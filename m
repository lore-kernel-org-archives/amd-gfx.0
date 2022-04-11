Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CC0DC433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Apr 2022 13:10:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1CBB010E21E;
	Mon, 11 Apr 2022 13:10:22 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2088.outbound.protection.outlook.com [40.107.92.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E15D10E21E
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Apr 2022 13:10:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PmqUF/SM7vDBuzSv4Jh3IzQ5WeAJ9QtHeac3A/u0z/tmS2UgZIFqu/SYGMCnCdd2ySHbD4A+A1+JZnoXvbJghwhe/rvidX4NSrH+2s3TkxvFSlA7ROGSEtKEgAKSddePpDweoCDOBVPA1k5UKB5Qn35veWNrut0V5jCvkVo6kYyhde3X7l/16xjtuDwfD8z7jvC4SeaoP4G95+z3HzwQbeprlwVIKEPEoLPbOdfhEImJJfbk4r4wqXYS3AgckdoczFqhIAIrHDvmxh3WfR+g6pMfKSVq7B3TGQoEI6DAzLna4ik7Uie5d2bRkT5JfIKf67LxxRXulTQx6AEuh2qyzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=POKWgSd8mwqiL/Ya+BOloEoYbUVEZSPP5efP3IuVdfQ=;
 b=MsDa4FPvhE8dlY4zp7OA3YJUZrodyY21VSKJhwfUTVQVu1P/10itjYZb78gQGxAiv8RYnshZDz50uUDXGMHhNaJ3odJAZ+ctaOQWJ1HAjjwhXAqWViDuRp43pKR3petbXVrv6G0sul+7r/LpbWZyyjw2sGYPgsnZAr7M7C9sR+hj/nQxiouk2GqIaXcQrXEQWrDtPJj/ZhBIofARQSloiW/rktYMUzTf0eSI+RVdf+Vs1tMf/xgju9ZHx+fRIFlFSID+MJWAw/MeKKp6PMacdhLFSxU8yogxNBq2qhIDZ2RxtjAo10UvmcmQvfMtzj8+GtSFTXW4DIW8+jkhP6mEBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=POKWgSd8mwqiL/Ya+BOloEoYbUVEZSPP5efP3IuVdfQ=;
 b=k1Rji70J3bz1ProzYJC1J97GIqQs+9AmtJxGgLTP8pvN1DfGxEO8CLdMsrcSmT0DeDIVxXEMG4sP9CBOcbmLk4zVZC2Ay2st7ipanYHgTFshJd/xpmpCzeOZY3nfslUMQeEGbwN3uQiT9QCJzmbiDxwuIE6GYmKtmI7h38mP0ts=
Received: from CO6PR12MB5473.namprd12.prod.outlook.com (2603:10b6:303:13e::8)
 by BL0PR12MB5554.namprd12.prod.outlook.com (2603:10b6:208:1cd::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Mon, 11 Apr
 2022 13:10:18 +0000
Received: from CO6PR12MB5473.namprd12.prod.outlook.com
 ([fe80::28df:431f:d965:e6ef]) by CO6PR12MB5473.namprd12.prod.outlook.com
 ([fe80::28df:431f:d965:e6ef%6]) with mapi id 15.20.5144.029; Mon, 11 Apr 2022
 13:10:18 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "Ma, Jun" <Jun.Ma2@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu: Release memory when psp sw_init is failed
Thread-Topic: [PATCH] drm/amdgpu: Release memory when psp sw_init is failed
Thread-Index: AQHYTaGgF9v/b1CBSEK8AjqtDeL/DqzqrUaQ
Date: Mon, 11 Apr 2022 13:10:18 +0000
Message-ID: <CO6PR12MB547319DAE1601C366E2E607C82EA9@CO6PR12MB5473.namprd12.prod.outlook.com>
References: <20220411124206.1348117-1-Jun.Ma2@amd.com>
In-Reply-To: <20220411124206.1348117-1-Jun.Ma2@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=True;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-04-11T13:10:17.689Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD
 Official Use
 Only; MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 79c74f60-12ec-4a0c-baec-08da1bbca080
x-ms-traffictypediagnostic: BL0PR12MB5554:EE_
x-microsoft-antispam-prvs: <BL0PR12MB555471FADFFBB1C67D56A22782EA9@BL0PR12MB5554.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RuuOgaeIZPwF9+Ujr2Hc0EwcfMLoUEQigEnAFtyHhNP32+bp2aC0EjYm8WXcTrfCY9rgz6APODoF5hUXuip7qRPO6zKfPYJnEJnpSzxx7iTs/W6tInvP4cg4z2ycwnhd8FJK8IV7RCy+ddo6He0/KkC40oVSMAmPNfoQ3lp+9uheDx2JLyHrdsz8D+lBYs69QrAOHmzwEZa0NXK1WROm/WFKh8THIvuZZn69/JqQpwtK12rHIucLOr689BDS2ce6Jbh9fZSRfOOuNR8OeJeaDzP1QlTGbC+r1GZXph67eJtXYPI6szYwo8wV0l+I1iMLscmOw38iWXc03YiM9FlwZtcKaKKfyBa0zaeZg3cIzWoOdu5b7j8pX3EJSsOmd5lbGpR7ONKsUJRhH+z8j9In5hvpsbA6mjcTo7JUdcPqrjl2JhIY6SaxLy8DXPndPw08rjb8pJunSVZIGKB8zbEj8bVCmlqvf3cd6u76xoP/xtcWK9SvntkjbrRbiZKmLLJPFO+aGikrKLB1qrW9Wc/9fJwstFI/SWWYf07bDFeqba0ERhGnFJk0esDWocB86OUJtxz+jv3iogSuWwlACyITHoRF2UqMjO2YnDWpq75+/dNziwDi0nGIyeHz97nkUQyIzN0v34rZqf1qVG/ApAjNJh2/UtaXYdq2DLdfoo+7sFFjO888YW2QooSNOBc/9QXqtoMH5o4oajWLvl18iTqHlQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5473.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(33656002)(8936002)(83380400001)(38100700002)(38070700005)(5660300002)(26005)(19627405001)(186003)(508600001)(2906002)(55016003)(8676002)(91956017)(76116006)(4326008)(86362001)(64756008)(66946007)(316002)(54906003)(66556008)(66476007)(52536014)(66446008)(110136005)(6506007)(7696005)(9686003)(53546011)(71200400001)(122000001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?lWrlEyqIXD4jdqI8EYmW167Pl9beusQlkBKBVoQgErspAnZ79RFe+UOiR4?=
 =?iso-8859-1?Q?iXmZg+Irh6A2nidj5Lyp4MLk0kHoQ6Q+DOFQCjq+uReE9AADPKZ/4FPlVM?=
 =?iso-8859-1?Q?gbpzHzLfYsCwV4py25mLpUbr/U0r6mj/LJbJKpwnV9NGWa2xLgGDNrP+FL?=
 =?iso-8859-1?Q?hIxsoRwSekU8eXsGZa3XhHJKqwclmaT/RwmcTuypOWPJMHRQFfcfGdgi3y?=
 =?iso-8859-1?Q?81o5rA8pXTJ2Y0SOxd3jNMjRt69DZiOSww0PIceIuKQGbV/FTjY7Cgnmz5?=
 =?iso-8859-1?Q?WeppEtrmBNZx3PkEH3Ub5c68e/0QO6Ht7Z5nkandDfur3Etik4ttLBUrc9?=
 =?iso-8859-1?Q?sXWH8BwHj6JEhOG8bFVyzwHXhJQRAoN+pebIUNF/is4eTX28jNW0+bMp6L?=
 =?iso-8859-1?Q?heO+j7rWVinxgciLjJtj7MHp9ObpWM62wwe+pjG5QZ9PWtgUrJqVW4wjfo?=
 =?iso-8859-1?Q?qLiGpxV359WwB/9HmpJ5hQYenUXdPtH2/QuRFZDFN1LZ8iejppiRmMeRaX?=
 =?iso-8859-1?Q?7Wx6JXF+YjKxPHFS3itmmVIpc/lBAs7KHyNqp7z80ymfW9yMpBrs2pcVp0?=
 =?iso-8859-1?Q?iYkBo4lGkfiu7uJJgwVzh2/rfLHJvdwinXQrtmw1FMfD3xcySNdCEapbb2?=
 =?iso-8859-1?Q?sWgfTnnl3Clw2rHKwEpSW5kdE/fREYDBQk2P9jl3NBqapw0hJ2Y6Uw130p?=
 =?iso-8859-1?Q?YKfjRF1+sxcZRVHxf8Oxzyymj+Gu/9Af5HHosYy7iUN+6bir5NDJL5gr/I?=
 =?iso-8859-1?Q?nw0VVlVPH+5HF6y2dFZkXV60fIBcHH6ebOKJKj5/oDeK8d56ZR8xx6pfvX?=
 =?iso-8859-1?Q?sGmQkLMXtMc+CTatJ9CmGyZq4/lgzKCHJaYEET767rhII6iTJ8xUdmvToJ?=
 =?iso-8859-1?Q?jikaNsp0u3UPixyICKMDJaxPVKlqgaH2hO0aih8k0LAVUWplXQB/mcypij?=
 =?iso-8859-1?Q?iC5Qir/xuUFnzQNVrJSfJ2J+/F1+DYOOEDABUztk/dJlGIQJH+DLIGViuC?=
 =?iso-8859-1?Q?RJ4p+G0BuBiTJRJ8K4ahzSVsgmCwiPIsyOEn02mvlNeQkr218wkCgSmfmv?=
 =?iso-8859-1?Q?caZgjJOeRJXJQygz+loz+TRf10vXfzrLzjEZNZCiTZmhygZnmeUBBeEPr3?=
 =?iso-8859-1?Q?Xi90g4H+iFUhqBQW2nZUF1JuktPiWGPDZBPggnX/mowB+p2dOhHY1QTdmz?=
 =?iso-8859-1?Q?w4QH1KGc7FqkwuMT6uhZqVtPyXloi4SXlvElS0LbW9iOv+flctmXezDzkc?=
 =?iso-8859-1?Q?cxAWzqlgMGxEQHmDuTA162eEo8J0mEzRsxakX1poY2I1kzVGK1TGeAv5KS?=
 =?iso-8859-1?Q?3zOpzKBkApQAOXJNpddzYF5Y7cqWJR+4W+QC/wc8BRepMQDMET+WKt2Xwh?=
 =?iso-8859-1?Q?xUkW8Z1ZytCHVxt5noiz0VKym1kpuLZCrdmFnSrgErxl/Y6yQLXzZRrGFK?=
 =?iso-8859-1?Q?GH6H7KhNWyyymQCLkMtnBXUVz4hoH2ZuKW22gltgqN5QBimX5Ajmh0Imng?=
 =?iso-8859-1?Q?MHBPm3CGAsnzGZYc+15+uu+7m8v+jwXkkwPf2ut6K3MA1Orkbe9Ze8ONNR?=
 =?iso-8859-1?Q?V7VvSEqWrSeKAncypIQ7vqfDCj/YXbuyqvu5b+QyDcwnMl4Q/0tMm33tNO?=
 =?iso-8859-1?Q?XYsmE0YcvP/1yN34O1/GVwxZLfIpZJUUeCI906iAEqyb8bwSMetyTHmj5f?=
 =?iso-8859-1?Q?TZT4J7RjBKmecQH42u7kuCJwR46L8cggvqbQkiosd8jwXZLn6azBFRHy9U?=
 =?iso-8859-1?Q?ZCWcISVHqPWo4TbgdQdyjGOcxaC3H08pddfQplwcCu428q?=
Content-Type: multipart/alternative;
 boundary="_000_CO6PR12MB547319DAE1601C366E2E607C82EA9CO6PR12MB5473namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79c74f60-12ec-4a0c-baec-08da1bbca080
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2022 13:10:18.5845 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ud0wLjPh/l+SbPSsrrG1qZPt8PUGAu0VdEhF9kfjU/EOO5IWw6xGmWfv+Hm0PLCf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB5554
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_CO6PR12MB547319DAE1601C366E2E607C82EA9CO6PR12MB5473namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only]


________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Ma Jun <=
Jun.Ma2@amd.com>
Sent: Monday, April 11, 2022 8:42 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Chri=
stian.Koenig@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: Release memory when psp sw_init is failed

Release the memory (psp->cmd) when psp initialization is
failed in psp_sw_init

Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
Change-Id: I2f88b5919142d55dd7d3820a7da94823286db235
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_psp.c
index a6acec1a6155..1227dc014c80 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -305,9 +305,10 @@ static int psp_sw_init(void *handle)
                 ret =3D psp_init_sriov_microcode(psp);
         else
                 ret =3D psp_init_microcode(psp);
+
         if (ret) {
                 DRM_ERROR("Failed to load psp firmware!\n");
-               return ret;
+               goto failure;
         }

         adev->psp.xgmi_context.supports_extended_data =3D
@@ -339,25 +340,27 @@ static int psp_sw_init(void *handle)
                 ret =3D psp_memory_training_init(psp);
                 if (ret) {
                         DRM_ERROR("Failed to initialize memory training!\n=
");
-                       return ret;
+                       goto failure;
                 }

                 ret =3D psp_mem_training(psp, PSP_MEM_TRAIN_COLD_BOOT);
                 if (ret) {
                         DRM_ERROR("Failed to process memory training!\n");
-                       return ret;
+                       goto failure;
                 }
         }

         if (adev->ip_versions[MP0_HWIP][0] =3D=3D IP_VERSION(11, 0, 0) ||
             adev->ip_versions[MP0_HWIP][0] =3D=3D IP_VERSION(11, 0, 7)) {
                 ret=3D psp_sysfs_init(adev);
-               if (ret) {
-                       return ret;
-               }
+               if (ret)
+                       goto failure;
         }

         return 0;
+failure:
+       kfree(psp->cmd);
+       return ret;
[kevin]:

  1.  do you forget to set 'psp->cmd' to NULL?
  2.  according to my understanding, the buf will not be used in the functi=
on (in psp sw init stage), can you move this to end of function to mke patc=
h logic is clearly.

Best Regards,
Kevin
 }

 static int psp_sw_fini(void *handle)
--
2.25.1


--_000_CO6PR12MB547319DAE1601C366E2E607C82EA9CO6PR12MB5473namp_
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
[AMD Official Use Only]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" co=
lor=3D"#000000" style=3D"font-size:11pt"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Ma Jun &lt;Jun.Ma2@amd.com&gt=
;<br>
<b>Sent:</b> Monday, April 11, 2022 8:42 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Koenig, Ch=
ristian &lt;Christian.Koenig@amd.com&gt;; Zhang, Hawking &lt;Hawking.Zhang@=
amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: Release memory when psp sw_init is fail=
ed</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt"=
>
<div class=3D"PlainText elementToProof">Release the memory (psp-&gt;cmd) wh=
en psp initialization is<br>
failed in psp_sw_init<br>
<br>
Signed-off-by: Ma Jun &lt;Jun.Ma2@amd.com&gt;<br>
Change-Id: I2f88b5919142d55dd7d3820a7da94823286db235<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 15 +++++++++------<br>
&nbsp;1 file changed, 9 insertions(+), 6 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_psp.c<br>
index a6acec1a6155..1227dc014c80 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c<br>
@@ -305,9 +305,10 @@ static int psp_sw_init(void *handle)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; ret =3D psp_init_sriov_microcode(psp);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; ret =3D psp_init_microcode(psp);<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; DRM_ERROR(&quot;Failed to load psp firmware!\n&quot;)=
;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return ret;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; goto failure;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;psp.xgmi_context.=
supports_extended_data =3D<br>
@@ -339,25 +340,27 @@ static int psp_sw_init(void *handle)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; ret =3D psp_memory_training_init(psp);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (ret) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_E=
RROR(&quot;Failed to initialize memory training!\n&quot;);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto failure;<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; ret =3D psp_mem_training(psp, PSP_MEM_TRAIN_COLD_BOOT=
);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (ret) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_E=
RROR(&quot;Failed to process memory training!\n&quot;);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto failure;<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;ip_versions[M=
P0_HWIP][0] =3D=3D IP_VERSION(11, 0, 0) ||<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ad=
ev-&gt;ip_versions[MP0_HWIP][0] =3D=3D IP_VERSION(11, 0, 7)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; ret=3D psp_sysfs_init(adev);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (ret) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (ret)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto failure;<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
+failure:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfree(psp-&gt;cmd);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;</div>
<div class=3D"PlainText elementToProof">[kevin]:</div>
<div class=3D"PlainText elementToProof">
<ol>
<li><span>do you forget to set 'psp-&gt;cmd' to NULL?<br>
</span></li><li><span>according to my understanding, the buf will not be us=
ed in the function (in psp sw init stage), can you move this to end of func=
tion to mke patch logic is clearly.<br>
<span></span></span></li></ol>
</div>
<div class=3D"PlainText elementToProof">Best Regards,</div>
<div class=3D"PlainText elementToProof">Kevin<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;static int psp_sw_fini(void *handle)<br>
-- <br>
2.25.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_CO6PR12MB547319DAE1601C366E2E607C82EA9CO6PR12MB5473namp_--
