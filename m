Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8E80C4450E
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jul 2026 14:28:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4B79310F0E6;
	Wed, 15 Jul 2026 14:28:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2jNee15P";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012052.outbound.protection.outlook.com [40.107.209.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A627110F0E6
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jul 2026 14:28:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PtwbWyA7ka6VnWq0VcgmHa8r+r7EAaajfNlZXmzjGuL+pdcSU+upWt9CLQngrXVMSFk+ZjAvtNO8HH3Vy15+/AbVNjV5Qb/rU887FnOTOPpt/wKFv2LPuAsbZlkVcHVV/GfdCvxMKJH2fG8lE3w3nyu/hU6zE29cBtT+S6X3hVL9+4i4DpJNIYLGWZKRXUpWj0Ps0Sybe17MZkGO8xsLf3ncv8p+Z2wX3A2MQVZIXBAgF6t8zel7R5b0lyNJXvLNDhhChzSn4i8Ac47OPSqDkxjuqvLXtIfkb+BsMmqLG/8qHvipC+ilOylBRULTy29oz6WTcfUlq5YjK5dRSIfv1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gjurBTJ6zN3mTHWfe/dHasyldm6MN+dOW9Y3k07mAcs=;
 b=KFw7qkvXskTsGmRIs2CL3RgNJWFC/sMceqpi5oBSAe4uGIqZ90znkcsA+6cMgyDRrcNsfFuoUnUsJWxJ4CGF2Ye/Ai1ZSXoQyEaqsYe/Klaa6HQ2b663nWQzJGzkzQz48nMy6ln8XkgSjxJZw4djMgRw3eGKuDe6w8NYupQEYbXP7T8wYjmL53lf9DwKDDU1g/bUWRrLkP6kmBXkz04sSMukzkFCnu48q9N3jr4DAF6kqXbrznTT0wjXAVSwLorfI5B3sTEtsV4hMinW37LA+f1ZmaCc+zOjxwZTU3G+Ncd2g1nBQWzQL3WYuK/yzvslE+lxSdPp4XXVj6/PRr7ctQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gjurBTJ6zN3mTHWfe/dHasyldm6MN+dOW9Y3k07mAcs=;
 b=2jNee15PyVzsXYCCgXzoE0gJ987sidDckae3LeXi8PZoqwCq2lsU+m6CjbS17LPAvX0x/ue3uzTGkup6cKsG6z3vns62WJTAO/IekvMDngp/SvIEXgVhEtu+mOsa50wjIkrGwERpOyzKp2tyYXVsKSd2wKDo0M7I04Ht9P5lPFg=
