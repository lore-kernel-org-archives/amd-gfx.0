Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C890CDB474
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Oct 2023 07:35:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CD63010E27D;
	Tue, 17 Oct 2023 07:35:13 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2046.outbound.protection.outlook.com [40.107.100.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F52B10E27D
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Oct 2023 07:35:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aqQ4s3YDxZKgMauZMJhBd4QjwYXHWe5LHULSXW0SY4e1qB08m7M5gY3SGhRX3rIjT0h4TO3Jyi3YUKdlya0ONe4vPyIJ3N0WcjMvBQFu9tfqzScuRxQ2wCM4SxVONMSHoPX0GjJeifdwgFqQcorT3DG4xJbFE0i7nwnnRCiGJucM9sr9Rb5EIrm6D2Ie6FJ8syxwu7l2PNch6cIM5OfJnWWXbkA+Jf4tHZtpEC7j6AgIxXJYz+3NI8iMlaFaAFXuqd7JqaZ0tQAvKToxXJT03bV9Y/OTz7Y2YOU2DccN78Gxz94dblxfoGByZsOmn5djxk+YaUKoajA5BjluPL8bqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=grqZzRZBwOO0FxtQXp9UsIV9l8ZQY0Gf72vHiQaaQlI=;
 b=c67CDG0w22124b41tYTxgOgnKa2qIZA1T20sNRw6UhVT0v9bG9MrkxMvIIw2E6RKoS8tWUuwvCQ5t4U6WNfP1MIdYqKEgU3deNLxH/yR3jvtEPvOF67ZELS8Id8lJeHc3NP8u0qUpJgdQG6kk+p5OPluHJdmX4AmiZb6ECqZTnwxZM0YrAc36rzCS36i7Ym8qo3EjYBXydq7eTMxArRBXaG2+T1QjVlmq9zwuxEjsX/xQQ+jJ0p//4Dc6oG7xzeTZmZ9ZTFmkVam+Ig1QajGg8Wel1K9E3CpFdhhA97HBe2fshq3nNo3z7q673kRVMhpohP32S5MxSNep3e1R6/BqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=grqZzRZBwOO0FxtQXp9UsIV9l8ZQY0Gf72vHiQaaQlI=;
 b=UgL9KXs4IusOQNwh4cFTbgyZkD/5aRzBh5bE2MKVU9Z78mhnqPz6ohNizDtecqXn8D+tZ5R43z6c4Y6vsv7UjAw+Lq0hTvcSuOaWAnuY9U2ksW+d2MMTApRZIOdOE49Z8XVsQBb/4cBRrqnB9HkCoRmsHo/SsLnUqpXv8k9bCfw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by LV8PR12MB9269.namprd12.prod.outlook.com (2603:10b6:408:1fe::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35; Tue, 17 Oct
 2023 07:35:06 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::a7fa:4411:67a3:131d]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::a7fa:4411:67a3:131d%4]) with mapi id 15.20.6886.034; Tue, 17 Oct 2023
 07:35:05 +0000
Message-ID: <df1a3bea-3e39-444f-a69f-4babfeb1b74a@amd.com>
Date: Tue, 17 Oct 2023 09:34:59 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: move task_info to amdgpu_fpriv
Content-Language: en-US
To: Shashank Sharma <shashank.sharma@amd.com>,
 Felix Kuehling <felix.kuehling@amd.com>, amd-gfx@lists.freedesktop.org
