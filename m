Return-Path: <SRS0=9uSV=II=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A13DCC433E0
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Mar 2021 11:33:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 35DA664F59
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Mar 2021 11:33:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35DA664F59
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BE13C6E1A2;
	Wed, 10 Mar 2021 11:33:42 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2079.outbound.protection.outlook.com [40.107.220.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6D8486E1A2
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Mar 2021 11:33:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dv0U+apIHfPqi5aUC4DjviL4zGDQX3AHx1jmvfEpzA843AnQhdlZsBxskC2r4ptvWymBAKIAxNpt2GySacg/f5UzHLicsFagLcgO1coYRexC0f4vNnTXyWEVCueD2ePf/p3pNSlB9223xjEtnEhZFXVz2g17yfFyUjkwNOYi1Wul8PartuPTX2CXAbu9BURJqVck+kDqYwkheO91mNaskDtZ80vEMVfTg8YrnGiTmsHGOo0yM2P8B0xUkD89Nn4j8FMpDGcRHHatG60ctO1X8lVwK+1A5ISoatyoSmJ4wzRM9bpWdqlCyFH2EOgE59CJ2DW25Rb1KlpkXJAAE/BXfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aw/Ajkr8EW+xeJu8U+oCiNP0OdcQfkEX7EMXE0e4weQ=;
 b=CmXBtJvgyTTVrpZE2fOhG6KvhBQM6KtczI3hiTW0O4SKwzDdg3TIzZ0cAH9PDo0+mmMN9esRvveKsuCJz5AhoshD3BSVWIFMqC9nTf50upS2/me0Anf//trpTt6DdibHGDv62RHg4cVlwTOh2zGgLFJFH3wwStSQhdyw9y6F6kezAVEUCcGQVCDYFM51hZKJd/cpV5BjBuR+s9idXewqUwBWCE8UeeirRFnXgOa6gT2YRuLYGaHh8IOEePDC3tIK3SOCafAQ2U2uPwD7ATCJHgYP6CzjXEnzlFpicsJpeSXuOZSYgoWUOB0SrGSnKMyHfpbYm4HAIj6/pdRBx1LwSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aw/Ajkr8EW+xeJu8U+oCiNP0OdcQfkEX7EMXE0e4weQ=;
 b=pVrN470SsTXZhbv4vsRVxO522lXKLQANH9JajDlElpMTHbMDLkQsuA9OeAdeUzVN25Posse4d1OQZGtpNBugC+IYjnUtdHhgZR13Oa2nGgfcBKsOl2/QhYzq5cXW8D0SWAO7vxetNFREe7ohbutcajvXIZPyCnN03j6OjMg9U2M=
Received: from DM6PR12MB4075.namprd12.prod.outlook.com (2603:10b6:5:21d::8) by
 DM5PR12MB1706.namprd12.prod.outlook.com (2603:10b6:3:10f::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3912.27; Wed, 10 Mar 2021 11:33:39 +0000
Received: from DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::34e3:c46e:188c:ef53]) by DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::34e3:c46e:188c:ef53%5]) with mapi id 15.20.3912.030; Wed, 10 Mar 2021
 11:33:39 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Free PDB0 bo before bo_fini
