Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32019C433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Nov 2021 06:02:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 00C806E18F;
	Mon, 29 Nov 2021 06:02:25 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2085.outbound.protection.outlook.com [40.107.223.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D76CF6E18F
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Nov 2021 06:02:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EjE1BlWCKKYiMxzJZsSomHAaFK+wuuhCw+HWCN6NrWcQzxKOoa55TJPolU6TnbHccB81FB+cGLPU2ajJhnJYhb1FTGP4AahBzpW0FWZKhBfF3FqvQi/B03gSIMfhzIhuHseSKPujLyI4e8+tnDP2WEc4peHWmgvxayN6Q2sv/kemb+j7M4j84rVQAV/DT1c4TIMFwt41rIQxMzr9DHsu9sYQq7Zoh07JvEvqhwv2qxeEoPJXhECun/4XSNLtdVxwcCZsR8PG7TNu0Qp49wlAZ8nTNqSZVZfs8vAe/fqz1sp7eDnB6/NwcMfE6fukvg1JHo7kyfHASz7C7HyUR+EOYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9eQJm4OmF5zdRpDg3N0w/D63VH/VaItS6eQzv0zQjoU=;
 b=TB+L4njLDwrDXQ9QAsLayShl4cCnA53T71mw8Eh0v+Eax/I3JHw39w4ElByzuzRVcz+qM8fMSfD8xc6YVQykd+rW52KYOURtzpQAH3SfbpQG1Lqwe8swOXJfR4dxf1pCA5c8Qmwv69QTLyODinawllMsSDVszbceq5TWhC6PHfrVX/AD6ywL+u4hhHTPXYPCeh3uBjinmagifYM2LN5hoZbWTqagjm1n+8Sgesab3DSpHIqQpTENfAGHKuu9ybWDV1XnPFfU3FP6wp8GUoMDGtGStkCdfe1oTzqg8S3jYUqt4ey7aKmoOYXgNuDrRxeXT8y6aAEg/NYOQ82laj727w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9eQJm4OmF5zdRpDg3N0w/D63VH/VaItS6eQzv0zQjoU=;
 b=l2auAp5yNpu+ukUcAxzL5XkR7gPWaZnDW6Lz6Pj0xWw/OEP4j8Gv9+z7irtYWd1818KN86vXpAE7PQ20/oycEQ1dFRO3g4G6ar0SEqmgmLHUhN65d6orQV7Nz1nsYEDaTl3ut+0Gbf3u4NJMWejjxgV2FPDG6xLDLI1oLd88zK8=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by BN9PR12MB5241.namprd12.prod.outlook.com (2603:10b6:408:11e::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Mon, 29 Nov
 2021 06:02:21 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::2919:f0f6:40a9:e1c0]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::2919:f0f6:40a9:e1c0%7]) with mapi id 15.20.4713.026; Mon, 29 Nov 2021
 06:02:21 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Yang, Stanley" <Stanley.Yang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Clements, John" <John.Clements@amd.com>,
 "Zhou1, Tao" <Tao.Zhou1@amd.com>
Subject: RE: [PATCH Review 1/1] drm/amdgpu: adjust ip block suspend sequence
 on aldebaran to fix disable smu feature failure
Thread-Topic: [PATCH Review 1/1] drm/amdgpu: adjust ip block suspend sequence
 on aldebaran to fix disable smu feature failure
