Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67A94CCFA0D
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Nov 2025 15:41:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 079A210E777;
	Wed,  5 Nov 2025 15:41:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mmlyPNIW";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011023.outbound.protection.outlook.com [40.107.208.23])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BE6E310E77A
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Nov 2025 15:41:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jDgjGgqTHUDoJCY5hqMKZW9i7CUN2lZlbfbks3YvxMxt7Fvag9qp6r1jDHssA8av2IQfqOd8KxrqVuydPRq368Ei+mYplLqrDejHXcoZRZdR+AKQeSHhh6CfRQJPBwmYAr8Zwva89i953RBAU+Q7oG8RDRNeyRmead2t0LMaSsn06FDLKFSTYK5Jk+X4uKc4LrKWWGKvaEHADvj4juDFnVLaHalz3cR5bSH/HAuvn7iT1o389gYdXhpKXcShQLG5nP6p5N+WQkMPy7IUvKERHTDr35Fv5uNsslLhZbE1fZgmrZa1WR5ww1A0jlQx9iEmnDJtkKRP0JPh950F02Lhnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RFxyMfvzCRDszMoNRXO72p28p6STJjlwAQvNw/07amw=;
 b=qf8jkXRyAwoPqISN1EXEuhvTiQ73Yu6gE+IuJFMh7nncVDimVogoLe+5GvwZhNj/rpPedRpe69rz/V2tEO8Su6tRtbp2wKxuIJJdDOg3xzXOGBHPQDB7A8Buo7uWxIIiKb0sU3k7mV0QjL2hwyBEKTW23w0QOqItMqfR6wr/AQKm+mW/0/tMLtsMXOFY4n8R6zExxDrsB6SOiABJL6l++nneE1CxS5WO++FehDHELTVSraagw6Gu4fLmceRmbUEZ9rxphof2T0VG6uO/ub6k/C3/DL79BQsYyDQYd6eqWfm5/WAc2+yR6mqUS759108vnKr+Vo5brUNYpMgVT3FToA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RFxyMfvzCRDszMoNRXO72p28p6STJjlwAQvNw/07amw=;
 b=mmlyPNIWbifRpKT0CU2KaNwRSxTkSTNUOWVFvvygHkiAM+dyY8TkbCMYDHwVZTrlZjjkop4MVtId9zAti8mougLSS4azQnZs6/h2h2Oz+16onDHCeMfuH5xM83WgFfCzja1msz7/Ni3E8s39eUM6lP8rnhAcg+4Ff8spU4qV3Gc=
