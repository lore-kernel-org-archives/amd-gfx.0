Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34721C433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Apr 2022 14:07:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 548BF10EA51;
	Wed, 13 Apr 2022 14:07:29 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2044.outbound.protection.outlook.com [40.107.101.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D145F10EA51
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Apr 2022 14:07:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rx79F9+goFiQLTFf2NKCctVGDCfNESGUAZuK/rYZ8IuLB1/y+LmZqLKc7G0xBQiU8bdq16UnQHYyPPj8fzTMpVbeJ6ISYQo8RNL/4CHHiN2QJHr0xOeaA+u5KfV38PpgaQGdWuYDIQuW8TTKgurQQcLi8WOH5koWiltXvbEPlyzWI+0aWmDzQb3Y+Dapc+ip7QkokOmPXtglZ5SboL619sHBENcpVhECD4uA0UFB3IVKj+tyk0vF6cVHDLRCDkP80J+ZEYKYQ+7MmUv2E9rny2tl/bsPM4aX96e1I6fwFDecHHMRy+1m3MsTQMWQEBTeRCQK3lcgVSGSYuifkfI/2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TNZjl4l9nLm7zsUIe6TGU5oGaBlyjcpw7BSQ6ITvq7M=;
 b=S6H+cUDmeNYnmZEixzMCWDB7jSb5wKTtGx4HdnNGny7k4cXed669ZlchLEWBTPF/c9xLbr4ErsFrtfVUXf7BbttLoJueKu8TBMkmsl81EmT2Mm8HOLIwrlQJbWp+61yW/8BnMPe+rYm77A2uz5TFCLKGv5ZK0c4rtw9UYs2U4bHetts6vwzpCBtdkPh5IksYPV1fmVGl1c7qcW8elr9chNVzZixiOqfZhhYHRPig/D1klcCaMdI938ZSo06v22avrtwQEC4qwhbwjE8BgM4KOe6g43r+af7AgkNTX17bpldvnoe5IF7RcpzJP1LrFnuje8gLzpaFQ/v/n1Un1DgG7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TNZjl4l9nLm7zsUIe6TGU5oGaBlyjcpw7BSQ6ITvq7M=;
 b=mRYsbJtVy68h80/T0CO0n8Qm6kO8xyoup+yLWx+Tydbem0gDriIhl17Wiu3a/kB76J6NCIj5Bts+6mtPlKtcRUjty2cV8UNt4HHxY8xtEuipfUaxN2EXYsHqPemVsw3f2y/v9c5eIA27pgCEau3dSc6UCQrZVn1YMrmFZwqXjuU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3370.namprd12.prod.outlook.com (2603:10b6:5:38::25) by
 BN6PR12MB1940.namprd12.prod.outlook.com (2603:10b6:404:fd::18) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5144.29; Wed, 13 Apr 2022 14:07:26 +0000
Received: from DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::3111:c071:1ca6:1e9b]) by DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::3111:c071:1ca6:1e9b%3]) with mapi id 15.20.5144.030; Wed, 13 Apr 2022
 14:07:26 +0000
Message-ID: <6eb41b29-61a3-0db4-d386-714ff59da78c@amd.com>
Date: Wed, 13 Apr 2022 10:07:22 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v3 1/1] amdgpu/pm: Clarify documentation of error handling
 in send_smc_mesg
