Return-Path: <SRS0=uqvu=KN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,PDS_BAD_THREAD_QP_64,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 300EAC433ED
	for <amd-gfx@archiver.kernel.org>; Tue, 18 May 2021 02:44:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E272E61369
	for <amd-gfx@archiver.kernel.org>; Tue, 18 May 2021 02:44:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E272E61369
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 37BF96E5A5;
	Tue, 18 May 2021 02:44:47 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2074.outbound.protection.outlook.com [40.107.94.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A97EC6E5A5
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 May 2021 02:44:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mo1JKic3xqzAVE0nQCtrG3IJ+IjRBqPiWor1Ip5N+9eh6Vop2cXaHAPGWTXWrqRm1I55hs1Gukdp7iacShGuMR7qcKLSRQBLWAbQKPFnlu9uhxy02wETA4CQd7AMjpiKNHYlvEo0FszyQwBY+2hdhOwnzjYS9pV4m9rI8Ft1kG4WIjxGziV5/FXAWZQC/YueZpm1+RSHm6qEM3dL3wIJ+ILudwzl1aAAVzVzHlpe8GwI7NtT6p9mIB6waEhJu7VPPVnCW58GW42FtEAUJeGV5bCow0CxA3oJARe7dIeS8i67kVPr6fAIEDc03IUGQhi1c6z48xd4IaRtiZ/6NnnPIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RMTRDbMNXIJLKbMKIYmnBDpbmSwpri4ARfbSCSRZuF8=;
 b=NpzCeBO9wQxExzzAob6lgpy1/P8RYbBHPFPqauiFXw0J8iE2E1f8Hta5eYlNJz+Bo8wp7tJX7HfCiUYxMjAahsRR0IDUPYoEWBFbOKH0iLVRea3/T0idDi4HYKThL5al8QdgeP3pc6w7MDOKuLR0RyTNLWbzIs/dz32Sa46NHESkHVYgsZxwBjiX1WXn5oBY8BMvrgyjzF2Ap8Fcv1Za+SaKsv4TBTCLjdFxXLSaGlm/HrT0F1471N3loxArcPqusfesoE+zSLynXAT0AcNweX/eedzzjmXJfGAOkaNdlFa4LUKH6YLeHpGMHHNAUHx6rt0PKziAuVR9MRpHD8YCoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RMTRDbMNXIJLKbMKIYmnBDpbmSwpri4ARfbSCSRZuF8=;
 b=Q4u1b61MhR7OaSgMu+TvHctPvicgsHmbo0IATVcy5nGjywgcHlgvhwoSj0KEw4yN2UEld8l662ELA9HBSJ8Vi8QS+EHIcekepqte5aIhjOvgVDQ7K0z3mWTOZjpS8sNevMnQzSf9fw7F/4/iFJ6sU84P71kWjxye3ToNMN+FWXs=
Received: from BYAPR12MB2840.namprd12.prod.outlook.com (2603:10b6:a03:62::32)
 by BY5PR12MB3714.namprd12.prod.outlook.com (2603:10b6:a03:1a9::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.26; Tue, 18 May
 2021 02:44:38 +0000
Received: from BYAPR12MB2840.namprd12.prod.outlook.com
 ([fe80::7c65:7181:6d1d:8616]) by BYAPR12MB2840.namprd12.prod.outlook.com
 ([fe80::7c65:7181:6d1d:8616%7]) with mapi id 15.20.4129.031; Tue, 18 May 2021
 02:44:37 +0000
From: "Nieto, David M" <David.Nieto@amd.com>
To: "Gu, JiaWei (Will)" <JiaWei.Gu@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "maraeo@gmail.com" <maraeo@gmail.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: Re: [PATCH] drm/amdgpu: Add vbios info ioctl interface
Thread-Topic: [PATCH] drm/amdgpu: Add vbios info ioctl interface
Thread-Index: AQHXSxVPBvM50M0wZkSTUB4XlW18fKrnlu0AgAACYYCAAObDgIAACKsH
Date: Tue, 18 May 2021 02:44:37 +0000
Message-ID: <BYAPR12MB2840E231B64B432D709A3B59F42C9@BYAPR12MB2840.namprd12.prod.outlook.com>
References: <20210517120804.27052-1-Jiawei.Gu@amd.com>
 <CH0PR12MB5156D238E265426E504B791BF82D9@CH0PR12MB5156.namprd12.prod.outlook.com>
 <51161d6d-a6be-90f0-262d-5215402e25dd@amd.com>,
 <CH0PR12MB515644C1FF56458EFCA4B0FBF82C9@CH0PR12MB5156.namprd12.prod.outlook.com>
In-Reply-To: <CH0PR12MB515644C1FF56458EFCA4B0FBF82C9@CH0PR12MB5156.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-05-18T02:44:37.431Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.53.104]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4d72ddcb-eced-41df-d79b-08d919a6e100
x-ms-traffictypediagnostic: BY5PR12MB3714:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR12MB371469EF5CA2468084FABE5AF42C9@BY5PR12MB3714.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OPr3L2dRUHUiLXtvgV8d0Yz4k0d8fIIK7bL6qy2mWADBhY7atEUNryDOO2Vq/7KMyQWjELMSy+nqTO8DWkLjTi0fn+wl8zfcsDiBeGGrLmly1zdvVrMZ8m0NKuFhmBID56OJqx/GTJ+RZT06MYgsu1m1FhutLV1ufvxf2XS0eE21oVAlO3+PGkNxy/KMTvJtNa1iuafg9Y9T5QemKiML8ceHwxnIxgFK7eLECe5amtk9qE4l0o+deBAQM3AwPP8QdDaKTYioNHTrFRZzDuXQdgE3K3ng7afNOk6LluclkAiEOZVeON+BiBQDXlTr4Cfqv23LX6uXLRDD7GLVsNLyJruaIXciZjtlvizRvK6dfP29azO62V/dvyv5ixskozjHwyx1AzKJnd7b8+iBtM6iKTmEhHTgfeVC0gZ1GdCsMUqvo37o0tqrkb3E2Cd2ugKbIziiSmgE+a85GGFxgyOoa6CTZZaYjh6b2vVgRiwY2bxxx+nF788E1XQxDNgwY70wwQS0ag39x82oP0uLcplv9BqjTXSyfF6qTVku20vaUcRn62AfgCesPSJdckPlIf9bZErCu/TXMIXCB8katlAprEITPQxqAQwnQd62HJuvCI8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB2840.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(366004)(376002)(346002)(136003)(55016002)(7696005)(66476007)(66946007)(66556008)(76116006)(66446008)(64756008)(33656002)(5660300002)(186003)(122000001)(8936002)(8676002)(26005)(53546011)(6506007)(316002)(110136005)(38100700002)(66574015)(2906002)(83380400001)(86362001)(9686003)(71200400001)(30864003)(6636002)(19627405001)(52536014)(478600001)(4326008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?pdwizrGYglhUsw/dwSBul/6kL/cOuheE3qS058T47PuYX5ZFhuxRwkfXoe?=
 =?iso-8859-1?Q?o1EIEPpLVFCuLjKJ0RJkdMhXum04zLMAzZx8h8ZK8Afj0Z+rVwMpAwBjOL?=
 =?iso-8859-1?Q?J3el2p4wQqdi4rDHYgSkbsttGxV96tbJ/6IYvJmN2kU7d7BhAXfHsuTuLd?=
 =?iso-8859-1?Q?dDWn2dne5+3wh9/LWr0gMYuvtNVr8wwX4aK0u50M1CT1mb8yZDqC6D7zqO?=
 =?iso-8859-1?Q?hveon1ghZ8JVrj0LoKFLZLjGqcE8e1NBAbYhGhClmic7Y5V3zVJPxUToEX?=
 =?iso-8859-1?Q?gHxKISMPyvU4azgId4hrj0U9PSJO2V+HS24KiHFRt+XpULmmCg5e86VBC8?=
 =?iso-8859-1?Q?NKheeD2igGMnGB3GCFjv6k0EDFiEoB1iZ6LcT6VOldNWjdVQmbyUlNca25?=
 =?iso-8859-1?Q?knndS31jfnNEWhwHMrwg9xSX44Ld1zcS1bhksEn8pfbaJ0A1m0J3elpABE?=
 =?iso-8859-1?Q?mIOz2z8eHVSpseUAv6PEIWxnCRTHWY2HL4pZ0IlYCv+0F+xuQ9WVUjuNCt?=
 =?iso-8859-1?Q?EXEEX1sO+dJVBBwlehSFC+n5zg2Wyd520LyaXg5Pn+Fh53wlqrKD6bk/1d?=
 =?iso-8859-1?Q?/CEPxtXC1i6w4j1YwsWvFLJy9pqf0oJOL7+ZqURrn09sTYTviDz1QzfY2i?=
 =?iso-8859-1?Q?FfxJRSqo3Iz7Oer5p3xu/478IvTvKR7Zn7wcmsr6iM1l9Brt6AXWuW/fRo?=
 =?iso-8859-1?Q?yj1NYbsWhs3n3QU0i5Kih+V5xE3xwQI9MevKSi1k/B4D/hyxDF42a/Kt5m?=
 =?iso-8859-1?Q?2wGfrHTX+uMJaBxPVlwy39GEnTuTywgNYLQWxFyJcZzed1MIXqOIJrmpVr?=
 =?iso-8859-1?Q?//7deLq5vbqSOa/OeI/UlTwUjujQhVIco9ffz80Ya+2P8aP+z/mpzYF1P9?=
 =?iso-8859-1?Q?0vn/B/jX5T3JZiQ5FHak7r5yF2FWNgs4gq+mm2X1QI0CZJDqfS+B+pHLNl?=
 =?iso-8859-1?Q?X9HbKSaSzqNxr8ehXMTWMdXkNxzDB55uQAIa8bRF8rRmhVwyyWH51nI6aT?=
 =?iso-8859-1?Q?8RrcvpDsAMctYlHSeKc3d/WKaaCa+EgHTRIH4gBndSvNGDMKhZwqZ+GSvm?=
 =?iso-8859-1?Q?wpCNDLybf/xpOoPkR9xDeBxiZ55aKQa9875WJLcRI47xmI7gzo+2rwAXw9?=
 =?iso-8859-1?Q?LYzu5LdHhkSwJmTiaNl0rmxz98Jo3GRFFdvbZ2mFQQA7u0+xu2JpOJluuN?=
 =?iso-8859-1?Q?+isXMSLeqI8n+sfYy83a2GMFJAQJMmnzDEwPTcvE5jVuO4ycb2hN2i4WMn?=
 =?iso-8859-1?Q?n/tvbjjWhiZt+OzNTptAtgxFthp9id5uXQNbm4JOOW9hiwkMntvancz2NL?=
 =?iso-8859-1?Q?r/fJ7YOShz1PHeKuLzLMSK/1QDi1NKDUezjK+a54b6fnnIYMk3EFaYb4KS?=
 =?iso-8859-1?Q?POfrCeRtxP?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2840.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d72ddcb-eced-41df-d79b-08d919a6e100
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 May 2021 02:44:37.8411 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bt54904qEFac5PiWBnjb9xSbBPg5PQFQDBVxkC6NRRbppf4AaPONvLEXwoUYTFNG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3714
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
Cc: "Deng, Emily" <Emily.Deng@amd.com>
Content-Type: multipart/mixed; boundary="===============1888821419=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1888821419==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BYAPR12MB2840E231B64B432D709A3B59F42C9BYAPR12MB2840namp_"

--_000_BYAPR12MB2840E231B64B432D709A3B59F42C9BYAPR12MB2840namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

The serial number is ASIC information, not VBIOS information, and it is sti=
ll available as a sysfs node... I don't think we should put it there.

Not sure what dbdf stands for.
________________________________
From: Gu, JiaWei (Will) <JiaWei.Gu@amd.com>
Sent: Monday, May 17, 2021 7:11 PM
To: Koenig, Christian <Christian.Koenig@amd.com>; amd-gfx@lists.freedesktop=
.org <amd-gfx@lists.freedesktop.org>; Nieto, David M <David.Nieto@amd.com>;=
 maraeo@gmail.com <maraeo@gmail.com>; Deucher, Alexander <Alexander.Deucher=
@amd.com>
Cc: Deng, Emily <Emily.Deng@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Add vbios info ioctl interface

[AMD Official Use Only - Internal Distribution Only]

So I guess the dbdf is also needed to be removed?
And how about serial?

> +struct drm_amdgpu_info_vbios {
> +     __u8 name[64];
> +     __u32 dbdf; // do we need this?
> +     __u8 vbios_pn[64];
> +     __u32 version;
> +     __u8 vbios_ver_str[32];
> +     __u8 date[32];
> +     __u64 serial; // do we need this?
> +};

Best regards,
Jiawei

-----Original Message-----
From: Koenig, Christian <Christian.Koenig@amd.com>
Sent: Monday, May 17, 2021 8:26 PM
To: Gu, JiaWei (Will) <JiaWei.Gu@amd.com>; amd-gfx@lists.freedesktop.org; N=
ieto, David M <David.Nieto@amd.com>; maraeo@gmail.com; Deucher, Alexander <=
Alexander.Deucher@amd.com>
Cc: Deng, Emily <Emily.Deng@amd.com>
Subject: Re: [PATCH] drm/amdgpu: Add vbios info ioctl interface

I'm not very familiar with the technical background why we have the fields =
here once more.

But of hand we should at least remove everything which is also available fr=
om the PCI information.

E.g. dev_id, rev_id, sub_dev_id, sub_ved_id.

Regards,
Christian.

Am 17.05.21 um 14:17 schrieb Gu, JiaWei (Will):
> [AMD Official Use Only - Internal Distribution Only]
>
> Hi all,
>
> Thanks Christian's suggestion.
> I reverted the previous patches and squash them into this single one.
>
> As this patch shows, the current uapi change looks like this:
>
> +struct drm_amdgpu_info_vbios {
> +     __u8 name[64];
> +     __u32 dbdf;
> +     __u8 vbios_pn[64];
> +     __u32 version;
> +     __u8 vbios_ver_str[32];
> +     __u8 date[32];
> +     __u64 serial;
> +     __u32 dev_id;
> +     __u32 rev_id;
> +     __u32 sub_dev_id;
> +     __u32 sub_ved_id;
> +};
>
> As we know there's some redundant info in this struct.
> Please feel free to give any comments or suggestion about what it should =
& shouldn't include.
>
> Best regards,
> Jiawei
>
> -----Original Message-----
> From: Jiawei Gu <Jiawei.Gu@amd.com>
> Sent: Monday, May 17, 2021 8:08 PM
> To: amd-gfx@lists.freedesktop.org; Koenig, Christian
> <Christian.Koenig@amd.com>; Nieto, David M <David.Nieto@amd.com>;
> maraeo@gmail.com; Deucher, Alexander <Alexander.Deucher@amd.com>
> Cc: Deng, Emily <Emily.Deng@amd.com>; Gu, JiaWei (Will)
> <JiaWei.Gu@amd.com>
> Subject: [PATCH] drm/amdgpu: Add vbios info ioctl interface
>
> Add AMDGPU_INFO_VBIOS_INFO subquery id for detailed vbios info.
>
> Provides a way for the user application to get the VBIOS information with=
out having to parse the binary.
> It is useful for the user to be able to display in a simple way the VBIOS=
 version in their system if they happen to encounter an issue.
>
> V2:
> Use numeric serial.
> Parse and expose vbios version string.
>
> Signed-off-by: Jiawei Gu <Jiawei.Gu@amd.com>
> Acked-by: Christian K=F6nig <christian.koenig@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c    |  21 +++
>   drivers/gpu/drm/amd/amdgpu/atom.c          | 174 +++++++++++++++++++++
>   drivers/gpu/drm/amd/amdgpu/atom.h          |  12 ++
>   drivers/gpu/drm/amd/include/atomfirmware.h |   5 +
>   include/uapi/drm/amdgpu_drm.h              |  16 ++
>   5 files changed, 228 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> index 8d12e474745a..30e4fed3de22 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> @@ -861,6 +861,27 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *=
data, struct drm_file *filp)
>                                            min((size_t)size, (size_t)(bio=
s_size - bios_offset)))
>                                        ? -EFAULT : 0;
>                }
> +             case AMDGPU_INFO_VBIOS_INFO: {
> +                     struct drm_amdgpu_info_vbios vbios_info =3D {};
> +                     struct atom_context *atom_context;
> +
> +                     atom_context =3D adev->mode_info.atom_context;
> +                     memcpy(vbios_info.name, atom_context->name, sizeof(=
atom_context->name));
> +                     vbios_info.dbdf =3D PCI_DEVID(adev->pdev->bus->numb=
er, adev->pdev->devfn);
> +                     memcpy(vbios_info.vbios_pn, atom_context->vbios_pn,=
 sizeof(atom_context->vbios_pn));
> +                     vbios_info.version =3D atom_context->version;
> +                     memcpy(vbios_info.vbios_ver_str, atom_context->vbio=
s_ver_str,
> +                                             sizeof(atom_context->vbios_=
ver_str));
> +                     memcpy(vbios_info.date, atom_context->date, sizeof(=
atom_context->date));
> +                     vbios_info.serial =3D adev->unique_id;
> +                     vbios_info.dev_id =3D adev->pdev->device;
> +                     vbios_info.rev_id =3D adev->pdev->revision;
> +                     vbios_info.sub_dev_id =3D atom_context->sub_dev_id;
> +                     vbios_info.sub_ved_id =3D atom_context->sub_ved_id;
> +
> +                     return copy_to_user(out, &vbios_info,
> +                                             min((size_t)size, sizeof(vb=
ios_info))) ? -EFAULT : 0;
> +             }
>                default:
>                        DRM_DEBUG_KMS("Invalid request %d\n",
>                                        info->vbios_info.type);
> diff --git a/drivers/gpu/drm/amd/amdgpu/atom.c
> b/drivers/gpu/drm/amd/amdgpu/atom.c
> index 3dcb8b32f48b..542b2c2414e4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/atom.c
> +++ b/drivers/gpu/drm/amd/amdgpu/atom.c
> @@ -31,6 +31,7 @@
>
>   #define ATOM_DEBUG
>
> +#include "atomfirmware.h"
>   #include "atom.h"
>   #include "atom-names.h"
>   #include "atom-bits.h"
> @@ -1299,12 +1300,168 @@ static void atom_index_iio(struct atom_context *=
ctx, int base)
>        }
>   }
>
> +static void atom_get_vbios_name(struct atom_context *ctx) {
> +     unsigned char *p_rom;
> +     unsigned char str_num;
> +     unsigned short off_to_vbios_str;
> +     unsigned char *c_ptr;
> +     int name_size;
> +     int i;
> +
> +     const char *na =3D "--N/A--";
> +     char *back;
> +
> +     p_rom =3D ctx->bios;
> +
> +     str_num =3D *(p_rom + OFFSET_TO_GET_ATOMBIOS_NUMBER_OF_STRINGS);
> +     if (str_num !=3D 0) {
> +             off_to_vbios_str =3D
> +                     *(unsigned short *)(p_rom + OFFSET_TO_GET_ATOMBIOS_=
STRING_START);
> +
> +             c_ptr =3D (unsigned char *)(p_rom + off_to_vbios_str);
> +     } else {
> +             /* do not know where to find name */
> +             memcpy(ctx->name, na, 7);
> +             ctx->name[7] =3D 0;
> +             return;
> +     }
> +
> +     /*
> +      * skip the atombios strings, usually 4
> +      * 1st is P/N, 2nd is ASIC, 3rd is PCI type, 4th is Memory type
> +      */
> +     for (i =3D 0; i < str_num; i++) {
> +             while (*c_ptr !=3D 0)
> +                     c_ptr++;
> +             c_ptr++;
> +     }
> +
> +     /* skip the following 2 chars: 0x0D 0x0A */
> +     c_ptr +=3D 2;
> +
> +     name_size =3D strnlen(c_ptr, STRLEN_LONG - 1);
> +     memcpy(ctx->name, c_ptr, name_size);
> +     back =3D ctx->name + name_size;
> +     while ((*--back) =3D=3D ' ')
> +             ;
> +     *(back + 1) =3D '\0';
> +}
> +
> +static void atom_get_vbios_date(struct atom_context *ctx) {
> +     unsigned char *p_rom;
> +     unsigned char *date_in_rom;
> +
> +     p_rom =3D ctx->bios;
> +
> +     date_in_rom =3D p_rom + OFFSET_TO_VBIOS_DATE;
> +
> +     ctx->date[0] =3D '2';
> +     ctx->date[1] =3D '0';
> +     ctx->date[2] =3D date_in_rom[6];
> +     ctx->date[3] =3D date_in_rom[7];
> +     ctx->date[4] =3D '/';
> +     ctx->date[5] =3D date_in_rom[0];
> +     ctx->date[6] =3D date_in_rom[1];
> +     ctx->date[7] =3D '/';
> +     ctx->date[8] =3D date_in_rom[3];
> +     ctx->date[9] =3D date_in_rom[4];
> +     ctx->date[10] =3D ' ';
> +     ctx->date[11] =3D date_in_rom[9];
> +     ctx->date[12] =3D date_in_rom[10];
> +     ctx->date[13] =3D date_in_rom[11];
> +     ctx->date[14] =3D date_in_rom[12];
> +     ctx->date[15] =3D date_in_rom[13];
> +     ctx->date[16] =3D '\0';
> +}
> +
> +static unsigned char *atom_find_str_in_rom(struct atom_context *ctx, cha=
r *str, int start,
> +                                        int end, int maxlen)
> +{
> +     unsigned long str_off;
> +     unsigned char *p_rom;
> +     unsigned short str_len;
> +
> +     str_off =3D 0;
> +     str_len =3D strnlen(str, maxlen);
> +     p_rom =3D ctx->bios;
> +
> +     for (; start <=3D end; ++start) {
> +             for (str_off =3D 0; str_off < str_len; ++str_off) {
> +                     if (str[str_off] !=3D *(p_rom + start + str_off))
> +                             break;
> +             }
> +
> +             if (str_off =3D=3D str_len || str[str_off] =3D=3D 0)
> +                     return p_rom + start;
> +     }
> +     return NULL;
> +}
> +
> +static void atom_get_vbios_pn(struct atom_context *ctx) {
> +     unsigned char *p_rom;
> +     unsigned short off_to_vbios_str;
> +     unsigned char *vbios_str;
> +     int count;
> +
> +     off_to_vbios_str =3D 0;
> +     p_rom =3D ctx->bios;
> +
> +     if (*(p_rom + OFFSET_TO_GET_ATOMBIOS_NUMBER_OF_STRINGS) !=3D 0) {
> +             off_to_vbios_str =3D
> +                     *(unsigned short *)(p_rom + OFFSET_TO_GET_ATOMBIOS_=
STRING_START);
> +
> +             vbios_str =3D (unsigned char *)(p_rom + off_to_vbios_str);
> +     } else {
> +             vbios_str =3D p_rom + OFFSET_TO_VBIOS_PART_NUMBER;
> +     }
> +
> +     if (*vbios_str =3D=3D 0) {
> +             vbios_str =3D atom_find_str_in_rom(ctx, BIOS_ATOM_PREFIX, 3=
, 1024, 64);
> +             if (vbios_str =3D=3D NULL)
> +                     vbios_str +=3D sizeof(BIOS_ATOM_PREFIX) - 1;
> +     }
> +     if (vbios_str !=3D NULL && *vbios_str =3D=3D 0)
> +             vbios_str++;
> +
> +     if (vbios_str !=3D NULL) {
> +             count =3D 0;
> +             while ((count < BIOS_STRING_LENGTH) && vbios_str[count] >=
=3D ' ' &&
> +                    vbios_str[count] <=3D 'z') {
> +                     ctx->vbios_pn[count] =3D vbios_str[count];
> +                     count++;
> +             }
> +
> +             ctx->vbios_pn[count] =3D 0;
> +     }
> +}
> +
> +static void atom_get_vbios_version(struct atom_context *ctx) {
> +     unsigned char *vbios_ver;
> +
> +     /* find anchor ATOMBIOSBK-AMD */
> +     vbios_ver =3D atom_find_str_in_rom(ctx, BIOS_VERSION_PREFIX, 3, 102=
4, 64);
> +     if (vbios_ver !=3D NULL) {
> +             /* skip ATOMBIOSBK-AMD VER */
> +             vbios_ver +=3D 18;
> +             memcpy(ctx->vbios_ver_str, vbios_ver, STRLEN_NORMAL);
> +     } else {
> +             ctx->vbios_ver_str[0] =3D '\0';
> +     }
> +}
> +
>   struct atom_context *amdgpu_atom_parse(struct card_info *card, void *bi=
os)  {
>        int base;
>        struct atom_context *ctx =3D
>            kzalloc(sizeof(struct atom_context), GFP_KERNEL);
>        char *str;
> +     struct _ATOM_ROM_HEADER *atom_rom_header;
> +     struct _ATOM_MASTER_DATA_TABLE *master_table;
> +     struct _ATOM_FIRMWARE_INFO *atom_fw_info;
>        u16 idx;
>
>        if (!ctx)
> @@ -1353,6 +1510,23 @@ struct atom_context *amdgpu_atom_parse(struct card=
_info *card, void *bios)
>                strlcpy(ctx->vbios_version, str, sizeof(ctx->vbios_version=
));
>        }
>
> +     atom_rom_header =3D (struct _ATOM_ROM_HEADER *)CSTR(base);
> +     ctx->sub_dev_id =3D atom_rom_header->usSubsystemVendorID;
> +     ctx->sub_ved_id =3D atom_rom_header->usSubsystemID;
> +     if (atom_rom_header->usMasterDataTableOffset !=3D 0) {
> +             master_table =3D (struct _ATOM_MASTER_DATA_TABLE *)
> +                             CSTR(atom_rom_header->usMasterDataTableOffs=
et);
> +             if (master_table->ListOfDataTables.FirmwareInfo !=3D 0) {
> +                     atom_fw_info =3D (struct _ATOM_FIRMWARE_INFO *)
> +                                     CSTR(master_table->ListOfDataTables=
.FirmwareInfo);
> +                     ctx->version =3D atom_fw_info->ulFirmwareRevision;
> +             }
> +     }
> +
> +     atom_get_vbios_name(ctx);
> +     atom_get_vbios_pn(ctx);
> +     atom_get_vbios_date(ctx);
> +     atom_get_vbios_version(ctx);
>
>        return ctx;
>   }
> diff --git a/drivers/gpu/drm/amd/amdgpu/atom.h
> b/drivers/gpu/drm/amd/amdgpu/atom.h
> index d279759cab47..6463ce6e756d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/atom.h
> +++ b/drivers/gpu/drm/amd/amdgpu/atom.h
> @@ -112,6 +112,10 @@ struct drm_device;
>   #define ATOM_IO_SYSIO               2
>   #define ATOM_IO_IIO         0x80
>
> +#define STRLEN_NORMAL                32
> +#define STRLEN_LONG          64
> +#define STRLEN_VERYLONG              254
> +
>   struct card_info {
>        struct drm_device *dev;
>        void (* reg_write)(struct card_info *, uint32_t, uint32_t);   /*  =
filled by driver */
> @@ -140,6 +144,14 @@ struct atom_context {
>        uint32_t *scratch;
>        int scratch_size_bytes;
>        char vbios_version[20];
> +
> +     uint8_t name[STRLEN_LONG];
> +     uint8_t vbios_pn[STRLEN_LONG];
> +     uint32_t version;
> +     uint8_t vbios_ver_str[STRLEN_NORMAL];
> +     uint8_t date[STRLEN_NORMAL];
> +     uint32_t sub_dev_id;
> +     uint32_t sub_ved_id;
>   };
>
>   extern int amdgpu_atom_debug;
> diff --git a/drivers/gpu/drm/amd/include/atomfirmware.h
> b/drivers/gpu/drm/amd/include/atomfirmware.h
> index 275468e4be60..28deecc2f990 100644
> --- a/drivers/gpu/drm/amd/include/atomfirmware.h
> +++ b/drivers/gpu/drm/amd/include/atomfirmware.h
> @@ -197,6 +197,9 @@ enum atom_dp_vs_preemph_def{
>     DP_VS_LEVEL0_PREEMPH_LEVEL3 =3D 0x18,
>   };
>
> +#define BIOS_ATOM_PREFIX   "ATOMBIOS"
> +#define BIOS_VERSION_PREFIX  "ATOMBIOSBK-AMD"
> +#define BIOS_STRING_LENGTH 43
>
>   /*
>   enum atom_string_def{
> @@ -215,6 +218,8 @@ enum atombios_image_offset{
>     MAXSIZE_OF_ATOMBIOS_ASIC_BUS_MEM_TYPE      =3D 20,  /*including the t=
erminator 0x0!*/
>     OFFSET_TO_GET_ATOMBIOS_NUMBER_OF_STRINGS   =3D 0x2f,
>     OFFSET_TO_GET_ATOMBIOS_STRING_START        =3D 0x6e,
> +  OFFSET_TO_VBIOS_PART_NUMBER                =3D 0x80,
> +  OFFSET_TO_VBIOS_DATE                       =3D 0x50,
>   };
>
>
> /*********************************************************************
> ******* diff --git a/include/uapi/drm/amdgpu_drm.h
> b/include/uapi/drm/amdgpu_drm.h index 9169df7fadee..e0f98ca9a755
> 100644
> --- a/include/uapi/drm/amdgpu_drm.h
> +++ b/include/uapi/drm/amdgpu_drm.h
> @@ -756,6 +756,8 @@ struct drm_amdgpu_cs_chunk_data {
>        #define AMDGPU_INFO_VBIOS_SIZE          0x1
>        /* Subquery id: Query vbios image */
>        #define AMDGPU_INFO_VBIOS_IMAGE         0x2
> +     /* Subquery id: Query vbios info */
> +     #define AMDGPU_INFO_VBIOS_INFO          0x3
>   /* Query UVD handles */
>   #define AMDGPU_INFO_NUM_HANDLES                     0x1C
>   /* Query sensor related information */ @@ -949,6 +951,20 @@ struct
> drm_amdgpu_info_firmware {
>        __u32 feature;
>   };
>
> +struct drm_amdgpu_info_vbios {
> +     __u8 name[64];
> +     __u32 dbdf;
> +     __u8 vbios_pn[64];
> +     __u32 version;
> +     __u8 vbios_ver_str[32];
> +     __u8 date[32];
> +     __u64 serial;
> +     __u32 dev_id;
> +     __u32 rev_id;
> +     __u32 sub_dev_id;
> +     __u32 sub_ved_id;
> +};
> +
>   #define AMDGPU_VRAM_TYPE_UNKNOWN 0
>   #define AMDGPU_VRAM_TYPE_GDDR1 1
>   #define AMDGPU_VRAM_TYPE_DDR2  2
> --
> 2.17.1

