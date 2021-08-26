Return-Path: <SRS0=gNHI=NR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C07B6C432BE
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Aug 2021 18:18:30 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6EAED60FC1
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Aug 2021 18:18:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6EAED60FC1
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 10E996E895;
	Thu, 26 Aug 2021 18:18:30 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2046.outbound.protection.outlook.com [40.107.96.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 578036E895
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Aug 2021 18:18:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TbvTdJlu/siHyzm9QPWWLOGIclqcUPH9zAbWVqp5GMM/nCLRc0MF+R7ySH/vT8cdB6Hy9jeYS/6RMjTUbSbQfnWiisBtFXfScVoKmNf4MM93JdX7wrhx6E0a+uRzsdtL7CxgQnd87kRJqFLg1SLkKB92V79s7Ef+ph/X9r7arQxneaJXwuzulfHLzEKVjqPj29JwWmQYq38gGa450hiD7ns66pq7VxL/yGPFYI2XwpsRAJoStCsXRQ275Ru5YNispBNxWT9i2QmyE9Gu1BYQVIa0t93HilUWj4QdD+kLsUGetiMasK5iEkdQxTASLBW+pQsO14MIlGUvpkzGTYPyBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jtpnd+5MC/QycSVKa57cqWp0CLXZ7gxYOgnxn2M+Ubs=;
 b=gbx3D4KJ2ePeL6/39TIHU8CoFJ0nUfSv9WrpnTVNs0GpK5U3Z2X7mcpEQsXsboZh5WAs7b4B+qqKVRhzFqpOvbOzLwJAQg1vxM1IFY9BDFHGDa2/3Zg84GX9LwASMhUY3XnsZmF4oVzJLk8Vv0nZmxm2aizZjupnLhGBU4nRaGkuBatD8sRyMS4SNQXX0GwB8lYfbRhmVIVlEjkldNiAcn9Vb5WRYRh/wstXu/qXDuXPqxla2Xyoo5QusQS5QZiOsq65TSqfkVDpFT8Vy/5xI83JhDPZedsXe4TV8OcxevLPlh+jpfV3ym9xiW30eFmxhbB2YT++t6H/aAJPhp46dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jtpnd+5MC/QycSVKa57cqWp0CLXZ7gxYOgnxn2M+Ubs=;
 b=fhH5QG15fX/ruOzs17PSXFiarto8uaRm4GDLSN+zdrk7L17QzgurUiNlsWpeNProd/pKuOZGl3wSI85hR0wpD+IT1c1XWHfBs7aNvZ9AUmmh+ZJ+QNc7wH/Wmhx0vKjjjPbN/wiJLuR70PuTcGl3lrmQ8d0tEYCbBUSbTQZD0Lo=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by BL1PR12MB5364.namprd12.prod.outlook.com (2603:10b6:208:314::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.14; Thu, 26 Aug
 2021 18:18:25 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::5dfc:ea54:4a18:89f5]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::5dfc:ea54:4a18:89f5%4]) with mapi id 15.20.4436.024; Thu, 26 Aug 2021
 18:18:25 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Mahapatra, Rajib" <Rajib.Mahapatra@amd.com>, "Wentland, Harry"
 <Harry.Wentland@amd.com>, "Kazlauskas, Nicholas"
 <Nicholas.Kazlauskas@amd.com>, "Wu, Hersen" <hersenxs.wu@amd.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amd/display: Set the domain as GTT when VRAM size <=
 32 MB
Thread-Topic: [PATCH] drm/amd/display: Set the domain as GTT when VRAM size <=
 32 MB
