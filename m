Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23A0BC32793
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Jan 2023 22:53:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5FF1010E865;
	Wed, 18 Jan 2023 22:53:39 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2067.outbound.protection.outlook.com [40.107.243.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D60D310E865
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Jan 2023 22:53:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K21H7RVCP+b3o2pWZQGltbG0H/JWDCYGmgxgBoxDw//cLQc4HhRSZZCkXFyhruJIT1N3SsgJPfFIUhWC75m9rDbc2jLqa46q88N6N9AzE9vnvIN1O1Skf/Xqsdrg2wwLoyf0rk6OGF1J7kszpWyRuwbeEgC7fjNK8KQVeiwt58On4VD0OkG/z5c3RSAUJI8cgvPADHGya0qvBBaxLVngYQCOuHUWQdlAzK2ssDnaxYny+9RWw3rktaE09VRy6X1M45aKNX9shhvme2uXrp95JRumibSVeoxUISfeT7mZaOlgQyL+NEeBnuFrPhIpoRpCnU85GoLpctkq2uqP+IrP8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eF+OdXfY/waHJVH6GtgfpDGEY9CSE4lo98m5P8I5dLI=;
 b=l/KjviYLKoyCqXGu3QQOhBM/S2td7K5ejMqbw6cHstKXp22pMst4CgUmDeaKlJOovu4LmXu7J7TLxJwIzVUv1l24Bjpf0RWwcb+j1UoQWCnwjXokNAiikQ58XfEgYBdqgVaU2uHcCayYNuwEPcL3L0K53c61qLG+HNISGOR4UGHMbo+q/nhIG9ojonba8x/dok/Ceww8ISnpMvCmTgy+p2J0lkb+bHG3Mj1EiX8uoiWcnRDJesFQ6L6jNl+ojbXS4D5PVypziqkoFRdLLNiDG9rzQpVyxNSWf6TSDYrQDgwq81bnzHNCsLy0BuXRGqij29GlDT1+yzuXaICHBRAJpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eF+OdXfY/waHJVH6GtgfpDGEY9CSE4lo98m5P8I5dLI=;
 b=J/kvoyw1AM5+VqfIhSj49bcvCWNdxpo2jvcne1znq+7h4EAaYNgcWjvhLYS2bm16m5CxrXWSKHP1WA3vd3DJzajGRitF4wFZRbhMdivr6hxm0LtWKICAKSFtcy1cDpxIKTuORattfkGVSpFwKHvszuz3b8AaC/Mcxit04Qw4TIE=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by DM4PR12MB6541.namprd12.prod.outlook.com (2603:10b6:8:88::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.24; Wed, 18 Jan
 2023 22:53:35 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::5cbd:2c52:1e96:dd41]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::5cbd:2c52:1e96:dd41%6]) with mapi id 15.20.6002.024; Wed, 18 Jan 2023
 22:53:35 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Limonciello, Mario" <Mario.Limonciello@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 0/3] Quiet down some warnings on laptops
