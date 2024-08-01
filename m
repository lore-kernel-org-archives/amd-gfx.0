Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 013E1C3DA64
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Aug 2024 06:05:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A3C5210E899;
	Thu,  1 Aug 2024 06:05:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kwcb1kAA";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2055.outbound.protection.outlook.com [40.107.94.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4B4CC10E898
 for <amd-gfx@lists.freedesktop.org>; Thu,  1 Aug 2024 06:05:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vh5lxXhUXe8NJORsf+HtvfUoqf95utvSmB0S+nkNKxLv1T70BWJA2sZzC7RMHixuWUzh0oUGk/SZraKbXpbp3rvbsEZkPMXkCcHVmbHa79BEY3ygnYYmSzyGGn/SO5zQPp5D/vqwQO+ZnTaVSEX4NIeTsdajjKaOvXLfnPX0VyXNz0VkSRWPj9edNu2rvu40TyuVz/Jz56H/hihp6aejzvRpwCyollcTjS9ExRzc86eNj+pBo/wyZONFb55Ev0GA2gROzf+qPvNbxPFI8aW3AFV+FoXvd/6HCCwQ/CyOxuoMzFiHYLp8OfHX9lSC5Pj4nr1G9PPhbE2GaOPIyLnrJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zQmXZgpT+RRtBIyQb+sj05ctoHUzDyVYN71muYWdDhA=;
 b=jcQAe6ilYZAzcs/G7EwWk2cgvOwes8sbaMoCm+t1+zSV2UyBAhWTRXaAuuXf/3GSGIREcQn6hGzH4/WDTC3c4zzfjPP+F+yZdtrFIP7+DfipDlHS64Lgb5rLbCwq3cINhG4Qj77gqmyfS05Be/HmshUVSmg4xViqBIhjggR2JwzxSZkDJdJGSaCwL72yMA5gEmbs5B72VjHAJtG7NPyzPSZbp0AAvYRsxas7BxtrnoB+3NnR7ny95KKMt/EeAkE+OitVnp6C3YBRtpH3k/LiJkaNXE//cvZd7DqzlUprjD/koJtvsN2+adKE3yBdqY2Qap1Ymxj94hIed7elo7lsow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zQmXZgpT+RRtBIyQb+sj05ctoHUzDyVYN71muYWdDhA=;
 b=kwcb1kAAQ2zKYSs5tB1O47Mqyp5YluMHHWAT/gh1sJ1tM3+bas2K03bt/baKMvyh2YJymzBtwA2Y3Fw4K224rl3iHMQdV2cLF6KVeu+DPKJ787UHWu+eR632EwqMIx429cSL5vrrBUn67JIRWBigFHKHglFKtCQfrMa5Tb5GmR0=
Received: from PH7PR12MB8796.namprd12.prod.outlook.com (2603:10b6:510:272::22)
 by CY8PR12MB7413.namprd12.prod.outlook.com (2603:10b6:930:5f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.27; Thu, 1 Aug
 2024 06:05:12 +0000
Received: from PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::910f:c354:ea0d:1fd]) by PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::910f:c354:ea0d:1fd%5]) with mapi id 15.20.7807.026; Thu, 1 Aug 2024
 06:05:12 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Add more types for boot time error reporting
