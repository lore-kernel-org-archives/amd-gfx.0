Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 132AEC4167B
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Dec 2023 20:17:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B9F710EA82;
	Fri, 15 Dec 2023 20:17:52 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2040.outbound.protection.outlook.com [40.107.220.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E13E110EA79
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Dec 2023 20:17:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NsR8hL+iXPEPxvly2ktwj0ilw05cXfefhSHjlmr/i0gNdcp7pKvlEStqloWXeZojBafJS+pfkjmny1OhETIzCNbXYcKUlztLCXZAz4ahaCzKk3IlC2gLRalFV0VJaPW77isEJgRnqbHkgxCMqReK4Bt4xNjD6Az2RmQD0d3cU+Y32mpdSPp5zpjeRmmFZ6eOijkp7EO/txMUQPyguuWHxVbXnmAc8ZHV4h4+JCn/GdKSBUGSGLTyKXcoKokTO9sQpb6hIu01yKA0u+VFdEgtZ+gJk4hzRMr0kiNWFRwWr6JVGISyYf0zt+7UMNCg7rcNnvYzEKdcBq5kvY/HlFq7Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E4tpMH+LNRfOj38tqPjaJfw/LGi0vECph8QQPR4ULbY=;
 b=CP36yYKETowZZZgKZJpB8jXbNT9F3OQRYnNzoKuvm6vPHcdM2VUVJuqoWUiSOG2x7hTuxqCzt4fBos3FZA2NSfMgy3+ZpkyhlJ4885UJNe9LRvNx6taRonxCIuzYtFvahVqYXuJTnlMeIpQFo2McKcYmAOvBNU10sHWfhs/4JspJ3Xv9fA5Foalr0KDVaTUtBel1X8llhG7dzSdaec7Tui7Ed/yWRq96ORVw+vqfG106NWLq/+dZjp7gtNPR5T7UYnf4n7hspO7wedXSc2AeL2e+oKGZLS5dT5DlLESKQavaXzPgiuvm02E00DEl3VB2SFHCwLSxrJlBYS+RwN8X0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E4tpMH+LNRfOj38tqPjaJfw/LGi0vECph8QQPR4ULbY=;
 b=O0d8MNpzKAcppMHJv0dcDNCknFT6PGFujDKuSTW9GH1EnWiKx+n9nf5kNZvA24TM79d0zWgg6v4IqFKiwMoG65bwbiTSdu1DZ6UbPBfTzwCeWGX5R/2h5N3g+oHCcf/V9gp5qyrOg/avRMCc8kPli15lO1SUgDczCyz9rQpMZSE=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by BY5PR12MB4305.namprd12.prod.outlook.com (2603:10b6:a03:213::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.31; Fri, 15 Dec
 2023 20:17:46 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::f081:16c7:9129:c010]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::f081:16c7:9129:c010%3]) with mapi id 15.20.7091.032; Fri, 15 Dec 2023
 20:17:45 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Limonciello, Mario" <Mario.Limonciello@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amd: Add missing definitions for
 `SMU_MAX_LEVELS_VDDGFX`
Thread-Topic: [PATCH] drm/amd: Add missing definitions for
 `SMU_MAX_LEVELS_VDDGFX`
