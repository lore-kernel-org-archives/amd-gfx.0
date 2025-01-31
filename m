Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A089C0218F
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jan 2025 16:58:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B2C5D10E433;
	Fri, 31 Jan 2025 16:58:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OaTl52c0";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2081.outbound.protection.outlook.com [40.107.237.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F295110E3C6
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Jan 2025 16:58:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u5s+NaqPNi2vLFZizBo3zzcBq3iqKJK9cNPVRNnIkeAXzzFSvN7xpvnih13dFgPllAMrTF4IKHormrx0LgX1yxQtcn2alQ4C351CRerlze5PlADVQfjqy3Co3JLzEwQ47d7IrgXdRZUqksop1CSfQnZytfxx18a96AfVJQTIJVHaECvQsCydv6gYiXSlykjYCoSH4a0gFtkY1IG3Fl3PHCMshmoubuZsU3Cf6jYJUI2rHyQiZZmlevMGpCujFYnK6zg57fumZUk8e4GW9OvhnunhdXyjLEU042xRJf3+mFO6B+PeEOSx3eAGulGBEToyWgKbqI9BPc0Co4Ww4TP5KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zh3Al8CPYGZfnn9LaFPYt1X+So/xv5zsvwcH3EiqpwM=;
 b=giIczAQonWdI0FCMGSMGLTLvSCsBj+i+ri8pSwZMKWwXbuiOm3rw+6Vu42sU2UUx/cMWbrQEqHvyxMcPChUIiyP7+WoKYS8ozmn/2pXr5se+FEqKDAgAsBhoBl/Xqc0GPdKziTr+p3KW9m1ivCM7+TFpZ/Xqr8SiphNmVaaUaYtzSGl5odLz8+MN25KoVObZ7HPQ2ZZK5Xq7mbkX63ubRuQE2ordEGQ6++1q65vDPsAg2/fY0LKtVO4V6I/Yl91+l1uETMCPA8kSTESVpLf6v+RFIVkpQVOl/5kvQ8wGgzMpoo3mB00FNhs1m23OZCqW3hXQlyZpf2nBvzWm5Z8gew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zh3Al8CPYGZfnn9LaFPYt1X+So/xv5zsvwcH3EiqpwM=;
 b=OaTl52c0615egQw353LQ+Vb4CLzaBHW38MFmJATXlrjSNDTWkVKARaex33YSNQkhxzcKNCRSaeTMKyFw4SH3OnjXzJugMvVXhRbpeBV2MekcrmUfppNpz6TJWUd2opkeTszSzvNyS+G0MZQWi6DWDBe2mL//EIp85GbuwMkyMIg=