Thread-Topic: [PATCH] drm/amdgpu: Add more types for boot time error reporting
Thread-Index: AQHa49dOsKQIYoU0l022meyvGar4ILIR6dMw
Date: Thu, 1 Aug 2024 06:05:12 +0000
Message-ID: <PH7PR12MB8796CC0B6ACAB979B09A90F4B0B22@PH7PR12MB8796.namprd12.prod.outlook.com>
References: <20240801055436.31616-1-Hawking.Zhang@amd.com>
In-Reply-To: <20240801055436.31616-1-Hawking.Zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=bef205be-728d-4a56-aa9c-9a44e0539571;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-08-01T06:05:05Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB8796:EE_|CY8PR12MB7413:EE_
x-ms-office365-filtering-correlation-id: b8956d61-c206-464b-4e1a-08dcb1efe799
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?ENOQk/hHbKCFngIyPxH266UZRq5h+ObWSG1GrReH3aB+07NVEBhpZf8NWXFc?=
 =?us-ascii?Q?hrD1Mh7H6PwNwAQBglqaUOhla/wBuPgccZbAhUWw7la8GSpC58RbaigcERFM?=
 =?us-ascii?Q?Xd4v/D9q6QAwm3d0SOYve572ONqct6Cvtp+KWNJbAkr6XMyExs2FCkV5MHDh?=
 =?us-ascii?Q?9MWnV19JKy8YhprPLEnEiv9U6+lQodJR8HStlSyIYE6nCmA9f/sCA6Xj8DDo?=
 =?us-ascii?Q?JkB6IBmjFwO499Bhm+QG1BwrAmVD48SP2/Y1jiOREwT/9uLfdnrUPQJvKTiu?=
 =?us-ascii?Q?F2jc/BPM6LfmqYTn6boaQSjL2kj0pG9/ZOucbKQoOlMx09KJWhN/kJulZcX5?=
 =?us-ascii?Q?ce5B/w6Im5kMLB0DsLNSEJ7gWC/c2i/YlELI8rSdwTxcbgzAlF6Hzu6AGX+a?=
 =?us-ascii?Q?+Iw//qn+BzVal2oKCAtwUs6EEmA0oRFkxOjm2smw83NtuMW9NaqQETWJabSg?=
 =?us-ascii?Q?gjLHPGEui03EELMYc/pWSZ565WwxUrnrdKHSzU0B4xu+ogBkq1TWA9VPI/R/?=
 =?us-ascii?Q?eT0Tsq2IDvLm2y6Meoko0lHU3N5SxQZAEqCpt9NH56Wn4cHHTVMaTLt58gxJ?=
 =?us-ascii?Q?hwP17F0SzfYsXDn1U5vH6PV7Vp2R6ESC3s9cAZQmUZvu4ohSQQOqGOOqw8sa?=
 =?us-ascii?Q?3QxRlwEb9Ato61Ix2iwl+3Eayb3H1TQEXRMQOfBjFQbWEcacjFZ983Hmx7Ws?=
 =?us-ascii?Q?/aiXAYdzWLTlpgBQwKkIs+N6ypV9oV4yFPL/MM0D21iIRpUVqlgQ86T2j7vd?=
 =?us-ascii?Q?uywJrrNK824dtGStzxqrBqzWqx/gtw4J+09BwPS4OwheW8CW6I9rI6otsSUw?=
 =?us-ascii?Q?49g1Xu1D2Jf7GfwGJTm0UxGiEDBSgkNFgaG22+LfgwkQ2pg7tcrPlsKUcnOu?=
 =?us-ascii?Q?Z+ddV9xuwNqyuqAMLR2R4U8djEuhaDnfWzNMkxOt+yjKMebldS6MuyoxZNsJ?=
 =?us-ascii?Q?GXgRCnxNwJZq6RzD1NwsyMgL+Vn10QwEwu0CMJHUylkf2iAhOpwxXnFQUGwM?=
 =?us-ascii?Q?BnKiOspbvfjUih6IrVqw/0F0MZDpSagP09GBuyR9YgZE7CABNRGTQGoCxnRn?=
 =?us-ascii?Q?rM7OBUKgrSOYpBnMRe/VzBm9zEU/343oob73S8X5tZ9AMLXxD+Myb+BANOC5?=
 =?us-ascii?Q?HWqeFnNGs4jrIeKOLULmP/+NRF+rksKuzZe/URmC37b3MFcyGBz/RM3s1e4X?=
 =?us-ascii?Q?IiRg0oGmYV3tHFyMdb4g/y9vx2fNkbHiHqwHE2yfVlMyOH98AxO6o0iKDITz?=
 =?us-ascii?Q?UIZk9JvRNwK3bKqdgnIDVHBjEReTzmJMDUWEdWPXbeUr63i6GXNx6YpvB24B?=
 =?us-ascii?Q?7vIypYaLKrDsWA1sOIoBpJHkG0B5XgdgaMrfyAxSgsQcr5FjmU4RdGVr1fvU?=
 =?us-ascii?Q?NTA0Mczkeas41KwSsKezOK6lEGDPh6t1D1+dN7+xD9TT3aPAow=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB8796.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?2Co9L/gipvkQQX2IGx591rMFTtoBHKOby/Bpk5bJHOBLDOsPFSeDUGExP+XY?=
 =?us-ascii?Q?njYfsdv73g/MTuUfhQHxrpNuvA57H+1BER8z5RUBaGakvNtJp0alSe2ek87c?=
 =?us-ascii?Q?F4msoL/cotg9Mg5xtRQVikggemFJ1jH/Vq7tdez12uPKRWEHghXszcThQ5m+?=
 =?us-ascii?Q?PFHadUH4Z5cbYbYnzrOw/fSYVf0tXQlj0p/awTa4yEWdr3ItcXopIbN9HS17?=
 =?us-ascii?Q?+JenOvTsbNLbot1+lVAM3wja87QDI2212E0/WC+nO9FVDETe+sts38/pnQlv?=
 =?us-ascii?Q?7OxGI2LrnrkVO4j2pRjbaGzfke2LRsj6juGc1Qw5eaDjtg5rGVQaBO19igww?=
 =?us-ascii?Q?fAXmeOH3HfDO8p5XzdoDExfnpcr5mCxoxudU4ksNdw/ieeWyYLkHIafyCprP?=
 =?us-ascii?Q?mV54VN/OXX04WhHKvQyG61TsIQVuZtqx86V2sClHlHdO8jG0HGzjeH/UUl8B?=
 =?us-ascii?Q?A0YvGsO4X32vEhX3Z7t07byNHUMp/Ldog6hVFj9ZjJtGRyMxDmN6+JSjZjV4?=
 =?us-ascii?Q?KEOeHVX47MypotZhJjRBYNeN+Ibk2tLMEy3jb/Y0V5itZWoXd5IjcBNSPnP5?=
 =?us-ascii?Q?dEOn+IiKgT/H+bjN0mIOQWLIwm1RxIbj88aSoAmkuCm58sOdEFPjTENKu+XS?=
 =?us-ascii?Q?MBvuHh+XNRXn/YNh3X0JXdZM9T1dmcd8ROgjdHPAxDBn7D0OYQtYuRia8Yqn?=
 =?us-ascii?Q?0TiGkU9e/hFh42fJUBXqsKLUrHT7cigg6hGFT8EyOLjrlUzgoz/Lp/iGAIsJ?=
 =?us-ascii?Q?DDjGKtiVDrqVoQXljsI4FdylZoQxxkNSt3yyRo1eME3sW39NM/hDODCtuF7o?=
 =?us-ascii?Q?EdOCpj6h1xRaTUQq+r1WR+u1qnQyM8lmgM7uaCjYJ4JFufaDWV4QsHRXV71K?=
 =?us-ascii?Q?L3j8C6FFGO71TtjCo1XI8S+C8d/N6+m56Xr7mDThTcRVHqbkhZnWBv5jx+7r?=
 =?us-ascii?Q?6BgAoeQlIe360zvpqjWaFHrsa+WX2/A3f3NzEte54EVvyAyorIeMathYZvT0?=
 =?us-ascii?Q?0G8pAZBDwuQGOS+0Kwb0V2hAiFxpDQbZjlHtWqvxyuCT052mgJpTON8rtrrf?=
 =?us-ascii?Q?esD1dPnsbnTTYz2Mc7P3/slrb+NxtU7aoOV0t5PPq+PdVNhyi8pORcR/A80h?=
 =?us-ascii?Q?IncBOGxw7yCqT6iqJNCoLEMSEZx459uSUhbVrSlOeQo39z/F/01ZAI+uQMai?=
 =?us-ascii?Q?x8MsN4mrP/a5RQtZVyG+zh6OwoGDChtsIaBJ4pxx9F6x7cwNmAESsRgiBM+U?=
 =?us-ascii?Q?9vp/BjB4pg+wEMgTlndIP1TEdcu3U6DTvAz54pMFLbQs3BlHoaAOezJWu4Rz?=
 =?us-ascii?Q?NhZV725QU0FE/K9WLTDUo7NoGUELELb1uA9yZJpxzamsLAaNL5GQAihYDf9E?=
 =?us-ascii?Q?4tH8hb/D9zeOEBta2SK1lZIozsOUZYzP8ypnbgDmu6C/hcRdkbwntpXrnC/j?=
 =?us-ascii?Q?Wq578UcTJkLDn53JLDy0IPixx8HQKP7ZpoM8llgZbjmUai048n0Qll/d7FUn?=
 =?us-ascii?Q?XKDDzYN0YtIgtYt5tWtXUhJfpn1bwgeZ0Du+MIUS4MS2kc5y/hnj4Pl3FGUE?=
 =?us-ascii?Q?bWU5JhEnRsLaPCOc3lA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8796.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8956d61-c206-464b-4e1a-08dcb1efe799
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Aug 2024 06:05:12.0497 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AsEjsXpzUmazuk7VGw/Ye6NzrW5qHCdMABsGeSL6BqA8PGNVhX73BTZEYvMFZdsF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7413
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

