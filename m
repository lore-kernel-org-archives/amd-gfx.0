Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5390FE6C60B
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Dec 2024 06:17:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0606A10E8F7;
	Tue,  3 Dec 2024 06:17:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="U7hy4yqD";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2069.outbound.protection.outlook.com [40.107.94.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3504A10E8F7
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Dec 2024 06:17:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FSkxgHjGm6d2xgOx4LydtMlWkUbIUn9+4YZshTLqS6vxtQjaVrbKzzUEEnEXPj80vdaSVN1hz7+VkPTfOTBX2RX5NdMnCWHHL0tfu9845xXO2h8t74w2Lquh2YvTkwesXIU1EfOmSEzUwO7wrveAU7+GfqUjZKFODRgeY3QFO9LgbeHzsLvOhGOzJyMwuMhwMiqW5VEJj7rXUVWUOwDCGDZT6NnJAglIdu4mfFTzcfs+TLD/Y9ip3Pc2XBfW805IPz7XBrlWbrk/Snr0H7N9cEVIhZ1bJNBjJsVJ3Z5ELyaNKk5wx/arcIypCx23O6e4cKAvw9Ma4W+30fgXz+0yOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NoshA5RTnlAkO4BTEDMZli5YvQ0a5Pn4ulIU0UGa1Zg=;
 b=DM/fJ+xhpR8MNtJYhczG4jrLjvRGPVYXeB5YbuZsf52cmvycL7AOc8sGEWLU2RQHX4bzOSuZfXHituzx5QLKCDshI37iMmVxWTav2Lgf6PrXz8zkh85rp+0Le9OvXxzdi+KO6gC2c0cCGEYo/PC4oJzEjpWtjI/C9lXT3dL00zcU8IThmBzAsRgSPXjTl1hMqaArNt80ob7FG/qogMb2rno06qfyekeZrJbr/MdBeRcM91ckEKGoneIuoxTJ5BZmK7GriqPOVxCauappc08LXAvxwhKWN2XwzKB8u/Ma8qatQnnpmxeKauRoPiAKNeG4LcYj2DdmSb8JmxNffGlEAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NoshA5RTnlAkO4BTEDMZli5YvQ0a5Pn4ulIU0UGa1Zg=;
 b=U7hy4yqDIDi//SbPzcjxf9WYzFVroM/HCUm7be/lfe2RhY0rGtiJR2RsDtWqQ4anv/O8m3MO2FbXrN7e/bI63B2ZR1IwmeXaYeZiS3aTGMVzcWkfr1G9USXBWEZxQoY13EOOjyx3TXE9RCfbtq5LSLsdY7x71HxPVwU0+vrPmzg=
Received: from PH7PR12MB8796.namprd12.prod.outlook.com (2603:10b6:510:272::22)
 by DM6PR12MB4467.namprd12.prod.outlook.com (2603:10b6:5:2a8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.19; Tue, 3 Dec
 2024 06:17:15 +0000
Received: from PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::910f:c354:ea0d:1fd]) by PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::910f:c354:ea0d:1fd%4]) with mapi id 15.20.8207.017; Tue, 3 Dec 2024
 06:17:15 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Yang, Stanley"
 <Stanley.Yang@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>
Subject: RE: [PATCH 1/3] drm/amdgpu: move common ACA ipid defines into
 amdgpu_aca.h
Thread-Topic: [PATCH 1/3] drm/amdgpu: move common ACA ipid defines into
 amdgpu_aca.h
