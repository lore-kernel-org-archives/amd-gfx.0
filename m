Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D291C32771
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Sep 2022 17:44:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A952A10E51C;
	Wed, 28 Sep 2022 17:44:16 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2063.outbound.protection.outlook.com [40.107.93.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0037610E51C
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Sep 2022 17:44:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JKI+Xi44+0Rrnsd+GtZQLd9Sh4OgxBKja8HdUDv3Bza6cFI8PRK2kKPHGdiJef14DUTcKZjJs7l9P8GI+POib+y+ERge+63cOuYhvc5qj3qn1CBmkJ406m2Xr3JPlRiH2Y6Te6sxrCkBgn1bo45lHi9kil0kC1Iup9kCrzO7IKVA+T1h/A5TotwJUXbU521vkBDfcfgOt5pku36si8XmYykokgVlIXMTOAInpuHRKrpWdfpr2K+AhHUv1fPuINVgGuwliVZ+mQISGa9ATUPHPc+XJsfEora5nikJ6wEV1Ldw0HnVKtbx73TrkbCFUVQi4Zq3IRWm5/rpAkYOxdxuvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y6UqRpDxeCSWUJ9qV3xF+1uk0TRy6SNjad4DUqWSQz8=;
 b=PHWFX93aRZBcfsh2174834lkGJdSgirJJcs/tE0CQlLoDHXlwyUSy+w2ylWILj+/oeSigRrKFA1n7DU2DOvnhdZ/EILgRXO4IaswBs5WnJtx1Z0sZMSWo82byR9dVDiNOuLKMvnQQb0O9ywyNqsXWsUlGtezcZT3oyv33A6boLtebt7T/98SIcYgreYk2LVnRLOerZZ0fkJ6eEtV5vElWFDJVrPCFFKl63J/MfVc6G55wAbEPPaSLMLCHS9ietG54T0j47MkcpdO21DawA2dFbF9RYWUbrEH+O4sEMSmMzkUUdgwBAqPkEjnDYhTK6GpohtfG5i7i9O+kmqrNKn7mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y6UqRpDxeCSWUJ9qV3xF+1uk0TRy6SNjad4DUqWSQz8=;
 b=UM2Xq5GULNENKhDPTUPxQ9ZHUfo+CBOFV8g93BWVPsGj3cRRrFJRUky3+BlJwp/32Pw4TZrpbV1ZrOv45cWKJInlqb0jZ0Yh78cmJcneyvc5lHN8pXWII5qn8RfZR++1lTp8SBOTc38jj7/aADKOiV0w4u74f+OL+3AlKfw10C8=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by DS7PR12MB6216.namprd12.prod.outlook.com (2603:10b6:8:94::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5676.17; Wed, 28 Sep 2022 17:44:12 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::f5f8:4688:2e04:4769]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::f5f8:4688:2e04:4769%3]) with mapi id 15.20.5676.017; Wed, 28 Sep 2022
 17:44:12 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>, "Zhang, Hawking"
 <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Gao, Likun" <Likun.Gao@amd.com>
Subject: Re: RE: [PATCH 09/10] drm/amdgpu/gfx10: switch to
 amdgpu_gfx_rlc_init_microcode
Thread-Topic: RE: [PATCH 09/10] drm/amdgpu/gfx10: switch to
 amdgpu_gfx_rlc_init_microcode
Thread-Index: AQHYySTmzdfGVhRC30Ol5CiEa32oJq3tlpLygACh2QCABvf1AIAAAPao
Date: Wed, 28 Sep 2022 17:44:12 +0000
Message-ID: <BL1PR12MB5144E1AA8FE0EDCCCA8B12ACF7549@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20220915170135.23060-1-Hawking.Zhang@amd.com>
 <20220915170135.23060-10-Hawking.Zhang@amd.com>
 <BL1PR12MB514443C746109B972824368BF7519@BL1PR12MB5144.namprd12.prod.outlook.com>
 <BN9PR12MB5257828CD0C0CE680B14D27CFC509@BN9PR12MB5257.namprd12.prod.outlook.com>
 <8a383215-4a8a-243c-6cef-6e7fc12af001@collabora.com>
