Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86C36C369BD
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Apr 2025 10:42:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 045D010E8BB;
	Wed, 16 Apr 2025 10:42:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wjefAges";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2078.outbound.protection.outlook.com [40.107.236.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6EB8310E8BB
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Apr 2025 10:42:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o3tGl7abtK/N0m82kq8QPyPglwMn1b2M8mmqZ+JqQ2I1zJd9ZiptV7vF6tK0jFZI9/td0YbJBeI0GMRDxk4Nv+50jKYXRHVQnTcDMBuNPHpVYd0gBpW8KyXYQgV+DW45l135VSBK4JlsVUog9myj2daB3IK+gNkN3025FVy1nDtB1xecNJoxpYxR32vRvCaG80MSVJ3fv4DW8NQZ/MXCTK9As3tVqc/ddvB6vHQS3nTi3V7/03gcwYrzYHqwurr63M5eafHH7GoyiA1LUFRC9t1Bb91cSVFIGGwWtv8kBnG7fHVxCLwFlBTXmMACa0onsADKQ8/phAcvW6WJ0PlO6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I7HmuxLAKFg6N6c8CN7Ns+UNziyzMQ4UB9brnN9FjYA=;
 b=wcRyZI8YI4TJKlw0KJPnvwym59Ytb8flktizgSAyOzb23FMx/mKWu5kHzH2ykZLvrmk012y3+1sBxHyYYxHyfLRjN76GJjAlXMY12aXBYPrAQKAs0Jknpl5e5yXDy19wFa85kDPa7H/E036nrxzMwpO4oKL7JR0fBNxVDSLeJu/oLs//K5kZvcJnw71KTpqAJqQ5dZlzQ5C4fN5edrP0LaVvw5eRl9bxhwoR1Ji+Sgh0cQ/Xz8VjzjOsxo4Sc37HsuFERVx4KC1BYBFY//mVhozp/m8+Rg7RjItigv4c88N5OAJ1wUOSKIjOMXG/C+zGHJuaArHm8GQwFanl8TT2nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I7HmuxLAKFg6N6c8CN7Ns+UNziyzMQ4UB9brnN9FjYA=;
 b=wjefAgesDc8IAsdoidxbR7aA4VY3uYcNM1KWsPSS+QiYp/whlUFrky2/8FobApl6svaEd/gZPNeWBbK+9MeVN4fQUObdgy4Wl3wGp5WwEUZDvzeyixBA1gyl8aojOaI8uvlfdcP+cbgH0i1nE4Vp4Ny5aSfjUFaancCdtZ9GAR4=
