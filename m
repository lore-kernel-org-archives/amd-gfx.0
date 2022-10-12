Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE811C4332F
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Oct 2022 01:48:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 41B7A10E174;
	Wed, 12 Oct 2022 01:48:22 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2076.outbound.protection.outlook.com [40.107.244.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B5B9410E174
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Oct 2022 01:48:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wub7A2Y62WdQRiLY0mh7u1OpVeYHCKYiCYh4R4Gft6JVg2QyKwRAEaOSqfobkbUySri0AqgN69XI+ENkCg1ghgw23MMzRJFqkMT0AWrzIpCEoV7NFq29rG89sYkcL/R0ZRUwaR5ZGZuurJoKuD7VHClF5pTkmo6QVS2iEMBR60xA2OAQLPt9x5wf+V6Q4L+t6juY8eFz9R4zAZwDYc05LWbSTXCXNKfqAI0FayfXkDD4mw5pz05qwvWmj9WiB3nYJg9lvG0ZTvx4+Gagbo4hcQL0kjQa8rQ4liSQjIJSaXbiHCLNVw5w0+ssnC0Cp+K3TmQ01VmiwXAkJb4kSy8jFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8+zPHsPCH1lN5aG1Cket9RKDyQu7XtNW00Wa6myCwUI=;
 b=iSNT8jiyT8RHsKTm8KyHVyEZHc4m6tyVEU0QXZOpzF6ehCBUEskzYJ5q1FqJ82ab+KR6RpXaiwsHJ6UCBMIaQsptkajSN7nwvsByM92VNg2R8a8tyfz2DLqv2B13djPJmdEYzDoEPy1nmUYrXRcp/fGqp/wSnHseFjZiVQOXdca4W7ET8ifjPSVoKAPJR2JQ/K6/3NLR3MEkvPMesdoX8mK7Jsyql2nOvDY4JqFF/AlPf+sEzj4MnyzPFd1bfkHeaTG/md2Jkhgg3cDvdF0HnFWuOPQdQSl5k4fSGlgCeGn3sfPxJWYpbM9YbjDladbK/zN9Aj6Dj1nfagyjAoVdzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8+zPHsPCH1lN5aG1Cket9RKDyQu7XtNW00Wa6myCwUI=;
 b=gKrBtw4YEnqOb6Ajhbga7h+FYVJ43yfOgYuxNNQDjICMDj9iBtRGKYsFMBijPNTQX4SH2qKhcwpXFznUAmT55hmycnLwh/oiErKRBod87tkzZSZF6zGwBhiQsv03vlKq7AP/52GN1M0mrSgiMC7+ZmxrMLDFk1Yj8L1a+NeBP1s=
Received: from CY5PR12MB6369.namprd12.prod.outlook.com (2603:10b6:930:21::10)
 by PH7PR12MB6882.namprd12.prod.outlook.com (2603:10b6:510:1b8::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Wed, 12 Oct
 2022 01:48:15 +0000
Received: from CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::83b:c645:e27b:b656]) by CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::83b:c645:e27b:b656%3]) with mapi id 15.20.5709.019; Wed, 12 Oct 2022
 01:48:15 +0000
From: "Zhang, Yifan" <Yifan1.Zhang@amd.com>
To: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdkfd: correct the cache info for gfx1036
Thread-Topic: [PATCH] drm/amdkfd: correct the cache info for gfx1036
Thread-Index: AdjcSY11oTxMl0WIT9SvS4q+/96NQQAbYFC2AB55vmAAAAoLYAAq06kQ
Date: Wed, 12 Oct 2022 01:48:14 +0000
Message-ID: <CY5PR12MB6369ACDEF61737FECFF01425C1229@CY5PR12MB6369.namprd12.prod.outlook.com>
References: <DM4PR12MB5152E7324B015121A58421D2E3209@DM4PR12MB5152.namprd12.prod.outlook.com>
 <BL1PR12MB51444061064E5A389D8EDB36F7209@BL1PR12MB5144.namprd12.prod.outlook.com>
 <DM4PR12MB5152F3DFF5D93F750662E0B4E3239@DM4PR12MB5152.namprd12.prod.outlook.com>
 <DM4PR12MB51522F1AFF5AF9507C1678E7E3239@DM4PR12MB5152.namprd12.prod.outlook.com>
