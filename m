Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 303F3C5AD7B
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Aug 2026 16:37:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BDD0B10E208;
	Mon, 10 Aug 2026 16:37:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JqEhR3+o";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010059.outbound.protection.outlook.com
 [52.101.193.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 398B110E933
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Aug 2026 16:37:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kZQ4qsz+6hxEnFPpNMe7/nepEYIWIjWI1UbddK6A64R5my000oeCj6+k7DBWDTDOjo079a+qBTxftknUqQDp0whwVW6PcHX68qZyrnFcA7jHKRBqI3LBx9GUJxxPXF0BtYkHXq2UvnUo3rqG5b2ndJGAohTIDg3t9gpQs2eM6uyPcA6z5phWOIuWMoncAAXZompr8WaadDbbyCEvbhzfBkmGNQLvBIL1EKfO2GN82Z3K7i228GYPYelkdg8sNjuqNWpZh1omSc9Tps9gcy2Ytw042f4593dKbRR3S05IagUcmoSU8forjg27p7aoQYGIxsxhDUWE2cwNlIN3KFILrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uDS5ukIX7Et+muzCRULiehPnV+gb4JZHuafXn9h3mFA=;
 b=Qc4NahT5TjyvgjK1V342nBF0AGz1GI7dyud+uT3r+HfOa7aqTgaSfS0N3pXpV6CMcb/qOWXixWuOp9eFHdqbbj7tTkYC/AvNjCnpVJk5Noz8y6Qaivw1wUe3Q/QwCkBEdLbW4MujS3Imvm2Avo66AwttXnNZaf49O+e4hF8pJ362Dhu+q85GuJDAd/OnR61160dfkJVaZdTIjBrlQS8J1DPA8hhXVmOH8mTpVcIGPxphIenJkibXEXjDNUaEe0VaJC2JzP9OmKafCl2zLFhKuAZE409EYtNtbAD+hxL2r3TVSys5p7aAxm8KWATuTSQn2YyY2OTq/ByVvYIDZxsRbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uDS5ukIX7Et+muzCRULiehPnV+gb4JZHuafXn9h3mFA=;
 b=JqEhR3+ooH69K5JlhubkPuyPWgpZvpTaVSj6tvlPOVkXFj3cbyJXd+AAJ0MfNQtQyjxfITjBo6VKQoL8moOE7jjWyHQmfscRlZ31/AYaItBiO7ecn/EkUnalltV9emRjyx4xyTJdMOTD6/r4/bILH7BqtR1ZTCQXBPexiGTNQ8Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN7PR12MB6767.namprd12.prod.outlook.com (2603:10b6:806:269::8)
 by CH2PR12MB4119.namprd12.prod.outlook.com (2603:10b6:610:aa::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Mon, 10 Aug
 2026 16:37:54 +0000
Received: from SN7PR12MB6767.namprd12.prod.outlook.com
 ([fe80::ef05:8207:37d5:53]) by SN7PR12MB6767.namprd12.prod.outlook.com
 ([fe80::ef05:8207:37d5:53%4]) with mapi id 15.21.0292.024; Mon, 10 Aug 2026
 16:37:54 +0000
Message-ID: <b9d7763a-4acb-47a4-843e-40f0c2c9e65d@amd.com>
Date: Mon, 10 Aug 2026 18:37:45 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] drm/amdgpu: handle GDS and SPM without a VM fence
To: Alex Deucher <alexdeucher@gmail.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20260713182414.630372-1-alexander.deucher@amd.com>
 <20260713182414.630372-3-alexander.deucher@amd.com>
 <CADnq5_Orn3EWG_wGNyDHZa=7xCkQMJpFeK_wDxRXDcsRCSCxhQ@mail.gmail.com>
Content-Language: en-US
From: David Rosca <david.rosca@amd.com>
In-Reply-To: <CADnq5_Orn3EWG_wGNyDHZa=7xCkQMJpFeK_wDxRXDcsRCSCxhQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0364.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:fd::28) To SN7PR12MB6767.namprd12.prod.outlook.com
 (2603:10b6:806:269::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB6767:EE_|CH2PR12MB4119:EE_
X-MS-Office365-Filtering-Correlation-Id: 00608d9b-0fb7-44d0-33a7-08def6fdb9f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|18002099003|22082099003|10067099003|56012099006|4143699003|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info: cpeysGMVIIPyIsR+wLXcOeJAb8TbbqmGZCPsBTojL5pgEgejG7NGgTp52rSqm0nXYVoBkumLDperstyeHyJxo3hxAocladu8SGfsQIqzPxsQ1Ypov9+ZK0V1+s2u1ZfbCd9VGXO23AaMJX3qW2KhIpgyLgT2Faah5UOROQs/QdzlmSQyp6IXMrScTRukL/ZkqBdnZ6VsSqldtDsdXm7h2wAkmqwoUwH9iZ2eurWbtHGP1ZkcuEnHnqxVp56J37XWVEoHGU+T6lpWHRnfbY9xNJD9Ej1X7hzxlomphDyd5NrRYvBdrRdR/B1hlMNjMkJhwfvNpYxmB3oBAqgWHIssoZHaPU4ac4JecaUAAmmjGhHob8OLDVmJ6yPXg8UQ9oeCNSlx9XhH0OF1kS/NDIgFbt9iVzt3YdzuCpGEDDYzVanr6tDRgplFptTjnMc1RYmstMeAFNdYZpIlBFqXLfY/Ag2h8ywBZ2ajaOk0D/TIYUIskksl2oDvkhAktKOgPoCcy7KhCFHRS83FHgvBJswLVF54EckXty65t/sK5NL2EeeVwu84OVxkWGkn1nWZQ38QFpS+xm+ARxLzrzebil3xrhS2S4KXFFyMi6VpD9x+iDhTTGuoXUSpdHnQLXu5yEZ6yq1KCcpniAOTc5DbUfWTYzdRr+PGZcurzkgrCdtnLz0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR12MB6767.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(18002099003)(22082099003)(10067099003)(56012099006)(4143699003)(11063799006)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RjlneDhoRTl5T2t2WnVXYVVhZkI1YlJLSStOMmI4SHlMb1hqYWlMbWtZc3dn?=
 =?utf-8?B?bFVQWFVybVllRTl3UDdxSVJWdk5td0UwN1BiS2doVEk4QVA5SCsrMndnVFla?=
 =?utf-8?B?Wk4xdVpPcFU1bm5BSDhIUU8wbVhoWnZyWEZOSDkwanJLaTZYd1JNNjN6ZXAr?=
 =?utf-8?B?TzhaNkR6cDI5bi9pM1ZWeURrbDBZbXo2dnVEdWNQQVh0cW5XSFF4N1d1b1c2?=
 =?utf-8?B?dENjNUdjczVybXZyQnROVjc4cWovL2R1bXVrb3pZdE9lVWM5YmpLY3U1alVi?=
 =?utf-8?B?U2NncVNaYUtVcC8waXV1YWVNVHVOWHNZd01oWnUydEROeUhiNmF2YzdlYVps?=
 =?utf-8?B?NGJBZ2ZONFBBWWo5UVAvVk85MytONU04ajFZbGhpOFo3TW1nd0doYk8wd2RP?=
 =?utf-8?B?Yng4K0lwYnpUb2FxNDFxYmFHVTV0TDVkSXEyWTdaYitESEtNWWZXOCtWZjYy?=
 =?utf-8?B?a0xLOHZpdkV0ZDdWWllWVk5pVXprK0cyVGFyOVhDd2RscDVwYWtJb3RlZzFU?=
 =?utf-8?B?ZXdxcm9KSlBTeEdINUtlUjZBalVkUTBXVnhoNllGSFU4dEZYdHYzbnQ5bTdu?=
 =?utf-8?B?UTNCUU9pTkRBRnlnWURTazhxSUpBYlkvcEliNzVXcjJhQmFCZDFEVjZtTDFM?=
 =?utf-8?B?ZXI1NXlWTEdvYVJSOGFnTDQ5OFdzdzJQV2l2cnF0MTQ1Z0V5SzVxR3FSMFNk?=
 =?utf-8?B?UXYrcmRPNWJKVzVKRE43YkdnR3ZVTSsxbHZ3a3NpYnkxeS9YcG5KT3JVQVAw?=
 =?utf-8?B?SVdRVENVMXRqdE8wejYxVVVJVTZ1cFI3d3lyZS9UamxCNHl4YjB4MmdWTkpJ?=
 =?utf-8?B?bDZCOWpKaHBiam05K2xOZHVIb2xJb1k2UUtuODdGY2M0ak8vTzQ0ZUpPaURq?=
 =?utf-8?B?Y1hvOEFCb0duSlhuNnRDOTJTMC9GUFFpQjFCL0YyN2RyajZtQzRpSEo5cWJv?=
 =?utf-8?B?Q2VNZHdHRnQ4dEZsZTJhcUY3SExiUzFyeHVlODZ2d1VGczBtbUR2MEVGQVJr?=
 =?utf-8?B?Z2tWU2NGZzI4UUVjcVp5TDVGWmlYMGxBdUZHOXl0dWNOTWRmN1NDMXJtNkNT?=
 =?utf-8?B?UmFvaHVQN3VmOS9yUXk3WHkwcjQ0YkgybStlejY3ZllOR25IN0pnUHQxTkpQ?=
 =?utf-8?B?RFp4SjRld25ZTFM5OWRzZHBOdkRzbzh0QWlGTUIzRU9HcS8yQUM5V3FYYnVp?=
 =?utf-8?B?U2VoSWdXNmI4Mi9USG1TTGJaRGlLcEpwWlJTeDlLRW9QTUFyNURhYjBYNGJI?=
 =?utf-8?B?SUR3Z2drc1poTllQdXhxSjNGZklMbFM0YUtFWmc1SkdHU1pKaWpPdVlOWkFh?=
 =?utf-8?B?OTRKUDFKb2pEN1h6UUxGVkxMQThhMTFSYmNhb0hIUzR2cTR6RDJjU0QrdmRT?=
 =?utf-8?B?Z1NuVG5ObUdqRldKYW52WVV6elpJdmpuR3dQcktpVFd4RW5EZnhzRkJOTThU?=
 =?utf-8?B?eW5PZmphcFJEM3ZqemxtTFRMZkRzY0lWbzJxbVV5Y0J5SUR1U2hLK3RGd3lT?=
 =?utf-8?B?MUNUc21uT0R3M05GWjNHdjVuNVpqWVZvNTJIYm0xV3Z1cEpQd0NIK21DZXcz?=
 =?utf-8?B?TE9qWDBNcFNsLzFnaFl4OEhQYWtTbkphOHRyMlpmMC9RZ0hHVm1PdDBXRjNi?=
 =?utf-8?B?SWVDVitFUTZ4dDA3UXJXd1pQSWVPYWhSWGUzYkhXYjArSy9TRW9LZmtkQzFM?=
 =?utf-8?B?WFdPWS9oMmY4bDV5a0hjYjh3ak1kNUdKYjYweEdWeXNyc2twRUxpWmJ3TFB0?=
 =?utf-8?B?blYxbGc1NkI4bEdzYTBpWjdDNWtoZVEvWmZzNmxTMFlRWGlVYS9NY2NRRExa?=
 =?utf-8?B?S3VVZEp1QU1TSjRtQ0d6UWJOdWZ5dlVLWlp2V0FhY1pCSlZ2OVc5dnFwUG10?=
 =?utf-8?B?SGFNUnVsWXA1c0t4Z1dRbDZMaU9CMXVldzc0b21neW5ldk1PVWhLUDg5S1BF?=
 =?utf-8?B?YXBHeDMxc0Fudjd5ZFVqQ2E4YjlpRUZmWTUyempmSGtTaDllVGh0WEwwVnVG?=
 =?utf-8?B?ekk5YU11d3BFSXlOVkROczZOeWoySXRXL0VwM05nSEhuYUVBSWRPa1JpMzRS?=
 =?utf-8?B?UlpzVkxPTTY4UTIxTWlWVExoV2RvZUFIeDN4eHR5cXlDM2tLaEppcld2SHN2?=
 =?utf-8?B?ZWY4SFpnRFdYTHJ1S3lNUndsNUc5YU9hRmZCQlZsbHVldGRsOHMxQ1U4YzFV?=
 =?utf-8?B?L0pacG5CQldUa2lhQ0g0bVU3dy9XcDBsaHdRb0Y2OHF0bDhaR0pUbksybnU0?=
 =?utf-8?B?RmRNUllBRXFaOVFSWWRTM0x0TEt6RFl4WHgyVnZrbXlTMUc2ekd3VjBPaEVt?=
 =?utf-8?B?WEliSTYrZ2VhekJIZFZCdFVpY0tWMmlSaVROVTdaZzZLcnljREFBQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00608d9b-0fb7-44d0-33a7-08def6fdb9f4
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB6767.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2026 16:37:54.1410 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7Ai00YWTsIwSfYexUEEeOI7FgtTgkPqYYcFeM5U4TI6ktDg80Yx6ZY0v+FFrhnjgcSXLbTSX9q86dmBQ4cTtYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4119
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


On 8/10/26 17:59, Alex Deucher wrote:
> + David
>
> Ping?
>
> On Mon, Jul 13, 2026 at 2:24 PM Alex Deucher <alexander.deucher@amd.com> wrote:
>> If we end up emitting a VM fence keep GDS and SPM
>> associated with that fence.  If not, emit them as
>> part of the IB fence.
>>
>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c | 14 +++++++-
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 47 ++++++++++++++++++--------
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h |  4 ++-
>>   3 files changed, 48 insertions(+), 17 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
>> index f1ed4a436f5b4..d439c68eed9de 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
>> @@ -131,6 +131,8 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
>>          struct amdgpu_fence *af;
>>          struct amdgpu_fence *vm_af;
>>          bool need_ctx_switch;
>> +       bool emit_spm_needed = false;
>> +       bool emit_gds_needed = false;
>>          struct amdgpu_vm *vm;
>>          uint64_t fence_ctx;
>>          uint32_t status = 0, alloc_size;
>> @@ -220,7 +222,8 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
>>                  vm_af = job->hw_vm_fence;
>>                  /* VM sequence */
>>                  vm_af->ib_wptr = ring->wptr;
>> -               amdgpu_vm_flush(ring, job, need_pipe_sync);
>> +               amdgpu_vm_flush(ring, job, need_pipe_sync, &emit_spm_needed,
>> +                               &emit_gds_needed);
>>                  vm_af->ib_dw_size =
>>                          amdgpu_ring_get_dw_distance(ring, vm_af->ib_wptr, ring->wptr);
>>          }
>> @@ -232,6 +235,15 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
>>          if (ring->funcs->insert_start)
>>                  ring->funcs->insert_start(ring);
>>
>> +       if (emit_spm_needed)
>> +               adev->gfx.rlc.funcs->update_spm_vmid(adev, ring->xcc_id, ring, job->vmid);
>> +
>> +       if (emit_gds_needed)
>> +               amdgpu_ring_emit_gds_switch(ring, job->vmid, job->gds_base,
>> +                                           job->gds_size, job->gws_base,
>> +                                           job->gws_size, job->oa_base,
>> +                                           job->oa_size);
>> +
>>          if ((ib->flags & AMDGPU_IB_FLAG_EMIT_MEM_SYNC) && ring->funcs->emit_mem_sync)
>>                  ring->funcs->emit_mem_sync(ring);
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> index aec8468634535..756810c606d80 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> @@ -766,18 +766,22 @@ bool amdgpu_vm_need_pipeline_sync(struct amdgpu_ring *ring,
>>    * @ring: ring to use for flush
>>    * @job:  related job
>>    * @need_pipe_sync: is pipe sync needed
>> + * @emit_spm_needed: does the caller need to emit spm
>> + * @emit_gds_needed: does the caller need to emit gds
>>    *
>>    * Emit a VM flush when it is necessary.
>>    */
>>   void amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
>> -                    bool need_pipe_sync)
>> +                    bool need_pipe_sync, bool *emit_spm_needed,
>> +                    bool *emit_gds_needed)
>>   {
>>          struct amdgpu_device *adev = ring->adev;
>>          struct amdgpu_isolation *isolation = &adev->isolation[ring->xcp_id];
>>          unsigned vmhub = ring->vm_hub;
>>          struct amdgpu_vmid_mgr *id_mgr = &adev->vm_manager.id_mgr[vmhub];
>>          struct amdgpu_vmid *id = &id_mgr->ids[job->vmid];
>> -       bool spm_update_needed = job->spm_update_needed;
>> +       bool spm_update_needed = adev->gfx.rlc.funcs->update_spm_vmid &&
The check for update_spm_vmid shouldn't be needed here.
>> +               job->spm_update_needed;
>>          bool gds_switch_needed = ring->funcs->emit_gds_switch &&
>>                  job->gds_switch_needed;
>>          bool vm_flush_needed = job->vm_needs_flush;
>> @@ -785,6 +789,7 @@ void amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
>>          bool pasid_mapping_needed = false;
>>          struct dma_fence *fence = NULL;
>>          unsigned int patch = 0;
>> +       bool emit_fence;
>>
>>          if (amdgpu_vmid_had_gpu_reset(adev, id)) {
>>                  gds_switch_needed = true;
>> @@ -800,6 +805,7 @@ void amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
>>          mutex_unlock(&id_mgr->lock);
>>
>>          gds_switch_needed &= !!ring->funcs->emit_gds_switch;
>> +       spm_update_needed &= !!adev->gfx.rlc.funcs->update_spm_vmid;
>>          vm_flush_needed &= !!ring->funcs->emit_vm_flush  &&
>>                          job->vm_pd_addr != AMDGPU_BO_INVALID_OFFSET;
>>          pasid_mapping_needed &= adev->gmc.gmc_funcs->emit_pasid_mapping &&
>> @@ -810,6 +816,17 @@ void amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
>>                  ring->funcs->emit_cleaner_shader && job->base.s_fence &&
>>                  &job->base.s_fence->scheduled == isolation->spearhead;
>>
>> +       emit_fence = !!(vm_flush_needed || pasid_mapping_needed ||
>> +                       cleaner_shader_needed);

Double negation shouldn't be needed, all bools.

Reviewed-by: David Rosca <david.rosca@amd.com>

>> +
>> +       *emit_spm_needed = spm_update_needed;
>> +       if (spm_update_needed && emit_fence)
>> +               *emit_spm_needed = false;
>> +
>> +       *emit_gds_needed = gds_switch_needed;
>> +       if (gds_switch_needed && emit_fence)
>> +               *emit_gds_needed = false;
>> +
>>          if (!vm_flush_needed && !gds_switch_needed && !need_pipe_sync &&
>>              !cleaner_shader_needed && !spm_update_needed)
>>                  return;
>> @@ -844,21 +861,21 @@ void amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
>>          if (pasid_mapping_needed)
>>                  amdgpu_gmc_emit_pasid_mapping(ring, job->vmid, job->pasid);
>>
>> -       if (spm_update_needed && adev->gfx.rlc.funcs->update_spm_vmid)
>> -               adev->gfx.rlc.funcs->update_spm_vmid(adev, ring->xcc_id, ring, job->vmid);
>> +       if (emit_fence) {
>> +               if (spm_update_needed)
>> +                       adev->gfx.rlc.funcs->update_spm_vmid(adev, ring->xcc_id, ring, job->vmid);
>>
>> -       if (ring->funcs->emit_gds_switch &&
>> -           gds_switch_needed) {
>> -               amdgpu_ring_emit_gds_switch(ring, job->vmid, job->gds_base,
>> -                                           job->gds_size, job->gws_base,
>> -                                           job->gws_size, job->oa_base,
>> -                                           job->oa_size);
>> -       }
>> +               if (gds_switch_needed)
>> +                       amdgpu_ring_emit_gds_switch(ring, job->vmid, job->gds_base,
>> +                                                   job->gds_size, job->gws_base,
>> +                                                   job->gws_size, job->oa_base,
>> +                                                   job->oa_size);
>>
>> -       amdgpu_fence_emit(ring, job->hw_vm_fence, 0);
>> -       fence = &job->hw_vm_fence->base;
>> -       /* get a ref for the job */
>> -       dma_fence_get(fence);
>> +               amdgpu_fence_emit(ring, job->hw_vm_fence, 0);
>> +               fence = &job->hw_vm_fence->base;
>> +               /* get a ref for the job */
>> +               dma_fence_get(fence);
>> +       }
>>
>>          if (vm_flush_needed) {
>>                  mutex_lock(&id_mgr->lock);
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>> index 939f639cd8bfd..f82572b71c5ad 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>> @@ -515,7 +515,9 @@ int amdgpu_vm_validate(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>>                         struct ww_acquire_ctx *ticket,
>>                         int (*callback)(void *p, struct amdgpu_bo *bo),
>>                         void *param);
>> -void amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job, bool need_pipe_sync);
>> +void amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
>> +                    bool need_pipe_sync, bool *emit_spm_needed,
>> +                    bool *emit_gds_needed);
>>   int amdgpu_vm_update_pdes(struct amdgpu_device *adev,
>>                            struct amdgpu_vm *vm, bool immediate);
>>   int amdgpu_vm_clear_freed(struct amdgpu_device *adev,
>> --
>> 2.55.0
>>
