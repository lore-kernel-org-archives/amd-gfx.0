Return-Path: <SRS0=Z8rF=PU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FD9EC433F5
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Nov 2021 02:46:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8893C60F3A
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Nov 2021 02:46:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8893C60F3A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C7E7889836;
	Mon,  1 Nov 2021 02:46:31 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2047.outbound.protection.outlook.com [40.107.236.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B6D7289836
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Nov 2021 02:46:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jZQ3vIPYHBg+S0oGbUmGnPK36fpY5JwZwanexgsLonJysm+tYOfMVlweVlW7JpF1WNulv4BK8Q573LQ1UsNqsDzmq2AJTyYT//1v7OxXNLtL837z/63/y6Y7LIgTQvhGaFQDU2UtV42XhyK0Fyx66HuRkOnJj89PDwqEgkHpcmMv9Ny3GLZzkF8DEE9woRk7jK1Ydgrr/w5NIBbxUVmPe80ebO/MKWs3dpVxIwHyueks3wMq/wjuLsbPXl1bVY9REWvw0DL6Wk/gvz+Ibd+5Wet1hYf8hPBai4fy6DHSjS9yTE/GMH3QnHUFhh8XDyubtJmY4akZOR/xTeJgBbKMbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d00w1sAH9t7ZdnV2RORThRXgtX4/pSbqRf9h6gac76w=;
 b=FuVfAioK93Dy2ZWg3DsOPg+CLdy1XkfGNCEjcK+5CNLItkLaAvkk1TvDDSAcu8uorjXmgKwwosuUw9Lxz+/iCcf1l8hMle2A5P2O1TpILlPWnTZW76oZHKcjEtq5ERE4+xmLNFpbge9JtCoNf+h3uKc3/trrEe+Fgr0j2V5o5FaqA553jy12xp+5vNYphUFifMxDNGUatQII3/FokBnwkf7XJJFjfjLNRNu78Oh/wiCKnpqpSawOkDpmj88SX9kgYTrvrjnhnEDu83zijuWSQac2W4H7HfrjTojAjKUvCZVbYYpHefYMWRfrpw9okpxvu68c9JDuQnNgX1Zj74WG1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d00w1sAH9t7ZdnV2RORThRXgtX4/pSbqRf9h6gac76w=;
 b=EP4hLzQNhktUbHXNgQ1ICiYhjmWsg5sl9qPVZhHh8STPRPWownFUKpApnvAjJtf1zPMZtoBAi7/cN2dCfMe7qB8aby5+0ZsbGtCFfWLl4n6L4UyVCn28z3xcpKNhJt1C2fjiRzjECgaS5PSGzr1AH6uPPk3DZ3dsn53m61Fhsns=
Received: from SA0PR12MB4510.namprd12.prod.outlook.com (2603:10b6:806:94::8)
 by SN6PR12MB2686.namprd12.prod.outlook.com (2603:10b6:805:72::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15; Mon, 1 Nov
 2021 02:46:28 +0000
Received: from SA0PR12MB4510.namprd12.prod.outlook.com
 ([fe80::7cbc:2454:74b9:f4ea]) by SA0PR12MB4510.namprd12.prod.outlook.com
 ([fe80::7cbc:2454:74b9:f4ea%6]) with mapi id 15.20.4649.019; Mon, 1 Nov 2021
 02:46:28 +0000
From: "Limonciello, Mario" <Mario.Limonciello@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, Alex Deucher <alexdeucher@gmail.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Deucher, 
 Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdgpu/pm: Don't show pp_power_profile_mode for YC
 and later APUs
Thread-Topic: [PATCH] drm/amdgpu/pm: Don't show pp_power_profile_mode for YC
 and later APUs
Thread-Index: AQHXzQpfR0t+R21ab0+Bz/UnGbwLr6vq6DqAgAC2CgCAAAbiAIACVdOw
Date: Mon, 1 Nov 2021 02:46:27 +0000
Message-ID: <SA0PR12MB4510B9D577B9B4FE3608AD30E28A9@SA0PR12MB4510.namprd12.prod.outlook.com>
References: <20211029211717.28519-1-mario.limonciello@amd.com>
 <DM6PR12MB39307B878DCE0423ADFBBFF397889@DM6PR12MB3930.namprd12.prod.outlook.com>
 <CADnq5_PDhA61gJYTPg3Dn=zy0hrt2ZJJN4TYm5WJRQfACrjDbg@mail.gmail.com>
 <DM6PR12MB3930BB63A500C4E548B697FD97889@DM6PR12MB3930.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB3930BB63A500C4E548B697FD97889@DM6PR12MB3930.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-11-01T02:46:26Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 87bcf92f-1bde-4b71-7c20-08d99ce1cd93
x-ms-traffictypediagnostic: SN6PR12MB2686:
x-microsoft-antispam-prvs: <SN6PR12MB26867CB1FB2184165740C64EE28A9@SN6PR12MB2686.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CDzOEvSHkxHUcAB4wtQKm27ch+YthwSS2+lTrtxzfc+sGrkjjF3TdPqgZOyOgW+RhoPw5xFH9dn/1nVbWJ8zyzJmegBcE+/7mFw7X4E5ZRln3ov++muIiIM6YmUtmcy1CuxoMMbu4tTadSstNnWHjUQxFZ1XMeLtdm5egoJNAZ46ZpvTJbx6JrKIGcAeCb5IfO490QwtREs7ZNrCevOivBFEOBUe7fe+MCMtVrT2NuTpZXAaq5p0vaDg6zBDPjC/0nljywTDPTkOBbPjpmEcrRsqQKNig7+7ZQSnLxOsSR2Ka5MU2emikwzPOSFI8RJ5h0eSiH7Y5z3XCQIRorDopPioQmvJg+6MWSFLuwVMZ23rMuVORRJBZdgsPBbo4gjC916bsqAATGayZFWQF5tClkdg/uh9hKVPnNKXDeckN+1nHAEATFWQTjSJNAo5oQRQMqWcY1GdEZJwH/CZcMs1TuAlIf85W72U+5iyTl2MZ1qhevBwB94ROPtnukflcXbjev0yzWBrotWd41EcCtyspcLUJOWY1+lF2L9HZ9R3HFd8orr23FZf32dwUB9sUHrVskm/xDOirUHfGhnCD16VpBDrmeMX6KnmyS4oz5ZEXiC/1++u2tY++hpSDpVYxOTyKp+3a5TruJkSUFmuANZOsu4Cvtr12mOCw8RobxpnLWGHVoBTK4JSIVD0TxfxfNmOep9lKmYa+hRYPRrW9VoGDg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB4510.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(7696005)(2906002)(55016002)(76116006)(54906003)(316002)(4744005)(110136005)(8676002)(122000001)(9686003)(66946007)(66446008)(66556008)(66476007)(71200400001)(64756008)(33656002)(53546011)(4326008)(86362001)(186003)(8936002)(6506007)(38100700002)(5660300002)(38070700005)(508600001)(52536014);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ftnlbCQt1L4vyWPTaGSeTy2fiZ2m39Z+2ZsL6AZBesh/SokSK+bgjSiq1kXG?=
 =?us-ascii?Q?riwoDArVHdQhTiHSueCrgxFAj/92/vZl1JzcvKK086O3gbNkRSojBzIwKTe2?=
 =?us-ascii?Q?phFndaVjxHcLpJtwvDNA+g0+7/WL8ToBNKiCUozgST/TbWLTm/nVhS8GeaoR?=
 =?us-ascii?Q?ddJGmMd6/HPD8NXyClHOsO8nBvgoSoLk1ikQ+Iwxt8X9QNf2YE5WQ8FL/C/c?=
 =?us-ascii?Q?wAz361bj43DwMU+dg1pj/pNfqJFsPmHVsR5eiuSPBMaRqzXsMKSUrXedaFsN?=
 =?us-ascii?Q?Jhq429UWscq2Iu3zwQdQuyAjMLr6O1/hXO9nMUHwjQPuzvhEFxSKuxAp03ip?=
 =?us-ascii?Q?/JZH2yLTGzoj6CNCECLLWbyGEVpvQK7bIw+rZalniwhdtKpjJ+lcnIL9Pdwa?=
 =?us-ascii?Q?gVdcWCx6gF6pkQ0rXeWoKpmRCZt2lsEIQ+k6FXtp0TBqHqnNEyoZPF8xuPqn?=
 =?us-ascii?Q?N4P92sQuODsbJ2lISe+gJH7VcHfd24rMPPn3mDwcrKjBb620+7z0m37f1cMO?=
 =?us-ascii?Q?wA+mIKgU8vq2ohGlFUpM7xEDntY3NBA2yz2+2IJV7mNMjNeDL2ONXBd66E5J?=
 =?us-ascii?Q?GS3nHFM16UQcAoVw57uQRBUvZbo9PMX5enEpleMTB4iblVo8ecAJ5YTDvhbo?=
 =?us-ascii?Q?e5zKJkW9QbJ3MpgjT0D4boU2O27PtM3T0iCQXeVUEmatqvNLsVLspWniLGeF?=
 =?us-ascii?Q?bLQb84skIzGd5gqXfqQv6xiSV0iIA4XyfRdGQov8O9RFNP9IEh3bN9OQMWU7?=
 =?us-ascii?Q?QQcg+rs9PV97V1ZmstPGmewEVZylBU5RQRLYyL7N3chpqXFAoozgTAkV7ja+?=
 =?us-ascii?Q?cAU9+XpqoepLuM4gKvzNIpIBEBbxyzDW1j4vtvafL4MIUk6HspKkON5SHdnK?=
 =?us-ascii?Q?tc5MgQHf3ExpBeOkEoml0ChLesZZ1TzZCmlrwPrE32YI+wdYjUJo/S8++iwW?=
 =?us-ascii?Q?TCy2dsGpOwzXdPE5RBiBrRgkjdX4Mf9EMpUJlrTH/3wGWBicfh6e5u05WYAY?=
 =?us-ascii?Q?oKzWW1pB8XlDyXsn48P0xD0t2Ig5pYvo2BLeIimCTavz9zrT+9iypri82tqA?=
 =?us-ascii?Q?BP2xtLvon6UnY2ZLWOSVeB93s/wCwxuf8cQDy2zXWvd+AK1YXtCscW8vKS1a?=
 =?us-ascii?Q?IprRl0HRSaRsCJ2m1omrmYtGkRYjvCdJq/0ZVQpNivnygYPYr21gI0VwQc+1?=
 =?us-ascii?Q?i9rIwuHkWUhvGrKC8AfJafQeZA3tNVsWttdNB573mlypqbVyhXUqUwo6r4RA?=
 =?us-ascii?Q?wiNYkiplBILltpb6pByFCp1zVQtdDwmPRMhFkGRvudCW1cfj+NVdxQCR/z4e?=
 =?us-ascii?Q?pQTSPxDeXYCo7LBpb7qg0HbWp0wro3VPL0K2BTLUCXjWraxaZNZovLUkruRU?=
 =?us-ascii?Q?McXAf3eW/lHk5+u6lzJqnIepc1R3EYAWwXgwjmqWm/Yq6Bq85GMmoAmMk7Im?=
 =?us-ascii?Q?sAQO1s/lfEmQPrXmTOGzENxaJ11M+7AACRp0I6qV+PDgSssnZyzVBJI6yc8L?=
 =?us-ascii?Q?eugjHU7sCfExck9VxUPirT53E4k3aVtyYCsu1vxbaXxp4a7KklCQPdGkPUtG?=
 =?us-ascii?Q?khkjyqqY60lDXgcpNW2KPGxPbpGVnbE/YvgFaSh5hR60RzHGcrY32CTCiFRv?=
 =?us-ascii?Q?6MlfclALSGeLaXcn7IDewHmBncscI+ZuMJnFtpNBfogtsd2omKZI1adizojC?=
 =?us-ascii?Q?bxC1fQ=3D=3D?=
Content-Type: multipart/alternative;
 boundary="_000_SA0PR12MB4510B9D577B9B4FE3608AD30E28A9SA0PR12MB4510namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4510.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87bcf92f-1bde-4b71-7c20-08d99ce1cd93
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Nov 2021 02:46:27.9289 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MeztLSzPOMcd/brpGIvxInUDRc8t5747z3IXQH29KAsbo0FMULC15G7GgkMcmlN3KNyqUmokA9GhnduHSAXacQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2686
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

--_000_SA0PR12MB4510B9D577B9B4FE3608AD30E28A9SA0PR12MB4510namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[Public]

smu_get_power_profile_mode actually calls smu->ppt_funcs->get_power_profile=
_mode

So shouldn't it be sufficient to do this?

        } else if (DEVICE_ATTR_IS(pp_power_profile_mode)) {
                if (!adev->smu.ppt_funcs->get_power_profile_mode)
                        *states =3D ATTR_STATE_UNSUPPORTED;
        }


From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Saturday, October 30, 2021 10:06
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Limonciello, Mario <Mario.Limonciello@amd.com>; amd-gfx@lists.freedeskt=
op.org; Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: Re: [PATCH] drm/amdgpu/pm: Don't show pp_power_profile_mode for YC=
 and later APUs


[Public]

For swsmu, we could add a helper macro like smu_is_supported(x) that checks=
 if ppt func is not NULL.

Thanks,
Lijo

--_000_SA0PR12MB4510B9D577B9B4FE3608AD30E28A9SA0PR12MB4510namp_
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
<style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:"Fira Code";
	panose-1:2 11 8 9 5 0 0 2 0 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
span.EmailStyle18
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
p.msipheaderc10f11a2, li.msipheaderc10f11a2, div.msipheaderc10f11a2
	{mso-style-name:msipheaderc10f11a2;
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
<p class=3D"msipheaderc10f11a2" style=3D"margin:0in"><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:green">[Public]</s=
pan><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">smu_get_power_profile_mode actually calls smu-&gt;pp=
t_funcs-&gt;get_power_profile_mode<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">So shouldn&#8217;t it be sufficient to do this?<o:p>=
</o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal" style=3D"line-height:14.25pt;background:#1E1E1E"><sp=
an style=3D"font-size:10.5pt;font-family:&quot;Fira Code&quot;;color:#D4D4D=
4">&nbsp; &nbsp; &nbsp; &nbsp; }
</span><span style=3D"font-size:10.5pt;font-family:&quot;Fira Code&quot;;co=
lor:#C586C0">else</span><span style=3D"font-size:10.5pt;font-family:&quot;F=
ira Code&quot;;color:#D4D4D4">
</span><span style=3D"font-size:10.5pt;font-family:&quot;Fira Code&quot;;co=
lor:#C586C0">if</span><span style=3D"font-size:10.5pt;font-family:&quot;Fir=
a Code&quot;;color:#D4D4D4"> (</span><span style=3D"font-size:10.5pt;font-f=
amily:&quot;Fira Code&quot;;color:#569CD6">DEVICE_ATTR_IS</span><span style=
=3D"font-size:10.5pt;font-family:&quot;Fira Code&quot;;color:#D4D4D4">(pp_p=
ower_profile_mode))
 {<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"line-height:14.25pt;background:#1E1E1E"><sp=
an style=3D"font-size:10.5pt;font-family:&quot;Fira Code&quot;;color:#D4D4D=
4">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
</span><span style=3D"font-size:10.5pt;font-family:&quot;Fira Code&quot;;co=
lor:#C586C0">if</span><span style=3D"font-size:10.5pt;font-family:&quot;Fir=
a Code&quot;;color:#D4D4D4"> (!</span><span style=3D"font-size:10.5pt;font-=
family:&quot;Fira Code&quot;;color:#9CDCFE">adev</span><span style=3D"font-=
size:10.5pt;font-family:&quot;Fira Code&quot;;color:#D4D4D4">-&gt;</span><s=
pan style=3D"font-size:10.5pt;font-family:&quot;Fira Code&quot;;color:#9CDC=
FE">smu</span><span style=3D"font-size:10.5pt;font-family:&quot;Fira Code&q=
uot;;color:#D4D4D4">.</span><span style=3D"font-size:10.5pt;font-family:&qu=
ot;Fira Code&quot;;color:#9CDCFE">ppt_funcs</span><span style=3D"font-size:=
10.5pt;font-family:&quot;Fira Code&quot;;color:#D4D4D4">-&gt;</span><span s=
tyle=3D"font-size:10.5pt;font-family:&quot;Fira Code&quot;;color:#9CDCFE">g=
et_power_profile_mode</span><span style=3D"font-size:10.5pt;font-family:&qu=
ot;Fira Code&quot;;color:#D4D4D4">)<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"line-height:14.25pt;background:#1E1E1E"><sp=
an style=3D"font-size:10.5pt;font-family:&quot;Fira Code&quot;;color:#D4D4D=
4">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &n=
bsp; &nbsp; *</span><span style=3D"font-size:10.5pt;font-family:&quot;Fira =
Code&quot;;color:#9CDCFE">states</span><span style=3D"font-size:10.5pt;font=
-family:&quot;Fira Code&quot;;color:#D4D4D4">
 =3D </span><span style=3D"font-size:10.5pt;font-family:&quot;Fira Code&quo=
t;;color:#4FC1FF">ATTR_STATE_UNSUPPORTED</span><span style=3D"font-size:10.=
5pt;font-family:&quot;Fira Code&quot;;color:#D4D4D4">;<o:p></o:p></span></p=
>
<p class=3D"MsoNormal" style=3D"line-height:14.25pt;background:#1E1E1E"><sp=
an style=3D"font-size:10.5pt;font-family:&quot;Fira Code&quot;;color:#D4D4D=
4">&nbsp; &nbsp; &nbsp; &nbsp; }<o:p></o:p></span></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div style=3D"border:none;border-left:solid blue 1.5pt;padding:0in 0in 0in =
4.0pt">
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> Lazar, Lijo &lt;Lijo.Lazar@amd.com&gt; =
<br>
<b>Sent:</b> Saturday, October 30, 2021 10:06<br>
<b>To:</b> Alex Deucher &lt;alexdeucher@gmail.com&gt;<br>
<b>Cc:</b> Limonciello, Mario &lt;Mario.Limonciello@amd.com&gt;; amd-gfx@li=
sts.freedesktop.org; Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;<b=
r>
<b>Subject:</b> Re: [PATCH] drm/amdgpu/pm: Don't show pp_power_profile_mode=
 for YC and later APUs<o:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p style=3D"margin:15.0pt"><span style=3D"font-size:10.0pt;font-family:&quo=
t;Arial&quot;,sans-serif;color:green">[Public]<o:p></o:p></span></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div>
<p class=3D"MsoNormal" style=3D"background:white"><span style=3D"color:#212=
121">For swsmu, we could add a helper macro like smu_is_supported(x) that c=
hecks if ppt func is not NULL.<o:p></o:p></span></p>
</div>
<div id=3D"ms-outlook-mobile-signature">
<div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
<p class=3D"MsoNormal">Thanks,<br>
Lijo<o:p></o:p></p>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_SA0PR12MB4510B9D577B9B4FE3608AD30E28A9SA0PR12MB4510namp_--
