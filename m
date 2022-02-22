Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AB9EC433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Feb 2022 15:25:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0382A10E4E1;
	Tue, 22 Feb 2022 15:25:58 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2057.outbound.protection.outlook.com [40.107.223.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E2C010E5D7
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Feb 2022 15:25:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jY5FLh+vPy51Scb8XvLeZndP2thmo9KtCGjADGyuG9nS+q4OiVPR/J+zefyRHY2qDAj5nSSp+IUK1fnkBeZ8gW+5Wjgh/LPtrHSUBA+OZuUKpnZtALNn0Q1d2L1X21R1a39P9lhLTf5YdexiIMudvVR8MUUxuBAdBXinMde5ecZ1/NpvM1QIfT93UQdEBn2thRbJjaaE8NVtIptRFt6nGnRuP7cflnbFWwG9zvXJwGrz3IevEE5y27E5NnShrJZoNilXV/nQVXwSWoIeIUN5OodP/AS/yfJIdzFTpKs9smDgc3y87JMNUKCnEFEZFAwKiM1dku28Zq2KcbrVK31kzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lmo7+bhjmSHUpVAaupVxlCuIQWVQkk6o+h0A5kC+i4o=;
 b=WTUMO8NB5wZgFHXbhOjp8jKxtavd5NfC07th7zf54RD12u0Yt1Iw9ILxdVVbuiI7V82SOvnnWDzlubi3bq7Yu0GDHk4aTAKCAAMfNEuJVLIU9OSZQMCeosjvUhoxqr9xUrPJ/mdg4CM0ImyD9aG7xo9MeGZxngt/EHJSQlb/VHGgrVns+TgZaQizQfZ2FGHOPy1fwMZZsJC6QTnzJC9bsGpcUWuIoK2noNnTpITcle0qTAN1g7akzjw8LvID2ln0fq2B37qx3gtWjiXO8sfP2JDCw+oNV0ZGBERkh1vCyZ0l4xzHqRcVpDkbyXwMt8J5TOyaDn2pcNc3zbYBw5NWxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lmo7+bhjmSHUpVAaupVxlCuIQWVQkk6o+h0A5kC+i4o=;
 b=j952hBzoncoMYCdM1PKPCvm8DbSlZIcFcJ/Kq2QqcgFwXQbCX4T3qVWuHojv67qyzrlmNc+fZ/+4enKC8Udl+KpDKyF4WrrtP8oEH5IvIh3MrssCjQtxfdse/nuYc15y9oLkpdHreMmjPK2OdcEPSLJ9NvrFdqjnBFQfhibkMIA=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by MW3PR12MB4492.namprd12.prod.outlook.com (2603:10b6:303:57::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.22; Tue, 22 Feb
 2022 15:25:55 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::2877:73e4:31e7:cecf]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::2877:73e4:31e7:cecf%7]) with mapi id 15.20.4995.027; Tue, 22 Feb 2022
 15:25:55 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Chen, Guchun" <Guchun.Chen@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Zhang, Hawking" <Hawking.Zhang@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>, "Pan, Xinhui"
 <Xinhui.Pan@amd.com>
Subject: Re: [PATCH] drm/amdgpu: limit harvest bit read on several ASICs
Thread-Topic: [PATCH] drm/amdgpu: limit harvest bit read on several ASICs
Thread-Index: AQHYJ/32llQ81uKIkE+Iyz546EtxxayfsO2H
Date: Tue, 22 Feb 2022 15:25:55 +0000
Message-ID: <BL1PR12MB5144943B84097486016D420AF73B9@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20220222150731.16954-1-guchun.chen@amd.com>
In-Reply-To: <20220222150731.16954-1-guchun.chen@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=True;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-02-22T15:25:54.686Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD
 Official Use
 Only; MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard; 
