Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C040ECAAD3
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Sep 2022 03:51:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 39EC810E3B2;
	Fri,  9 Sep 2022 03:51:12 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2040.outbound.protection.outlook.com [40.107.237.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A7FF410E3C0
 for <amd-gfx@lists.freedesktop.org>; Fri,  9 Sep 2022 03:51:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mSt+DTBOGSFZHnITjcOKcmSfGZVLSzG7KqTpX8JqXBvyCPN7XlSalgTL9Qtybd/xysekVl5+A2WpjgD6qjkVfVW1v+2o3XP94DQXu4OyCBDJUmvN2Lc1CMA7Y9MpibjXprtcrcgQMajA1e3jo7iZAXjbkAQ9+6FGHiWqgrYm6nFJzFKNVBTGzHelR/UIn/iYBbuu0hEodEV/dMW9esXr6s0MYE5QEZGdNsSjULumGOyaoWLnURrS39hYAhDTn10w1iUr42PY/fd74MYZL7Un3gwSe+6yZb4HY9ShMLyQEpBbGe9YtC3Yr97cVKySCL+CAU+Wg8xBheVzlwAYMc0prQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zZsqQSdqDEIpkHtur4Ae70+boKtXsFCuWNl0bWtyrcA=;
 b=FZ4X+hPYoZFF83YmojbB/cli9+wIQGBUJsrL81c07s8hswZ6yJtbRxwu4dZsrmU90ZhFqCiY8Ka4gCsHFurFvPWRgTVtIe1O4i8sQxnx8mLUC0c5lvwhRqE9XLT0GAU/Qor2T6UQLe5l8r9UP1FfAAGo7jKQveDzbC4qfa9yujCFrvCTMlcHIOCBdLrk+C4QxHlr2/ZtITQbdlz8oQ4MMOhAqYREIyUzDoE6EWL0Md4uWlh8BLLeU8ktk+khN5apAhNMmYB6zBgFIlSQrOnOj2ik6GB8Om3UWB1jfeNZpIGr1ymThaVDA+ogoGTbtvjzrJE/TcQd0lDkbKUB71WKpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zZsqQSdqDEIpkHtur4Ae70+boKtXsFCuWNl0bWtyrcA=;
 b=X+KwwPwciM3bfkLRHIDKhBKL5MY0rtn5CXI0o0zOic1q/SXop5oBH4fEWXvd2zyt5F1vWWHzBKN24go0cFy/mi/Kj1PaNIpiUWlCJAeNc/UACa1V+FAfHNRaQHdeopNd2CCaEu9sj8P4u1SGMfSGB2HYyl4zqEUgIj/AAa2N+zY=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by DM4PR12MB6639.namprd12.prod.outlook.com (2603:10b6:8:be::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.14; Fri, 9 Sep
 2022 03:51:04 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::1192:d133:8667:ed28]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::1192:d133:8667:ed28%5]) with mapi id 15.20.5612.019; Fri, 9 Sep 2022
 03:51:04 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH v3] drm/amdgpu: change the alignment size of TMR BO to 1M
