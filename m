Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57251C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Dec 2021 16:39:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EB78310E570;
	Fri, 17 Dec 2021 16:39:20 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2072.outbound.protection.outlook.com [40.107.237.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1068310E570
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Dec 2021 16:39:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bW18oAX5xvFhp6acroiiayQJ2+qJ4BQ2zQPOfoy4HPq3vwd3AL6rZWLKaxTcK38ai/3Wcmm/0H5v6Na2dn6H41DZIKYd3kDJE+8jBh0XvzqCqtOjwBZn9bi+X5Lc1/ib/PXE2XkKP3mfswZlJc8APD9Z/1edNY+8XN1Mum9N4MYWKRmjEo1uwql5yioFsSh8zot5/NLUW9QnUsoOEt6qipFwcSYkhN58yj5S2LNpwgWG9gInKP6sNcztQLdCLp9aSpsRTUE7OuA7xR6S6HyxQTck/nQw8GmxfG5BZPNoLfZ/+Kzq6Y4EEK18K/vKkYqsinc7RMLO4NZOPBR1KURMbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EpGnjr5H5tA/B3exYrG+uXDSx6HVwk6ZGsbtYVE8erY=;
 b=jCgaD6ByFs6XjDIdaWqyaXZy/VtKlXtlVxFnuLEhyOtYEk+kbtfuaL/NExuEk4uOBeVL3wzqBRcl+Bq858McLIlYh4hMRxe5VElirNodO7fBFrho5r7JAFFYRYTcg6mTbSWxtuUqH7oCoeAjG50s6vApVgKRpUjUrkYx8PseeB1Irqf8rHrGzG4qb9ed7E0uVzyT76y9Y30exVIx4MDUxIUVWxrBYdlFJMxGdPCV1T/b4oZaA2mxabbUjE+4moSQQep80pY5qroBmkkYjCdmZT9VMxVuWGRC3tK0UG7HvyhWj89boWdCaXrgCOipYtWStEoX7oJRo11YdI5u0JpXwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EpGnjr5H5tA/B3exYrG+uXDSx6HVwk6ZGsbtYVE8erY=;
 b=5VEhdpC1Hj9OXkZiE1sf9cE+J8J2/hIRMmPj2WNyV+MtQ/moxCiyMH5faxaR95OA0sdpsddYNxxPXSNyEJ3Cz82N5JZimdy8FyKJixCZI3irwTTxdkP5Sc/kK0FSpqV4aZcJMlETs32NvHnwNdaNOVJHywGGVbGm3at+bwoGkBc=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by BL1PR12MB5077.namprd12.prod.outlook.com (2603:10b6:208:310::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.17; Fri, 17 Dec
 2021 16:39:16 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::f170:3712:b17e:bd65]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::f170:3712:b17e:bd65%9]) with mapi id 15.20.4801.014; Fri, 17 Dec 2021
 16:39:15 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: ZhiJie.Zhang <zhangzhijie@loongson.cn>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu: Try To using WARN() instead BUG() avoid
 kernel panic
Thread-Topic: [PATCH] drm/amdgpu: Try To using WARN() instead BUG() avoid
 kernel panic
