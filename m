Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03CCBEB5961
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Feb 2026 05:16:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 74AE210E009;
	Wed, 11 Feb 2026 05:16:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DxsxFhah";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011010.outbound.protection.outlook.com [52.101.62.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0562010E009
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Feb 2026 05:16:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yhHQXQ+MQia8TRrNE64odPJpAq1rkvNIAZWTVDeOdExANflTk5r3SMgCgLa6zyQ53zA5GUlvIMCyUk70LOfHg14E/uGPA5sn6ZAALlgUSuLikdAxEbb/OBJf0AvBmd/gYl759N6ImYvNXGc9WZgY25KmvN5o1Y8I2erksZYp0LzolJwssmQybstq4p/+UTzj2MdcJqbyfo6+A7kPyGKiWMHennHiF4yLKSLEttf9PxnuZ2DSNDUKWTkUvKOfHpQdt5PIDhuc7RdnE7HHpeiWzUnUOg3Pa3Sgoa1TfaCV+8+gGXLML0Hp7WteQl1Lz9aAtDjaipsB375NDN+f0q5UAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lze4Ji1oo5YPOFz+irYiYdIRhoZoIFqyg+Khfue62AQ=;
 b=MzR3HSDMOvRVx20oCWysQGP60zuKAlFvPjxwIY12L0VOXO+5/CeUBScvS3LA6pHj7FLrdASOCOoaunjkosLe0RsMN6XyK9YY8vFa1V31eBBXftiQhvq2jb85BOwpcioAL9buqvqYhx03j47ZL+WJ8MCn16sPMdaWGKfAnXFKQHTcqiqDM3XZwDcn1MNkETP4314Id/xTZ3Ljvs1PhJzUFVWjCgXozZfaNf/PVITHzr8K8G6YXApvrzHwsbzA+iL+48N7MyiRaxrbsVSVMG9vVSCKt2iIVthjD5okBbcYP1dls2kX95gOlFPmJypmeZO2xBmmIZVxyS4+ymAlEYNAaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lze4Ji1oo5YPOFz+irYiYdIRhoZoIFqyg+Khfue62AQ=;
 b=DxsxFhahdbWJNWjg2kRJ+dMZ96cfprGbH1hU7S3tB7FNbmbHVHmnboPcJNOThZgysms57ROzKZMc0G5zxDUsmEoGADN6kp6Gh0duKhiwMBlxYwwHWq6/Y0SkAEWRVfnYViteLOWlf/Pf+HcMNkZvqN0swlRGBrlXCRf401fmnaU=