Received: from DM4PR12MB5937.namprd12.prod.outlook.com (2603:10b6:8:68::11) by
 BN5PR12MB9461.namprd12.prod.outlook.com (2603:10b6:408:2a8::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8632.33; Wed, 16 Apr 2025 10:42:16 +0000
Received: from DM4PR12MB5937.namprd12.prod.outlook.com
 ([fe80::c847:70c6:3c78:54ba]) by DM4PR12MB5937.namprd12.prod.outlook.com
 ([fe80::c847:70c6:3c78:54ba%7]) with mapi id 15.20.8632.030; Wed, 16 Apr 2025
 10:42:16 +0000
From: "Zhang, GuoQing (Sam)" <GuoQing.Zhang@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Zhao, Victor" <Victor.Zhao@amd.com>, "Chang, HaiJun"
 <HaiJun.Chang@amd.com>, "Deng, Emily" <Emily.Deng@amd.com>
Subject: Re: [PATCH 0/6] enable switching to new gpu index for hibernate on
 SRIOV.
Thread-Topic: [PATCH 0/6] enable switching to new gpu index for hibernate on
 SRIOV.
Thread-Index: AQHbrSqkd9P4m/w0jEq/ekT1o+A9w7OmHd7K
Date: Wed, 16 Apr 2025 10:42:00 +0000
Message-ID: <DM4PR12MB593793E2B15E182E1DE70017E5BD2@DM4PR12MB5937.namprd12.prod.outlook.com>
References: <20250414104655.336497-1-guoqing.zhang@amd.com>
In-Reply-To: <20250414104655.336497-1-guoqing.zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-04-16T10:41:24.7323440Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5937:EE_|BN5PR12MB9461:EE_
x-ms-office365-filtering-correlation-id: 253cd4a9-0676-4bb6-5669-08dd7cd35b22
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700018|8096899003|7053199007; 
x-microsoft-antispam-message-info: =?Windows-1252?Q?O/st4ucEUJSadl0BrdM7skEQTxvb/siBheCKxMBWtG1NblEkvUfxxMfz?=
 =?Windows-1252?Q?4WuSgnh1BX+Mn3Gh9hrB3IDKUpwGV3OQajzEzfJaS4W2Aou818IWgvUd?=
 =?Windows-1252?Q?fYPwaR2sb+wy0/oowIF+u9Lmu5p089runrsW6tQui8agfoe3XgLoyu9k?=
 =?Windows-1252?Q?DFRocv69y/FhuDJcRpib0s9FnjbYJnJVXZF57RaCX1E5AJpSgMfELIcU?=
 =?Windows-1252?Q?EwTqAOJOKoM4dcwH3IY48OeP6GdLKVaamwrd7Kl1YiI2lPB8ztDuAY8n?=
 =?Windows-1252?Q?hYECd459YWYgSyFy5r63yidCOZh/GC2wm0qN8x/+yO6R4YA2uudEDFvK?=
 =?Windows-1252?Q?ls6ub81XjmXyoEPCYD5tnIlmANNkEuLECd1/Ckz8ztjSaCADrKZJGcOd?=
 =?Windows-1252?Q?qpH37kW1qOizsn+Djhy2v8l5Dtcd8bClvsuSu942Q3g6w3iAZKTQ5cIT?=
 =?Windows-1252?Q?vgz2FdVts1FqcxLYS7/4uvJn+7QxuF21Tm4hpWYe4iTqnmEi4dMTgh5t?=
 =?Windows-1252?Q?SLOj8nzMncDbPqxEXKqa86wBzx7c0XLWt+zhtg9EMgwDGwZGfSEG16/X?=
 =?Windows-1252?Q?mXQYNF3RfwxFMasIW2yEssUqB2ERicak6XnEN2oL4Gp1xyTgHzTKjvlz?=
 =?Windows-1252?Q?tlN3Ws9zuXq1KKYK9ocuJBxIkmbWXOD4a4OkJd6uaigsCi9b30tS6fce?=
 =?Windows-1252?Q?nGM+JuS1WLYUl1TcsSfhs6EtPQai+UQiVRd0g0f4Rn1H+DDHTUjLA+mE?=
 =?Windows-1252?Q?g4nDoUht+iTUO7gpp4KiUS6Tkm/gKp6Wv2D0WG/FRpEdcOxA6laVY75G?=
 =?Windows-1252?Q?VEnud31xUuKBC3eJ39UF3wdwtxc+5FTL5KVleEbMEJXWCuCnWTJzY0RW?=
 =?Windows-1252?Q?3sl3DqTC4Kq7mDPwQlJIpIS3jSV8wkz+5lVSrb/2HwhvNDYppQl+vPUF?=
 =?Windows-1252?Q?hKZdm69TxWIXNK11BB5UwoxTKtGMTU996iKBF+RQEGPWXNoX57PKJzJk?=
 =?Windows-1252?Q?WBk3qveBkdFy3TsqgKZem26B0g9DVobJ81AbfRhurl3jlPrapVucQ9YS?=
 =?Windows-1252?Q?5Gz6q9ezTUxCL+0HjNdOlhOMzrtcYghpu83uukB5oyTo9l/v+2T3oDeR?=
 =?Windows-1252?Q?JsJev22d+O17WiCvcTW+o3RuE6Vfy5O1mossospyRGu0dyPmOrEEazg1?=
 =?Windows-1252?Q?vb0HOULWSbVCIElkr9mqJCHUktilq8L2U81uPUwZ6JnPHSkNSYMgLH12?=
 =?Windows-1252?Q?I7A4/7YHPKWvcvpahx5ob+tR9l56mfDqoVKQxZiOT4VP6cjjX1oYHj/i?=
 =?Windows-1252?Q?8FnoyAVLJcAoIDpwOj/iLz1I3WbEC+qjxVMYonoW8TMaMkhdwhQXkE5O?=
 =?Windows-1252?Q?cY3H7FBUi/jr0tanantUna8krNOD+9Gn3KBCD6E8r1J2fMi0BejEQ1ZD?=
 =?Windows-1252?Q?HAfxIpZ+XBPDPNv6slMgsiXW5avJWyRn02CFsmMXF4QqCohb1mk5Q6gz?=
 =?Windows-1252?Q?qWamwHwcQlBkcF5fe97tcPlbcRVo3D87X24UUu2wiDHmJ1Pyn4sHkzKh?=
 =?Windows-1252?Q?vdlnjVliE7FmPN9Wgmnmz/9oBp0ZueIXThe1oA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5937.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018)(8096899003)(7053199007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?Windows-1252?Q?Qhub4ezXuqJWOx2KMic08/KeNSC3jCMc7y2kbSE5f+aNWUHxIikBOThR?=
 =?Windows-1252?Q?obD2bZQnAE4af+8yLJRzmfuMqOJaTj60OaFR96pyfvCpaD4GM/83oAgo?=
 =?Windows-1252?Q?iBTs8AfASGe93DE7hDa72abben1zAdbBTTeLjKDHieS4sqmLRp3jQlpD?=
 =?Windows-1252?Q?A+iLC7WiCMLC/fLB0qq8zjZPzKAwDx6WgchBWGGVyPAiHVigFr/hgQ9w?=
 =?Windows-1252?Q?hxjbMG6z5KuA3ks8mUkcqBxsW43WjjKQdhOsdRDidhk3mzoKisVj3p2x?=
 =?Windows-1252?Q?AvFMSzqf9glEArp6NZGIu9vE0VOeGXefEi13+bUk9r+9fRCy6nXHJ9AE?=
 =?Windows-1252?Q?sjQv+P/I0XUYUkDRyrpjM813WTnwT2hxdspynjzjJykZcwK+uMsgixJE?=
 =?Windows-1252?Q?EsBqepMYPSphmnYWJ/k+8sXrJ136g9ZOv3ygNO4CblJGb7f1oYNZEiRR?=
 =?Windows-1252?Q?Kc4ZG1JGUhwJWbnxkAntOkAFN1lNP/SDK+vOzhe4i/hfIKC4/vmfY01n?=
 =?Windows-1252?Q?LKVlRY/6qpHkJqpCKVGjQvt23vIw8jFqLnirDg5680OKy3HCro7dHIUq?=
 =?Windows-1252?Q?f+MdOrqVrfUWBm95RYWT1LdGORMNqwUeytMoZBcKArYiXECWnhyF5FYR?=
 =?Windows-1252?Q?XyaXEJixUmhAh48zYuRzO05SGCudSWNKpjPm3JHBMJLucz5qqspT5Szq?=
 =?Windows-1252?Q?c435TOTOD0rlId9jygXPJHmcGf6cur8DxiicBzMUk05yOlBW++Sc8Tyt?=
 =?Windows-1252?Q?8a6C/R4c3YgQRgNnAhbz6tju5Xvm1LhD8nMvubcshqsSFo795lZs3ZGc?=
 =?Windows-1252?Q?fQPf7qp2ePHygjUBv/92tVAgvLIK9uH1dLS+tKD1LB4rj0ZrJsCuyGV8?=
 =?Windows-1252?Q?M4X+OMXj24dRVUGo8xm5qabu8ITdvbKWm+mgHMy4ZYhxi0j9imooaCci?=
 =?Windows-1252?Q?cVA4WdmLQm7dPF+LJmZUi/kok/7kMbETyRd0dhVsYrv1isiCh/STk2Df?=
 =?Windows-1252?Q?h9NEq/pu8M8NQtGWQ6LTbNGPnmzbbmM0RHkD2+dO3V24xv/ndzEOH0cZ?=
 =?Windows-1252?Q?oAFiksn8bXSjcST65MY0dIWXYmHQ2ILUYSYWC3JSPg8vNhSQ/YNBzWZu?=
 =?Windows-1252?Q?uegDySMuNtE7M2qtIipxckvQObFccUqH0VK0YQS9rtU8H5CzuYxNrzR+?=
 =?Windows-1252?Q?9VmEVfaiuZJlEmlEIPy3yIUoMsrkZ6sUo3ISR+iHAXrtmhvxokef2AZm?=
 =?Windows-1252?Q?u/mkckw4yb33pPzFudnHIr/uFcmlP2aYfcnAb2cGtA/H9TIuHNOK3u9m?=
 =?Windows-1252?Q?KtbOhpWmNoyw/mgwCcwC88aJB0dawz05azeD8jayQf1k8R+fsuHo8hh+?=
 =?Windows-1252?Q?gLfevy6WzFr/kpEiC/i53jUt9+q7danFVdJnVOrEwLzKA96nQsw8Cyoo?=
 =?Windows-1252?Q?fXbq1QKa18pSLOVxuUntorUyqBx+jlwBVaDII3HV970aa1Muzl9atnS/?=
 =?Windows-1252?Q?CrvcRubUXGvZ2iQoW0sk6z86itU2VujdgVmPF2RTOtPtLATIYOi4OF0H?=
 =?Windows-1252?Q?AuqNrV6Wzk8VLBAzmF5zH59HyicWpEM/iRwJTHVFlv2ax9vRTeT13OOe?=
 =?Windows-1252?Q?xCTJ1ufqqzUYp4n/p1A0eagIwBPj/ww9XQJ4q+S7Ab7OLCMHZBLpsRyf?=
 =?Windows-1252?Q?uJfVSlrObNY=3D?=
Content-Type: multipart/alternative;
 boundary="_000_DM4PR12MB593793E2B15E182E1DE70017E5BD2DM4PR12MB5937namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5937.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 253cd4a9-0676-4bb6-5669-08dd7cd35b22
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2025 10:42:16.4775 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: E/UQGxr6DFgAsU1UbS3COR2v5//tAT7+wJ9q97qPPP9w59E+a0lGVCZoCv1pJPBjILAu5Dns8nUgQiuoFPvB4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN5PR12MB9461
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

--_000_DM4PR12MB593793E2B15E182E1DE70017E5BD2DM4PR12MB5937namp_
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - AMD Internal Distribution Only]

