Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5343BCEE32A
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Nov 2025 15:47:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E5DE810E4EC;
	Tue, 18 Nov 2025 15:47:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ECe/dFCJ";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010013.outbound.protection.outlook.com [52.101.56.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D4EDE10E02C
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Nov 2025 15:47:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V8qryfL83AatpV8zFhOrTpee0DItfJ0Hz9HEiMFpFlkwGISvri+6o9ZemEVh5ICAgsxDzQ5zEeDeeRHxsThpBP2AikccpQ7nl9ehfBelv2/GseBWYvFFz9ZlEwpiBu0znYik+ySK5iLy6nDukselF763AguuW68IpkcHZQaHl2zl5t3LC3+SJw2pZzu7rJXp3q/h0PO0xUPcod7f5yEMsjgNGn1v+velFAumBPO4YVIM2vjzFa0F4w1/V2Avo+8OSGDalRzQzeM2+SMGEfWjm2hh6scUG+hx8Uej+CM+R07Rtui5PdybywayW0ivJ85mfzLjQEbc2PrA+aougDjD7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LP6sw2PBEPUYkbuf21s0o4SDMo2AT4e6MXpejgxjqjY=;
 b=aJVmfKL6hLiOfQ+CnXCGYa1XC5UJESnf+iu7Ss6agpLLkDANTNIccZFE3tcrdNv9BxBQ+OK+O+dFztEsmIK9QLdhN1dwb11P4atBhhxeP93o00QtDKfmPIowxBckb9nXwnIUe0p3vWX5Zm0u4AnguDUN1byurujmaSUHFefj2wMlQi9K6L7ufsf38x6ZSfeL/YSQSpem4hXAG+ILXhEqaH4eiLdyvs/hc3Nh5DsrM0D7zqN+VZr+NhvPTI5qgAOI1Ju7mF2NrZVrQ7WZb88T/yIWYx6LBgxbZ+ljarB1NNA6SRgIDyzC3c1dRZ4spPlRK/7oMaxBsxPDtkSW2uQF5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LP6sw2PBEPUYkbuf21s0o4SDMo2AT4e6MXpejgxjqjY=;
 b=ECe/dFCJk7cPRhB+ewtUfse9xQNBkR+O9Fs6wn3YefvMMR4LvKiUjt4I5IKStyNUhnPtmPGpWrKTfp6ZDD1iBmaJ91KN81to8dRADJX9hPNjO41O7nMV5bm6FFTVczLyyE/489M3+FlgLk6v2nY7AX4pREFOYufLuRg4ThDn6i4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by DS7PR12MB5861.namprd12.prod.outlook.com (2603:10b6:8:78::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.22; Tue, 18 Nov
 2025 15:47:31 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::36fa:deca:aaeb:75da]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::36fa:deca:aaeb:75da%5]) with mapi id 15.20.9320.013; Tue, 18 Nov 2025
 15:47:31 +0000
