Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BCA1C7EE2A
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Jun 2025 22:12:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1D8ED10E7F8;
	Wed, 25 Jun 2025 22:12:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gu9BO5J6";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2064.outbound.protection.outlook.com [40.107.236.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 816E710E7F8
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Jun 2025 22:12:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cWdvNk+lYtjwOnO6PdUs/1XrtVcK97PhByDIW57hxYDQFbbLJ1GP4EeT9624QgPAs+S7PdtBrpIhqXw2rrouQgswUWbXwfJw3QGdzjZXv0SP8lPBJh5hSkm4sOchcYmHF595FMraezBpP50ZAUOn0wpaz/9cR/cHF/0aofO7E6bV9WqGbA9NNB7rQBPtDwQv2GxfW5QhtS4yYShzacBkgXgnr+wZPz+q1GuyJnEcuAzgCNshWBxuTEKyrr/gCSUPrfG/fy8YsaN/mmSFWRjMIMqVj+j0rP6FO0tIyYM1u0gndMIE6+e5rFA7l+VHPwWp0fv2okas96+4x1IvfZwi9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WseBKrOzegEzqdZKvxEBNmckxmQ7hGMR5ASDKbomfuk=;
 b=VJuPFYl4NdVM4BnMxvcz2u6fhXi2N/0+SdFOKRYi1iSu0gA0WCiTbC0NywTLkBAGzveR2gCCf0BrYRd6ME91sEofwOrSjhxxeiaKRDdimc62Ct7q3n70xtm0lIJOAY8Yq3GscQg4sG+vOATdagrEX9qxwcMYJBmSXrN1Torm5z7eLq1Nx7sSccxXxMfNAV3smXugxHva+fxUjR3fiVD9+zGvI6vIGSTKk8mmrQJPK0FO6ocxi/vs1fXT8WZQLSTMDlbho4mAGPCdi4UF+rISBBUjSn95X4mWJo79Hs1zJkfMetyp9755nTkJIRiChkil9efF27fnw+AuSz/nhhxqEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WseBKrOzegEzqdZKvxEBNmckxmQ7hGMR5ASDKbomfuk=;
 b=gu9BO5J6uBgUMneH7xTrZzM3ORm5IkXEdZRlFyhhh1idkMNrdNmObxr5xzDqgDrFuvzYY9xbjFGAAgH4lhdAM1rxTdlyqaAOg+kMNVwLkz8gq+4P3SpwsJj5akQ+UKneMlY1j5EYCuOcX6xTaipCW4AmE8q3V+cXTAMeY6KnYRE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5112.namprd12.prod.outlook.com (2603:10b6:208:316::16)
 by LV5PR12MB9825.namprd12.prod.outlook.com (2603:10b6:408:2ff::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.20; Wed, 25 Jun
 2025 22:12:32 +0000
Received: from BL1PR12MB5112.namprd12.prod.outlook.com
 ([fe80::4179:4c7f:76be:47d8]) by BL1PR12MB5112.namprd12.prod.outlook.com
 ([fe80::4179:4c7f:76be:47d8%6]) with mapi id 15.20.8857.019; Wed, 25 Jun 2025
 22:12:32 +0000
Message-ID: <77b1256f-4431-447a-9b9a-bf00c644f808@amd.com>
Date: Wed, 25 Jun 2025 18:12:30 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] amdkfd: MTYPE_UC for ext-coherent system memory
To: David Yat Sin <David.YatSin@amd.com>, Amber.Lin@amd.com,
 amd-gfx@lists.freedesktop.org
