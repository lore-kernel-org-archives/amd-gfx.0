Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37A8BC77B6E
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Apr 2023 14:16:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AF3D910E990;
	Wed,  5 Apr 2023 14:16:53 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2052.outbound.protection.outlook.com [40.107.94.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3CBF710E990
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Apr 2023 14:16:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T3O1kCRyzEVyA6mEwGdYAHOBh7E3razJe4N+Wt0k2q9dcxMTzNizS+Ro1MCcvkM479lWzerbotrsDkR0LxMgqx/sUJMwmx72oK7hLKKWkOXe5OFcbbwBsfFPrLwdGzzPkM0l33YlkYkmlRfsMcPXQ+Joz+snUjiOnsQnzWC4NM1kiyt/OeSDaSFHLN8sRO1GRGR2AHW0DnPkYAlYk4YVAqvckl3FwlmcYoHt27vjd4Rz8cTw4jox4tOmri5CrOyPj54mevljrvqKFumT8jxawBYfx5WGTsJ85D2uT5/HREtXWW7ixgLvlsUYtdQoMAAWhbmV4ZvYD9Rb9/DOd3qfAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w3utL7HUi13UCDCbOwJX2oAl9HeciD2DpiGk/wrPpfA=;
 b=Q3YJlokzMd8wME4MCEoSGeUodhC33//oX3OhObm5EddCa40Ikzuus/KtpkF3eRFqrRN0ukGd9eTKi7CLcbgy/icYZuSsnAbkCQEyPo8e/I1ZakwmvIehkbLtbD142HCJQoabbJsCI0SzjfC3WL0BrhsGpyuh3fVBOjXhEZ32tvAZ0cpLMbqrj1ndP9+ttxXaB0vJKrAWd6hSOzOXYTuUOZBvq2AdmrX6b8LP4ELduWs7AAGXVJ7Hodqr25JOvsVQTYO9nidKdWEBaNdj5aMuagHIc4NnC7ncAJP7Bhdln0APVvEwbIzWJWZo+h0hVJ9wz9uTbV5WWhNP6IuxNimb2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w3utL7HUi13UCDCbOwJX2oAl9HeciD2DpiGk/wrPpfA=;
 b=3qn9NGmGLKoiP6APXRME6BceuFjKvoBT4U63cT2guQUrmgMu/BNhI1aeakC4ySe1Jk7jy8L+U4RotAnkvESPmlRXrCHN70Yix58dMKSw+6EQ/nnxpT5KePFyi8IPBVuakETAJ/mKXC5UjKXLYJaNiEEqvKsJhH/mzcajnFaUKUg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by DS0PR12MB7771.namprd12.prod.outlook.com (2603:10b6:8:138::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.33; Wed, 5 Apr
 2023 14:16:50 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::4624:dc39:943e:6ae]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::4624:dc39:943e:6ae%5]) with mapi id 15.20.6254.035; Wed, 5 Apr 2023
 14:16:50 +0000
Message-ID: <95ad7a5a-09b7-9f2e-9864-442c70af4cfc@amd.com>
Date: Wed, 5 Apr 2023 16:16:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2] drm/amd/amdgpu: Fix trivial style errors
Content-Language: en-US
To: Mario Limonciello <mario.limonciello@amd.com>,
 "Russell, Kent" <Kent.Russell@amd.com>,
 "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>
References: <20230405132428.393593-1-srinivasan.shanmugam@amd.com>
 <DM5PR12MB130816E7449E8137E84EBE6585909@DM5PR12MB1308.namprd12.prod.outlook.com>
 <a35a4485-42f1-fdd0-cc18-051b355448f3@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <a35a4485-42f1-fdd0-cc18-051b355448f3@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0074.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1f::12) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|DS0PR12MB7771:EE_
