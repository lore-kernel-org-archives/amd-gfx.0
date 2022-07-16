Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00B61C43334
	for <amd-gfx@archiver.kernel.org>; Sat, 16 Jul 2022 15:24:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E68259642E;
	Sat, 16 Jul 2022 15:24:16 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2067.outbound.protection.outlook.com [40.107.237.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 51CDE95789
 for <amd-gfx@lists.freedesktop.org>; Sat, 16 Jul 2022 15:24:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VF4p/Fe03CzOD8TuM0gvDlCf1LU6dHT+4dHibIZInfXiv5F/Xzwfbo9NDwTFKvJZsReQklXmDci1ALxyHsPfvlLBtkGN7B76DTX05JsshbcAhmOxMvTvFb404pyxI6zgpvvG1HRZkiCR3Dwb0oLLnkrVm35tAJRxy3flzm0iPx3We9RtxcJt/76zaWvftZzaXHmTGLOzZR3wPzfzImPcGR8dDu2on+3rLAPBwNR/UK4uq58GEOK0SYXZpDnBCBV8kf9K3KnGw2EMi8v4l1tbNRzU/GXPEuSS5MDZ5s0tS+npVK93prB1s+4b4by0ECjcv/Pd7mZcJUcZarrYEIV3Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N6tJPmA/zKEzEmLq8Whznnn9ZmgVAGpmczMaY94TEnQ=;
 b=XRfqaOW6ScvoVGGMM/G+VVRqreKAcNTMrKAa4UIqP0IRzicZjzO2onde3ejefdJ8AkIlzL57diz0kgoLcg6zQD7RFB3+yObnoYEFvlScRav8sbMi5i/YphnTbP4fPPRhoWuGDw4S9q/TZULxV77DQRrUd9hXBwV9H3giM4ILaNKdem+jlfvxRrNSvCe1dFtZbW2q1ApuYZHZ0i0bf/bcR6XFOqQ8uE4Cu94HlJ2b92wkjLQKDiSfC8BMj5iu8LN38L0rTR69AC7r6wfKU0KjQgOhNgw3wtcTzo7tvrydSRY+shP+HsTuI9pM1qtFWrGZQCMZOo+X/KgemEDU/3EaiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N6tJPmA/zKEzEmLq8Whznnn9ZmgVAGpmczMaY94TEnQ=;
 b=FWvDCJbcafdJy+LfMH4KAcCyIhtGNqd/kcM5Oscmz8FQ+g3DT8RkUy0oYJ2J4h2J7Yat6BeqFyRpCZja1hR2mT+CAHfpFpewLi5nKe2yllYml8H3vztgzIWB58cwrzmxDowD9bl4If40251ezF3wT/Y1LlPpNqoiyfDnUbPRGS4=
Received: from PH7PR12MB5997.namprd12.prod.outlook.com (2603:10b6:510:1d9::21)
 by DM6PR12MB4841.namprd12.prod.outlook.com (2603:10b6:5:1ff::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.21; Sat, 16 Jul
 2022 15:23:58 +0000
Received: from PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::4929:3644:b9ee:8554]) by PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::4929:3644:b9ee:8554%7]) with mapi id 15.20.5438.014; Sat, 16 Jul 2022
 15:23:57 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "Feng, Kenneth" <Kenneth.Feng@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amd/pm: enable mode1 reset for smu_v13_0_7
