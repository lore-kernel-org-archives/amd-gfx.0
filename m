Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FB63E936ED
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Oct 2023 20:23:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4032210E1AF;
	Wed,  4 Oct 2023 20:23:18 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2066.outbound.protection.outlook.com [40.107.92.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0C64310E1AF
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Oct 2023 20:23:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y1RqWapEkGpf4kRphFVKNkyAtOmMzA6o+cp26V8hCAAFUdy3Nss56/hh74RInU2G3uIgWLbuQN3cMAfRdyZbywlQCBEMEED3ubewxeN7okLC0XuS/cljgZ65+W+W27vv6kndJ9g3DUaVIJVBhhpk1fmeLLgi81SvXzgkLCA5mYqTZdbIpSm8hhCiimArnGoDrM4F3sVri/TU3tKxmp3MNb4HNzXR2ILoanJvOsb3NO6g/v/KzxlR+bV8mQ823W7Hl/1hfNFZq6id9bBHchH6cIXoYswiS1/RVqWUfl/Zte73+VugRA97Lwaw3XBmWhcezURkoKD8a7Q8YKzNDP1lEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pl1QDvvWFNHPhqHlJs2thW0rviVcPGk8PEyDPsd4FIM=;
 b=IilC+K6BveusQmI+51QrU22zAHLL7HGKS6NCGZJSg9gDiqrtYxOg3IFYaGgps2MN63q0pEKaUAWLNYzVqjxjnu1qp12S1LZ6Bu49S/r2bK7U7onzUuHiuyJMWzylEG7NsYT0WDWtzk/E5P8pKm3RiwchjLM6izsyiiTEF90wOPeHueVGBco3eDknHmsR0rgLWfZW5EbhfrSO4FV0OLhu9Pj9+t7GEb5j3xpYOzfCJDJYcaDFYwWKdNhrwxcUJ7KAI9xoYygQ7O2l30kE/NK7GydOGLm/qN77O5Vb1ZXWBGUx8VsSautmNWH4i4B79/Et82ffPbjf8UxEbckiiXx8Zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pl1QDvvWFNHPhqHlJs2thW0rviVcPGk8PEyDPsd4FIM=;
 b=IvGdic2INkRA8sNGUiamLcViLTsNm6bFQzFLEJSbOhpHEA0NWAg0bS8TGXB1E4XLfz28vMtzzgtc4cNwIbx1i8kKSO4ZcenEhf0LBJxpnd57iDXcfO5VdgMbxPg72x8PXt8xCvXri9BKThg11py94cYf5GLV3S7rj/FN8Wy0dRc=
Received: from MN2PR16CA0019.namprd16.prod.outlook.com (2603:10b6:208:134::32)
 by IA1PR12MB8079.namprd12.prod.outlook.com (2603:10b6:208:3fb::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Wed, 4 Oct
 2023 20:23:12 +0000
Received: from BL02EPF0001A0FF.namprd03.prod.outlook.com
 (2603:10b6:208:134:cafe::aa) by MN2PR16CA0019.outlook.office365.com
 (2603:10b6:208:134::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.33 via Frontend
 Transport; Wed, 4 Oct 2023 20:23:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A0FF.mail.protection.outlook.com (10.167.242.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Wed, 4 Oct 2023 20:23:12 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 4 Oct
 2023 15:23:11 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/radeon: Fix UBSAN array-index-out-of-bounds for
 Radeon HD 5430
Date: Wed, 4 Oct 2023 15:22:53 -0500
Message-ID: <20231004202253.182540-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231004202253.182540-1-mario.limonciello@amd.com>
References: <20231004202253.182540-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FF:EE_|IA1PR12MB8079:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c63d210-eabe-4dd3-e6bb-08dbc517bb99
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DW8KIIQaVV1h7s8NZ31mdW4DvYwQjB0tlV5ltv7IlitB5+yZULmA3swcFWnbUXPFSysCqpcyOmJytVIfGFOveV74m0ccPta74wpUpFnInqGTc2yTON07DqaRXMPA6FojBzagh2dECuoH5rPO5CoQTC899FSH0sqiaoPQ8+JFLmR/A8N6DLDyqxhlH7ePDeqP/BJe2SBTiCMKmtRdlIvmxbavAE6+6Jjc4jNmrwbQ7CQyeQYe15SfrvekQB37giODKwtps4ztWuu8YO6/3aM2x2JPMkz7GfWZBU+2H3UnXqBCRhMQldkDV7bYNI6r8JaBrs3iDfIjUbtoSpp0TbSN7gGTxB7oT84sM99uz4Rd3ztnpVPW+BphJEVV1weqknCmJqCJeB7rD9jK5W6aRZUm+1hor0VE6tjClBOEI1vT/fKWwbwZVsR6ml9hYS1/54uhQH1QVmPXR5dsrLqhN97ROYbJPFVk+nWVGykzau0o0mrGiOLi+DNA+6sdICpiv8NM0Y3kXvJ48cHTrCOSInp0YmSn1Lb1qv8uA+geUPSfxMobkjuR4IqCkU5k1pjrN3wCezR4mfROD/iynVDWblJVUEdsbWrSeWzz4bsKKGaZTRn/86LBaQXDaq/yU82aqpg6kecPAidXR15/PON7hXnJwKs0GwmUQWoWrVy1KW18bGLGgL7eaya6D7EQzi1qeVGwRcPcAcOBWz+YGs7H0Q8QlJ8HskeFAupHIm52vxB1FgOOh3kCjAN9uH18iit6DWqY
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(396003)(346002)(136003)(39860400002)(230922051799003)(64100799003)(1800799009)(186009)(82310400011)(451199024)(46966006)(40470700004)(36840700001)(40460700003)(16526019)(36860700001)(36756003)(8936002)(44832011)(86362001)(83380400001)(5660300002)(8676002)(4744005)(2616005)(6666004)(426003)(26005)(1076003)(336012)(4326008)(47076005)(82740400003)(7696005)(356005)(81166007)(40480700001)(70206006)(2906002)(966005)(478600001)(41300700001)(54906003)(316002)(6916009)(70586007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2023 20:23:12.4933 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c63d210-eabe-4dd3-e6bb-08dbc517bb99
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8079
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
Cc: Felix Held <felix.held@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

For pptable structs that use flexible array sizes, use flexible arrays.

Suggested-by: Felix Held <felix.held@amd.com>
Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2894
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/radeon/pptable.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/radeon/pptable.h b/drivers/gpu/drm/radeon/pptable.h
index 4c2eec49dadc..94947229888b 100644
--- a/drivers/gpu/drm/radeon/pptable.h
+++ b/drivers/gpu/drm/radeon/pptable.h
@@ -74,7 +74,7 @@ typedef struct _ATOM_PPLIB_THERMALCONTROLLER
 typedef struct _ATOM_PPLIB_STATE
 {
     UCHAR ucNonClockStateIndex;
-    UCHAR ucClockStateIndices[1]; // variable-sized
+    UCHAR ucClockStateIndices[]; // variable-sized
 } ATOM_PPLIB_STATE;
 
 
-- 
2.34.1

