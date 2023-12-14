Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA96DC4332F
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Dec 2023 19:03:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3228310E218;
	Thu, 14 Dec 2023 19:03:14 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eae::600])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 411EC10E977
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Dec 2023 19:03:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ld5b3RIaswX5+I0RuUKUEBrarVnRTFXNqg5EhXkmOcEF0V8rHucLpQ1UET8u0O6cCIfjbd50y3WaQtmTIjvOQ0hN2p9bQJGINuviNsx1igiJ9stHh7qcO9BeUV0kr541ld15N79IiGfM4szGLc8O/v2vhzPYkWUVLAdOBkVLzD9TM27CDnQ2T3YPW8vNlXpzoYrNd2aJrOfM6jWkkOxD8WJkuDJIRtWxl9x/OKUolxfEfhwqa8WwpReIMAf4rntmaSQCxMzVHLttJBJCfJfMG7gGM3VyktOX+MAM5fOKLhdXs/blUkAQTlbFMNTATwCJavR8eoq9qp5V7JDG5qyCSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mAOYw3fMNL6Y8l5V+18afdTWd91ktGOU5hy6N38QRuI=;
 b=iLAs8yTSYqbubeTITvWS6ATenbrpa+d29OzcoFtcCYB66PGKcy3pYviB6lrFY4WDvhSAqNAsiDcVYGR6PdtI0JtVKahYgTN/wtqDBxVvHbXEEk8XDhLVX9zs7PvU2VxII3yYwhx28NfawgsHqoeSOmcAWnbU+CavbJQwVYgsI1jedARW/duyQV8BsU+PUM4UzpKfhTtGsRxCR/MiKZdPK+04h8ufYw1qCBJi/IWeGWfaMZ6yUZQGVBOto0XoJOKM1+oB6kN+IpTB6ozc0nY6GSuP2+CCderSXmanTJi7znc1MNrx8BlXxnfscIgug/uPqT85HxXuxkY42lPCtzgD/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mAOYw3fMNL6Y8l5V+18afdTWd91ktGOU5hy6N38QRuI=;
 b=iC4dUrZfXvFWypb/p8P8hO6fCS2gasDiNqlgQRCoIskC+F9eShrIhegGo0JpFkwvE0Hkn9CIuBnubxnNFJJL1+O1K+e3o9mqSBjLcosrIQ56Xat8N1PV3GNw59DiucqeOTlMQXFi3wrbAmXQbKi6SqJY7aDCZJW2I8QDzI4vSMg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5336.namprd12.prod.outlook.com (2603:10b6:208:314::8)
 by SA3PR12MB7806.namprd12.prod.outlook.com (2603:10b6:806:31d::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.28; Thu, 14 Dec
 2023 19:03:02 +0000
Received: from BL1PR12MB5336.namprd12.prod.outlook.com
 ([fe80::7ef6:8317:95ab:ce40]) by BL1PR12MB5336.namprd12.prod.outlook.com
 ([fe80::7ef6:8317:95ab:ce40%3]) with mapi id 15.20.7091.028; Thu, 14 Dec 2023
 19:03:02 +0000
Message-ID: <c3920def-4c50-4c74-b376-dcb66ff46092@amd.com>
Date: Thu, 14 Dec 2023 14:02:59 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: only flush mes process context if mes support
 is there
Content-Language: en-US
To: Jonathan Kim <Jonathan.Kim@amd.com>, amd-gfx@lists.freedesktop.org
References: <20231214031939.93942-1-Jonathan.Kim@amd.com>
From: Eric Huang <jinhuieric.huang@amd.com>
In-Reply-To: <20231214031939.93942-1-Jonathan.Kim@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR01CA0160.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:7e::29) To BL1PR12MB5336.namprd12.prod.outlook.com
 (2603:10b6:208:314::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5336:EE_|SA3PR12MB7806:EE_
X-MS-Office365-Filtering-Correlation-Id: 679aa3e6-2513-48df-ecf8-08dbfcd74bb7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iV7FhR7QfGSQ77PmYE+8j5ftyEavi9Fhcwvuv4erChxLf5/gDNAcMrolqhniFPP8qdU0Zki5jO6gOTviZPsaBds1LBV47KHrqiHv8hB0t0jvt109ckDSm9JDLW9zqz5tT5xiwuPHrZQQQUoHFmK6Lf8PwxlIlHiqcm5XFkZ9xgwGVc8tQZaAZHxXuI53A8K/ozcBaG39v8TMS44IAKLAHsTkhSEfqHODlI5VbM6N6Tdsr14BCl5x/OvCQYLM9BjrNox9vjXeS2fHe+scCa6S4xCZkjpymbDa9GkmajrVCC3ER/Y2TJsGQDJ5Mf3DcDqhzPxT6Gak8Vmt+dg2jLdiXxj45xS8p80mCQL6UmSst3HkMfvp+45SxIEUk08z8c7+o6uLYjOqbXNhN+Ol1n7tvI4XckNqmLQqEnaQTicRf8vKfLFSsZZ66PgHAQuVyNBTT0fNhsLkKaHJCOobuR8Izp3ISSaJ/nMnoJ0YfawuOfxs4HaTY8v0VNTTNDKROxXi8/yh1r8KXEyBPnrle7WRAEHPSFyP6YeFyJ3po6qL86Lc6HZ8TFqcA2DkqaRFaMV96NMSFH5dBAq+WRW27VwnfotAqodNmtCd77LBJGq4DoHsNlIQPSN4XQ5Fs9VfGFWnQlQpqzttLSGwFZaANAhy+g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5336.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(366004)(346002)(376002)(39860400002)(136003)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(86362001)(38100700002)(8936002)(8676002)(2906002)(5660300002)(31696002)(31686004)(83380400001)(53546011)(316002)(26005)(2616005)(4326008)(66556008)(66476007)(66946007)(36756003)(41300700001)(6666004)(478600001)(6512007)(6506007)(4001150100001)(6486002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TGo4RlE2NDJmZzlndHMzZnFLVmFFd1RBOElOeW5sN3RLcXEwSzRiYnN6L21i?=
 =?utf-8?B?Y0xtY2F4VElYbEZ4dG9TNjcrTTdUbzRUcncwVU02VFlaZlpSU09wWlEzQVo4?=
 =?utf-8?B?V04yUG5rWWpxN0NReElJWVhZdnI3Q3hNWk5rNC94ekE4Y2grNlo5cldvMVhS?=
 =?utf-8?B?SFlra1RnOWo4K210QzlWczEwbzc4b25pdGc3S1J5b3BPOUI0dzdGaFJZSW1h?=
 =?utf-8?B?ck1LZ2RHNnhXcFcvKzU0KzVaY1RTNTVYQmFCdFZjNmtOQjJtaFJWYTFVM09J?=
 =?utf-8?B?ckhGeVo4TnN4ekRuSjlmY1ovcHN1b1VNUW9MTFJ4L0RzUGFVNGw1bFRIOER1?=
 =?utf-8?B?SmIxMkxLNWtSb29vN25qSGUyZFNVUzdhQzZzWWM2RkYxaWhhMHpjNnN0UmNr?=
 =?utf-8?B?SVpxVXBXRE5yNlhtNjNPT3Q5djNRbEc0VzJ6M2JXTU1nTE4weDJPMjdlenRm?=
 =?utf-8?B?eEVwRTE0NURJbEtJSG50djNxZUxGRzJkak1hT09pMUNldlM1bXVVTFdjMHFL?=
 =?utf-8?B?S0N1TkNlMi95U1U0eXdyeU40ODRIWlVQRmthaGNGdEFwckI2N2R5RUZhOTVh?=
 =?utf-8?B?SERuS0REdU5pY2IwVGdqUEw0VTRUK0xCemZoQUNEU1pqMWVxVlRGQy9kUVB5?=
 =?utf-8?B?UVJaa1p0TFVHT1o3RVZWRHZ5c0dRQTlrTUZ2bVV1eGFPYU9PUDIxNk5uc0d5?=
 =?utf-8?B?VUkyaGI5UnFmMlZmeGY0Y0tsNGo3VmNXV0lVMUwvSG5UUU84NFc2TkMrdDI1?=
 =?utf-8?B?RUtab1g0WEZ6SGhjVGhuSXNuUFVuQUJRV296VDZHRzFUSWM1VGZtYWZKSEpH?=
 =?utf-8?B?WHhVNVovNEo1bjQ4S2FURTNER0JnTllGZEpmNTZTQU5vSG95TFlkM3AyM2Fo?=
 =?utf-8?B?S09TOEJHbnFmSnR2TVB2VU41WnVrZnRQWmcrMndPTGF4UGNod1hiaExya1Bv?=
 =?utf-8?B?Qkowc2lISFBKZzVWalMvRzVpdDRMSnJEWmF5T2tOaFFZQXJJSEl6TXpBUll3?=
 =?utf-8?B?WmtETk8wSU1uMkFzWVlSSGRZRE92T2d0aXR1NS8zaW1ZZHF2QWxoQmJjOXBR?=
 =?utf-8?B?K3c1aEVrUFVWcEpCenRWREQxNzdiTWhsSEFDaDAxNEt2T3RkemxnR1FCbkVQ?=
 =?utf-8?B?WVdicnZ3b2V2dExZQUU0K0h2ZWRwMVZLN3JXV2xsdmI3WVBiY1hsZVhnWjhV?=
 =?utf-8?B?dTlPa3orWmNHN01MenQ3UXJVSGlWeHJFWWhueHNIVWdHdVRqTTlnTWtrT1J1?=
 =?utf-8?B?eFNWdHlTcWZ5dmh5a0FDUW51ZXBFV2dmMW5BbHNLS0V0WVJ0R2taL25pUWVz?=
 =?utf-8?B?VWdJVDNORnpNZW91WUpkRWp1d0d6bVR0V1dyc2pUNEt3SEFtVzZLQkpialJo?=
 =?utf-8?B?R0NQOE9VclpQUmQ5bnBVZkdCdE5hZUtjYnFaYnR0bzZNTjh5OW5GSlJDajI2?=
 =?utf-8?B?R0hkVm03MStRTlU5RHYrYU90RzdoeHBsajNRWjJEcDRERGI1dTQ2SjJZUytS?=
 =?utf-8?B?SWl6VFc1c1ZPbm5RT2pWTDFhVUhLODJhVjNVT0hsN2R2SmVIazNrNVM5ZW0x?=
 =?utf-8?B?dS9TdnNvNHlWRS94Z09VVEdqL0dZY3dycTBVdjEwZzRPaldqUTluTWxkRGZz?=
 =?utf-8?B?OFk0SFpobWFiZ3A5cklDZ1pkSjM5dnJ6cEhsYW1KSERWZ09HWVRBendaN3hB?=
 =?utf-8?B?S2hBSHpIVVhmQTNnUTFKcHJnU0JOKzdGQ1ZBdVlBWXBRSy9LOFpYRGNkMThX?=
 =?utf-8?B?dHBDNHJjOStZaVc2ZHBIeVBuVEN1K2hBMDhZM3RJckNlL1oxbWlldXRUUVI1?=
 =?utf-8?B?cjJmNlFQRWZEUGVReE50cFdoNW1KbDhqK0lOem5BN2RhaXlrVW1VVXV4Zmhm?=
 =?utf-8?B?ckFqT1ZMWXNnWHVxejVMYlE4dHhkL3NuSGw3WklieXVZZWdydDlIRVZiWU1l?=
 =?utf-8?B?RUdUSHl6QzVtOVlvbDV2a1VCTW9HYm55VWxNNkgxMStnYVZMMXh5YVdOK0dr?=
 =?utf-8?B?TXhHbStuQnAwLzlxK1cwQkN5eStMb0VtZVZFdG9WNzhQTklwUUwxVGE2QXdI?=
 =?utf-8?B?ZjNOekFFNEluYUJJZVlnWkdMc3NjUlg5ZkFVbXRMQURnbWFqMEMyWXgzOGhJ?=
 =?utf-8?Q?R0bRDKHpRuFFPSoNEpXE500a+?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 679aa3e6-2513-48df-ecf8-08dbfcd74bb7
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5336.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2023 19:03:02.3471 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CSaYAnRGZeyq5EkEn93IQYAPbg9+jV4Xwey4TGkO1WM9St7GJnJDJ207nWWmuHQOsyeQX+PAY/itCPTC35dZMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7806
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
Cc: Shaoyun.Liu@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 2023-12-13 22:19, Jonathan Kim wrote:
> Fix up on mes process context flush to prevent non-mes devices from
> spamming error messages or running into undefined behaviour during
> process termination.
>
> Fixes: 73204d028eb5 ("drm/amdkfd: fix mes set shader debugger process management")
> Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
Reviewed-by: Eric Huang <jinhuieric.huang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> index 8e55e78fce4e..43eff221eae5 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> @@ -87,7 +87,8 @@ void kfd_process_dequeue_from_device(struct kfd_process_device *pdd)
>   		return;
>   
>   	dev->dqm->ops.process_termination(dev->dqm, &pdd->qpd);
> -	amdgpu_mes_flush_shader_debugger(dev->adev, pdd->proc_ctx_gpu_addr);
> +	if (dev->kfd->shared_resources.enable_mes)
> +		amdgpu_mes_flush_shader_debugger(dev->adev, pdd->proc_ctx_gpu_addr);
>   	pdd->already_dequeued = true;
>   }
>   

