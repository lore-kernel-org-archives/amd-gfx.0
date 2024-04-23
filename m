Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE8C4C4345F
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Apr 2024 06:29:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 510F9113141;
	Tue, 23 Apr 2024 06:29:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NW4v97FB";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2077.outbound.protection.outlook.com [40.107.223.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D011113141
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Apr 2024 06:29:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GHEtKTKz+cEGOUkOAJ1Qa+X4M2k853nrZhagg5j7YvabDph/Y9yuIfwMUEFjXbq4cIEJo8MaEyMbbgo2KdN7/6jVoEEDSBc35/1jgPIUYiF2V0/NbPKv5TR7TS0X5CFGbi79vW/Za8JVzXcl4BBt0ZxZvxI2keFpfWLIwKWfPxYzEsoVoV0N4SYgokKtKwSI6eaR6tV2oNuv9Mm7dhek6zO/QDojbm2a/mqOnbQoxqm8FGHAVXMDNud/rzxT0d1VfbEJbADThlU/pauzkDKuRqUpRJ1wBkU7Q5J40QgE/S9Re0XUmybmkeAa2w/U91Qhyo89kBt0NuWf5JO7Sna0nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rd+jeuYt76DlavAwJm+DVHJdPJ4Amn03AUlOk/2X41c=;
 b=BBtnKmYBJOfuDhKsD5C4Vy/7KMh85dyN8AVMNwhhowxXIelNzkuDW2sM+SFU/5VzJveAxRHSyXx6+iQqlcVl+o+Mu0OOJvn3J+DxudkF/IBUPONY9Psjoa+0fsaB+mK3FRZxq0pkFLyD60EP7PoiOlp1M45xP69rq6C6bEg+444mEGFo89KHypXmxHdpiwOCyMse3tadk/ZubMjCyqiery/wh9S/rkqVtoRRA2yBQqyoppgZd700gxAMpBcuC8EVLLw+yK0JpBgFNGXCa6HcsUHmFpaPI6RwidPCx7uM34JZaBTxui3aK3fyHATriAntexhf9YsmjHUwatdG5d/YiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rd+jeuYt76DlavAwJm+DVHJdPJ4Amn03AUlOk/2X41c=;
 b=NW4v97FBMpG3eYB2HpSzaO2rYXAOXiOdpeHeI4KyfBDVZ6Fkz6b5AQG75DWdVLzWAo37WoyxEYla5eJtwIUFoiW8vqpi+b92qunMfJn1AesxWq/dQLNhm4AfEFvPNTO0vW8+P+zZoLiRsStb7xUEdXHC42ZUo4N4Lzkae6WcOS8=
