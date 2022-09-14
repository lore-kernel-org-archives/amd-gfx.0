Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9ACDECAAD8
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Sep 2022 03:58:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B62310E826;
	Wed, 14 Sep 2022 03:58:49 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2074.outbound.protection.outlook.com [40.107.244.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C904010E824
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Sep 2022 03:58:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DN2xfKCBAoBIKCdWCTVhHlGvFg/RZN6IeeJkW16ypL0nD3LCtagtpnz3vdIO1yRZkDEsEeEb9pavxhPf3FEnsIr43MopjnfskW7LA6XelzNGjfxHf5qpAsdV7JA3GchJ9/SSEtJnSARvU2yyK2EDfn9BXDw04XEOpT5W/fgxUn1Pc5m4NBYuQrx5UjnJM3RWyQ50Ce0yNsGzHaUq2r9Kdoj9B/9C2gPACH1/3Q/QADKBhmpdra/DO/KPq6APLXkVBhWIagA1hhYBa2DAs3nm34YHyhsafyyQPUP86zInQo/pAymAnp38OOl4gwva1CZs3gjZYoeMxVn58/RzxhgoFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZnVBWhHYoaV9prpRhNpjkAg6ZDHPSPCw0hEqgl/W2p8=;
 b=gCEQUAW9zN/M8NOKM+SBwbi8ml5q1gKSdFG+bKg8tCk+YsujFvdt6Uu957rJgiP9GbW5TBXZz2HLO02qkPbehoJ4W86qzB2a0DdS6HNn53jgseV3TNt5cXkbu5hSIlELxMmnZbfcg0W7MGhH0/7FItnozONsitxYiaxkmManoglHRjAPvg0by6rp18C5pZuIXXfT+qcmk7dKq1SVQAVlZVbXwn6cYKve16GqUCL1qu4Ghg4L4StElf0FX43i0vf+t3OQRttoryKUJi4STCVBI+lkpcRziUB/vGnei2tF65IikbByW+eIo3BSNPO9s3Dio/bErEd4HDyu12swts3smQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZnVBWhHYoaV9prpRhNpjkAg6ZDHPSPCw0hEqgl/W2p8=;
 b=z9oVeK/79YtqvIA31p+ghgfUdZP2f329hPfrf/X5ME4k/5bDltZPgf5cAvbixssf3JwQtxeaS3XDARmrk9jNNHqynK8aEScs/BEEFeSmtKCk7KF27Z1KPPv3LIIpPibMbrmmBNkF4BPEG+/TzWnpSi0FdkEr7GdyxB8t9HlY5vw=
Received: from BN9PR03CA0797.namprd03.prod.outlook.com (2603:10b6:408:13f::22)
 by SA1PR12MB7365.namprd12.prod.outlook.com (2603:10b6:806:2ba::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Wed, 14 Sep
 2022 03:58:40 +0000
Received: from BN8NAM11FT080.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13f:cafe::c7) by BN9PR03CA0797.outlook.office365.com
 (2603:10b6:408:13f::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14 via Frontend
 Transport; Wed, 14 Sep 2022 03:58:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT080.mail.protection.outlook.com (10.13.176.82) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5632.12 via Frontend Transport; Wed, 14 Sep 2022 03:58:40 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 13 Sep
 2022 22:58:35 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 13 Sep
 2022 22:58:07 -0500
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Tue, 13 Sep 2022 22:58:04 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH V2 46/47] drm/amd/display: Fix failures of disabling primary
 plans
Date: Wed, 14 Sep 2022 11:48:07 +0800
Message-ID: <20220914034808.1093521-47-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220914034808.1093521-1-Wayne.Lin@amd.com>
References: <20220914034808.1093521-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT080:EE_|SA1PR12MB7365:EE_
X-MS-Office365-Filtering-Correlation-Id: 1db5e7be-68db-43d7-897c-08da960568c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YcCRdfA6Qb1GlbDIm3aV/vUlRKNUd2i0MoWZDUKhGWQ1xcpqPUSMelYTTaQfyX3S1z7eGY+8obYnQoVOiH50KxfNcaBgiwhtumRCjkbF1Lkz3pW9mRywnyXGSMj3sYTTm5dj8uRn254/qzA1cH7ZJey9Sc2Npl0qTQkiUp4H3w8sqiAtc8lxQZqwmAzR6D5h4LlWweiGyT3eXX9Myj2PJi/vEjTKsIvHYhN9NKYwAmGC7HR4j+vSiHDGdpzl9QjxApbG908Oovbz+YacjmxFcSNas+06kZX6KCuTcMxyxajeAdMHk9AAZOr2eyHzG/5soSBCocmUeyyh9NVOeBHS5GEo3B+bYiD1nRvRH4Ihu9VL2DagRKTLdNWwOvA/SNz40besC/isI0WJB9ZSrp+Rl7gC05RQcp2WdbNz9MVtKsyrjIWexPM+BDxy9SDyCnwGgwHfzak3dXXec/cGPEUdgu76V2jdWQiWvYeJWUMhm/Uoc3K1ZrBYX4ZKIELLLhmwQEcdvZZJGIC4Aq+Ia8PefUgpvKcXYOqO0q5ZdNzA5viOj6Ws/sqmjE/vH4rdTVHSQH1NF8ZCoiphTODbzAa6TBkVN2cQxtpGnwrIhO6GiFKBu+lo4EjbQmQ2pVpi8r3by6eU7SYcmwY0tp29iv5UUzlLJ7jzpbxTwFewVUkH7VYVqT39Fl+xxoWrCgzCRmfPBYq7gjKFHV16jI2uLmGOT8jUNefgUy16s4Hl/Jo4rz2VomjUH51ogTh/HGWOOeA2hYkHLliWC9SB+NjDXqHxj/O3Gy9PM7A8/qWLlkPxMjo2mx2XeBl70AlPm2Oc/IMc
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(376002)(39860400002)(396003)(346002)(451199015)(40470700004)(36840700001)(46966006)(83380400001)(4326008)(82740400003)(40460700003)(8936002)(26005)(86362001)(47076005)(7696005)(8676002)(2906002)(6916009)(426003)(36756003)(336012)(186003)(356005)(316002)(81166007)(41300700001)(2616005)(1076003)(478600001)(82310400005)(70206006)(5660300002)(54906003)(70586007)(36860700001)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2022 03:58:40.2697 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1db5e7be-68db-43d7-897c-08da960568c8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT080.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7365
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
Cc: stylon.wang@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, Alex Hung <alex.hung@amd.com>,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alex Hung <alex.hung@amd.com>

[Why & How]
This fixes kernel errors when IGT disables primary planes during the
tests kms_universal_plane::functional_test_pipe/pageflip_test_pipe.

Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c   | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
index c89594f3a5cb..099a226407a3 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
@@ -376,18 +376,6 @@ static int dm_crtc_helper_atomic_check(struct drm_crtc *crtc,
 		return ret;
 	}
 
-	/*
-	 * We require the primary plane to be enabled whenever the CRTC is, otherwise
-	 * drm_mode_cursor_universal may end up trying to enable the cursor plane while all other
-	 * planes are disabled, which is not supported by the hardware. And there is legacy
-	 * userspace which stops using the HW cursor altogether in response to the resulting EINVAL.
-	 */
-	if (crtc_state->enable &&
-		!(crtc_state->plane_mask & drm_plane_mask(crtc->primary))) {
-		DRM_DEBUG_ATOMIC("Can't enable a CRTC without enabling the primary plane\n");
-		return -EINVAL;
-	}
-
 	/* In some use cases, like reset, no stream is attached */
 	if (!dm_crtc_state->stream)
 		return 0;
-- 
2.37.3

