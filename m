Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D84D8C021BE
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Feb 2025 04:03:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 89C8210EA21;
	Thu, 27 Feb 2025 04:03:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="k2q4BsE+";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2049.outbound.protection.outlook.com [40.107.93.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 77BE510EA21
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Feb 2025 04:03:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tU/fcGtDG46T0xxJ73m0pwfv6frL3pUUgAlrsWPULQSAKYZ0t3L/2e44d4FXSPdz61Zz3pOSbL8SIyPzQx1QMbqkCys7sOqSwicQ+9ofkb2h15s7nEkQD1mohDYcXoMUU4n0S8hT25SywyBLR2CIV+CC3nA0R9paeQcVj3p/KlhOyLuh8GYz/Z/t78LPZSDMNcAlOal5fpzz73/ouY5Hl9W/6HWUVrZ2gzGJIXPHCilawBVoO4CU7J8GSox0bnVZPrryZiHgsiIqCakNkfZTvhJxL/ml4vZSg/z0xxM7LEkD64Vkw1a04X5AWVeHTK1V4gMdYAcmeyyPERUV1Rrraw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GxvD85VTwDUJgidjU/pPk/O4LxcDAsFkiAb3OALq96k=;
 b=d2SpgEgarAnTAilAELfcpZaIBiLWoYnuFLr5EsQvcE0plHwAJlvj958BSjKMEZjkR50rdD7+teJnxlh0IaostFM0jB0PufGj+D6UclmdZhrERcSEY0ZVkmurziQSwzORKhB+0TgLsvY+MLVWUevPdbOhpTfiTz4R5UeUTycSloAcflqyedCn1qiRWir0q0SmRpr7+AErNvAFMUKJsvP8Nx4ZCraA8ZVepQ6Q6ft1luEykXF3SLRGGeuXSW3tjw5HZAn1rTfrkEKdfHAf+DpnLlIPPDdGG0zDPSzkhxj00XzYuC34fRWF51nN8F4jBrMe6wEs+t1/6si4z3dYpRjKMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GxvD85VTwDUJgidjU/pPk/O4LxcDAsFkiAb3OALq96k=;
 b=k2q4BsE+JOgBO4FSGhQwON5WORmzl+pFN8+wZij4UrO/uB//lAvKJff7X6gc9BuSXHpOpKFymqzAY/WbKCN/AOX4Y9ViTggEFOw+toAghbJqV4k9ehoYPtjbgarfLH3toQf+KP62p7F7OJnhqkUI/OXp1aer5a1crsn2M26PqbI=
Received: from CH2PR12CA0020.namprd12.prod.outlook.com (2603:10b6:610:57::30)
 by DM4PR12MB5867.namprd12.prod.outlook.com (2603:10b6:8:66::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.18; Thu, 27 Feb
 2025 04:02:56 +0000
Received: from DS3PEPF000099E0.namprd04.prod.outlook.com
 (2603:10b6:610:57:cafe::60) by CH2PR12CA0020.outlook.office365.com
 (2603:10b6:610:57::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.18 via Frontend Transport; Thu,
 27 Feb 2025 04:02:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099E0.mail.protection.outlook.com (10.167.17.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8489.16 via Frontend Transport; Thu, 27 Feb 2025 04:02:56 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 26 Feb
 2025 22:02:54 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: validate user queue parameters
Date: Wed, 26 Feb 2025 23:02:34 -0500
Message-ID: <20250227040234.235004-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250227040234.235004-1-alexander.deucher@amd.com>
References: <20250227040234.235004-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E0:EE_|DM4PR12MB5867:EE_
X-MS-Office365-Filtering-Correlation-Id: ede81b97-1697-48a3-28ec-08dd56e39dd4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?HgyDs9uPisH2zgsnqbGjMn5/VUWyb54pycuce1Y/zKs96H/uKcDFf9fpOF5g?=
 =?us-ascii?Q?7pbw+pZto3wV+Uh7NOt5Ky/uxDv/vzGak42IsFnqNcyxrI92g+3DsgUBdwhy?=
 =?us-ascii?Q?wSN6XMv5lvqPAMZaUbcJII2FBG9gKyGsDFHm8nYlRrgQVrG9O4UZdc+kcn0v?=
 =?us-ascii?Q?3sfNjL6RHfalqqLvyQbHwaIau7H/u1297Yx3hp6PX8Ox7cgpcWEWe5QdvtLF?=
 =?us-ascii?Q?r/zQb+32+ZgUHBHT48p3ryfcRGhDQFOx8b807HeCz70OxhTlFJuZEKan+X/C?=
 =?us-ascii?Q?IbJfjRRirlPZqnbti4wJtEF2lnLIdQQS2UMJAhFemY8DYepqs4gw6WIuEwmE?=
 =?us-ascii?Q?i/Cur0CW8rhgTPUoqCoIMtps3iZiKjK1wSqlIYfq1Ds3J4x2gzSutdBWwoOt?=
 =?us-ascii?Q?LkC5CuAbeGSvOYZIXZDq21olGNgVU6ZaRIqo128/bvuFMvw9ejjBJFywZKX6?=
 =?us-ascii?Q?v7/cXnloaHBSyKircOrf+YGm4nz7tR5xm98b1aSiZA8TSo6Q0T5SLWsV6s2h?=
 =?us-ascii?Q?+tM/MZ2/d1cgNrUBfUewUeEapmbMkKDc7cP34A6Ij64BW61RG+CBnEVLRscX?=
 =?us-ascii?Q?TIvoZ+ogLvguQNkBF61fkHolxy480xuQ7IJHvRG5yx0wiXqmna5O2PLPRXCt?=
 =?us-ascii?Q?OhJK7LYMJlyZLpxYMxDWVd7XMib++DxLVeg0v9yU60FeBNjgtpcvguFGfall?=
 =?us-ascii?Q?NvTIWNmAwMYhEN0R0FklnDnwIrJg8sjNLVVrbJoXrXQ4fJ/5Sfy/aOW1HqYD?=
 =?us-ascii?Q?NNlvFq2WdmY7Z/Lg1M6exjWUZqX1eRm32cAN72OP9GYb7PSFLYZK167SpPLc?=
 =?us-ascii?Q?AKrcQX3U2l3R1ZftAJh9z+kBNGZ6nO66iu/dp+i9Icz5l33aW92rdbQrJWcF?=
 =?us-ascii?Q?win8by6udFAxXw9zdeU55HDPfVJriVWlJ1Tdlbr2IP+PSn47ayWV/z26ppzo?=
 =?us-ascii?Q?jSBjG2rNTesbeNEXhyrYsJzIkaottf6YCry4djz0Mi4jSITrcwy40fqVl+CH?=
 =?us-ascii?Q?2Bt1uIdKU0X+mSIh+pQgtQJ0ilSBb4cqEiuaea1mf7bj882hjieugeX7nK3J?=
 =?us-ascii?Q?PR1cApRTcCLsdhqBmo22kGfASbEH1HPcEhPnEVfAjUOdjbC6rw9RbjSd+uap?=
 =?us-ascii?Q?gMonkT4zcMUY/vATAORORyU3IJm7QNsJnTStxLcxJurguaNJ8BnLjQZi0ZSs?=
 =?us-ascii?Q?OBAf9k3adWClaPvrZ78SkzRPgliYDtSaeYRvoUqDsKhiqAI68G3vMEj5lCQl?=
 =?us-ascii?Q?olSlqdvgRrwUUxPCWRUYB+F1gf3fAVlknsYuwemX0/uonPxCBOXO8vWSi0yl?=
 =?us-ascii?Q?lNW619e9jT0NdJuGhMPBMQ6A16UoyrmEUa2B/rmRjwIZvIeMcpvZ/Ek3weTK?=
 =?us-ascii?Q?3j5O0p3gMYGALMQPBtx6mmjp2QuiKlvs9gl334Hp5aAWps2jdbQJB3DE0PoY?=
 =?us-ascii?Q?dXxkKu7oUcoXXnjwbwdgAab84f7lYw0viCMJdjcsNSjBTJIlz+bR3TpMG0A2?=
 =?us-ascii?Q?igO9kXVlE115Uxo=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2025 04:02:56.0876 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ede81b97-1697-48a3-28ec-08dd56e39dd4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099E0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5867
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

Make sure these are set properly to ensure compatibility if
we ever update the IOCTL interface.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
index 0664e04828c07..39279920a757c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
@@ -380,12 +380,26 @@ int amdgpu_userq_ioctl(struct drm_device *dev, void *data,
 
 	switch (args->in.op) {
 	case AMDGPU_USERQ_OP_CREATE:
+		if (args->in._pad)
+			return -EINVAL;
 		r = amdgpu_userqueue_create(filp, args);
 		if (r)
 			DRM_ERROR("Failed to create usermode queue\n");
 		break;
 
 	case AMDGPU_USERQ_OP_FREE:
+		if (args->in.ip_type ||
+		    args->in.doorbell_handle ||
+		    args->in.doorbell_offset ||
+		    args->in._pad ||
+		    args->in.queue_va ||
+		    args->in.queue_size ||
+		    args->in.rptr_va ||
+		    args->in.wptr_va ||
+		    args->in.wptr_va ||
+		    args->in.mqd ||
+		    args->in.mqd_size)
+			return -EINVAL;
 		r = amdgpu_userqueue_destroy(filp, args->in.queue_id);
 		if (r)
 			DRM_ERROR("Failed to destroy usermode queue\n");
-- 
2.48.1

