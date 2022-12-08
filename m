Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BB87C4332F
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Dec 2022 07:52:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 362B910E468;
	Thu,  8 Dec 2022 07:52:11 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2085.outbound.protection.outlook.com [40.107.223.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CDA0610E468
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Dec 2022 07:52:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kl9uVmG6oK/bCZl21QIg89eooxeE7edTicNKWZ8yY2XoCIhXHrTHdCbXGtqu6B+R1pB0rPlsLz1KnZr9Fab+h2RpKzRDSpjYV1ZY/J02aDGfUsOaPx5j4yrW77MtwDXD/CWRlTFB9xavjysh7IMsqNWM7DvkJxzCVeeB7E9T+u6Hr2RIZtU4EdiRjiDyzXb28wgkumKbvSuT+ItbENY78s1gS4vhK6Zsun2Pt7KrIh1NJ9bETHWJ2CD+XWhV7fFwf/HZ2+k76Qqadb3ubJBvufHNQQcS290L5/9HcdKu/5VHiAzUOa5izNsLO3ZZqzVMYHUH4XENiY7+oK01LepsQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0lbQd9T5DktqiPX6hBl3CDQRO9P7/0LFpjYbtKGXO3Q=;
 b=PcYhrCD9NgA18TEG9U02tsy81cqc+IZRgOoSNd72w58IfxFlPfM4wkYQyS2pOyno3GqJQXsWUETvIhLnaU6UEyGT0yhBCDF1wfQkOjpvCiVDHIfNInp4wiiRHwr8yWUbvXfQz8DpwydEAFauzqRZG+SjMmAE2KXx8oNGe215mxSsTXncJSYaGuPuC02e5o6Nt63A95bH5N+PBydLZlmR0JF7bQ3+MnG+l5Hv7+R8m7JoRN8PeO/zSfPes4q+xxH7P08P4Wo1jpza3r2KSZWl+P9ocvs/H2M11l0OitK22cF6JvUWkzmujzvjxY/fhIOH5Xz1h+Tc0S3hBRRWnuoulA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0lbQd9T5DktqiPX6hBl3CDQRO9P7/0LFpjYbtKGXO3Q=;
 b=aVzgOAHaxntjlCYXOdBJ2Ni6jt7EMcF1nR8X3LkF1xruZpUYPmQxh5S5kpm6yZRh6KrsehEz3+4CQW4f58J/TBR2AOfT2p+xfl21RAFiDeqMg0pK3dTk4QT5ipienjPL3J38e98NviHzeV9TX/7W4R+Dua1hLaWR5EET56CiDq4=
Received: from MW4PR04CA0383.namprd04.prod.outlook.com (2603:10b6:303:81::28)
 by CH3PR12MB7547.namprd12.prod.outlook.com (2603:10b6:610:147::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.13; Thu, 8 Dec
 2022 07:51:59 +0000
Received: from CO1NAM11FT061.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:81:cafe::fc) by MW4PR04CA0383.outlook.office365.com
 (2603:10b6:303:81::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14 via Frontend
 Transport; Thu, 8 Dec 2022 07:51:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT061.mail.protection.outlook.com (10.13.175.200) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5901.15 via Frontend Transport; Thu, 8 Dec 2022 07:51:58 +0000
Received: from taozhou1u2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 8 Dec
 2022 01:51:56 -0600
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <hawking.zhang@amd.com>,
 <stanley.yang@amd.com>, <Gavin.Wan@amd.com>, <Vignesh.Chander@amd.com>,
 <david.yu@amd.com>
Subject: [PATCH 7/7] drm/amdgpu: define RAS poison mode query function
Date: Thu, 8 Dec 2022 15:51:22 +0800
Message-ID: <20221208075122.28702-7-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221208075122.28702-1-tao.zhou1@amd.com>
References: <20221208075122.28702-1-tao.zhou1@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT061:EE_|CH3PR12MB7547:EE_
X-MS-Office365-Filtering-Correlation-Id: d0aa4e47-269b-4305-fe60-08dad8f11599
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ed29vSDJ7UnGcBPmVVUM+A75yre/bMfZ0W/wegs9GRDGbVsuvTzSDL/aMtQaCBvGdFPg4A4m7qbTa+FBtuoKZAEVF2x6L5g+QmFNceUFh1DwJEhovDRNHnixC58JCckLgoHKcBS8aBazXe81RDPQRixDGawNZg8eZYqy99STUSCiTGDkFyV4mpYclx+3N4KbJmcIU4y3Lv6pdJ0KkJjQKxvJ3LCwIPB7Kdc9MpLy8aoeRc9pW6TmoMMj+8oiFDxRmYE3CIi2B4O6ZJjkihKfUkemaX6LUQu1Nl+55D3bXqnoztDLZgSCoIBm9oCuglJjf7bUeBSDgfXXkoWJ5vTrKfRBQrJMgvkhySFJhWxYg5vY+Ej5o81tGDqlfGrBV1DL05Rrb53AMhVLqY2lDhTyu+w6jPTUdgUJ/i5X7GqzMDqZ1Gm21Hz4G2nQU8eIP1fjkSRadGy8rQxuucv7oLxH8TnE4MHIGnNxgGkYfMWMGEajwNe2v5Ah1g5ZXJjDrBw4ON0HHrz27fnBU8vf/oxr6I55AoC9Sehz21W+npZ4kxXPcf0EMJ0+P4m6xsb1t8E6eAMpzeD7VTp0++rLvBoHpZapKeVWzC9Uhm5VdY7HFnkEqYg8ePpbGoKuif7wf4K4uXf+axKvtSZPds8k0ae9VW2u2QsT1dVd1UKB/M0E6C+CCx0oKP+21tpf/akVPk6rrzaFAp90WKjMKfa0aoVuvhOJTPM0eLYFffyMjQU9IpI=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(39860400002)(376002)(396003)(136003)(451199015)(46966006)(40470700004)(36840700001)(2906002)(110136005)(186003)(6666004)(1076003)(6636002)(26005)(86362001)(426003)(47076005)(2616005)(70586007)(16526019)(82740400003)(356005)(478600001)(40460700003)(81166007)(8936002)(41300700001)(5660300002)(4326008)(8676002)(70206006)(36860700001)(336012)(83380400001)(316002)(36756003)(82310400005)(7696005)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2022 07:51:58.6071 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d0aa4e47-269b-4305-fe60-08dad8f11599
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT061.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7547
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
Cc: Tao Zhou <tao.zhou1@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

1. no need to query poison mode on SRIOV guest side, host can handle it.
2. define the function to simplify code.

v2: rename amdgpu_ras_poison_mode_query to amdgpu_ras_query_poison_mode.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 54 +++++++++++++++----------
 1 file changed, 33 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 56d2c581f545..0735dfd72c99 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -2411,11 +2411,42 @@ static void amdgpu_ras_counte_dw(struct work_struct *work)
 	pm_runtime_put_autosuspend(dev->dev);
 }
 
+static void amdgpu_ras_query_poison_mode(struct amdgpu_device *adev)
+{
+	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
+	bool df_poison, umc_poison;
+
+	/* poison setting is useless on SRIOV guest */
+	if (amdgpu_sriov_vf(adev) || !con)
+		return;
+
+	/* Init poison supported flag, the default value is false */
+	if (adev->gmc.xgmi.connected_to_cpu) {
+		/* enabled by default when GPU is connected to CPU */
+		con->poison_supported = true;
+	} else if (adev->df.funcs &&
+	    adev->df.funcs->query_ras_poison_mode &&
+	    adev->umc.ras &&
+	    adev->umc.ras->query_ras_poison_mode) {
+		df_poison =
+			adev->df.funcs->query_ras_poison_mode(adev);
+		umc_poison =
+			adev->umc.ras->query_ras_poison_mode(adev);
+
+		/* Only poison is set in both DF and UMC, we can support it */
+		if (df_poison && umc_poison)
+			con->poison_supported = true;
+		else if (df_poison != umc_poison)
+			dev_warn(adev->dev,
+				"Poison setting is inconsistent in DF/UMC(%d:%d)!\n",
+				df_poison, umc_poison);
+	}
+}
+
 int amdgpu_ras_init(struct amdgpu_device *adev)
 {
 	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
 	int r;
-	bool df_poison, umc_poison;
 
 	if (con)
 		return 0;
@@ -2490,26 +2521,7 @@ int amdgpu_ras_init(struct amdgpu_device *adev)
 			goto release_con;
 	}
 
-	/* Init poison supported flag, the default value is false */
-	if (adev->gmc.xgmi.connected_to_cpu) {
-		/* enabled by default when GPU is connected to CPU */
-		con->poison_supported = true;
-	}
-	else if (adev->df.funcs &&
-	    adev->df.funcs->query_ras_poison_mode &&
-	    adev->umc.ras &&
-	    adev->umc.ras->query_ras_poison_mode) {
-		df_poison =
-			adev->df.funcs->query_ras_poison_mode(adev);
-		umc_poison =
-			adev->umc.ras->query_ras_poison_mode(adev);
-		/* Only poison is set in both DF and UMC, we can support it */
-		if (df_poison && umc_poison)
-			con->poison_supported = true;
-		else if (df_poison != umc_poison)
-			dev_warn(adev->dev, "Poison setting is inconsistent in DF/UMC(%d:%d)!\n",
-					df_poison, umc_poison);
-	}
+	amdgpu_ras_query_poison_mode(adev);
 
 	if (amdgpu_ras_fs_init(adev)) {
 		r = -EINVAL;
-- 
2.35.1

