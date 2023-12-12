Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39A0DC4332F
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Dec 2023 17:49:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BC8ED10E64F;
	Tue, 12 Dec 2023 17:49:31 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4BDBB10E64F
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Dec 2023 17:49:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Uw8Uo+o/1m0zYH7v2ePUkOB4E5RFgPNWOssdAIsZkfkRPDKll2BRbcnlQJg1tlI6I/wjJX1pZDHorstHH4zGHRrpZwkpl4+0a7Z7BqW1Y5LWYKX/bGIaA7jqdUvbMgcbGmMDxHkiFBvlSYCY5Uib0zrITfP7kyk3htK6lr32tUSBC86NENAdhp9ztFSlOOeQXG80seMQvjf34hbuo+PxO+I6O9MVpsQKAMm8PlulQeHU2gIQ9vQ+IlqaTwQ+SpeSlTnOHMCzP76rt9HpdMlSnn8QckqEUQkvT/ZyM+g2XRxKJnlnXai44xix+EUjmH4O1JiqQ1ffklYTTN9dIm6m4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rYG32DJsLGppQ8MvtZ1CM40Xnlf7xEZs2VDoLlkMIFU=;
 b=Jsu3CZjniM1R3dPw3Tn7Aicu7lL+X8EOqC7YCPTA8cIYuWSJPyjyoCy/3irQBeF0la/bIjdeCU1T3KBDh8ot5swKt9m3gEGLvHMcad7ORQwgfzw07vEDHDlsJJlCYzaaf9HHrr/rTVIKhAk4fZ6VohZcutYI8gZWD/RCunfP4OeTojzcqz9W5Mns/hVpal38sCKxysQGx5s1J6v0fNKBNwWKDa/QjIaCup86vFpl/Jj96ayrmLRyiYWN0iqqGbUVcJrsuaeCkIbKy/7QcXUP1csS0BmOJJI0LvXGsefT92SZeMjo7vpkRjFgyYEknT+/xAPnpDEMHOX5/ROsjRzWXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rYG32DJsLGppQ8MvtZ1CM40Xnlf7xEZs2VDoLlkMIFU=;
 b=tWAoK4K+SEGsaX6GuUBPteEsDNKnolOdU4hnFxh8TcxRPfa9CaXskXRUmf40QjK+FcOfsAGgvfCXQewt+ICW5tv5iEpVb0S1SitX+wOxmEGQI6jq/vnzwtSOeU5d5Mrz6Co6A141wlRy7PEzZ0eAkoSFX1rxp2kEWMePnWXSlUI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5336.namprd12.prod.outlook.com (2603:10b6:208:314::8)
 by SA0PR12MB4494.namprd12.prod.outlook.com (2603:10b6:806:94::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26; Tue, 12 Dec
 2023 17:49:26 +0000
Received: from BL1PR12MB5336.namprd12.prod.outlook.com
 ([fe80::7ef6:8317:95ab:ce40]) by BL1PR12MB5336.namprd12.prod.outlook.com
 ([fe80::7ef6:8317:95ab:ce40%3]) with mapi id 15.20.7068.033; Tue, 12 Dec 2023
 17:49:26 +0000
Message-ID: <c4fc2b14-07b1-4b27-b460-166dcb343d74@amd.com>
Date: Tue, 12 Dec 2023 12:49:22 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: fix mes set shader debugger process management
To: Jonathan Kim <Jonathan.Kim@amd.com>, amd-gfx@lists.freedesktop.org
References: <20231211211612.3109-1-Jonathan.Kim@amd.com>
Content-Language: en-US
From: Eric Huang <jinhuieric.huang@amd.com>
In-Reply-To: <20231211211612.3109-1-Jonathan.Kim@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0005.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:85::29) To BL1PR12MB5336.namprd12.prod.outlook.com
 (2603:10b6:208:314::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5336:EE_|SA0PR12MB4494:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b88c19c-ef00-4b55-628b-08dbfb3aaec3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: N3vIvuFWQ0Wc4JWk0UjUW+vC0cin+hgeRqr+rPw2s85XG2J/5tnSBoaWpMT4ODLxl0XV40wXDbwu72Hiho1RCaAmZqV/k3muFSwHalNGpENXsrXJKOfo4OIxzL6OuAkGLAj1B0MAOqa3mN1/BNvBA4L1gnhi84ZaWj3TjIF6OVg9bc+iSbqGmjx+FfnR26/j7b+f7ZK8XeGQLvrKkVlcjSciCrA+oHGbGXZjMbthLpIC7rPefWqbfBKARMiFoKc0GUDA0HYVBfEJcUTpdDIlzGOeZ6iHxmEBTmzJhIuutIoFKH2Ddh0bKf9At6VZowaIh+ivCWQdWwlKtbH1YUldTyqJpSCra98y4uYqS5Npo7fSyTAa7NiWrsFP97zvHMeZNSNyMiDPexdTiXsuLu9IfZ6/ujUXLzWwUmPRHlAka/7PiattKNRFwTlPROU5qUmbED7Zq9mFU/X+hfvepwDyiWUpvNQhb4/75esMcVgjcsTZzSC4qiND7Uw3ahmKVaT8J8R1TY1cPmGU50z63NkpZfDxRZ1WzYJ6BAhGqZFhgdKGtwvdy+mBCpy7SCnHc7nuO4Bz7hg/57K3QKz0lstoscrM4UUJiyypGmMafUc7iBO+FnqtRx5d/mpH8Ys/Wyq04ljqakkzpZw+gsHO7qJBBg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5336.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(366004)(136003)(376002)(396003)(346002)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(83380400001)(6506007)(53546011)(2616005)(6512007)(38100700002)(8676002)(5660300002)(4326008)(8936002)(26005)(41300700001)(2906002)(4001150100001)(6486002)(6666004)(478600001)(316002)(66476007)(66946007)(66556008)(36756003)(31696002)(86362001)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MVFKdkRZVTA0a3l5TWNzWmtncnNYOEZyUHFMRHgwSkZTdHNobTZsNlNMaHlQ?=
 =?utf-8?B?ZkRHQkkrSnRQakNoMllRZVFjUkowVHhIdkp5QjJicXRyd1R1SHFnR1dsWnUr?=
 =?utf-8?B?WlZqbi9qa3dTM1Z2TlBiQVRWdU9MbVVRaXdvQ0VMd2QvY1lxeFgvMzJVWHZS?=
 =?utf-8?B?ZTd0NzZJZWxUVXNKeGU2dHU3MW9mQ01Oc3g3MTFDQ2lOaFpjcFhEbHhCdHpM?=
 =?utf-8?B?Y3hJYjN0TlhHck9DbUIvejBoTWFVQk1TcEFLWVNreGYrNXBmWWY1N1ZteXZo?=
 =?utf-8?B?YnBmS0syMmQ3aUNKdXdVWk45TDQwZ2ZwVzFsWnBMRDNBSHpab0hZYlFiVUQ3?=
 =?utf-8?B?WnIrcjkwYmpCWnRTSG9XNmJWYWlBN0VxVWVKWThHdmY3dXEwazRORHBWM1NU?=
 =?utf-8?B?eG8zeFFTY0E0YlpaT2VXMDhyZkdHWVZhSUpQek15bkJRREhEZ0MwTXRqNXlK?=
 =?utf-8?B?cEFLL3N2TDA4STVQWUluNVUrRDdTVWt3dEVKM3dvcTg0QVd2b2hrSTBVc1FL?=
 =?utf-8?B?WmpQVzYyc1A1VVN1eVkzV1JTMU1ld3habmVTZmcrVWVqNVRQNWl4Ynp1QWx2?=
 =?utf-8?B?amdIY2FSanBFR0IrUlR6ZnRvSVIzYXZZK1R3TllYVEVzUytIeEpUMUZBVEJu?=
 =?utf-8?B?THo3YmN3Y3dCSDNUUWFHbjNDR1ZUa082TjVpSjBIMHRDQXI1V3U3N0V4UFpS?=
 =?utf-8?B?Vnl1UFdQOVZkSUVqa2Mwbm1WNG0wS1R1cXIvQnE5NTVUWlQ2MWo5UGFRaUpW?=
 =?utf-8?B?dTJKaVVEZGFCMzJqS3h0QlBpcmQzd3RPR1Y0TEh4eG1IOTFodE5nQjRSVjZm?=
 =?utf-8?B?S2JmamtEUXV0WDZZRjNFdXNxUnVYRXExanVzZ0pFWkNzWmtJUEJUVW1kaC9E?=
 =?utf-8?B?RVF0WWNvcjVrSGlRVENabFY2MitybUNhSzdONTI5SXpCQVJBZVdpK3BmbHJJ?=
 =?utf-8?B?d3hmcVlyV2Y5N1VjNzdTZ2tkS3lyb2NCVjI4UWM5Z0ZDd3l4QzdwcUF2dTVW?=
 =?utf-8?B?VytOWXdRV3VHNzF3Z0R3eUNsN3RaNmhBc0Vta1pmVTMwRjhCUjJCMHVWaEVi?=
 =?utf-8?B?YmFhc3lXeHdNd0hzYXRsek1zbmNjdTU2QldKMTZHZnlsaHBRQWx5SytjMFRx?=
 =?utf-8?B?MDlLNmN5cGZYNUdLYlltYzZ6M1I2K016YjF1L2dTNjV1a1JrdEp2eEtsRWEz?=
 =?utf-8?B?eGROdFlKRG1BUUZiYWdtbzJRN1NveHlvT1BmRlFOeHY1ZXFJbDZXTDBjbHNn?=
 =?utf-8?B?bFpRWEV4QlZGSzV0TDdhczNWMWwrT2NjMHpMbU4wYTNhY2hiZ2xzeVdGd1ZW?=
 =?utf-8?B?VFNhbmg3b3VNdlV2YTBaRDgyd2o4aGxoUHlKemh6OWl6S2ZQL1JsNFVtWmVj?=
 =?utf-8?B?aWJuaG9PeG16ZnhtUUN6L3gra0hRVElJR01sT1dKa2NHRGNtcnlUTXlBaGFw?=
 =?utf-8?B?NmZVMyswQVlBRHJjaFVWNW5zdDhkNGhHNWd0VjhidVp0SStReTViYVphdUwx?=
 =?utf-8?B?VG1DTEcxTjVnbEZTaURxY3hKSkw5RHh2S1pqRHFUVWpiTmhWNEtsK2l4UVVu?=
 =?utf-8?B?ODRQdnVKNjA3dGpFYmN4b2hRN25rSGVLNCtBejMwV3cyUnY4RWg3WDJmZXM1?=
 =?utf-8?B?dFcxMTZGTFI2bThoaFpZVUV2d1lXQnN4RE5aOEdpNE51VU1DV1pobjhhaXMw?=
 =?utf-8?B?bnF3K2pjMzBSZ1U1Vlc2VkFLbnJYMzBZNWV4cXVocys2MDVyUW9idEZ2VEYw?=
 =?utf-8?B?UGxQMkMyYkFvNlp4UHU0QUI0NHN1aEg1N1A1RENsMkgrUlBSWCtsY3dONUt4?=
 =?utf-8?B?OFJ3NCtCQ0xlWUJ6cHZxUUxLakxlTUNvNmNVK1o2QXIvNm9OdHB0N2lIaWtN?=
 =?utf-8?B?b0JDc1JEREptYzJUeWtUdm5qeXRSU3duZ0ttY1hNNk1zQ1cvcmZ1NmErQW5J?=
 =?utf-8?B?MUxrOTMvWjFQdnRvZlZZNmVuWlM3Tll5NVp3bDhrczhzdGFTK2JPcW5Qb1Y5?=
 =?utf-8?B?VStFYjFleVRla1BCMmhCdjQvL1g5dnFjbTN3UkJrM0R1am1hY3c3WjhDVmxY?=
 =?utf-8?B?V21iU0J2Qkt3TExJWHdMbERsMWZtWmJ6RTVVQXhqWTJCUndVUENxd3BKdXNu?=
 =?utf-8?Q?KmHb/xEAJguipH6YGxHryqrsL?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b88c19c-ef00-4b55-628b-08dbfb3aaec3
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5336.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2023 17:49:26.4386 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zHcxxxoi0lE/Nx6QiikpO41tVhm3j9ZO7iMjD3fwjFhPo6iAw5PUKZhk86WJW8cDVgxBIFQ2L4srra0n9jurXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4494
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
Cc: Alice Wong <shiwei.wong@amd.com>, Felix.Kuehling@amd.com,
 Harish.Kasiviswanathan@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 2023-12-11 16:16, Jonathan Kim wrote:
> MES provides the driver a call to explicitly flush stale process memory
> within the MES to avoid a race condition that results in a fatal
> memory violation.
>
> When SET_SHADER_DEBUGGER is called, the driver passes a memory address
> that represents a process context address MES uses to keep track of
> future per-process calls.
>
> Normally, MES will purge its process context list when the last queue
> has been removed.  The driver, however, can call SET_SHADER_DEBUGGER
> regardless of whether a queue has been added or not.
>
> If SET_SHADER_DEBUGGER has been called with no queues as the last call
> prior to process termination, the passed process context address will
> still reside within MES.
>
> On a new process call to SET_SHADER_DEBUGGER, the driver may end up
> passing an identical process context address value (based on per-process
> gpu memory address) to MES but is now pointing to a new allocated buffer
> object during KFD process creation.  Since the MES is unaware of this,
> access of the passed address points to the stale object within MES and
> triggers a fatal memory violation.
>
> The solution is for KFD to explicitly flush the process context address
> from MES on process termination.
>
> Note that the flush call and the MES debugger calls use the same MES
> interface but are separated as KFD calls to avoid conflicting with each
> other.
>
> Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
> Tested-by: Alice Wong <shiwei.wong@amd.com>
Reviewed-by: Eric Huang <jinhuieric.huang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c       | 31 +++++++++++++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h       | 10 +++---
>   .../amd/amdkfd/kfd_process_queue_manager.c    |  1 +
>   drivers/gpu/drm/amd/include/mes_v11_api_def.h |  3 +-
>   4 files changed, 40 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> index e544b823abf6..e98de23250dc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> @@ -916,6 +916,11 @@ int amdgpu_mes_set_shader_debugger(struct amdgpu_device *adev,
>   	op_input.op = MES_MISC_OP_SET_SHADER_DEBUGGER;
>   	op_input.set_shader_debugger.process_context_addr = process_context_addr;
>   	op_input.set_shader_debugger.flags.u32all = flags;
> +
> +	/* use amdgpu mes_flush_shader_debugger instead */
> +	if (op_input.set_shader_debugger.flags.process_ctx_flush)
> +		return -EINVAL;
> +
>   	op_input.set_shader_debugger.spi_gdbg_per_vmid_cntl = spi_gdbg_per_vmid_cntl;
>   	memcpy(op_input.set_shader_debugger.tcp_watch_cntl, tcp_watch_cntl,
>   			sizeof(op_input.set_shader_debugger.tcp_watch_cntl));
> @@ -935,6 +940,32 @@ int amdgpu_mes_set_shader_debugger(struct amdgpu_device *adev,
>   	return r;
>   }
>   
> +int amdgpu_mes_flush_shader_debugger(struct amdgpu_device *adev,
> +				     uint64_t process_context_addr)
> +{
> +	struct mes_misc_op_input op_input = {0};
> +	int r;
> +
> +	if (!adev->mes.funcs->misc_op) {
> +		DRM_ERROR("mes flush shader debugger is not supported!\n");
> +		return -EINVAL;
> +	}
> +
> +	op_input.op = MES_MISC_OP_SET_SHADER_DEBUGGER;
> +	op_input.set_shader_debugger.process_context_addr = process_context_addr;
> +	op_input.set_shader_debugger.flags.process_ctx_flush = true;
> +
> +	amdgpu_mes_lock(&adev->mes);
> +
> +	r = adev->mes.funcs->misc_op(&adev->mes, &op_input);
> +	if (r)
> +		DRM_ERROR("failed to set_shader_debugger\n");
> +
> +	amdgpu_mes_unlock(&adev->mes);
> +
> +	return r;
> +}
> +
>   static void
>   amdgpu_mes_ring_to_queue_props(struct amdgpu_device *adev,
>   			       struct amdgpu_ring *ring,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
> index 894b9b133000..7d4f93fea937 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
> @@ -296,9 +296,10 @@ struct mes_misc_op_input {
>   			uint64_t process_context_addr;
>   			union {
>   				struct {
> -					uint64_t single_memop : 1;
> -					uint64_t single_alu_op : 1;
> -					uint64_t reserved: 30;
> +					uint32_t single_memop : 1;
> +					uint32_t single_alu_op : 1;
> +					uint32_t reserved: 29;
> +					uint32_t process_ctx_flush: 1;
>   				};
>   				uint32_t u32all;
>   			} flags;
> @@ -374,7 +375,8 @@ int amdgpu_mes_set_shader_debugger(struct amdgpu_device *adev,
>   				const uint32_t *tcp_watch_cntl,
>   				uint32_t flags,
>   				bool trap_en);
> -
> +int amdgpu_mes_flush_shader_debugger(struct amdgpu_device *adev,
> +				uint64_t process_context_addr);
>   int amdgpu_mes_add_ring(struct amdgpu_device *adev, int gang_id,
>   			int queue_type, int idx,
>   			struct amdgpu_mes_ctx_data *ctx_data,
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> index 77f493262e05..8e55e78fce4e 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> @@ -87,6 +87,7 @@ void kfd_process_dequeue_from_device(struct kfd_process_device *pdd)
>   		return;
>   
>   	dev->dqm->ops.process_termination(dev->dqm, &pdd->qpd);
> +	amdgpu_mes_flush_shader_debugger(dev->adev, pdd->proc_ctx_gpu_addr);
>   	pdd->already_dequeued = true;
>   }
>   
> diff --git a/drivers/gpu/drm/amd/include/mes_v11_api_def.h b/drivers/gpu/drm/amd/include/mes_v11_api_def.h
> index 1fbfd1aa987e..ec5b9ab67c5e 100644
> --- a/drivers/gpu/drm/amd/include/mes_v11_api_def.h
> +++ b/drivers/gpu/drm/amd/include/mes_v11_api_def.h
> @@ -572,7 +572,8 @@ struct SET_SHADER_DEBUGGER {
>   		struct {
>   			uint32_t single_memop : 1;  /* SQ_DEBUG.single_memop */
>   			uint32_t single_alu_op : 1; /* SQ_DEBUG.single_alu_op */
> -			uint32_t reserved : 30;
> +			uint32_t reserved : 29;
> +			uint32_t process_ctx_flush : 1;
>   		};
>   		uint32_t u32all;
>   	} flags;