--_000_BYAPR12MB2840E231B64B432D709A3B59F42C9BYAPR12MB2840namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Arial;font-size:11pt;color:#0078D7;margin:5pt;" ali=
gn=3D"Left">
[AMD Official Use Only - Internal Distribution Only]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);">
The serial&nbsp;number is ASIC information, not VBIOS information, and it i=
s still available as a sysfs node... I don't think we should put it there.<=
/div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);">
Not sure what dbdf stands for.</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Gu, JiaWei (Will) &lt=
;JiaWei.Gu@amd.com&gt;<br>
<b>Sent:</b> Monday, May 17, 2021 7:11 PM<br>
<b>To:</b> Koenig, Christian &lt;Christian.Koenig@amd.com&gt;; amd-gfx@list=
s.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&gt;; Nieto, David M &lt=
;David.Nieto@amd.com&gt;; maraeo@gmail.com &lt;maraeo@gmail.com&gt;; Deuche=
r, Alexander &lt;Alexander.Deucher@amd.com&gt;<br>
<b>Cc:</b> Deng, Emily &lt;Emily.Deng@amd.com&gt;<br>
<b>Subject:</b> RE: [PATCH] drm/amdgpu: Add vbios info ioctl interface</fon=
t>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">[AMD Official Use Only - Internal Distribution Onl=
y]<br>
<br>
So I guess the dbdf is also needed to be removed?<br>
And how about serial?<br>
<br>
&gt; +struct drm_amdgpu_info_vbios {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; __u8 name[64];<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; __u32 dbdf; // do we need this?<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; __u8 vbios_pn[64];<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; __u32 version;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; __u8 vbios_ver_str[32];<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; __u8 date[32];<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; __u64 serial; // do we need this?<br>
&gt; +};<br>
<br>
Best regards,<br>
Jiawei<br>
<br>
-----Original Message-----<br>
From: Koenig, Christian &lt;Christian.Koenig@amd.com&gt; <br>
Sent: Monday, May 17, 2021 8:26 PM<br>
To: Gu, JiaWei (Will) &lt;JiaWei.Gu@amd.com&gt;; amd-gfx@lists.freedesktop.=
org; Nieto, David M &lt;David.Nieto@amd.com&gt;; maraeo@gmail.com; Deucher,=
 Alexander &lt;Alexander.Deucher@amd.com&gt;<br>
