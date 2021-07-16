Return-Path: <SRS0=OLwD=MI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6536DC07E95
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Jul 2021 13:53:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22E5E613BB
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Jul 2021 13:53:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22E5E613BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D75706E987;
	Fri, 16 Jul 2021 13:53:21 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2069.outbound.protection.outlook.com [40.107.244.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E7F686E987
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Jul 2021 13:53:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ET3GJUtF/pM2n0PliI2fgkrO1boj2s19ylYZy8APZUeNT+gkMx/SyU6v262j/8ZTIkmcSapeTH2NJLPpI5eGDndO77bJ5UW0+fQMzKsCX97k/94T3e2dNpvSHWU/m1GYrJlFPJB7tv2DT3KKGizUThcGD5hwon3rNPXpVVBxqCVUH49vq+ThhRYgv8xh94/ElR075Ywx6om+Lr/pFFNPWLDgUrYCTHyHMJSrPgv3dLyoaPRfMhmwxNt9kpj53zOVL7YvJ7ylS3s1slzXqwNF5IQUtUNjh3tkfqGJbFJPqAkviQIllH5IzelWqtIb16UM8m5HzSFZ9Xrao3DdsPlzmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fq6Yp2vWgfr4VvdkUJ228c6f6F3HHfUy+hs3aOIUnSU=;
 b=Ie1/kxqe2/Qljy9ACKIpsDrObWkhmlBGCvLkkWWhiO2Es548HWOQDoaTpGP0gNIHDccgPyHlDU5WK4FEoQO3SEiZPl4+GH+lEvQ2LvDsGJaR4zpRUWS+Q2JXbWcEstBZ8Vh8f5fZcj9SsO4oi1gAq4dYqo1Q/f4TipUZIChE5sB/xFHempWOJZl6oTzHOm9YJuApDCVBHbAbklMarGkXQmdu4ovdAR4G9SzCdn/IeCKUYivRmKwXJhksfiow3yemd2QPhD9ZzlLIeHXFHm1MqKSPxqJQBToCbOtNRcj++Konhn9kQwJC8np1sEwtkcKZa2lDOxa7lD1TMu2ZMwnMNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fq6Yp2vWgfr4VvdkUJ228c6f6F3HHfUy+hs3aOIUnSU=;
 b=B9jKqC4AFbA58bQcqOmyoP+9Gj4O9dlQ9kMgRlV4r2gxIJ78aS0EdSxAldvIzOk22zVuTwIGU45vUJs3mG5h/rMUcSj1zJ0DWm/tcjmeZFHFKfP08TvIOcfrTqPNu370HUck5xndNrXKqLT7f04DbWIpwRIGMetIoPF3ieKEwNQ=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by BL1PR12MB5303.namprd12.prod.outlook.com (2603:10b6:208:317::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.23; Fri, 16 Jul
 2021 13:53:18 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::8cb6:59d6:24d0:4dc3]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::8cb6:59d6:24d0:4dc3%9]) with mapi id 15.20.4331.028; Fri, 16 Jul 2021
 13:53:18 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Zeng, Oak" <Oak.Zeng@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 1/5] drm/amdgpu: Fix a printing message
Thread-Topic: [PATCH 1/5] drm/amdgpu: Fix a printing message
Thread-Index: AQHXeeF4qLxJaovb8UmOObUJbgtGx6tFoAB7
Date: Fri, 16 Jul 2021 13:53:18 +0000
Message-ID: <BL1PR12MB514416C6EDCBFD9AEE448000F7119@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <1626398715-6419-1-git-send-email-Oak.Zeng@amd.com>,
 <1626398715-6419-2-git-send-email-Oak.Zeng@amd.com>