Thread-Topic: [PATCH] drm/amd/pm: enable mode1 reset for smu_v13_0_7
Thread-Index: AQHYmSKAYnVh9DlqyUSKncm/6cslEq2BHbxz
Date: Sat, 16 Jul 2022 15:23:57 +0000
Message-ID: <PH7PR12MB5997CB3FA578AE01D3C141F7828A9@PH7PR12MB5997.namprd12.prod.outlook.com>
References: <20220716044330.13768-1-kenneth.feng@amd.com>
In-Reply-To: <20220716044330.13768-1-kenneth.feng@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=True;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-07-16T15:23:57.435Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bc715b7b-a913-4f95-5b28-08da673f33ea
x-ms-traffictypediagnostic: DM6PR12MB4841:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NOdhmhjaWd/0oP0B4YGk4mHyVZtdZDm78zuW3IOJQOjbOPka4sKaxURByRLApxXQG19hbJqgVbmkn3rucdUPPsRJmbk6bzUt3cIO72BEUKm14FmPdA2iM+NHMxqXGIhyy936jPRxkIrQZ3mNoKygxUBCr/8ftrw/eDBfoyvvke92oiUKpnUkMGfurGwiwC7+eltWWeqCKdgLol6CHedzyc7d36J77kVjwUkGDwIa6BGqkSc19bR1Ec9DJ+2PgV8fLnQHHXbYfRq1sr8FDl4U56ZgJe6clXM2+UnXuuLl3IImlfJ6ATe/Q2ZQGGiqS9jO/Fv/3ZYdvx7KowG3B5IM9iVAtepJJJEcYVAfvqnf/YqtgwwCFWxjS7Bj4O5FtdfAvBymJMJzkZuuYQnO99fe3HAOrz8eTcxFgbcnAMmOqazpO62vEH+a2A28AjVRGd3UxLOgb//T9FfZrR+cFs/rR2dbavvEVp895la2Yg4ykNPnzeUe99855XQr9xSTNDT4rU7ZKVE6FDK5O8eE7tIYuxUe6GZqRdD1PZ5QgbmY6v5Cm7SHsGmr4Kjb/dDNzE7g+MDD1ly0Ea9JDtEIuX5hkpf7qvBJBgffqVDkfnHiaRjiTah5YZXyNSxRoqEw9BtiJkUK+2fBjq8R6bKb3vVot2zC0LXI/X64TGQDq6F29xqhUa5Av5KnUFCLd9kZwGc0oZ/Vjk0mX2cOqo+9U2JGZolSI0QqHiJiV3HbEPxpnzNa0mKYIdYjb46GePiaIiZLktGMBqPM3nAp6/ziTuI3jdsPveP8JFmrGBs1dXOZTUGnp1SbvtgTeCG7AmGk/r34
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5997.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(376002)(136003)(396003)(366004)(346002)(39860400002)(38070700005)(83380400001)(186003)(9686003)(122000001)(38100700002)(5660300002)(8936002)(52536014)(55016003)(2906002)(478600001)(71200400001)(7696005)(53546011)(26005)(6506007)(41300700001)(76116006)(91956017)(66946007)(66556008)(66446008)(8676002)(66476007)(110136005)(316002)(33656002)(19627405001)(86362001)(64756008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?gxb7FHub+kV5nwoy5/G5Z4Z4cqISwo99ovTPyE3YjCzulfUmi+Z6ygmOJ+?=
 =?iso-8859-1?Q?GsCE4hgr1VqyN7zhNZswXAZwCEhYkVfGts4ysjlecKsSyDllprOQKl4Tgz?=
 =?iso-8859-1?Q?m4oi0kB4OS3yXJMu22Q3qITEhvXPBwR1qPxpO7AcIohByYYcVn2LOxaxz2?=
 =?iso-8859-1?Q?42dezOK8qNT3EsM4+RKh27obFtkjenZGUe3jqzUNdVK+tI3igmwVTJs2sZ?=
 =?iso-8859-1?Q?BEhluei8fW+vqD7MyIMYJf4jJh+q5BF/MIW8YRP10ir5AW4iyo8LiS3Hsq?=
 =?iso-8859-1?Q?jRsw3EgSD4nF2u817JnSpHMrhqqSzAJQAhuzKV+xOTpCrFeUJ0FGLsDnCi?=
 =?iso-8859-1?Q?IznTM8A30gXZeaiFuxZ9MoM6VH/yTY/DbzgKmpdcq0pkbjmM+OyuRMN+wa?=
 =?iso-8859-1?Q?rwqC6SWcC14XMvi1z3kpc5VsV/uVIlRKpU9F9Tu30tF5L8WerQdOafBFmr?=
 =?iso-8859-1?Q?QsrBPgF0e88lid2LHM+AvqV9FKW9zSWAL2oc/xBzxDa9hbTU3vcyItGVts?=
 =?iso-8859-1?Q?/WYwla8bzsKQkad18Qxdi2eZJW1i3tRASFvbsEWvxVTlVNena2AcV88XO9?=
 =?iso-8859-1?Q?AFa9r/aAZ0evLcwE6i0grYBM0Za1OKBfnN69PJPMtSEUnL7pUn/3291YRd?=
 =?iso-8859-1?Q?VpKnd+75XENuwEbZQBrq6/8ClVInWWX0qsWLvZoJeubsU38VJlCHEC9Rkv?=
 =?iso-8859-1?Q?lauycIaAfhYv0SQ3SeGeBvrjxKZYRNc9Zwar21Gg7H2H1h465FezyBTaSP?=
 =?iso-8859-1?Q?qkgRGyzhWsaMkDdKLlih96r3Xw5cE5Cng1sOSnPqc7y48xFzJWPiRpNOFJ?=
 =?iso-8859-1?Q?pTyiPnpsEIRUdOs9mercLdpR0r57qRtbyqf0vBnIjL36PBqgoZcUeczyoL?=
 =?iso-8859-1?Q?7xZi1dvqaKQoW/gitCCEL17d+5/xbznedAvibl9G3yUMLf4fxgt42OlxG1?=
 =?iso-8859-1?Q?C8BlmFt8S5dRlarCdV1ryKmpdf5/x8oezjZJy5E2BGi3VInnLts42Yyw4G?=
 =?iso-8859-1?Q?wabn7J4R2QSe0EXqHPuHqaFnhXgcZQm3t9S7L8aFuSXcgKSu1GPsfd+fUF?=
 =?iso-8859-1?Q?OZkGEgC7GjmMWTHNNqSjYHPETzASrV3UxBteL3HL8fjYxD1iDV1xT3qxe8?=
 =?iso-8859-1?Q?8HUDT0VAim2TagBSL9RkQwARM6sfvURBh+aV0+g19uWpDPEqDs4m72s64P?=
 =?iso-8859-1?Q?rNgzjY88MHpsLSs2ARw53mazSeke3SQgBEzRNGFQudaML7SC2uE5DbckjQ?=
 =?iso-8859-1?Q?bns3cg4uWIz0BDLGMkqoP7ogx9MWXgbydtrml5S761iSStW4CnBQZNSy8c?=
 =?iso-8859-1?Q?gtjLprsBsyjJQHx6vc2DHUh4Fw8nnxcKOjMjId6DI6KdRpQ+yTvvS3Tgp4?=
 =?iso-8859-1?Q?Am2GeAp82+mC5VilBWhaEEy45ndOnTD66ZqsJ5q4gq6kPTjOJr7+GSO1X6?=
 =?iso-8859-1?Q?Xuv/Ypt1Vzb7WsQvBNS+6TSRQ+udGAujKT+eluhhGrmKDv9p9nemQ0ZQfC?=
 =?iso-8859-1?Q?CpOPVVppr+mHuz9552EYPpY/qxKE24IdyzcygDRRoRxpGoZ29Mbxtl1SP/?=
 =?iso-8859-1?Q?eMe0fhD66thGSYnzMzcgse2tQVNteVV6zoqpk2t0eCzt87qW1eUV13TeCU?=
 =?iso-8859-1?Q?n+LK79W5TymgM=3D?=
Content-Type: multipart/alternative;
 boundary="_000_PH7PR12MB5997CB3FA578AE01D3C141F7828A9PH7PR12MB5997namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5997.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc715b7b-a913-4f95-5b28-08da673f33ea
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jul 2022 15:23:57.7787 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: N7ObxoOEQp3ah8TPBFDdcAqFpi9TXN8c1xNMEZRAg7klJTnaTKZuxNk0fMFy8yqU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4841
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

--_000_PH7PR12MB5997CB3FA578AE01D3C141F7828A9PH7PR12MB5997namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - General]

