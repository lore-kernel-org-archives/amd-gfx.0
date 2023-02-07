Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6172DC636CD
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Feb 2023 07:38:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C8AB210E2F6;
	Tue,  7 Feb 2023 07:38:16 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20619.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::619])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 958CD10E2F6
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Feb 2023 07:38:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jfVGpnbh4QL6332TD9G0Q9RPD/8EQeOIfCo9bevwkRMghg62JY7iCOlJOA9wTNckHK5/Az/Aoewca7Hv/ZSGvxMkU8XjskqOxxt2srufa/hjm5LjCDHFMKoAlHvMGqe7KtYXX8UiOViY8hh1pPSue/iAwM+sOuWFGv/nuTi6cdVevJV4wZr1KUNz+E0yC5OBMTdmuAABkLLspOJXBNEWD2TroidWyrghAW5wNet0M9yzzqJPcfZywUJNLOs3BPuT3rFOvyvNx4bTvvnXwqIJJ9Bq9yY3J9wv8nEEuzuP2+vy8Mz66IZCHqFn5lQ7difWKU5VWnQ3v3iPe6AVw71S9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=riBu6xYf3DLW5jzzZIKUg+fvMNChXetwQMI/bwULPDs=;
 b=BTSAqmepjrdZu91J0Dqpp54xk5mqtLGO4cn6yTrWAWDqNFSYDVR2wk9IeUyXy8uzzz8GL2sYOVG+MnOVZOCM6nwAfrLoaO8jhH3MLrMdmgMy2eiDkivAFpNLkk3XoSnYOXQKTPuDM/tZmtxHBS3ntzg/nTWloI7YctEiq04yJuPFEa8QSN2IIBkbR6VjJtf/Tf5tM6XCqogDOgDvCmeSXAz5KwvvWeshODsCUQoPMAwwaZMbiZxrSMk/E56vpi+E64TOlyFP8gdftJqUx29F09SbIDImrzhFZrqtknqg5VeS+64t7wE3x5PlPdHslwq2jO1WP3Ua3iaDBb5mZeF4Kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=riBu6xYf3DLW5jzzZIKUg+fvMNChXetwQMI/bwULPDs=;
 b=KKMssBkd2SBqgVVIUWJOOps5SCS1bquPXut/lfftfefkITciRgtvDw9xjAGP8jVxu351R2+piM0dYAwysEMPFzdTEhyF2mBVGFQSgeAXrubCK4TpOByCGJuRnPj+qFCKOUFoO4oobgpsm4UtdTiYkwmGkhBNqh9IZQl6RT58MEY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB5667.namprd12.prod.outlook.com (2603:10b6:303:18a::10)
 by SN7PR12MB7884.namprd12.prod.outlook.com (2603:10b6:806:343::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.34; Tue, 7 Feb
 2023 07:38:13 +0000
Received: from MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::d1c8:8b04:20ba:9d6f]) by MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::d1c8:8b04:20ba:9d6f%4]) with mapi id 15.20.6064.034; Tue, 7 Feb 2023
 07:38:13 +0000
Message-ID: <e5762028-238e-f317-8ba7-9c284d7a80af@amd.com>
Date: Tue, 7 Feb 2023 08:38:05 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 1/8] drm/amdgpu: UAPI for user queue management
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Alex Deucher <alexdeucher@gmail.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
References: <20230203215409.2021-1-shashank.sharma@amd.com>
 <20230203215409.2021-2-shashank.sharma@amd.com>
 <CADnq5_MSMivTzo0k+wJj+bGpsQZ3HEDVt5XqzjGdBiv08fFWCQ@mail.gmail.com>
 <95ac9ea3-47c8-744c-7fd7-ddc54b19926f@amd.com>
 <CADnq5_M9q0R=d=KU8P4oVOCY0Gw97Uhzy6Mrg0GgxeROGn6xrQ@mail.gmail.com>
 <afce1a57-8007-5d1b-0715-9756d7d07153@amd.com>
 <CADnq5_P8UJYvnH_kWcPY2hfnhU3Ppo-3RoQAU5Ohf1T841kvzQ@mail.gmail.com>
 <bb992153-fa99-7b50-a188-e49a8d673439@gmail.com>
