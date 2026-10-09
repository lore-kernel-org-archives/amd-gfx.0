Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6230CA5FED
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Oct 2026 09:15:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4DB4E10FFD0;
	Fri,  9 Oct 2026 09:15:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZSbAMckY";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013020.outbound.protection.outlook.com
 [40.93.201.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5F81610FFD0
 for <amd-gfx@lists.freedesktop.org>; Fri,  9 Oct 2026 09:15:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aZhh7leG/UlZPyVBuNKc76yUAmLpcXS2YjUt9UTu4OesOmybYpIxpGuc5axZkY6kZk+dN/kmcOZFUgr1NpFfNfJPLTOvMkc8QTF9CuV+26qiumGDtJGYFudtym/L2MC5jsN7PignEWcDPfjCq3Kmuz8SN/rl14wnXIBBVw+MfjltRhEYGWzrL9yg57IMp/xpNuPd99evTCF7Guk3huL3YE6anpAVSmQOJe6SE3uU8ThNoKFYk9xYEkesbZgHOuJu9T9BMSOxs8peO+7zuexdBgK3WhLkB08t9PshoMYLMPBcZWq04EvP/OEfveC6lTTwcudoDR75C0N1HnbeJhf+mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DIhjPmr/yaDvEwCbBxTSOQUwI/jx9bLEVdbzORCeEv4=;
 b=dICLx3Yu2zS6uqCWJQbEOV2cWodxxqopZI/YnC70qQ99myRexg7pPIFU29aS7gcs5pquUFU93R92lXpjSzjE8CyzOSnoa3DxWvA16aY7KSKgP/gE/JQd45HHjHNpOif0Ov2Wh/xH4Yuo0exheWVCqIb7UHm23MVtjuXcXXxrHrSWG0grP5+HTHkuweF+ig4t2ZRPVBY9hu3GQp9xm36dhSCN796rwumtgOXmD4JTc86SaIViRE2ohT7EG+gBRG1ySx2arnQKvpg83bzwNK3MRxPUEbctzK7bvjMf2wZKMSxUiACZuw153Isof+7hJeDxO+4r++Kg7C01T4q9QfMimQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DIhjPmr/yaDvEwCbBxTSOQUwI/jx9bLEVdbzORCeEv4=;
 b=ZSbAMckYsHrFETn8EG1K3ByAvv1venZYFQak07qpyaWNs0jHQQMlxvz2o1lBcAWYwadPoVkfvK/eJhGcw9XnPZE5AfglgkGjt+evOzXCjkqS6nkzKU3bbRrzSQqxMnDC9aMWdEW2lKq1bPLoe09oWA7SPkBm7pIaZP7h29hwLHQ=
Received: from CYYPR12MB8729.namprd12.prod.outlook.com (2603:10b6:930:c2::5)
 by SJ2PR12MB9086.namprd12.prod.outlook.com (2603:10b6:a03:55f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Fri, 9 Oct
 2026 09:15:41 +0000
Received: from CYYPR12MB8729.namprd12.prod.outlook.com
 ([fe80::1f0c:463f:a438:d85]) by CYYPR12MB8729.namprd12.prod.outlook.com
 ([fe80::1f0c:463f:a438:d85%2]) with mapi id 15.21.0451.026; Fri, 9 Oct 2026
 09:15:41 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Liu, Xiang(Dean)" <Xiang.Liu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Yang, Stanley"
 <Stanley.Yang@amd.com>, "Chai, Thomas" <YiPeng.Chai@amd.com>
Subject: RE: [PATCH 2/2] drm/amd/ras: use page units in EEPROM status messages
Thread-Topic: [PATCH 2/2] drm/amd/ras: use page units in EEPROM status messages
Thread-Index: AQHdULdYY8Ncc1QdjE6TzeZ1NyF8fLb0+iLQ
Date: Fri, 9 Oct 2026 09:15:41 +0000
Message-ID: <CYYPR12MB87297B77FCBFF8AC5774EC6EB0922@CYYPR12MB8729.namprd12.prod.outlook.com>
References: <20260930083945.1362254-1-xiang.liu@amd.com>
 <20260930083945.1362254-2-xiang.liu@amd.com>
In-Reply-To: <20260930083945.1362254-2-xiang.liu@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-10-09T09:08:43.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CYYPR12MB8729:EE_|SJ2PR12MB9086:EE_
x-ms-office365-filtering-correlation-id: 4901e267-9166-4e99-868e-08df25e5e405
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|22082099003|18002099003|10067099003|4143699003|11063799006|38070700021|56012099006;
x-microsoft-antispam-message-info: EcJ78aan3H55McrImoB/4zETWr8zQgeVWFlx3iDEdnjRkTfP/O2zNu7244O5meYejumDklA8cmKy6mui+k0uA2cKiaewpcx9FLLaF6zUztcIbll4vDJkgQPwsPFSEw5wm92B9wd6ez+0AUGVZFFyCJ44gakqj+2vKD6YQc+sDSqchZH+G0lbC8IsgeorO6PcC3jFnF9MSQvps1M2qlWs8YIHj2bOk5JtIP6qKu62X4tzmC8pPnyKju9PAOI0UXtx7qkj1HqPQD32GrCXROwBOnPH5G33iLjOghyUHgqM0PVG9nkpyZ0sL6qPBow3wzXXTUQeEg79/S2qTbpvm+qu7EXBgeX7JSWojHzdtOg0KzB2WsDam9Dr+Ahkm4Xp4Hm48noax6BWs0Fe/MnG0v1EzVWIWHRV3J36OhZ8H11PV0zGPGsl+Jx5QLgQXuNMWayXmxd0S9g8ZQWrCEMpuLGvm6sfCw6lqQ/QxteKshCoCtqxfmmOu+fIWashxPSPWFxWqp34Esy/SFKasLKpCkyWRy5AiGo6kQrzYuSUtb+08P9S/cagIQK+QdEYOrFJw1CE0K8XfxWHDVDiruklVpHUQ8CoILQh0BKOPZeTuEGVsXMcS51efL7e2vH+uEv+WKOVrMxZsBN/cnHYxhzwbjYOVk2/ohY1/60VkFhJfzKqiSYhOny1RyVY2627gB/IDB2r35HsEqOMnRAeTYq52MEnKsyjVdZB+Gi2FmQe+rdZuWA=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CYYPR12MB8729.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(22082099003)(18002099003)(10067099003)(4143699003)(11063799006)(38070700021)(56012099006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?P0oWXm8WxnGVZNCciXVM+CqZRLSDkdu2I5G1sezE/Bgy7U+f3S2pfEuiH54U?=
 =?us-ascii?Q?JKGE9mn5n+9//MiJMxaj4142NpbtQf0GsvajqaMfsG31C9HlU96JqckuJEQI?=
 =?us-ascii?Q?sSXUO9r0iJciWEKyF83gZH8g72FSNGIFcPYHCyzm1g/9s4aO57R7V3S9hujZ?=
 =?us-ascii?Q?tRs0Nz4ri2DTRFAA95qCnll8aqVONpgSdQOfbksfqUSQ41BfQ1WGu23LUkTg?=
 =?us-ascii?Q?lxgzBTlelNQKO4CgJ0ZMVd4+P6lJpt3cXVi643WKeKkfDUEdsAql+GJRTDMp?=
 =?us-ascii?Q?nedJXweYwwc8nUiSqF3oxh1PhZ+WCfGHlaubvx4iCDFKbQmlRKbO7LG5cHPF?=
 =?us-ascii?Q?JhgyUZEtNb5YlGGLAlQH+rWuWcZIDhKykwumu2XelGyoRa0+Q3t8OSytTTjw?=
 =?us-ascii?Q?Qusw8Dg6a20pswu0c/mJL/hKCsyQ0xJqa5STCpzXOHg9oDRdWmunfbOEkIcd?=
 =?us-ascii?Q?sTtGuGfmJ5tOotkfR1rR0n4z4Sa9yQE7Qf32LceDvaod+oyiEqdIZKpMGX8e?=
 =?us-ascii?Q?nYETvYAp3J41LcUoqlANgBFowTlItDTr911yV05IuVTvcsFiZPAKc3Vtq6wR?=
 =?us-ascii?Q?DdOZSRmrAJbgKz8TJpzRsjXbx21LdnoQ7yGiB1EWqJ9Qz2DX//oe8A4vlRQs?=
 =?us-ascii?Q?O72Hl8d79uc9FHXlA6glsnwpZeWYstd99bDcJW51bmIupziAUmj8767WmPDO?=
 =?us-ascii?Q?UN7qHdjInR4jrUOtCrQkNGGIzaUgOJL1l2FC2xn0XkWwpknkywU8e+2Qaw+A?=
 =?us-ascii?Q?YuxL/fEKPXMVU7puvoEUndRZhVPCsRO6UHiN37RmthSL5dAH2YBCronzY9LS?=
 =?us-ascii?Q?v9xY/c3AtW+hLbtz+Ng4A7fhDrE+MgbuWVgsb+5Nq+VD9rd07QTAABTEoyD9?=
 =?us-ascii?Q?ZLHZZIdoDDAhSy3WA2Gjiy0tJ45CC2NIwxUJcFhjraVa74cyyNS+CYsohs2e?=
 =?us-ascii?Q?dSQ5RtyGx2UtuOTct5jvzQnsfwWqFTCogpvEw8t4irBNT2npUy1VrMvsxLo5?=
 =?us-ascii?Q?WYXPyNz1TXmgjW8cb/603idstwKVpDJZBJmCs/fR68/LDqoqJj5qLPW8FMGd?=
 =?us-ascii?Q?rjTKFUlQoqUjA5AnlewWgU2BgjmCj5mDManKtTJCzhxZz5byy+zmZXIWghHe?=
 =?us-ascii?Q?QFZkUbqoW0K/Gtg7s65dw/zapb7LLKf1dZ40IopRQyco2wUgPshiBE40z8xj?=
 =?us-ascii?Q?gpD8gKFZxtQJH8TLYGnxTOMuB7JW+XEXmIa7Tv0No8TpEJZ1ibBe1Pid7766?=
 =?us-ascii?Q?sVQjmSBBl29TXRUvyQ93z4sy0DH58deJ7LTMC6Q8Jq7dGILtQlhKMPNeX5pe?=
 =?us-ascii?Q?44qrFBt77sPfRoFHUR1TrISiN8Omoxyr8m6JZr1Mm3Y4nynd2OKVhk4Hjl0W?=
 =?us-ascii?Q?B4k8VR+l4LlUjIa81Fo5tT3b8MDeQr4jx/r6jhQ89QuTF7A21gu3/SbtPi7Z?=
 =?us-ascii?Q?h1euHlwWedngnSsEz++hGqpUd7m9gppD2eOFuk45wruH22YHhREh87nsU7x0?=
 =?us-ascii?Q?8bOi7ChmQsphUt/jyDcgw6U7372jLcnE0JBk8kvpmHwMwMzywuadXuij79a5?=
 =?us-ascii?Q?L4bOe8uVu9jXVnvxvz9p8XSI/EGDEGypYUqiHcgZzimp1wdh0okkMHTleWGd?=
 =?us-ascii?Q?KurgwPnTtz0qC0gjsQb/F9qEp+Dpvwco4U1rMD/kXk93N2ZMCG6j/EmY4VRM?=
 =?us-ascii?Q?km3Uo52rXGS/LhVjFKXmsAJTApWZ2BhXKlLqDudpxNUP7JBw?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8729.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4901e267-9166-4e99-868e-08df25e5e405
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2026 09:15:41.3089 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +0lkYKmRTToBXuA1mrUg2uRyePpgFf5WWaTJskqdTIYUw6pXP1YnR0ZK+ZSrP35K
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9086
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

The series is:

Reviewed-by: Tao Zhou <tao.zhou1@amd.com>

> -----Original Message-----
> From: Liu, Xiang(Dean) <Xiang.Liu@amd.com>
> Sent: Wednesday, September 30, 2026 4:40 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Zhou1, Tao
> <Tao.Zhou1@amd.com>; Yang, Stanley <Stanley.Yang@amd.com>; Chai, Thomas
> <YiPeng.Chai@amd.com>; Liu, Xiang(Dean) <Xiang.Liu@amd.com>
> Subject: [PATCH 2/2] drm/amd/ras: use page units in EEPROM status message=
s
>
> Report the actual bad page count and convert the record threshold to page=
s using
> the per-ASIC row size. Keep threshold decisions in record units.
>
> Signed-off-by: Xiang Liu <xiang.liu@amd.com>
> ---
>  drivers/gpu/drm/amd/ras/core/ras_eeprom_mgr.c | 29 +++++++++++--------
>  1 file changed, 17 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/ras/core/ras_eeprom_mgr.c
> b/drivers/gpu/drm/amd/ras/core/ras_eeprom_mgr.c
> index e90f89be7ebf..6cafda806d19 100644
> --- a/drivers/gpu/drm/amd/ras/core/ras_eeprom_mgr.c
> +++ b/drivers/gpu/drm/amd/ras/core/ras_eeprom_mgr.c
> @@ -260,6 +260,7 @@ int ras_eeprom_mgr_check_and_report_status(struct
> ras_core_context *ras_core, bo  {
>       struct ras_eeprom_mgr *mgr =3D &ras_core->eeprom_mgr;
>       struct ras_eeprom_info info =3D {0};
> +     u32 bad_page_count, bad_page_threshold;
>       int valid_err_count;
>       int ret =3D 0;
>
> @@ -274,25 +275,29 @@ int ras_eeprom_mgr_check_and_report_status(struct
> ras_core_context *ras_core, bo
>               return ret;
>
>       valid_err_count =3D ras_umc_get_saved_eeprom_count(ras_core);
> +     bad_page_count =3D ras_umc_get_badpage_count(ras_core);
> +     bad_page_threshold =3D mgr->ras_err_threshold *
> +ras_core->ras_umc.max_pages_per_row;
>       if (info.eeprom_status =3D=3D RAS_EEPROM_OK) {
>               RAS_DEV_DBG(ras_core->dev,
> -                     "Found existing EEPROM table with %d records\n",
> -                     valid_err_count);
> +                     "Found existing EEPROM table with %u records\n",
> +                     bad_page_count);
>
>               /* Warn if error count reaches or exceeds 90% of the thresh=
old */
>               if (10 * valid_err_count >=3D 9 * mgr->ras_err_threshold)
>                       RAS_DEV_WARN(ras_core->dev,
> -                             "RAS records:%u exceeds 90%% of threshold:%=
d\n",
> -                             valid_err_count, mgr->ras_err_threshold);
> +                             "RAS records:%u exceeds 90%% of threshold:%=
u\n",
> +                             bad_page_count, bad_page_threshold);
>
>       } else if (info.eeprom_status =3D=3D RAS_EEPROM_LOCKED) {
>               if (info.rma_status || valid_err_count > mgr->ras_err_thres=
hold) {
>                       if (info.rma_status)
> -                             RAS_DEV_ERR(ras_core->dev, "RAS records:%d
> exceed error threshold",
> -                                     valid_err_count);
> +                             RAS_DEV_ERR(ras_core->dev,
> +                                         "RAS records:%u exceed error th=
reshold",
> +                                         bad_page_count);
>                       else
> -                             RAS_DEV_ERR(ras_core->dev, "RAS records:%d
> exceed threshold:%d",
> -                                     valid_err_count, mgr->ras_err_thres=
hold);
> +                             RAS_DEV_ERR(ras_core->dev,
> +                                         "RAS records:%u exceed threshol=
d:%u",
> +                                         bad_page_count, bad_page_thresh=
old);
>
>                       if (mgr->work_mode_over_thresh !=3D
> RAS_WORK_MODE_OVER_THRESH_DEBUG)
>                               ras_core->bad_page_over_threshold =3D true;=
 @@ -
> 320,13 +325,13 @@ int ras_eeprom_mgr_check_and_report_status(struct
> ras_core_context *ras_core, bo
>                               ras_core->is_rma =3D false;
>                               ras_core->bad_page_over_threshold =3D false=
;
>                               RAS_DEV_INFO(ras_core->dev,
> -                                     "records:%d threshold:%d, resetting=
 RAS table
> header signature",
> -                                     valid_err_count, mgr->ras_err_thres=
hold);
> +                                     "records:%u threshold:%u, resetting=
 RAS table
> header signature",
> +                                     bad_page_count, bad_page_threshold)=
;
>                       }
>               } else {
>                       RAS_DEV_ERR(ras_core->dev,
> -                             "records:%d threshold:%d, not support to re=
size RAS
> table\n",
> -                             valid_err_count, mgr->ras_err_threshold);
> +                             "records:%u threshold:%u, not support to re=
size RAS
> table\n",
> +                             bad_page_count, bad_page_threshold);
>               }
>       } else {
>               RAS_DEV_ERR(ras_core->dev, "Error ras eeprom status:0x%x\n"=
,
> info.eeprom_status);
> --
> 2.34.1