Cc: Deng, Emily &lt;Emily.Deng@amd.com&gt;<br>
Subject: Re: [PATCH] drm/amdgpu: Add vbios info ioctl interface<br>
<br>
I'm not very familiar with the technical background why we have the fields =
here once more.<br>
<br>
But of hand we should at least remove everything which is also available fr=
om the PCI information.<br>
<br>
E.g. dev_id, rev_id, sub_dev_id, sub_ved_id.<br>
<br>
Regards,<br>
Christian.<br>
<br>
Am 17.05.21 um 14:17 schrieb Gu, JiaWei (Will):<br>
&gt; [AMD Official Use Only - Internal Distribution Only]<br>
&gt;<br>
&gt; Hi all,<br>
&gt;<br>
&gt; Thanks Christian's suggestion.<br>
&gt; I reverted the previous patches and squash them into this single one.<=
br>
&gt;<br>
&gt; As this patch shows, the current uapi change looks like this:<br>
&gt;<br>
&gt; +struct drm_amdgpu_info_vbios {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; __u8 name[64];<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; __u32 dbdf;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; __u8 vbios_pn[64];<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; __u32 version;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; __u8 vbios_ver_str[32];<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; __u8 date[32];<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; __u64 serial;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; __u32 dev_id;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; __u32 rev_id;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; __u32 sub_dev_id;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; __u32 sub_ved_id;<br>
&gt; +};<br>
&gt;<br>
&gt; As we know there's some redundant info in this struct.<br>
&gt; Please feel free to give any comments or suggestion about what it shou=
ld &amp; shouldn't include.<br>
&gt;<br>
&gt; Best regards,<br>
&gt; Jiawei<br>
&gt;<br>
&gt; -----Original Message-----<br>
&gt; From: Jiawei Gu &lt;Jiawei.Gu@amd.com&gt;<br>
&gt; Sent: Monday, May 17, 2021 8:08 PM<br>
&gt; To: amd-gfx@lists.freedesktop.org; Koenig, Christian <br>
&gt; &lt;Christian.Koenig@amd.com&gt;; Nieto, David M &lt;David.Nieto@amd.c=
om&gt;; <br>
&gt; maraeo@gmail.com; Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;=
<br>
&gt; Cc: Deng, Emily &lt;Emily.Deng@amd.com&gt;; Gu, JiaWei (Will) <br>
&gt; &lt;JiaWei.Gu@amd.com&gt;<br>
&gt; Subject: [PATCH] drm/amdgpu: Add vbios info ioctl interface<br>
&gt;<br>
&gt; Add AMDGPU_INFO_VBIOS_INFO subquery id for detailed vbios info.<br>
&gt;<br>
&gt; Provides a way for the user application to get the VBIOS information w=
ithout having to parse the binary.<br>
&gt; It is useful for the user to be able to display in a simple way the VB=
IOS version in their system if they happen to encounter an issue.<br>
&gt;<br>
&gt; V2:<br>
&gt; Use numeric serial.<br>
&gt; Parse and expose vbios version string.<br>
&gt;<br>
&gt; Signed-off-by: Jiawei Gu &lt;Jiawei.Gu@amd.com&gt;<br>
&gt; Acked-by: Christian K=F6nig &lt;christian.koenig@amd.com&gt;<br>
&gt; ---<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c&nbsp;&nbsp;&nbsp; =
|&nbsp; 21 +++<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/atom.c&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 174 +++++++++++++++++++++<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/atom.h&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 12 ++<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/include/atomfirmware.h |&nbsp;&nbsp; 5=
 +<br>
