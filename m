Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B32C3E77188
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Dec 2024 12:02:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 32BD610E035;
	Thu, 26 Dec 2024 12:02:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vnviHxZX";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2049.outbound.protection.outlook.com [40.107.212.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AD66210E035
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Dec 2024 12:02:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qOj45G1vSt5GrBJ+idN9KOHI33d6t7cyHoHTi5wqyzQrXBBU56nOQDM3XUybBmprBaDm0WQ6/fvfi1OXt0h9sFzdtx99zYxldgFRzFwPK8tdrS/j206S8MUszOYQhXi2/0PAlfMZNydTweADTeDD9YCWMcY+oKOG2Cz+Lm5IiPICnyPIzwOdP3KSS4ijF4DN7QzveP4Sq8w42G6D9PKNUA2Bi/QPlsX1v4tmXNWqlXdyfSG6EOFTSkyInxxqM/LULgwUdG59c+cU0qTVCTgL63hF1dXjbGOAf67QYbNluE2BasDafCYo9O1BQWm0LbqKU1hsJG7oH2GMPPVk5FPt2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fbGEXtVBb4Z8quVN2iv2EZIANQvogzuJjZRhre0qj8c=;
 b=FFOjxB8ZYHDMY7atHyC+SwjRx3+iNhg+LrkUiZKSVoNaKNfuzw0qZvLS1M8EQruxPCbBxWyZQdMmPEdK7E2ttUzFflAjiZBei/ldeax1hHqIw10x8ilYL0oZHRgparc5T2lfoQDUwX6HMVmd69kHvCXOK+uMfJXCQ7uVKiLWLpLi2ZmpovEuiMqt9KiXPABL+05ZSwL8u7snk1hY7T97VRgYYVs84rS8vyI3nskSDn5TmaqeUAzpjsHAKr8D2BPMouTkj/SwJYswDnnWBAH+V4S7jo3ItIur3CYr3Vt/XifoK6gKqDsaROzFEkTwoElwKr6+eIj2m3u0VYz0LLJPxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fbGEXtVBb4Z8quVN2iv2EZIANQvogzuJjZRhre0qj8c=;
 b=vnviHxZXk7lPWbZ86bt4mcip4o5nPt3yPFk0o53SR43NLaMEkAmM+aL0UsFf1o+nsxBj+poqldq77UDpjUvwlwYtirw+zJp6mwXs24bMQCii2kTWwBZ2vcY43NOSIY8yxjYalRePjOZXnMcWYWHL8BrHW1Ve/+zDuc702SqMc8o=
