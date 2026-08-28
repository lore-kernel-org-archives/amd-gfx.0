Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A779AC61DBD
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Aug 2026 14:32:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 38EB410E197;
	Fri, 28 Aug 2026 14:32:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="uhBF0hhr";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012029.outbound.protection.outlook.com [52.101.48.29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D0F7110E197
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Aug 2026 14:32:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=faoJg1AieZVXYj30dHgjDPWuG0B539HAydMXyRAlGEWs3Ya1Nm1rWZjW/fHry9aUk24pSa3SeFk4LO5+m/WLn5YxKMFTYVFkPlevzUyjqFt4C4uCCCX/CGyWTt99nD+LyzYdP6qhPc7hrKkbXXPxtrIHejqf0P1NWqSuIV4kHL2sGk1rF9v9IQkaIn9Vv/mdvkR2iPKMleAF3JZ+Hbx6VlcBA4A+hDKNrO8H3XR5WDCgav6gpzi8q3ovsb2hZS4rhA9pn3C+Pzcgcb5UW8Vm3p7AmAvdmQSx46qAdhDPbiHdXgY3FvaPMFUnpr68kcPy5HckCe+fIfsVcBoxcSM+Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pdJdZ1M/RTe9Ysq+DrQ0tvEvWNu0sRBupwWRiHlCBEQ=;
 b=Hbr2HyxK7TpVEojjZaat8OXNY2yO637j61BXDkx1CgBWshdMnsyo1SXbhvZU47UxtIn8G6UWA9SsVJBmlQbTTyu18mC4sLAgqqdxfeYST2Pyj7fOsGSot0imTGuzBdmHuTI9pcprTDXSBcuHYzYmTUHSoXvfPS5FHjs5kAiSkm/ts7KdaCw3+NipddpaPtgWUwyJCOk5sRX5gW+M9+NAyaCmG5FM7m/8grbyVXSV3FOKkMETMXuzZc0thIRIUbFg+HH2nMEt77tUfkKrYCPrMmvfZG/5b61zSodcA95IbFToqoY9nIAsbZHV6qa+AVmzOjfy2d1hlSrNU7wx2vs6bA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pdJdZ1M/RTe9Ysq+DrQ0tvEvWNu0sRBupwWRiHlCBEQ=;
 b=uhBF0hhrLos57065CVKCfozfASvsRzy0rDBF6R6FEeHsA9eazzfKi4LVFKx2qFw3AJ+XLk5W1D+CoTwgfGSdE5d4sAhSZZhAbjrwJ2k214ezrDLnzVEuwXE6ocPU5TFonQaoptY2nvkhrEBn5jFI+TGuby1o2c2RFVCj04+hiSE=
Received: from CH3P221CA0022.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:1e7::12)
 by DM6PR12MB4385.namprd12.prod.outlook.com (2603:10b6:5:2a6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Fri, 28 Aug
 2026 14:32:41 +0000
Received: from BL02EPF00021F6E.namprd02.prod.outlook.com
 (2603:10b6:610:1e7:cafe::68) by CH3P221CA0022.outlook.office365.com
 (2603:10b6:610:1e7::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.11 via Frontend Transport; Fri,
 28 Aug 2026 14:32:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF00021F6E.mail.protection.outlook.com (10.167.249.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Fri, 28 Aug 2026 14:32:40 +0000
Received: from jzuo.laptop (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 28 Aug
 2026 09:32:39 -0500
From: Fangzhi Zuo <jerry.zuo@amd.com>
To: Harry Wentland <harry.wentland@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Fangzhi Zuo <Jerry.Zuo@amd.com>,
 "Pei-Hsin Yang" <peihsiny@valvesoftware.com>
Subject: [PATCH] drm/amd/display: Emit VTEM for HF-VSDB VRR on TMDS links
Date: Fri, 28 Aug 2026 10:32:27 -0400
Message-ID: <20260828143227.2280936-1-jerry.zuo@amd.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6E:EE_|DM6PR12MB4385:EE_
X-MS-Office365-Filtering-Correlation-Id: c037c5be-d588-4747-317c-08df051136f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|82310400026|36860700016|1800799024|10067099003|11063799006|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info: N/yeCvVB2WkNaE5n1lrHhT9NrsRUcy/nA2RMzL6RO2lQk7jA5HvS4eIytFsC/p1OD4CEQwPN2jBIgQE2+0dTjaPvLGRd0MyZpXi6lQ4Wg7rA2/lhFh4N6Z1uwNMtx3F9QypKhiQw4AmsyHZELYdp4E5tkN6VsLl+4GVln4oQ/Vg3ue8L07TrcAZI2XkmszMMNOy6QW3W+VMiTqjhYv/GbaZPABvUz2+oPAzUTutG2eQGqfflFe5bKMl6rTdwPD7H4Bb2nUykf9N2ru/7YMYSy7aKdYinREFLBvK8i0vWyyMOTUegwOA8KCv4XOUlN9cVLHHTboCq25f070cLZo1Ns76ipL1Avudy5lhr1rb5lxdYuTOWsoeat/6bJhbYSFLu+k4qa5TCmb6P7UTnzwWAPhpUQhvsWFGFH9fkUh3DdoutwpPVJUdmXsV7PJ450ZGGO4s22WWZHU9LAyf8GkhOTXgZRE/JWv5NbhGv+q0B+BZG2N6/ZA9Gln80fcVZehsvAempRrlcpMDaKcEzeSRnNU6Sm2z1Jd3ptKxbg4brPXNVcT7weI5FSTiT6pIw8vi0KPzeS5e5Mqc2W4v7n7MMVNoMfR8DPdMtgQTgtfLFku225zxtM9p9k5b0X0V1o6gdJPlAtjFAdvAqnlUPP/tGGPqX74GV39eKjL7twJaL1GY/A+FUNKC6tQWd3CXYvyghmazBqXk3kjDpKnMZ4UZlAg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(82310400026)(36860700016)(1800799024)(10067099003)(11063799006)(18002099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Eur0CRQjbdZc5vOIwxdD9OKtgyKo1k4BlU+DE359EKvYnn7WMjasuIyn4vNE+6OsLMd8203UrUIpQH7bxRGkBVL6klk5ad+SiVIhq0heM+Sy7k7guVB1f4X7CR7rGyJYsRe919sFojfIp/rBVgltPhBe2nc64WLux+S+cJHmEJKO6hhwuOYHY5pZmgDcaeMiO2dWGuJvO0cwj+PgE8dettLs2oj681PoifFO6k7kJxBbap2uMipn+mHaDVQXkBiKqBq4RZpTKIgBZR13YjpjKEmM0bIXmZYqm8z4iPLQaqXmEHV8V5FImdH+8NW6nO5cpgnQiGXKXNidWjyU3lW88r1hDoWVwGjmHNvjZL8wJKXtkxvlSfJGSu4pYUbjORo6LT/b8BQkuvdhF5tiskdOvc+radRPZel3rGuK0n2C2+zo3hVtwOTvQrFyJVadQdoh
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2026 14:32:40.2520 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c037c5be-d588-4747-317c-08df051136f8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F6E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4385
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

From: Fangzhi Zuo <Jerry.Zuo@amd.com>

HDMI-Forum VRR metadata is carried in the Video Timing Extended Metadata
Packet (VTEM). amdgpu_dm_update_freesync_state_on_stream() only built the
VTEM for SIGNAL_TYPE_HDMI_FRL, so on a TMDS link a sink that advertises
HDMI-Forum VRR via the HF-VSDB (but not AMD FreeSync via the AMD-VSDB)
never received a VTEM and VRR could not engage.

Per HDMI 2.1 a VTEM is a video-blanking data-island packet valid in both
TMDS and FRL modes; only the compressed-video CVTEM is tied to FRL. Build
the VTEM on a TMDS link as well when the sink reports HF-VSDB VRR. Sinks
without HF-VSDB VRR keep the existing AMD FreeSync SPD infopacket path, so
AMD FreeSync behavior is unchanged.

Signed-off-by: Fangzhi Zuo <Jerry.Zuo@amd.com>
Tested-by: Pei-Hsin Yang <peihsiny@valvesoftware.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_freesync.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_freesync.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_freesync.c
index 63d10cb7f5ed..281c6cec9f4b 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_freesync.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_freesync.c
@@ -238,7 +238,10 @@ void amdgpu_dm_update_freesync_state_on_stream(
 		&vrr_infopacket,
 		pack_sdp_v1_3);
 
-	if (new_stream->sink->sink_signal == SIGNAL_TYPE_HDMI_FRL)
+	/* Per HDMI 2.1, VTEM is valid on TMDS as well as FRL */
+	if (new_stream->sink->sink_signal == SIGNAL_TYPE_HDMI_FRL ||
+	    (new_stream->sink->sink_signal == SIGNAL_TYPE_HDMI_TYPE_A &&
+	     aconn && aconn->base.display_info.hdmi.vrr_cap.supported))
 		mod_build_infopacket_vtem(new_stream, &vrr_params, 0, &vrr_infopacket);
 
 	new_crtc_state->freesync_vrr_info_changed |=

base-commit: eb3ff61912825e72633f70b6f7197973be83c8db
-- 
2.53.0

