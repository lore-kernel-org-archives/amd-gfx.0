Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95D0DC433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Mar 2022 15:22:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 213B410E9FD;
	Thu, 10 Mar 2022 15:22:50 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2048.outbound.protection.outlook.com [40.107.223.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C523710E9FD
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Mar 2022 15:22:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=axNkbMKwCL3YsOzB7E96ZMaloXN/kk6l8XD5RT6ea7ZagQILQAdjqXpxaeMWUZ6tuF0L0hEc/7UoiDUNB2lxNTHrycIZ0vGQmAsE57hLXgtOqHnMFqVb5vSY+ICHG7xUx7J85qcxSOVkrj1E0ZyU3tku8gFqobmNc/MFVT1+KLyWXdEWqcxuGghbRWSBUdbMYBrQkSXu/mpPB6fV7tR/KspXdl875FPnEO8SGbllv+zVcKl36Kg0BKY/qCA1PlrWqLtMfJgXuutcRKu0mrdw9/9gOyVg7iNVaMMV6H2F1Y/lxpcOH8TkXen+ZiA03ch/BY6WZT5tHqjIRDRL40mmkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TaC6VbiqunlDFbwKnkj64B0SnupvfqH/cubE966yOa8=;
 b=dPZSxkf4prIuPg8zMZj8kZzfCUG8LOt0nsu5tH/ageansgbJab3QI5TrkS0ttT5/ooszBtOQvCNOKRUlYt08Cri8ANb0G7Jyn6IrwtRZZFear0GvRxm345G5fAssibFfhTp6fQq9NvGhzAVoIgMuRzknK0lo/xwH2xRIOyi0urSrXtbb0NdOvhoqcO+KS5Joe3dLXdF0u3+aUFMxy1AXdMbJa3wMFTV+lBzPLEgIuD2Y9M8/HTwLzjou8g4iupOQHpiVQUML7kvF7e4xTfXCzJ6MZljmtigyQVUVFfOMPMDY36oltB8J56k5MnRKOWt2TYuFSLJXBwyGPhfygjK0WQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TaC6VbiqunlDFbwKnkj64B0SnupvfqH/cubE966yOa8=;
 b=4YXXUN6ZidIYaQPmucTboK10LuEOtvsy3POd7ONR4HQR0JwPg0ncavM3dk7yO2kvfHnVfRZxcY6I3ty41jipSKluJPJ8I7pfc3V7GgbTPW+GK1XavOdL00N02A0LLDXOWseHLQH+AxemsCWFsGXfq9370cJYvKkx6J5EJiOegxg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1947.namprd12.prod.outlook.com (2603:10b6:3:111::23)
 by DM4PR12MB5817.namprd12.prod.outlook.com (2603:10b6:8:60::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.16; Thu, 10 Mar
 2022 15:22:46 +0000
Received: from DM5PR12MB1947.namprd12.prod.outlook.com
 ([fe80::90bd:5b12:918d:5703]) by DM5PR12MB1947.namprd12.prod.outlook.com
 ([fe80::90bd:5b12:918d:5703%5]) with mapi id 15.20.5038.027; Thu, 10 Mar 2022
 15:22:46 +0000
Message-ID: <aa976262-2b16-f922-a379-28d086b7d7c5@amd.com>
Date: Thu, 10 Mar 2022 10:22:44 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] drm/amdgpu: schedule GPU reset event work function
Content-Language: en-US
To: Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20220310090702.52749-1-Amaranath.Somalapuram@amd.com>
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
In-Reply-To: <20220310090702.52749-1-Amaranath.Somalapuram@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR02CA0017.namprd02.prod.outlook.com
 (2603:10b6:610:4e::27) To DM5PR12MB1947.namprd12.prod.outlook.com
 (2603:10b6:3:111::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 28c6e767-78a9-4c2d-671f-08da02a9d493
X-MS-TrafficTypeDiagnostic: DM4PR12MB5817:EE_
X-Microsoft-Antispam-PRVS: <DM4PR12MB581702BED3F1AE18E17D6925EA0B9@DM4PR12MB5817.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PyJFz7Vq/shO/HWxak62W5YjjFqSopb2nos7YMLMqhbntgGVwjcnLzd8kP7hcx9NYRxWsVfi57sbdoizy+KnvaiwG+JRlwnzyCALS8ndK5/J7va5ZuwV/3SzlSUkiFiqrZ4b5D/pwtrQ/fGvm1BieRnCz+kQ8f8D95gSqrskchx0WZgMOn2tIPhSLdjO6hLzR1QsBcMMmJKkvUxoDmkiWSfqxK1eCgFAjWbFFyUcbfOvbIuMrRxpdFFIdh8reVmeXSRe8XC+AbByclj71SYXZ7jBC9FQuu2b1w7j+fZZCxGgTP4aocNKv0Y5fFjfSBGjrmy35F7t9js/agUxX/uon9ucOfzx5ObgadIjuNbqKKb4lqTdCBvMaa79DRXr6INni1Wxc1pZkmbzwe0zqf548kHcziLbnD1aEPhUIPeMt7wSq+LqAVU5QXe8H024lJS4Kvuo+qvQHbL++2jxEmPqnHrXOLd3D2bitQcHIjOUEgiFNV2ZHbZjC/ACcoaE3eCHvHRwguxIFf6ZFDkRZKShnA/bS/Izmyjkx5GLxNuBWOkC6M0faXZbhMbKkFcCUAcL94FWEiLjktz7zzC8orlatyIz/UA8c06wkcplons02c5Z41XPRT8UZr6h5ZTcqTeQm9RQ6uwwcCzfUe0l8vN7W6jM3l294NEARldo/Mt5Fgecme489ajaIfbe2Y9/xkDati5PcMDWtwOrRuE++CJROmcuKjziW6qzHiyN82nj5iRBQFMaU63hxXi3Gp0Yj5Mh
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1947.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(6486002)(8936002)(186003)(31696002)(508600001)(2906002)(86362001)(8676002)(4326008)(66946007)(66476007)(36756003)(38100700002)(44832011)(5660300002)(316002)(53546011)(6506007)(6512007)(2616005)(31686004)(66556008)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M1BnV2hEV21HVGhKQXhiZmZtejRwNkVrVDAyN1dEVTNBbzA0QllQR0VIRm9B?=
 =?utf-8?B?ZS9oVjlldkR3Q3UvN0lnQTVhWDBRMTFmSDg1LzZLL255NEorNGw3S2JjR3lP?=
 =?utf-8?B?U2VvK2JxZ3lJNCtkMzNIa3phODQ4bm5xVFRNRmo0R09uRVh6L0pnZmlwdS9t?=
 =?utf-8?B?dTJCdzE2aWpndUxuZ1NEN25SNm4wQnhCOXIwSWJFV3FSSjJvRCtCVDNSc2dM?=
 =?utf-8?B?dzJKUSt0RWlzRFJwQ3cyWE5FR2FrOWYyT1ZXcmU1K0JoNVZUa0tjdENubTlm?=
 =?utf-8?B?VHdmR3VjVnR6eld2R1Y3WXNjcXR1NzlsZFl1RXN4L2xDYVliYlNuVGpwTXF4?=
 =?utf-8?B?VkREclJnakZNcUNYVkUyN1dhbHNKMVVBT2c0RGkvWGtEelIwdm1vWkIrd0dN?=
 =?utf-8?B?M1ZFWlI4QnRnSHBvWnhCQllMdmpuRWpZZEQrWHJsUWFtVEdQUVFxWmUwZ1VH?=
 =?utf-8?B?TEVCS0o0TDVneTdwQlpNTkxlZFRkZDNoWUF4aTg2WlNqQzNQNUs2aVVFbVlL?=
 =?utf-8?B?QzlEOWFZc3Y2ZTBlUHVSQk9HL0gzS0VLeDVvRU1yT0pvQVJLZDBTN3p1UGh2?=
 =?utf-8?B?TlRvNCtUbDd4ZEVRb0RxTDQ2YmVzSjZRY2h1UVVDMWg3SWZ5a0lxaVVENmhU?=
 =?utf-8?B?dVVVMXN4VHVVR3NYSExveWhxc0dMbzZlSGRhZzdkR01lTUE0SEdVaGdVeWJx?=
 =?utf-8?B?c2orRkJsLzZFWDJPemwxU0R0K1RKWjBJNzNiNXNQREcwaFdCYk8vU1prS25P?=
 =?utf-8?B?aFpXeUluSzdock1hTFhHbFEySkluSHV4Y3h2S1Nuc014eXBtcm1uNnlybEdC?=
 =?utf-8?B?VCs5NGZuOHAyZE9BTzY2WStYZUk3WTBHNlp0R0EvaDNFY05od3VTbHlHODA0?=
 =?utf-8?B?aFZMUTdpakprQWdsZ2xNQ2IxbWd4UFBWTHMyYm4xOENBQ05VY201MGdDd0h6?=
 =?utf-8?B?L1Q1alFaazhaMC9qczB4KzZiYjlUQ1BXZ3k3WDRCaDZSd0E2WVhtWHBMS0Vs?=
 =?utf-8?B?OXZIS0hWeE9RVkJ3ZG5VeCtOK21lTFhtYitjN1BxVXR3V0VTNXNMYVJldklY?=
 =?utf-8?B?Wlp2bDZzTTFUMlJDbkYwbERlczN5RnZmZUlpT0JrazhhQy8vN2VZVUVTQ2kx?=
 =?utf-8?B?YVU2bmQvemo3Ky92cnh0UUlodVU4SERGY1pIZktIMEdVRUh0QmF5Ymc5R25h?=
 =?utf-8?B?N0R3d2o3QW5DWmRUcWIwcW44NENpZ2I5L00rdDdaTkpEd01QZUpYdzE0cVNZ?=
 =?utf-8?B?Rklqc3dVaGtFRkpDeVFreHlHWW1BVzR3MldwZ3JydUN6UU9NNFdhRlhLamkz?=
 =?utf-8?B?cVVTZkNobWpBSFo0YUd3Z2M3QjBjdVNzaDJRSm9xUEEvdU5JY3FSaVNOWnd3?=
 =?utf-8?B?dllDMU1QR3hneUxxMGZnanFVWXIzYjVVYnhLZVV6VDBHYUlNd0h2WnFPcWk3?=
 =?utf-8?B?YXgvKzd5SitaNEdMS241cmFzZWp2NFZYTEM5WEFIUndzMVl1RzdxVnBEWEJ6?=
 =?utf-8?B?SG1ldzc3UHVNcVJjVDFZdUpFNjZpVGcrN05BdlU2dDc3dHhzTUdzWi9QZWRN?=
 =?utf-8?B?cDBSNDVpejJ5bHF0VE8xMFBpZ3M5RHNKT2d0M1hqZkZwUmYvMzRDY3djOGds?=
 =?utf-8?B?ZTNoWEk5cWJXYXJGME9DcmF0YkFseFJIajJBK1JUM1pZNHlnWGNRVVJWZTFq?=
 =?utf-8?B?VlpLS1h1RWpaTlVpUE1YRW1RaEFwbVFCVUxsVGNnZlphNERZMHkxTG1kbnky?=
 =?utf-8?B?VnFuR2dqUnVNeG44cFpLU1lkcFRmcFFKU1Q2Y0g4Z3NERUdqeVN6NmtqQnA5?=
 =?utf-8?B?c2ppellzTzQvQ0dzUkQ5Q1NMOXl2MjJ3Ym8xbnZ1TWY5NHJjaXJEenZOdjFq?=
 =?utf-8?B?ZlorSkZHZmlYZXpjdzBzTkVnbGpDcllnTnlSWEVzMTlTdDNxSlNqSTh2WlJ1?=
 =?utf-8?B?eEVFQlNqRWg2aE1JWEhsSzJTRzJrSExmWGVmUzNVWXg0Nk8vSmlWWE1iSGJI?=
 =?utf-8?B?dzdsbFA3VzVlRTBjUmRXREMvZzY3VUNDblRzbG02TU9OcEpRUzQ0ci9pOUxX?=
 =?utf-8?B?ZHN0aW90d2w5ZXoweFR1RUhESTlsOWtzWnBNQUZlOFdUVDVzSytVaVZLbUll?=
 =?utf-8?B?TUU5aDN6eXdQb0dXWDVQVnd5Q3JKTXdoVUV0dkhGRFkxejVQSllhZ1dWTWpq?=
 =?utf-8?B?Rm9zZi9HdjJzd0djbnBxbGNhSFJvU0Q3dWJiT2hnQS9oWm00WnZrRzk4RjVw?=
 =?utf-8?Q?eQUZIXtMgD09SvUfN3z5TSYNqxYWVLN8v5xOkGQ25s=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28c6e767-78a9-4c2d-671f-08da02a9d493
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1947.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2022 15:22:46.7536 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XeP0N1HRCr8lSqvBCUxQfD++tx04XSU5MHKTImwF0WiHeumOFcV1RjNA81n5BZPpymIKLRZrApSBNNk3LJYNPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5817
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
Cc: alexander.deucher@amd.com, christian.koenig@amd.com,
 shashank.sharma@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Reviewed-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>

Andrey

On 2022-03-10 04:07, Somalapuram Amaranath wrote:
> Schedule work function with valid PID, process name and
> vram lost status during a GPU reset/recovery.
>
> Signed-off-by: Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 13 +++++++++++++
>   1 file changed, 13 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 02843479e1ef..7ca4f52e393f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -4805,6 +4805,19 @@ int amdgpu_do_asic_reset(struct list_head *device_list_handle,
>   					goto out;
>   
>   				vram_lost = amdgpu_device_check_vram_lost(tmp_adev);
> +				if (reset_context->job && reset_context->job->vm) {
> +					tmp_adev->reset_event_info.pid =
> +						reset_context->job->vm->task_info.pid;
> +					memset(tmp_adev->reset_event_info.pname, 0, TASK_COMM_LEN);
> +					strcpy(tmp_adev->reset_event_info.pname,
> +						reset_context->job->vm->task_info.process_name);
> +				} else {
> +					tmp_adev->reset_event_info.pid = 0;
> +					memset(tmp_adev->reset_event_info.pname, 0, TASK_COMM_LEN);
> +				}
> +
> +				tmp_adev->reset_event_info.flags = vram_lost;
> +				schedule_work(&tmp_adev->gpu_reset_event_work);
>   				if (vram_lost) {
>   					DRM_INFO("VRAM is lost due to GPU reset!\n");
>   					amdgpu_inc_vram_lost(tmp_adev);
