Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4A47C02194
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Feb 2025 14:13:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6189D10EAE4;
	Fri,  7 Feb 2025 14:13:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ckWHgheS";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2079.outbound.protection.outlook.com [40.107.220.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E16510EAE4
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Feb 2025 14:09:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j5SbBiPFq4mut1nPM1pXYA5NTL9eG8rBQyjsVBXf1b94r3/snQA62kK7fuImMRFVpwCpiW1WJxaopZr6W439fx46RdyDgOdgLXWwEhgGD58an02ON54tux3FFRClBX00RYumdtIa2QwXJ+JWvjA/rpbmRtO3sL4T1PAnu1FatsidvY07qvlrchLCV56Y3+cMabK2bHGVvmt54ASvsy3Kd5+Ud7sPJ4FyUcAOBRjxkHr9LmGdQO6bB3sVPENQSK8PURPispdJDYklgJ0D3Mu3Hdst26Bk17q6vQdx0+Xsx4uj2mRjwgYmsZGeiV2eleFrMZvRhLTJrlXHWO+2xjIQNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XNGYiG5rEYvZ6NYM8nbFzA970aElYo8jwJJaJBNpQdk=;
 b=vWfda/xA1DS97n6I+4LMA83oMYVUrD62XaGDPB0xqAR8GzpNbMrLfuLJRdpsL/WXIqs3H4ijEJPtzVZjW19Il9vdkz+SuopWnZMlZfLObw/WyTnpgx4vANNtO9JtjzHqa62KlNcm+YW4kZuXEUbBzrMFmsMuvF9A9SyGhEIRRbXqulkgq5Mrf7McN7MVSVmus1JhJGfGG84yd2MgWINN056D43X5La0Dl4ak/vO90JEnBHeLx0OFqk2s8721g8FPEH0gmOGRVP51D6pboivVy8PCPULa6c4eKmJ2dJ2VoJ7iRdI1Sj3Z/k5XhSbxRp2HKcs/h4JfxmdpeA9QGQgvzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XNGYiG5rEYvZ6NYM8nbFzA970aElYo8jwJJaJBNpQdk=;
 b=ckWHgheSb6d5Dr5yGZo8i2iO7yvOiJ2t7a9zmPUi2TZobVGl3KMZkKp1ISuMlOqnm1FicxJq87bRl2bQHNvN9gj5YkGL2QWjX+5Af054Tfd0mEDhaPbZdxv6dmvRA5fJGNyUSudRvdDOchpjYlhq509OSPDQB5cMc1GNbt9E8nI=
Received: from CH0PR12MB5372.namprd12.prod.outlook.com (2603:10b6:610:d7::10)
 by PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Fri, 7 Feb
 2025 14:09:22 +0000
Received: from CH0PR12MB5372.namprd12.prod.outlook.com
 ([fe80::fec0:2b36:85c1:fc9b]) by CH0PR12MB5372.namprd12.prod.outlook.com
 ([fe80::fec0:2b36:85c1:fc9b%4]) with mapi id 15.20.8422.010; Fri, 7 Feb 2025
 14:09:22 +0000
From: "Liu, Shaoyun" <Shaoyun.Liu@amd.com>
To: "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "cao,
 lin" <lin.cao@amd.com>, "Chen, JingWen (Wayne)" <JingWen.Chen2@amd.com>
Subject: RE: [PATCH v3] drm/amdgpu/mes: Add cleaner shader fence address
 handling in MES for GFX11
Thread-Topic: [PATCH v3] drm/amdgpu/mes: Add cleaner shader fence address
 handling in MES for GFX11
