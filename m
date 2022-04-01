Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BDB1C433F5
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Apr 2022 13:02:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 022A710E2DC;
	Fri,  1 Apr 2022 13:02:38 +0000 (UTC)
Received: from ipmail05.adl3.internode.on.net (ipmail05.adl3.internode.on.net
 [150.101.137.13])
 by gabe.freedesktop.org (Postfix) with ESMTP id 8311510E242
 for <amd-gfx@lists.freedesktop.org>; Fri,  1 Apr 2022 12:18:51 +0000 (UTC)
X-SMTP-MATCH: 1
IronPort-Data: =?us-ascii?q?A9a23=3AmCAkyalCme9UxMi/OR5/EqXo5gyWJ0RdPkR7X?=
 =?us-ascii?q?Q2eYbSJt1+Wr1GztxIbUW7UO//eamL3Kt90PY21/U9UucOAmtA3GQpupCg2E?=
 =?us-ascii?q?X8T8cPLXY3DJUv7Mi/DJ8fJR0k/tZlFO4HMIspqFCKMjxr8abKJQVtUjPHQH?=
 =?us-ascii?q?OCgYALn1oGdfeLXIcsYoUoLd9MR2+aEv/DpW2thhvuqyyHvEAfNNw9cagr42?=
 =?us-ascii?q?YrawP9clKyaVAcjg7ALTasjUGkyNpUiJMl3yamZdxMUS2TPdwKwb76rILqRp?=
 =?us-ascii?q?gs18/qxY+5JnIoXcmVSKlLT0eZiiFIPAvjk2EEa4HZjlP9gbJLwam8O49mNt?=
 =?us-ascii?q?9lr1NVQr9q1QB0yPoXNnvgQSR9fHyw4OqsA/rLbSZS6mZDKlxKYLiO1kp2CC?=
 =?us-ascii?q?2ltZdZIoLwmaY1UztQVNjkLKAmejuSeybe3DOJrg6wLBc3mLIoZtnx6ix3UE?=
 =?us-ascii?q?P0mTIrrSqDGo9Rf2V8YrcBUHO3CZsMfLxloYRLBbDVGP1tRA5U79M+Li3/5f?=
 =?us-ascii?q?iFY7nyYo6Uf6m3figd21dDFFNvXfZquTNdchG6Ro26A9GP8ajkTMdDaxjSV2?=
 =?us-ascii?q?natnfPU2y3hVY8eGaa76vlyxlqJyQQ7AQcKVUah5/ywkFW+c9NZN0EO/C0io?=
 =?us-ascii?q?O418gqtQ8WVYvESiGrc61tFA5wIB7RvsEfV3vCBu0DIWTNfWmUUMJp7oJBjf?=
 =?us-ascii?q?TYuwgbRyoutXSgHXKa9UWqFr+7E6GnrYW1PfCpbPndCRAcBptDvq8Q3iRSKR?=
 =?us-ascii?q?MxqC/XsyMHtFnfxxSyHti45i7hVishN0ainlW0rSgmE/vDhJjPZLC2NNo590?=
 =?us-ascii?q?j5EWQ=3D=3D?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AYF0FQqvytDDiNb+oi6VpsIJ37skDYdV00z?=
 =?us-ascii?q?EX/kB9WHVpmwKj+/xG+85rsSMc5wx+ZJhNo7q90ey7MBDhHP1OkOws1MmZPT?=
 =?us-ascii?q?UO0VHAROpfBMnZsl/d8kbFmdK1u50MT0EHMr3NMWQ=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2AEBACq7EZiAIId0nZagRKBUYwvqyG?=
 =?us-ascii?q?BfAsBVAQBAYUHAoRYJjUIDgECBBUBAQYBAQEBAQcEEAE5UoV1hkMCAQMnCwF?=
 =?us-ascii?q?GEFFXgx2zJzKBAYgXgWWBPIk9hRE3gVVEgUuBBoIshAmBCYUyBJkeGSaBawS?=
 =?us-ascii?q?UG5tQkj00B4NMgTwGDJ4TTahOLZYxoU1yhi4BghMzGi6DL1AoV41VFo5BgRo?=
 =?us-ascii?q?CBgsBAQMJkWABAQ?=
