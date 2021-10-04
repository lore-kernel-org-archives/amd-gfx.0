Return-Path: <SRS0=otPk=OY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BDE6C433EF
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Oct 2021 16:04:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C570360200
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Oct 2021 16:04:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C570360200
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3AED86EA45;
	Mon,  4 Oct 2021 16:04:17 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2047.outbound.protection.outlook.com [40.107.243.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1B0C16EA43
 for <amd-gfx@lists.freedesktop.org>; Mon,  4 Oct 2021 16:04:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G13cVQfhmHdDxc2C5DROlrbjiHQNZtQ+mr1v4z1UZmwlFCxnHXmawsLHfyc6DvYMh4ZGGVm1TtJQUwDOWK27FC8iWVwLceM72zIwPhs/eiyylCZmlSfGxaBqr8g6QwiPN+DqlQHHcPGbMOTJEPu8O108AWftoubHEsVXPE2hFD49+dCOZHA6NimBjIoeVX6uxIe8dHcwY5ZQroyLYvJkL20a1lQ3MLHTKkbQU1bF+Q5avyrpKywTZv7e1+FpJkWj2V1bPRPTK9iG51OFsZ0cmRfNzFehbbmcXxYBvM2t+IaWnVP3zIn/FrDANLbbwk0R5ZH8g0o1DvSV+KI+CGScqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NGSzhNOxEC+ds326tRMm9Ll1u3XE8jByLPiFt/gfaEQ=;
 b=TMWXM3E+cJmuAC7KrraAS4lO0xnHJQSGMl2SLdybHbq0Ki+dmCb3MKqKh6suAFOSUpgx4NEKYX0fDUc3E4rlYFWjjKvnyMpUsziseNEHyUe3cc+gU15RW477h91leGDtEWJXQvgLNXZgpuo1n4hAep6D8NzqV6vEMOfLjzQrs/tEkWThfYwWpORbq2O6nGJQ8G/SS2lG16WsOcUirNVHwxiklL3U4UHcb1A4j4A11NijQnWMtGD2XRt9EqI5Dn4VtWo1dkaJYZh3ESlJMOlfuTqs3zs6TndIULqEzJNQkrR35U4nde1ejlpQlOG0fdYkse9teJwgVOeFq33fvQ1KBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NGSzhNOxEC+ds326tRMm9Ll1u3XE8jByLPiFt/gfaEQ=;
 b=OeXwp2Yctfa4rQ2lPHT9px0ZorXCc3so0Zrii7Hh8AnmyByHCdJckCtgQv8EEje83lbO86OxGAeCZTlk48Bsmzmp0Cbn5r/hTdFfQA9q5eEtbprZSM40Pcc8NMAjosbnRU8ncJtYQJKal7AdZmyS8wKsrrPEXULMMTcTwLp0W0I=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1947.namprd12.prod.outlook.com (2603:10b6:3:111::23)
 by DM6PR12MB4809.namprd12.prod.outlook.com (2603:10b6:5:1f9::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.22; Mon, 4 Oct
 2021 16:04:12 +0000
Received: from DM5PR12MB1947.namprd12.prod.outlook.com
 ([fe80::3153:3d7b:e216:74c0]) by DM5PR12MB1947.namprd12.prod.outlook.com
 ([fe80::3153:3d7b:e216:74c0%11]) with mapi id 15.20.4566.022; Mon, 4 Oct 2021
 16:04:12 +0000
Subject: Re: [PATCH] drm/amdgpu: handle the case of pci_channel_io_frozen only
 in amdgpu_pci_resume
To: Guchun Chen <guchun.chen@amd.com>, amd-gfx@lists.freedesktop.org,
 christian.koenig@amd.com, xinhui.pan@amd.com, alexander.deucher@amd.com,
 monk.liu@amd.com
References: <20211002151802.11872-1-guchun.chen@amd.com>
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Message-ID: <7a2fadb8-8576-14ab-2bfa-ba880f0f241f@amd.com>
Date: Mon, 4 Oct 2021 12:04:10 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <20211002151802.11872-1-guchun.chen@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: YT1PR01CA0063.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2e::32) To DM5PR12MB1947.namprd12.prod.outlook.com
 (2603:10b6:3:111::23)
MIME-Version: 1.0
Received: from [IPv6:2607:fea8:3edf:49b0:bc6f:8108:e4c4:3301]
 (2607:fea8:3edf:49b0:bc6f:8108:e4c4:3301) by
 YT1PR01CA0063.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2e::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4566.14 via Frontend Transport; Mon, 4 Oct 2021 16:04:12 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 487fb7a1-176d-4680-4e54-08d987509b78
X-MS-TrafficTypeDiagnostic: DM6PR12MB4809:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4809A958EF1394C77972FA74EAAE9@DM6PR12MB4809.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3XqnveWpmRiorDoYvYAJGZaNCM8nQFYwhQtEZfbAzE3OsdsVamai/QVkB3dIqvpXZtGHT7ucKvFPw6VGmOACzVyrdtrab1oaHE3vuMVWLhcoCRnlaHVT99Mn+ueYSjcK53WM4uY9ScjbbJhf8dgDVRzkUB4rig00rWeGTR2+2Um+EwKs2xTjDQ6m4eLg2zth8JgdiCluZzRN4GcHNxBM77v1qTEEytIoH0w+9fcds3MiZVRv1jbNGV3HciiEcpLcWtyP4jAxRakMmw4Ge27mJYVVr3kfJv9IfQF7Dk/b4m754CiZdcc+qq0c3WV3agK6CKWol0YYRr+ByaJS2vRt8sHpOsEj21tizi1J1VzPNy9CDjqEGpKyoPUZL6PdgK96BnEEM26zVVqLUeZE/qNH2W8RhBugYZM0oPhDl5sbRjkURnGquLmA9nVsbqxVBQIHY3yL4Myyx7drLeJfRBkspaVXFwE40ZRG80QpFSVnF6bAZZa+VO+9o/2I65TNl2roqS0x2dreFb7fYF86D9doJAfPG2ZMHNf7rzdl8SQR+5IDrVemz8tetRhYCqDL6xvsz8EjP41oDooN9gproyLKExYxN2PuTGPzfFKbCb8wf43jPpFvl5/9fEheWgsTh08J8EWGWvwbrvrv0k+yOuPHTLmsjUsDT/Op3qiCDE+/axmp6RClFz01rfGbgKPZb5hseJgTeTFxi4BwOiEk79lfyv5v8rlAQ8cLv+YEzitRiVQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1947.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(38100700002)(6486002)(316002)(508600001)(8676002)(83380400001)(66476007)(66556008)(186003)(66946007)(2616005)(44832011)(31696002)(6636002)(53546011)(86362001)(2906002)(5660300002)(31686004)(8936002)(36756003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cVI1dUNXQTNTS3Q0SkYxVEhVZUlHamk2WEZsR2FuTzJiNjhLbGg2SVozLzdC?=
 =?utf-8?B?cHZZaHdlMDJPRGdlTFcyY2l3ai9WcjU5RzZjTGFteURlS3kwTklyYVM2L0lm?=
 =?utf-8?B?c0dES0VoZ0R5OU1heE1vR2ltY29MSnNQUUhQanZ1WCtyUmpQK1R3ZUFhQTQz?=
 =?utf-8?B?ZzQwcUxkZkhWK3NTeTdPdjBaMHFOVm15ZkVLOVB4S3pyMWZyMStEVmlhSnJK?=
 =?utf-8?B?QW8veDQxWmZFMnZiUE42TCtVZkhjYmJidVFiM1ZIRzJpaUFSZDRjOENGTHRs?=
 =?utf-8?B?d0NXV1BGOWw3Qmc3bzMzYjJocjVha0lmUjBUbVBMNUQyWFZYVDRvSHRoeXB0?=
 =?utf-8?B?MTdQa3V0TXQrK3dMRXYzREltcGd1R3lKeUpPM1lrMkwzU3ozRWZKL2xlSGNw?=
 =?utf-8?B?aDdqSTU2UkNlanJnU3kzT2txYmcvOU1SZkM2VXpiM3RrOTcvUytGaDJaOWJE?=
 =?utf-8?B?K0Y0YlFwSzNiblRCL1lyMUZ6Sis3algyRmJuQldUVXNUK3c1alFkV3EvdUhx?=
 =?utf-8?B?aXM4Q1crSnB2VHBXTGFNVnVuVXo3WnNjSjBEbXQrTDRGKzJxbVdaSUliOUx5?=
 =?utf-8?B?ZUliOGRETjY5b3dQVkFBUmlWbVQxaTlnSEhLTFFVaXlwaDF1d0NzRHd2dEhQ?=
 =?utf-8?B?SEZrdlo4NVJ0MVhiL281aDRNQkRiU054TGwxZkhiaXVmdkYzNnVoblRKYTdt?=
 =?utf-8?B?NWlCWkRpTXVqYXVJeDlkcEprb2pETnpLZjhUbkh6VVhHZ3Noc0VPQUllYmZF?=
 =?utf-8?B?V3BCRTR2RzUwQ0ptMG9zVGlpRXFReklDVjZvTFFlSHZxY0lqTjBMV1RUVUJu?=
 =?utf-8?B?YVhpd2ZDVWVLcy9CYW52dkFjaVhsZk1aN1hxQ1ZhV3loSGpPWWRNMlI2TEo5?=
 =?utf-8?B?MlFNKytheU1SUEZDTmhSSzE2c3VkUndlQ1B3cllKd0RLVjJzQ3dqSEU0eld0?=
 =?utf-8?B?c3lPcWMzZ1loNjEzTllDaGNMeWVlQlEyaWpCTGMxRUxsUXlSSUtkdVFYRHNK?=
 =?utf-8?B?VzBMZ3ZwVGtYWVZhMXM0cDZ0YmNrV2JhNVN0YjJjQ2pRU1U2dVF2eVg5OFMv?=
 =?utf-8?B?WThsemt2clQ1VDg1M2NPaTFUbnRtU0NERzRySGRyaUFHaFZYM2Ixb2xSL1BE?=
 =?utf-8?B?YWJ0ejd6UGlhS1JGUG9YYWJEQkMyNHZjSVhqazdtZUxGaDJOOVFYeGlWQmVT?=
 =?utf-8?B?T1RwMTdNZFN6QW44OG9HRzlNN2liTkluV2d4QnRTKy9pVEVJaWpXZFhxR2lG?=
 =?utf-8?B?aW55QWtxSFdBaVRhQzN0ZmJ5eHpTREVobEsrWnUrQzUwbVVWR1J4SmJwdUx2?=
 =?utf-8?B?ZW9qNnVaK1VsWENiRjlBU1dmZ05FTC9aRjJWSndIczdQSlo4ZzdYazh3WFBt?=
 =?utf-8?B?MmgzREJsUVRpa0JvaElyNEg1d25EaGk5VHpxZ0JYOFJkdmd6SHlwZWVoT3ha?=
 =?utf-8?B?L1JoeklGS0s4RDM3Wm5NSDdEb3RmdVg1R2lOakltWk9nNmZqTFNCT2t0TzNL?=
 =?utf-8?B?b29hRFdlWks1eHR1NjViZHl4TGtmeUFuVUxjMFVJaDQxYVRUOHhSOTVuOHkv?=
 =?utf-8?B?RmwrQ2xlZVVteWdEUjhldWlOdzVEK1loN25Kc2NNcSs1T0wrbmk3ZG1KM0lu?=
 =?utf-8?B?T1NBQlljUDREbndLMDZMQnJaN20wNnNFUmJ1RURwVmNOQkplTzQ3SEFuSjJu?=
 =?utf-8?B?czVaOVMrMkQzUkgrUUQ4RlJCQVhkUHlvSk1EaEJIdnNiYXpaSUdsRHA1OWMr?=
 =?utf-8?B?TlNOYUdxVXVNd3ZhU2NOU3dCVS8rbDhwWFE5aVNYNVUyUVRDVGRJT1lZeXlS?=
 =?utf-8?B?Ukw1U21xNU9kTEYvNVZob2tKQ3FMT0NRdlo2OEFtbDk4WVVOZlc0eSs5SC9M?=
 =?utf-8?Q?1/3mw0DITwPgz?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 487fb7a1-176d-4680-4e54-08d987509b78
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1947.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2021 16:04:12.6981 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nsRRPey+sgPdzcvbR826ux7v/rX3yyRg1xHQE5GrB3cNrczK7JzNL/D5WuCJIqAcfxouu35nASMwQLnCE/DdnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4809
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


On 2021-10-02 11:18 a.m., Guchun Chen wrote:
> In current code, when a PCI error state pci_channel_io_normal is detectd,
> it will report PCI_ERS_RESULT_CAN_RECOVER status to PCI driver, and PCI
> driver will continue the execution of PCI resume callback report_resume by
> pci_walk_bridge, and the callback will go into amdgpu_pci_resume
> finally, where write lock is releasd unconditionally without acquiring
> such lock first. In this case, a deadlock will happen when other threads
> start to acquire the read lock.
>
> To fix this, add a member in amdgpu_device strucutre to cache
> pci_channel_state, and only continue the execution in amdgpu_pci_resume
> when it's pci_channel_io_frozen.
>
> Fixes: c9a6b82f45e2("drm/amdgpu: Implement DPC recovery")
> Suggested-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
> Signed-off-by: Guchun Chen <guchun.chen@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h        | 1 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 6 ++++++
>   2 files changed, 7 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index f4bceb2624fb..720d0ccecfe0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -1094,6 +1094,7 @@ struct amdgpu_device {
>   
>   	bool                            no_hw_access;
>   	struct pci_saved_state          *pci_state;
> +	pci_channel_state_t		cached_state;


I would give a more descriptive name to this (e.g. pci_channel_state)
Other then that Reviewed-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>

Andrey


>   
>   	struct amdgpu_reset_control     *reset_cntl;
>   	uint32_t                        ip_versions[HW_ID_MAX][HWIP_MAX_INSTANCE];
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index bb5ad2b6ca13..1aaeb4b30edc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -5368,6 +5368,8 @@ pci_ers_result_t amdgpu_pci_error_detected(struct pci_dev *pdev, pci_channel_sta
>   		return PCI_ERS_RESULT_DISCONNECT;
>   	}
>   
> +	adev->cached_state = state;
> +
>   	switch (state) {
>   	case pci_channel_io_normal:
>   		return PCI_ERS_RESULT_CAN_RECOVER;
> @@ -5510,6 +5512,10 @@ void amdgpu_pci_resume(struct pci_dev *pdev)
>   
>   	DRM_INFO("PCI error: resume callback!!\n");
>   
> +	/* Only continue execution for the case of pci_channel_io_frozen */
> +	if (adev->cached_state != pci_channel_io_frozen)
> +		return;
> +
>   	for (i = 0; i < AMDGPU_MAX_RINGS; ++i) {
>   		struct amdgpu_ring *ring = adev->rings[i];
>   
