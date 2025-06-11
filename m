Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B77EC71141
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Jun 2025 18:41:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8530310E6DC;
	Wed, 11 Jun 2025 18:41:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Qc2t3ZGu";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2051.outbound.protection.outlook.com [40.107.220.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7F55610E184
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Jun 2025 18:41:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HVsfGFhMtkV4QdPJXMJNUCUuR8bJYiFYizBk4ytZ8ew5p2iT2d1EiLd/KaOPp5fhEOsrD6iTLDndDOYpVxpfYhVMG+ezZB3h9tlVvxGQboyExwiG2WGx0VF+icFdd5jzi4zi9pBzB0w1oaYBFOx6jHWwkwyNklF6oCQKASE+SXCrUlk7ttZKvWwUo4tuRnARigSI0hVWp+/Hta3lHuym66BhaOdZrZ9exq4fDtssphC8oD5k1QkfIGJ7nAu4SC6BYD8wrTpmovOBFFuK0MYi4oZCWmqowSAbhVe8SNeOCnSonZTUYuu7dQnn+DdpaJPBmzschriBvoEe3BCtx4xw+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qw3VIkG8U9BCK/qyxVyYIMvVLzUXE/fGpZbpsTQYRNg=;
 b=vctgI8mg4h93TxUD7XS9MhjBIOFNnhwSEbCNexS4GFlb4zS+SdjNF6/Bj01EJe2qxIEfzk8aIxUvT8aZEcrk4vNgEc4LejVdVSMV37X/07kgtUgB21Vr6HT6/D6M9KFCC2+EEjmmYuyXkC1ooaOVesMPziuVF5/H3ZPLKdznYCifFVptKxAzGlhlHLOALCfWadEmNWAzJsIpl9WBobbSNCp7VHUcn9BYlrwoAQlnZf8vnbgRzdFSCkv49eC5KIBGn2MORCxHR0Jo30qZ/NvJ+zoyFTtqGgtW7gDdoYHhvUZGDGCnRlxqjr+iDAlo10oFOoiXym6+hx2EMnEryxtpLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qw3VIkG8U9BCK/qyxVyYIMvVLzUXE/fGpZbpsTQYRNg=;
 b=Qc2t3ZGu+W6cb4RQLQmMVLWSw0ekSk3g3046Is9LdsBW0Zb8NGWaLEce3RqXRrXR7apWpLKKxrRzc8wZcOI4ohU+f2r9aVdkGMS6rBaO8bGvjCcGAcTzH92O6taDtDlEhHhr6cxTgk0quSBabzP3RjWI56FAiwizCcaB+g3Cnhw=
