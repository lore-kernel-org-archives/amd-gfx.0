Return-Path: <SRS0=RZx8=MG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 039D1C12002
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Jul 2021 23:54:06 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A777261029
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Jul 2021 23:54:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A777261029
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 446B76E432;
	Wed, 14 Jul 2021 23:54:05 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2059.outbound.protection.outlook.com [40.107.244.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CDEBC6E432
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Jul 2021 23:54:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E+Y7aKDz786y8mIzmdfLvUCtxhS2FLI3LPBcGIRvhK7Ej91C9Ayrk23SqAVI8L7j3t7677BO/R32MmNTOCz0ZIqP00f5RDHrc08oZSF64Z7s1GI4ofzyt2HIx/ZOD17+5dIy6+PDVNRRxyLd0H5BBxDZOiZwDe2i3fTvjoPKhgRiB/Y0RyGkXM993WJVhEVFWvI3lrEn7ST+UDKCDV6fxQz9EzPT7mtnMYaTJp6nZyjIAcZjYLHv3YAoRmuxsxsGWXNQDcxBHC713rVbU++piGPOu7vjo85Xyh4Fs1+U+ZyiMKg6Jhvdj6HD4LU/XY+ncHoUPHYcKglu+tC2DY2PZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E3RjY4n8IZNyME24rkjZ9B01gldQ/n08sC/99V2a4PY=;
 b=FMr20G/OPDlKXhKUmgt5gUZQKnMPZg1DyR5DHTv9WTPiwestGhhPhbpU2QVqS1huTPEczcjU7Q/WnH9ydPha14ijZQFZJXssF5Ip0e1T3plO5kPlLoUpUtCAzTju6L6jcNQI3B+SgxCrtfoamfC+4nYcR+iBctaNEH9eCtQfJcT+n2TpZHCgaInuj9BBPeuJDgisI+W6IPGMWqKKJelm8FUhn/u043m+ZwcPylOmWLKzJay9gAKp3aU0wAQsjPvaTdrtuGgZr0pyvJCpx9JMijOPvRTppH4kqGIY2ilHM2j/Q96FoFQRa+YSMqFtEkzSfcyixwKYhaL3mdCBhSIiXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E3RjY4n8IZNyME24rkjZ9B01gldQ/n08sC/99V2a4PY=;
 b=qsbn+vlhS82yGj1HihIPZx3Z56sq4VqIC8s8hFvNpCuWNEjQegc98jnfEnPqpS7MyR1JWE8SAJX/OgfO9226YkelDnt0UieH0nKiQ9jUZLFaGshJbbQPqzacCWxicThKxfXwZJivWj83DFGt8MhQ6cj+Q+0nn6sPR4OQ9Yq1PcU=
Received: from BL1PR12MB5269.namprd12.prod.outlook.com (2603:10b6:208:30b::20)
 by BL0PR12MB5556.namprd12.prod.outlook.com (2603:10b6:208:1cf::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21; Wed, 14 Jul
 2021 23:54:00 +0000
Received: from BL1PR12MB5269.namprd12.prod.outlook.com
 ([fe80::d9d7:2d92:acc3:e3c3]) by BL1PR12MB5269.namprd12.prod.outlook.com
 ([fe80::d9d7:2d92:acc3:e3c3%3]) with mapi id 15.20.4308.027; Wed, 14 Jul 2021
 23:54:00 +0000
From: "Liu, Monk" <Monk.Liu@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, "Zhou, Peng Ju"
 <PengJu.Zhou@amd.com>, "Liu, Leo" <Leo.Liu@amd.com>
Subject: RE: [PATCH v2] drm/amd/amdgpu: Recovery vcn instance iterate.
Thread-Topic: [PATCH v2] drm/amd/amdgpu: Recovery vcn instance iterate.
Thread-Index: AQHXd9JTYboMshPaSkirtTTEK9V4VqtCjzoAgACYEMA=
Date: Wed, 14 Jul 2021 23:54:00 +0000
Message-ID: <BL1PR12MB52698D14831EB471F690696E84139@BL1PR12MB5269.namprd12.prod.outlook.com>
References: <20210713103054.4161-1-PengJu.Zhou@amd.com>
 <CADnq5_OOhNpLE1uibK_L09epxyzymDxi4aAZzdWTqq6tt-wbVg@mail.gmail.com>
In-Reply-To: <CADnq5_OOhNpLE1uibK_L09epxyzymDxi4aAZzdWTqq6tt-wbVg@mail.gmail.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-Mentions: Leo.Liu@amd.com
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-07-14T23:53:59Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=04a59527-ca0d-4cc6-a537-1492c3157b66;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fefd6bb1-a40c-4f60-38be-08d94722a6e7
x-ms-traffictypediagnostic: BL0PR12MB5556:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL0PR12MB55561DDF4353E07C470EAB3B84139@BL0PR12MB5556.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:378;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XoFdXlbdn6u0RaYmF+s9iV3DsVmL8OFtd7cyYyL3yxewW6YMjqoV/jrlxAUdhGWueJeEkSvsuy/6HJQrGNFh4SN+ilaPKy0E4mJoyEGoa87UMlkSL364e1Qrv4yzYEEtEkQdxnP9Nq+1ZOHiEVMzvOdjGqLOZSyVkki91bTzluVIPNB6U1msudMSSlgsG2f6hz8CO9q3yo0Y/RCtMIVLIObOD2b25Oucbar1QUEba2HV7YG9txifM5hM8YT3kIeOWquPhmdynHbpqWt6sKl8JE1ZF0g+IvpgV9WlaGDM3+6ZbfXaO10nTfV7sGGFLCMmZZ5POO+sEpcq8AGR/1o40Ab+98Jt8ywq3hyby/57FHIET9n2XLbruwzQ8HgG6LrnrXF01dH9NJN11cDOLrzjzi5diqNJIZYhRRp2btJnm0t1x+9jnlsv7EW1QzV+lqi5NDpwxNHhffxbRw+GvQSAcg+BlUUyVw0+2ZDc9lvTATq2sR0zmBUX3v8vkwHFnMyxy5ELeRWEqOLKjt15HzuLRBZbF+8WZZGTY2Bzm35kh2Hb9+cY9Tb6Q5RVRoRlnZpE+ymlNfAQY/RHp5QG0EWpT/xj7Y9GQEMa32sGsDqznGOStExtOwihdV1h8CtQ58falaRf+pn+3xtVVA81/dPiubXPrq4wY7lPdDCxiXZA/glAZgnw1BQu8WFmzYPC+H8B8QY3zHbppSSXmPMigxQ+9Grb/ew05vUwxzObIyO8Ok4xULHonhQWuLAng4/AILXaZbc/35PYfAb47yOTknJJAzONCABk54hWNC0kgvf/EMU=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5269.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(346002)(39860400002)(366004)(376002)(396003)(5660300002)(45080400002)(478600001)(53546011)(966005)(33656002)(186003)(86362001)(6506007)(8676002)(71200400001)(7696005)(52536014)(8936002)(9686003)(2906002)(76116006)(122000001)(4326008)(6636002)(66946007)(66446008)(66476007)(26005)(64756008)(316002)(38100700002)(66556008)(83380400001)(110136005)(55016002)(38070700004);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?BcSWiAlylEgqalo4W1tR1L1VqZoiu6kw9nuNWGvnOHIyjOnaD2w4ZAHr5/q2?=
 =?us-ascii?Q?z2mYK0aPIAYtEnHn4QMazhtl0QP6qbKs7QKeoTld81I7GuZWqcfldGsfLGox?=
 =?us-ascii?Q?gX1Zrf/IhypDWpKgk8rnSLs7yflL5SBSo806Z7MyDFZau24chfetdJzGj4jb?=
 =?us-ascii?Q?M1d+LyGHpNhvwOl6TmebtTJdB5Y9b6Ipn/EqL8XhcTjaSmBIfJSj3Uko3Vb4?=
 =?us-ascii?Q?jRPX3Lt/PnVrxRQRYN4gJo+sEn4mV0cI0F5unc0UCVXEyL7ylQLU2k9GaQdR?=
 =?us-ascii?Q?lENgWUxfy57C7VXjxhwCV0kuGfwlk26CBbae7lIeObAa0bNXSwHdd/DB2tQs?=
 =?us-ascii?Q?s3V1JbcAuxH0oj9wdBOlstRm7G4yMYae9DCPiUT5M0+5lnZvcT0IJZyF6Xf6?=
 =?us-ascii?Q?4JFb3hbhwmHjfJ0FjTe6X409JhX4RHfFansK+byh2fYuil4P2UCl3RXiQBGO?=
 =?us-ascii?Q?NBaE2A6r+bR/cq5XqIUHjNNBJGTgwGZrI+z4m+6R+JZFMthWARoIQW3oebxE?=
 =?us-ascii?Q?pJ07o4rzRl88q+1Q2QgL9L3S00lUaJ4HirEpcl1EJhJXc6NJVjPyuo3AcpwC?=
 =?us-ascii?Q?nU08TLQuDlpe16dvK15d7xfTyh/hRGgAgoSZ82LLJsMCD1SwryhcFaeX8/TM?=
 =?us-ascii?Q?IeEuWmgReSsjeio9jofHORl4V4bru9SxgKm00mI5MlnbV8zeBjl8I2LPV2N6?=
 =?us-ascii?Q?vupUtVvzD8HBx72tjStj824nwJIF3kbAftlGWRr7dGMPgOSlcqe0RKYb3jw6?=
 =?us-ascii?Q?z+7hGsHrglYixm2m4sq5ghQ7eKXwOiv7o0NXt3Lwg7T5O+TIr1M3O4mQ+fLN?=
 =?us-ascii?Q?uCkZcw6+v0n8P2G+6wk4XjFKiRnhN6MdBLZ6v0prm1NfUgmps2JvAmk4HUTe?=
 =?us-ascii?Q?xoidOmF/MVDdi0tgWnWqkB5PKHUq1HlpHQmPJtlt9oclXrgoXLuLI3oT2Rlj?=
 =?us-ascii?Q?2Ai1B5RAj6XhfaKZvWRquMaY1XdPOSkPedEQ9XYL1qP72iHn5MGz2CQsWlk0?=
 =?us-ascii?Q?ia7yNq+6Ung5QSTYlJiTLmhISfYCPzCQo+oLg4RixSwvmppp9OTRr2om3F2n?=
 =?us-ascii?Q?oGFByO1CxVu/60x2pDzGC2SO+AAb/NT/T7ln5mAvoxom09AExnaA1g1PZwEN?=
 =?us-ascii?Q?OHwsOq0w0chjEalm8XpdWgUDqspkFxXNevC11APlGbdvcjt7/N8l1zuDgZ3x?=
 =?us-ascii?Q?McrN92tDqP45k9P7LlYEPez/VIJrrZlnVmHhq1KLH6wDnZ+tw7byxEQrX3ec?=
 =?us-ascii?Q?Fm7lRwCXp1vVwpSPqrkZW2ID3FXdJUPySjzq+k8TL4rt3swTUjtYqt0F2GWP?=
 =?us-ascii?Q?f790jhYI5L58HK+s384MQ5dh?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5269.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fefd6bb1-a40c-4f60-38be-08d94722a6e7
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2021 23:54:00.3032 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GQWonEvRPa38g1IpyejdvSLov1osqBzY2TUybxYG3hFbjzwY6Js2/ycmhHdtsknF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB5556
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
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]

Reviewed-by: Monk Liu <monk.liu@amd.com>

You might need @Liu, Leo's review as well 

Thanks 

------------------------------------------
Monk Liu | Cloud-GPU Core team
------------------------------------------

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deucher
Sent: Wednesday, July 14, 2021 10:49 PM
To: Zhou, Peng Ju <PengJu.Zhou@amd.com>
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH v2] drm/amd/amdgpu: Recovery vcn instance iterate.

