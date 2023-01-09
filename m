Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27CBEC5479D
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Jan 2023 20:21:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B3C5D10E480;
	Mon,  9 Jan 2023 20:21:00 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2077.outbound.protection.outlook.com [40.107.243.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DADD310E480
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Jan 2023 20:20:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ReConLApk8PeXy6xu9y7gLOSoY/vaeuKXqPaZQaJZzdmvgRlxQOvn3ZnoGnLbBbJbyv/Eej5yZ0wIMlZWHxD3SeDTkMfWsoayPzXDTUycIW7BZQyWLk7udQ/Y9s/2uMcWvRoGPx4DWRRlxEv3vmk+XiwtJvDYPUEKcoWeeZtM/Eh9UcX9rAqASNgUlcdLjFghx0gxskgEG6GFFKT4PxeqA8Rs9hjcMh5ZH5THHwH0iF9NxiMrq4EsMNtEr/sT4PZzrE15PSqnaCBR0T0b+ZdgZsytXAh5Uj1Miuunh5u2iHDsQJTKXyuaW6Ic5J5qT1T0q5NommfUNWis+LaCzaAvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bmpfh7/P0SR/Uebx64BS65BOo4wajT0ZtVevZO3xez8=;
 b=JN4hGK7bMaR5ZoFHsSjmjbiQ3e5APp/XmwNfzOq8HpcxyfFuxiUdXyMV6ou+96Xj3CJgZz/2LJdeFBQ8AxG3mWRFk0eyuNTtavgFt2mxVgXwoHEqh0mg6JhrpaCxg2rjWbJ5DXgE1kNwYan7mw33jdzS8xyeMFgkYNmnTOt+IXMjNTUnUuwyiZ6w9KaLOJTjvtUsvOiYTfeVFf2FJfSoPKJzU4fCvX6caA5FgHGVnLsYtfNWErNME6su5IC4EYoWTQLFN59OF87CI7/FExpGglCFuBWSFDrOsDXWPiERMg5JobOQ6ez8q4oTC5QDvx1AtVkQhlOr/u7Ul7yl760nmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bmpfh7/P0SR/Uebx64BS65BOo4wajT0ZtVevZO3xez8=;
 b=5R+hLDnMkJwhdBTcie4WJZg5KJArTZiVSRmgtNHjSJ8g5x96IGUn2sJlrcaianv+Yjabh+npsRjoyHJu6S1DPGBGNcX6nA5HiTQMpIiNiCOMVwCTqYnIuZG7ty2MNTaJHdcrMkag5D/jPwE0dPAngpe3+j8OR6hcny1xIfY4Dhw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by DM4PR12MB5056.namprd12.prod.outlook.com (2603:10b6:5:38b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Mon, 9 Jan
 2023 20:20:56 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::c3f5:aede:fa4d:5411]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::c3f5:aede:fa4d:5411%5]) with mapi id 15.20.5986.018; Mon, 9 Jan 2023
 20:20:56 +0000
Message-ID: <6f6b44cd-6382-2517-66c4-8fb9245ee1b3@amd.com>
Date: Mon, 9 Jan 2023 15:20:53 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] drm/amdkfd: Add sync after creating vram bo
Content-Language: en-US
To: Eric Huang <jinhuieric.huang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230109192743.133767-1-jinhuieric.huang@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20230109192743.133767-1-jinhuieric.huang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR01CA0006.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01::14)
 To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|DM4PR12MB5056:EE_
