Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 682DBCA1007
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Sep 2025 00:46:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D3D8E10E008;
	Tue,  2 Sep 2025 00:46:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="SipXiD8r";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2053.outbound.protection.outlook.com [40.107.212.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B73B710E008
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Sep 2025 00:46:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y2wdJWb9rY7TGWJl70oM20PJBbN4XHuufeyfFrBCL299BUKJjLxlnCQmUuWPCQ/Hf7jZhg0wrT6qyfiyPd3H10mcDaqT/W2P01QAhlVml+wvz7tmElj8DESDwxGByRnmnRySuug1v5A1semQtmXiinZqea4xDHl+aAGZG7OgoUBFGmNe0E0N00zsRaPglTlGdJYr8kHKSTNUOh+7c+Ix2W5uHkec77dyme04O7MI+pvPjTZgynSnsoZ1V7VPUd2IRGxIxblfKuICXwt3o/K/jacLqJYZYYhCHfMlLiaBOsMdL2eFV2zzTEFAopsBtBa9YGWfSRDnWB3Ti3ILm8DAjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pC5Sv9YytXU/hQJJI7xa9J+tObTjQ2fSCpo9UlxOtug=;
 b=uUA+13L0HTaBznE2eFRUdvYhFDBUr+S+tJH0ENri+1eZNqvneqL/n+QxeZUT5NcSkWT15WVFVUyzo93QCrp7wYDl7fLpNCneINeB88rvVW4BWlwYH2MZ2Jeso2r5NHj9ruPHpGWa+eK8fm3tuaiMpvU2X+dxczeZlAze24WWOvjivdMd1XKXR+N3YiH1Lzd0/Ae3cts6ppgVX3dX1hIeSBu8AeF0PcOoPrbb7XL/YnBCdNRxyB6yYZR4FJLNOerQFPh5Ytbggy8yl+WwGRPRFqWRfgKnQ1bq7zp2PRdwU3KDu76oCCYnPfxVIjAaMY8HlXeSwaHOClRqmMXC7N7K3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pC5Sv9YytXU/hQJJI7xa9J+tObTjQ2fSCpo9UlxOtug=;
 b=SipXiD8r+YLhwOOi9Z7z8dqHWhZ13R5p9YMDoyha55jnIU/ECxGCb246JJXYg72Jy7WQW9vDfaau0VsTL3f4PwckrXjDOf2XW9R/h24gwt45aCLUt3M2LiWqavNG7REdpo9kBgj7qz6feypDjLOH6XrHq5waXbgVqX0Wrk/fFv4=
Received: from DS7PR03CA0157.namprd03.prod.outlook.com (2603:10b6:5:3b2::12)
 by IA4PR12MB9836.namprd12.prod.outlook.com (2603:10b6:208:5d0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Tue, 2 Sep
 2025 00:45:58 +0000
Received: from DS2PEPF00003443.namprd04.prod.outlook.com
 (2603:10b6:5:3b2:cafe::67) by DS7PR03CA0157.outlook.office365.com
 (2603:10b6:5:3b2::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.27 via Frontend Transport; Tue,
 2 Sep 2025 00:45:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003443.mail.protection.outlook.com (10.167.17.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9094.14 via Frontend Transport; Tue, 2 Sep 2025 00:45:57 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 1 Sep
 2025 19:45:57 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Mon, 1 Sep
 2025 17:45:56 -0700
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 1 Sep 2025 19:45:45 -0500
From: waynelin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, waynelin <Wayne.Lin@amd.com>
Subject: [PATCH 00/11] DC Patches for September 8, 2025
Date: Tue, 2 Sep 2025 08:42:45 +0800
Message-ID: <20250902004532.1833436-1-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003443:EE_|IA4PR12MB9836:EE_
X-MS-Office365-Filtering-Correlation-Id: 040d3e97-c57c-4869-0582-08dde9ba14df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014|43062017; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ZH3f2sJc+/ydKg+c10Ob3zKjEiNaKjXFOdAdT081ls4I17sn0wzgBKpANiLa?=
 =?us-ascii?Q?JSgSLuWFPf7Xfrd6gmeer7DuqxX0A7Y5eQN2aVIXJl8ptyjPdy8J3hFmLW8a?=
 =?us-ascii?Q?fK1MMy7C0rVGg33iMmhnqiI2SFph27a1RFH4ze9zIuhvGfrMj+7ZPGi5A29w?=
 =?us-ascii?Q?hMshpux3ZfNN/q3rTSI4VcavSUDA+MlofvkWPsd6Sv4cm76VxRktT8gfgneU?=
 =?us-ascii?Q?JDZoy8j1iFKIkHWscKk/RiM+xM+kBeHmr8RYJj4OJ8XxIIhnCOYD8F3IXPeZ?=
 =?us-ascii?Q?cOj1AKMn/hciGe3sS7wn6clj/7XAbsHjit5hRedg2oo+Z9UBw34l9YI+mqe9?=
 =?us-ascii?Q?ktnIO8Z9BGpWwtjAfkBiXq5MgAeqAzIlqkVifwyKBJYWMsYMXzfWuHoX7UUH?=
 =?us-ascii?Q?IAVtRk+dnwj/VcHhDrRLZ3z5BsWv5PvpRAQNHW1MqcMcRbLoPQZpJt32NHtu?=
 =?us-ascii?Q?MM9IBTO0RYOEE3h30cJ2UDvOG1GfxqTIx0l2t39MX9ubECU1iwyK5rihkElU?=
 =?us-ascii?Q?qWc+u7UU4iZMjV0nbTGGTCIF8yIHCsFE3pwqt+12K9TFD2xo9BEDW6m+/UsH?=
 =?us-ascii?Q?8w/FHTValQ42OKmaYaQzFOZGhIdKP6nlr1IeatH+ALCySCestZjdZgdvQVF1?=
 =?us-ascii?Q?N18JTt9Vw0kLFocBwvgKsqD0xKYB8YEBnVjgPpuj4vSkNnxh/62g5s1yKHoB?=
 =?us-ascii?Q?TdpEvGUUzAOgP2M37l/cN7tTCnLQmdtlt9SQtFNnKbllo6GbJNnC+PLX8Mwd?=
 =?us-ascii?Q?vdVabR8l2p/wY59VTFF7mb/3uRr6mWXWzLFUKCTxnClAMOq8gOSHarL4E2SI?=
 =?us-ascii?Q?Tvl9SC6jigxdAYiFCjulalXlYfFAESrqPAVQz06iPbGIJxTRdsnt9udBU7M/?=
 =?us-ascii?Q?1JCWM3XRMcTkqwcf0SuwNGozoWscGiDwabIy+IkvTkYTyBB8w2UxujALySUQ?=
 =?us-ascii?Q?0+1KPza2i57EXbZd4zYukZO1ZMlK+IRABpDqd9qiPxq1PrGBzEzIksj93+QS?=
 =?us-ascii?Q?lftP2FkT6xK60/fkz3c8MwSPDuo4Z7hP/aCHouFmVi3Ya4ydp2+l0FBJyN1Z?=
 =?us-ascii?Q?PTj9KGa4Kw0/MaJhDx/hM6lv3EP3G2cOVXYcx5+0oMTsFiRh82GbP+fcA4hz?=
 =?us-ascii?Q?khWIP4TlE9erMNCHhAamqkOocGAzsseRUXGn9cfMSJwYLUpvJeYEG11NNqmK?=
 =?us-ascii?Q?gJl3eBIJcD7RShKKVpUffKdYi0cKXETfU8i98cjqQvEW3KSr/Dg3SWY9I6bx?=
 =?us-ascii?Q?DlS9QcHFrsxWAjQ3V8q4AeM2Saqjlzdf0Sbua8R/WHIeG5hCTBe478e6kH0N?=
 =?us-ascii?Q?dT3W4enEXwKgWMjQ1f5JBeOgDLWJ2lsRTtieTOsCCeBL+gNvyhHv7wcTsqmp?=
 =?us-ascii?Q?/44+c+ZnLbuIIJnbKZc1UIhgMyLxHE4uDi7cQ4fJcE+VSLvnJ5tbWG/Fssgq?=
 =?us-ascii?Q?GsSfGQfSHqlM9K3Ke/3IcyI83F3ApnSNRx0LCc5+MHjA2J4v+3UYnq8eW3aK?=
 =?us-ascii?Q?blnofVXDJqMmKgNsljoMSLu/T9RtRY8UtzAAqxFIYsgCDPaaRmXlLPXFzQ?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014)(43062017);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2025 00:45:57.9017 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 040d3e97-c57c-4869-0582-08dde9ba14df
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003443.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR12MB9836
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

This DC patchset brings improvements in multiple areas. In summary, we highlight:

- Disable stutter when programming watermarks on dcn32
- Fix pbn_div Calculation Error
- Correct sequences and delays for DCN35 PG & RCG
- Define interfaces for hubbub perfmance monitoring support
- Extend to read eDP general capability 2 
- Indicate when custom brightness curves are in use
- Dont wait for pipe update during medupdate/highirq
- Add HDCP retry_limit control parameter

Cc: Dan Wheeler <daniel.wheeler@amd.com>

---

Allen Li (1):
  drm/amd/display: Read DPCD to obtain eDP capability information.

Ausef Yousof (1):
  drm/amd/display: dont wait for pipe update during medupdate/highirq

Cruise Hung (1):
  drm/amd/display: Add link index in AUX and dpms

Dillon Varone (1):
  drm/amd/display: Disable stutter when programming watermarks on dcn32

Fangzhi Zuo (1):
  drm/amd/display: Fix pbn_div Calculation Error

Mario Limonciello (1):
  drm/amd/display: Indicate when custom brightness curves are in use

Oleh Kuzhylnyi (1):
  drm/amd/display: Add HDCP policy control

Ovidiu Bunea (1):
  drm/amd/display: Correct sequences and delays for DCN35 PG & RCG

Roman Li (1):
  drm/amd/display: Refine error message for vblank init failure

Taimur Hassan (1):
  drm/amd/display: Promote DC to 3.2.349

Wenjing Liu (1):
  drm/amd/display: Update dchubbub.h for hubbub perfmon support

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |   9 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_hdcp.c    |   2 +
 .../display/amdgpu_dm/amdgpu_dm_mst_types.c   |  13 +-
 .../display/amdgpu_dm/amdgpu_dm_mst_types.h   |   2 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c      |   2 +-
 drivers/gpu/drm/amd/display/dc/dc.h           |   4 +-
 drivers/gpu/drm/amd/display/dc/dc_dp_types.h  |   1 +
 .../amd/display/dc/dccg/dcn35/dcn35_dccg.c    |  74 +++++------
 drivers/gpu/drm/amd/display/dc/dce/dce_aux.c  |  17 ++-
 .../display/dc/hubbub/dcn32/dcn32_hubbub.c    |  37 +++++-
 .../amd/display/dc/hwss/dcn35/dcn35_hwseq.c   | 115 +++---------------
 .../amd/display/dc/hwss/dcn35/dcn35_init.c    |   3 -
 .../amd/display/dc/hwss/dcn351/dcn351_init.c  |   3 -
 .../gpu/drm/amd/display/dc/inc/hw/dchubbub.h  |  22 ++++
 .../gpu/drm/amd/display/dc/inc/hw/pg_cntl.h   |   1 +
 .../drm/amd/display/dc/link/link_detection.c  |   2 +-
 .../gpu/drm/amd/display/dc/link/link_dpms.c   |   9 +-
 .../dc/link/protocols/link_dp_capability.c    |   6 +
 .../amd/display/dc/pg/dcn35/dcn35_pg_cntl.c   |  78 +++++++-----
 .../dc/resource/dcn32/dcn32_resource.c        |   1 +
 .../dc/resource/dcn32/dcn32_resource.h        |   3 +-
 .../gpu/drm/amd/display/modules/hdcp/hdcp.c   |   5 +-
 .../drm/amd/display/modules/inc/mod_hdcp.h    |   1 +
 23 files changed, 220 insertions(+), 190 deletions(-)

-- 
2.43.0

