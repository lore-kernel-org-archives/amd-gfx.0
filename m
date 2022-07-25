Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DE8EC433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Jul 2022 17:20:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A0B46C11E8;
	Mon, 25 Jul 2022 17:20:28 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2067.outbound.protection.outlook.com [40.107.220.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A402C11E7
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Jul 2022 17:20:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M86m/ZLeYGxDCMGjZS4xXWReWUc+3PmIf07T8SKYFrkq9+Udr6y8WzFH+pvVus3nTcJJkGjK1HDg/SvsgvTzgd0YWUDn18Cj1LQA/5lr0fp4grG4D6USFZnYfdt7Q9Vr0irEl03mUYD/GHEjWg3BWRRQ4A/na+4UrQ/MRuhUNCSS59Lc0ThDZknJCz4u9Lru9Vjx5XYO+XREC/JKWX7g+TV+f+HVX9Kdzwib3EeonjrhznCYJBt7WyWxKoCpU/LgEgMilQnF5tCaNnAWUi/pd1B2au3/JINfHvMM2NnscMF9yhhtDFalp7SYld4c57sz5xNwhmZMD28L9YhDLpH2+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3kg0XKtiYs3fBmO0RHC40oO1Pej2TH3rnrp98/hXUCE=;
 b=nirWklkXvg0YhO5Gh1maShn7/TfRdvNDQN4bVO5DUH+h8855R7bBc6+XNLuk1XEggmNtUFmdZf6d8BOx4TaQoQMQ3OekX20Ym/a4bEMCaJvhs59aScj29PFOuG8kC3VvWxDFvJF8Bv7Lxb5ktRP3aHViTCAN3dRUjSNk7kUxuETMQOKdV2D2esDpgXbbtBMbfMZbW9a6MwlsIGpgHk/rFNIETDcq2mBlCr0/KNNUL6SBol8wHdLmy59m1ZTS9W3/idFuKg34PWQyle2d+x5PvPl2VN7rMMDVxoBbKfah6wyFCWU+P1HTqAJ6qHBVqTW+weCmcTIZcjgxF44yN1nIKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3kg0XKtiYs3fBmO0RHC40oO1Pej2TH3rnrp98/hXUCE=;
 b=n8g9WwnO1z2qK6gZYlCsE3R4hVg1yQWHj7rsQrgfBVuw47oh6m3SpQxvUV4aUgO4kBAKPNtGbqRp/EDsld3ll9f0HbvOu1GH4vtnthetlx6wzrT4hNS+3v1XEEYyhhXdbmHt84IDXWnGiNXKpjyeYjocbBsWQ2DGrdzoMSWqFjE=
Received: from DM6PR13CA0038.namprd13.prod.outlook.com (2603:10b6:5:134::15)
 by BL1PR12MB5994.namprd12.prod.outlook.com (2603:10b6:208:39a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.22; Mon, 25 Jul
 2022 17:20:24 +0000
Received: from DM6NAM11FT037.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:134:cafe::33) by DM6PR13CA0038.outlook.office365.com
 (2603:10b6:5:134::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.11 via Frontend
 Transport; Mon, 25 Jul 2022 17:20:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT037.mail.protection.outlook.com (10.13.172.122) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5458.17 via Frontend Transport; Mon, 25 Jul 2022 17:20:23 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 25 Jul
 2022 12:20:19 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 3/3] drm/amdkfd: Split giant svm range
Date: Mon, 25 Jul 2022 13:19:43 -0400
Message-ID: <20220725171943.9155-3-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220725171943.9155-1-Philip.Yang@amd.com>
References: <20220725171943.9155-1-Philip.Yang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9fd25e6d-6196-4a52-a587-08da6e61f5c8
X-MS-TrafficTypeDiagnostic: BL1PR12MB5994:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: c210DmIKZFtpEo44fidm+l2p0GXdmqLXra1+YjpCL6esDGLFonQtSrUos83/DEqJqocVYco5pPhssmIVDF+YjQBIQJyq1bNPrh6fenFUoQVXxLOGaIui8nqrf6pm6e7JgZXG6LihBMqu0HcAm4LStYG8vaaTwywVpZq07jGep8CVLVabp1yh3BbRY5ge1jPw3aG1PCPwRaAOA4AnLIL7uQ2m/ZPn5ZGXtwolPUA7z6H1cUVmYxQm2zBPMy/cpCrbHbt2pGxOUIrjYXhTafkOTtGwZCS7VTie6Kw88cXDDsUdEEh5Bq4AWHuqNmG3Y/d9sLUQGdoHVIAldOArbhN28Xr501fp9SFvlSyPgKmuYV9uduCoT4CM2bu2K/W9b3bsxETdOMLHG/R9O9326p9QtsdROpjE8HNNuCfy6DjjxmrU91D4q+FY3fmlGWmLpik0UcV7HrJn6fiElRIHfWKZMwb/QF/auVUlSKw8M6p3a/nN3MhmStL6AgFzEPzErpWU2vKE0hVMmBos2C/Ljpn74NzAwLNS82EpUx9uVk1aUwJ8mpGsojOJepaOV1/ZAv5H+0WEcXMGKR9WbSR70mqWrnTZ5oERIaiONUx+EOFPpZwfsUbLavlEQnQ1Nv1ky+XTRv7zb3HLb8oZjx/pKxDipb1wL7ocv3kXQ7JqxNh1ZwPIUtCpFIJjBo/9+wp3nm09SitxdnEHKPFT4eJHPZImIsIOHvVYB9FyWvBQB8VoIPTHPCd69mnVwvdRJdAszC1FlsW7s1AR12b5Cb7ps2kP/frD9lteWWrDl1kA+VxDYu+6ISJxQTypB1rSWEh6tE9OEcwvTqDWXuS74kvrz4wpXA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(136003)(376002)(39860400002)(346002)(396003)(46966006)(36840700001)(40470700004)(8676002)(54906003)(40480700001)(6666004)(316002)(41300700001)(1076003)(6916009)(7696005)(478600001)(82310400005)(40460700003)(4326008)(186003)(70586007)(70206006)(5660300002)(2906002)(16526019)(36756003)(8936002)(26005)(356005)(2616005)(47076005)(336012)(426003)(82740400003)(36860700001)(86362001)(83380400001)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2022 17:20:23.9703 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fd25e6d-6196-4a52-a587-08da6e61f5c8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT037.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5994
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
Cc: Philip Yang <Philip.Yang@amd.com>, felix.kuehling@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Giant svm range split to smaller ranges, align the range start address
to max svm range pages to improve MMU TLB usage.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 49 +++++++++++++++++++---------
 1 file changed, 33 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 098060147de6..6529a40fb508 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1889,6 +1889,31 @@ void svm_range_set_max_pages(struct amdgpu_device *adev)
 	WRITE_ONCE(max_svm_range_pages, max_pages);
 }
 
