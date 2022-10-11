Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00A43C433FE
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Oct 2022 13:19:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 207CD10E3BF;
	Tue, 11 Oct 2022 13:19:23 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2059.outbound.protection.outlook.com [40.107.237.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6F4DC10E366
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Oct 2022 13:19:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PIuR2fNykzLufKzHJC/+c+CxH/juS8A60ReyX6690jQcy8qQpDr/xt9NkGbZlHaIKI4xSJBPFkJKtS1VaVh+ibEfBeJvav3QDp/Ao3xd/Ke/Nh76SEUL1RSYGXvWYF9JaOA5AviT+J6yLYJdAfpC5bblVK/2AFxXX5kc6kQnuD5/2pf+cg8A4mLNMliI49qqbO5Fh0mZeBhN1RQW6phgBsojFh9bCoedC+DSPcm6RUeho4VxQwa4TUT+ktRLA+4uw72M1UcYV5HyqQELY4rxdQ3oZzUjD8MITyw7ArZ146MDCERmEItXHJX4lXOeRpripUUDzd1lNtdv2gg3O2pyhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1galj23fssWq/TJ5Y029y+tv/emhkn1nq2IPA/61lN8=;
 b=TuwswEak2cISDPwoZTaehRPH75CWZij+r2XkB8krzS1SzLFxbUiI/q4vafZliKgAhIstLjX2DQfxQXl0jyXEYOLmC0U0Po/QKbS40/zX/IdCAC/KkXqaLG3Jb2S/vruXyjbhslu6qTrAyjhl+DcZ0Lu8bY23aoT9zZ/sQNAK3ulAW7ebNOIn8UeyjZ9FRAeXYd3rv6a7CqzOxSmiJ7PGG2mRtYA7dfphzxWrzjEOHYdrThpiE0hzaoh/tG3SAplX7J0WcOgmZ2lhkq+XdbDob3hq8LuIgBJxRDOwq1Z4nrYvM8K2RLlTI6Dl5kbU2YqGzHPCdjo29SwX3ryivQB7tQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1galj23fssWq/TJ5Y029y+tv/emhkn1nq2IPA/61lN8=;
 b=q8wb3T0WSQEqnVfVniqNHLvQQuQvi3XML1TXpR3rfI2Ktik7vrkvujwW0k49jeHCXJwANIspJVfV9lnpr4umEpg7iTpj+/qBL5bSxW+ieo01ZaF8Y+ticJAg8xnnEb1Lzfzxs1cJZa+o7so7W3fkJwK2kG+2XqdWSzh6HqVGPm8=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by PH7PR12MB6539.namprd12.prod.outlook.com (2603:10b6:510:1f0::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.21; Tue, 11 Oct
 2022 13:19:14 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::f5f8:4688:2e04:4769]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::f5f8:4688:2e04:4769%3]) with mapi id 15.20.5709.019; Tue, 11 Oct 2022
 13:19:14 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdkfd: correct the cache info for gfx1036
Thread-Topic: [PATCH] drm/amdkfd: correct the cache info for gfx1036
Thread-Index: AdjcSY11oTxMl0WIT9SvS4q+/96NQQAbYFC2AB55vmAAAAoLYAAQuO15
Date: Tue, 11 Oct 2022 13:19:14 +0000
Message-ID: <BL1PR12MB5144A93784C379073A52FAECF7239@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <DM4PR12MB5152E7324B015121A58421D2E3209@DM4PR12MB5152.namprd12.prod.outlook.com>
 <BL1PR12MB51444061064E5A389D8EDB36F7209@BL1PR12MB5144.namprd12.prod.outlook.com>
 <DM4PR12MB5152F3DFF5D93F750662E0B4E3239@DM4PR12MB5152.namprd12.prod.outlook.com>
 <DM4PR12MB51522F1AFF5AF9507C1678E7E3239@DM4PR12MB5152.namprd12.prod.outlook.com>
