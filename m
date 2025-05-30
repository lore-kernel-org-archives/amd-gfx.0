Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96451C54F30
	for <amd-gfx@archiver.kernel.org>; Fri, 30 May 2025 07:22:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1435C10E7D5;
	Fri, 30 May 2025 07:22:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="f36Fw+++";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2058.outbound.protection.outlook.com [40.107.243.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5083010E219
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 May 2025 07:22:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RgdUuamz0+Nq0ZQJGojSR5SOkeRYqorlYanb70hdivPQ/3VR/Lrp7Ujh5mpF3T1Yz2kCfUEf0wy7s/oQQfSy9WCZHYeiaRBSjEvt/J2VOzsRUvuIURskilQTN5dnnAu1x4wBV8Thb+PUAVNByMBnZSiBnQ+zy3yDukqMaH+yLUo5OKgyGQY+QPVAHImwPkxbaNr02kj8lu3ufa0iilQBy6VoBfGCIOHCOH6DKdSkZ/3nvScc2DqoC8rP6BL0ocMK6/z9XrtRi+SDuC/DFiYYn+eC8xe+bTGXtwUXKMkWencr4DQW69f3/T8ej+460Z5k4IcvyBUbtP+5t7gEfxEcFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WCafsmJNyli3xS/7/Cxz2YkT3DIJlC40iHIMI5vB7HA=;
 b=iC+YvH0lrWhoseUCm9rRcCS+3oPDGqPP6QKjEc+YVt2K6ubjupsyHUT80OBaSUbwzsJnEprzqzG3xSe73QgbPU2v/ix6TM4JX7WSpRcsVdZlmYyEwbBjG6m+xfeIexEUvlYsHGQuHI16j7wDGpRy6PKm2DeIq3q4HI2ApsRAvaYiiUPB0cu2QzqqNZW+v5ohJuRhPMUaKYHDOEqTn9IU+LIe33jnCc9sUdkvF1EgyKaE/0f11GWnzs50aqmaWWvyADoVnZnfIa2f9x+WxSoCgJjxOj+qgAcDZm5n+8CGbiH4sylia4PnWh+3BMlIXRl1KdMeeW/7EjjvHHNNwx6OxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WCafsmJNyli3xS/7/Cxz2YkT3DIJlC40iHIMI5vB7HA=;
 b=f36Fw+++r7+gbm/8+QISDPNNYJTN2r8DzI3p2GPvyNeRhcInreIQ4szGF1UOpqRhiEH8ELJUi2ku58XF9HlUfobzbZCAhVzz+c7rBQpyrZ9oxH59Qf4yrjlCHd2d+NF2wihNeJtrgH4mUbi65vTnVbqNdsaILWPjDurbioqr1tc=
Received: from DM4PR12MB5165.namprd12.prod.outlook.com (2603:10b6:5:394::9) by
 IA1PR12MB6186.namprd12.prod.outlook.com (2603:10b6:208:3e6::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8769.29; Fri, 30 May 2025 07:22:05 +0000
Received: from DM4PR12MB5165.namprd12.prod.outlook.com
 ([fe80::db2e:f082:bb80:d1a4]) by DM4PR12MB5165.namprd12.prod.outlook.com
 ([fe80::db2e:f082:bb80:d1a4%5]) with mapi id 15.20.8769.025; Fri, 30 May 2025
 07:22:05 +0000
From: "Feng, Kenneth" <Kenneth.Feng@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdgpu: disable workload profile switching when OD is
 enabled
Thread-Topic: [PATCH] drm/amdgpu: disable workload profile switching when OD
 is enabled
Thread-Index: AQHb0KSs7sSXxygToEqka65tn1dLILPqxZ8w
Date: Fri, 30 May 2025 07:22:05 +0000
Message-ID: <DM4PR12MB51651B8667F5FA5BE4FADEDD8E61A@DM4PR12MB5165.namprd12.prod.outlook.com>
References: <20250529141841.849654-1-alexander.deucher@amd.com>
In-Reply-To: <20250529141841.849654-1-alexander.deucher@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=0d47684d-1848-4864-8f60-a3a57a6ffde2;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-05-30T07:21:26Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5165:EE_|IA1PR12MB6186:EE_
x-ms-office365-filtering-correlation-id: d6ca2e42-f9a6-4c32-c41d-08dd9f4aae3e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?Vyq84b+p9NzfvyMvwVBWWXVxqlwQiAtCPQYkw2A9FmU+hXjyp4JbvllzGrSC?=
 =?us-ascii?Q?l6X/hPP4ZpyQeGctrokTEtnVFs5hBnK38V5Hap/of0osACdYAlIe5c69/Mtt?=
 =?us-ascii?Q?w4JtZQOMZDHDl5XDee6JoVY/7Oful5TuGdzNtPbugXHG6v5GqCE4pHUoU/sb?=
 =?us-ascii?Q?AihOEVojBK7gLxKIAfIyiOyRLbx0xcX3O9pKSET2Sznp19Ss4RHz++DLqLgJ?=
 =?us-ascii?Q?tVxCWGAierShZKJWqimmJsEKV4xFCywZkcM7NQloRkNZKdLZz3V5aZ33pZch?=
 =?us-ascii?Q?PxcFgP1ayq1QJLELehJO/jLqNkRF5ndgXf1qVVoR9mqN+7aMUGkMa/mUYFzc?=
 =?us-ascii?Q?Ce2GWhE8/Gdo62DKvPeR//6eIgoXW9qRz4PvEQVpObGN8abotVgCqlCPeWlM?=
 =?us-ascii?Q?LA1GWdrUpS43It11j6gxcDXhDTbvnLx38IW0mJW5QG1XxdAW0VpUXICyeupn?=
 =?us-ascii?Q?A5T7r+5o7ddM1DLEilkD+bfggxSM6e+1zyyqViNd7iqIBcYJXJhcCp1SlI8p?=
 =?us-ascii?Q?2zWYcHr7DMWCPubuxwWGIgS8hNgtSoPeBbA7Erx3woTPuXAxxOyBT2z6oDZ9?=
 =?us-ascii?Q?MOmrWIDQ2iLHY6MZILTVnkuIbz8ivqFgAfIkYRBLAGdOBC4HpV3P7C8VuTgQ?=
 =?us-ascii?Q?Z9WObC90siVdzFNxJKI3yqgmtKEcmGMCMfthUlRT8GcaKG2YzwP+Q/4PbtMD?=
 =?us-ascii?Q?Ahfu3UbVI4USKAiDL6Xw7yebCp/MQ/WIas3kBHEHzBurv/r1vtCXj8JwLq4B?=
 =?us-ascii?Q?ecJPaiNsZyZpEgFRXxbdrX+DeYvHZT+ODVtzW60gEMXQaUQHXgZIntOm1+sp?=
 =?us-ascii?Q?+dN5owzIhHaBa1HFtT3R0qxRm/g1SYEE/+sGi+2/lrqDI/Z2MUO0pO4guMXK?=
 =?us-ascii?Q?M0MBwp+/MQtgUI7F+j/j/L1FYrBfZ9IQQFiPY4bsLYKvv4hmqy6gNCuZCjUj?=
 =?us-ascii?Q?DPicYDG+1ZnVbNyD6Jm1+jgn7W92KXTSjPEu7DJ3qXPSr+5LSi0UfAsNX48l?=
 =?us-ascii?Q?iSJEKVEKLWHhiWbaCvhtTatG+pp2vRX93+SR8F9Exgopld3ctYdaolnpIT1U?=
 =?us-ascii?Q?HsophNaGxjWZo4Rysw+ZLTPTr/gXeHSJY+z6p2LJKgnoXI659x+xczvapmIY?=
 =?us-ascii?Q?pLZwhptvc8Bf4MUy0iWKuavloAE3F1gPQBP5DIxyLTAWrjjm3aPVYTObWJsl?=
 =?us-ascii?Q?psztFJYVxecJuY7n4auLu8mrGvB9P1swL0xI+9Ir4RQdLzRM0eFvQY8EFd2G?=
 =?us-ascii?Q?b0Zfp6PIbqvrQVKN7wwTSdrrUWUjPFCwIu9klKmblJzZSktrUcuJj8MUV6yH?=
 =?us-ascii?Q?syzzOm05J/+iNv7laJplOhYc0JtIRNhXrIxmD+GSxY/rEgHJY2r6Anv3WrA6?=
 =?us-ascii?Q?ovPr6LHtmWaUv9EOjOHYjXF5jfrNC/e9qB/FjBde3xCPR4dPQ5eToCMBaYwn?=
 =?us-ascii?Q?7WClXq+IXkE=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5165.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?6wBOTtRuhVkL4nPN/YWMV9DgN5tTrvdNlX0JW6kFbPH+bFEL6CdJjL5NMtZD?=
 =?us-ascii?Q?VBPqGhc9Z+27R2Ea8qkDZ0h2xkkJl/hdgiRVmPC7kYFc1h0z2sqh9vAzjKDM?=
 =?us-ascii?Q?MoostSGBBHygqY9ih0Z0LtfSntwfnZo8njhqd875uaRMBFABhKhP/bIEWz38?=
 =?us-ascii?Q?ueZdzwCfqDlNm/ByMac4nHBsKJwoE3Gki+xYUS3n4dbO5o3ocpZ0jRu4guNO?=
 =?us-ascii?Q?3NkEdbQtlvRLHp92SdVb6G77NA9dsOJoLsmMa76Kos9ZoBnSN+ujAI5CMmmb?=
 =?us-ascii?Q?+e88XQe9Z0qSxgJbvP2fEQs3G3j7k0ioJYlDRtW/wIaQKsYQH46htG3DIDQn?=
 =?us-ascii?Q?bh9lvUP4gMNLLyhVOLU7F1ybtYFt9FCtB/F1z/grtEnSHwKKvz00G1ToLGbG?=
 =?us-ascii?Q?DWBrq+nJ1sPESz22tB2PFOsWw459p0GsLhOGz0E5sEtNUkEIvEAdVKWuRCLQ?=
 =?us-ascii?Q?1dpzjc8PUQGkdV4N05slaOkJOZ90Mz6Z0tH/468NLCCV2q7wp3HUk5LKfC8w?=
 =?us-ascii?Q?nhui6+SLPV2OfgbXETzRbhR4Y8uYCyPXPJZmGfzQUJLDdmO3zf02rciQG1yD?=
 =?us-ascii?Q?QusbHj2esXJ/Y24GTZWwTDdcTQqjZwQ//6vzw02G7evyaZRurr8ZVte2JbPY?=
 =?us-ascii?Q?fBXCVqRdN3839TfRV3XKa6Dp22E0rz1V9Y0fACU4zFJM6tsQ+IfxG8XDBb8m?=
 =?us-ascii?Q?G44A81TGqDMS6dkrLSUpIHOdwrFhzpeb0QKI462x1EqZNEB0G4DxkkEVZlTW?=
 =?us-ascii?Q?OVoOwlxT3esHya54ruySxi2gWq99owXA9BUzefw6j5cQXlgTzezx/bB8BOh/?=
 =?us-ascii?Q?tHX7E/3tTz/NMQ7cVcyKUOUyJL6yLEiELB7B6zTMO/AYKMZq83GFIXdbCCf4?=
 =?us-ascii?Q?CXT24LdOI6MXGkdVN7mK0yNG8rMan7MQzvDzEdAkUL1y03kU6a4lqtuvuDmQ?=
 =?us-ascii?Q?RQMxaZSIuOaimMerI8x7F2dfiLO7hraF6M3MpIN6EZGWa1Nu2X2aJvpjjUb5?=
 =?us-ascii?Q?X4pW+x0va4HXA3fKUlix3tekP1KYwoFTrfbOV6xh0wDjlHVmMFPerEcKZE0s?=
 =?us-ascii?Q?dZhRbNSReXFTivhvwYbBXk+DyE5nb4sVLZ/Hctxf5cWKcBk6Km0gq4fuWzlM?=
 =?us-ascii?Q?v7jgVjYEXos+Nvtlp6hyzLUHnsTdH0cZStwszksnWXK1SXZrq462LtPtvryb?=
 =?us-ascii?Q?Zf9bePClmhsMlD6zKtZ9qvNwfF9DSNvlX/jKYB6JOcJI/FhwecBCnQgt9fKL?=
 =?us-ascii?Q?Dn5kwia5MYPLxfp2szy+W35NdD+lToyY8QcvW/Pd5LmB842SVMteVMiKMV8I?=
 =?us-ascii?Q?j+Mhx9EEmCULV/ezjjnd2uxwsCSaDHqsYYu5a8jmDJF8FaNoHaerr4cDCjxJ?=
 =?us-ascii?Q?ppo4Ic8csfgKqr5etHKcCRavJXoL+6XSanocyUGb/64JSx2bXhW6hJqFxUKl?=
 =?us-ascii?Q?60SeF2ztQ6BcQd0cZlbBXaLRFIc40ZF+ArYStoJ7XutWnleyuR5wCzvtciQg?=
 =?us-ascii?Q?sdoPr5ffggQpBQ9irvHvdAnd3Xo/syjT8Levuaq50zyAlCgJfyfy9tlOL9nW?=
 =?us-ascii?Q?babg25/CwDpmyB8z3B0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5165.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6ca2e42-f9a6-4c32-c41d-08dd9f4aae3e
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 May 2025 07:22:05.5827 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wlV2IO8odV8FdLxU77ftOfF90cmPP4WlhFBnqEJkNQcRvgucSDIYw36yoduThXnD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6186
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

[AMD Official Use Only - AMD Internal Distribution Only]

Reviewed-by: Kenneth Feng <kenneth.feng@amd.com>


-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deu=
cher
Sent: Thursday, May 29, 2025 10:19 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: [PATCH] drm/amdgpu: disable workload profile switching when OD is =
enabled

Caution: This message originated from an External Source. Use proper cautio=
n when opening attachments, clicking links, or responding.


Users have reported that they have to reduce the level of undervolting to a=
cheive stability when dynamic workload profiles are enabled on GC 10.3.x. D=
isable dynamic workload profiles if the user has enabled OD.

Fixes: b9467983b774 ("drm/amdgpu: add dynamic workload profile switching fo=
r gfx10")
Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4262
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c |  8 ++++++++
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c     | 22 ++++++++++++++++++++++
 drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h |  1 +
 3 files changed, 31 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_gfx.c
index 1db1e6ec0184f..c5646af055abc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -2228,6 +2228,9 @@ void amdgpu_gfx_profile_ring_begin_use(struct amdgpu_=
ring *ring)
        enum PP_SMC_POWER_PROFILE profile;
        int r;

+       if (amdgpu_dpm_is_overdrive_enabled(adev))
+               return;
+
        if (adev->gfx.num_gfx_rings)
                profile =3D PP_SMC_POWER_PROFILE_FULLSCREEN3D;
        else
@@ -2258,6 +2261,11 @@ void amdgpu_gfx_profile_ring_begin_use(struct amdgpu=
_ring *ring)

 void amdgpu_gfx_profile_ring_end_use(struct amdgpu_ring *ring)  {
+       struct amdgpu_device *adev =3D ring->adev;
+
+       if (amdgpu_dpm_is_overdrive_enabled(adev))
+               return;
+
        atomic_dec(&ring->adev->gfx.total_submission_cnt);

        schedule_delayed_work(&ring->adev->gfx.idle_work, GFX_PROFILE_IDLE_=
TIMEOUT); diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/dr=
m/amd/pm/amdgpu_dpm.c
index b5477e02fe996..353f01c0d1000 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
@@ -1701,6 +1701,28 @@ int amdgpu_dpm_is_overdrive_supported(struct amdgpu_=
device *adev)
        }
 }

+int amdgpu_dpm_is_overdrive_enabled(struct amdgpu_device *adev) {
+       if (is_support_sw_smu(adev)) {
+               struct smu_context *smu =3D adev->powerplay.pp_handle;
+
+               return smu->od_enabled;
+       } else {
+               struct pp_hwmgr *hwmgr;
+
+               /*
+                * dpm on some legacy asics don't carry od_enabled member
+                * as its pp_handle is casted directly from adev.
+                */
+               if (amdgpu_dpm_is_legacy_dpm(adev))
+                       return false;
+
+               hwmgr =3D (struct pp_hwmgr *)adev->powerplay.pp_handle;
+
+               return hwmgr->od_enabled;
+       }
+}
+
 int amdgpu_dpm_set_pp_table(struct amdgpu_device *adev,
                            const char *buf,
                            size_t size) diff --git a/drivers/gpu/drm/amd/p=
m/inc/amdgpu_dpm.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
index b52162112fa68..9163962814ea8 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
@@ -563,6 +563,7 @@ int amdgpu_dpm_get_smu_prv_buf_details(struct amdgpu_de=
vice *adev,
                                       void **addr,
                                       size_t *size);  int amdgpu_dpm_is_ov=
erdrive_supported(struct amdgpu_device *adev);
+int amdgpu_dpm_is_overdrive_enabled(struct amdgpu_device *adev);
 int amdgpu_dpm_set_pp_table(struct amdgpu_device *adev,
                            const char *buf,
                            size_t size);
--
2.49.0

