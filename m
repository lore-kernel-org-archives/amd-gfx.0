Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD772C36010
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Apr 2025 04:55:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5C7BC10EADB;
	Fri, 11 Apr 2025 04:55:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="e9DtJ6mS";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2073.outbound.protection.outlook.com [40.107.236.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B655010EADB
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Apr 2025 04:55:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rh+KtVWmGnQ0LVrp/QiwtusCfv65a53szBZdOH4igcRmKU9WrzEO5MzchmQmWcLX/au1asBwsiHpRRWfzxDJ2shsKNr8PTD/6lO3eXACE2QuuN7S82DvPYRF+wnWTxYbYTse7qNTEFTbei7D8d6t1pFe7VkEIkLWbCeI/yAYUdUwAw6ONlmCAIYD5MReoFX3TVsbR/jUf+TQErI3fSJ5xaJ6+NjlmMeROSsUe7q800EjJO+JoiE+5cvfk84iE9ooo85GHvWhPNAvFMz97NRFTtn2pfkHNBufKwZsfS2RYlhS/mOwrgitjsdUM2xn+5wFTGrZABVYtGTEqTeIZVifVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z4QJHkNqqVDhB5c6OrxzZkO4ZVUX6dEiaDPvbFmedXs=;
 b=E+X2CsKn3MLY5dQHm18Ihtxjjt0xGc7ZT3jK/MxOEpBgh6SrcGFgYULWkx0yoPl7wURrcbikN76/VyvY6gWLOeXT522j/RHrBPG6MGRx7mUzLbKd9ynu5VN4OGZm5O3ilquLcX6CH3nRhr4B6bzfD25LTMcQ6sCHfXGbImBXZudM1pIjAffKxxVHmNKKe56zQyy0hj6W/EkuLipYUqd40IMEDZaMcXadaCeWODC/L9jktSMkzQi/ol05kyuQY0Tdk/bHkUQmPcdJLBMYUIWbu44qyBEri6ls4jvwefMfau5eKSXJPVuXg8NMOEmQsLYGGk00dTlagG5WFbGhxqSiZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z4QJHkNqqVDhB5c6OrxzZkO4ZVUX6dEiaDPvbFmedXs=;
 b=e9DtJ6mSFHS0+J84f8RL8PQB5B8loJrUtxR7gzgXEjtyv9KSZDqK/iln4MMQXWfCO6bZwzyLw1l1X9hJJDduQ1EQwa2g0Iz6QvY7RbgkGZ8jwNfgOCJslmkaQ48tSRvLjVRMRncp+k5bwzwHoc86Ag7xXLUxT2e+T5lZp81Bfys=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by DS0PR12MB8272.namprd12.prod.outlook.com (2603:10b6:8:fc::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8632.22; Fri, 11 Apr 2025 04:55:41 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::491a:cce3:e531:3c42]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::491a:cce3:e531:3c42%6]) with mapi id 15.20.8632.025; Fri, 11 Apr 2025
 04:55:41 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Yadav, Arvind" <Arvind.Yadav@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Khatri, Sunil" <Sunil.Khatri@amd.com>, "Sharma,
 Shashank" <Shashank.Sharma@amd.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 2/2 v2] drm/amdgpu: Add fw minimum version check for
 usermode queue
Thread-Topic: [PATCH 2/2 v2] drm/amdgpu: Add fw minimum version check for
 usermode queue
Thread-Index: AQHbqij+KyY2G2n3F0O4SuJCkdkcobOd5ymAgAAAY8o=
Date: Fri, 11 Apr 2025 04:55:41 +0000
Message-ID: <BL1PR12MB51446C91686B8D6B3E3F7A0FF7B62@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20250410145750.51421-1-Arvind.Yadav@amd.com>
 <204b9b11-9045-d180-927e-ba1cb015b368@amd.com>