Thread-Index: AQHbeUhfMCTrHUGl0UirpOi4oAUOG7M73YCg
Date: Fri, 7 Feb 2025 14:09:22 +0000
Message-ID: <CH0PR12MB5372454F0C760D60545AB9E5F4F12@CH0PR12MB5372.namprd12.prod.outlook.com>
References: <20250207100900.1115660-1-srinivasan.shanmugam@amd.com>
In-Reply-To: <20250207100900.1115660-1-srinivasan.shanmugam@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=1ac7a3a5-3198-456f-98d0-320ac11f1148;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-02-07T13:56:06Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR12MB5372:EE_|PH7PR12MB5685:EE_
x-ms-office365-filtering-correlation-id: 82191d41-5ffb-40d1-ffcd-08dd47810547
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?jyKowB619fpTkmsIssVlvRRpzI34MS1wHB5c+FuAa2GLL/3YLWQ4PPMlwN?=
 =?iso-8859-1?Q?19T+nPb/fL/QqZm2GEZgmC3vu9TJ434kBu81w3SY1CJs0BGF8Hfx79YTXu?=
 =?iso-8859-1?Q?SNvgSJNeQfR7G+uRY5BsuxTA2o3JiSMkqJUZRbLYUFbUg3NVrX41NErZF1?=
 =?iso-8859-1?Q?1H4cERMy4Vy4OYucPlguESQR8bwftw0ILoSGSSgtnO/cp9kGSq96kiM5IN?=
 =?iso-8859-1?Q?1PmtO44UlwUl1vSxtmFWv3qlltl9CmI6EEEAVgxCPPXf922OBNiQRQldRh?=
 =?iso-8859-1?Q?30QCyDtDeOR6D3gXpDO9t4TOC3VnArwRT+WhoLzwyd9aLRtwPb8KXDrnMt?=
 =?iso-8859-1?Q?iI1bxmFlBviyMR8WpWpUO4j8t489OWK0r1OpNnOqCURmOrNXfQ+p2XbHUS?=
 =?iso-8859-1?Q?tcJY//6DGe724mDmy/rzwMC2uhpBQeVihSjL0sTUqBQ1yoNxmXufBKpP/D?=
 =?iso-8859-1?Q?kuKDmhWKz0PaXYrX5sxGu6NwYxbh0GH27cKj3Z6ba5Lx/pkF+A3DNGBlfq?=
 =?iso-8859-1?Q?XkQn88YT3SbbZdDiWYHZePMfO3dC7I1djI3L03Oi7IShRTLu8UONSTCqSv?=
 =?iso-8859-1?Q?MiSjMNOmclXRkI98Szjl2pswtL69hiZTvrZVf9B9/hlvVyId5ttDZwFw0R?=
 =?iso-8859-1?Q?WAZWRnpeN8Eby9wbWvNH7GAXX+j2opDBK5xwEBlli7KwpumC5FrGPzKq1I?=
 =?iso-8859-1?Q?/gVMkTsXYz/OddtMC6+/Z6VQ4BzwoGp+K25xl04bFNvdhu2TrKChGH9939?=
 =?iso-8859-1?Q?9wgDIrStimTqcPTOPFYAd10ksCOykbUH6nklUz8vO2q0/hdQRyCP2fDBG3?=
 =?iso-8859-1?Q?/mcN7PB2wt29us0l4xROM53+mBr9W21V/fOsM5YehsnDv37145RoPPpbcJ?=
 =?iso-8859-1?Q?ZFTKhp5Iyv24VMA3iRWQPILRK+X/kaiuQ1tTdIPMkx5bO7IMGYPlSRzcxN?=
 =?iso-8859-1?Q?4EAR3b5fx2ZFM7Mfqq19mPWLGcCZFcH1arelaMsYDRM01Iy0VSIjAWk/A9?=
 =?iso-8859-1?Q?FG5dw/LvP+DSrg253yCkQF1CaplB5pX0USVeaAidSCTAKgJ9i/9lA4Puho?=
 =?iso-8859-1?Q?XIPV3XN9QuzXLi8wmaG/JVhQdXdDPZhJjvsDbtqv9mffyRnalbII/YJZOm?=
 =?iso-8859-1?Q?gXiXLbCjQcah5Mrhb9rNP6ILySj7OMl63osYUrRe5WA0MAZJrVK39Sa+xI?=
 =?iso-8859-1?Q?i8OdlPtGq0NH1DHPxqUE7Ys7u135iyUFjW8d0YQegkdswzaQNg4E13LOLq?=
 =?iso-8859-1?Q?/+hcOGg8Wd0vN02uLxI/trzYRtPM3suo7jwN3xhbwsms7vRIbJ78P2MM0Q?=
 =?iso-8859-1?Q?94Qz1gKKEvgUpHjtzUPXz1G0wz4GnXKuG6iNQ8wp1K+3gYYqfU2S8uOESg?=
 =?iso-8859-1?Q?TBig8VskROZf7ywxsHx1iVzX7Q8dQtcpii/Uhrsnn7Gvo4ndtFuOyU31Fm?=
 =?iso-8859-1?Q?bsfLiGUYplfKZ8lQ+ej+/QYCmqf/PfmW5AkXzwr0VX/CAS473KT2LKg307?=
 =?iso-8859-1?Q?V+HUplCJ9bWqnL7Tgj70r0?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5372.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Ufm4Ivxw7f/84+FrV1OfQ/jhfvZUPDnurctBZgqkka+sS/Jzd0eM+shDLR?=
 =?iso-8859-1?Q?vENYCNOateQohh0BaIZT4q+HOHGPFHdnMPy7paE7A0czxGV9kcZY8p8qg6?=
 =?iso-8859-1?Q?XhBiz3OWCMIx2aIjv6KOVKKYuwpeVjYogEenKFQ4XWwmFvMkPuvqt5BEyf?=
 =?iso-8859-1?Q?rlLhHqQfAhur+jiPdRszjGvYjr9jvFgwJMA43k52+dyHt34gzS2l6eF44Z?=
 =?iso-8859-1?Q?eqsYLGUbx40bCB06ajW64G1mHrbDzMWLr9HiNZmYIcVWIQJxZxCTa50q0c?=
 =?iso-8859-1?Q?W7gSri05lGHiskil7Vh+Ncft9obRtcs1sFCe0QJXG8bahaabc52mA65suR?=
 =?iso-8859-1?Q?zvlUAsLGd8px/zF/p0x8WH70ZVBZM9d7NMqTBY8s4zRGpTfMs9VfOBRivA?=
 =?iso-8859-1?Q?o0wMQ2qK5KS9a0uwXx7A1kSD3CQ+BcVgvjyX3d6T7mwUCThp+V3KENT535?=
 =?iso-8859-1?Q?dn4oNdYwtoOXkNLk5uE5BfizgisXb/ZiRgsBDeJu96tTikKPp5IyPe//nr?=
 =?iso-8859-1?Q?rkGKFaKKmqpPhBTvdHVjDThvd+e/BdiXlbafLN6LD70zd6mJlMo3/D69wD?=
 =?iso-8859-1?Q?QewnEoRD1QHFsTdrvz2ZhdLt3wqt4nHanJEAYWjyKzY3itSfyqztwyP1Yy?=
 =?iso-8859-1?Q?QLF+IaR+49QUW+FqPbvqU4bD09K1ti8Baxh2T7i9C2E8oPg9jCkvyDxNaf?=
 =?iso-8859-1?Q?z29v9MsCQY+WSXebkEN5T3jRq9kVSvqNkgKJcSljNOr4TPQlxpMmhNugfl?=
 =?iso-8859-1?Q?rz2Bs1+sWxhq0E5Xg5I+4JhsK5L6PGeN2YmSLJ3EdPaXvR4dHOuknVTCAG?=
 =?iso-8859-1?Q?TKF3I3Nuek84kwI0IC5dt4Ju8AOQ7yBItk246cv08jpkitSCv7l5kyUlaU?=
 =?iso-8859-1?Q?64HfzYYGDk1hKQnqslycppUEGQpHXLlnjmtpk8UgmtKNEoESEksck/ZTRe?=
 =?iso-8859-1?Q?OILSEcsuV3MuasoeqKSYtOBmAWCMyRrcE5JrlHfu4NNPSy9VdqqWqzcQ6u?=
 =?iso-8859-1?Q?bCI5b4wOjGr4lohUDpoRDUm90Xlq/Ac+tOv4/Yi0saC83CbnUAqWgKH6gb?=
 =?iso-8859-1?Q?DstutcpZEhPIb6nt5IexjJy7LCz6oOhdTEOd61Xxr02JO3qn0n3Fqi513O?=
 =?iso-8859-1?Q?6KrY+HXTxvpypslefSf3Z2yT+Lq7CeLgWMg6Uu846SAuADqxtKra3SG5p+?=
 =?iso-8859-1?Q?B4BYCpYCaIs6dR3oSVSZW6mJU6KlD/XstEyA+izfUSprLJdd9lLqjxGX9T?=
 =?iso-8859-1?Q?dvjkykuqV9GQYI8Ms//WCBg87E+3UY+Fpye/5luvI6x7T3ct3pW3i8yfVS?=
 =?iso-8859-1?Q?gMOyBdz91a+/0daJLrYackniL7UpqqCdGmwMmU7tAOsZK3kekLDcSbhfmS?=
 =?iso-8859-1?Q?AaXaBzU8zSWBVrN0BVRAN30jCU0lPhS0wZMmvb6mk9a8blO0Bu7NrUD236?=
 =?iso-8859-1?Q?fCA9ic3xijMFx9Wt3CfKT9zymP61PZy12hby9cWk6+HC2eqSTLD4tDcHEq?=
 =?iso-8859-1?Q?MQtayI1+YWNFD+rK2ETmjCsUCXKzHHFAwpfpLCa05iJbbYGO08mGzfF013?=
 =?iso-8859-1?Q?hl+OwEtlNdyvZvbTTmVHU93RAHUSq0a5G4Nygl0dFW2FvdZMFDUyQNECI0?=
 =?iso-8859-1?Q?YvIfq7xI91onc=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5372.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82191d41-5ffb-40d1-ffcd-08dd47810547
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2025 14:09:22.1390 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WpLqIm0bUM3V+TEZ0ApnlM6wl5Tltfk0Bxx87Dk3Q1BOWC2QNb425Y7yMB6oxhgxr3MLZbLYUH7/OLzyEAfZ0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5685
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

