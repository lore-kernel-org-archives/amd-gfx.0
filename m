Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BFE5C433EF
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Jun 2022 09:57:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 437DA10E209;
	Wed,  8 Jun 2022 09:57:24 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2056.outbound.protection.outlook.com [40.107.102.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 10D5C10E0D3
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Jun 2022 09:57:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Obe7EVyx1nC0Kwp0EWaZ0cJyTisExkPSb6yZ4ip9YD3Cv5FNrVStDPyskKgMWhQgrVGzk5mX3Tp/fvDo6sHsVY9txx0NcoVk9YbuFljc1vSRDCZgpiBcc5CB5GwNxwsPu62fcKXevzV6cnRFYDg1N3AQJT/e5+B6via+pbncGcv4vHoDtxbZrw+k90NaDVahAkbCKXe2uC4t9quc8ihsNB/UU0p5m8MCA+RH7E0SlspFZ/MvJdRUmQ74aFX9+LwEILe/i+zlyZhDc7RuHhUA/09/sVfbkDTo36NhI23PxWu2QkbxIQybsq4SMZTmWw6exR7uoZOYzNTi71S1+WuKXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g1FU/+fx6kNxCFWT29Vgl6dH4BJDSQRIvhOD/C4Qnbk=;
 b=KO1T0ff7bxK08r4ajIqhfZmtn2b95fSbGesjHMipvYL1Rabg0iQqjfXBbSxXJLLFOo1Kvx9tWzbGsxONZmc6i9CF2HhGA9kJr8KKxHnrT32vIPRwgTqD0OYaYDn4gSVhLOjoUv7X4gSROJGUHJvKKQ9+HDgXBjaprP3SNTP9/02BjLOzlPuT7H6FTtuZog35PS08asaX0i1KS68J9Zwh044MOAKweA5mgvuU2Cv6RQCHlZw242GTVAMW7Exw1NgbbYCQ8yAC/nTakSAy0DAL0yCo1yyzKrPxh+Wda93hFOAQFmfUCTR3H+0PGBtpVfEU05MCE8VnE7EKU87vm0yTfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g1FU/+fx6kNxCFWT29Vgl6dH4BJDSQRIvhOD/C4Qnbk=;
 b=l1Dcgk3u6SCXKWO4wWqHPFHpk2YpijUhEl9uc2C4Kw5PzKZFaVNorG7TvYoom8ogq3AVLQ3Idb9enPLAAbhpcSQaQLuO58HuD4Fs/ok5sU8xbnkSDf9B7ZfxGS8iyYc2IBSD67eY3w/DyKatvUBdPZIcIdwVpLJZS9RF78zlkUU=
Received: from PH7PR12MB5997.namprd12.prod.outlook.com (2603:10b6:510:1d9::21)
 by DM6PR12MB3227.namprd12.prod.outlook.com (2603:10b6:5:18d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.13; Wed, 8 Jun
 2022 09:57:20 +0000
Received: from PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::5108:cd17:1f53:8f88]) by PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::5108:cd17:1f53:8f88%7]) with mapi id 15.20.5314.019; Wed, 8 Jun 2022
 09:57:20 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "Feng, Kenneth" <Kenneth.Feng@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 1/5] drm/amd/pm: add interface to deallocate power_context
 for smu_v13_0_7
Thread-Topic: [PATCH 1/5] drm/amd/pm: add interface to deallocate
 power_context for smu_v13_0_7
