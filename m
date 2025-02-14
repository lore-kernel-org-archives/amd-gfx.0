Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59627C021A4
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Feb 2025 17:41:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0960910ED27;
	Fri, 14 Feb 2025 17:41:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lqeoIbr6";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2044.outbound.protection.outlook.com [40.107.94.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7184610ED26
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Feb 2025 17:41:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lXyozw4JGKdqU749WiJRGrWueLPC0nmCN9QbtLwBGyrObJfG7bj4Rz3hINWMjwbIVkUWcmlAac159VHFpQdAM/pSnMRDZNZabrMr+nsbeSSKJfnRmCY9QGDaB6LzKF2lHKjpgzvehP7vK6bJtI8iWeiAXPoWcFcLB4b2gGK7LDV97q8Vq3gCZGHunt4W+vqVHXzWs+F8OhitXguUcZuhFIrk1aEWMxEVThoDlSKswGgmcddf7rHCEbpTO2C+QAQGZ+LcjKNzcobvH4LjessJbrrygamXrNhMMR22hmtyC2qu6sZFRDFTzEY/aWt+TWNf2MkdIAc2/mVgjVr9r9KljA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=loXP9+uyccs0E68jrvARoaDBD6WA7VadhCUvFfn/YCw=;
 b=V33eHFV4zyWH7p6vWN0X45750+FRqzLeeMalOIF620z2THgtrNHWThveUrmk22oghnWySCkQu/740NFmOeOWTnYyT91N+/Ghn7eSQQsG9atzrtyf+ICJgEBF/a/Hp+TDGw/uxuvKXtYu0NYEdJW3bAeqb7UYCYIfPKJHreJoWPg/7/2D2VfPymYLA0qHsqLINJRsryjiP6appnKWyYDq1NW3CJr4onvYSQf9/ffep0bKRezUbE54rI1QhQLT2B9rXH0b1cGtBd8Z4lh3njfGzQOhgtuLTg1XYn0ywjOW2Nh98b1Y6VRfpkrYssXtQeVIedkpWDn+SNDJajSWv/RSEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=loXP9+uyccs0E68jrvARoaDBD6WA7VadhCUvFfn/YCw=;
 b=lqeoIbr60hv7dtCSnOCHAvBMGaP40FNUSMPnhBdsyYE7/WOvhmimhauSkJF49w1NTKLDyYhViQRdA2ljCsY8URpPkTbzenNvneov6PEp2Ts5h1vffgjtlU7YY8mtS3ipXuAgqLv4LWq68DvSujJ86TyMBxmI0qAqdnZE4+j/aFc=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by DM6PR12MB4042.namprd12.prod.outlook.com (2603:10b6:5:215::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.19; Fri, 14 Feb
 2025 17:41:35 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::491a:cce3:e531:3c42]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::491a:cce3:e531:3c42%4]) with mapi id 15.20.8445.016; Fri, 14 Feb 2025
 17:41:35 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Liu, Shaoyun" <Shaoyun.Liu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 2/2] drm/amdgpu/mes12: allocate hw_resource_1 buffer once
Thread-Topic: [PATCH 2/2] drm/amdgpu/mes12: allocate hw_resource_1 buffer once
Thread-Index: AQHbfvPRnxLqKvOK+02RJB3+fiwCRbNHAcaAgAAB77uAAAxjAIAAAU5Z
Date: Fri, 14 Feb 2025 17:41:35 +0000
Message-ID: <BL1PR12MB5144F2DD16616390864C9B72F7FE2@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20250214151901.2071738-1-alexander.deucher@amd.com>
 <20250214151901.2071738-2-alexander.deucher@amd.com>
 <CH0PR12MB5372425560C5BE3E4FED28B8F4FE2@CH0PR12MB5372.namprd12.prod.outlook.com>
 <BL1PR12MB5144F31AC0DD465DD9D63EB6F7FE2@BL1PR12MB5144.namprd12.prod.outlook.com>
 <CH0PR12MB53727651D93D9CE233CB86CFF4FE2@CH0PR12MB5372.namprd12.prod.outlook.com>
