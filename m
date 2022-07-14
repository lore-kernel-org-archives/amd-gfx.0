Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF02BC43334
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Jul 2022 02:31:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 02F98A05E7;
	Thu, 14 Jul 2022 02:31:54 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2051.outbound.protection.outlook.com [40.107.92.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E0E0A05E6
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Jul 2022 02:31:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BjoW3/spr9PJm5fJhalSxwPhtx5ME2EiH2M6uYmu84cKJWsCZe/BDHYKKR7rscICBP7DiYaClG8f4nIb5Sc/EhfCqAcyEh7IPn9u4QN5m7J0rur4aQ63JX2NnxEkhUAGFunwbkrlpDDI/KBzS0nUlYfO8DXRDqyyasY7Fpz/9/2VBQJqLqKNKWvGnAPIEUQH6QqrfuT+sy0InKcVYuEwiWnKTQglczkXVpVKM6/R4VFI5Mkq1hArCO9YpYSv4C0OSvdfxhASE2NaCnaaQBSKytHFZlNNehqoR2VfOnRIJmefVMb5QbTHaN6h9d/pMEslRDI1r7T3xHpG5C10JlHuGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N76qgX/VxRGt9SKnlgcRtFpnMj2ld3FiU4vjO4us4Jo=;
 b=PsX7GftxVwLl+NPNCFImjE5Zna1s3+qaxBPuSd3gAVjadXTotPftanwHOhYPM3GMIwdp9ujX1Ngf9fspYYS1YoSxjtoMXoDFkRWvY5/fc1QamQBhthAm+lPTan2A/542bR6gV/IAuIJAXUFDixi8lQ/1v5mgrARXsuhZ2hSXAbLwVGAhTvQ0KJbEsKI13OG9DLAgSKbAeMtBcCrnhfUbSvbATYB/envF53RoCzaq8dtKovD1xBalfqnHB6jx7ho2Uxuc5+lO0hgqwcdlNRhMzhdA0Jrl/5iEbZ8xMNdskNTlZn/62/fBAoZ+VjngFEGZCJtJ84RzqC91Sl1ThUGXqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N76qgX/VxRGt9SKnlgcRtFpnMj2ld3FiU4vjO4us4Jo=;
 b=i7/K45pAmiAUek+UhGGzR2/jxH5t1NoACwU0HYIb2duxKfOoC4ScB7nuKJTyrDgeZ7sZN+VaUXNKHuqda6CyVPs0gK+70nbBdI9SgZ/atZgTIAp7prfigT6BF4bVGWAy5G0V1nwUwuU1FXO6Z3r8Le7kg6Pt9oh5C260qRZE8No=
Received: from MW4PR04CA0164.namprd04.prod.outlook.com (2603:10b6:303:85::19)
 by CY4PR12MB1830.namprd12.prod.outlook.com (2603:10b6:903:127::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.23; Thu, 14 Jul
 2022 02:31:49 +0000
Received: from CO1NAM11FT045.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:85:cafe::47) by MW4PR04CA0164.outlook.office365.com
 (2603:10b6:303:85::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16 via Frontend
 Transport; Thu, 14 Jul 2022 02:31:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT045.mail.protection.outlook.com (10.13.175.181) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5438.12 via Frontend Transport; Thu, 14 Jul 2022 02:31:48 +0000
Received: from amd-SYS-7048GR-TR.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Wed, 13 Jul 2022 21:31:46 -0500
From: lin cao <lin.cao@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Call trace info was found in dmesg when loading
 amdgpu
Date: Thu, 14 Jul 2022 10:31:11 +0800
Message-ID: <20220714023111.46015-1-lin.cao@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: eb12181e-8b5f-452a-22b1-08da654100f6
X-MS-TrafficTypeDiagnostic: CY4PR12MB1830:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: du7/lg0AXOhGgN3AI74AHmPUwWWmgnssE6bpUhXrwwDSiNuhdRCFQFLk8UBn2OOmloyLHTASnTN6Pcs0oSPIkE0OLsSdrCJa4+b1otFO5q6uuI4UTq9qUPGaoVqZrDYz+iP2tUx/vfxl8BQhge9T4/ptHmD8KLuapJDGfuB4n/ElPKecnvoUbVXHBFJF9TJEF4H5RZwQTUZdauTFenSlis+FdgfCydM0gc87tFENe4EkCAU5PxxFkugFX+zmKtoN7Gc4x0UuDWSLgBNwFg5oZ+Os+eOO4Em0EFMm4use9iGk62OBjBNBr0+6qEywp1/2Pk2Fn0guwze/vhuCAgkLL9bKqSTLj7eo/kYgSb9C+bpaGCJJVEdxIXSDyx5RKE9NkElROIwKQIRt/+f8A6u/LqrTStxeigcVkfd9FiLVsWG/HLD8TxNff1LgPZ4Y0WE0PzySTw0wqnsDur6vJSdw2Y0sBeLn3UaawhPr6tpdQmG1IFS73ZXfI9XisbIIjtZbodOpRU4R2qtADz4lI5JK7BbOdpg5LxoTfGwsBxfUXqIsQIJ/r55ieBP57P4v9yVB0s/8mRY+A2cy2gIIJRfw092Yd/2AkJuVdj8FH7pFPcx0DLhEqgKdHsYZKKGheh6jD0wnsFq19dztrvknxMJnwx1xctDTlXTZ6DwyF94lMB3fxW6Itvt6XIYfkH5Fjxa3rthe6z/ekU0/3WMxqBErQxuHLd6pfttPS2ytEOTKhMwF24+Dv4+/QZwzkqb1BP4JSC26uJrlNCRDz33o8HOZ6NBtqzqr0vs91nKJlZkRQatjUQeN8j2bBsxBQgFQBKRUgMgzGW8+RClyulHDJSJwuih+HJYm8BWbdX651ZjtXvg=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(346002)(39860400002)(396003)(136003)(376002)(46966006)(36840700001)(40470700004)(36860700001)(82740400003)(41300700001)(7696005)(40460700003)(6916009)(40480700001)(54906003)(2906002)(86362001)(36756003)(26005)(5660300002)(8936002)(2616005)(70206006)(336012)(8676002)(426003)(70586007)(82310400005)(356005)(1076003)(47076005)(6666004)(16526019)(186003)(478600001)(4326008)(316002)(81166007)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2022 02:31:48.7413 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eb12181e-8b5f-452a-22b1-08da654100f6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT045.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1830
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
Cc: jianzh@amd.com, lin cao <lin.cao@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

In the case of SRIOV, the register smnMp1_PMI_3_FIFO will get an invalid
value which will cause the "shift out of bound". In Ubuntu22.04, this
issue will be checked an related call trace will be reported in dmesg.

Signed-off-by: lin cao <lin.cao@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index b71860e5324a..fa520d79ef67 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -886,6 +886,7 @@ static void sienna_cichlid_stb_init(struct smu_context *smu);
 
 static int sienna_cichlid_init_smc_tables(struct smu_context *smu)
 {
+	struct amdgpu_device *adev = smu->adev;
 	int ret = 0;
 
 	ret = sienna_cichlid_tables_init(smu);
@@ -896,7 +897,8 @@ static int sienna_cichlid_init_smc_tables(struct smu_context *smu)
 	if (ret)
 		return ret;
 
-	sienna_cichlid_stb_init(smu);
+	if (!amdgpu_sriov_vf(adev))
+		sienna_cichlid_stb_init(smu);
 
 	return smu_v11_0_init_smc_tables(smu);
 }
-- 
2.25.1

