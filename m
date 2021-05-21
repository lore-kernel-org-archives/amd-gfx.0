Return-Path: <SRS0=kbWR=KQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BD8FC47076
	for <amd-gfx@archiver.kernel.org>; Fri, 21 May 2021 17:37:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1408B61168
	for <amd-gfx@archiver.kernel.org>; Fri, 21 May 2021 17:37:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1408B61168
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 681476E51B;
	Fri, 21 May 2021 17:37:07 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2057.outbound.protection.outlook.com [40.107.237.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 51FDC6E51D
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 May 2021 17:37:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=isoToeNnt/NxY/RoZMjxyCA2ynaNvQXbwf+3mrQBQ2P6tLtH0dy+DjnCzimf7QqQX4m3iDfWWIhwHWfNaR0vRHDHPKLIuEFiBjdGbfbQ/1LnbR54rNCqV7E2pvpIU3DtEndq+egQV7M/Q2CWdsvMKkPYAyXK7BLNhNMCZFPbsTbgdH2gbcjHGqy8VTFRX2WwdIXAx8dS65oonEPoK7upfcUoIUHDliJnSpjG8aZJEejkIvL3/BAJvdPcKGhTCe+Y69iN6nRoKV4w35+FaGzMpenfUDqfp1H9be6msPcR0E0CGhC5z31j95rBfqg0tOyg2CIOSZCXxbfQIkiYFkbgAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nPjb3zXB9eft7cMZzxr7QOGnGLvOrpyE3txrflLfayY=;
 b=Kw/Mj0iveiqFw1IhiWClaevzu0MZ92KCHSNpBGFjLNehzeUsBeOSnTKzzRW5/iJ94FFczO9JPXm9XMYRzZjQzSWwInsk6XVSu32bKNfVcj605wFB8mm+NfbG4I60qjPPgW96k9CP99mdJiYaJBm9ON9HiIfdphuUWul90Ouk5WBS/XMSykVrC4zMpYLW4Z5hH1bbSz8bY6nzmPxr8HW0h+qEx6WsklvxyHljTB+UvKnVwSlFgjHXIcEjQYqsUbURLxX1DTP3M9dAsGv3B7KLOz/fz7rHCbAQ5T36ig1VWNhwQmp35N+SWPPnBWbh/CCMTPn8EviBl7zHq3N9FTlJ2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nPjb3zXB9eft7cMZzxr7QOGnGLvOrpyE3txrflLfayY=;
 b=4shjpJ29qnhURRBh5oUZ9Mw6CYQEBfITugOx9gndORnmTlWZ6SuL/QJD0UmMkDR04FemVqfF3MVmLIYHhIjRI1HeeRrmEnFC3EQ3UeVjtUjQTdogImVj7etPZ+BxfgyuFI0C9A7Q7B5/oxOKeo4hxCmUeY51wag7ycVFK9Qi2cM=
Received: from BN9PR03CA0673.namprd03.prod.outlook.com (2603:10b6:408:10e::18)
 by DM6PR12MB3434.namprd12.prod.outlook.com (2603:10b6:5:3b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.25; Fri, 21 May
 2021 17:37:03 +0000
Received: from BN8NAM11FT064.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10e:cafe::12) by BN9PR03CA0673.outlook.office365.com
 (2603:10b6:408:10e::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.23 via Frontend
 Transport; Fri, 21 May 2021 17:37:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT064.mail.protection.outlook.com (10.13.176.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4129.25 via Frontend Transport; Fri, 21 May 2021 17:37:03 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Fri, 21 May
 2021 12:37:02 -0500
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 07/15] drm/amd/display: Fix potential memory leak in DMUB
 hw_init
Date: Fri, 21 May 2021 13:36:38 -0400
Message-ID: <20210521173646.1140586-8-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210521173646.1140586-1-qingqing.zhuo@amd.com>
References: <20210521173646.1140586-1-qingqing.zhuo@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2c75e2d0-958e-434e-ce35-08d91c7f0bed
X-MS-TrafficTypeDiagnostic: DM6PR12MB3434:
X-Microsoft-Antispam-PRVS: <DM6PR12MB3434A1761386A83EB93C98F0FB299@DM6PR12MB3434.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KUPwobbv8WqQd5d2DcziT4iaCG488h3Tc0zHmNLCEbgf+gvmtVXp6/TdYOISVmnZYIiqYjMyjR7scainR6al3slP7lREjx9gdvPG1INdcGjCeAGlzBvG0aYk9WCQZI9bB3aSHosYo49DIgDqLyWcf6ZWe68KFollrPVRNPgInUH479u7tLVmjdMUfpw0ccYSB59Pfq27prF2MJJnvu0kxNJDoaZOL3DE7Mn+WO8eVy2h3V2WOZEcIsBI60rXHxSxTVI4+MOCe4DZg975Ap90t2/ZvXIMCHXXTdlDlZ9IW6RqXOJHaVEbqsaEm8M1t+htvnivc8LmaRb9YRkAAx2D8QxtO/WYoBtz8Qpe1elk6gO2Py8rblpoxQ3S5FsE1TS3Ieu0+6xu5Vy7/j3d+Pjdl+S8JburN7uKAawbjFOU6ARc/RapHtlNF0ntTLHFBqih69JYFVyrz0k3PgTIFKTHy7/Rb9CzVTn20TlUesWb2NzKf+vevvFBAhGxYDsSYyblk3Daw3WgY769QSY7lQI2Y7+Bg8OlgQSHW9Zw2lv8Y5wJ9+aNk2d4D0wfPZajQiyhCJIeHTF8Nn3zJLdLFEY8DrgCeWUxkJkhwVZF08tMKs3tATUkwkJ2BR0uHs/2JBL1f3MgL+bq5lJ9Xc4YnI1ixWO6IFWZx/wdclwplNY9VAEN4ZLG9o638w/2ZcBxa6hu
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(346002)(136003)(39860400002)(396003)(46966006)(36840700001)(54906003)(83380400001)(70206006)(426003)(36860700001)(70586007)(336012)(2906002)(47076005)(2616005)(44832011)(82740400003)(478600001)(8676002)(81166007)(356005)(8936002)(16526019)(186003)(6666004)(86362001)(82310400003)(1076003)(4326008)(26005)(6916009)(36756003)(5660300002)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2021 17:37:03.5754 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c75e2d0-958e-434e-ce35-08d91c7f0bed
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT064.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3434
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
Cc: Lang Yu <Lang.Yu@amd.com>, Eryk.Brol@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com,
 Bhawanpreet.Lakha@amd.com, Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>,
 bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Roman Li <roman.li@amd.com>

[Why]
On resume we perform DMUB hw_init which allocates memory:
dm_resume->dm_dmub_hw_init->dc_dmub_srv_create->kzalloc
That results in memory leak in suspend/resume scenarios.

[How]
Allocate memory for the DC wrapper to DMUB only if it was not
allocated before.
No need to reallocate it on suspend/resume.

Signed-off-by: Lang Yu <Lang.Yu@amd.com>
Signed-off-by: Roman Li <roman.li@amd.com>
Reviewed-by: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 9be4ebb5fac4..c582c424460a 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -981,7 +981,8 @@ static int dm_dmub_hw_init(struct amdgpu_device *adev)
 		abm->dmcu_is_running = dmcu->funcs->is_dmcu_initialized(dmcu);
 	}
 
-	adev->dm.dc->ctx->dmub_srv = dc_dmub_srv_create(adev->dm.dc, dmub_srv);
+	if (!adev->dm.dc->ctx->dmub_srv)
+		adev->dm.dc->ctx->dmub_srv = dc_dmub_srv_create(adev->dm.dc, dmub_srv);
 	if (!adev->dm.dc->ctx->dmub_srv) {
 		DRM_ERROR("Couldn't allocate DC DMUB server!\n");
 		return -ENOMEM;
@@ -2003,7 +2004,6 @@ static int dm_suspend(void *handle)
 
 	amdgpu_dm_irq_suspend(adev);
 
-
 	dc_set_power_state(dm->dc, DC_ACPI_CM_POWER_STATE_D3);
 
 	return 0;
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
