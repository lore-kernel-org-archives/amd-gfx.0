Return-Path: <SRS0=2AtA=PH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC6B7C433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Oct 2021 18:13:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B24E60EB8
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Oct 2021 18:13:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6B24E60EB8
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1845B6E1DE;
	Tue, 19 Oct 2021 18:13:23 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2041.outbound.protection.outlook.com [40.107.92.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7B4466E1DE
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Oct 2021 18:13:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HTbzfxGNK4MOxIh/Cl5zWFbp3TWwrI4WjTnJ0M/O8EowMtIhIo6CXZGIZuHpF9ks+pvYVSfKqjz8IyowaFmVFzL+8kMuHQwdA/Uoq10lW7Lq55WBacTshcbsj9zmlKbPiGEnBPsYY9K4T9bBZLOLyKTDYW2MLJ6AryTWO1gANxuB6wL8y49AzuGDhSsa6gU9VTLsL7+/+yVxT+Iymqnu0rrGrs8rUDR/Vp1MwtxF+hwWBf15mULUuoVnb8c1aVsARqIs6eGb+Om1O/S7hAtiIBaqYcQO7tP2esgoBJ0fgjQr1zhUeYjgos0A8ALQuSkNCrUD8LFc3IrM9gPO9eqvyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R8rzHFJnylha2+F6rOjgKvDF960kJoyx2YaELtygr14=;
 b=Ad43yiWTBMTF81KVKCx9XT+TeTg09G/aFlMIcA7fWLm555puHLUiSIoo8vJ9v9Agr+G85wOh8FiDowyqKGZCLiie8COf6FAgx+wjvh5viJSJtMaKjuobr6C56BifahtluNkPn6a4GoUJ9U0B9wRgfPvnJ8zPIgDuAuzQADfkImqLMfMP6swLjGSgfOEf0ukZMaHbofltl3FPcoTLK0xT3mE9IN0Ez03nJUBlVaMOSbSv6b78j6bnVehuYs9ZsgwJpPGbURsqsgK4WNX5utZn181fm+n+bQrUIw27QsV/vT5p8Wbo7JOs/8UiWO1Vw/MH4GPKP4qsb0BwYj8qwMmM5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R8rzHFJnylha2+F6rOjgKvDF960kJoyx2YaELtygr14=;
 b=C/k1qkPEIszPuWS/6gtwjUMZYbwD6VaPrn7QlMMSxBkiKuSgTGci/3LhCHRdJz3Zgq89gZ9Cuoq0JzEtyXx6Cwtjhn2BAvC7ytddFKT3MrBIWuDQ+b1bJ/KKmNK1jjCCknKb63ZiAa31j37kwFQr5hN9Omib9qx1qp6CWWoFRnU=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM5PR1201MB2491.namprd12.prod.outlook.com (2603:10b6:3:eb::23)
 by DM6PR12MB2937.namprd12.prod.outlook.com (2603:10b6:5:181::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.18; Tue, 19 Oct
 2021 18:13:15 +0000
Received: from DM5PR1201MB2491.namprd12.prod.outlook.com
 ([fe80::d153:3aa6:4677:e29]) by DM5PR1201MB2491.namprd12.prod.outlook.com
 ([fe80::d153:3aa6:4677:e29%7]) with mapi id 15.20.4608.018; Tue, 19 Oct 2021
 18:13:15 +0000
Subject: Re: [PATCH 3/4] drm/amdgpu: Add kernel parameter for ignoring bad
 page threshold
To: Kent Russell <kent.russell@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Luben Tuikov <luben.tuikov@amd.com>, Mukul Joshi <Mukul.Joshi@amd.com>
References: <20211019175050.934527-1-kent.russell@amd.com>
 <20211019175050.934527-3-kent.russell@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <12b72b9b-0b46-248d-fb85-82e442f59570@amd.com>
Date: Tue, 19 Oct 2021 14:13:11 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <20211019175050.934527-3-kent.russell@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: YTXPR0101CA0044.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::21) To DM5PR1201MB2491.namprd12.prod.outlook.com
 (2603:10b6:3:eb::23)
MIME-Version: 1.0
Received: from [192.168.2.100] (142.118.126.231) by
 YTXPR0101CA0044.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:1::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.15 via Frontend
 Transport; Tue, 19 Oct 2021 18:13:14 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8e2c05f1-8ca8-4a14-2042-08d9932c1e7d
X-MS-TrafficTypeDiagnostic: DM6PR12MB2937:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB29371B914B1C98484E5E442F92BD9@DM6PR12MB2937.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZDpyrAJ8bpTIhGJK3wL3Ph3xUuIJwcRGQY9zOaTMtFCWVsY0J5ySD/hYM3LT0OKIiHnTcH24WIdZgaUVxIhh65RJsSf/bqiMUyB/6VIIYVNrrO1SYjJa0SX3bUUINIc4poKTrR9gHExzdaHYXdvacqtlSdN/H5eyA6UEOdenBSeyS/vNtBQLszIsDRUmeiMHgqteujOueUFoN7RjDqSNClYw8LMwYmXuDjGFGCVIwfuldwsEWTb4d9hx6KfPXtGIe/hKxk557qn2vwHA+NS5xSqq7ZtVJoBHh0Gq9cFPfF+G1fursIwN55yrQ9riIAwsKrFJieXbkBpVeceRNNPW3TrEdLHVhyuGFGGM4ss5Fp5BHgh7x9ZU481ElZM7R7jlChFrszd1eY5B3KTgCbhix4URZw77bZ9h6c1jRQfhMNUoi5/WzCNFr5V2jtJq1nJ8tUU2wNrgL6Ev2S0w0QBMGQw+vDda9yxdTRPHc1lU9vplsgRBkC+NkMw9ybLLtl2uYeNswgFtk9lqrv0ROAUGSyTCWTXMyxg4emR0jvjtOu97bf6RHz8JOSePE5Yd9jjrk0DBGIobcaDKi85FWznwCO6Jk+cZ7oS95hYk9AXcOFTVMAATv8AJkBigUjN9hYuaAHKUYu70T65O8fLRLulUWIXgTPx7kz+sS8AG/6DESVkRydsuhAeGOtQKpxr0k77KFbdTvKzOfPAqJarFqdJVD7Z5VLKc5cwllsVtnxyuMRFzWMA/WXWAvF94jZoY6HAP
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR1201MB2491.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(86362001)(31696002)(186003)(508600001)(31686004)(956004)(2616005)(6666004)(66946007)(66556008)(316002)(83380400001)(16576012)(66476007)(8936002)(38100700002)(26005)(2906002)(6486002)(54906003)(5660300002)(4326008)(4001150100001)(8676002)(44832011)(36756003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OUVLTStUSXlMS0pzc01EWUNrWDNjZ1NlYkp4RmJnWGMzUDR4cVRNRDM4OWlK?=
 =?utf-8?B?VVkzKzJYZk80aXJLanUyQzNEMnFYZWsyL3VLTVVjL3l5SEZRYWNPTExmNmVs?=
 =?utf-8?B?UXBuQ2QvYXQ3dW9uL05CY3VuUGQ3VDhtcVowM0xoR1BvdElmWDZ3QXZYbWsr?=
 =?utf-8?B?anZ0WHkwZTJJY2gwSjRiS2s2OHVhWENsRFpFQnRvZjcrdithV2I1QWxQQXBJ?=
 =?utf-8?B?aVRZNXloejI5dk5LWEJKZ0tlcEhpYVNjZnpuMmFLdGxuVGtOZjg3aURRclR2?=
 =?utf-8?B?MVNFVVVNcXBFR0dvanV2NldpMkJwM0FCMFhOUmVQeTZyaGtzQXRXK0haWWxz?=
 =?utf-8?B?OSthbHNKOGdmaFZDTmtodWRCNzNicDBuTGVuNE1LMTlaMGZkNTk5Rk55bTVQ?=
 =?utf-8?B?UUg0b0NXL2cya0VXVXZ1Q2tlYzB5cXM1UHltYUZaUVUxdWpDbERBdm9hVURY?=
 =?utf-8?B?M1BmamRjWWJ0ZXl1d241OWFody94TXZmbnZFVHAwZEFFMHo3cnNFNkFhWDVh?=
 =?utf-8?B?c0ZYN1U4RmRqd2hxNG96SG0xcVZxM0djT2pDYk1YdzFDZFN4ejBFMGpUL1lU?=
 =?utf-8?B?cmpTVlpUWWxEdTlaMHFuanU1cDFGZ2EwbnVTY1pZR2twcExVMHNLeXpWVXdv?=
 =?utf-8?B?dmtGSHNHTk40bSt5ekg1ZnREa1BTWmZZcEZtcytWNHByRkowTENKRVUvZFZl?=
 =?utf-8?B?RmFLQTlxU1F3YSttU1lGaVVuenZIQTRJU2xiVDBLeEZmZksyaEhORzBZRDVN?=
 =?utf-8?B?clh5M0dFTUswWWUySS9taTJrb3NMdFJSenpYeFdRRWlsTjhIWDR1VVJEeVJi?=
 =?utf-8?B?eEFkZzhGbktSdFltcEJNbmpXcjNLUWtRaDdwbHpJNHZZUVhwY3NpN2ppMVZ4?=
 =?utf-8?B?UUsrbWFDVVFpdHNDRWFSV3JDd2xFSTRNTXBNb2xuTyt2OHJHaWRNQ1dFM0ZK?=
 =?utf-8?B?enVSTTRJeHNRUVQ5TDdlQWNxZS9FNXdTNWlRTUZFSFcxRUZCQTJuVnI4Ly9K?=
 =?utf-8?B?UzBQbEUxdFF2N0Q1MEc5YVhLM01WM3hoTlVnS3Nnd1daQzV4YWs2bWxkNkVx?=
 =?utf-8?B?Ti9vM1RzanJxbnIrcENyMUFwckd0WmpmNmd2OXBxVS9vY2tUcHlTMzU4Y1dt?=
 =?utf-8?B?UVY0YmF4b0JHeWtoNlRDNmV6T2FoUHpHZUMxOWs4TG4xVVUwZVc3RWM0MlQr?=
 =?utf-8?B?cks2UTJWZFhGWDVDWjVTYWlnalNQeXErQU5IeEZmeGJiM1BTSGtJVmQ1Wmp5?=
 =?utf-8?B?VklhMnVMUFNhTVFncDdvQ1NGdDI5RUhKMDBzZzRNUStQM1BQRkdMVGF5QXh0?=
 =?utf-8?B?a0FVd3Bka1UzYURrNW1BL1VUQjl3b1E0RmtMbE1LckorTGUzUlNPaGNyQTQ4?=
 =?utf-8?B?UVFmci9YZjVtZVZtdzZvaEk4akx0WEJ1ekVEKzA3V0xOYzF3cndFYnc4eGxm?=
 =?utf-8?B?ekh3L0g4b1lIaGtJY2pGb1Rmak5XMUtmdzZNZE1pMmVFaDJwbTFaanJSTEp4?=
 =?utf-8?B?SVRISFpZYk5KKy83K2UyOFhTcEM2Ykw1WUV0Tkd2ck5PUlZOclh3RDdIajJM?=
 =?utf-8?B?NzFyOFNhM2FKekFMOTdIOHNEaENRL2wzajRZdXdQUnpFR0l6TVhCZjMwY25S?=
 =?utf-8?B?Q3lqNkFyRHBxZUNxK3k3dnlXWVdpRGJHaGV0S1FtKzVvNW90SE5WYWFhL0xI?=
 =?utf-8?B?NlJ2d09JczZtTFRpNFl5QnJuTklnQTdpZXppRFBTYmtmKzJRVmltTUhJY1NB?=
 =?utf-8?B?WHBDQmNwY29KZzNXTUwwYWpQVXJqUEdlWGpIZ0lFK2pEVFh4aDhHalNWamFy?=
 =?utf-8?B?Ry9DQjQ0YzFnM1RmbS9PQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e2c05f1-8ca8-4a14-2042-08d9932c1e7d
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1201MB2491.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2021 18:13:15.0695 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LlV6NRSoXNQmbMguPFIRGwodAqE3qnWSG4VZirUGzc0OvBqGJ1Bq2vnsEsU/uU+eRAxJ2JVJkWn/WM//lT0jWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2937
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


Am 2021-10-19 um 1:50 p.m. schrieb Kent Russell:
> When a GPU hits the bad_page_threshold, it will not be initialized by
> the amdgpu driver. This means that the table cannot be cleared, nor can
> information gathering be performed (getting serial number, BDF, etc).
> Add an override called ignore_bad_page_threshold that can be set to true
> to still initialize the GPU, even when the bad page threshold has been
> reached.
Do you really need a new parameter for this? Wouldn't it be enough to
set bad_page_threshold to the VRAM size? You could use a new special
value (e.g. bad_page_threshold=-2) for that.

Regards,
  Felix


>
> Cc: Luben Tuikov <luben.tuikov@amd.com>
> Cc: Mukul Joshi <Mukul.Joshi@amd.com>
> Signed-off-by: Kent Russell <kent.russell@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h     |  1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 13 +++++++++++++
>  2 files changed, 14 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index d58e37fd01f4..b85b67a88a3d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -205,6 +205,7 @@ extern struct amdgpu_mgpu_info mgpu_info;
>  extern int amdgpu_ras_enable;
>  extern uint amdgpu_ras_mask;
>  extern int amdgpu_bad_page_threshold;
> +extern bool amdgpu_ignore_bad_page_threshold;
>  extern struct amdgpu_watchdog_timer amdgpu_watchdog_timer;
>  extern int amdgpu_async_gfx_ring;
>  extern int amdgpu_mcbp;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 96bd63aeeddd..3e9a7b072888 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -189,6 +189,7 @@ struct amdgpu_mgpu_info mgpu_info = {
>  int amdgpu_ras_enable = -1;
>  uint amdgpu_ras_mask = 0xffffffff;
>  int amdgpu_bad_page_threshold = -1;
> +bool amdgpu_ignore_bad_page_threshold;
>  struct amdgpu_watchdog_timer amdgpu_watchdog_timer = {
>  	.timeout_fatal_disable = false,
>  	.period = 0x0, /* default to 0x0 (timeout disable) */
> @@ -880,6 +881,18 @@ module_param_named(reset_method, amdgpu_reset_method, int, 0444);
>  MODULE_PARM_DESC(bad_page_threshold, "Bad page threshold(-1 = auto(default value), 0 = disable bad page retirement)");
>  module_param_named(bad_page_threshold, amdgpu_bad_page_threshold, int, 0444);
>  
> +/**
> + * DOC: ignore_bad_page_threshold (bool) Bad page threshold specifies
> + * the threshold value of faulty pages detected by RAS ECC. Once the
> + * threshold is hit, the GPU will not be initialized. Use this parameter
> + * to ignore the bad page threshold so that information gathering can
> + * still be performed. This also allows for booting the GPU to clear
> + * the RAS EEPROM table.
> + */
> +
> +MODULE_PARM_DESC(ignore_bad_page_threshold, "Ignore bad page threshold (false = respect bad page threshold (default value)");
> +module_param_named(ignore_bad_page_threshold, amdgpu_ignore_bad_page_threshold, bool, 0644);
> +
>  MODULE_PARM_DESC(num_kcq, "number of kernel compute queue user want to setup (8 if set to greater than 8 or less than 0, only affect gfx 8+)");
>  module_param_named(num_kcq, amdgpu_num_kcq, int, 0444);
>  
