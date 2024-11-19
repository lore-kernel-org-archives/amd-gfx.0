Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DF4CD44175
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Nov 2024 15:37:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D82710E34B;
	Tue, 19 Nov 2024 15:37:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="yThDsw/a";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2062.outbound.protection.outlook.com [40.107.94.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8799D10E33D
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Nov 2024 15:37:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zDDKbRVy3VumH1XZ2jbbOyNqkVyrxZROsxYKtxLg+5VzBw/+Epn5fqGVu9c7g815AD1gcRhwt0bJtwavwzX+MYKScdqD8vgDFxYxg9k4nc3d5yotsKuoXsI+OfimMC29+Vc6RhCfq49Xg8nOoAiVZ1xyyyuzPQ9On41fO75pRTpMw/ZS0rSf/PDF4f5cMb7N0Hmg26AfXG4EaHy98C5DlFAH+e2/6dbZAtMJUJj3FW07AGqFRy0JhdJIOrd2dYWxgui67dvfL5idZQKQWlJRO1KKSOSjM5Fz/xLjmsjgg5ua40IhpJK3wbOqEGVzBmnd5T6qDLuCW0IXornKskNMtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z0aXWMpcbYL/TmwMN9uKFRkmBczfOdfCMeJNt9GAq6c=;
 b=qGnZwk0RUoL7Cx4UfrrH6PfXtxVyOrh0HnXbqlIPjHV7fr97eOrHuW5XFO8W/nUtYOGFyDrbtMOlBRHTVw9Wb2OPN79gCu6U/HEI/6SvDfgnrvMyGh1CmdhVBg379lr6S/qRTHN0KH0wAXIiUT5g6coO9eIvvLFlD2SIh2NELdJY0UZmPcYtBD+fWVeHyjfrRShYoDOXd8ytHHWl+NRNTxYDHwNo2xwmpEIiWdbhFXtyFHAFAZCocaMHVIgPR0GJzJU77MvWbD8TSJYjuJqIV5O1YDOMjbKqyTiSBaRaXnNrbB8hZPhtwi6WDXbPvnJTZe67QmVoRyql9mKdXhYTwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.12) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z0aXWMpcbYL/TmwMN9uKFRkmBczfOdfCMeJNt9GAq6c=;
 b=yThDsw/atxsGFSHHAI3Qxcx9MnKwsXMnkTkejM3lNTJqjGdTVOzea2bqxaUfP5nOxoQC1GmZGIUoUqZUPUNsAL20fyfxMP00PYPqpN1CPCcYa/Mj1UW2m3jSq5moSsS+pVnPIzG/yQv8w11qpM+1zW9xLrXW4yxr9nQimezbX68=