Ping=85

Regards
Sam

From: Samuel Zhang <guoqing.zhang@amd.com>
Date: Monday, April 14, 2025 at 18:47
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Zhao, Victor <Victor.Zhao@amd.com>, Chang, HaiJun <HaiJun.Chang@amd.com=
>, Deng, Emily <Emily.Deng@amd.com>, Zhang, GuoQing (Sam) <GuoQing.Zhang@am=
d.com>
Subject: [PATCH 0/6] enable switching to new gpu index for hibernate on SRI=
OV.
On SRIOV and VM environment, customer may need to switch to new vGPU indexe=
s
after hibernate and then resume the VM. For GPUs with XGMI, `vram_start` wi=
ll
change in this case, the VRAM aperture gpu address of VRAM BOs will also ch=
ange.
These gpu addresses need to be updated when resume. But these addresses are=
 all
over the KMD codebase, updating each of them is error-prone and not accepta=
ble.

The solution is to use pdb0 page table to cover both vram and gart memory a=
nd
use pdb0 virtual gpu address instead. When gpu indexes change, the virtual =
gpu
address won't change.

For psp and smu, pdb0's gpu address does not work, so the original gpu addr=
ess
is used instead. They need to be updated when resume with changed vGPUs.

The last 2 patches fix the issues we hit when testing this feature.

