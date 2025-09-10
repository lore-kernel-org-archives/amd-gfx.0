Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29D54CA101F
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Sep 2025 05:33:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9FF5610E859;
	Wed, 10 Sep 2025 05:33:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="I+Zs0Fbi";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2043.outbound.protection.outlook.com [40.107.95.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A9E010E859
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Sep 2025 05:33:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h69MgALcnpHVjqHTDTLGOeylXpmqzpzq/uweeoKE2ApGt3xkiImgVkSEZLetHP3bNdnCapC1qeZEZqvOK1JGUSZoDpc1wUKXBAe61JgqA56BNkSretRB8GFv8WD1ogmOjWSTSh5iF8WvREgRDqFe3Zne/n06ZvtQCKFXMAhqR+g5WLyNb+to6q0SiOfU5VYgvsgHA/gmeQp2IXu4w+pgIySMYaY9UL1XLJ/jRg+Kwg8SPeei35Y4zNEmRrYE6MvV4O4yIsqh5hvOcgZwp1lebNSld+NMVs/3STi6vbPbL64kWKJ0Jj9ScFM+zd+3eO3MVlbCq4uXj7T8QlQ51M911Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vJ89d6Wt7cDiA7TjmLfwSt0w8COqzr3V5gUAmiaSL68=;
 b=qXQ8Nxwy2FpOmKtlb0u0ts1Ue0rL8YI76lkJEO3Jlk3gikfSYMlZL5Y4vmUvgJzkM9TYaI3KCiAZepE4dTdRNJMizygSMPEuMcdUVemCLkzOE3eOGAiUBAz+YBf0AOUW6jnSgAd4v6XawSotg311Bdyl+d15szXiArno6FzUH/K3A05EVDVJGBy14c+DwW8bYzVP04BgVdNhag5tJqmqP7VvOPtqXAb6odr7fOdtE2/LABq6SXEv/1gUY6UbGv3u/LJ7UfSjtcpusE+AWbE3dFmLHMoETjk2INFn84oFxK1J9XavUaIPVa2XoKR06vthmnBTOvUZ1Ii2rS+dS5SkqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vJ89d6Wt7cDiA7TjmLfwSt0w8COqzr3V5gUAmiaSL68=;
 b=I+Zs0FbiuWjb0tH8urf/a0vp6lwodyAOTZ3CLrUZk8ruBBsYLQEqxWtY0dtqaFeiQiYFvlL+AFfIKc4sGR7enbVsz0kRzWWf9YkLUmbVDGq3m3GfzfpzRLP4o9AwgyoGOI3b27Y077HeFoDUH3Wam6PQ2yzEmzQ0cya8ZXP9fSk=
Received: from DS7PR05CA0035.namprd05.prod.outlook.com (2603:10b6:8:2f::18) by
 SN7PR12MB7132.namprd12.prod.outlook.com (2603:10b6:806:2a4::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Wed, 10 Sep
 2025 05:33:25 +0000
Received: from DS3PEPF0000C37D.namprd04.prod.outlook.com
 (2603:10b6:8:2f:cafe::f2) by DS7PR05CA0035.outlook.office365.com
 (2603:10b6:8:2f::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.14 via Frontend Transport; Wed,
 10 Sep 2025 05:33:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DS3PEPF0000C37D.mail.protection.outlook.com (10.167.23.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Wed, 10 Sep 2025 05:33:25 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Tue, 9 Sep
 2025 22:33:24 -0700
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 10 Sep
 2025 00:33:24 -0500
Received: from ray-Ubuntu.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 9 Sep 2025 22:33:21 -0700
From: Ray Wu <ray.wu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, "Daniel
 Wheeler" <daniel.wheeler@amd.com>, Alex Hung <alex.hung@amd.com>, "Mario
 Limonciello" <Mario.Limonciello@amd.com>, Mauri Carvalho
 <mcarvalho3@lenovo.com>, Ray Wu <ray.wu@amd.com>
Subject: [PATCH 11/15] drm/amd/display: Set up pixel encoding for YCBCR422
Date: Wed, 10 Sep 2025 13:30:34 +0800
Message-ID: <20250910053222.2884632-12-ray.wu@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250910053222.2884632-1-ray.wu@amd.com>
References: <20250910053222.2884632-1-ray.wu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: ray.wu@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37D:EE_|SN7PR12MB7132:EE_
X-MS-Office365-Filtering-Correlation-Id: c4917323-8079-407f-d22f-08ddf02b9074
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?wXSfrCHUOWPOh/9gSF3cIf+W/GokZuhF9jcRk2g3xYrybvWG1dZzKe/p0l7l?=
 =?us-ascii?Q?WUoUzVzfdyRnEAkO19l5CGRkWarrNJyZVd1omHEKCFUg0kjrjpJIAXEqUt3Q?=
 =?us-ascii?Q?SjTQdU7l6F5k7wSJb4JYfCArJGcO4mrq+/qg0MbeBxlk8gIP6z3tOizj6VOE?=
 =?us-ascii?Q?Da8DSgRoSRp8xDwi/JD4kmOspOJQunMKqktiRJC+RjKXG3wtVQhLJsJS8Fbq?=
 =?us-ascii?Q?njnut47HQsP+j7e8lP4NycbCvPZCVj+cLvuqH1aWKG6p5OsT/P9myLjZ4Kwf?=
 =?us-ascii?Q?1zm2YKXdIlUcgBXghML5EhC51DfZxLiWvHEuJkZI5iWnbpqkWX7WBqQb2MP8?=
 =?us-ascii?Q?nOT/Eif40lXOZdJexsXDqvOqgr+ac7nip99tIe38a7QXLgD0z/pUvWfP8X+G?=
 =?us-ascii?Q?+Q+0v4Jm7dr9js/5jzlN8ZYZ7nDFAovfWvGIuiR3gNKW8ntEQNSRalBneHWA?=
 =?us-ascii?Q?S5Yo2K3AyHEHnnEZOTjrg2Ux7WdLXiymN1EGCBuF4M1eIpmcbXSjnTSY8ubL?=
 =?us-ascii?Q?RNnkqXmdwHvIWwbIjJLBZGXKyCv91IaI6lFOJiDP6Ay0yo6VRzE0wUQcPB3d?=
 =?us-ascii?Q?NTTfEigfMl4s8GNVF4+DbunXaXccAUvV1o/NxmYP8SCsopIiefpXXXtfW+An?=
 =?us-ascii?Q?THPWQHw0TapO7MDRvkKooQKKZqb+eDK/lpaY6mj/qrb4aziIA+PTyOwDx8e0?=
 =?us-ascii?Q?EZQxLHeWZFEKW3bp0Dmk6/cRuJhDJHpLU8GETycfUyR2eBtA4LTYsNLo91lq?=
 =?us-ascii?Q?m4B7WNw1sYf2wr/XNwfnTVp0tt0dVOoGKfjkFlNMcF4IMaQgZ9ZyyMUzOtFS?=
 =?us-ascii?Q?ddTPAN5FtNTPLqkeeSjxAGb9LQGOKON1auPuuLG7tAqFzgUoRsoQAMUrGx7m?=
 =?us-ascii?Q?o86d7m+yjvGh4DQj2p1Ob8rn0bgwf3dRq57sFmGBYx14c/0xHeq5hHbQPv6t?=
 =?us-ascii?Q?oQWV4EsQ+StbZc22MkaB6FVTX/RXdACgM3SNPYd8/KZsgtjJNIIWNVhQkN4c?=
 =?us-ascii?Q?ydHAKw983xNUh8l2+FzoNMXHFivAxM6i9RXDMINN9+el1bhjh3AW8QzvoNFP?=
 =?us-ascii?Q?e1Oha8q3f56y7UHO36NwSVq9oRMlScdBhHaSLb6hfxQavC5Z4iZd56hr4HC4?=
 =?us-ascii?Q?9fyM+9GNB94+Pb5Bp5+CZ+DEwx4uMT+nG1yZP2TO3uKLAe0Ssn8v4IgveHf1?=
 =?us-ascii?Q?cS50W1iID/+8qznu5ikHU9ZEijNFH4hyTBNN8N9LggLpdhdtZQ8L4xigqvTV?=
 =?us-ascii?Q?xreqoDVonnodDT2qoA4l7EJOgNNJojClxxcRy01CreAWDZAr1I7eC+YLk6jE?=
 =?us-ascii?Q?6tf3FirRc0JoNCsoq8ltVkEfKLPEpu66oQHAQSf0rTxkvvvHz1FQf15prgnL?=
 =?us-ascii?Q?Nqws0hs0xneXZYrwEjV7MZG/QbuXyg1o8Da1I9R8cBZR9UvJNBPrFxRf0e0i?=
 =?us-ascii?Q?DIsxBXcYLwc3zmmH7QBxkmU0sPDuNHFohoJGVBfVASYT49RUqlYNhutr7o6H?=
 =?us-ascii?Q?ZSXFXcMOVW6BINf7PmgXanTWwi5w2aHmNplW?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2025 05:33:25.3499 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c4917323-8079-407f-d22f-08ddf02b9074
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF0000C37D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7132
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

From: Mario Limonciello <Mario.Limonciello@amd.com>

[Why]
fill_stream_properties_from_drm_display_mode() will not configure pixel
encoding to YCBCR422 when the DRM color format supports YCBCR422 but not
YCBCR420 or YCBCR4444.  Instead it will fallback to RGB.

[How]
Add support for YCBCR422 in pixel encoding mapping.

Suggested-by: Mauri Carvalho <mcarvalho3@lenovo.com>
Reviewed-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Mario Limonciello <Mario.Limonciello@amd.com>
Signed-off-by: Ray Wu <ray.wu@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 849c45d10ad6..1f9c56c288b2 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -6405,6 +6405,9 @@ static void fill_stream_properties_from_drm_display_mode(
 			&& aconnector
 			&& aconnector->force_yuv420_output)
 		timing_out->pixel_encoding = PIXEL_ENCODING_YCBCR420;
+	else if ((connector->display_info.color_formats & DRM_COLOR_FORMAT_YCBCR422)
+			&& stream->signal == SIGNAL_TYPE_HDMI_TYPE_A)
+		timing_out->pixel_encoding = PIXEL_ENCODING_YCBCR422;
 	else if ((connector->display_info.color_formats & DRM_COLOR_FORMAT_YCBCR444)
 			&& stream->signal == SIGNAL_TYPE_HDMI_TYPE_A)
 		timing_out->pixel_encoding = PIXEL_ENCODING_YCBCR444;
-- 
2.43.0