In-Reply-To: <8a383215-4a8a-243c-6cef-6e7fc12af001@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=True;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-09-28T17:44:11.565Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|DS7PR12MB6216:EE_
x-ms-office365-filtering-correlation-id: f53ea69a-d63a-4f47-d797-08daa1790dcd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1X3NEQdm87pd9/9ooFEsJCJbpe1DNNlJ4Gmnj7fbhuUaC8UPNs+Te43p41mCB2tfhI71s+4tp96gf+rQ/UAslIGHkv23hLJfLew54ljWm6GNwqX2AaOjO0esJahSxVF9w2aBMWmdyPPUl9S0dbPCa8PxBfTNKnlqQC/d3FeeJVMy2o3vc6r5YZ4zMJmxQNVSgTkdYUVlZZNRY+N4E8fTErra8oTruHy4Ptqs23bIpw2XSBF4SceMEtMhKdGP3N0w/l1y4qrltEyfzbQU0bAvo9yoc9ZAPQH2MvzQHdAlvVquZ4nmS9X8nNQlzXOHIw/EzJt2od5Ryjx9WeZRSZIRzaaMtJ5JtU6hHPQkxtM2IjtDBddYcPunVe1pNKK7u5g4S2pq6JgZr6USjR/uZb+Qxt2zZBVSe4V3A744W3uvpvSiekIfNjpsqFXDe7ed/r7Lf9J6gbJ0COfRZLj2/ON2Clik3mgs2yUxcQqYD1wTigcisfNgWEmvjBpFvEIO5uTgVggEgXE5cfMUtz3fkU5fgHddDJTRHqPnf5Cd+6jW+n3C8CDT5i+nQgXQo9wCvhf/VIYmlKVnUnxaxjjpIuEPpZ4w+62cqL+tX1p3SHlxr7U3CBiW/9p3JWt/0cJ9VnITIUu/GkNDQohoWh33KXMnY4S8y/rwsxYlYzTtgjdFt83iCas+/wKZWBWvVXOuNe5OcHyRnIOjrrWfpz78MoU6NQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(136003)(346002)(366004)(376002)(396003)(451199015)(6506007)(38100700002)(7696005)(316002)(110136005)(52536014)(26005)(186003)(6636002)(53546011)(9686003)(86362001)(8936002)(55016003)(41300700001)(122000001)(33656002)(83380400001)(38070700005)(8676002)(66946007)(2906002)(66446008)(66476007)(64756008)(76116006)(71200400001)(966005)(478600001)(66556008)(166002)(5660300002)(19627405001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?/Aexz5e3wFlBdiKnX0WPfCVbcPsZKF/+cOR/n4MrpGfGwFaVkriJXU0k8MmV?=
 =?us-ascii?Q?zEsFtSUCLJw4UmskAJUIp+muMEhursbUjvr50tBjM1gqH7UIfkW0zl3il91j?=
 =?us-ascii?Q?UZVHoY6x+QsEcz8vaiMvTk44rjzWBGk8nlKLUREzmTRcgoBnfL7JOIhBXOaZ?=
 =?us-ascii?Q?uQ11fM5+zpJbZL8l+zI33mP+qiwJXhCkbX4ljYriSCiPvT1IOyrgk0JWX++t?=
 =?us-ascii?Q?Rt5rS16nPWWGFsm3AYWNzmZijq9MpcjIg1JF8U9qVRsXirE+0nOZKza/2qFP?=
 =?us-ascii?Q?nR2fqeDb3Lq6rlzOYmWbNNFdhTaXi1pR9e+3n7aSLidzQAsG0QjgubLedzOx?=
 =?us-ascii?Q?fdeQCSUi6G5bxHqD/nEIIYszzupS8+aFer7DBey2icxW6qntakwVsWKkOloS?=
 =?us-ascii?Q?BLphW/FBfFsPItF5vB6VDXZAKezwCfA4lzkYO4lqOikm+RS8giJN90m/cK6z?=
 =?us-ascii?Q?S8C/ws+9DBU9snhKJUHy6fru2V7DY+67nUAOtJJBSNE4JHlkXzF0mMfW1s3e?=
 =?us-ascii?Q?QpIyc2zA85JGdvHAhWJDh8epfECISu8hTW8RKPhnpJgKLGOyBgb1R0x9CRyz?=
 =?us-ascii?Q?JPAJb+O59OSFB+Qi7ARc4v0+gCQxSVSeSTUCmERwVuxuit8aVRqaeyC1DSiu?=
 =?us-ascii?Q?52lputTX95X1aCrNwgG1GDLMRanELTjh/N3EhYwua4AlkKcsCbyVI+tPjaII?=
 =?us-ascii?Q?IhAhaC+syHP3VYDfYzoToLzq0U7gLsKarsigHVakaD2VmELHb+VToTPxh/oX?=
 =?us-ascii?Q?/rUpoAkNMS7zsogRJdW1s2scZGR5k/wF+7lqfVBuLBGZ2JuZKi+cSSp/8oWD?=
 =?us-ascii?Q?Er40nfZcQm3sOvVebhsOzbmI8Y8sXJOcj0FPbEVf8zBfTBtYSTPVAPjZLdJx?=
 =?us-ascii?Q?rPhd4GJ8ScTk99FCmFlwEsAwNB3pEmsBAA9+b13MVF4tst1LVK7Z0I9m8OcM?=
 =?us-ascii?Q?t7tYRmUJy3IZDaChdggxtQnjFKQc8TIxNyaMWpwxrp0O+C3AUVlYd9FrDeCy?=
 =?us-ascii?Q?B7gARcB/aGZD+FXvF8fUv9BmcPx64M9yM0w0oqk4nNj9hl8wQzztpPvoB+9y?=
 =?us-ascii?Q?UjAY9S1uUArgNzNIxnbo8xUCWRBNmmefTHl1fOA+9aM153pNayHy2J6B60vn?=
 =?us-ascii?Q?PUsZf8UKKh2f0kpGIPlamiKIwA3hKtbJNUXNiTgvUXFrTkGz5hix7Nyw2kav?=
 =?us-ascii?Q?qHxKu4bo6EG6z56p+Q5oj/INjHZ1mEBA8Ehwu5IN4vLhQ0+ylFmbBaiDMLWf?=
 =?us-ascii?Q?l8SVi2ad6Za/yWn3vHpFAs666kccQ7SBfyXB4LP1sjDHk5sPxKFdopGykPOW?=
 =?us-ascii?Q?IHjwLrpTw7xU0vdu+wGKXLpuUjqszBpc6DWmdJ1Cl6sy11btT6n7OwMlY0jt?=
 =?us-ascii?Q?3pxDpwAbQCjOQ78V5/6XiB36ucHRbIO8VA1lmUSKM4n4PNHXal5ZHKdekiJ5?=
 =?us-ascii?Q?VftncASqzAscxbovEYjevsy0ZZU6X4H330545EOQeNgCVWeQ9MRQefLkw81c?=
 =?us-ascii?Q?96cbVBS1b7TJ8E0WL7OVcEyK7o45Z9FWtHLwQPC4mhCTPrE+3iPCL1JQZNUQ?=
 =?us-ascii?Q?/VS/I59xAXaxhHWghnw=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB5144E1AA8FE0EDCCCA8B12ACF7549BL1PR12MB5144namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f53ea69a-d63a-4f47-d797-08daa1790dcd
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2022 17:44:12.0430 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3W3NfDzK4aiwPY0WNwzRT4ACEAs6wsYl+ZC6cBkZSJSaEWMBc7/tl/1QEt8+31w6/zBhk2eGPHrx1Lgepk92ug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6216
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

--_000_BL1PR12MB5144E1AA8FE0EDCCCA8B12ACF7549BL1PR12MB5144namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - General]

