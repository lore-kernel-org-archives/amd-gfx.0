Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E15BC25B74
	for <amd-gfx@archiver.kernel.org>; Mon, 27 May 2024 03:39:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4DA8A10E132;
	Mon, 27 May 2024 03:39:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="26m40YTo";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2048.outbound.protection.outlook.com [40.107.101.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6C84310E132
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 May 2024 03:39:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FzUpoM7Hl+LBG4JEelB8qLVn3et6AQ4/Qv1K/3Mq6yK2Iv7gz6qupMeQ8v5W88mMut9NsNEL4LvkJ3OE+m2cM8L9XoecUPuvy+Z8akEHuvoep4tCilgmduSPGrR+r8/FY8X4m7qdCHu5ZVer7J7KwbAdnlP5iOoQDmCDPq7nzUoSA/dCCefr3+6Br9JKKYVOxgpzYaPaCRVGDgKL/o6XxGKIAoLHxFYHEIw/CP3vXYySCjB03OErs8eavdqBYncZiXmR6ygF5swvh3SNyvsMPIP91H/zZc6SG2R2MZnORxNzQMS/iRQE0gDO71VCIUYXMYm8yprbUnSWuLKjHgkthg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nPA92J/s6nMUao5zk6IQYqxAjsjlQpEcK+V3B1ZAiHA=;
 b=a3RMn9cNNHpbD2dDHaypHMxTiDbgubsFkIjVN8qRt8wwzcjVI09JexAwC7pjN8xOLG/XGkiqEZ+BrH1BJ7vfn4WaidMzEBvlgN7KssID+q22AkBpBnoXu8yLSK+wto5S0Gc1y5fyOKsiQ2KCNRA3Bf1JMGy+tYYvYwEm+UNLQyvs15l3FP7MJZwCeypCWCseYq9wSfrvLWYGtvSgW2e8LbLeBx3tDOVBo+yB7sU4Wu0GSnZpTWk0ncSKTbBJiRYmQjaRQKjKzNEz5kQ5PRORU9Xx4ox4nU77axwjf9BdC7VqNrg46f5TrrMFMRlq0oix8fDBsGhJTXxJdDmdGygyGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nPA92J/s6nMUao5zk6IQYqxAjsjlQpEcK+V3B1ZAiHA=;
 b=26m40YToilPi6FwQVdaI2LvVYVFVeZUvRvSRJLFvsCw1SpRGz5ylREcPNveR3qDmtXxHPtKfCzyGGntOt2NPJ8zD2mGrLq+/ihutA9w/sWxRyTCaTA1CguYonjdwnd9dUsxmaRmMW0dQ84A/F6cOAWPhKlE6wufr6hj/9/h4nZg=
Received: from PH7PR12MB8796.namprd12.prod.outlook.com (2603:10b6:510:272::22)
 by SN7PR12MB7956.namprd12.prod.outlook.com (2603:10b6:806:328::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.29; Mon, 27 May
 2024 03:39:05 +0000
Received: from PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::910f:c354:ea0d:1fd]) by PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::910f:c354:ea0d:1fd%7]) with mapi id 15.20.7611.025; Mon, 27 May 2024
 03:39:05 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Yang, Stanley" <Stanley.Yang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/2] drm/amdgpu: add RAS is_rma flag
Thread-Topic: [PATCH 1/2] drm/amdgpu: add RAS is_rma flag
Thread-Index: AQHarPhDSbOnX8dY+0S+Y2HWoRe0D7Gk2BuAgAWbjDA=
Date: Mon, 27 May 2024 03:39:05 +0000
Message-ID: <PH7PR12MB879673AD123C1C8789189DB6B0F02@PH7PR12MB8796.namprd12.prod.outlook.com>
References: <20240523100148.2457-1-tao.zhou1@amd.com>
 <PH7PR12MB7988A8EEBFB64B5F9ECE70B39AF42@PH7PR12MB7988.namprd12.prod.outlook.com>
