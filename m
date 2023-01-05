Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60EBBC46467
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Jan 2023 01:04:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6727810E48A;
	Thu,  5 Jan 2023 01:04:39 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2082.outbound.protection.outlook.com [40.107.223.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DD07610E48A
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Jan 2023 01:04:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iTniUmGLiQWQyUJHchDAhW7Gyej/pPTeb1CK7Y9NL1bz2ysDk8u2eZmQAY86ROc/Y837GW/r+j9SRycgSvAO54kEpRsRtQ4ff7d4MPHQBTWakdREzXgfGZ4Su2qcuAwMrvULxfgFNlLhTkzFnC9rP9fVZhEbSt/2GXncjV0RJxC0bXQGkRJsoHdFK2/Ysfk9mVcZzfJcWi9Oi+vrFOcjnCeHvIzNhGnnYJPyDpHT2IdsuzdUqYAdFsBBQS+xU2wZT6bfXaoFXzmPrr4UupC+IyvzYXMHsbRqE007jj5FiWrWhwfrYJk3JjA5iNJpZ2NhCeWRIf+cldGKyExplaJbIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OLRIe28/dTnHHhu+z92PAdEVwR/Uir9nyVPLXfwReE8=;
 b=R26gLwMCqhH2BYAufik/c3IfAqx9+lm3+PFCk/edbsW6cn4R12lkDxiF8TJ5Gv3YbLl32gwJLiFPAofWlOCQpsXx5cMQkk8yKST0+qpN2kq3ZY0q5Qu8/chNA3sLlZ51AY0D/JmSDeNFGfmjJGzdMBESKlrgJzOZpvm2Md0i43EplMNdd+ngmLkWL36ELaPPkfaLEVeejNMSCyexT2MbyRYcQqIbKN1R7T68tdg+MrWeK1Vu98KQJ9X94dffpnZUtBXbjFKCnBi3gBkzYY+VVc9kI1wQbT5XtQFQX7R4yMlsaMsxf26Fjpdv+6lXEki/pAGegLkx31f+GwkzRc4xGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OLRIe28/dTnHHhu+z92PAdEVwR/Uir9nyVPLXfwReE8=;
 b=3u+ZBcoyQTGLgmX8a9M1B74wkfsjzElqhqGWczQvwZo+lncio0FSgJ6Z2M/uPG25I92JLAyfLMQOdQPLUAXOgC7dc7wcsGX5TiSPBoumgTLBlL6mgtohyL//VRJJGurNg8UvVr5X+CngVydb4JBhN6KKp7D+73mvKWvgWKpi5yQ=
Received: from MW4PR03CA0288.namprd03.prod.outlook.com (2603:10b6:303:b5::23)
 by BY5PR12MB4919.namprd12.prod.outlook.com (2603:10b6:a03:1d6::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Thu, 5 Jan
 2023 01:04:32 +0000
Received: from CO1NAM11FT100.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b5:cafe::7) by MW4PR03CA0288.outlook.office365.com
 (2603:10b6:303:b5::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5966.20 via Frontend
 Transport; Thu, 5 Jan 2023 01:04:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT100.mail.protection.outlook.com (10.13.175.133) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5944.17 via Frontend Transport; Thu, 5 Jan 2023 01:04:31 +0000
Received: from aaliu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 4 Jan
 2023 19:04:29 -0600
From: Aaron Liu <aaron.liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amd: update securedisplay_cmd to ta_securedisplay_cmd
Date: Thu, 5 Jan 2023 09:04:01 +0800
Message-ID: <20230105010401.2216819-2-aaron.liu@amd.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230105010401.2216819-1-aaron.liu@amd.com>
References: <20230105010401.2216819-1-aaron.liu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT100:EE_|BY5PR12MB4919:EE_
X-MS-Office365-Filtering-Correlation-Id: ceee448f-1b05-46b7-cfe2-08daeeb8cd97
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l+yejAZ4dIlcF5646asF0E9YEgTtbydx+vDCjzvgzp4lTN4rmSE+2RqHjp1o5A2j6HaOZLSNsNcr+hGQYE+HZZUHhvwiCoclAVfiS8XXmzKVK2/zQtqWeT0tWwdnxSTIkS6uT2dDtiVwj2rw0gEclFl+M1cldsZiDC/pDHKM2xVMvTvKfD2tZ7ueUBwaK8CX0wwBaIuUMfmryN+VmYXEOH5a6Fr9E8febbEzgv3tlaw8ddUGPEyzgItIQhjnKpRxaNGGrne9GvWkwPLioK/bQo2USJoXN6Pj3UNmqW00lKuZquHSk8rk9gORe/n4Fi2jrXW41bxY8btD/nGw8Nh60/06Skyx5ae7gJt3Vyu8G+la6j8jftABSxQ0xe49Jp0Qao1B2C98nS6Eme6yAr4EXMizN2YA9vDAFHQ4pvnNqOEfjKRG0eLTflsOoi9Fhu+m5vXSU/ezvHr20DLJKsJuMuvtsw5n7FO77TB+PKVd47NMDMjfzCraefNXvwtquYMlvtLMCb8O/33Ee+5obf2xiiJK7dnFuLa/MTOUAG5GMifv0lW479XdxHwvg5dp/Got8LASMGhDQ8usG82W50TQhtshuhip5Zq16HabzyrsleU/d/8TmKHWZ0AvzkxMd/mCeMa7eMBY7S4tWlzDXV3sBqYPP2pc+DwV85x+CiBLZUL0KUnWJRdZZbbH5MT5GtjUVJSTjVTziz+Eq00dVkaga01s7jixZ7xV2Sxxv0huTCU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(39860400002)(136003)(396003)(346002)(451199015)(36840700001)(46966006)(40470700004)(70586007)(316002)(6916009)(186003)(70206006)(2906002)(4326008)(54906003)(5660300002)(44832011)(478600001)(26005)(41300700001)(16526019)(6666004)(7696005)(426003)(40480700001)(86362001)(36860700001)(83380400001)(336012)(2616005)(82740400003)(81166007)(1076003)(8676002)(40460700003)(36756003)(8936002)(356005)(47076005)(15650500001)(82310400005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2023 01:04:31.5455 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ceee448f-1b05-46b7-cfe2-08daeeb8cd97
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT100.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4919
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
Cc: haoping.liu@amd.com, Alexander.Deucher@amd.com, shane.xiao@amd.com,
 Aaron Liu <aaron.liu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This patch updates securedisplay_cmd to ta_securedisplay_cmd
starting from amd-ta_securedisplay-v27.00.00.08.

Signed-off-by: Aaron Liu <aaron.liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c               | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_securedisplay.c     | 8 ++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_securedisplay.h     | 2 +-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c | 2 +-
 4 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 0706afb11577..2bebda7de604 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -1907,7 +1907,7 @@ int psp_rap_invoke(struct psp_context *psp, uint32_t ta_cmd_id, enum ta_rap_stat
 static int psp_securedisplay_initialize(struct psp_context *psp)
 {
 	int ret;
-	struct securedisplay_cmd *securedisplay_cmd;
+	struct ta_securedisplay_cmd *securedisplay_cmd;
 
 	/*
 	 * TODO: bypass the initialize in sriov for now
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_securedisplay.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_securedisplay.c
index 2c1d82fc4c34..8ed0e073656f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_securedisplay.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_securedisplay.c
@@ -77,11 +77,11 @@ void psp_securedisplay_parse_resp_status(struct psp_context *psp,
 	}
 }
 
-void psp_prep_securedisplay_cmd_buf(struct psp_context *psp, struct securedisplay_cmd **cmd,
+void psp_prep_securedisplay_cmd_buf(struct psp_context *psp, struct ta_securedisplay_cmd **cmd,
 	enum ta_securedisplay_command command_id)
 {
-	*cmd = (struct securedisplay_cmd *)psp->securedisplay_context.context.mem_context.shared_buf;
-	memset(*cmd, 0, sizeof(struct securedisplay_cmd));
+	*cmd = (struct ta_securedisplay_cmd *)psp->securedisplay_context.context.mem_context.shared_buf;
+	memset(*cmd, 0, sizeof(struct ta_securedisplay_cmd));
 	(*cmd)->status = TA_SECUREDISPLAY_STATUS__GENERIC_FAILURE;
 	(*cmd)->cmd_id = command_id;
 }
@@ -93,7 +93,7 @@ static ssize_t amdgpu_securedisplay_debugfs_write(struct file *f, const char __u
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)file_inode(f)->i_private;
 	struct psp_context *psp = &adev->psp;
-	struct securedisplay_cmd *securedisplay_cmd;
+	struct ta_securedisplay_cmd *securedisplay_cmd;
 	struct drm_device *dev = adev_to_drm(adev);
 	uint32_t phy_id;
 	uint32_t op;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_securedisplay.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_securedisplay.h
index fe98574748f4..456ad68ed4b2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_securedisplay.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_securedisplay.h
@@ -30,7 +30,7 @@
 void amdgpu_securedisplay_debugfs_init(struct amdgpu_device *adev);
 void psp_securedisplay_parse_resp_status(struct psp_context *psp,
 		enum ta_securedisplay_status status);
-void psp_prep_securedisplay_cmd_buf(struct psp_context *psp, struct securedisplay_cmd **cmd,
+void psp_prep_securedisplay_cmd_buf(struct psp_context *psp, struct ta_securedisplay_cmd **cmd,
 		enum ta_securedisplay_command command_id);
 
 #endif
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c
index ad73e5855580..8841c447d0e2 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c
@@ -103,7 +103,7 @@ static void amdgpu_dm_crtc_notify_ta_to_read(struct work_struct *work)
 {
 	struct secure_display_context *secure_display_ctx;
 	struct psp_context *psp;
-	struct securedisplay_cmd *securedisplay_cmd;
+	struct ta_securedisplay_cmd *securedisplay_cmd;
 	struct drm_crtc *crtc;
 	struct dc_stream_state *stream;
 	uint8_t phy_inst;
-- 
2.39.0

