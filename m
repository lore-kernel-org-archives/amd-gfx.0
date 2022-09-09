Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85936ECAAD3
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Sep 2022 03:38:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EB15B10E987;
	Fri,  9 Sep 2022 03:38:38 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2068.outbound.protection.outlook.com [40.107.212.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 298C610E987
 for <amd-gfx@lists.freedesktop.org>; Fri,  9 Sep 2022 03:38:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a3xCMuJmw5ictA2iOzM5L0zODck7KkxZnT4YVamquVdKWmvbCScPJvkt/YkNJZKyL/83vhrdjBUXxRDd1Z1mF7ILmt5Nmi+n2Zpd1y6FTp3GDaOMUYyr68FTg0wozjgCzucfkQ0O6gx04/XFHGvToDzA36xImVJZWNgGDtbpCF9nAG/pJs47i5AvVqDrldDXYfNe4kKyY4WPV68XofXf4DlAIxO4RJRDaCJ7KE+ZR1lqRVXTCBh4KjpPF5bWFc1tRWTFidYX19xN3HcyjG7DnCjfZGej4YLxNUavv1hlgyoLSHY8QWS8PXmPpHnXxl9OkPFGJlQfgh4PIsJ4mNkBMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DuDrMmWi4Rcz6h+ZLQSPeJXmLDwnU1DFJlyLHamiu+w=;
 b=GftNkfWMeEzYtr9s0APhU6IrjWS/8jQmnpT3AIexngS+FmIBqsHrqLM0vNzQc33BRxeXHGgKjkp49fxn84sTOBei62Jz9WRykyLNqyksGHTHCjsujpl47opR+4DVBS1LqkWE2F5sTs82n/gw1rLfgiDk61IhJtUNOw8BwiOL9vjA4vBMzVjdNdmkMfru6+ZC/LPoEZ8mQwuPufMK7jk6UQtrAoSAD8FrBW0tmmluDdE9iq0FcBBQfNmxKGP254jPROReoazk7+31NGHzXzEKymsblYu1WOgvR5AKjWYRmgRd0rTKhQni6X93zWESRz9pT3AbJIVp4SlGyZRPHqIEBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DuDrMmWi4Rcz6h+ZLQSPeJXmLDwnU1DFJlyLHamiu+w=;
 b=kJ0x12Luqvo15ViVrk0MISXOUd5nMcKnS77//OYmVoW/7VU+9yjyO0px3CQyGG1oV6WIudkJNOezpFMQNRJlnBAxEGPvNGoFBgq3x/qd6UnhwaYb5bMxVqoq0xbCj1vgIac9UxmH15W8KVk+XQihG7A4ib25MeEbBPn0r1xKW5U=
Received: from DM6PR03CA0083.namprd03.prod.outlook.com (2603:10b6:5:333::16)
 by SN7PR12MB6887.namprd12.prod.outlook.com (2603:10b6:806:261::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.14; Fri, 9 Sep
 2022 03:38:33 +0000
Received: from DM6NAM11FT033.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:333:cafe::43) by DM6PR03CA0083.outlook.office365.com
 (2603:10b6:5:333::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.12 via Frontend
 Transport; Fri, 9 Sep 2022 03:38:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT033.mail.protection.outlook.com (10.13.172.221) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5612.13 via Frontend Transport; Fri, 9 Sep 2022 03:38:32 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 8 Sep
 2022 22:38:30 -0500
From: Yang Wang <KevinYang.Wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2] drm/amdgpu: change the alignment size of TMR BO to 1M
Date: Fri, 9 Sep 2022 11:38:16 +0800
Message-ID: <20220909033816.3601512-1-KevinYang.Wang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT033:EE_|SN7PR12MB6887:EE_
X-MS-Office365-Filtering-Correlation-Id: 80dab3d8-3942-46b6-c2ce-08da9214c4da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Hot8g2bERg7qroCaEMPBRF4MDCeYUuPSusTnvBBW9VkyOLeBNnkhLinXGhf7dyPAjAq4/rbisGVYpD2RfLmtVIWolHz6c12bKKqmIuaF4HpcXHU9iJRKhyRL3KjX2UwrhvArrOiACNAO6UiZEioZyXX7h8nHpi39HbeSzZvbOn1Bt6SaLwdSmXOaIzRdDrkTUDnPUfXox0gVRKqvpi+ehxaDbOxaY9vIzecyr5gNaQKzIA/YQUEoXZ73LTiuDUaBGGH13a0nlWPkwnKAig/tYOPzX5eb+gpGR9A8TxgEVQtkuq/UsRJSev0iptGImMzSfIDn0HjJpgE201zdv6nlYA/8tGcRLxAVhKO3yBKNtEPiU2PctlxZOO0K4ufq9lmoy3zh1u1MxhpRGZ5lJo4JIg9cRabKGlAp7zmbovYWkMJqMuHVX54dZUuqeTkoJHoyQ+xfIDKl/jvAqkUYInncfhocJ4K9x/uuwXHGGTIOYmJjMlKADDE4ynfBtDw+QGjMF9KGxf0w64GbUvF8iwsFJkIFEjkcuizYRT7K/xs+3r4l00qJ6SjDlCV/0m4JBy2/r9K6WjKNP/M67CbZc0VSw1X1k2IaFhH53G7txLpPR2F1tLa/VjRodUr3YoWQS/M6v/wSLOzO/Cd52bMZZ9DCpt1vWeTWT3ztM92xsG2k75+CFcLy9m8I3GZTbXgGW82z48thhxctiiuK0QY4x6egFFg3EvsAWFIbdumAANi7nTjiZzCLQ31HbWyv5smaF5SjHbqOcaehIb0FPde9pW7K47uL1kEHGSREmITfZFslURPN403lIQV0Xjtp8xC+soDw
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(136003)(346002)(376002)(39860400002)(396003)(46966006)(40470700004)(36840700001)(36756003)(40460700003)(83380400001)(70586007)(82740400003)(1076003)(8676002)(36860700001)(54906003)(40480700001)(8936002)(4326008)(86362001)(70206006)(2906002)(6916009)(16526019)(426003)(26005)(5660300002)(336012)(47076005)(82310400005)(7696005)(2616005)(186003)(41300700001)(6666004)(356005)(478600001)(316002)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2022 03:38:32.5081 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 80dab3d8-3942-46b6-c2ce-08da9214c4da
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT033.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6887
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
Cc: Yang Wang <KevinYang.Wang@amd.com>, Hawking.zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

align TMR BO size TO tmr size is not necessary,
modify the size to 1M to avoid re-create BO fail
when serious VRAM fragmentation.

v2:
add new macro PSP_TMR_ALIGN_SIZE(adev)
to add ASIC specific TMR alignment size support.

Signed-off-by: Yang Wang <KevinYang.Wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index cfcaf890a6a1..289c4567c501 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -766,7 +766,7 @@ static int psp_tmr_init(struct psp_context *psp)
 	}
 
 	pptr = amdgpu_sriov_vf(psp->adev) ? &tmr_buf : NULL;
-	ret = amdgpu_bo_create_kernel(psp->adev, tmr_size, PSP_TMR_SIZE(psp->adev),
+	ret = amdgpu_bo_create_kernel(psp->adev, tmr_size, PSP_TMR_ALIGN_SIZE(psp->adev),
 				      AMDGPU_GEM_DOMAIN_VRAM,
 				      &psp->tmr_bo, &psp->tmr_mc_addr, pptr);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
index c32b74bd970f..869675c9037b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
@@ -36,6 +36,7 @@
 #define PSP_CMD_BUFFER_SIZE	0x1000
 #define PSP_1_MEG		0x100000
 #define PSP_TMR_SIZE(adev)	((adev)->asic_type == CHIP_ALDEBARAN ? 0x800000 : 0x400000)
+#define PSP_TMR_ALIGN_SIZE(adev)	(SZ_1M)
 #define PSP_FW_NAME_LEN		0x24
 
 enum psp_shared_mem_size {
-- 
2.25.1

