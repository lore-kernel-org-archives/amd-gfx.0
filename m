Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63E3CC47258
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Jan 2024 22:51:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0619810E3BD;
	Mon, 15 Jan 2024 22:51:42 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2057.outbound.protection.outlook.com [40.107.100.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A5E010E3B4
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Jan 2024 22:51:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c5ZdGIfFFwrPDhUXigHXWZmTIzlVQJLVlekO7Ev8TcejMj69EphxImjnzPIYOY1LidcgbE1XSfB4yqEA8GqAcmxJpTkCwB7IXJpzKNrPmgabumwgcbXTW3erubl1fJF/TPlvR6PpEbqqMU7bcQtCN6WsWR/hglqaLd1GpjY4S/fByNEsb1z6AyHXm2UPh7z+uPLO41LNFvRFXT0iZ1DUqLl0GQIY3cmPz7BFL+50u6HbsnlTDOjRxflr/Nw9is2+vaApzGIOSEBNS3JsiwTScJkAQLXSkmliF/cyAfV6Jc1bSaC+ZxqaCYPlexYrgR7CD5lftMoMbkIYfWHoLxVkMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FcqpAn+uOXvtWQlQusrzm8APkjFvwJvC7V6An3IFc7I=;
 b=f8IQUDfFT9kImIPx4Uyg/IwQ3Y9jZHlYkcbrvZNaSONChVw63t0TTHMQYIW1zesRWcRooUP1eleTO3rV+qaxmXHWeyUEqb2xRvMAEOvFQ/7qkihMvQKXXwXeq9fI47rZ2L95iWnUd+56eC3tmkhOuASEZt9fWzEwrZTDRcGT5nLfco6ZjV5ajuYDeNuo8cH/Fwhk65XNpsLTZoX3RbD7inAVbzAemtXsFcUizV4VnGX+049wl17D6QFRs8SuIxlQ15m5PgHUqQ65vHZSBVlvSgmDeyMX+rv8V2oA5bI+xt9Dd2rA16fAwgBBtdfpQAhLhPijaWa1cTxKkUJAGfuVbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FcqpAn+uOXvtWQlQusrzm8APkjFvwJvC7V6An3IFc7I=;
 b=suhgNn/+nCsSfjofPRM1mpetw+bzVqIKkflEFmwGfJApIdrhf0hkZAt6+Na5lZGcUVD70VW+hN0y38B85F59eW2KQT7oBiFRYplqOWie71ZzeYwyyvIe6qn1y+emE3G1DtHeJH/3RyucvefaUjDhdL20rLprnaxz/AjKRUHvTKE=
Received: from SA9PR13CA0175.namprd13.prod.outlook.com (2603:10b6:806:28::30)
 by CH2PR12MB4232.namprd12.prod.outlook.com (2603:10b6:610:a4::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.23; Mon, 15 Jan
 2024 22:51:24 +0000
Received: from SN1PEPF0002BA50.namprd03.prod.outlook.com
 (2603:10b6:806:28:cafe::b3) by SA9PR13CA0175.outlook.office365.com
 (2603:10b6:806:28::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.19 via Frontend
 Transport; Mon, 15 Jan 2024 22:51:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002BA50.mail.protection.outlook.com (10.167.242.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.16 via Frontend Transport; Mon, 15 Jan 2024 22:51:24 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 15 Jan
 2024 16:51:22 -0600
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v4 5/7] drm/amdkfd: Change range granularity update bitmap_map
Date: Mon, 15 Jan 2024 17:49:48 -0500
Message-ID: <20240115224950.3300-5-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20240115224950.3300-1-Philip.Yang@amd.com>
References: <20240115224950.3300-1-Philip.Yang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA50:EE_|CH2PR12MB4232:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d10ad69-7c3e-4de6-2a6c-08dc161c8036
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xCWQnatuagN3lxXAR+IpJmjG5NRu9cqmSvakqpAPT1Ge+7rTyN5+S0j91PUTd0qHrPvaKc6rE7foLquoMDfVBFC6DzDrwLlrnKv/x0dCIwoboAxG8CKdnvY3keR9mc8vqX2IGIfVCk1jNKZ29kvOFA41pioiHRaa9FWRYx922la1nbJMJwPpYKfA5K2KVcUob4asRt2muIw55bP1UHGbPbu0Aqg3M8+V76NjohzFUfPuZb/ymY5qAbR4IMmDkttFNr0ZdWRRJqGDpjyOLOZ1XY8+B6yvLC8npMF6QWAz00viQj8VlqqLqnBp5/YtkVIRBLCcSWjj9IbTNDzLzmD0M5USNhl3V5iqoTA9yZNoYnC3U5ZGMR9JVAmTmuuqOuRoDW/ShWeiyfuOoFXbApFvDEjS3dZhlS1zcvUeHU1DXCXDnybYnVh46Phq+oxw7ZBXWw99HPfjzYZsiAVIKnjb6E9PCDbwjb80X/4HjbVvveeNzrrolUwA2IjuHq3eDtC1LKkVqtJ9+VwqfJ3xRYQQ5iJabJDPrbPG/wJaa7GiDMV/Q+LKBd4RVgSYTX2YafIY+36yEnLCYIgASAvSxqpmtqYshPrL4/CF+87UAnqf01+uJ1mSdVlibWlZBmgvrtbz7uDGfoA1tg86uiUm5rM6jfLrg/Z/Zj55DKXZePz2eGiei3V8FnQVElnYm/LbRikzK2/CBHBCRGWT29XcwAsRw2iEthfo8VlbykU8kkhWlC5zmQvZh5J8O/DJ0Ue1sq58XSKcT1F3JDHQ9hTf6KpOCA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(136003)(39860400002)(346002)(396003)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(82310400011)(40470700004)(36840700001)(46966006)(41300700001)(82740400003)(47076005)(83380400001)(36860700001)(36756003)(86362001)(356005)(81166007)(70206006)(70586007)(316002)(54906003)(6916009)(8936002)(2906002)(8676002)(4326008)(5660300002)(15650500001)(2616005)(1076003)(16526019)(426003)(336012)(26005)(478600001)(6666004)(7696005)(40480700001)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2024 22:51:24.5227 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d10ad69-7c3e-4de6-2a6c-08dc161c8036
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA50.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4232
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Cc: Philip Yang <Philip.Yang@amd.com>, Felix.Kuehling@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

When changing the svm range granularity, update the svm range
bitmap_map based on new range granularity.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 49 +++++++++++++++++++++++++++-
 1 file changed, 48 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 7a30c3e58234..ebc4cce801bf 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -757,6 +757,53 @@ svm_range_check_attr(struct kfd_process *p,
 	return 0;
 }
 
+static void
+svm_range_change_granularity(struct svm_range *prange, u8 value)
+{
+	struct kfd_process *p = container_of(prange->svms, struct kfd_process, svms);
+	u32 new_nbits, old_nbits, i, n;
+	unsigned long *new_bits, *old_bits;
+	u32 gpuidx;
+
+	if (prange->granularity == value)
+		return;
+
+	old_nbits = svm_range_map_nbits(prange->start, prange->last, prange->granularity);
+	new_nbits = svm_range_map_nbits(prange->start, prange->last, value);
+	if (new_nbits > old_nbits) {
+		n = new_nbits / old_nbits;
+		if (new_nbits % old_nbits)
+			n++;
+	} else {
+		n = old_nbits / new_nbits;
+		if (old_nbits % new_nbits)
+			n++;
+	}
+
+	pr_debug("prange 0x%p [0x%lx 0x%lx] bitmap_map nbits %d -> %d\n",
+		 prange, prange->start, prange->last, old_nbits, new_nbits);
+
+	for_each_set_bit(gpuidx, p->svms.bitmap_supported, p->n_pdds) {
+		old_bits = prange->bitmap_map[gpuidx];
+		if (bitmap_empty(old_bits, old_nbits))
+			continue;
+
+		new_bits = bitmap_zalloc(new_nbits, GFP_KERNEL);
+		if (!new_bits)
+			return;
+
+		for_each_set_bit(i, old_bits, old_nbits) {
+			if (new_nbits > old_nbits)
+				bitmap_set(new_bits, i * n, n);
+			else
+				bitmap_set(new_bits, i / n, 1);
+		}
+		prange->bitmap_map[gpuidx] = new_bits;
+		bitmap_free(old_bits);
+	}
+	prange->granularity = value;
+}
+
 static void
 svm_range_apply_attrs(struct kfd_process *p, struct svm_range *prange,
 		      uint32_t nattr, struct kfd_ioctl_svm_attribute *attrs,
@@ -801,7 +848,7 @@ svm_range_apply_attrs(struct kfd_process *p, struct svm_range *prange,
 			prange->flags &= ~attrs[i].value;
 			break;
 		case KFD_IOCTL_SVM_ATTR_GRANULARITY:
-			prange->granularity = min_t(uint32_t, attrs[i].value, 0x3F);
+			svm_range_change_granularity(prange, min_t(u32, attrs[i].value, 0x3F));
 			break;
 		default:
 			WARN_ONCE(1, "svm_range_check_attrs wasn't called?");
-- 
2.35.1

