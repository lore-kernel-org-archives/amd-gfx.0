Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 750DDCA0FED
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Sep 2025 05:33:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 097B910E855;
	Wed, 10 Sep 2025 05:33:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="U12LqmNx";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2048.outbound.protection.outlook.com [40.107.220.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7CCD510E855
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Sep 2025 05:33:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aPRkH4lJD4AwezqmQ8zBS2jx3dh4wtUi2wtzuQ3bvcnciPblgShGB3KfTOgmWBQDu9V4+NNsJXe8KS5pgxtfXvLq5v+Zu8p2dpAl3aIi664TFqcVtPexp/GiUlC13y+wCr1GC6Bv6t3zoOSeiHhUSN1y0V26hWPMHoXXgAYmHEIhuwwHlPafVEUr2sqkRGN5iEUL4eL2rzi1vYVT1DUbBk6ntTwziHmJkKaVya91oFQ7MZnGGZZaMtkSjFjg2ut5a6E+qudcjVQZlX7OgxXNgS6ZwqZvWOfuM2ubqLQ2CLc3elKBntrFOL3P52RbHTxeWUO5x50wLvTpTgW5y38qcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ieLTa09e29GgyJU3xAaMIQXFSZtMMWMg0cOzOy+i4+E=;
 b=Ir/SBhC+EEGpfBX9s2Na4Wj7uq2NWyAobvgdyd9bo0l3mF0uQQLIVdPBkY4GnuSKW4/NT/6NgmXRKKuoE71piCVAdnZQlKDbshxRnldAGgIHQI6MzxwMdgrSjc+lo0+k0+9cvRbKEnBRWxfpJn141uDQNdqC7hy0xsiO5i4RZfP6oDQIwNTxY6TDrLr7HJ+XYKnqrl4/Mzng3T8kxSDkQs/cq+EOSfSmMkmkb8ufeO6wfB/tLqyZk7tX+rZPSyV3vUmfgxUjpdQQvl6Z4SCpX0HJpMVDhysrL30elVKi+7iQemqOOW7teOv61jFFJvNEJbeeLz/E8QNX0f/zSledJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ieLTa09e29GgyJU3xAaMIQXFSZtMMWMg0cOzOy+i4+E=;
 b=U12LqmNxCPM5r1HV4dAHxix1YV67L5QafJSq1jim2t3LvJa2ZH0v9ljdOcMlUWBJTPv11W6N7X/Y8e0L8WJxRhU9nG3RSkcM21d7BwYoBz1sA7EVmIpAjfs1v5fn91ScXKc2xqiu5+UisMo1vq2UWJrqIIhHRKH48yKr6UUppnQ=
Received: from DS7PR05CA0033.namprd05.prod.outlook.com (2603:10b6:8:2f::20) by
 PH7PR12MB7844.namprd12.prod.outlook.com (2603:10b6:510:27b::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9094.22; Wed, 10 Sep 2025 05:33:12 +0000
Received: from DS3PEPF0000C37D.namprd04.prod.outlook.com
 (2603:10b6:8:2f:cafe::e0) by DS7PR05CA0033.outlook.office365.com
 (2603:10b6:8:2f::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.15 via Frontend Transport; Wed,
 10 Sep 2025 05:33:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DS3PEPF0000C37D.mail.protection.outlook.com (10.167.23.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Wed, 10 Sep 2025 05:33:11 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Tue, 9 Sep
 2025 22:33:11 -0700
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 10 Sep
 2025 00:33:10 -0500
Received: from ray-Ubuntu.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 9 Sep 2025 22:33:07 -0700
From: Ray Wu <ray.wu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, "Daniel
 Wheeler" <daniel.wheeler@amd.com>, Alex Hung <alex.hung@amd.com>, "Charlene
 Liu" <Charlene.Liu@amd.com>, Chris Park <chris.park@amd.com>, Ray Wu
 <ray.wu@amd.com>
Subject: [PATCH 07/15] drm/amd/display: limit one non-related log to dGPU
Date: Wed, 10 Sep 2025 13:30:30 +0800
Message-ID: <20250910053222.2884632-8-ray.wu@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250910053222.2884632-1-ray.wu@amd.com>
References: <20250910053222.2884632-1-ray.wu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37D:EE_|PH7PR12MB7844:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a225d60-ad3e-4627-1963-08ddf02b884b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?hxWUXKcg/L3+AE+KWg26ZNXyW6nUE61sST2tt6l9j8MbhAu2SZ0+1WPNwgJa?=
 =?us-ascii?Q?/+ttSCU07GI7orKULm4GB6HW1KjAiUTEZy8GUeMcdkgn/bbfZUebUwztK5Hm?=
 =?us-ascii?Q?dfk5sBYhBeEHKdO4v8MnqfBUw7eESUPK0kVyEWqjQQL19E5MVvXZwD3QAC6f?=
 =?us-ascii?Q?oCAW6le2bJYpdyqu6MmhAgK5VpHTtOoN8Hc9UIZIwmNqgnpigoLnyWwipBtA?=
 =?us-ascii?Q?e6rd+xSJFMnDtzgiOAlbLBk9QGFLxD2D1NC6cW/blmVZRi4FvlGUsr2LaYgE?=
 =?us-ascii?Q?OCD+j4GJWeLG6yI15d/82GJzwyt2UFBRcsbJzkwxA1fXu1DkHobFX9SlR2Tm?=
 =?us-ascii?Q?hEsStjGdMmg7haEBlNPfT5SdX33UleiMzHRkvCLiAS4h4xhD3U1qfjx32NNw?=
 =?us-ascii?Q?vOY9QEFg8QG08et2bIWQ/CGuRWJCLICjclsyBLSNTC5oixpwsswdFBl0oGgo?=
 =?us-ascii?Q?+NjEOXJrc5VBku3HoLWv1D8PDaHio8lTyhJFU4Fs/Qv/cM+wPOrjdeZN0XmF?=
 =?us-ascii?Q?jjSsCCGhIA/MKOxhAaTraUPeaUY3NSc4PSXhuj5446S4gpROJU/lnHl9YlJY?=
 =?us-ascii?Q?nXQCosBpCPnwim/+Tvtaflo8zJP+DzUsLtCx8Wrm/QuHsEIajEw043vamZbB?=
 =?us-ascii?Q?c5QBJNG4Ua95CjvpVloujKNzsw3GWL8T03xxn2jza11VBDt4mybO9EcONqlh?=
 =?us-ascii?Q?kh8n1pZtqleY0mGZlXPZy/Dg+1AvAfgITlgXQOaNXsbtAll13R2YB2LM9ZYo?=
 =?us-ascii?Q?M/aPCYHDqzVgbnKiUadppkTkp34Oy+dcfcC59KtYklwFa94b1jOksDNaFsqQ?=
 =?us-ascii?Q?PBHVDlk9u6kb+o2unYJo8iXn2FCySEMa37f3fCdMPWiwrpM5b9R3GYV5dmv7?=
 =?us-ascii?Q?INxq5sVYoo7iSzQxG54nYb20uFIO26OXpwrzUHTzhBNvIcEM+j3e0q5GxHcI?=
 =?us-ascii?Q?8zXC6ZZITsT2VdEh+cWSNQbvOdGjONA3YhIhWI98FBm1hr3GYs39feAMICFm?=
 =?us-ascii?Q?Y1G5IlXiHimZtt2qtzFJwT0aK1N0dLhdhW3xjtlBfWIhZ5Nfjfhj2+O/qr86?=
 =?us-ascii?Q?cO3vb1V2bgMXn1SMbA6Cxgio5Ua7VfrnRqyEBIgsW6nvZf1oOnCboDrzPr9j?=
 =?us-ascii?Q?LK9qOrm40quWrqIZav6/20wDTpMJabhR054DXieXUV1bhGpxHXHiv/LnRol4?=
 =?us-ascii?Q?EW7LGZZavGXXIST1KBjLkYXhvtfc4TbRzOnwdAcvxi5VnbWjdqJ7swRM6qmx?=
 =?us-ascii?Q?CcFdumWRdaazn0WLwP6pTLEm1CUqyX90izemUXSvtIQavPI+9BnaBp4XE5K7?=
 =?us-ascii?Q?xn5S97wdlpVRrBkVfhEJ9Q+uIXV3gvC+JSMW1MRJ6iTUIFsudr69ktBveLLk?=
 =?us-ascii?Q?LUJCT5XuMnHf5LvKti1ELWv0gIvtbiwhi5ylaedBXsFsbsiN1P9Y04CCsMTB?=
 =?us-ascii?Q?L9NomfDOpqRkzgKQ6c7CQhUtBXaS+mVJDktCycnSCoigzyVPJ0KBolcocZHn?=
 =?us-ascii?Q?XxvXIq1ZsohbvOZi6+o8QluWIWb2oVed0haC?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2025 05:33:11.6562 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a225d60-ad3e-4627-1963-08ddf02b884b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF0000C37D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7844
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

From: Charlene Liu <Charlene.Liu@amd.com>

[Why&How]
some log are for dGPU only.
Added check to limit log.

Reviewed-by: Chris Park <chris.park@amd.com>
Signed-off-by: Charlene Liu <Charlene.Liu@amd.com>
Signed-off-by: Ray Wu <ray.wu@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 269206ebee60..c4dd52ed377d 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -5622,8 +5622,8 @@ void dc_allow_idle_optimizations_internal(struct dc *dc, bool allow, char const
 			subvp_pipe_type[i] = dc_state_get_pipe_subvp_type(context, pipe);
 		}
 	}
-
-	DC_LOG_DC("%s: allow_idle=%d\n HardMinUClk_Khz=%d HardMinDramclk_Khz=%d\n Pipe_0=%d Pipe_1=%d Pipe_2=%d Pipe_3=%d Pipe_4=%d Pipe_5=%d (caller=%s)\n",
+	if (!dc->caps.is_apu)
+		DC_LOG_DC("%s: allow_idle=%d\n HardMinUClk_Khz=%d HardMinDramclk_Khz=%d\n Pipe_0=%d Pipe_1=%d Pipe_2=%d Pipe_3=%d Pipe_4=%d Pipe_5=%d (caller=%s)\n",
 			__func__, allow, idle_fclk_khz, idle_dramclk_khz, subvp_pipe_type[0], subvp_pipe_type[1], subvp_pipe_type[2],
 			subvp_pipe_type[3], subvp_pipe_type[4], subvp_pipe_type[5], caller_name);
 
-- 
2.43.0