In-Reply-To: <DM4PR12MB51522F1AFF5AF9507C1678E7E3239@DM4PR12MB5152.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-10-12T01:47:25Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=fbaf0962-061c-4cc2-8507-8dad72b3069a;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2022-10-12T01:48:12Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: 5cad7a62-30ae-4b8a-8806-b24a189c3ad9
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR12MB6369:EE_|PH7PR12MB6882:EE_
x-ms-office365-filtering-correlation-id: d1b5e27a-fcd2-459d-b885-08daabf3d416
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: P08TSdxwBVWoo3tgMMPqi0WwznLVajGz7lspmyArB6L4/SSf29/CVp3pUwdiaa9VdJr38+U0pK8hhbpeailR07setfWDhFiiGhIhNEi1yuGV4SEkHCWfh3Cn6wsZMJLYBuQ1bSFgGOGhWENAAWVylDLEf5nKxYfIH58+1hyruk97kEY5VD1fXt2QfOV31OA+ghIv2DcsKPLXWt44BHt0VfcHKSZafTdZUJH/Etf6pr3n1ZA0MAWvWmJg9Tzis1OLs5GNNQOgo/Ry2u84KlH6xv2g7M4RNOhypF/u4B1ndB20y3ahBGIabySm+j+FPP4NVy7SVLWexRLROiQjgCrmQ9TYAPvNw1q33Q4lzsPyT+nqneVjOfJWJJj710uOV7CSSTliXtqPYUTISr+v0lpe/scWNU8c16jGIkVlU7dgRPHltY9M2ql42DgGQC5/JqHuRL0HK2ssXgssMALP+OA2p5EcOYOUFj1VDFbYkf+RWR3y8/uaUq1JBdJINwborF6DZisKL3UmuAXAyVd1PtynkyX0i+na4TvrwnS3IISpTG199fnTF362Uto7Rfjdt3wSIU6bqm3xYUY10H3v51BYjbZ/vp188NdINPRYXX7mhbzXtEd/kjfOYGfWX/v8fjNKetwY4YS9cpvuI5+Rz9UUHylpTf7PO2HWJSAig33oJX9Gz6a4kopHbsPbE91vli6muqJY8eUJkc1VRYa2JFF7cqsGPiSfPi03FfwviilaoeTXKMJTIq6KmUEci3FHF0Mo3IGqCCMKyxtHJVUWDFK86yYUJpxWj/7EPbY3drUAJ3yNynUlirPO8mTLovtQKC+q
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY5PR12MB6369.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(346002)(39860400002)(366004)(136003)(396003)(451199015)(26005)(7696005)(6506007)(53546011)(122000001)(38100700002)(66556008)(316002)(55016003)(8676002)(66446008)(66946007)(71200400001)(76116006)(4326008)(64756008)(66476007)(38070700005)(86362001)(33656002)(186003)(478600001)(2906002)(54906003)(5660300002)(41300700001)(8936002)(9686003)(110136005)(52536014)(414714003)(473944003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?eV41C0QObxvW+BfLWRma/WsXdVVprZMgy2rz8ObCtT31cd1K5oG59LZaZgT7?=
 =?us-ascii?Q?1cAwctL8qYOJneN4TXffzzl0OUpP7zObe8NBsB3ZdO/+O4xdMJzYv42Z7YT1?=
 =?us-ascii?Q?11tnjq2a8R4N72sVWXFWaQgEKiHj38scTuQ55GT8OY8jkGTqEV+Wy+auTifS?=
 =?us-ascii?Q?Gb0iGcZH1DLAjRCpQvRLzQvbVbic1gmdFBIG/bmSo2GzYDwBlLa00v0sWsZR?=
 =?us-ascii?Q?YZGGtpJQ7JGkC7uAW+dsI1YA9JnhcWtqQjgMsKCK3jrYBfqV7aPwy7Afyk6n?=
 =?us-ascii?Q?LJ8am7uCHKFZRHD4d/nxwG+XSf39vQEDAGRDUmOM+pMkgc6vs+EDlWaXeIvu?=
 =?us-ascii?Q?Qev0fHrlIU/WdIPZrI3P5oYa2JZEyXYE3gT44JJdnFcY/AIqT6WqqF1bnyow?=
 =?us-ascii?Q?dti78RqitQCKsItgu/D3CFtSYVQSAsFBfm6tCN2XuTiMhJ8u+Ah3f8X30ua8?=
 =?us-ascii?Q?ctmcDSgBT8WpTb0M/9z45nedw1pmRq0/vmAeIWfMuQmEkd067RboF7evRgR6?=
 =?us-ascii?Q?sdd0Bg38fyashFxTlkvYcJY7arq7udoRLajXfzz1CX23H01WC2zR5Poc/tgG?=
 =?us-ascii?Q?oIRH1GEEBnOUjwe0zRb3jkX9s0TODi2kdAj4Y71p3espio4W0yWK8y5478IZ?=
 =?us-ascii?Q?8WtSlxbfImcyQBT7K2TKHNMmqPQfdRmfFt+oJ3CIOnS5DuzYYYcE2AH4wcVM?=
 =?us-ascii?Q?DcDBqAOMKo3ZqyGmM43WFv7Xb4ttu99vHG1AomA7770kIH/JdQ39IA6rSLPy?=
 =?us-ascii?Q?yFqhArUcWeYD1EM7Jxz+gjIcZvmcdcziFxO3akweeA4hWZI/TdciLiJKUyPt?=
 =?us-ascii?Q?cFrc75GqtJIxIdRb43x6aJ5Z2G6taVbCUV/PclpogxwX/GqDwieUzbK6Vmdh?=
 =?us-ascii?Q?WkbvjspWdvvJcS+s4mD9z8rl1Dc/fFFDtK0mP/DwwTdHpzEiOAflbKgjvl2a?=
 =?us-ascii?Q?b8fCq6R2Gqvcqhi2ALF/Oe34ExuOjK5mYHtaJVJMbcCrnj8JfSzI6jfS+JfX?=
 =?us-ascii?Q?/BcPP6AgyibvtvucpxeK2QeQ6wld/qAw8SD11D/uf6BN28H/ZOdhN16/mJB+?=
 =?us-ascii?Q?exWreFgr1PZxMwGTGGY5B4AeaMLeTew/72QPw6j8ch9GT2LdiqIijZVAEhWy?=
 =?us-ascii?Q?vd8EWTCj3vtZen/K6Cw2PEgHQzT/NGz7xpYyllk6Ie1m5ZM+r0k3O+xwBVn1?=
 =?us-ascii?Q?W7Q15Ue3PD1dDuBon1XA8KIhjYZfV3en+TzProgqQZor/4zRkx6bD/6ynU5c?=
 =?us-ascii?Q?3LdeeHP54vmXEyN22TS0XU2tVXXQ8RrUKPevCpmFX6b1qprj/6V8rgAbnNpU?=
 =?us-ascii?Q?OcThMZVMrGrbMunWkQggdYADaaiz6Zt0xsMNvuDQ7/pWiB0vaqeZC0SqcMuv?=
 =?us-ascii?Q?Vv4eNAR8GhRrxjCHvrD5cbrdRLtsKz7OsDhv5O9nDCHY0HofGT/C3luAfmwc?=
 =?us-ascii?Q?j4NbldupCBrUzC6F0fxbtrP1310qNMI4eJaclyvD6WoGR8gcf9uF5/vtzR8t?=
 =?us-ascii?Q?cJgi8fHVZGpKn0z1aswsBMx3ZUTBql8Q3cyFM2z/ULSKD3aZGzsnlslIMw8V?=
 =?us-ascii?Q?B4vj0s6BgabfLt3P8GQ=3D?=
Content-Type: multipart/alternative;
 boundary="_000_CY5PR12MB6369ACDEF61737FECFF01425C1229CY5PR12MB6369namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6369.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1b5e27a-fcd2-459d-b885-08daabf3d416
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2022 01:48:14.3307 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6RAZ9Skn4jO+CGP9TmC7H8DTsL51Q6mRj0h2MtDZmKC5vxfy6ChAM75JSN+NiV3u
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6882
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Kuehling,
 Felix" <Felix.Kuehling@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_CY5PR12MB6369ACDEF61737FECFF01425C1229CY5PR12MB6369namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[Public]

This patch is

Reviewed-by: Yifan Zhang <yifan1.zhang@amd.com>

From: Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>
Sent: Tuesday, October 11, 2022 1:23 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Yifan <Yifan1.Zh=
ang@amd.com>; Kuehling, Felix <Felix.Kuehling@amd.com>
Subject: RE: [PATCH] drm/amdkfd: correct the cache info for gfx1036


[AMD Official Use Only - General]



   correct the cache information for gfx1036



    Signed-off-by: Yifan Zhang yifan1.zhang@amd.com<mailto:yifan1.zhang@amd=
.com>



    Signed-off-by: jie1zhan jesse.zhang@amd.com<mailto:jesse.zhang@amd.com>

    Change-Id: I60e754737057c144e69a6511ba6ddfca472ca7a1



diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm/amd/am=
dkfd/kfd_crat.c

index 477a30981c1b..d25ac9cbe5b2 100644

--- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c

+++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c

@@ -795,6 +795,54 @@ static struct kfd_gpu_cache_info yellow_carp_cache_inf=
o[] =3D {

        },

};



