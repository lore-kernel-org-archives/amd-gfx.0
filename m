Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E12DC021B8
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Mar 2025 20:52:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DCE7610E6B2;
	Tue,  4 Mar 2025 20:52:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WLHZrrhP";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2068.outbound.protection.outlook.com [40.107.94.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 309BC10E6B9
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Mar 2025 20:52:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=du39ZocaakEAsXvS3gajNbyA7b4yxsSGsJNCBhqboapc+AA/0rKoLtrKq4J5jHk15RBzivvTH7LOtGL9543W7FMAhHw6DaxN5U8WVfnhWEhUveDBmqvy6AATVMpO9P4TLbhhCDvY1hGUps+T/flVKKmDV/LaYwMS0kJCXvc+kyYieKMOjiL1VkybA/OUl6ppFO1+54I9nlQHInE93UytfZwwv/lHXt0+VFcZzgOSgQ2VgwINm0ogrrFOCsWOpE+c5qjEzxXp3/9jhaehG9SHBJOEQ2IxGdn4+UrK8eqRLAUREjHtkQmRN81JEeYbcgJjJ+32i7a/pdDKzLVqer3F+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WwZq+8N1oMDyS0SzB+OjL+A5+v+VI2rXd2PMhS4RRaY=;
 b=dfElXhSOfae3QWMnLI9Z7cJtzheHx4OW3YoSBrXxlZzC+BTl0QH3ODbi3+aToCyD8rdL5VKUAk8HG/prywxZqVnR95yYQPQrOODnquhD8WI4C8pQjlMytP0oGA9l5OA7WRBw3SUrZ+gvIs6Yz8YOBIll4fquUEiV+5z7xpRCrdmaJieaB0Licp4vonDDa1EnfUNSEpbMKcc4dS5cdz1BcKx7rC8n9QC78MAFFzdDFFBOQUrh6K7ot9odBMpKbC+DOGhQUuLgwTEMC6WKVfs92IAbmcYpb5z0Xlf+y2LIccbx1b0S6jMSaw9UIwh529BmH17Okd8n3RQpkwzsOlRORQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WwZq+8N1oMDyS0SzB+OjL+A5+v+VI2rXd2PMhS4RRaY=;
 b=WLHZrrhPQ3v1nzYfFsRxvlcZcJ6RpIFY8tXqcFvJTemIOgEuLIX2GAup6WthhbnYlpYy1Ka4PITjudTfDtEPEaNvg51Wq9Ejf2Zqe/9hyTUvs44GNBG4I2GLlFyyIgyDLM4M6+Jo7ttXmnFs2Obn6wvVuB/0ytULl4yUnAAHvV4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA0PR12MB7507.namprd12.prod.outlook.com (2603:10b6:208:441::13)
 by SJ0PR12MB8139.namprd12.prod.outlook.com (2603:10b6:a03:4e8::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.25; Tue, 4 Mar
 2025 20:52:25 +0000
Received: from IA0PR12MB7507.namprd12.prod.outlook.com
 ([fe80::4ee4:3253:28fb:550b]) by IA0PR12MB7507.namprd12.prod.outlook.com
 ([fe80::4ee4:3253:28fb:550b%3]) with mapi id 15.20.8511.015; Tue, 4 Mar 2025
 20:52:25 +0000
Message-ID: <0358291a-7744-4e91-9442-3dd9f999d4d0@amd.com>
Date: Tue, 4 Mar 2025 15:52:23 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu/vcn: fix idle work handler for VCN 2.5
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20250304162242.4029795-1-alexander.deucher@amd.com>
Content-Language: en-US
From: Boyuan Zhang <Boyuan.Zhang@amd.com>
In-Reply-To: <20250304162242.4029795-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0053.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:88::10) To IA0PR12MB7507.namprd12.prod.outlook.com
 (2603:10b6:208:441::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR12MB7507:EE_|SJ0PR12MB8139:EE_
X-MS-Office365-Filtering-Correlation-Id: 146be537-3017-4ab8-d005-08dd5b5e77f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Z2R6TW1sZUpMYmZVYS9qbDdFWFJJSTg5MWNFMjRkcFB3dk1KaE90OEp2QnZr?=
 =?utf-8?B?WXdwRzg3djROYjRRcXUvU3ZRTURSMHNzbVZBWDdLNktHQzA3YzR6amFIQVJz?=
 =?utf-8?B?ZXJNRU1qVnhKNngwelhxWFFKRjdMdE12LytMMTB4V2N4TTNyUjhuMTVYaVpl?=
 =?utf-8?B?RERlOTRvUmI3NFNHWXIxeWdFejkwa2VHY2tEZWR3UFp3eUFVbFgwLzBONitu?=
 =?utf-8?B?VUZFSTcyUUtyeGdhamdOazl2SzZyN3A2aFRnSWpmcFNSbDJVSlpHcmYxV2k3?=
 =?utf-8?B?M1VybXZRM0JVUjFyaDA1WkIwRHJLdXhaa292ajRIdDBIbGtyYkJmb1NtYjlT?=
 =?utf-8?B?NGllQ21ldGMxNkczTU94anpGM25FTGlrMTlLZm1CblE4VjdJU3FsVGlVOE5W?=
 =?utf-8?B?Y25BdUk3NVhqUXdOelF0YnFyWnV4VnVIaTNlYkE4cmpXeWxrK1RVUXFJbmZo?=
 =?utf-8?B?aUtqVktqWVNTWHZjakg1bDY5TjBlcXhzblkvWUE5bjNaTzhXOWk4NlRrcGR6?=
 =?utf-8?B?RnhtcUs3dTZzMjk0SURwZys1Z2hwc0lIdnRIWkR1VTNwNldKSjdmYnF1Uk9L?=
 =?utf-8?B?ZzEvdGRLTk5hUHV6Ny81aVBXZ1poUVAwUlFSN2xpbkhEREdmWU5pMEVpTWlm?=
 =?utf-8?B?OFBwUVhUeVVmNlF0YkxUaVBRWjJqdWFTT2w4d2FrblcwZkkxL1hEN2VHL255?=
 =?utf-8?B?Y2ZXRDk1UHR4VVl1bnUvQnNkQVVQSGFnbm5FNzdqb3YyeE02QWZ0NEhuRlNH?=
 =?utf-8?B?ZGxuMmV1eHpPVVJkSnV5ZDhiRW5nWUtJQzIzdEJpV2w0dTFnZnpvOHk5MVJF?=
 =?utf-8?B?aUVBanRybUpPaTlWTTdXNlRPOUFTaWFFbjFnT3MzTDhGZUZibzFBODgxcENh?=
 =?utf-8?B?RXZhQmlyTnQ2SThHUUY0cDdzM05tRlJrelkzRERXVWdHTG1YRFR3Wmx6SzYy?=
 =?utf-8?B?T2JJVHp5VlYyUkRzeEdjaXl4OHlDL0VHTkx1N0JPS2lxYmgxb0VUc1UxWnIw?=
 =?utf-8?B?YktTbis0TzZMNzFSam5rSWVrcVNNeXBUbVQ1VHNoWWM3SEUyT0xKQklMbzhJ?=
 =?utf-8?B?VDBzTTVLQXQ2OFlsMm50aDExWFV4OVllS3h0TXFMQkRkSGI4ZzdrRkpLZWhN?=
 =?utf-8?B?V3VDeGc2UE9ZbnpTOEdWYXduOXVRTnF2OGx5dVYwL1YrODExdm54WXJITFQ5?=
 =?utf-8?B?bmZjMTNqYTBxckhUaGtaaEhYYXBJMWNOcFAvS3pFa2pFYkpPTkhiQXBLOTBr?=
 =?utf-8?B?UFpheTVsNzI2NnpPdTRHbzBWSk1CRnFpaUhNYW1Eamcya0NYMXFHOHEwT2tl?=
 =?utf-8?B?QUpwZkp5dGh5YzlEdXJ2cFNKbVBWWmh5VEtBVFVrb2libVlLSVZndFQ3L21L?=
 =?utf-8?B?bTdaVkpSRHdXeG9vT1RFMFZjbWZVcm1Ib0hRWE5FRlVjaDZPN2IvTEhUSWto?=
 =?utf-8?B?aHczOS9UR29ESjBkMHprZldmeFNpZ3N2SXFsdHVISVo4YlpmcHM0K3E1a0tV?=
 =?utf-8?B?SWZLZFh0R1I4MFFFMnZUVURTOE1GalJ5eHZnUC8wcTJxNHVlTXRRTEVPenE0?=
 =?utf-8?B?VWR2dDdHVGl0aEpZL2RrZnhXcWd4K1VvYnZiMDcwcHArR2t0azBzdkgxMFVS?=
 =?utf-8?B?clJwY3JlVWdhZkpEYVdhWCtNRzJzd0pHYU1RNUlyV2J6MGhkbE5rWGx0K0Fl?=
 =?utf-8?B?Y2M1QXdhdWtFY0haRjJFKzg5NFhGenc0Mjk4MWt1Y2QzeWx5WlJGNVJ5RWpL?=
 =?utf-8?B?WDZNNWc3T1QxeFNyN01BTjR4ZzlJZ2xoNGg0SWludG4xdUtGRVI1VmhEZDhz?=
 =?utf-8?Q?jdO3CScImF81HDB8RdbgxNNLeJ0vAmbNGWIlY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR12MB7507.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y3FwZU9aTjlFUU81ZUZWM2UyQXRoMmhuM2Y0WW9BL0ZKTi9MeDYxaDVlQ2dJ?=
 =?utf-8?B?b1pwN1h4dE5SeExhSTZ0aGxOTUZQdXFMT2gvOTh2R1BOQ0JJR2lVaytpZjgz?=
 =?utf-8?B?Sys1S250S2hGU00yRVg2a2dadmNvZFNrYzVjejhUNURpdllvZXNGUWdYbC9l?=
 =?utf-8?B?YnZ2ZHpmZ0JEc0ZxUzQ3T2s4VEhlUExaUFFPR0tPTUp4QTJRdXdxbEg0ODl4?=
 =?utf-8?B?ek9HWnI0bXc5MmNpTWEwNFRxYUs1VFNCMUc1RkZlblhNMUV3Kzhtcm1PREdq?=
 =?utf-8?B?YU1YTTVuT003b1NETm1hVDJtQUtpUnR2M3grNEdpMmFjOXRycjZqczhubnZo?=
 =?utf-8?B?RDhyS2RHeTZnYkF0YW50UEgxNTdaWlNxSjlJZkdrbFh5dERRVE5KRmVvY1hZ?=
 =?utf-8?B?Y1Fsb0Uzc1l5N1RkVDBTZnpWNE9lZE9NS2ZTMFFBcHVFN2tQZ1JhTEZHUDZ5?=
 =?utf-8?B?eDB2eXZpREl2NlNuWE8xYkJDUWE1bDFrcDZ6MUJxMnd4WlFrd3R3MmZJcWtF?=
 =?utf-8?B?eXMwVjhocWlEc1E5TVFjbStZalgvbi90b2VzT0htZER6cFFrclM1NnU5ck5Q?=
 =?utf-8?B?MmtpaC9mMFBTT2VuSk1uQWtzL0lUTmgzMFFqMkZRZ0RiUDhxYi82OGpqSWpT?=
 =?utf-8?B?SFhmVFdjeGNkSVp0S1ZzejF6SEpQM3FVNVdZMXB3UnFCaDFzbHBUSnY3ZkQx?=
 =?utf-8?B?WTVIRE9WREZYN2RuaDJKdUFRSU40WVdrZFFxeW9TT0Y0ek5xUzc4dVpqaGdT?=
 =?utf-8?B?ZU56R3ZLTDZXZ29zazQvYy9rdkRudC9ZZ2NUMHUrWlFpeGk0Wmdta2VwcmE5?=
 =?utf-8?B?a0preFcxcGFjd25TbnpnbWl1ZENRR2V5WGp5dDRnMnJDN3pTTTZ4bDVYbDRP?=
 =?utf-8?B?M0pURzNJazUySThsRXlSL2U5a1MxdkF3YlRmdWpUdVBzOHArU09MNTZ0bHAx?=
 =?utf-8?B?VFZLMHJTNzQwVisrR0lvTVhPeUR6Y0hjd1poMEt4b0VDVmwvalRpaWFTVUZq?=
 =?utf-8?B?enVIck5ESEhzWVdlaVg0ajdFRmNycUdMdUl0UVY2WjM4UDdFS3lSU2Q2V0Nk?=
 =?utf-8?B?czd4d09LNlJ4SCtZb0NnMHFrQjczMHpyekN3c3VvbXBvRDdGLzJzczZhZjZW?=
 =?utf-8?B?MDQyWXFQSTdZQk5LdU1DbEkyZzJHaWFIVjNRL3BQenFiSFQ2bSsyMGwyY0c4?=
 =?utf-8?B?NFVmdmhQZk4vdWpKZmlCOS9FbFk1SzZaM1gvQ2ZhRVpxYXp3UEpHSk5UUzB3?=
 =?utf-8?B?ekFmcENaSUJPZStJQzFZTFdNUmptVFZ4YXNYZC8xcnpQa09DVVVtQ29ObndN?=
 =?utf-8?B?T2VOdmN6VHdSV0dMRnkzWTNzSnJxZ2tyRXBBbjIxQk1HMm1mTmhha0dBcEw2?=
 =?utf-8?B?Y1JBZGZVOU5WcFlsMU9ncU02a0pUZHNma0xKM0o0cS9Zd1NoWnptbVJxQUxh?=
 =?utf-8?B?MDMyaUNLZ2JTYTBiaEc5ZE0xYzRpZ3pmaThmaTk2bUp2OHUxdURucmJZRGNL?=
 =?utf-8?B?L0RmbUlLNDlUQUo4Tk9sTzlnYUlTQmxwd0lvaktTZnN3WDVKTmlpQzIzUDQz?=
 =?utf-8?B?TzFqcHhGZm9BbDYwQ3ZhdTVOZEttVGM5UWZDakxSeHRmblZ2S1RZYjV2aVA0?=
 =?utf-8?B?eGZhdE5CZ3pqenR6U0NzY2JNUDJnSEp4N09YNW4ydU1OQW56dDI2d2JTRm5P?=
 =?utf-8?B?YUF3M0tMOEIrd2hIMGVjemhBTDgvSzFMTUxpb01DSEs4YUptRUhrOW9Pcmlh?=
 =?utf-8?B?dTdIdmMwSWxQNzAyYWZsaEk4ZzlXTjJ1UEFFcElFV1liK1l2ZkE1QW4wTmkv?=
 =?utf-8?B?UnF6dnQ3NTB2Y0tCQmtTRkdsdUdxckZhWUJlUkFuWk9tQ1dEN0J5TnlVQkNo?=
 =?utf-8?B?NFhzdjd1Y0ZKd0RFOVNqUmdEOTJtRGhNNVpyTWZxL0t5TzIwbGE3eStqcnZx?=
 =?utf-8?B?OGt3SWJLZmR3RytvSXRHRVBUbE43UEJneTNNc3pEUkRsTElvZUR1bzU0c1dv?=
 =?utf-8?B?M1BTaHhZOHR2UEJjU0pzWXQ3L05GWUN6eXRuMWZrUkpoUHgyMXNCVE1SVjZC?=
 =?utf-8?B?cFJEL2ZtSEkyN1VhRGFOQ0QxRHlFRGVDak9WdHFrVG12VVNBTGVXbzNBV0tK?=
 =?utf-8?Q?sseO/3dS0o4u8I0E/mn9l1Jd1?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 146be537-3017-4ab8-d005-08dd5b5e77f8
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB7507.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2025 20:52:25.6226 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Mwbullzk8JVs/QcSjDI1iuVGnfSjG3/SoHP6UYg/SroFFBbC1oTNNiKJ0judVcTDdgev8/kliFAOoPn27Akkqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8139
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


On 2025-03-04 11:22, Alex Deucher wrote:
> VCN 2.5 uses the PG callback to enable VCN DPM which is
> a global state.  As such, we need to make sure all instances
> are in the same state.
>
> v2: switch to a ref count (Lijo)
>
> Fixes: 4ce4fe27205c ("drm/amdgpu/vcn: use per instance callbacks for idle work handler")
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h |  4 +++
>   drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c   | 41 +++++++++++++++++++------
>   2 files changed, 36 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> index 26c9c2d90f455..3bc4fe4aeb481 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> @@ -358,6 +358,10 @@ struct amdgpu_vcn {
>   
>   	bool			per_inst_fw;
>   	unsigned		fw_version;
> +	/* VCN 2.5 global PG handling */
> +	struct mutex		global_pg_lock;
> +	unsigned int		global_pg_count;
> +	enum amd_powergating_state global_pg_state;
>   };
>   
>   struct amdgpu_fw_shared_rb_ptrs_struct {
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> index dff1a88590363..972f0842ea47b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> @@ -172,6 +172,8 @@ static int vcn_v2_5_sw_init(struct amdgpu_ip_block *ip_block)
>   	uint32_t *ptr;
>   	struct amdgpu_device *adev = ip_block->adev;
>   
> +	mutex_init(&adev->vcn.global_pg_lock);
> +
>   	for (j = 0; j < adev->vcn.num_vcn_inst; j++) {
>   		volatile struct amdgpu_fw_shared *fw_shared;
>   
> @@ -1853,21 +1855,42 @@ static int vcn_v2_5_set_pg_state(struct amdgpu_vcn_inst *vinst,
>   				 enum amd_powergating_state state)
>   {
>   	struct amdgpu_device *adev = vinst->adev;
> -	int ret;
> +	struct amdgpu_vcn_inst *v;
> +	int ret = 0, i;
>   
>   	if (amdgpu_sriov_vf(adev))
>   		return 0;
>   
> -	if (state == vinst->cur_state)
> -		return 0;
> +	mutex_lock(&adev->vcn.global_pg_lock);
> +	if (state == AMD_PG_STATE_GATE) {
> +		if (adev->vcn.global_pg_count == 0)
> +			goto unlock;
> +		adev->vcn.global_pg_count--;
> +		if (adev->vcn.global_pg_count == 0 &&
> +		    adev->vcn.global_pg_state == AMD_PG_STATE_UNGATE) {
> +			for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
> +				v = &adev->vcn.inst[i];
> +
> +				ret = vcn_v2_5_stop(v);
> +			}
> +			adev->vcn.global_pg_state = AMD_PG_STATE_GATE;
> +		}
> +	} else {
> +		if (adev->vcn.global_pg_count == 0 &&
> +		    adev->vcn.global_pg_state == AMD_PG_STATE_GATE) {
> +			for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
> +				v = &adev->vcn.inst[i];
>   
> -	if (state == AMD_PG_STATE_GATE)
> -		ret = vcn_v2_5_stop(vinst);
> -	else
> -		ret = vcn_v2_5_start(vinst);
> +				ret = vcn_v2_5_start(v);
> +			}
> +			adev->vcn.global_pg_state = AMD_PG_STATE_UNGATE;
> +		}
> +		adev->vcn.global_pg_count++;
> +	}
>   
> -	if (!ret)
> -		vinst->cur_state = state;
> +unlock:
> +	vinst->cur_state = state;


I guess we don't need to bother this per instant (vinst->cur_state) at 
all in this case? Other than this, this patch is

Reviewed-by: Boyuan Zhang <Boyuan.Zhang@amd.com>


> +	mutex_unlock(&adev->vcn.global_pg_lock);
>   
>   	return ret;
>   }
