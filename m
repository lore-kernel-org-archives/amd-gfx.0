Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1280D3E775
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Nov 2024 22:29:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 800A710E03D;
	Tue,  5 Nov 2024 22:29:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GrRbUqai";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2047.outbound.protection.outlook.com [40.107.93.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 30B7510E03D
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Nov 2024 22:29:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GClJXPh6meecmx96a57/EFW+AdEErtxA0OHO2RnXxf1p39pl25SigZboRyfmeLYdIMDoyA1fh/VkK0GULsPyBzK1b2gPVSTxiLp1Z40iRoz93frAwbLNNQFlP32/kWAvUhr7bSIXogMJ/QvCam6EqfPioAkMaaX85nEI8nX2ekhYJ7cnTNUH3eX4mfaumamqiO4s6w8r+Y4qT1u2PjvgGoX/M9O3msXBm3D9wYr8aCZsXdn/SmdnAu5FohYKARFq/qlbD/oUgemQDjh22ud/Ag6gTP+njqoMTeKpYrMzr6jBnoSd6DOdtgLWo49T+Eo+8GQZ6+ytdPA4Ta2Pkh10aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1U7WNyXyuUYvn8/HWlCEtJJab6A6HeZpTfMqwoe/8uA=;
 b=tZmg22ydcyVvByf+Hw++wxZGRfKrZsUbzrAxWv5PnR+gIjgsgU4aq4gU8WnkIfzIHINlWw1x+vp0/50Ci3GnkCPZUHrrm8batXLo9uOtIYxezVtwJWyykMElXrHXDeCZZYDLaSITF2o3w0LoK0svyOzBdaIT4pSskO1Aj5mJ34SFMAvjULRogADj7niuah19bqrimDA4eNiSni2tdRLMtgsR79EOkaPNsj56SMnBkLNVGZFqSFKXoM35bN4PhqfiJH5cE4DegtRN4auGsUIKM13EJk/Xw968oThf4p10zkUYnkZaiyBSj8BE9Edkc0oSekUjRyhN7Ag+75k8iojPIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1U7WNyXyuUYvn8/HWlCEtJJab6A6HeZpTfMqwoe/8uA=;
 b=GrRbUqaiYmV308OSbNenQ7GjNPmViUv2MsqM6xqn/seFBONinlQi6c1kHBYl5cC8xuhQhdJ5spp6gbq16hyKpWZ8ZBBRDL7H6M1qtvjr9yLom+nuPgFdUniF+xmxEfGwa+Letw5Hxl0iM87hdeRUOW2B7otYJmrPBuDfhydt4J4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6566.namprd12.prod.outlook.com (2603:10b6:8:8d::16) by
 PH7PR12MB6420.namprd12.prod.outlook.com (2603:10b6:510:1fc::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Tue, 5 Nov
 2024 22:29:10 +0000
Received: from DM4PR12MB6566.namprd12.prod.outlook.com
 ([fe80::31b:5d31:8ba6:abd7]) by DM4PR12MB6566.namprd12.prod.outlook.com
 ([fe80::31b:5d31:8ba6:abd7%6]) with mapi id 15.20.8137.018; Tue, 5 Nov 2024
 22:29:10 +0000
Message-ID: <2598b4ce-1b11-40e6-9846-2b0f6ab314ea@amd.com>
Date: Tue, 5 Nov 2024 16:29:08 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] drm/amdkfd: change kfd process kref count at creation
Content-Language: en-CA
To: amd-gfx@lists.freedesktop.org
Cc: felix.kuehling@amd.com, philip.yang@amd.com
References: <20241028204301.46168-1-xiaogang.chen@amd.com>
From: "Chen, Xiaogang" <xiaogang.chen@amd.com>
In-Reply-To: <20241028204301.46168-1-xiaogang.chen@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0068.namprd11.prod.outlook.com
 (2603:10b6:806:d2::13) To DM4PR12MB6566.namprd12.prod.outlook.com
 (2603:10b6:8:8d::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6566:EE_|PH7PR12MB6420:EE_
X-MS-Office365-Filtering-Correlation-Id: 814082d8-9c8a-446e-7eb9-08dcfde944ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bFNPcktsa0t1YWE5bEhQb3JlV1BhRmZvZTRBT0kvK0h1UVZkTTlRaGZuWk1s?=
 =?utf-8?B?NHV3TUkvSlUreWxFN1phemgzTkxBMC9kU1FoaWNraEdYVzQ3U24zYjllQkpr?=
 =?utf-8?B?QkdmZnBrRGlBQzB5ZVRlZTRLMVZUdlI3K0pKWUYwZXhoQTRYZHNZS1JpTTJN?=
 =?utf-8?B?c3hEZFVmUEJVOHg0eDNRMzl3OEZTbW1oZEFVVkxRRUpWc0pnaHg5cU55blFS?=
 =?utf-8?B?Q3oyY3lhRFdoVDRiQW4ybGlEMVVoK1VqYmt5SUJQRmovS2VHa0JhYmJjSE1T?=
 =?utf-8?B?MEpESS84R0NGck9tQjBBQ0ltbE5rdENSWER0Q2g2d2REM2JVUER6cHNPZW5Q?=
 =?utf-8?B?YkpxNFhtQ0k3TDFpaWFob1FPQ1poN0phR2QraEFPd1NIQk92RmdqMkxyaGEz?=
 =?utf-8?B?RWdnNVNVUnpvUWtacXd3aWZyR2UwVjllV3RpOHZMbXRNc0JMVWt2R0NJb1B5?=
 =?utf-8?B?ZkRpU2R5N3laU1plTTJvZVNBaXNlbDAzRUhuTUp3SGpXaGQvMGxvNk55eVFQ?=
 =?utf-8?B?VGk2U1l5dkpRdTJ0UGNLK1hyS1NsODNXMW9lK25QZk5pbkxyckVaay9IcFRx?=
 =?utf-8?B?ZlYzcGxtMmt1WFdUKzNUS2RsMkdHZExlQVVmNG9pZUp3Q3ZBUTBHUFMwS1Zy?=
 =?utf-8?B?SW5sN2VJaTVrSC9NZzhuNWQwS1BtSk1Md0hINHZ1Q2c2a2kzMVlFYkhoNXVu?=
 =?utf-8?B?dlBjaHl4VTFUU2cxL3I2aDVaUFI1bW1sZkxiL2x1UjFnOGV2NGJEL2pYcnZa?=
 =?utf-8?B?VHBwNjZuQVZIeFIyVWtVNG9IZXFRZnJZbWo0ajMzQ01NRUZIMGZtempoZkYz?=
 =?utf-8?B?dUsxMmI5SDJBYUxRWk9kN25Mc0N4bVdvY3ZYaGQrTWpMK3czb1JxR2lBb3R4?=
 =?utf-8?B?ODl1YkpLcWpGZHl6REFYdStMNyt3MUlrN3dFbVhnb1VMc2FSeVBjMEZ3Sm1C?=
 =?utf-8?B?bExBZ0pZZFdZUy80SWIyanhRSDdaQThWS3JmRDEwdkN0dmFoR2RCcTFLR3FS?=
 =?utf-8?B?anpkbDNaNG54OUNQRnppcTBQY0oyeFJaanZhbmdyREdnakxpT01SRngycTJp?=
 =?utf-8?B?VG43T3hTRDlOUG14bzBxdWJSL2VVK0tmSWJCMEgrb2NMRnRKRkZJSEx2U2pH?=
 =?utf-8?B?V1BzSWlsaXJ3VGl6ekowRUp4K1NvbHpjbC9GNFhma1VhYW45S2FOb1p5ZmhH?=
 =?utf-8?B?WHNVR2k0SDdCWE40b3pRaUl5eHRzeXpyd1dSbm0vVjN2M05JUWZtQmgyYlNS?=
 =?utf-8?B?WmxKa01BR3pnT0x3Ly9jSFZNaE9lSUxFQklBMnlkUkxMbFcwbjRuOEVORHov?=
 =?utf-8?B?aVRzRW1RL21vYlpZV3hiWkp6WUNmMWNMMmlLellldnZ5Vk0wTGxIRHVlRFBO?=
 =?utf-8?B?cW92QnZIZ1dRc2NDVnlSVGRYRXRHOG04SEJlcGllTlh0OUVRWWJ1WnFveEw3?=
 =?utf-8?B?ZXp1YWpVUnNKTlo3akVYTmlNZHVhL0hLU2hxVjJKZVZCOS9GTUZYWGFHaXJJ?=
 =?utf-8?B?TWprR1Z3dEVBTnBxaTR5OUNvZ1pRR1lIMit0LzBqNmQvdS9uRHFtUWRUVEJC?=
 =?utf-8?B?VnVlV09rZ05RT1U1UHI4cjZrbFp6ajJqOUd0THZLRWpHL2VpZmRSZDRWblVS?=
 =?utf-8?B?L0FnbGN3ME5EZURDWS9HbnV2dHVpVzk3TXJuQXNqRWd1UmUxeXNwaU1wd3hs?=
 =?utf-8?B?SnFBOGcvRFpyenpLemJyaEViZFAvODB3NFVZaFByZTR0N2ZzZHRxeWd5cXNw?=
 =?utf-8?Q?wgMP7dhUPAskyStlEfONGn+OnRjHLK+rNEFvO8k?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB6566.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?anlQZmlxbHdqZEkyL05rblFkQ2FOVnJxQXRNaXNKcW5qS050SnFDQnRmK0Vw?=
 =?utf-8?B?REFFSFVTMUovWjRRNGcwdzRQUGNMeXZFWm5WMFpjMHh5eVBmUDBZUi9kYW5u?=
 =?utf-8?B?a2Fna29OdnhFc092a29xOHl4UmlrbVppR29manJ6MWZGZjNvWHltd2JDUUVQ?=
 =?utf-8?B?UFA4RWJLdmlwa0hjT2hNNGxqdkFaT1RFKzh4Z3V6T1JMSDFQVjNsYjc4L2ll?=
 =?utf-8?B?MjY5WXlBZVc1MyswNTJSNlVwSkhBeGxsQ2dtaTUxKzIyZlFpRUY0QVJNUi9V?=
 =?utf-8?B?eE1Sdm93QXFIcGhPUVkxYzE4cGQ2czI4NWtMak5EWFkzUXBCdTFNSVRuTGRo?=
 =?utf-8?B?b1owRzFWTHc2V1lvUXFlbUU5akNHZCtSc2ZhRFhWcXRNbXV1UExBNjNnVDMv?=
 =?utf-8?B?OFZhRjdQYVdyMGxRaVFZa1dBSjNTNTRIRHlDVmlhL3FhSnMwSWhsMlczMms3?=
 =?utf-8?B?R1FZMmVWamRTRWhWd0k5cUZiR3NNTGJSWGZleUVOcDYxZTNuZE5Oc0g1RE5Q?=
 =?utf-8?B?NnVCd3JlMVVYU2grRE5aTUVMR2F5aXR0WW9ld0Jsdk1zVG1ENlNSS1luWFVz?=
 =?utf-8?B?b0lDSzNQdVhLWisxZnI3TEZlWE9IQVRGekg0OGlJcnZ3bmVRbWQ3NEZ0Q1JC?=
 =?utf-8?B?SFdaZXZQVXExVWJ6SmlqRFpzejhhWVYwSUR1QXkrMnIya3cwd1pnaFgyb1Aw?=
 =?utf-8?B?Qy92YUhmUUNkTU4xaUxYcm1KYXo4TzlVdkhzZjVUYkl2aUNBQjRZQnAyNk4v?=
 =?utf-8?B?V0RCaWFFUDNrWFJsVXBMVjdFMVR3VmJwUFhnZFVETWlGbFplY092QkNRWTVr?=
 =?utf-8?B?WnRiU3lIeEViN0RJamJQcjh0a0dDdUZBZGd1NUhEYnpNSWdLVyt3ZjMzYjJo?=
 =?utf-8?B?eFNVS2tNbUhEL0Z4bjUrVmp0Wi9MaEpHK1JYTEZPdndPTUFUOTNwWWNITTQ3?=
 =?utf-8?B?Qm8ydm5OU01ONWQzRTgxdVFFaENLZko5dFhXeXRqQjNiTzhLNlA5NW9ud3lr?=
 =?utf-8?B?NlpxL2ViOXdVZ2V0TUQ5US9rTm9HL1MwVkpHVWtMRnk5ekM2K1N6YUpBL3VW?=
 =?utf-8?B?M0FFN2x0VUw4ZnhPaDFVbHUxYi9udEJRaEVBaFppVitldk9RYlN5aGNLdjRo?=
 =?utf-8?B?eS9ZTmh5WXgvcFhYWm9jSWhlMXZJc1lrOVdyaStVWEFQMzRtejgyeS8vSlNx?=
 =?utf-8?B?TXZEdjMvQ3RmTyt4WldnM1U0YktjMGRoMmNMV3ZIRUJhelpUNE1BRUlQaE52?=
 =?utf-8?B?NTJ0eXpYR1RDd3c3MURkT1JSWU9rbEFLaHludWV0YVdFbWdPM0NzdzUrZHhC?=
 =?utf-8?B?cnRHeGY1WGhGanhMb2Z0b3VUdUZDREQ4RE44Z1Q5ZnhOVXJSTk9uWGRiQ0Jm?=
 =?utf-8?B?QjhZdXFXbUMzbE9kK2RaMmJLMzhuelJjOUFuaTBsVmNTdnU4NDR6SkVKZnhz?=
 =?utf-8?B?SlJsUVNjaUtuYzJmQk5mSGMzOWhCZmpQRGpPQlBlWGZNSUtHdS81bVRVWHcw?=
 =?utf-8?B?UzRjN1lQTkdtWG9jNEZBWTgrbXdxaW93bkkrRlVXV2NCUHplVC9Zdk1SMm9W?=
 =?utf-8?B?MTM2L2VCbCt3U00zbXN3RWNITTBPbEZ6SWdsTDMxTDFJTWwyZHJMeHVDNWFz?=
 =?utf-8?B?QzhBWHU5bTBybGEwaGZSNWtJa3pScVpWMzVwLzBndmlObnRJQ09zajhSYjhK?=
 =?utf-8?B?VEluZGhKbjd0N3Q3am9uR1VzNzZJZytwbTFZaEFVOU9hSjNKQ0grelJsZDJG?=
 =?utf-8?B?VFVtSHN4UVpqdFp1TERtcDhwRUVMalJScVRuM21GU08rd3l3WTUxSWxiNHBG?=
 =?utf-8?B?NTducUFsSlJ4a0owSlcrWm1oQkxpdVdEYVJoTFM1MlA3Y0Z2TzZLbEFCd2tw?=
 =?utf-8?B?WGlwR28vSDV3WDFXdTdIZDhaZTBJWFNLODFVdlJvWnZRZzRxelVwYjd6UzFt?=
 =?utf-8?B?NDA1VTY3WElqQ0g2NitFZ2dnSXQ5ZjVNT251RFRpM0lIeTlZREgwZmpUOE10?=
 =?utf-8?B?UHR5N1hjdUUvdFlndnJ5dGJQU2hMMmI2ZHlYZ3c5bHlXUXVRY1FkM3lnclVF?=
 =?utf-8?B?eDJIck5nV3cydFY3ajY2dFRkaWw2ZWdWNjBBRUFRR2pjRnZ3d3A1OCtWRHJh?=
 =?utf-8?Q?I+Lk=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 814082d8-9c8a-446e-7eb9-08dcfde944ec
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6566.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2024 22:29:10.7086 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tuX6cYsDx6FekWrzKdBdS1wIte6NO/tXnuGzGVf/ImP4j64+Sfi7qu0fF3L2u9ki
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6420
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

ping

On 10/28/2024 3:43 PM, Xiaogang.Chen wrote:
> From: Xiaogang Chen <xiaogang.chen@amd.com>
>
> kfd process kref count(process->ref) is initialized to 1 by kref_init. After
> it is created not need to increase its kref. Instad add kfd process kref at kfd
> process mmu notifier allocation since we already decrease the kref at
> free_notifier of mmu_notifier_ops, so pair them.
>
> When user process opens kfd node multiple times the kfd process kref is
> increased each time to balance with kfd node close operation.
>
> Signed-off-by: Xiaogang Chen Xiaogang.Chen@amd.com
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_process.c | 14 ++++++--------
>   1 file changed, 6 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> index d07acf1b2f93..d871d5320297 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> @@ -850,8 +850,10 @@ struct kfd_process *kfd_create_process(struct task_struct *thread)
>   		goto out;
>   	}
>   
> -	/* A prior open of /dev/kfd could have already created the process. */
> -	process = find_process(thread, false);
> +	/* A prior open of /dev/kfd could have already created the process.
> +	 * find_process will increase process kref in this case
> +	 */
> +	process = find_process(thread, true);
>   	if (process) {
>   		pr_debug("Process already found\n");
>   	} else {
> @@ -899,8 +901,6 @@ struct kfd_process *kfd_create_process(struct task_struct *thread)
>   		init_waitqueue_head(&process->wait_irq_drain);
>   	}
>   out:
> -	if (!IS_ERR(process))
> -		kref_get(&process->ref);
>   	mutex_unlock(&kfd_processes_mutex);
>   	mmput(thread->mm);
>   
> @@ -1186,10 +1186,8 @@ static void kfd_process_ref_release(struct kref *ref)
>   
>   static struct mmu_notifier *kfd_process_alloc_notifier(struct mm_struct *mm)
>   {
> -	int idx = srcu_read_lock(&kfd_processes_srcu);
> -	struct kfd_process *p = find_process_by_mm(mm);
> -
> -	srcu_read_unlock(&kfd_processes_srcu, idx);
> +	/* This increments p->ref counter if kfd process p exists */
> +	struct kfd_process *p = kfd_lookup_process_by_mm(mm);
>   
>   	return p ? &p->mmu_notifier : ERR_PTR(-ESRCH);
>   }
