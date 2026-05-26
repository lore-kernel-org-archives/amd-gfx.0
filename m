Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3ACBCD5BD1
	for <amd-gfx@archiver.kernel.org>; Tue, 26 May 2026 08:46:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7BD2B10E461;
	Tue, 26 May 2026 08:46:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ydzB9Tu9";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011040.outbound.protection.outlook.com [52.101.57.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4E41510E461
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 May 2026 08:46:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=apYzMFVJpaL4RNoaDrOSqTHtfIka2cPJFzkvZ2ARYfsmwa0MKqkcwp2Q+HHHghea8TgMUWfALdrr7Yr/RZq80CHenLvYeXt45zNJokIYvadOTidLKckqAfL63k7RqS+YYymSdMeaKNlsozKq5wgjkOgORueT/pnNd3/5iCsk+BESRzVTiXlbrHVXynX/g33tyl8OknM+VmsW2xm4BfvtdpxaP6/z7SgQS+6xt4TdWjQZq8dOKlAkNsASvbYGy4iKuu6mXq/JdN9u/DB+qOWLAnQwJ5Sqnx8/yCLfyYTpPdmIIYIB/ErtFNPER6uqSybyQsA8ZnIcpCPaOESRB4W7BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9Udbp8kXGmsiPTbYABFPZd9JfxZ6F5Q1dK+RvsmvRaY=;
 b=UUSozjz9KA/qwHEK5A+Fmsu1lljniE/ugcDIcaBDg33Pf33oJ82TYdF09J1wGH5K5oXVX+GlshvBQHaofrHtamCrA+cHl7TscSd9C///2tmA1ZL9GoqgYpXgJoeIuS5VQ8G6y437AQCZX4fPHl6KGtAVr5iSnviXcj16+I4YJ4ngtbsMMGP0ThKoqTr4DDoum3uOzv/EubbIn0JXC7EQPcjl3SgNpni2cP41xO/RsQfoc1omKamjb/M0vpslXNoApUwRByjgTOWJ/Qw1H7SOowKGU0kCzQQbzOS2sFdNVKWwesnndASdE11FZuL9ED+4t59NmUkVwxbe1t5bXlAyFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Udbp8kXGmsiPTbYABFPZd9JfxZ6F5Q1dK+RvsmvRaY=;
 b=ydzB9Tu9QfOV2RXozi8YKjp2mq/OxLdwj4eNZtFDnFYNcZ6rJMmdIP6z4GcIysWgVKnqkPLSkeeW1UVwpZVSCjF7Yj1iTkypekgg2cparu1H7YXv5WaUElIFuXgM8kAIN234v1zHWFuf8uaNt6OVsMNAaQN9sMK1uylm6+xQmjc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH0PR12MB7983.namprd12.prod.outlook.com (2603:10b6:510:28e::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.11; Tue, 26 May
 2026 08:46:32 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0048.016; Tue, 26 May 2026
 08:46:31 +0000
Message-ID: <7f2be916-27ba-47bc-9440-121a9e7d659c@amd.com>
Date: Tue, 26 May 2026 10:46:28 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: implement per-process MES context
To: "Zhu, Lingshan" <lingshan.zhu@amd.com>, amd-gfx@lists.freedesktop.org,
 Alexander.Deucher@amd.com
Cc: Ray.Huang@amd.com
References: <20260525082359.5510-1-lingshan.zhu@amd.com>
 <53d1f30e-96d1-48a8-a933-c922439e9cdb@amd.com>
 <591307db-a567-4bac-b995-1eec64a7c42d@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <591307db-a567-4bac-b995-1eec64a7c42d@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0071.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ce::6) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH0PR12MB7983:EE_
