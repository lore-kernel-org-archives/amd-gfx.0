Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC6CAE7719E
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Jan 2025 07:53:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4FA4A10E25F;
	Mon, 13 Jan 2025 07:53:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nsXs2WHA";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2058.outbound.protection.outlook.com [40.107.236.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 67C6C10E25F
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Jan 2025 07:53:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PIazuGyiO47jvngy3UwFi8AZAdn6/cObJOr4t9ubmB7MrLzvbIXN2wSxj00UdFyffXYn9LfSaD0qR83wkr3iQ6RaMTHWA6GeR1n60Vwg7vGJk2Tg+mlePHSKQevfEp4usI+d4mQmSOG6V7qBXRSBnPySHekpioKotFFMYfyqDRyVz5Kkj9j1GgV06ly1QoQCa2M+qLWtojeSss0Z1o526JgUlyYQ3l6MocwzjhEhDqJbvrRoKIdyRm2kS4mAQCGL6NeHBaulNjZ25W//qZV6kmndo1cxFh++Jw67vFaDCzPn42vdY69y4mIqIlSlpbTOQaOQNd+wII/g/KYArxiTjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zNAUOn+tLud0/60qOiKnr++uMRbaHQtZnx8IOUi5xJc=;
 b=FwhqIJf11eLjphDY+oWl1JK32OqjY22bC2PMdZs/MqbfvLQdRkFz9tYChSAouKPliSLsp6NUXO+484o2koqjKVl6NqAchXcr+Y18gh30geAwFO876k/Fvfqu+Fy/pg7hb6EbozACMQ6mDFsBb7FhX+Wab8TyH1zFRNOQrWaDUGFqYqwNFNO5+FEEkmTZ6sQ61kGXMlE10ezrOe3ruL6pMGU+Zx8KTioMaUHRULtoWn1GGam07BgUdmTkhnja8aEJz5PFstLVgXYa3lunNuMYI2RkzukxVCgDXwfgpsr58CAj/Sf4ftyFEIkTjKJ7Uy+RJ/W2FlhXalVHTCkBZKDZOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zNAUOn+tLud0/60qOiKnr++uMRbaHQtZnx8IOUi5xJc=;
 b=nsXs2WHAmy7FcUcamJu/8CHokOta+jfMOvPMel2h9SKC500oLHGEAP5M5C9HNi/QversE6BLCi3k6/2mz5C2DiBf9QinCd5hCnZSLVSDL/GPXwAkubzq/qt7wV5RhdLV+8TciRPPP6wzYVjgoHhYKsVbUrYVXC4v3kMv5r0c1/o=
