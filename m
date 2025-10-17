Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B937CCCD195
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Oct 2025 22:40:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1067C10E1D0;
	Fri, 17 Oct 2025 22:40:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2a8uGYnU";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010069.outbound.protection.outlook.com
 [40.93.198.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E808D10E1C5
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Oct 2025 22:40:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GUXgnmu0ZwakJc0iVsj7MkFjMml4cuBtZl/wHSf/LBjksM7nXXm1lN5kTkwbXqdQbc6uh0xkkf3YyD/Nfz+GMddHmMS1Wi315nzVpddEpPKFp3g/MY6VxKz9asZAnZ+yxV/D3wO36+5bN9/SVT5DiIy2msdoMQKcqDrIBvM3e4fWK12gjFmpBHuHzK8Ve0S+qthxn5cUubCgLOHtoI7XEIyNJmL5qmptl53e9QtAGj2Y2c5LSBJZ5Ddh4rXPbY3CJhRBn7OMwKoVVRLFJIqeVUi5k15v6vtE5sLno5yjZiaJVlweYgt4mGIurpCEBtgAXaKOve6DpUoADM8M70XLzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IE4P9rer7JvW1m8HnaW7RtvD9+J3DcBjSN70Zmpbrfc=;
 b=rzHgg4Ir6B5p9TNENw2IWPU0AAZZSIeFh07BAEqw6BESA1FAFo8wOQWVAQW3XJNYT9xE0+e+01EptpMZ5mpY5CzRlwc2WAMP1jGhGKCfbpvOnVGaD0dQI7R9ohusNSGCKZxKyML6BW+G2am4W6OFRiIfJwGrbhaoRNfZ3owtqt0AwBKsWeYKiN4Og9X/iQEMcns3q45e7sJE1ebLcAepDo2zkKzP7cNHkjsbesq7skZ+ePbX6czre0Z6d7lWm8PAHtGm+8qcLIZrRj/gCn7ftt10y3BNKg+boBldifNG+tYqoMSwfIGiol2geRcFSSmMDvSxxnn3p/pa8GDRstgYvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IE4P9rer7JvW1m8HnaW7RtvD9+J3DcBjSN70Zmpbrfc=;
 b=2a8uGYnUVzvMmIPZK9xvDkcd1t+hbHvehH2PD++GOgy9BVWbS2i6ZkMjUqNlQvEi99m3IkWwqOciU3/rvptGNKYux0+Y0FmVyDTA22Q4UYJVIZjeXoR93ASlGavVkOKMpeWbeCjcDDUCc2cfSGxo3VrGgp/Rz2Dp/XJ0GbT8GAU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by MN2PR12MB4223.namprd12.prod.outlook.com (2603:10b6:208:1d3::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.13; Fri, 17 Oct
 2025 22:39:57 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81%6]) with mapi id 15.20.9228.005; Fri, 17 Oct 2025
 22:39:56 +0000
Message-ID: <e9368458-47b2-4bf1-9f44-edee2cd45023@amd.com>
Date: Fri, 17 Oct 2025 18:39:54 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] drm/amdkfd: Fix false positive queue buffer free
 warning
To: "Chen, Xiaogang" <xiaogang.chen@amd.com>, Philip Yang <yangp@amd.com>,
 Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20251015201134.2540-1-Philip.Yang@amd.com>
 <682f9477-ae2c-4022-be84-620cb02e388a@amd.com>
 <42c82bf6-e100-076f-18a6-43a50e758d8d@amd.com>
 <39f7504e-a162-42bb-a481-6c2c7aa8e416@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <39f7504e-a162-42bb-a481-6c2c7aa8e416@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQZPR01CA0014.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:85::27) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|MN2PR12MB4223:EE_