In-Reply-To: <204b9b11-9045-d180-927e-ba1cb015b368@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-04-11T04:55:40.898Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|DS0PR12MB8272:EE_
x-ms-office365-filtering-correlation-id: 331ef487-8e92-4212-7daa-08dd78b51c26
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7053199007|8096899003|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?Azr/VaijXEh3yTeE4J/ybMM4ezMt/o52YviLFvpwvbUfakmQLWWxIagYAIKC?=
 =?us-ascii?Q?v0OxCgjPYgnfqjw4p5btTTobFBxfnGm3bH1vOls0NBsLSlwIaMQQxX9cimAe?=
 =?us-ascii?Q?KCQ4d43zC36obip+0fTpusKsaAPPHKEjhy+t0JYHmznvgmtV07E2a1Woi+OK?=
 =?us-ascii?Q?btyAbXFdQTYwOiIwVZ1rHCFcM5VlLiHNENv4LJNPL036Vgmb/q5XDOJFYSdI?=
 =?us-ascii?Q?6l02gTlcZxOMUZAHXzAVU2fGs9KmHEcof6Gt5A4QIYWTrB7brIRAoxO3RvEZ?=
 =?us-ascii?Q?6l2lPjSGMHhz18Ky5hqPf84VKSqdKndSZo/hIQ1R2M92GuKgQR/Tqk7842w0?=
 =?us-ascii?Q?ClaNqMXoHApEz2ClOu0DpxEAMq4/kmKCEUD90GoNBqvrmUXPALAXLGRjXwJZ?=
 =?us-ascii?Q?XgWJiuZwZ9JN6VGyvUS22MMRCBTAGqvGhdEoC17puWQskn8UFY31BdcOPZ4q?=
 =?us-ascii?Q?luQMBcnjPnt2BXY4qdVxztjybSH5bBz7i8DdSl1tRLoxs057yG9N7OWGVlvK?=
 =?us-ascii?Q?yDTl9ny7WC7pRHoCAs3L0n2Bf6Q01tT6dJwLjAJaFDFZqp2u0Wo2Z38SgeQ5?=
 =?us-ascii?Q?rtKXbyTn8vImlX3otYnXEWaQ2GGJo8F62cb46DweW6v3GEMi5VNLNnHrbuWX?=
 =?us-ascii?Q?L0ioBjRS265n4beQbbM6yVUQlyMm89h/4L76HarFTWxiANxIBhLSyvHevCUy?=
 =?us-ascii?Q?Xuy1gfKxUJRb0MUettQQDrevrxiU6xU+RX02tZYfhzPB9M5dcLl2Hov76DPx?=
 =?us-ascii?Q?/l9GxPieGMJa1EMJi2/qe3hxBMx5QMItVTnSOJPhLAuc8ZVYIuu78KmsXgkd?=
 =?us-ascii?Q?lW9eL55ABqlqBmminnekRue37FGishF1lfIq6ZV3yUS8COaFGKgIWF0WQlz3?=
 =?us-ascii?Q?TKzn50gmFCAlAloetqkzoUHKEDYz9eDiItcHReaX+9UX8H0yHKzIwU3vZtd1?=
 =?us-ascii?Q?Cd2Ci7GCSRHtFCL9AdZMPSSCtX+gnkstEcmcMzaBp1kJ1atqUX2Rv11j6+d1?=
 =?us-ascii?Q?KtprvnEUDHtKZKnOdnSblOHWOoyCfIwCx/qzrpfnfmE/LjwzqU7f1bFCscxo?=
 =?us-ascii?Q?0oGfqIxTuzwSNVsEB4FhBmJF9VqfdvtLOCl9dXz3ms1r5LODqWD30rdFOxcU?=
 =?us-ascii?Q?A3yYgIah9szhrEhklDxQo7slwo0Ao8kb6We1A0jhoQca8XPV5JFBM10wEeC6?=
 =?us-ascii?Q?tTfUneAsHQjh9P15Zz/tMMsrJotnv5Rmu+XxSEuC6OpQngyTTdD7XD9EOMJr?=
 =?us-ascii?Q?cqJuAzwtFT7ACuUOZTlqXdbOJ0p+I4pDyJsG8796rvkvtee+pCSOzNdVoig/?=
 =?us-ascii?Q?UyWTH9mmW67pE5/L9D6atS+00xrcWv3GqkhOi7ksDTV/c+t8Ggn68OqUQYxG?=
 =?us-ascii?Q?XA2tXL6q7+45s6dh1BZF6zzY/3iArMA7lIGhv9L0aeGznx7wFsXOcEAs+pSx?=
 =?us-ascii?Q?M988LCDeVYZObFqVGQTkhS1H3uB+xHM868/leNDYtJ8QQ+ButyDtu9WBHzED?=
 =?us-ascii?Q?iFN+1HZUr7BLI2Q=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007)(8096899003)(38070700018);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?orVOfpDKrLdsDXYU2oYitnKb5D4cvAP4YW+bmyVEDUyuHixlzwpu+EC2B2tD?=
 =?us-ascii?Q?oikByuDaZJ0A91Nnlsrz1OmWzDlrcyYd8OfRMtuK4iqB3ezLIH2JRmXGJorU?=
 =?us-ascii?Q?MhIxYkqvfbeDKE9OAkcLtL9ojtwm8SfVVcy1xrUUX9bDHAzl/0OR6UT1V1gw?=
 =?us-ascii?Q?XOcdoYl/wfBEWHSDLZ0k/+PkKRMm4L5CPT3g2rainYy7Nz4ScCJgTJnaYlzd?=
 =?us-ascii?Q?FqVHPDsSfP+fb5tQsCmX2L7dy/BOtr0N0xtkBabgETic3cRJm4HC+fGJzEiG?=
 =?us-ascii?Q?WE76lAQb5FcMDFrN4YQMCohoU/JDLugt8U6Drz6oHyhpFecurxM/lxVjltFV?=
 =?us-ascii?Q?tRuvMO+UIkCUNiQmdz5gzvliuAJBd57XeEAMvG+WfNS1p8Xc/odAQXbu32Ow?=
 =?us-ascii?Q?PS5Q4f1BtK8t/cdYdxw/hsRK5T9mSZB6sv4prbOzKazz1njhPu508JaQrOej?=
 =?us-ascii?Q?y6tiD1ND5UvEVzFDnb+IRzxgUjj9bbW4uD+QIjSvWTcmNlV4nctISSnWbySY?=
 =?us-ascii?Q?Oj871+08VZOtL+MKO+JqnVX5kwXxgOMBuB58YWvZ9f7ugEmV7S7Fah1kEFWQ?=
 =?us-ascii?Q?iUYGEYYd+7AILM8WIFQawLqOac7LRgZ72TrRB0P9zesIyy2phxzB9rrSp+KR?=
 =?us-ascii?Q?Gv8mQYaYlVIybfxY5mC6sYrxHN16zzbKiY/TQHxSDs6GVS4sLdGx08hC4OD7?=
 =?us-ascii?Q?p+iTFp2rI4nckV8UdIU6qdjvGPvW1LCt+F5qtR6IYuFqEeWmioTffK/bFUcM?=
 =?us-ascii?Q?oV46ZTIgVl7X+xD20TEoOrP35VksT/EUSodgxYj+RPRBjJ4x6Ng1SyHQWfIm?=
 =?us-ascii?Q?fC8ohB2ohmByniEIskFvmDl6ERyj6bk/3+oR1Lig3Du5yXfsWdYkeW83xmog?=
 =?us-ascii?Q?O9HKyy2nBCaIdbPE9zjnp/pddfFSSc9J5tvZv5b0t4+b/pEtPL7GAxnIqWXJ?=
 =?us-ascii?Q?eYjo0mQg0PsQ2uXPVQB4hFVqHR9fCs1cOdBrtpYcXa9cxldMBlqlovVsEToe?=
 =?us-ascii?Q?GBjRWkNXYw4nJWm+1BxRxPjkcV1Rp+7qKv05oIvvH6UE+xpjEG63jcUc59yL?=
 =?us-ascii?Q?jwOaVW4OSopOxd2Dk/DOb29mbI6vK9FqF+LzyqnM//mS6OTcm028R90/CXZA?=
 =?us-ascii?Q?EBkY7sKP98J86rU4YDjwTuqfFvpvyhxGGyUWryv//qOH6Jrt/FM+1aUEgU82?=
 =?us-ascii?Q?w0KvVdn8Z4vnImy3llHYi6AVgVtgXP7voUM3++MWBuioxoD1cOicHVq2a5+l?=
 =?us-ascii?Q?wdJj0WyHF4FJGNEAnM9X3pwMrcE6jk3cKaUK8HRd1xvEm5Obbi1XTo2sg97+?=
 =?us-ascii?Q?sRw24/aODcr+kk1GiTTCN2U3BNv13wxnS455CepuMoPmM9O4+EoQHU4cz1w1?=
 =?us-ascii?Q?coT+jB3AJYTBke+SWFf0PrLVe/oWkCuZxBXnFGk+1DVCSMZojdQLcqJ8jezK?=
 =?us-ascii?Q?r4FIJlp3Gpw0RBJ9iJzFtWv5OIBSUcd2UXAlXN8o5bxvpoctUfr+jrflJzwu?=
 =?us-ascii?Q?zel8m/YgsdkDLfvdsD7AuT0jOOJfWy7Tp3S8DwQ77rHdNPDFdDkMDRtILrsa?=
 =?us-ascii?Q?71oSfIzwX/po6Ve/doo=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB51446C91686B8D6B3E3F7A0FF7B62BL1PR12MB5144namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 331ef487-8e92-4212-7daa-08dd78b51c26
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2025 04:55:41.3145 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cTS03IWRk4luGUchh/7Z6oceFBX+17KvII6HmztliU41+rzWOomxrv2/z1y6J0dF9vRwYMbR6H8z9+Xwwr2FbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8272
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

