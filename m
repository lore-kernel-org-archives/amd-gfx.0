Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA265C25B74
	for <amd-gfx@archiver.kernel.org>; Thu, 30 May 2024 20:53:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 20C4712B66E;
	Thu, 30 May 2024 20:53:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Rxp7Zg0b";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2057.outbound.protection.outlook.com [40.107.102.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 465C612B66C
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 May 2024 20:53:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IV2CpnD7f2wIFzT0vn5dnfai2zhrN28sUJV4GziopouLqCQp0F1JHFhfmwlVJYHW5ZgfbyIy8MT5VkhTVvvVBjuX+7pMNhKvxxQUyM/d64kmMwlFjKnR/o/0dMWfUc0OZMRetP04lI3d5kv+pD+MpAZ59g6AVJu7/gtqtDM9ggevKaJrP442GNIRghh49Pyh21kvc71ykYecycCPLnY/Y3hSaDPkILGz3BxqDTgLRqOn8SjuyVtbC1oBcI1xioUyL+IFgJWrccJkGc560Wq3/d5+58b5ALp9aWF762vpeKUak2B6LI/RbaMJGK2kcaTQENGdrW59UIYxDg7cWY2AMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mEfuCxpMye3bPT759pSIO14/X9WSesAJTpwRGVUELPs=;
 b=cbhtKCC3taR3XSBMjrWf9b01x23Fq4RrlpAmLxPC41X2TK/KMmk+7eN2eSJ7JDiNIVpucwoKb0RksqiFYJZESM/QhQA8qVBaBclbRD5BQ0EAsYn4RIY9+62adPHVCkiHYER+5KPLNt7kb9ZmZptJr426aQgEy+h5Z3O5QyPo4wDJiJTReB45SJpIaeG+GuTcbe0fdiN+jdNdfgLXcBcJQG9ike2LWooOyMmbB3HPc0qoERTtxW4VYWcZ9YpR12oO6ky8qGe6wbAZlfieewuMoHLLIEZEUVP44pd5BpS4zHcczhLx+oIdFQCPN6ox8e+Y9zBaM41y9dwbLlGdZOd0hQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mEfuCxpMye3bPT759pSIO14/X9WSesAJTpwRGVUELPs=;
 b=Rxp7Zg0bfb87AuCUc9f4l+QxQo8WSXjZggVJrWgtryv5fPRGe7CRr7/8Q4D2YvHpZ3l0C4WNYZpM25eEmGvaxjZHX/ZtRLvDcfp4XGFr1PcFUIPCq0mb0duVTfv//RJ+zpse72lwwNWzYhS74qPKHDOHqYevTaJ7ZbT51sW6Yms=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by CH3PR12MB8460.namprd12.prod.outlook.com (2603:10b6:610:156::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21; Thu, 30 May
 2024 20:53:06 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81%4]) with mapi id 15.20.7633.018; Thu, 30 May 2024
 20:53:06 +0000
Message-ID: <25960c20-9de0-41cb-83b2-ec78437333dc@amd.com>
Date: Thu, 30 May 2024 16:53:05 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/8] drm/amdkfd: remove dead code in the function
 svm_range_get_pte_flags
To: Jesse Zhang <jesse.zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Christian Koenig <christian.koenig@amd.com>,
 jonathan.kim@amd.com, Tim.Huang@amd.com