Reviewed-by: Yang Wang <kevinyang.wang@amd.com>

Best Regards,
Kevin
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Kenneth =
Feng <kenneth.feng@amd.com>
Sent: Saturday, July 16, 2022 12:43 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Feng, Kenneth <Kenneth.Feng@amd.com>
Subject: [PATCH] drm/amd/pm: enable mode1 reset for smu_v13_0_7

enable mode1 reset for smu_v13_0_7 since it's missing.

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/soc21.c                   | 1 +
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgp=
u/soc21.c
index 765c3543ad18..00e9b7089feb 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc21.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
@@ -320,6 +320,7 @@ soc21_asic_reset_method(struct amdgpu_device *adev)

         switch (adev->ip_versions[MP1_HWIP][0]) {
         case IP_VERSION(13, 0, 0):
+       case IP_VERSION(13, 0, 7):
                 return AMD_RESET_METHOD_MODE1;
         case IP_VERSION(13, 0, 4):
                 return AMD_RESET_METHOD_MODE2;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
index 6259a85bc818..6f0548714566 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
@@ -118,6 +118,7 @@ static struct cmn2asic_msg_mapping smu_v13_0_7_message_=
map[SMU_MSG_MAX_COUNT] =3D
         MSG_MAP(DramLogSetDramSize,             PPSMC_MSG_DramLogSetDramSi=
ze,          0),
         MSG_MAP(AllowGfxOff,                    PPSMC_MSG_AllowGfxOff,    =
             0),
         MSG_MAP(DisallowGfxOff,                 PPSMC_MSG_DisallowGfxOff, =
             0),
+       MSG_MAP(Mode1Reset,             PPSMC_MSG_Mode1Reset,              =
    0),
         MSG_MAP(PrepareMp1ForUnload,            PPSMC_MSG_PrepareMp1ForUnl=
oad,         0),
 };

