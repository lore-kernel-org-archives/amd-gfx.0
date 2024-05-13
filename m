Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E08EAC25B10
	for <amd-gfx@archiver.kernel.org>; Mon, 13 May 2024 12:03:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B38D10E6F9;
	Mon, 13 May 2024 12:03:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZKMRXndL";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2077.outbound.protection.outlook.com [40.107.102.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A14410E6F9
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 May 2024 12:03:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fWNpMXpSs2rMCnSD+JKLz5bgHumTkDca1UX54WUclPtNAm1f3raumFBjbm5U+7LNWoJg8YyM0lypn5HMVcnq/VNnMrwgmVCllpSapXRBGgd+mXwPMhK/BB5OT3LSs762aQUvu3qgklLA6RyjVpovqdRsiNCrtctfkSjflct2ZfqyU6JhvEjgcLhVfyO3SDULLYlWdxdczT/rxD2O6+KDqZyCIUumRi0S0CgJ7Hiq4jzxY+fmw/TESg4nt12LqM1KKzOP00/qchdQsQNorgP8Z4gIB4TuPX70drLo9WnU05FOzzdeddWms9iIn3EG+48l9BEjm7/OWWJFjEgrdpoHlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IlyJOn0KfitQQRzGNlauV9m7Q8QGZ8j6r5ZwddpfoUI=;
 b=OlbvcdA2WCCoXc7eKztrk/Zpds0Pg5ub4T+CA5I+VffqrbjqTItr/VleH0GWM2zHs78W71x3KA17obYskcv/r5ev4i9Ffthd80/JBAHsrMXaVFlTmRBZfVL3YipcUR89MYnby/I9zn+0uW0sVBWHIMHLdg4BT31T1yBucknCf+huVMoUC4Gu1efjjgOSiFjO5ym/LL40M4N5dk1ZqElfDJRx8S+04ayjXCA8+ebNQ8/9LmH+7eUVG0Q63dlI0ebC8Q5rjjLGZYpk0eL7xR2odMUZPLJRZRrz3U98oVE5xWcdbwp+wfMPRQwLgmQRMzBIz48+QJIflooQjDdX7im+oA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IlyJOn0KfitQQRzGNlauV9m7Q8QGZ8j6r5ZwddpfoUI=;
 b=ZKMRXndLmWvW840bTo5jVuiuq1M6KCGD54RxPcA8qN3Qu/xivZr0LJQ8ZM6kNX7wPfOC4epg8gz7/n8kSD7sxXzT3//bgjpeN3C/vVvuxhLkYbtW8S9z1SHKfWnIavYIechwIjC1Krp7NZJVCPOyAVKHtMuFKky3EbgFld0WzKM=
