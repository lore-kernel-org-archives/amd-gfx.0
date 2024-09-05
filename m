Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B54CCD4F59
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Sep 2024 07:36:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3321010E6F0;
	Thu,  5 Sep 2024 07:36:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4qG5bURt";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2073.outbound.protection.outlook.com [40.107.102.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8D15F10E6F0
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Sep 2024 07:36:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yztLHIme8qC8hEXDjIP9QVF0zJ5G0CdNh4Ixtfs9C6M2Ac8cqULyehE22om3FF2nND9TSqH86xyM5V2EE8cmLogOOutb03LXPR1B3mpfYjT7vqwYs0xszZQ45bdIqLQq+w2CBGDC70LDltr+4FKV3K6Q+hq3AiZzlRMAhOtg1rDJOubVNDrU2nlnAbdEXYII5TJmBrrisvCYXzQXR/4qqbUngHsVOWgvYDSA498W+Zj8Bkd+5mWc0XdKY0/c6a1HZ+p17FSWi6XQSLOMFMCVU1nVtKCzVMA4vjrc5+irfF88JlPI8VPU0qcyAucckP2bv0IO3U9H6byyf28efrUsWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gmKvE9sVML61fsOJBoIH+gFd52aGTTN92yuzPL5WB04=;
 b=xwynfEKA7NpIXABulrO8s33jyK8M5nMvNQYAnVPzkbV0SJZJ6brSWWLUxcu3ATtgq2zr8PzFDbNrVggCr4avtJGBrOeuPthVxhL8Ywg8j6BaMGEUJNoasb3UsMvJYTeXzguI151Gi/7qi4JWJ6Vn5fteM1ope1jfS5x7+MJJHM6FY/L0xptgU+vfK+aS+BhQhujRYC1h8444Tcrf4q8MX+HH/WtCI4k6NW1kiBEW1TZyXp1Gmgrfs6cg9UY59zG70RXEj1oBhiUuloX2wzIm5tauHxMay5Ya+Pdp0Tp1vyZeXpL9yHIvwnPjC3zi6q1Lio+YRy0jRBhihXP1XkcbLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gmKvE9sVML61fsOJBoIH+gFd52aGTTN92yuzPL5WB04=;
 b=4qG5bURt6ZosJUqJKU9VXY04KmHl5iNifh24cXYyc8lgoN41Ph7HzM2sb4BsGvw1iiMCPOOFNOe/TS9Ldr1GD7YQO0AkTcvXmJOYP/cJUYo/G6B2oT5VBYoz8MNgpU/+RVoAC+E7fGnbKUZdXgBdzK5YIb6xDNbj8+VypuWDAbE=
Received: from DS7PR12MB6005.namprd12.prod.outlook.com (2603:10b6:8:7c::17) by
 MN2PR12MB4238.namprd12.prod.outlook.com (2603:10b6:208:199::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.20; Thu, 5 Sep
 2024 07:36:01 +0000
Received: from DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb]) by DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb%4]) with mapi id 15.20.7918.024; Thu, 5 Sep 2024
 07:36:00 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdgpu: update suspend status for aborting from
 deeper suspend
Thread-Topic: [PATCH] drm/amdgpu: update suspend status for aborting from
 deeper suspend
