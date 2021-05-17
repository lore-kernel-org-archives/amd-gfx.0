Return-Path: <SRS0=Ip1/=KM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90C6BC433ED
	for <amd-gfx@archiver.kernel.org>; Mon, 17 May 2021 08:40:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 50A5861108
	for <amd-gfx@archiver.kernel.org>; Mon, 17 May 2021 08:40:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50A5861108
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 76DDA6E11C;
	Mon, 17 May 2021 08:40:26 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2057.outbound.protection.outlook.com [40.107.220.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A6876E8F6
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 May 2021 08:40:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k2FoUlhr01L8JzEEYkCvc6f9/bihZc7FhT0IX8Sw0l5IcSDW6oSKhUZFMo6AF7OqMvYNxW+gZw7MMU4DlR62+al59MO0DlTiZ5lccKY41jYaE3gkJSw7vChZtHPggoe2txrECxYsY99mPA8DXo+EBqBaBsxdFiRN0AkQGs1x0XHtwhe0YuBLBtVpX7zBt2fWx+7a6DsMKTJJ/y1aA6/t0fQshRRSYT7JB7tXCJD3JuKPQvSjMATQk04Z7/ZsibAyH2jVscY5S/tIT5i1kw9e58c+tWFTHNxZsOrsjXOlQKTnkKE2FX/H4aEltknULNrBG1S/2qlBM2FPiCHJXzLHqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ub9G3paog3KFqC/ibVnKLKM5HNqH7U3FUvcxSHcJUkE=;
 b=FwUV1xLDt0+rAl167cvcIHZkZemADTn0zi/uXhnLq0IggDO/7j+08swm8N5ATCAXT0MT1fJnyhXl8OpqZ9Fd0dXvL3yb16gqpt/tYiBINdpgdRpM4Hg+PCHA2Qz4MVWXry1nn4/BMy//arnLwSDfEvM+Z7DIWBQThfE6x5i6HnVAv4YyoevtewAWBBCMC8YAju++IrPyzWja11MUAU0Ne0FPhrNcygbj2ICcVgrHfsS7LmvpWSCjlJFN6l0brPG0tQri3ZdwvOnsw6yJ9TeLiO1f7QsKuKEZOSJxSPMgjiBQf2ozAwaL0CLMTB4GoMLFgH7Ti5zH3oJoLrqq9JyOfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ub9G3paog3KFqC/ibVnKLKM5HNqH7U3FUvcxSHcJUkE=;
 b=bMjAvhPDbSXcwR/jP2aCttq0hvykOMFqsnliNP7/IwVP49V4y35sEx7KV0SQOGXRbdYevt9k2Lr2Bg1wxCNVz3XTC+Zg06/Yz6Wuhwl8mHZj9sBH/HgqbCCWrKv0ChMWH80pxuQ5P1Nf71sTwTRwO45nv2/7/5sbzD2+ZAs906k=
Received: from CH0PR12MB5348.namprd12.prod.outlook.com (2603:10b6:610:d7::9)
 by CH0PR12MB5043.namprd12.prod.outlook.com (2603:10b6:610:e2::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.26; Mon, 17 May
 2021 08:40:16 +0000
Received: from CH0PR12MB5348.namprd12.prod.outlook.com
 ([fe80::9c3:508d:5340:8efd]) by CH0PR12MB5348.namprd12.prod.outlook.com
 ([fe80::9c3:508d:5340:8efd%6]) with mapi id 15.20.4129.031; Mon, 17 May 2021
 08:40:16 +0000
From: "Lazar, Lijo" <Lijo.Lazar@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 3/3] drm/amd/pm: Reset max GFX clock after disabling
 determinism
Thread-Topic: [PATCH v2 3/3] drm/amd/pm: Reset max GFX clock after disabling
 determinism
Thread-Index: AddK+BdYXdxKJZClSAKOGQYepd2ncQ==
Date: Mon, 17 May 2021 08:40:16 +0000
Message-ID: <CH0PR12MB5348F690A9085DF0EF6C4DC9972D9@CH0PR12MB5348.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-05-17T08:40:12Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=53c04eaa-5494-453f-9a9f-e6703a0e6c5b;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.159.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: da1e98bf-bdb1-47f0-64f8-08d9190f6538
x-ms-traffictypediagnostic: CH0PR12MB5043:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH0PR12MB5043E10647BF8CB165B8ADDD972D9@CH0PR12MB5043.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:660;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FKG0p9Y7+iA2UdYrZZl/qUu8wvPdvNTBXnOQR864mUQ3ox+Wj+lXp1NfZ1/PD3qR/+5StVP2k7pBhHyC4cGa9q3OkW5+yQN2A7j9VoXWa3XzTA++H11DkMQg4uSApr2/wOi2FR5WzUc86XVpxwtA5Swa4UEef7b0+HXAR3lcFboP6eHLQMGBAyWSZ2WbH4TaTnktZzZxY73v5asP4IWTCEel7OVrg3oP9VoePidhrvm1pqpOqI2U/LABwUeoBafs5zV1tO0twaGVZiD+k1DXYFhyp2P+L+LWkFiu+a5Iiy34r2Gl/SOCNkepZe6/zDKnAdgje7d0gPschKzoj36z1RpEym2d8Fva0LUHiCHZzf5q9GaT+DgekyHVL8E1H6kbPthlkQdInJTggCFrZRtK11sqyu6wu9eFxy+zA7N/lQyAJY4+6p6X3cErJdIFKi9wuFNpxZhIhslk930piYH+ENlR7EILM/yrANsaBvKfrdzB1RjhCL9lLXZWKUn92HQRpifbQtUhXoRYEDfl8op1PR0Jm725YFuEtyOKRhmt6Dt5oMnd3gfkJ1X9DDXihvTCMtCCWKaQpLA2gLA/T0KdbTp65OlSbqEUbp/FjmrmyLQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5348.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(366004)(376002)(346002)(136003)(396003)(83380400001)(86362001)(38100700002)(26005)(122000001)(33656002)(478600001)(71200400001)(8676002)(8936002)(2906002)(186003)(7696005)(6916009)(66446008)(76116006)(64756008)(54906003)(66556008)(66476007)(66946007)(316002)(52536014)(5660300002)(4326008)(55016002)(9686003)(6506007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?sdWfom15Ul3uPH07zgMiXWD64XVxMqX2CCtBsqGNvqHW7Ah0Zy5SoThErbN7?=
 =?us-ascii?Q?BVVLw13aEroHF43/AzF84B3EwgXvuWz03YkkzQZ9Xwu2GraOheWQfiDZ9gGp?=
 =?us-ascii?Q?Xa5m3oRdZx7bDcROvGFjR2D1mmJ6KqydxXbs/QHNz+3EeR42BnxzvYOWaMn5?=
 =?us-ascii?Q?VcnJALL0MEPLUfnRzkcy6uiDS6IJQI1XoR6dd5eWvdHitTE8LFWhUbxW7CKg?=
 =?us-ascii?Q?HRJ6za9AT+89efibhYj7f7XU9XfkOdOZBeE4wtlgCgOyMHtHN+9EJ7dQo09b?=
 =?us-ascii?Q?PReDM1kJZjQ6CTDd/LdTnKakZk5I0TGIO/XHuZtJP1sZ6P3biKHDK9c41ppp?=
 =?us-ascii?Q?U1+pa4mndSKFv5ovC96RBT/7ajiFxoCYDBvsxajHgLbsQ/o4VM7DbCybzGRA?=
 =?us-ascii?Q?5DPlm4rJaaz3vEw9pXsa1Di56P5aoQrSNB96S94sFYaFloLuFwjBawnJQdxm?=
 =?us-ascii?Q?lsgihYfN+sv43sRNZtYkVwTMxf+eKex81Y4qGDEsl/tGeH7MS45EBPc+htHZ?=
 =?us-ascii?Q?VrlMbC5ogRZwmRGDxUTCw2pnZDZaqrETAET26XOEBdXd47vfspdGK6kKhD7j?=
 =?us-ascii?Q?ioJi3NBPXKqZ+n4412Knl1P93iyKEjgk3tSJ3rKu6EvPJfALAscc/h2ILQtN?=
 =?us-ascii?Q?1XEZnMk3OjFETdorNDkRUfbdXd3Qy5gjO3+DkJr9qGViHsrCQFAfO6E4+O9I?=
 =?us-ascii?Q?2Q6046wXqTlklgpcw77mdi9N5CW3gE2IujEKyZM0jBYWLKRCV0Og6HjGodP2?=
 =?us-ascii?Q?AARmcHEDbEyVoloQ7f8jyorn4dtkmgK9v2TzGQcC5JXyf3tKjKuQ26iYS5I1?=
 =?us-ascii?Q?mXQxHW3lXK2uy16kI+pkLFjQ9aewXXiw74qZ2ryx66QaZXlLdnlAvjAPiCHN?=
 =?us-ascii?Q?v4eOhTlfLqSQ8y2woFMBj1snXfa0gLTA+RTbFBNsyprGFgssto00Wax7LY/h?=
 =?us-ascii?Q?IsM9cCAFICxedPDUKHD8ynz8bB7utZARZTsCnvvvgr8MIoaubYGuem4C+SEL?=
 =?us-ascii?Q?5z0LnQwmWOaxvAm6OP1SY5r1P2AX2nC1M8VpBZUAynFrZt+EqRKjN0D0BmmL?=
 =?us-ascii?Q?07+yoDBHQOYtEDQ9NpnupegQmuOF5WJDJUrCyUMnRodrf/KDc69o4nCQGgYO?=
 =?us-ascii?Q?c1QCKxbM0D1BgkIuu7h00DZCFrzGRe82Lz42tVuCRQpSAIO+NxMcdYdbrHI6?=
 =?us-ascii?Q?oPhbT5fBfkPcxEhPjkyxeI92/GdOWrWRG8VXMgwqzyMf9x2n8yRQqZhE8CEt?=
 =?us-ascii?Q?VGtRc2MAyygI7LhM0L8T9KEFCiNl3cpdksSuxCxLPgo/UMqn5o6a3DQ/ssLG?=
 =?us-ascii?Q?r8j8yp39aeFRW5yZyBo9lYOL?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5348.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da1e98bf-bdb1-47f0-64f8-08d9190f6538
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 May 2021 08:40:16.1301 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: i6+6JC+w8Ke3YL/AxkaYmjfY00/r6NpQBpU6KHSmV6gr1j3BsexlntpS7JZeJJm7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5043
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
 Kenneth" <Kenneth.Feng@amd.com>, "Chen, Guchun" <Guchun.Chen@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Content-Type: multipart/mixed; boundary="===============0730504945=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0730504945==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_CH0PR12MB5348F690A9085DF0EF6C4DC9972D9CH0PR12MB5348namp_"

--_000_CH0PR12MB5348F690A9085DF0EF6C4DC9972D9CH0PR12MB5348namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Public Use]

When determinism mode is disabled on aldebaran, max GFX clock will
be reset to default max frequency value.

Signed-off-by: Lijo Lazar lijo.lazar@amd.com<mailto:lijo.lazar@amd.com>
---
drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c | 11 ++++++++---
1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/g=
pu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
index d27ed2954705..34afea71f1b3 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
@@ -1129,12 +1129,17 @@ static int aldebaran_set_performance_level(struct s=
mu_context *smu,
                                                                           =
       enum amd_dpm_forced_level level)
{
               struct smu_dpm_context *smu_dpm =3D &(smu->smu_dpm);
+             struct smu_13_0_dpm_context *dpm_context =3D smu_dpm->dpm_con=
text;
+             struct smu_13_0_dpm_table *gfx_table =3D
+                             &dpm_context->dpm_tables.gfx_table;
+             struct smu_umd_pstate_table *pstate_table =3D &smu->pstate_ta=
ble;
                /* Disable determinism if switching to another mode */
-              if ((smu_dpm->dpm_level =3D=3D AMD_DPM_FORCED_LEVEL_PERF_DET=
ERMINISM)
-                                              && (level !=3D AMD_DPM_FORCE=
D_LEVEL_PERF_DETERMINISM))
+             if ((smu_dpm->dpm_level =3D=3D AMD_DPM_FORCED_LEVEL_PERF_DETE=
RMINISM) &&
+                 (level !=3D AMD_DPM_FORCED_LEVEL_PERF_DETERMINISM)) {
                               smu_cmn_send_smc_msg(smu, SMU_MSG_DisableDet=
erminism, NULL);
-
+                             pstate_table->gfxclk_pstate.curr.max =3D gfx_=
table->max;
+             }
                switch (level) {
--
2.17.1


--_000_CH0PR12MB5348F690A9085DF0EF6C4DC9972D9CH0PR12MB5348namp_
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
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
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
.MsoChpDefault
	{mso-style-type:export-only;
	font-family:"Calibri",sans-serif;}
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
<p class=3D"msipheader251902e5" align=3D"Left" style=3D"margin:0"><span sty=
le=3D"font-size:10.0pt;font-family:Arial;color:#317100">[AMD Public Use]</s=
pan></p>
<br>
<div class=3D"WordSection1">
<p class=3D"MsoNormal">When determinism mode is disabled on aldebaran, max =
GFX clock will<o:p></o:p></p>
<p class=3D"MsoNormal">be reset to default max frequency value.<o:p></o:p><=
/p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Signed-off-by: Lijo Lazar <a href=3D"mailto:lijo.laz=
ar@amd.com">
lijo.lazar@amd.com</a><o:p></o:p></p>
<p class=3D"MsoNormal">---<o:p></o:p></p>
<p class=3D"MsoNormal">drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c |=
 11 ++++++++---<o:p></o:p></p>
<p class=3D"MsoNormal">1 file changed, 8 insertions(+), 3 deletions(-)<o:p>=
</o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/alde=
baran_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c<o:p></o:p>=
</p>
<p class=3D"MsoNormal">index d27ed2954705..34afea71f1b3 100644<o:p></o:p></=
p>
<p class=3D"MsoNormal">--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_p=
pt.c<o:p></o:p></p>
<p class=3D"MsoNormal">+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_p=
pt.c<o:p></o:p></p>
<p class=3D"MsoNormal">@@ -1129,12 +1129,17 @@ static int aldebaran_set_per=
formance_level(struct smu_context *smu,<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;enum amd_dpm_fo=
rced_level level)<o:p></o:p></p>
<p class=3D"MsoNormal">{<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_dpm_context *smu_dpm =3D &amp;(=
smu-&gt;smu_dpm);<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; struct smu_13_0_dpm_context *dpm_context =3D smu_dpm-=
&gt;dpm_context;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; struct smu_13_0_dpm_table *gfx_table =3D<o:p></o:p></=
p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;dpm_context-&gt;dpm_tables.=
gfx_table;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; struct smu_umd_pstate_table *pstate_table =3D &amp;sm=
u-&gt;pstate_table;<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Disable determinism if switching =
to another mode */<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; if ((smu_dpm-&gt;dpm_level =3D=3D AMD_DPM_FORCE=
D_LEVEL_PERF_DETERMINISM)<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;=
&amp; (level !=3D AMD_DPM_FORCED_LEVEL_PERF_DETERMINISM))<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if ((smu_dpm-&gt;dpm_level =3D=3D AMD_DPM_FORCED_LEVE=
L_PERF_DETERMINISM) &amp;&amp;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; (level !=3D AMD_DPM_FORCED_LEVEL_P=
ERF_DETERMINISM)) {<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_cmn_send_smc_msg(=
smu, SMU_MSG_DisableDeterminism, NULL);<o:p></o:p></p>
<p class=3D"MsoNormal">-<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pstate_table-&gt;gfxclk_pstate.c=
urr.max =3D gfx_table-&gt;max;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (level) {<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p></o:p></p>
<p class=3D"MsoNormal">-- <o:p></o:p></p>
<p class=3D"MsoNormal">2.17.1<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
</body>
</html>

--_000_CH0PR12MB5348F690A9085DF0EF6C4DC9972D9CH0PR12MB5348namp_--

--===============0730504945==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0730504945==--
