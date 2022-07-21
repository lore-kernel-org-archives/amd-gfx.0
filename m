Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39D74C43334
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Jul 2022 15:04:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7BE0B14A55C;
	Thu, 21 Jul 2022 15:04:40 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2044.outbound.protection.outlook.com [40.107.243.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5794714A55C
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Jul 2022 15:04:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kUCPYYYhIPFC3Cqstt1vKgWogyzSgYaRIbyAYmpp8nVASOWONJJaXQzYGPJBbRTJvw48X+zjlmB0OVl5sVjD7qj8ISta1nVuqDlfCdLJCzUCgwLUqtgICohlng73s/bPOATHzWsY8BU/9Bz1VxvCEEPPbDEwsUdWW1jvkOe1vnoFeP0DTDIbKITJtYlocdF7qduotsL+JeJ7AaagtPXVmxpLwoZY2BAq3fyMWiWBB3/3I5n+A9XEWaBq7NYJ2bHi3UgUmznjivqQ+D+cuVTMyf6Ga73SsgHBQz5ancLrELtOWlzSFUadynYjkEg5yG2McukVjG14tOXFJ2YBdmtZQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n6Y7wgPbP6eyVJrMSLJ4/eukuOsWJRLJ88jmsE9tDGo=;
 b=GNSbIh8ErbVIp0swHb6xH12VtFJonfAGVc/1eRdE3P1SYNz+RLuZ9pNj5JyAA7Fz4kkm5ZrHP4ScJB79jtCHT8cPJR4pmuS7ltq5zXw0zn2uaMzxD1miHyPNQjQ8Mi7NnbTq1ocSHTM6xGEAq4RGMxAq1cmCkwvkxln98f2BH10CFYLcW+8VDpM9gYB4nIox14eYKrJ5RC4jwJ56dcqSI5TQecBeXKGtH5LtHbTBKRYNRWnwJTGy2TRm2k7gEhgM/GCKN0CYVVUZOSLS6o+hhYTQwpax66ICIT3IgidLLom8krXM2q0+MhjGNqGx9Y7H1DM23guaApu+z8owbS7yrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n6Y7wgPbP6eyVJrMSLJ4/eukuOsWJRLJ88jmsE9tDGo=;
 b=4r6qxKz8tjV2Pr6mBnYLh3hhO4Bim29ImeW84kNjXnPny3mhm7/JKJ2P7YdEA4oSCgnOnhsxSwsv5pSHCPBXYB7CzCSoIuxnTvUl6xhpWgiUuvviuI+cy9tG6Rt/hOaIY9BmODPsbnRqeFIociEyhYiH+R/kbOoExbJEzHUKoD0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by DM5PR12MB1466.namprd12.prod.outlook.com (2603:10b6:4:d::15) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5458.19; Thu, 21 Jul 2022 15:04:34 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::b096:31c:bfb7:fa0a]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::b096:31c:bfb7:fa0a%4]) with mapi id 15.20.5438.025; Thu, 21 Jul 2022
 15:04:34 +0000
