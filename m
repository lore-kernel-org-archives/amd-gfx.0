Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D587ECAAD3
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Sep 2022 01:58:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 40ED210E102;
	Thu,  8 Sep 2022 01:58:42 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2057.outbound.protection.outlook.com [40.107.101.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 398BD10E102
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Sep 2022 01:58:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HmXccdjaDM94iHIkWkFxL2J6XQ6Ao1p9TKmLTCBWZhxE3W4TH+UiQbp0qciu7L2VIlzAtvq+m6m6h4YVU272Gi5BhytLQNNZcQdKru8BJhQP+IKJAvxZOI1kMfjcDKQ1KfsdHltn7ndq1HY1+RkSRW85zIawZhOZn5pU5etyyTvIDOm1YhGSL9nAnKxfydT46vT36FnDUibwI8DfGYyZHTgSs3+e3q1bWsWZR4Ai+zyhXcaqDDGDD6G0nblZCrymX7M3eDaXVVUwb3GgQRTOyg0ASqqUNRAcnih9D1RFp5ilpZjCPsiVF4rFM+BG5hWyRVo9qwBz56nhAipPigScYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xBilbuyTn1/royIHbPNnsssEA5j4nzZEM06y5TUsjNI=;
 b=UnPQtitt/rFn8mp2S0RtGQoeqB/FSCwVYsnFQszETtDjB+D9nSFNA8gHVXRfq1G+MCTdWSD20F6oTmHEVb/ANoeeRPV/soRUPtqT4TzTifDr/U1Kdx+9EL2PuKMjh2KJgZXBbkGuARoh9zFNo/oOWOnsyC+4Xv5NsPA+b4Csc9tzyO1uc8E2rVGqxxQfObPiV023KDytTxwne17DWlRGmO2XtGtGsyyeBiuU6H2sNM+GRQC0piBYkIX0ptpMqIYiwH5F1svYQgTc/g9me+KEQ+OYg/2nwat+atBld6cteySFYp5fzjCqE1gvvcMiFGAXKbfGvOq/+AZ2MT9wyZRf1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xBilbuyTn1/royIHbPNnsssEA5j4nzZEM06y5TUsjNI=;
 b=q640jqWCVZIcB51CI4CO9AUWxyaO7C3NyR5gu/o84/veTyGfZGYJY1aIclof6VFo+cRMlh+t0P42s/AVALu3ngA/GUFzEZ8zE+Mf5HxqJeuh1w6vh8EpIn7mp+PkGcauYyp4Z+ISXg6NcsdPthNsrTdV8X3tUQLyyYH60CfoKwY=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by DM4PR12MB6278.namprd12.prod.outlook.com (2603:10b6:8:a4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14; Thu, 8 Sep
 2022 01:58:35 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::1192:d133:8667:ed28]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::1192:d133:8667:ed28%5]) with mapi id 15.20.5588.018; Thu, 8 Sep 2022
 01:58:35 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Li, Candice" <Candice.Li@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu: Rely on MCUMC_STATUS for umc v8_10
 correctable error counter only
Thread-Topic: [PATCH] drm/amdgpu: Rely on MCUMC_STATUS for umc v8_10
 correctable error counter only
