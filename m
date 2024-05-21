Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA15CC25B74
	for <amd-gfx@archiver.kernel.org>; Tue, 21 May 2024 06:11:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0B0EA10E01F;
	Tue, 21 May 2024 06:11:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="C8uoL46/";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2045.outbound.protection.outlook.com [40.107.236.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B637710E01F
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 May 2024 06:11:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=THWbyEcsfhkFIgBl/frBtAG0Q6+bs2Xpwm4vgySsF+RSkNwRxdZpBq60R4QDA1E39sqpSXD/o1OakUqutmfAii6tBG4reBbv9gjqdG4pZFllsqo3EeO6OB2CBT2EdL++KJqhgksbDr15n20pKS8yfPyXBe7eqia+GEhwY041KQtdAcoq845/CupGiGHSEUaFpX0wwCEaOJlsl36OkGVTPOvAiPB+nDt2ANNKfyaYpDtjW3LogAoOp7J8g1tE6sK0w4SN+hcsyRh+Emxy5fbLxx7nbCEp1k6mPj2WfyNMmAOYVGYhxY9zORfD+w51lyFuv4UT+PEnlD8pQlJl8gfgHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kD/R1gSXn3q5HSTP+AGsKpBEIS5LRywJ6iKZ6cKZ4wY=;
 b=eAY69iFhfLZACx9AcvFJ6m/sP8bLAcymM+wF2ZjGajl1JxFspB6jSG6gX3/Pi0RKFu08ssRrYTAthO/zGQVW1Kh2Ftik3gX+sgmhkAacYh3cqem8OwulP4nvrfr3JoxSYkHlwEG2oRzgNpiCT3og8mT+PBVOLk3y5z5QSPLjQRQLEItoY7CHDuXVw8vB7Xg1OFI3dDgZVfMQBb/W6eXxiQ5MAEAtwbw4qr5bHqHq4mPqGElOerCTOS6M1ThwMec1oQ0DB+9FDqUYJYnE0HgqgUzkTj3NjZsit7mlXb8pu3cKvRrqnitSym9rFRg0lD11aMAz7C12e23iD4LNN7a59A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kD/R1gSXn3q5HSTP+AGsKpBEIS5LRywJ6iKZ6cKZ4wY=;
 b=C8uoL46/kuJxkiuh6io8P00lX+O7jHqP01PVwp3dSOlMFjnWJq92k4WQd/+zq6TXJQ9i/VeIolfAe5B3tY48KZcpNHnrI9D0zMPoC0Z1eVYmW5a00pblTmJ0Gu6oORIlWzrC9KZHobJ/j6TIqzUtndE58RMsH7lN8GCK5dPtCKk=
Received: from CH3PR12MB8074.namprd12.prod.outlook.com (2603:10b6:610:12b::9)
 by BL1PR12MB5923.namprd12.prod.outlook.com (2603:10b6:208:39a::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Tue, 21 May
 2024 06:11:34 +0000
Received: from CH3PR12MB8074.namprd12.prod.outlook.com
 ([fe80::7f58:8648:262d:89e9]) by CH3PR12MB8074.namprd12.prod.outlook.com
 ([fe80::7f58:8648:262d:89e9%4]) with mapi id 15.20.7587.035; Tue, 21 May 2024
 06:11:34 +0000
From: "Huang, Tim" <Tim.Huang@amd.com>
To: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>,
 "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
Subject: RE: [PATCH 4/4] drm/admgpu: fix dereferencing null pointer context
Thread-Topic: [PATCH 4/4] drm/admgpu: fix dereferencing null pointer context
Thread-Index: AQHaqy6kf+XIBVmy4UCRO3dTsOZlTLGhMu2w
Date: Tue, 21 May 2024 06:11:34 +0000
Message-ID: <CH3PR12MB80741397D72C5073520DD833F6EA2@CH3PR12MB8074.namprd12.prod.outlook.com>
References: <20240521032550.288684-1-jesse.zhang@amd.com>
In-Reply-To: <20240521032550.288684-1-jesse.zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=c502bf7f-46d9-4916-8939-f642410fe205;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-05-21T06:03:48Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB8074:EE_|BL1PR12MB5923:EE_
x-ms-office365-filtering-correlation-id: 85a777b4-33e9-4369-f30e-08dc795cddec
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|366007|376005|1800799015|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?Q1OvtyEObsVuXyowlfpmhrKt6brLfjOAYZoBRAe14PABHlL4n7DJqPm7TkJZ?=
 =?us-ascii?Q?mbyWB4FThBRQfgJb0IrOnQ6FlGCDaP/h57OWLQAgjlNSWAOrlH6DO2t8TzyK?=
 =?us-ascii?Q?qnJGDVjsjYBuROKG3vhQOArINn7YKkJnBF0GvAHpb/m2llU7IY44R0CE6c3M?=
 =?us-ascii?Q?iwnTyn5BMW9OCRIGjWHekONNRQydMpTxUtNG8GIqCsLFpo04S+2ssjcyrYJZ?=
 =?us-ascii?Q?WQQJp75hkZKLTxN8dhYOIfBF558vtePalFd2bdn1FTTPBPQkOcwAR2Jo+eit?=
 =?us-ascii?Q?UycqfZ6dsUlLKhLY4JGRZKfU8NnM/1kOEQK9K/nePCGEJFUZSlwdhlrbmblb?=
 =?us-ascii?Q?aGZHbbVkSE9e3r4b2EDBm2VO/qUZLbQFrubwPCWvyKvE6ZtZUVbVlJtVUkPP?=
 =?us-ascii?Q?U/MQbWtJFwxaqGtK0ZHuHkvrCFIpsQSV9Zn4SUF7z3ZMSK+PDF23ULKeuRas?=
 =?us-ascii?Q?QJgcaDkkrvhiXj2jPpj1fIgL1Ni7zvdivqovhCVfyV3efcAn25gN6QQBg2ik?=
 =?us-ascii?Q?0csF7mNCxGUCSG/J0cSYbeMuXekaKpfEpNZ9f5MmHpgFhsm663q+59Rgk6l0?=
 =?us-ascii?Q?3U8HjpnucBdkfHU/8yTlbniRWUlBwrJdBcrrAis31RHaUlBiZn238h8aGITU?=
 =?us-ascii?Q?GWrhPj51VQyBi85FedFdGJt+DHb+7kkJ6gWi38gBideqBkQpUnwGwnskU8LV?=
 =?us-ascii?Q?2CWDizd/PI2DmYfwfJvE0MOW6BXdFYUHbbdvuOz9F3YQaNdLhZ0VdFglSTwt?=
 =?us-ascii?Q?2X6juT5RPt2Yny6qE/Ms/rhQaRoywCU6OeHusSZDfY5lrzy/C9xrPt6sY6Be?=
 =?us-ascii?Q?1442c/eOWCsBdhVQD3bcQBtlDTuqH+lsKRR7AqQamBsO/onOtZEyH5c1rvou?=
 =?us-ascii?Q?oieV86G0RuQPEYfwmFrkcrDxWa3N1V04TsTdxS8WuPE2js7q0sYHx/rArfeb?=
 =?us-ascii?Q?CR7Zm1RCJk48uO4jePGgVA0k7vOWXBqizMrDmqf6ZiD2QJUpMkNkvGInvnch?=
 =?us-ascii?Q?2J5GDMuvOn4s/lNvWgwSU/IaeLhbI+TeeLZlNSWuJ2DW6AuF3rhPE7fJANTu?=
 =?us-ascii?Q?SZ/bgEcJFNrO1m1RrZavEmf7dSDB3pJoXyYaRyT42999/lre7Zj7USSaMTeG?=
 =?us-ascii?Q?mCTG137VAoO2r+BTBlEfXxLOBpkGx35Vx9iQ5IBN5YTmRl00bCcktANPDBmd?=
 =?us-ascii?Q?9kWeHUGsgmVzuGqEUzwAo8EjcdlSgjv1Gcyatu7X0QhVUaHFFjUaiPj2dedz?=
 =?us-ascii?Q?G1l0d9sfiSohiZ3N+ZbybpikKsGaoZ9uPjh6WDuMjsFa0+/WJjR+5r9h5VEy?=
 =?us-ascii?Q?j9txSB/SPBOjYRNUFDGQs5sh?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8074.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Phf+7dOSZpuQ8VFpHB7leMTvt/yHfs1hRQCOFimdZY8gDdc63VN0y5hJT/wV?=
 =?us-ascii?Q?7htG9QIes2bci0B113ODU2JmaFhE5gqA4F6Ehr5ptavutbE8PtXFhKbxNgdA?=
 =?us-ascii?Q?XO1dRafyUV62QG1xkEBsRp6tJ2qaz1ZZ/a9Lprsl7Xx+78Dw741Cl9jY4lqA?=
 =?us-ascii?Q?j6C51Ci0sqEbx4GPAOq2BBcRMuEdC6wblFpW2Zpaed7nxqxA8kjA18qsgF+L?=
 =?us-ascii?Q?s3OutsjECBMAythBj7nX91su+/hNrLmn+HtddTfyxGQeGidCGlPYYYPEkydn?=
 =?us-ascii?Q?70QoggCSdJ5zrHTgdobHqFAR0BaJxtR9YQes71/4sfXZ+orRdn7bzowS12dU?=
 =?us-ascii?Q?vc9tSl9zwL3noeEsh8+/XdA7BaNgDBqjkBjp0lUf8Q9KEKPXLphlKCUBxBwl?=
 =?us-ascii?Q?Utpt+e72Ojl1wcjcHlb3+eZhr1TW03DSs+b/vaQHRv1H+QPTNTqz1jU/5RDd?=
 =?us-ascii?Q?dnbHEP5+q+WTay4VDQH2guJzHKzV6vyXXB3y3h1TBoi4vW8IvEkByw3AnYg4?=
 =?us-ascii?Q?ixLzPzgPcIEUgCT+f8WRWOUH+2WZ0OZQJqWB8/tR5wAMwdwfEVFd22u1Wkww?=
 =?us-ascii?Q?1HUMBT8cc5jjJOHmThqCVoIzqx+B1xglSLldFGxo42fqdjk8XsUJMp+3uu9h?=
 =?us-ascii?Q?v+buV/UcSKNU6s7Nj6PtE2Fq3+oHy+EYbXVUx08WWO5+qXMWBvuxiN6ud8Yb?=
 =?us-ascii?Q?atjtI5BVTXJOVK6NTI445vFS/Mc/bcSdc1i5FD0hVNdlO0guxxHi4z5F5i5R?=
 =?us-ascii?Q?41Tm0rbZCf15QvH2w4Nn+XmuxrIVXlQxXxFX7dYJBPFOkzYoVkwjydAF7BPY?=
 =?us-ascii?Q?1BWMPTl33elQ9+u+y5N2lypNyKFa7yUljQoXKQV/ekLYDvQmpLFZRIfWPmgM?=
 =?us-ascii?Q?CBP4sPqgJ4kjJAUwvwCEwopVyrjsVA7HAWRo/QwkyVgmIVXoU1ahqbNrk8JN?=
 =?us-ascii?Q?CoLipVl2oE9qIn93eGyZcxK3MJK1+ew6/W1ZlLLBPjp5zibxDrphUpJvTKnr?=
 =?us-ascii?Q?RwJ4UfDn3JGVpjeVgMP8vVIqOtF3OBsGm2ENSfQmCJo71TlCLqv6eNJDXLpP?=
 =?us-ascii?Q?Mcn/g0XcErBYgUIzEH+Qx+YoaFxxxJ43AGoi0lyM+UtlWcIBYo9Og86+Rrof?=
 =?us-ascii?Q?AKiknjfgPRurgb897HroQWdq/oN5ukvTkgYTDaS2tYEoypfMArE5K/S8gsbT?=
 =?us-ascii?Q?keK6vrFD6PcQKhkBGQcNCQEcb1urQ7PKEzkOWwsDmxCoej40HoToLmU7bJpS?=
 =?us-ascii?Q?Ch/LwcIIih+xmW/Hd8wFbtgro4n5DVTHOfI0r42yHBvBAYRn1JWgzfY4lnbS?=
 =?us-ascii?Q?coIEsdbRxIJbnZSXQkci6ppQj8dkzJseFh7jbn/Xdz7SopJ3mBUhDmD6ZNdz?=
 =?us-ascii?Q?rxntO/qRxClR4OXRihr+bYxFAsDIK8Ef2pfapNHeSxPJEwtcJgZy3FcZE/mV?=
 =?us-ascii?Q?YRVbu4Wk1sp7AHOmkxWvdekjYGc1gjkeIpHTBTkkSz/H58S4gyeBOLUGgniA?=
 =?us-ascii?Q?NOg8WgXOY54vw9VMFmdXgJh3MispnhepOEEaT7OI6fVrota2mamWU23zNSOf?=
 =?us-ascii?Q?GNhOlbeyEdnusqAcxiI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8074.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85a777b4-33e9-4369-f30e-08dc795cddec
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2024 06:11:34.6434 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Y9bB6T+TAg57ZLFSR+MbjZ2/tgPrdrt7id+I14/C0DK0clYxcJp/y9r24St7HFx46kAn6Dz4KjeMGsBj8cUNdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5923
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

Hi Jesse,

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Jesse
> Zhang
> Sent: Tuesday, May 21, 2024 11:26 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>; Huang, Tim <Tim.Huang@amd.com>; Zhang,
> Jesse(Jie) <Jesse.Zhang@amd.com>; Zhang, Jesse(Jie)
> <Jesse.Zhang@amd.com>
> Subject: [PATCH 4/4] drm/admgpu: fix dereferencing null pointer context
>
> When user space sets an invalid ta type, the pointer context will be empt=
y.
> So it need to check the pointer context before using it
>
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c
> index ca5c86e5f7cd..ac1f423dd28f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c
> @@ -334,7 +334,7 @@ static ssize_t ta_if_invoke_debugfs_write(struct file
> *fp, const char *buf, size
>
>       set_ta_context_funcs(psp, ta_type, &context);
>
> -     if (!context->initialized) {
> +     if (context && !context->initialized) {
This can help to avoid using the empty pointer context but still needs to h=
andle the context =3D=3D NULL case and return an error.

Tim
>               dev_err(adev->dev, "TA is not initialized\n");
>               ret =3D -EINVAL;
>               goto err_free_shared_buf;
> --
> 2.25.1

