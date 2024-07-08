Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDC26C3DA41
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Jul 2024 02:27:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5AD1110E1CA;
	Mon,  8 Jul 2024 02:27:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0+NhmygO";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2078.outbound.protection.outlook.com [40.107.236.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 34E8610E1CA
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Jul 2024 02:27:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XTubwxTLH6+udBQkuVP3Kn9GCVdrRKOR9ujPGgl8uM0WKHKuNLXN/7YE/22C12upXiaoW3ipFJRsKtHMLG89wrdrdcCQahOmeCkkhIb+F3cCmExQ83ew9OUTdz+zcpqJERzTHjJKg/vpWZF2tSCND/UJD4kuuJZhpjKcs9IZhQxsc7upQGhI7q3Ukq8B0H0p+55Wo0Rnn13E5E9+9L0R1x3z7agZ6OG7Y+Hk8gZSUWTY/+iAu3QRsKeYYbAYHePqN3SHGgKpVTKjlAuKrOWdLoPDNejIbshxETgkH/WNSv6Tuh7NOyl4t5IRAV9Xv6UELg6RmD/ATQ3R229IVyxPfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tgli7LqUpdXqoZhldjlQUw1536e2Lpu08SYF9tPeEoM=;
 b=jooo6xpDFbs3So1gRspUufNxp+p9M0WyQSeYfqofmw7+niu7IMfOEVlencPYcee47UHbMLccUa5YTg9NRzyQreW4dzPAj6ZbGp8wjd0KBgo8lPyc8oX7CyUcwn2mWm65k1A6smWM+WXMW1R3kbInoqhOzDXFoStJL0hIDxKGijAzSs09H44RHchGIWDfioKsvS6B3/aNJEAzmGQDg+mEWDrelvOcNNiC6XzfspJEr4DOVIFjzi2rlkdZ3vaDM4Q8eSCLmh+HKbWBtO3w81c3dReUI8JftiJMxRZL69rvodXZvoZRGxOWj4GK2j/vAj9Qq2T4bx4vbRBryDiEEs3E3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tgli7LqUpdXqoZhldjlQUw1536e2Lpu08SYF9tPeEoM=;
 b=0+NhmygOYDJXkD+wvg1MFvTIh07t10CBcbEdrS1Y6hqCrMf3A0l/599NYmWQpQFat590r52jkQ6tooIKNgmwDA72u+vVHabjPUjtb7HLjxfkRIE5KDlT/flW4918LEjwexbEdrVwQ0y02nMWv/OjVa/0dwvOa0ZtgUsVKYXB930=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by SA0PR12MB7479.namprd12.prod.outlook.com (2603:10b6:806:24b::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Mon, 8 Jul
 2024 02:27:00 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009%6]) with mapi id 15.20.7741.033; Mon, 8 Jul 2024
 02:27:00 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Yang, Stanley" <Stanley.Yang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH Review 1/1] drm/amdkfd: Use mode1 reset for GFX v9.4.4
