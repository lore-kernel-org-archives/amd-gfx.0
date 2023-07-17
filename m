Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1AB7EB64DD
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Jul 2023 00:38:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 09C6410E0EB;
	Mon, 17 Jul 2023 00:38:46 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2061f.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8b::61f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C6D9E10E0EB
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Jul 2023 00:38:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WnQJ3V4xUJKk97DUMVkeWx5r/3F6EVzGp8mlJYU3k+ncPrnZrsk8wQUn6KvQB6+BXxVFr7tXxqoLk7Q66yf2CDJ6xAu7K9TMfglwvp8dUom6+YTfvvvMEGhgS51I8Fja9b5BRHFwLpEEfiJw0zcYnFYKLoIbrJ0VeVzHpcl4Qt4ExKyxh6BWH5JZcCRRBy8GBSdrNPgXlpB2tWEd8qmiuEd+eomzWCud+g41xud19I7J2pCMyGH6BWQLIWiYd4z4ujteLQ4zKNV1sxFR6pV5SE1SL85Zms55yldnhHIoGRDndM1MyPIlwwwP/I+vYtLKlFLrVzDZ0uTRVdDgXqAJcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A/sEMn996O6oDVQ+9uhl5OCPvVBV0FxsO0BBlJM0SHU=;
 b=nH+ZMP3/sndZDZH49/Qk9SnPTp3CcPxu0dJeU2anvxmBdwWLhLaVtTlEUFIPPgqDoCO+Qigv5t7mcpUd7ogcblzsOL1q7fupw1MgmGaOj4LUmXAPTiGqKGNwO0Ve34tLT/shqYuFVl/M1H8FTVwfeBOsO4ps+kz/K9/kKRslJ+S9SppqhsuINZkQxaxFTKH8jthpaXNwa2cJSaIPAfmg11K3Xf8qylY6ywlMa/Gbt91dFcf5EkhkmWUpEUOsMQNEXSGfgQnIJ6Q4rGweZtSdsBbeTL9i2T9nGYCudu/mtZM39G6DK5SA+zxNOB/9W7bp2y7y8Y9CJFwn9PUaNlmYkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A/sEMn996O6oDVQ+9uhl5OCPvVBV0FxsO0BBlJM0SHU=;
 b=SxAx0pxXQXGwbGiBBfIhK/RKEKmkMtQOWoidE0GXiWeCGzcK8BtX3gKrvp+8cAN7Q8JUcVtf7rAGC9XGWGBqWM+vI3T6KZHzY2yAirAClZ2FgdHi49apKWmKqrtBH2TY75l34Dr0PZ0SuogBpqBo1+sjFATxY6dxPsh3Qv37kAU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by IA1PR12MB8538.namprd12.prod.outlook.com (2603:10b6:208:455::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.28; Mon, 17 Jul
 2023 00:38:38 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146%7]) with mapi id 15.20.6588.031; Mon, 17 Jul 2023
 00:38:38 +0000
Message-ID: <c61d729c-7798-7a7f-cfdd-ea59fb4633e7@amd.com>
Date: Sun, 16 Jul 2023 19:38:41 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [1/2] drm/amdgpu: fix slab-out-of-bounds issue in
 amdgpu_vm_pt_create
To: Guchun Chen <guchun.chen@amd.com>, amd-gfx@lists.freedesktop.org,
 alexander.deucher@amd.com, hawking.zhang@amd.com, christian.koenig@amd.com,
 Philip.Yang@amd.com, Felix.Kuehling@amd.com, mikhail.v.gavrilov@gmail.com
References: <20230714110510.3690246-1-guchun.chen@amd.com>
Content-Language: en-US
From: "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <20230714110510.3690246-1-guchun.chen@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN9PR03CA0698.namprd03.prod.outlook.com
 (2603:10b6:408:ef::13) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|IA1PR12MB8538:EE_
