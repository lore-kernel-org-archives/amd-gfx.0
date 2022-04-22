Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04750C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Apr 2022 22:01:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5CC2810ECD9;
	Fri, 22 Apr 2022 22:01:30 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2084.outbound.protection.outlook.com [40.107.243.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E8D110ECD7
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Apr 2022 22:01:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kx+pHFF4HWITtcEuA4qS8+Gtf+k2V1Kv2fmM+9WpXB62jvsoK+iEDCSaOHEGk/zGSl8ue/L09T7N98nGvnKjraYbRTzKcsWxTgdEb71b+zXXCVKn4GmhctHjlCiUeBP57o0ko0/kN4pLwyZ8cYQwPkTi0dboLWihPjX06lTJTb93M0F8ao4pHjr6PnNTtpKFCNGF4mu3A+qPFQJEzJV7hvI/Um0+4aJBPbyJvwfe3FSzV5/UGkSudHDTguvNtHtzx7BWskUtn3l93X2kYotjok6yKfZ152B0Z8oggi5d5LAoV9FvpNskGVeAg+J+wAPpjizsZZHcu4Ct/DzDS+iHYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ueAjJVEQRh9WR3LN6prltxnBhYrl7RzB9ObDpy+0dA4=;
 b=ExxkJ/GZ7C/S1H8vx8aj5+d0YsjJ9Jb5hXrG0hjYjq29ujyvadYr/ztQWA7WOAjaJ+XoM+mwzFVGaJsNZ2mjDtpyel5yIQG0IeyzBM8MCvctsXgKJ9LFKkz97VzLZ/Un9mqPfEIDb+dZuH1Tup2uND3xzhKK9o4IfC+oBIMMW3zEvGx76h79LZmWNknYNafBj98Upt8/94N15rrZUda7rmWB4dna6x65KtL4lzg/wqjd0DnTBI8W6b8R0qXrr0sxy8W8ervdNrHw5D0wPNNm87aYTpJ3H8dhI5WUrCD00GlFc5OPhCUgULlrmJEcgnPzRpUf2LLfxzpabm9J6hF7VA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ueAjJVEQRh9WR3LN6prltxnBhYrl7RzB9ObDpy+0dA4=;
 b=JQA1tICg3AXYftPidQjKHUw28LfcuMzSGApZN00JB8I/YPRqVYR5WZ3wKvn+kPcqCo6xdq5i1AjX6iDjwtd+2zFNljz50ZiSaMSctDbiLapgEG8WyHW482664NiHcSoJK8C3vGLO1wyUk0Njmndq+lWYmRbSijjaGYUL14GAC2g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by CY4PR12MB1448.namprd12.prod.outlook.com (2603:10b6:910:f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Fri, 22 Apr
 2022 22:01:27 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::6070:7681:db0e:7702]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::6070:7681:db0e:7702%9]) with mapi id 15.20.5186.015; Fri, 22 Apr 2022
 22:01:27 +0000
Message-ID: <503a936a-b08a-f75c-b577-a87e0a2918e2@amd.com>
Date: Fri, 22 Apr 2022 18:01:25 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] drm/amdgpu: replace VM fault error by info logs
Content-Language: en-US
To: amd-gfx@lists.freedesktop.org,
 "Sierra Guiza, Alejandro (Alex)" <Alex.Sierra@amd.com>
References: <20220422211553.1240-1-alex.sierra@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20220422211553.1240-1-alex.sierra@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR05CA0055.namprd05.prod.outlook.com
 (2603:10b6:208:236::24) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b44069c9-b028-4c44-7429-08da24aba617
