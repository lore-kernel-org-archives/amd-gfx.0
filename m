Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C5ABCDB483
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Oct 2023 22:15:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AB02A10E209;
	Mon, 16 Oct 2023 22:15:26 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2047.outbound.protection.outlook.com [40.107.93.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4FA0A10E22B
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Oct 2023 22:15:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j8iVufR7+yUdWHzQ0hdMoyZX05ywRMRsMkN3No+IXJVFmySF9TmyBYOLOlXwKnHgBlsoVRWvlNqyDzKL0Ujfy3EuHnZXo56w9aZgfZN4QoZV3Gh3FB+FIzpDoplYzOKNiHFe2pWTXTPeNzcImBRzZb3NITvrPjAkCQUGd80dxE29Jab2epgAdZSMexV3SOJ4ntIVq3ZGQk36u8eBIns8ZuIxCMPndrd0MkK3CEDZfwPDkjCF50/cIElkygtrpZtHwkYpdrGmNCjn3prZ+PFFINFY49Eb5v+FLA9qD91Qh4ZMft8X5kjHbcx6Ulqy/t1IFJtFYOJYgrE+WjDoNQg9bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ajgceAeyWuJGzthlzAjqCJzj35OunU5pZGUmXPsCTec=;
 b=W/1j9kYw1U3n1YqvDY3pZJxKHGtDqaYcu7ek/CKE/VI302zjIid72FkilzRz8cvcscnvaomdudckfHLaWIbqSGN6R78csAb9BRf3qrb25H1+48LV/i+WxqeUMSSfOZHV452SBRK22MhwyIpi4q/ZeQzv/5PXd6umwoT7CUAes+HzLZMWIoGYd9Arz3WG3M04nP9NFTXJiCsyhSq/qVvqBB0/+UWSqngx3SunItDjflInc3TzKMThFz/IUq0g6PHyYDpcsLTojcBm33ShwIUw3oWoX7B4nbzdh/Z90191K56Sk+NZkYKrxHnC5WbpLRjsn3amHq+pPHbs3PMts6AjDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ajgceAeyWuJGzthlzAjqCJzj35OunU5pZGUmXPsCTec=;
 b=FOJufu54olhxt0Tao5oBPMdoF5K5sXYFYcziVFXpF5jLmmD39Vpifz6T4O9jKcOhBVMogQlIcA85Qx8B3C8NZ3rOuYW0aq5u6U5FO268uvH71gVt4Jm1mYQuRoc5bmXFd5uUOMJFfK9zBv7gQcn2YKeZoWZI9U+nnzr/luVFDh0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by BN9PR12MB5179.namprd12.prod.outlook.com (2603:10b6:408:11c::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36; Mon, 16 Oct
 2023 22:15:21 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::2e40:ffd7:e752:644f]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::2e40:ffd7:e752:644f%6]) with mapi id 15.20.6886.034; Mon, 16 Oct 2023
 22:15:21 +0000
