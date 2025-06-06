Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD16FC5AD49
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Jun 2025 20:33:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A7BC10E080;
	Fri,  6 Jun 2025 20:33:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="F6yPjFQ/";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2074.outbound.protection.outlook.com [40.107.223.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC50110E080
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Jun 2025 20:33:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=svdzHqv31XSQiL4A8muJ7tkH0tw4u41FRQSLBYT0+hWSmq1dEDPZbHIhDMJ/DT2xL+dWc8WDKbhrWE27e/+XDduraOLAp7RLI/yFET2AnIKDu/Cc+YqrNgGHeqG3HxG8wRAcMUM0vDQK0a+N2f5RT/44mcVW7MVO1zW6LKOBSKhg9J3mn5cbdHVv1aOSa4CaYlypst0KVH8pch/jeHFXU4vjWeh2A2viiFem4By3lXJRcdAA1gXyxmuRk3YFXk1hJq2/yNhXYymDRrnoGx3aRs5jl/rcycgMMp0aggChmozuzEnToXri/3jjUk1NesuHsnKukYUhw9Pb+kd74y/b9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zkFNJT/M2uR53ZPotoSY4Q7poFd+CKPQV+253ywKOL0=;
 b=ewKfuDNM2Tq6e7UBzVmsn8wWzyXPr2Prbldh5zDDA5nA4TPkTfl8lGW9PE7JLgBuXHYI3d2YN3z8D6nE54ENtvdYsUWWWOIdvK/BPJjsGuXwb+7oAN9Fe9GpQb3wAjR7c0PmG0Gwkwi3bKpfVx/8/2Z5JmIYC1B6TOTAycT0mkBm3NHO7vDlmrQJ58ITxJT1Mnn1cu+KKFxO5ZH+dd/QMaf9NNTMWi/jZwKBpVyaU6cDwk4rnalj/OBM+Gl8/LgU2cWMVchFQlNJWtC/yDJHg6rzZlsTztah7O8L20QqpcV6oav4qpIb9lqLj9z3YkXccTexTYqwKkd66fDS7fgLaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zkFNJT/M2uR53ZPotoSY4Q7poFd+CKPQV+253ywKOL0=;
 b=F6yPjFQ/csa2XyxCgR5ITKPwFxnlDkrD5OBduNplLklklnq/WunmjE9Tcf4e5DBkFQSpyOj/mQQ0TTGRGmNUlvu4AKxOn2o8REbzIrb2dgF8T9MnxuC/GP4ujW7Pdvdu6aR56XnqlsVfuVwGl6yIkmPf9UxOtIuPCLP3n8QQntI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by BL1PR12MB5756.namprd12.prod.outlook.com (2603:10b6:208:393::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.37; Fri, 6 Jun
 2025 20:33:48 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::36fa:deca:aaeb:75da]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::36fa:deca:aaeb:75da%6]) with mapi id 15.20.8792.038; Fri, 6 Jun 2025
 20:33:48 +0000
