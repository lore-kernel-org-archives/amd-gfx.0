Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35640E77188
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Jan 2025 23:07:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9912E10E40B;
	Thu,  2 Jan 2025 23:07:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="i82ZkGZv";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2059.outbound.protection.outlook.com [40.107.223.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 796D410E40B
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Jan 2025 23:07:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pSG0Jo8N7RljoyIcSZm/kU/+Hpuf0cRer0NtwlH3useyMKfUyfVQuQBOfujeGkcnkbykS5LdPDe6YmacD4KccsW8PrJZB/8Z5UbCw3tJo0pAewl+irlW67C7gaYwvvp1xsdGdDkjcvk5Yhmfgqppv0VFlCOTaQh7JwWf+GYn5oPrPZgnQL/MLSXMFW7M87kgVsP32aX0nU/0QInkOm+ZzVV53EigDKGl6GkUigQdrOVbygmd66toeayVj9OKCvmLAuVKHMMJRrDe0ZJsx1XZHbEklhSienOQSMbcuWjrmq9JtQC/jZQHjtrPbMyc1ePiCTv/F3GH37z27rSzFQyaaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xAU0w7tEsu7BIHIPPrQlBuiqZ1myHcEF5jiZkoXjOS0=;
 b=mmD/BiWW/L86K0MpRFTUcoSoYAm9rYtvMj/8SDoP+BhyOhjd6vDKz5SajcodpE6UY9ifUVjyPKnv544jvZZ6M0DywkPnQOc4pxy9xyfSnkBrYxD5VQubavZamBOiSWGD5elvRgEL6TrrGsXtiVoH1N9FhhnGc3u6131W9H6e/CCvmlKY1VpgSPwNO7z1RxppT/9VDleyH3oN/8e8yW1nqC+IzBAznsmObCwYx4glp/JPmuroOYSW24s74b/sjJV2s3jkmhoXzUsI0GaohXjF/yvg2UenpbMHmx+XJDOWpax0HntmpaO9Va8HY8pE1AqSj8X5ENZ3JTmL20n3b+GIJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xAU0w7tEsu7BIHIPPrQlBuiqZ1myHcEF5jiZkoXjOS0=;
 b=i82ZkGZvH6vwhFSQaRsHKgvPPSW2aMow1Vjg/MvUWXqvBTqNTEaS8eXig8IDX6caOOMMgdzxXqahgEdEW1B+IIJvd6hBhv3YGm7ot0fkTvI5s4fA1006vGyX5VXG0D8eY0xXxf0DhnQL3vnsxKGVrig5cMInb7rWxNkqEG1+vH4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6566.namprd12.prod.outlook.com (2603:10b6:8:8d::16) by
 PH0PR12MB7931.namprd12.prod.outlook.com (2603:10b6:510:289::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.13; Thu, 2 Jan
 2025 23:07:41 +0000
Received: from DM4PR12MB6566.namprd12.prod.outlook.com
 ([fe80::31b:5d31:8ba6:abd7]) by DM4PR12MB6566.namprd12.prod.outlook.com
 ([fe80::31b:5d31:8ba6:abd7%4]) with mapi id 15.20.8293.000; Thu, 2 Jan 2025
 23:07:41 +0000
Message-ID: <c1a4e8a6-2d6e-4e30-a6db-24c0a17b635d@amd.com>
Date: Thu, 2 Jan 2025 17:07:39 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] amdgpu: add flags to track sysfs initialization status
To: Jiang Liu <gerry@linux.alibaba.com>, amd-gfx@lists.freedesktop.org,
 kent.russell@amd.com, shuox.liu@linux.alibaba.com
References: <cover.1735795671.git.gerry@linux.alibaba.com>
 <737a46d7273d625ef8a1146925296bbdf57f2274.1735795671.git.gerry@linux.alibaba.com>
Content-Language: en-US
From: "Chen, Xiaogang" <xiaogang.chen@amd.com>
In-Reply-To: <737a46d7273d625ef8a1146925296bbdf57f2274.1735795671.git.gerry@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR04CA0075.namprd04.prod.outlook.com
 (2603:10b6:805:f2::16) To DM4PR12MB6566.namprd12.prod.outlook.com
 (2603:10b6:8:8d::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6566:EE_|PH0PR12MB7931:EE_
X-MS-Office365-Filtering-Correlation-Id: aaeee0f2-0213-4267-c277-08dd2b82425f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Wk5pU281dXRydHZ6dExNRGp4TUtGd0JjUWRyK0tSZHVBd3hEbE8vWXNRQ1J6?=
 =?utf-8?B?bmJpSkNFWnNFYVprMnhVODkxclJsL1lZZVdKRlArdDNqcmFuN2FhWGxnSFZp?=
 =?utf-8?B?K3BpSVhPQmlYWHhuelQ5RkFoQkU0cHc2cE9PcG1uYXR6SWx3dXZYaXdmalFu?=
 =?utf-8?B?M1duT2o2amU0aWdLM2hRZDRXcDI1VWJMUlRYKzhpVzZQYWdOSmFDTXpMN3I3?=
 =?utf-8?B?UzFJbVducE5uTDluM3hLOWNqL3RnTElTQi9IcTMxWEF2K1RoRUhsdDBvS3gv?=
 =?utf-8?B?cDc1RzhaZjBZMlhVZzljZzU2eXNtNERaTFl3NXhHUTJVMVAyUk5WM3lrR284?=
 =?utf-8?B?VE1yamRxNHlWLzEzZTI3YzJRbVd3VjVGVkFVV0piUmpHT2pURnFhRnd1WXBV?=
 =?utf-8?B?RDZjcWM3bHYwNVdVVThXaFRkaUVJTFZ3SFlFdEFqTjN5UkVjOTduYXRxQkxS?=
 =?utf-8?B?Rm1RT1BpYVVmenRNS3Vtc2g4WEorb3hMVUVrZkdMenJjYmZtb2hidnlDcW5V?=
 =?utf-8?B?eWFXbzBZWmFTbzBncThoY1VEMnU5Mk9GVUNINzJCZ0p4eUFOMWsremdiZkUr?=
 =?utf-8?B?Rmt3NWxudmxhVU1vTmpqQVdsdnZIWDl5UmxOU0R6bklmQnp0clFwdlg2a0Qx?=
 =?utf-8?B?TTNMazhkSldWangrZS82Ulp0SjcweHJWdExvYjVKZ1FuRTYrR2FRNjJiYXls?=
 =?utf-8?B?d0ZDRXZKZjBOK0lOZVNOeW53aHlhazVBczRzZGRlSGZHNk10VU55d0Y2Y05j?=
 =?utf-8?B?ZmpsT1ZNUGphb2tvRDlrR3J6MFhIbzB3TkRJbCtacTdBeGVCVVlkT2JMTVd4?=
 =?utf-8?B?UVhKTXZGTHdkQ2xrbXJIRDRZSWU5eGRyaTcwa2ZyVTN4cU1LMFpaMEdnd1R6?=
 =?utf-8?B?cGdETWFmOE9nNzgwblpYVmhQVkxhT1h4SUE5RE5MVEl5cWRuMmtZK0RSNCta?=
 =?utf-8?B?dGNNYVZxdzhwOXJhQmJXY0txaGc0VU9SVU1LWktLZFBTR0JmSWs3Skh3bGNB?=
 =?utf-8?B?T2RjTVl6angyZC9HaHNhcjNqRDRZdGZNb0xPdng5M1ZlWWdDNGJ4RHBhQnBZ?=
 =?utf-8?B?akl0MVdua285b2VJempKM0R1WEdjQXdRbVk2WHJIVlNnSXBnTWcwRTdCdjVo?=
 =?utf-8?B?TytPbjNZWXg3NndXOEsxK1ljUmhibzF3dVViZjlabGh4WEh3a05zYTBpc3Mz?=
 =?utf-8?B?S0x5bDNEK3hxNDcxQXI2Z3dhV3RYcUdpY29Rd0FPbVlUNW5iT2pMQXpmc2NF?=
 =?utf-8?B?dGJKM09FeGEvUGRqNDcrTjNEclRUV2pSQWdLc0lPWTRSM3JNYjVPZThKbnMv?=
 =?utf-8?B?VHM3d0tMZlpQUUFvMWhaTkdOMWhjUzhsTWlWTXdUMWJDQlpYd29ZVFFiekZu?=
 =?utf-8?B?SWFQSDFlc2JmNkR0V29uQlkrV3czaVNyM0QveUI3dnNkWU4xQWJ2UzhaS3h0?=
 =?utf-8?B?TUlRV0RuVXNsWTdiTTJHSlh5UzBZUUgzVm1IdEJKUDhOTmxjQjYxQVdtN2lT?=
 =?utf-8?B?TUVUQVZsVnVZSGNrZTlhSzNLMCtSSGcybXhVMDNoRUQzL0k0VDluaGZER3JR?=
 =?utf-8?B?Y0Y0TURzR1cvVjhPWGlON2UxYmxQWWlXT3Y4RjRjNzBtcFlxcFBlMUhPNXhK?=
 =?utf-8?B?dXd5bVJEejVzMFJVaDBqZ0lKVGloOXhhK2lJRHI4cDNiOS8xUlBLTisvRFJw?=
 =?utf-8?B?Yy9jVXFqVC8zQzR4b2Irc24wVmJrakxqZnNIdGx3SXJoN0xhTEtMclpHZ2Rj?=
 =?utf-8?B?RFVWSm9SVnVkbWFRWDVJczdTRW5GZ2ErUnhiV29hdUh5T0NwdmdiQVhESnkx?=
 =?utf-8?B?UndGYXRJYzljSTJocXNWRUxZb2EyNkkrM0xLb2JpMzdrYXlxNGpmOG9KTm1Q?=
 =?utf-8?Q?VQiLluTfF0DRW?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB6566.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cnBKTFhUVGk0UUs3MWpGUFFSanpzUzlRT09veUREbVVWRitqWk0zaXRZVEpP?=
 =?utf-8?B?OXpNb2k5Tks3OEg1WFJEYkl2QjFQRHJVSVhVL0F6NzFvU2ZBZ3RSNWRoSm53?=
 =?utf-8?B?QmxCK25VSTdnaUNxRkVHS2x6RTVuSzFZQVNkeWhUaW9kdE10alpJNU9tNWxk?=
 =?utf-8?B?bVVqcHJZUDJGek1VNkRTcnF3blJoaXhkNTBMbWJabWJkL0J6SVlZVHdvMmY1?=
 =?utf-8?B?blJmWWIwRmV2MG9ZTlB3Tnh0RHpLVUdid3JFZ3VFSitkdnRtUUNDMy9pUnVO?=
 =?utf-8?B?Z0JIWlZodC9RZFdwcDY0MGtSWlVUbzNvTmRMSG5GKzIrcURjYUVmMyt6dHJR?=
 =?utf-8?B?YzQyNlNFclFIdVBnS1VKZFZlaHV4RTRpdVZkdk9xaXJ6dXI5bzRnMmRJTkhY?=
 =?utf-8?B?ZDhRV0VSa2NiZ2VIYUhSVWVUUUNjYXhrMms2RGFVbFRpeW9sUHlzNTBmN2Zu?=
 =?utf-8?B?QThUay9KUExvcFlDR0hncCtpNDdpS09DWW93OURpcVRQNEZuOHlOMENpTVc5?=
 =?utf-8?B?WnNpTlJER1VKcGpNOFVkNG5QcE5DRTVMeVQ2TEhkTVdZUHhyOXJsUlZtaExt?=
 =?utf-8?B?WnNod0tXUU56TWt3azFBTjd6OVVwR21vdFlTQmRnelQ1MnJCQ1cwOWpHem9K?=
 =?utf-8?B?U1E1dzJocG9xeVpPRnZCZnF0c25BWkMvRUdBL1lTczZGdW5wczViNWtKcVdT?=
 =?utf-8?B?K1lXVDd6OUt6KzJFOHRMbEdQUWlQWmVxcWd3TWxwUklDSzl4aFRzTGpIUE9v?=
 =?utf-8?B?eVJOUjFXZFlqVFFzOHRuenpXbEN3cnk2UnQ3QTgzZGd1dk1IYngwM1VDUERw?=
 =?utf-8?B?dXdvT1JsS29wamJ4NVZJN25VdXQ0ekp6OHZkeThxOEZlb2pwWXRxMHhLeFpt?=
 =?utf-8?B?cVR2Z2JPeEFTWHVCTWpxZzBVaXJzeEtzdVVudDVDWmgzRmpWQTZNejRzK2RM?=
 =?utf-8?B?bGFzeU5EanN3Z1FrVlE0SGF2d2lUckZnYXI3R2ZXbGt4OVFiam9rdG1HYzdn?=
 =?utf-8?B?MS9vVkROUFV5dWR3VUtXcDdvYWREc3h4cnJ2QTFhWlBTTVhRTGc4M2ZsWEl3?=
 =?utf-8?B?QmRsZFhzZWI5a3cwK3NLTnpxSmhxK0R3OEpMcXNsTXk4LzQ3UU9TSXIzWjZL?=
 =?utf-8?B?ZmgzN0V3MzFhWmNFQ0NtVENtN2RMYkJ1MGxmSmtFY0J1bjA4c2tUVDFick1M?=
 =?utf-8?B?SVl2YlJQdytTUVFvWm1ST0RsUEJuclVqRjA2MGVxSmJ5QkdtNCtGS2d2V3do?=
 =?utf-8?B?Z2w4SzRaSXlIbDRIMlhRRk4zcXprWFhsd1o5Zzk0cm1vVEI2STRycE9nbU4x?=
 =?utf-8?B?cXlxZmZjWGl3bmUwbDg3ZXZGZmJ1RXM2ekltMTR3UzJsT1dKN3hKL0FYUUgr?=
 =?utf-8?B?eENUL284Ry9FeUlVTnZEOUhQbTAxWlV1SkdxWWZFZUFvb2lvdEY5RTlwSHFw?=
 =?utf-8?B?cXVNbFVPbDhIOXRxY2ZxTngxTllrZWdxcnMwdVZFZU1hbTZKeWlVTk5tSWdJ?=
 =?utf-8?B?a2EwL2ZzbHJPQXlpS0xTR1pMMDVsaUJCKzlUZnpkNW9qM291Z2tpcmFiU01I?=
 =?utf-8?B?NE1UQ09XMnh5b1BKbGtjMFg2WFNrblJQd05jNXlHZ0U1dU9mVi8rMTUzczNj?=
 =?utf-8?B?czlrSFR1LzVWelUzUW1rdWFhRW44QlIzWmY2YWgvYmRNVFkwck0yb1Q3eU41?=
 =?utf-8?B?clZBY3ZVQVloaTdqSFpzcldDWXlNenM5TGNOWmRoTlUrTi9OVjZPa0dDQXh6?=
 =?utf-8?B?TzN3UGp2eTZMQUx6ZTZvdzdBZCtJSGxYZHBnSFZ3NXRnVDBQMDRUTFJOZ2JQ?=
 =?utf-8?B?eW50RFB4QUZYb1VrQ0V2NmhjaS9RTnhNVllBS09CamRPakNaYmpJNzZmaFlr?=
 =?utf-8?B?VTFpU0dsdWxYdnE3bnpQOTRZdURVMUN6VkdxdHBXNWZGUUlGeEVNVWpWNG00?=
 =?utf-8?B?ZDRpeVVpQnhFcjh4ZlNlZ3czVHAvcHMyMUdQK3dUNE1XbGVVL0k3eTh0MFd4?=
 =?utf-8?B?bllVSEdFbHFMTHBTWGlCbFFQU3JQWE1xM0hoQU0vY2NvaTVNekV5K3lsY2pL?=
 =?utf-8?B?V2IzRXNSdC9hMUNYeklzS2kxbTNCN1MzdnhmaDNFN25aUHU3L05JdEJXTnEy?=
 =?utf-8?Q?z6+k=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aaeee0f2-0213-4267-c277-08dd2b82425f
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6566.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2025 23:07:41.7381 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O0N/lm5erQgnWVuuXGPxDnxqMhVUQ6IRxCDOWSfqcbNP95MzTDl9tNXSlsZhm/aJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7931
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


On 1/1/2025 11:36 PM, Jiang Liu wrote:
> Add flags to track sysfs initialization status, so we can correctly
> clean them up on error recover paths.
>
> Signed-off-by: Jiang Liu <gerry@linux.alibaba.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  3 ++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 34 +++++++++++++++++-----
>   2 files changed, 30 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 22c7e9669162..e4b13e729770 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -1157,6 +1157,9 @@ struct amdgpu_device {
>   	bool                            in_runpm;
>   	bool                            has_pr3;
>   
> +	bool				sysfs_en;
> +	bool				fru_sysfs_en;
> +	bool				reg_state_sysfs_en;
>   	bool                            ucode_sysfs_en;
>   
>   	struct amdgpu_fru_info		*fru_info;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index d1bb9e85b6d7..3244966b0c39 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -4533,8 +4533,13 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>   		adev->ucode_sysfs_en = true;
>   
>   	r = sysfs_create_files(&adev->dev->kobj, amdgpu_dev_attributes);
> -	if (r)
> +	if (r) {
>   		dev_err(adev->dev, "Could not create amdgpu device attr\n");
> +		adev->sysfs_en = false;
> +	} else {
> +		adev->sysfs_en = true;
> +	}
> +
not need use {}
>   #ifdef HAVE_PCI_DRIVER_DEV_GROUPS
>   	r = devm_device_add_group(adev->dev, &amdgpu_board_attrs_group);
>   	if (r)
> @@ -4542,8 +4547,21 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>   			"Could not create amdgpu board attributes\n");
>   #endif
>   
> -	amdgpu_fru_sysfs_init(adev);
> -	amdgpu_reg_state_sysfs_init(adev);
> +	r = amdgpu_fru_sysfs_init(adev);
> +	if (r) {
> +		dev_err(adev->dev, "Could not create amdgpu fru attr\n");
> +		adev->fru_sysfs_en = false;
> +	} else {
> +		adev->fru_sysfs_en = true;
> +	}
not need use {}
> +
> +	r = amdgpu_reg_state_sysfs_init(adev);
> +	if (r) {
> +		dev_err(adev->dev, "Could not create amdgpu reg state attr\n");
> +		adev->reg_state_sysfs_en = false;
> +	} else {
> +		adev->reg_state_sysfs_en = true;
> +	}
same as above
>   
>   	if (IS_ENABLED(CONFIG_PERF_EVENTS))
>   		r = amdgpu_pmu_init(adev);
> @@ -4666,10 +4684,12 @@ void amdgpu_device_fini_hw(struct amdgpu_device *adev)
>   		amdgpu_pm_sysfs_fini(adev);
>   	if (adev->ucode_sysfs_en)
>   		amdgpu_ucode_sysfs_fini(adev);
> -	sysfs_remove_files(&adev->dev->kobj, amdgpu_dev_attributes);
> -	amdgpu_fru_sysfs_fini(adev);
> -
> -	amdgpu_reg_state_sysfs_fini(adev);
> +	if (adev->sysfs_en)
> +		sysfs_remove_files(&adev->dev->kobj, amdgpu_dev_attributes);
> +	if (adev->fru_sysfs_en)
> +		amdgpu_fru_sysfs_fini(adev);
> +	if (adev->reg_state_sysfs_en)
> +		amdgpu_reg_state_sysfs_fini(adev);

If creations of these sys entries fail does kernel send warnings or just 
ignore that when delete these entries? Seems kernel keeps silence for 
this case.

Regards

Xiaogang


>   
>   	/* disable ras feature must before hw fini */
>   	amdgpu_ras_pre_fini(adev);