Received: from BY3PR04CA0029.namprd04.prod.outlook.com (2603:10b6:a03:217::34)
 by DM6PR12MB4185.namprd12.prod.outlook.com (2603:10b6:5:216::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.11; Wed, 15 Jul
 2026 14:28:42 +0000
Received: from SJ5PEPF000001CA.namprd05.prod.outlook.com
 (2603:10b6:a03:217:cafe::8) by BY3PR04CA0029.outlook.office365.com
 (2603:10b6:a03:217::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.11 via Frontend Transport; Wed,
 15 Jul 2026 14:28:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001CA.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Wed, 15 Jul 2026 14:28:42 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41; Wed, 15 Jul 2026 09:28:39 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH v5 1/4] drm/amdgpu: Signal USERQ_EOP EVENTFD notifications
Date: Wed, 15 Jul 2026 19:58:21 +0530
Message-ID: <20260715142824.3475418-2-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260715142824.3475418-1-srinivasan.shanmugam@amd.com>
References: <20260715142824.3475418-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CA:EE_|DM6PR12MB4185:EE_
X-MS-Office365-Filtering-Correlation-Id: a5082e63-2126-421a-af8d-08dee27d5f0a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|82310400026|1800799024|36860700016|10067099003|11063799006|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info: nRSZBjO0aOKJIVjm9J16kuVm9b7xnUhhdSzqw9A63m94NyDBwIz1bSbTfdFfnu1C7kkGHEfSR4McmqFFCiL7L6k8fN4Q+Wu8EcIZpdWrVuqr6lDWm6oADkWL4K0KJskWukx9N7HiD4SS1bpDmwXP/v3m4Xlj7Y1cbe+ZOan3ltbFbkmDMijGHATRI1QuvyzXYxtd8orpwd3dqgllT6HIeOnNwnch8Y20KTulh8OVHgUWov4XiwowQZkjIsflOuOa0hgssHvzszmQ1CjErWVfW9TqvoLX+MEQb09WFz2xIqTHGhBlydyIRm0Wj7P7sCwz24dQOZV9qTeBZJFYPdJHt+q7G2J6c/bPTYUldBlAaJuKmM/emjROgFFAYdFRYcGGCZDdr43CEngrchwH6va3wwwPzXoqjeN+sVVl8TP/9RojedykH0k+Fs1xuVFd06fTM3fEuwbuD4riMk952Q4D6ypxsPhqp9bAwEsFDiugzK8z6siBmv4/YIeDBVMycnQGc13laQuwLLxOBc7JdlEWN6phkzQkaYfos2syJJH6j7PNDTxJVBt5QjKnW2D5Q5pc4CxARhD9fSAH2Zyt+BdBrCuFgLaJO737God7fEhrQXsoSSDs5IyiF4JN0f3NPSd7sytSjMxpuX1K+6a0OsHKlACvgzkahL6hnWxKGHkiiqpcQebUSZ916QHFgZBgYi5U0DbiiQNoW9WnepcUIL6AKA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(82310400026)(1800799024)(36860700016)(10067099003)(11063799006)(22082099003)(18002099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: t0JJaOFvJt5rwNOt4hcuncFw/ZDpqA8dvSb7/0m1D3mA8Y2hp9hFZFMG5SL02ohRwWg2/bV9Xja7tTwy3SIa74oLSZf6q9/LaIxZsD2cgHqmZWddHpmtuBIZ5j7NhCXZHMTEcNcKcJJPVArjlyFU6pPnVY36KoPtvvLYeqjIt688AqCj2lo50WlXAUDZ3bEz/EJQPk6mpcEPmiBFUPjSvJcCAxDa8BnIR4BQEOepr6cJeiBR2NnMcg/bEXorZGQwAa4RArfLVNdXBL82ei/Vs0zGHJdoyOQ1Tj1qM4pwJZxi9c5//ANZNIl2y6PLUiZfWqdGH0iw39hi2xeyz9+s+fftRDnUqsEBn7la+xxJpqf5cRf5wD524syQuxa+jcQ8vhHvq4npJYLEyJKLiQYtzr3Blqy/tZ2BADOdUFpOTvkKVuTbHVh5tXqDIijudmiA
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 14:28:42.5250 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a5082e63-2126-421a-af8d-08dee27d5f0a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001CA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4185
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

Signal USERQ_EOP EVENTFD subscriptions from the USERQ interrupt path.

The EOP interrupt already identifies the queue that completed. Use the
queue object directly to notify matching EVENTFD subscribers.

Routing notifications through the queue object keeps delivery tied to
the queue instance that generated the completion event, avoiding
ambiguities from reused queue identifiers or doorbell indices.

EVENTFD remains notification-only and carries no event payload.

v2: (per Christian)
- Move USERQ_EOP EVENTFD signaling into amdgpu_userq_process_fence_irq().
- Reuse the existing doorbell-to-queue lookup instead of duplicating it
  in the interrupt handler.
- Keep fence processing and EVENTFD notification handling together in a
  single helper.

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index fbf783946f6d..ab3ef3a9f655 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -215,6 +215,7 @@ void amdgpu_userq_process_fence_irq(struct amdgpu_device *adev, u32 doorbell)
 {
 	struct xarray *xa = &adev->userq_doorbell_xa;
 	struct amdgpu_usermode_queue *queue;
+	struct amdgpu_eventfd_mgr *eventfd_mgr;
 	unsigned long flags;
 	int r;
 
@@ -232,6 +233,11 @@ void amdgpu_userq_process_fence_irq(struct amdgpu_device *adev, u32 doorbell)
 		/* Restart the timer when there are still fences pending */
 		if (r == 1)
 			amdgpu_userq_start_hang_detect_work(queue);
+
+		eventfd_mgr = amdgpu_userq_eventfd_mgr(queue->userq_mgr);
+		amdgpu_eventfd_signal(eventfd_mgr,
+				      DRM_AMDGPU_EVENT_TYPE_USERQ_EOP,
+				      queue);
 	}
 	xa_unlock_irqrestore(xa, flags);
 }
-- 
2.34.1

