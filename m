Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79697C2D0CD
	for <amd-gfx@archiver.kernel.org>; Thu, 15 May 2025 13:19:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1D4E710E88D;
	Thu, 15 May 2025 13:19:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5RtaaCKr";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2082.outbound.protection.outlook.com [40.107.92.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C00C810E877
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 May 2025 13:19:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tuCfezVguoA+b7omI7ru3DfYhx16PRNnwCAMiuvMLL/A59aKBLtyRoJywe1ehtCJdh49Op1Mamd+pwmq5JJ1bkQ4JXwianuNqFf3Nep1ksB85V5AUFOJdlW/uReWsFZ5MaPm/+v4cOF26VveUHtaAGC6B4XQ/phLDhJZkXu+P+todbakWgLH2c7zNOns6OFnTJ9gOn0KHYQannjRD4+MOPX1fKQRW4y2WrbrfR9BOwu337XTTVHTLMCU2apNY8dmbdJz05MdRW9fDZINHKaI9sAov3xkTkT+M1v7LKpBQ4jOsFEqMCuRddnXZoXwnX4Rp6lMMCeFEeKNowwrw739uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QSQ7HEjraYerJUSRb3jKWU9ae+lUXvCV8T1n5mAfnqs=;
 b=sIGfY+ldDPkynloxw/5o+WBTSe5YFl6jJJ9u5hdrRZFrbGva8IDWCq55pw6tbkFTETXWbIFNpcPF5iu4QzgS79DRqQyjBbH/a8QoRWSh41yB8+WdKLa8tW1XN2zy41YHFAzGOCD7oPqI+mKtA5ScwXGqRuHiyuyRNCh1cG/KZbOYaQ0M+aspU2U36OqgR/62gDVTVDZaAEEN6+U6Ev9oxoFQ867dM86bIipWMHZEKEPuJJKNCzB85ZE1wH63r7docZh6eVZ/eLzaC0MUMoakLpNqr12oDWri7d9En8N5w4oJLTUgzdRQFnhiigglDP6kiC2+zXPWA0A/Z50dqe+o0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QSQ7HEjraYerJUSRb3jKWU9ae+lUXvCV8T1n5mAfnqs=;
 b=5RtaaCKrrCvkjmpHmiqvdeWL7B/wN/kI+KmMksj9eYUkd+KFMFktkMhTVl7UjwS6OdPAKM31cVf8sjNo5MeR/qtVRK1UfuTXam9Xq1ckwsN22hYkJGggMnjje5+J5bjp8xoAnNXCYD+nvGv6jr+UIGhwDpZwQLmQYvjp7oA51Ck=
Received: from DS7PR12MB6005.namprd12.prod.outlook.com (2603:10b6:8:7c::17) by
 LV3PR12MB9117.namprd12.prod.outlook.com (2603:10b6:408:195::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Thu, 15 May
 2025 13:19:02 +0000
Received: from DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb]) by DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb%4]) with mapi id 15.20.8722.031; Thu, 15 May 2025
 13:19:02 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Fix eviction fence worker race during fd close
Thread-Topic: [PATCH] drm/amdgpu: Fix eviction fence worker race during fd
 close
