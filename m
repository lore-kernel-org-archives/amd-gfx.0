Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62434C433EF
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Dec 2021 11:11:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A67466E459;
	Wed,  8 Dec 2021 11:11:31 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2040.outbound.protection.outlook.com [40.107.244.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 247676E0CD
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Dec 2021 11:11:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=khhWaDhmZfXS5J37r3nlcZUQUqbTGz8GJw5sgaIZxXYoOXgiuIh8finOoUtWOPoFn2xhtOKVDdQWk9KHWif/iUfviUoMTRqkWpNMkUEAeHEguFZCrqpekwk37YlEU5ccSP5A+IFYaJqodfQfuBAQg5RQKAsu6KeKomDpig44yWvOnSq9O1rukrKFTwsD/eHRoc+WKnkR3bSs3usk0cNsTQiORptLCetjR6Pjhp4N4DKUH3EddzqDCi8Jt/26IHVV/b8ts5x6hRwv8hncPz7rt9TcBJATFpGiwKMz2ONPYh8q69N4Hxyp9sH8cC6xzXnUm+NcImSWsiJztG4wVn3i/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ESL6Xe1CwZPbnsR05O222qZKQl3F70GVoQXf/48Sols=;
 b=C/1Fy3mk35UfozQndoQZ3EfXsUGJx+le50R94/yMJkr4O7j0MLCGrahb8dT6RovV61or9UcrqpLrxRjqmn8z3+BeVmUplzTbTebK4ItFkdz0oFqeHX8L63p/1YfA1guJa8M+CF+MVjA4cs2sbMJUJWQsfsQkC1wYv2cDM6p9t8QsXNwanxXVaKsmtpknCgg8ZCzwNQ87BUT8pPaciAJYuID/rsK268i09yBkBAPF6jD/XPm2vP7xRVSitoxO9g+W6G9A86yJqQk7cUXfQwthZfFvd4yeqbNWMyz5pYz090v1MUTTUA5+TvWqVJNn2tr8ZYnqWAcin0nyMgk6gexYXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ESL6Xe1CwZPbnsR05O222qZKQl3F70GVoQXf/48Sols=;
 b=LYSbiaYQf8LD060ITHNet1GfRSKDPawgQ7Xo6mUnWKwgXK9mPYkQDRArVP+Tp6QaR9m2lz5pzsO7VsguuSUEHttLEP9daVg+KidJy8EkP5nTLHUDmh+945O9JZaOj58+Q3Q41IW7SV5SGvnD32hYwZV1iHNKLUFIAFvGxi3qNX0=
Received: from CO6PR12MB5473.namprd12.prod.outlook.com (2603:10b6:303:13e::8)
 by CO6PR12MB5393.namprd12.prod.outlook.com (2603:10b6:5:356::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.11; Wed, 8 Dec
 2021 11:11:28 +0000
Received: from CO6PR12MB5473.namprd12.prod.outlook.com
 ([fe80::41ae:ed40:dc40:9205]) by CO6PR12MB5473.namprd12.prod.outlook.com
 ([fe80::41ae:ed40:dc40:9205%9]) with mapi id 15.20.4734.024; Wed, 8 Dec 2021
 11:11:28 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "Yu, Lang" <Lang.Yu@amd.com>
Subject: Re: [PATCH 1/2] drm/amdgpu: remove power on/off SDMA in SMU
 hw_init/fini()
Thread-Topic: [PATCH 1/2] drm/amdgpu: remove power on/off SDMA in SMU
 hw_init/fini()
Thread-Index: AQHX7BgU5HX9dZEduEK+rK85stTqHawoXQK3gAAP4QCAAAN28g==
Date: Wed, 8 Dec 2021 11:11:28 +0000
Message-ID: <CO6PR12MB54732E5665A1323B2BB8010F826F9@CO6PR12MB5473.namprd12.prod.outlook.com>
References: <20211208092642.173385-1-lang.yu@amd.com>
 <CO6PR12MB547373A8EA694763B14A431A826F9@CO6PR12MB5473.namprd12.prod.outlook.com>
 <YbCP2DWgO207Uqjr@lang-desktop>
In-Reply-To: <YbCP2DWgO207Uqjr@lang-desktop>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=True;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-12-08T11:11:27.563Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD
 Official Use
 Only; MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard; 
suggested_attachment_session_id: 8e5620c9-f8a7-97bd-033f-1f2a0d22bae5
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 191462fb-372f-4c23-527c-08d9ba3b7b4a
x-ms-traffictypediagnostic: CO6PR12MB5393:EE_
x-microsoft-antispam-prvs: <CO6PR12MB5393D851043167EFC8F61558826F9@CO6PR12MB5393.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CBopa9nlFv3Ekn6SY19ior0vgaG2luzf2s+NRDQ+RPUOnP4YLqhxiWzW7sPpqDBUMe+6uU9rwEg06bjVNbFwjdlqCxGp7qqvV5qTwg2npHatPM2vSWtAtcXB5BodlvrzPFkN8CqgaWDfv9DlmBMkkdXErFws8FZHK6fPU4QalcMfk62DxQ4GNSq+lZixXfSLmVFRhzbMpBqeGqhlIJkvVkG1xgK3jSqhedXQuzjkCBnQWEs1zWElV9uOpkMN5+odo/fLv4ldjHGbYoA1AaYUyYNJSP9wNP5xF16Akns4gyTq0OMxk4had+6M+VwG4ptDT+9684lkbB3L09+j2lWJUnklmrKRVHyIFlQPIBsIHqdBPtvUFdQHN3j+G/8uORgETvZEW/rygx3zfYy6jGX4mHnwOQx5N2iRZeAYV8LQWmw3h4ycFOxxmjX/FVMYDJyKcbpqzuEDbUPEJJKCQfzvIYf1u3xCIy+5NUjavO9idU1yzFSmwiS3oEQIfoUTnfCf/7jb3ZotDYBv489iQgrFB/vTJ9k+zdoYPorxb8A8eoPBLkxcvX0sA2tZxtPfFMhBVUkIQWILzeR6jF7Rnem3yAWsksZWvcEdnf4770sZ1ImgfzUyl/xvlbOQNcHlsD8dmhYXqBxPQ6ORfFUDIT0EMh03XUkfKE71mX0nqNv1ujc8NJuQVDnA0hhhO2rrRzj2skIAHVDuzd7dsz7HiWkdyQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5473.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(86362001)(316002)(9686003)(91956017)(508600001)(8676002)(55016003)(54906003)(6862004)(4326008)(66556008)(19627405001)(66946007)(66446008)(66476007)(8936002)(2906002)(6506007)(52536014)(186003)(38070700005)(53546011)(122000001)(38100700002)(71200400001)(7696005)(5660300002)(33656002)(6636002)(76116006)(83380400001)(64756008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?R6emoq1w2nCoWSWIDdQQYXCvXUk8TBSe1+NY3RfDrzk94Kq6hLfaoJHhcg?=
 =?iso-8859-1?Q?f4XD9K/MC5ya67vYxLQpQX+0/xBTA/DQUM8w3dx3B0Pga4TEmukSLxFAQR?=
 =?iso-8859-1?Q?L9D7eXgVCdDprDR1STRNGAwsJliWa6Z0Q1tiCz40KnIZvnloXQAb+WLjkb?=
 =?iso-8859-1?Q?fvekm+vt/PGFpzLmF3t6kHlEqNs2d0u90aaydWqcxQbBSuv9btAgMYgVGH?=
 =?iso-8859-1?Q?60/4r3AdJYhMvyA1LVwdjRB0/rNjGUT7zc3Lg2b6WxZP9GwCB30IuR6rzJ?=
 =?iso-8859-1?Q?mtkNpqHgjAna8J0qDcioXvYRGbIYEUMn+3F8f0NejB6ZCr7zRY/O+T4VPl?=
 =?iso-8859-1?Q?jbyyWjHOZtToWu2lCqB0MInIGv8Um1fC7hwIjWFnZbmg8WSHOfiYb8P7RI?=
 =?iso-8859-1?Q?5yUxc4nYAJQkDFcKoU1rVkFW6e5aQDyD2oipTU0Nu8hs7bLjsA06in4VQI?=
 =?iso-8859-1?Q?0uya972gvSYUmXIgBIVf0ktJmEsNRi7WGFklzBxn0x/2MheVKEUTJWZrVm?=
 =?iso-8859-1?Q?fH30JXZ5Zh6ZPX0OrBlPWEm+vir679i7qrEta4GiNj34Xrjff45xtPtP0s?=
 =?iso-8859-1?Q?tjPEAPKGg4PFq4zGt95xZqpcbMpdz9mNJnxnZiRg35OFBc9Hzfj2OC3HYk?=
 =?iso-8859-1?Q?0Kjb5wiykm0yIPJ55yWLrdAlceFJCrRhB6moLU6+y/MqsLiGPfA6IdieZW?=
 =?iso-8859-1?Q?1dgulfxPQAW+QasbmIflAmLBxdzd5sHIWdQ5/WBmAuL8goNT2TJo6alyag?=
 =?iso-8859-1?Q?J+Jg4Tm2apFuqw3Cd61uff0d+6ZP07cp4JrTqloscu3+iG2C+cftd4nV9j?=
 =?iso-8859-1?Q?99dlvZggkRaE8pUZiAUnY/1gc8M9IlF4f8vWGUkCReDMNzBIZYbpcqgfQp?=
 =?iso-8859-1?Q?phs11YI9xjeEaVgapbspF8QgpT2N9Xow0bUb1uLDTgVqnU3i9a5WzjTuwp?=
 =?iso-8859-1?Q?AWa6y5PuCxwz8iwAKQckcRpuVKxSDZvHkZsRDyr9s68XYuCtp8LvBFfLUO?=
 =?iso-8859-1?Q?QBQUm/lsGmMT8aTuB5OUz/FHL67s+M2XNbiuWxmwP7B9qtFI90aAqtS6Fc?=
 =?iso-8859-1?Q?Obkt9Qb1jgJ7m4WJas8wEell+plDQH2UdP3pfdBe3KV1HIC74FrrkoTHgp?=
 =?iso-8859-1?Q?80AzefN8grgCpC/5vNwsRlA6P8pd8DLSfRHolZr0FPJSTohNlcwFOdWbXi?=
 =?iso-8859-1?Q?uVPJtRofkk+By4cNwXZTdJp7KETc8NnnnWbwOC/aIWLxBXp3PTEEVy0D2G?=
 =?iso-8859-1?Q?Fkt146BxS+Jrl1kDzswplgM65Uid38Y4DQxUOI1SHZZYXbI56FJmlyhAg8?=
 =?iso-8859-1?Q?xFYh2lysFncYJg3FWWP4rA6moH9gEFdEleLBRrmhzGRBr0Bl59hPZPgMDJ?=
 =?iso-8859-1?Q?Mu7dS0m75TRS8xy5YjOVWzp8gfSFtZHP05DbOkH+xMFUdHmoB77arIdYNG?=
 =?iso-8859-1?Q?TifGdfB8f9FmkidFblQeJo+782m7Vq9e3GfuhAAsSiM+ggU5K59d9goqmr?=
 =?iso-8859-1?Q?8ffH6oBWMhS7qGXbbuyj1OJZwVCspFSF1dm9ny7jvYRrbZazBxcb3tpmFA?=
 =?iso-8859-1?Q?bE2Hg7WL6Ne7d9r1IrkzzRfcescNcwV/qicYdWcqLTLPdL3GvC5zza6M/A?=
 =?iso-8859-1?Q?8G1av/l0Z2Qy+ufVg4Zz8Qy96qaMiEnEFCQ8mOI29xVK+oMO7VqE/eQA?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: multipart/alternative;
 boundary="_000_CO6PR12MB54732E5665A1323B2BB8010F826F9CO6PR12MB5473namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 191462fb-372f-4c23-527c-08d9ba3b7b4a
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Dec 2021 11:11:28.0974 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bTNGaHU89J68IjFZF8LODCO0QOwMgSCDK6/udu3VMmuSf+tWta+SXVNnOe0OEOf3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5393
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
Cc: "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "Lazar, Lijo" <Lijo.Lazar@amd.com>,
 "Huang, Ray" <Ray.Huang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_CO6PR12MB54732E5665A1323B2BB8010F826F9CO6PR12MB5473namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only]

OK, I miss this call path.

Reviewed-by: Kevin Wang <kevinyang.wang@amd.com>

Best Regards,
Kevin

________________________________
From: Yu, Lang <Lang.Yu@amd.com>
Sent: Wednesday, December 8, 2021 6:58 PM
To: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>
Cc: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>; Deucher,=
 Alexander <Alexander.Deucher@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.com>; H=
uang, Ray <Ray.Huang@amd.com>
Subject: Re: [PATCH 1/2] drm/amdgpu: remove power on/off SDMA in SMU hw_ini=
t/fini()

On 12/08/ , Wang, Yang(Kevin) wrote:
>    [AMD Official Use Only]
>
>    Hi Lang,
>    the function of smu_powergate_sdma() is only valid on renoir chip.
>    if you want to remove it, please also remove following callback pointe=
r
>    in struct pptable_funcs{}.
>    related macro definitions also need to be cleaned up.
>    int (*powergate_sdma)(struct smu_context *smu, bool gate);

     It will be still called by amdgpu_dpm_set_powergating_by_smu()
     in sdma_v4_0_hw_init/fini().

     Regards,
     Lang

>    Best Regards,
>    Kevin
>      __________________________________________________________________
>
>    From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Lan=
g
>    Yu <lang.yu@amd.com>
>    Sent: Wednesday, December 8, 2021 5:26 PM
>    To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
>    Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Yu, Lang
>    <Lang.Yu@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.com>; Huang, Ray
>    <Ray.Huang@amd.com>
>    Subject: [PATCH 1/2] drm/amdgpu: remove power on/off SDMA in SMU
>    hw_init/fini()
>
>    Currently, we don't find some neccesities to power on/off
>    SDMA in SMU hw_init/fini(). It makes more sense in SDMA
>    hw_init/fini().
>    Signed-off-by: Lang Yu <lang.yu@amd.com>
>    ---
>     drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 5 -----
>     1 file changed, 5 deletions(-)
>    diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
>    b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
>    index 5839918cb574..2d718c30c8eb 100644
>    --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
>    +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
>    @@ -1350,7 +1350,6 @@ static int smu_hw_init(void *handle)
>             }
>
>             if (smu->is_apu) {
>    -               smu_powergate_sdma(&adev->smu, false);
>                     smu_dpm_set_vcn_enable(smu, true);
>                     smu_dpm_set_jpeg_enable(smu, true);
>                     smu_set_gfx_cgpg(&adev->smu, true);
>    @@ -1512,10 +1511,6 @@ static int smu_hw_fini(void *handle)
>             if (amdgpu_sriov_vf(adev)&& !amdgpu_sriov_is_pp_one_vf(adev))
>                     return 0;
>
>    -       if (smu->is_apu) {
>    -               smu_powergate_sdma(&adev->smu, true);
>    -       }
>    -
>             smu_dpm_set_vcn_enable(smu, false);
>             smu_dpm_set_jpeg_enable(smu, false);
>
>    --
>    2.25.1

--_000_CO6PR12MB54732E5665A1323B2BB8010F826F9CO6PR12MB5473namp_
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
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;" ali=
gn=3D"Left">
[AMD Official Use Only]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
OK, I miss this call path.</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Reviewed-by: Kevin Wang &lt;kevinyang.wang@amd.com&gt;</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Best Regards,</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Kevin</div>
<div id=3D"appendonsend"></div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<br>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" co=
lor=3D"#000000" style=3D"font-size:11pt"><b>From:</b> Yu, Lang &lt;Lang.Yu@=
amd.com&gt;<br>
<b>Sent:</b> Wednesday, December 8, 2021 6:58 PM<br>
<b>To:</b> Wang, Yang(Kevin) &lt;KevinYang.Wang@amd.com&gt;<br>
<b>Cc:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;; Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Lazar, Lijo &lt;=
Lijo.Lazar@amd.com&gt;; Huang, Ray &lt;Ray.Huang@amd.com&gt;<br>
<b>Subject:</b> Re: [PATCH 1/2] drm/amdgpu: remove power on/off SDMA in SMU=
 hw_init/fini()</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt"=
>
<div class=3D"PlainText">On 12/08/ , Wang, Yang(Kevin) wrote:<br>
&gt;&nbsp;&nbsp;&nbsp; [AMD Official Use Only]<br>
&gt; <br>
&gt;&nbsp;&nbsp;&nbsp; Hi Lang,<br>
&gt;&nbsp;&nbsp;&nbsp; the function of smu_powergate_sdma() is only valid o=
n renoir chip.<br>
&gt;&nbsp;&nbsp;&nbsp; if you want to remove it, please also remove followi=
ng callback pointer<br>
&gt;&nbsp;&nbsp;&nbsp; in struct pptable_funcs{}.<br>
&gt;&nbsp;&nbsp;&nbsp; related macro definitions also need to be cleaned up=
.<br>
&gt;&nbsp;&nbsp;&nbsp; int (*powergate_sdma)(struct smu_context *smu, bool =
gate);<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp; It will be still called by amdgpu_dpm_set_powergat=
ing_by_smu()<br>
&nbsp;&nbsp;&nbsp;&nbsp; in sdma_v4_0_hw_init/fini().<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br>
&nbsp;&nbsp;&nbsp;&nbsp; Regards,<br>
&nbsp;&nbsp;&nbsp;&nbsp; Lang<br>
<br>
&gt;&nbsp;&nbsp;&nbsp; Best Regards,<br>
&gt;&nbsp;&nbsp;&nbsp; Kevin<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ________________________________________=
__________________________<br>
&gt; <br>
&gt;&nbsp;&nbsp;&nbsp; From: amd-gfx &lt;amd-gfx-bounces@lists.freedesktop.=
org&gt; on behalf of Lang<br>
&gt;&nbsp;&nbsp;&nbsp; Yu &lt;lang.yu@amd.com&gt;<br>
&gt;&nbsp;&nbsp;&nbsp; Sent: Wednesday, December 8, 2021 5:26 PM<br>
&gt;&nbsp;&nbsp;&nbsp; To: amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.=
freedesktop.org&gt;<br>
&gt;&nbsp;&nbsp;&nbsp; Cc: Deucher, Alexander &lt;Alexander.Deucher@amd.com=
&gt;; Yu, Lang<br>
&gt;&nbsp;&nbsp;&nbsp; &lt;Lang.Yu@amd.com&gt;; Lazar, Lijo &lt;Lijo.Lazar@=
amd.com&gt;; Huang, Ray<br>
&gt;&nbsp;&nbsp;&nbsp; &lt;Ray.Huang@amd.com&gt;<br>
&gt;&nbsp;&nbsp;&nbsp; Subject: [PATCH 1/2] drm/amdgpu: remove power on/off=
 SDMA in SMU<br>
&gt;&nbsp;&nbsp;&nbsp; hw_init/fini()<br>
&gt; <br>
&gt;&nbsp;&nbsp;&nbsp; Currently, we don't find some neccesities to power o=
n/off<br>
&gt;&nbsp;&nbsp;&nbsp; SDMA in SMU hw_init/fini(). It makes more sense in S=
DMA<br>
&gt;&nbsp;&nbsp;&nbsp; hw_init/fini().<br>
&gt;&nbsp;&nbsp;&nbsp; Signed-off-by: Lang Yu &lt;lang.yu@amd.com&gt;<br>
&gt;&nbsp;&nbsp;&nbsp; ---<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 5 =
-----<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; 1 file changed, 5 deletions(-)<br>
&gt;&nbsp;&nbsp;&nbsp; diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu=
.c<br>
&gt;&nbsp;&nbsp;&nbsp; b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c<br>
&gt;&nbsp;&nbsp;&nbsp; index 5839918cb574..2d718c30c8eb 100644<br>
&gt;&nbsp;&nbsp;&nbsp; --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c<br>
&gt;&nbsp;&nbsp;&nbsp; +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c<br>
&gt;&nbsp;&nbsp;&nbsp; @@ -1350,7 +1350,6 @@ static int smu_hw_init(void *h=
andle)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; }<br>
&gt; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; if (smu-&gt;is_apu) {<br>
&gt;&nbsp;&nbsp;&nbsp; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_powergate_sdma(&amp;adev-&gt;smu, fal=
se);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_dpm_set_vcn_enable(sm=
u, true);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_dpm_set_jpeg_enable(s=
mu, true);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_set_gfx_cgpg(&amp;ade=
v-&gt;smu, true);<br>
&gt;&nbsp;&nbsp;&nbsp; @@ -1512,10 +1511,6 @@ static int smu_hw_fini(void *=
handle)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; if (amdgpu_sriov_vf(adev)&amp;&amp; !amdgpu_sriov_is_pp_one_vf(adev))<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt; <br>
&gt;&nbsp;&nbsp;&nbsp; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (smu-&gt;is=
_apu) {<br>
&gt;&nbsp;&nbsp;&nbsp; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_powergate_sdma(&amp;adev-&gt;smu, tru=
e);<br>
&gt;&nbsp;&nbsp;&nbsp; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp;&nbsp; -<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; smu_dpm_set_vcn_enable(smu, false);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; smu_dpm_set_jpeg_enable(smu, false);<br>
&gt; <br>
&gt;&nbsp;&nbsp;&nbsp; --<br>
&gt;&nbsp;&nbsp;&nbsp; 2.25.1<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_CO6PR12MB54732E5665A1323B2BB8010F826F9CO6PR12MB5473namp_--