Thread-Topic: [PATCH v3] drm/amdgpu: change the alignment size of TMR BO to 1M
Thread-Index: AQHYw/9C1KaYUA1kJE+pXZKQGn9+p63Wdqak
Date: Fri, 9 Sep 2022 03:51:03 +0000
Message-ID: <BN9PR12MB52579A7D564E0DA5CE50184CFC439@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20220909034948.3647700-1-KevinYang.Wang@amd.com>
In-Reply-To: <20220909034948.3647700-1-KevinYang.Wang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=True;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-09-09T03:50:37.6106498Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|DM4PR12MB6639:EE_
x-ms-office365-filtering-correlation-id: 760030e7-a724-46cb-be1c-08da921684b4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: b4+ZtoIgDAJUebwW03OCj9gP9rKOfLMtR+gsSI52iS1kwCjfFOcHYHv+ynUoY44Fhkn9UqwawlLMHvMB3ONlrQ0ZOBwsWReQJlQBc78pPz///o3/UMDtnX9UU6Rl4sW29cMRjZv6zu5Kk3lFOM2Wy1mdqvRhO7PQ4I0YTl6Wpxk6wpysgxNiW3/S979ufz/wJm+Y94zj+++4A+DPm9L+ZYj8UAxskhiIp2q1vkqfLiwpcQjCnT5Q9XeVrAZXK3sDEFy66CYS+TNe18+7ZYLKmt5a3EKDRxcdyDfPXr7nTl9TFevQKjNAeQ6OQX8It2QXI+OacJSnt3fYV/8xdWk/q7xIK+/A3Xdwa+6PEPrJV4e01clruEOfci+qem+sCzh3lx7nrWQ8i0gPgFA0twNh0asW3yUWUG7ecCjUb9Kq+WIZ814EPPnlYpGCHgdVB4rkqwsw2IzMVrb8unY+Z/DITr9xMSThk4SX11T7bn0bUwc2L2Ukv1tiK1TncZGAEd6c1QZPxE5pLpbABkvBZn9N0pXqEMOnWO52mt2gu2qhOyfFmiNlOQmHI8kgneuQEhxuLyoHmiLgTt1vos88quFVuwnYxhveMqN1FDN4tvZt0cga6apuCZdD+8gEavoiC2iUNGhHrGTfFYgBFRlL4jZ03+MMo8S/1W6UuFmMnB+9zCJK/oPI6g2zAwcT3sdxVAM+jx7SY+zOoQ3O2ky0b9l9W5mYuHcUPQV4Agh3jqZiqdh2jhJaJeiYT5Kid0dp+1lPftPRjGgkjzd7SzEjRPvwXA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(39860400002)(366004)(376002)(346002)(396003)(136003)(33656002)(83380400001)(5660300002)(2906002)(53546011)(26005)(6506007)(7696005)(66446008)(110136005)(316002)(186003)(9686003)(38070700005)(86362001)(122000001)(38100700002)(55016003)(8936002)(41300700001)(52536014)(71200400001)(76116006)(66556008)(66476007)(64756008)(91956017)(66946007)(4326008)(478600001)(8676002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?8NWgA8jSSKlQ+PltlD1GiMU7kzhG9FlGxWlmrJnEKRsNPDmn1LP9cXXwXsO3?=
 =?us-ascii?Q?aT2OJ3T2gxBvS6CS4KRFE7WiEqvdOrXHQ2EruGreERc4/TYISggjwqoSPOWC?=
 =?us-ascii?Q?U+DKyC9Nqkbr0rYtbAAR1q/ht6VMmtsYOqhoqxnD98ML+0Au0xPPvgmPq+iY?=
 =?us-ascii?Q?dhhLoaf5fMCspc1/4e9KxMMqojrafVdBaEV6XtO9Fc1HLr5gGJB+E3+ndtNd?=
 =?us-ascii?Q?Dlmhu5fpgDwQ8+DeDFrMK/JqBy8iO6POyjem2SMxEsGjXXl60lEnEdCGvTiD?=
 =?us-ascii?Q?rAQxiiu2xyE+jtM3ToOPMXhRpeh8raM2G0/W3qpoSw54pRtD3JyrdMRld6Wb?=
 =?us-ascii?Q?8phPAQkgZyLsUGe9wpnCR7MQfVu3WIE/FaZY432IUEUPvv6l34lN5Ef9abFZ?=
 =?us-ascii?Q?Fgl2xTq2hU5WXSrU6bvNsj4ziamRWoWk7YGsbAEi3CCSGXV+OrvUg6/pHl/7?=
 =?us-ascii?Q?SlWVHGJw/p7rjTykheNAtx6bs3/zk+nR7bX4NuOfFalLq1IYoppMpGZlUMk2?=
 =?us-ascii?Q?06cx/Ax6GoKxIx2Po4NggMfrrKTgmKHidjUMPFgaLZh2HHJ2ejBvxFZ7pWHt?=
 =?us-ascii?Q?B+HTIqzAVLLnU25+zHaQNsNBDVXt85oSp7lIsUWn0tQY4luDUD+n/RqYAx6s?=
 =?us-ascii?Q?4Q66AR/azTAEcB3SG3kKWV80TfYBOcU7SJ9xDk1/GBv/O5Xj9VIdZaiCbErx?=
 =?us-ascii?Q?YASMb+BL19YTLJ4l6AAnOntXB6cr+UOeRsmlKZVr9yRE6993CYyHk9MgQRn4?=
 =?us-ascii?Q?YciaVE4Ew/7toN8SgU+VuN+mN1Zi6BbdOdbu+mgF2sCwv6x9AeMa0AFopWrl?=
 =?us-ascii?Q?ig4jehIBfCdkDCwjQnB4Lkh4xmMgXTHvVqGBX6hNMTIgj4NB7ljJ8yjg5HXD?=
 =?us-ascii?Q?sjHNzZo4nZl4nbR1BjKPCDx8s1trMhgR5yckUgFKNEwavdpB0w/4zUG8huxu?=
 =?us-ascii?Q?ezJ1VcJQPUufQOTS4auJp7FYEsMeejOkTSD3xrn6vn7rS1MmKFSIKoi+fJ4z?=
 =?us-ascii?Q?Zo1qspyWb4xuszDI0mlv/rutYNfRIAvDc0G2XJE/Yt0OT1TLH/6BxEELzVJ6?=
 =?us-ascii?Q?Ile+KfHXIcxEnEtRpLqjVNwKrc8duzmzItJfW4DsEjskp+MgjnQ85uIcm0rq?=
 =?us-ascii?Q?rFDM/tBHEUnw0qZIfDOyro3AhmL/HgamTlb//IEj/186/cqmHCl+piF4YV4c?=
 =?us-ascii?Q?0qCt4hms8TjrxWIgPBAg6DjpYfOl+U9LKkcmuNrS+atJqPIFQilX4gcvyUZf?=
 =?us-ascii?Q?plOcgh46pifKtdGZc05veZ8egHd0543mCUo4jMnTHBJSM+lHIuvLHY/O6z33?=
 =?us-ascii?Q?A2AHw9qEIXtH2FuRy++561l6WwoI9dotoLCFuzI/1x7OWfnrnt5mE8KOaGvd?=
 =?us-ascii?Q?HKQliD5rk90Oqs1HfKddUBphdUWng8S1YuY0ImEz4bGHJaOI2vG5MsvPi4Md?=
 =?us-ascii?Q?F6GpTus9gnwQKru6AVNFo10FHcJ8I+R5DYNQVI1LQuNlgQ/5khFjsGYhlPZ8?=
 =?us-ascii?Q?svVmxKYEE4HLyJx7rPsl9bcPVq6Jq0Sg6Qht4cN6LWwR3kJl5HbgiEUa/P1V?=
 =?us-ascii?Q?PwKy7YVw7MhqjcVZCC2Ne1RuL4Oidh86kvg/PyI3LwZzEyBZWWgxwUYJK/nf?=
 =?us-ascii?Q?9Q=3D=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BN9PR12MB52579A7D564E0DA5CE50184CFC439BN9PR12MB5257namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 760030e7-a724-46cb-be1c-08da921684b4
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Sep 2022 03:51:03.9251 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Sni6hbXp+bpAKg8TV6xqM2BxMaNmZyC87AQ0uI5yk7+7qZ9i7HU4kVvxzVTVzBC4SW98MP4NentehzpIZXXHyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6639
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
Cc: "Wang, Yang\(Kevin\)" <KevinYang.Wang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_BN9PR12MB52579A7D564E0DA5CE50184CFC439BN9PR12MB5257namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - General]

