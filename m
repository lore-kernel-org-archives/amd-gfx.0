Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B97FF589CD
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Apr 2026 13:06:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ACD5910E2C1;
	Thu, 23 Apr 2026 13:06:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="oE9ZYjCJ";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010047.outbound.protection.outlook.com
 [40.93.198.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A3E5E10E2C1
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Apr 2026 13:06:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r+eHNk7sRN+aaZnNvPjrg7t7qcdXFXvUDDtmNERox9c3LiyQuDP3MGGGykEcuYa+8wzEen3l1KtOgMkyUOVRGLzg7zXERghFdjigKAFMHI1E53RhYjSZCo1yTwFz/a8GDdMsPv97ZyRo9f5MHd+bnj1f2XXBGrkLOgDo6djOXBBl4Nx3rAgTgFuxOKHkb4wD01Kx3tsm7ySDOa5dq9j9lwhqqn4NxaUkcKVUiJmIucL6npHhQJ+zMgRDDGIJwaR2q9d12Dw8ZFsnZZZqOINixHTMiq8EnTkFIdLccNA/XT22IHqTq6i+MZuy0kHS/4Fs44EUD7SCxzKR3JCYfgAY0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xRD4oSwbvzwdJr8aqfXWt0PVrz7JKDjjohSy1eXhgC4=;
 b=YWKX04JLJqOCY3cWg8YsQwN3815eEz46W71xgjOithGqe/GITjHPp/KAOS6llCStdr8mgxAk8dTE+YN6WYgtap0co4LL0U3284x9B0FBb/M1FRVjU8gnLmTK1srvAGk4JA6HSHK7IaFkLxqqCHmgnlFwxy///Q3PFTS/COskn4R3GJ+QY9PqR+1swjvlaweCC1tSnFjbHJnF2ZxL+oeHwk6P/XfMpvwmT0eWJIXKxrzpYBoGS/80z+QvI1XAC7PuW3nVGpAYJAkSAzOyzw143K5hN0jVa+xd6Bp1RCs4eKbIB5YnP0ovDLlQSen0AidOlBlWoy1CAh4bdk3yPs3D5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xRD4oSwbvzwdJr8aqfXWt0PVrz7JKDjjohSy1eXhgC4=;
 b=oE9ZYjCJOJtWZcn4AF02a0QI87ShULS+BGYdnEnQreddo8k0VJi/vuxUKettofIpawBRJGNkWuhcbIahRNQw/fXLIefJzT4s3l70wdXHMvVI1HB/rgWPS8C/Mhi6AHHSWswTJjIfsXNQFAsmDfrXb7bmV3jutezUHCdUsIkI2xE=
Received: from PH8PR05CA0008.namprd05.prod.outlook.com (2603:10b6:510:2cc::19)
 by MN0PR12MB5715.namprd12.prod.outlook.com (2603:10b6:208:372::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.22; Thu, 23 Apr
 2026 13:06:27 +0000
Received: from CY4PEPF0000EE37.namprd05.prod.outlook.com
 (2603:10b6:510:2cc:cafe::e8) by PH8PR05CA0008.outlook.office365.com
 (2603:10b6:510:2cc::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.22 via Frontend Transport; Thu,
 23 Apr 2026 13:06:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EE37.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Thu, 23 Apr 2026 13:06:26 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 23 Apr 2026 08:06:24 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: David Yat Sin <david.yatsin@amd.com>, Rajneesh Bhardwaj
 <rajneesh.bhardwaj@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Dan Carpenter <error27@gmail.com>, "Felix
 Kuehling" <Felix.Kuehling@amd.com>
Subject: [PATCH] drm/amdkfd: Validate CRIU-restored IDs before idr_alloc
Date: Thu, 23 Apr 2026 18:36:11 +0530
Message-ID: <20260423130611.2439580-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE37:EE_|MN0PR12MB5715:EE_
X-MS-Office365-Filtering-Correlation-Id: e290513d-70df-4164-3bbe-08dea13920ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|376014|82310400026|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: gR0X2eYTqs05JdjFhBs0Lc14Rz1ZGdyFF9zgj86D98q8bRg8/RW3AbgzAYQ+rozx65ZBLrtfcbb3H3NI40127mMg7u1r8mNJsdwo91r/EfVm3RsSDzR8LI7mmWdHg8TZ1t9fKsIRDzS5OhrV4gUstX1xS2uh41QsEMvvAtT1avWEbdi7LrBQMnoSJQU7DKD5YcZa9aKp9TMH+5LPM7jw4mDYQR79kM3lhSzMIHbW58aZyjH6O6xPLTEilmVLMDCDoAmfgTM+B1lCXBDfE8jZWYlMPdmgrSJT8wSElZNDlvLzdKFuNuPbycj/n1OB4RWg2OzCnCgGowy0i2EJbP8AH8kGIucfLl8M/rZVtVvPTVhbWSX1X3fZGFeZeoBA2HoO1hIKR1Htoo6mG6LX3UES93a6IOTjj7tl60WXZZFFIH1awEGCur4aDT1TEdRbZ6Ny0hrp51vHmZIuNdd7S9r/KGo/TCEsIjq/GhYOunrBCki+RaHE/8sTQ62QqarnfXBBZBJqjXUdHR9c3+C91/qY83mcdN6XeyHzIoIY8w60I2kw60s28Ybzrm+cWKN3pZGLrSPT+YIdPElYQLAAF8DatGVMm05/um4nZwuM/Q/WV3XJr3XUDsN8i0w9OJYiZu+3lh5SaAhOpRGH6VQkeGEcG5K3XY8j79mp6Bq8wNCRsEdSi1qr/DrnxOrZihy08/6e0vJrRfxb3uFJrygxqDsUNJ8aSZFynIfIFvTL1oahH/faCaRkd4HU2t3mj4LGooGqrFawioBCRqbTRkW83S4Qxw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(376014)(82310400026)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: /rEgkqng5tXSOieRdZ9dKh8ev5KRMNxqlb1LjLwoqg/Cpk2F5sjV15rIS9H1mcCWxQJ2XPuLe8GY40A+eRna4gWJ+zu8rPrLUFfWbOD42saflxDrxR/mlsfYL0Oaj4aqrgq3Q9hijLuybxGkuarFgw311A+AjNYCXPFXdtVEWuMIfs/W6yGfre79omBKZgkzjaMUDwHBUVFyIm1JFH+LrkCK1B3n5inh3nuII+FRlBWz1YUoxb+EzAkNqaCxPvoHdFqRx4UnF4lkBmIgRaVS3/7s/ztnOYYXpq9BY0l2dRDq1fsS0sJhWTH0UuliRlJce47EBIOF1taAonNPhWIo0K5is4FCiXAGPNJUbJCUxEigfAopp1+MK5kKi+2MAau6+n4DqtHTEVl+VDr22UcjsOO0FyhzR+GMxZPnfqNcmdqevlelEN8sJfTLdPJl18mf
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2026 13:06:26.5813 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e290513d-70df-4164-3bbe-08dea13920ae
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE37.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5715
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

The KFD CRIU restore flow restores previously saved object IDs from
userspace.

For event restore:

  kfd_criu_restore_event()
      -> create_signal_event() / create_other_event()
          -> allocate_event_notification_slot()
              -> idr_alloc(..., *restore_id, *restore_id + 1, ...)

For BO restore:

  criu_restore_memory_of_gpu()
      -> idr_alloc(..., bo_priv->idr_handle, ...)

In both cases, the restored ID comes from userspace-provided CRIU data.

idr_alloc() expects the ID range values to fit within signed int
limits. If a restored ID is larger than INT_MAX, it can trigger a WARN
in the IDR layer.

A kernel WARN is undesirable because it prints a warning trace and may
cause a panic or reboot on systems with panic_on_warn enabled.

Smatch reported these paths as allowing unchecked userspace values to
reach idr_alloc().

Add INT_MAX validation before using restored IDs in:

- kfd_criu_restore_event()
- criu_restore_memory_of_gpu()

If the restored ID is invalid, return -EINVAL.

This prevents invalid restore data from reaching the IDR layer and
avoids WARN-triggering paths, while keeping valid restore behavior
unchanged.

Fixes: 40e8a766a761 ("drm/amdkfd: CRIU checkpoint and restore events")
Reported-by: Dan Carpenter <error27@gmail.com>
Cc: Felix Kuehling <Felix.Kuehling@amd.com>
Cc: David Yat Sin <david.yatsin@amd.com>
Cc: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 3 +++
 drivers/gpu/drm/amd/amdkfd/kfd_events.c  | 5 +++++
 2 files changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index ce27a23977d1..880c115dbff7 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -2433,6 +2433,9 @@ static int criu_restore_memory_of_gpu(struct kfd_process_device *pdd,
 	const bool criu_resume = true;
 	u64 offset;
 
+	if (bo_priv->idr_handle > INT_MAX)
+		return -EINVAL;
+
 	if (bo_bucket->alloc_flags & KFD_IOC_ALLOC_MEM_FLAGS_DOORBELL) {
 		if (bo_bucket->size !=
 				kfd_doorbell_process_slice(pdd->dev->kfd))
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_events.c b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
index ee70eb4b6319..e9be798c0a2b 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_events.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
@@ -483,6 +483,11 @@ int kfd_criu_restore_event(struct file *devkfd,
 	}
 	*priv_data_offset += sizeof(*ev_priv);
 
+	if (ev_priv->event_id > INT_MAX) {
+		ret = -EINVAL;
+		goto exit;
+	}
+
 	if (ev_priv->user_handle) {
 		ret = kfd_kmap_event_page(p, ev_priv->user_handle);
 		if (ret)
-- 
2.34.1