Message-ID: <17c2885b-68ed-89c5-3025-381124a5642e@amd.com>
Date: Fri, 6 Jun 2025 16:33:46 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] drm/amdgpu: Add chain runlists support to GC9.4.2
Content-Language: en-US
To: Amber Lin <Amber.Lin@amd.com>, amd-gfx@lists.freedesktop.org
References: <20250605161155.1692134-1-Amber.Lin@amd.com>
From: Philip Yang <yangp@amd.com>
In-Reply-To: <20250605161155.1692134-1-Amber.Lin@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0011.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:85::26) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5149:EE_|BL1PR12MB5756:EE_
X-MS-Office365-Filtering-Correlation-Id: 55cc915a-de80-45de-f344-08dda53970a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VDZDRk1ZRGprN0ZUVTVRSTIraGo4d2NBalgzSHE3eEN5Yi9BU1FTdThPR2kr?=
 =?utf-8?B?NnFxTTAycUZnY1ZscUgyc3llZUNBVS9MSlR5eC81NzJ3YUt4RDFRRk40eUdx?=
 =?utf-8?B?eUUrWCtnU0lpdjRrcnhxVmRxUUczWjNhOUxRQ0JYRzN1RWVOT3Byd1hGejhR?=
 =?utf-8?B?WFlIWHZyc2tKaXBhVm9uS25wcHpUdmFhQktmcmtYcDZIM1FRV0xwa1UzWFJN?=
 =?utf-8?B?NXVERzZjN2JBOEZXYUsvL2Z3RW14R1lRTXRzVTJqbXRlL2VrUFJnM0wrMllR?=
 =?utf-8?B?RW9UVDc3UGN3cnhDZkZlV2p2U2N2b01vczhJRkNkazRFMnNIWndmWFBvM0RR?=
 =?utf-8?B?T2IxQkNRcVlBWkZwZzFBL1JJVWp1SStFbnZRYldsN3N0T20zVWpmcTdWVDJF?=
 =?utf-8?B?NU5yTDMvSytkWTBUKzdOK2VSU3dGeHFlY3dSdlcwWmJtbDc4VWpOWVViMi9C?=
 =?utf-8?B?YjlFSW1zNmk5cEZhMGpGbmNyV0NjYWRDQzhEWDNEaUxZTDBRdE15V3J5aEZt?=
 =?utf-8?B?dXpqQ0JjVVlHR1JjaVVBYTA5QXk0WTdQck14NEpRazEzUEtKVWdtSExIOHJV?=
 =?utf-8?B?SkE3Z2FFQWRLem5VdVVMZGVMSmpVUkthNU1FU2Q5NWRzVmw4MzducFB2TnJF?=
 =?utf-8?B?SllSTzY2UW1qNXdqSzE4VmEzUUdIbFVITnJlSEVlZTdtSloxRlR3YzQ2WVhu?=
 =?utf-8?B?SmQvWWpRUEpQZE5STEFmUitXOFNQYkJPUWZXREw2dzZjdVROQk5jL0phYUpu?=
 =?utf-8?B?RlR6bTBkc0pNeGtQUktCaXprc1cydWN0QmxKdFByTFZWbDUxV0dlV3RWdlYz?=
 =?utf-8?B?RHlWL0hzbVliNU9MU2lnMlQwZjRrOWFZS1VJeVlxckNseXUwUjFDUm1Yb29R?=
 =?utf-8?B?SkZORzJ0UUhrMzRYWDUyeXF3U3U5Q2lKTmsxWkVDdHMxdjV6Y1VtVEY4TUpa?=
 =?utf-8?B?Z0hoNkdVU0IyMEZ0SmRjcWgvVXdoYy9rek53b0x1dmtIN2FTMG9JZmxCK2lU?=
 =?utf-8?B?S3BoOTVGRExCdExhLzZ4UlJrVkEyUC9hT1haQmI1ckFnNzA3amxYZGNkQ0Vr?=
 =?utf-8?B?Qk5VdG9IZzdhQVl6NGV1di9FQU5Za2NSV2h3TjhZbGJ6VUFpNXBhL3hvWTJ0?=
 =?utf-8?B?UGMzdUl0bWQ1QUhtRkErdkEyT3NCRVJvWGIvMGpHYUowY002OVBCT2hNU29O?=
 =?utf-8?B?QS8wc2NRNDV1SGpxRzhoV3VTUExqSnh5MFBkQWdOanN0YWlLR2poQVJJcmdR?=
 =?utf-8?B?VG00VVllWStUYTBUdFJrc2t1SDFIeFc4bnNXNEhRMUxBRG11VXNjN1VVU1pX?=
 =?utf-8?B?elYxTEVISjRiMjlpMGY4anFRSFh3cWxvd3IrSTVWVEw2d2hXdkpRVU9tb3do?=
 =?utf-8?B?TytLck5pZy95QnVFTmZqZURlNkNKeVQ1R3dXWEd0bDdoM2Nzb1pQZk5UeXdI?=
 =?utf-8?B?dWhwMjBKRTVvYlQweHFRWUh1WUNHbDhEcVVoYlhBS1dRbEo4bExkc0tWdWp3?=
 =?utf-8?B?YVE2ZkZTWE5xU2RYVjJFRWlIYldyWTE5YjZDdW5ZWkJ1MllMWkRaRHZ1SnlL?=
 =?utf-8?B?VDhQYWhJaW5QVUIxMUdSY0JuUEp1UDZrUUVCNlE1RjA0MlNoeFM0ajhKUFBm?=
 =?utf-8?B?VzBYM3kwSXF5QTA1dnJJYmRZV3RwSTBCQkpPeVZwRVlMN1FkbyswWWMxQmkx?=
 =?utf-8?B?Rk83T2I4cXV6MnJSRnVHaDFFOTJ2UXI2eWtsNktXZy96M2lMbmZNS1hUUldY?=
 =?utf-8?B?MENGVGJob2d5Q1RBQWhldkxvYTNFSDk1emtaNmFkVzVPU3FGSFZ6TGE1Y1hq?=
 =?utf-8?B?L09VaXp2S1ZIVG0rVm9HOGlQZE0yUi9DMFF2a3BxZVFFdFE4b0lkdElGU3Q5?=
 =?utf-8?B?SERYM3hEbHhNbHpxV0FlVUk3UC9ubFJ3WW9wbXJzcnYvVmNzek9rUjliT2tH?=
 =?utf-8?Q?Phe7id7xiW4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SHpFQVFVbzZ5R1Y0L2oxQXVmNnVCRGJHc1k5YVhxMmVtNC9PbnNza2FqUEhJ?=
 =?utf-8?B?SUZhMm9Xa2x0bjRqVG04dnpwRGlIdjErR1k1UGFHRGV3K0pCeDV0YWFoamZX?=
 =?utf-8?B?WHYzU2pwRDEyenJjUEFFUHVrdFkwNVIvVnhQNHEvbjJBeGhvUzZ5d0ZkMktm?=
 =?utf-8?B?c0RZVjZWdlZqRmprMnl4dmI1Kzl1SXNTdXk1K1ZFNHJjVEhvYnhOazBXQUFZ?=
 =?utf-8?B?ZVNodXJGbkdURTY5dWpLMnN5cUJZNExqZjdEbFJLSEI3OGVnVGdzeW9nWldB?=
 =?utf-8?B?Q2lLdCtrSXlVd0VMaVhqeWFyQ25uWk9TTE5nZ2FndmMzejBocncyeHVwdGZQ?=
 =?utf-8?B?cXZ1Y24rdnZxTFQ1aGgvQlcrSnZSSE4zZmUxRDJ4SUZSRHVvT0V6Y0xjU211?=
 =?utf-8?B?b2d3aWdGampoSC9pVDVwQ1J1NjlhcXJUeExSeCt4UlZiWFA0MjZYWm9reUNp?=
 =?utf-8?B?VEFCaHVNWmQvdzBja1MyYTlYQWRlNVdaMDUvUFN3WUtzZTBRbDVqUW54T3F6?=
 =?utf-8?B?Qmo1MEVmazczZk5iNDFzOGZpTVJSNUI2d2tZZm8vM3RERDlHUXVVUy9GYytY?=
 =?utf-8?B?U21vV0xlc0VlS3g0eDBDa0FxOVhyeXJOOUFjdzFyYkJSSktiN0QyMlRuUEFl?=
 =?utf-8?B?ZzkvcEw3UThDZDBPeGtBZDdLZ1hTYSsydDVSZGhtM3FuYlc4Z3lGdTJoZlc1?=
 =?utf-8?B?aUdzN1VpeGhmL3hGclcxMWtlSk8xa3Q4L1FNL25CYW5wVmJZOFA0SkwwSXlm?=
 =?utf-8?B?UFZzQWh2ZkhmQVBwSy94dE4xL29GZVVIRXJRUDhvQkRhejJtZ3JoMUZlQ2lJ?=
 =?utf-8?B?dGliTDM3NFZOOGgzeFd5b2RwTXpZMWlSd2w3U2gwYUEzZ0QxT2JDeS9iUGZt?=
 =?utf-8?B?VlM2aXdLbG12bnFzTkJlNnhJSzV3SVR4aGMvYWo1Q0UzTGR6K0VKd1BaaHdY?=
 =?utf-8?B?bE1XSHRJdHpyRkpmVHVSRHJOZVNrWHlBbXJ4cGcweVZBTDZBdFlWZ2J1U0V2?=
 =?utf-8?B?dDFUZmNGUkFtODQ1bCtJTWtKSjd5K2VaVnlOemZFUDgxaWdwejB5S25tTTI5?=
 =?utf-8?B?QVp4cUlLc2JTa3h1SU5sVzl0WnRuSFRIWTlodDNWSE5KNGVyVG1pT3B5NnUx?=
 =?utf-8?B?OVNoUVJSSFhSOUY0RzZhSXZTeDkxVDFJSDVMQ3hFTGtqTjFKVTlORTJjTWxU?=
 =?utf-8?B?QmVqeXNWbGpDN1U2QzJKSktqZjBHYnNhVnRaeWVrcXh1WVVPQVJwVkV0cVB2?=
 =?utf-8?B?QnN2dEFjdGJyOUl2cjAvYlBHN3pISGtoT0wzN2FRbStTOVUxc1pEUzlLZ1dz?=
 =?utf-8?B?NWtqMVRJQXNwZjA1TzQzbkw1bmkwWjJDdVM2c3hLbmpBd284OHZ0SFVqYnow?=
 =?utf-8?B?QkRSMWFPSDYxVVdHcE4xRDVpY201eWQ5dW5GUXNYajR4anNoN3k5S0tmeE1F?=
 =?utf-8?B?UDV2TEoyWW1EaU4rNEJBN083SDgrQzVpQkZjTm5RcloxNEppcWhodXljTmQz?=
 =?utf-8?B?b1hETmtOaXJzWFczR3JBVy9TZ1pJWWRoY1ZuWjd3Z3pDL3JIQWd0eEF5STZX?=
 =?utf-8?B?M3RaRGxCVlVJdXhMd1NCNmUrOG9QS0NWMTEwblBTR0N2d04vR3lqbWZPbkUr?=
 =?utf-8?B?M2J1T0orK3B4YnZPejkra2E3c1hXaUVETms0WTYxVVBKeFhRWjFqekZSWDhL?=
 =?utf-8?B?RXQxVVFLVkMrcExpR1VkTFMyRUhLbXhhYnFwcEtlbXdSMTE5VE9VQnltZzdu?=
 =?utf-8?B?SGo0cm1hZFRsbWFvYUdmbHYycGdHblg5czBGa1RWKzFTckV3QXg3SzI4cXEx?=
 =?utf-8?B?NTZwSmtpL1VpWitjWjNPWGN0U01Kd3lVd1pBNGIrNGNwdFEyYUdOakxPV0NK?=
 =?utf-8?B?dFRhRWVkeDd6V1BYcE5KOTJxMHhvZGhGUGI5Z0JvYUk3QVQ4TS84SWxXajBy?=
 =?utf-8?B?NXJVa1pyRUp5R3FIQWFTTHlYeVVaVEU0OUc4TU9BdDVnZlhUc1pVWVB1WjBN?=
 =?utf-8?B?QzFVd1VnWkw0UWNDb1pjaHlCeTRoYlJIY1FCYktSNTUvL2hvV3huc1E0b0dv?=
 =?utf-8?B?ZXpYRVpocThHbG9OR3J6VFMrbXB6YkpKY09lNWVFUHhuazVvN0xWL2c2eTJP?=
 =?utf-8?Q?sj5w=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55cc915a-de80-45de-f344-08dda53970a4
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2025 20:33:48.0686 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x4hniP3IcOkhYz+MrU+AWLOqURE0zA53frs6tGyHdeRXrYYlhWYK8AnAZOh43VEJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5756
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


