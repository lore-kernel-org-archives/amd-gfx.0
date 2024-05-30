Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E04D5C25B74
	for <amd-gfx@archiver.kernel.org>; Thu, 30 May 2024 20:40:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0BD1412BAC8;
	Thu, 30 May 2024 20:40:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="eEcGuA7f";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2042.outbound.protection.outlook.com [40.107.244.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 29FBB12BAC5
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 May 2024 20:40:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gSrr/A7VPVwk6FXeiZFjZCKrqZ+ymeSp8AAFfAZ8oy1xdGkpLABr4lIgwu1nQ8vo9a0Qh0wkD1H7By51opVU9n5CyDY7J4D8Cn13Opbmp4i0ksMwKZ8hSK5XS3hblUbBdw46Yu1fQxbkzQTero6ueqHk53uMyGUjIjvMepGCMei59WZctIhODiXHGLE02XWKbrUWh3LFDWAbEn1P7BiMzG/RZKKgppYUqsYorRI4HhJ7aE+T9MvXXt/59RdI7B+syWvE/B5SfjzdeDp+bTb4ALz17tIEratW3xnCNM8/ezT4W8T3+VRrUgM4GNmueMf3q2flrJquyg80iqDXRkKXUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hpKIdE8GrINBPF2Y8S7ecJomng+zxNEMWu2dkndUjCc=;
 b=D6XauurcSoUr+HSHhF234wYUAqfJ4JMhuqABbWNMfsDa2lZpxgvbvMo1b0EtY3vkJMVTnMQuluoET13HMwFy3KRsdBUZnJP8/Lqijzr/EcP9RsPSIIwulMsc3rKFnNnrurCNbrj/R/qWoSNkFR6Q8+3fRB62UEkO2feK30YIfLyLTqr4xILeXTvhg+nsATPGRfOrzjAKjRNmc9Cw0Ex0ueCix152Ae9lc05yZawd3IdhTLPRxPQcT5/8B4zco6a26igUmZ2L6Y8Z63fVnehMqpytfO8C5L50fmYJc1IsqWtdwHe4vCykaiGJ0NBSMhpmXM6SBMDJGpN3ZcmccgLK/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hpKIdE8GrINBPF2Y8S7ecJomng+zxNEMWu2dkndUjCc=;
 b=eEcGuA7fpazoCg0i+ukTTlIsVsUvMu+nlD4+9DNhN31LnV7EQpQ4Djt+JImh9HMC1ziR1jIF/Nn+tRYSuPbSjiigy889GBeTKXZaos53VOzFdr9Qw0acEXlC7UURPTUajpncVrIKN/N/hZJmajY0eixsrouD2ObJyRAiss88l0U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by SJ2PR12MB7893.namprd12.prod.outlook.com (2603:10b6:a03:4cc::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21; Thu, 30 May
 2024 20:39:59 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81%4]) with mapi id 15.20.7633.018; Thu, 30 May 2024
 20:39:59 +0000
Message-ID: <aaba2dbb-ca5e-41c7-bc60-7f65cce6b775@amd.com>
Date: Thu, 30 May 2024 16:39:57 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/8] drm/amdkfd: fix the return for the function
 kfd_dbg_trap_set_flags
To: Jesse Zhang <jesse.zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Christian Koenig <christian.koenig@amd.com>,
 jonathan.kim@amd.com, Tim.Huang@amd.com
