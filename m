Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D5C2C369D5
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Apr 2025 12:40:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3838E10E1D9;
	Mon, 28 Apr 2025 12:40:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GMSBST8d";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2070.outbound.protection.outlook.com [40.107.220.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8940610E1D9
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Apr 2025 12:40:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M967wMWDuh+4IxUQ1G9KnOkQk5dabFChZA63Sdth41/H2Baz+ycaumvXdZ2BX6bzVCY2Fp5Kl8dy3dSc52YNjxMl1nRisb6aa9RnsBK67b5sdzzsKIlZiNZnYjQWLeBtBiexOuiC0t77VzdNN4eTc/wfF5qScPaL7plmc5HhzaogaQ++Q1KxXc8VQ8uaP0oa4k5EBpcv94nh2SLRxmuZ8w2CHLJTiLiLpiABYPKGfh040g/gwbxUGasT2f6uxdNU2J2TwQC73+vASD5mzLTSwOhU/GBTkcY4mD7YdAX9vOdHsWtWIrnGFj2JEEAMPsyvTwPSgQxwQk2hMWqgA+4CFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WeCKMz26inNr5AKS584uBqvz6l44jTMC61mNNN98KGA=;
 b=Sf90ay1w6B/YrIBkf2tPlnZXEIbkn4lNCcyco0yRt/vnAWBaSU95m9N9HP1uB/FM9V9IsV+fqP+/BsibRjyDRApfAeg01TCCuqtgzsyAM4Q5Mlt4Hu+UMGKM0De9CTS/TmDdOmFsVQrC+JsZEycD2KHgpbORtILn1TRIKAQGBqGqzQ1BHUuPukD0oQ+H+FDQ9RYDdDrjH+a83xX3DoHrzrwB19SipSP0KyYk77J4NUAngMpoXntGbAVG8ncXx4hxi0a+XFnk99q8AZpEQLz0lkSnTcIlnA9U+KZG1KYDvmHC2yGrPi0pOrwKtDXDXsXgFPSaynrQBWjCP7flh0nUVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WeCKMz26inNr5AKS584uBqvz6l44jTMC61mNNN98KGA=;
 b=GMSBST8ddIFXOqx8TybUEXW9CafDjM+OknQzJcTpJl+nnn8vMFBYiuGe+xWd9sVBcqEL0toKuWUaKx0D2Zv9C3ws4EyR+wrEftLHWgBfNFwenAVgxMfOKx82dSPj03tvRq6EB9UOg/yDCM0d41BojBRqv3qT3il82WkDZsR7OvE=
Received: from DS7PR12MB6005.namprd12.prod.outlook.com (2603:10b6:8:7c::17) by
 IA0PR12MB7627.namprd12.prod.outlook.com (2603:10b6:208:437::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.34; Mon, 28 Apr
 2025 12:40:19 +0000
Received: from DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb]) by DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb%6]) with mapi id 15.20.8678.028; Mon, 28 Apr 2025
 12:40:19 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH 2/2] drm/amdgpu/userq: take the userq_mgr lock in enforce
 isolation
Thread-Topic: [PATCH 2/2] drm/amdgpu/userq: take the userq_mgr lock in enforce
 isolation
Thread-Index: AQHbthDBFWP7Ud6aMUqEm/PMjhzohbO5CRCA
Date: Mon, 28 Apr 2025 12:40:19 +0000
Message-ID: <DS7PR12MB6005BEB0DC2C82CA1DEBA56BFB812@DS7PR12MB6005.namprd12.prod.outlook.com>
References: <20250425183428.162862-1-alexander.deucher@amd.com>
 <20250425183428.162862-2-alexander.deucher@amd.com>