X-MS-Office365-Filtering-Correlation-Id: 3fd49481-b854-40ad-cc29-08daf27f03ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cIhemOCehg2tiN3fpnt69rucxXuosjJci//9ySt8oyJoVyEmYyZOMhlue84/NUtmL4an66m2bcpx+57x+A5Ax3L8EPHLnxHLv9/akMsr5qQoeY5hw+K+dxtq1opb+i3/0jFoI1lwxeibF2btO7VLDugIshSMax1UPUHlCtx+/c57UeyTP7moy6knw52vnoV+AfQx89fvQOjFxghm8DvlsHztxZZ9FKFbNlARHA7nG9yqfeFuJLK6/Pj3IPYv4j/GFKdGKDIRlCjrrLJAnnANbGWHf05xC/HnghsEpdboUsy/RqOCl19a2GUctO2EFtybG+af5zRnIqGjIfz65o8CnAkaYdR5oKdd2EUV8bicCAPn1UurGR//KcImF9yuWsN8qMrhWf8tqeQUNDmKc5+qmFuyY0cW03V9HJ3/mMMNYUmIe1GAym8uPzEq3M4yYqU4bXzcdtYNdeQGBrJe8jmk+F1DXPztJOVx4uSqatjfnMBPpimIwGSHFS20z9KnsZFPGR7KOf9ow2KdwfbAATcP67QcE5zBQ4RFSLRP5scZRPysEgphbfi1cDutX6hUi0b9yfBs07WDvL4KBfIFE56+4fNG4Fi82bfLlMpzysGPA/yAOU+yo2kAaGFJzhvlMPZh0QnDw0BVhPdlm8aknYvvUUmOM1meM5XLVVY2oCMdZzFo2DeUt70nJ90klSinJUKiQbNCU5rstTwwjxrpuQHZjWMVxiHLKxAjh6PJ9K1p238=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(136003)(39860400002)(376002)(346002)(366004)(451199015)(36756003)(186003)(8936002)(6666004)(26005)(6506007)(6512007)(2616005)(66946007)(5660300002)(66476007)(66556008)(316002)(86362001)(31696002)(38100700002)(478600001)(41300700001)(6486002)(31686004)(8676002)(2906002)(44832011)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NmNGNjdacFRjMW50eE9EeVV3bG5UR2hmTXVzMG11aUw1NHExYnA5MTlReis1?=
 =?utf-8?B?Wi9ORkJJcC9FaUE5Q2E3ZkF2YWpxUlh5L1EzNE1VZkp5VlMwcFM5Y2dvUmRC?=
 =?utf-8?B?djVsZGVWbWRwbDN1alJqamMwQTQ5anpqUnNXblg1RmxhTjhOVGtXVURibTJn?=
 =?utf-8?B?dUVKK000cXYxSFI3Z1NIYkljZmFUNjlUSElNMk5KYzZyTE1CQUxqMlAxcEkr?=
 =?utf-8?B?aHRlSUdJK0xQWk5RdEx4ZWlYQkRnS1h0UGx3elhYemdjTmxqeDNpK0dVbm0w?=
 =?utf-8?B?YkJsditaMGtzd0E3TnJrdWU2ZlQ1SDNGQlhjU1FtbVhFU3JqUFNEZWdDNjI0?=
 =?utf-8?B?eVg0THB0UTd2VEx2RXF4L1pITXJtZ1RGWEh4MUxpTnhBTjNSemoreHlhbE9F?=
 =?utf-8?B?UkdMU1B5QzFaN1h1bEpVeHNZK2tMaFFQc3poaktMVkhuN0Nsc0VGZEpEN0lI?=
 =?utf-8?B?b0VOK3h0UURUWmFkVXd6ekJNL1NUNDgrQ3AzYjhLeFVHeTU2aVQ1Znd0cWJP?=
 =?utf-8?B?SWtiWjZid0xqU0ozZjdkaDREVDdac2dyeVlaazVndzBuMWFhZDg5WHZPZk1x?=
 =?utf-8?B?U3ZNQ1EyMzJHemhHT1VWNTNJUndJMlhoQzFVRVA2clhlTnFKNUZHaWtFL3E0?=
 =?utf-8?B?VklzdVBPRXk5WDJCOWNVbnYrMW5iZXZqYVpCblgxYys5aDFTelE2NDR6WFBO?=
 =?utf-8?B?elJTNmZUTUpQN0ljT2duSm45VWozQXVJeWpON29VRE1BRktUanRaeFpoMGFu?=
 =?utf-8?B?UTgvQkltWU0xMUFvYUdDYy9oSHJZYTFEYWk3WWsrWXIzdHhNVURvNE1BcGZ3?=
 =?utf-8?B?UVN6ekxuSDR4K09tV0hMbGt1MXo0cFFBOWpWWCsyNTJ6RHdxbGVacHVRWmxj?=
 =?utf-8?B?UnRwTEFJUmY1U0xsQmI1UFljQWdrSG9uLzZzZVBvSDBOUk5EaGYxaHg3cFBF?=
 =?utf-8?B?WUdEQWdqMU1seHZTa3ZxWU0vdy9mOHF6dmh1VE1DOW5oUjdMYk5LRlZING5j?=
 =?utf-8?B?elJtL2Yya2IxNDBSYUx1a3BldnlHZEtxTWN2b3VENHlZRG9hQVE3dWpjNWlT?=
 =?utf-8?B?aERHWXl1YVpza1hPbjdIVjlIQWZLWUFmTWlGbzA5Y0VZU042YkZWeWJSSWRS?=
 =?utf-8?B?WmZrS1VYelJmZUJnWmN5S2x2SnhMTnF2c09BT0Rjb2kvYWNnQk12UHNPZ3Y1?=
 =?utf-8?B?MXIvYkRWNC8xSlBnMjhrT2JIaFNxWGJOMzNnRGpIbWhQQzNSTmppV0VDWnZC?=
 =?utf-8?B?ZDZNdEFndEFwL1IwS1hCS2xRVktucFBNeUswMENKWWFsa05tK3ZTelFUUGM4?=
 =?utf-8?B?VTBWOWxpa0hrMXhTOUlHZzRveEIrY2pIMkp0dTZxMFVBOTJld0NyZXRqak4z?=
 =?utf-8?B?cGVnQ3FJSmd3UDNlVldiYTJWMmdwQnlCL2UvWlFPWlkzWk5ZRy9WNXdubkYz?=
 =?utf-8?B?VzRYTjFyNzJNQ2FTQytQOStZZTU0UzI2VGxRa25zSW1uanZ2Z1hKY1p5RmpX?=
 =?utf-8?B?aTNzVTIzY25qRUF1UmhVNXNkSGtsTHRUZ0VtRzB6ZkE3L1RuTlJ0aTh3angw?=
 =?utf-8?B?dUk1ZEtXRENsOEd6ZHZjbnNSUUdmOCtqMFBnZDNaNThqUEZSNnR0OU1kSitZ?=
 =?utf-8?B?d0NyN01ucmluRlV1aGtvYkJ4allqRDQ4QWE1cUs5UGwyV0h2czRrRHdiQVlB?=
 =?utf-8?B?TG43dGREaW82YVFEc2FVMnZ4YWFqeDFqLzVsd29vc3hMVGYwVHZRdUhZaCtW?=
 =?utf-8?B?THMzZWYvQi9mRDRsN1cvOXN1T2dUOVV5cGhLMmsxQ1FFOHN2MXVlbWljaXFz?=
 =?utf-8?B?UitVQTVWZFZoWU1jMGlPMmh1MWxLK2pSQU90cWxkcDBYSm84QTIvRSt1blE3?=
 =?utf-8?B?RWtzYTB0SHFHcys2SE5LS09LUXB0TUVUUk1kZTBnNG1vcEcvSzd1WkxQRHNk?=
 =?utf-8?B?WlFNdkc5T2VNQXk2MXZsK2srdmY5NmdkY2kzRS9BdTVtQ3BneExCanJIUVJy?=
 =?utf-8?B?VEdRWUtBRzgxZnVGUStVM3BnT1JSUGVtdHp4UEZvYkFhcXlpeTkyMk5YMSto?=
 =?utf-8?B?YkhQOXV6bWh3V0JNOGtJdktTQkRYMXpYL2lsNENmN1JJVWlaejlyWDdmYy9y?=
 =?utf-8?Q?q7a1DbqejkIiXuK5OS61e3MXS?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fd49481-b854-40ad-cc29-08daf27f03ca
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2023 20:20:56.6611 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BPF2Qj+dLkLk9Iq4nHnZjvQoHetrqyQMTiznhSrBwD2ZczF0y2dG4VbazUONFHxboX/xdxO7m7IMgK74xfw9dw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5056
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