In-Reply-To: <CH0PR12MB53727651D93D9CE233CB86CFF4FE2@CH0PR12MB5372.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-02-14T17:41:34.850Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|DM6PR12MB4042:EE_
x-ms-office365-filtering-correlation-id: 50d7886a-4274-48a3-8a8e-08dd4d1ed3b8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700018|7053199007|8096899003; 
x-microsoft-antispam-message-info: =?us-ascii?Q?RhVpufA9o6aQvWYAbTFEhVmeBQbQOi1WF4ED7cB3Ghs99UwZ8QPHFKP6JyL9?=
 =?us-ascii?Q?EjJNKgBec1yyL78DviN49pMftLdaBpdCCIbEYhpCUmy8bOpVk7Lfx6EBfB/z?=
 =?us-ascii?Q?2ZpkiodqYo4Cu7GJXTrMtukVpcbu4OE7hUtVdi6Ku3A7UKxsWsM6gm79iM0g?=
 =?us-ascii?Q?dZziDB4nURhPINFpfSfIKYEiVRH7upqq9LN3Znskopa6ZzM9cusAHEq19zg0?=
 =?us-ascii?Q?sHyPmFf9frRy6/eshf9HTKD9ipEQM7BeP3hewhRUUzZgTJgYRiQMfU3amVF4?=
 =?us-ascii?Q?fjuagh6ZhFLvbKDWbZsXzn11lgzcIzGgVJHiTr+cs2vC738dUnx0yQv/G7Yc?=
 =?us-ascii?Q?eWNA46zVpdYQBqL3dL1Q+u2003AlYCKhHcOpLe6v3msKMIVSyV4YwHIx2mKQ?=
 =?us-ascii?Q?ngmKKSa4XYXK2YME5q6LJNT7cv9gvRqAqOdiT693lFHvu90IPGcfw3+bi9nw?=
 =?us-ascii?Q?24W7smCrMaD/+K4CBRQshmYwHbp3MKrId1xEe95vtcvmroiZIVlCir27yn5m?=
 =?us-ascii?Q?bXupyCPMKCaljyvUatsoRDfiYXiLD1TdWr06XFzU/7ane8q7SrUS7q7Kv4oM?=
 =?us-ascii?Q?vsCcqlaNb7RPYBa9L1tqaYlTQPTLJUa6qCE10mnqRr2rkNABHScyZrQKc73f?=
 =?us-ascii?Q?1juZvAd9vQiePVeGZw2SR0hFUCzQ4Z9U8i0Ov9SEAJ825lqd+Nj7tQ1TBo6v?=
 =?us-ascii?Q?/UXVFyG5DuSQFXbR7wD+WtrbqaqSV9d8oftP87to4eh5M1RNnS16DTnhNikE?=
 =?us-ascii?Q?Gxt4npLXAorjuG9V/8MAwcqNLrchlFppMxkpLhf6N7Jndds1bqEnnDlVRfU2?=
 =?us-ascii?Q?vwwUpux24vWV9EDE2W0FuhSfslwQyOw9A990uz/21WhJfG3j3jiHWaX4TE22?=
 =?us-ascii?Q?X27xsmO4bbI/zW1yOc4lTq8J+nl/Jd8sqAvJ8ovh5P2Z7aDZlZMTVv1Foxem?=
 =?us-ascii?Q?0kbll+JtPuN7NL/AObD/26SI28p/Lt+BjOeIp30lgKwceXbv6W9GYMP8sM68?=
 =?us-ascii?Q?AscnSbZtdxwujdAfT3fGd+diuQxlpnHdVXrr/+i2RusXQkUoNdbTjC3/z9tv?=
 =?us-ascii?Q?CmoBwgPDNa6En355rRS0Puvfa4J9v6MBW64pNJ0fr2vh+5EtovsLlXXuyNGL?=
 =?us-ascii?Q?hF/XXFzSCT2gmJKoUYVOpCBa5tyzR5QT1FHqAuHgnHnIKUs6DJo474v6Bp9E?=
 =?us-ascii?Q?QNZRvufM9FgJZ+iF2Kxt1kX/4vg/IEFkZtpCYf/5kaDdixxgMvr0+LLz8a4i?=
 =?us-ascii?Q?MmV6tULbsZexzlEzeYGSwAy0A5GVsCZ1A+auceKoURH9Oo6PrOXeO/wHJTiC?=
 =?us-ascii?Q?Wd+1EDphmYkrHeTMN6m/ExRYPNBvxP1eu4J8XB5nAJRML2R+Wo1Un+txfsg1?=
 =?us-ascii?Q?S1a9tas+2diETbWbRE2qbPbYkI8FPFpoo/IFChILTL9eU/tL6VSJ4Y9mHLxA?=
 =?us-ascii?Q?WYnEgkUzORLbBI811lE8o0vn8+6U1jyB?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018)(7053199007)(8096899003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Gq76oStuK0hnORRScB9BYPg129Yww8M8oSUmk9L308a+8jOinSxshCVvGCyg?=
 =?us-ascii?Q?V10D7xVod+t/bOiakaW8WZEUkq6lUg7jf2uGMmNie0HZD6zvxlA7ZwsHyNi6?=
 =?us-ascii?Q?ouygmZNeHgFaKGo/aatHE9BsMMrrHcZoGcdx+uRZtkCOLW6qJy0iImSN1Lxr?=
 =?us-ascii?Q?7m9BIjZJHGqM/nOfZnIyjAuDf/OzgdS5VGqmsYSmH8rCRMGdV2JixTkDOiVI?=
 =?us-ascii?Q?AZhQQR/N5krF4/N4gQbi+A9F0M5yGYnqw12jytT1jJEb+jdP1RHTqcdBi7Sp?=
 =?us-ascii?Q?p5oEM94gRARqNZwAdC5L7cOzK4MWbz+Z97IllBnKtSXGcU6RUgSe5muG0V1O?=
 =?us-ascii?Q?6ajcNpIRCMCmx8jUJt4V3aaHDtmAICcRUsErFwWTMxiwBJHca4HPg1MWJujV?=
 =?us-ascii?Q?KOECWy6mHTkpkYOPS2mN93UeDvF7kdUSz5uuFggOG+sHUSxbelffoCpiYUjs?=
 =?us-ascii?Q?sWwxjxyLt6OmECQMLgZ3pRAuIHPTpBVK6KSRdQgBlXVZtl9r5PvGZdaZ/MGM?=
 =?us-ascii?Q?MF1Dfpb1HgbSS3kugKLFgCt2ecNWwK7Wc9tYS030SmtgnUWyyPBbuJQfxl4I?=
 =?us-ascii?Q?DpaUL5WF3y3lZ9MuZXsGqa6Jc9IRWJ1h2utXCphOZ6KuEkSqfVC6mlx8FKRK?=
 =?us-ascii?Q?WPgC7UOEhTdHV4rbB4yYkpKW4Q/IAgcNvLxNIs5cdR9Ag1ZcZQQZFO56Cfci?=
 =?us-ascii?Q?shzVLSAn1oDTp9ffhPvpWiNyrxu1bqD9qK1OaW+bWyYHF64VsuHuOe/s+bHE?=
 =?us-ascii?Q?9GAhlfHt93ErhltBbxUEBnpOCGG4/CPzsDLxHkgAccQsgND5k+TuLMB8eM1N?=
 =?us-ascii?Q?fSZs0idZd5VGWJDG+pBdwhK7lIjMR7guQqFPeD1bJfxR3HHVwk7xbc+OMnEb?=
 =?us-ascii?Q?i+QhqtB7m+fx33NjzZL8GkBYH0FwqVbiLrvlF6fMUWoyn52TGdzx/JbzJbDo?=
 =?us-ascii?Q?NDvBY6IqEVap8I5B64j26RdgP/N0KBFbfkry0UhOW1a4f094DSAuC0TsXSTg?=
 =?us-ascii?Q?KWLKoy3NIoawsz2GF+WSN5+w0/Ng+4SaWI82CZTkSqSRjYNG7U5IYwdFq82T?=
 =?us-ascii?Q?RdQ8TupSgVqfRVubKiabyHP8nP0/w3pi/g0GFBAxmpcnRQ8l1Qkww/NlZHcy?=
 =?us-ascii?Q?eqNBmnMXfOtjWuVJKRhShYXEJPNfqFF4til8lr4Rk7eRk5n2aimiTEf7RvVL?=
 =?us-ascii?Q?55Zusti8icMmVGSQIN+MR39YBDlQ8Yx/qk7IQNWF2L5uE13ZLvQMmK900Q4q?=
 =?us-ascii?Q?g0LK/uuJHL4LgmoluAkstjUM3LmjPe3kRheV3SCMmfxdJx2+TWmQgnTrxANA?=
 =?us-ascii?Q?x1Hz7TAkuMeqnBQDRmOfIX37lmiqGBdUTEGsZAv2tYnI5PXAIvyDgvStk78t?=
 =?us-ascii?Q?Hp6ROVzA2QuOd2TkaL1uaPdKN2Higz9GxcICafLmALYYjEMGkexxOvdH9Ift?=
 =?us-ascii?Q?TETOO7IamKAIZYzco64EpNFdxLT01SZuD4guWneygMsr/FReDywi9hMxfUcz?=
 =?us-ascii?Q?WLgQxTPLtNZmOeuO7AysxodSYQeHdGE7jfAcCr0f0cnbZYOK4CMEQ22YsSIf?=
 =?us-ascii?Q?d7GVMhipRLG49bTMDPY=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB5144F2DD16616390864C9B72F7FE2BL1PR12MB5144namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50d7886a-4274-48a3-8a8e-08dd4d1ed3b8
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2025 17:41:35.2333 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: X3alU3GdVe2CKO2V2ZN/IgioEAPmi20UmkfKf+VLAG1tniqfFH7NLqKqoxaqvWGqNH04KF4BMtm+BrOaBgLfUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4042
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

--_000_BL1PR12MB5144F2DD16616390864C9B72F7FE2BL1PR12MB5144namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - AMD Internal Distribution Only]