Message-ID: <303bc208-bfc8-0284-bbb1-d57e6d1bbe09@amd.com>
Date: Thu, 21 Jul 2022 11:04:31 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/1] drm/amdkfd: Correct mmu_notifier_get failure handling
Content-Language: en-US
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220721134438.23653-1-Philip.Yang@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20220721134438.23653-1-Philip.Yang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR01CA0160.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:7e::29) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5771ecea-713d-4360-c6de-08da6b2a525f
X-MS-TrafficTypeDiagnostic: DM5PR12MB1466:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: faHRhE6LOuRK17h8GxNtXK1JZYQKm1MRNHS4Ih7ATqT4UBiWrecdQR/r6mM1hdLm0/9mqDH0uJz3rux5fToYmox1JE6Rgxvy9KhotXv3Y7D1t7BRMaoRJCuNbT7okHf7JxRc2SBcQ1ID2wNwL+FfV0BaTZoGrmJHTRjiCk8fm+u1WP9SbdPfQVVSi6ANdQ2bUmIEwXilC7qIOxVOavvhaLknXjLiR9b9Kh6uyuk4p0hhwqZy80VTOIr1evexiDG9CdEY2ZmQiKAW3SnTXGK7DmdxIhefo3/846QJR/e6ic12ntBddjjXuKk1xbTxIoYrX8ZiCRVS0p5g8eRFMEUCftfY9CAVC5mHDx5AqN5xQSAoO9qmyyg8Ri+GWUXT801xFmsN42ETHlmgFXWzKmGez1NNH3RBnvxWWNHpvDwfTeh3/MHVyYJVt5B504IVFgRUu+2SSFfegkRQXDWKoVngbyjQTSCJcvz6gpmQ9LdbM4iBCLVb0dENW+dc9GlM0pqki5xvMytTjpmxFNaowLbvPWc4CyCo2kLSgfwR84e/+ipIncPBR3k4Li0f30nyXX2x+Kvk5kHDjtyxamnS6oGhplncwE5ccY2of+9LXrVuVKvV6DMFPnx7Lrf3REICi2eMuCmLiuFfUJI3F+kU5Me/hc5R4KybqjZzF0UF30VqRXb/AggFCghHOLbRr5qaVnutB7aO+w8dXZbTKroF/7hreeLuHG7Yb8VQ9c31EguPLRdxqLRE/ASEAGmqGDKqTw5GdsNnsnxHYbw3LeSAGMZRgDTQWhK+HHVS97fBs5IeIHfhC0E56q4e/E55o5D3EvjSW1+bUapySNxlEqjtp0p3MQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(39860400002)(376002)(346002)(366004)(396003)(136003)(44832011)(5660300002)(8936002)(8676002)(66476007)(66946007)(66556008)(2906002)(83380400001)(38100700002)(86362001)(31696002)(36756003)(478600001)(6486002)(316002)(186003)(2616005)(6506007)(6666004)(6512007)(41300700001)(31686004)(26005)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VFZydGpDTFUvdDMxV1FSbFUwMU4rOEYxU0dOU0hid05lZXhMeTQ3RTRGYVNZ?=
 =?utf-8?B?S1RmV1pHWjg1N2pYbUtvWXFNcHEweXZUckJtSndyK2c3cnQyVTIvOTRGbTNC?=
 =?utf-8?B?c3ZtSTB3SHFkK0ovY0ZJSHBMNXVCNk1mc2ZlRUhCa0ROTGNpckUwUStHWWlB?=
 =?utf-8?B?czd6aDR3UVJ6MVo3cmJUcTVFM1RTT0xORGs1c2ZPcXlISHFHcFlzcVRzZkN0?=
 =?utf-8?B?dUNJdkxkQnVPejczdm5NMzJvTFoxK3dWNlBmZ2g4MHN0S3o4UGRiV2pzemp4?=
 =?utf-8?B?c0U3V0QvZkU4c2t4Ylp5Q212OXpsVE1xNFhLbSt1Snd2SE9XQy9Xc2dUT3NB?=
 =?utf-8?B?M0dMbVFCS2Yrdm04R2JlTjlsSTRXVFM3UmJBNkxkTnRvYW5rbDJjaUZsOTRs?=
 =?utf-8?B?ZGdQOTN2L2hxdForck1oeWc5RHpvZkFUdXFkZDJxVHowNEN4V2NULzg5VXBX?=
 =?utf-8?B?RUgwN0ZkWjF4SVFvRVVDV21NV2FKOCt4cEowbVVkNitBRzhpemFHbm9SSzB1?=
 =?utf-8?B?dGxkNWE2bVNPcVM5NlZ5OFdDMHBURWNFeEJ4dzFRVDN4dFlkMUJzd2FDQUtY?=
 =?utf-8?B?MjFXNGtxUFZiRmxBK2ZDMUE1dGhiTkNOZ0ZCaWd1Q2VVekxVM0M5QXpOL3dp?=
 =?utf-8?B?WkluVi9YZGF5b29BVEgxSDVEQUZlR0VYZWt3RnNzVmt4Z005cXNrNnp6OVpu?=
 =?utf-8?B?M1A2aU1sS0pUaTdjT0Z6cmVhdUlPMmllc3BkalRiU1VIbVEyeHlDN1dGWGIv?=
 =?utf-8?B?ZHp1WUlKVFdkQTRHQzFET055K2JjWk9RbXp5NUp2YnpOMm16UHlVVWxLOGQz?=
 =?utf-8?B?TUtMcE5RSno5ejJSS3RQQVRwTUd5WEtPbCtWT1VtakNLT2xRWGZHWWNKbksr?=
 =?utf-8?B?dlZRdmZ3b3IyWXErL0gvWTZDcElnRzdaOGNkNHVUWHdxQWt5RlhKMXE1Q3hH?=
 =?utf-8?B?QkphQXJ5ZWE2WkdqSHFMdjFWejNWTGxoT0M3cFpJUlRjdkRuNXNEdjIzenkx?=
 =?utf-8?B?Y0lmZHZxWWdlZ1A1QkNKWnljbnhTdFI5a1EyNnJvQ0JONE9pak9Ha012aVpX?=
 =?utf-8?B?QUJkQTJ4Z3RCZmtHNi9DR2t1Rk5jakN0TjFwTmpRS200bVRmcGhoQ3NNSWE5?=
 =?utf-8?B?SUR4UXNlYkJmRmk3R1hlbkdXWVYyK0NuaFlSbVVNWG9VclRyYWFrL0Fia2VM?=
 =?utf-8?B?ZnQ0MnMrbG1CamFhRXM3Vzd0c0VRUGdGLzJ6VnVmUktDOTVyeGwxNTFEaTE5?=
 =?utf-8?B?TXZWWGY4Q01RTG0xS2xYMTRJdlBQb1lTUkUxM3JrQzZvV0NQWVNSTjlxSHZV?=
 =?utf-8?B?STh5WHRBY0V4dk1mMTZUTjBKc2NhNmNxY21RL0U5MnBnTTlsaVBsYUZUTFkz?=
 =?utf-8?B?NzBDdTZpYTVOY281bFJoZUgrbVdzMXZIMGkvczNIdWxOeitkZFBiYUV3Tk9t?=
 =?utf-8?B?YzF3NnFnaFIxK2krOW9YbTZWc05yTVdra0dUdHV2cG9hOGJOWDVUd3R0Z0FG?=
 =?utf-8?B?SHorUTRFdk9XTnhkd2Z1R1E0MU4wSlNUL2RFRW80VmJ4U1F4a3NWNWFZUlkw?=
 =?utf-8?B?TGl4QUlweVcvNFFWTmZaS1VDS2c1bm5FVStVZkwxOE1jOGNvNjFTVHBaSU9K?=
 =?utf-8?B?c1pzUHJwSWZid3ZpNzQ4emN4L3liQ1pmdGNCQ0R0QWhyRjFuUFFUcUo3TVRB?=
 =?utf-8?B?VXVuakJCc0ZWa3NnRzFGVTVmQW8wWEN2OSswcXowUU54a09QT0owMHFRU2tk?=
 =?utf-8?B?b0pGZ010R2ZNV0ZzWk9mSUU5VzlrYXlpS2QwbDN1U2hHRnp6UHNORWZ4WEF3?=
 =?utf-8?B?T1FNbG9WcG1RNVo2blp1N3pkbWJWbHNjUHlVYkpTTDNDTTNlY0k0RHBXd0pj?=
 =?utf-8?B?L2d6Q25lZmNsZ3YvZkN6MExFeDd5clF0RkRtSUd4OWs3ZGNGcEU4TnhycmdP?=
 =?utf-8?B?UmxYVEdONnk3aEF6VVF1MTBwMHliVG9oVnZSU1hRazFpY1NCWVhBckt6TnFG?=
 =?utf-8?B?YVMxdUhOTGc4RWo5NldRS2xMc0FRTC9HRThuWnUybURCcXU3VEJ4ZVBDbmFa?=
 =?utf-8?B?U1RoWUNhYVcwWUQzTGJkaDAzS0xTNE1YcUJDZDdJS29LRk5pbXVleVBncnor?=
 =?utf-8?Q?g9qTDnmPdup5AdAvQLrW9uGuY?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5771ecea-713d-4360-c6de-08da6b2a525f
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2022 15:04:34.2247 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qx8l/m+m8w36/Cr9VWhrQEzU+VPb21H9OsNqelkwCFP75GzcFeIMlBoHzcRSHv1CYFIc1aK5bpk47C+IpY5Knw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1466
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