References: <20250619184035.1283782-1-David.YatSin@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20250619184035.1283782-1-David.YatSin@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0269.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:109::25) To BL1PR12MB5112.namprd12.prod.outlook.com
 (2603:10b6:208:316::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5112:EE_|LV5PR12MB9825:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c926cae-274b-4280-8bc7-08ddb43561a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?d0NtVU12c3BqNkJSamF5djNJZnU5YzJxVW5QNEdIT3puSkpHdUs1QVRuZ2VS?=
 =?utf-8?B?ZTBXWkZGamRET0F4STgxam9kWGhZOW5ucUtrQXhKb0RKenVFN1ZNU2xSNkRN?=
 =?utf-8?B?YitqWStub2JQWHBiaDdLMUhtMEw2dlM0eUkvNCtEZEZrb20zbGF0TEtWWmlP?=
 =?utf-8?B?M21vNUdjOE1QcjJacEhOVXIydWtNaDJLU0NRZ1YwajgrRFQyek5PeFdJd1Vx?=
 =?utf-8?B?c0FmTWovMHVmaGVvUFpac2dhME9VMVhOalNBQ0VOYVU1bE1jN0FCdGM2VUJE?=
 =?utf-8?B?T285T3VEZjEwV1Z3VVVmeE9YS1ZsYzFHQnA4M1doOGJySnVlSEpHL3M2K3FE?=
 =?utf-8?B?WndCVzdoOVl5anhwMkJDUi9pZjBCT2gvMm84MVZyWE8xTE82OG9DUzFlZjNa?=
 =?utf-8?B?OE1DcDNubE9sc0FqR2U0YWVFM1lEcFdHWEFqMEpONWdaUnNTNkliejRZU3lP?=
 =?utf-8?B?dXJ1R3ZYMElucXpnU1FrRnZJcVFUbUNqaXlVY3RMd2Zjb3VNM2NPZDBxenpS?=
 =?utf-8?B?RjZJek5iUWlHUUtrUXBuN0EyMUNhSlZWVXoyY3MzUE5JdHB4bEt3dmJMK1Ey?=
 =?utf-8?B?OW9rbkpNVjY1TVVTNktOTnk4K0NwckQxSXdtNnllWFhpWmxBdmhjY05lbG91?=
 =?utf-8?B?c0ZYbllDWU5GVjRRNmpWKzlIWVdaVkMvRHlGV0NTOVNJT0M0Y28rdWNBVWVC?=
 =?utf-8?B?azJRMHpIUzZ5MGNFZlhTWFlraE1zTHJ3a21wbzRMc2hhNys4bHJNU3R1NUhP?=
 =?utf-8?B?NWhrRk93ems3SmFrMkFMdFRZdGU2SytNakJ6aUM1OCs1SGpOa0swZ09RL3N6?=
 =?utf-8?B?N0Y4N1psZWgwWUgzeTZpcHJtdGpFeTRveHR5QTdMbEhJUG1adC9OUlVDbkh2?=
 =?utf-8?B?QzZpQmYyYVUrQ1FqUk8wQTFKd01ZNzBJa01UODlLMEtPelVPSHUwUHlWMVZj?=
 =?utf-8?B?NHRKN2NMRDRNUVRxTkVsY2lla3I2blRHRGRnRkp5am9PTFhFUmJRZU15ZFY4?=
 =?utf-8?B?S1pFL3BtbkY0YUZyaEZ4YjZ4RlBiZVgwWlcvTFp2WlFoTmhhcmZmMkp1eitU?=
 =?utf-8?B?OEsvNWxERm5NSUYxV05Td1doWWVIbkg0dDJoRUEzYnZpcm1UM3Y5MUdpS0VK?=
 =?utf-8?B?bERCQTlZaW0vbXR2Z1RZY25EMzBzYmRxR01sbjlqdXJRWEF4NUR4NSsyMmUw?=
 =?utf-8?B?R1BaR21hK3hTRzZvYnlKM2JQSzlpVEYzdXlmUTM4c2JjYm5qTDNVcXY3SVZF?=
 =?utf-8?B?NUU2TlNlZ3g3emt0THRUcXJhN1pzUm8ySmNhNHNYL0FOMVI4NWxhTHp2ZTZ3?=
 =?utf-8?B?bzRhUEhZcHE2UlY2Nm5IczFTdElPWGc1RnhmdHliNXBpSDcvcWF1R3BUWmR2?=
 =?utf-8?B?M3FFTjkrQ3JIcUlQRmtiQmtoa0hnM1NXQlZ6TkI1UnRuTGJ3cDc0UHFzSzJZ?=
 =?utf-8?B?SzlhOTZVdXkzTDdKd05LbXRaeXlWNmJ3bnJTVXozaWlXN3dVa1BhSFVaaVJ3?=
 =?utf-8?B?U3FnT25UampCZ2wzMjRGa2xkeGIrS1NqN1VoZEJUeGtjb00vVVJEOGl3clhW?=
 =?utf-8?B?QnM2bW94S0E4NzB4TEFia0NPZUt6ZUttWVRtUkFVOXRMNEFIWG95LzhteE5u?=
 =?utf-8?B?cnZSdE50aFZVSTdnM0dwRWh4M2tjQUJBNjhtZjFoSlNDdHVUT0ZpRzIxNDR5?=
 =?utf-8?B?Y1R2MThIYU1HdlA2cVhnQjJFQmpQeUpuQ004S0tvVlZXYjZQQ2pSaTJBTlhh?=
 =?utf-8?B?dlR2VDNBVDF0Q3pmczdDL0MxU0N4R2RmNzhveW5ISzFBcmk1T1VVWlhiTHpS?=
 =?utf-8?B?dE1zYU9SMUx6OTE3L01XY29kN0dxaVZyYURUWDdkZWVEVlY5aytKeDFqWlY2?=
 =?utf-8?B?bzlScGZoMWdjZVAzUmZ2QjRxY1VQSEQyczRGQlZZeS9PaG1YNjk3SUZKQjFv?=
 =?utf-8?Q?E9aKTxchkds=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5112.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q09ibTE1aE5hcDBWZ0trYlhWMGRqSHQwWTE2cWZuRHQzc21YallqYm5JVW9h?=
 =?utf-8?B?enNzelpJZmlNUXVxb0Ezcng5Z2krU0grWG9uckg2Yjhkb0l0RDBNWTdlVkcy?=
 =?utf-8?B?eUxKSmIydEd4NGJ3aWc2UmtMMXQ4NVdYc1U0UFUyTGliMHpqT3Z3emR2TTds?=
 =?utf-8?B?MHg0TDBnZ1JzU0EvTStQbVJ4QUk5ZjZmQldQM0FTeE5VMjFyYVZwSWJ0N1kx?=
 =?utf-8?B?VDNKc2VwMFJSZVlyV21PWDd1MjRjZDJWN3NqWjdCWUFLeitmYnlJd0JzaHEr?=
 =?utf-8?B?NFpGSGVuNUQ3K0tEMEVwM1NSTVloT0R3alJKbURacDBENTcyeDhOWklVelBT?=
 =?utf-8?B?S0M3QWhVMkFMWnJkQmwyMGdVa2U0RzR3NVVPOXJ4dlpDZ09PY0xEdDl5ZHlY?=
 =?utf-8?B?RlMvaWdwUGF2UjRxNE8zSTBSNUtxejBsL1QxZUFFd2FSRk1OL3RrMS9mclFl?=
 =?utf-8?B?UG16aDdjeE5JOFBpYm5DZVBtVG0zREpPbEhzeGtnbS9NajczZU1VSEZPM2lm?=
 =?utf-8?B?NWU2OTY5bTM2YWlOMEFGT1c2OENHV0YxRTJacU5BMTE0ZjlHdlZqY0JSMGg5?=
 =?utf-8?B?K3lzaS85YXdaVU1kVDZOMWd6bHh0WXdvNXVDS1BvWnRCWjloQ0czbXFSdjAy?=
 =?utf-8?B?dmxPS2N3SUJROVM4S0RMVHRPMURKOXU1eUZYbS8yd0tOdWxzb1B1dUxQTmhl?=
 =?utf-8?B?ajRYdDg0aFlPNG94Q2pLS2tWNmgzbExHamhsYXdpSFZURyt1TUdPQWZWUk93?=
 =?utf-8?B?STJVYVRMekFGNXdiejBXQzkrYUxET3crUXdLWmFsMDQ0YURQU1Z1RzM5ZXds?=
 =?utf-8?B?cGQ0RHRBYnFvVjB0NVF1STRhTjR6Y3UwSDlqQ1dvbzlkSE9HQTJiY3Q5MzRT?=
 =?utf-8?B?VUlRUFZHWTNTWGR6Z1FwSVREYk5nRVA3WUwxQno2d2Zuanl1MEJkSFNmaVZn?=
 =?utf-8?B?QWhQVzZXaUVmWk0vM3BCbFVma0wrb0M1ejZweUI2SlFmNkRkZ05sMStncmNK?=
 =?utf-8?B?Y1NidFNEMkcveW0zaEF1Q2VoMDl5TU5DRE5Ya0xsQ2MwZUxGV2tGN29NRGoy?=
 =?utf-8?B?VmQ0bVlBMXFIN3JXNEJIUEgvalJWaW5adWlpQ3hBUHRidnM0MDU0MFRjLy9n?=
 =?utf-8?B?S1VoT084SzI2cjZ2dGdRZ1k5bGtoRXZIazN1anZBMFdzNDVUS1M0cTFpTU9R?=
 =?utf-8?B?cTdZbUs5MWZWRWM4b0ZFTzk3c0Jvc1pKTXB1eDFKTTNrakc1WG1uMHF6SlpX?=
 =?utf-8?B?ZWpZaFdxZW8xQXFidFNTYWZJdzlZYkFCVUFMQ3BhT1IyTDgwZk9mdzhSaW13?=
 =?utf-8?B?Z1JlMi93MEVsVE1WYVdWY24weXM2eVZ6My9NTE51eTFtVlVXR1hJNmdwYXFv?=
 =?utf-8?B?UG0vOTdWZmY3NEhvREJxSUN2MTVabkp1dXRxSFVqcnVtTFlCWnRoRmhhV0I4?=
 =?utf-8?B?ZkJnZU9HdXVBd1JXZDBJRFhEQ1JHWmx5T3R3b2x3UGNzY3cwTUVRaUdOSndt?=
 =?utf-8?B?Znlsb241alBtZk03V2hnZ3JZV0U0Y0RrbkptSXBlVmtHOTQyRXdqSElDcFNt?=
 =?utf-8?B?cmo2N1BrR3lKL0M2NFFrY3NGTVhySFhiWm5Vd0FBR2xET1Y1dWQ3L1VFQWFU?=
 =?utf-8?B?ZUd0UFg2cDkzUFJGSDlNNEEvQ29aZWNZMXZzbW1BYTdMUkVFcWplOVYvYlZL?=
 =?utf-8?B?SExabEhGdGlzcVEzdk91aDBWMGxvYzBzbEZadUt5d2xONms1NXlnbnZtN1NE?=
 =?utf-8?B?MkRQa29YNXZzRUdxS200Y2o3YWt0SzRwR3NYWWFxU0JNV2lXZENhVXBvTC8v?=
 =?utf-8?B?ai93eEE2UDUvZURENlRMYTR3VnByMFVvcUsrczNMazhwQmw5TTZKdWZkVHVY?=
 =?utf-8?B?TGFiQ1hJaU9pUFk4VG1tRnU3bHlOOUJHdnVtQUVyNWxGemFId1FCeE9wWVB5?=
 =?utf-8?B?cWd0TW0yak94ZlZVNjV0ZTVFanlzMHNwVVF4SjlBZ2wrYzZwU1pBODZVcWts?=
 =?utf-8?B?WWhWMmhYV1RlTVg2TmowcUl1OHBFNUh0MEMva3hINlBHanVNSTZCTndQR08x?=
 =?utf-8?B?L1d2aDdVNWxMakN5SWlpN3FvNDNzSzJiNHYybmJnaXpIOVJNR2JvUENkUE0w?=
 =?utf-8?Q?bcjo5SskmgqB4fmfKmS6DSSNz?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c926cae-274b-4280-8bc7-08ddb43561a8
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5112.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2025 22:12:32.5048 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KpGBzhK0jWzI70u4pqlH/v6fY/OFRMAW0egDVJ33sOrIpDUp4vXSxXPlzYBQbh8Z83JXKNgLnSNSK7KbEcJpNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV5PR12MB9825
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


On 2025-06-19 14:40, David Yat Sin wrote:
> Set memory mtype to UC host memory when ext-coherent
> flag is set and memory is registered as a SVM allocation.
>
> Signed-off-by: David Yat Sin <David.YatSin@amd.com>

Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index 16fb19800f9e..9dba0e4ae4b3 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -1282,7 +1282,7 @@ svm_range_get_pte_flags(struct kfd_node *node,
>   				mapping_flags |= ext_coherent ? AMDGPU_VM_MTYPE_UC : AMDGPU_VM_MTYPE_NC;
>   		/* system memory accessed by the dGPU */
>   		} else {
> -			if (gc_ip_version < IP_VERSION(9, 5, 0))
> +			if (gc_ip_version < IP_VERSION(9, 5, 0) || ext_coherent)
>   				mapping_flags |= AMDGPU_VM_MTYPE_UC;
>   			else
>   				mapping_flags |= AMDGPU_VM_MTYPE_NC;