X-MS-Office365-Filtering-Correlation-Id: 6fb7bb12-08a8-458e-7c92-08debb0348fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|22082099003|56012099003|18002099003|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: 8RqQUObFpsrjh9WczZwxz1U35mYJ0wIQzASUVz2Tbm9ezGaQbEx2pFJqVEDn3djW7sYYV431vatILnBzVTw1WpOfVIZZZX8DoLvRoKQD1vMMMzGPS9F5EiqBEZrDBEyNwBBvVjzGS/Fjm8KX4g8EPDBDg4vPcMPkGzNi/1np69nF0nmxI+R4niq2WLB8WamO5MP2ChDKI89lypJPZrRYPhLJY3FzAq2W2OLM/H9+ZA9MOdXA5BYse2BezjTs0v7iMNblfbH0QhbTC+TAwQhi3E9W5ZtUhR0VYkhx23Xo20Sj+oC6MSvhDGUY7jHdSS9fVxoV0eyZvZ13Zrs07gzzUberlhoCbdFjlylQqPb3rzf9Jup9PbV3ttRjEUOQ1sN+jNe0qVv6DDcE6h89cAlt6JaOw+VMZvqOIJjNmS1joh6fzRFPK242dOx4SwCI3TmajhDrWdwmSwIwRlPjujHevNdCmm8XvNOCNisPjj49hUVfq5uEvXlHK3BYAQ56I2PoKIGVNBQiryU96GmA24N3MjtpyArgifcEfxdiDplfBc7QpNLnZCOvVulgq2OIgpUCEddId12QoApCjTNXqCWuxkbPK8tp1fzMpYvx21nVxxVnoOk5HCKnElqCMHrZaGYVWPtUYCZQp0Wq6w3fbQdiJkVqp7SPeIY9lo8sAjrt5DotZ7wS3PBJLYgYu+uU02lO
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(22082099003)(56012099003)(18002099003)(11063799006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z3p5SVJGUTVsSFZvYTg0VGtFM2ZuNlhhUE02Q2ptNFpDNmx0bTBOUS9ZZUE4?=
 =?utf-8?B?SW8vNTZWK0tCOFhhWkRMcXVMbW5VMlMwY1lIVURwejVhTFk5d29CeXplT2F0?=
 =?utf-8?B?dlpiQ1kwWjMvN2tHemJoNmVaTjhWU21WN3lwNVBkZ1hLcjVvZ05wbVF6Vjl0?=
 =?utf-8?B?Ti9GT0hGdi9FdGQ0RS9lZlg4ZlljQ0wyOXpESlNZNFBkT081TkVHVlIrNjRN?=
 =?utf-8?B?WmZ4QXQ3blYwcXZXZW1Icm16bFFNMmNiOWdFaTYyMmF0TDBzdklXb3hFMzJX?=
 =?utf-8?B?dDQ2L0FPZTF1ZTFHSUxsNkwwMndiS3pVZEZ6TFBKMy9XWGJocmZuVytlTDZv?=
 =?utf-8?B?dUs5OUdUYVRmb3ZjU1VWaklYT1VBb0lxdmxtcmRsZE45QXhCTGszY3o4ejVE?=
 =?utf-8?B?SmJxdG9VT1A1UkJCRGkvQTVXZnR4QXlxaXkxK0tEMHZPRGl1d0FYSUcreHhm?=
 =?utf-8?B?V1RnT2pqOGp3UDErV0dhRzZvbURFcVM1cFJ0bjRhWWRDbkIycDVsMXVvaG9P?=
 =?utf-8?B?T1VQSVRnV3B3SW13LzZrZWE0SkYvVlhLWVd4eGJHMC94M1EyclZMejJuOHdH?=
 =?utf-8?B?bnMwZGZMcWwxTkJLVVdDQmJhaktnbkFpb3JpRGhrVlp2SVFvN005ZmowRnlk?=
 =?utf-8?B?enNpWS9NdzdwRzF5ejR6TW5BVi9tVEFQcmpFRkoxV25iNkYrd2N5bER1Ukox?=
 =?utf-8?B?b3dpdHdpVEVpRmJYaUJCbjZDd2hkeERhQkRZK3VXTHhsZ2JyODRva05WeXM2?=
 =?utf-8?B?YjJIK1A3ZVlROGtOZmpDbnM5aGYyKzJvbnNNdVVza0FoMW5sU1h0OHloRTBz?=
 =?utf-8?B?LzFxT1BqMlZEY0xJeVZWRGg5NU1kakNVSEFLV0FmY1N4Syt5VUtNSjlMaWt3?=
 =?utf-8?B?SGJRZEpHdysyUUV4Rm9MZTc3YnhnU1lCbXZmZFFlYXZEYUpjclMwSGlteGR1?=
 =?utf-8?B?STZFTDV1UFBVYTA1T2ViLzc3eTVodTZEVHB6dHFoK2xqS0RKcVkvSFg2MHIy?=
 =?utf-8?B?UTZkaEM5UitwT09va29iT2d1bVQvTTVyNEwrK2lSUjJRZHRINkRrSVkrTWM5?=
 =?utf-8?B?cGNDd1QrOXJMMWdkMU5QUGZhV0FwNCs2ZXRESnBVVUpBOU9xSUxCU3FUSXZG?=
 =?utf-8?B?OXI1WVJBUEdHNk9kcytDUlMvcXVwSmVLZWNHMXY4bU5ScExxOGdsMGFsZXM5?=
 =?utf-8?B?L3JpRmo5SVZJT1FOY0w0Mm1xYkUrUWJhc29ZMjdsU0MrRmljYnllZGtOVVQr?=
 =?utf-8?B?YWFJdEtvMlZaWG9RdHlUMlB1dWJyWGhPMjA5NDQyRFNiMkJOMUU5SEV2ZnFm?=
 =?utf-8?B?ZExuUUFsNXhEV0lQNDcvTkVsM3d2WDl6dUZoREFLS29oVXduWGFQc25CcEth?=
 =?utf-8?B?UDhLUGE3N0FxUXlFeUhNbVkyUUhPWjFmYUVKSkpqdEpqalkyUk1lMUZOY09V?=
 =?utf-8?B?djd6UndaN2U5c0pERm9tT0lpamNIUTUreitvd3JlTG5XSUhuN2thdU5lbUNZ?=
 =?utf-8?B?N1VNbzdTR0ptZ05TY0NWU3FnOW5JYXQvZ29WcTA0cDdDVnVMTENJcjZSL0RG?=
 =?utf-8?B?SmxuVUc1M2FkTVRxclVCTEY1bzNlOWVSMGJoN0RXVWQvOC9sZ0dCMlk5d1FE?=
 =?utf-8?B?MGV2Qnc4M2RCakRodEZSbzczZnUzSCtCS0I3L1FaZjc3VStXSmxsQnRYL2RX?=
 =?utf-8?B?SFNHcjFkZGh6UnVaS3VpUGYvTGhabFNzWm5nMnNnRDNSaThCcmsvcCswbEd5?=
 =?utf-8?B?cVBacTNJYmhSZUdBOXVSbkh5cU02T3pTUEZlZGNRRDVkbndEYVU4cjU2aEky?=
 =?utf-8?B?VlE1ZDd1aVR3N3RpaG1McWhNUW1kamVzTk5YbVRMSkpldk5UdlY5OERCcWxW?=
 =?utf-8?B?d29nUzJCd1JPTFNzZWdrcjA5RnE3bWY2TW41cGNBRnViOUhEQ0RuajlCbWRE?=
 =?utf-8?B?aVJoSzNJVi84eStYM0RHVTNic2EyWE1aTGpURThvSzQ5YkFUY1VLNEoxWjZo?=
 =?utf-8?B?RS9MOGZML3VoYUJTNkhIb3BPU1NtNEllZGltdEt4QVRuUHkwWG9sY09zM2ls?=
 =?utf-8?B?M05QeWZCeVh4a1c5VTZ1R3lPMlhsOHdDMjlDUWJlMkVqUERaRG1yMThCRE5a?=
 =?utf-8?B?MmUrMDZnc2htSDlDZDVXRk5jU1BFcUt2VFY1QzRDMXlmZFh5UnBWYUp6QlJQ?=
 =?utf-8?B?dmxQZjdELzVHdUJRdnl1NEhUNUw3TWx4K3lDWmRVdmR2RFhXZU05b2h0U2Np?=
 =?utf-8?B?K3NBMGZjZVltYTJsbWR4MkhGZGsvMEJCems4endmTm5rb3NOekpTeDBOMW42?=
 =?utf-8?Q?yS+ZVAaXoMzEprPOg6?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fb7bb12-08a8-458e-7c92-08debb0348fc
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 08:46:31.8380 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C30Qv1s0qFYNQ2ng/J8Y1gluToMogmMIKXr/iZnWwLx8dGOEPRlpbmROgvZEKfkg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7983
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

On 5/26/26 09:54, Zhu, Lingshan wrote:
> On 5/26/2026 3:02 AM, Christian König wrote:
> 
>> On 5/25/26 10:23, Zhu Lingshan wrote:
>>> MES process context is a process-level page
>>> where process specific context is saved for
>>> MES scheduler.
>>>
>>> However, current user-queue code path assigns
>>> fw_obj of a queue to MES process_context_addr
>>> when adding the queue to MES.
>>>
>>> This means every new queue from the same process
>>> would replace the previous process context address
>>> with that queue's fw_obj address.
>>> What's worse is, when user space frees a queue,
>>> its fw_obj will be freed as well, causing MES
>>> working on a NULL page pointer.
>>>
>>> This issue leads to inconsistency and crash
>>> in the scheduler.
>>>
>>> This commit allocates a process-level page for
>>> MES process contexts for a process other than queue-level
>>>
>>> Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>
>>> ---
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c  |  5 +++
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h  |  1 +
>>>  drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 48 ++++++++++++++++------
>>>  3 files changed, 42 insertions(+), 12 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>>> index 38e310a8694d..0c4d6f80616e 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>>> @@ -1225,6 +1225,11 @@ void amdgpu_userq_mgr_fini(struct amdgpu_userq_mgr *userq_mgr)
>>>  	 */
>>>  	cancel_work_sync(&userq_mgr->reset_work);
>>>  
>>> +	if (userq_mgr->proc_ctx_obj.obj)
>> Please drop that check it is unecessary.
> 
> sure, I can drop this in V2.
> 
>>> +		amdgpu_bo_free_kernel(&userq_mgr->proc_ctx_obj.obj,
>>> +				      &userq_mgr->proc_ctx_obj.gpu_addr,
>>> +				      &userq_mgr->proc_ctx_obj.cpu_ptr);
>>> +
>>>  	mutex_destroy(&userq_mgr->userq_mutex);
>>>  }
>>>  
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
>>> index 28cfc6682333..fe85234e58b3 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
>>> @@ -127,6 +127,7 @@ struct amdgpu_userq_mgr {
>>>  	struct amdgpu_device		*adev;
>>>  	struct delayed_work		resume_work;
>>>  	struct drm_file			*file;
>>> +	struct amdgpu_userq_obj		proc_ctx_obj;
>>>  
>>>  	/**
>>>  	 * @reset_work:
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
>>> index e9189f07c6dc..3022025bc2ec 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
>>> @@ -133,8 +133,8 @@ static int mes_userq_map(struct amdgpu_usermode_queue *queue)
>>>  	queue_input.gang_quantum = 10000;
>>>  	queue_input.paging = false;
>>>  
>>> -	queue_input.process_context_addr = ctx->gpu_addr;
>>> -	queue_input.gang_context_addr = ctx->gpu_addr + AMDGPU_USERQ_PROC_CTX_SZ;
>>> +	queue_input.process_context_addr = uq_mgr->proc_ctx_obj.gpu_addr;
>>> +	queue_input.gang_context_addr = ctx->gpu_addr;
>>>  	queue_input.inprocess_gang_priority = AMDGPU_MES_PRIORITY_LEVEL_NORMAL;
>>>  	queue_input.gang_global_priority_level = convert_to_mes_priority(queue->priority);
>>>  
>>> @@ -169,7 +169,7 @@ static int mes_userq_unmap(struct amdgpu_usermode_queue *queue)
>>>  
>>>  	memset(&queue_input, 0x0, sizeof(struct mes_remove_queue_input));
>>>  	queue_input.doorbell_offset = queue->doorbell_index;
>>> -	queue_input.gang_context_addr = ctx->gpu_addr + AMDGPU_USERQ_PROC_CTX_SZ;
>>> +	queue_input.gang_context_addr = ctx->gpu_addr;
>>>  
>>>  	amdgpu_mes_lock(&adev->mes);
>>>  	r = adev->mes.funcs->remove_hw_queue(&adev->mes, &queue_input);
>>> @@ -186,12 +186,8 @@ static int mes_userq_create_ctx_space(struct amdgpu_userq_mgr *uq_mgr,
>>>  	struct amdgpu_userq_obj *ctx = &queue->fw_obj;
>>>  	int r, size;
>>>  
>>> -	/*
>>> -	 * The FW expects at least one page space allocated for
>>> -	 * process ctx and gang ctx each. Create an object
>>> -	 * for the same.
>>> -	 */
>>> -	size = AMDGPU_USERQ_PROC_CTX_SZ + AMDGPU_USERQ_GANG_CTX_SZ;
>>> +	/* The FW expects at least one page space allocated for gang ctx. */
>>> +	size = AMDGPU_USERQ_GANG_CTX_SZ;
>>>  	r = amdgpu_bo_create_kernel(uq_mgr->adev, size, 0,
>>>  				    AMDGPU_GEM_DOMAIN_GTT,
>>>  				    &ctx->obj, &ctx->gpu_addr,
>>> @@ -257,6 +253,27 @@ static int mes_userq_detect_and_reset(struct amdgpu_device *adev,
>>>  	return r;
>>>  }
>>>  
>>> +static int mes_userq_create_proc_ctx_space(struct amdgpu_userq_mgr *uq_mgr)
>>> +{
>>> +	int r = 0;
>>> +
>>> +	mutex_lock(&uq_mgr->userq_mutex);
>> Clear NAK. We can't allocate anything while holding that lock.
>>
>> Please add a different lock to protected the buffer or just oportunistically allocate it with CMPXCHG().
> 
> I will introduce a different lock in V2.
> 
>>> +	if (!uq_mgr->proc_ctx_obj.obj) {
>> Please drop that check, amdgpu_bo_create_kernel() should already take care of that.
> 
> I think we still need this check, because although amdgpu_bo_create_kernel() checks (!*bo_ptr), but:
> 1) it does not immediately return if bo_ptr is valid. It only skips re-creating the bo,
> it still calls amdgpu_bo_reserve(), amdgpu_bo_pin(), amdgpu_ttm_alloc_gart(), and amdgpu_bo_kmap()
> on every invocation.
> 
> 2) it calls memset() unconditionally on every invocation.
> 
> So I think this check is still necessary, and another thing, do you think
> amdgpu_bo_create_kernel() should immediately return if *bo_ptr is not NULL?
> It looks like this deserve a fix.

Good point, IIRC we added this handling to make it easier to re-create kernel buffers after suspend/resume.

I'm not sure if any code path is actually still using this since we found that for a lot of use cases you need to keep the FW buffers at the same location even after suspend/resume.

Anyway just add an if and comment why it is necessary.


> 
> Thanks
> Lingshan
> 
>> Regards,
>> Christian.
>>
>>> +		r = amdgpu_bo_create_kernel(uq_mgr->adev, AMDGPU_USERQ_PROC_CTX_SZ,
>>> +					    0, AMDGPU_GEM_DOMAIN_GTT,
>>> +					    &uq_mgr->proc_ctx_obj.obj,
>>> +					    &uq_mgr->proc_ctx_obj.gpu_addr,
>>> +					    &uq_mgr->proc_ctx_obj.cpu_ptr);
>>> +
>>> +		if (!r)
>>> +			memset(uq_mgr->proc_ctx_obj.cpu_ptr, 0, AMDGPU_USERQ_PROC_CTX_SZ);

When amdgpu_bo_create_kernel() does that the memset here can probably be dropped.

Regards,
Christian.

>>> +	}
>>> +
>>> +	mutex_unlock(&uq_mgr->userq_mutex);
>>> +
>>> +	return r;
>>> +}
>>> +
>>>  static int mes_userq_mqd_create(struct amdgpu_usermode_queue *queue,
>>>  				struct drm_amdgpu_userq_in *args_in)
>>>  {
>>> @@ -429,7 +446,14 @@ static int mes_userq_mqd_create(struct amdgpu_usermode_queue *queue,
>>>  		goto free_mqd;
>>>  	}
>>>  
>>> -	/* Create BO for FW operations */
>>> +	/* Create per-process MES process context BO */
>>> +	r = mes_userq_create_proc_ctx_space(uq_mgr);
>>> +	if (r) {
>>> +		DRM_ERROR("Failed to allocate MES process context space bo, error: %d\n", r);
>>> +		goto free_mqd;
>>> +	}
>>> +
>>> +	/* Create BO of a gang for FW operations */
>>>  	r = mes_userq_create_ctx_space(uq_mgr, queue, mqd_user);
>>>  	if (r) {
>>>  		DRM_ERROR("Failed to allocate BO for userqueue (%d)", r);
>>> @@ -492,7 +516,7 @@ static int mes_userq_preempt(struct amdgpu_usermode_queue *queue)
>>>  	*fence_ptr = 0;
>>>  
>>>  	memset(&queue_input, 0x0, sizeof(struct mes_suspend_gang_input));
>>> -	queue_input.gang_context_addr = ctx->gpu_addr + AMDGPU_USERQ_PROC_CTX_SZ;
>>> +	queue_input.gang_context_addr = ctx->gpu_addr;
>>>  	queue_input.suspend_fence_addr = fence_gpu_addr;
>>>  	queue_input.suspend_fence_value = 1;
>>>  	amdgpu_mes_lock(&adev->mes);
>>> @@ -529,7 +553,7 @@ static int mes_userq_restore(struct amdgpu_usermode_queue *queue)
>>>  		return 0;
>>>  
>>>  	memset(&queue_input, 0x0, sizeof(struct mes_resume_gang_input));
>>> -	queue_input.gang_context_addr = ctx->gpu_addr + AMDGPU_USERQ_PROC_CTX_SZ;
>>> +	queue_input.gang_context_addr = ctx->gpu_addr;
>>>  
>>>  	amdgpu_mes_lock(&adev->mes);
>>>  	r = adev->mes.funcs->resume_gang(&adev->mes, &queue_input);