Am 2022-07-21 um 09:44 schrieb Philip Yang:
> If process has signal pending, mmu_notifier_get_locked fails and calls
> ops->free_notifier, kfd_process_free_notifier will schedule
> kfd_process_wq_release as process refcount is 1, but process structure
> is already freed. This use after free bug causes system crash with
> different backtrace.
>
> The fix is to increase process refcount and then decrease the refcount
> after mmu_notifier_get success.
>
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_process.c | 6 ++++++
>   1 file changed, 6 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> index fc38a4d81420..d8591721270b 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> @@ -1405,6 +1405,11 @@ static struct kfd_process *create_process(const struct task_struct *thread)
>   	hash_add_rcu(kfd_processes_table, &process->kfd_processes,
>   			(uintptr_t)process->mm);
>   
> +	/* Avoid free_notifier to start kfd_process_wq_release if
> +	 * mmu_notifier_get failed because of pending signal.
> +	 */
> +	kref_get(&process->ref);
> +
>   	/* MMU notifier registration must be the last call that can fail
>   	 * because after this point we cannot unwind the process creation.
>   	 * After this point, mmu_notifier_put will trigger the cleanup by
> @@ -1417,6 +1422,7 @@ static struct kfd_process *create_process(const struct task_struct *thread)
>   	}
>   	BUG_ON(mn != &process->mmu_notifier);
>   
> +	kfd_unref_process(process);
>   	get_task_struct(process->lead_thread);
>   
>   	return process;
