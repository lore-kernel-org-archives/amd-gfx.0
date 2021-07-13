Return-Path: <SRS0=Y2YZ=MF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,HTTPS_HTTP_MISMATCH,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 152D3C07E95
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Jul 2021 11:20:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C03486117A
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Jul 2021 11:20:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C03486117A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4EC556E082;
	Tue, 13 Jul 2021 11:20:01 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2065.outbound.protection.outlook.com [40.107.94.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C74666E07F
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Jul 2021 11:19:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=miwTpQYQ37uvIiGmU86oUqKCn8oLRVO7yZ1bYET1tsj9VbHeOrHNXuFdda5DWw0kxLFiZQLadl4pN57BsWvjrZDXqoFXHF7Bf8iN9dDpsneiCrhr2RWX5tc20SYM4aOdeZ7xpycD55PCEmvCHCBME5oGdueosZhhb2YqAS7hAV38WxKA+VP+pnYkJp6BO1fmmrqY+yJgzDlavpBFskMLcvuQwUMp90joA9FJVj2Y16CDTKdmcklYjvSHl6QqxeVZBAu4p/1AoZ55olDTTigvf2u3DiRQhw12bxWgDSoTWmtlWcb9tkLq/jNyIOo52I97pLtQObqdBSPIW1eglPv+zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hQqbxa/q1GjkZ4MR99+GhTdqwzCA1JueHvxS/1eyImU=;
 b=IAOZzogWi1pXwrQnvFmKb+Ba4EWE939Zq8+lwH6ZWrv/U2UEGNuTfchcGdZbIQU1MYy2d1vQRmyV48JHA1hZAHylTfAd08TF6SxvYsXul9mRiFZg7nX+wVPelnpUZAHrXVrTHD/JJHQnQohazv+kKRAk4PhBAfMBPx8n9uecLDuS3nB3ep5897dPeuswm9fThWdKfc5m1eLajx+qE4NDY7J/EqRcrG6Fcne2Ue4Ktd+VGf6XJdpp2k+GVPcj9ZtGl3/QFyxEeAClEeUthJHFMdDdeYPE4Xuj/nbUIYu78u01qmt2TEDUOkJoa3f3JLXpyXdqBiKxjkk25B9nI+rnJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hQqbxa/q1GjkZ4MR99+GhTdqwzCA1JueHvxS/1eyImU=;
 b=4r6r2Q+zFlM/gRq0ZQPuBIILFo5Q6ru8a3mWU/vN8BR/wDyQUPqNaemfzVwyCuQgRFYtu5OpabiPvUE+mB6dWNA/nyD3zgfbghnUStAL3R5Ng8RNLRO8W35ji8TsxStE5KU0fwVdokuqK3YoMxO+3v44huY3u2kES99TCr7XBaI=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by BN9PR12MB5306.namprd12.prod.outlook.com (2603:10b6:408:103::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.22; Tue, 13 Jul
 2021 11:19:56 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::5dd:148c:8b35:b31b]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::5dd:148c:8b35:b31b%3]) with mapi id 15.20.4308.027; Tue, 13 Jul 2021
 11:19:56 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: =?iso-8859-1?Q?Christian_K=F6nig?= <ckoenig.leichtzumerken@gmail.com>,
 "Clements, John" <John.Clements@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Resolve bug in UMC 6.7 UMC error offset
Thread-Topic: [PATCH] drm/amdgpu: Resolve bug in UMC 6.7 UMC error offset
Thread-Index: Add3ynqQDrdXffQvTkm667otpc5Z8wAAFN8QAALyhoAAAJLAEA==
Date: Tue, 13 Jul 2021 11:19:56 +0000
Message-ID: <BN9PR12MB5257BEFB6044D718DB3EDF46FC149@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <BN9PR12MB5226592BA32F2E749A39B9D5FB149@BN9PR12MB5226.namprd12.prod.outlook.com>
 <BN9PR12MB5257A6F5F01459E9DB43B0DDFC149@BN9PR12MB5257.namprd12.prod.outlook.com>
 <8f4b76dd-c75b-e4db-4dc7-cc164210d175@gmail.com>