Thread-Index: AQHYexb1SRR6Or+/tUOggG1jp0VgEK1FRfmR
Date: Wed, 8 Jun 2022 09:57:20 +0000
Message-ID: <PH7PR12MB59975DD244586B51074032B882A49@PH7PR12MB5997.namprd12.prod.outlook.com>
References: <20220608090536.1969621-1-kenneth.feng@amd.com>
In-Reply-To: <20220608090536.1969621-1-kenneth.feng@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=True;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-06-08T09:57:19.952Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 39c2ebb8-5e99-420b-f95f-08da4935477b
x-ms-traffictypediagnostic: DM6PR12MB3227:EE_
x-microsoft-antispam-prvs: <DM6PR12MB3227E3F5A97EAAABD9DFB2FC82A49@DM6PR12MB3227.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: B0qupcHVtjIQy00I716MkRzNoa9iBLmvzZAdzYRyXOG5zXSVyZhDUMSZWlTU3A7nSlUd9KkAhWp/+LEkgDUMvITC1aaI9TYnrRdMwdff+Yx9BpatpiTLsYctFZazDhCWoQC+xUD8cQC8XrcAFUE2dhvpFpw/xbAzuu/rqJGn7CO9ahNTEVGPLscM3Y2uq6iP0wkP7TpD/Yr5hGeU1mU8bbiC3qUMpkwHLQ6hpmUMEHbcsWVL1Mz2xAK9By9aLLRcWH/mkDAUOfKayPbK7GNwQXuWJOKTn0olOGPkjPreg/1mZ45T1tzzMGwDWzwo2ytKWxwwbJUG2W8nzX7dpW2r+ZQ9SZcSXI6Q1MYcK/UZbq5pggO3vLXOmgYTcDmcyg/AA8pEh5xn9GvXAkpfpLUUDBmummzzpqrPj6b3ZypctbaDoLjj0+Uk1yM1qyjOfbq+nqbjoc5QDfAIfrYMncs8ZKIrULXYNhoBP7gjYjNaK3bHkjKPLHiMo+PbalgvwxZ1oKW54lR6EGpP3UiczcFnsngi+fu7GoIfXY8W1MLwn4faw5auxrm/7UFlhe1jsVKq7nUcTMSNJOtbND7ADDUoDINITq3nnIIVwiB1VGVVvEJ0alLj0R+ffuF/QAM0PEy8cH6oeQzRsVpGpBGetiMPhiB2igj3Ruf4pxZihVY5vD38ZG9jwySSnQwoDHGu/dzTpsEgNImHivmqHF3kvIVrBw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5997.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(66446008)(66476007)(64756008)(66946007)(53546011)(8936002)(66556008)(8676002)(110136005)(186003)(508600001)(6506007)(38100700002)(7696005)(86362001)(33656002)(76116006)(71200400001)(2906002)(52536014)(38070700005)(26005)(9686003)(19627405001)(55016003)(122000001)(316002)(5660300002)(91956017);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?ijyytjLo7vnHTag+nQfyGWXyR7HXC0+c1Tulefp1LFEoBtphcensUcsGyc?=
 =?iso-8859-1?Q?aG241kBjy4DQaJZxJ4A5FK/gqZeCPmRCqZIU+KuXevPSUQQFp0IZk83J6y?=
 =?iso-8859-1?Q?hF1qOzj10l2C9u1LT3ZXFWI8/9gsV0hEiLIgc7tewgXvkU/U9E+QJ8aSK5?=
 =?iso-8859-1?Q?v0uSBTzpDQ/up19HVy3lBR5Ud/2bB25auBW7dYeCRjuHyfjDCca+hYt8/O?=
 =?iso-8859-1?Q?rPCIDWK8cFh+jNf9VPGbUhst5HpeGUDj4QeMiWTZ4d6oh+czzT37K1qH75?=
 =?iso-8859-1?Q?XQB+av6kJVctFmC9tmRVJtOwd6RBuQZa5NXwPewgB5cQ9bmMJbdUkY7AVL?=
 =?iso-8859-1?Q?+tP8NxpXjEGsVfqdzRj2C5kaw5YWkATh2DbDOxw/vue5wzAdNpvMG283sF?=
 =?iso-8859-1?Q?54Ys51joqMwZLAA15vN15cOSEIyoNnUZfYpLYF1VD/G4/fi/cEPAEcq6rD?=
 =?iso-8859-1?Q?t5X7e7jh/aEwY/Y+b+nTGPHNqHYgApl1aRiEyzPAROlO02J7nhcjhPSvUx?=
 =?iso-8859-1?Q?yO9TdDq82rQVvjhqIFGOAfvAygCl3dnmlCo7p2Gds3/D04tN2O4Ng+72lh?=
 =?iso-8859-1?Q?i3U66ottd9PZ/s0BRdRQ4+9uvAn8a5fAbqsTIGRat93zeNqVqg8BEVX3aZ?=
 =?iso-8859-1?Q?oqsON5QZ7trv516fgkVBi06b39tQQpB0MbWTGds4GFA2mqLPKP1jgyASVU?=
 =?iso-8859-1?Q?0nMEfvOqakqEb4RgsfRqEABRySICnHrGpMEzQSqSwda9Hf5PWtitSGPXwN?=
 =?iso-8859-1?Q?hhZvEDGYi631zIL8m0a4ucdY94A31Y4x9pvPwALu7Piyq6Xn+DaquTzRlb?=
 =?iso-8859-1?Q?Rou+RFSlbE36VOcHN2yl/9pMtE2W1ElpqxQv5Wm/Cu5BXupP5e6F0SIC6u?=
 =?iso-8859-1?Q?wI4na4LDeauIa5r2ftiiukyZhyzpXAuaG/aG91Cs/RmyfZewDGmgkBZmpF?=
 =?iso-8859-1?Q?HOJn9rE2xvCAJtPUGsyQYNdrAiHd5gWFNQiIjVyKrwjPiNrIr891WBGhK9?=
 =?iso-8859-1?Q?2epdP160WiEDtn7HrrIFnywXMOC0yHBzgIBgGDvlJHtcTGo9Kp2KQ/Szyf?=
 =?iso-8859-1?Q?F5cIPkZ1swaY5K8iUpSQNuImm+O2b3acS6cszbnpEeSWvy0EI0iK2ybZ9/?=
 =?iso-8859-1?Q?kqQ7knbNwXua9H41aPJhHwsJUUtuj7Zi9Y93421gIPo0Vv1roY264F9aTZ?=
 =?iso-8859-1?Q?QhADHknAJUOWWq3nU9F8uT+2a6KKaqIwxrLhpSRLCVPC2MBeQ4E6/jIs8R?=
 =?iso-8859-1?Q?hef1kr1AftqoeAjYXnlUE/nVh9CSDOxLfxuhpQhTDOHCKZ4Tjh4db7yAEU?=
 =?iso-8859-1?Q?Wl2q/vMYSrW5UFqPmd83FoYRGwS1lpYk3dhMty4UYli8i/ZRKzgT7eKXcB?=
 =?iso-8859-1?Q?Mz7GodTutkVtqtmLluRwuz8EQ1TgzV8DJEgln2QqMKOpSIHyn8xgb46fDz?=
 =?iso-8859-1?Q?fwoQHQ7EFUPBwzYJ6YecnsWTnpMJXp6fx03evAJawrLnBZyGbI3Eehww/F?=
 =?iso-8859-1?Q?zvHQqXsKxajKMtMK2DYGIL9BkW1O8yLDaCOPhbTvZlpHWQSumGTryv6kI/?=
 =?iso-8859-1?Q?Oj52msKGEvmBK6nMPmbkpnur1kq6ByTWVjITprvbAqRIOeV4HFfmXkKJB6?=
 =?iso-8859-1?Q?ye1QeH5Coa6dn77NpJDWd3NGAp/IwrjvimQ0Qa74rSvlC33z9O9RXCTsdx?=
 =?iso-8859-1?Q?zDf+B56QOCPpbDhQnAyWTE4bvZfsRj0AJmCnOMarYYtKTTTfONiyFWHSuU?=
 =?iso-8859-1?Q?FVlM8uMjPW7ciRYUMzXSAFMlXlxI1+vk+ncpsavhyoegGi?=
