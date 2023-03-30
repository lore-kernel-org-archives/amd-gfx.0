Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67B34C6FD1D
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Mar 2023 14:38:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C477E10E047;
	Thu, 30 Mar 2023 14:38:04 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2077.outbound.protection.outlook.com [40.107.92.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9AB5410E047
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Mar 2023 14:38:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W3MPcCXKKg9irIMAsCxAh0Td3Qzw8acvuTHVg4hfl7S7ezN98WSAyQNlLla/F/Hy8lnwAkL7QDG8/j2gyLAJ8ZCA1f2Ag+A9QG3OYkJo5SKuPSXL1rVChFk3EslSh8lEjqGUaXmCDUhFzLyDV76ewTP45VQPGZkjaJhZz4DQTW7s+jGXdMVibDRMD8mxulqVqVVlxOTbRq+5SdmD8yH6UOnQvglQoa/KOzTVEg6nbUrywkDY7OiUQttLdO3tXZGPsLL0L8caou7ubWh4CaiUlCYN0O2ELVgUX8c6pVzov/8NOtJH5lElMl6BMPNkjgv2Mxb3d0CMFwG9RV3N/b/W3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VDntjjcVO9AzFk3IDsDFVKF6PoP2SYWzbXGGrfdN2Rg=;
 b=fjLD+vnnHCj84WLv9lLk+8vktCLdzYQDnig1pfDapRPSF5L1hPNy/Px+bd9YViazpeKPUALWBFMBg0KBIHcQgbwBQo6Dy8CZbal0YlSs2guZcu+bYRpmtwwJ4WcY0ph4/nQOLKbcDkYVBqd0ikhmrZj3cUmCFAkPQw6MXhIrdYrUeUtL3VgqCuFrNqNDwgXNKMT+K9wdctZID2AP7yxq9xBR02Cvzp/ubXmXnU97Iesb8UlIs8nI0UHnHaazAMdcD5h6UZTZxCcu6u++SaOuU9BwZAccdCiMp7khZIiubPhIOH+is5BEjPyZIr7KI24ItDIM+t5wsKHwJqb3xDZaig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VDntjjcVO9AzFk3IDsDFVKF6PoP2SYWzbXGGrfdN2Rg=;
 b=UFl82D/RIO8M1aQQcZpLe35ZsIsDoIJmEEIagey2KeQ1fH6QUpQE50suwvA9acRQnyZeDEX7luRBYvtobODdj8RQijiczzSGLMVi9Yd19oQKGuS2BAvmxZyxfvghVfxyJWInjUQoqbWMyF/dWRhFq/c0wiHUDUVhRwD/tpLzFPw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB5667.namprd12.prod.outlook.com (2603:10b6:303:18a::10)
 by DM4PR12MB6640.namprd12.prod.outlook.com (2603:10b6:8:8f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.22; Thu, 30 Mar
 2023 14:38:01 +0000
Received: from MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::755d:fed:c4a:bf05]) by MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::755d:fed:c4a:bf05%4]) with mapi id 15.20.6222.035; Thu, 30 Mar 2023
 14:38:01 +0000
Message-ID: <fabf0ef4-f668-43d1-78d6-e5baac3ab098@amd.com>
Date: Thu, 30 Mar 2023 16:37:53 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 10/16] drm/amdgpu: validate doorbell read/write
Content-Language: en-US
To: Luben Tuikov <luben.tuikov@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230329154753.1261-1-shashank.sharma@amd.com>
 <20230329154753.1261-11-shashank.sharma@amd.com>
 <de6368af-b16b-0794-6eda-465d5046c142@amd.com>