Thread-Index: AQHYwyBuqRhEVw2D/Euy504s3Wwfpa3Uxqn4
Date: Thu, 8 Sep 2022 01:58:35 +0000
Message-ID: <BN9PR12MB52575B55845850645F5C74BEFC409@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20220908011409.17228-1-candice.li@amd.com>
In-Reply-To: <20220908011409.17228-1-candice.li@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=True;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-09-08T01:58:15.1207451Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 546c16fd-bab5-41e9-205a-08da913da3dd
x-ms-traffictypediagnostic: DM4PR12MB6278:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Oq8wC5Ix5nS5kG4Jzzu1uhW/lSjy3bTuAjGv+Su6Qa6XMo/n0zghVjwDwCxvBZYKlzNELS0sLlr6O3yOPZSFjsPsfRtNLcg7CHAbFwULql/sn40lrqFa/xN9RI/McdG9x0IP6n5dsGh0JjPavX6wV4Mk1tI4tFhAYvN499+O/qdxtXlK44N4WcRLGOvSUI8Am1VUxasGleRDRPAkgkvOzTwPcxx5bwslcO1Q6RkNKzgkh0ERx9rSxWs28HlMJLuTFhBpFeQpGbIqIWF24whgCc+ag0fIVkmjyQK25VeG3fMeR0hl3WGQoOrb3V1JOIrhU+7w4fkNpBnaWjzAwOFzVmGYf07jpiUm1QP6TE+5I9fJMktQlJCVYiZ0lIva4H110Z2OTo3wnuCAreZAm7GW3rNRGTdM0VWRIiCnTB5AqSYnlAe50sXdrfTHj2iGASH/JsxiFMGXcFPDaaXP2sYHz3MtmjME4754aWvJnLZOU+TtW9u6yYsq0PLakBibqd3Qf9Y+1hwpXryzyfBqcd4oewY75ItA6p6Xkts78+6m6ieHZzq49qr3shHFG94gtHVH3XwV92IeQ9NjepgitQZclEWSEsF/M/c9kRXINaiQcUdgTQPfEgmQnyhy2FhkR9pC2YJRJHWJX5GTSBXW/XqQCbxDaQCOE1kChy2zdDzQn/bvFHuZ3d+VOAZbYo1br8DGTqMKL2DIU/kMPvRZKnUxlwkg5FAd/CCIC3Du9m7jQx1YBnYvQFSipXWY9nrkirKyy0ETf40+m2BZsoYNc1QqHA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(39860400002)(346002)(136003)(366004)(396003)(376002)(86362001)(122000001)(38100700002)(38070700005)(66446008)(64756008)(8676002)(4326008)(76116006)(66476007)(66556008)(66946007)(91956017)(33656002)(83380400001)(478600001)(9686003)(7696005)(26005)(41300700001)(71200400001)(53546011)(316002)(110136005)(6506007)(55016003)(186003)(8936002)(5660300002)(2906002)(52536014);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?R4eJcHRLBAcEt7R9LD2BTYPv12cWWCY6LdoHsQ3bkuRLSPOACnOlMCOkVOAy?=
 =?us-ascii?Q?ixUXX59JbOpq4DKqxH5aEO6861vZiCNalX5N/Xb2S+nfgIu+nYdK3Z8SAxSm?=
 =?us-ascii?Q?8R5DohU4qNnAmYSjnoiPUDviMwvJwAladAGVK/eByCFvUttgSxCb4+CwUu3p?=
 =?us-ascii?Q?h0P2OZr9uLXzhpAusMwkNsM8y6Cm03YoNuKRIYBexH8kiqVedysd4gKfs1xN?=
 =?us-ascii?Q?3ihjFryR/88DpIjn+T3mFhcWziTnkhhqHTXB1wLnZJ+U6CfC7hvhWamt+veP?=
 =?us-ascii?Q?oBwXIXpYQy0RC/w88sKbvG+zRgLPSTOwmrUnrloihZVo39jKfvkTAemfSyP7?=
 =?us-ascii?Q?XQPx5nDs/a9oo3ocYcRqn9ngVwWRlr9WP4dPxrSQKFzr5z3zdxQcBRfOTC1V?=
 =?us-ascii?Q?btPztLaiOtaif1CAPJz0WsZebT3T8bHocdlaxislpYj/MqJi5KLG9JP29MsO?=
 =?us-ascii?Q?GZFkIMigGxwiFzGmPfrCXzCkDyYjLt46GS4ZRXFGn/ZJXcAUOB+vKUlRRq3C?=
 =?us-ascii?Q?O3WYMyRy8ds4hEQm1E/lr0IIA/8E5iJI94Ld0gibN7plcw5v2LrnyvkiqBeh?=
 =?us-ascii?Q?kK2FRasicek1s2ig84AEFyOHrDpXzxVbbD+q5f2jVPmhBYjSj6fR5Cgn1Slt?=
 =?us-ascii?Q?8Blca3l4PqVMIHV5JkSCR0PJkU/VXlCn8O59h4LjRmCzALa6RYxxeDYFBnGe?=
 =?us-ascii?Q?sQ0SWIxYv443eXmWx2RdJW8HIAWnHU1ocoP651a7fiedmjYkZihNGkUVOeRr?=
 =?us-ascii?Q?k/Fe7t/ozZlKaEbQB2hC8jRNcoX12wNDDBcYFJuWTissFBaQdeIs7ilb8TuP?=
 =?us-ascii?Q?H76TtWjlFP5i0h9YlRrDUmTI/nsh4jYJkzqp4XXFfPefecSt27vzSg8ezBN5?=
 =?us-ascii?Q?pnDmagBpQokYieKWm/rX05Da8gief5KQnL252Jwqpfkk9u7fhyJGh8WHeyBV?=
 =?us-ascii?Q?XeIYfg96WF9XTC8aH0x53QlQKQIIJenZOVWfOkkfLX2cMbbUd3Wv3J5k8cMD?=
 =?us-ascii?Q?RcJho37FqV7GAs5ksg2kaRzrvBr4ji+r4G8oxouDDqgMj0sExjg5T2FrxzQi?=
 =?us-ascii?Q?kPTp4z6ZPO1lnrMxs13IfjL9Vau4JPy5QHTeKrnvkUf8P09MsxUEJqe/1BSy?=
 =?us-ascii?Q?SOGMUsdgorP1I29vET7qjF37sL9OT51PJarIgIo2IC9yDBvODcKzb4GaPbA5?=
 =?us-ascii?Q?mkOanTJwSSpNuwZ6UoSOzy1sKOHb7X/6BrYUO3SUehFTVu8Kr3LJ6u1qSAxz?=
 =?us-ascii?Q?hA+xh62TDv/MJjY7JDxU2B6QVvnm9BV7zRa90MBd6EIPOg/+3dnYy1hKXWm0?=
 =?us-ascii?Q?etuaXYa2heORO/A7e11flnnbZ8uKjAUOxN50G358S4gUd6qWe6QXUC4XDapO?=
 =?us-ascii?Q?0SUyQPaEdblPSHoIxghPYTyPhvPRmyPPNT0/denRKm25vXi8enKTWN5Bezfs?=
 =?us-ascii?Q?dUZOdyAvrrnBL6sOunnIvRgd0Dn+81ti2bs1yCL+VrL+LAPcXa5tY8iwMl/s?=
 =?us-ascii?Q?iokeAq6PS1oQDkrVrx48ok9Rv7bhxXoEJeFGdaNMv5siDaM2wS3r6aVaKFNS?=
 =?us-ascii?Q?L2RCuxgDTvEdbRFAwyYuovbbDy+eZ4WNoKS0E6RqnKkE35u0KS1ABYM3e3XX?=
 =?us-ascii?Q?xw=3D=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BN9PR12MB52575B55845850645F5C74BEFC409BN9PR12MB5257namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 546c16fd-bab5-41e9-205a-08da913da3dd
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2022 01:58:35.4088 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Qjs8YaO1U/MW9dnTDJ9uFkT8WAKbEgIWpThBUXNKZk6DS3YrpCZy0F0lggNnt0yO+990Urd/3mn25+rSWDKknA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6278
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
Cc: "Li, Candice" <Candice.Li@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_BN9PR12MB52575B55845850645F5C74BEFC409BN9PR12MB5257namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - General]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Candice =
Li <Candice.Li@amd.com>
Date: Thursday, September 8, 2022 at 09:15
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Li, Candice <Candice.Li@amd.com>
Subject: [PATCH] drm/amdgpu: Rely on MCUMC_STATUS for umc v8_10 correctable=
 error counter only
