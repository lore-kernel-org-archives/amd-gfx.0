Return-Path: <SRS0=0Udm=MU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38096C4338F
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Jul 2021 09:44:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE84860F9C
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Jul 2021 09:44:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org EE84860F9C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 909D76E536;
	Wed, 28 Jul 2021 09:44:26 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2061.outbound.protection.outlook.com [40.107.92.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 669216E204
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Jul 2021 09:44:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dLLPDhIEyen1ZunXgpD1XCZxPy4Tio5AnWV+lYqMZ8to2d78UgIKKceyIxFa0I17VjAEfyNDndGLbKCShpNETvsfxM+TlHgo4MAqjWu1u2reeNDCkW95PTK+aqU3MgePlNcXzLH48zUArapjJ9tnXKhUQPY3fLShy1hwNL2dqRpP2opw8WbagZ3Tj3wIlkxlBXh/wqHF/WIEJUS4sJfDi95pl4SHm5lr5qXvI2ur463GzSUJvyQLBI+66+GA+R0NvjjEzk8VbMjh836Hkz8dYJcIwJdtxQ/wV/8tQx89M7ue3lGTKwK0yDJlMZYOfnQexWcfZInt6/gatTEHJ6+kdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U6Z7gU4eap8EH0219HIh1FDLg/QhSPXC8eMQLf45zpE=;
 b=Wb/ZiNePHw4CCYAStZpTqCpo6THRjQVkGh7OZ+zjCLxoeSKNrghmZQjIYI9G0CyA5Ip7L3vrygVTEZRgDJTPCtbtoVkFrJOrsj2uh5T79eBk91OLc8FsxnMVZ24ojf1fHcJr6jvuO1MKUX4FrQz+6cbXzbWD+WglOed1umxZK9sAkbQIqPHuEAfsg5ZjaTB6YYyqIWJi+ucRNTeFmjI/M+yC+VeJY+laC3J3O7VEL5rXX3lTOtLOgkKF+S890LsaA4m/EVWP6bi6CUQc2ytIY7kU0PGZEKUMkB4XPeCmUuGVCoH2JSLSxygLqQ50nhucnJogOHtbgYFap5eSpSUHGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U6Z7gU4eap8EH0219HIh1FDLg/QhSPXC8eMQLf45zpE=;
 b=dtJD8UwK7COwisEIIKLiIfbrQkCqH+4FA1qCq1NpsTHLbHCFELPEqkJyI7mRNjtSGO4HD8ao8hL0dlEndztZLA2XKXK90PaS5SNlI/B02WbMNGoYPqN8yWWGIeL0sNw4nbkVWyZLTX0pVNSe92YIIVTz1gjY1c3z76dUaY1HIKU=
Received: from DM6PR12MB4650.namprd12.prod.outlook.com (2603:10b6:5:1fd::27)
 by DM5PR12MB2549.namprd12.prod.outlook.com (2603:10b6:4:bb::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.29; Wed, 28 Jul
 2021 09:44:23 +0000
Received: from DM6PR12MB4650.namprd12.prod.outlook.com
 ([fe80::b0d9:236b:a2a0:49d8]) by DM6PR12MB4650.namprd12.prod.outlook.com
 ([fe80::b0d9:236b:a2a0:49d8%7]) with mapi id 15.20.4352.031; Wed, 28 Jul 2021
 09:44:23 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Huang, Ray" <Ray.Huang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu: enable psp front door loading by default for
 cyan_skillfish2
Thread-Topic: [PATCH] drm/amdgpu: enable psp front door loading by default for
 cyan_skillfish2
Thread-Index: AQHXg4+PGt4BFMitQkW51DuAbkjZQqtYIx+A
Date: Wed, 28 Jul 2021 09:44:23 +0000
Message-ID: <DM6PR12MB46507D303471778931B0F3E2B0EA9@DM6PR12MB4650.namprd12.prod.outlook.com>
References: <20210728090402.638158-1-ray.huang@amd.com>
In-Reply-To: <20210728090402.638158-1-ray.huang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=True;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-07-28T09:44:36.826Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD
 Official Use
 Only; MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b0eda5e2-9fa3-4bcf-9c56-08d951ac4811
x-ms-traffictypediagnostic: DM5PR12MB2549:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB2549B53881191F8E6F1715E0B0EA9@DM5PR12MB2549.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:751;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oE2SAPhbCC10k5rA035DWxLr8lSr3qigIhzeVuybx+4QblzkX67Df8/nRx99OZZaZBQ/PryvSP/VmhStctupOcw8ZOt+LvTdZu4V1Du5CeMM4YmbWq6oh2+SMk0gI+A8JoP9zHZvhl+GMjAxUu1JI5PviQ0bJSowELe9877U+3N96ZbiBbu25rkME27w48+yFCKWgSS6BrF8bJB1GO1bE79TuJsyRebuN4qUMZMSiwHxsIIfxWhKweK1hnNcVFTn0ylbat+LYXwcJlunHa7Z3WFxcF1Calan7C0WHKgYTnPgZ8cG/mxsmtsfaGVVLqsKil1Q87/KGUSNOcAjyXArTuEQqn+rcfxwBO+Rw6P88nNe3r6JLbHbnexGJdl5NxEvJAy3Uvm/57yVK7/rYZI71nc+Jpt/dXA7zIwJet/Ipj6Xf3h45xLm9YUAnEEA8XHNKbfPam4/foDL/R7OufYV95/zIP5kYoge/SZhHvoC+5NLKdS4DF3JzzWVggVAkGYPebRXWdGlDEglWDD9MQjrN1siklUGgEAmJApZPxniFQUBqmntFk/XmNQcodcy0xDtjjZTahrBFaojVKbL6ED2x5ypO/zC24OF7LgHutR1coQz/9h/Vl4B1Yb0KuG2bU6bAMHgFm7OuuBCveMejvI0z6oX9d8Lps5sVNc+tOFrRyIKN/qOxoB28h4LkaiAIuSmyIHtrn/VDZp0rwD+ClZz8g==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4650.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(39860400002)(396003)(376002)(136003)(346002)(66556008)(8676002)(316002)(33656002)(83380400001)(122000001)(7696005)(186003)(110136005)(2906002)(38100700002)(86362001)(478600001)(4326008)(53546011)(6506007)(19627405001)(52536014)(71200400001)(66946007)(8936002)(54906003)(26005)(55016002)(64756008)(66476007)(9686003)(66446008)(76116006)(5660300002)(91956017)(38070700005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?mdk7Suagu4JOIZp+AKzXGc0sJ9rWrMgmJZ639+/mNF9t1dDZSP7XiE2R7I6n?=
 =?us-ascii?Q?HkYb4RnnS/sE82V+4y4NnAI0mBD1I+EteK/9TlAmQxvGa5S03rznb6v1U3RV?=
 =?us-ascii?Q?boDldvFVh+kA/rVbtK0FYGq82E3oyJVdg8fKs9QChfsZvP/jfeZC8rsBcVMH?=
 =?us-ascii?Q?BtphooZZsglyNeZuRo8jg+qDnl2Wao+4vEsvm77D7FUnVso8OIs09AcWHj8B?=
 =?us-ascii?Q?rgT5QfIyFC0823nFVdvPlc3sRKSXAIUgpwBWbBMR5cBsSGZO6vPuG0xTuR3/?=
 =?us-ascii?Q?4fmix1EMVV/24quK35/9/YlUltEdjwnvn2NEmMtXwG+FdKSj/Ca3cSOpWPcE?=
 =?us-ascii?Q?rjZXo6+kgaW8NDh17oXhky1yxfdVnx4y/qD7Mvfo9E7G3OuFy0rKAxt1wHKc?=
 =?us-ascii?Q?tYDmwsi1drxpYngyrZXA7MHXOWP7qns3dJT40KsHSUMCPGmSNhXOPaeeAqfe?=
 =?us-ascii?Q?DBB9zzq2jws3oaQinHat9WbxiQ79D4htRqSV5QylDwwZ4aQsm1uMqjs7Wpcz?=
 =?us-ascii?Q?vw4FNQeojNkZTHx/7OBVHlrpKtWTZzc24pNHc3NmxmY314LW2i7R0q0BB3Ei?=
 =?us-ascii?Q?UyAZ3ouju7ZIydowCe9u5T669RAmg5HdqeNZ9ExjwBhOTd5u2rVLa+NTKWF9?=
 =?us-ascii?Q?V2N95R2ESIV9avbGhOiNIYAqrhsfOECgCGtfiKpObWrhkJSOV3C3TC8EHHj4?=
 =?us-ascii?Q?7TvBgQ9kJmMCEJuL6ehPmR4i4C9Xx5+ntk6I3KKNxrLHuvvN1MQVBCfT6oKH?=
 =?us-ascii?Q?aFzgwFg48APXPQk74AKjvENMn42lu3sGQk7h8cCvoVYILR5tcCMx2JKGxp4m?=
 =?us-ascii?Q?kG+J/mzj1KqcAA0S2umXvcfFiuKyUNmu2ttdRFV484CxvpBTjueS1SHB412k?=
 =?us-ascii?Q?Y+6x5d6XpDDYfh+1aa60JWEKeL0hs0Q0lui18KjD3chkiK8wgU6p++u57GCO?=
 =?us-ascii?Q?0BZM4rJSp6ieY+46C076mQs7dD2gT2lVgYTxOkM4s3VLPpNATDraCmmlF4U0?=
 =?us-ascii?Q?p9yZLgIZdNaZdVZOdnPax/nfRsmqYQcjGX1SVjdKRYvqPCW487N8kZsMppgC?=
 =?us-ascii?Q?8CySChOCD4Ycse1Njb/+/G2KFuZshBlE66Qi2CnG9xfSCrz/SZCDb+KIpj2a?=
 =?us-ascii?Q?5X8dUMKajs22gLheAoz8KmqtGKsEg8l+VAb33FYPvTkEm+7bOiNDOxRUa5Ys?=
 =?us-ascii?Q?zWnC/7E5mbKB64xaGh7fczSyr6w7xQe1yW13mw/VU2mgb+XbeB1gF3OIwhJg?=
 =?us-ascii?Q?UsEFYRrmP38DQrKQ0TPwpHP30zLJdr2iJ5RScLfbxfxe7U+/GgGwG76HtdEs?=
 =?us-ascii?Q?qgmQwamnJqsJwUCxK/h8Vzis?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4650.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0eda5e2-9fa3-4bcf-9c56-08d951ac4811
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2021 09:44:23.3904 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lsZLDkajQfT+4FUE+K7weldcigd+tsmMq1/aUjvASmJbTH3uBBTxYLS0f4baNATv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2549
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Gong,
 Curry" <Curry.Gong@amd.com>, "Yu, Lang" <Lang.Yu@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Content-Type: multipart/mixed; boundary="===============0194979668=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0194979668==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_DM6PR12MB46507D303471778931B0F3E2B0EA9DM6PR12MB4650namp_"

--_000_DM6PR12MB46507D303471778931B0F3E2B0EA9DM6PR12MB4650namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only]

Reviewed-by: Tao Zhou <tao.zhou1@amd.com<mailto:tao.zhou1@amd.com>>
________________________________
From: Huang, Ray <Ray.Huang@amd.com>
Sent: Wednesday, July 28, 2021 5:04 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Hawking <Hawking=
.Zhang@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>; Yu, Lang <Lang.Yu@amd.com>=
; Gong, Curry <Curry.Gong@amd.com>; Huang, Ray <Ray.Huang@amd.com>
Subject: [PATCH] drm/amdgpu: enable psp front door loading by default for c=
yan_skillfish2

The function is ready on psp firmware, and enable it by default.

Signed-off-by: Huang Rui <ray.huang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_ucode.c
index e001875ea1b7..5fdeceaa979f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
@@ -410,10 +410,11 @@ amdgpu_ucode_get_load_type(struct amdgpu_device *adev=
, int load_type)
                 else
                         return AMDGPU_FW_LOAD_PSP;
         case CHIP_CYAN_SKILLFISH:
-               if (adev->apu_flags & AMD_APU_IS_CYAN_SKILLFISH2 &&
-                   load_type > 1)
+               if (!(load_type &&
+                     adev->apu_flags & AMD_APU_IS_CYAN_SKILLFISH2))
+                       return AMDGPU_FW_LOAD_DIRECT;
+               else
                         return AMDGPU_FW_LOAD_PSP;
-               return AMDGPU_FW_LOAD_DIRECT;
         default:
                 DRM_ERROR("Unknown firmware load type\n");
         }
--
2.25.1


--_000_DM6PR12MB46507D303471778931B0F3E2B0EA9DM6PR12MB4650namp_
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
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;" ali=
gn=3D"Left">
[AMD Official Use Only]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<span style=3D"margin:0px;font-family:Calibri, sans-serif;background-color:=
white">Reviewed-by: Tao Zhou &lt;</span><a href=3D"mailto:tao.zhou1@amd.com=
" target=3D"_blank" rel=3D"noopener noreferrer" data-auth=3D"NotApplicable"=
 data-linkindex=3D"0" style=3D"margin:0px;font-family:Calibri, sans-serif;b=
ackground-color:white">tao.zhou1@amd.com</a><span style=3D"margin:0px;font-=
family:Calibri, sans-serif;background-color:white">&gt;</span><br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Huang, Ray &lt;Ray.Hu=
ang@amd.com&gt;<br>
<b>Sent:</b> Wednesday, July 28, 2021 5:04 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Zhang, Haw=
king &lt;Hawking.Zhang@amd.com&gt;; Zhou1, Tao &lt;Tao.Zhou1@amd.com&gt;; Y=
u, Lang &lt;Lang.Yu@amd.com&gt;; Gong, Curry &lt;Curry.Gong@amd.com&gt;; Hu=
ang, Ray &lt;Ray.Huang@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: enable psp front door loading by defaul=
t for cyan_skillfish2</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">The function is ready on psp firmware, and enable =
it by default.<br>
<br>
Signed-off-by: Huang Rui &lt;ray.huang@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c | 7 ++++---<br>
&nbsp;1 file changed, 4 insertions(+), 3 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_ucode.c<br>
index e001875ea1b7..5fdeceaa979f 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c<br>
@@ -410,10 +410,11 @@ amdgpu_ucode_get_load_type(struct amdgpu_device *adev=
, int load_type)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; else<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retur=
n AMDGPU_FW_LOAD_PSP;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_CYAN_SKILLFISH:<=
br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (adev-&gt;apu_flags &amp; AMD_APU_IS_CYAN_SKILLFISH2 &amp;&am=
p;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; load_type &gt; 1)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (!(load_type &amp;&amp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;apu_flags &amp; AMD=
_APU_IS_CYAN_SKILLFISH2))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return AMDGPU_FW=
_LOAD_DIRECT;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; else<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retur=
n AMDGPU_FW_LOAD_PSP;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return AMDGPU_FW_LOAD_DIRECT;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; DRM_ERROR(&quot;Unknown firmware load type\n&quot;);<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-- <br>
2.25.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_DM6PR12MB46507D303471778931B0F3E2B0EA9DM6PR12MB4650namp_--

--===============0194979668==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0194979668==--
