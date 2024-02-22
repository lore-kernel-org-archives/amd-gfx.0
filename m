Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2EA9C48BF8
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Feb 2024 04:37:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5874410E2F3;
	Thu, 22 Feb 2024 04:37:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="TUz8Sn0I";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2040.outbound.protection.outlook.com [40.107.243.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 99C2C10E2F3
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Feb 2024 04:37:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H9mdj9L+vVLu9TGHeJbsSKQolkq6kdCxbwEWWxoQwZUqEo51ztrf2BxuRFrrqohCz0A7LcegM7kPuTpyBXnzE7XeJ7WvsoDZhudiMHjj//9Qkh9RkHcIyyN8b5vB63IH5rTih9fYebqE+zAobA43sFZ8lBH5rAdS75K/kXYKFzLLsjb3AHqlhMWgPkNOEIA7gK4VlQMVZajBO49lZ/DPYSv4XRkUInOHflns/PUABU/sP6WHEK2UIqlKYiaU7GBLpXEW/yNQ0IdpJBAr39SYS9AlA0ZZA2flaMImAOYfbCprCMAUXk7zojgyZrNpPvDAGoPocBhuKzyLsSkl0Y9HJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jkxuLhXyG7rXVY+ZAMBT9qE7zkRZGgdwEBy4n0TMbsE=;
 b=fPCJxPRuLrFPGCiMhbq/R1rQYdG0fxDq8CsY2yUE8a6mQt+xaWj1D2GPg/c4p/BtD6cUzjIhpY5v/8/pg9bCtukNFMW2pd5BODTrUWC9MOcLyHRxW/K3k2E7AFIznLHZ7T3nMcmPsNbx4n9CHK3hP58QVoY2CZ7pDmnHTAHdC8bQDLA7SQFDSkEr9oEyQBRNpfSPHvCwC66PNTWKgowYkaUbu4uIcdCspEcrgcqQooQzkfNxlzVF+xzw+nuXoVxhzAuUXiQB2BWOQSWuHfmMU45/4MQVuTzwcNGQxMQzB99tlr/4IdZh/nysXuFHoFVPmgtr8guxNtQ7TvgchS1WSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jkxuLhXyG7rXVY+ZAMBT9qE7zkRZGgdwEBy4n0TMbsE=;
 b=TUz8Sn0IEMZP11YHeolgAXEpyF52V/7FYNbSv9ra0XXtQHw6a2OSdAcDIPaGD0ov+rbJY34CpQcWVvu8RQfDFaN2N53s+XKxUf5gvS/dVbhB1Vcpbw6NsRgX6Bb6S5mR4g/w3KvuIEILPshu22qpnXTe6EAB7eEHYWz/6XmqiOE=
Received: from BYAPR04CA0017.namprd04.prod.outlook.com (2603:10b6:a03:40::30)
 by PH7PR12MB8155.namprd12.prod.outlook.com (2603:10b6:510:2b2::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.22; Thu, 22 Feb
 2024 04:37:52 +0000
Received: from SJ1PEPF00001CE6.namprd03.prod.outlook.com
 (2603:10b6:a03:40:cafe::75) by BYAPR04CA0017.outlook.office365.com
 (2603:10b6:a03:40::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.43 via Frontend
 Transport; Thu, 22 Feb 2024 04:37:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE6.mail.protection.outlook.com (10.167.242.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Thu, 22 Feb 2024 04:37:52 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 21 Feb 2024 22:37:49 -0600
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, Roman Li
 <roman.li@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Qingqing Zhuo <Qingqing.Zhuo@amd.com>
Subject: [PATCH v3] drm/amd/display: Prevent potential buffer overflow in
 map_hw_resources
Date: Thu, 22 Feb 2024 10:07:23 +0530
Message-ID: <20240222043723.669677-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240221063850.293956-1-srinivasan.shanmugam@amd.com>
References: <20240221063850.293956-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE6:EE_|PH7PR12MB8155:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f1b841c-d859-41b3-9fbe-08dc33600815
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D/yjN9G/fAQ9m3LXL5nZzba0Tob5o0J10+d9IsyRnVSxRK2nwaKHlwC/m3Qjd2iNl/BZKd74GfvbMowdAmGy3rgUlf6sT+eL4jLJbZnyT+CKG3+pRu2XMGH/f3O/OJKWoUsXe91hMnXR9DccagCQJUZYdTlfrv1eQMSlGb39LVZTVR1BTWX0Z3Yo+8HcF9o9kOB64ed45Kww5HRC4jGsu+gvrPWUGlfEtqvqWVt/a3OwPpu9e5HR92/g3RGdjpRIK0zh2Vt/F6cRu2usdkphqO2/p8AvRdLIgf0L5YwuiAdYRURtcWC8kh+d80d2d2TqXH41nxhyYnEzBWlMaw9nS9505MQ4hUe2p8uq7Q6ahqrgFE4QhD5Tds88s+QtXGWDhL06nUZlPQmKug5N3UdDC5eYeeZQsfCKp/5m+eizvYRQ4kjs3zMKKq4sART9A+repSqjbH9gtno0u8K6XrWZVNWyur5BcAIDnZ8/s+Daz6Saoz44hlAGQvYNYOJS5UFt2rZMIb/eTvlYuGQ+ZV5IglsH/E/gK4wY1jjGh4mbVZX+BoplSWx6XpIt6CO2nBscqNugB7q33fBKHu2eqTm8NAVVma+1b4nArnyoC2LpqN62Ft32tJ6yhMGIadUPVX77joxlv+z/HUo5MCojewfQxaHiwZ+/sRI/hs+7gAVwkcI=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(46966006)(40470700004); DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2024 04:37:52.4029 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f1b841c-d859-41b3-9fbe-08dc33600815
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8155
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

Adds a check in the map_hw_resources function to prevent a potential
buffer overflow. The function was accessing arrays using an index that
could potentially be greater than the size of the arrays, leading to a
buffer overflow.

Adds a check to ensure that the index is within the bounds of the
arrays. If the index is out of bounds, an error message is printed and
break it will continue execution with just ignoring extra data early to
prevent the buffer overflow.

Reported by smatch:
drivers/gpu/drm/amd/amdgpu/../display/dc/dml2/dml2_wrapper.c:79 map_hw_resources() error: buffer overflow 'dml2->v20.scratch.dml_to_dc_pipe_mapping.disp_cfg_to_stream_id' 6 <= 7
drivers/gpu/drm/amd/amdgpu/../display/dc/dml2/dml2_wrapper.c:81 map_hw_resources() error: buffer overflow 'dml2->v20.scratch.dml_to_dc_pipe_mapping.disp_cfg_to_plane_id' 6 <= 7

Fixes: 482ce89eec1b ("drm/amd/display: Introduce DML2")
Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc: Roman Li <roman.li@amd.com>
Cc: Qingqing Zhuo <Qingqing.Zhuo@amd.com>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
v3:
 - s/return/break as return may leave the system in a bad state

 drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.c b/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.c
index 26307e599614..2a58a7687bdb 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.c
@@ -76,6 +76,11 @@ static void map_hw_resources(struct dml2_context *dml2,
 			in_out_display_cfg->hw.DLGRefClkFreqMHz = 50;
 		}
 		for (j = 0; j < mode_support_info->DPPPerSurface[i]; j++) {
+			if (i >= __DML2_WRAPPER_MAX_STREAMS_PLANES__) {
+				dml_print("DML::%s: Index out of bounds: i=%d, __DML2_WRAPPER_MAX_STREAMS_PLANES__=%d\n",
+					  __func__, i, __DML2_WRAPPER_MAX_STREAMS_PLANES__);
+				break;
+			}
 			dml2->v20.scratch.dml_to_dc_pipe_mapping.dml_pipe_idx_to_stream_id[num_pipes] = dml2->v20.scratch.dml_to_dc_pipe_mapping.disp_cfg_to_stream_id[i];
 			dml2->v20.scratch.dml_to_dc_pipe_mapping.dml_pipe_idx_to_stream_id_valid[num_pipes] = true;
 			dml2->v20.scratch.dml_to_dc_pipe_mapping.dml_pipe_idx_to_plane_id[num_pipes] = dml2->v20.scratch.dml_to_dc_pipe_mapping.disp_cfg_to_plane_id[i];
-- 
2.34.1

