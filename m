Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16635EB64D9
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Jun 2023 19:34:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F76E10E04D;
	Mon, 19 Jun 2023 19:34:13 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2055.outbound.protection.outlook.com [40.107.244.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 814A410E04D
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Jun 2023 19:34:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=loy/s2c+ZDtq7k7BNuswbS0NmPv/7Rfexn4gAv9yiJj376VxAgQF/sl6TJIwG7Ghg7Cx7VxO/QG0TE5l9hRkdn3RnZNa004YagaGHbQ1NgjO8Yar74FLkdC+ybUqdqljui5gOJ/fiNKd8eqeMbHdP+IsJxvsY9clW5rGUVdkChlKUHOeqKg+pM8+N+iz3iS75z6+Hom95N6DeyclXlGxDZiLsKCW7hLdEHofcz8cXKYznMuiFD/vScDn5fToY3GxgvsMN05oaHRh3v6JQcx0KNQ8Tapkc+nS7VMWMsJfxUu+2edXn4u3Je4vQa4O1vX6rwPchOyX+EiOKGajL9JlmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=txjwHP1Acq1R57/LRu2Nkzb2N2qkfmZOfe57COjdcOw=;
 b=igW5CLMjcbyIsSPce03SlsV4BaRIoYHKEn8EBL8/SkBHf9/P1q9rN+sY5yCWobfuxs/Kv5NP+MqGSw49UsfcoMse0WjScXvmZxxSUu3WiLGXGIN0tmp+Ps28EQ2sJG+DYV90vKtDaJr73zJYdElCRyEQCsIWd/7czQPySsoZrbyP63dZVYs83rNHQNZ2HFS+/JEvYbibv88eu6abgBd0Qfiz3LdG3PDND/FsOwf6vuppFsECCF2Y0bn+zZxsth99BN2QsxkKKfLUEJLc7MDe7987CX4Nf3POPYIIH1AL16oyUwG2hzRvPHtLms+8Mfd/MU/tHOMbTlSmM4e60VEGVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=txjwHP1Acq1R57/LRu2Nkzb2N2qkfmZOfe57COjdcOw=;
 b=NXA0dcqW/ydH2Ps/86K2GJk8zgOmEznEhw3dIHEYOJ5MaBSlHdCNQFE42tb9qw4i32lAune97zK3LQ5gyTm52/TSDq+jD7fRveak0DA7nePsnZyged1K/UJ3ZWQeF+nAxGyP5IQfOx1/HUlkwK0S3SHUdeO1WvAjVOy5WAxLn/g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by MN6PR12MB8513.namprd12.prod.outlook.com (2603:10b6:208:472::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37; Mon, 19 Jun
 2023 19:34:09 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::2dc3:c1:e72d:55bc]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::2dc3:c1:e72d:55bc%7]) with mapi id 15.20.6500.036; Mon, 19 Jun 2023
 19:34:09 +0000
Message-ID: <61a95cad-d7fb-9114-39c9-41d4d3d75315@amd.com>
Date: Mon, 19 Jun 2023 15:34:06 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] drm/amdgpu: remove vm sanity check from
 amdgpu_vm_make_compute
