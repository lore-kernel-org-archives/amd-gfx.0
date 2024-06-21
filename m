Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE0F3C2BA18
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Jun 2024 03:34:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 248B110E917;
	Fri, 21 Jun 2024 03:34:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YfZ/gVSg";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2061.outbound.protection.outlook.com [40.107.212.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B22CC10E917
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Jun 2024 03:34:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FsNr2rIbjsiMwUHNsfH2DbW3MzSXb8rHgloS5g8CiilU+yp42qEZGbuCBd5MoCyd4E/e+ANac4Zn5y9c3rlPyT4ktsTqM/6olvIK0T60RxUHf6sI03AKpvs/77tnzk0bnnLtn/xNP2tQGDPItb8fKzQOOrzIPCKxYpw6RXKMaNp3FJSg1oOCcXEuiMwm7CF7PT+7CTsIUlLhi+Hz+v/xML5Tamcg9Wo+veobr6vlDTH6sxPqis5mUfh1/9Nu9C/BVqLX/dWK95MHZBaTLYMYOqH7zNup0te0YoUDmMrKuzzY5wzFs+uJydWM97KhFtbgUPFLkIq/5GiVgtDmPggQUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IIyj2fKW7sf8r8q9akA0CmPxVj5nhRd8eAHtUtULDBM=;
 b=HuG7h9hGrVGFIIP/UIqLwzvKarQU341uLl7wCrZkRShA1cLWx3ZJ2oTpJs357RYTNVtLipx0sw5C5JXm9FJd9JFe3uX+L+MyOAUY0uwL234TN6BwStF+HnGVKRK3c7TzRxuppz0tS7WRPw8icG1iyG0s9IM6ssG5HTaWYAtXDgWhYvn9hDgruAosxCDlpdQuhSv01ybVdci7iz1SosXL3ECKX/kqECdj5VVkQGFCg5kM1Ns2MXg/Rt6XBotQ1Q5YI33K0L1/QIK7H+YjYzNdjHzF3HxqfS/NKvXUkA1mppZGgUHSsDx9/NQ1AlFm7YdKr6MEOhD/D54vqGNFS62YKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IIyj2fKW7sf8r8q9akA0CmPxVj5nhRd8eAHtUtULDBM=;
 b=YfZ/gVSgYPm7J4uPpTQfm0/3Bq51DUuLVHC1VZsW7/kEpQl7G71PX+OVlCDiWJtPRS+zB/fmQFrRFA0iy/u3efqhi0DiBV/vBPXEH/FtRCF9LSkkBfJCOh7WLzFiRQ5pvarb7rQlQsjTGrzXi+7THu0bGd7wYAOwFRnsccPKAXU=
Received: from PH7PR12MB8796.namprd12.prod.outlook.com (2603:10b6:510:272::22)
 by PH7PR12MB8124.namprd12.prod.outlook.com (2603:10b6:510:2ba::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.21; Fri, 21 Jun
 2024 03:34:47 +0000
Received: from PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::910f:c354:ea0d:1fd]) by PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::910f:c354:ea0d:1fd%5]) with mapi id 15.20.7698.020; Fri, 21 Jun 2024
 03:34:47 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Fix register access violation