Thread-Index: AQHX5OXcPecNMj/oVUmt8luQYiI42qwaAotQ
Date: Mon, 29 Nov 2021 06:02:20 +0000
Message-ID: <BN9PR12MB52576122FFB656FA1645CD07FC669@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20211129055627.7886-1-Stanley.Yang@amd.com>
In-Reply-To: <20211129055627.7886-1-Stanley.Yang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-11-29T06:02:18Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=f3cd3a2a-d63c-4fd3-9a18-a65031345d58;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a071b79d-7504-4c84-e018-08d9b2fdceab
x-ms-traffictypediagnostic: BN9PR12MB5241:
x-microsoft-antispam-prvs: <BN9PR12MB524155527B0CB6AD5078A1EEFC669@BN9PR12MB5241.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:37;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PeDjJ32W5fp5ygSEtncRd6vhjrIVifTq7LFXoJ2/9uwUQUCiZGmbQ1KSe5GC9maT+80IdlI/nokpUmaLms5d0u25eNNYFLZpRij16IHJ5HrE7QGV/ryYWRrpY4d5XdsVtvSg01c5jrj/a0zad151sVoQqoYdw+JeKQ7h9AMJu6oaBEOi3emdCGgpwiHM+Yd0oPM8eZUfMV14epb4xJ93PMp9pw7UTZonNgEak4F/dFa5ybJNBjRWQP0uz9XanWow0T1OTdXapO4EsPZu6PCLby3AKxoXYeWMBmuEQ2cWNYFLliw0DEgmn/I6J7UKZaTACS9gbz6WJrfndKsLErMd2XzJ2m9u7imHd4vzcawzd60JA1bOWZ3v4TaAhEs6yb63dvPQp2nbA6mK5XGGOeZ7qCG07WyWhj/0hBoSNh7aZhY7DPd2AbbCrKNhm+wTvxmKrSDe+yWL34qAL+AadezbekOh40dMXU3UhQJKf9wyswqIVP4ZCRqObQxJ7AjfSit2V0xDVzuRkCjkmE/N8ANV+eQKei8RnwA20/4Ni1dYeNfgTjQvLdVGa3O8iC5yIs746FIYWwUsooDIZjYwR/5+mQvSLwIWEn0d0knyGSN9y73jenNQ4o1q3oORbrCQXpet2/yc9ZXQZWgnlFKR/cncFQH5ev8uvDns+0j0BoZ+DLmM0Tp/QKVFcmF2TPbFE7D6hNP8X3I9Nh544Ld7n/wR0Q==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(8676002)(26005)(86362001)(83380400001)(71200400001)(186003)(7696005)(8936002)(53546011)(5660300002)(66556008)(66476007)(66946007)(38100700002)(9686003)(122000001)(76116006)(6636002)(316002)(6506007)(64756008)(55016003)(2906002)(66446008)(38070700005)(15650500001)(966005)(33656002)(52536014)(4326008)(508600001)(110136005)(30864003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?XXqf3yeD63UR8bsBc5hvJpdSIbg6UkdheyiJxDgD0SbnMCsdt/k/WI8jIMTD?=
 =?us-ascii?Q?0hB1XHdnHajvkKRuZ6HucDPTq1LAhlMHAJM7AFBEk9U9cp4SZJ9PszE+ea0N?=
 =?us-ascii?Q?HG/o7/2Ug3Mgj6XHpcUHuRyK8//9ikIvQihBllzfjf8iOEBtj2pFr8zLuMC3?=
 =?us-ascii?Q?6i+yOjRgHS27A6BRNLlWQUji2gnX7j0vg77XQpjweFikAtdR6JIHnAYO4ODM?=
 =?us-ascii?Q?mzHILi3PaHxZ1bTSQTwF3pighttJrLBIUl52AbqwcuD8PtNx+WOdYwPfBUgA?=
 =?us-ascii?Q?UyA/CDPXbsHBjSNnu2Zs3XB5Yw2LNM+E5GHIINYpv7aBfCgAPyDD8bA0U/mn?=
 =?us-ascii?Q?VQtKaKgbdz3CHKqfOBoks+KwsmXLI1CNYMEQhkm+1m+Rq2q4G9eW9U8ukZe2?=
 =?us-ascii?Q?DoFZzobKhUVybtpOgygnocynn9IJizN+GfPadXkcBx3DaY3Z0AGPnLNHVeww?=
 =?us-ascii?Q?rfzC5q4CTfNPA64TtqeVBUb483V8CzWCFT63cl5v+VPx0c5luwkfgknkub/N?=
 =?us-ascii?Q?j4n4SMbso4X6NAgT+TpRmpakOc+PKbogaoZqPwUOY+ffoCxO98m46kMcPPBm?=
 =?us-ascii?Q?vgzJS9xPusWDqqAx5wKuWhG/XnM3nrB73brVG5QJ51SCt54NLS4bDavRtlGa?=
 =?us-ascii?Q?04k0sSIIZYjE+4fGY+0HDLtb3kiFUhd17rNKzlHZFTG5vzob9udnpoeHUg9C?=
 =?us-ascii?Q?rjsK1Hz3K7AjQDOIi20pXpOaYKMNlM+evjRpeaSWWqlQzpmd/WJSeCZ7wtoR?=
 =?us-ascii?Q?fTG2RIARi0RHIURqtbZEdXdsJVWMudAZwnxbjrVhybaRqEnjJ7Q7/ofyBD0A?=
 =?us-ascii?Q?fZmRJNYAKRPqbp1UfN+Q3jAe0/DML3VZ5tf52GIm6yTL3QCIAMtyGInndYwJ?=
 =?us-ascii?Q?EaImAy33A3BTdJxisGZpyu6q6CUBvlwW+Eki3N7//WCBLiXheIyxDHVkTTIo?=
 =?us-ascii?Q?B5muWybJ9fIjttqoyg37uf/p3qauvnK6eKeegdyJ1iM0B4mdq59xqwfmbOlL?=
 =?us-ascii?Q?lXxLC46cVksHgqRqdA8YiZMvnGMFyuoEEY9Sl8CWPor+Pa0SZh/Wb1Bh54v+?=
 =?us-ascii?Q?zvwULBD3N36t+ciQNIB6YD3gJtc2WJtrZh5ow0HaKueA5G1iPMYqT2BEuBJj?=
 =?us-ascii?Q?jIQEg94hKPwq+pRSHVZ0bNFIG8kT7GP0P7tqFfwUSUZTPL3gOaX5rtNBfoAC?=
 =?us-ascii?Q?0GtPZ8E6ZDFHULyovN46MBhvXJT6sjZY8D3/GBcdNGPDcarr1b1BzoOOElcR?=
 =?us-ascii?Q?Zup5qJK/jVuN6dX18sSvKoqp1npAY/AQFr6IyVljYEB5Q3dGMLvIhHjF0RGg?=
 =?us-ascii?Q?yezUlgCqJS+zMpLqRbsfSAkaGvX0v0hI8fybZlyuCna3GI2Plq1Oh0nqrSX9?=
 =?us-ascii?Q?hTZsZBz+XMnspVt0D1/6J5LXkHui2mcfAaaEmqetL0wrWjlDPrAnr3I22kL+?=
 =?us-ascii?Q?UuApO1k7ZrloWiJM/b6KFc1h6rP/n+CO7vDFWY4Z1MlGfJK8hGDa6D0GZRwX?=
 =?us-ascii?Q?/BMt5y2fn3DDMqp4aLF4VQrIrcGqYMg2IZulEnteas3gxatIy9ttQJvHTHf/?=
 =?us-ascii?Q?OSP3cdnxas1GamawjNyM0HCxjhNLBwjxNbg7ftPoZLgT4sLkbskCMGADVxYj?=
 =?us-ascii?Q?U5/BAOEt5KvMND711qvyzvE=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BN9PR12MB52576122FFB656FA1645CD07FC669BN9PR12MB5257namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a071b79d-7504-4c84-e018-08d9b2fdceab
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2021 06:02:21.0121 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cUMnWtnBhGkr7QpVs/wK7o77VVr7RKjzmdi+WvGFLjjm8lXXNq+eFI0WmyKl/0/eSMhMoAdYNgtQalKeHK6N5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5241
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
Cc: "Yang, Stanley" <Stanley.Yang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_BN9PR12MB52576122FFB656FA1645CD07FC669BN9PR12MB5257namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only]

