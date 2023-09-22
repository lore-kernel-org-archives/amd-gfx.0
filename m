Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EADE4CE7A81
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Sep 2023 21:12:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3148710E196;
	Fri, 22 Sep 2023 21:12:16 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2043.outbound.protection.outlook.com [40.107.96.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6D28C10E196
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Sep 2023 21:12:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iIDfVrNHoAw/mGdQmsE2UWF0EmWbEZcFXA73uZo4krHscARV1QKXGpcKYabFaWttMaBuWrW+B/yBYFTsdTevYZ9EUb3bPDXKD1vuAG5F4fSez/aPGMlNNdVavbe/RkVIo1YphXqTF9uB3dgC6xRkdmalt1QAL2HyDssE2V8Ag3ciuY7RYipER5t2+JgNWstslNxV9G0Lnxr/eHGsNOQ/kHWVw6FKB8BWEfDAjU9xvcxLkWbTZt1xK7/NWnjqUqhK0eUGJXC9lHtd1hJB+0ZFQJvatNJYPffX22ONTpYz5TXpVDQ5asRAlNrpFHIDzn45O6rlNJWQigOvs3Zj89T9ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lsamJwclyhXHnxuFO0nweFeOfi/F91751VFmnrkTMf8=;
 b=lvJfoILna+w+U7d4x/HUSxRCL/CihY4dB8lYJO1BD+A1ymFbkQQiKukRV7yjsTdvnn3iciM0CQCwEymTPdzA7WDaB68o6fGaNFxCw++f7D1Wlpm0y1LjmJ8M+rIcifkpe6R4yiGE7ojrzh2kN2j6RDUOWElR+Be2pOZ/hi/88ESIJZrKIPxlpmIZ01A9pH0ldrXb/3hJzAO34kuXr2ZXu7Z3K+0/BTAP4fBkP6vpO5FWS1UwCq1oTEwd6rWYKz8jUonSdF6FVnv/RnPCAn1JPg4GRgrwrObL4UHnQs3sqNHSIjaAEYWt5PdT8ovbh2GAILVq9PkWwj3szkZ2jJ/zaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lsamJwclyhXHnxuFO0nweFeOfi/F91751VFmnrkTMf8=;
 b=gF4DtT+uRqr8itBit+g75HT6crBgrGzdFvm6x1M/bzBHvhfVhxo5lIRLSmYjwn3jgXDf67govWvArFmqNxyGy+THzzHfjvdrGGhnV/biIDxjO8nskdCWRNkBZytjjkVAOpl/mgMRZhFG/9F3NN8iDUVyW/Z4fDoqw35mUQ4coDU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3370.namprd12.prod.outlook.com (2603:10b6:5:38::25) by
 PH8PR12MB6841.namprd12.prod.outlook.com (2603:10b6:510:1c8::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.28; Fri, 22 Sep
 2023 21:12:08 +0000
Received: from DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::8a67:3bbe:8309:4f87]) by DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::8a67:3bbe:8309:4f87%3]) with mapi id 15.20.6768.029; Fri, 22 Sep 2023
 21:12:08 +0000
Message-ID: <22994930-e2fb-4be4-afdd-448ed874db05@amd.com>
Date: Fri, 22 Sep 2023 17:12:06 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:115.0) Gecko/20100101
 Thunderbird/115.2.3
Subject: Re: [PATCH] drm/amdgpu: fix memory leak in
 amdgpu_fru_get_product_info()
Content-Language: en-CA, en-US
From: Luben Tuikov <luben.tuikov@amd.com>
To: Yang Wang <kevinyang.wang@amd.com>, amd-gfx@lists.freedesktop.org,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>
References: <20230922052753.1922483-1-kevinyang.wang@amd.com>
 <17d92228-b0a2-408e-a233-e7faf4d056b7@amd.com>