References: <20240530034950.2341520-1-jesse.zhang@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20240530034950.2341520-1-jesse.zhang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: QB1P288CA0001.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c00:2d::14) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|CH3PR12MB8460:EE_
X-MS-Office365-Filtering-Correlation-Id: 03edeb5e-10fd-4a8e-137d-08dc80ea818f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eDBhMjhKdnJ4VytycUYwZmFFK0tXMWRxdUw4WVRZbU5FS2Ezb3ZIVEpvakNB?=
 =?utf-8?B?blVBajFmUmphcUpXSnVxMHhMZkt0cjlFWXgyeSs3T2VON3ZaTGUzai9DOUs3?=
 =?utf-8?B?Y1IxeFRNcTRrd2F1eFZEcGVaanc4UTJrcjZwM0M0anlyaWh2eGwzdW9ac2du?=
 =?utf-8?B?VXRUejUvOFZWZlBCTWxUdUJtTlpHUitodXhzcnA1eENadDIrdE5qT0IxUzZ5?=
 =?utf-8?B?bCtIdDN2K2p3NFJMNnpzOHBkd2dGSlVMYXV6VG9FK25qRWpoMFhHVTRJMjRs?=
 =?utf-8?B?d212VkdwOVF2akRuT1E2QVhsK21Kbmt0MnBrT3RpZmJCOE55WU1BM3FueWF5?=
 =?utf-8?B?TGhqMnlldjVMbVFZVkJlcVdnT241d0FFUmJJQTEyTXJwL1BlMFkzdzlzNzJk?=
 =?utf-8?B?ZkhYNHdGajgwQjM4d0V2cnRBWWpBVmYreGNsbE1FOEhra0c2cEpDVmtuMkdP?=
 =?utf-8?B?eEI1eSsyYzUyS21wam9TQ2ZmT29KVzhUMWRpZDAxR3I3STR5enpWTUs2NGN2?=
 =?utf-8?B?OExLbWF2VmJjZEk4eGE2R2VjZTBFMzZDZzYvQ1MvOENtZkM3S3k1M2ViMEFw?=
 =?utf-8?B?OHhNZm1lS0dLVnpoRExERVhORHdnNDMyNUM2QW9QeFAxTy9UNmxSVWdNcFpB?=
 =?utf-8?B?SGJPM0hYbUdNdjUvSjBod0FmclpkQVRYdi9sdENnMHZxbHNTbWVJQ3VYTkJI?=
 =?utf-8?B?YnFSeXBvMGM3ZTRwVTNaWGN2QmZXVGRJWU8yR1BhenpSbXByUlZYUnpDUjZZ?=
 =?utf-8?B?T0FPc1E3Q2FzTVoremcvQXpNdUU2WkNyVGd5TjJnb1YxckxGVWNEUnMwMjNG?=
 =?utf-8?B?Y2tzQTVQWURWYXdldmszanlhcmIxK3pDTFdEdWJwa1phYXRCQm53MFhwcUVS?=
 =?utf-8?B?MXFLcllOV29UOUliQ3FxejdTZ3BXdGJNKzFrR2Y2TDdiaEd0ZmVXYXZ3UFFr?=
 =?utf-8?B?S3RWTDlENnRYb3pzR05GQlNZbG5ZVk5XREdOdXFrUlA2aGl0dVpUS2dDQTQ5?=
 =?utf-8?B?eVV4ZzBTQkFtZ0MzN1A4UGN2RGsvK1dqRFhRZDRpNktXalJRbXEyUE9tOSsz?=
 =?utf-8?B?ak9ZU2xXb1ROcVlEbnJxNFo2MEdlM01NOU94WndENFg0MmdKK0xoSUE0UjJI?=
 =?utf-8?B?OVFGb2lYalUyaUNLaXU5L3RpSHIrNlIxTG1LUXlwd0x3VHlZakRqRnhIb0U1?=
 =?utf-8?B?WWVGOEUxVHVOVXF5NmZENVlKQVlzeTdxTjk4MnluUGhweFVnc2JSd1Q4R2Z4?=
 =?utf-8?B?YTlmWGw4WEtuaVpUb253MXo2S1dTTnFFNkdBbG9lMVB0ZjZCSHZqMnh1TlFZ?=
 =?utf-8?B?OU9nNURLMzkvbk44SmNoRUx2enpiU2s5N0ZySXlRck1YV0hqMTVaNkk1YTBC?=
 =?utf-8?B?bkFFamlpaUc0bEcybnQ2WXpTalJFbFBNVmZ6cnBveWlaYXVIZ3hBaDg2cnFu?=
 =?utf-8?B?R0xyRWhDc082RnV3ZnpSVmhycEx3a1RlOFhWK1NSQTZDOXFyb1NYSU96WlFt?=
 =?utf-8?B?VVdBdzhjZ2htYjVMZ3hpaXo5SFJSenUrelFZRFpLSkRhaW41ZjVhNjZOQkpR?=
 =?utf-8?B?cG1MendWK242RTlaall0WldOK1dGaW9vNmZ0azVKWXBZbHI3UVY3dnNRdmhL?=
 =?utf-8?B?Z1FyYlVBQ25Ucy9rRUFWSGk1RmEvaWJxRXJDNmZYbnA2dlpuVUNaODViMGdD?=
 =?utf-8?B?Q2FZY3cvQ2NvSlEvMTE2V0pSOTYwWm9xNUJBWkFxMlh0RjZleFBGV0d3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WWVrdG1EMUtEVldvY0ZOMmg0c291b0lKZ2tsT0J6ZklSRWhnRW9VaDE0OUdx?=
 =?utf-8?B?T3liVE1qU0tUckdsaExJblNRMENtcXBJdzZOa1BwL0dXMCt0Q2MrTkhzc0hr?=
 =?utf-8?B?UjE1bVN1azZYOUpHb3lLOEpCMUJRWm5tZ2QwUDVQcFloSzZlUjdlWjJ1U1hY?=
 =?utf-8?B?S1RwWFFoa0xrKzhsR0l1cjQ5ZTJGVlpwMHdDUE9YbklCQ3BXQU9vUDNuY3B5?=
 =?utf-8?B?UGp0UldESUtRejUzNTV3UnBXVlpyVUJWSFQ1YzQyc1hjeENZVUxxUU1FL3NR?=
 =?utf-8?B?Y1diemFoUE5WbUx4eTN4eFYwR0hGTi8ySmZXVStmUUNqNjRUQnI1QlUxOEVq?=
 =?utf-8?B?VDJUWjcvRzdDUzRPbHFENnBmVmxrTWFpQVFyZW55bkNpZkhmeHBmYWNveGZD?=
 =?utf-8?B?cWliWDRubk1lVWRvZGI1NCtQTElpQ29jVDJad1AzYWlVRjNjSXZseHQ2N1lw?=
 =?utf-8?B?eXNIQ0FwQTVrWXBqTnJoYnZERnlEVXJhTnpjUEdLWHh2K2lLaXpodEtvc1pk?=
 =?utf-8?B?SDRuZUo0eVI5aVFYT2E3RWZjcll1V0ptOGZ0VWhOdnU1Mno2OW5oOHV3cU9M?=
 =?utf-8?B?dkJxbVpReDVaOGVOaWw5dFdmblZscmhkdVNkOUc1ZXMvTmVuL0wweEZWQUFs?=
 =?utf-8?B?NzdmRFdRV1VYdENSbzlFWlozL0pvOC9ocWM3bC9QOTZESFpnc1A0Y2FmdUsy?=
 =?utf-8?B?Y2ZmeVVRbUZqOE1HNzd0NldEQkpaUGdwRDFYUnNDSmt2YmVJelNaTllNbjFC?=
 =?utf-8?B?Q1l5Y2g4MGVaa1BkRnBCSlUwRkd1UVFxL0l2bUYyL3M1U1VkZDJOVGs0U1A5?=
 =?utf-8?B?b3k3Zkt1dGJuZTVrVGd6emJEMHhCU0l6eG83UkJLUmJFVys3N0VENEpEcENn?=
 =?utf-8?B?aE9IdDhvMTJ2M005UlhpMXMxbWxTcWtmVE4xdmgzRzF4em5QbFMvK2V0NEJ1?=
 =?utf-8?B?ODZMd0NUUDFGdDhhTVMxOFBKbVBwQXlOaDdPYm9tUzdHWHZka0kvRGFMMFA5?=
 =?utf-8?B?RHVscHZhSHUwVXpBUXdOdW5sNFZVZHpvaUFOTHBQUk00SU92dmlUWHhKUVR6?=
 =?utf-8?B?emY5TnptMHRxQ3dpb2VmVlIzTXJhZFVBODBnRFVlU0srZWV6UlVEcUN1NDlk?=
 =?utf-8?B?NjV3S3QwSk5Dd1NoMWsrS0xYbDBSQm1BUVJBNTdHdkxVaTYyczE0czVKdDFj?=
 =?utf-8?B?clF2ZE5Jd2VLelFJZGUyQ0NHcG1MVDhoaFlKZTVzM1dLcUFFcVcrUWlWNzVH?=
 =?utf-8?B?Ty9zSXlKd3F2d3ZWZWRhSG8rMDQ2Y3czM09YakRNUzhLd2dkZW53WFRxaXNC?=
 =?utf-8?B?S3dpdWhwOVB0MXMzbzVVM1hyNm5rZXZ1eXhjTTRSVG1LU21ONnBqODA2Zk1m?=
 =?utf-8?B?L1BudGhmT2xBV0IvdE5nVVZEcjFjMjQ4UDlXQmdrWVJ3NlBTUXpxRllXdk1T?=
 =?utf-8?B?NWEzblkwbXRhVEFxM2NLQzdZM1daZnV5YWgrMGhyK2sxNGQ2d0g0NFMrOEZG?=
 =?utf-8?B?Ry9iQ01xejNxeFMySFB2b1BjalF4aDBXZk5VQy9XamN0a1gvcXhVbzVoL3Vu?=
 =?utf-8?B?UGs2NkUrOGhUNU9RZklHZFdzSVBocFcxSU9FZ1hJWDVWZ05aUUp3YitwYUVQ?=
 =?utf-8?B?eWdPN2pIdHhLZDFTRDZSdXE5MmtnRnBLcEdTRGpjcmdhR3hjR3psbURpZ0Nz?=
 =?utf-8?B?Y285OUpOUk1IT2VuRlRUN1Y2RzE0WElzNk5aekRHVHVKVDVlTHlNRmdOYnF3?=
 =?utf-8?B?WE9IZWRqYzlTQmRWc0RRcnpXSWR3R1hHVmxITUNJNnN2cVFyR0tLR2pIWHdH?=
 =?utf-8?B?Nlo0KzZoTWoyQVQ2RDVlMnErOTkzYTI2VkRRTUtveExzaTVHQWdkUXptOFpE?=
 =?utf-8?B?ajV1dTVuTXQ5UG1hZ0kzaDdIdktIUGlTSTVNZUVYUnFiaG92NWxINGN0bjFm?=
 =?utf-8?B?Z2p3eDIxOUlpeTBlR2orSkdIci9rTDVFZFlKdGNDMnFpaWt2T0kzbS9lb2xJ?=
 =?utf-8?B?cFhBYmV4Yk95d3ZNb0xCVU5PY1BrcGVxNTNKRU12WUptRm5QR01IRy9scndn?=
 =?utf-8?B?Wjd4dWw5VVI5eHgySlRNQ3lWZDJsbXI3dmpwUDlqSE1TaW1WeGxwdUZNT2pC?=
 =?utf-8?Q?F9aZy12LOo8fT3YWNapQMt8zJ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03edeb5e-10fd-4a8e-137d-08dc80ea818f
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2024 20:53:06.5460 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QaO0pJVFZRt33Wij+WoRKwIgfP2gdUIn/N+Haj8s2D8l/HQ+XJgYQ3T7TLJ+Y73tdQTMaUIczoEWxMuZ3CmDGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8460
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

