Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCF35C61DA4
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Feb 2023 08:05:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 532E810E0D8;
	Mon,  6 Feb 2023 08:05:48 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2070.outbound.protection.outlook.com [40.107.237.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BEAEF10E082
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Feb 2023 08:05:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EnW035manIUlWurv+TjX7UqzTw6tWU5KDJ3VivfyJlSkKB+YmGcxqlVyRWNDzCl/1ZHcs65azW4ZKLpNmxRqbqPL5IIZZ4MiA+Dkmx2tFFa75I8LPIQXIA/zsfqye3DUcAF2sy0LhuO0bN5slMlJWAEOGKCzpaczxwxWV2/VSBBFAIktsAK4kIapGWH6gVtauwwSz7KW1/CqbEmtmMZJzzjq1WoM9zt+19ITL0ewIDYN5mjojAb6NMSxTwVyK2RqLvHBqcYp4LkxHsWsWHVARsEcdEJmVM8aER8AoZ78jpPH0p5uRuRUrWd9QkbVh8zIfTYONdfmisyY+GNQgDM0cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b9hM9GI0dMZZVQAEdCBKvPEB5uIzyVpKNV5hNulESPc=;
 b=CkjFKzOjotnPLw9q4Ji/HqAVx38s4CGvqEpukN1Cslo4IFmQoawig6rxcai00XXTssRjQH/oj5rKN7ZxIpry1pr9MRozNfnHqVbQYfif5WTAIqv/eeVptgHit8HVc4YlYtxyXHzih4bgP7XALYeEzrX1otNR4wfM01ExRFsaYqqf7SqoKoy0JTd1Aih5qiP93gnlYnZt93c5D3JRGkFfs7+8ZF4df5Kep1jgKkPaq+EzoZVSENqZfAHJqlP81wHec4gE1SM5bWURc7sVKcYC+jH2r9JhzxvLc/k65/ojxmrsLmBLc2SCslRkZhqywgq9u03a/phuvfIqQTpbfYbk0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b9hM9GI0dMZZVQAEdCBKvPEB5uIzyVpKNV5hNulESPc=;
 b=NATx0XvYRHC1M8JF9TSCNYYXSbUhE0heoiTM5PjSh8VjXQI8laCs742pf3bXx3TYSHhZrTN0KZo+WaEfzsPfwSlVEcgDdoBUfNSH22aYy2rRpq7mrZccgOoeYW/tGO1Wg4JiRBD8JbQlh0X9KJWBmuL4w5O8cY7gQj+hOxRB0XI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by BL0PR12MB4962.namprd12.prod.outlook.com (2603:10b6:208:17e::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.34; Mon, 6 Feb
 2023 08:05:43 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::2e4f:4041:28be:ba7a]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::2e4f:4041:28be:ba7a%6]) with mapi id 15.20.6064.032; Mon, 6 Feb 2023
 08:05:43 +0000
Content-Type: multipart/alternative;
 boundary="------------9kbFj8nVSwdJo9OitOTjLHm2"
Message-ID: <9ac594eb-9b59-02e1-fc7f-a745e28ff201@amd.com>
Date: Mon, 6 Feb 2023 09:05:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] drm/amdgpu: only WARN freeing buffers when DMA is
 unavailable
Content-Language: en-US
To: "Xiao, Jack" <Jack.Xiao@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>
References: <20230202095416.4039818-1-Jack.Xiao@amd.com>
 <BYAPR12MB35899E39061894E55AC07FE383D69@BYAPR12MB3589.namprd12.prod.outlook.com>
 <MW3PR12MB4458B37F3A4E9AF91F35279FEFD79@MW3PR12MB4458.namprd12.prod.outlook.com>
 <a4d8d310-c2e0-f2e5-74e8-fe8a5c34501e@gmail.com>
 <MW3PR12MB4458263C5E9B1071F7831EF7EFDA9@MW3PR12MB4458.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <MW3PR12MB4458263C5E9B1071F7831EF7EFDA9@MW3PR12MB4458.namprd12.prod.outlook.com>