+static int
+svm_range_split_new(struct svm_range_list *svms, uint64_t start, uint64_t last,
+		    uint64_t max_pages, struct list_head *insert_list,
+		    struct list_head *update_list)
+{
+	struct svm_range *prange;
+	uint64_t l;
+
+	pr_debug("max_svm_range_pages 0x%llx adding [0x%llx 0x%llx]\n",
+		 max_pages, start, last);
+
+	while (last >= start) {
+		l = min(last, ALIGN_DOWN(start + max_pages, max_pages) - 1);
+
+		prange = svm_range_new(svms, start, l);
+		if (!prange)
+			return -ENOMEM;
+		list_add(&prange->list, insert_list);
+		list_add(&prange->update_list, update_list);
+
+		start = l + 1;
+	}
+	return 0;
+}
+
 /**
  * svm_range_add - add svm range and handle overlap
  * @p: the range add to this process svms
@@ -1991,14 +2016,11 @@ svm_range_add(struct kfd_process *p, uint64_t start, uint64_t size,
 
 		/* insert a new node if needed */
 		if (node->start > start) {
-			prange = svm_range_new(svms, start, node->start - 1);
-			if (!prange) {
-				r = -ENOMEM;
+			r = svm_range_split_new(svms, start, node->start - 1,
+						READ_ONCE(max_svm_range_pages),
+						insert_list, update_list);
+			if (r)
 				goto out;
-			}
-
-			list_add(&prange->list, insert_list);
-			list_add(&prange->update_list, update_list);
 		}
 
 		node = next;
@@ -2006,15 +2028,10 @@ svm_range_add(struct kfd_process *p, uint64_t start, uint64_t size,
 	}
 
 	/* add a final range at the end if needed */
-	if (start <= last) {
-		prange = svm_range_new(svms, start, last);
-		if (!prange) {
-			r = -ENOMEM;
-			goto out;
-		}
-		list_add(&prange->list, insert_list);
-		list_add(&prange->update_list, update_list);
-	}
+	if (start <= last)
+		r = svm_range_split_new(svms, start, last,
+					READ_ONCE(max_svm_range_pages),
+					insert_list, update_list);
 
 out:
 	if (r)
-- 
2.35.1