Thread-Topic: [PATCH Review 1/1] drm/amdkfd: Use mode1 reset for GFX v9.4.4
Thread-Index: AQHa0Nrl7LAaPuh/mUaXR517mWzPk7HsGtHg
Date: Mon, 8 Jul 2024 02:27:00 +0000
Message-ID: <BN9PR12MB525775125ABC896C9CE9CAE6FCDA2@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20240708020146.947040-1-Stanley.Yang@amd.com>
In-Reply-To: <20240708020146.947040-1-Stanley.Yang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=d9505288-08d4-4739-9f7c-c38669e67002;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-07-08T02:26:39Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|SA0PR12MB7479:EE_
x-ms-office365-filtering-correlation-id: 165c92ff-9e76-41a5-3fe3-08dc9ef57250
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?S2e0AumJpEAQ7GCID9p8s59LAd5h5mxB7Qw89exs7re7j4PvFZyzQ3LZQTf3?=
 =?us-ascii?Q?VAOKfld0bi6Y9Gjy8vAam2e5Daovi5izeRl1YvW/mtp58dovZgjJXUc+WBFz?=
 =?us-ascii?Q?ZBk0tWnm4O5SEa151eW4QLzXleEEWVZghPz9lNpsqX7RuoFxxM83oXLS//gT?=
 =?us-ascii?Q?7nk7HHDKyp7hGmMyR9oyd1GizmTlz3znNamObXXAV7FINxt4oEnb1vo/16hZ?=
 =?us-ascii?Q?BXduYlpK8I5n0JaI0De4pL1dxnYlmiAGR6GmjhdnJ1nOTNbZsTt0AKVWpmbE?=
 =?us-ascii?Q?3yjrfBFhI8qYM+QCW7XADRPYy05kA9Su/yxFfr9/Bh10H9PkZ1rgZZ9HfzLn?=
 =?us-ascii?Q?9iuAcVYBCD9UUCyegnuNq8mIJCtZpeMSjVrHSEB8LTybuZQrDOdNPdRBujUu?=
 =?us-ascii?Q?Yc0xzMGPdCD1J6vnxCVtqBnMZmesdVhnt/jT5hd4WZsC6YVJzbor0x1SJIbb?=
 =?us-ascii?Q?cPKzgAeNVvyB7y2QcQLB5lS51a9x2me1Zs6ihgjZfdiZRUOlSGItm+Ql33Tn?=
 =?us-ascii?Q?TBl+oQ0JhtSKUJj4LVrFV8YBifX+zskxESirMb2RykooqhPfTgPBF+WL7sQN?=
 =?us-ascii?Q?c82pmeKcIO1wTpRNriUC14jPPC7Dal/E77JilU/9WZocsoZraF5CgzIxMw4i?=
 =?us-ascii?Q?0u28U1fWy8OMU17qMzGvXxOLkW+kxdFm486Nli/FzHy/yLon1WpDFphxnjZT?=
 =?us-ascii?Q?Lm0jvS/j+OA4GK02Snv6QHuz0nbYONcPos0jIQLRImqbWu3FdSdCW4G1rbAh?=
 =?us-ascii?Q?5yHI8LgtTzC7gn9PQ4arD/DYwRmDEoExsHPerTRqxzQpi7IK5dhRwu6knZka?=
 =?us-ascii?Q?awEhP/RGZYjkwdgOLvlq4vaDnwoxzeTtbIlGy7uvcXG1aXybeTIx8Tqc3OUK?=
 =?us-ascii?Q?z8aAtDyoFPKVA8GILLY0Hc8rPw4z0k6OQ5NzZCKWbWs95vG3mV8peU9dy8pR?=
 =?us-ascii?Q?NNjURKVR3sRWmTjFvMgiJaC+w22YDZAFhyYeGCR/Z9OVee/zNez/brDwea/8?=
 =?us-ascii?Q?PELpiONPmLH0grDL9nsOf4X9JmDlt63AtIKOC4pc1BuEjca57rvHpM5X0Xmy?=
 =?us-ascii?Q?USthkmOOTY5MkL4vVi2Zt0QesyC5BLoG7qEju8CfJLkwtBB++4gotbYRyej4?=
 =?us-ascii?Q?40S3Sa4MSFivrEe5MypUWF44qZQkLluk4xWo8SYbHF8PwUMwXiqOowGxG8SO?=
 =?us-ascii?Q?FSaLtAQ9dj3J7TLO5TMunakHzbsu48CV3j6NZ28LU5wFHs5KQTLTsG2eQ1Uz?=
 =?us-ascii?Q?WKeC1YZIvgXbiNgnB/B//CsggcvOjiWDlMkShBeJAddE9YZ+9RxND6xmJx9K?=
 =?us-ascii?Q?uQ31Se/TnEZJ4++hc3tI3frbGtilSVRHoiwYRMzm+/gw6aftWo+jIZGrC1yw?=
 =?us-ascii?Q?4IVXKOepwKP5tDT6VeJLeHLRkFydSOXnSdAPzcYsdPsj1+9MDQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?RY0QYiWgEZUAOzc4v48ffmK/574tdraavo5LnO537Kg242yDNpg+CT+tHav9?=
 =?us-ascii?Q?THkmeefNaEpeQehsE6eLaRPBcKdva/2hkw84DGy+bN4TcczwDdv7Ci+g7bp6?=
 =?us-ascii?Q?WLUBWKlUJrWPnN3kZYWOB40yA2E8JoGhU1XWVSICrveOvemF9KEsetdjS8TM?=
 =?us-ascii?Q?z+iRJZEM0lAyACWVxLI1/+9/lHB5+R+JvfUUP9rPzSZdgxFDX0noCmJMTOVe?=
 =?us-ascii?Q?CMjYcAk6eLysHpO5nmtFWv7sXfDI+Khqik4itD1AgVa4Vb2l6n7qyOCs+3LI?=
 =?us-ascii?Q?uXB8AEAnhixFhvHLDzCxsYE1vbu9jcNw6Tt9wDsdzZNy5WYfzPgyoeXC3VFm?=
 =?us-ascii?Q?fR+VqvCEpbZjwXBbMmUmSQDMAhhLSYQF/lQmQIJwEL7gk8QuJACGAdB1RBeN?=
 =?us-ascii?Q?osd/vPfzCTzxkZNqeSdTI9WyeshX+lpWL03iMtSZskjBbpFn5SpodZ9OGqeN?=
 =?us-ascii?Q?lN+25QGA+BuxC++HrZ39Ti9G1Yg9Z+lbrg1q4F4tSHtl+rYrpComJgPFRgsh?=
 =?us-ascii?Q?ILqnjMjKFSMRTKWmpgUrTmYFD8KdSQyPD1wv/KyrsxDomOwufmrTYbWFfbfg?=
 =?us-ascii?Q?uYyP3VPJwCF0U23t78l9KcfB8DZWOgKiFa0+xUOSrNXcDSCvxK8q6pyLJQRH?=
 =?us-ascii?Q?bkRPS/FxrRKfZzcoPl71oPJcUgCkeHXMr1smzYQ3KA0CsGwgqws03dGBeEes?=
 =?us-ascii?Q?cS/hrom3/qJAcisEVuvYBmsg3ykqPAjWa+1QR4vjXj5ym53pEIxaCh+nH3RH?=
 =?us-ascii?Q?U4CqvigAsoqPB4DzbWQ2kZa8nTFhJxylpFnpOroiXo8DM6u2lniPoo6gmgK1?=
 =?us-ascii?Q?ejBRxHnO3oeRidq1tEYihtSTXsF5nX3oNgC4KJB5zmqX3bA7UN/d11BjKSUH?=
 =?us-ascii?Q?ZexZoM2UO29POiatbMAqrieP7rJiz6f1kLqVH4LBwlx/GyYUm8CX1j2zP94L?=
 =?us-ascii?Q?RsrcnDuxbL3NC9JfHKUmqoh+5brSAK9IESVtkC+yqfg9bsn9euTThIC6+aD3?=
 =?us-ascii?Q?cayREAEQXcWmmLla9k8sbFCrR4Yoc9L82epWFO6jUGFmltldOJL7VsvbnnVl?=
 =?us-ascii?Q?TdDVtUfcv22HFNyPqHNnI15x79D3BpkKEIcEBEblD7XhpvI8d7my45Cl/cSb?=
 =?us-ascii?Q?GWgNIAsVOd5+z3FPSzPb0/Ev5zIvesdtpi8BBV9TkTfpkDIY14DHzeP1Ps+E?=
 =?us-ascii?Q?8BKrm7zBquJGSuZl2uCCGd9WmnaqdYnOE6SxLiPo4tmxYCEi15l7oBpJ8a/n?=
 =?us-ascii?Q?l/GetRXqs99lE61b+a8KSe6jpFqJx+kPAfiaGhVne7B2jOCiY3AkgpyCiny1?=
 =?us-ascii?Q?PLelqMDmQI0tzwfUC+bkI/cIcLpDs+oTcR41CYuKASteWsuy20+YVltaHckw?=
 =?us-ascii?Q?ybSoW3bvlD8fhPBE+7w81ZTli5wzjx0Fn0Og0bdXZ184uWDQMNzTqMdF0/tz?=
 =?us-ascii?Q?GrqT2QG0tJ/t3JMp7+dczbtm9wHljG9Y0vO1kfqjrd4rPPMaS+6pJfiFR/W3?=
 =?us-ascii?Q?RYm5ItHZFhrN3UlkdIXC8nKzFVUFWsrNlbJu1sgaHoSQx773WzRrjY3AJEGL?=
 =?us-ascii?Q?zlox5ZJUs5g3LTEve08=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 165c92ff-9e76-41a5-3fe3-08dc9ef57250
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2024 02:27:00.1785 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 717lWP7FUyhXcX94olmEPS+KoaRI3AzJc07xJOqRq/Prubt3+aUJgR3tT+OfIo01EJ1oKCUh2wNx1oec/MY4Ag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7479
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

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Yang, Stanley <Stanley.Yang@amd.com>
Sent: Monday, July 8, 2024 10:02
To: amd-gfx@lists.freedesktop.org; Zhang, Hawking <Hawking.Zhang@amd.com>
Cc: Yang, Stanley <Stanley.Yang@amd.com>
Subject: [PATCH Review 1/1] drm/amdkfd: Use mode1 reset for GFX v9.4.4