Does it matter which pipe we use for these packets?

Alex

________________________________
From: Liu, Shaoyun <Shaoyun.Liu@amd.com>
Sent: Friday, February 14, 2025 12:36 PM
To: Deucher, Alexander <Alexander.Deucher@amd.com>; amd-gfx@lists.freedeskt=
op.org <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/2] drm/amdgpu/mes12: allocate hw_resource_1 buffer on=
ce


[AMD Official Use Only - AMD Internal Distribution Only]


Ok .  From MES point of view , we expecting  both set_hw_resource and set_h=
w_resource_1 been called all the time.



Reviewed-by: Shaoyun.liu <Shaoyun.liu@amd.com>



From: Deucher, Alexander <Alexander.Deucher@amd.com>
Sent: Friday, February 14, 2025 11:53 AM
To: Liu, Shaoyun <Shaoyun.Liu@amd.com>; amd-gfx@lists.freedesktop.org
Subject: Re: [PATCH 2/2] drm/amdgpu/mes12: allocate hw_resource_1 buffer on=
ce



[AMD Official Use Only - AMD Internal Distribution Only]



I can add that as a follow up patch as I don't want to change the current b=
ehavior to avoid a potential regression.  Should we submit both the resourc=
e and resource_1 packets all the time?



Thanks,



