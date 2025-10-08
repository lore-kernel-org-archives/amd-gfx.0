Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F4A7CCA470
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Oct 2025 20:30:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 055A710E210;
	Wed,  8 Oct 2025 20:30:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Qdi0JtMJ";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011022.outbound.protection.outlook.com [40.107.208.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A706710E210
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Oct 2025 20:30:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PDOuqEvCc/29gu1AN8tVa3QGYq3K3E6OZuDs8juJyY9/h3jwZXg5O1KqzzFLAA71zeYeyrUNOeWBtgj3PXLI5ulxX8CztA+mAbF7klFhsw/rPry06xWfLBGS5gUhvPGnwS3629R2ixIDuTkYvQhGBxjXBhqTgdilztDM5zhKhdPaWHL8F3OPjNAZUcbQsQ/9KmPAEbuh8YOq7YQWPLBlwpSF39PhYOQjdfQwPkPkcGn4/Sot+2ZUFk8I61rv3TkBHCQKtu1E0Q/hTVWSVBxHa8xl5kQHxeySkymltdZohtlulaOx9DQh7TrzMCO/CzXmuRp9pVFxwo2NaS4WFF9uWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f5DXoRG0HZNR4mdbg6orcPr3oMVn+FWTCfz6CkFDbZY=;
 b=BYZGx6BV0lgXuWr7xh6siGd/UD94JJVxE+hXiI4/pgVqnZsRRwj5BaUdn1qjfVB/ZlFZrmQeKpeyzcTyJQ6PC66a40K8UUYqzParxo9ytCUq7FxMgpDZhOaXZgrnnT7e2d52M+UIb3SP99/NoHkXCsOTZ8eh/jrkwEy3W09nYJIRsDR1sbbDCGpC0BY+vIO3mEK1KBSdqso5kt2XoVjIFPB3rQamo6B4AW6ez1MEO1Nx/Clts65YiJ49sTV1GZ2te4ZrdDHeBGARmd5sqDPRhHBd2J9wX0wZNX7fP4ou1pOXNj3iBVU+0Ya/0NjmlfpSDplQI8OstUGjmp31dupkww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f5DXoRG0HZNR4mdbg6orcPr3oMVn+FWTCfz6CkFDbZY=;
 b=Qdi0JtMJY5d+UiXfi7/FMul9ZlZG1FpJVhDsT8VTSd0xiEOceiQBzUADxbhET6mSGEZCd7MkVt9ZOTTX1BjF+v9AxqgSI47qdaqmbjh9VpiNY3l051qV9PJ2mytQnT84aLfgOsl67LzmLcE0sSwBljwPFMzROW/U6e+SMZqtGck=
