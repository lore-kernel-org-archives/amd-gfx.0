Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D951CC433F5
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Jan 2022 17:26:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E3E2210E380;
	Tue,  4 Jan 2022 17:26:34 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2047.outbound.protection.outlook.com [40.107.243.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8AD6410E26A
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Jan 2022 17:26:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LQ8+jAO/JGCRswKhV9bcsNr1GswhXH/WPY/62EIxXtNjLerQ5K7wyFZoyEi2meOHaS8Av5qv2gAP5x5RB5fStjkt7ZsOzu/f7mIgJKEEE5JAkFKWWGnbpPkzasNoHH8Mirzhm77cllOehiwGDDZrWlg0Y5xFjJ9JmnizztpiPne1LZ49bXg3F/1OYgR8webv+RcEiYvvrzMXsxSLzC+wS1sHP1O08ict09ISg6UU6Gf1ptVXek29SuWZ0qevpBEOMjn45ialYaegpa/jO1I2LznuxrgtRV5TPsxIdt4ANM1h0XItXhBHz2CTUzDyOKgN/16ga8urWMkl2Vwx7nSebw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NOoU3x5XNO+feZt5hcqfH+RwS1ccpw40/xdD8zC3pUY=;
 b=a7rr5f3XVeZKnhxyuRQxU0/aQmX3k0RUWl8A1RGvMPJFihyIEWZUERG99m78WHH5ihFcMDyima1zA0aR7OtqlPSHxeQ2gNtbY/JME7Lrnty65/IK8rYEGbHd5Y+7ymvPUo54AVLfgda4XrIE87tteR1pinzwBKHFQDX+JI9xOBwYKPzMm50DhZkWtycGbMPOVP3RIiNlzVYniox5dpXv/OT9mXWi0/Zp2q8xBoiEF4D4gTydqn+8nwa3LZQ/JlItPhMY2qYwJSv+9SU7AChP+1IDMd26GXNsle/G8dtwwTZUBKb306GL5h57jrtevgiw7Crb9bC0xl1RpReytXn4Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NOoU3x5XNO+feZt5hcqfH+RwS1ccpw40/xdD8zC3pUY=;
 b=IUTgNLgWld92JvabmurY8mJOwNu7QqxUtlEsutgxHM3vyaiDscfZ/rjZWeGFTvXi6/veOH/W6KcpnQL0+O9rvymD4eL/qDPNwWk1HZxwX4I/qACXFV/RI83OZgSGjoFtKQzu2a892qyKJ3CfadYvx3k8lGECN/kLKbmWHuUJtR4=
Received: from BL1PR12MB5157.namprd12.prod.outlook.com (2603:10b6:208:308::15)
 by BL1PR12MB5380.namprd12.prod.outlook.com (2603:10b6:208:314::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.15; Tue, 4 Jan
 2022 17:26:30 +0000
Received: from BL1PR12MB5157.namprd12.prod.outlook.com
 ([fe80::d06c:f070:6bfd:6455]) by BL1PR12MB5157.namprd12.prod.outlook.com
 ([fe80::d06c:f070:6bfd:6455%4]) with mapi id 15.20.4844.016; Tue, 4 Jan 2022
 17:26:30 +0000
From: "Limonciello, Mario" <Mario.Limonciello@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/2] drm/amdgpu: don't set s3 and s0ix at the same time
Thread-Topic: [PATCH 2/2] drm/amdgpu: don't set s3 and s0ix at the same time
Thread-Index: AQHYALXzfnsHPJE7NEKycgnqM71PQaxTHm2AgAAAacA=
Date: Tue, 4 Jan 2022 17:26:30 +0000
Message-ID: <BL1PR12MB515790C579D9A38B018AE43AE24A9@BL1PR12MB5157.namprd12.prod.outlook.com>
References: <20220103152311.1453-1-mario.limonciello@amd.com>
 <20220103152311.1453-2-mario.limonciello@amd.com>
 <BL1PR12MB5144856BFAA05B8100781100F74A9@BL1PR12MB5144.namprd12.prod.outlook.com>
In-Reply-To: <BL1PR12MB5144856BFAA05B8100781100F74A9@BL1PR12MB5144.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-01-04T17:26:29Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_enabled: true
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_setdate: 2022-01-04T17:26:29Z
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_method: Standard
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_name: AMD Official Use
 Only-AIP 2.0
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_actionid: f417c995-98a0-4f91-bff7-58d5991e4f7f
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 92e1727c-f060-47c5-a8a5-08d9cfa758b4
x-ms-traffictypediagnostic: BL1PR12MB5380:EE_
x-microsoft-antispam-prvs: <BL1PR12MB5380820B7AF075725F2538F6E24A9@BL1PR12MB5380.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kxYxwjHUFkC0aAsZ3vKWsaHO9JF0Hs3b1htD28c5tENSxCkHtPdwtI44xwBailX2JmOUZLdZey2LKU46O2AujLZwcOZgYEAfj/A7ndadCa/tTjqNwSwYeMbDhuXTn2YrliSiSH9lIT7IdPHSoVP0953whplWM7o8mE1sva9ABTddhP727gullMp+Ylqvc3qkMzbkDjj0TwZHuWgUBNVngzJp565yuu7u3Ns9nwhIQgi/iHmFVnjKu5GvB7wGp+sLX/+Iz7iEoZzkMGZioCY6Y72xeOU7xV1U5AaYFYFljCDYXhrJFdyutpaTuGAGo7OAmJLNp1QEzRiWiBDbICSsmw2yFAiEhF5A/0DLRTHVvs608JpAZZU9aQDpv65ntBCH4saCQJrKnPrTe5gki80HgpP6NB8ckf9ldEEiA3OxKTFv7bFKw/EJiTdrfwhdREIYryRCFeEghA10UMlykd8gDRgGj0Do8Zcdu+aN5FUnPZ/8Xvl5IfKK4klzz0My4te52xFhCpTIqei8pv42LaAjocg+pH1XSULYPR92NOcrBZkZyPz4F8RK2b7+1JwJk7eIF5A7AaKPmq05ZLW5AbTHbW/CvxEW6LMfyvYhUjlAO2U7szdO+y4yDuknJRqUQoSf535GRlseKJtbFKCeoTSh8imRykVnU0g8rgEE/9/v1qghCx8/k4hl1Svf4f3jGxw2CiMUPxPDeqZovdp0Tf391wNGr0JrmUeA6vFtJdM9HmY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5157.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(64756008)(76116006)(5660300002)(2906002)(66446008)(186003)(38070700005)(508600001)(83380400001)(86362001)(316002)(66476007)(110136005)(66556008)(66946007)(8936002)(38100700002)(52536014)(53546011)(55016003)(6506007)(33656002)(122000001)(71200400001)(8676002)(9686003)(7696005)(32563001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?MzUPHCqhBs43Pi6NJSTIWX6fx7UKh/cGF+1h+PTq0/2Dr+gjTSNruL53hQct?=
 =?us-ascii?Q?m7PxpU7akjHtYhjp/rkrg6Jwidfafq03L0fbrZ0K6RGG5paYguRKlhPkcToR?=
 =?us-ascii?Q?VWtp+YAcDmCGZlzdLQo0A8ORhpF3UthABkBmoz5wA4KOESXV+twlZw7z1Cf3?=
 =?us-ascii?Q?RUrEUhYpMAO1WXZXJRnL8zShMSekWVJRgmX7kGIyfFckCEoe5f285IMHFOFy?=
 =?us-ascii?Q?brKrGBdwbTK/RTZwMNJ3cvgiB/pP8syeWn8mCGUKnE44lTZZczNG6O0g101k?=
 =?us-ascii?Q?r7ZZn3mlfd4RFH+i661x84qP2V32i+XCMIEjJknkk01vxc1WHlGqsBN9xw6f?=
 =?us-ascii?Q?Yp1VWmGKPhwL5P7Cxx1YtfFSF9YptPEU8w69e0xcfeVMp3AXpu57aG/09snR?=
 =?us-ascii?Q?HpAJLcCIb6rmKi+HQaGSUBFAeNhX+icJ12W3e+IAeffe8LutwsnrldTK7HVR?=
 =?us-ascii?Q?ThyNMFkUX2xaWs9umq+fr/AsGpNoivII9IRD9EV6d96Z7lsrp474E3H0RpLU?=
 =?us-ascii?Q?boSvCLax3X9jp0DziuiPeKJS2eJ7sJ5ZDPnkANP2Kct7t18zq72Ac+CRICe+?=
 =?us-ascii?Q?kK4NGn69/8dLdTkMZLhb5eQYb79wVZLdvW4+P1Ndx44CwkJqPcTDG42qNyrU?=
 =?us-ascii?Q?ksd8sPu4DXmArkTZq1BUlk68wd8NfwN2GJqsDxkZoxelrsCA4ZrMiyEjdTxx?=
 =?us-ascii?Q?L61qEIy2FMXQCRJDS/tXzXD7XTXC5fym+Wr5ow6pZbpksJOkECl9wKoXu+wN?=
 =?us-ascii?Q?PLky2iNhDckCRulQbGCM0ruL6QNlKP6oROf7bXW5lq9KH0w0/t/TmX7v35Fb?=
 =?us-ascii?Q?OvmL5kcGLPxIyP6sHa5+HYG93+HL+cu0YvzQEXWdJ6x4whRZK4OdSD7Grk9J?=
 =?us-ascii?Q?vM0RMEO3h3DzNyQhyX9M2unIwOjLkd58zbLIdP3Qlk1oLOBrXjCYHmMdi3g1?=
 =?us-ascii?Q?XaMkMeZ8KvcH7Lh6UQCYNQyIm7NwFF4YG3eQbUbfBfOI5y0lPxAmCJgNbJZs?=
 =?us-ascii?Q?PFrcnKIimknwEhsJwly+y+t57i3vbheoNFcnmKQmay1cCbQrcNCofLXb8uBW?=
 =?us-ascii?Q?wdiZ6yE6uzLvrEiWt3XZSFqFVnvAtIXOZ21ryYFr9l72TW5EiHYaKrgOeON6?=
 =?us-ascii?Q?wngEgODwCUS1mSw2JLzMa2Ll3ykDpnDcQ/pbAuvcC3dqjFDQ1KpgKpi2BNDO?=
 =?us-ascii?Q?O4ZFYSsCayVOOYj2o/Urn4+egdc6oSRK7YYWr4jGr5OM3SKrXXxMPquAQ8qz?=
 =?us-ascii?Q?VoSjPhLswfUsxX/F5Cx8BUb0LiJcCphCM4UOePXpKaZg/Zd6wlVYan6A03FB?=
 =?us-ascii?Q?E+BLVmE1Auh8L8eIRFfL3Ov9q0+c5IiGNNzGe/ym2Koxb5zojnvRDHwpPY0a?=
 =?us-ascii?Q?wpkNUb4qf32/lF8YMIU02qQii7MEGPc34t27S4xW7YgXoKHtZ43lCNF9XVwM?=
 =?us-ascii?Q?qyoRCrrb6pvZFCFGQpvhZEDyfr5uLcsbPoPwvANLljeR1JiahWP6SloERFhP?=
 =?us-ascii?Q?cbGSkTFmnz4UFwnLOiJN+IbH0MB4VZuX06dV9O1zXwXWTQgCCj0HcNd+JtVB?=
 =?us-ascii?Q?OOqE3bAppTr2FOAeNnFqx8x0Xws6pu6/ww+sT9DujaE297h6R24cw/kIzPzY?=
 =?us-ascii?Q?5kWuEdOBU6qhOg9TujTCzcG+ONpWIrpBtMjydUqA2TBl73qFrtVCeGw/14YT?=
 =?us-ascii?Q?Yx5gd7cBpcl1XZFmCcNgO1saqZA=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB515790C579D9A38B018AE43AE24A9BL1PR12MB5157namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5157.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92e1727c-f060-47c5-a8a5-08d9cfa758b4
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jan 2022 17:26:30.2483 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iH4Bl9obU+yw4ft80x10vKkBCVdsZB18q47g9SA5wgEOCjQoSJA5PeT1Tum/0Kx07wpv7sBnrCQqGmnm8UVgXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5380
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

--_000_BL1PR12MB515790C579D9A38B018AE43AE24A9BL1PR12MB5157namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only]

Maybe it was used more widely previously?
The only place that I found it in use was amdgpu_device_evict_resources.

From: Deucher, Alexander <Alexander.Deucher@amd.com>
Sent: Tuesday, January 4, 2022 11:24
To: Limonciello, Mario <Mario.Limonciello@amd.com>; amd-gfx@lists.freedeskt=
op.org
Subject: Re: [PATCH 2/2] drm/amdgpu: don't set s3 and s0ix at the same time


[AMD Official Use Only]

I don't think this will work properly.  The in_s3 flag was mainly for runti=
me pm vs system suspend.  I'm not sure if in_s0ix is properly handled every=
where we check in_s3.

Alex

________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org<mailto:amd-gfx-bounces=
@lists.freedesktop.org>> on behalf of Mario Limonciello <mario.limonciello@=
amd.com<mailto:mario.limonciello@amd.com>>
Sent: Monday, January 3, 2022 10:23 AM
To: amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org> <am=
d-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>>
Cc: Limonciello, Mario <Mario.Limonciello@amd.com<mailto:Mario.Limonciello@=
amd.com>>
Subject: [PATCH 2/2] drm/amdgpu: don't set s3 and s0ix at the same time

This makes it clearer which codepaths are in use specifically in
one state or the other.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com<mailto:mario.li=
monciello@amd.com>>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_drv.c
index db2a9dfd5918..413fecc89e6c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2165,9 +2165,9 @@ static int amdgpu_pmops_suspend(struct device *dev)

         if (amdgpu_acpi_is_s0ix_active(adev))
                 adev->in_s0ix =3D true;
-       adev->in_s3 =3D true;
+       else
+               adev->in_s3 =3D true;
         r =3D amdgpu_device_suspend(drm_dev, true);
-       adev->in_s3 =3D false;
         if (r)
                 return r;
         if (!adev->in_s0ix)
@@ -2188,6 +2188,8 @@ static int amdgpu_pmops_resume(struct device *dev)
         r =3D amdgpu_device_resume(drm_dev, true);
         if (amdgpu_acpi_is_s0ix_active(adev))
                 adev->in_s0ix =3D false;
+       else
+               adev->in_s3 =3D false;
         return r;
 }