Received: from CH2PR05CA0020.namprd05.prod.outlook.com (2603:10b6:610::33) by
 IA1PR12MB6329.namprd12.prod.outlook.com (2603:10b6:208:3e5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Mon, 13 Jan
 2025 07:53:29 +0000
Received: from CH1PEPF0000A34A.namprd04.prod.outlook.com
 (2603:10b6:610:0:cafe::3f) by CH2PR05CA0020.outlook.office365.com
 (2603:10b6:610::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8356.11 via Frontend Transport; Mon,
 13 Jan 2025 07:53:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000A34A.mail.protection.outlook.com (10.167.244.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8356.11 via Frontend Transport; Mon, 13 Jan 2025 07:53:29 +0000
Received: from sathish-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 13 Jan 2025 01:53:27 -0600
From: Sathishkumar S <sathishkumar.sundararaju@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Sathishkumar S <sathishkumar.sundararaju@amd.com>, Leo Liu
 <leo.liu@amd.com>
Subject: [PATCH] drm/amdgpu: increase amdgpu max rings limit
Date: Mon, 13 Jan 2025 13:23:13 +0530
Message-ID: <20250113075313.115411-1-sathishkumar.sundararaju@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A34A:EE_|IA1PR12MB6329:EE_
X-MS-Office365-Filtering-Correlation-Id: a237cd1a-bcaf-4b0a-254d-08dd33a75e6a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dXFNbkZDMHowYnQ3dUNTUHRrQ0VQWDN3VVk5OFdtd2JKd2hhNnpPWGduUkM1?=
 =?utf-8?B?N0lPdHJnYjZEamZIcWpkMjJtU2VkV0IrS1JDUm5XN1o3QXFmbXBRVzdIVmJa?=
 =?utf-8?B?Y2M0V2FQcmlmTE4waDRRdDJQaTY3MS9FTXBBWmxxWW1xK3JrRktURWUwSWRn?=
 =?utf-8?B?RkdNRGhRb3Q4aEM3VnBEcndsQWVZV0dGKzljcWxQazJLTDJvbitIbFJqZTFM?=
 =?utf-8?B?a2c1bk9UWGZVWlBOVUZJdjJxM01tcGxWWGN3ZnVMdG5nUXZPQmJ1YkJOMGRW?=
 =?utf-8?B?U1Y5ZkYrcXppMWFHOHNGa2wzc0cxaVNOcUsrSGxzTElpc1ZreTVsems3RklQ?=
 =?utf-8?B?YjVCY3Z1ZkRydXRKZTlSRnNtM2xSRzNEamNVK1d2UXpHdlRad3Z3dDAvMmpE?=
 =?utf-8?B?Q2NTQVh1Z09DVkgvRVFvWDZMYlY0ZGVYZFpLSGJXZER0Lzh2U25ZVHhyRzh4?=
 =?utf-8?B?RWRHYkhhSEFBQkxyWkNDM0hyWjFUV1l3Y2U3em5FYlQxc3ZPRSttK1dEOWNV?=
 =?utf-8?B?eW90d2pmbHdUTEpkZlR6S0hKL1pKYXFWZFFBTTFwUXN5SDd4djd0WUM5dEJJ?=
 =?utf-8?B?SURUT3h1YStadlprOXFINjRsc3VCdThvQkhicjBEaWNmM2JNZWZ2TDhZZUpi?=
 =?utf-8?B?R1hPWC9iTUxzYUVHNzJic3QxQUJVajNxQWQ1RHM4S3RlVEpOZTVsbjdnWmF2?=
 =?utf-8?B?emVRUk1kR04rcUJOc3prdEJ4QXU1Tk5IZi94Z0IxbzR5K2xKRTRaa2s4Z2pF?=
 =?utf-8?B?ckxaOWpXNnVYRk1haEFWNitiTndYQmYraXRtY0o2R21mZ2xVaHdleklPSkIv?=
 =?utf-8?B?bkFYc2FXY2lyL2N5VzUvVFFqSEhsalVhbC90alYxL1VCSWxLOXVSbCs3RkRJ?=
 =?utf-8?B?bml0c0FQVDFJeEQ4bGExNG5mSmU0dkp4Sk5YK0hWVDVhOVM3cjU3bXptV3F5?=
 =?utf-8?B?dWxIMlhwVUQ5cDFia2Q1eEtMR25WRDNHdlZnbTBYS0Z2ZnMveDZDQUxqQnAv?=
 =?utf-8?B?SmdpSE9Qd3BjREMrSW1xYWJKbjZacDBzLytyOTVPVDUxekFVTXgyMUVMVzN2?=
 =?utf-8?B?MjFhcUUvZHJjT25vcVlvMHlTeVIycUVTdDdraEI2SDQwdWhHOThNazMyMGxG?=
 =?utf-8?B?dHZKNWljek1oQWNrMVZ2NTc3ZzY2QTJwM1hVY3NBWnM1aGs1c2x6UUgvOHVz?=
 =?utf-8?B?RU41Q2lET1VZL0hsRGU5WExpbXpzOENXRlBrSnk5bFN6ejZVdXJBb29NajZo?=
 =?utf-8?B?a3k3S0loM3YxTjRPL09hTjZ5YU44RmRwZGJyUVg0UGtwN1BBaHNTVVY3TE40?=
 =?utf-8?B?ang1eEFQYlcvdmJGcmpnQ3BVNGF2cDNna0h4R1VrQXIrMlBESGhFcy9iZ3lZ?=
 =?utf-8?B?clZMVDlJaENYbjcyejZlamNhZWxOVmwrY2VxeTdPanlqUVJhOFZKNUR6dWU4?=
 =?utf-8?B?a1NaZGN5dlNsVC9NYTlySHZrSW54SkhLQkhnTmFYQ25DMGRFaDlsNENxUmpr?=
 =?utf-8?B?ZitCZmZLOU1mdUw3L2tVMTBBSzBLK1BWY2Fjck9QeHdnMThPcjNFazRvNDlJ?=
 =?utf-8?B?K3dJMjUwOGw1b3pvRENvTE9qc3JPcWQ1cWNLQkFQMVdCL0dlRG9PMjk1MURQ?=
 =?utf-8?B?U0NxUG9TZ1IzcU50VWorRHNISEZRN01rbzZxaktRY20wZks2UjU4UGZleHA1?=
 =?utf-8?B?bGJaK2hFL1A0Z3FXUW12Zk5Rb1BLRVAwOGFCRnZIL2J0c0YxVzB1c2JDWU45?=
 =?utf-8?B?UVQvUFlINkkzQk5hRCtVeUxSM0JKNHFNLzBMbFBhYVYxUEtmVUNzY29WWGI4?=
 =?utf-8?B?M1NVcWl5MVd5c08zSWN0cy9MbExxZG16Y255RTBaelBITXN1Z2gzMWN4ZlNH?=
 =?utf-8?B?RWNnMUtoREJwbmdteFAyTDB6Y2pHMDJZNGs1VFhFM2JaWk1jajBqeHpzNEIv?=
 =?utf-8?B?ckNrODgxbVRrRVliUmFHQXV0NmtrQTBJTUgySmNBdUNjcDI0MXZYOHBKdUph?=
 =?utf-8?Q?pbNLQVYdBenTDGIG//DK6m9Vnan70I=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2025 07:53:29.2266 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a237cd1a-bcaf-4b0a-254d-08dd33a75e6a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A34A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6329
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

increase max rings to 132 to support all JPEG5_0_1 cores, else
ring_init fails due to ring count exceeding maximum limit.

Signed-off-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
Reviewed-by: Leo Liu <leo.liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
index dee5a1b4e572..04af26536f97 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
@@ -37,7 +37,7 @@ struct amdgpu_job;
 struct amdgpu_vm;
 
 /* max number of rings */
-#define AMDGPU_MAX_RINGS		124
+#define AMDGPU_MAX_RINGS		132
 #define AMDGPU_MAX_HWIP_RINGS		64
 #define AMDGPU_MAX_GFX_RINGS		2
 #define AMDGPU_MAX_SW_GFX_RINGS         2
-- 
2.25.1