Thread-Index: AQHX8u88ofqL9FkkBE+Yxi2UHTSly6w24vi0
Date: Fri, 17 Dec 2021 16:39:15 +0000
Message-ID: <BL1PR12MB5144AD700F07EE3ECA1BA2B6F7789@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20211217023847.13379-1-zhangzhijie@loongson.cn>
In-Reply-To: <20211217023847.13379-1-zhangzhijie@loongson.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=True;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-12-17T16:39:15.244Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged; 
suggested_attachment_session_id: 689869d8-dfcf-1e62-f400-80f2e3558fe8
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0a26517a-747c-46e7-93a4-08d9c17bc3d1
x-ms-traffictypediagnostic: BL1PR12MB5077:EE_
x-microsoft-antispam-prvs: <BL1PR12MB5077F2004D7B86A154730EA2F7789@BL1PR12MB5077.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:439;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: q1yIbfayqY53HMiaN+KtfKtKF1meb2ws0m6XASDqq2q7de+48TNfQhxYbgSXcvYqbcUBj3K67bg52mPeQ/zBJt1X/wlKiity030gCAXnaG4m9jxwGf7CDl7N7dTxGGm/ZPEknMPrkqf2tYkLtxFYx9vTQ4hQZiaz2EPISCDdmdJOOPo6+GCnzLSU4hgSAWFa6CB5KgNPhk+dZJ9EWSmzLpIbafYAdOGTx+r06+JSQJgc0PTNmYK9Ys16fKw2qubZVEziCvpowWUJFvbARBrBYaU465CGjiw523l2PTOt6cH0OjyXImsHGkWhk3ZY6+Wg0wp9Mf7Viee4jTVMxtLQz5JnG9P45MzRDTf0Z0IY6AFLyKgoph/rzgR5GnjjCWXMtdI4xyMpJKJv6UzrlMRj4YGWDYW9SvpRWARTS6zwsFX8RKhTtMIj+/v6K1PudZLirSjpWyAg3joieG4ywadWk4V3lMx3cqFYewJ4TDmlcnlaitkx+j2M4YsBvLmkY98Fpa3v3pJmkA0bfYcjtEovoWWgNJQg2O46J4jeEZ3KMLrR633tQQpb7cwZ2g2V9Y7wf478R87XJWSXw5FFOdXvmln0JcgnBWYB5fWQwoycd/PgbLIBBVDvBp8FIZDTaBh8+L0KDy6NvnIJZAY+7HsGAkdkvR/z4T1g/MYeCOmHcbjxaNjA128dnljOUQUZimAEropWwZJUHmh8EHGeeVUE5w==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(38100700002)(186003)(86362001)(7696005)(8936002)(33656002)(508600001)(52536014)(71200400001)(8676002)(2906002)(122000001)(83380400001)(55016003)(53546011)(6506007)(38070700005)(66476007)(76116006)(4326008)(19627405001)(110136005)(66556008)(54906003)(26005)(64756008)(9686003)(316002)(66446008)(66946007)(5660300002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?x7SdquJQYd8WQATUILHsRkQIgcKbCXQeJ9bRa6KLjP8UDZ0+fdaC0KWDMs/o?=
 =?us-ascii?Q?7p9BDnNxZr8NNW/7wLfTVylxaGZuK1xcZV6QXWNSkhG+LuHzSip/piwLVwPy?=
 =?us-ascii?Q?r48sNV8v88hJ+g2wACdY0iEVcQeJC9P4Gzz0j0qVFDC5WYduOvAAHzN1ry38?=
 =?us-ascii?Q?d2yRPrKWg67agSi8dMDorMEIqdLq12kEAepXIf20IwT/7pCvCASkv9cKSZ78?=
 =?us-ascii?Q?DtVADwWWUuZw/uKGovVG45H7KnKgYqpWK3C2TJ/JF2qTugI1KMDKB3PoA2Ml?=
 =?us-ascii?Q?uzxTfIfpgfkVEZ3ZTXA1PkYIXTlHcRm2E5+vRqMcOU34umxHURPjtfR5Z/2Y?=
 =?us-ascii?Q?yRjfi6cRJzJnDXXch6IoT2ioE0ve/fdTkH1CiZvW7R8DUGTR1Gju9UtXqVe7?=
 =?us-ascii?Q?0tYhIpO14b8ilIb26Vpmjgt0NtiMqyT0bcdJwI44YGWX4f3H0hQ4qIZgkH0w?=
 =?us-ascii?Q?WCdTMJl4l3d53yyA6i1MW3NYT1bz8gBRB21Xt1NBRq2rtAcpkRZU1saWJft/?=
 =?us-ascii?Q?Ze1DUoNzCyMpdDiUGDcY9qt6KztlAV9EicEBHHU2vGpJLuZQL7bGMuEB55tK?=
 =?us-ascii?Q?UXsC9jxzvfcdfcOs89thKmBfXcNt7IfnAS+8SJdG54NLEITuCzHFlSIsQnpE?=
 =?us-ascii?Q?Hl/TrMcmuDIR2Iqn0RT7wGOCtyLl3XiaM/XQUysE7Mbf8dWcLHK7ZfegPgN1?=
 =?us-ascii?Q?HGEyhmKEv/A41jk+Dh4NgDZzfvMqiLEh1ltVXNLQ+lSWrDduDWHqZTwkWVp8?=
 =?us-ascii?Q?qG7yXS39aeeBKWIAcdCMl4h4gyL0ye/byLbLy9QSORpJPSs6xD2bZ5P7NWyy?=
 =?us-ascii?Q?s9ZkfyDZgwHbM0NTZitdSwhp9KToEtsv35bP+TygST95lWMOlGa/xQB8x2oU?=
 =?us-ascii?Q?X7eEN3OO8FFOijM/C0HYwy7EPo4LU4+cfbApt9vHYa6CoqtR5m2+NIxwc4s1?=
 =?us-ascii?Q?ECMnZMN487omZlGdhSNdpTiYMvoqlTzh+W4LfvDAGsxty+2wjbLSG3ObvGYj?=
 =?us-ascii?Q?ricB5hMOzEgksjEUxJkV7EOWVtxFwkdUQy5lSXvFNoDv7Zxq/Y6u+CpUmRbU?=
 =?us-ascii?Q?EMc90c939al5IxIVfhSnVUV/SGf+Ponbfl1vwRNniXTnqsvRgclMiHicUxie?=
 =?us-ascii?Q?J9pJ++nFE9e/JzEmrFdQ6UjLPc5vN6gQomkSnKS8l5rTOB6G4XiiYzsD9WQH?=
 =?us-ascii?Q?Ub3LsfP5By9Eci9YRcBGwyNiuNq9Q6x3q0AL/1Xxb56TIV3arJbFpNP5kQg6?=
 =?us-ascii?Q?dsuc2lDS6w0iPH2SPidK8NdEc+fMpek3j2hTdE5jdET0j8I/MZFvt3xwK1tn?=
 =?us-ascii?Q?NmZZZjaAbU8rbJ0hYWhO2r/qgkFKMlMu1yYpBj+us1LcjjD8F+CUJ8MdJ7vn?=
 =?us-ascii?Q?XfRc/kg5Pcrr13ezz9ifEXRQK/XCLwVZ4LwtIs3DjAcIJuHot+obl4O9C3Go?=
 =?us-ascii?Q?ddjK+7abFnJH5LJhml9s7Yu9nH7RGpEnHf7KOoPBppng2dzjBaB75TNvxNW/?=
 =?us-ascii?Q?74IgS7sxJiWRMfpTwwBidcSpRXjB0nbD6LFyKdApvFxN8m+67lLB4jsSXoqw?=
 =?us-ascii?Q?Bw636lk4wrETzCLRvyin0HDdOmLaidRlyK4n5TaIfjHPLFKW0mUixS9JZ7Q9?=
 =?us-ascii?Q?db+ktECMuFv33E6khqwq6z0=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB5144AD700F07EE3ECA1BA2B6F7789BL1PR12MB5144namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a26517a-747c-46e7-93a4-08d9c17bc3d1
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Dec 2021 16:39:15.8659 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xrYDCZiLknoNOEfzI+UB+Wpva5Ufb3WAM3P93WLOxZdkpaM6zUCRrgvJAT4a7bpkf68+uN8zq3bgSnR6psultw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5077
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
Cc: "airlied@linux.ie" <airlied@linux.ie>,
 "Jack.Zhang1@amd.com" <Jack.Zhang1@amd.com>,
 "botton_zhang@163.com" <botton_zhang@163.com>,
 "daniel@ffwll.ch" <daniel@ffwll.ch>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_BL1PR12MB5144AD700F07EE3ECA1BA2B6F7789BL1PR12MB5144namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[Public]

I think these are pretty fundamental errors.  You should never hit them in =
practice and if you do, I think a BUG is fine.

Alex

________________________________
From: ZhiJie.Zhang <zhangzhijie@loongson.cn>
Sent: Thursday, December 16, 2021 9:38 PM
To: Koenig, Christian <Christian.Koenig@amd.com>; Deucher, Alexander <Alexa=
nder.Deucher@amd.com>; amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedes=
ktop.org>
Cc: zhangzhijie@loongson.cn <zhangzhijie@loongson.cn>; botton_zhang@163.com=
 <botton_zhang@163.com>; airlied@linux.ie <airlied@linux.ie>; daniel@ffwll.=
ch <daniel@ffwll.ch>; Jack.Zhang1@amd.com <Jack.Zhang1@amd.com>
Subject: [PATCH] drm/amdgpu: Try To using WARN() instead BUG() avoid kernel=
 panic

Signed-off-by: ZhiJie.Zhang <zhangzhijie@loongson.cn>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cgs.c    |  4 +--
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 31 +++++++++++++++-------
 drivers/gpu/drm/amd/amdgpu/cik_sdma.c      |  5 +++-
 drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c      | 18 +++++++++----
 4 files changed, 41 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cgs.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_cgs.c
index f1a050379190..edf2de4cec8c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cgs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cgs.c
@@ -76,7 +76,7 @@ static uint32_t amdgpu_cgs_read_ind_register(struct cgs_d=
evice *cgs_device,
                 DRM_ERROR("audio endpt register access not implemented.\n"=
);
                 return 0;
         default:
-               BUG();
+               adev->accel_working =3D false;
         }
         WARN(1, "Invalid indirect register space");
         return 0;
@@ -104,9 +104,9 @@ static void amdgpu_cgs_write_ind_register(struct cgs_de=
vice *cgs_device,
                 DRM_ERROR("audio endpt register access not implemented.\n"=
);
                 return;
         default:
-               BUG();
         }
         WARN(1, "Invalid indirect register space");
+       adev->accel_working =3D false;
 }

 static uint32_t fw_type_convert(struct cgs_device *cgs_device, uint32_t fw=
_type)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c
index 188accb71249..b9ecf7f70409 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -488,7 +488,11 @@ uint8_t amdgpu_mm_rreg8(struct amdgpu_device *adev, ui=
nt32_t offset)

         if (offset < adev->rmmio_size)
                 return (readb(adev->rmmio + offset));