Received: from SJ0PR03CA0369.namprd03.prod.outlook.com (2603:10b6:a03:3a1::14)
 by CH3PR12MB7690.namprd12.prod.outlook.com (2603:10b6:610:14e::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Tue, 23 Apr
 2024 06:29:30 +0000
Received: from CO1PEPF000044F3.namprd05.prod.outlook.com
 (2603:10b6:a03:3a1:cafe::9a) by SJ0PR03CA0369.outlook.office365.com
 (2603:10b6:a03:3a1::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.34 via Frontend
 Transport; Tue, 23 Apr 2024 06:29:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F3.mail.protection.outlook.com (10.167.241.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Tue, 23 Apr 2024 06:29:30 +0000
Received: from ldev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 23 Apr
 2024 01:29:27 -0500
From: Tim Huang <Tim.Huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <christian.koenig@amd.com>, Tim Huang
 <Tim.Huang@amd.com>
Subject: [PATCH] drm/amdgpu: fix uninitialized scalar variable warning
Date: Tue, 23 Apr 2024 14:28:53 +0800
Message-ID: <20240423062853.1022925-1-Tim.Huang@amd.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F3:EE_|CH3PR12MB7690:EE_
X-MS-Office365-Filtering-Correlation-Id: dbb05f99-6c03-458d-6670-08dc635ebb7c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?4lQrTn98uhzXCaf2PFMziIclQrPHFPAgMiK4S8F6QFsFZwGOs8sAS0j1zpcL?=
 =?us-ascii?Q?Xk+BbH0UYtjeSsnxtDDXVF7o7sH3isr1Eh/p+HxxsH6YIwVtvrwSsC7it5zu?=
 =?us-ascii?Q?STsvow6oTvidM5bZRmqq3GtuSJdUPwuc/pmuiu5zG2xA6o3j2QCr4obruEY3?=
 =?us-ascii?Q?Mj5FbSyIrm3dB7q9+6Kv0vQ/jrETCMbeIRqOpeO9XvAoyG/rumTQNv6IG7bi?=
 =?us-ascii?Q?0a1snajK5k2Y1pw2kCDl9wg7uxYwa6rUFVdS0ZmK/zDfRrhkYrn827xDVfVW?=
 =?us-ascii?Q?IFetKd+2OL3MCciyNBRwx2IdarEeiFrUnXzvN7IYG5XYXLv/ZMjIZnyabc8g?=
 =?us-ascii?Q?maq3ueyYGAmqnsoyVPLIJeJ3DD8U90Dx5TqnrYErv2nD3Iqd4j027RdR7+mF?=
 =?us-ascii?Q?osgmwvzw5fj77xngP+29PpaXeZXaqXE8M9PVcw2ZsBZ5rYSc9ZJ93igLGQUf?=
 =?us-ascii?Q?7a1OdfSElQVK6j6NKH8tr0eIKrmy+sZ3B7EjdAsQoNgbNebbw2QfY2hOgF4l?=
 =?us-ascii?Q?7l99DydC0R4NCVc4cFQlkVIGVRXibwFj8hSTXitGPacF+YYigEcvYudmsrgj?=
 =?us-ascii?Q?Sfb7LO7bBMIDawb5c5SZQ+u4DejNwOpPwS6QaIkjeZM02jcsTMFlkADmhCb/?=
 =?us-ascii?Q?/9AXVFpyVHHER/MXPbo7HBf7Xd7WEgaa3s/Ej2t1sXJwAeFcM1gTUnrZw0EH?=
 =?us-ascii?Q?zg9FI+0L1sx39bRp9Ynh+5941lRYhLiQ0GXtmqnYFcpz+cx2lIRGZmfrMuGs?=
 =?us-ascii?Q?kfCj80lrz2zL/DV8X9alFPs9j+se7BRMbpnsTFFy2EqNz/OWcXBIOu6krhSt?=
 =?us-ascii?Q?MqsEkEjhfE8PZyVAf7aTunVt1r1RSaCD1B2KCrhLpfQGRobyfEWgML9hLnbJ?=
 =?us-ascii?Q?KJE2WYeO0lUWehriV1hHRFgyT7AC+sXyxwQDpBja5wIwL93uocPweZeQ9yLL?=
 =?us-ascii?Q?IMHSDNnnLi+t5OFs8GykFVgKQPTMfu+0tmML9p+wfuwecB79BcLl1GKKhQMR?=
 =?us-ascii?Q?Ig+HMGwcLO2hZ4yGsm2B7lsfcTQclXDkImBBqSGE5hp5/1BqFvvFBTgKI4se?=
 =?us-ascii?Q?1ZhNdq1B8I7rAIQXvn+z68pt3Ny8fCwPaimFjWIbwePCRdWCy61Zg3L3Cb8S?=
 =?us-ascii?Q?Ng85yQzPzkYDaPNu5SkYRPNq68gxQyM3rvON46E4COtRckGg0eFRmkkLYwwI?=
 =?us-ascii?Q?CTkvE102WCyUEmON29hI4VcbJB9QqVTZpjQDVP2pQ2Odvqdyr1jcS248DAv7?=
 =?us-ascii?Q?xPoitgq8c2wtgpBmhmQbpvF/nopnflao3p2MUPhOpi2ImTTWAjp6+dnW2WML?=
 =?us-ascii?Q?MaDpOluqaTGuR2WbrCHMjuR7UP8GdC4F3S9hY0UELx/vFTvGWvHeS1eg3lIw?=
 =?us-ascii?Q?B3CjJsLRAPhi9VjYcT6Kfu+f7d/+?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(82310400014)(1800799015)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2024 06:29:30.1616 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dbb05f99-6c03-458d-6670-08dc635ebb7c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7690
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

Clear warning that uses uninitialized value fw_size.

Signed-off-by: Tim Huang <Tim.Huang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index d95555dc5485..6b8a58f501d3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -1084,7 +1084,7 @@ void amdgpu_gfx_cp_init_microcode(struct amdgpu_device *adev,
 	const struct gfx_firmware_header_v2_0 *cp_hdr_v2_0;
 	struct amdgpu_firmware_info *info = NULL;
 	const struct firmware *ucode_fw;
-	unsigned int fw_size;
+	unsigned int fw_size = 0;
 
 	switch (ucode_id) {
 	case AMDGPU_UCODE_ID_CP_PFP:
-- 
2.39.2

