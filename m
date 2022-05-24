Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A03FC433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 24 May 2022 06:12:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A14AF10F5B6;
	Tue, 24 May 2022 06:12:56 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2052.outbound.protection.outlook.com [40.107.237.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7227F10F5B6
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 May 2022 06:12:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jFmyktgFl2sEZZV5oGnYBl8MGr+oVnxFCgjr1tROwqwWW3wRIKbIYJZDxG88jhjwzyckLPr/dq0qMVM5DmQPcoTfXaw06w9FuuraPpTLNdnzm0uDPh9boBGwtpAp2eTavQyfuauN1KyMosqidP26jhnmzvWBtFPhta/7TiKq4ROUl+NCog4RnnDv21yiidcSWOO63liJI2HuRRtbPl5n2xgX20RE3H/mToZwZaDJj5OZYnNCUpslzp2juw80YYcneldNaQJVp8afZr4yUBAkbqLK4/4SycZXsHGHFFo9EX+K2L54WFJpcHtbQJIVNw7KkC6b905NihU9TfhmbS01eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t2YdyDgcA0iiMw4QPUZavaeYB1BHqWjr82aMsaAMUcM=;
 b=Wh1iaiu5uXQPmKoTBs2dGzAbSXSMy9rC2+pdKavJYSP/IWtS7je60qFaVzZwz1a1eK/ENOJExAEVb66GzjSVARNL7hQEa7rdTHMxAIQVqquJaBWsZqjSlpS1vnCWEC410Ac0fJnz6PqzwACT7PrIe12+KWhD6vhXQXoquyUtga6eiGQWXK+PEYUDiSSMQyA8oPYJxmNsu5BMfm2CDz06r01f5vQNU2wucu+/UUUch0ch4S2lOy9Aah3vMWQ8w32E2zKsPThEo7y+pkmMz1f1nJosJVa6t+pSTPaEHMAAcziyzDK9T+xD/5IGCpaB6SZCF5lwYGylxi4v+Zu0vgWaEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t2YdyDgcA0iiMw4QPUZavaeYB1BHqWjr82aMsaAMUcM=;
 b=Cgv999bphuE/0wP2FMbEFoAG5DwKYB1mlq0VkJVxAu2lfhcKZ0/j7YL/dkekceoDB2NoRWi6Ns/eKAagOa7xsEcuvLpfcYWX2mcii+aJQMPVScpGaf9uSm+vk6c4Coym5BFyRTMcv1z36GmkpvLDKNDPEckgy97eRAWBkdammhU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3897.namprd12.prod.outlook.com (2603:10b6:5:1ca::24)
 by DM6PR12MB3132.namprd12.prod.outlook.com (2603:10b6:5:3c::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.14; Tue, 24 May
 2022 06:12:53 +0000
Received: from DM6PR12MB3897.namprd12.prod.outlook.com
 ([fe80::d88f:683a:1421:dde3]) by DM6PR12MB3897.namprd12.prod.outlook.com
 ([fe80::d88f:683a:1421:dde3%7]) with mapi id 15.20.5273.023; Tue, 24 May 2022
 06:12:52 +0000
Message-ID: <9fdbe193-b65a-a429-09a1-107b00313891@amd.com>
Date: Tue, 24 May 2022 11:42:42 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v1 1/2] drm/amdgpu: save the reset dump register value for
 devcoredump
Content-Language: en-US
To: "Sharma, Shashank" <shashank.sharma@amd.com>,
 Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20220520134909.92781-1-Amaranath.Somalapuram@amd.com>
 <1b19f85d-0ac7-3559-92a7-f7c7c6571512@amd.com>
From: "Somalapuram, Amaranath" <asomalap@amd.com>
In-Reply-To: <1b19f85d-0ac7-3559-92a7-f7c7c6571512@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BM1PR0101CA0019.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:18::29) To DM6PR12MB3897.namprd12.prod.outlook.com
 (2603:10b6:5:1ca::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1f8c0eb6-eefc-4cff-33d3-08da3d4c6f7a
X-MS-TrafficTypeDiagnostic: DM6PR12MB3132:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB31326926A15C406D11764CE7F8D79@DM6PR12MB3132.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KDMj5MYIW/RM9oK9I/yi3hC6l6jM4d78AVz9lbTHPnQZ94z1+i0fCC5njvagHtG0cGAvs97wJ491D1yOqmQHnvHTnbCjXoAJYaj5LBqI59/B5HH7Yaoftvf3TFRJpBam5FoYESSifmLmpEcLT52Wk+/Cfo0oYt7x6pd3DPgTts8jusvxtDnS07SAMYJXYKPFAts+w+rpCN2kbq06gmeMLvHGJlAXrIASUdjUhQ0B/9z2B+Pl0blj3MCjSXQ3cO2NTyRiPv+OgGMyAhPTAaINDBDUa3UzMdyP+DqZaCoZe1s0lJ/KTs/NnzYcfHYXrrbJJ6ZhlQlUxM1F+Xec8D0Uw1XLn3TmwB/YS87DjRN5jc1hw+xDJJSnm4fWWotzA3bzs7o/br+5RF6W++DCOM538PisRffeDS6LbziiuLHLRLsZP0sgAxv2VXHyZ30zG3URAIpw5f9/AB2gksDyiozCynyfghWmlufqgyr6vB7/tY+kUMrD8wdI0OTsgKo93vP8yVElgEJutpar5djPVBlqMhGXY/OlnsOYTBYyoiWMBSbcj3ncN7I/z3g153owNMPshd6P7myXrDXx81XWwD/vzl8e+/6b4JeJJHlbtIdWQLiOinpgGAymBElkfHUz1hVTu+U69mHb1zghMIKRb2xf3Z44BdeUzG6rKfhfAY/lf4/EJ3VWNQx1xZt/jivy/LmgdsOnP+ClBFqafCrw4H/VFoz6IJNqHvfxP+BlDy48y60=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3897.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(36756003)(31686004)(6506007)(316002)(110136005)(53546011)(38100700002)(508600001)(2906002)(6666004)(83380400001)(66556008)(8676002)(4326008)(66946007)(31696002)(66476007)(186003)(5660300002)(8936002)(6486002)(2616005)(6512007)(26005)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RDlwTzJDOTdlSWU5STNlQ1h3YStmU0JzcmdqYzgxQkRUVU1rWHk5RTA2aXNY?=
 =?utf-8?B?dis0VTdFSGlseEk0NlpwSzZ3RmdLYW1yc1FQNmdWdk1jenVlbkt5UzB1WFh5?=
 =?utf-8?B?bks3RHBVYnZPeExwTksvQ2QzSHVUcEUwRitsZjczL0toWVVYQ1d0VlIxTmlH?=
 =?utf-8?B?Q2JibDAwMGNvd0toQ1ZqTE1qSWNabWNlS0MraE5Dd1VoSzd4YVA5RGI5RGsz?=
 =?utf-8?B?SUMxTWg4dXYyMndubTRFNHlVc0N6UHR2T253Y3N6TFRISW9MMGpnL2pFZ2Ix?=
 =?utf-8?B?QUR4V2tDeWQzNmdLRnVNUmMvcXhteUZ6SzFsTFhUcUFodnFwUk9XTjBnYTY2?=
 =?utf-8?B?S2M3ZjNxYVJXUkI3ZUs3dG85SlNHVG9CYXVzUmdSUXcwNnc0UFhFcER6UGQ2?=
 =?utf-8?B?VFd5VEsrZ0pERXdoVkFwYlBvTStuNWVpNDYvWE1aL1Q4NnRLOUcreWZwbUZS?=
 =?utf-8?B?d3Z4NEN4Y2dXM3RIRFBJbkQ1eUtOcmJIMWVQUk4zN2VmZFQrUUJKbDIrSnVi?=
 =?utf-8?B?UUxPUm1pL1ZPM2w3Z3U0R0JtTzZBaGxLMWdkaWVZWXFWME1keTZrYTE1T3lJ?=
 =?utf-8?B?VUt6bDFBUVpnZlJaNjhBY0JYVEdvaGZIN0x2bW83U1NrbHlNams0SnIxTkcy?=
 =?utf-8?B?alBRSzhRODBacFB3Ni9EQyt4cmFsOWRmQ296bEovbkVBdzJjdUpxNmRNS1Nj?=
 =?utf-8?B?dnR5SGlqbllQekJmK2g5aWMwSGk3MkxIRkdFdWs0bE5XVndZOXpGQW0xM3lX?=
 =?utf-8?B?ZjZaYTVaaTd6bTRJZkpqT0kyWUNCN1FGcWs0b2lzaVJBU1VxeXliVXFYdGRP?=
 =?utf-8?B?ZXU3T21ycVlJNnNNeTVoTTU1Um9aUXkvT0RCOVhCS2RHMzBLVTA5Q2RYa1o1?=
 =?utf-8?B?cnkwbUU0aHkzYzJaZzlRS29jZW42QXFoVFY4YXZhOGRwbmFWa2ZxVFBzVHZ5?=
 =?utf-8?B?MllUbDEwd1VQYk9PTlZUUzRuQnNNejFQQXhwekRGR3BNbnYrRFVQTnJUNjlP?=
 =?utf-8?B?OTg5dzdBNzJPbUk2dGRVKzhKZ1BaYjRNbC96TS90YXdiSzF0azl2SnBoc2xp?=
 =?utf-8?B?ajdQSVRSNkZIVkpaWTErbXpNWTQ1bksrV21VcGJkN01PUTlZMVMvdzczM25p?=
 =?utf-8?B?OE9YdzBRWS83Z1NqM1hmZHlpNmJMdVlSckhkbTIxd2NCbWdQVVE0N1RxWHdw?=
 =?utf-8?B?azlyaG5nd2pNMnludWtUby9oMnhBNm50S1c2UjZ4eW1xZW1MTDlFQTc5Vy9S?=
 =?utf-8?B?TkNtcjBYTGdSWkRGNXRqbTN2eURGRm82YjRMU3Fqc0pUNFltSmFubzViYWlL?=
 =?utf-8?B?K3lrTkxrVWo1V1VTK1RsQ01MNnN0Z0pIbUtYUGZzaFRJMjJsbGl6elAydnJC?=
 =?utf-8?B?d014eTFHbytOcXNmejJwWURzWXVkeGJoNDkzZi85T3lyaEVYeXBoZXBiK0Yz?=
 =?utf-8?B?RnVpekJFbGtBQ254U3ZsMFRKRUFOSTFOWis2WHhTMjIrZThNaHZDTWhwRDdU?=
 =?utf-8?B?YmlWN1ZZRmVieFcySlFnWGc1MThtd1JWWmxXUzAwdGhYZHlUUjQrWUFmR3N3?=
 =?utf-8?B?RTBaWXNQb0dJS1E2R1dpaFduZFRSTloyWEdBMERxcHZDZDR4TmIvY0xCWndP?=
 =?utf-8?B?QjBRZVFzS3lHVkFuWEh6bGVjRXh1UGo1aU10K2dzZGVCTkY4cE9yTkdRZXZB?=
 =?utf-8?B?QkZlcVh6eDhUZkQ4ZmNiTFZEaG1PU3lhYlBtMGFDTXBhbisxdTdjK2FaeHFX?=
 =?utf-8?B?N1pmV0JnS2lBVm5BTjVLZ3ZuRzJJN0ZtSjFCbW9BR1F5RkhqMy9QUDBKRlpR?=
 =?utf-8?B?RHVMdzBLQm83MDZBVCt6eWpGaGtyUjVwRHk5RDJOU1lXU29LcElSVm5mU09u?=
 =?utf-8?B?WitjcE1MWWdERjlXdjJ2dklyWWN1M3Jkd2xoS2lheHc1UTdvV0lmejhRckJu?=
 =?utf-8?B?dDY1RFR2dFk5dGsyWnRHNXBkdmVUR3RDd1Yxd0RRV05DanpsYU1pZHdHYWFK?=
 =?utf-8?B?MDVweGMwcEFValNHOGhyYm03V2lNK0cxRDF3VFpPenRuQTVldUdlYy9YZjk2?=
 =?utf-8?B?d1k1UksvTGNmdTVEUU5ra0krRG9zRkNScVlPdS8vWGJES1dxU3JaNzQ2L2pj?=
 =?utf-8?B?OEFORTdKZjBXVDlLNys4ZzBvVm1icE5BQXFENldzTVZXTFQwVlBuaVJkdCtP?=
 =?utf-8?B?SmVFc01jNFZ3dUdKSlo3Wko3NlNlejVQNDJ2cjZoNmNIcHl5elJTYXJmRkdi?=
 =?utf-8?B?bGd3eVRrSjNlUE9jRm5kcGtvaS9iZWZhcUxWYm1SV3pkNkQwbkR4dU9US0Ja?=
 =?utf-8?B?dlgrMzVwQjZ0MkRFL3N2UWs3dUpmODFSVk9OOUdOZlcyeEZ2R3lWZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f8c0eb6-eefc-4cff-33d3-08da3d4c6f7a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3897.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2022 06:12:52.8278 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Mn6ZUTJhxCyghn++OHT9kDYAJ02/nh9vclF5Mm3ps6mj4cMK3mFGnDYq2a/z0vOietqfQX7ZX4PwTnUfkniviQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3132
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
Cc: alexander.deucher@amd.com, christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 5/20/2022 7:36 PM, Sharma, Shashank wrote:
> Hey Amar,
>
> On 5/20/2022 3:49 PM, Somalapuram Amaranath wrote:
>> Allocate memory for register value and use the same values for 
>> devcoredump.
>> Remove dump_stack reset register dumps.
>>
>> Signed-off-by: Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu.h         | 1 +
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 9 ++++++++-
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c  | 7 +++----
>>   3 files changed, 12 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> index 76df583663c7..c79d9992b113 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> @@ -1042,6 +1042,7 @@ struct amdgpu_device {
>>         /* reset dump register */
>>       uint32_t                        *reset_dump_reg_list;
>> +    uint32_t            *reset_dump_reg_value;
>>       int                             num_regs;
>>         struct amdgpu_reset_domain    *reset_domain;
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>> index eedb12f6b8a3..942fdbd316f4 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>> @@ -1683,7 +1683,7 @@ static ssize_t 
>> amdgpu_reset_dump_register_list_write(struct file *f,
>>   {
>>       struct amdgpu_device *adev = (struct amdgpu_device 
>> *)file_inode(f)->i_private;
>>       char reg_offset[11];
>> -    uint32_t *new, *tmp = NULL;
>> +    uint32_t *new, *tmp = NULL, *tmp_value = NULL;
>>       int ret, i = 0, len = 0;
>>         do {
>> @@ -1709,17 +1709,24 @@ static ssize_t 
>> amdgpu_reset_dump_register_list_write(struct file *f,
>>           i++;
>>       } while (len < size);
>>   +    new = krealloc_array(tmp_value, i, sizeof(uint32_t), GFP_KERNEL);
>
> tmp_value is initialized to NULL, which means krealloc_array() will 
> behave like kmalloc_array(), is there any particular reason we are 
> adding this variable at all just to use krealloc_array(), and why not 
> use kmalloc_array() directly ?

I thought of using kmalloc_array() (got little confused on next write 
cycle), I agree to use kmalloc_array().

Regards,
S.Amarnath
>
>> +    if (!new) {
>> +        ret = -ENOMEM;
>> +        goto error_free;
>> +    }
>>       ret = down_write_killable(&adev->reset_domain->sem);
>>       if (ret)
>>           goto error_free;
>>         swap(adev->reset_dump_reg_list, tmp);
>> +    swap(adev->reset_dump_reg_value, new);
>>       adev->num_regs = i;
>>       up_write(&adev->reset_domain->sem);
>>       ret = size;
>>     error_free:
>>       kfree(tmp);
>> +    kfree(new);
>>       return ret;
>>   }
>>   diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> index 4daa0e893965..963c897a76e6 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> @@ -4720,15 +4720,14 @@ int amdgpu_device_pre_asic_reset(struct 
>> amdgpu_device *adev,
>>     static int amdgpu_reset_reg_dumps(struct amdgpu_device *adev)
>>   {
>> -    uint32_t reg_value;
>>       int i;
>>         lockdep_assert_held(&adev->reset_domain->sem);
>> -    dump_stack();
> This should be a part of different patch, where you can give some 
> background on why are we removing this.
>>         for (i = 0; i < adev->num_regs; i++) {
>> -        reg_value = RREG32(adev->reset_dump_reg_list[i]);
>> - trace_amdgpu_reset_reg_dumps(adev->reset_dump_reg_list[i], reg_value);
>> +        adev->reset_dump_reg_value[i] = 
>> RREG32(adev->reset_dump_reg_list[i]);
>> + trace_amdgpu_reset_reg_dumps(adev->reset_dump_reg_list[i],
>> +                adev->reset_dump_reg_value[i]);
>>       }
>>         return 0;
>
> - Shashank
