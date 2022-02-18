Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43F1CC433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Feb 2022 14:28:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 73F9510E3D0;
	Fri, 18 Feb 2022 14:28:03 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2056.outbound.protection.outlook.com [40.107.223.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7FE7C10E168
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Feb 2022 14:28:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gnc52Cf+teyB6CnLWoyiajHliqdWpmpN6bABtG7t9HAGm+9Bdtmkx4ivy/KanIuv5ZBlevmJG1ZiesvL8DVbJOZmuHUIpm5X77fj7sBWI7OojF0Bn3jNIWxJMkDy1ERpaKnu4MYQxAv5iaWqFCzGboLNJTRE06opE9YrMAU6Xy2nllU02qEVCKeU7EcXAWze+lO3QneG7+su2TCWvXAgnMvyJLlGPOZ5f6XNeDdAz6IBGsWCXYnCEy1x5viWFnOkrIdmc+8lIi0cEhsrcMFY+hZnrHAyfjJ/vUoElHmQZ77T2v2Tam1EYpYvfgcHv5i70X8G5ekv5y+WdJavjve0dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=afoAQ6+/qreC2aLyp/zvaGMShFn8ihgaY1MBrAS9clU=;
 b=MUdsbnh5f8TEOdCFAwCNB2ZaxBY4dJx9el4qeAJVkQiiH/dDnt96biM7ZKP1sYhhlwNPn9ejH3PEsZ4IN7opNRhrNRCZwEooWyXLqxwGFwn0PFbOz2dPbU9SMiSCcTRWnUvwl94E2pc0jlBWTRicpgLi/tTjFINymdHUJ5s2mOyYIlHulvwpWUM0D+ptxlWUZ35mznKW/oZaTrSGt/2QPwnZ9mLHmBFHMqyKoF7X1W72ube2CwtRQPgYn00zFzPQFM8xLx4dmyyeyY3YQSA5sDpdjNcDm6z7u7zJvv2sj/ZayOyKgUOkM7ACdCtySs0HeO+7jXRwj57Q0jy9mMShZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=afoAQ6+/qreC2aLyp/zvaGMShFn8ihgaY1MBrAS9clU=;
 b=PKeg3qdhe04KcRofd6NQJDhgavabPqEWvQK9GEmxwoDFfYy1LF9rQSFrxofOeVH2CQsRlEprsf2868DQXQkclVxOhzIhStWzdcYUFhAohh7n4zExHNtgYH2m1KGotL+E9DMBQxn6vGvmcj8OZZi/Icef+0ruYZAIU9X65DVmbCQ=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by DM5PR12MB2502.namprd12.prod.outlook.com (2603:10b6:4:af::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.17; Fri, 18 Feb
 2022 14:27:57 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::2877:73e4:31e7:cecf]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::2877:73e4:31e7:cecf%7]) with mapi id 15.20.4995.024; Fri, 18 Feb 2022
 14:27:57 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Liang, Prike" <Prike.Liang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu: enable TMZ option for onwards asic
Thread-Topic: [PATCH] drm/amdgpu: enable TMZ option for onwards asic
Thread-Index: AQHYJGy6Su0CtwxPcEC9xHKJv2wTG6yZXfSz
Date: Fri, 18 Feb 2022 14:27:57 +0000
Message-ID: <BL1PR12MB5144EFE6C248CAB61A3D6D33F7379@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <1645150097-18020-1-git-send-email-Prike.Liang@amd.com>
In-Reply-To: <1645150097-18020-1-git-send-email-Prike.Liang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=True;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-02-18T14:27:56.525Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD
 Official Use
 Only; MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard; 
