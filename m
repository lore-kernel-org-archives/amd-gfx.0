Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 318CAD44148
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Nov 2024 12:22:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A5EFF10E2A6;
	Tue, 19 Nov 2024 12:22:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="REcFuR8b";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2062.outbound.protection.outlook.com [40.107.94.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7D5F610E2A6
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Nov 2024 12:22:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rd3p5y/q55sRkx+hWkbt00LuPap8BYkc08n2mhpPz0NlBO+woFdCGtd1DNMVLYlvUdE62weQX8wisdc6OygYdXtdLZMDnAE5XcVqFFCBsrzvtgHRUKZPrPjrufYnE6Rmeberr03L0nE4s7OvkE3ysrtHssT1rTJsUmmkS0hgInXR0zLS8AISvaLYPJUKng/Kg+zFnEl0OvemH3wYVzPlLspJ0t6fwWaxyKzWLnfA1vudhNrBh10hqIZyR1YeXO//7DbdYAfrZkpOTeN2HkGPDD++kNfZ4QjmF9stohNvSyXKWqP7bWm7vRW/ncJiLTX9dz4xQPPg6DG2eQwDSQfDgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1ijow4EMOzztlMMtaVoKWZo4DVVATIQo4+O19TUNPWI=;
 b=tNgUSOTOQOyxu/h7Nl+wBpwEcgfZKNiZZtI1iWCCtGIvwYDonDc0r/q77R5UBq9u2pzLJ3I0IIDKVXV3LiEOEK8dJ+4tlUc+o6lrfbQpdN3aqICFJEqWB0YrwWC3gzibPssirXV7bIdc/A5X6c5eZOH4A+HhI3Vy3B3IVaMxzT1BMQ2PNQo+jMIHwVuOKsHjoiQ+pQ2ibBEe/ELvxChXZQxwr8ZtXAhOueeD7XW2aLlGCQizkicfz3RHV1nYYhqsU3gBOJdmbNnU66tBtk7FckHEj+Ke1vsmYBbYQGTK6C9zV+5WBCkfgyYOofMi3pqFYxztt/XP6LFArwCVighBYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1ijow4EMOzztlMMtaVoKWZo4DVVATIQo4+O19TUNPWI=;
 b=REcFuR8bw20gTkVF/CQjDYkjUxrxUpC86lVTNo2wEPyUPkYWjn+UAfxaiRPAAyQTBteHlqsE464ukK/sOtIhLdmrUYtcWLEwyViKDcwIuO8Ub2FM2FQtUnqJh/Il4ZC+nsCL2GiRJb44oUPy91Bey55Yyt3Oox39EyFmQQgGBy8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 BL3PR12MB6545.namprd12.prod.outlook.com (2603:10b6:208:38c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.15; Tue, 19 Nov
 2024 12:22:26 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%7]) with mapi id 15.20.8182.013; Tue, 19 Nov 2024
 12:22:26 +0000
Message-ID: <8a6f8b0a-96fc-4ef0-812a-04bd129a5232@amd.com>
Date: Tue, 19 Nov 2024 17:52:18 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu/vcn: reset fw_shared when VCPU buffers
 corrupted on vcn v4.0.3
To: Xiang Liu <xiang.liu@amd.com>, amd-gfx@lists.freedesktop.org,
 alexander.deucher@amd.com, christian.koenig@amd.com, leo.liu@amd.com,
 hawking.zhang@amd.com
Cc: david.wu3@amd.com
References: <20241118094737.1024533-1-xiang.liu@amd.com>
 <20241119105739.1047372-1-xiang.liu@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20241119105739.1047372-1-xiang.liu@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0127.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:6::12) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|BL3PR12MB6545:EE_