Thanks for the quick turnaround. Please check my comments inline.

In addition, it might be better to shorten the commit tile to "adjust ip bl=
ock add sequence on aldebaran", and add detailed information in commit mess=
age

Something like "to fix disable smu feature failure on aldebaran"

Regards,
Hawking

-----Original Message-----
From: Stanley.Yang <Stanley.Yang@amd.com>
Sent: Monday, November 29, 2021 13:56
To: amd-gfx@lists.freedesktop.org; Zhang, Hawking <Hawking.Zhang@amd.com>; =
Clements, John <John.Clements@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>
Cc: Yang, Stanley <Stanley.Yang@amd.com>
Subject: [PATCH Review 1/1] drm/amdgpu: adjust ip block suspend sequence on=
 aldebaran to fix disable smu feature failure

{
    [  578.019986] amdgpu 0000:23:00.0: amdgpu: GPU reset begin!
    [  583.245566] amdgpu 0000:23:00.0: amdgpu: Failed to disable smu featu=
res.
    [  583.245621] amdgpu 0000:23:00.0: amdgpu: Fail to disable dpm feature=
s!
    [  583.245639] [drm:amdgpu_device_ip_suspend_phase2 [amdgpu]] *ERROR* s=
uspend of IP block <smu> failed -62
    [  583.248504] [drm] free PSP TMR buffer }

Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com<mailto:Stanley.Yang@amd.c=
om>>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_discovery.c
index 4e3669407518..364808f3607f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -1309,10 +1309,13 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_de=
vice *adev)
                }
        }

