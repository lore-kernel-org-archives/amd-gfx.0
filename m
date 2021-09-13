Return-Path: <SRS0=miQW=OD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8FFAC433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Sep 2021 15:19:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C78960FE6
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Sep 2021 15:19:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5C78960FE6
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6DF9389FCC;
	Mon, 13 Sep 2021 15:19:12 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2089.outbound.protection.outlook.com [40.107.212.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E249389FCC
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Sep 2021 15:19:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AdVBl7NLmExecmp34Xb+g3tU6f4eNh3fbOXiKP3NlUraMrt7sAN/vK4BWpviiSTMr+D6bevR5B6BfswQbojt9Tfaes012isNUoJaJOcSZGaWof3b8leIurTl7iYLWZ0eBq4M+ptOeKVnrxWkLfx2CWVyr1bW0PRIH/q1vkkg0wKqtJqjKi4fhvNsPPzJofbULbH9tu+3+A2Kuno5vbxVVmYALF8wVudQQVA0pEMaL8CJyyIwfEHel+Cm7z8GfldlTBnmwTMI2L8YEUNXMcprm9ZanyxR3VgI/ZZQSqpdop4bcSa9c1dtdFjMAJhiBqsYqFjJwZXy17Xh9iVcegmayg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=y37toI6aIXimhdIzNchaLwmFaCPo76nMz4WqVkR/q4I=;
 b=XlYf7YOAEP0/DAKVRsmpixwxcsaYQBkvi4LraDx5Dm7aOtan+Z8x3P5rT7hNZwmskF5WkqnViT/YwMIa+kkVsmcO2WCSD2SDuBC4K+qeDk2ovUMndrTgs8KOcVVXVdTBrTsYafLUVZV9HAkVEo319tuFu31piPIdonRNPTe1etMAYreN+6uHem6VQ5wqPSO7pbYfPk9IAHdTjemfN14wMxuaCckq3eqILCvBPIVB6T6SAk5cnfukWwOUZOEono9gcRao4/v6P9mYTiABboEFo6BwIjo46rUvkKGSE6nKDGvH1d4DWuUM/xN4nmldfOP/54mQ4GNKqGK3gigBmEt6RQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y37toI6aIXimhdIzNchaLwmFaCPo76nMz4WqVkR/q4I=;
 b=ub/7WUuHpcvIjYmLx+NiiLOh0JZK6IVNQqy50QJuOrVctMv1Y7TTQiwZu/FuQjb2e6RQ4VTxBsqfVWO42p/d85Q8jXsTP3L3NvuezfRZ9/iIB67da+uIlBiLQHABFeuCn26ta0iV7lhROA98sxRn7rkQEb3H8JOg0Z70AjF5z6M=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5133.namprd12.prod.outlook.com (2603:10b6:5:390::6) by
 DM8PR12MB5430.namprd12.prod.outlook.com (2603:10b6:8:28::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4500.16; Mon, 13 Sep 2021 15:19:08 +0000
Received: from DM4PR12MB5133.namprd12.prod.outlook.com
 ([fe80::344d:ea6f:fb1d:ddc8]) by DM4PR12MB5133.namprd12.prod.outlook.com
 ([fe80::344d:ea6f:fb1d:ddc8%9]) with mapi id 15.20.4500.018; Mon, 13 Sep 2021
 15:19:08 +0000
Subject: Re: [PATCH] drm/amdkfd: Cast atomic64_read return value
To: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 "Pan, Xinhui" <Xinhui.Pan@amd.com>
Cc: Lyude Paul <lyude@redhat.com>, amd-gfx@lists.freedesktop.org
References: <20210913141946.1884173-1-michel@daenzer.net>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <06496dcf-67cd-6695-e993-23d46dfd91e9@amd.com>
Date: Mon, 13 Sep 2021 11:19:06 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <20210913141946.1884173-1-michel@daenzer.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: YT1PR01CA0072.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2d::11) To DM4PR12MB5133.namprd12.prod.outlook.com
 (2603:10b6:5:390::6)
MIME-Version: 1.0
Received: from [192.168.2.100] (142.186.47.3) by
 YT1PR01CA0072.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2d::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4500.14 via Frontend Transport; Mon, 13 Sep 2021 15:19:08 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 68a4aad1-38cc-45fc-23e4-08d976c9d509
X-MS-TrafficTypeDiagnostic: DM8PR12MB5430:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM8PR12MB543044A93D260472528FAFC392D99@DM8PR12MB5430.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2uVfq6c7chPMSjJ2RTD565QluSZRgTBiizgK+eYDL52/iEI5MLZ4ooiVeIJVlqDPamLYXCNeWy00oSzdmxc3x04A/DTyX9BMCP97s7yurKVMLA1JJxRYnyL4DeZnF+QkSDfwP2cPtqDs6D6Qpxv5dNqjGoj8qIQ4YwRwMiByIibwjmFDn0LLWVI0fTn61m68r9Hr+7HiyWkCju5syvrIwI9C6WUD6oskA5LqusBDuL97jsXizGN7Zq5DP70qi59iokV2f3GfZGirSsrDDjJmYjPYdLUOGRe/vgO7xqX55PaakxaDBjNwNXBlHpTpQ7H6GrEiNUP8poUDz2yzDjR9BD1d2S/O1W+8GLAIv3urvwTAp25WtWahdhKXTnYE9l4ArHP+7YzUyzDRxAy+fhDx5BrJcvzbkKJPTEJV6Kh+zjsFU5LNkUzgH8F63ugt+ziSZjCjUm9r5y5Sespyz3OpidH/jSB/nCxhFyl697r2f4ZrcbcqDENrFnTLRLwDWzf9E+TOulc/sVmunqlb2ImSng3hEcmdIgvne9IRD8mp6lkaRikWXKqWyw1X0sjVh/kGUsimWH3qSpsW8un4eC9VDLY0eXh29KTxkIPf01oYV4S7zS1+iz4srlw/KJHRg7YO9QiMxlGSAvJnRbwpuhBuy9PGExZq/51eCqaXIg3QLJIeZijQFCY0cCFqnH1lzLSw0sGt4+khZWdXez9mGYaFHnB05fx5p92MFGDhAfY9dYU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5133.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(4326008)(2906002)(6486002)(38100700002)(8676002)(2616005)(26005)(110136005)(44832011)(5660300002)(508600001)(66476007)(956004)(66946007)(66556008)(6636002)(66574015)(186003)(316002)(8936002)(31696002)(36756003)(16576012)(31686004)(86362001)(83380400001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b3g5c0VEbk5lcld1d1Rha29JaTlZZ0lxeCttemhVa3U3cnN4SWxtTDk1OTdN?=
 =?utf-8?B?dHRRSUhlRUFrRFQ5ZDg0NzJRRkhCZVlxUFJBcEpaS2g5VWV5THNyZWdQTTFv?=
 =?utf-8?B?WTB3SEtZOE5laGxqUmZTRTZoZCt1MDM1Q3BJNUFCZ0JhNU85OVRFUFdBNUU1?=
 =?utf-8?B?WjJVL2oydTNHd3Q4VzA4NzBrQkdOZ3M4MzFkQkxPYkdIWGQ2b1pJb0g4M2Fu?=
 =?utf-8?B?L0xyYm4zdUJrNzJLejRzZHRoN3ZKdDZBaVdYZnBubENNWUl2bGcyZmRLQ3d3?=
 =?utf-8?B?ZDNnb3hpb3BxcVBOTjFNYlA2SUp1c0I3ZGN3Rm9wTGxPNVd5WE0zZ0E1MkJQ?=
 =?utf-8?B?N0R1S2RXdVZUMlNueEpBcGU3M0xDUk1ZbVVLR05hWnNDZ0dqMFdZbzR3VWd6?=
 =?utf-8?B?ZGJEbEhSQU9sanlWNFhiRVV6aWlQRG9jRlYwYm1aeEdkaXVHQ1lLcnlyRlha?=
 =?utf-8?B?QVdzY01nK0FtNW15V2pTREMrKzA5aTRXTVcxWDkybFMzQWE0a3QyWEh2WjNw?=
 =?utf-8?B?QjBKa05Gbm5LRU5ud2todTRqU0ZoaTdhMk91UFl4RzI2d3YzMlFYUlF5NjZ4?=
 =?utf-8?B?ZUhodlhqNjExYnFjL0g2Nk1yVkhFSEM1SFNnL1ZIcjFsVjIyVXhWNHJiUDJW?=
 =?utf-8?B?M0VQNUkzZVFVbTQxemtJNjcyalFyVjlJcDBTanFPWHBsSEZEMWdMS0NVVk5M?=
 =?utf-8?B?ZmNRWHNnUnYyUTV4bmRrRDA1ZlFWcWxyd3ZFamJnYVRFTUNWU3RmQzFaR0lW?=
 =?utf-8?B?bXBWUzhQMkZjWmJrdTArZEZtek1iZjYwbE5CckZqZC9lRkRLMlo4NGVXLzFo?=
 =?utf-8?B?c2RpdnNhU1BxY0NzbEpZWGxHa0piMVEwejF5SVVRMHBUdTNKeHIxeHh4OGRS?=
 =?utf-8?B?THRkNG8wS29SRkdINkhkalozanlpYmdSd0lNcjZzbW9DTXh4R0kxd2ptbUZ1?=
 =?utf-8?B?bUhGTFpyc2txek5WY3pVZGlSRWpYUHdza3laNkI4V0MyKzh1d3hsWTVkbHly?=
 =?utf-8?B?ZGpNSDd1bEgrTzdqdkViSEU4SGdvMHY2WDV4VGdTa25jRE4veFFhWjg4SjNG?=
 =?utf-8?B?V3I2S3RtMjdydWtSSjRhZXBOZUp0dlNqZmJZOHJaUk9LQWpNRFVMalM3YzE4?=
 =?utf-8?B?azJWQmM5MjdVS2JoODBhbkdFemc2KzdkdXk0M2lXWmtSZkdGZVEyVjRhYzJh?=
 =?utf-8?B?MG9kU25aTFA1YmZleW9BNU51RnRuTEx4M0xnaVU1V0VBUzFFaDhjQVp0djV0?=
 =?utf-8?B?V3ZZdURZanFHdWJnU3NXeUxrRlorVnFFLzYveU8zY0ZWL2dEazFlZVVNN2Q1?=
 =?utf-8?B?cFkrT1E1NkZBZVRFVkw0S0JaSmdZRjFScDRnQ3haang3SjdkdktNS3NkTmRt?=
 =?utf-8?B?VWsrMjlpcTlRWVd3K1NTTUQyN2l0cEQzSXpCQm9uSWNmM0ZYbzM1L2x6Zys3?=
 =?utf-8?B?YklpLzc1TEhIdnpVQlNXSjhLOFpqaWY3Yi9tWDZTakljR1pDbkZQMytGc0J5?=
 =?utf-8?B?U1gxSkNxdjNZd0NrS0RPRkErRk0vTWpKVFhlcHo1eHBwU1p5ZkVVVURLcE1R?=
 =?utf-8?B?c3QrQlNyakxNS0ZuRnVYQmRKZDJoalZZeXg5NllzN0pXSWRRdEhnZUlKcDlW?=
 =?utf-8?B?eG4vQWwzcXdEM3I1VkRmWTlnUzgwcmJUTGJJdW1VUFQ4bFdsc1FKeGJFd2ls?=
 =?utf-8?B?M1ZsL3JGU3pDSXFSSk5jY2lQNkltbWkvc2V2aS9xd01peTVQU0p1NnYyVTVC?=
 =?utf-8?Q?hLxVVPwNtftOPSwMCobZSWU34BsJR/TWCmu3sVg?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68a4aad1-38cc-45fc-23e4-08d976c9d509
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5133.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2021 15:19:08.5878 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HqhoxgedYij1mWnAheITEgbANhk3hY1GoNUU5e+kjj7IW97aSQlU2UnxL83b2dnWY6LuT10aL5iuLMPcghRaow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5430
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

Am 2021-09-13 um 10:19 a.m. schrieb Michel Dänzer:
> From: Michel Dänzer <mdaenzer@redhat.com>
>
> Avoids warning with -Wformat:
>
>   CC [M]  drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_smi_events.o
> ../drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_smi_events.c: In function ‘kfd_smi_event_update_thermal_throttling’:
> ../drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_smi_events.c:224:60: warning: format ‘%llx’ expects argument of type
>  ‘long long unsigned int’, but argument 6 has type ‘long int’ [-Wformat=]
>   224 |         len = snprintf(fifo_in, sizeof(fifo_in), "%x %x:%llx\n",
>       |                                                         ~~~^
>       |                                                            |
>       |                                                            long long unsigned int
>       |                                                         %lx
>   225 |                        KFD_SMI_EVENT_THERMAL_THROTTLE, throttle_bitmask,
>   226 |                        atomic64_read(&adev->smu.throttle_int_counter));
>       |                        ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>       |                        |
>       |                        long int

That's weird. As far as I can see, atomic64_read is defined to return
s64, which should be the same as long long. Which architecture are you
on? For the record, these are the definition for x86 and x86_64 on Linux
5.13:

./arch/x86/include/asm/atomic64_32.h:static inline s64
arch_atomic64_read(const atomic64_t *v)
./arch/x86/include/asm/atomic64_64.h:static inline s64
arch_atomic64_read(const atomic64_t *v)

Looks like x86 uses int-ll64.h (64-bit types are long-long). Some other
architectures use int-l64.h (64-bit types are long). On architectures
that use int-l64.h, this patch just casts s64 (long) to u64 (unsigned
long), which doesn't fix the problem.

Regards,
  Felix


>
> Signed-off-by: Michel Dänzer <mdaenzer@redhat.com>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
> index ed4bc5f844ce..46e1c0cda94c 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
> @@ -223,7 +223,7 @@ void kfd_smi_event_update_thermal_throttling(struct kfd_dev *dev,
>  
>  	len = snprintf(fifo_in, sizeof(fifo_in), "%x %llx:%llx\n",
>  		       KFD_SMI_EVENT_THERMAL_THROTTLE, throttle_bitmask,
> -		       atomic64_read(&adev->smu.throttle_int_counter));
> +		       (u64)atomic64_read(&adev->smu.throttle_int_counter));
>  
>  	add_event_to_kfifo(dev, KFD_SMI_EVENT_THERMAL_THROTTLE,	fifo_in, len);
>  }