References: <20231016170820.979-1-shashank.sharma@amd.com>
 <b6709537-e2a4-4694-b5a6-862212ed0cbf@amd.com>
 <b096e8d1-e8ed-4e72-8282-c8cc5d32616b@amd.com>
 <3c1b3f96-1456-506e-0914-504e64d247f7@amd.com>
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <3c1b3f96-1456-506e-0914-504e64d247f7@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0058.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4b::19) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|LV8PR12MB9269:EE_
X-MS-Office365-Filtering-Correlation-Id: b4e0db6d-08ea-4179-821f-08dbcee394cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IFZb1ketvHUAa3ykz/r9Gsn2aOpOIc9po2LsIQ/G1m/RiBC30ODIt1vGfs/DAyNEuuzjFpESKwqC8Lbwcof+6KSYL3jJiOFeik5gScYeCvWOtDL8LtAxFpw78GUI9xZ6uYutHmHroTTSwqMfttLOHuImBbhx5xp59MQ+3MXjof/aFdOS4/0P6C8MkrjXGajPAgza6W7X2A73VKssYwEzkwRkJo295BVsciaArmAgWtlBjXamTQMHscvDwmqc4Q5fF8PfD/KzC3r1zB/ugVJdH4VZuKlOUI1luVyv7WgFy/dmi4vxyBl55S5ZMZACz3xZQQnFMLlCQa9vyPak6keTZFVCSPNmiJ9hlW8x6vpEGOMoFPg/5Q6XzNyFqieSVwFo9nQh6IBlM6Eop1TmiWX7oh00XPqADaDqrTx2eLLQJfG1VSRPxL7DtET3Q/6AI2nN4OQqqHH4NmqYDGVnepuENh19zRC+ykt5xbsHoCmFY7yMDxbyvbS62jY9EVNJGhw/3p1IHFyxteU0+tfmGptH64SRK2e6N7ybtoteZFL+R9dUrqUXFxltMMVyIqNeG+3l8Mt5EVW944kRBJ97hJLXHA/lSI/KO6SQxkBgTAum1979B8sKMTO8+3GTohI7EuEQMbFoUSqq/dI/7wgclovzzw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(396003)(366004)(376002)(136003)(346002)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(66556008)(478600001)(66946007)(66476007)(6486002)(110136005)(6666004)(26005)(30864003)(53546011)(41300700001)(66574015)(6506007)(316002)(2616005)(6512007)(4326008)(2906002)(8936002)(8676002)(5660300002)(36756003)(4001150100001)(86362001)(31696002)(83380400001)(38100700002)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UHNTZWhKdWYrbURIOUZsdzE4aWlabzFFdzlCZjVYR1VJMm5KWUVCYWFhQUVE?=
 =?utf-8?B?SUhxaHFXNTVvNTZRenRJWFJ0cnFURFFoQXc0K2l2L3lRSzF2WEFQcitFYmRa?=
 =?utf-8?B?MXk3TFE2NWxYY1JGUzZmWnYxQmIra0dQRzFqNmh3Smtrem1BY1dYL0FQYjBE?=
 =?utf-8?B?anlWODJGVURvQzFEODR3d3duM3lmaDJhTDBoVTlLK0puNjdteU15U2RCdVdn?=
 =?utf-8?B?YVhKNmUrOERxZ0t6VG80aU9xb24vWUdaSjg5cUtIN0FkY3J0ZGR2NDJOb0dx?=
 =?utf-8?B?VGpKOXh4d2Y5eE45VGc5LzJMaFVqMzZkVTBjbWpKTlMzLzZXaUlPdnVGYytE?=
 =?utf-8?B?aVF6Zlo5T2I0eUdSSENXbE1qM0pJRHN6aFBZWkxQZ2VqYytURG9jbEtIMzFr?=
 =?utf-8?B?aDc5RGJsd3l6SnJpNGF2bTE5M0JJYTVMRk5RYUptMjJwc0poRXRPd1lOZS9B?=
 =?utf-8?B?anBzL0ljN0FSdXV4dmtOODNlRndyTnk2SXFIb3g1T3huaHQwOGVFanBDSG1T?=
 =?utf-8?B?VzN2YW82QzlsN1U0Sjc5T25QT2t0MzRIZndEWXlaL2pIWW9CWVFvbWZMaTZn?=
 =?utf-8?B?bzRCVGlWaDlqK1FIUU5KeVBsSEszeC9XMlpIZGNmNE1ZK1RYbHVOVUxaSE5R?=
 =?utf-8?B?bEc4UWQyVDR2U0pkNEQ2UUpPRTFHbi9TaTJTa1lnUk81bjZyZzhFazJVNDds?=
 =?utf-8?B?SVBWZDNqZDM2aG5laWFzUnZTVkI5U01BcE9vSFBoNFB6dWZhcS9DVUpLWklY?=
 =?utf-8?B?TExOQ0h4U2ozLzMvclBvRzN0NXVPcVpGU1FEeUpjRnJBa3YxNElZS1FhdUl1?=
 =?utf-8?B?c3Fqb1NWVEdGNThPSzFHelZ0UnZoL01lY2ttN1lEZ1NOYmZhTGtOcUJzUXNx?=
 =?utf-8?B?elFrTFJiR0ZSVnBEWDg3amhZNm5DVGxwRzQ1SllMM2gvbkVxUFhwckE5K0dr?=
 =?utf-8?B?K2NqU2VzZWRyemI2NWowQ1ExZlBvQU40NnZuQnlpZFN0RmZtakZNRlBla1NW?=
 =?utf-8?B?MmY4OVRmOThlMXR4S3I3Y2s4QnJaTzkvOFliODBMa1lpZ0Evc2YxenQ0M3BV?=
 =?utf-8?B?aDJOV0NQVXRTSk0yRllIbmdUMk9kbW9Rd2U1bXRCSUpjeG9jYjNsaDR3dDhH?=
 =?utf-8?B?a29DU3RJMXdqOGxVaDNGL0dQTWpNazFva2hodkRQTkRmbFZBUkIwN2h1dys5?=
 =?utf-8?B?d1lYTzVVWFRkeEdGVmJjTTE1S3l6dVRpQTJ2dHpkRU02SmFVM1FmakRoQi92?=
 =?utf-8?B?Q2g5RjhhdWNvYVF6b1psSkNMMzZPOU5sc1JkRUZYeExsR1IwSklPb1lGWld1?=
 =?utf-8?B?ODNSTXNBU3BOQjRZalJ3VkZJem5uWXY1ZXNKWXhyU0hFVDk3dklldnJIdGNp?=
 =?utf-8?B?bURxY1RwY1ozUW9CZk5aZmZ5clAvNDg1THg5b2ZhekdhQkJIcGxKZHo4Q0Iw?=
 =?utf-8?B?UEpIRHRxeFl3VE5ZRDlBMmZseWY0dXl0Tm1PS0ZWNE9BdUxKZmJpdnhGRnNt?=
 =?utf-8?B?WjhGUk95SFU0R1R5SUh2QXZiTkRoSGZ6V3M5RWs0cFVmTEJQaC9DVVA0RGYx?=
 =?utf-8?B?OFlrVDN1RHp2Rkw1ZnhQVUc2MEh4TVZPbm9vMC8veEFCZE5Ibmk1RUd0QnE1?=
 =?utf-8?B?b2V1SUtydXo1SEJhTlJhaU5aWmxUaTg3YnlFdGp6RVJvdDB1N29LYVA4TVVN?=
 =?utf-8?B?OTFNMEEydXRCY1RIdXk1b3lMMFk3LzNpZ0FPc0c5cUcyT1ZoTUMyUHBndW5C?=
 =?utf-8?B?UlFPQk5NditScFRiak5DaEdxZENKRVlJMHN0SHFXMnBVQkhpOGNabVlybity?=
 =?utf-8?B?NVErUkh0OVJ4Y1pMUFJzL0pTYndiQXRMcmF1dVJkeFI3TUIyOGh2RDhuUDRT?=
 =?utf-8?B?ZUdTZS95NnE2eEorZDdoRE9ITmlVNHMvdk1aMWxZVk01TXZkaVNncFFPQUpj?=
 =?utf-8?B?bWIzZVZVWi9ocnc0bGFXM1R2SXRDL0lCUlk2ZkJRQjFBNnE5Nit2YzU4c2Fz?=
 =?utf-8?B?VEhqYzRGekZRSTFMVXlxa1RNRzhRRWlCNGd4Y3N5QzFwQjZ4VFRNb0MrRGlL?=
 =?utf-8?B?OUpsdWRVVGxzUjRvU0RoTklpMUR3eU8wQ2NxZCszQnNEUnphVXBOUlhuN0Uz?=
 =?utf-8?Q?eJHaIpfk3DVB7GVoGHnGoxxuC?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4e0db6d-08ea-4179-821f-08dbcee394cd
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2023 07:35:05.4852 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q905wBtAWZSLBE/fZK1VAehlWiZqBERXsKGAam0xLfbrQJH4m2gbRmeusfcUuCR/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9269
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
Cc: Alex Deucher <alexander.deucher@amd.com>, arvind.yadav@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 17.10.23 um 09:25 schrieb Shashank Sharma:
> Hello Christian, Felix,
>
> Thanks for your comments, mine inline.
>
> On 17/10/2023 07:55, Christian König wrote:
>> Am 17.10.23 um 00:15 schrieb Felix Kuehling:
>>> On 2023-10-16 13:08, Shashank Sharma wrote:
>>>> This patch does the following:
>>>> - moves vm->task_info struct to fpriv->task_info.
>>>> - makes task_info allocation dynamic.
>>>> - adds reference counting support for task_info structure.
>>>> - adds some new helper functions to find and put task_info.
>>>> - adds respective supporting changes for existing get_task_info 
>>>> consumers.
>>>>
>>>> Cc: Christian Koenig <christian.koenig@amd.com>
>>>> Cc: Alex Deucher <alexander.deucher@amd.com>
>>>> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
>>>> ---
>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu.h         |  2 +
>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c |  4 +-
>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c  | 28 +++++--
>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_job.c     | 16 ++--
>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c      | 87 
>>>> ++++++++++++++++-----
>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h      |  9 +--
>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c   |  5 +-
>>>>   drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c      | 19 +++--
>>>>   drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c      | 18 +++--
>>>>   drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c       | 17 ++--
>>>>   drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c       | 19 +++--
>>>>   drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c      | 19 ++---
>>>>   drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c    | 20 ++---
>>>>   drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c | 14 ++--
>>>>   14 files changed, 186 insertions(+), 91 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h 
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>>> index dc2d53081e80..a90780d38725 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>>> @@ -469,6 +469,8 @@ struct amdgpu_fpriv {
>>>>       struct mutex        bo_list_lock;
>>>>       struct idr        bo_list_handles;
>>>>       struct amdgpu_ctx_mgr    ctx_mgr;
>>>> +    struct amdgpu_task_info *task_info;
>>>> +
>>>>       /** GPU partition selection */
>>>>       uint32_t        xcp_id;
>>>>   };
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c 
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>>>> index a4faea4fa0b5..6e9dcd13ee34 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>>>> @@ -1763,9 +1763,11 @@ static int 
>>>> amdgpu_debugfs_vm_info_show(struct seq_file *m, void *unused)
>>>>       list_for_each_entry(file, &dev->filelist, lhead) {
>>>>           struct amdgpu_fpriv *fpriv = file->driver_priv;
>>>>           struct amdgpu_vm *vm = &fpriv->vm;
>>>> +        struct amdgpu_task_info *task_info = fpriv->task_info;
>>>>             seq_printf(m, "pid:%d\tProcess:%s ----------\n",
>>>> -                vm->task_info.pid, vm->task_info.process_name);
>>>> +                task_info ? task_info->pid : 0,
>>>> +                task_info ? task_info->process_name : "");
>>>>           r = amdgpu_bo_reserve(vm->root.bo, true);
>>>>           if (r)
>>>>               break;
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c 
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>> index 3f001a50b34a..b372a87b9b77 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>> @@ -4872,6 +4872,27 @@ static void 
>>>> amdgpu_reset_capture_coredumpm(struct amdgpu_device *adev)
>>>>       dev_coredumpm(dev->dev, THIS_MODULE, adev, 0, GFP_NOWAIT,
>>>>                 amdgpu_devcoredump_read, amdgpu_devcoredump_free);
>>>>   }
>>>> +
>>>> +static void
>>>> +amdgpu_reset_dev_coredump(struct amdgpu_device *adev, struct 
>>>> amdgpu_reset_context *reset_context)
>>>> +{
>>>> +    struct amdgpu_task_info *ti;
>>>> +    struct amdgpu_vm *vm;
>>>> +
>>>> +    if (!reset_context->job || !reset_context->job->vm)
>>>> +        return;
>>>> +
>>>> +    vm = reset_context->job->vm;
>>>> +
>>>> +    /* Get reset task info and save a copy of data to be consumed 
>>>> later */
>>>> +    ti = amdgpu_vm_get_task_info(adev, vm->pasid);
>>>> +    if (ti) {
>>>> +        adev->reset_task_info = *ti;
>>>> +        amdgpu_reset_capture_coredumpm(adev);
>>>> +    }
>>>> +
>>>> +    amdgpu_vm_put_task_info(adev, vm->pasid);
>>>> +}
>>>>   #endif
>>>>     int amdgpu_do_asic_reset(struct list_head *device_list_handle,
>>>> @@ -4976,12 +4997,7 @@ int amdgpu_do_asic_reset(struct list_head 
>>>> *device_list_handle,
>>>>                   vram_lost = amdgpu_device_check_vram_lost(tmp_adev);
>>>>   #ifdef CONFIG_DEV_COREDUMP
>>>>                   tmp_adev->reset_vram_lost = vram_lost;
>>>> -                memset(&tmp_adev->reset_task_info, 0,
>>>> - sizeof(tmp_adev->reset_task_info));
>>>> -                if (reset_context->job && reset_context->job->vm)
>>>> -                    tmp_adev->reset_task_info =
>>>> - reset_context->job->vm->task_info;
>>>> -                amdgpu_reset_capture_coredumpm(tmp_adev);
>>>> +                amdgpu_reset_dev_coredump(tmp_adev, reset_context);
>>>>   #endif
>>>>                   if (vram_lost) {
>>>>                       DRM_INFO("VRAM is lost due to GPU reset!\n");
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c 
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
>>>> index 78476bc75b4e..99cf30c0bce6 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
>>>> @@ -35,7 +35,7 @@ static enum drm_gpu_sched_stat 
>>>> amdgpu_job_timedout(struct drm_sched_job *s_job)
>>>>   {
>>>>       struct amdgpu_ring *ring = to_amdgpu_ring(s_job->sched);
>>>>       struct amdgpu_job *job = to_amdgpu_job(s_job);
>>>> -    struct amdgpu_task_info ti;
>>>> +    struct amdgpu_task_info *ti;
>>>>       struct amdgpu_device *adev = ring->adev;
>>>>       int idx;
>>>>       int r;
>>>> @@ -48,7 +48,6 @@ static enum drm_gpu_sched_stat 
>>>> amdgpu_job_timedout(struct drm_sched_job *s_job)
>>>>           return DRM_GPU_SCHED_STAT_ENODEV;
>>>>       }
>>>>   -    memset(&ti, 0, sizeof(struct amdgpu_task_info));
>>>>       adev->job_hang = true;
>>>>         if (amdgpu_gpu_recovery &&
>>>> @@ -58,12 +57,15 @@ static enum drm_gpu_sched_stat 
>>>> amdgpu_job_timedout(struct drm_sched_job *s_job)
>>>>           goto exit;
>>>>       }
>>>>   -    amdgpu_vm_get_task_info(ring->adev, job->pasid, &ti);
>>>>       DRM_ERROR("ring %s timeout, signaled seq=%u, emitted seq=%u\n",
>>>> -          job->base.sched->name, 
>>>> atomic_read(&ring->fence_drv.last_seq),
>>>> -          ring->fence_drv.sync_seq);
>>>> -    DRM_ERROR("Process information: process %s pid %d thread %s 
>>>> pid %d\n",
>>>> -          ti.process_name, ti.tgid, ti.task_name, ti.pid);
>>>> +           job->base.sched->name, 
>>>> atomic_read(&ring->fence_drv.last_seq),
>>>> +           ring->fence_drv.sync_seq);
>>>> +
>>>> +    ti = amdgpu_vm_get_task_info(ring->adev, job->pasid);
>>>> +    if (ti)
>>>> +        DRM_ERROR("Process information: process %s pid %d thread 
>>>> %s pid %d\n",
>>>> +               ti->process_name, ti->tgid, ti->task_name, ti->pid);
>>>> +    amdgpu_vm_put_task_info(ring->adev, job->pasid);
>>>> dma_fence_set_error(&s_job->s_fence->finished, -ETIME);
>>>>   diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c 
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>>> index f5daadcec865..aabfbb8edb2b 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>>> @@ -2335,6 +2335,7 @@ void amdgpu_vm_fini(struct amdgpu_device 
>>>> *adev, struct amdgpu_vm *vm)
>>>>         root = amdgpu_bo_ref(vm->root.bo);
>>>>       amdgpu_bo_reserve(root, true);
>>>> +    amdgpu_vm_put_task_info(adev, vm->pasid);
>>>>       amdgpu_vm_set_pasid(adev, vm, 0);
>>>>       dma_fence_wait(vm->last_unlocked, false);
>>>>       dma_fence_put(vm->last_unlocked);
>>>> @@ -2491,26 +2492,44 @@ int amdgpu_vm_ioctl(struct drm_device *dev, 
>>>> void *data, struct drm_file *filp)
>>>>       return 0;
>>>>   }
>>>>   +static struct
>>>> +amdgpu_task_info *amdgpu_vm_find_task_info(struct amdgpu_device 
>>>> *adev, u32 pasid)
>>>> +{
>>>> +    unsigned long flags;
>>>> +    struct amdgpu_vm *vm;
>>>> +    struct amdgpu_fpriv *fpriv;
>>>> +    struct amdgpu_task_info *task_info = NULL;
>>>> +
>>>> +    xa_lock_irqsave(&adev->vm_manager.pasids, flags);
>>>> +
>>>> +    vm = xa_load(&adev->vm_manager.pasids, pasid);
>>>> +    if (vm) {
>>>> +        fpriv = container_of(vm, struct amdgpu_fpriv, vm);
>>>> +        task_info = fpriv->task_info;
>>>> +    }
>>>> +
>>>> +    xa_unlock_irqrestore(&adev->vm_manager.pasids, flags);
>>>> +    return task_info;
>>>> +}
>>>> +
>>>>   /**
>>>>    * amdgpu_vm_get_task_info - Extracts task info for a PASID.
>>>>    *
>>>>    * @adev: drm device pointer
>>>>    * @pasid: PASID identifier for VM
>>>> - * @task_info: task_info to fill.
>>>> + *
>>>> + * returns the task_info* (refrence counted) set under the vm_pasid
>>>> + * user must call amdgpu_vm_put_task_info when done with the 
>>>> task_info ptr
>>>>    */
>>>> -void amdgpu_vm_get_task_info(struct amdgpu_device *adev, u32 pasid,
>>>> -             struct amdgpu_task_info *task_info)
>>>> +struct amdgpu_task_info *amdgpu_vm_get_task_info(struct 
>>>> amdgpu_device *adev, u32 pasid)
>>>>   {
>>>> -    struct amdgpu_vm *vm;
>>>> -    unsigned long flags;
>>>> -
>>>> -    xa_lock_irqsave(&adev->vm_manager.pasids, flags);
>>>> +    struct amdgpu_task_info *ti;
>>>>   -    vm = xa_load(&adev->vm_manager.pasids, pasid);
>>>> -    if (vm)
>>>> -        *task_info = vm->task_info;
>>>> +    ti = amdgpu_vm_find_task_info(adev, pasid);
>>>> +    if (ti)
>>>> +        kref_get(&ti->refcount);
>>>>   -    xa_unlock_irqrestore(&adev->vm_manager.pasids, flags);
>>>> +    return ti;
>>>>   }
>>>>     /**
>>>> @@ -2520,17 +2539,49 @@ void amdgpu_vm_get_task_info(struct 
>>>> amdgpu_device *adev, u32 pasid,
>>>>    */
>>>>   void amdgpu_vm_set_task_info(struct amdgpu_vm *vm)
>>>>   {
>>>> -    if (vm->task_info.pid)
>>>> -        return;
>>>> +    struct amdgpu_fpriv *fpriv = container_of(vm, struct 
>>>> amdgpu_fpriv, vm);
>>
>> Big NAK to that, no idea why everybody wants to upcast the VM 
>> structure to fpriv.
>>
>> Instead move this into the the fpriv handling in amdgpu_kms.c
> If you see the existing consumers of amdgpu_vm_get_task_info(), in 
> most of the cases they either have only the vm or the pasid available 
> (Please see gmc_v*_0_process_interrupts, sdma_v4_*_print_iv_entry or 
> kfd_smi_event_update_vmfault). Now if we want to move the task_info 
> from vm to fpriv, the only way to do it without breaking these 
> existing consumers, is to get fpriv from VM. If we move this handling 
> into amdgpu_kms.c , then how to handle these consumers who do not have 
> fpriv available with them ?

Well the primary task is to make task_info a stand alone object, if that 
means that it moves to fpriv is only optional.

When we have a lot of use cases which go to the VM with the pasid and 
want the task_info then we should probably keep that pointer there.

But that is then just a helper function something like 
amdgpu_vm_get_task_info_by_pasid() which then also returns a new 
task_info reference which the caller has to drop.

Regards,
Christian.

>>
>>>> +    struct amdgpu_task_info *task_info;
>>>>   -    vm->task_info.pid = current->pid;
>>>> -    get_task_comm(vm->task_info.task_name, current);
>>>> +    if (fpriv->task_info)
>>>> +        return;
>>>>   -    if (current->group_leader->mm != current->mm)
>>>> +    task_info = kzalloc(sizeof(*task_info), GFP_KERNEL);
>>>> +    if (!task_info) {
>>>> +        DRM_ERROR("OOM while task_info creation\n");
>>>>           return;
>>>> +    }
>>>> +
>>>> +    kref_init(&task_info->refcount);
>>>> +    task_info->pid = current->pid;
>>>> +    get_task_comm(task_info->task_name, current);
>>>> +
>>>> +    if (current->group_leader->mm != current->mm) {
>>>> +        task_info->tgid = current->group_leader->pid;
>>>> +        get_task_comm(task_info->process_name, 
>>>> current->group_leader);
>>>> +    }
>>>> +
>>>> +    kref_get(&task_info->refcount);
>>>> +    fpriv->task_info = task_info;
>>>> +}
>>>> +
>>>> +static void amdgpu_vm_free_task_info(struct kref *kref)
>>>> +{
>>>> +    kfree(container_of(kref, struct amdgpu_task_info, refcount));
>>>> +}
>>>> +
>>>> +/**
>>>> + * amdgpu_vm_put_task_info - reference down the task_info ptr.
>>>> + *
>>>> + * @adev: drm device pointer
>>>> + * @pasid: PASID identifier for VM
>>>> + */
>>>> +void amdgpu_vm_put_task_info(struct amdgpu_device *adev, u32 pasid)
>>>> +{
>>>> +    struct amdgpu_task_info *ti;
>>>>   -    vm->task_info.tgid = current->group_leader->pid;
>>>> -    get_task_comm(vm->task_info.process_name, current->group_leader);
>>>> +    ti = amdgpu_vm_find_task_info(adev, pasid);
>>> This doesn't make sense. Anyone trying to drop a reference should 
>>> already have a ti * from a previous amdgpu_vm_get_task_info call. 
>>> You don't need to find it again. Just pass the ti * from the caller 
>>> to this function.
> Agree, I will modify it.
>>
>> Yeah, agree completely. Additional to that one goal here was to 
>> decouple the VM from the task_info.
>>
>> Probably best if you put the task_info structure into amdgpu_reset.h 
>> and the related handling into amdgpu_kms.c or amdgpu_reset.c instead.
>>
> Same question as above.
>
> - Shashank
>
>> Regards,
>> Christian.
>>
>>>
>>> Regards,
>>>   Felix
>>>
>>>
>>>> +    if (ti)
>>>> +        kref_put(&ti->refcount, amdgpu_vm_free_task_info);
>>>>   }
>>>>     /**
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h 
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>>>> index 204ab13184ed..40a8c532a5ed 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>>>> @@ -187,6 +187,7 @@ struct amdgpu_task_info {
>>>>       char    task_name[TASK_COMM_LEN];
>>>>       pid_t    pid;
>>>>       pid_t    tgid;
>>>> +    struct kref refcount;
>>>>   };
>>>>     /**
>>>> @@ -333,9 +334,6 @@ struct amdgpu_vm {
>>>>       /* Valid while the PD is reserved or fenced */
>>>>       uint64_t        pd_phys_addr;
>>>>   -    /* Some basic info about the task */
>>>> -    struct amdgpu_task_info task_info;
>>>> -
>>>>       /* Store positions of group of BOs */
>>>>       struct ttm_lru_bulk_move lru_bulk_move;
>>>>       /* Flag to indicate if VM is used for compute */
>>>> @@ -466,8 +464,9 @@ bool amdgpu_vm_need_pipeline_sync(struct 
>>>> amdgpu_ring *ring,
>>>>                     struct amdgpu_job *job);
>>>>   void amdgpu_vm_check_compute_bug(struct amdgpu_device *adev);
>>>>   -void amdgpu_vm_get_task_info(struct amdgpu_device *adev, u32 pasid,
>>>> -                 struct amdgpu_task_info *task_info);
>>>> +struct amdgpu_task_info *
>>>> +amdgpu_vm_get_task_info(struct amdgpu_device *adev, u32 pasid);
>>>> +void amdgpu_vm_put_task_info(struct amdgpu_device *adev, u32 pasid);
>>>>   bool amdgpu_vm_handle_fault(struct amdgpu_device *adev, u32 pasid,
>>>>                   u32 vmid, u32 node_id, uint64_t addr,
>>>>                   bool write_fault);
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c 
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
>>>> index 96d601e209b8..3d7a9ad963a8 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
>>>> @@ -1023,21 +1023,24 @@ int amdgpu_vm_ptes_update(struct 
>>>> amdgpu_vm_update_params *params,
>>>>               uint64_t upd_end = min(entry_end, frag_end);
>>>>               unsigned int nptes = (upd_end - frag_start) >> shift;
>>>>               uint64_t upd_flags = flags | AMDGPU_PTE_FRAG(frag);
>>>> +            struct amdgpu_task_info *task_info;
>>>>                 /* This can happen when we set higher level PDs to
>>>>                * silent to stop fault floods.
>>>>                */
>>>>               nptes = max(nptes, 1u);
>>>>   +            task_info = amdgpu_vm_get_task_info(adev, vm->pasid);
>>>>               trace_amdgpu_vm_update_ptes(params, frag_start, upd_end,
>>>>                               min(nptes, 32u), dst, incr,
>>>>                               upd_flags,
>>>> -                            vm->task_info.tgid,
>>>> +                            task_info ? task_info->tgid : 0,
>>>> vm->immediate.fence_context);
>>>>               amdgpu_vm_pte_update_flags(params, to_amdgpu_bo_vm(pt),
>>>>                              cursor.level, pe_start, dst,
>>>>                              nptes, incr, upd_flags);
>>>>   +            amdgpu_vm_put_task_info(adev, vm->pasid);
>>>>               pe_start += nptes * 8;
>>>>               dst += nptes * incr;
>>>>   diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c 
>>>> b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
>>>> index fa87a85e1017..14ded13c8b09 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
>>>> @@ -107,7 +107,7 @@ static int gmc_v10_0_process_interrupt(struct 
>>>> amdgpu_device *adev,
>>>>       struct amdgpu_vmhub *hub = &adev->vmhub[vmhub_index];
>>>>       bool retry_fault = !!(entry->src_data[1] & 0x80);
>>>>       bool write_fault = !!(entry->src_data[1] & 0x20);
>>>> -    struct amdgpu_task_info task_info;
>>>> +    struct amdgpu_task_info *task_info;
>>>>       uint32_t status = 0;
>>>>       u64 addr;
>>>>   @@ -155,15 +155,18 @@ static int 
>>>> gmc_v10_0_process_interrupt(struct amdgpu_device *adev,
>>>>       if (!printk_ratelimit())
>>>>           return 0;
>>>>   -    memset(&task_info, 0, sizeof(struct amdgpu_task_info));
>>>> -    amdgpu_vm_get_task_info(adev, entry->pasid, &task_info);
>>>> -
>>>> -    dev_err(adev->dev,
>>>> -        "[%s] page fault (src_id:%u ring:%u vmid:%u pasid:%u, for 
>>>> process %s pid %d thread %s pid %d)\n",
>>>> +    dev_err(adev->dev, "[%s] page fault (src_id:%u ring:%u vmid:%u 
>>>> pasid:%u)\n",
>>>>           entry->vmid_src ? "mmhub" : "gfxhub",
>>>>           entry->src_id, entry->ring_id, entry->vmid,
>>>> -        entry->pasid, task_info.process_name, task_info.tgid,
>>>> -        task_info.task_name, task_info.pid);
>>>> +        entry->pasid);
>>>> +
>>>> +    task_info = amdgpu_vm_get_task_info(adev, entry->pasid);
>>>> +    if (task_info)
>>>> +        dev_err(adev->dev, "for process %s pid %d thread %s pid 
>>>> %d\n",
>>>> +                   task_info->process_name, task_info->tgid,
>>>> +                   task_info->task_name, task_info->pid);
>>>> +    amdgpu_vm_put_task_info(adev, entry->pasid);
>>>> +
>>>>       dev_err(adev->dev, "  in page starting at address 0x%016llx 
>>>> from client 0x%x (%s)\n",
>>>>           addr, entry->client_id,
>>>>           soc15_ih_clientid_name[entry->client_id]);
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c 
>>>> b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
>>>> index e3b76fd28d15..2d96567171bc 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
>>>> @@ -120,17 +120,21 @@ static int gmc_v11_0_process_interrupt(struct 
>>>> amdgpu_device *adev,
>>>>       }
>>>>         if (printk_ratelimit()) {
>>>> -        struct amdgpu_task_info task_info;
>>>> -
>>>> -        memset(&task_info, 0, sizeof(struct amdgpu_task_info));
>>>> -        amdgpu_vm_get_task_info(adev, entry->pasid, &task_info);
>>>> +        struct amdgpu_task_info *task_info;
>>>>             dev_err(adev->dev,
>>>> -            "[%s] page fault (src_id:%u ring:%u vmid:%u pasid:%u, 
>>>> for process %s pid %d thread %s pid %d)\n",
>>>> +            "[%s] page fault (src_id:%u ring:%u vmid:%u pasid:%u)\n",
>>>>               entry->vmid_src ? "mmhub" : "gfxhub",
>>>>               entry->src_id, entry->ring_id, entry->vmid,
>>>> -            entry->pasid, task_info.process_name, task_info.tgid,
>>>> -            task_info.task_name, task_info.pid);
>>>> +            entry->pasid);
>>>> +
>>>> +        task_info = amdgpu_vm_get_task_info(adev, entry->pasid);
>>>> +        if (task_info)
>>>> +            dev_err(adev->dev, " for process %s pid %d thread %s 
>>>> pid %d\n",
>>>> +                task_info->process_name, task_info->tgid,
>>>> +                task_info->task_name, task_info->pid);
>>>> +        amdgpu_vm_put_task_info(adev, entry->pasid);
>>>> +
>>>>           dev_err(adev->dev, "  in page starting at address 
>>>> 0x%016llx from client %d\n",
>>>>               addr, entry->client_id);
>>>>           if (!amdgpu_sriov_vf(adev))
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c 
>>>> b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
>>>> index 5af235202513..8759ef1c5ea5 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
>>>> @@ -1446,14 +1446,19 @@ static int 
>>>> gmc_v8_0_process_interrupt(struct amdgpu_device *adev,
>>>>           gmc_v8_0_set_fault_enable_default(adev, false);
>>>>         if (printk_ratelimit()) {
>>>> -        struct amdgpu_task_info task_info;
>>>> +        struct amdgpu_task_info *task_info;
>>>>   -        memset(&task_info, 0, sizeof(struct amdgpu_task_info));
>>>> -        amdgpu_vm_get_task_info(adev, entry->pasid, &task_info);
>>>> +        dev_err(adev->dev, "GPU fault detected: %d 0x%08x\n",
>>>> +            entry->src_id, entry->src_data[0]);
>>>> +
>>>> +        task_info = amdgpu_vm_get_task_info(adev, entry->pasid);
>>>> +        if (task_info) {
>>>> +            dev_err(adev->dev, "for process %s pid %d thread %s 
>>>> pid %d\n\n",
>>>> +                task_info->process_name, task_info->tgid,
>>>> +                task_info->task_name, task_info->pid);
>>>> +        }
>>>> +        amdgpu_vm_put_task_info(adev, entry->pasid);
>>>>   -        dev_err(adev->dev, "GPU fault detected: %d 0x%08x for 
>>>> process %s pid %d thread %s pid %d\n",
>>>> -            entry->src_id, entry->src_data[0], 
>>>> task_info.process_name,
>>>> -            task_info.tgid, task_info.task_name, task_info.pid);
>>>>           dev_err(adev->dev, " VM_CONTEXT1_PROTECTION_FAULT_ADDR   
>>>> 0x%08X\n",
>>>>               addr);
>>>>           dev_err(adev->dev, " VM_CONTEXT1_PROTECTION_FAULT_STATUS 
>>>> 0x%08X\n",
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c 
>>>> b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>>>> index f9a5a2c0573e..75b849d69875 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>>>> @@ -550,7 +550,7 @@ static int gmc_v9_0_process_interrupt(struct 
>>>> amdgpu_device *adev,
>>>>       bool retry_fault = !!(entry->src_data[1] & 0x80);
>>>>       bool write_fault = !!(entry->src_data[1] & 0x20);
>>>>       uint32_t status = 0, cid = 0, rw = 0;
>>>> -    struct amdgpu_task_info task_info;
>>>> +    struct amdgpu_task_info *task_info;
>>>>       struct amdgpu_vmhub *hub;
>>>>       const char *mmhub_cid;
>>>>       const char *hub_name;
>>>> @@ -625,16 +625,19 @@ static int gmc_v9_0_process_interrupt(struct 
>>>> amdgpu_device *adev,
>>>>       if (!printk_ratelimit())
>>>>           return 0;
>>>>   -
>>>> -    memset(&task_info, 0, sizeof(struct amdgpu_task_info));
>>>> -    amdgpu_vm_get_task_info(adev, entry->pasid, &task_info);
>>>> -
>>>>       dev_err(adev->dev,
>>>> -        "[%s] %s page fault (src_id:%u ring:%u vmid:%u pasid:%u, 
>>>> for process %s pid %d thread %s pid %d)\n",
>>>> +        "[%s] %s page fault (src_id:%u ring:%u vmid:%u pasid:%u)\n",
>>>>           hub_name, retry_fault ? "retry" : "no-retry",
>>>>           entry->src_id, entry->ring_id, entry->vmid,
>>>> -        entry->pasid, task_info.process_name, task_info.tgid,
>>>> -        task_info.task_name, task_info.pid);
>>>> +        entry->pasid);
>>>> +
>>>> +    task_info = amdgpu_vm_get_task_info(adev, entry->pasid);
>>>> +    if (task_info)
>>>> +        dev_err(adev->dev, " process %s pid %d thread %s pid %d\n",
>>>> +            task_info->process_name, task_info->tgid,
>>>> +            task_info->task_name, task_info->pid);
>>>> +    amdgpu_vm_put_task_info(adev, entry->pasid);
>>>> +
>>>>       dev_err(adev->dev, "  in page starting at address 0x%016llx 
>>>> from IH client 0x%x (%s)\n",
>>>>           addr, entry->client_id,
>>>>           soc15_ih_clientid_name[entry->client_id]);
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c 
>>>> b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
>>>> index cd37f45e01a1..d3b9fe74332a 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
>>>> @@ -2112,7 +2112,7 @@ static int sdma_v4_0_print_iv_entry(struct 
>>>> amdgpu_device *adev,
>>>>                             struct amdgpu_iv_entry *entry)
>>>>   {
>>>>       int instance;
>>>> -    struct amdgpu_task_info task_info;
>>>> +    struct amdgpu_task_info *task_info;
>>>>       u64 addr;
>>>>         instance = sdma_v4_0_irq_id_to_seq(entry->client_id);
>>>> @@ -2124,15 +2124,16 @@ static int sdma_v4_0_print_iv_entry(struct 
>>>> amdgpu_device *adev,
>>>>       addr = (u64)entry->src_data[0] << 12;
>>>>       addr |= ((u64)entry->src_data[1] & 0xf) << 44;
>>>>   -    memset(&task_info, 0, sizeof(struct amdgpu_task_info));
>>>> -    amdgpu_vm_get_task_info(adev, entry->pasid, &task_info);
>>>> -
>>>>       dev_dbg_ratelimited(adev->dev,
>>>> -           "[sdma%d] address:0x%016llx src_id:%u ring:%u vmid:%u "
>>>> -           "pasid:%u, for process %s pid %d thread %s pid %d\n",
>>>> -           instance, addr, entry->src_id, entry->ring_id, 
>>>> entry->vmid,
>>>> -           entry->pasid, task_info.process_name, task_info.tgid,
>>>> -           task_info.task_name, task_info.pid);
>>>> +           "[sdma%d] address:0x%016llx src_id:%u ring:%u vmid:%u 
>>>> pasid:%u\n",
>>>> +           instance, addr, entry->src_id, entry->ring_id, 
>>>> entry->vmid, entry->pasid);
>>>> +
>>>> +    task_info = amdgpu_vm_get_task_info(adev, entry->pasid);
>>>> +    if (task_info)
>>>> +        dev_dbg_ratelimited(adev->dev, "for process %s pid %d 
>>>> thread %s pid %d\n",
>>>> +                    task_info->process_name, task_info->tgid,
>>>> +                    task_info->task_name, task_info->pid);
>>>> +    amdgpu_vm_put_task_info(adev, entry->pasid);
>>>>       return 0;
>>>>   }
>>>>   diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c 
>>>> b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
>>>> index f413898dda37..56c2f744d64e 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
>>>> @@ -1633,7 +1633,7 @@ static int sdma_v4_4_2_print_iv_entry(struct 
>>>> amdgpu_device *adev,
>>>>                             struct amdgpu_iv_entry *entry)
>>>>   {
>>>>       int instance;
>>>> -    struct amdgpu_task_info task_info;
>>>> +    struct amdgpu_task_info *task_info;
>>>>       u64 addr;
>>>>         instance = sdma_v4_4_2_irq_id_to_seq(entry->client_id);
>>>> @@ -1645,15 +1645,17 @@ static int 
>>>> sdma_v4_4_2_print_iv_entry(struct amdgpu_device *adev,
>>>>       addr = (u64)entry->src_data[0] << 12;
>>>>       addr |= ((u64)entry->src_data[1] & 0xf) << 44;
>>>>   -    memset(&task_info, 0, sizeof(struct amdgpu_task_info));
>>>> -    amdgpu_vm_get_task_info(adev, entry->pasid, &task_info);
>>>> -
>>>>       dev_dbg_ratelimited(adev->dev,
>>>> -           "[sdma%d] address:0x%016llx src_id:%u ring:%u vmid:%u "
>>>> -           "pasid:%u, for process %s pid %d thread %s pid %d\n",
>>>> -           instance, addr, entry->src_id, entry->ring_id, 
>>>> entry->vmid,
>>>> -           entry->pasid, task_info.process_name, task_info.tgid,
>>>> -           task_info.task_name, task_info.pid);
>>>> +           "[sdma%d] address:0x%016llx src_id:%u ring:%u vmid:%u 
>>>> pasid:%u\n",
>>>> +           instance, addr, entry->src_id, entry->ring_id, 
>>>> entry->vmid, entry->pasid);
>>>> +
>>>> +    task_info = amdgpu_vm_get_task_info(adev, entry->pasid);
>>>> +    if (task_info)
>>>> +        dev_dbg_ratelimited(adev->dev, "for process %s pid %d 
>>>> thread %s pid %d\n",
>>>> +                    task_info->process_name, task_info->tgid,
>>>> +                    task_info->task_name, task_info->pid);
>>>> +    amdgpu_vm_put_task_info(adev, entry->pasid);
>>>> +
>>>>       return 0;
>>>>   }
>>>>   diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c 
>>>> b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
>>>> index d9953c2b2661..6b51262811f6 100644
>>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
>>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
>>>> @@ -238,16 +238,18 @@ void 
>>>> kfd_smi_event_update_thermal_throttling(struct kfd_node *dev,
>>>>     void kfd_smi_event_update_vmfault(struct kfd_node *dev, 
>>>> uint16_t pasid)
>>>>   {
>>>> -    struct amdgpu_task_info task_info;
>>>> +    struct amdgpu_task_info *task_info;
>>>>   -    memset(&task_info, 0, sizeof(struct amdgpu_task_info));
>>>> -    amdgpu_vm_get_task_info(dev->adev, pasid, &task_info);
>>>>       /* Report VM faults from user applications, not retry from 
>>>> kernel */
>>>> -    if (!task_info.pid)
>>>> -        return;
>>>> +    task_info = amdgpu_vm_get_task_info(dev->adev, pasid);
>>>> +    if (!task_info || !task_info->pid)
>>>> +        goto unref;
>>>>         kfd_smi_event_add(0, dev, KFD_SMI_EVENT_VMFAULT, "%x:%s\n",
>>>> -              task_info.pid, task_info.task_name);
>>>> +              task_info->pid, task_info->task_name);
>>>> +
>>>> +unref:
>>>> +    amdgpu_vm_put_task_info(dev->adev, pasid);
>>>>   }
>>>>     void kfd_smi_event_page_fault_start(struct kfd_node *node, 
>>>> pid_t pid,
>>