X-MS-Office365-Filtering-Correlation-Id: 62caf275-b641-4a8d-65b3-08db865e2894
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D/aY3zVemKlP7Tpj5abVaIadNek1v0Xl+zmrhjtfcTSqNojK/8QQWZD02/rbcukZN7ieohYLSqU6oqv4gmPR7syERCFRD5vwYCTChu3dwONSaOxJUJpYiIfgoAArbLOjxcWLUwQL/zov/e7E6pCzPILaEcRBoQS5otjDSzcvaVPWapR/q7vVTUEGkoqmSSox90wEvP40bbswEgM841fyXA2YfqoL+fG5Uch9iKbQiffb6RC4U+QuBhll3rVCmFGJDNWuG0Q20IfTk0XcXIbL3gG18Ep5sSuSCR1BDfTkp8D+qmRmbujRG09X0//YEJEa4ZogJe6Lidtz1/TThoIh5k7UjpfxCemgMPcaGTO9yk+AmJMxKehHQmChZtkh3SQGoG2O3C8mWZBzZ0a6PKXkOOP9fiHqrk9AENWwjwjSGpf+PPHWGt/xKV1f2c2LO2SMJy2NgbT05wUSJOXHqYJPW0oIuS4AzO+I1muEokgTZwgE3WfyxCrr82pV+K6pr7nGWAyKrnRTOTsnU+xzcsssXMFASGsUjYiYsnUMo9JFM4Wt2QBggAcJHE5noM+4A/61myNE4F264TJMuAeSg7A7ZwyrD7kOmLi3xIT+4VW/8Yl+cFVKTP/kOjOdLjNm/91O
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(366004)(39860400002)(346002)(376002)(136003)(396003)(451199021)(31686004)(53546011)(26005)(6506007)(38100700002)(31696002)(5660300002)(478600001)(8936002)(66556008)(66946007)(66476007)(966005)(6512007)(41300700001)(8676002)(86362001)(316002)(6486002)(6666004)(66574015)(2616005)(186003)(2906002)(36756003)(83380400001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R1RFekl4Y1kyN2NlRi9VUFdPSGw4QjI2V1JQVFRZUFVpcWIwNVEzV3RraXMv?=
 =?utf-8?B?NXZoaHd4RjI5KzBUdVg1eUlNK1dybkg1Z2lwK2Ezb2hOUjRtTGx3dWVsZFRD?=
 =?utf-8?B?cWxuWWN3aWluMktoMEEwYjU5ZUV0QTA0Rmducno1blM0ZnluL2ZobHEyU0hN?=
 =?utf-8?B?ejNad1JhVDNkb1dZUzM2aVdtdmNJem5CVWhKdEtUV3B4Tk5LUFUwZGtyQm9o?=
 =?utf-8?B?b2VndlgyOENJNDlxSFZobVc4M2VHUWZXd3luOHhuMFVHZkpFOUppZHpDVDdn?=
 =?utf-8?B?NEQ4VHFoZmNNQStlT1QzQllOU0xjeko1blJtZ3RwdlhUTGdpcWlmK2dYOWRj?=
 =?utf-8?B?bEloQXFUa0k4VHVLTTBZcUdhb2tVeitLNUF4Vm9HeVZQcko1OWlTalZvUVFM?=
 =?utf-8?B?Qi8zeGE2TUNvQTFxR0VmWTVBZVN0Z3FGSzhMQ1pDeTlnT0U0bFllay81U0ll?=
 =?utf-8?B?NTUzeHY2RVc0VzNDcHlOSm1UYlJmK2M4NjdaMXpBb3NnTTMzSy9LSEFUc2Fv?=
 =?utf-8?B?bzExWkRvc2VVTThFRm5XRzUyQkNKMjlyL0MvOHY0MWV1VzZxN1RLU2FwdlEw?=
 =?utf-8?B?N0RZOUtRczNtQyttSkF6ZDRtYTI5TGEwTm9HZTU2Y2RXZ2owYlNXWkFnOCty?=
 =?utf-8?B?alBGZkRCVTlGVk9POFVKVU9KclRZQUpZaWw5VWw2WmUvUTdYWFRmbVBKM2NM?=
 =?utf-8?B?enl3eUR4TU5Gcmp3aFlGbndHcEdyMXp6RTAzTkVYbXhTVWUzb3dWbk5rdldF?=
 =?utf-8?B?VklqUHFIczVtZllXR0M3UzRiUVozTEpSOHJVYjFGRGo0WXJYMDVZVmVaSlZG?=
 =?utf-8?B?Vlp1cGdjbjdMcGRTaGdEUWI5aHNpRGx1U1JPcUtBVXlSMVlmQ1ArVGlaTVR5?=
 =?utf-8?B?L1V6T2gxZms2VkRWS2Ewb0s5VGdhbTVIajNkZUJRRVE3WHhja29ZcDF0S0d1?=
 =?utf-8?B?YThvd2ZEM0gvRVhmemIrWTNCVm1KTk9tVVhJNzNkZlh4TFRZVzBRd0FybTMz?=
 =?utf-8?B?cjBwMlcrcmQyNG9yR214a2RnZnBSVnFCOUdhWkEzdEk2SSttY3JRQXNqdVRu?=
 =?utf-8?B?c2Q5OUZHMThqWmt3aXJoaDJHenRtWE5JR2JEZzNDV0pHc1RWdnloYmxTekFw?=
 =?utf-8?B?MUp0aFIrTUV3OXE2MERLc2RjaTFwbTdmUHFWU2RoalAzZDgxcUZDNmY4QlZS?=
 =?utf-8?B?ZGtiaFZ1cEprTTFSMlZZRXlpZXYwRXBNbHFQNUFmMi9Xd3BTZ1VaQ2d3c0l1?=
 =?utf-8?B?Mnh5Qy9kQ3JnaXIvVStpcWQ1K2dWL1pjeWlHZXIvQ04wamk5enZHelpWTlZ2?=
 =?utf-8?B?M2I1U2hOYWo3RUxjbUFpQ0tQd0NtMkRPckpQN1hHU1ZvODQ3UEtBNFd5TXJl?=
 =?utf-8?B?N2xWY3JYaUdoYVU4L2dRVWt1dElKdHFhYnRlc2lkejBFVGpZcEFkenFqYjF4?=
 =?utf-8?B?WkxRYVFsK0xDNE4wUXdZUVoyZWlhVnpLSllvUGJLd3hyUWpKa0s1T0h3WVVG?=
 =?utf-8?B?UnRqMVJQRExuSEViSWFXSytYcSs3NnZWRFFoTExOSnFCNlBsREFzSGdYNEJt?=
 =?utf-8?B?alErVklWMFFQbG4rQU5tRXRSMXltVW9uaHlDdHlGNHF0a3cxTTMxS3FBM21Z?=
 =?utf-8?B?SElaQVpycDRvQWlmdEdIMGY4cUgxSlQ2aC9PRHpmRG1pYlEvVVpCU0lZa2Vv?=
 =?utf-8?B?cW12eitENS9mcjlvc2N4ZWxNaE5sZm5IOHhUWHdsck83Um9VcVdFVWEwY3Y4?=
 =?utf-8?B?eHk3Q3VOd0JVUTRvNDNuY3N5VW5EaFFxbTdRQVRNYzVYZ2hFVitVT2FjaUZt?=
 =?utf-8?B?Vmw1L2daOURGK3dSMHVad0J3UXJHRmp1ZFl2UklGUkdjaEJub0YvYUFTZ1lx?=
 =?utf-8?B?ZDBJT1NRd2xZVHBLQWxhNy94b3RwSXo4M2RPYStha1dxc2xpWk1tRFJUUjJC?=
 =?utf-8?B?dUdyOGRTZFlCaExKcmlHMFVpVmF3OG5aeDdPb0FPTmdTQzlVeExRZDNUN05H?=
 =?utf-8?B?SmxpNlNoNEFyODZJcHRodzQwL2NaR3BTUFZDNlNNQm1hSlF4Z3E3eGJnM0t6?=
 =?utf-8?B?MjEyZ1RyS0pqczNjWUFyQzNSQWc2TUlZT3k0QnJ1bm9NMnhETUk4aGVuY2Qv?=
 =?utf-8?Q?kRQAf9njDNR9i0eTyYbYtF9ht?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62caf275-b641-4a8d-65b3-08db865e2894
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2023 00:38:37.1355 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rW3bFUlkmI8QWs+0gORnU0Pgz0eUmlwKquxXhHF8ALB2lZtX9ZFjkbwU9WG0RJw+ovS+45UminMmJDDIjA8yig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8538
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


On 7/14/2023 6:05 AM, Guchun Chen wrote:
> Recent code set xcp_id stored from file private data when opening
> device to amdgpu bo for accounting memory usage etc, but not all
> VMs are attached to this fpriv structure like the vm cases in
> amdgpu_mes_self_test, otherwise, KASAN will complain below out
> of bound access. And more importantly, VM code should not touch
> fpriv structure, so drop fpriv code handling from amdgpu_vm_pt.
>
> [   77.292314] BUG: KASAN: slab-out-of-bounds in amdgpu_vm_pt_create+0x17e/0x4b0 [amdgpu]
> [   77.293845] Read of size 4 at addr ffff888102c48a48 by task modprobe/1069
> [   77.294146] Call Trace:
> [   77.294178]  <TASK>
> [   77.294208]  dump_stack_lvl+0x49/0x63
> [   77.294260]  print_report+0x16f/0x4a6
> [   77.294307]  ? amdgpu_vm_pt_create+0x17e/0x4b0 [amdgpu]
> [   77.295979]  ? kasan_complete_mode_report_info+0x3c/0x200
> [   77.296057]  ? amdgpu_vm_pt_create+0x17e/0x4b0 [amdgpu]
> [   77.297556]  kasan_report+0xb4/0x130
> [   77.297609]  ? amdgpu_vm_pt_create+0x17e/0x4b0 [amdgpu]
> [   77.299202]  __asan_load4+0x6f/0x90
> [   77.299272]  amdgpu_vm_pt_create+0x17e/0x4b0 [amdgpu]
> [   77.300796]  ? amdgpu_init+0x6e/0x1000 [amdgpu]
> [   77.302222]  ? amdgpu_vm_pt_clear+0x750/0x750 [amdgpu]
> [   77.303721]  ? preempt_count_sub+0x18/0xc0
> [   77.303786]  amdgpu_vm_init+0x39e/0x870 [amdgpu]
> [   77.305186]  ? amdgpu_vm_wait_idle+0x90/0x90 [amdgpu]
> [   77.306683]  ? kasan_set_track+0x25/0x30
> [   77.306737]  ? kasan_save_alloc_info+0x1b/0x30
> [   77.306795]  ? __kasan_kmalloc+0x87/0xa0
> [   77.306852]  amdgpu_mes_self_test+0x169/0x620 [amdgpu]
>
> Fixes: ffc6deb773f7 ("drm/amdkfd: Store xcp partition id to amdgpu bo")
> Signed-off-by: Guchun Chen <guchun.chen@amd.com>
> Reviewed-by: Christian König <christian.koenig@amd.com>

This bug was also reported in Gitlab.  Here's some more tags.

Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2686
|Tested-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>|

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c   |  2 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c   |  2 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c    |  5 +++--
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h    |  5 +++--
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c | 11 ++++++-----
>   5 files changed, 14 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> index 85a0d5f419c8..9a5aa4318cad 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> @@ -1232,7 +1232,7 @@ int amdgpu_driver_open_kms(struct drm_device *dev, struct drm_file *file_priv)
>   		pasid = 0;
>   	}
>   
> -	r = amdgpu_vm_init(adev, &fpriv->vm);
> +	r = amdgpu_vm_init(adev, &fpriv->vm, fpriv->xcp_id);
>   	if (r)
>   		goto error_pasid;
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> index e9091ebfe230..cac1d1b227f5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> @@ -1382,7 +1382,7 @@ int amdgpu_mes_self_test(struct amdgpu_device *adev)
>   		goto error_pasid;
>   	}
>   
> -	r = amdgpu_vm_init(adev, vm);
> +	r = amdgpu_vm_init(adev, vm, 0);
>   	if (r) {
>   		DRM_ERROR("failed to initialize vm\n");
>   		goto error_pasid;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index 32adc31c093d..74380b21e7a5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -2121,13 +2121,14 @@ long amdgpu_vm_wait_idle(struct amdgpu_vm *vm, long timeout)
>    *
>    * @adev: amdgpu_device pointer
>    * @vm: requested vm
> + * @xcp_id: GPU partition selection id
>    *
>    * Init @vm fields.
>    *
>    * Returns:
>    * 0 for success, error for failure.
>    */
> -int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm)
> +int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm, int32_t xcp_id)
>   {
>   	struct amdgpu_bo *root_bo;
>   	struct amdgpu_bo_vm *root;
> @@ -2177,7 +2178,7 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm)
>   	vm->evicting = false;
>   
>   	r = amdgpu_vm_pt_create(adev, vm, adev->vm_manager.root_level,
> -				false, &root);
> +				false, &root, xcp_id);
>   	if (r)
>   		goto error_free_delayed;
>   	root_bo = &root->bo;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> index 88ee4507f6b6..bca258c38919 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> @@ -398,7 +398,7 @@ int amdgpu_vm_set_pasid(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   			u32 pasid);
>   
>   long amdgpu_vm_wait_idle(struct amdgpu_vm *vm, long timeout);
> -int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm);
> +int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm, int32_t xcp_id);
>   int amdgpu_vm_make_compute(struct amdgpu_device *adev, struct amdgpu_vm *vm);
>   void amdgpu_vm_release_compute(struct amdgpu_device *adev, struct amdgpu_vm *vm);
>   void amdgpu_vm_fini(struct amdgpu_device *adev, struct amdgpu_vm *vm);
> @@ -481,7 +481,8 @@ void amdgpu_vm_get_memory(struct amdgpu_vm *vm,
>   int amdgpu_vm_pt_clear(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   		       struct amdgpu_bo_vm *vmbo, bool immediate);
>   int amdgpu_vm_pt_create(struct amdgpu_device *adev, struct amdgpu_vm *vm,
> -			int level, bool immediate, struct amdgpu_bo_vm **vmbo);
> +			int level, bool immediate, struct amdgpu_bo_vm **vmbo,
> +			int32_t xcp_id);
>   void amdgpu_vm_pt_free_root(struct amdgpu_device *adev, struct amdgpu_vm *vm);
>   bool amdgpu_vm_pt_is_root_clean(struct amdgpu_device *adev,
>   				struct amdgpu_vm *vm);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> index 70fc5856a5b9..eb52dfe64948 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> @@ -498,11 +498,12 @@ int amdgpu_vm_pt_clear(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>    * @level: the page table level
>    * @immediate: use a immediate update
>    * @vmbo: pointer to the buffer object pointer
> + * @xcp_id: GPU partition id
>    */
>   int amdgpu_vm_pt_create(struct amdgpu_device *adev, struct amdgpu_vm *vm,
> -			int level, bool immediate, struct amdgpu_bo_vm **vmbo)
> +			int level, bool immediate, struct amdgpu_bo_vm **vmbo,
> +			int32_t xcp_id)
>   {
> -	struct amdgpu_fpriv *fpriv = container_of(vm, struct amdgpu_fpriv, vm);
>   	struct amdgpu_bo_param bp;
>   	struct amdgpu_bo *bo;
>   	struct dma_resv *resv;
> @@ -535,7 +536,7 @@ int amdgpu_vm_pt_create(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   
>   	bp.type = ttm_bo_type_kernel;
>   	bp.no_wait_gpu = immediate;
> -	bp.xcp_id_plus1 = fpriv->xcp_id == ~0 ? 0 : fpriv->xcp_id + 1;
> +	bp.xcp_id_plus1 = xcp_id + 1;
>   
>   	if (vm->root.bo)
>   		bp.resv = vm->root.bo->tbo.base.resv;
> @@ -561,7 +562,7 @@ int amdgpu_vm_pt_create(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   	bp.type = ttm_bo_type_kernel;
>   	bp.resv = bo->tbo.base.resv;
>   	bp.bo_ptr_size = sizeof(struct amdgpu_bo);
> -	bp.xcp_id_plus1 = fpriv->xcp_id == ~0 ? 0 : fpriv->xcp_id + 1;
> +	bp.xcp_id_plus1 = xcp_id + 1;
>   
>   	r = amdgpu_bo_create(adev, &bp, &(*vmbo)->shadow);
>   
> @@ -606,7 +607,7 @@ static int amdgpu_vm_pt_alloc(struct amdgpu_device *adev,
>   		return 0;
>   
>   	amdgpu_vm_eviction_unlock(vm);
> -	r = amdgpu_vm_pt_create(adev, vm, cursor->level, immediate, &pt);
> +	r = amdgpu_vm_pt_create(adev, vm, cursor->level, immediate, &pt, 0);
>   	amdgpu_vm_eviction_lock(vm);
>   	if (r)
>   		return r;
