Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2410ECD6E4A
	for <amd-gfx@archiver.kernel.org>; Fri, 29 May 2026 15:43:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A60CC112148;
	Fri, 29 May 2026 15:43:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FC/tUzc3";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011053.outbound.protection.outlook.com [52.101.62.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 669DC112148
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 May 2026 15:43:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GHTb1fhaMATCADpoVw5LWeUtOkNfjoXMYrg1NqYeBQaHAalG6Y/w3lY7nZIlCja/H1pSwh43tBpDQgNYMqemL9Bw2s3c4wqE5ZouOc2o9Cah8CheSAWWxqBNNuXuvOZgBPNmUa1PcHi/n7DmQ/uC2S6Pi2RBFP+4Q3zFMTNp+7N/SSOYxCnV60r2UvTEq5zwJtTqBgmzcet+5s8LBl49UOSPvHb8u82Lzh0U/hKrXhYoeENHebsK107o+VAlEfkSUV7Lo8OguzxqqbOWEEceX+RxSOIZKzkddZ9QFVLy7+Fzf3VmN6ks67k4aMDtTeuc3qXHPDHEm9fYyCg9+/0xTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EqzRO33LQ/jPOa16Tn9Cc1x5fL731ZGItOe6nY6TFcw=;
 b=wPwx6D8W3AX8bP7wZnmqtTr8quCfR+Kk+DeIEnv9hO2QLvImStmvYVbO0F0tZgzj/23+Kp9XwMVeuhfXO54qgPkZUrq8MxG8sbnHRZy+COJUrSYAn8CsgZise7n+3G/8sXAAdXUNBqlj9drzympUufmtzQoT1a7J6gdiLjFT326iwrXmtUsd1SKF2+7jeArXncb47rW1jRs8q0NOKpau+elr6zOwK+uwHU3yUptMrylH9utU7y7cea/cwiNzuivf2XDsYUan/iTWGtqyJBTccfx0RaxRof/dQ7QdRMb6GLvbxLq4qxk3+RpySCrq6pHqSsekNP592524+40Ad+KOmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EqzRO33LQ/jPOa16Tn9Cc1x5fL731ZGItOe6nY6TFcw=;
 b=FC/tUzc3Lzm0BXPlcamTUT9M1AQrN66yy4E/+K4/F2KXqEQaIH6M2wqdz3HlAAEFxpomBCHkHWHClLCcqbkfD36GpfQmm+xFRoVH1vnWeo8rwPquPpUcEyq0/nFIezgjWodMVCLZ/WRmdifQG6A/k+WxBJBAOtToR4S9vfv3P1A=
