Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 000A0CE8D6B
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Nov 2025 15:06:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9304A89266;
	Mon, 17 Nov 2025 15:06:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="F0MSpfq8";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012018.outbound.protection.outlook.com [40.107.209.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 675C989266
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Nov 2025 15:06:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=COx3pGbp8KuQXE8p+wOnv77200ReSONJW/8W8CwvqWh2Ag7e+7UQwzOB6otw1X4c71+3f7CUD1dNMSX+S99iaKEoyHnAaIqGWWFX2mJmpvAHexctgCwXGTsJritTnyOOg0GSQ4DCd7XLig0WaDWl27In7CmO5T/eq3o4NJxvZCFHsTRGI6rIKMAWhuaUprMyZTyuq7sTECJKs27sOXtpdw4IDRxYaIaFXctEbgeUjsMqvI0PS2VGWmknJuaVWkM2sFehDwkkeWPvEiuUCtq5HES3w1XYAhvow3UX7IKXChgGvkdWUkORwi5HMTTRAIsQMpNHOpIUzhygQL6eUYYgqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5Xiau3r6QrCtDOwNfOu0hgvd1Z/6Ls7FANW0dkodquc=;
 b=dPIhRGLUjvQa2393FuveWcZhFm6/ig5BvI8m5UCQJfBLcVqc0euigHc0jFCeXFnZolV/q+vTpc9B9YazlsKKcf+lOQaDaeZoggxYeAwggelivAee3RqEnac+dkgzZBds4P+yyJtZeeOa9u7Smj76A467NiEKz9J4RYWnkCHq09OHOS2GDJCS+NViacf54rV4SOt5OvSz0NidSr5eusEGWbJBe6hDAqFOkHqXu/s2bijDbMRgIxMFVe/riGv1lEjksjGcQo++dsA9pIi6vpijKy6thWnrvi1QvDMJwZzbOJgCVZDoXB03TwyY1d/wCGQLx1rZgURczhLWjB9S1oS6yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Xiau3r6QrCtDOwNfOu0hgvd1Z/6Ls7FANW0dkodquc=;
 b=F0MSpfq87ahZtUfh4V3MHvFvUnIvONysDAG55Mu3ud2r4nowfoRNUkQPKBaEq6dFd58+tz4PVV6hQP0Mq8xdEvHNbw28x1BLdId5EFlguJl+6MbslPbD0Gp4jLWYn3qXttDZq7CiGNYaDQG4m/z3pLWQ8x/xjKlk+cbxT9AyIxQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by CY8PR12MB8216.namprd12.prod.outlook.com (2603:10b6:930:78::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.18; Mon, 17 Nov
 2025 15:06:02 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81%6]) with mapi id 15.20.9320.021; Mon, 17 Nov 2025
 15:06:01 +0000
Message-ID: <e1b5e4f3-d2b4-4c96-820d-56144b5a7934@amd.com>
Date: Mon, 17 Nov 2025 10:06:00 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdkfd: Use huge page size to check split svm
 range alignment
To: Philip Yang <yangp@amd.com>, "Xiaogang.Chen" <xiaogang.chen@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20251113210955.352373-1-xiaogang.chen@amd.com>
 <c87b788f-65a6-468d-b100-2295eb284489@amd.com>
 <1421dbc3-c800-330a-2b30-3a359b9ef9af@amd.com>
