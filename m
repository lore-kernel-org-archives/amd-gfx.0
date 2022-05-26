Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C02FFC433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 26 May 2022 09:57:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E8A010EA98;
	Thu, 26 May 2022 09:57:48 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2068.outbound.protection.outlook.com [40.107.243.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C350F10EA98
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 May 2022 09:57:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LYOVdFU2F8KRsSE+ZHZmNp90mM+UZdBj4eqPSMUCYTnSuFNhlypIdd0G2UugrogFrUEbaWU2a3zjjjgPuOnOZ+VH4mjWYFOptbj8tDvl9zzNCbbNtSuJOnvD+d60KI11FU3zPV7bL6Cd4Qjsat0FL6dOK6J6/VtbWnqtEbqkzg3hjihc1lBjgeY41V7/G9/JbYjMtm5fPVN5YIhs/Jo2Ib6DFYiP2YvR3+dZu0gZ+wanNpvBwK8xvPNB7E+ne872pKJMZj1OXG4SysP7ct8yKAlOBTIdKsNbWtfjYN8TsM+lwn25wJ85yoaC3TfDjoRfTqiEHRp9L4fUR67OxxKBfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cH/oZKetQQC7JvBWGliE0CqOEV3F6marMRca4bXIJHg=;
 b=a7m5NQRh+oCM4rLT606u1WF4P+ImnuQLIopiBNYEEuZMgIhvVQ+qJRN1RjyJpQtw0T5yQqdmq9nKk8XL8NpO4RJaXI4qsWTyWAygWMfSY9GSTOz4an3/GauXSM63pXy2gFmxx5bYmVKCMdiBUdLkBrMFVJsA10tnZJq4OI40+wIHhhTBUb5JBc8pQqhH5R+8oi7j4+byUF0bFk7UwYJ0reWMqdm5PKm2XJW3qq6iOFLPg0nPTe3kGXA3+lN03BadJfY9aKu3NbdY4NLYDS29JWRpU77K605/K3bVQhVw0a/QhvGkhsKYzqpzaPPy5M/BA5Bpv1xBHlIKXHQ5/3yecA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cH/oZKetQQC7JvBWGliE0CqOEV3F6marMRca4bXIJHg=;
 b=S2vpEbRr8Lm7bPJvnU3iClptYnjQ+/GZs8k9qZpm9fyD/yU787i+R9S+FM4J5HN1pta+SnQSd7SckxtoDbccFBstqFtrlIwtOmth5I2XlRO8mzerbTKrzhQN9jasigb3CJYd2Vh4sPLguatPjdNjWAAGudcmrQWfjOobfKtht0o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB5667.namprd12.prod.outlook.com (2603:10b6:303:18a::10)
 by BN6PR12MB1923.namprd12.prod.outlook.com (2603:10b6:404:107::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.17; Thu, 26 May
 2022 09:57:44 +0000
Received: from MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::5149:1152:d389:81e3]) by MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::5149:1152:d389:81e3%2]) with mapi id 15.20.5227.023; Thu, 26 May 2022
 09:57:44 +0000
Message-ID: <3a677ab8-42a7-4bee-6e94-d4cd43991d49@amd.com>
Date: Thu, 26 May 2022 11:57:35 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v2 2/2] drm/amdgpu: adding device coredump support
Content-Language: en-US
To: Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20220526094839.36709-1-Amaranath.Somalapuram@amd.com>
 <20220526094839.36709-2-Amaranath.Somalapuram@amd.com>
