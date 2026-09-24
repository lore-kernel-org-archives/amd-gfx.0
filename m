Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7DF3C9830E
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Sep 2026 18:46:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E1C2610F736;
	Thu, 24 Sep 2026 18:46:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tV44/V7+";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011002.outbound.protection.outlook.com [40.107.208.2])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3071010F72A
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Sep 2026 18:46:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qdUq3KqhymUpWuhdrAQM9ogEdi5xr36+hKWk4XxWDuAQw0lzNG0B2bL5pigq0bamjLml7sWdIBWHS/TU/dFVHk1GepMEMwt7sfITRHw4xDl8w3CSTTYbn7C+jeXWA2NXuvR7Z0R6VrscJxzaGk0Xn4dpRL+WWYeNWCIIY53ft9Vi3T7TqrUpZ9MQwPvo7EjHV2p4y5/MJZcMdNdphyCuNfXBVNYy8k27Y2bDyQCXm3SbkhTVPf+v0EuFUozQXad1p0abGmpTh38mhLQ7/rmM+QtjewZMNiyMVCo14J5joBjJEjLBh94ikto8sjz2qJEsy4tcZlcu6tmy+savAg65FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TsrvJUSXvMNF/mnPDQ9UoyxbcVkIZIKEVf0yVfL45+I=;
 b=GuugVIQiIIkfESvZ8KbOk/dh2RW+esgCqjXtXbFhUcjyGjdVfdFvl7FIwJWZ0676ztKQhU1iPJhsOv7Bhk89lAwgoF2Ofu1xFb+d+fttpWzAGdIdIKvc6M2QettF5lDcNtcAFaxGtbRyHYGKOi78teiVx38kjTrvvqK4ENHI35Bchm95g1lCxkP95l8f3G0qm5I1NLIGqLvwanQhu5tnwCPIPGRGC7RFEKz+wLE6j1lnRCAp2Zhimr8/umziR4oTUvszWgVBvnm/58Q8kMX0d9dOu9X7Cq9njC+gdpGls4JpmojU5PjfmVoWfhGdj983TUZW6Q0R8pGRRp9y3TQfEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TsrvJUSXvMNF/mnPDQ9UoyxbcVkIZIKEVf0yVfL45+I=;
 b=tV44/V7+qIZJwUhVsd6Jh4lDvRwwEx24g9XDAeJYR0GfiCPMYXAsfUk/TDiX6mo4sgVobazUjkuEl0gnh7cp4VJfWUeuRMNtDgMQR4S6iFgd+GCQC91uamaPQ4MJ81Pnd5fpSBRw5110XMIQC/WLXz2sNmf/GFxh37svLwbrwoU=
