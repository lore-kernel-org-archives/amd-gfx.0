Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D88E4C77B75
	for <amd-gfx@archiver.kernel.org>; Sat,  6 May 2023 12:16:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2457B10E0A4;
	Sat,  6 May 2023 12:16:05 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2049.outbound.protection.outlook.com [40.107.237.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B75B310E0A4
 for <amd-gfx@lists.freedesktop.org>; Sat,  6 May 2023 12:16:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g78+m44ODNjZfaxqoiG9kZ0iC1d5mUPrCNEjehgVosj2ZDKXk6YXxKVd6+i67HeoW/f5OkD3hMyMqzqHJrBN9yCEeuCdz0C9unq9vPuSZX65DQGcba8uEh2McxmJUegHvntljZ6MfMB2945VFzWsdlBzr11oTaob1b3MOwgZIfZ5cOFTbLbIv4tv7iG2k++sB/mA9dloRrAOXT6AcVxc72WGwA+ucWRoZh4xE/ErXMjFZQ3NMZdhW594ZZY+kMtciJa/QusoHbus6H/B4dkab27sLe8HD74cOnsaT37jsT3VgyVMK29iR80sPVHMpAZ0glmr1LfOxnoyDqWvauCmgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EGIsq1Z7IO+V1Wnb8+F/gX1W+kSR58EZhFetVKTFwvk=;
 b=D9bsARmeCRt+NA0nXFsxfrcAoJPskyNNIWrfhl9ICbJJm0vJ1WXtjgJsn330l5RrL+9RODcv8rJhcRe1CLV9Cwic1lcUtVDebfDs2rsuXw9o7Z4PE8E4365e9HGEVR3hFNUXALiGRx8iCkD0fPTJb/W/MDuftY4j1Q6mPKLcDDaEGGlI3drXUFP/wJA5+1SfN2EJsjws7xVmRqkSZpZDS5VKDVmyCKIiCqcWdnjGvwkZtRh1a+EiNSaNis+8oWhq/5JMddN+2pgerTP0iX8a0QIgzkCPSgDJPd1qq+XxgwnXmX4YNc6/Iw+xWea6RfX31UkgytxfzwfMOPx8Tiix3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EGIsq1Z7IO+V1Wnb8+F/gX1W+kSR58EZhFetVKTFwvk=;
 b=HxEyYcBW17f+7PO3JCyeEvW7Hw2gEty2mXOUqF5kKF1UvIoyjKPA+4qypAzsmzHX+faZ8YJp7vsPekVQILQ6ZTOCqbqUmFzE5E539QJ/FQmPhXdSba+Sf6dqMAbjhq6NgOD2zhx1JuiX9T7NbgC3rDHcTuRjO0jyAusleuacaXU=
Received: from DM6PR18CA0026.namprd18.prod.outlook.com (2603:10b6:5:15b::39)
 by MW4PR12MB7189.namprd12.prod.outlook.com (2603:10b6:303:224::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.22; Sat, 6 May
 2023 12:15:58 +0000
Received: from DM6NAM11FT079.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:15b:cafe::d0) by DM6PR18CA0026.outlook.office365.com
 (2603:10b6:5:15b::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.29 via Frontend
 Transport; Sat, 6 May 2023 12:15:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT079.mail.protection.outlook.com (10.13.173.4) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6363.29 via Frontend Transport; Sat, 6 May 2023 12:15:58 +0000
Received: from guchchen-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Sat, 6 May 2023 07:15:55 -0500
From: Guchun Chen <guchun.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <alexander.deucher@amd.com>,
 <hawking.zhang@amd.com>, <lijo.lazar@amd.com>, <Tao.Zhou1@amd.com>,
 <christian.koenig@amd.com>
Subject: [PATCH] drm/amdgpu/gfx: disable cp_ecc_error_irq only when gfx ras is
 enabled in suspend
Date: Sat, 6 May 2023 20:15:43 +0800
Message-ID: <20230506121543.1891418-1-guchun.chen@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT079:EE_|MW4PR12MB7189:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a0cf713-ad96-4987-e0f6-08db4e2ba666
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OptawjCVQKZQ86Hj8by3cSrI4ggmcVywG0SwpQAOsEKv5djueeVr5Njfrv1Ci7Bny8yeNQU0nFqxqNgoqcvPN2fVNKkFWMajcCRsHC+tHqCrXF2262ebHeNSrc5aa7LPwOgz28wnpPRna5oZklrp4+4vexTmYjVznqgKR0RCyOa54UQSRjCs9y37ikdMCTuH7gW43y0JRI8em5D7rOlROLqGag7mcNFL6a5bhFeY4gxciy37xBF37zNrpp4JWch9MSwMM64s1OwGBtQLXVcTxiMj92T3QtdY1YWKMOwfB5OaNSFl8aOoOFw+VhC2+BiJ/9vJ1gZD3t1g9vmLCqRlEKmsUqyd26pvaY4Me3f5w+hY9u0PWPtS731X903hBh9ylHS1eOKunxBu+XFq+MDywZDgql5nzXVG5JuGnzvxuJnYCUGj66z1xzR8isKuRbcSLdUIB1cB4Ve+AdAN3XCIzVke5EaEyog90WX1kbZ2f3jsmf8h+G+zOpdZXxEsQBrn3sOOAZwH0kXKbEiTE8BFKSFNWo5ecxtiR4kW3CSC1Oz1ikZp/8nZXHxr1HcPUsKYClz336gTwuT+dWTGbVu/KFHqguZXxhtPtA+8yEdfB2amCoAorIKn2LdLDPalPMVHHbWHTFcgP1M2o8MVECEectRL8hT5fRVJAVKEaVCmouPalO5rwVgsadHIXVPijyEHsDS8wRC5J4ojbTmC8g/EPg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(136003)(396003)(346002)(376002)(451199021)(46966006)(36840700001)(40470700004)(478600001)(316002)(82310400005)(40480700001)(8936002)(966005)(36756003)(86362001)(8676002)(7696005)(4326008)(6666004)(41300700001)(6636002)(70586007)(81166007)(70206006)(82740400003)(40460700003)(5660300002)(356005)(47076005)(2616005)(2906002)(36860700001)(83380400001)(110136005)(1076003)(426003)(336012)(186003)(16526019)(44832011)(26005)(2101003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2023 12:15:58.4596 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a0cf713-ad96-4987-e0f6-08db4e2ba666
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT079.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7189
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

cp_ecc_error_irq is only enabled when gfx ras is assert.
So in gfx_v9_0_hw_fini, interrupt disablement for cp_ecc_error_irq
should be executed under such condition, otherwise, an amdgpu_irq_put
calltrace will occur.

[ 7283.170322] RIP: 0010:amdgpu_irq_put+0x45/0x70 [amdgpu]
[ 7283.170964] RSP: 0018:ffff9a5fc3967d00 EFLAGS: 00010246
[ 7283.170967] RAX: ffff98d88afd3040 RBX: ffff98d89da20000 RCX: 0000000000000000
[ 7283.170969] RDX: 0000000000000000 RSI: ffff98d89da2bef8 RDI: ffff98d89da20000
[ 7283.170971] RBP: ffff98d89da20000 R08: ffff98d89da2ca18 R09: 0000000000000006
[ 7283.170973] R10: ffffd5764243c008 R11: 0000000000000000 R12: 0000000000001050
[ 7283.170975] R13: ffff98d89da38978 R14: ffffffff999ae15a R15: ffff98d880130105
[ 7283.170978] FS:  0000000000000000(0000) GS:ffff98d996f00000(0000) knlGS:0000000000000000
[ 7283.170981] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 7283.170983] CR2: 00000000f7a9d178 CR3: 00000001c42ea000 CR4: 00000000003506e0
[ 7283.170986] Call Trace:
[ 7283.170988]  <TASK>
[ 7283.170989]  gfx_v9_0_hw_fini+0x1c/0x6d0 [amdgpu]
[ 7283.171655]  amdgpu_device_ip_suspend_phase2+0x101/0x1a0 [amdgpu]
[ 7283.172245]  amdgpu_device_suspend+0x103/0x180 [amdgpu]
[ 7283.172823]  amdgpu_pmops_freeze+0x21/0x60 [amdgpu]
[ 7283.173412]  pci_pm_freeze+0x54/0xc0
[ 7283.173419]  ? __pfx_pci_pm_freeze+0x10/0x10
[ 7283.173425]  dpm_run_callback+0x98/0x200
[ 7283.173430]  __device_suspend+0x164/0x5f0

Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2522

Signed-off-by: Guchun Chen <guchun.chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 3 ++-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c  | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index ecf8ceb53311..f6bc62a94099 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -4442,7 +4442,8 @@ static int gfx_v11_0_hw_fini(void *handle)
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 	int r;
 
-	amdgpu_irq_put(adev, &adev->gfx.cp_ecc_error_irq, 0);
+	if (amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__GFX))
+		amdgpu_irq_put(adev, &adev->gfx.cp_ecc_error_irq, 0);
 	amdgpu_irq_put(adev, &adev->gfx.priv_reg_irq, 0);
 	amdgpu_irq_put(adev, &adev->gfx.priv_inst_irq, 0);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index ae09fc1cfe6b..c54d05bdc2d8 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -3751,7 +3751,8 @@ static int gfx_v9_0_hw_fini(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
-	amdgpu_irq_put(adev, &adev->gfx.cp_ecc_error_irq, 0);
+	if (amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__GFX))
+		amdgpu_irq_put(adev, &adev->gfx.cp_ecc_error_irq, 0);
 	amdgpu_irq_put(adev, &adev->gfx.priv_reg_irq, 0);
 	amdgpu_irq_put(adev, &adev->gfx.priv_inst_irq, 0);
 
-- 
2.25.1