Received: from DM4PR12MB5038.namprd12.prod.outlook.com (2603:10b6:5:389::18)
 by IA1PR12MB9500.namprd12.prod.outlook.com (2603:10b6:208:596::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.15; Fri, 29 May
 2026 15:43:49 +0000
Received: from DM4PR12MB5038.namprd12.prod.outlook.com
 ([fe80::3c29:3d93:2028:85c4]) by DM4PR12MB5038.namprd12.prod.outlook.com
 ([fe80::3c29:3d93:2028:85c4%6]) with mapi id 15.21.0071.014; Fri, 29 May 2026
 15:43:48 +0000
From: "Kamal, Asad" <Asad.Kamal@amd.com>
To: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "Zhang, Hawking"
 <Hawking.Zhang@amd.com>, "Ma, Le" <Le.Ma@amd.com>, "Zhang, Morris"
 <Shiwu.Zhang@amd.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amd/pm: fix off-by-one over-read in pp mode
Thread-Topic: [PATCH] drm/amd/pm: fix off-by-one over-read in pp mode
Thread-Index: AQHc7zL3qnZ7R7HYpUm11LqCtsfYvrYkkeOAgAATklCAAAKMAIAAfTJA
Date: Fri, 29 May 2026 15:43:48 +0000
Message-ID: <DM4PR12MB5038004BE928C211545DA5158E162@DM4PR12MB5038.namprd12.prod.outlook.com>
References: <20260529061811.357041-1-asad.kamal@amd.com>
 <DM6PR12MB2972B5C6F3EACBEF419362FE82162@DM6PR12MB2972.namprd12.prod.outlook.com>
 <DM4PR12MB503870918384A4AB75B98CE28E162@DM4PR12MB5038.namprd12.prod.outlook.com>
 <DM6PR12MB29727754D5F5ABC0E607A1B982162@DM6PR12MB2972.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB29727754D5F5ABC0E607A1B982162@DM6PR12MB2972.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-05-29T06:50:34.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5038:EE_|IA1PR12MB9500:EE_
x-ms-office365-filtering-correlation-id: d0ee6c9d-bff9-4613-4cc9-08debd99137d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700021|18002099003|22082099003|4143699003|56012099006|11063799006;
x-microsoft-antispam-message-info: mr+pf3vSo4q/c4zpkA8t/8z4zWwvcco8W6yvA95hY3iPNsTtGGU/CvyZJTuuh5YHkc7nz0JV8J902sBo+2jqPh5hr3FPFdzYi1RConnpAb9IKz5sQCuN97p+qLZK87sgK7k8TAvmu6s3bYn1Lc8Zd9WDAx7nz6lxTXWf5jtzHQXz81G6DXiQQJFjyFgZ65J5H79fLXGvS7vAjL2Cjc2hUhW79GiTa5xhaGtZHVzsWj+p51hRs82axF4rmIThfYoR1Zi2xTZOGXK1WNliBdLIhBNf9B75qm/j8QsZa++oF45XX5HL0HEFQSVGkTKcOwPj42AABYwNGH7JfXCCYmn6/QD2BDjlbPvpLYMhQYcQf3agKveLjei8onwq0/9G4nV5TOyrQZch3xWlwZtGiFVSJfm2MRgf176VC0nTBCcfkLxbVMBHRKDrXwiGb59bPElIhwyXAhNoz4o5rsJkJvmPulYHr/iFO0q6p7XqH4Nr4GaaLFdQ4rFxg5/ABrc8Ne3gEpw/eRAdC6QNL8ldE/w8oT8967L8VqKPE/cEbe1tKxzi3FKfGa0jrXR5vI2wOBFc5CwL9AEylP0/0BKQ5KjuwGgQ15eQt1TfHg0Bjkx2khVMrWjAMmYygAMtRlQZvpJBYKwiWoFdWSGoNvbIUgHkvaR49MGSDJkVd/FkukM6FPcNUFoTcVpXHyEyKOOVzQ9oSxqhhb6x3zIO9NF7x/iqSEVnunl43VdjUiMoYiJZuFnxmqY/OSx5BSYtwKO3TwkH
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5038.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700021)(18002099003)(22082099003)(4143699003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?pnIc7P1Up8aGk8pC5DTZyzpVBMbTcudBmBBR6WpUwfIylYKyJ9E1mHLM3yRX?=
 =?us-ascii?Q?4qOinM+ugFxlXEgAE4tK5Y2a10OHdQePecutqGK7wQFBj5VWqQKTcSaLDXSC?=
 =?us-ascii?Q?X/9zRjTeo5ZeIBVEUCmwYs7w7E/VnGIWxNnwA3TTv3IG8CCa6f5H/0ZMoqUm?=
 =?us-ascii?Q?w55aOyTG81uTKCZgIJPblejkTH5BuOmVCoVkGZi22s0JLkBzek/QMPoVS/eu?=
 =?us-ascii?Q?qy7VlE8necp8xKx9Zgar84xRFNBIslEuEKgZiyTjIJhpm+O1AT70cg1s8joQ?=
 =?us-ascii?Q?T1Jg4P7CjVqEUIGr6/Z8K9kQ38VXnfxL+G6YrqDvjpxG5LdRI5//814cGGbL?=
 =?us-ascii?Q?JiA2wxukcvOZnudz31Ui6vy1tWw+cCnxd5v4lFfjLrECP8eCm4+YH/hNeoo0?=
 =?us-ascii?Q?Bh1hGEl6ZJE5AZxgkSLqVRwVANPLJgRHtEnP9I8jFPm7VtW3cIyUMjUTC2UC?=
 =?us-ascii?Q?TswlF8xoxU4gOIQMV8vz25t4AVbqQgmsuT2GUSV9RQF62BHV0vJsUvnOIsgp?=
 =?us-ascii?Q?NXrXoRPb86DB+NIcuQ7k/L5tm+yod2jN6as3D98iBAWd9Dyag8B2U8+C7o0O?=
 =?us-ascii?Q?mIpCRWHRAVmIQT+ZDH8sEzeK1ruQK8QVwBdA886qYLzqaJt9NyHHheHcBi+N?=
 =?us-ascii?Q?/AN8/2Wn0gjcd5GN3edVnGJ0hwyhbw0udCnBiCDbjJnTSFYGqPsC85gssvpi?=
 =?us-ascii?Q?n/uqZ2iHT6RBD1fxU7F7WrHFv5ZcRe+mXK6HOZKLrMj24n8+hnd6PVwVD0Xu?=
 =?us-ascii?Q?MkGgOC9ZO/WyhUPggLo+cZRSqtyI+fm8pu9L9OpcQyjilDjyQSCEM45gh6jL?=
 =?us-ascii?Q?9YSBmte9FP0U2LbZnJ6lLNBcIw35y8exPy/ls1XY2i6xRMyrZkwd7KnE6pbH?=
 =?us-ascii?Q?JcEWUtTqTrNQkugkd1518vzk0cfxVs2ZSuSp+NSGKq1FyDZEiuAPbvzT2cAD?=
 =?us-ascii?Q?JDLklmyoBqPgy8kN+As5pv+Io4XY8sRo3aeLdRAzQb0I34iqXGNcdn8MaeRD?=
 =?us-ascii?Q?VYLA2VlrtIBzK+JGXpYTmGp4nLvmNCOv9iAO7VEtn1szyklVAxBX4Ws1SzTh?=
 =?us-ascii?Q?zlqsqGgb4XRcC5znoYWb7q4jaMxgV22eIuZPDRc5NHVKnpcCJdIX/86Md9ib?=
 =?us-ascii?Q?NuOkPj9tJXoIXT4VpNWyrUwFDxGq9L7vyPq/hWlvOaXaYvrFARLINNbe9rCA?=
 =?us-ascii?Q?OvZDqC9g1ZZrAGMrvoc+HX0Ykho3Gk/IT4IoXyGEooMvhIzloWvhA/Xjbzhz?=
 =?us-ascii?Q?qbFmnrGSpK4xoHOPUivWihngc6KTw5BWK9cGTckMqwg6IrUjU89rFAie/iBE?=
 =?us-ascii?Q?TTArat9d3NYpX6dZ1aiTKB/UiseEIiuDrFQOYFhw+1XZPjDxuCvCFLfPux60?=
 =?us-ascii?Q?79jRnO8kPuFcT+PKBIRErZSj749T2qHnhzPUvcMyN+OuKGykZiWKxtowDyTn?=
 =?us-ascii?Q?GKNv2rqVDX+gO1Or7h8yieYkQZX2LC+zn9+6eSCUgsYkzHIyp/OKikzi/4Ly?=
 =?us-ascii?Q?194zE+mBhuNglOD2mnWwekeXFHoQEVp2EB1jIhthwoXR0OR7Qxs0DFLHvCkP?=
 =?us-ascii?Q?3dPXt0SOYv0sVMrFGn0No7O0rwu66v0/k8RV8K8/UeO+CnTRmIoZ1J0cxpHm?=
 =?us-ascii?Q?VumYTzKlJpI5kElWH3vlXz+vSKRFW/xEgHgPXKIxfX6Y6r8I1nh8ix1zrj6l?=
 =?us-ascii?Q?HxhuK4H/Iv2dh8nKFYEqj9069nFyU2Q8V7to3ym6j30AmLhs?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5038.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0ee6c9d-bff9-4613-4cc9-08debd99137d
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2026 15:43:48.7260 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XnttB5HSVEGSqh18dx/dL4ZK9vs6oObs8Dz/kfmYEEwYiua5wff9yMwFvP6DYvyOt4JFc4LIsM7aNSe4oytEwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9500
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

AMD General

Dropping this patch, as already covered by patch "drm/amd/pm: Use strscpy i=
n profile mode parsing" sent by Lijo.

Thanks & Regards
Asad

-----Original Message-----
From: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>
Sent: Friday, May 29, 2026 1:45 PM
To: Kamal, Asad <Asad.Kamal@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Lazar, Lijo <Lijo.Lazar@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com=
>; Ma, Le <Le.Ma@amd.com>; Zhang, Morris <Shiwu.Zhang@amd.com>; Deucher, Al=
exander <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amd/pm: fix off-by-one over-read in pp mode

AMD General

> -----Original Message-----
> From: Kamal, Asad <Asad.Kamal@amd.com>
> Sent: Friday, May 29, 2026 16:07
> To: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>; amd-
> gfx@lists.freedesktop.org
> Cc: Lazar, Lijo <Lijo.Lazar@amd.com>; Zhang, Hawking
> <Hawking.Zhang@amd.com>; Ma, Le <Le.Ma@amd.com>; Zhang, Morris
> <Shiwu.Zhang@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>
> Subject: RE: [PATCH] drm/amd/pm: fix off-by-one over-read in pp mode
>
> AMD General
>
> Good catch. count and i are unsigned, so the concern is underflow of
> count - 1 - I, if i
> + 1 > count, not signed overflow. On the sysfs path, kernfs
> + NUL-terminates at
> buf[count] and count >=3D 2, so the whitespace loop should keep i <=3D
> count - 1, but that isn't explicit today. I'll add if (i + 1 > count)
> return -EINVAL before computing len and keep buf_cpy[len] =3D '\0' for st=
rsep().
>
> Is it Ok?

Looks good, go ahead please.

Best Regards,
Kevin
>
> Thanks & Regards
> Asad
>
>
>
> -----Original Message-----
> From: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>
> Sent: Friday, May 29, 2026 12:26 PM
> To: Kamal, Asad <Asad.Kamal@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Lazar, Lijo <Lijo.Lazar@amd.com>; Zhang, Hawking
> <Hawking.Zhang@amd.com>; Ma, Le <Le.Ma@amd.com>; Zhang, Morris
> <Shiwu.Zhang@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>
> Subject: RE: [PATCH] drm/amd/pm: fix off-by-one over-read in pp mode
>
> AMD General
>
> > -----Original Message-----
> > From: Kamal, Asad <Asad.Kamal@amd.com>
> > Sent: Friday, May 29, 2026 14:18
> > To: amd-gfx@lists.freedesktop.org
> > Cc: Lazar, Lijo <Lijo.Lazar@amd.com>; Zhang, Hawking
> > <Hawking.Zhang@amd.com>; Ma, Le <Le.Ma@amd.com>; Zhang, Morris
> > <Shiwu.Zhang@amd.com>; Deucher, Alexander
> <Alexander.Deucher@amd.com>;
> > Wang, Yang(Kevin) <KevinYang.Wang@amd.com>; Kamal, Asad
> > <Asad.Kamal@amd.com>
> > Subject: [PATCH] drm/amd/pm: fix off-by-one over-read in pp mode
> >
> > After consuming the leading profile digit in tmp[0] and skipping i
> > bytes of whitespace via *++buf, buf points at original + 1 + i. The
> > number of bytes still inside the sysfs buffer is count - (1 + i),
> > not count - i; using the latter copied one byte past the store buffer.
> >
> > NUL-terminate buf_cpy before strsep() so parsing cannot run past the
> > copied payload.
> >
> > Signed-off-by: Asad Kamal <asad.kamal@amd.com>
> > ---
> >  drivers/gpu/drm/amd/pm/amdgpu_pm.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> > b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> > index 60db9b66d08c..450ecb188aed 100644
> > --- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> > +++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> > @@ -1379,6 +1379,7 @@ static ssize_t
> > amdgpu_set_pp_power_profile_mode(struct device *dev,
> >       char tmp[2];
> >       long int profile_mode =3D 0;
> >       const char delimiter[3] =3D {' ', '\n', '\0'};
> > +     size_t len;
> >
> >       tmp[0] =3D *(buf);
> >       tmp[1] =3D '\0';
> > @@ -1391,7 +1392,9 @@ static ssize_t
> > amdgpu_set_pp_power_profile_mode(struct device *dev,
> >                       return -EINVAL;
> >               while (isspace(*++buf))
> >                       i++;
> > -             memcpy(buf_cpy, buf, count-i);
> > +             len =3D count - 1 - i;
> There is still a risk of signed integer overflow here, please review this=
 part.
> btw, the variable 'i' may be greater than 'count' ?
> >               while (isspace(*++buf))
> >                       i++;
>
> Best Regards,
> Kevin
> > +             memcpy(buf_cpy, buf, len);
> > +             buf_cpy[len] =3D '\0';
> >               tmp_str =3D buf_cpy;
> >               while ((sub_str =3D strsep(&tmp_str, delimiter)) !=3D NUL=
L) {
> >                       if (strlen(sub_str) =3D=3D 0)
> > --
> > 2.46.0
>
>