In-Reply-To: <8f4b76dd-c75b-e4db-4dc7-cc164210d175@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-07-13T11:19:51Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=a95ff1c6-768a-457c-9a0e-e0c859cddd7f;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 499b0771-0d98-430c-5fda-08d945f024fb
x-ms-traffictypediagnostic: BN9PR12MB5306:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN9PR12MB5306BB2B23CE544B9796A151FC149@BN9PR12MB5306.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tOoHEhf4l3eIfmPuDXi6/8Qob2SqO43gTusGisLqILPSr9CQ0B5G2vELn2P4F+ieZEPkXIMe3SuIqEuhProU3sx/zEP36g+2usXarEhUGeIUnYgRDzLOPboZjAKUq3thn1BEqQrV8nuSWyMZasMpfIItKJy6RhmyK+67xgagtXZK8gRg50s5aCiWx682soItkofmY4NuWzq/CUrkx3IAmjTEPQkViuYna6yXE4vcAkzGQQIr+Wk3fWlVn9YFehkIkhtPPWjLUh/PD6cWPv4AHQ/5kh3sCdpdESEJd62k4yUX81YaHinU5nOcHSYQD/+Dj4jznjWrIn6nJfd1SJR8Ha77i9fHKIeMIO3fhWYrs+ZKN58A6bwMiJAFUAbfj95YC9dQGo28wGSABsyzPzjwuLjQAQagI3VYvKUVWd/T+ZCbhCBYze+Bi+oNMsBcyOjdpQsT1+egIEIgDOj8CCYpr7f607dXhxZyxKB9YDY97iuB8zcG56UN8g5D83sKci1FxsO7GwzHL78yKK/R44yz5z/beXIAZYQdQgh14Vdhq/fD6rL/HH2+SOsiJ5cSL0+0EewVOs3+IH6be9v+MuwLwrbjsybUcD62oD43XbSfjpeuMmit45PN4e8jyp1eh5aMBk4S0zxnCZj0NqzM4H8gEg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(39860400002)(366004)(346002)(396003)(376002)(71200400001)(86362001)(76116006)(66946007)(66476007)(966005)(66556008)(26005)(9686003)(7696005)(2906002)(53546011)(6506007)(110136005)(478600001)(166002)(55016002)(64756008)(38100700002)(186003)(33656002)(122000001)(316002)(52536014)(5660300002)(8676002)(66446008)(8936002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Pyu5HTtz8Ot/4O8DqcnFivUywh2u0GR1knsJBvbpk4TMEMx4v2OGTA3/ju?=
 =?iso-8859-1?Q?rod9kSxg+uZgGctopAN9ol8Jq3Aefl+5TW9nRQuNx632QzP55vj9yn5zVq?=
 =?iso-8859-1?Q?wW8ZLUvOwJVLnp3ztAKtNhOBO6Lwtnad4oLEH5gcmFdUYEDf63WwaFJ5Db?=
 =?iso-8859-1?Q?sn7j0oC+pGH0DiSZB52UVIv2iNBrvkaPsAHl2x2eePtbi/TZZ5oyAPCtea?=
 =?iso-8859-1?Q?pGmz+cfTxpkMSVTotAZvi3S937BedXgOjXqPFxr7JnEHjuYDozvDjCInOu?=
 =?iso-8859-1?Q?ahdcelI1Fsj0zGum1QDT/PEPPeKUbFFqQ/Kot2syEQPhUJHOLy0w1Vygxx?=
 =?iso-8859-1?Q?MhqCsfNZAnff2FNYLYGlZml6kYE/oUa5i26Ya8Myw2ISKzfvO4UsdMJj/A?=
 =?iso-8859-1?Q?0CNIeQJnJS33itaRIvhgWsgtQE8v0umOn3ja90Y2V9Npcoe155HtBFFWai?=
 =?iso-8859-1?Q?q+Y7WzzYncWyjMMENcbpu63KX+b5jmNmNhsRAeQdKiQEKffJ1f5PjwDWgw?=
 =?iso-8859-1?Q?vd6ziEjYpqsOGtyvQimYlm0sHjAkhPYyhR5n3KjcRGmLDKpyT4yjagrO2i?=
 =?iso-8859-1?Q?+8QJbq3VOzOIzEhs81VvGdkNc/ZLMODhlNlwmqsu6Nl4E4spA/h5bzH0qL?=
 =?iso-8859-1?Q?zUKKZgYD7Gik8vTr7rn9QO/docjWmqg3BYl4Y2gA1n8yiK0FeciC2vbO12?=
 =?iso-8859-1?Q?iFCF+1djHKtaMj5ZL9gNQt7rgeayQkU8LE5NjlgtjRY27YpMn1juuYW4Wm?=
 =?iso-8859-1?Q?LTutCUpduO7CUg6qJ7AuDJPBp1i+hZ8I16Q7h4mJBEHqrH+n/XoPb8ctrT?=
 =?iso-8859-1?Q?PXiWhDUtelxDbNPXxi5DnenysSJVskRGF0tejVocLwDDI0qc8wjo4/vn/V?=
 =?iso-8859-1?Q?VtU7WtlSuk4oO/OdO/2KGl04ffqlBqvhDGOl+9jk8IOiIF5b+hp02GLmj5?=
 =?iso-8859-1?Q?RGM7IrHzcreXPy4vZmYOhBg9ecfVNgjFtyvw/3k72zCd59Nt3gs9U6KF4K?=
 =?iso-8859-1?Q?ePgEZnB32lhpIo4nK7kGKZzcRaUfFuYnU9OmPhAxZRaf3b070Wx/7XGObJ?=
 =?iso-8859-1?Q?MRxKlZdYjiRY6Vlq4ChQNxbTiC1RIGs+73U6dY/mEO+agFY3Y2ztn3dC99?=
 =?iso-8859-1?Q?iNCq54FZb2Ue7nlacVx5ya050jDj4BEDqwVW69crPjDLRLwl6tLQVyluyn?=
 =?iso-8859-1?Q?M4vOuJCktLPDobT/SLCnbYrnbfdJ9Bg1pTpthMJk35jDnhDgkcYPc/Jf07?=
 =?iso-8859-1?Q?hHKQXeYBv9HkMABjkLN++vYGYxH1hlqzNbUvyEbbI1YgaC8TKeAfRT47U6?=
 =?iso-8859-1?Q?e0cul8jD19rxaaOReZD57UYayyIUQGu1uUnPWI2NmFHFvQzbwEUSgXF2Oz?=
 =?iso-8859-1?Q?2WggB2jBMs?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 499b0771-0d98-430c-5fda-08d945f024fb
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2021 11:19:56.3511 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5Jp+7X4dakkvPKmHshsGs+p//ewjvChAjhlvhT7eChl99evSrJO4Fos3NF3AC9E8MpDdUsp35GyJScQWzOAl0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5306
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
Content-Type: multipart/mixed; boundary="===============1206592587=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1206592587==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BN9PR12MB5257BEFB6044D718DB3EDF46FC149BN9PR12MB5257namp_"

--_000_BN9PR12MB5257BEFB6044D718DB3EDF46FC149BN9PR12MB5257namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only]

