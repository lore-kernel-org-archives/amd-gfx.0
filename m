Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2DB3C46CA2
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Dec 2023 22:20:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 27A3710EAA6;
	Fri, 15 Dec 2023 22:20:42 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2043.outbound.protection.outlook.com [40.107.102.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3CA6710EAA9
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Dec 2023 22:20:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VyxAnWuOSVwjL8cTfqTT8GNjCRCFHg1nuTC+BR2hHXvxN31phdvdvgaARHyAGYOrQ5PNM7XvA/3e5qJjV+2Uh4kjxbmbsWkr5JVkTzTVvUX6/JC5UaVvS492fJHH3VAxZDkBbd9Ifq8hamWoKVI06t+BOaaCfJDYSdFf6Fmnf01xbZ5r3RwxZz9SXqyt1/3Vyc7Ez66WyDBjNJWJCN6m29tPhM6FYNN2T8o5EQ0asK5CHzDRiyRHYYUCpOcXKJLco7X6CN6BB9OYPIGV4QhTNfsl5nk5GsiKdqhUBQVlw+5xtZTXzJcha3QziPqXff9DT1EJUxHDquJhknKjpnEgXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4swRF50jFvfGZo1h5K8TSRBDr+Q/s95CJKag2s6raOM=;
 b=BLU07aMsObqRfR+xwL9GnZ28eaGZTuewoPxAcnx5u/3YPyh0/jlSoDltmXNTeblo1mbUhHb9rSzNXuzuMm8MpPINruvV8He9ikjKF8M04LgHuJ/KBNNsHc703J4Vr3Yage23cJKC65EWQbFoBECaMg4OEKG41TVYPOl6JplnhxJ1GnAjaKQXURtXDYtU7RKA3KR/TAKrTSV/TiPwYdR6Zrx/UuzpmAC82NUfEcSA2O1KLAwrmeuIOcevFqmoJQuArLPz8g8bNr09yQrcO8aSwn+upjMSlWDccTbLgjeTjKicA05HxPodyOCRlLmDXEuyMmo4dKL1w/Ovxt2RVeGK0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4swRF50jFvfGZo1h5K8TSRBDr+Q/s95CJKag2s6raOM=;
 b=WHKFWUIqyAzGt6k4I97RzLwH1qAS16E09YzekUW9FyrCUKFwOesWljMSlINFav0Vj5AO5aMeskidMSsatZXBKz7B9D/9Zwycw5s32XB3QqHoAPSkrl0dMwZEmEteUvog8+Xa2dHeX98BmlJ/AwYkO6L4rQuN7QGiCxixDb2Jqok=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by LV3PR12MB9354.namprd12.prod.outlook.com (2603:10b6:408:211::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.28; Fri, 15 Dec
 2023 22:20:37 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::f081:16c7:9129:c010]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::f081:16c7:9129:c010%3]) with mapi id 15.20.7091.032; Fri, 15 Dec 2023
 22:20:37 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Limonciello, Mario" <Mario.Limonciello@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 2/2] Documentation/amdgpu: Remove a spurious character
Thread-Topic: [PATCH 2/2] Documentation/amdgpu: Remove a spurious character
Thread-Index: AQHaL6JL4HpzlIqkeECDYHpNLtO0aLCq6ney
Date: Fri, 15 Dec 2023 22:20:37 +0000
Message-ID: <BL1PR12MB51447B4FEB1271926C68946DF793A@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20231215214600.22479-1-mario.limonciello@amd.com>
 <20231215214600.22479-2-mario.limonciello@amd.com>
