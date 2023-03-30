Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9754EC761A6
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Mar 2023 13:13:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 12E7110EE27;
	Thu, 30 Mar 2023 13:13:49 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2C4C510EE14
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Mar 2023 13:13:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oYptxXO/gfNg8/ft2hJyw5Zl3qZJoJcQSjksqlINg0CDb30BEpQMoZw4rd8z/6CS28ffji4o9Vz5L62afYPq30/32hsr0zpLLziJH86rizL0vzPoM6IQ+yEZHUQwXIOJ7bFnGkX4Uhc1DUghMvR3D34vGbepuTY0DzN3voqQkOjv/Qu0SJxBIBxqhh0Ng0+E+b/km4EBaIdmxx97rD3c2jcrfTlhbiIq8f3EmVQIHKIH7CXu1JdiOM8XBMihC5SOErfHVV4zbAjSbz2VoCzRdiBOR7g7ujL/NH8MDmR6P+Vsv9UeVtvi/SYVg0WUX1gkEwyTTRAGrPR+UectK/JnWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sRFo6m3vSP0qPWzzxbKZQc2eqHoaGC4HhhQKcIVq9MM=;
 b=caVEjw3S8rLf0QrSaIDDrxSyEEVluU19TW7N/x4Rlu+sDXQejMJfzYLdgtOayMlZJx2S/ztxN5EmvGLEjryYkctuq/WXACTIMQZMpARwvzmiUJdSnQ/yDhgxVKenRcycVIwq32eT+MWul8vqqEDrHOyAawqvoQ2WuCoD6or3O21ovRGSPhUNH0tidalr2hlfFysJoe7I9OnlfACD/pu6BvaVgpOeD7cSUvUHMndI+NOw0PETChwDmV9IeIjEo/mknLiXLw2I6DxiNhvin7f04dyZc6yroGJhuiUHSUHqqxVus8Rvhh8sgGK7AXypZBsxUSzUISmQACtaPracoWb4pQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sRFo6m3vSP0qPWzzxbKZQc2eqHoaGC4HhhQKcIVq9MM=;
 b=IkPnaw4falGoZDeey4ooMVhworN4a/teWW/VIhII+Dazk6eyLSQsJRWhwpwz/yTIjQ+JvCY0wwXvq2wDyJ2raIafs9rQ5zlqDz6woO+07z8swG4mI9oXh/VwuNkzp/HdoHPM9CbWmnabkiHcV9mEKmJOm90fB09Ry15glNZdAU8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB5667.namprd12.prod.outlook.com (2603:10b6:303:18a::10)
 by DM6PR12MB4909.namprd12.prod.outlook.com (2603:10b6:5:1ba::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.35; Thu, 30 Mar
 2023 13:13:45 +0000
Received: from MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::755d:fed:c4a:bf05]) by MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::755d:fed:c4a:bf05%4]) with mapi id 15.20.6222.035; Thu, 30 Mar 2023
 13:13:45 +0000
Message-ID: <19239825-6e18-17e7-05cb-00deb37108c6@amd.com>
Date: Thu, 30 Mar 2023 15:13:38 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 01/16] drm/amdgpu: rename num_doorbells
Content-Language: en-US
To: Luben Tuikov <luben.tuikov@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230329154753.1261-1-shashank.sharma@amd.com>
 <20230329154753.1261-2-shashank.sharma@amd.com>
 <488b89ff-e9f4-3017-503f-59456e935000@amd.com>
