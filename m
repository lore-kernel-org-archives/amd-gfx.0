Return-Path: <SRS0=J6fF=IW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE9FAC433DB
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Mar 2021 05:19:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C6BE619E9
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Mar 2021 05:19:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C6BE619E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DDA1D6E97B;
	Wed, 24 Mar 2021 05:19:32 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2085.outbound.protection.outlook.com [40.107.102.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4EF836E97B
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Mar 2021 05:19:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IocD1P7wgccHTDWD7Nzdq/wisbcdOy4d0Zs/pvQSCszeygiGOX2fxc7n7oVD9QZAbYc/Grd8UXqkN7DluoYYnVQWNCgh7PefX4ChVBLu7mJdK2msgBuQNHLv+lBy6Fns2ZFt0QOFKSrK3qFYHE1XcisNlZVw8zV2D5mPy42mhoNIK/0a9oE8NKSevlh5eddXYOayNrlC6s0i1pQxyjiXgRiw5A1QjrCYxkulbCHodsx10zkz+9x2TnVhgQ5FYHh+OW0n66Ut5w6GxNSvajjHp29NNpa3+HeS7h2imt9yOVOyg2xT2E2yxZAWqGU0+kPVewbQR52aw7cUtvdhVNTvRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e5kN4fwtIO109nRjiKEa2n1ieXN/XNkIixAcC/eDoxk=;
 b=gkdIrlRTw0E255nxvKL8+T29cBG58RjT2TA57MCI8CWHpPkZEXmJK00X7hrSes9rq70N2trnsA5+gpJ5BqA3rGXuHKUYNzu6egqB+0lIInHrUsPcxJfkVq8JBA2y5Ewc23rY8dtyTRNXl6Ks6sOlHdX7XULmm2Cafr0iROIXEiaGg+9uKfPfbBZMbA3P3gY1jcWjVO6ixT7xW8/DjTqIgcR015VuJElhd5olJ0fNSOg/iAxd3jgbqDjF0lpN/p1u7/+d8ci375Z/exIe/tcoCRmh1585Jzgx71dt3EUKvC5UpCRAuP3ZE6GMcKtNL1ZmHTrV9anglD5V9iEWNm1aRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e5kN4fwtIO109nRjiKEa2n1ieXN/XNkIixAcC/eDoxk=;
 b=f4OnI7VgyEwIxtJAIRTV2GNa12erugu/NY/4y1NBSPGmxWNdw0VcJTC75C9cOGeOPBr51f6c8YKwtn+GJXfR4QZjv/EKzFZMM7bbC3a/+CVWg8YzMIsqwJrJFIUaO/Iiuf5KH6IMS8rEcmnNvvARdbNBfvKcpAQTqYvOrGfSeRM=
Received: from MN2PR12MB4549.namprd12.prod.outlook.com (2603:10b6:208:268::15)
 by BL0PR12MB4913.namprd12.prod.outlook.com (2603:10b6:208:1c7::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.24; Wed, 24 Mar
 2021 05:19:29 +0000
Received: from MN2PR12MB4549.namprd12.prod.outlook.com
 ([fe80::58d5:c2:7a3c:4408]) by MN2PR12MB4549.namprd12.prod.outlook.com
 ([fe80::58d5:c2:7a3c:4408%5]) with mapi id 15.20.3955.027; Wed, 24 Mar 2021
 05:19:29 +0000
From: "Lazar, Lijo" <Lijo.Lazar@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Fix build warnings
Thread-Topic: [PATCH] drm/amdgpu: Fix build warnings
Thread-Index: AdcgbTOCq7rjbWWtTU+bZ+wP3L3uLg==
Date: Wed, 24 Mar 2021 05:19:28 +0000
Message-ID: <MN2PR12MB4549EEA4886523AC36E8073297639@MN2PR12MB4549.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-03-24T05:19:26Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=c574316b-38c5-450a-b186-6e72153c6b1a;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
x-originating-ip: [49.207.210.201]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 565f6a33-eee5-4216-1a0c-08d8ee846646
x-ms-traffictypediagnostic: BL0PR12MB4913:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL0PR12MB49131901CA34F5375043731D97639@BL0PR12MB4913.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:107;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ua8CcGGmkg3pxsAFhFC5twD7nNEFu8krtX3d3Q4xTr2jSIiSSH6k59RF9Kfmou0sXfBcO3wnUie+a9KorFWlhsaFjJpiylMi/ju/Z9qxPhJACf6Lh9R2X6DL+5QTx5pQXiyWOpqDRTAVz/6GQ4XNbwOAWcPUeJ8fAK6NbBDA3H7s29FbCuYVBihpF92CbvEXeF2aCxr2/sp2OHbKrwp0XNSlnYaCxnZcIGjXlUz6zqjLxJ5uYp9K/psU6M7udffsavJIBBTzdEeh8pZR3Mhw6B2c0qZ7WSazIIq1aLanAIHgvIkR5AZWnL1gMGIZmorzd57TCeolda6xk6Wu3rpbZ29fxExIH8b6o03wJhjwoBY2l3BCJ/6jpnLf9dYcBLg1FB7SQ/wpMuANy0CIsagRj2wT8DfqFiI3/QCt83oTY/Zqa+gwss/CFZ4X5psxuu8mOXElxhm44308zZPTC/RtQ/9oW9DUK91DWgqcB27muNnU1DbGQ0rpbSr9v3cAQFsCAHlbTcA/iSB621onUxPyAlmyYNqDLHzUrtLhJgsmzhMx+MP/ss5q1nElSOmLgH86L0vK1ciEQZ+A6VJuJJoHpDWxl48JsepKibbhp6c3N1jNikgVJM67FWa0xpO0uZgkrg61r050cZygh92sIup9TMBhklizwj6ay4b/BXqx6TA=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4549.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(376002)(136003)(396003)(346002)(366004)(9686003)(2906002)(66556008)(66446008)(5660300002)(76116006)(66946007)(71200400001)(66476007)(64756008)(55016002)(6916009)(83380400001)(186003)(52536014)(38100700001)(8676002)(316002)(55236004)(54906003)(7696005)(6506007)(478600001)(26005)(33656002)(8936002)(86362001)(4326008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?x+tRiBvZb4C3Jbc9BjTUdmv6iSBrtxTG7EepG4fRUg9CvgHt1AzZqymOHA6T?=
 =?us-ascii?Q?BVp0jkhyJgm6naf3UEzdRzmgqMmH8og/gbTZPLSRMl0rinTgxUJpQ8SsSQlY?=
 =?us-ascii?Q?b/ItdlRwIvvjBfku5271HKq9ZOMWPCo7pOormt7TZ7KQCQJl4XzG9AV7nvM6?=
 =?us-ascii?Q?twCKCr5QJ4+txgD15qANPPE+ZYuYFf0Pgt0DPDv61iuuSpY7cDu8uzb9a9kU?=
 =?us-ascii?Q?BsltrqewF4cOPzU51CA6R3gngSQJd1hzeD+uAEmSHH34iNj+dDJDrIJkhKDH?=
 =?us-ascii?Q?M6aDpCRvCHSeXSd846JaczP+0J+OZfl4PxIVa3jjF6zgOXyzpbrFhJM8b/OW?=
 =?us-ascii?Q?IHd72F5oCAf9aIqz+mJ++f5/1AytJ8N33BLuNHxar3dCeE1Sc4vVwN08D80c?=
 =?us-ascii?Q?TKiD68rYny/HE53cl48YIble7aslSc/POSZrqKqOPFLePzp6FNC/hRZdxtyX?=
 =?us-ascii?Q?nY2m2ciSQMTWasfAbIoKg3Mb9esHn9VV9/t9hNfJbF4Wyb5ZHrgXp1sUbXgq?=
 =?us-ascii?Q?mlpBKe4o53FfljhkF54mmAjdVP6mqX9SmUBvTXuTKy+IaqDB0GDZwLAVKLjq?=
 =?us-ascii?Q?wL532eLTqGd/djFc+AC1681vLHAZGioj+GASnpYnq8PmrRUuIcS2fvikjfCE?=
 =?us-ascii?Q?rFxzQInPbTuvnObIoMgs3Z8ehEat2ctFvDfViwwhtRt0AtpU84XiUhNyb+Fg?=
 =?us-ascii?Q?nvw6z0vIfrOaByX36K34g57Oa3uszYWZbluIMKoEzJpAi21Shc+mAXSON5Ux?=
 =?us-ascii?Q?fj9V4p0/YIws7x5P4nYGKLbrjYbvUqTQJMKpr3kyB2RhdX60K5DkBn+KOMBv?=
 =?us-ascii?Q?QUrb+cnYWioyaPrq7Ad4Bzdo0SLi2XB6VSUAj1lCeOgYg9LbqIbEl7UFp/xB?=
 =?us-ascii?Q?MSKcVh/a7F/mbQZ7yb6RD6Jl8YgNH4hsglvRLJxDQP1IHheUW3weyBYA3FM8?=
 =?us-ascii?Q?9IPahLYXtXxzsGZQGUBxptkkMFtnl9JtVD10/PFREZP3mAZqSggbHAUcDSW2?=
 =?us-ascii?Q?qrhje6Y5VdhlumlJjai70fUNqt6xpfK9MF5LvoMDaAhk5T245AZQ6QlnlDCx?=
 =?us-ascii?Q?05XE+/7Lk17c6HWYCght3QK/ZLbqFkAAz/XUgk55FnETWRhCdW0armdVEd7Q?=
 =?us-ascii?Q?93BaC6Jp5QjJ/oLUB482QTsMUwnS95PgB/To94R0cGv/Gy1hz7vc5qMMqvpD?=
 =?us-ascii?Q?v80IQ197kCP+MMCl4o2bDtOFqNtJWTlrItSSAfKdMJRJ45rU4pN1sU58Qite?=
 =?us-ascii?Q?nK7zqTw5+Rr9/6oFNM7zVlV3LaodEB2sbmVCtyMmYN3B5v3uxgtrerpU/VqV?=
 =?us-ascii?Q?VWg+5aW9Nll+/4CKOL6JyPrA?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 565f6a33-eee5-4216-1a0c-08d8ee846646
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2021 05:19:29.0246 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uR9kMjrRIyqZE7/aafac51b61/sapCoYXi9ztCfZO45YYi4NLXp7m2/EoO7EC/iA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4913
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
Content-Type: multipart/mixed; boundary="===============0340067186=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0340067186==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB4549EEA4886523AC36E8073297639MN2PR12MB4549namp_"

--_000_MN2PR12MB4549EEA4886523AC36E8073297639MN2PR12MB4549namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Public Use]

Fix header guard and make internal functions static. Fixes the below warnin=
gs:

drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu_reset.h:24:9: warning: '__AMDUG=
PU_RESET_H__' is used as a header guard here, followed by #define of a diff=
erent macro [-Wheader-guard]
drivers/gpu/drm/amd/amdgpu/aldebaran.c:110:6: warning: no previous prototyp=
e for function 'aldebaran_async_reset' [-Wmissing-prototypes]
drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu13/aldebaran_ppt.c:1435:5: warnin=
g: no previous prototype for function 'aldebaran_mode2_reset' [-Wmissing-pr=
ototypes]

Signed-off-by: Lijo Lazar lijo.lazar@amd.com<mailto:lijo.lazar@amd.com>
Reported-by: kernel test robot lkp@intel.com<mailto:lkp@intel.com>
---
drivers/gpu/drm/amd/amdgpu/aldebaran.c             | 2 +-
drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h          | 2 +-
drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c | 2 +-
3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/aldebaran.c b/drivers/gpu/drm/amd/a=
mdgpu/aldebaran.c
index 39604a461bf5..65b1dca4b02e 100644
--- a/drivers/gpu/drm/amd/amdgpu/aldebaran.c
+++ b/drivers/gpu/drm/amd/amdgpu/aldebaran.c
@@ -107,7 +107,7 @@ aldebaran_mode2_prepare_hwcontext(struct amdgpu_reset_c=
ontrol *reset_ctl,
               return r;
}
-void aldebaran_async_reset(struct work_struct *work)
+static void aldebaran_async_reset(struct work_struct *work)
{
               struct amdgpu_reset_handler *handler;
               struct amdgpu_reset_control *reset_ctl =3D
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_reset.h
index dc84d871fe72..e00d38d9160a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
@@ -21,7 +21,7 @@
  *
  */
-#ifndef __AMDUGPU_RESET_H__
+#ifndef __AMDGPU_RESET_H__
#define __AMDGPU_RESET_H__
 #include "amdgpu.h"
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/g=
pu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
index 472829f5ff1b..ddbb9a23a0af 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
@@ -1433,7 +1433,7 @@ static ssize_t aldebaran_get_gpu_metrics(struct smu_c=
ontext *smu,
               return sizeof(struct gpu_metrics_v1_1);
}
-int aldebaran_mode2_reset(struct smu_context *smu)
+static int aldebaran_mode2_reset(struct smu_context *smu)
{
               u32 smu_version;
               int ret =3D 0, index;
--
2.17.1


--_000_MN2PR12MB4549EEA4886523AC36E8073297639MN2PR12MB4549namp_
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
<p class=3D"MsoNormal">Fix header guard and make internal functions static.=
 Fixes the below warnings:<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu_reset.h:=
24:9: warning: '__AMDUGPU_RESET_H__' is used as a header guard here, follow=
ed by #define of a different macro [-Wheader-guard]<o:p></o:p></p>
<p class=3D"MsoNormal">drivers/gpu/drm/amd/amdgpu/aldebaran.c:110:6: warnin=
g: no previous prototype for function 'aldebaran_async_reset' [-Wmissing-pr=
ototypes]<o:p></o:p></p>
<p class=3D"MsoNormal">drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu13/aldebar=
an_ppt.c:1435:5: warning: no previous prototype for function 'aldebaran_mod=
e2_reset' [-Wmissing-prototypes]<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Signed-off-by: Lijo Lazar <a href=3D"mailto:lijo.laz=
ar@amd.com">
lijo.lazar@amd.com</a><o:p></o:p></p>
<p class=3D"MsoNormal">Reported-by: kernel test robot <a href=3D"mailto:lkp=
@intel.com">
lkp@intel.com</a><o:p></o:p></p>
<p class=3D"MsoNormal">---<o:p></o:p></p>
<p class=3D"MsoNormal">drivers/gpu/drm/amd/amdgpu/aldebaran.c&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 2 +-<o:p></o:p=
></p>
<p class=3D"MsoNormal">drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 2 +-<o:p></o:p></p>
<p class=3D"MsoNormal">drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c |=
 2 +-<o:p></o:p></p>
<p class=3D"MsoNormal">3 files changed, 3 insertions(+), 3 deletions(-)<o:p=
></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">diff --git a/drivers/gpu/drm/amd/amdgpu/aldebaran.c =
b/drivers/gpu/drm/amd/amdgpu/aldebaran.c<o:p></o:p></p>
<p class=3D"MsoNormal">index 39604a461bf5..65b1dca4b02e 100644<o:p></o:p></=
p>
<p class=3D"MsoNormal">--- a/drivers/gpu/drm/amd/amdgpu/aldebaran.c<o:p></o=
:p></p>
<p class=3D"MsoNormal">+++ b/drivers/gpu/drm/amd/amdgpu/aldebaran.c<o:p></o=
:p></p>
<p class=3D"MsoNormal">@@ -107,7 +107,7 @@ aldebaran_mode2_prepare_hwcontex=
t(struct amdgpu_reset_control *reset_ctl,<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;<o:p></o:p></p>
<p class=3D"MsoNormal">}<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p></o:p></p>
<p class=3D"MsoNormal">-void aldebaran_async_reset(struct work_struct *work=
)<o:p></o:p></p>
<p class=3D"MsoNormal">+static void aldebaran_async_reset(struct work_struc=
t *work)<o:p></o:p></p>
<p class=3D"MsoNormal">{<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_reset_handler *handler;<o:p>=
</o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_reset_control *reset_ctl =3D=
<o:p></o:p></p>
<p class=3D"MsoNormal">diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset=
.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h<o:p></o:p></p>
<p class=3D"MsoNormal">index dc84d871fe72..e00d38d9160a 100644<o:p></o:p></=
p>
<p class=3D"MsoNormal">--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h<o:p>=
</o:p></p>
<p class=3D"MsoNormal">+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h<o:p>=
</o:p></p>
<p class=3D"MsoNormal">@@ -21,7 +21,7 @@<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp; *<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp; */<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p></o:p></p>
<p class=3D"MsoNormal">-#ifndef __AMDUGPU_RESET_H__<o:p></o:p></p>
<p class=3D"MsoNormal">+#ifndef __AMDGPU_RESET_H__<o:p></o:p></p>
<p class=3D"MsoNormal">#define __AMDGPU_RESET_H__<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;#include &quot;amdgpu.h&quot;<o:p></o:p></p>
<p class=3D"MsoNormal">diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/alde=
baran_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c<o:p></o:p>=
</p>
<p class=3D"MsoNormal">index 472829f5ff1b..ddbb9a23a0af 100644<o:p></o:p></=
p>
<p class=3D"MsoNormal">--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_p=
pt.c<o:p></o:p></p>
<p class=3D"MsoNormal">+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_p=
pt.c<o:p></o:p></p>
<p class=3D"MsoNormal">@@ -1433,7 +1433,7 @@ static ssize_t aldebaran_get_g=
pu_metrics(struct smu_context *smu,<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return sizeof(struct gpu_metrics_v1_1);<o:=
p></o:p></p>
<p class=3D"MsoNormal">}<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p></o:p></p>
<p class=3D"MsoNormal">-int aldebaran_mode2_reset(struct smu_context *smu)<=
o:p></o:p></p>
<p class=3D"MsoNormal">+static int aldebaran_mode2_reset(struct smu_context=
 *smu)<o:p></o:p></p>
<p class=3D"MsoNormal">{<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 smu_version;<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0, index;<o:p></o:p></p>
<p class=3D"MsoNormal">-- <o:p></o:p></p>
<p class=3D"MsoNormal">2.17.1<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
</body>
</html>

--_000_MN2PR12MB4549EEA4886523AC36E8073297639MN2PR12MB4549namp_--

--===============0340067186==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0340067186==--