Received: from SJ0P220CA0020.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:41b::26)
 by PH7PR12MB5976.namprd12.prod.outlook.com (2603:10b6:510:1db::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Thu, 24 Sep
 2026 18:46:15 +0000
Received: from SJ1PEPF00002315.namprd03.prod.outlook.com
 (2603:10b6:a03:41b:cafe::8f) by SJ0P220CA0020.outlook.office365.com
 (2603:10b6:a03:41b::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.18 via Frontend Transport; Thu,
 24 Sep 2026 18:46:15 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002315.mail.protection.outlook.com (10.167.242.169) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Thu, 24 Sep 2026 18:46:15 +0000
Received: from jzuo.laptop (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 24 Sep
 2026 13:46:04 -0500
From: Fangzhi Zuo <jerry.zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>
Subject: [PATCH 05/34] drm/amd/display: Serialize HDMI FRL status polling
 against link detect
Date: Thu, 24 Sep 2026 14:45:18 -0400
Message-ID: <20260924184824.596894-6-jerry.zuo@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260924184824.596894-1-jerry.zuo@amd.com>
References: <20260924184824.596894-1-jerry.zuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002315:EE_|PH7PR12MB5976:EE_
X-MS-Office365-Filtering-Correlation-Id: 7fe6fb51-fad0-450c-f781-08df1a6c1d28
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|36860700016|376014|1800799024|10067099003|5023799004|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: cseQTAI8Ett0RkeZMd1ewid97Hl2jqGSlDqGodQCO9EoK4SrJ/oCkfxml4vZLQRWgNKwHRICqyakhQDwVV+B3gdTMwpS8tt/dX2BrZsHj1Qv+esWG/FGodoMi+H6J2Oy0PgglFBpZtQ6LkJuqMvhP9RC0G7O38t4wtUsEQoCvGtsPbukGG5+6JyX5C01QjDKMug4u60lnRgPhJB3zytpUsNHT0iK0I9+trxAYOf9qJdhq3FM70v+9kGnsHWSvlsYfmCi+WjlNkBvO+erHuKLRKjzzaTiPR5MnxYrgzVKiKLR8RnnDMJ5EJJwgpRlQETpeSilHzFh9Xi0e/3+XskBoJno7efVKrebJWiQQBo3+gmcDhBbN1KMuEeedgD0h/LYgmNTYx6pt+LtQW0DZtCj4mK5+sv2wvEbZ0KUfW8ZC26o4gVbgcGBOTCMYnXMq8eII7ChR91sKybMWYwqg1Fl2NGU5PPiP5krX3ek1pLnlYAMJ9dQ2M6uiSosM+iwJ3tIlfoM9On7t9VqUbwIE0QBrLUcQ/pQUfySFocPeiWw11qjXiJyS9IN4qBW3ELf3l3HdQSEzeNO6M/ImF0JH9vDGYDDdXE7p4hG1c/Y1V2SoFpuaDg3wCnvpdg+hCUvQdDla1/Fuwu0+BUHU4v2JqQEbNf4R/L221nxaSvJ1yivPy1ZoyQW3+bvQNUyuwVpQuVf/3kNTjnQqgU+MOiRJqaWug==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(36860700016)(376014)(1800799024)(10067099003)(5023799004)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: y/xdGub4kJCtTZBvfzTAkTCFbesPinvuhbYQIYcEZgd3BSoDrSqAx20/Q3PeuTfW3xSN6fi6WqBCzcuFNxqt3mbRKmwK/TLrN21WMCDbIZP2qfOKPtvRE+eK58wW+8RIZ2u2KF8CJ/5MmtOZDNR7264wg4sWDXgAjP0mQ/88Lt+lN1ahDyjytTmJ4POjE7s/hQDPpPipi3964riY/ZN81w3nujm3t+uME/nVhQ3NmgswQIG9ygFfndOKewJmUCWqKlP80HqJfrXTwwn94habpWbfou3r93HskovaUXdPEkTGGCIabWLllPP5OFnXLb8RVS0LyIQcq557QARSk9Esh738016qWfcirj5lcn/jCJWtwed/aQbbhkxoT5RNmeXbYU/+2hkrQMEpRY/eckCMqGrk1I222Ba9IAv2v2lPPamGm6F+ymFIgzPXJCMzz+s2
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2026 18:46:15.6638 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fe6fb51-fad0-450c-f781-08df1a6c1d28
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002315.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5976
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

[WHY]
The HDMI FRL status polling work can run concurrently with link detect
after an unplug/replug. Both paths access the same link through DDC and may
perform FRL link training, while the polling path also reads link state
without holding dc_lock.

[HOW]
Use mutex_trylock() to serialize the complete link walk, FRL status
polling, and retraining sequence with dc_lock. If the lock is busy,
defer the background poll to the next 200ms cycle instead of blocking
an active detect, modeset, or flip.

Signed-off-by: Fangzhi Zuo <jerry.zuo@amd.com>
Reviewed-by: Harry Wentland <harry.wentland@amd.com>
---
 .../display/amdgpu_dm/amdgpu_dm_connector.c   | 35 +++++++++++--------
 1 file changed, 21 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
index 7ebf7216b499..3255f5b2dde6 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
@@ -3109,26 +3109,33 @@ void hdmi_frl_status_polling_work(struct work_struct *work)
 	struct dc *dc = dm->dc;
 	struct dc_link *dc_link;
 	bool link_update = false;
+	bool link_detected;
 
-	for (int i = 0; i < MAX_LINKS; i++) {
-		dc_link = dc->links[i];
+	/* Defer to the next cycle rather than block on a busy dc_lock. */
+	if (mutex_trylock(&dm->dc_lock)) {
+		for (int i = 0; i < MAX_LINKS; i++) {
+			dc_link = dc->links[i];
 
+			if (!dc_link || !dc_link->local_sink)
+				continue;
 
-		if (!dc_link || !dc_link->local_sink)
-			continue;
-
-		if (!dc_is_hdmi_signal(dc_link->connector_signal))
-			continue;
+			if (!dc_is_hdmi_signal(dc_link->connector_signal))
+				continue;
 
-		if (dc_link->frl_link_settings.frl_link_rate == 0)
-			continue;
+			if (dc_link->frl_link_settings.frl_link_rate == 0)
+				continue;
 
-		link_update = dc_link_frl_poll_status_flag(dc_link);
-		if (link_update) {
-			mutex_lock(&dm->dc_lock);
-			dc_link_detect(dc_link, DETECT_REASON_RETRAIN);
-			mutex_unlock(&dm->dc_lock);
+		link_update =
+			dc_link_frl_poll_status_flag(dc_link);
+			if (link_update) {
+				link_detected =
+					dc_link_detect(
+						dc_link, DETECT_REASON_RETRAIN);
+				if (!link_detected)
+					DRM_ERROR("HDMI FRL retrain failed\n");
+			}
 		}
+		mutex_unlock(&dm->dc_lock);
 	}
 
 	queue_delayed_work(dm->hdmi_frl_status_polling_wq,
-- 
2.53.0