Received: from PH7PR12MB5686.namprd12.prod.outlook.com (2603:10b6:510:13d::13)
 by DS7PR12MB6143.namprd12.prod.outlook.com (2603:10b6:8:99::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8293.14; Thu, 26 Dec
 2024 12:02:32 +0000
Received: from PH7PR12MB5686.namprd12.prod.outlook.com
 ([fe80::2c1d:4b4d:9fa4:d758]) by PH7PR12MB5686.namprd12.prod.outlook.com
 ([fe80::2c1d:4b4d:9fa4:d758%6]) with mapi id 15.20.8293.000; Thu, 26 Dec 2024
 12:02:31 +0000
From: "Sharma, Shashank" <Shashank.Sharma@amd.com>
To: "Yadav, Arvind" <Arvind.Yadav@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH v2] drm/amdgpu: Fix Illegal opcode in command stream Error
Thread-Topic: [PATCH v2] drm/amdgpu: Fix Illegal opcode in command stream Error
Thread-Index: AQHbVVA8qGLcwGYnw0W/63hVTHmziLL4cUcf
Date: Thu, 26 Dec 2024 12:02:31 +0000
Message-ID: <PH7PR12MB568618716642B64B33F90F05F20D2@PH7PR12MB5686.namprd12.prod.outlook.com>
References: <20241223153439.2208-1-Arvind.Yadav@amd.com>
In-Reply-To: <20241223153439.2208-1-Arvind.Yadav@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-12-26T12:02:31.251Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB5686:EE_|DS7PR12MB6143:EE_
x-ms-office365-filtering-correlation-id: ccec7a1b-16c9-4e90-a257-08dd25a52d6d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|8096899003|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?rBQvlq2Vi7YEn6q0SdxoLB/HzZBitJsvpJR383u2jLhUU6DIT3/2E3w02y?=
 =?iso-8859-1?Q?CTcT+RRP4jqPUKwUavqyocmluNbVaYz6rLBVOFcgNDeNqJZtPh61OMibML?=
 =?iso-8859-1?Q?enHZkLWJbqXax+LMBSQbm1Qmp1TvtC1pzoiwdv/6SCmWt8MvMhsFthJKH+?=
 =?iso-8859-1?Q?KWwQStpVTVmcwHlpMG6Gvh/WrYNcZvpep5MZKnSzfshTpEYuGb1wivluoI?=
 =?iso-8859-1?Q?oyE2zQfs1Zn3Uv0zxFp1jshhT8g70u0Vw0DiLq/5gX8vEgX5pMC8pmr+9X?=
 =?iso-8859-1?Q?m5elZMIJcqeJ5/tFI3KO1KoxVNCgoOQ7tmZg0DYMh0MoBbBz/uc8kzrkfC?=
 =?iso-8859-1?Q?QgfPikQ7bv4ZuvHEGPvs9sn2Gl54DBCABTmZOV3ZlIHaOWfgFHzeHfKLR1?=
 =?iso-8859-1?Q?3K7ZaB+U1JFbJFzeow4+mTwcuTi7JTPO2o/OeE+7QZV4LnlK1yjO2LBVKc?=
 =?iso-8859-1?Q?2QuvGvSsPFLrtnGjL9u6YkR40Ihv141f40R860S6W5NijW3Z2NnAmIXNQf?=
 =?iso-8859-1?Q?sfIGE7PJRX7+gRrRWxdeHSl3IG4Mr8XV1PpnRp+VFdORdIsQ/hXjq3t/Ov?=
 =?iso-8859-1?Q?NxIEN5IB0pgOFPePBX1VXrDBE5jKv5XtLVMKz5kCucMIbyzgEGWGYBrHT3?=
 =?iso-8859-1?Q?CQLhjOnnoFXXQs4JRPDq3V4lPz3ee8vhj2g/2kEHClgkVfMuELfdrv+0WN?=
 =?iso-8859-1?Q?31yJ7IFl3+sOVPD17qAe4pgI5Ku3b63bwBEiNHbHnCin6BwkPyX1/x5RyV?=
 =?iso-8859-1?Q?vkDexCGqn7fURkaY3h4eP/ws2Xvh6I8N3sGR/QUSLzhYJS15Qg+fZBUosE?=
 =?iso-8859-1?Q?65hLwW8yNM28cEbd9o1HESXADTwLuwapZoEQha1YcRa/4ywrssw7cN8PXw?=
 =?iso-8859-1?Q?2WH5yQGEVnH7leh3BUBYV9T9GdLHSPwjkNK6dVRbYo7gvtC3TH2hsMn2/a?=
 =?iso-8859-1?Q?c+Z3lQRghiSZx6b3mwlsLDG8xuEMb4bUakdFYLnnzN/EUnYISL9u+zJSZs?=
 =?iso-8859-1?Q?Q7XgVKBgXRN5+7L1ZK/8/j2MhZah6koCEBU6rOut/nkxsyFNT3fWQ3B79d?=
 =?iso-8859-1?Q?e6PO7sp3MN+bOdm36fQVb63b1sMaL1uRNfe8a+y5LK/qTKC4YP3B+HwVJe?=
 =?iso-8859-1?Q?skkOTvljmr9YMIaLzcxPeLPOfu80aPpnhUKqeFr4bcf8hzSl7upNTIswHB?=
 =?iso-8859-1?Q?5z67OtX3ELoU09hR1xqxVvLwa2lu+aQY6WZxsYGEavUXBwG4nCMc3iiqUI?=
 =?iso-8859-1?Q?TCUIVqz/tLAlrG/YnKASULk83XtlQp/b3zjmVyvXOOtjegoTaPGolSIpgN?=
 =?iso-8859-1?Q?FPr/3OVcQe5gebkDFAneBx3LTgEesom/Q+0o+8fuShBP0JyHY/bvc9Jges?=
 =?iso-8859-1?Q?JdsB5RbU1NxfwnYx8HLmOy+fkHb5DOJZ7LejPL8PhaA3sHY4TD/Gsva5hA?=
 =?iso-8859-1?Q?iW/7wuxGYPo4B/KInBr/7Bt1O0YcW0HMdJdcCUqkEsG+SAioKKhaU7DZUw?=
 =?iso-8859-1?Q?hL2Dw3Nii+6LJ6oLyRMPeT?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5686.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(8096899003)(7053199007)(38070700018);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?2Jl/vdZrNSG0F/4gC/3lfbvswXTGCCUoHG9VXcctSN/D8LORohzTWT1E+M?=
 =?iso-8859-1?Q?NmphJ2Ej8y9kg/Bis4kqgGK5ZOJPP32ZyIPB8M2+FBpDd6pKcHEZkBnvpb?=
 =?iso-8859-1?Q?6cMCRv7P9HhSqBb2WjhpIqy6TC8gmM3Dxk9yM1jMU5yfba2TH2xi9GCtvL?=
 =?iso-8859-1?Q?Yv6UGBNduSV4vUIH+Hopx1gG+yXn8wrd0mG5H3WlSZ8CHkfwE9gN6HoJ9T?=
 =?iso-8859-1?Q?G7Q8sZhjKRutXCCzAMSEgDACNes2FrNgvg/zo8SEN6bdaqMRzf77XbNi65?=
 =?iso-8859-1?Q?JcCCj2sLgqehOSb1M8zjWMU8Aji3tB9Sa4yVmexdGg1mL6+HD8NFyElHiJ?=
 =?iso-8859-1?Q?2DqH/m9+sLBhrBUO3YKmSHsqcuQxnCH65F9vmdy3TIjxNsOHwOoGttnwHj?=
 =?iso-8859-1?Q?nIrc2KCVNS7DYlNwJ5pTtNHKmcpInU3CgxEybJKiJDGcWcqRXR07w3U+3I?=
 =?iso-8859-1?Q?0F/CRI2ogpWSpvjx+in8ge5FJPhYTmQUgpHyTHl3C6V6iv3lJFuj9MaXtN?=
 =?iso-8859-1?Q?P+iuPF2d9H7yX9wlo925aKo8MUOCFXVGUekCBRjjHMU/WfR3uDRv5yCyzc?=
 =?iso-8859-1?Q?Z9YqhLG0IaNXU6x1DMb26MOpMDwaQFVNGHwKIxAKT5RpW0Nwqfwbsgselb?=
 =?iso-8859-1?Q?EntZ2XaSU59oJIaPP52+HayKfxwonA5TwhxUsh00NrNfRs0060FKZQpNZ3?=
 =?iso-8859-1?Q?TfkvyW0D1RJ6SGjMHbovOybEciSrgSXkAVIqWzBk7nXYC/1M7uRRTSgIHe?=
 =?iso-8859-1?Q?hpxTcIBMaRm+JcE3vu7MGzkNRtGF20q38n0vu18dpoBAizSZYgpR2zxvUJ?=
 =?iso-8859-1?Q?zTVqRg196kQb+WLxLdc7oatRZkZJ2lcln+ZlxejL5kWfKap5CR+PBI+EuR?=
 =?iso-8859-1?Q?eO8q1P4xCZtyl+NgKn1u/CyfbuNOlohyb2kRe67tQgnreFlOtAfGoBirzk?=
 =?iso-8859-1?Q?eohIiNU3jfgzoa1bF+BaHycK9wm+BKZgPthLZkepcsqZkOcKXDLPSHgJvz?=
 =?iso-8859-1?Q?o6CwkmKK9HOtpW/8zpo8vRoYHWry6SQQCPcOC2smtuJGtA3akhV4dKAMSi?=
 =?iso-8859-1?Q?43PJDqzxa1KGsb9/vpPK1yR/zPKSimp6W7nlm261bUuUFirtta2bSP8Y8K?=
 =?iso-8859-1?Q?zm5Zrw+pM7qlZE10rCsIRC2mLXty3tIn3oPDGMn4akndEIrdqV7Ps/Mf7b?=
 =?iso-8859-1?Q?kjTKS1yUT142UaRwJZR7kxT1MgUv6CG54OqAuC7hj85wEKoCmgAA8N7dkR?=
 =?iso-8859-1?Q?43X6uJSzg+RGtI1wY32/zuIRI0QSwI2EjiBDUyJlcEnppMT5Geo9fLgw2m?=
 =?iso-8859-1?Q?EzDtyXkQ12wIqgvtNKZlyYv/EfKz8ySP6rUD/LM3jarI/ZkBe6sdifFeqO?=
 =?iso-8859-1?Q?ZR7k4Xo4z6GlNyaG+jiKr4tg4Ja+1EAXnkgGcv0t2WlB4nDnHysMq5ZAru?=
 =?iso-8859-1?Q?lV6BGkv/YKjOUBFR/5oG6+6t3A5tIEIjZomL0ZDy7OhZTShxgWaxx/ptR8?=
 =?iso-8859-1?Q?VAi46D7gEU4YHQuvGyW9KNhWXcDxCXGhULoA0q5kHnnF25Qcymj41OtgNr?=
 =?iso-8859-1?Q?y1vCAgG04guRpIHH4BvBrRotIyQaO00S4h9nwDMCPFQ+pBrhqeBFHjJVMS?=
 =?iso-8859-1?Q?Ze3+oN7r8r0Ik=3D?=