This fence address will be used in MES after  set_hw_resource_1 API, so you=
 can  not free the  mem directly in set_hw_resource_1 function .
You can simply  free it inside mes  hw_fini function to make it balance. An=
other more preferred way is allocate the  mem in amdgpu_mes_init and  free =
in amdgpu_mes_fini .

Regards
Shaoyun.liu

-----Original Message-----
From: SHANMUGAM, SRINIVASAN <SRINIVASAN.SHANMUGAM@amd.com>
Sent: Friday, February 7, 2025 5:09 AM
To: Koenig, Christian <Christian.Koenig@amd.com>; Deucher, Alexander <Alexa=
nder.Deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org; SHANMUGAM, SRINIVASAN <SRINIVASAN.SHANMU=
GAM@amd.com>; cao, lin <lin.cao@amd.com>; Chen, JingWen (Wayne) <JingWen.Ch=
en2@amd.com>; Liu, Shaoyun <Shaoyun.Liu@amd.com>
Subject: [PATCH v3] drm/amdgpu/mes: Add cleaner shader fence address handli=
ng in MES for GFX11

This commit introduces enhancements to the handling of the cleaner shader f=
ence in the AMDGPU MES driver:

- The MES (Microcode Execution Scheduler) now sends a PM4 packet to the
  KIQ (Kernel Interface Queue) to request the cleaner shader, ensuring
  that requests are handled in a controlled manner and avoiding the
  race conditions.
