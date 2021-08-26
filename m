Return-Path: <SRS0=gNHI=NR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 449DDC432BE
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Aug 2021 09:27:36 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EDA85610A3
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Aug 2021 09:27:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org EDA85610A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 875D46E595;
	Thu, 26 Aug 2021 09:27:35 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2056.outbound.protection.outlook.com [40.107.243.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 80EF46E598
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Aug 2021 09:27:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mCq4bw5spT5mr3oJOx5ftBG5YD0c96RylstbpjO4ofPhKib9w3pz0qp9wcV2b/tQjbUtNhWIzzC7wkMDKjnl23fu5krDA8aScKZq1KQzxgs4wuqeTuWAY8k5yqErN7+j2lUVKZXEe/VL19Q1MYSGLKOIUbke6/HckeEV+mSv+F4cRCRW2VAQ390es0KlvJ6RAPc8pi0R65wuMFDfMib90HbSLtNqYV7Wzq7Q0QhAf/E+vSAhb5VCQWZBUzpIN8JmGdUBAeitutm7mYW57JssSVy4dxu9rk4Xua1rIZHKUEBtrBNDLxxpXbw2chiGl7UHKw55kxBA+BHkdEgFm01jVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VDBgIDFk4yef+wCsaJChTvVAdNB3eHZVQB2alG1AYJU=;
 b=jflGJgARC8QEb3XlDVIKx3HS7cVdDrCrc+1r6ONEre80+jQrdrLINh5VJxoRSnMGVS3plGXJYvAcZ6J5TfqVRx/tZC6IjekfzDs/gQNNClbiSBlVZwSWyN8qZoHGzMwtgEagzG/XuhReWSgkI7y06jH9whKowQlNnxl0C8XAxCqFlnM1TeTtR1yvxQexMEo/wS8B306WWPZ3PBtviDVQDJiL5twMt0kx9f5S4lGVZ/RVpcuFI3GxaUn4nj8FoxF/rLSxq3CwHUI6mIlm+z5prtX9TWoTpxWiZUbx6wk6nmIlyXh+TBP5W5xUN2pVDmE0KJzeU7EY0J9IB24e9XB7Mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VDBgIDFk4yef+wCsaJChTvVAdNB3eHZVQB2alG1AYJU=;
 b=iNJ0zc/4ERAn3/cfYb0pRR9ftHiqIZ6gFi9RZpOzJGz0jul3VVXZt9IDg1e1Xwt9CgGZeWONa425+Gxr/CpxKtgwBrGljK1yrjtWZjFp1sKy24u8Ssx8C3eBSbRe6Huh+Pg2MPC8v19DvECXLplFf69tN2EyGtEjHkSCPcnBEr0=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5349.namprd12.prod.outlook.com (2603:10b6:208:31f::7)
 by BL0PR12MB5538.namprd12.prod.outlook.com (2603:10b6:208:1c9::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Thu, 26 Aug
 2021 09:27:32 +0000
Received: from BL1PR12MB5349.namprd12.prod.outlook.com
 ([fe80::152:9dd3:45a4:eeb6]) by BL1PR12MB5349.namprd12.prod.outlook.com
 ([fe80::152:9dd3:45a4:eeb6%4]) with mapi id 15.20.4415.024; Thu, 26 Aug 2021
 09:27:31 +0000
Subject: Re: [PATCH 1/1] drm/amdgpu: detach ring priority from gfx priority
To: Nirmoy Das <nirmoy.das@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Christian.Koenig@amd.com, satyajit.sahu@amd.com
References: <20210825154233.4882-1-nirmoy.das@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
Message-ID: <b2a5e7d5-5fa1-ec27-8244-98a4a1e0a125@amd.com>
Date: Thu, 26 Aug 2021 14:57:21 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <20210825154233.4882-1-nirmoy.das@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN1PR0101CA0004.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c00:e::14) To BL1PR12MB5349.namprd12.prod.outlook.com
 (2603:10b6:208:31f::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.31.157.114] (165.204.158.249) by
 PN1PR0101CA0004.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c00:e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.17 via Frontend
 Transport; Thu, 26 Aug 2021 09:27:29 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3474559c-5015-4e41-caf9-08d96873bae6
X-MS-TrafficTypeDiagnostic: BL0PR12MB5538:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB553841F794B356270AB9E09D97C79@BL0PR12MB5538.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bq/RsCeOVjumBkf60/fK8EpvoVB6G9lMLS/ANd3VfnnxOjdSvDKXkvmIqejN/NXrMX/+ZC0D+Ks7CZ9u9w/G0qjvY3XUd/fzTNrUNFyfwlRBXI/1Fudtj6nS+01nArnvZ6uXnbB1CzUEvAb2ZblyXTG+0zi5PTMxlDTAia6kXtoOn5E9KH6MePQ1zS8ZqqPR876mzh4S0t94YPxVxAsS5IhVJWaxeV1N2jtuRxKtT2OZzZysBuIzobYtC9HMMB0IhvtXYASdXJ9vZHmPqHHGbQ4HtIaUpDP23MzqgFRvejjKOfq3EXPKj9IM4l9wNFCn6YAHw+IZZL97vjI8+N060xcrAc7Vbcy/cXaRXaAfZ2byQ4jc+NuxLAXBtXKfJWXoqCblcFYGuGOqePJooW/Cgw1XqmoxiChPucbGhOaZBu61nmWx4jk7eyo6y/c7H+lm/gX6GrF7ma268RIMUDOSg7eTRJr2mx8GBxnbrhz2Fop2N8Lrwyz8DASFUOPlwnoTkcuW8mKHq5ctjghkinv8KTLSa8r3rypenqJhAt/nb5y3WrUFLy9/sDglGqgNem/8VOR7CcY+3kJgE+aVSEO5qKUkJE9wH7EYhZ+3/hnAKcYPJG6yJuG5D05rsqf7m6ME5mp3salNbvRhTo+ERzxnPLTD3b5hHuaV5zaCDPl+6VkRtbB4qk+JE1H2ZY+oEm26hh3IbIlomHNArrJGqmkXhbPCduEZwHjlu+Sg5aWN6H8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5349.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(366004)(136003)(346002)(396003)(376002)(4326008)(2616005)(66556008)(6486002)(2906002)(8676002)(5660300002)(53546011)(31686004)(86362001)(478600001)(36756003)(16576012)(31696002)(66476007)(186003)(83380400001)(6666004)(66946007)(38100700002)(8936002)(316002)(956004)(26005)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZngxNEdKTFJuVkZhSDkyL1Q3ajNNQ01tM3NDMjhxQ2ZKeTh0VlcxNkJ0TlZM?=
 =?utf-8?B?MndRQmg0VWt4eVJwSktJK09ZZzlwMlVxc0Y4ZUZJQjcwSVNMOHFpT1hCV2J5?=
 =?utf-8?B?Zm1oUUtkWDQxZTc3MWp0bUhueGxmRVU2TVRmS05NLzJsRyt0cjNaRHlGZWpR?=
 =?utf-8?B?Ukt0RjgrcXJIL28vWGlYdW9CMW8xNmVDdSs0akFsQkk3cEp6ejdlNW8ybmJZ?=
 =?utf-8?B?S1dpWmczOE1Gc1V1Q0JlRUtOU09JT2gwTUJyZHRwb2NQdkhlcEM2NmFYdnI5?=
 =?utf-8?B?VWJnazRicGxDYzAzbEZyMUYyYXpRN3dHSHpaNGVaRnJjTjI0RVlWSEpvSWZU?=
 =?utf-8?B?Ni9iblJpVGhTbnRSRWZtaEZPR2JvZThPbnNKN3l0bjJZZXFYSTQrZmJqUm5a?=
 =?utf-8?B?eTFDR3F0RzNuV09wM3pwVGl0KzRuN0pPdkJUcDRFS0prVzZ5L0xXUDZBOGhr?=
 =?utf-8?B?eUw4TVdra1NtaWVITG1jN2gwOUQ0SmRVS0N6dVRtdmJHbXYyTmhmamtYV29P?=
 =?utf-8?B?aUxPZFZtVm5uNW9INlU4b3E0aFVzTkZHdVV0RmV6VWxSTlg2YzAwZUpiazBP?=
 =?utf-8?B?MGFsU1IwY2NCdThvSm11QzVuRktyRk9MQWxtYTFMM0NaSlVSNkM3SEpCOUgv?=
 =?utf-8?B?YmxpYzFQRmRXd0FrSkNtS2JTVnZ1U2YvcnFnNE13NjFGaU1ic01XTWhVZE40?=
 =?utf-8?B?eFRtZnhaTFVieDNhOE4vUTZUQVFKZGJybnloNTdnUDNsdGxVVGJCVGlFNnNI?=
 =?utf-8?B?L01LZnBvYUozanhGNHkrZlZTb05pa0ZuZ09ZVmsvUDJMQ1RFR0dRZUQ3eVN2?=
 =?utf-8?B?eDY4QkZFTnVCd3o3bERXVG9BQlFLbThiMXM2QnZBUGF4Mk82UU5BYXZVcWk4?=
 =?utf-8?B?ZmF1WXhnN2tnUitTYmJTSmJ1dTFpR3BRQ1gxQWZlOVFlS29jVmVsTnR4NTRH?=
 =?utf-8?B?cHgzY1c4UEcxT3R6NjZvN1dnTG0zZGZmeVR2YWRrenZjVUNMOGZtS21HTGRv?=
 =?utf-8?B?dmhqellGUXA1U3JXKzM3QkJjdmFxYzZVNjlITXlUY0FiNzYzbFhBdXVKVEVI?=
 =?utf-8?B?anREOWdOVm42c0FOeFduUDRNem9kanc0ZDFMeXdHekNEQkV4SFNRRHhyOUZl?=
 =?utf-8?B?UDN0MW9vcE9nUEVUUDAvSlZudU40aDFSSW5UcTFkN0JDdjcwYlRxdVlGbGl4?=
 =?utf-8?B?L3JxYktjNytFdytiZS9qTWhOeXBreDByTXlJajUyS29XVVMzME83SkNaWW1l?=
 =?utf-8?B?ZjRZWThCdEdJMmFNNjM0djY1WXdvWFMyMHV6USszaS9CWGxnc2NyNUx2Tkha?=
 =?utf-8?B?bkloaWJCRzVCZkc3SGR3Tnprc2V2S0hPRmNwMm5kMEZKc0RZZ2llc0U2Wkdy?=
 =?utf-8?B?VFkxMXBPMzkxbS95a0NMTTlGc1JaYUlHSmU5OFMrRDFRTTl1TE9QTlBybDlj?=
 =?utf-8?B?R0hGdlJ4UWlrNll3emxlRWpDOEJON3V5ejdvRkhwWmgxTnZLWEkvbkFKT1JT?=
 =?utf-8?B?UXZNV0o3eStZU3NTQVdsMThjNVI0M0JuZEtsNUZ2dDVNQUt0dFFPYWtKWFNN?=
 =?utf-8?B?eXRpSS9jV21EanZXVWtvekdzNXdxU2hoZ095OW9udWFTdnhOekhrLzhKdU02?=
 =?utf-8?B?UmV0TTdtblNTNlhkUHIvT2tkYlVvK1plUDFwTnF4Wml6eW5VV1RtQVdadUdR?=
 =?utf-8?B?ZDlLdlhhQ1cwd3BNUzQxZVVzeWhON2lrZ2VDNWhoaXpQVjNLV0ZyUzIxRzBa?=
 =?utf-8?Q?KU/lmqs6ea09/nQevrksAX2UMIB70WSU5UjlGuA?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3474559c-5015-4e41-caf9-08d96873bae6
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5349.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2021 09:27:31.7463 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Nsq+ZZJmYCZU/XN7vvne+Xh4zGqnbkQqE9d+kusvbe/DB42Aund+EDouK8CJu834
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB5538
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



On 8/25/2021 9:12 PM, Nirmoy Das wrote:
> Currently AMDGPU_RING_PRIO_MAX is redefinition of a
> max gfx hwip priority, this won't work well when we will
> have a hwip with different set of priorities than gfx.
> Also, HW ring priorities are different from ring priorities.
> 
> Create a global enum for ring priority levels which each
> HWIP can use to define its own priority levels.
> 
> Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h  |  6 +++---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h | 10 ++++++++--
>   2 files changed, 11 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> index d43fe2ed8116..937320293029 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> @@ -43,9 +43,9 @@
>   #define AMDGPU_MAX_COMPUTE_QUEUES KGD_MAX_QUEUES
>   
>   enum gfx_pipe_priority {
> -	AMDGPU_GFX_PIPE_PRIO_NORMAL = 1,
> -	AMDGPU_GFX_PIPE_PRIO_HIGH,
> -	AMDGPU_GFX_PIPE_PRIO_MAX
> +	AMDGPU_GFX_PIPE_PRIO_NORMAL = AMDGPU_RING_PRIO_1,
> +	AMDGPU_GFX_PIPE_PRIO_HIGH = AMDGPU_RING_PRIO_2,
> +	AMDGPU_GFX_PIPE_PRIO_MAX = AMDGPU_RING_PRIO_3

Is this a valid priority level? If not, better avoid it.

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

>   };
>   
>   /* Argument for PPSMC_MSG_GpuChangeState */
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> index e713d31619fe..85541005c1ad 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> @@ -36,8 +36,14 @@
>   #define AMDGPU_MAX_VCE_RINGS		3
>   #define AMDGPU_MAX_UVD_ENC_RINGS	2
>   
> -#define AMDGPU_RING_PRIO_DEFAULT	1
> -#define AMDGPU_RING_PRIO_MAX		AMDGPU_GFX_PIPE_PRIO_MAX
> +enum amdgpu_ring_priority_level {
> +	AMDGPU_RING_PRIO_0,
> +	AMDGPU_RING_PRIO_1,
> +	AMDGPU_RING_PRIO_DEFAULT = 1,
> +	AMDGPU_RING_PRIO_2,
> +	AMDGPU_RING_PRIO_3,
> +	AMDGPU_RING_PRIO_MAX
> +};
>   
>   /* some special values for the owner field */
>   #define AMDGPU_FENCE_OWNER_UNDEFINED	((void *)0ul)
> 