Thread-Topic: [PATCH] drm/amdgpu: Fix register access violation
Thread-Index: AQHaw4tpJdkng+Y7w0KpcAwEpX3V67HRkMsA
Date: Fri, 21 Jun 2024 03:34:46 +0000
Message-ID: <PH7PR12MB87966F93E445357D5850B920B0C92@PH7PR12MB8796.namprd12.prod.outlook.com>
References: <20240621033006.19213-1-Hawking.Zhang@amd.com>
In-Reply-To: <20240621033006.19213-1-Hawking.Zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=eb1aa279-dcb0-4436-bd59-c69c77266a60;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-06-21T03:34:37Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB8796:EE_|PH7PR12MB8124:EE_
x-ms-office365-filtering-correlation-id: 0f7b8945-4b15-4a74-e168-08dc91a31946
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230037|366013|376011|1800799021|38070700015;
x-microsoft-antispam-message-info: =?us-ascii?Q?dZY3lr1rS16FHRfB24dOf6ylUoS01gWUyY5QhMO+3+6TMDro3HR0sde+bEC9?=
 =?us-ascii?Q?Mx6ejsZe9h7zL9n9Py7dVF3+rfmILWlTj96gJogJzEuKFFXGgwy9FjylnHk2?=
 =?us-ascii?Q?4w/BN1M7w3Vw62R8cK2KxPqAJji/skswLQpVFbS4zfXnYFZ7BksEQbgJAS8i?=
 =?us-ascii?Q?rids07mKcUrlBlyK5AXgbJrSWqvkWvWH28ZlUmPjxo7FfbGQTYvsi/EpyDwV?=
 =?us-ascii?Q?Ni5s7ER1B2KfEVl8umHiJB+BoFoHKdgPEF3Z7egpCtuusswWyPSqZVsIagJb?=
 =?us-ascii?Q?2yoxdAmBpPo7WEWw9/uZ61xO9tAwA16e7t5NNWdlJl8rMkkqXI/QZqghUUot?=
 =?us-ascii?Q?wfgrQBNzoo7tYbceQuf51I1d/IDtfzFCtliC/bZb9ouzfQoEeDCWWmtH5YPq?=
 =?us-ascii?Q?bNUgmvxDCt9qNEn5X+wt90K3OI4Z4X4WYFImYeR/aq1m/YVpF37EW1Msl9sv?=
 =?us-ascii?Q?ogYH3nKgmQuUNzUJ1HmxpOVt912h0a7Ak4T1e9jKMaFmWvxRNA4G/W+boBIl?=
 =?us-ascii?Q?fAcobpsEDgptGNWVM9YLMa1/zMWrm+svR3O9iwMF2358zQ7N92ahO//MU+4J?=
 =?us-ascii?Q?y4NL4WeBSm6yRvxnLeRaMR+i6fQwTT1M1MUU6NjueUvQnKE5MKVO7o64w6M4?=
 =?us-ascii?Q?psJlDftexbyFjbwJGJDDC4LtsJt2BAC9qCHyhTRwGKEsvV0V1G/SALaxzyVw?=
 =?us-ascii?Q?WOJDlwfzMABcFAP7W8qOqUskghuLnFt/cQ9Ji9qvxHmka/fjoRSxBmp4bkl8?=
 =?us-ascii?Q?fFIDbBjtY9prc2aWLGzZECxBHM5fiy1xS/F5niCSsHaTbBuW3oa1vP0rEElT?=
 =?us-ascii?Q?s4boFCoK7Xx/6LIwwu93JgQYeESPaQy3McSHUs1I0mcLedzXRd4LhWhgK8eg?=
 =?us-ascii?Q?e52M8bQpCck+CaENOlOZg/sr9havZPc825nkGT18NLgPrWI6tJh5arwI2Js8?=
 =?us-ascii?Q?QuMTsJbnR3/B+X4UlpASo3EjqHlesYyg7NwkVEBhRpKoKk9LDCIOsTIEZ9av?=
 =?us-ascii?Q?MUfXa2KqC4I+rEUYrIFJeTfNeJPgOFPcG4wiAtDpu7jcbxI+kJNvlhJ+yaTq?=
 =?us-ascii?Q?PlyicPO8uWXsS800IkqOzVa2NDOyAsi0vbVcM2XtTPL6UypWq+pvX2s03Ncw?=
 =?us-ascii?Q?/M1ivysqaQxiyXNoQY6G5w9GMySNaL2MOYD2d14JVT7/NgrFXAnc9yLh7CdA?=
 =?us-ascii?Q?cdSRhg6FAc+Qc2ZZq+lX7oGIP5S5j++iqtE0ONkAX2hRXw138qI2bDp3VjRx?=
 =?us-ascii?Q?MkBS79LTeRqRFbnSKOcM8av12fPR6QIARHCgnzi9v0KO9d8of6BeMkbPIh4y?=
 =?us-ascii?Q?ONssMKHZGDQTUCwGghS2+G56x2cBwB0ekGgVTNxw7m+DMCK2lSubQXRlbM0k?=
 =?us-ascii?Q?rFbjTzU=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB8796.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230037)(366013)(376011)(1800799021)(38070700015); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?gPXqiihdlCBO+M6ZU8EZytZwlM5MAfTmbxmNclP3Y4v9Gnz/oxbWrvUJJayt?=
 =?us-ascii?Q?SCW49kcN/e0f8tnCno/nqahagyF/UsXCuPXZIVkE/lr2OctBP40S3bi39TFg?=
 =?us-ascii?Q?orB7D1Dw12Y9KvychK5mAUnNn1f2zpT/dyLH/Kb8FBuzaQ1PIBIza0Dw1AI1?=
 =?us-ascii?Q?nt85X39kDil6ftMipuvJxVtp29H6tf9KR3IyfFMKBAC0L3iYD/KTBiwLniZe?=
 =?us-ascii?Q?HitgfeHozcCANb1YvaDwmoZWDSe6Z0DdXpb+yAKtOp6jh9WjQDuezsvi1Ugf?=
 =?us-ascii?Q?bjrCtcqXbmhWM0IEgcuXWYdkwGSEsSIeH9pYwfHhDv/t692nM5L5xkX5w+/z?=
 =?us-ascii?Q?b3diLPALma1isuo8GfS7yeoM78fP8AOlKlkhoCD9Wev10/7EfoJcwZzzL8TH?=
 =?us-ascii?Q?vL9b90hohqSOS9F3ZSiK6QDjHUT74ZnRQlHC89b2jzoNgKxCFLFkRh/COE3a?=
 =?us-ascii?Q?dk9WlbmdPXjlOndMGJBEHP6q1gAmwnWjfBqlXQ7cqtw5nqIt89gLLbaPP++6?=
 =?us-ascii?Q?vfm2kMx2PqYQ/JI8MnZQ4eNiWfAV6OR8wOo9eiTKf2bsG4Tu06YnYu550MuC?=
 =?us-ascii?Q?MhOPI10o+ITEmgzAPjSYcCuQ01wexjpxVX26MLbw6tlUqSHwZvscNav8aajJ?=
 =?us-ascii?Q?GjntXmgcMQwPdCGGrEnyDr31lFkFSlfNA0iwHdaSLAiH0DU6i8Lr3hoT9hhx?=
 =?us-ascii?Q?o7Z6z4PbeFbve+Q7qhu2B8MSdvRZmVM3GQwGkIERbOMuNDD72J3oife1OJyf?=
 =?us-ascii?Q?NkhSpI3y7F7VbI7o39yXkk7+ZhZ9/Yitywzo9pKncrarnq1BFHX6E2CwqFc2?=
 =?us-ascii?Q?WkoXoFeDJBwVgbjRE+YiMN6AQVFBiFNQzx/Rp6xI0h1FG1wa+kFDiOxTBaW2?=
 =?us-ascii?Q?9qhIy0tvePRmzGXeoOAN1gL4/DaiAw9XRVSy1dKg18yIyJ1sH9f7km+7q8zO?=
 =?us-ascii?Q?7DX83+4JSF6WpDNQ8MSTILXsXNt45sRgbPpWZKEBpOpJqiM8udgDYNp46tj9?=
 =?us-ascii?Q?MEsTxCsdgI3YKd6DIgYCHLajjddRpdyZi7hILqhxdxnnXl7El/wQzCDCXXfL?=
 =?us-ascii?Q?79IYV1wfNzdscA2LCZiO/WDjSFeLsPLYZzbCM/CkJ9/RXYq7GBbqDoT3AJUE?=
 =?us-ascii?Q?FP8pLhKpRRbLYKfzdKDO94InjQ5deZqUJfb6Eaz8CX38P3jZjaF84VNaHtCx?=
 =?us-ascii?Q?0CluXhqPasY6glCOBBS4Ls0NHfR/WOTaRoMkYyhNWC6M4KcVZnztxxT+UuxC?=
 =?us-ascii?Q?5S25NTv2tsoI/pNA/U9YVXGiPo/BE8udYoHTZS6P2I+rPj9yTqmoGUxmtU3p?=
 =?us-ascii?Q?cTbQwcascKZa4d7PyLroWc2P3i11PFMMmelJC5mOJKUkaLtTBTT6PTqBqDbY?=
 =?us-ascii?Q?Ls2PtL9oxClHKmeuZxsMswYTPz9HwHG0ZR8FTHUKdWNhOqLtaS22r/5J/4/X?=
 =?us-ascii?Q?uPyAi7QFasv4LZ1MORWe0uAmofcT4+QB441qHgBmnL8tQi+mLtXmXeimcDEt?=
 =?us-ascii?Q?2ZSSJey48Vp84C3EGPI9ZoxrCupXQ03C00BbBDKV0ScR+N6ukFZLgzCOt1Ya?=
 =?us-ascii?Q?rWVcai28N9ezYxp2TiM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8796.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f7b8945-4b15-4a74-e168-08dc91a31946
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2024 03:34:46.8258 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7YHL4zX9RCDEcuouDpnY2y2tiwtSLu5POtqCqkSLxWsW/9d7KmRFIP8KgaZFN1NN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8124
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