Thread-Index: AQHaLtvjfl/qyjaRfk+wu5+WPV3i17CqxNbH
Date: Fri, 15 Dec 2023 20:17:45 +0000
Message-ID: <BL1PR12MB5144FC12F21B98A89DAB4CE3F793A@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20231214211153.45546-1-mario.limonciello@amd.com>
In-Reply-To: <20231214211153.45546-1-mario.limonciello@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=True;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2023-12-15T20:17:45.388Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|BY5PR12MB4305:EE_
x-ms-office365-filtering-correlation-id: 6c8bc4c8-aee5-43ab-818f-08dbfdaae69a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6sp2kxZNy13UxodbrnfNT8djNrnECh13YUFVlJtPNnMDSrV4QyzTmlXwWFR5g5UWAWpuSJhIkOgQs9ACZpAQzrg5RFeTglBGhIrQnUcauO+TSolC8M0p6oEFXDnCkWUgyEMA1jWNPVa5hvrfmJ4fPNZxg7eoAPGD0W9hqqS4gFkRYym8lypJQpjVlSRIlyergcfyAih79GOQwIjEUtRcMAfA5xVB0ywHlxMYqrriH6eutSm0tUcGuQckh7aRaCrJ3Uws5wHHp69ZRtp/Dd0tztflpf4AV8PTeR0tUXQCb3IHK129W6jkvPHM53r8OzAHCtuEULHkJa4lIDXBys0cksNVGhLeeJ6kdkYU9EtoM2plBA3bFcFVvjC/r+3rdv/rZCbOx3qNwg/aMNT9Dlo8EQwHFGNtYY/UgXkgdoZDQohc+yVwgI6VW7jpPVWph1BMlg5M/9SEPZZoO5AXhgNjhTC1O1LFMaladM7WF+h1dfcvuiYvKZG0tlC82hskqOR+lccJNYsozffFH4UaRaJ9wiqIJmAMEyQ8lRQkWXyXK5a+diSgkJiRBnv4Vku6Wygha94ZZpSLmBZ/8z4KGjrdE9kktHYkv2+xmghw9lnvMfayhputu7FVidFFqMDeoWqQ
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(376002)(39860400002)(396003)(366004)(346002)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(52536014)(55016003)(110136005)(316002)(66476007)(66446008)(64756008)(66556008)(66946007)(91956017)(8676002)(76116006)(6506007)(53546011)(8936002)(19627405001)(5660300002)(478600001)(7696005)(86362001)(41300700001)(71200400001)(2906002)(966005)(26005)(33656002)(9686003)(122000001)(166002)(38100700002)(38070700009)(81973001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?KsF73G4S8h3gv+si6RoMZVguD2jATIKNbh9d38tO5RICG1cvG9EjW/GTmynL?=
 =?us-ascii?Q?ZMg53HrAb0gu+zmSe2J83+eI98MPZw400wRcbqCVZRP2lebQdPUmIDnEvj9F?=
 =?us-ascii?Q?KUjy7ugIGS0P2w07UfPL5FSDWhWl+k+mDWrISTP/q4RsILiYQOqrBY/fSllE?=
 =?us-ascii?Q?H29rRodE1tT5bY0C6u0dSrjVjJORrcaIjn3YK0+LM1bMGmPGy90VU4Xr4fU/?=
 =?us-ascii?Q?CvfV/Nf0eoWoOV+ZbZYHEqViqCKA5qfwGyJfiVkxKVh+rJd683oMZf+kxzHJ?=
 =?us-ascii?Q?DvlpeArhwmgcjrWvRqTQHnuRv2676BHQIzsO+nZ6jdgWtWp3lyoQswhZ0shQ?=
 =?us-ascii?Q?AB8l8Uen6gfo2rKTJt85bU9N89PyjJvHJeaoIAVzHNpgZVWyj0jDPTNKVId/?=
 =?us-ascii?Q?YiJxcqOU98tnsPtsMlxrCBcLtq++VL+o+PabzlbBgcdjGAqthi8dS3FX8Sk9?=
 =?us-ascii?Q?tC7NQ4g67Sb5j2wvkCE5xEIzKR54FOubrxm+cXNyQX4nToQq8gZRPi5XzaQa?=
 =?us-ascii?Q?piLNKOWQnLGy/9yNRs+rvHbjfzF7w2DUvwQpNkP2cJE7dOUAeAUi80VhZpMw?=
 =?us-ascii?Q?0gclmuBiNzl+t6tZ/S2ONqVB2MfU2Y9rbR2raCXHK1RbY5x4JYWUVFvX5Pko?=
 =?us-ascii?Q?rpsEzdIc7QixM5F7cY96SXa9LgGXPrSZKFfzsa4s+0u/aPX/yk8tk295Mb2v?=
 =?us-ascii?Q?cGQI5nSOHSoGjUM/Q9kRrbhiGpjEqwFc+cktAcJSIN+GTWnxjxYxZhMDSDhN?=
 =?us-ascii?Q?RHbDljAAaHQncANiKvq6motXfivcCsyTqlvMzqVDKwl+2jOeNb0jrAO3IYS3?=
 =?us-ascii?Q?WMDS7udHbhi0IqI/4OcY/M2MKFl1G8Y00hVpAab5BT1riN2/tvrBXHeMSmJE?=
 =?us-ascii?Q?pgzkFgaMNUtBKGR5Gblustb4TMBRY75QzmaYunuZmuXvIqpwIigvucVV2Vtc?=
 =?us-ascii?Q?xKJYLdHazkDDfc/8NEz+FqkUJVySFKQ44QcLO1oTCPt09vQxxaApEx8kKncK?=
 =?us-ascii?Q?oy9KxQ37LrFN2g/+16Fw8NqSJufy15pArX+p5BfQZIzobKofa9v0Se1f5tmk?=
 =?us-ascii?Q?iDsvEHoE618NPjFUPTaI3B16e2SWuP7mRDfBiMrVHqob079D4RrgPlAjNYb3?=
 =?us-ascii?Q?QxDDpjQs2/02nqpBMfFIkuvnsYuzxetNKKJeWPNSn9GRA5Y2uiJZ+ZfB0W4M?=
 =?us-ascii?Q?zFf7v9Hf0we2ixKBTMpmTcR9tIuhRkKofjF+LF7D1DzViq1iIto1r9YPFwbx?=
 =?us-ascii?Q?apuxvujyGrTyVrva7gWVThxUbRm5q99PJ0m9DyYxbkKV3MXmIqeL5WHJw8Co?=
 =?us-ascii?Q?Z9NIJcexvgyLUnqUAbiJWjUdx6WlIgX6bu+AWjrN8MCbi5bGwk2VFXN49xQS?=
 =?us-ascii?Q?WHaVloYNKJq44FEPOF3tWgcLlOaowtnsFWcfX3HM26Q7zWp9iPQmoU7qDsaW?=
 =?us-ascii?Q?6KvtcumZhElwk+0QgQre8l1clKrMRMpso1B3JtUnCQpAWnG0FYXoxAKts9Ca?=
 =?us-ascii?Q?nDGk/jonmn2x6SsPUXQtq9qRTO13ZqcRwCNLKWkUAbr5IN1fcx0IEI0/bbM6?=
 =?us-ascii?Q?GZHptR+qAntYMhxidP4=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB5144FC12F21B98A89DAB4CE3F793ABL1PR12MB5144namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c8bc4c8-aee5-43ab-818f-08dbfdaae69a
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Dec 2023 20:17:45.7666 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pbWtYFYihl79T6D9OwKKGY7lc2oDBYYwNfjM0mWyfAksAGdWphouj/qL869ptRfPzqCKZa40GDlRHXKLow6vpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4305
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

--_000_BL1PR12MB5144FC12F21B98A89DAB4CE3F793ABL1PR12MB5144namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[Public]

VDDGFX should be matched to VDDC (e.g, SMU7_MAX_LEVELS_VDDC).

Alex
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Mario Li=
monciello <mario.limonciello@amd.com>
Sent: Thursday, December 14, 2023 4:11 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Limonciello, Mario <Mario.Limonciello@amd.com>
Subject: [PATCH] drm/amd: Add missing definitions for `SMU_MAX_LEVELS_VDDGF=
X`

It is reported that on a Topaz dGPU the kernel emits:
        amdgpu: can't get the mac of 5

This is because there is no definition for max levels of VDDGFX
declared for SMU71 or SMU7. There is however an unused definition of
VDDNB. Use this to return the max levels for VDDGFX.

Link: https://gitlab.freedesktop.org/drm/amd/-/issues/3049
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/pm/powerplay/smumgr/ci_smumgr.c      | 2 ++
 drivers/gpu/drm/amd/pm/powerplay/smumgr/iceland_smumgr.c | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/smumgr/ci_smumgr.c b/drivers/=
gpu/drm/amd/pm/powerplay/smumgr/ci_smumgr.c
index 9e4228232f02..c5bccd382196 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/smumgr/ci_smumgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/smumgr/ci_smumgr.c
@@ -2303,6 +2303,8 @@ static uint32_t ci_get_mac_definition(uint32_t value)
                 return SMU7_MAX_LEVELS_VDDCI;
         case SMU_MAX_LEVELS_MVDD:
                 return SMU7_MAX_LEVELS_MVDD;
+       case SMU_MAX_LEVELS_VDDGFX:
+               return SMU7_MAX_LEVELS_VDDNB;
         }

         pr_debug("can't get the mac of %x\n", value);