From: Shashank Sharma <shashank.sharma@amd.com>
In-Reply-To: <488b89ff-e9f4-3017-503f-59456e935000@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0088.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9b::13) To MW4PR12MB5667.namprd12.prod.outlook.com
 (2603:10b6:303:18a::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB5667:EE_|DM6PR12MB4909:EE_
X-MS-Office365-Filtering-Correlation-Id: e5de0290-06f8-41a9-11b9-08db31209762
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oJcIBCmPE8wtX8cGj2CUeFyPuTMK3TV6g9upmIidWYWzPoHaxz7bEhdzsW5fm60ghfGYeplocxXkfpbUOVNR9uO0y2HUxa/L8s3ZcEe6iOd5btzUKR6Ba3Z/nVVVCkt9kpoLUcmE2g2J2TM5cLUOhzJiWoRhIZntrRYSbEdvyQVyF82/4Jo9orb5PHvhGUA3nOIk/86dXZZm4QR80SiGvyWfGngONlP1EwXaHYiqVQFdiToKWyfECa7S6S/fQ5qOyeD5VFFIC5TbKKeLqoDVT5IxUwa+tz0I451oRMnc8YEmCd2HZDJjlqts2NB52I/7nLoplxTm4879LCsUqR6CCUIDGMLQBEZNAIPLMUTggG39JmRHyYByRUKX8v0ibSAnGBP2sztRKGh82aMqBrFKq6oVvLaM4WyDU90SRAJLuf6CFcVDpnkaFQMi9I+DeMPvUp+rJx4rKQ72znsYSAX0MelwNCW7tkDPKTGJ3jIPP7VRIuGq8s/LPpc6Mn4gcN6XEbewfSBv7at5GkP+taEKxkpGcW/SHfWqEiC0OzYawp6mqgg8AFu0unlt2zdjbxSox+i7eJwOD+rfy83JKRi+Q2w0TscV1V04DnKY9biifiO6bHuZGObB93SVDw21ufFQiwebqhlrPRtRmqQpRPfUuw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB5667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(39860400002)(346002)(366004)(396003)(136003)(451199021)(66556008)(316002)(31686004)(6666004)(478600001)(2906002)(53546011)(2616005)(6486002)(38100700002)(6512007)(6506007)(26005)(66946007)(186003)(54906003)(66476007)(83380400001)(8676002)(4326008)(8936002)(41300700001)(44832011)(5660300002)(86362001)(36756003)(31696002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UEVpSlREbmhTb0NWbFJWTStNUXRQMlQxM3RJRHJ0WmdlZE1hazlTSnl4NE55?=
 =?utf-8?B?ZlJ1RytESkx3UWtNOFczbk11WkV4V2RBRFFHRStuSnl6UUtra1VMekgrV1VS?=
 =?utf-8?B?YTJkTTR6SzYra3kxdUROUngvaHVrblJPVCtjZ0kyMjJxeEFOb2wvbnp4dzRE?=
 =?utf-8?B?SS9VVkZrejdyL1U2RTJQOFN1UU9QYVc4WDd0bE5LSXh1N1FrZ29Td3BKRnE4?=
 =?utf-8?B?TGF1NS9IditEbDVuOUhrNE1xRnRRVVdRRXlKeFdCdGZIQTEvajc0aWlYVytq?=
 =?utf-8?B?Z09BTmZ2akc0cjRHQnZKK0EyWkh4UVZWZHZmTVI5VzE5NW9yUkVPYVZKOExa?=
 =?utf-8?B?M3BESEh4Z3JMdisvcG1BRWZWQTNZU1pqdkZxUDRGZURheFRhbXVYcitjcTFU?=
 =?utf-8?B?N1ZaTVdoT0dxRnpKNzAwanU4NjJOdktEQzJMbkJBRnFJeG1OYnRlRHl1YU9F?=
 =?utf-8?B?aFJiNkYxMGFERFcwdldCbVN6elJsUndWcUdxS0c3eXI5Zmlya2d4cnZkemFL?=
 =?utf-8?B?YmNzZ05jVGgzZXZZbitBMkVrcGd4Uzh1N1NYWXJaeXc5TzM3RGRvbmtXaWl5?=
 =?utf-8?B?SFQ3UUpBREpQUGh4K1AvRXJacEdoRG1EcTd0M2VzMjFIY2V0RXEzcUozRDJE?=
 =?utf-8?B?aXRyRWIvTmJhNlhRN21FY2hXajlqRXFXV2c4aTd5WWp6VU0zZC9MSDRBY2t2?=
 =?utf-8?B?eldwT1gxbGxvUTNDcjY4bjVNaEI0VjZjd1hkdjY3UWdJQ1lIWXpSeWNjak40?=
 =?utf-8?B?Tm5tZExlN0gwWHFOOEpwUTFUVmNJWmN6ajc3WGxwR1Y0V3MwbkZiMldtNTBo?=
 =?utf-8?B?d2M5R0cxNmFuL1ZrTWRZVTJHYkczZS8vSkhla2lOcU41SUUxUG9XbGlVSkxX?=
 =?utf-8?B?UUx2S25YZFM4QmhoK001NFhML0QwbmRMbjV2SWQzb1FvTEpBRVI0Z1J4Tmg3?=
 =?utf-8?B?WXliM1pvZzZjdGdCZ3F0dzUxTEhRWkF2RDhLZGZDSE84azMvZ25tckVVRkVa?=
 =?utf-8?B?NXgwcUZkS3F1YmFJS3M3RlNYUjFHTVBwNTlFTDNtZEY3ckNlcUZ6ZVBtcFRn?=
 =?utf-8?B?bjhoUTJiblE4THR0SUlhMHMwNU1Ia1I1Y24zUW9sL2wxZk5RWkxQb0YxNkNF?=
 =?utf-8?B?M05hVDl0NkNJUzhxMVdLS1RuQzMzZGh5MVhYRkJVN012eFdlY1V2ZFRZNWdr?=
 =?utf-8?B?c0VSZmZpNHllY0FRYjh2TGpFUXl2ZE5IaXBPNXZuMk9YelhDempYZVZINzVp?=
 =?utf-8?B?N2dVQTdDTDdJRnFrUVV6akNtNGhma05BZmpFVDVKM1ZuV09tK29XY0dZeVJn?=
 =?utf-8?B?bmJqWFJNSDB0NDM1TW5WblpNZDBFZ3F2Q05NcTRiREZmdGJjMnNEdW53ejZq?=
 =?utf-8?B?Y0xmNTFOZ29FcVB1bllHSkVzTWRFaXNlRFlSNmVXRjBEWXZ4MjFVWHp3QlpH?=
 =?utf-8?B?RGJSc3o1RVA2WDJxa2hSdWNyL2VpVHcxb3dzL24zMWl0YTRtT01JYjY4MDh0?=
 =?utf-8?B?MEI4cDdkc3RCSmhhV1ltK08zaVBiTERMZXZwTEFMV1l0YmlmR09Qb3lkL2Ri?=
 =?utf-8?B?Tmc1NTdjUExzZTNlbko0dmxlaFNxL1hmeDErVmNzRUFwSmtUa0FFMVdhTWFy?=
 =?utf-8?B?UVBZMGViVk4rZWtlOG1CY2N5M2NJUXllWVNucUxua3dqbnlRZEM5bnV4bFU0?=
 =?utf-8?B?WStROXA3WGorVUxxd05aVk5CNkFiYUY0TmdER0JmUUVmQ3hJdHhFTm9aOXNo?=
 =?utf-8?B?MzRyOEQ2Z1VCQlhZb0ZNaUZHNkZDeENlbVlyRE9oeXVRVnlHUHhqNTVrWmhQ?=
 =?utf-8?B?blVRa2dNMG9OdENiZElNRzV3VENiVWFpOFQvakdJcHdHOG9NTDlSbFVmT2hJ?=
 =?utf-8?B?YlRpVTZTODJNRTlVK0NPS3BPdFFxUHF6SnZEMHRyTmM0aXBGVHRPbE1tMFc2?=
 =?utf-8?B?MmJiejJWOElPc2h2M085V1VJVExMdlhKejZyeDRnNFNLdXJycnljOFRnQ0ZV?=
 =?utf-8?B?NjgrMHYzK1lpbWxQY2l6QkVxS2JZMUdqYmVTeXM1R2RHSjdaejJqSXZ2QWVl?=
 =?utf-8?B?ZFo2b2tHZFhlL3lYSkpmb3BNUmJmRC9hTjBlV1lNU09GeGZGV1ZmeG1mU0N6?=
 =?utf-8?Q?uEW3jMKBAh+dTEFle24KB0ROg?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5de0290-06f8-41a9-11b9-08db31209762
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB5667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2023 13:13:45.4806 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R0JJxKq8ZwAYnGLgaThYx+CGS21e99WJUcfxTcpWHYpFacMhIKkMFPWVecvsEugc7/GAl8F1Sl8XP5TSWNlFsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4909
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
 Shashank Sharma <contactshashanksharma@gmail.com>,
 Christian Koenig <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hello Luben,

Thanks for the review, comments inline.


On 30/03/2023 15:11, Luben Tuikov wrote:
> Hi Shashank,
>
> Inline:
>
> On 2023-03-29 11:47, Shashank Sharma wrote:
>> From: Shashank Sharma <contactshashanksharma@gmail.com>
>>
>> Rename doorbell.num_doorbells to doorbell.num_kernel_doorbells to
>> make it more readable.
>>
>> Cc: Alex Deucher <alexander.deucher@amd.com>
>> Cc: Christian Koenig <christian.koenig@amd.com>
>> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c   |  6 +++---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c   | 22 ++++++++++----------
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h |  4 +++-
>>   3 files changed, 17 insertions(+), 15 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>> index f99d4873bf22..0385f7f69278 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>> @@ -96,7 +96,7 @@ static void amdgpu_doorbell_get_kfd_info(struct amdgpu_device *adev,
>>   					 size_t *start_offset)
>>   {
>>   	/*
>> -	 * The first num_doorbells are used by amdgpu.
>> +	 * The first num_kernel_doorbells are used by amdgpu.
>>   	 * amdkfd takes whatever's left in the aperture.
>>   	 */
>>   	if (adev->enable_mes) {
>> @@ -109,11 +109,11 @@ static void amdgpu_doorbell_get_kfd_info(struct amdgpu_device *adev,
>>   		*aperture_base = adev->doorbell.base;
>>   		*aperture_size = 0;
>>   		*start_offset = 0;
>> -	} else if (adev->doorbell.size > adev->doorbell.num_doorbells *
>> +	} else if (adev->doorbell.size > adev->doorbell.num_kernel_doorbells *
>>   						sizeof(u32)) {
>>   		*aperture_base = adev->doorbell.base;
>>   		*aperture_size = adev->doorbell.size;
>> -		*start_offset = adev->doorbell.num_doorbells * sizeof(u32);
>> +		*start_offset = adev->doorbell.num_kernel_doorbells * sizeof(u32);
>>   	} else {
>>   		*aperture_base = 0;
>>   		*aperture_size = 0;
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> index afe6af9c0138..57ee1c4a81e9 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> @@ -593,7 +593,7 @@ u32 amdgpu_mm_rdoorbell(struct amdgpu_device *adev, u32 index)
>>   	if (amdgpu_device_skip_hw_access(adev))
>>   		return 0;
>>   
>> -	if (index < adev->doorbell.num_doorbells) {
>> +	if (index < adev->doorbell.num_kernel_doorbells) {
>>   		return readl(adev->doorbell.ptr + index);
>>   	} else {
>>   		DRM_ERROR("reading beyond doorbell aperture: 0x%08x!\n", index);
>> @@ -616,7 +616,7 @@ void amdgpu_mm_wdoorbell(struct amdgpu_device *adev, u32 index, u32 v)
>>   	if (amdgpu_device_skip_hw_access(adev))
>>   		return;
>>   
>> -	if (index < adev->doorbell.num_doorbells) {
>> +	if (index < adev->doorbell.num_kernel_doorbells) {
>>   		writel(v, adev->doorbell.ptr + index);
>>   	} else {
>>   		DRM_ERROR("writing beyond doorbell aperture: 0x%08x!\n", index);
>> @@ -637,7 +637,7 @@ u64 amdgpu_mm_rdoorbell64(struct amdgpu_device *adev, u32 index)
>>   	if (amdgpu_device_skip_hw_access(adev))
>>   		return 0;
>>   
>> -	if (index < adev->doorbell.num_doorbells) {
>> +	if (index < adev->doorbell.num_kernel_doorbells) {
>>   		return atomic64_read((atomic64_t *)(adev->doorbell.ptr + index));
>>   	} else {
>>   		DRM_ERROR("reading beyond doorbell aperture: 0x%08x!\n", index);
>> @@ -660,7 +660,7 @@ void amdgpu_mm_wdoorbell64(struct amdgpu_device *adev, u32 index, u64 v)
>>   	if (amdgpu_device_skip_hw_access(adev))
>>   		return;
>>   
>> -	if (index < adev->doorbell.num_doorbells) {
>> +	if (index < adev->doorbell.num_kernel_doorbells) {
>>   		atomic64_set((atomic64_t *)(adev->doorbell.ptr + index), v);
>>   	} else {
>>   		DRM_ERROR("writing beyond doorbell aperture: 0x%08x!\n", index);
>> @@ -1034,7 +1034,7 @@ static int amdgpu_device_doorbell_init(struct amdgpu_device *adev)
>>   	if (adev->asic_type < CHIP_BONAIRE) {
>>   		adev->doorbell.base = 0;
>>   		adev->doorbell.size = 0;
>> -		adev->doorbell.num_doorbells = 0;
>> +		adev->doorbell.num_kernel_doorbells = 0;
>>   		adev->doorbell.ptr = NULL;
>>   		return 0;
>>   	}
>> @@ -1049,27 +1049,27 @@ static int amdgpu_device_doorbell_init(struct amdgpu_device *adev)
>>   	adev->doorbell.size = pci_resource_len(adev->pdev, 2);
>>   
>>   	if (adev->enable_mes) {
>> -		adev->doorbell.num_doorbells =
>> +		adev->doorbell.num_kernel_doorbells =
>>   			adev->doorbell.size / sizeof(u32);
>>   	} else {
>> -		adev->doorbell.num_doorbells =
>> +		adev->doorbell.num_kernel_doorbells =
>>   			min_t(u32, adev->doorbell.size / sizeof(u32),
>>   			      adev->doorbell_index.max_assignment+1);
>> -		if (adev->doorbell.num_doorbells == 0)
>> +		if (adev->doorbell.num_kernel_doorbells == 0)
>>   			return -EINVAL;
>>   
>>   		/* For Vega, reserve and map two pages on doorbell BAR since SDMA
>>   		 * paging queue doorbell use the second page. The
>>   		 * AMDGPU_DOORBELL64_MAX_ASSIGNMENT definition assumes all the
>>   		 * doorbells are in the first page. So with paging queue enabled,
>> -		 * the max num_doorbells should + 1 page (0x400 in dword)
>> +		 * the max num_kernel_doorbells should + 1 page (0x400 in dword)
>>   		 */
>>   		if (adev->asic_type >= CHIP_VEGA10)
>> -			adev->doorbell.num_doorbells += 0x400;
>> +			adev->doorbell.num_kernel_doorbells += 0x400;
>>   	}
>>   
>>   	adev->doorbell.ptr = ioremap(adev->doorbell.base,
>> -				     adev->doorbell.num_doorbells *
>> +				     adev->doorbell.num_kernel_doorbells *
>>   				     sizeof(u32));
>>   	if (adev->doorbell.ptr == NULL)
>>   		return -ENOMEM;
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
>> index 7199b6b0be81..12263986f889 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
>> @@ -29,7 +29,9 @@ struct amdgpu_doorbell {
>>   	resource_size_t		base;
>>   	resource_size_t		size;
>>   	u32 __iomem		*ptr;
>> -	u32			num_doorbells;	/* Number of doorbells actually reserved for amdgpu. */
>> +
>> +	/* Number of doorbells reserved for amdgpu kernel driver */
>> +	u32 num_kernel_doorbells;
> The variable name should be indented to the same column as the previous variables.
> 	u32                     num_kernel_doorbells;

Noted,

-Shashank

> With that change, this patch is
> Acked-by: Luben Tuikov <luben.tuikov@amd.com>