-       if (likely(adev->firmware.load_type =3D=3D AMDGPU_FW_LOAD_PSP)) {
-               r =3D amdgpu_discovery_set_smu_ip_blocks(adev);
-               if (r)
-                       return r;
+       /* move add smu block after add smda block for aldebaran */
+       if (adev->ip_versions[MP1_HWIP][0] !=3D IP_VERSION(13, 0 ,2)) {
+               if (likely(adev->firmware.load_type =3D=3D AMDGPU_FW_LOAD_P=
SP)) {
[Hawking]: can we merge the condition with "&&"?

+                       r =3D amdgpu_discovery_set_smu_ip_blocks(adev);
+                       if (r)
+                               return r;
+               }
        }

        r =3D amdgpu_discovery_set_display_ip_blocks(adev);
@@ -1327,6 +1330,14 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_dev=
ice *adev)
        if (r)
                return r;

+       if (adev->ip_versions[MP1_HWIP][0] =3D=3D IP_VERSION(13, 0 ,2)) {
+               if (likely(adev->firmware.load_type =3D=3D AMDGPU_FW_LOAD_P=
SP)) {
+                       r =3D amdgpu_discovery_set_smu_ip_blocks(adev);
+                       if (r)
+                               return r;
+               }
+       }
+
        if (adev->firmware.load_type =3D=3D AMDGPU_FW_LOAD_DIRECT &&
            !amdgpu_sriov_vf(adev)) {
[Hawking]: can we merge the condition check with "||"
                r =3D amdgpu_discovery_set_smu_ip_blocks(adev);
--
2.17.1



--_000_BN9PR12MB52576122FFB656FA1645CD07FC669BN9PR12MB5257namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Exchange Server">
<!-- converted from rtf -->
<style><!-- .EmailQuote { margin-left: 1pt; padding-left: 4pt; border-left:=
 #800000 2px solid; } --></style>
</head>
<body>
<font face=3D"Times New Roman" size=3D"3"><span style=3D"font-size:12pt;"><=
a name=3D"_msipheadera4477989"></a>
<div><font face=3D"Arial" size=3D"2" color=3D"blue"><span style=3D"font-siz=
e:10pt;">[AMD Official Use Only]<br>

</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">Than=
ks for the quick turnaround. Please check my comments inline.</span></font>=
</div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">In a=
ddition, it might be better to shorten the commit tile to &#8220;adjust ip =
block add sequence on aldebaran&#8221;, and add detailed information in com=
mit message</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">Some=
thing like &#8220;to fix disable smu feature failure on aldebaran&#8221;</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">Rega=
rds,<br>

Hawking</span></font></div>
<div><font size=3D"2"><span style=3D"font-size:11pt;">&nbsp;</span></font><=
/div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">----=
-Original Message-----<br>

From: Stanley.Yang &lt;Stanley.Yang@amd.com&gt; <br>

Sent: Monday, November 29, 2021 13:56<br>

To: amd-gfx@lists.freedesktop.org; Zhang, Hawking &lt;Hawking.Zhang@amd.com=
&gt;; Clements, John &lt;John.Clements@amd.com&gt;; Zhou1, Tao &lt;Tao.Zhou=
1@amd.com&gt;<br>

Cc: Yang, Stanley &lt;Stanley.Yang@amd.com&gt;<br>

Subject: [PATCH Review 1/1] drm/amdgpu: adjust ip block suspend sequence on=
 aldebaran to fix disable smu feature failure</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">{</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp; [&nbsp; 578.019986] amdgpu 0000:23:00.0: amdgpu: GPU reset b=
egin!</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp; [&nbsp; 583.245566] amdgpu 0000:23:00.0: amdgpu: Failed to d=
isable smu features.</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp; [&nbsp; 583.245621] amdgpu 0000:23:00.0: amdgpu: Fail to dis=
able dpm features!</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp; [&nbsp; 583.245639] [drm:amdgpu_device_ip_suspend_phase2 [am=
dgpu]] *ERROR* suspend of IP block &lt;smu&gt; failed -62</span></font></di=
v>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp; [&nbsp; 583.248504] [drm] free PSP TMR buffer }</span></font=
></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">Sign=
ed-off-by: Stanley.Yang &lt;<a href=3D"mailto:Stanley.Yang@amd.com">Stanley=
.Yang@amd.com</a>&gt;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">---<=
/span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> dri=
vers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 19 +++++++++++++++----</span><=
/font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> 1 f=
ile changed, 15 insertions(+), 4 deletions(-)</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">diff=
 --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_discovery.c</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">inde=
x 4e3669407518..364808f3607f 100644</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">--- =
a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+++ =
b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">@@ -=
1309,10 +1309,13 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device=
 *adev)</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; }</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (likely(adev-&gt;firmware.load_type =
=3D=3D AMDGPU_FW_LOAD_PSP)) {</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; r =3D amdgpu_discovery_set_smu_ip_blocks(adev);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; if (r)</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;</span></fo=
nt></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* move add smu block after add smda bloc=
k for aldebaran */</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;ip_versions[MP1_HWIP][0] !=
=3D IP_VERSION(13, 0 ,2)) {</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; if (likely(adev-&gt;firmware.load_type =3D=3D AMDGPU_FW_LOAD_PSP)) {=
</span></font></div>
<div><font face=3D"Calibri" size=3D"2" color=3D"#4472C4"><span style=3D"fon=
t-size:11pt;">[Hawking]: can we merge the condition with &quot;&amp;&amp;&q=
uot;?</span></font></div>
<div><font size=3D"2"><span style=3D"font-size:11pt;">&nbsp;</span></font><=
/div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_discove=
ry_set_smu_ip_blocks(adev);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)</span></font>=
</div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; return r;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; }</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_discovery_set_dis=
play_ip_blocks(adev);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">@@ -=
1327,6 +1330,14 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device =
*adev)</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; return r;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;ip_versions[MP1_HWIP][0] =3D=
=3D IP_VERSION(13, 0 ,2)) {</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; if (likely(adev-&gt;firmware.load_type =3D=3D AMDGPU_FW_LOAD_PSP)) {=
</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_discove=
ry_set_smu_ip_blocks(adev);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)</span></font>=
</div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; return r;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; }</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;firmware.load_typ=
e =3D=3D AMDGPU_FW_LOAD_DIRECT &amp;&amp;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; !amdgp=
u_sriov_vf(adev)) {</span></font></div>
<div><font face=3D"Calibri" size=3D"2" color=3D"#4472C4"><span style=3D"fon=
t-size:11pt;">[Hawking]: can we merge the condition check with &#8220;||&#8=
221;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; r =3D amdgpu_discovery_set_smu_ip_blocks(adev);</span></f=
ont></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">--</=
span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">2.17=
.1</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font size=3D"2"><span style=3D"font-size:11pt;">&nbsp;</span></font><=
/div>
</span></font>
</body>
</html>

--_000_BN9PR12MB52576122FFB656FA1645CD07FC669BN9PR12MB5257namp_--