X-MS-TrafficTypeDiagnostic: CY4PR12MB1448:EE_
X-Microsoft-Antispam-PRVS: <CY4PR12MB144810FD4EB7643CB619A23892F79@CY4PR12MB1448.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hyPkp7RMXlzgKlJVBoJtQQoDnDseKvGxmi2936GcY5e2oQ21NyXhL1tloLb/he46rahRYKhj1TgIm6txvapp1Pbyio8XOtL+sUva29h+HyJRTqbmBUnGdRcufSH4UmVzqyDbQ0I1hIUFrJYOi3xFuGtgvDQhgrnmU2m7xF4qlbyoloVdsuidDql5UBbAGxpokvcPcOUjtYlO5sAlX+u8X7V9L681yPPx6RrAIZL2kkuezgM+JwmEqpGLhw6Ks/uxya5w8BHNhfGq0tlO3AdXn2K4/4sBnyBHVntg44JWdPy091QLyu3qs1bBdjoAFNCvBX8qMrhxkopLjSclEmfsUTd56FWsjgnJjYcQQjNur9qi+dS8VHgUy7U6Q1NWMANS3CNpHXlHGun3F+hdFk2p+88CKJS1ww82Go+WJ/nnUlVCO9fFGx0K4J5UVl/Y6qh5WSeMBMr1WSmR3RZiy0hoQCk/tMfj/v/58o+Ke+kafwWjm4OS+Cw4BqMRGFgqojOS8XHfRmNrKeQlaUvKwSVmYbdg0KucS12iBJS6Mfu/m/XGSmA0xnHwVV9BEBgokIdWipjRlT3W9bAwb/0dyDF/aKU9qpPkQozm1HYEvyuZ5C8THLkKv0SpaMdPoSQF5FE7qzRT5u+So/mhBBvsakNRb5HV0jlnNEXWatxmwrYi+8iWvCuEeQyI+KmhwJgYHucUS5pRZdCf2XMrDHvSYL134W62n53bQ3IeZM3M850IfTmSxFY9hOk2bXFdiaOQOjEM
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(6512007)(508600001)(8676002)(6506007)(186003)(5660300002)(6862004)(36756003)(2906002)(44832011)(8936002)(86362001)(83380400001)(2616005)(36916002)(66476007)(66946007)(66556008)(26005)(6486002)(31696002)(53546011)(6636002)(38100700002)(31686004)(316002)(37006003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SFN0bS9WMGxhdk42enZaQS9yLzdLRDhBZkRuaFNiMjJyYnNabUtSZnFkeEpz?=
 =?utf-8?B?Zmh4KzJ6S0N1K3VlRFNLSUw5NHZvbWNjdU04WXJWNDh5M2drS0dyY1VoaEVi?=
 =?utf-8?B?NDNuNXVEU0FNYjNwbUs5NU9oTE5QSTEzWWhRMzR3T0o2TGJoVkZMTEpqb01j?=
 =?utf-8?B?amNmN0h0TDAyeFNZem5vTGdNQldKbzBSbGk3Q0ZPRG5Idk5IeWt1NnRGZ3Zx?=
 =?utf-8?B?UHg3M2VGRW5pSEhWWmFoSlRzbFBvRWJISy9pbFFlK0NXdEduaUJyQnJFUWZJ?=
 =?utf-8?B?ZW93NU00S1hNNE95QVZod0dUcW81K21LYjlxYnNPS0gzVGljTWFVaFRpV3VH?=
 =?utf-8?B?dGlma0F4UEVWRGdoSkplT25MQVhvSXQ3NHIvMWpiSks3VXpYS2Y3WkVwVmdU?=
 =?utf-8?B?dWRDYWIwclBoNis2NGFNbUZUSGpYc0hlSjZFcnlJSlRrWEs1ejNqbGhwOUlR?=
 =?utf-8?B?aU8yNERMV1RGZHFxYW1NcWNQMnpYSlpNVXZFSXorbFBPcEdrakx5WGtRTlNt?=
 =?utf-8?B?UlBMQnMzSGl6UFdDN2krVW5SSnp4cVB4MlBnY2hmR21zcWdnRzNGNUdSOEtP?=
 =?utf-8?B?czRFV21xTEZxMjNYbWx4T1VFVkdNYUIxQTlNM0hCSCtJNW43eVVXN2VIdE04?=
 =?utf-8?B?QVZjS3YxWlJ1RFZwRWN4YTdmVnJxbnJEMExjVkJ0OXdiV09ZWkFIczhaeEVP?=
 =?utf-8?B?cUwreVJKRUN0VFpSUjdON1JqeUdKUHY4elUxQ2Vla2tBUzZCT0ZZZjJaZ2hH?=
 =?utf-8?B?dFd3dDVVbTB3SnVIVksxUFdtR3JpYk5xRU1STDFrWE16c3VBY3Z1bmNxTXN4?=
 =?utf-8?B?WURhV0pyWTkrUUhHUzlrNC9ZYmhEazhOUWNXcnRMNjVQYlVpaW5MeXZlV3dL?=
 =?utf-8?B?RHpwNWhKSi80VURPQ29xK3pVOER0N3oxbWNVWUlCQXk5SHgxU1R6cS95Mk5O?=
 =?utf-8?B?aUV5V3hkSU5tV2Z6T0JMUmNqbEVFTkxwaHBwTFF0dEQrVjE0UVFyanJiOFlD?=
 =?utf-8?B?RlhkZWxWR3AxOS8xWDVmMGR6YXMrZzBBd2JTVUhJK2ZrUnhIUldqVmdWcEtK?=
 =?utf-8?B?ME0vbkpITXZnSzR2ejhWWDhuVmlYK055eUV5RlFUb3BEaDd2MmJzeWNsRXEx?=
 =?utf-8?B?ZHpMSVkxRHovSGNEZmFYKzZTU1lJaS90V1NFSXhTWFdLYjlzdEdESWVRSmcz?=
 =?utf-8?B?SVlWUmI0cm1EVytoRDFQZVMveFlmVm0zand1bWRlamljeUVtQmF0QjdpSHNY?=
 =?utf-8?B?YktRa2pLa0tTZHlpV2Z6aUFEZjdpVjNjTVhuaFQvY0Q2WnFEMkhxRHQ2aGRq?=
 =?utf-8?B?TFM3S051RXI1Ym1DS0VRYkhvT1BEU3lhcEJpbXZqYW43TTVESjdpOUJMN0tq?=
 =?utf-8?B?M1k3Y1VhSEFpWi9uY29xMEhlUHZMVjNUaTRKNFVGb201cElmVEFoSWpFRkQz?=
 =?utf-8?B?aTVJaU9Cem1GcU5Jaklhb2l4R2wrZ1ZDYXEzbVI1eUhBdzhGNk1INnNjZlkw?=
 =?utf-8?B?SC95aGR0OGYxWFlTdVVYWlROamhNbjFSZ28xN3RPNlJuZ09oSWhKZHZZbUsy?=
 =?utf-8?B?cFpxdk1pVjZVWlZIeXhHWnlYVmlIT293QzEzeHc2RFdVNWRGRW9tVytEYldP?=
 =?utf-8?B?b0cwTkd1S3o1YkhxMm5teTJQUEpVeFA5MHJaM3kyV1B4M0ZmSjhNMlpVZ0hw?=
 =?utf-8?B?cGM2WmF3NDVaYVB1ZFJ5VDJZMHBOM3NMbXVHMFMwelNscXBlYWZyaUtHekls?=
 =?utf-8?B?cXVQejhoNFkxSU1DQXd2VGpFZTNSb2Y0eGJpREVwdDlPNUhmYTVpOEJLR1Ux?=
 =?utf-8?B?ZDhLVEpEeFA5d2ltbjlxUUFHbmRIZHdlbEpFL3BnMnAzZjcrZDE3QU8vQVhn?=
 =?utf-8?B?QXhJUGE4VkVuU3JSVFAvMTdZUGF1U2EzUmRKeGlIL1FmK3YvWWpvLzl4SW9D?=
 =?utf-8?B?UkxabHUzTmRPZGVEdXNOVWU1WVlueXZOZEFrc1NkMEhGUlg0SWVtRUhncUFq?=
 =?utf-8?B?TVdJeldMbHZOOURRdDI2dEVXb0RCTG83SW4xcHhmcXdNblhBdHkrK0x2Q21s?=
 =?utf-8?B?WEJaQ2tFMDF1MkJxQmh0SHBQQURxNStySWJqSk9GRHg3UHgvQzNXeVZNWkxV?=
 =?utf-8?B?cDJMNjgwbXVzeDFtTDRRSnhoSHkwcE82YXhlMndwa0RHUGlMQ01jV3dRNXR0?=
 =?utf-8?B?aURvbUxmUDdOVHgzRTV6ZGk4d2NCUllSU2U1ZEErc3RIYUZlclJpTWZLSklU?=
 =?utf-8?B?N2l2YmVnMUJZb2psR0RCdWFvOUVaNGRmVnFwd3hFb3FTNHZ5bkFDU3B1aHhV?=
 =?utf-8?B?cXhIQTBETTlYNmJ6RWFjWXhJZTM0NVlISFBCbG41ZFh2NW9oNWhlZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b44069c9-b028-4c44-7429-08da24aba617
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2022 22:01:27.4222 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lF9WuQEulddUH+w7myXVXnkcEgoTcANIvoId7oFTRa1AkWoPr2DSzPJNKeeYm5zNQiOnPkQIWW3udFUIIw+smg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1448
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

On 2022-04-22 17:15, Alex Sierra wrote:
> This is not a kernel error. These logs are caused by VM faults that
> could not be handled. Typically, generated by user mode applications.
>
> Signed-off-by: Alex Sierra <alex.sierra@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 20 ++++++++++----------

Please update the other GMC versions as well to keep things consistent.

Regards,
   Felix


>   1 file changed, 10 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> index 22761a3bb818..98c8de7307be 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> @@ -582,14 +582,14 @@ static int gmc_v9_0_process_interrupt(struct amdgpu_device *adev,
>   	memset(&task_info, 0, sizeof(struct amdgpu_task_info));
>   	amdgpu_vm_get_task_info(adev, entry->pasid, &task_info);
>   
> -	dev_err(adev->dev,
> +	dev_info(adev->dev,
>   		"[%s] %s page fault (src_id:%u ring:%u vmid:%u "
>   		"pasid:%u, for process %s pid %d thread %s pid %d)\n",
>   		hub_name, retry_fault ? "retry" : "no-retry",
>   		entry->src_id, entry->ring_id, entry->vmid,
>   		entry->pasid, task_info.process_name, task_info.tgid,
>   		task_info.task_name, task_info.pid);
> -	dev_err(adev->dev, "  in page starting at address 0x%016llx from IH client 0x%x (%s)\n",
> +	dev_info(adev->dev, "  in page starting at address 0x%016llx from IH client 0x%x (%s)\n",
>   		addr, entry->client_id,
>   		soc15_ih_clientid_name[entry->client_id]);
>   
> @@ -611,11 +611,11 @@ static int gmc_v9_0_process_interrupt(struct amdgpu_device *adev,
>   	WREG32_P(hub->vm_l2_pro_fault_cntl, 1, ~1);
>   
>   
> -	dev_err(adev->dev,
> +	dev_info(adev->dev,
>   		"VM_L2_PROTECTION_FAULT_STATUS:0x%08X\n",
>   		status);
>   	if (hub == &adev->vmhub[AMDGPU_GFXHUB_0]) {
> -		dev_err(adev->dev, "\t Faulty UTCL2 client ID: %s (0x%x)\n",
> +		dev_info(adev->dev, "\t Faulty UTCL2 client ID: %s (0x%x)\n",
>   			cid >= ARRAY_SIZE(gfxhub_client_ids) ? "unknown" :
>   			gfxhub_client_ids[cid],
>   			cid);
> @@ -648,22 +648,22 @@ static int gmc_v9_0_process_interrupt(struct amdgpu_device *adev,
>   			mmhub_cid = NULL;
>   			break;
>   		}
> -		dev_err(adev->dev, "\t Faulty UTCL2 client ID: %s (0x%x)\n",
> +		dev_info(adev->dev, "\t Faulty UTCL2 client ID: %s (0x%x)\n",
>   			mmhub_cid ? mmhub_cid : "unknown", cid);
>   	}
> -	dev_err(adev->dev, "\t MORE_FAULTS: 0x%lx\n",
> +	dev_info(adev->dev, "\t MORE_FAULTS: 0x%lx\n",
>   		REG_GET_FIELD(status,
>   		VM_L2_PROTECTION_FAULT_STATUS, MORE_FAULTS));
> -	dev_err(adev->dev, "\t WALKER_ERROR: 0x%lx\n",
> +	dev_info(adev->dev, "\t WALKER_ERROR: 0x%lx\n",
>   		REG_GET_FIELD(status,
>   		VM_L2_PROTECTION_FAULT_STATUS, WALKER_ERROR));
> -	dev_err(adev->dev, "\t PERMISSION_FAULTS: 0x%lx\n",
> +	dev_info(adev->dev, "\t PERMISSION_FAULTS: 0x%lx\n",
>   		REG_GET_FIELD(status,
>   		VM_L2_PROTECTION_FAULT_STATUS, PERMISSION_FAULTS));
> -	dev_err(adev->dev, "\t MAPPING_ERROR: 0x%lx\n",
> +	dev_info(adev->dev, "\t MAPPING_ERROR: 0x%lx\n",
>   		REG_GET_FIELD(status,
>   		VM_L2_PROTECTION_FAULT_STATUS, MAPPING_ERROR));
> -	dev_err(adev->dev, "\t RW: 0x%x\n", rw);
> +	dev_info(adev->dev, "\t RW: 0x%x\n", rw);
>   	return 0;
>   }
>   
