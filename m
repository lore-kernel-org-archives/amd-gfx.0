Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64123C27C65
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Jun 2024 16:52:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9824C10E6CD;
	Tue, 11 Jun 2024 16:52:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="luH78SVE";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2049.outbound.protection.outlook.com [40.107.101.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 28AF110E1BB
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Jun 2024 16:52:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GVtCskBX1s0ZwM8K7p0AUN4FgZ1Sr/gfY4Spdb5OZfEzsFoG7p4+9+FjZva+tVV9f/HPbAs78RrvUFoacFC/kB1sElhc8ySyF9GDskN72buuwcDkP8jEAiqhDURpecTPyr9hJ2IijoxlfWiyBSfMdxjRDW3OvzPnAGwT7hO7jSvr5PQJF+mDQL9XhIpDgxRQHrKeBdlk5CHQkuiN62o1TqP+hwQMIiOZwWah8msc9mIrQSQ2F58hBh+HDTpsgLRdDr5pNMBdRjNr5H0kZWQRSJXkg0Jt+NXVgM73WQ9deI7a08gmVKgT0+5XWjFOS0jr+1JD5SS1gelNPTw2Ac7SuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kZ77YWoBIumHCDZW41i8lWyDTlS6kHZfSrt6/+A1yzM=;
 b=EWBqkplKq8NHpXljwp6d0eDhg2t6zX5Jf+/mkRuzCrQdl/ctnVWzMxXqhq96PhzRpLKOuon9NHSSH7DUBacyh0XIaOl3wDTLArmI90alaNrcWwgZwzyUOfwlACb9bus0ao4RkTb8DmHr7XC10UWnrKY5lmeAtKLxPdUbtPWfBoUIdEUZ2FafsZhE8a0G13JFPIwwpCI6uYRocehqMCJ3woD4Yd4gvDuC9dv+YllLqbN7uAK8c1uM/SzqFEO6bZqno/SHfC1k4N6jS34D9VI4q3r5pNYmx6ef3pemDTz1f3d8zMaVUigKvQij5580qZpM4TGm6KEhI+7oYk7ten3R6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kZ77YWoBIumHCDZW41i8lWyDTlS6kHZfSrt6/+A1yzM=;
 b=luH78SVESd6F/MFVhrfccaYOHGNRFha+cruwygqMPfRL3RGuHh+lyTGzOGwWBMu9sd+MFb5mqau6TBGlyKr2nWuf+ksMnj2803V3hLUVEFFsJpS9+exmjK6hFt/mPuNV7rDCShhucJXGxRFxkS/rtyeHLGJGWxPu1FDUW3u38OI=
Received: from BN8PR07CA0032.namprd07.prod.outlook.com (2603:10b6:408:ac::45)
 by IA0PR12MB8748.namprd12.prod.outlook.com (2603:10b6:208:482::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.37; Tue, 11 Jun
 2024 16:52:33 +0000
Received: from MN1PEPF0000ECD4.namprd02.prod.outlook.com
 (2603:10b6:408:ac:cafe::4c) by BN8PR07CA0032.outlook.office365.com
 (2603:10b6:408:ac::45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.19 via Frontend
 Transport; Tue, 11 Jun 2024 16:52:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECD4.mail.protection.outlook.com (10.167.242.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Tue, 11 Jun 2024 16:52:33 +0000
Received: from hamza-pc.localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 11 Jun
 2024 11:52:29 -0500
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Daniel Wheeler <daniel.wheeler@amd.com>, <Harry.Wentland@amd.com>,
 <Sunpeng.Li@amd.com>, <Bhawanpreet.Lakha@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>,
 <qingqing.zhuo@amd.com>, <roman.li@amd.com>, <wayne.lin@amd.com>,
 <solomon.chiu@amd.com>, <agustin.gutierrez@amd.com>, <jerry.zuo@amd.com>,
 <hamza.mahfooz@amd.com>, Alex Hung <alex.hung@amd.com>, Harry Wentland
 <harry.wentland@amd.com>
Subject: [PATCH 13/36] drm/amd/display: Explicitly extend unsigned 16 bit to
 64 bit
Date: Tue, 11 Jun 2024 12:51:16 -0400
Message-ID: <20240611165204.195093-14-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240611165204.195093-1-hamza.mahfooz@amd.com>
References: <20240611165204.195093-1-hamza.mahfooz@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD4:EE_|IA0PR12MB8748:EE_
X-MS-Office365-Filtering-Correlation-Id: c0b4fd3c-753f-4c7d-c710-08dc8a36e40a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230032|82310400018|36860700005|376006|1800799016; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ywqZ5pOnHYstcKQH5MPdOHBoEEKyAUJiEofC/eDgsZHGKXtd4mcRZdOE/M66?=
 =?us-ascii?Q?iv9UmZEWxHpqzy7oqCqx8MmU3lIxzFdMq4wtXMLpjOwfyobba4afhbsDR5Gf?=
 =?us-ascii?Q?QlXLNknmi8SVlLOp2bMig0MEt1MchROmGNDrOJ56w6UVViInPTRSMRFXpJFi?=
 =?us-ascii?Q?Es3SU54H7O3XHc6pzKIq102aY6z4HxdnN9weJGa4zYl2wK/sLMTTxhfgdNt1?=
 =?us-ascii?Q?U/H08LBfu0iYgp13AYbefKX8dAgRlS93IdQg7e5fykq/QosPgbnwkSbT2yKR?=
 =?us-ascii?Q?jg6WMPWUFL2bXDzM0iJcCSHIUu0lKZDNdMT9xXVS+xOYuIW5Dh00/bFxSI3c?=
 =?us-ascii?Q?s3haYQvv1EDV+zFkyAllCgPgAc69kIXDSJmUQDa3Hbsdd5DuQ4MhlyE0vth2?=
 =?us-ascii?Q?y+TRA3mBfQeBQSkLhemavPsrDbuPIeGqPNKDuu64bpm8EzuSi2MVwR96IWgr?=
 =?us-ascii?Q?1ktwBoKa1sKEKwvU3hj08c506J1LfhS9RDLzkTQ1x0aLJOast9v4cKrMeGxr?=
 =?us-ascii?Q?peB8wDsz7xDynS1KKBNS7Cx+fhdt6aDSR8MNHc8Ks13Pc9DzMxPVVkyQl8gW?=
 =?us-ascii?Q?m4gxSGodjPbD8AyXRMJSro6GJTSavFjJzK2nsRmvkt+iLr3de4Iv591HnTno?=
 =?us-ascii?Q?qTKUow9P/3ENH5Mro6jaTo7ZwAZVLVxVQdXdY0zEnl5DpOtj0Q8Tn0jcUVRU?=
 =?us-ascii?Q?dRvvbyDei0tUnjGbRrfkgLF0UojEXQ36lhr646AXnEGL+FStVJJSf6optac2?=
 =?us-ascii?Q?+MXGZqAUr2HP6cUiAmw+48/v5ndtaGL+3sB+pNAC+771Kmix7xwDi7nRPZ5y?=
 =?us-ascii?Q?2xVSr8Zf/5Q2+ceS/jOrkRL9BZTChZD+djMMzF6bvyf3Sn4yqdDTk2k287Qv?=
 =?us-ascii?Q?1h7slncYpZaA+6O0DLPap7zNdrdKV+JYK0orwaXdoY3768A0d+7rwf59WnTE?=
 =?us-ascii?Q?iJ02+9qkQA9o8FnGojccqC/yfbU02c3v7DhU4gk8IWgYl0nabOQy40hygbht?=
 =?us-ascii?Q?p56s4Yi4GVcnEQjd6rJrBO6vb+LuTVzT9+iAV+38am5KMLeDeM9AxxiqJgRb?=
 =?us-ascii?Q?wb34jmhSNfnkT/PKmX15xnTMJ/iTJPuEqMnyyG1n3g3Yq+BZ5HTb5a+YZyGw?=
 =?us-ascii?Q?P6yBk6EriR2/TfoV2aB9kJ8hyofawh6Ry+fqyiL04LVF85RkV3ZwswsVaYrX?=
 =?us-ascii?Q?xi1mSsB1lYAYxtbD2dCOpwtlp1sP5YOi+Qtv4YzUTDOELN0PLun4sye/tGno?=
 =?us-ascii?Q?fdhG/3YdvZun3+DlOtfrseacPkn1fnxtMnmn7y8DhEozknaz3Reb3vUW+Mz7?=
 =?us-ascii?Q?jYM0euVOxfic/HlVLqWl87/ksaZrzAh06s1Qr2vc0NAFMqL51TfddxeUIJdD?=
 =?us-ascii?Q?GEbUV0OzCYE5EAb6DxusYnuTy/WFUMdNEzn0r+ExBlZBI+Vcww=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230032)(82310400018)(36860700005)(376006)(1800799016); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2024 16:52:33.7921 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c0b4fd3c-753f-4c7d-c710-08dc8a36e40a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8748
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

From: Alex Hung <alex.hung@amd.com>

Coverity reports sign extention defects as below:

Suspicious implicit sign extension: mode->htotal with type u16 ... to
int (32 bits, signed), then sign-extended to type unsigned long
(64 bits, unsigned). If mode->htotal * mode->vtotal is greater than
0x7FFFFFFF, the upper bits of the result will all be 1.

Cast it to unsigned long to avoid possible overflow.

This fixes 4 SIGN_EXTENSION issues reported by Coverity.

Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Acked-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 0940c2facb30..4de50b297035 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -977,8 +977,8 @@ static void amdgpu_dm_fbc_init(struct drm_connector *connector)
 
 
 	list_for_each_entry(mode, &connector->modes, head) {
-		if (max_size < mode->htotal * mode->vtotal)
-			max_size = mode->htotal * mode->vtotal;
+		if (max_size < (unsigned long) mode->htotal * mode->vtotal)
+			max_size = (unsigned long) mode->htotal * mode->vtotal;
 	}
 
 	if (max_size) {
-- 
2.45.1

