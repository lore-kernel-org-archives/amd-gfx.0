Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3580DC433F5
	for <amd-gfx@archiver.kernel.org>; Mon,  2 May 2022 09:51:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9BC8110E9FF;
	Mon,  2 May 2022 09:51:46 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2070.outbound.protection.outlook.com [40.107.236.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CCAC310E9E1
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 May 2022 09:51:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LLfvWvYcEWrKVsYkk054Fdvk5FeKQhshwDyp/hcATFxuro7mHcjqqanIfW+NkKWtjEJL5u1gCwz+hC6BLmE8qQLu9aCXxyDjUeT6BOg8UZVxuJFT0bqSusSgF2CztKU/k0NSKBQuapot79FBOD1kaWOUhj6lXNG3COYgh7MTnFErrTIYn8RtYnEeqzowOUWnq+SN7cNRnsLqV0SzsDAXhsRGMmr/eF0NuNoUgBE6y52i9E2eXZaTMzUXK2ZL7cJNHH6tefeKPdUxqje1PqcSynPLMCM7e7XnDxIXQVNKXeArRripwB+S7bd/30GgWnSeNnOjbm8xTGr5uTsF08dSgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DIdEE7azzIVbNeGHVmAf0OANR4z456MeO7vPCMbiF+I=;
 b=GiwgrfjVzvxvgWPL36SmZQ2DQpOXHYvsQW59oGTfy/LxUH23ANay0gxokemjZT6KPIU6qR7VrwCeXSzZKUoWIsIot0J8DKuWlBA/XFMygiiFpHgIy8yVRYG2baMoRWnSj74nTw35a+meUVc15E+CJe37IvFWNY53fk2hMJsCFiGiCXeE8nHY/SQB0Bn8ZIFyAYBMm7W+9NW9bPqYsP88wLf1DfNBfOVzTnaxM9ZaD19Cg4xrrHRWg36dazNlTetdDP4Rhy7lxddUZkvlM6yPK8HqYOyFml6wXBdCBwyVxi1H0GZyECRG0LpF4HUCyVUmV+r2xjCtuxgITStUnSfTVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DIdEE7azzIVbNeGHVmAf0OANR4z456MeO7vPCMbiF+I=;
 b=sKhjK0KsUN8hwrCEZ/R0TjED5ea15CfLmc0Ceape9vGeahth+aYgLMu36Zqspt0MYvzS4xv+tklYzoRexNCzch6LTfOgUEpIDLWEwOBruReEcparHhiXlvKSvA4sOglFinZLSyWCwdov09BSaikuFKnPFkAHKJY7ykygLQRpki8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4342.namprd12.prod.outlook.com (2603:10b6:208:264::7)
 by MWHPR12MB1198.namprd12.prod.outlook.com (2603:10b6:300:d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.24; Mon, 2 May
 2022 09:51:36 +0000
Received: from MN2PR12MB4342.namprd12.prod.outlook.com
 ([fe80::812:88d6:77ae:1d87]) by MN2PR12MB4342.namprd12.prod.outlook.com
 ([fe80::812:88d6:77ae:1d87%8]) with mapi id 15.20.5186.028; Mon, 2 May 2022
 09:51:36 +0000
Content-Type: multipart/alternative;
 boundary="------------0TFk0kqSvp5eODqzlMUj0uR2"
Message-ID: <a2a802bf-2118-9a35-4415-f08d399dd8cd@amd.com>
Date: Mon, 2 May 2022 15:21:26 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH] drm/amdgpu: Add out parameters to drm_amdgpu_sched
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com
References: <20220430151428.237089-1-Arunpravin.PaneerSelvam@amd.com>
 <85927512-377e-39b1-d812-ef9bddcc2f02@gmail.com>
 <b42d6e3d-e646-8bcb-6166-bdb94ddd1d69@amd.com>
 <54568104-c607-eb76-6c20-67e91baec00f@amd.com>
From: Arunpravin Paneer Selvam <arunpravin.paneerselvam@amd.com>
In-Reply-To: <54568104-c607-eb76-6c20-67e91baec00f@amd.com>
X-ClientProxiedBy: PN2PR01CA0059.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:22::34) To MN2PR12MB4342.namprd12.prod.outlook.com
 (2603:10b6:208:264::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 59a99ba0-aa02-45b9-2ce2-08da2c2158c9
X-MS-TrafficTypeDiagnostic: MWHPR12MB1198:EE_
X-Microsoft-Antispam-PRVS: <MWHPR12MB1198BAB30E62F2B52500C854E4C19@MWHPR12MB1198.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0IrTW00D1+9PtMXQyFcLCyvtSurHtUWqDELKllDrmu/jiWepJ7Bk+pxwYZX9IMXRSExiaf3+/t/K/TbQGEYDVijjgCXYnYUCwxZc2aVu2Jw68rHtbJ+ylIB2sPJJjeXrgwkxZ+edDb3lbUgprhIE3AXUD46T6qkGxhKpNjqBZM9NFTzoeaey1E/QBoRBdPe6TjFZJmV96Jy8V3v5CiEmEVj5g5GaClQxJqmCYU2dmiBf8NYH4cX5XEXA4/pkkjOi8JCTtdnehsfbvCOBzIwl2saHnjexth/DHahbvQk8PAbjtckBU0RytLOrtbWJolexTkMff6mtLPYgCHnVFYlAdeCDSn/lV789gmj2kjbhSLxzFa48A4dYv0W5dnITIx9HxFhnaehZPj7mp1uzGs+PUuIPxjGz07SppVlkIEHMBqhCKMVHARc6Zao4TzD4mHS+X5rw0uMLVa09FwaM+t8pop8ftKyRWVG2k6ZhP/kX8NnjiGxHlwD27eEg93HmrLIO+9JRsdXybhxDv1K6B81gsC6kiu0lIRI6GYlitYGOS2fzyoMixpub3eZbsdwjqjxeb/lVjDWZzfE9Y/595tugNSx+X8fev5Qs8S62qmJEG3nxouzbifYJAVinGdOuiy0GMlf2DCrSszinx/KqnXgcgValk5jLxQv7N+d2rmIpZE8Ypf7GUabUkBHASPNn55ljUsL9xHmgwinJWzBRCEqdePioORGos2KxHYDr40iBnmPTcvB/K5Ne+DYkskGfbwGt
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4342.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(6512007)(6506007)(53546011)(33964004)(2906002)(26005)(86362001)(31696002)(38100700002)(508600001)(966005)(45080400002)(6486002)(8936002)(36756003)(30864003)(6666004)(166002)(5660300002)(8676002)(66476007)(66946007)(66556008)(83380400001)(31686004)(66574015)(316002)(186003)(6636002)(110136005)(2616005)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WmpYVVZrNUtPU1Z6OFlWaWREMVYzVUVpZHRoRHlRcnZrRFRiT1JNaXhubVZ6?=
 =?utf-8?B?aThTZTJzdGV3ZE1aMEpJMWNvSjFzVDlKTEh5UURsM3RHd2h6b3J4RGVWNmtm?=
 =?utf-8?B?Sis2Qlc2MmtxaCt5OW9mUkZKYUNpQVA3ejRzMFp1azhxVzBDcnBvYTMzSTVH?=
 =?utf-8?B?REFES1BpdHphMCtqUWZKbEEvK3MvRHZMZy9PM3VudHNYc0lINDhTTytaZ0tq?=
 =?utf-8?B?NWJGUFkzQy85ajlqdkdEWlROaC94ZlpKV1JYUXU5cUlKLzcraTZVMXdZdjJK?=
 =?utf-8?B?SDNsL2JjZzF6V3EraXVkNVlYdm11YTgvdFZadmpvaWs1Sk9Qa2c3OUQ0QTFy?=
 =?utf-8?B?ek5UQWxiYXhoUk03a2RIVjhsRU1FVDNrb0ZKNFVnT2VHbG9tdWRzbnRWS3RD?=
 =?utf-8?B?U3UreFRTY1FLR0lWNzFEY3Y1TTdPK2VzeG4xdHIzY3dEck9JVUkzNU5WWUJM?=
 =?utf-8?B?dExSUjVKZkpmOCt3SU5IOC8xUnZVdUxta09KRnJGemhLSjlXaVkvMHl4WGJO?=
 =?utf-8?B?VE9zNjdZb3hIUHVUMlJhcXV2K2N0dlRSZ2pCTElabDEwc1hiT2xKNHA1R0ha?=
 =?utf-8?B?MVJGdjU3cGVlSzJrZzIvK1JGS2I4VG0vc3V3SjUrcGpocFdIbGptRU9XVURh?=
 =?utf-8?B?ZGhYbHBxczJVYUJFSkVDcFFKMGhEcWJxemZJN2o2TGVkWlNOWmhHcUFSNUp3?=
 =?utf-8?B?YTczSWU4eElSYWZ3aGtjYWY4ZnNNR2ovWmFtZ1cwVjIyM1E0S1RjUENpQjN2?=
 =?utf-8?B?MzEvS1UyZXJVU2IzY0xXa1RhYW9hL3RHTmZtN1NkNFdDSk8ySWVHY3d6S2cv?=
 =?utf-8?B?cFdBQkVoTGNkRStvcEFrZWlEaWRPdnJUQk1Mc2t1K1dpd043RmFGRll2MjZM?=
 =?utf-8?B?SVpOc1ZDNitQMW00dFdMU29kN3BhcVYvSWVUU0F5QVVQRTQ4TjFoNjlaY2Vr?=
 =?utf-8?B?K1A0b29vMVZBbWczcm1ucHA0MDdIbU0vVjhzeEtVMXRGbU93Ui9UNGRLSG5V?=
 =?utf-8?B?V3A1WFlSMXE3UU9MSjhRT1k2TDRaOE5VTHBXRHU2U1U4K2hRZC8zLzF1bWhN?=
 =?utf-8?B?dlpxRWhYd3V6VVhuaFg5VW45a2pjN2JTalBiVTdvWWxLU0VTOUhWNWVmUUZE?=
 =?utf-8?B?RldFRlRqcnlJRHB5RlFHT2xnaTZBZWhDanVoSXQvZTA5aHhZczVaYnpVRzg5?=
 =?utf-8?B?bmhpRFJ3bkFKcUM1Vmw1Si94R1BHblk4T1hqWVI2TGpUWXdha1B4OHdoSi9r?=
 =?utf-8?B?QlV0Ym8zV3gyakdaMkc5b0Rzd25JbmVMRGY5YTltbzVIS2xFaXR6QU93VTBZ?=
 =?utf-8?B?RVMrTkxObWduVEhiOTFNNUEvUTUwdkZVS3lpdW1lNWFqYitoNk1JdXJESE4y?=
 =?utf-8?B?NFZra25ORVZCbE9kd0tmZGwxRGE2TWozZkZpOTM0bXF2TThLemNZdWh0UEt2?=
 =?utf-8?B?S2xyNVNhNGtGTHFGRkdBVk9uRVBSaGxLMGEveDlkN3hRYmlaUnJlclltYjM2?=
 =?utf-8?B?SGRWR0s1TnM1REFERmVUTVJlSGdzbGxtclFYenFvY1Rsb0FKVzlVa1pQRVNO?=
 =?utf-8?B?M01mTVN3ZmxSVVZMUFhIc01FVFIrc3ZMV2NqaFhsSlFyUk85eHk2WmZVVk1O?=
 =?utf-8?B?YUoyTzNZRytXbU05OEtMM2cydm10QlRQTGxhNG9uTU9MMTdNWlhOMTRoNTNt?=
 =?utf-8?B?aFM3SnNsQmFyVGhhb2hRSFkvajBkcXJ3WFJvU05Ubm5kangwYzdhRGluTXJj?=
 =?utf-8?B?V2cwbnlhNU5pRU9rNURLSlh4UzlibytTMENqN3hhYjJPc053YnJvWGw2MkZE?=
 =?utf-8?B?bnlwRnpEVDl4Q1RQWFp1ekN2a0JxUXVjeHdtM0hWbW1pRHBVSVZlTEVqaTBl?=
 =?utf-8?B?T0JuaVU2K1E5eCtGUDg1bmFnaGVPdytvVWlSZE1Lb3E5VWcwclJYOEZGVUR4?=
 =?utf-8?B?N1kwSkxpTVNBSXBHOVBnNVo2TzRBRENrUG9sdVFaNE1vd2QwVEdQZHVTNkRo?=
 =?utf-8?B?YzZWQ0JqdkFibUlzNEc1SDYxRDNyRDI5WTBEczdvMHFHZTdOdnVXanRuWktQ?=
 =?utf-8?B?c3FhQ2VjMS8xYVR3VituTGo1UVZCZ2NIb20ySURBcklNMjlFZENHNlV3dHZa?=
 =?utf-8?B?MWpqTnpYTHNveEkvTEEyQ1owZDcrTEJ1NjlYakJEckpRYm1Wa0RoeFFUVHRu?=
 =?utf-8?B?cEN5cFE5Y0dJZHVJWmhaY1l6MENhWGljRmRqWEEzYVp4WmZ3NDZYYUMvcFVm?=
 =?utf-8?B?VUl5dUp3Q055VVd3TEhacFpoeS9HV2ZNcFhhZUtGY0NFZFFteHNDUEZWQ1VG?=
 =?utf-8?B?RkZ1VmJxbXpUSG1maGxOeUJoMHRGcU5qaVdkWWNwTTlmSGprMlV4Zz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59a99ba0-aa02-45b9-2ce2-08da2c2158c9
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4342.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2022 09:51:36.4905 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xfs/je9/BAK1HD7O9qqqS+P8/EZ/HoXR2cseh/ArDcO+ZfzVMfneqois77UjpAI/DRTJCkMf0yqn9pWqaXF68Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1198
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

--------------0TFk0kqSvp5eODqzlMUj0uR2
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 5/2/2022 11:26 AM, Christian König wrote:
> Am 01.05.22 um 21:45 schrieb Arunpravin Paneer Selvam:
>>
>> On 5/1/2022 12:59 AM, Christian König wrote:
>>> Am 30.04.22 um 17:14 schrieb Arunpravin Paneer Selvam:
>>>> - Add pipe and queue as out parameters to support high priority
>>>>    queue test enabled in libdrm basic test suite.
>>>>
>>>> - Fetch amdgpu_ring pointer and pass sched info to userspace
>>>>
>>>> - Improve amdgpu_sched_ioctl() function
>>>>
>>>> The related merge request for enabling high priority test case are
>>>> libdrm - 
>>>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgitlab.freedesktop.org%2Fmesa%2Fdrm%2F-%2Fmerge_requests%2F235&amp;data=05%7C01%7CArunpravin.PaneerSelvam%40amd.com%7Ce7a876029be4439b742808da2adfb82a%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637869437601696844%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=jXIBtdA4seXl%2BYKsY2SDu%2B9tPoH6tfvUUXIRl4IosJc%3D&amp;reserved=0
>>>> mesa - 
>>>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgitlab.freedesktop.org%2Fmesa%2Fmesa%2F-%2Fmerge_requests%2F16262&amp;data=05%7C01%7CArunpravin.PaneerSelvam%40amd.com%7Ce7a876029be4439b742808da2adfb82a%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637869437601696844%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=%2F%2FwMJ86SXxP7K9STA%2B1x5rox1F5CPEy3JIhFMCjqwiY%3D&amp;reserved=0
>>>>
>>>> Signed-off-by: Arunpravin Paneer Selvam 
>>>> <Arunpravin.PaneerSelvam@amd.com>
>>>
>>> Well that is certainly a NAK since as far as I can see this breaks 
>>> the UAPI in a not backward compatible way.
>>>
>>> Then we absolutely should not pass scheduler info to userspace. That 
>>> should be completely transparent to userspace.
>>>
>>> So can you summarize once more why that should be necessary?
>> I added a new test case named high priority queue test in libdrm 
>> basic test suite to validate the kernel feature patch named
>> high priority gfx pipe. In the test case, we are creating a context 
>> and overriding the priority as HIGH, submitting a simple NOP
>> command to test the job scheduled on high priority pipe / queue. This 
>> we have manually verified using the sysfs entry
>> amdgpu_fence_info where fence signaled on gfx high priority pipe 
>> (gfx_0.1.0). To ensure this in a unit test case, we require
>> pipe and queue info.
>
> Completely drop that requirement, it's not even remotely valid 
> justification for an UAPI change.
>
> The IOCTLs are for supporting userspace APIs like OpenGL, Vulkan, 
> VA-API etc.. and *not* unit tests.
>
> If you need additional information for unit tests we need to add that 
> to debugfs instead and as you wrote we already have that in the form 
> of the amdgpu_fence_info file.
sure, we will drop this requirement.

Hi Alex,
I verified the sysfs entry amdgpu_fence_info, a submitted high priority 
job fence signaled on gfx_0.1.0, shall we push the kernel patch named 
Enable high priority gfx queue
into staging branch.

Thanks,
Arun.
>
> Regards,
> Christian.
>
>>
>> Thanks,
>> Arun
>>>
>>> Regards,
>>> Christian.
>>>
>>>> ---
>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c | 114 
>>>> ++++++++--------------
>>>>   include/uapi/drm/amdgpu_drm.h             |  14 ++-
>>>>   2 files changed, 53 insertions(+), 75 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c 
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c
>>>> index e9b45089a28a..fc2864b612d9 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c
>>>> @@ -32,106 +32,72 @@
>>>>   #include "amdgpu_sched.h"
>>>>   #include "amdgpu_vm.h"
>>>>   -static int amdgpu_sched_process_priority_override(struct 
>>>> amdgpu_device *adev,
>>>> -                          int fd,
>>>> -                          int32_t priority)
>>>> +int amdgpu_sched_ioctl(struct drm_device *dev, void *data,
>>>> +               struct drm_file *filp)
>>>>   {
>>>> -    struct fd f = fdget(fd);
>>>> +    union drm_amdgpu_sched *args = data;
>>>> +    struct amdgpu_ctx *ctx, *ctx_ptr;
>>>> +    struct drm_sched_entity *entity;
>>>>       struct amdgpu_fpriv *fpriv;
>>>> -    struct amdgpu_ctx *ctx;
>>>> -    uint32_t id;
>>>> -    int r;
>>>> -
>>>> -    if (!f.file)
>>>> -        return -EINVAL;
>>>> -
>>>> -    r = amdgpu_file_to_fpriv(f.file, &fpriv);
>>>> -    if (r) {
>>>> -        fdput(f);
>>>> -        return r;
>>>> -    }
>>>> -
>>>> -    idr_for_each_entry(&fpriv->ctx_mgr.ctx_handles, ctx, id)
>>>> -        amdgpu_ctx_priority_override(ctx, priority);
>>>> -
>>>> -    fdput(f);
>>>> -    return 0;
>>>> -}
>>>> -
>>>> -static int amdgpu_sched_context_priority_override(struct 
>>>> amdgpu_device *adev,
>>>> -                          int fd,
>>>> -                          unsigned ctx_id,
>>>> -                          int32_t priority)
>>>> -{
>>>> +    struct amdgpu_ring *ring;
>>>> +    u32 fd = args->in.fd;
>>>>       struct fd f = fdget(fd);
>>>> -    struct amdgpu_fpriv *fpriv;
>>>> -    struct amdgpu_ctx *ctx;
>>>> +    u32 id;
>>>>       int r;
>>>>         if (!f.file)
>>>>           return -EINVAL;
>>>>         r = amdgpu_file_to_fpriv(f.file, &fpriv);
>>>> -    if (r) {
>>>> -        fdput(f);
>>>> -        return r;
>>>> -    }
>>>> +    if (r)
>>>> +        goto out_fd;
>>>>   -    ctx = amdgpu_ctx_get(fpriv, ctx_id);
>>>> +    ctx = amdgpu_ctx_get(fpriv, args->in.ctx_id);
>>>>         if (!ctx) {
>>>> -        fdput(f);
>>>> -        return -EINVAL;
>>>> -    }
>>>> -
>>>> -    amdgpu_ctx_priority_override(ctx, priority);
>>>> -    amdgpu_ctx_put(ctx);
>>>> -    fdput(f);
>>>> -
>>>> -    return 0;
>>>> -}
>>>> -
>>>> -int amdgpu_sched_ioctl(struct drm_device *dev, void *data,
>>>> -               struct drm_file *filp)
>>>> -{
>>>> -    union drm_amdgpu_sched *args = data;
>>>> -    struct amdgpu_device *adev = drm_to_adev(dev);
>>>> -    int r;
>>>> -
>>>> -    /* First check the op, then the op's argument.
>>>> -     */
>>>> -    switch (args->in.op) {
>>>> -    case AMDGPU_SCHED_OP_PROCESS_PRIORITY_OVERRIDE:
>>>> -    case AMDGPU_SCHED_OP_CONTEXT_PRIORITY_OVERRIDE:
>>>> -        break;
>>>> -    default:
>>>> -        DRM_ERROR("Invalid sched op specified: %d\n", args->in.op);
>>>> -        return -EINVAL;
>>>> +        r = -EINVAL;
>>>> +        goto out_fd;
>>>>       }
>>>>         if (!amdgpu_ctx_priority_is_valid(args->in.priority)) {
>>>>           WARN(1, "Invalid context priority %d\n", args->in.priority);
>>>> -        return -EINVAL;
>>>> +        r = -EINVAL;
>>>> +        goto out_ctx;
>>>>       }
>>>>         switch (args->in.op) {
>>>>       case AMDGPU_SCHED_OP_PROCESS_PRIORITY_OVERRIDE:
>>>> -        r = amdgpu_sched_process_priority_override(adev,
>>>> -                               args->in.fd,
>>>> -                               args->in.priority);
>>>> +        /* Retrieve all ctx handles and override priority */
>>>> + idr_for_each_entry(&fpriv->ctx_mgr.ctx_handles, ctx_ptr, id)
>>>> +            amdgpu_ctx_priority_override(ctx_ptr, args->in.priority);
>>>>           break;
>>>>       case AMDGPU_SCHED_OP_CONTEXT_PRIORITY_OVERRIDE:
>>>> -        r = amdgpu_sched_context_priority_override(adev,
>>>> -                               args->in.fd,
>>>> -                               args->in.ctx_id,
>>>> -                               args->in.priority);
>>>> +        /* Override priority for a given context */
>>>> +        amdgpu_ctx_priority_override(ctx, args->in.priority);
>>>>           break;
>>>>       default:
>>>> -        /* Impossible.
>>>> -         */
>>>> +        DRM_ERROR("Invalid sched op specified: %d\n", args->in.op);
>>>>           r = -EINVAL;
>>>> -        break;
>>>> +        goto out_ctx;
>>>>       }
>>>>   +    r = amdgpu_ctx_get_entity(ctx, args->in.ip_type, 0, 
>>>> args->in.ring,
>>>> +                  &entity);
>>>> +    if (r)
>>>> +        goto out_ctx;
>>>> +
>>>> +    /* Fetch amdgpu_ring pointer */
>>>> +    ring = to_amdgpu_ring(entity->rq->sched);
>>>> +
>>>> +    /* Pass sched info to userspace */
>>>> +    memset(args, 0, sizeof(*args));
>>>> +    args->out.info.pipe = ring->pipe;
>>>> +    args->out.info.queue = ring->queue;
>>>> +
>>>> +out_ctx:
>>>> +    amdgpu_ctx_put(ctx);
>>>> +out_fd:
>>>> +    fdput(f);
>>>> +
>>>>       return r;
>>>>   }
>>>> diff --git a/include/uapi/drm/amdgpu_drm.h 
>>>> b/include/uapi/drm/amdgpu_drm.h
>>>> index 1d65c1fbc4ec..e93f1b6c4561 100644
>>>> --- a/include/uapi/drm/amdgpu_drm.h
>>>> +++ b/include/uapi/drm/amdgpu_drm.h
>>>> @@ -70,7 +70,7 @@ extern "C" {
>>>>   #define DRM_IOCTL_AMDGPU_WAIT_FENCES DRM_IOWR(DRM_COMMAND_BASE + 
>>>> DRM_AMDGPU_WAIT_FENCES, union drm_amdgpu_wait_fences)
>>>>   #define DRM_IOCTL_AMDGPU_VM DRM_IOWR(DRM_COMMAND_BASE + 
>>>> DRM_AMDGPU_VM, union drm_amdgpu_vm)
>>>>   #define DRM_IOCTL_AMDGPU_FENCE_TO_HANDLE 
>>>> DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_FENCE_TO_HANDLE, union 
>>>> drm_amdgpu_fence_to_handle)
>>>> -#define DRM_IOCTL_AMDGPU_SCHED DRM_IOW(DRM_COMMAND_BASE + 
>>>> DRM_AMDGPU_SCHED, union drm_amdgpu_sched)
>>>> +#define DRM_IOCTL_AMDGPU_SCHED DRM_IOWR(DRM_COMMAND_BASE + 
>>>> DRM_AMDGPU_SCHED, union drm_amdgpu_sched)
>>>>     /**
>>>>    * DOC: memory domains
>>>> @@ -308,6 +308,11 @@ union drm_amdgpu_vm {
>>>>   #define AMDGPU_SCHED_OP_PROCESS_PRIORITY_OVERRIDE    1
>>>>   #define AMDGPU_SCHED_OP_CONTEXT_PRIORITY_OVERRIDE    2
>>>>   +struct drm_amdgpu_sched_info {
>>>> +    __u32 pipe;
>>>> +    __u32 queue;
>>>> +};
>>>> +
>>>>   struct drm_amdgpu_sched_in {
>>>>       /* AMDGPU_SCHED_OP_* */
>>>>       __u32    op;
>>>> @@ -315,10 +320,17 @@ struct drm_amdgpu_sched_in {
>>>>       /** AMDGPU_CTX_PRIORITY_* */
>>>>       __s32    priority;
>>>>       __u32   ctx_id;
>>>> +    __u32   ip_type;
>>>> +    __u32   ring;
>>>> +};
>>>> +
>>>> +struct drm_amdgpu_sched_out {
>>>> +    struct drm_amdgpu_sched_info info;
>>>>   };
>>>>     union drm_amdgpu_sched {
>>>>       struct drm_amdgpu_sched_in in;
>>>> +    struct drm_amdgpu_sched_out out;
>>>>   };
>>>>     /*
>>>
>>
>

--------------0TFk0kqSvp5eODqzlMUj0uR2
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <br>
    <br>
    <div class="moz-cite-prefix">On 5/2/2022 11:26 AM, Christian König
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:54568104-c607-eb76-6c20-67e91baec00f@amd.com">
      
      Am 01.05.22 um 21:45 schrieb Arunpravin Paneer Selvam:<br>
      <blockquote type="cite" cite="mid:b42d6e3d-e646-8bcb-6166-bdb94ddd1d69@amd.com"> <br>
        On 5/1/2022 12:59 AM, Christian König wrote:<br>
        <blockquote type="cite" cite="mid:85927512-377e-39b1-d812-ef9bddcc2f02@gmail.com">Am
          30.04.22 um 17:14 schrieb Arunpravin Paneer Selvam: <br>
          <blockquote type="cite">- Add pipe and queue as out parameters
            to support high priority <br>
            &nbsp;&nbsp; queue test enabled in libdrm basic test suite. <br>
            <br>
            - Fetch amdgpu_ring pointer and pass sched info to userspace
            <br>
            <br>
            - Improve amdgpu_sched_ioctl() function <br>
            <br>
            The related merge request for enabling high priority test
            case are <br>
            libdrm - <a class="moz-txt-link-freetext" href="https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgitlab.freedesktop.org%2Fmesa%2Fdrm%2F-%2Fmerge_requests%2F235&amp;amp;data=05%7C01%7CArunpravin.PaneerSelvam%40amd.com%7Ce7a876029be4439b742808da2adfb82a%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637869437601696844%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;amp;sdata=jXIBtdA4seXl%2BYKsY2SDu%2B9tPoH6tfvUUXIRl4IosJc%3D&amp;amp;reserved=0" moz-do-not-send="true">https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgitlab.freedesktop.org%2Fmesa%2Fdrm%2F-%2Fmerge_requests%2F235&amp;amp;data=05%7C01%7CArunpravin.PaneerSelvam%40amd.com%7Ce7a876029be4439b742808da2adfb82a%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637869437601696844%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;amp;sdata=jXIBtdA4seXl%2BYKsY2SDu%2B9tPoH6
 tfvUUXIRl4IosJc%3D&amp;amp;reserved=0</a><br>
            mesa - <a class="moz-txt-link-freetext" href="https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgitlab.freedesktop.org%2Fmesa%2Fmesa%2F-%2Fmerge_requests%2F16262&amp;amp;data=05%7C01%7CArunpravin.PaneerSelvam%40amd.com%7Ce7a876029be4439b742808da2adfb82a%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637869437601696844%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;amp;sdata=%2F%2FwMJ86SXxP7K9STA%2B1x5rox1F5CPEy3JIhFMCjqwiY%3D&amp;amp;reserved=0" moz-do-not-send="true">https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgitlab.freedesktop.org%2Fmesa%2Fmesa%2F-%2Fmerge_requests%2F16262&amp;amp;data=05%7C01%7CArunpravin.PaneerSelvam%40amd.com%7Ce7a876029be4439b742808da2adfb82a%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637869437601696844%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;amp;sdata=%2F%2FwMJ86SXxP7K9STA%2B1x
 5rox1F5CPEy3JIhFMCjqwiY%3D&amp;amp;reserved=0</a><br>
            <br>
            Signed-off-by: Arunpravin Paneer Selvam <a class="moz-txt-link-rfc2396E" href="mailto:Arunpravin.PaneerSelvam@amd.com" moz-do-not-send="true">&lt;Arunpravin.PaneerSelvam@amd.com&gt;</a>
            <br>
          </blockquote>
          <br>
          Well that is certainly a NAK since as far as I can see this
          breaks the UAPI in a not backward compatible way. <br>
          <br>
          Then we absolutely should not pass scheduler info to
          userspace. That should be completely transparent to userspace.
          <br>
          <br>
          So can you summarize once more why that should be necessary?<br>
        </blockquote>
        I added a new test case named high priority queue test in libdrm
        basic test suite to validate the kernel feature patch named<br>
        <span style="mso-spacerun:yes"></span>high priority gfx pipe. In
        the test case, we are creating a context and overriding the
        priority as HIGH, submitting a simple NOP<br>
        command to test the job scheduled on high priority pipe / queue.
        This we have manually verified using the sysfs entry<br>
        amdgpu_fence_info where fence signaled on gfx high priority pipe
        (gfx_0.1.0). To ensure this in a unit test case, we require<br>
        pipe and queue info.<br>
      </blockquote>
      <br>
      Completely drop that requirement, it's not even remotely valid
      justification for an UAPI change.<br>
      <br>
      The IOCTLs are for supporting userspace APIs like OpenGL, Vulkan,
      VA-API etc.. and *not* unit tests.<br>
      <br>
      If you need additional information for unit tests we need to add
      that to debugfs instead and as you wrote we already have that in
      the form of the amdgpu_fence_info file.<br>
    </blockquote>
    sure, we will drop this requirement.<br>
    <br>
    Hi Alex,<br>
    I verified the sysfs entry amdgpu_fence_info, a submitted high
    priority job fence signaled on gfx_0.1.0, shall we push the kernel
    patch named Enable high priority gfx queue<br>
    into staging branch.<br>
    <br>
    Thanks,<br>
    Arun.<br>
    <blockquote type="cite" cite="mid:54568104-c607-eb76-6c20-67e91baec00f@amd.com"> <br>
      Regards,<br>
      Christian.<br>
      <br>
      <blockquote type="cite" cite="mid:b42d6e3d-e646-8bcb-6166-bdb94ddd1d69@amd.com"> <br>
        Thanks,<br>
        Arun<br>
        <blockquote type="cite" cite="mid:85927512-377e-39b1-d812-ef9bddcc2f02@gmail.com"> <br>
          Regards, <br>
          Christian. <br>
          <br>
          <blockquote type="cite">--- <br>
            &nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c | 114
            ++++++++-------------- <br>
            &nbsp; include/uapi/drm/amdgpu_drm.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 14 ++- <br>
            &nbsp; 2 files changed, 53 insertions(+), 75 deletions(-) <br>
            <br>
            diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c
            b/drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c <br>
            index e9b45089a28a..fc2864b612d9 100644 <br>
            --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c <br>
            +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c <br>
            @@ -32,106 +32,72 @@ <br>
            &nbsp; #include &quot;amdgpu_sched.h&quot; <br>
            &nbsp; #include &quot;amdgpu_vm.h&quot; <br>
            &nbsp; -static int amdgpu_sched_process_priority_override(struct
            amdgpu_device *adev, <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int fd, <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int32_t priority) <br>
            +int amdgpu_sched_ioctl(struct drm_device *dev, void *data,
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_file *filp) <br>
            &nbsp; { <br>
            -&nbsp;&nbsp;&nbsp; struct fd f = fdget(fd); <br>
            +&nbsp;&nbsp;&nbsp; union drm_amdgpu_sched *args = data; <br>
            +&nbsp;&nbsp;&nbsp; struct amdgpu_ctx *ctx, *ctx_ptr; <br>
            +&nbsp;&nbsp;&nbsp; struct drm_sched_entity *entity; <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_fpriv *fpriv; <br>
            -&nbsp;&nbsp;&nbsp; struct amdgpu_ctx *ctx; <br>
            -&nbsp;&nbsp;&nbsp; uint32_t id; <br>
            -&nbsp;&nbsp;&nbsp; int r; <br>
            - <br>
            -&nbsp;&nbsp;&nbsp; if (!f.file) <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL; <br>
            - <br>
            -&nbsp;&nbsp;&nbsp; r = amdgpu_file_to_fpriv(f.file, &amp;fpriv); <br>
            -&nbsp;&nbsp;&nbsp; if (r) { <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fdput(f); <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r; <br>
            -&nbsp;&nbsp;&nbsp; } <br>
            - <br>
            -&nbsp;&nbsp;&nbsp; idr_for_each_entry(&amp;fpriv-&gt;ctx_mgr.ctx_handles,
            ctx, id) <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ctx_priority_override(ctx, priority); <br>
            - <br>
            -&nbsp;&nbsp;&nbsp; fdput(f); <br>
            -&nbsp;&nbsp;&nbsp; return 0; <br>
            -} <br>
            - <br>
            -static int amdgpu_sched_context_priority_override(struct
            amdgpu_device *adev, <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int fd, <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned ctx_id, <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int32_t priority) <br>
            -{ <br>
            +&nbsp;&nbsp;&nbsp; struct amdgpu_ring *ring; <br>
            +&nbsp;&nbsp;&nbsp; u32 fd = args-&gt;in.fd; <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct fd f = fdget(fd); <br>
            -&nbsp;&nbsp;&nbsp; struct amdgpu_fpriv *fpriv; <br>
            -&nbsp;&nbsp;&nbsp; struct amdgpu_ctx *ctx; <br>
            +&nbsp;&nbsp;&nbsp; u32 id; <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int r; <br>
            &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!f.file) <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL; <br>
            &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r = amdgpu_file_to_fpriv(f.file, &amp;fpriv); <br>
            -&nbsp;&nbsp;&nbsp; if (r) { <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fdput(f); <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r; <br>
            -&nbsp;&nbsp;&nbsp; } <br>
            +&nbsp;&nbsp;&nbsp; if (r) <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto out_fd; <br>
            &nbsp; -&nbsp;&nbsp;&nbsp; ctx = amdgpu_ctx_get(fpriv, ctx_id); <br>
            +&nbsp;&nbsp;&nbsp; ctx = amdgpu_ctx_get(fpriv, args-&gt;in.ctx_id); <br>
            &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!ctx) { <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fdput(f); <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL; <br>
            -&nbsp;&nbsp;&nbsp; } <br>
            - <br>
            -&nbsp;&nbsp;&nbsp; amdgpu_ctx_priority_override(ctx, priority); <br>
            -&nbsp;&nbsp;&nbsp; amdgpu_ctx_put(ctx); <br>
            -&nbsp;&nbsp;&nbsp; fdput(f); <br>
            - <br>
            -&nbsp;&nbsp;&nbsp; return 0; <br>
            -} <br>
            - <br>
            -int amdgpu_sched_ioctl(struct drm_device *dev, void *data,
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_file *filp) <br>
            -{ <br>
            -&nbsp;&nbsp;&nbsp; union drm_amdgpu_sched *args = data; <br>
            -&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev = drm_to_adev(dev); <br>
            -&nbsp;&nbsp;&nbsp; int r; <br>
            - <br>
            -&nbsp;&nbsp;&nbsp; /* First check the op, then the op's argument. <br>
            -&nbsp;&nbsp;&nbsp;&nbsp; */ <br>
            -&nbsp;&nbsp;&nbsp; switch (args-&gt;in.op) { <br>
            -&nbsp;&nbsp;&nbsp; case AMDGPU_SCHED_OP_PROCESS_PRIORITY_OVERRIDE: <br>
            -&nbsp;&nbsp;&nbsp; case AMDGPU_SCHED_OP_CONTEXT_PRIORITY_OVERRIDE: <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break; <br>
            -&nbsp;&nbsp;&nbsp; default: <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_ERROR(&quot;Invalid sched op specified: %d\n&quot;,
            args-&gt;in.op); <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL; <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r = -EINVAL; <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto out_fd; <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } <br>
            &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if
            (!amdgpu_ctx_priority_is_valid(args-&gt;in.priority)) { <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WARN(1, &quot;Invalid context priority %d\n&quot;,
            args-&gt;in.priority); <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL; <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r = -EINVAL; <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto out_ctx; <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } <br>
            &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (args-&gt;in.op) { <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMDGPU_SCHED_OP_PROCESS_PRIORITY_OVERRIDE: <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r = amdgpu_sched_process_priority_override(adev, <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; args-&gt;in.fd, <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; args-&gt;in.priority); <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Retrieve all ctx handles and override priority&nbsp;
            */ <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            idr_for_each_entry(&amp;fpriv-&gt;ctx_mgr.ctx_handles,
            ctx_ptr, id) <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ctx_priority_override(ctx_ptr,
            args-&gt;in.priority); <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break; <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMDGPU_SCHED_OP_CONTEXT_PRIORITY_OVERRIDE: <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r = amdgpu_sched_context_priority_override(adev, <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; args-&gt;in.fd, <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; args-&gt;in.ctx_id, <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; args-&gt;in.priority); <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Override priority for a given context */ <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ctx_priority_override(ctx,
            args-&gt;in.priority); <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break; <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default: <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Impossible. <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */ <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_ERROR(&quot;Invalid sched op specified: %d\n&quot;,
            args-&gt;in.op); <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r = -EINVAL; <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break; <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto out_ctx; <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } <br>
            &nbsp; +&nbsp;&nbsp;&nbsp; r = amdgpu_ctx_get_entity(ctx, args-&gt;in.ip_type,
            0, args-&gt;in.ring, <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;entity); <br>
            +&nbsp;&nbsp;&nbsp; if (r) <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto out_ctx; <br>
            + <br>
            +&nbsp;&nbsp;&nbsp; /* Fetch amdgpu_ring pointer */ <br>
            +&nbsp;&nbsp;&nbsp; ring = to_amdgpu_ring(entity-&gt;rq-&gt;sched); <br>
            + <br>
            +&nbsp;&nbsp;&nbsp; /* Pass sched info to userspace */ <br>
            +&nbsp;&nbsp;&nbsp; memset(args, 0, sizeof(*args)); <br>
            +&nbsp;&nbsp;&nbsp; args-&gt;out.info.pipe = ring-&gt;pipe; <br>
            +&nbsp;&nbsp;&nbsp; args-&gt;out.info.queue = ring-&gt;queue; <br>
            + <br>
            +out_ctx: <br>
            +&nbsp;&nbsp;&nbsp; amdgpu_ctx_put(ctx); <br>
            +out_fd: <br>
            +&nbsp;&nbsp;&nbsp; fdput(f); <br>
            + <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r; <br>
            &nbsp; } <br>
            diff --git a/include/uapi/drm/amdgpu_drm.h
            b/include/uapi/drm/amdgpu_drm.h <br>
            index 1d65c1fbc4ec..e93f1b6c4561 100644 <br>
            --- a/include/uapi/drm/amdgpu_drm.h <br>
            +++ b/include/uapi/drm/amdgpu_drm.h <br>
            @@ -70,7 +70,7 @@ extern &quot;C&quot; { <br>
            &nbsp; #define DRM_IOCTL_AMDGPU_WAIT_FENCES&nbsp;&nbsp;&nbsp;
            DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_WAIT_FENCES, union
            drm_amdgpu_wait_fences) <br>
            &nbsp; #define DRM_IOCTL_AMDGPU_VM&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_VM, union
            drm_amdgpu_vm) <br>
            &nbsp; #define DRM_IOCTL_AMDGPU_FENCE_TO_HANDLE
            DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_FENCE_TO_HANDLE,
            union drm_amdgpu_fence_to_handle) <br>
            -#define DRM_IOCTL_AMDGPU_SCHED&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            DRM_IOW(DRM_COMMAND_BASE + DRM_AMDGPU_SCHED, union
            drm_amdgpu_sched) <br>
            +#define DRM_IOCTL_AMDGPU_SCHED&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_SCHED, union
            drm_amdgpu_sched) <br>
            &nbsp; &nbsp; /** <br>
            &nbsp;&nbsp; * DOC: memory domains <br>
            @@ -308,6 +308,11 @@ union drm_amdgpu_vm { <br>
            &nbsp; #define AMDGPU_SCHED_OP_PROCESS_PRIORITY_OVERRIDE&nbsp;&nbsp;&nbsp; 1 <br>
            &nbsp; #define AMDGPU_SCHED_OP_CONTEXT_PRIORITY_OVERRIDE&nbsp;&nbsp;&nbsp; 2 <br>
            &nbsp; +struct drm_amdgpu_sched_info { <br>
            +&nbsp;&nbsp;&nbsp; __u32 pipe; <br>
            +&nbsp;&nbsp;&nbsp; __u32 queue; <br>
            +}; <br>
            + <br>
            &nbsp; struct drm_amdgpu_sched_in { <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* AMDGPU_SCHED_OP_* */ <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __u32&nbsp;&nbsp;&nbsp; op; <br>
            @@ -315,10 +320,17 @@ struct drm_amdgpu_sched_in { <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /** AMDGPU_CTX_PRIORITY_* */ <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __s32&nbsp;&nbsp;&nbsp; priority; <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __u32&nbsp;&nbsp; ctx_id; <br>
            +&nbsp;&nbsp;&nbsp; __u32&nbsp;&nbsp; ip_type; <br>
            +&nbsp;&nbsp;&nbsp; __u32&nbsp;&nbsp; ring; <br>
            +}; <br>
            + <br>
            +struct drm_amdgpu_sched_out { <br>
            +&nbsp;&nbsp;&nbsp; struct drm_amdgpu_sched_info info; <br>
            &nbsp; }; <br>
            &nbsp; &nbsp; union drm_amdgpu_sched { <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_amdgpu_sched_in in; <br>
            +&nbsp;&nbsp;&nbsp; struct drm_amdgpu_sched_out out; <br>
            &nbsp; }; <br>
            &nbsp; &nbsp; /* <br>
          </blockquote>
          <br>
        </blockquote>
        <br>
      </blockquote>
      <br>
    </blockquote>
    <br>
  </body>
</html>

--------------0TFk0kqSvp5eODqzlMUj0uR2--