In-Reply-To: <DM4PR12MB51522F1AFF5AF9507C1678E7E3239@DM4PR12MB5152.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=True;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-10-11T13:19:13.762Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|PH7PR12MB6539:EE_
x-ms-office365-filtering-correlation-id: 78e26043-d3c3-420a-081a-08daab8b3177
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: D3SLKljPjEdC1CVYdl94sH8eG1CFPFT/WLm2DaI8fz4NLm5Dkdesii7TZ8cmZG3dd3jQyKph4BatDvw5VWlUtBDa5VTArnW7VV10VfMmqzcmR22hzEZc+AnSbUuszRnZCWQfhXrbQ5YMBvXL2C5oGGMyWtyuhBYCrrsPfS7XSUMIBFuLGnyYrWbxkXJ/pdAAr3Rhj6jbuBQlU9VMc4K09LXJBk1WktLDWSh1KEeOf1k6JwIoUUbs+nKxq3Yg1froA+Zi4ZlhNPIUg09HxH7x41mXxKkRFyMHRfvhbDtlMohtJq762gsdDN5O6is1x8qwJkvtR8eVLbGO8TCRl20yjmnO/n+K1YwNXlJPy+OopnYSBOfL7lYEeNumPcbGEbUx3mJGrxJcsxV3nID58jLbTM3HJBLm+3r7sUGq0h+bzEaWoZWSVqbL6KvfQbW3WW9mOFLaeuWDOb2Iyz/MSZi5XEA6KBrQuH5RNKUGWZdudAg7Sz2rpbqveMGPoh7yheGz1XJLGmd/Npm4DmyEexzQtouUEQByAVJGSoWUUPRseDvkF/lfPeOl9ixscUeTasC5JLUWtYdWvQerm5bcyieBytJCHjvaKmB22tfbvGuQJrwCA5rjRrpAqT1pSyMfX19cjSBWLoK76b+5/l/X6g1casTMhQWOUaakuF06snXW3bYBx+McUQzg78wTysWSKyLp1cg+3eYIWa6geiDWsvm15oZ7jZ/gbKgu8U1ogDue+8l8ebQelWa2HRHBzYdM2qdqTKPALAnRaaLgjYMi5/bHdZ1YacHjD2FiBjOAnPgQOAGGsxWBU0AL2XESa8hp6CjU
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(366004)(376002)(346002)(136003)(39860400002)(396003)(451199015)(122000001)(55016003)(38070700005)(38100700002)(86362001)(33656002)(54906003)(76116006)(66946007)(66556008)(66476007)(66446008)(64756008)(8676002)(4326008)(110136005)(316002)(19627235002)(2906002)(52536014)(41300700001)(5660300002)(8936002)(186003)(478600001)(71200400001)(9686003)(26005)(6506007)(7696005)(53546011)(19627405001)(414714003)(473944003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Tz/xA4vd4atds6Tb/vJ/7Z9jPzVSKdJqHV/okG3QyJk71QMBM6z/gbqgStVI?=
 =?us-ascii?Q?JFo7nI9/oduHIU+F/4yMfjFIgk8FD6f4QAlTE5Uxsd4j2u9a3+MxndonuiOI?=
 =?us-ascii?Q?uZ2cCzvMNNki8hSah8bT5NfmeZrtxa/bMBzA0Gscdrm/LtNeWwLFi2sHUfXz?=
 =?us-ascii?Q?oz3bZs3Yu4kMs5rPkZHSxFCw0eBc4p1QM3wM2NbpCW/wyvbDxi/thBbu/ASm?=
 =?us-ascii?Q?jAgfHjFuRWFFmW87s2VviCVcjpIOv1hAojwFMwdb892fCI5GG0mphDVfq/Ks?=
 =?us-ascii?Q?D3fDA5QOVzYM7oopGQf0vO11+1F1jydvpLCZNXZzxabSQxu4iujRHMvy4oWO?=
 =?us-ascii?Q?ZjqJaj1mwymW4PwI127zJcur4W9mippVZqba2a8EwyoRvXnV7DudaCqBJQiI?=
 =?us-ascii?Q?lw9dug2UQdbOmk0gMBXVYgCT9FpUDCRf4n2bFjSXD+6s3ddCWnTPyQaqp+T4?=
 =?us-ascii?Q?EfYXkpKukgM9/+uxzfCqeubfa+GPkTlrbdIkcluM0wZyG/1h9WvSuhhX3q2k?=
 =?us-ascii?Q?HhbxeU2K3kcBDyEoyJjUmuqNbAdfTK7q2vUayscaZ+RXkbJYmMwY7z98/dG7?=
 =?us-ascii?Q?F45GeWf+RLz9Zqf4ne3tMsX1tao2fPhfxKmRUV2A0fdTqS4pUJfnwP4gmKEO?=
 =?us-ascii?Q?k1+4Xlmd+tK4P0nLZJ9gzYmNqNXgnyQ64bJzHdYDICIZBM8oxWfJFufkhfN3?=
 =?us-ascii?Q?Zg9XhvHm/6I/aqI2foMIUFIkss6YLqzt3ndEBVff2jP6eevdqSnmHqLBggYB?=
 =?us-ascii?Q?+jBEk44RbDd1A+lV1xXrzgDv/fGHtlI0o94+7ewyXC3TByY2Wwd7LNcCFxC3?=
 =?us-ascii?Q?R2mcFLIPF0QR84g1/g7e887TCbqTK8XXa5o5advpRfO9FuvnybAab/gATqQq?=
 =?us-ascii?Q?y6/mmw0sRD951pux8gBEx8pRLc8ti7RdWXA4JcqR+x5FaLQwQEbez45W1f9c?=
 =?us-ascii?Q?aoL8QWP28UEIs/1AS52m9h3vCnx2aTaO/DWkMFfKG/B+9H9Z2zkiNcmx7JX/?=
 =?us-ascii?Q?FG6wlFWqeKTrxy8mfbFjIzLfvYI7pD5fIjrdQcijio7hUyVRAMwLd4cKKYkW?=
 =?us-ascii?Q?IyUq4HvZgZLD1GOFoQ9MbLDO+me4gECqsQ7gNnwonkaBolG4nErckw1UuQHr?=
 =?us-ascii?Q?pY8LR17vWN8KGl7T6v3JTe1rFJoocK9T3M+i/f6IE16qjk/m0hPtLzVbmCUl?=
 =?us-ascii?Q?YXEW+1gXV57WQiCTbiSfPKaQ+RYWYEMZbJFNeSv4fynL2JsJfRJgvTjR7U1h?=
 =?us-ascii?Q?8efV0hir44/Q76Kw8TM4geteXAD7TKBIF/sQVlaESziqTqsm1QscifstaBOo?=
 =?us-ascii?Q?kyfpqI8wh6mBC3weoA0CKa60fF802Itdg14naeuR18PGtIidM0PxqhbFSouU?=
 =?us-ascii?Q?wg39kEWfwt5Gmv2JB3E/cEiJuOJuww/OM/8fLctaC4ktWdFRsve+vkHxXto+?=
 =?us-ascii?Q?LyVPF/kfXl5lyIvo2gg0x58UzyNX1Q0XSHoplUjzcb/RpvzBdYQWjchqOJ05?=
 =?us-ascii?Q?Q3ykaTq874Zg/vEQqX/M39ZyoeD9hkFqRtuWotxfPi6LlNGbKr9OeAUB/VXG?=
 =?us-ascii?Q?IHRWQyv5xbRo+Ta1IW8=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB5144A93784C379073A52FAECF7239BL1PR12MB5144namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78e26043-d3c3-420a-081a-08daab8b3177
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Oct 2022 13:19:14.4879 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /MxFsOZjCHbpyLyguUY0MmwvIVG9yK+6VouIyZ9yu71qY35rWaXKwGN/SC5t/XOw1NlYEJih45YRQCo9ifRTgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6539
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
Cc: "Zhang, Yifan" <Yifan1.Zhang@amd.com>, "Kuehling,
 Felix" <Felix.Kuehling@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_BL1PR12MB5144A93784C379073A52FAECF7239BL1PR12MB5144namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[Public]

Acked-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>
Sent: Tuesday, October 11, 2022 1:23 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
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

--_000_BL1PR12MB5144A93784C379073A52FAECF7239BL1PR12MB5144namp_
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
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
Acked-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Zhang, Jesse(Jie) &lt=
;Jesse.Zhang@amd.com&gt;<br>
<b>Sent:</b> Tuesday, October 11, 2022 1:23 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Zhang, Yif=
an &lt;Yifan1.Zhang@amd.com&gt;; Kuehling, Felix &lt;Felix.Kuehling@amd.com=
&gt;<br>
<b>Subject:</b> RE: [PATCH] drm/amdkfd: correct the cache info for gfx1036<=
/font>
<div>&nbsp;</div>
</div>
<style>
<!--
@font-face
	{font-family:"Cambria Math"}
@font-face
	{font-family:DengXian}
@font-face
	{font-family:Calibri}
@font-face
	{}
p.x_MsoNormal, li.x_MsoNormal, div.x_MsoNormal
	{margin:0cm;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif}
a:link, span.x_MsoHyperlink
	{color:#0563C1;
	text-decoration:underline}
p.x_xmsonormal, li.x_xmsonormal, div.x_xmsonormal
	{margin:0cm;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif}
p.x_msipheaderdf3d92d6, li.x_msipheaderdf3d92d6, div.x_msipheaderdf3d92d6
	{margin-right:0cm;
	margin-left:0cm;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif}
span.x_EmailStyle20
	{font-family:"Arial",sans-serif;
	color:blue}
.x_MsoChpDefault
	{font-size:10.0pt}
@page WordSection1
	{margin:72.0pt 72.0pt 72.0pt 72.0pt}
div.x_WordSection1
	{}
-->
</style>
<div lang=3D"EN-US" link=3D"#0563C1" vlink=3D"purple" style=3D"word-wrap:br=
eak-word">
<div class=3D"x_WordSection1">
<p class=3D"x_msipheaderdf3d92d6" style=3D"margin:0cm"><span style=3D"font-=
size:10.0pt; font-family:&quot;Arial&quot;,sans-serif; color:blue">[AMD Off=
icial Use Only - General]</span></p>
<p class=3D"x_MsoNormal">&nbsp;</p>
<div>
<div>
<p class=3D"x_MsoNormal">&nbsp;</p>
<div>
<p class=3D"x_xmsonormal">&nbsp;&nbsp; correct the cache information for gf=
x1036</p>
<p class=3D"x_xmsonormal">&nbsp;</p>
<p class=3D"x_xmsonormal">&nbsp;&nbsp;&nbsp; Signed-off-by: Yifan Zhang <a =
href=3D"mailto:yifan1.zhang@amd.com">
yifan1.zhang@amd.com</a></p>
<p class=3D"x_xmsonormal">&nbsp;</p>
<p class=3D"x_xmsonormal">&nbsp;&nbsp;&nbsp; Signed-off-by: jie1zhan <a hre=
f=3D"mailto:jesse.zhang@amd.com">
jesse.zhang@amd.com</a></p>
<p class=3D"x_xmsonormal">&nbsp;&nbsp;&nbsp; Change-Id: I60e754737057c144e6=
9a6511ba6ddfca472ca7a1</p>
<p class=3D"x_xmsonormal">&nbsp;</p>
<p class=3D"x_xmsonormal">diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.=
c b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c</p>
<p class=3D"x_xmsonormal">index 477a30981c1b..d25ac9cbe5b2 100644</p>
<p class=3D"x_xmsonormal">--- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c</p>
<p class=3D"x_xmsonormal">+++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c</p>
<p class=3D"x_xmsonormal">@@ -795,6 +795,54 @@ static struct kfd_gpu_cache_=
info yellow_carp_cache_info[] =3D {</p>
<p class=3D"x_xmsonormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; },</p>
<p class=3D"x_xmsonormal">};</p>
<p class=3D"x_xmsonormal">&nbsp;</p>
<p class=3D"x_xmsonormal">+static struct kfd_gpu_cache_info gc_10_3_6_cache=
_info[] =3D {</p>
<p class=3D"x_xmsonormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {</p>
<p class=3D"x_xmsonormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TCP L1 Cache per CU */</p>
<p class=3D"x_xmsonormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .cache_size =3D 16,</p>
<p class=3D"x_xmsonormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .cache_level =3D 1,</p>
<p class=3D"x_xmsonormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .flags =3D (CRAT_CACHE_FLAGS_ENABLED |=
</p>
<p class=3D"x_xmsonormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CRAT_CACHE_FLAGS_=
DATA_CACHE |</p>
<p class=3D"x_xmsonormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CRAT_CACHE_FLAGS_=
SIMD_CACHE),</p>
<p class=3D"x_xmsonormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .num_cu_shared =3D 1,</p>
<p class=3D"x_xmsonormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; },</p>
<p class=3D"x_xmsonormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {</p>
<p class=3D"x_xmsonormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Scalar L1 Instruction Cache per SQC=
 */</p>