X-MS-Office365-Filtering-Correlation-Id: f2ca729f-615f-4b59-2874-08de0dce18da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Ykc4TGhSMFF6MW5naWRJVE0zOW1tam11WmVMV2xiaDNneTJyQ25YNkJsV1lD?=
 =?utf-8?B?Z2hBejBxcDdpbjhFcWs4S0FqdkRjNTc1cTBxR0hkakJqcVN4d2dBb2FvZUdv?=
 =?utf-8?B?Wkc4RmJtc0c2UHdnMlIxOThLbzl6c0VHWTI5dGd0MFg5RVhSTWREazVUZFVR?=
 =?utf-8?B?Mk5TRU9GZmZseVg5SFRqL2xlTDFxdmR4blVxcEhyVk4wSGdobzFGN09FcitU?=
 =?utf-8?B?YitZS2tjR1VTQnJaUlJtQ2RVTW5qMERSakVNM0dUZTlJWWF5MG5IZFhBbW1t?=
 =?utf-8?B?SFR3dy9mZk1XeWhQcDU4S3ROaEJuUHl2Z2ZOQVc3Q0RyeTBEdXlzSm16N2RI?=
 =?utf-8?B?bjFNUmJpUGhiZWorM3lLQUo5ZmpIdWdFTldMcFNjK1FFUmwxYml1ZHIxaHEy?=
 =?utf-8?B?ZldPaVZrM2tQRStqeTNYNlZ3MzEvaGd2TVdadDQ1VUlSSGtqZTBzM0UxWG9V?=
 =?utf-8?B?ZnNEQTRzbjBNZ0l2NDdoWWlEZlYxOXlYdlUrSlN4cTY0ejlySStQN01zb2E5?=
 =?utf-8?B?THM3NGErRk03NmpEaTZ3SmdRTlRvNzM3SEJNRXMzYUNLWWZ5emgvTkk2NjhV?=
 =?utf-8?B?M1d3N2NadVZCRG43SGxDZW14QVRieWhWTmduVkNYRlE4RUp6OEdnQ3Rha1N0?=
 =?utf-8?B?WjV5a2dnWHVoa0pITk1WVkVnU1paK3pYTGdBblp3VEpndXJVdTNSaWtzTk84?=
 =?utf-8?B?cHI2MUFqRnNOblVKNVdBdHFLM0hLeU5ROHFqRnVHQmVjdENGcHkyajNxRDRh?=
 =?utf-8?B?K2lXajROeVkySitmOVJqSnV0bUlmdTJ0NHNDUXdxTk9lQ2RPRDFmb1V1dWFI?=
 =?utf-8?B?UE5YRE55c24zT29oUy9hdzQ1SWdpMFZwV0dTMkZzZ0MzVUpyV2V6WXJScDVZ?=
 =?utf-8?B?SFNCQWVIa1U0QkVUVElQL29nT1FBK1R6NWFaT2JoakhqUUJPWE54WDJ5bEY4?=
 =?utf-8?B?T2N6UGhMM3kzZHJLbE52V0Z0K0tWcXdocE1ncWRwK0sxRHhKTVUxMkpHUWxN?=
 =?utf-8?B?anpCczVHNStMWnoyamxQbmxpTWxEbDJPWlJYSERscVQ0cmpnL2ZYblNYb2Rs?=
 =?utf-8?B?ZWRBVCtyZm52MVZGUkd5T2d5YTFsVU55blhaVCtPMGkvZkJCbERLZjBkbWYw?=
 =?utf-8?B?cW5XOTlURTN5NzBqRytwU2hmdng2ODJqaHZtRW5Ga0M5TXpvY3J4N1BlazZ5?=
 =?utf-8?B?am5FMzdWTk9zaXQyeFl0VDVoRDJjcml3WW9RZE9US0RSZUZKNkhKSWZuaWlE?=
 =?utf-8?B?VlFkOFFRTDJxUEo0bW54UXIrUm5jbGVGNXR5TVlKTWpTbFpPSEtjZXJJdndW?=
 =?utf-8?B?SkdjMWlNdFNWWll6WWZ2MlRoMW5wemFBTEQwOFdQNDV0TDVXYnVQQ0ZoNmUv?=
 =?utf-8?B?cFhYcVJSaERocjMzYTdnQ3I3Vkd1TGdOU2NPUTU4M3IxWUR2Qk5NclJOaEFK?=
 =?utf-8?B?WlpxY3lZQWhjbk5JMUp4MUhXektBcGFqRTJmWjJXclJNQU9pN0xwUVpsOUNW?=
 =?utf-8?B?aHIvVmNDbGVCK0IvUUdCblRGMWpqaHZqVHNlZzZoREdpcWpGcjgvMUx4aDBu?=
 =?utf-8?B?S0I3SzFyMDVDbjhSSWNyd2NNYTVxSXJ1YUxBUU5sRjViWjRTYnAvSk1RWUpQ?=
 =?utf-8?B?ZFY5emlMSzZRM01GVjlpZEFBQnQ4bERwMEg5RnVFQXVIQm82cDRHZndrYXlt?=
 =?utf-8?B?ZDNzL1UzeXM2SEl3bDRaclVwMXNPRjRYMDM5alRXWnZoVnZvZUhkcU1uVE1m?=
 =?utf-8?B?TXBteUQxMG12KytaTnl3YytmOWhHckp2NFVRVzRONWwvZXZ3akZvSko2TUZo?=
 =?utf-8?B?bVBrZWxCV2R4TmU1Ulg0VG5ZcjhMOXIxWkJoTTZ3NjMzZ3ppaWlvakQrcUc2?=
 =?utf-8?B?T05qeURsdEx4WDJLcVIrU3FqVHY3cDh4dG95Nm5DV1VINzVIbEZ2Ymk0Vjdl?=
 =?utf-8?Q?C9l+0QaRyAO0F5oNKVNMOIiksXkqKh7Q?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WWQwd0R4cG5uWnFwL3VSSVplNnFEbmFyTDc1QkpUQmJqaDl3RU43bUVRamg2?=
 =?utf-8?B?RDFYb3N0aU0wRXE4b1pkVlJLTTlJcXlTTWE1R3lWdFV4WWJJUFRKYUhMRmJz?=
 =?utf-8?B?cWxwM1NoRDJkU2xTaW5YaGJLN3dVb0s1b3h5NHMvaElzektFVytEQ28xeDJK?=
 =?utf-8?B?Qkd6NVMwUHhBUXlDN0JJS2dhL21oTjY3ZkxLUmZnU3NmN2NnUTF3cTh4b2xV?=
 =?utf-8?B?ZmhGLzllYm0vRWNSenpmbC9kdGFoQ3R1NFM2MUs1aVdsb1ZabkRWYVhOYmYr?=
 =?utf-8?B?YkkwVWpjUlh4UXBUbC82TFZCUnN4RE13N1lvRjJVWHJkWTU1Q3orSzVBUGVT?=
 =?utf-8?B?ODR1bkVvMnVUZGF3bDJ1RjlkdEdYOW05RW9XenpWeThwZVNmZzRsc3U5WGND?=
 =?utf-8?B?SnVoNU9vdkMzWnpuZHFYb0VMTm1uUDdIRDU5NlQ3YlVPRE0wVk5MN1FRWUZ1?=
 =?utf-8?B?RmVMenlzbEFqSjJVYVN0THR0RkVVNmEweEZJaTRONVFaam8vTnRaelNjT290?=
 =?utf-8?B?TFRXN0tnNzk4ZUZhajBHaDJJWm1SM05CTW1TL1I2WmZ4SlNQN3lNWThuazdR?=
 =?utf-8?B?a0QzVjJsd3F4dTg2TTRVLzZDMHZMWkg2d1k2SWkrZW9MQm9yL2tWQ1lBSWFt?=
 =?utf-8?B?REkzcDFza2tTUmdPRkUzTFFnSG1pOGUyZ2RTb1ZzMkdLelhjRUZyY3JXL2NQ?=
 =?utf-8?B?VnRwQjNNWlpsUllPdWlPckpDNHdYdG1CRmxKRm1ZSUZOM0dnWXhUTkswQnlh?=
 =?utf-8?B?VjNGUXRIMU0yL1VpdXVtMGZQUzZHT1Q4dnVwOElyUFg2TXR2WTJPRytIVFNR?=
 =?utf-8?B?bFhpTFFpS2dWbVVtQ3hTUFhORE5VQ3VabXNrMUhkTkYzUGdyVmhYMUlpNld3?=
 =?utf-8?B?VGtWQ3FiTzZVRkg4ak8wTURrMkJ3cGVOd3pkaTBtRWRxQ3BJT3plRXJROHU5?=
 =?utf-8?B?OXowYlBsVXc0YzZYSW5GRVFGVFIra0U5TUNOOWZ5MzBHaEJWaFZDYzhMRlJw?=
 =?utf-8?B?UmFZY0QwK0VlZnZZeS94TDdOdG9VVDMvaGlIKzR2Y253RTVtWEVBYlJlWVRv?=
 =?utf-8?B?RjczQ0Q3dXFxa2tTNEI1S3MyNXRESThJUHA5dFpoZDB2R0Z2ckZ0enZoSjJT?=
 =?utf-8?B?a2hGWGViRUNSZXVwOU4vSlF1V3pwRzk5eW9lMCs2TjBhSUIydDVpdXg1WU9n?=
 =?utf-8?B?MU1OOFhTUVRwdi9seW8rQzAwQnAvYnN2QnZReWREZUx5UFZ4NmxjbTdzWnVR?=
 =?utf-8?B?WHZNTTNRMktTT214WVYyQnVHQlJGUkRMT1FCM0grZjFaREw3R0FheEVVM0hr?=
 =?utf-8?B?ZnMvSkNDNjBHbjcwRnpyMmkza0RTb1F0bFBZNnorSlFlTlF3c3Z6YkVXVVd6?=
 =?utf-8?B?UlFCKzFTbFhmcWtlNStGbjAxdU5GMDRsYUhQR0xOMFk4UTZ3UWFTelNIeEhn?=
 =?utf-8?B?T0xjbmFpSWdxSDZYRGcvditITXJKQmFzbWs5RWpwUUJHdmRCeEtKVERjVkJU?=
 =?utf-8?B?bnRheW1tblZpTjJFakxYMUhYZ2tqT0lyUDVETnR3YVdkUkFEWGgwYTJXYlhs?=
 =?utf-8?B?aE5mOG9VQzFEazMydnc5TDFyNzhCd3NGQVdoOWlZdTRFNTZVb2RyMTVraVd5?=
 =?utf-8?B?Wm9PWDUyckxjcnhoSElFUUYvVlAzdnR4dGxwZFU0TWczR1pFcWNtZVhWQ1BK?=
 =?utf-8?B?R20rRlBXK1h3U2JMQUI5ZndTeWtVam9rQUxnektmWlZMeXlkWWxGc3BWN2d2?=
 =?utf-8?B?eVVFcEM1bUpuR1M0RnM4MEJUT25yTG1vNzdIMUdPbHBLZVRCcnJrU2JXSnJa?=
 =?utf-8?B?cUpVajFiWjltY2hUak54OUFWN21FR3h0T0ZqajJiTzBDenluSUtucHk5WnBt?=
 =?utf-8?B?VWJOQ1JxZnJQeUlVZUlyZjIwcHk3VVkwYnFuaTd0NW1Sb3cxcHIvaFFSSzBo?=
 =?utf-8?B?RWJQaEdGdWl1cWRvK1pyVlpxaHJLL0JtRi9NamNUSmg2SlJ1dUl5M1U0UHlV?=
 =?utf-8?B?TGtKRDVmN2ZwbHh1bUgxeTNLcXZBQ2VzWC8yaVhkUDBrRENISzR6SmZZaUls?=
 =?utf-8?B?T3RNaEpFL2pUUnQvRUhrWCt5ZEY2eG83NjdGTkJaZVBjd2pEZENja3NKQS9u?=
 =?utf-8?Q?/jQRDDTvt9YFPyxkIlf+GL9Kd?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2ca729f-615f-4b59-2874-08de0dce18da
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2025 22:39:56.6079 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f0a8rfgt7s6K8CbVx58z9OYa8bVaJ4Bp2ab3f2C3lWqb/KcJw2O63tob37IVUA0TZoIYYGK6MMFwD3X0136O0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4223
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

