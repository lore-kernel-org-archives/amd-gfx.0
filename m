Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B647C02194
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Feb 2025 08:38:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C7C2910E758;
	Wed,  5 Feb 2025 08:38:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qfmt+sMc";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2048.outbound.protection.outlook.com [40.107.94.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 848AC10E752
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Feb 2025 08:36:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dFGnbtu6wLAU9k0y8dUKznUioLUFAaDFoZB1dJ/G8n7+fKDy2jkd5NkwyQwJPYMrirvGStD7GbWiUF1o0MHpHQkpeU6Dki9YHbjkn0+QQbnYpZrOPk8/xsTJRfjl42/jGFu+487Z0Gk7F1GQqs8h3qL/2z7Ll9agIZuY8bqXX4QgOWR+SjpFwxkgtjXiqqdOqWp5Ue/vc1lLwRYuTCDwLLMDcpOQqKDQCFZEtM6AsIXCnwKuIDjUOWVvfFHPoF9YxJDohF5rbu8n4E4RlqFiMvtKvHi9eOtJLeVLq7fhe7F4k/zYKQQaohtp2rgQM1KmRULwd0K+aSzOvSTrbGUzYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mw4hnbP9RAboTY9VOhj8n6ysaBXnOdrti3waH8lEtkA=;
 b=Y5z9FGgMnioxBM9Hzt96SsHrFT4ZIVYYheihAme11Jglnos2C9xmMIi7k+cgv+3EAAnTm6TAFPHAdtEMI9JrQFm2alM6NPW6QR+4K7g3liVskn4ZbW8GqPcb0YOixwnLcqpf099HwHcMnkrq+ejsXbd2ibQYmW1/sTzEGlznOFSUfhTpme4V44Ze/rNVyEMjUdW0fge8UE2vOccgJzY7Arlh5OVSVW5xJeynhSMpoISRI8jbdKVh7LigPILL06TUvHWJuK5EKX/oOy7qHk6JKkrQ36xTp4eXKf91vkrRN557ySz025U20582bZYFtaHE/qFGhg7u4mUROG4AFEUERA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mw4hnbP9RAboTY9VOhj8n6ysaBXnOdrti3waH8lEtkA=;
 b=qfmt+sMcXyC2DseS9N+Bnhpjb2jNGVHknK90WR0aB6F5VKNL9YIkS+fkVBCrRGb/U/ePBQO0NLcLpwdmy+UuZi7R7pXvOeY2tg9L4RBu/HRPiGx1itG0EEatDYmzgotQsQVtxVmTXFcpHU4klDHunF8iYK0TMd+WWDBG4PNqo5k=
