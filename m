Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E30D7C7618D
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Apr 2023 14:36:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8A08410EC08;
	Thu,  6 Apr 2023 14:36:35 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2080.outbound.protection.outlook.com [40.107.244.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5132C10EC0A
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Apr 2023 14:36:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SsmqtMSIxFDwP2paciTmcPifPeZccjIMMUngjMeI4P/hZ7Rqly2/xaZzwIhm6y8cpvFlp9FQLPr1Qp4HfitJz56fKr43GfDJZXDMB0kiRp7xxA/gUFxQuUibcQPFxeOyhOLqS5yO2fSp9vDwVE0CiHxlAz+5YKai3g5KJImjWuBy+Jgv+eU1DZF0m75eYSQS7Wro1AZnIn9zeydrFh6Z/pBkxiLhFuR4k9JXAy02luuAVoSmztTAI9j2Crd64FHpb2IYhRz0910ApITVjgzmxoNh9bi1D2SosQwgrSIJLENfyTBxAbAEc7CnjWCt8YyneuMaZDx0D4tszPxnlW8dmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pBX24aWCUmBUZ9IELc1uPgVOlE8MOs0VlnS0iYhY120=;
 b=YPkPgzTVWRCCse26bAk+A5i1zb8m1f7+cnWv9awu1RhuEGQjCfPjCqEfujettqn1o8cb/2edi0A7aFdAvUpKnMd3AjmNL0DL8t+CgvdiG2t2Ch2Dcf26FPfMrQpBl2r+WPRk6x4N7GNCQlhY12GQwKByfNMj9ta2+/YWp852e538KWLxNlnFG3mRt68u2uWrpn+5aoV1rxuY2I62lSmeMPS2Pi4b6IQrvgBMKUTKQMlaLIK1c0KFFTgDX0HAZz5kbwVdSSnau+L0MzZ+RYsEkxPcFqc3pQTbd+zwsHIDRnJEryON36paPrbhcQ5u/owwapyhwS7+9C7hKry3y2SPqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pBX24aWCUmBUZ9IELc1uPgVOlE8MOs0VlnS0iYhY120=;
 b=lWc3Lxto+n8B/S86TM9MTBlcE5y6sb4tJ0eOEof0WGRYIW1Ca5sjJ8zBztuLByxwIjan4VUZG0gFL/WSOax7bL92TzGVQeSCm7S9o1df3nLqj6lGJJT9G5yXMm3zH1eyd/CD/HLNo7rvFGcu5gC9oqW9WLy/9MxB+ZQkoVy6oGc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by PH0PR12MB8174.namprd12.prod.outlook.com (2603:10b6:510:298::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.35; Thu, 6 Apr
 2023 14:36:31 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::4624:dc39:943e:6ae]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::4624:dc39:943e:6ae%5]) with mapi id 15.20.6254.035; Thu, 6 Apr 2023
 14:36:31 +0000