In-Reply-To: <PH7PR12MB7988A8EEBFB64B5F9ECE70B39AF42@PH7PR12MB7988.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=8466b0d3-ce4a-4ef2-a3d4-5ee580aa1072;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-05-23T13:51:47Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB8796:EE_|SN7PR12MB7956:EE_
x-ms-office365-filtering-correlation-id: 7681aecd-53f9-4abc-fd02-08dc7dfe8ecd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|1800799015|376005|366007|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?+DzU1pckhSEzWwQ4LVlpEt4y5Ll2lb06o7IA1tMfUTtaIUmeVn9yePozn4+W?=
 =?us-ascii?Q?4oBqg424JDxmx0nmeBeR2Db16EC92khr0rJPSYEBiwqPeEQPF8XCHA81GEdM?=
 =?us-ascii?Q?rag8on3z4OgTxVawy8fqMNTvIysQ1+E+362IjbLQnMy7371IFPDREfQ07Mqq?=
 =?us-ascii?Q?DQqye7huwM3/gk4YxdT9fuSN1JarKlDtQp4YOJYxOIceuK+PQ8Qp3/e2Jo5d?=
 =?us-ascii?Q?txGhxelBaaZF2zZ+tAMN5tXuiYc0B7Ry6oJzRTKgSQjSAxm79RqHwPIYMEK7?=
 =?us-ascii?Q?MQeSxJjA5xCaQ4jg/iyFHBCn6WHrnnVFcR0v0P06rN5b7TBvrSFOvHfEWdRA?=
 =?us-ascii?Q?ZJfIbtSbBMsIF9ZSK2YtIPtRkw3m6K3lontyn5t8zYcGQHnv9Am9FWhIyDQV?=
 =?us-ascii?Q?i3T3a0tGweUU2n6AcvGcjTIZEXusmgfwBGTrBOLrwrX0qAIubEzIhWDAipSQ?=
 =?us-ascii?Q?fkb3NYGDvueqgnRi4edKQKN/dCMpTwzru5fFfNLKofgW4Mr4/1wkTxnny0kk?=
 =?us-ascii?Q?P70+N/Nq0nBwXCaFQ3VP6ndovWgoT+rsQ+PaHk9BVcdmVim9lNUnJ1kIeLfH?=
 =?us-ascii?Q?GyItPM7is8Svyu0bHmczQXEnWiIPhhgnB3O54ATnPF/8gLsnX2Q/9ETXZoiw?=
 =?us-ascii?Q?KUYZcJbeXHRmtBCb3LTF8vA7gIi06i4cX1mk4YHT618fgEZSsp9IuhrSqLPD?=
 =?us-ascii?Q?tqgV1zbTHZIodtqC4B9GtHwQDs7MUbp+CmfIPpvaAOEubkHXnPfxFzPh2sTY?=
 =?us-ascii?Q?XD6U/O8+xOMMboA3I0wEy79UKvqi2NeAo2L0IfOIs+/5RuSWDBrMc6ospMjd?=
 =?us-ascii?Q?IWPTjk5xhtETYsaTm8DTmvxmBU0lVW+q8b+bPLzv3xCTANEMO8hD18Mm4nJH?=
 =?us-ascii?Q?bQomfppiCLlRjVMOb3pC4vj7vkulI2Xjf+eOJmVK8lzJcZbRsIj+c3Ul8hA/?=
 =?us-ascii?Q?jvu6vCTXHm0jKURbzSTj86w9E14HJGuR4DImQCje8XnyEtULUEvcLX9/XNoo?=
 =?us-ascii?Q?QzkO9FvVU+/F6IR4AqeqlvRTtszm0DZMqLNdDA/lzCHD6J11Ag4SMCA6iMDi?=
 =?us-ascii?Q?bO2Y+iuB/RQqrqprTePzduy97MnPQJMg4+leoTBGoDO7/7v5Hye5QKuIPz96?=
 =?us-ascii?Q?nNABroazBSDIJ6ysc4A0oh9Jp89hXxtxr1J9Yz9iNBbZrg1eog6VhsKA6tFN?=
 =?us-ascii?Q?Gw17t6gjQMGg3/XiwsaSm/PTBEzj9RsSNLuGj63MBEp4tRYxh9CVdQmPle8Y?=
 =?us-ascii?Q?a9isLB+Mh35WJ9Hm1kM48vqFOsME/McehdDPr6ayjcz89UnRE8uUmxTQe0dD?=
 =?us-ascii?Q?4o4+C3QS9jYwy8ImU7c1GbxqcaXe9dfpT0gGk03O/KhauA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB8796.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(366007)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?H+nterq/k0kimPrcOJx2H+PH9y/Uv6IufTMGd3+SRh8VLFyXoMjbFzRU2sOC?=
 =?us-ascii?Q?s2PIBJpfxIv8oUgOlyDhDdSUPshtEOG0aRC/A8zpJQgNt/egIO3UwgUPUJ54?=
 =?us-ascii?Q?0uAOeAEac48PtLyOQJOxFaJ1d5VuHfL7MlBgDs4aT6ugfSRGBlrdINY3lQtC?=
 =?us-ascii?Q?KIDNOTCZvXyIuvAx6RVNqoCn2AsFdGGqKxfUCjsl1tR6gXkrs1yaGM7Hi/9b?=
 =?us-ascii?Q?KMkqus4G6JUR49Io/FmxMDaJNnnkeubP34dl5QEp62HptuqlCHw1LU6+4cuq?=
 =?us-ascii?Q?GyW9+CUAMJzdTFd8xXG+vTkbCYQKKTbKJFkhnY6FXJF5ktvVrihiIgXqI2KM?=
 =?us-ascii?Q?9MGaZBvI/S6eRyFluiBekqoejZvJXmTc3GK01vT82VqXneePDgeMxd30pstI?=
 =?us-ascii?Q?hiRGc6RY+tVaqCJNVXaqUSsf8A6HAIxotHJHvqQ9BzFTZblHr/lu8Q2z1PS0?=
 =?us-ascii?Q?tMEeDWqPtSTgi+bP1ehbzcjymlAFoDYn7dzr9gBj/AgooLG8+rbLMI4s1eMs?=
 =?us-ascii?Q?EAYITCa5GyydpdMoC48X8wwdovgwj7DrffghAX4qbp3tuYZjEfk8k8ylJTop?=
 =?us-ascii?Q?hYAaR35DyDVUAJ3ivNBQfSr1lhXaRMhpI06TwyWDWv2/WjokN5sLgDIumjfJ?=
 =?us-ascii?Q?TwC/+jcXENHqS61hUQZyhvbIjXamRJNA6eIQDz/FNIBqb2ssnFF/T3nHK6N+?=
 =?us-ascii?Q?wGeFrSSWcPdzNwv9heY1CB/6td0E2fatzVLWZ8XbscSWxP1hfPa4cyFzW5YQ?=
 =?us-ascii?Q?iO2JLDvt44ArmBLMp6Rwdp1yCNAoQFFaAL8Ne0l8eJTWC69j4U0QcBVwSyn2?=
 =?us-ascii?Q?DfR9wVNWn27HDxmJH508bjIa6mnj7FttZfQaICVJtsqBWMuxj/3Qm1KE3U3i?=
 =?us-ascii?Q?c6h3dhIEwt8Miu4GmHh9s0ARVn+dMkotouLCeYqlceiA7fDvqgxKmXeXPz0r?=
 =?us-ascii?Q?nGWZkcbG2bTI8gQRofqYTlu8J1IVbIUCWAlRCfVSqIabJXMOMncT19mC6eHr?=
 =?us-ascii?Q?bifBliFSW6kSWjpyRoXQCvxtlICPJBfTGhQIatysmqZksMgVA+zvKLYblriW?=
 =?us-ascii?Q?iM0GoKgB7+aBE3MuokiX+pha2iTHFfZZ3S4zwzqyQZ5DMH4nfhhZpEQ3LMRQ?=
 =?us-ascii?Q?pmCvA4zolz8RRyEjXi60FU0VuaTRhAtrgMds0mm0IIEXLmzowVzgHUi3VLa3?=
 =?us-ascii?Q?dumzKSN0anW/th8CCPOpAcYv1zyA+SLA0Ww61PbKpjlE4QUJpYy2ZH2FCFLo?=
 =?us-ascii?Q?Fn+PfXOe2hqfhc14J64wRG0N1CqlsjXLKftGBF51Q9CcLTSQ2AMAbjhS/Egb?=
 =?us-ascii?Q?Nv/xVgnb8HQ1yd4CodGQSrPWb8mlaaEiQmcjE4Ak1rJqzwsZo7Mqm78Z2gsE?=
 =?us-ascii?Q?PfNcPAm9pcqTr8vAdJ4itSTDKkuNrhr1EBdj9So0cTbDI71E0GX3dSAp3o4N?=
 =?us-ascii?Q?55bVH2DZrabZ8Mz/3BoX5ujSNf/Rb4shwccKIwv0j5yTZYUKJxi0jtRMx5tQ?=
 =?us-ascii?Q?wNiIIDSaduLlurlcsIKe3InLMtwCfC2W/AHIn9gQ88mxs/3Bbvv9faGtQnus?=
 =?us-ascii?Q?U4eW1erakoSw5F2LLmw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8796.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7681aecd-53f9-4abc-fd02-08dc7dfe8ecd
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2024 03:39:05.0209 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AoMBXQ8Z+0cNnnJSEO70YWiBO2/0UpEviN+qK9l61TUzoIj0rlnMkZN8C4GDhb/M
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7956
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