Content-Language: en-US
From: "Kuehling, Felix" <felix.kuehling@amd.com>
In-Reply-To: <1421dbc3-c800-330a-2b30-3a359b9ef9af@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQZPR01CA0083.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:84::24) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|CY8PR12MB8216:EE_
X-MS-Office365-Filtering-Correlation-Id: a1130379-31c3-4add-c54b-08de25ead285
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MkZHbnJWOWR6TWJhREpmcVQ5TWEzUDhiZE9mWFAwWDFyZWtrUWo5MmNQbGZy?=
 =?utf-8?B?V0I5ZW9QNnp6aUNOWlBVK2I4R2FvcTR0MzAxdTRNK2JsS2dDWDVETlQ2RTht?=
 =?utf-8?B?YlhDVk9sRU1pajJHUHJyQ0U5V0FFTGpZWU5jV3p2RHhmb1BkclRjY2NkQ01o?=
 =?utf-8?B?aUlRZjZmUDZDZkJXakwrRUh6RTdiZGdnNVVCbVhJVERmNnQwRkYrVWlPVjZu?=
 =?utf-8?B?OUJ1a1FaYnhqUkxvd2FRb29LSXlmdzRvdGtVblBmTHRCMHAzWklmZUxUVVZn?=
 =?utf-8?B?Mk9nT1VxVGpIZjVUQTlzM2JqOXpxZlBJR3RoTzdXNFplQ1RLUXRQMlArdnVK?=
 =?utf-8?B?aXJhZ1hQOXBLdy9BVnQ4M1JVR21JemMxTlpkNFBDQS9GNCtKejVCNzFJQUIr?=
 =?utf-8?B?bG93VkZ2Q3FxN0RJMWtXWW11MXQ0SE9lUjhKdzluTWVnMWwxZTEwdjdHSFVr?=
 =?utf-8?B?Wkl2cHB5UmtaeXYvUm9tRUZjZml0UXNUd0lEZmhKR0tBV2J3dWJvVzh4MW9o?=
 =?utf-8?B?U3NmQkpCYjJ3ckxTTTlkaVhPRTlUVmFvK2pGT2ZwSjdOZjAwNThOa05Zbjhx?=
 =?utf-8?B?SVc4SThFdElCcnFnOVA2dlFEVTVNZGR3a2g0bmQ5WEVwWnFIU002YlBJOXRN?=
 =?utf-8?B?eXVlWUt2akZ1MDYvVWdtcjNkbkRpUDExa28zeW5id09LbUs3ME9lN2NjeEsx?=
 =?utf-8?B?U21YTGQzUE12bmp0ZS92VEhkd1VuZ0t1anlldlFxMmNobUQ1Zy95amVtMkxW?=
 =?utf-8?B?WkNVRXJHN2JWcERhcnRYcVJKSmErbEVJWjFuQXIvd3hVZjJvMnJHYTRHY0tT?=
 =?utf-8?B?UE9RcXFwaUt5Y3dHYlI4UEF3WGpRZDhCOW5ZYktGYlJJaEhqNjBwVEpzdnZX?=
 =?utf-8?B?anpWSFdobDdJY29KZHJMdzd0S0dvUDR4WWJHVTZhVmxhK3pKOFRuTGV3eit6?=
 =?utf-8?B?SG8rQ1NhZFYrTlVaNGYzbGpWeHU4MkVlbmNuRUpGZXk4OGRZVjByTVo2MUE1?=
 =?utf-8?B?dTBFeVBGN1h3VEc4aUtLbi83YnRGa25MWGU2NUYwazFWUjcwZkV0dVpWeUhm?=
 =?utf-8?B?aUEzNm02MTZqT1RwemVLQlo0TGM2VVpOd1AxSWtVZGtPLzdCVzZsbnNHeWYv?=
 =?utf-8?B?TW5aS3crWlBKU2JYa1dTUU9QOG1yUVhoa2tMYWRzNCtMQUlyNjFFSGdVVGJp?=
 =?utf-8?B?eWFHK3BnQjNUaUZKeG1BUkdEZW5YbHZ5cElGMWhmd1dmc2hFS0xNclZHWHph?=
 =?utf-8?B?MEo0MDRLZ2pXTUlEZlo2cCtvSkZPRzgzdnFzbXVNS0ZkTmNubnpRekpuTGFC?=
 =?utf-8?B?dHZteGptandqUkVYRHU4OUpyR2llbzZBUXF0cXhFcjE1WXEzWEZVem1UVkR5?=
 =?utf-8?B?bm5pSzFTRTRnMit6RnpUZVZFOUx5NStuZEtOY2JIayszcEw5OUl3ZXhwd3JE?=
 =?utf-8?B?V25kUWRGWUJwQlo1UzZMSHNkNUFzR3BvNitlM3FZRHVDTGUyNzNwcE9ndDFW?=
 =?utf-8?B?dFNaWUR6WXRFcW9ZWUxSMkg0RHl4d0lTSnhDKzlHVzcwQXJiVzBMNzN5eEdB?=
 =?utf-8?B?UXQzaHpVWmRNSTNmUnVSQnlNeHA1UEZFbzBsRFV0czVLTElLMGxjQWRIZWxV?=
 =?utf-8?B?dWtUdTJ5TStRclkvbmRLL0FyaE9HRGJVSVV3a1phQ0h2Sno3NXArVnN5bC9B?=
 =?utf-8?B?c3cyY2dJUktPTk5GMFlBTFptSEdKb2JjNHZ2c0ZZa3ozL1BxZ3VIVUFZcUNK?=
 =?utf-8?B?TkJaRWV4MStMZ0x0dFhyQmZaYm5SeWRvQkI3QjhWZE80c1FWL3V0NHhvY1hK?=
 =?utf-8?B?MWpCbERpQTd5N1A2eW03R2RyNk1kVEhMMUh2clZjZUR2TXFGYTA2VUdBVitT?=
 =?utf-8?B?Lzk2VEp1TTk4L0t2c09jRXo0ZjRRL0NOMVdmQ0VJbmE4Y000eUhmQlBldERE?=
 =?utf-8?Q?4WqTA88eVHPsXlCgBB/m55C48QfNeoKj?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WnU4UGFzWXdIQlJ1bk5hdEtxNnlCWmh6ZERac1J3Q3pCUzdYbExyTFY0UXNl?=
 =?utf-8?B?dHFnY1ZwWDh6UHlidHJ3bWNtSldYaGdHTURvK1JnM1dxZmtmRG9tNDR5ZHd1?=
 =?utf-8?B?aWhBRmlSY0xxK2tteDRGZ1BVY3F6MDMwZEpGbzZSVks3d3QrcExPUUszNzhx?=
 =?utf-8?B?dk5VU2JCc3ZFVU5aQWlrVUlXbmFGemVjdzZYa0lWdTJ4MmJIUGlmWXJib1Vm?=
 =?utf-8?B?cWRBT09QQmZnU3B5S085ZmJMaFBnSk5QMWRJSHEzdVViT2JBK3JCLzgvM0N5?=
 =?utf-8?B?cDdNK3puVlhHc2NyTHZDakxtK1V4aTVmSHU0bjRpbGcrVlM5bW9QaTRtNlFp?=
 =?utf-8?B?RXFqcTcxZ29jRUMxQXVUZFJDR0h2cy95aDhBNXNNWXAySFc5SCswQ1RWTnFB?=
 =?utf-8?B?eUU2MWJPRlcrbEZGY2xYRmZBU3krQWVBK0t6WmdwaWNHYWNvdzN6NXR2d0I5?=
 =?utf-8?B?Wm5BbmRPamdNUzZxRG5YREEvcW9hTis1SVNjdXJaM3piaWxocnN6TFo2RjI2?=
 =?utf-8?B?d3ZIeDYyMlRVREZhVDBWK1kzeWhwVVhKQ1dXRTIrektJb2pNNlZwMkxPZjJD?=
 =?utf-8?B?L1dab0NEWU14UisvRVdGeW1halp0bWFuY3JKWHEvZkZmOHVNRDZVYW8vZ3Nw?=
 =?utf-8?B?NSt6MHFXdFdSdDZ6b3ljTUJHeE1FemtLMVYxWDRwWS9hOGdoQ1NqR2RPckxx?=
 =?utf-8?B?RStjY0JvQjR4cGM1OWpRN09YQjRoY0xKUkFleTE0SWxzbktqMEptM0syVVFa?=
 =?utf-8?B?SWdMbWU0WmJ6YVk2cDRSWHVGQVBqemxFVVVxalhUK2xQem1UWm44VjQ3dXJs?=
 =?utf-8?B?WEd2UkdENk5Dc1EwMmNSUCtZeXlScWZDcWlYSHJ3dTBmdVRKOU9JaGJKNXRn?=
 =?utf-8?B?dms4aFdNWFhwWGRGWVdjTnNUc0ZsVFlzTXRXNWRTdEJQNWRDVmlYYkQwTC9j?=
 =?utf-8?B?NkJPbFRJNmRLOHM0MHFQdW9ZWW1OVlYwV3Z4TGRQNWwvYVlWNktqWUFRRExR?=
 =?utf-8?B?S0tzejBCK20vUW5mSTg3WWJIWWQvZ3BlYStmbVZTZE4rak5ua1ZwVjA1NGh0?=
 =?utf-8?B?YWdhbWRGWFlUWVFOVWk0ZGlPYk5WaGVJQTd5NDM4NVNFclluTmt0MWVHTWhN?=
 =?utf-8?B?MHJEYnJvNW5WVUFQRGtvSVFJVkZVMDI2cDhyZi9McEFBL1dlK0tWTVNoT3Uz?=
 =?utf-8?B?T3RCUGpkdWdzeGpaK3haNkR3cW04SkFGWU9FcHZ3dXNuSmdyY0RoQXFxQ0pv?=
 =?utf-8?B?M0k0UmJOUk5jandhbjBoR01LcjV0UWV5VUs5dGZNTDRCMkNCdk1Cck5DZjlq?=
 =?utf-8?B?SmJscHh5RVVFNkUyY2RGWVBEQ3lUSG5OKzRsWmhnZ2crZkgyZkttRzhncmhB?=
 =?utf-8?B?d2tYUEJSNm15WktDZXhja3g2eEZtTTkwRFlrejk1dm1WVmN2WDkzQUt0ZE13?=
 =?utf-8?B?YkVPV3ZkUXJrSUJyQm9lS2xtd0NVNmR3YlBTZXFXa09NYUMxb3ZvYy8xQkxl?=
 =?utf-8?B?dzZsdkpyRU05UXVpVWVOTEVjVTRDdUl0SnlaOFpWdFN4RU9FTE1FcUw0d2pC?=
 =?utf-8?B?cmd6M3dMV0R4RTEwa2p5eEhQL1E0N0FBUmxQY25QQnU1RFEwTzhRbEtpQTlu?=
 =?utf-8?B?d3BKc1VFbDgvM1Q4MXJmdUwyNE80bU1hMFJIQVF2ekRENUNBVStsMTRoN3Qy?=
 =?utf-8?B?WVB0U0lWN1F3QzMxcFlwbFo2RCtTNmxEdFpjWHBGRU0zWkgwR0s4ZjE3SFBq?=
 =?utf-8?B?Um5HVFIwRm44aGdSYkJYcC9PWDNqOUhpdlpHOEFwL0JDZzdQeXQrdzAxK3dT?=
 =?utf-8?B?L3dUSmtobjJYdmdHQ2FNN1dlWktWb3h4eGNQSE8xS0RaZWVvZHNWZVljREpP?=
 =?utf-8?B?TEdwaHZDazhqWVJLenJUQTR0VGZYRkRHNW9JTS8vbEFLZWhlN1lEMERld3hn?=
 =?utf-8?B?ZjQvank4Z1NSelIyWFk5Q3ZKaWdnTThseW00THdTMU1WVTFQcHluVGVCQWV6?=
 =?utf-8?B?M0tsWDZJS0RSWllnamEvYTB5Zml4dVlLRWlJVlBOdEVMdG1iek94ZEJwb1lO?=
 =?utf-8?B?dlBLOUZkVlR3bTlaT3VBc09Gd2xsbmw4UkxLaWZqUk80TUJZZkdIYndoRGc3?=
 =?utf-8?Q?oK9HlVVTUcRHD4EQaEBwZWGBs?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1130379-31c3-4add-c54b-08de25ead285
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2025 15:06:01.9107 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qBhe8cVYZEIVa3GFAbv/tYtCBdc4otB2PMjphu5gCUZJfqI3cFayU88i1fqCahvEZbAjiHuA4AeJexZ3wx5VqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8216
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

