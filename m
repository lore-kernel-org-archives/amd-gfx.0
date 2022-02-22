Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60701C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Feb 2022 15:07:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CB29C10EA45;
	Tue, 22 Feb 2022 15:07:53 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2084.outbound.protection.outlook.com [40.107.93.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4B18C10EA46
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Feb 2022 15:07:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iCkQ3qWao1G9zV6IWuOceLcqqWkXxWcaiEdx8gDBOTH393N8JJE8DmP+vkMC/bRX1Fxav9usee+WIPT2OHK8HBYQLznpmNYrIzYGtmA6EtAOhdxIve0AT+g3iDgDTN03eTPd0bjYgI+47TGgTw2T5DCFkYkXk8TfVCY50SJY6XtbOAbuBnpl+lsm9wDzGG2PYlHi1lALRVcYIbv4vnnK7ygCw1paiM67gtpVLirnZ2ubzgBONTv/+Pchy2IFelCEmTV+R4IU0qNSOCVUYx1/q8TPIvDdRaCq49R5buZzQ9M/ZFD4dk0opj0ZcWf1jSwOQjVmI/MHqkVDiyhtt2VccQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7A/cvENbxLC7JpGd/qIjLzjOchIdNi1wHZOsq4/VSIY=;
 b=XojfqDX/ZYQr7QrQUtWQomQ0TNLp9ver0CFvDrIgQ8iHiQ0juL0JPSbAHAP/YRfOBGf2Aa9fxLpu5OJDv/MP2w7tU60XdtYaOEdHYgMnTi0TZEb96+teEuEMyUrlJtzsxME6219mvK5QuLuoQHgO5SNIoQ4T2xMr7a5B2NqXpQ1dheXIfF72Zk+NOf31lvz1PrGWA9J9EYNLmouOJFApPSgpRFba4bCXpHQ+sEEeCgBg3U0ywn7j+7RMNJV1rryBafRrOZDx2BZiaEaCeSl6Rwec0p265hf8STaJm+o9/rxFaSseiAtD8fsJ+w5S2CZHePKbeKxFszlw38ZNLao1rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7A/cvENbxLC7JpGd/qIjLzjOchIdNi1wHZOsq4/VSIY=;
 b=rRioCBFx1nT3TXBwsgtbQFBDPz3WGYGVtSYcBXb0RYjYDcbVfenwqWLfK7esVY7FWjqp4c6gXVZ5DEhq9krZwUGyCELA/FXuPLHoRsWSXzijt8BpRwoAf51w6A5Es/ArJQuvAU4fchppbW63M7FxmwvLtVeCg91kFyT1jK/b1xk=
Received: from DS7PR03CA0023.namprd03.prod.outlook.com (2603:10b6:5:3b8::28)
 by DM5PR1201MB2523.namprd12.prod.outlook.com (2603:10b6:3:e8::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.21; Tue, 22 Feb
 2022 15:07:50 +0000
Received: from DM6NAM11FT005.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b8:cafe::f8) by DS7PR03CA0023.outlook.office365.com
 (2603:10b6:5:3b8::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.17 via Frontend
 Transport; Tue, 22 Feb 2022 15:07:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT005.mail.protection.outlook.com (10.13.172.238) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4995.15 via Frontend Transport; Tue, 22 Feb 2022 15:07:50 +0000
Received: from guchchen-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Tue, 22 Feb 2022 09:07:47 -0600
From: Guchun Chen <guchun.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <alexander.deucher@amd.com>,
 <hawking.zhang@amd.com>, <christian.koenig@amd.com>, <xinhui.pan@amd.com>
Subject: [PATCH] drm/amdgpu: limit harvest bit read on several ASICs
Date: Tue, 22 Feb 2022 23:07:31 +0800
Message-ID: <20220222150731.16954-1-guchun.chen@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2fe91693-fd55-4278-3835-08d9f61517c2
X-MS-TrafficTypeDiagnostic: DM5PR1201MB2523:EE_
X-Microsoft-Antispam-PRVS: <DM5PR1201MB25231B886890AFA20876A0CCF13B9@DM5PR1201MB2523.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bNyDhRPJVEOajhCUTl/TqRWS6P54V5m1GMVeVlQqBq57K3Xfp5705wAo/nghoHFLFiwAN7tjlDgEbDhY1z08hvSZ2kH9gS4eJWcEgsDFTwnsxBQrdlNzuSjEHsQlyh8YDNHuPTyVKwk6g2ZWqyMFGA0Yem1B3nY8awUY0X30kRsFZsrQjsEobeUo9p8d28anKhyJ6o5/ya4tDAMP4B2NQieLdHgHoPCZjpsihQGccpgFl2RWjnWIXQEUCmmRniWrzx+Di9fH5q5hp0fsWOL2yX4yaFIVmvIvLgSQJphwCSBynQyNyoU8WQH+4HwJWPHWJnALiPtuDRe0/awDsU972WuMm4fPN8k8sMpA459EJ+4Lh7wCm5xOZ21FFybJtVb03nVVGLE0gsXnk1v8MTP2RW8XgmuSLJfmWm/DZgyEYrP6Amh/n87LqborQIwrVe+YQkMGIrQEIhsa4OLZvjAPFqSq1Eg4t2OpYE62XcS5HD0WRsydY4DMAAS7t6t54T3lWs/jSnSF+YIgd7a+avuhqu9ZJi25btBpyNJJBvErrMfrXFkLgOOEeaMiaf6zkwiQyz02qjbGRkEqiS5KMqK/Ew4TYetv7Mn2xbTyhzdPNT3hhlp0tSFDG2Skpd6HHcwa1Iv1KA+Bdbq8UJ1+V8I72VM2BRGJvFZFCXAVqq1ebL/PvQxU1trl3pAKhVqseUAiDeoy6HIyMwFDsyPNkCL7WqtUU0+gMp9l4BQDUoYJat4=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(86362001)(70586007)(6636002)(26005)(40460700003)(16526019)(2906002)(1076003)(336012)(186003)(426003)(81166007)(508600001)(70206006)(110136005)(356005)(36756003)(316002)(47076005)(36860700001)(82310400004)(7696005)(4326008)(83380400001)(8676002)(5660300002)(8936002)(2616005)(6666004)(44832011)(36900700001)(2101003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2022 15:07:50.1892 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fe91693-fd55-4278-3835-08d9f61517c2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT005.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB2523
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
Cc: Guchun Chen <guchun.chen@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Due to faulty VBIOS out there, harvest bit setting is not
consistently correct especially for display IP. So far,
it's hard to work out a solution on all the legacy Navi1x
ASICs in a short time, so to avoid regression, limit harvest
bit read on several ASICs. Will revisit later once VBIOS has
corrected it in long term.

Fixes: b3f4ea887d5f("drm/amdgpu: read harvest bit per IP data on legacy GPUs")
Signed-off-by: Guchun Chen <guchun.chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 11255290f117..2e0ff1ace6fc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -1129,12 +1129,20 @@ void amdgpu_discovery_harvest_ip(struct amdgpu_device *adev)
 	 * so read harvest bit per IP data structure to set
 	 * harvest configuration.
 	 */
-	if (adev->ip_versions[GC_HWIP][0] < IP_VERSION(10, 2, 0))
-		amdgpu_discovery_read_harvest_bit_per_ip(adev,
-							&vcn_harvest_count);
-	else
+	if (adev->ip_versions[GC_HWIP][0] < IP_VERSION(10, 2, 0)) {
+		if ((adev->pdev->device == 0x731E &&
+			(adev->pdev->revision == 0xC6 ||
+			 adev->pdev->revision == 0xC7)) ||
+			(adev->pdev->device == 0x7340 &&
+			 adev->pdev->revision == 0xC9) ||
+			(adev->pdev->device == 0x7360 &&
+			 adev->pdev->revision == 0xC7))
+			amdgpu_discovery_read_harvest_bit_per_ip(adev,
+				&vcn_harvest_count);
+	} else {
 		amdgpu_disocvery_read_from_harvest_table(adev,
-							&vcn_harvest_count);
+			&vcn_harvest_count);
+	}
 
 	amdgpu_discovery_harvest_config_quirk(adev);
 
-- 
2.17.1

