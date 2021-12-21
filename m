Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0A61C433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Dec 2021 14:15:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4BDC21132BE;
	Tue, 21 Dec 2021 14:15:10 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2051.outbound.protection.outlook.com [40.107.244.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0498C1132CB
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Dec 2021 14:15:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KjJwbUWHtJwfs7frwPccTvuScsBVQ1nOzrT1LvTUjPZ1YI6IEdGVcf4qBa1F1B+mDKsMlixhXjI0VIizz1H0JxvaneTXB0bK58DEg5WW2Lhpc4VsGeEDi7Da7Mofgl/VHZ8AmJoUbPSoD4KjPEo4p2QM/ujFOvNi5rUbHbJQFdVQbqyxVwSUWbU38c6C+iasQzRzNTOTQotFbS7ycKpBDBEgvAw95Ckqn/XFJOlOYez1ZijwVTWv4iwo6dQjHWMgBtUoF4aGQpUUnnPOhktn3mpXFc2XsK/nUCkdbClpwJlhQhYARJ6vKwg3BAa77niNYymflvhikNal/4hLNjKG7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8erhNu+9KjO1+Af7cOjlF/VylL+jvHJO88nwCJch6ig=;
 b=j6SYqHatvFOYiuMOk9jIt8xiuLQ3EiYWvZAwl/JMcExgrReu8uHMsqddm+kRVUUQFzgR9T3rMMLMbx0Z62h9Te4B3VM5rC8MmAJ9cMh14TxYuZ9QYZdExAXTLjelh1PJGfVOiuxq++PA40JTUWp7M//TWo3jGgfFCXcDZ+wd8Hs3hq3xVBXi3rfuJnMB6y5198AgUAwr4SLIIHoIcKvTMCSQD5+U7kRgDCxE8GKATSjcN9ct1M2/0gJntW/lgzV9fIgdaWraHwTYkMAKZbwHZd+WRvfBQXXxXwNHVFFuBXnTUKgOrVoKb24z+bsP8eQXKHUrScRFmCxd8n4xM9Tn5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8erhNu+9KjO1+Af7cOjlF/VylL+jvHJO88nwCJch6ig=;
 b=2rLyXh/UmeYuZ5hVDt6+cK7UFjZzN1Mh6ezQYSDuK38opl7SdR931eDzSc7bLjnAXjd1ch597sQo8KJQsGd64OZZrj6ujZd2PnXElpcBIab5JjVz73Ju9PnzX+b1DDHTv7g0Y3sze+dbPgwiw1/XzUu/9WRRfOltguENQ6HbEI0=
Received: from DM6PR12MB4300.namprd12.prod.outlook.com (2603:10b6:5:21a::21)
 by DM5PR12MB4661.namprd12.prod.outlook.com (2603:10b6:4:aa::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.16; Tue, 21 Dec
 2021 14:15:07 +0000
Received: from DM6PR12MB4300.namprd12.prod.outlook.com
 ([fe80::ad2e:ee2e:f3a6:398a]) by DM6PR12MB4300.namprd12.prod.outlook.com
 ([fe80::ad2e:ee2e:f3a6:398a%5]) with mapi id 15.20.4801.020; Tue, 21 Dec 2021
 14:15:07 +0000
From: "Nikolic, Marina" <Marina.Nikolic@amd.com>
To: "Russell, Kent" <Kent.Russell@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] amdgpu/pm: Modify sysfs pp_dpm_sclk to have only read
 premission in ONEVF mode
Thread-Topic: [PATCH] amdgpu/pm: Modify sysfs pp_dpm_sclk to have only read
 premission in ONEVF mode
Thread-Index: AQHX9bvj41WooLnqpEOY/BhGvnfg9qw7vGaAgAFAa0A=
Date: Tue, 21 Dec 2021 14:15:07 +0000
Message-ID: <DM6PR12MB4300CCD940D7D651D07CBD2A8E7C9@DM6PR12MB4300.namprd12.prod.outlook.com>
References: <20211220160834.8400-1-Marina.Nikolic@amd.com>
 <DM6PR12MB2858E316736722D6682BAAAA857B9@DM6PR12MB2858.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB2858E316736722D6682BAAAA857B9@DM6PR12MB2858.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-Mentions: Greg.Kitchen@amd.com
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=True;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-12-21T14:15:06.932Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD
 Official Use
 Only; MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard; 
suggested_attachment_session_id: 1bb3100b-a3c6-5f38-0b31-21ca21e1ca63
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 701663ba-5312-44b5-395b-08d9c48c4a97
x-ms-traffictypediagnostic: DM5PR12MB4661:EE_
x-microsoft-antispam-prvs: <DM5PR12MB46615FAA6CCE269CE1D8E2668E7C9@DM5PR12MB4661.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2449;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8dXmdFwEl6+273c4tqKg9jK27ZV5Zf/mjQUd6D4y3Qj1EVtr6NjCLHlbrOL3utmb+H71tXKUjGjd34dEMHNmmCsuEOESAGHEGgM/J6dApfTVXGGBWR3PXZH3LA8lkdHGXz4TrY2TCrveIiTFr9nfITrXkgosnwvlhnSiO1NsRfw8WQZ224gzg3+o6RPBpqW63aKn55h8J0jRxE57Ankh2V8Yczn8Sng/WvYzbPJriv/knaLTNOUbap6hnfEB7ZC2Xk+7O6tkhK4JDnDdA+OkvCSC2NMOnXu5dry9CoIy65YyYtVR8HwWpJqi6Ab98ATWXVGFpjeEqnKOuswUfoVAlsGbxiwxldcTRevzZl2cIbKzlZNwe/Dbe7dS5U+Cu4SoBXCOZsN0z0yirv2mC0H64vxIjpsvojXn4zw0kCc15ZyJl8/yLvJDbsRfNZhMoXPoLRuIQgTM2OVSL4pgnYy7F2AQvpnKhU9WxbgdossQ5WfvJbUm8uv2cKd0uHmZqv/Egxls7/vaPCz4IZXjtCjiLo1Q2eavhytAQYm73yCqCzsdBXgNdSzWVTCgmOSBLt/v+ewf25vjV9qJC2qIERmaYG951AKs2xcCzr00+mYE1Zh5nt1WucYjpgODNd2a+x4XhlCZN3rsqlFPMQ7eajBisGu1WCYA4K2JSOmw+vVLoTeaRwcoMXNDneVzHMCnGcze2DcBwrsp5l/yzkWbVangrA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4300.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(6506007)(110136005)(8936002)(38100700002)(26005)(53546011)(38070700005)(91956017)(122000001)(316002)(66446008)(83380400001)(186003)(52536014)(7696005)(19627405001)(8676002)(66946007)(54906003)(33656002)(9686003)(5660300002)(76116006)(508600001)(71200400001)(86362001)(66476007)(55016003)(4326008)(64756008)(66556008)(2906002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?jbCny2sqi+5insJMmRkj7SLTiVr5dZrE7uw5cPuCJX5IqPYsZ3f70JYY7cz7?=
 =?us-ascii?Q?C0lu9L+HwTEeTivy5hi/+vtax11zTnpP9eBklCAnG221CdChyhCkuiV/zoIo?=
 =?us-ascii?Q?DkpAsclqDRrsl2WrA+v8Nmu7i8edesmyNowiSqjyPktjNQmT1m63JeHZsCPB?=
 =?us-ascii?Q?mTP2H8P34sZAFjPf4nl0l3K9DVbgC8kNzrCzWqjz6+sS7viAP+rjffic2MTu?=
 =?us-ascii?Q?XPwwikluWkWnAT75HHrLlyQyFDIUxMgIKu5OvrciO7uL8dYipCl+GJnUI1c9?=
 =?us-ascii?Q?TBD/98v2wYf2mfhYinsRMRCktLWLNRBPru7RRfcPwxiTn12hRoCVK6gwWqbq?=
 =?us-ascii?Q?PCVkntxCeptH9pC1+nFoY/flH96IjciPPu+Qpe9ChBP1FtE9LM4zoTCKaTGs?=
 =?us-ascii?Q?m9RNzb/op0nM8E42rEpkn8eVFgSLoWkgllfGYjJOxZkpE7yoHMG2+HppolZ6?=
 =?us-ascii?Q?alDWeAvt9io4YoC4FbiDdu6FJGz0LAkGDUE04aHn/+4V/rK1HMHcYE+z6Tvd?=
 =?us-ascii?Q?xip8SQGQvJBxeM7T4lQBQyf4/m55x4fX55N+ymFV2awn0EC/iU46KTSHCXs9?=
 =?us-ascii?Q?t83hVt5QZ09r5wmuKiCjYznDGecyPbafjsCP6DWdxJ3oPCXegnwENsvS1MeI?=
 =?us-ascii?Q?TKJqG5/GHHL+Q6HgY2VL/TnHc5IulrRqXJv0ZV73IrSPVmicih2QqNZp2ZXy?=
 =?us-ascii?Q?/qLA/YY0lHHAUIi0rxIbrMR0bFzoZn5wPc8WZMLPhHoYwPVtuErWl4DFWXp0?=
 =?us-ascii?Q?pqItTi14LAF4xDACal+zs4PMJKS/mzggHkDCa2Pq2mbZS0mE8OGkNEw/Di62?=
 =?us-ascii?Q?ynmYfAqspPBpyTEoqRkhabSf44Aiu6rhADpKB+aEWXe2dvxQeLOtOgfmKGS2?=
 =?us-ascii?Q?300KMHyLo688uhquaKRMawBob0i1rzgEO4v89WYyDGQIDu1vGNCk3YGFZDep?=
 =?us-ascii?Q?3GVLX8kSL0YhaxcxB6DY8A7IQ+la++609s0y+7R8m5LM/CN4QELyIY6l0FJV?=
 =?us-ascii?Q?cA9HTkACjwf4ET8nEkTXsty6U2uU3MKiwkzxrJwDntqX+FYGuXi0PNEJEpo7?=
 =?us-ascii?Q?NujrozDsudhqSf55wdePVt8NfF4srbPq0R0syMlzmGhq1UzFVPkPokbnjP7w?=
 =?us-ascii?Q?broohpTUE1Ci8uTR5+O0EPnPYo6n8JUXvJxeqSV3V90S8fcbFLky1TSiZTiy?=
 =?us-ascii?Q?gFInnjexLA3V3RCOAV+iRDaoodgQaNqktiMsAhNpnLtNBGDRQzyfD8K//7s1?=
 =?us-ascii?Q?7EUzGL5HmrsDMgpA+l8cQLUZdggJdr08gk8MjLeB72MUIVYew9GGsnJnMty2?=
 =?us-ascii?Q?KdtgLfOedSiq8Xm33//bS+UfPuDR2T01ZypPUePK34ii+OdO6AeCcAdmqVqj?=
 =?us-ascii?Q?25EwUqjR/nYkandh5YbMtbZSlmR+0WKImb+F/s07N+wmPkPdqJENK4CgZsHW?=
 =?us-ascii?Q?uMAydoR2HvENRLUtTck1vAAbSAKYP2z+5/XmYP5GLgZYo81BeLpM9l+CJp31?=
 =?us-ascii?Q?53YvztAsJrnN0NxoMcI26mBUiJS1vwvZHP7o9kwL4ztdRiAiVqPE9XO/RiRj?=
 =?us-ascii?Q?Psjp+WO1rFBtICKhACO3z/hNA2uu3cmrmtzfLz4+nCmHU0CEpWOMXcDrA7Cd?=
 =?us-ascii?Q?aQ=3D=3D?=
Content-Type: multipart/alternative;
 boundary="_000_DM6PR12MB4300CCD940D7D651D07CBD2A8E7C9DM6PR12MB4300namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4300.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 701663ba-5312-44b5-395b-08d9c48c4a97
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Dec 2021 14:15:07.4588 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LejArC2vhReOsiGmLKWtfNB4WLgTr3WYlZT0dGlj5B7k3xnRFxE3IadCtWFVT+utljdnrNxUs36JshMKA2ycgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB4661
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
Cc: "Mitrovic, Milan" <Milan.Mitrovic@amd.com>, "Kitchen,
 Greg" <Greg.Kitchen@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_DM6PR12MB4300CCD940D7D651D07CBD2A8E7C9DM6PR12MB4300namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only]

Hi Kent,

Thank you for the review. Yes, I can confirm I am trying to set this for ev=
ery single file for SRIOV mode.
@Kitchen, Greg<mailto:Greg.Kitchen@amd.com> required this for ROCM-SMI 5.0 =
release. In case you need it, he can provide more details.
I'm going to clarify commit message more and send a new patch.

BR,
Marina
________________________________
From: Russell, Kent <Kent.Russell@amd.com>
Sent: Monday, December 20, 2021 8:01 PM
To: Nikolic, Marina <Marina.Nikolic@amd.com>; amd-gfx@lists.freedesktop.org=
 <amd-gfx@lists.freedesktop.org>
Cc: Mitrovic, Milan <Milan.Mitrovic@amd.com>; Nikolic, Marina <Marina.Nikol=
ic@amd.com>; Kitchen, Greg <Greg.Kitchen@amd.com>
Subject: RE: [PATCH] amdgpu/pm: Modify sysfs pp_dpm_sclk to have only read =
premission in ONEVF mode

[AMD Official Use Only]

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Marina=
 Nikolic
> Sent: Monday, December 20, 2021 11:09 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Mitrovic, Milan <Milan.Mitrovic@amd.com>; Nikolic, Marina
> <Marina.Nikolic@amd.com>; Kitchen, Greg <Greg.Kitchen@amd.com>
> Subject: [PATCH] amdgpu/pm: Modify sysfs pp_dpm_sclk to have only read pr=
emission in
> ONEVF mode
>
> =3D=3D Description =3D=3D
> Due to security reasons setting through sysfs
> should only be allowed in passthrough mode.
> Options that are not mapped as SMU messages
> do not have any mechanizm to distinguish between
> passthorugh, onevf and mutivf usecase.
> A unified approach is needed.
>
> =3D=3D Changes =3D=3D
> This patch introduces a new mechanizm to distinguish
> ONEVF and PASSTHROUGH use case on sysfs level
> and prohibit setting (writting to sysfs).
> It also applies the new mechanizm on pp_dpm_sclk sysfs file.
>
> =3D=3D Test =3D=3D
> Writing to pp_dpm_sclk sysfs file in passthrough mode will succeed.
> Writing to pp_dpm_sclk sysfs file in ONEVF mode will yield error:
> "calling process does not have sufficient permission to execute a command=
".
> Sysfs pp_dpm_sclk will not be created in MULTIVF mode.
>
> Signed-off-by: Marina Nikolic <Marina.Nikolic@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/amdgpu_pm.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> index 082539c70fd4..d2b168babc7d 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> @@ -2133,6 +2133,12 @@ static int default_attr_update(struct amdgpu_devic=
e *adev,
> struct amdgpu_device_
>               }
>       }
>
> +     /* security: setting should not be allowed from VF */
> +     if (amdgpu_sriov_vf(adev)) {

You should be checking for pp_dpm_sclk here, for example:
                if (DEVICE_ATTR_IS(pp_dpm_sclk) {

Otherwise I am pretty sure you're setting this for every single file. And i=
s it only sclk? Or does it also need to affect mclk/fclk/etc? If it's only =
sclk, the line above should help. If it's for more, then the commit should =
try to clarify that as it's not 100% clear.

 Kent

> +             dev_attr->attr.mode &=3D ~S_IWUGO;
> +             dev_attr->store =3D NULL;
> +     }
> +
>  #undef DEVICE_ATTR_IS
>
>       return 0;
> --
> 2.20.1


--_000_DM6PR12MB4300CCD940D7D651D07CBD2A8E7C9DM6PR12MB4300namp_
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
Hi Kent,&nbsp;</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Thank you for the review. Yes, I can confirm I am trying to set this for ev=
ery single file for SRIOV mode.</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<a id=3D"OWAAM749892" class=3D"J9Y1oNF3ZpoR5LC3M2PHm mention ms-bgc-nlr ms-=
fcl-b" href=3D"mailto:Greg.Kitchen@amd.com">@Kitchen, Greg</a>&nbsp;require=
d this for ROCM-SMI 5.0 release. In case you need it, he can provide more d=
etails.</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
I'm going to clarify commit message more and send a new patch.</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
BR,<br>
Marina</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Russell, Kent &lt;Ken=
t.Russell@amd.com&gt;<br>
<b>Sent:</b> Monday, December 20, 2021 8:01 PM<br>
<b>To:</b> Nikolic, Marina &lt;Marina.Nikolic@amd.com&gt;; amd-gfx@lists.fr=
eedesktop.org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Cc:</b> Mitrovic, Milan &lt;Milan.Mitrovic@amd.com&gt;; Nikolic, Marina =
&lt;Marina.Nikolic@amd.com&gt;; Kitchen, Greg &lt;Greg.Kitchen@amd.com&gt;<=
br>
<b>Subject:</b> RE: [PATCH] amdgpu/pm: Modify sysfs pp_dpm_sclk to have onl=
y read premission in ONEVF mode</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font face=3D"Times New Roman" size=3D"3"><span=
 style=3D"font-size:12pt;"><a name=3D"BM_BEGIN"></a>
<div><font size=3D"2"><span style=3D"font-size:11pt;">[AMD Official Use Onl=
y]<br>
<br>
&gt; -----Original Message-----<br>
&gt; From: amd-gfx &lt;amd-gfx-bounces@lists.freedesktop.org&gt; On Behalf =
Of Marina Nikolic<br>
&gt; Sent: Monday, December 20, 2021 11:09 AM<br>
&gt; To: amd-gfx@lists.freedesktop.org<br>
&gt; Cc: Mitrovic, Milan &lt;Milan.Mitrovic@amd.com&gt;; Nikolic, Marina<br=
>
&gt; &lt;Marina.Nikolic@amd.com&gt;; Kitchen, Greg &lt;Greg.Kitchen@amd.com=
&gt;<br>
&gt; Subject: [PATCH] amdgpu/pm: Modify sysfs pp_dpm_sclk to have only read=
 premission in<br>
&gt; ONEVF mode<br>
&gt;<br>
&gt; =3D=3D Description =3D=3D<br>
&gt; Due to security reasons setting through sysfs<br>
&gt; should only be allowed in passthrough mode.<br>
&gt; Options that are not mapped as SMU messages<br>
&gt; do not have any mechanizm to distinguish between<br>
&gt; passthorugh, onevf and mutivf usecase.<br>
&gt; A unified approach is needed.<br>
&gt;<br>
&gt; =3D=3D Changes =3D=3D<br>
&gt; This patch introduces a new mechanizm to distinguish<br>
&gt; ONEVF and PASSTHROUGH use case on sysfs level<br>
&gt; and prohibit setting (writting to sysfs).<br>
&gt; It also applies the new mechanizm on pp_dpm_sclk sysfs file.<br>
&gt;<br>
&gt; =3D=3D Test =3D=3D<br>
&gt; Writing to pp_dpm_sclk sysfs file in passthrough mode will succeed.<br=
>
&gt; Writing to pp_dpm_sclk sysfs file in ONEVF mode will yield error:<br>
&gt; &quot;calling process does not have sufficient permission to execute a=
 command&quot;.<br>
&gt; Sysfs pp_dpm_sclk will not be created in MULTIVF mode.<br>
&gt;<br>
&gt; Signed-off-by: Marina Nikolic &lt;Marina.Nikolic@amd.com&gt;<br>
&gt; ---<br>
&gt;&nbsp; drivers/gpu/drm/amd/pm/amdgpu_pm.c | 6 ++++++<br>
&gt;&nbsp; 1 file changed, 6 insertions(+)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c<br>
&gt; b/drivers/gpu/drm/amd/pm/amdgpu_pm.c<br>
&gt; index 082539c70fd4..d2b168babc7d 100644<br>
&gt; --- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c<br>
&gt; +++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c<br>
&gt; @@ -2133,6 +2133,12 @@ static int default_attr_update(struct amdgpu_de=
vice *adev,<br>
&gt; struct amdgpu_device_<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; /* security: setting should not be allowed f=
rom VF */<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(adev)) {<br>
<br>
You should be checking for pp_dpm_sclk here, for example:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; if (DEVICE_ATTR_IS(pp_dpm_sclk) {<br>
<br>
Otherwise I am pretty sure you're setting this for every single file. And i=
s it only sclk? Or does it also need to affect mclk/fclk/etc? If it's only =
sclk, the line above should help. If it's for more, then the commit should =
try to clarify that as it's not
 100% clear.<br>
<br>
&nbsp;Kent<br>
<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; dev_attr-&gt;attr.mode &amp;=3D ~S_IWUGO;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; dev_attr-&gt;store =3D NULL;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; +<br>
&gt;&nbsp; #undef DEVICE_ATTR_IS<br>
&gt;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt; --<br>
&gt; 2.20.1<br>
<br>
</span></font></div>
</span></font></div>
</div>
</body>
</html>

--_000_DM6PR12MB4300CCD940D7D651D07CBD2A8E7C9DM6PR12MB4300namp_--