&gt;&nbsp;&nbsp; include/uapi/drm/amdgpu_drm.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 16 ++<br>
&gt;&nbsp;&nbsp; 5 files changed, 228 insertions(+)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c <br>
&gt; b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c<br>
&gt; index 8d12e474745a..30e4fed3de22 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c<br>
&gt; @@ -861,6 +861,27 @@ int amdgpu_info_ioctl(struct drm_device *dev, voi=
d *data, struct drm_file *filp)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; min((size_t)size, (size_t)(bios_size =
- bios_offset)))<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; ? -EFAULT : 0;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; }<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; case AMDGPU_INFO_VBIOS_INFO: {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_amdgpu_info_=
vbios vbios_info =3D {};<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct atom_context *at=
om_context;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; atom_context =3D adev-&=
gt;mode_info.atom_context;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memcpy(vbios_info.name,=
 atom_context-&gt;name, sizeof(atom_context-&gt;name));<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vbios_info.dbdf =3D PCI=
_DEVID(adev-&gt;pdev-&gt;bus-&gt;number, adev-&gt;pdev-&gt;devfn);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memcpy(vbios_info.vbios=
_pn, atom_context-&gt;vbios_pn, sizeof(atom_context-&gt;vbios_pn));<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vbios_info.version =3D =
atom_context-&gt;version;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memcpy(vbios_info.vbios=
_ver_str, atom_context-&gt;vbios_ver_str,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sizeof(atom_context-&gt;vbios=
_ver_str));<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memcpy(vbios_info.date,=
 atom_context-&gt;date, sizeof(atom_context-&gt;date));<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vbios_info.serial =3D a=
dev-&gt;unique_id;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vbios_info.dev_id =3D a=
dev-&gt;pdev-&gt;device;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vbios_info.rev_id =3D a=
dev-&gt;pdev-&gt;revision;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vbios_info.sub_dev_id =
=3D atom_context-&gt;sub_dev_id;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vbios_info.sub_ved_id =
=3D atom_context-&gt;sub_ved_id;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return copy_to_user(out=
, &amp;vbios_info,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; min((size_t)size, sizeof(vbio=
s_info))) ? -EFAULT : 0;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; }<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; default:<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_DEB=
UG_KMS(&quot;Invalid request %d\n&quot;,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; info-&gt;vbios_info.type);<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/atom.c <br>
&gt; b/drivers/gpu/drm/amd/amdgpu/atom.c<br>
&gt; index 3dcb8b32f48b..542b2c2414e4 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/atom.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/atom.c<br>
&gt; @@ -31,6 +31,7 @@<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp; #define ATOM_DEBUG<br>
&gt;&nbsp;&nbsp; <br>
&gt; +#include &quot;atomfirmware.h&quot;<br>
&gt;&nbsp;&nbsp; #include &quot;atom.h&quot;<br>
&gt;&nbsp;&nbsp; #include &quot;atom-names.h&quot;<br>
&gt;&nbsp;&nbsp; #include &quot;atom-bits.h&quot;<br>
&gt; @@ -1299,12 +1300,168 @@ static void atom_index_iio(struct atom_contex=
t *ctx, int base)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; <br>
&gt; +static void atom_get_vbios_name(struct atom_context *ctx) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; unsigned char *p_rom;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; unsigned char str_num;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; unsigned short off_to_vbios_str;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; unsigned char *c_ptr;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; int name_size;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; int i;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; const char *na =3D &quot;--N/A--&quot;;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; char *back;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; p_rom =3D ctx-&gt;bios;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; str_num =3D *(p_rom + OFFSET_TO_GET_ATOMBIOS=
_NUMBER_OF_STRINGS);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (str_num !=3D 0) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; off_to_vbios_str =3D<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *(unsigned short *)(p_r=
om + OFFSET_TO_GET_ATOMBIOS_STRING_START);<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; c_ptr =3D (unsigned char *)(p_rom + off_to_vbios_str);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; /* do not know where to find name */<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; memcpy(ctx-&gt;name, na, 7);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; ctx-&gt;name[7] =3D 0;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; return;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; /*<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * skip the atombios strings, usually 4=
<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * 1st is P/N, 2nd is ASIC, 3rd is PCI =
type, 4th is Memory type<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; str_num; i++) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; while (*c_ptr !=3D 0)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; c_ptr++;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; c_ptr++;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; /* skip the following 2 chars: 0x0D 0x0A */<=
br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; c_ptr +=3D 2;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; name_size =3D strnlen(c_ptr, STRLEN_LONG - 1=
);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; memcpy(ctx-&gt;name, c_ptr, name_size);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; back =3D ctx-&gt;name + name_size;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; while ((*--back) =3D=3D ' ')<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; ;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; *(back + 1) =3D '\0';<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void atom_get_vbios_date(struct atom_context *ctx) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; unsigned char *p_rom;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; unsigned char *date_in_rom;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; p_rom =3D ctx-&gt;bios;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; date_in_rom =3D p_rom + OFFSET_TO_VBIOS_DATE=
;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; ctx-&gt;date[0] =3D '2';<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; ctx-&gt;date[1] =3D '0';<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; ctx-&gt;date[2] =3D date_in_rom[6];<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; ctx-&gt;date[3] =3D date_in_rom[7];<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; ctx-&gt;date[4] =3D '/';<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; ctx-&gt;date[5] =3D date_in_rom[0];<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; ctx-&gt;date[6] =3D date_in_rom[1];<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; ctx-&gt;date[7] =3D '/';<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; ctx-&gt;date[8] =3D date_in_rom[3];<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; ctx-&gt;date[9] =3D date_in_rom[4];<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; ctx-&gt;date[10] =3D ' ';<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; ctx-&gt;date[11] =3D date_in_rom[9];<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; ctx-&gt;date[12] =3D date_in_rom[10];<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; ctx-&gt;date[13] =3D date_in_rom[11];<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; ctx-&gt;date[14] =3D date_in_rom[12];<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; ctx-&gt;date[15] =3D date_in_rom[13];<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; ctx-&gt;date[16] =3D '\0';<br>
&gt; +}<br>
&gt; +<br>
&gt; +static unsigned char *atom_find_str_in_rom(struct atom_context *ctx, =
char *str, int start,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; int end, int maxlen)<br>
&gt; +{<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; unsigned long str_off;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; unsigned char *p_rom;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; unsigned short str_len;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; str_off =3D 0;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; str_len =3D strnlen(str, maxlen);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; p_rom =3D ctx-&gt;bios;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; for (; start &lt;=3D end; ++start) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; for (str_off =3D 0; str_off &lt; str_len; ++str_off) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (str[str_off] !=3D *=
(p_rom + start + str_off))<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; }<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (str_off =3D=3D str_len || str[str_off] =3D=3D 0)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return p_rom + start;<b=
r>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; return NULL;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void atom_get_vbios_pn(struct atom_context *ctx) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; unsigned char *p_rom;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; unsigned short off_to_vbios_str;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; unsigned char *vbios_str;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; int count;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; off_to_vbios_str =3D 0;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; p_rom =3D ctx-&gt;bios;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (*(p_rom + OFFSET_TO_GET_ATOMBIOS_NUMBER_=
OF_STRINGS) !=3D 0) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; off_to_vbios_str =3D<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *(unsigned short *)(p_r=
om + OFFSET_TO_GET_ATOMBIOS_STRING_START);<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; vbios_str =3D (unsigned char *)(p_rom + off_to_vbios_str);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; vbios_str =3D p_rom + OFFSET_TO_VBIOS_PART_NUMBER;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (*vbios_str =3D=3D 0) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; vbios_str =3D atom_find_str_in_rom(ctx, BIOS_ATOM_PREFIX, 3, 1024, 64);=
<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (vbios_str =3D=3D NULL)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vbios_str +=3D sizeof(B=
IOS_ATOM_PREFIX) - 1;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (vbios_str !=3D NULL &amp;&amp; *vbios_st=
r =3D=3D 0)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; vbios_str++;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (vbios_str !=3D NULL) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; count =3D 0;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; while ((count &lt; BIOS_STRING_LENGTH) &amp;&amp; vbios_str[count] &gt;=
=3D ' ' &amp;&amp;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vbios_str[count] &lt;=3D 'z')=
 {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ctx-&gt;vbios_pn[count]=
 =3D vbios_str[count];<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; count++;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; }<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; ctx-&gt;vbios_pn[count] =3D 0;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void atom_get_vbios_version(struct atom_context *ctx) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; unsigned char *vbios_ver;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; /* find anchor ATOMBIOSBK-AMD */<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; vbios_ver =3D atom_find_str_in_rom(ctx, BIOS=
_VERSION_PREFIX, 3, 1024, 64);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (vbios_ver !=3D NULL) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; /* skip ATOMBIOSBK-AMD VER */<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; vbios_ver +=3D 18;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; memcpy(ctx-&gt;vbios_ver_str, vbios_ver, STRLEN_NORMAL);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; ctx-&gt;vbios_ver_str[0] =3D '\0';<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; +}<br>
&gt; +<br>
&gt;&nbsp;&nbsp; struct atom_context *amdgpu_atom_parse(struct card_info *c=
ard, void *bios)&nbsp; {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int base;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct atom_context *ctx =3D=
<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kzal=
loc(sizeof(struct atom_context), GFP_KERNEL);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; char *str;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; struct _ATOM_ROM_HEADER *atom_rom_header;<br=
>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; struct _ATOM_MASTER_DATA_TABLE *master_table=
;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; struct _ATOM_FIRMWARE_INFO *atom_fw_info;<br=
>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u16 idx;<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!ctx)<br>
&gt; @@ -1353,6 +1510,23 @@ struct atom_context *amdgpu_atom_parse(struct c=
ard_info *card, void *bios)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; strlcpy(ctx-&gt;vbios_version, str, sizeof(ctx-&gt;vbio=
s_version));<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; <br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; atom_rom_header =3D (struct _ATOM_ROM_HEADER=
 *)CSTR(base);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; ctx-&gt;sub_dev_id =3D atom_rom_header-&gt;u=
