Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59629CD98F3
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Oct 2023 06:51:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C0C1C10E1F6;
	Wed, 11 Oct 2023 06:51:22 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2083.outbound.protection.outlook.com [40.107.223.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1BA6010E1F6
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Oct 2023 06:51:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PN+nuZN5rSUfbkq5LI+yeVIuSsxL0y46te5SmJRe9Gf/0KOZSGA30fjot9r2Hx9iSejpUW0U0zgVqYzc5yi7LYNr4Y8PU/pNVhh0SdrLdlOynTdfksbRws8tuzqMakh6Leu8Dtsbptm9VOJPYUm54cRHfZzK/fk51VWnGJWF17J+OWdMTillqKUP23VmL7gzVtc6YXHk9ljEa0QsIlP1CVYcF4cJtFn5YtUIWF8L8lnF8Njie25hamH4XuLTPd6QvfeJDn0jrRAH8wvEATuMnr160EmMscEeGX2VEcZGTng+3s9wOg69orI/n6iz+gF3cls/mY9hxCd3DJN0CAszEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k8BuyFJZNLghYSbegVYCLZZAAcLIxxLyUkhayM5FEhU=;
 b=T2uHJi6p+2EluMNaqlggRaLR06/wDBkZgtkqtK9KMXpCMCbi6yycy4ABTaIhswf3zcsEoDuptwX8sLe01ywhf4x78eT2ZPyVsvSmECyI97wXXwdWglmWhM1rjAwFny+2Q9yF+CKC8aPOT5MxCfEU0x9B/xl6ujuaZtb/UcKTDRRN+m1T5bFdSqD/Tbe6Pp1bfH/ddv60jtjlLDzAEnIv4ltD8w5j7PW//vciWwq6M6MtnFxxa/YZlo6SqGy+QIS7wwGlhB2+8D003mqjIWnWAsi+K1P/yhYcadESbLko1tNwHmkDd2yPqVyTC0WhZjvwVjFc3yWD7tVVgE0ZoNiNLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k8BuyFJZNLghYSbegVYCLZZAAcLIxxLyUkhayM5FEhU=;
 b=xhxJSmEdrYNPYadp6pgKwbfLHkuZgIOvunaBgW3nPfRVm3WvK51GIDpMh3djS7HMGNm81I5hKZ37kKH8T4SFcK1VAGROP02heZcTOTW1X5ltWEDL2AuGOAxEpzN2UESwD6y8c1vZMje2GnCZZA6s2+F3K7uzF/UlUauAVoROTZk=
Received: from MW4PR04CA0135.namprd04.prod.outlook.com (2603:10b6:303:84::20)
 by BN9PR12MB5291.namprd12.prod.outlook.com (2603:10b6:408:104::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.44; Wed, 11 Oct
 2023 06:51:18 +0000
Received: from CO1PEPF000044FC.namprd21.prod.outlook.com
 (2603:10b6:303:84:cafe::d) by MW4PR04CA0135.outlook.office365.com
 (2603:10b6:303:84::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.37 via Frontend
 Transport; Wed, 11 Oct 2023 06:51:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044FC.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6907.10 via Frontend Transport; Wed, 11 Oct 2023 06:51:18 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 11 Oct
 2023 01:51:15 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Read PSPv13 OS version from register
Date: Wed, 11 Oct 2023 12:20:35 +0530
Message-ID: <20231011065035.54324-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FC:EE_|BN9PR12MB5291:EE_
X-MS-Office365-Filtering-Correlation-Id: 43a6e6aa-6672-4370-9c00-08dbca2678c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HOmP0Qcll1DsTQGn4E5y5X0XT8zOpq8Px3vdp7vurcOhZZ6rDL0JYj0LUTniA9XOlL2AQkjTmyc6mqjR7fbUNnTyMgTKY47BvrT/7YSIJv5VRtKq7WlT3oP3Sh+xZyzFL2a/qToWLJhcCp8WkHwSmQIWnw0BLHwkUIWnzQvI2h3IG15KbVJ/3wajgvGb+mvi/sCnIbto1+aM+B+uW7OB88rfTLp1EdoWivh12h8mvThZq4pKlF/4E5nLqPZccysN/uVb4zhdjZ6CNJKjQyMn0cx7sCyvabjVjOjjIrpNTpeT9gUbS61yyAHKjGWfCXuwxuKSlYX++X9PPiXvb0hw0T5TUGchBDUsq11woq+CriHUxSmU0nklKajDEV8n/WAb1TQgky9jkv0qvHvVXS+np9U7lhrcEDip7tlsnTBQcPut2/F6D7szQ8VigrznKSvZXFTr0z86n6ykK/jt+yDNLECgwcq9lNpSZFUII5WaMQjU2NOesitnkNctrkGXcZ4+S0vhVtMOBP4wmL7B1C1iMyht0hzeRJkLKehVFqdqu17wrUiBB+V4MC8dvpHXzPeW8qRKE/A/tLSlAR97+W/Yz6Buz1vT77uVfwrpXmxF/f1DjlTl3uqPsyGBW2scpHF5dgc6VjsH203zXtQMewlL0GxPYrn0ms5zDnwDWzXUsQtBpjQVF/mR+TrOQzuPu7vLm6316uEOa9OyP7UifQwngybj4TB+6bps7ICLYs39/3uMbQQvIEJuXcAj7kT3Fk9tJVz3qrt3672GJ8fUS6ihrw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(346002)(396003)(136003)(376002)(230922051799003)(82310400011)(451199024)(64100799003)(186009)(1800799009)(40470700004)(46966006)(36840700001)(26005)(2616005)(47076005)(16526019)(478600001)(83380400001)(7696005)(1076003)(86362001)(40480700001)(40460700003)(6666004)(41300700001)(336012)(426003)(36756003)(8936002)(8676002)(4326008)(54906003)(6916009)(316002)(70206006)(70586007)(2906002)(36860700001)(5660300002)(44832011)(81166007)(356005)(82740400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2023 06:51:18.5238 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 43a6e6aa-6672-4370-9c00-08dbca2678c2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044FC.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5291
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
Cc: Alexander.Deucher@amd.com, kevinyang.wang@amd.com, Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

PSP OS updates the version information in register. On APUs with PSPv13,
PSP OS will already be loaded with SBIOS. Hence use the version register
instead of using information in driver binary header.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/psp_v13_0.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
index b7bc00d4c696..573046702861 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
@@ -263,6 +263,12 @@ static int psp_v13_0_bootloader_load_ras_drv(struct psp_context *psp)
 	return psp_v13_0_bootloader_load_component(psp, &psp->ras_drv, PSP_BL__LOAD_RASDRV);
 }
 
+static inline void psp_v13_0_init_sos_version(struct psp_context *psp)
+{
+	struct amdgpu_device *adev = psp->adev;
+
+	psp->sos.fw_version = RREG32_SOC15(MP0, 0, regMP0_SMN_C2PMSG_58);
+}
 
 static int psp_v13_0_bootloader_load_sos(struct psp_context *psp)
 {
@@ -273,8 +279,10 @@ static int psp_v13_0_bootloader_load_sos(struct psp_context *psp)
 	/* Check sOS sign of life register to confirm sys driver and sOS
 	 * are already been loaded.
 	 */
-	if (psp_v13_0_is_sos_alive(psp))
+	if (psp_v13_0_is_sos_alive(psp)) {
+		psp_v13_0_init_sos_version(psp);
 		return 0;
+	}
 
 	ret = psp_v13_0_wait_for_bootloader(psp);
 	if (ret)
@@ -298,6 +306,9 @@ static int psp_v13_0_bootloader_load_sos(struct psp_context *psp)
 			   RREG32_SOC15(MP0, 0, regMP0_SMN_C2PMSG_81),
 			   0, true);
 
+	if (!ret)
+		psp_v13_0_init_sos_version(psp);
+
 	return ret;
 }
 
-- 
2.25.1

