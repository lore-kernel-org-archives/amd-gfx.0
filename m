Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2904DC3601E
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Apr 2025 08:11:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8179210E2AE;
	Thu, 10 Apr 2025 08:11:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QcZcVVt3";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2067.outbound.protection.outlook.com [40.107.244.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5290710E2AE
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Apr 2025 08:11:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gCkAurrmpm36HXaQUjReYWL9oWrvz2Jr6MdWSsuzn1xXspm+PP646ZJG9BnDN06HQ1mIzv33aDCojeiic0z+lsLrtIA5WEZm4WN9Y6AFu4kMhwDO4ZnJkcW3ukfmrDXfwnl3stj0Frq2k4eVOI2+F4mFbzcxVZLBtJFGwOww59ltj8qgOTYa9D02z79S9JKJrG0tlvTaqVuTPhYU9Jh4QhweWNCmqj8qlHPPdnrzd/m+a99RhomP5cuQIcFMT9n1MSGz49BYX9xClJRK45mHKoFF7kSkpuROorr9ApEzFOXBdL4oCyukYoA969K5AC2jaUIod2Jo5+jyaXF+kH0aVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5ngOMgmMXsZNrCUQRtdpe2qR/nVD1zNFetkOcwgTFdU=;
 b=NM865Lzg69Il3QEzaU81I6FtfehB5sNa+m6vCCPH/Au+lJGVHih2Q8+C/3sa2kxKrLurLIEMIBNlnoYXYtx8JwzNegUDmwzfw7TgURDkJRZssl4xpQAZppuY1CcpqcHzqDRKy08radlKzYaMiLIGQr9sF0Vgv6qwURyDekslKO0RrLFt421RKW+MUGk524KFKCfjH5eO8+TAsq1upqeBiLfmc0Yz/t7orpx4PYRCDUiyR2b1JzkWHrIxO1vhr9zKkn3PHtfg6DzjVzh1Ez6ogeP5swn9R+B+L/mqtvFRrX0sbMVLjiEFVN+nVkdtV1XUFE2UZu28TQ3miaZNMAhkvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5ngOMgmMXsZNrCUQRtdpe2qR/nVD1zNFetkOcwgTFdU=;
 b=QcZcVVt3c8iR8IWTVbFyB8Y9iDChmSuqbzwN2nWe0TRbNdRrRTNfZMFWc4sVvFNDwEWfGch6yEU6v3JJ0tZnjA2ML/lwfF0/86gAl5sdfG5xc8SsEyOJe1tUL8vT4491SMN3ajtM4b+QOQ2u8kjpoDmlI8vYYm0FVmsOS7g443Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 IA1PR12MB8407.namprd12.prod.outlook.com (2603:10b6:208:3d9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.22; Thu, 10 Apr
 2025 08:11:17 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%5]) with mapi id 15.20.8606.029; Thu, 10 Apr 2025
 08:11:17 +0000
Message-ID: <bd7fbf90-b541-4acf-9b8f-fdf633766749@amd.com>
Date: Thu, 10 Apr 2025 13:41:11 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] drm/amdgpu: fix a smatch static checker warning in
 amdgpu_pci_slot_reset
To: Ce Sun <cesun102@amd.com>, amd-gfx@lists.freedesktop.org
Cc: dan.carpenter@linaro.org
References: <cover.1744200284.git.cesun102@amd.com>
 <464215422a8b934b9280fac884f6f389b64fca05.1744200284.git.cesun102@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <464215422a8b934b9280fac884f6f389b64fca05.1744200284.git.cesun102@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4P287CA0069.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:267::15) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|IA1PR12MB8407:EE_
