Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BD35CD343F
	for <amd-gfx@archiver.kernel.org>; Thu, 21 May 2026 06:37:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1629D10E473;
	Thu, 21 May 2026 06:37:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fFDxhTi3";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012027.outbound.protection.outlook.com [52.101.48.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9B54410E473
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 May 2026 06:37:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jdqOGvKEmcsnzHugPlnzZBjxroUfpCzqe452qt6tthUfVg6ZACXuHLwJRa8ZaUtZATlIU6De5/Jy1foDTHaOLLJiIj3Rlx74CYqADbq8WC8YiSr4MfJXmLYr7cYqrC3jYvP21ZeupBqo/A1b1w0iqn47BpjFYndicgDGG8PBxZDRRIxNuQnGZ+WQh12FHbGlhitZWwpiI3assPSXOiBBZaip/+xGG7zC7a+WDNVYCUWVG8uyG5xMnGA1lrt29iMtfBwqYarMq/HWNaGOAd7EHY37GE4jpnlboflPeQAVGWk8gJNtJHWm0cahkE1WZDQXkP3RFv897DVVJLWm/ka0ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3+QOJJE6/U2iIz31CL6WIYDKN5cpSiJExprOajVoHUI=;
 b=KAoCdK8pbv1vzx75ngvjkXZslRpcLlX4K6cfcjWciJi+V1EizD1nakgiWIhoPFDZkODKaOFgtQlPCJKMaNF1grtyuJD+Cr7K2zA0m6XUkUFz/dEF9fUlRUpX8I7riu2S+QBVHUMVJIOFhYrFM7MytzjcUVp7pUwYx9YUjlWR7ujDpQyy1WboeRGcPlsfWM6oogUldKDqgNTBQxWZlA/8i/DmJSMoZ3mdHX6dSF0hweT8fXRwY+4LsoVOX68yF14ljsaG5+vJDDZZr0uHH+p0ITZ6sJ9+JmA/4KqGBm1IkCSvSEUzhpClGSfPW6waTXr4e/RXL7WODSk3eaR+KbB2/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3+QOJJE6/U2iIz31CL6WIYDKN5cpSiJExprOajVoHUI=;
 b=fFDxhTi3JCIZDpOWcA9uAX/OBMUdM+MbaZ60vRVlYWWGsgTR3Ck+kEtwL3HX7KKclqE+6zTeo8Cmc57AjtHGDg+LMkR0Dtj3n6yZnF9ncTeYwVI3AqQtyQqLoQhKKpq900a02K0ILqE0hn8cfdS1QlxwuDck8tMCbg9Mz/dgM0c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by DS7PR12MB8321.namprd12.prod.outlook.com (2603:10b6:8:ec::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Thu, 21 May
 2026 06:35:12 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%3]) with mapi id 15.21.0048.013; Thu, 21 May 2026
 06:35:12 +0000
Message-ID: <733037e6-8132-420e-b2f2-3b695f9a2ca3@amd.com>
Date: Thu, 21 May 2026 12:05:05 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdgpu: add ioctl to handle RAS poison error
To: "Zhang, Yifan" <Yifan1.Zhang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>,
 "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "Yat Sin, David" <David.YatSin@amd.com>, "Russell, Kent"
 <Kent.Russell@amd.com>, "Yuan, Perry" <Perry.Yuan@amd.com>
References: <20260515132702.1494187-1-yifan1.zhang@amd.com>
 <adc4600a-1d3c-4e79-9b6e-2e433bb3223e@amd.com>
 <CY5PR12MB63696C68EA513F50DD4C1226C10E2@CY5PR12MB6369.namprd12.prod.outlook.com>
 <d706a70d-8b8d-4076-9bcb-e29c770c5c35@amd.com>
 <CY5PR12MB6369F10CC121FE8FBB7975B9C10E2@CY5PR12MB6369.namprd12.prod.outlook.com>
 <f88a7428-0296-4493-a8e6-45592e910f0b@amd.com>
 <CY5PR12MB63690B697847B06C254D58EBC10E2@CY5PR12MB6369.namprd12.prod.outlook.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <CY5PR12MB63690B697847B06C254D58EBC10E2@CY5PR12MB6369.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0123.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:11d::6) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|DS7PR12MB8321:EE_