Received: from MW4P223CA0011.NAMP223.PROD.OUTLOOK.COM (2603:10b6:303:80::16)
 by CH3PR12MB9169.namprd12.prod.outlook.com (2603:10b6:610:1a0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.24; Tue, 19 Nov
 2024 15:37:41 +0000
Received: from MWH0EPF000971E2.namprd02.prod.outlook.com
 (2603:10b6:303:80:cafe::87) by MW4P223CA0011.outlook.office365.com
 (2603:10b6:303:80::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23 via Frontend
 Transport; Tue, 19 Nov 2024 15:37:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.12)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.12 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.12; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.12) by
 MWH0EPF000971E2.mail.protection.outlook.com (10.167.243.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Tue, 19 Nov 2024 15:37:40 +0000
Received: from mkm-d10-yfeng11.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 19 Nov
 2024 09:37:39 -0600
From: Yuan Feng <yfeng1@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Yuan Feng <yfeng1@amd.com>
Subject: [PATCH] drm/amdgpu: Use MEC FW with SJT on gfx_v9_4_3
Date: Tue, 19 Nov 2024 10:37:23 -0500
Message-ID: <20241119153723.2635-1-yfeng1@amd.com>
X-Mailer: git-send-email 2.39.1.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E2:EE_|CH3PR12MB9169:EE_
X-MS-Office365-Filtering-Correlation-Id: ea8332b1-c924-4269-8e8f-08dd08b01a81
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?DlY5xepDNspRbTWT4TdZMf3Zkxy6u66DvVo8ix6YhK+lPsMVxayfkuBaEGG7?=
 =?us-ascii?Q?r+fFv269PnX933LWlF2cChZziJzt9aR4JCJSBi5ld0zv8IUUYBXrgbeLQ65g?=
 =?us-ascii?Q?w2aD/KX5hGf+GzH25XFf4qlnEVNPJnbAG0+tig2oawC2lLBL7tG1d42At1lH?=
 =?us-ascii?Q?/oovdpuBkWbEr7gkAWN6U9Vcl/yF8u8Vmrc4mH34h2VujZ4iFMUjy6Z3zKeX?=
 =?us-ascii?Q?LjE0judMbgkzR8JgtzIdHzz88XPakW3wOrSwaHLfVB7D00qs/y/RWkxqYTfn?=
 =?us-ascii?Q?xrpT+ayg7eXf8Lsz1GDuPt2BWDR6AqOkiigQBsMqdjBupg7rp4eHXv81px5g?=
 =?us-ascii?Q?2Hdv4v1v3U1GkWLzyUPVJuAcKW5K2pv41jmM29qnI2g65v/yPaedkvwx/5Ig?=
 =?us-ascii?Q?VcSs6blyexG/fvq8dMQqvEqHPaUocp/CVF1w94Wd/k0x9lqhCmuosC/6pOo8?=
 =?us-ascii?Q?jYKAW9h5Njq8sv5xZJmDOShFKABSqVYZxEE4MxtZVP6JnNVV8TfIIMSTAZCw?=
 =?us-ascii?Q?57bfsO4xurLQ78VD7LTMhmoai5wOEn2vtiY/mbQ6LHwDAbvniSwjso81Nj8A?=
 =?us-ascii?Q?Q1EeImEepHgFQu1uDfElzqeo4AmqLpsOQYYlJwqJSerBMSapAtDwZ30NdN3H?=
 =?us-ascii?Q?3U5tQWb4WoTo0m36s/PLHCqAS8RRkpovGJVcG9OYAOh/6415EwZy7hqz9pwy?=
 =?us-ascii?Q?1RndlAHTRvKW3ftG9X+srVrmu/EY1kjB1wSEWu0Hq4uqFSrQBNTeBzwvvh7Y?=
 =?us-ascii?Q?GGa0GBK9m6J2a+UYF42PyhGsxmQYOx50GF2yTnn505nzGYqbxhDwYkSwzZxL?=
 =?us-ascii?Q?8cwvqlblgCyYQXELwvb4hkVSFmTXMei8VxOr8jGSY9ryk41vqTnHve/XPvTV?=
 =?us-ascii?Q?+saAfrmj0eKrklax6H/kpA89l04a4ciEEEQ3noruff4mv106IxdWEoh02LT+?=
 =?us-ascii?Q?CaDkVzFX2iWG4KeUcz1LbRuO7QZLYv8SDNdLRae8yy6z4hnLrYEdrvC9iDBI?=
 =?us-ascii?Q?bQEhfjlTihu6zkfc3yd6K3kHFN0ccxjDST5AqqWCYEbtV2UJ3U50EsP1s8UG?=
 =?us-ascii?Q?sUA2EcZraCEC8M7ZWxrD6rIs2FjzNFOUhe22IAtkjigSN2mMbj3XwfGljyU9?=
 =?us-ascii?Q?2LQOigKuychY1kjeZr7/GHi5Of/xsnL+BgCHjTGke2tDga2VMXHy6xrd/cqG?=
 =?us-ascii?Q?/09N/jiKnrUqNbjas2jW4xo+cED9ddRU1BIGrsuHRPD8v2N9ihovt0zXDcLq?=
 =?us-ascii?Q?4eVMzT41f96BRKSIU1LmtmH2sV1HxgRJX9LEcciIxj9OUKClUVFCm8r2GNrJ?=
 =?us-ascii?Q?gF0IPT3fvs90kDc3+YBg58jyWOR0B0ckmNJCK9WTrvVaFzrBFA9Vq2/O9Cfh?=
 =?us-ascii?Q?VxNGvRQ+JtIUA9CH2Il/CxQ3HqRdgSTW8yo5JZRnbu7VXCENMw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.12; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:atlvpn-bp.amd.com; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2024 15:37:40.6724 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ea8332b1-c924-4269-8e8f-08dd08b01a81
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.12];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E2.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9169
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

On SRIOV, guest driver and host driver might deploy different versions
of MEC firmware binaries that lead to potential compability issues cause
system hang. To solve this, host and guest deploy MEC fw with two level jump
table.

Signed-off-by: Yuan Feng <yfeng1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index 03654bfda58a..6011332cce92 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -45,6 +45,7 @@ MODULE_FIRMWARE("amdgpu/gc_9_4_3_mec.bin");
 MODULE_FIRMWARE("amdgpu/gc_9_4_4_mec.bin");
 MODULE_FIRMWARE("amdgpu/gc_9_4_3_rlc.bin");
 MODULE_FIRMWARE("amdgpu/gc_9_4_4_rlc.bin");
+MODULE_FIRMWARE("amdgpu/gc_9_4_3_sjt_mec.bin");
 
 #define GFX9_MEC_HPD_SIZE 4096
 #define RLCG_UCODE_LOADING_START_ADDRESS 0x00002000L
@@ -574,7 +575,11 @@ static int gfx_v9_4_3_init_cp_compute_microcode(struct amdgpu_device *adev,
 {
 	int err;
 
-	err = amdgpu_ucode_request(adev, &adev->gfx.mec_fw,
+	if (amdgpu_sriov_vf(adev))
+		err = amdgpu_ucode_request(adev, &adev->gfx.mec_fw,
+				   "amdgpu/%s_sjt_mec.bin", chip_name);
+	else
+		err = amdgpu_ucode_request(adev, &adev->gfx.mec_fw,
 				   "amdgpu/%s_mec.bin", chip_name);
 	if (err)
 		goto out;
-- 
2.39.1.windows.1