Content-Type: multipart/alternative;
 boundary="_000_PH7PR12MB568618716642B64B33F90F05F20D2PH7PR12MB5686namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5686.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ccec7a1b-16c9-4e90-a257-08dd25a52d6d
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Dec 2024 12:02:31.8317 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nc8VotJfsvNnT4BlQrtv803BpkI6iZAqej4HQt1NbNzpuw/wPKr0lCd+h2r+UEaMB2G7uIu7A2roOYiN4Q5EJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6143
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

--_000_PH7PR12MB568618716642B64B33F90F05F20D2PH7PR12MB5686namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - AMD Internal Distribution Only]

Please feel free to use:
Reviewed-by: Shashank Sharma <shashank.sharma@amd.com>

Regards
Shashank
________________________________
From: Yadav, Arvind <Arvind.Yadav@amd.com>
Sent: Monday, December 23, 2024 4:34 PM
To: Koenig, Christian <Christian.Koenig@amd.com>; Sharma, Shashank <Shashan=
k.Sharma@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>; Yadav, A=
rvind <Arvind.Yadav@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>;=
 Yadav, Arvind <Arvind.Yadav@amd.com>
Subject: [PATCH v2] drm/amdgpu: Fix Illegal opcode in command stream Error

When applications closes, it triggers the drm_file_free
function which subsequently releases all allocated buffer
objects. Concurrently, the resume_worker thread will attempt
to map the usermode queue. However, since the wptr buffer
object has already been deallocated, this will result in
an Illegal opcode error being raised in the command stream.

