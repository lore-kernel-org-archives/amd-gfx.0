Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AF2BCD8C9C
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Oct 2023 14:41:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8ED1110E38E;
	Tue, 10 Oct 2023 14:41:58 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2042.outbound.protection.outlook.com [40.107.94.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2388410E38B
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Oct 2023 14:41:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LX5ytcYD3B6yhSTDMm4J7UB80grGWtOCWam9cxpqXsiOeroQUSVDcwPzuRu4GTLSYxx5TAxy2t9PCLSr284U6hSCp6X1oba3ICwyERZ3P54PzcSs46hsI8c7oyN81bgRmIJUM5EE3DS0JNy9Ofg5NOVFe4f5k4WFbgHGuZj2UNlb42WV2imWbqpTHm7TWk2mUJuYUNYUi3fFgSG4rGxXNeMXoZ1ESCsRoSyCAPS+cLAWBagFVyOob4y+7T1bVXkCk86hss20NsHwyTqIFim/jfuSmcxq+T1/9cacMf+gltbTIWuPOQFHsHOGUNuCiUU0UjDJSEE27rzBAkqa4tuSlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ktn66/S+d2Z52VQRvVag6zdI+BmVhJY0yxZhRbj85KI=;
 b=O4M2vf+2Z8AvTL5CR4z3Afqve9xhHLkv6RlZngna6yjpoSVwY3ht4V6Du7FxsHD02/fnu5e1jHTUb8OJJCXBupUZpjYdD2M3jQGpUZ3ZkZCepjAjlWRmZSLQGEZ6EqiFg0EyoY1OB0bQ1SJLPm4ZsOJok2ByULI5RutyzVzsJG9Zm8KA4wQK2f3WAYQG8Ad+g+X1WKZMs/46zrCZaC93WNAjJPkFz2EAL1O6EuHIjRjLW8LXHhCCpKPyeqqgShEXvh1Fga+R6An1FZcf2uKg27my2H3cm93ZPPIW5niizYLj3cRpULc4xTMkGAbdJVcwEywomJynJFLPBOhQdc+pGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ktn66/S+d2Z52VQRvVag6zdI+BmVhJY0yxZhRbj85KI=;
 b=Z4Bvvs2HOj2J18FzAbc0HqrXY0mv/hXJJZGQRvqDAxpLjh6XjgmGs7IspcpJOpSalUeyx+7Th5ckx40QKbCqc/xUVe9jO8eOVmgGX8u5EPn83neZChiQR4X2sd6U5KH8luqWZX4j5BXC5JZjW9RUSXlm+Iq7ptuXy5SFk2Eh6/E=
Received: from MW4P222CA0024.NAMP222.PROD.OUTLOOK.COM (2603:10b6:303:114::29)
 by SN7PR12MB8604.namprd12.prod.outlook.com (2603:10b6:806:273::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Tue, 10 Oct
 2023 14:41:51 +0000
Received: from CO1PEPF000044F1.namprd05.prod.outlook.com
 (2603:10b6:303:114:cafe::3d) by MW4P222CA0024.outlook.office365.com
 (2603:10b6:303:114::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.36 via Frontend
 Transport; Tue, 10 Oct 2023 14:41:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F1.mail.protection.outlook.com (10.167.241.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Tue, 10 Oct 2023 14:41:51 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 10 Oct
 2023 09:41:49 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 7/7] drm/amdkfd: Changing range granularity update
 bitmap_mapped
Date: Tue, 10 Oct 2023 10:40:24 -0400
Message-ID: <20231010144024.3016-7-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20231010144024.3016-1-Philip.Yang@amd.com>
References: <20231010144024.3016-1-Philip.Yang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F1:EE_|SN7PR12MB8604:EE_
X-MS-Office365-Filtering-Correlation-Id: dac80c0e-632d-4a54-7eae-08dbc99f0a6a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ifWhDNXRxPSCh3dh0VmdT3NAAshdKcnH+edJHfAQ4x5RhP+ueTTQ9TTv8gBmxYEXAOz4w/wzIEe3Ktvoknls6gBmMkoSK2VAfkCcLmmwc9QmDEGRXj91sl34kNd/h+EawAlX4yuJPst1u1FJtaAmSGnHgWdWZ9/3N/qkNj/2ttr9U2cxDGNBPVKs0bDeEUVbUiKBOuFYeIr5nBD9kr994IkU/6ZXRS4vYtPYl8gTQl+dEk/Sz5HYiA7xkiVlvGsBeJwsFHPA52n4QiCkHiF5ViSmOg9S4s6En9U0FG0Zjr3qy/X0yOmL50bsfhv3elz69dcZFjKIuKeR3hRvWz8MpdpNEh/wSOyKYz4SSVNEAPSzuNVBMcdT0HvGF5ogYvwb0j1Jv/BJgFDpeQqVkXMEE2+/skPPlkf/WLizhbtxd6jBzewDSfENC9qr71N1pN49E2FYGCbN3wxO+3YALfFnfI6/blJr0go4wvQ6fhk2bOTI0fNpCMvK60ogieA6+WOLqwiejLSw2VUlNl70wmOW4xYh0ZqW6nBeeidL7SFISYHaqGOBuzcPMIcjk67+Fhf2qPATvIvSmny4cd/qUHNqjn62Ahd5uagmDLR5ItNwrySinEXSJvECBk0B8xLZWvDdfz+aqCNnrRhFgsKkSL4zYSPsut0LQWm832VvKOfD1qBCBHMQIt6mCRhaVj4KRQQVfOTaxSHd1LRm6ruYjpUO/meCpaeglX/5ipKsbkGI4gvjxFx6/GJe/OdPBzeN+PfEvOdj2uuPorOpZ3BJhw0TTQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(136003)(396003)(39860400002)(346002)(230922051799003)(451199024)(186009)(64100799003)(82310400011)(1800799009)(46966006)(36840700001)(40470700004)(2616005)(1076003)(40460700003)(40480700001)(82740400003)(36756003)(356005)(81166007)(86362001)(36860700001)(16526019)(26005)(47076005)(336012)(426003)(2906002)(83380400001)(15650500001)(7696005)(6666004)(478600001)(5660300002)(4326008)(8936002)(41300700001)(70206006)(70586007)(54906003)(8676002)(316002)(6916009)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2023 14:41:51.3385 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dac80c0e-632d-4a54-7eae-08dbc99f0a6a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8604
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
bitmap_mapped accordingly.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 49 +++++++++++++++++++++++++++-
 1 file changed, 48 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index e1392b277399..55b806048925 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -739,6 +739,53 @@ svm_range_check_attr(struct kfd_process *p,
 	return 0;
 }
 
+static void
+svm_range_change_granularity(struct svm_range *prange, uint8_t value)
+{
+	struct kfd_process *p = container_of(prange->svms, struct kfd_process, svms);
+	unsigned int nbits_new, nbits_old, i, n;
+	unsigned long *bits_new, *bits_old;
+	int gpuidx;
+
+	if (prange->granularity == value)
+		return;
+
+	nbits_old = svm_range_mapped_nbits(prange->start, prange->last, prange->granularity);
+	nbits_new = svm_range_mapped_nbits(prange->start, prange->last, value);
+	if (nbits_new > nbits_old) {
+		n = nbits_new / nbits_old;
+		if (nbits_new % nbits_old)
+			n++;
+	} else {
+		n = nbits_old / nbits_new;
+		if (nbits_old % nbits_new)
+			n++;
+	}
+
+	pr_debug("prange 0x%p [0x%lx 0x%lx] bitmap_mapped nbits %d -> %d\n",
+		 prange, prange->start, prange->last, nbits_old, nbits_new);
+
+	for_each_set_bit(gpuidx, p->svms.bitmap_supported, p->n_pdds) {
+		bits_old = prange->bitmap_mapped[gpuidx];
+		if (bitmap_empty(bits_old, nbits_old))
+			continue;
+
+		bits_new = bitmap_zalloc(nbits_new, GFP_KERNEL);
+		if (!bits_new)
+			return;
+
+		for_each_set_bit(i, bits_old, nbits_old) {
+			if (nbits_new > nbits_old)
+				bitmap_set(bits_new, i * n, n);
+			else
+				bitmap_set(bits_new, i / n, 1);
+		}
+		bitmap_free(bits_old);
+		prange->bitmap_mapped[gpuidx] = bits_new;
+	}
+	prange->granularity = value;
+}
+
 static void
 svm_range_apply_attrs(struct kfd_process *p, struct svm_range *prange,
 		      uint32_t nattr, struct kfd_ioctl_svm_attribute *attrs,
@@ -783,7 +830,7 @@ svm_range_apply_attrs(struct kfd_process *p, struct svm_range *prange,
 			prange->flags &= ~attrs[i].value;
 			break;
 		case KFD_IOCTL_SVM_ATTR_GRANULARITY:
-			prange->granularity = attrs[i].value;
+			svm_range_change_granularity(prange, attrs[i].value);
 			break;
 		default:
 			WARN_ONCE(1, "svm_range_check_attrs wasn't called?");
-- 
2.35.1