suggested_attachment_session_id: d5da5b59-e999-a77f-e75c-29334572578f
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9494f962-395e-4ca9-ac90-08d9f2eadba7
x-ms-traffictypediagnostic: DM5PR12MB2502:EE_
x-microsoft-antispam-prvs: <DM5PR12MB2502738A9FE511EFBEB9871AF7379@DM5PR12MB2502.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SDlwxY5w3AwGb+SPegA5nP36AlTP4McTLcms3tqtdgoV2GEhNmuMc7VGAY5PjshAMV/QZswPxmaCycc4YlV6J18+hxsTBQrwXKGUI74KI0Bgh/lyqpbyUG/x5RvO1+REvli2kcuc/PNRIiRCIwK8gucI1RFNvXbBEHuBx1+gCQ2mm9m7C3vwl5Kz9GaA7JUQVJc3sAJEIL3K0TU11sWKfZ+xHfdRHEgK37RMUC+87ePzqHZWkqo/1YNUmoMmcaNCS7OgeZay60atbkdrk8QPolINXl020le+AvvS+Ke8dKfxmM7E62hFqLAQZfP21Vxbr16jxQdXA/cdaE1uZXQTzIBe1QGmq4JljbLmTnUIZoHKAKRp2TjvwuLJdcuzv7EH76NtEUG+35IbPY+h+w5YBSsgmB3R3OmtmjTByiRet4YTYwSM78Gs3NJEC5pntawsisuZ99Opgj1DnP0L5NXJg2gFJFu45XsMuWwqOrKy9jVTUgFHUf2yD2J3Hw5FYLmWCXkFK94OfP1F5BVEtMHZzg6ccc1cCBE0Kec/uionpMjgMyow+Zi6rWYGCU5SRykum8jGE4AIKJ3UYz1A8284dt6gLvK3j3XH6nuW192U2uuxqN9uypAnyiuLhTKIs+7Bg1n0CjeEGbaER3RgYddx6GVoOW3E6odjP9utV8quYM8bKb4n7McfJyHiboJzc6R1MY6NtKUogM51DuDbUYGHiQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(71200400001)(508600001)(2906002)(8676002)(4326008)(76116006)(83380400001)(66556008)(66946007)(66476007)(66446008)(64756008)(122000001)(7696005)(6506007)(110136005)(54906003)(33656002)(38100700002)(19627405001)(186003)(26005)(53546011)(5660300002)(52536014)(9686003)(8936002)(86362001)(38070700005)(316002)(55016003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?DE/hunImIsLMLlIOY/R4y0tf/3nI3l93tFOAGMeNrJt2V7yyCu69em4VDvQe?=
 =?us-ascii?Q?Y+tO513yXWDkNpnVA1wLBDijq1UhUkMwaumsyLZpVQimctHBHDPVGX5ab1pS?=
 =?us-ascii?Q?snYmIdSYAWuXL/Y/Oytyr70WwiECOLJK2pL05TKSx3OvEfMurz2aR6YAIax4?=
 =?us-ascii?Q?h6mjFzPfdESq0q9V0lTZmozdhmYqIK1db9xUVeS1GlUD09Yj5S19cjVT1Zo+?=
 =?us-ascii?Q?KjEQvSwrsHc3BIpq2452bepmnn1PweKkA5V8f6tZ5KJpZ2Ge1Pu4XWaTKtyl?=
 =?us-ascii?Q?lMqRE0jBvLHHZvWAl0wDkU5lB34nCT+WZWLJxF0Imc06p25EEoquFTw80yph?=
 =?us-ascii?Q?qQOJaWgNpNZJTYt6Fqo2pyVBFL4XlkzzT5O7pKOwTgo5xgoAJXVi2sYwOAVC?=
 =?us-ascii?Q?jgS+iggJI4TfpBzoj9BYpB0icAe0uAlWGAs2RhsyN5YqMTERmu3w11juewnX?=
 =?us-ascii?Q?d9qBb1ZNzow4GLdbdrJOvRfanFqmKcs1XIxpKfc3KW9WaqImrL73gv8QobLP?=
 =?us-ascii?Q?uqCT9ZiL123zyUstkhvJbYnLUAn0+vnJklK1ZzrqueIkLMHrh311BTt2K/Jw?=
 =?us-ascii?Q?rScHTwj9FwttE73UiPi9KFjY2M18RKQ1T72L/EUqyiNH9antplQp2Mz2P88x?=
 =?us-ascii?Q?ap6zcSDoD1wX6mP5IdX8Zb9OBYDNXBcTELDQS+set50aCefvShVVxzbRY2qx?=
 =?us-ascii?Q?gTBLDcwJiOvbZsa1Ye5hW+leeM6vATyrXZPLVLDVBVPnqyBcouCLkBwu9dpV?=
 =?us-ascii?Q?orff42p9lRKZGEeHHIGfdfkyTLMfEBqK/j6PoiVWiZaEd8IpFiScWwjSbhrF?=
 =?us-ascii?Q?ycoF6VmbaJwEeqAc/aouNovOalGku9foMgNvBL5O6/06GlkNsBxxaE2RndT4?=
 =?us-ascii?Q?2YT+6PhaMzpfLCjyNzEojxV7ulkccbCUHaIlxn0a/tE574T3q4+b56hW86Ev?=
 =?us-ascii?Q?UKc8706KQG/UiDWVkbWjam0oS6vl7CmgKsRhWdGSCE0a7xc8m8hXs4iPxHzm?=
 =?us-ascii?Q?QzPRg6TEc2WrtwBgkkQhdXyw1U4G0ZYoLYCs21uvjH724XZICb2ZSqvzqmoa?=
 =?us-ascii?Q?gbV117PsnUNaOsO5wkkPNGXR36PrSMkoIKQ7NWkNP9RwD2lngMZzGRvg04vG?=
 =?us-ascii?Q?xSDD/It+WLPTq7RzMB3zk5NcKAJC0K5LxRBrhWlFQBp9R7r0Ffw6o5RJQh8b?=
 =?us-ascii?Q?51W4rR809ssPFS+kISLbR46YZ4SyeI9XcMWr0tkyewjqJw1vbQfb12ajBww9?=
 =?us-ascii?Q?Ed+U2uJ3zSbOfVax2WrwLPT9+5DNtaYsOt76C1oA2sCWXb+jBDEBsCogsz3C?=
 =?us-ascii?Q?2EuHHM6WhlSOGfza9GgdsFYcP7Ffc1VN+oXqlxUWHM20PokuCfziec9eqE7X?=
 =?us-ascii?Q?eGlM1DE1Hs2xL9hiOQF4HWzSm/DZnCUGc1DS1zw3JRwX5+63dkDFfcEjKwKL?=
 =?us-ascii?Q?Gtcm544dipb4eaj+lpCxhQvOarhncqLx2ddTtXr8peYHh33eZaGHyQ4gTLcX?=
 =?us-ascii?Q?Eh9t939IuK00Gs2WiZ9vGiGgGdHlL59/0Ss0anva09HD+kXK45Zxg/s6RT3x?=
 =?us-ascii?Q?jxTaicmLvtF/kPmoVVvpfr4DiPoNntuKbAcleR7BWLuYYG7FuHRDZyXIlwHi?=
 =?us-ascii?Q?cljHYRakqCsvoDlp1T7iJdI=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB5144EFE6C248CAB61A3D6D33F7379BL1PR12MB5144namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9494f962-395e-4ca9-ac90-08d9f2eadba7
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2022 14:27:57.0635 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: m0tcce9Gbwsj+FHn/N//eEtVmpgMmQhB5t0zWpKJQzIu9gZHd5YRh6RRe+jw3jRwgpssr0csiAqEsgkVseLKpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2502
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
Cc: "Huang, Ray" <Ray.Huang@amd.com>, "Liu, Aaron" <Aaron.Liu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_BL1PR12MB5144EFE6C248CAB61A3D6D33F7379BL1PR12MB5144namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only]