+static struct kfd_gpu_cache_info gc_10_3_6_cache_info[] =3D {

+       {

+               /* TCP L1 Cache per CU */

+               .cache_size =3D 16,

+               .cache_level =3D 1,

+               .flags =3D (CRAT_CACHE_FLAGS_ENABLED |

+                               CRAT_CACHE_FLAGS_DATA_CACHE |

+                               CRAT_CACHE_FLAGS_SIMD_CACHE),

+               .num_cu_shared =3D 1,

+       },

+       {

+               /* Scalar L1 Instruction Cache per SQC */

+               .cache_size =3D 32,

+               .cache_level =3D 1,

+               .flags =3D (CRAT_CACHE_FLAGS_ENABLED |

+                               CRAT_CACHE_FLAGS_INST_CACHE |

+                               CRAT_CACHE_FLAGS_SIMD_CACHE),

+               .num_cu_shared =3D 2,

+       },

+       {

+               /* Scalar L1 Data Cache per SQC */

+               .cache_size =3D 16,

+               .cache_level =3D 1,

+               .flags =3D (CRAT_CACHE_FLAGS_ENABLED |

+                               CRAT_CACHE_FLAGS_DATA_CACHE |

+                               CRAT_CACHE_FLAGS_SIMD_CACHE),

+               .num_cu_shared =3D 2,

+       },

+       {

+               /* GL1 Data Cache per SA */

+               .cache_size =3D 128,

+               .cache_level =3D 1,

+               .flags =3D (CRAT_CACHE_FLAGS_ENABLED |

+                               CRAT_CACHE_FLAGS_DATA_CACHE |

+                               CRAT_CACHE_FLAGS_SIMD_CACHE),

+               .num_cu_shared =3D 2,

+       },

+       {

+               /* L2 Data Cache per GPU (Total Tex Cache) */

+               .cache_size =3D 256,

+               .cache_level =3D 2,

+               .flags =3D (CRAT_CACHE_FLAGS_ENABLED |

+                               CRAT_CACHE_FLAGS_DATA_CACHE |

+                               CRAT_CACHE_FLAGS_SIMD_CACHE),

+               .num_cu_shared =3D 2,

+       },

+};

