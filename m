Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7D5EC4332F
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Nov 2023 19:16:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 44B4510E231;
	Thu,  9 Nov 2023 19:16:33 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20629.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e89::629])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1EFDC10E231
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Nov 2023 19:16:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TdlKqFGMjTlgDf5RNoEjSkKnWS1EzAD/GObwiChjU10cXTljFvyCxxBclkVoblLdeqtZl/G8aBJqwZag5CaHamU/oFspX1YuyThwbR28QjtTF0uIf3HZPZRk11iNDYL5M/f7baw2iRdWFm8R1kD+/jgpx4WkQUlxZSz6KpEwbCCAbcPPArSpQ/0ZuGd8BZGjjtzlGH2adEa3rIKcb8E5U831CoMCc6bReJ/PAnoOs9zC2++WXGse0BeJVRjayNm3vcGuwOWXitw5v0PZ8JH35yxYxCl3oN/SYA+oXBhtAVRL7eMajVuSHG6wuIqof86Ise8SpfS+lJMXQrlVfjVv2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Dve9MghQvWgp83PwLym4nHOhDK6deBsonaIQvytq+I=;
 b=Jb7+62c2hoSz/HlpG57tbCCmVBOj1MGefjQkC+GdHMZS5yG1CCc2ZbPUeXYmFKfH/SvoUQ/8w3xqcwU2p1ewMsOZz213kqCQw7fWrAlzlSJ8q3qGdMfQANn10+AVPQdUpiA1tsh3pzcFnrSWa3fzuwGn5wfiGTSY8kgvPs8WWzjb63o2x6n85DYKd4PirZmEFB6EIPr5Bko5ZK+/iOeSTPAzrLThTDT6d+PCf0yZvGaW8fiH8jV/i6xDKQHt7/0YryOIViSjkf5Oje09hFDcd0Nf9a0i9EmBHhzM2E3RY0y4wCY7Cc9+u/E+NPdHU6fT5QRHFUw8qFLOAvJP6aqJ3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Dve9MghQvWgp83PwLym4nHOhDK6deBsonaIQvytq+I=;
 b=m3nSpxm7EMS5lByNPJZeXGWYtDJ8qjZAXjYkY5LffVGdEXSlkN6D6X4mJB3OCyy/dULSNR80v0COCETe//F6cNsA5GrSMDm+PRLLiQV/WPPfi8Af8ALTXzjJkgJmtPMSzBXf4B/9CmcYJQlGaWv7ZSsZ5SevTg5a1TkyGS9WpQo=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by DS0PR12MB7629.namprd12.prod.outlook.com (2603:10b6:8:13e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Thu, 9 Nov
 2023 19:16:08 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::f081:16c7:9129:c010]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::f081:16c7:9129:c010%3]) with mapi id 15.20.6954.029; Thu, 9 Nov 2023
 19:16:08 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Limonciello, Mario" <Mario.Limonciello@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amd: Explicitly check for GFXOFF to be enabled for
 s0ix
Thread-Topic: [PATCH] drm/amd: Explicitly check for GFXOFF to be enabled for
 s0ix
