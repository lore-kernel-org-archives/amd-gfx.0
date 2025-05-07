Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB2F5C369DC
	for <amd-gfx@archiver.kernel.org>; Wed,  7 May 2025 06:22:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5973510E0C8;
	Wed,  7 May 2025 06:22:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="oE1cJUD7";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2087.outbound.protection.outlook.com [40.107.93.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A7FD10E0C8
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 May 2025 06:22:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UIYcMa8z+g7g/u1KaGuLvi2bHbeTnQUOu2GoVWS+ho8DumVnN2jJHDL4pAQCq5zqKhhG9dP9PzygB9daRM5hPokwvwgJcuEfF0SjVQAkGxEE4yw95gB4RLvCs2Q9b7LRFnzTpA31XlQNFNos1oVZe18LpBTgU9AKO9T5cJzy2XbxMASR3f5a2vcFt6ldwvcXUjDbieA0iSZZ8263k0M4JLSjbd+da9KuV7NbwDB5tfkm2nuGRa0phhVGoaymB7qkVtdPTRs34HKedyv7zQZivEJ/V1jkGR4Gae+Q2VQKVAcxni7O89IoD6mAmyMDkGc1ZefULsE1O/9OTeRcZIFZOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FMIf7rpLM1ysgrhmPHLtnZ+rwOdwL+ZMNaewj12Y7UY=;
 b=P/Vrd8DG08xo7GHvyC+f0tcVgEISCzKvqd4MO6MQGh65esSZg9jNUj/Utfhz4JNiULRw65kfTaQ8c/+2n6HJw39CqJHrV6tPnXo2aZk6BlxO9qT0engvOxGNXHyKYD3lCo9DfNE37eeW6c/yIXqXPxo7r6y7WevhBGJewVScUORN3SMxiaUcTn9c9G52Gtpk0usTUMm64DDqtbiZ30c8UpBGDgtZF7Cs0ZZ2r1oPQZgl/FTBVFCZljyFB16qMz5UOpUFhOqFKQAgYWYWFf8dE/zs6EqXJz8C7XycTx/Gxt3Iw2V3G5ardtlAVEX6LJwD9m8XzWOWVEVPEHiJ/+wBEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FMIf7rpLM1ysgrhmPHLtnZ+rwOdwL+ZMNaewj12Y7UY=;
 b=oE1cJUD74A5Qnx6Et/d2VNTNoOhapM6DR2gripq516G/MTkhjEzkSgVZDPeLG7rF+qHjzFN58ookQ0Lqhsh3oCCxm69fXYYjoCr9KhAPoMVG/LfjtCj9DySg9YjVgmIn+jdXekB3xHWnV6nQTaqsOiIZetPShuddGuHRD/ukcIE=
Received: from DM4PR12MB5937.namprd12.prod.outlook.com (2603:10b6:8:68::11) by
 MW3PR12MB4460.namprd12.prod.outlook.com (2603:10b6:303:2f::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8699.26; Wed, 7 May 2025 06:22:42 +0000
Received: from DM4PR12MB5937.namprd12.prod.outlook.com
 ([fe80::c847:70c6:3c78:54ba]) by DM4PR12MB5937.namprd12.prod.outlook.com
 ([fe80::c847:70c6:3c78:54ba%7]) with mapi id 15.20.8722.020; Wed, 7 May 2025
 06:22:42 +0000
From: "Zhang, GuoQing (Sam)" <GuoQing.Zhang@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Koenig, Christian"
 <Christian.Koenig@amd.com>
CC: "Zhao, Victor" <Victor.Zhao@amd.com>, "Chang, HaiJun"
 <HaiJun.Chang@amd.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Zhang, Owen(SRDC)" <Owen.Zhang2@amd.com>, "Ma, Qing (Mark)"
 <Qing.Ma@amd.com>, Jiang Liu <gerry@linux.alibaba.com>
Subject: Re: [PATCH v3 1/7] drm/amdgpu: update XGMI physical node id and GMC
 configs on resume
Thread-Topic: [PATCH v3 1/7] drm/amdgpu: update XGMI physical node id and GMC
 configs on resume
Thread-Index: AQHbvmqSdeRyBSujaUqqoycQD1crPbPFfriAgAEQVKY=
Date: Wed, 7 May 2025 06:22:40 +0000
Message-ID: <DM4PR12MB59371DC0E9B611C568CE395CE588A@DM4PR12MB5937.namprd12.prod.outlook.com>
References: <20250506093629.249792-1-guoqing.zhang@amd.com>
 <354d063e-ba67-469f-a945-d8c6467f6c11@amd.com>
In-Reply-To: <354d063e-ba67-469f-a945-d8c6467f6c11@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-Mentions: Lijo.Lazar@amd.com
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-05-07T04:10:00.6049801Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5937:EE_|MW3PR12MB4460:EE_
x-ms-office365-filtering-correlation-id: df079dda-5231-4acb-1a93-08dd8d2f92c9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|38070700018|8096899003|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?J4Gn+y9Yk9XDM4FoXnHGVKOrJRuK44hxUi7LuqKnWNWfwGNNzsgcEGB8+NZ1?=
 =?us-ascii?Q?wbOM9zDs4jv+YRv/CkOo+nJgBT2VyE7StnsSS0BvPReYUx9Wi8E3VP+mZo67?=
 =?us-ascii?Q?3Vi/4fFIqBN0l+jUbZCpoYoJJhW3U90H5M8vdMkuJRxvz7YUDjzaEBZ5vCR1?=
 =?us-ascii?Q?fFP29nwFkseauZ+pt2jV+CxWZsUYqBMG8ejzowyyBD3oopKA9cfPnETqkdK+?=
 =?us-ascii?Q?CzNAIpCbDE2skoltqwqL8cAURrXk9TWwKfmC9rogoUf3C76wyI3rrqogqLwx?=
 =?us-ascii?Q?dlp8E2jO0HoH013lRDl3bMegHHPsWFOnTxB8OOAvWfIEr1XE8LSh+V3DkNUC?=
 =?us-ascii?Q?BbgHNIpNA6vo7W+2rYV2CQ0hwR8Rjoz9CI2YtYwqB2Kl7e5IoFnj51eHeV53?=
 =?us-ascii?Q?T49YPnWqFpjHwOwStt8rnzrnliwfuUakVGEUgvmOSHI9ter4Qp70pNM68cU3?=
 =?us-ascii?Q?7R8B6XsG4JxjvOZln52W2pCfWgi0O2M5GiACqG20TMa6IZzOt2JO2DA6fJlr?=
 =?us-ascii?Q?Z6a53n2Qi53lqpjjmh4DpYsJhx0rm6CZpY0xJ/xAptZ0CeQhxJoOrAhdQUir?=
 =?us-ascii?Q?Cvvag+bw8x6jGuIeeAhX1k8Tn6Y+Gav1uGKtqoCPDAFW5ktdzoFkDsEuv8+D?=
 =?us-ascii?Q?mtWEAI7yei0lf5q52OusfYzBkQzCFwfznK52M7wXFaPEB2r5BBwvds/oEkHR?=
 =?us-ascii?Q?NFsIqhwpscbHhYJ1rMI6Tsk52YCatXksRZFtEbaKhDceIY8GNlUDdrlocNyP?=
 =?us-ascii?Q?CrjxrBveObvux1Uu/kR2gLumREKga7psOWep4aYBRRec75ibyJAWApHccGiO?=
 =?us-ascii?Q?Z3jkpo/DSAqq9+K3vxT7olQVgTPNUOfwmBioMQXw0Yh7PobrzVAlptH4uSDp?=
 =?us-ascii?Q?38TUmfLXcT7Sj5GHEiHZNeNm26AC/tJTeAK54De4NrtTywYFokWp3RkzIxY2?=
 =?us-ascii?Q?Rp8rnuSvqELdMRwyA7iCdjeJfgdQvYud+U2yhCpUqSQzn8+3Np9WUMfwez4p?=
 =?us-ascii?Q?1oJ4uW5ki+Vpdmbri6YFgFI8D4Q5vpgR6Akjb0fOD+Eqg3hk7o1KRNyWQcLJ?=
 =?us-ascii?Q?zxPXDSghWBe+JDIfdl59qHxIuS0jNYt2PFjQZClvUxx42NOMj6Tjrk4iSebQ?=
 =?us-ascii?Q?N1nnTwmlxbNK63yFb8jsziYmGJbCNkBz39LlS1ZOLd5BsvRt45beE2xBo9PJ?=
 =?us-ascii?Q?wqWtCIYXTjkAFKGMKfCgZpLpRhbjV1VKXYtWdDqM/K8aP7QEB9oHksDS0qoI?=
 =?us-ascii?Q?tjyFsNc7VLgiFRTlCE+QkREZd8s4TPsTPsIxIncWawaGR874zZOTTHRdNX1j?=
 =?us-ascii?Q?yViobY3sgh8lTl7i5zQM6TywvD1B6Tot+0RWOEJQN+hsKDbtXv9vui35v62s?=
 =?us-ascii?Q?ho/Snkz5mz+JmhpvYJJuYmUCxHyxWApohsPqNLIUZkNSlfUxx3PxuOzqK4au?=
 =?us-ascii?Q?/I2slXkhkzsZc9vHwxFMECLGEjpBjbbu5bVxbLWj9B3JeGf05jgnP9b79Yoh?=
 =?us-ascii?Q?ayq+Zt5dSwQaIaY=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5937.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018)(8096899003)(7053199007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?B6fDr+JHIFU2PNaaYcZFR7jDeb4dG2+J3x63RjE0HnvOCUoLrJnrQYNfr4kO?=
 =?us-ascii?Q?qUgcwEB3Fp5jIXokPB1ZyacRcnHcq03ePd7jhblohXH52PXhnk4nMpxslzNa?=
 =?us-ascii?Q?S0D0VQflIQi43zBhdWitlnaogK1ZDDpzMWdJASDhAGFVifq4ubPDUJG2csN6?=
 =?us-ascii?Q?8mPCaXgfvSV+Cb59HbuZ7GUaRzPiyzJaRlWFDpozZ8XTYj6XeRzXZe4Ymenq?=
 =?us-ascii?Q?LHlDGT2Uco+AD4kFIish3XEjdhj5XrXD48NXLGK4LGRbf4npydija5tjufPE?=
 =?us-ascii?Q?haRIw6Svg2mp9534VbqTsGoRnsXvaINViUis45bDkylAR27LgktUNxVHSNtl?=
 =?us-ascii?Q?whfNBOIo3FXpx/CG7oWQ59so0A+fgqZRz1GD7rpY7tzYH6IMa2U6pmV0x2IY?=
 =?us-ascii?Q?Rf+VmC8in9RHqVnZa9QQ2Lq6RkGe/F2bRAP2nthCX9Oo42LmgJ3ZK1YWhOpt?=
 =?us-ascii?Q?EAFhYsgXHaNsH2DVipxe45zscZeFhAay8w+yCCiwqZxPN54ZJuAmuaUJhW1B?=
 =?us-ascii?Q?4l7oHAlf735quBZnt9u1MOfs8rzl1JeJe4CsYl+kAqxSHoBbLOjmLOOkLGaK?=
 =?us-ascii?Q?21DZJMCoOkZZ96R6W8OPtwxG35IltKNTcwVAtWk92iqwwSv5fkhMv+j2XXZr?=
 =?us-ascii?Q?snAEOtssl9IifnJxBBdCj4IwKCYVUg56tV2WHf7BZ+nUJgl1mDquEsEUW4OV?=
 =?us-ascii?Q?SG8Z10vTdTsDU2rIiAsfFm7SHOr4SDNd/dV3CcYXlER8B85LV4ckm1ilSbaI?=
 =?us-ascii?Q?vrt6qQz0XXjKWX+AhY8QwbkojATsorUYoAv4KierCSLzqNRVmurN4ljQRtye?=
 =?us-ascii?Q?mXkAB6JnAdR/hvgqVKUjgtQTN3KfoIfZS7/LL1U5mUFbzU80hWzjjElooW8v?=
 =?us-ascii?Q?RLdwZuGgsOLD8fW6ZlEyLstErrlexUD8AFUNbuxcLRbod5kAlwmNRGesEvkV?=
 =?us-ascii?Q?0SthLC+0b0XPjUsxPOWr4nszUmy7cbHm+z1P5RSiaDufnsxdobGmUeSifQdc?=
 =?us-ascii?Q?QJu7EBRCUjJztYKC3YPZlftWb+x/VrErq8FzSYavqiE9DNmHYwkqsrPctCon?=
 =?us-ascii?Q?ZIcUCDnV58ueaz87ESidg1urfOIx3VS3zQexD1uobGjin5shUcFfE+tLEwf8?=
 =?us-ascii?Q?ssFjAuSGBDtsmbwiV5sXdGiqxHrTagv6Cl8B0J611aADhY613HnzVsj51QFY?=
 =?us-ascii?Q?i4EtFl6aRebook/tKCibMA8Yc81j0OUCWhOHp1ter4hvb8SaWZf4DbSsgyzR?=
 =?us-ascii?Q?Qv1/BOu9KRTpiKMIUkumZK34IT6LWcSmwfXk8KtdVj6Jd0KvweXJxlT1vpZg?=
 =?us-ascii?Q?ANvSOY7FJVK4NjbVYB15FLAa8gQKGwGZcdQytUzu4oFmEfkamBvWtHZH+04f?=
 =?us-ascii?Q?jlIJkLRlK4G1WhM4mtVfBpsSgZoJKdrD/GhnSTRohmrZ9oAjr2cuhz3FdLwl?=
 =?us-ascii?Q?z6Jxtp7l6Q7JyKQwJlt3hdCWl4vst1Uq0cIsfppCwWQFIrkAlp6X5T0rH5Ga?=
 =?us-ascii?Q?JLmofbtLqVIpzHajf5gd6pq8pasQ5xGZ0HwOFCMakzu4F0YGUe43fNWgqrK+?=
 =?us-ascii?Q?tAJ29gsf7mkWoDd+xO8=3D?=
Content-Type: multipart/alternative;
 boundary="_000_DM4PR12MB59371DC0E9B611C568CE395CE588ADM4PR12MB5937namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5937.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df079dda-5231-4acb-1a93-08dd8d2f92c9
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2025 06:22:42.1664 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Wh2yufiQHP1QC055JB8w6VCJwHWE+OrH34sPf3cm2zbBDMOa3yccGdCN9UBttw1c7rh50Qsk86eeTtgiFcvpzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4460
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

--_000_DM4PR12MB59371DC0E9B611C568CE395CE588ADM4PR12MB5937namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - AMD Internal Distribution Only]


> Please keep in mind that this is not the only scenario addressed by the
> driver - for ex: a resume sequence is executed after a device reset.
> This patch itself introduces unwanted sequences for other commonly used
> usecases. Please rework on the series without breaking existing usecases.
>
> Thanks,
> Lijo

Hi @Lazar, Lijo<mailto:Lijo.Lazar@amd.com>, Thank you for the feedback.

I also think the new code should be inside a check so that new code is exec=
uted only on resume with different VF and do not break existing usecases. F=
ollowing is the implementation of this approach I can think of.
- introduce new field `prev_physical_node_id ` in `struct amdgpu_xgmi `. up=
date the fields on resume.
- put new code inside code block `if (prev_physical_node_id  !=3D physical_=
node_id )`

Is this approach acceptable? If not, can you suggest a better approach? @La=
zar, Lijo<mailto:Lijo.Lazar@amd.com> @Koenig, Christian<mailto:Christian.Ko=
enig@amd.com> Thank you!

Regards
Sam

From: Lazar, Lijo <Lijo.Lazar@amd.com>
Date: Tuesday, May 6, 2025 at 19:55
To: Zhang, GuoQing (Sam) <GuoQing.Zhang@amd.com>, amd-gfx@lists.freedesktop=
.org <amd-gfx@lists.freedesktop.org>
Cc: Zhao, Victor <Victor.Zhao@amd.com>, Chang, HaiJun <HaiJun.Chang@amd.com=
>, Koenig, Christian <Christian.Koenig@amd.com>, Deucher, Alexander <Alexan=
der.Deucher@amd.com>, Zhang, Owen(SRDC) <Owen.Zhang2@amd.com>, Ma, Qing (Ma=
rk) <Qing.Ma@amd.com>, Jiang Liu <gerry@linux.alibaba.com>
Subject: Re: [PATCH v3 1/7] drm/amdgpu: update XGMI physical node id and GM=
C configs on resume


On 5/6/2025 3:06 PM, Samuel Zhang wrote:
> For virtual machine with vGPUs in SRIOV single device mode and XGMI
> is enabled, XGMI physical node ids may change when waking up from
> hiberation with different vGPU devices. So update XGMI physical node
> ids on resume.
>

Please keep in mind that this is not the only scenario addressed by the
driver - for ex: a resume sequence is executed after a device reset.
This patch itself introduces unwanted sequences for other commonly used
usecases. Please rework on the series without breaking existing usecases.

Thanks,
Lijo

> Update GPU memory controller configuration on resume if XGMI physical
> node ids are changed.
>
> Signed-off-by: Jiang Liu <gerry@linux.alibaba.com>
> Signed-off-by: Samuel Zhang <guoqing.zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 24 ++++++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c    |  3 +--
>  drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c      |  4 ++++
>  3 files changed, 29 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_device.c
> index d477a901af84..e795af5067e5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -5040,6 +5040,27 @@ int amdgpu_device_suspend(struct drm_device *dev, =
bool notify_clients)
>        return 0;
>  }
>
> +static int amdgpu_device_update_xgmi_info(struct amdgpu_device *adev)
> +{
> +     int r;
> +     unsigned int prev_physical_node_id;
> +
> +     /* Get xgmi info again for sriov to detect device changes */
> +     if (amdgpu_sriov_vf(adev) &&
> +         !(adev->flags & AMD_IS_APU) &&
> +         adev->gmc.xgmi.supported &&
> +         !adev->gmc.xgmi.connected_to_cpu) {
> +             prev_physical_node_id =3D adev->gmc.xgmi.physical_node_id;
> +             r =3D adev->gfxhub.funcs->get_xgmi_info(adev);
> +             if (r)
> +                     return r;
> +
> +             dev_info(adev->dev, "xgmi node, old id %d, new id %d\n",
> +                     prev_physical_node_id, adev->gmc.xgmi.physical_node=
_id);
> +     }
> +     return 0;
> +}
> +
>  /**
>   * amdgpu_device_resume - initiate device resume
>   *
> @@ -5059,6 +5080,9 @@ int amdgpu_device_resume(struct drm_device *dev, bo=
ol notify_clients)
>                r =3D amdgpu_virt_request_full_gpu(adev, true);
>                if (r)
>                        return r;
> +             r =3D amdgpu_device_update_xgmi_info(adev);
> +             if (r)
> +                     return r;
>        }
>
>        if (dev->switch_power_state =3D=3D DRM_SWITCH_POWER_OFF)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_gmc.c
> index d1fa5e8e3937..a2abddf3c110 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> @@ -1298,8 +1298,7 @@ int amdgpu_gmc_get_nps_memranges(struct amdgpu_devi=
ce *adev,
>        if (!mem_ranges || !exp_ranges)
>                return -EINVAL;
>
> -     refresh =3D (adev->init_lvl->level !=3D AMDGPU_INIT_LEVEL_MINIMAL_X=
GMI) &&
> -               (adev->gmc.reset_flags & AMDGPU_GMC_INIT_RESET_NPS);
> +     refresh =3D true;
>        ret =3D amdgpu_discovery_get_nps_info(adev, &nps_type, &ranges,
>                                            &range_cnt, refresh);
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/=
amdgpu/gmc_v9_0.c
> index 59385da80185..1eb451a3743b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> @@ -2533,6 +2533,10 @@ static int gmc_v9_0_resume(struct amdgpu_ip_block =
*ip_block)
>        struct amdgpu_device *adev =3D ip_block->adev;
>        int r;
>
> +     r =3D gmc_v9_0_mc_init(adev);
> +     if (r)
> +             return r;
> +
>        /* If a reset is done for NPS mode switch, read the memory range
>         * information again.
>         */