Reviewed-by: Tao Zhou <tao.zhou1@amd.com>

> -----Original Message-----
> From: Hawking Zhang <Hawking.Zhang@amd.com>
> Sent: Thursday, August 1, 2024 1:55 PM
> To: amd-gfx@lists.freedesktop.org; Zhou1, Tao <Tao.Zhou1@amd.com>
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>
> Subject: [PATCH] drm/amdgpu: Add more types for boot time error reporting
>
> Data abort exception and unknown errors are supported.
>
> Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 10 ++++++++++
> drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h |  2 ++
>  2 files changed, 12 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index 12ab48f26bd5..7aff6150898b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -4769,6 +4769,16 @@ static void
> amdgpu_ras_boot_time_error_reporting(struct amdgpu_device *adev,
>               dev_info(adev->dev,
>                        "socket: %d, aid: %d, hbm: %d, fw_status: 0x%x, hb=
m
> bist test failed\n",
>                        socket_id, aid_id, hbm_id, fw_status);
> +
> +     if (AMDGPU_RAS_GPU_ERR_DATA_ABORT(boot_error))
> +             dev_info(adev->dev,
> +                      "socket: %d, aid: %d, fw_status: 0x%x, data abort
> exception\n",
> +                      socket_id, aid_id, fw_status);
> +
> +     if (AMDGPU_RAS_GPU_ERR_UNKNOWN(boot_error))
> +             dev_info(adev->dev,
> +                      "socket: %d, aid: %d, fw_status: 0x%x, unknown boo=
t
> time errors\n",
> +                      socket_id, aid_id, fw_status);
>  }
>
>  static bool amdgpu_ras_boot_error_detected(struct amdgpu_device *adev, d=
iff -
> -git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> index 7ddd13d5c06b..0d49b74bfe5e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> @@ -46,6 +46,8 @@ struct amdgpu_iv_entry;
>  #define AMDGPU_RAS_GPU_ERR_SOCKET_ID(x)
>       AMDGPU_GET_REG_FIELD(x, 10, 8)
>  #define AMDGPU_RAS_GPU_ERR_AID_ID(x)
>       AMDGPU_GET_REG_FIELD(x, 12, 11)
>  #define AMDGPU_RAS_GPU_ERR_HBM_ID(x)
>       AMDGPU_GET_REG_FIELD(x, 14, 13)
> +#define AMDGPU_RAS_GPU_ERR_DATA_ABORT(x)
>       AMDGPU_GET_REG_FIELD(x, 29, 29)
> +#define AMDGPU_RAS_GPU_ERR_UNKNOWN(x)
>       AMDGPU_GET_REG_FIELD(x, 30, 30)
>
>  #define AMDGPU_RAS_BOOT_STATUS_POLLING_LIMIT 100
>  #define AMDGPU_RAS_BOOT_STEADY_STATUS                0xBA
> --
> 2.17.1