From: Shashank Sharma <shashank.sharma@amd.com>
In-Reply-To: <de6368af-b16b-0794-6eda-465d5046c142@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0119.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9d::15) To MW4PR12MB5667.namprd12.prod.outlook.com
 (2603:10b6:303:18a::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB5667:EE_|DM4PR12MB6640:EE_
X-MS-Office365-Filtering-Correlation-Id: e3ad4038-552b-42b3-824c-08db312c5c8d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mmTWq7aDNVc+TGxVZbqHeTxoHbNOqvj31er2VS49xMp5ZDhY+Jtgbtr6iePung7oINr9WmjXGqJTvB2TFlwVQj6gm7g5/g506qJl+cov5pllniXNIOziZjaATCbcPABtdH42w9QBkfF4NSDu+rYGZJ6VIrKSh2K/38um1YZvyVroDQ1Gjlp3ZkBAtOSOHKqEDZ2fFLzpAwdiEJdTEONrHJjhsro4khMKsp9IH8gXYaoXc6Mnl8vUdkVXteR7/XUHVadI9L/5RX4DeoPP8zlWbQUQFFS6NSI2nHDpq4RQNKbMY577FYoC55O4pm/5Ynspw2WsPnieWAGSvNNaQiw7q8kCVRWpliTa00u5roz/ynl7TLElY6caunDYUQDv9BNzrORQxbXj9okDo1hMDAdnsWg0L2fez/o1a79Povfb7Ci7qxdPS/PHJrQi82k0zlj0MEBZ+y4OJhDwU7zye1j2XKTFZJI3mbkDH4S3W9emhHih9wz7fdOgms1hIElr3mTREBsW/5FCYO/xbQYUHI2qwHE97klzdrQN5Ryhxe22kKFr7hnSjqlPjj7n2CBNOaxjVdVGHk6Zf0GZEuzXy9rxiMyvfVmjofpEp27cltvds3Aqpe0W2OkdqxOOufdaGefaPwcokMRW8uW15sZeNorjGA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB5667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(366004)(396003)(376002)(39860400002)(346002)(136003)(451199021)(6666004)(6486002)(54906003)(478600001)(53546011)(186003)(6512007)(6506007)(316002)(44832011)(26005)(2906002)(15650500001)(5660300002)(66946007)(66476007)(8676002)(4326008)(66556008)(8936002)(86362001)(38100700002)(2616005)(36756003)(41300700001)(83380400001)(31696002)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RmtCRFd5dmtmWUQvbkpGdTlZSkdnUmVhRmx4OE50Q2w4WE9rYWZBcDUxUC9U?=
 =?utf-8?B?blhaTkhXZERRVmhvNHFybHhqY3p3dENrVmNpZGhpc1lSMjgxRHhqejdkclhJ?=
 =?utf-8?B?UmYzVkp5U25nL0xIaXVXUkNDcEh2eW5CZERBQ0xxSFZKMEFsWE5mNW1MaE1r?=
 =?utf-8?B?Z3lZelAzVFc0ZWkvZ2hlL3NjN2VaZUVudFJiRjZNbDV6Y2VlNUswQnRXK2Ji?=
 =?utf-8?B?aHBrajJwZ3JIM3EvZEJ1WXVQVE9tWmpRRWxxQ092WlZKa0pkSSt5TVBjeDBC?=
 =?utf-8?B?VWJraSt6eitRSG1uajVJbmF5eVpYa2JkRkFBOFNDa3pmbnp1NURsa2RpWmhu?=
 =?utf-8?B?V3N3Yzl6WUJ5WWJSSHlvWnU5QzVkcTZnMk9sclNXYndyTjZaN0d3dnVoQUNU?=
 =?utf-8?B?Z0RwQS83dFpkUWNLQVZUUE9wZ2ZKZTRSS3ZNZVA1bGJHakU5Rmc1SDBVQStw?=
 =?utf-8?B?VlJLWnBydlQ5bTRLUnRqN0NIWDFyRmpxdVFSUVI3S2Q5cjA2WVoxVEhDTGhn?=
 =?utf-8?B?WVR1K3dDRVVKSFBOM1BuMHU2d3hKMGFWTWpZWWF1VFNJZXcwcUJRMlZOTlVs?=
 =?utf-8?B?TVBiMTN0ZEpNekt6dHUyaEc0aEVDZ05VYW1lbTZ2MVFMVGxHKzVFNEVJeitD?=
 =?utf-8?B?RWQ1UHNnWElSeE9uNEFqNkQ1U0hDcDVwd3RjSTVES2luc1pvSFBnZ1drRnpE?=
 =?utf-8?B?K0dIbmJWTDl6aTZjL09ZV1JJSjkyVFdhN2F6Y0VSMXJlbktZenYzdE9qVVBB?=
 =?utf-8?B?TGdiM0w1b0dkSGVLQTVJL1Mrd25SVlJ1SEVud1dTK3ZCYXM0VDBJS2NtSjdI?=
 =?utf-8?B?NkJJRktTY1Z6aklZZUJUUUxwcXVZNnlpOHBNSWlEL1pZUzhUOExZZ2JSYktw?=
 =?utf-8?B?cVNyY21rR2pJc2RLeDBHNU1OSDA4dHN6QnJRZmFrQjlaVkZzYzF6UERCWVB4?=
 =?utf-8?B?YjhmTUZUcVBIaG10YnFkemFXa29GRUNyd1FsREFzczlWa1dWUWxJNnVrczZy?=
 =?utf-8?B?bXdKbzdSMEczUE1hYmlNZjVuYkYzSUVuWlB0RXZ1Z2tkYVhHb2c4K3I2bHFQ?=
 =?utf-8?B?SENhS25BcUpRTDN2L3ZKYTVJUmM4RzJtWlJxdnJTY0lFTUVjODNsUXptZFQy?=
 =?utf-8?B?K3dYc0Rhc21QRmZLRkkxNWRUZ2xQekpMNENET2RidEZ5Z1JSTlNha0IwZ1pk?=
 =?utf-8?B?UmZPYnBRbVhmcHUxTlJXWDNkOVJPK1VlUFFVL3lUZGUrNjRxQm9ZaS9ORnBI?=
 =?utf-8?B?MmdGRDhpM2VuOGJCQnU2b1NwQmVMSWltT1Y0UWNXWlB4Q3Q4dXd4KzFuWFJG?=
 =?utf-8?B?SWNZdCt6WHdwbXNSZ1V0NjgyK1ZqN0Z3Ri9pRVc4YmhpVERJek1FL29ya29M?=
 =?utf-8?B?RXBGckZuK0lTZFg2UnBQRkM4QkJEOWV5bGltRzRsNVJRd3FYeTgxRWVXRDZN?=
 =?utf-8?B?MTA5YUQwZWJaazA5K1JrUWc0YjdiSkdIS1FJMmZINGhPL3UyT1lHbVVqV2xR?=
 =?utf-8?B?SGlmOS9POVJEcmVpak0yd1ZoblZ2UlJJUlh0RmZjTGxwcDVJbmtVQjVyY1ZU?=
 =?utf-8?B?TkZsdnRQQWh1R3A5S3FRT2kvYlIyaWFPam9CSlRLdFo0c0lsSkpDUENOaDBn?=
 =?utf-8?B?cXZ3S2FuNTlTazIwQ09TMUNrMGtvUmpaSUxzYng4SnZLVmJJNjNDQTRyOTdD?=
 =?utf-8?B?N2ZVWmZ0YS9lTXhUL1dwakRBdDRzSmdialFyTTNqdk11UmlvNnEzMjVEWlhG?=
 =?utf-8?B?QW9WLzlyNWxreDAxN0NUOW5YWlgxRmtqaDBZMkk5OHpsL1FzZlFZejVPdW11?=
 =?utf-8?B?YTNrdTFGQzJzTDR1UXRhUllGcGRHbE51elYvMkcwQmdoV0hDY1lDTXF6M0lk?=
 =?utf-8?B?ci95UVIwZ2duSmIzL25WNXc5OGVENUxqVEJhN1h2OGxuazByT3QrZ3dVa2Rs?=
 =?utf-8?B?SCtWaEJQQ1NGb0o0aGZraTNUbEJsdGorL01MZXBvQ0ZrRmxZTUNCeG9mQ3BV?=
 =?utf-8?B?QVFucHNncEs1SzV5ZVZiSUFkcGNTTWNmZ3hNTWZHbnVTSkNFQVV6V1dlR1FX?=
 =?utf-8?B?dEVVSXAweTdsZTRWMjhZQXV5QXJzdGZSU05ETnBBNVU0TGh1c1NvRXhzREx1?=
 =?utf-8?Q?j8ykGXhrLvbmZO4kbxF3R8ZFq?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3ad4038-552b-42b3-824c-08db312c5c8d
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB5667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2023 14:38:00.8406 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wQNIQSxqZrWUpx2nZi4cbLDdn5ADVaHa0ZEQXxV7I8rd3bmOMlPdPpd4DoT7/vyZCUSl3yxf2rBcE0+sVf4nqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6640
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Mukul Joshi <mukul.joshi@amd.com>,
 Felix Kuehling <felix.kuehling@amd.com>,
 Christian Koenig <christian.koenig@amd.com>,
 =?UTF-8?B?77+8QXJ2aW5kIFlhZGF2?= <arvind.yadav@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 30/03/2023 16:34, Luben Tuikov wrote:
> On 2023-03-29 11:47, Shashank Sharma wrote:
>> This patch:
>> - updates start/end values for each of the doorbell object
>>    created.
>> - adds a function which validates that the kernel doorbell read/write
>>    is within this range.
>> - uses this function during doorbell writes from kernel.
>>
>> Cc: Alex Deucher <alexander.deucher@amd.com>
>> Cc: Christian Koenig <christian.koenig@amd.com>
>> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
>> Signed-off-by: ￼Arvind Yadav <arvind.yadav@amd.com>
>> ---
>>   .../gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c  | 29 ++++++++++++++++---
>>   1 file changed, 25 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c
>> index b46fe8b1378d..81713b2c28e1 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c
>> @@ -22,6 +22,25 @@
>>    */
>>   
>>   #include "amdgpu.h"
>> +#include "kfd_priv.h"
>> +
>> +static inline
>> +bool amdgpu_doorbell_valid(struct amdgpu_device *adev, u32 index)
>> +{
>> +	if (index >= adev->doorbell.kernel_doorbells.start &&
>> +	    index < adev->doorbell.kernel_doorbells.end)
>> +		return true;
>> +
>> +	if (index >= adev->mes.kernel_doorbells.start &&
>> +	    index < adev->mes.kernel_doorbells.end)
>> +		return true;
>> +
>> +	if (index >= adev->kfd.dev->kernel_doorbells.start &&
>> +	    index < adev->kfd.dev->kernel_doorbells.end)
>> +		return true;
>> +
>> +	return false;
>> +}
> Here you're excluding "end".
>
> In patch 7 we see this:
>> +	/* Last index in this object */
>> +	uint32_t end;
> Which implies that "end" is included, but in this patch, the code excludes it.
> Perhaps you intended to use "index <= ...end" here?

No, this is intended, same as array object calculation.

end = start + size;

max = start + size - 1

so (< end) not (<= end)

end says last index in this doorbell range;

- Shashank

>
> Since this isn't RTL, wouldn't it be better to describe the doorbell instance,
> with a "start" and "size"? This is traditionally used in memory management,
> and it makes comparisons and checks easy.
>
> Regards,
> Luben
>
>
>>   
>>   /**
>>    * amdgpu_mm_rdoorbell - read a doorbell dword
>> @@ -37,7 +56,7 @@ u32 amdgpu_mm_rdoorbell(struct amdgpu_device *adev, u32 index)
>>   	if (amdgpu_device_skip_hw_access(adev))
>>   		return 0;
>>   
>> -	if (index < adev->doorbell.num_kernel_doorbells) {
>> +	if (amdgpu_doorbell_valid(adev, index)) {
>>   		return readl(adev->doorbell.ptr + index);
>>   	} else {
>>   		DRM_ERROR("reading beyond doorbell aperture: 0x%08x!\n", index);
>> @@ -60,7 +79,7 @@ void amdgpu_mm_wdoorbell(struct amdgpu_device *adev, u32 index, u32 v)
>>   	if (amdgpu_device_skip_hw_access(adev))
>>   		return;
>>   
>> -	if (index < adev->doorbell.num_kernel_doorbells) {
>> +	if (amdgpu_doorbell_valid(adev, index)) {
>>   		writel(v, adev->doorbell.ptr + index);
>>   	} else {
>>   		DRM_ERROR("writing beyond doorbell aperture: 0x%08x!\n", index);
>> @@ -81,7 +100,7 @@ u64 amdgpu_mm_rdoorbell64(struct amdgpu_device *adev, u32 index)
>>   	if (amdgpu_device_skip_hw_access(adev))
>>   		return 0;
>>   
>> -	if (index < adev->doorbell.num_kernel_doorbells) {
>> +	if (amdgpu_doorbell_valid(adev, index)) {
>>   		return atomic64_read((atomic64_t *)(adev->doorbell.ptr + index));
>>   	} else {
>>   		DRM_ERROR("reading beyond doorbell aperture: 0x%08x!\n", index);
>> @@ -104,7 +123,7 @@ void amdgpu_mm_wdoorbell64(struct amdgpu_device *adev, u32 index, u64 v)
>>   	if (amdgpu_device_skip_hw_access(adev))
>>   		return;
>>   
>> -	if (index < adev->doorbell.num_kernel_doorbells) {
>> +	if (amdgpu_doorbell_valid(adev, index)) {
>>   		atomic64_set((atomic64_t *)(adev->doorbell.ptr + index), v);
>>   	} else {
>>   		DRM_ERROR("writing beyond doorbell aperture: 0x%08x!\n", index);
>> @@ -157,6 +176,8 @@ int amdgpu_doorbell_alloc_page(struct amdgpu_device *adev,
>>   		return r;
>>   	}
>>   
>> +	db_obj->start = amdgpu_doorbell_index_on_bar(adev, db_obj->bo, 0);
>> +	db_obj->end = db_obj->start + db_obj->size / sizeof(u32);
>>   	return 0;
>>   }
>>   