Received: from DM8PR12MB5399.namprd12.prod.outlook.com (2603:10b6:8:34::5) by
 SJ2PR12MB8876.namprd12.prod.outlook.com (2603:10b6:a03:539::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Mon, 13 May
 2024 12:03:28 +0000
Received: from DM8PR12MB5399.namprd12.prod.outlook.com
 ([fe80::fddf:5872:b8e2:9563]) by DM8PR12MB5399.namprd12.prod.outlook.com
 ([fe80::fddf:5872:b8e2:9563%4]) with mapi id 15.20.7544.052; Mon, 13 May 2024
 12:03:28 +0000
From: "Liu, Leo" <Leo.Liu@amd.com>
To: "Wu, David" <David.Wu3@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
CC: "Koenig, Christian" <Christian.Koenig@amd.com>, "Jiang, Sonny"
 <Sonny.Jiang@amd.com>
Subject: RE: [PATCH] drm/amd/amdgpu: update jpeg 5 capability
Thread-Topic: [PATCH] drm/amd/amdgpu: update jpeg 5 capability
Thread-Index: AQHaolkWlolgEJ80kU+AgiwdRYwrq7GVFktA
Date: Mon, 13 May 2024 12:03:28 +0000
Message-ID: <DM8PR12MB539964EEF0C3768E75AA4003E5E22@DM8PR12MB5399.namprd12.prod.outlook.com>
References: <20240509213709.1495007-1-David.Wu3@amd.com>
In-Reply-To: <20240509213709.1495007-1-David.Wu3@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=31559387-aa8d-4b7b-8afb-20dbc45a9795;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-05-13T12:02:57Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR12MB5399:EE_|SJ2PR12MB8876:EE_
x-ms-office365-filtering-correlation-id: c1e5f6cb-e387-4638-63d9-08dc7344b36f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|376005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?M2fNqfxSl+I8xW360OVINyvTBmeaEgSlmTVCdUahC+r/pEuJEJLJa2yY719T?=
 =?us-ascii?Q?eW8ra6PVOciJlE1TBa64UXsnzLdBdzN8ChAkj8kiRhWwK1iKzvNrHGEn9DXr?=
 =?us-ascii?Q?sST4EeqSPl/UF0Ij1PPGEnybIkv78oQAWgiwPTxi+mLsyNpaQLu05qEZb4RG?=
 =?us-ascii?Q?ViFbBJcA6tTWmsg52BjCNd7sI3UwoJTU+bQuOD4Is2ey+DTI2UPdLU9AuA0f?=
 =?us-ascii?Q?SNELzc00ABs5AXTtbkT1993NQFWu4XlTkS8M/vNHz1QvCuvfhGfLLFRwjHol?=
 =?us-ascii?Q?mcqOYkhncNZK5YKo4k2K+j1FrPdEJO4xGzphp7kwlMP0PlbflyuSQNaKgOfv?=
 =?us-ascii?Q?FRU9OfKRLeRZWE1AQWd61OXWFMGE4gNlkEKuWvipbcnhpS2xoSXBCNcnR+Ft?=
 =?us-ascii?Q?6+dZbziPVd6GyxgKHDAQoi1l4dQz+0YezR1zSjjnILkNlBWT+7E7Gr5O5vgw?=
 =?us-ascii?Q?eqrhy9Q39R1vDlor6kJ3EWniGfYzApbaCFVjcC/+MlkbL71Q+pLfPOrkRbtI?=
 =?us-ascii?Q?lke+DLkBTn4AVGkB6sQIxZd91Wi3gv+lBJr8/P4sWKU+u4RysXdHrn5dkU6e?=
 =?us-ascii?Q?Lieap4PpIGK0UjvWNi8DTZqz6WnbK2/Qy77Y+bamSO8vpnARE6prHVxsegBm?=
 =?us-ascii?Q?AM/ck4bhOiQ4YzIgx0A0LLnccasT83ZJrnTOn2Yr50Z1d2LPildRMA3OTkLd?=
 =?us-ascii?Q?YQWzMk7nI5BD3Bm8uGf9/Wm4VCSrDN5vOdMixc3HphIMONxBL1Yal0V2CqaP?=
 =?us-ascii?Q?GP8NmYlT7Bv9F18VytzE8rdYCRc0Ipde02pVeoZjEs3x4rsejuSjqKP3HDCg?=
 =?us-ascii?Q?NLRPN8Fgu445VVcnyumMcfSUbOz94P+BAJeqxjDZFG/yVvmqltUbHkfAcx4p?=
 =?us-ascii?Q?BRgGsQaIpHt65MoXaoVJffU/7en9nPn9IrYL3md6vcd78P5u9zAVxqIqOV6f?=
 =?us-ascii?Q?g4I1Dr8Ie6HZpstICsCKU0Vj+KaAy1sZQsj/Nsx/2AspRzLRL1u179SxB591?=
 =?us-ascii?Q?0kUMgOXavJprFwslXIN7MtheJcvGTUS6TWEF6Pf4RILWtlaKGhjzICWW6N40?=
 =?us-ascii?Q?rkwfLayPM/rme8rUjQiNoScT2eQTmNDYCri8FS+mqeYolticPSvAwLp0stVp?=
 =?us-ascii?Q?O6pdjK36xlwZS6+okeGzNNZMX281M4MrJD/OVdObjpPErk2ZXB63tzR8bdOp?=
 =?us-ascii?Q?gn0bgHs5MjRCx7+lS2/ntEkcdTHYq43Jtcnpud9Kyp2dECnri7ZHJl4Kyk0o?=
 =?us-ascii?Q?ksqjPbj0NKOP0nyITAQQtq176X8xTEfp4MeoWmmU23jy7I1eWsS30WT25tO3?=
 =?us-ascii?Q?mM6HGEfbuamTvi3Vy235keQ+xFV0WtHmp1PCxAKowpvouw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR12MB5399.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?xz1CJra6ClzKHqyTeKJ3nlqMzQ7HeCJd8rAxzl4mWmhJSy4qG+fBTcYlDLNj?=
 =?us-ascii?Q?vx4qbcC0s1Qt3z0H+TQSQ6q22pz1lCffIdZVRLpz4OY7LrwSpzQ90Oa7648o?=
 =?us-ascii?Q?oTlC1AvA9ApOAR1ZkWDIpesK5U0QDYA5KLqeuFkq2rCj9Kne/XguPLQMX9W5?=
 =?us-ascii?Q?DuNoriygv2DCoB/R/g9iDQQbJMyqCaSS0e1B5lvRwLaSdcty3I8NlAK5eNVO?=
 =?us-ascii?Q?MHbcQwJDcBt4pUXaaGT+mAs3+3aoAB3MhU/7R++Zf1Jy++zQG3kpG5FFPwFE?=
 =?us-ascii?Q?+6hSuLKNR2xt0/e4rmrKO7m6QhkBVQIW8wvmUXrYZAoSqImoZZHm3njhU66f?=
 =?us-ascii?Q?7gWCoWfy6JIsniKqW7fWAHL9qKPUKty1J8/tq/RH7ne72uxgbKQprY7fE8tf?=
 =?us-ascii?Q?Wfr+CjWEzyWb1JpEQU/1qrdUi2a7tPdGIRgn3kJzyLyeDPjoOBucXTeWAkM8?=
 =?us-ascii?Q?pyhFu1L2Emeb8PlQxi1312GmaxQ8pTroZFSnvCxDxpBYQgtp0O6wgDqKJ29c?=
 =?us-ascii?Q?NAtNh6OpyzB86x73g1OCSrQutgMmIT15v7mISKQnglwV8L46sAoMFKwJZPe6?=
 =?us-ascii?Q?Msru61l+OEsFlB3B81t+f8HwSuGnlSg5za244Jv5KoSOUofLDcrAj3EK2Lxo?=
 =?us-ascii?Q?p03ab5mcL9g/72HkWFXAeIsqZM2DJcjauE2GiruVXiNruid3bWMzxbGDI/JT?=
 =?us-ascii?Q?RDQliBN6cQVFItI53iQ8qD1wfb2VYJrrp8DYLQDUH2YyUs5Pu5FEPif7rMF5?=
 =?us-ascii?Q?xMxzWO6FGF9TFvdvi1otOL4/AqRos6AOVxYoS0nl+JR5PxFOLr2nSPZ0WmFh?=
 =?us-ascii?Q?5sBl5vsVkxSV+PrJ0IBLI5wSXCTz/FUGgejpyI07Z5kHMT2MNJZctatuAAtI?=
 =?us-ascii?Q?GSM5C93rbhrAZffaidAzS5BaVIfDfx0HO4FaeU3ooLkvAATc7uNWcFeRwFeA?=
 =?us-ascii?Q?Mtmvfk+L/uFYKzvBWWcRbS9Dmk1yY6AIJHNdMwXxKSYmT1VWQ0lnviUQ366G?=
 =?us-ascii?Q?10JiL2A4j78q6Q6wCN+hIJdnsu5wYaQVnUx8yhBMSGatzg5LmictqrNjLcwH?=
 =?us-ascii?Q?LKJoDlH6lLZu0mqOeh6Zn7MmzNAUJzaJ270InphbBH+CvtwaSV5T2HIf2tp+?=
 =?us-ascii?Q?nqI/KZH4kClVcdupjjLOh+YcgX4pZQ0p8lwfLIbxZBOdg6Ez7ZhmXhRWzTac?=
 =?us-ascii?Q?cQyRj6+4CE8ZzArWZXVkDfO9eOtwVWv1sE+Tnbvaq99SORr9whknHWHj5TF5?=
 =?us-ascii?Q?HSgGpGECv0BBwjnXdtnUGAqgq3II8EOC9FbVL3YJHUg+XEG53aId5/vVK8ov?=
 =?us-ascii?Q?/sz/vsqFJneFo2wSYrAEim4j7DSbkIfxWbN7ARObGEL60rSmClhCjWfNGv65?=
 =?us-ascii?Q?rF49QXSiTKxICD487RL1EB7vm+kMajAM0dRCkDYQVdl4kTBA12nPqeAUVmJ6?=
 =?us-ascii?Q?QsyfzB4XoCbEv+v3ryvb+0qAaH4scH395NsSsjRW/krch1v0f/mojYjGdO1y?=
 =?us-ascii?Q?ljbiVzzK3iyulULS/VaTQO8Gtu5wFU6UU7O3pKRs/0by4DzKttQCYnowkOpU?=
 =?us-ascii?Q?+QRHurQRjTQIT4ddFEE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5399.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1e5f6cb-e387-4638-63d9-08dc7344b36f
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2024 12:03:28.4568 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: O0ECXFMYiAFNOcBmibE99fmOePwOfuzHEfbSg5ZTKy2ZpuTQL8ITV6unMvapkngw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8876
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

Reviewed-by: Leo Liu <leo.liu@amd.com>

> -----Original Message-----
> From: Wu, David <David.Wu3@amd.com>
> Sent: Thursday, May 9, 2024 5:37 PM
> To: amd-gfx@lists.freedesktop.org; Deucher, Alexander
> <Alexander.Deucher@amd.com>
> Cc: Koenig, Christian <Christian.Koenig@amd.com>; Liu, Leo
> <Leo.Liu@amd.com>; Jiang, Sonny <Sonny.Jiang@amd.com>
> Subject: [PATCH] drm/amd/amdgpu: update jpeg 5 capability
>
> Based on the documentation the maximum resolustion should be 16384x16384.
>
> Signed-off-by: David (Ming Qiang) Wu <David.Wu3@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/soc24.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/soc24.c
> b/drivers/gpu/drm/amd/amdgpu/soc24.c
> index 12900488dd61..285d6af10f62 100644
> --- a/drivers/gpu/drm/amd/amdgpu/soc24.c
> +++ b/drivers/gpu/drm/amd/amdgpu/soc24.c
> @@ -61,7 +61,7 @@ static const struct amdgpu_video_codecs
> vcn_5_0_0_video_codecs_encode_vcn0 =3D {  static const struct
> amdgpu_video_codec_info vcn_5_0_0_video_codecs_decode_array_vcn0[] =3D {
>
>       {codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4_
> AVC, 4096, 2160, 52)},
>       {codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_HEVC,
> 8192, 4320, 183)},
> -     {codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_JPEG,
> 4096, 4096, 0)},
> +     {codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_JPEG,
> 16384, 16384,
> +0)},
>       {codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_VP9,
> 8192, 4352, 0)},
>       {codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_AV1,
> 8192, 4352, 0)},  };
> --
> 2.34.1