diff --git a/drivers/gpu/drm/amd/pm/powerplay/smumgr/iceland_smumgr.c b/dri=
vers/gpu/drm/amd/pm/powerplay/smumgr/iceland_smumgr.c
index 97d9802fe673..c9115eaa63c4 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/smumgr/iceland_smumgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/smumgr/iceland_smumgr.c
@@ -2268,6 +2268,8 @@ static uint32_t iceland_get_mac_definition(uint32_t v=
alue)
                 return SMU71_MAX_LEVELS_VDDCI;
         case SMU_MAX_LEVELS_MVDD:
                 return SMU71_MAX_LEVELS_MVDD;
+       case SMU_MAX_LEVELS_VDDGFX:
+               return SMU71_MAX_LEVELS_VDDNB;
         }

         pr_warn("can't get the mac of %x\n", value);
--
2.34.1


--_000_BL1PR12MB5144FC12F21B98A89DAB4CE3F793ABL1PR12MB5144namp_
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
<p style=3D"font-family:Arial;font-size:10pt;color:#008000;margin:15pt;font=
-style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[Public]<br>
</p>
<br>
<div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<span style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService,=
 Calibri, Helvetica, sans-serif; color: rgb(0, 0, 0);">VDDGFX should be mat=
ched to VDDC (e.g, SMU7_MAX_LEVELS_VDDC).</span></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<span style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService,=
 Calibri, Helvetica, sans-serif; color: rgb(0, 0, 0);"><br>
