Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5C14C25B75
	for <amd-gfx@archiver.kernel.org>; Thu, 23 May 2024 16:03:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5AA2310E131;
	Thu, 23 May 2024 16:03:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NXakPrpa";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2047.outbound.protection.outlook.com [40.107.101.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A9EB410E131
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 May 2024 16:02:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nQSPIzrfETUWDtT1lMCdhUX7Kqh4+0WtisqpPvD1nUOx61B6f2O6HfVoSiAdAVfwUp1KYa1QxF74Ot28936fn7qpzFhdfTS6iBtVci7JBzloXsy1XLs/dGcNu4aIrmdlAwToPTQaijgKAkCUnvmspuVtwY/1aIeIpBOVyybDuzDesloDT2aRFGV5dJNMc4O7Y+VpBH7hajf9FCqeknffzpeqnNiUVllimHyagQUZu8UbRMfUYoUWrPRSwiVupiAaPAVgwMtCxeyZUKXMt8efGIwL6iICWW7UW8lB8ycH8rwXhAltrGF/HyvQ1yp4TjQ0QUDosbDHrZVd8YGOHsVZPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kcR5SO58BssuBAnSMsrt83m/5mkqz1R9W5jZ3VYeJEA=;
 b=PW3E+D4QqprLgWXU1+CKJKr3Q6CnGEmPT+Ohz4rFrl8rcUbjVJAj3we5e0SBStX0z2a8SAhVSqTLjXjYF7vsgKG8Nu3MTw613C3+p2LY9TslYXGUC6xsFkmYZu5V8aWeWpqEgywNYcM92xTK2HmrXm71ZtXIbaHWMzvnnxJDhGyKzy51pxjRN4sUCk72miDj44ZaVfyi2PCb7u78KkmRpPGTjsNY3qtDIIYRhfN5DCAujtxTB+YhUS2JLLWKp8Che7+1vjUrIT/S3AsDeO9YxV9hFHqu+eyLDjbaaRBU5l0lKcY+rtmULUEiXDAq5j/BB/KGUIE/PuiorCwmfiRIYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kcR5SO58BssuBAnSMsrt83m/5mkqz1R9W5jZ3VYeJEA=;
 b=NXakPrpapRirZr1fax/ECf+/6GYUKJ3SsLTg1LcZrYrv5mnQaeXq97AUyAAQPkbdbU/uKpxzkJ20GZaxS+aqjOck6Mq62K/CNWP313ZnWcEHAMyw+VH8aXGB5VzUJJI+pZ5S1w2eB2efHvSsQYRlVRMoEdMxQNmw899hSCmq2HM=