Thread-Topic: [PATCH] drm/amdgpu: Free PDB0 bo before bo_fini
Thread-Index: AdcVmYi3nGUgLuqGR2CtYPJZg2gsbgAB56Hg
Date: Wed, 10 Mar 2021 11:33:38 +0000
Message-ID: <DM6PR12MB40751123CB0B7B658DFDB292FC919@DM6PR12MB4075.namprd12.prod.outlook.com>
References: <MN2PR12MB45490E6DF73972AFEF0F052897919@MN2PR12MB4549.namprd12.prod.outlook.com>
In-Reply-To: <MN2PR12MB45490E6DF73972AFEF0F052897919@MN2PR12MB4549.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-03-10T11:33:37Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=15ee522d-f8ff-4ecd-a4de-67ff884c4c6d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: bd451e6e-5be5-47e0-1c54-08d8e3b859ad
x-ms-traffictypediagnostic: DM5PR12MB1706:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB1706C6F4DECE11E5A57B0FF3FC919@DM5PR12MB1706.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:346;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /eti3UeTU/Ra2Jf3vDVx8EpAvvL+ThyuHVQZz/jLYe1gbH1cwWUBpdmhg4Pw4+53VOALDqhwpFJwCRzZgLnC2vtzYkzC6L5FYmKf0in2az3nEjggx2oA3rlodKXXo4lCAUWhobNlyzsOR4tHQl5sA1zhaDFsJ18E2wNv2NFdkQOCrFikp9HoAqIUmOm5RJOCfcepARC4xXk08nXatx1xoekaVmUCiZflMc4Z60rxIw7SBuohpDpCzJQDYgyfIZtqELVLGtO6DFvMuf3x5FMxIesVeuOI57PzZ3JWgmFZFgvrx+CPYlzNUtg48AWh7eRUEcmdzRxL1lCGYq/AJq2EaMsZ1IqrijnCF3QAJIOZrvAJDw+lnlt9tX2D5qoUs+IjojOqbkhPlpftETcWZ66Plq5B8V5kjHpv0AoBbHym/of6aW7QxH24n1Mw9Zg0xQqbgfQ+yK1qo+m8rgb5OFVsvFS5L3zNVq8DbEo4A+4JHf/4o8wMAapEEfLnXwgNg7b/8V3QH0IM3BRqxySzcuqofA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4075.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(39860400002)(366004)(396003)(136003)(376002)(316002)(4326008)(8936002)(110136005)(52536014)(76116006)(66446008)(86362001)(54906003)(66946007)(55016002)(186003)(53546011)(66556008)(33656002)(66476007)(71200400001)(26005)(83380400001)(6506007)(5660300002)(64756008)(8676002)(7696005)(2906002)(9686003)(478600001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?IvfTblrdyoRRXItSbzrhT/gqsy4/w56Q45dzdTT0hhxC5iLs5+lUnx5khq9F?=
 =?us-ascii?Q?OY8KfDxCVIrOkQtVgN03x7jn296tiWeaF3aoZCa7d5C5XigpSm20YmQSZayL?=
 =?us-ascii?Q?hfwN17HbxYmHeIPT5Yf3vCOigf5WJumEBP84k7xTZi9t2X7O79NdZwsadf4q?=
 =?us-ascii?Q?rNWOn+KIGo7jh7DzQ5c2lWQ7KkBVv6j+CBedr2M95EwZhD1Nu5+JM/1lE8KC?=
 =?us-ascii?Q?QZOPjMeJS/n4qZH6ftFbCwq2nGglhq2x3r/lNo7BCU3rrlsz4MPmD4ubFO6u?=
 =?us-ascii?Q?yCIJudrEnJBw83DtVlvasTHaBlvoGF+C7XvWnLU+TMcL5kUyWyxDgrWM+veB?=
 =?us-ascii?Q?SudvZdwgzJf2t+y1VxfuWkZcjcnjHNjKzm3LU1KwxYNVrH7jiCNA7pE/06df?=
 =?us-ascii?Q?77STs8jgzB5SjY3vMJwwvlmF6e9U36krgyUiPHtGO0jgD+dm4UlL1fl8uTn+?=
 =?us-ascii?Q?3Hox7CNsK+N6l4LRa3IUZDJOs76A06wYPVTZd9WYv/KhCTX0hnhGOF3jtT4H?=
 =?us-ascii?Q?ppSEZIG8GQ37N1l+OTy131GuR6j3r9DuDF2qykg1XgP5dbNFF4vavzm1slI+?=
 =?us-ascii?Q?FlDNdZ2VUoaRQKd1psRIlBVju0yvUuo+kDTvZyJtQfgILp6eDX9Q6ec/kin0?=
 =?us-ascii?Q?NOVSQeVRZxvDUtKanP0WxnQG7lDs34ps8ItJ7Eq92rbzIgnws0SEBRUc6UOd?=
 =?us-ascii?Q?tdboU2A+6Gl6/igHzKS5P0s3IZ3F+FZtobZMDrzEnJge9AzlsgBio6scYwCX?=
 =?us-ascii?Q?dFL4Ccf+sId098au2xmA89LpmF4QwLunS/HRJ9pkLhiPQk/kMgWM+cP0op+O?=
 =?us-ascii?Q?E4XEHpGRoUyIxc4cf9aJWrIz/WM+8TJTN6srH9fw/GINU2uY80yBn+T39jG2?=
 =?us-ascii?Q?QNTFsTNMmqjQxDsxtgZ0gVpaThem5hMxLoP8B5HAZXb91nx+t+KptsvRNJgV?=
 =?us-ascii?Q?/TvwFaDzqwS6HvB0wc4CnPUlebaBn4TzsxFxibx3t6RLMsord59fobRmyRRN?=
 =?us-ascii?Q?nMUmhpsmfxzBNHLFuBBSf4U/o4fndY0TeWLGrpX4J65oXZNiNI9H9iPsnPaK?=
 =?us-ascii?Q?kwchOHX9rTKs5N1ailK85Evpq5Az2XGTFHrOP+udAXO9th8vaOuh4yJ6Rehc?=
 =?us-ascii?Q?H+yC8TaijkUYBIKlbTGBeDxhT5xgX2qa2DcezUVk1mP96IUveWHW7WdjnXVZ?=
 =?us-ascii?Q?VD6z8ogPuHP8Ndc8Bp8foi/j1L8f8e1LwHJWGNdku5DxyhaVcsayupKwkO/B?=
 =?us-ascii?Q?O6itRKTAHLmpq4a4WhlE52bO7gm710d6JkWl8Jh1cet69YFIbHKQcqEfDTSh?=
 =?us-ascii?Q?HqB8DR6NXVRtf0TPLWCi50Ov?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd451e6e-5be5-47e0-1c54-08d8e3b859ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2021 11:33:38.9177 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8Tyayc1M1FJRyIeL7/jCUvXc4Ay+d8Vu8fekXXI0Awf2A9rWmFfuBYa5OJK1djq4zudcxjW5sSbAbxW5SnjsVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1706
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
Cc: "Zeng, Oak" <Oak.Zeng@amd.com>, "Kasiviswanathan,
 Harish" <Harish.Kasiviswanathan@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>
Content-Type: multipart/mixed; boundary="===============0820045237=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0820045237==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_DM6PR12MB40751123CB0B7B658DFDB292FC919DM6PR12MB4075namp_"

--_000_DM6PR12MB40751123CB0B7B658DFDB292FC919DM6PR12MB4075namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Public Use]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Wednesday, March 10, 2021 18:40
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Zeng, Oak <Oak.Zeng@amd.com>; K=
oenig, Christian <Christian.Koenig@amd.com>; Kasiviswanathan, Harish <Haris=
h.Kasiviswanathan@amd.com>
Subject: [PATCH] drm/amdgpu: Free PDB0 bo before bo_fini


