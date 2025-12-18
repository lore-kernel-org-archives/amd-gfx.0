Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18391D6ACD7
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Dec 2025 09:30:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AB73310EB06;
	Thu, 18 Dec 2025 09:30:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dUr4YfO8";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011026.outbound.protection.outlook.com
 [40.93.194.26])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E931C10EB06
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Dec 2025 09:30:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZfFTeUjy20bo4QKzfqQO6aUlNKPnUUBQd7jGM/qy77yPKZYZ52eaoXs/csgCLwWyxn7n/Q4GPNx9LjrzeQieTYYI0TA7jWZo3d8ZNgZEFIGv4ZdWrVCcPSzt+Sa3+Kz9pDURsRtvVMsBunYAZPX7wqbVVru1moV2Wu1audgfA/0gkGLcDF+ppX1wCbwvoXbH1nQbDYXwn2m+B7weWruDWUCAwe4r9rzuI6/eMSgPylyDgGuv5xkTjL2Trbb/DuFljxUf4+sAlOsYLqNQSsWHh9h1P+RWUHUKcB+oyADig3s46PuI8iBx1kHkIUqMJQozmQ+wL30+UoqR+nNd7apyGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0rzrmTaHJnyq+7KKhDdb4G3BR4WF4fAA0L1UInzbn4I=;
 b=BOoFTbA89sDuIgOzfqIfBDvfp15GxavVi3AcvUSynPtshTaIGeBoaJf/9WIZ930CR6E4NLTJ8wKFOnHWinKWxnATT1RZID3retyklLqZXnzXkhTK/3taFxnnoGaJtIan9da4KLNGz5zOTKTgJty2SysVwmYaJtXFRCdJIXvDxxxMkOjG2IdqDkTEoPEwcDpJ1HZIIe6oJenJeKWAxGq8BhgmVyECUi9HMgitSpynD/aWHsrXwEUpUwnLKIBCuqlTa++5K4K4aMGd7C5gC0pbmne/j3RzgI5LZ0cvqdIaPc8nREtOz+Udy7C5ptzg5eckDHWhJnarBBMtWbfseJhmrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0rzrmTaHJnyq+7KKhDdb4G3BR4WF4fAA0L1UInzbn4I=;
 b=dUr4YfO8l0halUgXYjtVeDkPRUbMmX20GAYXQ9d4rgR32yC0RYxM/MHOoJYgx/ECwbArKqSlwoI4zSGnjBDZCDtXG0hdKFHjPiQ7WcLvgbQCtHWUKdTDjy55acc6JRKSmp9cz8DUCfXK96M0htbXL12XqQOvBY1YJTsEXtypYZ8=