Content-Language: en-US
To: "Xiaogang.Chen" <xiaogang.chen@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230619190651.23982-1-xiaogang.chen@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20230619190651.23982-1-xiaogang.chen@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0198.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:67::35) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|MN6PR12MB8513:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a95dab3-12ec-4298-7068-08db70fc2704
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PPcyBfSkCj1sjvuERgV5amVzW1N3x9QEaPNqqJKhhVzw7JtMMHjjsWC83g6HneQ5+Yw/GlBGrZiN3aGpk0r9iggBMn9WGsyVZui8frDzYwdufQ0G/ETdEYV7elyw7bL86G03gQWU0ivzJW93NsS0VaRntiGrmhxFabGNSkhNovEgxLOXRodMnnuatJY1c/bV0caNiei07J/TVuw9eOsCpSSiwQUkNkrOy3bzs5ZsXLYFLqeKJ8vLppyETSixeIVbdO8bBaoA9KFskf94tA762HF0Si1KcBoa4E+Yj/vpEYoqv5C+9T0p8SRuebxfFEF2rweQgpkV2bbSJd1sN2RFastmC0N6nB/mUkN+IjOQWzEY/Y6cN5ttbQ/PqsyeZMwMiex6oIxku8WT7Syrd0BTwoL4yU2efpy9ckFnPcItIDJcmMd9/IfLHKeEG9h1MyKF8L7DjHN6YuTcPbk6fkOYIsqs1K9MUCj4oCz5XGQnc5LgIwxHf6Rq5tqWr85oZBZsf0bJmFVWrqK612ug/zVIzPSW/QXDJqL7E8brCM7AXYYLpAKYELwDnzBQYikXpYiRu62YUPdEM6XiUyyQE7Rv212crGBxgrpKtnW5SGs4V21urQUTM+UYcksDyF78NkLKEShUYo3Jg8NX3r7qizrdgQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(366004)(39860400002)(396003)(346002)(136003)(451199021)(478600001)(26005)(6506007)(53546011)(6512007)(6486002)(186003)(6666004)(36916002)(36756003)(2906002)(8676002)(41300700001)(8936002)(66946007)(66556008)(66476007)(316002)(5660300002)(44832011)(31696002)(83380400001)(38100700002)(86362001)(31686004)(2616005)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZGZwQlprN2FVR1JTbEM4dHphZ2lyR3BiSDBTaWVueUpmQXA1TUFnRkoxRE9q?=
 =?utf-8?B?MUZEeEZ1NmhFYnRtRG9WeGxXekM1Nmd6ckc1ZHlYU3NKU1F2NFRoaitSQkli?=
 =?utf-8?B?aVkzYmNuNmNKbmswTCtLRktRdjhhM0ZXc0kyeE04T0xpWUdIZGNZdGN5Z2lM?=
 =?utf-8?B?VmNyWTNoWllkSEpUaTBuR2hEUnA5VWNCeElteWtoMW41TnJ1Tm9CbDdhNTNU?=
 =?utf-8?B?OU5CWG1YRU1HZUZ4Yyt4SndwQkhCejNNUDc5QzVZVmhjNFFOYTlKdnhQc3JG?=
 =?utf-8?B?RVRWKzB6OHdlM3draitvUi9tNGtKcEhIZzlXQ3dkeW9Rc0hnWlI5OWVqQ3pI?=
 =?utf-8?B?M0JTWmM4bHUvWDZWblNIZTZLS0xNT2c2UjRlaFpnMDExNk9WQmFSV0dMbGdC?=
 =?utf-8?B?VTIyaExXc3VMK1Ezei9NUm5SYVJQWm9LRHpISUJTclVsYlhlRGVmOEs4K1ZF?=
 =?utf-8?B?bGt5bVA4WkcxaXhqcXhoamt1bENvbFJWVFdzNStRbEhMSG83bWM0Wm9BQ1dw?=
 =?utf-8?B?Y0ZjZ3dnMEdtRzhkY0MzSWtSTGRDajN5YnNwa2tvamsrazVUaVZ1MVF2UlRV?=
 =?utf-8?B?L2NjU3R4SndvMlVsSVA5ajcxTXFaRUwyMGVvSVlUVE1jMEk1ZFRlTldjZHVr?=
 =?utf-8?B?b05IcG1ubHEzL3RXOUhDTFF0WkFod3RIRjczOUljQ2x6aXFQeXZyc3FUdFNR?=
 =?utf-8?B?Vk5IOWdrU2dVV0c3RHR3bmc3S3VKQUhEWld2ZDN2QW1uNU5IWllYSTN6WUh6?=
 =?utf-8?B?MmhqUG9SdThVcUFFN0ZZOWVqeStWbVFuZzJ6WUFBSERkNjlMV25mYjRQVDlJ?=
 =?utf-8?B?T0FYR3E5YWRiWkpmY3JqZUhzYkw1WGJka1hjR1BiOTFuRjJvOXhQYkZScDMv?=
 =?utf-8?B?WGN5NWJyZk51eVZNVjFjWjN4S0VqZDF5a3VrdHZLWGU3alE0TE9aQVJVV1pW?=
 =?utf-8?B?QVRwL3VicEN5SmV3Z1ZQU1NCV08ySGdzVkhqNHlXWG1HU29YMkVjYWRLNnNN?=
 =?utf-8?B?bDRhV25DcU12UWd4eUMzMGZYVWR5KzZMS3NZMkhZdEZ2QWZYL2pSTDMxSE9K?=
 =?utf-8?B?M3Q0RkZFVnIyMUZhZFZtQmNXRVFiNnBjeDZYbEtobkZVRVU3dE1pNDlvZHpF?=
 =?utf-8?B?NnZGY2xLUFh1STFiWjhONTBMVkV3YzZzNUpjSEJFd2svV3FER2NtRnZYU0pQ?=
 =?utf-8?B?Mkd6TEZiWkpkYldoMnJjbHltTDRuVHFUcEYvWFVuMVlxQVY5NHJFa2ovbU0z?=
 =?utf-8?B?TzV0TGtVbElIaDBmWlM3ZnhjRFlpVmVTNmZUS0xyRExMSm5MV1FNWFhuZWRh?=
 =?utf-8?B?R3pnd1IxWGxwclFDWTZ4NmREZ01FeVZoc3l6eWZubTY0ZjFzQUgzSTI5TGQ1?=
 =?utf-8?B?Q3JPVGdCWGtpa2lKZkNLMTdnY29EUDhGTFh5TENEN0N2bHdCS2ludjE2N05w?=
 =?utf-8?B?dllJclRQdmNodUdMaWRxQkRnV0dOckNURkVKZGErenU5dU55UkZ2MVB1WU5H?=
 =?utf-8?B?Z09CRWZ1czIxTTJaNm1qOWlJdGg1QmpqcVhydlp6TUNwT08xWi9ZZ1pLWmw1?=
 =?utf-8?B?WmpYSUt4YjNONURFQWFJR3hmdzIzb0NCSTBORXNQZEZ6YXVvRENHZndJT2ly?=
 =?utf-8?B?OGN5MlFVYS9IVGk1YUVydVZsL1l6VUhHOFZVNGtUUVBaRDNCS0p5L1RKNFlF?=
 =?utf-8?B?RmtNZHcwdEFaMUZzVUJ0VkpuS1g5Uy9aZndQV3VJWWJNSjZCcUxxa1IyZFd5?=
 =?utf-8?B?Uzh0L3hwUDVQcEd2b3pScS9DWWtvaSsrL0QrZ2ExVUdwZWdsVjViTTRyanFp?=
 =?utf-8?B?WG8vb25idjFVMjdseWtoRFNsNy9TNzRBSjdEUXdhcFBSWG15L1ltTGRsNCtu?=
 =?utf-8?B?b2trZVZTQjh0Q05DckVYejhKL0RVWTZvZkRJL3ZoeGRKZE9hL3BBY3Q1R1Fa?=
 =?utf-8?B?YU1vSGdKT0NxeDM2SmdvdEdueTRMNzFnTmlSRGttaXhHejluZUx4RmNHV2JC?=
 =?utf-8?B?V1gveWxBUWdWMk1jbVljZ2FpMTR2TkUvTytxNTc3bXpYSG5XMEMwbGxvVFpl?=
 =?utf-8?B?bTRHSTBOcWFMcnRVSDk5Y1Q1UU9XWmRqbWV5cTgxS3JjSklxNFY0aFFzemd1?=
 =?utf-8?Q?uotKGp5DhrFc1EfBBRMi8mB65?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a95dab3-12ec-4298-7068-08db70fc2704
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2023 19:34:09.3348 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vzv5rl+6g5BfjU+y2wtSUL9/6VPwEQIp1BhhS2fHkyHqxq88LJAYcfexiy9p3CDBSGQLp0u7DZzSxCg5MYqVSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8513
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


On 2023-06-19 15:06, Xiaogang.Chen wrote:
> From: Xiaogang Chen <xiaogang.chen@amd.com>
>
> Since we allow kfd and graphic operate on same GPU VM to have interoperation
> between them GPU VM may have been used by graphic vm operations before kfd turn
> a GFX VM into a compute VM. Remove vm clean checking at amdgpu_vm_make_compute.
>
> Signed-off-by: Xiaogang Chen<Xiaogang.Chen@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index eff73c428b12..33f05297ab7e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -2246,7 +2246,7 @@ int amdgpu_vm_make_compute(struct amdgpu_device *adev, struct amdgpu_vm *vm)
>   		return r;
>   
>   	/* Sanity checks */
> -	if (!amdgpu_vm_pt_is_root_clean(adev, vm)) {
> +	if (pte_support_ats && !amdgpu_vm_pt_is_root_clean(adev, vm)) {

I think the correct condition here would be "pte_support_ats != 
vm->pte_support_ats", because that's what's used to reinitialize the 
page table just below. I think it would be even cleaner if you moved 
that check inside the "if (pte_support_ats != vm->pte_support_ats)" 
block below.

Regards,
   Felix


>   		r = -EINVAL;
>   		goto unreserve_bo;
>   	}
