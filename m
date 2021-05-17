Return-Path: <SRS0=Ip1/=KM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B102C433ED
	for <amd-gfx@archiver.kernel.org>; Mon, 17 May 2021 06:51:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 506A160C3D
	for <amd-gfx@archiver.kernel.org>; Mon, 17 May 2021 06:51:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 506A160C3D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E253D6E8CD;
	Mon, 17 May 2021 06:51:40 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2075.outbound.protection.outlook.com [40.107.236.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 31C106E8CD
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 May 2021 06:51:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I+gg6lzEylcO8OgNy2uCKoGQ+wa9XTR8gS8B7io6AejqXNvpRCyG717f6r1jdyiyUB8MjO5QH93f8070whiaCv4Eekorw0pmSHD3EZRhDFy5SkMHBYz7VcXMgDzBRH0SfjM5Lq5j/hzKA0WHQQdWTia2i+iwxKg9hYhZgrlrWh4PDXP3savK2m4hw6gpogNXZ9h3mBhIKVSkqD6jiucuxvrWM6Q+gba2PGgaqHnp2MwlKZcyr330OON+lFgB/+pJSj9uVfqmijeVCgob8mZwSAvqDiRXrJrQkbQHoLP1jKYNUhkzny1ccq3GCz3YCXa63oRcL5R08lHcSstzU3Q4Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ug+L9WfR8Bs50iiAy5BMRsZ5Wa7qmr+BwByUmEda6NY=;
 b=VyraEEPBWaioOyZQeds2nQ7IsNZ4MPaY/2/1XdJR//YCH4JJ76mS/r3MQ4C4xS3w//tAWPiIUOi9oUmdpO5StvS1FFUP3gA5GLMtJo3OB0JSxkzFZv6aHh2stPxSXCQhms5AVzNKdgUQhVwxKt4LORyHNneiBw1rVfzcyiKlw9b5pYSi07VTMSYqxDx00skzBIrQlvehAja6zabQjH0+JfwevscF0MQmoK8PcWVrGI6fs1DqH6jkDg5BSJsWYneBYNKdiaC7o/4/CQIhTm0Y5+gtXMDL2tWWJOV7tV+IsnJwt1Vyne3PzjkEX8FQmj0jyxiE3Q5OXJ2wTLc8Qf5HyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ug+L9WfR8Bs50iiAy5BMRsZ5Wa7qmr+BwByUmEda6NY=;
 b=gnLSGmoyY07XXyqugOxIwUGezZU1uPNRliusM1TuC3Sgv1wswMSXEi0JMFfSabeA+z14/T8rIR1v5a4CJHiqxBrr+T5i2PXfWme4AJ9oX/a2nW2bJ2PmOPX2T3B0BDiyJvdwc1g+OrRkT8no7IBN6AAJOttcscLFawh1Z5n8qIM=
Received: from BY5PR12MB4885.namprd12.prod.outlook.com (2603:10b6:a03:1de::20)
 by BY5PR12MB4887.namprd12.prod.outlook.com (2603:10b6:a03:1c6::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.25; Mon, 17 May
 2021 06:51:36 +0000
Received: from BY5PR12MB4885.namprd12.prod.outlook.com
 ([fe80::19f5:ee37:5c06:900e]) by BY5PR12MB4885.namprd12.prod.outlook.com
 ([fe80::19f5:ee37:5c06:900e%4]) with mapi id 15.20.4129.031; Mon, 17 May 2021
 06:51:36 +0000
From: "Chen, Jiansong (Simon)" <Jiansong.Chen@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: optimize to drop preamble IB for old GPUs
Thread-Topic: [PATCH] drm/amdgpu: optimize to drop preamble IB for old GPUs
Thread-Index: AQHXStauMcp5hdyczE26kG7wgOFEKarnObiAgAABT4A=
Date: Mon, 17 May 2021 06:51:36 +0000
Message-ID: <BY5PR12MB48858069A0EBCDBED03B6052EA2D9@BY5PR12MB4885.namprd12.prod.outlook.com>
References: <20210517043940.99603-1-Jiansong.Chen@amd.com>
 <bc81cba1-b338-3ef3-c488-178768d14637@amd.com>
In-Reply-To: <bc81cba1-b338-3ef3-c488-178768d14637@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=53303297-a818-4d1b-b824-c34039712e11;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD
 Official Use Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-05-17T06:46:23Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.134.244]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8e15b7fe-023a-41f9-35af-08d91900371e
x-ms-traffictypediagnostic: BY5PR12MB4887:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR12MB4887FBCD5795BCA9B97D0EA4EA2D9@BY5PR12MB4887.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bvL5eODcgijeteuk71xfauW59s87c3hrSFN2pmJo0LRM9OZURexcAQhv/5Hd184Samw61ldNYvHripfBVUKPCyNaTZjmEsZx6gCHGbNoh1+txqK/w8fkXR7S7AU/VRCpUKFkfNQA5d2xGP6tqkY17RSAqMzebLvPTKymJB20qghL6V4kkMXDkyCYij9OehMCywy2+jGLE/eNqkeEMJyScAeruwJY1NfwgcCvHhMQeAIUAhqZrztDYY/NwhGl3OQCr4mC2fmWv8BaVa/Ov49KXbyG1ZH+w0Z3wkOiNt+0/PKU6elEOBTq57wcHm0z4zHG9aW5jSwMWAqH1RqFDuC1+/UeAAW/xe5AoPq8bctjG7zJn+d3i2FZrQzyOQ9QD18UF9Wx4PHFDPFaZOc2oZG3TBLwWwsWZEGttaYOS4nKCeNQ5tbKu3Z0vfwyHD3JS/MU2vblt2iZa9ISWITbsMKCY8KIWIAzMuK9ytbjHTdqcy1mqr5v+jUpvF/jzm+mNkBBoKnBr4qJec7R6pl009mGV7V9/gtbjYNbIcTcOtmQ7532YckZXfcXvHyrkXH213D1VKPQgnLW+ghhhkUAgo60jjSj20iG2+FxCJ3msR3E3TI=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB4885.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(376002)(366004)(346002)(39860400002)(136003)(5660300002)(316002)(186003)(122000001)(110136005)(6506007)(86362001)(53546011)(66446008)(52536014)(33656002)(71200400001)(8676002)(83380400001)(76116006)(478600001)(8936002)(55016002)(9686003)(26005)(2906002)(66556008)(64756008)(66476007)(66946007)(7696005)(38100700002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?utf-8?B?R1Jqb0Y0ejl1MGtneGRNYUFvZnZoV1h0cGZQem10Y2lhQnpoYnkrQlA1Tzlk?=
 =?utf-8?B?WnlRZE5aZkRYTlhycWt4TEFYQkdWZG54UGJMbHRmMDhJWkFkQkl6MHJObFIy?=
 =?utf-8?B?b1lkdnM1bmZaaHk1T2k2MnBIbzc5K1JWWlBKMVZYblIyN0ZhQS9lYU5WY1BV?=
 =?utf-8?B?M0VxK2dldmVKeUN4Q1ZrMlRIL0NIdVFzSUEzaUVyNk1MYXlGK09xUEZ6cEN4?=
 =?utf-8?B?bktaTmwzQ1BRU0swaE5PWStXeU9BRk56dGRTdUZWWFpWNXQrVWFYUmErbXlH?=
 =?utf-8?B?ZlhUZHk0WlJiTFlFc0xIWUlWRnhHVDNUaGlkUEpITUd2U0IxM2xjbXB3YnBC?=
 =?utf-8?B?U1d0Tkd4azl0RnhDYVlUQTJRaEV5ZzZJWldkcTBlOVVnTVc4aGRjWlYrV0R6?=
 =?utf-8?B?N0lxdms4OWhWbTVCMHB0UXhJc05SeTMwN3kvTmRtL2tocG44UFI1dCtOSkNv?=
 =?utf-8?B?SE42bUREd1lzODI4cFlVaktJdVV5T2w4TGZvUVJTSjU2cEpmcGtISWRocUJH?=
 =?utf-8?B?cFNJMVlpR00zdDhocG40dVJBK1pYSzlNZVdVYVNHN3BJNzA3akI2QjFjVXFO?=
 =?utf-8?B?aFpZWnBpWm5YaUc3cFl6d2M4RVl6RnEzLzVQQmY2YVFPZTEwZ3FlS3JkNXJ0?=
 =?utf-8?B?UHUxZ1lrUnpzakEwS3FtYVgxWGxneXdjanF5MjJ1eVJDNWpFcGFJMjZOdlhJ?=
 =?utf-8?B?bWFQL3pNSEJjNEYvRWRXZmlUT2tDaldvc3hDNGNPSlpIVGJlMkZsTVdMckw2?=
 =?utf-8?B?QXNxOWdzanJPQlVKWDBLeCtVdE5qR0g2QTluNDJIMDc2ZTJzVWV4OVpUMG1V?=
 =?utf-8?B?Q09NMVl4cWpvb2k5UjhMUHhsWi9IRkVRenBtak9VUUtFZDRTUk4za2duSjh6?=
 =?utf-8?B?QVkvTVpwaSt4SUJjMHZVUHJlWTZQMmRnVUgrT2pjZTExUmF4dHVqWlM0NW9B?=
 =?utf-8?B?WFFabklkVzVKZjlteVNZNzg3VjdIZjBoYkRzbnVQRmFscEVGOHl4RFdRQjlt?=
 =?utf-8?B?dGtiQlFMOHhobmpHRC8rNXlFeG5QMitzcENhL0tSc1prc1RqUjRKdnpyN2hB?=
 =?utf-8?B?R2VEeXN5dklVREhWejJ0aE1xUFAxZmQ2VjRYTVc2OE5nbDRpU0RvU3ljVUtX?=
 =?utf-8?B?ZHJuREtIbHB3WUlwUjhuVUVteEsrLzk0a1ZsNTdkQnBkcjRRajVKZUIxaEQx?=
 =?utf-8?B?UUc2TTd4NlJPT3hLM2xpRVV6VVRQTllOMWJVSlduYXRYUjlmUFJFSjZWOU1m?=
 =?utf-8?B?ck83alJ0RmNUK0lBSVZISm11SXVqM2gvMlVLUWRKM3FLWnl5TVZyUmZ3OGk1?=
 =?utf-8?B?WnlSYnFGbFlaK2t2MUVyWThxMWttOHFSOCs5azNiUTNjL3lwSUNUSUxnazVK?=
 =?utf-8?B?SUVLMGdZL28wYVNQdWl4ckRqdWFvZEc2Zk93TEZyYklPbmczYzBzVmhQZEdw?=
 =?utf-8?B?V0hIN2dLOUtPRWw4aytPaFRSc2ppY0F2VURTekFaL3dkZnZXR2t4R29UeUFL?=
 =?utf-8?B?b2J4bEdpdXJzSG9tTGVaSGx2OElmOWx4clVjTmV3cFo2aHdEaHgxREdOd1dX?=
 =?utf-8?B?YkFOZlZyb3BmKzMyT2tnYWk5RGJYaUJISnlIWFAzOFJxS2hTNmRlNGN2Rkc4?=
 =?utf-8?B?TzJYQy9WVlRZTXVpSUlSUytibWdyM3lRazZhY0FIVzJSTnE1NjA4RkdaaWtO?=
 =?utf-8?B?c1NqdFJRdXhqcGNpWVZTejFSc0pZVE1mRnR0ZFQ5cVpCakorVDdnc2pjdTJO?=
 =?utf-8?Q?SpI9sd9f6x8mbMi60+WVP982wWacAtSrcPPjvXf?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4885.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e15b7fe-023a-41f9-35af-08d91900371e
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 May 2021 06:51:36.3155 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YU2G/0ZhE2WMyUo84eLH3oCxwFdqAjsnY/MG6uvxHzAEFwq0j7qQNudwArSN5fPPQd31a3rpASBHV6WQr6+jIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4887
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]

Doesn't  current solution always enable the optimization in a safe and more clear way?
1. for gfx8/9/10 we use load_ce_ram in context_control to control the optimization.
2. for gfx6/7, we directly drop the preamble ib.

Regards,
Jiansong
-----Original Message-----
From: Koenig, Christian <Christian.Koenig@amd.com>
Sent: Monday, May 17, 2021 2:42 PM
To: Chen, Jiansong (Simon) <Jiansong.Chen@amd.com>; amd-gfx@lists.freedesktop.org
Subject: Re: [PATCH] drm/amdgpu: optimize to drop preamble IB for old GPUs

Well NAK, as discussed checking the global flag is more flexible since it will still enable the preamble drop when gfxoff is disabled.

Christian.

Am 17.05.21 um 06:39 schrieb Jiansong Chen:
> The optimization is safe for old GPUs and can help performance.
>
> Signed-off-by: Jiansong Chen <Jiansong.Chen@amd.com>
> Change-Id: Id3b1250f1fe46dddbe8498894fb97e9753b7cafe
> ---
>   drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c | 6 ++++++
>   drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c | 6 ++++++
>   2 files changed, 12 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
> b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
> index 3a8d52a54873..c915cc439484 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
> @@ -1873,6 +1873,12 @@ static void gfx_v6_0_ring_emit_ib(struct amdgpu_ring *ring,
>               amdgpu_ring_write(ring, 0);
>       }
>
> +     /* drop the CE preamble IB for the same context */
> +     if ((ib->flags & AMDGPU_IB_FLAG_PREAMBLE) &&
> +         !(flags & AMDGPU_HAVE_CTX_SWITCH) &&
> +         !(flags & AMDGPU_PREAMBLE_IB_PRESENT_FIRST))
> +             return;
> +
>       if (ib->flags & AMDGPU_IB_FLAG_CE)
>               header = PACKET3(PACKET3_INDIRECT_BUFFER_CONST, 2);
>       else
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
> b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
> index c35fdd2ef2d4..6d9ccae48024 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
> @@ -2269,6 +2269,12 @@ static void gfx_v7_0_ring_emit_ib_gfx(struct amdgpu_ring *ring,
>               amdgpu_ring_write(ring, 0);
>       }
>
> +     /* drop the CE preamble IB for the same context */
> +     if ((ib->flags & AMDGPU_IB_FLAG_PREAMBLE) &&
> +         !(flags & AMDGPU_HAVE_CTX_SWITCH) &&
> +         !(flags & AMDGPU_PREAMBLE_IB_PRESENT_FIRST))
> +             return;
> +
>       if (ib->flags & AMDGPU_IB_FLAG_CE)
>               header = PACKET3(PACKET3_INDIRECT_BUFFER_CONST, 2);
>       else

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
