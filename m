Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29F98C433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Jul 2022 21:07:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DE7D310EAC5;
	Mon, 25 Jul 2022 21:07:29 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2087.outbound.protection.outlook.com [40.107.100.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 35DF910EDE5
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Jul 2022 21:07:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=erHl7jM/jkWA6jgcMTyGDfg2e2dOEtg7gJU4Y+FtZ7e5mmRHI7d/25JfLcqUQXULdAXy7JfDbcOXCDx6ivu33wWSVLiPGk57wAQ3CylKtRHWoq9NQZDVUkY/LXZCLwqSzYlthpUxMNQegOUHRC5loNRzt5qLmxDANdGd6RLZE8NpOiJzj9aNVEeAeNmvAcFgjYh99UoK8cFIZRjuz4mNVVQde4Nm05YeuSav6fu0L2h1thTBml/F6H8iBSPidYKIXHsjxorl/CT3ILDzZ5nPs4hNembqEapBPMS+ccg63nJ5syy+s0+lg7A54OJLHEXnmmZZNgp/IfqZz2uIYxrjKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Np0Z+p4ZbrSyRree/2JOKjPgNdx/EajkvknX3XzjZfI=;
 b=abSkJaKH1x5b7I+LDB2KYUn15IAyZwvnu9VipL8Mf4Lwr4t7HgMoEhMO71Vwzpj12i+EQwSxEiALL+Bw0p4hy9CrG+PzqoNiEr7EwiBKhWukVKG3GAbV+DYvK2usqIFK7pKvJrsjDd0cUbSR7+6D+HQvPlA6fcfhXUqy9VjQMidnOt2cVFkSnOt6oEwnxz9GAWDOLz/MTAP4Xj3g+qo/t3v8wwXlhqnJmzBbS+b6/uPKt8cL3Gb1xLJuCfTeAHba1VpH5m3Khi047BlzCb7GAB5mCEu6rtjfeNNolEJP9/p07+Htbpsh/+hqfuzIeWO390bTx0/5xHLTQT8kNbx7fQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Np0Z+p4ZbrSyRree/2JOKjPgNdx/EajkvknX3XzjZfI=;
 b=IxGvXNcFoSthp39ZR+HLwpHtLs0MQr18/aCq4CTALVe+KIpas2XWNqPBbJ96r1ybcB7DH4z8PDx+GQN8XIfGa4xboxiUv2ucOaSzuPieqbhBTc/iaqQ2H2I27KDttoXv6YuGlxjsE0Ew/pMPHn75bH4Mu/8cX6jg2FG5hiDrJFA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1947.namprd12.prod.outlook.com (2603:10b6:3:111::23)
 by BN8PR12MB3588.namprd12.prod.outlook.com (2603:10b6:408:41::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.18; Mon, 25 Jul
 2022 21:07:25 +0000
Received: from DM5PR12MB1947.namprd12.prod.outlook.com
 ([fe80::9da9:705a:18ae:5e91]) by DM5PR12MB1947.namprd12.prod.outlook.com
 ([fe80::9da9:705a:18ae:5e91%9]) with mapi id 15.20.5458.024; Mon, 25 Jul 2022
 21:07:24 +0000
Message-ID: <3257a7ae-67c9-4905-d9d0-4539ce46f2cd@amd.com>
Date: Mon, 25 Jul 2022 17:07:22 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 2/5] drm/amdgpu: add debugfs amdgpu_reset_level
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 "Zhao, Victor" <Victor.Zhao@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20220722073403.5171-1-Victor.Zhao@amd.com>
 <20220722073403.5171-2-Victor.Zhao@amd.com>
 <30f6ef1d-a1b3-3228-37f5-3cfede6431b5@amd.com>
 <DM6PR12MB43400E00CDC78399E92D6FB6FA959@DM6PR12MB4340.namprd12.prod.outlook.com>
 <039ddc04-386f-4032-f9a8-bd9950507765@amd.com>
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
In-Reply-To: <039ddc04-386f-4032-f9a8-bd9950507765@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT2PR01CA0014.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:38::19) To DM5PR12MB1947.namprd12.prod.outlook.com
 (2603:10b6:3:111::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6fb0bfae-6808-4341-ad70-08da6e81ac4d
X-MS-TrafficTypeDiagnostic: BN8PR12MB3588:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ukszIYR3G6leiIe228LGADLR9XD3aHFN1ndn5LXGNggtAYe0Rj2jur+MnBP3Y1aAF3I2WRSxab9pbEoFDbiGUjI413yP5W67x5e5yxGLdrUsrgL4C0yv1rA6qKJ+WNenbtDXP/q78LseR/JJqHiZKh5hr7MRxW6H2f7Zf+AKV3ObrBsBcu0+xZI9+BAGCNy1ztbIzNHt//9meWVscrXCL8826sD8K3pU2vZMLXDXGgtASMg5ewpYEFqKxmrKDKhB2KfrSY+2uqV3zhGjfGNIeY4VKob7wvUtL0QYNAoulTCJB6lVhtBKG7WOebuM7cQuhAXOSCSYcH1YJoVIA1yZFRJ0kr4I7O2dQTniH0ycRyjSSAd+E7OZ2V2JRuZkLxy79icaPdVJX8F2U2quxe53vNJFPY2BUXauq+obmQyREh+RSikf+qXAD3kP3kw/hmbGFzzL5DnbIbAbHP6Y9ut1FlfIci4w+HQOEVmfuI/9bDaHKmfpFo26ohbayucmhJOzPWEEt0zlKMQpNpjFSoY20hVGWrY8wuhaj0T6jNbUqWf4ks+egq72PEaY7BOb+G+vFl73XdEqbnHmSxCrAzHhjVObFuuRHmVFqSuv4cXa7dmE1/zXK0OhB0SX9Z1Fu5yjIn9H9dp8jAwu1zYHBwtK1oo8HMrI4peXBwIv230GhlysZGWWqDjFpsBmiWFSSxX32GIc6t/butle0pfSFk/09Xhi4BDeFSNlDZs5AEwGbk5F3MMwSO1poMiCofqdiiQN81LzZY479X6NpnTuRSI1KlM4mqE4vpAZOGCvKCSopOO5g0PdBNT4LW6mxl+4UOEEev/pdsWi8nS74b+AIxCj1A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1947.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(39860400002)(346002)(376002)(396003)(366004)(136003)(6512007)(44832011)(86362001)(8936002)(5660300002)(6486002)(66556008)(53546011)(66476007)(8676002)(6506007)(4326008)(478600001)(41300700001)(31696002)(66946007)(36756003)(316002)(2906002)(54906003)(38100700002)(66574015)(186003)(2616005)(31686004)(110136005)(83380400001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MCt6bHhOdTEwczRDdXNrT0JTRnpTSW8va1FRSG1udUh2R0Z0SE42SGIvSUlk?=
 =?utf-8?B?MkNCL3Y3MG9NZjgxTjFKcENqV3N4NjZnZDFnc0dWOFVVTlN0NU9ucVZVRWxJ?=
 =?utf-8?B?MjNLVFgvaDVuRGgvSTU0MnB2N2pDQ1Q0UCtmNkw4NU5OOFVkcTNBZ3hnNXJ5?=
 =?utf-8?B?OGdjdEFnT251b2tCbFVLOVJ4UjhQMFhnS1ZzZ1IvZHhTYkgwelRaMUhHeHNV?=
 =?utf-8?B?ZlZEaFJhUGgxcnNmeHA5N0JyazVlWVJoeVRYdVlReDRyOUJqZjkrWDhHRndQ?=
 =?utf-8?B?Qjg3RFFFcTFDcGlpRWRIdFd6M09FSThLMTJYR3pGL2JsMUtjTjV2MWZYaDNK?=
 =?utf-8?B?ZHB5SEJNVG83OVI3K1lWKzVxTzVjSzFtZERRekhSMVlqWm1EdWI0bGtVQ3dW?=
 =?utf-8?B?N0tGUjQvSXZMTnhyVSthZXlIOEpjMlkvM3FTUy9JSlVrUExFUTZKekpIS2tn?=
 =?utf-8?B?WlNpbG51N3RXOFZhUnkramJEV2ZRRktXb3lvelZTTHE3UTRTY1BIU1l4ckFP?=
 =?utf-8?B?M2hsKzZxdkxwQXhDYTJINFhRWU1TWXErMXhXdW9OQjIrb2lhSVJMK0p2SUNY?=
 =?utf-8?B?STE4Y1NWZWRFd29wenhPMFBid1FQNW42ejdtdUdNRDgzTFZ0azZrcUpha1Vj?=
 =?utf-8?B?VVVySmtuWTUxL2VYR1g4Z2RESUFoTk1XdGdvalRCWHVXSXBGMjRaMXVWUWVu?=
 =?utf-8?B?aHplOXE4MzJIZVVzckpZRUUxNDl4YTJ2VWQ1T3hQNWpYZ2hHOTd4b2pLTVRN?=
 =?utf-8?B?WlIyak9BaldraVYrRlkrNlRGZzhoUzJjQ1VEUGR5MzUveUFZOEJudFBqRmdQ?=
 =?utf-8?B?ZmduMEhybzV5MzRKMnduZkhiMFRrb1Robjh2ZzFQa1RldTU4VmpUaHJCdjBV?=
 =?utf-8?B?QU1tcWUwekNDV3hLWFduNXpQbm1aSkJVbCtjbmxSREFUZGh3ckJrcFkrNHFl?=
 =?utf-8?B?eUR0TnpLVitrR1dubHhuT3o4NjdvWXAwSVNrcGtkWWF1MSs1cGtYTGl5OE1E?=
 =?utf-8?B?QXVLMlRZdVlKK2ZtWThTUnB6bHBJSitIUVdYbmdXTFJqZXA0K2htZjFFb3Rl?=
 =?utf-8?B?eUs3WVYveFVqUk40M0hteVdYdnA0SW1jc09aRkF1VndKenQ0REExa3l6M1J6?=
 =?utf-8?B?eGZyK3dPQm84TUY0ZEZnVmdFYTdjM2twWGlTWDI3YXAwWURQZXgzQ2UwbmU4?=
 =?utf-8?B?UkRRRitXTVEyYkNwd0xvMjluRjRqQXpHT3lvYnBSSTB5VXFZZk9jeWczTnRr?=
 =?utf-8?B?ZU5PQ3VZTFNSZ1ZrZWJPTTJKVW10VHk1S0tFVTZZQTFBa29oMk5BKy8rVWZ1?=
 =?utf-8?B?VWdRblVwN2l2Wjdjano4cHpoblVsSnl6U1hBTzlsNFZrWlpYY0F5MFhZY0xI?=
 =?utf-8?B?U3ZEN0dMaFJvUFQrNFZkejlVY3dKb0VrL1VIbzFkKzRRNDgrdDRQczNEV25a?=
 =?utf-8?B?M0gwb1dpaGx0dGVzS2E4WDh0b1NwZmV2MDVDOG9XVTBoa0J5M2lobEh6WTNP?=
 =?utf-8?B?Y2pMN1AzRHZ0WUNuNVFtSHZFb2RuMlRHYTdOWVIxTDFQa3lLQS84cXg2ZitO?=
 =?utf-8?B?dTVnOHEyUWxPbWlWaCtsN0c3UUFxRlRsb0J0NkVZZ2JLNThCNGhCZWM3d3BW?=
 =?utf-8?B?NmNMYVc1bmpWYWh5YlpQK2VjWG4zeFRabklSd2FzK1BOMHdRU3lUdU5oZzZ0?=
 =?utf-8?B?d0pxM2ZHMmFsbDM5T1pDV04xSGxYaWplZldQYXYzV3VweXFFTDhKZGRVd2Fk?=
 =?utf-8?B?am9Gc3ZwdVNibDNkbndsaThzVFZXMS9mc0wvZEpaRHZ0VUtPaEJxTzNMRmN0?=
 =?utf-8?B?bXptSjBMTHJQRzNMU0dwOWdUemxIV3ZpY296R0Qxd1FadmxERFNTanZZd1Fu?=
 =?utf-8?B?Q2hKeDNLUXYwelJNa3IxWVZEZk1ib1A2MUMwcnlBdGxlcm02M1ExNFc3SUZZ?=
 =?utf-8?B?TDB6TDg1SWpOZWJNcXZFczYwUndQeDFBVWNJQjJvbUtpdjMyKzBYNFV6V2Vs?=
 =?utf-8?B?V3F3ckVicWx2N1BIdjJDYkg0NmtKcGpsVXJwOFl1Z1JmV2RxTlVQMFh1ektF?=
 =?utf-8?B?bE1zek5mbEszZ3QveWY3K1pwOUIzVXFDOGlCVzN4ZlFRS0dpR1JmWERTeEph?=
 =?utf-8?B?ck1PR0ZTeXc1OVJ4OUJUcWkvRmhyaThNQklyVlJiR3UyaVd6ZGEzb3NwR2xB?=
 =?utf-8?Q?EPe9REuiy1FYdm/sL6EgN7i5vmCS+bSGrgujf4Awg0R3?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fb0bfae-6808-4341-ad70-08da6e81ac4d
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1947.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2022 21:07:24.8361 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +Gp0FRKkr9x8iSZSlyh4XBWtraey5KROZkTTMDh4BcnLjAU42O7n+zeLFNFuHVgZNyNUJXW59F27MO64AUANLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3588
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Deng,
 Emily" <Emily.Deng@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 2022-07-25 13:37, Christian König wrote:
> Hi Victor,
>
> Am 25.07.22 um 12:45 schrieb Zhao, Victor:
>> [AMD Official Use Only - General]
>>
>> Hi @Grodzovsky, Andrey,
>>
>> Please help review the series, thanks a lot.
>>
>> Hi @Koenig, Christian,
>>
>> I thought a module parameter will be exposed to a common user, this 
>> control was added to help debug and test so I put it as a debugfs. I 
>> can make it module parameter if more appropriate.
>
> That's a really good argument. I leave the decision if we should use a 
> module parameter or debugfs file to Andrey.
>
> If you go with debugfs then using the debugfs_create_u32() or 
> debugfs_create_u64() function would be more appropriate I think. And 
> then don't make that global, but rather a per device flag.
>
> Regards,
> Christian.


Makes sense to me too.

Andrey


>
>>
>>
>> Thanks,
>> Victor
>>
>>
>>
>> -----Original Message-----
>> From: Koenig, Christian <Christian.Koenig@amd.com>
>> Sent: Friday, July 22, 2022 4:20 PM
>> To: Zhao, Victor <Victor.Zhao@amd.com>; amd-gfx@lists.freedesktop.org
>> Cc: Deng, Emily <Emily.Deng@amd.com>; Deucher, Alexander 
>> <Alexander.Deucher@amd.com>
>> Subject: Re: [PATCH 2/5] drm/amdgpu: add debugfs amdgpu_reset_level
>>
>> Well NAK to the debugfs approach, stuff like that is usually a module 
>> parameter.
>>
>> Apart from that this series needs to be reviewed by Andrey.
>>
>> Regards,
>> Christian.
>>
>> Am 22.07.22 um 09:34 schrieb Victor Zhao:
>>> Introduce amdgpu_reset_level debugfs in order to help debug and test
>>> specific type of reset. Also helps blocking unwanted type of resets.
>>>
>>> By default, mode2 reset will not be enabled
>>>
>>> Signed-off-by: Victor Zhao <Victor.Zhao@amd.com>
>>> ---
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu.h         |  4 ++++
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 20 
>>> ++++++++++++++++++++
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c     |  1 +
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c   |  6 ++++++
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c    |  3 +++
>>>    5 files changed, 34 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>> index 6cd1e0a6dffc..c661231a6a07 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>> @@ -238,6 +238,7 @@ extern int amdgpu_si_support;
>>>    extern int amdgpu_cik_support;
>>>    #endif
>>>    extern int amdgpu_num_kcq;
>>> +extern uint amdgpu_reset_level_mask;
>>>       #define AMDGPU_VCNFW_LOG_SIZE (32 * 1024)
>>>    extern int amdgpu_vcnfw_log;
>>> @@ -274,6 +275,9 @@ extern int amdgpu_vcnfw_log;
>>>    #define AMDGPU_RESET_VCE            (1 << 13)
>>>    #define AMDGPU_RESET_VCE1            (1 << 14)
>>>    +#define AMDGPU_RESET_LEVEL_SOFT_RECOVERY (1 << 0) #define
>>> +AMDGPU_RESET_LEVEL_MODE2 (1 << 1)
>>> +
>>>    /* max cursor sizes (in pixels) */
>>>    #define CIK_CURSOR_WIDTH 128
>>>    #define CIK_CURSOR_HEIGHT 128
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>>> index e2eec985adb3..235c48e4ba4d 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>>> @@ -1661,12 +1661,29 @@ static int amdgpu_debugfs_sclk_set(void 
>>> *data, u64 val)
>>>        return ret;
>>>    }
>>>    +static int amdgpu_debugfs_reset_level_get(void *data, u64 *val) {
>>> +    struct amdgpu_device *adev = (struct amdgpu_device *)data;
>>> +    *val = amdgpu_reset_level_mask;
>>> +    return 0;
>>> +}
>>> +
>>> +static int amdgpu_debugfs_reset_level_set(void *data, u64 val) {
>>> +    struct amdgpu_device *adev = (struct amdgpu_device *)data;
>>> +    amdgpu_reset_level_mask = val;
>>> +    return 0;
>>> +}
>>> +
>>>    DEFINE_DEBUGFS_ATTRIBUTE(fops_ib_preempt, NULL,
>>>                amdgpu_debugfs_ib_preempt, "%llu\n");
>>>       DEFINE_DEBUGFS_ATTRIBUTE(fops_sclk_set, NULL,
>>>                amdgpu_debugfs_sclk_set, "%llu\n");
>>>    +DEFINE_DEBUGFS_ATTRIBUTE(fops_reset_level, 
>>> amdgpu_debugfs_reset_level_get,
>>> +            amdgpu_debugfs_reset_level_set, "%llu\n");
>>> +
>>>    static ssize_t amdgpu_reset_dump_register_list_read(struct file *f,
>>>                    char __user *buf, size_t size, loff_t *pos)
>>>    {
>>> @@ -1785,6 +1802,9 @@ int amdgpu_debugfs_init(struct amdgpu_device 
>>> *adev)
>>>            return PTR_ERR(ent);
>>>        }
>>>    +    debugfs_create_file("amdgpu_reset_level", 0200, root, adev,
>>> +                  &fops_reset_level);
>>> +
>>>        /* Register debugfs entries for amdgpu_ttm */
>>>        amdgpu_ttm_debugfs_init(adev);
>>>        amdgpu_debugfs_pm_init(adev);
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>> index e8c6c3fe9374..fb8f3cb853a7 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>> @@ -198,6 +198,7 @@ struct amdgpu_watchdog_timer 
>>> amdgpu_watchdog_timer = {
>>>        .timeout_fatal_disable = false,
>>>        .period = 0x0, /* default to 0x0 (timeout disable) */
>>>    };
>>> +uint amdgpu_reset_level_mask = 0x1;
>>>       /**
>>>     * DOC: vramlimit (int)
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
>>> index 831fb222139c..f16ab1a54b70 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
>>> @@ -74,6 +74,9 @@ int amdgpu_reset_prepare_hwcontext(struct 
>>> amdgpu_device *adev,
>>>    {
>>>        struct amdgpu_reset_handler *reset_handler = NULL;
>>>    +    if (!(amdgpu_reset_level_mask & AMDGPU_RESET_LEVEL_MODE2))
>>> +        return -ENOSYS;
>>> +
>>>        if (test_bit(AMDGPU_SKIP_MODE2_RESET, &reset_context->flags))
>>>            return -ENOSYS;
>>>    @@ -93,6 +96,9 @@ int amdgpu_reset_perform_reset(struct 
>>> amdgpu_device *adev,
>>>        int ret;
>>>        struct amdgpu_reset_handler *reset_handler = NULL;
>>>    +    if (!(amdgpu_reset_level_mask & AMDGPU_RESET_LEVEL_MODE2))
>>> +        return -ENOSYS;
>>> +
>>>        if (test_bit(AMDGPU_SKIP_MODE2_RESET, &reset_context->flags))
>>>            return -ENOSYS;
>>>    diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
>>> index d3558c34d406..1ffdc050a077 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
>>> @@ -405,6 +405,9 @@ bool amdgpu_ring_soft_recovery(struct 
>>> amdgpu_ring *ring, unsigned int vmid,
>>>    {
>>>        ktime_t deadline = ktime_add_us(ktime_get(), 10000);
>>>    +    if (!(amdgpu_reset_level_mask & 
>>> AMDGPU_RESET_LEVEL_SOFT_RECOVERY))
>>> +        return false;
>>> +
>>>        if (amdgpu_sriov_vf(ring->adev) || 
>>> !ring->funcs->soft_recovery || !fence)
>>>            return false;
>
