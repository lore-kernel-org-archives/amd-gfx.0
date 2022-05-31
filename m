Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A2CDC433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 31 May 2022 13:08:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B02F8112D70;
	Tue, 31 May 2022 13:08:54 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2053.outbound.protection.outlook.com [40.107.243.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7B65D112C8A
 for <amd-gfx@lists.freedesktop.org>; Tue, 31 May 2022 13:08:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hp4nO6xoj2sc0FnEkimAX3Wuy+fcNUNtFXfzR1DRWXo7FUZQUJH6em41+wm33APFMOejnxSjZ281TVlXoeo9eONzDUKjEYMTTPc+lza1vW9apBpmUgBknCNvNOA98+Maeihe6/8wVbx76PRvtnaST1Bbic51q46B3UVcwawbG9k6MubYrj77bkV2tUyG7vcQetm18fLa5vInhX5GXMj+cc19Z4vezqzTy1Mivlk1Jk+qh2jRzqPfKLuidsQkohEziVKl8oBod5B/o7m8g3yRgbgcj0uhirmMmxvqy55epltemKn/sCpJuIhN5sl1hWfmnTkxwPrUJ1Z+dqHgEhP6zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BtbEpk+Qp6aLmJm4Paj7kG9KitflK1Y8tJIeLoiujxs=;
 b=fV4GG/q5WthNeD58nFYxRfQeYpyEYRWU6z+/Z4bMbuk5fLRo4NTQwsLami18bJbub5mpsj/Jpt0JdaEcaCJJxyO2OdXXdDpj5TZEuWp5HTwKrgq1yqBEKePJJQhipTmKd0rgyltB2FfwVwtGlHpP34N821uhA133/uhF7Ct03wLRc+mPuj6ayDb/zqncfTU/b3ccYUUujVLZ1gQKiNAV5dPCUdkC1xl9aUUWYJakRHeziMBeFTruPSXAaFRvI9Xm2ui4w0W636RBaGs4zMqYnIQWF7DrUftHZCVEJypmtRll8K7gMAzjh0QIwN5jEnVh4FrkpZpxmD0DGNs/CG2c/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BtbEpk+Qp6aLmJm4Paj7kG9KitflK1Y8tJIeLoiujxs=;
 b=Z7azDO0kcvgEWWF+5/21VNiPnhGNe7XMY06JvDNBukCYWdjGeZMFrxEf5bHJ874AtKHobny86g/1JXzSZxPLGx+gEG5H2+q7J4+N6+liDwHOA0OpLcZ5wIi/HacZeLOUcxTNPM4xgkx0tDfZxIdXExXcJZMGNUbeADbuB0GKeGc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3897.namprd12.prod.outlook.com (2603:10b6:5:1ca::24)
 by DM6PR12MB2939.namprd12.prod.outlook.com (2603:10b6:5:18b::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.16; Tue, 31 May
 2022 13:08:50 +0000
Received: from DM6PR12MB3897.namprd12.prod.outlook.com
 ([fe80::d88f:683a:1421:dde3]) by DM6PR12MB3897.namprd12.prod.outlook.com
 ([fe80::d88f:683a:1421:dde3%7]) with mapi id 15.20.5293.019; Tue, 31 May 2022
 13:08:50 +0000
Content-Type: multipart/alternative;
 boundary="------------66ImXz0fBI5FzKolZG4Ojh6p"
Message-ID: <aeb838ef-ce57-510c-d364-f2b57b1af435@amd.com>
Date: Tue, 31 May 2022 18:38:39 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v2 1/2] drm/amdgpu: save the reset dump register value for
 devcoredump
Content-Language: en-US
To: "Sharma, Shashank" <shashank.sharma@amd.com>,
 Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20220526094839.36709-1-Amaranath.Somalapuram@amd.com>
 <483cf4d0-ef9d-ea0c-e0ea-8c006051ba55@amd.com>
From: "Somalapuram, Amaranath" <asomalap@amd.com>
In-Reply-To: <483cf4d0-ef9d-ea0c-e0ea-8c006051ba55@amd.com>
X-ClientProxiedBy: PN2PR01CA0103.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:27::18) To DM6PR12MB3897.namprd12.prod.outlook.com
 (2603:10b6:5:1ca::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 29842ba3-d370-40ac-1fc9-08da4306b41a
X-MS-TrafficTypeDiagnostic: DM6PR12MB2939:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB293913907C49D0F0E541F9C9F8DC9@DM6PR12MB2939.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2ZLReSRM0YaBMlW9EXkoEtPAtqiVOeShBtVKWd4TddD72kD1oAVnKHS3fiOQRp0LEdj4qmRZ/WmSklN4foAgieSJFWxvFKfJ558jJADBX1Y2ROafbQmFFGgEKTyrqVcICfORcbQG3J3e4fCNmHIGTrcys1ajnj8Mnl5/3q8cIYqmaSUfwKdNJj2pcrN4cTIO+9AseftdQQE7ync1aZzIEK582IMHenc0NRQyR91fWLIAmHeGF68fentnAFdqJXV3wOvupv1pnKezsucUKADcsokxkwvpOWdxplhOgeBsWYIeWNcRYDh8N8LbPkj52lPNm1eNYzC1Kb/bCznPvngbkHWHSKWpHB8sTkuTNVAdPdqUiSehQNhAgmCt1s2cnigGhuUvQXRDo3LttoF47I9exHIL6GfccgEvPyrUpJe5YPRTb2ZiqLX6x312Kzt62AX8g4AsqH/mkKDqxYEG7t04ckg1wX5p8wy/8U73VjjqHijusd6NhNwmUhZ9gCMmlwwFmBi4ZsA1GkLAVxakJE5WgwHvdPIqGe2NTRCMTtWeLZ/MEy4WM5++BwKPGZ+vqh7Q9Ym63V7H/Pc3egpl+MpFlGcjZB2iYPwVmx51xbnl+6Uv3Uu6zLC7x4xLp6bGFe+r2kfNzIbP2D4A03CLn3QUH0XsftDt71F3BwAqoYFuBRhDzad7AqugcPFkaD8ah/lYovG5EdshWKYZIvJl3Opm66a6UmVvn3ZIDvTROSn/6E0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3897.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(4326008)(5660300002)(83380400001)(6506007)(8936002)(31686004)(26005)(8676002)(33964004)(2906002)(66946007)(66556008)(53546011)(66476007)(6512007)(6666004)(38100700002)(508600001)(36756003)(6486002)(316002)(31696002)(110136005)(186003)(2616005)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?djRjbnEyQU9YY25MTGhmaUdGY0Qzd2JHUXYxTEszclFjSFZoRHFJcU5rdnkz?=
 =?utf-8?B?VnYvc1RyaDdhM25maGRnaDJxZGtlcURWYXhYWXlvOW1YNGhpanZWTmN1ZUZ0?=
 =?utf-8?B?eFRpcWg4dlMyWWZOVTRQaExJSC9jdWpvT2pJWGplWjhkUmw3dFo2STF1aVM1?=
 =?utf-8?B?d2dXZzZSM094djJaUC96ZGtGSHlDeVYydDBJMVFQZk1SRlhNa1FhUXVaMjli?=
 =?utf-8?B?Sy84bHh4ano2L2RsY2NVb3g1MU1xWm5JZlNra2ZocDRkMkw3VEpsL3JSdDV3?=
 =?utf-8?B?L0R2d0NEd09uSDVqZ2Iwd3NyQ3lzbldYU1FpeEZJRmU5UEQ1ZklQYzBrZUdn?=
 =?utf-8?B?VTVlWGNTRGdDaFA4WXBPbGtva2R2c1NXU3VrM1hXUmwyQzRneVJocmpBaC9a?=
 =?utf-8?B?eXY2MW8ySjRyaFVKanNjU2o2eG1uWkhDeFFrSUZibm4wUEdMcGprczNQZHdw?=
 =?utf-8?B?bmJIRjdvc1JId0QzdzFmckMzbkRQbklHb0hyTWZ5VjRpVU5kNDZyTWNoY09N?=
 =?utf-8?B?b3BrM3c2Z3ZRenZHZ0R3S015Wm5LV3lLNWdWOG9Wc0IzeklVTVlOMEpzTVJr?=
 =?utf-8?B?elZURjVFMHhjMjBrK3hMb2N5YVNzZlkyamFzNTFBLzdDTFpHUUJ2TzFDOVc5?=
 =?utf-8?B?elVIQ0RoUmVaRVpWTDE0bHFFeDVwRWxCQkFjeGMvQW11SExMYk01ZjY0QkV2?=
 =?utf-8?B?YTFTbURpZm4ySEZjTVI5ay9TeXVSYkxxRURiUlBNbVFWeGdneE5sSE1JSW4x?=
 =?utf-8?B?cTlUV0ZMVEZmbEtldWo5ckNKckRvbEQwaFN5TDhhUnV4bnF0VzRLYWJRbkxD?=
 =?utf-8?B?d1JHR2dUN2E5bXg4ZllYa1VtTGhsWW1qQVFoWnVyQlpCOVN1Z3NsdnRXTEFE?=
 =?utf-8?B?cWVuUVUrQmYzaVRZZjdaK3paTXZJcktabXVqVndNNjNYLy9kOVcveGNVQ2FL?=
 =?utf-8?B?WGxtVlBsVFQ4MWhUbDhkcEJZRkNFcFVJdDg1OTVHOGl2TXFwd1dWeUFKd0Fu?=
 =?utf-8?B?Tnh6NDhsNlBvNlpWc3l6Y3FsMlNRcjd0NElIeWhMVHJBTkNtZVVqMGp4WFBk?=
 =?utf-8?B?Y0VVOXpnRWc3TXZHeEZ1Y3pYQTJoTmc0ak5udUxjd29vNk1IS3QvdWhLZVBq?=
 =?utf-8?B?cU5yQjBHdmY1UnNtTFBqcmFFY1dTRlpVQXYvRXdhRGpNY3VCK0pjazZQTTEz?=
 =?utf-8?B?RFJlRzhSMUV0SUJVeDY1QmJQMWtLTGdLaWFnOEVoMDg2eUFwbGo0bWh2SDVm?=
 =?utf-8?B?blRJTmNqYTRuV2htSnNqSXhyY082Y3ZBM3NiY2VoZkxmM2NSREVlS2h3ODkr?=
 =?utf-8?B?UGVqSGNPWDZERHExaVVKWHZvbmR0d0hhSTdmWm94V1V1cFJyWWlqSHhKNkxi?=
 =?utf-8?B?aXJmeCtTM1pXT1F1OEZWQTJKeEEyZVp2aUhoUTVmQjY0K3F0bEZZc3ptYWhJ?=
 =?utf-8?B?SjZxcE1paS9EWTVpTkJCM3JoYkZSVVFwc0VyWFc0SzA5aVlDZExUb1NXVzJq?=
 =?utf-8?B?REZIWlc0cThDWXBGdGEwTmlZdXE0YXZ2QkJERzAvTlF3cElWU0I1ZW5XWVlY?=
 =?utf-8?B?ODVCYXZuUllpK1JUMlNNK3FHc0lFS0E2dlpnZ1ZMOVRzT0o5U3EzUCtSbjNk?=
 =?utf-8?B?RFJjREEvZVFKS3hCVGFmZ3VZcXZsYmdyUThQTmZCVjl6SUNWbFFqcm85cnZT?=
 =?utf-8?B?TzZwRGw5UXp5czIrajRWRmZ3YS9GTEpDS3h3THprN3A3aDBHTVI5NUtZZ2Js?=
 =?utf-8?B?RGxGMXVOZmp1b2VRYVFhUHVOSlB1QStUazVQVHJBSjh5N3Ura3E2NENzcHlU?=
 =?utf-8?B?R3JTaWFWaW0wMlN4ZUR1NSs5K3I1Vjg3WmRVUVN6UE9Sc1FEUHF4UjRWdWV5?=
 =?utf-8?B?NThiOG1vSkh5Zm9Eb1dTU3JmUDJvbG8xVVZRSDNzbmVITVZ4cmczSEljelI2?=
 =?utf-8?B?c2RoNDZvVVJpUVdpUXVpa2lRVlMzRHg3Z20rQjl0Nnc3OFpRZ05ieE5DV3BV?=
 =?utf-8?B?MG9CODFVTjYyZWc5LzZ5TklnTlE0WnFtOHZxbDc2QitHQ0p3a0xyUXE1N0Ir?=
 =?utf-8?B?Qk5WL0lPZE5iUTZDQWhBTi9MNjVqbUxEc2Y0VTVjdHpzYU9YYmF0NGw3ZU93?=
 =?utf-8?B?c3VkUW9KOEhNUFliK1VnbXJ1Z2ZRL0pTbjVoa0ZPN3RyTXhrUHNnOHVuUlNS?=
 =?utf-8?B?YXc0bUN2U3ZERGRRQlZnTmRsaHJENmhWZVQ1SEhQUlY5d1p4OVhMaWZOOWFt?=
 =?utf-8?B?K0szOWhBRjZjY2NQcXUzS3lkNC9yeEhua2xKeVVudzJwZ0JhQ2M0azBRc0cz?=
 =?utf-8?B?NzF1VmplSW15Z1RsYldZUStpUzVJOUdLbXd1L1VjR2V1VUtucStEdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29842ba3-d370-40ac-1fc9-08da4306b41a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3897.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2022 13:08:50.0884 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jm38lQD5L52V+CEAIiL2snmr/p03LIJTc8VvCkpVb8cvT7HUE28idjJ7G/tdMdK3AeNcd3bcozPfZ1yFth8HYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2939
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

--------------66ImXz0fBI5FzKolZG4Ojh6p
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 5/26/2022 3:24 PM, Sharma, Shashank wrote:
> Hey Amar,
>
> On 5/26/2022 11:48 AM, Somalapuram Amaranath wrote:
>> Allocate memory for register value and use the same values for 
>> devcoredump.
>> v1 -> V2: Change krealloc_array() to kmalloc_array()
>>
>> Signed-off-by: Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu.h         | 1 +
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 7 +++++++
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c  | 6 +++---
>>   3 files changed, 11 insertions(+), 3 deletions(-)
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
>> index eedb12f6b8a3..f3ac7912c29c 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>> @@ -1709,17 +1709,24 @@ static ssize_t 
>> amdgpu_reset_dump_register_list_write(struct file *f,
>>           i++;
>>       } while (len < size);
>>   +    new = kmalloc_array(i, sizeof(uint32_t), GFP_KERNEL);
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
>> index 4daa0e893965..866b4980a6fa 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> @@ -4720,15 +4720,15 @@ int amdgpu_device_pre_asic_reset(struct 
>> amdgpu_device *adev,
>>     static int amdgpu_reset_reg_dumps(struct amdgpu_device *adev)
>>   {
>> -    uint32_t reg_value;
>>       int i;
>>         lockdep_assert_held(&adev->reset_domain->sem);
>>       dump_stack();
>>         for (i = 0; i < adev->num_regs; i++) {
>> -        reg_value = RREG32(adev->reset_dump_reg_list[i]);
>> - trace_amdgpu_reset_reg_dumps(adev->reset_dump_reg_list[i], reg_value);
>> +        adev->reset_dump_reg_value[i] = 
>> RREG32(adev->reset_dump_reg_list[i]);
>> + trace_amdgpu_reset_reg_dumps(adev->reset_dump_reg_list[i],
>> +                adev->reset_dump_reg_value[i]);

Alignment is showing spaces in email. But its 2 tabs in code.


Regards,
S.Amarnath


> Please fix the alignment with the line above, after that, please feel 
> free to use:
> Reviewed-by: Shashank Sharma <shashank.sharma@amd.com>
>
> - Shashank
>>       }
>>         return 0;
--------------66ImXz0fBI5FzKolZG4Ojh6p
Content-Type: multipart/related;
 boundary="------------80No8rWIYRw8Kj2rvo2tElBH"

--------------80No8rWIYRw8Kj2rvo2tElBH
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 5/26/2022 3:24 PM, Sharma, Shashank
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:483cf4d0-ef9d-ea0c-e0ea-8c006051ba55@amd.com">Hey Amar,
      <br>
      <br>
      On 5/26/2022 11:48 AM, Somalapuram Amaranath wrote:
      <br>
      <blockquote type="cite">Allocate memory for register value and use
        the same values for devcoredump.
        <br>
        v1 -&gt; V2: Change krealloc_array() to kmalloc_array()
        <br>
        <br>
        Signed-off-by: Somalapuram Amaranath
        <a class="moz-txt-link-rfc2396E" href="mailto:Amaranath.Somalapuram@amd.com">&lt;Amaranath.Somalapuram@amd.com&gt;</a>
        <br>
        ---
        <br>
        &nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 1 +
        <br>
        &nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 7 +++++++
        <br>
        &nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_device.c&nbsp; | 6 +++---
        <br>
        &nbsp; 3 files changed, 11 insertions(+), 3 deletions(-)
        <br>
        <br>
        diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
        b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
        <br>
        index 76df583663c7..c79d9992b113 100644
        <br>
        --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
        <br>
        +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
        <br>
        @@ -1042,6 +1042,7 @@ struct amdgpu_device {
        <br>
        &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* reset dump register */
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *reset_dump_reg_list;
        <br>
        +&nbsp;&nbsp;&nbsp; uint32_t&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *reset_dump_reg_value;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; num_regs;
        <br>
        &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_reset_domain&nbsp;&nbsp;&nbsp; *reset_domain;
        <br>
        diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
        b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
        <br>
        index eedb12f6b8a3..f3ac7912c29c 100644
        <br>
        --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
        <br>
        +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
        <br>
        @@ -1709,17 +1709,24 @@ static ssize_t
        amdgpu_reset_dump_register_list_write(struct file *f,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; i++;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } while (len &lt; size);
        <br>
        &nbsp; +&nbsp;&nbsp;&nbsp; new = kmalloc_array(i, sizeof(uint32_t), GFP_KERNEL);
        <br>
        +&nbsp;&nbsp;&nbsp; if (!new) {
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret = -ENOMEM;
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto error_free;
        <br>
        +&nbsp;&nbsp;&nbsp; }
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =
        down_write_killable(&amp;adev-&gt;reset_domain-&gt;sem);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto error_free;
        <br>
        &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; swap(adev-&gt;reset_dump_reg_list, tmp);
        <br>
        +&nbsp;&nbsp;&nbsp; swap(adev-&gt;reset_dump_reg_value, new);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;num_regs = i;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; up_write(&amp;adev-&gt;reset_domain-&gt;sem);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret = size;
        <br>
        &nbsp; &nbsp; error_free:
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfree(tmp);
        <br>
        +&nbsp;&nbsp;&nbsp; kfree(new);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;
        <br>
        &nbsp; }
        <br>
        &nbsp; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
        b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
        <br>
        index 4daa0e893965..866b4980a6fa 100644
        <br>
        --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
        <br>
        +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
        <br>
        @@ -4720,15 +4720,15 @@ int amdgpu_device_pre_asic_reset(struct
        amdgpu_device *adev,
        <br>
        &nbsp; &nbsp; static int amdgpu_reset_reg_dumps(struct amdgpu_device
        *adev)
        <br>
        &nbsp; {
        <br>
        -&nbsp;&nbsp;&nbsp; uint32_t reg_value;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i;
        <br>
        &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; lockdep_assert_held(&amp;adev-&gt;reset_domain-&gt;sem);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dump_stack();
        <br>
        &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i = 0; i &lt; adev-&gt;num_regs; i++) {
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reg_value = RREG32(adev-&gt;reset_dump_reg_list[i]);
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        trace_amdgpu_reset_reg_dumps(adev-&gt;reset_dump_reg_list[i],
        reg_value);
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;reset_dump_reg_value[i] =
        RREG32(adev-&gt;reset_dump_reg_list[i]);
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        trace_amdgpu_reset_reg_dumps(adev-&gt;reset_dump_reg_list[i],
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;reset_dump_reg_value[i]);
        <br>
      </blockquote>
    </blockquote>
    <p>Alignment is showing spaces in email. But its 2 tabs in code.</p>
    <img src="cid:part1.Xziuqf4a.c74LRdxP@amd.com" alt=""><br>
    Regards,<br>
    S.Amarnath
    <p><br>
    </p>
    <blockquote type="cite" cite="mid:483cf4d0-ef9d-ea0c-e0ea-8c006051ba55@amd.com">Please fix
      the alignment with the line above, after that, please feel free to
      use:
      <br>
      Reviewed-by: Shashank Sharma <a class="moz-txt-link-rfc2396E" href="mailto:shashank.sharma@amd.com">&lt;shashank.sharma@amd.com&gt;</a>
      <br>
      <br>
      - Shashank
      <br>
      <blockquote type="cite">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
        <br>
        &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;
        <br>
      </blockquote>
    </blockquote>
  </body>
</html>
--------------80No8rWIYRw8Kj2rvo2tElBH
Content-Type: image/png; name="imNmJuhYCmZqwnZU.png"
Content-Disposition: inline; filename="imNmJuhYCmZqwnZU.png"
Content-Id: <part1.Xziuqf4a.c74LRdxP@amd.com>
Content-Transfer-Encoding: base64

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

--------------80No8rWIYRw8Kj2rvo2tElBH--

--------------66ImXz0fBI5FzKolZG4Ojh6p--