[AMD Public Use]

Cleanup pdb0 bo before bo_fini gets called

Signed-off-by: Lijo Lazar lijo.lazar@amd.com<mailto:lijo.lazar@amd.com>
---
drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 3 +--
1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/am=
dgpu/gmc_v9_0.c
index 45ba3819bb8f..e8de5145339b 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -1577,10 +1577,9 @@ static int gmc_v9_0_sw_fini(void *handle)
        amdgpu_gem_force_release(adev);
        amdgpu_vm_manager_fini(adev);
        amdgpu_gart_table_vram_free(adev);
+       amdgpu_bo_unref(&adev->gmc.pdb0_bo);
        amdgpu_bo_fini(adev);
        amdgpu_gart_fini(adev);
-       if (adev->gmc.pdb0_bo)
-               amdgpu_bo_unref(&adev->gmc.pdb0_bo);

        return 0;
}
--
2.17.1

--_000_DM6PR12MB40751123CB0B7B658DFDB292FC919DM6PR12MB4075namp_
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
p.msipheader251902e5, li.msipheader251902e5, div.msipheader251902e5
	{mso-style-name:msipheader251902e5;
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
<p class=3D"msipheader251902e5" style=3D"margin:0in"><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:#317100">[AMD Publ=
ic Use]</span><o:p></o:p></p>
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
<b>Sent:</b> Wednesday, March 10, 2021 18:40<br>
<b>To:</b> amd-gfx@lists.freedesktop.org<br>
<b>Cc:</b> Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;; Zeng, Oak &lt;Oak.=
Zeng@amd.com&gt;; Koenig, Christian &lt;Christian.Koenig@amd.com&gt;; Kasiv=
iswanathan, Harish &lt;Harish.Kasiviswanathan@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: Free PDB0 bo before bo_fini<o:p></o:p><=
/p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"msipheader251902e5" style=3D"margin:0in"><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:#317100">[AMD Publ=
ic Use]</span><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Cleanup pdb0 bo before bo_fini gets called<o:p></o:p=
></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Signed-off-by: Lijo Lazar <a href=3D"mailto:lijo.laz=
ar@amd.com">
lijo.lazar@amd.com</a><o:p></o:p></p>
<p class=3D"MsoNormal">---<o:p></o:p></p>
<p class=3D"MsoNormal">drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 3 +--<o:p></=
o:p></p>
<p class=3D"MsoNormal">1 file changed, 1 insertion(+), 2 deletions(-)<o:p><=
/o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b=
/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c<o:p></o:p></p>
<p class=3D"MsoNormal">index 45ba3819bb8f..e8de5145339b 100644<o:p></o:p></=
p>
<p class=3D"MsoNormal">--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c<o:p></o:=
p></p>
<p class=3D"MsoNormal">+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c<o:p></o:=
p></p>
<p class=3D"MsoNormal">@@ -1577,10 +1577,9 @@ static int gmc_v9_0_sw_fini(v=
oid *handle)<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ge=
m_force_release(adev);<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_vm=
_manager_fini(adev);<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ga=
rt_table_vram_free(adev);<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_bo_unre=
f(&amp;adev-&gt;gmc.pdb0_bo);<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_bo=
_fini(adev);<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ga=
rt_fini(adev);<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;g=
mc.pdb0_bo)<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_bo_unref(&amp;adev-&gt;gmc.pdb0_bo=
);<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;=
<o:p></o:p></p>
<p class=3D"MsoNormal">}<o:p></o:p></p>
<p class=3D"MsoNormal">--<o:p></o:p></p>
<p class=3D"MsoNormal">2.17.1<o:p></o:p></p>
</div>
</body>
</html>

--_000_DM6PR12MB40751123CB0B7B658DFDB292FC919DM6PR12MB4075namp_--

--===============0820045237==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0820045237==--