Message-ID: <67923897-fef1-1b6b-75d6-0a33922e0132@amd.com>
Date: Thu, 6 Apr 2023 16:36:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] drm/amdgpu: Update invalid PTE flag setting
Content-Language: en-US
To: Mukul Joshi <mukul.joshi@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230404215923.3739152-1-mukul.joshi@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <20230404215923.3739152-1-mukul.joshi@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0139.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:95::13) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|PH0PR12MB8174:EE_
X-MS-Office365-Filtering-Correlation-Id: d8ef95f4-1872-49e1-f629-08db36ac4ffe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1S8G926jrev0GRke3fYubKOP91JCFl8UT2IA8CzTtweyvqs44fd1iQcTm9C59tQKIZ76Qqb76VZ7xQ/yeQLwoppOlup1Di/wDvOlqxBVmZA4l8iog1943KLVHIPnZ4xnev5HhlAMZ8qkOUvxtYEux5jiEm59FbTJqXsdxYCHyNGnykGpVodV2AC5CEOgiDYDowuA/VNeHz9h93Zi7yrt0n82+Nos+FrLaPYKHyVbVRRp8QTAGrrlEJJcQSFoCpJpHy+2742fWq2ayQCkEOB/x/3IICnLN+1RpDuS8bh3Yw2EqhSjgrvYFIgfHxriF5exNZ5ESDjwGjp00/Nt8+KrLJUxjNmk19EmHW6enPc42thuUy7UC0nv7Rq7ZxbflcinlD1g+1j9QRZAMBU/iq5/nDZXagy9Q8uG9ussl3WdUk+7kQWxKY+/h6dNc6rXuknLhuYU0bCdWqo9SITBU7wa/60hujQ6sOWxvcsIUBJJu0vNtiJom0qfdcmjcaeq/N+Cv/xdenjkFWuIHLVJfRPALokpY9vUCmuecm8C4xd5jPVOoKI7++OEeeN/8YzOVp6C1ScvZEdprRt6+Sio0xkXKpWR/VyUQGp1eKBLVZEuJCW3seQvJrsxIBScXVK6jP5ec2RpMcQATOO1NCYmtGRvuw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(376002)(136003)(346002)(366004)(39860400002)(451199021)(38100700002)(186003)(8936002)(2906002)(2616005)(5660300002)(15650500001)(6512007)(31686004)(6506007)(41300700001)(8676002)(66556008)(66476007)(6486002)(66946007)(316002)(86362001)(31696002)(478600001)(4326008)(6666004)(36756003)(83380400001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TWNVaUsvYUlnZXRPYVR3dFMzN3NJdWxuVnFvZjY0bEdmNmJwYUtKODZyN1hV?=
 =?utf-8?B?aVhldU5NMk5WWnlBY1hETTQ4cU9samp6U3RnWncxd054RGx1ZmxERkhsQUlr?=
 =?utf-8?B?dHF6bVgzL1g5V0pENVZod1VjUGRCWW5WaW9QcTY5dnZWWWhvZ08xamM5Rnps?=
 =?utf-8?B?N0lzOWFJRXR4bHZzblhoODFHbjZhWWhiRERaUXY1QTRyNVlZanZOSDg2M21n?=
 =?utf-8?B?NXZxQkpsaFhzdHJlUThWcm00RVVEMmtWQWVDWnFzaVNBUTdLYjFxeVpiWm9N?=
 =?utf-8?B?VnZQQ1YrMTdlWllVbjFDM1BVbnlndWhzWDRRNVhZVlZFVVp2QUlVSjRKUWlX?=
 =?utf-8?B?SllxZ0hVcDhTUEsyakY1UGdXNDNwUmhleHFIQmVadE5LL1VITXQ5NDdsZ2Ry?=
 =?utf-8?B?bmlWclNzVlJvektvekhkL2tUYTZDdHFRajdsT0F5WExHaGNyajlKQklwL3dV?=
 =?utf-8?B?SXhnKytYSHhvK1dpZXVsVE5Sd0hGUGVKZlI1bmZrOVR5UmpFWlZPaU5lcUFy?=
 =?utf-8?B?QjJBZUhkeHFXNERBOWNpc2ZSbHkycUg3NUJXelJCVnFHRWRCTnBOcGlteHp5?=
 =?utf-8?B?TVZHMkNSdjR3dFVwclhzaVVqbWF2SzFzRk1vV0lDV1RKMVc2VmFVaEIxTnpZ?=
 =?utf-8?B?WXkzc3dUWEYzb29UMzVIeW8vSUpBWEQ1YXJ0MFd1L1RhT09SWnZRY2lGcllL?=
 =?utf-8?B?Mk9EUnFrTEx2ZmtCSmVKMkVSVTdiQWxzdWNiMlV6NlpJc1JXYy9xNmpDT25p?=
 =?utf-8?B?YVNmelU0K1YrdEZhd1BIdnNreTVtS251d0E1d0VvcVhkMUVLV0ErSHhnd3ZX?=
 =?utf-8?B?bVdkTWRPeDlhVGpMK2tBWGR3Z2hzazFxK2VHMldvanM1bUFVajRSenh6d1dz?=
 =?utf-8?B?R0sxRGk2NXJFUE55QlVkUDFnTjJOb2c4R0pJbGxEQzhrMGdFYzVENEhwRUl4?=
 =?utf-8?B?Vm1JSVMxZ3RQOVh4L2toREJNZWtlYXpvRHNFRXVMRHNHeEJCbm45cHdOdWs0?=
 =?utf-8?B?b2pMYkpabUJQUjJ3U1BvcTlHOURBblczU05vczFFVnlKNzBGQUtTQTJ6MW5i?=
 =?utf-8?B?K3ZlMkoxNnVRT1o5MFhEMkROTldDaEIrL3BpaHp2NVhnOEtNMWtRWTFwOU96?=
 =?utf-8?B?cUVBc0M3QzB2OUxTbEJjZnp3UnpoOVBiVVhTRlQvMDdrVHFkeXRic3NoNE0x?=
 =?utf-8?B?U24vL3RpRUhGTEVqZDdRb2FwZXRsbGJ1cE44cEx5R04raG9Rak5jaGI4ZXE4?=
 =?utf-8?B?SVZ6L2ZKdFJsSWRzQkFxNVEzYTBSNVlRRWQ3dEFCMHZXQ3BFd25Fd1pIVzBJ?=
 =?utf-8?B?K1NScWU5N0cvcTJ4QXhORFFJMWZhR2toeVlVZktXcWJPUGNXOHV3SncwaE44?=
 =?utf-8?B?SjVOV1cxVTZqWHpraUpJZlhwU3Q3Q3JkeEtMTkFjNDRBdnVnd2w3Wmt6U2ZD?=
 =?utf-8?B?RjZSd0hhMDdxZWIxbVFiSFN4ZGozNzlZZzdicWx1RENIUnJDUlZlVGpZWlhl?=
 =?utf-8?B?WGFYMGFqUUtSUm83ZGFZSGhpY1E5M1VEdFNUN1NkKzB0NXdVSVRJSW4zUWJ2?=
 =?utf-8?B?dXZEYTNWUUFnalpicDBIdExCdDBDY3U5L1ljT05xSlRyOFYya2Z5YjEyY1lx?=
 =?utf-8?B?UW1wL2RwSnlVLzlvQmQrYyt4ZFd4YU1ra2xOUXF6YnU2cTlXZW1SSWE0MlAz?=
 =?utf-8?B?RWNFdWlaOEVLZmZTR3luS0NFTTJJZWg1L1ZvMU52Rzdma3lzeHpCUmNWRTJW?=
 =?utf-8?B?WDdRYnp2M2RXR2NzV0hBRjhYWjhrUndOVVFGR3lDblcrNzQ2ZUMrQXFINnJD?=
 =?utf-8?B?L3pvK1Z6ZVhVelNrOUZqSFl3dm04VWxFbkhYL0lLK0RLM291QWhpSzZYNmhQ?=
 =?utf-8?B?Y2toVUs5SndVUVNGUFlqeHROd3ovYTlxYng4R0R5VCtqeXN5SjlPNUhKclIr?=
 =?utf-8?B?N011NlFRSnlYSXloSmxUYmpkRXcwSmhNWjRpUzZ3blRiM01zd2hyMGRxclht?=
 =?utf-8?B?cDdXTlZkTnd2eWgycFd2RU1iaW5hMDRNRnlyejdOMFdhU09pOWJ0MWV0WHJC?=
 =?utf-8?B?bGpWRWV6bElIUlNQeFZHRXYySTh4QjYydjN0S2hJZUVjUUY0RkpuQS9sLzQv?=
 =?utf-8?B?bG12bTJSQmgxeE5KOU9oTGpJR0pkZWpCZGU3ci9JZ3lGMVgwSDZjL2Z4ZVBX?=
 =?utf-8?Q?fRJlQEQOy26wI7GVP0WZgL7xd4u1NdvACV1yYPjRMTof?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8ef95f4-1872-49e1-f629-08db36ac4ffe
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2023 14:36:30.9885 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 79kMV51rnmWWvXxLPLOJbi1szRVTRkcRYnuUfBWM9lwJZO8f6uAprALVi0RvILBx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8174
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
Cc: Felix.Kuehling@amd.com, jay.cornwall@amd.com, laurent.morichetti@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 04.04.23 um 23:59 schrieb Mukul Joshi:
> Update the invalid PTE flag setting to ensure, in addition
> to transitioning the retry fault to a no-retry fault, it
> also causes the wavefront to enter the trap handler. With the
> current setting, it only transitions to a no-retry fault.

Well that was actually the intended result. Why should it enter the trap 
handler here?

>
> Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index af6f26a97fc5..5df4f7bb241f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -2488,7 +2488,7 @@ bool amdgpu_vm_handle_fault(struct amdgpu_device *adev, u32 pasid,
>   		/* Intentionally setting invalid PTE flag
>   		 * combination to force a no-retry-fault
>   		 */
> -		flags = AMDGPU_PTE_SNOOPED | AMDGPU_PTE_PRT;
> +		flags = AMDGPU_PTE_VALID | AMDGPU_PTE_SYSTEM | AMDGPU_PTE_PRT;

As far as I can see this is actually a valid combination and would not 
have the desired result.

Regards,
Christian.

>   		value = 0;
>   	} else if (amdgpu_vm_fault_stop == AMDGPU_VM_FAULT_STOP_NEVER) {
>   		/* Redirect the access to the dummy page */