From: Shashank Sharma <shashank.sharma@amd.com>
In-Reply-To: <bb992153-fa99-7b50-a188-e49a8d673439@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0026.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::13) To MW4PR12MB5667.namprd12.prod.outlook.com
 (2603:10b6:303:18a::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB5667:EE_|SN7PR12MB7884:EE_
X-MS-Office365-Filtering-Correlation-Id: 8879e4ab-5096-4772-e789-08db08de4459
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tCCnHsGtPuEHSqIXc/L2QWnsmqv0E5aEWlqcjDKGj/u9ltiteN49MN497QkX0tfWbCtAtsW0QbSzH/+v5JCjSPY3gvIE78TJ8uq3JhKf6rkSpzmuQHcJxrHtunhCDziH+dP8HfmORnYtaMwnuwJoslBxSSVEcJnfuK799wRBoseHG4DjYdAMP7LpvwvYqnZIs1SSfMw2/uwP9qqyJf/r5o9sswfz5iG5opH9UYq7rYPpWbUVj59NuXm4p80Il99ASuL2Fgwn4IbvlgjQTFJ9zMYyyhf9QYHn8V39m1a2Cfdn8ch+3UfvOspXAii5yY0WFboFeMulsFwnbe3HsngUG/Y82H1jHC3TWprolBhHfqkoiJokxkF/lRZJJl+QDuTeCz6Qqn60PJigrBu4+0WoRFIcCB04+to1ISL4OCMy/NXeyCXNeZDLLVGglg9damYzpypY1RYb51m43IMb970WMWPUvZGE5vYiyU7q+7bbwRJccRfKFDB9XQ3YCY5xBDhXUN3RnIn1cybzCIn37lju7X9Hv1GJ9lHytdAYH+bOwO2ywFCQ3jGX/5aC+gBF1P/4iTdN+9pm0NULlYtZFJS2aWfsU7lsFp5lHJOsiu8vFJfNw91tC600er5yR/GgEWwtuP/05kXKbFILXv+R5ZlbEvir744BMEIJBCRHB1pqFG8j5eJgG3mntZggTID+niKWRs8PPK4DqgMgr4RYEjix62qJD0N8DmQcqvZMcxlbEWY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB5667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(39860400002)(366004)(396003)(136003)(346002)(376002)(451199018)(110136005)(86362001)(6636002)(316002)(53546011)(6512007)(2616005)(186003)(38100700002)(66574015)(26005)(83380400001)(36756003)(478600001)(6506007)(6486002)(6666004)(31696002)(41300700001)(31686004)(5660300002)(8936002)(2906002)(44832011)(4326008)(66476007)(66556008)(66946007)(8676002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RTlZVC9oMXZoWTBmRlh4Yml2TXUrMGNmRXdhUFluZjNFa01PNTg3QWUwZS9v?=
 =?utf-8?B?S09mQ2pROWJ4WllxbjlvaVp6dkF3aHRPaXdZTnU1bTZ4Z0FSc1UyT0I2VFBw?=
 =?utf-8?B?Wm5RQWpXT0dmajBlR2NXM21BWUhhMk9Qc3VRT3FTY1NYS2dXbE1MaStzS0oz?=
 =?utf-8?B?azRXalNTQkt0Rm5COWJMSVNrNUVMcm8vVUFob1pOeUp4WnMrdjI0K2s0MnFy?=
 =?utf-8?B?SFdGUmlGTWlPWEtvNjR5MkdqSGcycmpzZGpBb0R0d2JKOGpUdjNCWjBWRTFr?=
 =?utf-8?B?b3duL0NnVjBoVXpZUWp0UGgwc0JxeGVONm1MTDhjZ0JDTDRrSDhLaWxTMVdI?=
 =?utf-8?B?Qmx0b0NtWmVNZHQxMzJadXR6UzYzWmJEd3pOMmIrZ3NxUVFDRHpYbG9ZTUpD?=
 =?utf-8?B?TWxHL2srUi9sZWRVdllvakRlbVBrL3N1Wmc1UTR2UEVVN0t3NXhlcTZvdkxX?=
 =?utf-8?B?bTZObzRIZUpKOHIrbEZPU0dNcnZkR2R5QjA3VlNjN2YxNktsYjhwQjVvVmN3?=
 =?utf-8?B?NTExL1Q2blcxRk1tbzN5NFhVVmRMeUpiVUN6azRhV0lsajZ6Q3FDM3hVeGZy?=
 =?utf-8?B?NjJCd3dxT1hMbHlTMyswYWx2YWJiU29BUFlST2ZzajFjSzgyYWFpQ0krZ1hM?=
 =?utf-8?B?cmNOMGRyN3JoRXRIanZ3bitVaG1rcHhkbVdONTFvUjdSZ25jSllVbVhZR0lK?=
 =?utf-8?B?L2hLT1pGaTVBVkZqVTE3dGtKZkpLZzdzUkJybnNIcUFtWVZYVDNXYmFMeWE0?=
 =?utf-8?B?UlRCNEhtMmVUQ2tNWDZaUHQxVFlMQUwrTk55T0M1NXlWOXVRdlFRQ2dQVmhP?=
 =?utf-8?B?TXNGcFFGV2U0VEFrVEdpcm5RVHArTVZLTEZLL1gzaGlSZXUvRlhLRTh1YzY2?=
 =?utf-8?B?SGc0RVhDOVlOUHlvbTNEelRFbCtYY3RGZFJTbkhuMzFGYittdnpTL3lrYWF4?=
 =?utf-8?B?ZVNheDRpc2h1YndzWFh0djhYT2hCczUyQVJnMlhoemZSQ1Q2TEN2ZUNhRmwr?=
 =?utf-8?B?bG13RCtPdFBCY1lKWnJ5SXZxb2N0ZVA2WDFMSXM1am1aN29pV3VDdHIvY3FR?=
 =?utf-8?B?YjRiSVRrMXl4QU84N1orMi9JRUkxdDExTENVS2dRVSt5Qjg5c2dQRnR4YWVP?=
 =?utf-8?B?MVNLS3YwTlJ5elNOWEhwUTVxclM5MzNMaGNwR1BYWTk2VXA5NGJYdWVVRlRy?=
 =?utf-8?B?bUZSRXNqcVFrRUUwblFlMi9nTUE5RFByMllRS2tZWmZhQ1kvTSt2Z3NzVnhL?=
 =?utf-8?B?ZDZ4NmNnNzc2UVhaSms5Ykhxb3JkZVNHUEVUSUZRMVRrRW9jbnVEQS9PVDVy?=
 =?utf-8?B?WkVFQUk5cVQ4R0pGWUI5Y2RIanhCWko5SlRhM2NpOHpDZWpYVCtMeXhKakox?=
 =?utf-8?B?RjN6cjBVNEtKV3RUYUVIdFdBZmZvN29Ya1VMc0xST0VoTHNWdlpFcGtYdjRV?=
 =?utf-8?B?MlhFcnBndHpkME9SeCtibGxadU5ZNTViVCswTmF2c01NMmNqaFoxK0tTYlNV?=
 =?utf-8?B?MjQ5SGdwYUpKSmxyTllzZk5EejlEY1IrYWY1L0pLbFV5RHRnRHpCL3YvdXpB?=
 =?utf-8?B?V0NUZTBtNUp2bVg0Y3dqT2FBS3drUWNnRDBkd2V0UjFsb00zQ0xvMjhoRExT?=
 =?utf-8?B?d2FXc2hSWDJzUmxaTllyUUd3Uk94YjlTYUR2a0FSdTVqK2d3NlhmUG56TlND?=
 =?utf-8?B?ejU4RW1YZS8xa1lhcXhQZ1ZPZENtL2lUSFBUY21qU3FNSHNjYzNYMWFNRFdo?=
 =?utf-8?B?TGx0eGFLeHJVRi9nUUpEWGQwSFVadnIrR3NsREt4T3ZhWHFqWmw3MDB0OC80?=
 =?utf-8?B?bzNPWXhtbkpNOHVYbktjRStsT2E5SFp4S1VlZkZOTlAxYi9oa1BjK0ZiR2V5?=
 =?utf-8?B?YXNzb1Robm1yYXdWRmIvSEFMdUc4V0MyRzhHQUhBWjFicTRWQUNDMmdPdzZP?=
 =?utf-8?B?Y1VJdy9BR05vZGtLamFiV2o0M09pZkx6R1VWaGlERTltb2d2ZkZnMUxXQllW?=
 =?utf-8?B?b2hkaUUyYTExT1JQSzNCbkxnZ3EraUFYMmdYblNsOUhIREpURXpEWTFlRnRP?=
 =?utf-8?B?M1UxRWQrUVNNVFRsa0ZlRGh3QjJweUl2dU50RmwzNWJZV1N1Z3BHTXFXSnN6?=
 =?utf-8?Q?Aqru226rFh0yBBZeS5DknJxY1?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8879e4ab-5096-4772-e789-08db08de4459
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB5667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2023 07:38:12.8686 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mu41Fa9GzsmW2jii2oGmpHeTwTgLjLj60kojOa6mUAzzyzp3rQNSN/wEsIzBjgv8HffA8HGgtxkX7wUoTXuQHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7884
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
Cc: alexander.deucher@amd.com, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 07/02/2023 08:03, Christian König wrote:
> Am 06.02.23 um 22:03 schrieb Alex Deucher:
>> On Mon, Feb 6, 2023 at 12:01 PM Christian König
>> <christian.koenig@amd.com> wrote:
>>> Am 06.02.23 um 17:56 schrieb Alex Deucher:
>>>> On Fri, Feb 3, 2023 at 5:26 PM Shashank Sharma 
>>>> <shashank.sharma@amd.com> wrote:
>>>>> Hey Alex,
>>>>>
>>>>> On 03/02/2023 23:07, Alex Deucher wrote:
>>>>>> On Fri, Feb 3, 2023 at 4:54 PM Shashank Sharma 
>>>>>> <shashank.sharma@amd.com> wrote:
>>>>>>> From: Alex Deucher <alexander.deucher@amd.com>
>>>>>>>
>>>>>>> This patch intorduces new UAPI/IOCTL for usermode graphics
>>>>>>> queue. The userspace app will fill this structure and request
>>>>>>> the graphics driver to add a graphics work queue for it. The
>>>>>>> output of this UAPI is a queue id.
>>>>>>>
>>>>>>> This UAPI maps the queue into GPU, so the graphics app can start
>>>>>>> submitting work to the queue as soon as the call returns.
>>>>>>>
>>>>>>> Cc: Alex Deucher <alexander.deucher@amd.com>
>>>>>>> Cc: Christian Koenig <christian.koenig@amd.com>
>>>>>>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>>>>>>> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
>>>>>>> ---
>>>>>>>     include/uapi/drm/amdgpu_drm.h | 53 
>>>>>>> +++++++++++++++++++++++++++++++++++
>>>>>>>     1 file changed, 53 insertions(+)
>>>>>>>
>>>>>>> diff --git a/include/uapi/drm/amdgpu_drm.h 
>>>>>>> b/include/uapi/drm/amdgpu_drm.h
>>>>>>> index 4038abe8505a..6c5235d107b3 100644
>>>>>>> --- a/include/uapi/drm/amdgpu_drm.h
>>>>>>> +++ b/include/uapi/drm/amdgpu_drm.h
>>>>>>> @@ -54,6 +54,7 @@ extern "C" {
>>>>>>>     #define DRM_AMDGPU_VM                  0x13
>>>>>>>     #define DRM_AMDGPU_FENCE_TO_HANDLE     0x14
>>>>>>>     #define DRM_AMDGPU_SCHED               0x15
>>>>>>> +#define DRM_AMDGPU_USERQ               0x16
>>>>>>>
>>>>>>>     #define DRM_IOCTL_AMDGPU_GEM_CREATE 
>>>>>>> DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_CREATE, union 
>>>>>>> drm_amdgpu_gem_create)
>>>>>>>     #define DRM_IOCTL_AMDGPU_GEM_MMAP DRM_IOWR(DRM_COMMAND_BASE 
>>>>>>> + DRM_AMDGPU_GEM_MMAP, union drm_amdgpu_gem_mmap)
>>>>>>> @@ -71,6 +72,7 @@ extern "C" {
>>>>>>>     #define DRM_IOCTL_AMDGPU_VM DRM_IOWR(DRM_COMMAND_BASE + 
>>>>>>> DRM_AMDGPU_VM, union drm_amdgpu_vm)
>>>>>>>     #define DRM_IOCTL_AMDGPU_FENCE_TO_HANDLE 
>>>>>>> DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_FENCE_TO_HANDLE, union 
>>>>>>> drm_amdgpu_fence_to_handle)
>>>>>>>     #define DRM_IOCTL_AMDGPU_SCHED DRM_IOW(DRM_COMMAND_BASE + 
>>>>>>> DRM_AMDGPU_SCHED, union drm_amdgpu_sched)
>>>>>>> +#define DRM_IOCTL_AMDGPU_USERQ DRM_IOW(DRM_COMMAND_BASE + 
>>>>>>> DRM_AMDGPU_USERQ, union drm_amdgpu_userq)
>>>>>>>
>>>>>>>     /**
>>>>>>>      * DOC: memory domains
>>>>>>> @@ -302,6 +304,57 @@ union drm_amdgpu_ctx {
>>>>>>>            union drm_amdgpu_ctx_out out;
>>>>>>>     };
>>>>>>>
>>>>>>> +/* user queue IOCTL */
>>>>>>> +#define AMDGPU_USERQ_OP_CREATE 1
>>>>>>> +#define AMDGPU_USERQ_OP_FREE   2
>>>>>>> +
>>>>>>> +#define AMDGPU_USERQ_MQD_FLAGS_SECURE  (1 << 0)
>>>>>>> +#define AMDGPU_USERQ_MQD_FLAGS_AQL     (1 << 1)
>>>>>>> +
>>>>>>> +struct drm_amdgpu_userq_mqd {
>>>>>>> +       /** Flags: AMDGPU_USERQ_MQD_FLAGS_* */
>>>>>>> +       __u32   flags;
>>>>>>> +       /** IP type: AMDGPU_HW_IP_* */
>>>>>>> +       __u32   ip_type;
>>>>>>> +       /** GEM object handle */
>>>>>>> +       __u32   doorbell_handle;
>>>>>>> +       /** Doorbell offset in dwords */
>>>>>>> +       __u32   doorbell_offset;
>>>>>> Since doorbells are 64 bit, maybe this offset should be in qwords.
>>>>> Can you please help to cross check this information ? All the 
>>>>> existing
>>>>> kernel doorbell calculations are keeping doorbells size as 
>>>>> sizeof(u32)
>>>> Doorbells on pre-vega hardware are 32 bits so that is where that comes
>>>> from, but from vega onward most doorbells are 64 bit.  I think some
>>>> versions of VCN may still use 32 bit doorbells.  Internally in the
>>>> kernel driver we just use two slots for newer hardware, but for the
>>>> UAPI, I think we can just stick with 64 bit slots to avoid confusion.
>>>> Even if an engine only uses a 32 bit one, I don't know that there is
>>>> much value to trying to support variable doorbell sizes.
>>> I think we can stick with using __u32 because this is *not* the size of
>>> the doorbell entries.
>>>
>>> Instead this is the offset into the BO where to find the doorbell for
>>> this queue (which then in turn is 64bits wide).
>>>
>>> Since we will probably never have more than 4GiB doorbells we should be
>>> pretty save to use 32bits here.
>> Yes, the offset would still be 32 bits, but the units would be 
>> qwords.  E.g.,
>>
>> +       /** Doorbell offset in qwords */
>> +       __u32   doorbell_offset;
>>
>> That way you couldn't accidently specify an overlapping doorbell.
>
> Ah, so you only wanted to fix the comment. That was absolutely not 
> clear from the discussion.

If I understand this correctly, the offset of the doorbell in the BO is 
still is 32-bit, but its width (size in bytes) is 64 bits. Am I getting 
that right ?

- Shashank

>
> Christian.
>
>>
>> Alex
>>
>>> Christian.
>>>
>>>> Alex
>>>>
>>>>>>> +       /** GPU virtual address of the queue */
>>>>>>> +       __u64   queue_va;
>>>>>>> +       /** Size of the queue in bytes */
>>>>>>> +       __u64   queue_size;
>>>>>>> +       /** GPU virtual address of the rptr */
>>>>>>> +       __u64   rptr_va;
>>>>>>> +       /** GPU virtual address of the wptr */
>>>>>>> +       __u64   wptr_va;
>>>>>>> +};
>>>>>>> +
>>>>>>> +struct drm_amdgpu_userq_in {
>>>>>>> +       /** AMDGPU_USERQ_OP_* */
>>>>>>> +       __u32   op;
>>>>>>> +       /** Flags */
>>>>>>> +       __u32   flags;
>>>>>>> +       /** Queue handle to associate the queue free call with,
>>>>>>> +        * unused for queue create calls */
>>>>>>> +       __u32   queue_id;
>>>>>>> +       __u32   pad;
>>>>>>> +       /** Queue descriptor */
>>>>>>> +       struct drm_amdgpu_userq_mqd mqd;
>>>>>>> +};
>>>>>>> +
>>>>>>> +struct drm_amdgpu_userq_out {
>>>>>>> +       /** Queue handle */
>>>>>>> +       __u32   q_id;
>>>>>> Maybe this should be queue_id to match the input.
>>>>> Agree.
>>>>>
>>>>> - Shashank
>>>>>
>>>>>> Alex
>>>>>>
>>>>>>> +       /** Flags */
>>>>>>> +       __u32   flags;
>>>>>>> +};
>>>>>>> +
>>>>>>> +union drm_amdgpu_userq {
>>>>>>> +       struct drm_amdgpu_userq_in in;
>>>>>>> +       struct drm_amdgpu_userq_out out;
>>>>>>> +};
>>>>>>> +
>>>>>>>     /* vm ioctl */
>>>>>>>     #define AMDGPU_VM_OP_RESERVE_VMID      1
>>>>>>>     #define AMDGPU_VM_OP_UNRESERVE_VMID    2
>>>>>>> -- 
>>>>>>> 2.34.1
>>>>>>>
>