X-MS-Office365-Filtering-Correlation-Id: 614875a1-1912-4f38-7111-08dd0894d3b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?R1BDUG91SUJaNWFTcVk1R0JHVUluNnkxNHFCQTM0OFAvYTJCWTZCNE1tKzBS?=
 =?utf-8?B?dWx2SE1WSldqU2dCTnlic1EvQ0JaQ29QL3pzM0pQcytmZ0puWmNkeWx0TllB?=
 =?utf-8?B?bU1lVmc3YzJHMGZUTi9Gc1ZkU2E3cHBzc3VpRmloUFcrK1owRGx3MFVMUHFi?=
 =?utf-8?B?T3BTM2RURm12Z1dZbElueVQzcTBlRlRnVTBNV1I1SFA3WXpiM0QrY1pCSkw0?=
 =?utf-8?B?Mm96cHpoVjJUZVBseFdaaTdQL0FncjRCSVFVUjFybUc2TVZvT0JmNTYvZ01M?=
 =?utf-8?B?eUFsSElPaGRnTnRxTHBaZ2pEMWxzL0NUajUxOFJhbUFUTGwxeW9oOFA5ZzA5?=
 =?utf-8?B?bVMwd0h6czNrTGduUUY5QkpvUjgvNEdjalhVWG9tNGlXMmVtQ2lnYTVIeE8r?=
 =?utf-8?B?aXUxS0FhVThUd0FVWVE0TmszYWxDeXhRN1NHUWo1NzVuUXpXaG9mT0Y0WFZo?=
 =?utf-8?B?NERnSEprb0tYSHBhQUowb3B4RXIvZUczVEViTFJWZW00bE9IZThTVkFSZE9y?=
 =?utf-8?B?Rk1MbG4yM2Q0N3A2WVBTM0pEUnlHdWYrbGxQT0M2UG9Hb1lnb3RZZElsVFln?=
 =?utf-8?B?OHlwU2xkZzJBR21rUWdVU0J2SFI0aSszcnNIUGYwOStvVjUwMEF3VDZjT2VU?=
 =?utf-8?B?UXRoNFlKTWxCLzk5dHFFQ05Sc1pRMXBLZEo5OXFybkZ2RlhnTTBHNjY2ODlN?=
 =?utf-8?B?VUY4V29IVzJhUG5ubUNOaDRJcXB5WllzdjBZczViZEh4TU9ubG00c1hmTFZX?=
 =?utf-8?B?K3JUV28xckp4ZG9qUEoyemd0R3gwcUxjYXlZRm4vVWh6NUthbm9pa0F3dDhD?=
 =?utf-8?B?amR0VSs5eGRUdXBodEl6c2xzejVDdkxsV0pYT1JZRVdTSjFsY1hLbkZpNlZy?=
 =?utf-8?B?Yng3STdsRDAvWFMvREcxaW1uNnU4MW1YZUxFTzd6VVE3ZWREUUZkekVNZnhE?=
 =?utf-8?B?c1ZhNjVTM3ZjVTltbmozUmZtRkY3bkVmWm5HRU5keEVpWmo0UEN6cFgyais3?=
 =?utf-8?B?cTlneWJiQ3JZYm9TZkRXN1c0Z0REekdaTlpTSjhWcStheU44WUNvN3h1ZWxC?=
 =?utf-8?B?WG1jQm1LNEVQYWxwTnZlUEJzM3RuTTBkdjFHaXVMQ1o5cEZZQXdrL01LVDlt?=
 =?utf-8?B?Ynl1RTFhSFBIOTduV2RmUmJtN0RaVzR5aFFFS214aFBCM3gxU2NObGZ1WVNo?=
 =?utf-8?B?WHpSUUozbXJSRWZzM2tHV1ZpUFRLaFdPY1JiUE9VVlRxcm1NQUY1VnpwY0tp?=
 =?utf-8?B?VVVDWXFwYm12U1FPaGNjUjFpRXhOSmpCN3NOMDdwVVJGY3Y2NEoweEYyQkV1?=
 =?utf-8?B?YnYvNVFRUWhydlRKUFRNSCtaRTcwUVN2TVF3UFRCdlZsRWdPZWVIL0FvTjQ5?=
 =?utf-8?B?MzFucnJhZzBNdCtoUDA0a2x0dzBEZlk1NS9iUVdHRC91cnFiVDU5YVF5cWZo?=
 =?utf-8?B?cEtseGRoRnl4RWdCZW9xTU1PWkhuQ2hhbER4TVc5RkpFOTdrbmRSWGR6RldD?=
 =?utf-8?B?aGptSFFJczRrMmdNbW9FVXRodlF6K0dIK0xWYW1zV0g1Z21LY2Q3QnpyZitn?=
 =?utf-8?B?OG9WSFZWZ2FZOGhkNE9UbTZVNEs1eXROWXA1ZnR3SldqTXZ6dnFncXAxaXhz?=
 =?utf-8?B?MVlmbVltTGRkQkxlcTdtMjUrbVk2ckdnNkQwbkl2K0x3MksxYUdIZlJRUEpZ?=
 =?utf-8?B?dGhQWUNybzFiak5TcXRueFZIVlpHcTl0ZHV0WE8ydGhCeWVmYmFjMlA5aHZx?=
 =?utf-8?Q?/BgazlEtFpQpXfNLH4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cXpiS3JuQkdhaXdmUjJDbDA5VVM0K25ReGg3cTFUZFhpanhxcTBEelR3RXVS?=
 =?utf-8?B?VDBkWlJFczBNOFhFcTBad0tuM0Q5T0NqMHN3cXE4UjFxWEhvSHprWHJQMStm?=
 =?utf-8?B?cEI2VWFhOFZkejVuMVc1Q0ZleHhUYjgwd1FUak5tdHREbFErZEdvdUxHZ2Rk?=
 =?utf-8?B?M01yNmU5SW5JbUp6THRhYlgwU3lxSVk2dzVTd2ZnYzdhWnpKOE1IcEU0cDE1?=
 =?utf-8?B?alVReVRMRjJoUkExQXROY0VoeVRuVS85NGsvOGpFSWttUmc5ai94Qk9UeGRU?=
 =?utf-8?B?RC90UlIxQjV1cm1nbzFSS2wxTFlOSHJxSllncE5wSVZmWmlubi9kYk9BZGcv?=
 =?utf-8?B?UUU4Y1YzdEdVMVdxV2huam5IRm11WHg5Y1BZY2wvVU5TQTBPYUNMdmZRQWQ4?=
 =?utf-8?B?NzBCN2lRWkxnMGhJQ0J6RTFrNzJFSkJBcU04N05PdjgvSVh2YmdCd0JJUkZP?=
 =?utf-8?B?SmREWDdzOEFQaTAwWHIyOU0xTkdoY1pzdFVIaDhUdC9EdnV1cDNQL0NGQy85?=
 =?utf-8?B?RTBPVGFiSTg2SmxLTmtRdzJzYSt0ZWU5VzVQU2crV2QwbktaVkNjTUNubys2?=
 =?utf-8?B?d1R1ZEl0SmxIcjlmVFZHU1hjVDYyb2FvSXN6MmZXSFRNbnUrbTBFU3QwTm9v?=
 =?utf-8?B?cjlvTGV2bGYwVnhKdWYvR3M5V3FmNlVhdFZVMEFKZkU4cjVseXB2MGpMNlRM?=
 =?utf-8?B?S3gxamZTaTZLK01CYlJLaFhkSFVKT21pR2FXcFlid3NzRENSRDNYTEdOZlJ4?=
 =?utf-8?B?TmlFN0FpZzdGa3lLMm5wSlo1RlZZSk1OSERIZmxleVBldVF4cXZNRENGOTJw?=
 =?utf-8?B?UlJWZ29YKzc5a3R5U1h3WUlDYk9sRDVxMlQyKzhKZXVFRXJTMDltM2ZULzd2?=
 =?utf-8?B?Qk5CRFlhdTltaDZSVFA3dU1waDdsNG93eEdmSU9Cdzc2SEIvQ0ZmSjUvVEg5?=
 =?utf-8?B?ellOYTR1em90cWdnUXBRVUJUeldWK0M5MDl3L3lwU3VSc3BaUTlNQUJiblI5?=
 =?utf-8?B?dXdVbmlWSDBXdjZ5T2IyZDVrbzMyT0FXL2IvUkNJRzlNQzVtdXhQZHBqenMx?=
 =?utf-8?B?akZPYXQ3S2tHNGQyWWt0enB6UHJoMkZ6ZlMyVzEyTEdCYlFOdC8zclJPSFRu?=
 =?utf-8?B?bjczZm1DV3MyN21hc2ZRODZObjQ4VmRWR29sWks1eVNDcldRZFUwMFpwRmho?=
 =?utf-8?B?WC8vNVZIeUhpcS80VG0xbSs1QWJvR2dhaVVndng1SWZxTDZlSjZtcVRRTC85?=
 =?utf-8?B?S2NZTDVPdXNuMWo2aTF6NVQvZlJGSUZIdG0wWnBrUVJOcHZMSnBqVm1weDFa?=
 =?utf-8?B?b1crTkM1UzlmZVZvQ2xObUNnMTNXZ3RxTEpsTkpDREtqa0R5dGFMam5rSUNy?=
 =?utf-8?B?RjREUENqbm1aZEZIM01zYk5VM3N5N0lZNmFOSkFqMEgvbXY1ZDYvd3l6M04v?=
 =?utf-8?B?K1k2RjNWdWtFUXhpaXFQMkN0LzZBcmNDWFJsODM2NFNnKzNacHVnZWdTRWNv?=
 =?utf-8?B?MnJhYTBEdUYrZDBudm05NUllaHNmc05lNWQ5c2I1aktRN3Nxc2JLTXpobUs2?=
 =?utf-8?B?QnROd01XdVAwUVZUcUlMMTlJNGMxTWlOcURtOURlb1dlV2FsK0VaTGhDMlcz?=
 =?utf-8?B?eXFRaHFncCtzMWxuYXliSHpzQkl1N0hucGdsMzVpcFlwM2R2dzVUdzQrOUV0?=
 =?utf-8?B?bVJOQks4OHduaE9SVGhqd0h2YXdzSmMvTzhrYTV2bm9hSGVMVVVDQkxlNnpy?=
 =?utf-8?B?a25HL1VIdzRITTN2NS9pWE12MEticUhqZ0FpdFU0UnZDLzZWeFc1UGcxOE9T?=
 =?utf-8?B?SGZBeEVoYUhzRmpiWE1Hckcwbk11eVkycGc5TEt6S0k3RjU2YXNWV0g0RzVm?=
 =?utf-8?B?NHhqdlp6V2JNT0NTSk9Hc3hodFhBQTJUOStWUmlSMVRKcTN4eGhxQ1ZZeWdZ?=
 =?utf-8?B?RXNaS2tpNzhlOHMvcG1yVGhDTWtQVVV1UUpwdU1TTW5uNWVrWGNVNUZzNG4r?=
 =?utf-8?B?M1NEb1N5aEE3Y1RoZnlkZXhhRmk2U3lENkROSXdWbS9QVzBaQjdBZmhsdGZv?=
 =?utf-8?B?NnFuNmNRM3dOam5KSWF0dHoxR2E1dzVWdWxra3lNMFFoR215Wjh2VGEwN0ln?=
 =?utf-8?Q?uF7rpZEJ3kUpkJnAj/fXKWI7J?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 614875a1-1912-4f38-7111-08dd0894d3b7
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2024 12:22:26.0023 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2xS2notKbp5zMJLB7xco0PGvKtJgo9GQHX2Q1ndSy01afrS+NaX5J7Dsk9FAZXyX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6545
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