Content-Type: multipart/alternative;
 boundary="_000_PH7PR12MB59975DD244586B51074032B882A49PH7PR12MB5997namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5997.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39c2ebb8-5e99-420b-f95f-08da4935477b
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2022 09:57:20.7123 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DGelvQHrjvyl2kc2cMlRGDGxHcjwo2fmSodZQDrnWflZInP3e940Oe19d7SP6xFC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3227
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

--_000_PH7PR12MB59975DD244586B51074032B882A49PH7PR12MB5997namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - General]

Series is

Reviewed-by: Yang Wang <kevinyang.wang@amd.com>

Best Regards,
Kevin
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Kenneth =
Feng <kenneth.feng@amd.com>
Sent: Wednesday, June 8, 2022 5:05 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Feng, Kenneth <Kenneth.Feng@amd.com>
Subject: [PATCH 1/5] drm/amd/pm: add interface to deallocate power_context =
for smu_v13_0_7

add interface to deallocate power_context for smu_v13_0_7

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
index bdea7bca3805..7da42cae5d6e 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
@@ -1541,6 +1541,7 @@ static const struct pptable_funcs smu_v13_0_7_ppt_fun=
cs =3D {
         .load_microcode =3D smu_v13_0_load_microcode,
         .init_smc_tables =3D smu_v13_0_7_init_smc_tables,
         .init_power =3D smu_v13_0_init_power,
+       .fini_power =3D smu_v13_0_fini_power,
         .check_fw_status =3D smu_v13_0_7_check_fw_status,
         .setup_pptable =3D smu_v13_0_7_setup_pptable,
         .check_fw_version =3D smu_v13_0_check_fw_version,
--
2.25.1


--_000_PH7PR12MB59975DD244586B51074032B882A49PH7PR12MB5997namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
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
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
Series is&nbsp;</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
Reviewed-by: Yang Wang &lt;kevinyang.wang@amd.com&gt;</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
Best Regards,</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
Kevin</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" co=
lor=3D"#000000" style=3D"font-size:11pt"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Kenneth Feng &lt;kenneth.feng=
@amd.com&gt;<br>
<b>Sent:</b> Wednesday, June 8, 2022 5:05 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Feng, Kenneth &lt;Kenneth.Feng@amd.com&gt;<br>
<b>Subject:</b> [PATCH 1/5] drm/amd/pm: add interface to deallocate power_c=
ontext for smu_v13_0_7</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt"=
>
<div class=3D"PlainText">add interface to deallocate power_context for smu_=
v13_0_7<br>
<br>
Signed-off-by: Kenneth Feng &lt;kenneth.feng@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c | 1 +<br>
&nbsp;1 file changed, 1 insertion(+)<br>
<br>
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c<br>
index bdea7bca3805..7da42cae5d6e 100644<br>
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c<br>
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c<br>
@@ -1541,6 +1541,7 @@ static const struct pptable_funcs smu_v13_0_7_ppt_fun=
cs =3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .load_microcode =3D smu_v1=
3_0_load_microcode,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .init_smc_tables =3D smu_v=
13_0_7_init_smc_tables,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .init_power =3D smu_v13_0_=
init_power,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .fini_power =3D smu_v13_0_fini_power,=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .check_fw_status =3D smu_v=
13_0_7_check_fw_status,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .setup_pptable =3D smu_v13=
_0_7_setup_pptable,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .check_fw_version =3D smu_=
v13_0_check_fw_version,<br>
-- <br>
2.25.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_PH7PR12MB59975DD244586B51074032B882A49PH7PR12MB5997namp_--