On 2024-05-29 23:49, Jesse Zhang wrote:
> The varible uncached  set false, the condition uncached cannot be true.
> So remove the dead code, mapping flags will set the flag AMDGPU_VM_MTYPE_UC in else.
>
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>

Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 5 +----
>   1 file changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index 407636a68814..bd9c2921e0dc 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -1171,7 +1171,6 @@ svm_range_get_pte_flags(struct kfd_node *node,
>   	bool snoop = (domain != SVM_RANGE_VRAM_DOMAIN);
>   	bool coherent = flags & (KFD_IOCTL_SVM_FLAG_COHERENT | KFD_IOCTL_SVM_FLAG_EXT_COHERENT);
>   	bool ext_coherent = flags & KFD_IOCTL_SVM_FLAG_EXT_COHERENT;
> -	bool uncached = false; /*flags & KFD_IOCTL_SVM_FLAG_UNCACHED;*/
>   	unsigned int mtype_local;
>   
>   	if (domain == SVM_RANGE_VRAM_DOMAIN)
> @@ -1220,9 +1219,7 @@ svm_range_get_pte_flags(struct kfd_node *node,
>   			mtype_local = amdgpu_mtype_local == 1 ? AMDGPU_VM_MTYPE_NC :
>   				amdgpu_mtype_local == 2 ? AMDGPU_VM_MTYPE_CC : AMDGPU_VM_MTYPE_RW;
>   		snoop = true;
> -		if (uncached) {
> -			mapping_flags |= AMDGPU_VM_MTYPE_UC;
> -		} else if (domain == SVM_RANGE_VRAM_DOMAIN) {
> +		if (domain == SVM_RANGE_VRAM_DOMAIN) {
>   			/* local HBM region close to partition */
>   			if (bo_node->adev == node->adev &&
>   			    (!bo_node->xcp || !node->xcp || bo_node->xcp->mem_id == node->xcp->mem_id))