Thread-Index: AQHbxWgaNdbtWgSI2kWpuqT9Fu+2YrPTqobA
Date: Thu, 15 May 2025 13:19:02 +0000
Message-ID: <DS7PR12MB6005CC0AA22150DA4B9A6F50FB90A@DS7PR12MB6005.namprd12.prod.outlook.com>
References: <20250515070751.497828-1-Jesse.Zhang@amd.com>
In-Reply-To: <20250515070751.497828-1-Jesse.Zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=407b1ce7-9863-407b-9214-016a354f8930;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-05-15T13:10:10Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Tag=10, 0, 1, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6005:EE_|LV3PR12MB9117:EE_
x-ms-office365-filtering-correlation-id: 17d8499b-76d3-4a14-eeaf-08dd93b30f75
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?DQPN4VSuA2ihNs84wiWbpdjoe4UIEqe0dsQAGmuI1UzIlJlTOO/+rc8yzsjE?=
 =?us-ascii?Q?ZKcM+wV48WksMT9uzYMQ9uEPecUxRV4RDt7AUE0x5rId1ZUDhAH91vhhsCW7?=
 =?us-ascii?Q?CEb3v4hQv6t0xFOGGPoyJgVGc5HTff/bMb7EqzkgQP8QQLHZal5S9tDJhRQB?=
 =?us-ascii?Q?JC0CVe0iXlehr9zhUl8AgwvuiXL5ssaCdz90saiy8MyVniiPADHFtY7h7XU8?=
 =?us-ascii?Q?QDQ9M+jPBeridY1yqqNsMzKjfA20DYhLADv57/zYv7Z0BQ2pH/D+oRKY+bTH?=
 =?us-ascii?Q?7iR+CVK1dQRgHf1hilrhAtVRnPsK7XRV0c/zA7etKNe5RJ2bO2lShLssOJ87?=
 =?us-ascii?Q?LYRco6ijn+99fWleE8jLl/YQOtRWbn+RqmZjKLGnH8e1VLUTdmCk3Y4UlByX?=
 =?us-ascii?Q?cVzkP6LN9jZSKKlnAPWTOxUK2DtNUeFeZ1g7X9qRzlkg9DKV0KHbgGS8NAR5?=
 =?us-ascii?Q?bDJl9WS5JjGSAbBKbGg4+GVQJl/vo29iTnLBKh2sdJ71m1mKj9cQRl+xqWF4?=
 =?us-ascii?Q?PzotSs8/EaRObmKOghU+g6WQXAo6aOKnckiFGK+BqGTFvetsusvEeAhLbk4e?=
 =?us-ascii?Q?feFccSPUsb6DSKRnVQuUzpiy8xRwGcTA/8m4JOCVfZSWDI9VyQz7mHhRCafu?=
 =?us-ascii?Q?+A439/qrjicorMHY23aHqpPacWAiY4U8RQOETSa4anhT5BLzKCUgjAVfR2lO?=
 =?us-ascii?Q?WCeO2qtU21TtthML4nw6RqekPnv+yWyHtjJjHWbJfgwU4eQW26tmJ7DdEK2y?=
 =?us-ascii?Q?+cCKmRMyY8wdEmLoxF55+edTjRBtIjcVAOAvHkG+tk0A4KRQVsc2mz4T4SEE?=
 =?us-ascii?Q?S1f0MG/ysLNzrnGzz1D/vf7UofPdCtpStfKFpoKQIWTzMaxDnG/vKTiYTLxn?=
 =?us-ascii?Q?OqC3svh9YXGZBf4uEqMhXW3uaN/+2uep35PIsHs+/wTz0v0Het8wE9OKj1pc?=
 =?us-ascii?Q?8JnD5r/7qTskWquuDv5WXxxR0GGobGqA8Ont4MqwFikOa2tjuzz2h5yOTSaE?=
 =?us-ascii?Q?RGmxWMeE10OfCXPC7dfVbgGxB4QuzCXIE0ZgWsi2hbE+ifVkaKFrC8ak4iCS?=
 =?us-ascii?Q?LoAUni87jA+DLFkcSpPWDuwGfmGfLLQRez/8p+1/aYSXrAYBmpGI20FY6y6P?=
 =?us-ascii?Q?e+tqFjKqzTHOh9EgMdzvT8Lf+cQNY6mxHPZEU7bFpGHxw/zk/ikb+2I6/ZwS?=
 =?us-ascii?Q?xfmHPVCMkZiX/k6UzsP1JxASg2PFaRyvGLCxYr8c5lNHBpAEgWBGejGh2P5s?=
 =?us-ascii?Q?NjwVS9d4ZDJ7MHK3NNufoU31H9GsGyt+kqLVDP1S7aeIhMVRbTKFvaJoiN+d?=
 =?us-ascii?Q?9d0CxHH6cIdjiPRbt07Y3uqrGTG00KzyV4GdHNQ221P/kMP29E5BdXaK0PZT?=
 =?us-ascii?Q?+ECPEuK/aBjEk+LSMFJlMjjdRGIr38Jpf0CJks4avfYaLZfiHTa3WSQwtd8+?=
 =?us-ascii?Q?3NarfsPP+tYSbIwKuIYM+hRI6yBntjh5vA+ZtJoFHNJUhQq3DUTmAw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6005.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?HWs9p9BYa6WEqknB3CQCRsTbOrEH1JwMw5IBsi+Iax8xzLdOsO5bgsWNWMg5?=
 =?us-ascii?Q?Pe+Jx/v8blPhrl/Qopl7WTThmuCbK613sHE6mYotaWHMQr2UquSUzj5rM8m3?=
 =?us-ascii?Q?ul4H5Qv/DvMcXZ3qs1ghGGQFToJFdU4T9qiTSId3mbgVe7ZJQtfKm72bA9Ad?=
 =?us-ascii?Q?S5xfXSko0HGXOmAV0WF27vqKi7TLv15iPT0Mb6B8asICBcEcuIpIh4FUWpcO?=
 =?us-ascii?Q?u6RhDiq0hy6AOnlqSdlizIOulCXgSg+nhxEnEUa8CGlL38yCDQnOzFdq68WQ?=
 =?us-ascii?Q?Ta7LARUq+5Cl308rhKVRrnzYjJYMSzIdLbkmMyMMjm3FlsGEkTf9+oRkbpsJ?=
 =?us-ascii?Q?8MgiXCP+ZCjgpku1hpaPFV+IboSRKCRCEo+YrsZm9DnwraTsXm30qTH/F6oU?=
 =?us-ascii?Q?/vomkoHqUYH0XSia9Qho8+Jq6mT26sIpNT4hz4wPWRC/9eQeJ05dI+wKQ1DK?=
 =?us-ascii?Q?0xKt2NP65qJT9AULa9Wyh7ZYSvCDS6DToJj1mZJNFlcaA4DETGWldBhm2mFB?=
 =?us-ascii?Q?7IOXTwFcGiNA0NndCO2kOD1lV4PPKeqQI3EraE2TIXzBSlYLFs1MRyaG/Thv?=
 =?us-ascii?Q?gsfMKqoRmyDcuMLmAVuD41l82rzLdBSDLuQjwY26RlIEPHp45bdCpG17swkB?=
 =?us-ascii?Q?WePU54vl2OHMRK8xzG/fAbBBjO70zlFg57vKUgafhvwGvrWnleZ+u+D8+WQI?=
 =?us-ascii?Q?dJ4sTroCOIJ8fwlEAk+EFy1sPBLQmj8X0huPeD0rgpwxPOzTEbdbeHuIkjbr?=
 =?us-ascii?Q?g3O+eUT4NGLmO0NS7i4oHUn6olYGfwJcr5OGZmEdyTq92HXQyI5C+1EbXkkA?=
 =?us-ascii?Q?nwNyIGw1WIYO8IKVX8iXKHB5XuPcFTErXB24zT8tpH2jmC4mp0iGjkL7bihp?=
 =?us-ascii?Q?eaa9KYkd5SfBcR7eUZbEogolVMt7JZ/5RKTXIUQlc8oc89b+eurXF/zVMoe7?=
 =?us-ascii?Q?eySphXEksvMlvYbx1TIJjQdVO4agMt2WF4QAGVQQmjWMBCXlvQweIBMbA36w?=
 =?us-ascii?Q?YAbquirXrKiXZEzaqVGfXW1So9JIuzjvfCuJMTo9tar9czm4bBD0PX7LvnJ5?=
 =?us-ascii?Q?iDyEENZJgiwB+Mgf1mNEj6oVpYlGkoWus/KZ32HI7bHJKV8jhEBawl07M9hn?=
 =?us-ascii?Q?ouYRX9/B3BHNHNyKjp9YI4waZo+fzGz1uYhPmS62iRFdGKa3dzjmhuanDDeg?=
 =?us-ascii?Q?3cUFt0awu5wmBsXXke5QFmWtptmYTHsS+C7VZhEB2+1cPMCrIdWpuzrkIhlE?=
 =?us-ascii?Q?3Ht+4lq4gc9u+c4KpH4vnS03ua+f/rYiQ4rPwxT++s+D58f4FUC69YneGuVK?=
 =?us-ascii?Q?4Pqpbff7C9vWvnYmCuuPoOKp1oX3SN1qnavm3Tdjvty7SLulb7eTehHo/rXF?=
 =?us-ascii?Q?6FEHohnEkRKzzmCqUtHokf6AWzA79SqnKuptCQO5oRM4CwE+mksv7VUd0fnQ?=
 =?us-ascii?Q?F0XmBb/IMc/uZrt3aiq/y0aJVul5r5H/t/pIMzvv6gO3BwEMKSI4PXgqSCOJ?=
 =?us-ascii?Q?aT4HfbA1ognzl21K8Kc2QT/zn9dT9ajhGI7wlAjCSKikep4/AVpA8pmRLiXi?=
 =?us-ascii?Q?gW7twsz4ZQb5+MDRuyY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6005.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17d8499b-76d3-4a14-eeaf-08dd93b30f75
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2025 13:19:02.4151 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Pv06ybVlgs1J+mkNo+tqxrCNQvoPgZlkVcOlQNCBuG5Vu/zaEPkwYcXMSrVSw2Yu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9117
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

