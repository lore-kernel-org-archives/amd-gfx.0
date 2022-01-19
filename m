Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96E63C433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Jan 2022 00:08:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D83FD10F070;
	Wed, 19 Jan 2022 00:08:34 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2070.outbound.protection.outlook.com [40.107.236.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B5B1910F070
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Jan 2022 00:08:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R5CC/fP1QTzkDNroyGzLSdSGtGn+5MVLw6P5b/FGyJrFFBBsyAV8t9CmyvNj54XuJbhscLVXNiT72QJKcuHKns1cNP4V8FGRanPuaTeHSgF8zAYD6vger/bMl9uIXA7EvHkSNgT/NqlV8cPCgPkZTjiF41bAGK9fOuXUCAinIeqhSw4NXP9PPUC2J836VFSjwTE5/osnYzo4IRQ5V06554p57mUpZX+y77Sn3DE2cJB2mxCEvbWyF6ycB2p4bZgg9pacRGFB4V+LvG/JKubndmSPj5B0RIxzr6xkg+kBD0MdDg5cMEfTe8m1O1+MFxOSLnUamcaYTaYmgcS07Q7lwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ly3B+g8oqlr4ru2RLqX7vtC9vk3STlzRClubC0CkmJU=;
 b=XqVfcUIq6mOJGQxZniQNMhrdW3zRiQmbHmryjp7LSZke7ecpFvwR3wGEsJzZ0j6/Z6EgVR1xcjWgjclMP0mPULYrIY2qWS3USMBnGC/16+35LI3CptDymFF10tMWgdjAmf7KlzMsy6gSHAWRO7O2lPp2wYty9bnxjpGCanF/IEbkBIEKYRTVHwCe5D8GH5kgw7jzM+lABPuBQYyQhy/3Cdzh3vxQGw41VSbq1Gv+Kik2Zg8axyigX3lXSoTaJf2dHVMlpBWvx7fsBAeBbHBxvVThdqMuc046oJptCYYRMpCKIWMMocubuv69/Uo3WNonq9UACZWivEcTNpdL5OLW0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ly3B+g8oqlr4ru2RLqX7vtC9vk3STlzRClubC0CkmJU=;
 b=pyKp8nsAcCThuoYA4OxBCK6ABRv/CawSscjmu81/wolO2VQ+i/6p3n8JqmrdOYnytTc9All/+JUfKoPGuFoO6iUk6ZXEsmJ+8dW6FZSBJTll6oyV2T+5QUOw1EAQT+QdOehHfAaZ1ASaMJHTy+EIv+dVjtNAoGKlce7hMjMQ39k=
Received: from DM5PR12MB1308.namprd12.prod.outlook.com (2603:10b6:3:76::7) by
 BN6PR12MB1777.namprd12.prod.outlook.com (2603:10b6:404:104::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.7; Wed, 19 Jan
 2022 00:08:25 +0000
Received: from DM5PR12MB1308.namprd12.prod.outlook.com
 ([fe80::b975:de48:9987:2ea4]) by DM5PR12MB1308.namprd12.prod.outlook.com
 ([fe80::b975:de48:9987:2ea4%11]) with mapi id 15.20.4888.014; Wed, 19 Jan
 2022 00:08:25 +0000
From: "Russell, Kent" <Kent.Russell@amd.com>
To: "Kuehling, Felix" <Felix.Kuehling@amd.com>, "Huang, JinHuiEric"
 <JinHuiEric.Huang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdkfd: enable heavy-weight TLB flush on Arcturus
Thread-Topic: [PATCH] drm/amdkfd: enable heavy-weight TLB flush on Arcturus
Thread-Index: AQHYDL0fyZH/Oz956ku+GOPqPt3eQqxpbwKAgAAIm0s=
Date: Wed, 19 Jan 2022 00:08:25 +0000
Message-ID: <DM5PR12MB1308928E28F9CAAB947F9E3585599@DM5PR12MB1308.namprd12.prod.outlook.com>
References: <20220118224513.26563-1-jinhuieric.huang@amd.com>
 <b4572e2d-7898-9740-c1f6-15c22aca12bd@amd.com>
In-Reply-To: <b4572e2d-7898-9740-c1f6-15c22aca12bd@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 86b1687f-f550-4cfd-61b4-08d9dadfd059
x-ms-traffictypediagnostic: BN6PR12MB1777:EE_
x-microsoft-antispam-prvs: <BN6PR12MB177751A27DE37B657C04BA6585599@BN6PR12MB1777.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rAqBxC1ysWiEJAbedF6UHEjEuPVZXfhw5giqA6Xi+VevmQEwFMgWxmIqJT/Ur20aUw1gqJPLg9pCJL1/vNPdXT6CIcH0GE4XDRCgR43bG0HgMQz8aiYWBQ8sIc3bqLHvVF0Nc6/3zil76SOt0xcY/6srGR9j+5EUET3ZO6GhKyzfqVuFCyjSNPKpkWttDB9vsfMZYwUFMcAyJ4pbPB1aCCjA1nG7TplvmtPnLYAmcPPmZmmEMD0eSAzVmSKlX9k0nP+poySqg/2WLEo4FEpBKkPuM+0+aUtng7kwZ3xbW9RpQbhy5bpapOFtRWctin6v6ge0tVaiTEx8Yie6kqiah01mSfFPT6gCbobUcVFvLBgybA7GtCcZ9295iPp/BMnai9/S+dRUvvkWoNoz9MJWAY5M+/6mnjk/zyv3ch1Y4bUfREeD0NRcqFy0ZSNyUhz9KjWtrF4u+sTF10gF8MHmHxsAmKQ7W7o915m4g6V8hYwzM390gYljnCJ2YjSuafmt8smGazGsN6rs0Eecr/CXNgcvcta1KKcIl9VBa78zH/jHwgbzAS2s4bMJW9YEcugDkoTETbEc39383YUj+fH8M8ryp1e199IY10P92kPeEZ59I44U/uNMvsNwHm5qVNyjm1IOHp1JGS6Nl0l945U+jrrru+AlNk51fzoD4hM8mD3sqVaubP3u+QpP5BtTQDVUXGf5I3IWwgCEtATgV+mTVGm0ZvEVpGOuO6ihNp+JxXo=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1308.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(53546011)(6506007)(9686003)(86362001)(110136005)(8936002)(71200400001)(316002)(2906002)(508600001)(7696005)(40140700001)(122000001)(38100700002)(186003)(66556008)(64756008)(66446008)(66476007)(26005)(91956017)(76116006)(66946007)(8676002)(55016003)(33656002)(5660300002)(83380400001)(52536014)(38070700005)(16393002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?v2axt5wHEwDhLbbC/bs1VdDGlrD0VG3/KV2XhiLkvyukmtYJyy+fal2Rin?=
 =?iso-8859-1?Q?FcBg2gy+jzVs2bST5DfE2mmOdhVDp6jmyBvtmioTgdhSGzoIBNudDeVENy?=
 =?iso-8859-1?Q?zKeD9F9H7iYn1mIUXKHD+WJy1S2tlH706Vn8PLKD6pdirGhsP6PpKSh5WJ?=
 =?iso-8859-1?Q?XbfelRmSRp2QnJnLsfoUR0dWJaVRjjFpmkVz4wH+2Qq6wzhh4TWm69Fm+s?=
 =?iso-8859-1?Q?LxhqLItTrMYyspxVIQEjtV7l8efe0tz71KOU14blsDaqY4b8OOmwUuZjMV?=
 =?iso-8859-1?Q?pH5LncYNa9Y5B2cQoYwLQz73bj7faHAz3EAwynn6RQhZCZQ7NVf87y9SHa?=
 =?iso-8859-1?Q?jeA+i7UtDAUomGpYU/G/7T6E/FRVgkfeNA78O4gmwZCRfioLUCh92/r0Zp?=
 =?iso-8859-1?Q?CKD10kbWz9eUm1iHCc1orf89a3CugG8zBmpmSJwztCSIiqoJQh2UrmuBNs?=
 =?iso-8859-1?Q?5x/ALII24q3CBu/SEl6qPdmJu81L9RPIW8sKp2BmOlcXI/Cyk9FaNqT55c?=
 =?iso-8859-1?Q?E3xSgyksZf3I98XJVG6QrPfynYPdStns6wUJ1/dQ4oJKWz7nXJy27Vm46m?=
 =?iso-8859-1?Q?v8LixaZbB0GIT9nCn/l9vVWAA/mY9F2U/h/o+qpKPEFJnfF05PIyKqjZIq?=
 =?iso-8859-1?Q?MDNu+izBzjSEyLh2PMBWfM1uEOSOtojFitNw7VaJP4+smOKuJLF7MVByIt?=
 =?iso-8859-1?Q?dwhC5i1fZH62owerX10y97X0lCYEQYP0VSi7WfzR0bRg/yFuX1BSLxY68U?=
 =?iso-8859-1?Q?WE2hhCuAziWDTzNxAwSIuNU2DSuJWJifMEQqm4HnPyMCMqJpEpsKwXjLi0?=
 =?iso-8859-1?Q?pM1ZkRxZXsC3nVtI9rWW0Fnnki6lUQKKBqrv37flEJ2LuGjir5Z5y9L94z?=
 =?iso-8859-1?Q?aDE00ZDcWkgxFLQ/Qd6s370teeUD7k0jdqUjjoYUaKiDFrfvPy8njrIix1?=
 =?iso-8859-1?Q?cd85SC1hG/485M9Xh7Odez3xp6yuyGeepgrwS/Lh1jCWe15gWYyuxwxkPp?=
 =?iso-8859-1?Q?TeTAYF75nhHVcMQ+911niSwv+CkPbOeZe7prmjeeNXcnM2+XvZAWbaZoof?=
 =?iso-8859-1?Q?wwe8KAs+0iNoS0Z0n92K0JaVDdk1r8bsGlRHJuLJwWdQka3eEnHOf3U+vP?=
 =?iso-8859-1?Q?NTaBSkp2KrEK+pK0vZ1NMVYJQ97yhruriT4f7EQzL7yXpmYYQidLfBV7k1?=
 =?iso-8859-1?Q?DKtm61RvggPtoI+l7Ya/P+TZ7zLq7fPOt5roiYUWPChZ2TKPurgSxbcI7z?=
 =?iso-8859-1?Q?BmBlYa2BOascTpSjdJ0PLVwQLj/eoArcz5J8KEZCwTCuzf421Hak4SzCRR?=
 =?iso-8859-1?Q?9bq7Z07pOYW3niNNtcsX6BNFySr9E+n3alZlAx5sGKjYvgXiu4ZQ38T3yX?=
 =?iso-8859-1?Q?BYtJ+Oc8tGxOx9J5JaQ1JvxuncmrD7jduvofLMHfVMXsc39lOgBx1ulppA?=
 =?iso-8859-1?Q?WJ0vRSE/qgIPBf/qv3KiuLXli+OCku+B0+OM2XBBKk++jzonIvOkXkhEGi?=
 =?iso-8859-1?Q?B9qoOyryhiTbMtkPQN4Ap4pEtgMoRSX+Sf8Ns6GbAN2aTHge6h7MzAY5ge?=
 =?iso-8859-1?Q?6lb0FaFO78c9Rg8UFXyN+CWYUYN0hHALKCOY10mi519Y/8iuB1Lssox42m?=
 =?iso-8859-1?Q?aHOdU0JwgSU7U48CBLNxQ2gdyKT4cG3CdTX68PV3MO5gujotyssYauqA?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: multipart/alternative;
 boundary="_000_DM5PR12MB1308928E28F9CAAB947F9E3585599DM5PR12MB1308namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1308.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86b1687f-f550-4cfd-61b4-08d9dadfd059
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jan 2022 00:08:25.6466 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: diBoNyko7jANePh74utqrNq9a1PE6a5fCTz5MVjxLxDHrqXptDbOFzuRXg/6Qf7EosmIDBGC8okYs3eDSnvelQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1777
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

--_000_DM5PR12MB1308928E28F9CAAB947F9E3585599DM5PR12MB1308namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

One question inline


KENT RUSSELL
Sr. Software Engineer | Linux Compute Kernel
1 Commerce Valley Drive East
Markham, ON L3T 7X6
O +(1) 289-695-2122 | Ext 72122

________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Felix Ku=
ehling <felix.kuehling@amd.com>
Sent: Tuesday, January 18, 2022 6:36 PM
To: Huang, JinHuiEric <JinHuiEric.Huang@amd.com>; amd-gfx@lists.freedesktop=
.org <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdkfd: enable heavy-weight TLB flush on Arcturus

Am 2022-01-18 um 5:45 p.m. schrieb Eric Huang:
> SDMA FW fixes the hang issue for adding heavy-weight TLB
> flush on Arcturus, so we can enable it.
>
> Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c |  6 ------
>  drivers/gpu/drm/amd/amdkfd/kfd_chardev.c         | 10 ++++++++--
>  2 files changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/g=
pu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index a64cbbd943ba..acb4fd973e60 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -1892,12 +1892,6 @@ int amdgpu_amdkfd_gpuvm_map_memory_to_gpu(
>                                true);
>        ret =3D unreserve_bo_and_vms(&ctx, false, false);
>
> -     /* Only apply no TLB flush on Aldebaran to
> -      * workaround regressions on other Asics.
> -      */
> -     if (table_freed && (adev->asic_type !=3D CHIP_ALDEBARAN))
> -             *table_freed =3D true;
> -
>        goto out;
>
>  out_unreserve:
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/a=
md/amdkfd/kfd_chardev.c
> index b570c0454ce9..485d4c52c7de 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> @@ -1596,6 +1596,12 @@ static int kfd_ioctl_free_memory_of_gpu(struct fil=
e *filep,
>        return ret;
>  }
>
> +static bool kfd_flush_tlb_after_unmap(struct kfd_dev *dev) {
> +     return KFD_GC_VERSION(dev) =3D=3D IP_VERSION(9, 4, 2)

Do we need to add a check for sdma ver >=3D8 here?

||
> +            (KFD_GC_VERSION(dev) =3D=3D IP_VERSION(9, 4, 1) &&
> +             dev->adev->sdma.instance[0].fw_version >=3D 18);
> +}
> +
>  static int kfd_ioctl_map_memory_to_gpu(struct file *filep,
>                                        struct kfd_process *p, void *data)
>  {
> @@ -1692,7 +1698,7 @@ static int kfd_ioctl_map_memory_to_gpu(struct file =
*filep,
>        }
>
>        /* Flush TLBs after waiting for the page table updates to complete=
 */
> -     if (table_freed) {
> +     if (table_freed || !kfd_flush_tlb_after_unmap(dev)) {
>                for (i =3D 0; i < args->n_devices; i++) {
>                        peer =3D kfd_device_by_id(devices_arr[i]);
>                        if (WARN_ON_ONCE(!peer))
> @@ -1806,7 +1812,7 @@ static int kfd_ioctl_unmap_memory_from_gpu(struct f=
ile *filep,
>        }
>        mutex_unlock(&p->mutex);
>
> -     if (KFD_GC_VERSION(dev) =3D=3D IP_VERSION(9, 4, 2)) {
> +     if (kfd_flush_tlb_after_unmap(dev)) {
>                err =3D amdgpu_amdkfd_gpuvm_sync_memory(dev->adev,
>                                (struct kgd_mem *) mem, true);
>                if (err) {

--_000_DM5PR12MB1308928E28F9CAAB947F9E3585599DM5PR12MB1308namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
</head>
<body>
<div style=3D"font-family: &quot;segoe ui westeuropean&quot;, &quot;segoe u=
i&quot;, helvetica, arial, sans-serif; font-size: 12pt; color: rgb(0, 0, 0)=
;">
One question inline</div>
<div><br>
</div>
<div><br>
</div>
<div>
<div id=3D"divtagdefaultwrapper" dir=3D"ltr" style=3D"font-size:12pt; color=
:#000000; font-family:Calibri,Helvetica,sans-serif">
<div style=3D"font-family:Tahoma; font-size:13px">
<div style=3D"font-family:Tahoma; font-size:13px">
<div style=3D"font-family:Tahoma; font-size:13px" readability=3D"8"><font f=
ace=3D"Verdana" readability=3D"6"><font size=3D"2"><b></b></font>
<p class=3D"MsoNormal" style=3D"margin-top: 0px; margin-bottom: 0px;"><a na=
me=3D"_MailAutoSig"><b><span style=3D"color:black; text-transform:uppercase=
">KENT RUSSELL</span></b></a><span style=3D""><b><span style=3D"font-varian=
t:small-caps; color:black">
</span></b></span><span style=3D""><span style=3D"font-size:10.0pt; color:b=
lack">&nbsp;&nbsp;</span></span></p>
<p class=3D"MsoNormal" style=3D"margin-top: 0px; margin-bottom: 0px;"><span=
 style=3D""><span style=3D"font-size:10.0pt; color:black">Sr. Software Engi=
neer | Linux Compute Kernel</span></span></p>
<p class=3D"MsoNormal" style=3D"margin-top: 0px; margin-bottom: 0px;"><span=
 style=3D""><span style=3D"font-size:10.0pt; color:black">1 Commerce Valley=
 Drive East</span></span></p>
<p class=3D"MsoNormal" style=3D"margin-top: 0px; margin-bottom: 0px;"><span=
 style=3D""><span style=3D"font-size:10.0pt; color:black">Markham, ON L3T 7=
X6</span></span></p>
<p class=3D"MsoNormal" style=3D"margin-top: 0px; margin-bottom: 0px;"><span=
 style=3D""><b><span style=3D"font-size:10.0pt; color:black">O</span></b></=
span><span style=3D""><span style=3D"font-size:10.0pt; color:black"> +(1) 2=
89-695-2122<b>
</b><span style=3D"">| Ext 72122</span></span></span></p>
</font></div>
</div>
</div>
</div>
</div>
<div><br>
</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Felix Kuehling &lt;felix.kueh=
ling@amd.com&gt;<br>
<b>Sent:</b> Tuesday, January 18, 2022 6:36 PM<br>
<b>To:</b> Huang, JinHuiEric &lt;JinHuiEric.Huang@amd.com&gt;; amd-gfx@list=
s.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Subject:</b> Re: [PATCH] drm/amdkfd: enable heavy-weight TLB flush on Ar=
cturus</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Am 2022-01-18 um 5:45 p.m. schrieb Eric Huang:<br>
&gt; SDMA FW fixes the hang issue for adding heavy-weight TLB<br>
&gt; flush on Arcturus, so we can enable it.<br>
&gt;<br>
&gt; Signed-off-by: Eric Huang &lt;jinhuieric.huang@amd.com&gt;<br>
<br>
Reviewed-by: Felix Kuehling &lt;Felix.Kuehling@amd.com&gt;<br>
<br>
<br>
&gt; ---<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c |&nbsp; 6 -----=
-<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdkfd/kfd_chardev.c&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; | 10 ++++++++--<br>
&gt;&nbsp; 2 files changed, 8 insertions(+), 8 deletions(-)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/driver=
s/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c<br>
&gt; index a64cbbd943ba..acb4fd973e60 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c<br>
&gt; @@ -1892,12 +1892,6 @@ int amdgpu_amdkfd_gpuvm_map_memory_to_gpu(<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; true);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D unreserve_bo_and_vms=
(&amp;ctx, false, false);<br>
&gt;&nbsp; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; /* Only apply no TLB flush on Aldebaran to<b=
r>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * workaround regressions on other Asic=
s.<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (table_freed &amp;&amp; (adev-&gt;asic_ty=
pe !=3D CHIP_ALDEBARAN))<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; *table_freed =3D true;<br>
&gt; -<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto out;<br>
&gt;&nbsp; <br>
&gt;&nbsp; out_unreserve:<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/dr=
m/amd/amdkfd/kfd_chardev.c<br>
&gt; index b570c0454ce9..485d4c52c7de 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c<br>
&gt; @@ -1596,6 +1596,12 @@ static int kfd_ioctl_free_memory_of_gpu(struct =
file *filep,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&gt;&nbsp; }<br>
&gt;&nbsp; <br>
&gt; +static bool kfd_flush_tlb_after_unmap(struct kfd_dev *dev) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; return KFD_GC_VERSION(dev) =3D=3D IP_VERSION=
(9, 4, 2)</div>
<div class=3D"PlainText"><br>
</div>
<div class=3D"PlainText">Do we need to add a check for sdma ver &gt;=3D8 he=
re?</div>
<div class=3D"PlainText">&nbsp;</div>
<div class=3D"PlainText">||<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (K=
FD_GC_VERSION(dev) =3D=3D IP_VERSION(9, 4, 1) &amp;&amp;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; dev-&gt;adev-&gt;sdma.instance[0].fw_version &gt;=3D 18);<br>
&gt; +}<br>
&gt; +<br>
&gt;&nbsp; static int kfd_ioctl_map_memory_to_gpu(struct file *filep,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; struct kfd_process *p, void *data)<br>
&gt;&nbsp; {<br>
&gt; @@ -1692,7 +1698,7 @@ static int kfd_ioctl_map_memory_to_gpu(struct fi=
le *filep,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Flush TLBs after waiting =
for the page table updates to complete */<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (table_freed) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (table_freed || !kfd_flush_tlb_after_unma=
p(dev)) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; args-&gt;n_devices; i++) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; peer =
=3D kfd_device_by_id(devices_arr[i]);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (WAR=
N_ON_ONCE(!peer))<br>
&gt; @@ -1806,7 +1812,7 @@ static int kfd_ioctl_unmap_memory_from_gpu(struc=
t file *filep,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;p-&gt;mute=
x);<br>
&gt;&nbsp; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (KFD_GC_VERSION(dev) =3D=3D IP_VERSION(9,=
 4, 2)) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (kfd_flush_tlb_after_unmap(dev)) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; err =3D amdgpu_amdkfd_gpuvm_sync_memory(dev-&gt;adev,<b=
r>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (struct kgd_mem *) mem, true);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (err) {<br>
</div>
</span></font></div>
</body>
</html>

--_000_DM5PR12MB1308928E28F9CAAB947F9E3585599DM5PR12MB1308namp_--
