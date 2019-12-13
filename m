Return-Path: <SRS0=wwPX=2D=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FORGED_HOTMAIL_RCVD2,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DE5DC341AC
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Dec 2019 20:49:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 411A7246B5
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Dec 2019 20:49:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="YYO0weBz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 411A7246B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=hotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0AA3E6E2EC;
	Fri, 13 Dec 2019 18:21:14 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11olkn2012.outbound.protection.outlook.com [40.92.19.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E0D26EC04
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Dec 2019 18:21:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KIieABH1LzMwNYT5suM8j/LRqysFdexQ8OMLOUFbcPL6GefUiD+72rFAibpdXirct/0BfxLp1+b/2ERogo0qGNxLg0DmvI+mlTY19P0xOztE+yG7yf5aMPpCOaev0HGPnpkNZ4KA7em7NX4BW0i0+rx/8oTTsCD7WY8oI6X3jQG36NGTMn8gBn62h/Cq6YAwfk6Yrtt7DFyi0MuIRlwZcYkT1ug3Op5LFYQmkaGu8qTl1M2243djYa0Duk1Vu2OocfgmUj5njSeN1+0EIgDMe8LeMwsfyvqk44z5YH7xZjHdVPOAsjvo50RPetvchXfrqI3c6vdqEMj/7a5eCHOacQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vhVqhQbB59eIvMfPx6KZKEu3Xbo9xNrTgPAwD56tUxk=;
 b=DEUnxXf0jtYjM6k1+VFGKXv8o0SeLz2yWAvIXyIP1KGYVDFI2DD6YhfMGBZqAriwNw5Y3pVw//ZrvA4BjbboqFl/cX4khG54kvT+MUGVQNia59Zwi7OP8TYBOX/udIP1TMebLxMvYLoPulSOoy01pY+Hfkjk2717oIrMCzqN4f1H1LzRdyKEPLQo2GF3RZIV686iiO59inl7gd6yQvxK9sVmZmOoByus346dJEwalnMMidVX1fcJOtTNEc2LDccC/tmfYYywZua3K6yEajZzjMibi0zJ4ZASvB+97BYLoX1aX5NTgfl0EHd6C1U+mG+Qd8Lq3TkascBflKLKeDKLiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vhVqhQbB59eIvMfPx6KZKEu3Xbo9xNrTgPAwD56tUxk=;
 b=YYO0weBzDgMv0E0BbdPGmQA3dOdHOPidIJGcEx4BWO6DgGUhofQ4EvLQIx9IH4yOqrJjEybPJl5vQVQmtGsxtZfgEDdgWlJQ11tBPPqV0CfmcwkU89lA0vx7574hk0rd7IMBVfLfE+ZSyFF+VTYC9DVYpYFbarRDlHCgHWCZCGiUviWfuLDq34gs/s6vxMjOm1yd/H532HRCtBTLZGKBnxnxVydS6Bx1sIAiS3M5V93pUx+0IU4nZ3/GPpLeMJcoM4DRv8QWkczonDjgl2jBQZDiiwP+NiU3FKaEZHB3/t/kkr/e4Q6p/nCIN/BHaCPc3HPgiFeld0vkzmfNaa5iiA==
Received: from BN8NAM11FT028.eop-nam11.prod.protection.outlook.com
 (10.13.176.60) by BN8NAM11HT010.eop-nam11.prod.protection.outlook.com
 (10.13.177.175) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2538.14; Fri, 13 Dec
 2019 18:21:10 +0000
Received: from DM5PR02MB3178.namprd02.prod.outlook.com (10.13.176.55) by
 BN8NAM11FT028.mail.protection.outlook.com (10.13.176.225) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.14 via Frontend Transport; Fri, 13 Dec 2019 18:21:10 +0000
Received: from DM5PR02MB3178.namprd02.prod.outlook.com
 ([fe80::9cdb:a733:f952:fbc3]) by DM5PR02MB3178.namprd02.prod.outlook.com
 ([fe80::9cdb:a733:f952:fbc3%3]) with mapi id 15.20.2516.018; Fri, 13 Dec 2019
 18:21:10 +0000
From: William Lewis <minutemaidpark@hotmail.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH v2 2/5] drm: Add Reusable task barrier.
Thread-Topic: [PATCH v2 2/5] drm: Add Reusable task barrier.
Thread-Index: AQHVsdX+RfMjrWxDYk6PpUIzEzOhjKe4YIEA
Date: Fri, 13 Dec 2019 18:21:10 +0000
Message-ID: <DM5PR02MB3178BAA83274FF2DCF7ABB2EC8540@DM5PR02MB3178.namprd02.prod.outlook.com>
References: <1576256049-12838-1-git-send-email-andrey.grodzovsky@amd.com>
 <1576256049-12838-2-git-send-email-andrey.grodzovsky@amd.com>
In-Reply-To: <1576256049-12838-2-git-send-email-andrey.grodzovsky@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN4PR0801CA0024.namprd08.prod.outlook.com
 (2603:10b6:803:29::34) To DM5PR02MB3178.namprd02.prod.outlook.com
 (2603:10b6:4:67::10)