X-MS-Office365-Filtering-Correlation-Id: 59fdef42-cc4b-47ad-f2d9-08dd780744dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NWJhVDJqajVWc2EyUFBDNmpoTVdzZlMwN3BjQ3pxdW9yVlRFNTRxUGdWeEF1?=
 =?utf-8?B?MTNUU1BwNXBYYnNBK3k0TXk1SWttM1ZlR3hEYTY5WGh5RTNwVEhWc3R1UW8v?=
 =?utf-8?B?NVAzeWVLT2xoUFhZc09QWFdnZ1JjQnVoR0JZQmpIa1l2Qlk1UGY1R2sxaWor?=
 =?utf-8?B?RWV4SjJONFY3akhLTHdENWdDMGFRWjdvNkhncDhzbzN1ejVDRVhPY0hjTzlk?=
 =?utf-8?B?cEc0djFLbyt1ZjdRWjNoWFNEc3dTS01GS2RQY0tkZGZGeUpLSEJUd2xkdGwx?=
 =?utf-8?B?Z0t2Y1MrRkxBdnBGVDFzZ1ZZWCtDaXlrVnRTaFpGM3UxSTlmekRtYVNxWTlQ?=
 =?utf-8?B?eGFGa3hLNFBMV0FwQ1RXUDkwZ0NoQjVtS3NIdlpuZGpGZFhKUFBub3dhRGpt?=
 =?utf-8?B?TlB5ai9nYXlsVWRrbkFuOU0vUm5OOHRPYUJYWG05SXdEOENjQXNCWklsc1pQ?=
 =?utf-8?B?TjlsdGRnVlZHbXV4UXJDLzFqaDUvcDRlaXZUSEpnWEpiTlNGWUp6OWY4aFZk?=
 =?utf-8?B?cmRxdjNHWkFHYnkySTZJTFAvRERDN3hHMzFhM2hHVnFVck9FMGdNb1EzWFhX?=
 =?utf-8?B?Qzk2UkZUMVFia01NWWNXUXhGNHo4eDdVY2pQcHNyNnVQbi9JN05HRjVPdlp2?=
 =?utf-8?B?S3NodHhmUDYwWERrWDF5WHQ3em41Q05KaHZFbDB6R0E1N0VXU2JCWGFiT2lP?=
 =?utf-8?B?M0diUXp4SkU1MTN4a0Fzdjc1eVZ1aFNNTmg3bkNVNlpBMWh6ZXpsY2c2Zkk1?=
 =?utf-8?B?eHI4dkRSalc1NFpBaUgvbFNMemZMOFJjRlRHV0FzVkR6R2ZzakZSYXk2NHF6?=
 =?utf-8?B?YWRZUXNwYUQ0dGJqbEdtT29WVmMxa2xxMUwxc2ZVUFBDQTduSTlqT2JlV3Qz?=
 =?utf-8?B?OGYwMDdmbFRocG5VczdqNHdMVzR0OWIzTm13aFhyd0w4ZitSckhTZzQ2alUy?=
 =?utf-8?B?WFpFL1FmWGpHQUcwU3BwOG1TQVp5WDQydy9iL25FeWVna0hmTmNvNFpJOU9J?=
 =?utf-8?B?UHBhK2I1Y2tsMjlPcGl0cldTblU4NXVBOFVzV0YvQjd4SjhhendHM0t0cFFH?=
 =?utf-8?B?SnhIRTh1eGMwOFVUcUUvT2JHcTBqQTIxVExkTWJWL0dod0k1QXZNYzM5dzlT?=
 =?utf-8?B?Sng2NjVtcXg2ckRtZjVWL1lIZlZybGxYSkZXSjk4cC9uUTNyaGpWQzZlVzd6?=
 =?utf-8?B?bEVlTjlaTlg2U0pjNWwrMHp0TURVSkZFa3AzcWtuSHc0Q09iTDRueEFKb2VT?=
 =?utf-8?B?bzZ3TlpGYUpMbVZ0Ylh6WE1ydzFzNE9MRDljV3NkMWlLNllRQkNWeXFQY0oy?=
 =?utf-8?B?OWpLZ3IwdHhDKzNkNGliQXpOc0NaV2lBSEFpZjF5YklOUDdvdTFwNkRQWjVV?=
 =?utf-8?B?Zy9TR0ZFN0hJMER4VEU2b2lDNkJjeGpvRkRRQ2pneXhIQW4vd0lVdEFGa2Nk?=
 =?utf-8?B?cUtoZHdYVU43UXpFMG5SMFI2eHh4RUVmYmJMMzhDTTZBZ3NySGNmRkRzMWpj?=
 =?utf-8?B?MTBjUmxxM3FBN3hsS0g5VXZRSzc5Sm1va1VQZ1JGWWtDTFRDODJhbk1KQXll?=
 =?utf-8?B?M3lUSEJSWEdYek5hVzl4NFh2bUhLRmZYUDNkK0NxNWh6NVFja1ZUUk9tNzdL?=
 =?utf-8?B?eEkxQzhhTmc4ZmltSzljU0xqYW1VZEExK09LYkZRQjRZK1o5aUFkUzRtVUhM?=
 =?utf-8?B?ZVZVSlpqSFVXaXVwR3d6TDdEYVBQeEZWSCtGUE1BaWhZZjRQNGFOUGZHMlA1?=
 =?utf-8?B?dUFWOFNCbWJFa3hLUWoyY1V0d0QxVWxnWlAvajFaQVgrMW85QkhwaXZQK2s0?=
 =?utf-8?B?MDRJK0VZc25INGNQTHRKSTQwcmZ5MitmWHNtV1hLcHlwREtITTJxOHhEUTVU?=
 =?utf-8?B?MnBGMjRuWGVIQjFHMCtXaEhpV2QxS3MxVGZjWTNwaUp4cWxMM3BZbjNrY2th?=
 =?utf-8?Q?I5CrhiqYzXA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bC9RdWRtQWhTMk4rUlNHTzRFZmVjMDIxNDFTMEhqc1duWHk0K004b1JDdG5z?=
 =?utf-8?B?MDFNSmw1b2c4VXFORGpsK0NXOWVyQ0VTQTFYeWxVWVc1VkF3QkxScVluZHRa?=
 =?utf-8?B?YVdTMlAvVzNTMGhyeXBNQW4xMU52clE4RmpJNHBvc1RwZUM2SnlpdTFrZm0y?=
 =?utf-8?B?c2NVWEZobFBqMUFpTDh2a1UvZWkyQU1ha0FCdkJPZHA2WG5rZ3NXeVF6REZP?=
 =?utf-8?B?cE5DVUVWQXRxYkxwNlJaK2czbnpDeWhhUVZQc1lVV04zaDVtcDBMSGE2NlBT?=
 =?utf-8?B?di93MWhGaW5wMllDbC9xd3J3akNpUFEzY0o5VURaeVV5Y3o5NlN0WWJTQmtF?=
 =?utf-8?B?N0szY2R6cThBVmlaTjZYMTFvZnFCRUQ0MDAwU2k3d3BmMW0vdmZ3b0d2RmxN?=
 =?utf-8?B?amEvUXJZcVdLZ0Nmai9rZUhXcmUwZHBvR28zR0l3N0poYUFacGpsaCtZZ3lX?=
 =?utf-8?B?bFZnYUw5WDJreXhDQjUxM3I4TjZSdU5Jc1U3TVNjY1pZeTJlcVg2alhoN3hB?=
 =?utf-8?B?T1ZXVlc2NlJhcFdTaXhHRmN1SnFqdUJZSDRNak8zbkZOQkJTc1ErVnArbFpt?=
 =?utf-8?B?MDJFWGg2cnF3djd1OXBzeGhVVkM5aEFoMEJ4YWVUMjRiYjF5MFIyYzUrc1A0?=
 =?utf-8?B?TWliNFNaaVlmWHJLaXdPcnFScG0yZjRPOHRXQzRURXdSY2RuOGNsNGxEa2RW?=
 =?utf-8?B?VU1mbHl1UThrM1hWQkttVE5paW9pYkllVk9IOFZWbk9BWThhNmNKRmxNeldS?=
 =?utf-8?B?YW9qRlhOU1pEc1pQYnIrdjZTV3ZXRmdRdXVZTmozSFB4cnB5dmJYbEdLTEFO?=
 =?utf-8?B?UHMvZjJGQ0I1L1IyYlM5VE4wdzgrUUxjRzlLMkR4UGR3SzRyTXcwVzh6cWxI?=
 =?utf-8?B?MWR3d21YTkMrQW1VZ0N2RXF3QU9FaFRjZU4rYVAyZHJTR1lmZlhldFRSQ01U?=
 =?utf-8?B?cWRtN2FQbndzK3pCVEE0RkFZdW5PbXpWbGtvZmNKRDZDTXoydjhpK0NtSDBq?=
 =?utf-8?B?UDdXeFE0citKTzJhVXFsZ3lXK1RHZVFsQVNhbkpQd2wxbWN1bmJ1akZyYlh5?=
 =?utf-8?B?WkI2anI2QVpsSi94a3ZXbzZaNGwzdHF5NVVIWG91Q1prVjl4SG9kQ09oaFQ3?=
 =?utf-8?B?OGxjY1ZhNzNlY1F0OFVIUUJvYkR2TERjWUNjVUVIS3R5VlFHOGsxZkx6RDFL?=
 =?utf-8?B?c3JxODlDc1RqV2xPVldxWWF2dXJ1b2w4QnhHMGJDOUdVMVhFUWtUYW05anZK?=
 =?utf-8?B?YzNBcHRER2oybGVZNHhlQWhxc3VadUJkZUlCR1htMHM2TXJCajI3dXlVOWlt?=
 =?utf-8?B?cDNyU0pGN05WOXV1b1ZYUlU2UTlybSt0WGppRkxTTmJucUY1SGJvT2NyK2dJ?=
 =?utf-8?B?bklwc0FKM0ltenhKajVHeFBwYm5Eeno1eWpQTGdNQ1dqQ0FEZldqQVNSd2Fk?=
 =?utf-8?B?L1JGZ2NmS1ZZN2lWUHNhZXVSVkdMeHdLZnQrcUFGVk54NVVoMUJYd1RXSnZP?=
 =?utf-8?B?TXB1UUlJLzZzc0pRQ1ZtNXZBa050b2V0ZkNIVldsbStMcUJIOUMyekxSaHdR?=
 =?utf-8?B?eElveTJPOG9seVhQNTMraGhaMzN3SjMzNmdJSXhlNGNkRERkdkpDSVZ6dnpQ?=
 =?utf-8?B?bUxFdkN3TXNDcTJUUzhhdzZUVHpBWEgweHR0UjczODdXVklPaVhwRHpTU3pv?=
 =?utf-8?B?L1VRU2RnK3RuY1N1L2tDdmlPd1pUWDdvYUhQS0NjK0ptMU5wYUk2RnJDcjY1?=
 =?utf-8?B?Wmt5T0Q3NkFVWHlRNk1PTytuSTlML1JFU3lxUVdua3J4cG9Yc25PTXpyV1Ny?=
 =?utf-8?B?MDVKbFE3cnN4eFdSRTVXNVlUYVFWNE8rUFhPU1krZEJjblNtOG9CNEYvVEpP?=
 =?utf-8?B?KzEySS9EN2Z3VVZIcXlPZHdIN3R3elIvL01iMzFhNGtsM21pVUV4YStjc2FK?=
 =?utf-8?B?VWxRZVRNYng3clhaRnR1R1JkWElQTlJqdW9keHJJdkF2SUJRYWIyVDVGNytm?=
 =?utf-8?B?L0VHV1VuOGJoUVE3bC8vWW5qM1JLU29KVzk1TEhaVHZvOEUzYm91ckdLaysw?=
 =?utf-8?B?RFBpMDg5QnBwbmFuaXU0THM1bzNsM3dpbFFzT2FEUG5VQUxMMHpEeVNHVndt?=
 =?utf-8?Q?GZhPLlgwQr1DalSXxueE+OUrP?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59fdef42-cc4b-47ad-f2d9-08dd780744dc
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2025 08:11:17.5782 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QWuDDfTatwfb2yGzqGcK3nlXubknYUi10yW04K/lCxCA4RiaeSlDUsNJQQCSmylj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8407
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



On 4/9/2025 5:40 PM, Ce Sun wrote:
> Fixes smatch warning:
> 
> drivers/gpu/drm/amd/amdgpu/amdgpu_device.c:6820 amdgpu_pci_slot_reset()
> warn: iterator used outside loop: 'tmp_adev'
> 
> Fixes: 8ba904f54148 ("drm/amdgpu: Multi-GPU DPC recovery support")
> 
> Signed-off-by: Ce Sun <cesun102@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 60269fba5745..eb0589a09a27 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -6846,7 +6846,7 @@ pci_ers_result_t amdgpu_pci_slot_reset(struct pci_dev *pdev)
>  		dev_info(adev->dev, "PCIe error recovery succeeded\n");
>  	} else {
>  		dev_err(adev->dev, "PCIe error recovery failed, err:%d\n", r);
> -		if (tmp_adev) {
> +		if (hive) {

Hi Ce Sun,

Looks like your original patch broke single device handling path. That
one will need a revisit.

Thanks,
Lijo

>  			list_for_each_entry(tmp_adev, &device_list, reset_list)
>  				amdgpu_device_unset_mp1_state(tmp_adev);
>  			amdgpu_device_unlock_reset_domain(adev->reset_domain);

