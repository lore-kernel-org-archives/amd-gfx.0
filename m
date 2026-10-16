Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A53DCCA463
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Oct 2026 03:15:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F09D610E223;
	Fri, 16 Oct 2026 03:15:43 +0000 (UTC)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012025.outbound.protection.outlook.com [52.101.43.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 27B7710E223
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Oct 2026 03:15:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MxFUnxcp4YoBtyD6SAIml+VHtU0GebBFtN2/yjL3a6DFD7lvy+QhG0/xwAkgE1ldEFK8UElRtigFJ1PldIsUWDwBaVaoQsFd5/nY7MScBG2EJAKDkSaotjtE89zGmWXqo+OxcBZEmTtjzolBcdcbcnbJ2H9So+KCvZWiQ/MgwAYfVym9e3nNJZV5B3BnZKB2aakEO2jL1adFkVM+KHjjDEPf7KMux+jbosnUcYE+AzxoXQ1wsbGUzvXON8o4e1wLjvPW6sXNbcB9mjKhS+1Y5iQcQR8yRtvvAeTu04pJzM16duabNGaJ43aAy57SIn4i7HVC7dzwdSXaxcEpByxABA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z8S66oLG5+sUP7LSUAZEOEXlXu3CZP6KEMN/2AYjBVg=;
 b=E1HmR4hflfjGIo/BC14PS0IRxeOclsRnonz7fJau+yCu7rnCzMuKNPcNpJBaCEKW8S44m0hrDGYUH1Dm112ksMjgsxC531GBlmqsjIh4lGXoIQX2jUB+xZpfimcUVc7dNz6iOZeT4ToxIoMyjcXth5UrHLSqHbiLFvQlf/bmvxO6LssY6QOEAhVmd1AxfaP0uQ/RUiLzcKaiULf3Dh8L9062NLfdR7+06rwSX+ryFIuqMdkJrkRcmoPBfOg0selVKQJ+IGfah4iD3KdDRk+AohfF7AzQS9xtsUILCD4F6MrdZ4GNtYikMT341Z4/Z7N/XffNmhvN1ZCaD5TIQdjLSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z8S66oLG5+sUP7LSUAZEOEXlXu3CZP6KEMN/2AYjBVg=;
 b=PQzZvZId3Ndk1P8T9LZfMfCaSAloCjs5WhxfLUricfobnJPnGuSuv1qE1ouXqRIILFOLJX1h8tOhxdKJEl2yUTEnh8HOxDr0yH/3H6iMmgFaUEe5enBWniO4SiQy3d9ulDBdw3iHK0qdyqt8lz0E3G5RMhXSVOoNOciM7L2+/zw=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by DS2PR12MB9823.namprd12.prod.outlook.com (2603:10b6:8:2ad::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.14; Fri, 16 Oct
 2026 03:15:35 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::699b:1fb2:73:6a33]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::699b:1fb2:73:6a33%6]) with mapi id 15.21.0522.013; Fri, 16 Oct 2026
 03:15:35 +0000
From: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
To: "Khatri, Sunil" <Sunil.Khatri@amd.com>, "Khatri, Sunil"
 <Sunil.Khatri@amd.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH v1] drm/amdgpu/userq: commit seq64 BO mapping at queue
 creation
Thread-Topic: [PATCH v1] drm/amdgpu/userq: commit seq64 BO mapping at queue
 creation
Thread-Index: AQHdXRpXF3rt2xp4hkOF6T58YGgpUbb/fdug
Date: Fri, 16 Oct 2026 03:15:34 +0000
Message-ID: <BL1PR12MB51441FFECBA6F0211FDF6D51E39B2@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20261015174444.948651-1-sunil.khatri@amd.com>
 <99bfd8d4-8839-44f4-996e-8f903af60abf@amd.com>
