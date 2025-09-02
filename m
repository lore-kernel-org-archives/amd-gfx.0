Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F220CA1007
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Sep 2025 00:46:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BC26410E54B;
	Tue,  2 Sep 2025 00:46:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="X7Af+DdF";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2067.outbound.protection.outlook.com [40.107.236.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1E45110E54B
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Sep 2025 00:46:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ptPLtmzkCBseWzZwvj8k+2dcB7rpK7nEUF+mSaeNKAFt0NnvefEgWOUIh7qInC6wG80W2pdRbqKMSK5g5Bvu9r8+vpqhYaIgeMum3avfNRVTy8XnzkRDsgdtCnaskrfwewkWFWyvI/3D4NXNm49Cwms8V/CtHTKee+zDWrmNq+wQ+gnVUbhyYOnnLx2kShphw7G6LdM06NxBfUq/sTm81GKgVtqPSGCp5wa6IGb2dq3YZYd+1sb9dbtqhdbkB4SewnrD0f1tSPF3VC5p8FU1cbIl35Gn34bTodSHb3hErZqE4dE0V4L7nw33QQdjl76oQooe2zTZ2Ezcc3MFyYin9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3pvF9R9Rij3FVlziax7X39D+TO1UOhYcq8f6Df2P+es=;
 b=rJahxaSJRAEkR+dhKYZW02VE2jzZGfedg/Z3Ewf2aEjGc4xOi7nO9g/9v+yuiOT0yGMsAQbq6EsP20EqqfssOFcvFOkxMF94Jw5BA13KM68JnbjULOUuyYpll+vQXbeE1ch92lIMy509BL9rWF8Gah3H+jql50D1AJxCCbzjQk3oeMjBu6m/vy0JNCuIWa1xv13E9WH1U4YcXYf+TqqugV24+dHGxRJzoE7m+Tzs6cfzzOykVCdbno9CqIaarvP7/jo1hJZw0BgwD7DI0UrjaRjY5A3LxIkJT4doVAnwbU7RDNc1S7VZOH0AyV1qYIKBBXLdoDOGfFrmXt8/1sOEIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3pvF9R9Rij3FVlziax7X39D+TO1UOhYcq8f6Df2P+es=;
 b=X7Af+DdFq5FaJuQcCwtKQxWw6FosTzvzNGim/3CdyLLQvfeI0cEHMuh1inaYC6P4fIxnERM8XVXoNwtw0tDMfSyJQYgqRCoEuesLncEU3Bmr9H1KEfgRy+MpeOyZbpWck8NixtKJOjNpPkJMlccb7Wmu7LmVjCkYg1yDmrEgk00=
Received: from DSZP220CA0001.NAMP220.PROD.OUTLOOK.COM (2603:10b6:5:280::15) by
 DM4PR12MB5964.namprd12.prod.outlook.com (2603:10b6:8:6b::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9073.27; Tue, 2 Sep 2025 00:46:45 +0000
Received: from DS2PEPF00003444.namprd04.prod.outlook.com (2603:10b6:5:280::4)
 by DSZP220CA0001.outlook.office365.com (2603:10b6:5:280::15) with
 Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.16
 via Frontend Transport; Tue, 2 Sep 2025 00:46:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003444.mail.protection.outlook.com (10.167.17.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9094.14 via Frontend Transport; Tue, 2 Sep 2025 00:46:44 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 1 Sep
 2025 19:46:44 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 1 Sep
 2025 19:46:43 -0500
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 1 Sep 2025 19:46:34 -0500
From: waynelin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Roman Li <Roman.Li@amd.com>
Subject: [PATCH 07/11] drm/amd/display: Refine error message for vblank init
 failure
Date: Tue, 2 Sep 2025 08:42:52 +0800
Message-ID: <20250902004532.1833436-8-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250902004532.1833436-1-Wayne.Lin@amd.com>
References: <20250902004532.1833436-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003444:EE_|DM4PR12MB5964:EE_
X-MS-Office365-Filtering-Correlation-Id: f25e0aa4-7257-4059-5606-08dde9ba30ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014|43062017; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?v1BLW/GNun92oEBiwLdEyKaEEOiG+O0c7ntz33DhuFPOKcatd9DBnNI2+/3j?=
 =?us-ascii?Q?d1W5+8xqwFJXX+qMg1Ct2e2CS7jMvaV2eyNf7pBc1N0k3+eya7d1WNlKWfks?=
 =?us-ascii?Q?pCZ0qUYX1RHgDDlOI0eHhkeeCRIpy7nBGjOP1j2APDFV0s5uaGVt++rSW72c?=
 =?us-ascii?Q?nE1z4KXZuvS33O5y61VQQNKgS3Wo0XtyOrXWNmBFVn7CYcebcZFhrr5Gtebb?=
 =?us-ascii?Q?eBQZGviA7KsgWJEhzEdJ6xYhVtcwo30MAvu4u28nek8qjR/7nBQXEqO+3tiO?=
 =?us-ascii?Q?ehCvp6kODRgT+WDlOj1bwdPtnMO/UkAQdaGxF2lAn1D573BX99y1a67LVESV?=
 =?us-ascii?Q?qfWr+oqwzMMXcYIGtg+9vsYJc5Nhwrf0ZXNFwE2xGF+nbOoRDk4yMkcdW+kV?=
 =?us-ascii?Q?FlewRycpH60nbmJpOaCi6enSiC6GTExiJdeMWgurpnPd4wdaUBRLT93wnEdo?=
 =?us-ascii?Q?mtSIbvVNWMBWrhPrMg8+4zIusU33D1fgvQq4RPdudAh36y9Q6oKep18RiOR7?=
 =?us-ascii?Q?SDNuTeRzqGA2OvFiTJuCagiLZcl9+7RWmNoKLCZ2RlSVEYp8poOs/gfk96cj?=
 =?us-ascii?Q?HyuuTyEEYjGg6iV3l0c8tj/U0oELM64HYOUY3vNNoXRjWgEuPmTbIE9XFzxr?=
 =?us-ascii?Q?c37mWKUt7gXpnr6BeaoRYSMnIQoixaLUVcsYrL5BW15/NSOjaHzDAOc+ITyL?=
 =?us-ascii?Q?pThUwXljiLQoBbfnm9nLhvp1btdQvXTQb0Orehwn4vPFzPm62ao/DgCAgdKF?=
 =?us-ascii?Q?+ny3WfCFmBasuhx+7wUIGBGijSZ/J2WNPXMcJiME0dFO82ImhyiWVLdZkMa4?=
 =?us-ascii?Q?QUaw4PJu0HtEsSGie7p07gkTDVxu8cnImUDO7A0XUF9TNPcxdrddsxeSJ1Ld?=
 =?us-ascii?Q?8aQKxQAKL2saguEY/MBBw5xzLsYx/eZw7gHiVVEI8BsQotWUcAoxBihUr9z2?=
 =?us-ascii?Q?+RwElDn6XZ7vBGxpWZusAtGCwAiKrLulGvRyGG9odLEQv4CQ7ak6ZvFhxbw8?=
 =?us-ascii?Q?sXDNsXeN4iHBjlIeFvaOzxTX9x7ZEwxYH5l16KV/6vZ+triVLLy6HhRgU8Mu?=
 =?us-ascii?Q?N8KS8YAEhmew/2vkLUQFJXThbzYkoHSres5h7quh+vCuU1izcu0WnauMkfB6?=
 =?us-ascii?Q?ze3wcjooR69ACxPNWgGRsfwjaMBbCg79TnilFBEwr84q3l+Ba/XoGztyr40w?=
 =?us-ascii?Q?aGDL9P8CSS7T3uxZ1kNEeZjFrM5K/j3pesPSdzxd1sTVz6pl6HywiyZRf0UK?=
 =?us-ascii?Q?ZG9Rm+mvXFyXefiMEn3c2xZazs6AShO1R1WuMNxkANklk6796Tg0b0Fz21g/?=
 =?us-ascii?Q?djifU5rwdaxkwYW6XNzXC7GcbpASkcBH3OaQGbLrNB/IXWSRMg7+iYhLtXYp?=
 =?us-ascii?Q?8bqK51uKn4V7pSivEdEcu462DKX2aI2F6G3o+JxilZ00IsCFbDNgbovUtQbs?=
 =?us-ascii?Q?SwBEaYQp5Mr7TXrR27fDN0EwBgLvTKyL/9uw79tihtOR5exBUTP9IKzCToyn?=
 =?us-ascii?Q?Q0NdjFYj2HfMF05M39n5cq9NUcd9dU9QI6Ni6ain32yYqZEac0TLf9jThw?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014)(43062017);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2025 00:46:44.9726 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f25e0aa4-7257-4059-5606-08dde9ba30ed
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003444.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5964
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

From: Roman Li <Roman.Li@amd.com>

[Why]
The error message "failed to initialize sw for display support" is used
for both DRM device and vblank initialization failures, making it difficult
to identify the specific failure during troubleshooting.

[How]
Update the vblank initialization error message to
"failed to initialize vblank for display support"
to distinguish it from the DRM device init failure.

Reviewed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Roman Li <Roman.Li@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 7470e1a21279..9273bc3849f1 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -2186,7 +2186,7 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
 
 	if (drm_vblank_init(adev_to_drm(adev), adev->dm.display_indexes_num)) {
 		drm_err(adev_to_drm(adev),
-		"failed to initialize sw for display support.\n");
+		"failed to initialize vblank for display support.\n");
 		goto error;
 	}
 
-- 
2.43.0