X-ClientProxiedBy: FR3P281CA0054.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4a::18) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|BL0PR12MB4962:EE_
X-MS-Office365-Filtering-Correlation-Id: b2bd9e0c-5405-44ef-bd50-08db0818f198
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /3xwlHHlF5z3M6ZS0lTbVAr9BEHynoyVuMwB7k5Vh5fdBTo/dMPp1Cz7VI+23DFF2AE9/+TM9lA1jDaPlr8czjHNrKVwI84XA0Ff8scBGPf8VZWACOSJE8jmFAtAQWxjZghlrqJsdabI2Br5oZnt4MCoJFMLwl12BxQFe+5nFxZ79Syr8TWai3e+tBJszC8466pxpEucoy/WDqn3UwXyRYchFDJ436YJQA6QZmxZE9KLr2ehy9oq8ckE67b9gcNzJha2LdM/GZYAuFrzR92fHSdFTm4Dvb0EP/pbItW+Zcquy7jFUTct7AOAmotTeThoq3VmKGirbHCo/tFN2/AT0tZDV8dTvQn3P6nJYtvBCYnAlxcjj5sjihtaTvprocgXpLsHJE6VrdW97nE8PjPkD9yf9xh6SHVZH9ABg6q3mDbN9fzl8iAkxd5NBevmjBkZGXMtysPMidKpQiX+8ekBjasH84zau4L9R48oIs6yKv+8EbRJbfQpRmih2v18dRgysIV4nPQeiUFqj1wJl9VdpDSSaVcD1BHgkdd6LfywJI8dSNLZyWrAReS7VMcIQSNMCB00aMoX8cGWQY/KW/wrXQ9dR6YdZHyy6sT5qZphbj42g9zpt0tOe+Ocz027KhRvm02mSrc0288TDLLHHHY+aakkYbIJajoNqMbCQxUPNe/MBqvvOXhIFTjO6T6k5sTJlY4OzJAQ3WLUSFhQT2estG0pdfU9pvIhI6gE68vQYzo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(39860400002)(136003)(376002)(366004)(396003)(346002)(451199018)(316002)(478600001)(6636002)(110136005)(6506007)(53546011)(33964004)(5660300002)(2616005)(6666004)(26005)(6512007)(186003)(31686004)(31696002)(36756003)(6486002)(86362001)(38100700002)(66574015)(83380400001)(66946007)(8676002)(2906002)(66556008)(66476007)(8936002)(41300700001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Vld5dk1jK21tdmZ6cDhOUUFZK0FUdW9CTDFNODNRUkorc0pCQ3doZVZ1RThj?=
 =?utf-8?B?Z3YvUkJZMGlqWmozcE9NYUlZTnFsSXlqNllCQTByN2FBbEZHWm9iUjU2RE9U?=
 =?utf-8?B?MG5uNzMzcFd3TDZ4NGJ1a2hPM04xM21iNndWdWNnaTdNUitmMWZpR25pM0g4?=
 =?utf-8?B?aVVFT3BWdVlQakErWjJzR0gvSER4d09oNVpNYUlkODZ5VWg0bnJXeXZTNFdN?=
 =?utf-8?B?SFNOM0p6NkJRLzh5Ry93bzBQNktRT0tiZFZIVzlMZDJxZGM3K20xRXE4cDM5?=
 =?utf-8?B?WlFTQkZHcmRaeHlkU1F0MWQ3OFlVaVBqQThkT2ZVL1J5SjlhSTRKbGc5SlNH?=
 =?utf-8?B?bEFTTSs1bTVBZzlsNEJCVDRjTm04TXRaMktzK0pPak5vWnBNbUJqelRLVHJ6?=
 =?utf-8?B?bktpZWhjK1kzSG9xb1FORU53VGZOajNRcm5nV2hoR3hBWU1yVElveHQ0S0dO?=
 =?utf-8?B?RHV4cUJLVDU2MEJvTWFGeXc5TktpUjdTTU82WGlWZFRISG1Ya0U2cERFT3BV?=
 =?utf-8?B?ZnVkVm5JdzkrbzBPeVFpN3hsazFnWDZCTCt6UzBOMXFwRFlocmtlVDFOSmRD?=
 =?utf-8?B?ZHV4VHl4dXpNR3JqeXBwSmZUNzlBM1Z3bjE3L2tGdHFoQ0ZhazhuNlFhbTgv?=
 =?utf-8?B?eWNRNVVCTitHd0VQRU5idTBYeFMwSnZ1eElNaU1PaU92ZHlSbkZ6QTYyek9y?=
 =?utf-8?B?N1pRZ2w3ZHZYN2g2YWRpL21oT3FONHFKd0czUEQ5dFc0RFU1MXNudkJQam5G?=
 =?utf-8?B?T0xnZExmVzNFWlZLZGtBZ29CcHVUSyt2ZUN0QUM0eE1HOERobmRJMU82dmNl?=
 =?utf-8?B?bXcvOWFRZnVmbmVlSXE3M09sR1o0YWhmVy84WSswREJMTGROMGhjbmN6engr?=
 =?utf-8?B?bkZVcm9kWHdZYnRiU09GWlN1UFVVczYydGNESnFuZmNFaytvVjU5MjVwNG85?=
 =?utf-8?B?bDVIazN4TGdESW1BUDMvOUpiWkF0cUkrejhWYnhocHV5bmliTjhkbmNyQno0?=
 =?utf-8?B?WEU4ZmRVS0dZNUI2alFMazUzSS9jU3B2blFaUG93U2RtRlNQNVNkYWFHM3lm?=
 =?utf-8?B?clhabzBIbnRHT3NiTXUzQmhSMFB5RXZpRWJKc0RaTlgvQXVyN0gxbkdlelQ4?=
 =?utf-8?B?MG83ZGpaRnFqdkdmbmx6V3daNTNBdStyU2hZL1U2R2tSd3RtVWV5V1J4TUhh?=
 =?utf-8?B?UWs1eG43ZjdqbEYwNTVSeFQ2MUhRc1VJWXJ6U29TRlc2WDRRUm9lSFB6emVG?=
 =?utf-8?B?N1dIUVZNV2hWZXB0NSs5MUlyLzY0aHhQa1ZOalZsUzVtZXVwY1pGOHhCOEVv?=
 =?utf-8?B?RC9wRzlCOVJqRnRUdFdlTU1JMGMvSkF3TnZzYVVxdjZ1OTdyeGVnSUpJcWxE?=
 =?utf-8?B?ZEFXVEhwSWhKWDVWQkduVGxSTmdTS1F0RTBUSVZtdjFGMHFtWnhVSmdFU2Vn?=
 =?utf-8?B?MG8yRXplRDVodXNsVVJLOGJjclJXcFQwZXNLaTJuMmVobTJ0SktYUVpsWERt?=
 =?utf-8?B?WGllbEE3MVBjZGFyTnhTYzdwcnlqM1Qrb1ljVTJpU2ppUWlYbTBsbmlYMU52?=
 =?utf-8?B?aFdsL3RwNEwvNTBZY1VMcnI5QnhGSUZpUkpNS0gyWWtIUkExdDB6WStPdWh5?=
 =?utf-8?B?Rlo2cGdtTTNNUkZwYWVHR0VTdFJNM3VuQlJqWG4vREl5TzJSK0xwZWFqQ1N1?=
 =?utf-8?B?Z2RzY2liUzQzT3FHMHVEV1NYMHJXSzRwa2pvbWY1K0dVSDdySDFQb2JXZEZF?=
 =?utf-8?B?OEVyVVA5ZHhxYTF1SEpQYUNWQVdDTk01Zk8zK05ZSDdocDgyUkkyQ05wZ0dM?=
 =?utf-8?B?T3VtdWF2Qk9kTk1wOHZ4aTZCdDhtaG5Zb0JNUG51VExGZUdMb1BTdWRTdVRi?=
 =?utf-8?B?bkVsRUlnRXBLQnBOYnp4WFU3SVAyRHhBMGhtSmtVVndaMTZpK0FUWlFGbWln?=
 =?utf-8?B?S09iV015Mmd3MjJZOXM2ajZFOXQwVVIrZ2ZtNS9SNFZIU0t1VTNUNnpKOU9Z?=
 =?utf-8?B?a0ltczFFWHl5aHltMHpLdjYybTY3bXAzVXd5WTlOUlo3eVBjS3RhV3M2eGVu?=
 =?utf-8?B?N0w3YWR0RXUyc2JaS2JVZ2xhcEVFdkNzWnlaTFlOWHc3enhDeFdLajlrMFBD?=
 =?utf-8?Q?wCHLcJO0sd+9xtY6DOKad3ORb?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2bd9e0c-5405-44ef-bd50-08db0818f198
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2023 08:05:43.0800 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i1cfvbUReIDSx7XNXQjB+r6ru5CAG5PwgyKUG8dLwmLQwQBuIjuYSsmP72dZgI0B
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4962
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

--------------9kbFj8nVSwdJo9OitOTjLHm2
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 06.02.23 um 08:23 schrieb Xiao, Jack:
>
> [AMD Official Use Only - General]
>
> >> Nope, that is not related to any hw state.
>
> can use other flag.
>
> >> It's simply not allowed to free up resources during suspend since 
> those can't be acquired again during resume.
>
> The in_suspend flag is set at the beginning of suspend and unset at 
> the end of resume. It can’t filter the case you mentioned.
>

Why not? This is exactly what it should do.

> Do you know the root cause of these cases hitting the issue? So that 
> we can get an exact point to warn the freeing up behavior.
>

Well the root cause are programming errors. See between suspending and 
resuming you should not allocate nor free memory.

Otherwise we can run into trouble. And this check here is one part of 
that, we should probably add another warning during allocation of 
memory. But this here is certainly correct.

Regards,
Christian.

> Thanks,
>
> Jack
>
> *From:* Christian König <ckoenig.leichtzumerken@gmail.com>
> *Sent:* Friday, February 3, 2023 9:20 PM
> *To:* Xiao, Jack <Jack.Xiao@amd.com>; Koenig, Christian 
> <Christian.Koenig@amd.com>; amd-gfx@lists.freedesktop.org; Deucher, 
> Alexander <Alexander.Deucher@amd.com>
> *Subject:* Re: [PATCH] drm/amdgpu: only WARN freeing buffers when DMA 
> is unavailable
>
> Nope, that is not related to any hw state.
>
> It's simply not allowed to free up resources during suspend since 
> those can't be acquired again during resume.
>
> We had a couple of cases now where this was wrong. If you get a 
> warning from that please fix the code which tried to free something 
> during suspend instead.
>
> Regards,
> Christian.
>
> Am 03.02.23 um 07:04 schrieb Xiao, Jack:
>
>     [AMD Official Use Only - General]
>
>     >> It's simply illegal to free up memory during suspend.
>
>     Why? In my understanding, the limit was caused by DMA shutdown.
>
>     Regards,
>
>     Jack
>
>     *From:* Koenig, Christian <Christian.Koenig@amd.com>
>     <mailto:Christian.Koenig@amd.com>
>     *Sent:* Thursday, February 2, 2023 7:43 PM
>     *To:* Xiao, Jack <Jack.Xiao@amd.com> <mailto:Jack.Xiao@amd.com>;
>     amd-gfx@lists.freedesktop.org; Deucher, Alexander
>     <Alexander.Deucher@amd.com> <mailto:Alexander.Deucher@amd.com>
>     *Subject:* AW: [PATCH] drm/amdgpu: only WARN freeing buffers when
>     DMA is unavailable
>
>     Big NAK to this! This warning is not related in any way to the hw
>     state.
>
>     It's simply illegal to free up memory during suspend.
>
>     Regards,
>
>     Christian.
>
>     ------------------------------------------------------------------------
>
>     *Von:*Xiao, Jack <Jack.Xiao@amd.com>
>     *Gesendet:* Donnerstag, 2. Februar 2023 10:54
>     *An:* amd-gfx@lists.freedesktop.org
>     <amd-gfx@lists.freedesktop.org>; Deucher, Alexander
>     <Alexander.Deucher@amd.com>; Koenig, Christian
>     <Christian.Koenig@amd.com>
>     *Cc:* Xiao, Jack <Jack.Xiao@amd.com>
>     *Betreff:* [PATCH] drm/amdgpu: only WARN freeing buffers when DMA
>     is unavailable
>
>     Reduce waringings, only warn when DMA is unavailable.
>
>     Signed-off-by: Jack Xiao <Jack.Xiao@amd.com>
>     ---
>      drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 3 ++-
>      1 file changed, 2 insertions(+), 1 deletion(-)
>
>     diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>     b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>     index 2d237f3d3a2e..e3e3764ea697 100644
>     --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>     +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>     @@ -422,7 +422,8 @@ void amdgpu_bo_free_kernel(struct amdgpu_bo
>     **bo, u64 *gpu_addr,
>              if (*bo == NULL)
>                      return;
>
>     - WARN_ON(amdgpu_ttm_adev((*bo)->tbo.bdev)->in_suspend);
>     + WARN_ON(amdgpu_ttm_adev((*bo)->tbo.bdev)->in_suspend &&
>     +
>     !amdgpu_ttm_adev((*bo)->tbo.bdev)->ip_blocks[AMD_IP_BLOCK_TYPE_SDMA].status.hw);
>
>              if (likely(amdgpu_bo_reserve(*bo, true) == 0)) {
>                      if (cpu_addr)
>     -- 
>     2.37.3
>

--------------9kbFj8nVSwdJo9OitOTjLHm2
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    Am 06.02.23 um 08:23 schrieb Xiao, Jack:<br>
    <blockquote type="cite" cite="mid:MW3PR12MB4458263C5E9B1071F7831EF7EFDA9@MW3PR12MB4458.namprd12.prod.outlook.com">
      
      <meta name="Generator" content="Microsoft Word 15 (filtered
        medium)">
      <!--[if !mso]><style>v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
w\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style><![endif]-->
      <style>@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}@font-face
	{font-family:DengXian;
	panose-1:2 1 6 0 3 1 1 1 1 1;}@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}@font-face
	{font-family:"\@DengXian";
	panose-1:2 1 6 0 3 1 1 1 1 1;}p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}p.msipheaderdf3d92d6, li.msipheaderdf3d92d6, div.msipheaderdf3d92d6
	{mso-style-name:msipheaderdf3d92d6;
	mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}span.EmailStyle19
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:windowtext;}.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}div.WordSection1
	{page:WordSection1;}</style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext="edit" spidmax="1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext="edit">