Content-Language: en-CA
To: Darren Powell <darren.powell@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220413050845.24499-1-darren.powell@amd.com>
From: Luben Tuikov <luben.tuikov@amd.com>
In-Reply-To: <20220413050845.24499-1-darren.powell@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT2PR01CA0012.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:38::17) To DM6PR12MB3370.namprd12.prod.outlook.com
 (2603:10b6:5:38::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9638f192-ba04-407b-3480-08da1d56eff7
X-MS-TrafficTypeDiagnostic: BN6PR12MB1940:EE_
X-Microsoft-Antispam-PRVS: <BN6PR12MB1940CA153CFAFA158CD365F399EC9@BN6PR12MB1940.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Dqx1J/4UlC8SatqgFvgoJNoodafeyt/8bws9ZQAhjVbvnuSLGfzpxbcnIZe31YtImGuAykS1eC9vQNR2rRtYHhSfMCsJDd23Ub8u4d/b4XLix9uX8Xk/UOC1ecXLufPw/HQ1AVnqs9akK+hhYH+x1oHUvQ8nDJXznD6aCQr+bT0zlN81/KWtgTag+wCxNkv1jNHDCjpCeBwWWi8SIOzA/pQUSqTOjTjJZ/iGafcBM6pLuttqd/8XdKuM0I6CoMop+oEK0faXENbFbNEhYlhiRag93qG4pHjCDulUCS/M8ed42T3dPrJRoC/jfkOnMvUWmFPIqV15JPl8pKDtX3lXsDORkIUCP+EZbztK6SGLyZM7Ua2CwlmVQ4s914TqqSwTJY6K1E6qIsK/SmK1wC2PJsOHwf/vxC+gfd2fPcHKN2dksPsAi2+l8XmnPXQBBDRWo6YCGemgy1r6rtNONnn47ThYN5xI6RGIpJPaZnLr9wpEoM06S4FHzSCtluuY36alhnvcuGZNi4j+7NmlQOx9z9hgd9yoXxJIM9oOn8PlanN/x4v9TFuaDd7kkwvXsJF2o7KhoaD10nJJI4v7Wb6Ay6Gj7xN9a5bGNxaJQAijH112IXkdogB76uKDesKjt887v2JfVOipvpNcHWA5bkeeA2qGFmIgoqMP80x84esOldhuHyTd7nSJfjbl5ehzyKoTYEjF4CB6k516uFqAAJxGvdORWy5NJ5knGCTA5Ly496Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3370.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(6506007)(6666004)(6512007)(83380400001)(8936002)(186003)(26005)(2616005)(53546011)(38100700002)(508600001)(31686004)(5660300002)(6486002)(36756003)(31696002)(44832011)(316002)(86362001)(66476007)(66556008)(66946007)(8676002)(4326008)(2906002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WEs4M1NKL0pST3ZVNDFueUFqeFRocG5NUFRWQ3V3c3FjeW5DTkx6eVhaQ1dz?=
 =?utf-8?B?Wkp0cXZKQzNhRVpZRFluL1hWODBmczNTS0VMRlRHQzY5UUlVVkxxRVZMQThO?=
 =?utf-8?B?OGZDcjRuMERkb1ZFU0VZbWNkZEhmRmdVRG9TNDBJYm9HdGpkcGJRNU1IMFZt?=
 =?utf-8?B?QmNlbk43c1UxZEN0QmQxOWFTQkRqZUtzNkd0UythRDd3WjloUXUyOEFUSXBM?=
 =?utf-8?B?elJGa1c0cE9PeHM5WUsyMXpDQkNNSnJ6SXRLdTZvY3FFUzZqRVlyNzkrWFVv?=
 =?utf-8?B?VWtHMHdicHAxWnBlMVF6WmtQN0RRS2dDYXFkcUZ0Smd4QyszdnhWZzBFUmMx?=
 =?utf-8?B?WWhySTQ4T2Jha2ZmR2s0NDdhNTJEdkVHazl1dlFnZThGK2VSSlZKNkpVWVBj?=
 =?utf-8?B?V3lxbTdNMW5SWkVHdUhKcERPakV1a29aazFZWEpiMExkOXlmOXI3WWphRzU0?=
 =?utf-8?B?V2tUVFZYbEJtK3JHVEc3dlZYWC8vcEVJUGROb1JnLzMwTk5KM2dzSDI4Z2p3?=
 =?utf-8?B?aUl1SncwMlJaOGNuRFZOWGoyTmdtUHVoVnQzK2tsUHZ3OHVaaThlUEtZU3FN?=
 =?utf-8?B?eElWV2pYY1B5RHZGeTJQcFhRY0lTWG1GUGtqTUd2NFlUVnF5TWJhYWVWQzlu?=
 =?utf-8?B?YlNjbDJzeGZodWFuSjY1TVNJNVE3L1VuQVVLTmVURlJiemdKYll3WGdWUkhC?=
 =?utf-8?B?WWhKbnl1U2ZwSkdyWnRtWkdiYkw5TTA1TlYzWWRkakNWaW1palZWejkxellm?=
 =?utf-8?B?U0xsNE1hWDRZWTUva3c0WDBuN3F5TCt4MmUvdlBPd0JMc2JJcThYUjIvVlMx?=
 =?utf-8?B?Ukx5MFNQUmg3WE9kaWs1Mk9oSVJhNXhlc0F4T1NUWDIrUEdzZkNZSnp2b2ls?=
 =?utf-8?B?RWxZcU00aU51cjc2SHo3WW5NRzVzODdaeGZsRmlicFVsVmJSMnE3dDVsN2Zt?=
 =?utf-8?B?K29UZlVyQmVkMWhvZ3dpSjBGS2hwbkZ5TXF3UzlMSndUcDJWYzhSc05XaUVu?=
 =?utf-8?B?eHd1Q0V4RnFQNnVML3IrYktRMlhXMlhCakFWYlZzVnhiT0RnVUhkMng2aURX?=
 =?utf-8?B?bmsyOFhEMnBMNnVjb2ZSK2pYdkg5NVZUK2hDOHFsZHJkVnpBakI3dzVTc2Rw?=
 =?utf-8?B?Tkw2cWJ2WHNqWDdQVDNFKytKd0N3bE5GWnRmUkFqMm1Cb0NRaEdkeU5OU2NY?=
 =?utf-8?B?NUxRcTJFNEticHlHQ0g2UTdyNjdidGtybEhpd0hMOU1uNTczSWNENjNCcy81?=
 =?utf-8?B?bGtNRys5QmRKMWxqcjB1N0tjTEhheDg1dFlVc3RTbFU5NnNlSEdDWGlhTWEy?=
 =?utf-8?B?ZHIwV1JHNW90YW9IWWtnd2dJSVZvMCt5NEJZZ1JQTmtPUncrSjNIMGZUY3Jp?=
 =?utf-8?B?cmNab2JZNk9vR3M4MDRBMndQZ2k3NEpLNlUxVlJiRzZaVnNKb3lRelJ2QTJV?=
 =?utf-8?B?Wkd4bVZJUXpYdnYzdHRjUzFLTzM3YjJTaDVBelJqUi8vbUxlU2JTaGhHZkFz?=
 =?utf-8?B?YktJRmg5eDM5TEx4cDZpenB2a2xsaEtLMExqbXUyREFRSXFZRmdPaldBMXdG?=
 =?utf-8?B?bGhFenR2cGx1VGxjaDRZSXVqYUFoT09pVFcrNWVERzQwREFpYjYxaXQ2dkZs?=
 =?utf-8?B?VkV6aXZQSVYwQzFMcTY3eWVHcDdvV2tkUjc4YjhYWXFDYkdWOVd0aFFTbEVZ?=
 =?utf-8?B?MUNyOE1lS2ZFMHV4STE2R3ZoNzQwVWhvU0NrQUNZL1MwekttKzFscUtKdTlO?=
 =?utf-8?B?bFMyQTQyRUhZejRtTS9wSWhCTE15TGlzZ0dlZ0h2UjlXUG5UdXBoK2RmVXR0?=
 =?utf-8?B?OU1BaUdTYld5cmI3M0lqRDl5eFNGVzhnQ00vNGlFbXRJZ1FNU0JyTmlWNDQy?=
 =?utf-8?B?R2pNdm5VN3o2SHpLbmhXNmtrcFRHY3BRUDJxdTRET20wZmhKcjVQeTNjanZO?=
 =?utf-8?B?NFYwL2dxS0c1WU9YZTkwMGx2Z2hVdWVudTk2TS9yWDQwUGxINVR5aC90VzNV?=
 =?utf-8?B?K1dJbXU4SU9WZjgxMzhmUkwreDhEbEhIbmVpcXFDUTMyU2o4cjBaazliLzli?=
 =?utf-8?B?MllscmdSVDNlbmI0cTRyTHdzUWVXTGZIanZRT1ErK05qTWt4azdySVFYMGd4?=
 =?utf-8?B?UUdGOHJSWnBSbWhXYXBuVnlxdVo4QStRSWVLSG54UWhpM1ltR0ZETFYrVnZH?=
 =?utf-8?B?SnFYTUszU0M1bWlrSzFtQTIxaDN6TjhFQXQ4L2VxYkRxclRwMVRGanR2NVdz?=
 =?utf-8?B?NTRMNENyRGh2bXVWZTdlTDJ4UENGd0RHR2NUUnBNbnlrTEdFVDlmRllUUDdU?=
 =?utf-8?B?eFY0N2V5c0FwQW8yMVhmcVB5enRKVXFPdXdGbWd3ZFQrUmM1UnJpZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9638f192-ba04-407b-3480-08da1d56eff7
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2022 14:07:25.9194 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 97WuhnHZecNp6VARLAh3NJ1sMyN/NYJuLy+x/USRMEYljnt/EyTm2ijKYINl1rsi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1940
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
Cc: lijo.lazar@amd.com, pmenzel@molgen.mpg.de, evan.quan@amd.com,
 andrey.grodzovsky@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Looks good! Thanks.

Reviewed-by: Luben Tuikov <luben.tuikov@amd.com>

On 2022-04-13 01:08, Darren Powell wrote:
> Clarify the smu_cmn_send_smc_msg_with_param documentation to mention two
> cases exist where messages are silently dropped with no error returned.
> These cases occur in unusual situations where either:
>  1. the message type is not allowed to a virtual GPU, or
>  2. a PCI recovery is underway and the HW is not yet in sync with the SW
> 
> For more details see
>  commit 4ea5081c82c4 ("drm/amd/powerplay: enable SMC message filter")
>  commit bf36b52e781d ("drm/amdgpu: Avoid accessing HW when suspending SW state")
> 
> (v2)
>   Reworked with suggestions from Luben & Paul
> 
> (v3)
>   Updated wording as per Luben's feedback
>   Corrected error stating all messages denied on virtual GPU
>   (each GPU has mask of which messages are allowed)
> 
> Signed-off-by: Darren Powell <darren.powell@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> index b8d0c70ff668..f12319883a80 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> @@ -356,9 +356,11 @@ int smu_cmn_wait_for_response(struct smu_context *smu)
>   * completion of the command, and return back a value from the SMU in
>   * @read_arg pointer.
>   *
> - * Return 0 on success, -errno on error, if we weren't able to send
> - * the message or if the message completed with some kind of
> - * error. See __smu_cmn_reg2errno() for details of the -errno.
> + * Return 0 on success, -errno when a problem is encountered sending
> + * message or receiving reply. If there is a PCI bus recovery or
> + * the destination is a virtual GPU which does not allow this message
> + * type, the message is simply dropped and success is also returned.
> + * See __smu_cmn_reg2errno() for details of the -errno.
>   *
>   * If we weren't able to send the message to the SMU, we also print
>   * the error to the standard log.
> 
> base-commit: 4585c45a6a66cb17cc97f4370457503746e540b7

Regards,
-- 
Luben