Received: from MN0PR03CA0028.namprd03.prod.outlook.com (2603:10b6:208:52f::16)
 by DS0PR12MB8767.namprd12.prod.outlook.com (2603:10b6:8:14f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Thu, 18 Dec
 2025 09:30:26 +0000
Received: from BN2PEPF00004FBD.namprd04.prod.outlook.com
 (2603:10b6:208:52f:cafe::87) by MN0PR03CA0028.outlook.office365.com
 (2603:10b6:208:52f::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.8 via Frontend Transport; Thu,
 18 Dec 2025 09:30:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF00004FBD.mail.protection.outlook.com (10.167.243.183) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.6 via Frontend Transport; Thu, 18 Dec 2025 09:30:26 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 18 Dec 2025 03:30:23 -0600
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Philip Yang <Philip.Yang@amd.com>, Gang BA
 <Gang.Ba@amd.com>, Felix Kuehling <felix.kuehling@amd.com>
Subject: [PATCH v2] drm/amdkfd: Fix signal_eviction_fence() bool return value
Date: Thu, 18 Dec 2025 14:59:59 +0530
Message-ID: <20251218092959.742273-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251217095811.709295-1-srinivasan.shanmugam@amd.com>
References: <20251217095811.709295-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBD:EE_|DS0PR12MB8767:EE_
X-MS-Office365-Filtering-Correlation-Id: 305fa9e1-3454-454a-4099-08de3e18139a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Q+X8Q/Vf3eRrfb+tQAKgtyFdIZh7ufZ/wsLI0UUhLYZWsltkLdLwg8ichlNQ?=
 =?us-ascii?Q?XFuwIyZK/IKkJGljVTBlD77r7g+WK9Byi4R6PuVkro1CQtJp+bTRpGCRJDJs?=
 =?us-ascii?Q?/hIo+t7XKXbQSaqpU3bbGbNzATPD3sB5toEMLxj83Fd9GPI1I6C1FE3HcwDA?=
 =?us-ascii?Q?KDKZ4g72LKywr+hQYoMJ8BqTiu5y2Ojnh0TqAzN36AuWt7tyydZ2YvRtCsYR?=
 =?us-ascii?Q?P0NcF2zh9eT49KcGmBTa/fZc554y0n1RyqoIuVVsCAvJsNKv0XrAViZ5a+x2?=
 =?us-ascii?Q?5rQxWQCEv6S17gXOONNOwmmq4Rg97H5MxZyzCk5v0HmTqOQ0Kvsy0yFUvwKY?=
 =?us-ascii?Q?xF6AvTi7jtGRWg9UX9fbDwu4IJ3tphBm91SbHjb2ZGh4knQuB+Co1YZGFYBb?=
 =?us-ascii?Q?qpD1JhUJZU2nNyPeVVTrSodW30CfCKWlhtRDxUoR2NYbZ1fwpDU/PrND0Ojz?=
 =?us-ascii?Q?bXgGQu4Q7IF4nl4vn+2P5c0rII57kU9BcEdJNt0S/yobgOKtliwVHb5YNYJl?=
 =?us-ascii?Q?36cs6FvTS+ta33mEXYKiiEKUVC74BnjPLLjk3LFG5hqOjq41T30pOLzq3+VW?=
 =?us-ascii?Q?Si+SNeTOzDjfkUU2wWSyFXYqYyTjynhxFHjVIKlcjcY7MPTzEvhYUVAI1/Aj?=
 =?us-ascii?Q?O/I2O4Qk7EYOWdsjVFmd4o57YtECxqktVdid8aM62jsLNUTXFhAesYAThpRG?=
 =?us-ascii?Q?YTx7m9+JpHH/7M1S1Sy8dCng9VxwLkuKRsC32qbLfIVOmmdB7RzYNvDviefl?=
 =?us-ascii?Q?s0i0ip0uLo5IBiiG8W/mbnAgNWrCxTNf4Ahjii8mrYSdPnU8UlTSH1+w2JSl?=
 =?us-ascii?Q?DfMSBozLcwn50zVGQ0ocVmp2t3t8w69al16zVLbFd6nRL4WQsfT06z953SOz?=
 =?us-ascii?Q?oI3Xs1EAjPQqUTWtpNYoSpUd7yOe3iI32QC/sNSOIwTyFshg1CQUFnWUGVfK?=
 =?us-ascii?Q?UNNSCAiqU5UguBHazSVDIs9PtKQJ1kgpreuf7bFP4IcI5Rul9kG13BKElhBJ?=
 =?us-ascii?Q?0+1z28HR0uPESnCnB41nNbgDCK7O+c6mBG/YsMfcwoeHXKE708WawkO9Sdq3?=
 =?us-ascii?Q?fcnzzDvhBr9LaibiSae7nhguzCse06RyR32Lwch1TW017QQdZ5tBAD8/8HIp?=
 =?us-ascii?Q?tXlqgILiO8E7hpEnLPPJS6ojlO26vKH0JHRJ1mto/uSBYnJGrCmRd8DX1ciT?=
 =?us-ascii?Q?15VTW26I8fxnG0awj5tKzJYi9aQdWGJgunh2D464XZrbGQATleZ9c8wE2/UU?=
 =?us-ascii?Q?e/T1IvC2H8/pu65CSpDZ9AQpXjDK3tmz2fdN7y0WhZHE9LbvWO8nNyBhsiBC?=
 =?us-ascii?Q?tJh0apxdeql2mxnEB8jfH+O8PRmYzmybOg9tZvKazR5EWMEa1AjwqomATwjh?=
 =?us-ascii?Q?Sgq6KEY+OxdTB05YZmcXgwmtRNDbdtnhZRjoL9YjDmOtQyZYc3eJJnT4cC+w?=
 =?us-ascii?Q?nR9vaG2caYHd7aPWbmKo28oFzReWW8o7q42zJTed8UcjqXETXGx7DKJxPz/5?=
 =?us-ascii?Q?bnSAUKG0SDUMI6aESdLdaKfy9QOTono7O/UuNtoxmrP9thV6MuLe3FzWrrPv?=
 =?us-ascii?Q?U2TKpBx4KQS2yCQPjgk=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2025 09:30:26.1778 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 305fa9e1-3454-454a-4099-08de3e18139a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF00004FBD.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8767
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

signal_eviction_fence() is declared to return bool, but returns -EINVAL
when no eviction fence is present.  This makes the "no fence" or "the
NULL-fence" path evaluate to true and triggers a Smatch warning.

v2: Return true instead to explicitly indicate that there is no eviction
fence to signal and that eviction is already complete. This matches the
existing caller logic where a NULL fence means "nothing to do" and
allows restore handling to proceed normally. (Christian)

Fixes the below:
drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_process.c:2099 signal_eviction_fence()
warn: '(-22)' is not bool

drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_process.c
    2090 static bool signal_eviction_fence(struct kfd_process *p)
                ^^^^

    2091 {
    2092         struct dma_fence *ef;
    2093         bool ret;
    2094
    2095         rcu_read_lock();
    2096         ef = dma_fence_get_rcu_safe(&p->ef);
    2097         rcu_read_unlock();
    2098         if (!ef)
--> 2099                 return -EINVAL;

		This should be either true or false.
		Probably true because presumably
		it has been tested?

    2100
    2101         ret = dma_fence_check_and_signal(ef);
    2102         dma_fence_put(ef);
    2103
    2104         return ret;
    2105 }

Fixes: 37865e02e6cc ("drm/amdkfd: Fix eviction fence handling")
Reported by: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Philip Yang <Philip.Yang@amd.com>
Cc: Gang BA <Gang.Ba@amd.com>
Cc: Felix Kuehling <felix.kuehling@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_process.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index 028853d39841..82109f939c13 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -2097,7 +2097,7 @@ static int signal_eviction_fence(struct kfd_process *p)
 	ef = dma_fence_get_rcu_safe(&p->ef);
 	rcu_read_unlock();
 	if (!ef)
-		return -EINVAL;
+		return true;
 
 	ret = dma_fence_signal(ef);
 	dma_fence_put(ef);
-- 
2.34.1