suggested_attachment_session_id: 3ffecca4-d11a-44b4-a20c-8c05560d9c01
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6d8663fa-bf18-4dee-7edd-08d9f6179e81
x-ms-traffictypediagnostic: MW3PR12MB4492:EE_
x-microsoft-antispam-prvs: <MW3PR12MB449213C512033BD3F0FD9712F73B9@MW3PR12MB4492.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fZQsGN8pjq/NDEN8xrNKZwd5CuZ1/OhNcTyz6Ch/v209pke46W0E/GAWYjTwUls5ZLRrroVlsmVIephUQGjTIWQlfFK8WI52vPUUHeJUVJB7ky3wFb26v11+CRFs+7DcopPNWiifXHQPr5e7hZXkk0tBbScEAEuLb8gqx3Cysublu0EtF5qaVq5/BLpPlnRoybSGH/JABPAqgaodDzuCy0EWxLRrdvcli9WuEoTAQ4jPZMPHdjZPFEqFkX1GFQoO3YUKlO0hZNJO7ELVXdNBpCj4ANWmEkzu1EYylwpVRoi1cMMhZCsxdUN8ujPCp/ljtNbuRM3tz/uDFgTVbPcuv/UjU2Qd7hQx5hoFgg2z5627MXLuihP5b5bziMZvQbPB/9B/eEScv03FYtircnxZ2uxT55OT/hKzig9pM3kBlo4+K8aURW8T7wdWFHrNIn61e8J+7KW238UNB3JNn02EphMzhlzy1fK+Si7EtaOnsFcHIA4o/dFzxB2iXVs9k6aLoDlxLMKojI1ZNV9f5BkWBSmsi+IHioopZkuTTIkNadE6cNjMOXpUGppAKOgLm5ZLUm5zhByX8zriIQABS2QqXRhY3e9wOTIkpEYSxZfxzDxkbT3Va6+wJ+oO8lwaPmRGXkJ01uvRhM0wALfRuFiFnfzEEjRSj6OPFLh8nFgzZBlVk0WpEC2oyeKpK3OGLn/JtBtGTKDQT1dlZC0A3Wl70A==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(9686003)(508600001)(83380400001)(5660300002)(316002)(6506007)(8676002)(122000001)(53546011)(6636002)(71200400001)(110136005)(33656002)(66946007)(66556008)(66476007)(66446008)(64756008)(8936002)(38100700002)(76116006)(52536014)(7696005)(2906002)(26005)(186003)(55016003)(19627405001)(38070700005)(86362001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?FRiUvUYPyMHL+PZvykL7ONJHiAxZAX93HqG1rZwsdxMVruLPVwlXc2L8kdqP?=
 =?us-ascii?Q?138z4G3Qp84ikI9aWCQRF4wMUD14qVrAf04DoKECh8Lk1WYdixaA9q4eR1Y7?=
 =?us-ascii?Q?z0+q03TvV4IMuwSHzpSmtxQQRUUwInTFxp6qwdK13GNJ3dGmzqZ+2iMFMMQr?=
 =?us-ascii?Q?9I7J2p5pS9fvBsq3gIQ3aZYwNUNbCZMsDFtbVsnqYVD84iYOTmvhRrLPOjCV?=
 =?us-ascii?Q?HOqv/MQtv4PxcuRrP4YVESqNI4JBEO35rMy3+NS/fdInRs3H7/BrXhnt8Qqa?=
 =?us-ascii?Q?LbQmlRPrwDvQCtmQot2CdxlVh/b+YeEya49dxViGLvYanfIKTrenUMQcSJNc?=
 =?us-ascii?Q?irxu8kZplsLFZovCgQvQJo8cuPWakW3s68S4es4fFFxPDOOBGidws0NR6kRE?=
 =?us-ascii?Q?b0wCZj/ldcgYC39PviR4mIIqyUicIjqwFJY3WICMdNtBgirhHYBMSrkmQ9Vx?=
 =?us-ascii?Q?ncQEYrMvgcopa1Bp016mFxt2lk0J/eypOoP/GZorsLnjcV+FMGRG845DlDYC?=
 =?us-ascii?Q?GxLjBDbSsWbRaf2iGYUcvctKTmQY8KbFCaNpd0UGc750VDO6XdgK2nzQ7TwY?=
 =?us-ascii?Q?x8LWvp066kGFPsaSuL8pv5AGwNEP82SoPvFmXdFXBy16gmxACZT1DqAN8TEi?=
 =?us-ascii?Q?Gsn3BG/hrIM8sve0up0E2DXWLL4mUg0+2LiOLiGqOYdwMYmZLvINijMLpqf0?=
 =?us-ascii?Q?BpSL/gXCJm+owQgGYDgh3ZRXTlb2Wt+TWLbBvEYTgDSj/W26FW+q6urr2B3P?=
 =?us-ascii?Q?tbAoDISJ8rteSMajGmirLkvMxl8V8kgGUtRdtOLPyKVxWiAU5UVTOLqavTik?=
 =?us-ascii?Q?6QUUcMwnZb5fbY3Sq4QQvKkD2OvCan5UL2oFPldGEaxByuKta8kr9bT8Bx9w?=
 =?us-ascii?Q?VnoqYzFzvvxtlefSHiAojeeWcs5qMQnnydG200klRWpHGDl7MvuWsraQ6GOh?=
 =?us-ascii?Q?JUsBK7jyGLNLxxXf2Xf+aedk439e0Wet37CYC2qdEnKenXq0h9+cQX6QzyUr?=
 =?us-ascii?Q?hHYFI7yk/slFkYd46UulSgxyMxo92IwWWuCMCY6tEIO2f2K15whH9j9p87cg?=
 =?us-ascii?Q?LQv31akDX29Zb4FqRVUcyM8ulv1+em/txQ09KTup7yX7zWGQGrAV4fepWvuA?=
 =?us-ascii?Q?unUGAKqrdV6Rh3kOhZduqNm0zOoqa+EP1FoqXDeCxo10Z2jvEXtw95MQL8hG?=
 =?us-ascii?Q?VtWfGTfygVNp6FdU7jFvRu0MvodVExCr5zOA2t0xtqazWGQA2tDB21hoEeMM?=
 =?us-ascii?Q?mPfJnvB8Q/JHq9R960TwdEynq6uKPrycOf/DKBzfPFjvH4JZ6D9KMqDoc3aV?=
 =?us-ascii?Q?Izgwx3WzXg2cc5iTffen6V7urGgCcUymtfDtt/xMidyLGrQHq/pOgz3l6twE?=
 =?us-ascii?Q?u/PVSbtjtFkSevjlbr0E8+1PLbwdUJtlIeOFU9JeUnzRjZBuQwZRV1hoZElC?=
 =?us-ascii?Q?+eziGzBdss5RXDVLhmF2TAvdUnXx1HQJTiTuKbD7IWGlqrXn6v2p5RSaUxM1?=
 =?us-ascii?Q?/JWpxIiKG5FIZVT5StDTHF8fbctr80hUsKzo2zhf/G2Wvm8x2ZWcmM51vpc4?=
 =?us-ascii?Q?EqZc/+wdrUZK2OWras+koLilBLo9lh8bLGqIQrul3AIiLWMA/ISnuxsG2BUT?=
 =?us-ascii?Q?tg=3D=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB5144943B84097486016D420AF73B9BL1PR12MB5144namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d8663fa-bf18-4dee-7edd-08d9f6179e81
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Feb 2022 15:25:55.1884 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: b76xMxIFun2jJPEAgw8U05CNeGunut0vDgtwYLXjZOanG2bXOqyz++l1k1DnNUrtg4xc2ztZvHh+m1nTKyzLkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4492
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

--_000_BL1PR12MB5144943B84097486016D420AF73B9BL1PR12MB5144namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only]

