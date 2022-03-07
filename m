Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BC59C433F5
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Mar 2022 17:06:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9484810E0A2;
	Mon,  7 Mar 2022 17:06:04 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2052.outbound.protection.outlook.com [40.107.243.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A588B10E0A2
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Mar 2022 17:06:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fbHvbmHCuR+8nSn8JybeUomuk4OOJ0j/BloYbkZFuWHooGSqwK+uw2ml78gD1a9cWVMkMGshDgj/A+dilD/8Z5u32dcTlhtMKBUDUOKpfQFz1Z75UzoIl/mtTl/lCWr7c59X55NhzLjDNQWhykjo09qsAtA6g7sm7D0nL1tA4BhvbKdEKqLXbnCPKWUYQ/OpSFcUgSKfSZuPvJo8hGg0Y9GipYNCbDNV6NZxpczGDPGl38Ey8dtTCPdImT0oAzFNItx0arW13OkyUa5ZDg0MhaY0R7QZeeE5AfazT41IeyiCYeOaGyIVplvMyJYDlU0wWzrFssWtfVIj0m4obqkgsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MCUDBKA01oSqyne8xLgbTtN4lv4+RC5SowY/i+/uX0I=;
 b=ObQUwxORWR4qTDdZ7jqW9eByv9qRhUqrxFtQweA69aYaYgHfIg8iTNE8oxnJXvKeTMgVDwlC3BFG3Udd1YFnHMBH6R/kXKcNp1Yz2VCco+lqzgX9HbKSuK1VQWjtt+CE0FrHRTncs0QpqoRO9vYt2FaBeUbN7CJ2bYkYoMMxaagz/1awhMZ5T8/fo748Lc9BG6Ps+xv0QJK0voXAQgzh5q0kutnxrjtUi7c5h9izXZclTDtu2uyvlWgLrwc0Me+pDnWEeafVtvcylSgqwxLkX9njHI7c5V4UQNPwBDDYlmwZR4v7UWnvqmmF7ZGeYhpwF/b4732ka0fnK/E11XFcsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MCUDBKA01oSqyne8xLgbTtN4lv4+RC5SowY/i+/uX0I=;
 b=K4Trdtfz2vyIHEtgDsmXnVKBTw2bLbOH03X5Qgx8FUo3ujcqI4zQYA2v5+vO9Qg0/IJz0FCzfkwoscIEP8ka6DcWZt7gc++yhD4/NYp5Qc7r4yIIAkb3lgtKbcqVMDwxb0EELl14pim210Mj59rpVdlwY0qdVNZD22dx9i1mlGY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19)
 by BY5PR12MB4950.namprd12.prod.outlook.com (2603:10b6:a03:1d9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Mon, 7 Mar
 2022 17:05:59 +0000
Received: from DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::f037:e2a1:f108:125a]) by DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::f037:e2a1:f108:125a%8]) with mapi id 15.20.5038.027; Mon, 7 Mar 2022
 17:05:58 +0000
Message-ID: <7eed2410-235b-a016-2ca6-20b8ccb1637c@amd.com>
Date: Mon, 7 Mar 2022 18:05:52 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH 2/2] drm/amdgpu: add work function for GPU reset event
Content-Language: en-US
To: "Somalapuram, Amaranath" <asomalap@amd.com>,
 Shashank Sharma <contactshashanksharma@gmail.com>,
 amd-gfx@lists.freedesktop.org
References: <20220307162631.2496286-1-contactshashanksharma@gmail.com>
 <20220307162631.2496286-2-contactshashanksharma@gmail.com>
 <b5f0fbd2-f599-8f4b-dd12-8f18734d52d8@amd.com>
