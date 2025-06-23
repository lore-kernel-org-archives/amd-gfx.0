Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7571EC77B7F
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Jun 2025 09:52:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A877A10E2DE;
	Mon, 23 Jun 2025 09:52:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vgktA60i";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2051.outbound.protection.outlook.com [40.107.244.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2437710E340
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Jun 2025 09:52:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tPT4X5o9kji2Hum/JpTQQ5C70HAZTBGeoo0GLXA+h6iWkgOZw0zXy/ITFE8ZWnUpxKOi4BKGC6dC4jb/C8N6ZqiSxS3QYx4hsIUqxdxUErmhpAQEbrC/RmUTTgClzbir3//EZzsd8cUTBy3VeBG3vMHA8PIDtasUAcXvjS/HaD6Zqg5IlbkGH5ydUFzWCw3EWl5DRWKAe92EF+I2vK/LGs7xSLYcXpw+IPChVZQsdE12rhPsQj/l7a5/cVxDwE+wpFYVtb2LkbXs/voyajUXGk3OawUF3wz01HXSwg1CIfC2C8MYyXBb28bSjKKPV0j8AKpps0XNqPZIfQhjYMWnfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6OmwpXKhF01wSWSg9J5uRPDS+WPA8o1LJKOBUkzZKEU=;
 b=bkUg6OUZOgzez2eUOxPYQXB02Th2/vHT9NDvhJXnvgd8r3zU6LzLuHp7ARcoJeAKqCvACNBlDRE67t40mHX+eiEX7efdMTyxE21XJqr7A7xDjSutRblXmiQn0XJcf9a7DC8fz5l9vHes9tZjOw7a8mmHxfSlVlim+bS/GAX1Tol20Fw7YfQDGvFSOsC5GQGXUm5jiiwSqn6Rm7ETg2Qo2mEe4WNcwN/JJIuhfWr4WVTpkfjYWOIrfm0FoHlCg6jZ3WDj7M88EQU76CotEf2EwbNjTQsK02GEW+2e9RqBYK3uFeR8dzIhlPRztzI0XtdRNYWNBOfqTJ5nQu1JgfpXxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6OmwpXKhF01wSWSg9J5uRPDS+WPA8o1LJKOBUkzZKEU=;
 b=vgktA60iUSA+fThvuV5YErIwejN331Er420TyuMwRtoajls6H04YgLQGsQmmK2t5ctpplJKELE42uy7Z41S6HV6NKOpjma96a28YH8aUib8DNM7Nn3RiJ3lSDb50TnNqhvhykk/Nlqiu0Z7QCCJttl6VNvfY0GdiFZU3V46sz/o=
