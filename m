Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C16ACD5BD0
	for <amd-gfx@archiver.kernel.org>; Thu, 28 May 2026 02:53:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8197710EB8F;
	Thu, 28 May 2026 02:53:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="iuHy32+P";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011057.outbound.protection.outlook.com [52.101.57.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6FFFA10EB8F
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 May 2026 02:53:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LH+ksqEFToTIY52QPJUCvHjWoDWxdBf8wQcST5mDWXpq3NWCS3/f8lAGA5BinK9ZBKo4p7N1dHRAZDYGy3AYTS89ecnF6zeAG48LNcoK1SdNBJJLZvHnZuKK11bTdR+lzXL72p2QS1fV9F7IMQmmhe7Wop31yuPEOJ6NReOMQ7W2NRrWpOoJ87wNnGRtMMKrCJdWU6luEAYVtj3qVlv17sTlK/8gmi6uVb/bYhCJ5fxDXHIYfNH+87TXaRHJ7J5b6nJt/4kAnK7vb/6uK2bbDXHYoQAAcSaOi9kQgF/4yf/G3w62gXzakINeTPzspMhUgnJIOgKdQKQMXQ2WJ4XyBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iIA3FBugBzuH4pukk1bwE0RQbxeDTPTZuTYE7Ab27VU=;
 b=OAdcNmHkMFEO9iA9o3ZZUKaDA0ZS5pXbGR48EGNgB1u7dVPWYL2y3wcXtpbFccHayOY5eylWIljPvwrh3s3ZIVF2lqTLyA1mBFowrJ0bFSmbN0mSkAaZdGGLlRxT+uJ0te1m9p2cCaEEr5UgIZiIjnNKvHG3LyR0/EHZQrc9HKgUYPkPWx/MwsRRY5bqrpdqkVOnuKFQWFqm8FzewearGhPGdnrvoWRzUYi9lb4ajLwWkaTRFf6lzrUhhtCvxbZu7D+yPjLON5+QzlDSbWJBNsOuUwGwvOnkSfe0FKGpRKIe8E0b7oau1JLs+8BxBhTfr9ZrQtTLup7wchlig4oTfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iIA3FBugBzuH4pukk1bwE0RQbxeDTPTZuTYE7Ab27VU=;
 b=iuHy32+PhofLMQN3RqyYH1y0e6g0tv3b9bALYciZ93rauPTTWOAXdFKnpGzb9eUT6eVvdEDbc2iETBmC0K5lRwxe4w/K9hiXMEuA8BgZV88d0gbt/61aDQctpPXWQsnasOzeEC05v1OwAwXq0VtXkSv1eSlDc4HGdJrUFNWtWZ4=
Received: from PH7PR12MB7425.namprd12.prod.outlook.com (2603:10b6:510:200::8)
 by IA0PR12MB8746.namprd12.prod.outlook.com (2603:10b6:208:490::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.11; Thu, 28 May
 2026 02:53:39 +0000
Received: from PH7PR12MB7425.namprd12.prod.outlook.com
 ([fe80::f3a5:abac:97f4:e406]) by PH7PR12MB7425.namprd12.prod.outlook.com
 ([fe80::f3a5:abac:97f4:e406%3]) with mapi id 15.21.0071.011; Thu, 28 May 2026
 02:53:39 +0000
From: "Yang, Stanley" <Stanley.Yang@amd.com>
To: "Chai, Thomas" <YiPeng.Chai@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Zhou1, Tao"
 <Tao.Zhou1@amd.com>, "Li, Candice" <Candice.Li@amd.com>
Subject: RE: [PATCH 1/2] drm/amd/ras: Return RAS TA injection result to
 userspace
Thread-Topic: [PATCH 1/2] drm/amd/ras: Return RAS TA injection result to
 userspace
Thread-Index: AQHc7NXHDI1n3MsamkK+eWGJYqhJI7YhscoAgAENdOA=
Date: Thu, 28 May 2026 02:53:39 +0000
Message-ID: <PH7PR12MB7425CB40EE50B220AA501BCB9A092@PH7PR12MB7425.namprd12.prod.outlook.com>
References: <20260526060602.69082-1-Stanley.Yang@amd.com>
 <BN9PR12MB5306F83C3CCB8F410A273F1EFC082@BN9PR12MB5306.namprd12.prod.outlook.com>
In-Reply-To: <BN9PR12MB5306F83C3CCB8F410A273F1EFC082@BN9PR12MB5306.namprd12.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-05-27T10:38:23.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB7425:EE_|IA0PR12MB8746:EE_
x-ms-office365-filtering-correlation-id: bb15463e-88a1-4ab6-58cf-08debc645200
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|38070700021|6133799003|4143699003|11063799006|56012099006|22082099003|18002099003;
x-microsoft-antispam-message-info: MCTASd+k3TTNpKXnReKaQctUdljVUN35N15p6Hmtt7AZm0cnTHRv0vZN9cEjl3tVLPoIP1sHidIXbEgOCoJtY7G80UW96nS9fAodJnTlEMpsppFekJXTcLLfDKTAQG6k40XMEzq02QUez1S0PJEswvroBw3437MNxVftfy4cBVMeIcP+CaH7fndByMymOw9xFzAMviZlL4b2N1Ti9j5IeJoouRRmLlIhpbrXyWC5cL/89+AD7aVJMUtXgf5U3T9CluOLNv+l27KzH7DO5qTI9tHWx0CYt0zDHHPJfkUSIlFVa1XEFS+thJhGvp+02Ghl+evgXQe7mRH+S/756zuyJyYG6G/Itevx3zxPg1/gnBSqqNhlUFWSU8pBAsNDs17uXcaYtkTmmPa0ClizBomSUH1YIox8wunew92BkOcpHosz/TRuDicRQJOUjvbysQr53SKYAqc5JExF/J5gQTGzzMg5mNPQA56jggJ8F0kp/9fxm2PQSxR1zqlzYsZc8hdyNciKchdaS2tF2SNLZFnd7ueLv5go1roP7P6MqjcudPlkuNPiybmLm2GjlPl3StSWhlTuGn5XZfE3pdUItzsmE7krwzMPbagvtyhJLmmSq3qRoQ/HUGnx+NF37hTDGwm4eUSyMspH6FD/vutLuMHM6FW1NioV8FlXxkcODADodrxope/l0sk9R1oeDVme/bjUbpJLAfyhPK8uPU6c1n41hh1uPNEHIc9xFxAU2ag48+3NMAB8oszHn/CaX21Zc84N
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB7425.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700021)(6133799003)(4143699003)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?oQ49OKzNxiD9/XhfhziTtFFWZ9SkNAt+r475xgJCusBdRBXrUts9XRQmSo4H?=
 =?us-ascii?Q?k8oNa9DKzsdzyIJL1bMcEXYrWHWwCbOEo8gKeSazQwSq0Wni7iLbxrKBN1Hm?=
 =?us-ascii?Q?bpCDaG6fkh6HOm5NYjrdmn1yHdzNnoOSDT7LPUZ2d/kskv3pt/4gKRU8xd3/?=
 =?us-ascii?Q?h9+6hmJioLsCXIuE76UfcEBtwc5Tj4q+H9cISj3TbX27H6EHVWZtltXAZm6Y?=
 =?us-ascii?Q?hCH6pS5XaXXhWapQgV3jdRnqrOghzkWgRFm2WyYuLNTtXy7c/FeCIrqyKvDK?=
 =?us-ascii?Q?dh5fkv++Fm14kmqkagn99fWlDaxgfBbNfFQlSGH1+bGkgdIrjGWmC16pG4oj?=
 =?us-ascii?Q?++V2YahttSVh7qUMo6JZ6rFR3fpjETwLTxLUMLPjZDKr2eg/uwX1qSvCMGIX?=
 =?us-ascii?Q?OP+uloiiSJBzQtNLRjzxtRe4cPpgTrHK5rziqmeaZ1OqUw0oG11O024t+foL?=
 =?us-ascii?Q?6TGLx94GQ/fN1qx+NJocHzgJRi7ui6MJa1lxEsOxHAFvUVUOnD/fjD7M0eka?=
 =?us-ascii?Q?oUbuAFUrr2GE7BMKlwL5/7Werd0WNd7XVWkRrWzx1CaKr7pxrZkVMLKWvjWU?=
 =?us-ascii?Q?s91KicP0kTeQHm3qt3BRZmDdrb29HVY0mkxHsU+yPo9zDITrn89V+8x2YQEG?=
 =?us-ascii?Q?ScB0JupLLJIbpvzGzDQ4BKasE1VU99xZMP+TDxzLPQ5p+VYoAgPfkw/bvYvy?=
 =?us-ascii?Q?TZqdN4yA34ugLAeVA8zA8CGyJ0itgtZbPt5SGU9CaBfZ4L09BDKWMVNCPEOo?=
 =?us-ascii?Q?XTXLeqtt/DebT7phIPZhDQQooKlEI+weDw1PsRWXugf8kcCELAQwPhTFhuLf?=
 =?us-ascii?Q?7LpSxLtogKO618khfLxyVaONZlag7NXWPsMga3ICcaGqkSRBfh8hOY6aZDcv?=
 =?us-ascii?Q?2iMcgvFelnsjd5C3Zd4pNU7U8mFqJ67s2yzay9r3ulbQ/eoY23+Gu7YUsl0w?=
 =?us-ascii?Q?CEaaEvqauV5DgYNxi3ZH23pVF82cBRcZJEljvItdDeYCDLUWlHhOILLoR14j?=
 =?us-ascii?Q?TEycxf5XMfAQIZhaDy6ZqnphSsQsxuxMJ9K/LoXNMB/6x0nVxCiHMWrE02wB?=
 =?us-ascii?Q?HU+iHyKpCQUiu7LdZzNxQRnld4CfVqK+/8qUel7S0dVAG6htTkYma5Rw0BCa?=
 =?us-ascii?Q?mMXwo30Tb58nRbju08s9dz+lnUq5bl5j+yleJgCRlcCZY5I0Ti80j0OrD5cQ?=
 =?us-ascii?Q?xP6uxRgNSglYb1TUYatv6nhvwtrJEHrvtOOD7j7UYy5H56tUnTRri4wS13JX?=
 =?us-ascii?Q?dJBtyLPAtgQ4yVEQmBscTnTYd0N93z1Jd1t9A/iLdEszkxtdI3eMmutfUly5?=
 =?us-ascii?Q?n3DXAVZ62cD7xm/ad20/b7UluWvn6TBNPM/S4fHGh3VLcWKIJxwmxhI21yMl?=
 =?us-ascii?Q?fFkcCC92ooWM3FrpgHYsmwyi7bLd9h/Qm1r7HkF36XGWAtae6w/XTvqxc3s9?=
 =?us-ascii?Q?9p0fcfj25pvTI+jiwrBHQ6HdqrXfZqPgrrJZveoKn5g7isj3aPpoxKT/GUxw?=
 =?us-ascii?Q?VFZSLImzwo+SNTGBpTY+WA9AFVJ0nCRabq7JvaBd3idhI95q1DD0P/ggSczG?=
 =?us-ascii?Q?9WkONTeDnghPG1ZV54iCt05Sg0QBZvruFK77qvVZmdBt601w+oibtkGWwQiM?=
 =?us-ascii?Q?Fb2bQT3G0rlzZfMJfs0dQ25pGZGnKCZWOOYBGl97ACiQMAUYCmf0AFuKwEi3?=
 =?us-ascii?Q?9nWtIMVQ/fR+RUrMbHu9uoJtaSYhbUXN9GPzF9fqC7xE0F4j?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7425.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb15463e-88a1-4ab6-58cf-08debc645200
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2026 02:53:39.1354 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fYRZRg45+2rLJZAZwO+ablPLeiqhsOQWiGlAF4PTQMdQld+I8xwgrUnSCL9Ykp37c9h0K0PySNw5wlGB2HFi+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8746
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

Hi Thomas,

As currently structured, every path in the switch statement-including the d=
efault case-already returns explicitly. This means the end of the function =
is unreachable, and introducing a trailing return could result in dead code=
. In fact, adding such a return might trigger "unreachable code" warnings f=
rom compilers or static analyzers like Smatch or Coverity.

Best regards,
Stanley

> -----Original Message-----
> From: Chai, Thomas <YiPeng.Chai@amd.com>
> Sent: Wednesday, May 27, 2026 6:44 PM
> To: Yang, Stanley <Stanley.Yang@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Zhou1, Tao
> <Tao.Zhou1@amd.com>; Li, Candice <Candice.Li@amd.com>
> Subject: RE: [PATCH 1/2] drm/amd/ras: Return RAS TA injection result to
> userspace
>
> AMD General
>
> The __check_ras_ta_cmd_resp function should have a return statement added
> at the end.
>
> Fixed that the series is:
>
> Reviewed-by: YiPeng Chai <YiPeng.Chai@amd.com>
>
>
> Best Regards,
> Thomas
> -----Original Message-----
> From: Yang, Stanley <Stanley.Yang@amd.com>
> Sent: Tuesday, May 26, 2026 2:06 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Zhou1, Tao
> <Tao.Zhou1@amd.com>; Chai, Thomas <YiPeng.Chai@amd.com>; Li, Candice
> <Candice.Li@amd.com>; Yang, Stanley <Stanley.Yang@amd.com>
> Subject: [PATCH 1/2] drm/amd/ras: Return RAS TA injection result to
> userspace
>
> Return RAS TA injection result to userspace that avoid app continue to lo=
ad
> work once injection failed.
>
> Changed from V1:
>         refactor function __check_ras_ta_cmd_resp return
>         ras ta corresponding error.
>         return res instead of RAS_CMD__SUCCESS in function
>         amdgpu_ras_submit_cmd.
>
> Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
> ---
>  .../gpu/drm/amd/ras/ras_mgr/amdgpu_ras_cmd.c  |  2 +-
>  drivers/gpu/drm/amd/ras/rascore/ras_psp.c     | 21 ++++++++++---------
>  2 files changed, 12 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_cmd.c
> b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_cmd.c
> index c22e53e84207..ff7f9af980d5 100644
> --- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_cmd.c
> +++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_cmd.c
> @@ -288,5 +288,5 @@ int amdgpu_ras_submit_cmd(struct
> ras_core_context *ras_core, struct ras_cmd_ctx
>                 return RAS_CMD__SUCCESS_EXEED_BUFFER;
>         }
>
> -       return RAS_CMD__SUCCESS;
> +       return res;
>  }
> diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_psp.c
> b/drivers/gpu/drm/amd/ras/rascore/ras_psp.c
> index 5d556e2a7000..358f602b167d 100644
> --- a/drivers/gpu/drm/amd/ras/rascore/ras_psp.c
> +++ b/drivers/gpu/drm/amd/ras/rascore/ras_psp.c
> @@ -317,36 +317,37 @@ static int send_psp_cmd(struct ras_core_context
> *ras_core,
>         return ret;
>  }
>
> -static void __check_ras_ta_cmd_resp(struct ras_core_context *ras_core,
> +static int __check_ras_ta_cmd_resp(struct ras_core_context *ras_core,
>                         struct ras_ta_cmd *ras_cmd)  {
> -
>         if (ras_cmd->ras_out_message.flags.err_inject_switch_disable_flag=
) {
>                 RAS_DEV_WARN(ras_core->dev, "ECC switch disabled\n");
>                 ras_cmd->ras_status =3D
> RAS_TA_STATUS__ERROR_RAS_NOT_AVAILABLE;
> -       } else if (ras_cmd->ras_out_message.flags.reg_access_failure_flag=
)
> +       } else if
> + (ras_cmd->ras_out_message.flags.reg_access_failure_flag) {
>                 RAS_DEV_WARN(ras_core->dev, "RAS internal register access
> blocked\n");
> +               ras_cmd->ras_status =3D
> RAS_TA_STATUS__TEE_ERROR_ACCESS_DENIED;
> +       }
>
>         switch (ras_cmd->ras_status) {
> +       case RAS_TA_STATUS__SUCCESS:
> +               return 0;
>         case RAS_TA_STATUS__ERROR_UNSUPPORTED_IP:
>                 RAS_DEV_WARN(ras_core->dev,
>                          "RAS WARNING: cmd failed due to unsupported ip\n=
");
> -               break;
> +               return -EINVAL;
>         case RAS_TA_STATUS__ERROR_UNSUPPORTED_ERROR_INJ:
>                 RAS_DEV_WARN(ras_core->dev,
>                          "RAS WARNING: cmd failed due to unsupported erro=
r
> injection\n");
> -               break;
> -       case RAS_TA_STATUS__SUCCESS:
> -               break;
> +               return -EINVAL;
>         case RAS_TA_STATUS__TEE_ERROR_ACCESS_DENIED:
>                 if (ras_cmd->cmd_id =3D=3D RAS_TA_CMD_ID__TRIGGER_ERROR)
>                         RAS_DEV_WARN(ras_core->dev,
>                                  "RAS WARNING: Inject error to critical r=
egion is not
> allowed\n");
> -               break;
> +               return -EACCES;
>         default:
>                 RAS_DEV_WARN(ras_core->dev,
>                          "RAS WARNING: ras status =3D 0x%X\n", ras_cmd->r=
as_status);
> -               break;
> +               return -EINVAL;
>         }
>  }
>
> @@ -417,7 +418,7 @@ static int send_ras_ta_runtime_cmd(struct
> ras_core_context *ras_core,
>         if (!ras_cmd->ras_status && out && out_size)
>                 memcpy(out, &ras_cmd->ras_out_message, out_size);
>
> -       __check_ras_ta_cmd_resp(ras_core, ras_cmd);
> +       ret =3D __check_ras_ta_cmd_resp(ras_core, ras_cmd);
>
>  unlock:
>         mutex_unlock(&ta_ctx->ta_mutex);
> --
> 2.43.0
>