Autocrypt: addr=luben.tuikov@amd.com; keydata=
 xjMEY1i6jxYJKwYBBAHaRw8BAQdAhfD+Cc+P5t/fiF08Vw25EMLiwUuxULYRiDQAP6H50MTN
 I0x1YmVuIFR1aWtvdiA8bHViZW4udHVpa292QGFtZC5jb20+wpkEExYKAEEWIQQyyR05VSHw
 x45E/SoppxulNG8HhgUCY1i6jwIbAwUJCWYBgAULCQgHAgIiAgYVCgkICwIEFgIDAQIeBwIX
 gAAKCRAppxulNG8Hhk53AP4k4UY5xfcje0c5OF1k22pNv8tErxtVpgKKZgvfetA4xwD+OoAh
 vesLIYumBDxP0BoLiLN84udxdT15HwPFUGiDmwDOOARjWLqPEgorBgEEAZdVAQUBAQdAzSxY
 a2EtvvIwd09NckBLSTarSLNDkUthmqPnwolwiDYDAQgHwn4EGBYKACYWIQQyyR05VSHwx45E
 /SoppxulNG8HhgUCY1i6jwIbDAUJCWYBgAAKCRAppxulNG8HhnBLAP4yjSGpK6PE1mapKhrq
 8bSl9reo+F6EqdhE8X2TTHPycAEAt8EkTEstSiaOpM66gneU7r+xxzOYULo1b1XjXayGvwM=
