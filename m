Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 499BEC28D13
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Aug 2022 07:34:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 992E611B6D5;
	Thu, 25 Aug 2022 07:33:58 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2041.outbound.protection.outlook.com [40.107.94.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C8A5511B6D5
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Aug 2022 07:33:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HVnkhLqSHJgexFk/Mq+OIMAyI0q4rnJVXdYu2ufp/sYycsNxCNZkRQwZlSYBWW+hABV6f+XpMsKYcNAbgVN7rWt5UUYWqpPMMi83zJhPUoCTz6y58FN3RIgKM5uxjMa5Vd2IfhnnsatTHKpEUTjc8c4MnInpd13+d+gGQraB1VXTp72B35kMh21zREEv+7ETfQq6Fw/QngHPVbNf27UC1ocjQjvc9yW+/xdEfq7BxHuyVKEo0AEzSBkLbrVxjapqBIxFBAGUnW2deOijec6okJUCLedHKLP1JHeKlBSa362xvdqvFh1kp3Hz3PVC4G4WyRgiJ0SYtUaa6Xa01WwMdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lSuLr+k+EM1SgkbQWZziQhNfYBuofSnNFQuuJ2ENQIQ=;
 b=X86o4qEtwUpL6vFqH4BPEkXPDVIF5zis0kki6tLAxdioTEs35sBmdE61Ho9ysaoUQTRNGJTUbtlS6PBBKf541Ez9QRw405q2H81gxFZseU9JYjxK+Zu5M/qRPqDmsrpgjbhgYH4ydHF/qkQzVDRa/OVsq7gXJZGDIvK3IP1wlH7pz8DWWYsJLTlzUINLkhRgWJmXqaqJG8d0hU1jUzj5xN/5Slx64qbAuOdUBU7401B41x+PdqYV+eJfw1biftmb1IfjVg28E8tO1MdOTgXEA7/kLJ6QL8WLndHwoO9bUkjtAWXoD1N+VFby1F1V0vLcyeZa1OKbIFs2dKKVeNGwJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lSuLr+k+EM1SgkbQWZziQhNfYBuofSnNFQuuJ2ENQIQ=;
 b=Z8sGRZhBRUpnJI4aHSH62KpEn1pE3v2AVVUD1Sf6sQkFKw3kU9b7/GYy9dnm5Xn3TZBbMQvBksM9tHKfdkn103Duo61Pv4FkPVNJ6K1qDJN2KEarmxd6CHlM1RTfK1jCdYDxci85Ok0S55/apxwfCk8s3aq2zhlgiDxXkU/hSDw=
Received: from BL1PR12MB5254.namprd12.prod.outlook.com (2603:10b6:208:31e::21)
 by SA1PR12MB7365.namprd12.prod.outlook.com (2603:10b6:806:2ba::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.20; Thu, 25 Aug
 2022 01:03:31 +0000
Received: from BL1PR12MB5254.namprd12.prod.outlook.com
 ([fe80::3dab:9d05:5a0f:185f]) by BL1PR12MB5254.namprd12.prod.outlook.com
 ([fe80::3dab:9d05:5a0f:185f%4]) with mapi id 15.20.5546.022; Thu, 25 Aug 2022
 01:03:31 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Chai, Thomas" <YiPeng.Chai@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 1/2] drm/amdgpu: The call to amdgpu_xgmi_remove_device
 needs to be earlier than psp_hw_fini
Thread-Topic: [PATCH 1/2] drm/amdgpu: The call to amdgpu_xgmi_remove_device
 needs to be earlier than psp_hw_fini
Thread-Index: AQHYrivZQ1ZxQc5EMEu67MeMVCuf/a2vjbKAgA9Sbsg=
Date: Thu, 25 Aug 2022 01:03:31 +0000
Message-ID: <BL1PR12MB52542FCD1700739645466A7DFC729@BL1PR12MB5254.namprd12.prod.outlook.com>
References: <20220812091317.338637-1-YiPeng.Chai@amd.com>
 <CH2PR12MB4215CBF380BB28417AB5C82AFC689@CH2PR12MB4215.namprd12.prod.outlook.com>
In-Reply-To: <CH2PR12MB4215CBF380BB28417AB5C82AFC689@CH2PR12MB4215.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=True;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-08-15T07:02:43.0000000Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2e3f10a8-f26d-472e-a26a-08da8635a0e3
x-ms-traffictypediagnostic: SA1PR12MB7365:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4OKKsd6XQJVV4BBCJFXbt2stD7HjcAGa6jEvAW0p/RLaPP4cOvzG3tPXoG6GNYGTvbSS49QcHumzc3xBK+WsSejnLGRATrqYLogigkhAA5FkenqxKvBOJ/3JrsuY0tcw7A6/Gvg0QqHsrZe5Mf+t7pyDwBy18Z14J2JLKO/PkTJuUBaMCA6uuutxltQ7+Czf5JCQAHNI4x9+EeYpSmOJ9bF/qA8rbP13HhOD+b+ZkYN/4EFvrd6IqmP7HsKp0+JslDn6bX7MUlbBp2oapSYJSMKTCE9+jhYu0/eHJ10q8+xmjNvmDyX20OXYW0tq8TJdCDxpEvD2AXg+gFb2N+1HUcCDLgLlD8RcA9PPBHUww7B/KPL4oXG4dquJchwKuDz+zkmzCLlG7n7TOSdfNxr0s7iFH+090ClSxs4701MIso6vgRKAkjTKkNMMEpHjIat1kSNA0ASgTRbxZTisO/ye3ydUAI5Y22MBPokpTCJj7ND+Ob0pGEsUqAxf11dmvWd+inuJ05mVtaUGQ3ewuAiLTxxHskO3swM33DYHWg5oACpHc/RKe0GaDWpz6yJBg/xOygNvw3O2NX2fPQzsFbX7AaAg1O3WMjp1bvAYLOpwHAxD4avtWZz1c+DIjzk7RcDq0lotMn/bc++y7gCsMPJk85bW8JFtHE8YEGE6k+3aIjIl9tmaIoJeFlN6hYv+cWdiJGZ66GZRfNKV1Tl6R1e3qL07jMiTqBY9jBaYlLHd9AStNZV3ueX3OabPs+x6hC0hTcPF1kPtEsdu9errYwniiA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5254.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(376002)(366004)(396003)(39860400002)(346002)(136003)(122000001)(52536014)(8936002)(8676002)(64756008)(2906002)(66446008)(66476007)(76116006)(7696005)(110136005)(66556008)(66946007)(4326008)(53546011)(6506007)(9686003)(26005)(316002)(55016003)(5660300002)(33656002)(71200400001)(41300700001)(478600001)(83380400001)(91956017)(186003)(38100700002)(86362001)(38070700005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?lUxvExST1FUDl1i0kE86Sg9WFUw95ywtIWWKu/qbWll1xm3wsNo5YG9k4tp2?=
 =?us-ascii?Q?xkW6Wl9Y5X2dMRbDGKCFo9qLRWeqWcu7ivcukTclDlNdPn27S66BMYGjryYW?=
 =?us-ascii?Q?KbrkdgtysnBy6yo13xAv+Mf0oxHgIgtofBWIOgevOiGsKsVEoHCPKGPijdyN?=
 =?us-ascii?Q?Fax15p9QRRbi00ElPrK0+/o+bH6G8nvF1Td/n/PfRWPbb/d2EOQctWROUxcr?=
 =?us-ascii?Q?DERWPE3ZsRnf+kj4bVRvVIQHPPwI8PT8csTYl/p+1MjAeIdK18Rr1WPUdmZ0?=
 =?us-ascii?Q?srZ25Z/C0vOO3Qp4jdmmgrBxYg45w/DRtAIYGosftwsUFBE2zTm9QQwMoEp2?=
 =?us-ascii?Q?xOZxDb6kwTovemT4s40sj5Usb15D3MvI5qE2MKTZd0/FjskMLJiASHtMcN+U?=
 =?us-ascii?Q?b+tUL8As/B5kKrthf4l6lIm7BMpNp9MUygK8KpxGpghArslfxbz3dY1/UxTR?=
 =?us-ascii?Q?x0lHZIUPPPpNLJtMgHBFt2l4L2FpNnPQZzB2Ed8vNvTPbI6XO6IJRlxPtnZe?=
 =?us-ascii?Q?UehoOvugVGr8bsjTberXLJycIPq+PBf2fjP2zlQvwVH9SgoKAQQR1t2i+UP2?=
 =?us-ascii?Q?QP328rV6jEDFfFYSq0r56/tLTqXrsuT5fvPETLcEMrjMDwOkcAVhotN4YQSN?=
 =?us-ascii?Q?CLtS4P+VBPJh1XM7nSo05XSZlMu8h6hvvcSamnSIVztCjfBUz+tYaH6oVAhH?=
 =?us-ascii?Q?KgKzheR7vNhlbXAsU8BkPP0ZAVr9r7e8C2vYNaPN7earSh7kyUN4ugKda3fw?=
 =?us-ascii?Q?V6Lnrq8Tn40VoimgKyzFakkzQxyCF77D+A2ugN/JHrmyppu4RJCksA5ifh86?=
 =?us-ascii?Q?6720lAFmMUSV2BXDk8HNsI+g5ibK2kv1bmSocRJZakNCBNo7OPI9YLtyBYKi?=
 =?us-ascii?Q?cX9tw2xkyq4pB6xui+Fzy45xCejMWycnE2OkJj6ZBvbGb/F6ePWcUyNt6Jq4?=
 =?us-ascii?Q?JUhQNV+rW+oVQiZevVjQU9T56RArexEFQPYM/FIgEIUhtCI4YAzN9KzO/HFg?=
 =?us-ascii?Q?DFUknJjz1n8BXhbzWvOzX7P2DsBJdHSm/2CGC2lsvwOZsBPoefweLnfpHkXO?=
 =?us-ascii?Q?OrecvanMXO2SD/nNNr1i2S4bSzVJvZhbmriCXtCRfzVMYlqznBhat/YK2jV+?=
 =?us-ascii?Q?FI9QlUCQ/4JzcmDppIkrxJrho1yMhg6IhZc+YbG4SIchm77Hxy8ibhvms756?=
 =?us-ascii?Q?8AMbCvX1HzcGSniVZBZ0I0bJz2NM3TTy7xjPhl2T1E7MjNxv3FV1aWUu/NLr?=
 =?us-ascii?Q?4qa5OMsmj0t7rbvADrJTdBiwY7q5QGTLPyE+TcPND1sDl4sWGUIdpygRKtxl?=
 =?us-ascii?Q?raDYMxqN6503vowooEfjGUENnKBEDwzao3YXbRy9N6o88C1WCqVt6LbislTT?=
 =?us-ascii?Q?D0GPugnbs+aSdXsIKoJZxL8FoaNo3aibtqi6hCouTPHuUTpEMZNdOfbCJ80v?=
 =?us-ascii?Q?MkI5RjIN8MrC/DThXoouNj+ZSlJwlmsaWcexXbK0okr7MKiWnBpvkxa0y7E8?=
 =?us-ascii?Q?R31KodowvD/aYnQSPdFkguFBpB2xnk2zgiPEh3f26Okl1BvkGATD18icOy8H?=
 =?us-ascii?Q?/dK8ZrE1VHuMSGtg1N2jTcBbAzQ6QiTWD4WFnOq4Xdj1OD5OIslkTuRtwnSw?=
 =?us-ascii?Q?eA=3D=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB52542FCD1700739645466A7DFC729BL1PR12MB5254namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5254.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e3f10a8-f26d-472e-a26a-08da8635a0e3
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2022 01:03:31.6695 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gEShC7M6uXIU6KIupXP0U+5VP+uqnK/e0DmxyKeW0wMgpQWjmx1cfknOCqhWONSPjSiQlIg5ASK0Qjn49+R+dQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7365
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
Cc: "Wang, Yang\(Kevin\)" <KevinYang.Wang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_BL1PR12MB52542FCD1700739645466A7DFC729BL1PR12MB5254namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

I thought I reviewed this one together with another one from you that fixed=
 hive refcount leak. You sent them in series.

Anyway, go ahead to submit with my RB.

Thanks.

Regards,
Hawking

From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Chai, Th=
omas <YiPeng.Chai@amd.com>
Date: Thursday, August 25, 2022 at 00:37
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>, Zhang, Hawking <Hawking.Zha=
ng@amd.com>
Subject: RE: [PATCH 1/2] drm/amdgpu: The call to amdgpu_xgmi_remove_device =
needs to be earlier than psp_hw_fini
[AMD Official Use Only - General]

Ping on this series.

-----Original Message-----
From: Chai, Thomas <YiPeng.Chai@amd.com>
Sent: Friday, August 12, 2022 5:13 PM
To: amd-gfx@lists.freedesktop.org
Cc: Chai, Thomas <YiPeng.Chai@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.c=
om>; Wang, Yang(Kevin) <KevinYang.Wang@amd.com>; Chai, Thomas <YiPeng.Chai@=
amd.com>
Subject: [PATCH 1/2] drm/amdgpu: The call to amdgpu_xgmi_remove_device need=
s to be earlier than psp_hw_fini

The amdgpu_xgmi_remove_device function will send unload command to psp thro=
ugh psp ring to terminate xgmi, but psp ring has been destroyed in psp_hw_f=
ini.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c
index c84fdef0ac45..2445255bbf01 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2787,6 +2787,9 @@ static int amdgpu_device_ip_fini_early(struct amdgpu_=
device *adev)

         amdgpu_amdkfd_suspend(adev, false);

+       if (adev->gmc.xgmi.num_physical_nodes > 1)
+               amdgpu_xgmi_remove_device(adev);
+
         /* Workaroud for ASICs need to disable SMC first */
         amdgpu_device_smu_fini_early(adev);

@@ -2830,9 +2833,6 @@ static int amdgpu_device_ip_fini(struct amdgpu_device=
 *adev)
         if (amdgpu_sriov_vf(adev) && adev->virt.ras_init_done)
                 amdgpu_virt_release_ras_err_handler_data(adev);

-       if (adev->gmc.xgmi.num_physical_nodes > 1)
-               amdgpu_xgmi_remove_device(adev);
-
         amdgpu_amdkfd_device_fini_sw(adev);

         for (i =3D adev->num_ip_blocks - 1; i >=3D 0; i--) {
--
2.25.1

--_000_BL1PR12MB52542FCD1700739645466A7DFC729BL1PR12MB5254namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" xmlns:w=3D"urn:sc=
hemas-microsoft-com:office:word" xmlns:m=3D"http://schemas.microsoft.com/of=
fice/2004/12/omml" xmlns=3D"http://www.w3.org/TR/REC-html40">
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
	{font-family:DengXian;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:"\@DengXian";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:10.0pt;
	font-family:"Calibri",sans-serif;}
span.EmailStyle19
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style>
</head>
<body lang=3D"EN-US" link=3D"#0563C1" vlink=3D"#954F72" style=3D"word-wrap:=
break-word">
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">I thought I reviewe=
d this one together with another one from you that fixed hive refcount leak=
. You sent them in series.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt"><o:p>&nbsp;</o:p></=
span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">Anyway, go ahead to=
 submit with my RB.
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt"><o:p>&nbsp;</o:p></=
span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">Thanks.<o:p></o:p><=
/span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt"><o:p>&nbsp;</o:p></=
span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">Regards,<br>
Hawking<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt"><o:p>&nbsp;</o:p></=
span></p>
<div style=3D"border:none;border-top:solid #B5C4DF 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><b><span style=3D"fon=
t-size:12.0pt;color:black">From:
</span></b><span style=3D"font-size:12.0pt;color:black">amd-gfx &lt;amd-gfx=
-bounces@lists.freedesktop.org&gt; on behalf of Chai, Thomas &lt;YiPeng.Cha=
i@amd.com&gt;<br>
<b>Date: </b>Thursday, August 25, 2022 at 00:37<br>
<b>To: </b>amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc: </b>Wang, Yang(Kevin) &lt;KevinYang.Wang@amd.com&gt;, Zhang, Hawking=
 &lt;Hawking.Zhang@amd.com&gt;<br>
<b>Subject: </b>RE: [PATCH 1/2] drm/amdgpu: The call to amdgpu_xgmi_remove_=
device needs to be earlier than psp_hw_fini<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[AMD Official Use O=
nly - General]<br>
<br>
Ping on this series.<br>
<br>
-----Original Message-----<br>
From: Chai, Thomas &lt;YiPeng.Chai@amd.com&gt; <br>
Sent: Friday, August 12, 2022 5:13 PM<br>
To: amd-gfx@lists.freedesktop.org<br>
Cc: Chai, Thomas &lt;YiPeng.Chai@amd.com&gt;; Zhang, Hawking &lt;Hawking.Zh=
ang@amd.com&gt;; Wang, Yang(Kevin) &lt;KevinYang.Wang@amd.com&gt;; Chai, Th=
omas &lt;YiPeng.Chai@amd.com&gt;<br>
Subject: [PATCH 1/2] drm/amdgpu: The call to amdgpu_xgmi_remove_device need=
s to be earlier than psp_hw_fini<br>
<br>
The amdgpu_xgmi_remove_device function will send unload command to psp thro=
ugh psp ring to terminate xgmi, but psp ring has been destroyed in psp_hw_f=
ini.<br>
<br>
Signed-off-by: YiPeng Chai &lt;YiPeng.Chai@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 6 +++---<br>
&nbsp;1 file changed, 3 insertions(+), 3 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c<br>
index c84fdef0ac45..2445255bbf01 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
@@ -2787,6 +2787,9 @@ static int amdgpu_device_ip_fini_early(struct amdgpu_=
device *adev)<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_amdkfd_suspend(adev=
, false);<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;gmc.xgmi.num_physical_no=
des &gt; 1)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; amdgpu_xgmi_remove_device(adev);<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Workaroud for ASICs nee=
d to disable SMC first */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_device_smu_fini_ear=
ly(adev);<br>
&nbsp;<br>
@@ -2830,9 +2833,6 @@ static int amdgpu_device_ip_fini(struct amdgpu_device=
 *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(adev) =
&amp;&amp; adev-&gt;virt.ras_init_done)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; amdgpu_virt_release_ras_err_handler_data(adev);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;gmc.xgmi.num_physical_no=
des &gt; 1)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; amdgpu_xgmi_remove_device(adev);<br>
-<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_amdkfd_device_fini_=
sw(adev);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D adev-&gt;num_ip=
_blocks - 1; i &gt;=3D 0; i--) {<br>
--<br>
2.25.1<o:p></o:p></span></p>
</div>
</div>
</body>
</html>

--_000_BL1PR12MB52542FCD1700739645466A7DFC729BL1PR12MB5254namp_--
