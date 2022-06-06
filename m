Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 867F3C43334
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Jun 2022 14:26:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EEA7211B7BB;
	Mon,  6 Jun 2022 14:26:57 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2077.outbound.protection.outlook.com [40.107.102.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 96AEA11B7B6
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Jun 2022 14:26:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FE6e5bN6ptuku16W33VNBL0aAWXJ9guOFCoIt2Iq46kY+QE9GDbTG89gY3RPZ27wBVtEXC3JEnviaSG5dfiYjXydjP1fyCU5iC2nib/PM1pSSEpEqOKqlIdyqb3pZecNOcRnn/D2dvzPHy0T0ksgtEPdrsNEqwoOBmKfQu/OwYOdu3GGxrxXyMzF8/pjvZUyp2IGFFonRM0daH5+UTWypOJtZAk63lfrXpq71KQ0SwE/0EKbiDEIh0aDi0dfN6S8wlveZW7Jy7K+LilQl1+Hwg3BAWyJSXbDfkju4JVlnBagAU3clFvhhcFO1rxa23ZlfSmLQZ4029kpLQy0hJjCjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cBQ8o+9jpm1d45z6GiWgjUKfz4X9SuWrXjT00EaWvFk=;
 b=lftbyQhRNjAC/c1poWNBhiY9MYvEmnLUwJJMbifj5HqdxHbuS3+NdSQ88b7ISp4e6wFrbJ0m055A1LrBq+iJ/y4hCbCvSBmuqM/mZdYgcDhEuPbl+t2axPiMLj9bLzmoRwB4ibQKrPVQmJFsU2gSPU0hxke6WuW6/8WjK4XBb8O4uBKXnO+TjJu6qloXTz8TkM3A/ib8pX8S5KyheZ5Z9yOshrXfarnJ18kcjP8lZiiehImvoJYKe06Z3Np3HBPo20HXE+4ciL+vBc4IJSd0965qA9o3E0w20exFxJacGsqltbcnC6Pz3ibonLVrfmg3div17EIhQUSqTEVSnxTGag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cBQ8o+9jpm1d45z6GiWgjUKfz4X9SuWrXjT00EaWvFk=;
 b=Xwr5DGtwAMZZfhMvx124tRGfZZPPR2KK6rCYrk01UphAmVxEfcNdICeSm1qBt8BXkMElLa9TtW/hvQzEO4b4MWjR8rv2k+OyBO4+mrHl/IyT+e/f+2+XmC/x//UnVf1OTzCgsNTkiqaPWOm8rE7SP4B34K8/vr4O0vn0h7ykg7s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by BN8PR12MB3009.namprd12.prod.outlook.com (2603:10b6:408:42::32)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.17; Mon, 6 Jun
 2022 14:26:55 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::1cf6:2a9d:41d6:e8c3]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::1cf6:2a9d:41d6:e8c3%4]) with mapi id 15.20.5314.019; Mon, 6 Jun 2022
 14:26:55 +0000
Message-ID: <1763506e-f963-d163-831e-29a2e59f415c@amd.com>
Date: Mon, 6 Jun 2022 10:26:53 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 2/3] drm/amdgpu: Add peer-to-peer support among PCIe
 connected AMD GPUs
Content-Language: en-US
To: "Errabolu, Ramesh" <Ramesh.Errabolu@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
References: <20220603105227.3363029-1-Ramesh.Errabolu@amd.com>
 <412d12a6-24e5-ff30-2d1f-b631e0e21784@amd.com>
 <MW2PR12MB25693166D2F65B64427A782BE3A09@MW2PR12MB2569.namprd12.prod.outlook.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <MW2PR12MB25693166D2F65B64427A782BE3A09@MW2PR12MB2569.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT3PR01CA0076.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:84::19) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5ff1e22e-7f6a-44f7-3331-08da47c89b06