From: "Sharma, Shashank" <shashank.sharma@amd.com>
In-Reply-To: <20220526094839.36709-2-Amaranath.Somalapuram@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM6PR0502CA0044.eurprd05.prod.outlook.com
 (2603:10a6:20b:56::21) To MW4PR12MB5667.namprd12.prod.outlook.com
 (2603:10b6:303:18a::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 57bfe9f8-9ad6-472e-154f-08da3efe2e19
X-MS-TrafficTypeDiagnostic: BN6PR12MB1923:EE_
X-Microsoft-Antispam-PRVS: <BN6PR12MB1923D62EB43D60E42753ACECF2D99@BN6PR12MB1923.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SldxrfGjdV/4fVQT6LGDb+P5Y+1vxudr5RfnYqdq5EtqhARSbwhTVLDWG6WJl85Vnd3Vi9gzTU5xMYWRVdo/nhhBqnukYv/VT09gt1zt7opAaCmDJRc/pwZXAHOgBo4jMsVF6Ls386ya7jOnvsxbGxktbcczq6fcXnreXH6aeehgf4FilEeIPrp4GmDjklv3FH0XxruRQ3g5wEyBLyOEnNTFImjBUqyGv8XRZAkEZck28aQRgdurkFp7NDjI6ct/ap0cWe6oJv9W0bgxTC2W2zOudFp+CeFlUgZQjGlivLcnZIkNYYkOONV/Z+Kr31BWU6W0+oAxTP3+kT+m3k1Ts9AAyRlsPsDsQB/uRr+9MPuc5qYE6myzcrWeitqp/VWENTsZ/8JyWd4nD+ntIZxC765xnx/jd9dJ52S4xYE7z9L9OAijJKfyNeLX0AV3ZscEHJJJ6hZa6m27lHeFhd1hRdFoD2TWAjmpaiSUjMvYCusaKPbAuPSt4lLa1scFvHx20EYcTesDBxZnJgQHDHwRPPZ7VpjKR3ZhBEVrN2NSClccsD0Gy8QtMM6lOy1nIAJaBmDUIR3sWuiLEnenqXlWkvAU3aGRzg98knxhw4Or8Z/p3gsbOlfrXFTG9dYXeHrUMo1OK+0JBYmKfM3BxtVfBbEMIsiAvxc2leN5T6ipmOgd0LEyQhTU11uNNtT+g+q0ogJDL4IrnC/IspMZpTmz2co4YckrZYz5UrU6t2/0yZxKoa/Wc245nh0igftcCB2H
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB5667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(8676002)(66946007)(4326008)(6512007)(316002)(53546011)(2616005)(26005)(8936002)(66476007)(31696002)(186003)(66556008)(31686004)(86362001)(36756003)(6506007)(2906002)(6486002)(508600001)(6666004)(38100700002)(5660300002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Tm1NS1ZKVlJiMHM0SHRnUVlEcmJEc213VWxJR2ZJamhSTldyUWlQMHR4YjFN?=
 =?utf-8?B?VDVqay9VeDZHRkxWUjFheUhTVERkMnJQcW8yTG1KSDU3amQrTE5HSG04NDBm?=
 =?utf-8?B?K3FpZTJxL1BsK1FNRlNJaDFQU0I5TU9FcExvS2pJaWxjVmZlT3huRUlOb0ZN?=
 =?utf-8?B?eXV2dktnLzByUGtoV1lDSllCVW04K2JZQmtMR1R1Y3k3Z1ZPV3ZxV3U4QjFY?=
 =?utf-8?B?R0lFR2xGSmRKcElYNjhBUE51c3BmbStJOXpmeUthbytjZ2F6bWp3RFF3YjZV?=
 =?utf-8?B?NVZTbG83TStRNGJjbGpLMG9aSDlxYU8vMld1TDdhY1VVcG1VWm5nK01YWnZM?=
 =?utf-8?B?WnY0eWx2b2NCVURMcEFKR0VGZk9US0UrLzdXUE5PVFhXVEJpQnZCWmFyQlJN?=
 =?utf-8?B?eXJWMGNGNFdrOElMN1lXSkdRSkxOQWZYaVNZaUp2TXlUa204NFA2VEZJZ3pQ?=
 =?utf-8?B?ZzlqaldTMndNWWlnSkxieFNwVzM0RzNaVHRWdVFzWU1ieTJkT2ZiOFJuZ1lz?=
 =?utf-8?B?d25DdCsrRENjZ1N0NkpOQ0N6a1huRzRqcmVaNDNYRTdiVVZ1U2dYdVAvdCtD?=
 =?utf-8?B?eFFTWUMzcjk3c21uWUEydGhxakV5b3IxY1FSZ014OHpBdmlxa3RRd2ZLRm8z?=
 =?utf-8?B?cSt4cHFyVmdkSW9RRnZ0ZXlEdS9ocktoUDg1dGk5STBlS0U2Vy8xTDMrR3hG?=
 =?utf-8?B?ZUVnYy8xbnoyVEtWNHdud3pUOUNmNjdVTzlPcGhSSG51ZU1OQXRYTXB2bjgw?=
 =?utf-8?B?c05XNGtjK2o3aDc0emtHS1JLK0ZsQXZPMGxTYjNJK2IrdmxIRE5ycFcrenpN?=
 =?utf-8?B?ZVVkaXFTRkNtTllnOUpnSFRoVUQvdHpJYlJaaGFUSzJweHkzcmxtald5dFlu?=
 =?utf-8?B?eW5XelMwdVZaZ2o1bEhzazlJek8vdVBZOTdNVG9EdjdJaU9zcUJnU1AvVEV5?=
 =?utf-8?B?Q1B4SG1sY3QxT2dGTW1oM1lXRlVZOXB5eXdCVGloa09iSmdNOFh4dXhmRkNW?=
 =?utf-8?B?WW4vK2phdFIraVMvY0lkQS80dnQyTDc2TmFLWHR1SE5WOC9pSGN0Vm01WGZo?=
 =?utf-8?B?Ry9iTzIvb1pQNDZHbWZHbWhmRjFxUmVqTW84YzdVYXJJWTJOaXkvaDhQZXhF?=
 =?utf-8?B?L2tJMis3YlZZelpjWVVVdmw2QTZYQ09hYXM1S253bjRNNmwvODJhTEl4TEJQ?=
 =?utf-8?B?Ty91dTduSGJMOVQ2bldYYzU1Q1UvNkFrUEI3cDJkOExwQVZDbEFCcGpvaEY0?=
 =?utf-8?B?MW4zWWhRNkdLQjZodkFXcSsyUmhraytGcnVRcmZYSWwyeXBUL2ZoNFZIVkx5?=
 =?utf-8?B?S2cvRlJEbGxOMjgrL3Jidzc0OE81MjhIWlNHNUpGcG53dDdjaXpRUS9SOFoy?=
 =?utf-8?B?MWNQaWQrNXp4SmxJdFJJUGFSL0g3eDFibkhzZndRbGQwQjZEcGI5cmNNUThn?=
 =?utf-8?B?TjBPVmorZDFpbmwwNFY2NXBsL3ZldTVZc3VodWJFakRSS3ZtSHZKSEJ6QU9X?=
 =?utf-8?B?cmo4eUlUQ3BMMUNKQndYRjFxT2xYdU9vYmdqU0tVRnhzeCtiUXVtV3BmcjBr?=
 =?utf-8?B?S3k0dXNhdGZoa0FhMWkwWDBBNmcrL2ttWmZkK1pqZ2FKbTFRSVEweUZvWjVL?=
 =?utf-8?B?OEhVczdDZFlpZzMwU291Q1YyS01Rb01vaVVWTGUvWTJPeGxjejRlR0xBa2h6?=
 =?utf-8?B?SEZraGhmL1JIVXhyZ2FCV1NGMjZRYngxUkZPMmRHN2dPdTcxUHBrNnlaL2h3?=
 =?utf-8?B?OEp4azNrNkJQQjY4STFQTnRWZDhBMTRneFFnRlR0YWNQMTdOSHczNER0WW45?=
 =?utf-8?B?MlNTMVh6MjVvb1Z4K0wwWTlLNzE1NytTcnZsK1NDdFZjQ3R2ejFTZUFrTW9o?=
 =?utf-8?B?YXpEM21Cci9sK3o4L0txNUxsbzhZaEs0N2pwaHAvM3QxeHV2WE54d1VVMSs5?=
 =?utf-8?B?M2hNclVzN3p4dzM2d2hjUXBvQk9ZNkFnMmpMQ3ZtdSs5enorb1lnaEE5aDNy?=
 =?utf-8?B?Lzg4cTZwd21ZNXA5U1FLVTlxRkZqdlFpbVExT1FhRkphSGJOY0xXRWN1bFZG?=
 =?utf-8?B?N1llVTZyd0xmT1kzQW5sZ21EeWJyamJwTkNsYW1HTURNWHU2M2NxRjVSa1lK?=
 =?utf-8?B?ck5QR3JJM1Q2SHYvbHorZUNkM0VKK2haRlJMOXl6VUcyQ212RHAyRmVoQzlz?=
 =?utf-8?B?VFZKM2NIZDJTTzNVMWtSK0pERGtSK1ptNzRPRkN2L1RsL2JqdFh6cmFBY0dt?=
 =?utf-8?B?YUhwQ2UxYUlvbXVYTzU3RmZXbVNHbGhTWXdjSVpKVE9mTWJXZldiVG13bTI3?=
 =?utf-8?B?d2tkM1g3TGU2YWt4Yk9OMzNJNVpYQkxRdnhmenZ5b1hta1R1U3RIUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57bfe9f8-9ad6-472e-154f-08da3efe2e19
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB5667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2022 09:57:44.5950 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fl6pxjvFDRlZjs0N+LQUkLbUHvR0ia+5vMoqJmJOtxDm3rkVWJQRVNN4DiMcRx51BaN945a4FIhO1OX6STHWKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1923
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
Cc: alexander.deucher@amd.com, christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 5/26/2022 11:48 AM, Somalapuram Amaranath wrote:
> Added device coredump information:
> - Kernel version
> - Module
> - Time
> - VRAM status
> - Guilty process name and PID
> - GPU register dumps
> v1 -> v2: Variable name change
> v1 -> v2: NULL check
> v1 -> v2: Code alignment
> v1 -> v2: Adding dummy amdgpu_devcoredump_free
> v1 -> v2: memset reset_task_info to zero
> 
> Signed-off-by: Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  3 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 67 ++++++++++++++++++++++
>   2 files changed, 70 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index c79d9992b113..25a7b2c74928 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -1044,6 +1044,9 @@ struct amdgpu_device {
>   	uint32_t                        *reset_dump_reg_list;
>   	uint32_t			*reset_dump_reg_value;
>   	int                             num_regs;
> +	struct amdgpu_task_info         reset_task_info;
> +	bool                            reset_vram_lost;
> +	struct timespec64               reset_time;
>   
>   	struct amdgpu_reset_domain	*reset_domain;
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 866b4980a6fa..ca97afe5be63 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -32,6 +32,8 @@
>   #include <linux/slab.h>
>   #include <linux/iommu.h>
>   #include <linux/pci.h>
> +#include <linux/devcoredump.h>
> +#include <generated/utsrelease.h>
>   
>   #include <drm/drm_atomic_helper.h>
>   #include <drm/drm_probe_helper.h>
> @@ -4734,6 +4736,62 @@ static int amdgpu_reset_reg_dumps(struct amdgpu_device *adev)
>   	return 0;
>   }
>   
> +#ifdef CONFIG_DEV_COREDUMP
> +static ssize_t amdgpu_devcoredump_read(char *buffer, loff_t offset,
> +		size_t count, void *data, size_t datalen)
> +{
> +	struct drm_printer p;
> +	struct amdgpu_device *adev = data;
> +	struct drm_print_iterator iter;
> +	int i;
> +
> +	if (adev == NULL)
> +		return 0;
> +
> +	iter.data = buffer;
> +	iter.offset = 0;
> +	iter.start = offset;
> +	iter.remain = count;
> +
> +	p = drm_coredump_printer(&iter);
> +
> +	drm_printf(&p, "**** AMDGPU Device Coredump ****\n");
> +	drm_printf(&p, "kernel: " UTS_RELEASE "\n");
> +	drm_printf(&p, "module: " KBUILD_MODNAME "\n");
> +	drm_printf(&p, "time: %lld.%09ld\n", adev->reset_time.tv_sec, adev->reset_time.tv_nsec);
> +	if (adev->reset_task_info.pid)
> +		drm_printf(&p, "process_name: %s PID: %d\n",
> +			   adev->reset_task_info.process_name,
> +			   adev->reset_task_info.pid);
> +
> +	if (adev->reset_vram_lost)
> +		drm_printf(&p, "VRAM is lost due to GPU reset!\n");
> +	if (adev->num_regs) {
> +		drm_printf(&p, "AMDGPU register dumps:\nOffset:     Value:\n");
> +
> +		for (i = 0; i < adev->num_regs; i++)
> +			drm_printf(&p, "0x%08x: 0x%08x\n",
> +				   adev->reset_dump_reg_list[i],
> +				   adev->reset_dump_reg_value[i]);
> +	}
> +
> +	return count - iter.remain;
> +}
> +
> +static void amdgpu_devcoredump_free(void *data)
> +{
> +}
> +
> +static void amdgpu_reset_capture_coredumpm(struct amdgpu_device *adev)
> +{
> +	struct drm_device *dev = adev_to_drm(adev);
> +
> +	ktime_get_ts64(&adev->reset_time);
> +	dev_coredumpm(dev->dev, THIS_MODULE, adev, 0, GFP_KERNEL,
> +			amdgpu_devcoredump_read, amdgpu_devcoredump_free);
Alignment with line above.
> +}
> +#endif
> +
>   int amdgpu_do_asic_reset(struct list_head *device_list_handle,
>   			 struct amdgpu_reset_context *reset_context)
>   {
> @@ -4818,6 +4876,15 @@ int amdgpu_do_asic_reset(struct list_head *device_list_handle,
>   					goto out;
>   
>   				vram_lost = amdgpu_device_check_vram_lost(tmp_adev);
> +#ifdef CONFIG_DEV_COREDUMP
> +				tmp_adev->reset_vram_lost = vram_lost;
> +				memset(&tmp_adev->reset_task_info, 0,
> +						sizeof(tmp_adev->reset_task_info));
Alignment with the line above.
> +				if (reset_context->job && reset_context->job->vm)
> +					tmp_adev->reset_task_info =
> +						reset_context->job->vm->task_info;
> +				amdgpu_reset_capture_coredumpm(tmp_adev);
> +#endif
>   				if (vram_lost) {
>   					DRM_INFO("VRAM is lost due to GPU reset!\n");
>   					amdgpu_inc_vram_lost(tmp_adev);

With above fixed, feel free to use:
Reviewed-by: Shashank Sharma <shashank.sharma@amd.com>

- Shashank
