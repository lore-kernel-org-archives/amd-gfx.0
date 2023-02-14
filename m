Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3304C61DA4
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Feb 2023 04:55:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 61CAB10E098;
	Tue, 14 Feb 2023 04:55:20 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2047.outbound.protection.outlook.com [40.107.220.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5048A10E098
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Feb 2023 04:55:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ArZGbUfNywe3XJEFCdq7/wZdlhmlppJUH3JuLvTQU4gWIs3tZjBpP39MSiSCnzdrKii7LEtf/53zdgAwPGSIpe29qyaEdP78ULL72hS7k6e2LGxuEJyJWRi/R9rbe+MVczPLq6Auzvl2VshUteOLFP+wypoICDQSC6HZH3kpDKAKOGPPJ93KqXbiB4/YEUKSU4lfHQcytfDeVURsK9EJkZkbkWGLORP326tuhxjCNLamgHVu1oo3qKGLHmsf8UfmOcxiYTJ+L3fM5lnVgrgyLPBEeAPZVKQpNa5JxshpFpi/OIO418aAIYORK5X7ycpK8v2GEWvZUy0WjpuRtAnG7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FqjdH+Yj59PO5iKbA99eOlAMhuqM0zlFpeCMvhRthXE=;
 b=fWbRuyZfuUI6dSuRUtCDKjs4khkoLGERn51PlqVdK9rZ/eTA/EwS8jHOJX1IDDHR29tHA82KzgnoUi1IQ992cdz7gQHioqNWRwZblU3xH+5/OcgIWmDQ4Nia+SBqRhSZr+P/ZKmT6CfAA8RvslOKTopYIZR5YC0qOmB59a9mASkl8WQO0acSzY5C+/XreIuIkpCWMB4bLG6vjoy2uHYD9CvmDKn1ZAsC93hc5aS/HMqr3ayWsU1wkC/frIdOhshCuy1H3e+ym9smaMPxpWNNzHf4o+rVy+FAXELnjUFYAs0ReQKhBTjPdnkY6eJTSc8SUBwXq1kTLvSh2koSitBAQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FqjdH+Yj59PO5iKbA99eOlAMhuqM0zlFpeCMvhRthXE=;
 b=TyGWjGZUHyqAhAG+eeRdwNeUip2a+4UM3XHJCA4816cIG6rmF7+yMKBAtFvl2mIocaIGCQrSvgyd4VNv0CvNNUPBJbDS0OCI+HHDTPp8i1a3zzxMzGUcuLuxDkD2YIfV5//ZQ1u1onLA/h0gCaBeapATzY5EUi9zKEI7POyEdn4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by DM4PR12MB6613.namprd12.prod.outlook.com (2603:10b6:8:b8::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.24; Tue, 14 Feb
 2023 04:55:16 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::66b2:8732:c7f0:d6ca]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::66b2:8732:c7f0:d6ca%5]) with mapi id 15.20.6086.024; Tue, 14 Feb 2023
 04:55:16 +0000
Message-ID: <623a1379-5746-1bfd-b083-c49c3cd169ea@amd.com>
Date: Tue, 14 Feb 2023 10:25:05 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH] drm/amdgpu: don't increase UMC RAS UE count if no new bad
 page
Content-Language: en-US
To: "Zhou1, Tao" <Tao.Zhou1@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Zhang, Hawking" <Hawking.Zhang@amd.com>,
 "Yang, Stanley" <Stanley.Yang@amd.com>, "Chai, Thomas"
 <YiPeng.Chai@amd.com>, "Li, Candice" <Candice.Li@amd.com>
