Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98098C4828E
	for <amd-gfx@archiver.kernel.org>; Fri,  2 Feb 2024 10:01:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E7E5110EC8A;
	Fri,  2 Feb 2024 10:01:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qmGo+/+F";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2079.outbound.protection.outlook.com [40.107.237.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5B7B110EC8A
 for <amd-gfx@lists.freedesktop.org>; Fri,  2 Feb 2024 10:01:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OGgDoqrbcXi3htuLK1IByz6AU768L1l/aijiSZQF3Ws+Fk4pdAy8PZosgg3VSeKHEeFsq67B18tNpsmNcSFf0A//i83gPdgYcPw17XGDB9R/46XFhWG0JDK1o/lZI1+OqQdNnHmLSWqbL/5LrDLtJaBfDOYrOeA3jYlj4upBtMSup8DFXje2E97G7xGyoCpucXCdrOJ4JCZMHjW8xSGt59F0+MdaTxVN6isfgSjCjbByWm1tgzroCykxXCHc3mG/Swy2jMTfItsC6ES4nTgtm9R6/2A4AEpTaMYs31vK6infP1D5NQGu8ZDDF9xvwo1fG0f+k0qMV45CgS655VNX4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Uej2Fgmz94VV+QrI0spXnRa2ve/b8GgWXqZ4ExX0G1U=;
 b=h3gUtVm9cz8hp7h+OOcLSFSgVApwU7EnYhkZwHq7qifUDu+JGcuDfWGEwOgyF8qAFPwMl2Y+LL2krUFVSzU5QKh2hYoNuj7RTe0oDZR031sPm4TbS18ISXYnZ5P4F1w00QW15NDRNb+YIr+g2hNm4KK42q0jE+6VtMDanXEIpSPdPtdAwAmrclumW5QCoG1KQ3xXTh5lWe7gvB4wLYCVYjaTWEmKBV6CyN99aI1sOrzUkXfM1O+NBpxB7T9qJQKSAwnso/z8bfGBJKn2irHJIL+oTdxA5zEdF0TD0N1b/E04GoJnMfzxWI2A5GIWaKOYj4YrKIUcr4HhJG+5bemnHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uej2Fgmz94VV+QrI0spXnRa2ve/b8GgWXqZ4ExX0G1U=;
 b=qmGo+/+FtE+b9gPxwZOy+jh+qnDvp0Nqnk7r1cjneXXVTGBx127V8O3D4+wPVIhWQXuJkDk2YbQNsvMsEe5cKesxaK5JY103mAzlVSMeEK+68Glwm0EQ7vNKdLe70lVOuNsy+ISpLeIZUmUSJg71ng9p/J7DpIEmzWmxkduJJUM=