On 2025-11-17 10:00, Philip Yang wrote:
>
> On 2025-11-14 18:26, Felix Kuehling wrote:
>>
>> On 2025-11-13 16:09, Xiaogang.Chen wrote:
>>> From: Xiaogang Chen <xiaogang.chen@amd.com>
>>>
>>> Fixes: 7ef6b2d4b7e5 (drm/amdkfd: remap unaligned svm ranges that 
>>> have split)
>>>
>>> When split svm ranges that have been mapped using huge page should 
>>> use huge
>>> page size(2MB) to check split range alignment, not 
>>> prange->granularity that
>>> means migration granularity.
>>>
>>> Signed-off-by: Xiaogang Chen <xiaogang.chen@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 16 ++++++++++++----
>>>   1 file changed, 12 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c 
>>> b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>> index 521c14c7a789..c60d8134db45 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>> @@ -1146,11 +1146,14 @@ svm_range_split_tail(struct svm_range 
>>> *prange, uint64_t new_last,
>>>   {
>>>       struct svm_range *tail = NULL;
>>>       int r = svm_range_split(prange, prange->start, new_last, &tail);
>>> +    bool huge_page_mapping = IS_ALIGNED(prange->start, 512);
>>
>> Instead of hard-coding 512 here, it would be more future-proof to 
>> call amdgpu_vm_pt_num_entries(adev, AMDGPU_VM_PDB0). That's currently 
>> a static function in amdgpu_vm_pt.c. Christian, would you object to 
>> making that non-static?
>
> We don't have method to know if prange has huge page mapping which 
> depends on virtual address 2MB align and physical address contiguous, 
> it is decided inside amdgpu_vm_ptes_update. Even prange->start is not 
> 2MB align, prange could have huge page mapping.

Right, I guess the correct condition would check that the range contains 
at least one potential huge page. I.e., the start address aligned up to 
2MB is larger and the end address aligned down to 2MB. And the unaligned 
split is between those two aligned addresses.

Regards,
   Felix


>
> Regards,
>
> Philip
>
>>
>> Also, to improve the check whether the range can really use huge 
>> pages, you could add a check that it's size is at least 512 pages.
>
>>
>>
>>>         if (!r) {
>>>           list_add(&tail->list, insert_list);
>>> -        if (!IS_ALIGNED(new_last + 1, 1UL << prange->granularity))
>>> -            list_add(&tail->update_list, remap_list);
>>> +        if (huge_page_mapping) {
>>> +            if (!IS_ALIGNED(tail->start, 512))
>>
>> Make that one condition: if (huge_page_mapping && !IS_ALIGNED...)
>>
>>
>>> + list_add(&tail->update_list, remap_list);
>>> +        }
>>>       }
>>>       return r;
>>>   }
>>> @@ -1162,11 +1165,16 @@ svm_range_split_head(struct svm_range 
>>> *prange, uint64_t new_start,
>>>       struct svm_range *head = NULL;
>>>       int r = svm_range_split(prange, new_start, prange->last, &head);
>>>   +    bool huge_page_mapping = IS_ALIGNED(prange->start, 512);
>>
>> Why the blank line before huge_page_mapping? It's part of your 
>> variable declarations.
>>
>>
>>> +
>>>       if (!r) {
>>>           list_add(&head->list, insert_list);
>>> -        if (!IS_ALIGNED(new_start, 1UL << prange->granularity))
>>> -            list_add(&head->update_list, remap_list);
>>> +        if (huge_page_mapping) {
>>> +            if (!IS_ALIGNED(prange->start, 512))
>>
>> Same as above.
>>
>> Regards,
>>   Felix
>>
>>
>>> + list_add(&head->update_list, remap_list);
>>> +        }
>>>       }
>>> +
>>>       return r;
>>>   }
