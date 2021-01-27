Return-Path: <SRS0=2QJd=G6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 949FBC433E6
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Jan 2021 14:59:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2CCF2214D8
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Jan 2021 14:59:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CCF2214D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B612D89BB0;
	Wed, 27 Jan 2021 14:59:30 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2082.outbound.protection.outlook.com [40.107.93.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA89B89BB0
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Jan 2021 14:59:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BTkgs7fOTlLpTx6O0tar+SSibb3ThUFK9umNliVivdy3XBOxDQoGBNWrXOaCWifXUegcIXogLwQv2HHxsr1W3I97mO3yLhk2OYVsNYVw9Jk7nUw+UzufF9YGuqjIWVVcFa6lHbRG3B8Io7AMtxnuqJfv0dPsDqlwLqR6qE2LAvw3x/Hz9GpY7Cgua2hjurQuItgH+bYfwlh2L70F2nXAx6rXeD9v+TA9h4YeNRf/YZHd7l+TZnNyFneREuvash1MBlHknGxhrBKJpcctvuJK3jlyZmVEemLMaj9M9vazoXrmfbclEzUaqZdW2J6alfoTRKuEv/yTy5vIoVR0W2Aj5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nrCN8zkesDyQ8Ws4+Ke6eyIdJSkx4WbrqS9WM3mZIw4=;
 b=kc8Bo81fzizJppKT40yUoRUHAMLqOQfFvbqndRjTJQ/NJH3qKGSwutVSJL1HimSm7DlaFRkmd6OYpd1sQ+1FvvTVQUWDgewmzyz72jTwJW/y3E7Wc99tf+YfijK8t81C62dC4y8rvUWxvplypRI1U5qCb2hdqAoinAE9ibQz3BlBpjzVQnRUGOTM1hUU6jdhFcvjnjTgam/2eI4aKQZFmFiByLVW4O4csxh1RVpzjqkpMbx1f1Ip93B2PPn75j7kNOU9Z9CW5ZfZ9+Ca2cqSHN4FcLx64ePL1EyNHFsP0vTZmqOBv5JC1B5pJEMSYuSFabmuK61a9Au+NNyanop8+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nrCN8zkesDyQ8Ws4+Ke6eyIdJSkx4WbrqS9WM3mZIw4=;
 b=mF0dEhIbiJbBObailIT8aVoyYhvBGkQwuwjbxKOwmJ0ijVHs+VjfKbrBHF8crgnnm5UYSOr4qvHyWKSvIiW25t5uC5++tfumXKa4NMgYwFRd2byhX4bXjUHhr7E5tULQaN4xEeIS5EgVY7T75stKfy/C9YhfdidP/1/62Lnvk5Y=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by BL0PR12MB2452.namprd12.prod.outlook.com (2603:10b6:207:3f::32)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.9; Wed, 27 Jan
 2021 14:59:25 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::44f:9f01:ece7:f0e5]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::44f:9f01:ece7:f0e5%3]) with mapi id 15.20.3784.019; Wed, 27 Jan 2021
 14:59:25 +0000
Subject: Re: [RFC PATCH 1/2] drm/amdgpu: add wave limit functionality for
 gfx8,9