Samuel Zhang (6):
  drm/amdgpu: update XGMI physical node id and GMC configs on resume
  drm/amdgpu: update cached GPU addresses for PSP and ucode
  drm/amdgpu: update cached GPU addresses for SMU
  drm/amdgpu: enable pdb0 for hibernation on SRIOV
  drm/amdgpu: fix sdma ring test fail when resume from hibernation
  drm/amdgpu: fix fence fallback timer expired error

 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 25 ++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c    | 45 +++++++++++++++-------
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h    |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c    |  7 +++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_irq.h    |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c |  8 +++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c    | 24 ++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c  |  3 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h   |  2 +
 drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c   |  2 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c      | 39 +++++++++++++------
 drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c    | 30 ++++++++++++---
 drivers/gpu/drm/amd/amdgpu/vega20_ih.c     | 18 ++++++++-
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c  | 30 +++++++++++++++
 14 files changed, 199 insertions(+), 36 deletions(-)

--
2.43.5

--_000_DM4PR12MB593793E2B15E182E1DE70017E5BD2DM4PR12MB5937namp_
Content-Type: text/html; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" xmlns:w=3D"urn:sc=
hemas-microsoft-com:office:word" xmlns:m=3D"http://schemas.microsoft.com/of=
fice/2004/12/omml" xmlns=3D"http://www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3DWindows-1=
252">
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:DengXian;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:Aptos;
	panose-1:2 11 0 4 2 2 2 2 2 4;}
@font-face
	{font-family:"\@DengXian";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
span.EmailStyle19
	{mso-style-type:personal-reply;
	font-family:"Aptos",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;
	mso-ligatures:none;}
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:72.0pt 72.0pt 72.0pt 72.0pt;}
div.WordSection1
	{page:WordSection1;}