-       BUG();
+
+       WARN(1, "Invalid indirect register space");
+       adev->accel_working =3D false;
+
+       return 0;
 }

 /*
@@ -513,8 +517,10 @@ void amdgpu_mm_wreg8(struct amdgpu_device *adev, uint3=
2_t offset, uint8_t value)

         if (offset < adev->rmmio_size)
                 writeb(value, adev->rmmio + offset);
-       else
-               BUG();
+       else {
+               WARN(1, "Invalid indirect register space");
+               adev->accel_working =3D false;
+       }
 }

 /**
@@ -803,7 +809,8 @@ void amdgpu_device_indirect_wreg64(struct amdgpu_device=
 *adev,
 static uint32_t amdgpu_invalid_rreg(struct amdgpu_device *adev, uint32_t r=
eg)
 {
         DRM_ERROR("Invalid callback to read register 0x%04X\n", reg);
-       BUG();
+
+       adev->accel_working =3D false;
         return 0;
 }

@@ -821,7 +828,8 @@ static void amdgpu_invalid_wreg(struct amdgpu_device *a=
dev, uint32_t reg, uint32
 {
         DRM_ERROR("Invalid callback to write register 0x%04X with 0x%08X\n=
",
                   reg, v);
-       BUG();
+
+       adev->accel_working =3D false;
 }

 /**
@@ -837,7 +845,8 @@ static void amdgpu_invalid_wreg(struct amdgpu_device *a=
dev, uint32_t reg, uint32
 static uint64_t amdgpu_invalid_rreg64(struct amdgpu_device *adev, uint32_t=
 reg)
 {
         DRM_ERROR("Invalid callback to read 64 bit register 0x%04X\n", reg=
);
-       BUG();
+
+       adev->accel_working =3D false;
         return 0;
 }

@@ -855,7 +864,8 @@ static void amdgpu_invalid_wreg64(struct amdgpu_device =
*adev, uint32_t reg, uint
 {
         DRM_ERROR("Invalid callback to write 64 bit register 0x%04X with 0=
x%08llX\n",
                   reg, v);
-       BUG();
+
+       adev->accel_working =3D false;
 }

 /**
@@ -874,7 +884,9 @@ static uint32_t amdgpu_block_invalid_rreg(struct amdgpu=
_device *adev,
 {
         DRM_ERROR("Invalid callback to read register 0x%04X in block 0x%04=
X\n",
                   reg, block);
-       BUG();
+
+       adev->accel_working =3D false;
+
         return 0;
 }

@@ -895,7 +907,8 @@ static void amdgpu_block_invalid_wreg(struct amdgpu_dev=
ice *adev,
 {
         DRM_ERROR("Invalid block callback to write register 0x%04X in bloc=
k 0x%04X with 0x%08X\n",
                   reg, block, v);
-       BUG();
+
+       adev->accel_working =3D false;
 }

 /**
diff --git a/drivers/gpu/drm/amd/amdgpu/cik_sdma.c b/drivers/gpu/drm/amd/am=
dgpu/cik_sdma.c
index c8ebd108548d..957169142e57 100644
--- a/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
@@ -129,7 +129,10 @@ static int cik_sdma_init_microcode(struct amdgpu_devic=
e *adev)
         case CHIP_MULLINS:
                 chip_name =3D "mullins";
                 break;
-       default: BUG();
+       default:
+               DRM_ERROR("Invalid CHIPS");
+               err =3D -EINVAL;
+               goto out;
         }

         for (i =3D 0; i < adev->sdma.num_instances; i++) {
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c b/drivers/gpu/drm/amd/am=
dgpu/gfx_v6_0.c
index 6a8dadea40f9..e312a2146f6f 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
@@ -334,7 +334,10 @@ static int gfx_v6_0_init_microcode(struct amdgpu_devic=
e *adev)
         case CHIP_HAINAN:
                 chip_name =3D "hainan";
                 break;
-       default: BUG();
+       default:
+               DRM_ERROR("Invalid CHIPS");
+               err =3D -EINVAL;
+               goto out;
         }

         snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_pfp.bin", chip_name)=
;
@@ -1668,8 +1671,8 @@ static void gfx_v6_0_constants_init(struct amdgpu_dev=
ice *adev)
                 gb_addr_config =3D HAINAN_GB_ADDR_CONFIG_GOLDEN;
                 break;
         default:
-               BUG();
-               break;
+               DRM_ERROR("Invalid CHIPS");
+               return;
         }

         WREG32(mmGRBM_CNTL, (0xff << GRBM_CNTL__READ_TIMEOUT__SHIFT));
@@ -2153,7 +2156,10 @@ static u64 gfx_v6_0_ring_get_wptr(struct amdgpu_ring=
 *ring)
         else if (ring =3D=3D &adev->gfx.compute_ring[1])
                 return RREG32(mmCP_RB2_WPTR);
         else
-               BUG();
+               WARN(1, "Invalid Ring Buffer");
+
+       adev->accel_working =3D false;
+       return -EINVAL;
 }

 static void gfx_v6_0_ring_set_wptr_gfx(struct amdgpu_ring *ring)
@@ -2175,7 +2181,9 @@ static void gfx_v6_0_ring_set_wptr_compute(struct amd=
gpu_ring *ring)
                 WREG32(mmCP_RB2_WPTR, lower_32_bits(ring->wptr));
                 (void)RREG32(mmCP_RB2_WPTR);
         } else {
-               BUG();
+               WARN(1, "Invalid Ring Buffer");
+
+               adev->accel_working =3D false;
         }

 }
--
2.34.0


--_000_BL1PR12MB5144AD700F07EE3ECA1BA2B6F7789BL1PR12MB5144namp_
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
I think these are pretty fundamental errors.&nbsp; You should never hit the=
m in practice and if you do, I think a BUG is fine.</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
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
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> ZhiJie.Zhang &lt;zhan=
gzhijie@loongson.cn&gt;<br>
<b>Sent:</b> Thursday, December 16, 2021 9:38 PM<br>
<b>To:</b> Koenig, Christian &lt;Christian.Koenig@amd.com&gt;; Deucher, Ale=
xander &lt;Alexander.Deucher@amd.com&gt;; amd-gfx@lists.freedesktop.org &lt=
;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Cc:</b> zhangzhijie@loongson.cn &lt;zhangzhijie@loongson.cn&gt;; botton_=
zhang@163.com &lt;botton_zhang@163.com&gt;; airlied@linux.ie &lt;airlied@li=
nux.ie&gt;; daniel@ffwll.ch &lt;daniel@ffwll.ch&gt;; Jack.Zhang1@amd.com &l=
t;Jack.Zhang1@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: Try To using WARN() instead BUG() avoid=
 kernel panic</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Signed-off-by: ZhiJie.Zhang &lt;zhangzhijie@loongs=
on.cn&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_cgs.c&nbsp;&nbsp;&nbsp; |&nbsp; 4 +=
--<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 31 +++++++++++++++------=
-<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/cik_sdma.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |=
&nbsp; 5 +++-<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |=
 18 +++++++++----<br>
&nbsp;4 files changed, 41 insertions(+), 17 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cgs.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_cgs.c<br>
index f1a050379190..edf2de4cec8c 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cgs.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cgs.c<br>
@@ -76,7 +76,7 @@ static uint32_t amdgpu_cgs_read_ind_register(struct cgs_d=
evice *cgs_device,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; DRM_ERROR(&quot;audio endpt register access not imple=
mented.\n&quot;);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; BUG();<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; adev-&gt;accel_working =3D false;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WARN(1, &quot;Invalid indi=
rect register space&quot;);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
@@ -104,9 +104,9 @@ static void amdgpu_cgs_write_ind_register(struct cgs_de=
vice *cgs_device,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; DRM_ERROR(&quot;audio endpt register access not imple=
mented.\n&quot;);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; BUG();<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WARN(1, &quot;Invalid indi=
rect register space&quot;);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;accel_working =3D false;<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;static uint32_t fw_type_convert(struct cgs_device *cgs_device, uint32=
_t fw_type)<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c<br>
index 188accb71249..b9ecf7f70409 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
@@ -488,7 +488,11 @@ uint8_t amdgpu_mm_rreg8(struct amdgpu_device *adev, ui=
nt32_t offset)<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (offset &lt; adev-&gt;r=
mmio_size)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return (readb(adev-&gt;rmmio + offset));<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BUG();<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WARN(1, &quot;Invalid indirect regist=
er space&quot;);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;accel_working =3D false;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;/*<br>
@@ -513,8 +517,10 @@ void amdgpu_mm_wreg8(struct amdgpu_device *adev, uint3=
2_t offset, uint8_t value)<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (offset &lt; adev-&gt;r=
mmio_size)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; writeb(value, adev-&gt;rmmio + offset);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; BUG();<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; WARN(1, &quot;Invalid indirect register space&quot;);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; adev-&gt;accel_working =3D false;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;/**<br>
@@ -803,7 +809,8 @@ void amdgpu_device_indirect_wreg64(struct amdgpu_device=
 *adev,<br>
&nbsp;static uint32_t amdgpu_invalid_rreg(struct amdgpu_device *adev, uint3=
2_t reg)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_ERROR(&quot;Invalid ca=
llback to read register 0x%04X\n&quot;, reg);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BUG();<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;accel_working =3D false;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
&nbsp;<br>
@@ -821,7 +828,8 @@ static void amdgpu_invalid_wreg(struct amdgpu_device *a=
dev, uint32_t reg, uint32<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_ERROR(&quot;Invalid ca=
llback to write register 0x%04X with 0x%08X\n&quot;,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reg, v);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BUG();<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;accel_working =3D false;<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;/**<br>
@@ -837,7 +845,8 @@ static void amdgpu_invalid_wreg(struct amdgpu_device *a=
dev, uint32_t reg, uint32<br>
&nbsp;static uint64_t amdgpu_invalid_rreg64(struct amdgpu_device *adev, uin=
t32_t reg)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_ERROR(&quot;Invalid ca=
llback to read 64 bit register 0x%04X\n&quot;, reg);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BUG();<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;accel_working =3D false;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
&nbsp;<br>
@@ -855,7 +864,8 @@ static void amdgpu_invalid_wreg64(struct amdgpu_device =
*adev, uint32_t reg, uint<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_ERROR(&quot;Invalid ca=
llback to write 64 bit register 0x%04X with 0x%08llX\n&quot;,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reg, v);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BUG();<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;accel_working =3D false;<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;/**<br>
@@ -874,7 +884,9 @@ static uint32_t amdgpu_block_invalid_rreg(struct amdgpu=
_device *adev,<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_ERROR(&quot;Invalid ca=
llback to read register 0x%04X in block 0x%04X\n&quot;,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reg, block);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BUG();<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;accel_working =3D false;<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
&nbsp;<br>
@@ -895,7 +907,8 @@ static void amdgpu_block_invalid_wreg(struct amdgpu_dev=
ice *adev,<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_ERROR(&quot;Invalid bl=
ock callback to write register 0x%04X in block 0x%04X with 0x%08X\n&quot;,<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reg, block, v);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BUG();<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;accel_working =3D false;<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;/**<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/cik_sdma.c b/drivers/gpu/drm/amd/am=
dgpu/cik_sdma.c<br>
index c8ebd108548d..957169142e57 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/cik_sdma.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/cik_sdma.c<br>
@@ -129,7 +129,10 @@ static int cik_sdma_init_microcode(struct amdgpu_devic=
e *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_MULLINS:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; chip_name =3D &quot;mullins&quot;;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default: BUG();<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; DRM_ERROR(&quot;Invalid CHIPS&quot;);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; err =3D -EINVAL;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; goto out;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; adev-=
&gt;sdma.num_instances; i++) {<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c b/drivers/gpu/drm/amd/am=
dgpu/gfx_v6_0.c<br>
index 6a8dadea40f9..e312a2146f6f 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c<br>
@@ -334,7 +334,10 @@ static int gfx_v6_0_init_microcode(struct amdgpu_devic=
e *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_HAINAN:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; chip_name =3D &quot;hainan&quot;;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default: BUG();<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; DRM_ERROR(&quot;Invalid CHIPS&quot;);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; err =3D -EINVAL;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; goto out;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; snprintf(fw_name, sizeof(f=
w_name), &quot;amdgpu/%s_pfp.bin&quot;, chip_name);<br>
@@ -1668,8 +1671,8 @@ static void gfx_v6_0_constants_init(struct amdgpu_dev=
ice *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; gb_addr_config =3D HAINAN_GB_ADDR_CONFIG_GOLDEN;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; BUG();<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; break;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; DRM_ERROR(&quot;Invalid CHIPS&quot;);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(mmGRBM_CNTL, (0xff =
&lt;&lt; GRBM_CNTL__READ_TIMEOUT__SHIFT));<br>
@@ -2153,7 +2156,10 @@ static u64 gfx_v6_0_ring_get_wptr(struct amdgpu_ring=
 *ring)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else if (ring =3D=3D &amp;=
adev-&gt;gfx.compute_ring[1])<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return RREG32(mmCP_RB2_WPTR);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; BUG();<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; WARN(1, &quot;Invalid Ring Buffer&quot;);<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;accel_working =3D false;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;static void gfx_v6_0_ring_set_wptr_gfx(struct amdgpu_ring *ring)<br>
@@ -2175,7 +2181,9 @@ static void gfx_v6_0_ring_set_wptr_compute(struct amd=
gpu_ring *ring)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; WREG32(mmCP_RB2_WPTR, lower_32_bits(ring-&gt;wptr));<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; (void)RREG32(mmCP_RB2_WPTR);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; BUG();<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; WARN(1, &quot;Invalid Ring Buffer&quot;);<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; adev-&gt;accel_working =3D false;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;}<br>
-- <br>
2.34.0<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BL1PR12MB5144AD700F07EE3ECA1BA2B6F7789BL1PR12MB5144namp_--