sSubsystemVendorID;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; ctx-&gt;sub_ved_id =3D atom_rom_header-&gt;u=
sSubsystemID;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (atom_rom_header-&gt;usMasterDataTableOff=
set !=3D 0) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; master_table =3D (struct _ATOM_MASTER_DATA_TABLE *)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; CSTR(atom_rom_header-&gt;usMasterDataTableOffset);=
<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (master_table-&gt;ListOfDataTables.FirmwareInfo !=3D 0) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; atom_fw_info =3D (struc=
t _ATOM_FIRMWARE_INFO *)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CS=
TR(master_table-&gt;ListOfDataTables.FirmwareInfo);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ctx-&gt;version =3D ato=
m_fw_info-&gt;ulFirmwareRevision;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; }<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; atom_get_vbios_name(ctx);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; atom_get_vbios_pn(ctx);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; atom_get_vbios_date(ctx);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; atom_get_vbios_version(ctx);<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ctx;<br>
&gt;&nbsp;&nbsp; }<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/atom.h <br>
&gt; b/drivers/gpu/drm/amd/amdgpu/atom.h<br>
&gt; index d279759cab47..6463ce6e756d 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/atom.h<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/atom.h<br>
&gt; @@ -112,6 +112,10 @@ struct drm_device;<br>
&gt;&nbsp;&nbsp; #define ATOM_IO_SYSIO&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2<br>
&gt;&nbsp;&nbsp; #define ATOM_IO_IIO&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; 0x80<br>
&gt;&nbsp;&nbsp; <br>
&gt; +#define STRLEN_NORMAL&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 32<br>
&gt; +#define STRLEN_LONG&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; 64<br>
&gt; +#define STRLEN_VERYLONG&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 254<br>
&gt; +<br>
&gt;&nbsp;&nbsp; struct card_info {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_device *dev;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void (* reg_write)(struct ca=
rd_info *, uint32_t, uint32_t);&nbsp;&nbsp; /*&nbsp; filled by driver */<br=
>
&gt; @@ -140,6 +144,14 @@ struct atom_context {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t *scratch;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int scratch_size_bytes;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; char vbios_version[20];<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; uint8_t name[STRLEN_LONG];<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; uint8_t vbios_pn[STRLEN_LONG];<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; uint32_t version;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; uint8_t vbios_ver_str[STRLEN_NORMAL];<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; uint8_t date[STRLEN_NORMAL];<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; uint32_t sub_dev_id;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; uint32_t sub_ved_id;<br>
&gt;&nbsp;&nbsp; };<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp; extern int amdgpu_atom_debug;<br>
&gt; diff --git a/drivers/gpu/drm/amd/include/atomfirmware.h <br>
&gt; b/drivers/gpu/drm/amd/include/atomfirmware.h<br>
&gt; index 275468e4be60..28deecc2f990 100644<br>
&gt; --- a/drivers/gpu/drm/amd/include/atomfirmware.h<br>
&gt; +++ b/drivers/gpu/drm/amd/include/atomfirmware.h<br>
&gt; @@ -197,6 +197,9 @@ enum atom_dp_vs_preemph_def{<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; DP_VS_LEVEL0_PREEMPH_LEVEL3 =3D 0x18,<br>
&gt;&nbsp;&nbsp; };<br>
&gt;&nbsp;&nbsp; <br>
&gt; +#define BIOS_ATOM_PREFIX&nbsp;&nbsp; &quot;ATOMBIOS&quot;<br>
&gt; +#define BIOS_VERSION_PREFIX&nbsp; &quot;ATOMBIOSBK-AMD&quot;<br>
&gt; +#define BIOS_STRING_LENGTH 43<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp; /*<br>
&gt;&nbsp;&nbsp; enum atom_string_def{<br>
&gt; @@ -215,6 +218,8 @@ enum atombios_image_offset{<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; MAXSIZE_OF_ATOMBIOS_ASIC_BUS_MEM_TYPE&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; =3D 20,&nbsp; /*including the terminator 0x0!*/<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; OFFSET_TO_GET_ATOMBIOS_NUMBER_OF_STRINGS&nbsp;=
&nbsp; =3D 0x2f,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; OFFSET_TO_GET_ATOMBIOS_STRING_START&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 0x6e,<br>
&gt; +&nbsp; OFFSET_TO_VBIOS_PART_NUMBER&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 0x80,<br>
&gt; +&nbsp; OFFSET_TO_VBIOS_DATE&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; =3D 0x50,<br>
&gt;&nbsp;&nbsp; };<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp; <br>
&gt; /*********************************************************************=
<br>
&gt; ******* diff --git a/include/uapi/drm/amdgpu_drm.h <br>
&gt; b/include/uapi/drm/amdgpu_drm.h index 9169df7fadee..e0f98ca9a755 <br>
&gt; 100644<br>
&gt; --- a/include/uapi/drm/amdgpu_drm.h<br>
&gt; +++ b/include/uapi/drm/amdgpu_drm.h<br>
&gt; @@ -756,6 +756,8 @@ struct drm_amdgpu_cs_chunk_data {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #define AMDGPU_INFO_VBIOS_SI=
ZE&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x1<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Subquery id: Query vbios =
image */<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #define AMDGPU_INFO_VBIOS_IM=
AGE&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x2<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; /* Subquery id: Query vbios info */<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; #define AMDGPU_INFO_VBIOS_INFO&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x3<br>
&gt;&nbsp;&nbsp; /* Query UVD handles */<br>
&gt;&nbsp;&nbsp; #define AMDGPU_INFO_NUM_HANDLES&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; 0x1C<br>
&gt;&nbsp;&nbsp; /* Query sensor related information */ @@ -949,6 +951,20 @=
@ struct <br>
&gt; drm_amdgpu_info_firmware {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __u32 feature;<br>
&gt;&nbsp;&nbsp; };<br>
&gt;&nbsp;&nbsp; <br>
&gt; +struct drm_amdgpu_info_vbios {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; __u8 name[64];<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; __u32 dbdf;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; __u8 vbios_pn[64];<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; __u32 version;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; __u8 vbios_ver_str[32];<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; __u8 date[32];<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; __u64 serial;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; __u32 dev_id;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; __u32 rev_id;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; __u32 sub_dev_id;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; __u32 sub_ved_id;<br>
&gt; +};<br>
&gt; +<br>
&gt;&nbsp;&nbsp; #define AMDGPU_VRAM_TYPE_UNKNOWN 0<br>
&gt;&nbsp;&nbsp; #define AMDGPU_VRAM_TYPE_GDDR1 1<br>
&gt;&nbsp;&nbsp; #define AMDGPU_VRAM_TYPE_DDR2&nbsp; 2<br>
&gt; --<br>
&gt; 2.17.1<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BYAPR12MB2840E231B64B432D709A3B59F42C9BYAPR12MB2840namp_--

--===============1888821419==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1888821419==--