- The CP (Compute Processor) firmware has been updated to use a private
  bus for accessing specific registers, avoiding unnecessary operations
  that could lead to issues in VF (Virtual Function) mode.
- The cleaner shader fence memory address is now set correctly in the
  `mes_set_hw_res_pkt` structure, allowing for proper synchronization of
  the cleaner shader execution. This is done by calculating the address
  using the write-back memory base address and the cleaner fence offset.

- **Memory Offset Retrieval**: The line `ret =3D
  amdgpu_device_wb_get(adev, &cleaner_fence_offset);` retrieves the
  offset for the cleaner shader fence from the write-back (WB) memory.
  This is important for ensuring that the cleaner shader can synchronize
  its execution properly, as the offset is necessary to calculate the
  exact memory address where the fence will be located.

- **Setting Cleaner Shader Fence Address**: The line
  `mes_set_hw_res_pkt.cleaner_shader_fence_mc_addr =3D adev->wb.gpu_addr +
  (cleaner_fence_offset * 4);` sets the memory address for the cleaner
  shader fence in the `mes_set_hw_res_pkt` structure. This address is
  calculated by adding the base GPU address of the write-back memory to
  the calculated offset. By setting this address, the MES (Microcode
  Execution Scheduler) knows where to check for synchronization related
  to the cleaner shader, ensuring that it operates correctly and that
  the GPU is in a stable state before executing new tasks.

Cc: lin cao <lin.cao@amd.com>
Cc: Jingwen Chen <Jingwen.Chen2@amd.com>
Cc: Christian K=F6nig <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Suggested-by: Shaoyun Liu <shaoyun.liu@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
v2: The checks for amdgpu_sriov_is_mes_info_enable were removed to
    simplify the resource management logic in the MES initialization and
    finalization functions, ensuring that the necessary resources are alway=
s
    set up and cleaned up regardless of the SRIOV mode, thereby enhancing
    consistency in cleaner shader operations.