On Tue, Jul 13, 2021 at 6:31 AM Peng Ju Zhou <PengJu.Zhou@amd.com> wrote:
>
> The previous logic is recording the amount of valid vcn instances to 
> use them on SRIOV, it is a hard task due to the vcn accessment is 
> based on the index of the vcn instance.
>
> Check if the vcn instance enabled before do instance init.
>
> Signed-off-by: Peng Ju Zhou <PengJu.Zhou@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c | 33 
> ++++++++++++++++-----------
>  1 file changed, 20 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c 
> b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> index c3580de3ea9c..d11fea2c9d90 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> @@ -88,9 +88,7 @@ static int vcn_v3_0_early_init(void *handle)
>         int i;
>
>         if (amdgpu_sriov_vf(adev)) {
> -               for (i = 0; i < VCN_INSTANCES_SIENNA_CICHLID; i++)
> -                       if (amdgpu_vcn_is_disabled_vcn(adev, VCN_DECODE_RING, i))
> -                               adev->vcn.num_vcn_inst++;
> +               adev->vcn.num_vcn_inst = VCN_INSTANCES_SIENNA_CICHLID;
>                 adev->vcn.harvest_config = 0;
>                 adev->vcn.num_enc_rings = 1;
>
> @@ -151,8 +149,7 @@ static int vcn_v3_0_sw_init(void *handle)
>                 adev->firmware.fw_size +=
>                         ALIGN(le32_to_cpu(hdr->ucode_size_bytes), 
> PAGE_SIZE);
>
> -               if ((adev->vcn.num_vcn_inst == VCN_INSTANCES_SIENNA_CICHLID) ||
> -                   (amdgpu_sriov_vf(adev) && adev->asic_type == CHIP_SIENNA_CICHLID)) {
> +               if (adev->vcn.num_vcn_inst == 
> + VCN_INSTANCES_SIENNA_CICHLID) {
>                         adev->firmware.ucode[AMDGPU_UCODE_ID_VCN1].ucode_id = AMDGPU_UCODE_ID_VCN1;
>                         adev->firmware.ucode[AMDGPU_UCODE_ID_VCN1].fw = adev->vcn.fw;
>                         adev->firmware.fw_size += @@ -322,18 +319,28 
> @@ static int vcn_v3_0_hw_init(void *handle)
>                                 continue;
>
>                         ring = &adev->vcn.inst[i].ring_dec;
> -                       ring->wptr = 0;
> -                       ring->wptr_old = 0;
> -                       vcn_v3_0_dec_ring_set_wptr(ring);
> -                       ring->sched.ready = true;
> -
> -                       for (j = 0; j < adev->vcn.num_enc_rings; ++j) {
> -                               ring = &adev->vcn.inst[i].ring_enc[j];
> +                       if (amdgpu_vcn_is_disabled_vcn(adev, VCN_DECODE_RING, i)) {
> +                               ring->sched.ready = false;
> +                               dev_info(adev->dev, "ring %s is disabled by hypervisor\n", ring->name);
> +                       } else {
>                                 ring->wptr = 0;
>                                 ring->wptr_old = 0;
> -                               vcn_v3_0_enc_ring_set_wptr(ring);
> +                               vcn_v3_0_dec_ring_set_wptr(ring);
>                                 ring->sched.ready = true;
>                         }
> +
> +                       for (j = 0; j < adev->vcn.num_enc_rings; ++j) {
> +                               ring = &adev->vcn.inst[i].ring_enc[j];
> +                               if (amdgpu_vcn_is_disabled_vcn(adev, VCN_ENCODE_RING, i)) {
> +                                       ring->sched.ready = false;
> +                                       dev_info(adev->dev, "ring %s is disabled by hypervisor\n", ring->name);
> +                               } else {
> +                                       ring->wptr = 0;
> +                                       ring->wptr_old = 0;
> +                                       vcn_v3_0_enc_ring_set_wptr(ring);
> +                                       ring->sched.ready = true;
> +                               }
> +                       }
>                 }
>         } else {
>                 for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
> --
> 2.17.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flist
> s.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Cmo
> nk.liu%40amd.com%7Ceee0db55446b43f11a5d08d946d69bda%7C3dd8961fe4884e60
> 8e11a82d994e183d%7C0%7C0%7C637618709836027968%7CUnknown%7CTWFpbGZsb3d8
> eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1
> 000&amp;sdata=0lw4us%2FTz66cgN6I0kQSwQDQzYRKfa2VuSBemqDMhcs%3D&amp;res
> erved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Cmonk.liu%40amd.com%7Ceee0db55446b43f11a5d08d946d69bda%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637618709836027968%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=0lw4us%2FTz66cgN6I0kQSwQDQzYRKfa2VuSBemqDMhcs%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