--
2.25.1

--_000_BL1PR12MB515790C579D9A38B018AE43AE24A9BL1PR12MB5157namp_
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
<!--[if !mso]><style>v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
w\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style><![endif]--><style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
span.EmailStyle18
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
p.msipheadera4477989, li.msipheadera4477989, div.msipheadera4477989
	{mso-style-name:msipheadera4477989;
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
<p class=3D"msipheadera4477989" style=3D"margin:0in"><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:blue">[AMD Officia=
l Use Only]</span><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Maybe it was used more widely previously?<o:p></o:p>=
</p>
<p class=3D"MsoNormal">The only place that I found it in use was amdgpu_dev=
ice_evict_resources.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div style=3D"border:none;border-left:solid blue 1.5pt;padding:0in 0in 0in =
4.0pt">
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> Deucher, Alexander &lt;Alexander.Deuche=
r@amd.com&gt; <br>
<b>Sent:</b> Tuesday, January 4, 2022 11:24<br>
<b>To:</b> Limonciello, Mario &lt;Mario.Limonciello@amd.com&gt;; amd-gfx@li=
sts.freedesktop.org<br>
<b>Subject:</b> Re: [PATCH 2/2] drm/amdgpu: don't set s3 and s0ix at the sa=
me time<o:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p style=3D"margin:5.0pt"><span style=3D"font-size:10.0pt;font-family:&quot=
;Arial&quot;,sans-serif;color:blue">[AMD Official Use Only]<o:p></o:p></spa=
n></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">I don't=
 think this will work properly.&nbsp; The in_s3 flag was mainly for runtime=
 pm vs system suspend.&nbsp; I'm not sure if in_s0ix is properly handled ev=