Now replacing drm_release() with a new function
amdgpu_drm_release(). This function will set the flag to
prevent the scheduling of any new queue resume/map, stop
all queues and then call drm_release().

V2:
  - Replace drm_release with amdgpu_drm_release(Christian).

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian Koenig <christian.koenig@amd.com>
Cc: Shashank Sharma <shashank.sharma@amd.com>
Signed-off-by: Arvind Yadav <arvind.yadav@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 16 +++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c |  4 ----
 2 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_drv.c
index 62de668e9ff8..acb9dc3705ac 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2794,6 +2794,20 @@ static int amdgpu_pmops_runtime_idle(struct device *=
dev)
         return ret;
 }

+static int amdgpu_drm_release(struct inode *inode, struct file *filp)
+{
+       struct drm_file *file_priv =3D filp->private_data;
+       struct amdgpu_fpriv *fpriv =3D file_priv->driver_priv;
+
+       if (fpriv) {
+               fpriv->evf_mgr.fd_closing =3D true;
+               amdgpu_userq_mgr_fini(&fpriv->userq_mgr);
+               amdgpu_eviction_fence_destroy(&fpriv->evf_mgr);
+       }
+
+       return drm_release(inode, filp);
+}
+
 long amdgpu_drm_ioctl(struct file *filp,
                       unsigned int cmd, unsigned long arg)
 {
@@ -2845,7 +2859,7 @@ static const struct file_operations amdgpu_driver_kms=
_fops =3D {
         .owner =3D THIS_MODULE,
         .open =3D drm_open,
         .flush =3D amdgpu_flush,
-       .release =3D drm_release,
+       .release =3D amdgpu_drm_release,
         .unlocked_ioctl =3D amdgpu_drm_ioctl,
         .mmap =3D drm_gem_mmap,
         .poll =3D drm_poll,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_kms.c
index d2a046736edd..f908355df07c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -1478,10 +1478,6 @@ void amdgpu_driver_postclose_kms(struct drm_device *=
dev,
                 amdgpu_bo_unreserve(pd);
         }

-       fpriv->evf_mgr.fd_closing =3D true;
-       amdgpu_userq_mgr_fini(&fpriv->userq_mgr);
-       amdgpu_eviction_fence_destroy(&fpriv->evf_mgr);
-
         amdgpu_ctx_mgr_fini(&fpriv->ctx_mgr);
         amdgpu_vm_fini(adev, &fpriv->vm);

--
2.34.1


--_000_PH7PR12MB568618716642B64B33F90F05F20D2PH7PR12MB5686namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
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
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
Please feel&nbsp;free&nbsp;to use:</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
Reviewed-by: Shashank Sharma &lt;shashank.sharma@amd.com&gt;</div>
<div id=3D"appendonsend" style=3D"color: inherit;"></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
Regards</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
Shashank</div>
<hr style=3D"display: inline-block; width: 98%;">
<div dir=3D"ltr" id=3D"divRplyFwdMsg" style=3D"color: inherit;"><span style=
=3D"font-family: Calibri, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);=
"><b>From:</b>&nbsp;Yadav, Arvind &lt;Arvind.Yadav@amd.com&gt;<br>
<b>Sent:</b>&nbsp;Monday, December 23, 2024 4:34 PM<br>
<b>To:</b>&nbsp;Koenig, Christian &lt;Christian.Koenig@amd.com&gt;; Sharma,=
 Shashank &lt;Shashank.Sharma@amd.com&gt;; Deucher, Alexander &lt;Alexander=
.Deucher@amd.com&gt;<br>
<b>Cc:</b>&nbsp;amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop=
.org&gt;; Yadav, Arvind &lt;Arvind.Yadav@amd.com&gt;; Koenig, Christian &lt=
;Christian.Koenig@amd.com&gt;; Yadav, Arvind &lt;Arvind.Yadav@amd.com&gt;<b=
r>
<b>Subject:</b>&nbsp;[PATCH v2] drm/amdgpu: Fix Illegal opcode in command s=
tream Error</span>
<div>&nbsp;</div>
</div>
<div style=3D"font-size: 11pt;">When applications closes, it triggers the d=
rm_file_free<br>
function which subsequently releases all allocated buffer<br>
objects. Concurrently, the resume_worker thread will attempt<br>
to map the usermode queue. However, since the wptr buffer<br>
object has already been deallocated, this will result in<br>
an Illegal opcode error being raised in the command stream.<br>
<br>
Now replacing drm_release() with a new function<br>
amdgpu_drm_release(). This function will set the flag to<br>
prevent the scheduling of any new queue resume/map, stop<br>
all queues and then call drm_release().<br>
<br>
V2:<br>
&nbsp; - Replace drm_release with amdgpu_drm_release(Christian).<br>
<br>
Cc: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
Cc: Christian Koenig &lt;christian.koenig@amd.com&gt;<br>
Cc: Shashank Sharma &lt;shashank.sharma@amd.com&gt;<br>
Signed-off-by: Arvind Yadav &lt;arvind.yadav@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 16 +++++++++++++++-<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c |&nbsp; 4 ----<br>
&nbsp;2 files changed, 15 insertions(+), 5 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_drv.c<br>
index 62de668e9ff8..acb9dc3705ac 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c<br>
@@ -2794,6 +2794,20 @@ static int amdgpu_pmops_runtime_idle(struct device *=
dev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&nbsp;}<br>
&nbsp;<br>
+static int amdgpu_drm_release(struct inode *inode, struct file *filp)<br>
+{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_file *file_priv =3D filp-&=
gt;private_data;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_fpriv *fpriv =3D file_p=
riv-&gt;driver_priv;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (fpriv) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; fpriv-&gt;evf_mgr.fd_closing =3D true;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; amdgpu_userq_mgr_fini(&amp;fpriv-&gt;userq_mgr);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; amdgpu_eviction_fence_destroy(&amp;fpriv-&gt;evf_mgr);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return drm_release(inode, filp);<br>
+}<br>
+<br>
&nbsp;long amdgpu_drm_ioctl(struct file *filp,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int cmd,=
 unsigned long arg)<br>
&nbsp;{<br>
@@ -2845,7 +2859,7 @@ static const struct file_operations amdgpu_driver_kms=
_fops =3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .owner =3D THIS_MODULE,<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .open =3D drm_open,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .flush =3D amdgpu_flush,<b=
r>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .release =3D drm_release,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .release =3D amdgpu_drm_release,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .unlocked_ioctl =3D amdgpu=
_drm_ioctl,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .mmap =3D drm_gem_mmap,<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .poll =3D drm_poll,<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_kms.c<br>
index d2a046736edd..f908355df07c 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c<br>
@@ -1478,10 +1478,6 @@ void amdgpu_driver_postclose_kms(struct drm_device *=
dev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; amdgpu_bo_unreserve(pd);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fpriv-&gt;evf_mgr.fd_closing =3D true=
;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_userq_mgr_fini(&amp;fpriv-&gt;=
userq_mgr);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_eviction_fence_destroy(&amp;fp=
riv-&gt;evf_mgr);<br>
-<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ctx_mgr_fini(&amp;f=
priv-&gt;ctx_mgr);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_vm_fini(adev, &amp;=
fpriv-&gt;vm);<br>
&nbsp;<br>
--<br>
2.34.1<br>
<br>
</div>
</div>
</body>
</html>

--_000_PH7PR12MB568618716642B64B33F90F05F20D2PH7PR12MB5686namp_--
