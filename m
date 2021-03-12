Return-Path: <SRS0=mwd6=IK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C06BC433E6
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Mar 2021 08:52:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05A7064FCE
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Mar 2021 08:52:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05A7064FCE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A9C216F4C8;
	Fri, 12 Mar 2021 08:52:21 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2068.outbound.protection.outlook.com [40.107.243.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A09846F4C8
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Mar 2021 08:52:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HElHGyGC4QLPfV3s+un9RKPGq7ctGyiLBTlSSoLJxvqJL8d6GWln7sjIZS9yFQXeoDN3SJeMfHm8EbvakWZdIGdErKc1c94SW5IumvEbLcHdYJt2x3moWxSYa7wlh5C3m3PNhUAR+NkXvU8LWNyrPjOLy+EYqmFhy8ibaQW+Wccz4IbaxAiqErdp9bfKOLBSKIBIEXUlYqC9P47JxwDwoSnEw9BgJmS3te6v3CWsfj2iqycJYaVhST1hBIn8H4rXc451WJpkdItspwA9avrW4ayM73a/KvOmx1IeqqQsigJAqwI0dmmYhjPHiNEkRfujo3XOfhM2fP3YfgcuS9SW+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dMiOLwy86YD8wuQUTMrDg14vDbDeyNCvraVJCoU7Z5c=;
 b=GquGJMWXNUqqrtXu9cvhexQrkYmqI5auqQGCqBLPHynMVv77XyKbjxosNWvIERXNQO1mc0Iex/JADtoipqGfQSDfvuhD/Yi85VWBm5kboUmkvBkAu8ejxHfOiX7rJOXidl9S2Bqoa7ZTWUEqocTcjH/HKU8XFETcwfWbWqFb7X84xawveyVzfRB94GciW5SIhDsLWQqEZi0WqsyIUGjJMJrtfNs8MEnWSb1Un5+Ryocz7JKJ3Xil4XQsIloDy/B+hLuzeZ8mLNN4/F4qGJ/OHdmVjSJQwdlV9a8wHtFd+7wuj5ZeUO+IbJC/bxwkMGA4jX0DNKeV4RB6IWhVgVK/Ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dMiOLwy86YD8wuQUTMrDg14vDbDeyNCvraVJCoU7Z5c=;
 b=rmLV9/vbAFlX1Scjj6/k8cahjAQMBs6YX8Zm3gvJ4EzZF8lCWbAmBZsu5yzSg/9MEJVToTqKWZiHDvUM6hd4YBNoFItzPZlRyh8+XVEhYN9nllNJ+PvGSiR+rPaGkB68dHl+zIrm49ltPcWBhlyzp6YooUAudwVvEOc57+Maek0=
Received: from MN2PR12MB4549.namprd12.prod.outlook.com (2603:10b6:208:268::15)
 by MN2PR12MB3680.namprd12.prod.outlook.com (2603:10b6:208:169::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17; Fri, 12 Mar
 2021 08:52:18 +0000
Received: from MN2PR12MB4549.namprd12.prod.outlook.com
 ([fe80::c1a6:7b2b:9494:776a]) by MN2PR12MB4549.namprd12.prod.outlook.com
 ([fe80::c1a6:7b2b:9494:776a%3]) with mapi id 15.20.3912.030; Fri, 12 Mar 2021
 08:52:18 +0000
From: "Lazar, Lijo" <Lijo.Lazar@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Enable VCN/JPEG CG on aldebaran
Thread-Topic: [PATCH] drm/amdgpu: Enable VCN/JPEG CG on aldebaran
Thread-Index: AdcXHPOjp+bq3zcFQmKE9RkN+7Ov7Q==
Date: Fri, 12 Mar 2021 08:52:17 +0000
Message-ID: <MN2PR12MB4549EDCC892E2BA0C1F1F95D976F9@MN2PR12MB4549.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-03-12T08:52:15Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=b4b7ed06-e71f-4505-be86-e429272655cc;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
x-originating-ip: [49.207.202.46]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e96ca9f2-27eb-4492-3a51-08d8e534245a
x-ms-traffictypediagnostic: MN2PR12MB3680:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB3680FF8CC52C561A720B1D61976F9@MN2PR12MB3680.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1227;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: A40JevWFEHGmuHpJzDKXoj5tLNtWOa88X3GLU0r/rafunrkJSTUitLExofCAMt0eJMsebhZsgS9hZTITgVg1ewwuno6s1ntfO8ZQQGy9kHmFlLUk4Jk0hCFo2Lg8Am0FgsnRmKmwFGmV5EaiprV4FU13WnUqi2YMmgCwz7/hQS5Yf4NwVaZbIKCd1w2AYbAHTat6uJhY0xI8dgrPW+kv93HyAz/bfdU/cgYgxlbLo4wlnDhGWncP2KDv7XROTVQN9ZMsNAG2XdHBDZHM+FhAV36pDQMtsQV+trplf1n40BTAsbozKkumUmEFP1VolIZsiVaBgNE4t92fLTx+rJ8DnSDN22R1Rg3C5SSZnGxa1dd8XBlTn4Eu+5Z+VWvTh7QxvV/BNCQW8KfNYIv2TveEVhBtO4K1r/++bwvtQtWDdd9rcl437b9Uc8j3Ig8oa9Cx4sI3L2Ar17ebPeND0PyfJH7C5DNM93oDooZ68K+79DDK/AJi5vQc2X+xHGA8wXF7q1akyj+F+genb0f9D3IHyg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4549.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(366004)(39860400002)(396003)(136003)(346002)(6916009)(2906002)(33656002)(478600001)(76116006)(4326008)(64756008)(26005)(186003)(66946007)(66476007)(66446008)(52536014)(66556008)(86362001)(5660300002)(8936002)(4744005)(55236004)(55016002)(9686003)(8676002)(83380400001)(71200400001)(316002)(6506007)(54906003)(7696005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?LMY9QACJ4X/IrnZ1yyNAHDZ9R99nKBgHWdn0mzbsyKHQGtj/iYe8VAex5srq?=
 =?us-ascii?Q?rYB4cIvWSBYbKbDzKUNQYDIcWalQKCxV2ZWnUuwdyWtNCcd2f7TP29MAoG9G?=
 =?us-ascii?Q?3ITte625cYOwUpWqhnFEqvAqY8Ev1wu/nkDzyYXIHVKd/VYZGmXwOeZxmJCK?=
 =?us-ascii?Q?ibLenkE6aJsYrj1Gvq9cELImfNy3OhYBlJEPm9snGLmZXJwbTn0zP7OeZD0D?=
 =?us-ascii?Q?gvmHuo5WgXTIDA0n0/HKLSi+RTnHqeTmamxdLxzA8LmFCiZ1028Do7rIykYL?=
 =?us-ascii?Q?St90oiYWkQxhmPFFMr6rpI6kuLpPm1FYr6BsyV63ZjP/yIcGW9XVW2ZkOzyr?=
 =?us-ascii?Q?4/PFLP/63FwP7+B8lMWARn0udoXDPa4hHgyK/svBNwYUoHICycVve/3oYwJG?=
 =?us-ascii?Q?bqDtjzgkoY1ItWW7AXpBbrbVCrXMOgJYVc6WWTp10En+LBGG2XaiBTY6Rkzy?=
 =?us-ascii?Q?1EW3AzVOEiMZYKYFd9ftvdx+15ON7FhnqemvI74f7jIm6JfPQcadrJFs/h6z?=
 =?us-ascii?Q?0ZdLrZOpd/wqn5NIxNfEoNAciGdMBULiGjXXMgDz9w3VGJPHTAAib7pV7OQH?=
 =?us-ascii?Q?HMkSZm9J9P3j9RTv8hAJdGJZSZ+7pLAlFSPOyNI6vlCHmT9TO1awYwKKfNrP?=
 =?us-ascii?Q?OukZh4swvYZx821omfoiH3R7X6kzd0BiqbadH8EkTuC9sA470yG9exxWjmIg?=
 =?us-ascii?Q?44jbwiLkV902ClWbeMa2OhNkU1IcoQKyrIDbyh4UGSi0dF3OWv1IQPW0xsR0?=
 =?us-ascii?Q?ogzTX9qpOWo11Gak0TKMiebEprkACfr487ubTBoolO2CykH4VTL5V0gGJjWi?=
 =?us-ascii?Q?LZVXVV2ayni48i+p+Bw5jUeVAFrKvyXVmflh5GObHepKGoh/SRbBPkfL42Gp?=
 =?us-ascii?Q?Bz62GqNjvxQbgnUZCOBNMsn4VzJMLPZRJOCsTrZI71aKO3o9/EluKesJOVED?=
 =?us-ascii?Q?7E4NUKYAJX0P0xzAoJ1cduMFunAsDgSx0atUbOX1FUXwnCxPyd6owkE3ogGL?=
 =?us-ascii?Q?QUFcRT85HhctBCojotej3SM+j6V8ZtveRKWXh75bq3kak2x/okUWbW3NYHfY?=
 =?us-ascii?Q?zKJmAN4vrBNBK/T+CwwRB9kdHkVIDAH/y6p/cQmqfKOKPy1Zdf5+T9CcvAaw?=
 =?us-ascii?Q?fidzbLsQ440QkNitqJEog6CKjSFJnIacgEuvqS7jwfcEqGyQgRbwVa+FiNq7?=
 =?us-ascii?Q?ni90NMPf6VlZHlJDzj9s7OBToKoW0+uSLVDkAiVxHEFlXAvND6WaxjHuZqcC?=
 =?us-ascii?Q?dL45MSUjcWHBmtDhphCAP1P5SGoBtWeoTcf7uctPWFiApf75N6gV/WW6JYaG?=
 =?us-ascii?Q?MQrJ41ZZQYW6naM28Za0qHal?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e96ca9f2-27eb-4492-3a51-08d8e534245a
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2021 08:52:18.2613 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uib93L0pqBtPd8AbRJobtNCFt4iu/z9PU4EPeue0ewQiLKhXtznwRWQMsHthaYu6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3680
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
Cc: "Xu, Feifei" <Feifei.Xu@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>
Content-Type: multipart/mixed; boundary="===============0220952840=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0220952840==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB4549EDCC892E2BA0C1F1F95D976F9MN2PR12MB4549namp_"

--_000_MN2PR12MB4549EDCC892E2BA0C1F1F95D976F9MN2PR12MB4549namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Public Use]

Enable clockgating for VCN and JPEG blocks on aldebaran

Signed-off-by: Lijo Lazar lijo.lazar@amd.com<mailto:lijo.lazar@amd.com>
Reviewed-by: Hawking Zhang Hawking.Zhang@amd.com<mailto:Hawking.Zhang@amd.c=
om>
---
drivers/gpu/drm/amd/amdgpu/soc15.c | 4 ++--
1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgp=
u/soc15.c
index 3808402cd964..a08000a3bdb9 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -1495,8 +1495,8 @@ static int soc15_common_early_init(void *handle)
                        AMD_CG_SUPPORT_HDP_LS |
                        AMD_CG_SUPPORT_SDMA_MGCG |
                        AMD_CG_SUPPORT_SDMA_LS |
-                       AMD_CG_SUPPORT_IH_CG;
-                       /*AMD_CG_SUPPORT_VCN_MGCG |AMD_CG_SUPPORT_JPEG_MGCG=
;*/
+                       AMD_CG_SUPPORT_IH_CG |
+                       AMD_CG_SUPPORT_VCN_MGCG | AMD_CG_SUPPORT_JPEG_MGCG;
                adev->pg_flags =3D AMD_PG_SUPPORT_VCN_DPG;
                adev->external_rev_id =3D adev->rev_id + 0x3c;
                break;
--
2.17.1

--_000_MN2PR12MB4549EDCC892E2BA0C1F1F95D976F9MN2PR12MB4549namp_
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
<p class=3D"MsoNormal">Enable clockgating for VCN and JPEG blocks on aldeba=
ran<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Signed-off-by: Lijo Lazar <a href=3D"mailto:lijo.laz=
ar@amd.com">
lijo.lazar@amd.com</a><o:p></o:p></p>
<p class=3D"MsoNormal">Reviewed-by: Hawking Zhang <a href=3D"mailto:Hawking=
.Zhang@amd.com">
Hawking.Zhang@amd.com</a><o:p></o:p></p>
<p class=3D"MsoNormal">---<o:p></o:p></p>
<p class=3D"MsoNormal">drivers/gpu/drm/amd/amdgpu/soc15.c | 4 ++--<o:p></o:=
p></p>
<p class=3D"MsoNormal">1 file changed, 2 insertions(+), 2 deletions(-)<o:p>=
</o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/dr=
ivers/gpu/drm/amd/amdgpu/soc15.c<o:p></o:p></p>
<p class=3D"MsoNormal">index 3808402cd964..a08000a3bdb9 100644<o:p></o:p></=
p>
<p class=3D"MsoNormal">--- a/drivers/gpu/drm/amd/amdgpu/soc15.c<o:p></o:p><=
/p>
<p class=3D"MsoNormal">+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c<o:p></o:p><=
/p>
<p class=3D"MsoNormal">@@ -1495,8 +1495,8 @@ static int soc15_common_early_=
init(void *handle)<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; AMD_CG_SUPPORT_HDP_LS |<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; AMD_CG_SUPPORT_SDMA_MGCG |<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; AMD_CG_SUPPORT_SDMA_LS |<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; AMD_CG_SUPPORT_IH_CG;<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /*AMD_CG_SUPPORT_VCN_MGCG |AMD_CG_SUPPORT_JPEG_MGCG;*/<o:p></o:p></p=
>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; AMD_CG_SUPPORT_IH_CG |<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; AMD_CG_SUPPORT_VCN_MGCG | AMD_CG_SUPPORT_JPEG_MGCG;<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;pg_flags =3D AMD_PG_SUPPORT=
_VCN_DPG;<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;external_rev_id =3D adev-&g=
t;rev_id + 0x3c;<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<o:p></o:p></p>
<p class=3D"MsoNormal">--<o:p></o:p></p>
<p class=3D"MsoNormal">2.17.1<o:p></o:p></p>
</div>
</body>
</html>

--_000_MN2PR12MB4549EDCC892E2BA0C1F1F95D976F9MN2PR12MB4549namp_--

--===============0220952840==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0220952840==--