Thread-Index: AQHbRJcLkT1PGnXpOEC4duaLkSFZ+7LUDLzQ
Date: Tue, 3 Dec 2024 06:17:15 +0000
Message-ID: <PH7PR12MB87962405F7055669AF24544AB0362@PH7PR12MB8796.namprd12.prod.outlook.com>
References: <20241202084850.1960341-1-kevinyang.wang@amd.com>
In-Reply-To: <20241202084850.1960341-1-kevinyang.wang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=e2fc633b-8131-4683-ad05-64517bdcd5fa;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-12-03T06:16:58Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB8796:EE_|DM6PR12MB4467:EE_
x-ms-office365-filtering-correlation-id: 9da293ab-f6ad-4f17-7496-08dd136221c3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?0MQ3m96wu0shCiJFTu3CVMtYy1u9pnbVsIho4X9UMFEtHT0OMHpRWCvbKYyP?=
 =?us-ascii?Q?7Z+bZ2sEJBwSAhJXrP14LJ8b/Sj2GBLrrXjZbBGOX1OP5w7LAy3ACNis5G54?=
 =?us-ascii?Q?nP/Y/LoD2h5jj0VyBCtPdEDGNVVgHDqHTu7VYARXK3RIpZ/AaastsF7pWEQ9?=
 =?us-ascii?Q?T3JQ8flFgLJynywGukTUPsU72071jkJvf3QhL8tY8AAoDgBTgIEG1YUTgHHp?=
 =?us-ascii?Q?ipWkF17rHit6Hc0WBNJptVl9FV7P3Tz7R8ATbXKE6tYRvWmo9dghsnbH3Ber?=
 =?us-ascii?Q?k90TsAeq/XKVBIcMWAMlFcxEDXCUU8Ym6cCVwIASOxbPEkqHAV6++Cw02o9e?=
 =?us-ascii?Q?GfWuhmLrzcbDj2fYkckuMdefF7MxRh8HX+ymIEmbnTTfj75aM4LQL40NPrfM?=
 =?us-ascii?Q?Y7eo2QmKQA2QqpU4Mh3jPhkB/JTHc5o0qh5gxVq+LM8oWpVARsgEhmTmGbQK?=
 =?us-ascii?Q?lmRzUiF2YyQtxyiz5WutNhd0MBQ0dyvHZ+QSU1kGiTmAK+VOkqnNd2E8fbFU?=
 =?us-ascii?Q?ESBVrcM3bJldQVC1k4c0Csl1ua3yuQnAjCPFoIUe8b8ynY/G1vCmEnkKnNyv?=
 =?us-ascii?Q?HzDsvw7PBXP6+ArGFLMgJfQxoGU7C9hN9t4QWZ0SlKoyYibkUFPH1g7uN/mB?=
 =?us-ascii?Q?WhdVfCScg1Ddrnkf7+6o5MgcsU6RaRFQdPXFvQBWgpCbHAxULVBo+DhaqL7Y?=
 =?us-ascii?Q?b1dbqZwdwTwu7s2vdAgLMy1+IiyejBWhct08U60jL450agvlBjH2VS+gWWSg?=
 =?us-ascii?Q?sSzZ9iGXZHuEFEI4y5DVEN4dPmwpo3vcAzMMkMcL6fhNudilFIqAsEfI8CPH?=
 =?us-ascii?Q?O0ITLSze27Gy6ZUwA4+8TSBqY5NPC5IXhxa2/e/UYynXEEQBAgTPCELQ6Eb4?=
 =?us-ascii?Q?HrrsrqGiAhESuAsXqCq65qLgFrurKecPiYTeBozu7pLg6j4P2871CFMDmYMC?=
 =?us-ascii?Q?kWyhXWMYWM2/r2Qcl2CaCrxEZToNNb4DPgeEhM6go84y6M0+EMau9pL7bO1E?=
 =?us-ascii?Q?m/X+J+xJCqVWFgu0bwISJ1ssG3gtH8lYe4fbHfimexMTfFidG7ITefUX/FzD?=
 =?us-ascii?Q?81wRvTw9as3rkdHw0kskWcSYAIomN7oFUXltPDfjiErJh3vc8WpHm6DeZB40?=
 =?us-ascii?Q?kMTVH1TfJwharDH87FMXTLH2gSgC2RDayAl5TSqWo5hfBLB8caqG52/Sq+Vx?=
 =?us-ascii?Q?uVgrYmlMMkvhxv3jBRa06KLRbasKgVZlonvu65VIRMzvWrXgpf9dym+LXIoV?=
 =?us-ascii?Q?d0zUbPpJlNwpZI1lEL4GYj95+xjqRZ2g/AYjZr5hHFBtTHcsJ6R2WYs7H0Z9?=
 =?us-ascii?Q?5DWtUPPSpLXidoBM3x3sO9AWabaiM5dF+aVuOCHRJ0GEOpA7uFuei2POy3kf?=
 =?us-ascii?Q?zIeTPeBVx0MC05NdFNAElVRpldeGZDEdK/pVPW4NfWzfBiaG0Q=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB8796.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?8KA3iepAELKspVRU1xq3I1b1QMAM5A72Mey32dbd/XJ/xh+Gmh/Bt+mNS+N6?=
 =?us-ascii?Q?viPdqibnno+7n3ocJEZ4H6qG3SgYgblj6C2XiWEdksI7Ki0Fv9QHfffrt/dp?=
 =?us-ascii?Q?28cYYpto78pK01cEBUDqg2RilBjnCij91WX7d552FhH/4AMN1hrSbGJBES2g?=
 =?us-ascii?Q?91JxzC9fVo2CestIWDAvr3x5qk30L3KpiklIXbgOtdv+rZgVQofiWXCD5eH9?=
 =?us-ascii?Q?hd2hTh8i12hB8rvwTMLYwTokO89hshD4+w2k2hiOtAH8z6WVGz8KpKkOTar9?=
 =?us-ascii?Q?UXE7PxwIvmLXw0/5NmlBs5Jy6KJtiw0RBhq5SXMvEOMoIvYhWY95/l6+oPvf?=
 =?us-ascii?Q?cKB16up1uHiGEF3MVKFegB6pcpCIOVAnHbyYkIccJfPmXMXRfP0PjerUAOx9?=
 =?us-ascii?Q?PotV9FAKr3Lo3qpeAOZ+ZHMrm9VdD+oxJamOxa5HM0x4Jx4seXZTnVycCo9N?=
 =?us-ascii?Q?4v8NqFeM4a/G/hB1b3NZrkCvKuOnXkVkIzdiYR2jTvyZY0vyflnAcM5o6s+b?=
 =?us-ascii?Q?I8M+KePIsys3j16flK/lTyVeAztNJ8sajZAlluyIFje6KqOjg/YtBsPZXLYr?=
 =?us-ascii?Q?aFgTW+6dYYrwLDUob96etZ9fKIU3a3VLTHevv0WL4/C0bWFzMmYTJyofvipL?=
 =?us-ascii?Q?Hpsq98gRlrY9eqW86P1RF8/16MUwrv+extpKLMb1yHfC5qKFloJ/VzUe9cv7?=
 =?us-ascii?Q?tw8xWE+DYIENjAYTZsHXwB8F2WQcbBA9TkHJ3BxoqbCZXsyEWX69Pf9zmEpN?=
 =?us-ascii?Q?C8JMouQwlaniw36/PJNoz14hnyMir5JQtbo1SeAPAWBd5sBHrSfQxN4OnyJv?=
 =?us-ascii?Q?e+EIRM9mnAbz71axk1HcKT6jT8mvFqhPKT1uKZnxAs6IpUwGpqfDSl1XqK+x?=
 =?us-ascii?Q?FCHvSjD9sk4RYNzx7Gd8wR0DgsGwpaaRxnVZVCpJcT9KHY2vW6ZPb0Sol6zI?=
 =?us-ascii?Q?yQV85RVe0s5bp75Hrt+xJNfXjM3Ze/ESo9WAyNiRVDxDJ632QmYXCNSx7nlb?=
 =?us-ascii?Q?eMyhaHnTuL/iSZcum8Mwtitfd9l2gm+hPRMr5X6+xSO0V/Cuez0FhEZFsLbm?=
 =?us-ascii?Q?dDIVADhdYqFFHGSA80JsiooYqcUQ1/SmCkY8lFlXH2jgzuXi7bk2MYpHT2aA?=
 =?us-ascii?Q?eiq/tNVPRooWWwcRKgaaFyD3Kytj6QP0FFtWl7m3Bh7RNilw/mR2rnnAGsrJ?=
 =?us-ascii?Q?lE0JuU47588/bYSOZWO7XLeojJWIc3wzuc80TqAYrl13GhRVgXeX8gNyeNRN?=
 =?us-ascii?Q?lJCX2MH+UJ0DDJHvsBCh3PnuNI9r01b8D3Td+TNUhpRrm/jGmBEcIqzRrvdK?=
 =?us-ascii?Q?8GVRxet7vA42RxYrOZXAdhoda7GggOoJQCyAQ+rz4n917xa0sgS38e6QbXgB?=
 =?us-ascii?Q?JPxdFabBgy1JLHV2dSNxNsx7iHTuk9sFfTXhKvBF1mHWw/CxnER59C7V+y9O?=
 =?us-ascii?Q?/BAZml/DBAyF/WTaLppoUL1iU7RtGRnd3wnl04x5yKJbH/DNJrvOCAT9Q3oJ?=
 =?us-ascii?Q?fXt+oZtHPJnxekBCbikTGIAlJfcp2E85lVVh/1FYYa7VFhRLGH/yXGUEJ2I6?=
 =?us-ascii?Q?r7CXpKMhk6GRDTeOkY8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8796.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9da293ab-f6ad-4f17-7496-08dd136221c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2024 06:17:15.0521 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GH9Hg8QM9FgJm0QLuxwmPUQ7uqPobafkSYWYXVlDGL+yOaOwpwJdjoDqkBK/2Bxz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4467
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