Thread-Topic: [PATCH 0/3] Quiet down some warnings on laptops
Thread-Index: AQHZK47Um4ixFexR/UGun/M79FQqp66kyDBa
Date: Wed, 18 Jan 2023 22:53:35 +0000
Message-ID: <BL1PR12MB51441F33F4BBD0AD3FB03CDDF7C79@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20230118224711.6832-1-mario.limonciello@amd.com>
In-Reply-To: <20230118224711.6832-1-mario.limonciello@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=True;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-01-18T22:53:34.937Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|DM4PR12MB6541:EE_
x-ms-office365-filtering-correlation-id: 8db0b7af-d3ba-43ac-a060-08daf9a6d4af
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EGYmaWIHKPzWdkHoYR1OEdKPuO5AULFxMsGVDuznUk4ZsZ6BpiXY6NYY8YtcgyIWoaaEge5jRnVOTIBsY1ojGPKkkpDV386gPoa+ZMYukc2HJeFHBKKUnbBaKaWWW17pwOScJ47ru1z2oUqtddYopVD43UikwEkbxPE+B7Ii+fqvCNZttrpde14E0FoOaCiObM+1KbuNNkuH05fnI013LO1kCB5DOgAkCZyf+47PGRP7Sp7223h9LdOjzImxtqH9fSOWgkvD+3yBOJJmURJzKIIFpf7+pakGGo1KGIvqsXITxRWnS01PMJZf4RVPBRBvz1zgA/cmH0w0JQhLm7ZIWtbqIyZ8sTwwHM38VqL+6EOFjc+S0JHjStBm1WS7divoq6m3bHz1HI6cFUMduvczVTAmYzG1OGx4cA/v6Es1bY8Pc1WnFszqCCzi/ySTw7eECuxYdhxOV73oCvtU/RlV072O2nre4LLNm2u6fR9XIT0YI6n5tW0dD4AF2fwCqaC+Ft69SAn91Vct0yi3ej/6R26rABY33XSwksGZIi7gWQ0X6V2COM435FMS+Kbv7klkPkeLoRl6mI6MjNwL/T3AH2iVRPkIe498lKedWtfb3Y63dmdoVj9CNUYXyyVnHvhS6SAGDbOhuPC6pkVdYCYL3VzT+mhEEvxaFysZ9BHWJODVlS1dW7wHeKqVkns6jVvjaP4p2F7Fywg0psuS8xcuFg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(366004)(396003)(346002)(136003)(376002)(39860400002)(451199015)(38100700002)(33656002)(122000001)(86362001)(5660300002)(8936002)(55016003)(66476007)(2906002)(76116006)(52536014)(66556008)(66946007)(64756008)(66446008)(8676002)(41300700001)(9686003)(186003)(26005)(83380400001)(7696005)(53546011)(71200400001)(316002)(110136005)(38070700005)(478600001)(6506007)(19627405001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?0Ydr39xSjvlhhZrkhuTHwvpitT20M7BpF/wg793HgQ7uZNVf4I9OGrqtcrpX?=
 =?us-ascii?Q?c9LhaM9NhRenlFzWh7aBS5ZD7twMCkNycfJS2GjELKpPVa63YGdtBZFN5Bpg?=
 =?us-ascii?Q?3OtS+r+S8MZgNWpGdRyWmv7TEmuR8hyZdJenOdFFbGZAEhXlNqoszYxUV8eM?=
 =?us-ascii?Q?kX3EM7Fy+PUBHJWYmjoOZb5LE+slLxApPnJfP5Rgs9g1gWlGEOm4+96kRPV8?=
 =?us-ascii?Q?zTzXsROQIyvn5dr5c/P6Evv6WkqQF+2ZOAaJCO4eVqoKqN+UKOK5J0bU0pny?=
 =?us-ascii?Q?qsiCD7c5U6vdB/1XNY3T3Qxwa0VxNS7UCajWpw647qT9E8G01FV+XRGSNzdl?=
 =?us-ascii?Q?gRRviq8pda0eiK7z47wfDe65mw+DOXV81THB1REUSUkO9fy7Q5NOAA7oHfRK?=
 =?us-ascii?Q?i4s3qOPl7qSoJaGR1GbiH4EqRASt5otCNa89/TbTlBSfhai953Z+fuMMW/Vz?=
 =?us-ascii?Q?/T19TKYs0/xIEROReZjhjrvJN//FpEYFqupBmWewSzt2GXWRh0PCeZ1w/rtl?=
 =?us-ascii?Q?WegIgIrNeroTpjFmVJ7PlvbqQ/S0uUwe2JM7J28SPYT8JlmpKwjaze1wdYv0?=
 =?us-ascii?Q?IwgYgMWZHzn05NgdmK41d882FP52I/den4VVcd7IngR+dNAeyV+kRYMX9IFg?=
 =?us-ascii?Q?Ew+uxCSHNl5G925R1zndZDNVMOpsP86tBjo7y+TRVIB035Hy+m7N8Twui4Kv?=
 =?us-ascii?Q?8BSFpENE1goJObWCCGMbtbi9n8BhQqe6ofa2vYjCusdK9SCyY/XVyuDjYvgG?=
 =?us-ascii?Q?53vBPoc6BwaA78Zu8XtIgkSdSawil34FvuZqNBaO2rpXEA738LR2m/ipDwvl?=
 =?us-ascii?Q?q1fFaDTYrL8oBprVuygqXZU48VvSNwp/j6z2i63fqIeY2LJNrnyhXAfjj/b0?=
 =?us-ascii?Q?IzhQh9BnNSNIuBS0R/k8OhVR3kT3mOSh4gqi23mNKTvw5Gv8ilD3NE31P/nH?=
 =?us-ascii?Q?26JA8i8xsEI1fpFR81njqFlnRtKP/XXgjBF5w+cWZEXknSzBWVOyzmWDZhVc?=
 =?us-ascii?Q?dJ+5aE3LLACe1UCDfWaQDpc9LDF8KOVXBeq6MY75BoYpd0QAFe+5iHg2j2Q7?=
 =?us-ascii?Q?WT9t5azmsIxZyUVp+6VcUs0Z0gE+tB1VnPf1pdIJgc9DqjnuRkvJ9i15tMfk?=
 =?us-ascii?Q?zYg3TyBSBIl44UQfIQ2VhTOPzshDSa0vpROklaNv22QdZnNL44HJEpzM2aFE?=
 =?us-ascii?Q?0e6fcoTcYrvGdQuCtNRVjPC3A8b8mGfSKui6RcqBGnxULMtsAOty/uEP18Zf?=
 =?us-ascii?Q?EQ8VWq3ZHpNdALwfLE7Ab07fQ1zdpARNHl/ttjRL/i3nidm2KxSrpjNB7AXY?=
 =?us-ascii?Q?B0ifVnu4s0LoTUPhB5rN9BOoCxf2kqpmOpCvFlmT5IrPxbBk0KQXO1EGF1iq?=
 =?us-ascii?Q?c6dzERAHyFBRYB+XocYzVn2a0nHmeSeuR+uv+PWm4sg0Q/yc56tVH3Ri/Df6?=
 =?us-ascii?Q?QsXlJJzW2SED5uWPZOpAgQXsvYu9EmLpCXC7JJjlVA7/pmQeCtJAK3IPxTvn?=
 =?us-ascii?Q?og2W/y9oNotmBncf6Zey3u+lwjgAkdk2GXRFZ9toJmM/jVnQSHXQre2t/ILx?=
 =?us-ascii?Q?9D5nmm7r5fNp5EaxUec=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB51441F33F4BBD0AD3FB03CDDF7C79BL1PR12MB5144namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8db0b7af-d3ba-43ac-a060-08daf9a6d4af
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jan 2023 22:53:35.4358 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9PCBL7szf9mGW1aHaFmkVvKu8H28VApTRCy55vVUJsU+azs+P+zvAUMZA6yMN8guQADI7BlyQcS3JCpzkE1JxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6541
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

--_000_BL1PR12MB51441F33F4BBD0AD3FB03CDDF7C79BL1PR12MB5144namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - General]