In-Reply-To: <1626398715-6419-2-git-send-email-Oak.Zeng@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=True;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-07-16T13:53:17.766Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f0b059f4-1566-4ce5-e541-08d94861110d
x-ms-traffictypediagnostic: BL1PR12MB5303:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL1PR12MB5303CCB02513EBFE2A374B0DF7119@BL1PR12MB5303.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zJDzcCiaxV5gRcKGnLEuZzoEyS+HTcLMzRh3sIUu4dAX6MMZooZKaYbbh+RzjUw4hYMq2x8wb3VhMgNcMlg/7afnnU3k5NaD38oPvP607bsbTsT4SmFNvIpcLiAcmlggLWEwnv7d0WuVQirFR6e+dNV9FzKeOafJUXgbQSYe7kQ+DHa8YdeG1El15UDbxJry4PEGAiOrZHIr1KCtLfGUh9Utn4Omy71FeDqIVULydcVZ6GBReiSu862gjkmRWp1uvfU6KrQknqN9Obu93frp6llzEWTESEZh5GM1qCh5nqvlHcyr69rEo/+ezPNpvId6bwvXQh0ZKJANEgS25K+Dl3pOI0gdEM90uD4A4ycnSt4lQEyNl7mnjwn5c3YahVezOZiKtCGZgJpyFLamBOkYaHVwJwn0XjvcWN/Nj4roBL8RRPUTn/Rr5qudb8gS/n1ErBBin4x1zfsRX83U9w/wZ5gvGvAnG80vWFpjPDh2sJJo6y+mcqeESCLIN/VxT5qmlTIeM8ivlkCWznRkPc1m5mxCIw1+l4jHLlIZ7Ui3dCnK2F2Wskpr8wtayzBiCrWPo7fQosQIzc/UpBvfd4FWPjQyeURnWMYpWwxEnx/caXnVFPAE9j+Vxqezd4JsfptP16N8tcgcfEejVg1UocR6kNussFV08kLofGRtgBIwOX20RLm9/7kh/DnWPXG/pWirkv2T6JoCxFqeUNNxNBzZHA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(39860400002)(376002)(136003)(396003)(346002)(66946007)(71200400001)(76116006)(54906003)(33656002)(110136005)(186003)(52536014)(478600001)(45080400002)(86362001)(19627405001)(2906002)(15650500001)(64756008)(26005)(66556008)(66446008)(316002)(66476007)(4326008)(166002)(6506007)(55016002)(83380400001)(38100700002)(53546011)(122000001)(8936002)(8676002)(9686003)(966005)(7696005)(5660300002)(38070700004);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?tT0YtmN85/+nNDDPEUsvMAtZTiEEA6Jp1qJslyGjrd2nNnVdibhUIIzIwL7m?=
 =?us-ascii?Q?PNxlnsf2169Wfu8zdZKgpQAxZRgEm2cDbuh17KbIMvUWhvmLTzJawX/m35aQ?=
 =?us-ascii?Q?kGWju0Irdnh1+rOmDN9LFd9we1VyeFfQyHdaR/rUHaVYDCrzSFgRjUZIUQ7c?=
 =?us-ascii?Q?+2rgoOIFLhQvC0rkyZjNEjQ1mlirYXflLbRWfm9XDXU6x2jRFhlu1VlgN2Xl?=
 =?us-ascii?Q?vD0Df+uKuvsE6jicIaEKX8cWqXQhzC9FWoYByxh/Ym9g+kpk61/bOE9HgjGZ?=
 =?us-ascii?Q?KvYzqmlbVbmz1yK0QHhYlOhtRb/s8PUA5VnAgDUDPjJXGk2hgi/mVMo22hgA?=
 =?us-ascii?Q?gOdukov/+Sx1sVw9uT9mHhIpqj4U7rchjb9UIxUoKE3vgTenPD0Ij2zHDHve?=
 =?us-ascii?Q?wolwSufRl6y/TDcWKBuhd8z+ytOccRWKRN8H3F+FBcqG7VNS2R4Zb5tpXYTq?=
 =?us-ascii?Q?ZgxdY7KujNSxu25VCW4rwIkqUREYzSJvAWmTxOmq7WRhNFWMS7gBLY3irf0n?=
 =?us-ascii?Q?B1QyrcCUGgX38mDBTsf+ccP0ZwyirfxyFRfn1hRN4vzX+NcI4hFVM8wwk4tz?=
 =?us-ascii?Q?H8s02PCRFdRP7p+HnMcJeCtLbcUDGVq+gvU2gMPxDAD16SWLrjsoyadgHksw?=
 =?us-ascii?Q?bUoNm0MEOOjUPsynKQaK0aFhGR9kmhFdtfcp/xuCaM0VX3eCDFq5dP/17Zv8?=
 =?us-ascii?Q?8t3N6IZ6SJ2Cj6idG4s0WdTKC4LY6V4kAvGp8nEanFJG4eWwPty0beMIZw8d?=
 =?us-ascii?Q?grheE/YHzrlcNkLnhR8m90ImGlohHqScENo6nnpzpxYUFu4bBJciA4NdpumP?=
 =?us-ascii?Q?++JADfbWuNCX/JGRDZyyDqw+YBrlB+fHcmEucVQYAw7wstAZbyM0A+mWgjMe?=
 =?us-ascii?Q?Z7Xab0XKweHKiVmxTNHdich54Bb9r6BPXzvURr4laaecwe9AKPLY2NdjXMcu?=
 =?us-ascii?Q?8gT4XmCQ+r/Cg5k10iZ3H+mbSvuYH4vLLrzgvBQOeiTDIzfXV6hiF+vssN+G?=
 =?us-ascii?Q?DWnxSeHkx/KRODLp+iC+so7cj7EQZNtau/v8tzbrz+PTF8zwBlO7yt85LW0x?=
 =?us-ascii?Q?UQOewH+taxv/9GPx9seS0bqEa3myk/H7s9F8PD9pdKC6daHNAdN1KxILLU7z?=
 =?us-ascii?Q?RyXMZLT1BsGOOtCcVP7uT2vFN5qPpQ/G66ZA9jbqPvSc+hEPyvwoGWdtm+ar?=
 =?us-ascii?Q?/kLQ35CY6FoEX7ijHmeUbfhBmCNgBNY/Ef/XjHmjyIouBXF/eSky1r/It//F?=
 =?us-ascii?Q?Gw9G6CI32Y94YzUF6qvlWBFoNfWXRwHhko4gnGKc3VzVNGMrPTYvtwt+K43K?=
 =?us-ascii?Q?Xj2a3RXzUh/vqAAHUYOWTlfn?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0b059f4-1566-4ce5-e541-08d94861110d
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jul 2021 13:53:18.3353 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: r5zw6NirIcYtSAZRC+DwwRc97gxiQORbHYZYmwfBc9anyIe3Yy+MR65+XVfNzOs1f7NP3M+Vwwq9EseK4N76+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5303
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
Cc: "Xu, Feifei" <Feifei.Xu@amd.com>, "Kuehling,
 Felix" <Felix.Kuehling@amd.com>, "Liu, Leo" <Leo.Liu@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Content-Type: multipart/mixed; boundary="===============0401292574=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0401292574==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BL1PR12MB514416C6EDCBFD9AEE448000F7119BL1PR12MB5144namp_"