Acked-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: Chen, Guchun <Guchun.Chen@amd.com>
Sent: Tuesday, February 22, 2022 10:07 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>; Deucher,=
 Alexander <Alexander.Deucher@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.c=
om>; Koenig, Christian <Christian.Koenig@amd.com>; Pan, Xinhui <Xinhui.Pan@=
amd.com>
Cc: Chen, Guchun <Guchun.Chen@amd.com>
Subject: [PATCH] drm/amdgpu: limit harvest bit read on several ASICs

Due to faulty VBIOS out there, harvest bit setting is not
consistently correct especially for display IP. So far,
it's hard to work out a solution on all the legacy Navi1x
ASICs in a short time, so to avoid regression, limit harvest
bit read on several ASICs. Will revisit later once VBIOS has
corrected it in long term.

Fixes: b3f4ea887d5f("drm/amdgpu: read harvest bit per IP data on legacy GPU=
s")
Signed-off-by: Guchun Chen <guchun.chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_discovery.c
index 11255290f117..2e0ff1ace6fc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -1129,12 +1129,20 @@ void amdgpu_discovery_harvest_ip(struct amdgpu_devi=
ce *adev)
          * so read harvest bit per IP data structure to set
          * harvest configuration.
          */
-       if (adev->ip_versions[GC_HWIP][0] < IP_VERSION(10, 2, 0))
-               amdgpu_discovery_read_harvest_bit_per_ip(adev,
-                                                       &vcn_harvest_count)=
;
-       else
+       if (adev->ip_versions[GC_HWIP][0] < IP_VERSION(10, 2, 0)) {
+               if ((adev->pdev->device =3D=3D 0x731E &&
+                       (adev->pdev->revision =3D=3D 0xC6 ||
+                        adev->pdev->revision =3D=3D 0xC7)) ||
+                       (adev->pdev->device =3D=3D 0x7340 &&
+                        adev->pdev->revision =3D=3D 0xC9) ||
+                       (adev->pdev->device =3D=3D 0x7360 &&
+                        adev->pdev->revision =3D=3D 0xC7))
+                       amdgpu_discovery_read_harvest_bit_per_ip(adev,
+                               &vcn_harvest_count);
+       } else {
                 amdgpu_disocvery_read_from_harvest_table(adev,
-                                                       &vcn_harvest_count)=
;
+                       &vcn_harvest_count);
+       }

         amdgpu_discovery_harvest_config_quirk(adev);