<p class=3D"x_xmsonormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .cache_size =3D 32,</p>
<p class=3D"x_xmsonormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .cache_level =3D 1,</p>
<p class=3D"x_xmsonormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .flags =3D (CRAT_CACHE_FLAGS_ENABLED |=
</p>
<p class=3D"x_xmsonormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CRAT_CACHE_FLAGS_=
INST_CACHE |</p>
<p class=3D"x_xmsonormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CRAT_CACHE_FLAGS_=
SIMD_CACHE),</p>
<p class=3D"x_xmsonormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .num_cu_shared =3D 2,</p>
<p class=3D"x_xmsonormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; },</p>
<p class=3D"x_xmsonormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {</p>
<p class=3D"x_xmsonormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Scalar L1 Data Cache per SQC */</p>
<p class=3D"x_xmsonormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .cache_size =3D 16,</p>
<p class=3D"x_xmsonormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .cache_level =3D 1,</p>
<p class=3D"x_xmsonormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .flags =3D (CRAT_CACHE_FLAGS_ENABLED |=
</p>
<p class=3D"x_xmsonormal">+ &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;CRAT_CACHE_FLAGS_=
DATA_CACHE |</p>
<p class=3D"x_xmsonormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CRAT_CACHE_FLAGS_=
SIMD_CACHE),</p>
<p class=3D"x_xmsonormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .num_cu_shared =3D 2,</p>
<p class=3D"x_xmsonormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; },</p>
<p class=3D"x_xmsonormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {</p>
<p class=3D"x_xmsonormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* GL1 Data Cache per SA */</p>
<p class=3D"x_xmsonormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .cache_size =3D 128,</p>
<p class=3D"x_xmsonormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .cache_level =3D 1,</p>
<p class=3D"x_xmsonormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .flags =3D (CRAT_CACHE_FLAGS_ENABLED |=
</p>
<p class=3D"x_xmsonormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CRAT_CACHE_FLAGS_=
DATA_CACHE |</p>
<p class=3D"x_xmsonormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;CRAT_CACHE_FLAGS_=
SIMD_CACHE),</p>
<p class=3D"x_xmsonormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .num_cu_shared =3D 2,</p>
<p class=3D"x_xmsonormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; },</p>
<p class=3D"x_xmsonormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {</p>
<p class=3D"x_xmsonormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* L2 Data Cache per GPU (Total Tex Ca=
che) */</p>
<p class=3D"x_xmsonormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .cache_size =3D 256,</p>
<p class=3D"x_xmsonormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .cache_level =3D 2,</p>
<p class=3D"x_xmsonormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .flags =3D (CRAT_CACHE_FLAGS_ENABLED |=
</p>
<p class=3D"x_xmsonormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CRAT_CACHE_FLAGS_=
DATA_CACHE |</p>
<p class=3D"x_xmsonormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CRAT_CACHE_FLAGS_=
SIMD_CACHE),</p>
<p class=3D"x_xmsonormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .num_cu_shared =3D 2,</p>
<p class=3D"x_xmsonormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; },</p>
<p class=3D"x_xmsonormal">+};</p>
<p class=3D"x_xmsonormal">+</p>
<p class=3D"x_xmsonormal">static void kfd_populated_cu_info_cpu(struct kfd_=
topology_device *dev,</p>
<p class=3D"x_xmsonormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct crat_subtype_computeunit *=
cu)</p>
<p class=3D"x_xmsonormal">{</p>
<p class=3D"x_xmsonormal">@@ -1514,11 +1562,14 @@ static int kfd_fill_gpu_c=
ache_info(struct kfd_dev *kdev,</p>
<p class=3D"x_xmsonormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; num_of_cache_types =3D ARRAY_SIZE(beige_goby_cache_info);</p=
>
<p class=3D"x_xmsonormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; break;</p>
<p class=3D"x_xmsonormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(10, 3, 3):</p>
<p class=3D"x_xmsonormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(10, 3, 6): /* TODO: Do=
uble check these on production silicon */</p>
<p class=3D"x_xmsonormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(10, 3, 7): /* TOD=
O: Double check these on production silicon */</p>
<p class=3D"x_xmsonormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;pcache_info =3D yellow_carp_cache_info;</p>
<p class=3D"x_xmsonormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; num_of_cache_types =3D ARRAY_SIZE(yellow_carp_cache_info);</=
p>
<p class=3D"x_xmsonormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; break;</p>
<p class=3D"x_xmsonormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(10, 3, 6):</p>
<p class=3D"x_xmsonormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; pcache_info =3D gc_10_3_6_cache_info;</p>
<p class=3D"x_xmsonormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; num_of_cache_types =3D ARRAY_SIZE(gc_10_3_6_cache_info);</p>
<p class=3D"x_xmsonormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; break;</p>
<p class=3D"x_xmsonormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(11, 0, 0):</p>
</div>
</div>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_BL1PR12MB5144A93784C379073A52FAECF7239BL1PR12MB5144namp_--
