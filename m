Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52184C5AE59
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Jun 2025 09:11:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E127F10E59F;
	Tue,  3 Jun 2025 09:10:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wUShlBgA";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2058.outbound.protection.outlook.com [40.107.102.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3343910E30C
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Jun 2025 09:10:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VUoYMhkHTjyoxlHCDR/ZuoCpIZ1llP7MpQjYbEQQG+bUe33GJA5qF4IM9jWSZOcVzukHlFEo12sW3Z3SQW5BsRl3lluYO1ML8iZgfrMMYHT88opHMJ+R0y0leJNRKRHes2yjebkNHOMQaX7IuGdK+E2Gl3KI8oyO2TMn+7/4SJa8aqVxgcscpiUm1ZvoNlu2vivuF0IfLiMWQ/RdAySLPqUgqOR+s+iltMgzZz83/Zk7ZGVSBSp7yIyaC34xNEcQmfT6su0LERLtMgowGkT5zcc3O4MczwkOGK7YGP+7o+EMgBXFbKGORgkgJE0zrrIxx+ORyXBJnWMSEyHX3vRevw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eTqHIKCx5tStNKodMuLctTxy9VLBG1UmX/4m+hDCBuY=;
 b=feywhVYrBa731SXj4FVZT3qvLJPfnaAcA/GCk8Go0HqvV6Z5iVO6DAIiUfV/y0jQRjwphxG12JFYXFaJ9Y4Y+aX9S0TEn7P/bHh4MhcdBab1jQ97VD0ixGZUHnardwsvQ0L7aMZlYLIqZ1VcnEqIqq3be70An6dnGXHgLIFPPLKn90mLSqLx63imYU6fufH/y65Qf1+jeeAl1oC145eZ6sxsTiLzHP1DDlhIiJKysd0T6ARUtNf3kMlsMfR+2+brIutLqGvik91YY6QiA2DFjR6YnewBOO4pTSzfE/G854/Nr7nEJMXw5kvAnraOfflr5i6dHVsB4SWmB2q46He1yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eTqHIKCx5tStNKodMuLctTxy9VLBG1UmX/4m+hDCBuY=;
 b=wUShlBgAyAoVv3AP6x2sky3l7MJUfV1eFkINiBuyYvk2jevSgUR5FYJ+LCHZBcE9QzpOmvcShVpegGKzOcBYWUKCSW0Dl4D6m3DSkB3yKq4yhKyuLgjEMdY3Jnyb82/dSk8/BgjFlGnJxpdyXmFV186BexfEgTttK+tQdjCz+aU=
