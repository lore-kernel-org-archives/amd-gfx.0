Return-Path: <SRS0=AiXT=JE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0419C433B4
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Apr 2021 14:53:06 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 735AA61363
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Apr 2021 14:53:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 735AA61363
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E0B6889ADC;
	Wed,  7 Apr 2021 14:53:05 +0000 (UTC)
Received: from NAM04-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr680078.outbound.protection.outlook.com [40.107.68.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 40EB6898EE
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Apr 2021 14:53:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FM+8aCH60V4iRXLZ7rSOrJE1blt7NhqSZATetDgggNPAhEkzgV05jugoRS57h/J8UoDZIqtmqB6CT/prD3BdGzOVdWh5v7o/Ya5/ZjdjO0ihNJg9SnbG8SqJL82CiXLGLEgDDucm2itLMZrEjKJMtVLKpA8oUUZqzlY9Z7aGbgPC0RLmzeRWIige7brrwDtrjot7kGMWim5iqcgDnBnOyDG8p4uNs8vgHIuFFAYf4k9/sk0RwbGm3ttNz0i2kG3Gnvl4VhZG7jm6Bziwp0CKcFFzjJYg6TPmkiYRwqlWjHZz0btgSe/q21YXRoRJKSPpZEsIr6DtS0viec46V9u93A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xi3VfREgzFW4Cjg7TLPEKc6KT1ukAtYeYw8c+/KN1rg=;
 b=G3efPOu30hmZly8QeVz9yHFExxRjPt9T2pMtqGiek0pe6ivfYpy2yljrrdqKQuDe5r3kiw4BrkH74lomRli7mh/pbU3PnmcreXA7QNZ0ss4EXI2OIAlGTu9gFaFtFbeC5HhJULKfgWeMIQ1fmKsWvuBJMRLcY8O+S4+8bzupLzb2X5x/QG0jivqRN7R/zy1s7C7F47hrtkaGlZd8VMnJHZ2T08tptFBJHlyRd16RyAn70j61U37URPlgznxSG304kAb8L1Vg67dkK2C84nQqqajUW8RpvqW8MAu2DOqNXDmQcm7nU9VSwLUQPUGrIRjbA1SCYlM8gmoYTz+EiOwY7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xi3VfREgzFW4Cjg7TLPEKc6KT1ukAtYeYw8c+/KN1rg=;
 b=iLvdVcyrIIB32x4JiEX3a0+HyebC2daHHJJ/r6TXFEMfCpOc1qyuEkHVWrwLf6uZbjXwCD8aUpctFB1JepG9fu6Ig8zbw3bWCPnhYwbevtPyRz8laGK9hWjuABURFEe015R7iXKteaPkKJh08Sy04HqO9f1RTBdkOjUoznNN1o0=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4379.namprd12.prod.outlook.com (2603:10b6:303:5e::11)
 by MWHPR1201MB0253.namprd12.prod.outlook.com (2603:10b6:301:52::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.32; Wed, 7 Apr
 2021 14:53:01 +0000
Received: from MW3PR12MB4379.namprd12.prod.outlook.com
 ([fe80::4987:8b2f:78ca:deb8]) by MW3PR12MB4379.namprd12.prod.outlook.com
 ([fe80::4987:8b2f:78ca:deb8%8]) with mapi id 15.20.3999.032; Wed, 7 Apr 2021
 14:53:01 +0000
Subject: Re: [PATCH] drm/amdgpu: add DMUB outbox event IRQ source
 define/complete/debug flag
To: Jude Shih <shenshih@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210407083428.93645-1-shenshih@amd.com>
From: Harry Wentland <harry.wentland@amd.com>
Message-ID: <9e4f2ea9-d6aa-d1d1-9914-006c08cc21c7@amd.com>
Date: Wed, 7 Apr 2021 10:52:56 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
In-Reply-To: <20210407083428.93645-1-shenshih@amd.com>
Content-Language: en-US
X-Originating-IP: [165.204.84.11]
X-ClientProxiedBy: BN9PR03CA0689.namprd03.prod.outlook.com
 (2603:10b6:408:10e::34) To MW3PR12MB4379.namprd12.prod.outlook.com
 (2603:10b6:303:5e::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.31.7.247] (165.204.84.11) by
 BN9PR03CA0689.namprd03.prod.outlook.com (2603:10b6:408:10e::34) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.16 via Frontend
 Transport; Wed, 7 Apr 2021 14:52:59 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 11162f13-3e9f-4aa8-bf75-08d8f9d4d6df
X-MS-TrafficTypeDiagnostic: MWHPR1201MB0253:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR1201MB0253CD8A548B82050C1B832B8C759@MWHPR1201MB0253.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iTT9F7syKgd6XkzlJIdQ9DJtZM1J/Y2IZfZJyAuASwPUSD7BXLROy91H01HNRyEMUrucua9Q8x0VRY6MdiG29o73GMZ218UsT+w7PSdvmJr9b9hxl4B8VbjkEjeFQYhqGz1we/9aBhBli9lx1gBWkj/XsQxQWJKVs5hK5kjAS2Oe78hAw61/luL7WxNDQiCczdxnfrnyQWSaICnYLXsWHWbEBHzZ/DwFGT5hyD0TscfiB0DiOYVxrhRj88diHWBtJP+gk0uW+pxDLKYWGSCRoLXX5kDdTqRQCkcWFgs+bzNKK9XNgbAxgSmCeTIloGK12E0Atwf+DRu4TH0NinC3iCi/q9HH7Eay/4JR0nRcTHM4k4rza64fvMF6mQuOLz4hX58MwCbz9wsrxGhi3txfBsEJuFytsDmKNkSaeJaISMmRsZD++l+SoB+WJIHJ0M5Ea6S9JuwN9iiNJ2vS3M7hMwMbeN6A7mV4lawIJ4YYYMTY50wu9ThxPG55gi5hDAbRB96luhGimgbR/xM05Nm/v5JluJBMD0mxYm0hIfjO5BClehjYx7iciqPbKi6uGFcox7nYJZFE5qqnKXkRXdDRWw54BKIMlOwTRV+hEdFOhNgaGRfmfiXefY6ZSSMVSATEULLKlSQzbTl/ozMhvdywPCr09yu8pZ7dpAwCsMi0Cf+JIJBwWlksGxMuTltQwOfOT+VNuYocVeOYs/qvvQ7UkA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW3PR12MB4379.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(346002)(39860400002)(396003)(136003)(376002)(66946007)(8936002)(66476007)(66556008)(26005)(5660300002)(86362001)(6666004)(44832011)(16526019)(38100700001)(4326008)(36756003)(186003)(8676002)(956004)(31686004)(2616005)(6486002)(16576012)(53546011)(316002)(31696002)(2906002)(478600001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?Y2xkUW95Q25YNGNsUmtQOW5VOE1mN0tmS2c1dnFpaFBoaVI0VEpnamtpVEUw?=
 =?utf-8?B?cU5KaUJkY1F4ZUdnVGZhM2hCTlZpNGRxSEgxRm9pVVFtZy9pbWYreWpkdHJU?=
 =?utf-8?B?UFVPY09UdDYrbzVpNGU3bWNiakFHeUJ3QVBOalNiRTE2TEtobkhUemRxZVMz?=
 =?utf-8?B?cDFaYk5aZmorOVFDdDZlUHJqQTNWK1hyZG1UcmczcDZUMjJNSk1nRjY0S1Uz?=
 =?utf-8?B?RDVVcVhlNWRiWktMRTVWaFY0L0NZdXdOaW9zNGc4dFZlcDY2K3RoOGI3My9T?=
 =?utf-8?B?SFQrWVVqQURYVWZRY3FPOFY5bytLZ0xNdkhqSEJCd3djTHcxeFp0alBJWTg2?=
 =?utf-8?B?L052SXAxN0VXTWV5Q24wdmpRdjRzUFlRRVJzRU05UTdONWVKSWx2V3k0OVF4?=
 =?utf-8?B?bzZrMUF6OUlxaVhGQVhwVGRUQldiaHM3QjVNekhnU2ZtL1p3Q2dJM1hRWncz?=
 =?utf-8?B?VGZzbFNFWXhxQnA5Y2NBSkxaT3dvV1ZEclh5ZnVUSGpzTEpWUU5GQnNrbTlm?=
 =?utf-8?B?ZFVPa1Vhcy9UVXJNU2FXejNOVFZ5M3VmcmxucjdRUEdZNGQwbXZGRXAvUTJp?=
 =?utf-8?B?d0lxZHZsNXpKMzJVZ0U1SmNvdDdpd2xlckh5amdtUDFva1k5T01JTmJaVENy?=
 =?utf-8?B?ZElneWpaK2NkdmlCNFVyNUMySzlkcVgxVkJ6UDVqWDRFVjdNZFpFRFRybE5J?=
 =?utf-8?B?aUlKbUhEMkpNUWRtS2lTWHVKN2lmMk1oWjVNMWhCakxudms1U0RxMjdZcFZ3?=
 =?utf-8?B?U25NVXJiT09XcHcvOUQ0YzJGMVdLME9wc0V2cm9FUXNod3lqbHFYMnQ4clEw?=
 =?utf-8?B?WU0yd1pWRkZGMlBYZW4ybmE3dzFpclk0WVZ6NEx1WnVhQis0eVJ2dWEwT1B6?=
 =?utf-8?B?L3VoZEt0c1VvVnJ2MGZ5MFZueFdPSHdESGpiOGJhU2pTQm9SaGVxdVNTTnlQ?=
 =?utf-8?B?VDRhbXZtbHFXMStSQXUrZ1l5UUpVaDdsMFhXejV5eDErNVNjVDF5aVRJbzJG?=
 =?utf-8?B?TEtNenNhbG9PSDMwNGwvNFd0bWg0TVNxbXZrbWtZdnI4Nzl0Y2U0alRCRVVk?=
 =?utf-8?B?dytHT2VWT0dDUGtZY3R4aG1TMGRxeDF3S3h1QmdaMGFjVmJqU3lmRTE4SStr?=
 =?utf-8?B?amRhTVhnbndzMnZuYXlKQlZSdUJYclpBckpwWWRNbUxzNElaVEFqc3VrRjNq?=
 =?utf-8?B?Ri83T3dGZUsxTEg0STdOWDZyV0FpN3dNKzdxZVVKSG43K1JaMWdZKy9TZCtE?=
 =?utf-8?B?Qm5GazFnbGV2eVVIUERUU3ZYSkgzTkJMUHFvbE4xTjN4dENpdjRFRUhFMlVx?=
 =?utf-8?B?TWxCeHZ5dnRnRjl6RGJodERkY1RrbDkrVGx4MmtxTDQydEpwYkp0M2pYLzRp?=
 =?utf-8?B?Z2xQV256cS9vM2lHN1BLbUtnL216ejQzSkVOMndpVDczNFFIN3g1NGtKUFRw?=
 =?utf-8?B?ZVdpN29sek9XekZtemtFaGE3cHJTUHdLRnJLRGNoclF3bFJoT1Z4dlR0OGs1?=
 =?utf-8?B?ZUpLTndtQVVqSjVIZWdrZS9KNGdzUjZtL1JWQTBWdk50aTg0a0dGZGs3dVdP?=
 =?utf-8?B?TW82UHZzdUpLRnBUeHAyMC8rbjhRUmUvQlhING5kdEJ3SjRPZTV4SzErZ3Vj?=
 =?utf-8?B?b3JVaE1vZjMrOExpRkJjMzdudVZJYUNOOHFEcjhLNFZpWXViV0s1UUNQbTQ5?=
 =?utf-8?B?WWk2cld2WHo3a2ZjSWRvblNHV2h6TnFwUk5aR2ZOWDQ3bUw2aWw3b0JUMGkr?=
 =?utf-8?Q?ewXnMUkbzbkK3KrrHC90hSPaRWllZvtjYNQeGlx?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11162f13-3e9f-4aa8-bf75-08d8f9d4d6df
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4379.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2021 14:53:00.9282 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fVacOyeTCvWdKXeuoR2fc8Z9Ys77qR3USuwejGPVwATsPXfENMMvorrf7iCXNyIoKDIWa2t0X3Zy5+lofDODCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0253
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
Cc: alexander.deucher@amd.com, wayne.lin@amd.com, cruise.hung@amd.com,
 nicholas.kazlauskas@amd.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2021-04-07 4:34 a.m., Jude Shih wrote:
> [Why & How]
> We use outbox interrupt that allows us to do the AUX via DMUB
> Therefore, we need to add some irq source related definition
> in the header files;
> 
> Signed-off-by: Jude Shih <shenshih@amd.com>

Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Harry

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h                       | 1 +
>   drivers/gpu/drm/amd/include/ivsrcid/dcn/irqsrcs_dcn_1_0.h | 2 ++
>   2 files changed, 3 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 963ecfd84347..480e07d83492 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -923,6 +923,7 @@ struct amdgpu_device {
>   	struct amdgpu_irq_src		pageflip_irq;
>   	struct amdgpu_irq_src		hpd_irq;
>   	struct amdgpu_irq_src		dmub_trace_irq;
> +	struct amdgpu_irq_src		dmub_outbox_irq;
>   
>   	/* rings */
>   	u64				fence_context;
> diff --git a/drivers/gpu/drm/amd/include/ivsrcid/dcn/irqsrcs_dcn_1_0.h b/drivers/gpu/drm/amd/include/ivsrcid/dcn/irqsrcs_dcn_1_0.h
> index e2bffcae273a..754170a86ea4 100644
> --- a/drivers/gpu/drm/amd/include/ivsrcid/dcn/irqsrcs_dcn_1_0.h
> +++ b/drivers/gpu/drm/amd/include/ivsrcid/dcn/irqsrcs_dcn_1_0.h
> @@ -1132,5 +1132,7 @@
>   
>   #define DCN_1_0__SRCID__DMCUB_OUTBOX_HIGH_PRIORITY_READY_INT       0x68
>   #define DCN_1_0__CTXID__DMCUB_OUTBOX_HIGH_PRIORITY_READY_INT       6
> +#define DCN_1_0__SRCID__DMCUB_OUTBOX_LOW_PRIORITY_READY_INT        0x68 // DMCUB_IHC_outbox1_ready_int IHC_DMCUB_outbox1_ready_int_ack DMCUB_OUTBOX_LOW_PRIORITY_READY_INTERRUPT DISP_INTERRUPT_STATUS_CONTINUE24 Level/Pulse
> +#define DCN_1_0__CTXID__DMCUB_OUTBOX_LOW_PRIORITY_READY_INT        8
>   
>   #endif // __IRQSRCS_DCN_1_0_H__
> 

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