Received: from CY8PR12MB7435.namprd12.prod.outlook.com (2603:10b6:930:51::6)
 by SJ2PR12MB8875.namprd12.prod.outlook.com (2603:10b6:a03:543::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.9; Wed, 8 Oct
 2025 20:30:41 +0000
Received: from CY8PR12MB7435.namprd12.prod.outlook.com
 ([fe80::234c:7f13:920d:3cc8]) by CY8PR12MB7435.namprd12.prod.outlook.com
 ([fe80::234c:7f13:920d:3cc8%4]) with mapi id 15.20.9182.017; Wed, 8 Oct 2025
 20:30:41 +0000
From: "Kim, Jonathan" <Jonathan.Kim@amd.com>
To: "Liu, Shaoyun" <Shaoyun.Liu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: fix gfx12 mes packet submission status check
Thread-Topic: [PATCH] drm/amdgpu: fix gfx12 mes packet submission status check
Thread-Index: AQHcOHLJRL0QRFecdkyxa3OjtALBLLS4fTmAgAA2TRA=
Date: Wed, 8 Oct 2025 20:30:41 +0000
Message-ID: <CY8PR12MB743535EF2420036360D31C3D85E1A@CY8PR12MB7435.namprd12.prod.outlook.com>
References: <20251008164408.850834-1-jonathan.kim@amd.com>
 <CH0PR12MB5372D9F4DABAD16DEBDBBB0AF4E1A@CH0PR12MB5372.namprd12.prod.outlook.com>
In-Reply-To: <CH0PR12MB5372D9F4DABAD16DEBDBBB0AF4E1A@CH0PR12MB5372.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-10-08T20:30:11.0000000Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7435:EE_|SJ2PR12MB8875:EE_
x-ms-office365-filtering-correlation-id: 826bb511-cda1-4667-c132-08de06a98ccc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|7053199007|38070700021; 
x-microsoft-antispam-message-info: =?us-ascii?Q?1aNKdukDkYvtg7STz56COvu6Jolbbs71kzK9HZWnNlKB9taaZidYNN0m61TQ?=
 =?us-ascii?Q?TtDMQxzEIjvwS+CeggPd1MeXIaU22xBcyXuXfOrPD7/vfmNmDdwS2lTsd8q0?=
 =?us-ascii?Q?2GcwdKs1J3a2na8tqxLpXn9zdpQXy3eRcfTQDIijhgz1Z/+VOMc1Y2JlqcBX?=
 =?us-ascii?Q?4NfMNSAEIparwV61uyb6vMnqrJiuMbIhhPWqoZ8g0GKqhKM0Vef+KATollYf?=
 =?us-ascii?Q?h/w1/aIXBWRp7c4/o3j4FhqkR8ZoO2l0kHR5rmFEXM/zwQIFz3gBnvRwBCB5?=
 =?us-ascii?Q?49UjuQzc2tGdr8DTRgzsrhC4EJaCmSGf/Ni2apBWwAi5A71FntqMfwvUpFu8?=
 =?us-ascii?Q?NXE6MkaENIzPy1Su7hKS92f/7GFC/0zy8ClE+efMFUluwXlmZGjHFC6xkdb8?=
 =?us-ascii?Q?YxyziSNIX47Ftyw4vwYmZMWAaVfogwaGEIr3KY78A3iH53MzOejdRnUMMQ8W?=
 =?us-ascii?Q?huAG2KQiGyyjPFxBKc/ems5Prtin8wvvh3nnhy/N3CZPt5mC4AxgRLpaoGE/?=
 =?us-ascii?Q?lu7EbTdUbwR77msFXAP0hBpSPFrqzYdPBdDCN4nU6uuSTIKdiDqixC/2/3Xx?=
 =?us-ascii?Q?bwUkJyL/xGWEzF3Z3XOCHdPIujHt/UsdOjhHyaj0keKGzjrN7j1PtHDV60Oi?=
 =?us-ascii?Q?p1V7B1oHblPAWqmo/E9Dq4VrkKF3xLXz2QKIkbE5ZQQ0sXZRGzbi/wL1oOnJ?=
 =?us-ascii?Q?mLpYH09v618pwSlxn8sBYpOINw533OtH30FDIjgz8Fw1bwgUyP2Lq0IJ92zf?=
 =?us-ascii?Q?4w27TMvmcU3qEkj+7J0cp+LGErbDZhBpAontcQR2GtFe0TdEO42/PDB6tjtE?=
 =?us-ascii?Q?LLTNWJ8vkt6vbvBSkOhToCEpQUa4335mXmT+D4EvUw2gtwIt/1wHbgL0pnge?=
 =?us-ascii?Q?MMKCaH3tT7QEa8TAZbMzX5MJ8NT/TBHTMPlY8EbwCl/mP+QG9rqhh26lwdN4?=
 =?us-ascii?Q?DC8tiwSDD5OYsmZelJc3QnQImCrYTmz65OmM1vMASGUxyuJ4AqUXTtzrs8jX?=
 =?us-ascii?Q?ox4m0M7YhxIFNnjtIVok9Q60baByTFG1lqf2YGKc5RMCs49ixNP4l9DIiQ9h?=
 =?us-ascii?Q?urCwK9ESjPFT5pdXOy0l02ugidaX51xHD+rlNNjLJgqaJsD3M27bpLiiYxcH?=
 =?us-ascii?Q?pXIwv5GJwv+2Sp4RkvyRZ8s/lqI7jCzypQO3DMShMq6JHsrO0wsWe6v/+Nu8?=
 =?us-ascii?Q?xR/HXTIEy690iM9Gi4akRMZB7ZQphrkU/AZqPCj9n36QVRmRTBLgJgyRk20P?=
 =?us-ascii?Q?9aT/h2/Bvmp3ve0VSV0+u2PuA7pW1DiOOBS6GyT+yD1dT9iI1kUA6y5igadD?=
 =?us-ascii?Q?irS7uJrGsN1wGMTi6jvsrImHI6J9cOI9iqkyAu2IdBNV3+Aj/V1l0S8Mu8fJ?=
 =?us-ascii?Q?hTUC7TN1e19O1MEkzxjPPrjJPFpRw1ZE9tOH8QPRLrur+wjmOYejThFsP0tf?=
 =?us-ascii?Q?dF0yXJ1dfHqk51QPqkiFVPzAVKqfDiCR8As1VZloNUZPjaxkI5y7CdKncc7o?=
 =?us-ascii?Q?CQ5xKXK7ZAdUxf5hcOUF2hqbl+jJN0Cxrqiu?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7435.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?tsBx6IWnL1ohLwJmVCUrxBEf+6QshHud50Zn/MPfpoek0U+cI4GJOP+fWanR?=
 =?us-ascii?Q?gIIVjY4yLmsxheC2aOk9FWeUNmP7nh/l8SovqHwqzU7ByX5rVK7ewTjk8I4N?=
 =?us-ascii?Q?nuJTlcR9lwdgtlGZhMlvOp6qoP4q/+jLju2BHyZ4skEIYRbIlJ2Cl0xa6Ieb?=
 =?us-ascii?Q?v7spGwWYoDEpHZ+H3BJOMFgr9pIAETLgOXWQSvUHzBFH7mAoFrUvrDDV/X/o?=
 =?us-ascii?Q?1ddQF3n/aM9M6+FkovSsvuhMrOku26OZe/WE2XsiqZ0n8BeMIAjYIIxrcEK4?=
 =?us-ascii?Q?ovgBjvylkEUe1b7u1wwFbhBbp8g/jHeVZ8thTK6GxM7wcqr/Uq8cXGTdvKUW?=
 =?us-ascii?Q?DFvSqAFPWmbzBXbcomPeDkpL5/KfYaMU90Rssuz6/k21p8xUX+OKX5Xd8Xat?=
 =?us-ascii?Q?uO0ZrgB5Ra7borSR0G68WQDqNKswFjVNeo+HgZqJB3czI68WljpAf626W8It?=
 =?us-ascii?Q?tKC5o/YshM5AA3yj0srliipPENcMqLplPTpsotRKJQKlxo6X9Wq0zAxa35rx?=
 =?us-ascii?Q?qM1V812jBJEA2B4w/F4ZWjaeEvV94Qd5pGvfR9IDW3VCj6Ass5I8l+UZKfbX?=
 =?us-ascii?Q?1sWHE3mCVoB+BHGE/Z3LMjqwLjPY/oDIaIA6XI0vqMxxvUR5ztIHOg6diulC?=
 =?us-ascii?Q?xzsDAASLePSSEcHqo3TRLmzu1gBzu1aCGVhFxRlpI5RzYbtFB0XJzI+DixXA?=
 =?us-ascii?Q?DY9G69zsAMdROVO6YFlZWIsPJLZdKHJcUbw/OpH2kklSs1iBHtty8aFktJxV?=
 =?us-ascii?Q?bSACLYjWRW4ASMWMqERZssjAUaiMQnL6J25jY9y/xEGPe7JeaqlMChr981z/?=
 =?us-ascii?Q?9ozOeN/PSgQqs2hwA0tH/iIxte95TApk1kIbRCsn++kyR73VlTDve2FUHCtE?=
 =?us-ascii?Q?yQZ0gO2HQymBqSPC6A2g3J3fR9UWImYKDB+2gFM1us55seh+69+2KYIJdK29?=
 =?us-ascii?Q?xJxxQLD45hn4Q6rnoFBFDWZV88GmrpP3ST7EYyHEioU7uwdbpSD4oIbFYB5Z?=
 =?us-ascii?Q?s4ciBGeV+Y7jHQj5q1rkBGDh1ycY6f4h6iL4xNzwCN9QYM/c8aFvM2HN9Zow?=
 =?us-ascii?Q?aPUxJucZj+KVNxXK3x3kIJ+8XA/JFRZL6LBU9VH/jSdHRWSRogdJHFzXg5mj?=
 =?us-ascii?Q?BqVZty2kX5jcG1bmaCXIKMrCaBY+LPEQ8O+6YnuKBlsWMnjaE0gTtqZ1qTqz?=
 =?us-ascii?Q?DoBQPivlAlS+Ulkd3THBQHOn5amRALhzPbzRh9pyy9yQXabo2HE8b1EGpYSC?=
 =?us-ascii?Q?EdGhLESSg2YfcBppHxnTUtUCps+nkMGQibCOSXhHF8xDnhpHkBqY7ZGmaRkn?=
 =?us-ascii?Q?m/SvimKl4tN9CuV511DRaNRw/qUM9kJKVHa+E/JbWUZZnMj214sOxCGhoHhz?=
 =?us-ascii?Q?WPukNt9Kh8Q9xL2qYER97ISFPb32xFTsqzxZlwa6N95v8JjV5vNWMe2KiF+m?=
 =?us-ascii?Q?PB4WtKs9A9lBX/fmlTT3iy27sAxv7V2+l+BNWjDaW/a5/dKwCni/RbSG595b?=
 =?us-ascii?Q?6gkkYc8VE691VC48C9hNuGEV7bnBBQIqPqOUQVXPmQbYtV6gF5hJZ9/ZvLtb?=
 =?us-ascii?Q?KYCt62GXPYqu3Do88X4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7435.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 826bb511-cda1-4667-c132-08de06a98ccc
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2025 20:30:41.4573 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wkGaE6jAAqGcSL3NQMJGBh2KiCemmU70M3HpHJ+5TZycXl90rpChoWixDC1kuzNo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8875
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

[Public]

Based on conversations with Alex, it's probably best to just check the low =
32-bits of status instead.
Will send out v2 shortly.

Jon

> -----Original Message-----
> From: Liu, Shaoyun <Shaoyun.Liu@amd.com>
> Sent: Wednesday, October 8, 2025 1:15 PM
> To: Kim, Jonathan <Jonathan.Kim@amd.com>; amd-gfx@lists.freedesktop.org
> Subject: RE: [PATCH] drm/amdgpu: fix gfx12 mes packet submission status c=
heck
>
> [AMD Official Use Only - AMD Internal Distribution Only]
>
> Looks good to me .
> Reviewed-by : Shaoyun.liu <Shaoyun.liu@amd.com>
>
>
> -----Original Message-----
> From: Kim, Jonathan <Jonathan.Kim@amd.com>
> Sent: Wednesday, October 8, 2025 12:44 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Liu, Shaoyun <Shaoyun.Liu@amd.com>; Kim, Jonathan
> <Jonathan.Kim@amd.com>
> Subject: [PATCH] drm/amdgpu: fix gfx12 mes packet submission status check
>
> The driver currently only checks that the MES packet submission fence did=
 not
> timeout but does not actually check if the fence return status matches th=
e
> expected completion value it passed to MES prior to submission.
>
> For example, this can result in REMOVE_QUEUE requests returning success t=
o the
> driver when the queue actually failed to preempt.
>
> Fix this by having the driver actually compare the completion status valu=
e to the
> expected success value.
>
> Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/mes_v12_0.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
> b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
> index aff06f06aeee..58f61170cf85 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
> @@ -228,8 +228,7 @@ static int
> mes_v12_0_submit_pkt_and_poll_completion(struct amdgpu_mes *mes,
>                         pipe, x_pkt->header.opcode);
>
>         r =3D amdgpu_fence_wait_polling(ring, seq, timeout);
> -       if (r < 1 || !*status_ptr) {
> -
> +       if (r < 1 || *status_ptr !=3D api_status->api_completion_fence_va=
lue) {
>                 if (misc_op_str)
>                         dev_err(adev->dev, "MES(%d) failed to respond to =
msg=3D%s (%s)\n",
>                                 pipe, op_str, misc_op_str);
> --
> 2.34.1
>