Alex



________________________________

From: Liu, Shaoyun <Shaoyun.Liu@amd.com<mailto:Shaoyun.Liu@amd.com>>
Sent: Friday, February 14, 2025 11:45 AM
To: Deucher, Alexander <Alexander.Deucher@amd.com<mailto:Alexander.Deucher@=
amd.com>>; amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.o=
rg> <amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com<mailto:Alexander.Deucher@=
amd.com>>
Subject: RE: [PATCH 2/2] drm/amdgpu/mes12: allocate hw_resource_1 buffer on=
ce



[AMD Official Use Only - AMD Internal Distribution Only]

I'd suggest remove the  enable_uni_mes check, set_hw_resource_1 is always r=
equired for gfx12 and  up. Especially after add the  cleaner_shader_fence_a=
ddr there.

Regards
Shaoyun.liu

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org<mailto:amd-gfx-bounces=
@lists.freedesktop.org>> On Behalf Of Alex Deucher
Sent: Friday, February 14, 2025 10:19 AM
To: amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com<mailto:Alexander.Deucher@=
amd.com>>
Subject: [PATCH 2/2] drm/amdgpu/mes12: allocate hw_resource_1 buffer once

Allocate the buffer at sw init time so we don't alloc and free it for every=
 suspend/resume or reset cycle.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com<mailto:alexander.deu=