Message-ID: <49df5d58-1482-f6e1-3b5e-3b8e785ea2bf@amd.com>
Date: Tue, 18 Nov 2025 10:47:29 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2] drm/amdkfd: Uninitialized and Unused variables
Content-Language: en-US
To: Andrew Martin <andrew.martin@amd.com>, amd-gfx@lists.freedesktop.org
References: <20251117210402.2213429-1-andrew.martin@amd.com>
From: Philip Yang <yangp@amd.com>
In-Reply-To: <20251117210402.2213429-1-andrew.martin@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0289.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:6d::9) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5149:EE_|DS7PR12MB5861:EE_
X-MS-Office365-Filtering-Correlation-Id: b6ee8a7d-c69e-40b4-d938-08de26b9c8f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VXhpb0UzbjBrQVRGMmF5aGZwTjRBRlpGZ3pTNWJoemZBZUxJS2hNOHBPOVdM?=
 =?utf-8?B?WkhlQWV4b0tCaDNXUnlaNmpzdlJpMC9JRTBPS3VXR3ZOYmNFOUEvTmhQc2Iz?=
 =?utf-8?B?ZkFDNHJqdUhzaE0zN1hQdi9qcW5RZWh6QTU0UDVzRzZpZmNiOWtjcUJHb3pI?=
 =?utf-8?B?NEdPSkFxTHVPSjl5TUJydHRyZXJ1MlhiU09TUXRBakkzRWFoUjFJRFVWUENB?=
 =?utf-8?B?ZVRzdkxEcGh0MlNDSjU0OXQ4cU93ciswdTFHeDliWlZSRE9MdUcrMWcwTzVK?=
 =?utf-8?B?ckEvaGlvYUJLQmt3Z1F3cldrdkVqMzRHcGZwMjFTRnI3YnZ0cXVzRGdBaENO?=
 =?utf-8?B?OVJBWFZoZ1FEMXF0Y3BzbEUwSHc1a1lkUTltTk5lbEE5SUw0WDlpUm10LzAx?=
 =?utf-8?B?VUJFMkJaeXFhaHNPeVlISVBLd2pTZEJaRWh6MUlUVlhwbzNRZWpFNE15cG03?=
 =?utf-8?B?WHorZmt3b2l1ME8yK1F6WDhrdDl6Y2NET1l2Z0xuWWtFc3RuMVYrZk1KMUQr?=
 =?utf-8?B?dWdLNEVCVU52czBWdXlNVjM4a0ZoY3dMS2F5RHdQSm5BSVNtYjFPdWl5TFdm?=
 =?utf-8?B?aHpUTkNPSFNxZjFycFFsdHFKNWVWSUVtNFpqWk1LUHNRK1NkVDhWMEVrUjZp?=
 =?utf-8?B?QXRmcEtzWFEwUWppYVpkbUZuSWJyNVdmbjBUa2t3ZmhYT3FjVlV1RjFLdmZa?=
 =?utf-8?B?ZzhxdjZyZVJaeGVBUFltWGpRcTVlbnpMQWNQU29LYmRTWXhIOUtucjZGNUZv?=
 =?utf-8?B?bUx5Mm9tcHM5eG4yY3I5a09hK3g0UHdDV2UvNXYyZyt4TXdsNGJIQXdPOXpw?=
 =?utf-8?B?UVI5Qm9SL3M4OXpCRVBQZFg2OGU5THJkVHlrL0ExZmt0WVhjckF1Q2gwYjhJ?=
 =?utf-8?B?bzNVZXFXdy93WXdHQ1BOM2RoWDUxdldadWJwekJzN2FZRStPTGZSVHFCMGtS?=
 =?utf-8?B?aWtjOElWYk9LdXVkKzl6a0VLN2lFTlppWjRuS2hESFlheGRxalpIbGR5ajhC?=
 =?utf-8?B?Qms4TzlxUkpJckFpSlg5eU1UaGpvaVpXNEJNUithaUd1K243N3FaOU1jMGl0?=
 =?utf-8?B?TEJhWWZJMGZpaTlBVmpkcjhoaFU3bEE2WHF3S3hiOUEzQjkrakxoQzhsME9U?=
 =?utf-8?B?T1NVZGhObXFESUFCTzVGVEVKYVF6cWF2ZUMxdFZ6dEVhUUwzRTIwZzZkSGc5?=
 =?utf-8?B?SnI5Q1FsQWZHYjJEU0FYbHk0ZVl5SFdxTjF2MFJEV1lDNklRUyt6ZzNPckVK?=
 =?utf-8?B?VzA4NXdxMGwwYWFBTFFJdFhSVU1UMmJ3bWE3cW1SdldwSjRBWkc2TWliUGZ3?=
 =?utf-8?B?WFBhR0FUbXFMTTNIY0NvOUcvTUE1YW5EZDcrajQvdWhxOG9kZnBZc2xOQ1BY?=
 =?utf-8?B?dHRrODhGWFJDbWRXQVRIWUZSSXIyc2xVSkZKV1NlYnV4MkxlZiswOERsY1lW?=
 =?utf-8?B?VjVzdUVETEdhaHRTT2VabGF1Sys1MXhiOXgxaTV6L2lGRFVjVCt4akQzYjBm?=
 =?utf-8?B?UzVzK1Y4L1RNY0h6WStmOWRucE05b1Z6d3A5Y21MM0lXVFBkdmxSZ2VJdUVW?=
 =?utf-8?B?Rk5mZU52YkEyREgrNnFKWEx4VHRvVndrcHF1ZGNvVWdFV2pPTmdUaytINGlL?=
 =?utf-8?B?SHNkWWFnQU5nU1AxT2gzRDhZYysxRnc4K2hPMDVVdUErR0twYy9jc3VUNU10?=
 =?utf-8?B?WHZ2aDBYdURKNXh0MlNORm9TYmkyS2VSZ05pVmtVOWNyNDRWMU54UEhub2VK?=
 =?utf-8?B?NWtnT3k3djU2blNNZWhNaUdUVlVkVFpvVFFYZWY1RzBhV0FEcUs2L2d3cmJZ?=
 =?utf-8?B?WlR2Y3p3V0pKUEQzSkdscE9OUWN0ZFVkVVV2L2FrNXRwWmpRVm1DNjJlYWNW?=
 =?utf-8?B?SnV6Ylp2aEhJQXJveEM0Ylc3Y2VobEZNeTV2b2JINDYzbzUvTUJobi9sVGRY?=
 =?utf-8?Q?Fr9sYQ/OdVx8YjvA1FzcGx8C9jZPu8A3?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q2JvMXI5YVV2MGh3Q01DcS9QN0QrTzhLQWFhV0NvNlZnWmdOVk1rQXM5dEJj?=
 =?utf-8?B?d2gxb0JYc0pRMUM2K0tZR2JFRHJ6Vlh0VVdzK3A4akdlMVpUcDMydFVsVXVJ?=
 =?utf-8?B?a3FDbm9PODVDdFcxajRBLzZITndVRGZRZUgvZFlRM3I3S0xIQis5VytUdk52?=
 =?utf-8?B?Ti9TTW9OL3BZZVhydVhQUGxJbmN2MVpUem5zZldIdEE3UHQwNnR1QVpmbEtF?=
 =?utf-8?B?R0dpM0lNU1lBUnhoWGd6bkpPWmM3bnZDVUdsNjdLTlVmUVorUWdSWUFxcFk5?=
 =?utf-8?B?cStOWG9Ed1JUb01EWVZ4ZTRsUEZjUHlPTVhZQTJlaVFoUXpqb1U2TFpVRHJ1?=
 =?utf-8?B?bWhIdHZCbS9oQUlDNDFRTzErV0hMejdtQmQrbTBtMHdoWHBwd0hQUlFTYkRE?=
 =?utf-8?B?WXBwQUwwV2srTEpnVithbXV0MGtURGNORzBSd0syR1JQLzVXMGhoUHpnTnFO?=
 =?utf-8?B?blRLSGFlYWhUNWw5ZVBVWVcxc0ZVNmowZHlVQzA3SytlcENUcDByTHh3OEdu?=
 =?utf-8?B?K0pYbjV3S0RTTWh0b0EwTGR3Z2QrTkdvVnNaS3RvcnFWL1BULzVWYURpZkZy?=
 =?utf-8?B?UDBXanNPTyswL1MxL0FzMkFscWdyeGZVbU5tZm1kOXlEZ3lmUWFaYU1mK0pK?=
 =?utf-8?B?eDdsREdZcndURXY0eFpCRW5YaXc0ajMzUnNncU80KzJzQ0svT0Vta2dGMjk1?=
 =?utf-8?B?WG9GZThvNjZmWXRuZ281MEppbWRwdHo4dmxmdWNIZEFGNzdocUw2Q1IvT09m?=
 =?utf-8?B?dmRGcDhoVHd1UnFGTE1sWkVMYlhUL0h1SnNZYkpENi9ZVFVQVXZhZ1k3bVZF?=
 =?utf-8?B?cmNQbnZyZzdqaEI1dVNNWGd1b050RTMxckRBYTBXeUdobFk0ZmwzQmNtREg4?=
 =?utf-8?B?MVlMcE0ydmdseEhldUZWMzcramUyNElidVVlWGJHZ2xEQkhLeFpwNFUrYlM3?=
 =?utf-8?B?SU1oTXZsM1NNdndyNXJYWE5sN2RFMzI1QmdoUXkvWEQ4RGswYUdKa3JBMlUx?=
 =?utf-8?B?NTFXWk5FV1hYNkUwTHQxaGRTR1gzVnhRTlBJdVZoMGRTZUpWTVJPS0VWZTh4?=
 =?utf-8?B?ZmJkaFlSNHN3eTdwKytMY28xeDlXTDVNalR0OGVGdnJoSC8xUnV3RHROMXEw?=
 =?utf-8?B?ZURqMmN2MDJMYW9GZkIxQThBZnJUZ1AzVDhyVFEzNjZlZnRLK3dzaVNzVE1k?=
 =?utf-8?B?Q2QxbTI3TWNWdXZjaVA2TWVEdElwM01TdGlrMVhoTGpoM2Fna1RIVG5ZMFFJ?=
 =?utf-8?B?MElUazRqdnRZeGlyTm5Ud0FlZVVXYW1SbTJkRU1tWHFQUGcwTjNFb3FRaCs5?=
 =?utf-8?B?OVJjRE9SSHN1eGVQM01RSVVNL0pONnB2aGd2QXRMdHJvZGpDSUR4NEhXZERU?=
 =?utf-8?B?SDlZTUJ1VjdxYjdTb093Nng5TGFQbE9wOTJCdG16UTZRUUU4ekFlVlVQT2Fu?=
 =?utf-8?B?UnNRTEdOeVlidVZFK1loeHlTVmU5NGhtNk9iSWswbGZDNkFPZitsTldxV3RN?=
 =?utf-8?B?Z2srZEtzVDlvZXVFU3krWFpjSFFzUHZQNklrMXN4YkJtcG0rS1YwY3lKaWlO?=
 =?utf-8?B?QzdGV1dkelRWeHZxL2FrTE9OU2xhTDZiUEJxMjZ1OVpmNTNoMmpLanJ4T0sy?=
 =?utf-8?B?bWVrU2docGRicjhhTHpEdHEybVBZMWMyYng0UzV2K1NmTWJtNEo3MDlkTkNE?=
 =?utf-8?B?RHh5Zk5iZUZlUFB5TElSb1loaTV2Vk1tQnZEaEZpNUNhZzJWMWlCOFV3NjMy?=
 =?utf-8?B?R2gvSlh2SFloY3M3em5PbC90cGpINGZ4NFI0d1ZIOWVWbC9VMWd3MlpORnE2?=
 =?utf-8?B?NmQvRkhLZEZFZ0toS3pCdHhZcFhnckVwYVcrL0t2NXFsNHdIaWZFODFKa05w?=
 =?utf-8?B?Z2xOU0R6cWorMWZvVzFjMHNvNWF5bVhRL2hTYkNybmV1NERJN1k2MG1JMUh0?=
 =?utf-8?B?ak1SV3pnS2YvTU4xcXM4V1lTaDhSL1A2VkJjSGFaUktqSCt6M3QwemcvTWtR?=
 =?utf-8?B?WndyWm1Zd0tBQ2d0aGlmd1FteGlqczdtQkxkSDVVMm1HVGREaThsRDBBQ3B4?=
 =?utf-8?B?aUpwTWFKeGwvUHUxUXhUcG5ZOVZOeTFDdElUVlF2QWR5TU1UajZ1NE5CTWVL?=
 =?utf-8?Q?IP2I=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6ee8a7d-c69e-40b4-d938-08de26b9c8f0
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2025 15:47:31.8315 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IoTvCAySXEUYzgolly6vzrzDRcg2TFV4Rs+phYAs3GMUEHEm1jonlbVIUZ3+T0kh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5861
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