--
2.17.1


--_000_BL1PR12MB5144943B84097486016D420AF73B9BL1PR12MB5144namp_
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
Acked-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Chen, Guchun &lt;Guch=
un.Chen@amd.com&gt;<br>
<b>Sent:</b> Tuesday, February 22, 2022 10:07 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;; Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Zhang, Hawking &=
lt;Hawking.Zhang@amd.com&gt;; Koenig, Christian &lt;Christian.Koenig@amd.co=
m&gt;; Pan, Xinhui &lt;Xinhui.Pan@amd.com&gt;<br>
<b>Cc:</b> Chen, Guchun &lt;Guchun.Chen@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: limit harvest bit read on several ASICs=
</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Due to faulty VBIOS out there, harvest bit setting=
 is not<br>
consistently correct especially for display IP. So far,<br>
it's hard to work out a solution on all the legacy Navi1x<br>
ASICs in a short time, so to avoid regression, limit harvest<br>
bit read on several ASICs. Will revisit later once VBIOS has<br>
corrected it in long term.<br>
<br>
Fixes: b3f4ea887d5f(&quot;drm/amdgpu: read harvest bit per IP data on legac=
y GPUs&quot;)<br>
Signed-off-by: Guchun Chen &lt;guchun.chen@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 18 +++++++++++++-----=
<br>
&nbsp;1 file changed, 13 insertions(+), 5 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_discovery.c<br>
index 11255290f117..2e0ff1ace6fc 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c<br>
@@ -1129,12 +1129,20 @@ void amdgpu_discovery_harvest_ip(struct amdgpu_devi=
ce *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * so read harvest bi=
t per IP data structure to set<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * harvest configurat=
ion.<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;ip_versions[GC_HWIP][0] =
&lt; IP_VERSION(10, 2, 0))<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; amdgpu_discovery_read_harvest_bit_per_ip(adev,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; &amp;vcn_harvest_count);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;ip_versions[GC_HWIP][0] =
&lt; IP_VERSION(10, 2, 0)) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if ((adev-&gt;pdev-&gt;device =3D=3D 0x731E &amp;&amp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (adev-&gt;pdev-&=
gt;revision =3D=3D 0xC6 ||<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;p=
dev-&gt;revision =3D=3D 0xC7)) ||<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (adev-&gt;pdev-&=
gt;device =3D=3D 0x7340 &amp;&amp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;p=
dev-&gt;revision =3D=3D 0xC9) ||<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (adev-&gt;pdev-&=
gt;device =3D=3D 0x7360 &amp;&amp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;p=
dev-&gt;revision =3D=3D 0xC7))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_discovery=
_read_harvest_bit_per_ip(adev,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;vcn_harvest_count);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; amdgpu_disocvery_read_from_harvest_table(adev,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; &amp;vcn_harvest_count);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;vcn_harvest=
_count);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_discovery_harvest_c=
onfig_quirk(adev);<br>
&nbsp;<br>
-- <br>
2.17.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BL1PR12MB5144943B84097486016D420AF73B9BL1PR12MB5144namp_--