Message-ID: <b6709537-e2a4-4694-b5a6-862212ed0cbf@amd.com>
Date: Mon, 16 Oct 2023 18:15:18 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: move task_info to amdgpu_fpriv
Content-Language: en-US
To: Shashank Sharma <shashank.sharma@amd.com>, amd-gfx@lists.freedesktop.org
References: <20231016170820.979-1-shashank.sharma@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20231016170820.979-1-shashank.sharma@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0294.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:6d::18) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|BN9PR12MB5179:EE_
X-MS-Office365-Filtering-Correlation-Id: efdb08f7-8ba7-4528-4196-08dbce9562fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Jn59ueMFQoj+uGqXmLhXpt96m7G+xp2gR9uJWT0uY5hnq5fIH+d/U6R1+zUQOpJnbJFlOD5Qqe8Kk6xEJoIQUSdJvxEZCuI6FD+LCRc1sqh4IJ9VMLT0QL/xhGHicO9NshGnjfm34+W/3iDqhdT+fuvf6OsB7BJrZgFMpS0uEjAJAo2etCc/z544V/EUbGcSza5eJSePyhhd/YKxzt1R0lH27fdJeS8m6cseXOapOUPpSXQj345orL+/Lk9nZk6FhK16Og2Q6ZWwztMj0yZT3rfb2fCFsS0jOr5l4pRgmjIU21q4ueV330mAnU19OxxJCFyl/XXnHt5uRLdqt2nLSrOz0b7nitkZpLejFLP1okN4cid76Lpt0Wj0kNHI5B3CtlY27RYiNJX8flszrMRiWZgqMlsoM7aVNP/s+qPUktND+v3fjj3KXNMPf9DNoDrhFkMuAXA4D0mSpesuvWKIOXdcpIvb6dAZ3IJR12tjo+D5esvQvK1Daq+x/XD1uGqKT1R1T9tD7Zf/HQ4HVlUXHoRsFyrtxCrYMD9FRUSHqgBuD6r+YJRee00kZfsTjBzeO0l3WU/nyR+dIQ9ykkvpR5XTTJachOF7JSpUdGigJpoP1+GK+m25Sgz2xeli796XlszMstwVdcozUgT6qENryw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(396003)(366004)(346002)(136003)(39860400002)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(6512007)(26005)(2616005)(30864003)(83380400001)(66556008)(66476007)(8676002)(4326008)(54906003)(66946007)(8936002)(316002)(41300700001)(53546011)(6666004)(6506007)(36916002)(5660300002)(44832011)(478600001)(2906002)(6486002)(38100700002)(4001150100001)(86362001)(31696002)(36756003)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SHJRY2lWMktPYzNsN2c5SFVKeXloaVNRM2c5MG8vMXE2Q2w5b2syMkliZkRV?=
 =?utf-8?B?YllleFBmVTM4UXUxSktRaldzV3NGK3BjanNvWVpTWFNDNythU214c1EybGE3?=
 =?utf-8?B?STFRTERxY3ZIeHo0a3N5WUVvUzB5WEZ3TGFUZHliS3pQZTQ2Q21pZ0I2ZTAx?=
 =?utf-8?B?QU1nRnEyNXhIeC85Q3VMSVlRc1RuRFFPVWp3QVVhSTdYdmluVzZxMWIvZnVt?=
 =?utf-8?B?NUZYenNhUTkvYVN4N2N6WENsNW1FUVROY3Vacjd4T2g4bHB3eVlaSzNUN2xX?=
 =?utf-8?B?azhWdVhpaUxDTEpyMzVOZHI1NDgyb3hycWlBbE5ET0RKU3JvWnB1bGNtdit6?=
 =?utf-8?B?YzVyQXZKTm04SDd6MkV1WityZVI2d2gzZ1FtclFaWjVPSFdkMUlxQ1B5aTNW?=
 =?utf-8?B?T3FpMHNiMkExSE5FaUlPbG5xM2lNSVg2czJOMXlDMDNHOFQxdThqS0sxWmlB?=
 =?utf-8?B?WmhYMk8rVW1WL2p6NEc4MXFwNitvMWg2cnQ1RllzRDVtMXJ3dDR6dk9ueGhV?=
 =?utf-8?B?cEpyekdjQmdBZGxaL3BGeXJNd1RQeDBRNk82NExKVEE5THhiZ0QwTnVrcUlK?=
 =?utf-8?B?b05FWmRVc0trWEdIbVRxejF1c0pZWnJBbW56MjRkdjBJS1lEOHhLZzgva20x?=
 =?utf-8?B?NTRHUllINDBaT0tWTnFJZEYySW5BWThTQTJUNHQvUnNxWG80Sk9PdFVZK3dJ?=
 =?utf-8?B?d2dQUE1tbkIxSWQzUzVMb29uTGg4SkI4bnR2eTFrNkRZTHJvbkE4MDVjVjEz?=
 =?utf-8?B?UUJ0WXpYNGozckRva1h2QUp6OWZSczAzZm1BVjFXc0NRVkhPcXZ0L0RnMVND?=
 =?utf-8?B?UlIyUkxXV1VUYSt6eGt0VUVzU1JlZ05YNXFmS2NwNkVJMkxrUHdWdVhLbFVx?=
 =?utf-8?B?NXFETUxOSFdTYkVYQmhqNXRXb0RkQ0lsZE9VWFJUUlhkcFRKaVNDbWx6d2Vp?=
 =?utf-8?B?Smg2SlE0WDRyQ1JlcXRpVk9RZGdMTE9CNzNRbFV0UWJvcFB2M3dPT3pHdlNy?=
 =?utf-8?B?NnFweTE2dXRsSGcwWnBhQjROKzNDdTJaazJ0dkFUZVd0YkIyV1V1ZEc2a1Nh?=
 =?utf-8?B?R1hDeXZPQ1ZrOTAyKzJSQUQ1V29leW1tRk9yWC9ibWV0WVV5ZkNaUlE3UDAy?=
 =?utf-8?B?U0svTHJkTGRsc05HdDV1eXlxSUMxQmVua2dSUHpvYlZBOEJkOWdXeS8xQkk1?=
 =?utf-8?B?SkdQRUd6bUo1R3d3d21nellLRDZYck44Zzk0M2VzTlkwdmdZZzV0bzFWZFRS?=
 =?utf-8?B?TE5JbFdxNjFMcU1qZ2RVb2tUR2pTdmI0eGdNK2E2cFFNcFRrSGdXN0RGK3Ri?=
 =?utf-8?B?RUMyMHFSck1La0psZklJVHFFbGp2YnFCdzZ0bUJiREhjZk5DSmNvZFI5aUJ2?=
 =?utf-8?B?Qy96WTdmWTRRMGErdW5CTzg2UUdGdVBwdTc5NFIvdW9tOCtQRytwQW5VcUxZ?=
 =?utf-8?B?cTlLNUF3U0lKcm5JeXVNQ3g5eWREVTJHRDhmKzRzTzhCTjY2eUJrSm9BSHZZ?=
 =?utf-8?B?OVJlbDYvcnJGZS9EdThCRGUyZTRFcytSVldEdis0a3J3cUJCTzZnN3R0SzNB?=
 =?utf-8?B?bDZ5ekczcmxvTzZsdGZPN1I3L2lmV2hJV0tYUERuYm5pa2dnUUd3dWlJV1hO?=
 =?utf-8?B?UFRwSmFQcHdqK3RiOWlUMXdoN1pabVNiZVFUVmQxQm8xVFI3VjRMVXZCYXBT?=
 =?utf-8?B?USt5TkdIcjNzWXZtYkIyMlhhbFhMYzdFa25UeExEL0lPWm0yMkEyQkE3eTZy?=
 =?utf-8?B?NlBkcnNreTB4SGc5aXRrOFFzcDZWSmh4cDloZjFZRnFZSEwvQlEyVE5mbUxr?=
 =?utf-8?B?bldVTFhoaFUyQTVXdG5kUnB4clNJUmxCaVJZUGttTUpWR2dTZGMwNkJWWHJt?=
 =?utf-8?B?T1hyT2ZNNXhmNVo4OWJNVDJqbTZQb01mOEdxNW1XSVJHMy85eERIaXIvNTZH?=
 =?utf-8?B?KzQra3gvbzU3K25FQ1VBQ0Mwb29wZHJ6bVRRRE1zOE02Rm9aZGNlY0RFVjdZ?=
 =?utf-8?B?d2ljSWNTYzJDSGRSWUxnL1FYNGwwQ2pEWkd0OXpvVGZiVUM2Vy8rNnltcVlC?=
 =?utf-8?B?OHExQWhPOFVqUXBJbGNXYUo0VmswaHBGUjBTSlpGMDVFRkUwUHdTUE5ueDhk?=
 =?utf-8?Q?DU2joTBvxyxVleITZcFQ0DF9G?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efdb08f7-8ba7-4528-4196-08dbce9562fb
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2023 22:15:21.0720 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QHvAccoYqdXxhNr5AjLFEB3GhoNc7KWDsWk80UtiKWTrLzHf31/yDz7utjEPEjiC04q+CRlr9yzK9zkaZDPcPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5179
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Christian Koenig <christian.koenig@amd.com>, arvind.yadav@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2023-10-16 13:08, Shashank Sharma wrote:
> This patch does the following:
> - moves vm->task_info struct to fpriv->task_info.
> - makes task_info allocation dynamic.
> - adds reference counting support for task_info structure.
> - adds some new helper functions to find and put task_info.
> - adds respective supporting changes for existing get_task_info consumers.
>
> Cc: Christian Koenig <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h         |  2 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c |  4 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c  | 28 +++++--
>   drivers/gpu/drm/amd/amdgpu/amdgpu_job.c     | 16 ++--
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c      | 87 ++++++++++++++++-----
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h      |  9 +--
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c   |  5 +-
>   drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c      | 19 +++--
>   drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c      | 18 +++--
>   drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c       | 17 ++--
>   drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c       | 19 +++--
>   drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c      | 19 ++---
>   drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c    | 20 ++---
>   drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c | 14 ++--
>   14 files changed, 186 insertions(+), 91 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index dc2d53081e80..a90780d38725 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -469,6 +469,8 @@ struct amdgpu_fpriv {
>   	struct mutex		bo_list_lock;
>   	struct idr		bo_list_handles;
>   	struct amdgpu_ctx_mgr	ctx_mgr;
> +	struct amdgpu_task_info *task_info;
> +
>   	/** GPU partition selection */
>   	uint32_t		xcp_id;
>   };
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> index a4faea4fa0b5..6e9dcd13ee34 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> @@ -1763,9 +1763,11 @@ static int amdgpu_debugfs_vm_info_show(struct seq_file *m, void *unused)
>   	list_for_each_entry(file, &dev->filelist, lhead) {
>   		struct amdgpu_fpriv *fpriv = file->driver_priv;
>   		struct amdgpu_vm *vm = &fpriv->vm;
> +		struct amdgpu_task_info *task_info = fpriv->task_info;
>   
>   		seq_printf(m, "pid:%d\tProcess:%s ----------\n",
> -				vm->task_info.pid, vm->task_info.process_name);
> +				task_info ? task_info->pid : 0,
> +				task_info ? task_info->process_name : "");
>   		r = amdgpu_bo_reserve(vm->root.bo, true);
>   		if (r)
>   			break;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 3f001a50b34a..b372a87b9b77 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -4872,6 +4872,27 @@ static void amdgpu_reset_capture_coredumpm(struct amdgpu_device *adev)
>   	dev_coredumpm(dev->dev, THIS_MODULE, adev, 0, GFP_NOWAIT,
>   		      amdgpu_devcoredump_read, amdgpu_devcoredump_free);
>   }
> +
> +static void
> +amdgpu_reset_dev_coredump(struct amdgpu_device *adev, struct amdgpu_reset_context *reset_context)
> +{
> +	struct amdgpu_task_info *ti;
> +	struct amdgpu_vm *vm;
> +
> +	if (!reset_context->job || !reset_context->job->vm)
> +		return;
> +
> +	vm = reset_context->job->vm;
> +
> +	/* Get reset task info and save a copy of data to be consumed later */
> +	ti = amdgpu_vm_get_task_info(adev, vm->pasid);
> +	if (ti) {
> +		adev->reset_task_info = *ti;
> +		amdgpu_reset_capture_coredumpm(adev);
> +	}
> +
> +	amdgpu_vm_put_task_info(adev, vm->pasid);
> +}
>   #endif
>   
>   int amdgpu_do_asic_reset(struct list_head *device_list_handle,
> @@ -4976,12 +4997,7 @@ int amdgpu_do_asic_reset(struct list_head *device_list_handle,
>   				vram_lost = amdgpu_device_check_vram_lost(tmp_adev);
>   #ifdef CONFIG_DEV_COREDUMP
>   				tmp_adev->reset_vram_lost = vram_lost;
> -				memset(&tmp_adev->reset_task_info, 0,
> -						sizeof(tmp_adev->reset_task_info));
> -				if (reset_context->job && reset_context->job->vm)
> -					tmp_adev->reset_task_info =
> -						reset_context->job->vm->task_info;
> -				amdgpu_reset_capture_coredumpm(tmp_adev);
> +				amdgpu_reset_dev_coredump(tmp_adev, reset_context);
>   #endif
>   				if (vram_lost) {
>   					DRM_INFO("VRAM is lost due to GPU reset!\n");
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> index 78476bc75b4e..99cf30c0bce6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> @@ -35,7 +35,7 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
>   {
>   	struct amdgpu_ring *ring = to_amdgpu_ring(s_job->sched);
>   	struct amdgpu_job *job = to_amdgpu_job(s_job);
> -	struct amdgpu_task_info ti;
> +	struct amdgpu_task_info *ti;
>   	struct amdgpu_device *adev = ring->adev;
>   	int idx;
>   	int r;
> @@ -48,7 +48,6 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
>   		return DRM_GPU_SCHED_STAT_ENODEV;
>   	}
>   
> -	memset(&ti, 0, sizeof(struct amdgpu_task_info));
>   	adev->job_hang = true;
>   
>   	if (amdgpu_gpu_recovery &&
> @@ -58,12 +57,15 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
>   		goto exit;
>   	}
>   
> -	amdgpu_vm_get_task_info(ring->adev, job->pasid, &ti);
>   	DRM_ERROR("ring %s timeout, signaled seq=%u, emitted seq=%u\n",
> -		  job->base.sched->name, atomic_read(&ring->fence_drv.last_seq),
> -		  ring->fence_drv.sync_seq);
> -	DRM_ERROR("Process information: process %s pid %d thread %s pid %d\n",
> -		  ti.process_name, ti.tgid, ti.task_name, ti.pid);
> +		   job->base.sched->name, atomic_read(&ring->fence_drv.last_seq),
> +		   ring->fence_drv.sync_seq);
> +
> +	ti = amdgpu_vm_get_task_info(ring->adev, job->pasid);
> +	if (ti)
> +		DRM_ERROR("Process information: process %s pid %d thread %s pid %d\n",
> +			   ti->process_name, ti->tgid, ti->task_name, ti->pid);
> +	amdgpu_vm_put_task_info(ring->adev, job->pasid);
>   
>   	dma_fence_set_error(&s_job->s_fence->finished, -ETIME);
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index f5daadcec865..aabfbb8edb2b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -2335,6 +2335,7 @@ void amdgpu_vm_fini(struct amdgpu_device *adev, struct amdgpu_vm *vm)
>   
>   	root = amdgpu_bo_ref(vm->root.bo);
>   	amdgpu_bo_reserve(root, true);
> +	amdgpu_vm_put_task_info(adev, vm->pasid);
>   	amdgpu_vm_set_pasid(adev, vm, 0);
>   	dma_fence_wait(vm->last_unlocked, false);
>   	dma_fence_put(vm->last_unlocked);
> @@ -2491,26 +2492,44 @@ int amdgpu_vm_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
>   	return 0;
>   }
>   
> +static struct
> +amdgpu_task_info *amdgpu_vm_find_task_info(struct amdgpu_device *adev, u32 pasid)
> +{
> +	unsigned long flags;
> +	struct amdgpu_vm *vm;
> +	struct amdgpu_fpriv *fpriv;
> +	struct amdgpu_task_info *task_info = NULL;
> +
> +	xa_lock_irqsave(&adev->vm_manager.pasids, flags);
> +
> +	vm = xa_load(&adev->vm_manager.pasids, pasid);
> +	if (vm) {
> +		fpriv = container_of(vm, struct amdgpu_fpriv, vm);
> +		task_info = fpriv->task_info;
> +	}
> +
> +	xa_unlock_irqrestore(&adev->vm_manager.pasids, flags);
> +	return task_info;
> +}
> +
>   /**
>    * amdgpu_vm_get_task_info - Extracts task info for a PASID.
>    *
>    * @adev: drm device pointer
>    * @pasid: PASID identifier for VM
> - * @task_info: task_info to fill.
> + *
> + * returns the task_info* (refrence counted) set under the vm_pasid
> + * user must call amdgpu_vm_put_task_info when done with the task_info ptr
>    */
> -void amdgpu_vm_get_task_info(struct amdgpu_device *adev, u32 pasid,
> -			 struct amdgpu_task_info *task_info)
> +struct amdgpu_task_info *amdgpu_vm_get_task_info(struct amdgpu_device *adev, u32 pasid)
>   {
> -	struct amdgpu_vm *vm;
> -	unsigned long flags;
> -
> -	xa_lock_irqsave(&adev->vm_manager.pasids, flags);
> +	struct amdgpu_task_info *ti;
>   
> -	vm = xa_load(&adev->vm_manager.pasids, pasid);
> -	if (vm)
> -		*task_info = vm->task_info;
> +	ti = amdgpu_vm_find_task_info(adev, pasid);
> +	if (ti)
> +		kref_get(&ti->refcount);
>   
> -	xa_unlock_irqrestore(&adev->vm_manager.pasids, flags);
> +	return ti;
>   }
>   
>   /**
> @@ -2520,17 +2539,49 @@ void amdgpu_vm_get_task_info(struct amdgpu_device *adev, u32 pasid,
>    */
>   void amdgpu_vm_set_task_info(struct amdgpu_vm *vm)
>   {
> -	if (vm->task_info.pid)
> -		return;
> +	struct amdgpu_fpriv *fpriv = container_of(vm, struct amdgpu_fpriv, vm);
> +	struct amdgpu_task_info *task_info;
>   
> -	vm->task_info.pid = current->pid;
> -	get_task_comm(vm->task_info.task_name, current);
> +	if (fpriv->task_info)
> +		return;
>   
> -	if (current->group_leader->mm != current->mm)
> +	task_info = kzalloc(sizeof(*task_info), GFP_KERNEL);
> +	if (!task_info) {
> +		DRM_ERROR("OOM while task_info creation\n");
>   		return;
> +	}
> +
> +	kref_init(&task_info->refcount);
> +	task_info->pid = current->pid;
> +	get_task_comm(task_info->task_name, current);
> +
> +	if (current->group_leader->mm != current->mm) {
> +		task_info->tgid = current->group_leader->pid;
> +		get_task_comm(task_info->process_name, current->group_leader);
> +	}
> +
> +	kref_get(&task_info->refcount);
> +	fpriv->task_info = task_info;
> +}
> +
> +static void amdgpu_vm_free_task_info(struct kref *kref)
> +{
> +	kfree(container_of(kref, struct amdgpu_task_info, refcount));
> +}
> +
> +/**
> + * amdgpu_vm_put_task_info - reference down the task_info ptr.
> + *
> + * @adev: drm device pointer
> + * @pasid: PASID identifier for VM
> + */
> +void amdgpu_vm_put_task_info(struct amdgpu_device *adev, u32 pasid)
> +{
> +	struct amdgpu_task_info *ti;
>   
> -	vm->task_info.tgid = current->group_leader->pid;
> -	get_task_comm(vm->task_info.process_name, current->group_leader);
> +	ti = amdgpu_vm_find_task_info(adev, pasid);
This doesn't make sense. Anyone trying to drop a reference should 
already have a ti * from a previous amdgpu_vm_get_task_info call. You 
don't need to find it again. Just pass the ti * from the caller to this 
function.

Regards,
   Felix


> +	if (ti)
> +		kref_put(&ti->refcount, amdgpu_vm_free_task_info);
>   }
>   
>   /**
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> index 204ab13184ed..40a8c532a5ed 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> @@ -187,6 +187,7 @@ struct amdgpu_task_info {
>   	char	task_name[TASK_COMM_LEN];
>   	pid_t	pid;
>   	pid_t	tgid;
> +	struct kref refcount;
>   };
>   
>   /**
> @@ -333,9 +334,6 @@ struct amdgpu_vm {
>   	/* Valid while the PD is reserved or fenced */
>   	uint64_t		pd_phys_addr;
>   
> -	/* Some basic info about the task */
> -	struct amdgpu_task_info task_info;
> -
>   	/* Store positions of group of BOs */
>   	struct ttm_lru_bulk_move lru_bulk_move;
>   	/* Flag to indicate if VM is used for compute */
> @@ -466,8 +464,9 @@ bool amdgpu_vm_need_pipeline_sync(struct amdgpu_ring *ring,
>   				  struct amdgpu_job *job);
>   void amdgpu_vm_check_compute_bug(struct amdgpu_device *adev);
>   
> -void amdgpu_vm_get_task_info(struct amdgpu_device *adev, u32 pasid,
> -			     struct amdgpu_task_info *task_info);
> +struct amdgpu_task_info *
> +amdgpu_vm_get_task_info(struct amdgpu_device *adev, u32 pasid);
> +void amdgpu_vm_put_task_info(struct amdgpu_device *adev, u32 pasid);
>   bool amdgpu_vm_handle_fault(struct amdgpu_device *adev, u32 pasid,
>   			    u32 vmid, u32 node_id, uint64_t addr,
>   			    bool write_fault);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> index 96d601e209b8..3d7a9ad963a8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> @@ -1023,21 +1023,24 @@ int amdgpu_vm_ptes_update(struct amdgpu_vm_update_params *params,
>   			uint64_t upd_end = min(entry_end, frag_end);
>   			unsigned int nptes = (upd_end - frag_start) >> shift;
>   			uint64_t upd_flags = flags | AMDGPU_PTE_FRAG(frag);
> +			struct amdgpu_task_info *task_info;
>   
>   			/* This can happen when we set higher level PDs to
>   			 * silent to stop fault floods.
>   			 */
>   			nptes = max(nptes, 1u);
>   
> +			task_info = amdgpu_vm_get_task_info(adev, vm->pasid);
>   			trace_amdgpu_vm_update_ptes(params, frag_start, upd_end,
>   						    min(nptes, 32u), dst, incr,
>   						    upd_flags,
> -						    vm->task_info.tgid,
> +						    task_info ? task_info->tgid : 0,
>   						    vm->immediate.fence_context);
>   			amdgpu_vm_pte_update_flags(params, to_amdgpu_bo_vm(pt),
>   						   cursor.level, pe_start, dst,
>   						   nptes, incr, upd_flags);
>   
> +			amdgpu_vm_put_task_info(adev, vm->pasid);
>   			pe_start += nptes * 8;
>   			dst += nptes * incr;
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> index fa87a85e1017..14ded13c8b09 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> @@ -107,7 +107,7 @@ static int gmc_v10_0_process_interrupt(struct amdgpu_device *adev,
>   	struct amdgpu_vmhub *hub = &adev->vmhub[vmhub_index];
>   	bool retry_fault = !!(entry->src_data[1] & 0x80);
>   	bool write_fault = !!(entry->src_data[1] & 0x20);
> -	struct amdgpu_task_info task_info;
> +	struct amdgpu_task_info *task_info;
>   	uint32_t status = 0;
>   	u64 addr;
>   
> @@ -155,15 +155,18 @@ static int gmc_v10_0_process_interrupt(struct amdgpu_device *adev,
>   	if (!printk_ratelimit())
>   		return 0;
>   
> -	memset(&task_info, 0, sizeof(struct amdgpu_task_info));
> -	amdgpu_vm_get_task_info(adev, entry->pasid, &task_info);
> -
> -	dev_err(adev->dev,
> -		"[%s] page fault (src_id:%u ring:%u vmid:%u pasid:%u, for process %s pid %d thread %s pid %d)\n",
> +	dev_err(adev->dev, "[%s] page fault (src_id:%u ring:%u vmid:%u pasid:%u)\n",
>   		entry->vmid_src ? "mmhub" : "gfxhub",
>   		entry->src_id, entry->ring_id, entry->vmid,
> -		entry->pasid, task_info.process_name, task_info.tgid,
> -		task_info.task_name, task_info.pid);
> +		entry->pasid);
> +
> +	task_info = amdgpu_vm_get_task_info(adev, entry->pasid);
> +	if (task_info)
> +		dev_err(adev->dev, "for process %s pid %d thread %s pid %d\n",
> +				   task_info->process_name, task_info->tgid,
> +				   task_info->task_name, task_info->pid);
> +	amdgpu_vm_put_task_info(adev, entry->pasid);
> +
>   	dev_err(adev->dev, "  in page starting at address 0x%016llx from client 0x%x (%s)\n",
>   		addr, entry->client_id,
>   		soc15_ih_clientid_name[entry->client_id]);
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> index e3b76fd28d15..2d96567171bc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> @@ -120,17 +120,21 @@ static int gmc_v11_0_process_interrupt(struct amdgpu_device *adev,
>   	}
>   
>   	if (printk_ratelimit()) {
> -		struct amdgpu_task_info task_info;
> -
> -		memset(&task_info, 0, sizeof(struct amdgpu_task_info));
> -		amdgpu_vm_get_task_info(adev, entry->pasid, &task_info);
> +		struct amdgpu_task_info *task_info;
>   
>   		dev_err(adev->dev,
> -			"[%s] page fault (src_id:%u ring:%u vmid:%u pasid:%u, for process %s pid %d thread %s pid %d)\n",
> +			"[%s] page fault (src_id:%u ring:%u vmid:%u pasid:%u)\n",
>   			entry->vmid_src ? "mmhub" : "gfxhub",
>   			entry->src_id, entry->ring_id, entry->vmid,
> -			entry->pasid, task_info.process_name, task_info.tgid,
> -			task_info.task_name, task_info.pid);
> +			entry->pasid);
> +
> +		task_info = amdgpu_vm_get_task_info(adev, entry->pasid);
> +		if (task_info)
> +			dev_err(adev->dev, " for process %s pid %d thread %s pid %d\n",
> +				task_info->process_name, task_info->tgid,
> +				task_info->task_name, task_info->pid);
> +		amdgpu_vm_put_task_info(adev, entry->pasid);
> +
>   		dev_err(adev->dev, "  in page starting at address 0x%016llx from client %d\n",
>   			addr, entry->client_id);
>   		if (!amdgpu_sriov_vf(adev))
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
> index 5af235202513..8759ef1c5ea5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
> @@ -1446,14 +1446,19 @@ static int gmc_v8_0_process_interrupt(struct amdgpu_device *adev,
>   		gmc_v8_0_set_fault_enable_default(adev, false);
>   
>   	if (printk_ratelimit()) {
> -		struct amdgpu_task_info task_info;
> +		struct amdgpu_task_info *task_info;
>   
> -		memset(&task_info, 0, sizeof(struct amdgpu_task_info));
> -		amdgpu_vm_get_task_info(adev, entry->pasid, &task_info);
> +		dev_err(adev->dev, "GPU fault detected: %d 0x%08x\n",
> +			entry->src_id, entry->src_data[0]);
> +
> +		task_info = amdgpu_vm_get_task_info(adev, entry->pasid);
> +		if (task_info) {
> +			dev_err(adev->dev, "for process %s pid %d thread %s pid %d\n\n",
> +				task_info->process_name, task_info->tgid,
> +				task_info->task_name, task_info->pid);
> +		}
> +		amdgpu_vm_put_task_info(adev, entry->pasid);
>   
> -		dev_err(adev->dev, "GPU fault detected: %d 0x%08x for process %s pid %d thread %s pid %d\n",
> -			entry->src_id, entry->src_data[0], task_info.process_name,
> -			task_info.tgid, task_info.task_name, task_info.pid);
>   		dev_err(adev->dev, "  VM_CONTEXT1_PROTECTION_FAULT_ADDR   0x%08X\n",
>   			addr);
>   		dev_err(adev->dev, "  VM_CONTEXT1_PROTECTION_FAULT_STATUS 0x%08X\n",
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> index f9a5a2c0573e..75b849d69875 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> @@ -550,7 +550,7 @@ static int gmc_v9_0_process_interrupt(struct amdgpu_device *adev,
>   	bool retry_fault = !!(entry->src_data[1] & 0x80);
>   	bool write_fault = !!(entry->src_data[1] & 0x20);
>   	uint32_t status = 0, cid = 0, rw = 0;
> -	struct amdgpu_task_info task_info;
> +	struct amdgpu_task_info *task_info;
>   	struct amdgpu_vmhub *hub;
>   	const char *mmhub_cid;
>   	const char *hub_name;
> @@ -625,16 +625,19 @@ static int gmc_v9_0_process_interrupt(struct amdgpu_device *adev,
>   	if (!printk_ratelimit())
>   		return 0;
>   
> -
> -	memset(&task_info, 0, sizeof(struct amdgpu_task_info));
> -	amdgpu_vm_get_task_info(adev, entry->pasid, &task_info);
> -
>   	dev_err(adev->dev,
> -		"[%s] %s page fault (src_id:%u ring:%u vmid:%u pasid:%u, for process %s pid %d thread %s pid %d)\n",
> +		"[%s] %s page fault (src_id:%u ring:%u vmid:%u pasid:%u)\n",
>   		hub_name, retry_fault ? "retry" : "no-retry",
>   		entry->src_id, entry->ring_id, entry->vmid,
> -		entry->pasid, task_info.process_name, task_info.tgid,
> -		task_info.task_name, task_info.pid);
> +		entry->pasid);
> +
> +	task_info = amdgpu_vm_get_task_info(adev, entry->pasid);
> +	if (task_info)
> +		dev_err(adev->dev, " process %s pid %d thread %s pid %d\n",
> +			task_info->process_name, task_info->tgid,
> +			task_info->task_name, task_info->pid);
> +	amdgpu_vm_put_task_info(adev, entry->pasid);
> +
>   	dev_err(adev->dev, "  in page starting at address 0x%016llx from IH client 0x%x (%s)\n",
>   		addr, entry->client_id,
>   		soc15_ih_clientid_name[entry->client_id]);
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> index cd37f45e01a1..d3b9fe74332a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> @@ -2112,7 +2112,7 @@ static int sdma_v4_0_print_iv_entry(struct amdgpu_device *adev,
>   					      struct amdgpu_iv_entry *entry)
>   {
>   	int instance;
> -	struct amdgpu_task_info task_info;
> +	struct amdgpu_task_info *task_info;
>   	u64 addr;
>   
>   	instance = sdma_v4_0_irq_id_to_seq(entry->client_id);
> @@ -2124,15 +2124,16 @@ static int sdma_v4_0_print_iv_entry(struct amdgpu_device *adev,
>   	addr = (u64)entry->src_data[0] << 12;
>   	addr |= ((u64)entry->src_data[1] & 0xf) << 44;
>   
> -	memset(&task_info, 0, sizeof(struct amdgpu_task_info));
> -	amdgpu_vm_get_task_info(adev, entry->pasid, &task_info);
> -
>   	dev_dbg_ratelimited(adev->dev,
> -		   "[sdma%d] address:0x%016llx src_id:%u ring:%u vmid:%u "
> -		   "pasid:%u, for process %s pid %d thread %s pid %d\n",
> -		   instance, addr, entry->src_id, entry->ring_id, entry->vmid,
> -		   entry->pasid, task_info.process_name, task_info.tgid,
> -		   task_info.task_name, task_info.pid);
> +		   "[sdma%d] address:0x%016llx src_id:%u ring:%u vmid:%u pasid:%u\n",
> +		   instance, addr, entry->src_id, entry->ring_id, entry->vmid, entry->pasid);
> +
> +	task_info = amdgpu_vm_get_task_info(adev, entry->pasid);
> +	if (task_info)
> +		dev_dbg_ratelimited(adev->dev, "for process %s pid %d thread %s pid %d\n",
> +				    task_info->process_name, task_info->tgid,
> +				    task_info->task_name, task_info->pid);
> +	amdgpu_vm_put_task_info(adev, entry->pasid);
>   	return 0;
>   }
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> index f413898dda37..56c2f744d64e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> @@ -1633,7 +1633,7 @@ static int sdma_v4_4_2_print_iv_entry(struct amdgpu_device *adev,
>   					      struct amdgpu_iv_entry *entry)
>   {
>   	int instance;
> -	struct amdgpu_task_info task_info;
> +	struct amdgpu_task_info *task_info;
>   	u64 addr;
>   
>   	instance = sdma_v4_4_2_irq_id_to_seq(entry->client_id);
> @@ -1645,15 +1645,17 @@ static int sdma_v4_4_2_print_iv_entry(struct amdgpu_device *adev,
>   	addr = (u64)entry->src_data[0] << 12;
>   	addr |= ((u64)entry->src_data[1] & 0xf) << 44;
>   
> -	memset(&task_info, 0, sizeof(struct amdgpu_task_info));
> -	amdgpu_vm_get_task_info(adev, entry->pasid, &task_info);
> -
>   	dev_dbg_ratelimited(adev->dev,
> -		   "[sdma%d] address:0x%016llx src_id:%u ring:%u vmid:%u "
> -		   "pasid:%u, for process %s pid %d thread %s pid %d\n",
> -		   instance, addr, entry->src_id, entry->ring_id, entry->vmid,
> -		   entry->pasid, task_info.process_name, task_info.tgid,
> -		   task_info.task_name, task_info.pid);
> +		   "[sdma%d] address:0x%016llx src_id:%u ring:%u vmid:%u pasid:%u\n",
> +		   instance, addr, entry->src_id, entry->ring_id, entry->vmid, entry->pasid);
> +
> +	task_info = amdgpu_vm_get_task_info(adev, entry->pasid);
> +	if (task_info)
> +		dev_dbg_ratelimited(adev->dev, "for process %s pid %d thread %s pid %d\n",
> +				    task_info->process_name, task_info->tgid,
> +				    task_info->task_name, task_info->pid);
> +	amdgpu_vm_put_task_info(adev, entry->pasid);
> +
>   	return 0;
>   }
>   
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
> index d9953c2b2661..6b51262811f6 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
> @@ -238,16 +238,18 @@ void kfd_smi_event_update_thermal_throttling(struct kfd_node *dev,
>   
>   void kfd_smi_event_update_vmfault(struct kfd_node *dev, uint16_t pasid)
>   {
> -	struct amdgpu_task_info task_info;
> +	struct amdgpu_task_info *task_info;
>   
> -	memset(&task_info, 0, sizeof(struct amdgpu_task_info));
> -	amdgpu_vm_get_task_info(dev->adev, pasid, &task_info);
>   	/* Report VM faults from user applications, not retry from kernel */
> -	if (!task_info.pid)
> -		return;
> +	task_info = amdgpu_vm_get_task_info(dev->adev, pasid);
> +	if (!task_info || !task_info->pid)
> +		goto unref;
>   
>   	kfd_smi_event_add(0, dev, KFD_SMI_EVENT_VMFAULT, "%x:%s\n",
> -			  task_info.pid, task_info.task_name);
> +			  task_info->pid, task_info->task_name);
> +
> +unref:
> +	amdgpu_vm_put_task_info(dev->adev, pasid);
>   }
>   
>   void kfd_smi_event_page_fault_start(struct kfd_node *node, pid_t pid,