From: "Sharma, Shashank" <shashank.sharma@amd.com>
In-Reply-To: <b5f0fbd2-f599-8f4b-dd12-8f18734d52d8@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM7PR02CA0025.eurprd02.prod.outlook.com
 (2603:10a6:20b:100::35) To DM4PR12MB5040.namprd12.prod.outlook.com
 (2603:10b6:5:38b::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8585ccb7-9047-4fd9-8223-08da005cc00a
X-MS-TrafficTypeDiagnostic: BY5PR12MB4950:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB49507701597F4C4E163D7D80F2089@BY5PR12MB4950.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Rj8AodJ1B9wRAE7TLlM+eyXinoVFIEXqcM3iUFLQXl4TMcnWh08S3jSwPAJiQ3iEVIAvJMXgkJX05Zh9ffHaycMHTN50wYOWaO+5MJK/rGh/wpOahQp5CpsjRG7W7OrKI/bInKV9OoJ7gNxVEbLsKZZhFC3P/9LGotTTP15Ltt9VssZwSPWIyHr/yx8H1ryuiKaEEA0RAAJxvVRBid/HJYWZM//USY3lf1nV306OzZ3PnHqUWJ+Sst9Y2i00ZJE0xOHBbPVBPLPiZxVGDM393XEzp48m0MfNUAvGwWD4+n3WKYU8C0DTKewnaJ8WG5uCdn8z/X4x13PJ7FH/QSc50R9F7MZkAWJx7hx/w2zNf4RFKUcDncA3qIjJt+ar6fg7ReexJYIiohr+GGl1KlyQjWOuqSbxNK4h3zMr7e54KznWA9KQHcl/gj+oz3nW8CETu37S26fZTktNtUL/JyS02RoErb1e9pa2Vb4lAZX7ZGcVLm2XpIbpPCi+qiXNoT6l5lq9HgOPG7d16eFKx8e+CknHEgBOq9Zj432/DzEIMLi3rrqMyZFFpt/xK32vbgrb0FpzhzAZrM3TRJZ6f3Ac0C5yx5UZlfhfHXA5BQCbptMPcg3R5RerOAQc8WXzQLoQ3RUvHAqEMn0Dk7hR19f9J3sTxJcd3ruV1igFPK8Jf9SvYXh2cTnONgg0ztOdWmCKLrQ41VaXs9LZwFs4DH3+wFllb/pyaYmVr0PmAGPbTHM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5040.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(2616005)(31696002)(110136005)(86362001)(54906003)(31686004)(66476007)(6506007)(53546011)(6486002)(508600001)(83380400001)(26005)(186003)(6512007)(2906002)(8936002)(5660300002)(38100700002)(6666004)(36756003)(316002)(4326008)(66556008)(8676002)(66946007)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WmNGdUhURkpkYUhwQzJpQmVvamNaWDR3eWQwQWxsSjZFQTNqbmpBRTk3dXZz?=
 =?utf-8?B?ZUMxd1NrRnVIYW02N2hHdkV4MEJWV2tjcmRxSGpqRUNSaXJWdWZBQWpWdHp0?=
 =?utf-8?B?TDM2QklqcHEzQklySlVNUGdoZXBHSENPbEZCR2hnc0lMQThWZFlxUXp1SlRx?=
 =?utf-8?B?QVd2R0E4akNvd042N2VJN2dkUUxUdE5xdHZJcFBZSWtTV1ZoWEcrSi81Z2c2?=
 =?utf-8?B?a21oQ0Y2VEQ1Z3JteHBBNm1JdUd1YnVzTDdIY3dDU29vTzNzUFl3WloycHRP?=
 =?utf-8?B?VzBCS3g5LzhwZjY4S3pRMHVRcUs1V2FhMEVUSEQwL3NyZlZMVCtFbktXUlVJ?=
 =?utf-8?B?OVJzaW9ncjg5QkJpbGExQUtPNDUrMmc1RUdPZ0NsNS9KNFJ3d3pWSnhGZXh2?=
 =?utf-8?B?cVVUN1NGeEhGWkpzK0pTV0ZxVEJDaUZCdGcrbDRpQXd5NDN0Q21lSkZqd2JC?=
 =?utf-8?B?aGZScWxqY3V4VzJ6SkUzb0tERVp3QWpJY3dpcnhzYWVKOEVPM1lQWXRpVXR1?=
 =?utf-8?B?ODdUU1lQRUJDc3pLSHA4ZytCSGpreENVN2gyMDIvVFovc05Wd1QyOU96VkV4?=
 =?utf-8?B?bFV2QlhUMlhsc0tucFJ0MStmOUIwL1REbWxtOFVzb01WK0NhRUFoZjJIV3c0?=
 =?utf-8?B?ekxxRkZsQnNpNHdEZ2JPYzhOUTUvVGdWSWQzYVhFOFBiNHNrQ3d2UXpKRkpT?=
 =?utf-8?B?OFM5dVl5eXVoMDNMK2RjamtONnlwaEoxRkVDLzJrSU94N1ZUYzFkd0RJQVVn?=
 =?utf-8?B?cUxBek1zUVJnL0IwVGdoYTZLSUZUclBZMHNQakVvektoTWRFeWQrMmd3TUI3?=
 =?utf-8?B?alpxVDNZQW5MamhDUTZJclpZeDVvaEZVdWNIYkFIYU9GMWo1eC93d1YzeE1M?=
 =?utf-8?B?d0tiWlpqQWlNZEVPRHpoSEVCaDE0d3Z5eEcySG9hOWtTSlhpZGVzMHkxbXhM?=
 =?utf-8?B?TUZYNlM0MUxlSmhuSWxWZW1DSlVaVGt6dFFoTGoyS3NpcExuM0lEbEt4NXIz?=
 =?utf-8?B?Tk1adDFWOHdJdlBHMm9wVmpoVVB1b2Y4VUUwdUtybHhlalBuR1VvUW4xcnhv?=
 =?utf-8?B?czFIbzlTUFdONlFNQjZYdFdSU2xGVndHenRvV0NoRk9YeGdMWjBPT2dRSFR6?=
 =?utf-8?B?RDFhanFHTGtrbFlaQzA0QWh6TlRvQ1hIUHpVTmUzaEVWOTFmWm1TbTF5NnUr?=
 =?utf-8?B?dXJkdnVkUHJLUWs2K2p1OFU2SkhLaDBrSXlHelU2YklHUDJ4UGk1Sy9ySzV3?=
 =?utf-8?B?Vm1EcE1NVm1nUm1HZnNGWXdSeElMQlJGcUlBWDNjOUJ3dTNmeDQ3MVNpMy84?=
 =?utf-8?B?YnpPM2Rsc09JUCt3eGQzVVF0RUU1cy96RDJhRGd0YmNPTEpRYmJSTUlDa01o?=
 =?utf-8?B?UXRlM0Evejlia05Qb0txOU5DNEU0SzA5WUtmMitwUCsrTytYRStOdVhPQ1E0?=
 =?utf-8?B?bTc4cDNJb2Z0K2R1NFJoUzdNbk1KS2Z4L2I4bVZOK0pISXVwbklZOFlZbmVu?=
 =?utf-8?B?ZkI0ZmhyeHNnOUtRb3NBYXIycWRUR1VrWUNEd3FWOEVZUmZ2M0pEQzh3WGQx?=
 =?utf-8?B?aDdhYW51SDUxV0hlWmN6dVJzSjIrdG5QZm11MERYR1ptR0pEZzBQNWxZS1RF?=
 =?utf-8?B?aG9hOWZxejNUOFpZU2hmZncxY1JndWNuZUVlRGM1ZTNyeWZZTksvR3MyeEJX?=
 =?utf-8?B?bnExQlZmWlFwTk1RUDM1VE96aXZhV3ZPaUVBbDhXQWNvOEUxcnpFeXJ4cG9u?=
 =?utf-8?B?N1Mra05MZjRFVy81RmxZczgwejI5NS85aWU4VFpwSlRwbS9VZW8wTFhKVVBk?=
 =?utf-8?B?VUFqdlFmaE0zc2dDTHVTRCs3T2VMUXdRSEpiaHd3WDdxV2ZrNUkxWm1URUJn?=
 =?utf-8?B?UlIya3UwZG50UGwrWE5qQURCaEVlclJ6V3pTbVUwRURXaERlWXJPUkZYNm9m?=
 =?utf-8?B?cjBrZ2JJS1VFaWtGaVJHVllTdFVLYVZGUGs3U2FqQThhNE5vVGV6Sk5sd1BJ?=
 =?utf-8?B?SzR1dVVoVHBubHlHc1BNYWZzVXUvbEowc0hlbm1vS3ZodTNGa2orWU9Rd2dw?=
 =?utf-8?B?aWJzV3ZjWnovSVl2YUc2VW5sV2M1Z1M0VUJCK05QNWRtSW82TnNHb3dBbUlD?=
 =?utf-8?B?R0JmMmM5K1c3MS9SSUNqdm1Jc0RDVXFZUEhOQlBLSzVobkFKaHQ2UkhLb01V?=
 =?utf-8?Q?BxE7+72jJpyvvDt4IylBFQ0=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8585ccb7-9047-4fd9-8223-08da005cc00a
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5040.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2022 17:05:58.7282 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tL9UXyt8Ar32bOy/98O6A4jkFesV1hJfwQN7F6t+yzUicfQFYubVtxtOITzYswZmHdV4e1rhNjh8DUTw9DmsZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4950
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
Cc: Alexander Deucher <alexander.deucher@amd.com>,
 amaranath.somalapuram@amd.com, Christian Koenig <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hey Amar,

On 3/7/2022 5:46 PM, Somalapuram, Amaranath wrote:
> 
> On 3/7/2022 9:56 PM, Shashank Sharma wrote:
>> From: Shashank Sharma <shashank.sharma@amd.com>
>>
>> This patch adds a work function, which will get scheduled
>> in event of a GPU reset, and will send a uevent to user with
>> some reset context infomration, like a PID and some flags.
>>
>> The userspace can do some recovery and post-processing work
>> based on this event.
>>
>> V2:
>> - Changed the name of the work to gpu_reset_event_work
>>    (Christian)
>> - Added a structure to accommodate some additional information
>>    (like a PID and some flags)
>>
>> Cc: Alexander Deucher <alexander.deucher@amd.com>
>> Cc: Christian Koenig <christian.koenig@amd.com>
>> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  7 +++++++
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 19 +++++++++++++++++++
>>   2 files changed, 26 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> index d8b854fcbffa..7df219fe363f 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> @@ -813,6 +813,11 @@ struct amd_powerplay {
>>   #define AMDGPU_RESET_MAGIC_NUM 64
>>   #define AMDGPU_MAX_DF_PERFMONS 4
>>   #define AMDGPU_PRODUCT_NAME_LEN 64
>> +struct amdgpu_reset_event_ctx {
>> +    uint64_t pid;
>> +    uint32_t flags;
>> +};
>> +
>>   struct amdgpu_device {
>>       struct device            *dev;
>>       struct pci_dev            *pdev;
>> @@ -1063,6 +1068,7 @@ struct amdgpu_device {
>>       int asic_reset_res;
>>       struct work_struct        xgmi_reset_work;
>> +    struct work_struct        gpu_reset_event_work;
>>       struct list_head        reset_list;
>>       long                gfx_timeout;
>> @@ -1097,6 +1103,7 @@ struct amdgpu_device {
>>       pci_channel_state_t        pci_channel_state;
>>       struct amdgpu_reset_control     *reset_cntl;
>> +    struct amdgpu_reset_event_ctx   reset_event_ctx;
>>       uint32_t                        
>> ip_versions[MAX_HWIP][HWIP_MAX_INSTANCE];
>>       bool                ram_is_direct_mapped;
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> index ed077de426d9..c43d099da06d 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> @@ -73,6 +73,7 @@
>>   #include <linux/pm_runtime.h>
>>   #include <drm/drm_drv.h>
>> +#include <drm/drm_sysfs.h>
>>   MODULE_FIRMWARE("amdgpu/vega10_gpu_info.bin");
>>   MODULE_FIRMWARE("amdgpu/vega12_gpu_info.bin");
>> @@ -3277,6 +3278,23 @@ bool amdgpu_device_has_dc_support(struct 
>> amdgpu_device *adev)
>>       return amdgpu_device_asic_has_dc_support(adev->asic_type);
>>   }
>> +static void amdgpu_device_reset_event_func(struct work_struct *__work)
>> +{
>> +    struct amdgpu_device *adev = container_of(__work, struct 
>> amdgpu_device,
>> +                          gpu_reset_event_work);
> 
> I am trying same thing but adev context is lost.
> 
> schedule_work() in amdgpu_do_asic_reset after getting/reading vram_lost 
> = amdgpu_device_check_vram_lost(tmp_adev);
> 

I am not sure if I understand your point correctly, but in this patch I 
have introduced a struct amdgpu_reset_event_ctx, which already is a part 
of adev, and has space to store both PID as well as flags.

So all you have to do is:
- GPU reset happens
- Save the pid in adev.reset_event_ctx.pid
- If VRAM valid, Save the vram status in adev.reset_event_ctx->flags |= 
(BIT0)

and schedule this work function. If the data is saved properly, it will 
reach the work function and the event will be sent.

- Shashank

> Regards,
> 
> S.Amarnath
> 
>> +    struct amdgpu_reset_event_ctx *event_ctx = &adev->reset_event_ctx;
>> +
>> +    /*
>> +     * A GPU reset has happened, indicate the userspace and pass the
>> +     * following information:
>> +     *    - pid of the process involved,
>> +     *    - if the VRAM is valid or not,
>> +     *    - indicate that userspace may want to collect the ftrace event
>> +     * data from the trace event.
>> +     */
>> +    drm_sysfs_reset_event(&adev->ddev, event_ctx->pid, 
>> event_ctx->flags);
>> +}
>> +
>>   static void amdgpu_device_xgmi_reset_func(struct work_struct *__work)
>>   {
>>       struct amdgpu_device *adev =
>> @@ -3525,6 +3543,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>>                 amdgpu_device_delay_enable_gfx_off);
>>       INIT_WORK(&adev->xgmi_reset_work, amdgpu_device_xgmi_reset_func);
>> +    INIT_WORK(&adev->gpu_reset_event_work, 
>> amdgpu_device_reset_event_func);
>>       adev->gfx.gfx_off_req_count = 1;
>>       adev->pm.ac_power = power_supply_is_system_supplied() > 0;
