Return-Path: <SRS0=SWRn=ML=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91489C12002
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Jul 2021 03:35:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A99A61042
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Jul 2021 03:35:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A99A61042
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A59A389DD8;
	Mon, 19 Jul 2021 03:35:43 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2087.outbound.protection.outlook.com [40.107.95.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7305789DD8
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Jul 2021 03:35:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ofbivnBQlitgjqZzZsHbk5alTDqiSh5tgK4LldzmPRcU1Kcic81HSmF07+PWinPbwZx1qKobqJt6sJJPmK3RPqU40UrPOiKRKu8w3kbg46YHC9lx9TJdqu/TCT3A3sZBR7iPcitZDWoKI9E4/u7exJlGRsL8TMww3o+XfRLtbeEIQNzB3a25CgM2GeRk/a4Vh7r4mWkzu4Z0euakHKeRO5HfavHIXHV2rt6xfbmDYo5YiO4FQ9L9yPkh9852a41OH4P9tFXzGqHmL43Df2pmH6DDmTixTb3K3mJiGNsQrR1mwdd3jYQU37BQsjYPOGKRLm9lb2rmDcQSu57eEsVBDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vDJWxv1wjNFxaObQcvRoDWDH4K4/oJzKyB9BwvkH/PU=;
 b=E2lHD2noyTld2i1OBjgq9t6b24OjtBmCmbQ7o+zY7Q9QLAHycXjeR6WEe/DFGn+mwsnqnQImdVniJ2jSaWx0Yj4eBofc5jzfTnjERKuJg0F9fVE8ZsH4HLVz764R87X5N4v4Tfb5aqi4lW9tnbH0tOirrXIxRnG/5RWkJ0WA/J82DVzRN7W4P3Y4Y0exSvDk7xUH8d5SHgKTn0+EE0AaBJZ8hqkmS2pJz0HY7gkoZeXzeEAL8gPIYemsV+qDQpQZ5n7KvM7L/+lvIOtyMMVdeEu2qHzWU/6SfaLd7y9H5YfCiiSvCsElrM2ONotwjjV6QMmJA8hJ1UOX37SsIVuR7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vDJWxv1wjNFxaObQcvRoDWDH4K4/oJzKyB9BwvkH/PU=;
 b=dFGvCLVtbSE8axWtoqfhRn817d32ZNJP49jqYutKYP5aL8FbD4YrkUNoSwyrhYzMdohnerOKGnhJpokIwUz7xYxovLNKduPQwSFr75QJcr/8ArKBOYIt7C/UI/krFjrcM0UF9DauOPvlQ2hEpN92/82Nly1CbsBT5GmWlRipL7s=
Received: from DM8PR12MB5478.namprd12.prod.outlook.com (2603:10b6:8:29::12) by
 DM4PR12MB5216.namprd12.prod.outlook.com (2603:10b6:5:398::18) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4331.21; Mon, 19 Jul 2021 03:35:39 +0000
Received: from DM8PR12MB5478.namprd12.prod.outlook.com
 ([fe80::9dce:d45f:88c7:8a72]) by DM8PR12MB5478.namprd12.prod.outlook.com
 ([fe80::9dce:d45f:88c7:8a72%9]) with mapi id 15.20.4331.032; Mon, 19 Jul 2021
 03:35:39 +0000
From: "Zhou, Peng Ju" <PengJu.Zhou@amd.com>
To: "Zhou, Peng Ju" <PengJu.Zhou@amd.com>, "Liu, Monk" <Monk.Liu@amd.com>,
 Alex Deucher <alexdeucher@gmail.com>, "Liu, Leo" <Leo.Liu@amd.com>
Subject: RE: [PATCH v2] drm/amd/amdgpu: Recovery vcn instance iterate.
Thread-Topic: [PATCH v2] drm/amd/amdgpu: Recovery vcn instance iterate.
Thread-Index: AQHXd9Iwvd3Kd1vle0ail5ypjMsaGKtCjzsAgACYKACAAbka4IAEzd7g
Date: Mon, 19 Jul 2021 03:35:39 +0000
Message-ID: <DM8PR12MB54783A67E6E8D7DC0EA8D806F8E19@DM8PR12MB5478.namprd12.prod.outlook.com>
References: <20210713103054.4161-1-PengJu.Zhou@amd.com>
 <CADnq5_OOhNpLE1uibK_L09epxyzymDxi4aAZzdWTqq6tt-wbVg@mail.gmail.com>
 <BL1PR12MB52698D14831EB471F690696E84139@BL1PR12MB5269.namprd12.prod.outlook.com>
 <DM8PR12MB547842919141D197309734C9F8119@DM8PR12MB5478.namprd12.prod.outlook.com>
In-Reply-To: <DM8PR12MB547842919141D197309734C9F8119@DM8PR12MB5478.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-07-19T03:35:34Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=04a59527-ca0d-4cc6-a537-1492c3157b66;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 989b525d-d63a-4a75-5861-08d94a66476d
x-ms-traffictypediagnostic: DM4PR12MB5216:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM4PR12MB5216FE0CE73C3C9896B48C04F8E19@DM4PR12MB5216.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:421;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: A+l8BnENq+8iWNyHxYzykygOITILDZB4fPAPyrVm64uJ/JYGtfScEujsuVkWLc+MzHlhGtQavNp2YiKWFdhmVCU1Wz2Lcc9Bwy9jQXRydGgFAPP8P5Dr9mp5HwJzS5YH/9VO/hiDmVb5mutjwnytiL9AqOs6ytUg+15squ/ZRAXYZd5gUkHz3pcxaUDHSXeIrXtEcD5llR6YnU7RCS0u2brsLvm02rZmGSg7Xv6Vd/qxw47NmZjcQ/8kcFE2QG36xCDWpEVzsFp46QMtT5QULZ1zxkzE/ENmeVFdE1oSHl5L9XZuqzDPDg7TNV12VOaOhDgSlLkFqxmvqIGR9h7Wdahqph72ibrtUR4fpuf4olVp78QyRe2c/G741cnwtmIQ8ywvdR8NoYztfxfh7rqKWHp9aYroBpoO1KEwTCa6UBPDOe5nPLQ0KHvEa4qKq4xOqiLwK7ZLrbX4npwNex5J52onExWvE3hi6r09ORX5W2j7GM1Msbe99OJ2diATEG6LmclY1+tXlDkOz8CTBf0KqKaU8cH7e3at5I4W/XzCZQGkwiwXrdWSFE3Os4mrr4v3DB6IbRXeca+aCfGJJ634/shzmfWGxbwKA2TBb4G/Z3SHTh6oYt5jAS7tDddrwbXOW09hjfdU2MV8wzKqrFT2YwkYfJB0C9Gq82HhVHWNtuh7UV9+ps6g4TYvHr716HRTae0qk7gRAQAS/eWVx713AkV1BDFDLvhbxoCVGOBX+taSMWQwtGhxvH0zP/bCG5UyMdH4CP/0FKakshcdhk14ON63OUanOr3nTh+JhmziA8cznexdSiyPGjHOXxa8a+eX5S3kcLIAVdpFaLxJGaTzig==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR12MB5478.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(39860400002)(376002)(136003)(396003)(346002)(45080400002)(122000001)(8676002)(966005)(478600001)(38100700002)(7696005)(9686003)(55016002)(33656002)(52536014)(54906003)(6506007)(316002)(53546011)(6636002)(66946007)(66476007)(66556008)(64756008)(66446008)(26005)(186003)(2906002)(86362001)(76116006)(110136005)(83380400001)(4326008)(84040400003)(8936002)(5660300002)(71200400001)(38070700004);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?RBvwShdWfs5iopZ4vxHXECH4nnwixfVK1XYlwSyKXpOn5JTdL7tS477VIlI9?=
 =?us-ascii?Q?r9X8hWxAMJOizkzUf6NinfnxQrAieCJHpwlNTszHB2GdSM280VF0JGRb7RJB?=
 =?us-ascii?Q?/A2fqSelnHiijqI+l6LGNWOAZGBu6egF8vGOJyrsF3n6SPZzitXGckcqTtdZ?=
 =?us-ascii?Q?JnWPjKxbsVbEFXpKoAdND7Luhx6gn4EEKq/5R5lpc9muCDKQN6PXnvemMnT9?=
 =?us-ascii?Q?odAnPE8idmvW1Yk0bogsLnPjlFbLyUOqdgvsrUtV9zKhq64M5Ni6lKYCOZ+K?=
 =?us-ascii?Q?c4ezWNsUpb4cUdL3B9c+nUs6RBBLfs5BeD63JH0xypQIvEBd3AtUf8IT1x+8?=
 =?us-ascii?Q?uMGgOHys4weHYyJTDvTofOfARLohhwWQfK7BlhpXAlQPWKUYby14MESXOdG6?=
 =?us-ascii?Q?eAddb84UXN8/J3JqQrP/N7iL24URJQBMjB65rjRwoEyiAfWnErHdg+Q3E2lO?=
 =?us-ascii?Q?rWDt2Nyx/jg8F9zobqM64ye2qHASFw0c3tbzWiSTbQ5dK+tz7aIznUssmEIO?=
 =?us-ascii?Q?hturij9Va4vouPvAHoZvfj7/mkIwteeuIWJqoA0djXpDcF7T8CAtfXNlQPyr?=
 =?us-ascii?Q?ggEQyxDyPccEyTXZjAO2gKnvq1RN8739QmDggVsajZiRr7j2P0+zkBvshgzH?=
 =?us-ascii?Q?1z4YzXrOsIZ5+EyYFjab+vRig6ggITQMQmNrQhCIkGqAkDabprrOlnWedFSv?=
 =?us-ascii?Q?vI6fZXoDmXXT8JoBxY04dZf7L5kgJg88rZD+xBtK+zN2penfxln19cvg940C?=
 =?us-ascii?Q?8c4B9OhxLzAnGHiKn7SHUFrymXZkwOcscGSfzwesAv5Xf1+KwTh4C+nhlTul?=
 =?us-ascii?Q?A+bvxklvLesl8ARcpJnvJLzFmDOdsQA3K4HS0i3FYvKRiWdXeAHw405UVmhf?=
 =?us-ascii?Q?+gJC6lBepVY/auesL3JInL/J5gjXLG2sfMtmud1ww9lpTU7XFmv48F4GpwZz?=
 =?us-ascii?Q?HtMXNntfplNMrrdyHwLGYDpTdN9AworBiz3UuA1JdEs7iCpjntkFiOahoeoP?=
 =?us-ascii?Q?6zEubvoRhf/k2Jn5ULYil9nhPp48ir07Gsc0Cd2rQNP6XOIX3miEOWqSyVYe?=
 =?us-ascii?Q?VrOYOkk6qOXOkfptJAVVmZlmGVsHW+lYYAF7Dp0a+9Bbx3TnblDNHM0IHnLm?=
 =?us-ascii?Q?Cnjd8ecCVI/UgSbrxHaMBtjNhJmB9JDacgezFa3BrRmAKPJ8MNd3J+WVPMQA?=
 =?us-ascii?Q?WkmB2df07/NQvvm4D3i+ETmOfYZ/w5eBNGwrqbdUWv7vjH0iu2cs7VvDV/BA?=
 =?us-ascii?Q?jhYMGRDkaYL7WPLnOxhOa+PsqtgjFs6EqSGCXwSrQpwxlb2PAAzjSMf6T+ra?=
 =?us-ascii?Q?kBJJQYgj38LG76FHyU5E2fUt?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5478.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 989b525d-d63a-4a75-5861-08d94a66476d
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jul 2021 03:35:39.4556 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6V24qDveqJCDOhdO7QQNOtlZv6azYqDVBmg08b3yz2j+2FNVjUeO5ra3j2qpAWaneqbtQe7p2R45z0aNYRweBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5216
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
Cc: "Wang, Yin" <Yin.Wang@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]

