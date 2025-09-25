Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE38FCAC5A5
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Sep 2025 09:02:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D42D10E898;
	Thu, 25 Sep 2025 09:02:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lNmnSw4Z";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013057.outbound.protection.outlook.com
 [40.93.196.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E688510E898
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Sep 2025 09:02:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eoDtkXbMTWqAA8fCs+YFb5FhoilzZYyzr41zZKP/NRyPPdz7GbRFxfdP088/xMF7gfS270ryn4nKnSQ4eyXgq5+C2oAL8pGYw1418CVm9NMl239yg8X91VJYzIWqv3Fuhh18zTdKdlbrwUiafvp/3hC+APO4uS/k4fabm+ZhQou0J1IRxTFrlCcD4m47cZ629ptxreVT4wDcjA0nZTtO1/fG5PS85BNl3TdBX2uppS1RQcBB5YC4HJCVTY/t/mtwW4DZSxPCuipMCO9jCZAnAhvp20bOuOq3NUnIVtsYt25id4iLMEPTjwJ5IH17xeWSnSDbZ6JpFPxuwKTQ/Ku/Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=82twc6Bp4aWXrVYHS6XkAEn2Z7vFNXQAQ06W2RqHnZI=;
 b=mBORJNUwoKUUaI2g8kFiocmoqLWu5d6AUpI9zGPJdGVeKG60pGhFrJtDIjG17QTgZIF1Py1z6cYabzxKcRuTQk7/04KOIb0LTJW1KPspcIUImovTiLZ2+99fnVn+vjFecpPTEOOVgdlbE0XPLNjh10ArWrB14dXreyuxotc76Qi571C98b1bck74+IAIQfmoV3mobn/xFpMf3G8nbAcR0L7Jjozt3peyVItwKHaCUANdliKfvvrZ2341n3c6h3Cj4llJPl/WSoYpmLdkjrWxmtdf/SPA6cTMCimM1JXWglKmIF10tkt5F3QxsftMA/U4lYW+yD+O5u+3eGqjp6Tu3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=82twc6Bp4aWXrVYHS6XkAEn2Z7vFNXQAQ06W2RqHnZI=;
 b=lNmnSw4Zq8m+AbWkikhy3O+vdsFMp+OOsHEv2BuFi3/4/C3KuzFMhoD3KiX85ZTBBVl44LFMYx9lrOPEZgrjZSYU5sRlR61kHCByk1XnEFhdKOxUtYcHx0BybI1dm6fA7qWM9cninEIliHVhrP8mywtoTEIs/sW2NghrEXCezTQ=
Received: from PH8P223CA0002.NAMP223.PROD.OUTLOOK.COM (2603:10b6:510:2db::8)
 by CY8PR12MB7539.namprd12.prod.outlook.com (2603:10b6:930:96::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.20; Thu, 25 Sep
 2025 09:02:41 +0000
Received: from SN1PEPF00036F42.namprd05.prod.outlook.com
 (2603:10b6:510:2db:cafe::de) by PH8P223CA0002.outlook.office365.com
 (2603:10b6:510:2db::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.20 via Frontend Transport; Thu,
 25 Sep 2025 09:02:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SN1PEPF00036F42.mail.protection.outlook.com (10.167.248.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.9 via Frontend Transport; Thu, 25 Sep 2025 09:02:41 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 25 Sep
 2025 02:02:41 -0700
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 25 Sep
 2025 02:02:40 -0700
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Thu, 25 Sep 2025 02:02:39 -0700
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse.Zhang <Jesse.Zhang@amd.com>
Subject: [v7 1/2] drm/amdgpu: Convert amdgpu userqueue management from IDR to
 XArray
Date: Thu, 25 Sep 2025 17:01:32 +0800
Message-ID: <20250925090238.2862961-1-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F42:EE_|CY8PR12MB7539:EE_
X-MS-Office365-Filtering-Correlation-Id: b1b8ff4f-0899-4064-2908-08ddfc12488e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Z0JBVytTRHF3d00rWGRXYzhKeDhLcWw5YXJoKzF0bEREbWZQMmVzaEgvdHBu?=
 =?utf-8?B?VlQwbE5ucUFWSkIxeXBkOU16UHNRd2FQVWhmditPYm9PK3FKZFAyQkR4dEVv?=
 =?utf-8?B?eHZFTTF1Q3F0aGQvcHJSdEdpeFNaZ0Z2aHpKOVBIZVN4UTZPMXRLcDFQNzRs?=
 =?utf-8?B?OUVaY0ovTlhEQ3o0ZytyWW41WU5nM0p3WGYyamtXMjlySUoySWtXT3VNWHd4?=
 =?utf-8?B?QmFtb010d1k5ZWNWMTZSZWJMMFlTYnFnV0NWSnp0dU9NWlc5SWlUNVFpdC8x?=
 =?utf-8?B?eUt5OGVpVkFxZDd1YThWUGlvc09meGlVNjNjUFlBeTVwaVhsWnNLMEhjNi94?=
 =?utf-8?B?QW9XSUFMc0xWRTRZTWVxWlZxeEczOEFrdGU4STBCN3Z4b3hiL3ptdXNkb1Ba?=
 =?utf-8?B?SXZEamEzRCtBY1VnZTNDUVR4T0xaN0tLY1dZamx5cnBUNzJpT2RDcDdKWTZM?=
 =?utf-8?B?S1ZBNTBSTzMrdG5DYTJPQ2pHTFo2TkNuTU0xN2tOYlZLU1RtbVJTSThEWHZa?=
 =?utf-8?B?ZmN3QmZ6R1Zsc2xaVFk3bzFxeTBGL2FmSytYeGwrWThhUU9tTTdJamI4Z0JL?=
 =?utf-8?B?YkQxVXQ2NjZoV3ZyUjNMVy9hc0tnZHlGeWtCNVg4a2RSbmMwUFJndkRudExZ?=
 =?utf-8?B?SWdkWTFkZTlvNUJSbDk3YjNvUHBVbWVXTW50SUUzbEJ1SlJXMVM0ODFkUUJH?=
 =?utf-8?B?ZFdVTndmbXBaRytHT2ZqYlJjczA0N0NqTGhDVWRzYjZ2K1gvNXd5WG91T29s?=
 =?utf-8?B?cEVHRXRkSFljQ0J1b2RuUnhkZ0QzU09scndVRWk5VUpaUEhBQWtaZEFPNlB5?=
 =?utf-8?B?VjZTbGYrdzR5S3Q3c21GODNMR2YyK3V5UitBc1lDN2dFY21SL2Jock1SOWta?=
 =?utf-8?B?RkVkZWJhRHBCMmdHdUc4cG44S2tvNy8zZ1ZoeHc3dVJ6ZkZkaWRsY0ordUFH?=
 =?utf-8?B?a1pzYkZ1N2hTclg1TVBHN2dFbGRYQldoZ2Y5c25MOWxwUUJrSmdiWmJ5RnpR?=
 =?utf-8?B?YVFQSVZ6YWwxL3YrcVZDd0FQdzdpUGk1WXY3VDNYRnRrNEVkaHpkdTJ2eHRP?=
 =?utf-8?B?VVhXektUazBXVGQvVHhtbk16L0xOd1BzalVWOTIxMlVzNnVqc3dxSGNXTUQy?=
 =?utf-8?B?bVJHNFZ1S0dTQ0dBRVM2QjU5V0NrL0pSbEZ2WFNqRDE4UzhrU0NyeUFncVI3?=
 =?utf-8?B?bUNyZU5IOUZwb1BFMkNlSnFhdk5tVUNPSVJWU1VLTWJpS0tMUHpDY1Y3NVN1?=
 =?utf-8?B?L2Zrd29zYVBqcHQwNVNHeVF0aWNlL2hXdFUvcnlaL1ZkSzVFSkNwSERTa0tu?=
 =?utf-8?B?Q2RYZitzbEV5UWJtdnBXcko2NVRmWTBYdUZDd0JybUVTcDVYTHh5MHZRY0do?=
 =?utf-8?B?aTZYdVBZSmV5WHdTdE9UQWoxTk5tMkRkaTA5Q29aNHJXMjFIbFluWlkrd282?=
 =?utf-8?B?T1Q0ZUJVL25haHJzRS9VR2ZkeE01ckVRSGRHK05WVlZyb0tjKzRhT045NUg0?=
 =?utf-8?B?OUN1N1l4aGxIZ1MzbkxCVldETzdQVlVHNzBSRGhwSFJWTGNkVTl6TzQvTk1o?=
 =?utf-8?B?Ni90cE9qa3lZeUE5M0RUMXJxSXJNUk9lcy9iSkZNNXRTVHFxQkJKR1Q2RDVU?=
 =?utf-8?B?Z0dRdTZ6L2NtUVhRM0JxTjA0ei9lMTdKcEVtZ1Z5cEl6NjJER0IxaUwxY21B?=
 =?utf-8?B?NHptdlNwdVNwSlJVTjd0c1BiOHZsdUlPR3R6TDlFcUs2WFdvUk14ZkZtdTdC?=
 =?utf-8?B?Y28wUkhJQ0l5djVvaUpVc1RWQmlSYy9vTmtDWm9oZ20ranpkd05jWGxMQWVu?=
 =?utf-8?B?MjdFTlAxanZlM3BJNEpqTG1Rb001dkVrdnVaODhSbGtKbzF4U21TSzZmc204?=
 =?utf-8?B?MkZleVVsRG1aTzdWSS9EYklJKzYrRENoTXhoNkdDeEtmZ0k0M1JYYnFXR0U3?=
 =?utf-8?B?b1BvbG1Lc01YOXNTeENyRjNDc0M3M2FsUlh2c3o1Q2pMK0htOVRYWllpbngw?=
 =?utf-8?B?amdPSEhKQ1VUdXVBN1kxR09nRGh5eHJxZ3loaXZ1U29BMkVjVVAxU0FUN01y?=
 =?utf-8?B?OVh4T1JGTU1icytYSnhvM3dQVHdkUmkwZFNoN242RHg5L3U5bUhPY29PbURO?=
 =?utf-8?Q?Gp+c=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2025 09:02:41.2639 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b1b8ff4f-0899-4064-2908-08ddfc12488e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00036F42.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7539
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

This commit refactors the AMDGPU userqueue management subsystem to replace
IDR (ID Allocation) with XArray for improved performance, scalability, and
maintainability. The changes address several issues with the previous IDR
implementation and provide better locking semantics.

Key changes:

1. **Global XArray Introduction**:
   - Added `userq_doorbell_xa` to `struct amdgpu_device` for global queue tracking
   - Uses doorbell_index as key for efficient global lookup
   - Replaces the previous `userq_mgr_list` linked list approach

2. **Per-process XArray Conversion**:
   - Replaced `userq_idr` with `userq_mgr_xa` in `struct amdgpu_userq_mgr`
   - Maintains per-process queue tracking with queue_id as key
   - Uses XA_FLAGS_ALLOC for automatic ID allocation

3. **Locking Improvements**:
   - Removed global `userq_mutex` from `struct amdgpu_device`
   - Replaced with fine-grained XArray locking using XArray's internal spinlocks

4. **Runtime Idle Check Optimization**:
   - Updated `amdgpu_runtime_idle_check_userq()` to use xa_empty

5. **Queue Management Functions**:
   - Converted all IDR operations to equivalent XArray functions:
     - `idr_alloc()` → `xa_alloc()`
     - `idr_find()` → `xa_load()`
     - `idr_remove()` → `xa_erase()`
     - `idr_for_each()` → `xa_for_each()`

Benefits:
- **Performance**: XArray provides better scalability for large numbers of queues
- **Memory Efficiency**: Reduced memory overhead compared to IDR
- **Thread Safety**: Improved locking semantics with XArray's internal spinlocks

v2: rename userq_global_xa/userq_xa to userq_doorbell_xa/userq_mgr_xa
    Remove xa_lock and use its own lock.

v3: Set queue->userq_mgr = uq_mgr in amdgpu_userq_create()
v4: use xa_store_irq (Christian)
    hold the read side of the reset lock while creating/destroying queues and the manager data structure. (Chritian)

Suggested-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |   8 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |   3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |  16 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c     | 154 +++++++++---------
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h     |   8 +-
 .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   |   4 +-
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c    |  22 ++-
 7 files changed, 101 insertions(+), 114 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 2a0df4cabb99..ae10832a09f4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1174,6 +1174,12 @@ struct amdgpu_device {
 	 * queue fence.
 	 */
 	struct xarray			userq_xa;
+	/**
+	 * @userq_doorbell_xa: Global user queue map (doorbell index → queue)
+	 * Key: doorbell_index (unique global identifier for the queue)
+	 * Value: struct amdgpu_usermode_queue
+	 */
+	struct xarray userq_doorbell_xa;
 
 	/* df */
 	struct amdgpu_df                df;
@@ -1308,8 +1314,6 @@ struct amdgpu_device {
 	 */
 	bool                            apu_prefer_gtt;
 
-	struct list_head		userq_mgr_list;
-	struct mutex                    userq_mutex;
 	bool                            userq_halt_for_enforce_isolation;
 	struct amdgpu_uid *uid_info;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index a77000c2e0bb..6d083522d5e7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4483,7 +4483,6 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	mutex_init(&adev->gfx.userq_sch_mutex);
 	mutex_init(&adev->gfx.workload_profile_mutex);
 	mutex_init(&adev->vcn.workload_profile_mutex);
-	mutex_init(&adev->userq_mutex);
 
 	amdgpu_device_init_apu_flags(adev);
 
@@ -4511,7 +4510,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 
 	INIT_LIST_HEAD(&adev->pm.od_kobj_list);
 
-	INIT_LIST_HEAD(&adev->userq_mgr_list);
+	xa_init(&adev->userq_doorbell_xa);
 
 	INIT_DELAYED_WORK(&adev->delayed_init_work,
 			  amdgpu_device_delayed_init_work_handler);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index ece251cbe8c3..fdea7cd4b3ce 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2771,22 +2771,8 @@ static int amdgpu_runtime_idle_check_userq(struct device *dev)
 	struct pci_dev *pdev = to_pci_dev(dev);
 	struct drm_device *drm_dev = pci_get_drvdata(pdev);
 	struct amdgpu_device *adev = drm_to_adev(drm_dev);
-	struct amdgpu_usermode_queue *queue;
-	struct amdgpu_userq_mgr *uqm, *tmp;
-	int queue_id;
-	int ret = 0;
-
-	mutex_lock(&adev->userq_mutex);
-	list_for_each_entry_safe(uqm, tmp, &adev->userq_mgr_list, list) {
-		idr_for_each_entry(&uqm->userq_idr, queue, queue_id) {
-			ret = -EBUSY;
-			goto done;
-		}
-	}
-done:
-	mutex_unlock(&adev->userq_mutex);
 
-	return ret;
+	return xa_empty(&adev->userq_doorbell_xa) ? 0 : -EBUSY;
 }
 
 static int amdgpu_pmops_runtime_suspend(struct device *dev)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 3bbe1001fda1..28efa1e3a2fb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -182,16 +182,24 @@ amdgpu_userq_cleanup(struct amdgpu_userq_mgr *uq_mgr,
 	struct amdgpu_device *adev = uq_mgr->adev;
 	const struct amdgpu_userq_funcs *uq_funcs = adev->userq_funcs[queue->queue_type];
 
+	/* Wait for mode-1 reset to complete */
+	down_read(&adev->reset_domain->sem);
 	uq_funcs->mqd_destroy(uq_mgr, queue);
 	amdgpu_userq_fence_driver_free(queue);
-	idr_remove(&uq_mgr->userq_idr, queue_id);
+
+	/* Use interrupt-safe locking since IRQ handlers may access these XArrays */
+	xa_erase_irq(&uq_mgr->userq_mgr_xa, (unsigned long)queue_id);
+	xa_erase_irq(&adev->userq_doorbell_xa, queue->doorbell_index);
+
+	queue->userq_mgr = NULL;
 	kfree(queue);
+	up_read(&adev->reset_domain->sem);
 }
 
 static struct amdgpu_usermode_queue *
 amdgpu_userq_find(struct amdgpu_userq_mgr *uq_mgr, int qid)
 {
-	return idr_find(&uq_mgr->userq_idr, qid);
+	return xa_load(&uq_mgr->userq_mgr_xa, qid);
 }
 
 void
@@ -463,8 +471,9 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 	struct amdgpu_db_info db_info;
 	char *queue_name;
 	bool skip_map_queue;
+	u32 qid;
 	uint64_t index;
-	int qid, r = 0;
+	int r = 0;
 	int priority =
 		(args->in.flags & AMDGPU_USERQ_CREATE_FLAGS_QUEUE_PRIORITY_MASK) >>
 		AMDGPU_USERQ_CREATE_FLAGS_QUEUE_PRIORITY_SHIFT;
@@ -487,7 +496,6 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 	 *
 	 * This will also make sure we have a valid eviction fence ready to be used.
 	 */
-	mutex_lock(&adev->userq_mutex);
 	amdgpu_userq_ensure_ev_fence(&fpriv->userq_mgr, &fpriv->evf_mgr);
 
 	uq_funcs = adev->userq_funcs[args->in.ip_type];
@@ -547,17 +555,27 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 		kfree(queue);
 		goto unlock;
 	}
+	/* Wait for mode-1 reset to complete */
+	down_read(&adev->reset_domain->sem);
+	r =xa_err(xa_store_irq(&adev->userq_doorbell_xa, index, queue, GFP_KERNEL));
+	if (r) {
+		kfree(queue);
+		up_read(&adev->reset_domain->sem);
+		goto unlock;
+	}
 
-
-	qid = idr_alloc(&uq_mgr->userq_idr, queue, 1, AMDGPU_MAX_USERQ_COUNT, GFP_KERNEL);
-	if (qid < 0) {
+	r = xa_alloc(&uq_mgr->userq_mgr_xa, &qid, queue, XA_LIMIT(1, AMDGPU_MAX_USERQ_COUNT), GFP_KERNEL);
+	if (r) {
 		drm_file_err(uq_mgr->file, "Failed to allocate a queue id\n");
 		amdgpu_userq_fence_driver_free(queue);
 		uq_funcs->mqd_destroy(uq_mgr, queue);
 		kfree(queue);
 		r = -ENOMEM;
+		up_read(&adev->reset_domain->sem);
 		goto unlock;
 	}
+	up_read(&adev->reset_domain->sem);
+	queue->userq_mgr = uq_mgr;
 
 	/* don't map the queue if scheduling is halted */
 	if (adev->userq_halt_for_enforce_isolation &&
@@ -570,7 +588,7 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 		r = amdgpu_userq_map_helper(uq_mgr, queue);
 		if (r) {
 			drm_file_err(uq_mgr->file, "Failed to map Queue\n");
-			idr_remove(&uq_mgr->userq_idr, qid);
+			xa_erase(&uq_mgr->userq_mgr_xa, qid);
 			amdgpu_userq_fence_driver_free(queue);
 			uq_funcs->mqd_destroy(uq_mgr, queue);
 			kfree(queue);
@@ -593,7 +611,6 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 
 unlock:
 	mutex_unlock(&uq_mgr->userq_mutex);
-	mutex_unlock(&adev->userq_mutex);
 
 	return r;
 }
@@ -691,11 +708,11 @@ static int
 amdgpu_userq_restore_all(struct amdgpu_userq_mgr *uq_mgr)
 {
 	struct amdgpu_usermode_queue *queue;
-	int queue_id;
+	unsigned long queue_id;
 	int ret = 0, r;
 
 	/* Resume all the queues for this process */
-	idr_for_each_entry(&uq_mgr->userq_idr, queue, queue_id) {
+	xa_for_each(&uq_mgr->userq_mgr_xa, queue_id, queue) {
 		r = amdgpu_userq_restore_helper(uq_mgr, queue);
 		if (r)
 			ret = r;
@@ -846,11 +863,11 @@ static int
 amdgpu_userq_evict_all(struct amdgpu_userq_mgr *uq_mgr)
 {
 	struct amdgpu_usermode_queue *queue;
-	int queue_id;
+	unsigned long queue_id;
 	int ret = 0, r;
 
 	/* Try to unmap all the queues in this process ctx */
-	idr_for_each_entry(&uq_mgr->userq_idr, queue, queue_id) {
+	xa_for_each(&uq_mgr->userq_mgr_xa, queue_id, queue) {
 		r = amdgpu_userq_preempt_helper(uq_mgr, queue);
 		if (r)
 			ret = r;
@@ -865,9 +882,10 @@ static int
 amdgpu_userq_wait_for_signal(struct amdgpu_userq_mgr *uq_mgr)
 {
 	struct amdgpu_usermode_queue *queue;
-	int queue_id, ret;
+	unsigned long queue_id;
+	int ret;
 
-	idr_for_each_entry(&uq_mgr->userq_idr, queue, queue_id) {
+	xa_for_each(&uq_mgr->userq_mgr_xa, queue_id, queue) {
 		struct dma_fence *f = queue->last_fence;
 
 		if (!f || dma_fence_is_signaled(f))
@@ -920,44 +938,30 @@ int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *userq_mgr, struct drm_file *f
 			  struct amdgpu_device *adev)
 {
 	mutex_init(&userq_mgr->userq_mutex);
-	idr_init_base(&userq_mgr->userq_idr, 1);
+	xa_init_flags(&userq_mgr->userq_mgr_xa, XA_FLAGS_ALLOC);
 	userq_mgr->adev = adev;
 	userq_mgr->file = file_priv;
 
-	mutex_lock(&adev->userq_mutex);
-	list_add(&userq_mgr->list, &adev->userq_mgr_list);
-	mutex_unlock(&adev->userq_mutex);
-
 	INIT_DELAYED_WORK(&userq_mgr->resume_work, amdgpu_userq_restore_worker);
 	return 0;
 }
 
 void amdgpu_userq_mgr_fini(struct amdgpu_userq_mgr *userq_mgr)
 {
-	struct amdgpu_device *adev = userq_mgr->adev;
 	struct amdgpu_usermode_queue *queue;
-	struct amdgpu_userq_mgr *uqm, *tmp;
-	uint32_t queue_id;
+	unsigned long queue_id;
 
 	cancel_delayed_work_sync(&userq_mgr->resume_work);
 
-	mutex_lock(&adev->userq_mutex);
 	mutex_lock(&userq_mgr->userq_mutex);
-	idr_for_each_entry(&userq_mgr->userq_idr, queue, queue_id) {
+	xa_for_each(&userq_mgr->userq_mgr_xa, queue_id, queue) {
 		amdgpu_userq_wait_for_last_fence(userq_mgr, queue);
 		amdgpu_userq_unmap_helper(userq_mgr, queue);
 		amdgpu_userq_cleanup(userq_mgr, queue, queue_id);
 	}
 
-	list_for_each_entry_safe(uqm, tmp, &adev->userq_mgr_list, list) {
-		if (uqm == userq_mgr) {
-			list_del(&uqm->list);
-			break;
-		}
-	}
-	idr_destroy(&userq_mgr->userq_idr);
+	xa_destroy(&userq_mgr->userq_mgr_xa);
 	mutex_unlock(&userq_mgr->userq_mutex);
-	mutex_unlock(&adev->userq_mutex);
 	mutex_destroy(&userq_mgr->userq_mutex);
 }
 
@@ -965,28 +969,26 @@ int amdgpu_userq_suspend(struct amdgpu_device *adev)
 {
 	u32 ip_mask = amdgpu_userq_get_supported_ip_mask(adev);
 	struct amdgpu_usermode_queue *queue;
-	struct amdgpu_userq_mgr *uqm, *tmp;
-	int queue_id;
+	struct amdgpu_userq_mgr *uqm;
+	unsigned long queue_id;
 	int ret = 0, r;
 
 	if (!ip_mask)
 		return 0;
 
-	mutex_lock(&adev->userq_mutex);
-	list_for_each_entry_safe(uqm, tmp, &adev->userq_mgr_list, list) {
+	xa_for_each(&adev->userq_doorbell_xa, queue_id, queue) {
+		uqm = queue->userq_mgr;
 		cancel_delayed_work_sync(&uqm->resume_work);
 		mutex_lock(&uqm->userq_mutex);
-		idr_for_each_entry(&uqm->userq_idr, queue, queue_id) {
-			if (adev->in_s0ix)
-				r = amdgpu_userq_preempt_helper(uqm, queue);
-			else
-				r = amdgpu_userq_unmap_helper(uqm, queue);
-			if (r)
-				ret = r;
-		}
+		if (adev->in_s0ix)
+			r = amdgpu_userq_preempt_helper(uqm, queue);
+		else
+			r = amdgpu_userq_unmap_helper(uqm, queue);
+		if (r)
+			ret = r;
 		mutex_unlock(&uqm->userq_mutex);
 	}
-	mutex_unlock(&adev->userq_mutex);
+
 	return ret;
 }
 
@@ -994,27 +996,25 @@ int amdgpu_userq_resume(struct amdgpu_device *adev)
 {
 	u32 ip_mask = amdgpu_userq_get_supported_ip_mask(adev);
 	struct amdgpu_usermode_queue *queue;
-	struct amdgpu_userq_mgr *uqm, *tmp;
-	int queue_id;
+	struct amdgpu_userq_mgr *uqm;
+	unsigned long queue_id;
 	int ret = 0, r;
 
 	if (!ip_mask)
 		return 0;
 
-	mutex_lock(&adev->userq_mutex);
-	list_for_each_entry_safe(uqm, tmp, &adev->userq_mgr_list, list) {
+	xa_for_each(&adev->userq_doorbell_xa, queue_id, queue) {
+		uqm = queue->userq_mgr;
 		mutex_lock(&uqm->userq_mutex);
-		idr_for_each_entry(&uqm->userq_idr, queue, queue_id) {
-			if (adev->in_s0ix)
-				r = amdgpu_userq_restore_helper(uqm, queue);
-			else
-				r = amdgpu_userq_map_helper(uqm, queue);
-			if (r)
-				ret = r;
-		}
+		if (adev->in_s0ix)
+			r = amdgpu_userq_restore_helper(uqm, queue);
+		else
+			r = amdgpu_userq_map_helper(uqm, queue);
+		if (r)
+			ret = r;
 		mutex_unlock(&uqm->userq_mutex);
 	}
-	mutex_unlock(&adev->userq_mutex);
+
 	return ret;
 }
 
@@ -1023,33 +1023,31 @@ int amdgpu_userq_stop_sched_for_enforce_isolation(struct amdgpu_device *adev,
 {
 	u32 ip_mask = amdgpu_userq_get_supported_ip_mask(adev);
 	struct amdgpu_usermode_queue *queue;
-	struct amdgpu_userq_mgr *uqm, *tmp;
-	int queue_id;
+	struct amdgpu_userq_mgr *uqm;
+	unsigned long queue_id;
 	int ret = 0, r;
 
 	/* only need to stop gfx/compute */
 	if (!(ip_mask & ((1 << AMDGPU_HW_IP_GFX) | (1 << AMDGPU_HW_IP_COMPUTE))))
 		return 0;
 
-	mutex_lock(&adev->userq_mutex);
 	if (adev->userq_halt_for_enforce_isolation)
 		dev_warn(adev->dev, "userq scheduling already stopped!\n");
 	adev->userq_halt_for_enforce_isolation = true;
-	list_for_each_entry_safe(uqm, tmp, &adev->userq_mgr_list, list) {
+	xa_for_each(&adev->userq_doorbell_xa, queue_id, queue) {
+		uqm = queue->userq_mgr;
 		cancel_delayed_work_sync(&uqm->resume_work);
 		mutex_lock(&uqm->userq_mutex);
-		idr_for_each_entry(&uqm->userq_idr, queue, queue_id) {
-			if (((queue->queue_type == AMDGPU_HW_IP_GFX) ||
-			     (queue->queue_type == AMDGPU_HW_IP_COMPUTE)) &&
-			    (queue->xcp_id == idx)) {
-				r = amdgpu_userq_preempt_helper(uqm, queue);
-				if (r)
-					ret = r;
-			}
+		if (((queue->queue_type == AMDGPU_HW_IP_GFX) ||
+		     (queue->queue_type == AMDGPU_HW_IP_COMPUTE)) &&
+		    (queue->xcp_id == idx)) {
+			r = amdgpu_userq_preempt_helper(uqm, queue);
+			if (r)
+				ret = r;
 		}
 		mutex_unlock(&uqm->userq_mutex);
 	}
-	mutex_unlock(&adev->userq_mutex);
+
 	return ret;
 }
 
@@ -1058,21 +1056,20 @@ int amdgpu_userq_start_sched_for_enforce_isolation(struct amdgpu_device *adev,
 {
 	u32 ip_mask = amdgpu_userq_get_supported_ip_mask(adev);
 	struct amdgpu_usermode_queue *queue;
-	struct amdgpu_userq_mgr *uqm, *tmp;
-	int queue_id;
+	struct amdgpu_userq_mgr *uqm;
+	unsigned long queue_id;
 	int ret = 0, r;
 
 	/* only need to stop gfx/compute */
 	if (!(ip_mask & ((1 << AMDGPU_HW_IP_GFX) | (1 << AMDGPU_HW_IP_COMPUTE))))
 		return 0;
 
-	mutex_lock(&adev->userq_mutex);
 	if (!adev->userq_halt_for_enforce_isolation)
 		dev_warn(adev->dev, "userq scheduling already started!\n");
 	adev->userq_halt_for_enforce_isolation = false;
-	list_for_each_entry_safe(uqm, tmp, &adev->userq_mgr_list, list) {
+	xa_for_each(&adev->userq_doorbell_xa, queue_id, queue) {
+		uqm = queue->userq_mgr;
 		mutex_lock(&uqm->userq_mutex);
-		idr_for_each_entry(&uqm->userq_idr, queue, queue_id) {
 			if (((queue->queue_type == AMDGPU_HW_IP_GFX) ||
 			     (queue->queue_type == AMDGPU_HW_IP_COMPUTE)) &&
 			    (queue->xcp_id == idx)) {
@@ -1080,9 +1077,8 @@ int amdgpu_userq_start_sched_for_enforce_isolation(struct amdgpu_device *adev,
 				if (r)
 					ret = r;
 			}
-		}
 		mutex_unlock(&uqm->userq_mutex);
 	}
-	mutex_unlock(&adev->userq_mutex);
+
 	return ret;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
index c027dd916672..c562c8d2b53a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
@@ -88,11 +88,15 @@ struct amdgpu_userq_funcs {
 
 /* Usermode queues for gfx */
 struct amdgpu_userq_mgr {
-	struct idr			userq_idr;
+	/**
+	 * @userq_mgr_xa: Per-process user queue map (queue ID → queue)
+	 * Key: queue_id (unique ID within the process's userq manager)
+	 * Value: struct amdgpu_usermode_queue
+	 */
+	struct xarray			userq_mgr_xa;
 	struct mutex			userq_mutex;
 	struct amdgpu_device		*adev;
 	struct delayed_work		resume_work;
-	struct list_head		list;
 	struct drm_file			*file;
 };
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
index 761bad98da3e..2aeeaa954882 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
@@ -537,7 +537,7 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
 	}
 
 	/* Retrieve the user queue */
-	queue = idr_find(&userq_mgr->userq_idr, args->queue_id);
+	queue = xa_load(&userq_mgr->userq_mgr_xa, args->queue_id);
 	if (!queue) {
 		r = -ENOENT;
 		goto put_gobj_write;
@@ -899,7 +899,7 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
 		 */
 		num_fences = dma_fence_dedup_array(fences, num_fences);
 
-		waitq = idr_find(&userq_mgr->userq_idr, wait_info->waitq_id);
+		waitq = xa_load(&userq_mgr->userq_mgr_xa, wait_info->waitq_id);
 		if (!waitq) {
 			r = -EINVAL;
 			goto free_fences;
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
index 2db9b2c63693..9e4229c79c69 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
@@ -205,9 +205,9 @@ static int mes_userq_detect_and_reset(struct amdgpu_device *adev,
 	int db_array_size = amdgpu_mes_get_hung_queue_db_array_size(adev);
 	struct mes_detect_and_reset_queue_input input;
 	struct amdgpu_usermode_queue *queue;
-	struct amdgpu_userq_mgr *uqm, *tmp;
 	unsigned int hung_db_num = 0;
-	int queue_id, r, i;
+	unsigned long queue_id;
+	int r, i;
 	u32 db_array[4];
 
 	if (db_array_size > 4) {
@@ -227,16 +227,14 @@ static int mes_userq_detect_and_reset(struct amdgpu_device *adev,
 	if (r) {
 		dev_err(adev->dev, "Failed to detect and reset queues, err (%d)\n", r);
 	} else if (hung_db_num) {
-		list_for_each_entry_safe(uqm, tmp, &adev->userq_mgr_list, list) {
-			idr_for_each_entry(&uqm->userq_idr, queue, queue_id) {
-				if (queue->queue_type == queue_type) {
-					for (i = 0; i < hung_db_num; i++) {
-						if (queue->doorbell_index == db_array[i]) {
-							queue->state = AMDGPU_USERQ_STATE_HUNG;
-							atomic_inc(&adev->gpu_reset_counter);
-							amdgpu_userq_fence_driver_force_completion(queue);
-							drm_dev_wedged_event(adev_to_drm(adev), DRM_WEDGE_RECOVERY_NONE, NULL);
-						}
+		xa_for_each(&adev->userq_doorbell_xa, queue_id, queue) {
+			if (queue->queue_type == queue_type) {
+				for (i = 0; i < hung_db_num; i++) {
+					if (queue->doorbell_index == db_array[i]) {
+						queue->state = AMDGPU_USERQ_STATE_HUNG;
+						atomic_inc(&adev->gpu_reset_counter);
+						amdgpu_userq_fence_driver_force_completion(queue);
+						drm_dev_wedged_event(adev_to_drm(adev), DRM_WEDGE_RECOVERY_NONE, NULL);
 					}
 				}
 			}
-- 
2.49.0