> -----Original Message-----
> From: Yang, Stanley <Stanley.Yang@amd.com>
> Sent: Thursday, May 23, 2024 9:57 PM
> To: Zhou1, Tao <Tao.Zhou1@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Zhou1, Tao <Tao.Zhou1@amd.com>
> Subject: RE: [PATCH 1/2] drm/amdgpu: add RAS is_rma flag
>
> [AMD Official Use Only - AMD Internal Distribution Only]
>
> > -----Original Message-----
> > From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Tao
> > Zhou
> > Sent: Thursday, May 23, 2024 6:02 PM
> > To: amd-gfx@lists.freedesktop.org
> > Cc: Zhou1, Tao <Tao.Zhou1@amd.com>
> > Subject: [PATCH 1/2] drm/amdgpu: add RAS is_rma flag
> >
> > Set the flag to true if bad page number reaches threshold.
> >
> > Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c        |  7 +++----
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h        |  1 +
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c | 10 ++++++----
> > drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h |  3 +--
> >  4 files changed, 11 insertions(+), 10 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> > index ecce022c657b..934dfb2bf9e5 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> > @@ -2940,7 +2940,6 @@ int amdgpu_ras_recovery_init(struct
> > amdgpu_device
> > *adev)
> >       struct amdgpu_ras *con =3D amdgpu_ras_get_context(adev);
> >       struct ras_err_handler_data **data;
> >       u32  max_eeprom_records_count =3D 0;
> > -     bool exc_err_limit =3D false;
> >       int ret;
> >
> >       if (!con || amdgpu_sriov_vf(adev)) @@ -2977,12 +2976,12 @@ int
> > amdgpu_ras_recovery_init(struct amdgpu_device *adev)
> >        */
> >       if (adev->gmc.xgmi.pending_reset)
> >               return 0;
> > -     ret =3D amdgpu_ras_eeprom_init(&con->eeprom_control, &exc_err_lim=
it);
> > +     ret =3D amdgpu_ras_eeprom_init(&con->eeprom_control);
> >       /*
> >        * This calling fails when exc_err_limit is true or
> >        * ret !=3D 0.
> >        */
> > -     if (exc_err_limit || ret)
> > +     if (con->is_rma || ret)
> >               goto free;
> >
> >       if (con->eeprom_control.ras_num_recs) { @@ -3033,7 +3032,7 @@
> > int amdgpu_ras_recovery_init(struct amdgpu_device *adev)
> >        * Except error threshold exceeding case, other failure cases in =
this
> >        * function would not fail amdgpu driver init.
> >        */
> > -     if (!exc_err_limit)
> > +     if (!con->is_rma)
> >               ret =3D 0;
> >       else
> >               ret =3D -EINVAL;
>
> [Stanley]: Should stop device service if device is under RMA during runni=
ng? the
> amdgpu_ras_recovery_init function only be called during the process of lo=
ading
> driver.

[Tao] yes, I plan to stop service in resume stage after mode-1 if run-time =
RMA is reported. But I have no environment to verify the design right now, =
so this is TODO temporarily.

>
> Regards,
> Stanley
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> > index d06c01b978cd..437c58c85639 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> > @@ -521,6 +521,7 @@ struct amdgpu_ras {
> >       bool update_channel_flag;
> >       /* Record status of smu mca debug mode */
> >       bool is_aca_debug_mode;
> > +     bool is_rma;
> >
> >       /* Record special requirements of gpu reset caller */
> >       uint32_t  gpu_reset_flags;
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> > index 9b789dcc2bd1..eae0a555df3c 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> > @@ -750,6 +750,9 @@ amdgpu_ras_eeprom_update_header(struct
> > amdgpu_ras_eeprom_control *control)
> >                       control->tbl_rai.health_percent =3D 0;
> >               }
> >
> > +             if (amdgpu_bad_page_threshold !=3D -1)
> > +                     ras->is_rma =3D true;
> > +
> >               /* ignore the -ENOTSUPP return value */
> >               amdgpu_dpm_send_rma_reason(adev);
> >       }
> > @@ -1321,8 +1324,7 @@ static int __read_table_ras_info(struct
> > amdgpu_ras_eeprom_control *control)
> >       return res =3D=3D RAS_TABLE_V2_1_INFO_SIZE ? 0 : res;  }
> >
> > -int amdgpu_ras_eeprom_init(struct amdgpu_ras_eeprom_control *control,
> > -                        bool *exceed_err_limit)
> > +int amdgpu_ras_eeprom_init(struct amdgpu_ras_eeprom_control *control)
> >  {
> >       struct amdgpu_device *adev =3D to_amdgpu_device(control);
> >       unsigned char buf[RAS_TABLE_HEADER_SIZE] =3D { 0 }; @@ -1330,7
> > +1332,7 @@ int amdgpu_ras_eeprom_init(struct amdgpu_ras_eeprom_control
> > *control,
> >       struct amdgpu_ras *ras =3D amdgpu_ras_get_context(adev);
> >       int res;
> >
> > -     *exceed_err_limit =3D false;
> > +     ras->is_rma =3D false;
> >
> >       if (!__is_ras_eeprom_supported(adev))
> >               return 0;
> > @@ -1422,7 +1424,7 @@ int amdgpu_ras_eeprom_init(struct
> > amdgpu_ras_eeprom_control *control,
> >                               dev_warn(adev->dev, "GPU will be
> > initialized due to bad_page_threshold =3D -1.");
> >                               res =3D 0;
> >                       } else {
> > -                             *exceed_err_limit =3D true;
> > +                             ras->is_rma =3D true;
> >                               dev_err(adev->dev,
> >                                       "RAS records:%d exceed threshold:=
%d, "
> >                                       "GPU will not be initialized.
> > Replace this GPU or increase the threshold", diff --git
> > a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
> > index 6dfd667f3013..b9ebda577797 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
> > @@ -129,8 +129,7 @@ struct eeprom_table_record {
> >       unsigned char mcumc_id;
> >  } __packed;
> >
> > -int amdgpu_ras_eeprom_init(struct amdgpu_ras_eeprom_control *control,
> > -                        bool *exceed_err_limit);
> > +int amdgpu_ras_eeprom_init(struct amdgpu_ras_eeprom_control
> > +*control);
> >
> >  int amdgpu_ras_eeprom_reset_table(struct amdgpu_ras_eeprom_control
> > *control);
> >
> > --
> > 2.34.1
>