--_000_BL1PR12MB514416C6EDCBFD9AEE448000F7119BL1PR12MB5144namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[Public]

Please use dev_info rather than DRM_INFO.

Alex

________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Oak Zeng=
 <Oak.Zeng@amd.com>
Sent: Thursday, July 15, 2021 9:25 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Xu, Feifei <Feifei.Xu@amd.com>; Kuehling, Felix <Felix.Kuehling@amd.com=
>; Liu, Leo <Leo.Liu@amd.com>; Zeng, Oak <Oak.Zeng@amd.com>; Zhang, Hawking=
 <Hawking.Zhang@amd.com>
Subject: [PATCH 1/5] drm/amdgpu: Fix a printing message

The printing message "PSP loading VCN firmware" is mis-leading because
people might think driver is loading VCN firmware. Actually when this
message is printed, driver is just preparing some VCN ucode, not loading
VCN firmware yet. The actual VCN firmware loading will be in the PSP block
hw_init. Fix the printing message

Signed-off-by: Oak Zeng <Oak.Zeng@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c | 2 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c | 2 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c | 2 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c b/drivers/gpu/drm/amd/am=
dgpu/vcn_v1_0.c
index 284bb42..1f8e902 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
@@ -119,7 +119,7 @@ static int vcn_v1_0_sw_init(void *handle)
                 adev->firmware.ucode[AMDGPU_UCODE_ID_VCN].fw =3D adev->vcn=