--_000_DM4PR12MB59371DC0E9B611C568CE395CE588ADM4PR12MB5937namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" xmlns:w=3D"urn:sc=
hemas-microsoft-com:office:word" xmlns:m=3D"http://schemas.microsoft.com/of=
fice/2004/12/omml" xmlns=3D"http://www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
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
s&quot;,sans-serif"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Apto=
s&quot;,sans-serif">&gt; Please keep in mind that this is not the only scen=
ario addressed by the<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Apto=
s&quot;,sans-serif">&gt; driver - for ex: a resume sequence is executed aft=
er a device reset.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Apto=
s&quot;,sans-serif">&gt; This patch itself introduces unwanted sequences fo=
r other commonly used<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Apto=
s&quot;,sans-serif">&gt; usecases. Please rework on the series without brea=
king existing usecases.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Apto=
s&quot;,sans-serif">&gt; <o:p>
</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Apto=
s&quot;,sans-serif">&gt; Thanks,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Apto=
s&quot;,sans-serif">&gt; Lijo<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Apto=
s&quot;,sans-serif"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Apto=
s&quot;,sans-serif">Hi
<a id=3D"OWAAMBAFCD4633AA3514C9B5BCB5E58BDD327" href=3D"mailto:Lijo.Lazar@a=
md.com"><span style=3D"font-family:&quot;Aptos&quot;,sans-serif;text-decora=
tion:none">@Lazar, Lijo</span></a>, Thank you for the feedback.
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Apto=
s&quot;,sans-serif"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Apto=
s&quot;,sans-serif">I also think the new code should be inside a check so t=
hat new code is executed only on resume with different VF and do not break =
existing usecases. Following is the implementation
 of this approach I can think of. <o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Apto=