Received: from DS7PR12MB6071.namprd12.prod.outlook.com (2603:10b6:8:9d::11) by
 BL1PR12MB5729.namprd12.prod.outlook.com (2603:10b6:208:384::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.26; Wed, 5 Feb
 2025 08:36:48 +0000
Received: from DS7PR12MB6071.namprd12.prod.outlook.com
 ([fe80::be26:4c33:76bc:e1b]) by DS7PR12MB6071.namprd12.prod.outlook.com
 ([fe80::be26:4c33:76bc:e1b%7]) with mapi id 15.20.8398.025; Wed, 5 Feb 2025
 08:36:48 +0000
From: "Kamal, Asad" <Asad.Kamal@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Pelloux-Prayer, Pierre-Eric"
 <Pierre-eric.Pelloux-prayer@amd.com>, "Feng, Kenneth" <Kenneth.Feng@amd.com>, 
 "Limonciello, Mario" <Mario.Limonciello@amd.com>
Subject: RE: [PATCH 1/3] drm/amd/pm: Add APIs for device access checks
Thread-Topic: [PATCH 1/3] drm/amd/pm: Add APIs for device access checks
Thread-Index: AQHbds91Dkl5hq2+YUem5HZy5hyUM7M4ZIZg
Date: Wed, 5 Feb 2025 08:36:48 +0000
Message-ID: <DS7PR12MB60712FC852E06FCA0823F32F8EF72@DS7PR12MB6071.namprd12.prod.outlook.com>
References: <20250204063817.1865562-1-lijo.lazar@amd.com>
In-Reply-To: <20250204063817.1865562-1-lijo.lazar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=995d9587-17ad-4956-8fcf-d0b11912dab7;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-02-05T08:36:38Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6071:EE_|BL1PR12MB5729:EE_
x-ms-office365-filtering-correlation-id: 817c8d89-f87a-407d-3d10-08dd45c03b0d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?V+ZZ4IOAJzc5Pe+AY76IuUPy6KPYoL2T3s4gNrJ9nJXZcO1IdT2gjUl4gjyw?=
 =?us-ascii?Q?s6wuZaKT2ZoyxgY/1FJszh6CqVzFw8MQWsy4qN3tEafuNPWfQoHE981a7s5M?=
 =?us-ascii?Q?LIKPmN8gE/yqV49/XGS4uSIgldvr/EGUSgDLS4g9lX4gMlt4zQpx2f1Q9Cne?=
 =?us-ascii?Q?46+hZUSVlswE/U5nJ7jiYhs4lXbCyIapIKgsGKHtFrOJglCNKCPx8i8eA71f?=
 =?us-ascii?Q?RjmfiZ9vtYgpAdJ2niwVTlzV61Rd731BQp8Dvz+lnvK3zNBOE8wb5kSS8Uqu?=
 =?us-ascii?Q?LMpDQQHYrnzb7ysKJYGjepyPUe/ibnu9xhREbFJqDRi7QtFmVsiT6INEV67h?=
 =?us-ascii?Q?Z++6JtvZCH6hWZatX+QzoA/PlcWfYU7lscWoycDqognWBb9cmPrOVYZ4NXG0?=
 =?us-ascii?Q?ctksy97YaMUPcJuaIHd9Y4QLjUL+Z2RJhcCdoMWtWFFp/ZVMA9jKTU9JaVJ7?=
 =?us-ascii?Q?U4EnHtUwcaK8qIJjuOTYwvB4tu3Ky9fXrKIIKC81J/KiDYhsE7uvngTqcLcp?=
 =?us-ascii?Q?iA91HbHETdm2AAU+yT099zX0+WWt+O7qElVptlRNGLN5RT1l7hatCYRY+b36?=
 =?us-ascii?Q?r5FeDPB63/V7UnK/eqjQULVA/RMRuBCRnwzjhwRpvIPdPe8UH79WnyX9iDw7?=
 =?us-ascii?Q?opAZXYsOiNxKT+liXEPA6YjQB6Ym5V07NZoG+HcbEFmkXAGvrPR/tUQ62/hj?=
 =?us-ascii?Q?zBDEWIePncywsme9nkF+vyZxBRv939eiZkU2PM82XNCfEB38dlh2I0hgYgjl?=
 =?us-ascii?Q?pJQfMB3PIIxo3huAID6G0ri/xvFAmOTCrHcijC57rUvZc9j0LmnGPUChir+7?=
 =?us-ascii?Q?csceU7+qhhGe/fAr9nfUZFGrdDU/X2HyDPFeE8ILp6sW5F6ru1Eyuorg8fnE?=
 =?us-ascii?Q?Gv299uBq2RsZSb01NWOMsU0+gJHkmw5jtbU0FvosGO3EZgycgHMSWBiXDtm2?=
 =?us-ascii?Q?5i8ZtwF7Ksi6Vya+lR/VxylSzv0W+TAeW9x9Z3w4vMq7a1YcmIhMLYxwTM3f?=
 =?us-ascii?Q?xv07lEv62CTpSE/F66PpIVlFkZ5trMaymuVl77oNBDxWMjfAD6amum3QlDEe?=
 =?us-ascii?Q?oKMusCmTnjbsVJjV8uh2p6uwRKpWWBqR+F2j2qFRWywasgMSZkJyDdQ/6Dp+?=
 =?us-ascii?Q?4Lq3U2/7VMVP5JFDR2uXZi2DxfSQ2YotEly1OpedqKQFNFXHfOc1lZ/AdQYa?=
 =?us-ascii?Q?gkmnudRUyX+n+RT9Sk9QkJrV9qMp8Uv01/VnL+ylOFbkW8zsNZ7azaAdsZ8q?=
 =?us-ascii?Q?xy1QQMf5zUPROdwdIDhaGbcF8DnXstucU3HS7cUg8RyzM6ZNOBUWZrlYNN3Y?=
 =?us-ascii?Q?eOP8baCFwPdmvTgJh1Cee1BzpmBFFHfXRuZ2FUnDR7cChqQSYxx9f/LitrsV?=
 =?us-ascii?Q?v5sj+hL6Xm5uVWG5EUa2ED3tDe7qP/YdnfRgd2Vk4SWaJGulhVZzrQ/kDlLR?=
 =?us-ascii?Q?OHOQ4zfaFvzm7ztjR0LSKpFjFKfhQEJp?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6071.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Aj3TiNLcSODrSjC+hoCz5/GNqXD38sfonD2uGXNXnSEeMkId90OVGYtl6hSK?=
 =?us-ascii?Q?/XV5gh0ISQNRqVoSHVB9L7IMG0FHcjsKJQ2dYUEXZxWGMMWJzORYyhJW4Q/l?=
 =?us-ascii?Q?VtHaudqFEYyV/2JTDXezrSWIgBR4RXPwdwIjN4f7z0XMU0T1fvRt4JxDE+wu?=
 =?us-ascii?Q?jix/8ZqCTd/oEx9KlNbU3iYB1a4deZdQFaBtuMLoZ7K7MqK4g5qxaweSWa+c?=
 =?us-ascii?Q?pcqE3G0Bs+3AZ3U8KTb+C2CiL7DHWa0K/5TQoe9Bz9nqRryOUf677Yu7OUl7?=
 =?us-ascii?Q?AT0NB8flvLJuAwRjllAhhpiaTmUy8z3tW0ClifqbOpl1U9/11vCsAfvyVmpu?=
 =?us-ascii?Q?cbe3GB7mxXBOmys/BPjU24WL0CchfeNLHygOULMKdr7QOXay6Q7mtr0LwOvg?=
 =?us-ascii?Q?OpEg8ElrxD22Z0YpkCdGRwb0Z18uXitvXTiUTWdW4XWmc9VDhF8HHG3aaTcn?=
 =?us-ascii?Q?Q350CexUTPlK/rpI0Mk7TSDDK9VRWDxBeQdrD7RQXvFhQtLQBo1XTI9lcLrz?=
 =?us-ascii?Q?6guDBGtoQQ7PFieWP1u52b8inJ8K0l/WV8MB7XZfgZRBsymV9kS/rnW5ZyY8?=
 =?us-ascii?Q?B6oIYD7PQCPuQCluhvNJxh8gwP9stsGJZXv5dQIHY1NOsUM5OyH/ZO2LCdN+?=
 =?us-ascii?Q?lx2OCGmRy6RcHD0/PT7nD4BFDdjmfn1elSBp3vt8/Pa/qb3ehCe2mmrRaNWo?=
 =?us-ascii?Q?dtFUSHP33bqC9ttqfFuquV8e1PvgOn+NW2SYqZOPQm3NfUfEejZS77vST9Qp?=
 =?us-ascii?Q?MvHpExe6+EI8pDdImRAWpF0zBMk6cmgA4L9BMYNaf8nkd9HNzJK4hseHIlhS?=
 =?us-ascii?Q?/MKA8MjPNtCRa3Ujl/gu9mLyYg2duKjMo2ItTBWE+fdBWQm3g3j3j7WRP/WP?=
 =?us-ascii?Q?H1+2jrtLK8K1JZBr9Tdmnf8+AQ1Rdkj48+PSSjz31ksAGFKdAZo+rQX6Jey8?=
 =?us-ascii?Q?V43fzoDtFRoMqlaD4enXhsIgF+DmTUMOrS1kMJnanQlrT4nJJJ/DgT93LWnd?=
 =?us-ascii?Q?VhNhqxDNAxHAEP/JzfhYR3ZWRnKuiQiqfnR7BGdziDNiH+MX8B3rpAYsKROL?=
 =?us-ascii?Q?vtT5LGf9/geWViTy05h4IZ/Rrt6fO5YbnclbtBHnmrzd9w356AMUrftlVJY4?=
 =?us-ascii?Q?wzw6bSTS3psJRop7x/+s4Ykl3D2TJGQ+WQxULCscxF/UCHBhpJt28ebNDok8?=
 =?us-ascii?Q?kxK0sBhih1sBG7qN9cvYqIGL+cyJ8GIWUAJ4EfteH2OQVAblzxjm4kyGdGDb?=
 =?us-ascii?Q?q3jyyCLM4XJcv/nzfU7xSvX7T0WBALgETNDbFRuAsxOd1twavmhldcnLB/0e?=
 =?us-ascii?Q?L0jFI/25Nx0FYv1vzefyDju2hGtrK3VqPMdxmL4P8h02TovEABpy/F5c/JwV?=
 =?us-ascii?Q?IAjUAOpCAMCDekOxD4us286PeaLJZycOWzDxc6EXpAC5XfoOeo2AgMz3HpvL?=
 =?us-ascii?Q?B5ioqay3K7FuLKqqkWqUlamI99CiLaAjaRuY5Mkn0HiQIZR1vhnlH6EUK8TN?=
 =?us-ascii?Q?s0Ym0EWtvZh4BsQ/qujG6YlQN9d0+oBf/5Z6m20eKkh3NlWVuO6C3wJZ4CBO?=
 =?us-ascii?Q?I0WRcvs+b88nxC98SWE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6071.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 817c8d89-f87a-407d-3d10-08dd45c03b0d
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Feb 2025 08:36:48.2748 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FZ7E43ZAP2yvpJNmrnoMFke2w2dWRMUT2RtOYaQAfEfqYD0952FztxJI6Q2LyYaDb+lf7/FXKnlFcnKV61uTHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5729
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

Series is

Reviewed-by: Asad Kamal <asad.kamal@amd.com>

Thanks & Regards
Asad


-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Lijo Laz=
ar
Sent: Tuesday, February 4, 2025 12:08 PM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>; Pelloux-Prayer, Pierre-Eric <Pierre-eric.Pelloux-prayer@am=
d.com>; Feng, Kenneth <Kenneth.Feng@amd.com>; Limonciello, Mario <Mario.Lim=
onciello@amd.com>
Subject: [PATCH 1/3] drm/amd/pm: Add APIs for device access checks

Wrap the checks before device access in helper functions and use them for d=
evice access. The generic order of APIs now is to do input argument validat=
ion first and check if device access is allowed.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c | 616 +++++++++++------------------
 1 file changed, 229 insertions(+), 387 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/am=
dgpu_pm.c
index 0aca0803514e..0fe0b798f559 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -97,6 +97,77 @@ const char * const amdgpu_pp_profile_name[] =3D {
        "UNCAPPED",
 };

+/**
+ * amdgpu_pm_dev_state_check - Check if device can be accessed.
+ * @adev: Target device.
+ *
+ * Checks the state of the @adev for access. Return 0 if the device is
+ * accessible or a negative error code otherwise.
+ */
+static int amdgpu_pm_dev_state_check(struct amdgpu_device *adev) {
+       if (amdgpu_in_reset(adev))
+               return -EPERM;
+       if (adev->in_suspend && !adev->in_runpm)
+               return -EPERM;
+
+       return 0;
+}
+
+/**
+ * amdgpu_pm_get_access - Check if device can be accessed, resume if neede=
d.
+ * @adev: Target device.
+ *
+ * Checks the state of the @adev for access. Use runtime pm API to
+resume if
+ * needed. Return 0 if the device is accessible or a negative error
+code
+ * otherwise.
+ */
+static int amdgpu_pm_get_access(struct amdgpu_device *adev) {
+       int ret;
+
+       ret =3D amdgpu_pm_dev_state_check(adev);
+       if (ret)
+               return ret;
+
+       return pm_runtime_resume_and_get(adev->dev);
+}
+
+/**
+ * amdgpu_pm_get_access_if_active - Check if device is active for access.
+ * @adev: Target device.
+ *
+ * Checks the state of the @adev for access. Use runtime pm API to
+determine
+ * if device is active. Allow access only if device is active.Return 0
+if the
+ * device is accessible or a negative error code otherwise.
+ */
+static int amdgpu_pm_get_access_if_active(struct amdgpu_device *adev) {
+       int ret;
+
+       ret =3D amdgpu_pm_dev_state_check(adev);
+       if (ret)
+               return ret;
+
+       ret =3D pm_runtime_get_if_active(adev->dev);
+       if (ret <=3D 0)
+               return ret ?: -EPERM;
+
+       return 0;
+}
+
+/**
+ * amdgpu_pm_put_access - Put to auto suspend mode after a device access.
+ * @adev: Target device.
+ *
+ * Should be paired with amdgpu_pm_get_access* calls  */ static inline
+void amdgpu_pm_put_access(struct amdgpu_device *adev) {
+       pm_runtime_mark_last_busy(adev->dev);
+       pm_runtime_put_autosuspend(adev->dev);
+}
+
 /**
  * DOC: power_dpm_state
  *
@@ -140,18 +211,13 @@ static ssize_t amdgpu_get_power_dpm_state(struct devi=
ce *dev,
        enum amd_pm_state_type pm;
        int ret;

-       if (amdgpu_in_reset(adev))
-               return -EPERM;
-       if (adev->in_suspend && !adev->in_runpm)
-               return -EPERM;
-
-       ret =3D pm_runtime_get_if_active(ddev->dev);
-       if (ret <=3D 0)
-               return ret ?: -EPERM;
+       ret =3D amdgpu_pm_get_access_if_active(adev);
+       if (ret)
+               return ret;

        amdgpu_dpm_get_current_power_state(adev, &pm);

-       pm_runtime_put_autosuspend(ddev->dev);
+       amdgpu_pm_put_access(adev);

        return sysfs_emit(buf, "%s\n",
                          (pm =3D=3D POWER_STATE_TYPE_BATTERY) ? "battery" =
:
@@ -168,11 +234,6 @@ static ssize_t amdgpu_set_power_dpm_state(struct devic=
e *dev,
        enum amd_pm_state_type  state;
        int ret;

-       if (amdgpu_in_reset(adev))
-               return -EPERM;
-       if (adev->in_suspend && !adev->in_runpm)
-               return -EPERM;
-
        if (strncmp("battery", buf, strlen("battery")) =3D=3D 0)
                state =3D POWER_STATE_TYPE_BATTERY;
        else if (strncmp("balanced", buf, strlen("balanced")) =3D=3D 0) @@ =
-182,14 +243,13 @@ static ssize_t amdgpu_set_power_dpm_state(struct device =
*dev,
        else
                return -EINVAL;

-       ret =3D pm_runtime_resume_and_get(ddev->dev);
+       ret =3D amdgpu_pm_get_access(adev);
        if (ret < 0)
                return ret;

        amdgpu_dpm_set_power_state(adev, state);

-       pm_runtime_mark_last_busy(ddev->dev);
-       pm_runtime_put_autosuspend(ddev->dev);
+       amdgpu_pm_put_access(adev);

        return count;
 }
@@ -263,18 +323,13 @@ static ssize_t amdgpu_get_power_dpm_force_performance=
_level(struct device *dev,
        enum amd_dpm_forced_level level =3D 0xff;
        int ret;

-       if (amdgpu_in_reset(adev))
-               return -EPERM;
-       if (adev->in_suspend && !adev->in_runpm)
-               return -EPERM;
-
-       ret =3D pm_runtime_get_if_active(ddev->dev);
-       if (ret <=3D 0)
-               return ret ?: -EPERM;
+       ret =3D amdgpu_pm_get_access_if_active(adev);
+       if (ret)
+               return ret;

        level =3D amdgpu_dpm_get_performance_level(adev);

-       pm_runtime_put_autosuspend(ddev->dev);
+       amdgpu_pm_put_access(adev);

        return sysfs_emit(buf, "%s\n",
                          (level =3D=3D AMD_DPM_FORCED_LEVEL_AUTO) ? "auto"=
 :
@@ -299,11 +354,6 @@ static ssize_t amdgpu_set_power_dpm_force_performance_=
level(struct device *dev,
        enum amd_dpm_forced_level level;
        int ret =3D 0;

-       if (amdgpu_in_reset(adev))
-               return -EPERM;
-       if (adev->in_suspend && !adev->in_runpm)
-               return -EPERM;
-
        if (strncmp("low", buf, strlen("low")) =3D=3D 0) {
                level =3D AMD_DPM_FORCED_LEVEL_LOW;
        } else if (strncmp("high", buf, strlen("high")) =3D=3D 0) { @@ -328=
,14 +378,13 @@ static ssize_t amdgpu_set_power_dpm_force_performance_level(=
struct device *dev,
                return -EINVAL;
        }

-       ret =3D pm_runtime_resume_and_get(ddev->dev);
+       ret =3D amdgpu_pm_get_access(adev);
        if (ret < 0)
                return ret;

        mutex_lock(&adev->pm.stable_pstate_ctx_lock);
        if (amdgpu_dpm_force_performance_level(adev, level)) {
-               pm_runtime_mark_last_busy(ddev->dev);
-               pm_runtime_put_autosuspend(ddev->dev);
+               amdgpu_pm_put_access(adev);
                mutex_unlock(&adev->pm.stable_pstate_ctx_lock);
                return -EINVAL;
        }
@@ -343,8 +392,7 @@ static ssize_t amdgpu_set_power_dpm_force_performance_l=
evel(struct device *dev,
        adev->pm.stable_pstate_ctx =3D NULL;
        mutex_unlock(&adev->pm.stable_pstate_ctx_lock);

-       pm_runtime_mark_last_busy(ddev->dev);
-       pm_runtime_put_autosuspend(ddev->dev);
+       amdgpu_pm_put_access(adev);

        return count;
 }
@@ -359,19 +407,14 @@ static ssize_t amdgpu_get_pp_num_states(struct device=
 *dev,
        uint32_t i;
        int buf_len, ret;

-       if (amdgpu_in_reset(adev))
-               return -EPERM;
-       if (adev->in_suspend && !adev->in_runpm)
-               return -EPERM;
-
-       ret =3D pm_runtime_get_if_active(ddev->dev);
-       if (ret <=3D 0)
-               return ret ?: -EPERM;
+       ret =3D amdgpu_pm_get_access_if_active(adev);
+       if (ret)
+               return ret;

        if (amdgpu_dpm_get_pp_num_states(adev, &data))
                memset(&data, 0, sizeof(data));

-       pm_runtime_put_autosuspend(ddev->dev);
+       amdgpu_pm_put_access(adev);

        buf_len =3D sysfs_emit(buf, "states: %d\n", data.nums);
        for (i =3D 0; i < data.nums; i++)
@@ -394,20 +437,15 @@ static ssize_t amdgpu_get_pp_cur_state(struct device =
*dev,
        enum amd_pm_state_type pm =3D 0;
        int i =3D 0, ret =3D 0;

-       if (amdgpu_in_reset(adev))
-               return -EPERM;
-       if (adev->in_suspend && !adev->in_runpm)
-               return -EPERM;
-
-       ret =3D pm_runtime_get_if_active(ddev->dev);
-       if (ret <=3D 0)
-               return ret ?: -EPERM;
+       ret =3D amdgpu_pm_get_access_if_active(adev);
+       if (ret)
+               return ret;

        amdgpu_dpm_get_current_power_state(adev, &pm);

        ret =3D amdgpu_dpm_get_pp_num_states(adev, &data);

-       pm_runtime_put_autosuspend(ddev->dev);
+       amdgpu_pm_put_access(adev);

        if (ret)
                return ret;
@@ -429,11 +467,11 @@ static ssize_t amdgpu_get_pp_force_state(struct devic=
e *dev,  {
        struct drm_device *ddev =3D dev_get_drvdata(dev);
        struct amdgpu_device *adev =3D drm_to_adev(ddev);
+       int ret;

-       if (amdgpu_in_reset(adev))
-               return -EPERM;
-       if (adev->in_suspend && !adev->in_runpm)
-               return -EPERM;
+       ret =3D amdgpu_pm_dev_state_check(adev);
+       if (ret)
+               return ret;

        if (adev->pm.pp_force_state_enabled)
                return amdgpu_get_pp_cur_state(dev, attr, buf); @@ -453,11 =
+491,6 @@ static ssize_t amdgpu_set_pp_force_state(struct device *dev,
        unsigned long idx;
        int ret;

-       if (amdgpu_in_reset(adev))
-               return -EPERM;
-       if (adev->in_suspend && !adev->in_runpm)
-               return -EPERM;
-
        adev->pm.pp_force_state_enabled =3D false;

        if (strlen(buf) =3D=3D 1)
@@ -469,7 +502,7 @@ static ssize_t amdgpu_set_pp_force_state(struct device =
*dev,

        idx =3D array_index_nospec(idx, ARRAY_SIZE(data.states));

-       ret =3D pm_runtime_resume_and_get(ddev->dev);
+       ret =3D amdgpu_pm_get_access(adev);
        if (ret < 0)
                return ret;

@@ -490,14 +523,13 @@ static ssize_t amdgpu_set_pp_force_state(struct devic=
e *dev,
                adev->pm.pp_force_state_enabled =3D true;
        }

-       pm_runtime_mark_last_busy(ddev->dev);
-       pm_runtime_put_autosuspend(ddev->dev);
+       amdgpu_pm_put_access(adev);

        return count;

 err_out:
-       pm_runtime_mark_last_busy(ddev->dev);
-       pm_runtime_put_autosuspend(ddev->dev);
+       amdgpu_pm_put_access(adev);
+
        return ret;
 }

@@ -521,18 +553,13 @@ static ssize_t amdgpu_get_pp_table(struct device *dev=
,
        char *table =3D NULL;
        int size, ret;

-       if (amdgpu_in_reset(adev))
-               return -EPERM;
-       if (adev->in_suspend && !adev->in_runpm)
-               return -EPERM;
-
-       ret =3D pm_runtime_get_if_active(ddev->dev);
-       if (ret <=3D 0)
-               return ret ?: -EPERM;
+       ret =3D amdgpu_pm_get_access_if_active(adev);
+       if (ret)
+               return ret;

        size =3D amdgpu_dpm_get_pp_table(adev, &table);

-       pm_runtime_put_autosuspend(ddev->dev);
+       amdgpu_pm_put_access(adev);

        if (size <=3D 0)
                return size;
@@ -554,19 +581,13 @@ static ssize_t amdgpu_set_pp_table(struct device *dev=
,
        struct amdgpu_device *adev =3D drm_to_adev(ddev);
        int ret =3D 0;

-       if (amdgpu_in_reset(adev))
-               return -EPERM;
-       if (adev->in_suspend && !adev->in_runpm)
-               return -EPERM;
-
-       ret =3D pm_runtime_resume_and_get(ddev->dev);
+       ret =3D amdgpu_pm_get_access(adev);
        if (ret < 0)
                return ret;

        ret =3D amdgpu_dpm_set_pp_table(adev, buf, count);

-       pm_runtime_mark_last_busy(ddev->dev);
-       pm_runtime_put_autosuspend(ddev->dev);
+       amdgpu_pm_put_access(adev);

        if (ret)
                return ret;
@@ -735,11 +756,6 @@ static ssize_t amdgpu_set_pp_od_clk_voltage(struct dev=
ice *dev,
        const char delimiter[3] =3D {' ', '\n', '\0'};
        uint32_t type;

-       if (amdgpu_in_reset(adev))
-               return -EPERM;
-       if (adev->in_suspend && !adev->in_runpm)
-               return -EPERM;
-
        if (count > 127 || count =3D=3D 0)
                return -EINVAL;

@@ -785,7 +801,7 @@ static ssize_t amdgpu_set_pp_od_clk_voltage(struct devi=
ce *dev,
                        tmp_str++;
        }

-       ret =3D pm_runtime_resume_and_get(ddev->dev);
+       ret =3D amdgpu_pm_get_access(adev);
        if (ret < 0)
                return ret;

@@ -806,14 +822,13 @@ static ssize_t amdgpu_set_pp_od_clk_voltage(struct de=
vice *dev,
                        goto err_out;
        }

-       pm_runtime_mark_last_busy(ddev->dev);
-       pm_runtime_put_autosuspend(ddev->dev);
+       amdgpu_pm_put_access(adev);

        return count;

 err_out:
-       pm_runtime_mark_last_busy(ddev->dev);
-       pm_runtime_put_autosuspend(ddev->dev);
+       amdgpu_pm_put_access(adev);
+
        return -EINVAL;
 }

@@ -835,14 +850,9 @@ static ssize_t amdgpu_get_pp_od_clk_voltage(struct dev=
ice *dev,
        };
        uint clk_index;

-       if (amdgpu_in_reset(adev))
-               return -EPERM;
-       if (adev->in_suspend && !adev->in_runpm)
-               return -EPERM;
-
-       ret =3D pm_runtime_get_if_active(ddev->dev);
-       if (ret <=3D 0)
-               return ret ?: -EPERM;
+       ret =3D amdgpu_pm_get_access_if_active(adev);
+       if (ret)
+               return ret;

        for (clk_index =3D 0 ; clk_index < 6 ; clk_index++) {
                ret =3D amdgpu_dpm_emit_clock_levels(adev, od_clocks[clk_in=
dex], buf, &size); @@ -861,7 +871,7 @@ static ssize_t amdgpu_get_pp_od_clk_=
voltage(struct device *dev,
        if (size =3D=3D 0)
                size =3D sysfs_emit(buf, "\n");

-       pm_runtime_put_autosuspend(ddev->dev);
+       amdgpu_pm_put_access(adev);

        return size;
 }
@@ -892,23 +902,17 @@ static ssize_t amdgpu_set_pp_features(struct device *=
dev,
        uint64_t featuremask;
        int ret;

-       if (amdgpu_in_reset(adev))
-               return -EPERM;
-       if (adev->in_suspend && !adev->in_runpm)
-               return -EPERM;
-
        ret =3D kstrtou64(buf, 0, &featuremask);
        if (ret)
                return -EINVAL;

-       ret =3D pm_runtime_resume_and_get(ddev->dev);
+       ret =3D amdgpu_pm_get_access(adev);
        if (ret < 0)
                return ret;

        ret =3D amdgpu_dpm_set_ppfeature_status(adev, featuremask);

-       pm_runtime_mark_last_busy(ddev->dev);
-       pm_runtime_put_autosuspend(ddev->dev);
+       amdgpu_pm_put_access(adev);

        if (ret)
                return -EINVAL;
@@ -925,20 +929,15 @@ static ssize_t amdgpu_get_pp_features(struct device *=
dev,
        ssize_t size;
        int ret;

-       if (amdgpu_in_reset(adev))
-               return -EPERM;
-       if (adev->in_suspend && !adev->in_runpm)
-               return -EPERM;
-
-       ret =3D pm_runtime_get_if_active(ddev->dev);
-       if (ret <=3D 0)
-               return ret ?: -EPERM;
+       ret =3D amdgpu_pm_get_access_if_active(adev);
+       if (ret)
+               return ret;

        size =3D amdgpu_dpm_get_ppfeature_status(adev, buf);
        if (size <=3D 0)
                size =3D sysfs_emit(buf, "\n");

-       pm_runtime_put_autosuspend(ddev->dev);
+       amdgpu_pm_put_access(adev);

        return size;
 }
@@ -991,14 +990,9 @@ static ssize_t amdgpu_get_pp_dpm_clock(struct device *=
dev,
        int size =3D 0;
        int ret =3D 0;

-       if (amdgpu_in_reset(adev))
-               return -EPERM;
-       if (adev->in_suspend && !adev->in_runpm)
-               return -EPERM;
-
-       ret =3D pm_runtime_get_if_active(ddev->dev);
-       if (ret <=3D 0)
-               return ret ?: -EPERM;
+       ret =3D amdgpu_pm_get_access_if_active(adev);
+       if (ret)
+               return ret;

        ret =3D amdgpu_dpm_emit_clock_levels(adev, type, buf, &size);
        if (ret =3D=3D -ENOENT)
@@ -1007,7 +1001,7 @@ static ssize_t amdgpu_get_pp_dpm_clock(struct device =
*dev,
        if (size =3D=3D 0)
                size =3D sysfs_emit(buf, "\n");

-       pm_runtime_put_autosuspend(ddev->dev);
+       amdgpu_pm_put_access(adev);

        return size;
 }
@@ -1057,23 +1051,17 @@ static ssize_t amdgpu_set_pp_dpm_clock(struct devic=
e *dev,
        int ret;
        uint32_t mask =3D 0;

-       if (amdgpu_in_reset(adev))
-               return -EPERM;
-       if (adev->in_suspend && !adev->in_runpm)
-               return -EPERM;
-
        ret =3D amdgpu_read_mask(buf, count, &mask);
        if (ret)
                return ret;

-       ret =3D pm_runtime_resume_and_get(ddev->dev);
+       ret =3D amdgpu_pm_get_access(adev);
        if (ret < 0)
                return ret;

        ret =3D amdgpu_dpm_force_clock_level(adev, type, mask);

-       pm_runtime_mark_last_busy(ddev->dev);
-       pm_runtime_put_autosuspend(ddev->dev);
+       amdgpu_pm_put_access(adev);

        if (ret)
                return -EINVAL;
@@ -1240,18 +1228,13 @@ static ssize_t amdgpu_get_pp_sclk_od(struct device =
*dev,
        uint32_t value =3D 0;
        int ret;

-       if (amdgpu_in_reset(adev))
-               return -EPERM;
-       if (adev->in_suspend && !adev->in_runpm)
-               return -EPERM;
-
-       ret =3D pm_runtime_get_if_active(ddev->dev);
-       if (ret <=3D 0)
-               return ret ?: -EPERM;
+       ret =3D amdgpu_pm_get_access_if_active(adev);
+       if (ret)
+               return ret;

        value =3D amdgpu_dpm_get_sclk_od(adev);

-       pm_runtime_put_autosuspend(ddev->dev);
+       amdgpu_pm_put_access(adev);

        return sysfs_emit(buf, "%d\n", value);  } @@ -1266,24 +1249,18 @@ s=
tatic ssize_t amdgpu_set_pp_sclk_od(struct device *dev,
        int ret;
        long int value;

-       if (amdgpu_in_reset(adev))
-               return -EPERM;
-       if (adev->in_suspend && !adev->in_runpm)
-               return -EPERM;
-
        ret =3D kstrtol(buf, 0, &value);

        if (ret)
                return -EINVAL;

-       ret =3D pm_runtime_resume_and_get(ddev->dev);
+       ret =3D amdgpu_pm_get_access(adev);
        if (ret < 0)
                return ret;

        amdgpu_dpm_set_sclk_od(adev, (uint32_t)value);

-       pm_runtime_mark_last_busy(ddev->dev);
-       pm_runtime_put_autosuspend(ddev->dev);
+       amdgpu_pm_put_access(adev);

        return count;
 }
@@ -1297,18 +1274,13 @@ static ssize_t amdgpu_get_pp_mclk_od(struct device =
*dev,
        uint32_t value =3D 0;
        int ret;

-       if (amdgpu_in_reset(adev))
-               return -EPERM;
-       if (adev->in_suspend && !adev->in_runpm)
-               return -EPERM;
-
-       ret =3D pm_runtime_get_if_active(ddev->dev);
-       if (ret <=3D 0)
-               return ret ?: -EPERM;
+       ret =3D amdgpu_pm_get_access_if_active(adev);
+       if (ret)
+               return ret;

        value =3D amdgpu_dpm_get_mclk_od(adev);

-       pm_runtime_put_autosuspend(ddev->dev);
+       amdgpu_pm_put_access(adev);

        return sysfs_emit(buf, "%d\n", value);  } @@ -1323,24 +1295,18 @@ s=
tatic ssize_t amdgpu_set_pp_mclk_od(struct device *dev,
        int ret;
        long int value;

-       if (amdgpu_in_reset(adev))
-               return -EPERM;
-       if (adev->in_suspend && !adev->in_runpm)
-               return -EPERM;
-
        ret =3D kstrtol(buf, 0, &value);

        if (ret)
                return -EINVAL;

-       ret =3D pm_runtime_resume_and_get(ddev->dev);
+       ret =3D amdgpu_pm_get_access(adev);
        if (ret < 0)
                return ret;

        amdgpu_dpm_set_mclk_od(adev, (uint32_t)value);

-       pm_runtime_mark_last_busy(ddev->dev);
-       pm_runtime_put_autosuspend(ddev->dev);
+       amdgpu_pm_put_access(adev);

        return count;
 }
@@ -1378,20 +1344,15 @@ static ssize_t amdgpu_get_pp_power_profile_mode(str=
uct device *dev,
        ssize_t size;
        int ret;

-       if (amdgpu_in_reset(adev))
-               return -EPERM;
-       if (adev->in_suspend && !adev->in_runpm)
-               return -EPERM;
-
-       ret =3D pm_runtime_get_if_active(ddev->dev);
-       if (ret <=3D 0)
-               return ret ?: -EPERM;
+       ret =3D amdgpu_pm_get_access_if_active(adev);
+       if (ret)
+               return ret;

        size =3D amdgpu_dpm_get_power_profile_mode(adev, buf);
        if (size <=3D 0)
                size =3D sysfs_emit(buf, "\n");

-       pm_runtime_put_autosuspend(ddev->dev);
+       amdgpu_pm_put_access(adev);

        return size;
 }
@@ -1414,11 +1375,6 @@ static ssize_t amdgpu_set_pp_power_profile_mode(stru=
ct device *dev,
        long int profile_mode =3D 0;
        const char delimiter[3] =3D {' ', '\n', '\0'};

-       if (amdgpu_in_reset(adev))
-               return -EPERM;
-       if (adev->in_suspend && !adev->in_runpm)
-               return -EPERM;
-
        tmp[0] =3D *(buf);
        tmp[1] =3D '\0';
        ret =3D kstrtol(tmp, 0, &profile_mode);
@@ -1445,14 +1401,13 @@ static ssize_t amdgpu_set_pp_power_profile_mode(str=
uct device *dev,
        }
        parameter[parameter_size] =3D profile_mode;

-       ret =3D pm_runtime_resume_and_get(ddev->dev);
+       ret =3D amdgpu_pm_get_access(adev);
        if (ret < 0)
                return ret;

        ret =3D amdgpu_dpm_set_power_profile_mode(adev, parameter, paramete=
r_size);

-       pm_runtime_mark_last_busy(ddev->dev);
-       pm_runtime_put_autosuspend(ddev->dev);
+       amdgpu_pm_put_access(adev);

        if (!ret)
                return count;
@@ -1466,19 +1421,14 @@ static int amdgpu_hwmon_get_sensor_generic(struct a=
mdgpu_device *adev,  {
        int r, size =3D sizeof(uint32_t);

-       if (amdgpu_in_reset(adev))
-               return -EPERM;
-       if (adev->in_suspend && !adev->in_runpm)
-               return -EPERM;
-
-       r =3D pm_runtime_get_if_active(adev->dev);
-       if (r <=3D 0)
-               return r ?: -EPERM;
+       r =3D amdgpu_pm_get_access_if_active(adev);
+       if (r)
+               return r;

        /* get the sensor value */
        r =3D amdgpu_dpm_read_sensor(adev, sensor, query, &size);

-       pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
+       amdgpu_pm_put_access(adev);

        return r;
 }