Received: from DM6PR17CA0004.namprd17.prod.outlook.com (2603:10b6:5:1b3::17)
 by CH3PR12MB9283.namprd12.prod.outlook.com (2603:10b6:610:1cd::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.28; Mon, 23 Jun
 2025 09:52:08 +0000
Received: from DS1PEPF00017094.namprd03.prod.outlook.com
 (2603:10b6:5:1b3:cafe::55) by DM6PR17CA0004.outlook.office365.com
 (2603:10b6:5:1b3::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8857.28 via Frontend Transport; Mon,
 23 Jun 2025 09:52:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017094.mail.protection.outlook.com (10.167.17.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8880.14 via Frontend Transport; Mon, 23 Jun 2025 09:52:07 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 23 Jun
 2025 04:52:03 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>, Prike Liang
 <Prike.Liang@amd.com>
Subject: [PATCH v3 01/11] drm/amdgpu: validate userq input args
Date: Mon, 23 Jun 2025 17:51:44 +0800
Message-ID: <20250623095154.1150830-1-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017094:EE_|CH3PR12MB9283:EE_
X-MS-Office365-Filtering-Correlation-Id: c7950218-9b7c-437a-c97c-08ddb23b9ddd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?l3bFC8KvkhWjTYsadtAhGdn0cfC4YP6onMMQ5dasViF49n/RZ/HMUxVa8MhV?=
 =?us-ascii?Q?efWWegn48YnfUBGo2lO+vQXWmz2ZFwTUpWWXhOYlb0W2jgimrtjT1NAya3/x?=
 =?us-ascii?Q?AFdIJk7gaowml3Vl5qaskc8Fd2KdHnwlAlqCN07i+2LeBSm32y+DvI48j1JY?=
 =?us-ascii?Q?kRQ9tYRyrQhBk5feB7XCNM0sAPcJmkXLWWV+1AC3x3KZC8XNyNrdRtuTjHOa?=
 =?us-ascii?Q?MLDppG8FQvlqdzJN+m1PfEfcFffGXW0DWdNq12qipl60WTyjvaCXCKjLrsPL?=
 =?us-ascii?Q?VIJSTubtBglvNj/tgUUdaCgLGFRrh4iGkR7BQp45IclMXsenK2zopQFBalKQ?=
 =?us-ascii?Q?4Jrac2SdQHKCB+ZwpkwCUYGxL/3TRzXpXjy5zsJpbAS6TeZtnLM2GtyqwVU2?=
 =?us-ascii?Q?rEvZWNpvZq/nvj0Mpvi9LENeGK8+nT43GS0aA1zldIuANOHOrZO9QxCdTcrr?=
 =?us-ascii?Q?NVKQunQAa+J5vM3YKsck6tt2bueVWOP4XC6r9dTSrapTSiMnWbKEek+x8I/L?=
 =?us-ascii?Q?hftYHnwqNY0IGbB0w8Fpm0KIZJ/o2UZeTjVFLjWqfzdn2JY5dD2Gmd/ZBB9D?=
 =?us-ascii?Q?1MR1PHd/M4wlYeHDOlRY8GGQzEGvWwf7wEy5FtMwPcYEYLAKXJiBb3+r8YQh?=
 =?us-ascii?Q?EEGEXF1pNaXE4rH8tynulv64QrSOkQKspobGAsEB9cawsRhKmRTGqeLgoMa8?=
 =?us-ascii?Q?ymIyJveu04xKqMdIN1uUF2fzYspI5SCB8YbFGFyxRWKjEzA4IoTxmgNCu85q?=
 =?us-ascii?Q?1xUoMJZNbOALG2Jnw4hvJ5NyNSF6e/YETYuNT0uIES4a6oev/NGCKegsMdde?=
 =?us-ascii?Q?9hns1o6KNDVQ+2lDP1+OZT2Im4K1cjWvlmlZhJnCVmMVYStiVm4oB0plsgbo?=
 =?us-ascii?Q?a2lLnT4rzkcW9LFO6Y/66YJktVaA5+oYPepQlM5OaNzPK4DBa83AJmWa9QcT?=
 =?us-ascii?Q?C0Cf2tdeBoM1oQwtMQXFQt70G3PY0JTutSFkxwONwLE01nBcfvgsCRfPFyMS?=
 =?us-ascii?Q?lcj029vpVAEFZZPAQze9nVThOFkoD0hEF7FIcjYuOwgiwOFxW82akd9akvFo?=
 =?us-ascii?Q?tDD+RBq5jxrFz1hiPh6QqPBNEdaKhgC9VlyOM7KnwC7bQZPGYUaaM642pVzg?=
 =?us-ascii?Q?PKiKXz26g30YZ4XIz68cjZVj1wYfy8UhFHr4u1SBmQOCb4pzE7XVN3Sv084z?=
 =?us-ascii?Q?StCj2NJNc5pqnVeawYY1orZyxk5CawsN7IANG1IENCK59vwvzFZIcWasGXko?=
 =?us-ascii?Q?QfQjk2k/FEdThnXnM58RQpCbMArQsIro3fPGkyPVw01bBRsce6AcrugvHX7C?=
 =?us-ascii?Q?zZfYKDHoAm0ymchOO+oalf31bwSUthQzRQ9xkLhjlA8yxSjd4yYqG0BU5UlT?=
 =?us-ascii?Q?CfwKo7YbKodecs+UPNbTTQSUpHMe8WENqeJUjU07AUI2D+DYpEW6zqWzCb5D?=
 =?us-ascii?Q?PzKHFm5LeFxYXcslZ2KSd4CSxpATbu4aUjJRlgsi+e/jhLpPaw1iGRlUbOOV?=
 =?us-ascii?Q?Bjfjdh0JQONKmRS0n2rN3abO7ZSAKG36Icy3?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2025 09:52:07.7108 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c7950218-9b7c-437a-c97c-08ddb23b9ddd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017094.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9283
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

This will help on validating the userq input args, and
rejecting for the invalid userq request at the IOCTLs
first place.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c  | 81 +++++++++++++++-------
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c |  7 --
 2 files changed, 56 insertions(+), 32 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 295e7186e156..7f9dfeae4322 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -359,27 +359,10 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 		(args->in.flags & AMDGPU_USERQ_CREATE_FLAGS_QUEUE_PRIORITY_MASK) >>
 		AMDGPU_USERQ_CREATE_FLAGS_QUEUE_PRIORITY_SHIFT;
 
-	/* Usermode queues are only supported for GFX IP as of now */
-	if (args->in.ip_type != AMDGPU_HW_IP_GFX &&
-	    args->in.ip_type != AMDGPU_HW_IP_DMA &&
-	    args->in.ip_type != AMDGPU_HW_IP_COMPUTE) {
-		drm_file_err(uq_mgr->file, "Usermode queue doesn't support IP type %u\n",
-			     args->in.ip_type);
-		return -EINVAL;
-	}
-
 	r = amdgpu_userq_priority_permit(filp, priority);
 	if (r)
 		return r;
 
-	if ((args->in.flags & AMDGPU_USERQ_CREATE_FLAGS_QUEUE_SECURE) &&
-	    (args->in.ip_type != AMDGPU_HW_IP_GFX) &&
-	    (args->in.ip_type != AMDGPU_HW_IP_COMPUTE) &&
-	    !amdgpu_is_tmz(adev)) {
-		drm_file_err(uq_mgr->file, "Secure only supported on GFX/Compute queues\n");
-		return -EINVAL;
-	}
-
 	r = pm_runtime_get_sync(adev_to_drm(adev)->dev);
 	if (r < 0) {
 		drm_file_err(uq_mgr->file, "pm_runtime_get_sync() failed for userqueue create\n");
@@ -485,22 +468,45 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 	return r;
 }
 
-int amdgpu_userq_ioctl(struct drm_device *dev, void *data,
-		       struct drm_file *filp)
+static int amdgpu_userq_input_args_validate(struct drm_device *dev,
+					union drm_amdgpu_userq *args,
+					struct drm_file *filp)
 {
-	union drm_amdgpu_userq *args = data;
-	int r;
+	struct amdgpu_device *adev = drm_to_adev(dev);
 
 	switch (args->in.op) {
 	case AMDGPU_USERQ_OP_CREATE:
 		if (args->in.flags & ~(AMDGPU_USERQ_CREATE_FLAGS_QUEUE_PRIORITY_MASK |
 				       AMDGPU_USERQ_CREATE_FLAGS_QUEUE_SECURE))
 			return -EINVAL;
-		r = amdgpu_userq_create(filp, args);
-		if (r)
-			drm_file_err(filp, "Failed to create usermode queue\n");
-		break;
+		/* Usermode queues are only supported for GFX IP as of now */
+		if (args->in.ip_type != AMDGPU_HW_IP_GFX &&
+		    args->in.ip_type != AMDGPU_HW_IP_DMA &&
+		    args->in.ip_type != AMDGPU_HW_IP_COMPUTE) {
+			drm_file_err(filp, "Usermode queue doesn't support IP type %u\n",
+				     args->in.ip_type);
+			return -EINVAL;
+		}
+
+		if ((args->in.flags & AMDGPU_USERQ_CREATE_FLAGS_QUEUE_SECURE) &&
+		    (args->in.ip_type != AMDGPU_HW_IP_GFX) &&
+		    (args->in.ip_type != AMDGPU_HW_IP_COMPUTE) &&
+		    !amdgpu_is_tmz(adev)) {
+			drm_file_err(filp, "Secure only supported on GFX/Compute queues\n");
+			return -EINVAL;
+		}
 
+		if (args->in.queue_va == AMDGPU_BO_INVALID_OFFSET ||
+		    args->in.queue_va == 0 ||
+		    args->in.queue_size == 0) {
+			drm_file_err(filp, "invalidate userq queue va or size\n");
+			return -EINVAL;
+		}
+		if (!args->in.wptr_va || !args->in.rptr_va) {
+			drm_file_err(filp, "invalidate userq queue rptr or wptr\n");
+			return -EINVAL;
+		}
+		break;
 	case AMDGPU_USERQ_OP_FREE:
 		if (args->in.ip_type ||
 		    args->in.doorbell_handle ||
@@ -514,6 +520,31 @@ int amdgpu_userq_ioctl(struct drm_device *dev, void *data,
 		    args->in.mqd ||
 		    args->in.mqd_size)
 			return -EINVAL;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+int amdgpu_userq_ioctl(struct drm_device *dev, void *data,
+		       struct drm_file *filp)
+{
+	union drm_amdgpu_userq *args = data;
+	int r;
+
+	if (amdgpu_userq_input_args_validate(dev, args, filp) < 0)
+		return -EINVAL;
+
+	switch (args->in.op) {
+	case AMDGPU_USERQ_OP_CREATE:
+		r = amdgpu_userq_create(filp, args);
+		if (r)
+			drm_file_err(filp, "Failed to create usermode queue\n");
+		break;
+
+	case AMDGPU_USERQ_OP_FREE:
 		r = amdgpu_userq_destroy(filp, args->in.queue_id);
 		if (r)
 			drm_file_err(filp, "Failed to destroy usermode queue\n");
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
index d6f50b13e2ba..1457fb49a794 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
@@ -215,13 +215,6 @@ static int mes_userq_mqd_create(struct amdgpu_userq_mgr *uq_mgr,
 		return -ENOMEM;
 	}
 
-	if (!mqd_user->wptr_va || !mqd_user->rptr_va ||
-	    !mqd_user->queue_va || mqd_user->queue_size == 0) {
-		DRM_ERROR("Invalid MQD parameters for userqueue\n");
-		r = -EINVAL;
-		goto free_props;
-	}
-
 	r = amdgpu_userq_create_object(uq_mgr, &queue->mqd, mqd_hw_default->mqd_size);
 	if (r) {
 		DRM_ERROR("Failed to create MQD object for userqueue\n");
-- 
2.34.1

