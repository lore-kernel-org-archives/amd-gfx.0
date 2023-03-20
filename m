Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46175C76195
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Mar 2023 17:38:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 26C7810E60D;
	Mon, 20 Mar 2023 17:38:31 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on20610.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7ea9::610])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF38510E600
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Mar 2023 17:38:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZHsnaP/JjS15d9LXgYZ6E3gYNplDyq2fARsL+vAfsQ5xVXAsHMqbuPnsXOHjmB35SDrIq/AU3BzFu68d2ncS0e3KUZC4M3csuX4pYDZS6Drjtf2hfNgAjBF+dy5PhgziSBggLfyj3fPC639LWDmqFHYp2wPKK+uLP/mXZ+w5gKxS0+RPXMO47qfakLx0EncVKthWNO1GgrdpLv9AjCaj+gjnU4oj23KU0S+yCCZxXaR6qKVVoFu2oHd8Q713hW+Q6weH2m9Yhhk7/pw9OtYWxlMc1cYuL6q+RtmFu9uq7Lk7GiZM5N9YA/XUbbjJ/JO1yT7p1Wi1KUgKMuNfGbsAVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eWJ5Z/aU+yOnmuaUBP2O0+l7owFFx1x+tDKzLIvxfcE=;
 b=J2pzteEdOwOHM/lSSWbtI71Fq820YMJZabw0ImsbPq4KcLkiih/brtDI46xGMs7ejMhPix+yUXeW3UNyARVBUqNhfJ25FHYzxGoVKaZyUOYlun+/9QO2Gp1Hz3muEHsIncnt9hhgMt//H6hjcupVzMt1EB+l8xnJyN/QwTX4M7l1Mb69/GhuJvZauD0DgQqjnXuze2HGldDPpD6GJQyzQ2j/tV49PbIqEzi8Nkt3zNK80lhfdyxtVMYQg2uNiYDE0VXyZCcAGQO5rxYQ7yG1YJOkyOlm1kTYlfEqzTwawoP6bcjfgDyczEyHzum93u85LO+dFdrgejvuveby+e2X8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eWJ5Z/aU+yOnmuaUBP2O0+l7owFFx1x+tDKzLIvxfcE=;
 b=qsY4FYKHiEE7aiC+okAyUq4+wDvP6uoU/NW81F0VHK21gooAxkku6WRxxN25dLfe+8zsymkgOeNbUIqQ26QniiVV4VsxbNmANj2al+D9R/e+iaCBX+iLu4WTDtL4+HKpNr5aBK6pi1XWpgTQ9BGuHt+rs0VrzlM8c1eItI02cRY=
Received: from MW4PR03CA0174.namprd03.prod.outlook.com (2603:10b6:303:8d::29)
 by DS0PR12MB8479.namprd12.prod.outlook.com (2603:10b6:8:155::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Mon, 20 Mar
 2023 17:38:26 +0000
Received: from CO1NAM11FT078.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8d:cafe::d3) by MW4PR03CA0174.outlook.office365.com
 (2603:10b6:303:8d::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37 via Frontend
 Transport; Mon, 20 Mar 2023 17:38:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT078.mail.protection.outlook.com (10.13.175.177) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6222.15 via Frontend Transport; Mon, 20 Mar 2023 17:38:25 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 20 Mar
 2023 12:38:24 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 01/11] drm/amdgpu/gfx11: add FW version check for new CP GFX
 shadow feature
