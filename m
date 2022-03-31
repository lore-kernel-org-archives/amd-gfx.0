Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F10DBC433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 31 Mar 2022 07:47:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D39910FD0C;
	Thu, 31 Mar 2022 07:47:40 +0000 (UTC)
Received: from ipmail03.adl6.internode.on.net (ipmail03.adl6.internode.on.net
 [150.101.137.143])
 by gabe.freedesktop.org (Postfix) with ESMTP id BC22A10F5E7
 for <amd-gfx@lists.freedesktop.org>; Thu, 31 Mar 2022 04:27:32 +0000 (UTC)
X-SMTP-MATCH: 1
IronPort-Data: =?us-ascii?q?A9a23=3AlUiTmq6xjbMIFNcpN+zuUgxRtC/GchMFZxGqf?=
 =?us-ascii?q?qrLsTDasY5as4F+vmYXXjuHOquCYmCkfdsjaI6+8BgG7MOByIIyQABlrCozF?=
 =?us-ascii?q?3sbp5KYXI/BfkyqY32Zf5ScQR8+4sgUN9TKdcpsRCf1q0b2ONANj1ElhfnSH?=
 =?us-ascii?q?OaU5M0om8xJqLwNpB4J0XqPpsZg6mJWqYjha++ykYuaT/33YDdJ6hYsWo4mw?=
 =?us-ascii?q?/vrRCBH5JwejAglUmkWPpinirN/e049V/rzLYnpR5fxrxI98uSSH44vx5nhl?=
 =?us-ascii?q?o/VEotENz+rrlr7WhVirr8+0+SMoiMPC+7420AE/H10i/1jXBYfQR4/ZzGhl?=
 =?us-ascii?q?sptyMhX85m5UxwpFqzKhOkHVR5UHmd5O+tA9aOvzX2X65zDlxCZLiCyqxlpJ?=
 =?us-ascii?q?BpuZt1CoLcf7Xt13fEGITZLdw2Kgcq/xb79Qe5p7uwKKMT7NYUTt2sm4TzEB?=
 =?us-ascii?q?vYrW7jKRqmM7thdtB8bhtpPBurfbsxfSj1iahXPSxRKNhEcD5dWtMSlgH/yb?=
 =?us-ascii?q?z0ehl+TqoI+5mSVxwt0uJDJMdjSPPiDV8xPtk+dqiTN+GGRKhgfOJmQxyqt9?=
 =?us-ascii?q?nO3mvSJkzn2VY4fD76k8eYsh0ecrkQaEgEWSEH9pPCjkU6WWtRDJlYS/SYj6?=
 =?us-ascii?q?680skqmUrHAs7eQtCbR+0dEHYJESrhirlmZkP+MpVfGXTMQFWsZLoEy65oOT?=
 =?us-ascii?q?zg+jwfcx5exEVSDq5WNUWrEr+fR92rqfHJEaDZZPWkNQQ9A6tXo5YU0iFfFV?=
 =?us-ascii?q?N94S/fzksX6XzD23z2Qqi8yivMUi4gN2rnTwLwOuBr0zrChc+L/zl+/srqZ0?=
 =?us-ascii?q?z5E?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AXK2oxqFucJce12WOpLqE/8eALOsnbusQ8z?=
 =?us-ascii?q?AXPo5KJSC9Ffbo8/xG88506faZslwssTQb6LO90cq7MBbhHOBOgLX5VI3KNG?=
 =?us-ascii?q?LbUSmTXeNfBODZrAEIdReSygck78ddT5Q=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2BJAwDcLEViAIId0nZagRKBUYwvqyC?=
 =?us-ascii?q?BfAsBVAQBAYUHAoRYJjQJDgECBBUBAQYBAQEBAQcEEAE5UoV1hkMCAQMnCwF?=
 =?us-ascii?q?GEFFXgx2yPDKBAYgXgWWBPIk7hQ83gVVEgUuBBoIshRKFMgSYfhmCFcIiNAe?=
 =?us-ascii?q?DTIE7BgyeD02oTC2WMKI8hi2CFTMaLoMvUCidA4EaAgYLAQEDCZFgAQE?=
Received: from ppp118-210-29-130.adl-adc-lon-bras31.tpg.internode.on.net (HELO
 localhost) ([118.210.29.130])
 by ipmail03.adl6.internode.on.net with ESMTP; 31 Mar 2022 14:57:30 +1030
Received: from amarsh04 by localhost with local (Exim 4.95)
 (envelope-from <arthur.marsh@internode.on.net>) id 1nZmPB-0000uQ-Br;
 Thu, 31 Mar 2022 14:57:29 +1030
From: Arthur Marsh <arthur.marsh@internode.on.net>
To: evan.quan@amd.com
Subject: [PATCH V4 17/17] drm/amd/pm: unified lock protections in amdgpu_dpm.c
Date: Thu, 31 Mar 2022 14:57:29 +1030
Message-Id: <20220331042729.3490-1-amarsh04@internode.on.net>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <DM6PR12MB2619B0D5271592A645F67845E4E19@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <DM6PR12MB2619B0D5271592A645F67845E4E19@DM6PR12MB2619.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 31 Mar 2022 07:47:38 +0000
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

Hi Evan, even with the patch below applied and built, I was still getting no
signal to the monitor upon loading of the amdgpu module and no response
from the pc except when giving the magic sysreq boot key sequence.

.config has:

CONFIG_DRM_AMDGPU=m
CONFIG_DRM_AMDGPU_SI=y
# CONFIG_DRM_AMDGPU_CIK is not set
# CONFIG_DRM_AMDGPU_USERPTR is not set

kernel command line has:

amdgpu.audio=1 amdgpu.si_support=1 radeon.si_support=0 page_owner=on amdgpu.gpu_recovery=1


diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
index 89fbee568be4..d7dc9c5b3df9 100644
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
 

Regards,

Arthur Marsh.