.fw;
                 adev->firmware.fw_size +=3D
                         ALIGN(le32_to_cpu(hdr->ucode_size_bytes), PAGE_SIZ=
E);
-               DRM_INFO("PSP loading VCN firmware\n");
+               DRM_INFO("VCN 1.0: Will use PSP to load VCN firmware\n");
         }

         r =3D amdgpu_vcn_resume(adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c b/drivers/gpu/drm/amd/am=
dgpu/vcn_v2_0.c
index 8af567c..ebe4f2b 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
@@ -122,7 +122,7 @@ static int vcn_v2_0_sw_init(void *handle)
                 adev->firmware.ucode[AMDGPU_UCODE_ID_VCN].fw =3D adev->vcn=
.fw;
                 adev->firmware.fw_size +=3D
                         ALIGN(le32_to_cpu(hdr->ucode_size_bytes), PAGE_SIZ=
E);
-               DRM_INFO("PSP loading VCN firmware\n");
+               DRM_INFO("VCN 2.0: Will use PSP to load VCN firmware\n");
         }

         r =3D amdgpu_vcn_resume(adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/am=
dgpu/vcn_v2_5.c
index 888b17d..5741504 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
@@ -152,7 +152,7 @@ static int vcn_v2_5_sw_init(void *handle)
                         adev->firmware.fw_size +=3D
                                 ALIGN(le32_to_cpu(hdr->ucode_size_bytes), =
PAGE_SIZE);
                 }
-               DRM_INFO("PSP loading VCN firmware\n");
+               DRM_INFO("VCN 2.5: Will use PSP to load VCN firmware\n");
         }

         r =3D amdgpu_vcn_resume(adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/am=
dgpu/vcn_v3_0.c
index c3580de..b81eae3 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
@@ -158,7 +158,7 @@ static int vcn_v3_0_sw_init(void *handle)
                         adev->firmware.fw_size +=3D
                                 ALIGN(le32_to_cpu(hdr->ucode_size_bytes), =
PAGE_SIZE);
                 }
-               DRM_INFO("PSP loading VCN firmware\n");
+               DRM_INFO("VCN 3.0: Will use PSP to load VCN firmware\n");
         }

         r =3D amdgpu_vcn_resume(adev);
--
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D04%7C01%7Calexande=
r.deucher%40amd.com%7C18117b603e8044be99c708d947f898f7%7C3dd8961fe4884e608e=
11a82d994e183d%7C0%7C0%7C637619955325132066%7CUnknown%7CTWFpbGZsb3d8eyJWIjo=
iMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdat=
a=3Dh5P5Asi3pBpWlB2o9xeq7Bjm7lBbRVJPyTY3aa%2B9O60%3D&amp;reserved=3D0