cher@amd.com>>
---
 drivers/gpu/drm/amd/amdgpu/mes_v12_0.c | 39 +++++++++++++-------------
 1 file changed, 19 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd/a=
mdgpu/mes_v12_0.c
index 8dbab3834d82d..6db88584dd529 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
@@ -678,9 +678,6 @@ static int mes_v12_0_misc_op(struct amdgpu_mes *mes,

 static int mes_v12_0_set_hw_resources_1(struct amdgpu_mes *mes, int pipe) =
 {
-       unsigned int alloc_size =3D AMDGPU_GPU_PAGE_SIZE;
-       int ret =3D 0;
-       struct amdgpu_device *adev =3D mes->adev;
        union MESAPI_SET_HW_RESOURCES_1 mes_set_hw_res_1_pkt;

        memset(&mes_set_hw_res_1_pkt, 0, sizeof(mes_set_hw_res_1_pkt)); @@ =
-689,17 +686,6 @@ static int mes_v12_0_set_hw_resources_1(struct amdgpu_mes=
 *mes, int pipe)
        mes_set_hw_res_1_pkt.header.opcode =3D MES_SCH_API_SET_HW_RSRC_1;
        mes_set_hw_res_1_pkt.header.dwsize =3D API_FRAME_SIZE_IN_DWORDS;
        mes_set_hw_res_1_pkt.mes_kiq_unmap_timeout =3D 0xa;
-
-       ret =3D amdgpu_bo_create_kernel(adev, alloc_size, PAGE_SIZE,
-                               AMDGPU_GEM_DOMAIN_VRAM,
-                               &mes->resource_1,
-                               &mes->resource_1_gpu_addr,
-                               &mes->resource_1_addr);
-       if (ret) {
-               dev_err(adev->dev, "(%d) failed to create mes resource_1 bo=
\n", ret);
-               return ret;
-       }
-
        mes_set_hw_res_1_pkt.cleaner_shader_fence_mc_addr =3D
                mes->resource_1_gpu_addr;

@@ -1550,6 +1536,20 @@ static int mes_v12_0_sw_init(struct amdgpu_ip_block =
*ip_block)
                        return r;
        }

+       if (adev->enable_uni_mes) {
+               int ret;
+
+               ret =3D amdgpu_bo_create_kernel(adev, AMDGPU_GPU_PAGE_SIZE,=
 PAGE_SIZE,
+                                             AMDGPU_GEM_DOMAIN_VRAM,
+                                             &adev->mes.resource_1,
+                                             &adev->mes.resource_1_gpu_add=
r,
+                                             &adev->mes.resource_1_addr);
+               if (ret) {
+                       dev_err(adev->dev, "(%d) failed to create mes resou=
rce_1 bo\n", ret);
+                       return ret;
+               }
+       }
+
        return 0;
 }

@@ -1558,6 +1558,11 @@ static int mes_v12_0_sw_fini(struct amdgpu_ip_block =
*ip_block)
        struct amdgpu_device *adev =3D ip_block->adev;
        int pipe;

+       if (adev->enable_uni_mes)
+               amdgpu_bo_free_kernel(&adev->mes.resource_1,
+                                     &adev->mes.resource_1_gpu_addr,
+                                     &adev->mes.resource_1_addr);
+
        for (pipe =3D 0; pipe < AMDGPU_MAX_MES_PIPES; pipe++) {
                kfree(adev->mes.mqd_backup[pipe]);

@@ -1786,12 +1791,6 @@ static int mes_v12_0_hw_init(struct amdgpu_ip_block =
*ip_block)

 static int mes_v12_0_hw_fini(struct amdgpu_ip_block *ip_block)  {
-       struct amdgpu_device *adev =3D ip_block->adev;
-
-       if (adev->enable_uni_mes)
-               amdgpu_bo_free_kernel(&adev->mes.resource_1,
-                                     &adev->mes.resource_1_gpu_addr,
-                                     &adev->mes.resource_1_addr);
        return 0;
 }

--
2.48.1

--_000_BL1PR12MB5144F2DD16616390864C9B72F7FE2BL1PR12MB5144namp_
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
<p style=3D"font-family:Calibri;font-size:10pt;color:#0000FF;margin:5pt;fon=
t-style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[AMD Official Use Only - AMD Internal Distribution Only]<br>
</p>
<br>
<div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Does it matter which pipe we use for these packets?</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Alex</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Liu, Shaoyun &lt;Shao=
yun.Liu@amd.com&gt;<br>
<b>Sent:</b> Friday, February 14, 2025 12:36 PM<br>
<b>To:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; amd-gfx@li=
sts.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Subject:</b> RE: [PATCH 2/2] drm/amdgpu/mes12: allocate hw_resource_1 bu=
ffer once</font>
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
	{font-family:Aptos}
@font-face
	{}
p.x_MsoNormal, li.x_MsoNormal, div.x_MsoNormal
	{margin:0in;
	font-size:12.0pt;
	font-family:"Aptos",sans-serif}
a:link, span.x_MsoHyperlink
	{color:#467886;
	text-decoration:underline}
span.x_EmailStyle20
	{font-family:"Arial",sans-serif;
	color:windowtext}
.x_MsoChpDefault
	{font-size:10.0pt}
@page WordSection1
	{margin:1.0in 1.0in 1.0in 1.0in}
div.x_WordSection1
	{}
-->
</style>
<div lang=3D"EN-US" link=3D"#467886" vlink=3D"#96607D" style=3D"word-wrap:b=
reak-word">
<p align=3D"Left" style=3D"font-family:Calibri; font-size:10pt; color:#0000=
FF; margin:5pt; font-style:normal; font-weight:normal; text-decoration:none=
">
[AMD Official Use Only - AMD Internal Distribution Only]<br>
</p>
<br>
<div>
<div class=3D"x_WordSection1">
<p class=3D"x_MsoNormal"><span style=3D"font-size:11.0pt; font-family:&quot=
;Arial&quot;,sans-serif">Ok .&nbsp; From MES point of view , we expecting &=
nbsp;both set_hw_resource and set_hw_resource_1 been called all the time.
</span></p>
<p class=3D"x_MsoNormal"><span style=3D"font-size:11.0pt; font-family:&quot=
;Arial&quot;,sans-serif">&nbsp;</span></p>
<p class=3D"x_MsoNormal"><span style=3D"font-size:11.0pt; font-family:&quot=
;Arial&quot;,sans-serif">Reviewed-by: Shaoyun.liu &lt;Shaoyun.liu@amd.com&g=
t;</span></p>
<p class=3D"x_MsoNormal"><span style=3D"font-size:11.0pt; font-family:&quot=
;Arial&quot;,sans-serif">&nbsp;</span></p>
<div>
<div style=3D"border:none; border-top:solid #E1E1E1 1.0pt; padding:3.0pt 0i=
n 0in 0in">
<p class=3D"x_MsoNormal"><b><span style=3D"font-size:11.0pt; font-family:&q=
uot;Calibri&quot;,sans-serif">From:</span></b><span style=3D"font-size:11.0=
pt; font-family:&quot;Calibri&quot;,sans-serif"> Deucher, Alexander &lt;Ale=
xander.Deucher@amd.com&gt;
<br>
<b>Sent:</b> Friday, February 14, 2025 11:53 AM<br>
<b>To:</b> Liu, Shaoyun &lt;Shaoyun.Liu@amd.com&gt;; amd-gfx@lists.freedesk=
top.org<br>
<b>Subject:</b> Re: [PATCH 2/2] drm/amdgpu/mes12: allocate hw_resource_1 bu=
ffer once</span></p>
</div>
</div>
<p class=3D"x_MsoNormal">&nbsp;</p>
<p style=3D"margin:5.0pt"><span style=3D"font-size:10.0pt; font-family:&quo=
t;Calibri&quot;,sans-serif; color:blue">[AMD Official Use Only - AMD Intern=
al Distribution Only]</span></p>
<p class=3D"x_MsoNormal">&nbsp;</p>
<div>
<div>
<p class=3D"x_MsoNormal"><span style=3D"color:black">I can add that as a fo=
llow up patch as I don't want to change the current behavior to avoid a pot=
ential regression.&nbsp; Should we submit both the resource and resource_1 =
packets all the time?</span></p>
</div>
<div>
<p class=3D"x_MsoNormal"><span style=3D"color:black">&nbsp;</span></p>
</div>
<div>
<p class=3D"x_MsoNormal"><span style=3D"color:black">Thanks,</span></p>
</div>
<div>
<p class=3D"x_MsoNormal"><span style=3D"color:black">&nbsp;</span></p>
</div>
<div>
<p class=3D"x_MsoNormal"><span style=3D"color:black">Alex</span></p>
</div>
<div>
<p class=3D"x_MsoNormal"><span style=3D"color:black">&nbsp;</span></p>
</div>
<div class=3D"x_MsoNormal" align=3D"center" style=3D"text-align:center">
<hr size=3D"2" width=3D"98%" align=3D"center">
</div>
<div id=3D"x_divRplyFwdMsg">
<p class=3D"x_MsoNormal"><b><span style=3D"font-size:11.0pt; font-family:&q=
uot;Calibri&quot;,sans-serif; color:black">From:</span></b><span style=3D"f=
ont-size:11.0pt; font-family:&quot;Calibri&quot;,sans-serif; color:black"> =
Liu, Shaoyun &lt;<a href=3D"mailto:Shaoyun.Liu@amd.com">Shaoyun.Liu@amd.com=
</a>&gt;<br>
<b>Sent:</b> Friday, February 14, 2025 11:45 AM<br>
<b>To:</b> Deucher, Alexander &lt;<a href=3D"mailto:Alexander.Deucher@amd.c=
om">Alexander.Deucher@amd.com</a>&gt;;
<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.=
org</a> &lt;<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.=
freedesktop.org</a>&gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;<a href=3D"mailto:Alexander.Deucher@amd.c=
om">Alexander.Deucher@amd.com</a>&gt;<br>
<b>Subject:</b> RE: [PATCH 2/2] drm/amdgpu/mes12: allocate hw_resource_1 bu=
ffer once</span>
</p>
<div>
<p class=3D"x_MsoNormal">&nbsp;</p>
</div>
</div>
<div>
<div>
<p class=3D"x_MsoNormal" style=3D"margin-bottom:12.0pt"><a name=3D"x_BM_BEG=
IN"></a><span style=3D"font-size:11.0pt; font-family:&quot;Times New Roman&=
quot;,serif">[AMD Official Use Only - AMD Internal Distribution Only]<br>
<br>
I'd suggest remove the&nbsp; enable_uni_mes check, set_hw_resource_1 is alw=
ays required for gfx12 and&nbsp; up. Especially after add the&nbsp; cleaner=
_shader_fence_addr there.<br>
<br>
Regards<br>
Shaoyun.liu<br>
<br>
-----Original Message-----<br>
From: amd-gfx &lt;<a href=3D"mailto:amd-gfx-bounces@lists.freedesktop.org">=
amd-gfx-bounces@lists.freedesktop.org</a>&gt; On Behalf Of Alex Deucher<br>
Sent: Friday, February 14, 2025 10:19 AM<br>
To: <a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesk=
top.org</a><br>
Cc: Deucher, Alexander &lt;<a href=3D"mailto:Alexander.Deucher@amd.com">Ale=
xander.Deucher@amd.com</a>&gt;<br>
Subject: [PATCH 2/2] drm/amdgpu/mes12: allocate hw_resource_1 buffer once<b=
r>
<br>
Allocate the buffer at sw init time so we don't alloc and free it for every=
 suspend/resume or reset cycle.<br>
<br>
Signed-off-by: Alex Deucher &lt;<a href=3D"mailto:alexander.deucher@amd.com=
">alexander.deucher@amd.com</a>&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/mes_v12_0.c | 39 +++++++++++++------------=
-<br>
&nbsp;1 file changed, 19 insertions(+), 20 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd/a=
mdgpu/mes_v12_0.c<br>
index 8dbab3834d82d..6db88584dd529 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c<br>
@@ -678,9 +678,6 @@ static int mes_v12_0_misc_op(struct amdgpu_mes *mes,<br=
>
<br>
&nbsp;static int mes_v12_0_set_hw_resources_1(struct amdgpu_mes *mes, int p=
ipe)&nbsp; {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int alloc_size =3D AMDGPU_GP=
U_PAGE_SIZE;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D mes-&g=
t;adev;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; union MESAPI_SET_HW_RESOURCES_1 =
mes_set_hw_res_1_pkt;<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memset(&amp;mes_set_hw_res_1_pkt=
, 0, sizeof(mes_set_hw_res_1_pkt)); @@ -689,17 +686,6 @@ static int mes_v12=
_0_set_hw_resources_1(struct amdgpu_mes *mes, int pipe)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mes_set_hw_res_1_pkt.header.opco=
de =3D MES_SCH_API_SET_HW_RSRC_1;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mes_set_hw_res_1_pkt.header.dwsi=
ze =3D API_FRAME_SIZE_IN_DWORDS;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mes_set_hw_res_1_pkt.mes_kiq_unm=
ap_timeout =3D 0xa;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D amdgpu_bo_create_kernel(adev,=
 alloc_size, PAGE_SIZE,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_GEM_DOMAIN_VRAM,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;mes-&gt;resource_1,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;mes-&gt;resource_1_gpu_addr,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;mes-&gt;resource_1_addr);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; dev_err(adev-&gt;dev, &quot;(%d) failed to create mes resource_1=
 bo\n&quot;, ret);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return ret;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mes_set_hw_res_1_pkt.cleaner_sha=
der_fence_mc_addr =3D<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; mes-&gt;resource_1_gpu_addr;<br>
<br>
@@ -1550,6 +1536,20 @@ static int mes_v12_0_sw_init(struct amdgpu_ip_block =
*ip_block)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;enable_uni_mes) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; int ret;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ret =3D amdgpu_bo_create_kernel(adev, AMDGPU_GPU_PAGE_SIZE, PAGE=
_SIZE,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_GEM_DOMAIN_VRAM,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;adev-&gt;mes.resource_1,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;adev-&gt;mes.resource_1_gpu_a=
ddr,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;adev-&gt;mes.resource_1_addr)=
;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (ret) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_err(adev-&gt=
;dev, &quot;(%d) failed to create mes resource_1 bo\n&quot;, ret);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
<br>
@@ -1558,6 +1558,11 @@ static int mes_v12_0_sw_fini(struct amdgpu_ip_block =
*ip_block)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D i=
p_block-&gt;adev;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int pipe;<br>
<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;enable_uni_mes)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; amdgpu_bo_free_kernel(&amp;adev-&gt;mes.resource_1,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;ad=
ev-&gt;mes.resource_1_gpu_addr,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;ad=
ev-&gt;mes.resource_1_addr);<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (pipe =3D 0; pipe &lt; AMDGP=
U_MAX_MES_PIPES; pipe++) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; kfree(adev-&gt;mes.mqd_backup[pipe]);<br>
<br>
@@ -1786,12 +1791,6 @@ static int mes_v12_0_hw_init(struct amdgpu_ip_block =
*ip_block)<br>
<br>
&nbsp;static int mes_v12_0_hw_fini(struct amdgpu_ip_block *ip_block)&nbsp; =
{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D ip_blo=
ck-&gt;adev;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;enable_uni_mes)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; amdgpu_bo_free_kernel(&amp;adev-&gt;mes.resource_1,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;ad=
ev-&gt;mes.resource_1_gpu_addr,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;ad=
ev-&gt;mes.resource_1_addr);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
<br>
--<br>
2.48.1</span><span style=3D"font-family:&quot;Times New Roman&quot;,serif">=
</span></p>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_BL1PR12MB5144F2DD16616390864C9B72F7FE2BL1PR12MB5144namp_--