Am 2023-01-09 um 14:27 schrieb Eric Huang:
> There will be data corruption on vram allocated by svm
> if initialization is not being done. Adding sync is to
> resolve this issue.
>
> Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>

The description is a bit misleading. The problem is not that the 
initialization is not being done. It is being done as a result of 
setting AMDGPU_GEM_CREATE_VRAM_CLEARED. The problem is that the 
initialization is not complete yet, so it can corrupt data written by 
the application unless we wait for it to finish first.

Other than that the patch is

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 7 +++++++
>   1 file changed, 7 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index b8c9753a4818..344e20306635 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -574,6 +574,13 @@ svm_range_vram_node_new(struct amdgpu_device *adev, struct svm_range *prange,
>   		goto reserve_bo_failed;
>   	}
>   
> +	r = amdgpu_bo_sync_wait(bo, AMDGPU_FENCE_OWNER_KFD, false);
> +	if (r) {
> +		pr_debug("failed %d to sync bo\n", r);
> +		amdgpu_bo_unreserve(bo);
> +		goto reserve_bo_failed;
> +	}
> +
>   	r = dma_resv_reserve_fences(amdkcl_ttm_resvp(&bo->tbo), 1);
>   	if (r) {
>   		pr_debug("failed %d to reserve bo\n", r);