Received: from CH2PR14CA0010.namprd14.prod.outlook.com (2603:10b6:610:60::20)
 by SA1PR12MB8094.namprd12.prod.outlook.com (2603:10b6:806:336::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.8; Fri, 2 Feb
 2024 10:01:48 +0000
Received: from CH1PEPF0000A34A.namprd04.prod.outlook.com
 (2603:10b6:610:60:cafe::bb) by CH2PR14CA0010.outlook.office365.com
 (2603:10b6:610:60::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.24 via Frontend
 Transport; Fri, 2 Feb 2024 10:01:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000A34A.mail.protection.outlook.com (10.167.244.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Fri, 2 Feb 2024 10:01:48 +0000
Received: from x570-ryzen9-5900x.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 2 Feb 2024 04:01:45 -0600
From: Saleemkhan Jamadar <saleemkhan.jamadar@amd.com>
To: <saleemkhan.jamadar@amd.com>, <leo.liu@amd.com>,
 <amd-gfx@lists.freedesktop.org>, <veerabadhran.gopalakrishnan@amd.com>
CC: <srinath.rao@amd.com>, <himanshu.nayak@amd.com>,
 <sathishkumar.sundararaju@amd.com>, Veerabadhran Gopalakrishnan
 <Veerabadhran.Gopalakrishnan@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: add ucode id for jpeg DPG support
Date: Fri, 2 Feb 2024 15:31:25 +0530
Message-ID: <20240202100126.3208200-1-saleemkhan.jamadar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A34A:EE_|SA1PR12MB8094:EE_
X-MS-Office365-Filtering-Correlation-Id: d2e0e695-457c-4086-8cb5-08dc23d5f85b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f4PqAnqpzzvvFMoV8RT+cjHOMynOG/42lTMCILMUpV6CxN0XvEizerMExFX3A8IWZthybzl9sH7FJoUcNo6pHa4g8Ens3h0EBDO1jA9LU6rwK1RvjPnNPmar1qSz94xGU5Ql2ilSlTptNC14uu3YY46hhJ+eZVF6P4XPVK1YJrCXgEeXlK4ei4JTdpJ11c2d+IFgfRkQv0AQUjv9fa9NFLlGkvSEzklK94iPKW2MyST6D7J/zwK1kG7+NYk5JxWVPKtAIn7o8QHvdPicJvzJCyTeil2K2BcU4aR6OL6q9FrrnO9TT/KtSHcgqfsnDPlZQe5wxXCRB1f988avIjg1SAzxd6SUOHEHvg8ykia07GsTc1HZfdugKvTyShCv4Jr5BuHBAzqbMynDzNfVs74PtGxQRzQfXqRlLo+EVuaNLiEnht44ZyDqm5HxXcR9rRKrkxQo7znGY/V2X17ZaqMi1ElH76kp4uEEFWbJ7kGID3jb5PizMACWtVbgmA4QmBHgqTYJYQUU2XXJvgGLHGXyJ5jKYm2QAmQBgsa6mDndEWZaYS1pEgLr7Lpoz+2scwshPMK8mN+Fdy+TIQvrHKyNAYwCuuiuCY31OLhekyygvv1tjwhMqDXPeJroJzoXi01L+YszTjGPBG29hQDS+BDzloWJ6Z9n0nKf8Ghkgyi85jzHztgGmflVU7deHxGgAIQBJxp4D5rhKeA3JkPaeVkSKXu09CEDHGY87n+urOGjJHb55kJdRE/bORlHthYHTtyYs6PJZYoHhpdxyA6tDw0hBA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(39860400002)(376002)(346002)(136003)(230922051799003)(451199024)(1800799012)(82310400011)(64100799003)(186009)(36840700001)(46966006)(40470700004)(41300700001)(86362001)(1076003)(16526019)(2616005)(8936002)(426003)(36860700001)(356005)(336012)(82740400003)(47076005)(26005)(81166007)(44832011)(2906002)(8676002)(316002)(7696005)(54906003)(5660300002)(6666004)(4326008)(70206006)(478600001)(70586007)(110136005)(6636002)(36756003)(40460700003)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2024 10:01:48.0898 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d2e0e695-457c-4086-8cb5-08dc23d5f85b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A34A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8094
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

add ucode id and cmd buffer for jpeg psp sram programming
and Jpeg DPG support.

Signed-off-by: Saleemkhan Jamadar <saleemkhan.jamadar@amd.com>
Reviewed-by: Leo Liu <leo.liu@amd.com>
Reviewed-by: Veerabadhran Gopalakrishnan <Veerabadhran.Gopalakrishnan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c   | 3 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c | 2 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h | 1 +
 drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h   | 1 +
 4 files changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 1bf975b8d083..91bcbb9958e6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -2462,6 +2462,9 @@ static int psp_get_fw_type(struct amdgpu_firmware_info *ucode,
 	case AMDGPU_UCODE_ID_P2S_TABLE:
 		*type = GFX_FW_TYPE_P2S_TABLE;
 		break;
+	case AMDGPU_UCODE_ID_JPEG_RAM:
+		*type = GFX_FW_TYPE_JPEG_RAM;
+		break;
 	case AMDGPU_UCODE_ID_MAXIMUM:
 	default:
 		return -EINVAL;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
index b14127429f30..433739a5393f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
@@ -678,6 +678,8 @@ const char *amdgpu_ucode_name(enum AMDGPU_UCODE_ID ucode_id)
 		return "UMSCH_MM_DATA";
 	case AMDGPU_UCODE_ID_UMSCH_MM_CMD_BUFFER:
 		return "UMSCH_MM_CMD_BUFFER";
+	case AMDGPU_UCODE_ID_JPEG_RAM:
+		return "JPEG";
 	default:
 		return "UNKNOWN UCODE";
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
index 4244a13f9f22..619445760037 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
@@ -511,6 +511,7 @@ enum AMDGPU_UCODE_ID {
 	AMDGPU_UCODE_ID_UMSCH_MM_DATA,
 	AMDGPU_UCODE_ID_UMSCH_MM_CMD_BUFFER,
 	AMDGPU_UCODE_ID_P2S_TABLE,
+	AMDGPU_UCODE_ID_JPEG_RAM,
 	AMDGPU_UCODE_ID_MAXIMUM,
 };
 
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h b/drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h
index 4bb5e10217bb..7566973ed8f5 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h
+++ b/drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h
@@ -296,6 +296,7 @@ enum psp_gfx_fw_type {
 	GFX_FW_TYPE_VPEC_FW1                        = 100,  /* VPEC FW1 To Save         VPE     */
 	GFX_FW_TYPE_VPEC_FW2                        = 101,  /* VPEC FW2 To Save         VPE     */
 	GFX_FW_TYPE_VPE                             = 102,
+	GFX_FW_TYPE_JPEG_RAM                        = 128,  /**< JPEG Command buffer */
 	GFX_FW_TYPE_P2S_TABLE                       = 129,
 	GFX_FW_TYPE_MAX
 };
-- 
2.25.1