Hi Leo
Can you help to review this patch?


---------------------------------------------------------------------- 
BW
Pengju Zhou




> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Zhou,
> Peng Ju
> Sent: Friday, July 16, 2021 10:15 AM
> To: Liu, Monk <Monk.Liu@amd.com>; Alex Deucher
> <alexdeucher@gmail.com>; Liu, Leo <Leo.Liu@amd.com>
> Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
> Subject: RE: [PATCH v2] drm/amd/amdgpu: Recovery vcn instance iterate.
> 
> [AMD Official Use Only]
> 
> Hi @Liu, Leo
> 
> Can you help to review this patch?
> Monk and Alex have reviewed it.
> 
> 
> ----------------------------------------------------------------------
> BW
> Pengju Zhou
> 
> 
> 
> > -----Original Message-----
> > From: Liu, Monk <Monk.Liu@amd.com>
> > Sent: Thursday, July 15, 2021 7:54 AM
> > To: Alex Deucher <alexdeucher@gmail.com>; Zhou, Peng Ju
> > <PengJu.Zhou@amd.com>; Liu, Leo <Leo.Liu@amd.com>
> > Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
> > Subject: RE: [PATCH v2] drm/amd/amdgpu: Recovery vcn instance iterate.
> >
> > [AMD Official Use Only]
> >
> > Reviewed-by: Monk Liu <monk.liu@amd.com>
> >
> > You might need @Liu, Leo's review as well
> >
> > Thanks
> >
> > ------------------------------------------
> > Monk Liu | Cloud-GPU Core team
> > ------------------------------------------
> >
> > -----Original Message-----
> > From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex
> > Deucher
> > Sent: Wednesday, July 14, 2021 10:49 PM
> > To: Zhou, Peng Ju <PengJu.Zhou@amd.com>
> > Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
> > Subject: Re: [PATCH v2] drm/amd/amdgpu: Recovery vcn instance iterate.
> >
> > On Tue, Jul 13, 2021 at 6:31 AM Peng Ju Zhou <PengJu.Zhou@amd.com>
> wrote:
> > >
> > > The previous logic is recording the amount of valid vcn instances to
> > > use them on SRIOV, it is a hard task due to the vcn accessment is
> > > based on the index of the vcn instance.
> > >
> > > Check if the vcn instance enabled before do instance init.
> > >
> > > Signed-off-by: Peng Ju Zhou <PengJu.Zhou@amd.com>
> >
> > Acked-by: Alex Deucher <alexander.deucher@amd.com>
> >
> > > ---
> > >  drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c | 33
> > > ++++++++++++++++-----------
> > >  1 file changed, 20 insertions(+), 13 deletions(-)
> > >
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> > > b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> > > index c3580de3ea9c..d11fea2c9d90 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> > > +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> > > @@ -88,9 +88,7 @@ static int vcn_v3_0_early_init(void *handle)
> > >         int i;
> > >
> > >         if (amdgpu_sriov_vf(adev)) {
> > > -               for (i = 0; i < VCN_INSTANCES_SIENNA_CICHLID; i++)
> > > -                       if (amdgpu_vcn_is_disabled_vcn(adev, VCN_DECODE_RING, i))
> > > -                               adev->vcn.num_vcn_inst++;
> > > +               adev->vcn.num_vcn_inst = VCN_INSTANCES_SIENNA_CICHLID;
> > >                 adev->vcn.harvest_config = 0;
> > >                 adev->vcn.num_enc_rings = 1;
> > >
> > > @@ -151,8 +149,7 @@ static int vcn_v3_0_sw_init(void *handle)
> > >                 adev->firmware.fw_size +=
> > >                         ALIGN(le32_to_cpu(hdr->ucode_size_bytes),
> > > PAGE_SIZE);
> > >
> > > -               if ((adev->vcn.num_vcn_inst ==
> VCN_INSTANCES_SIENNA_CICHLID)
> > ||
> > > -                   (amdgpu_sriov_vf(adev) && adev->asic_type ==
> > CHIP_SIENNA_CICHLID)) {
> > > +               if (adev->vcn.num_vcn_inst ==
> > > + VCN_INSTANCES_SIENNA_CICHLID) {
> > >                         adev->firmware.ucode[AMDGPU_UCODE_ID_VCN1].ucode_id
> =
> > AMDGPU_UCODE_ID_VCN1;
> > >                         adev->firmware.ucode[AMDGPU_UCODE_ID_VCN1].fw =
> adev-
> > >vcn.fw;
> > >                         adev->firmware.fw_size += @@ -322,18 +319,28
> > > @@ static int vcn_v3_0_hw_init(void *handle)
> > >                                 continue;
> > >
> > >                         ring = &adev->vcn.inst[i].ring_dec;
> > > -                       ring->wptr = 0;
> > > -                       ring->wptr_old = 0;
> > > -                       vcn_v3_0_dec_ring_set_wptr(ring);
> > > -                       ring->sched.ready = true;
> > > -
> > > -                       for (j = 0; j < adev->vcn.num_enc_rings; ++j) {
> > > -                               ring = &adev->vcn.inst[i].ring_enc[j];
> > > +                       if (amdgpu_vcn_is_disabled_vcn(adev, VCN_DECODE_RING,
> i))
> > {
> > > +                               ring->sched.ready = false;
> > > +                               dev_info(adev->dev, "ring %s is disabled by
> hypervisor\n",
> > ring->name);
> > > +                       } else {
> > >                                 ring->wptr = 0;
> > >                                 ring->wptr_old = 0;
> > > -                               vcn_v3_0_enc_ring_set_wptr(ring);
> > > +                               vcn_v3_0_dec_ring_set_wptr(ring);
> > >                                 ring->sched.ready = true;
> > >                         }
> > > +
> > > +                       for (j = 0; j < adev->vcn.num_enc_rings; ++j) {
> > > +                               ring = &adev->vcn.inst[i].ring_enc[j];
> > > +                               if (amdgpu_vcn_is_disabled_vcn(adev,
> > VCN_ENCODE_RING, i)) {
> > > +                                       ring->sched.ready = false;
> > > +                                       dev_info(adev->dev, "ring %s is disabled by
> > hypervisor\n", ring->name);
> > > +                               } else {
> > > +                                       ring->wptr = 0;
> > > +                                       ring->wptr_old = 0;
> > > +                                       vcn_v3_0_enc_ring_set_wptr(ring);
> > > +                                       ring->sched.ready = true;
> > > +                               }
> > > +                       }
> > >                 }
> > >         } else {
> > >                 for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
> > > --
> > > 2.17.1
> > >
> > > _______________________________________________
> > > amd-gfx mailing list
> > > amd-gfx@lists.freedesktop.org
> > > https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flist
> > > s.freedesktop.org%2Fmailman%2Flistinfo%2Famd-
> > gfx&amp;data=04%7C01%7Cmo
> > >
> >
> nk.liu%40amd.com%7Ceee0db55446b43f11a5d08d946d69bda%7C3dd8961fe4
> > 884e60
> > >
> >
> 8e11a82d994e183d%7C0%7C0%7C637618709836027968%7CUnknown%7CTW
> > FpbGZsb3d8
> > >
> >
> eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D
> > %7C1
> > >
> >
> 000&amp;sdata=0lw4us%2FTz66cgN6I0kQSwQDQzYRKfa2VuSBemqDMhcs%3D
> > &amp;res
> > > erved=0
> > _______________________________________________
> > amd-gfx mailing list
> > amd-gfx@lists.freedesktop.org
> >
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.fr
> > eedesktop.org%2Fmailman%2Flistinfo%2Famd-
> >
> gfx&amp;data=04%7C01%7Cmonk.liu%40amd.com%7Ceee0db55446b43f11a5
> >
> d08d946d69bda%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637
> >
> 618709836027968%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiL
> >
> CJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=0lw4
> > us%2FTz66cgN6I0kQSwQDQzYRKfa2VuSBemqDMhcs%3D&amp;reserved=0
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.fr
> eedesktop.org%2Fmailman%2Flistinfo%2Famd-
> gfx&amp;data=04%7C01%7CPengju.Zhou%40amd.com%7C954d8355dd564f7a
> 5d4c08d947ff8051%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C6
> 37619984967610886%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDA
> iLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=Rjt
> b0ufSZEt%2B6GFS%2FaXK4YA%2FbNeXr7ptGyFPBLut994%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
