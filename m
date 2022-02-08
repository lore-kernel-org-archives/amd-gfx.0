Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3670C433F5
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Feb 2022 03:20:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1990210E259;
	Tue,  8 Feb 2022 03:20:48 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2081.outbound.protection.outlook.com [40.107.244.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D8B7410E259
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Feb 2022 03:20:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EWaUJC0b9JTbU+rFIrg/AIbldHoDzg4AUH5UTodW9n5S8hmhQ8fWuE3/hcY1CilllzfbpRroWUNXacsKeqRyV3fDlAHy1f0WvZyins5ibYLqeLiFTJ/jhw+3Sr4vUBrX5aK/EsOK1vHloivHtuBVlSRPCEx77Pk1RSy59C6vhh+gn6+d2pt+1MyKi/MkuVqmZV5nb0v+wlF/zHOn1PLrU/9vBv7RTrs7G9020oMd1p4wluo6rx9lYV0TfvMYeY2ydDmeQCTS2CLtRxIblCtsUWeWYJz/gOslb2ndDwNbOuKkbsmTXUYhmY/TXODwRk2ndzEHCEHxXEdiPgsDuVfoxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Zai0PfVcS/ADEz73CW31jz9BtYfxLLpAGfB+w3I+Us=;
 b=QsVWx2D7yNFPBUWVp03+Fu6cOvlrgCQVyEf4MsR9rk++UJAcqt80jRIS0TyWMxy3oxUOL5GnJJLw232xFazbGvnhYuqEOvmH4s7A9672LXgHSP8yETZzeSet6ktl2EmV4LlKxpKpSTggSwQ57LIFrpHZfaMhX6n4UB3db6bEbgLHWr/rexx47KqyrY7YbSmM4rAl4DzcNRzmERi5xkKX2FUgEIERLm1C/Dkc/0HVec6ncu87uBfwxqufRQkMmisaOSnWdEuRA+LQ2IZxy+Mwv33wHdgU9U0rwXQnQXvqM/Ef7cZ2GnPYCjYJtP4KabFNS6gBdVUA6ChURGXlYBPhSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Zai0PfVcS/ADEz73CW31jz9BtYfxLLpAGfB+w3I+Us=;
 b=1HS9mhJWVAC+l+GvvFHqsHNSYQ8bNOhrWm6XbGOuHW8nra0JPh9hRjPISfa2fjyQWb++dwsVESJrjDzGDjWkm9Zqh1dlVw5vAiru39qTf53PhpPcX0OKIMusXyVotE7jeljUsQlVzqAT+CSxsB96HB66alkvL8/uCUyVUntnR3A=
Received: from DM6PR18CA0020.namprd18.prod.outlook.com (2603:10b6:5:15b::33)
 by BN8PR12MB2851.namprd12.prod.outlook.com (2603:10b6:408:9f::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Tue, 8 Feb
 2022 03:20:44 +0000
Received: from DM6NAM11FT022.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:15b:cafe::b6) by DM6PR18CA0020.outlook.office365.com
 (2603:10b6:5:15b::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.19 via Frontend
 Transport; Tue, 8 Feb 2022 03:20:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT022.mail.protection.outlook.com (10.13.172.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4951.12 via Frontend Transport; Tue, 8 Feb 2022 03:20:44 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Mon, 7 Feb
 2022 21:20:42 -0600
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 7/7] drm/amd/pm: fix some OEM SKU specific stability issues
Date: Tue, 8 Feb 2022 11:20:09 +0800
Message-ID: <20220208032009.763982-7-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20220208032009.763982-1-evan.quan@amd.com>
References: <20220208032009.763982-1-evan.quan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 622c8402-92a6-4a66-886c-08d9eab1fe53
X-MS-TrafficTypeDiagnostic: BN8PR12MB2851:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB2851ACC072FA78E5CBE37007E42D9@BN8PR12MB2851.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:546;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dfM0uvpxzHYaOxs9yx6llqlXy/Er7GMz4Xa3ea9nqNh2ECXyjvilYCvylbnY/ja2MXmCOMymFgbbKJOBaDbObzSXhoGBgVQfOYIXcI1yNW76SBvDDUmiqgNF/iFzX/l5iv4aOngZRPkS7rToMxeYfj4WNIqg9i8nFHVnad3HQxTQr/AWFqp0vBBtczuSlCBn+m+An81xc2W1wHhIL0nl5NAzqwRUHeIDLGuGEXF8QXABZIQpITEishBlOKelYsXHu+D8xIx/1AElDX0QmhIEOiVIWvwbZEWo6LwkpTo9kcb2wp94k22IEj4hjTUwHyvwzEmY9RoBFexcliUv7BKNB+NtxfzI/9fpmvEhiIYVBkuTwkd7+Jii0Y1CU2xD7Is3LdiZsTxRkEszqE7f77xwPD1ijEpWKM9Ip7mlsguQ8gf4skhpbwGqAPpXyLcBTM9fmOXnwrcA3gR4C73RZ9ZxstPiD0OMAqXEGX2/dWCzl9vgJFAt0upv4otgMe9Vn5oBq/Ie7qbIL4ZERzcOHpc9Esq1JNJedV0qnjZx5Vd8HmpOZLFLTPLfHPfAtvkEivjLt4uD32U7azbc5uNhncc6SOGgMHutPoukf36SQvwwGkDUeLrUoydp7n3sB/F4R1bkvZ1F7V+rV42uDDSz9mRufWPMCjUEPaOzdc/FcgbOi4DbvUuEtWryCcBsjpvO13AX/HYLXLBEHOaplEYzQU13dg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(5660300002)(81166007)(356005)(82310400004)(44832011)(6916009)(316002)(4326008)(70206006)(70586007)(8676002)(54906003)(86362001)(8936002)(7696005)(508600001)(40460700003)(83380400001)(336012)(26005)(2616005)(1076003)(426003)(16526019)(36756003)(186003)(6666004)(47076005)(2906002)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2022 03:20:44.5540 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 622c8402-92a6-4a66-886c-08d9eab1fe53
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT022.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB2851
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
Cc: Alexander.Deucher@amd.com, Evan Quan <evan.quan@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add a quirk in sienna_cichlid_ppt.c to fix some OEM SKU
specific stability issues.

Signed-off-by: Evan Quan <evan.quan@amd.com>
Change-Id: I172c6429c54253788dbf28f7acf877375f2bfc5b
---
 .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   | 32 ++++++++++++++++++-
 1 file changed, 31 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index a7bb5358d4a4..f964af05f376 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -428,6 +428,36 @@ static int sienna_cichlid_store_powerplay_table(struct smu_context *smu)
 	return 0;
 }
 
+static int sienna_cichlid_patch_pptable_quirk(struct smu_context *smu)
+{
+	struct amdgpu_device *adev = smu->adev;
+	uint32_t *board_reserved;
+	uint16_t *freq_table_gfx;
+	uint32_t i;
+
+	/* Fix some OEM SKU specific stability issues */
+	GET_PPTABLE_MEMBER(BoardReserved, &board_reserved);
+	if ((adev->pdev->device == 0x73DF) &&
+	    (adev->pdev->revision == 0XC3) &&
+	    (adev->pdev->subsystem_device == 0x16C2) &&
+	    (adev->pdev->subsystem_vendor == 0x1043))
+		board_reserved[0] = 1387;
+
+	GET_PPTABLE_MEMBER(FreqTableGfx, &freq_table_gfx);
+	if ((adev->pdev->device == 0x73DF) &&
+	    (adev->pdev->revision == 0XC3) &&
+	    ((adev->pdev->subsystem_device == 0x16C2) ||
+	    (adev->pdev->subsystem_device == 0x133C)) &&
+	    (adev->pdev->subsystem_vendor == 0x1043)) {
+		for (i = 0; i < NUM_GFXCLK_DPM_LEVELS; i++) {
+			if (freq_table_gfx[i] > 2500)
+				freq_table_gfx[i] = 2500;
+		}
+	}
+
+	return 0;
+}
+
 static int sienna_cichlid_setup_pptable(struct smu_context *smu)
 {
 	int ret = 0;
@@ -448,7 +478,7 @@ static int sienna_cichlid_setup_pptable(struct smu_context *smu)
 	if (ret)
 		return ret;
 
-	return ret;
+	return sienna_cichlid_patch_pptable_quirk(smu);
 }
 
 static int sienna_cichlid_tables_init(struct smu_context *smu)
-- 
2.29.0