--_000_BL1PR12MB514416C6EDCBFD9AEE448000F7119BL1PR12MB5144namp_
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
Please use dev_info rather than DRM_INFO.</div>
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
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Oak Zeng &lt;Oak.Zeng@amd.com=
&gt;<br>
<b>Sent:</b> Thursday, July 15, 2021 9:25 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Xu, Feifei &lt;Feifei.Xu@amd.com&gt;; Kuehling, Felix &lt;Felix.=
Kuehling@amd.com&gt;; Liu, Leo &lt;Leo.Liu@amd.com&gt;; Zeng, Oak &lt;Oak.Z=
eng@amd.com&gt;; Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;<br>
<b>Subject:</b> [PATCH 1/5] drm/amdgpu: Fix a printing message</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">The printing message &quot;PSP loading VCN firmwar=
e&quot; is mis-leading because<br>
people might think driver is loading VCN firmware. Actually when this<br>
message is printed, driver is just preparing some VCN ucode, not loading<br=
>
VCN firmware yet. The actual VCN firmware loading will be in the PSP block<=
br>
hw_init. Fix the printing message<br>
<br>
Signed-off-by: Oak Zeng &lt;Oak.Zeng@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c | 2 +-<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c | 2 +-<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c | 2 +-<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c | 2 +-<br>
&nbsp;4 files changed, 4 insertions(+), 4 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c b/drivers/gpu/drm/amd/am=
dgpu/vcn_v1_0.c<br>
index 284bb42..1f8e902 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c<br>
@@ -119,7 +119,7 @@ static int vcn_v1_0_sw_init(void *handle)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; adev-&gt;firmware.ucode[AMDGPU_UCODE_ID_VCN].fw =3D a=
dev-&gt;vcn.fw;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; adev-&gt;firmware.fw_size +=3D<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ALIGN=
(le32_to_cpu(hdr-&gt;ucode_size_bytes), PAGE_SIZE);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; DRM_INFO(&quot;PSP loading VCN firmware\n&quot;);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; DRM_INFO(&quot;VCN 1.0: Will use PSP to load VCN firmware\n&quot=
;);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_vcn_resume(ad=
ev);<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c b/drivers/gpu/drm/amd/am=
dgpu/vcn_v2_0.c<br>
index 8af567c..ebe4f2b 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c<br>
@@ -122,7 +122,7 @@ static int vcn_v2_0_sw_init(void *handle)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; adev-&gt;firmware.ucode[AMDGPU_UCODE_ID_VCN].fw =3D a=
dev-&gt;vcn.fw;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; adev-&gt;firmware.fw_size +=3D<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ALIGN=
(le32_to_cpu(hdr-&gt;ucode_size_bytes), PAGE_SIZE);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; DRM_INFO(&quot;PSP loading VCN firmware\n&quot;);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; DRM_INFO(&quot;VCN 2.0: Will use PSP to load VCN firmware\n&quot=
;);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_vcn_resume(ad=
ev);<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/am=
dgpu/vcn_v2_5.c<br>
index 888b17d..5741504 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c<br>
@@ -152,7 +152,7 @@ static int vcn_v2_5_sw_init(void *handle)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-=
&gt;firmware.fw_size +=3D<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ALIGN(le32_to_cpu(hdr-&gt;ucode_=
size_bytes), PAGE_SIZE);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; DRM_INFO(&quot;PSP loading VCN firmware\n&quot;);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; DRM_INFO(&quot;VCN 2.5: Will use PSP to load VCN firmware\n&quot=
;);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_vcn_resume(ad=
ev);<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/am=
dgpu/vcn_v3_0.c<br>
index c3580de..b81eae3 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c<br>
@@ -158,7 +158,7 @@ static int vcn_v3_0_sw_init(void *handle)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-=
&gt;firmware.fw_size +=3D<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ALIGN(le32_to_cpu(hdr-&gt;ucode_=
size_bytes), PAGE_SIZE);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; DRM_INFO(&quot;PSP loading VCN firmware\n&quot;);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; DRM_INFO(&quot;VCN 3.0: Will use PSP to load VCN firmware\n&quot=
;);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_vcn_resume(ad=
ev);<br>
-- <br>
2.7.4<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx@lists.freedesktop.org<br>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D04%=
7C01%7Calexander.deucher%40amd.com%7C18117b603e8044be99c708d947f898f7%7C3dd=
8961fe4884e608e11a82d994e183d%7C0%7C0%7C637619955325132066%7CUnknown%7CTWFp=
bGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%=
7C1000&amp;amp;sdata=3Dh5P5Asi3pBpWlB2o9xeq7Bjm7lBbRVJPyTY3aa%2B9O60%3D&amp=
;amp;reserved=3D0">https://nam11.safelinks.protection.outlook.com/?url=3Dht=
tps%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;da=
ta=3D04%7C01%7Calexander.deucher%40amd.com%7C18117b603e8044be99c708d947f898=
f7%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637619955325132066%7CUnknow=
n%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI=
6Mn0%3D%7C1000&amp;amp;sdata=3Dh5P5Asi3pBpWlB2o9xeq7Bjm7lBbRVJPyTY3aa%2B9O6=
0%3D&amp;amp;reserved=3D0</a><br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BL1PR12MB514416C6EDCBFD9AEE448000F7119BL1PR12MB5144namp_--

--===============0401292574==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0401292574==--
