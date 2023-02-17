Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8682C636CC
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Feb 2023 01:28:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2CF8D10E138;
	Fri, 17 Feb 2023 01:28:06 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2084.outbound.protection.outlook.com [40.107.244.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 508E410E138
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Feb 2023 01:28:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dz+oQaXgS1l2OyRYdKmatsyAIghDFhIGmynHopgAxE+za+CIFYsFX7cVXwBwPY/N2F7FYhuOSEb+bHqvKiTOcZSGBzrUrWBC5aeQnrL+tW2rveHEVLzNohxiJEwvvx8pRoECVQzagffEDj5y1QYYaSKOdibpLfJmxtSuuimhMY1xnbl0Qh6zuSVrmG/CzVd+XMcp4/wI4aZBYYpWce9JqUwTBvQjzSKpt++98rRwKuATbyg/SbYizUrXdZKLOcglCAFtk2efY1Mg3ne8olfDy9PH57+WqPC1mt6kcPaKZ+1JKZqNrjROo/8QdgKWmDzlN6Z5OWbA76UoMkRHELZFBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L7B0EKLKpJAsmd1QaZGB2wluqreooQkYNeh4Dxb6gZk=;
 b=XtybbDK4g33Jtq8WBrw3VVevWdybQZU8+xH9rJtQ/ihYjbt8awJhlmrGx8Z4QTtRAsQXGb+WGGC7vg7qFTynQBRbzrL5lSFW5EH2Jbxk5iA9tVVOG8VuDszSWRfKM7RnI4SG1q8AB++U+x8xY9dvNAZCLOOeIsGBFmIcwWjYygKR0RlyI8/MXQbsqafyZYeY5aRRvKBNAtZ6Jgh76KYM6bNyfQ51dM0aMYmUXTNpF7XxBYSDvyO5Hycd0Nlx5Tyq0heSd2rAsaKznLOoHgkevEe0KH1zM1E8p504MR1V55z0TLW+UolGnvjXl9V3G5XrcZdodv6/+THH9Evr7YeaPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L7B0EKLKpJAsmd1QaZGB2wluqreooQkYNeh4Dxb6gZk=;
 b=GE08u1ZZPhSh4TFgF8QG66mJ9QQz5A8C+HOQrkbLVjAkgG9v2kQLalMWezI//OFyRAfava/w88qQZAPEsVyTO6e5ZRJ5IFtBKzBScHnDU/QI5UmNgS31U4s9CDGjX5Ey38sTmPdl9MUwnFwHmaC23uuHiZbY98xfvMmj7Iw7w2o=
Received: from DM4PR12MB5152.namprd12.prod.outlook.com (2603:10b6:5:393::16)
 by PH8PR12MB7448.namprd12.prod.outlook.com (2603:10b6:510:214::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.24; Fri, 17 Feb
 2023 01:28:01 +0000
Received: from DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::8662:7aff:5c10:42d7]) by DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::8662:7aff:5c10:42d7%6]) with mapi id 15.20.6111.013; Fri, 17 Feb 2023
 01:28:01 +0000
From: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Zhang, Yifan"
 <Yifan1.Zhang@amd.com>
