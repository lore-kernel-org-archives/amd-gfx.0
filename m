Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AAD9C4167B
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Nov 2023 22:32:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1309210E13D;
	Mon, 27 Nov 2023 22:32:54 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2054.outbound.protection.outlook.com [40.107.220.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ADABC10E13D
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Nov 2023 22:32:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SXC4Inv1Sv1MXs06IPWjnCJgyj01dY0Hq0+TsMv1WY3F0M813/+OHdIQsr1nMoZDrhv7l6TG/+w0uIvlfQZaqvaqYc6KAN1npO2UujMUeWZz468lWNO9NBecfcPdAOv2kwISiiWxIAaInjMzyIw41Nku7Mxbwk4D8qE2TDN3Xe/vgjc0/Te/watB/T81e/WYiaTNgaVuEhq1TzqPkEFAUO8X3ifgWG3TAL2z1X9cWE4BTDio20RgKIM/WgEw4fEjnC66KSGTGVYV2/KSZxcT1JjtcUFhEbwKFA80HVuFC4xPCpD0kDA4IHZkn+EhtmoO2bPj5qVqd7BPa8v5dMNSSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wyvmsT2yvyLqw4x+G2+5gkL2kdlAIctqklm02u4vWgs=;
 b=R0gc+rpGFPrSK4ENc8PAWBUZvmZbiHRUOS9G1L2eM0yopb/GEMWWFZajLLHVRqDeNn2jU+hpRSMYRl0/CKDvl1lOKUmhzKp4q9IuoaL4fsJfhZwSy8k8qRN6vB9bEA7oM/TPZo6qnsy3UD5Z6SonLUKcYgjuqjzcl81MNrMcqO6ZNuOED/9Wl3Mh3K7qCmkaGwE7yact/40OhSxe2P5Za0M+EjY2pQ9CzM8ziK8eRt+MAgxC7gyyR9FdIDiVmFX93DwCWR0vkN+tD6D/TE+SVZSlthHxhRGO1OlNNGwWTmhIDDR4Uku4XOmT+ihwE8FC9REkEvf/abFstBjL2w/Kag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wyvmsT2yvyLqw4x+G2+5gkL2kdlAIctqklm02u4vWgs=;
 b=aoTYMRGAdGX0hVuto40ZyUcTmUqOrIj/25UHWKn2MncoMKuQZUkhJ8azaermi/fZ6Pvs9pWbAeu28PPD65yg7sOu/LHhDmkay9qCS6VHIgwo8U7a1za+weylYcB0TqGsu95aPnoHpxacNYpFgtSqVFmCu9qRRdOxDmKFNdWHP+Q=
Received: from BL1PR13CA0025.namprd13.prod.outlook.com (2603:10b6:208:256::30)
 by SJ0PR12MB5485.namprd12.prod.outlook.com (2603:10b6:a03:305::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.27; Mon, 27 Nov
 2023 22:32:50 +0000
Received: from BL02EPF0001A105.namprd05.prod.outlook.com
 (2603:10b6:208:256:cafe::63) by BL1PR13CA0025.outlook.office365.com
 (2603:10b6:208:256::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.17 via Frontend
 Transport; Mon, 27 Nov 2023 22:32:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A105.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7046.17 via Frontend Transport; Mon, 27 Nov 2023 22:32:50 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 27 Nov
 2023 16:32:48 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amdgpu/debugfs: check if pcie register callbacks are
 valid
Date: Mon, 27 Nov 2023 17:32:34 -0500
Message-ID: <20231127223234.891204-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231127223234.891204-1-alexander.deucher@amd.com>
References: <20231127223234.891204-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A105:EE_|SJ0PR12MB5485:EE_
X-MS-Office365-Filtering-Correlation-Id: ba59695a-c2c2-4171-524f-08dbef98c9bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /0LrswldBa/Sti+L9F7apVvvE4sA1pLjr+bQNaPhYE+vMcutaoATt+vrPZxz1X0GqjvCzxV7kISzKeQMLClEKMLlFc7vfnT/vGECCQMZJjAwBP6T2xYQI+pQAQ75UgfA8Dh1+DGPl7hh4pmSfOY7MqMRGNaBB9GkJiIM0BJizfe+hbSsWBpOd8Lc+lZ8ib1Ia4pgzec3+AhDQnzmFG9ILVGGrr/71F1H3eLHfCN5Vhuvb3toKL70QzHKRXamrmIClWh/u9eklmf2ZKqvkMrOzqnRyiN1AfOI1sSn2ExCQJH/r+nW9uM+5LWDYU0geEAcaRkOPOGpw/ZiYAzatA7mgjb1N+OC2qPyHBrZ4j+/F/f83w2U3W5IMV4OuHuo4J2mefC/E0CR0+xhOW0JmANmhE3iKQBwCNc/iaFUJ/2Rzpfft7RoUACebFqoo+zQy40rw39sOHGV10lpV+NzsGD3ereaPZwN3lCCP+kpeXIDP81jktj2sZIGJ/r8U20CSTVI+s1TR6UwiFZYHazWX8+ETQPuVlrCM+ztGFEtmIZcU/JMGrerWHDzDoT/ymgLzHydwL3bFZPYjRHPesA2udEDwPjeC7VFn2ybCdF0BOwSO/hdnzhPOKfUGP+MD8n48MIG6t2xvcANdPyzgBNaurtLBea3d9DGJIJ0D6cfHhyMY/TUfuT+iv6lh10AJFWDStpUDwZxQhywgLNzN/CiQgA75NG0WBwvEoWN1kisB94bW7EITZ0DCBv7FEW1SMBbi4aVskCfKa+9d98VJ+z7uqmSRg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(396003)(136003)(39860400002)(376002)(230922051799003)(64100799003)(1800799012)(451199024)(82310400011)(186009)(46966006)(36840700001)(40470700004)(5660300002)(2906002)(4326008)(8936002)(8676002)(70206006)(70586007)(41300700001)(40480700001)(26005)(478600001)(16526019)(6666004)(1076003)(7696005)(2616005)(6916009)(316002)(83380400001)(426003)(336012)(40460700003)(47076005)(36860700001)(86362001)(81166007)(36756003)(82740400003)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2023 22:32:50.0749 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ba59695a-c2c2-4171-524f-08dbef98c9bc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A105.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5485
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Before trying to use them in the debugfs register access functions.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
index 8d4a3ff65c18..cb2849e39dba 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -525,6 +525,9 @@ static ssize_t amdgpu_debugfs_regs_pcie_read(struct file *f, char __user *buf,
 	if (size & 0x3 || *pos & 0x3)
 		return -EINVAL;
 
+	if (!adev->pcie_rreg)
+		return -EOPNOTSUPP;
+
 	r = pm_runtime_get_sync(adev_to_drm(adev)->dev);
 	if (r < 0) {
 		pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
@@ -581,6 +584,9 @@ static ssize_t amdgpu_debugfs_regs_pcie_write(struct file *f, const char __user
 	if (size & 0x3 || *pos & 0x3)
 		return -EINVAL;
 
+	if (!adev->pcie_wreg)
+		return -EOPNOTSUPP;
+
 	r = pm_runtime_get_sync(adev_to_drm(adev)->dev);
 	if (r < 0) {
 		pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
-- 
2.42.0

