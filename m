Return-Path: <SRS0=P/1w=P4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12EFCC433EF
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Nov 2021 07:31:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CCEE961175
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Nov 2021 07:31:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org CCEE961175
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E8196E122;
	Tue,  9 Nov 2021 07:31:46 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2044.outbound.protection.outlook.com [40.107.236.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4283C6E122
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Nov 2021 07:31:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gQAUsf/0JcWzDTmqE9hQt2FBso8NmnpOtO1fkf43XonX0eCIqyZxk3Io5pFF0VZ4oVrP+7S0PF8S4xaHv2BwyiRz1IxmcXIT+uMsldK5oADHeGWsRVJEgRBWLNojOvjC44cmP63KQYlUYlIgljxlbia6eyA9lUPrEam9cBp6HDtpyDiU/IW9wkJDFbd7wPnfiH3DO3JE0DEtke4DUiVXZcWEI4vNhVaX5cRCWSKf2xamceyuL80WW0foCMAj6jI3GQTUZ+vzkgrFmZoprWMtPQ9/WYdbD3jku0IMvxLjTi0aHne29MaBrGR9EFb9Oa/L88T4FCtdtZt/g0/uXkk+Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Usu6/IifQ2888kBXFynv8CsnVTRBg1y6eR/yPXzzmFg=;
 b=ageLqmLzFrt8d3HF1L0hEWATu6pUX5jZljRoLakvlGbF17vWV7Q86cxyL7z/htS7qaWzxFeK9/314+1+m83Vin5daES7OQECPffCPT31PehMbgdK5Kv0ACJVu/pqoAKqXl0GjP6mIyMv3VpIqtotu6Q47kXH5IUl1GBdDNHAVBsjIQZY830MasRUtauBBIaJ6jgEfGkCwxNaQ3yDGhxDaH3FaDAKfi7sZ6qvz1BPf+154LX60lTIOnHwE7JYvAaiAW/FRu9yVXisiNnKiOKFoz2hcpWolOQ9gRAmSaPjaW7orvOjHeC88W/6R8lNDu1zINf1wPv35oJlT3eGLvWF7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Usu6/IifQ2888kBXFynv8CsnVTRBg1y6eR/yPXzzmFg=;
 b=oaWslQZRFliz+XV5BnIkyuDOBrK3Xrb7aQShffnvIzKloR56u7qJyXgIWWMTBFyzA+KV8X8CLGsnlySU9jZJqwfcW5oi+XoVMXVAkVYnlFERHR2d6F6PcOTdZQIOeF6Q8cbfHbeb4CKW8lyQq19OlcJWnIV4IUZjx26VI7tAMjY=
Received: from SA0PR12MB4399.namprd12.prod.outlook.com (2603:10b6:806:98::17)
 by SN6PR12MB2848.namprd12.prod.outlook.com (2603:10b6:805:77::30)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.11; Tue, 9 Nov
 2021 07:31:43 +0000
Received: from SA0PR12MB4399.namprd12.prod.outlook.com
 ([fe80::91ba:8d66:bd75:2ac2]) by SA0PR12MB4399.namprd12.prod.outlook.com
 ([fe80::91ba:8d66:bd75:2ac2%6]) with mapi id 15.20.4669.016; Tue, 9 Nov 2021
 07:31:43 +0000
From: "Errabolu, Ramesh" <Ramesh.Errabolu@amd.com>
To: "Yu, Lang" <Lang.Yu@amd.com>
Subject: Re: [PATCH] drm/amdgpu: Pin MMIO/DOORBELL BO's in GTT  domain
Thread-Topic: [PATCH] drm/amdgpu: Pin MMIO/DOORBELL BO's in GTT  domain
Thread-Index: AQHX1QpvVeATLBE+YUa3UHVfmzoPjqv6qrMAgAAMUJCAAAlVAIAADOL0
Date: Tue, 9 Nov 2021 07:31:42 +0000
Message-ID: <SA0PR12MB43996758E1F3D0CBA6370FCFE3929@SA0PR12MB4399.namprd12.prod.outlook.com>
References: <20211109013744.30464-1-Ramesh.Errabolu@amd.com>
 <YYoGmHxlugJagJ70@lang-desktop>
 <SA0PR12MB43995DF3EBD469BE416B1DF4E3929@SA0PR12MB4399.namprd12.prod.outlook.com>
 <YYoYwLJbI/M7AKcV@lang-desktop>
In-Reply-To: <YYoYwLJbI/M7AKcV@lang-desktop>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=True;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-11-09T07:31:42.014Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD
 Official Use
 Only; MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard; 
suggested_attachment_session_id: 9f3314dd-c326-7916-764f-9a99949e6875
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0c059b7a-0727-406a-e1db-08d9a352fa3f
x-ms-traffictypediagnostic: SN6PR12MB2848:
x-microsoft-antispam-prvs: <SN6PR12MB28482811C0A2170F28BFAEB4E3929@SN6PR12MB2848.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HfDfxLHQjm+qPvorx54JBri/16dnp9Q+0nwNDqO0Wysdrm+MZSWiadqzTP7NA1yKmgvMf3DitcTQetpZZQ7UigKTHtSwpAoVPyyEb9P9Nas3K2VB/a3aBBXD/09hTfVS3Mq6+r6fjojSJ+UcJKFoXcNOfFNWbV3sMlyOQ+vxHQ18KxPLJyqdHpXnRvy5qx05UPSI+SObJlPNuoMLMJkj+anv/5CWneqa1sCIRmmYnb1AwBLOu2lPSr6OIrGk5BAc2HNYOiUMQSfOeI0fVtgUDG4mgLemSRiXChlTnYMLQFVIHOxPat0vvzT/F9LaDPesYRdOzMjSDF2m1T1gg2rUrHqmU/qiKTUyigjgJr6fcVthz5gAl0yeDP00R4yzKb+wZ17JOh1mAJ48AQlfdXbSezaHgExa6Y0yWz6MxcsigK8nptgBRSrUOupus6CJQ5t23hSFW5vIRU+P+KPK1Gg/jz+ab5/Wrz28LyKsToaIEqMZjXOpJI3XubshVLQnq1G/qXLZvBwX381+cjIBHn+kJx3z4orfGqablmG60TFzp5b9VVBru5W7XWg4TZrtfQKt+sDtKgYwPIH7dBQJ/N83eGfPdOOkLcBvLgznFe5YRT53qfa/mCjZ9rm/ZAOgQlel55hPJiajRXoE1gHhNkHmoum2wm893DeONBJJ3oK/vweAG2WFkISOJEeCj7K4IuP0S/Cq9krJBxlrYOb5EPQUbg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB4399.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(5660300002)(6506007)(53546011)(26005)(83380400001)(6636002)(19627405001)(4326008)(71200400001)(64756008)(66946007)(6862004)(38070700005)(66556008)(76116006)(66476007)(7696005)(9686003)(508600001)(66446008)(38100700002)(122000001)(8936002)(316002)(52536014)(55016002)(33656002)(2906002)(186003)(86362001)(8676002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?cirwRISXNs+3a2HCUHN0uN/JkxBHr8mA9NIYvekUG5k901K9iMFyEEyu4ZAu?=
 =?us-ascii?Q?lpVB+14iaZZtlw9mQKCYtzgULv2bq68B5PzppxfZ9SplbGVZB14Zw4MxENkf?=
 =?us-ascii?Q?04pxiXSkqLGca5XHettL0bsinGC3SqAIg5lCRYZqRTWb0aSvmvG1NCS1bspE?=
 =?us-ascii?Q?XxWj32yHYL+QTTqfDtr+xI2Mgw+4569CH98qrNGkhKewIVHDpEVSk0B7jnrj?=
 =?us-ascii?Q?MspVuYm5jIvpa6XufdHPovz3HP1OVuf2YETiUE3J8A945Rh5I2J9Ww9QrvcH?=
 =?us-ascii?Q?YIc/esoYASzpBofbi3PYUJr5OB5tfpCJ6mqoiWZQ+zuHFs3svss7MFpFjFQO?=
 =?us-ascii?Q?4VQhk5QYf4fu0fEAWde4aBmliQtNoMVisBXbN+Y12UskPwHx+wIBXex6O44Y?=
 =?us-ascii?Q?zRvgnfpEwZpX0kS146vUGLwXX7dZRMV2ofb7RKjZoY+x829I5TQpvzwufIxD?=
 =?us-ascii?Q?FqWGreHOD0LZW7sZVGVVCa79f+61jRrGiechf+S3oPKbPThqlWEV+7qF2OYL?=
 =?us-ascii?Q?pD60tUXcqCto9h0OiqJsEUqup0OGUACSz/nfKcus/zoCL/yWjZw4ECBZse36?=
 =?us-ascii?Q?HQfyVFMAqGbJDerEA5o0U4aWGItT4D122Ke6Ls+rBsfebjGFArbDZoONgtgD?=
 =?us-ascii?Q?a3MBxjjKMT5xzctCCYpKvEmeNaVadyevhIjyxFQRoGslmlEmLowZ37rlVnhX?=
 =?us-ascii?Q?w9Je/dy3BhLo+0WP1NFESWgWOu4KZw20bdEab1aIgN62TPVyMuTUSkt7Gq4P?=
 =?us-ascii?Q?2TBaqB5rp6Xznw15Cyljk6wnN/ZAkYacrudLW72Iaxh8bS/96/7gRw2sDHAP?=
 =?us-ascii?Q?DufwHUhPy7aa9xkK+QP9OTQyte8rOh91pbdOBHv+L1qMY2UHMBBdslNi6Y8U?=
 =?us-ascii?Q?Xdhll10qJAAAWdThGoVk7wjin91yShccjXjZEH9W6hYf/J+nc6yMXBmo8u6V?=
 =?us-ascii?Q?byRl1SXknICQlcrVZTbSOj4CHh8/0D7PUoV1bDGFo+a2p8EnkcSZg/MDGFEx?=
 =?us-ascii?Q?tULpj7xBZx1F3h9Rb/e/MJ7aXlwBW30Ypm+bmnr/wWR3jHzBhYetVTXGITyi?=
 =?us-ascii?Q?qRCIilG/Xyb6NnC9IhMykI03LU1GRX9KMxUgr5t1+NBrVEIbi6FXQnnouVyO?=
 =?us-ascii?Q?mY9e99sbT/M+Q+nOfFQD42k+JaLw+SU1hzaWec8JSHeG1M1aIdp8e5EBKgnZ?=
 =?us-ascii?Q?Ntq4STXApk0DFjeCmtBb06RiBNmFL5HsVQclwFEtb2Qm/GNBYqUiAByDRt/f?=
 =?us-ascii?Q?lpuPw4TPV5ZGFS/8fXFeTtdmO0MAruKQTM+icpnq/TuPygRw4euluaxnX0pp?=
 =?us-ascii?Q?7JxQf5Jc/idCAOmR88woM6WC6grq3AUigbMwignPiKYkqFIm7JyhKt/B4rML?=
 =?us-ascii?Q?QfuC0NwgFmwJ+4Su8SouDqElj+dzTDtZJLkgwLJhUhOMbqFot/iitjywrK4Q?=
 =?us-ascii?Q?gwaDj3/RuFymtCNOHwtRQhcGpvhGa6kh6TaavhnyvzUVv8yjGjhRC06fODlN?=
 =?us-ascii?Q?anLrpnF+7Scp7EowYszLK4MqIZq9CKW5hEXGGdMPii+8jptqdp9QhJmoz8Na?=
 =?us-ascii?Q?6DBdB8x686CrdXwSpxgojd9R9F2V0pn4kQ3GtsQPWgLLNFW1uz8LzOi+0c7Y?=
 =?us-ascii?Q?CQ=3D=3D?=
Content-Type: multipart/alternative;
 boundary="_000_SA0PR12MB43996758E1F3D0CBA6370FCFE3929SA0PR12MB4399namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4399.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c059b7a-0727-406a-e1db-08d9a352fa3f
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Nov 2021 07:31:42.9806 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eFFCeeTOXhcWoo6nkhDGJAeyWePRHqZzJMKPeOpAlcgiUO2e9xXCWsIxsOS+mPQfNJHKKnl0ytvfaE6lySR0yw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2848
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

--_000_SA0PR12MB43996758E1F3D0CBA6370FCFE3929SA0PR12MB4399namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only]

I will experiment to see if it is not needed. Will update patch based on th=
e results.

Regards,
Ramesh
________________________________
From: Yu, Lang <Lang.Yu@amd.com>
Sent: Tuesday, November 9, 2021 12:44 AM
To: Errabolu, Ramesh <Ramesh.Errabolu@amd.com>
Cc: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu: Pin MMIO/DOORBELL BO's in GTT domain

On Tue, Nov 09, 2021 at 02:12:00PM +0800, Errabolu, Ramesh wrote:
> [AMD Official Use Only]
>
> Responses in line
>
> -----Original Message-----
> From: Yu, Lang <Lang.Yu@amd.com>
> Sent: Monday, November 8, 2021 11:27 PM
> To: Errabolu, Ramesh <Ramesh.Errabolu@amd.com>
> Cc: amd-gfx@lists.freedesktop.org
> Subject: Re: [PATCH] drm/amdgpu: Pin MMIO/DOORBELL BO's in GTT domain
>
> On Mon, Nov 08, 2021 at 07:37:44PM -0600, Ramesh Errabolu wrote:
> > MMIO/DOORBELL BOs encode control data and should be pinned in GTT
> > domain before enabling PCIe connected peer devices in accessing it
> >
> > Signed-off-by: Ramesh Errabolu <Ramesh.Errabolu@amd.com>
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

--_000_SA0PR12MB43996758E1F3D0CBA6370FCFE3929SA0PR12MB4399namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;" ali=
gn=3D"Left">
[AMD Official Use Only]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
I will experiment to see if it is not needed. Will update patch based on th=
e results.</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Regards,
<div>Ramesh</div>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Yu, Lang &lt;Lang.Yu@=
amd.com&gt;<br>
<b>Sent:</b> Tuesday, November 9, 2021 12:44 AM<br>
<b>To:</b> Errabolu, Ramesh &lt;Ramesh.Errabolu@amd.com&gt;<br>
<b>Cc:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Subject:</b> Re: [PATCH] drm/amdgpu: Pin MMIO/DOORBELL BO's in GTT domai=
n</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">On Tue, Nov 09, 2021 at 02:12:00PM +0800, Errabolu=
, Ramesh wrote:<br>
&gt; [AMD Official Use Only]<br>
&gt; <br>
&gt; Responses in line<br>
&gt; <br>
&gt; -----Original Message-----<br>
&gt; From: Yu, Lang &lt;Lang.Yu@amd.com&gt; <br>
&gt; Sent: Monday, November 8, 2021 11:27 PM<br>
&gt; To: Errabolu, Ramesh &lt;Ramesh.Errabolu@amd.com&gt;<br>
&gt; Cc: amd-gfx@lists.freedesktop.org<br>
&gt; Subject: Re: [PATCH] drm/amdgpu: Pin MMIO/DOORBELL BO's in GTT domain<=
br>
&gt; <br>
&gt; On Mon, Nov 08, 2021 at 07:37:44PM -0600, Ramesh Errabolu wrote:<br>
&gt; &gt; MMIO/DOORBELL BOs encode control data and should be pinned in GTT=
 <br>
&gt; &gt; domain before enabling PCIe connected peer devices in accessing i=
t<br>
&gt; &gt; <br>
&gt; &gt; Signed-off-by: Ramesh Errabolu &lt;Ramesh.Errabolu@amd.com&gt;<br=
>
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
&gt; &gt; <br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_SA0PR12MB43996758E1F3D0CBA6370FCFE3929SA0PR12MB4399namp_--