X-MS-Office365-Filtering-Correlation-Id: c98d07d8-7c93-4be0-ccf4-08deb7031c3e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|18002099003|4143699003|22082099003|56012099003|3023799007|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info: WUcpQlTrKRlK+j5Ob4eGilHgL4WNy00DY5CWKJl+uXZ7Dnd93z+8nL1gVlzJmydscw2FJiiTxt6hv3MRZPm2XkMDR5yzinrD314V3w+u0+44r7LpMS8PX9VNoJPwNVkBMWWW3PJz29T1w552M41Ytm8PJSvFI/XI8oyyhUGf0z/KTeG6pCm0iSSPInQVLGhSXlovfEYLJGKlCoDpr7V3uyCCxv0VWGlPIAkgcHtH0ny2fQOkHntVMQMAwVMptx5TRjeKA+CKeO6t30xj96MlJTyLK3AUixUPN1mCiIc/Se0llGyzUPnuy3u6O+nC8FXlp2QwbOJADN1d/etAhJ/KwArZjtOfMV0X1/qPum9KCG3HADrTrrjeUIS5cT0/BZsIzN2nSgHxp1YDo8FfyQvZjDpq0TscGs++VqwL6w5TZcLRrbh3hHPpBPslHY+vdPaGAa5l9hoakGhE79CxmTYYuVefNOfOL3GtQfr/oa48czvmV26C+rgNfQoS50tt74u9O5f/E+w3J9qfCp7g6zIv75RojwRgB6c6m9WKyAkrefoArmd1KFFGESkQ73Jq4xYIYMTq3L1u1W9hk95dYj7KFBO7oUKbOO3cOTl/+bJaGDumbGRGa69FCZgCb40RVozsOLLT5on9yTzKvqgFymZGL/e3nrzRdlRvRnHZi8UTtJ3PUZJae5uyvcdu8D4neYlb2hs8+dacwPx1kqZmE4AvMA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(18002099003)(4143699003)(22082099003)(56012099003)(3023799007)(11063799006)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NGJLTDZOQlhraGt3L1JNem9za0M5L2lwRWdKWlh0M093ZjJsUDFWaklCbVJQ?=
 =?utf-8?B?c0FjbVdhZ2JmeHlTZ0hLeGR2U2hud05ja2ViNDk0VEtRTlJMcTg0VGsrZEVU?=
 =?utf-8?B?SnErREtZakM4NFdlblFhM1JYK0N3VHI1YmVjTDl5ZXRlWm9JMFNSVmFNUU44?=
 =?utf-8?B?L1hjWERYR3k2QmlkRVJEYWdTRmVOZWVTOURqbE5pTGphV1QyUm5LbHYwRVVm?=
 =?utf-8?B?OEJmdVJGS0c3d3NpRHhYQ2drckdZQXAzZlBOd1l4K1owMXBWQm9JRjZVcFZi?=
 =?utf-8?B?NS9WOGJWOU5SVjc5dXN2ZFk2WkdRbkJqUU9qaGU0MWtSTlYwWkhzaW9waUFD?=
 =?utf-8?B?YW1Ka2ZJM0JhaXA4dVdDZitNREpsQmlpcEl3Mkppc2luaXFBNDltRW5VY3F4?=
 =?utf-8?B?WjJUZE1wSG53dmMxME5kci9JaTJaVmNCQ1ZhUzhSMnhWNjlHYmFVWmxOTlFn?=
 =?utf-8?B?Y1h5VEwvR2NGcVFFYnlmWU1sZlM3SVcrems1YThaMTgvcGRMUXVlS0NXVkMr?=
 =?utf-8?B?TmtBYm5hYXEyMW4xUE1IeXBNRlhIdDlvZStRaC9aR2hybVJBYUR4SVFJdGFv?=
 =?utf-8?B?TUw5Y2cxZjUrem5rQ2dyRUtpUm5jTE9MNVpMcmFGUXYycGRsQSt3RC81NUQy?=
 =?utf-8?B?NjB2VE1rWE9KSU5ad2Zyc0VmTW5VY1ZreDhSdnJKUTVsN05qNHpYdnVPSkhx?=
 =?utf-8?B?TlEzRXFTeSsyenp0N2U5b1psaTdmbjRZWDE5ZEgrK3k5aDdrMkdwWUZhVUVx?=
 =?utf-8?B?bGlad2dNREVGT3pYM0c4UWVLMVkra2h0Tlk5Q1NKaWNMUFJ2LzZIUVBYOU05?=
 =?utf-8?B?Y2hVa25YZXR1RVJycXRjRWZBQmZGNkpPK3F1RzRoaUQ5WjJVazlHVzNPbGJ4?=
 =?utf-8?B?M2xCMEdyYXVsTnpTTnFVeVVMbVJYbXFpUEVCcko4Yll3blphb2VLQ01PRXFp?=
 =?utf-8?B?dUM0Z3c2amFBcE5jZXpJZVpSTjZ3RFJFYzNyYk02L1ljN3FmbmVYSUx6YVVz?=
 =?utf-8?B?VWNucVh6YzdKME5OUy82WTRzMlZka0dzOW1SNmIyREU0b1UrVFZSNmRlbzkr?=
 =?utf-8?B?TjZuNm5RdEJHZnJ4Z1ZVeDVyTTNjUzlmMTNUNWY5QmNBRlVXZkptOThTZ2hT?=
 =?utf-8?B?TW53MXdiTUNoZWxha0F3c01WaC92T3hkeUNjK3dsWnorb2oyeWJXVnFja25k?=
 =?utf-8?B?Tjc3R3pLRUNMMGowdFE1Q3ZSZ3MxM1hGd25tZE9uV0hwbUtZYzM3bENoRkZW?=
 =?utf-8?B?Q1lkSXlaVzdiS21yS1J0N0p6OGY0cHY3Rk5QN1g0SVU1RlIxRlMyT2pFSURD?=
 =?utf-8?B?WmNjUTdIYkFya3ByTGVCRkRPL3RBOXEvSkFpelNMOHkyTVBsTmdhWThwaG4r?=
 =?utf-8?B?MVNNdjhvOExxdUZuaFpBeEp2NEp2YkhCRzZ6cWtRek41TVQrZHU2SHVJSW8z?=
 =?utf-8?B?Qk14N1BqUDZWR0h5NHpHV0dKZndNMnNNS3BXcWtoUkhTVU1HN0U2NVhGUWRK?=
 =?utf-8?B?MURyTW1HdmtwQ2RkYjQ5QStIaFgyOTRIOGZTWGd2RjlpZ2l5RVdLS2h3Z09K?=
 =?utf-8?B?Vkd1VGJhaGw1VnBTa0dodzNhNzdjVWcvNE5oaW0vVDB2aHA4Zys3ZDJjT3Q2?=
 =?utf-8?B?R0RObkNWUDFjbE9UWGZncUNTeHlqbnVWaGJnYTZKdXN2dC9vV3Rwa2xzVU13?=
 =?utf-8?B?WjR0dW9ocEo0N3VRWFF4V1Z2aTVHVGZCZVVhL0Z3Q0EzSVFDRm5EQ1pFbTdy?=
 =?utf-8?B?V2hxeGlFMkhvb2ludHJZWGhvc1ppc0tkRmpCbGdTb3hXTzY3VWtKTzh0ZXZT?=
 =?utf-8?B?ckZFNVJoWkpvUmxmYWlDYWVvNTFrckFVT1lNUGk0d0tnMkF3VlpTVG9lWExJ?=
 =?utf-8?B?SWRBeGdnU0dISXZOOHJMQTlSMldmaHB0WnN0bmZNdGl2cEhVSHlyMUdnRXdH?=
 =?utf-8?B?cXNZWVBJQkFnczRsZlU1Yk1RdUlNNysvVG9SOVgzd1o2SVM4WURMSENEcVNQ?=
 =?utf-8?B?VXRYcmRMb2l4NERvM2Q3ZGJKdHhYRHN0UDNRODhydTdXN253MGhseG1COHpF?=
 =?utf-8?B?WWlST1dGaGdHSGFscDFmenkvWEVJa2gxWGRFV1FySWc5MzdBN2ttUTRYM3JS?=
 =?utf-8?B?Tk8yVmo3Tk80NFpXMEs4TXh5SjJEemU4eG9GaVl0aXFrRDZlRm5mbUZSdnNi?=
 =?utf-8?B?NjdPMFNydnNabDRXc014SW41OUlUYkZ5NWExZXlUTW9SM0pTYWJERjg0b2Z5?=
 =?utf-8?B?cGRMU3ZNZVozVitmZEhoZlc4enhsRmpPNldPWlRJLzVQZDZQM2hMRjF3a2g5?=
 =?utf-8?Q?I2ngi6QJKMqTFwYL7p?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c98d07d8-7c93-4be0-ccf4-08deb7031c3e
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 06:35:12.2221 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9TGzohK3uhOirwgk6G0XfPS34qZyJPQJj4zVPUBBgih1ZR0tzOJbfx+uC02ynFIb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8321
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



