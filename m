Return-Path: <SRS0=P/1w=P4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 190C5C433EF
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Nov 2021 19:24:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0F8A61208
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Nov 2021 19:24:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A0F8A61208
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 29F256E038;
	Tue,  9 Nov 2021 19:24:48 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2066.outbound.protection.outlook.com [40.107.92.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2239C6E038
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Nov 2021 19:24:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k4f5yHxYa1csbsNjspQD5wESEXo5vHFnt3ZdAKObd/zsiA6BZVdxiV02rvfzzfIKG2DUVXo6iQ8rBA0gOHCtXVWyf7DAtrRAMZthOBAxzzghLNzHMp65nED6Cn9uIVEUtIojIdisfkKxQtMt3utyTVDqnXpwi4yfyxv9IqoyEUJ7Sp0VDyYWcvB/8a5Ga58hi9pxuyho+2D4S1AMHgK5IXQ6wINw37ylizBSz7I4AGGwaKgdj4/FTZ2rTlQt2dGK8Cm1kVfP5DuxEZs9goE4lg8J/+YslvBA64+iBPFOaE1l6rMtI99guEqTDzRBzXi0WTJLZ66E6L+vTF/l28V3RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vFwlKJOxXHGgODab5A0s4MTMJju+zI4h3jVNclbILQs=;
 b=CbdnuekmThmwzxy0t7QINE92vpEtWgYHSleHXx5Tfh+X3aYOCg1CpeLWkofB/x6UzwR5t4bgPL4bOTjouD01F2t6RnAhtj2NcBKUhuRR0kEX/ICFiWvdp+ik2NsdaZPSu3WhVcdwHaE44+BbQDJfXBNRGHKJbvuj5UiMx9QNxpFFz+Gbqk6bjZ77/6Fbp0esnB/VwkSr7sT8KYacVr8mjuFh10Yabe3q5IHvVKcbZp1202KxkCJVNfastxWOoI0LZQe9ZNMxhHHQEKJH7vmVB9zXbNolWYIOeIz74q5Qv7tHBucKKIPeN5fFRgw0rKjSC0mGndO6dDsl1sJ4X2crEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vFwlKJOxXHGgODab5A0s4MTMJju+zI4h3jVNclbILQs=;
 b=APSHhGSYtlVTcw+6RxEolQoMBw+LsfuRyNJDefB8v8k7mqO8EtGhuWnIT/DmU7iIW6RvNIb6jj9MS4dT4bi8lgF7taX52WzTPrHD3/cqAVxk6/nvKjZUKyBMK9/68wv2cKtc6VtYl2Ab2a9Yh0PtYm4vOtJMalnR2bAbYu9zlKQ=
Received: from SA0PR12MB4399.namprd12.prod.outlook.com (2603:10b6:806:98::17)
 by SN1PR12MB2397.namprd12.prod.outlook.com (2603:10b6:802:27::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.15; Tue, 9 Nov
 2021 19:24:45 +0000
Received: from SA0PR12MB4399.namprd12.prod.outlook.com
 ([fe80::91ba:8d66:bd75:2ac2]) by SA0PR12MB4399.namprd12.prod.outlook.com
 ([fe80::91ba:8d66:bd75:2ac2%6]) with mapi id 15.20.4669.016; Tue, 9 Nov 2021
 19:24:44 +0000
From: "Errabolu, Ramesh" <Ramesh.Errabolu@amd.com>
To: "Yu, Lang" <Lang.Yu@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Pin MMIO/DOORBELL BO's in GTT  domain
Thread-Topic: [PATCH] drm/amdgpu: Pin MMIO/DOORBELL BO's in GTT  domain
Thread-Index: AQHX1QpvVeATLBE+YUa3UHVfmzoPjqv6qrMAgAAMUJCAAAlVAIAADOL0gADGyqA=
Date: Tue, 9 Nov 2021 19:24:44 +0000
Message-ID: <SA0PR12MB4399F7FF81BC087AD27245E1E3929@SA0PR12MB4399.namprd12.prod.outlook.com>
References: <20211109013744.30464-1-Ramesh.Errabolu@amd.com>
 <YYoGmHxlugJagJ70@lang-desktop>
 <SA0PR12MB43995DF3EBD469BE416B1DF4E3929@SA0PR12MB4399.namprd12.prod.outlook.com>
 <YYoYwLJbI/M7AKcV@lang-desktop>
 <SA0PR12MB43996758E1F3D0CBA6370FCFE3929@SA0PR12MB4399.namprd12.prod.outlook.com>
In-Reply-To: <SA0PR12MB43996758E1F3D0CBA6370FCFE3929@SA0PR12MB4399.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-11-09T19:24:42Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0ca1468a-aad0-48d2-cda4-08d9a3b69639
x-ms-traffictypediagnostic: SN1PR12MB2397:
x-microsoft-antispam-prvs: <SN1PR12MB23970EDD286D64391CFA52F5E3929@SN1PR12MB2397.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RXlIvnCR82Tb6j6iutyxY1wPhZ7o/O2m61U0lAyEcAFK//4xlL96oUboBFFwHFulHaWCfAYWuxl2g5pl0KsWm04DIZ6chk7l2vQ0rv1M4PHAUmybxzC09y0R0w7Y9mgwi101nDgTGFEsDDaQaJHFWhZFsNxGHIKbAXqWaKouB+giynuy3p75amVDv6y/HJhyV0kRzRU3wQGFo/hYx7yGWLxWDEOTsDmVDA8BbAjVTl4jFw9w/9MDg1Ar9esb/ClnGKV51rYpQPuP5P+z3SLfEhnGVR+IPk0nV3JZvMEMupea9hBSfe+UaoeMMEf2aPlIiQzlKMzutWZLjsh9IfdTqiI7cDDSdHjKgHy131FAiAraetC0KqGsFRl7R2OwlkiRmRtqT/s5buah06ggEyNPXeVwEgsQXoc1yT804RU5s6+bQqSRnkeSb+ML7Ab6AE0hKswZuQGSxwOEWDwR2YrfPRfcPaMDJmvQe6odpgnyxwtwCthSlsIoy2Y8dj/EChk9MsZWkDJ+FfK1JPvJbqTaoZQMzr52SolxNGmGYYl/m8VBo1HYem4aooCxcw5GyPpeAXhMyALv09rLQD7hh22EaORzOCuXKDajqEDZwk2OOVrVReH0xHQLOPgJQ36k+lplT2OHMVuHoPpJ8m3IVg/Tj1M/12/dm6sAxUrir/bued2aOrw8L7GOMNlEd4iiR+GWPF5NVca3ZXcoVvTofl6vTg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB4399.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(83380400001)(66446008)(66556008)(122000001)(316002)(2906002)(6862004)(86362001)(66476007)(38100700002)(64756008)(9686003)(76116006)(66946007)(55016002)(8936002)(5660300002)(52536014)(186003)(8676002)(26005)(6506007)(7696005)(53546011)(6636002)(33656002)(38070700005)(508600001)(71200400001)(2940100002)(4326008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?hX5LGWLSBn5xbrefqryHH6EmMbPKQauxlg+4pvlQZmOFbCpBHlWS0xkbIT/9?=
 =?us-ascii?Q?LLysqI4+GDoQdym1XnVweDzaSMO3daWw7+Hc8+6KIvLN06mo4nHu0Jad4d4q?=
 =?us-ascii?Q?+BKc1mVlEM2njjCe5ldH07+VarvWKc8XdrKoOk31nyDken4fuToTPpXCilJ6?=
 =?us-ascii?Q?rc7p8+og+pclxTaaSm2axu+pe29J3UXD34GNJtptnDaUTmmIuAP/X+IRDlgd?=
 =?us-ascii?Q?PdMUw6X9U6X8kMDPzDwuXu4QxOP4c7ZuSZv6jfIg3FiSFlRpCdqAkQxn8KMq?=
 =?us-ascii?Q?SgkN0XxYbJkARSCWSRYbje9cwUQ6xwp6xI5/7pheNSE6V6KJn+F4DgWW06qI?=
 =?us-ascii?Q?Ho1man70CQoTM5mI5x0Uufw2WsdGu62xdYFaeLUJpOduvh0I3CpDwF6DUi7O?=
 =?us-ascii?Q?Z/YEBJAp3IHre7XoXEELmMPdWlbd+WlNWS2tykZJMwellkc+fOqANTtHg1xM?=
 =?us-ascii?Q?RAhPWrL30acRFZn6FuFrSxzc2hf+RW1ML/x+AklR/tYccCuzvl2yqAAClzhB?=
 =?us-ascii?Q?KVM6NUoN5RY+DnCOnqZUpfn0LIUMifyyKKcZ11lzoNgixipVHB2u+M9K1FHk?=
 =?us-ascii?Q?/YRWt7NOJak8EAadJa0ho4+c78Vf/I5Q6THf6iL7tV03sP/pNvbukwteNKsx?=
 =?us-ascii?Q?4dhTiFOaZIRjIlLxxD92Z7em8ZJloxntQg6MmPAVqh4WTLQyiIbZxt3ZRTtb?=
 =?us-ascii?Q?6Lb+K0FrCYqGwzZPGZb5OI7H+Iv9LbsYnjtyTyTbLymjquEdnDpeeskc8ad3?=
 =?us-ascii?Q?yugGBz/ONv8rr4TVwKHGzLensCMb/olmiBW+US2/UzSwbuL3SKv+Z8wchvGe?=
 =?us-ascii?Q?ebvwqBBo3QSk0o0HaomOvhyqPWCzJFLqPuIAdhlk7gFkYrKS54I4b9ck0ikz?=
 =?us-ascii?Q?vHNXXXDV/xl1TWMQP3+8mKSTYKc6tphyCcBxPk5W458JPyJDw9cBaDjnwj3o?=
 =?us-ascii?Q?ENEjxHgYYiltGfO9kgEvxtK8htDaPKHTdofjwyAh2DZ79RZy5x32hcK68kdx?=
 =?us-ascii?Q?CE1ujYwPCetphvfruu33Gn3qcwnoFV0FXTMorcpe3qiQ8DOhJcQOYi4upx96?=
 =?us-ascii?Q?ktYK+PES/y0+2vvf6p6TsUjKCS3G2HQVyAgpOHTD5JO7WdO/4zz86qzNTGJh?=
 =?us-ascii?Q?SFxSRHsWHiFAYde6FBUBU2wAh6tstZE5g6Gie8KwHNVHY+aswOsj9lYIWbY8?=
 =?us-ascii?Q?5WwTQTAefGWqsJoDp3eArQL1q6xw5X6o+zegpfMnj/h1VZdLDrPbhmGz6Dvx?=
 =?us-ascii?Q?PKmGYWNtj/a9hQCbBpDylO2g4fQwu7tWRuWk28Q1+KlzPMagBgs/CGFPx59Q?=
 =?us-ascii?Q?1D4ifWmgSiOoV3/7ZQFKHqJeKqO70BpkWx+vPWnQ5XohEAKHtLEAwL8I/uhQ?=
 =?us-ascii?Q?6FKYB77NKUv5L1lbx+3Qpdy+TiU/0+OLPKc8BcwSKMJlGitWa6sglA7a6ye5?=
 =?us-ascii?Q?BYrykypJfquw0LGOKVP8mTPlY3ioXCP/G+aqgS7mCOZXa7QhJhQ5BKHiEPHk?=
 =?us-ascii?Q?O3J/OH2c7Sm3q48vmadU+4TqlqQ8+A3kkucUbVe1KJ10g/6L+hZx0W36uxXX?=
 =?us-ascii?Q?6U2cSFMBr39v95xWIQ71roNzByFnm7EiYnEk9G9RO4tE+HavfdvjsOHo4D9I?=
 =?us-ascii?Q?CmzDsjgRRiDewuneeIcu43E=3D?=
Content-Type: multipart/alternative;
 boundary="_000_SA0PR12MB4399F7FF81BC087AD27245E1E3929SA0PR12MB4399namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4399.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ca1468a-aad0-48d2-cda4-08d9a3b69639
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Nov 2021 19:24:44.7659 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2LTn0LufEgp/2RvlE6msjz+ZAWcA8RiAHguyPsjA2Q1Bi9DHZX6kjerHgisU/i4SJiSuZZGRbntBTyTiDq8gRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2397
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
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_SA0PR12MB4399F7FF81BC087AD27245E1E3929SA0PR12MB4399namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only]

Based on my experiments I am able conclude that I can avoid validating the =
BO prior to pinning it. I don't have the code history that led me to valida=
ting the BO in the first place. In any case I posted an updated patch to th=
e DRM-NEXT branch in addition to a standalone patch for the DKMS branch as =
well.

Thanks for pointing this out.

Regards,
Ramesh

From: Errabolu, Ramesh <Ramesh.Errabolu@amd.com>
Sent: Tuesday, November 9, 2021 1:32 AM
To: Yu, Lang <Lang.Yu@amd.com>
Cc: amd-gfx@lists.freedesktop.org
Subject: Re: [PATCH] drm/amdgpu: Pin MMIO/DOORBELL BO's in GTT domain

I will experiment to see if it is not needed. Will update patch based on th=
e results.

Regards,
Ramesh
________________________________
From: Yu, Lang <Lang.Yu@amd.com<mailto:Lang.Yu@amd.com>>
Sent: Tuesday, November 9, 2021 12:44 AM
To: Errabolu, Ramesh <Ramesh.Errabolu@amd.com<mailto:Ramesh.Errabolu@amd.co=
m>>
Cc: amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org> <am=
d-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>>
Subject: Re: [PATCH] drm/amdgpu: Pin MMIO/DOORBELL BO's in GTT domain

On Tue, Nov 09, 2021 at 02:12:00PM +0800, Errabolu, Ramesh wrote:
> [AMD Official Use Only]
>
> Responses in line
>
> -----Original Message-----
> From: Yu, Lang <Lang.Yu@amd.com<mailto:Lang.Yu@amd.com>>
> Sent: Monday, November 8, 2021 11:27 PM
> To: Errabolu, Ramesh <Ramesh.Errabolu@amd.com<mailto:Ramesh.Errabolu@amd.=
com>>
> Cc: amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>
> Subject: Re: [PATCH] drm/amdgpu: Pin MMIO/DOORBELL BO's in GTT domain
>
> On Mon, Nov 08, 2021 at 07:37:44PM -0600, Ramesh Errabolu wrote:
> > MMIO/DOORBELL BOs encode control data and should be pinned in GTT
> > domain before enabling PCIe connected peer devices in accessing it
> >
> > Signed-off-by: Ramesh Errabolu <Ramesh.Errabolu@amd.com<mailto:Ramesh.E=
rrabolu@amd.com>>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h    | 25 +++++++++
> >  .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  | 55
> > +++++++++++++++++++
> >  2 files changed, 80 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> > index 4c1d6536a7a5..d9a1cfd7876f 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> > @@ -300,6 +300,31 @@ int amdgpu_amdkfd_gpuvm_import_dmabuf(struct amdgp=
u_device *adev,
> >                                    uint64_t va, void *drm_priv,
> >                                    struct kgd_mem **mem, uint64_t *size=
,
> >                                    uint64_t *mmap_offset);
> > +
> > +/**
> > + * amdgpu_amdkfd_gpuvm_pin_bo() - Pins a BO using following criteria
> > + * @bo: Handle of buffer object being pinned
> > + * @domain: Domain into which BO should be pinned
> > + *
> > + *   - USERPTR BOs are UNPINNABLE and will return error
> > + *   - All other BO types (GTT, VRAM, MMIO and DOORBELL) will have the=
ir
> > + *     PIN count incremented. It is valid to PIN a BO multiple times
> > + *
> > + * Return: ZERO if successful in pinning, Non-Zero in case of error.
> > + * Will return -EINVAL if input BO parameter is a USERPTR type.
> > + */
> > +int amdgpu_amdkfd_gpuvm_pin_bo(struct amdgpu_bo *bo, u32 domain);
> > +
> > +/**
> > + * amdgpu_amdkfd_gpuvm_unpin_bo() - Unpins BO using following
> > +criteria
> > + * @bo: Handle of buffer object being unpinned
> > + *
> > + *   - Is a illegal request for USERPTR BOs and is ignored
> > + *   - All other BO types (GTT, VRAM, MMIO and DOORBELL) will have the=
ir
> > + *     PIN count decremented. Calls to UNPIN must balance calls to PIN
> > + */
> > +void amdgpu_amdkfd_gpuvm_unpin_bo(struct amdgpu_bo *bo);
> > +
> >  int amdgpu_amdkfd_get_tile_config(struct amdgpu_device *adev,
> >                              struct tile_config *config);
> >  void amdgpu_amdkfd_ras_poison_consumption_handler(struct
> > amdgpu_device *adev); diff --git
> > a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> > index 4fa814358552..f4ffc41873dd 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> > @@ -1299,6 +1299,36 @@ static int init_kfd_vm(struct amdgpu_vm *vm, voi=
d **process_info,
> >      return ret;
> >  }
> >
> > +int amdgpu_amdkfd_gpuvm_pin_bo(struct amdgpu_bo *bo, u32 domain) {
> > +   int ret =3D 0;
> > +
> > +   ret =3D amdgpu_bo_reserve(bo, false);
> > +   if (unlikely(ret))
> > +           return ret;
> > +
> > +   ret =3D amdgpu_bo_pin_restricted(bo, domain, 0, 0);
> > +   if (ret)
> > +           pr_err("Error in Pinning BO to domain: %d\n", domain);
> > +
> > +   amdgpu_bo_sync_wait(bo, AMDGPU_FENCE_OWNER_KFD, false);
> > +   amdgpu_bo_unreserve(bo);
> > +
> > +   return ret;
> > +}
> > +
> > +void amdgpu_amdkfd_gpuvm_unpin_bo(struct amdgpu_bo *bo) {
> > +   int ret =3D 0;
> > +
> > +   ret =3D amdgpu_bo_reserve(bo, false);
> > +   if (unlikely(ret))
> > +           return;
> > +
> > +   amdgpu_bo_unpin(bo);
> > +   amdgpu_bo_unreserve(bo);
> > +}
> > +
> >  int amdgpu_amdkfd_gpuvm_acquire_process_vm(struct amdgpu_device *adev,
> >                                         struct file *filp, u32 pasid,
> >                                         void **process_info,
> > @@ -1525,6 +1555,23 @@ int amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(
> >      if (offset)
> >              *offset =3D amdgpu_bo_mmap_offset(bo);
> >
> > +   if (flags & (KFD_IOC_ALLOC_MEM_FLAGS_DOORBELL |
> > +                   KFD_IOC_ALLOC_MEM_FLAGS_MMIO_REMAP)) {
> > +           ret =3D amdgpu_amdkfd_bo_validate(bo, AMDGPU_GEM_DOMAIN_GTT=
, false);
> > +           if (ret) {
> > +                   pr_err("Validating MMIO/DOORBELL BO during ALLOC FA=
ILED\n");
> > +                   goto err_node_allow;
> > +           }
>
> amdgpu_amdkfd_gpuvm_pin_bo() will do ttm_bo_validate(),
> amdgpu_amdkfd_bo_validate() seems redundant here.
>
> Ramesh: In my experiments I recall seeing an issue if BO was not validate=
d in GTT domain prior to pinning. If my memory serves me correctly, the cal=
l to PIN will fail

From amdgpu_bo_pin_restricted() we can see, pin operation will

If not pinned,
1, validate the BO with requested domain
2, increase pin count and update stats

If already pinned,
1, increase pin count

So seems not necessarily to validate it twice.

Regards,
Lang

> > +
> > +           ret =3D amdgpu_amdkfd_gpuvm_pin_bo(bo, AMDGPU_GEM_DOMAIN_GT=
T);
> > +           if (ret) {
> > +                   pr_err("Pinning MMIO/DOORBELL BO during ALLOC FAILE=
D\n");
> > +                   goto err_node_allow;
> > +           }
> > +           bo->allowed_domains =3D AMDGPU_GEM_DOMAIN_GTT;
> > +           bo->preferred_domains =3D AMDGPU_GEM_DOMAIN_GTT;
> > +   }
> > +
> >      return 0;
> >
> >  allocate_init_user_pages_failed:
> > @@ -1561,6 +1608,14 @@ int amdgpu_amdkfd_gpuvm_free_memory_of_gpu(
> >      bool is_imported =3D false;
> >
> >      mutex_lock(&mem->lock);
> > +
> > +   /* Unpin MMIO/DOORBELL BO's that were pinnned during allocation */
> > +   if (mem->alloc_flags &
> > +       (KFD_IOC_ALLOC_MEM_FLAGS_DOORBELL |
> > +        KFD_IOC_ALLOC_MEM_FLAGS_MMIO_REMAP)) {
> > +           amdgpu_amdkfd_gpuvm_unpin_bo(mem->bo);
> > +   }
> > +
> >      mapped_to_gpu_memory =3D mem->mapped_to_gpu_memory;
> >      is_imported =3D mem->is_imported;
> >      mutex_unlock(&mem->lock);
> > --
> > 2.31.1
> >

--_000_SA0PR12MB4399F7FF81BC087AD27245E1E3929SA0PR12MB4399namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<!--[if !mso]><style>v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
w\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style><![endif]--><style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
span.EmailStyle18
	{mso-style-type:personal-reply;
	font-family:"Courier New";
	color:windowtext;}
p.msipheadera4477989, li.msipheadera4477989, div.msipheadera4477989
	{mso-style-name:msipheadera4477989;
	mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"#0563C1" vlink=3D"#954F72" style=3D"word-wrap:=
break-word">
<div class=3D"WordSection1">
<p class=3D"msipheadera4477989" style=3D"margin:0in"><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:blue">[AMD Officia=
l Use Only]</span><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;">=
Based on my experiments I am able conclude that I can avoid validating the =
BO prior to pinning it. I don&#8217;t have the code history that led me to =
validating the BO in the first place. In any case I
 posted an updated patch to the DRM-NEXT branch in addition to a standalone=
 patch for the DKMS branch as well.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;">=
<o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;">=
Thanks for pointing this out.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;">=
<o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;">=
Regards,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;">=
Ramesh<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;">=
<o:p>&nbsp;</o:p></span></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> Errabolu, Ramesh &lt;Ramesh.Errabolu@am=
d.com&gt; <br>
<b>Sent:</b> Tuesday, November 9, 2021 1:32 AM<br>
<b>To:</b> Yu, Lang &lt;Lang.Yu@amd.com&gt;<br>
<b>Cc:</b> amd-gfx@lists.freedesktop.org<br>
<b>Subject:</b> Re: [PATCH] drm/amdgpu: Pin MMIO/DOORBELL BO's in GTT domai=
n<o:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">I will =
experiment to see if it is not needed. Will update patch based on the resul=
ts.<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black"><o:p>&n=
bsp;</o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">Regards=
, <o:p></o:p></span></p>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">Ramesh<=
o:p></o:p></span></p>
</div>
</div>
<div class=3D"MsoNormal" align=3D"center" style=3D"text-align:center">
<hr size=3D"1" width=3D"98%" align=3D"center">
</div>
<div id=3D"divRplyFwdMsg">
<p class=3D"MsoNormal"><b><span style=3D"color:black">From:</span></b><span=
 style=3D"color:black"> Yu, Lang &lt;<a href=3D"mailto:Lang.Yu@amd.com">Lan=
g.Yu@amd.com</a>&gt;<br>
<b>Sent:</b> Tuesday, November 9, 2021 12:44 AM<br>
<b>To:</b> Errabolu, Ramesh &lt;<a href=3D"mailto:Ramesh.Errabolu@amd.com">=
Ramesh.Errabolu@amd.com</a>&gt;<br>
<b>Cc:</b> <a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.f=
reedesktop.org</a> &lt;<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd=
-gfx@lists.freedesktop.org</a>&gt;<br>
<b>Subject:</b> Re: [PATCH] drm/amdgpu: Pin MMIO/DOORBELL BO's in GTT domai=
n</span>
<o:p></o:p></p>
<div>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
</div>
</div>
<div>
<div>
<p class=3D"MsoNormal">On Tue, Nov 09, 2021 at 02:12:00PM +0800, Errabolu, =
Ramesh wrote:<br>
&gt; [AMD Official Use Only]<br>
&gt; <br>
&gt; Responses in line<br>
&gt; <br>
&gt; -----Original Message-----<br>
&gt; From: Yu, Lang &lt;<a href=3D"mailto:Lang.Yu@amd.com">Lang.Yu@amd.com<=
/a>&gt; <br>
&gt; Sent: Monday, November 8, 2021 11:27 PM<br>
&gt; To: Errabolu, Ramesh &lt;<a href=3D"mailto:Ramesh.Errabolu@amd.com">Ra=
mesh.Errabolu@amd.com</a>&gt;<br>
&gt; Cc: <a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.fre=
edesktop.org</a><br>
&gt; Subject: Re: [PATCH] drm/amdgpu: Pin MMIO/DOORBELL BO's in GTT domain<=
br>
&gt; <br>
&gt; On Mon, Nov 08, 2021 at 07:37:44PM -0600, Ramesh Errabolu wrote:<br>
&gt; &gt; MMIO/DOORBELL BOs encode control data and should be pinned in GTT=
 <br>
&gt; &gt; domain before enabling PCIe connected peer devices in accessing i=
t<br>
&gt; &gt; <br>
&gt; &gt; Signed-off-by: Ramesh Errabolu &lt;<a href=3D"mailto:Ramesh.Errab=
olu@amd.com">Ramesh.Errabolu@amd.com</a>&gt;<br>
&gt; &gt; ---<br>
&gt; &gt;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h&nbsp;&nbsp;&nbsp=
; | 25 +++++++++<br>
&gt; &gt;&nbsp; .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c&nbsp; | 55 <br=
>
&gt; &gt; +++++++++++++++++++<br>
&gt; &gt;&nbsp; 2 files changed, 80 insertions(+)<br>
&gt; &gt; <br>
&gt; &gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h <br>
&gt; &gt; b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h<br>
&gt; &gt; index 4c1d6536a7a5..d9a1cfd7876f 100644<br>
&gt; &gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h<br>
&gt; &gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h<br>
&gt; &gt; @@ -300,6 +300,31 @@ int amdgpu_amdkfd_gpuvm_import_dmabuf(struct=
 amdgpu_device *adev,<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint6=
4_t va, void *drm_priv,<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struc=
t kgd_mem **mem, uint64_t *size,<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint6=
4_t *mmap_offset);<br>
&gt; &gt; +<br>
&gt; &gt; +/**<br>
&gt; &gt; + * amdgpu_amdkfd_gpuvm_pin_bo() - Pins a BO using following crit=
eria<br>
&gt; &gt; + * @bo: Handle of buffer object being pinned<br>
&gt; &gt; + * @domain: Domain into which BO should be pinned<br>
&gt; &gt; + *<br>
&gt; &gt; + *&nbsp;&nbsp; - USERPTR BOs are UNPINNABLE and will return erro=
r<br>
&gt; &gt; + *&nbsp;&nbsp; - All other BO types (GTT, VRAM, MMIO and DOORBEL=
L) will have their<br>
&gt; &gt; + *&nbsp;&nbsp;&nbsp;&nbsp; PIN count incremented. It is valid to=
 PIN a BO multiple times<br>
&gt; &gt; + *<br>
&gt; &gt; + * Return: ZERO if successful in pinning, Non-Zero in case of er=
ror.<br>
&gt; &gt; + * Will return -EINVAL if input BO parameter is a USERPTR type.<=
br>
&gt; &gt; + */<br>
&gt; &gt; +int amdgpu_amdkfd_gpuvm_pin_bo(struct amdgpu_bo *bo, u32 domain)=
;<br>
&gt; &gt; +<br>
&gt; &gt; +/**<br>
&gt; &gt; + * amdgpu_amdkfd_gpuvm_unpin_bo() - Unpins BO using following <b=
r>
&gt; &gt; +criteria<br>
&gt; &gt; + * @bo: Handle of buffer object being unpinned<br>
&gt; &gt; + *<br>
&gt; &gt; + *&nbsp;&nbsp; - Is a illegal request for USERPTR BOs and is ign=
ored<br>
&gt; &gt; + *&nbsp;&nbsp; - All other BO types (GTT, VRAM, MMIO and DOORBEL=
L) will have their<br>
&gt; &gt; + *&nbsp;&nbsp;&nbsp;&nbsp; PIN count decremented. Calls to UNPIN=
 must balance calls to PIN<br>
&gt; &gt; + */<br>
&gt; &gt; +void amdgpu_amdkfd_gpuvm_unpin_bo(struct amdgpu_bo *bo);<br>
&gt; &gt; +<br>
&gt; &gt;&nbsp; int amdgpu_amdkfd_get_tile_config(struct amdgpu_device *ade=
v,<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct tile_config *config);<br>
&gt; &gt;&nbsp; void amdgpu_amdkfd_ras_poison_consumption_handler(struct <b=
r>
&gt; &gt; amdgpu_device *adev); diff --git <br>
&gt; &gt; a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c <br>
&gt; &gt; b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c<br>
&gt; &gt; index 4fa814358552..f4ffc41873dd 100644<br>
&gt; &gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c<br>
&gt; &gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c<br>
&gt; &gt; @@ -1299,6 +1299,36 @@ static int init_kfd_vm(struct amdgpu_vm *v=
m, void **process_info,<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&gt; &gt;&nbsp; }<br>
&gt; &gt;&nbsp; <br>
&gt; &gt; +int amdgpu_amdkfd_gpuvm_pin_bo(struct amdgpu_bo *bo, u32 domain)=
 {<br>
&gt; &gt; +&nbsp;&nbsp; int ret =3D 0;<br>
&gt; &gt; +<br>
&gt; &gt; +&nbsp;&nbsp; ret =3D amdgpu_bo_reserve(bo, false);<br>
&gt; &gt; +&nbsp;&nbsp; if (unlikely(ret))<br>
&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret=
urn ret;<br>
&gt; &gt; +<br>
&gt; &gt; +&nbsp;&nbsp; ret =3D amdgpu_bo_pin_restricted(bo, domain, 0, 0);=
<br>
&gt; &gt; +&nbsp;&nbsp; if (ret)<br>
&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_=
err(&quot;Error in Pinning BO to domain: %d\n&quot;, domain);<br>
&gt; &gt; +<br>
&gt; &gt; +&nbsp;&nbsp; amdgpu_bo_sync_wait(bo, AMDGPU_FENCE_OWNER_KFD, fal=
se);<br>
&gt; &gt; +&nbsp;&nbsp; amdgpu_bo_unreserve(bo);<br>
&gt; &gt; +<br>
&gt; &gt; +&nbsp;&nbsp; return ret;<br>
&gt; &gt; +}<br>
&gt; &gt; +<br>
&gt; &gt; +void amdgpu_amdkfd_gpuvm_unpin_bo(struct amdgpu_bo *bo) {<br>
&gt; &gt; +&nbsp;&nbsp; int ret =3D 0;<br>
&gt; &gt; +<br>
&gt; &gt; +&nbsp;&nbsp; ret =3D amdgpu_bo_reserve(bo, false);<br>
&gt; &gt; +&nbsp;&nbsp; if (unlikely(ret))<br>
&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret=
urn;<br>
&gt; &gt; +<br>
&gt; &gt; +&nbsp;&nbsp; amdgpu_bo_unpin(bo);<br>
&gt; &gt; +&nbsp;&nbsp; amdgpu_bo_unreserve(bo);<br>
&gt; &gt; +}<br>
&gt; &gt; +<br>
&gt; &gt;&nbsp; int amdgpu_amdkfd_gpuvm_acquire_process_vm(struct amdgpu_de=
vice *adev,<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; struct file *filp, u32 pasid,<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; void **process_info,<br>
&gt; &gt; @@ -1525,6 +1555,23 @@ int amdgpu_amdkfd_gpuvm_alloc_memory_of_gp=
u(<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (offset)<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; *offset =3D amdgpu_bo_mmap_offset(bo);<br>
&gt; &gt;&nbsp; <br>
&gt; &gt; +&nbsp;&nbsp; if (flags &amp; (KFD_IOC_ALLOC_MEM_FLAGS_DOORBELL |=
<br>
&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; KFD_IOC_ALLOC_MEM_FLAGS_MMIO_R=
EMAP)) {<br>
&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret=
 =3D amdgpu_amdkfd_bo_validate(bo, AMDGPU_GEM_DOMAIN_GTT, false);<br>
&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if =
(ret) {<br>
&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_err(&quot;Validating MMIO/D=
OORBELL BO during ALLOC FAILED\n&quot;);<br>
&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto err_node_allow;<br>
&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<b=
r>
&gt; <br>
&gt; amdgpu_amdkfd_gpuvm_pin_bo() will do ttm_bo_validate(),<br>
&gt; amdgpu_amdkfd_bo_validate() seems redundant here.<br>
&gt; <br>
&gt; Ramesh: In my experiments I recall seeing an issue if BO was not valid=
ated in GTT domain prior to pinning. If my memory serves me correctly, the =
call to PIN will fail<br>
<br>
From amdgpu_bo_pin_restricted() we can see, pin operation will<br>
<br>
If not pinned, <br>
1, validate the BO with requested domain<br>
2, increase pin count and update stats<br>
<br>
If already pinned,<br>
1, increase pin count<br>
<br>
So seems not necessarily to validate it twice.<br>
<br>
Regards,<br>
Lang<br>
&nbsp;<br>
&gt; &gt; +<br>
&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret=
 =3D amdgpu_amdkfd_gpuvm_pin_bo(bo, AMDGPU_GEM_DOMAIN_GTT);<br>
&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if =
(ret) {<br>
&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_err(&quot;Pinning MMIO/DOOR=
BELL BO during ALLOC FAILED\n&quot;);<br>
&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto err_node_allow;<br>
&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<b=
r>
&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bo-=
&gt;allowed_domains =3D AMDGPU_GEM_DOMAIN_GTT;<br>
&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bo-=
&gt;preferred_domains =3D AMDGPU_GEM_DOMAIN_GTT;<br>
&gt; &gt; +&nbsp;&nbsp; }<br>
&gt; &gt; +<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt; &gt;&nbsp; <br>
&gt; &gt;&nbsp; allocate_init_user_pages_failed:<br>
&gt; &gt; @@ -1561,6 +1608,14 @@ int amdgpu_amdkfd_gpuvm_free_memory_of_gpu=
(<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool is_imported =3D false;<br>
&gt; &gt;&nbsp; <br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;mem-&gt;lock);<br>
&gt; &gt; +<br>
&gt; &gt; +&nbsp;&nbsp; /* Unpin MMIO/DOORBELL BO's that were pinnned durin=
g allocation */<br>
&gt; &gt; +&nbsp;&nbsp; if (mem-&gt;alloc_flags &amp;<br>
&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (KFD_IOC_ALLOC_MEM_FLAGS_DO=
ORBELL |<br>
&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; KFD_IOC_ALLOC_MEM_FLA=
GS_MMIO_REMAP)) {<br>
&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amd=
gpu_amdkfd_gpuvm_unpin_bo(mem-&gt;bo);<br>
&gt; &gt; +&nbsp;&nbsp; }<br>
&gt; &gt; +<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mapped_to_gpu_memory =3D mem-&gt;ma=
pped_to_gpu_memory;<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; is_imported =3D mem-&gt;is_imported=
;<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;mem-&gt;lock);<br=
>
&gt; &gt; --<br>
&gt; &gt; 2.31.1<br>
&gt; &gt; <o:p></o:p></p>
</div>
</div>
</div>
</body>
</html>

--_000_SA0PR12MB4399F7FF81BC087AD27245E1E3929SA0PR12MB4399namp_--
