Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F942C369AB
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Apr 2025 05:59:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CC67A10E724;
	Thu, 24 Apr 2025 05:59:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MuwUjJ4R";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2078.outbound.protection.outlook.com [40.107.243.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BDE3C10E724
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Apr 2025 05:59:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v9+Jp2Xlvh0O6zR600J/ladidOIOtyXnTuQ2fwv7BZHpzK33OAY4NOwKxIZjeHrl/WLnygOQOSZV7hkdI7b1jqmaByzJWc1R2XyVfBe/S448ufZ5EuUTvuWdZ5hBb4xdP8auMRWOX9Df3sEiUrwt+ct0Gndv+9qt9i1NlsQ/7Hu6v+NWJ27ytxXbU4kO/SyYjftN0Lwyuo0QB9K+5qZvYMh0Y5UiRMaaQJJskJpzqSKW2naLcGQhdbqruZ+DViSF6Ph3PvfyOH4CaBhq0DoeL5DeIm0UPXQ/vA+mPPtNqT02QAhKZCJ4TaT6auq5sTE93vALvrXKAMOgpcV49E5WQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aX1SIcripqz3G3ow1w6GBn8s3Vpr10DJsz/47vniSeE=;
 b=zNyCR4E7T9zX9XZRFdOaAp2c8+hsQXOLOGOrbWUP1v5SPsuiWTiIj/xD8Ia7LgsuL6F0RSPJkfnlyd6Z2TPNN7uwj6CZBeloEhq4PTLJ+fdO8KEZCaa7FA62uK7PTUt4UJ7AfA+Mwm1wULUhRW2xkQ5G+j3sNpSw2wSrB3LSKUVI/iemikYYVrCHCffB/5S80Ru97jY3BsShHuYe4MrP2JynU+5Pzu6XgCv1NeOSXk9Dv2S965GUePq9wDssCVykP4UtkFa5qQwkabfrTZ8StusCAlLy/AtaIwu3T6fLrLyBL0vgxps5K8ophefRYeBY0nqApoZCBhMla3xbgiYw5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aX1SIcripqz3G3ow1w6GBn8s3Vpr10DJsz/47vniSeE=;
 b=MuwUjJ4RY+62EZ/gMjUEbLalNiWiobOmUE+mVFKbBQ/4eOUgU/veQaf8tG8jVjLZTtrpi+gtV8pIqnAPGnPF0aFhWPRhBPofIyNU//hnzUSZFJq+T2L6nGMGKh1+D0UWAznDkeoDCQQDE1CBjuKteTOBJ/4KrLWpP0QYvmJUdaw=
