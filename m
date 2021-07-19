Return-Path: <SRS0=SWRn=ML=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA6C0C07E95
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Jul 2021 15:50:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A1A8361166
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Jul 2021 15:50:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1A8361166
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E7E289D1D;
	Mon, 19 Jul 2021 15:50:32 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2046.outbound.protection.outlook.com [40.107.212.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0376A89D1D
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Jul 2021 15:50:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZolsytXUfMEi+5cJrqgPvJt2//3JTxFGq/3/u664o7o/O0NUoG6w5BLBv6k3BDRQPjDFsrHDwi5wmiuUUZwtkwoeT1fiQwMdReNqsu7PcLhGSCK/mhaRxVHL/jBQALI2Eqgl0g+m21WAHz1rs6A2iP3HcClAjnpfgmO2e3OY73aLLrzzUL981S/bQTWCu6inCIS5X+q9NFugJBm6C8SZ66bBwhBp3KJsfvs6VAieXsPJ17hSXw9+uBiUi2eRE7O1HeUmQ8b8cN39qe7Js+1Wq+13tpXuAvV6BBFd+MYkrhRk0Fd6sKHsG76x8QwmqgI4wXAGP4cE9ASsXP4nAyxy3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ps4vvmQ0rWYUWJcpgvRm0SE5W77V4NRFCER7mfbKTas=;
 b=RtFPo9rFicytYls7ArEA+5NwTX/9Wsp+Ihj3js054Ct1/QOclApmsQSjILHgIA1xwfFhvMz7qDUKe1qQHEX1oGf1AjCUEJkSxRIJ01jX1fdgtqAlOOl4aEZINI96DjylI7nbY+I2vp8nNXJFDojGR8jirKMI7VCywm0I/8teF8GV5oiAGLa0A31eEh1ENB0K4KS1vfAU2QNxHQQKsFBctCIgDNB1o8WRRS1i/lBkICBcMZiJIVwngqZuNN7fPJ/R55WqasjGV5KGO+LzUzg8UpK6lTw7G4kuuAdIzuPD6CiwL+vFbpb/LbWLhJd8kUNeoO5so2ADm2HnfznWyHWf3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ps4vvmQ0rWYUWJcpgvRm0SE5W77V4NRFCER7mfbKTas=;
 b=a6UiocnqEnNEzDJcn+MQKEcHynAqJ8gjY2fxN79ThBcXkM0sS/UYFBDP2FjHxQ6Pj1fB52b5PLoshFK/7ttXulO7M5RxA/IFbrnRs9pflQSxdRP/8BTYnnyqQzDTHQjsBZ+po+S8jy1Lb5phnG1lWozolWSxiYtP9neR8IOJBfw=
Received: from DM5PR12MB4680.namprd12.prod.outlook.com (2603:10b6:4:a6::33) by
 DM6PR12MB4530.namprd12.prod.outlook.com (2603:10b6:5:2aa::19) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4331.23; Mon, 19 Jul 2021 15:50:29 +0000
Received: from DM5PR12MB4680.namprd12.prod.outlook.com
 ([fe80::1d06:dcde:55f9:3eb7]) by DM5PR12MB4680.namprd12.prod.outlook.com
 ([fe80::1d06:dcde:55f9:3eb7%7]) with mapi id 15.20.4331.032; Mon, 19 Jul 2021
 15:50:29 +0000
From: "Kim, Jonathan" <Jonathan.Kim@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/3] drm/amdkfd: report xgmi bandwidth between direct
 peers to the kfd
Thread-Topic: [PATCH 2/3] drm/amdkfd: report xgmi bandwidth between direct
 peers to the kfd
Thread-Index: AQHXemGzV9RvInrj80ePyyv8CyogaqtJ6KiAgACNsYA=
Date: Mon, 19 Jul 2021 15:50:29 +0000
Message-ID: <DM5PR12MB46808DDD944D1DF12636E09E85E19@DM5PR12MB4680.namprd12.prod.outlook.com>
References: <20210716164312.896939-1-jonathan.kim@amd.com>
 <20210716164312.896939-2-jonathan.kim@amd.com>
 <19e8ee08-c4b7-ffd7-0805-84c93402d76a@amd.com>