In-Reply-To: <20231215214600.22479-2-mario.limonciello@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=True;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2023-12-15T22:20:36.796Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|LV3PR12MB9354:EE_
x-ms-office365-filtering-correlation-id: cc684766-6d9b-4373-9332-08dbfdbc1040
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /pgkgU1SjTy8p1ZYn0yHXsDeeR9JhWHGsqvTVWax8Lrjxe/VUrTdt+JCNSiB9f5GrgDVgnuoG3DLvXEMeHszVaSNGLNVsouYz6WjI7l7v+zzxIa+SQc9sFJPJJTTbeiqCcxpb6L+ILHstLa6FtNpYxUav7/il8jMf6gNTs4VrJuTJAYOuYLs8cSAzoHh5TMNqbWpcZ3Q+WfmTnsewDH81iuKoHpvWAnECSn2xL+jnM7uroyEJVH8s/ZCZZIpw/BFPdLgmOulE22IjnKmkf5g4wcvlR1DO3e6hmKSRTWstESnDGp34Q6kjGcPjKYTtyh0etN5VMyIghRjIVaHpvqtbVqij9fKEuZFzThQaYqvR8x0nvUWI4B2bUq2/OBkP80YHu+5Ms8muUOufDTvoWmnc+aA1qXfpKuCnjaW1kJ/tR5J5lvIvsDQoCpDcMSeZMbmJHH/F7FtnokXbfeutFeuTrHzmXc5mqWxELXe7Mo8H3cbmqLwTDMNTzwl6qhPD+LtlA8w0cveAXh5MdImNYM0ovNlxN/ypHHV1/sRQvndgqYEpq8c0kHy69qU4U9o9JFyX+1++b696/sc+emsEsW/nqSKq6bxZKsCuuTC0OqNSQFdhB8EZuyDk/Wtkt1PmP+b
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(396003)(136003)(376002)(346002)(39860400002)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(66446008)(76116006)(64756008)(66946007)(91956017)(110136005)(55016003)(19627405001)(71200400001)(66476007)(66556008)(478600001)(52536014)(86362001)(5660300002)(316002)(8936002)(8676002)(83380400001)(9686003)(7696005)(6506007)(53546011)(26005)(38070700009)(122000001)(41300700001)(33656002)(2906002)(38100700002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?fnU0eNUGhADnOhjIVJlbHwE0Foztz9NRbYh0xNCbqYLNPRZyt05Gfp0AHWT8?=
 =?us-ascii?Q?LEa2extPbppagEljbWtyUCLVzddLskBbRlVXXiVdvgOAiPEW1kgQBkdtnAGk?=
 =?us-ascii?Q?GF233dUat7LRk/EWW1AZxu+llbtgRziv/e3MG4p6sUPjexNf6uy+aHaMiXQ4?=
 =?us-ascii?Q?d/8Ie3UCsIRrjKZtNENnvA5NphmH5KVCGVxDfWIYoykCnNg8BEEjSBADvHmA?=
 =?us-ascii?Q?UUwr8l1519mrtWouw/lCSKC+7CxBI4m8w7WBe9BYS/P/9I4Fg3KsqTI/p3Qd?=
 =?us-ascii?Q?oYuyCCjrlkqUFuVpNxOelXWy6M79HnSkmP/RIY5YQTy5ZnxFwMOJ6Eji63zQ?=
 =?us-ascii?Q?E0J9783rJdWe3QKyWXRv3apSYId5M7lTtYKxn9ceP8Pu0MYbAQghWOIlqFm1?=
 =?us-ascii?Q?x4xOIs6hdOupqNAO539CEZ2nGyLgslAIiWBQan4NqEMoYZTszVi+h67d3X2w?=
 =?us-ascii?Q?WKxDLMxoQiKgZhG5OwPntPvVQbfel6a73z+My94PtpJXEOi4H9NXFjomhSFd?=
 =?us-ascii?Q?wZaFaHvh8eMChWA/69QW6Us1JZYonIDAjkU54i/MvLYn6Lpq9C35mL0UQpuA?=
 =?us-ascii?Q?9Jt8h7T+vYY07x4XqmJW5X5ZfeJACJVqqsMuwq2s0r9qL3Kt3l6wUb1kFetT?=
 =?us-ascii?Q?F8xJ8BJaoC/4ow/8KmAAyN0QZwGfAY56fp190ROdLOYERZbqn3uM4eYbY2Mg?=
 =?us-ascii?Q?Pp1YEOflMyqNxTRGO5tDVbdovvVK1nJShL8M8O9fe2EoCtgFo6jFIZhmXVY+?=
 =?us-ascii?Q?upY6pKkBitL7U6b2NcKwIWzyb5nrP+xgnVXruASNwUlcrjUsNOki0Y0RSC80?=
 =?us-ascii?Q?tfo9Tm8UvSIJods3RS/+cR6iM+MGfto3XJ589cdPXAZkImwV+NTO5M6ZrB72?=
 =?us-ascii?Q?WBQ1d8zoy1rVllt2WppjzlsFrCnA5HvpJdyObfqgPQGRZVvK5sXiovjPH8Vx?=
 =?us-ascii?Q?2t0pSiNDWOoVPVN840x+kx30xn3lPZIMk3BJh3J0gxStRzWXcuFuXxy6gfhO?=
 =?us-ascii?Q?0Ea8OS8QUO3EcOzZSZS40Ich3kSQ7hm8LI4lpe9EoI6LWo6ORut+UfYUoNvH?=
 =?us-ascii?Q?pHTqcYemQSsOFMFensnlsxNJQOFTJ+lIMjkg3BTCug9CkjA/FENkKPZJvMVe?=
 =?us-ascii?Q?RjmsdT4BZZj0piFD++ZMY1mH+ZbKd7vAcaV+8K9aQ/HftccdVqPYB9Ne0Pd5?=
 =?us-ascii?Q?oZeNMaBDHN+03ahw8HwKCtqwmGvwT6/65DZk+MCXqMiPz7LlOhKIupMRz0bt?=
 =?us-ascii?Q?f3WXH0D7xaJ5GEMUVsB7jT4pZN/TnI1Jreba0w8oYBGDGKS6VSg2tmti0VB+?=
 =?us-ascii?Q?9Lkyp5qil/OPp2QuhFj4kIUAR1t0f3wgJ8vzuJYxYYlgTEZcRG8a343XvCf1?=
 =?us-ascii?Q?eCOvE9koCzBlcUqGkFUct0NqFrJhK29G0keCwLfLoUuTdohFJfMM2zG8n0K5?=
 =?us-ascii?Q?SqTJoJUS/Q4Aca6ELfVC3uMoJSKFbUEKHdshWfOastaRS4Qks5QmgvGlOE09?=
 =?us-ascii?Q?pkjsEUU5xYXQOXloCvbUXFLsHHbcONItMDPrdwn2TnB7cnxeQN9fLNbkZv9y?=
 =?us-ascii?Q?TDKnsQrFmN/2fIHswJE=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB51447B4FEB1271926C68946DF793ABL1PR12MB5144namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc684766-6d9b-4373-9332-08dbfdbc1040
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Dec 2023 22:20:37.1190 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ffibxaELEIRyQj1g5/k/sGR6bIzer2VZEuY3CiVA5ypPqn8svL9+DsK7zDj69e2ZqU9iCHA9hIwbd0R3y3nGJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9354
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

--_000_BL1PR12MB51447B4FEB1271926C68946DF793ABL1PR12MB5144namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[Public]

Series is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Mario Li=
monciello <mario.limonciello@amd.com>
Sent: Friday, December 15, 2023 4:46 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Limonciello, Mario <Mario.Limonciello@amd.com>
Subject: [PATCH 2/2] Documentation/amdgpu: Remove a spurious character

`/` wasn't meant to be in the Dragon Range line

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 Documentation/gpu/amdgpu/apu-asic-info-table.csv | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/gpu/amdgpu/apu-asic-info-table.csv b/Documentati=
on/gpu/amdgpu/apu-asic-info-table.csv
index b8ada69919f3..18868abe2a91 100644
--- a/Documentation/gpu/amdgpu/apu-asic-info-table.csv
+++ b/Documentation/gpu/amdgpu/apu-asic-info-table.csv
@@ -7,7 +7,7 @@ SteamDeck, VANGOGH, DCN 3.0.1, 10.3.1, VCN 3.1.0, 5.2.1, 11=
.5.0
 Ryzen 5000 series / Ryzen 7x30 series, GREEN SARDINE / Cezanne / Barcelo /=
 Barcelo-R, DCN 2.1, 9.3, VCN 2.2, 4.1.1, 12.0.1
 Ryzen 6000 series / Ryzen 7x35 series / Ryzen 7x36 series, YELLOW CARP / R=
embrandt / Rembrandt-R, 3.1.2, 10.3.3, VCN 3.1.1, 5.2.3, 13.0.3
 Ryzen 7000 series (AM5), Raphael, 3.1.5, 10.3.6, 3.1.2, 5.2.6, 13.0.5
-Ryzen 7x45 series (FL1), / Dragon Range, 3.1.5, 10.3.6, 3.1.2, 5.2.6, 13.0=
.5
+Ryzen 7x45 series (FL1), Dragon Range, 3.1.5, 10.3.6, 3.1.2, 5.2.6, 13.0.5
 Ryzen 7x20 series, Mendocino, 3.1.6, 10.3.7, 3.1.1, 5.2.7, 13.0.8
 Ryzen 7x40 series, Phoenix, 3.1.4, 11.0.1 / 11.0.4, 4.0.2, 6.0.1, 13.0.4 /=
 13.0.11
 Ryzen 8x40 series, Hawk Point, 3.1.4, 11.0.1 / 11.0.4, 4.0.2, 6.0.1, 13.0.=
4 / 13.0.11
--
2.34.1


--_000_BL1PR12MB51447B4FEB1271926C68946DF793ABL1PR12MB5144namp_
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
 Calibri, Helvetica, sans-serif; color: rgb(0, 0, 0);">Series is:</span></d=
iv>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<span style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService,=
 Calibri, Helvetica, sans-serif; color: rgb(0, 0, 0);">Reviewed-by: Alex De=
ucher &lt;alexander.deucher@amd.com&gt;</span></div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Mario Limonciello &lt;mario.l=
imonciello@amd.com&gt;<br>
<b>Sent:</b> Friday, December 15, 2023 4:46 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Limonciello, Mario &lt;Mario.Limonciello@amd.com&gt;<br>
<b>Subject:</b> [PATCH 2/2] Documentation/amdgpu: Remove a spurious charact=
er</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">`/` wasn't meant to be in the Dragon Range line<br=
>
<br>
Signed-off-by: Mario Limonciello &lt;mario.limonciello@amd.com&gt;<br>
---<br>
&nbsp;Documentation/gpu/amdgpu/apu-asic-info-table.csv | 2 +-<br>
&nbsp;1 file changed, 1 insertion(+), 1 deletion(-)<br>
<br>
diff --git a/Documentation/gpu/amdgpu/apu-asic-info-table.csv b/Documentati=
on/gpu/amdgpu/apu-asic-info-table.csv<br>
index b8ada69919f3..18868abe2a91 100644<br>
--- a/Documentation/gpu/amdgpu/apu-asic-info-table.csv<br>
+++ b/Documentation/gpu/amdgpu/apu-asic-info-table.csv<br>
@@ -7,7 +7,7 @@ SteamDeck, VANGOGH, DCN 3.0.1, 10.3.1, VCN 3.1.0, 5.2.1, 11=
.5.0<br>
&nbsp;Ryzen 5000 series / Ryzen 7x30 series, GREEN SARDINE / Cezanne / Barc=
elo / Barcelo-R, DCN 2.1, 9.3, VCN 2.2, 4.1.1, 12.0.1<br>
&nbsp;Ryzen 6000 series / Ryzen 7x35 series / Ryzen 7x36 series, YELLOW CAR=
P / Rembrandt / Rembrandt-R, 3.1.2, 10.3.3, VCN 3.1.1, 5.2.3, 13.0.3<br>
&nbsp;Ryzen 7000 series (AM5), Raphael, 3.1.5, 10.3.6, 3.1.2, 5.2.6, 13.0.5=
<br>
-Ryzen 7x45 series (FL1), / Dragon Range, 3.1.5, 10.3.6, 3.1.2, 5.2.6, 13.0=
.5<br>
+Ryzen 7x45 series (FL1), Dragon Range, 3.1.5, 10.3.6, 3.1.2, 5.2.6, 13.0.5=
<br>
&nbsp;Ryzen 7x20 series, Mendocino, 3.1.6, 10.3.7, 3.1.1, 5.2.7, 13.0.8<br>
&nbsp;Ryzen 7x40 series, Phoenix, 3.1.4, 11.0.1 / 11.0.4, 4.0.2, 6.0.1, 13.=
0.4 / 13.0.11<br>
&nbsp;Ryzen 8x40 series, Hawk Point, 3.1.4, 11.0.1 / 11.0.4, 4.0.2, 6.0.1, =
13.0.4 / 13.0.11<br>
-- <br>
2.34.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BL1PR12MB51447B4FEB1271926C68946DF793ABL1PR12MB5144namp_--
