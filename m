Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18FE1C433F5
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Mar 2022 07:20:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9AD4710E393;
	Tue,  1 Mar 2022 07:20:23 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2072.outbound.protection.outlook.com [40.107.243.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3B37210E3AF
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Mar 2022 07:20:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M5AgVVI15LapVAPeygDr/SdaUyMZEicxcreRltUHS3RQ538vTRgo4w9bBUhn+St6x3zoGG30HntO5C98+VdHhw/4qD65MnrWdvECuHNrKAIDceriUuZ7LXDxNpDrMYZJ2fUueBcqn2TFF5fgz/aeRmtrHfpoWulVMWX4YQGd12V31feZ8uOfkc1lP4e6FcStOqxLazNePMBkBb71G+8TiDcTI+vJ46Ssy4hj1bf0KL/BfEbEGLNX944D1nn4U4CFeI20mQCFr0srVZoTcjjE6giByOpmopMMijecYQy17YVUFcvL89C0Rw31fMkBinJweGn2Nvyq3qLxe7GmlTEIVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zvUWQ0F6XWi8mjb8HnU8j02NhG2ezQKWaG0xjfygm9E=;
 b=PBr31FfldIPtlcXNyvOpIo3OOb4SbQ9C75SD/TYTw0XvWdQRDYOykyLdre2Os/d0uAicrtmwaLN7kX7tq7Hf60TvVL6qz253soBAWw5bHjvOUAnlv1EZbac84T0y4LfbDqRDm2LkY09KQOMLbZquP6+yQvhVTLlaidF/FAQQi2KSrf7J3TXdpJjl4Y2qdKEz0Rj0/OJVnVIYlORDHAlOLkQFZcnQZQ+gv51wzkUABacxy1CT8wRegpYcupPHeGBrYS20f0zS4+NyG3QKdNTrQcHKidE1sVDXvAU+jb+sW5smUm92sR+LJATtwN/ublqGN9J7vmoZDk9Dv4CsihuCkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 165.204.84.17)
 smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=temperror action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zvUWQ0F6XWi8mjb8HnU8j02NhG2ezQKWaG0xjfygm9E=;
 b=wubo8YPaUreJ1uBU1atuVJPN9UCiWOo8hyrNMt0KesJ8VrBFcpyGOXYnlWIvw0SLKiCs/v0bwiGloj2NLvwePq+6OvKL5zL8TczIzuq/J1NntwStiRc3u1h6cWQuSDhvPxBttqxCJ9IyvTid86zknTzjFlG58UrOj+GKNmzWUHc=
Received: from BN9PR03CA0986.namprd03.prod.outlook.com (2603:10b6:408:109::31)
 by CY4PR1201MB0183.namprd12.prod.outlook.com (2603:10b6:910:20::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.27; Tue, 1 Mar
 2022 07:20:20 +0000
Received: from BN8NAM11FT037.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:109:cafe::e9) by BN9PR03CA0986.outlook.office365.com
 (2603:10b6:408:109::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.21 via Frontend
 Transport; Tue, 1 Mar 2022 07:20:20 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=temperror action=none header.from=amd.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of amd.com: DNS Timeout)
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT037.mail.protection.outlook.com (10.13.177.182) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5017.22 via Frontend Transport; Tue, 1 Mar 2022 07:20:18 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Tue, 1 Mar
 2022 01:20:18 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Mon, 28 Feb
 2022 23:20:17 -0800
Received: from yzha-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.18
 via Frontend Transport; Tue, 1 Mar 2022 01:20:15 -0600
From: Yifan Zha <Yifan.Zha@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Bokun.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: Move CAP firmware loading to the beginning of PSP
 firmware list
