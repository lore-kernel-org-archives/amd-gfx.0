Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC23DC61DB9
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Aug 2026 01:40:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 434FF10F20B;
	Fri, 28 Aug 2026 01:40:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Src5KJL9";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012041.outbound.protection.outlook.com [52.101.53.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DBAA410F20B
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Aug 2026 01:40:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xLssA4BFIDah5eHfL1FK2X/PS5DD6fvdLsDIK0Dc4TlPVM8SmviTM6ZQ2HnoWkTl4mfjh7L5GvNWtuph5ESF+ZhyxvUQ4JRwW6i5ONAxGvSSr5YnYpnPFnekHSPihIWAyDAU9H2CSt8I8T6b/veHvaY7BaalkAU0/sszfNZsDGx5WIrqIZIhLSpuTwr7bdlKWeQyObVbdBHgFaQ79D52zPKc/L58Qg/SttXYuz5fj1CQObLu3JwL75OPKITvh/eqAjFcDQir+OFyyQSUlB7EG+4fFQMQgMFHSmGRjO3mCJkjlREfHEQ1tehxHWmUI9cgwT+xKRQsIpCARQlAbjYKsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xuBH9FxiC5MjYzqsdNAj0Tzlj6H+Clvqz8wPla8thB0=;
 b=OkDcvAJJGquTGl/iiraZgluxFOJ3ksDr0EJd0QJn9ePHrAJVaHhCdCOUKKJLgzDMUOuwhDKIDnC3++tJMuoqzNRQe5gJ/NpnzXUIxQvhBGjMFh/1RrtOKj82ECt9X2wi78T+V5U66Aj2Cvp59LFl7eg/LeXKt+s8v06cEoHN1qUSs5WR8haQ94kGJKrOf+gBeizU+muzh8zcu4vN+lXLbFsI2PTX0HwEOww+8EG6vAhgsh6u70rhAKtfC9csj02TjVPW+zYM/aZg7/yDWXvx3AL7USJR8Rw+if2twoB2ZOLceQii8Su5YNDHcLDADFs9UwARxMtQKu7Ng3wJBzN9yA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xuBH9FxiC5MjYzqsdNAj0Tzlj6H+Clvqz8wPla8thB0=;
 b=Src5KJL9dqsKS+ARc1QlUc87gTPpKC1Yf+N2nms1DVn7FJmoeLoU7uyg5TwYvBXkNATI/4dytv/yGRcteLQfPN7lHZoj0S9aJ8et+/UrsPTQRXKJa9qQuUhOGDIXI1GOByiBrW4UXmvLf2a3dThXGIi6aovXHEKE438clzhuewA=
Received: from DM4PR12MB5152.namprd12.prod.outlook.com (2603:10b6:5:393::16)
 by MN2PR12MB4471.namprd12.prod.outlook.com (2603:10b6:208:26f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Fri, 28 Aug
 2026 01:40:14 +0000
Received: from DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::8874:ea43:ba4a:e73d]) by DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::8874:ea43:ba4a:e73d%5]) with mapi id 15.21.0360.008; Fri, 28 Aug 2026
 01:40:14 +0000
From: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
To: "Lin, Amber" <Amber.Lin@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Chen, Michael" <Michael.Chen@amd.com>,
 "Liu, Shaoyun" <Shaoyun.Liu@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Update queue reset support version