Thanks Kevin!

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
From: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>
Date: Friday, September 9, 2022 at 11:50
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>, Wang, Yang(Kevin) <KevinYang.Wa=
ng@amd.com>
Subject: [PATCH v3] drm/amdgpu: change the alignment size of TMR BO to 1M
align TMR BO size TO tmr size is not necessary,
modify the size to 1M to avoid re-create BO fail
when serious VRAM fragmentation.

v2:
add new macro PSP_TMR_ALIGNMENT for TMR BO alignment size

Signed-off-by: Yang Wang <KevinYang.Wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_psp.c
index cfcaf890a6a1..e430a3142310 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -766,7 +766,7 @@ static int psp_tmr_init(struct psp_context *psp)
         }

         pptr =3D amdgpu_sriov_vf(psp->adev) ? &tmr_buf : NULL;
-       ret =3D amdgpu_bo_create_kernel(psp->adev, tmr_size, PSP_TMR_SIZE(p=
sp->adev),
+       ret =3D amdgpu_bo_create_kernel(psp->adev, tmr_size, PSP_TMR_ALIGNM=
ENT,
                                       AMDGPU_GEM_DOMAIN_VRAM,
                                       &psp->tmr_bo, &psp->tmr_mc_addr, ppt=
r);

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_psp.h
index c32b74bd970f..e593e8c2a54d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
@@ -36,6 +36,7 @@
 #define PSP_CMD_BUFFER_SIZE     0x1000
 #define PSP_1_MEG               0x100000
 #define PSP_TMR_SIZE(adev)      ((adev)->asic_type =3D=3D CHIP_ALDEBARAN ?=
 0x800000 : 0x400000)