References: <20240530034848.2341406-1-jesse.zhang@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20240530034848.2341406-1-jesse.zhang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0033.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00::46) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|SJ2PR12MB7893:EE_
X-MS-Office365-Filtering-Correlation-Id: 8be06cc3-de93-4f6b-8fc3-08dc80e8ac65
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?a2dTYlpqYjExNWt5Y1gzQjB1MUZpRjZDY3RxZkw3UEpVVHNYZGNJYmE2SlIr?=
 =?utf-8?B?WTh2QXQ5U282aC9VUmJrWFFsMG5ObWV1L1VhSE9qZG5nUmk5K0V4UmF3dW9a?=
 =?utf-8?B?SG1xSWcrTkpBcUw1NURLc0duTE83OXh1RDdXdXF6V2E0Wmx6Rkp3VDgrY2U1?=
 =?utf-8?B?RTlCMEVIakErR0UzV3VYQ3lEbDhrTms0Y3NBZ2F0akJQTVpGcmFJaUJncjM5?=
 =?utf-8?B?ZUZIdzVrRkcycDM4ZmlOWktjNG0yeE12d2x4UzVyVWNucjZDSzNtbG5WQXZQ?=
 =?utf-8?B?ampxdms2V3Btblk5enlPYjVZS2k1cDFIa0RtTlI1bi9MMTdoSEdOUmZlR2s4?=
 =?utf-8?B?Q0wyT0ZaL3pvMm1Ld1RRbitXc2lBcFJXTnlsRDFzd3RoZ1VPTkwyUk9wZ0tO?=
 =?utf-8?B?cnFjNmpqRUJzZytDUmdMQ3hMUXRmN3Fvc1NGTmNGQmlpTW1JbFgzYzVMQW5E?=
 =?utf-8?B?ekswZytwd1B1ZFR0aFRtSHJneTczRlVKVjlwZVVSSlVhS1I4NFJqOXJMZFFv?=
 =?utf-8?B?RGJDMHJjTFR3VFBLT2hxc3lvcWoyRHNWNExHUElQTUNiRVUvSmVGeE96aHp2?=
 =?utf-8?B?bUxKMnp2NzgvVEtNbVNpNDNBQzNqQTRJY3BFa2lCY0pCcHJqWi9XZFE3aEpw?=
 =?utf-8?B?ZjVLQTMwK2llWlgzb1BFRTNLRzlSVkFmUGF1UUpORmRyWWs2NXNHaHZIcU9o?=
 =?utf-8?B?bVErTDQ1VFdDdmFKOGE4RDJLSDJzZlI4WGswRjFTRXJyTWdGTEh1UTZKcWxr?=
 =?utf-8?B?aklTWUFQWHdKUldCWTAxYklBeFlTd1J1dTc4YVdyTmdZWi95dEpMWFc2N25q?=
 =?utf-8?B?aFBnZi93ME5iMlZFd0Z1T1NxWVQ4dHhJT0FCOEdwOURIWHpmQzEvTFFyVHhj?=
 =?utf-8?B?WFl3UFFIZGF4QXlxdnpzVEs1OHFsL0FhSlV4RkFTRWJ4Z3NsNjVKNEluVXh1?=
 =?utf-8?B?YlFDOWFmQjJPTFVmZTlvNHRKaWhoa3dkMTMybUJITWdNd0dwdXJZMTAwQTNT?=
 =?utf-8?B?bC9CT1BvVTBLQVdpM3lQV0FWZ0hqMk5QZ3BnaVhGZnNZdlNaM0l6bU04REFU?=
 =?utf-8?B?RTVHNHg5YjcvMko5UTRFdUo1NWZVNXJCOWNEcGJuQWxQblpKbklYaytBak1Z?=
 =?utf-8?B?ZnBnOVEwRnRWWUtiVm1KZjZQUkdORkhDaHhYcXRwdVJudmRsZmxMcitneFB0?=
 =?utf-8?B?bFJ5M3gxYm1IUDZXV0ZTY09VUlVvTlNmNU83aWg4SDVYTk5RUUZuL1NveGFD?=
 =?utf-8?B?ODlyTXNMVWVXak9LbTlIbTVGcXo5WThnRU1iZmFGTmtDc1hpMXo2YmZkY3pF?=
 =?utf-8?B?SDVVNDc5b3AwaUJTVFVreE92K1pneDJoMVVNcVVzN3FZUDBJa3VtREFyYm5T?=
 =?utf-8?B?K3E1Q1NlNHlha1ZwVms1eWxGM09kN3hvT1BpdjRsVFBvL2RuOVdoVmliU2pn?=
 =?utf-8?B?UUV1bnpuL1FHZkFCczJJVTM3dkwxSTkwcW5WWXF0OE1PcUJPVjY2cUJDbXZ0?=
 =?utf-8?B?MzIzN0VJV3RnMm1ObmxDUXdHQzc4T0RCMHErRyt3cHhvVUkvWEtPS1FxTi9W?=
 =?utf-8?B?L1JjVHFaMDgrSlRxTzRTWlZKUUVJSkNVblI4UEUwY0h1clZuMFhPT0xac1NC?=
 =?utf-8?B?QnZYak5NOFI0aW4zazlNTkZpdUFxYi9OWUU1OFFsQWtWOVhGb1VrdEJLaHA4?=
 =?utf-8?B?UUhNT1NkR29BVFc3dHBUajlRam9ha09mK09wOEVNYTBXR3lRSVhRd3ZRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bW1LQkY4QWhpNkhDZTdrR0tUaHJWdVFJcURFaVhYV0tHMWJtam1QRDBJQlo1?=
 =?utf-8?B?ZFZxdWNHR203cVZGcHNKY0szYkI1MDlha1ZsNk9uYkNUNjlPWjMzZkw3cVNN?=
 =?utf-8?B?bjJ0Mzc0U1FLR1B0VHpEdmVlTlNVRjdxWVZqQ2dnT0p4amE3czkyTzBsbGVu?=
 =?utf-8?B?Sk84SXJDNnE4b05wNnhNNDMrVVliaHI2djlPbFRDTEg4MDF6aWpoWTdZOWkr?=
 =?utf-8?B?VWRlY2xEbDJiU2wxM0dzZnZiTWNrSmEwOGp5SjdEQzBXOFpBOFNCd2MwRW9P?=
 =?utf-8?B?QnN4T3B6eVhRQVlNbStXUGVsRHNGU0NKRS94dktkVk9oMXR5RVNLeDhiUGtj?=
 =?utf-8?B?d2kxeG9oODExN09jODFZUGpuakIvN2xZZXEyU291M1BHWVZPUFVtSVc3SU5N?=
 =?utf-8?B?NVRKcjhnL3EwcHJzN0FHUzMyM29IR0NDY3JPV2tFQm5US2g4NG1XRDhkUFZB?=
 =?utf-8?B?QlNZSiszN2Z2S1RyT0svWmdYcS90TmdxRjhwTG1sbHBRMDNvV2dKV3YycGRn?=
 =?utf-8?B?M1BiQjdXOStUcVN4aTlVOEduWlNtYzdhL1djQmpYMnh2dXBHRExnR1dJZnFz?=
 =?utf-8?B?UEFIcElqMlNHTGdwRlRLMkR1UDI5TzRzc05hZUo5a3RBUUYrVjRHUlBPWXhv?=
 =?utf-8?B?UytJU3hjcGN2T1J1NjU2Y2pzOEJ5Q0RlY0tMSDBMcGE2WGxxOHVUekVVVG8x?=
 =?utf-8?B?Sk1lRWhXb2EwYTQ0Q0RLWUdXRktNL0pKMkN6WWJVei9qeGo0SDNZUEJWeEpI?=
 =?utf-8?B?cHJBY2FXcGF4SXQvcmd4VHoxMWoxVFZIT0Q4aWdrRVNNa1czbGlKV2pGc3l2?=
 =?utf-8?B?TklQaU9SL0Q2bnVhRTBBR1ZXWGFkbUxBU014azllUHBIa0VaMjJMdzJvejRj?=
 =?utf-8?B?THhYeXk1czN0TmlFN2o3aG95TkZ3TkRrYmpKaW9ncGhlSlFQUHhRNkYyU3FR?=
 =?utf-8?B?N1p4UWhpTFcyUlpqK3VaNjBJeEVQV3J3b0hJcVhqUmpYVk1mcGNVUXh5QjhL?=
 =?utf-8?B?aGRjRzdHVmgzZkFMclpiZDBpOFlHbGE5SkF1bnB0RE5QVnh2Vk5RSWkxK3NS?=
 =?utf-8?B?VzJCZTg1Z1hpb2hBUVdTeGJLZzBXUmZXb0JMWDhUY3pvWG4rb0JPc1NhK1B0?=
 =?utf-8?B?aTY3NEVLOXFOc3UxYTFrb0dySzBYUXhrVjRxWGtlWWlxSVNoSUhOa2tnWDAr?=
 =?utf-8?B?RnVQNnFIWk1TdE9CZ3YrNXNwYndYVW0wZ3RzbHdlVTArd2tWS05nbHhPOXBm?=
 =?utf-8?B?dlRsQnExajdwWGZUV0RydnNMdGRycTUyWlNUY2QvZXRoQ1pOQjZLMmxQN3Ev?=
 =?utf-8?B?SnJpNC9qaUd0TkplcUpPUkYwMzhpZmw3eFdEMUxxcDJMNGJCRVZzMUV0MGxa?=
 =?utf-8?B?cWg2ZHpQUWszNEMralVCRlc1WDEycTUrNXhwS0V5cWMxQ2lSRzlBLy9qelo5?=
 =?utf-8?B?M0dleTNrMkJrcW1iYTNMRElXTXd3TU11RjBGRk9WbDRKVmN4YjRZa2Q4K0tJ?=
 =?utf-8?B?dFp5YnNoOTlBUjhIZFBpcHRpZ2luOWR6ZmRwb0EyUmtOTzZna0FvWlBwTkVE?=
 =?utf-8?B?ekdtRFQzTDJFRnBrU1dTc3h1VmdlUTFEaUtTQmRqVXZsR1ViMlVVeUk0Snlu?=
 =?utf-8?B?UXFWem5wRDVGeWJZaG5NckxkL213QTlmODc0bnJiMHUycHpqdGFpR2IwKzJE?=
 =?utf-8?B?N0RtdXE5UXlvOHdoUzgxaGtXeE9tam5PcG8wODlZY0tPUjVYL2hKQ2JJS2VO?=
 =?utf-8?B?dCtMVUlLcmd3OElXQXNKMnB5SWxFNGZ4OGVYMkJBRTlQSXN0bHVqVXQ0QTY0?=
 =?utf-8?B?b3VBVThmZ082bWNRTXZRcDdFRTlaaC9SWHRWR3pnWG1aU2xIUUIyUHBYVmsx?=
 =?utf-8?B?dStuN3FuUllsaTh1Y2hKZk5FNDNnOGxGRk1yTVU3azk1UGxJbS85UEJlVjN0?=
 =?utf-8?B?NUN6aGVjSG5STHlmNGtwRlZ3RlZ4UDRIRWNkOERqVGt1eWNFWUlwbi9KZVUz?=
 =?utf-8?B?dFZHY09uOW5nd3h2VElpMDRkUUJSd1UvNHZYakxRU3ZNNzhpeTgzS1liRWUx?=
 =?utf-8?B?RGNCWGpDMXBadXpNbXBtTXhlUEpkY0NYUnNKa0hXNHdmTzdNVkNhMktObjJw?=
 =?utf-8?Q?kWcGie1m2ShQLg6yuOrnv/4Ts?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8be06cc3-de93-4f6b-8fc3-08dc80e8ac65
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2024 20:39:59.5202 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n2P7j4x4mx/fPYll18ubKtXz4YSY8GdPygm5bVHX+zKLMkDq1KnMI7P+BjvsW9SvvgYZE+LYKxcW3QMKW3q1EA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7893
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


On 2024-05-29 23:48, Jesse Zhang wrote:
> If the rewind flag is set, it should return the final result of
> setting mes debug mode or refresh the run list.

No. We're rewinding because an error occurred. We want to return that 
error, not the success probably returned by refreshing the runlist.

Regards,
   Felix


>
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_debug.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
> index 4abd275056d6..d12e5f29919a 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
> @@ -548,9 +548,9 @@ int kfd_dbg_trap_set_flags(struct kfd_process *target, uint32_t *flags)
>   				continue;
>   
>   			if (!pdd->dev->kfd->shared_resources.enable_mes)
> -				debug_refresh_runlist(pdd->dev->dqm);
> +				r = debug_refresh_runlist(pdd->dev->dqm);
>   			else
> -				kfd_dbg_set_mes_debug_mode(pdd, true);
> +				r = kfd_dbg_set_mes_debug_mode(pdd, true);
>   		}
>   	}
>   