X-MS-Office365-Filtering-Correlation-Id: 35573cfa-fa3e-48c1-2d0a-08db35e065c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dlAlSxwcBGUM7wXFvP3ud192fucgLow6Xd6sAsMdo2mjKyNXtG97L1YmlVDWt9SCoataVqZB0g1WTbd8ffVZIaLKi2C0mrTZBN3ON4Sx6kZIK4GgO1KZDxoTeIgpKCE/f2zLFiKr+1X95Pw0DQNxYuPrlQA8yugkxFIJAz0k1XRCUFe99OGjXo8qRF7HTKvQtbsZWtE9U2uFzfHgL5ISZYlmdpcnJe3LnWI9rIFe9/3sOedjbHbPje5ZgmfsCnOz2SVAe/3RSdVAIFfQFfVqM+Btym//WgE1MhlJ4PU/wNFazNHxIHJ1DTCrztGWS37OQaU3iAuVVgPF5dJBGqVocHka/82vCjn+MiKJzIthLU1J1zj0A0DeRgXxZZpHzpJJociBIUQhVCMuHBNpnSMjKIt2W2lOnL2va5n4E6zhJ+dIwYhEOvyNK1vLT/Ijd+3gEGvOXJb7WHRy46s5GeN7qmxPZsz9Euib2oKig5YIBGVhoy8soQ4o+fCIGK4Tp10DxTJq7I9gJMEUZlgoy+VafZ0NRszREB11Nybqz5BA8oO2SrMrLVRwIXoZJbVCTSpIkjjLYdc+riE5F8xeurAzzcib6jKxBkLQc0X0f580y2uEOno0hUQDMfiwJnXuVmjsURk/AiNS0VQiKCnNUy2cpQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(136003)(366004)(39860400002)(396003)(376002)(451199021)(31686004)(86362001)(6486002)(83380400001)(38100700002)(36756003)(6666004)(2906002)(31696002)(478600001)(53546011)(6512007)(6506007)(66574015)(316002)(8936002)(5660300002)(110136005)(6636002)(41300700001)(186003)(4326008)(66946007)(66556008)(66476007)(8676002)(2616005)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dytiQTVWelVZTlJOSVhrS0Z5cUM3am5OUGZaT3k4NXprdkg3QVpGbC91TlVH?=
 =?utf-8?B?N2Jsb0ZhekVSUUNXUTR6RjF6QWE2SENYMWVRY1RIMng4OGw0dmZjRjJVZ2xW?=
 =?utf-8?B?V2c4djNncUVJeGxDNzkrZlhwUXljb2JTMUhZV3pQeExRbjNuSll3YlhzQ3Nu?=
 =?utf-8?B?L0k4OFR3dHAvODdUQ2xqMnlrVld1eGdINDFod1Z2b1dyT09jdzBlamtZUXIv?=
 =?utf-8?B?VjVlczFTdkY4cE1MZktLWEJ6M01YM0Fsbm4wZTIzL1BMejhyZEpyQ3ZZTDdm?=
 =?utf-8?B?NHhUVnJHWU9jZXpyV3JsVVZ1a29MUWsrRDQ5clF1a0d1SUpOTkhrUnRlTEI4?=
 =?utf-8?B?bFM4RzFjZ0dQTW5kRnhldHBpRVZZaWNuZ2g3cFhnOG1tN05SQ1VvUUVGRXRm?=
 =?utf-8?B?QUtIMnJYMVkzNXk3RkhEcG1EMENaMXV2YVVReXgwZkFmWVlEWXFNL0xPMzRT?=
 =?utf-8?B?OVB3OXJzK3dnMExJbkVzdFd4Ujd0SmFacjJpclQrdytCRFY5emZrZ0p5U3Nl?=
 =?utf-8?B?WVBPWDlYRm1aQTJXQmkxQ05EeGlUbnc2dzRKbC9uanlMR2ozeXVJcGgrdDd2?=
 =?utf-8?B?U1p5S2JmSk51V1hpNTA0R3pENmxMMTdJOS9JQ1FVR0puZjMxb0wvalA2WVM0?=
 =?utf-8?B?aXFUMVlxVG9xK2FlTjU5anY4OGE2Y2pCV0l4bnlZRlJ0d29Rb21sTHREdmVL?=
 =?utf-8?B?OTZmMDl1MVBscldHWWtneitFNEZubHNZV0ZnQisxSkgyKy9EVVlMckVNdUlp?=
 =?utf-8?B?QTZXUTA1cG9ZWlJZZFp5NVUvTk5TWVpkQm5NOVE1SWFOUlFkR0FHUm1wT3JM?=
 =?utf-8?B?cmZpSFR4a2IrZFNESG9ZNHJJVkVhVWNkUUN0Vnh0ZWF3UFhyN20wTVhnd3I3?=
 =?utf-8?B?KzZXM1BoaC9vZVpGUHNERXdiaWRSOFUySzBENkZHYzVxd05ybE9VSm1lTXo2?=
 =?utf-8?B?V2lWNmhFTUVpOXQvZmpJS0ZYaFU2dXAyL0xBTjlVMWxaVGlxSnErUHNvMXlt?=
 =?utf-8?B?YkdQQUd4d2wzTFlwb2xENDZ0d2JRZ25jTmh6OUhyRGJoeGt0MmN3QnNIM0Ru?=
 =?utf-8?B?L29LRTlSSHhtWXBLcmwwR0dsVlNWK2ZPdkMzTHVTY0JRa1FOMGtxR1VScHJv?=
 =?utf-8?B?ZVdzV0ladFU2WVNjdFZyaVNSMnZBZkVTam5TRTcwbFVJR0IzSG9FQ2NFVWFp?=
 =?utf-8?B?K3EwOUpPbVdRbmx5azZ4NjVvR1Ayck9LZFgvZjJRaEF4d0R2U2xtOXRGTGJp?=
 =?utf-8?B?U0x3MjJYUGZsQVdsa1AyREJWTnZKSzM1NFBYSWUydzBiZkd5YTRBTDErSkhp?=
 =?utf-8?B?emgvcFV0Zzc5cFdNaUdNdG1KWExyeUlkMnBVSFlYcEFrS0k4R3JGRC8rRkti?=
 =?utf-8?B?MHQydit5U2UyVUlDTkgvZ0ZYbmdnQzFJWFk3QVJzcjU0NGt2djNDTGIwVVkz?=
 =?utf-8?B?NDJ3Um1FZks3UXQ2WXMvY1ZxTXBkOTdtMjMxdnNTcHlzU0lvMjdBbUN6QUNI?=
 =?utf-8?B?YTFWUjV0WlBiMjZ3NDdpeFpnSEs1L0E3TlR1dk9NbEVmcy9aekhERzJvTGdv?=
 =?utf-8?B?ZW1kN0RBY2t1ZFBXZTlrNUpjdHB5dEpUOTFmTHU5cUQ5UGZyaTdHeDA0UE5p?=
 =?utf-8?B?MzdvZnl0TkJ0U0E4a0xuY0dJSjdMQkREdGRjZGNSOThUTS83ZjJYL1VCa1BM?=
 =?utf-8?B?emNndEVYcVJYYWRpekJNS1FHRlI0V0RZa1NhUFVteWtQM2Y0M2R5bkswbFhN?=
 =?utf-8?B?dlBQTThJeGM0RDFEcUZjOEl6ektlTmNBM3NTRXJYZHA4ZlZiaDUva0IyYXNS?=
 =?utf-8?B?a1NpMkFOMXV4bWVCeDBNVnFkb3g1dEtMNGF5S3IvbXpwSjgrMm8zSXdwa3RW?=
 =?utf-8?B?YThybmVmMVkrbS80dENyNDRzY3Z0ekkwVzVQRVk0bEZGMGdWcWYwaEVQRTQw?=
 =?utf-8?B?bGtTWk44RjkweXJoMEhJNDRleFg0elJ0dnM3UWlRT3NRYTJiSnByOXU2K1Yx?=
 =?utf-8?B?MWdLeGx5R2YrWHpBYUhsOFBxZ1ZmRlZKMFBiakhyM0VEU1YrRDZaRkdxTzZY?=
 =?utf-8?B?YXdLNmtPRFk3bHNHWEh6UmtqWjRkZ1ZCUFQvOXlnZmI5OTVKMzVoMnhIRE5U?=
 =?utf-8?B?aGpPUlA4R1RVdlBQYzg0Mkwyb0VSSjZYYnEvTC9jUTlvZTZOVkprNW1KNHlV?=
 =?utf-8?Q?xWTpi+qB0tH8pODcjbrBU7BA3r48oYiuzQH20zdDyBAD?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35573cfa-fa3e-48c1-2d0a-08db35e065c9
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2023 14:16:50.2461 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qFe1GImYdAuheuYUVn3jSIrr5ZNPm4VurQ2SNqkd3PLHqqhci62IFS/OGGUeuDPB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7771
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
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Removing the global job_hang_limit variable and replacing the only place 
where its used with 0 would probably be a good idea also.

