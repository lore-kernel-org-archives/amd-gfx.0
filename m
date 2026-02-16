Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09595E81A3D
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Feb 2026 15:50:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9825610E3AD;
	Mon, 16 Feb 2026 15:50:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Ox7c4AHX";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013062.outbound.protection.outlook.com
 [40.107.201.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA7EB10E3AD
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Feb 2026 15:50:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l9nbQd6aQoHVGqkgkpxXSBet0v4AYt/VE5ylzv5LaFUtXEzX59RvSfjZw4blP9Y/XtZeLRW1W/LMJnK5pMmeauvfkktSN6MltU+RgKhQqLFUYmDYMruc356xDJQFHoqpUw4dwffJLRd6YTwM9jIIxjObBDZGfi6GSgW95C5Mkrct8JkVpilp9byZX84OgCrCEFNWveOR4i2xxWWxsPQH6sS/cmfIPDnz8i46qF9SO1za8Vho++gN5rW5AVFNRbZ6P9p4ejWdlXBJA24LjFXXAFzd6enA64RePEpQNyBvdcvM6Bszamd/PZCgPICKcU1/n1Gw5LX7NgOL4M9mq98zXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rsjJVs07fFJ20dJ5+f7wAo/EbGTIoIKXEKjka4zD8A8=;
 b=FXSKCksmZ7/Hj4JLUDWUsz5YozG9VCvg+/fq6GrBuwNyWE4tbUQDW337Wy8YgXGPrkhapKF8zMOsFvSoSggKUymFxneo+KgY1d3kQGEsmtZwCidxyPH8CVFJ/s3IdgW/QnDVx32EN9oIEv3xa7z6O2OWJ3xNU3dq68XFXGASTF67uy9pPUoRewzXWlVFRRQDGrF28Nm5kZjf6+1jkTlfjh3zn/m7HgYaSDUEjHUW0eHxTvBPUqn6p9I+h+uQN4puZXZ6MA2UBtzpaCVD5ipmfsxwmwIzAPXVgc7BRaat1DS/GXIgR59v0+6Qiip0BCjrK6FWeDVrJYqcBs9rAwsQBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rsjJVs07fFJ20dJ5+f7wAo/EbGTIoIKXEKjka4zD8A8=;
 b=Ox7c4AHXdt1+vw+HVX3YN2IIuqEB6v3KVTDd/AIquFTUm7cl3THkx8OA+rADSfZ8wqmWeGpWvcIKbDuLm8c3gqIRdrroUxS6hCyk7594k7xsov44roEMFe4RMxYbWfRF8IzU9bmLy/uCvqHwLhXOw5CE1D3bnZ5oF2bVqegTC+I=
Received: from SJ0PR05CA0016.namprd05.prod.outlook.com (2603:10b6:a03:33b::21)
 by SN7PR12MB7021.namprd12.prod.outlook.com (2603:10b6:806:262::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16; Mon, 16 Feb
 2026 15:50:18 +0000
Received: from SJ5PEPF000001CF.namprd05.prod.outlook.com
 (2603:10b6:a03:33b:cafe::27) by SJ0PR05CA0016.outlook.office365.com
 (2603:10b6:a03:33b::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.13 via Frontend Transport; Mon,
 16 Feb 2026 15:50:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001CF.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Mon, 16 Feb 2026 15:50:18 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 16 Feb 2026 09:50:16 -0600
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Harish Kasiviswanathan
 <Harish.Kasiviswanathan@amd.com>, Felix Kuehling <felix.kuehling@amd.com>
Subject: [PATCH v2 8/8] drm/amdkfd: Notify render-node eventfd subscribers for
 KFD events
Date: Mon, 16 Feb 2026 21:19:43 +0530
Message-ID: <20260216154943.1582412-9-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260216154943.1582412-1-srinivasan.shanmugam@amd.com>
References: <20260216154943.1582412-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CF:EE_|SN7PR12MB7021:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b076a44-2549-47dc-030a-08de6d7315aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OTdDVGJnSzczYThkNlkyclZhcXMzQTdvRkZXVUlibjJsRWVOSm1rWHFsblhI?=
 =?utf-8?B?TjBVd25lM3NKL0paVkVZNjFsZll5emYxczhiS3lUWURpeDBvVVd4TlduQmlT?=
 =?utf-8?B?ZTdmc3FPcGpqT0REak5BckdHRTFGWmJPMGVGQXlSU255VXlnNFZwa0N2MGpu?=
 =?utf-8?B?cVlCcEYvVWFpaEFPa2Q0VHFNcDUwZWtzN0tLUEtseHp0M3RCNWxyUk1QNFNI?=
 =?utf-8?B?Rk1YcTZhZTNSb3psWEE4K3dRMDhjK0k0cUdYZWk5OVBFYWwwdEJqMWNqQ2N0?=
 =?utf-8?B?WjdCZnhEam1RL3JOMVFlT2ROVnNyWCttYWZUekdKdUlleUJsZmFDTVRhQ1hv?=
 =?utf-8?B?Rmg4OWZiekFIdjBaVU10NmpINXg4azFjeXBTSFN3V0V1ZmFYZnAvU2EzNDdh?=
 =?utf-8?B?QUxKSlU0enhXNFdOVTBBVmlFY2FrU1piOG1CWjhicThRYW1ZcklvNnlrcUNy?=
 =?utf-8?B?RnlVak5MdDk2MVJmdzFMeC96aXoraERqK1RkeTBMN09vQjAzQS85MXZNZWJq?=
 =?utf-8?B?Z3RDVDRlVnFnK09VbHpjZjYyNlJnNi9SeHJoVzhwZkFtYmx6TDhpSmRwNi9n?=
 =?utf-8?B?UTJ3Z1hzN3U2Q0IxWmlLRWJnVnowdmhrTEVLNU02dkNkMDJHb3JpakxlQldk?=
 =?utf-8?B?VmhqMjY5YmZQaXI2Y0lMSEtSVG85WTY3d3FiT1Foemo4aUtlMnA4SmlWTFdj?=
 =?utf-8?B?a1BXdmNhR2hhdVpsWjl3SVV4em54VlJJZm1zaG1KQlIxSG1pV1pIazA5SmFB?=
 =?utf-8?B?V2FZOXVYTHd6UHpEL2RFL1MzOEY2UXB0UzBUYUJwbEswSDRFZ1BsUWhnTldF?=
 =?utf-8?B?N3gyS2xaWWpjcm9KeXBjSTFGcEVkSFphWExkOVc5WVloajd5QjYwSUNhNmFu?=
 =?utf-8?B?eFh4aEZONEY5RjdSaFU3TE1lUjdQKzF4WitqeG5MSlFtRXNNcmovUlJKbTNs?=
 =?utf-8?B?NG0rTGxaRzB3dE96U0gwdUVHaGZjY1ZQUUgybGVVKzU5QkFFYTg4Z254Qi9h?=
 =?utf-8?B?bGE1UlJSOTFRYktqNFZoWnlZcGZsN0RvOVR5eit4cXROdWZSNVRkbHFiSFNl?=
 =?utf-8?B?WU1GWFRRRm9TcDdzZFh2RVFrUGZPZ2hranUxcC9iMzRTMUovTU8wRGI2MEF2?=
 =?utf-8?B?Yk1GeXlFWlZJN1NxVklQSXJMVjNYYWlESlpla0djc3BQYnlsUDE1RnZyeWR0?=
 =?utf-8?B?M01wMzVGeURjYmJNanB6WEdFZmY1NERSSUFYeFJ2dVFmbk1RY2dDRldjaTVS?=
 =?utf-8?B?bjRqUHpnL3B1ZUtjVFBqVnc2ZHhadzc3c1FYVVJkMW9ZdXZlajRINVNMdkF5?=
 =?utf-8?B?Q3BxUU4yTEdBc2lFZVY0WisrZGYwMWJIL09Pbi9URTBMS01LODF6L3dRNTRv?=
 =?utf-8?B?aXNBQ2ZZTk9CdlVTeEZLMC9jSVBEWXNqNmZsaDZZTkpzSWpucVpwYnFZdzU2?=
 =?utf-8?B?Q05va25neG50YUFldHo4N3p6aE5DKzN1eUFWcmN0TjAvOFhKc2RxUEl1SS8v?=
 =?utf-8?B?ejFNWUNVMm1IVlVMVGhyZVIwcnZHRi9QRkhYV0syRVE4QXU3Z09ZMi8rKysy?=
 =?utf-8?B?Z0FGSHRJaUF6eUpZZWxnRUxjc0hFbnZIQ0VWM0tzdFI5cFpMWHZGZUx5ajJB?=
 =?utf-8?B?c3JIRXNuY2phdnJnM0NYdTFYcHhYdUplZ1JHYllPbUFpOWsyUVIycFZHMkhI?=
 =?utf-8?B?dzExSTk4Mm9uSkg0RTM0VjdMSUVMSjc3RHJFN0lEcWJRV2JoK0hNaUQ1dXhT?=
 =?utf-8?B?R0syVzBsQ3JXZzlKbWxWQXNIaGN5NUxZTEpvV3F4QUxyeWdEdERtSDVWdzJF?=
 =?utf-8?B?ZHkwK1IvSFJlTzBNWVpCNVNsTmdBV005WGkzSWxqR3g0RzAzMjd4d3ZGdVRF?=
 =?utf-8?B?TmR1RGhiY09pek93VTM3eUg5MVg1NU5ubXJkdjNmQW5LdzZXQ0VLNFlPcExL?=
 =?utf-8?B?WjFzU0tVZ0liMFdlM0NEeVYwVTFieGlQZWN4K2tWank1cnhwYnNOS1FrenNL?=
 =?utf-8?B?aDRWWmNXNTFGcmpPRHJBVVY1SGxzUFE2QnJINENrcCtSUnJBcW1kTnhLRUFK?=
 =?utf-8?B?eUl2TGRZZUVDSk9ZQ3RkZ09jb3p1UHdETmpjL2Vad1dVQ3RtU0E3K1RDS1FV?=
 =?utf-8?B?aWg0dG9uNTVBWEFBNVlwNlRnMlUyL0FNbkFHckk0TGtLblZSZjNhYUhBMXFN?=
 =?utf-8?B?QjJsQ1IyczhVOFRIbWVHazVNa1Z3VVBJUktIY1RNMWgzOXl5NHN0NGNic1p3?=
 =?utf-8?B?bG1BQ3RiVE95clVhVVJiY0tqTVpBPT0=?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: OS3dx/lQAHjAXJhUd+CbdsgTAqi/5i2wX05P8rM5rvvQCm2isR10nBiVk+cjdu3pIEvjBwu+KwH0la+56m0PQcR2ha3bxpmjx9inl/+qbaK8KyF8yddiDr1pC14/Tx3nqDPYhSeXVk2ZqDgYqREeqH5XquusdYa5K8JV13qVxDaReroEN3l9oq9HtZOww6MHr2YA8KMgeLVlFLk7/pK6d6aLJPbKAMud6q3d3O2cb7TfFhurvnBDtgYmLhLoV94i3Ip+ugcrBlxE6ILBRWdXNEdb6G8gM088B++uzYTCDcT0WjKioYhKkrxTbOlyHn6W2eSEXR8yLoEUUXN3WaXoTJZegbX8RAfi9qlsBIh6YpIkHh/OQ6vBYK3o5F6ZtZVWXuauPIQh5+AQhkk+YUwEm0ZpUV4jfGA2YUlJiRr1pzLit0+og8acNFSGhIKSPn0e
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2026 15:50:18.4585 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b076a44-2549-47dc-030a-08de6d7315aa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001CF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7021
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

Extend KFD event signaling to also notify render-node eventfd subscribers
via amdgpu_eventfd_notify(pasid, event_id, count).

Add a weak no-op amdgpu_eventfd_notify() so KFD keeps building even when
amdgpu does not provide the bridge implementation.

Use PASID already tracked by KFD (pdd->pasid, or derived from the process
pdds) to avoid drm_file-based PASID derivation.

Hook notification into:
  - CPU-driven SIGNAL events (kfd_set_event)
  - IRQ-driven SIGNAL events (kfd_signal_event_interrupt)
  - HW exception, VM fault, reset, poison consumed, and process terminate
    event paths.

This preserves existing KFD semantics while enabling render-node clients
to observe the same KFD events via standard eventfd mechanisms.

Cc: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
Cc: Felix Kuehling <felix.kuehling@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_events.c | 76 +++++++++++++++++++++++--
 1 file changed, 70 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_events.c b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
index 13416bff7763..00416f6ec261 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_events.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
@@ -57,6 +57,35 @@ struct kfd_signal_page {
 	bool need_to_free_pages;
 };
 
+/*
+ * Optional KGD hook for render-node eventfd signaling.
+ * Weak no-op so KFD builds even when amdgpu doesn't provide it.
+ */
+__weak void amdgpu_eventfd_notify(u32 pasid, u32 event_id, u64 count)
+{
+}
+
+static u32 kfd_pasid_from_pdd(struct kfd_process_device *pdd)
+{
+	return pdd ? pdd->pasid : 0;
+}
+
+static u32 kfd_pasid_from_process(struct kfd_process *p)
+{
+	u32 i;
+
+	if (!p || !p->n_pdds)
+		return 0;
+
+	for (i = 0; i < p->n_pdds; i++) {
+		u32 pasid = kfd_pasid_from_pdd(p->pdds[i]);
+
+		if (pasid)
+			return pasid;
+	}
+	return 0;
+}
+
 static uint64_t *page_slots(struct kfd_signal_page *page)
 {
 	return page->kernel_address;
@@ -654,6 +683,7 @@ int kfd_set_event(struct kfd_process *p, uint32_t event_id)
 {
 	int ret = 0;
 	struct kfd_event *ev;
+	u32 pasid = kfd_pasid_from_process(p);
 
 	rcu_read_lock();
 
@@ -670,6 +700,14 @@ int kfd_set_event(struct kfd_process *p, uint32_t event_id)
 		ret = -EINVAL;
 
 	spin_unlock(&ev->lock);
+
+	/*
+	 * CPU-driven SIGNAL event (KFD_IOC_SET_EVENT) should also wake
+	 * render-node eventfd subscribers for the same (PASID,event_id).
+	 */
+	if (!ret && pasid)
+		amdgpu_eventfd_notify(pasid, ev->event_id, 1);
+
 unlock_rcu:
 	rcu_read_unlock();
 	return ret;
@@ -713,13 +751,15 @@ static void acknowledge_signal(struct kfd_process *p, struct kfd_event *ev)
 }
 
 static void set_event_from_interrupt(struct kfd_process *p,
-					struct kfd_event *ev)
+					struct kfd_event *ev, u32 pasid)
 {
 	if (ev && event_can_be_gpu_signaled(ev)) {
 		acknowledge_signal(p, ev);
 		spin_lock(&ev->lock);
 		set_event(ev);
 		spin_unlock(&ev->lock);
+		/* Bridge: wake render-node subscribers for same (PASID,event_id). */
+		amdgpu_eventfd_notify(pasid, ev->event_id, 1);
 	}
 }
 
@@ -744,7 +784,7 @@ void kfd_signal_event_interrupt(u32 pasid, uint32_t partial_id,
 		ev = lookup_signaled_event_by_partial_id(p, partial_id,
 							 valid_id_bits);
 	if (ev) {
-		set_event_from_interrupt(p, ev);
+		set_event_from_interrupt(p, ev, pasid);
 	} else if (p->signal_page) {
 		/*
 		 * Partial ID lookup failed. Assume that the event ID
@@ -767,7 +807,7 @@ void kfd_signal_event_interrupt(u32 pasid, uint32_t partial_id,
 					break;
 
 				if (READ_ONCE(slots[id]) != UNSIGNALED_EVENT_SLOT)
-					set_event_from_interrupt(p, ev);
+					set_event_from_interrupt(p, ev, pasid);
 			}
 		} else {
 			/* With relatively many events, it's faster to
@@ -777,7 +817,7 @@ void kfd_signal_event_interrupt(u32 pasid, uint32_t partial_id,
 			for (id = 1; id < KFD_SIGNAL_EVENT_LIMIT; id++)
 				if (READ_ONCE(slots[id]) != UNSIGNALED_EVENT_SLOT) {
 					ev = lookup_event_by_id(p, id);
-					set_event_from_interrupt(p, ev);
+					set_event_from_interrupt(p, ev, pasid);
 				}
 		}
 	}
@@ -1107,7 +1147,7 @@ int kfd_event_mmap(struct kfd_process *p, struct vm_area_struct *vma)
  * Assumes that p is not going away.
  */
 static void lookup_events_by_type_and_signal(struct kfd_process *p,
-		int type, void *event_data)
+		int type, void *event_data, u32 pasid)
 {
 	struct kfd_hsa_memory_exception_data *ev_data;
 	struct kfd_event *ev;
@@ -1130,6 +1170,8 @@ static void lookup_events_by_type_and_signal(struct kfd_process *p,
 			if (ev->type == KFD_EVENT_TYPE_MEMORY && ev_data)
 				ev->memory_exception_data = *ev_data;
 			spin_unlock(&ev->lock);
+			if (pasid)
+				amdgpu_eventfd_notify(pasid, ev->event_id, 1);
 		}
 
 	if (type == KFD_EVENT_TYPE_MEMORY) {
@@ -1168,7 +1210,7 @@ void kfd_signal_hw_exception_event(u32 pasid)
 	if (!p)
 		return; /* Presumably process exited. */
 
-	lookup_events_by_type_and_signal(p, KFD_EVENT_TYPE_HW_EXCEPTION, NULL);
+	lookup_events_by_type_and_signal(p, KFD_EVENT_TYPE_HW_EXCEPTION, NULL, pasid);
 	kfd_unref_process(p);
 }
 
@@ -1233,11 +1275,14 @@ void kfd_signal_vm_fault_event(struct kfd_process_device *pdd,
 	id = KFD_FIRST_NONSIGNAL_EVENT_ID;
 	idr_for_each_entry_continue(&p->event_idr, ev, id)
 		if (ev->type == KFD_EVENT_TYPE_MEMORY) {
+			u32 pasid = kfd_pasid_from_pdd(pdd);
 			spin_lock(&ev->lock);
 			ev->memory_exception_data = data ? *data :
 							memory_exception_data;
 			set_event(ev);
 			spin_unlock(&ev->lock);
+			if (pasid)
+				amdgpu_eventfd_notify(pasid, ev->event_id, 1);
 		}
 
 	rcu_read_unlock();
@@ -1251,6 +1296,7 @@ void kfd_signal_reset_event(struct kfd_node *dev)
 	struct kfd_event *ev;
 	unsigned int temp;
 	uint32_t id, idx;
+	u32 pasid;
 	int reset_cause = atomic_read(&dev->sram_ecc_flag) ?
 			KFD_HW_EXCEPTION_ECC :
 			KFD_HW_EXCEPTION_GPU_HANG;
@@ -1274,6 +1320,8 @@ void kfd_signal_reset_event(struct kfd_node *dev)
 			continue;
 		}
 
+		pasid = kfd_pasid_from_pdd(pdd);
+
 		if (unlikely(!pdd)) {
 			WARN_ONCE(1, "Could not get device data from process pid:%d\n",
 				  p->lead_thread->pid);
@@ -1312,6 +1360,9 @@ void kfd_signal_reset_event(struct kfd_node *dev)
 				ev->hw_exception_data.gpu_id = user_gpu_id;
 				set_event(ev);
 				spin_unlock(&ev->lock);
+
+				if (pasid)
+					amdgpu_eventfd_notify(pasid, ev->event_id, 1);
 			}
 			if (ev->type == KFD_EVENT_TYPE_MEMORY &&
 			    reset_cause == KFD_HW_EXCEPTION_ECC) {
@@ -1320,6 +1371,9 @@ void kfd_signal_reset_event(struct kfd_node *dev)
 				ev->memory_exception_data.gpu_id = user_gpu_id;
 				set_event(ev);
 				spin_unlock(&ev->lock);
+
+				if (pasid)
+					amdgpu_eventfd_notify(pasid, ev->event_id, 1);
 			}
 		}
 
@@ -1367,6 +1421,9 @@ void kfd_signal_poison_consumed_event(struct kfd_node *dev, u32 pasid)
 			ev->hw_exception_data = hw_exception_data;
 			set_event(ev);
 			spin_unlock(&ev->lock);
+
+			if (pasid)
+				amdgpu_eventfd_notify(pasid, ev->event_id, 1);
 		}
 
 		if (ev->type == KFD_EVENT_TYPE_MEMORY) {
@@ -1374,6 +1431,9 @@ void kfd_signal_poison_consumed_event(struct kfd_node *dev, u32 pasid)
 			ev->memory_exception_data = memory_exception_data;
 			set_event(ev);
 			spin_unlock(&ev->lock);
+
+			if (pasid)
+				amdgpu_eventfd_notify(pasid, ev->event_id, 1);
 		}
 	}
 
@@ -1394,6 +1454,7 @@ void kfd_signal_process_terminate_event(struct kfd_process *p)
 {
 	struct kfd_event *ev;
 	u32 id;
+	u32 pasid = kfd_pasid_from_process(p);
 
 	rcu_read_lock();
 
@@ -1404,6 +1465,9 @@ void kfd_signal_process_terminate_event(struct kfd_process *p)
 			spin_lock(&ev->lock);
 			set_event(ev);
 			spin_unlock(&ev->lock);
+
+			if (pasid)
+				amdgpu_eventfd_notify(pasid, ev->event_id, 1);
 		}
 
 	/* Send SIGBUS to p->lead_thread */
-- 
2.34.1

