Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A25DBC25B74
	for <amd-gfx@archiver.kernel.org>; Mon, 27 May 2024 19:40:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 21C2010E321;
	Mon, 27 May 2024 19:40:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5dWmy2n7";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2068.outbound.protection.outlook.com [40.107.223.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A600910E321
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 May 2024 19:40:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MJJ059puMQOxRpDxtxfZ3drUDhyJpugX2ALR8L+w6z3kT6Pg+mItJpN6hJzNB35/8p4GxAKdvqS5fn8FW5S4I++7K7/fcAtVWUbFb2ZUffwVXo/pFUoTso75qepHWMu1QiZbcGOcp34XIibtSUh6/JaX41c+bQYgceWc69fq2JAdoER0uKubLVT0grM+E4z7HZVuRiKdcdi2R1/ts+X1cSzl9XPAtfLeb457FWIBlU8c9S5M6/hE0gZFcRQ0d87qoIlXkqvpNEXKgbJ3JHc2Bck+aHg5qmVTG95IhWcyXjxefTkZbmdL65e0RLlLIjxZLOyRGhbbqF22y8EwJD4vSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CEkKJ9WnQER/wqw6MmFeNIkYwYPzu2SaHmjB8g7VLt8=;
 b=GG6LU+6wG7RwifD107rQHai2A/KshKnyzwK9niqcIgbeysLVtgM5qLi5Xd+6YplvzkIxgizOab1GqcdHg+dTYlZXAwKhtBasiJnnuFIoZOmoYxltLvkkcyKrkBVy3WAFVxBpTUQlFfdHO0Dk1aPDTxKKXrzt1Gd9eCP6gtMg+mj9U20XJUQXirRk3AxiO4c7qejWC7TZZkxbE3taDKdV+aHKsqBeBMxl0y8pnTwvNvfba0VUBCJrmbeAhB0x0Vm7oo8CTJqVl661MByzLwUitFcqP/FmPSZkB0A1p6/75APCkb2zGPILM54Hww/Ik0g3h+fGNOosOZuP3iBoGkkKTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CEkKJ9WnQER/wqw6MmFeNIkYwYPzu2SaHmjB8g7VLt8=;
 b=5dWmy2n7/Dqg6EW1hhwiQE6LEDMvJgszc0hP3bM0nOTT7ecuRn5uDeLkeMsIKI9mRbJ6qFSciC9HBVZGrtIqLIVTIRegcafaIGjw1FLxS+3rfCIlmj50xrxTV/48SvdG2VPeC/Qrf5bpHHuOwDXDJ37e5J0CacvgRGBXzI+9474=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by PH7PR12MB7284.namprd12.prod.outlook.com (2603:10b6:510:20b::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.29; Mon, 27 May
 2024 19:40:46 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81%4]) with mapi id 15.20.7611.025; Mon, 27 May 2024
 19:40:46 +0000