Christian.

Am 05.04.23 um 16:13 schrieb Mario Limonciello:
> Also the changelog should be below the cutlist (---).
>
> On 4/5/23 09:12, Russell, Kent wrote:
>> [AMD Official Use Only - General]
>>
>> Probably worth changing the commit message and headline now that 
>> you're removing the parameter instead of just fixing the code style.
>>
>>   Kent
>>
>>> -----Original Message-----
>>> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
>>> Srinivasan Shanmugam
>>> Sent: Wednesday, April 5, 2023 9:24 AM
>>> To: Koenig, Christian <Christian.Koenig@amd.com>; Deucher, Alexander
>>> <Alexander.Deucher@amd.com>; Limonciello, Mario
>>> <Mario.Limonciello@amd.com>
>>> Cc: SHANMUGAM, SRINIVASAN <SRINIVASAN.SHANMUGAM@amd.com>; amd-
>>> gfx@lists.freedesktop.org
>>> Subject: [PATCH v2] drm/amd/amdgpu: Fix trivial style errors
>>>
>>> Fix coding style errors reported by checkpatch, specifically:
>>>
>>> ERROR: space prohibited before that ',' (ctx:WxV)
>>> +module_param_named(job_hang_limit, amdgpu_job_hang_limit, int ,0444);
>>>                                                                 ^
>>>
>>> ERROR: space required after that ',' (ctx:WxV)
>>> +module_param_named(job_hang_limit, amdgpu_job_hang_limit, int ,0444);
>>>
>>> This patch gets rid of all above type of  "ERROR" messages in
>>> drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c.
>>>
>>> v2: The driver doesn't resubmit jobs on hangs any more, hence drop
>>> the hang limit module parameter. (Christian)
>>>
>>> Suggested-by: Christian König <christian.koenig@amd.com>
>>> Cc: Alex Deucher <alexander.deucher@amd.com>
>>> Cc: Mario Limonciello <mario.limonciello@amd.com>
>>> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 7 -------
>>>   1 file changed, 7 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>> index e652ffb2c68e..25606af348b8 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>> @@ -521,13 +521,6 @@ MODULE_PARM_DESC(virtual_display,
>>>            "Enable virtual display feature (the virtual_display will 
>>> be set
>>> like xxxx:xx:xx.x,x;xxxx:xx:xx.x,x)");
>>>   module_param_named(virtual_display, amdgpu_virtual_display, charp, 
>>> 0444);
>>>
>>> -/**
>>> - * DOC: job_hang_limit (int)
>>> - * Set how much time allow a job hang and not drop it. The default 
>>> is 0.
>>> - */
>>> -MODULE_PARM_DESC(job_hang_limit, "how much time allow a job hang and
>>> not drop it (default 0)");
>>> -module_param_named(job_hang_limit, amdgpu_job_hang_limit, int ,0444);
>>> -
>>>   /**
>>>    * DOC: lbpw (int)
>>>    * Override Load Balancing Per Watt (LBPW) support (1 = enable, 0 
>>> = disable).
>>> The default is -1 (auto, enabled).
>>> -- 
>>> 2.25.1