On 2025-10-15 18:46, Chen, Xiaogang wrote:
>
> On 10/15/2025 4:45 PM, Philip Yang wrote:
>>
>> On 2025-10-15 17:01, Chen, Xiaogang wrote:
>>>
>>> On 10/15/2025 3:11 PM, Philip Yang wrote:
>>>> Only show warning message if process mm is still alive when queue
>>>> buffer is freed to evcit the queues.
>>>>
>>>> If kfd_lookup_process_by_mm return NULL, means the process is already
>>>> exited and mm is gone, it is fine to free queue buffer.
>>>
>>> But another question is why a prange is still alive, its kfd process 
>>> is gone?
>> It is application process exited, kfd process structure still exist 
>> and available. The issue is race condition:
>>
>>    do_exit
>>       exit_mmap
>> a.          mmu mm release notifier, schedule kfd release wq to 
>> destroy queue
>>              unmap_vmas
>> b.                mmu_notifier_range(.. MMU_NOTIFY_UNMAP...)
>>
>> the step b is executed to unmap CWSR svm range, before step a kfd 
>> release wq destroy queue.
>>
>>
>>>
>>> When unmap a prange the queues that use it should have been stopped. 
>>> If not, there is problem somewhere. This warning message need be 
>>> sent no matter kfd process exists or not.
>>>
>>> I think a real problem here is kfd process need be alive as long as 
>>> any of its resource is still alive. In this case since prange is 
>>> still alive its kfd process should not be released(p should not be 
>>> null). If not we need wait all pranges from this process got 
>>> released, then release this kfd process.
>>
>> kfd process structure is freed in kfd_process_wq_release after 
>> svm_range_list_fini.
>
> I wanted to say: delay remove kfd process p from kfd_processes_table 
> until all resources of p got released. So when any p's resources is 
> getting released p is available. That needs change kfd process release 
> logic.