In-Reply-To: <19e8ee08-c4b7-ffd7-0805-84c93402d76a@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=4b309fe6-edd2-4958-b175-f3eb7616abec;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD
 Official Use Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-07-19T15:48:45Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d8795a84-749c-415b-2d42-08d94acceefa
x-ms-traffictypediagnostic: DM6PR12MB4530:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB4530E9B39219ADBA7143E4C685E19@DM6PR12MB4530.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZuCBfcFn86vZ5k6i9J9OBoueyUVlmfg8P/OhDWXtPYtOlX/SB8vyeRxknZHLkERxAPBqY9Bs2523xkpzfpo1/6lRzB2Vq79WOAbpUavpnyKG7FNevtPJhmteOkeow0xbLgAGYSj77WfQarpx5YrcCo0/CRwCuE9QINMawZk+a9z12nfsuLw2Dl517rHo6OjwwEp/oUqLTmwVtaui2LERRQkvpqhEIVksqU9X/7nDorLnsLUo4PPVXaI7W+8Sg3tzY1kqy5o/7i3owSB8QZz+vOuzHXgTwvnsn5b4K6rmBcY7F0ZDoqeULExJssoaUlNlJd9j0D7l4LVC58oYyepo2wXJPLabPN5h7eYssFWwmRdy4vDe7OOSkH4tRTFm6s9WQOVfhfdhSOIDhrwdf6A7EYzhBeRErQiqsYXRFcrt/QiKQreBjMrPa04d62wDgkgDLLao/1kmgM7BWjU31J7cD4RryKx9SmFTfF/jAPDFr9wo3PV52a57hAcQ0de90zwkOuRTjfHwd/ZxJ6LI/SZFYh68zfuWJP/08rHbusL/DrNJ4wd1HBBHoGHLrFtS82f97eitjw0XEoQ0/5F+uCrKQxWelPnrZ6zbWs849POwJ1XH0KnsTliZS7f1rMb35lOyDBfxcOlbawBJckyDOyyw2OnLvTtbaMnqoU5OKHqNQJ7RyxgmeX7s5zTEyJLwPHCxy9Zx50oxUhWZXz9rsxAiEQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB4680.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(39860400002)(136003)(376002)(346002)(396003)(9686003)(33656002)(38100700002)(316002)(122000001)(55016002)(4326008)(8676002)(86362001)(66476007)(71200400001)(66446008)(66556008)(6506007)(186003)(110136005)(2906002)(8936002)(83380400001)(66946007)(52536014)(53546011)(478600001)(64756008)(5660300002)(7696005)(76116006)(38070700004);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YTZ0WlVieEpLdzQxTzAyWDI4OFBPc3dVUEVtU0NWcTRBNzYySGcybks0OHpq?=
 =?utf-8?B?ekVYVDlmQVFCV0JwWStHM015RzhtYWM0cFU1SGg3cThKQmRVZEVHVW91ZVlT?=
 =?utf-8?B?dnB2RWgwN3B4bVZVV05JUjQrK3R5N1V1SWRnaituYnJ4d013WGRDcDcwSldE?=
 =?utf-8?B?UmV3OWVaZ0Nwa1BxWDVCc2wvMXArZStxSE40RE5NNWdKZno0RVNTenc5Rzk2?=
 =?utf-8?B?UFdzVUFBLzRZVFVVZmVCcXNrWnBMdktSMVRkTHoxWVBPcTdmT3k5MVNRcTRW?=
 =?utf-8?B?emxyNEdJVEFzZnZEWTdCbkVSSkMvVzV0RDlqSTY0STFhZW9kRllxYitEckFZ?=
 =?utf-8?B?VWI3dE5YY0EvZzFIRkFvb1liTFc2eVFqOXJXamRwZHM3Q29ldEFFOVJCZXV0?=
 =?utf-8?B?Tnh2K3B3ODNxcUl6bUtrbzBOcWY1cG1QbFdGQUVWV05IUDhDU0M0aUVFdTlz?=
 =?utf-8?B?bDkzRFJzTS9pSDhseXZLVWhlRTMvWURDS21BQXdDbDNOdlZVTXhYOHhKdENl?=
 =?utf-8?B?eUxWUkQrdVdWNlEyT1p1NzVOMEo5aEx5SjN3QzJDbktRY2RvWHdFWUZrb1ll?=
 =?utf-8?B?V3g3MVZZbEg4Skh3ZWErNXlITmhDUWlmaGVEbDdBa29pdTRaSzVyUnJhcHpO?=
 =?utf-8?B?Qk9BRE5IVFR1Qks4WmhXNGxUbnhLY0NoZmVHcDYrREhMd0o5cGRacWJlSVRH?=
 =?utf-8?B?VGlXMW00MTNrQXJ4NDhKYVBwaW9vREVhNFlkTmFkR1QzSnh3dDFPR0FJaUxJ?=
 =?utf-8?B?R3VhMElqTEJUNlMrZzArblJlbGt1dXZNQkt6RjU1OXJiWm5jL3RIZWZ2c0lJ?=
 =?utf-8?B?Q3JhelowWld0a3VGSDRPNVZtL2d0dzd5RXNzUlZVL0lMdmRqc1FudFM1Y2lE?=
 =?utf-8?B?cmFYNWxNT1F6UzgwWDlQL2t3VFEvSzBBcGtTT3NuRjJhdkJCelhFZUM0MmNN?=
 =?utf-8?B?SHdhOHl0cm4rUjJ3bXFVbkRYczlFN0U0U3VDNTg0R0NjYXVUUm5LTmUxa3Jt?=
 =?utf-8?B?Q1ZQcU5MbzUwOWxBc0Z3bjdTdWh5ZVRuOWI0Z1Rac1V5aXhZVnBzSnRhaThh?=
 =?utf-8?B?NklITmxsZTRha3IrT0o2SEZETVNyYnorWlVhRDE1eFN5WVR0V08xaWxNSXF1?=
 =?utf-8?B?UFh1OUVidGhDZjdBL0p2ZUZiYnd3ZGRmWjJlQzVXSCt1dDJRZTlEREFkNFVu?=
 =?utf-8?B?MU03UEZQUlBvdkNBdVdkQk9uelFvYis1bTdwL0VKZ3pjVWFqMjN0dHBRMVdS?=
 =?utf-8?B?ZGZuT09TSnM2cUQ2VmR1RE5DODdpU1NvUnNRLzNwNXZON1h0T3E3aGVmd2Rh?=
 =?utf-8?B?eDdRaUdaZHVYdzYxYjNRSk5FQzlpNTBkSnNyVG12TWhKMmpaRUZjR0UrSkYr?=
 =?utf-8?B?MUQveGEvajNPQXNhZjF6MTl5aTNrc3dOalAzRmxrMlNkaTl6T0lpTTkvNXdC?=
 =?utf-8?B?dE5nUkUwb1NwK0VaanFlOHB6SCt3ZU1DaHVXdVdrMVREbkZaYkYwYXJaNitz?=
 =?utf-8?B?UldQQmZMVzlWSFFOZ0FrRHhPMkZBSnAyd25aVlBIdGdTQU9kZHZwSVVUSmpi?=
 =?utf-8?B?UnYrcHErV1dTTjA5eVRSMkQ3cEYrYStlVjJOWFBpSFA2M0V0T3pKaTRTd0FZ?=
 =?utf-8?B?d1djaXdMTFQ3RVk4SjVCdTBQbEU3ZENhQzlCU2NvQm42VUFjeWxqWmZDUmZp?=
 =?utf-8?B?ZlJ6Y3M2UFZBVC9lN0M1UkVsYW55VDRISEpheU5vZWZEaitYUGUrZHlhajNO?=
 =?utf-8?B?N2d3RnRtWGpPc3h1UjBYUzZCbUREdWxOSncwQWZyWGZmRmI5V2J3WG5vdDV3?=
 =?utf-8?B?Y1dheHNUY1hzK0pZQW1aNlpGakxlWlJCamJUU1M5WWZyMllhZFhicURNbHhR?=
 =?utf-8?Q?v9Ey2Ky/dGGpK?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB4680.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8795a84-749c-415b-2d42-08d94acceefa
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jul 2021 15:50:29.1773 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HCRhh5RR3GFiQVT/iEEy3q+L5ectUuQCbWjCq5Jx7s9ek5kVVHcQhRuA11hqM+Hl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4530
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
Cc: "Kuehling, Felix" <Felix.Kuehling@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]

