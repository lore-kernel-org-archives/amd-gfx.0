Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E8A5C54791
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Mar 2024 11:41:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F40110F2F3;
	Wed, 13 Mar 2024 11:41:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wGQqn/0k";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2078.outbound.protection.outlook.com [40.107.93.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5B60910F76C
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Mar 2024 11:41:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=etRAsvbYvdxLw6dy5bsAzoDs6Hhn5DmcnBtQwTnHVhw6cg6HDhK67mrh6Tf5taNhENa8N/1HdLhbvH45zQKXaH63OkBs+KFDk969NBe+Rg5z+CtbhwNaaRhOCb+bBoaVH7zYfdO69py3Vdlhl5JUUfgcZOIxxPuUS3L+UkQGMLdhhPCG9JRSpOzxNYZAPuur6WMQrOb9eSnajNGcTEBuzElR2FL+gIA4qxp2eQn4GaCqyV+QbOdntAxBBSW9/jtBgPhEm0KVOwJxedd/2N+FuarQGTnyUdUtXpMWJxLBr0WSfvzkRZCNSX3ThCXwvdXdlS2KeV7roxla7NhCAUE4mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LYkDb6dr27HxxysmxiIxSfZElxh4cgc0Kt0ehWd1Sio=;
 b=N0Cvn5d6fB4sx1LmLGZGe1/lp8x3SQqqeOeBz9qMjwoYbVSlgzyiPx8ymW6sxcntCmKdNsohnQZHNz088//DUpQPZpbGgK41eOvpcKvHQ8nR4w3Sow+UwADuLfkGdzDQAoVel0YI4Y5uChkTm+HzXyuQUyOfCbg6geRJSdh1NxnXXYOYkkrOrdrVqVz/4Rmasup41WikJKxLjx5BhM7AU+9E9rr3FPlZBdBSkkoc+Q5eEyWPriqZVpSOFNT7KVNGbxtbNa90J6sgLa8eafXKaGjgsGakq9rw9Fymls41aVLxcuizmF0xxi6s9fRXwoB34u1dIQyTd9ZTNttV5BQ2yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LYkDb6dr27HxxysmxiIxSfZElxh4cgc0Kt0ehWd1Sio=;
 b=wGQqn/0kWYzIxqHaJ3t6m+k8YrSj0yY+doNxXyAtU7E3fPAkiES2hdeUbfcnWcbuKrEQX5njTx38opIy9AUywcg8Ro25y3BPwU1iOAEqkJY2Q9FWts8OV0UJ+Ts5NI5KSTNYchfHeIoKVbgJQjQP47rDf58Di9ZMzxSR56gDyvU=
Received: from CY8PR10CA0024.namprd10.prod.outlook.com (2603:10b6:930:4f::18)
 by PH8PR12MB6673.namprd12.prod.outlook.com (2603:10b6:510:1c0::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.32; Wed, 13 Mar
 2024 11:41:32 +0000
Received: from CY4PEPF0000EDD7.namprd03.prod.outlook.com
 (2603:10b6:930:4f:cafe::37) by CY8PR10CA0024.outlook.office365.com
 (2603:10b6:930:4f::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36 via Frontend
 Transport; Wed, 13 Mar 2024 11:41:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD7.mail.protection.outlook.com (10.167.241.211) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7386.12 via Frontend Transport; Wed, 13 Mar 2024 11:41:31 +0000
Received: from Peytolee-HPDesk.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 13 Mar
 2024 06:41:29 -0500
From: Peyton Lee <peytolee@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Yifan Zhang
 <yifan1.zhang@amd.com>, Li Ma <li.ma@amd.com>, Lang Yu <lang.yu@amd.com>,
 Peyton Lee <peytolee@amd.com>
Subject: [PATCH] drm/amdgpu/vpe: power on vpe when hw_init
Date: Wed, 13 Mar 2024 19:44:51 +0800
Message-ID: <20240313114451.1592772-1-peytolee@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD7:EE_|PH8PR12MB6673:EE_
X-MS-Office365-Filtering-Correlation-Id: 086bac75-67a6-449e-44aa-08dc43528787
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ixromdL6j9DEzFJnyhMHHUYHiyzn1ZnbFZJF4Yi2J/1Up2o9ivaBXz6RgHs0n001vWVLjLPgVoiI0+eIggIbuLfd+AZZIm7Ng6IvO7bB7YN3gr0jM07XsqhBUcFsilCCWjWZUKSiUh8StOjmlYY0H8GJLV742B8BQ8KOVdf/MhPWyLB3yUmHYnQdbg+rwWTDUfDRFb42lvtr6JnMj1t5S6Ays1mapOgtGWknZTDUM6qRc+MNfc5CFqNzNvR3anh6Kz+UZ+hkAwKSWCnnGOvElVdtIA36vqikGjK4d0zpIAoOV8oRPXmHGgiALTGk+rP9kS++gzuP5l/iOTNOozUExS/Yyr43zzCBavsDEGz68wsc3XKCem7bsCVUyY/nBwyKG3uoG9LayvxCAkBZXKNK7NvHwG3mLS/fY+0fddz7cz312fLcS6DSMR4IyBT/485M75w3Ons9NM4w3ZG4ekHfhHvcEU8k8X2cFkHqqA8UwQO76fhrf5KkFu8J2cBKh2egFQJ2qxd6Mrw9TbrxKTtqNcCxrCUcLKRImVt9bFua18Apr+NNVUxv8AteUADueFEMb+VtDSsWyMtbo0SxIpmkyGG6NJ1ZEbDQJrcB0OsDWYCh0YFDPJqKom7YBpba8/gP8/jOmsSBxMjdPwwB3BAYyGY3hdWsRtpYR2p9feS+eZX30VbA298GMJzXNY7at+0ZXO8fhJHEjN20VLnYcYy2BCVfXfleuuO346C7+bbwQe6xEtcWPTDBhVvvOnroKb1y
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400014)(1800799015)(36860700004)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2024 11:41:31.8998 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 086bac75-67a6-449e-44aa-08dc43528787
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6673
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

To fix mode2 reset failure.
Should power on VPE when hw_init.

Signed-off-by: Peyton Lee <peytolee@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
index 70c5cc80ecdc..ecfe0f36e83e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
@@ -396,6 +396,12 @@ static int vpe_hw_init(void *handle)
 	struct amdgpu_vpe *vpe = &adev->vpe;
 	int ret;
 
+	/* Power on VPE */
+	ret = amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VPE,
+						     AMD_PG_STATE_UNGATE);
+	if (ret)
+		return ret;
+
 	ret = vpe_load_microcode(vpe);
 	if (ret)
 		return ret;
-- 
2.34.1

