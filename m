Return-Path: <SRS0=IWiu=JT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C44AFC433B4
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Apr 2021 09:52:05 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 525066144D
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Apr 2021 09:52:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 525066144D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D1C066E073;
	Thu, 22 Apr 2021 09:52:04 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2055.outbound.protection.outlook.com [40.107.236.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6E8686E073
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Apr 2021 09:52:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B8pnqhEiw3t5kAWuodqsxchB5wP8VqkA2zGDWsLmsNHtqXNulhrJFd/d6zzv+qqcwstVwTcz90LQgEsSPeGytPRFZMRuiS5C79psFimgInrw4nOyhNBFfteCQT0PMVpF3RmZM5BB6eN39shnMAypqiUeiRTX8vflNyTbw6isxCqjnilPmuGeowseuB8r4+/8FyCJHy3B8E1hR+wT4DeCiiHZq69IuKBlbjZmSi5KFBdAdijc5vTHdDfSiCw+6hIsUL8lJkRNatLfPeRIamFnhsqI+yZfAUMSryn1ftXFtfaW87QX3xxBdm4EjdQKcclSTcGKn49PlN61hh60wBU1/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3omIj0qervSiFkyULY1BnbB7TW3rPt0WMagcpmWRQA8=;
 b=illZSWMYUxHqelzxQgNpt6Ydn23QgZt6BmVj4k5t4Sm9kkF5x3lH031pWop3bAKShrLmnGOeA9IVOzmTZY9ndvKRlWd14q3WZVfD+n0NnwsghflmFpTniyptlTkytxzk/DwyCMWjeaSqfX6BdnFvEMr1A2I0E9nWnNEw08euV4XA10Nh+H4lPlZPaurP4FJzYKaWWOovYPNpA+itdGJUqnlhjBQUQQqu0BJ+WltSTnZiiq/RNSM1UKzVeioaUXP1V2qirpOWVFxhdCdJ3xH2CZRmDiKNolX0QdS2HSIFXb7yacbwmf4oSK7Ipy604jrFpfulPyGYLDk0w2gzJ09dvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3omIj0qervSiFkyULY1BnbB7TW3rPt0WMagcpmWRQA8=;
 b=CW1IPWj1xAZXmR/tCg6eicBHrCZ/uQcgJTiMoHbElqksXzVm3XpPvyZewYgBNiVKCrF/B5FG4Zj3eynEtRmR7s4TxnY1Nmqn04Qp9BQ8IYMPT8roavUsiPleSxvMp3dKdSr3rFxipq4p2C8WzhDXmTh7ckwel557WB2la9lvbN4=
Received: from DM6PR12MB4650.namprd12.prod.outlook.com (2603:10b6:5:1fd::27)
 by DM6PR12MB4652.namprd12.prod.outlook.com (2603:10b6:5:1d6::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.22; Thu, 22 Apr
 2021 09:52:01 +0000
Received: from DM6PR12MB4650.namprd12.prod.outlook.com
 ([fe80::8812:1cd3:be35:6bdd]) by DM6PR12MB4650.namprd12.prod.outlook.com
 ([fe80::8812:1cd3:be35:6bdd%6]) with mapi id 15.20.4042.025; Thu, 22 Apr 2021
 09:52:01 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Feng, Kenneth" <Kenneth.Feng@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amd/amdgpu: add cgls
Thread-Topic: [PATCH] drm/amd/amdgpu: add cgls
Thread-Index: AQHXN1qEtdIYRaOu8UaTkmQNdR8aBKrAS4nx
Date: Thu, 22 Apr 2021 09:52:00 +0000
Message-ID: <DM6PR12MB4650346877CA5D73D22AA7ECB0469@DM6PR12MB4650.namprd12.prod.outlook.com>
References: <20210422093301.922-1-kenneth.feng@amd.com>
In-Reply-To: <20210422093301.922-1-kenneth.feng@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-04-22T09:52:00.188Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ed94f1de-b9d0-4c60-c779-08d9057446b8
x-ms-traffictypediagnostic: DM6PR12MB4652:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB4652640966CC1B95DE950C37B0469@DM6PR12MB4652.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1060;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: v9MTFHtdX+UjLD4fNaPu7RDL3lMhGt+0xw8rWcjgJ4njLFxdXTYX6r9ihU2VT6f1dunsrpJm3Htr/qo9o/gys4M/+c/GUb3TgAx7NNgYhofrAf/W1R2Hzei9klTwCnRPIk4JXx790N5NE1KFDhxDTlH+s8ucwpHoMaI1tNumWy2fNr121evW24AvPjgQoU7CC3uclfp1tb8LIXvI4thvACpTEz8PoA53tOpNoa7hjhpfuAQfV01TMx1Stiw4QlSxUkkcLaDx7f4s5xDvAM+lrYVNpYaG2OmMpVlBMLWC3DV918hIjSfWT9t2PSkcsaU5VD2aN92xU7o0fkLc/m4U1RKJB9XJmEoKSv3juDztqA/VCy6p/T+kTFtiNW0EhNPRt7iBul0bFekZV3p7C3nZNetW+Bs+4RXgHeRuOi58JCCpK7w1Yn0DYt2i65A76VxUCVV9l9onN6fac9gQUsQ6qTsTNPx40euyusUonAF83HrL2zWgA0USFow4r7xH8wz0qFhs+Xvmrbvz37XrnEnMkVn9ymbghRK2h/awQRGa8+kxA2w9Q+keBqRr4yvm6dEyI+hxTZDRARiPlOkwXujQ+fNaJ0xenPofp1rlwgOO8/tpX8PDmNwrOI88ehWmP59ooYtqQpBOs+JXeSL3ziwBnQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4650.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(376002)(346002)(396003)(136003)(366004)(8936002)(2906002)(7696005)(8676002)(6506007)(53546011)(110136005)(9686003)(71200400001)(55016002)(122000001)(19627405001)(33656002)(86362001)(66446008)(45080400002)(38100700002)(76116006)(316002)(478600001)(186003)(26005)(66556008)(966005)(64756008)(5660300002)(66946007)(52536014)(66476007)(91956017)(166002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?wGDTokdEBD9ARGeDQHQBwzM4PRwmHtW8cgx5TfY3KCaTppJ1SREocdSveFPc?=
 =?us-ascii?Q?HLMiZETh/GPOHGsj+wmLza2m9iHJ7Zb0KC1pX6TnCYgwbhPXUu8F5aC/VMbG?=
 =?us-ascii?Q?3xJeXVbmzxVLgQUjESPzLrcJOFaEWo901Agd+P276gCpgNRHWwN0kUkPbTKA?=
 =?us-ascii?Q?aJ9Aonoret3Fa7LTv8uV/23IUj6Cj3g8n8nG9Fiy2zK3BaJ6z3wZxEIYWUn/?=
 =?us-ascii?Q?EsKZ/Lab13qc5fIrx5r9JqckY2zTHaF5dYWK3mjMyNxz5DDthYjy8PN5pABM?=
 =?us-ascii?Q?09eo9NrLeLHAYUcA4x0F9ogfskSqwA+2/32NC7E/YeO8EbExT5WbLfTdyTOH?=
 =?us-ascii?Q?t8s9dECYibZhMzV9sPJbJQTJ24IgWweY4oTF4qxDQHbG4+U7ig66kG73VnMv?=
 =?us-ascii?Q?Nmm9QpeBjVICkjNZvomJOP1VeHWvPyWg0z40vYCAypC0jfGyu01Vr5YuW1ep?=
 =?us-ascii?Q?RT2herP5GFwfcd9XOzIC2VyGQ/nwQ/wKxEeoaoiqtv059XFOvt0ygrs6z5xj?=
 =?us-ascii?Q?uwDKUH8KEv0f+q2IoxpHVCv76e0oQvQACFqRaAIK57PIpHAL9iosvxjwEL+g?=
 =?us-ascii?Q?OO4hNmflEHSitMX/ZvDyxFTajr+HwANFUG068R/lf3ijAekE8tvz/Oal02fh?=
 =?us-ascii?Q?emcFYTVSREBg52se4An+6GjGCCrVkU1d2FUeMwvM+6BHSBPbQ6f/bAq0fMhA?=
 =?us-ascii?Q?oj8RbqKxkhksx/ACfIEl1F7j4I9Pf4PZtTxoio/GWDM3LJYXVAgUuZeeSNwq?=
 =?us-ascii?Q?7b6BjBzciXHrBTPYlsx72P42rn6hm90X7APxPJyvBYW4s9iAh39c4TfhbGpv?=
 =?us-ascii?Q?oWZ8WfwAt7vJiPl49JDwHCo4K/f4sGvr8aZH/xJkjiLMnmH8d5P5ORI6rqfk?=
 =?us-ascii?Q?HzAqUhspEDN8tr8toGChARVHzzNhrtbUUHKaZREQp0sAAixH58erMJv05WHE?=
 =?us-ascii?Q?Z9swcQqwcJSzkTMVl1+PRW7ERT1frPr4H4SbyFQAwjZlI/ELiwNwQi98ba63?=
 =?us-ascii?Q?3x4qaa23v8o29rP6C+SOnFT30lNOY/cir6xVD0Kjk/+TiPw8vY1BmJxkiKpy?=
 =?us-ascii?Q?uHw5UD8Gh5uOcNemLKpElQaAnw17Xy2ocaBVYDnV9U5Bi6cqsEN+Xk7R7hTv?=
 =?us-ascii?Q?bQaaXbSpvOOsoh0CroeaoaHjYVztYWoqNOG0lJmvJwBwmQknVjDdo3N4NoMs?=
 =?us-ascii?Q?uExZEjWL8F17Xu18tR9cHgK6flhubtdNsmjKvkRwS0PQE7NGrTZCuvkCHcZ7?=
 =?us-ascii?Q?FVmy78MIwb4/K8rWnaQiRGVtdyDH/uGvN1LmGFWI+XS2IeoO5/t81XtYsMZF?=
 =?us-ascii?Q?nGA=3D?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4650.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed94f1de-b9d0-4c60-c779-08d9057446b8
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2021 09:52:00.8976 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rP1qYLtLs0L+YMI0OqqlLv6YUDk9bEto1c4r/8jelXkBVEvDcGHioXbSnjcav7jn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4652
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
Content-Type: multipart/mixed; boundary="===============1244310727=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1244310727==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_DM6PR12MB4650346877CA5D73D22AA7ECB0469DM6PR12MB4650namp_"

--_000_DM6PR12MB4650346877CA5D73D22AA7ECB0469DM6PR12MB4650namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

Reviewed-by: Tao Zhou <tao.zhou1@amd.com<mailto:tao.zhou1@amd.com>>
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Kenneth =
Feng <kenneth.feng@amd.com>
Sent: Thursday, April 22, 2021 5:33 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Feng, Kenneth <Kenneth.Feng@amd.com>
Subject: [PATCH] drm/amd/amdgpu: add cgls

enable cgls to improve the runtime power efficiency.

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nv.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/n=
v.c
index 0142f6760ad2..9c4f232e81c0 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -1065,6 +1065,7 @@ static int nv_common_early_init(void *handle)
         case CHIP_SIENNA_CICHLID:
                 adev->cg_flags =3D AMD_CG_SUPPORT_GFX_MGCG |
                         AMD_CG_SUPPORT_GFX_CGCG |
+                       AMD_CG_SUPPORT_GFX_CGLS |
                         AMD_CG_SUPPORT_GFX_3D_CGCG |
                         AMD_CG_SUPPORT_MC_MGCG |
                         AMD_CG_SUPPORT_VCN_MGCG |
@@ -1088,6 +1089,7 @@ static int nv_common_early_init(void *handle)
         case CHIP_NAVY_FLOUNDER:
                 adev->cg_flags =3D AMD_CG_SUPPORT_GFX_MGCG |
                         AMD_CG_SUPPORT_GFX_CGCG |
+                       AMD_CG_SUPPORT_GFX_CGLS |
                         AMD_CG_SUPPORT_GFX_3D_CGCG |
                         AMD_CG_SUPPORT_VCN_MGCG |
                         AMD_CG_SUPPORT_JPEG_MGCG |
@@ -1130,6 +1132,7 @@ static int nv_common_early_init(void *handle)
         case CHIP_DIMGREY_CAVEFISH:
                 adev->cg_flags =3D AMD_CG_SUPPORT_GFX_MGCG |
                         AMD_CG_SUPPORT_GFX_CGCG |
+                       AMD_CG_SUPPORT_GFX_CGLS |
                         AMD_CG_SUPPORT_GFX_3D_CGCG |
                         AMD_CG_SUPPORT_VCN_MGCG |
                         AMD_CG_SUPPORT_JPEG_MGCG |
--
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D04%7C01%7Ctao.zhou=
1%40amd.com%7C7a505b4ac545404e698608d90571a5d9%7C3dd8961fe4884e608e11a82d99=
4e183d%7C0%7C0%7C637546807949920387%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjA=
wMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3DuBcy=
z4X3dI8%2BrrHTdZXmA1GIE2nYiBKdAlP00x7JOwg%3D&amp;reserved=3D0

--_000_DM6PR12MB4650346877CA5D73D22AA7ECB0469DM6PR12MB4650namp_
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
<p style=3D"font-family:Arial;font-size:11pt;color:#0078D7;margin:5pt;" ali=
gn=3D"Left">
[AMD Official Use Only - Internal Distribution Only]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<span style=3D"color:black;font-size:12pt;font-family:Calibri,sans-serif;ba=
ckground-color:white">Reviewed-by: Tao Zhou &lt;<a href=3D"mailto:tao.zhou1=
@amd.com" target=3D"_blank" rel=3D"noopener noreferrer" data-auth=3D"NotApp=
licable" data-linkindex=3D"0">tao.zhou1@amd.com</a>&gt;</span><br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Kenneth Feng &lt;kenneth.feng=
@amd.com&gt;<br>
<b>Sent:</b> Thursday, April 22, 2021 5:33 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Feng, Kenneth &lt;Kenneth.Feng@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amd/amdgpu: add cgls</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">enable cgls to improve the runtime power efficienc=
y.<br>
<br>
Signed-off-by: Kenneth Feng &lt;kenneth.feng@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/nv.c | 3 +++<br>
&nbsp;1 file changed, 3 insertions(+)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/n=
v.c<br>
index 0142f6760ad2..9c4f232e81c0 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/nv.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c<br>
@@ -1065,6 +1065,7 @@ static int nv_common_early_init(void *handle)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_SIENNA_CICHLID:<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; adev-&gt;cg_flags =3D AMD_CG_SUPPORT_GFX_MGCG |<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMD_C=
G_SUPPORT_GFX_CGCG |<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMD_CG_SUPPORT_G=
FX_CGLS |<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMD_C=
G_SUPPORT_GFX_3D_CGCG |<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMD_C=
G_SUPPORT_MC_MGCG |<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMD_C=
G_SUPPORT_VCN_MGCG |<br>
@@ -1088,6 +1089,7 @@ static int nv_common_early_init(void *handle)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_NAVY_FLOUNDER:<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; adev-&gt;cg_flags =3D AMD_CG_SUPPORT_GFX_MGCG |<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMD_C=
G_SUPPORT_GFX_CGCG |<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMD_CG_SUPPORT_G=
FX_CGLS |<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMD_C=
G_SUPPORT_GFX_3D_CGCG |<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMD_C=
G_SUPPORT_VCN_MGCG |<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMD_C=
G_SUPPORT_JPEG_MGCG |<br>
@@ -1130,6 +1132,7 @@ static int nv_common_early_init(void *handle)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_DIMGREY_CAVEFISH=
:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; adev-&gt;cg_flags =3D AMD_CG_SUPPORT_GFX_MGCG |<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMD_C=
G_SUPPORT_GFX_CGCG |<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMD_CG_SUPPORT_G=
FX_CGLS |<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMD_C=
G_SUPPORT_GFX_3D_CGCG |<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMD_C=
G_SUPPORT_VCN_MGCG |<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMD_C=
G_SUPPORT_JPEG_MGCG |<br>
-- <br>
2.17.1<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx@lists.freedesktop.org<br>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D04%=
7C01%7Ctao.zhou1%40amd.com%7C7a505b4ac545404e698608d90571a5d9%7C3dd8961fe48=
84e608e11a82d994e183d%7C0%7C0%7C637546807949920387%7CUnknown%7CTWFpbGZsb3d8=
eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&a=
mp;amp;sdata=3DuBcyz4X3dI8%2BrrHTdZXmA1GIE2nYiBKdAlP00x7JOwg%3D&amp;amp;res=
erved=3D0">https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D04%=
7C01%7Ctao.zhou1%40amd.com%7C7a505b4ac545404e698608d90571a5d9%7C3dd8961fe48=
84e608e11a82d994e183d%7C0%7C0%7C637546807949920387%7CUnknown%7CTWFpbGZsb3d8=
eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&a=
mp;amp;sdata=3DuBcyz4X3dI8%2BrrHTdZXmA1GIE2nYiBKdAlP00x7JOwg%3D&amp;amp;res=
erved=3D0</a><br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_DM6PR12MB4650346877CA5D73D22AA7ECB0469DM6PR12MB4650namp_--

--===============1244310727==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1244310727==--