Reviewed-by: Tao Zhou <tao.zhou1@amd.com>

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Hawkin=
g
> Zhang
> Sent: Friday, June 21, 2024 11:30 AM
> To: amd-gfx@lists.freedesktop.org; Zhou1, Tao <Tao.Zhou1@amd.com>
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>
> Subject: [PATCH] drm/amdgpu: Fix register access violation
>
> fault_status is read only register. fault_cntl is not accessible from gue=
st
> environment.
>
> Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c | 8 +++++---
>  drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c    | 3 ++-
>  drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c  | 8 +++++---
>  3 files changed, 12 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c
> b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c
> index e14acab5cceb..72109abe7c86 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c
> @@ -629,9 +629,11 @@ static bool
> gfxhub_v1_2_query_utcl2_poison_status(struct amdgpu_device *adev,
>
>       status =3D RREG32_SOC15(GC, GET_INST(GC, xcc_id),
> regVM_L2_PROTECTION_FAULT_STATUS);
>       fed =3D REG_GET_FIELD(status, VM_L2_PROTECTION_FAULT_STATUS,
> FED);
> -     /* reset page fault status */
> -     WREG32_P(SOC15_REG_OFFSET(GC, GET_INST(GC, xcc_id),
> -                     regVM_L2_PROTECTION_FAULT_STATUS), 1, ~1);
> +     if (!amdgpu_sriov_vf(adev)) {
> +             /* clear page fault status and address */
> +             WREG32_P(SOC15_REG_OFFSET(GC, GET_INST(GC, xcc_id),
> +                      regVM_L2_PROTECTION_FAULT_CNTL), 1, ~1);
> +     }
>
>       return fed;
>  }
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> index 88b4644f8e96..b73136d390cc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> @@ -672,7 +672,8 @@ static int gmc_v9_0_process_interrupt(struct
> amdgpu_device *adev,
>           (amdgpu_ip_version(adev, GC_HWIP, 0) >=3D IP_VERSION(9, 4, 2)))
>               return 0;
>
> -     WREG32_P(hub->vm_l2_pro_fault_cntl, 1, ~1);
> +     if (!amdgpu_sriov_vf(adev))
> +             WREG32_P(hub->vm_l2_pro_fault_cntl, 1, ~1);
>
>       amdgpu_vm_update_fault_cache(adev, entry->pasid, addr, status,
> vmhub);
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
> b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
> index 7a1ff298417a..8d7267a013d2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
> @@ -566,9 +566,11 @@ static bool
> mmhub_v1_8_query_utcl2_poison_status(struct amdgpu_device *adev,
>
>       status =3D RREG32_SOC15(MMHUB, hub_inst,
> regVM_L2_PROTECTION_FAULT_STATUS);
>       fed =3D REG_GET_FIELD(status, VM_L2_PROTECTION_FAULT_STATUS,
> FED);
> -     /* reset page fault status */
> -     WREG32_P(SOC15_REG_OFFSET(MMHUB, hub_inst,
> -                     regVM_L2_PROTECTION_FAULT_STATUS), 1, ~1);
> +     if (!amdgpu_sriov_vf(adev)) {
> +             /* clear page fault status and address */
> +             WREG32_P(SOC15_REG_OFFSET(MMHUB, hub_inst,
> +                      regVM_L2_PROTECTION_FAULT_STATUS), 1, ~1);
> +     }
>
>       return fed;
>  }
> --
> 2.17.1

