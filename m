Return-Path: <SRS0=4Mkx=LD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DAC5C48BCF
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Jun 2021 10:48:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7F5661059
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Jun 2021 10:48:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7F5661059
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 80D886E5AB;
	Wed,  9 Jun 2021 10:48:56 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2054.outbound.protection.outlook.com [40.107.94.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A835A6E56A
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Jun 2021 10:48:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RUttnZ2AakRQ1qlDz3JhAryU4vmGbni0g44JmZ5kz6FnJzKFQgOuuP4xQf4jP4D4wiUXKMvdaqF5PwlSFyLgs9or4q5wrUhvKWetZfnu+DR6uTEsaV4LUZIbxmvBM0/gvTK/a3ROuxe+nE+B6eF459kP9G2sQndL+WY+uQ1mWlHp2E1W8v2Vexa73F4gYnHXX05Vwezyq0xrU9XpXYsZ+srdKw7Zcm2PexIREf6JaM3apr2NBLVtvMsOKMDVB+k/OTMOIJVFsITx/hE1y92vBlsVmc1PA9Trdv6f2OxziyfS+9WNwpdWz73NVy8vXMFGrroSiJKUfTer0ZRz65g4Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pTUtrv0XawF+LRd3/RCZ4/N5GI3U7KTn7nRv/dmSnhI=;
 b=auW9HeUU8HH3SlfQyW3iaP5OS7ih1e4lAv7M2i+omGqUrRRqOEDbESIh8BTVE1vdO3PFIwdJWdcwkY8eC7V+mGrR3W2Y9TFrngVXj5tPCvY/P2ZGqWJspG2QWp81nK0UewUWEB2Se0b9XNJGSX3h3g1mVrV2wh1HbhR5c8dQNJmIMHAvYqgNHzdMzRQnMNP6Rwy2BH8zTpG0zR+MO0nYmmFJfkhmz50fDcRG2dEQHNnBn8JyXLBWoQ2EaLgnoFCHi1CZF03LyXVN8PesOaI2yCU+yXTv+ZcxtPCFiAxEGqz34QqSE0wqKDaQs9gnTlogQ47F5b73/EOGpZ3Msd0Jyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pTUtrv0XawF+LRd3/RCZ4/N5GI3U7KTn7nRv/dmSnhI=;
 b=LGREapTs4cxMUO/udrvVMwkzOwIQXJU1yt/UYeRAYQUya77FsO3WcKT0RYxre5fhdrNj/37wuuXP2VJr49UCJYQxR1kC8DyNlbHhmGuU+5spnpuRyvUVwPH/v15AWPwtXqKG+lLeEz1ST8loypO/OkIUFTZVG01L7i9MRyzo7ik=
Received: from DM5PR12MB2517.namprd12.prod.outlook.com (2603:10b6:4:bb::13) by
 DM6PR12MB3785.namprd12.prod.outlook.com (2603:10b6:5:1cd::18) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4195.23; Wed, 9 Jun 2021 10:48:52 +0000
Received: from DM5PR12MB2517.namprd12.prod.outlook.com
 ([fe80::8d83:baf6:c6c6:9ac3]) by DM5PR12MB2517.namprd12.prod.outlook.com
 ([fe80::8d83:baf6:c6c6:9ac3%3]) with mapi id 15.20.4195.024; Wed, 9 Jun 2021
 10:48:52 +0000
From: "Zhu, James" <James.Zhu@amd.com>
To: =?iso-8859-1?Q?Christian_K=F6nig?= <ckoenig.leichtzumerken@gmail.com>,
 "Zhang, Boyuan" <Boyuan.Zhang@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu/vcn: drop gfxoff control for VCN2+
Thread-Topic: [PATCH] drm/amdgpu/vcn: drop gfxoff control for VCN2+
Thread-Index: AQHXW9vJewbkYgfsVE23TSd01p5zC6sJEXGAgAClEYCAAcu0Yw==
Date: Wed, 9 Jun 2021 10:48:52 +0000
Message-ID: <DM5PR12MB2517BB49EBDF4C52FDF16EA7E4369@DM5PR12MB2517.namprd12.prod.outlook.com>
References: <20210607202841.2120465-1-alexander.deucher@amd.com>
 <DM6PR12MB4843FC5C5BF8086C627A0BC887389@DM6PR12MB4843.namprd12.prod.outlook.com>,
 <558a24e0-3057-873b-e7fe-261975f9dc40@gmail.com>
In-Reply-To: <558a24e0-3057-873b-e7fe-261975f9dc40@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=True;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-06-09T10:48:51.119Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD-Official
 Use
 Only; MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard; 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [209.141.175.84]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bf2e35a4-2563-44d6-38da-08d92b342be8
x-ms-traffictypediagnostic: DM6PR12MB3785:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB378570365FEF3B9FB850E9A3E4369@DM6PR12MB3785.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OlE2ysCj1oHEzRTe0OLrwUIrOJMI/JZWdQwjLgqG/6S50sJKK/LkHNQ6c7jnsVb1GzZCkt+UIJx2+PzncrI/kRTte8pY64yTGNHL4cmtwQkMonmIKKlANuISGr1suu+krSB34MiBMlzESftSwha4CWPjegOoKIL9fAG4Le7cS3yFSQug2KD/1ui3VAxvXXK44qPxm5PrJl66651BYwN+23G4S3AsOs5WKot9YlZ6qbd4q6htlnGc0pvREtKKY2HK6OCw9oeo4pSsUskayn5eEpQzaAZwpn5OppRle9vsnPqJgpV4HKAqY9YNHYsCe79sYfvYHc4MsoEui3fks3C6TioDIWnOB5f9ujV8q4MjcpwZbctULdb97yMR9SsoDClHkJlFYpR/BF5HMk/6Pw3JqejO0OTrUwofywVLQleDXrUb6/159GlUPJmbSnnpejNIEL7A9s5Ofapoh2cEHMChczdQxn4CT3QmtrAnGWUJjRFWi1RbRGasKrrXBsuFOiBPT1Lpe8dwSKIJfN/NaQP6f3gOo5a6RUfLXN8eRqCQHS065DQ0OeGTqnETnT5ksrd0AzUlD2ipDohRJUVqoi6aF2u1StrrTuYz9ZjbAHXWFnNEpiNy1DaSCKBWTis7OmK2JaQzHLHCrXGnuI1ckQY/SA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2517.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(366004)(136003)(396003)(376002)(346002)(76116006)(8936002)(86362001)(91956017)(478600001)(45080400002)(66556008)(966005)(52536014)(66446008)(316002)(122000001)(55016002)(2906002)(7696005)(9686003)(186003)(110136005)(166002)(26005)(66946007)(66476007)(33656002)(5660300002)(83380400001)(19627405001)(64756008)(6506007)(8676002)(71200400001)(66574015)(53546011)(38100700002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?XX6YXVhhNIvhGezRuFVxg95NnpILm9JeuVVuXvPjuKYoop+7AXABBnDvEH?=
 =?iso-8859-1?Q?w8OHKFHNTsMkpQ/wijfu5O6U73EfCNw5lU/1rzAHWu0KdaWTY233OKbviP?=
 =?iso-8859-1?Q?nKMS6Q0tVL1rREUVTX5XK/w6YAHW+Fp+0CAALX3zGsZU7EiB8ScWW1GopG?=
 =?iso-8859-1?Q?EaQa5chh0A09RNRRYAqUtmYwETL7+BJVJiXzfXKh8FivgDCVPiN93bQf4R?=
 =?iso-8859-1?Q?P971wJnQDSJ+RCumCRnMo578YnpLhw6zwTT3xvqpm3gKIkNzirNDpNo6+v?=
 =?iso-8859-1?Q?Xg770lr0R0MU5oZQA+n3pYFaQixz2bxHMeDyCsogEuAsqUoaIpoasPNIAo?=
 =?iso-8859-1?Q?aVa4ev0GBdGt39nxdiUtran0cMMQ2xVjmref8WtEEgJ9vgaVhZLyEm32aa?=
 =?iso-8859-1?Q?v+JQnVMMZmj3kJ+attoIB95pzpB/sYgg3+r5eupXSCxe+8t8SYr3SQr60L?=
 =?iso-8859-1?Q?xKK6ARiR6AbB7KqC7rMj9UjjMKsjazTVx3+IvDi5TsUPc6yPo+mm6lFkWX?=
 =?iso-8859-1?Q?IwK4dBUtoNuBUM+JEL4h8miT1agGBdkBaoSxyRrJXnX7iD4R31qLhJJaBo?=
 =?iso-8859-1?Q?/f+YqoV32JbSagoozBufZy1n7niZdl/lYHaad3zhQ+D8csrLrHCbK7Uizo?=
 =?iso-8859-1?Q?BVkCk0AwI2nN0dzgYBFa1yLkMIwCWlv471s0RP8tswKp9R2eL1uWxZGHbn?=
 =?iso-8859-1?Q?Pr/N4K7kWKNPg2gU3FhNHPK5OREzhkM984kLDXxR0S+FiPTQPEQGSQTKRz?=
 =?iso-8859-1?Q?xxkAO+o5PDJl47YC9EfSKN6AM4q6QYXsrQsi4OgtKl8g4LpXB6BmxAMl2L?=
 =?iso-8859-1?Q?jO9tZ7r+9RrojW0Z7dg8LoBZ97K3E5cUjSu3ImwEZ58YftYiMIfmXKwavg?=
 =?iso-8859-1?Q?LcZ83fqzK5bwUk+9V+x0OnYRfc37DpG0MbYvF5Y1snpsfML+wDnOYoKEdt?=
 =?iso-8859-1?Q?pC5HOWE5gkg1dIu+ZQ+EqTvN0E7oDlew5FFjHMJnj86STP4wazX4SZb7cj?=
 =?iso-8859-1?Q?tKGP9p7xA8h1fqBXupjMBOIQocTIDyXsTkxX+R7AGPwEmqvAYzY7eEJcnS?=
 =?iso-8859-1?Q?RWFeww2Sfg4oHVPIGiqvd7L/NMgoisI7X0v6yTeZCzJwZjm1UIebLFWV0K?=
 =?iso-8859-1?Q?C9NXQqcgGOJLtsmsZaMFnq+aEbkc8M9J+U+r280xFN8h6LyD8wWM8Rdy1M?=
 =?iso-8859-1?Q?23ldgnO1x7kRfMWeprM9/q4P5xXs7rc5Xe9J+JXfK6IaiZgSW4XTeQiuBO?=
 =?iso-8859-1?Q?CgGcuxXwD+i29cabdp3QF0ZT/VybftXSRfxTrgpxyhwWd1mdm+A8XSQ//A?=
 =?iso-8859-1?Q?Zl0eTzCoS6yMBQEG8na/cKbpfRqtkKdUU3diQeR9V/QoA5/sq7f1EbNSw2?=
 =?iso-8859-1?Q?dhWHcIAo+O?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2517.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf2e35a4-2563-44d6-38da-08d92b342be8
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jun 2021 10:48:52.2649 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jxXTX59/LUPs1MEpijq4C4xDSSRsUrmxoRrrL61ncZAwnBUfGTZvu51DZaAbvdkg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3785
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
Content-Type: multipart/mixed; boundary="===============1221432019=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1221432019==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_DM5PR12MB2517BB49EBDF4C52FDF16EA7E4369DM5PR12MB2517namp_"

--_000_DM5PR12MB2517BB49EBDF4C52FDF16EA7E4369DM5PR12MB2517namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only]

Reviewed-by: James Zhu <James.Zhu@amd.com>


Thanks & Best Regards!


James Zhu

________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Christia=
n K=F6nig <ckoenig.leichtzumerken@gmail.com>
Sent: Tuesday, June 8, 2021 3:23 AM
To: Zhang, Boyuan <Boyuan.Zhang@amd.com>; Deucher, Alexander <Alexander.Deu=
cher@amd.com>; amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org=
>
Subject: Re: [PATCH] drm/amdgpu/vcn: drop gfxoff control for VCN2+

Acked-by: Christian K=F6nig <christian.koenig@amd.com>

Am 07.06.21 um 23:32 schrieb Zhang, Boyuan:
> [AMD Official Use Only]
>
> Patch is
> Reviewed-by: Boyuan Zhang <Boyuan.Zhang@amd.com>
>
> Thanks,
> Boyuan
>
> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex D=
eucher
> Sent: June 7, 2021 4:29 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
> Subject: [PATCH] drm/amdgpu/vcn: drop gfxoff control for VCN2+
>
> Drop disabling of gfxoff during VCN use.  This allows gfxoff to kick in a=
nd potentially save power if the user is not using gfx for color space conv=
ersion or scaling.
>
> VCN1.0 had a bug which prevented it from working properly with gfxoff, so=
 we disabled it while using VCN.  That said, most apps today use gfx for sc=
aling and color space conversion rather than overlay planes so it was gener=
ally in use anyway. This was fixed on VCN2+, but since we mostly use gfx fo=
r color space conversion and scaling and rapidly powering up/down gfx can n=
egate the advantages of gfxoff, we left gfxoff disabled. As more applicatio=
ns use overlay planes for color space conversion and scaling, this starts t=
o be a win, so go ahead and leave gfxoff enabled.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 2 --
>   1 file changed, 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_vcn.c
> index 1dc11dbd62b7..647d2c31e8bd 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> @@ -393,7 +393,6 @@ static void amdgpu_vcn_idle_work_handler(struct work_=
struct *work)
>          }
>
>          if (!fences && !atomic_read(&adev->vcn.total_submission_cnt)) {
> -               amdgpu_gfx_off_ctrl(adev, true);
>                  amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOC=
K_TYPE_VCN,
>                         AMD_PG_STATE_GATE);
>                  r =3D amdgpu_dpm_switch_power_profile(adev, PP_SMC_POWER=
_PROFILE_VIDEO, @@ -413,7 +412,6 @@ void amdgpu_vcn_ring_begin_use(struct a=
mdgpu_ring *ring)
>          atomic_inc(&adev->vcn.total_submission_cnt);
>
>          if (!cancel_delayed_work_sync(&adev->vcn.idle_work)) {
> -               amdgpu_gfx_off_ctrl(adev, false);
>                  r =3D amdgpu_dpm_switch_power_profile(adev, PP_SMC_POWER=
_PROFILE_VIDEO,
>                                  true);
>                  if (r)
> --
> 2.31.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists=
.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D04%7C01%7Cjames.=
zhu%40amd.com%7Ccf628d25d7704545c4a108d92a4e428c%7C3dd8961fe4884e608e11a82d=
994e183d%7C0%7C0%7C637587337878810926%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wL=
jAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3DhN=
8cuKAmvSK8b2%2B3uhT%2Fb6I6QnKlhIhZkjO6XeD6%2Bgg%3D&amp;reserved=3D0
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists=
.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D04%7C01%7Cjames.=
zhu%40amd.com%7Ccf628d25d7704545c4a108d92a4e428c%7C3dd8961fe4884e608e11a82d=
994e183d%7C0%7C0%7C637587337878810926%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wL=
jAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3DhN=
8cuKAmvSK8b2%2B3uhT%2Fb6I6QnKlhIhZkjO6XeD6%2Bgg%3D&amp;reserved=3D0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D04%7C01%7Cjames.zh=
u%40amd.com%7Ccf628d25d7704545c4a108d92a4e428c%7C3dd8961fe4884e608e11a82d99=
4e183d%7C0%7C0%7C637587337878810926%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjA=
wMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3DhN8c=
uKAmvSK8b2%2B3uhT%2Fb6I6QnKlhIhZkjO6XeD6%2Bgg%3D&amp;reserved=3D0

--_000_DM5PR12MB2517BB49EBDF4C52FDF16EA7E4369DM5PR12MB2517namp_
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
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:15pt;" al=
ign=3D"Left">
[AMD Official Use Only]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<font size=3D"2"><span style=3D"font-size:11pt"><font size=3D"2"><span styl=
e=3D"font-size:11pt">Reviewed-by:
</span></font>James Zhu &lt;James.Zhu@amd.com&gt;</span></font><br>
</div>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div id=3D"Signature">
<div>
<div id=3D"divtagdefaultwrapper" dir=3D"ltr" style=3D"font-size:12pt; color=
:#000000; font-family:Calibri,Arial,Helvetica,sans-serif">
<p style=3D"margin-top: 0px; margin-bottom: 0px;">Thanks &amp; Best Regards=
!</p>
<p style=3D"margin-top: 0px; margin-bottom: 0px;"><br>
</p>
<p style=3D"margin-top: 0px; margin-bottom: 0px;">James Zhu<br>
</p>
</div>
</div>
</div>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Christian K=F6nig &lt;ckoenig=
.leichtzumerken@gmail.com&gt;<br>
<b>Sent:</b> Tuesday, June 8, 2021 3:23 AM<br>
<b>To:</b> Zhang, Boyuan &lt;Boyuan.Zhang@amd.com&gt;; Deucher, Alexander &=
lt;Alexander.Deucher@amd.com&gt;; amd-gfx@lists.freedesktop.org &lt;amd-gfx=
@lists.freedesktop.org&gt;<br>
<b>Subject:</b> Re: [PATCH] drm/amdgpu/vcn: drop gfxoff control for VCN2+</=
font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Acked-by: Christian K=F6nig &lt;christian.koenig@a=
md.com&gt;<br>
<br>
Am 07.06.21 um 23:32 schrieb Zhang, Boyuan:<br>
&gt; [AMD Official Use Only]<br>
&gt;<br>
&gt; Patch is<br>
&gt; Reviewed-by: Boyuan Zhang &lt;Boyuan.Zhang@amd.com&gt;<br>
&gt;<br>
&gt; Thanks,<br>
&gt; Boyuan<br>
&gt;<br>
&gt; -----Original Message-----<br>
&gt; From: amd-gfx &lt;amd-gfx-bounces@lists.freedesktop.org&gt; On Behalf =
Of Alex Deucher<br>
&gt; Sent: June 7, 2021 4:29 PM<br>
&gt; To: amd-gfx@lists.freedesktop.org<br>
&gt; Cc: Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;<br>
&gt; Subject: [PATCH] drm/amdgpu/vcn: drop gfxoff control for VCN2+<br>
&gt;<br>
&gt; Drop disabling of gfxoff during VCN use.&nbsp; This allows gfxoff to k=
ick in and potentially save power if the user is not using gfx for color sp=
ace conversion or scaling.<br>
&gt;<br>
&gt; VCN1.0 had a bug which prevented it from working properly with gfxoff,=
 so we disabled it while using VCN.&nbsp; That said, most apps today use gf=
x for scaling and color space conversion rather than overlay planes so it w=
as generally in use anyway. This was fixed
 on VCN2+, but since we mostly use gfx for color space conversion and scali=
ng and rapidly powering up/down gfx can negate the advantages of gfxoff, we=
 left gfxoff disabled. As more applications use overlay planes for color sp=
ace conversion and scaling, this
 starts to be a win, so go ahead and leave gfxoff enabled.<br>
&gt;<br>
&gt; Signed-off-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
&gt; ---<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 2 --<br>
&gt;&nbsp;&nbsp; 1 file changed, 2 deletions(-)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_vcn.c<br>
&gt; index 1dc11dbd62b7..647d2c31e8bd 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c<br>
&gt; @@ -393,7 +393,6 @@ static void amdgpu_vcn_idle_work_handler(struct wo=
rk_struct *work)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!fences &amp=
;&amp; !atomic_read(&amp;adev-&gt;vcn.total_submission_cnt)) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; amdgpu_gfx_off_ctrl(adev, true);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_device_ip_set_powergating_state(adev=
, AMD_IP_BLOCK_TYPE_VCN,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; A=
MD_PG_STATE_GATE);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_dpm_switch_power_profile(adev,=
 PP_SMC_POWER_PROFILE_VIDEO, @@ -413,7 +412,6 @@ void amdgpu_vcn_ring_begin=
_use(struct amdgpu_ring *ring)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; atomic_inc(&amp;=
adev-&gt;vcn.total_submission_cnt);<br>
&gt;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!cancel_dela=
yed_work_sync(&amp;adev-&gt;vcn.idle_work)) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; amdgpu_gfx_off_ctrl(adev, false);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_dpm_switch_power_profile(adev,=
 PP_SMC_POWER_PROFILE_VIDEO,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; true);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
&gt; --<br>
&gt; 2.31.1<br>
&gt;<br>
&gt; _______________________________________________<br>
&gt; amd-gfx mailing list<br>
&gt; amd-gfx@lists.freedesktop.org<br>
&gt; <a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps=
%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=
=3D04%7C01%7Cjames.zhu%40amd.com%7Ccf628d25d7704545c4a108d92a4e428c%7C3dd89=
61fe4884e608e11a82d994e183d%7C0%7C0%7C637587337878810926%7CUnknown%7CTWFpbG=
Zsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C=
1000&amp;amp;sdata=3DhN8cuKAmvSK8b2%2B3uhT%2Fb6I6QnKlhIhZkjO6XeD6%2Bgg%3D&a=
mp;amp;reserved=3D0">
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D04%7C01%7Cjame=
s.zhu%40amd.com%7Ccf628d25d7704545c4a108d92a4e428c%7C3dd8961fe4884e608e11a8=
2d994e183d%7C0%7C0%7C637587337878810926%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4=
wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;amp;sdat=
a=3DhN8cuKAmvSK8b2%2B3uhT%2Fb6I6QnKlhIhZkjO6XeD6%2Bgg%3D&amp;amp;reserved=
=3D0</a><br>
&gt; _______________________________________________<br>
&gt; amd-gfx mailing list<br>
&gt; amd-gfx@lists.freedesktop.org<br>
&gt; <a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps=
%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=
=3D04%7C01%7Cjames.zhu%40amd.com%7Ccf628d25d7704545c4a108d92a4e428c%7C3dd89=
61fe4884e608e11a82d994e183d%7C0%7C0%7C637587337878810926%7CUnknown%7CTWFpbG=
Zsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C=
1000&amp;amp;sdata=3DhN8cuKAmvSK8b2%2B3uhT%2Fb6I6QnKlhIhZkjO6XeD6%2Bgg%3D&a=
mp;amp;reserved=3D0">
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D04%7C01%7Cjame=
s.zhu%40amd.com%7Ccf628d25d7704545c4a108d92a4e428c%7C3dd8961fe4884e608e11a8=
2d994e183d%7C0%7C0%7C637587337878810926%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4=
wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;amp;sdat=
a=3DhN8cuKAmvSK8b2%2B3uhT%2Fb6I6QnKlhIhZkjO6XeD6%2Bgg%3D&amp;amp;reserved=
=3D0</a><br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx@lists.freedesktop.org<br>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D04%=
7C01%7Cjames.zhu%40amd.com%7Ccf628d25d7704545c4a108d92a4e428c%7C3dd8961fe48=
84e608e11a82d994e183d%7C0%7C0%7C637587337878810926%7CUnknown%7CTWFpbGZsb3d8=
eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&a=
mp;amp;sdata=3DhN8cuKAmvSK8b2%2B3uhT%2Fb6I6QnKlhIhZkjO6XeD6%2Bgg%3D&amp;amp=
;reserved=3D0">https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%=
3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=
=3D04%7C01%7Cjames.zhu%40amd.com%7Ccf628d25d7704545c4a108d92a4e428c%7C3dd89=
61fe4884e608e11a82d994e183d%7C0%7C0%7C637587337878810926%7CUnknown%7CTWFpbG=
Zsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C=
1000&amp;amp;sdata=3DhN8cuKAmvSK8b2%2B3uhT%2Fb6I6QnKlhIhZkjO6XeD6%2Bgg%3D&a=
mp;amp;reserved=3D0</a><br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_DM5PR12MB2517BB49EBDF4C52FDF16EA7E4369DM5PR12MB2517namp_--

--===============1221432019==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1221432019==--