Received: from SJ1PR12MB6194.namprd12.prod.outlook.com (2603:10b6:a03:458::12)
 by CY8PR12MB9036.namprd12.prod.outlook.com (2603:10b6:930:78::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.20; Thu, 23 May
 2024 16:02:53 +0000
Received: from SJ1PR12MB6194.namprd12.prod.outlook.com
 ([fe80::df0b:3ee0:7884:c6a9]) by SJ1PR12MB6194.namprd12.prod.outlook.com
 ([fe80::df0b:3ee0:7884:c6a9%3]) with mapi id 15.20.7587.030; Thu, 23 May 2024
 16:02:53 +0000
From: "Dong, Ruijing" <Ruijing.Dong@amd.com>
To: "Wu, David" <David.Wu3@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Koenig, Christian"
 <Christian.Koenig@amd.com>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Liu, Leo"
 <Leo.Liu@amd.com>, "Jiang, Sonny" <Sonny.Jiang@amd.com>
Subject: RE: [PATCH] drm/amdgpu: drop some kernel messages in VCN code
Thread-Topic: [PATCH] drm/amdgpu: drop some kernel messages in VCN code
Thread-Index: AQHarSKQOzx61bnDt0yx+t8TgYSFMbGk+sEw
Date: Thu, 23 May 2024 16:02:52 +0000
Message-ID: <SJ1PR12MB6194DBE65CF492DA12ED5BE795F42@SJ1PR12MB6194.namprd12.prod.outlook.com>
References: <20240523150439.3274992-1-David.Wu3@amd.com>
In-Reply-To: <20240523150439.3274992-1-David.Wu3@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=0a73161c-cca8-45d1-8c68-1b3c671ed55b;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-05-23T16:01:46Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR12MB6194:EE_|CY8PR12MB9036:EE_
x-ms-office365-filtering-correlation-id: d085f7f5-56cf-4059-7bbb-08dc7b41cd7e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|366007|1800799015|376005|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?cKb+cLbGXZ+YLuyBuocITVljTT9bIKhoPmvaRXbvqy58hn8bux/MVOKVgz/8?=
 =?us-ascii?Q?t/fME+stw5x3kUCneNk5i7COnchzLfn5SSqwtIblfkS3ZHkOIV+UqT5FLUtv?=
 =?us-ascii?Q?XshAMxv2nZozA8nPxX81d8KID8rTbn5kDOnIrRZZhShzJIiPbkFQ4kHbKKjr?=
 =?us-ascii?Q?W8zEQw+mQsLEYTVFlcSArOaapvpK4utfmf4JsR1LcbYgh58FgbaAgSdCWTaR?=
 =?us-ascii?Q?fuSyOumgNhT8CaO7YCNBzwasSWltkgCY8xL2hNMvnzSkMhDHA92b7xLJu/ka?=
 =?us-ascii?Q?frJNKPbYbeYjT12mLspEuLnmVLWJjtWwvr4d/0VHDldc88Ba4rZV2M6kY6D1?=
 =?us-ascii?Q?03QiYGOa3/gjpEu+60fPLcwXnsTINWp6zjFJwYf+uUEiRndz3MmukKSxGxq1?=
 =?us-ascii?Q?4JcFlGaFRF1HYCYYJalyer/Zq1b9A0XExuD7Oh23YO1x+7pDyJZsTeSgP2nk?=
 =?us-ascii?Q?qazh3+hQs12Mp4jzgMKOBNAF/DUZlhwGK1oWTRq/0KTKYfh/nI2wm58JeDhV?=
 =?us-ascii?Q?OttPJ4dhZqcr4Y/1U71dpv97zeM/YLXM3/R/HdBrnRDSE86C46OeNoOhni+F?=
 =?us-ascii?Q?I7nYPafO5o4iPv2x/aO2H2oKftOP1vxaeY8Hgx2jX0duUGw1THH+k5USh3m9?=
 =?us-ascii?Q?xmG42GLEZp7/qo+4Koox9MvP5EHipBkDlJ+JiY/j94Jduh10dqJ1xudyQRWY?=
 =?us-ascii?Q?c/mT0fh0l53ZOmmY0RJtNnDxsXJWsix2+/caVTu+GMm0aIYf+vSYVt6z1P3S?=
 =?us-ascii?Q?7kIXQsoWIwtc1KlW3SD9ACnsEpK/sOBagQv59O307UyIV9Ge4qgiWnusfKPe?=
 =?us-ascii?Q?WZGFLs9csKy2dYS5FdINDO8Yj1kmZ984gq7/mqp6rO2+4uoB7sP6YkQZ6Pst?=
 =?us-ascii?Q?UTx4O6dDqrrMJf7e27QTkX4+4Poz0d3qm3bnU2vuOiXLI2jDVa0NS76I9p/A?=
 =?us-ascii?Q?+mKZkm3PxoHTTTRvqtWroNPKVXrUcClkrKb32RUfZJFkbEjIB2tsEDs57JSg?=
 =?us-ascii?Q?eqzACWBuHlTLav27kOB7FxRw7+MIMYGWi2r2gDuw+EAESzTS1V5A7LonY9U6?=
 =?us-ascii?Q?Qc9/U2ArlOi6vM7Mkg9min4DNdflw4Hg6VLXupZxKigK2aAfN/1INugHTEjy?=
 =?us-ascii?Q?I7mF4k2LaMGdLIinp1/M8174Bq/ZqZUpSV9e+CtBf9Yy0Fnt0t76JcCYr5Us?=
 =?us-ascii?Q?Ms4nS1VdTRKcO04PPPFEsTz2qt1nGNX5uLwGEMfi4fDbEAKWmM6CfFyPgv6H?=
 =?us-ascii?Q?mjOFLMMmLijCdBSCsjX5xKMjQFadadbwtWISv8e5je52fXinLZqsPw8MhfHq?=
 =?us-ascii?Q?LkBI76FCMjsciNvL3TS+pXXE5ADy2dyx6kSEOdrLPCY8EQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ1PR12MB6194.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?PbKAH5lq76Xg1BWeqwGi+a+LJQTz+MIXE4xNpkVzkNUiWTS/m9SPfNchc6e4?=
 =?us-ascii?Q?7+pWehvJJSwwF2srx4VaeS9ujZu+pESwnvfU0N5yPEvlKGWI1UuNVOltD7J0?=
 =?us-ascii?Q?DbR9xtS25Ke4kuKaiMeUT5rO8HKaNU/ya+SOR35CtFJ5SKQMFF2O1gQet7Mo?=
 =?us-ascii?Q?mvYBUas7x7o3DE2sqMnuHH5HP0V6MYvqCTPJXC0xgbjxjzUwbt5p/s5riCC3?=
 =?us-ascii?Q?XiFU7uZh6V2QABi/vJJGu4aubN/LlRK2jZMO08Huw048NuMDS1OivNNAZG/q?=
 =?us-ascii?Q?50c1z4ORX0Km0vY+qEBnVaL8A1NkEUkQr5mRglfgFDHXeT+mA208h5AC94D8?=
 =?us-ascii?Q?P/t69hpYKzU/xqadCyiwpHRtx/2+ywJegOowoHf4PQ11MCA78tvlMVnXPnPk?=
 =?us-ascii?Q?l3KIVLKA6s1K4tPh9/nOxfGKK+aVO9rsdM0m9FZx0nxPHWqiJMe6PMSUahwx?=
 =?us-ascii?Q?tKTCoCjK8pZzwOdm5ZNwcCtD2lW3YJzKWVLjthlXurs91eyMS2dvJ2ZlLvNF?=
 =?us-ascii?Q?IX5RpMc+PhbDGNijP3/uhfY6FXa4pk3YGWndN07t8nz0pj8fMIU15s6vQHHy?=
 =?us-ascii?Q?gv/ZEb/g6ZoTGEdmCGxFExrs80Sls8cp5QuNr6FuziyVEr8EN64o17OOhz4o?=
 =?us-ascii?Q?TfDC62pgU6CvDkKFliedcdXxGZKT0qOjJsPCOkaAPaHf9UloTfUZ6CYfdjrn?=
 =?us-ascii?Q?u6zr4g/EhdiiQjt94r2kqqGfKqQZwM4jSQOYB77dVy6sGg12OWWHUE5W4GJw?=
 =?us-ascii?Q?4lcldlXgDxhqHcBkL5xnJq0GqQZDK+m8pFYDDFUfSRDWoB860DghBrTmuYFn?=
 =?us-ascii?Q?t/r43scngT73c8iCu5tI9+cgNjzXoDkKMNNHt9y343DDPdqk6vRvoMt9w0tC?=
 =?us-ascii?Q?BaRZMNAEeQJyiDXccuJLGtzExT2kbqYGJirnLoXg6/a1di7s6esQudc+p6Hv?=
 =?us-ascii?Q?CHu9NhCYDjtgJzYSZsbMGVfKaab1A+Fx8qyozGcUpghtVk7xPB5ARcVgfVmX?=
 =?us-ascii?Q?HNQgOU68FQKJBMYLiL9jxINKnR8QEqSbgAomb4LE/6dr+xakg8qwK+eCnAvF?=
 =?us-ascii?Q?vt3j+ey35cICzDwYv8zatSMzOP3KTGNZ7JBqYmgGb7axr6YD6L5QOTXDaIOA?=
 =?us-ascii?Q?ZkI3NNSQ8ipnY1+Y0Ij6+sjyAhHwnGQjp9U9vhiksVdMg+oKfZj1+nuSDF3P?=
 =?us-ascii?Q?7ig7Uk2uDTSyFOGLd9S+KK25WrwxhEPLJzVGPta79QeHLmOKfSSRd2ghS/hT?=
 =?us-ascii?Q?oV8CopYLWyfoj/n7ge6f4sdPFKh+ScVKA9S95rx9zVFW82rIK4Mcs8/cwBqI?=
 =?us-ascii?Q?Vtn5peb0PzaYVBTYDe+6Z6d9e1Dhfg416GOU9L7PRsvl8AxjA8bHEt9e1NwP?=
 =?us-ascii?Q?zBqCBRjW4RqZV/AFto5Q5ueF11H2Tzg2iQXX3PL1vHQvrSU2Y0oKBf2FqnzL?=
 =?us-ascii?Q?5uXL0BonXUAzMmygBeEeNiLkMMR80Zd1TLfRaeWaO9zMwP0f7eIouhYxf+pG?=
 =?us-ascii?Q?LfO7w2SHA11RWevEyJXNDvAeec/qCrU2hUVND6HLfoDmAleQzB9zP/Jo9YdI?=
 =?us-ascii?Q?du+Ly7ZIlTrWGyf94uY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6194.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d085f7f5-56cf-4059-7bbb-08dc7b41cd7e
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 May 2024 16:02:53.0006 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CiNhMZFCfsClrHC8/7Ou4dKlfkgynmAvm62ZvDHFTIOlsyIwfB76LcA9Y0yeMj+E
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB9036
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

[AMD Official Use Only - AMD Internal Distribution Only]

Please see my question inline below.

Thanks,
Ruijing

-----Original Message-----
From: Wu, David <David.Wu3@amd.com>
Sent: Thursday, May 23, 2024 11:05 AM
To: amd-gfx@lists.freedesktop.org; Koenig, Christian <Christian.Koenig@amd.=
com>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Liu, Leo <Leo.Liu@amd.c=
om>; Jiang, Sonny <Sonny.Jiang@amd.com>; Dong, Ruijing <Ruijing.Dong@amd.co=
m>
Subject: [PATCH] drm/amdgpu: drop some kernel messages in VCN code

We have messages when the VCN fails to initialize and there is no need to r=
eport on success.
Also PSP loading FWs is the default for production.

Signed-off-by: David (Ming Qiang) Wu <David.Wu3@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c  |  1 -  drivers/gpu/drm/amd/amdgp=
u/jpeg_v5_0_0.c |  3 ---  drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c  | 10 +--=
-------
 3 files changed, 1 insertion(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_vcn.c
index b89605b400c0..5e2b7c340724 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -1078,7 +1078,6 @@ void amdgpu_vcn_setup_ucode(struct amdgpu_device *ade=
v)
                            IP_VERSION(4, 0, 3))
                                break;
                }
