Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C426C9830B
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Sep 2026 15:08:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EB9A910E149;
	Wed, 23 Sep 2026 15:08:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zo4ymXua";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010016.outbound.protection.outlook.com [52.101.201.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A5FBB10E0CB
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Sep 2026 15:08:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wypUyt4GVUYD1edJCPAlOJnvkX89aogYbE5q4fNaJU59Zt2Vs/+B6yTz0OypP2oG2/UDc6JXA2OZy3Z/yHFG8dybriXpoaXMzHbhMOa1NLjbkzer7TgOTGmGb/pvodt8I+aCXlP/Cz3Nvs7hxEUHJaNAuFeAvZTeDtnTBxmQMHJ/A0cVE980KaIQVSWoNrWRzEQlO4xlTCvaNnUydxcAWgQ3mh2cEcJRFaMu7+Rn3zmWarz+n0KPIa95BIcuxLFizKTbG2ud39tSmDMUBZZuddQclTyAtUs7uG9T0w4PuIv1lhFXr7lMaRooGbS37gYpfFDZy9X/jnNsaDxo6XxbPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vVM+9t4WoZ6pqCOlll84m48J1qkqXcSKkPfHHc4yXHc=;
 b=Qg7I0/Fg0raBhBnwZbSCn+rWS0hPlhnNELvkOdocb5w3gmhtjZvnXq+9ZNpHDA6RTNgHlWxW0xD7ws5aucj81Wblp+e/wXuAM5rX5RpLwvOcmqH7ffWi/o68A3QNKenrKxp5Yz0+E8pT1NS8hncmYylXohDV0t1j2bq0rYi9tanmSagr7vwm86t9cumgTe7fU5aQ/txNgom3ziv9tRmen/WpqW3av5OpT9+IoC30yGJcKSLfuTWrR+EWhRmmGZb1xufjx0gb0Wjrn53bLzssdNTEJxhf0J1tmMxr8G5P0eNyiUKdF/yj23wgxT2gBhOhTr+FDlJmYFej/uh8tGd+UA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vVM+9t4WoZ6pqCOlll84m48J1qkqXcSKkPfHHc4yXHc=;
 b=zo4ymXua0j5cZw1d0AwiMhWl3AuKWkG/kDKKrO/+VInklqJmchiwvsy3p6nXuQXipeFodNvCVhcAbpGH078WAT2/fa2YIHRMvBcNyZW+tLFfvhSRZ+NF9jDcxpeaMYG3SCmhza06wayQa7K9MgtXU3063Wl66xMEQx0tPHQg4oE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB8558.namprd12.prod.outlook.com (2603:10b6:8:187::22)
 by DS6PR12MB764263.namprd12.prod.outlook.com (2603:10b6:8:499::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.16; Wed, 23 Sep
 2026 15:08:36 +0000
Received: from DM4PR12MB8558.namprd12.prod.outlook.com
 ([fe80::1b2b:b6fc:16eb:2422]) by DM4PR12MB8558.namprd12.prod.outlook.com
 ([fe80::1b2b:b6fc:16eb:2422%3]) with mapi id 15.21.0451.014; Wed, 23 Sep 2026
 15:08:36 +0000
Message-ID: <a1f17682-ef2a-4665-9a78-95333679372c@amd.com>
Date: Wed, 23 Sep 2026 11:08:34 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/12] drm/amdgpu: add amdgpu_xcp_get_xcc_mask helper
To: "Lazar, Lijo" <lijo.lazar@amd.com>, James Zhu <James.Zhu@amd.com>,
 amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com, Bing.Ma@amd.com
References: <20260921200313.865829-1-James.Zhu@amd.com>
 <20260921200313.865829-4-James.Zhu@amd.com>
 <8f06398f-e207-45b0-ab85-931ccac35b65@amd.com>
 <ce3dbd30-31e6-4680-8618-2144fe44a928@amd.com>
 <0e573608-7f9e-4f3e-ac58-cf375962ae2b@amd.com>
 <c9cd0934-25ca-4d14-99c1-cc7aa3d566c8@amd.com>
 <8fc9ee70-d284-4ef3-9e66-08d809fac293@amd.com>
 <526f559b-cb01-425d-9ae6-831d8bd2c229@amd.com>
 <7633a664-dfeb-4796-8b84-c5f2bc5df0d5@amd.com>
 <8a01cbe9-edad-4bf6-8519-569375fd93bf@amd.com>
 <7e3e84e5-7203-4871-b5be-a99d16071afd@amd.com>