Date: Tue, 1 Mar 2022 15:19:14 +0800
Message-ID: <20220301071914.1624490-1-Yifan.Zha@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0247f64e-ec46-4620-ca53-08d9fb53f095
X-MS-TrafficTypeDiagnostic: CY4PR1201MB0183:EE_
X-Microsoft-Antispam-PRVS: <CY4PR1201MB01837158EB847A421195DD07F9029@CY4PR1201MB0183.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UvgP8osgMVcb6y8N8lECAZIZT+bGUkN5qQVaBqjkaAU45INHiHq4THNsq5nG7xsdKYPWCQuE8MT6O/XdljXQwte72bi0fu9d3f0Nq/DrcfRYK5QsEnJmUweYqk/fVrSVTELPCuIBqlN2mC3DD45sXuWRKUJjVix1NQayDL0uzmO8mGiapYXRydaEmkv0ksqQkhKroMmwYA7VjWZ07wPJ9RFaQNPg+j1YGX7OsXgKFBxemzkO3Z8HMbHCKEy9W7DUoqOQ8tw5598cTa9+uB4UrJQYdwZ3GGu1p5d6JP7hJvpKz+rcCSPfhsn8prYlAB+dmcfFn/+FpAtPxng49+VGalmCQv4ArX2kYoEPTM/ILGW2adI1So9S9dEi27NxSZYRmof+6cSP9Tg5vbFbDAbn0/0/6mur1ZAztppu/vuskdhgd/LP0IOIwabtRYCYBg+6nsUHhVm6XWlE+tEuww44dyk1ezVgaw5ZRUnE3oo7QyXPB0PD0o/iAEP2bRh+VkuGVh179ki8ieNf+iAbd4gNJ6mKBow1X7KHeMyPorUzOeaDv1Y2qkXC40w7+bWawbqxhM7VLpxGu8keDetqXmBbPOPFXR0lREs43QWgqUD54xvQE5RsROOtrBLRe8KPQ9TUMd5Cmd9a/F3nwIJvUVNpVufKN1voOT2ofOvzvZF7PYw3RcIbBpSzh9QfrEpOXhMw32mE6i/7+l772D2+Z4/dTw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(63370400001)(63350400001)(83380400001)(1076003)(26005)(186003)(2616005)(336012)(426003)(81166007)(356005)(82310400004)(47076005)(36860700001)(5660300002)(8936002)(2906002)(40460700003)(4326008)(508600001)(7696005)(70586007)(70206006)(8676002)(316002)(54906003)(6636002)(110136005)(86362001)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2022 07:20:18.6216 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0247f64e-ec46-4620-ca53-08d9fb53f095
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT037.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0183
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
Cc: Yifan Zha <Yifan.Zha@amd.com>, Jingwen.Chen@amd.com, Monk.Liu@amd.com,
 Guchun.Chen@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why]
As PSP needs to verify the signature, CAP firmware must be loaded first when PSP loads firmwares.
Otherwise, when DFC feature is enabled, CP firmwares would be loaded failed.

[ 1149.160480] [drm] MM table gpu addr = 0x800022f000, cpu addr = 00000000a62afcea.
[ 1149.209874] [drm] failed to load ucode CP_CE(0x8)
[ 1149.209878] [drm] psp gfx command LOAD_IP_FW(0x6) failed and response status is (0xFFFF0007)
[ 1149.215914] [drm] failed to load ucode CP_PFP(0x9)
[ 1149.215917] [drm] psp gfx command LOAD_IP_FW(0x6) failed and response status is (0xFFFF0007)
[ 1149.221941] [drm] failed to load ucode CP_ME(0xA)
[ 1149.221944] [drm] psp gfx command LOAD_IP_FW(0x6) failed and response status is (0xFFFF0007)
[ 1149.228082] [drm] failed to load ucode CP_MEC1(0xB)
[ 1149.228085] [drm] psp gfx command LOAD_IP_FW(0x6) failed and response status is (0xFFFF0007)
[ 1149.234209] [drm] failed to load ucode CP_MEC2(0xD)
[ 1149.234212] [drm] psp gfx command LOAD_IP_FW(0x6) failed and response status is (0xFFFF0007)
[ 1149.242379] [drm] failed to load ucode VCN(0x1C)
[ 1149.242382] [drm] psp gfx command LOAD_IP_FW(0x6) failed and response status is (0xFFFF0007)

[How]
Move CAP UCODE ID to the beginning of AMDGPU_UCODE_ID enum list.

Signed-off-by: Yifan Zha <Yifan.Zha@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
index 428f4df184d0..40dffbac85a0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
@@ -343,7 +343,8 @@ union amdgpu_firmware_header {
  * fw loading support
  */
 enum AMDGPU_UCODE_ID {
-	AMDGPU_UCODE_ID_SDMA0 = 0,
+	AMDGPU_UCODE_ID_CAP = 0,
+	AMDGPU_UCODE_ID_SDMA0,
 	AMDGPU_UCODE_ID_SDMA1,
 	AMDGPU_UCODE_ID_SDMA2,
 	AMDGPU_UCODE_ID_SDMA3,
@@ -378,7 +379,6 @@ enum AMDGPU_UCODE_ID {
 	AMDGPU_UCODE_ID_VCN0_RAM,
 	AMDGPU_UCODE_ID_VCN1_RAM,
 	AMDGPU_UCODE_ID_DMCUB,
-	AMDGPU_UCODE_ID_CAP,
 	AMDGPU_UCODE_ID_MAXIMUM,
 };
 
-- 
2.25.1