References: <20230210084529.9695-1-tao.zhou1@amd.com>
 <fe541c9c-4684-fd02-e5bc-f28b583744af@amd.com>
 <DM5PR12MB1770AF75B3AFA71C91FEC5D9B0A29@DM5PR12MB1770.namprd12.prod.outlook.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <DM5PR12MB1770AF75B3AFA71C91FEC5D9B0A29@DM5PR12MB1770.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0005.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:25::10) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4614:EE_|DM4PR12MB6613:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e83fad5-05e7-481b-4155-08db0e47aa02
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GEdCROaF011LrVwi+2gEb4JFJHH28pepcrLLqfk5QcJSNSyMgc41NKLBdajKCxpFOu1C1tTwljV/XtkU9QGJAWoIwSDM8JIlDg416ZfqRG59xwG3qVY9r3V3xY56Z451AQdybfTp2yhhD6Tn79/8zr5CQ7fvqEN+2eksn1dLiLFb31IJ2kgXlkUq6buFoM5SGcxrQr1ORFF4SlbXA+OE4PYDb6MGcVFrmxw4Srv3AYp5qqyMzYnsk3XR8FAnepBAC0egoZ6Z2Y3Y8EvxQWjYmJORvi5OqhNp7oXq/zusTXPJxVbhXwMURt1ecpo7vDtgIgylweYGphqIvssZRRT6O18EhLf9OWvrVb+lVUl8NR2OV9BuZCxpChQAKSJ11XGE5YMf8aVUXJM4X6HRBIt8O7j0txlfB6TbuxOfL23MZD5JBd+6lpliximF6tsPqLg/wBqOxqFpbtezPWrNaf42XlpNU94mnUsRSxGN3v2Gcogq5OMAGwPyuFlUKfznD9EVTOdNrf7lof/NjCaL5rUecs4DvTWfsAiYJXJxCUYlbAtOGLABevreXA1OVOn67e6UlrSHAMmfGNqecEjVqrCZPBaQIbuT6fCr07WWu/k+iFbzQJbl/DLUGfsxXRFV9NOPdTBlXM1B6loj/z9sagE0HDQldO5NYDIGX9N2CITTzHKBx+BlME4VkxXvO4POgqffq4FqbPqC/F8hy/k5yXpuNFlheEcFm/PsZF4vfjkbnPhv8SCF1YLp4rwMPy+pId8c
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(366004)(136003)(39860400002)(346002)(376002)(396003)(451199018)(31686004)(86362001)(66946007)(8676002)(6636002)(316002)(110136005)(83380400001)(31696002)(36756003)(26005)(2616005)(53546011)(6506007)(186003)(38100700002)(921005)(6512007)(6666004)(66556008)(41300700001)(478600001)(6486002)(2906002)(66476007)(8936002)(5660300002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MEZGK0J5QkRHLzJsM1VnTks1QTV4U2h2TG9oL3RVWXNmbG5GRnV6U2xTb3BN?=
 =?utf-8?B?V0ZUVTlxanFwcjBZUGFWRFBQZlBZa1hHQks2U3c1cjBHYWdpSzJlclhZU2Mw?=
 =?utf-8?B?Ull1cENvOGx0SDBJUmsvVFhJQWt2dTUvSzJZRXNzaDUra2phekxjY2lkQ2tZ?=
 =?utf-8?B?ZGtiQ1NHR2RLWmJKVXRtS1lNTC9OMnBxMldUQkhhQmtXa3ZpMStobVBGT05L?=
 =?utf-8?B?Y1VYTVRjeXNUWU9INytKT2ZueUhBT2xWMS9KZjBRanhOYTJzNlluUjMwTnNW?=
 =?utf-8?B?Nks0QXlGREM4MVlGbGdTM3hGQXBwcWlhZWpnYmhBYnpFSXk2MzNxc1lOS2Q4?=
 =?utf-8?B?aG5nSWY2NStrRERqcmNwTmYyWERoOWExVmVKWWdCMTA3VVArcGV0MW50eXNq?=
 =?utf-8?B?eWpRU1lBZnpwckFSVmppTzVnUHN5RlRyUUpQZ3lid2F0aCsxeWVRVjBJS24z?=
 =?utf-8?B?b28wV2VSUDdlUzk5cGxSeitjSDljQnF2ZkF6TEtQbHRUOG5ZOHo0a3V5SGh0?=
 =?utf-8?B?VUo2a3lCaVFTTm53VldSVW9KdnNzdmVSdHpuNzliVWpGYUVKZkVhVkNvTGZP?=
 =?utf-8?B?eFNJRWgyMFNBbzVSc0hxdktHSytCbmNDc0p2MHlkN0VTQVMzWlAwbjA0TkIx?=
 =?utf-8?B?MWpGSy94eEh3Y0RBcTRGU2NTdmpIeXFkT2pva0FTa3I0UWtnb1hncmtlQS8v?=
 =?utf-8?B?R2lsQ3BNaTdubW1zRlhTVXo2cVRxU0IwNFpmeVJHREZFZWdPMjl2eTlRei90?=
 =?utf-8?B?alNNU1IrbWRiOWVpeWJOdEhCai9MeUROT09IaDRkalFTTzA1R2NNWE9aYWhv?=
 =?utf-8?B?ZEF0NUF6YTNUR0lTRGVtb0p3MXdDUjU4TmpOWnFiTHVESWMxalVBQ052ampq?=
 =?utf-8?B?cFFzZFVqVUZpRXhIUzNSWm9FRFh4eld6aWNUUDlWRzVYbXJTbWVrMjFhWGU1?=
 =?utf-8?B?MFJvNDRrUWlwQUIzUjBkSlhvUjBCWkxpZ01CR2t5WXl3dUI2VGY5WEZsNXJp?=
 =?utf-8?B?RTNZSUhrcEZSa0tEdUdBdTUxa3pwUWhSNk81cDNFVjNhWndtT1pHQW9JNDBh?=
 =?utf-8?B?QWYvSHQyYkphWEx6dWdlcmw2NGFRYXlrYTZrMDMzdGZyMW14aUloMW5hTThh?=
 =?utf-8?B?bHBXYVA0NEdheWNNWFZ2RzVjNE9CVlE4MnBGWnp0K0N2WGZybnp1UEQwWHcx?=
 =?utf-8?B?azcwR3VYam9lelpXdmxGb2hUU2NGY1htbDRmUVJwVW5ZNTJtMGZoUlUxMVFY?=
 =?utf-8?B?NkZhYVpUNGlJWENyQk5uYlMzdkFPUHBTNmRzcmVoQUFDSDlMQ0pEY2V5QTY4?=
 =?utf-8?B?bmc5SkhVWS83LzZMV3Q0L0Z0T25YNzJLQ2NmZVZzL3ZYTElQM2FyWGJGS0Yz?=
 =?utf-8?B?dG5YTjE2cUtnZDB5aFBxMUtUZm90WEx1ZExzM053dHFnczJmOTBzNFBmM0tE?=
 =?utf-8?B?d2poM0VSeGgrMklqUWRodmMycGJ4VFpOczBWdDg5U3l1aWlWN3lvVHlHUGdD?=
 =?utf-8?B?YjNwUnZxWDJhTjBVa1RtVXMvWFphWHpWQ1VQbzE1RUNUeUxNSnkvY3ZrL0hW?=
 =?utf-8?B?UlNxemlmbFhuNUVDaDlZcFBLMGdsMHhoeHdoZ05RblhkOEhEZEFKbEdJSXRM?=
 =?utf-8?B?bnFSK2RReVNHMjlacDRaaDYvOWl5NnRoRTRGaEFmMFNuNVFFU05ZUW1rN05p?=
 =?utf-8?B?RTQ4NncwdFkrWWFVcTVaMGZDdC96QW1vSGk1UGcrZlRlVG5ib3ZMNkdKeWlX?=
 =?utf-8?B?ZThiNk9rK0QxRTZIZjVFc1JyaEJ5K3RITEFvck4zWkgzTDIyL1B2clNoQXVh?=
 =?utf-8?B?S052b0czQjB3cUhMZTNEd2RzbmQ4QjlvNEIyYUtpWUFiN01IUDVxWWhOWTll?=
 =?utf-8?B?QUZsUStHdjBZZWNReDFUYUtadDNycEZNUStKTU9waVpidHFtK0JLc1FyM3N5?=
 =?utf-8?B?dGVoajU0aWt0WXl5QXVmVDhDUFFlQmRxRi96M0hYSGRqVE44dDZpN3cyZXRW?=
 =?utf-8?B?SkF2bWc0UzhiSVRHc1lkYVRYdVoxcjAxQzBTRmFhQUFpVVAvY2pNUnY5Y2Jk?=
 =?utf-8?B?YVMvSWJob0VaMVNDS00yMXZFd2xtOC8rUDBDQnR3UmZodGxCVjBHcTArNWFO?=
 =?utf-8?Q?xuZH1kdJGO3VP7/9SR6KqkQyK?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e83fad5-05e7-481b-4155-08db0e47aa02
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2023 04:55:16.4860 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Whh0ta6MlL+JnRredOFjT1SmoaDTFgAvIVdX9J/aUioP0B7v543jUeVn2QkiQhOM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6613
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



On 2/14/2023 7:56 AM, Zhou1, Tao wrote:
> 
> 
>> -----Original Message-----
>> From: Lazar, Lijo <Lijo.Lazar@amd.com>
>> Sent: Monday, February 13, 2023 8:38 PM
>> To: Zhou1, Tao <Tao.Zhou1@amd.com>; amd-gfx@lists.freedesktop.org; Zhang,
>> Hawking <Hawking.Zhang@amd.com>; Yang, Stanley
>> <Stanley.Yang@amd.com>; Chai, Thomas <YiPeng.Chai@amd.com>; Li, Candice
>> <Candice.Li@amd.com>
>> Subject: Re: [PATCH] drm/amdgpu: don't increase UMC RAS UE count if no new
>> bad page
>>
>>
>>
>> On 2/10/2023 2:15 PM, Tao Zhou wrote:
>>> If a UMC bad page is reserved but not freed by an application, the
>>> application may trigger uncorrectable error repeatly by accessing the page.
>>>
>>
>> There is amdgpu_ras_check_bad_page which checks if address is already part of
>> an existing bad page. Can't that be used?
>>
>> Thanks,
>> Lijo
> 
> [Tao] amdgpu_ras_check_bad_page is already called in amdgpu_ras_add_bad_pages, this patch just makes use of the result of amdgpu_ras_check_bad_page.
> 

In the patch, below two are called after error count is set to 0.
	amdgpu_ras_save_bad_pages
	amdgpu_dpm_send_hbm_bad_pages_num

Instead of that, just check if it's an existing badpage which is 
repeatedly accessed and proceed directly to the next step (reset if 
specified)

	if (amdgpu_ras_check_bad_page(adev, address))
		set error count to 0;
		goto reset_logic;

Thanks,
Lijo

>>
>>> Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
>>> ---
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 9 ++++++++-
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c | 6 +++++-
>>>    2 files changed, 13 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
>>> index e85c4689ce2c..eafe01a24349 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
>>> @@ -2049,7 +2049,7 @@ int amdgpu_ras_add_bad_pages(struct
>> amdgpu_device *adev,
>>>    {
>>>    	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
>>>    	struct ras_err_handler_data *data;
>>> -	int ret = 0;
>>> +	int ret = 0, old_cnt;
>>>    	uint32_t i;
>>>
>>>    	if (!con || !con->eh_data || !bps || pages <= 0) @@ -2060,6 +2060,8
>>> @@ int amdgpu_ras_add_bad_pages(struct amdgpu_device *adev,
>>>    	if (!data)
>>>    		goto out;
>>>
>>> +	old_cnt = data->count;
>>> +
>>>    	for (i = 0; i < pages; i++) {
>>>    		if (amdgpu_ras_check_bad_page_unlock(con,
>>>    			bps[i].retired_page << AMDGPU_GPU_PAGE_SHIFT))
>> @@ -2079,6
>>> +2081,11 @@ int amdgpu_ras_add_bad_pages(struct amdgpu_device *adev,
>>>    		data->count++;
>>>    		data->space_left--;
>>>    	}
>>> +
>>> +	/* all pages have been reserved before, no new bad page */
>>> +	if (old_cnt == data->count)
>>> +		ret = -EEXIST;
>>> +
>>>    out:
>>>    	mutex_unlock(&con->recovery_lock);
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
>>> index 1c7fcb4f2380..772c431e4065 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
>>> @@ -145,8 +145,12 @@ static int amdgpu_umc_do_page_retirement(struct
>>> amdgpu_device *adev,
>>>
>>>    		if ((amdgpu_bad_page_threshold != 0) &&
>>>    			err_data->err_addr_cnt) {
>>> -			amdgpu_ras_add_bad_pages(adev, err_data->err_addr,
>>> +			ret = amdgpu_ras_add_bad_pages(adev, err_data-
>>> err_addr,
>>>    						err_data->err_addr_cnt);
>>> +			/* if no new bad page is found, no need to increase ue
>> count */
>>> +			if (ret == -EEXIST)
>>> +				err_data->ue_count = 0;
>>> +
>>>    			amdgpu_ras_save_bad_pages(adev);
>>>
>>>    			amdgpu_dpm_send_hbm_bad_pages_num(adev,
>>> con->eeprom_control.ras_num_recs);