--
2.25.1


--_000_PH7PR12MB5997CB3FA578AE01D3C141F7828A9PH7PR12MB5997namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
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
Reviewed-by: Yang Wang &lt;kevinyang.wang@amd.com&gt;</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
Best Regards,</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
Kevin</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" co=
lor=3D"#000000" style=3D"font-size:11pt"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Kenneth Feng &lt;kenneth.feng=
@amd.com&gt;<br>
<b>Sent:</b> Saturday, July 16, 2022 12:43 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Feng, Kenneth &lt;Kenneth.Feng@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amd/pm: enable mode1 reset for smu_v13_0_7</fon=
t>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt"=
>
<div class=3D"PlainText">enable mode1 reset for smu_v13_0_7 since it's miss=
ing.<br>
<br>
Signed-off-by: Kenneth Feng &lt;kenneth.feng@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/soc21.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |=
 1 +<br>
&nbsp;drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c | 1 +<br>
&nbsp;2 files changed, 2 insertions(+)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgp=
u/soc21.c<br>
index 765c3543ad18..00e9b7089feb 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/soc21.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/soc21.c<br>
@@ -320,6 +320,7 @@ soc21_asic_reset_method(struct amdgpu_device *adev)<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (adev-&gt;ip_versio=
ns[MP1_HWIP][0]) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(13, 0, 0):=
<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(13, 0, 7):<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return AMD_RESET_METHOD_MODE1;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(13, 0, 4):=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return AMD_RESET_METHOD_MODE2;<br>
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c<br>
index 6259a85bc818..6f0548714566 100644<br>
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c<br>
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c<br>
@@ -118,6 +118,7 @@ static struct cmn2asic_msg_mapping smu_v13_0_7_message_=
map[SMU_MSG_MAX_COUNT] =3D<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MSG_MAP(DramLogSetDramSize=
,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; P=
PSMC_MSG_DramLogSetDramSize,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; 0),<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MSG_MAP(AllowGfxOff,&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PPSMC_MSG_AllowGfxOff,&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; 0),<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MSG_MAP(DisallowGfxOff,&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; PPSMC_MSG_DisallowGfxOff,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0),<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MSG_MAP(Mode1Reset,&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PPSMC_MSG_Mode1Reset=
,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; 0),<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MSG_MAP(PrepareMp1ForUnloa=
d,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PPSMC_=
MSG_PrepareMp1ForUnload,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0)=
,<br>
&nbsp;};<br>
&nbsp;<br>
-- <br>
2.25.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_PH7PR12MB5997CB3FA578AE01D3C141F7828A9PH7PR12MB5997namp_--