--_000_BL1PR12MB51446C91686B8D6B3E3F7A0FF7B62BL1PR12MB5144namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - AMD Internal Distribution Only]

Acked-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: Yadav, Arvind <Arvind.Yadav@amd.com>
Sent: Friday, April 11, 2025 12:54 AM
To: Yadav, Arvind <Arvind.Yadav@amd.com>; Koenig, Christian <Christian.Koen=
ig@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>; Khatri, Sunil =
<Sunil.Khatri@amd.com>; Sharma, Shashank <Shashank.Sharma@amd.com>
Cc: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 2/2 v2] drm/amdgpu: Add fw minimum version check for us=
ermode queue

Alex,
This is v2 of 2/2 patch. Please review this.

~arvind

On 4/10/2025 8:27 PM, Arvind Yadav wrote:
> This patch is load usermode queue based on FW support for gfx12.
> CP Ucode FW Vesion: [PFP =3D 2840, ME =3D 2780, MEC =3D 3050, MES =3D 123=
]
>
> v2: Addressed review comments from Alex
>     - Just check the firmware versions directly.
>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian Koenig <christian.koenig@amd.com>
> Cc: Shashank Sharma <shashank.sharma@amd.com>
> Cc: Sunil Khatri <sunil.khatri@amd.com>
> Signed-off-by: Arvind Yadav <Arvind.Yadav@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd=
/amdgpu/gfx_v12_0.c
> index 3d87e445270e..3165fdfeca6a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> @@ -1418,7 +1418,10 @@ static int gfx_v12_0_sw_init(struct amdgpu_ip_bloc=
k *ip_block)
>        case IP_VERSION(12, 0, 1):
>   #ifdef CONFIG_DRM_AMDGPU_NAVI3X_USERQ
>                /* add firmware version checks here */
> -             if (0) {
> +             if (adev->gfx.me_fw_version  >=3D 2780 &&
> +                 adev->gfx.pfp_fw_version >=3D 2840 &&
> +                 adev->gfx.mec_fw_version >=3D 3050 &&
> +                 adev->mes.fw_version[0] >=3D 123) {
>                        adev->userq_funcs[AMDGPU_HW_IP_GFX] =3D &userq_mes=
_funcs;
>                        adev->userq_funcs[AMDGPU_HW_IP_COMPUTE] =3D &userq=
_mes_funcs;
>                }

--_000_BL1PR12MB51446C91686B8D6B3E3F7A0FF7B62BL1PR12MB5144namp_
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
Acked-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Yadav, Arvind &lt;Arv=
ind.Yadav@amd.com&gt;<br>
<b>Sent:</b> Friday, April 11, 2025 12:54 AM<br>
<b>To:</b> Yadav, Arvind &lt;Arvind.Yadav@amd.com&gt;; Koenig, Christian &l=
t;Christian.Koenig@amd.com&gt;; Deucher, Alexander &lt;Alexander.Deucher@am=
d.com&gt;; Khatri, Sunil &lt;Sunil.Khatri@amd.com&gt;; Sharma, Shashank &lt=
;Shashank.Sharma@amd.com&gt;<br>
<b>Cc:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Subject:</b> Re: [PATCH 2/2 v2] drm/amdgpu: Add fw minimum version check=
 for usermode queue</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Alex,<br>
This is v2 of 2/2 patch. Please review this.<br>
<br>
~arvind<br>
<br>
On 4/10/2025 8:27 PM, Arvind Yadav wrote:<br>
&gt; This patch is load usermode queue based on FW support for gfx12.<br>
&gt; CP Ucode FW Vesion: [PFP =3D 2840, ME =3D 2780, MEC =3D 3050, MES =3D =
123]<br>
&gt;<br>
&gt; v2: Addressed review comments from Alex<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; - Just check the firmware versions directly.<b=
r>
&gt;<br>
&gt; Cc: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
&gt; Cc: Christian Koenig &lt;christian.koenig@amd.com&gt;<br>
&gt; Cc: Shashank Sharma &lt;shashank.sharma@amd.com&gt;<br>
&gt; Cc: Sunil Khatri &lt;sunil.khatri@amd.com&gt;<br>
&gt; Signed-off-by: Arvind Yadav &lt;Arvind.Yadav@amd.com&gt;<br>
&gt; ---<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 5 ++++-<br>
&gt;&nbsp;&nbsp; 1 file changed, 4 insertions(+), 1 deletion(-)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/=
amd/amdgpu/gfx_v12_0.c<br>
&gt; index 3d87e445270e..3165fdfeca6a 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c<br>
&gt; @@ -1418,7 +1418,10 @@ static int gfx_v12_0_sw_init(struct amdgpu_ip_b=
lock *ip_block)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(12, 0, 1):<b=
r>
&gt;&nbsp;&nbsp; #ifdef CONFIG_DRM_AMDGPU_NAVI3X_USERQ<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; /* add firmware version checks here */<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (0) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (adev-&gt;gfx.me_fw_version&nbsp; &gt;=3D 2780 &amp;&amp;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.pfp_fw_version &gt;=3D 2840 &amp;&=
amp;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.mec_fw_version &gt;=3D 3050 &amp;&=
amp;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;mes.fw_version[0] &gt;=3D 123) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&g=
t;userq_funcs[AMDGPU_HW_IP_GFX] =3D &amp;userq_mes_funcs;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&g=
t;userq_funcs[AMDGPU_HW_IP_COMPUTE] =3D &amp;userq_mes_funcs;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; }<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BL1PR12MB51446C91686B8D6B3E3F7A0FF7B62BL1PR12MB5144namp_--
