Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B42ECCAC5B0
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Oct 2025 19:11:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B32410E964;
	Fri,  3 Oct 2025 19:11:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WZ3pI7Lp";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010053.outbound.protection.outlook.com
 [40.93.198.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 197FA10E964
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Oct 2025 19:11:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iV7mqBuciMO55eMevT036PDG6DZ/iNAeMMsiFc+oRWYg4ATfJRUZuWbEft6lHbvPeKsXMuVag4P+ZQkJOcr6lzrkVCD76e00kADDUsctkA+KHi6IUYf65w2Z5Tgjlyc1/lo/8nERm9axkiAF8t0z9UMybppLJ47Qs9rTZdDkrxP5DqbsVMx15j6S4MWXJwwOPCgsDzf5Ah1hPERKbRfFwZdHwk5GxUcawuu1pZ9qs0xYdP6aaJlzFoF1/yvi1Z+xJVRYlhSGrxpCNuCpmNjUGehFx2LLo1O18O+dKF8aGrUtgw8/RfOM2SJl9QoUwAUzSHXKP9gIB5AgURk18j9AYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6w4MnM8R1VTzBec8KAcqRCCKGZeavwB77+K+Em3cxpM=;
 b=Vu5cLrRov/D84l8JLleixfM/C5oE0YPSKzYcMCNQ/DBGqDzQt6G58QPnv3ICm9HhHrK9K3hNmfYgs6st3zaplipfNa2TAG18bQfAROVEX4T0EZJKZm4Csz5fD9AAB9dCKFpouilXf3rmICMCuMnpDPWIy2XDmHo23eLFhxLCMW71EPJXb+nfEYnMHxcLLzNsofueTGfBcIRHH3xgsuI9Uo2g49wfr88npIa1tM/LaJFCYNfXC708tB42ivGAOwAU0wZ1/4bnkFkOB8kRpZRmZn00cNk5yRAlnONv10deNg6SVCcTeg5gMRP5atStcwiX3yXU/kPS5R2C1uXhi4lr/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6w4MnM8R1VTzBec8KAcqRCCKGZeavwB77+K+Em3cxpM=;
 b=WZ3pI7LpsRmd9vFrzJt3bZOGihVjKyEVi/IRdbJWJ33pd1ieGpKyEkzyN2lawzhSO5cFkl3f7jMBOBUXcPpkhjojJ2/1tCDrU1Dw8r0UfAsBSU3pJrVOpkLY8qco/An/YmQ3WuiAIUl84b9ZSSETeBEW41MGKPIVbtsz/8DVw9w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6566.namprd12.prod.outlook.com (2603:10b6:8:8d::16) by
 DM4PR12MB6134.namprd12.prod.outlook.com (2603:10b6:8:ad::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9182.16; Fri, 3 Oct 2025 19:11:15 +0000
Received: from DM4PR12MB6566.namprd12.prod.outlook.com
 ([fe80::31b:5d31:8ba6:abd7]) by DM4PR12MB6566.namprd12.prod.outlook.com
 ([fe80::31b:5d31:8ba6:abd7%6]) with mapi id 15.20.9160.017; Fri, 3 Oct 2025
 19:11:15 +0000
Message-ID: <2ed6f7ae-9083-4835-a0f6-1795b63391a7@amd.com>
Date: Fri, 3 Oct 2025 14:11:14 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] drm/amdkfd: svm unmap use page aligned address
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Felix.Kuehling@amd.com, harish.kasiviswanathan@amd.com
References: <20251003181518.24270-1-Philip.Yang@amd.com>
 <20251003181518.24270-2-Philip.Yang@amd.com>
Content-Language: en-US
From: "Chen, Xiaogang" <xiaogang.chen@amd.com>
In-Reply-To: <20251003181518.24270-2-Philip.Yang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0225.namprd04.prod.outlook.com
 (2603:10b6:806:127::20) To DM4PR12MB6566.namprd12.prod.outlook.com
 (2603:10b6:8:8d::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6566:EE_|DM4PR12MB6134:EE_
X-MS-Office365-Filtering-Correlation-Id: 67b3e2df-8c1e-473b-7856-08de02b09fec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WVhOMHErWVU5K0xtYzlEaWMzdnhOdFM1WGp1VmI0RHFkV1B6WkhpRGJXa0dv?=
 =?utf-8?B?V0tCMkVzcEVRRHJvbUVGcEEwQUl0TFNjYkZteXlYenY2TEQ2Q1NmM2gzVXBM?=
 =?utf-8?B?Q29FYzR6a0ZZdjFWaWNRK3pTd2xoaFhtOUw2ejdTb3NFbGZzU0xpTDU3MFZN?=
 =?utf-8?B?d0pwMHlpSGRlN3BQY0JVNFQwdzJJMnM2NWZyMUJNM2R6bXk4dzB6bVlhR0JF?=
 =?utf-8?B?OVVYMXZSenNsRlk1aTMrUmRpd3FrOVdiSjBXQU40K2NGSWxLVmF1VCtpUXRM?=
 =?utf-8?B?LzFheEtDUEhPSGh5VjgvVmRhb2J1dTZndjh6MEg5Wm00NXBLYVY0V0dXQjhl?=
 =?utf-8?B?eDBXOWcrNStCdWtVcnpCL05QNStpYjF1QkdCSWgyV1Mxemw1UTZDSjhKNEtV?=
 =?utf-8?B?am1kVFNHOTU3WFNPVm5STUJhUGI2ckI3U2dSOVVjVkV2NTc0REU3V0xQZzEx?=
 =?utf-8?B?bHBDWkVCcEI0ZGo4QXRtbCs2am9tQ0FSUE1vclNMMzhhNHhsMDU1UmJhTHRs?=
 =?utf-8?B?M29zUGNUNEJ6SG1RV3FUQW4yRkNYcWlPb2lNbjltTnZPR3VKQmppQ3dFQXpW?=
 =?utf-8?B?RE5VRkxDaXFjOTRXZmY1M2E0WnhrNWVySnE3Mm1CVUhoWUhtdnEvYlVpYVVU?=
 =?utf-8?B?YW5FQjdQSnVKR3RWVk50NC96KzdQREdIOVd2czVaOEVDVzJDaFdoUmFvT2c0?=
 =?utf-8?B?NnV3cTVSV2V6WXNZczR5U0xpOHBKcitIcHI4NXQzK0hSZGpQNXcwdDhXRkZj?=
 =?utf-8?B?R283Qm8walR6a3V0ZVpYNGhSY25Fa0NBd3JyWExHMmo0WnhXZ1BUTmllQzZy?=
 =?utf-8?B?NjFGWWpKbmJEYkNvSkk5U0JLVTlFeXFBNjNnYjc2enRUZ3FWYmljeXdYb1BZ?=
 =?utf-8?B?TEhIUkl6ZEZMWk5DUFFINzBlZC9VdVJYNlJmYnJ2dVdaR0tZVDhDczJlZTdN?=
 =?utf-8?B?eU5DK1JsSXZTNllqeTl6a0ttK0xwSUFuWSt4TnNzK1VicytNSlI2RXo1YlpR?=
 =?utf-8?B?N050SC8yK2JFS2s5T3psaE5EWmUrQnhvMEZSeDNVVllSRkpLaWZLcUN2S0dt?=
 =?utf-8?B?KzlmMEVocElwVTBzSnNtMWZYSHZtMXZSclU2a0VjZFBZTUkyT3hxRmcydDd6?=
 =?utf-8?B?T3hSN0pxREN3YU1VQkZ3czJxSVJ0YldvbnBIejBGSnA1b05tN1dlV0FXUDNs?=
 =?utf-8?B?RHVIL2JDY1lnbkFJSWQ4ZmE2R1NRU3gyY3NiZno4ZVpjT0Z0bEMzNVoraFpv?=
 =?utf-8?B?b1ovZjNpZW1zU0tZWGdDekw4M2dvTFhFR2duL2l1NVBkRWhJSnhVa1JVWklq?=
 =?utf-8?B?OFdBR1g4YnhocGZyd1haRStENDl4K0NLcmdOYzVBeGZsWVR6d0FjTXBzVDll?=
 =?utf-8?B?QTZzSzlOS05VcXdycFNGb3hXV2c3RnlXOGpRVTU3OW5saitILzVtR0xCNi9I?=
 =?utf-8?B?aUx1Rk8yMURUb09VWG4zcGZ6WWtrQ0E4UmlZWFRwWjQ0dC9pT3ZITUY0Vk54?=
 =?utf-8?B?K25MVHArYmtPaGhhQjNodFVwSjJqYVpReEU4OFh0ZzRodllaeW9sUXlrTDhL?=
 =?utf-8?B?R2VKbnhZTnBrNDE1VDBnZVZ6c05ZdjQyZDRDaTl0TmRmMWdBNzRDZ1J5ejNL?=
 =?utf-8?B?SFc4VERRMGtoMkJnUFQ3WjQvcjJhV1g2cDk3a1VQOXhqaFJtSUVQTW00Nlgr?=
 =?utf-8?B?L0ZjR0hQOE9yWjZVUERGejI5WUt1enNDVng2YkdHd3lXZTF3aGlRTnBMMW95?=
 =?utf-8?B?QVdVb0NCWlBpRUQ2RzJVck4zaHBHay9Eak1tTTdmSmJHT1pzc3kxYUNDQjcz?=
 =?utf-8?B?d1FrSkprK01vT2VXeVhERHFwMkVsQWJhaDU1bFdmZTYzMkZvRUNVb3A2VEdj?=
 =?utf-8?B?ZkxBZVUvVWl1R29XQ3NleHBYWmc3OSs5a0QyMkxqOGswK09JSzFib1VtQU9t?=
 =?utf-8?Q?wvvWRrs1fK3uBt24Hwo8GNGdo8YFy1sB?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB6566.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eHU3STF5aUlpMWFLME96cmlQMzdURlQ2RHk2bFJjeTEvMUVUWWVaUVdveDkw?=
 =?utf-8?B?VnFyZFJBeEhFdGhvb3hDOU0wNnBKSGw0cnF6Q0pQSTd4TXJCTUpxcTNkaU9q?=
 =?utf-8?B?aGhkbEJFRjVqeVp2TTFmdGhiYlhrWnhBWWw0WW5OV2ZnMVk4aEwwSGhGZWw1?=
 =?utf-8?B?cDg4Nkk3dVJFY1hRZ3VSakRHY2lSNFh6bVVoM1Vidk9kbXhnZExEMmJvb012?=
 =?utf-8?B?ZW1sYmhQbXNlSmZ3RXFscEZ0NEhmeGdWTDVtTllLUm81YnVSOGk1OWxKNkJZ?=
 =?utf-8?B?bGduL0ZPSDNPVjhEaFpxZ0EwL3RzcVIxTnI1cGVjZUdZd05TaXQ2Um1hcGdF?=
 =?utf-8?B?UGJwTEh2emllOVZtc0dxbCtVKzVoNzl0aFdUaktSUUtibHlIZlBxbWE1eG5j?=
 =?utf-8?B?RkVsVW9RQXlFUUZHREVVZTFDaHVoOXZsOUtOTnRMVnNlbkpwQ1IybVZuS0NI?=
 =?utf-8?B?R1Y3MFgzaUdJR1FSNHVCYm16S1BLR2V5VS9vRDBXbGZqY09iSkNmRXpORVZL?=
 =?utf-8?B?aUxRYkcxdDA5NEVvVElzTUlwQndab2NXRnVvTHRBdVJMNFpISHJCM3Q2QnNI?=
 =?utf-8?B?a2E3Z1RWY3JlSWZ6S0hFczI3VW9Lb0Y3T0c4OVl2TlFMNjJpZWtIVFg0ZThq?=
 =?utf-8?B?RFRxWUs1TVZDV3pNR2JOZGhMYXcwYmdDUmhtVXFGRW9GaGJkaFQ1a3lkeTIz?=
 =?utf-8?B?dXdQY3NZRkdpVWJYMUMwUy9ESk1nRDhTM1ZUQkFISCtOazdTOHhqcFRFK2Zw?=
 =?utf-8?B?VkJMN2VrdXl2SWZHQzVWU0VvbXE5WWZCYmJnVmdCSGpnd3J0Mm9UWnpXSkRr?=
 =?utf-8?B?RmFHYkZLRXlIYnNPVlJNQ2dET2xsenNXbXEydmt6NEM5NUhmRTJtOFA3NCta?=
 =?utf-8?B?OTJ0ZkpzNGovV0pRdkJDVFRkT0hEcFpDalh1NTdMM2RHRFR0d1YvOHRVUkNL?=
 =?utf-8?B?NEluM1h2R0FQV1lKR0JBMEt5TTJoTkdOOGw5Yy9Vb0pESzJMTHBpbVAxbyt2?=
 =?utf-8?B?ZXF3d3ppR29jVy9HRXhKcFRJY0plbHlnZ2pDNUdNelpUc0lBQlhxclJ1NWNB?=
 =?utf-8?B?V09Gc2ltQkhRMXFoUUJWRUxGOXpJSCtLWGNIRXRYY1BUZ1k1dW83MzVnSkFo?=
 =?utf-8?B?SWNuNWpRREpmbFhNS1RnYUVFa2xpYnI4MncwcnlpeDUxeTkxZVUzcCthMU1T?=
 =?utf-8?B?MkFLV3RBbjY0aGt6MHg2WVk5aUJDdlJNak1oT0RZZ0ZydmlKTHVHc0RpMzEv?=
 =?utf-8?B?UWZZOFgyUUxLUVdhMEFsS0R6ekU1NmloaEJEWk55eGtNcXdFd3FDbnpsRFRo?=
 =?utf-8?B?Zmcva2JXempyZUJQdXh5djZjUHZCL3Q4OVFlY2V2NjJXR1l1c0FTMWF3OW80?=
 =?utf-8?B?MEYzWndkRGdTbURSOXhDNGdROHNtbGo4WDJBZjZKa0s2NzdXY0htVmw4RjVT?=
 =?utf-8?B?Y2Y2NnYzdUMwR1ZkZ2lCSEtZa0lDdWdFOCtITTBOOEl3ZlNmaWJwVmFMWURV?=
 =?utf-8?B?Qkphei9sNTV1SER1YTE5emFOU2NqUDRocTJ4NEticEswbE50dVhaMVZzczJR?=
 =?utf-8?B?UzJlRHdBMGlKclhGU0hJMU5rdG9xTExFSDVOZmgxS2ZnYnc0a3NJdmdUZXN4?=
 =?utf-8?B?am4rVytSQ0dORFg5eGtBQjZFdUprVmtoWTd3TklXY0RMQWhqQkNwR05EL3pQ?=
 =?utf-8?B?dEEyeUZBVDdnL0VJUlRRdWMxRlN3SVRncitkZGxwVlVBRUMwZVZGNHg1WVBu?=
 =?utf-8?B?WGdyT0t5S3JkOHMxeVJsTEtHb0I1YzhEYUFUcjdpR0h6U3Jwek5UaDRDUitt?=
 =?utf-8?B?MHFxMnVnUlFvemdBOThnOTRna3J2djlTNVpyclJ3K2ptOVdjVkxsTlVNbmo1?=
 =?utf-8?B?RVZKclhQVVRNaXdnQ3NscWlGTE42c2FLdkgwRDdsdjV3TlFyVzR2djR4ZHlZ?=
 =?utf-8?B?VGVvWWJVa0FBMkZ1YWlXMXpWUnlKbjh2V2ViYmNrWGpZU01uS2hWUTBLc0VY?=
 =?utf-8?B?Tkl4OU9lbjIxQzFaOVo1VlFrQ3AvQjZJQ1ZrSTVpVGxDTTh2eHRzR2I5dHJP?=
 =?utf-8?B?ckpyRHByMkIzVklyQ2dzcnd1MXlpSlhaTWFaaUVER0VIb2lHQmdTVWk0T3Q0?=
 =?utf-8?Q?Ojqc=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67b3e2df-8c1e-473b-7856-08de02b09fec
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6566.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2025 19:11:15.6029 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QIFJOXkXBeMqmIVil6hOADQ7x/L8LJYgONDxCrFIqYBp00nb81/Cq8c+Z1dyBfRu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6134
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

Reviewed-by: Xiaogang Chen <Xiaogang.Chen@amd.com>

On 10/3/2025 1:15 PM, Philip Yang wrote:
> svm_range_unmap_from_gpus uses page aligned start, end address, the end
> address is inclusive.
>
> Fixes: 38c55f6719f7 ("drm/amdkfd: Handle lack of READ permissions in SVM mapping")
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 7 +++----
>   1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index e8a15751c125..0aadd20be56a 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -1723,10 +1723,9 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
>   				svm_range_lock(prange);
>   				if (vma->vm_flags & VM_WRITE)
>   					pr_debug("VM_WRITE without VM_READ is not supported");
> -				s = max(start, prange->start);
> -				e = min(end, prange->last);
> -				if (e >= s)
> -					r = svm_range_unmap_from_gpus(prange, s, e,
> +				s = max(addr >> PAGE_SHIFT, prange->start);
> +				e = s + npages - 1;
> +				r = svm_range_unmap_from_gpus(prange, s, e,
>   						       KFD_SVM_UNMAP_TRIGGER_UNMAP_FROM_CPU);
>   				svm_range_unlock(prange);
>   				/* If unmap returns non-zero, we'll bail on the next for loop