We could probably convert this to an IP version check or a family check in =
the future, or add all of the unsupported chips to the disabled case and ma=
ke this case the default.

Acked-by: Alex Deucher <alexander.deucher@amd.com>

Alex

________________________________
From: Liang, Prike <Prike.Liang@amd.com>
Sent: Thursday, February 17, 2022 9:08 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Liu, Aaron <Aaron.Liu@a=
md.com>; Huang, Ray <Ray.Huang@amd.com>; Liang, Prike <Prike.Liang@amd.com>
Subject: [PATCH] drm/amdgpu: enable TMZ option for onwards asic

The TMZ is disabled by default and enable TMZ option
for the IP discovery based asic will help on the TMZ
function verification.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_gmc.c
index 956cc994ca7d..2cbb8c432168 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -581,6 +581,7 @@ void amdgpu_gmc_tmz_set(struct amdgpu_device *adev)
         case CHIP_NAVI12:
         case CHIP_VANGOGH:
         case CHIP_YELLOW_CARP:
+       case CHIP_IP_DISCOVERY:
                 /* Don't enable it by default yet.
                  */
                 if (amdgpu_tmz < 1) {
--
2.17.1


--_000_BL1PR12MB5144EFE6C248CAB61A3D6D33F7379BL1PR12MB5144namp_
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
We could probably convert this to an IP version check or a family check in =
the future, or add all of the unsupported chips to the disabled case and ma=
ke this case the default.<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Acked-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Alex</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Liang, Prike &lt;Prik=
e.Liang@amd.com&gt;<br>
<b>Sent:</b> Thursday, February 17, 2022 9:08 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Liu, Aaron=
 &lt;Aaron.Liu@amd.com&gt;; Huang, Ray &lt;Ray.Huang@amd.com&gt;; Liang, Pr=
ike &lt;Prike.Liang@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: enable TMZ option for onwards asic</fon=
t>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">The TMZ is disabled by default and enable TMZ opti=
on<br>
for the IP discovery based asic will help on the TMZ<br>
function verification.<br>
<br>
Signed-off-by: Prike Liang &lt;Prike.Liang@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 1 +<br>
&nbsp;1 file changed, 1 insertion(+)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_gmc.c<br>
index 956cc994ca7d..2cbb8c432168 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c<br>
@@ -581,6 +581,7 @@ void amdgpu_gmc_tmz_set(struct amdgpu_device *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_NAVI12:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_VANGOGH:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_YELLOW_CARP:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_IP_DISCOVERY:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; /* Don't enable it by default yet.<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (amdgpu_tmz &lt; 1) {<br>
-- <br>
2.17.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BL1PR12MB5144EFE6C248CAB61A3D6D33F7379BL1PR12MB5144namp_--