Only check MCUMC_STATUS for CE counter for umc v8_10.

Signed-off-by: Candice Li <candice.li@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/umc_v8_10.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v8_10.c b/drivers/gpu/drm/amd/a=
mdgpu/umc_v8_10.c
index 36a2053f2e8b94..a8cbda81828daf 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v8_10.c
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v8_10.c
@@ -101,22 +101,16 @@ static void umc_v8_10_query_correctable_error_count(s=
truct amdgpu_device *adev,
                                                    uint32_t umc_reg_offset=
,
                                                    unsigned long *error_co=
unt)
 {
-       uint32_t ecc_err_cnt, ecc_err_cnt_addr;
         uint64_t mc_umc_status;
         uint32_t mc_umc_status_addr;

         /* UMC 8_10 registers */
-       ecc_err_cnt_addr =3D
-               SOC15_REG_OFFSET(UMC, 0, regUMCCH0_0_GeccErrCnt);
         mc_umc_status_addr =3D
                 SOC15_REG_OFFSET(UMC, 0, regMCA_UMC_UMC0_MCUMC_STATUST0);

-       ecc_err_cnt =3D RREG32_PCIE((ecc_err_cnt_addr + umc_reg_offset) * 4=
);
-       *error_count +=3D
-               (REG_GET_FIELD(ecc_err_cnt, UMCCH0_0_GeccErrCnt, GeccErrCnt=
) -
-                UMC_V8_10_CE_CNT_INIT);
-
-       /* Check for SRAM correctable error, MCUMC_STATUS is a 64 bit regis=
ter */
+       /* Rely on MCUMC_STATUS for correctable error counter
+        * MCUMC_STATUS is a 64 bit register
+        */
         mc_umc_status =3D RREG64_PCIE((mc_umc_status_addr + umc_reg_offset=
) * 4);
         if (REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, Val)=
 =3D=3D 1 &&
             REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, CECC=
) =3D=3D 1)
--
2.17.1

