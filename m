Return-Path: <SRS0=Zxj3=KV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 104D4C2B9F7
	for <amd-gfx@archiver.kernel.org>; Wed, 26 May 2021 09:45:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C00EE61417
	for <amd-gfx@archiver.kernel.org>; Wed, 26 May 2021 09:45:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C00EE61417
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E0BA6EC24;
	Wed, 26 May 2021 09:45:36 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2058.outbound.protection.outlook.com [40.107.212.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E82416EC24
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 May 2021 09:45:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gHczPxcVCEcbKtk3fiSkLjLNfEksg0sp7/06YB1Q6ARr+gRRxYN5PPtX3USKrEhrIv5jFtT7VXsbakTq7Afjls5PnUmm6u7UM3vePoTEj7+Z1dCGt2NWjV1YH0CB0nbsQ4AukbIa49XfTHm3vH/AdgrzLSThayj2lsc+YfeZO/nmtp1O/lwtnXkIKlQx/HPzHckdOW6hTlQyeH/U4MWEqwDscguV/RsS+39pqqQSV/VxjC4m0FL/GnobBfJISGHNkcn1J4kJp5YunKo+WKxAm4AFdEPiuLNa2DlnTNkrPSOuUnZN/JoO1315EHP/zggTVCI5D3offDNjsXwaA20CpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=svG3ZcrLpGawhF+0jdf3N0g+brvjvNgcyEjZeT4yX2k=;
 b=flKeb7sLCv20iO7M3WmwKZBbLM6tI7pYRDL1gVrq618Hhxut1dLyiGZ7xlnQIlDMYuC8aS5/gDWjBphH9NSAOJ03ooxo2d9efGwFAG0t8glhIZwKt6bHJI+wZjRZ4xHvedBsgUKZ/zQkBKn6N8SRbF+sMXcTnBNHLxbaDgcGdMaghOHdKt0eZg9FpGePaLrE3E8+o8K4Se/hXhRUhrhqZn19FsjNKHNL1TT3G2e0Z0nk8Js2qULnOs5ZlxmadU/T4XtdpFjqwk/hrSkQgmo4qXtIqXXKrTyMrcqin7S1rmDaqZ1aak2qLoTgNj5NgFU6LypvCoJSvq26gi6x+67DZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=svG3ZcrLpGawhF+0jdf3N0g+brvjvNgcyEjZeT4yX2k=;
 b=oiyBpwauERcs9hfsBqXO08rG3b6QJh6OJuZfz+ZuTMWJkVnyKJzcZnb3EKh7uVP9tQ3Z5yveTjMz0LcccSa0yJfFSr/zs5rA2FEcg8WtrGp10/VlWBQWA3GPDdLiFzz8oU/GQ5wd+0qYP2ghVPQHb086h2vO2Jck17kXJq2+m6s=
Received: from DM6PR12MB4650.namprd12.prod.outlook.com (2603:10b6:5:1fd::27)
 by DM6PR12MB4106.namprd12.prod.outlook.com (2603:10b6:5:221::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.27; Wed, 26 May
 2021 09:45:33 +0000
Received: from DM6PR12MB4650.namprd12.prod.outlook.com
 ([fe80::b184:5f9:757:4848]) by DM6PR12MB4650.namprd12.prod.outlook.com
 ([fe80::b184:5f9:757:4848%7]) with mapi id 15.20.4173.021; Wed, 26 May 2021
 09:45:33 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Gui, Jack" <Jack.Gui@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amd/amdgpu: Disable page fault retry for beige_goby
Thread-Topic: [PATCH] drm/amd/amdgpu: Disable page fault retry for beige_goby
Thread-Index: AQHXUgOORKXJjpO9UkSSShXTBrdgtar1g6o6
Date: Wed, 26 May 2021 09:45:33 +0000
Message-ID: <DM6PR12MB46500D5AE09250E9BE507E6EB0249@DM6PR12MB4650.namprd12.prod.outlook.com>
References: <20210526074840.30310-1-Jack.Gui@amd.com>
In-Reply-To: <20210526074840.30310-1-Jack.Gui@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=True;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-05-26T09:45:45.416Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD-Official
 Use
 Only; MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.134.244]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 534e472d-4069-46a7-3f21-08d9202b018e
x-ms-traffictypediagnostic: DM6PR12MB4106:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB410690F08B675F7EAE4EA32DB0249@DM6PR12MB4106.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1388;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2qXWT26Au1y1kiBkOVyEKVuVo6DGGbxBSNK1tEnWDPV5Kqi27Ftzl+NkJDNdVagBDZwmAiav58GLzcPATsKkwP5U8eHxcRgU8Ve0bk17vtnwsUxXf6hx9xjFrtpbUO/rc70q9KgFles5+qzt4CNaUdt9yRXB2NI2RV+uWcIFa15eKIRv/poj34jflWheCYz6wIUyJ9dZl9CmJeDXQ9e8RS2qnmFbpXUgbl4hS+JxBrC3Jr4N27vKBw35jkUlDxr/ctkBFAv5sgUMH0c1LqS6wY38cHN+Rlnf23XfRV0DLZGX7Kn3W1kSnRdgMCVIW5v8yfPVc7CVMq5FfIA3GhtGvzE4oMAZoLufZNDCnyI+9qmPgMJvAwQ8x78S0MDemt5yhKxCIxxowsovnimuwQUXYsLSQNFnjYTNoHwINPTLvC0a1nNFN1HDTLC5Y1VQAj1GbVCuYSIoWTPrqCAtyVBsqFoYXjcbU+nUWqk3EEv5CoU2+zD5/qEvzbJIztlyKpldxhmFlQZMf5oHmbURwJRYUh4Xb8T4ftBrN1kRlel4eoC7zuJkZZvgnf4R49veXd4Q/tsxQn3GuORkoLGYkNF3VdlSAXNP19vpPCJUe9BEBqs=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4650.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(376002)(136003)(39860400002)(346002)(396003)(66446008)(66556008)(64756008)(91956017)(76116006)(2906002)(53546011)(54906003)(316002)(26005)(66476007)(71200400001)(6506007)(478600001)(7696005)(52536014)(66946007)(122000001)(8936002)(9686003)(8676002)(55016002)(86362001)(186003)(110136005)(4326008)(33656002)(38100700002)(19627405001)(5660300002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?lkJ9SXyJ05I7PAthy0Rrb8LpHrNH8jWEr2x6xE0JBsY18jiCxLMJwrA5WDJh?=
 =?us-ascii?Q?miOcIWtNVLGqg4/1xPwB+WsvsxDEU+lo3lyZmuMa65IxCcZp8XTxXFE7TUci?=
 =?us-ascii?Q?MyttW1Ma9A6kt1RNNmQpTxuWksde4J4F9d2+UduY1bg9CSKgSTuvPrn96Oyb?=
 =?us-ascii?Q?pl/b5RLJoX/Snq9VWWoQpn+25i/biUODmKXzPjLxXHjacmYAvXhFV8F10UzY?=
 =?us-ascii?Q?ucOr3gU8gyKr91nE1R/Y5938kVGarTXkYuKSv1SGYs3XoE1dg7Ld/n3JBaKp?=
 =?us-ascii?Q?0yrvdtDr8mCUCOrouUAC/fAXKhkYbTQS+Zin1P824CxxIo21J0WD9txUiW0z?=
 =?us-ascii?Q?ovG3fPHosFB01oxcgQvEBQ81KE1EsnBKwMyMG9QiHDND0rZXr1bZNbfwuGUO?=
 =?us-ascii?Q?pSNRn59lgkXHVcO8MsefOfuWXkdS9s+Ozqj81YY/n6TJoaaMp65iijjvLJDj?=
 =?us-ascii?Q?66los1c36eqdy3/aKaaxN0qPxf70b0Db00gpVhh7FVFTCKtM+0T+O6oNSED/?=
 =?us-ascii?Q?m8lMLVS5qVc6oo8NlFLJkLCFWBddo+Q1LzSbm1si1slXI8uQWnsNm7L/goeB?=
 =?us-ascii?Q?m4FibbVKfJN5WncNaAET8BjcQyWdbaKQ6PcFDKpJAux+cgyXolv0jHxYkXxe?=
 =?us-ascii?Q?gXngYoFlTAZxpOhqTYDWhsJ4mymCAdbKJeZM8KJH/oRdAiQS85lr8mRol4oh?=
 =?us-ascii?Q?2I7pbynuT/Ud44e2+M2dz8p/1tzgBtBLblnpC20YEpxLz94WsEyyfERlZf+v?=
 =?us-ascii?Q?8Wf0I7iu945fXzBmbvYy5vBTFlKsW6/8CCYYkmwqFDOIqiaHzKBp5Nz1xTPs?=
 =?us-ascii?Q?m1XgQoX2zAi0kacF5kxrK+9IKEy1cQ00kICcQ6GTpYVk+OiyvavoYfJaHGaP?=
 =?us-ascii?Q?gD0GjDM4vR+RLy2ijcVmorX2ca90p/rn0eEREWFXGiJC6QMw86kHSkzlGDxR?=
 =?us-ascii?Q?IQ77AM87FLY2885ezW0kOLNo1IpFGU2CiH6+yXFWF1Iu+Ak31lvJbOY4J8Ue?=
 =?us-ascii?Q?Sc/0AEs7zrNkCt02gfJe7ShGjOaQ4Ow/OYKlUVGhNKIifmDJBK+dFX2Po6Ot?=
 =?us-ascii?Q?WVzWdnQuIGddtGGCmqX5MJkpLWWVKPYVzyxyZjleIesO940b95p7eAUqlvYJ?=
 =?us-ascii?Q?w44NKzWlCtqzOqtQNRY6KFmMPLCGjDZ9at/MzCiL3Dxlq856eGdqntnozlNR?=
 =?us-ascii?Q?sfzQ8Z2asfHpv9p+EokE1JnL2K3bAC/WFcdV0tEYHXtcTXGzdtw21kD8at1h?=
 =?us-ascii?Q?bxRQL8fOQCByDQJ69mmhazTKkkj/bR3exKLAyYfkdJwAkXdC4WNs+HZlt8EN?=
 =?us-ascii?Q?+zUXWJUbtuExOG8Z80ZGYe6r?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4650.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 534e472d-4069-46a7-3f21-08d9202b018e
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 May 2021 09:45:33.0248 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xAfaKQiE1b6LIqEpkqW5roBrT+e/ePz0WG+lY9m+vOuw8NvC5TiM/RQkLBfGq/aH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4106
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
Cc: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Chen,
 Jiansong \(Simon\)" <Jiansong.Chen@amd.com>
Content-Type: multipart/mixed; boundary="===============0560665140=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0560665140==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_DM6PR12MB46500D5AE09250E9BE507E6EB0249DM6PR12MB4650namp_"

--_000_DM6PR12MB46500D5AE09250E9BE507E6EB0249DM6PR12MB4650namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only]

Reviewed-by: Tao Zhou <tao.zhou1@amd.com<mailto:tao.zhou1@amd.com>>
________________________________
From: Chengming Gui <Jack.Gui@amd.com>
Sent: Wednesday, May 26, 2021 3:48 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Gui, Jack <Jack.Gui@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>; Chen, Jia=
nsong (Simon) <Jiansong.Chen@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.co=
m>
Subject: [PATCH] drm/amd/amdgpu: Disable page fault retry for beige_goby

Set noretry =3D 1 for beige_goby

Signed-off-by: Chengming Gui <Jack.Gui@amd.com>
Change-Id: Ie679f9d6aeb5c45af1d3e4cb508d89c8510d8f89
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_gmc.c
index a129ecc73869..7fbb37051c6c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -589,6 +589,7 @@ void amdgpu_gmc_noretry_set(struct amdgpu_device *adev)
         case CHIP_VEGA20:
         case CHIP_ARCTURUS:
         case CHIP_ALDEBARAN:
+       case CHIP_BEIGE_GOBY:
                 /*
                  * noretry =3D 0 will cause kfd page fault tests fail
                  * for some ASICs, so set default to 1 for these ASICs.
--
2.17.1


--_000_DM6PR12MB46500D5AE09250E9BE507E6EB0249DM6PR12MB4650namp_
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
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:15pt;" al=
ign=3D"Left">
[AMD Official Use Only]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<span style=3D"margin:0px;font-family:Calibri, sans-serif;background-color:=
white">Reviewed-by: Tao Zhou &lt;</span><a href=3D"mailto:tao.zhou1@amd.com=
" target=3D"_blank" rel=3D"noopener noreferrer" data-auth=3D"NotApplicable"=
 style=3D"margin:0px;font-family:Calibri, sans-serif;background-color:white=
">tao.zhou1@amd.com</a><span style=3D"margin:0px;font-family:Calibri, sans-=
serif;background-color:white">&gt;</span><br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Chengming Gui &lt;Jac=
k.Gui@amd.com&gt;<br>
<b>Sent:</b> Wednesday, May 26, 2021 3:48 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Gui, Jack &lt;Jack.Gui@amd.com&gt;; Zhou1, Tao &lt;Tao.Zhou1@amd=
.com&gt;; Chen, Jiansong (Simon) &lt;Jiansong.Chen@amd.com&gt;; Zhang, Hawk=
ing &lt;Hawking.Zhang@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amd/amdgpu: Disable page fault retry for beige_=
goby</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Set noretry =3D 1 for beige_goby<br>
<br>
Signed-off-by: Chengming Gui &lt;Jack.Gui@amd.com&gt;<br>
Change-Id: Ie679f9d6aeb5c45af1d3e4cb508d89c8510d8f89<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 1 +<br>
&nbsp;1 file changed, 1 insertion(+)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_gmc.c<br>
index a129ecc73869..7fbb37051c6c 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c<br>
@@ -589,6 +589,7 @@ void amdgpu_gmc_noretry_set(struct amdgpu_device *adev)=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_VEGA20:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_ARCTURUS:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_ALDEBARAN:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_BEIGE_GOBY:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; /*<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; * noretry =3D 0 will cause kfd page fault tests=
 fail<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; * for some ASICs, so set default to 1 for these=
 ASICs.<br>
-- <br>
2.17.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_DM6PR12MB46500D5AE09250E9BE507E6EB0249DM6PR12MB4650namp_--

--===============0560665140==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0560665140==--