+#define PSP_TMR_ALIGNMENT      0x100000
 #define PSP_FW_NAME_LEN         0x24

 enum psp_shared_mem_size {
--
2.25.1

--_000_BN9PR12MB52579A7D564E0DA5CE50184CFC439BN9PR12MB5257namp_
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
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">Thanks Kevin!<o:p><=
/o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt"><o:p>&nbsp;</o:p></=
span></p>
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
</span></b><span style=3D"font-size:12.0pt;color:black">Wang, Yang(Kevin) &=
lt;KevinYang.Wang@amd.com&gt;<br>
<b>Date: </b>Friday, September 9, 2022 at 11:50<br>
<b>To: </b>amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc: </b>Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;, Wang, Yang(Kevin) =
&lt;KevinYang.Wang@amd.com&gt;<br>
<b>Subject: </b>[PATCH v3] drm/amdgpu: change the alignment size of TMR BO =
to 1M<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><span style=3D"font-s=
ize:11.0pt">align TMR BO size TO tmr size is not necessary,<br>
modify the size to 1M to avoid re-create BO fail<br>
when serious VRAM fragmentation.<br>
<br>
v2:<br>
add new macro PSP_TMR_ALIGNMENT for TMR BO alignment size<br>
<br>
Signed-off-by: Yang Wang &lt;KevinYang.Wang@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 2 +-<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h | 1 +<br>
&nbsp;2 files changed, 2 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_psp.c<br>
index cfcaf890a6a1..e430a3142310 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c<br>
@@ -766,7 +766,7 @@ static int psp_tmr_init(struct psp_context *psp)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pptr =3D amdgpu_sriov_vf(p=
sp-&gt;adev) ? &amp;tmr_buf : NULL;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D amdgpu_bo_create_kernel(psp-&=
gt;adev, tmr_size, PSP_TMR_SIZE(psp-&gt;adev),<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D amdgpu_bo_create_kernel(psp-&=
gt;adev, tmr_size, PSP_TMR_ALIGNMENT,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; AMDGPU_GEM_DOMAIN_VRAM,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; &amp;psp-&gt;tmr_bo, &amp;psp-&gt;tmr_mc_addr, pptr);<br>
&nbsp;<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_psp.h<br>
index c32b74bd970f..e593e8c2a54d 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h<br>
@@ -36,6 +36,7 @@<br>
&nbsp;#define PSP_CMD_BUFFER_SIZE&nbsp;&nbsp;&nbsp;&nbsp; 0x1000<br>
&nbsp;#define PSP_1_MEG&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x100000<br>
&nbsp;#define PSP_TMR_SIZE(adev)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ((adev)-&gt;=
asic_type =3D=3D CHIP_ALDEBARAN ? 0x800000 : 0x400000)<br>
+#define PSP_TMR_ALIGNMENT&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x100000<br>
&nbsp;#define PSP_FW_NAME_LEN&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; 0x24<br>
&nbsp;<br>
&nbsp;enum psp_shared_mem_size {<br>
-- <br>
2.25.1<o:p></o:p></span></p>
</div>
</div>
</div>
</body>
</html>

--_000_BN9PR12MB52579A7D564E0DA5CE50184CFC439BN9PR12MB5257namp_--