The series is:

Reviewed-by: Tao Zhou <tao.zhou1@amd.com>

> -----Original Message-----
> From: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>
> Sent: Monday, December 2, 2024 4:49 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Zhou1, Tao
> <Tao.Zhou1@amd.com>; Yang, Stanley <Stanley.Yang@amd.com>; Zhang,
> Hawking <Hawking.Zhang@amd.com>
> Subject: [PATCH 1/3] drm/amdgpu: move common ACA ipid defines into
> amdgpu_aca.h
>
> move common ACA ipid defines into amdgpu_aca.h file.
>
> Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
> Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_aca.h | 5 +++++
> drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 4 ----
> drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c | 1 -
>  3 files changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.h
> index 5ef6b745f222..f3289d289913 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.h
> @@ -71,6 +71,11 @@ struct ras_query_context;
>  #define ACA_ERROR_CE_MASK            BIT_MASK(ACA_ERROR_TYPE_CE)
>  #define ACA_ERROR_DEFERRED_MASK
>       BIT_MASK(ACA_ERROR_TYPE_DEFERRED)
>
> +#define mmSMNAID_AID0_MCA_SMU                0x03b30400      /* SMN AID =
AID0
> */
> +#define mmSMNAID_XCD0_MCA_SMU                0x36430400      /* SMN AID
> XCD0 */
> +#define mmSMNAID_XCD1_MCA_SMU                0x38430400      /* SMN AID
> XCD1 */
> +#define mmSMNXCD_XCD0_MCA_SMU                0x40430400      /* SMN XCD
> XCD0 */
> +
>  enum aca_reg_idx {
>       ACA_REG_IDX_CTL                 =3D 0,
>       ACA_REG_IDX_STATUS              =3D 1,
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> index f23df55d72fd..4e920607a278 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> @@ -52,10 +52,6 @@ MODULE_FIRMWARE("amdgpu/gc_9_4_4_rlc.bin");
>  #define GOLDEN_GB_ADDR_CONFIG 0x2a114042  #define
> CP_HQD_PERSISTENT_STATE_DEFAULT 0xbe05301
>
> -#define mmSMNAID_XCD0_MCA_SMU 0x36430400     /* SMN AID XCD0 */
> -#define mmSMNAID_XCD1_MCA_SMU 0x38430400     /* SMN AID XCD1 */
> -#define mmSMNXCD_XCD0_MCA_SMU 0x40430400     /* SMN XCD XCD0 */
> -
>  #define XCC_REG_RANGE_0_LOW  0x2000     /* XCC gfxdec0 lower Bound */
>  #define XCC_REG_RANGE_0_HIGH 0x3400     /* XCC gfxdec0 upper Bound */
>  #define XCC_REG_RANGE_1_LOW  0xA000     /* XCC gfxdec1 lower Bound */
> diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
> b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
> index b01bb759d0f4..e646e5cef0a2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
> @@ -33,7 +33,6 @@
>
>  #define regVM_L2_CNTL3_DEFAULT       0x80100007
>  #define regVM_L2_CNTL4_DEFAULT       0x000000c1
> -#define mmSMNAID_AID0_MCA_SMU 0x03b30400
>
>  static u64 mmhub_v1_8_get_fb_location(struct amdgpu_device *adev)  {
> --
> 2.34.1