In-Reply-To: <99bfd8d4-8839-44f4-996e-8f903af60abf@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-10-16T03:11:27.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|DS2PR12MB9823:EE_
x-ms-office365-filtering-correlation-id: 7e8b7a3a-2651-4afd-6179-08df2b33be89
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|23010399003|6133799003|22082099003|18002099003|10067099003|4143699003|11063799006|261009223027099003|38070700021|56012099006;
x-microsoft-antispam-message-info: OP8LyT+k6s1qA1A1XktGC376vd3rSqsx8Yw6S8z5byx3kLibAvLF33lH/FxyJlE3nEGndx2eYe4jX7jmueSyg+CynU/Bo2yLsUvtrBvODmDmLeCKu9GhXqaYBg++Ix9YCDmmmyH6fOAjzV420svOnB8TAK30Gn3nDHxl20KM7MyI2ahiUJx3aZKErYrwVpC5LZ2oSZ5Q7EbMrxe5pRAHPYwY4ER2fO+I79wW2nGI2cOsC3Ezl0T+Wsky/Ay5DzVZYPaUlIkYiCFuitDDodSz/Q7huDjxdZLCPyN8jv56QnkTKSxaZDV7cAPKRC83a7J4uuYtrjnHsjV9WqpXsvK/Eia7ZIAYPt4eP1kcAiLioBNjf1P6+1fIf3v+SFatdIHcYUcu1jGOBfc5wWw1+hSwMDh/z2I5diP5vJx17hmjIQPLjtwJDJduJVv02HHxy6raswFxEmChdE/NAAAKAzg82WrXkIK988fLRF93BHNP4YqsjvVKGjQM+2EEJYFDEdSvL3zwzMePFaeaFJ6ys5Aug52nKzlhCPpDkTGPAarXPmar3+l9Yry3SpaVugwIHhlbHCeXE3vEMHUinknRr3sOubefDFXOpjH8H5tLr/1AUDP38+58vNN8+DpQaJ9sukxFxsnH61ky5iNQw9yB1QXayFndjG0/ftTuYjgrD3MoNUw=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(6133799003)(22082099003)(18002099003)(10067099003)(4143699003)(11063799006)(261009223027099003)(38070700021)(56012099006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?zvq6UgicqsujAr7PEEhoDckVoYFT4l5CqM7hU3bZjScrgurc8X6NIdND22pZ?=
 =?us-ascii?Q?VPGKJ76Dc8hyIqaNgCGTRmR3PRsb8ws3Y2HolgltcPFL1B585gw3CxLCXX+Y?=
 =?us-ascii?Q?r5tOn2BcuiNasVKZrAUj65Hj8v1NTw0ltXm/QHnny7TqWE3RwURiR8nkA1Xw?=
 =?us-ascii?Q?eSBbW1PU1/N9QIK7mM5yLpZ4BRynJQI9H4hOMKD14KHy3ihyWVyUSCngxy1+?=
 =?us-ascii?Q?vhQV3d7Oa1R8G91HK9psVX8svptF1MYfkWzs9E1DZ5NcfuHj4+3vnnuAF4kK?=
 =?us-ascii?Q?dQzbUrEOb5OAPIXBh54HiabEC64luUbnWnfVWi+ugMrMoektJJb6tXfXlCzV?=
 =?us-ascii?Q?yCPGRqEQrkSmS3r/BEs/Ur8uWB2UPwqCtoZA0aEvQ8JoWhtN3g4hL2vbMnZt?=
 =?us-ascii?Q?QKKOwZCT6jXrEFTY08N+DYl6ymkRdODWMIdpE/8QGuDntPLI2/Ijk3U80/ng?=
 =?us-ascii?Q?TRIlsg2oMlR1lOXql1H+gUyCDWp/+i1EyBah0GFQCrI2YLwSrWk45WiWiTrY?=
 =?us-ascii?Q?AogAIDDcW5XG+kjY7WiTsijqlRniR2Z6+WyoqBij5G+2t7a0MVZxxXuxEEzn?=
 =?us-ascii?Q?gC3WdVbkyQ7IesbId8G4K1hmlY6R5DhxH58RRx+qiavO8jX349W1uGwM96v0?=
 =?us-ascii?Q?CMhQnAzYttbzFhRygDqSPoO1ZnCDhc3B6nY5VncDvNG6UbOSlhIvRxRPgN7y?=
 =?us-ascii?Q?SMK5kCD2ixxLAsUF0KC6VAnfIuZVNqmYak2GYcog42aAZI1f896LRdHdfAeB?=
 =?us-ascii?Q?eX1CgFuGjVe7Ig0IwKqOvDLGHOMwrevxfo3ZAsitXvKBuVeW6KaDjLe/+9YT?=
 =?us-ascii?Q?rs/7j5gayR2Xv4lYD54KKd8x/PqsdsI2Zw/O2XTp7RZVGIzikpsSjwJ/kkjq?=
 =?us-ascii?Q?RZttP25KGCDOV+6HOiCsMQHpw/lnG/qkyfTULQ1JwCXQHbZHKGKjdInni/p7?=
 =?us-ascii?Q?7bs7gxgkGsmxKNflMP3f1D+3EarjGyCQRolHjCEgch3Hc9X9qXl13pjK26EK?=
 =?us-ascii?Q?kZn+VvXb3Sr6X1wi6QYSlBk4Twt54JE1I+MxZxd9SCqHgZkT2olSPe1dCu48?=
 =?us-ascii?Q?zVAqjxLL4erYi6M+TU7fh+X+x1Vw3Q8MnlpIEtnen+WPTfVSG4/2L7UsJlDv?=
 =?us-ascii?Q?Ua+10LIglxyj/lHfqGIO9wfVUZeb81sBvvzJ4WJAuVnRJequdN7wdyWrDICD?=
 =?us-ascii?Q?zSC6KeFquQpaA6B0YityQgPJwEDHiXORwsIsC0D9Xyo4wiXS4kXopGh0H+tp?=
 =?us-ascii?Q?L8e2tWTle49HC9M+O0sAHeCir4f3x7J7tlEYCkq3WdnEgH1suVUrQiuUL4Il?=
 =?us-ascii?Q?etUBX8qB0cO2U8gpQJ3cePpKU/tjOBP6rClluJ69occlFD/NEvMzqJlQ/dcx?=
 =?us-ascii?Q?zKKjmkDjPlvXuhQyiDI6vckNc50c2znxk79bV+JLyFzhLF2neZLzAlejdfUy?=
 =?us-ascii?Q?RAmpnCiGarwVyxnIjw0rcFXfetB8zAoRDgPvbrhKOFwFOhZemzMVlRxc/0X4?=
 =?us-ascii?Q?gNgKW8GxAbp8BeCWaWDemQwHS3YF/Miekti2A7ovoOx8zyrYhdkcDb9x5XAP?=
 =?us-ascii?Q?pnTXgZVuCQ39jDktVp9StPUKBn0pGeR2YrFshZQkfO5YV2GxIrqDfPIPWUWZ?=
 =?us-ascii?Q?80QtJpV18PMQK0pPkVjuAghRgiI40riuwuSPU0PTfAkfaWcBJSQv2ZINQ6rO?=
 =?us-ascii?Q?rMzFIEgl5YvHuO9irsCZTa2AqJxd+9obXc69qYPL9aA83Nel?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e8b7a3a-2651-4afd-6179-08df2b33be89
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2026 03:15:34.9628 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BWUP4me1WdFuAIncA8+DkgjtcLEar4PucQ89LupYu9A5TKhHKYdfx0DZOFA6/Nj9iV6p5xd9Jzww5V5iKvBTuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9823
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

AMD General

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
> Khatri, Sunil
> Sent: Friday, October 16, 2026 10:59 AM
> To: Khatri, Sunil <Sunil.Khatri@amd.com>; Deucher, Alexander
> <Alexander.Deucher@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>
> Cc: amd-gfx@lists.freedesktop.org
> Subject: Re: [PATCH v1] drm/amdgpu/userq: commit seq64 BO mapping at
> queue creation
>
> Ignore please. Sent new patch.
>
> On 15-10-2026 11:14 pm, Sunil Khatri wrote:
> > The seq64 sync BO's PTE update only ran from the legacy CS path, so
> > userqueue-only clients never got it mapped and their fence_drv could
> > never signal completion. Add support for userqueues too.
> >
> > Fixes: ae05e3f3d02b812c ("drm/amdgpu: move amdgpu_vm_bo_update()
> call
> > into correct location")
> > Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 21
> +++++++++++++++++++++
> >   1 file changed, 21 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> > index 4dca1ab48410a..44cf25946a21c 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> > @@ -720,6 +720,27 @@ amdgpu_userq_create(struct drm_file *filp, union
> drm_amdgpu_userq *args)
> >     if (r)
> >             goto free_fence_drv;
> >
> > +   /* Update the seq64 BO mapping in VM for User Queues */
> > +   if (fpriv->seq64_va) {
> > +           struct amdgpu_bo *seq64_bo =3D fpriv->seq64_va->base.bo;
> > +
> > +           r =3D amdgpu_bo_reserve(seq64_bo, false);
> > +           if (r) {
> > +                   amdgpu_bo_unreserve(fpriv->vm.root.bo);
> > +                   goto free_fence_drv;
> > +           }
> > +
> > +           r =3D amdgpu_vm_bo_update(adev, fpriv->seq64_va, false);
> > +           if (r) {
> > +                   amdgpu_bo_unreserve(seq64_bo);
> > +                   amdgpu_bo_unreserve(fpriv->vm.root.bo);
> > +                   goto free_fence_drv;
> > +           }
> > +
> > +           dma_fence_wait(fpriv->seq64_va->last_pt_update, false);
> > +           amdgpu_bo_unreserve(seq64_bo);
> > +   }
> > +
Hi Sunil,

I noticed two issues in the earlier version that are worth checking in the =
replacement patch.

The update runs before VM validation. If the VM page tables were evicted be=
fore the first USERQ_CREATE, amdgpu_vm_bo_update() can return -EBUSY becaus=
e vm->evicting is still set.
CREATE then exits before reaching amdgpu_userq_ensure_ev_fence(), which wou=
ld otherwise trigger VM validation and restore.

Also, the root PD is already reserved here. Reserving the seq64 BO with ano=
ther amdgpu_bo_reserve() uses no shared ww ticket, so it can deadlock again=
st a drm_exec retry that holds seq64 and is waiting for the PD.

Could we update seq64 in amdgpu_userq_vm_validate_and_restore_queue(), afte=
r VM validation, with the BO reserved through the existing drm_exec, and wa=
it for its PTE update before restoring the queues?
please try the patch: "map the seq64 memory when restoring user queues"
https://lists.freedesktop.org/archives/amd-gfx/2026-October/155022.html

Thanks,
Jesse
> >     if (amdgpu_userq_input_va_validate(adev, queue, args->in.queue_va,
> >                                        args->in.queue_size,
> >                                        &queue->userq_vas.va.queue_rb)
> ||