X-MS-TrafficTypeDiagnostic: BN8PR12MB3009:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB300963B5ABEC92527AE9E09E92A29@BN8PR12MB3009.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TG+ziPj0IJcoLnbKVdmItYWgIQTtb3/0+0P/le/wLcF2A7mWXyGG0TZ62xNU9XZVcsyaltrpj1vrnYqs1rH4coFkPgXq1a1gCdJRrkXatfqpWu1XIjET6/Lj7OFRi5czIEL8aO4p5KPvsfxmoWkEEpFCmgZmwPYSH588kQSaRs9vDb3OjK2KXR+Pu3nQqpO5D/tHJMG9v/KP15uC/1aNVT3p2QOsj8wmup+JJnnGIV7HIEDjExM6tAYXp+fC8kXd/PFJIOrdqrJNgUBKGtpuiEWj1v0aOFBMQ2iWq/PEJyft5PBijUHsgnnYWjfmeqRamrOhjJJBFMIOAWsceVY4zi2LsmtM0qC6J9KZ4lAYLgulayRt2KJ2k1Gra2rft3DeQNcGCFi9d1p+cRt24pcegQUPU9xaa6Yi2LQHQGwnD4I+RbuWCANUUz7xVmvIrjozOdiQq9/WviSLRnNzBh/tuaGZV2LjdnnSQ58r2Mftj+++3vD7aF6J9iP/70yGojtZbm/UXyvNc/30OHdAti7tQGMQbZzMkGXzxYJNgw8dHPpuYL7Kn5ow8bz0jHEnFDvuksZMoh0mKQFfvTWDc5irUbDoKJriQUFW9EV8xvKfsijiKKaj+dmmh7s+OTEDleIap+AKYgZ+cD7GCMgWRkmmQ3+hUxsGBqP6CxeolaT2n1OvCnQtFiAJyE9ceVZK9pAYnXw2jfuOAc1OyPP/KF1iM4X5uvQdMZNpLWbCZWfjVSuihYDJyFlJT9Y07ndhncwI
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(110136005)(316002)(8936002)(36756003)(38100700002)(2616005)(66556008)(66476007)(66946007)(26005)(5660300002)(6512007)(6506007)(31696002)(86362001)(8676002)(31686004)(186003)(44832011)(508600001)(83380400001)(6486002)(2906002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aktqc1o1VU83a1lpZnlLQXI1QWgzMmk0blVyTkhobjNmY1FmUDZ4aW1HVlVJ?=
 =?utf-8?B?V1BBQ3h3K3Y1a0Z4ZWx2ekRKQWk5TWUydFBvWXI0Rk5OdEROUzlMdHdZZDUv?=
 =?utf-8?B?c3RjRHRCTkdxMm9GcnEvRFQ3VmRHSmRDbUhxbENiblZ4dUdIbFFEYkhkdzRG?=
 =?utf-8?B?ZmdhNVlRL0VqUzQvdGtYNGtSU3R0Z0prVExXQjRFRS96YkZEOTJuNUFZZ0U1?=
 =?utf-8?B?SHdGcVE4OUJkUzVkbEYrNk9rS2d3N1V4dXFVYm13bFN2R05VN3hVQUNyRmxz?=
 =?utf-8?B?L0tQWC9DQ2M4RjZiUTIzTDJVcVArZndkY0Zla0w5S3hudFBKY2tqS1hGM1RS?=
 =?utf-8?B?QmN4ZTM1UHpRTUpEczVtMUZ3cXRQL0U3T3RkZGlTT0FIOVh0NElSdktWRGp0?=
 =?utf-8?B?dGtsaG42MXplMkVUajlvZ1NCVHdWKzgrM1NzTHpHeEo3SkV4bTJDTTEvcFh1?=
 =?utf-8?B?N3lxRG9jVE91OTFVaVlyaVlrWXZYTk1HaVpTaVVBQWYzQWdzekVMUmxhTTBP?=
 =?utf-8?B?Q3VsZzBEWlIzWVQrMFMzSW9GYmRpa2hrbXJrZjl3SW9OZDBqazVneWZJTmtW?=
 =?utf-8?B?TVY4VTc0MmJtcGVMczNiTUVnR3lnODN0SEJ6U0pSQktpaDA4NXF5QlBJZ3hG?=
 =?utf-8?B?TUF5SmdXSEFJemhvUWJLVHdwVHpoOGg3NG0vOWVTc01HZkw3Q05IRythU1pP?=
 =?utf-8?B?VVgrNzB5SU9lMG9WdWVtcHVZbkZONWt1UkdKS0NkZTZ0ZWNCNlZieHNUSWxk?=
 =?utf-8?B?UGVDSTdPZTZ1elF5V295eEVlbnF2QUJ0TDRCcWRUYTJNSHl6TnQ3R1lKQ011?=
 =?utf-8?B?eU8zK2htbXh5Z2RaRHY2MEIrdko0U1hvelhpY2VTSmxJWko1aUptdlFGWm9Z?=
 =?utf-8?B?WVE0SGZQNmxQWGJpcWpLZysybERDb3J0NUk2WGtVMkxKa1RqUFFoelQxdlVH?=
 =?utf-8?B?cEliN3ArSlQwSVZtdlhiVUJwYUxSY3VFNmZSTDBnaGdmMUlHbzRrRmwzWUkv?=
 =?utf-8?B?aTlIbWdiMEt3cUZkNlVrRy9GRXRNcUplUlF4VFYxM0pGNFdWbC9DR2gxOGZu?=
 =?utf-8?B?Y2VhOVpzSC9SbzM1aC9HTGtHVG1ORUFKOGZkaGdQUytyUWluNkF0aTIvZEo3?=
 =?utf-8?B?VFl2Y3FSU3c4QmtyNEZQQ0U0N0hSaWRxWllJelBKV2ZSZko3T0ZKZ1VKVXRs?=
 =?utf-8?B?RW8rSVU3LzZLQzVMT0JDVVFOMHFURXVrY0ozZjRnVXAwYXJMY080WCs5V2xY?=
 =?utf-8?B?bHRKSTNaSklzVElmTnFmdVI0K3hUdlJET3lNckEwckRjTXVkVTB0SkN3dXJr?=
 =?utf-8?B?Tk12WEVrU0tsZjhZWUREM201elVDSFI2RDNkT1FNSVQ5VVd1R0svdmxSTTBw?=
 =?utf-8?B?V21SZFlCMk5jYWxYdFl5U2VMUGM4MW8rY3YyZVVUMEtCTFpFSlBXRkVyMUM4?=
 =?utf-8?B?ZmFGeTlwZXN5b05XLzB1a3ZFalVtVEZob3RxM0hnNm82SnZBaFY1QWhoVlIz?=
 =?utf-8?B?UEVFSnpSbWNuaXFkeXlZSUVnVGtrYzJXTUtUajJxYzMwd28zKzR1WnczWjFN?=
 =?utf-8?B?SXE2TGRWMlpEakJFV1dncU5panhNV1FUWEVpTE5Hd1FyWExvdko4VlB6Zktl?=
 =?utf-8?B?bnVvcjJWRUpPNW4xbW5xeGxnL3ZoSGU1TGl1QmxrNkhnTktlU0NzdU0yRlZ5?=
 =?utf-8?B?bXk0R1psYjJsU1EwNGdVQVlkV1lFSlR3R3NjcktLSjgvcHpQenU5bC9VelZx?=
 =?utf-8?B?V2FjTVZ1SEpVcFlCK25IWFhnWmdwZCtVaUtWbXRmbEVwb0JZQ09yakhTM2Fv?=
 =?utf-8?B?MXJId0hSR2NBaENtTnoxanpCQStmTWdjeGlHYlRpc3NtWkFobXBvZGFvMklu?=
 =?utf-8?B?cXFOaXV6WXJDMy9NT2FQQTVmcUQvblRrdVdQYUN6N3pjZXp4WG83YlNqUEJ4?=
 =?utf-8?B?TEZqbDZxL1lYcS93OHlnVlVQTUw2M29RUXR3V29LL0RFRUZZcVdNSTBadGNU?=
 =?utf-8?B?THFybmlHb1RIQVNuTHYybTlHcFkrWUhmSTlueU9Zc3k1c0RDVVkxYWxkY3dN?=
 =?utf-8?B?T2JaSHZLMGpQZDNORzM5TWJyZnR5aThUZ0Q1Zm54MjJCb3BzUmVob0RhaWRM?=
 =?utf-8?B?eU5LNHdWaWdTRW94U1lDTGNLank0Y3VHV3h3bVFFeGp0YU9nVk9EQzdEQitM?=
 =?utf-8?B?U1ZGc0JqdVU2TEJSR0JXdWR5YzE4alEwTFBWK1Jub0ZkS29YU0lLdnFuNHRV?=
 =?utf-8?B?b2lrcHFlTWtzWHFvYlJhM3laV2RvdDVqRXNiWVllOHJnMTRkUTdXTk84b0t0?=
 =?utf-8?B?ckdjS1ZNM1Mxd2ZEVjV2QkdRWUlkWS9RMjd5NWkzTnQzc2lyRkVCdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ff1e22e-7f6a-44f7-3331-08da47c89b06
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2022 14:26:55.0314 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yuFvTwBWIQLEO8XMPptrT5lmvk3xckZoCRKFBZYB8ui4paz/OljrzELR61Mk91AYmJ/HcSjl1n3QWfGfagrTbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3009
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


Am 2022-06-04 um 06:23 schrieb Errabolu, Ramesh:
>> +bool amdgpu_device_is_peer_accessible(struct amdgpu_device *adev,
>> +				      struct amdgpu_device *peer_adev)
>> +{
>> +#ifdef CONFIG_HSA_AMD_P2P
>> +	bool p2p_access = false;
>> +	uint64_t address_mask = peer_adev->dev->dma_mask ?
>> +		~*peer_adev->dev->dma_mask : ~((1ULL << 32) - 1);
>> +	resource_size_t aper_limit =
>> +		adev->gmc.aper_base + adev->gmc.aper_size - 1;
>> +	p2p_access = !(pci_p2pdma_distance_many(adev->pdev, &peer_adev->dev, 1, true) < 0);
> This would give you a checkpatch warning. Please run checkpatch.
>
> Why can't you initialize p2p_access in the declaration above?
>
> Ramesh: I did run checkpatch script, and it didn't complain about the variable being not initialized. Being a variable of extern class, it is initialized at load time to default value of ZERO. This is then overridden in amdgpu_drv.c to true. So initializing it to true does not accomplish anything.

p2p_access is a local variable. Are you talking about pcie_p2p?

Checkpatch is not a static analyzer, it would not complain about 
uninitialized variables. It's more of a coding style checker. It usually 
complains when there is no blank line between variable declarations and 
the function body. That's why I suggested initializing p2p_access with 
its final value where it's defined 3 lines above, and removing the extra 
assignment that violates the coding style.

Regards,
   Felix

