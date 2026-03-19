Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43C271075271
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Mar 2026 07:48:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DDCDB10E8C2;
	Thu, 19 Mar 2026 07:47:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zT1a82Zg";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013032.outbound.protection.outlook.com
 [40.93.201.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6D26C10E8BE
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Mar 2026 07:47:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DhjZZR+pUvTY+2yxmrob4v2yE9zyxTFe2fnkzMSrJ8YjkFFmOVobQju49EmX0YPclGFb5yyU38fBhSvF1g9m0wrAIoUCBUZdgrN3reusG+H9k1bsy1uOKGiyuwdOfVq08wSUhoS3rnFGL5uTLX7V0avW/WLmcrliBSZJfiS7lt3/te6idLIED6rQxEcKmXBctQLcPuel6QlCKfh7KcgoPl7VvNhqVtp5x0NgUOgrQm3cdcNUDO7zS+/PfBBEaKYKzOs534bSWRStgQp0SLyt5KteZzPVU83d0vewRTqbszTV4+MeegQGiueDk/OBQ996/3r8zKw4laG28GDaQdBseg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8UdMnt/HboGS0MAzwNWzVjexNXQ2HFZ5OuiRV2vEBKA=;
 b=BPU6V8NpNdvHN09UU4+XAEBUvc1mcM0rbC+q6lszW8R0ugdIGV6/f0f1M+0H4IUOUsHJEsHP3fuca8WKkoG00DPHYEF0cc+CxR4/UqK8KC6hpQ/fr+gH721AQ3sf0tIMGSnUSJBu6umnKKm6CGK81et+S5E3Ys2IK8vkUGRSKyru+vleU8RBp9/QuCJT6cZrJJ88Iotbt//ppoziTmDHIdX7UK90Koe2vGNId7xk+w0R8ZsK8kEVT6nGi3MqOAZjOJ4PVTgRRJXmT7uHL0sla3i+8AQObVP+JpW/0mLD80x50dBuTWI2LcaPfuS5xGPjXNh7wx6Vd57OLInLXZpCzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8UdMnt/HboGS0MAzwNWzVjexNXQ2HFZ5OuiRV2vEBKA=;
 b=zT1a82Zgjo7R7+OxMY9Tfk0jMm+Y5Cm8ioejpDlgkNZLTdj5S8eRrsjNTGngCdGW+obZ7bJcjitJZDuJ67gHrb466+RMxADa328/SoIrQl/vgEAoixs7SZq9ewLaZtYTWlXAllwNnyf58mC+Ef6kz7uxOEIaaI4a390dTOo6btE=
Received: from SJ0PR12MB7082.namprd12.prod.outlook.com (2603:10b6:a03:4ae::12)
 by DM6PR12MB4403.namprd12.prod.outlook.com (2603:10b6:5:2ab::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.10; Thu, 19 Mar
 2026 07:47:51 +0000
Received: from SJ0PR12MB7082.namprd12.prod.outlook.com
 ([fe80::fcf5:4106:dc85:4819]) by SJ0PR12MB7082.namprd12.prod.outlook.com
 ([fe80::fcf5:4106:dc85:4819%5]) with mapi id 15.20.9745.007; Thu, 19 Mar 2026
 07:47:50 +0000
From: "Lazar, Lijo" <Lijo.Lazar@amd.com>
To: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Zhang, Hawking"
 <Hawking.Zhang@amd.com>, "Feng, Kenneth" <Kenneth.Feng@amd.com>
Subject: Re: [PATCH 1/3] drm/amd/pm: add variant func smu_cmn_send_msg() to
 unify msg sending logic
Thread-Topic: [PATCH 1/3] drm/amd/pm: add variant func smu_cmn_send_msg() to
 unify msg sending logic
Thread-Index: AQHct0VyqZvhVAM9RkGgI7r97Rm3d7W1NymAgAAjnACAAB3anw==
Date: Thu, 19 Mar 2026 07:47:50 +0000
Message-ID: <SJ0PR12MB70821C13DE8260DE5CBABA48974FA@SJ0PR12MB7082.namprd12.prod.outlook.com>
References: <20260319020910.2620721-1-kevinyang.wang@amd.com>
 <a5044ebf-d4e3-4363-a211-9b6144c37c29@amd.com>
 <DM6PR12MB2972BD4381815DDFD4C650A0824FA@DM6PR12MB2972.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB2972BD4381815DDFD4C650A0824FA@DM6PR12MB2972.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2026-03-19T07:40:07.1669361Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
x-ms-reactions: allow
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR12MB7082:EE_|DM6PR12MB4403:EE_
x-ms-office365-filtering-correlation-id: 46bbfc25-bbeb-462a-cd8c-08de858bd22d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|8096899003|38070700021|7053199007|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info: viVAtjwg267+iWmE5cNlugKytY7q87pcJLAspySRWAAxT0KIWyFJ11mf7aAMPdGos58NFN9fwPOqTG3+Ha+BtFQZuUxm1oBPvHeyLNc8RkB3SU6WZ2FyE2Df5PejKzlPMChD+Yz6nPvXP1Mr9aZnwJKQ0l4FWZ7H4cDKQFAxj8Qp46bxJ2GjzVr8IFGUMNl1rGn/JLYtczB+plXWaiTwCkEzKiWEidkq99EzJPJ0nvgYm0dDRoPuZ3OCKMnL7Fu+Yf+fqJJIyrQxJAOoZ0/O5o1kRcDaIYwM2q2Zpbt0FLNyKSzdEoZhQnTjzj7ox1VlHMAbN21Gp+4b8VazsWNUBLIk7jQlvhK5ZGKsyHjQX5OvvfEMLlYACngW1+NL078GHq/yg4ekPusoP+6guluemJomARxIaNxkNC7rnLJuYuFk3HTwylsD6Q2JdKylBnlWNKvgH7ITGyaRnRyLr9tZEjCcjBLpoa/JBRMQ7QkbD9BbdF+U28uFvBY6Tdq1w7E4dCJtneMgpd3Ef/EyvDZovOuAj1ua2N88TLsO9nbs1em14OztVz/ppqa+xOfjrzqa64RTJBc09SiXcM/cfiypU9mAj66HX83ycjli9p0aTnlsp173JMyNBCbZlsOkgd85Nt2MpRF3uyk9IaeGU1kP99CNebMTkKg9H37N3AdirxoKltb5GrfZ7Hiob+W85Cw6Vk6sC233xENytgpOm9g47MTNdt25TYsYIiC0ixlvAoCJhBuF8WB1OKpUky2siyZZaA6wfUqsIioIbw3w/5VwqRvusZ6T/trFh1yFX3ZjfX4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB7082.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(8096899003)(38070700021)(7053199007)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?0YSureyanUIMpoGBjK3U4D/q8PS1po8Y58rgVkMU2wvalIE5E6weox2j1Epi?=
 =?us-ascii?Q?LPvlvSrSIa+0BjNRegZDYPqVTQp5SQ6xvsI9k5472DO0pBy4D9lUeTAPqRjj?=
 =?us-ascii?Q?TDKvjbsBVVgcl87nolgfq5a1ke0hUrOyXiz4G/nT8yiq4v+UY1GSpOPEID6k?=
 =?us-ascii?Q?hKwfbdYKs30GKuZv7O/oQqSBU4Ril+NqI3S74YqRhopdNURpHx9aKM9sLCSs?=
 =?us-ascii?Q?MclTkp90YpxGYCjRZo1lEVWPTIySTW94GMiiUtlA5vT5Iac/QDEe+y5gtkB/?=
 =?us-ascii?Q?xmorSy6CbfzvBw7abaJ29TKAAKTk8NStw3Hr9MBHEbCH/DrWsv+LA5Ane1gv?=
 =?us-ascii?Q?NkToZZOnIMziMPBSSbpCeaI0LXDs+eupCb0mDA6Ke/zky5q3tO3WeEkdDKu2?=
 =?us-ascii?Q?EcWvKPD4qNLsgI8+Z2hL8wu4+OaJLU+YLAHrNI4QQKrLTPun7ITDEvwHj6W/?=
 =?us-ascii?Q?2E5UeWBK85HyhRb6WnPm/gSshlSJ9qv1ETROuJHl0m5Ayjh4LI+valuSvrEx?=
 =?us-ascii?Q?bGdlh457mR0/2M1LJQzP1IqKfj5nNRJKOlAo7TEmIAT/TDyguaJiZy/sqgzl?=
 =?us-ascii?Q?81kOe7tQE5Xw4Yxow9vVY9yWDWTu2U/qSvfdvbTkXwGcIGgJCkTRYT8VzXqS?=
 =?us-ascii?Q?5yyfh0LeTi72QoKqKn4lpB176ToiLl89EfebLR3rxKI2+bH7xdUNjyCeGG5u?=
 =?us-ascii?Q?61VpMlH/6+/g26esM+J+2SaC5E00RlpenVkeNx93mxmXXJc9KufQhpPkFZNI?=
 =?us-ascii?Q?yS7wV3hYuCD2FAU8n1dTLS2/jzU1aMU5yvf/hbL1ie6Q+4P9X5rDvqyUfgmB?=
 =?us-ascii?Q?2xM2iUITxua/wCQ147GLcv9kxMAOabCyQHaEYNaawM0zCKq+fLkvAdLTaZWk?=
 =?us-ascii?Q?nu8Lz4O3NEdsWzesHAzkDWHRwIUzNlwjs5vTSj+v+rSwJho6oQwEK7GYCtRD?=
 =?us-ascii?Q?pjp7D816o2w9yenPtNyAV1pf8lpv0MJmDzvjIgf3yClHuFFy97QDRZTZSaEr?=
 =?us-ascii?Q?uLlIEM2PW2/s3KBCWFlWzUIpJDslLXUi5gNBBVk9RAw1JMhDKrtI1H2AZFZt?=
 =?us-ascii?Q?ariVQmXm/gASDne9UxCs6ol3GSA6ZmY3fLKw79pW5fyNryjL+DNRY7e8CBuP?=
 =?us-ascii?Q?7sECpvX5LGZVgHqUfez88gyM0nF71oN7c29xlbYYeIv4xVGNkp1Ic+n7tefy?=
 =?us-ascii?Q?9Krw1o0wvgTstVwZuwhD6Oh4DNv0kGxRYgd/4Mjyw7SMxDg91DcFgpHnmHt7?=
 =?us-ascii?Q?CA++kd/dxvcIwK+B6r/sQM0TaX5g1E52b9OU1TaS0JzsrBOBNGL452fa81+N?=
 =?us-ascii?Q?4ABKPHlSgAQdDDsNGLqhIXt9nCGpiQ6jyk0pFfak2+rfcBrIwHSwRwAx+epf?=
 =?us-ascii?Q?rAmo23t4GEVLSoe2qaSyqhHH5viUW6/GUl8Rci9FeTO5qTuf0FWY2h5isMrf?=
 =?us-ascii?Q?LlPPiTIdQ2XWDsJ2GxmwP8YsEpVhwrp8N13eeHU4AN9mS4aIT12fEItjs1RS?=
 =?us-ascii?Q?z3Hh2MMB2Hdr7eSkWIaba3I53vvWvVkri54TTNS98ik/WvKcEVZUmjA99e6N?=
 =?us-ascii?Q?CU6+yFu87gTor0oeKJSBSKt0rfr9ws2ULLP0xWB5hu0Qrx/aF9o7TlDsNHQ9?=
 =?us-ascii?Q?2r1CtyTxNHbDaP5QUXVq8nBgCRhGJphI32VaevO5ErfaBTFPUe7illtsdKHi?=
 =?us-ascii?Q?ayI6CKiz81M0AKCoYZfJA02w94+J8CFrXcxECVAw4YcEH22o4pED0ra15915?=
 =?us-ascii?Q?n74TXjiWEg=3D=3D?=
Content-Type: multipart/alternative;
 boundary="_000_SJ0PR12MB70821C13DE8260DE5CBABA48974FASJ0PR12MB7082namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB7082.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46bbfc25-bbeb-462a-cd8c-08de858bd22d
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2026 07:47:50.5743 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AK+LDmpVKqDLFIwmITfd5/P6FDWkDrlDNT/z+H81Z1r5lQnf2998cLHLp6GG3WPK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4403
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

--_000_SJ0PR12MB70821C13DE8260DE5CBABA48974FASJ0PR12MB7082namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[Public]

The variadic wrapper assigns different argument meanings based on number of=
 parameters used and the position. It will be hard to read code based on it=
. There is an optional timeout parameter which will need a 5-argument funct=
ion. Just don't want to miss out on that if everyone starts focusing only o=
n cmn helper functions.

Thanks,
Lijo
________________________________
From: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>
Sent: Thursday, March 19, 2026 11:23:06 AM
To: Lazar, Lijo <Lijo.Lazar@amd.com>; amd-gfx@lists.freedesktop.org <amd-gf=
x@lists.freedesktop.org>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Hawking <Hawking=
.Zhang@amd.com>; Feng, Kenneth <Kenneth.Feng@amd.com>
Subject: RE: [PATCH 1/3] drm/amd/pm: add variant func smu_cmn_send_msg() to=
 unify msg sending logic

[AMD Official Use Only - AMD Internal Distribution Only]

This patch simplifies the development flow with a unified interface and red=
uces overhead for developers.
Most developers can implement features without focusing on low-level detail=
s, while complex message sending scenarios can still use the low-level msg =
sending APIs directly.

Btw,
The scattered APIs hurt maintainability, and most developers should focus o=
n business logic rather than low-level details.
Thus, the "cmn" helper is necessary, it only simplifies the common path whi=
le keeping full flexibility for advanced use cases.
We do not have to choose one or the other exclusively.

Best Regards,
Kevin
-----Original Message-----
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Thursday, March 19, 2026 11:46 AM
To: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>; amd-gfx@lists.freedesktop.o=
rg
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Hawking <Hawking=
.Zhang@amd.com>; Feng, Kenneth <Kenneth.Feng@amd.com>
Subject: Re: [PATCH 1/3] drm/amd/pm: add variant func smu_cmn_send_msg() to=
 unify msg sending logic



On 19-Mar-26 7:39 AM, Yang Wang wrote:
> add variant func smu_cmn_send_msg() to unify smu message sending
> logic, and enabling support for newer ASIC interfaces such as SMU v15 and=
 upcoming devices.
> (support multi-param/multi-response, standardize code across all smu
> code layers)
>
> The smu_cmn_send_msg() API will expand to the following prototypes based =
on the number of input parameters.
> e.g:
> 1. r =3D smu_cmn_send_msg(smu, msg_id);
> 2. r =3D smu_cmn_send_msg(smu, msg_id, &read_arg); 3. r =3D
> smu_cmn_send_msg(smu, msg_id, param, &read_arg); 4. r =3D
> smu_cmn_send_msg(smu, msg_id,
>                       num_param, [param0, param1, ...],
>                       num_response, [arg0, arg1, ...]
>

The intent behind message control is to make the message protocol transpare=
nt to IP versions and specific IP versions to have more control over them -=
 if they need to override a message mechanisms, add specific timeouts to pa=
rticular messages etc. Overall, they are expected to move away from using '=
cmn' and directly use message control operations. That also avoids redundan=
t memory copies of in/out arguments.

Thanks,
Lijo

> Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
> ---
>   drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c | 79 ++++++++++++++++++++++++++
>   drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h | 22 +++++++
>   2 files changed, 101 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> index a644579903f4..bc2ac5ae6a48 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> @@ -193,6 +193,85 @@ int smu_cmn_send_smc_msg(struct smu_context *smu,
>                                              read_arg);
>   }
>
> +static inline int smu_cmn_send_msg_internal(struct smu_context *smu, enu=
m smu_message_type msg,
> +                                         int num_in_args, u32 *in_args,
> +                                         int num_out_args, u32 *out_args=
) {
> +     struct smu_msg_ctl *ctl =3D &smu->msg_ctl;
> +     struct smu_msg_args args =3D { 0 };
> +     int ret;
> +
> +     if (msg >=3D SMU_MSG_MAX_COUNT)
> +             return -EINVAL;
> +
> +     if ((num_in_args >=3D ARRAY_SIZE(args.args) || num_in_args < 0) ||
> +         (num_out_args >=3D ARRAY_SIZE(args.out_args) || num_out_args < =
0))
> +             return -EINVAL;
> +
> +     if ((num_in_args > 0 && !in_args) || (num_out_args > 0 && !out_args=
))
> +             return -EINVAL;
> +
> +     if (!ctl->ops || !ctl->ops->send_msg)
> +             return -EOPNOTSUPP;
> +
> +     args.msg =3D msg;
> +     args.num_args =3D num_in_args;
> +     args.num_out_args =3D num_out_args;
> +     args.flags =3D 0;
> +     args.timeout =3D 0;
> +
> +     if (num_in_args)
> +             memcpy(&args.args[0], in_args, num_in_args * sizeof(u32));
> +
> +     ret =3D ctl->ops->send_msg(ctl, &args);
> +     if (ret)
> +             return ret;
> +
> +     if (num_out_args)
> +             memcpy(out_args, &args.out_args[0], num_out_args * sizeof(u=
32));
> +
> +     return ret;
> +}
> +
> +/*
> + * NOTE: To ensure compatibility with the behavioral logic of the
> +legacy API,
> + * it is required to explicitly set the parameter "param" to 0 when
> +invoking
> + * the msg_0 and msg_1 functions.
> + * */
> +
> +int __smu_cmn_send_msg_0(struct smu_context *smu, enum
> +smu_message_type msg) {
> +     return __smu_cmn_send_msg_2(smu, msg, 0, NULL); }
> +
> +int __smu_cmn_send_msg_1(struct smu_context *smu, enum smu_message_type =
msg,
> +                      u32 *read_arg)
> +{
> +     return __smu_cmn_send_msg_2(smu, msg, 0, read_arg); }
> +
> +int __smu_cmn_send_msg_2(struct smu_context *smu, enum smu_message_type =
msg,
> +                      u32 param, u32 *read_arg)
> +{
> +     int ret;
> +
> +     if (read_arg)
> +             ret =3D smu_cmn_send_msg_internal(smu, msg, 1, &param, 1, r=
ead_arg);
> +     else
> +             ret =3D smu_cmn_send_msg_internal(smu, msg, 1, &param, 0, N=
ULL);
> +
> +     return ret;
> +}
> +
> +int __smu_cmn_send_msg_4(struct smu_context *smu, enum smu_message_type =
msg,
> +                      int num_in_args, u32 *in_args,
> +                      int num_out_args, u32 *out_args)
> +{
> +     return smu_cmn_send_msg_internal(smu, msg,
> +                                      num_in_args, in_args,
> +                                      num_out_args, out_args);
> +}
> +
>   int smu_cmn_send_debug_smc_msg(struct smu_context *smu,
>                        uint32_t msg)
>   {
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
> b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
> index e4d282d8bcae..f48356c22dbb 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
> @@ -209,6 +209,28 @@ int smu_cmn_dpm_pcie_gen_idx(int gen);
>   int smu_cmn_dpm_pcie_width_idx(int width);
>   int smu_cmn_check_fw_version(struct smu_context *smu);
>
> +int __smu_cmn_send_msg_0(struct smu_context *smu, enum
> +smu_message_type msg); int __smu_cmn_send_msg_1(struct smu_context *smu,=
 enum smu_message_type msg,
> +                      u32 *read_arg);
> +int __smu_cmn_send_msg_2(struct smu_context *smu, enum smu_message_type =
msg,
> +                      u32 param, u32 *read_arg);
> +int __smu_cmn_send_msg_4(struct smu_context *smu, enum smu_message_type =
msg,
> +                      int num_in_args, u32 *in_args,
> +                      int num_out_args, u32 *out_args);
> +
> +/*
> +* The smu_cmn_send_msg() API will expand to the following prototypes bas=
ed on the number of input parameters.
> +* e.g:
> +* 1. r =3D smu_cmn_send_msg(smu, msg_id);
> +* 2. r =3D smu_cmn_send_msg(smu, msg_id, &read_arg);
> +* 3. r =3D smu_cmn_send_msg(smu, msg_id, param, &read_arg);
> +* 4. r =3D smu_cmn_send_msg(smu, msg_id,
> +*                      num_param, [param0, param1, ...],
> +*                      num_response, [arg0, arg1, ...]
> +*/
> +#define smu_cmn_send_msg(smu, msg, ...) \
> +     CONCATENATE(__smu_cmn_send_msg_, COUNT_ARGS(__VA_ARGS__))(smu, msg,
> +##__VA_ARGS__)
> +
>   /*SMU gpu metrics */
>
>   /* Attribute ID mapping */


--_000_SJ0PR12MB70821C13DE8260DE5CBABA48974FASJ0PR12MB7082namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
</head>
<body>
<p style=3D"font-family:Calibri;font-size:10pt;color:#008000;margin:5pt;fon=
t-style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[Public]<br>
</p>
<br>
<div>
<div dir=3D"auto" style=3D"font-family: Aptos, Aptos_MSFontService, -apple-=
system, Roboto, Arial, Helvetica, sans-serif; font-size: 12pt; color: rgb(3=
3, 33, 33);">
The variadic wrapper assigns different argument meanings based on number of=
 parameters used and the position. It will be hard to read code based on it=
. There is an optional timeout parameter which will need a 5-argument funct=
ion. Just don't want to miss out
 on that if everyone starts focusing only on cmn helper functions.</div>
<div id=3D"ms-outlook-mobile-body-separator-line" data-applydefaultfontstyl=
es=3D"true" style=3D"font-family: Aptos, Aptos_MSFontService, -apple-system=
, Roboto, Arial, Helvetica, sans-serif; font-size: 12pt;" dir=3D"auto">
<div dir=3D"auto" style=3D"font-family: Aptos, Aptos_MSFontService, -apple-=
system, Roboto, Arial, Helvetica, sans-serif; font-size: 12pt;">
<br>
</div>
</div>
<div style=3D"font-family: Aptos, Aptos_MSFontService, -apple-system, Robot=
o, Arial, Helvetica, sans-serif; font-size: 12pt;" id=3D"ms-outlook-mobile-=
signature" dir=3D"auto">
<div dir=3D"auto" style=3D"font-family: Aptos, Aptos_MSFontService, -apple-=
system, Roboto, Arial, Helvetica, sans-serif; font-size: 12pt;">
Thanks,</div>
<div dir=3D"auto" style=3D"font-family: Aptos, Aptos_MSFontService, -apple-=
system, Roboto, Arial, Helvetica, sans-serif; font-size: 12pt;">
Lijo</div>
</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Wang, Yang(Kevin) &lt=
;KevinYang.Wang@amd.com&gt;<br>
<b>Sent:</b> Thursday, March 19, 2026 11:23:06 AM<br>
<b>To:</b> Lazar, Lijo &lt;Lijo.Lazar@amd.com&gt;; amd-gfx@lists.freedeskto=
p.org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Zhang, Haw=
king &lt;Hawking.Zhang@amd.com&gt;; Feng, Kenneth &lt;Kenneth.Feng@amd.com&=
gt;<br>
<b>Subject:</b> RE: [PATCH 1/3] drm/amd/pm: add variant func smu_cmn_send_m=
sg() to unify msg sending logic</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font face=3D"Times New Roman" size=3D"3"><span=
 style=3D"font-size:12pt;"><a name=3D"BM_BEGIN"></a>
<div><font size=3D"2"><span style=3D"font-size:11pt;">[AMD Official Use Onl=
y - AMD Internal Distribution Only]<br>
<br>
This patch simplifies the development flow with a unified interface and red=
uces overhead for developers.<br>
Most developers can implement features without focusing on low-level detail=
s, while complex message sending scenarios can still use the low-level msg =
sending APIs directly.<br>
<br>
Btw,<br>
The scattered APIs hurt maintainability, and most developers should focus o=
n business logic rather than low-level details.<br>
Thus, the &quot;cmn&quot; helper is necessary, it only simplifies the commo=
n path while keeping full flexibility for advanced use cases.<br>
We do not have to choose one or the other exclusively.<br>
<br>
Best Regards,<br>
Kevin<br>
-----Original Message-----<br>
From: Lazar, Lijo &lt;Lijo.Lazar@amd.com&gt;<br>
Sent: Thursday, March 19, 2026 11:46 AM<br>
To: Wang, Yang(Kevin) &lt;KevinYang.Wang@amd.com&gt;; amd-gfx@lists.freedes=
ktop.org<br>
Cc: Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Zhang, Hawking &l=
t;Hawking.Zhang@amd.com&gt;; Feng, Kenneth &lt;Kenneth.Feng@amd.com&gt;<br>
Subject: Re: [PATCH 1/3] drm/amd/pm: add variant func smu_cmn_send_msg() to=
 unify msg sending logic<br>
<br>
<br>
<br>
On 19-Mar-26 7:39 AM, Yang Wang wrote:<br>
&gt; add variant func smu_cmn_send_msg() to unify smu message sending<br>
&gt; logic, and enabling support for newer ASIC interfaces such as SMU v15 =
and upcoming devices.<br>
&gt; (support multi-param/multi-response, standardize code across all smu<b=
r>
&gt; code layers)<br>
&gt;<br>
&gt; The smu_cmn_send_msg() API will expand to the following prototypes bas=
ed on the number of input parameters.<br>
&gt; e.g:<br>
&gt; 1. r =3D smu_cmn_send_msg(smu, msg_id);<br>
&gt; 2. r =3D smu_cmn_send_msg(smu, msg_id, &amp;read_arg); 3. r =3D<br>
&gt; smu_cmn_send_msg(smu, msg_id, param, &amp;read_arg); 4. r =3D<br>
&gt; smu_cmn_send_msg(smu, msg_id,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; num_param, [p=
aram0, param1, ...],<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; num_response,=
 [arg0, arg1, ...]<br>
&gt;<br>
<br>
The intent behind message control is to make the message protocol transpare=
nt to IP versions and specific IP versions to have more control over them -=
 if they need to override a message mechanisms, add specific timeouts to pa=
rticular messages etc. Overall,
 they are expected to move away from using 'cmn' and directly use message c=
ontrol operations. That also avoids redundant memory copies of in/out argum=
ents.<br>
<br>
Thanks,<br>
Lijo<br>
<br>
&gt; Signed-off-by: Yang Wang &lt;kevinyang.wang@amd.com&gt;<br>
&gt; ---<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c | 79 ++++++++++++++=
++++++++++++<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h | 22 +++++++<br>
&gt;&nbsp;&nbsp; 2 files changed, 101 insertions(+)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c<br>
&gt; b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c<br>
&gt; index a644579903f4..bc2ac5ae6a48 100644<br>
&gt; --- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c<br>
&gt; +++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c<br>
&gt; @@ -193,6 +193,85 @@ int smu_cmn_send_smc_msg(struct smu_context *smu,=
<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; read_arg);<br>
&gt;&nbsp;&nbsp; }<br>
&gt;<br>
&gt; +static inline int smu_cmn_send_msg_internal(struct smu_context *smu, =
enum smu_message_type msg,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; int num_in_args, u32 *in_args,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; int num_out_args, u32 *out_args) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; struct smu_msg_ctl *ctl =3D &amp;smu-&gt;msg=
_ctl;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; struct smu_msg_args args =3D { 0 };<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; int ret;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (msg &gt;=3D SMU_MSG_MAX_COUNT)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; return -EINVAL;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if ((num_in_args &gt;=3D ARRAY_SIZE(args.arg=
s) || num_in_args &lt; 0) ||<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (num_out_args &gt;=
=3D ARRAY_SIZE(args.out_args) || num_out_args &lt; 0))<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; return -EINVAL;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if ((num_in_args &gt; 0 &amp;&amp; !in_args)=
 || (num_out_args &gt; 0 &amp;&amp; !out_args))<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; return -EINVAL;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (!ctl-&gt;ops || !ctl-&gt;ops-&gt;send_ms=
g)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; return -EOPNOTSUPP;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; args.msg =3D msg;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; args.num_args =3D num_in_args;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; args.num_out_args =3D num_out_args;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; args.flags =3D 0;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; args.timeout =3D 0;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (num_in_args)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; memcpy(&amp;args.args[0], in_args, num_in_args * sizeof(u32));<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; ret =3D ctl-&gt;ops-&gt;send_msg(ctl, &amp;a=
rgs);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; return ret;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (num_out_args)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; memcpy(out_args, &amp;args.out_args[0], num_out_args * sizeof(u32));<br=
>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&gt; +}<br>
&gt; +<br>
&gt; +/*<br>
&gt; + * NOTE: To ensure compatibility with the behavioral logic of the<br>
&gt; +legacy API,<br>
&gt; + * it is required to explicitly set the parameter &quot;param&quot; t=
o 0 when<br>
&gt; +invoking<br>
&gt; + * the msg_0 and msg_1 functions.<br>
&gt; + * */<br>
&gt; +<br>
&gt; +int __smu_cmn_send_msg_0(struct smu_context *smu, enum<br>
&gt; +smu_message_type msg) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; return __smu_cmn_send_msg_2(smu, msg, 0, NUL=
L); }<br>
&gt; +<br>
&gt; +int __smu_cmn_send_msg_1(struct smu_context *smu, enum smu_message_ty=
pe msg,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 *read_arg)<br=
>
&gt; +{<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; return __smu_cmn_send_msg_2(smu, msg, 0, rea=
d_arg); }<br>
&gt; +<br>
&gt; +int __smu_cmn_send_msg_2(struct smu_context *smu, enum smu_message_ty=
pe msg,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 param, u32 *r=
ead_arg)<br>
&gt; +{<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; int ret;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (read_arg)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; ret =3D smu_cmn_send_msg_internal(smu, msg, 1, &amp;param, 1, read_arg)=
;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; else<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; ret =3D smu_cmn_send_msg_internal(smu, msg, 1, &amp;param, 0, NULL);<br=
>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&gt; +}<br>
&gt; +<br>
&gt; +int __smu_cmn_send_msg_4(struct smu_context *smu, enum smu_message_ty=
pe msg,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int num_in_args, =
u32 *in_args,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int num_out_args,=
 u32 *out_args)<br>
&gt; +{<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; return smu_cmn_send_msg_internal(smu, msg,<b=
r>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; num_in_args, in_args,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; num_out_args, out_args);<br>
&gt; +}<br>
&gt; +<br>
&gt;&nbsp;&nbsp; int smu_cmn_send_debug_smc_msg(struct smu_context *smu,<br=
>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_=
t msg)<br>
&gt;&nbsp;&nbsp; {<br>
&gt; diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h<br>
&gt; b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h<br>
&gt; index e4d282d8bcae..f48356c22dbb 100644<br>
&gt; --- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h<br>
&gt; +++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h<br>
&gt; @@ -209,6 +209,28 @@ int smu_cmn_dpm_pcie_gen_idx(int gen);<br>
&gt;&nbsp;&nbsp; int smu_cmn_dpm_pcie_width_idx(int width);<br>
&gt;&nbsp;&nbsp; int smu_cmn_check_fw_version(struct smu_context *smu);<br>
&gt;<br>
&gt; +int __smu_cmn_send_msg_0(struct smu_context *smu, enum<br>
&gt; +smu_message_type msg); int __smu_cmn_send_msg_1(struct smu_context *s=
mu, enum smu_message_type msg,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 *read_arg);<b=
r>
&gt; +int __smu_cmn_send_msg_2(struct smu_context *smu, enum smu_message_ty=
pe msg,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 param, u32 *r=
ead_arg);<br>
&gt; +int __smu_cmn_send_msg_4(struct smu_context *smu, enum smu_message_ty=
pe msg,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int num_in_args, =
u32 *in_args,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int num_out_args,=
 u32 *out_args);<br>
&gt; +<br>
&gt; +/*<br>
&gt; +* The smu_cmn_send_msg() API will expand to the following prototypes =
based on the number of input parameters.<br>
&gt; +* e.g:<br>
&gt; +* 1. r =3D smu_cmn_send_msg(smu, msg_id);<br>
&gt; +* 2. r =3D smu_cmn_send_msg(smu, msg_id, &amp;read_arg);<br>
&gt; +* 3. r =3D smu_cmn_send_msg(smu, msg_id, param, &amp;read_arg);<br>
&gt; +* 4. r =3D smu_cmn_send_msg(smu, msg_id,<br>
&gt; +*&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; num_param, [para=
m0, param1, ...],<br>
&gt; +*&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; num_response, [a=
rg0, arg1, ...]<br>
&gt; +*/<br>
&gt; +#define smu_cmn_send_msg(smu, msg, ...) \<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; CONCATENATE(__smu_cmn_send_msg_, COUNT_ARGS(=
__VA_ARGS__))(smu, msg,<br>
&gt; +##__VA_ARGS__)<br>
&gt; +<br>
&gt;&nbsp;&nbsp; /*SMU gpu metrics */<br>
&gt;<br>
&gt;&nbsp;&nbsp; /* Attribute ID mapping */<br>
<br>
</span></font></div>
</span></font></div>
</div>
</body>
</html>

--_000_SJ0PR12MB70821C13DE8260DE5CBABA48974FASJ0PR12MB7082namp_--