This should be fixed in a backwards compatible way with this patch:
https://patchwork.freedesktop.org/patch/504869/

Alex
________________________________
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Sent: Wednesday, September 28, 2022 1:40 PM
To: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>; amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.o=
rg>; Gao, Likun <Likun.Gao@amd.com>
Subject: Re: RE: [PATCH 09/10] drm/amdgpu/gfx10: switch to amdgpu_gfx_rlc_i=
nit_microcode

On 9/24/22 10:14, Zhang, Hawking wrote:
> [Public]
>
> Hi Alex,
>
> Sienna cichlid rlc firmware binary needs to be updated to match with the =
kernel change.
>
> I shall add this comment to commit description.
>
> Regards,
> Hawking
>
> From: Deucher, Alexander <Alexander.Deucher@amd.com>
> Sent: Saturday, September 24, 2022 05:36
> To: Zhang, Hawking <Hawking.Zhang@amd.com>; amd-gfx@lists.freedesktop.org=
; Gao, Likun <Likun.Gao@amd.com>
> Subject: Re: [PATCH 09/10] drm/amdgpu/gfx10: switch to amdgpu_gfx_rlc_ini=
t_microcode
>
>
> [Public]
>
> This set seems to break RLC firmware loading on sienna cichlid.

This also broke beige goby. Please fix or revert. Requesting to upgrade
firmware is unacceptable.