GFX v9.4.4 uses mode1 reset to handle poison consumption.

Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c b/drivers/gpu/=
drm/amd/amdkfd/kfd_int_process_v9.c
index 816800555f7f..da95b8ba87e4 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
@@ -164,7 +164,8 @@ static void event_interrupt_poison_consumption_v9(struc=
t kfd_node *dev,
        case SOC15_IH_CLIENTID_SE3SH:
        case SOC15_IH_CLIENTID_UTCL2:
                block =3D AMDGPU_RAS_BLOCK__GFX;
-               if (amdgpu_ip_version(dev->adev, GC_HWIP, 0) =3D=3D IP_VERS=
ION(9, 4, 3))
+               if (amdgpu_ip_version(dev->adev, GC_HWIP, 0) =3D=3D IP_VERS=
ION(9, 4, 3) ||
+                       amdgpu_ip_version(dev->adev, GC_HWIP, 0) =3D=3D IP_=
VERSION(9, 4, 4))
                        reset =3D AMDGPU_RAS_GPU_RESET_MODE1_RESET;
                else
                        reset =3D AMDGPU_RAS_GPU_RESET_MODE2_RESET; @@ -180=
,7 +181,8 @@ static void event_interrupt_poison_consumption_v9(struct kfd_n=
ode *dev,
        case SOC15_IH_CLIENTID_SDMA3:
        case SOC15_IH_CLIENTID_SDMA4:
                block =3D AMDGPU_RAS_BLOCK__SDMA;
-               if (amdgpu_ip_version(dev->adev, GC_HWIP, 0) =3D=3D IP_VERS=
ION(9, 4, 3))
+               if (amdgpu_ip_version(dev->adev, GC_HWIP, 0) =3D=3D IP_VERS=
ION(9, 4, 3) ||
+                       amdgpu_ip_version(dev->adev, GC_HWIP, 0) =3D=3D IP_=
VERSION(9, 4, 4))
                        reset =3D AMDGPU_RAS_GPU_RESET_MODE1_RESET;
                else
                        reset =3D AMDGPU_RAS_GPU_RESET_MODE2_RESET;
--
2.25.1