</span></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<span style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService,=
 Calibri, Helvetica, sans-serif; color: rgb(0, 0, 0);">Alex</span></div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Mario Limonciello &lt;mario.l=
imonciello@amd.com&gt;<br>
<b>Sent:</b> Thursday, December 14, 2023 4:11 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Limonciello, Mario &lt;Mario.Limonciello@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amd: Add missing definitions for `SMU_MAX_LEVEL=
S_VDDGFX`</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">It is reported that on a Topaz dGPU the kernel emi=
ts:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu: can't get the mac of 5<b=
r>
<br>
This is because there is no definition for max levels of VDDGFX<br>
declared for SMU71 or SMU7. There is however an unused definition of<br>
VDDNB. Use this to return the max levels for VDDGFX.<br>
<br>
Link: <a href=3D"https://gitlab.freedesktop.org/drm/amd/-/issues/3049">http=
s://gitlab.freedesktop.org/drm/amd/-/issues/3049</a><br>
Signed-off-by: Mario Limonciello &lt;mario.limonciello@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/pm/powerplay/smumgr/ci_smumgr.c&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; | 2 ++<br>
&nbsp;drivers/gpu/drm/amd/pm/powerplay/smumgr/iceland_smumgr.c | 2 ++<br>
&nbsp;2 files changed, 4 insertions(+)<br>
<br>
diff --git a/drivers/gpu/drm/amd/pm/powerplay/smumgr/ci_smumgr.c b/drivers/=
gpu/drm/amd/pm/powerplay/smumgr/ci_smumgr.c<br>
index 9e4228232f02..c5bccd382196 100644<br>
--- a/drivers/gpu/drm/amd/pm/powerplay/smumgr/ci_smumgr.c<br>
+++ b/drivers/gpu/drm/amd/pm/powerplay/smumgr/ci_smumgr.c<br>
@@ -2303,6 +2303,8 @@ static uint32_t ci_get_mac_definition(uint32_t value)=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return SMU7_MAX_LEVELS_VDDCI;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case SMU_MAX_LEVELS_MVDD:<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return SMU7_MAX_LEVELS_MVDD;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case SMU_MAX_LEVELS_VDDGFX:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return SMU7_MAX_LEVELS_VDDNB;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;can't get t=
he mac of %x\n&quot;, value);<br>
diff --git a/drivers/gpu/drm/amd/pm/powerplay/smumgr/iceland_smumgr.c b/dri=
vers/gpu/drm/amd/pm/powerplay/smumgr/iceland_smumgr.c<br>
index 97d9802fe673..c9115eaa63c4 100644<br>
--- a/drivers/gpu/drm/amd/pm/powerplay/smumgr/iceland_smumgr.c<br>
+++ b/drivers/gpu/drm/amd/pm/powerplay/smumgr/iceland_smumgr.c<br>
@@ -2268,6 +2268,8 @@ static uint32_t iceland_get_mac_definition(uint32_t v=
alue)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return SMU71_MAX_LEVELS_VDDCI;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case SMU_MAX_LEVELS_MVDD:<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return SMU71_MAX_LEVELS_MVDD;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case SMU_MAX_LEVELS_VDDGFX:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return SMU71_MAX_LEVELS_VDDNB;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_warn(&quot;can't get th=
e mac of %x\n&quot;, value);<br>
-- <br>
2.34.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BL1PR12MB5144FC12F21B98A89DAB4CE3F793ABL1PR12MB5144namp_--