@@ -1576,24 +1526,19 @@ static ssize_t amdgpu_get_pcie_bw(struct device *de=
v,
        uint64_t count0 =3D 0, count1 =3D 0;
        int ret;

-       if (amdgpu_in_reset(adev))
-               return -EPERM;
-       if (adev->in_suspend && !adev->in_runpm)
-               return -EPERM;
-
        if (adev->flags & AMD_IS_APU)
                return -ENODATA;

        if (!adev->asic_funcs->get_pcie_usage)
                return -ENODATA;

-       ret =3D pm_runtime_get_if_active(ddev->dev);
-       if (ret <=3D 0)
-               return ret ?: -EPERM;
+       ret =3D amdgpu_pm_get_access_if_active(adev);
+       if (ret)
+               return ret;

        amdgpu_asic_get_pcie_usage(adev, &count0, &count1);

-       pm_runtime_put_autosuspend(ddev->dev);
+       amdgpu_pm_put_access(adev);

        return sysfs_emit(buf, "%llu %llu %i\n",
                          count0, count1, pcie_get_mps(adev->pdev)); @@ -16=
15,12 +1560,11 @@ static ssize_t amdgpu_get_unique_id(struct device *dev,  =
{
        struct drm_device *ddev =3D dev_get_drvdata(dev);
        struct amdgpu_device *adev =3D drm_to_adev(ddev);
+       int r;

-       if (amdgpu_in_reset(adev))
-               return -EPERM;
-       if (adev->in_suspend && !adev->in_runpm)
-               return -EPERM;
-
+       r =3D amdgpu_pm_dev_state_check(adev);
+       if (r)
+               return r;
        if (adev->unique_id)
                return sysfs_emit(buf, "%016llx\n", adev->unique_id);

@@ -1715,9 +1659,9 @@ static ssize_t amdgpu_get_apu_thermal_cap(struct devi=
ce *dev,
        struct drm_device *ddev =3D dev_get_drvdata(dev);
        struct amdgpu_device *adev =3D drm_to_adev(ddev);

-       ret =3D pm_runtime_get_if_active(ddev->dev);
-       if (ret <=3D 0)
-               return ret ?: -EPERM;
+       ret =3D amdgpu_pm_get_access_if_active(adev);
+       if (ret)
+               return ret;

        ret =3D amdgpu_dpm_get_apu_thermal_limit(adev, &limit);
        if (!ret)
@@ -1725,7 +1669,7 @@ static ssize_t amdgpu_get_apu_thermal_cap(struct devi=
ce *dev,
        else
                size =3D sysfs_emit(buf, "failed to get thermal limit\n");

-       pm_runtime_put_autosuspend(ddev->dev);
+       amdgpu_pm_put_access(adev);

        return size;
 }
@@ -1749,20 +1693,18 @@ static ssize_t amdgpu_set_apu_thermal_cap(struct de=
vice *dev,
                return -EINVAL;
        }

-       ret =3D pm_runtime_resume_and_get(ddev->dev);
+       ret =3D amdgpu_pm_get_access(adev);
        if (ret < 0)
                return ret;

        ret =3D amdgpu_dpm_set_apu_thermal_limit(adev, value);
        if (ret) {
-               pm_runtime_mark_last_busy(ddev->dev);
-               pm_runtime_put_autosuspend(ddev->dev);
+               amdgpu_pm_put_access(adev);
                dev_err(dev, "failed to update thermal limit\n");
                return ret;
        }

-       pm_runtime_mark_last_busy(ddev->dev);
-       pm_runtime_put_autosuspend(ddev->dev);
+       amdgpu_pm_put_access(adev);

        return count;
 }
@@ -1786,18 +1728,13 @@ static ssize_t amdgpu_get_pm_metrics(struct device =
*dev,
        ssize_t size =3D 0;
        int ret;

-       if (amdgpu_in_reset(adev))
-               return -EPERM;
-       if (adev->in_suspend && !adev->in_runpm)
-               return -EPERM;
-
-       ret =3D pm_runtime_get_if_active(ddev->dev);
-       if (ret <=3D 0)
-               return ret ?: -EPERM;
+       ret =3D amdgpu_pm_get_access_if_active(adev);
+       if (ret)
+               return ret;

        size =3D amdgpu_dpm_get_pm_metrics(adev, buf, PAGE_SIZE);

-       pm_runtime_put_autosuspend(ddev->dev);
+       amdgpu_pm_put_access(adev);

        return size;
 }
@@ -1824,14 +1761,9 @@ static ssize_t amdgpu_get_gpu_metrics(struct device =
*dev,
        ssize_t size =3D 0;
        int ret;

-       if (amdgpu_in_reset(adev))
-               return -EPERM;
-       if (adev->in_suspend && !adev->in_runpm)
-               return -EPERM;
-
-       ret =3D pm_runtime_get_if_active(ddev->dev);
-       if (ret <=3D 0)
-               return ret ?: -EPERM;
+       ret =3D amdgpu_pm_get_access_if_active(adev);
+       if (ret)
+               return ret;

        size =3D amdgpu_dpm_get_gpu_metrics(adev, &gpu_metrics);
        if (size <=3D 0)
@@ -1843,7 +1775,7 @@ static ssize_t amdgpu_get_gpu_metrics(struct device *=
dev,
        memcpy(buf, gpu_metrics, size);

 out:
-       pm_runtime_put_autosuspend(ddev->dev);
+       amdgpu_pm_put_access(adev);

        return size;
 }
@@ -1939,19 +1871,14 @@ static ssize_t amdgpu_set_smartshift_bias(struct de=
vice *dev,
        int r =3D 0;
        int bias =3D 0;

-       if (amdgpu_in_reset(adev))
-               return -EPERM;
-       if (adev->in_suspend && !adev->in_runpm)
-               return -EPERM;
-
-       r =3D pm_runtime_resume_and_get(ddev->dev);
-       if (r < 0)
-               return r;
-
        r =3D kstrtoint(buf, 10, &bias);
        if (r)
                goto out;

+       r =3D amdgpu_pm_get_access(adev);
+       if (r < 0)
+               return r;
+
        if (bias > AMDGPU_SMARTSHIFT_MAX_BIAS)
                bias =3D AMDGPU_SMARTSHIFT_MAX_BIAS;
        else if (bias < AMDGPU_SMARTSHIFT_MIN_BIAS) @@ -1963,8 +1890,8 @@ s=
tatic ssize_t amdgpu_set_smartshift_bias(struct device *dev,
        /* TODO: update bias level with SMU message */

 out:
-       pm_runtime_mark_last_busy(ddev->dev);
-       pm_runtime_put_autosuspend(ddev->dev);
+       amdgpu_pm_put_access(adev);
+
        return r;
 }

@@ -2218,14 +2145,14 @@ static ssize_t amdgpu_get_pm_policy_attr(struct dev=
ice *dev,
        struct drm_device *ddev =3D dev_get_drvdata(dev);
        struct amdgpu_device *adev =3D drm_to_adev(ddev);
        struct amdgpu_pm_policy_attr *policy_attr;
+       int r;

        policy_attr =3D
                container_of(attr, struct amdgpu_pm_policy_attr, dev_attr);

-       if (amdgpu_in_reset(adev))
-               return -EPERM;
-       if (adev->in_suspend && !adev->in_runpm)
-               return -EPERM;
+       r =3D amdgpu_pm_dev_state_check(adev);
+       if (r)
+               return r;

        return amdgpu_dpm_get_pm_policy_info(adev, policy_attr->id, buf);  =
} @@ -2243,11 +2170,6 @@ static ssize_t amdgpu_set_pm_policy_attr(struct de=
vice *dev,
        char *tmp, *param;
        long val;

-       if (amdgpu_in_reset(adev))
-               return -EPERM;
-       if (adev->in_suspend && !adev->in_runpm)
-               return -EPERM;
-
        count =3D min(count, sizeof(tmp_buf));
        memcpy(tmp_buf, buf, count);
        tmp_buf[count - 1] =3D '\0';
@@ -2273,14 +2195,13 @@ static ssize_t amdgpu_set_pm_policy_attr(struct dev=
ice *dev,
        policy_attr =3D
                container_of(attr, struct amdgpu_pm_policy_attr, dev_attr);

-       ret =3D pm_runtime_resume_and_get(ddev->dev);
+       ret =3D amdgpu_pm_get_access(adev);
        if (ret < 0)
                return ret;

        ret =3D amdgpu_dpm_set_pm_policy(adev, policy_attr->id, val);

-       pm_runtime_mark_last_busy(ddev->dev);
-       pm_runtime_put_autosuspend(ddev->dev);
+       amdgpu_pm_put_access(adev);

        if (ret)
                return ret;
@@ -2704,18 +2625,13 @@ static ssize_t amdgpu_hwmon_get_pwm1_enable(struct =
device *dev,
        u32 pwm_mode =3D 0;
        int ret;

-       if (amdgpu_in_reset(adev))
-               return -EPERM;
-       if (adev->in_suspend && !adev->in_runpm)
-               return -EPERM;
-
-       ret =3D pm_runtime_get_if_active(adev->dev);
-       if (ret <=3D 0)
-               return ret ?: -EPERM;
+       ret =3D amdgpu_pm_get_access_if_active(adev);
+       if (ret)
+               return ret;

        ret =3D amdgpu_dpm_get_fan_control_mode(adev, &pwm_mode);

-       pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
+       amdgpu_pm_put_access(adev);

        if (ret)
                return -EINVAL;
@@ -2733,11 +2649,6 @@ static ssize_t amdgpu_hwmon_set_pwm1_enable(struct d=
evice *dev,
        u32 pwm_mode;
        int value;

-       if (amdgpu_in_reset(adev))
-               return -EPERM;
-       if (adev->in_suspend && !adev->in_runpm)
-               return -EPERM;
-
        err =3D kstrtoint(buf, 10, &value);
        if (err)
                return err;
@@ -2751,14 +2662,13 @@ static ssize_t amdgpu_hwmon_set_pwm1_enable(struct =
device *dev,
        else
                return -EINVAL;

-       ret =3D pm_runtime_resume_and_get(adev->dev);
+       ret =3D amdgpu_pm_get_access(adev);
        if (ret < 0)
                return ret;

        ret =3D amdgpu_dpm_set_fan_control_mode(adev, pwm_mode);

-       pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
-       pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
+       amdgpu_pm_put_access(adev);

        if (ret)
                return -EINVAL;
@@ -2789,16 +2699,11 @@ static ssize_t amdgpu_hwmon_set_pwm1(struct device =
*dev,
        u32 value;
        u32 pwm_mode;

-       if (amdgpu_in_reset(adev))
-               return -EPERM;
-       if (adev->in_suspend && !adev->in_runpm)
-               return -EPERM;
-
        err =3D kstrtou32(buf, 10, &value);
        if (err)
                return err;

-       err =3D pm_runtime_resume_and_get(adev->dev);
+       err =3D amdgpu_pm_get_access(adev);
        if (err < 0)
                return err;

@@ -2815,8 +2720,7 @@ static ssize_t amdgpu_hwmon_set_pwm1(struct device *d=
ev,
        err =3D amdgpu_dpm_set_fan_speed_pwm(adev, value);

 out:
-       pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
-       pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
+       amdgpu_pm_put_access(adev);

        if (err)
                return err;
@@ -2832,18 +2736,13 @@ static ssize_t amdgpu_hwmon_get_pwm1(struct device =
*dev,
        int err;
        u32 speed =3D 0;

-       if (amdgpu_in_reset(adev))
-               return -EPERM;
-       if (adev->in_suspend && !adev->in_runpm)
-               return -EPERM;
-
-       err =3D pm_runtime_get_if_active(adev->dev);
-       if (err <=3D 0)
-               return err ?: -EPERM;
+       err =3D amdgpu_pm_get_access_if_active(adev);
+       if (err)
+               return err;

        err =3D amdgpu_dpm_get_fan_speed_pwm(adev, &speed);

-       pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
+       amdgpu_pm_put_access(adev);

        if (err)
                return err;
@@ -2859,18 +2758,13 @@ static ssize_t amdgpu_hwmon_get_fan1_input(struct d=
evice *dev,
        int err;
        u32 speed =3D 0;

-       if (amdgpu_in_reset(adev))
-               return -EPERM;
-       if (adev->in_suspend && !adev->in_runpm)
-               return -EPERM;
-
-       err =3D pm_runtime_get_if_active(adev->dev);
-       if (err <=3D 0)
-               return err ?: -EPERM;
+       err =3D amdgpu_pm_get_access_if_active(adev);
+       if (err)
+               return err;

        err =3D amdgpu_dpm_get_fan_speed_rpm(adev, &speed);

-       pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
+       amdgpu_pm_put_access(adev);

        if (err)
                return err;
@@ -2920,18 +2814,13 @@ static ssize_t amdgpu_hwmon_get_fan1_target(struct =
device *dev,
        int err;
        u32 rpm =3D 0;

-       if (amdgpu_in_reset(adev))
-               return -EPERM;
-       if (adev->in_suspend && !adev->in_runpm)
-               return -EPERM;
-
-       err =3D pm_runtime_get_if_active(adev->dev);
-       if (err <=3D 0)
-               return err ?: -EPERM;
+       err =3D amdgpu_pm_get_access_if_active(adev);
+       if (err)
+               return err;

        err =3D amdgpu_dpm_get_fan_speed_rpm(adev, &rpm);

-       pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
+       amdgpu_pm_put_access(adev);

        if (err)
                return err;
@@ -2948,16 +2837,11 @@ static ssize_t amdgpu_hwmon_set_fan1_target(struct =
device *dev,
        u32 value;
        u32 pwm_mode;

-       if (amdgpu_in_reset(adev))
-               return -EPERM;
-       if (adev->in_suspend && !adev->in_runpm)
-               return -EPERM;
-
        err =3D kstrtou32(buf, 10, &value);
        if (err)
                return err;

-       err =3D pm_runtime_resume_and_get(adev->dev);
+       err =3D amdgpu_pm_get_access(adev);
        if (err < 0)
                return err;

@@ -2973,8 +2857,7 @@ static ssize_t amdgpu_hwmon_set_fan1_target(struct de=
vice *dev,
        err =3D amdgpu_dpm_set_fan_speed_rpm(adev, value);

 out:
-       pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
-       pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
+       amdgpu_pm_put_access(adev);

        if (err)
                return err;
@@ -2990,18 +2873,13 @@ static ssize_t amdgpu_hwmon_get_fan1_enable(struct =
device *dev,
        u32 pwm_mode =3D 0;
        int ret;

-       if (amdgpu_in_reset(adev))
-               return -EPERM;
-       if (adev->in_suspend && !adev->in_runpm)
-               return -EPERM;
-
-       ret =3D pm_runtime_get_if_active(adev->dev);
-       if (ret <=3D 0)
-               return ret ?: -EPERM;
+       ret =3D amdgpu_pm_get_access_if_active(adev);
+       if (ret)
+               return ret;

        ret =3D amdgpu_dpm_get_fan_control_mode(adev, &pwm_mode);

-       pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
+       amdgpu_pm_put_access(adev);

        if (ret)
                return -EINVAL;
@@ -3019,11 +2897,6 @@ static ssize_t amdgpu_hwmon_set_fan1_enable(struct d=
evice *dev,
        int value;
        u32 pwm_mode;

-       if (amdgpu_in_reset(adev))
-               return -EPERM;
-       if (adev->in_suspend && !adev->in_runpm)
-               return -EPERM;
-
        err =3D kstrtoint(buf, 10, &value);
        if (err)
                return err;
@@ -3035,14 +2908,13 @@ static ssize_t amdgpu_hwmon_set_fan1_enable(struct =
device *dev,
        else
                return -EINVAL;

-       err =3D pm_runtime_resume_and_get(adev->dev);
+       err =3D amdgpu_pm_get_access(adev);
        if (err < 0)
                return err;

        err =3D amdgpu_dpm_set_fan_control_mode(adev, pwm_mode);

-       pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
-       pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
+       amdgpu_pm_put_access(adev);

        if (err)
                return -EINVAL;
@@ -3157,14 +3029,9 @@ static ssize_t amdgpu_hwmon_show_power_cap_generic(s=
truct device *dev,
        ssize_t size;
        int r;

-       if (amdgpu_in_reset(adev))
-               return -EPERM;
-       if (adev->in_suspend && !adev->in_runpm)
-               return -EPERM;
-
-       r =3D pm_runtime_get_if_active(adev->dev);
-       if (r <=3D 0)
-               return r ?: -EPERM;
+       r =3D amdgpu_pm_get_access_if_active(adev);
+       if (r)
+               return r;

        r =3D amdgpu_dpm_get_power_limit(adev, &limit,
                                      pp_limit_level, power_type);
@@ -3174,7 +3041,7 @@ static ssize_t amdgpu_hwmon_show_power_cap_generic(st=
ruct device *dev,
        else
                size =3D sysfs_emit(buf, "\n");

-       pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
+       amdgpu_pm_put_access(adev);

        return size;
 }
@@ -3235,11 +3102,6 @@ static ssize_t amdgpu_hwmon_set_power_cap(struct dev=
ice *dev,
        int err;
        u32 value;

-       if (amdgpu_in_reset(adev))
-               return -EPERM;
-       if (adev->in_suspend && !adev->in_runpm)
-               return -EPERM;
-
        if (amdgpu_sriov_vf(adev))
                return -EINVAL;

@@ -3250,14 +3112,13 @@ static ssize_t amdgpu_hwmon_set_power_cap(struct de=
vice *dev,
        value =3D value / 1000000; /* convert to Watt */
        value |=3D limit_type << 24;

-       err =3D pm_runtime_resume_and_get(adev->dev);
+       err =3D amdgpu_pm_get_access(adev);
        if (err < 0)
                return err;

        err =3D amdgpu_dpm_set_power_limit(adev, value);

-       pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
-       pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
+       amdgpu_pm_put_access(adev);

        if (err)
                return err;
@@ -3695,20 +3556,15 @@ static int amdgpu_retrieve_od_settings(struct amdgp=
u_device *adev,
        int size =3D 0;
        int ret;

-       if (amdgpu_in_reset(adev))
-               return -EPERM;
-       if (adev->in_suspend && !adev->in_runpm)
-               return -EPERM;
-
-       ret =3D pm_runtime_get_if_active(adev->dev);
-       if (ret <=3D 0)
-               return ret ?: -EPERM;
+       ret =3D amdgpu_pm_get_access_if_active(adev);
+       if (ret)
+               return ret;

        size =3D amdgpu_dpm_print_clock_levels(adev, od_type, buf);
        if (size =3D=3D 0)
                size =3D sysfs_emit(buf, "\n");

-       pm_runtime_put_autosuspend(adev->dev);
+       amdgpu_pm_put_access(adev);

        return size;
 }
@@ -3776,11 +3632,6 @@ amdgpu_distribute_custom_od_settings(struct amdgpu_d=
evice *adev,
        long parameter[64];
        int ret;

-       if (amdgpu_in_reset(adev))
-               return -EPERM;
-       if (adev->in_suspend && !adev->in_runpm)
-               return -EPERM;
-
        ret =3D parse_input_od_command_lines(in_buf,
                                           count,
                                           &cmd_type,
@@ -3789,7 +3640,7 @@ amdgpu_distribute_custom_od_settings(struct amdgpu_de=
vice *adev,
        if (ret)
                return ret;

-       ret =3D pm_runtime_resume_and_get(adev->dev);
+       ret =3D amdgpu_pm_get_access(adev);
        if (ret < 0)
                return ret;

@@ -3808,14 +3659,12 @@ amdgpu_distribute_custom_od_settings(struct amdgpu_=
device *adev,
                        goto err_out;
        }

-       pm_runtime_mark_last_busy(adev->dev);
-       pm_runtime_put_autosuspend(adev->dev);
+       amdgpu_pm_put_access(adev);

        return count;

 err_out:
-       pm_runtime_mark_last_busy(adev->dev);
-       pm_runtime_put_autosuspend(adev->dev);
+       amdgpu_pm_put_access(adev);

        return ret;
 }
@@ -4785,16 +4634,10 @@ static void amdgpu_parse_cg_state(struct seq_file *=
m, u64 flags)  static int amdgpu_debugfs_pm_info_show(struct seq_file *m, v=
oid *unused)  {
        struct amdgpu_device *adev =3D (struct amdgpu_device *)m->private;
-       struct drm_device *dev =3D adev_to_drm(adev);
        u64 flags =3D 0;
        int r;

-       if (amdgpu_in_reset(adev))
-               return -EPERM;
-       if (adev->in_suspend && !adev->in_runpm)
-               return -EPERM;
-
-       r =3D pm_runtime_resume_and_get(dev->dev);
+       r =3D amdgpu_pm_get_access(adev);
        if (r < 0)
                return r;

@@ -4811,7 +4654,7 @@ static int amdgpu_debugfs_pm_info_show(struct seq_fil=
e *m, void *unused)
        seq_printf(m, "\n");

 out:
-       pm_runtime_put_autosuspend(dev->dev);
+       amdgpu_pm_put_access(adev);

        return r;
 }
@@ -4831,10 +4674,9 @@ static ssize_t amdgpu_pm_prv_buffer_read(struct file=
 *f, char __user *buf,
        void *smu_prv_buf;
        int ret =3D 0;

-       if (amdgpu_in_reset(adev))
-               return -EPERM;
-       if (adev->in_suspend && !adev->in_runpm)
-               return -EPERM;
+       ret =3D amdgpu_pm_dev_state_check(adev);
+       if (ret)
+               return ret;

        ret =3D amdgpu_dpm_get_smu_prv_buf_details(adev, &smu_prv_buf, &smu=
_prv_buf_size);
        if (ret)
--
2.25.1