Message-ID: <3dd9e8ab-8c97-4948-be42-a322c1aecf22@amd.com>
Date: Mon, 27 May 2024 15:40:43 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Make CPX mode auto default in NPS4
To: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, lijo.lazar@amd.com
References: <20240522191526.342975-1-rajneesh.bhardwaj@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20240522191526.342975-1-rajneesh.bhardwaj@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: QB1P288CA0016.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c00:2d::29) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|PH7PR12MB7284:EE_
X-MS-Office365-Filtering-Correlation-Id: b76523d9-e8b8-4666-cd6a-08dc7e84e720
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WjJLam4wRithQnRXVWVaOXYrSkRoYzlHYlBzQ25EMkwxQlVMeHVTWjR2VGVW?=
 =?utf-8?B?ZGVENkZZbzV0ekZwZXUwL0VVWWlpemhVZmxHc1pIU1hIN21PQ0FmZUl3a3hW?=
 =?utf-8?B?RVcrb2svMUZ5eFcxVFIrZDNzNzlJeG1CdytLVlVSQWZaakVTSmgyUVBvbVVX?=
 =?utf-8?B?N05KOTVCa0pTZTNiU2tMUHZuMXVzQVR1eEcwelVVMlNZWnl4NngwTzNqZ0Nu?=
 =?utf-8?B?REp3S1RrdVpOaUx0R28wNFpuWXo3aldmRlVIZFlyeFhGK1BhbURXclFra0Vz?=
 =?utf-8?B?RjNUUEkxVm4vbzRCUDZVRjBJWElmR2p3ZHJUM0VnZnU0SVY4c0EwSjJaRlpm?=
 =?utf-8?B?aWxYTWx5dTVSMDEzL0Z2K0VZUWxVV2dRaHVQTDlBVkcybFgxNzUraTY1Mmdh?=
 =?utf-8?B?Q1B6c3dWRHpJVE5TTGY4bFA1MXkrcHdJMFNyZm9wLzRhQ0hCc3V0cit1UlhS?=
 =?utf-8?B?Um5uRko0bHM1YXNybGUrNGZ1UWo3R1BtRnh4YmthcXA0SjZjQUNwaXkveGtB?=
 =?utf-8?B?ZXJqYktyR2dHcVY1V3BTQWpJU0d5THFSV25CRjNvT2s1Y1BHTXpFNldPazlq?=
 =?utf-8?B?di8vQThUVDJjV3c2dDlCTU9aVzBDS3lWV2hpOW42REVzU1BXUkgweHBhREJQ?=
 =?utf-8?B?d2pOMGxTZ2hiOHFrc1FuSG1XeUpYVEFNcW9kL2hpNkdJQkpwY05JOEZBZG1v?=
 =?utf-8?B?Z1orYlVuMk90NElBVk84RWVZcEttOHZXQmdRNTAxUitLZnB3b3VuQVRPcmY3?=
 =?utf-8?B?ZWN1bS9oTzkzUll0Z0JXUW5BUS9KQTMyN0V5dWZQWTM1c2VkYlNnSUVNYUtI?=
 =?utf-8?B?aHRNUjNWbkNkc0FJNDF5NC9YZEF2Mk9XL3hWQTF2eU9XMG9VdHQxN0NhZzNL?=
 =?utf-8?B?eXBTZW9rQk5JdTNlWWpCL3ZOU0hXd0F3LzlhUFpIMkV2eG5DbVppWURxWGZN?=
 =?utf-8?B?OU1nRG9WbHF5Z0tLUDBLOEwyd1dPNk1hWEJicGRXVnNaZHZpL0MwOVQ1a2RN?=
 =?utf-8?B?U3E2M2F1NW5PTi9nRFdwNjAzNU10a2ZraTFMVmhVT3JBYkg4RldXV2NPbkNK?=
 =?utf-8?B?VVp4RnJqRElZMEgrdUwxeG1iOUxLdUtiUml6Qkc5ckpwOG1jbm5QUUpCc3FW?=
 =?utf-8?B?NnJCZXY0cTgwR1dSb2VlMjFGTXRqd244TmZlZWRIMlUrSGQvdlB1QzBOSzIx?=
 =?utf-8?B?VzU4Mzd4TjZxS3JEU1RtY3JFNUIxb0JFTjRHazBMZ01PNWttdFdnaUlISGFs?=
 =?utf-8?B?R1VZQ3pTejk5SzB1QkcweXdKdS8xZVprL2NFemp6M0tuRUhvWk9xN3BpRzV1?=
 =?utf-8?B?Sm1MZ3RPMXlpUlUvam9pM3prZEpsVVFlV2pUV1ZJVVpXQ3pkV1FkQ1JTLy9t?=
 =?utf-8?B?aTJMV1dGUUgzdXVmSmNpL3BGM3VKa21iQWVRNk9LaWVROEJMc3czRVBFMngv?=
 =?utf-8?B?UDg0SlhSdFJjM0hOTUtzOUFnSGpHN0FILzJtYzBqUC8xTGRYR1k5amdnUXUz?=
 =?utf-8?B?K1lqWk4wUVI4MnZJV2J5M3VjaXNvaVppN21CQUJwNUpQTk1XRG9sRHExRUtG?=
 =?utf-8?B?aXpkNmdGSWk2Q1B3QStTcFlzU2F3V1hTaGc1Q0ZPVWNUMHVWVDYvUDZRblNr?=
 =?utf-8?B?V2VnNTUyZmd4dDdFTGw5UUxaVFB4UG1JR3VkVEpQaEZCTlZsOW1kdTloN1lv?=
 =?utf-8?B?eUhscVhHYytHZld4QTBMR1c4ZXA3NCs1a2l2N3BVbmhSMHFsTXBJUitnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(366007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NlVWL3h6MXMxWFkxOFQzY3F4M05rbUdKNkNTK0pVdXZIaW1uMVY2SnNWTnpk?=
 =?utf-8?B?eWZoRk9jVk9EYkUxM0FBelRqdTZQK3BMd1RUZE1YcmlWZXZUNmpiUGFYSnh0?=
 =?utf-8?B?cUVnSVZwZ0d0OEZsSk9ia0E2YnNsM3YycHQwcjlBcHFLSUY4V2tkTEFBaWxO?=
 =?utf-8?B?YlFwUUtyVVFiV21YWjVxM05HeGFHZFdiWXlQRVVHNXBRRGI4ODkzdjQ1d2ky?=
 =?utf-8?B?M05mSXNKVkU1ZXRiWmUrTDhYMkREK1lUSlFOeEkwRVdsMEFBMkhLaXZxM3Q1?=
 =?utf-8?B?TWd0eXE4N1Z3V1IxaFVkdGUzZFZ5S0p3bXNreVZGVlBwUFBzRVJZeFpyVjhq?=
 =?utf-8?B?eUlvTlQ4eDNYQTFkdWhZREU0QWM1bWlEbWNuWFg0WE52YkpSNFZmTjhna3o2?=
 =?utf-8?B?MmRFQzExSlEveHdna2w5TkE1aDlpT2cwQ21pelBIQ0E5K2l0Y0J4dVRJWDBy?=
 =?utf-8?B?cGw2SHhHeTdEblZiNW9LMDNqMlI2dHpzZjNQSDZFRnN3RjVmYzFGMXdKTEgz?=
 =?utf-8?B?TEpRTFB2N2tEMG10S1lvLzNyV1NxanU4VWdQd056U2ZOL3pwTkdZMzY3UFl3?=
 =?utf-8?B?UGVHYjJkc0crbTg5dElHVG5LdTMveGFZRnFNZHlqTWlJaGtCYTRrQko1RHRu?=
 =?utf-8?B?VE9vN1NZcktBUnlhUWdxWVA1VlF6bnBIdHBkU2pkZVVIQi9UNDZrZzRWc2Q2?=
 =?utf-8?B?RHlvdGZCRU9TNVdXLzN5Y2o3aEJaUVpEMDdTaEltTUF3S0hsclFablBSYW9E?=
 =?utf-8?B?UkkxWk9GaXdWb2pCaFFQRjFjZE1JRExMeU1aait4b3kvSThVaGJlZVFpUk1F?=
 =?utf-8?B?ZDJzRmo4UHlvaXlCaGFKVDFhcytjV0RsTXVBZGdHZk1mTU1BUkFkVHRCdW5X?=
 =?utf-8?B?Q1FweG94b0dyUklQYTFrS3Bpb2VxbnJtZVBKVHc5dVFLSkk0cXlsKzJIcCsy?=
 =?utf-8?B?ZDBCYlBNSXdyVVhIR0RaRXBERW1MdDlDbzZlTjE1UDhHbWxDVWVWTkFPS1cy?=
 =?utf-8?B?M2hYdzl4NEdHc1h5V1FoUkdVbVpXYUIzZkx5NW9GSGRJbThBRldJM283RzM0?=
 =?utf-8?B?OUMwQzFpZmEyamJtSlZIR3FPaUR2b1lwTjN3azBqMFNZQnJyTTVJd2wzOWdB?=
 =?utf-8?B?aFRXZk95aEo2UDBGUFFIK3FxMjI3TmREd3JzSVQrS0I3QlFVV2ZuR0lSSm1P?=
 =?utf-8?B?aXllc0NoT3hUaDVWaGZkTGVjZThZMmwxQVp6cEJ0R01SL01adm1LMmlXU0FH?=
 =?utf-8?B?ZTVDY2NLZzZnOVdTNm8rVDRVVnlpMXZYWXlhTWhESW5FU3ExQWtwVWhnZWlo?=
 =?utf-8?B?SUJrVm9OTGtkVU9PZkpWK2ZzdGZWNHp2UDFWaEcxNGJLeWNMVmdBdlIwZklo?=
 =?utf-8?B?VXdKcHk4WnZydVFlV2FVVjNPRzNDZ2s2YzZZNUtReUtkb1hMTElnbkI1Z3lH?=
 =?utf-8?B?WUt4dlJCU3ByT2xEc2hiVVlxakdMU1dCWTNPRDR0a0RNN2ZWN0NaZjdkL2w3?=
 =?utf-8?B?T1AzbDlVYW9uVFlxOTNMOC9EbndqaFlkcTNvelVIaWxlYkllQTNOVE9SbVNO?=
 =?utf-8?B?T0RRVEJsOG5PUkF2NDRXbUxTaTU2VXVwZFdSN2JuQlNSRDhoTG0vVWpuMnlo?=
 =?utf-8?B?N3ZJQlo0OWU0MDdwUkwzYnZjK0dFaUhnUFdISVd4Y21VaVpUaG93cmhwWEFZ?=
 =?utf-8?B?VTdRMnVUc1loYWxwc2ZFUmdUakQ1S2dvTGhqUVN4MnZYaHBmb0ZyUno0QmpZ?=
 =?utf-8?B?VFdSUUlRQmdwL09RVXhFd0pDb01zbmNlTzNNUTB0UEJ3RmJ0bGF3MzNhTmlS?=
 =?utf-8?B?S0h0ajlsUkpHT0tXVG5nWE1ySG9wd1pBc2FaMDZtTjRLWUVsdFlWQkZPK0kw?=
 =?utf-8?B?SUhyMzdmQnM4MFI4MDkrREQzR2hheGp0U1VnYnZ0ajNEZFdHWUFMc2thbVZa?=
 =?utf-8?B?YUN5dmZ6cXZvMkhxL29wbG5tcG03UVpPWDh3dmxrZ0V3Zlh1WjR0eUszMURk?=
 =?utf-8?B?dDJaNitiSzN1YjM0dko0SEVORUJjejJMZGgxMTZkWm93Q0MrSGtkSGVid2k5?=
 =?utf-8?B?bjFwUEJzMHp0WTBRWGZqYjN2YmNCNXNSeVdXWGk1aEhmN1dLMGZISHdRSjJt?=
 =?utf-8?Q?zfLDVV1uDYv2G6kBMXt6YyChx?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b76523d9-e8b8-4666-cd6a-08dc7e84e720
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2024 19:40:46.0033 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QjypwVZgu6//UqAMgBgEQfAsAgk0Xv8veYRQdEXvBQUV9Nhrs50L9skU9HxJFN/gxXqSpwT+4ih8w95dBfSKHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7284
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

On 2024-05-22 15:15, Rajneesh Bhardwaj wrote:
> On GFXIP9.4.3, make CPX mode as the default compute mode if the node is
> setup in NPS4 memory partition mode. This change is only applicable for
> dGPU, for APU, continue to use TPX mode.
>
> Cc: Lijo Lazar <lijo.lazar@amd.com>
> Signed-off-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>

Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
> index d62cfa4e2d2b..2c9a0aa41e2d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
> +++ b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
> @@ -422,7 +422,7 @@ __aqua_vanjaram_get_auto_mode(struct amdgpu_xcp_mgr *xcp_mgr)
>   
>   	if (adev->gmc.num_mem_partitions == num_xcc / 2)
>   		return (adev->flags & AMD_IS_APU) ? AMDGPU_TPX_PARTITION_MODE :
> -						    AMDGPU_QPX_PARTITION_MODE;
> +						    AMDGPU_CPX_PARTITION_MODE;
>   
>   	if (adev->gmc.num_mem_partitions == 2 && !(adev->flags & AMD_IS_APU))
>   		return AMDGPU_DPX_PARTITION_MODE;