erywhere we check in_s3.<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black"><o:p>&n=
bsp;</o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">Alex<o:=
p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black"><o:p>&n=
bsp;</o:p></span></p>
</div>
<div class=3D"MsoNormal" align=3D"center" style=3D"text-align:center">
<hr size=3D"2" width=3D"98%" align=3D"center">
</div>
<div id=3D"divRplyFwdMsg">
<p class=3D"MsoNormal"><b><span style=3D"color:black">From:</span></b><span=
 style=3D"color:black"> amd-gfx &lt;<a href=3D"mailto:amd-gfx-bounces@lists=
.freedesktop.org">amd-gfx-bounces@lists.freedesktop.org</a>&gt; on behalf o=
f Mario Limonciello &lt;<a href=3D"mailto:mario.limonciello@amd.com">mario.=
limonciello@amd.com</a>&gt;<br>
<b>Sent:</b> Monday, January 3, 2022 10:23 AM<br>
<b>To:</b> <a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.f=
reedesktop.org</a> &lt;<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd=
-gfx@lists.freedesktop.org</a>&gt;<br>
<b>Cc:</b> Limonciello, Mario &lt;<a href=3D"mailto:Mario.Limonciello@amd.c=
om">Mario.Limonciello@amd.com</a>&gt;<br>
<b>Subject:</b> [PATCH 2/2] drm/amdgpu: don't set s3 and s0ix at the same t=
ime</span>
<o:p></o:p></p>
<div>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
</div>
</div>
<div>
<div>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt">This makes it clearer=
 which codepaths are in use specifically in<br>