Thread-Index: AQHa/Q/9qItUk6VUqUSLe/ZtzNgwobJI0iLQ
Date: Thu, 5 Sep 2024 07:36:00 +0000
Message-ID: <DS7PR12MB600580C6E52BE6734FD7F0F7FB9D2@DS7PR12MB6005.namprd12.prod.outlook.com>
References: <20240902081311.2918278-1-Prike.Liang@amd.com>
In-Reply-To: <20240902081311.2918278-1-Prike.Liang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=3937ee90-2b3d-47e3-9f9e-dedc15b230cb;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-09-05T07:35:07Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6005:EE_|MN2PR12MB4238:EE_
x-ms-office365-filtering-correlation-id: 4a010c36-e893-45ea-00c1-08dccd7d63d8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?s9M3H+1t65uUQ5f7Op/SrfV9VsZqEhYz27Iog6OvBy1VyyDzNhTPNOoEPYZU?=
 =?us-ascii?Q?j7r16+xKWX2/UY4HfxF8iudPDMSMCr0RwU8TE/jP9gTh28PvcEreMDqSgJFz?=
 =?us-ascii?Q?OAoN+j16lVMOhHKr+YzzDS0aI6VFZXxME38N0n1OgcAL5tR2ZKcWwbBTH6iR?=
 =?us-ascii?Q?wlCbZcEwIizwAL5F5ZJurp1u3lFeu1uFiP0tvdopfFuX032uYa7PpDdgb0Km?=
 =?us-ascii?Q?TNKFuvY3zC5KCepv8fd9gf76W3tMNYnDG61n9oKbUzcuSpw5/PnhVjXk1S13?=
 =?us-ascii?Q?baD0apMejbSTCDIjAU/oUu0DaiQOVD7z0l6M+xKHQ6liE8+Sba6gWsuGQp1k?=
 =?us-ascii?Q?tYjix0ul/il3ZsonZ/kOOe6mWotXR+NvXkxyaSkY9ght0K7csuiARizOKYMr?=
 =?us-ascii?Q?/Y88kep2l5YEVFKqeucbNZfjGR3WGU9o2OHfsRHJBDQ/w4Yx7DExVNw9yVDd?=
 =?us-ascii?Q?HzYqqfDXI38C1npdozoehp+Ek1SR+oKmOZp1HEbhQOcwmew2U8uLqPEnxm30?=
 =?us-ascii?Q?I/GIwrOQsJBushBRUbTbtOGnz7MI3u2EpLJCRMl++wxJRwX5yx8fmwSpWRx0?=
 =?us-ascii?Q?duIFz7VAlwT90yAl/BQmq4e8q2fg4YjjYyxf3ZEMBFAZ3P5NEvWjLJVOX8wt?=
 =?us-ascii?Q?r3Cqq+ffHHh7QZJSKJ9HTPvYSG9YDCPXE4x7l+nBzq8XzowpQ3gmsoWORdn1?=
 =?us-ascii?Q?Clc374A0cqvKHkdc7sjLkZYca/HPPBbBVXgn+ZGS/yF/wgRVarVWn1JgeGYA?=
 =?us-ascii?Q?SPiZCQ3UUrgp4umpSKphd2lykhRJYRe+mYWj+VMEFRntWxhn0J/ObhqbzlWm?=
 =?us-ascii?Q?tdXjp9xQmBGYDngM5ZWtP61gzBxN/YkMkn9Jd+59AU97Zqg0Lb1AYMNgGJtY?=
 =?us-ascii?Q?NCe+gAbWmNC0rY5SMG+n3ZzeOW6iJFkLIsF1Xn5T9UN1o+IxtxaPTZZfLoe8?=
 =?us-ascii?Q?a9Q0ibmzBtv8khm+83RYwzYLL/PIZTaWFqMTy3WbqW/HfxJxgx2FYo422Ruz?=
 =?us-ascii?Q?u/TncNZYQKzjB28ZeRNYPJqvQOnhZlHlZXwO+MJu3tbY4zDuqIdm1KG2HzwP?=
 =?us-ascii?Q?A11BKS70UHxYDh80Mi70XSCkpRfH8F7N+G9p6QoUCN7KZUz0y0L6Lii+YbxY?=
 =?us-ascii?Q?0mE98dzx0qe8sq5UpYvrVFPRQhfWJJANKre+TDOfMge32vUMP/QhehGh1NSW?=
 =?us-ascii?Q?EHJY9NmsZ1oqfhW4sWJs8mdXmANbYLKBPKB2jgc0sq6WqhpP9SaME+5rpOEu?=
 =?us-ascii?Q?FnxCOroD763P1yTZJ2G/8rVDP2jncgKbjTzXLk9JUTC+HuSdolLt8eiWK819?=
 =?us-ascii?Q?HTU1JJuBoo25keUybMkWfC9JlnFFpaJ9og2xPBxzZumjpHO8XgZPBoOAulau?=
 =?us-ascii?Q?bQijQxc6Xd+kW4DHkHEk6gl4FQkcuS6Tzfrfse8CDV3PjThldg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6005.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?4YYauh17CtPnU+8EytyTX13a2ws6CzAOgTNJtR3La89ccNIWU/wwTLHQ0pe0?=
 =?us-ascii?Q?2idExE7Ky7OxTToAmpsttFRzWxVyCPVWiwpUvWVX75Jv79HlHtZNjNsV9Ajm?=
 =?us-ascii?Q?YgVq8x/HTXZKwGSz/V9cbTDZGarrgKEl7BN68QI+BmUiKdXS0cCzG3smcAgJ?=
 =?us-ascii?Q?mHokA1WRkUXwxkMMp3wTGRRM02hIvgAG3Z3DCe5LiqQi6kew4kH6ri64hufn?=
 =?us-ascii?Q?VKm3LLU23M4Dxy2OZHORzw8Hl7p0Egv817JEB1W2vFcXrbyp015y7zF7YVyc?=
 =?us-ascii?Q?7IDX3CX/K/qtpVUdHrpqawBvT/c/8zkGBeFj7aI5iu1dc9u0ILP1Q26VnkJd?=
 =?us-ascii?Q?ygR4XtndGp8qlVrIoMHVNI8sDGfz5eCWmqXMhqTJU5cIarBUxLz6PR8q/uzF?=
 =?us-ascii?Q?nxHh6fD7Axv30o0ysW/7UdXNCzen/QTPu2bcwaig1+FrHrBslAbYZZxwclea?=
 =?us-ascii?Q?APK7YJLyCv47nQaoBMUv+BKLTPBjKnI13afW+3AUic0wDfswfJg3+Ve095Bh?=
 =?us-ascii?Q?2mTakTmN1v0ZosaOtpaqMJcHY5VglrTZHiaur5CrPVXvKKoXX37EOXKS5sBe?=
 =?us-ascii?Q?ThBJ5DTr1IplawVZRGtPxZP/2cyrIwMfaEkzddqie3NSyYldxgkBUsT6K+TB?=
 =?us-ascii?Q?vzZliABGugZcEU+OYgv+ah0HKLqDnVR6cAz4BOalu43gXXpJ89IXxU+NG3Pl?=
 =?us-ascii?Q?/vAo5Qxtpxi6XJHtxxYdQ4kv2RVLRanqB6Ers4CbMV2Wo2DDwaeVmiu3v0tx?=
 =?us-ascii?Q?AKOpn+QVGrW7q6N53XWQ0gSLY/e5ttKcpLYqOg3geQZzVKHfwIkq44kMopBp?=
 =?us-ascii?Q?EBDK4ZQeZAfOXy77aarP8RSLT/gKEYEWcs+Q+YbTkld6LuUMZ4q5Oe63v4Xo?=
 =?us-ascii?Q?+NjESv6QUM4ew5w9OxEkpx6wRXOknP29p4oW+sNIyVcKEwKr9voqjkON/DTi?=
 =?us-ascii?Q?/+ySc8qbvGMLW16oAD4V+Hb5lHFQ+gD4KLMoDSrhsVaDKaLO1HY8nsYZEwrP?=
 =?us-ascii?Q?mYXBweFIGHDGzqbnuozhfrGF0bnZXhTCHAZ+ZBuQmPL8UkZIwq3LvseCHWKk?=
 =?us-ascii?Q?is4/qtccFEU0Hr3pc1Y/kohXBBS/2TEtrjxjmZ+8KZRWAnMJwSZLWufwCq3m?=
 =?us-ascii?Q?uHdYqsSzFP04P2Ei7sSl0owzHibwYr26l4vEotdkwQbwUXD74TKmSnqNep5h?=
 =?us-ascii?Q?hAbXNZtg0yKX6LP2pQGYt7xLz9Mq+O2UcQgoPbEr6dBV+rzYOktfY8N5CqUW?=
 =?us-ascii?Q?o9CXQfN/uzVOR7TLtPa/pq7CTKiqIE0pMD0/hpU4IEG9jipH00bpSP89y88R?=
 =?us-ascii?Q?w8pqzjY8cb9VX5+1b7trSbph4iqmwWVIQrbkdFzQePvkQKSt7R+6sSEVmShE?=
 =?us-ascii?Q?arbvmUnx5WCxy6MOiR4bNgyfCUZ6ze7XnOLAa8x5JSFae1xl9mHmdtWgAj/a?=
 =?us-ascii?Q?yoq1DqwP4Exa3cNiAYTAO3gz6pI0KGH9b8L/XuOnOGiDGhDDjUIe1ori0QOM?=
 =?us-ascii?Q?yKoDYIo41+tAqOPoDYOykRbcHrqymF3TOflam1YcxUoYr+ZS64mRZtV+y4dh?=
 =?us-ascii?Q?+Wx/qsLTUhmXajBezTA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6005.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a010c36-e893-45ea-00c1-08dccd7d63d8
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Sep 2024 07:36:00.8931 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yTpgY4MBWpp9Vkz4g2/vRlbuuhaxXuysS1kkOrkbBYYrvnWlskLpKmeNP27ZDY7i
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4238
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