s&quot;,sans-serif">- introduce new field `prev_physical_node_id ` in `stru=
ct amdgpu_xgmi `. update the fields on resume.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Apto=
s&quot;,sans-serif">- put new code inside code block `if (prev_physical_nod=
e_id &nbsp;!=3D physical_node_id )`<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Apto=
s&quot;,sans-serif"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Apto=
s&quot;,sans-serif">Is this approach acceptable? If not, can you suggest a =
better approach?
<a id=3D"OWAAM57DEDBE5638C4240A750A18A148939F0" href=3D"mailto:Lijo.Lazar@a=
md.com"><span style=3D"font-family:&quot;Aptos&quot;,sans-serif;text-decora=
tion:none">@Lazar, Lijo</span></a>
<a id=3D"OWAAM10C90ABE505E85408A10A63A9A44DFE8" href=3D"mailto:Christian.Ko=
enig@amd.com">
<span style=3D"font-family:&quot;Aptos&quot;,sans-serif;text-decoration:non=
e">@Koenig, Christian</span></a> Thank you!<o:p></o:p></span></p>
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
ns-serif;color:black">Lazar, Lijo &lt;Lijo.Lazar@amd.com&gt;<br>
<b>Date: </b>Tuesday, May 6, 2025 at 19:55<br>
<b>To: </b>Zhang, GuoQing (Sam) &lt;GuoQing.Zhang@amd.com&gt;, amd-gfx@list=
s.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Cc: </b>Zhao, Victor &lt;Victor.Zhao@amd.com&gt;, Chang, HaiJun &lt;HaiJ=
un.Chang@amd.com&gt;, Koenig, Christian &lt;Christian.Koenig@amd.com&gt;, D=
eucher, Alexander &lt;Alexander.Deucher@amd.com&gt;, Zhang, Owen(SRDC) &lt;=
Owen.Zhang2@amd.com&gt;, Ma, Qing (Mark) &lt;Qing.Ma@amd.com&gt;, Jiang
 Liu &lt;gerry@linux.alibaba.com&gt;<br>
<b>Subject: </b>Re: [PATCH v3 1/7] drm/amdgpu: update XGMI physical node id=
 and GMC configs on resume<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><br>
<br>
On 5/6/2025 3:06 PM, Samuel Zhang wrote:<br>
&gt; For virtual machine with vGPUs in SRIOV single device mode and XGMI<br=
>
&gt; is enabled, XGMI physical node ids may change when waking up from<br>
&gt; hiberation with different vGPU devices. So update XGMI physical node<b=
r>
&gt; ids on resume.<br>
&gt; <br>
<br>
Please keep in mind that this is not the only scenario addressed by the<br>
driver - for ex: a resume sequence is executed after a device reset.<br>
This patch itself introduces unwanted sequences for other commonly used<br>
usecases. Please rework on the series without breaking existing usecases.<b=
r>
<br>
Thanks,<br>
Lijo<br>
<br>
&gt; Update GPU memory controller configuration on resume if XGMI physical<=
br>
&gt; node ids are changed.<br>
&gt; <br>
&gt; Signed-off-by: Jiang Liu &lt;gerry@linux.alibaba.com&gt;<br>
&gt; Signed-off-by: Samuel Zhang &lt;guoqing.zhang@amd.com&gt;<br>
&gt; ---<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 24 ++++++++++++++++=
++++++<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c&nbsp;&nbsp;&nbsp; |&nbsp=
; 3 +--<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; |&nbsp; 4 ++++<br>
&gt;&nbsp; 3 files changed, 29 insertions(+), 2 deletions(-)<br>
&gt; <br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/=
drm/amd/amdgpu/amdgpu_device.c<br>
&gt; index d477a901af84..e795af5067e5 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
&gt; @@ -5040,6 +5040,27 @@ int amdgpu_device_suspend(struct drm_device *de=
v, bool notify_clients)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt;&nbsp; }<br>
&gt;&nbsp; <br>
&gt; +static int amdgpu_device_update_xgmi_info(struct amdgpu_device *adev)=
<br>
&gt; +{<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; int r;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; unsigned int prev_physical_node_id;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; /* Get xgmi info again for sriov to detect d=
evice changes */<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(adev) &amp;&amp;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; !(adev-&gt;flags &am=
p; AMD_IS_APU) &amp;&amp;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gmc.xgmi.su=
pported &amp;&amp;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; !adev-&gt;gmc.xgmi.c=
onnected_to_cpu) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; prev_physical_node_id =3D adev-&gt;gmc.xgmi.physical_node_id;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; r =3D adev-&gt;gfxhub.funcs-&gt;get_xgmi_info(adev);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (r)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; dev_info(adev-&gt;dev, &quot;xgmi node, old id %d, new id %d\n&quot;,<b=
r>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; prev_physical_node_id, =
adev-&gt;gmc.xgmi.physical_node_id);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt; +}<br>
&gt; +<br>
&gt;&nbsp; /**<br>
&gt;&nbsp;&nbsp; * amdgpu_device_resume - initiate device resume<br>
&gt;&nbsp;&nbsp; *<br>
&gt; @@ -5059,6 +5080,9 @@ int amdgpu_device_resume(struct drm_device *dev,=
 bool notify_clients)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; r =3D amdgpu_virt_request_full_gpu(adev, true);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (r)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return =
r;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; r =3D amdgpu_device_update_xgmi_info(adev);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (r)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (dev-&gt;switch_power_sta=
te =3D=3D DRM_SWITCH_POWER_OFF)<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_gmc.c<br>
&gt; index d1fa5e8e3937..a2abddf3c110 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c<br>
&gt; @@ -1298,8 +1298,7 @@ int amdgpu_gmc_get_nps_memranges(struct amdgpu_d=
evice *adev,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!mem_ranges || !exp_rang=
es)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&gt;&nbsp; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; refresh =3D (adev-&gt;init_lvl-&gt;level !=
=3D AMDGPU_INIT_LEVEL_MINIMAL_XGMI) &amp;&amp;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; (adev-&gt;gmc.reset_flags &amp; AMDGPU_GMC_INIT_RESET_NPS);=
<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; refresh =3D true;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D amdgpu_discovery_get=
_nps_info(adev, &amp;nps_type, &amp;ranges,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;range_cnt, refresh);<br>
&gt;&nbsp; <br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/a=
md/amdgpu/gmc_v9_0.c<br>
&gt; index 59385da80185..1eb451a3743b 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c<br>
&gt; @@ -2533,6 +2533,10 @@ static int gmc_v9_0_resume(struct amdgpu_ip_blo=
ck *ip_block)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =
=3D ip_block-&gt;adev;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int r;<br>
&gt;&nbsp; <br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; r =3D gmc_v9_0_mc_init(adev);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; return r;<br>
&gt; +<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* If a reset is done for NP=
S mode switch, read the memory range<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * information again.<b=
r>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */</p>
</div>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_DM4PR12MB59371DC0E9B611C568CE395CE588ADM4PR12MB5937namp_--