one state or the other.<br>
<br>
Signed-off-by: Mario Limonciello &lt;<a href=3D"mailto:mario.limonciello@am=
d.com">mario.limonciello@amd.com</a>&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 6 ++++--<br>
&nbsp;1 file changed, 4 insertions(+), 2 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_drv.c<br>
index db2a9dfd5918..413fecc89e6c 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c<br>
@@ -2165,9 +2165,9 @@ static int amdgpu_pmops_suspend(struct device *dev)<b=
r>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_acpi_is_s0ix_ac=
tive(adev))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; adev-&gt;in_s0ix =3D true;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;in_s3 =3D true;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; adev-&gt;in_s3 =3D true;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_device_suspen=
d(drm_dev, true);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;in_s3 =3D false;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return r;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!adev-&gt;in_s0ix)<br>
@@ -2188,6 +2188,8 @@ static int amdgpu_pmops_resume(struct device *dev)<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_device_resume=
(drm_dev, true);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_acpi_is_s0ix_ac=
tive(adev))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; adev-&gt;in_s0ix =3D false;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; adev-&gt;in_s3 =3D false;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;<br>
&nbsp;}<br>
&nbsp;<br>
-- <br>
2.25.1<o:p></o:p></p>
</div>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_BL1PR12MB515790C579D9A38B018AE43AE24A9BL1PR12MB5157namp_--