[Public]

I haven't cleaned up the userq resource destroy at postclose callback in my=
 last patch, so here please remove the duplicated useq destroy. With that, =
the change in the patch is
Reviewed-by: Prike Liang <Prike.Liang@amd.com>

Regards,
      Prike

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
> Jesse.Zhang
> Sent: Thursday, May 15, 2025 3:07 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>; Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>
> Subject: [PATCH] drm/amdgpu: Fix eviction fence worker race during fd clo=
se
>
> The current cleanup order during file descriptor close can lead to a race=
 condition
> where the eviction fence worker attempts to access a destroyed mutex from=
 the
> user queue manager:
>
> [  517.294055] DEBUG_LOCKS_WARN_ON(lock->magic !=3D lock) [  517.294060]
> WARNING: CPU: 8 PID: 2030 at kernel/locking/mutex.c:564 [  517.294094]
> Workqueue: events amdgpu_eviction_fence_suspend_worker [amdgpu]
>
> The issue occurs because:
> 1. We destroy the user queue manager (including its mutex) first 2. Then =
try to
> destroy eviction fences which may have pending work 3. The eviction fence=
 worker
> may try to access the already-destroyed mutex
>
> Fix this by reordering the cleanup to:
> 1. First mark the fd as closing and destroy eviction fences,
>    which flushes any pending work
> 2. Then safely destroy the user queue manager after we're certain
>    no more fence work will be executed
>
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 2 +-
> drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 4ddd08ce8885..4db92e0a60da 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -2913,8 +2913,8 @@ static int amdgpu_drm_release(struct inode *inode,
> struct file *filp)
>
>       if (fpriv) {
>               fpriv->evf_mgr.fd_closing =3D true;
> -             amdgpu_userq_mgr_fini(&fpriv->userq_mgr);
>               amdgpu_eviction_fence_destroy(&fpriv->evf_mgr);
> +             amdgpu_userq_mgr_fini(&fpriv->userq_mgr);
>       }
>
>       return drm_release(inode, filp);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> index 9fbb04aee97b..1fec3713fbf2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> @@ -1504,8 +1504,8 @@ void amdgpu_driver_postclose_kms(struct drm_device
> *dev,
>
>       if (!fpriv->evf_mgr.fd_closing) {
>               fpriv->evf_mgr.fd_closing =3D true;
> -             amdgpu_userq_mgr_fini(&fpriv->userq_mgr);
>               amdgpu_eviction_fence_destroy(&fpriv->evf_mgr);
> +             amdgpu_userq_mgr_fini(&fpriv->userq_mgr);
>       }
>       amdgpu_ctx_mgr_fini(&fpriv->ctx_mgr);
>       amdgpu_vm_fini(adev, &fpriv->vm);
> --
> 2.49.0