Received: from CH3PR12MB8074.namprd12.prod.outlook.com (2603:10b6:610:12b::9)
 by SJ0PR12MB6928.namprd12.prod.outlook.com (2603:10b6:a03:47a::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.17; Wed, 11 Feb
 2026 05:16:18 +0000
Received: from CH3PR12MB8074.namprd12.prod.outlook.com
 ([fe80::e7f:6d00:5e86:274a]) by CH3PR12MB8074.namprd12.prod.outlook.com
 ([fe80::e7f:6d00:5e86:274a%5]) with mapi id 15.20.9587.017; Wed, 11 Feb 2026
 05:16:18 +0000
From: "Huang, Tim" <Tim.Huang@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Vishwakarma, Pratik"
 <Pratik.Vishwakarma@amd.com>, "Li, Roman" <Roman.Li@amd.com>
Subject: RE: [PATCH] drm/amdgpu: set family for GC 11.5.4
Thread-Topic: [PATCH] drm/amdgpu: set family for GC 11.5.4
Thread-Index: AQHcmtg3LDagH0FkDUSMM6S/lbelnrV89Ljw
Date: Wed, 11 Feb 2026 05:16:18 +0000
Message-ID: <CH3PR12MB807406ACAE9E71874BB739EAF663A@CH3PR12MB8074.namprd12.prod.outlook.com>
References: <20260210215634.70349-1-alexander.deucher@amd.com>
In-Reply-To: <20260210215634.70349-1-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2026-02-11T05:13:48.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB8074:EE_|SJ0PR12MB6928:EE_
x-ms-office365-filtering-correlation-id: e468f4a7-6a74-455a-fcfe-08de692caff7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|7053199007|38070700021; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?g1fthTEcLbyXAlEl0h/8gHWxBxzbypCMfGkZrM1fr5qBDj/R2Gn1SX9A4L?=
 =?iso-8859-1?Q?opHUT/u/st7HwWz0Q/IiCL8VfjHyUZV5YW+k2u/Dx9LG/Mb+wI9fnBR6zB?=
 =?iso-8859-1?Q?N+tnilOgyFddYA41K6BRBk7Qhs4LtpboB+0cfMdHNEN2P/eYaBltb7fixG?=
 =?iso-8859-1?Q?nNp4WmRz6RkhHNQ5/vGaqIhFf+C8VRPEbpivbqRpBZpTRDobzZL9HIC6rl?=
 =?iso-8859-1?Q?xkRIHM51GDSZit1tDVURvzuKoywfhcQfwatPneYRC8ZDjFLBe91/hZwwbQ?=
 =?iso-8859-1?Q?08X80F3rL36W2BrdZAyU4oNmQRzEaHJuNo2gRaqI6GZHtHR2ywNHsrCisA?=
 =?iso-8859-1?Q?wClxesaFO3oYIADL2tFaiLKPUNYX5qLRL/1JYyFkDcWkK+KFeONbyMhMY4?=
 =?iso-8859-1?Q?8TCsaWz1Oxbugv4gC9m2N6MrAL+jtcIcjmzhi/QYJTg1OfAY0CWMUvB35c?=
 =?iso-8859-1?Q?uZEcw0WlB2R+fDebwc9PVAKjcapS9JfgxeskdBlneIZZfOqxDw0uS7q+qr?=
 =?iso-8859-1?Q?eZpisjIGj4YP9rUiTnIAv16xNWGwGk00DkAqsnfssn8U9J0LYZ61mrMGTn?=
 =?iso-8859-1?Q?VHG3VKzd8JdhA72OxIvaArApRBwJiGElAHHKGWEeRZCGx5jag9QtadkVeY?=
 =?iso-8859-1?Q?Y6QASc96GEDKuo3vPWzYG+GU3Ye+XdmU4G6uScHXq0i+wmJ/4WCDBZM3tb?=
 =?iso-8859-1?Q?1QMBjD6JeYLCQOTJ1UsIKGHaJRJYi+l8Vs9o9EHCjGOOxkZ+jTSGccgyYL?=
 =?iso-8859-1?Q?iF1b9BTSETNjqU0EKFOu0fy2MsFxZZ95htfxu/tOSLTASqoKxpBFx5/UJf?=
 =?iso-8859-1?Q?Mno7nUfjLRxztx0ZRVVj1Rh1JBsPiwVC5DxkXXaLPJ9pyXD06dTiyDAAb1?=
 =?iso-8859-1?Q?v3SQvNn1WZnbpeIp5OJXvwTZgh0LcfI/uB1/2jsprR+aFZmYGMPqvQfbq4?=
 =?iso-8859-1?Q?AnGNlDAFl5VXPcT3j4UU/h7M8QC2w4gKfYkSY4pLcqj5iZBb7NS8bXe8d/?=
 =?iso-8859-1?Q?8lLr1aGIZ90AXW1Z1scLVIn0iP7rcbdxqN68lOqTndZSx/AMhmUPbFJT9B?=
 =?iso-8859-1?Q?jRciKxkBbm+fvis55gFdq124lhNggZUXTksdtT4RCt5KLlEqOLC+vcWbk/?=
 =?iso-8859-1?Q?kXxpUaB4PYdDaTo3SAM+CkXjNeTH1EB7i3xlAq5YobNlbwymtKPMzVgYii?=
 =?iso-8859-1?Q?LaA8dK3aN0cxUlGEZVdk2JiwXJPqQGOT2W8ggsPOIlFxDDDf+uFSGDBgwm?=
 =?iso-8859-1?Q?xkxCQvMyn7wZInypUatchfW9tUaHhLnj+FottX98K0g8mFtx9p5PAbK7bv?=
 =?iso-8859-1?Q?zLk6Zhms6WREksE39OxOkxg+oDmu/FbmB4N/wct8U0PrSL2wk9JTw9/wzd?=
 =?iso-8859-1?Q?ZajC6WXjYK6AhPr4Se7Xj3TGvBZMt6aGHxanPFPacjLhpOC5k5z/BCzOJM?=
 =?iso-8859-1?Q?+IYZ1gqzEFW4fMhSOMyeOwIYtfNKfxnnW18eU7VEQPXax/JjXsQxtuUWVD?=
 =?iso-8859-1?Q?zFm/6p0GYy1/H3XnnMRMYAZWNbKPDEtDReJ7GRGjfYiOWiW9X5eSoTk7el?=
 =?iso-8859-1?Q?QYZMkKj8JSRmTwrSAIs0HjLClxjazjYHRCyC6M4utYWH3IohawpbufgMfU?=
 =?iso-8859-1?Q?2jk2S8gkNi0gxh0fOPZrzBlkIH6/rfScY3eePtxuRtZ8SrMij939tvirs8?=
 =?iso-8859-1?Q?6Fa87IB7ktU97Xae/ZE=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8074.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?teHFR+YoA8Sxj2t+G+1dLZ2Qa0xwkHvh6LVA3UPFzVOV9Lk67T0ZOHP2TL?=
 =?iso-8859-1?Q?Di9eBNVGT9e9HjDFFyM8nYbRtIEIl2klnFp4e1c3CONsOxEJdvzgcCDUP+?=
 =?iso-8859-1?Q?yII90nm33n5NYQ5O7Ly8s9hfPxgpNc81p9/s87x90FKIEIVFhfk8uGPODj?=
 =?iso-8859-1?Q?PDIKRHfrPlssa31OSFbs0/lOL6fVcbpXnUtEeCcCYD40Wx9TO52rzkG6Nf?=
 =?iso-8859-1?Q?JfL/MVqy5JPmbPzXnYO2gfYt3FQxShHH40CSVFDhP3jP4GU7vNhlwLpuUg?=
 =?iso-8859-1?Q?EesH9n3UV/rBk1MwPLx/ThnaX9Lp4PDxqPVB3E+aqup6e9Q/pL7DisUAmz?=
 =?iso-8859-1?Q?X8hiycYqNa5F3Kq39K8r0pX3Q/u/TiA+7SaOSIxzYPBjq/Ik72BPUXF47W?=
 =?iso-8859-1?Q?JdUo4teA3m3gK8hamRP/iC+MZqbmc8/jIxFw3BB+6Uvo8mpSBrCpAyVEIN?=
 =?iso-8859-1?Q?UrvLW7k6KSb6z515g4uHjtPvIaND5a00ytKzQFqcjU1Qyv0xgF+z4KM2cW?=
 =?iso-8859-1?Q?itsfLwoxVbPZ64cjDa84WCioKjzbw+K+0BXZiNVGH4luFZO6s77C9QxJOL?=
 =?iso-8859-1?Q?IA3tMz3GXDbIkKdSpzSiYulE4ZqsrS4j/8ZR+EXcGCvnf4amlPUA+HX+zG?=
 =?iso-8859-1?Q?K7QdOnaEfFjv1N89xwBFA045g11638sdY1EOcaF9TsTxdR5HfWm5kEb1vk?=
 =?iso-8859-1?Q?SBQ+PpG+yVRJ2PHotnA7XbyaxWuX+OTgHgns/K9JVCr0yBm6Sbu2a2Dggd?=
 =?iso-8859-1?Q?YhF1Ha7ghx+J8mYimha2/Nu7pC+TQXDV2NXDZg6yVW9aD/Q3m/IY0aix3P?=
 =?iso-8859-1?Q?c4LROJomnwDqaXFF0utNgwjgRBX6LVGcbl8y8aPZ0TbdDKnO42Da4LAkEq?=
 =?iso-8859-1?Q?zigkBAld2N/gl8Dodf6cw4PAmAzNrN3WLoaojUVUGAp3fJv7YhUzKNxCz8?=
 =?iso-8859-1?Q?b7+egTYwBRpFpvE0SYnlN4InvdrIXcBjc3on1jSUnx1qoIVKom28bnkIHu?=
 =?iso-8859-1?Q?O/oKbQ0RrUUUqSosqgmSqN7ggTFcpMfa7Yh4BIQMxVy/+sqRuLa7selncZ?=
 =?iso-8859-1?Q?6eUihuTzRPe/hA/SFd0vb3vckoSzA6vBOSElldLHaQNxgA1PBPpi1P9C58?=
 =?iso-8859-1?Q?TUCIPG9tCO8ROiHRwujhsfsp5CFex5oG3LaV2UYjpX+sWKUzjZyroB7gBR?=
 =?iso-8859-1?Q?jfJnWawgzgaXoPFuNCBkvpHRH2r2qeZED3jhaMdHfI+ogKVq4Vmav9JDJ0?=
 =?iso-8859-1?Q?vRIH7BDW4zWooYufkG3nCCN/0hyNL5W1Xd7OuG9rtBu8wzXJtmmfsWtQ9X?=
 =?iso-8859-1?Q?TA3IfXO1XR9ByuPmCIsWmS2KShES9rgl3OHIkZABmvYbCYiATxey7DtLEu?=
 =?iso-8859-1?Q?Tw18ob6sFOJdl7W/qA3ifZTbYCAJT50mVRoV4Zy2//+ql4USj0gOJ7YOCX?=
 =?iso-8859-1?Q?pqaC9uV+xxuI1+CVO0t5su17A13M00Q3D2CSb9nbSsfyuVFXjbNbP3gjVF?=
 =?iso-8859-1?Q?HhBmc8CGNl99p2hYmn9eXqaN77XXmHZTcW6WxBrsq7+fws90LIiRhTYgc4?=
 =?iso-8859-1?Q?tIBNa2g7yRilO9dFmv1olSVXu6oiDnV1gGikt04SEEnHXO8NcBadSx0LIW?=
 =?iso-8859-1?Q?OPjSdR1LLQxwqmduk7OfKqwtofABcYEhZgUZ5Yz4anw/xLjDx0aiuGKG9/?=
 =?iso-8859-1?Q?KlTyclg9zfB1ryBwtJYLoNR56ITrXoHZk7FH2rzFyZwBCkIEmqXuoV+hVv?=
 =?iso-8859-1?Q?ubi5W3XXiGwdJyqnjkuBo0JerbA6qJMe+2j4Qr3a1A33Xn?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8074.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e468f4a7-6a74-455a-fcfe-08de692caff7
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2026 05:16:18.4463 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LQY/EO37q4B37zGTDb+mBd/NKFmU8Y8GNIFFYjSlSiaP7rqQ0IlKTKiHUx//fN9CIFupaJrZLKGyXZc/tbkJQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6928
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

This patch is,

Reviewed-by: Tim Huang <tim.huang@amd.com>



> -----Original Message-----
> From: Alex Deucher <alexander.deucher@amd.com>
> Sent: Wednesday, February 11, 2026 5:57 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Huang, Tim
> <Tim.Huang@amd.com>; Vishwakarma, Pratik
> <Pratik.Vishwakarma@amd.com>; Li, Roman <Roman.Li@amd.com>
> Subject: [PATCH] drm/amdgpu: set family for GC 11.5.4
>
> Set the family for GC 11.5.4
>
> Fixes: 47ae1f938d12 ("drm/amdgpu: add support for GC IP version 11.5.4")
> Cc: Tim Huang <tim.huang@amd.com>
> Cc: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
> Cc: Roman Li <Roman.Li@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 4 +++-
>  include/uapi/drm/amdgpu_drm.h                 | 1 +
>  2 files changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> index 41e63c2869125..4143a25a498bf 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> @@ -2988,9 +2988,11 @@ int amdgpu_discovery_set_ip_blocks(struct
> amdgpu_device *adev)
>       case IP_VERSION(11, 5, 1):
>       case IP_VERSION(11, 5, 2):
>       case IP_VERSION(11, 5, 3):
> -     case IP_VERSION(11, 5, 4):
>               adev->family =3D AMDGPU_FAMILY_GC_11_5_0;
>               break;
> +     case IP_VERSION(11, 5, 4):
> +             adev->family =3D AMDGPU_FAMILY_GC_11_5_4;
> +             break;
>       case IP_VERSION(12, 0, 0):
>       case IP_VERSION(12, 0, 1):
>       case IP_VERSION(12, 1, 0):
> diff --git a/include/uapi/drm/amdgpu_drm.h
> b/include/uapi/drm/amdgpu_drm.h index 7a7a9f4787fe6..ddd4182540720
> 100644
> --- a/include/uapi/drm/amdgpu_drm.h
> +++ b/include/uapi/drm/amdgpu_drm.h
> @@ -1676,6 +1676,7 @@ struct drm_amdgpu_info_uq_metadata {
>  #define AMDGPU_FAMILY_GC_10_3_6                      149 /* GC 10.3.6 */
>  #define AMDGPU_FAMILY_GC_10_3_7                      151 /* GC 10.3.7 */
>  #define AMDGPU_FAMILY_GC_11_5_0                      150 /* GC 11.5.0 */
> +#define AMDGPU_FAMILY_GC_11_5_4                      154 /* GC 11.5.4 */
>  #define AMDGPU_FAMILY_GC_12_0_0                      152 /* GC 12.0.0 */
>
>  /* FIXME wrong namespace! */
> --
> 2.53.0

