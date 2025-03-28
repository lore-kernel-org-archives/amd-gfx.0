Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45B52C28B20
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Mar 2025 17:34:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D9C2410E93D;
	Fri, 28 Mar 2025 17:34:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bIM43YNR";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2055.outbound.protection.outlook.com [40.107.220.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1EFE010E93D
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Mar 2025 17:34:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DEh7f8CZcLoVG4FTLWoo/X/GHznyov7hx4CDaBqSV/rZagmzTzbDh2Z7QzKrnsVRrhZAHs9UmmHX3+yqaQIFdgaorIFtygoegzzYYAbS76SqRN389EpcetPLImv+lxTx7hTU08zyJjKWAqNmNX1J4fUhhvMCyHQFeQsMQhkVRq+2/eXcro0/IKC+K4lIsiUsbtIuUJAa393ZlDzoDEfydB3TjmGVDwDfb61f79bvnl1jhbvhbzYZycWXn9Q14XoFxClcdihbC+9qs8FD5xab+7EVg3mhUyMC7vVkIRxw7lmcOkVkuBqXgFkukUh7av7JM4bCHhI3vANnWeNPQKOB6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n82R/k2oUToH/ZEVJt1vo0++ZfVfJF6zAIHURHxqNb0=;
 b=Iybk8cMbKm9ekS75KRpEc6PYjU+3ImMkdgp/zeYRR9rnVjMsbao1Ptxl/klT3mN0YE/ZPoDPGVB50lFHz3Phd2SBYMVRA2B1jHdGWaXB94/HdLt9cFtwnRbOb292QasvF+UMYsUk4hxAotdZvGnaJNXXHlLleATEUVD/cRbpoSfaLrV97ito1KVejCG40A5oZi6sliHMxVENbso+OUhIClo+ATGEIsPSVkQS5Jv+CZzy8ha4m32FHP9r3+MiM/JvcwxIp1ulRCLvv2DjnSNjkXTGy1r9jfqhvBzx5npJ5w0GlVTtejBzQdFaqq5PRhcViMGOYxOGt1kMp1yhNuSv9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n82R/k2oUToH/ZEVJt1vo0++ZfVfJF6zAIHURHxqNb0=;
 b=bIM43YNRaoDnsM99U18lFE4Mw/r+lDMR6OyJqji3Wj4QDn4t/2kESqycrnvwd/n3/S4Iqs8uXx+s2IxNv7z0Y0db45z4oauPN3q7O9He/V3GF3S3sBoFqB7DowXJdBrvoIpfIaDXKItKxwZ/rQSbv/Mat9SMP0gego27zLBtYFs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN6PR12MB8470.namprd12.prod.outlook.com (2603:10b6:208:46d::17)
 by DS4PR12MB9634.namprd12.prod.outlook.com (2603:10b6:8:280::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Fri, 28 Mar
 2025 17:34:42 +0000
Received: from MN6PR12MB8470.namprd12.prod.outlook.com
 ([fe80::9559:954f:41e5:5d32]) by MN6PR12MB8470.namprd12.prod.outlook.com
 ([fe80::9559:954f:41e5:5d32%4]) with mapi id 15.20.8534.043; Fri, 28 Mar 2025
 17:34:42 +0000
Content-Type: multipart/alternative;
 boundary="------------q0nC9Ta2kgRvs9uB1uE0xDm0"
Message-ID: <eb926790-16fb-49fe-9d07-7bde068bb746@amd.com>
Date: Fri, 28 Mar 2025 13:34:39 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: Drop workaround for GC v9.4.3 revID 0
To: Apurv Mishra <Apurv.Mishra@amd.com>, amd-gfx@lists.freedesktop.org
Cc: harish.kasiviswanathan@amd.com, Lijo Lazar <lijo.lazar@amd.com>
References: <20250327174723.394804-1-Apurv.Mishra@amd.com>
Content-Language: en-US
From: Amber Lin <Amber.Lin@amd.com>
In-Reply-To: <20250327174723.394804-1-Apurv.Mishra@amd.com>
X-ClientProxiedBy: YQBPR0101CA0096.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:4::29) To MN6PR12MB8470.namprd12.prod.outlook.com
 (2603:10b6:208:46d::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR12MB8470:EE_|DS4PR12MB9634:EE_
X-MS-Office365-Filtering-Correlation-Id: 695ad884-5b75-427c-e2e2-08dd6e1ed2d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|8096899003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cWNqbFIyZ09WUnk2aXhmWGRWWEI1amJRblFZSHhrK1FyK2ptc2szQmhmdEhw?=
 =?utf-8?B?ajlsOUNiK3M4blJYNzI3SkVzTFZKcUFmNnNpTCtNZjV5a2YwR1pvdXRrN0Uy?=
 =?utf-8?B?SHowcngwVlFjeGxmMEZxNVcyZDNyRVNKTnJVVnUrM2luc3plMWsvT1dzKzQx?=
 =?utf-8?B?alN0azEvYS95eUx1U011SStkci9KcUlkUzU5bWgwTXdZdHVsemtNL2EvdmxE?=
 =?utf-8?B?aThqZ1l1NzNZbW4zbnA2VUlaTGZEL2Z0V2pMY0w5N2Y5aVlPNklXbnRIakIx?=
 =?utf-8?B?UjdsZUN6WFk0c200WXZ4UmlSakNPb2Z4ejl1Tm54VVd3dDlJMVFHSDlkOE5V?=
 =?utf-8?B?bnRDNTFBc1BpOExUZEhpNFJsNlord1FGdllQUFFzb0kvRlhuOHA1YUdCWmR0?=
 =?utf-8?B?OVNORHd6dDdQL1EvaGNMRjJLVTFpbHlpYWlaVHl6UzUreHhGMEpuRU5OM3Bu?=
 =?utf-8?B?L0ppUklRRDFYb0JtdzNpdUt1bWx6MHBaQmRnN3l1andVbk9JelNsZVA1ckhQ?=
 =?utf-8?B?c3laMzFDdTUyM3BrcGxCeFpRNFg0TzUvcnNqcVQyemkrSm9pd3NUeG5ZczA0?=
 =?utf-8?B?T2tKbnRQNUd2aWhlZVcybHR1ZzhqZ3E3RVVPN2J2VkhWM3NYY3VNRjV6MmNZ?=
 =?utf-8?B?dzBVNUpwSTJ6b3RtR0RWcWluVlFHOFlDU1A1NTJwekpiTWttRkVidUpxZVhj?=
 =?utf-8?B?VHZudi9LYnVJYlFQRHZKd21EU3pCRzNFYUJqTlFkMG9QV21wYW1zbHpPd0hD?=
 =?utf-8?B?UEU3ME9QVC80SENmVGZKeTE2Tlg2MW1xbU5wQWxDeitoUDJyNUZGdndhU2hk?=
 =?utf-8?B?ZjRLL0RBTkFDTVg4bkZ4OTVFMUdYcXlmdzcrYTFxVTRqazh2NTY4U2FEOVZC?=
 =?utf-8?B?bmR5UWNNbDdwWDB2czVFZmp4VlpHWm03YW0rekZrc2R3MnFwQkpwTGRldXgw?=
 =?utf-8?B?eEZmb0V2ZU9oRzdkYkQzRUxXVDB4QS9BTVErWkhzRXBZUlBIOXpabzNYTjF6?=
 =?utf-8?B?bVFRTlFaK1d4N2hzUlp3WVZYb1V4aWtKd0xPOVZCWWY2MFFQK2V2bXlaYko3?=
 =?utf-8?B?YWxZdDJDakdDL0N6ak16bmpWSDZ2NEZ1Q0hEZll2YmVzdmZkaFovUEVQNUor?=
 =?utf-8?B?M3JIenlJb2NwU05ZNVBuL0VNd3h6d01pY3FILzV1bm1pZHF1SVVYRTJ2ZUZi?=
 =?utf-8?B?eUVKb29sMU84M0dOYjNqY0tPZ3IzUCtMZGF2ZXpjZTY5OUhmTitlNlhvRzF2?=
 =?utf-8?B?SWxGMG1vZUE4RFdMZ241dHVFM3JqN3BxK2E4V1dJU1BiWVBSTzFrV1lzdjlI?=
 =?utf-8?B?RGhWbTBhNzg0c3FJVmxEeXQ3cXhCc1prdGI3U1Z1VXhhTmtoQ2pGbWZTL1Zu?=
 =?utf-8?B?Y2txdGZzQjZKaDIyNFdvN1N0UWhVYUdPY1hHcGp3L3BGVEtaWkJ2VXNNY2ZC?=
 =?utf-8?B?NmFJYTJWSFFzZHIyeVFubDIzMnJLRndmOGJGbzJsUU1QMVhBR2c5WjFxSWFa?=
 =?utf-8?B?eWY1T3J1K0k2amdtVFlWUWVXWjFJck9hU3M5RDJNd2MwNVlldkNRTnBkcitF?=
 =?utf-8?B?N3ExS1hqSGF1dXBlSnZTY3pubjRrSlE0bVo2LzkyUGlTNDkveWhDWDFTUEdj?=
 =?utf-8?B?QlE2VWp2MGpySGZCWmJXaTF6RDFqRmlpVEMxOEliVDBTd0ZFL3lYaHRwKzlH?=
 =?utf-8?B?cXhvbGFVTmd4WHptU2tpWmNsU2tiNE5VQWRWNGtGM0hTc2VhZmkyVGNmZHc5?=
 =?utf-8?B?c09XNFlGdVppSi82dFNpSmVtWEN5UHUySzJZcGxJSmlSZVZRZFRZMDkrQmlq?=
 =?utf-8?B?OU9QMlpGMkFOK00rektXN0VEYXd4Nmg4OG96Rm5KVTgwMWs4SlhzZUs4UFdU?=
 =?utf-8?Q?lxmv1F+cV9b/V?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN6PR12MB8470.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(8096899003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d0JiekZIZDZQZU9TT0FuUzRGTVdYQkF1Vm1lVUZnRGJrb3p0SjA1YWdNTG9p?=
 =?utf-8?B?bFluNU01aHhZUGNqYVA1SUVVZ1hyVHQ5dGpVQUJHc2VCekZIQitwUHBQNkZE?=
 =?utf-8?B?N1Q4TnlTMTU5Qm9mb2VjY21ZSW4zV1dvUGJ6R2dkaEZzYksxd2puLzBBNDBq?=
 =?utf-8?B?Snd0b2paN0l3UnlYYTg2aUh0bC9EdjNTNHF1MVUzK0xlZ1MzL3BJU3ZMK2Zs?=
 =?utf-8?B?VU1lcld6ajE2eWtobEx2Uk51OXNsT3U2NHNVYXhYVUZZcVU4YnhRTWFjd2RL?=
 =?utf-8?B?S2hSRnM2akpvZzdCRzRYbTJrdmc4K2k0R2YvUDdQRUFXWGhqMHNKTG5EK2Ru?=
 =?utf-8?B?dGV3WVRwelJrbVNaL1RLRUhKVnoveDRZczNqVE5tNEpjODYyWXAxRUFPQk5H?=
 =?utf-8?B?S2tWRmc4NGMwYWFQL2g2Uk82WDltZFdsRDlNMCszVFo1WnpnKzRkbG9HZTlv?=
 =?utf-8?B?Vkw5SnhYLzE0Q3NNU1grOG1zSVdWT25WV0FaSE0rbTZyWGN3ZVdFNm5aUzdK?=
 =?utf-8?B?MFo2ekQyVzFHcmVqVzBFZ3VicUJ3amxZOFhzS2tmcjdWSW1xS3BOejVQN3Ba?=
 =?utf-8?B?MXQyVC8xZ29Rd3Q5ZzlwQTBhUGdQdlp1VmhCU2FzSEYySjlxQWJieEFVTEZu?=
 =?utf-8?B?QmtwYmxiZ2lXNFhWdUd4Vkc2VkdWd01sUm1WZHhFaXFjVSsvV0ZoVlcyU1kv?=
 =?utf-8?B?TytMQWgzQUZsckZ0eEp6YytNS1dzbnpvQU9TalNoSlNPeE5qWFYvWmpPS3gz?=
 =?utf-8?B?enFoZit0bnBRTnhjWFgrV2tUNUxxT0Z5SktXVGFBUFhQdWZJdU41aHVOc1BC?=
 =?utf-8?B?K3FQTHd4d2FQWElFeDM5NWZLaE5DSnpERXVkV0FEbVBkZlFiWisyQkhLU2FK?=
 =?utf-8?B?dmtaYVliRk5jcms5a25UOVVwNkxnQ3dKa1RBc0ZaanJNOWt0MGFXUFBnMVJp?=
 =?utf-8?B?YzdLN3BSd1c4UHV4Qkt3OU1WQXVMWWQra3kvSk9LTkVLdDNNcXhlbFpWaFhN?=
 =?utf-8?B?ZXRvZGd1T3AxSkFHRDk0VUVWb2Jyb2NuYkhCcmFHeXVPSmo0VnhMTzQwbUVS?=
 =?utf-8?B?cVkwWnJLSERLQUlhYzBGSnJQYlF5VVVVcWpTZjMxaEpzZkxLcU56bVVjcFMr?=
 =?utf-8?B?cFoyU21HNmNVYmRXWFk1MW1RL1VvYVlsa0ZSalVmTkFXSlVHTzE1ZlRVVk84?=
 =?utf-8?B?d0NSak9oWDMvUDhHWE16eTNWUVk1a05SaWdrdDg2YXJOTU1hZm4vRmJ5dFJG?=
 =?utf-8?B?OHFOR0VySDZ0N3FKb1VKL0hXZ2x4V0tnQnBpNkx6b05XallKb1Z6MmZhTWth?=
 =?utf-8?B?WFlmZmN3cGdoWkxpT0Rrc2NRNW5DQmZtc1BMT0hjZmNUZEUzRjZWODRLZXJp?=
 =?utf-8?B?SmN3MzFpcmJTQW9FOGtTSU9wWHBHWnNUWWlONWpPOHFaVXJTdEFMQXpLNjB0?=
 =?utf-8?B?eXgzZzB3RmppbEYybU4xd0FKbFhSNkk5bUk2TDNwdGFTUmZIQUlHckFrb2J0?=
 =?utf-8?B?dndGN3gwU2VLNmhHV2FWR1JYc003Qyt4Y2hjb3NGT1dmRk1rMGNNejJxdW5F?=
 =?utf-8?B?RFhGUWQ2eURZbzMxNHE4M29nNGlZZEIyL2pkZzNLK0hOOHR6cE1GYUpXTVFU?=
 =?utf-8?B?cGEyUHlYc1E3VkVrVTh3WDdSNFNoR0Q4Q3grWjU1VUsralMvODZRdE40ZUVx?=
 =?utf-8?B?KzFKN3c3dlRrc1MwQ0xjNEJSc0FQRGZJV0NNTHZ5M2VTd09nWVdhY3diTGZo?=
 =?utf-8?B?bzB0bCtNeG11Z1NRT2thTFovQVZUNllleVQrOVRIZUxIRWp4YmFvdU1VcUZO?=
 =?utf-8?B?cmJDVFFBQVVtbDZPd3F3SG5BMExsa3hlOXhwVXRvY1dsZGhFcjhsOEwwNEJR?=
 =?utf-8?B?S244WEJZVkNkaXF1NnNkbDQyR0w1MHJiTmRBRHhLVVNVL3huU0Z1VkVuT0ZD?=
 =?utf-8?B?VWZsN2ZsTjBpY0dPYXUra0o4dldXTTNtQ1AxR3JoQ1hzakg1ZDZsZ0NIeXMv?=
 =?utf-8?B?V0dId2RNY1A2dEhubkUzOFRlR0tyNzlFTFFzUWdjblliRTBoeDZyTlFhaUo3?=
 =?utf-8?B?dlkyZDJ3b1FxdnlyN0c1SEdjZ1BDSzBGNUFXZzQ2TWROaXFoY1hZZFVUZU9j?=
 =?utf-8?Q?Ql8oAH6CCjwJrUzY68PiDWoZ4?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 695ad884-5b75-427c-e2e2-08dd6e1ed2d0
X-MS-Exchange-CrossTenant-AuthSource: MN6PR12MB8470.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2025 17:34:42.3359 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gfwywgwIxMh06qn9bE04XNN9DPmHyZOKQYVPrmyOINQVhb15lNtyLIV5eKyD9+RD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9634
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

--------------q0nC9Ta2kgRvs9uB1uE0xDm0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

A nitpick below. With that addressed,

Reviewed-by: Amber Lin <Amber.Lin@amd.com>

Regards,
Amber

On 3/27/25 13:47, Apurv Mishra wrote:
> remove workaround code for the early engineering samples
> GC v9.4.3 SOCs with revID 0 - GFX 940 & 941 - from driver
Remove "- GFX 940 & 941 - from driver" and simply "Remove workaround 
code for the early engineering samples GC v9.4.3 SOCs with revID 0"
>
> Reviewed-by: Lijo Lazar<lijo.lazar@amd.com>
> Signed-off-by: Apurv Mishra<Apurv.Mishra@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  8 +++++++-
>   drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c      | 14 ++------------
>   drivers/gpu/drm/amd/amdkfd/kfd_device.c    |  5 -----
>   drivers/gpu/drm/amd/amdkfd/kfd_queue.c     |  4 ++--
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c       |  3 +--
>   5 files changed, 12 insertions(+), 22 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index d4b01ef00025..81d314f2c689 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -2692,6 +2692,13 @@ static int amdgpu_device_ip_early_init(struct amdgpu_device *adev)
>   		break;
>   	}
>   
> +	/* Check for IP version 9.4.3 with A0 hardware */
> +	if (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 3) &&
> +			!amdgpu_device_get_rev_id(adev)) {
> +		dev_err(adev->dev, "Unsupported A0 hardware\n");
> +		return -ENODEV;	/* device unsupported - no device error */
> +	}
> +
>   	if (amdgpu_has_atpx() &&
>   	    (amdgpu_is_atpx_hybrid() ||
>   	     amdgpu_has_atpx_dgpu_power_cntl()) &&
> @@ -2704,7 +2711,6 @@ static int amdgpu_device_ip_early_init(struct amdgpu_device *adev)
>   		adev->has_pr3 = parent ? pci_pr3_present(parent) : false;
>   	}
>   
> -
>   	adev->pm.pp_feature = amdgpu_pp_feature_mask;
>   	if (amdgpu_sriov_vf(adev) || sched_policy == KFD_SCHED_POLICY_NO_HWS)
>   		adev->pm.pp_feature &= ~PP_GFXOFF_MASK;
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> index 783e0c3b86b4..8d3560314e5b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> @@ -1213,10 +1213,7 @@ static void gmc_v9_0_get_coherence_flags(struct amdgpu_device *adev,
>   		if (uncached) {
>   			mtype = MTYPE_UC;
>   		} else if (ext_coherent) {
> -			if (gc_ip_version == IP_VERSION(9, 5, 0) || adev->rev_id)
> -				mtype = is_local ? MTYPE_CC : MTYPE_UC;
> -			else
> -				mtype = MTYPE_UC;
> +			mtype = is_local ? MTYPE_CC : MTYPE_UC;
>   		} else if (adev->flags & AMD_IS_APU) {
>   			mtype = is_local ? mtype_local : MTYPE_NC;
>   		} else {
> @@ -1336,7 +1333,7 @@ static void gmc_v9_0_override_vm_pte_flags(struct amdgpu_device *adev,
>   				mtype_local = MTYPE_CC;
>   
>   			*flags = AMDGPU_PTE_MTYPE_VG10(*flags, mtype_local);
> -		} else if (adev->rev_id) {
> +		} else {
>   			/* MTYPE_UC case */
>   			*flags = AMDGPU_PTE_MTYPE_VG10(*flags, MTYPE_CC);
>   		}
> @@ -2411,13 +2408,6 @@ static int gmc_v9_0_hw_init(struct amdgpu_ip_block *ip_block)
>   	adev->gmc.flush_tlb_needs_extra_type_2 =
>   		amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 0) &&
>   		adev->gmc.xgmi.num_physical_nodes;
> -	/*
> -	 * TODO: This workaround is badly documented and had a buggy
> -	 * implementation. We should probably verify what we do here.
> -	 */
> -	adev->gmc.flush_tlb_needs_extra_type_0 =
> -		amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 3) &&
> -		adev->rev_id == 0;
>   
>   	/* The sequence of these two function calls matters.*/
>   	gmc_v9_0_init_golden_registers(adev);
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> index b9c82be6ce13..bf0854bd5555 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> @@ -352,11 +352,6 @@ struct kfd_dev *kgd2kfd_probe(struct amdgpu_device *adev, bool vf)
>   			f2g = &aldebaran_kfd2kgd;
>   			break;
>   		case IP_VERSION(9, 4, 3):
> -			gfx_target_version = adev->rev_id >= 1 ? 90402
> -					   : adev->flags & AMD_IS_APU ? 90400
> -					   : 90401;
> -			f2g = &gc_9_4_3_kfd2kgd;
> -			break;
>   		case IP_VERSION(9, 4, 4):
>   			gfx_target_version = 90402;
>   			f2g = &gc_9_4_3_kfd2kgd;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_queue.c b/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
> index 4afff7094caf..a65c67cf56ff 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
> @@ -402,7 +402,7 @@ static u32 kfd_get_vgpr_size_per_cu(u32 gfxv)
>   {
>   	u32 vgpr_size = 0x40000;
>   
> -	if ((gfxv / 100 * 100) == 90400 ||	/* GFX_VERSION_AQUA_VANJARAM */
> +	if (gfxv == 90402 ||			/* GFX_VERSION_AQUA_VANJARAM */
>   	    gfxv == 90010 ||			/* GFX_VERSION_ALDEBARAN */
>   	    gfxv == 90008 ||			/* GFX_VERSION_ARCTURUS */
>   	    gfxv == 90500)
> @@ -462,7 +462,7 @@ void kfd_queue_ctx_save_restore_size(struct kfd_topology_device *dev)
>   
>   	if (gfxv == 80002)	/* GFX_VERSION_TONGA */
>   		props->eop_buffer_size = 0x8000;
> -	else if ((gfxv / 100 * 100) == 90400)	/* GFX_VERSION_AQUA_VANJARAM */
> +	else if (gfxv == 90402)	/* GFX_VERSION_AQUA_VANJARAM */
>   		props->eop_buffer_size = 4096;
>   	else if (gfxv >= 80000)
>   		props->eop_buffer_size = 4096;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index 100717a98ec1..72be6e152e88 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -1245,8 +1245,7 @@ svm_range_get_pte_flags(struct kfd_node *node,
>   	case IP_VERSION(9, 4, 4):
>   	case IP_VERSION(9, 5, 0):
>   		if (ext_coherent)
> -			mtype_local = (gc_ip_version < IP_VERSION(9, 5, 0) && !node->adev->rev_id) ?
> -					AMDGPU_VM_MTYPE_UC : AMDGPU_VM_MTYPE_CC;
> +			mtype_local = AMDGPU_VM_MTYPE_CC;
>   		else
>   			mtype_local = amdgpu_mtype_local == 1 ? AMDGPU_VM_MTYPE_NC :
>   				amdgpu_mtype_local == 2 ? AMDGPU_VM_MTYPE_CC : AMDGPU_VM_MTYPE_RW;

--------------q0nC9Ta2kgRvs9uB1uE0xDm0
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    A nitpick below. With that addressed,<br>
    <br>
    Reviewed-by: Amber Lin <a class="moz-txt-link-rfc2396E" href="mailto:Amber.Lin@amd.com">&lt;Amber.Lin@amd.com&gt;</a><br>
    <pre class="moz-signature" cols="72">Regards,
Amber</pre>
    <div class="moz-cite-prefix">On 3/27/25 13:47, Apurv Mishra wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20250327174723.394804-1-Apurv.Mishra@amd.com">
      <pre class="moz-quote-pre" wrap="">remove workaround code for the early engineering samples
GC v9.4.3 SOCs with revID 0 - GFX 940 &amp; 941 - from driver</pre>
    </blockquote>
    Remove <span style="white-space: pre-wrap">&quot;- GFX 940 &amp; 941 - from driver&quot; and simply &quot;Remove </span><span style="white-space: pre-wrap">workaround code for the early engineering samples GC v9.4.3 SOCs with revID 0&quot;

</span>
    <blockquote type="cite" cite="mid:20250327174723.394804-1-Apurv.Mishra@amd.com">
      <pre class="moz-quote-pre" wrap="">

Reviewed-by: Lijo Lazar <a class="moz-txt-link-rfc2396E" href="mailto:lijo.lazar@amd.com">&lt;lijo.lazar@amd.com&gt;</a>
Signed-off-by: Apurv Mishra <a class="moz-txt-link-rfc2396E" href="mailto:Apurv.Mishra@amd.com">&lt;Apurv.Mishra@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  8 +++++++-
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c      | 14 ++------------
 drivers/gpu/drm/amd/amdkfd/kfd_device.c    |  5 -----
 drivers/gpu/drm/amd/amdkfd/kfd_queue.c     |  4 ++--
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c       |  3 +--
 5 files changed, 12 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index d4b01ef00025..81d314f2c689 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2692,6 +2692,13 @@ static int amdgpu_device_ip_early_init(struct amdgpu_device *adev)
 		break;
 	}
 
+	/* Check for IP version 9.4.3 with A0 hardware */
+	if (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 3) &amp;&amp;
+			!amdgpu_device_get_rev_id(adev)) {
+		dev_err(adev-&gt;dev, &quot;Unsupported A0 hardware\n&quot;);
+		return -ENODEV;	/* device unsupported - no device error */
+	}
+
 	if (amdgpu_has_atpx() &amp;&amp;
 	    (amdgpu_is_atpx_hybrid() ||
 	     amdgpu_has_atpx_dgpu_power_cntl()) &amp;&amp;
@@ -2704,7 +2711,6 @@ static int amdgpu_device_ip_early_init(struct amdgpu_device *adev)
 		adev-&gt;has_pr3 = parent ? pci_pr3_present(parent) : false;
 	}
 
-
 	adev-&gt;pm.pp_feature = amdgpu_pp_feature_mask;
 	if (amdgpu_sriov_vf(adev) || sched_policy == KFD_SCHED_POLICY_NO_HWS)
 		adev-&gt;pm.pp_feature &amp;= ~PP_GFXOFF_MASK;
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 783e0c3b86b4..8d3560314e5b 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -1213,10 +1213,7 @@ static void gmc_v9_0_get_coherence_flags(struct amdgpu_device *adev,
 		if (uncached) {
 			mtype = MTYPE_UC;
 		} else if (ext_coherent) {
-			if (gc_ip_version == IP_VERSION(9, 5, 0) || adev-&gt;rev_id)
-				mtype = is_local ? MTYPE_CC : MTYPE_UC;
-			else
-				mtype = MTYPE_UC;
+			mtype = is_local ? MTYPE_CC : MTYPE_UC;
 		} else if (adev-&gt;flags &amp; AMD_IS_APU) {
 			mtype = is_local ? mtype_local : MTYPE_NC;
 		} else {
@@ -1336,7 +1333,7 @@ static void gmc_v9_0_override_vm_pte_flags(struct amdgpu_device *adev,
 				mtype_local = MTYPE_CC;
 
 			*flags = AMDGPU_PTE_MTYPE_VG10(*flags, mtype_local);
-		} else if (adev-&gt;rev_id) {
+		} else {
 			/* MTYPE_UC case */
 			*flags = AMDGPU_PTE_MTYPE_VG10(*flags, MTYPE_CC);
 		}
@@ -2411,13 +2408,6 @@ static int gmc_v9_0_hw_init(struct amdgpu_ip_block *ip_block)
 	adev-&gt;gmc.flush_tlb_needs_extra_type_2 =
 		amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 0) &amp;&amp;
 		adev-&gt;gmc.xgmi.num_physical_nodes;
-	/*
-	 * TODO: This workaround is badly documented and had a buggy
-	 * implementation. We should probably verify what we do here.
-	 */
-	adev-&gt;gmc.flush_tlb_needs_extra_type_0 =
-		amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 3) &amp;&amp;
-		adev-&gt;rev_id == 0;
 
 	/* The sequence of these two function calls matters.*/
 	gmc_v9_0_init_golden_registers(adev);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index b9c82be6ce13..bf0854bd5555 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -352,11 +352,6 @@ struct kfd_dev *kgd2kfd_probe(struct amdgpu_device *adev, bool vf)
 			f2g = &amp;aldebaran_kfd2kgd;
 			break;
 		case IP_VERSION(9, 4, 3):
-			gfx_target_version = adev-&gt;rev_id &gt;= 1 ? 90402
-					   : adev-&gt;flags &amp; AMD_IS_APU ? 90400
-					   : 90401;
-			f2g = &amp;gc_9_4_3_kfd2kgd;
-			break;
 		case IP_VERSION(9, 4, 4):
 			gfx_target_version = 90402;
 			f2g = &amp;gc_9_4_3_kfd2kgd;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_queue.c b/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
index 4afff7094caf..a65c67cf56ff 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
@@ -402,7 +402,7 @@ static u32 kfd_get_vgpr_size_per_cu(u32 gfxv)
 {
 	u32 vgpr_size = 0x40000;
 
-	if ((gfxv / 100 * 100) == 90400 ||	/* GFX_VERSION_AQUA_VANJARAM */
+	if (gfxv == 90402 ||			/* GFX_VERSION_AQUA_VANJARAM */
 	    gfxv == 90010 ||			/* GFX_VERSION_ALDEBARAN */
 	    gfxv == 90008 ||			/* GFX_VERSION_ARCTURUS */
 	    gfxv == 90500)
@@ -462,7 +462,7 @@ void kfd_queue_ctx_save_restore_size(struct kfd_topology_device *dev)
 
 	if (gfxv == 80002)	/* GFX_VERSION_TONGA */
 		props-&gt;eop_buffer_size = 0x8000;
-	else if ((gfxv / 100 * 100) == 90400)	/* GFX_VERSION_AQUA_VANJARAM */
+	else if (gfxv == 90402)	/* GFX_VERSION_AQUA_VANJARAM */
 		props-&gt;eop_buffer_size = 4096;
 	else if (gfxv &gt;= 80000)
 		props-&gt;eop_buffer_size = 4096;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 100717a98ec1..72be6e152e88 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1245,8 +1245,7 @@ svm_range_get_pte_flags(struct kfd_node *node,
 	case IP_VERSION(9, 4, 4):
 	case IP_VERSION(9, 5, 0):
 		if (ext_coherent)
-			mtype_local = (gc_ip_version &lt; IP_VERSION(9, 5, 0) &amp;&amp; !node-&gt;adev-&gt;rev_id) ?
-					AMDGPU_VM_MTYPE_UC : AMDGPU_VM_MTYPE_CC;
+			mtype_local = AMDGPU_VM_MTYPE_CC;
 		else
 			mtype_local = amdgpu_mtype_local == 1 ? AMDGPU_VM_MTYPE_NC :
 				amdgpu_mtype_local == 2 ? AMDGPU_VM_MTYPE_CC : AMDGPU_VM_MTYPE_RW;
</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------q0nC9Ta2kgRvs9uB1uE0xDm0--