Date: Mon, 20 Mar 2023 13:38:00 -0400
Message-ID: <20230320173810.250835-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230320173810.250835-1-alexander.deucher@amd.com>
References: <20230320173810.250835-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT078:EE_|DS0PR12MB8479:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a326dee-96ab-4fa3-0654-08db2969e8f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VuS0rRcQzSaH/8jVe+VTs//n/7M9Er3b7xlhoVxXNMW9cHpReW3BVSeNKawRyp3ahCP+aA7XT0As7M/2Y9ljPzba3Ye8kmWR6ybt0xw9IhuUW9WA0ZqHNwPAJAk7ldP7qmEyye5vBo6w2V6VKKDAnKpXMuWmDlgLndVbKWtdwHHfzDFFJjX+VXSOtaJi8w9WgyaVeX4C058Lo66dMwU8ppnhtsK28b3gAklKurE3p1m0dlcBzolZSk0fVrbPp1GvJOGzoeNrL9Sw3FlZRMByDIB6aG5QCL67uolSeYQi5lejWRnSBTNplacyyf4j1pJDjb/h5tnN3g4C9OvSTZ6EQrsPifS6OGs9RHmXmUAwRpVaY8ipdC/jtLl++flHMe4ur1fBwSim/L60UZydo+aIiDgdSaamhZgRq9YM1UD6QXcTnXTmuVXdcnPdF0H/9y5hdej12q1lr6bnfflTq5iiHiu/RCubf9Z1YZDP/Vv8oP3JgS7GaFd1dN0PeMnMHC88krQmADVcUrJCQ0+IcccfMXSFTwnxrc7spmJT/hwVmIMXDT7YnCIS0bQ6SDJi9V0mzD7yVCqjNPUiN2cJ+KWWNrwMSBO7gnstnXsR7m9MK4q91kobQER6gp7m1yvF0PfP3PIH1P05sF2wj8hwFsBXUB8JqkoTx8O4YqpdaG4O1D99giANYwVuBP0HKzsypm8A7loYS7Tj3VdxpXqHZJaDxBGy6iwLK0str5nNHLRZ1sI=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(136003)(39860400002)(396003)(376002)(346002)(451199018)(46966006)(36840700001)(40470700004)(82310400005)(86362001)(40460700003)(36756003)(40480700001)(83380400001)(4326008)(316002)(478600001)(70586007)(70206006)(6916009)(8676002)(186003)(1076003)(26005)(336012)(2616005)(47076005)(6666004)(16526019)(426003)(356005)(7696005)(2906002)(36860700001)(8936002)(5660300002)(81166007)(41300700001)(82740400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2023 17:38:25.8302 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a326dee-96ab-4fa3-0654-08db2969e8f7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT078.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8479
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

Use this to determine if we support the new SET_Q_PREEMPTION_MODE
packet.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h |  2 ++
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c  | 13 +++++++++++++
 2 files changed, 15 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
index de9e7a00bb15..4ad9e225d6e6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -364,6 +364,8 @@ struct amdgpu_gfx {
 
 	struct amdgpu_ring		sw_gfx_ring[AMDGPU_MAX_SW_GFX_RINGS];
 	struct amdgpu_ring_mux          muxer;
+
+	bool				cp_gfx_shadow; /* for gfx11 */
 };
 
 #define amdgpu_gfx_get_gpu_clock_counter(adev) (adev)->gfx.funcs->get_gpu_clock_counter((adev))
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index ecf8ceb53311..a0d830dc0d01 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -463,6 +463,18 @@ static int gfx_v11_0_init_toc_microcode(struct amdgpu_device *adev, const char *
 	return err;
 }
 
+static void gfx_v11_0_check_fw_cp_gfx_shadow(struct amdgpu_device *adev)
+{
+	switch (adev->ip_versions[GC_HWIP][0]) {
+	case IP_VERSION(11, 0, 0):
+	case IP_VERSION(11, 0, 2):
+	case IP_VERSION(11, 0, 3):
+	default:
+		adev->gfx.cp_gfx_shadow = false;
+		break;
+	}
+}
+
 static int gfx_v11_0_init_microcode(struct amdgpu_device *adev)
 {
 	char fw_name[40];
@@ -539,6 +551,7 @@ static int gfx_v11_0_init_microcode(struct amdgpu_device *adev)
 	/* only one MEC for gfx 11.0.0. */
 	adev->gfx.mec2_fw = NULL;
 
+	gfx_v11_0_check_fw_cp_gfx_shadow(adev);
 out:
 	if (err) {
 		amdgpu_ucode_release(&adev->gfx.pfp_fw);
-- 
2.39.2