--_000_BN9PR12MB52575B55845850645F5C74BEFC409BN9PR12MB5257namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" xmlns:w=3D"urn:sc=
hemas-microsoft-com:office:word" xmlns:m=3D"http://schemas.microsoft.com/of=
fice/2004/12/omml" xmlns=3D"http://www.w3.org/TR/REC-html40">
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
	font-size:10.0pt;
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
--></style>
</head>
<body lang=3D"EN-US" link=3D"#0563C1" vlink=3D"#954F72" style=3D"word-wrap:=
break-word">
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;" ali=
gn=3D"Left">
[AMD Official Use Only - General]<br>
</p>
<br>
<div>
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">Reviewed-by: Hawkin=
g Zhang &lt;Hawking.Zhang@amd.com&gt;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt"><o:p>&nbsp;</o:p></=
span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">Regards,<br>
Hawking<o:p></o:p></span></p>
<div style=3D"border:none;border-top:solid #B5C4DF 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><b><span style=3D"fon=
t-size:12.0pt;color:black">From:
</span></b><span style=3D"font-size:12.0pt;color:black">amd-gfx &lt;amd-gfx=
-bounces@lists.freedesktop.org&gt; on behalf of Candice Li &lt;Candice.Li@a=
md.com&gt;<br>
<b>Date: </b>Thursday, September 8, 2022 at 09:15<br>
<b>To: </b>amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc: </b>Li, Candice &lt;Candice.Li@amd.com&gt;<br>
<b>Subject: </b>[PATCH] drm/amdgpu: Rely on MCUMC_STATUS for umc v8_10 corr=
ectable error counter only<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><span style=3D"font-s=
ize:11.0pt">Only check MCUMC_STATUS for CE counter for umc v8_10.<br>
<br>
Signed-off-by: Candice Li &lt;candice.li@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/umc_v8_10.c | 12 +++---------<br>
&nbsp;1 file changed, 3 insertions(+), 9 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v8_10.c b/drivers/gpu/drm/amd/a=
mdgpu/umc_v8_10.c<br>
index 36a2053f2e8b94..a8cbda81828daf 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/umc_v8_10.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v8_10.c<br>
@@ -101,22 +101,16 @@ static void umc_v8_10_query_correctable_error_count(s=
truct amdgpu_device *adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; uint32_t umc_reg_offset,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; unsigned long *error_count)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t ecc_err_cnt, ecc_err_cnt_add=
r;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t mc_umc_status;<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t mc_umc_status_add=
r;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* UMC 8_10 registers */<b=
r>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ecc_err_cnt_addr =3D<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; SOC15_REG_OFFSET(UMC, 0, regUMCCH0_0_GeccErrCnt);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mc_umc_status_addr =3D<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; SOC15_REG_OFFSET(UMC, 0, regMCA_UMC_UMC0_MCUMC_STATUS=
T0);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ecc_err_cnt =3D RREG32_PCIE((ecc_err_=
cnt_addr + umc_reg_offset) * 4);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *error_count +=3D<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; (REG_GET_FIELD(ecc_err_cnt, UMCCH0_0_GeccErrCnt, GeccErrCnt) -<b=
r>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; UMC_V8_10_CE_CNT_INIT);<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Check for SRAM correctable error, =
MCUMC_STATUS is a 64 bit register */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Rely on MCUMC_STATUS for correctab=
le error counter<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * MCUMC_STATUS is a 64 bit regi=
ster<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mc_umc_status =3D RREG64_P=
CIE((mc_umc_status_addr + umc_reg_offset) * 4);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (REG_GET_FIELD(mc_umc_s=
tatus, MCA_UMC_UMC0_MCUMC_STATUST0, Val) =3D=3D 1 &amp;&amp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RE=
G_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, CECC) =3D=3D 1)<br>
-- <br>
2.17.1<o:p></o:p></span></p>
</div>
</div>
</div>
</body>
</html>

--_000_BN9PR12MB52575B55845850645F5C74BEFC409BN9PR12MB5257namp_--