+

static void kfd_populated_cu_info_cpu(struct kfd_topology_device *dev,

                struct crat_subtype_computeunit *cu)

{

@@ -1514,11 +1562,14 @@ static int kfd_fill_gpu_cache_info(struct kfd_dev *=
kdev,

                        num_of_cache_types =3D ARRAY_SIZE(beige_goby_cache_=
info);

                        break;

                case IP_VERSION(10, 3, 3):

-               case IP_VERSION(10, 3, 6): /* TODO: Double check these on p=
roduction silicon */

                case IP_VERSION(10, 3, 7): /* TODO: Double check these on p=
roduction silicon */

                        pcache_info =3D yellow_carp_cache_info;

                        num_of_cache_types =3D ARRAY_SIZE(yellow_carp_cache=
_info);

                        break;

+               case IP_VERSION(10, 3, 6):

+                       pcache_info =3D gc_10_3_6_cache_info;

+                       num_of_cache_types =3D ARRAY_SIZE(gc_10_3_6_cache_i=
nfo);

+                       break;

                case IP_VERSION(11, 0, 0):

--_000_CY5PR12MB6369ACDEF61737FECFF01425C1229CY5PR12MB6369namp_
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
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
p.xmsonormal, li.xmsonormal, div.xmsonormal
	{mso-style-name:x_msonormal;
	margin:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
p.msipheaderdf3d92d6, li.msipheaderdf3d92d6, div.msipheaderdf3d92d6
	{mso-style-name:msipheaderdf3d92d6;
	mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
span.EmailStyle20
	{mso-style-type:personal-compose;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
p.msipheaderc10f11a2, li.msipheaderc10f11a2, div.msipheaderc10f11a2
	{mso-style-name:msipheaderc10f11a2;
	mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
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
<body lang=3D"EN-US" link=3D"#0563C1" vlink=3D"purple" style=3D"word-wrap:b=
reak-word">
<div class=3D"WordSection1">
<p class=3D"msipheaderc10f11a2" style=3D"margin:0in"><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:green">[Public]</s=
pan><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">This patch is <o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Reviewed-by: Yifan Zhang &lt;yifan1.zhang@amd.com&gt=
;<o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:14.0pt"><o:p>&nbsp;</o:p></=
span></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> Zhang, Jesse(Jie) &lt;Jesse.Zhang@amd.c=
om&gt; <br>
<b>Sent:</b> Tuesday, October 11, 2022 1:23 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Zhang, Yif=
an &lt;Yifan1.Zhang@amd.com&gt;; Kuehling, Felix &lt;Felix.Kuehling@amd.com=
&gt;<br>
<b>Subject:</b> RE: [PATCH] drm/amdkfd: correct the cache info for gfx1036<=
o:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"msipheaderdf3d92d6" style=3D"margin:0in"><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:blue">[AMD Officia=
l Use Only - General]</span><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<p class=3D"xmsonormal">&nbsp;&nbsp; correct the cache information for gfx1=
036<o:p></o:p></p>
<p class=3D"xmsonormal">&nbsp;<o:p></o:p></p>
<p class=3D"xmsonormal">&nbsp;&nbsp;&nbsp; Signed-off-by: Yifan Zhang <a hr=
ef=3D"mailto:yifan1.zhang@amd.com">
yifan1.zhang@amd.com</a><o:p></o:p></p>
<p class=3D"xmsonormal">&nbsp;<o:p></o:p></p>
<p class=3D"xmsonormal">&nbsp;&nbsp;&nbsp; Signed-off-by: jie1zhan <a href=
=3D"mailto:jesse.zhang@amd.com">
jesse.zhang@amd.com</a><o:p></o:p></p>
<p class=3D"xmsonormal">&nbsp;&nbsp;&nbsp; Change-Id: I60e754737057c144e69a=
6511ba6ddfca472ca7a1<o:p></o:p></p>
<p class=3D"xmsonormal">&nbsp;<o:p></o:p></p>
<p class=3D"xmsonormal">diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c =
b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c<o:p></o:p></p>
<p class=3D"xmsonormal">index 477a30981c1b..d25ac9cbe5b2 100644<o:p></o:p><=
/p>
<p class=3D"xmsonormal">--- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c<o:p></o=
:p></p>
<p class=3D"xmsonormal">+++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c<o:p></o=
:p></p>
<p class=3D"xmsonormal">@@ -795,6 +795,54 @@ static struct kfd_gpu_cache_in=
fo yellow_carp_cache_info[] =3D {<o:p></o:p></p>
<p class=3D"xmsonormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; },<o:p><=
/o:p></p>
<p class=3D"xmsonormal">};<o:p></o:p></p>
<p class=3D"xmsonormal">&nbsp;<o:p></o:p></p>
<p class=3D"xmsonormal">+static struct kfd_gpu_cache_info gc_10_3_6_cache_i=
nfo[] =3D {<o:p></o:p></p>
<p class=3D"xmsonormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {<o:p></o:p><=
/p>
<p class=3D"xmsonormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TCP L1 Cache per CU */<o:p></o:p></p>
<p class=3D"xmsonormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .cache_size =3D 16,<o:p></o:p></p>
<p class=3D"xmsonormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .cache_level =3D 1,<o:p></o:p></p>
<p class=3D"xmsonormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .flags =3D (CRAT_CACHE_FLAGS_ENABLED |<o=
:p></o:p></p>
<p class=3D"xmsonormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CRAT_CACHE_FLAGS_DA=
TA_CACHE |<o:p></o:p></p>
<p class=3D"xmsonormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CRAT_CACHE_FLAGS_SI=
MD_CACHE),<o:p></o:p></p>
<p class=3D"xmsonormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .num_cu_shared =3D 1,<o:p></o:p></p>
<p class=3D"xmsonormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; },<o:p></o:p>=
</p>
<p class=3D"xmsonormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {<o:p></o:p><=
/p>
<p class=3D"xmsonormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Scalar L1 Instruction Cache per SQC *=
/<o:p></o:p></p>
<p class=3D"xmsonormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .cache_size =3D 32,<o:p></o:p></p>
<p class=3D"xmsonormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .cache_level =3D 1,<o:p></o:p></p>
<p class=3D"xmsonormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .flags =3D (CRAT_CACHE_FLAGS_ENABLED |<o=
:p></o:p></p>
<p class=3D"xmsonormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CRAT_CACHE_FLAGS_IN=
ST_CACHE |<o:p></o:p></p>
<p class=3D"xmsonormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CRAT_CACHE_FLAGS_SI=
MD_CACHE),<o:p></o:p></p>
<p class=3D"xmsonormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .num_cu_shared =3D 2,<o:p></o:p></p>
<p class=3D"xmsonormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; },<o:p></o:p>=
</p>
<p class=3D"xmsonormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {<o:p></o:p><=
/p>
<p class=3D"xmsonormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Scalar L1 Data Cache per SQC */<o:p><=
/o:p></p>
<p class=3D"xmsonormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .cache_size =3D 16,<o:p></o:p></p>
<p class=3D"xmsonormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .cache_level =3D 1,<o:p></o:p></p>
<p class=3D"xmsonormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .flags =3D (CRAT_CACHE_FLAGS_ENABLED |<o=
:p></o:p></p>
<p class=3D"xmsonormal">+ &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;CRAT_CACHE_FLAGS_DA=
TA_CACHE |<o:p></o:p></p>
<p class=3D"xmsonormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CRAT_CACHE_FLAGS_SI=
MD_CACHE),<o:p></o:p></p>
<p class=3D"xmsonormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .num_cu_shared =3D 2,<o:p></o:p></p>
<p class=3D"xmsonormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; },<o:p></o:p>=
</p>
<p class=3D"xmsonormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {<o:p></o:p><=
/p>
<p class=3D"xmsonormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* GL1 Data Cache per SA */<o:p></o:p></=
p>
<p class=3D"xmsonormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .cache_size =3D 128,<o:p></o:p></p>
<p class=3D"xmsonormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .cache_level =3D 1,<o:p></o:p></p>
<p class=3D"xmsonormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .flags =3D (CRAT_CACHE_FLAGS_ENABLED |<o=
:p></o:p></p>
<p class=3D"xmsonormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CRAT_CACHE_FLAGS_DA=
TA_CACHE |<o:p></o:p></p>
<p class=3D"xmsonormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;CRAT_CACHE_FLAGS_SI=
MD_CACHE),<o:p></o:p></p>
<p class=3D"xmsonormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .num_cu_shared =3D 2,<o:p></o:p></p>
<p class=3D"xmsonormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; },<o:p></o:p>=
</p>
<p class=3D"xmsonormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {<o:p></o:p><=
/p>
<p class=3D"xmsonormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* L2 Data Cache per GPU (Total Tex Cach=
e) */<o:p></o:p></p>
<p class=3D"xmsonormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .cache_size =3D 256,<o:p></o:p></p>
<p class=3D"xmsonormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .cache_level =3D 2,<o:p></o:p></p>
<p class=3D"xmsonormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .flags =3D (CRAT_CACHE_FLAGS_ENABLED |<o=
:p></o:p></p>
<p class=3D"xmsonormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CRAT_CACHE_FLAGS_DA=
TA_CACHE |<o:p></o:p></p>
<p class=3D"xmsonormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CRAT_CACHE_FLAGS_SI=
MD_CACHE),<o:p></o:p></p>
<p class=3D"xmsonormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .num_cu_shared =3D 2,<o:p></o:p></p>
<p class=3D"xmsonormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; },<o:p></o:p>=
</p>
<p class=3D"xmsonormal">+};<o:p></o:p></p>
<p class=3D"xmsonormal">+<o:p></o:p></p>
<p class=3D"xmsonormal">static void kfd_populated_cu_info_cpu(struct kfd_to=
pology_device *dev,<o:p></o:p></p>
<p class=3D"xmsonormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct crat_subtype_computeunit *cu=
)<o:p></o:p></p>
<p class=3D"xmsonormal">{<o:p></o:p></p>
<p class=3D"xmsonormal">@@ -1514,11 +1562,14 @@ static int kfd_fill_gpu_cac=
he_info(struct kfd_dev *kdev,<o:p></o:p></p>
<p class=3D"xmsonormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; num_of_cache_types =3D ARRAY_SIZE(beige_goby_cache_info);<o:p>=
</o:p></p>
<p class=3D"xmsonormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; break;<o:p></o:p></p>
<p class=3D"xmsonormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(10, 3, 3):<o:p></o:=
p></p>
<p class=3D"xmsonormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(10, 3, 6): /* TODO: Doub=
le check these on production silicon */<o:p></o:p></p>
<p class=3D"xmsonormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(10, 3, 7): /* TODO:=
 Double check these on production silicon */<o:p></o:p></p>
<p class=3D"xmsonormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;pcache_info =3D yellow_carp_cache_info;<o:p></o:p></p>
<p class=3D"xmsonormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; num_of_cache_types =3D ARRAY_SIZE(yellow_carp_cache_info);<o:p=
></o:p></p>
<p class=3D"xmsonormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; break;<o:p></o:p></p>
<p class=3D"xmsonormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(10, 3, 6):<o:p></o:p></p=
>
<p class=3D"xmsonormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; pcache_info =3D gc_10_3_6_cache_info;<o:p></o:p></p>
<p class=3D"xmsonormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; num_of_cache_types =3D ARRAY_SIZE(gc_10_3_6_cache_info);<o:p></o:p>=
</p>
<p class=3D"xmsonormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; break;<o:p></o:p></p>
<p class=3D"xmsonormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(11, 0, 0):<o:p></o:=
p></p>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_CY5PR12MB6369ACDEF61737FECFF01425C1229CY5PR12MB6369namp_--