In-Reply-To: <20250425183428.162862-2-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=93ec6860-4d1f-46d8-9921-b997f4ba1d62;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-04-28T12:39:43Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Tag=10, 0, 1, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6005:EE_|IA0PR12MB7627:EE_
x-ms-office365-filtering-correlation-id: 83664797-b72c-400f-0a83-08dd8651d5fb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?C9W5AlfiR8pM+q8kd8pyM3XVbI5xmjVUklcneYd9gPzwrVLhIgthsAzP57bD?=
 =?us-ascii?Q?xR2vJJcgzLhd2pYWiLzkWOkWts3OC0BZ715HX+xUFc/8cSuYH5T64cNqKK2u?=
 =?us-ascii?Q?jYVOQ/FV8Df1Q3KpTEg/GLql4143TjRl8YGFnIoyuLfomcJ9O1Dy3iY9/APz?=
 =?us-ascii?Q?owobdKZh144wh0J57zPWo6zsKwkEpdu5HEtjebbuurTcU7pcUdMyW6KMbx04?=
 =?us-ascii?Q?yxJcAVGj45ojXPqapNlTASVdQaWdzGFrZabN6RV08GU1M+GQ41Gri0ZxYQQ/?=
 =?us-ascii?Q?G+FPLuBywkK6oei5N37JavZyTbCOPXVuI1+cxrYzPK5ku1DZSYR2QRT2Nk55?=
 =?us-ascii?Q?MSfftoHJu+ctQF1sARS3BjS6/kQQMeq7Ea06t2M6VCKIGLGj0PlmmYLvLLwl?=
 =?us-ascii?Q?+RaKdwoQB6dvGnCYKoO7/OZW00z04kN/RiiL72i+duOavyD4TMksueGPEmJ9?=
 =?us-ascii?Q?cEwFGp4nxFgtkvFj5npI72PuAJ7Jwt/oIsIuJnT7SbwafxYY10al774/0Dsu?=
 =?us-ascii?Q?N5BP9o1FRQoTGcSWCHsMrh3zvqsRjQPMhtuWi92bDQAtHl8IYvLcsjSeJWAT?=
 =?us-ascii?Q?H5LRpUQyodH1xKAiWZN03QmtI167N8GsYzuNlIoDpS0/hXl75Q9CkAxQYhAC?=
 =?us-ascii?Q?rut6Fxng5sZG9/ynhviqxCMPDMoU8uUCzJUGXRDrv8mkwiDPjK9XZo8E4vWJ?=
 =?us-ascii?Q?7gE5wtKrM3yxwKBS9tKWlnV8qyxz4Ukbj8WTQ9y3L/8+plTw4p0cqvGcAmhk?=
 =?us-ascii?Q?rDhNKFdOPrgrSkRCpnI6cZxZJRPKgEkhWrW2YJm5w+/BXBIv/28qRo8azs9+?=
 =?us-ascii?Q?Y/rzL6DFrjGLV6SgvKpPEreLDemwA7lfSEPKfrUy65kN/gIwJxIbFcQqND03?=
 =?us-ascii?Q?DcnZs6NGpWASBOZTk5Aer7117AAvsOdvlqmOFyg5zvZwlXzuUIEBll7YpPqC?=
 =?us-ascii?Q?DeJCNi2SV+YVHOH4n8fiu7oyqIqsQQldY2oCwatZeWUjmdeg3qNrL0o5lteU?=
 =?us-ascii?Q?CdbHgzsx0ikYNPkN8zPz/p8Z6LUYF0RWrdOMwQ/kGZ6oxuQBBBOlSWeKAmNd?=
 =?us-ascii?Q?pAM1xJlJYbXvbICuCXaHhnJYF45oi9j/qNLc4qxGWonzwH89z/groKQW2cRu?=
 =?us-ascii?Q?Ml2AuNma3mTFLGYo/0RAB8bTb6+xtUx74fi/FVPZgkA/5Hcd0imQo0CJI6Nh?=
 =?us-ascii?Q?9cNFGt8kaWwV9cXogYi5E2QtF6s9FVInQ2rY785BWawSIDSJQ0s9Xw4/ULGQ?=
 =?us-ascii?Q?60LlNykR4jRMs/UR1qaiSEeIYfhPXipgrWQgpnUs2NA4BmMGtQkTHDU+0zey?=
 =?us-ascii?Q?QKYDCtGLl9GiUS+g89dO+bDjcrcZwOQkiLETLO9rJ1uyOdai8Mgp6eTJ4bTi?=
 =?us-ascii?Q?6B9bpY/tw7oUgBtJ/IamVfg9kC02Il+f7763MlTmV+lfGCjzOUlthtHtoUm2?=
 =?us-ascii?Q?RcelaEtts4tL8FmcWTEW2+cORXMtPlGOnOLeUV5xt2XWWTLe3RVhA4buyN88?=
 =?us-ascii?Q?Uq5FL7bVSx/huNc=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6005.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?rO9dQr8NmYbBbj3Iia1PQUegTZhhPEywvQMaoGtL5Ur3U3q/EplCwuICyy5G?=
 =?us-ascii?Q?dzwDpYqt8IbhKsir3FNeo35dZfiIS13TarDjaMaFPlum+bNbJgnBnzsYYKCW?=
 =?us-ascii?Q?4cw9cvLveN+jOb+L26XlcH89eoJobwVNFKI3Q/QFPFEsdNK2VyvAZIZppWFD?=
 =?us-ascii?Q?q5zjDsceD+x1NfPj5bcakitXPIFFCXLUEmwEf6cC0jYl6kzxuixChl87HR1H?=
 =?us-ascii?Q?RppBL04+jaFAi4VVmhHXxK5wTbCsJx2N2CSygDmw8Pmvf9mHiy9OmN1SWtgR?=
 =?us-ascii?Q?ytfqR9Ib04dE3zzDi5+DmZwucrTAl3kg9VImcv8RuXJ1/Tq2iB8DHOFte92h?=
 =?us-ascii?Q?eE7zRWj3/C5Z7H2Yl23lIKbKkK67DYfqFokd9uc2YVFauDxjDwh/4c/7fOHL?=
 =?us-ascii?Q?t4bynDMEG1uRwUzANbsBlgFJ1gNCGa/srrg7iodlA+lQMfjBZo22yzsPrnQJ?=
 =?us-ascii?Q?SOxpJMdXJ5vjJoJtI1WnPbtVFLt46Q9ZTDlR4UKXVGGyDOaTflS7XKw5EY3G?=
 =?us-ascii?Q?0ZX9sRMpQTTC60/TRCiBAcmkRN261zB81E9FQyHf+zWedlxyGlXxTgBqd/ud?=
 =?us-ascii?Q?akaIhQPvMyYlrjaiQwqxxGx3Zaz+D1vxiYmDFlTG9bLfFjZ7cy0nYMch8FCX?=
 =?us-ascii?Q?zxm0JDUtPyBuuvKaOQfNut08kYPjKQ1HFR1YuU8lRPyPRWYG4d9Ebfee68Hd?=
 =?us-ascii?Q?cJLxDOfRZubSjK+Ib0tVlpaissVI0sr5fMvOxcATkkFJN+rP0G81e3yGxQPV?=
 =?us-ascii?Q?DxLEALN6ywvTkRsZxNIw+B3nJf9ULHmN6NeybmptJtAR7oCMmVUyKXuW9paP?=
 =?us-ascii?Q?owABTs4/NvPrIvj/EKlcETrM3vHEBP+/7hFqAyId8WXMYH19PPMK4PwQpTHj?=
 =?us-ascii?Q?nrUFq83hCzo0uH2Xa9ZRWEQG8YSXYOFyOveTPrA/9B3GJN3eEkKeqP9vSA+G?=
 =?us-ascii?Q?tvXBA6VuSbxtTijhRqvEuph6J2oV/sPabUrTC31cRTO1esS63LoU1qRBwr9m?=
 =?us-ascii?Q?bwISW0N7AOyyr2K6pCC5MhGq2YXoc3rUgGI6yq55YItvEW1afwKW+TIN064/?=
 =?us-ascii?Q?UdrjvFvaI7zzLF279h22Ibhq377+pEc7DOx/jRARgCdrOBc3E07yzHecW8sE?=
 =?us-ascii?Q?G5G4myR5XcxQowSrkvXJw1j75ROBFbEVkbEfU85Y3Q5fhp9fQ/Z4UuSVfZiN?=
 =?us-ascii?Q?ncWoJgUrwNpr8UrfASzX47OLJ5y6x9Z/AsKIjZaEY3EU8cpkMNgtewT70yl4?=
 =?us-ascii?Q?Kx6k/0mgUoQMUpyXSaAnQmZv5YueLAQ4wXD/R8LxZcKzSIpJ41778pIZ3Hf8?=
 =?us-ascii?Q?d/7HTPgYOzloGvniZoKEFtj6N0dlYDjsEzbSZcUVWcCx0UT8USHiFMI4Tpek?=
 =?us-ascii?Q?gyFKxziiwWfAJvPPfyMxNgc0EQaCN5fgA11i7eNI/KYq/Gj5Idf464M+7sqU?=
 =?us-ascii?Q?h6YjkvinG8WFd/I8FeZgGySk8YjncRV5q4xGNnj5VC+s4yny+X18cutBJRDe?=
 =?us-ascii?Q?Lm48Er61O7mIKzgW0zYfrrwCu/9hueovZKNMVDZUYZhoxBhw86aO7ra1ujPF?=
 =?us-ascii?Q?7vdNwZFWHzEfv1Qnt3s=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6005.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83664797-b72c-400f-0a83-08dd8651d5fb
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2025 12:40:19.6734 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ew34Kxy17IRwmIEb0tzpwW6/F6HMdKqiKlMT6OTeV8vgISbnEKy7woimz4ArDG3k
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7627
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