That would complicate the cleanup a lot, because now other threads can 
still look up the kfd_process and use or modify it concurrently while 
the cleanup is happening. We remove the process from the 
kfd_processes_table first to ensure that it is safe to clean up all the 
process resources.

Regards,
   Felix


>
>
> Regards
>
> Xiaogang
>
>
>
>
>>
>> Regards,
>>
>> Philip
>>
>>>
>>> Regards
>>>
>>> Xiaogang
>>>
>>>>
>>>> Fixes: b049504e211e ("drm/amdkfd: Validate user queue svm memory 
>>>> residency")
>>>> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
>>>> ---
>>>>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 5 +++--
>>>>   1 file changed, 3 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c 
>>>> b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>>> index 4d4a47313f5b..d1b2f8525f80 100644
>>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>>> @@ -2487,7 +2487,9 @@ svm_range_unmap_from_cpu(struct mm_struct 
>>>> *mm, struct svm_range *prange,
>>>>       bool unmap_parent;
>>>>       uint32_t i;
>>>>   -    if (atomic_read(&prange->queue_refcount)) {
>>>> +    p = kfd_lookup_process_by_mm(mm);
>>>> +
>>>> +    if (p && atomic_read(&prange->queue_refcount)) {
>>>>           int r;
>>>>             pr_warn("Freeing queue vital buffer 0x%lx, queue 
>>>> evicted\n",
>>>> @@ -2497,7 +2499,6 @@ svm_range_unmap_from_cpu(struct mm_struct 
>>>> *mm, struct svm_range *prange,
>>>>               pr_debug("failed %d to quiesce KFD queues\n", r);
>>>>       }
>>>>   -    p = kfd_lookup_process_by_mm(mm);
>>>>       if (!p)
>>>>           return;
>>>>       svms = &p->svms;