Content-Language: en-US
From: James Zhu <jamesz@amd.com>
Organization: AMD RTG
In-Reply-To: <7e3e84e5-7203-4871-b5be-a99d16071afd@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQZPR01CA0131.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:87::19) To DM4PR12MB8558.namprd12.prod.outlook.com
 (2603:10b6:8:187::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB8558:EE_|DS6PR12MB764263:EE_
X-MS-Office365-Filtering-Correlation-Id: e3087507-5bc5-43e6-4ee9-08df19848a7d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|23010399003|3023799007|10067099003|4143699003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: aCAc2Z2OhfYh1LIAnASzBlApxuxNFInEWrZV67Po3ZOcZsW96F234xv6OzR22bSu2n+I5fix4KEr31+vCAMQONa3Vkd5t/uYwLSKmlQTG6UD4qBoPFwcpzfd/sBbpPiD+9Rp7eqskYtjikYqVx2ZA+8brzzwKRPr9cQLgSQxlRyRRTf/gAa9E6vxYlNF4VjKrLGopYQI5t+rJw6+0ilcWnqy6PyKDRCPoUzzPXXkOg5nhzPlrBewez3gTeWRlfdE9Hb7Qz8Q1P7IlgYoYRxzJbEqdyyI3sfYjpMQ5g0c2AdPhf8kK02NQv3u4p+7KzhYuH/3zZ+zOb9DgZyX7QfZ0C92I621oREreZ3OsfinUt9CK9Di0H7vqCe6Hs5aEanzzXr2SGCy/LR9ujW/UnScEIDBeJA4mzItAiA8DTBTwpCDSj0EyL80qlYbbqJv2w9VNXYpzcYpXjtTzu0o9LPH2qTCODvxq09y3oMNsCML8Ia1MzF0qS+oxMM0elBgNJc5ycHUMyCEg4chVHcfoiUqQOzQwYYSWkNo5EOdjFCTgqaRyXOoWFsPB5tUctgxMI5zl4xO/P+HwaoIY0wOx0TZVFEwISiUMcbpwNZ2/gqJOZi8klkGAy6fYvjqrh7Dza1K7a6om+iOL/7yu2V89DbcqU/IH6Zo9jjngWOKmxfnWS0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB8558.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(3023799007)(10067099003)(4143699003)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RzBXcW9sZk9DR3dCeEVBVGJMYmJiMUpidVlEQTRyNzI3a21mNEpnL1RmVHhJ?=
 =?utf-8?B?aDREdC9HRHBTYStVOWtzTHBEbWl3ekNWbnhybVBOalkybDl1Y05UN3J5dmlr?=
 =?utf-8?B?VFYrcXg3RDJOZmJhR0xVdmh4V2o4S1g5Y2Z1Z1FaYkhBYmdGNk9IZHZqVnpi?=
 =?utf-8?B?NjlEYjBCRE9CM0hmejBDdkdhcVJGTGI2Smx1dW9rNXAyNVlxaVA1dHFka3J0?=
 =?utf-8?B?Q3BGNzNUNHNtNUp0Zk1rQmF6YVZhTlFJdndDMHBhOW1SMXA3S2liTHNvb2ta?=
 =?utf-8?B?Uk9HS1p4VHV6ZHY0ZWovNlZOWUNiOHduaHNIR3RvU3U1eVhya1BmbjFYdENG?=
 =?utf-8?B?dlc4bDUwYStPRnFjU1NPcG54UW9DYWw0dGQybm5KR2VuNDh4L1ZCVVpPTkhs?=
 =?utf-8?B?N3hJSU9MWVpZV3FHdnhoWTgzL3dXZlJocVdPVkFrYmxEeU84YTlvVmd1cS84?=
 =?utf-8?B?bGVWZWNYM3ZpNEd1bTNjSUZrckp0VGpGQ29ZYUI3MFFsZUJGaGE5Vk1PT2t1?=
 =?utf-8?B?cGluWWxaTFFXTWc3RURQQm1XM1p0UUFNUjBvWnFuS2VLZE1wWldTMGJNb3BM?=
 =?utf-8?B?WEdRYTY3NVVOb2NwRGFYclNISW5XV0ozTmZXOVJ1MXpQZ1pxOEpSR0NHRVlL?=
 =?utf-8?B?dFpNMHBuMEZUbGIvNUxKaWdoK2dsN3RSUDhpMWJUNXhxYjNMZlFJNzRkNDFz?=
 =?utf-8?B?ZzdaZm85MDRVdFl4RWdCRlpBSTkzdk1DVUpBNzAyK3U2UDExOEZjaklXNlRz?=
 =?utf-8?B?SWRRZWlSSHNhejV6SlkvVklWRDIzc2FOemsyaXJDV2tmaklaZCtTYlJlQnBF?=
 =?utf-8?B?Wkl0NDloVjJseCtCcGpyUWtFRnVsejdZK3ladnVINVMwVk14eUdKUjUvYmpv?=
 =?utf-8?B?WjlCdjA4TUE5bzVXSkVLM3lWOS8rZkNzVXhERkNJSmNla2JhV051WWZET1Fk?=
 =?utf-8?B?V2k0ZlFxYTBicS90QkFlTVRkSUlPdVNyeDA5cGFyaDJwUTJlbXhkaG1JdEhn?=
 =?utf-8?B?NStFSkNKa2hGV0JUYjRMamZFaWJDcVQvYmNEVWNxeDU5bmFxdWxkUzV5TUlr?=
 =?utf-8?B?RVoxOC9VdEEyWE95cjNyWGdOYjFjR1drdjNSUVVSK0RpNk9lOWNmZ2o5Y0ts?=
 =?utf-8?B?VjMyWUh4RjFyY09USEhXUDVud1BpU1U2bHA3dDhON2xKbUpXQU9Dcnp0UDdr?=
 =?utf-8?B?TlhaS2FTaU1PQVBsb1VnamY2SG56TWExMkh6cDB1UGdYWVppc2ZxQy9IV3Ey?=
 =?utf-8?B?bFZUaHJiZjhBRFU5NlU5clViYXNEa3B0TUxrbWt5QnVTMVk3MXRXdnByQ0Q4?=
 =?utf-8?B?bDczd3Y3Uk1YRWttV1dCc3l5QTNoOGhKUkxqRER0bHA2aVVpbTd5bW1WZEdh?=
 =?utf-8?B?QzRBWU1qSlFueVV5ai85Vk9SNU9qNkJJbFdjYVhJU0tNdkJtc0tZWDZDUWpa?=
 =?utf-8?B?TXh6NWNkd2ZScEFySVliRTdxZit0bWg2cVJyeVpYaWxNZTVkTE1xaGNyZzJJ?=
 =?utf-8?B?d05vSGcrbkdYenVDU0s1anFqQ3Vpb1pXdWwxbkpPMjJHTUg1QzlTSXdhRVVL?=
 =?utf-8?B?UWtXQUgvdjhudDZtL2g2L3hHci9IbVFSTVlqRmpUQVQ4Y0lSd2U3RzNmQ0lx?=
 =?utf-8?B?WitWSy9CUVBqaURGN0ZOVGlITEo3WU5VN3cyV25EKzFTRlF2WkNQN1N1UTlh?=
 =?utf-8?B?WTliMDZXREZLZWFJV05UZHdKMm5BWVhWbGFZYWQ4eml1WFlhbzJ0ZGVjWi9Q?=
 =?utf-8?B?UDQ2TElrTlpFU0lwQVFaLzBkSzZBUDNyczk5aitRdzcxcXlDYlAvSWlNMGNG?=
 =?utf-8?B?VzJtcU5IZ0ROc2x3TVVPNUpzUFNuSERCM2E0Q0pRUEZSS295Skd1QUUvdXRG?=
 =?utf-8?B?azlMNTJEU1pCdnY5UG0zRlM5Wnl6VFlKMUUyWXRGbzV0bGFoR0VMOHU5MjVw?=
 =?utf-8?B?d1h1VTVpdmFZZzBIZG5jQ24vRUltSnAwcUVsZUllclJLbG5GTlBVaHZrSFVT?=
 =?utf-8?B?TUtSWWFWOXRLMVF3cVFDaXVxQ3ZOVmxxaUVxU2VycnplOHlXdFVJMFZYVERI?=
 =?utf-8?B?a0ZaajRXSnhYelY0amlEd2kveHFHUExWdWhZR2l1U2o5SVNsMllCV2E0MkQ0?=
 =?utf-8?B?UERTK0twc3hCeWp0Ym9ZQ0ZQSGg3NzNON3NmRVFqNkRSRklDcFlLRHhUS29B?=
 =?utf-8?B?UGFsaHlNVkNrVmd0WGVrU28xMXJnR21zTjB6Yk02cWx3NE1aRnpFKzNhMlY2?=
 =?utf-8?B?UFJzVUpzQm9XOTloMEMxckI4Y3Rpd0lCNmRmcjNsOTBNRkNMY1o4YU90T1ZQ?=
 =?utf-8?Q?0fWxfvXVl9Hr9yZ15K?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3087507-5bc5-43e6-4ee9-08df19848a7d
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB8558.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 15:08:36.2267 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uHZWoZmZggaF2LhmnSh2DWYTb/iueY1yjHQoEjcSZXPETqr7HOQJbbecb73NSSOO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS6PR12MB764263
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


On 2026-09-23 10:55, Lazar, Lijo wrote:
>
>
> On 23-Sep-26 6:06 PM, James Zhu wrote:
>>
>> On 2026-09-22 23:39, Lazar, Lijo wrote:
>>>
>>>
>>> On 22-Sep-26 8:40 PM, James Zhu wrote:
>>>>
>>>> On 2026-09-22 10:26, Lazar, Lijo wrote:
>>>>>
>>>>>
>>>>> On 22-Sep-26 7:41 PM, James Zhu wrote:
>>>>>>
>>>>>> On 2026-09-22 09:45, Lazar, Lijo wrote:
>>>>>>>
>>>>>>>
>>>>>>> On 22-Sep-26 7:05 PM, James Zhu wrote:
>>>>>>>>
>>>>>>>> On 2026-09-22 01:22, Lazar, Lijo wrote:
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> On 22-Sep-26 1:33 AM, James Zhu wrote:
>>>>>>>>>> Add amdgpu_xcp_get_xcc_mask() to return the XCC instance mask 
>>>>>>>>>> for a given
>>>>>>>>>> XCP partition. This is needed by upcoming SPM (Stream 
>>>>>>>>>> Performance Monitor)
>>>>>>>>>> support, which programs hardware per partition and must 
>>>>>>>>>> operate only on
>>>>>>>>>> the XCCs that belong to a given XCP.
>>>>>>>>>>
>>>>>>>>>> For partitioned systems the helper returns only the XCCs 
>>>>>>>>>> belonging to the
>>>>>>>>>> specified XCP. When @xcp_id is AMDGPU_XCP_NO_PARTITION (or 
>>>>>>>>>> the device is
>>>>>>>>>> not partitioned) it returns the device's full XCC mask (e.g. 
>>>>>>>>>> 0xFF for an
>>>>>>>>>> 8-XCC device). Note that the full device mask is returned 
>>>>>>>>>> even on a
>>>>>>>>>> partitioned device; callers that require partition isolation 
>>>>>>>>>> (e.g. SPM)
>>>>>>>>>> must reject AMDGPU_XCP_NO_PARTITION on a partitioned device 
>>>>>>>>>> themselves.
>>>>>>>>>>
>>>>>>>>>
>>>>>>>>> Could you clarifiy on this part - xcp_id = 
>>>>>>>>> AMDGPU_XCP_NO_PARTITION usage on 8-XCC device?
>>>>>>>>>
>>>>>>>>> The default state on a multi-XCC device after driver load is 
>>>>>>>>> all XCCs in a single partition called SPX. It should have at 
>>>>>>>>> least one partition valid.
>>>>>>>>
>>>>>>>> [JZ] Yes, 8-XCC device should not reach AMDGPU_XCP_NO_PARTITION 
>>>>>>>> case.
>>>>>>>>
>>>>>>>> the if(!xcp_mgr ||xcp_id ==AMDGPU_XCP_NO_PARTITION) mainly 
>>>>>>>> covers non partition device, I can remove the above comments 
>>>>>>>> which don't reflect the source accurately.
>>>>>>>
>>>>>>> Then I'm not sure what issue this is fixing.
>>>>>>>
>>>>>>> Multi-xcc devices will be in SPX mode and will return a mask 
>>>>>>> with all the XCCs. Non-multi xcc devices are expected to have 
>>>>>>> this set to 1 anyway to reflect that a single GC is present always.
>>>>>> [JZ] Just realized a Fixes tag is added. I think somehow AI 
>>>>>> review added it, and I did not check properly, is should be 
>>>>>> removed also. Sorry for this confusing!
>>>>>
>>>>> I see that it also added an external function like this -
>>>>>
>>>>> amdgpu_xcp_get_xcc_mask
>>>>>
>>>>> The expectation is any IP instance mask within a partition needs 
>>>>> to obtained through - amdgpu_xcp_get_inst_details
>>>>>
>>>>> Also, amdgpu_xcp_get_xcc_mask provides this which is not correct -
>>>>>
>>>>> *xcc_mask = adev->gfx.xcc_mask
>>>>>
>>>>> xcp instance mask operates only return logical mask of instances 
>>>>> present (xcc_mask could include disabled ones also).
>>>> [JZ] Here is only for non-partition device. I think adev- 
>>>> >gfx.xcc_mask=0x1.
>>>> I can change it to below code to clear the confusing
>>>>
>>>> *xcc_mask = BIT(0);
>>>>
>>>> How Do you think?
>>>> Thanks!
>>>>
>>>
>>> Once that is done, it's the same as what exists now (without the 
>>> extra function).
>>>
>>> Also, why do you need get_xcc_mask function? If the difficulty is in 
>>> getting amdgpu_xcp* pointer from xcp_id, then a wrapper could be 
>>> added and used like
>>>
>>> xcp = amdgpu_xcp_get_obj(adev, xcp_id);
>>> amdgpu_xcp_get_inst_details(xcp, AMDGPU_XCP_GFX, &xcc_mask);
>> [JZ] Basically, amdgpu_xcp_get_xcc_mask is the above two's combination.
>
> Ok, then suggest to use the two-step route instead of adding specific 
> wrapper per IP.
>
> Adding the first one (get xcp from xcp_id) could be helpful for other 
> scenarios also.
[JZ] yeah, but this is just for discussion. We will drop these SPM 
implementation.
>
> Thanks,
> Lijo
>
>>>
>>> Thanks,
>>> Lijo
>>>
>>>> James
>>>>
>>>>>
>>>>> Thanks,
>>>>> Lijo
>>>>>
>>>>>>>
>>>>>>> Thanks,
>>>>>>> Lijo
>>>>>>>
>>>>>>>>> Thanks,
>>>>>>>>> Lioj
>>>>>>>>>
>>>>>>>>>> amdgpu_xcp_get_num_xcc() is reworked to take (adev, xcp_id) 
>>>>>>>>>> and derive the
>>>>>>>>>> count from this helper via hweight32(). The helper is defined 
>>>>>>>>>> out of line
>>>>>>>>>> in amdgpu_xcp.c so that the static inline in amdgpu_xcp.h 
>>>>>>>>>> never has to
>>>>>>>>>> dereference the (incomplete) struct amdgpu_device; it only 
>>>>>>>>>> passes the
>>>>>>>>>> pointer through.
>>>>>>>>>>
>>>>>>>>>> This is a user-visible change: amdgpu_xcp_get_num_xcc() 
>>>>>>>>>> previously
>>>>>>>>>> returned 1 for non-partitioned systems (and for 
>>>>>>>>>> AMDGPU_XCP_NO_PARTITION),
>>>>>>>>>> and now returns the actual XCC count (e.g. 8 for an 8-XCC 
>>>>>>>>>> device). CWSR
>>>>>>>>>> callers (amdgpu_kms.c, amdgpu_userq.c, mes_userqueue.c) scale 
>>>>>>>>>> the per-XCC
>>>>>>>>>> control-stack and debug-memory sizes by num_xcc, so the uAPI- 
>>>>>>>>>> visible
>>>>>>>>>> ctl_stack_size and dbg_mem_size values grow accordingly to 
>>>>>>>>>> match the
>>>>>>>>>> actual hardware resource requirements, which were previously 
>>>>>>>>>> undersized.
>>>>>>>>>>
>>>>>>>>>> Fixes: 4cd417bfec49 ("drm/amdgpu: Add helper function to get 
>>>>>>>>>> xcc count")
>>>>>>>>>> Signed-off-by: James Zhu <James.Zhu@amd.com>
>>>>>>>>>> Reviewed-by: Bing Ma <bing.ma@amd.com>
>>>>>>>>>> ---
>>>>>>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c    | 2 +-
>>>>>>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c  | 2 +-
>>>>>>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c    | 48 
>>>>>>>>>> +++++++++++++ ++ ++ +++++
>>>>>>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h    | 32 
>>>>>>>>>> +++++++--------
>>>>>>>>>>   drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 3 +-
>>>>>>>>>>   5 files changed, 66 insertions(+), 21 deletions(-)
>>>>>>>>>>
>>>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c 
>>>>>>>>>> b/drivers/ gpu/ drm/amd/amdgpu/amdgpu_kms.c
>>>>>>>>>> index 57fa69c0382d..7782ccd4d28f 100644
>>>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>>>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>>>>>>>>>> @@ -1501,7 +1501,7 @@ int amdgpu_info_ioctl(struct drm_device 
>>>>>>>>>> *dev, void *data, struct drm_file *filp)
>>>>>>>>>>           fpriv = (struct amdgpu_fpriv *)filp->driver_priv;
>>>>>>>>>>           if (!amdgpu_trap_is_enabled(adev) || !fpriv->trap_obj)
>>>>>>>>>>               return -EOPNOTSUPP;
>>>>>>>>>> -        num_xcc = amdgpu_xcp_get_num_xcc(adev->xcp_mgr, 
>>>>>>>>>> fpriv- >xcp_id);
>>>>>>>>>> +        num_xcc = amdgpu_xcp_get_num_xcc(adev, fpriv->xcp_id);
>>>>>>>>>>           cwsr_info.ctl_stack_size =
>>>>>>>>>> adev->trap_info->cwsr.xcc_ctl_stack_sz * num_xcc;
>>>>>>>>>>           cwsr_info.dbg_mem_size =
>>>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/ 
>>>>>>>>>> drivers/ gpu/ drm/amd/amdgpu/amdgpu_userq.c
>>>>>>>>>> index db09e879b85e..d19af9cb6ee1 100644
>>>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>>>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>>>>>>>>>> @@ -258,7 +258,7 @@ int 
>>>>>>>>>> amdgpu_userq_input_trap_params_validate(struct 
>>>>>>>>>> amdgpu_usermode_queue *queue,
>>>>>>>>>>       int num_xcc;
>>>>>>>>>>       int r;
>>>>>>>>>>   -    num_xcc = amdgpu_xcp_get_num_xcc(adev->xcp_mgr, fpriv- 
>>>>>>>>>> >xcp_id);
>>>>>>>>>> +    num_xcc = amdgpu_xcp_get_num_xcc(adev, fpriv->xcp_id);
>>>>>>>>>>       r = amdgpu_trap_validate_params(queue->userq_mgr->adev, 
>>>>>>>>>> trap_params,
>>>>>>>>>>                       num_xcc);
>>>>>>>>>>       if (r)
>>>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c 
>>>>>>>>>> b/drivers/ gpu/ drm/amd/amdgpu/amdgpu_xcp.c
>>>>>>>>>> index 2a56f5ec9c76..90846d55292b 100644
>>>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
>>>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
>>>>>>>>>> @@ -390,6 +390,54 @@ int amdgpu_xcp_get_inst_details(struct 
>>>>>>>>>> amdgpu_xcp *xcp,
>>>>>>>>>>       return 0;
>>>>>>>>>>   }
>>>>>>>>>>   +/**
>>>>>>>>>> + * amdgpu_xcp_get_xcc_mask - Get XCC instance mask for a 
>>>>>>>>>> partition
>>>>>>>>>> + * @adev: amdgpu device pointer
>>>>>>>>>> + * @xcp_id: XCP partition ID
>>>>>>>>>> + * @xcc_mask: output parameter for XCC instance mask
>>>>>>>>>> + *
>>>>>>>>>> + * Returns the XCC instance mask for the specified XCP 
>>>>>>>>>> partition.
>>>>>>>>>> + * For partitioned systems, returns only the XCCs belonging 
>>>>>>>>>> to this XCP.
>>>>>>>>>> + *
>>>>>>>>>> + * When @xcp_id is AMDGPU_XCP_NO_PARTITION (or the device is 
>>>>>>>>>> not
>>>>>>>>>> + * partitioned), the device's full XCC mask is returned 
>>>>>>>>>> (e.g. 0xFF for an
>>>>>>>>>> + * 8-XCC device). Note that the full device mask is returned 
>>>>>>>>>> even on a
>>>>>>>>>> + * partitioned device: callers that require partition 
>>>>>>>>>> isolation (e.g. SPM)
>>>>>>>>>> + * must reject AMDGPU_XCP_NO_PARTITION on a partitioned 
>>>>>>>>>> device themselves.
>>>>>>>>>> + *
>>>>>>>>>> + * Note: On error, xcc_mask is undefined. Callers must check 
>>>>>>>>>> return code
>>>>>>>>>> + * and only read xcc_mask when return == 0.
>>>>>>>>>> + *
>>>>>>>>>> + * Return: 0 on success (non-partitioned systems or valid 
>>>>>>>>>> XCP found),
>>>>>>>>>> + *         -EINVAL if xcc_mask is NULL, no matching XCP id 
>>>>>>>>>> is found, or the
>>>>>>>>>> + *         partition's GFX IP details are unavailable
>>>>>>>>>> + */
>>>>>>>>>> +int amdgpu_xcp_get_xcc_mask(struct amdgpu_device *adev, int 
>>>>>>>>>> xcp_id,
>>>>>>>>>> +                uint32_t *xcc_mask)
>>>>>>>>>> +{
>>>>>>>>>> +    struct amdgpu_xcp_mgr *xcp_mgr = adev->xcp_mgr;
>>>>>>>>>> +    struct amdgpu_xcp *xcp;
>>>>>>>>>> +    int i;
>>>>>>>>>> +
>>>>>>>>>> +    if (!xcc_mask)
>>>>>>>>>> +        return -EINVAL;
>>>>>>>>>> +
>>>>>>>>>> +    if (!xcp_mgr || xcp_id == AMDGPU_XCP_NO_PARTITION) {
>>>>>>>>>> +        /* Non-partitioned: return the device's full XCC 
>>>>>>>>>> mask. */
>>>>>>>>>> +        *xcc_mask = adev->gfx.xcc_mask;
>>>>>>>>>> +        return 0;
>>>>>>>>>> +    }
>>>>>>>>>> +
>>>>>>>>>> +    /* Partitioned system: get this XCP's XCCs */
>>>>>>>>>> +    for_each_xcp(xcp_mgr, xcp, i) {
>>>>>>>>>> +        if (xcp->id == xcp_id)
>>>>>>>>>> +            return amdgpu_xcp_get_inst_details(xcp, 
>>>>>>>>>> AMDGPU_XCP_GFX,
>>>>>>>>>> +                               xcc_mask);
>>>>>>>>>> +    }
>>>>>>>>>> +
>>>>>>>>>> +    return -EINVAL;
>>>>>>>>>> +}
>>>>>>>>>> +
>>>>>>>>>>   int amdgpu_xcp_dev_register(struct amdgpu_device *adev,
>>>>>>>>>>               const struct pci_device_id *ent)
>>>>>>>>>>   {
>>>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h 
>>>>>>>>>> b/drivers/ gpu/ drm/amd/amdgpu/amdgpu_xcp.h
>>>>>>>>>> index 692508be23fb..6eed82ad49b1 100644
>>>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h
>>>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h
>>>>>>>>>> @@ -44,6 +44,7 @@
>>>>>>>>>>   #define XCP_INST_MASK(num_inst, xcp_id) \
>>>>>>>>>>       (num_inst ? GENMASK(num_inst - 1, 0) << (xcp_id * 
>>>>>>>>>> num_inst) : 0)
>>>>>>>>>>   +struct amdgpu_device;
>>>>>>>>>>   struct amdgpu_fpriv;
>>>>>>>>>>     enum AMDGPU_XCP_IP_BLOCK {
>>>>>>>>>> @@ -219,26 +220,23 @@ amdgpu_get_next_xcp(struct 
>>>>>>>>>> amdgpu_xcp_mgr *xcp_mgr, int *from)
>>>>>>>>>>       for (i = 0, xcp = amdgpu_get_next_xcp(xcp_mgr, &i); xcp; \
>>>>>>>>>>            ++i, xcp = amdgpu_get_next_xcp(xcp_mgr, &i))
>>>>>>>>>>   -static inline int amdgpu_xcp_get_num_xcc(struct 
>>>>>>>>>> amdgpu_xcp_mgr *xcp_mgr,
>>>>>>>>>> -                     int xcp_id)
>>>>>>>>>> +int amdgpu_xcp_get_xcc_mask(struct amdgpu_device *adev, int 
>>>>>>>>>> xcp_id,
>>>>>>>>>> +                uint32_t *xcc_mask);
>>>>>>>>>> +
>>>>>>>>>> +static inline int amdgpu_xcp_get_num_xcc(struct 
>>>>>>>>>> amdgpu_device *adev, int xcp_id)
>>>>>>>>>>   {
>>>>>>>>>> -    struct amdgpu_xcp *xcp;
>>>>>>>>>>       uint32_t xcc_mask;
>>>>>>>>>> -    int i, r;
>>>>>>>>>> -
>>>>>>>>>> -    if (!xcp_mgr || xcp_id == AMDGPU_XCP_NO_PARTITION)
>>>>>>>>>> +    int r, count;
>>>>>>>>>> +
>>>>>>>>>> +    /* Derive the XCC count from the partition's XCC mask 
>>>>>>>>>> (or the full
>>>>>>>>>> +     * device mask when not partitioned). 
>>>>>>>>>> amdgpu_xcp_get_xcc_mask()
>>>>>>>>>> +     * handles both partitioned and non-partitioned cases.
>>>>>>>>>> +     */
>>>>>>>>>> +    r = amdgpu_xcp_get_xcc_mask(adev, xcp_id, &xcc_mask);
>>>>>>>>>> +    if (unlikely(r))
>>>>>>>>>>           return 1;
>>>>>>>>>> -    for_each_xcp(xcp_mgr, xcp, i) {
>>>>>>>>>> -        if (xcp->id == xcp_id) {
>>>>>>>>>> -            r = amdgpu_xcp_get_inst_details(xcp, 
>>>>>>>>>> AMDGPU_XCP_GFX,
>>>>>>>>>> -                            &xcc_mask);
>>>>>>>>>> -            if (unlikely(r))
>>>>>>>>>> -                return 1;
>>>>>>>>>> -            else
>>>>>>>>>> -                return hweight32(xcc_mask);
>>>>>>>>>> -        }
>>>>>>>>>> -    }
>>>>>>>>>>   -    return 1;
>>>>>>>>>> +    count = hweight32(xcc_mask);
>>>>>>>>>> +    return count ? count : 1;
>>>>>>>>>>   }
>>>>>>>>>>   #endif
>>>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/ 
>>>>>>>>>> drivers/ gpu/drm/amd/amdgpu/mes_userqueue.c
>>>>>>>>>> index 16aa22b25098..1c7b2f3227e5 100644
>>>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
>>>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
>>>>>>>>>> @@ -503,8 +503,7 @@ static int mes_userq_mqd_create(struct 
>>>>>>>>>> amdgpu_usermode_queue *queue,
>>>>>>>>>> uq_mgr_to_fpriv(queue->userq_mgr);
>>>>>>>>>>               int num_xcc;
>>>>>>>>>>   -            num_xcc = amdgpu_xcp_get_num_xcc(adev->xcp_mgr,
>>>>>>>>>> -                             fpriv->xcp_id);
>>>>>>>>>> +            num_xcc = amdgpu_xcp_get_num_xcc(adev, fpriv- 
>>>>>>>>>> >xcp_id);
>>>>>>>>>>               trap_params.ctx_save_area_address =
>>>>>>>>>> compute_mqd->ctx_save_area_va;
>>>>>>>>>>               trap_params.cwsr_sz = compute_mqd- 
>>>>>>>>>> >ctx_save_area_size;
>>>>>>>>>
>>>>>>>
>>>>>
>>>
>