Thread-Index: AQHXmqVX4gt3/ggKW0q5Zgrxz3HeBquGF+tQ
Date: Thu, 26 Aug 2021 18:18:25 +0000
Message-ID: <BL1PR12MB5144C0F1425B8CE8B11BC093F7C79@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20210826180754.3193315-1-rajib.mahapatra@amd.com>
In-Reply-To: <20210826180754.3193315-1-rajib.mahapatra@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=True;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-08-26T18:18:25.119Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8b825f29-cc98-4152-df6a-08d968bde573
x-ms-traffictypediagnostic: BL1PR12MB5364:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL1PR12MB53646DDF113ADBB96B1EB26EF7C79@BL1PR12MB5364.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1388;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CvOwyRPbY2/gcB2Tr5KjRdIEfoV8q7IghVoiLpQ4uNNkeQ8/P1l4mXWCcJcmbo4wanO0iVYaoO00Jj54Te321kS84kUqTIq3TVkP53hY+0lo/dMbnslo+tu2WblrB1HJTvfuginIrdoWkUDLaO7xrJqHJ7HMCsLeW1pGKoM0dWM/Pw8tBirojFhRdKE4Mi9Sl39k4c/eeErRmOMnm53crYTX4kKvlpbNi5CoMa0wlZ5e9M1p6dp8mleC+4mnmdthkGuO7npTnq9eslxF0+/9xe6tJ2/74RMq6x/PRAYK1wyYfSC0D8/dh3ePhw0zC/U1OVfA7vMouKLUzdt56+UgOog5R7HYkp9wUTfD8si/USTymJyDMNDWJ1kHecVZuau+E7/NGLR0K49LnQehtoBmU+vvuys+4h3vdNpNZ9EO/Kqa76zTlyH7kXlW7+DPOas5GxbfR21tSR8WpPKQIHFVECE5Q/xJ/EPXKj9HO9WmbHXIddXcabgCCcH8hWWMJSzzRjhW2hHOFbAduW8XM+8rGXduBowxc5528+kDv4Rlv6C3cPBUyyt7RMPXggBLK4+Z8PXsIzCN9q46JSo0hL7vWjiA+b0aBzyXeKxzaF/bVW4JUJSJ63a9Mx67gzVMRPrluAgJISA1rluK+HiTh6NPcaEz1p5fHKduS9vV+3XBQ4M5QE9keGVuSD0CGGd1GbXPJR6t9ACQ+LZ2p02Y5Tt/Cg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(136003)(366004)(346002)(376002)(38100700002)(52536014)(64756008)(66556008)(7696005)(5660300002)(76116006)(8936002)(55016002)(19627405001)(86362001)(110136005)(6506007)(8676002)(33656002)(122000001)(316002)(66946007)(53546011)(66446008)(38070700005)(26005)(478600001)(166002)(2906002)(186003)(83380400001)(4326008)(966005)(6636002)(9686003)(66476007)(71200400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?WhEMY2PrLC/Tnk/7FL16TZ6bWNzZJhnUBPQIKpvujV+DBKcDRP+6abgodJi3?=
 =?us-ascii?Q?u7+S7htuVbm1dHOLbMsbnK/qHoOIuzpAsE2iXn8qQBpQ0nxY1QfLP+l3kU8D?=
 =?us-ascii?Q?dOGnTs4WyIsvv6qU0fPKLMI+2yDN4g6dHyh2lpCOcha8mdZyb3mWfgo7sZAH?=
 =?us-ascii?Q?PVvZdEsu4mdwIkVE+XZ1c+4fVSV/brQsR/A25TP58pc7svYuwWQYCHwPi1BV?=
 =?us-ascii?Q?8l3cA7lmMRYdlm6napI5BBqbWAj3ApB65EmzPCEXzFkqheAFB8wrq8FpEjd+?=
 =?us-ascii?Q?ELm5SfqgFyKro3lipSkJsRYuRicU3+tLgmKLaFQ1Pg+Vlxc/kiO6BwPJEa9C?=
 =?us-ascii?Q?mEbOeF3IKtqF2DJj7SqkK2yGHe6EqL9YhiDDGOJ+3vCpVxaBJV9EsVEQlT7T?=
 =?us-ascii?Q?KU8/se7gGLmPrOKYgx3MYW92tPJddriAqPqqDeMmi9MR6FtFTtUGmY7Q+fYd?=
 =?us-ascii?Q?prkWs0fuPyfIiOWBB1nC86qukx8aIfkht5ErH73KbX66TMOyv+8LcWSq3KMW?=
 =?us-ascii?Q?rZv6nb/d+5Kg2VmsnES+PkNF7FhGa0H03lyjE5UBanin0cAcXsxYxoa6B8/C?=
 =?us-ascii?Q?KnEf8uZZJcTK+fMubejblZJe1K0zXzzQvyhiIW6XFJGwFfPHPNeZcY+xCaR6?=
 =?us-ascii?Q?fASNPhbPHc0iTNs+kfh9Y6MMikV0sEzUtdxeW/IEv0xMItpdUuFL8RkMz7YL?=
 =?us-ascii?Q?ezeK1NY44q/0R5V/f0HC/FT4Zd35dEUEybIgMrwbhZXt4a02gwcFiLJ8aCPJ?=
 =?us-ascii?Q?61XoArOXYC9s1Ml9+kK1BxPWrlkZiqQij55zD8tTPvry93YnieIiek5Z+7A4?=
 =?us-ascii?Q?2LJDmhO0aR+u3Vg/6/MjxPjVlbO3WK5irHS1Ev03qbZ1u/Bmoh9Ys45TwFJ9?=
 =?us-ascii?Q?jO12vGbFqKkOrtQW9fbLNEpN6HrXMGZT3olcREEAAVtu1412n2rZcpKbkrnf?=
 =?us-ascii?Q?fMIsN3NkCYgmZvDFLYj9ThSpWqQx4bvhO526LgeuvagL8Dg693Wxx920kaj/?=
 =?us-ascii?Q?f+LTg15VIojoewYOl5rvNVjsu+/PmXaPfeP0OAlCdMc1mPRrutEkUtze2XyO?=
 =?us-ascii?Q?o+Ih8JujPfi1Q5aWzDkN7/Lf6XL4CEAEoVDrekxxWAbpVglCd8r23rBujT2e?=
 =?us-ascii?Q?fPHHp8iy50J88KmMY61CojSmo1oAxZl9gdQYFz3nFyALpFV2CqTnlNIzoGku?=
 =?us-ascii?Q?JVGZDElwaWKju747SGOxBSbUCG2NvE12GuXtPyQptkE7b/nnUnsUIGGOPzOt?=
 =?us-ascii?Q?dwhkM7cF8uL3hNuqOw7l1cyaoK3G4MJgJagscBQJkDQWj2wHQXlWSB2tws/V?=
 =?us-ascii?Q?ZpnsqrLKNP8raP1ldyonaS5L?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB5144C0F1425B8CE8B11BC093F7C79BL1PR12MB5144namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b825f29-cc98-4152-df6a-08d968bde573
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2021 18:18:25.5686 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VzTKhiRCDzDBjmXXT7IqaCDU9dQN/GtPHmqC/3/7m8+6OYEvwLgRa2NFn9oU/qKyFS4smx4+bhkc0YZ1O8M+Og==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5364
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

--_000_BL1PR12MB5144C0F1425B8CE8B11BC093F7C79BL1PR12MB5144namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[Public]

I think this may have already been fixed with this patch:
https://gitlab.freedesktop.org/agd5f/linux/-/commit/2a7b9a8437130fd328001f4=
edfac8eec98dfe298

Alex

________________________________
From: Mahapatra, Rajib <Rajib.Mahapatra@amd.com>
Sent: Thursday, August 26, 2021 2:07 PM
To: Wentland, Harry <Harry.Wentland@amd.com>; Kazlauskas, Nicholas <Nichola=
s.Kazlauskas@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>; Wu, =
Hersen <hersenxs.wu@amd.com>
Cc: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>; Mahapatr=
a, Rajib <Rajib.Mahapatra@amd.com>
Subject: [PATCH] drm/amd/display: Set the domain as GTT when VRAM size <=3D=
 32 MB

[Why]
In lower carve out (<=3D 32 MB) devices, it was unable to pin framebuffer i=
n
VRAM domain for some BO allocations. The device shows below error logs and
sometimes it reboots too.

amdgpu 0000:02:00.0: amdgpu: 00000000d721431c pin failed
[drm:dm_plane_helper_prepare_fb] *ERROR* Failed to pin framebuffer with err=
or -12

[How]
Place the domain as GTT when VRAM size <=3D 32 MB.

Signed-off-by: Rajib Mahapatra <rajib.mahapatra@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h               |  1 +
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 10 +++++++++-
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdg=
pu/amdgpu.h
index dc3c6b3a00e5..d719be448eec 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -236,6 +236,7 @@ extern int amdgpu_num_kcq;

 #define AMDGPU_VM_MAX_NUM_CTX                   4096
 #define AMDGPU_SG_THRESHOLD                     (256*1024*1024)
+#define AMDGPU_VRAM_MIN_THRESHOLD              (32*1024*1024)
 #define AMDGPU_DEFAULT_GTT_SIZE_MB              3072ULL /* 3GB by default =
*/
 #define AMDGPU_WAIT_IDLE_TIMEOUT_IN_MS          3000
 #define AMDGPU_MAX_USEC_TIMEOUT                 100000  /* 100 ms */
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gp=
u/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index e1e57e7465a7..f71391599be1 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -7106,8 +7106,16 @@ static int dm_plane_helper_prepare_fb(struct drm_pla=
ne *plane,
                 return r;
         }

-       if (plane->type !=3D DRM_PLANE_TYPE_CURSOR)
+       if (plane->type !=3D DRM_PLANE_TYPE_CURSOR) {
                 domain =3D amdgpu_display_supported_domains(adev, rbo->fla=
gs);
+               /*
+                * Handle devices with lower carve out.
+                */
+               if (adev->gmc.real_vram_size <=3D AMDGPU_VRAM_MIN_THRESHOLD=
) {
+                       domain |=3D (domain & AMDGPU_GEM_DOMAIN_GTT) ? doma=
in :
+                                  AMDGPU_GEM_DOMAIN_GTT;
+               }
+       }
         else
                 domain =3D AMDGPU_GEM_DOMAIN_VRAM;

--
2.25.1


--_000_BL1PR12MB5144C0F1425B8CE8B11BC093F7C79BL1PR12MB5144namp_
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
<p style=3D"font-family:Arial;font-size:10pt;color:#008000;margin:15pt;" al=
ign=3D"Left">
[Public]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
I think this may have already been fixed with this patch:</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<a href=3D"https://gitlab.freedesktop.org/agd5f/linux/-/commit/2a7b9a843713=
0fd328001f4edfac8eec98dfe298" id=3D"LPlnk">https://gitlab.freedesktop.org/a=
gd5f/linux/-/commit/2a7b9a8437130fd328001f4edfac8eec98dfe298</a></div>
<div class=3D"_Entity _EType_OWALinkPreview _EId_OWALinkPreview _EReadonly_=
1"></div>
<br>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Alex</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Mahapatra, Rajib &lt;=
Rajib.Mahapatra@amd.com&gt;<br>
<b>Sent:</b> Thursday, August 26, 2021 2:07 PM<br>
<b>To:</b> Wentland, Harry &lt;Harry.Wentland@amd.com&gt;; Kazlauskas, Nich=
olas &lt;Nicholas.Kazlauskas@amd.com&gt;; Deucher, Alexander &lt;Alexander.=
Deucher@amd.com&gt;; Wu, Hersen &lt;hersenxs.wu@amd.com&gt;<br>
<b>Cc:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;; Mahapatra, Rajib &lt;Rajib.Mahapatra@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amd/display: Set the domain as GTT when VRAM si=
ze &lt;=3D 32 MB</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">[Why]<br>
In lower carve out (&lt;=3D 32 MB) devices, it was unable to pin framebuffe=
r in<br>
VRAM domain for some BO allocations. The device shows below error logs and<=
br>
sometimes it reboots too.<br>
<br>
amdgpu 0000:02:00.0: amdgpu: 00000000d721431c pin failed<br>
[drm:dm_plane_helper_prepare_fb] *ERROR* Failed to pin framebuffer with err=
or -12<br>
<br>
[How]<br>
Place the domain as GTT when VRAM size &lt;=3D 32 MB.<br>
<br>
Signed-off-by: Rajib Mahapatra &lt;rajib.mahapatra@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 1 +<br>
&nbsp;drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 10 +++++++++-<br>
&nbsp;2 files changed, 10 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdg=
pu/amdgpu.h<br>
index dc3c6b3a00e5..d719be448eec 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h<br>
@@ -236,6 +236,7 @@ extern int amdgpu_num_kcq;<br>
&nbsp;<br>
&nbsp;#define AMDGPU_VM_MAX_NUM_CTX&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 4096<b=
r>
&nbsp;#define AMDGPU_SG_THRESHOLD&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; (256*1024*1024)<br>
+#define AMDGPU_VRAM_MIN_THRESHOLD&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (32*1024*1024)<br>
&nbsp;#define AMDGPU_DEFAULT_GTT_SIZE_MB&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 3072ULL /* 3GB by default */<br=
>
&nbsp;#define AMDGPU_WAIT_IDLE_TIMEOUT_IN_MS&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; 3000<br>
&nbsp;#define AMDGPU_MAX_USEC_TIMEOUT&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 100000&nbsp; /* =
100 ms */<br>
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gp=
u/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
index e1e57e7465a7..f71391599be1 100644<br>
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
@@ -7106,8 +7106,16 @@ static int dm_plane_helper_prepare_fb(struct drm_pla=
ne *plane,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return r;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (plane-&gt;type !=3D DRM_PLANE_TYP=
E_CURSOR)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (plane-&gt;type !=3D DRM_PLANE_TYP=
E_CURSOR) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; domain =3D amdgpu_display_supported_domains(adev, rbo=
-&gt;flags);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; /*<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; * Handle devices with lower carve out.<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (adev-&gt;gmc.real_vram_size &lt;=3D AMDGPU_VRAM_MIN_THRESHOL=
D) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; domain |=3D (dom=
ain &amp; AMDGPU_GEM_DOMAIN_GTT) ? domain :<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_GEM_DOMAIN_GTT;<br=
>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; domain =3D AMDGPU_GEM_DOMAIN_VRAM;<br>
&nbsp;<br>
-- <br>
2.25.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BL1PR12MB5144C0F1425B8CE8B11BC093F7C79BL1PR12MB5144namp_--
