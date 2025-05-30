Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F6C0C5B552
	for <amd-gfx@archiver.kernel.org>; Fri, 30 May 2025 09:03:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3113F10E822;
	Fri, 30 May 2025 09:03:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XG3L08bv";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2041.outbound.protection.outlook.com [40.107.93.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B4F3010E802
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 May 2025 09:03:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BjXu06SiDe9+BW5jaybxIbKJcM8sSkz9So035uoER5nT6s5/e1OsjxwifM9AFhL4sRjouVLibyZoHCj0Vo3WlDe8IRuDyy8uRb1QEAiAWSHdA0kD5CWdZrBEQ4I7Fk44XdebVU9H8Ayswwm4ixGRlnq29evPCeiFXaewPi1Jkz8CVsze3/ZJM89tw0cHlQ3VNhWrWh7KqjJ0cLWtUFQWotg1TVFUgniRIvj8O6nBxa+4/C2hTosO5yiIXSewFhQifS3MM3FA9ypjmHiLp4A+JnlLXtrr+sMUL2GlOJny9C6jHXq3ePhNwq0cS5/1bQyPfe1VG++cB4d0/GM+0aCVDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vOlNSrBmCxCqRTblWt0SmSDDkA2CQnNhmEUev341HzI=;
 b=RmSe29Od9Ok/y/8cTDAUCkNGyMMWmhbZsTSLWRniojkFGKsv7gbpuSIRvVoCmw2PU7zeQFmr3zIUrQwLCicou7Qv+4CrlYoaYPotULmAarUOShl9xo3LQzVmXZzqCyT/0YVAJsOVL98PNN758l4w504N9EvZ3VUUyeAIkkV/QYGfriipSkHaSuLKeoNRNUVcF/hcT/kBfY/0K2z/2E35EuBc4l9tu2qGnL/hGcgGVw7wBBERzV98ChWOECXqvvR1s7p7IjNICmFWHA31lQI6IUtuZFsoB/hHTDr8x9LjZDZiZwXSP+voQOhZyQCY0/Howjl5UlkN8wcM2FQdj/bJNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vOlNSrBmCxCqRTblWt0SmSDDkA2CQnNhmEUev341HzI=;
 b=XG3L08bv1z+4kGqdBt9loGP3LZCHuXQzTmJRCaugQESrWngix2HPwK25ebdC9Hri1YmG9fyJDNFfDOtI5hP9h8l6j8BW//zS0eOWgjTNpG2KPbOdkGXrzOZkA5gYMlUA24JGeyFx0EsJ1e6ZLobt3xnC/t5CKP+RvOrzPe+7Jcw=