Received: from PH0PR12MB5417.namprd12.prod.outlook.com (2603:10b6:510:e1::10)
 by IA1PR12MB8588.namprd12.prod.outlook.com (2603:10b6:208:44f::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.31; Tue, 3 Jun
 2025 09:10:50 +0000
Received: from PH0PR12MB5417.namprd12.prod.outlook.com
 ([fe80::de07:ec43:e847:2f50]) by PH0PR12MB5417.namprd12.prod.outlook.com
 ([fe80::de07:ec43:e847:2f50%4]) with mapi id 15.20.8769.037; Tue, 3 Jun 2025
 09:10:50 +0000
From: "Deng, Emily" <Emily.Deng@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>, "Chen, Horace"
 <Horace.Chen@amd.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Zhang,
 Owen(SRDC)" <Owen.Zhang2@amd.com>
Subject: RE: [PATCH v2] drm/amdkfd: Move the process suspend and resume out of
 full access
Thread-Topic: [PATCH v2] drm/amdkfd: Move the process suspend and resume out
 of full access
Thread-Index: AQHbzvUTZbMMhfehQE6fQzi1RSDgA7PnkvwwgALWOhCAAIkTAIAGPmuQ
Date: Tue, 3 Jun 2025 09:10:49 +0000
Message-ID: <PH0PR12MB5417C3C96F3FDA51A9F3BF6B8F6DA@PH0PR12MB5417.namprd12.prod.outlook.com>
References: <20250527104943.3020168-1-Emily.Deng@amd.com>
 <PH0PR12MB5417B96B410513A018108C208F67A@PH0PR12MB5417.namprd12.prod.outlook.com>
 <PH0PR12MB5417541194A32741CF817B898F61A@PH0PR12MB5417.namprd12.prod.outlook.com>
 <IA1PR12MB8405DF7195A951957697A569A861A@IA1PR12MB8405.namprd12.prod.outlook.com>
In-Reply-To: <IA1PR12MB8405DF7195A951957697A569A861A@IA1PR12MB8405.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=bc3e1e79-46d5-483c-add9-89294efd6437;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-05-28T06:19:21Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5417:EE_|IA1PR12MB8588:EE_
x-ms-office365-filtering-correlation-id: 6a4b3edd-511f-4f48-d8b5-08dda27e88c1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?2xqwjHge60zWZi5gE4cWvLoKUOQ5Gr2/yr/4qquZBLs2BXm/jvdLyx5culw7?=
 =?us-ascii?Q?Yb+QtqmZ8tj1Vh8E/6COLy/FaESw0znxggc/2pc0IFg2XuuaNSBT8sRZ+YHV?=
 =?us-ascii?Q?ApnCOcMbWR0aeK6adZc6mfi6O38vjMru5VAFHe0nSaRPv59AhgsqxcnMd5Ho?=
 =?us-ascii?Q?ctE6kwvW4m0RA9HRr0jIW4KXFhxZ03hsWqkXt7Dy1Gw09B0t/B6FMFpEnI+Y?=
 =?us-ascii?Q?ZF0Cemb3esGNewiBFCUpWBgm30R7pRb2lgBpy0Ls067UdioIDIteSY12qatd?=
 =?us-ascii?Q?U83XLdpirzFZV8ex50t8Lmkh876d1hcxlAOaqljuCP6zPIGza6CAIOoxnl6L?=
 =?us-ascii?Q?h7mcGPQYrvZkE20gvCGOo+EdKX8MqKXbybzYpgrglT9CCOuoCBqUj3kzu4a7?=
 =?us-ascii?Q?OP9X3HWaGE6TjyUltC9LX3CRSdbLW9+dPxQyOF/h+fwdE4JJGYUMZmxx/pHh?=
 =?us-ascii?Q?bLYSMu3CjvZOq5/CYItVJGyl9b4Hb6Yw0NQrxJylFIbiKH6kYLntNNtQAdvc?=
 =?us-ascii?Q?E6SAU5QIGv6P//tyP5FthbF7pN61iQHuqLnOmFGUtVZMbFUrtVXJ64t+9j3T?=
 =?us-ascii?Q?QsQYOaZBs8a9AFahUXy0jt9eyWlNZcbYA71dmb+PRJCCYsgDlI1wOyvFJiPq?=
 =?us-ascii?Q?NP/bUI/NeqKHXHpxvyaj6LrMr/8ZMB6SwF7bE4UOUsO/YSqd943yEFePkZ7I?=
 =?us-ascii?Q?fsLSg+cNSmeCX8MhwTbON0dz89aqS1ApLHtJc4ncbNp1BC+4y+sja8lSrPPM?=
 =?us-ascii?Q?yRlIKJylgzAmrveAfiQMj58XH9rz8kq61mjzBe/YTMGI/CRAZINl/ARWheAc?=
 =?us-ascii?Q?STraSknKK+/ZsV/Fz1XBF1tysxZ6FeKwjiDW4aJl/ycomCVqz2UQWzliJncR?=
 =?us-ascii?Q?7YYVjXYo4eiOEpcPd/5VvOfzP9lACT6dSY0VoDXu1COy5JcDXoetqQNnJ+1w?=
 =?us-ascii?Q?qP8QXFL4GclWA4GkKF+lprO0l6kETlTEa06Rd+O5nd9sZzoNbUdJEr9tj2o4?=
 =?us-ascii?Q?516pWX8c1lyMRqEuSosZGcn5DGwiG3GQXXkJ9DakrUYtNz6yGPIii83oWtre?=
 =?us-ascii?Q?6tDGMmBCZSsm1IkUzNPRkhyMCcdko0NoPONcHy6lWQlcWy0V6dPe+14HaVTw?=
 =?us-ascii?Q?CLpQHVPrd14+fYV3MHMl7UOFnCv/YvUJg/FEaP/Wq2nj9Ctpb5hYfWszzcUu?=
 =?us-ascii?Q?9j4ft41T/rfvvU9rlzTZYQ90qudmTYtAbkD6zMaQQeeClh7O4Ul8b6ghAmBS?=
 =?us-ascii?Q?URdwS68MxVzNyKIM/RXyfgqcYhOwpxme6OEXBDjLqcZVX2sQRwXWq4aNCvsK?=
 =?us-ascii?Q?ux1kIvvjsRx4545FlIN3FyLuOPMLhd9Eb7YEnwd6LzaxAcADMKqACTOoVeYA?=
 =?us-ascii?Q?ubYWIcuIn6NFFSiB/HNjy4Ip0qa7z7d1JvUGVFtRKU1w2TaWot4BN2s4PYjS?=
 =?us-ascii?Q?wbb83dAkYPH8Fp3oJVPGcUygkPqmPRCIhzvqc2D6aWNQxX6InBJTvOf+yaYd?=
 =?us-ascii?Q?vxyQW14+cX6gYvs=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB5417.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?fOhjJ9IADxOKkWFsijWsPOMylVvnyxfj9+9kluTcd/6ZpWqBe+fuUJOPq+oc?=
 =?us-ascii?Q?3ORF4Zp3I2jB/bp1Ukr9WZZE9YCnj4E81NdQQ2EQAtCdC/znwCmWWNp13W+K?=
 =?us-ascii?Q?MkmYJ8+E0/Rz+U7YOCcu1jwUHDK7O2pXh7FE7S+4XgLZhs7nt2LV7J2pxrPV?=
 =?us-ascii?Q?Wp+CWd/y8GwQgVleKDybcdHBA+LYvvf/lFeynNKKTpvSyhV0XLQ9Ah4pl/FS?=
 =?us-ascii?Q?OMVLf5oS96izbAofxn7scbpGMzmYV8LGHGE6rzmMvk3qsl4lzl/3ehrYjrzq?=
 =?us-ascii?Q?LjLv2vHBBzgaNh46wSCvHI/+ulEmOXwWo25AvjWZWcbD94inNqy5Hjk+465q?=
 =?us-ascii?Q?a1fp2kFpS1gBjo9uH9902PNwQHQQV/Qfapv5se3BelHL437Rx/48YMP3Amg2?=
 =?us-ascii?Q?IcHe0HMFZf8zTERzBH2BEhU0bfVn/lIDOl8VcTSJiEPs0C/IxqK++n4OLQEc?=
 =?us-ascii?Q?NPsQXtNGJCaE6Fg+N6IZaLVvrt2m8njF488G2LqnUWCzU3yIpVFcdq6oPzNP?=
 =?us-ascii?Q?17skCqEn7tJFsxwzrybeeTzz+1vRaxc5CjflXWOuTgdp7g4xLUTu6HlH692n?=
 =?us-ascii?Q?rZSrezJ1uhz1AVILUhD8K06MtOySfqegTNtw0O+jy41RiSj/Efa+QIFzenY3?=
 =?us-ascii?Q?gA/k+sknczRLcIf1uyPh+sH1l455zJfbGINUYlgHXv96D2mH6kzYN1cKV7MS?=
 =?us-ascii?Q?UaPJcQq7OwmmbT8QbGb4w38sC2HKSt6vbT+6PyLnGrvyJqB9YUTTPaLaTvK3?=
 =?us-ascii?Q?RrzIntIwYmoWRnLdWmpLsDDcjv1wMbgkmKYJSju3mdiqHhqtxD9cwAeXehvo?=
 =?us-ascii?Q?FvDHs6tGMFQcKII+tdnQU40azOdcKTbqb/J/PfXclyQXGskuJO+42eZmIb1g?=
 =?us-ascii?Q?gpq97WIFzmfjYcNHRSr3kUFr9b+fu/Wbp4PLb0Jhq2trNETfAee6nGimiXMF?=
 =?us-ascii?Q?r9536WT7x9lyfC4LVgel0P/2BIp+QQZRuxpLJJlEFPjlF+U69dTZsRhE2qDY?=
 =?us-ascii?Q?pt1S+rv22An0GgCWcpSbyMltKPQa2ZzV8yfHKLJ35iNHjspyPoBm93u3Wymd?=
 =?us-ascii?Q?XuDOhe14Fj3aLHv15967PGbui0z00WL1UJe8KNFsxGqvVf1+sUsaSCo7A/rv?=
 =?us-ascii?Q?TdtROrJLEp+YKE8NNcGnBGpgK0zt+RbJMJtfQlDBj2+P3k92TlSnYnsrGfnG?=
 =?us-ascii?Q?+r+KHK8zvM8SGr1JzmFBsIZTaua8tQy+5iuw5Hr2gZERPEAltXraG/b2BPWr?=
 =?us-ascii?Q?7hajcuL1MZjO8SCvX2NQWOlYsQJarKIpC40FX087NT8zdB787EzdiXRcUSBv?=
 =?us-ascii?Q?c0f/PRzoJsUuGOnqktonf0P5D56ORkg7Ivbbk70eHcmTkRrdWS6eXP/5LOj2?=
 =?us-ascii?Q?ldlSe3F0gskBEokcb0BKBToTMR705EuMLXU3jRpLyHsce71vA3lERXP8fBIs?=
 =?us-ascii?Q?DyaCtTrLoqK0J9Fdhjld32ZqRY4Y3w3Ufwg6ofp5u8CbmHL0HqaqU0oiELnq?=
 =?us-ascii?Q?ofAz3s4G6aGcPwDHVZec2K25oTpfAbJ13Pb7M6NhNpfMXbDeJgyP6qZED6/e?=
 =?us-ascii?Q?eE0i7SFlEw4c5U9JLik=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5417.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a4b3edd-511f-4f48-d8b5-08dda27e88c1
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2025 09:10:49.9834 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Tt7SKNnueek6JP4QmlprzRBPaFl7LAviL+/S3Y/TVwcwDMKFdPygoV6eyk2nIZxP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8588
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

Hi Christian and Horace,
     Could you help to review this?

Emily Deng
Best Wishes



>-----Original Message-----
>From: Zhang, Owen(SRDC) <Owen.Zhang2@amd.com>
>Sent: Friday, May 30, 2025 5:50 PM
>To: Deng, Emily <Emily.Deng@amd.com>; amd-gfx@lists.freedesktop.org
>Subject: RE: [PATCH v2] drm/amdkfd: Move the process suspend and resume ou=
t of
>full access
>
>[AMD Official Use Only - AMD Internal Distribution Only]
>
>Hi Team, @amd-gfx@lists.freedesktop.org
>
>Can you pls review and provide your inputs? Thanks for support!
>
>
>Rgds/Owen
>
>-----Original Message-----
>From: Deng, Emily <Emily.Deng@amd.com>
>Sent: Friday, May 30, 2025 9:39 AM
>To: amd-gfx@lists.freedesktop.org
>Cc: Zhang, Owen(SRDC) <Owen.Zhang2@amd.com>
>Subject: RE: [PATCH v2] drm/amdkfd: Move the process suspend and resume ou=
t of
>full access
>
>[AMD Official Use Only - AMD Internal Distribution Only]
>
>Ping......
>
>Emily Deng
>Best Wishes
>
>
>
>>-----Original Message-----
>>From: Deng, Emily <Emily.Deng@amd.com>
>>Sent: Wednesday, May 28, 2025 2:20 PM
>>To: Deng, Emily <Emily.Deng@amd.com>; amd-gfx@lists.freedesktop.org
>>Cc: Zhang, Owen(SRDC) <Owen.Zhang2@amd.com>
>>Subject: RE: [PATCH v2] drm/amdkfd: Move the process suspend and resume
>>out of full access
>>
>>[AMD Official Use Only - AMD Internal Distribution Only]
>>
>>>-----Original Message-----
>>>From: Emily Deng <Emily.Deng@amd.com>
>>>Sent: Tuesday, May 27, 2025 6:50 PM
>>>To: amd-gfx@lists.freedesktop.org
>>>Cc: Deng, Emily <Emily.Deng@amd.com>
>>>Subject: [PATCH v2] drm/amdkfd: Move the process suspend and resume
>>>out of full access
>>>
>>>For the suspend and resume process, exclusive access is not required.
>>>Therefore, it can be moved out of the full access section to reduce
>>>the duration of exclusive access.
>>>
>>>Signed-off-by: Emily Deng <Emily.Deng@amd.com>
>>>---
>>> drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 16 +++++++++
>>>drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h | 13 +++++++
>>>drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 12 +++++--
>>> drivers/gpu/drm/amd/amdkfd/kfd_device.c    | 40 +++++++++++++++++-----
>>> 4 files changed, 70 insertions(+), 11 deletions(-)
>>>
>>>diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>>>b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>>>index 4cec3a873995..ba07e9c6619d 100644
>>>--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>>>+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>>>@@ -264,6 +264,22 @@ int amdgpu_amdkfd_resume(struct amdgpu_device
>>>*adev, bool run_pm)
>>>       return r;
>>> }
>>>
>>>+void amdgpu_amdkfd_suspend_process(struct amdgpu_device *adev, bool
>>>+run_pm) {
>>>+      if (adev->kfd.dev)
>>>+              kgd2kfd_suspend_process(adev->kfd.dev, run_pm); }
>>>+
>>>+int amdgpu_amdkfd_resume_process(struct amdgpu_device *adev, bool
>>>+run_pm) {
>>>+      int r =3D 0;
>>>+
>>>+      if (adev->kfd.dev)
>>>+              r =3D kgd2kfd_resume_process(adev->kfd.dev, run_pm);
>>>+
>>>+      return r;
>>>+}
>>>+
>>> int amdgpu_amdkfd_pre_reset(struct amdgpu_device *adev,
>>>                           struct amdgpu_reset_context *reset_context)
>>>{ diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>>>b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>>>index b6ca41859b53..841ae8b75ab1 100644
>>>--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>>>+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>>>@@ -156,6 +156,8 @@ void amdgpu_amdkfd_fini(void);
>>>
>>> void amdgpu_amdkfd_suspend(struct amdgpu_device *adev, bool run_pm);
>>>int amdgpu_amdkfd_resume(struct amdgpu_device *adev, bool run_pm);
>>>+void amdgpu_amdkfd_suspend_process(struct amdgpu_device *adev, bool
>>>+run_pm); int amdgpu_amdkfd_resume_process(struct amdgpu_device *adev,
>>>+bool run_pm);
>>> void amdgpu_amdkfd_interrupt(struct amdgpu_device *adev,
>>>                       const void *ih_ring_entry); void
>>> amdgpu_amdkfd_device_probe(struct amdgpu_device *adev); @@ -413,6
>>>+415,8 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,  void
>>>kgd2kfd_device_exit(struct kfd_dev *kfd);  void kgd2kfd_suspend(struct
>>>kfd_dev *kfd, bool run_pm);  int kgd2kfd_resume(struct kfd_dev *kfd,
>>>bool run_pm);
>>>+void kgd2kfd_suspend_process(struct kfd_dev *kfd, bool run_pm); int
>>>+kgd2kfd_resume_process(struct kfd_dev *kfd, bool run_pm);
>>> int kgd2kfd_pre_reset(struct kfd_dev *kfd,
>>>                     struct amdgpu_reset_context *reset_context);  int
>>>kgd2kfd_post_reset(struct kfd_dev *kfd); @@ -463,6 +467,15 @@ static
>>>inline int kgd2kfd_resume(struct kfd_dev *kfd, bool run_pm)
>>>       return 0;
>>> }
>>>
>>>+static inline void kgd2kfd_suspend_process(struct kfd_dev *kfd, bool
>>>+run_pm) { }
>>>+
>>>+static inline int kgd2kfd_resume_process(struct kfd_dev *kfd, bool
>>>+run_pm) {
>>>+      return 0;
>>>+}
>>>+
>>> static inline int kgd2kfd_pre_reset(struct kfd_dev *kfd,
>>>                                   struct amdgpu_reset_context
>>>*reset_context)  { diff -- git
>>>a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>index 625c416c7d45..6e29f8bd54bb 100644
>>>--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>@@ -5080,7 +5080,7 @@ int amdgpu_device_suspend(struct drm_device
>>>*dev, bool
>>>notify_clients)
>>>       amdgpu_device_ip_suspend_phase1(adev);
>>>
>>>       if (!adev->in_s0ix) {
>>>-              amdgpu_amdkfd_suspend(adev, adev->in_runpm);
>>>+              amdgpu_amdkfd_suspend(adev, !amdgpu_sriov_runtime(adev)
>>>+ ||
>>>+adev->in_runpm);
>>>               amdgpu_userq_suspend(adev);
>>>       }
>>>
>>>@@ -5097,6 +5097,9 @@ int amdgpu_device_suspend(struct drm_device
>>>*dev, bool
>>>notify_clients)
>>>       if (amdgpu_sriov_vf(adev))
>>>               amdgpu_virt_release_full_gpu(adev, false);
>>>
>>>+      if (!adev->in_s0ix)
>>>+              amdgpu_amdkfd_suspend_process(adev, adev->in_runpm);
>>>+
>>>       r =3D amdgpu_dpm_notify_rlc_state(adev, false);
>>>       if (r)
>>>               return r;
>>>@@ -5178,7 +5181,7 @@ int amdgpu_device_resume(struct drm_device *dev,
>>>bool
>>>notify_clients)
>>>       }
>>>
>>>       if (!adev->in_s0ix) {
>>>-              r =3D amdgpu_amdkfd_resume(adev, adev->in_runpm);
>>>+              r =3D amdgpu_amdkfd_resume(adev,
>>>+ !amdgpu_sriov_runtime(adev) ||
>>>+adev->in_runpm);
>>>               if (r)
>>>                       goto exit;
>>>
>>>@@ -5199,6 +5202,11 @@ int amdgpu_device_resume(struct drm_device
>>>*dev, bool
>>>notify_clients)
>>>               amdgpu_virt_release_full_gpu(adev, true);
>>>       }
>>>
>>>+      if (!adev->in_s0ix) {
>>>+              r =3D amdgpu_amdkfd_resume_process(adev, adev->in_runpm);
>>>+              if (r)
>>>+                      goto exit;
>>>+      }
>>>       if (r)
>>>               return r;
>>>
>>>diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>>>b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>>>index bf0854bd5555..22c6ef7c42b6 100644
>>>--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>>>+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>>>@@ -1027,15 +1027,7 @@ void kgd2kfd_suspend(struct kfd_dev *kfd, bool
>>run_pm)
>>>       if (!kfd->init_complete)
>>>               return;
>>>
>>>-      /* for runtime suspend, skip locking kfd */
>>>-      if (!run_pm) {
>>>-              mutex_lock(&kfd_processes_mutex);
>>>-              /* For first KFD device suspend all the KFD processes */
>>>-              if (++kfd_locked =3D=3D 1)
>>>-                      kfd_suspend_all_processes();
>>>-              mutex_unlock(&kfd_processes_mutex);
>>>-      }
>>>-
>>>+      kgd2kfd_suspend_process(kfd, run_pm);
>>>       for (i =3D 0; i < kfd->num_nodes; i++) {
>>>               node =3D kfd->nodes[i];
>>>               node->dqm->ops.stop(node->dqm); @@ -1055,6 +1047,36 @@
>>>int kgd2kfd_resume(struct kfd_dev *kfd, bool run_pm)
>>>                       return ret;
>>>       }
>>>
>>>+      ret =3D kgd2kfd_resume_process(kfd, run_pm);
>>>+
>>>+      return ret;
>>>+}
>>>+
>>>+void kgd2kfd_suspend_process(struct kfd_dev *kfd, bool run_pm) {
>>>+      struct kfd_node *node;
>>>+      int i;
>>>+
>>>+      if (!kfd->init_complete)
>>>+              return;
>>>+
>>>+      /* for runtime suspend, skip locking kfd */
>>>+      if (!run_pm) {
>>>+              mutex_lock(&kfd_processes_mutex);
>>>+              /* For first KFD device suspend all the KFD processes */
>>>+              if (++kfd_locked =3D=3D 1)
>>>+                      kfd_suspend_all_processes();
>>>+              mutex_unlock(&kfd_processes_mutex);
>>>+      }
>>>+}
>>>+
>>>+int kgd2kfd_resume_process(struct kfd_dev *kfd, bool run_pm) {
>>>+      int ret, i;
>>>+
>>>+      if (!kfd->init_complete)
>>>+              return 0;
>>>+
>>>       /* for runtime resume, skip unlocking kfd */
>>>       if (!run_pm) {
>>>               mutex_lock(&kfd_processes_mutex);
>>>--
>>>2.34.1
>>
>
>

