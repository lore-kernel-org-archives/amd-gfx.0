Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEA42C6FA99
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Mar 2023 18:29:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2B9BF10E314;
	Fri, 10 Mar 2023 18:29:57 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2046.outbound.protection.outlook.com [40.107.220.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 41BB010E313
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Mar 2023 18:29:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hJx+zK8LFyVUoXYL7U9Xxc/G/Nz+xnbk0QO1I1xjXX9ipoykJcyV+0hKhrBh89sCziCfAfT7Tg+DfcjHubaxUEpBJRX4yTk+5n62ROhK8gomNr+wVpW1Qb7ad1Cilkv4Cmh+NBPS6z4sbBzRNcFskcRda2b8fNW+xmW43zLPOfg2Zv/SC5qvTxrMuEezAAQqAbETWIuPfquJsmPID5xRTio6XkFNnf47RW8cnDFhz8eJHuIoufp9m0zGXfyR2a8uxxetc6oy833dhUa6MD8Cetg/o+ntt0HFrr/SPrMyN71XNK7tItyN7bs+zytosVG8EIk9Ugt3S87DU2zbHIds4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E0YklYgMjmREF/zcKnd5iSoK6/7xa4CTI9ZQ3NWAJWw=;
 b=l6dPoS6buNj3R6aX8R5lYwfiabY5ugs7Uvg8FmVHRC2sRcNKZ6+rzoyqMdhyAclADjhC3Jjc5xPM6OvmRJQNGDF97grQuitheEZaenMW6NkiaCr47JWJLrttJUO/Goy2D2G68YIDs2hWQNYGOjZbSGvsEAP21Kt7Iow63dL8J/e4KLFl5NpBR0HL7crNcBkxVpF6Z4hzTTB81zxWAaudicCyLeI6RpDwXQ2ohf6oZExIbtc+ceyu4EyNUc/bg6QAmZfOasD3fhIkDL03Vt4CSdFsdKwitfHuu1x70sQqzmDrVeU3cP+4bA9cFI+EYIjLL1OaipInyNAiXohh4v8a6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E0YklYgMjmREF/zcKnd5iSoK6/7xa4CTI9ZQ3NWAJWw=;
 b=cYEKy0lVyPDybk+27713C3KUbfEx36f1GrxUCaRnqhtnQfWHLErTtAgRwJXFn/P/PX527u9VmzizcwZCSxW0eSzoEPEnAaWXscEbSxMejHJh+EtNyr4KUwoGCpwo4bI6FQ8q+loza93cQtHtblEnNnLFNpkCwKgmBVVRkX/ZIKI=
Received: from PH8PR12MB7279.namprd12.prod.outlook.com (2603:10b6:510:221::10)
 by PH7PR12MB6787.namprd12.prod.outlook.com (2603:10b6:510:1ad::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.19; Fri, 10 Mar
 2023 18:29:51 +0000
Received: from PH8PR12MB7279.namprd12.prod.outlook.com
 ([fe80::2a8d:2702:556d:b71f]) by PH8PR12MB7279.namprd12.prod.outlook.com
 ([fe80::2a8d:2702:556d:b71f%8]) with mapi id 15.20.6178.019; Fri, 10 Mar 2023
 18:29:51 +0000
From: "Lakha, Bhawanpreet" <Bhawanpreet.Lakha@amd.com>
To: "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 1/2] drm/amd/display: Add missing description to DMCUB
 definitions
Thread-Topic: [PATCH 1/2] drm/amd/display: Add missing description to DMCUB
 definitions
Thread-Index: AQHZU3iY/grKhoANA0C7GwBUy92yNq70VXRd
Date: Fri, 10 Mar 2023 18:29:51 +0000
Message-ID: <PH8PR12MB727944F7619681C29B392D80F9BA9@PH8PR12MB7279.namprd12.prod.outlook.com>
References: <20230310174849.1619771-1-aurabindo.pillai@amd.com>
In-Reply-To: <20230310174849.1619771-1-aurabindo.pillai@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-CA
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=True;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-03-10T18:29:50.780Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH8PR12MB7279:EE_|PH7PR12MB6787:EE_
x-ms-office365-filtering-correlation-id: e3a4a040-7f3f-4843-8f15-08db21956fcc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 81MrjZcIrczp+sT+JCkk2sYKRa6WF+1oJNlbz8tutyZHEx0h6q9P8pGYHDobi5AFbk7lvsPC+33y/VWraS4L+SV2VLCbXlBFyn+m22g7vICsgNQO0bH3WaxQF5oEO3RwRUIV8lMAnoTVk2KD4ETXxeA/VsZvvTgGBzrGeW+UXu4KTr7MLoYKX8xVjSmOwRWvny/upVzOHrfWDYALLD/AB4+PhY8UAm533FTO4hNDPfnM4N1NGEZ6srUvPCsNIPjDP8lmFjJMzRn+3JGtrXgQNO2Ei71G7x9c4LFxE0LN1w/lI6yCLFC/y2enXnu1Q6vD5irVAlbq0Hh/tmgfnJHahqaoq+JhLwguJ6rJyATd+He9HwQfYN/o6Ord+czil9KltNoeKYmMOKLUF1zxWwFv4G0NHVm+C0NqmPUigT+ueF86tKEf2DjRKjaCk+RA8ZMx/HUCBEvDJ/JZ7YK/f0yMiMUFUTCrkbWXlJ5VKbImnigliCDeExh9vbqekpNFsO2I7o4NtIXpiv22P5hCmzPtZ97nBFE0v0OMtzDjn5XlgDewQFdqDFGE+SfAPauiFMROBzJRC+d2bAUThSrXRlCgvu62qZDsJ++niEB+D3dIWnDdfYhJPzqXcoYWUmi/ePjGVMnp3wCir8+NvSKH1tUm4qrZs+nkujfVTWqynDo4jrhPdu3cWkuTV1vMNy8qMv8Lzs3ox8vRK94vfHRXaJU3TQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR12MB7279.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(346002)(366004)(136003)(376002)(396003)(39860400002)(451199018)(38100700002)(19627405001)(9686003)(54906003)(33656002)(110136005)(38070700005)(86362001)(55016003)(186003)(122000001)(53546011)(478600001)(6506007)(83380400001)(7696005)(71200400001)(316002)(66446008)(52536014)(66476007)(5660300002)(4326008)(41300700001)(2906002)(8936002)(76116006)(64756008)(66556008)(8676002)(66946007)(91956017);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?rXg1Q77zx58IPt2hUoAMPxXpOhCvQhsMFR3Ym3N1iV5tF1EcmoWACO2YTx16?=
 =?us-ascii?Q?FGhhQ9YWVp7UJxeuL2MQlcrQWhhGQXgpGLIg/YHwg17UKIdglwcM3Qxexmku?=
 =?us-ascii?Q?ddXM4+CdHPTsnKZ0ogTbKTDCPYo0Ndvtw3gus3/pk5IPqOtlJ5OtpbE/L7jU?=
 =?us-ascii?Q?qz1rnxJTz4P35KwGtdP8vRD3hSUYmrCXBO5nVgOANZqcUVIV307w3mJOGWAw?=
 =?us-ascii?Q?X6Ka4Osg4tvxwl3syJI+OH16R6eK0ydE1ct0UPr7BjzVCda2OtMIPEaFKFG1?=
 =?us-ascii?Q?1IV8WkMIXhmRm9n5uSOLbRywQN143hIoT9dco4Efiic3Bv5xwiVdEOYXA3hJ?=
 =?us-ascii?Q?HMDQVXAqzHaMYiaIliGg4bpiOWwWNNzsUCyTGEnaO3/rIuh0heQ9C9x20vJ9?=
 =?us-ascii?Q?AN/b0E4mpVTViibsKgX6rO0Zp1EEf/+VHMWhogZxqolLl5PlWG3AeggmG4t7?=
 =?us-ascii?Q?9tUmZn7rQ8lTznZ7XFLCSmQIAQjStoax3uCoOrezGzOfB4NV1FWMn6EUDL+L?=
 =?us-ascii?Q?7YRqpXeNeX8DUNEA4PbN/y37Vs64EYcU1Eb9AwbatBG4WwjJ1Couq5TZE+21?=
 =?us-ascii?Q?X+eK+vWzwDF/+jLFSPG118cmSLgPzgqtEn3cYztV2fvY7GMmc8WlpQvmlWSk?=
 =?us-ascii?Q?pB08phF0mEv6ceaCMplJaYLE6OS0xAsXnhpEkwzewhXVICzI7eTxOnG1HFih?=
 =?us-ascii?Q?ikrblqzcieo6mCI+9YeYlZ49ZCzhoSVcmvT/3mGGGm98B7ci+DD9wG9GH/Ps?=
 =?us-ascii?Q?UrZBsMOagalCg1CmJx39FtGASjJcOgdaT8wo6LognhchGgaxvAD1zU738984?=
 =?us-ascii?Q?wNFUnwIsDszgrVpRdH9ul2gTdc4Y0V6Wb3fd7qiEySNJqTZaV1o5+8kOHOam?=
 =?us-ascii?Q?Ft6vd8jATplftxCSksamrAgydBr+JW0L48vXBN4xKNu1YrpE+eiFQhbmtshn?=
 =?us-ascii?Q?kjLdIIUMBlTuH53BruAPkTS4ue1e34UNAO7TdPxYvwDC8zaqtadL9X/rCxmb?=
 =?us-ascii?Q?rSqobEXou5KxpEmwNVM3SuRef3XusW5qdWbW9riGedcxumEpDMTthOKE/CPb?=
 =?us-ascii?Q?VgR3aMQCF4hosmhxVpMXTWEgrfEWWsaG4S1ycBY8YY+CwGqly2NlBhsV/zfq?=
 =?us-ascii?Q?PfXhwzeQDG14PM7AyC4XCgdm4D9zfggpQhRKSpKCN3XHvn1NZA/GsU1iQeOF?=
 =?us-ascii?Q?bdn/pVnimYu1hU6l+imFo7Z4Mvx7vmPX7tA6Zbw713xOUdmEpzIHoktiX10t?=
 =?us-ascii?Q?TEhFJtRkSe6g46jrfUSOoldurl3OC/s7hkMOxcF83YTojzfg3z5xHzVuwEaB?=
 =?us-ascii?Q?C/+8q8ZGpYKtdA7MITlBa5AFOVTNyTUpIX5Js9dR6u8UL+cbbMqcZvMscd1y?=
 =?us-ascii?Q?NX3j0gYcWa0Nr8yT5fa96+6yWoGOUU7f/h8kX7RyKaT1pV7W25MGTBPrkSph?=
 =?us-ascii?Q?/sT/PUjHvoz/I9swxMCHpUZQsqzpamSCuMWA127kq1KJaAjtfqZTB4fNSLPA?=
 =?us-ascii?Q?8QQrbVx6Z1yc3zVA37aQex1ehS5W9fCCQ07ZOB2GkGRqyHcUPZ2wsZsqMZd2?=
 =?us-ascii?Q?WxJoMFz4L8Z+npXFg98IMMvaXQnMvgxZQG9Sy3mb?=
Content-Type: multipart/alternative;
 boundary="_000_PH8PR12MB727944F7619681C29B392D80F9BA9PH8PR12MB7279namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB7279.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3a4a040-7f3f-4843-8f15-08db21956fcc
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2023 18:29:51.2421 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: V8krKWVoGd4DyrcdFrGw7l7bA5WnCzYpJJ56pITCEbuN36hgc5n/xAmrEPpP+AOo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6787
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
Cc: "Siqueira, Rodrigo" <Rodrigo.Siqueira@amd.com>, "Wentland,
 Harry" <Harry.Wentland@amd.com>, "Mahfooz, Hamza" <Hamza.Mahfooz@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_PH8PR12MB727944F7619681C29B392D80F9BA9PH8PR12MB7279namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - General]

Reviewed-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Aurabind=
o Pillai <aurabindo.pillai@amd.com>
Sent: March 10, 2023 12:48 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Wentland, Harry <Harry.Wentland@amd.com>; Pillai, Aurabindo <Aurabindo.=
Pillai@amd.com>; Siqueira, Rodrigo <Rodrigo.Siqueira@amd.com>; Mahfooz, Ham=
za <Hamza.Mahfooz@amd.com>
Subject: [PATCH 1/2] drm/amd/display: Add missing description to DMCUB defi=
nitions

[Why&How]
Provides description for some enums used by DMCUB

Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/=
drm/amd/display/dmub/inc/dmub_cmd.h
index 734b34902fa7..4f67124d8e68 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -717,7 +717,7 @@ enum dmub_cmd_type {
          */
         DMUB_CMD__PANEL_CNTL =3D 74,
         /**
-        * Command type used for <TODO:description>
+        * Command type used for all CAB commands.
          */
         DMUB_CMD__CAB_FOR_SS =3D 75,

@@ -997,6 +997,9 @@ struct dmub_rb_cmd_cab_for_ss {
         uint8_t debug_bits;     /* debug bits */
 };

+/**
+ * Enum for indicating which MCLK switch mode per pipe
+ */
 enum mclk_switch_mode {
         NONE =3D 0,
         FPO =3D 1,
--
2.39.2


--_000_PH8PR12MB727944F7619681C29B392D80F9BA9PH8PR12MB7279namp_
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
: 12pt; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);" class=
=3D"elementToProof ContentPasted0">
Reviewed-by: Bhawanpreet Lakha &lt;Bhawanpreet.Lakha@amd.com&gt;<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Aurabindo Pillai &lt;aurabind=
o.pillai@amd.com&gt;<br>
<b>Sent:</b> March 10, 2023 12:48 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Wentland, Harry &lt;Harry.Wentland@amd.com&gt;; Pillai, Aurabind=
o &lt;Aurabindo.Pillai@amd.com&gt;; Siqueira, Rodrigo &lt;Rodrigo.Siqueira@=
amd.com&gt;; Mahfooz, Hamza &lt;Hamza.Mahfooz@amd.com&gt;<br>
<b>Subject:</b> [PATCH 1/2] drm/amd/display: Add missing description to DMC=
UB definitions</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">[Why&amp;How]<br>
Provides description for some enums used by DMCUB<br>
<br>
Signed-off-by: Aurabindo Pillai &lt;aurabindo.pillai@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h | 5 ++++-<br>
&nbsp;1 file changed, 4 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/=
drm/amd/display/dmub/inc/dmub_cmd.h<br>
index 734b34902fa7..4f67124d8e68 100644<br>
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h<br>
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h<br>
@@ -717,7 +717,7 @@ enum dmub_cmd_type {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DMUB_CMD__PANEL_CNTL =3D 7=
4,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /**<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Command type used for &lt;TOD=
O:description&gt;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Command type used for all CAB=
 commands.<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DMUB_CMD__CAB_FOR_SS =3D 7=
5,<br>
&nbsp;<br>
@@ -997,6 +997,9 @@ struct dmub_rb_cmd_cab_for_ss {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint8_t debug_bits;&nbsp;&=
nbsp;&nbsp;&nbsp; /* debug bits */<br>
&nbsp;};<br>
&nbsp;<br>
+/**<br>
+ * Enum for indicating which MCLK switch mode per pipe<br>
+ */<br>
&nbsp;enum mclk_switch_mode {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; NONE =3D 0,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; FPO =3D 1,<br>
-- <br>
2.39.2<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_PH8PR12MB727944F7619681C29B392D80F9BA9PH8PR12MB7279namp_--