On 2025-11-17 16:04, Andrew Martin wrote:
> This patch initialize key variables and removed unused ones.
>
> Signed-off-by: Andrew Martin <andrew.martin@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_device.c         |  2 +-
>   .../drm/amd/amdkfd/kfd_device_queue_manager.c   | 17 +++++------------
>   drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c |  8 ++++----
>   .../gpu/drm/amd/amdkfd/kfd_packet_manager_vi.c  |  1 -
>   4 files changed, 10 insertions(+), 18 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> index e9cfb80bd436..43e97b5b3b5d 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> @@ -1059,7 +1059,7 @@ void kgd2kfd_suspend(struct kfd_dev *kfd, bool suspend_proc)
>   
>   int kgd2kfd_resume(struct kfd_dev *kfd, bool resume_proc)
>   {
> -	int ret, i;
> +	int ret = 0, i;
>   
>   	if (!kfd->init_complete)
>   		return 0;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> index d7a2e7178ea9..57b3f7c7f422 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> @@ -624,7 +624,7 @@ static int create_queue_nocpsch(struct device_queue_manager *dqm,
>   				const void *restore_mqd, const void *restore_ctl_stack)
>   {
>   	struct mqd_manager *mqd_mgr;
> -	int retval;
> +	int retval = 0;
retval assigned to error code before goto exit, or assigned from 
allocate_doorbell, don't need init.
>   
>   	dqm_lock(dqm);
>   
> @@ -856,8 +856,7 @@ static int destroy_queue_nocpsch_locked(struct device_queue_manager *dqm,
>   	int retval;
>   	struct mqd_manager *mqd_mgr;
>   
> -	mqd_mgr = dqm->mqd_mgrs[get_mqd_type_from_queue_type(
> -			q->properties.type)];
> +	mqd_mgr = dqm->mqd_mgrs[get_mqd_type_from_queue_type(q->properties.type)];

unnecessary or unrelated change .

All other changes look good to me, with those 2 changes fixed, this patch is

Reviewed-by: Philip Yang <Philip.Yang@amd.com>

>   
>   	if (q->properties.type == KFD_QUEUE_TYPE_COMPUTE)
>   		deallocate_hqd(dqm, q);
> @@ -1443,13 +1442,12 @@ static int register_process(struct device_queue_manager *dqm,
>   static int unregister_process(struct device_queue_manager *dqm,
>   					struct qcm_process_device *qpd)
>   {
> -	int retval;
> +	int retval = 0;
>   	struct device_process_node *cur, *next;
>   
>   	pr_debug("qpd->queues_list is %s\n",
>   			list_empty(&qpd->queues_list) ? "empty" : "not empty");
>   
> -	retval = 0;
>   	dqm_lock(dqm);
>   
>   	list_for_each_entry_safe(cur, next, &dqm->queues, list) {
> @@ -1479,7 +1477,7 @@ set_pasid_vmid_mapping(struct device_queue_manager *dqm, u32 pasid,
>   			unsigned int vmid)
>   {
>   	uint32_t xcc_mask = dqm->dev->xcc_mask;
> -	int xcc_id, ret;
> +	int xcc_id, ret = 0;
>   
>   	for_each_inst(xcc_id, xcc_mask) {
>   		ret = dqm->dev->kfd2kgd->set_pasid_vmid_mapping(
> @@ -1831,8 +1829,6 @@ static int start_cpsch(struct device_queue_manager *dqm)
>   	struct device *dev = dqm->dev->adev->dev;
>   	int retval, num_hw_queue_slots;
>   
> -	retval = 0;
> -
>   	dqm_lock(dqm);
>   
>   	if (!dqm->dev->kfd->shared_resources.enable_mes) {
> @@ -2784,7 +2780,7 @@ static int checkpoint_mqd(struct device_queue_manager *dqm,
>   static int process_termination_cpsch(struct device_queue_manager *dqm,
>   		struct qcm_process_device *qpd)
>   {
> -	int retval;
> +	int retval = 0;
>   	struct queue *q;
>   	struct device *dev = dqm->dev->adev->dev;
>   	struct kernel_queue *kq, *kq_next;
> @@ -2794,8 +2790,6 @@ static int process_termination_cpsch(struct device_queue_manager *dqm,
>   		KFD_UNMAP_QUEUES_FILTER_DYNAMIC_QUEUES;
>   	bool found = false;
>   
> -	retval = 0;
> -
>   	dqm_lock(dqm);
>   
>   	/* Clean all kernel queues */
> @@ -3464,7 +3458,6 @@ int suspend_queues(struct kfd_process *p,
>   					else
>   						per_device_suspended++;
>   				} else if (err != -EBUSY) {
> -					r = err;
>   					queue_ids[q_idx] |= KFD_DBG_QUEUE_ERROR_MASK;
>   					break;
>   				}
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
> index f2dee320fada..2e9b6bcf2704 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
> @@ -596,7 +596,7 @@ static int hiq_load_mqd_kiq_v9_4_3(struct mqd_manager *mm, void *mqd,
>   			struct queue_properties *p, struct mm_struct *mms)
>   {
>   	uint32_t xcc_mask = mm->dev->xcc_mask;
> -	int xcc_id, err, inst = 0;
> +	int xcc_id, err = 0, inst = 0;
>   	void *xcc_mqd;
>   	uint64_t hiq_mqd_size = kfd_hiq_mqd_stride(mm->dev);
>   
> @@ -620,7 +620,7 @@ static int destroy_hiq_mqd_v9_4_3(struct mqd_manager *mm, void *mqd,
>   			uint32_t pipe_id, uint32_t queue_id)
>   {
>   	uint32_t xcc_mask = mm->dev->xcc_mask;
> -	int xcc_id, err, inst = 0;
> +	int xcc_id, err = 0, inst = 0;
>   	uint64_t hiq_mqd_size = kfd_hiq_mqd_stride(mm->dev);
>   	struct v9_mqd *m;
>   	u32 doorbell_off;
> @@ -818,7 +818,7 @@ static int destroy_mqd_v9_4_3(struct mqd_manager *mm, void *mqd,
>   		   uint32_t pipe_id, uint32_t queue_id)
>   {
>   	uint32_t xcc_mask = mm->dev->xcc_mask;
> -	int xcc_id, err, inst = 0;
> +	int xcc_id, err = 0, inst = 0;
>   	void *xcc_mqd;
>   	struct v9_mqd *m;
>   	uint64_t mqd_offset;
> @@ -848,7 +848,7 @@ static int load_mqd_v9_4_3(struct mqd_manager *mm, void *mqd,
>   	/* AQL write pointer counts in 64B packets, PM4/CP counts in dwords. */
>   	uint32_t wptr_shift = (p->format == KFD_QUEUE_FORMAT_AQL ? 4 : 0);
>   	uint32_t xcc_mask = mm->dev->xcc_mask;
> -	int xcc_id, err, inst = 0;
> +	int xcc_id, err = 0, inst = 0;
>   	void *xcc_mqd;
>   	uint64_t mqd_stride_size = mm->mqd_stride(mm, p);
>   
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_vi.c b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_vi.c
> index a1de5d7e173a..8321dd01b67a 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_vi.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_vi.c
> @@ -174,7 +174,6 @@ static int pm_map_queues_vi(struct packet_manager *pm, uint32_t *buffer,
>   	case KFD_QUEUE_TYPE_SDMA_XGMI:
>   		packet->bitfields2.engine_sel = q->properties.sdma_engine_id +
>   				engine_sel__mes_map_queues__sdma0_vi;
> -		use_static = false; /* no static queues under SDMA */
>   		break;
>   	default:
>   		WARN(1, "queue type %d", q->properties.type);