To: Nirmoy Das <nirmoy.das@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210127145658.13099-1-nirmoy.das@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <e363218c-721a-6ec2-26d7-2f91f7e59b98@amd.com>
Date: Wed, 27 Jan 2021 15:59:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20210127145658.13099-1-nirmoy.das@amd.com>
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-ClientProxiedBy: FR2P281CA0005.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::15) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
 (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by
 FR2P281CA0005.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:a::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3825.8 via Frontend Transport; Wed, 27 Jan 2021 14:59:24 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 86f44e80-f94b-4136-4d13-08d8c2d4232c
X-MS-TrafficTypeDiagnostic: BL0PR12MB2452:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB24523ED7717D24903DF4754C83BB0@BL0PR12MB2452.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Xqr9XCv/+oUyyGdfIamivoCCs+TYBhzfTP02TejmIw9dg+dEM+5XSeKgwqHtZ57ectPNe/aLX7jTUhfpLIpkSgsHhNZu/C9DxS4cEldX6zKJ1/tVSceyIq1xhWd2xqmQ6kbDo+jK8QcTK8O8briwsWFTsO5owpLO4DDs3cumLyT1nVEkxIy/8dqnYOXvY4BZWdHINGiQ4SULZEqm11dUI7vA7o5buhOBWooqP9qDObXIMKIjalcO5zmlJOJkZTnoe32jzHwfCUZ5NX/en8PH3cnZQzNmWc3nU8nG1tj60CYzUf5jbbEH7l0lDHa2Q6E0K+J7gZ0hJiEGss4m9nVZxO2dZH84L0zjlDgNJadbrIcpCn48a+meF1gKZqNqUq5fAoF6mlZYWJzxqhWh+ZG2+Dia5p2AxCHTh08f/WiDwOMeNbcc6thra90Ho28tThas/kTvcJh10tPvrTEC8DiT8AOPB9Izrj3PYFcVVMmpNg3J0W9OEdYSkfRVI+qIchYLmMyr6fh+TyDpCRdknS8QSwhRbWao1quo2qnkc8PvIsFuFyXBXNsy+qt6KdiNWByJrNec7fzeaH78/8n2irrJvuWyoTDl16Ko9Ep9j6YJWww=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(366004)(376002)(396003)(346002)(136003)(4326008)(66946007)(66556008)(66476007)(86362001)(8676002)(2616005)(36756003)(31686004)(8936002)(6666004)(5660300002)(316002)(83380400001)(31696002)(52116002)(2906002)(186003)(16526019)(6486002)(478600001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?SDhoSjVuZzVkM3dUcCtPZm9oMUE5bGR0T3JIY0xqNkYxTG1Rd0QvcTRMUkZP?=
 =?utf-8?B?a1pibUYxUGZQTzFpTWtNVEJoTG1Fd3FrcG9ZK2VhY0lKZFdJTUVGT21rNzM2?=
 =?utf-8?B?U0c5TFNoSnhSMlV6Q08yNEdoZVM5cmFwY3ZXa0NJbHFOckVuR0tZYlFxRmtG?=
 =?utf-8?B?YTdSZC9VbEdKTSswL2V1cmNLcnMxQ0RoQ256K0xTUmpxdUl5UVRtQmtGQlVR?=
 =?utf-8?B?TE9pb1RmZS9sNEVOeDhWSnAwU3dwOHh0ZjRTNlUvTWZSdmtnOTBsMk5lU3Qr?=
 =?utf-8?B?MWYwN0VkWnNNTy9JV21MSkVOTHF5amdaTE10RitxRGRlaHd2VlhRWEhsOW9O?=
 =?utf-8?B?cXdLOC8xZDkrVXh0TVhmNTZBR3V4a0pGTVJrb29uM1pmcFlLL1QxeTRGSkp6?=
 =?utf-8?B?b0ZQNG9DYnpLdHBUMEU4MDVNRlVlQ2pFRDduYXR1Y3ZhQXJ5a2E0OFFIZFdY?=
 =?utf-8?B?STkxWFY0NjhNOTA5TndkR3RPNHptNFViREFsckhaemhJRU02QkhzaDFoRk9V?=
 =?utf-8?B?SEJqeWpLeTloNmRHa3EzOVhjQitTWE1MRGN3bEk0TkJhQ3JVZ0JiTmNGOEp0?=
 =?utf-8?B?dFJGYy85SVFya1dIdUxkTnI2bG9qRkF4VS9raHVqTm5hVTlSVWg2K1BJcWUz?=
 =?utf-8?B?anVYQnphcCs4OUNmeWtYenJicjdVU2JhWGZiU2wxWmVSR2p2UjhxNzR1VFMv?=
 =?utf-8?B?U2M2Qkl3dFZ6blA0SkJYVC9kcEV0L1pOSjJNR1QwOGNwWmNqTFJLclhDWXRD?=
 =?utf-8?B?Q3RwSm9FTXozUDgxb2FraTA5ZXdaTnZPTU1rR3lwSzI3MWc3TnNIUDRzV1ZM?=
 =?utf-8?B?clQ4UExxUzVLNVlnd1RGbjB2Umd3aDBMN2pzZXBzcGczaDBvNmtreWw3QVk3?=
 =?utf-8?B?RzcxWUFzK0lFTTlFWmNlaHVmQWVTcHRjQXpjUGtBMi9LczZvZFArRjZTM291?=
 =?utf-8?B?cE5FT3NNMlVvTlhjajVGby9KZ0dVNWtaTEVWdTB3bHdJT1ozQ3RRUG1KWE9h?=
 =?utf-8?B?V1N6ZUtwTnFYekE5dm1jbVV1YWFoTVh3T2FNSk1mdEdNU1ZWMTArVWFzcU8r?=
 =?utf-8?B?TG9JbTl0ZXYyMlJPYXdCbmd6dTh5ZDRzRVE3aTZGTzQzQkVHVzB5aExzVHBI?=
 =?utf-8?B?SklyQjgxMUFMS3VGNnVVNVJjRTlwVEFqUTljMldwL1ZwWk1iaWlZN3RzRVlM?=
 =?utf-8?B?Y0FReThhcXBpWFZZV21zblNRT3lnZUZodnNVODBKOGtZWHEyM2cwTUYvYnU1?=
 =?utf-8?B?WWFWSDBnUGZJVDZ1TldQTXBxWHZpazg5SFJ2ZUp6SmdWMG5JL0xKeEhZRkVT?=
 =?utf-8?B?K0o0M0pWNGdzcktneVZwMVZyT0ExUU5lQU8xY1ppNndXdXR5N1dsWWYxRGsz?=
 =?utf-8?B?Q2h5dmlGTGdvT2pRdlFkbW9Ea3AyWGhDSTM3TEIwSVo5dnNMSVNLdDc4d3Ry?=
 =?utf-8?B?amV3a0IwanVNU0cxWDQ3aS9UbHArNjlhWm4rNGpaVHdXREs2RDg3aXlXcENl?=
 =?utf-8?B?VTVrbEJQb0ZucTQraVJKMktGdkFoazZ0clhIVndyYjZJOGhQMmc3T2V3L1RQ?=
 =?utf-8?B?N3h4Zz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86f44e80-f94b-4136-4d13-08d8c2d4232c
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2021 14:59:25.3765 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vplgem15ZC7yuErycejOo6nqQo271NW3gvBqxfr401YdVoo0PzzHF4k49mopyJsw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2452
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
Cc: Alexander.Deucher@amd.com, Alan.Harrison@amd.com, Felix.Kuehling@amd.com,
 ray.huang@amd.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 27.01.21 um 15:56 schrieb Nirmoy Das:
> Wave limiting can be use to load balance high priority
> compute jobs along with gfx jobs. When enabled, this will reserve
> 70% of waves for compute jobs

Can this be changed on the fly? I was always assuming this must be 
something static.

Christian.

>
> Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h |  1 +
>   drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c    | 16 ++++++++++++++++
>   drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c    | 18 ++++++++++++++++++
>   3 files changed, 35 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> index 7112137689db..220eec886f23 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> @@ -197,6 +197,7 @@ struct amdgpu_ring_funcs {
>   	void (*soft_recovery)(struct amdgpu_ring *ring, unsigned vmid);
>   	int (*preempt_ib)(struct amdgpu_ring *ring);
>   	void (*emit_mem_sync)(struct amdgpu_ring *ring);
> +	void (*emit_wave_limit)(struct amdgpu_ring *ring, bool enable);
>   };
>
>   struct amdgpu_ring {
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> index 37639214cbbb..ead2cae3927b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> @@ -6847,6 +6847,21 @@ static void gfx_v8_0_emit_mem_sync_compute(struct amdgpu_ring *ring)
>   	amdgpu_ring_write(ring, 0x0000000A);	/* poll interval */
>   }
>
> +#define mmSPI_WCL_PIPE_PERCENT_GFX_DEFAULT	0x07ffffff
> +static void gfx_v8_0_emit_wave_limit(struct amdgpu_ring *ring, bool enable)
> +{
> +	struct amdgpu_device *adev = ring->adev;
> +	uint32_t val;
> +
> +
> +	/* mmSPI_WCL_PIPE_PERCENT_GFX is a 7 bit multiplier register to limit
> +	 * number of gfx waves. Setting 5 bit will make sure gfx only gets
> +	 * maximum 25% of gpu resources.
> +	 */
> +	val = enable ? 0x1f : mmSPI_WCL_PIPE_PERCENT_GFX_DEFAULT;
> +	gfx_v8_0_ring_emit_wreg(ring, mmSPI_WCL_PIPE_PERCENT_GFX, val);
> +}
> +
>   static const struct amd_ip_funcs gfx_v8_0_ip_funcs = {
>   	.name = "gfx_v8_0",
>   	.early_init = gfx_v8_0_early_init,
> @@ -6944,6 +6959,7 @@ static const struct amdgpu_ring_funcs gfx_v8_0_ring_funcs_compute = {
>   	.pad_ib = amdgpu_ring_generic_pad_ib,
>   	.emit_wreg = gfx_v8_0_ring_emit_wreg,
>   	.emit_mem_sync = gfx_v8_0_emit_mem_sync_compute,
> +	.emit_wave_limit = gfx_v8_0_emit_wave_limit,
>   };
>
>   static const struct amdgpu_ring_funcs gfx_v8_0_ring_funcs_kiq = {
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> index a896e3d0fcf8..e94737d82915 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -52,6 +52,7 @@
>
>   #include "asic_reg/pwr/pwr_10_0_offset.h"
>   #include "asic_reg/pwr/pwr_10_0_sh_mask.h"
> +#include "asic_reg/gc/gc_9_0_default.h"
>
>   #define GFX9_NUM_GFX_RINGS     1
>   #define GFX9_MEC_HPD_SIZE 4096
> @@ -6670,6 +6671,22 @@ static void gfx_v9_0_emit_mem_sync(struct amdgpu_ring *ring)
>   	amdgpu_ring_write(ring, 0x0000000A); /* POLL_INTERVAL */
>   }
>
> +static void gfx_v9_0_emit_wave_limit(struct amdgpu_ring *ring, bool enable)
> +{
> +	struct amdgpu_device *adev = ring->adev;
> +	uint32_t val;
> +
> +
> +	/* mmSPI_WCL_PIPE_PERCENT_GFX is a 7 bit multiplier register to limit
> +	 * number of gfx waves. Setting 5 bit will make sure gfx only gets
> +	 * maximum 25% of gpu resources.
> +	 */
> +	val = enable ? 0x1f : mmSPI_WCL_PIPE_PERCENT_GFX_DEFAULT;
> +	amdgpu_ring_emit_wreg(ring,
> +			      SOC15_REG_OFFSET(GC, 0, mmSPI_WCL_PIPE_PERCENT_GFX),
> +			      val);
> +}
> +
>   static const struct amd_ip_funcs gfx_v9_0_ip_funcs = {
>   	.name = "gfx_v9_0",
>   	.early_init = gfx_v9_0_early_init,
> @@ -6775,6 +6792,7 @@ static const struct amdgpu_ring_funcs gfx_v9_0_ring_funcs_compute = {
>   	.emit_reg_wait = gfx_v9_0_ring_emit_reg_wait,
>   	.emit_reg_write_reg_wait = gfx_v9_0_ring_emit_reg_write_reg_wait,
>   	.emit_mem_sync = gfx_v9_0_emit_mem_sync,
> +	.emit_wave_limit = gfx_v9_0_emit_wave_limit,
>   };
>
>   static const struct amdgpu_ring_funcs gfx_v9_0_ring_funcs_kiq = {
> --
> 2.30.0
>

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