Received: from BN9PR03CA0488.namprd03.prod.outlook.com (2603:10b6:408:130::13)
 by BY5PR12MB4244.namprd12.prod.outlook.com (2603:10b6:a03:204::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.19; Wed, 11 Jun
 2025 18:41:18 +0000
Received: from BL02EPF00021F6E.namprd02.prod.outlook.com
 (2603:10b6:408:130:cafe::a7) by BN9PR03CA0488.outlook.office365.com
 (2603:10b6:408:130::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.35 via Frontend Transport; Wed,
 11 Jun 2025 18:41:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL02EPF00021F6E.mail.protection.outlook.com (10.167.249.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8835.15 via Frontend Transport; Wed, 11 Jun 2025 18:41:17 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 11 Jun
 2025 13:41:15 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 11 Jun
 2025 13:41:14 -0500
Received: from aaurabin-z5-cachy.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Wed, 11 Jun 2025 13:41:14 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Alex Hung
 <alex.hung@amd.com>, Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 04/10] drm/amd/display: Disable common modes for eDP
Date: Wed, 11 Jun 2025 14:39:54 -0400
Message-ID: <20250611184111.517494-5-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250611184111.517494-1-aurabindo.pillai@amd.com>
References: <20250611184111.517494-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6E:EE_|BY5PR12MB4244:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b9df7da-9e98-49dc-f5dc-08dda9178d70
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?s0e5OKfvLcFnTnDCXASbumc+36d+4Q343M1Reo5E6vcoXDvcMVUdj+PzVrnH?=
 =?us-ascii?Q?0UjWY20n6Q5tGfEK4tnmRXQIVU9/Ykr5kDZWnPeHo4iwWtENTF3megfMPL+Y?=
 =?us-ascii?Q?iONddAbqTc3fQvjxwKqRE2+1fvDZCIkvqL4tYAVvQZVPinBIxR5/hm/qODGk?=
 =?us-ascii?Q?8gv1vOjRryejcgk0QHOinCyDaHig9QHTo9sCsCi212K1QEcYdQU3UxDybwCR?=
 =?us-ascii?Q?QoV7LwR/27lNmZJApOR4W5BqiG/7bHVDBam9d30YGL6CQNV3n2jFUUTC1pYD?=
 =?us-ascii?Q?jjXy54s0twxuwG+9V+ro5M1ardls5yTSNjFvYeCaLyH6MiddRPMCPy1I0d7m?=
 =?us-ascii?Q?HAFKI7c5cVnCZtm7d36/JVzJapeuPHDNHUlQVZOrUzHN1El0tQNIjgC533FS?=
 =?us-ascii?Q?owbvhn6JCvP1od9b1z+l5yXInEme7PNOX3h/P3nhE/G/Ua4Dl0qgXGvjBMl7?=
 =?us-ascii?Q?2o67uGLQEzmqRa1fkl2+WBgzBPHEX5nL8JXLXNjX6oINP5WXPpXIsIuqvi7I?=
 =?us-ascii?Q?5L52dOVVZGmi/Wjso9vEjb9Jpb5v9llHQUgrZn46jjwJC17B40WBBXM/jn3N?=
 =?us-ascii?Q?l6Q5UIHWoL2IpbQHbFzv3ZCxPh4NbqnbKfMR+DqUtsogegj3qmjGSpQvFpoN?=
 =?us-ascii?Q?YVRlZnqjY2Q6+ubgKH3ZwO1J6N1gjfpzorbEbN990LspE547dLinV4MrK+YB?=
 =?us-ascii?Q?auG66geudGC5gYQ0dCRxgMgNyxBNfm/JMglPtmkfz+MKyQfWPq8WWCZWqPNU?=
 =?us-ascii?Q?fT8/4mMK8nER8RrbddWDoC1QSxT/9T4ktf4t5MaxB2iMZMAZb5B5jRgkL+Bt?=
 =?us-ascii?Q?Hcr6BUzAzVkP2dJ73o4qA02V6VBD8FFGMH1yFmMLKEkvyph3VfzFLiWdEwHH?=
 =?us-ascii?Q?scKiyLcZeGVg2wZbr+d13qsfmXbsrtSkJvjs2EPQvAdY8/Ve9+arIKbQmUsh?=
 =?us-ascii?Q?+/8tnYzwUuRryiEwcUFMatUJWZr5wny8mAT+IAWobYtRq5cm2lR9zsiQdydj?=
 =?us-ascii?Q?2yYlchJjFthd8SgxjDTe6rw3gyRAeGYjGRr8gfeG7YGTLplYtaW5cFwoOW0A?=
 =?us-ascii?Q?0ZWTxh1R5hJH6HuwFM/1LI7+AAuh0eEbn9RH1zc9EmHf3XwDl9upQ+kcFIcq?=
 =?us-ascii?Q?kdLWlyYq7xORm9LMAioMKpRRftBv5e8hrvj9PPLJAPJCasbJlgJHYre1ekj2?=
 =?us-ascii?Q?tV+4AgPys3s1/Hike3m3fE4uQ+6g/sZ+hnQqGZF1dxLTAncsbxueWNiMhiys?=
 =?us-ascii?Q?iyoMoQrbQdztwrWumcykS5zTxR/T9vOKtXAVqBS9OejRQlj0VZ4A27rr3BfB?=
 =?us-ascii?Q?E6ivKVWniypGR4z/bH8Rqk4SP/R/bOAgPfB/mEmY5AqS8nn9grieV+zT8PQr?=
 =?us-ascii?Q?5/8K/wAF2HVcxVFgNHVtRifqMYvJzkFcIVn/+MpJcQ8RVsE2ThPXsLeiBx2S?=
 =?us-ascii?Q?aWoejPWa2LahaffMhWU1eHBjRQZBZZjd+KVumGd08RTjkAA6nFjr45mpH5l5?=
 =?us-ascii?Q?5Ux8/8I7rRB5iTMfLTG0eNI0shv7n9zANhM7?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2025 18:41:17.8354 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b9df7da-9e98-49dc-f5dc-08dda9178d70
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F6E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4244
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

From: Mario Limonciello <mario.limonciello@amd.com>

[Why]
Common modes are added to eDP for compatibility in clone mode, but
not all panels support them.  Non-native modes were disabled in the past
but this caused problems because compositors didn't use scaling for non
native modes. Now non-native modes on eDP will enable the scaler by
default.

[How]
Check the connector type.  If the connector is eDP avoid adding common
modes.

Reviewed-by: Roman Li <roman.li@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 12cbfd7ffbc7..3972427f4796 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -8364,7 +8364,7 @@ static int amdgpu_dm_connector_get_modes(struct drm_connector *connector)
 				drm_add_modes_noedid(connector, 1920, 1080);
 	} else {
 		amdgpu_dm_connector_ddc_get_modes(connector, drm_edid);
-		if (encoder)
+		if (encoder && connector->connector_type != DRM_MODE_CONNECTOR_eDP)
 			amdgpu_dm_connector_add_common_modes(encoder, connector);
 		amdgpu_dm_connector_add_freesync_modes(connector, drm_edid);
 	}
-- 
2.49.0