Yeah, seems like switching the smtp server helps. Someone sents notes to br=
ahma_sw_dev.

Regards,
Hawking

From: Christian K=F6nig <ckoenig.leichtzumerken@gmail.com>
Sent: Tuesday, July 13, 2021 19:03
To: Zhang, Hawking <Hawking.Zhang@amd.com>; Clements, John <John.Clements@a=
md.com>; amd-gfx@lists.freedesktop.org
Subject: Re: [PATCH] drm/amdgpu: Resolve bug in UMC 6.7 UMC error offset

And let me guess you "git send-email" with an AMD address doesn't work for =
you either?

I think we need to ping our IT once more.

Regards,
Christian.
Am 13.07.21 um 11:39 schrieb Zhang, Hawking:

[AMD Official Use Only]

Let's submit the quick fix first and then work out better naming styles to =
fix confusing

The patch is

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com><mailto:Hawking.Zhang@amd=
.com>

Regards,
Hawking
From: Clements, John <John.Clements@amd.com><mailto:John.Clements@amd.com>
Sent: Tuesday, July 13, 2021 17:37
To: amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>
Cc: Zhang, Hawking <Hawking.Zhang@amd.com><mailto:Hawking.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: Resolve bug in UMC 6.7 UMC error offset


[AMD Official Use Only]

Submitting patch to resolve bug in UMC 6.7 error offset calculation

Thank you,
John Clements


_______________________________________________

amd-gfx mailing list

amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>

https://lists.freedesktop.org/mailman/listinfo/amd-gfx<https://nam11.safeli=
nks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.freedesktop.org%2Fmai=
lman%2Flistinfo%2Famd-gfx&data=3D04%7C01%7CHawking.Zhang%40amd.com%7C4ca213=
a09de544cb4ad708d945edbc20%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637=
617709639276832%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzI=
iLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&sdata=3DCn4YEVo40Mg3euPBaz5WFpMcPdwQ=
gDwe4qJmKyDyBBo%3D&reserved=3D0>