Subject: [PATCH]: add tmz support for GC 10.3.6 
Thread-Topic: [PATCH]: add tmz support for GC 10.3.6 
Thread-Index: AdlCbv0PHa8imUi5TB2aZmqtcXRTNA==
Date: Fri, 17 Feb 2023 01:28:01 +0000
Message-ID: <DM4PR12MB5152565187819FAA3A7D1AD9E3A19@DM4PR12MB5152.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-02-17T01:27:58Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=30302db9-1546-4a14-b6b3-34db80cdf622;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2023-02-17T01:27:58Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: 4f8b01f7-6ae1-450c-80cc-c3896e7bb9e5
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5152:EE_|PH8PR12MB7448:EE_
x-ms-office365-filtering-correlation-id: f6df520a-3468-4fc4-24fb-08db108635ac
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nXuprR9ZRykT1KTymaHnbnV/qnpqyXadeg0q8/M4krsvjozPB5igYifNIcg1giHFrUgDB9ZSIdxAtc5x5vfcPQjdd8Kgl2IfDIg1RlzmyRMAPAmHAZyyS7ez3kb0Jdhc4HECvwGfiIRe4oKZmJmOsTaByPFt81teHiCrgv6qYkWH3huuIHhft0sqzMP3soD6E7TWg+RjlCxCsSw2DZlFTfQ5D4VF1DdkMr0zAXDZDAo0edCk2b1bgj5Uivzej+amaAZAoGTO493XYBMnO69w18QBnSXNdcJruO6MBIlK79SwX95nC71QYb/ov6tE5qfrKaZ3Jrfnsmqetig14MuSz8zAJghIF3iln/lRG3qyd+OX7zinudUkDmt54M2NqKH2zLQ5hCMqLkXp8tkny+wIFXTTSacAapZmDQhThPjqX6SYnRkjM6kox5kwgA25y8T4rwTlgPP6g9LGhSuoobJSYDSYy6s5PIZ1fdTMWxtXHhJoppDKoKHviP+JOAljtchaQCJ6y+8uNL17ZXQB7357DSo0kP/3Y3H/Aq6KdYSeOOPzXklXFaeF/sk7/eVM2AvXc80SC12rtZeHHqjq5QBOqqs6OxLsusMBhJ1rP0Or697C2w0u09wj5BxuSgU8wPwFNkCKlUhVBsQNQ6fTgvbyVFFcJlvXkO+FgISM9ZyPyvc6OQmqVup4JUx3rKvffHXt
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5152.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(136003)(346002)(366004)(376002)(396003)(39860400002)(451199018)(26005)(6636002)(8676002)(71200400001)(76116006)(4326008)(316002)(110136005)(66946007)(186003)(86362001)(55016003)(122000001)(38070700005)(6506007)(38100700002)(66556008)(9686003)(33656002)(2906002)(41300700001)(4744005)(4743002)(478600001)(7696005)(5660300002)(64756008)(66476007)(8936002)(52536014)(66446008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Q/HswaSxrBA29VkJ8ZzrKeoJviCAa9BwjE1NzTQR+mlz3AiD+7hUiJjRM9lA?=
 =?us-ascii?Q?QftvuDx+5N/C3/G66cqbSueqkw4TQ6txB7fzFXpvWKgdOEYkVhIJBd60fSus?=
 =?us-ascii?Q?Koa+MuCfN+KgzaVcFnuu1F+Plpe+xaSh8jfZxlCSSFrI93pXdAkYJ7oTyxuS?=
 =?us-ascii?Q?xvyMF5rxV5fFZG8RA4KXmBrVEBkh3zwjyHWVbfUrw4RxsZqhZPsRfAv/zlb2?=
 =?us-ascii?Q?umq8+CYWbmGFTpc2stRAPMZqYgFUVKY1PMeruqTesPL6s8wilmBCU971ethd?=
 =?us-ascii?Q?aWoJn14GbsO15osaVAU5+4Q+ofxUIZAPNWLk1GkiR/rWENYTu/rDDBuJknM2?=
 =?us-ascii?Q?t+RhqUKEDTjMHLAIv3fvJdRlmKl3kBXG8mC772M8pz85UrkTxJJmN3yuw6sp?=
 =?us-ascii?Q?VUFz48QPtEO2Y5FWZkpV74fs6kxURMveEc2ZkLQ5OI7+ChDONQQjtsz/rbOO?=
 =?us-ascii?Q?ra3ooPRr8PhZ85CBoEhygQfDFgvmlWGM9DFI57pTUYo+htXlMxL0MZdudQQH?=
 =?us-ascii?Q?xifJKK2cmDNi0baD2AYAdBMq+3qelwTzJIc5fJFlnnaIZIDNJDGDO5EEhtc7?=
 =?us-ascii?Q?cHePnHGlSsV5ljfsm/iv4Sn7uPjeqEnvgAzR/bUFvnuvT8sm9sX/dNK1ko4f?=
 =?us-ascii?Q?TV0MDfZsFQbXIWPKN1j5PtLSZzGdBeGgJl+wRXd71IRxZaeBB+A/QXsbXHiZ?=
 =?us-ascii?Q?c7E6UuLjk8QtrVfC/3Qg8P4L6N9CGmlYg67l3edp8WHVQ/p2XuNXUJabWeHD?=
 =?us-ascii?Q?8oePlCN4huv/XQOdaGnDtBNCPOfJbIUhVBGFiJ8ah7+JEZSdIwtmQuhOYTMQ?=
 =?us-ascii?Q?jVQURc189k+NY9zmibdwBTN1iPBIfv8GQH3YCkheeaAR9uogzZppzOb+yUx6?=
 =?us-ascii?Q?iBswy9Wa3LW8jB6ZQktDF+LRAz7s5lfA/4+laEdeVXEvLH4L5GJdsUPBBPtf?=
 =?us-ascii?Q?sm9stkRws6w1twYCp9FRGreV0dZi9DpuWCA6cxf3nAIQQgodJr00HSyAWg0P?=
 =?us-ascii?Q?zWYic4W1kHSYc/07J8vIqq20U7NG2lR9HgI8aWQwk75FnHkbhNj+UOuIZErK?=
 =?us-ascii?Q?oqETKmfhgVseJVEdbuRhIy/P8NM6KrQULozLskZ3ZYVblCrjdvMWnJhWBLU9?=
 =?us-ascii?Q?dILivV3UmTIay3UTXc2E3ryHcZiO56qFLc6QZw67VRdA9eXTdpZw+20A58he?=
 =?us-ascii?Q?3/5iFiGQ2FXCfyzzxo6etoXYtHNl9ZK00+mArWLcWoTk2She9vXZQFqSltv8?=
 =?us-ascii?Q?pCj7d/0bVfncZc/656WMu1gLS5cTCZC1KwBXx244f2hBRo/n/hNjh3zIY0xA?=
 =?us-ascii?Q?zfJT+9oPhleYTnH6qEs188KOe3XicTQyw+eiavr88TI9QEq0s/ShiDl0uEsa?=
 =?us-ascii?Q?AffzxshmvAe6ejRoKu03XdzoEPvK5ilJq5il1VMfaRmkvHZdJEbyZ45fS85r?=
 =?us-ascii?Q?ryyVb7L/NA/pFDDt8VK8KkBFT0LKMLlSP0rUvY2ReYpM8LqmyGTkeLg0ynk+?=
 =?us-ascii?Q?zV6B430NCYBVFmGcAGLeBEbKSeYR95szMWs4h1N5FZnVY9ppJB+OfhqshVDS?=
 =?us-ascii?Q?YY/IDYwKVjcp0VgEGnBTNh2c9bPKCGEQd7C25Am+?=
Content-Type: multipart/alternative;
 boundary="_000_DM4PR12MB5152565187819FAA3A7D1AD9E3A19DM4PR12MB5152namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5152.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6df520a-3468-4fc4-24fb-08db108635ac
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Feb 2023 01:28:01.4725 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2HVAUH2W+tPmozkU0dUzsB7zSMyo9Dpng1YSqhx1bYpx0p36ZBQwOk0KmXQ3WVaiaQpxBFzsEEo54uzTaNTPhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7448
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
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_DM4PR12MB5152565187819FAA3A7D1AD9E3A19DM4PR12MB5152namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - General]


    drm/amdgpu: add tmz support for GC 10.3.6



    this patch to add tmz support for GC 10.3.6

    Signed-off-by: Jesse Zhang Jesse.Zhang@amd.com<mailto:Jesse.Zhang@amd.c=