x-incomingtopheadermarker: OriginalChecksum:C69661CE6D52C658EC672CC2BCA689835759E17E1E56D266B73BF93667CF5006;
 UpperCasedChecksum:3138CA49249AF6E2C36C85EF37AEAC2668EBD845D7CAB6A2769F64C662B4610C;
 SizeAsReceived:7310; Count:48
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn: [3mnIwOtzQ3tdK6iKKDZ54xcmiw4tsPbm]
x-microsoft-original-message-id: <64f95b36-af1c-d3bc-fdb2-39c7b6e64542@hotmail.com>
x-ms-publictraffictype: Email
x-incomingheadercount: 48
x-eopattributedmessage: 0
x-ms-office365-filtering-correlation-id: 59cc9a7b-8875-4a8f-8723-08d77ff93a47
x-ms-traffictypediagnostic: BN8NAM11HT010:
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nYTBLGBaxCb9aAhj8pvMoN8W7V4Lmw8va6B9phlhi+tBd+nHjRAo48yil0bl8bKxH47ONYT+Ox7WrCTphzeSn6b4nROVNE1mOufj+OLmV8bfk/ITxfKTR7FjXrYePkGBNyeoH1vgxjbs500uH82YxN1/HgM9TFHhZa3uJghoH+zZM+ojMV7Sfax5Ljf2yc2ZQjJVXPiATsdIPayRJ5K0bKmAImo/QCGgb41FeJbmX38=
x-ms-exchange-transport-forked: True
Content-ID: <68ACCEF9F1A97748A6187AC1980CDEEA@namprd02.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: hotmail.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 59cc9a7b-8875-4a8f-8723-08d77ff93a47
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2019 18:21:10.3021 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8NAM11HT010
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

Some typographical error nitpicks inline.

On 12/13/19 10:54 AM, Andrey Grodzovsky wrote:
> It is used to synchronize N threads at a rendevouz point before execution
rendezvous
> of critical code that has to be started by all the threads at approximatly
approximately
> the same time.
>
> v2: Remove mention of reset use case, improve doc.
>
> Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
> ---
>   include/drm/task_barrier.h | 107 +++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 107 insertions(+)
>   create mode 100644 include/drm/task_barrier.h
>
> diff --git a/include/drm/task_barrier.h b/include/drm/task_barrier.h
> new file mode 100644
> index 0000000..087e3f6
> --- /dev/null
> +++ b/include/drm/task_barrier.h
> @@ -0,0 +1,107 @@
> +/*
> + * Copyright 2019 Advanced Micro Devices, Inc.
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining a
> + * copy of this software and associated documentation files (the "Software"),
> + * to deal in the Software without restriction, including without limitation
> + * the rights to use, copy, modify, merge, publish, distribute, sublicense,
> + * and/or sell copies of the Software, and to permit persons to whom the
> + * Software is furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be included in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> + * OTHER DEALINGS IN THE SOFTWARE.
> + *
> + */
> +#include <linux/semaphore.h>
> +#include <linux/atomic.h>
> +
> +/*
> + * Reusable 2 PHASE task barrier (randevouz point) implementation for N tasks.
rendezvous
> + * Based on the Little book of sempahores - http://greenteapress.com/semaphores/LittleBookOfSemaphores.pdf
semaphores
> + */
> +
> +
> +
> +#ifndef DRM_TASK_BARRIER_H_
> +#define DRM_TASK_BARRIER_H_
> +
> +/*
> + * Represents an instance of a task barrier.
> + */
> +struct task_barrier {
> +	unsigned int n;
> +	atomic_t count;
> +	struct semaphore enter_turnstile;
> +	struct semaphore exit_turnstile;
> +};
> +
> +static inline void task_barrier_signal_turnstile(struct semaphore *turnstile,
> +						 unsigned int n)
> +{
> +	int i;
> +
> +	for (i = 0 ; i < n; i++)
> +		up(turnstile);
> +}
> +
> +static inline void task_barrier_init(struct task_barrier *tb)
> +{
> +	tb->n = 0;
> +	atomic_set(&tb->count, 0);
> +	sema_init(&tb->enter_turnstile, 0);
> +	sema_init(&tb->exit_turnstile, 0);
> +}
> +
> +static inline void task_barrier_add_task(struct task_barrier *tb)
> +{
> +	tb->n++;
> +}
> +
> +static inline void task_barrier_rem_task(struct task_barrier *tb)
> +{
> +	tb->n--;
> +}
> +
> +/*
> + * Lines up all the threads BEFORE the critical point.
> + *
> + * When all thread passed this code the entry barrier is back to locked state.
threads pass
> + */
> +static inline void task_barrier_enter(struct task_barrier *tb)
> +{
> +	if (atomic_inc_return(&tb->count) == tb->n)
> +		task_barrier_signal_turnstile(&tb->enter_turnstile, tb->n);
> +
> +	down(&tb->enter_turnstile);
> +}
> +
> +/*
> + * Lines up all the threads AFTER the critical point.
> + *
> + * This function is used to avoid any one thread running ahead if the barrier is
> + *  used repeatedly .
> + */
> +static inline void task_barrier_exit(struct task_barrier *tb)
> +{
> +	if (atomic_dec_return(&tb->count) == 0)
> +		task_barrier_signal_turnstile(&tb->exit_turnstile, tb->n);
> +
> +	down(&tb->exit_turnstile);
> +}
> +
> +/* Convinieince function when nothing to be done in between entry and exit */
Convenience
> +static inline void task_barrier_full(struct task_barrier *tb)
> +{
> +	task_barrier_enter(tb);
> +	task_barrier_exit(tb);
> +}
> +
> +#endif
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