<o:idmap v:ext="edit" data="1" />
</o:shapelayout></xml><![endif]-->
      <div class="WordSection1">
        <p class="msipheaderdf3d92d6" style="margin:0in"><span style="font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:blue">[AMD
            Official Use Only - General]</span><o:p></o:p></p>
        <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
        <p class="MsoNormal">&gt;&gt; Nope, that is not related to any
          hw state.<o:p></o:p></p>
        <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
        <p class="MsoNormal">can use other flag.<o:p></o:p></p>
        <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
        <p class="MsoNormal" style="margin-bottom:12.0pt">&gt;&gt; It's
          simply not allowed to free up resources during suspend since
          those can't be acquired again during resume.<o:p></o:p></p>
        <p class="MsoNormal">The in_suspend flag is set at the beginning
          of suspend and unset at the end of resume. It can’t filter the
          case you mentioned.</p>
      </div>
    </blockquote>
    <br>
    Why not? This is exactly what it should do.<br>
    <br>
    <blockquote type="cite" cite="mid:MW3PR12MB4458263C5E9B1071F7831EF7EFDA9@MW3PR12MB4458.namprd12.prod.outlook.com">
      <div class="WordSection1">
        <p class="MsoNormal"><o:p></o:p></p>
        <p class="MsoNormal">Do you know the root cause of these cases
          hitting the issue? So that we can get an exact point to warn
          the freeing up behavior.</p>
      </div>
    </blockquote>
    <br>
    Well the root cause are programming errors. See between suspending
    and resuming you should not allocate nor free memory.<br>
    <br>
    Otherwise we can run into trouble. And this check here is one part
    of that, we should probably add another warning during allocation of
    memory. But this here is certainly correct.<br>
    <br>
    Regards,<br>
    Christian.<br>
    <br>
    <blockquote type="cite" cite="mid:MW3PR12MB4458263C5E9B1071F7831EF7EFDA9@MW3PR12MB4458.namprd12.prod.outlook.com">
      <div class="WordSection1">
        <p class="MsoNormal"><o:p></o:p></p>
        <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
        <p class="MsoNormal">Thanks,<o:p></o:p></p>
        <p class="MsoNormal">Jack<o:p></o:p></p>
        <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
        <div>
          <div style="border:none;border-top:solid #E1E1E1
            1.0pt;padding:3.0pt 0in 0in 0in">
            <p class="MsoNormal"><b>From:</b> Christian König
              <a class="moz-txt-link-rfc2396E" href="mailto:ckoenig.leichtzumerken@gmail.com">&lt;ckoenig.leichtzumerken@gmail.com&gt;</a>
              <br>
              <b>Sent:</b> Friday, February 3, 2023 9:20 PM<br>
              <b>To:</b> Xiao, Jack <a class="moz-txt-link-rfc2396E" href="mailto:Jack.Xiao@amd.com">&lt;Jack.Xiao@amd.com&gt;</a>; Koenig,
              Christian <a class="moz-txt-link-rfc2396E" href="mailto:Christian.Koenig@amd.com">&lt;Christian.Koenig@amd.com&gt;</a>;
              <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a>; Deucher, Alexander
              <a class="moz-txt-link-rfc2396E" href="mailto:Alexander.Deucher@amd.com">&lt;Alexander.Deucher@amd.com&gt;</a><br>
              <b>Subject:</b> Re: [PATCH] drm/amdgpu: only WARN freeing
              buffers when DMA is unavailable<o:p></o:p></p>
          </div>
        </div>
        <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
        <p class="MsoNormal" style="margin-bottom:12.0pt">Nope, that is
          not related to any hw state.<br>
          <br>
          It's simply not allowed to free up resources during suspend
          since those can't be acquired again during resume.<br>
          <br>
          We had a couple of cases now where this was wrong. If you get
          a warning from that please fix the code which tried to free
          something during suspend instead.<br>
          <br>
          Regards,<br>
          Christian.<o:p></o:p></p>
        <div>
          <p class="MsoNormal">Am 03.02.23 um 07:04 schrieb Xiao, Jack:<o:p></o:p></p>
        </div>
        <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
          <p class="msipheaderdf3d92d6" style="margin:0in"><span style="font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:blue">[AMD
              Official Use Only - General]</span><o:p></o:p></p>
          <p class="MsoNormal">&nbsp;<o:p></o:p></p>
          <p class="MsoNormal">&gt;&gt; It's simply illegal to free up
            memory during suspend.<o:p></o:p></p>
          <p class="MsoNormal">Why? In my understanding, the limit was
            caused by DMA shutdown.<o:p></o:p></p>
          <p class="MsoNormal">&nbsp;<o:p></o:p></p>
          <p class="MsoNormal">Regards,<o:p></o:p></p>
          <p class="MsoNormal">Jack<o:p></o:p></p>
          <p class="MsoNormal">&nbsp;<o:p></o:p></p>
          <div>
            <div style="border:none;border-top:solid #E1E1E1
              1.0pt;padding:3.0pt 0in 0in 0in">
              <p class="MsoNormal"><b>From:</b> Koenig, Christian <a href="mailto:Christian.Koenig@amd.com" moz-do-not-send="true">
                  &lt;Christian.Koenig@amd.com&gt;</a> <br>
                <b>Sent:</b> Thursday, February 2, 2023 7:43 PM<br>
                <b>To:</b> Xiao, Jack <a href="mailto:Jack.Xiao@amd.com" moz-do-not-send="true">&lt;Jack.Xiao@amd.com&gt;</a>;
                <a href="mailto:amd-gfx@lists.freedesktop.org" moz-do-not-send="true" class="moz-txt-link-freetext">amd-gfx@lists.freedesktop.org</a>;
                Deucher, Alexander
                <a href="mailto:Alexander.Deucher@amd.com" moz-do-not-send="true">&lt;Alexander.Deucher@amd.com&gt;</a><br>
                <b>Subject:</b> AW: [PATCH] drm/amdgpu: only WARN
                freeing buffers when DMA is unavailable<o:p></o:p></p>
            </div>
          </div>
          <p class="MsoNormal">&nbsp;<o:p></o:p></p>
          <div>
            <p class="MsoNormal">Big NAK to this! This warning is not
              related in any way to the hw state.<o:p></o:p></p>
          </div>
          <div>
            <p class="MsoNormal">&nbsp;<o:p></o:p></p>
          </div>
          <div>
            <p class="MsoNormal">It's simply illegal to free up memory
              during suspend.<o:p></o:p></p>
          </div>
          <div>
            <p class="MsoNormal">&nbsp;<o:p></o:p></p>
          </div>
          <div>
            <p class="MsoNormal">Regards,<o:p></o:p></p>
          </div>
          <div>
            <p class="MsoNormal">Christian.<o:p></o:p></p>
          </div>
          <p class="MsoNormal">&nbsp;<o:p></o:p></p>
          <div class="MsoNormal" style="text-align:center" align="center">
            <hr width="98%" size="2" align="center">
          </div>
          <div id="divRplyFwdMsg">
            <p class="MsoNormal"><b><span style="color:black">Von:</span></b><span style="color:black"> Xiao, Jack &lt;<a href="mailto:Jack.Xiao@amd.com" moz-do-not-send="true" class="moz-txt-link-freetext">Jack.Xiao@amd.com</a>&gt;<br>
                <b>Gesendet:</b> Donnerstag, 2. Februar 2023 10:54<br>
                <b>An:</b> <a href="mailto:amd-gfx@lists.freedesktop.org" moz-do-not-send="true" class="moz-txt-link-freetext">amd-gfx@lists.freedesktop.org</a>
                &lt;<a href="mailto:amd-gfx@lists.freedesktop.org" moz-do-not-send="true" class="moz-txt-link-freetext">amd-gfx@lists.freedesktop.org</a>&gt;;
                Deucher, Alexander &lt;<a href="mailto:Alexander.Deucher@amd.com" moz-do-not-send="true" class="moz-txt-link-freetext">Alexander.Deucher@amd.com</a>&gt;;
                Koenig, Christian &lt;<a href="mailto:Christian.Koenig@amd.com" moz-do-not-send="true" class="moz-txt-link-freetext">Christian.Koenig@amd.com</a>&gt;<br>
                <b>Cc:</b> Xiao, Jack &lt;<a href="mailto:Jack.Xiao@amd.com" moz-do-not-send="true" class="moz-txt-link-freetext">Jack.Xiao@amd.com</a>&gt;<br>
                <b>Betreff:</b> [PATCH] drm/amdgpu: only WARN freeing
                buffers when DMA is unavailable</span>
              <o:p></o:p></p>
            <div>
              <p class="MsoNormal">&nbsp;<o:p></o:p></p>
            </div>
          </div>
          <div>
            <div>
              <p class="MsoNormal" style="margin-bottom:12.0pt">Reduce
                waringings, only warn when DMA is unavailable.<br>
                <br>
                Signed-off-by: Jack Xiao &lt;<a href="mailto:Jack.Xiao@amd.com" moz-do-not-send="true" class="moz-txt-link-freetext">Jack.Xiao@amd.com</a>&gt;<br>
                ---<br>
                &nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 3 ++-<br>
                &nbsp;1 file changed, 2 insertions(+), 1 deletion(-)<br>
                <br>
                diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
                b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c<br>
                index 2d237f3d3a2e..e3e3764ea697 100644<br>
                --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c<br>
                +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c<br>
                @@ -422,7 +422,8 @@ void amdgpu_bo_free_kernel(struct
                amdgpu_bo **bo, u64 *gpu_addr,<br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (*bo == NULL)<br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return;<br>
                &nbsp;<br>
                -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                WARN_ON(amdgpu_ttm_adev((*bo)-&gt;tbo.bdev)-&gt;in_suspend);<br>
                +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                WARN_ON(amdgpu_ttm_adev((*bo)-&gt;tbo.bdev)-&gt;in_suspend
                &amp;&amp;<br>
                +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
!amdgpu_ttm_adev((*bo)-&gt;tbo.bdev)-&gt;ip_blocks[AMD_IP_BLOCK_TYPE_SDMA].status.hw);<br>
                &nbsp;<br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (likely(amdgpu_bo_reserve(*bo, true) == 0))
                {<br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (cpu_addr)<br>
                -- <br>
                2.37.3<o:p></o:p></p>
            </div>
          </div>
        </blockquote>
        <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
      </div>
    </blockquote>
    <br>
  </body>
</html>

--------------9kbFj8nVSwdJo9OitOTjLHm2--