Received: from CH5P220CA0002.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:1ef::10)
 by SJ2PR12MB7799.namprd12.prod.outlook.com (2603:10b6:a03:4d3::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.22; Fri, 31 Jan
 2025 16:58:28 +0000
Received: from DS2PEPF0000343F.namprd02.prod.outlook.com
 (2603:10b6:610:1ef:cafe::fc) by CH5P220CA0002.outlook.office365.com
 (2603:10b6:610:1ef::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.20 via Frontend Transport; Fri,
 31 Jan 2025 16:58:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF0000343F.mail.protection.outlook.com (10.167.18.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Fri, 31 Jan 2025 16:58:27 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 31 Jan
 2025 10:58:24 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 41/44] drm/amdgpu/vcn5.0.0: use generic set_power_gating_state
 helper
Date: Fri, 31 Jan 2025 11:57:37 -0500
Message-ID: <20250131165741.1798488-42-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250131165741.1798488-1-alexander.deucher@amd.com>
References: <20250131165741.1798488-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343F:EE_|SJ2PR12MB7799:EE_
X-MS-Office365-Filtering-Correlation-Id: f7437a41-ef12-417d-e16d-08dd42187bb7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?3K2E+JXBU6kD4bbZCjAbaJqFr3aQc0NCnalxOWWRrIx/F6Lqm9GEp3/Hf4g9?=
 =?us-ascii?Q?myTTlYonLi2+fa3vYbg2JIFtPORh48VedS9S2nnIxyobgaTPs2b1fC5DGVT0?=
 =?us-ascii?Q?+TBrhqU9nh+u+dmBJjCQggb4ZQgGunncQhQJzto6xUgEzwT1LK/H2F6hQyrE?=
 =?us-ascii?Q?sgntuksSPlXmTdt339gtF4faWsSje1ukhyAcrnY2l63Alfas85gRNWBK7xtX?=
 =?us-ascii?Q?lmreFahBS0aweo/wIB23Sm/1oIZ1xxm9O5A2kTSsjza0l6yjNbxR4Fq3v+VB?=
 =?us-ascii?Q?odspgfeObq8RHoOgddCG7lkBh+mfMbwxI9HmZhO2asohU7ndU8Y4YhdjGZi7?=
 =?us-ascii?Q?YHi3UhIUsVxMBSOJ2iB9rmKrepmBCIeLYtU9hK+U3OHyEDrX0RY1Qv+pNkfx?=
 =?us-ascii?Q?8ZHyUz9spbjEwlnRuJTsiJxDSBeaFE1E1Rie9eU92TzE2EEIT2rwe85L3odC?=
 =?us-ascii?Q?H7ojXCsnMo1Cc4QUGJfGDgDQ9KXvuOnQm/75kaarq3UksnusG2Fid22wUurP?=
 =?us-ascii?Q?6pfiUp7mU9m8JiXZU6EIEJBmX+6181Kl+i4ASW2kMVPWtOrY/vSyV5o8aQnb?=
 =?us-ascii?Q?HSOTv2+Dt0nxFkXXIP4uZWb9gQH6hqeO9qNG7lyYS0eDWCcCIqwxsdTNcPen?=
 =?us-ascii?Q?7XtuchsRQVgBbfy5GhTnQsePD1IcxDnhVpeayPS3fap4MAWGgQcwylNQkjd8?=
 =?us-ascii?Q?wxH7SVXmsTzOssqQU5EhqU5Dcv811yYDfQICq/x4BaGewIEdj/D6ghe7o57d?=
 =?us-ascii?Q?07vJ4a8hLN5Qq1JtspdH1JlOCM+BQ1Pw2BMAaaQuPg6h8mrLViGmJEOUXJJE?=
 =?us-ascii?Q?2M83kJiUVEI+fAMr+HIKSjsy11q6Fyt9EI1GsfBLr6GRDf1ulGEIXhXk6QlX?=
 =?us-ascii?Q?9VdHqmfPZFFMThmmCvOa6VGDTsTkGAy4VHHbcpvQqos8Vyi1N/5SQftXZhNA?=
 =?us-ascii?Q?kwKo1uSMkjnB5Cakun6Gbu94c8dw3TAe9ZLD5SHiVlVnKfwwP5lfujq0HMc6?=
 =?us-ascii?Q?Id+FvdEpHQqRJioTQFRyTD6m4E6cH35YpCBsDOMqIenOXQIxqpMRcKhJ74+9?=
 =?us-ascii?Q?pXKQo0SWAVgEgYGE4S1N0s07rSOWo7O5sUHMZjiWbMvdbR1871vBO24hvlwE?=
 =?us-ascii?Q?S/u+i+0r8YsPo+SvbV/hlZtOQPSDw8NnHt+Iq20mMQUkR+YnbUDDtegmE42u?=
 =?us-ascii?Q?HuxV2SqOvWKuY7s3Dl1oM80/n+5cCyUCA8hpNkkwmpXyr5f/nyh8myBH7Tfz?=
 =?us-ascii?Q?aGLEo/o0YGpEiRsWqPk7eVdHIstYMy+ibsrvQdgpYFNhdTYezzCrubBGt07G?=
 =?us-ascii?Q?gTQfUxDxFjry3Nc4KkpcqKpwQ7Sk3u1zDy6sb6ro975XQUVJcZcInwJKfKBC?=
 =?us-ascii?Q?++dI5tkHa/M01A36FaWnOpoJLZaAny/8g9oLMbqbxcVqEyfmy58u2mJo87Ks?=
 =?us-ascii?Q?QP00Jh58BOcFZHPw7vHqypohdH8YPC53SREmG3rast4JcVDMTl9uXA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2025 16:58:27.7681 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f7437a41-ef12-417d-e16d-08dd42187bb7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7799
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

No need for an IP specific version.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c | 27 +------------------------
 1 file changed, 1 insertion(+), 26 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
index 9588153079675..4a2854238c618 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
@@ -80,8 +80,6 @@ static void vcn_v5_0_0_set_unified_ring_funcs(struct amdgpu_device *adev);
 static void vcn_v5_0_0_set_irq_funcs(struct amdgpu_device *adev);
 static int vcn_v5_0_0_set_pg_state(struct amdgpu_vcn_inst *vinst,
 				   enum amd_powergating_state state);
-static int vcn_v5_0_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
-					    enum amd_powergating_state state);
 static int vcn_v5_0_0_pause_dpg_mode(struct amdgpu_vcn_inst *vinst,
 				     struct dpg_pause_state *new_state);
 static void vcn_v5_0_0_unified_ring_set_wptr(struct amdgpu_ring *ring);
@@ -1319,29 +1317,6 @@ static int vcn_v5_0_0_set_pg_state(struct amdgpu_vcn_inst *vinst,
 	return ret;
 }
 
-/**
- * vcn_v5_0_0_set_powergating_state - set VCN block powergating state
- *
- * @ip_block: amdgpu_ip_block pointer
- * @state: power gating state
- *
- * Set VCN block powergating state
- */
-static int vcn_v5_0_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
-					    enum amd_powergating_state state)
-{
-	struct amdgpu_device *adev = ip_block->adev;
-	int ret = 0, i;
-
-	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
-		struct amdgpu_vcn_inst *vinst = &adev->vcn.inst[i];
-
-		ret |= vinst->set_pg_state(vinst, state);
-	}
-
-	return ret;
-}
-
 /**
  * vcn_v5_0_0_process_interrupt - process VCN block interrupt
  *
@@ -1483,7 +1458,7 @@ static const struct amd_ip_funcs vcn_v5_0_0_ip_funcs = {
 	.is_idle = vcn_v5_0_0_is_idle,
 	.wait_for_idle = vcn_v5_0_0_wait_for_idle,
 	.set_clockgating_state = vcn_v5_0_0_set_clockgating_state,
-	.set_powergating_state = vcn_v5_0_0_set_powergating_state,
+	.set_powergating_state = vcn_set_powergating_state,
 	.dump_ip_state = vcn_v5_0_0_dump_ip_state,
 	.print_ip_state = vcn_v5_0_0_print_ip_state,
 };
-- 
2.48.1