--></style>
</head>
<body lang=3D"en-CN" link=3D"#467886" vlink=3D"#96607D" style=3D"word-wrap:=
break-word">
<p style=3D"font-family:Calibri;font-size:10pt;color:#0000FF;margin:5pt;fon=
t-style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[AMD Official Use Only - AMD Internal Distribution Only]<br>
</p>
<br>
<div>
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Apto=
s&quot;,sans-serif">Ping=85<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Apto=
s&quot;,sans-serif"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Apto=
s&quot;,sans-serif">Regards<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Apto=
s&quot;,sans-serif">Sam<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif"><o:p>&nbsp;</o:p></span></p>
<div id=3D"mail-editor-reference-message-container">
<div>
<div style=3D"border:none;border-top:solid #B5C4DF 1.0pt;padding:3.0pt 0cm =
0cm 0cm">
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><b><span style=3D"fon=
t-size:12.0pt;font-family:&quot;Aptos&quot;,sans-serif;color:black">From:
</span></b><span style=3D"font-size:12.0pt;font-family:&quot;Aptos&quot;,sa=
ns-serif;color:black">Samuel Zhang &lt;guoqing.zhang@amd.com&gt;<br>
<b>Date: </b>Monday, April 14, 2025 at 18:47<br>
<b>To: </b>amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc: </b>Zhao, Victor &lt;Victor.Zhao@amd.com&gt;, Chang, HaiJun &lt;HaiJ=
un.Chang@amd.com&gt;, Deng, Emily &lt;Emily.Deng@amd.com&gt;, Zhang, GuoQin=
g (Sam) &lt;GuoQing.Zhang@amd.com&gt;<br>
<b>Subject: </b>[PATCH 0/6] enable switching to new gpu index for hibernate=
 on SRIOV.<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt">On SRIOV and VM envir=
onment, customer may need to switch to new vGPU indexes<br>
after hibernate and then resume the VM. For GPUs with XGMI, `vram_start` wi=
ll <br>
change in this case, the VRAM aperture gpu address of VRAM BOs will also ch=
ange.<br>
These gpu addresses need to be updated when resume. But these addresses are=
 all<br>
over the KMD codebase, updating each of them is error-prone and not accepta=
ble. <br>
<br>
The solution is to use pdb0 page table to cover both vram and gart memory a=
nd<br>
use pdb0 virtual gpu address instead. When gpu indexes change, the virtual =
gpu <br>
address won't change.<br>
<br>
For psp and smu, pdb0's gpu address does not work, so the original gpu addr=
ess<br>
is used instead. They need to be updated when resume with changed vGPUs.<br=
>
<br>
The last 2 patches fix the issues we hit when testing this feature.<br>
<br>
Samuel Zhang (6):<br>
&nbsp; drm/amdgpu: update XGMI physical node id and GMC configs on resume<b=
r>
&nbsp; drm/amdgpu: update cached GPU addresses for PSP and ucode<br>
&nbsp; drm/amdgpu: update cached GPU addresses for SMU<br>
&nbsp; drm/amdgpu: enable pdb0 for hibernation on SRIOV<br>
&nbsp; drm/amdgpu: fix sdma ring test fail when resume from hibernation<br>
&nbsp; drm/amdgpu: fix fence fallback timer expired error<br>
<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 25 ++++++++++++<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c&nbsp;&nbsp;&nbsp; | 45 ++++++=
+++++++++-------<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h&nbsp;&nbsp;&nbsp; |&nbsp; 1 +=
<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c&nbsp;&nbsp;&nbsp; |&nbsp; 7 +=
++-<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_irq.h&nbsp;&nbsp;&nbsp; |&nbsp; 1 +=
<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_object.c |&nbsp; 8 +++-<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c&nbsp;&nbsp;&nbsp; | 24 ++++++=
++++++<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c&nbsp; |&nbsp; 3 ++<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h&nbsp;&nbsp; |&nbsp; 2 +<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c&nbsp;&nbsp; |&nbsp; 2 +-<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |=
 39 +++++++++++++------<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c&nbsp;&nbsp;&nbsp; | 30 ++++++=
++++++---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/vega20_ih.c&nbsp;&nbsp;&nbsp;&nbsp; | 18 +=
+++++++-<br>
&nbsp;drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c&nbsp; | 30 +++++++++++++++<=
br>
&nbsp;14 files changed, 199 insertions(+), 36 deletions(-)<br>
<br>
-- <br>
2.43.5<o:p></o:p></p>
</div>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_DM4PR12MB593793E2B15E182E1DE70017E5BD2DM4PR12MB5937namp_--