On 11/19/2024 4:27 PM, Xiang Liu wrote:
> In the case of RAS err_event_athub, the VCPU buffers are corrupted and

For a better description -

It is not necessarily corrupted. When there is RAS fatal error, device
memory access is blocked. Hence vcpu bo cannot be saved to system memory
as in a regular suspend sequence before going for reset. In other full
device reset cases, that gets saved and restored during resume.

Thanks,
Lijo

> cannot be restored in amdgpu_vcn_resume(), the buffers are cleared to 0
> for good. However, the fw_shared stored in the buffers need to be reset
> , or the firmware cannot work properly.
> 
> v2: Remove redundant code like vcn_v4_0 did
> v2: Refine commit message
> 
> Signed-off-by: Xiang Liu <xiang.liu@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c | 32 ++++++++++++++++++-------
>  1 file changed, 23 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> index d011e4678ca1..cf8264bf45c5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> @@ -123,6 +123,20 @@ static int vcn_v4_0_3_early_init(struct amdgpu_ip_block *ip_block)
>  	return amdgpu_vcn_early_init(adev);
>  }
>  
> +static int vcn_v4_0_3_fw_shared_init(struct amdgpu_device *adev, int inst_idx)
> +{
> +	volatile struct amdgpu_vcn4_fw_shared *fw_shared;
> +
> +	fw_shared = adev->vcn.inst[inst_idx].fw_shared.cpu_addr;
> +	fw_shared->present_flag_0 = cpu_to_le32(AMDGPU_FW_SHARED_FLAG_0_UNIFIED_QUEUE);
> +	fw_shared->sq.is_enabled = 1;
> +
> +	if (amdgpu_vcnfw_log)
> +		amdgpu_vcn_fwlog_init(&adev->vcn.inst[inst_idx]);
> +
> +	return 0;
> +}
> +
>  /**
>   * vcn_v4_0_3_sw_init - sw init for VCN block
>   *
> @@ -155,8 +169,6 @@ static int vcn_v4_0_3_sw_init(struct amdgpu_ip_block *ip_block)
>  		return r;
>  
>  	for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
> -		volatile struct amdgpu_vcn4_fw_shared *fw_shared;
> -
>  		vcn_inst = GET_INST(VCN, i);
>  
>  		ring = &adev->vcn.inst[i].ring_enc[0];
> @@ -179,12 +191,7 @@ static int vcn_v4_0_3_sw_init(struct amdgpu_ip_block *ip_block)
>  		if (r)
>  			return r;
>  
> -		fw_shared = adev->vcn.inst[i].fw_shared.cpu_addr;
> -		fw_shared->present_flag_0 = cpu_to_le32(AMDGPU_FW_SHARED_FLAG_0_UNIFIED_QUEUE);
> -		fw_shared->sq.is_enabled = true;
> -
> -		if (amdgpu_vcnfw_log)
> -			amdgpu_vcn_fwlog_init(&adev->vcn.inst[i]);
> +		vcn_v4_0_3_fw_shared_init(adev, i);
>  	}
>  
>  	if (amdgpu_sriov_vf(adev)) {
> @@ -234,7 +241,7 @@ static int vcn_v4_0_3_sw_fini(struct amdgpu_ip_block *ip_block)
>  
>  			fw_shared = adev->vcn.inst[i].fw_shared.cpu_addr;
>  			fw_shared->present_flag_0 = 0;
> -			fw_shared->sq.is_enabled = cpu_to_le32(false);
> +			fw_shared->sq.is_enabled = 0;
>  		}
>  		drm_dev_exit(idx);
>  	}
> @@ -280,6 +287,8 @@ static int vcn_v4_0_3_hw_init(struct amdgpu_ip_block *ip_block)
>  		}
>  	} else {
>  		for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
> +			volatile struct amdgpu_vcn4_fw_shared *fw_shared;
> +
>  			vcn_inst = GET_INST(VCN, i);
>  			ring = &adev->vcn.inst[i].ring_enc[0];
>  
> @@ -303,6 +312,11 @@ static int vcn_v4_0_3_hw_init(struct amdgpu_ip_block *ip_block)
>  					regVCN_RB1_DB_CTRL);
>  			}
>  
> +			/* Re-init fw_shared when RAS err_event_athub corrupt the VCPU buffers */
> +			fw_shared = adev->vcn.inst[i].fw_shared.cpu_addr;
> +			if (!fw_shared->sq.is_enabled)
> +				vcn_v4_0_3_fw_shared_init(adev, i);
> +
>  			r = amdgpu_ring_test_helper(ring);
>  			if (r)
>  				return r;