> -----Original Message-----
> From: Lazar, Lijo <Lijo.Lazar@amd.com>
> Sent: Monday, July 19, 2021 3:22 AM
> To: Kim, Jonathan <Jonathan.Kim@amd.com>; amd-
> gfx@lists.freedesktop.org
> Cc: Kuehling, Felix <Felix.Kuehling@amd.com>
> Subject: Re: [PATCH 2/3] drm/amdkfd: report xgmi bandwidth between
> direct peers to the kfd
>
>
>
> On 7/16/2021 10:13 PM, Jonathan Kim wrote:
> > Report the min/max bandwidth in megabytes to the kfd for direct xgmi
> > connections only.
> >
> > v2: change reporting from num links to bandwidth
> >
> > Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 23
> ++++++++++++++++++++++
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h |  1 +
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c   | 12 +++++++++++
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h   |  2 ++
> >   drivers/gpu/drm/amd/amdkfd/kfd_crat.c      | 12 +++++++++++
> >   5 files changed, 50 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> > index bfab2f9fdd17..3978578a1c49 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> > @@ -553,6 +553,29 @@ uint8_t
> amdgpu_amdkfd_get_xgmi_hops_count(struct kgd_dev *dst, struct kgd_dev
> *s
> >     return  (uint8_t)ret;
> >   }
> >
> > +int amdgpu_amdkfd_get_xgmi_bandwidth_mbytes(struct kgd_dev *dst,
> > +struct kgd_dev *src, bool is_min) {
> > +   struct amdgpu_device *adev = (struct amdgpu_device *)dst,
> *peer_adev;
> > +   int num_links;
> > +
> > +   if (adev->asic_type != CHIP_ALDEBARAN)
> > +           return 0;
> > +
> > +   if (src)
> > +           peer_adev = (struct amdgpu_device *)src;
> > +
> > +   num_links = is_min ? 1 : amdgpu_xgmi_get_num_links(adev,
> peer_adev);
> > +   if (num_links < 0) {
> > +           DRM_ERROR("amdgpu: failed to get xgmi num links between
> node %d and %d. ret = %d\n",
> > +                   adev->gmc.xgmi.physical_node_id,
> > +                   peer_adev->gmc.xgmi.physical_node_id, num_links);
> > +           num_links = 0;
> > +   }
> > +
> > +   /* Aldebaran xGMI DPM is defeatured so assume x16 x 25Gbps for
> bandwidth. */
> > +   return (num_links * 16 * 25000)/BITS_PER_BYTE;
>
> Instead of having ASIC family checks and bandwidth info in interface
> functions, better to have this info come from base layer (amdgpu_xgmi or
> xgmi ip). That will help to handle other ASICs.

Ok.  We can revisit this as a follow up.  Maybe the full solution is a link width/speed support mask analogous to pcie.

Thanks,

Jon

>
> Thanks,
> Lijo
>
> >   uint64_t amdgpu_amdkfd_get_mmio_remap_phys_addr(struct kgd_dev
> *kgd)
> >   {
> >     struct amdgpu_device *adev = (struct amdgpu_device *)kgd; diff
> > --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> > index 81264517d532..e12fccb2d2c4 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> > @@ -226,6 +226,7 @@ uint32_t amdgpu_amdkfd_get_num_gws(struct
> kgd_dev *kgd);
> >   uint32_t amdgpu_amdkfd_get_asic_rev_id(struct kgd_dev *kgd);
> >   int amdgpu_amdkfd_get_noretry(struct kgd_dev *kgd);
> >   uint8_t amdgpu_amdkfd_get_xgmi_hops_count(struct kgd_dev *dst,
> > struct kgd_dev *src);
> > +int amdgpu_amdkfd_get_xgmi_bandwidth_mbytes(struct kgd_dev *dst,
> > +struct kgd_dev *src, bool is_min);
> >
> >   /* Read user wptr from a specified user address space with page fault
> >    * disabled. The memory must be pinned and mapped to the hardware
> > when diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
> > index 8567d5d77346..258cf86b32f6 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
> > @@ -486,6 +486,18 @@ int amdgpu_xgmi_get_hops_count(struct
> amdgpu_device *adev,
> >     return  -EINVAL;
> >   }
> >
> > +int amdgpu_xgmi_get_num_links(struct amdgpu_device *adev,
> > +           struct amdgpu_device *peer_adev)
> > +{
> > +   struct psp_xgmi_topology_info *top = &adev-
> >psp.xgmi_context.top_info;
> > +   int i;
> > +
> > +   for (i = 0 ; i < top->num_nodes; ++i)
> > +           if (top->nodes[i].node_id == peer_adev->gmc.xgmi.node_id)
> > +                   return top->nodes[i].num_links;
> > +   return  -EINVAL;
> > +}
> > +
> >   int amdgpu_xgmi_add_device(struct amdgpu_device *adev)
> >   {
> >     struct psp_xgmi_topology_info *top_info; diff --git
> > a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h
> > index 12969c0830d5..d2189bf7d428 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h
> > @@ -59,6 +59,8 @@ int amdgpu_xgmi_remove_device(struct
> amdgpu_device *adev);
> >   int amdgpu_xgmi_set_pstate(struct amdgpu_device *adev, int pstate);
> >   int amdgpu_xgmi_get_hops_count(struct amdgpu_device *adev,
> >             struct amdgpu_device *peer_adev);
> > +int amdgpu_xgmi_get_num_links(struct amdgpu_device *adev,
> > +           struct amdgpu_device *peer_adev);
> >   uint64_t amdgpu_xgmi_get_relative_phy_addr(struct amdgpu_device
> *adev,
> >                                        uint64_t addr);
> >   static inline bool amdgpu_xgmi_same_hive(struct amdgpu_device *adev,
> > diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> > b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> > index c6b02aee4993..40ce6239c813 100644
> > --- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> > +++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> > @@ -1989,6 +1989,13 @@ static int kfd_fill_gpu_direct_io_link_to_cpu(int
> *avail_size,
> >             sub_type_hdr->flags |=
> CRAT_IOLINK_FLAGS_BI_DIRECTIONAL;
> >             sub_type_hdr->io_interface_type =
> CRAT_IOLINK_TYPE_XGMI;
> >             sub_type_hdr->num_hops_xgmi = 1;
> > +           if (adev->asic_type == CHIP_ALDEBARAN) {
> > +                   sub_type_hdr->minimum_bandwidth_mbs =
> > +
>       amdgpu_amdkfd_get_xgmi_bandwidth_mbytes(
> > +                                                   kdev->kgd, NULL,
> true);
> > +                   sub_type_hdr->maximum_bandwidth_mbs =
> > +                                   sub_type_hdr-
> >minimum_bandwidth_mbs;
> > +           }
> >     } else {
> >             sub_type_hdr->io_interface_type =
> CRAT_IOLINK_TYPE_PCIEXPRESS;
> >     }
> > @@ -2033,6 +2040,11 @@ static int kfd_fill_gpu_xgmi_link_to_gpu(int
> *avail_size,
> >     sub_type_hdr->proximity_domain_to = proximity_domain_to;
> >     sub_type_hdr->num_hops_xgmi =
> >             amdgpu_amdkfd_get_xgmi_hops_count(kdev->kgd,
> peer_kdev->kgd);
> > +   sub_type_hdr->maximum_bandwidth_mbs =
> > +           amdgpu_amdkfd_get_xgmi_bandwidth_mbytes(kdev->kgd,
> peer_kdev->kgd, false);
> > +   sub_type_hdr->minimum_bandwidth_mbs = sub_type_hdr-
> >maximum_bandwidth_mbs ?
> > +           amdgpu_amdkfd_get_xgmi_bandwidth_mbytes(kdev->kgd,
> NULL, true) : 0;
> > +
> >     return 0;
> >   }
> >
> >
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
