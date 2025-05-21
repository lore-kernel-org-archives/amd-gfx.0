Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA402C54EDA
	for <amd-gfx@archiver.kernel.org>; Wed, 21 May 2025 15:29:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 918AD10EA0B;
	Wed, 21 May 2025 15:29:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NfGT6cmR";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2053.outbound.protection.outlook.com [40.107.237.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF7F310E8B7
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 May 2025 15:29:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x/kRpzSyv8pR+ZgkZMbeThkJKsTMy2VBiKysomL3cwWP94F4s5hTR4AmYxRpm9MQyW10jrQoV+GFluLDuP8BBTL3kPvqTVawIcuVtYJ67uKVerZh5UVLXRqhh7pbfPzonrZdRt0hZp+MSzx75WZ87SJ1UHLNPPNXaSIQC6kWFYdmYPiAgO0AEEKtPMXQxYo3m7G9TUUt15wLs3GGKxr7Jb7jQI4chnoyMKm6A57Rm1i2W2phGkeAcdHRDAZaAOpSgXPUNzwyjwIEIlgL2YegcTUZuV7LwE1kQWrqS6OrV8o52mZcgo+jr8Pr9LIttSW4/BM7AXHFGPGsNPiIyZl6xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NjqpcKKQ5N2NyQy72IK8Q05svBi80QiZDgdixwJVWwg=;
 b=ncAzQKu6FrphMF/Uol7IS01JM/V3aNkJSXs+shEJO1rCI+qSaa8t1Rpd2MrPgoR59m+hKsUzF+7oZqSZ6vfKZc0vOOZAgExxvK+aZPg/timT/C5CPaLSzRx+tJJYngdz87WDkE+Uq487eGItKpfDGIo+yZYGjNPr+W4hPIdNbvoLVMh9w7bjt4hyqlidDLCRW8A/AHZYcCHAk+R7lKzMle2+9KAXFjGOD91Niboxzb12gmsJjTj3+X0ARs8pJSEFfo8U3C+eveBif9DH/0rNzncZ2UaT1K0ceibn4FoZBCva4KYFaK0GrPPwZD3WydiqV6+ZR6Cygc3E5tiNdRu4+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NjqpcKKQ5N2NyQy72IK8Q05svBi80QiZDgdixwJVWwg=;
 b=NfGT6cmRBT4sERWkHAIZoqiCvVPi3QafZakix5Yvx5C6ygLOTyYwS/ZxZrBbRUw/Nm+zSjWw5zYHJ5aPrGgcvUQuPcDhITonCrGiftFmqQqZS1x2Fs0aGVDCYodMIXig1WtA/r4p7itS7jeYG/rpRVmgMuMM9Jj5VrSSrqv+gkk=