om>



diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_gmc.c

index adfc7512c61b..6830f671cde7 100644

--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c

+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c

@@ -551,6 +551,7 @@ void amdgpu_gmc_tmz_set(struct amdgpu_device *adev)

        case IP_VERSION(10, 3, 2):

        case IP_VERSION(10, 3, 4):

        case IP_VERSION(10, 3, 5):

+       case IP_VERSION(10, 3, 6):

        /* VANGOGH */

        case IP_VERSION(10, 3, 1):


--_000_DM4PR12MB5152565187819FAA3A7D1AD9E3A19DM4PR12MB5152namp_
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
	{margin:0cm;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
p.xmsonormal, li.xmsonormal, div.xmsonormal
	{mso-style-name:x_msonormal;
	margin:0cm;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-family:"Calibri",sans-serif;}
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:72.0pt 72.0pt 72.0pt 72.0pt;}
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
<p class=3D"msipheaderdf3d92d6" align=3D"Left" style=3D"margin:0"><span sty=
le=3D"font-size:10.0pt;font-family:Arial;color:#0000FF">[AMD Official Use O=
nly - General]</span></p>
<br>
<div class=3D"WordSection1">
<p class=3D"xmsonormal">&nbsp;&nbsp;&nbsp; drm/amdgpu: add tmz support for =
GC 10.3.6<o:p></o:p></p>
<p class=3D"xmsonormal">&nbsp;<o:p></o:p></p>
<p class=3D"xmsonormal">&nbsp;&nbsp;&nbsp; this patch to add tmz support fo=
r GC 10.3.6<o:p></o:p></p>
<p class=3D"xmsonormal">&nbsp;&nbsp;&nbsp; Signed-off-by: Jesse Zhang <a hr=
ef=3D"mailto:Jesse.Zhang@amd.com">
Jesse.Zhang@amd.com</a><o:p></o:p></p>
<p class=3D"xmsonormal">&nbsp;<o:p></o:p></p>
<p class=3D"xmsonormal">diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.=
c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c<o:p></o:p></p>
<p class=3D"xmsonormal">index adfc7512c61b..6830f671cde7 100644<o:p></o:p><=
/p>
<p class=3D"xmsonormal">--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c<o:p><=
/o:p></p>
<p class=3D"xmsonormal">+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c<o:p><=
/o:p></p>
<p class=3D"xmsonormal">@@ -551,6 +551,7 @@ void amdgpu_gmc_tmz_set(struct =
amdgpu_device *adev)<o:p></o:p></p>
<p class=3D"xmsonormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_=
VERSION(10, 3, 2):<o:p></o:p></p>
<p class=3D"xmsonormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_=
VERSION(10, 3, 4):<o:p></o:p></p>
<p class=3D"xmsonormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_=
VERSION(10, 3, 5):<o:p></o:p></p>
<p class=3D"xmsonormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSI=
ON(10, 3, 6):<o:p></o:p></p>
<p class=3D"xmsonormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* VANGO=
GH */<o:p></o:p></p>
<p class=3D"xmsonormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_=
VERSION(10, 3, 1):<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
</body>
</html>

--_000_DM4PR12MB5152565187819FAA3A7D1AD9E3A19DM4PR12MB5152namp_--