--
Best regards,
Dmitry


--_000_BL1PR12MB5144E1AA8FE0EDCCCA8B12ACF7549BL1PR12MB5144namp_
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
[AMD Official Use Only - General]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
This should be fixed in a backwards compatible way with this patch:</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<a href=3D"https://patchwork.freedesktop.org/patch/504869/" id=3D"LPlnk7239=
73">https://patchwork.freedesktop.org/patch/504869/</a></div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
Alex<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Dmitry Osipenko &lt;d=
mitry.osipenko@collabora.com&gt;<br>
<b>Sent:</b> Wednesday, September 28, 2022 1:40 PM<br>
<b>To:</b> Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;; Deucher, Alexander=
 &lt;Alexander.Deucher@amd.com&gt;; amd-gfx@lists.freedesktop.org &lt;amd-g=
fx@lists.freedesktop.org&gt;; Gao, Likun &lt;Likun.Gao@amd.com&gt;<br>
<b>Subject:</b> Re: RE: [PATCH 09/10] drm/amdgpu/gfx10: switch to amdgpu_gf=
x_rlc_init_microcode</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">On 9/24/22 10:14, Zhang, Hawking wrote:<br>
&gt; [Public]<br>
&gt; <br>
&gt; Hi Alex,<br>
&gt; <br>
&gt; Sienna cichlid rlc firmware binary needs to be updated to match with t=
he kernel change.<br>
&gt; <br>
&gt; I shall add this comment to commit description.<br>
&gt; <br>
&gt; Regards,<br>
&gt; Hawking<br>
&gt; <br>
&gt; From: Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;<br>
&gt; Sent: Saturday, September 24, 2022 05:36<br>
&gt; To: Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;; amd-gfx@lists.freede=
sktop.org; Gao, Likun &lt;Likun.Gao@amd.com&gt;<br>
&gt; Subject: Re: [PATCH 09/10] drm/amdgpu/gfx10: switch to amdgpu_gfx_rlc_=
init_microcode<br>
&gt; <br>
&gt; <br>
&gt; [Public]<br>
&gt; <br>
&gt; This set seems to break RLC firmware loading on sienna cichlid.<br>
<br>
This also broke beige goby. Please fix or revert. Requesting to upgrade<br>
firmware is unacceptable.<br>
<br>
-- <br>
Best regards,<br>
Dmitry<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BL1PR12MB5144E1AA8FE0EDCCCA8B12ACF7549BL1PR12MB5144namp_--