Received: from ppp118-210-29-130.adl-adc-lon-bras31.tpg.internode.on.net (HELO
 localhost) ([118.210.29.130])
 by ipmail05.adl3.internode.on.net with ESMTP; 01 Apr 2022 22:48:49 +1030
Received: from amarsh04 by localhost with local (Exim 4.95)
 (envelope-from <arthur.marsh@internode.on.net>) id 1naGEp-0001Uw-HM;
 Fri, 01 Apr 2022 22:48:47 +1030
From: Arthur Marsh <arthur.marsh@internode.on.net>
To: evan.quan@amd.com
Subject: [PATCH V4 17/17] drm/amd/pm: unified lock protections in amdgpu_dpm.c
Date: Fri,  1 Apr 2022 22:48:47 +1030
Message-Id: <20220401121847.5754-1-amarsh04@internode.on.net>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <BYAPR12MB2615608D66B2894697D8C5FEE4E09@BYAPR12MB2615.namprd12.prod.outlook.com>
References: <BYAPR12MB2615608D66B2894697D8C5FEE4E09@BYAPR12MB2615.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 01 Apr 2022 13:02:37 +0000
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
Cc: Kenneth.Feng@amd.com, Lijo.Lazar@amd.com, amd-gfx@lists.freedesktop.org,
 Alexander.Deucher@amd.com, arthur.marsh@internode.on.net,
 Christian.Koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi, short answer is that with both patches applied, I am successfully running
the amdgpu kernel module on radeonsi (plasma desktop on X.org).

I confirmed that CONFIG_LOCKDEP_SUPPORT=y is enabled in the kernel.

With the first patch applied and remotely connecting to the machine and
loading amdgpu via:

modprobe amdgpu si_support=1 gpu_recovery=1

the last lines of dmesg were:

[  264.095969] [drm] Found UVD firmware Version: 64.0 Family ID: 13
[  264.097779] [drm] PCIE gen 2 link speeds already enabled
[  264.648137] [drm] UVD initialized successfully.
[  264.648696] amdgpu 0000:01:00.0: amdgpu: SE 1, SH per SE 2, CU per SH 5, active_cu_number 8
[  264.984814] [drm] Initialized amdgpu 3.46.0 20150101 for 0000:01:00.0 on minor 0
[  265.040280] fbcon: amdgpudrmfb (fb0) is primary device

After applying the second patch and building and restarting with the new
kernel, I could load amdgpu successfuly and start
the plasma desktop under X.org, with the last amdgpu load lines being:

[  227.736281] fbcon: amdgpudrmfb (fb0) is primary device
[  227.760719] Console: switching to colour frame buffer device 240x67
[  227.765024] amdgpu 0000:01:00.0: [drm] fb0: amdgpudrmfb frame buffer device

I tried building a kernel with just the second patch and that experienced
a lockup after apparently loading amdgpu alright.

First and second patches combined:

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
index 89fbee568be4..e9ebbc9f4cd2 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
@@ -80,8 +80,6 @@ int amdgpu_dpm_set_powergating_by_smu(struct amdgpu_device *adev, uint32_t block
 		return 0;
 	}
 
-	mutex_lock(&adev->pm.mutex);
-
 	switch (block_type) {
 	case AMD_IP_BLOCK_TYPE_UVD:
 	case AMD_IP_BLOCK_TYPE_VCE:
@@ -102,8 +100,6 @@ int amdgpu_dpm_set_powergating_by_smu(struct amdgpu_device *adev, uint32_t block
 	if (!ret)
 		atomic_set(&adev->pm.pwr_state[block_type], pwr_state);
 
-	mutex_unlock(&adev->pm.mutex);
-
 	return ret;
 }
 
@@ -423,9 +419,7 @@ void amdgpu_dpm_compute_clocks(struct amdgpu_device *adev)
 	if (!pp_funcs->pm_compute_clocks)
 		return;
 
-	mutex_lock(&adev->pm.mutex);
 	pp_funcs->pm_compute_clocks(adev->powerplay.pp_handle);
-	mutex_unlock(&adev->pm.mutex);
 }
 
 void amdgpu_dpm_enable_uvd(struct amdgpu_device *adev, bool enable)

Thanks for the assistance!

Arthur.