Thread-Topic: [PATCH] drm/amdgpu: Update queue reset support version
Thread-Index: AQHdNlgyhAXMIy75oUGUa7YhfKBLmLayrhMA
Date: Fri, 28 Aug 2026 01:40:13 +0000
Message-ID: <DM4PR12MB515234AF3D93F1436781EE09E3AC2@DM4PR12MB5152.namprd12.prod.outlook.com>
References: <20260827191322.1295826-1-amber.lin@amd.com>
In-Reply-To: <20260827191322.1295826-1-amber.lin@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-08-28T01:34:35.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5152:EE_|MN2PR12MB4471:EE_
x-ms-office365-filtering-correlation-id: fc946f3a-8c35-4e95-e5d6-08df04a54e59
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|11063799006|10067099003|56012099006|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: QyDdTZjtUPzi145WCwPKgJe+d2927PjGJx7SkXdwr6O8r3LhfBb3c/kKy6BKg5mykho8iGGJkrNJABLVz3+hxrEyOtcNU4s3f2KyW3CCTJpC2eTTu+Ek/B9cG5sCJsUlfWhNG7+21+dsdwSrsl1ef/OYDk0dRmb9hjEqVdQVuZAjjz7cUAt0mTxWNmENXTIoUjHWwg4bmlN0fp9fSLXmliWiP2RWAKjjVyehbt2Myk8TWdA31N2iTkmjP1OAiGITtbUZHpHFc4pWxvErmyeiOQmwX8tvjrn9F0Ez0WnQZ7bgztJ7XPbFiJrBSLRfVyz8X8uMP8p2OWDVICWpYslEW2BncxC+4SfZtznSZZVRNL5K6onyFeHH6iUuJnQDCDY+VvSfq+hteZFN54JRmImdmIkFCBoBWQDbXUWP1+09jhQmCGnkHwM5jKzklN9xN/F/6Bc3GZPNsbvWzvEfdaNLKOAaJrWnKZwTqInUX751YmX2m0I+1XOFbfJhRLiWMyyueoQwjYp3dHAda/bncQHrJUlixtjEC+N5yZ4ceBZEVP5JIrxlBXgJywzGboGqkccCPZB8gOGlcLY+el7jJGbCwgI+/DsCoLs9G1ILcDVB6S07onCF8Cj1TX/7khda8I+dWjuW2jkMEUreRhxnUyRQDyRvK2ubKai/Is3hw3I/vgseSRU7peZISop4tbwTW3msypXVDg5FTyhbXqfsFUpgRt6Rlhdvf/qheoH/gP5kPnU=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5152.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(11063799006)(10067099003)(56012099006)(18002099003)(22082099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?RHB2Ej2on/e7r58pNVcM2BzDmMd+VU64LgDYP65cl6nSL+ykFRcH0/wKBQaW?=
 =?us-ascii?Q?yeoeJiRdOj4cF95t/yrGGISE/Pif9VfFLCNEhkL9xefE+apa6aSmMsZgg8sP?=
 =?us-ascii?Q?4A7ZgX3V0Tlt9i7f2wNPkWKA9Ujsh1D9V/Qabzc+0h8hnppwRsl57fV2QPXT?=
 =?us-ascii?Q?EjjQKelAUcX8HAH7iqMlw2qV/Lbe2tftSXmOHi/W0OGNcEz6ZL3J+yWvp+0e?=
 =?us-ascii?Q?fgco6AxrxgGPw/KtYaTcl60bagxcQX+N8INIcsYsg97jkBIkFj2Q2NKF82pF?=
 =?us-ascii?Q?GokjcC1XalBXDJRt1KIb46gIj9CvWLhX0WEGmF9Dm5vbdMESqIZyVK/2Snm/?=
 =?us-ascii?Q?9g953bs7ogHFGNcaCUfk2EDa3nTfLaTRL1TKHbibknGjYO7XvQoZ+aJCvvVS?=
 =?us-ascii?Q?hvYTe8pEutJmI5enXEAgo6D9G3Ow8YqBCqSOCjII2RikO4t6ykMxetzEZphg?=
 =?us-ascii?Q?u8ILIeGAGW/lCvEu5htWXmXlg45cIT/EIb/ixjN080mhQ/EbjpZUSE45DO2K?=
 =?us-ascii?Q?iRBvsPouzLhNKOh0I63wh9snOcW0T7NmiZTx5IIYEGcl96+80nJiE7hE3C2g?=
 =?us-ascii?Q?P1Ni7VjGUfHryTYyCWilWanEQJASOxTpjv2WMbtmtVjb49fEt5NRQ3pWiqVh?=
 =?us-ascii?Q?vMw9qpYAr6z/QhzAo5Fo6saSsI0vtYy2Ze2UAopBmZR0CvNyChLOEsfoClCP?=
 =?us-ascii?Q?awGpVQzZ+/Q8bCIDsB4lTXOWuy3YvV+4xF37TGTW+HniYAzox+tg0YF58z29?=
 =?us-ascii?Q?EdyGf5dJFo19ufN+VFTOngaxsBInTFlDVOTh/bezgpWlDWcQt9Dz8vpGNAWH?=
 =?us-ascii?Q?uJxTofrdjYFP61TekDNw3tAlPlW+h3n/mxTnO3ifBXg9TM6FRFZXwNaGcLZD?=
 =?us-ascii?Q?NsvSkiWWYa1md16mtLKWPV+YTMSfyUy4TUkDujlWX/9sbkUfRPaou1zFX8Hf?=
 =?us-ascii?Q?7uUEk+VfvxNaWHxJlHn9VCW2zfNbTRWrQDbvp9SDYExVwBFoTpLTyktLxjS+?=
 =?us-ascii?Q?fDJJlFB3yMQDmavRJSRy4HcY4IfO404ZCsjyyAIE9MeF1+bOGkGOf0e4/5pK?=
 =?us-ascii?Q?wEsyw0JrqCqzTcFEG7cRVc/NF8pxX8AsP+A4Ud1KVevfSXw+QSfOfKdWpJu0?=
 =?us-ascii?Q?rYYSUflNE1SLoLuUGy51RxO4yc5+VWevFmD2PN0OIHLs8XCno8LECOlhY/9O?=
 =?us-ascii?Q?Nyjz7J0r71/R6m2DQfWOCQvK9Fqy58bzwCDyv/3ruxoRcYVVef1FYE2kQsmJ?=
 =?us-ascii?Q?P1kqZUXC7rcvw87YI9RgogzVUXOipuJifZphQHU/NaSdW4vk4AxL97gxyc4S?=
 =?us-ascii?Q?OgI5e/6SsYGeTAwt7xnKMJWPJSoPGeDeK+6v5o1Ti1NdZvwQQDrE1rP0WC2M?=
 =?us-ascii?Q?d0lYvcaCZ9JblG6PZxYl4griDYKnsY25DfnT3vRPpNvm+bNZMqT7iX4GPfl4?=
 =?us-ascii?Q?QDCytecv1ENFbN9uZ7Bl7sYEGlT61iBR6fy1sl4TVdnkeZanx2SLi35+AhN+?=
 =?us-ascii?Q?kjTf24HGKj9Kjy8vrPiWb9gyDnO9V9hccRcKv4XbQf15nG5+6lOkBNDq2UvH?=
 =?us-ascii?Q?Q/OcnB6J+7tQnD4pA+bTjcnBsf0+7auiZSeXwaflfDf7MALSyzOo+sQDDxqk?=
 =?us-ascii?Q?/iuhOzJYCIb/Oc+sf80h1EwW0zH5ECeDwzOZw28J/oR1ouM00tdvJExN7SaL?=
 =?us-ascii?Q?YLVn71ddTWgnDXHpyqcCcf1Y9MM34twR/su9yUsYdI8kz9Vx?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5152.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc946f3a-8c35-4e95-e5d6-08df04a54e59
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2026 01:40:14.0212 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6AtTVdfwbgR8Vpb/A23CtzFDG7+ToX5HNRFEcULKb5/3fJj8EoE0wmuTwWSABBOY3XF4y4wxvnKwBtbyyb5Apg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4471
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

AMD General

Reviewed-by: Jesse Zhang <Jesse.Zhang@amd.com>
> -----Original Message-----
> From: Lin, Amber <Amber.Lin@amd.com>
> Sent: Friday, August 28, 2026 3:13 AM
> To: amd-gfx@lists.freedesktop.org; Zhang, Jesse(Jie) <Jesse.Zhang@amd.com=
>;
> Chen, Michael <Michael.Chen@amd.com>; Liu, Shaoyun
> <Shaoyun.Liu@amd.com>
> Cc: Lin, Amber <Amber.Lin@amd.com>
> Subject: [PATCH] drm/amdgpu: Update queue reset support version
>
> Update queue reset required MES version for MES 12.1 to 0x7b since we cha=
nge
> the implementation from detect-and-reset method to per-queue-reset method=
.
>
> Signed-off-by: Amber Lin <amber.lin@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> index e0e38d6bcafc..d88c95a8117c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> @@ -886,7 +886,7 @@ bool
> amdgpu_mes_queue_reset_by_mes_supported(struct amdgpu_device *adev)
>
>       return (ip_maj =3D=3D 11 && mes_sched >=3D 0x8c) ||
>               ((ip_maj =3D=3D 12 && ip_min =3D=3D 0) && mes_sched >=3D 0x=
8d) ||
> -             ((ip_maj =3D=3D 12 && ip_min =3D=3D 1) && mes_sched >=3D 0x=
73);
> +             ((ip_maj =3D=3D 12 && ip_min =3D=3D 1) && mes_sched >=3D 0x=
7b);
>  }
>
>  /* Fix me -- node_id is used to identify the correct MES instances in th=
e future */
> --
> 2.43.0