On 2025-06-05 12:11, Amber Lin wrote:
> Starting from MEC v97, GC 9.4.2 supports chain runlists of XNACK+/XNACK-
> processes.
>
> Signed-off-by: Amber Lin <Amber.Lin@amd.com>
Reviewed-by: Philip Yang<Philip.Yang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c   |  3 +++
>   drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c | 12 ++++++++++++
>   drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.h |  1 +
>   3 files changed, 16 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> index d377a7c57d5e..dedfc6c7f2cb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -2629,6 +2629,9 @@ static void gfx_v9_0_init_sq_config(struct amdgpu_device *adev)
>   				!READ_ONCE(adev->barrier_has_auto_waitcnt));
>   		WREG32_SOC15(GC, 0, mmSQ_CONFIG, tmp);
>   		break;
> +	case IP_VERSION(9, 4, 2):
> +		gfx_v9_4_2_init_sq(adev);
> +		break;
>   	default:
>   		break;
>   	}
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c
> index c48cd47b531f..6f40f3202f22 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c
> @@ -748,6 +748,18 @@ void gfx_v9_4_2_init_golden_registers(struct amdgpu_device *adev,
>   	}
>   }
>   
> +void gfx_v9_4_2_init_sq(struct amdgpu_device *adev)
> +{
> +	uint32_t data;
> +
> +	if (adev->gfx.mec_fw_version >= 97) {
> +		adev->gmc.xnack_flags |= AMDGPU_GMC_XNACK_FLAG_CHAIN;
> +		data = RREG32_SOC15(GC, 0, regSQ_CONFIG1);
> +		data = REG_SET_FIELD(data, SQ_CONFIG1, DISABLE_XNACK_CHECK_IN_RETRY_DISABLE, 1);
> +		WREG32_SOC15(GC, 0, regSQ_CONFIG1, data);
> +	}
> +}
> +
>   void gfx_v9_4_2_debug_trap_config_init(struct amdgpu_device *adev,
>   				uint32_t first_vmid,
>   				uint32_t last_vmid)
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.h b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.h
> index 7584624b641c..a603724c1dfc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.h
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.h
> @@ -28,6 +28,7 @@ void gfx_v9_4_2_debug_trap_config_init(struct amdgpu_device *adev,
>   				uint32_t first_vmid, uint32_t last_vmid);
>   void gfx_v9_4_2_init_golden_registers(struct amdgpu_device *adev,
>   				      uint32_t die_id);
> +void gfx_v9_4_2_init_sq(struct amdgpu_device *adev);
>   void gfx_v9_4_2_set_power_brake_sequence(struct amdgpu_device *adev);
>   int gfx_v9_4_2_do_edc_gpr_workarounds(struct amdgpu_device *adev);
>   