Reviewed-by: Prike Liang <Prike.Liang@amd.com>

Regards,
      Prike

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex
> Deucher
> Sent: Saturday, April 26, 2025 2:34 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
> Subject: [PATCH 2/2] drm/amdgpu/userq: take the userq_mgr lock in enforce
> isolation
>
> Add the missing locking.
>
> Fixes: 94976e7e5ede ("drm/amdgpu/userq: add helpers to start/stop schedul=
ing")
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> index 1fa9d2be87f39..afbe01149ed3f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -865,6 +865,7 @@ int
> amdgpu_userq_stop_sched_for_enforce_isolation(struct amdgpu_device *adev,
>       adev->userq_halt_for_enforce_isolation =3D true;
>       list_for_each_entry_safe(uqm, tmp, &adev->userq_mgr_list, list) {
>               cancel_delayed_work_sync(&uqm->resume_work);
> +             mutex_lock(&uqm->userq_mutex);
>               idr_for_each_entry(&uqm->userq_idr, queue, queue_id) {
>                       if (((queue->queue_type =3D=3D AMDGPU_HW_IP_GFX) ||
>                            (queue->queue_type =3D=3D AMDGPU_HW_IP_COMPUTE=
))
> && @@ -874,6 +875,7 @@ int
> amdgpu_userq_stop_sched_for_enforce_isolation(struct amdgpu_device *adev,
>                                       ret =3D r;
>                       }
>               }
> +             mutex_unlock(&uqm->userq_mutex);
>       }
>       mutex_unlock(&adev->userq_mutex);
>       return ret;
> @@ -897,6 +899,7 @@ int
> amdgpu_userq_start_sched_for_enforce_isolation(struct amdgpu_device *adev=
,
>               dev_warn(adev->dev, "userq scheduling already started!\n");
>       adev->userq_halt_for_enforce_isolation =3D false;
>       list_for_each_entry_safe(uqm, tmp, &adev->userq_mgr_list, list) {
> +             mutex_lock(&uqm->userq_mutex);
>               idr_for_each_entry(&uqm->userq_idr, queue, queue_id) {
>                       if (((queue->queue_type =3D=3D AMDGPU_HW_IP_GFX) ||
>                            (queue->queue_type =3D=3D AMDGPU_HW_IP_COMPUTE=
))
> && @@ -906,6 +909,7 @@ int
> amdgpu_userq_start_sched_for_enforce_isolation(struct amdgpu_device *adev=
,
>                                       ret =3D r;
>                       }
>               }
> +             mutex_unlock(&uqm->userq_mutex);
>       }
>       mutex_unlock(&adev->userq_mutex);
>       return ret;
> --
> 2.49.0