On 21-May-26 11:39 AM, Zhang, Yifan wrote:
> AMD General
> 
> But we need a per device storage for each process fd and iterate them when RAS poison happens, right ? Would you pls give a example of the data structure you are proposing ?
> 

I see it as a property of the process, just keep it within the process 
structure.

Thanks,
Lijo

> Best Regards,
> Yifan
> 
> -----Original Message-----
> From: Lazar, Lijo <Lijo.Lazar@amd.com>
> Sent: Thursday, May 21, 2026 2:03 PM
> To: Zhang, Yifan <Yifan1.Zhang@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>; Kuehling, Felix <Felix.Kuehling@amd.com>; Yat Sin, David <David.YatSin@amd.com>; Russell, Kent <Kent.Russell@amd.com>; Yuan, Perry <Perry.Yuan@amd.com>
> Subject: Re: [PATCH v2] drm/amdgpu: add ioctl to handle RAS poison error
> 
> 
> 
> On 21-May-26 11:12 AM, Zhang, Yifan wrote:
>> AMD General
>>
>> Yes,  the mux of per device delay time happens in kfd_get_sigbus_delay_ms.  But we still need some per device storage to store all the delay times.
>>
> 
> Which is why I said it doesn't make any sense as the signal is sent to the process and not at a device level. Also, in XGMI systems, a poison error could affect all of the devices and the intention of the signal is to prevent propagation/consumption of bad data.
> 
> Thanks,
> Lijo
> 
>>>> +/*
>>>> + * Resolve the per-process SIGBUS opt-in setting by scanning all of
>>>> +the
>>>> + * process' KFD pdds (each backed by an amdgpu render fd). Returns
>>>> +the
>>>> + * "most lenient" value across all fds, in this priority:
>>>> + *   DISABLED (no SIGBUS)  >  any non-zero timeout  >  0 (immediate)
>>>> + *
>>>> + * Rationale: if the app has explicitly opted in on any GPU it
>>>> +uses, it
>>>> + * wants the chance to handle the error in userspace.
>>>> + */
>>>> +static u32 kfd_get_sigbus_delay_ms(struct kfd_process *p) {
>>>> +     u32 result = 0;
>>>> +     int i;
>>>> +
>>>> +     for (i = 0; i < p->n_pdds; i++) {
>>>> +             struct kfd_process_device *pdd = p->pdds[i];
>>>> +             struct amdgpu_fpriv *drv_priv;
>>>> +             u32 v;
>>>> +
>>>> +             if (!pdd || !pdd->drm_file)
>>>> +                     continue;
>>>> +             if (amdgpu_file_to_fpriv(pdd->drm_file, &drv_priv))
>>>> +                     continue;
>>>> +
>>>> +             v = atomic_read(&drv_priv->kfd_sigbus_delay_ms);
>>>> +             if (v == AMDGPU_USER_OPTIONS_KFD_SIGBUS_DELAY_DISABLED)
>>>> +                     return v;
>>>> +             if (v > result)
>>>> +                     result = v;
>>>> +     }
>>>> +
>>>> +     return result;
>>>> +}
>>
>> Best Regards,
>> Yifan
>>
>> -----Original Message-----
>> From: Lazar, Lijo <Lijo.Lazar@amd.com>
>> Sent: Thursday, May 21, 2026 1:31 PM
>> To: Zhang, Yifan <Yifan1.Zhang@amd.com>; amd-gfx@lists.freedesktop.org
>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
>> <Christian.Koenig@amd.com>; Kuehling, Felix <Felix.Kuehling@amd.com>;
>> Yat Sin, David <David.YatSin@amd.com>; Russell, Kent
>> <Kent.Russell@amd.com>; Yuan, Perry <Perry.Yuan@amd.com>
>> Subject: Re: [PATCH v2] drm/amdgpu: add ioctl to handle RAS poison
>> error
>>
>>
>>
>> On 21-May-26 10:53 AM, Zhang, Yifan wrote:
>>> AMD General
>>>
>>> The signal itself is indeed process-scoped, but the policy is naturally per-device, because the poison event has a dev associated with it. ROCr already holds one amdgpu render fd per device, so attaching the option to amdgpu_fpriv lets the app configure each device independently with the handle it already has.
>>>
>>> E.g.
>>>
>>> Device A is driven by a worker that has its own RAS handler: set DISABLED on fd(A).
>>> Device B has no special handling: leave default / use a 10s safety timeout on fd(B).
>>>
>>> Storing a single process-wide value would force the app to pick one policy for all GPUs it has open, which doesn't match how ROCr layers per-device handlers.
>>>
>>
>>    From a process's perspective, what it wants to do - isn't it to delay the signal if any of the devices it uses gets into poison error situation and buy some time to clean up?
>>
>> Thanks,
>> Lijo
>>
>>>
>>> Best Regards,
>>> Yifan
>>>
>>> -----Original Message-----
>>> From: Lazar, Lijo <Lijo.Lazar@amd.com>
>>> Sent: Thursday, May 21, 2026 12:35 PM
>>> To: Zhang, Yifan <Yifan1.Zhang@amd.com>;
>>> amd-gfx@lists.freedesktop.org
>>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
>>> <Christian.Koenig@amd.com>; Kuehling, Felix <Felix.Kuehling@amd.com>;
>>> Yat Sin, David <David.YatSin@amd.com>; Russell, Kent
>>> <Kent.Russell@amd.com>; Yuan, Perry <Perry.Yuan@amd.com>
>>> Subject: Re: [PATCH v2] drm/amdgpu: add ioctl to handle RAS poison
>>> error
>>>
>>>
>>>
>>> On 15-May-26 6:57 PM, Yifan Zhang wrote:
>>>> Add a new DRM_IOCTL_AMDGPU_USER_OPTIONS ioctl with the
>>>> AMDGPU_USER_OPTIONS_OP_KFD_SIGBUS_DELAY option, allowing userspace
>>>> (ROCr) to control per-process SIGBUS delivery.
>>>>
>>>> Userspace for this can be found at:
>>>> https://github.com/ROCm/rocm-systems/pull/6148
>>>>
>>>> Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
>>>> ---
>>>>      drivers/gpu/drm/amd/amdgpu/amdgpu.h     |  12 +++
>>>>      drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c |   1 +
>>>>      drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c |  29 ++++++
>>>>      drivers/gpu/drm/amd/amdkfd/kfd_events.c | 114 +++++++++++++++++++++++-
>>>>      include/uapi/drm/amdgpu_drm.h           |  25 ++++++
>>>>      5 files changed, 179 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>>> index 5d7bfa59424a..6a5459b59af2 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>>> @@ -455,6 +455,16 @@ struct amdgpu_fpriv {
>>>>
>>>>          /** GPU partition selection */
>>>>          uint32_t                xcp_id;
>>>> +
>>>> +     /**
>>>> +      * @kfd_sigbus_delay_ms: Per-fd KFD SIGBUS delivery option (set via
>>>> +      * DRM_IOCTL_AMDGPU_USER_OPTIONS / AMDGPU_USER_OPTIONS_OP_KFD_SIGBUS_DELAY).
>>>> +      *
>>>> +      *   0          - send SIGBUS immediately (default)
>>>> +      *   0xFFFFFFFF - suppress SIGBUS delivery
>>>> +      *   other      - delay SIGBUS delivery by this many milliseconds
>>>> +      */
>>>> +     atomic_t                kfd_sigbus_delay_ms;
>>>>      };
>>>>
>>>>      int amdgpu_file_to_fpriv(struct file *filp, struct amdgpu_fpriv
>>>> **fpriv); @@ -1467,6 +1477,8 @@ int amdgpu_enable_vblank_kms(struct drm_crtc *crtc);
>>>>      void amdgpu_disable_vblank_kms(struct drm_crtc *crtc);
>>>>      int amdgpu_info_ioctl(struct drm_device *dev, void *data,
>>>>                        struct drm_file *filp);
>>>> +int amdgpu_user_options_ioctl(struct drm_device *dev, void *data,
>>>> +                           struct drm_file *filp);
>>>>
>>>>      /*
>>>>       * functions used by amdgpu_encoder.c diff --git
>>>> a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>>> index 99688391e70b..cad18bd6f8b3 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>>> @@ -3078,6 +3078,7 @@ const struct drm_ioctl_desc amdgpu_ioctls_kms[] = {
>>>>          DRM_IOCTL_DEF_DRV(AMDGPU_USERQ_SIGNAL, amdgpu_userq_signal_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
>>>>          DRM_IOCTL_DEF_DRV(AMDGPU_USERQ_WAIT, amdgpu_userq_wait_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
>>>>          DRM_IOCTL_DEF_DRV(AMDGPU_GEM_LIST_HANDLES,
>>>> amdgpu_gem_list_handles_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
>>>> +     DRM_IOCTL_DEF_DRV(AMDGPU_USER_OPTIONS,
>>>> +amdgpu_user_options_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
>>>>      };
>>>>
>>>>      static const struct drm_driver amdgpu_kms_driver = { diff --git
>>>> a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>>>> index 24526e92f9b8..7903587b8bbb 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>>>> @@ -1423,6 +1423,35 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
>>>>          return 0;
>>>>      }
>>>>
>>>> +/**
>>>> + * amdgpu_user_options_ioctl - set per-fd user options
>>>> + *
>>>> + * @dev: drm dev pointer
>>>> + * @data: pointer to struct drm_amdgpu_user_options
>>>> + * @filp: drm file
>>>> + *
>>>> + * Sets options stored on the per-file amdgpu_fpriv. Currently the
>>>> +only
>>>> + * supported option is %AMDGPU_USER_OPTIONS_OP_KFD_SIGBUS_DELAY
>>>> +which
>>>> + * controls how KFD delivers SIGBUS for poison/RAS events to the
>>>> +calling
>>>> + * process (immediate, suppressed, or delayed by N milliseconds).
>>>> + */
>>>> +int amdgpu_user_options_ioctl(struct drm_device *dev, void *data,
>>>> +                           struct drm_file *filp) {
>>>> +     struct amdgpu_fpriv *fpriv = filp->driver_priv;
>>>> +     struct drm_amdgpu_user_options *args = data;
>>>> +
>>>> +     switch (args->op) {
>>>> +     case AMDGPU_USER_OPTIONS_OP_KFD_SIGBUS_DELAY:
>>>> +             atomic_set(&fpriv->kfd_sigbus_delay_ms,
>>>> +                        args->kfd_sigbus_delay.value);
>>>
>>> Why this is stored at device level? A signal is process specific. I think the delay should be associated with the process regardless of multi-dev scenario.
>>>
>>> Thanks,
>>> Lijo
>>>
>>>> +             return 0;
>>>> +     default:
>>>> +             DRM_DEBUG_KMS("Invalid user option op %u\n", args->op);
>>>> +             return -EINVAL;
>>>> +     }
>>>> +}
>>>> +
>>>>      /**
>>>>       * amdgpu_driver_open_kms - drm callback for open
>>>>       *
>>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_events.c
>>>> b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
>>>> index e9be798c0a2b..2ff6348105b7 100644
>>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_events.c
>>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
>>>> @@ -29,10 +29,12 @@
>>>>      #include <linux/uaccess.h>
>>>>      #include <linux/mman.h>
>>>>      #include <linux/memory.h>
>>>> +#include <linux/workqueue.h>
>>>>      #include "kfd_priv.h"
>>>>      #include "kfd_events.h"
>>>>      #include "kfd_device_queue_manager.h"
>>>>      #include <linux/device.h>
>>>> +#include <uapi/drm/amdgpu_drm.h>
>>>>
>>>>      /*
>>>>       * Wrapper around wait_queue_entry_t @@ -1337,6 +1339,115 @@
>>>> void kfd_signal_reset_event(struct kfd_node *dev)
>>>>          srcu_read_unlock(&kfd_processes_srcu, idx);
>>>>      }
>>>>
>>>> +/*
>>>> + * Per-process opt-in for poison-consumption SIGBUS handling.
>>>> + *
>>>> + * Default: kernel sends SIGBUS to the process immediately when
>>>> +poison is
>>>> + * consumed, in addition to delivering the KFD HW/MEMORY exception events.
>>>> + *
>>>> + * Userspace (ROCr) can opt-in per-process via the
>>>> + * DRM_IOCTL_AMDGPU_USER_OPTIONS /
>>>> +AMDGPU_USER_OPTIONS_OP_KFD_SIGBUS_DELAY
>>>> + * option. This lets the app's registered system-event callback
>>>> +handle the
>>>> + * RAS error first, instead of being killed by SIGBUS.
>>>> + *
>>>> + * Encoded value (set on any of the process' amdgpu render fds):
>>>> + *   0          - default: SIGBUS immediately (no opt-in)
>>>> + *   0xFFFFFFFF - opt-in, never escalate to SIGBUS
>>>> + *   N (other)  - opt-in, escalate to SIGBUS after N ms if app does not
>>>> + *                handle the error in time (safety timeout)
>>>> + *
>>>> + * Per-process scope: the option is honored if ANY of the process'
>>>> +amdgpu
>>>> + * fds has been configured. This matches the slide deck's
>>>> +"Per-process,
>>>> + * App set at init" semantics, while keeping the UAPI on amdgpu
>>>> +where ROCr
>>>> + * sets it.
>>>> + */
>>>> +struct kfd_sigbus_delayed_work {
>>>> +     struct delayed_work work;
>>>> +     struct kfd_process *p;
>>>> +};
>>>> +
>>>> +static void kfd_signal_sigbus_delayed_fn(struct work_struct *work) {
>>>> +     struct kfd_sigbus_delayed_work *dw = container_of(to_delayed_work(work),
>>>> +                             struct kfd_sigbus_delayed_work, work);
>>>> +     struct kfd_process *p = dw->p;
>>>> +
>>>> +     if (p->lead_thread)
>>>> +             send_sig(SIGBUS, p->lead_thread, 0);
>>>> +
>>>> +     kfd_unref_process(p);
>>>> +     kfree(dw);
>>>> +}
>>>> +
>>>> +/*
>>>> + * Resolve the per-process SIGBUS opt-in setting by scanning all of
>>>> +the
>>>> + * process' KFD pdds (each backed by an amdgpu render fd). Returns
>>>> +the
>>>> + * "most lenient" value across all fds, in this priority:
>>>> + *   DISABLED (no SIGBUS)  >  any non-zero timeout  >  0 (immediate)
>>>> + *
>>>> + * Rationale: if the app has explicitly opted in on any GPU it
>>>> +uses, it
>>>> + * wants the chance to handle the error in userspace.
>>>> + */
>>>> +static u32 kfd_get_sigbus_delay_ms(struct kfd_process *p) {
>>>> +     u32 result = 0;
>>>> +     int i;
>>>> +
>>>> +     for (i = 0; i < p->n_pdds; i++) {
>>>> +             struct kfd_process_device *pdd = p->pdds[i];
>>>> +             struct amdgpu_fpriv *drv_priv;
>>>> +             u32 v;
>>>> +
>>>> +             if (!pdd || !pdd->drm_file)
>>>> +                     continue;
>>>> +             if (amdgpu_file_to_fpriv(pdd->drm_file, &drv_priv))
>>>> +                     continue;
>>>> +
>>>> +             v = atomic_read(&drv_priv->kfd_sigbus_delay_ms);
>>>> +             if (v == AMDGPU_USER_OPTIONS_KFD_SIGBUS_DELAY_DISABLED)
>>>> +                     return v;
>>>> +             if (v > result)
>>>> +                     result = v;
>>>> +     }
>>>> +
>>>> +     return result;
>>>> +}
>>>> +
>>>> +static void kfd_signal_sigbus_with_delay(struct kfd_node *dev,
>>>> +                                      struct kfd_process *p) {
>>>> +     u32 delay_ms = kfd_get_sigbus_delay_ms(p);
>>>> +     struct kfd_sigbus_delayed_work *dw;
>>>> +
>>>> +     if (delay_ms == AMDGPU_USER_OPTIONS_KFD_SIGBUS_DELAY_DISABLED) {
>>>> +             dev_info(dev->adev->dev,
>>>> +                      "SIGBUS suppressed for process %s(pid:%d): app opted in to handle RAS error\n",
>>>> +                      p->lead_thread->comm, p->lead_thread->pid);
>>>> +             return;
>>>> +     }
>>>> +
>>>> +     if (delay_ms == 0)
>>>> +             goto send_now;
>>>> +
>>>> +     dw = kzalloc(sizeof(*dw), GFP_ATOMIC);
>>>> +     if (!dw)
>>>> +             goto send_now;
>>>> +
>>>> +     /* Take an extra reference for the delayed worker. */
>>>> +     kref_get(&p->ref);
>>>> +     dw->p = p;
>>>> +     INIT_DELAYED_WORK(&dw->work, kfd_signal_sigbus_delayed_fn);
>>>> +
>>>> +     dev_info(dev->adev->dev,
>>>> +              "Deferring SIGBUS to process %s(pid:%d) by %u ms (RAS error opt-in safety timeout)\n",
>>>> +              p->lead_thread->comm, p->lead_thread->pid, delay_ms);
>>>> +     schedule_delayed_work(&dw->work, msecs_to_jiffies(delay_ms));
>>>> +     return;
>>>> +
>>>> +send_now:
>>>> +     send_sig(SIGBUS, p->lead_thread, 0); }
>>>> +
>>>>      void kfd_signal_poison_consumed_event(struct kfd_node *dev, u32 pasid)
>>>>      {
>>>>          struct kfd_process *p = kfd_lookup_process_by_pasid(pasid,
>>>> NULL); @@ -1345,7 +1456,6 @@ void kfd_signal_poison_consumed_event(struct kfd_node *dev, u32 pasid)
>>>>          struct kfd_event *ev;
>>>>          uint32_t id = KFD_FIRST_NONSIGNAL_EVENT_ID;
>>>>          int user_gpu_id;
>>>> -
>>>>          if (!p) {
>>>>                  dev_warn(dev->adev->dev, "Not find process with pasid:%d\n", pasid);
>>>>                  return; /* Presumably process exited. */ @@ -1391,7
>>>> +1501,7 @@ void kfd_signal_poison_consumed_event(struct kfd_node
>>>> +*dev, u32 pasid)
>>>>          rcu_read_unlock();
>>>>
>>>>          /* user application will handle SIGBUS signal */
>>>> -     send_sig(SIGBUS, p->lead_thread, 0);
>>>> +     kfd_signal_sigbus_with_delay(dev, p);
>>>>
>>>>          kfd_unref_process(p);
>>>>      }
>>>> diff --git a/include/uapi/drm/amdgpu_drm.h
>>>> b/include/uapi/drm/amdgpu_drm.h index 9f3090db2f16..dfc91d25c80d
>>>> 100644
>>>> --- a/include/uapi/drm/amdgpu_drm.h
>>>> +++ b/include/uapi/drm/amdgpu_drm.h
>>>> @@ -58,6 +58,7 @@ extern "C" {
>>>>      #define DRM_AMDGPU_USERQ_SIGNAL             0x17
>>>>      #define DRM_AMDGPU_USERQ_WAIT               0x18
>>>>      #define DRM_AMDGPU_GEM_LIST_HANDLES 0x19
>>>> +#define DRM_AMDGPU_USER_OPTIONS              0x1A
>>>>
>>>>      #define DRM_IOCTL_AMDGPU_GEM_CREATE DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_CREATE, union drm_amdgpu_gem_create)
>>>>      #define DRM_IOCTL_AMDGPU_GEM_MMAP   DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_MMAP, union drm_amdgpu_gem_mmap)
>>>> @@ -79,6 +80,7 @@ extern "C" {
>>>>      #define DRM_IOCTL_AMDGPU_USERQ_SIGNAL       DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_USERQ_SIGNAL, struct drm_amdgpu_userq_signal)
>>>>      #define DRM_IOCTL_AMDGPU_USERQ_WAIT DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_USERQ_WAIT, struct drm_amdgpu_userq_wait)
>>>>      #define DRM_IOCTL_AMDGPU_GEM_LIST_HANDLES
>>>> DRM_IOWR(DRM_COMMAND_BASE
>>>> + DRM_AMDGPU_GEM_LIST_HANDLES, struct drm_amdgpu_gem_list_handles)
>>>> +#define DRM_IOCTL_AMDGPU_USER_OPTIONS        DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_USER_OPTIONS, struct drm_amdgpu_user_options)
>>>>
>>>>      /**
>>>>       * DOC: memory domains
>>>> @@ -1673,6 +1675,29 @@ struct drm_amdgpu_info_uq_metadata {
>>>>      #define AMDGPU_FAMILY_GC_11_5_4                     154 /* GC 11.5.4 */
>>>>      #define AMDGPU_FAMILY_GC_12_0_0                     152 /* GC 12.0.0 */
>>>>
>>>> +/*
>>>> + * Definition of user options
>>>> + *
>>>> + * option: AMDGPU_USER_OPTIONS_OP_KFD_SIGBUS_DELAY
>>>> + *    0:          Disable sigbus delay - SIGBUS will be raised immediately
>>>> + *    0xFFFFFFFF: SIGBUS will not be raised
>>>> + *    other:      Set the sigbus delay in milliseconds
>>>> + */
>>>> +#define AMDGPU_USER_OPTIONS_OP_KFD_SIGBUS_DELAY              0
>>>> +
>>>> +#define AMDGPU_USER_OPTIONS_KFD_SIGBUS_DELAY_DISABLED        0xFFFFFFFFu
>>>> +
>>>> +struct drm_amdgpu_user_options {
>>>> +     __u32 op;
>>>> +     union {
>>>> +             struct {
>>>> +                     __u16 value;
>>>> +                     __u16 _pad;
>>>> +             } kfd_sigbus_delay;
>>>> +             __u32 _pad;
>>>> +     };
>>>> +};
>>>> +
>>>>      #if defined(__cplusplus)
>>>>      }
>>>>      #endif
>>>
>>
> 