v3: amdgpu_device_wb_free(adev, cleaner_fence_offset); to release the WB
    entry and prevent memory leaks. (Kevin)

 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c | 37 +++++++++++++++++---------
 1 file changed, 24 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/a=
mdgpu/mes_v11_0.c
index bf51f3dcc130..ad849ff2fa7a 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -745,14 +745,21 @@ static int mes_v11_0_set_hw_resources_1(struct amdgpu=
_mes *mes)  {
        int size =3D 128 * PAGE_SIZE;
        int ret =3D 0;
+       u32 cleaner_fence_offset;
        struct amdgpu_device *adev =3D mes->adev;
        union MESAPI_SET_HW_RESOURCES_1 mes_set_hw_res_pkt;
        memset(&mes_set_hw_res_pkt, 0, sizeof(mes_set_hw_res_pkt));

+       ret =3D amdgpu_device_wb_get(adev, &cleaner_fence_offset);
+       if (ret)
+               return ret;
+
        mes_set_hw_res_pkt.header.type =3D MES_API_TYPE_SCHEDULER;
        mes_set_hw_res_pkt.header.opcode =3D MES_SCH_API_SET_HW_RSRC_1;
        mes_set_hw_res_pkt.header.dwsize =3D API_FRAME_SIZE_IN_DWORDS;
        mes_set_hw_res_pkt.enable_mes_info_ctx =3D 1;
+       mes_set_hw_res_pkt.cleaner_shader_fence_mc_addr =3D adev->wb.gpu_ad=
dr +
+                                                         (cleaner_fence_of=
fset * 4);

        ret =3D amdgpu_bo_create_kernel(adev, size, PAGE_SIZE,
                                AMDGPU_GEM_DOMAIN_VRAM,
@@ -766,9 +773,16 @@ static int mes_v11_0_set_hw_resources_1(struct amdgpu_=
mes *mes)

        mes_set_hw_res_pkt.mes_info_ctx_mc_addr =3D mes->resource_1_gpu_add=
r;
        mes_set_hw_res_pkt.mes_info_ctx_size =3D mes->resource_1->tbo.base.=
size;
-       return mes_v11_0_submit_pkt_and_poll_completion(mes,
-                       &mes_set_hw_res_pkt, sizeof(mes_set_hw_res_pkt),
-                       offsetof(union MESAPI_SET_HW_RESOURCES_1, api_statu=
s));
+
+       ret =3D mes_v11_0_submit_pkt_and_poll_completion(mes,
+                                                      &mes_set_hw_res_pkt,
+                                                      sizeof(mes_set_hw_re=
s_pkt),
+                                                      offsetof(union MESAP=
I_SET_HW_RESOURCES_1,
+                                                               api_status)=
);
+
+       amdgpu_device_wb_free(adev, cleaner_fence_offset);
+
+       return ret;
 }

 static int mes_v11_0_reset_legacy_queue(struct amdgpu_mes *mes, @@ -1632,1=
2 +1646,10 @@ static int mes_v11_0_hw_init(struct amdgpu_ip_block *ip_block=
)
        if (r)
                goto failure;

-       if (amdgpu_sriov_is_mes_info_enable(adev)) {
-               r =3D mes_v11_0_set_hw_resources_1(&adev->mes);
-               if (r) {
-                       DRM_ERROR("failed mes_v11_0_set_hw_resources_1, r=
=3D%d\n", r);
-                       goto failure;
-               }
+       r =3D mes_v11_0_set_hw_resources_1(&adev->mes);
+       if (r) {
+               DRM_ERROR("failed mes_v11_0_set_hw_resources_1, r=3D%d\n", =
r);
+               goto failure;
        }

        r =3D mes_v11_0_query_sched_status(&adev->mes);
@@ -1665,10 +1677,9 @@ static int mes_v11_0_hw_init(struct amdgpu_ip_block =
*ip_block)  static int mes_v11_0_hw_fini(struct amdgpu_ip_block *ip_block) =
 {
        struct amdgpu_device *adev =3D ip_block->adev;
-       if (amdgpu_sriov_is_mes_info_enable(adev)) {
-               amdgpu_bo_free_kernel(&adev->mes.resource_1, &adev->mes.res=
ource_1_gpu_addr,
-                                       &adev->mes.resource_1_addr);
-       }
+
+       amdgpu_bo_free_kernel(&adev->mes.resource_1, &adev->mes.resource_1_=
gpu_addr,
+                             &adev->mes.resource_1_addr);
        return 0;
 }

--
2.34.1