-               dev_info(adev->dev, "Will use PSP to load VCN firmware\n");
        }
 }

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c b/drivers/gpu/drm/amd=
/amdgpu/jpeg_v5_0_0.c
index 64c856bfe0cb..68ef29bc70e2 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
@@ -145,8 +145,6 @@ static int jpeg_v5_0_0_hw_init(void *handle)
        if (r)
                return r;

-       DRM_DEV_INFO(adev->dev, "JPEG decode initialized successfully.\n");
-
        return 0;
 }

@@ -549,7 +547,6 @@ static const struct amdgpu_ring_funcs jpeg_v5_0_0_dec_r=
ing_vm_funcs =3D {  static void jpeg_v5_0_0_set_dec_ring_funcs(struct amdgp=
u_device *adev)  {
        adev->jpeg.inst->ring_dec->funcs =3D &jpeg_v5_0_0_dec_ring_vm_funcs=
;
-       DRM_DEV_INFO(adev->dev, "JPEG decode is enabled in VM mode\n");
 }

 static const struct amdgpu_irq_src_funcs jpeg_v5_0_0_irq_funcs =3D { diff =
--git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c b/drivers/gpu/drm/amd/amdgp=
u/vcn_v5_0_0.c
index 36d4ca645c56..070b56610c7d 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
@@ -200,16 +200,10 @@ static int vcn_v5_0_0_hw_init(void *handle)

                r =3D amdgpu_ring_test_helper(ring);
                if (r)
-                       goto done;
+                       return r;
        }
 [Ruijing] Are we assuming the hw init process always be successful?
        return 0;
-done:
-       if (!r)
-               DRM_INFO("VCN decode and encode initialized successfully(un=
der %s).\n",
-                       (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG)?"DPG Mode=
":"SPG Mode");
-
-       return r;
 }

 /**
@@ -1122,8 +1116,6 @@ static void vcn_v5_0_0_set_unified_ring_funcs(struct =
amdgpu_device *adev)

                adev->vcn.inst[i].ring_enc[0].funcs =3D &vcn_v5_0_0_unified=
_ring_vm_funcs;
                adev->vcn.inst[i].ring_enc[0].me =3D i;
-
-               DRM_INFO("VCN(%d) encode/decode are enabled in VM mode\n", =
i);
        }
 }

--
2.34.1