Series is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Mario Li=
monciello <mario.limonciello@amd.com>
Sent: Wednesday, January 18, 2023 5:47 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Limonciello, Mario <Mario.Limonciello@amd.com>
Subject: [PATCH 0/3] Quiet down some warnings on laptops

Looking at Cezanne laptops from a few manufacturers I've noticed a few
harmless warnings are emitted to the logs.  I looked through them and
think they can all be decreased to debug.

Mario Limonciello (3):
  drm/amd/display: Decrease messaging about DP alt mode state to debug
  drm/amd: Decrease warning about missing SRAT table to debug
  drm/amd: decrease message about missing PSP runtime database to debug

 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c       | 2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_crat.c         | 2 +-
 drivers/gpu/drm/amd/display/dc/core/dc_link.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

--
2.34.1


--_000_BL1PR12MB51441F33F4BBD0AD3FB03CDDF7C79BL1PR12MB5144namp_
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
<div class=3D"elementToProof"><span style=3D"font-family: Calibri, Arial, H=
elvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0); background-colo=
r: rgb(255, 255, 255);" class=3D"elementToProof">Series is:</span></div>
<div class=3D"elementToProof"><span style=3D"font-family: Calibri, Arial, H=
elvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0); background-colo=
r: rgb(255, 255, 255);" class=3D"elementToProof">Reviewed-by: Alex Deucher =
&lt;alexander.deucher@amd.com&gt;<br>
</span></div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Mario Limonciello &lt;mario.l=
imonciello@amd.com&gt;<br>
<b>Sent:</b> Wednesday, January 18, 2023 5:47 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Limonciello, Mario &lt;Mario.Limonciello@amd.com&gt;<br>
<b>Subject:</b> [PATCH 0/3] Quiet down some warnings on laptops</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Looking at Cezanne laptops from a few manufacturer=
s I've noticed a few<br>
harmless warnings are emitted to the logs.&nbsp; I looked through them and<=
br>
think they can all be decreased to debug.<br>
<br>
Mario Limonciello (3):<br>
&nbsp; drm/amd/display: Decrease messaging about DP alt mode state to debug=
<br>
&nbsp; drm/amd: Decrease warning about missing SRAT table to debug<br>
&nbsp; drm/amd: decrease message about missing PSP runtime database to debu=
g<br>
<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; | 2 +-<br>
&nbsp;drivers/gpu/drm/amd/amdkfd/kfd_crat.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; | 2 +-<br>
&nbsp;drivers/gpu/drm/amd/display/dc/core/dc_link.c | 2 +-<br>
&nbsp;3 files changed, 3 insertions(+), 3 deletions(-)<br>
<br>
-- <br>
2.34.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BL1PR12MB51441F33F4BBD0AD3FB03CDDF7C79BL1PR12MB5144namp_--
