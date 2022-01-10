Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A1BDC433FE
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Jan 2022 23:39:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1AEA310E663;
	Mon, 10 Jan 2022 23:39:23 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2064.outbound.protection.outlook.com [40.107.96.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AD9C010E663
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Jan 2022 23:39:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q8O/DiOSZGHUcTSmGIZHuSgbxBCHkDUxG4+w/gjKgFpprflJ98ywgil5dlcWIVEcap3ntxEabksfoupU3TLoTIpffxfehBcz474J6gmCW4vp/DVqtmPOFo5BGPYynF+VsNoC7rnY4tykHyHNBrNkEWM+P0ZNW3uxV+tY5yYzehTc0TDAI0D9tgpzCKVO1KKsUQrDvXtotbGhNChNKPSgZyBmSE1AzgyA24vX1CEz6pdFCuoUSf4NcboNDGLVHOiI3TiY4ea5dcwfnb+Elbg6zBU6ezVPACSJ6EnJdxzSx30ci0Ip+PX8Eka+WcnsR7JCBpwDGq3uI7CF6O01yfSJrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HV07DZh10dBNVx0G3qBKMrJ+3Uok1pgl0/zpC6HpPL8=;
 b=miHj9lgubXr1yRatrGdOEfc9/oNb/yPRsQArcqg3vW/TrhCL0qcC6K5CyJ0TniqmEVJsEXhEeLIYLOgur0DyqRKDVemgMmF+AS5X6XmTqXSHyHlNXoeW3IlRMkHefqLo1q6AcAQERrfTlv8V4KHHRfVwAelJ70wg/PQPUbkg12ZPzVi+Nbm8lu0obh/eSj6VVrQk8/XStZcOBdB5CCEyJx0fxfH3vq+Qp4lUPZRI4vE72rTNdReV5sb5KDZ4camizHGP/ej8JRB+xuHM3rjX6+ubuWWXK+5K0XuVzY91o7e0edFGprYVY/YTeCExSAuzXy3uUdvWUdR1pMBpguOj1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HV07DZh10dBNVx0G3qBKMrJ+3Uok1pgl0/zpC6HpPL8=;
 b=PwwTcPClg9O075XUMUKd6owh9CSjaadJzK9UaoKQHkXZyV1a7bBbaAne4455r6DUQdbV/L177EICCq5GAGbJFNEwXktC5m+7OOVH42kcjmV9ADhm/ook/UwXV6UTHAyuOO81CKc/ouL/c/HJa23iZWp/ruVyVwmkUVSJBEil0sg=
Received: from BN1PR13CA0020.namprd13.prod.outlook.com (2603:10b6:408:e2::25)
 by CH2PR12MB4921.namprd12.prod.outlook.com (2603:10b6:610:62::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.11; Mon, 10 Jan
 2022 23:39:18 +0000
Received: from BN8NAM11FT045.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e2:cafe::d0) by BN1PR13CA0020.outlook.office365.com
 (2603:10b6:408:e2::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.8 via Frontend
 Transport; Mon, 10 Jan 2022 23:39:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT045.mail.protection.outlook.com (10.13.177.47) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4867.9 via Frontend Transport; Mon, 10 Jan 2022 23:39:18 +0000
Received: from atma2.hitronhub.home (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Mon, 10 Jan
 2022 17:39:17 -0600
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, Harry Wentland
 <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>
Subject: [PATCH 1/4] drm/amdgpu: Treat warning as an error
Date: Mon, 10 Jan 2022 18:39:03 -0500
Message-ID: <20220110233906.1178021-2-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220110233906.1178021-1-Rodrigo.Siqueira@amd.com>
References: <20220110233906.1178021-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8871f011-6674-4629-287d-08d9d4926b6c
X-MS-TrafficTypeDiagnostic: CH2PR12MB4921:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB49217C2FA2BF7B4B0001723898509@CH2PR12MB4921.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:254;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9EBd+VuKZ2IIGvRa17x++KS1psh/C3Z9XI9UU4gZICUPLZoR9PrwXdyDSC6DLfkKj8DKCPH4UVniU9U475oI6LYPuJLWNF2VTcrt9AsvsYsiiN77JLtOLk1wP9ZgUTw0KrhArOS6stH4TCGMWebxq3f81G34O7nDcGzyTtRI6+76X1ZpRAvrcf6vEGtHTO0htIcKiTN7HDz3oTq2lM2DwTZgkx0Euv+/q/dObEDxLNQ4QigtLt2u+yZQndmVTKcKzOfF2XwhyeCtcu1tyXs0jbkb+iiRQhjVXbV1BAz5V+6febVKJe4MZBI5s81lNiuwbNDD6KEEW0hnfGBzX91Kp0FCHzIO5hNMgk2VhRzPmuJ6Hw/9zUs3+nq15BYl7wRJv5hAqWs86G24TQKS+TZWvDHY1JrP5ksTFeK5saYZgwKwxvcR06Svf4X0Myxqh/X6ej0DEcoCpFcfo/fC9Njf8vrO8RMyjlrAOsmpzg2vEUcEIUuKvZi8/ig12edK/3TXWBiBIsVTDNhubDLZxlu49nTtjotqfhfyw5bDhUY6iGJt9VcAHsoPX3zv3EtgjXC6xxCejPpuY2jxP+FXFCM7hE+/odP7J88uxrdj9rh3nQYp63KDdvHMqszvlHouSruyq5BLdKlp5TGnJmoyotmrBoeYsDzzotRND+lO+jW9xUGKyInEa3jdM41m8okBZeReTaNj1qhSmU90mU71bZUfSle0BYriwrLqIgWivqIJF7D4mGqNdCVKbacPu5fLlhGoUfitdnx+jPYstg2MXpEDYCOWDSDsuc+9UluLg9emQzM=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(40470700002)(46966006)(36756003)(110136005)(86362001)(1076003)(47076005)(4326008)(4744005)(70586007)(70206006)(6636002)(186003)(16526019)(316002)(26005)(36860700001)(336012)(5660300002)(8936002)(8676002)(2616005)(2906002)(356005)(6666004)(82310400004)(40460700001)(81166007)(508600001)(426003)(83380400001)(54906003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2022 23:39:18.1731 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8871f011-6674-4629-287d-08d9d4926b6c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT045.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4921
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
Cc: nicholas.choi@amd.com, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

We have one internal CI that builds our kernel with the -Werror flag; as
a result, when we try to sync our branch with amd-staging-drm-next we
get some failures due to warnings. This commit tries to alleviate this
problem by forcing a warning to be treated as an error.

Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
index 7fedbb725e17..158f427c2f2e 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -27,6 +27,8 @@ FULL_AMD_PATH=$(srctree)/$(src)/..
 DISPLAY_FOLDER_NAME=display
 FULL_AMD_DISPLAY_PATH = $(FULL_AMD_PATH)/$(DISPLAY_FOLDER_NAME)
 
+subdir-ccflags-y += -Werror
+
 ccflags-y := -I$(FULL_AMD_PATH)/include/asic_reg \
 	-I$(FULL_AMD_PATH)/include \
 	-I$(FULL_AMD_PATH)/amdgpu \
-- 
2.25.1