Received: from PH8PR21CA0017.namprd21.prod.outlook.com (2603:10b6:510:2ce::17)
 by CH3PR12MB8076.namprd12.prod.outlook.com (2603:10b6:610:127::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Wed, 21 May
 2025 15:29:42 +0000
Received: from CY4PEPF0000FCC3.namprd03.prod.outlook.com
 (2603:10b6:510:2ce:cafe::e3) by PH8PR21CA0017.outlook.office365.com
 (2603:10b6:510:2ce::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.10 via Frontend Transport; Wed,
 21 May 2025 15:29:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCC3.mail.protection.outlook.com (10.167.242.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Wed, 21 May 2025 15:29:41 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 21 May
 2025 10:29:40 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 04/10] drm/amdgpu: add AMDGPU_QUEUE_RESET_TIMEOUT
Date: Wed, 21 May 2025 11:29:17 -0400
Message-ID: <20250521152923.401945-5-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250521152923.401945-1-alexander.deucher@amd.com>
References: <20250521152923.401945-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC3:EE_|CH3PR12MB8076:EE_
X-MS-Office365-Filtering-Correlation-Id: b76c9cf8-cb9c-493e-3ad4-08dd987c4eaa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?2N+TsIBI1SzbIF+AdoanIvICdttbbXptntUtrhINkx74/IPsB3SwN0zsee3+?=
 =?us-ascii?Q?igrJcjzrPZnQIM2ZI/ZPN5dsdeTuS67BUhcfBmm/2CIqRnEJJTNMHpIHDUvm?=
 =?us-ascii?Q?pQ4K7b7oumHiOl8UZgmlxco+vGptNzZNGyEPA87e+uL4H94szA9nCEXZY32d?=
 =?us-ascii?Q?mqhbBylkJPpoB2jDxOP0O5KDunHJaPWXkYa1Zq610KRpDmCgrcVCeAsV2aAJ?=
 =?us-ascii?Q?AgydPd1ia9Ntgxc4dXRVIRyNVbECmbC+BLsiHP++qoPxynvHOUZKIJ1vTUaS?=
 =?us-ascii?Q?We31AoEbtCRB5GW6we4ANVYl7MXdxSXmIKF4X915giWx5UpCsN5EfJX4hf7q?=
 =?us-ascii?Q?yClaZbw0H9FXTUXDrfa+eYyNtKItzdMK7jxHjXlFsy6HGm/jtLisZ36aQiS+?=
 =?us-ascii?Q?SS78ArDrD9Vs95pTopM/6qvo4lc4CFbk3B1Wd9WsX7oQgeIk1fyJ4X7w2IFk?=
 =?us-ascii?Q?3LhSdw0QHPEBVarj6qLEsepY+lUmX0guBEQ40M1o9gV1qpSuzQXFQgwzO6qI?=
 =?us-ascii?Q?uwOWmXUT4EYLJ9A6YqYbcxPAuEd2DixGWRmriaGnZLlGxbMxzjBEuLaREHcw?=
 =?us-ascii?Q?ZgnlD+l/ttsVDWfC5REdc8ce5cVpMSZzOD1HxViT0uPecpWJWoSxUtu+lKrN?=
 =?us-ascii?Q?0P8PwoddlcEuvvEBLg7Uy7u+Vx/XmFy64F39bkqZDzpfnC7ka/xN73X7IZqy?=
 =?us-ascii?Q?KJw9KzIBKsGeOg2FeELyIj+5R2D2P8l4V3TNj2kZOy/MCtvx8VA3ofFUFe/z?=
 =?us-ascii?Q?bsZq2WbYJ6DS+qC5b0jZrS4BuWcnFjHRbbF9RVTz5RVzcChddFBTgXI/Pk09?=
 =?us-ascii?Q?4kz7h/fkjudvtGrLa3NraHAcm5VzrI73n50ncitmy0TGzYjE9RjWKr/3yZBy?=
 =?us-ascii?Q?YnhKOhrS7DmoL3MQlUyPl53E6vgj+MSs++QIZZJ+5SDDeCa/wuafol2Ur+PF?=
 =?us-ascii?Q?Fv+p+OcNEcKtecWZYIbyZo1qrxYaV2Edj84o21pJCe32qo48Ulz1pmlnYu/o?=
 =?us-ascii?Q?8QAozf4p9SsdTFOrzjG2oU5W8aH8haEEL+7WImlbHMe332pX8e6uB7C4bffC?=
 =?us-ascii?Q?lqEGvo5SpujRUhcmjUZPGWrDAh65kH5DgeoEtGi9GlecktCB2b37+05GClID?=
 =?us-ascii?Q?IK6w2dYMYHWautI30RI8xiocvOKbMqzcMKrboF7k+72C9lxhp0LDe4rk58a3?=
 =?us-ascii?Q?IhodZdsgB19GVOd8nm1RQ/p6o2595pf31VBbCaW4tfKKgfxIiRjrl2JYf1Ns?=
 =?us-ascii?Q?UU6uqzsf1dyWuMAEjvQ4awINodghMztHu7ULV0IZyPWz2LvE4HCVe3cV2njg?=
 =?us-ascii?Q?NKw3ym6vorORkwaah+DQC1mTjyChNIFxxgOfQdZh4MwZcJ4To+BN5hb5q1HJ?=
 =?us-ascii?Q?CGla0IQZ2CwC0c1vldt+wefkG831o/RVWhW0xUFa9Q5WzuOjMqJOnlgPYVjz?=
 =?us-ascii?Q?/D0g3jwgMhUEDfAUsvNPgtdVTqg5DK+WXZ7gq4iOyRB9FGBKd+HbmXPomAmc?=
 =?us-ascii?Q?qrcSX23NdDtEQ/IMTXZ80XIiknQgcVADz04D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2025 15:29:41.8615 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b76c9cf8-cb9c-493e-3ad4-08dd987c4eaa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8076
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

Add a new define for queue reset timeout.  This will
be used for the IB tests used when validatating
ring resets.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 836ea081088af..af79a03abc110 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -278,6 +278,7 @@ extern int amdgpu_user_queue;
 #define AMDGPU_WAIT_IDLE_TIMEOUT_IN_MS	        3000
 #define AMDGPU_MAX_USEC_TIMEOUT			100000	/* 100 ms */
 #define AMDGPU_FENCE_JIFFIES_TIMEOUT		(HZ / 2)
+#define AMDGPU_QUEUE_RESET_TIMEOUT		(HZ / 10)
 #define AMDGPU_DEBUGFS_MAX_COMPONENTS		32
 #define AMDGPUFB_CONN_LIMIT			4
 #define AMDGPU_BIOS_NUM_SCRATCH			16
-- 
2.49.0