Received: from DM4PR12MB5261.namprd12.prod.outlook.com (2603:10b6:5:398::22)
 by DS7PR12MB9550.namprd12.prod.outlook.com (2603:10b6:8:24e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.27; Thu, 24 Apr
 2025 05:59:49 +0000
Received: from DM4PR12MB5261.namprd12.prod.outlook.com
 ([fe80::e175:f839:8e2e:2885]) by DM4PR12MB5261.namprd12.prod.outlook.com
 ([fe80::e175:f839:8e2e:2885%5]) with mapi id 15.20.8678.021; Thu, 24 Apr 2025
 05:59:49 +0000
From: "Xiao, Shane" <shane.xiao@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Kuehling,
 Felix" <Felix.Kuehling@amd.com>, "Yang, Philip" <Philip.Yang@amd.com>
Subject: RE: [PATCH] amd/amdkfd: Trigger segfault for early userptr unmmapping
Thread-Topic: [PATCH] amd/amdkfd: Trigger segfault for early userptr unmmapping
Thread-Index: AQHbtDU6F4iFaGa3cEuCFM4kP0SL3rOxMTmAgAEhhOA=
Date: Thu, 24 Apr 2025 05:59:49 +0000
Message-ID: <DM4PR12MB52615EE9E9D0B99EDDDDD9859D852@DM4PR12MB5261.namprd12.prod.outlook.com>
References: <20250423095036.1413882-1-shane.xiao@amd.com>
 <991a1499-69be-494d-bff7-810134a8bbcd@amd.com>
In-Reply-To: <991a1499-69be-494d-bff7-810134a8bbcd@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=abda426e-bd61-46e8-a118-65f17d87388f;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-04-24T05:57:14Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Tag=10, 0, 1, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5261:EE_|DS7PR12MB9550:EE_
x-ms-office365-filtering-correlation-id: cc1bdc30-837c-4805-c527-08dd82f53948
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?jY8TodPGBF+g0ha2VYwezz0737eOCZoAppKkBjhys1BLm0+m7D/nhZLlwJAu?=
 =?us-ascii?Q?mWv+bWuStMBPMHT7hVhLwfBxJbd7WyAp1eYd6THKoRoVdPuuqOPWSWQkB7Iw?=
 =?us-ascii?Q?BwqUkSW48IUzjD0L/QCgipum+8vdrForXj/UH91Ck/hyTuivTI4tMzO5p8yB?=
 =?us-ascii?Q?3H/jgT8ApH8qhe6rkdCIvcGT+NlCtNEvKLmEKzsMwLRRQcvxFdLWyyQYwCxJ?=
 =?us-ascii?Q?8Ipe/rPkZ/p9gCxn8u7aZDWhUOH/00MV5aSeOxNZ7lfaK9CvGvvbq40N7kBu?=
 =?us-ascii?Q?ZT8kGLOpWPScvhyrF56EYqGk6DBlMdMcbalk6FObeIWwv9MIWbH2CBWOohRJ?=
 =?us-ascii?Q?vzpiBkSRLjWq5m0T7yV+LZAGdvEurhLzIYY+1kBfzqtBHrPN9wHMxlGvfnwi?=
 =?us-ascii?Q?7i2rmf0ZigFROIpOk3dcKoQOTDkbu7J//nQiZvWVrb0jciZtQqsmaeJ8uTp9?=
 =?us-ascii?Q?41aGNXAKYHcWtaY3h+Z+FTw9l+OlgaMGQQijsKD+fM5RibOgPAq10I4eIQiz?=
 =?us-ascii?Q?S9UWtyg2BvpiJrKogDdUh53BpK/MjvodXERb0aRwqey3wvlNCwr/Y5t17iRh?=
 =?us-ascii?Q?d3+Kz7+g77Xlp5XVzNwsrBWy/q7LOMDQ8ZUYgPUpdBqLnTl9/H9p+PEaMwTo?=
 =?us-ascii?Q?y9kAEcFc5qA3zdesUTIBXSjz1ZbKluhWfnlGLG5sEhWj2T1cONrTjLssZC4s?=
 =?us-ascii?Q?CqafyBQWbA+BxRM1e6oJ7kzDeDg3Iny4pVkBIMgX4nqtfYQ5HjscPGa82jBf?=
 =?us-ascii?Q?J6szSlpv9Gja1CbWoNUS/GVZC9FRCCnLpn21MB06oMSB+YRgqjllxfTn42+3?=
 =?us-ascii?Q?6FSXfSf/e6X0PaTLBd5ovo/HoZTleMA+6tZ0G/KPqbgCn5j4xJPyLxkgBOiH?=
 =?us-ascii?Q?wvclPQAsQfk7v/Uhki1EBS76YfBST2pzmHn1YyzHeSf8Jf/5w/rZ7R6qTqYq?=
 =?us-ascii?Q?oQKTp2wyrFSmgIhjryMd+aIvkG9fa3o2VflO/Xk+WFQokqZzL9tn5MdgYBRM?=
 =?us-ascii?Q?OIQm0SgoUIu3ESKzFFYiD4igrWha2QXL6qKEiCeukW81N3rUneDI0QizKT9I?=
 =?us-ascii?Q?VZx+eao9AYa4VXAlksc1EFIhW8f3pYsbc7XXX5Bg6yaAj4v8fNEUmc6XX3yD?=
 =?us-ascii?Q?h9pv3Y9vQBxU++bT4Jn52/1bZVmr9AbtpNJ6BYmE5B+tS/GhgmlBb3ycSlPg?=
 =?us-ascii?Q?npR3hvmLVRkBj+ktVd7rw9imFG5+0/f37ks5WeV+QREP+A2XrYrH+753rhSz?=
 =?us-ascii?Q?UHs6+cVoe5eyycD/iar0C5aWSIw6NsrjYNnwAdYAE5dUpHS8Z2KgIIaGcjgG?=
 =?us-ascii?Q?vUx9o2S2L0JWfV2wxIs2MbHtTm7TcnsptSllHMC8uEK0dv2a0eequyeGcbUz?=
 =?us-ascii?Q?dfc7Q1d5phWFNEVZ+z3H/lRMYPhCpP7ABzTe9AFidKFjmx5qIwf/GSMiaQcD?=
 =?us-ascii?Q?0B6puXYkSRQHftHLSlROo4vuejnI1kOZ4gnSWtDSnceBlGw+sS2NgVsNfCWh?=
 =?us-ascii?Q?3ef9lt4D3uHCM6w=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5261.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?CsOAyujJ+eWFy01SD8/7kknL0q2+8CRX+jht4U5dt03izi+VpjRoi9uQf0VU?=
 =?us-ascii?Q?OIH01sN7wxMrAVU3aRbPKriZ0US1mRvGPv4Z/fVhQh3FJXR3HlQA9MhLjYih?=
 =?us-ascii?Q?Bm7m7RFYFtgtmwD5Lyj/4j8ufVZq7gkRNaSiVo6g/MjenGgmbJPULNJOEaoq?=
 =?us-ascii?Q?kCqmaXfZkWaPlZSo+LbjfIXAdZUdOL33MDvw5KeXyoVyAEXNUCxN5rHkhnmB?=
 =?us-ascii?Q?cj6MOUAJJef9OBRNb16ZZPByJqePiOa+oKlR4LJ1tvbrhIoxLQ06ymJH8GZZ?=
 =?us-ascii?Q?NDA9n9w2WGXTAEDrgtA6KxtByBCJ0isZpD09O/ta06RIRSvOmIBtFSXLde0k?=
 =?us-ascii?Q?0T3lF2qB32ERzGv9G35bB3M29M3Tq65bz6/sMFm/OOchRWRJItBu9lUGIEKO?=
 =?us-ascii?Q?Ou/DRmgOyzqCbLTUzSWDwfAKhS3oivH1PjH1OgQKEXgfHleHmLUXdtTn6yiP?=
 =?us-ascii?Q?0YsdnwTw3yylbiNwNVYseRoUg3Ja5xP4Tmpvngpzy1q0+ZWo5aG9s3teCw8P?=
 =?us-ascii?Q?RhqU9qw1aJB81xfJ/QU8+FFK+h7YLsr8g0jyR5spYDOJp+ADMpDkWNQobdes?=
 =?us-ascii?Q?AP0fekx1oN49Z16dKc/LSApwPvWf+FHLImU7cbMytWcP6MmuYFgGf1CrNyzP?=
 =?us-ascii?Q?KY9u74oe2LnaVm70MRgGvNVy0yUUPXLA5Hx4mw7eIheF7XMCFyuRTm9gErDl?=
 =?us-ascii?Q?8xdDamuwurgV4N6s3Zyv1AMOFW/9FCe6D9D80FDEBXHe2vRPN9zmSs0evp9x?=
 =?us-ascii?Q?9j7AUAoSugLadydrxFf7izp6uh4MHPCkrNIeZaWkVFPLXnfmJbFFIS59dmwr?=
 =?us-ascii?Q?LXF78BLAlsAsBkt5gY0H+U8e2aIZqNGuwALKBAeq1zfbHVH6M/x10ygMTV/c?=
 =?us-ascii?Q?QH2Nl90/USyHAvLP1ZyqJAKiQWiyBN0IisV9SG4bp7UoE2pZK71oHkjPxyK+?=
 =?us-ascii?Q?8LmoUGcwsWwMX5eFiqx2PPgUb1tVxNLWyohzo72LsX5C3JoqZaivq68IpWSD?=
 =?us-ascii?Q?oLfiYwH5rGLln3mvfa7LMG2dholrdIbuhXWjn5tyEUWgiNoVnnT45Sx8yYgW?=
 =?us-ascii?Q?ieq+TtWbs5y9Hh73zU7QurvQJKNos1v4Ivz8CtPInT6PWXZXaawVFUYZ53kP?=
 =?us-ascii?Q?gLHj+ld4G6wFYxIBsLp/goCSS6Ql+MNVKGQVuQxEwpuuirtFCutMjnr7aGYI?=
 =?us-ascii?Q?tNSRI99Du/Me8vnH6XC+6+AfM6VREqk0d2dHEvrUn1hkra5NXQTxLkbAVy5q?=
 =?us-ascii?Q?bn6YgqRofqkM47LywPNCbSWVTw23sc3XzfqRP/FQcPvYUfiVeR9nIw/tVHj2?=
 =?us-ascii?Q?lSjw4X4EtuKOvsTMbE2cf6H+usZMWX/AXObU5hkCMdRTnneL0Af2pN8C+uU8?=
 =?us-ascii?Q?J8mjk9Ub6VLUQZ4iYqN+2ckhyfHCMedA945P3uSq2vaodP3MUco8to96AD9R?=
 =?us-ascii?Q?6F8VcfjeHtRxKrFD/dBTYqyeepwkCl1Ucfu+xV1XT4fzP0WM6UO8X2T2w545?=
 =?us-ascii?Q?5CNouJhhx4WzBFFx5COu5uat4GSJWED+Cf9jJj/+HIpIZWtm/rdQjyxJgfYV?=
 =?us-ascii?Q?FiFNNd8oCE5W03Ljsv4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5261.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc1bdc30-837c-4805-c527-08dd82f53948
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2025 05:59:49.5816 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Sv44NXIA85RlniL3YdD1zyzAHjPJ5CnJTF7XgazVb+k5/2NW3CwBUEZbqhFfxLkPAX6kr2Hamho4B2+jh4SuTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB9550
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

> -----Original Message-----
> From: Koenig, Christian <Christian.Koenig@amd.com>
> Sent: Wednesday, April 23, 2025 8:40 PM
> To: Xiao, Shane <shane.xiao@amd.com>; amd-gfx@lists.freedesktop.org;
> Kuehling, Felix <Felix.Kuehling@amd.com>; Yang, Philip
> <Philip.Yang@amd.com>
> Subject: Re: [PATCH] amd/amdkfd: Trigger segfault for early userptr
> unmmapping
>
>
>
> On 4/23/25 11:50, Shane Xiao wrote:
> > If applications unmap the memory before destroying the userptr, it
> > needs trigger a segfault to notify user space to correct the free
> > sequence in VM debug mode.
> >
> > Signed-off-by: Shane Xiao <shane.xiao@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> > index d2ec4130a316..259b38424b7f 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> > @@ -2559,6 +2559,16 @@ static int update_invalid_user_pages(struct
> amdkfd_process_info *process_info,
> >                     if (ret !=3D -EFAULT)
> >                             return ret;
> >
> > +                   /* If applications unmaps memory before destroying
> the userptr
> > +                    * from the KFD, trigger a segmentation fault in VM
> debug mode.
> > +                    */
> > +                   if (amdgpu_ttm_adev(bo->tbo.bdev)->debug_vm) {
>
> Using debug_vm works for now, but maybe we should have a separate debug
> flag for this.

I have added a new debug_vm_userptr bit in the new patch series.

>
> > +                           amdgpu_ttm_tt_get_userptr(&bo->tbo,
> userptr);
> > +                           pr_err("User space unmap memory before
> destroying a userptr that refers to it\n");
> > +                           pr_err("The unmap userptr address is
> 0x%llx\n", userptr);
> > +                           send_sig(SIGSEGV, get_pid_task(process_info=
-
> >pid, PIDTYPE_PID),
> > +0);
>
> Drivers should *never* mess with send_sig() directly. We made the mistake=
 to
> allow that with the KFD already.
>
> We should rather send this as GPU access fault or something like that.

Sure, already done it in the new patch.

Best regards,
Shane

>
> Regards,
> Christian.
>
> > +                   }
> > +
> >                     ret =3D 0;
> >             }
> >