In-Reply-To: <17d92228-b0a2-408e-a233-e7faf4d056b7@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0035.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:86::6) To DM6PR12MB3370.namprd12.prod.outlook.com
 (2603:10b6:5:38::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3370:EE_|PH8PR12MB6841:EE_
X-MS-Office365-Filtering-Correlation-Id: 1730412d-37fa-4939-9e7d-08dbbbb09470
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vo6600+gUZE1dm8YHWovq99jZ/pKyf3iwCWd982U8KmkN5kB85u2m20J22U+jlSnumhSTArnrJ1r+j2qwm/B35TyCUvdaX1kYKyM9VHySp8JcQXalXTiyBePOSbgmt/YIGACdLLZC1ucAjuFHfK6nofXWMVaqpHgxVN4bjmYhJfSpt3MRqJtrs4LjvR6l058sac744lItwmSbRJp3TgAV2w8ewVOyW8Cp10R2ktqyMiDPGW0WS+qaB4aTrH12OxI7JNM4+FrCYErHfWIV46LWS1aGP0rztZYnuz9QUeI/59vyYMpTZGx/9eI4mo4g2pUArjLowBPis+92MKLdzBPnv7oDS1VN6fK0oCzD8iequALnMxEFO19KmkluaP2LnVHbpUtR7oloatrrRXFPJLrbauhrBeW/JGUOH+AbRZlSVDu3PgRQdTepV3A6QK815t6YRhPcTO1akQD1u5ANYwX3ILD9zwUWaLjFO0O2h1LvoaIhApwl9iwJXP0uFlQAj8ey7ek+FaoX2+Zg+dDBqENfmxsPsBo8tCM8DFNowzAAlFul4Ks9ukwRhCbkrc7x30G5jroSNs60oNASuih8AVhfZb2UKNwQD7X+tsQvXdd8ymiUTdYYPyTT0r8PF8ect8cDbUzGPHHJDWHL9zGW2GeNQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3370.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(136003)(396003)(39860400002)(346002)(376002)(451199024)(1800799009)(186009)(36756003)(31686004)(83380400001)(86362001)(8676002)(31696002)(44832011)(8936002)(2616005)(41300700001)(5660300002)(6512007)(26005)(6506007)(53546011)(6486002)(66946007)(38100700002)(2906002)(6636002)(66556008)(316002)(66476007)(478600001)(110136005)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c3l2L2NMMTBBTXFOeFVxakZ5OXVYTXRzQkw4WDErdVRWd04zdHZudXM4UkVv?=
 =?utf-8?B?WlVJUWlMUHRjSU93UWQwNlFMRktOUkNmUk9lc2pqQjRVQnYxQ3krcDhVNzJi?=
 =?utf-8?B?Qy94Vmo4QUYwN1IvMG1STXRtNFNrNEl4VXFJYmp6MW9iMjNBQnYvdldWeElv?=
 =?utf-8?B?TzlEYkdsVnlGdVVRS3NOWmpKbGJFMWdERW1CWlhuUWhqVzEvcGYyaTNjOVVP?=
 =?utf-8?B?K0FxdGNEcC9lM0toaHlsWk0vTUlHeVpkZll2NjJWUmNlRnU0Skw5N0prcTlq?=
 =?utf-8?B?Q2N6YVRML3dac3RWc1FxQ3VsVTdOVlJRYVdFQjhmRXYzYVFROHRjOU10bGNR?=
 =?utf-8?B?Ymg1M0dUVlJKMjdDZXhPQkpLNXdxbGVTTGovaFF1VFRUNHZ1akNGQ0tOM1dB?=
 =?utf-8?B?WXMrNXJpYzYrdHNZeEpTT2JNY09uUTJQbjYwSGNYWUhGV0tDRzgyMXdKRUxL?=
 =?utf-8?B?Z213U3FDajgxNmJ0dGFHTDZhRnlXdlRhWWVkVEQxcXk2WDlxUThtVldQaXlT?=
 =?utf-8?B?NGthZS95c0Vkd1VZZzZ6UlJJVzJJS1NxWFo1WTZMM29OSy9aRW1YVGZqZ3hj?=
 =?utf-8?B?Z2MvT0NFNGhpazdvclNDSjI5dkJIUTdObEZ6VnJNeG4vbklnUlZHdzM5QWJ5?=
 =?utf-8?B?a0w1Rk4rMUxIcm9JM3UyL3Q0dnJaY2RvNzYxMjZoeEFBWUR5c0hPcVdzVHlJ?=
 =?utf-8?B?S2pSWS83RVl2ejFXMU12TXZsdXdkVmdXUUd0SXVjZ29lOG11N2F3UnIyZnZN?=
 =?utf-8?B?Mlh5K3ZBNTd3RzR5dzJBMzVKNlBkRytaNlFlMVhLN0FiUW5lWVhXSDJkS1Nh?=
 =?utf-8?B?THBTejNQZXFHWS9BMkdtWHVoMWd4ODdybllidVBtMnFEM2x5UVRya2RMamRl?=
 =?utf-8?B?NUlMelVvVWg4T2ZUbHk2TC80VEdhNE9uVnRRTk94cFN0S0R5VWdxLzlnVGVz?=
 =?utf-8?B?SHkyVGloQW1CTFJxNWY3UkNidWloTjhYcXY0QnlQYnQra0xzT3Azb2FxVWQz?=
 =?utf-8?B?TEdnMWVQUVBwTUhjd3ZjejlYR3pOeVkxcS8vbFpydlcvRnRBYWhvSHM3KzlE?=
 =?utf-8?B?UXRGZy9xaEhFNkw4UFkyNUdtQXp6b3NOMnVxWURLcU8zOWYvTWdFNGF3cTZ5?=
 =?utf-8?B?Sms5TGV2UGdZVFpmcXlVS3hMZU9vTkZXbTBEQ01Jem50TVRuTVdybSt6SE5G?=
 =?utf-8?B?ZE5oMm01dG02UUJpK0RHTko5alNDMnN6YUt1dWlsZGdmZWl5REw4OWU5Wmti?=
 =?utf-8?B?NTJlRGJUdFIwOEZUVjZXa2g1MGN0MUQ1TFlqMVpES3lLQVNhSFlDaDcrQW9R?=
 =?utf-8?B?YWo3TzVhTTRwVG1ibmxSNi9Eams3MGZKTGw5TW1la0p3SzdENUpjcXhha3ox?=
 =?utf-8?B?dGlQRjRtSksvVFhpWDU3RlRiWmg3UEkxN3dPeWNJenUwZ281UDJQYVZxSnEr?=
 =?utf-8?B?T21BUERUYW5QdFpNdk5HS1hpTGdzTDVtaHJoaW5QQzRjNU8wSmVVYjJYT0JG?=
 =?utf-8?B?dTZIcmZuOFlOMlhUUmhKREJLbnE2ZDU0aVgzUmswUS9PWUdNUGpZRzNsQWZl?=
 =?utf-8?B?TlRSd3U5RlYxRStNVk5iVmxBTFk1ZTBSV1BoUHBYNGFHaEUwUEdiLzR2YU1W?=
 =?utf-8?B?RTZBOEd0aG51a1llL2tEWHBkRGRaU0tQeS9mbGZWc0VoaUVsMWptOHp2RzBr?=
 =?utf-8?B?NEFnNzNVdWx5R3BnMzJCZTd6Vk9QbVRmdjBUTTZFaTVsMmp1dVcrWUJmWDZy?=
 =?utf-8?B?QitoSVV3L3JYUTg1dExFN0dQTmY3ZkxidlhxTFAxakRWcndHS1M2THFKU3VU?=
 =?utf-8?B?bG9DeGZxdGJSbnp4THUzWkY3TW5tZjY2aWpmSHNabjltUG04SGllTkVobkxD?=
 =?utf-8?B?ZWlxRElXMFZzQnNYazFGeFZza29KaGs3bSt2bmlHbVJ0OXduOUE5TVNiY0xW?=
 =?utf-8?B?K3lFMW9mQjNZL3FXQzdwL1UxakZDNXVCTjBnMG5VVndhaXhPRlRVUHVjMlAw?=
 =?utf-8?B?Sm54NE1kS1htNTE0RS96QStNTVJJT3FZTzNjRTRmOWx1RVZUa1g0RE13STQ2?=
 =?utf-8?B?MmlXSkd3OE9VY2J2QUJGcUQ1SFRDYm4xK1VBZ2pPWmNhWXhvVmFSM0RxNEVr?=
 =?utf-8?Q?N5tELDJ7PAppbadOJpmV8allK?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1730412d-37fa-4939-9e7d-08dbbbb09470
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2023 21:12:08.3706 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oHn4KZhsJLzxQPnzQr1ofDlZAJpsxnqfRTI3F+A3he7nSef+loB28X/un3EM70pu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6841
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

On 2023-09-22 16:58, Luben Tuikov wrote:
> On 2023-09-22 01:27, Yang Wang wrote:
>> fix a memory leak that occurs when csum is 0,
>> the origin function will return directly and forgets to free 'pia' resource.
>>
>> Fixes: 0dbf2c562625 ("drm/amdgpu: Interpret IPMI data for product information (v2)")
>>
>> CC: Luben Tuikov <luben.tuikov@amd.com>
>> Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
> 
> Ah, yes, we should free "pia". Good catch!
> 
> Reviewed-by: Luben Tuikov <luben.tuikov@amd.com>

Retracted--see my follow-up email of making this a one-liner change, instead
of adding a whole bunch of changes which are unnecessary to fix this memory leak.

Regards,
Luben

> 
> Regards,
> Luben
> 
>> ---
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c | 11 ++++++-----
>>  1 file changed, 6 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
>> index 401651f28ba2..50b6eb447726 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
>> @@ -111,7 +111,7 @@ int amdgpu_fru_get_product_info(struct amdgpu_device *adev)
>>  {
>>  	unsigned char buf[8], *pia;
>>  	u32 addr, fru_addr;
>> -	int size, len;
>> +	int size, len, ret = 0;
>>  	u8 csum;
>>  
>>  	if (!is_fru_eeprom_supported(adev, &fru_addr))
>> @@ -171,16 +171,17 @@ int amdgpu_fru_get_product_info(struct amdgpu_device *adev)
>>  	/* Read the whole PIA. */
>>  	len = amdgpu_eeprom_read(adev->pm.fru_eeprom_i2c_bus, addr, pia, size);
>>  	if (len != size) {
>> -		kfree(pia);
>>  		DRM_ERROR("Couldn't read the Product Info Area: %d", len);
>> -		return len < 0 ? len : -EIO;
>> +		ret = len < 0 ? len : -EIO;
>> +		goto Out;
>>  	}
> 
> 
>>  
>>  	for (csum = 0; size > 0; size--)
>>  		csum += pia[size - 1];
>>  	if (csum) {
>>  		DRM_ERROR("Bad Product Info Area checksum: 0x%02x", csum);
>> -		return -EIO;
>> +		ret = -EIO;
>> +		goto Out;
>>  	}
>>  
>>  	/* Now extract useful information from the PIA.
>> @@ -220,7 +221,7 @@ int amdgpu_fru_get_product_info(struct amdgpu_device *adev)
>>  	adev->serial[sizeof(adev->serial) - 1] = '\0';
>>  Out:
>>  	kfree(pia);
>> -	return 0;
>> +	return ret;
>>  }
>>  
>>  /**
> 

-- 
Regards,
Luben

