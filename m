Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B84AFC19F53
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Apr 2024 14:34:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B91AB112CB8;
	Mon, 29 Apr 2024 14:34:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="peNpWsCD";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2051.outbound.protection.outlook.com [40.107.237.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9CA7A112C90
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Apr 2024 14:34:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NuSToL6eEhVrNL3ct1SVuJBLYrzsS5cWKhxp4HFs7M9qm8xbeSLfFbIIKoYsTW/2S5a7wqwVJpxMbzyuuLoovM6m0w1fBmrDGsJv4r4exPpYeR080KsCmOhXxyZMyu33qsjIPEHQCiv2zFoouV17LNR6YhsTlNoXMb1/+WxE9lnkN8NjV2cv357918+XMjTnYLCMC2tmWqJK+1RrtcQ3zf0SIxUwN2nrjenrGZ70lNMBOdHmUveI0NBJFPQ6LUfCX4HVU/ZkWEQfse1N2CyuM5QyGG838P6yjW/HdBOgpdswDySYYvFhT1a+mU0Fbqm79i0InvGEdrQ3Lqo/R5JuuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EwFb6xsaxwiYaP3tzfRKk31ye81Lz0D10uqYE+xYyrU=;
 b=RyuVXBnYr0jqgo6ipTgSWr4rCVigktSdThTx0wkPwjPbi61AfcoMP3xsDBc9e8BMbhjOvzAOAXOIy0fOV3rZfSIAz8JzoHdNgmCq2dlRlXYLE9XxkeOm/0DNCvn+XqwKm3qa5MI3Wa/AHCItzyPLDchs/JMBkvKTu2ZadTHeh5cK2QpRkeRTpoV1egiV9AhqRQwvP7XM+glwb//J+bSE9ItEqFHn3JCV+f75E7RbYM4EZiMpkADYpveU1t1SuWyrJvHs1TdWOHa3HUAV2HFtGNzcRMKBghQg2b8l0TWnR7Jg0WvGsccXG9eoalT8PT8tpd3eaIAu8WX5TcL4rtlmIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EwFb6xsaxwiYaP3tzfRKk31ye81Lz0D10uqYE+xYyrU=;
 b=peNpWsCD7mXRd83dEPskFIVYwwCn06YMU6hbOBcUUv4sxf5oxz98GaMVZSne2Q5woJBk6UvQ1uoY7ljgG92EwXNHj8CXHhcMHflbBHdjs6eiDIK51DGmLNg6FxEESu/3dGx2hgF3aKLiKfPUuJlnz0QKgG373gjWuPqLfRHIDnY=
Received: from BY5PR20CA0004.namprd20.prod.outlook.com (2603:10b6:a03:1f4::17)
 by PH8PR12MB6940.namprd12.prod.outlook.com (2603:10b6:510:1bf::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Mon, 29 Apr
 2024 14:34:20 +0000
Received: from SJ1PEPF00001CE1.namprd05.prod.outlook.com
 (2603:10b6:a03:1f4:cafe::9) by BY5PR20CA0004.outlook.office365.com
 (2603:10b6:a03:1f4::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34 via Frontend
 Transport; Mon, 29 Apr 2024 14:34:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE1.mail.protection.outlook.com (10.167.242.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Mon, 29 Apr 2024 14:34:20 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 29 Apr
 2024 09:34:13 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Likun Gao <Likun.Gao@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 20/31] drm/amd: Move fw init from sw_init to early_init for
 imu v12
Date: Mon, 29 Apr 2024 10:33:28 -0400
Message-ID: <20240429143339.3450256-20-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240429143339.3450256-1-alexander.deucher@amd.com>
References: <20240429143339.3450256-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE1:EE_|PH8PR12MB6940:EE_
X-MS-Office365-Filtering-Correlation-Id: a16e0921-18ed-4bba-9683-08dc6859751f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|1800799015|82310400014|376005|36860700004; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?GfnF99FyNm052vyARW9RH9nBY/Vt6gpfdGe9r4MNmtTh09hpCaCBBZZAwP2p?=
 =?us-ascii?Q?fq03s3hBuIacIhABlojBSy6a1pj/16snqUdFriH2/CSI8b596OkntZJGUrj7?=
 =?us-ascii?Q?ANdyFv3S+U5NtfXGxGVYc7Q5+q2rHLEVSbxhW23c6RowBbVEO/nJC2ZP5IAp?=
 =?us-ascii?Q?zfFVPlvzvT/YHemGfS62JAh19MffZHtPtLv5/Wz5RDMKF2Q+KNaTcMNBdbmX?=
 =?us-ascii?Q?IiLiwsiw162WFwZG1LsY/CB+uaguIZr3XvJNHJlkC5moiKPbtXQKpB9AgTmC?=
 =?us-ascii?Q?dxmweznHlFfer/PMa+jopOgksG25HjnAvWUMFqmMAC67jEPwa3ro19fOCWyb?=
 =?us-ascii?Q?WCDf98FOj8NwG1lUH71JuXKpANV00z94osyLt7sDfwTxYquc/fs3K1x7+DDY?=
 =?us-ascii?Q?jM/QjYzmkyBvHdB0Zl/0lEUS7f3fIYxEwL26od4BQ8335H4EZOqwvSd/v4pc?=
 =?us-ascii?Q?jdqs5guJL10IruXeba7rpo95t+MceIMDF0tCKGzuHVZL0ws13WNKYdqkTgG5?=
 =?us-ascii?Q?lMD0+swLYhkm3bTGS3v9eYKWyFCUmJO8xh6zk4IbriedY121JDeFcZUcoe0P?=
 =?us-ascii?Q?5l6yV3l1MoEolEADOTGsGiLul8NXAjczJpYnr9QUjkQE/Ph/DPK6PrRUXJh7?=
 =?us-ascii?Q?aXqQe7z9CXmzPUC/OQojNUzejuuydOJn0pvaA0lBDHxvfaYqnjvz9+moR5bb?=
 =?us-ascii?Q?1UStN4kVVgYpD4hsAw1ZmUkWpnyW2R5rxVqagVPf5BHd2QbZpprIfex3k9I1?=
 =?us-ascii?Q?5C9Xvz9lRqT1+965bsYuEK5ADb2BZeaIexdUr0EU9Tq3Vi2naux4GmkJfb5i?=
 =?us-ascii?Q?xloG5zNde1Q5/5Qx2Cdqc7NKOxQcqsWjqrVbNYwFWxmKGg1mi3oI1yHASpI3?=
 =?us-ascii?Q?Qv0DWf62oH074XoTASihFNd3yP1nPlyp34VuhM3vK11IztPoukUHzszznwss?=
 =?us-ascii?Q?g6jcXhXLujGtC6s25toIKm7OXkh9eqq6MzqmzvQ9PaHO298aH4Tk27CDr/fe?=
 =?us-ascii?Q?hP/SH5EO5Xs5sc3P/B9wam8bmvg5++PulvWUkl3oB9lW+WhkNT1kR43RMHxi?=
 =?us-ascii?Q?jOBpYm1kDVfDurVJ4NRPZld46yuVQio6gUtuXiWieWqIwQNTnkqZcML7IFmO?=
 =?us-ascii?Q?4AwHUS5UPdFWim6zMI8c1c2KpSADp6BjPXknF8ZJFAw9XsCCreFrnMLZayHw?=
 =?us-ascii?Q?UQWMyMxDYU0shhitnHKeXtx443QFnmVORQHW4FstAfHWevklM3Lw6chCqZ62?=
 =?us-ascii?Q?bCSh9ctx9ZOB4uDmaIYDvm5C4LdvcXXFIGsyMBohsmXF6tu+/8bJqs9FmY+7?=
 =?us-ascii?Q?+hhtebPmazA6sJgpnMNIiOO93/Y1ffbOeWPKp8N9SOuzSTqfKfmaOtV4Tn2R?=
 =?us-ascii?Q?TkwqZug=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(82310400014)(376005)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2024 14:34:20.4900 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a16e0921-18ed-4bba-9683-08dc6859751f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6940
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

From: Likun Gao <Likun.Gao@amd.com>

Move microcode loading from sw_init to early_init to align with
the perious version of imu init sequence.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index df5873ba54e76..e8505c77e12e8 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -461,6 +461,14 @@ static int gfx_v12_0_init_microcode(struct amdgpu_device *adev)
 	/* only one MEC for gfx 12 */
 	adev->gfx.mec2_fw = NULL;
 
+	if (adev->gfx.imu.funcs && (amdgpu_dpm > 0)) {
+		if (adev->gfx.imu.funcs->init_microcode) {
+			err = adev->gfx.imu.funcs->init_microcode(adev);
+			if (err)
+				dev_err(adev->dev, "Failed to load imu firmware!\n");
+		}
+	}
+
 out:
 	if (err) {
 		amdgpu_ucode_release(&adev->gfx.pfp_fw);
@@ -1172,14 +1180,6 @@ static int gfx_v12_0_sw_init(void *handle)
 
 	adev->gfx.gfx_current_status = AMDGPU_GFX_NORMAL_MODE;
 
-	if (adev->gfx.imu.funcs && (amdgpu_dpm > 0)) {
-		if (adev->gfx.imu.funcs->init_microcode) {
-			r = adev->gfx.imu.funcs->init_microcode(adev);
-			if (r)
-				dev_err(adev->dev, "Failed to load imu firmware!\n");
-		}
-	}
-
 	gfx_v12_0_me_init(adev);
 
 	r = gfx_v12_0_rlc_init(adev);
-- 
2.44.0