--_000_BN9PR12MB5257BEFB6044D718DB3EDF46FC149BN9PR12MB5257namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
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
@font-face
	{font-family:Consolas;
	panose-1:2 11 6 9 2 2 4 3 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
pre
	{mso-style-priority:99;
	mso-style-link:"HTML Preformatted Char";
	margin:0in;
	margin-bottom:.0001pt;
	font-size:10.0pt;
	font-family:"Courier New";}
span.HTMLPreformattedChar
	{mso-style-name:"HTML Preformatted Char";
	mso-style-priority:99;
	mso-style-link:"HTML Preformatted";
	font-family:Consolas;}
p.msipheadera4477989, li.msipheadera4477989, div.msipheadera4477989
	{mso-style-name:msipheadera4477989;
	mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
span.EmailStyle21
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
<body lang=3D"EN-US" link=3D"blue" vlink=3D"purple" style=3D"word-wrap:brea=
k-word">
<div class=3D"WordSection1">
<p class=3D"msipheadera4477989" style=3D"margin:0in"><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:blue">[AMD Officia=
l Use Only]</span><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Yeah, seems like switching the smtp server helps. So=
meone sents notes to brahma_sw_dev.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Regards,<br>
Hawking<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> Christian K=F6nig &lt;ckoenig.leichtzum=
erken@gmail.com&gt;
<br>
<b>Sent:</b> Tuesday, July 13, 2021 19:03<br>
<b>To:</b> Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;; Clements, John &lt=
;John.Clements@amd.com&gt;; amd-gfx@lists.freedesktop.org<br>
<b>Subject:</b> Re: [PATCH] drm/amdgpu: Resolve bug in UMC 6.7 UMC error of=
fset<o:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt">And let me guess you =
&quot;git send-email&quot; with an AMD address doesn't work for you either?=
<br>
<br>
I think we need to ping our IT once more.<br>
<br>
Regards,<br>
Christian.<o:p></o:p></p>
<div>
<p class=3D"MsoNormal">Am 13.07.21 um 11:39 schrieb Zhang, Hawking:<o:p></o=
:p></p>
</div>
<blockquote style=3D"margin-top:5.0pt;margin-bottom:5.0pt">
<p class=3D"msipheadera4477989" style=3D"margin:0in"><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:blue">[AMD Officia=
l Use Only]</span><o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
<p class=3D"MsoNormal">Let&#8217;s submit the quick fix first and then work=
 out better naming styles to fix confusing<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
<p class=3D"MsoNormal">The patch is<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
<p class=3D"MsoNormal">Reviewed-by: Hawking Zhang <a href=3D"mailto:Hawking=
.Zhang@amd.com">
&lt;Hawking.Zhang@amd.com&gt;</a><o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
<p class=3D"MsoNormal">Regards,<br>
Hawking<o:p></o:p></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> Clements, John <a href=3D"mailto:John.C=
lements@amd.com">
&lt;John.Clements@amd.com&gt;</a> <br>
<b>Sent:</b> Tuesday, July 13, 2021 17:37<br>
<b>To:</b> <a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.f=
reedesktop.org</a><br>
<b>Cc:</b> Zhang, Hawking <a href=3D"mailto:Hawking.Zhang@amd.com">&lt;Hawk=
ing.Zhang@amd.com&gt;</a><br>
<b>Subject:</b> [PATCH] drm/amdgpu: Resolve bug in UMC 6.7 UMC error offset=
<o:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
<p class=3D"msipheadera4477989" style=3D"margin:0in"><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:blue">[AMD Officia=
l Use Only]</span><o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
<p class=3D"MsoNormal">Submitting patch to resolve bug in UMC 6.7 error off=
set calculation<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
<p class=3D"MsoNormal">Thank you,<o:p></o:p></p>
<p class=3D"MsoNormal">John Clements<o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><o:p>&nbsp;</o:p></p>
<pre>_______________________________________________<o:p></o:p></pre>
<pre>amd-gfx mailing list<o:p></o:p></pre>
<pre><a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedes=
ktop.org</a><o:p></o:p></pre>
<pre><a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps=
%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D04=
%7C01%7CHawking.Zhang%40amd.com%7C4ca213a09de544cb4ad708d945edbc20%7C3dd896=
1fe4884e608e11a82d994e183d%7C0%7C0%7C637617709639276832%7CUnknown%7CTWFpbGZ=
sb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1=
000&amp;sdata=3DCn4YEVo40Mg3euPBaz5WFpMcPdwQgDwe4qJmKyDyBBo%3D&amp;reserved=
=3D0">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a><o:p></o:p>=
</pre>
</blockquote>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
</body>
</html>

--_000_BN9PR12MB5257BEFB6044D718DB3EDF46FC149BN9PR12MB5257namp_--

--===============1206592587==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1206592587==--