Thread-Index: AQHaEzN70mof963iUUO1hIMJvYAjBrByW99T
Date: Thu, 9 Nov 2023 19:16:08 +0000
Message-ID: <BL1PR12MB5144F27456DB25D45CA7EF4DF7AFA@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20231109162749.38632-1-mario.limonciello@amd.com>
In-Reply-To: <20231109162749.38632-1-mario.limonciello@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=True;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2023-11-09T19:16:07.665Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|DS0PR12MB7629:EE_
x-ms-office365-filtering-correlation-id: 52a593a3-dc1a-4622-766e-08dbe158540c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JZBz6GotcjE5/wmmZ9Aj9mSyUvpFeRWlBhLAxElRc3StysMhIosbS6WsqVSr3zKQ3jALkpQbCcHyaIjt0eODgSvqeaMgUsTIul8B610xFNrbkKmKsaGGlBCk5vENgo+z7EVm9DEp4j1t0Oj3CuJwpo5ms30rhF3WHh4/CG2R44dPzlV6rpUFCKr+KQMjOtuYJE0tsWZ0ayltvBS8KzYMQgvOYpMhiprjYJn+UzdJWeUwp1HL9K6qoTeMt3fWUYkbckfcTliOsEISljpnxqihR9crW/hKme+ia1i4Fg0aXY1JxEvDWsuD7fHPaCpUutJmnvVBg4ZYDGWdCK6JZSIY52CJ0fV0YbFd3FEpDalzCGkcYcQiiExDfcEe/LjTyRLTK5LwTttDKb1S1HoDjV+vH97SIuXKnaqy0DLOxUKEBmL0KlVpmCPq3Hbmp5SckeKK0dVQDjsipQ7JgBwo4LrHkmWpyDHpYXLjNrD+Kc4x37yIZ4anHBnz6HPESI3V9gUxa5LpoM1y6Jni7yDNE6+Z+vpW0T4A73o1ZkWsvjK/9rDbLH8g2iftrhQca1mpbwtwoEFaYXWu9zJ3hQV3/NAWsUIN+24jPXhIASXgNHyT9a/yESzGnhdg2MCRZFhJLlGW/EIC77aOwopMJQy9CXodZA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(136003)(39860400002)(346002)(366004)(396003)(230922051799003)(1800799009)(64100799003)(451199024)(186009)(64756008)(66946007)(71200400001)(19627405001)(55016003)(53546011)(478600001)(6506007)(9686003)(38070700009)(33656002)(38100700002)(7696005)(122000001)(86362001)(41300700001)(5660300002)(76116006)(66476007)(91956017)(2906002)(66556008)(83380400001)(110136005)(26005)(66446008)(316002)(52536014)(8676002)(8936002)(32563001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?1Hp/ujmaWQNPENpf8WuYCAW057+ovAbGx5d+3wB0K4iSmBWTxtwiAgAEWjEh?=
 =?us-ascii?Q?co3n6ZfH1dI3HMhRPtiwBRhXXrveEAbnkXraM6g+zock/GGC9oY4GMpIwXhI?=
 =?us-ascii?Q?wjblrlNJpnz0Mj7cN5s7CKHeO4NTFqR4XZPjw9at8J0Z9FAtGfFNlRKaQJ+S?=
 =?us-ascii?Q?cnGB+00mvOfQtLeGnzRofXX4Z3MPBBDTIp/fagEtc1iwB2ph67E0brvG4Xc4?=
 =?us-ascii?Q?OzwhkmVcUckIcgwPdk96LBfUpjAxF2HiLNXHlTgAH2KK0AJEQVXmKfQVW8u4?=
 =?us-ascii?Q?zFAAE6mqyoWSsz/ymVERjhVNtKAnp4ir4YfAtwYjZo+U3XcBFywr3Lau/lxG?=
 =?us-ascii?Q?CTYsXzg26LPda6BO6hBH6YSx4botHIzZHiIlrccfyDu6kKrwy/Vg4zLZt4cS?=
 =?us-ascii?Q?1AMay4xm0Mv50Yb9qS16ESf1HXSh5b0A99rA9E/djn0jupTmn4V3lDx5+IEI?=
 =?us-ascii?Q?A6yOUaCQ5KUEPD+kz3ScBvBTHPb/FOlwDbLAMnuCCwt8dNUqaDsxboFcIX3b?=
 =?us-ascii?Q?PXO9Sean9TY3qvYKVExA5Dd5rNje9PwUEz9tMHgewuOCikqFakIGNEiOsqnb?=
 =?us-ascii?Q?K+FRXs9GR6/C9w2J0aRNOIMQnLvWXdoCUxYFuj6LF32fxi2W7R7gKOR38uft?=
 =?us-ascii?Q?viSSbsbs6XHkwCmCBfN1Rvj0ouWjtbRPYBvLRvnxYnFNLAvBqAMXn6Be2n98?=
 =?us-ascii?Q?bRelC1K3bVsunBj9kcjI0PR18UQctZe7AoqpDy62yx0NkqR3c0AVIOPkTZ8N?=
 =?us-ascii?Q?FYwMIpziyWrCJzCYrXkP78r3nC9wiPcyW6rHyDSmVkoI65pZ8RnZkp7YasTl?=
 =?us-ascii?Q?a+Nw8gtWjPFRqPFWKXBYkr+I1rQIRoLrqNTb7057BLIE1VCISFdZHhBix06Q?=
 =?us-ascii?Q?fpgKJlo61C7Mnw1+QYgKcQeYjfnhRdmmuaX5Sn1ADjJZgCCSi6qgF8/UNbom?=
 =?us-ascii?Q?dcpsU3wWxvULMzPwAx6NbFnHiefTHMPkn/yLZEIQNfAxFo5umQHgDMoyT154?=
 =?us-ascii?Q?64Z+k6h9bQU+Wp/XAkQEeWvaF9J48zFFLPd7VyFNtIXFEE8a7FrR37OiQgWR?=
 =?us-ascii?Q?oiF1iR2VukYg08ZLBj9wfWIXMEXPoNGu5hQQYx7fVY+tjPvtKg4oxLKLfTTQ?=
 =?us-ascii?Q?xFzbvJR1DK35X3y71d4PVRwVd8UZJVceR31TYv/sqQU0ayn0bGFpmMw+evMn?=
 =?us-ascii?Q?9XEgmO/3lUHx0BhK3UsyMXlOOIsd77Pp0tIbVI9mBI7n4kqoBdNLheBQql2l?=
 =?us-ascii?Q?AmDQlI3JnvwUW8ADi6/3CtNKTyGkKwLLv669oSolIHZTg5XrMToC26g6H+Id?=
 =?us-ascii?Q?GPVnS/YXSOq0tImmubh9EHQD/Rn5l7eIrBRa5J/qqY6VQ/TNyJuOq7SUlBt/?=
 =?us-ascii?Q?1nA3wdgftEjlQoDTWZ2QTVzW1uzUe8ppItL4oVb5+ZkqFRzSvjquia8GYE1G?=
 =?us-ascii?Q?OKsGhV4PhRxBHgX73sTinh3ynOkUoDYVUfB9BbuKZzWaxC1/aBpXVIH84JAF?=
 =?us-ascii?Q?n+8OCdzktyAqnb1Ciu0tncrv1mubTJTMXkA2zD3plwLESli6R1jd111nKFPO?=
 =?us-ascii?Q?TyCzDJC2ipppzABG+/s=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB5144F27456DB25D45CA7EF4DF7AFABL1PR12MB5144namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52a593a3-dc1a-4622-766e-08dbe158540c
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Nov 2023 19:16:08.6139 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PkJuOBBocVdAPNW9pPKR/c2mbmwx4PHPU3Sz7k/RXKxEPrgXPtUd14ddxIWehU51KcEXTbMnZVpI9kenU1XzzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7629
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

--_000_BL1PR12MB5144F27456DB25D45CA7EF4DF7AFABL1PR12MB5144namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[Public]

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Mario Li=
monciello <mario.limonciello@amd.com>
Sent: Thursday, November 9, 2023 11:27 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Limonciello, Mario <Mario.Limonciello@amd.com>
Subject: [PATCH] drm/amd: Explicitly check for GFXOFF to be enabled for s0i=
x

If a user has disabled GFXOFF this may cause problems for the suspend
sequence.  Ensure that it is enabled in amdgpu_acpi_is_s0ix_active().

The system won't reach the deepest state but it also won't hang.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_acpi.c
index d62e49758635..e550067e5c5d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
@@ -1497,6 +1497,9 @@ bool amdgpu_acpi_is_s0ix_active(struct amdgpu_device =
*adev)
         if (adev->asic_type < CHIP_RAVEN)
                 return false;

+       if (!(adev->pm.pp_feature & PP_GFXOFF_MASK))
+               return false;
+
         /*
          * If ACPI_FADT_LOW_POWER_S0 is not set in the FADT, it is general=
ly
          * risky to do any special firmware-related preparations for enter=
ing
--
2.34.1


--_000_BL1PR12MB5144F27456DB25D45CA7EF4DF7AFABL1PR12MB5144namp_
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
Reviewed-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Mario Limonciello &lt;mario.l=
imonciello@amd.com&gt;<br>
<b>Sent:</b> Thursday, November 9, 2023 11:27 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Limonciello, Mario &lt;Mario.Limonciello@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amd: Explicitly check for GFXOFF to be enabled =
for s0ix</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">If a user has disabled GFXOFF this may cause probl=
ems for the suspend<br>
sequence.&nbsp; Ensure that it is enabled in amdgpu_acpi_is_s0ix_active().<=
br>
<br>
The system won't reach the deepest state but it also won't hang.<br>
<br>
Signed-off-by: Mario Limonciello &lt;mario.limonciello@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c | 3 +++<br>
&nbsp;1 file changed, 3 insertions(+)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_acpi.c<br>
index d62e49758635..e550067e5c5d 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c<br>
@@ -1497,6 +1497,9 @@ bool amdgpu_acpi_is_s0ix_active(struct amdgpu_device =
*adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;asic_type &lt=
; CHIP_RAVEN)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return false;<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!(adev-&gt;pm.pp_feature &amp; PP=
_GFXOFF_MASK))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return false;<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * If ACPI_FADT_LOW_P=
OWER_S0 is not set in the FADT, it is generally<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * risky to do any sp=
ecial firmware-related preparations for entering<br>
-- <br>
2.34.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BL1PR12MB5144F27456DB25D45CA7EF4DF7AFABL1PR12MB5144namp_--