Received: from CH2PR19CA0017.namprd19.prod.outlook.com (2603:10b6:610:4d::27)
 by SJ2PR12MB7845.namprd12.prod.outlook.com (2603:10b6:a03:4ce::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.29; Fri, 30 May
 2025 09:03:44 +0000
Received: from CH2PEPF00000148.namprd02.prod.outlook.com
 (2603:10b6:610:4d:cafe::99) by CH2PR19CA0017.outlook.office365.com
 (2603:10b6:610:4d::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.19 via Frontend Transport; Fri,
 30 May 2025 09:03:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF00000148.mail.protection.outlook.com (10.167.244.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Fri, 30 May 2025 09:03:44 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 30 May
 2025 04:03:43 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 30 May
 2025 04:03:43 -0500
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Fri, 30 May 2025 04:03:36 -0500
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>,
 Sunil Khatri <sunil.khatri@amd.com>
Subject: [PATCH 03/14] drm/amdgpu: add mes userq reset callback
Date: Fri, 30 May 2025 17:00:04 +0800
Message-ID: <20250530090322.3589364-3-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250530090322.3589364-1-Jesse.Zhang@amd.com>
References: <20250530090322.3589364-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000148:EE_|SJ2PR12MB7845:EE_
X-MS-Office365-Filtering-Correlation-Id: 009a6c86-2bde-4084-a4d2-08dd9f58e13d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?LzkxSlhMWitxTDJwczJXSkpjTnVzak9jYU04QTVqbWk5UXUxNDNsK2krcUhu?=
 =?utf-8?B?dWRSdmpzUEtQaEJVUWZPRWpMMXFKb0RXLzFEVGdMekNTLytxTVc4Mll5ZXVX?=
 =?utf-8?B?dUZHdlpZSmc1TlpzdFFLUmh1WGFHNVJqczJFeHpkV1ZDZExrbEZCa1o3ZlA3?=
 =?utf-8?B?SFQ4MFpSeVFFTTJMV09FY3puM2hpM1VHd05MRFdpZTEvUlM2UHZkdmxSaStk?=
 =?utf-8?B?V0hIMytQZVJweEp3YUpQeDBteVZrbXVFZ2d6RENieE5vSGtRRFNyKzNjYUNH?=
 =?utf-8?B?U3RueUxSSUtpSEhKKzI4Z1E4NGtqYUNsWkxmK0NRSk1lN2o4SHZ6QURjRTBt?=
 =?utf-8?B?TW02T2JXcUNQUGpySFIyZmdoRkZMMFdvRis0MjRodkk5V05pUWpZNGs4Qm5P?=
 =?utf-8?B?OVVFZDFUaDVyNml2dFlrNVFnWEgyQldldE0xMDI4R3hMQmhoc1BnSk1DUXhU?=
 =?utf-8?B?RVZ1NG5hamcwZitxZktJMjBISTNWcHFmOHQrVE9xSGVMRnpIeEdpYUQ3cXdK?=
 =?utf-8?B?ZG9Ta29QbFJFQVI1Q09kSzZkME14NlNkMW1FeHRrMWZSL3M1MnlmY3NaVUtC?=
 =?utf-8?B?cDlUTVdtQ1AvUXRHek9tSFFoY2J2YW9FaElEL1BnaFJ3d2RxRTNOaUZUc1Nm?=
 =?utf-8?B?T2N1MEtzSFZVNzVacUdoVlp6N2pJK1poN0Jpb0o2a0VkSGNOZTVEbC9GU1k4?=
 =?utf-8?B?OHN2US9qM3hoc211NUlKQW1uQU5hUmVpVGg5eEhYb0NkQUE3UHRzeDRoVXVD?=
 =?utf-8?B?UTFVQkwyUnkrVndRUkVjbTBKbVhEaS8reitlakxtV1NVaWp5TStOZU5lMS9n?=
 =?utf-8?B?bkJpTVpRekR5bHk2WWNWaktQTXhCZjBoU2ZFUlR3VzZpOCtzcjh6NDRTV3pw?=
 =?utf-8?B?L2NjVWNVQW1iUXpYbVRCYWc5TXR4NEptbDBCTE91QnVkQ0NhQUhCMWF5WFRI?=
 =?utf-8?B?eTEwTEhPRVBxOWlqU2s0cnJjdlpLRldoZ1JhYXN5c2hQamcyOFJUejRuenB3?=
 =?utf-8?B?cDVYUEVLYmxiM1Q4SjJzcFZHajVXQ2p1SmlLd2VGeENrVnJ6cDcvL2F2Q3lN?=
 =?utf-8?B?K0Q5SjFuZ2swN0hNeU82RkdTL0RVOTJXVjVBaGZ0MGFDY2FGT3N0cmJ5WWR4?=
 =?utf-8?B?c1hVdzI1ZzBHWmgvcUNsdi9TVmZuaWRYcjdsQmZnaUx5NW9qd01tSVhtVDlH?=
 =?utf-8?B?TU14d09aQlRwUUd4VXc2THdyQVBua2xnTTROT1R3d2dKODE2NHZEUE9OamdQ?=
 =?utf-8?B?bW82UHBuc1lpcGIzYlF0aUFmbzFTWC9TYlBOU2pjSUQzUlhGRklQdUkvVTVX?=
 =?utf-8?B?VmlPdVNqaHFoWEZ4QjFOZU5NMXJ4Y0o3d0haQll6TjRjR1NwVVZJMG9SQkpB?=
 =?utf-8?B?S3JpN1dYdlVGUG81bUtIWi9RSi95Vk9OUVFrVVlmZEMvN3BIdWYxdWJRUVpw?=
 =?utf-8?B?aUtubWxJUUtFaHdDOGpoeTJBNkRzemh2Y0N1K3Jkdzh4Rnl5R253cUJtY2R0?=
 =?utf-8?B?Tm12cEdqTnBaU2N5b0xoZ3B3WVVPZFora0xDeXVnaGtGRDVUanZUblJYNzlD?=
 =?utf-8?B?WE5iZzcxVm5FdW00ZGIxTDQxZUIrZTZRUy9KWmhGWUlWM29PN2x2Qis3MnZ6?=
 =?utf-8?B?TnJnZkpDYk1oVFd3QnRNMXVNTGxjWUtiUUFCWUFuYk1qVzdnQ0dGWUpXMC9M?=
 =?utf-8?B?UVp2SU1YU0ZVMHRxRUFtK3pqQkZUc0tsR2RYVUVEak90S3dFL0hyVmhGQWxQ?=
 =?utf-8?B?QXVWaGYxc0k0bFYrWW40YmVML01RcnE2WXhQbG1nM21xalU3QTB2cjhGZU9y?=
 =?utf-8?B?d3hNckRmbFBFbVo1NUc2RlRIc2UxRzJhUjROL1l2Y1RuanA2NkJzZCs2eTFv?=
 =?utf-8?B?ZHJvVkRTeU90bGhSRWg5WDZyend0YzBxNUUzZFNBd0ZCMUFDbzlnYnNSRk5B?=
 =?utf-8?B?T2lxRnJHM0ZSalhMTktmZHhaOER0bk1RMmJMNnJsRFNjUE1aVkFlRXZRZXht?=
 =?utf-8?B?WmErL2FxVkl4emM4ckYyYUZ1bmV2TC9jQ2tTZ0Z3bGZqQmJyUG1oUUw2aHgr?=
 =?utf-8?Q?IZAXe7?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2025 09:03:44.0771 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 009a6c86-2bde-4084-a4d2-08dd9f58e13d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000148.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7845
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

From: Alex Deucher <alexander.deucher@amd.com>

Used to reset a hung queue.

Reviewed-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Sunil Khatri <sunil.khatri@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
index d6f50b13e2ba..650fdb68db12 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
@@ -347,9 +347,30 @@ mes_userq_mqd_destroy(struct amdgpu_userq_mgr *uq_mgr,
 	amdgpu_userq_destroy_object(uq_mgr, &queue->mqd);
 }
 
+static int mes_userq_reset(struct amdgpu_userq_mgr *uq_mgr,
+			   struct amdgpu_usermode_queue *queue)
+{
+	struct amdgpu_device *adev = uq_mgr->adev;
+	struct mes_reset_queue_input queue_input;
+	int r;
+
+	memset(&queue_input, 0x0, sizeof(struct mes_reset_queue_input));
+
+	queue_input.doorbell_offset = queue->doorbell_index;
+	queue_input.queue_type = queue->queue_type;
+
+	amdgpu_mes_lock(&adev->mes);
+	r = adev->mes.funcs->reset_hw_queue(&adev->mes, &queue_input);
+	amdgpu_mes_unlock(&adev->mes);
+	if (r)
+		dev_err(adev->dev, "Failed to reset queue, err (%d)\n", r);
+	return r;
+}
+
 const struct amdgpu_userq_funcs userq_mes_funcs = {
 	.mqd_create = mes_userq_mqd_create,
 	.mqd_destroy = mes_userq_mqd_destroy,
 	.unmap = mes_userq_unmap,
 	.map = mes_userq_map,
+	.reset = mes_userq_reset,
 };
-- 
2.49.0