Received: from BN1PR13CA0016.namprd13.prod.outlook.com (2603:10b6:408:e2::21)
 by SN7PR12MB8604.namprd12.prod.outlook.com (2603:10b6:806:273::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Wed, 5 Nov
 2025 15:41:30 +0000
Received: from BN1PEPF0000468B.namprd05.prod.outlook.com
 (2603:10b6:408:e2:cafe::f8) by BN1PR13CA0016.outlook.office365.com
 (2603:10b6:408:e2::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.7 via Frontend Transport; Wed, 5
 Nov 2025 15:41:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF0000468B.mail.protection.outlook.com (10.167.243.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Wed, 5 Nov 2025 15:41:30 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Wed, 5 Nov
 2025 07:41:04 -0800
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 5 Nov
 2025 09:41:04 -0600
Received: from jzuo-laptop.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 5 Nov 2025 07:41:03 -0800
From: Fangzhi Zuo <Jerry.Zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Taimur Hassan <Syed.Hassan@amd.com>
Subject: [PATCH 13/13] drm/amd/display: Promote DC to 3.2.358
Date: Wed, 5 Nov 2025 10:36:28 -0500
Message-ID: <20251105154035.883188-14-Jerry.Zuo@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251105154035.883188-1-Jerry.Zuo@amd.com>
References: <20251105154035.883188-1-Jerry.Zuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: Jerry.Zuo@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468B:EE_|SN7PR12MB8604:EE_
X-MS-Office365-Filtering-Correlation-Id: 3973f254-4bc2-40f0-a4b4-08de1c81ca54
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?n0ihpEl0ZYsJLfJ8nDezIL2ffHkedRo/YqrD4JfQLHKCaRmZYfqy61NVPdmZ?=
 =?us-ascii?Q?Jv5Q3fRjSHzBaOL5pKZKQb00F9DflfECfRn34QCJ5t9WxRO97yeJo+rCeOkv?=
 =?us-ascii?Q?1PMEGY+CJ4rs93BlJIrR7RirNsf/FMu6QJgaky83PekJcU3m8CblhsWOqQUO?=
 =?us-ascii?Q?523ZNKL5km5m9iETroLFu3n/Ey5WtlHmQ0iff6tR/nH7KTlc+Zi5idzl/tCn?=
 =?us-ascii?Q?RG3WQYraCbdoAiGi99n+6iL1NsSWALpVs671XJxP+rOAmZDVV9yxLmb85IkX?=
 =?us-ascii?Q?lNvQCnrbuDb002gOaLyFIGZLqUVupX+Avt+X+cOjMOfG31qC0iWVJlE1/AT2?=
 =?us-ascii?Q?kPExQ18o2N9cmi98ff6uatxagiNGABS8B1B6GnE8F6xP1RkCCJomsY5hjbCW?=
 =?us-ascii?Q?3zGha0FZ3JQ5qAsC5ByhaW8ZExAUCYBA21DbE1WQ4JxVtEuxa3yzMl2B/Qyt?=
 =?us-ascii?Q?jV9BjXOHeg6Ii7rxFruTOrlWuemjq4X2h3TyrvjOB+oXxBsP9xsqmZeEH3R+?=
 =?us-ascii?Q?2ykQ215Wx5cp2BFjELkBclSi9gFEpJS/gHp3NTeigddGhKAOfv0U8Eb40wou?=
 =?us-ascii?Q?DglzgD2r4hEGFctJZzvw8AthNEqovyvLxG9Br4oeqWvS97R4SJWQh41C3xUS?=
 =?us-ascii?Q?7IkW2q0+DAzfOafO3VaqjhiGaHMA0ReNIfH9NwOeulNh6GMi+Tx8PuksOacw?=
 =?us-ascii?Q?NJ9ICjU3U6hTMX0dqLmYSEOyX0xdmBaT7DMaXplFo5jnC9zqDo1O4wf5mkcj?=
 =?us-ascii?Q?/e40bMMuMBb6NiGjHIczrbr/qPmyWi92koyS+LhcLTExvaFpL0UAeYHrTCU2?=
 =?us-ascii?Q?cESpoM2AiRjRetYno0029VFSyhUM+DDhZwK/03nylZJ8XOwEuAFNTNrJs/ES?=
 =?us-ascii?Q?Yvs6XsRhM/QFhKlrC50EKRmiM6UiBAj+y0UVTfcTjMJLg+ZVVY2qYIOQMQtC?=
 =?us-ascii?Q?etm7gYirALufDVTTQVtI4uV88WAB1N7gJYYNmuGhkYpTZoNQJqffXehE42lE?=
 =?us-ascii?Q?UcSj2RaPjt3/lD/xz18bbUykFqKXufG+xbCtl6zOTDm/7Qx3Lh7sRkgl7Qyp?=
 =?us-ascii?Q?SME744zXbdz14fVHb1TQkPG875M8AXn/DybjNpWVVMocJf6pZV9qPH9pbz2N?=
 =?us-ascii?Q?oF0a/oQ7+ppb3fMLoFByRXxpQsggA5wEjq9Bjnwsv9UXsta5gM0sbRkPWhdg?=
 =?us-ascii?Q?u1tAPM9PHGnacfKTPbvQnrkRXUzrOyJX5KmY0sOrQIyFQaQVrvUVZBfQWnCp?=
 =?us-ascii?Q?J709mBUGJ/u6WrLBEhv7gKnPxW0LIn2sAOQckZo3RC2jv1bLhzSQA+siJHAV?=
 =?us-ascii?Q?ECDBtcQNVH0V9+HUoTtVdY+r6H1h55pzJM0M0SqRTqYSI73g2GmitQdK0YJ8?=
 =?us-ascii?Q?ZV/lQCxnuzeJLrYufpqf4uDr0vWiDNrpAI8876v6PnQjxBXp1TCDNZODuRgt?=
 =?us-ascii?Q?QBznfYlonbqpuRtHynz/hhoZgW/mmxS/NVx7h40OxuHt6nfbHJ2usne7Nh9K?=
 =?us-ascii?Q?+jayjnT4E7yRvv8Pq9OdqGSpQopTuKQgK2dm58WENC0Ppw/5uXoBZ35OkKWH?=
 =?us-ascii?Q?uOAvg+63hFmGB3IgLHo=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2025 15:41:30.3663 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3973f254-4bc2-40f0-a4b4-08de1c81ca54
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0000468B.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8604
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

From: Taimur Hassan <Syed.Hassan@amd.com>

Summary:

* Enable VRR when unsynced with the stream
* Refactor DSC cap calculation for dcn35
* Add debug log for power feature
* Fix fill latency issue
* Do not initialize LSDMA if it is not supported by DMU

Reviewed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Taimur Hassan <Syed.Hassan@amd.com>
Signed-off-by: Fangzhi Zuo <jerry.zuo@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index db43e6975675..3c032ac80d24 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -63,7 +63,7 @@ struct dcn_dsc_reg_state;
 struct dcn_optc_reg_state;
 struct dcn_dccg_reg_state;
 
-#define DC_VER "3.2.357"
+#define DC_VER "3.2.358"
 
 /**
  * MAX_SURFACES - representative of the upper bound of surfaces that can be piped to a single CRTC
-- 
2.43.0