According to the ChromeOS team test, this patch can resolve the S3 suspend =
abort from deeper sleep, which occurs when suspension aborts after calling =
the noirq suspend and before executing the _S3 and turning off the power ra=
il.

Could this patch get a review or acknowledgment?

Thanks,
Prike

> -----Original Message-----
> From: Liang, Prike <Prike.Liang@amd.com>
> Sent: Monday, September 2, 2024 4:13 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Liang, Prike
> <Prike.Liang@amd.com>
> Subject: [PATCH] drm/amdgpu: update suspend status for aborting from
> deeper suspend
>
> There're some other suspend abort cases which can call the noirq suspend
> except for executing _S3 method. In those cases need to process as
> incomplete suspendsion.
>
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/soc15.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c
> b/drivers/gpu/drm/amd/amdgpu/soc15.c
> index 8d16dacdc172..cf701bb8fc79 100644
> --- a/drivers/gpu/drm/amd/amdgpu/soc15.c
> +++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
> @@ -587,11 +587,13 @@ static bool soc15_need_reset_on_resume(struct
> amdgpu_device *adev)
>        * 2) S3 suspend abort and TOS already launched.
>        */
>       if (adev->flags & AMD_IS_APU && adev->in_s3 &&
> -                     !adev->suspend_complete &&
> -                     sol_reg)
> +                     sol_reg) {
> +             adev->suspend_complete =3D false;
>               return true;
> -
> -     return false;
> +     } else {
> +             adev->suspend_complete =3D true;
> +             return false;
> +     }
>  }
>
>  static int soc15_asic_reset(struct amdgpu_device *adev)
> --
> 2.34.1

