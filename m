Return-Path: <SRS0=YIqZ=K6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7374AC07E94
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Jun 2021 07:59:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31F6161405
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Jun 2021 07:59:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31F6161405
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E53FC6F5C4;
	Fri,  4 Jun 2021 07:59:42 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2065.outbound.protection.outlook.com [40.107.93.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1356B6F5C4
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Jun 2021 07:59:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LZCS72y+tgoY+d1ebdzBnlfjYELdQrSa/dvuBCdoWZEZ/QbCdqWFD/s6mxXSymyBlXx5cbKyWLev4UuwMAQpza3muYlj5Hq/MXo9NmsXg3H0JeyPMKWruPEtpSflRlT2cTusGcM/pCRXv5zY4I198IRMcJb/+RlmLTc5o0SsCnbtzbhEYm4zd8WIKI5OECGuv3Lr1aTKMmi9ZBayNjJQ3nUYti9PGjyUuAQKruAMymixYJnL+eCC1Ui6Ns6E1bzjEASRXYXFeMsJ7V0wXGeV0msKq04KOVap/WbKPeem+cE+iVj80EK4I9x/n0Ot33+kZPDW71igGC9xBASRZyWMnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CSDdtbsY763ftg7q+x9QySM9vsfbjOGb5Lqd4/x6oWg=;
 b=mRjx0dMPPm5kOdUSRiQf58oKkbnVKdP37VwTnX6NyP4Z1UakCLmmYe8BNKxroFKMQrAhP/m8i4niCP1PzT/i0Oo/raulzrFxgCUPDRp/buozpp6dTpjjgNRUn0/Rp7NQPeydgy8ajjGVupY8PRB5j12axtFJLHVvdCEz50RuWeLg5/SOB/ZnKVjC1DFpsplWrkBfetrJi8bBNBfgkriHjQDVi597VYxhjt/aY43QxEsQaBMKB/IkuFnm2qOyv3K7hAtw8VsBDK9jUUjHej6bnkEovqpG2/1Fv0SajAv7eLKoTqJvJ87G8/Gmcg96AeLZHNQ+9mc5mWMRX2zmZwg+Dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CSDdtbsY763ftg7q+x9QySM9vsfbjOGb5Lqd4/x6oWg=;
 b=uZa28klQIN1n/qN6IyNLMA+HCDYTKX/iSLu29X83Gmovd6tCELNi9brpbhAtDex5TmVC8NwVCR1kZoCmnCBQQzgQL3EbNg0RJgVTF+SJUBZLlbETWhzZ5/c29GNGa7FYuV2ABEQrkOxdkNsO9unog3+NOqWr2LSIUaAIaZpZ6EU=
Received: from BN9PR12MB5368.namprd12.prod.outlook.com (2603:10b6:408:105::24)
 by BN9PR12MB5035.namprd12.prod.outlook.com (2603:10b6:408:134::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.20; Fri, 4 Jun
 2021 07:59:39 +0000
Received: from BN9PR12MB5368.namprd12.prod.outlook.com
 ([fe80::245d:c14d:fd99:be85]) by BN9PR12MB5368.namprd12.prod.outlook.com
 ([fe80::245d:c14d:fd99:be85%6]) with mapi id 15.20.4195.024; Fri, 4 Jun 2021
 07:59:39 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/pm: Remove BACO check for aldebaran
Thread-Topic: [PATCH] drm/amd/pm: Remove BACO check for aldebaran
Thread-Index: AddZDjg3Cu9CTGIiTJylT/P58zU13QACU8Eg
Date: Fri, 4 Jun 2021 07:59:39 +0000
Message-ID: <BN9PR12MB53684F189C37FC4539241D1EFC3B9@BN9PR12MB5368.namprd12.prod.outlook.com>
References: <CH0PR12MB5348A2718AAC812DE39B7DEC973B9@CH0PR12MB5348.namprd12.prod.outlook.com>
In-Reply-To: <CH0PR12MB5348A2718AAC812DE39B7DEC973B9@CH0PR12MB5348.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-06-04T07:59:36Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=efa9b7c4-960f-4f7c-8c9a-0c6b44e79a63;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.134.244]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7393eced-c899-4315-f577-08d9272eb41f
x-ms-traffictypediagnostic: BN9PR12MB5035:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN9PR12MB50350DF3C0F1235B4EE01F62FC3B9@BN9PR12MB5035.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3276;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: O03kTSCzIO8/V9DGhJKpXRnIKYNoNw6IbNoDhtkvrqPS5Fz7gTFvZKM6gIU8QNvH+sehFk4HwGqh3dL3c5mKox06n/HjP20hTqND8k4XYaMrv19tpYiz48QBAtqxEke3IHSVfawF9Uwr5pKs55uWi0oO+jC5Kv23QxlGkFJGVB2zqPQQGv/h4nZpOCMu/rfAH3qqAvreoftDJqGi27B/SYsxs+s2zM6o3FP4563YCcsy6Bxq2sFYXdffVFTme2nTMN6XIV2X8rQME6p402oPLw6rLU2HY42NXpgsoy0r9wz2i4Vb0uYdQS+XdZx0MfJIJYX9Q+mVIuReUm4rluj+JAMwc0eZ93oMC9fGxgwRt2DTdBYVtU3x4AD1zi6dwhGku/GI/HkXKd4mwA30wbYLMaWwX4l8h+LnZRySRAsemDkYoF+OOgb0GyB//yqrep5MSqskuDjjUOqQqyb2NLiOVq/vjkMV52X8idXZN5q6lXE0a15QSih6fxqSsypbt/fELeq/TePtoxlsIFxZydMKYgPWxxbxXe9N3Dy+Q0xSy20g+Dgz0D/NiYd/ArHbe7ZxJcTh+Svf2uHaBzXRraQAuPA/rjusQ2tkccFFZzkBBWI=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5368.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(136003)(376002)(346002)(39860400002)(396003)(7696005)(83380400001)(478600001)(55016002)(5660300002)(2906002)(52536014)(8936002)(66446008)(66476007)(66556008)(66946007)(4326008)(186003)(9686003)(33656002)(71200400001)(53546011)(54906003)(316002)(64756008)(6506007)(86362001)(8676002)(38100700002)(122000001)(110136005)(26005)(76116006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?8AaEY0qt3iNrE8GKYCCi/7aH1fa5hEvRWGN5PoJ++DUR0NuKcL9PlKKneeac?=
 =?us-ascii?Q?Vt43yRFFRFjjav6OUJB9CVe7dPP40RcAGMFVPFwwv1TMLVIPyJfjKgEZ20qv?=
 =?us-ascii?Q?F3c0EJuOmyoRrw6opas6FGfwB0aMnJdSakF7i3OdM1rJkPsuoUN0+PEZR9ld?=
 =?us-ascii?Q?ap62QbDAkzAAAQHRRu8RBFLkb6zzJot8FuYrO7K2DKwIzzbZcN6eidWp8/cZ?=
 =?us-ascii?Q?3qqESli7ByzCT3mv5C27DPkDhkN5zIOdaKhwXJ5VjbsZGrBc8hXXGndvU1v0?=
 =?us-ascii?Q?GhgshBPK08Klm9jTrV5DHLn5DNkPkzeKFvdvs7MthHkH4AhObKIXxWnohWM1?=
 =?us-ascii?Q?fVlU+ALi0n/ziTMgRZQgttxs6U9C/K1bG56xthFgFVyNSBnst2u3h6qEiq2T?=
 =?us-ascii?Q?ToqSyNzj9wYxSLFFkW1p1HMLHGiVSFJnHkJcXFBbE7fwivugPD6klcfDSjNp?=
 =?us-ascii?Q?7MIrKfpVA9GNv1OUDR9RzUGXPBQnIVn3HoxAks5PQ44yv+da4ybd0ZSxXRKR?=
 =?us-ascii?Q?hY6dE7oWbmPMLFLxg3sp+CNqB1XDHKNT6t8VpJnPEM8dQe7IaVuExXs2kuI2?=
 =?us-ascii?Q?AYMpvvavmV4Kr6egOUtE+QTFrzFDyaPhYd0oyCOIx6KXVHLNNf1d3I6QWvf9?=
 =?us-ascii?Q?puQuT0o4yoz0Rd8kk+qf03J8iVacuy0SsAdxG7I0Ilx1QeA2Gsxf6HoozV7o?=
 =?us-ascii?Q?Hf/LhHFIutHS6/OSdiI20mCJFJD8Um/GKmcSlfGElRIbdunsmPn21R0nYKLf?=
 =?us-ascii?Q?AQ8Z9FiqbhiMCdjaiCVymofdaP257yFnqNZx0LDiYmdvbN90iEycEmopc09H?=
 =?us-ascii?Q?hpSRxVu87yTuO0CLq0xlLAaX2VIOFcP8s7190Mogi1/MddUt6bOsqup/neLS?=
 =?us-ascii?Q?7Bu3jiUxSbvl+u3BleBgGzgwxgnHBQ3yqqBGy8aY7AIEj6O/73kAZ04+LTzB?=
 =?us-ascii?Q?zqm4ETda3pwoVbYeUK1hi1JNpy9MDMvFfLA+oAQTcST0zWCcXcn8lKHXWvNP?=
 =?us-ascii?Q?hNazc+6jMULcXouF+hTKtxVNd1vLnUM4DHXUrddtvDZ4G+OOIxiqSejTxtJv?=
 =?us-ascii?Q?7iiMzx44n7p3atexzwL718vdr4Yo8uHJEHV50qg3VltM1lBM6wlfyzcIBJGl?=
 =?us-ascii?Q?u6fLigXQhRDhtQTp29TX5xiw8r2irdyOGcDGoDHl7BtZqrYazQgYzRxTLcLX?=
 =?us-ascii?Q?WoFrLzhH6PzEVirXpIhxNZZI3AZWBtOA/oSzHw1kYagYUghyBmmKlAFAKE+h?=
 =?us-ascii?Q?8QsMfnLS9FG7cR48y+h4vtOZnhPxsZc+rqApSDse/wKnk0nR1010dO3c84k/?=
 =?us-ascii?Q?vuicwjFFVqFyehZVDWkaXgBU?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5368.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7393eced-c899-4315-f577-08d9272eb41f
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2021 07:59:39.1497 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rB+AOkYwM+lOkzKkRT11eorq3bwfZval/+7EcfbeJhqinSlv/UX6Fy5WJPHiAJNq1XlVSt1QloJHFu7DYS7Vgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5035
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
Cc: "Wang, Kevin\(Yang\)" <Kevin1.Wang@amd.com>, "Feng,
 Kenneth" <Kenneth.Feng@amd.com>
Content-Type: multipart/mixed; boundary="===============1165532819=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1165532819==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BN9PR12MB53684F189C37FC4539241D1EFC3B9BN9PR12MB5368namp_"

--_000_BN9PR12MB53684F189C37FC4539241D1EFC3B9BN9PR12MB5368namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[Public]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Friday, June 4, 2021 14:59
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Feng, Kenneth <Kenneth.Feng@amd=
.com>; Wang, Kevin(Yang) <Kevin1.Wang@amd.com>
Subject: [PATCH] drm/amd/pm: Remove BACO check for aldebaran


[Public]

BACO/MACO is not applicable for aldebaran. Remove the redundant check.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com<mailto:lijo.lazar@amd.com>>
---
drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c | 7 -------
1 file changed, 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/g=
pu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
index 7a1abb3d6a7a..6ee9c4186f02 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
@@ -355,13 +355,6 @@ static int aldebaran_check_powerplay_table(struct smu_=
context *smu)
               struct smu_table_context *table_context =3D &smu->smu_table;
               struct smu_13_0_powerplay_table *powerplay_table =3D
                               table_context->power_play_table;
-              struct smu_baco_context *smu_baco =3D &smu->smu_baco;
-
-              mutex_lock(&smu_baco->mutex);
-              if (powerplay_table->platform_caps & SMU_13_0_PP_PLATFORM_CA=
P_BACO ||
-                  powerplay_table->platform_caps & SMU_13_0_PP_PLATFORM_CA=
P_MACO)
-                              smu_baco->platform_support =3D true;
-              mutex_unlock(&smu_baco->mutex);

                table_context->thermal_controller_type =3D
                               powerplay_table->thermal_controller_type;
--
2.17.1

--_000_BN9PR12MB53684F189C37FC4539241D1EFC3B9BN9PR12MB5368namp_
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
	{margin:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
p.msipheaderc10f11a2, li.msipheaderc10f11a2, div.msipheaderc10f11a2
	{mso-style-name:msipheaderc10f11a2;
	mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
span.EmailStyle19
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
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
<p class=3D"msipheaderc10f11a2" style=3D"margin:0in"><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:green">[Public]</s=
pan><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Reviewed-by: Hawking Zhang &lt;Hawking.Zhang@amd.com=
&gt;<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Regards,<br>
Hawking<o:p></o:p></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> Lazar, Lijo &lt;Lijo.Lazar@amd.com&gt; =
<br>
<b>Sent:</b> Friday, June 4, 2021 14:59<br>
<b>To:</b> amd-gfx@lists.freedesktop.org<br>
<b>Cc:</b> Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;; Feng, Kenneth &lt;=
Kenneth.Feng@amd.com&gt;; Wang, Kevin(Yang) &lt;Kevin1.Wang@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amd/pm: Remove BACO check for aldebaran<o:p></o=
:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"msipheaderc10f11a2" style=3D"margin:0in"><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:green">[Public]</s=
pan><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">BACO/MACO is not applicable for aldebaran. Remove th=
e redundant check.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Signed-off-by: Lijo Lazar &lt;<a href=3D"mailto:lijo=
.lazar@amd.com">lijo.lazar@amd.com</a>&gt;<o:p></o:p></p>
<p class=3D"MsoNormal">---<o:p></o:p></p>
<p class=3D"MsoNormal">drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c |=
 7 -------<o:p></o:p></p>
<p class=3D"MsoNormal">1 file changed, 7 deletions(-)<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/alde=
baran_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c<o:p></o:p>=
</p>
<p class=3D"MsoNormal">index 7a1abb3d6a7a..6ee9c4186f02 100644<o:p></o:p></=
p>
<p class=3D"MsoNormal">--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_p=
pt.c<o:p></o:p></p>
<p class=3D"MsoNormal">+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_p=
pt.c<o:p></o:p></p>
<p class=3D"MsoNormal">@@ -355,13 +355,6 @@ static int aldebaran_check_powe=
rplay_table(struct smu_context *smu)<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_table_context *table_context =
=3D &amp;smu-&gt;smu_table;<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_13_0_powerplay_table *powerplay=
_table =3D<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; table_context-&gt;pow=
er_play_table;<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_baco_context *smu_baco =3D &amp;smu-=
&gt;smu_baco;<o:p></o:p></p>
<p class=3D"MsoNormal">-<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;smu_baco-&gt;mutex);<o:p></o:p>=
</p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; if (powerplay_table-&gt;platform_caps &amp; SMU=
_13_0_PP_PLATFORM_CAP_BACO ||<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; powerplay_table-&gt;platform=
_caps &amp; SMU_13_0_PP_PLATFORM_CAP_MACO)<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_baco-&gt;platform_supp=
ort =3D true;<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;smu_baco-&gt;mutex);<o:p></o:=
p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; table_context-&gt;thermal_controller=
_type =3D<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; powerplay_table-&gt;t=
hermal_controller_type;<o:p></o:p></p>
<p class=3D"MsoNormal">-- <o:p></o:p></p>
<p class=3D"MsoNormal">2.17.1<o:p></o:p></p>
</div>
</body>
</html>

--_000_BN9PR12MB53684F189C37FC4539241D1EFC3B9BN9PR12MB5368namp_--

--===============1165532819==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1165532819==--
