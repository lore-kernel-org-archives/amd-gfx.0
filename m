Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D781C3DA6E
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Dec 2023 01:58:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BCF7D10E647;
	Thu, 21 Dec 2023 01:58:52 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2083.outbound.protection.outlook.com [40.107.94.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 21CE210E647
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Dec 2023 01:58:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VRGjiZRr4Nd2Zu9nA9MzAXtlbKx0oShxY20FnKfTSLHBG2ndBLV9/DQAuvbrl5dhEq/pvMfoPEe3I4Xb/qIPBK53BlNv2IfdSan7LfSOcaBHYCtL5CEj8qB/zxD/ygl0c3W07CnRbOIyMXdMT9RpVZqKZi1g2FJYygPGBqkShBe1yjRn4PrQLShC98TZZ6xiAc4eKpRjxSSjt127BTLeMNO3v/2q644QmrKFNAhQiOzi5w5Oza12+7LqWCUZAx28EWG2xBpNirztG81PeTNLY3NQJsLXzoNa+CoQP30Qae+wPvvARIevEEISfpdlEcmPSAOMxenwKv61RSnQR9xcuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aXUdZMRLLxfb5X1Hxy05E110n0lzqubMj07hlsjBHjI=;
 b=cw/bVVKoi+Rxn5Tzy56ZXyEwb9NfWnG3nOGcmdYh2k/0X+PG5i+BSJqgg0nT4MHL456Poi/MJRmtVP20mh9/kCYx2HyVBHSk/IBy2G4Pyc88eVbtekUgKszUODODwAep9kTZ+H/mMBSbmt22syJ2ZiAW1vukMXTYSxbHANfr5c1canyZcUj5gxLX3snXVXJ2N8+WSGwkshNAbcywmAWGOX6gvgP996plGU50TC7eSP0Fazg3Y70vkb+udAexLT/NQOdhO3KkojX+Xz5ONurILXtnNYOIG78NXg0pE9z6sR6XiKxNcFZL6Ejm4U0noONfjvUEkXCTPAV0ePlhRCjDwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aXUdZMRLLxfb5X1Hxy05E110n0lzqubMj07hlsjBHjI=;
 b=xRDzECrXc4JCX73+LXylIds45yGEDSgpXCJtu2d8aj8KD/f6ACc5quYrMO06SNerzYod75YpK9IL96poVavap4IgiBex09WjBb2pRBXUs6W0ishRk2/YMhpkQ4M/LhmV5C6cGMHEhq++9GQUDEXdS5idI2LpJ3qKK7jnJyRmiQg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6351.namprd12.prod.outlook.com (2603:10b6:8:a2::6) by
 CH0PR12MB5284.namprd12.prod.outlook.com (2603:10b6:610:d7::13) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7113.18; Thu, 21 Dec 2023 01:58:47 +0000
Received: from DM4PR12MB6351.namprd12.prod.outlook.com
 ([fe80::8650:7935:179:f18c]) by DM4PR12MB6351.namprd12.prod.outlook.com
 ([fe80::8650:7935:179:f18c%5]) with mapi id 15.20.7113.016; Thu, 21 Dec 2023
 01:58:46 +0000
Message-ID: <8fd5d4dc-e781-475e-b90f-b43001ab224b@amd.com>
Date: Thu, 21 Dec 2023 09:58:38 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Check resize bar register when system uses
 large bar
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Ma Jun <Jun.Ma2@amd.com>, amd-gfx@lists.freedesktop.org
References: <20231219055802.304678-1-Jun.Ma2@amd.com>
 <5c64d777-510d-4440-b1b6-aaccd7bb71a0@gmail.com>
From: "Ma, Jun" <majun@amd.com>
In-Reply-To: <5c64d777-510d-4440-b1b6-aaccd7bb71a0@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR02CA0029.apcprd02.prod.outlook.com
 (2603:1096:4:195::6) To DM4PR12MB6351.namprd12.prod.outlook.com
 (2603:10b6:8:a2::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6351:EE_|CH0PR12MB5284:EE_
X-MS-Office365-Filtering-Correlation-Id: 1898e507-60a5-4ffa-c53e-08dc01c85e2e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9UPDnDguLTBJhkDnnCjY5XpKnLEoQI5d7b+RZb5E/DLdj709eWQHK9KMQrO48AMJnxJMO2YTsrXX4INYDrAbI2zmrztTVvNlm+5BcNzM7HyJrOqX7O0Gjns0e5UGdPFGSf+pgJnYW/HZNcNbuonL6Tpzcn/xAr42QJ55tjoql8AxzTFAVLXsLUaODuJmce0HotVZRBf5VngCukcJaJlGCt7i3+e8O2q7W0G2ls8cwAN0x3IcD/AayFD38iPHzgOtQtv+Kdj4saLRoSFfAJ0pdYEkXOMVPhgV2cyESQf49znek07uC06fhLCwiJ8vM6v96m7ZZZhK8tXkU6rlOgkd/GJvzAVIJMXH6uos5F6XVoXv1OSReeSwina2qaTafjRLcTEjp5r22y8EAy/49oji8XthBx31N4qTUHT14vgi/YIISAUaVd8m6dZ3lb4tjgEBTLDYrM3ZEGSUMGHdfrE0ywf8F8mMSa8HG9TSY2qYr0T1rRf1BnPxvq7jhFxXdxLFL/M/0zEz4ZofFsZQgJIbti2CkgksrX/xnXu1ysvWPgCY2uuEQjp28WkLMuYxZidlL85gyaW9zbGs6S1QAF91db5W0NRYV4y1jLIEdTP4nFqaoXChpO4SOpYSUB3MzYTahUPGw+/V8Q7QE+7f40zNWwhkrMWKuymjwi2z6lH1p8gudP0rVWHc+25+wWYu6mx3
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB6351.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(376002)(136003)(39860400002)(346002)(396003)(230922051799003)(230173577357003)(230273577357003)(1800799012)(186009)(451199024)(64100799003)(31686004)(4326008)(26005)(83380400001)(53546011)(66574015)(5660300002)(6512007)(6506007)(8676002)(66476007)(110136005)(66556008)(8936002)(6486002)(66946007)(316002)(478600001)(2616005)(38100700002)(36756003)(6666004)(2906002)(31696002)(41300700001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?alRTbUNrS1QxRnpBelF3Q2RmVnZYOE9QcnBiT05NRHNzTDFzaUhHMGVVS3M2?=
 =?utf-8?B?TDFqWXNDR1lIcDdtR3M2ZEdmRkc0U0JtVVBUcUpoRDZBU0JHMjhnSGdKMkpS?=
 =?utf-8?B?SkVsMkd4TEQ0RXNrYkJNQUZyb2lyMVBlckhxb0RxcGRrdFQydi9RcmJnMFJC?=
 =?utf-8?B?ZVNXUVFnSEQvbzV0bUVCb0Zlc0dlUjZsRHErYUlwZWpoYzlHQ1ZvYXdyaHJr?=
 =?utf-8?B?c0RobzFWdkU4cEJ4TDdCMkhlQXZtY2E4aW9CNEFrU1NKd0hFYWNkbzdLZk5X?=
 =?utf-8?B?ZVI0K2V2VENpOHYyd3d5NkZrUWhNV2pqYUJtMS82S29hSml4Vk15bFZLc1dX?=
 =?utf-8?B?MElVSEk0SWVXZUtxMVFhQklFVTRIRm5FSlArbGRFWlJPS3hiZUV1cW1jREFW?=
 =?utf-8?B?M1g2bG5NMWY4Uzk4RFE1NW9EbWc4N1R6M2xyTjMyOThIcFExbkpySDBHakY1?=
 =?utf-8?B?V0JlaWNLdW5UN0RyS1FOc29oVlVscytPb1ZGSURUY2plcmJVQWdzaVhnVnVE?=
 =?utf-8?B?aUxaQmxXdW5Mck55SUt6dTViZW5GZFRuQUJKWlB3b3J6L2REdFBNYk9JYk54?=
 =?utf-8?B?cmcvTTZDRFVLaHkwbnhCd25PNmY4Yzdlbkw2eW9NcS90UDlwVEFDREpzdjBC?=
 =?utf-8?B?TFV1K2VkbHFPL1NKNXhwM1JNZWNxTG15c0VIaTBJemc1dWdKZVVJL2dreWtq?=
 =?utf-8?B?ZWdQcVU3OHJjZGpHSlVQamtsbWFBUEFxTnR0RkFOWm5YU0lzWjEwVEtDNHVo?=
 =?utf-8?B?S1kva0NSblZqV3h3YWJhMWhBQ0ZhNmh3ZVkxRmlVWHVQTDB3SUo1S1h6N25r?=
 =?utf-8?B?UlBKR0NjeHR6NjM5d1loMXMyY2hjTnE4TEhhYytWUnJrc3JsRmsrdzJRbkg2?=
 =?utf-8?B?eUk3dXdQWjFIREpRVmNMdFJEKzlqWlNrY29VcWhoOURKdGlBS2lkeFBRa3JK?=
 =?utf-8?B?clF5cWUwVG1MMWJHQ3lJMklhVVNjdERDMkZWZFMzeStqNGVXby9kZWxXYUV1?=
 =?utf-8?B?djdjV0tvR1M0YVFESlEwZnJqZnFKT0I1cFk3aEU4TG9LU3Zrd2pPcnZ4TFZD?=
 =?utf-8?B?N2E5cjZ6SzFRUVNZeFBuV3RLa0VkWGxuYUtrNmcra1RBY3RrTVdveFl0N0w1?=
 =?utf-8?B?VjRSV28xckxPTERFV3R1cWUwd0NPL0F1NTZWZTA5SmY2MEpjbVZnZVNWdkRV?=
 =?utf-8?B?Qi9vNW5CcEo1WVdvOE5QeXhzTkxUdW1XcEpPVzUxSnRGZFFlYzdLTnVEL3Va?=
 =?utf-8?B?VjUrZzA3WndDVEQ1U1gyK29UWUpuWHQvWjRvbE5WVFdwclF3MjRHM1ZITGsw?=
 =?utf-8?B?eU93ODFvL2JMNnpycURBSnQxT1JLTHpRSDZwTlZsZFBPNmx5Mkt3SDNLYlpl?=
 =?utf-8?B?Z09sTjdFWlBDazBVNzgrUlVhT3hsTU1FL3VrVXQwckdxTGk1a3dmK1hxbHU0?=
 =?utf-8?B?enFEbEdra3dROVhKS2xpMy93T1E3bzV3Zml1aFpKNGpwdXlOOGg4cWRIV2dR?=
 =?utf-8?B?SythYmFrRy9mL2JyM3lTZ1F5b1pvR1M2V0Roc2dVQzVIZ1pxOUd3R2JqNGtv?=
 =?utf-8?B?d3dzUXZRMmRZSXFPWU9TcUR4OGZRcU8xM0hsSGlTdFNzSGRkT0FqZzdwNXFl?=
 =?utf-8?B?NHA2RDZLc09WbmhmQ2FFVjdYU1ZlVTM5MUhNYjFOZGpsRDBsenRNa2Z1R3lx?=
 =?utf-8?B?UCtKTzUzQXFxV044MDh5Y0Z0VnVhS3pKbHNRUTErS1kyQXMzOWFYRHFzVmNU?=
 =?utf-8?B?U2hPV1g3K2lMUzE3UTczQzlZcWpRNi9YVFh1UzBzbFJSRzhodzBrRStLMnJt?=
 =?utf-8?B?NDZWRUl3L3VQVjlNdXl6WkY2QVpRS3U2ZitUWDRHWDVmSmM5MHUyS0xGaGtU?=
 =?utf-8?B?emUwMkJQWHFWVTRnbmVJYzc2ZWtQYllNMnFtTldHWWxmMGY5VUJtM20zMS9h?=
 =?utf-8?B?d1hybTNLbVQxYlduZHhOK2wxdGZmTlRBWW1rcHFYdmNWMkFXSWRxVlFsSUEr?=
 =?utf-8?B?SlJQb0xyREZGZ1hway9NQjA0RnpocWtOZG9KeW9RaCtDWmxNWDFjd2lma3pv?=
 =?utf-8?B?STJaVEVYUm90SU9rblZZQVBwM29udG1ZMTZvaTQvajRwM09icFZuVFY0bWdO?=
 =?utf-8?Q?L9bchfIEgiW8t6XnDyEcJ4kzK?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1898e507-60a5-4ffa-c53e-08dc01c85e2e
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6351.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Dec 2023 01:58:46.8117 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jsBdyYoue0CAky8Deguf0tTXm1tf2uT60b+35bx4hvKrzIAvhoqwvXIzOsUNxvmi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5284
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
Cc: Alexander.Deucher@amd.com, mario.limonciello@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi Christian,


On 12/20/2023 10:10 PM, Christian König wrote:
> Am 19.12.23 um 06:58 schrieb Ma Jun:
>> Print a warnning message if the system can't access
>> the resize bar register when using large bar.
> 
> Well pretty clear NAK, we have embedded use cases where this would 
> trigger an incorrect warning.
> 
> What should that be good for in the first place?
> 
Some customer platforms do not enable mmconfig for various reasons, such as
bios bug, and therefore cannot access the GPU extend configuration
space through mmio. 

Therefore, when the system enters the d3cold state and resumes, 
the amdgpu driver fails to resume because the extend configuration
space registers of GPU can't be restored. At this point, Usually we
only see some failure dmesg log printed by amdgpu driver, it is
difficult to find the root cause. 

So I thought it would be helpful to print some warning messages at
the beginning to identify problems quickly.

Regards,
Ma Jun

> Regards,
> Christian.
> 
>>
>> Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 10 +++++++++-
>>   1 file changed, 9 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> index 4b694696930e..e7aedb4bd66e 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> @@ -1417,6 +1417,12 @@ void amdgpu_device_wb_free(struct amdgpu_device *adev, u32 wb)
>>   		__clear_bit(wb, adev->wb.used);
>>   }
>>   
>> +static inline void amdgpu_find_rb_register(struct amdgpu_device *adev)
>> +{
>> +	if (!pci_find_ext_capability(adev->pdev, PCI_EXT_CAP_ID_REBAR))
>> +		DRM_WARN("System can't access the resize bar register,please check!!\n");
>> +}
>> +
>>   /**
>>    * amdgpu_device_resize_fb_bar - try to resize FB BAR
>>    *
>> @@ -1444,8 +1450,10 @@ int amdgpu_device_resize_fb_bar(struct amdgpu_device *adev)
>>   
>>   	/* skip if the bios has already enabled large BAR */
>>   	if (adev->gmc.real_vram_size &&
>> -	    (pci_resource_len(adev->pdev, 0) >= adev->gmc.real_vram_size))
>> +	    (pci_resource_len(adev->pdev, 0) >= adev->gmc.real_vram_size)) {
>> +		amdgpu_find_rb_register(adev);
>>   		return 0;
>> +	}
>>   
>>   	/* Check if the root BUS has 64bit memory resources */
>>   	root = adev->pdev->bus;
> 
