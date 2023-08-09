Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C1B5C001DE
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Aug 2023 21:38:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2D3AB10E11A;
	Wed,  9 Aug 2023 21:38:37 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2082.outbound.protection.outlook.com [40.107.220.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 84A1110E11A
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Aug 2023 21:38:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Uq1a+0z1keexsekCqqocdY5H5Xa+QaPHJsIhVKiwo/1mTwAZ8bainXNBXQTDPFkaKCglRpBQWfjf635YdtGXkPRvAXzBrU71+QoQEzZ/OmahWkV7o0/L5B6IXF6R/zmhxvBPNpvJi6lSr0bYTFHboxFfBxu0XvgQrbyr2/OmUMtHBcWn2EH3zVXhufVOj1y4cmJ80u1dUZxMMsOCUGPfUpsraQWf6QOrZ5pceYPsSGh4gwqm9IbkGQm6qgplMYraX8wWTU4HwfYwORm/uDwpig0xnSFtTp94eoLdQexWxwnj7II0uBrPHlfzY5iEh7hylSpPW/rCLc7aQXALCJ7R+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gYTaZD6EPuf46alpfxgmYFvsYlGjqm3RqpvtCbDg0VE=;
 b=afcydeXurDrl+AaNm/egJquqp8N6kAJAllCCwdMz1sgwIv/1sv2dHIG3se8+2NyXdtvaOWp9+v9TqQJ15AuEYeRfqmyynHl/pOe7L/wC+mX494/4e3gl9uUsFYTzIpAjXjBD7yyS4GSJVB3ywgt8UAEKFI52C32Y48Cr83l45mCBWL6WC1cPCcgLx1C02O5VGRGzVOigD/DLYHUtXhgzNhcsSJmxDRhRPpr0Agx8lN3qRqM68WeFV8kd9Ieyxj6oSPBl/ATUcIXsxXAVJnn9m3Hpt5OtoGoS4g+l3gm86RWJ90+97baGcTT5gq7tRLv5aHUYTNwOUvFAekpBLZm6Xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gYTaZD6EPuf46alpfxgmYFvsYlGjqm3RqpvtCbDg0VE=;
 b=PL6TpDlOl71Tg4KJuNlxbZ673s/g7R0xohYcm3IJH9+4sS2uaqTJD0xNCAPt+ierX3buptc0MgykDaXms8Q+Kmrud/sgCqbM//DeSbUF94JTz1/om0DIto5SnKGsD8rAymzYXw1hpowRgUHmRpOFH0YED0mHo5I9kbVNqcvVsMo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5112.namprd12.prod.outlook.com (2603:10b6:208:316::16)
 by MW4PR12MB7239.namprd12.prod.outlook.com (2603:10b6:303:228::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Wed, 9 Aug
 2023 21:38:32 +0000
Received: from BL1PR12MB5112.namprd12.prod.outlook.com
 ([fe80::aab4:88af:7781:60e3]) by BL1PR12MB5112.namprd12.prod.outlook.com
 ([fe80::aab4:88af:7781:60e3%5]) with mapi id 15.20.6652.029; Wed, 9 Aug 2023
 21:38:32 +0000
Message-ID: <30e00add-b511-8728-0954-7b7f54d828e2@amd.com>
Date: Wed, 9 Aug 2023 17:38:30 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] drm/amdkfd: Add missing tba_hi programming on aldebaran
Content-Language: en-US
To: Jay Cornwall <jay.cornwall@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230809212615.137674-1-jay.cornwall@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20230809212615.137674-1-jay.cornwall@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: QB1P288CA0013.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c00:2d::26) To BL1PR12MB5112.namprd12.prod.outlook.com
 (2603:10b6:208:316::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5112:EE_|MW4PR12MB7239:EE_
X-MS-Office365-Filtering-Correlation-Id: 013240d6-f049-49f1-1fb1-08db9920fa5c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iVH04g+ixqOXQ+BTuYW5OhckHNGsmei5PL8oXrQKUrapOU3e2C1gerrw7LZu/kZk01utcxXES9QcbbfkZcbOWgvVOdHTs5AM4oQoEp855wxx9yyyjPKVmOziRqchHzYPYBqWwkkxojVKzWvPFVeg+u8NA3KKVg4NSpGNTN9kzkC4xFewHFAouulh9hmJ9caiOwpAjWH79QjvL4YEEwReLAyxkU2mmG3Mf4zvjOZ0gyNu4yhG5QIn1UmSvFUvaCGS35GxRz9lxgLNTxIDF4nfwEfow4qny0xBI3KM0tHQbu2ubGOAOGBTqhyrURwyd82VcgJrbIZVudjaKyXjSx1T7du4WXksFohxIL57WqEqhRuNyFARnVW50CuZb5wjB58Xbd8ZRyV4ct7yGB6xWyTiHaSIIzRfqVQQueHJwSLPEfK19TaTSYTa/Vy2Q/saBTj8IT+E4xZHmkxY0G7/65ug8RHYyG054xUmKnvMr5D2iRWUlrLiTpZtPpbRl3Q/4UtK7JQhaqO/Hixdtbjr+FHpsk5c5F2c2oEWAlIxhGvbmKFhkUAw7sAakTfJmtB6v+SRlUFCpSYisf5DOKHssbRipR2NtcfY63aH9/TK1OJ4S8Hlc6dxbK8xaxDKKwaLSrZ0uL5VghORM9uQf7LPExdGnA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5112.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(346002)(366004)(39860400002)(376002)(396003)(136003)(451199021)(186006)(1800799006)(36756003)(86362001)(31696002)(6506007)(53546011)(2616005)(2906002)(8936002)(8676002)(26005)(478600001)(5660300002)(31686004)(36916002)(41300700001)(6512007)(6486002)(44832011)(66946007)(66556008)(66476007)(316002)(4326008)(38100700002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SHdlRWY3NE8yL0lld0gwTzhsREdSVWh5MzRVWjNHL3pvSC9nK1dFZURTL0Nn?=
 =?utf-8?B?cWZJMHRqMEt0VXBSUGxuczdxYnozWnVjcGhSSEtVV2tIak9LT3FSMk1ab3RM?=
 =?utf-8?B?eEZ4dEwrRG1JMmI3L3N5U3lxU1ZSTkJ4RnpvYTZObGVsUSt2Tit6ZGxzbjV4?=
 =?utf-8?B?TGJoZWI0VUhBOHpKWWkzK0tkcWduOWhLYjdDbEFKLzhzUTd0VmxBSzM3c1Y0?=
 =?utf-8?B?VlJiN1JQbElkbHRtdFFEZTE5NFV2WjRxM3BEYmdGekJmMVQwSUJsRnE3d2Yv?=
 =?utf-8?B?SUNLeUtSVTBaSCs5ZC9uZ3VpVm9iUnM1VTl3SGxuM2QxZGFRa1kycC9CNUJi?=
 =?utf-8?B?UXU0WGhhVEVYV3pvM2Y0cW9OK2xKYjdtd05aUjB4ZW05bnA4cVdlU3VicVYv?=
 =?utf-8?B?R0ptcEVENUZTNXVqVXhEQ25vQm44Nm1RRjdXcHVHRnZFL2dsdmxVWVhhSmZt?=
 =?utf-8?B?SFFmemh4OFEvSytvMk50OVhVZzhjYm9EODN4dG5jK0tsQXYrc2M2Z1pxNTZn?=
 =?utf-8?B?WHhzQ3VqYVRHY2pzTzMrUlBBbFRmYTcwcWZGdkZoQ0Jvd0lqVFI0VldYUGd0?=
 =?utf-8?B?WnRocEZSbWM3UzFCNGM2bG1TTFNscWorZURUSVdpWTBodGo3dzZOUHM2LzhY?=
 =?utf-8?B?TW9BbExTQ2hkTmJpTE1VT0FaUmlzMGNtV0VENkY3OWsrYkgxVnZ2SVNOR3Na?=
 =?utf-8?B?YjFVYjdCK0FheDF0R24vUE1Db3VOREJhak1mNlJzNWtkS3hJMHlzYmxPeU1h?=
 =?utf-8?B?QmUzYno1TFJxN2tEQitOdCtnTlRQNGJrT2MxQkZNZWUwU3NybU94cFBwbkxL?=
 =?utf-8?B?ZVBCNHRZTHM4TzZ1VWFGd2N2Qk1wbytGS0o2cnl5eTRuVVBGcktvb2RtRkRJ?=
 =?utf-8?B?bmwxLzhjSURYbmN4N2NUSnpLYkR0M1Y0V2xDbDlSckYwb3NjR3BOc3ZrZkdk?=
 =?utf-8?B?dlE5ZXA4a25pUU5GekxOQmpwT0pVTHREcldaZWd6QXVJTUZUQ3E2YUgrV0c2?=
 =?utf-8?B?WWNieG9OWDZvS0ZmdjNGa25FSWtaSUI4aXlqRHUrOWU2cDQwQUppWHhsdUxS?=
 =?utf-8?B?anE3ZVZiZ3RLT3ZrYUN5MUZSK20wT2QzQ3pBcHAzTHVIbjMraWJhZDdvTDhi?=
 =?utf-8?B?aUdFYnRKcUJWdENqZ2xKaCtGbVZJM1NhWnRUNmlhZVBIR3h5M1BScUpZaGI4?=
 =?utf-8?B?NVVSdUtTVFZST2Fmc2NMTWpWS1c5WmJibm5xN2pRUEFhMG51UkxrTC9pN1Fs?=
 =?utf-8?B?UVV5d0NES3lkcDZPbjBZclp5cUxxRjhzQXg4TzNBMWxDNzF1dElvMTV4YTI2?=
 =?utf-8?B?T2IvUlVma2RudEhyczRuWTBhejdWVDdtekdmZnFDY25aaUhxMGp0TVFMWG5q?=
 =?utf-8?B?NW4zUlVTam1uNlh5WHV2cWEyWThGZjR0U2trRVlrWFlxeWtEaHlWa1QzaUYw?=
 =?utf-8?B?N2lNQ3FsQmwybzZwSUhXM013VS9aQzNmQnYrVjA4eldIYmRPWVNJTlNDaXJV?=
 =?utf-8?B?eTFwN2c2cXBpL25KcmNWWTFiOC90RkhOWGx5VlNtQ0J3TkJrVXkwVWFxSm1O?=
 =?utf-8?B?WTJhMEMyaTdRVnMwMEZPazVEYzlTYm15d014U3FhRGNySC9VczhURHFkOE5y?=
 =?utf-8?B?WVBIUXBDcjdIVitEcWVMQ0FheWR2S2wxTHdpaXRGdzIzR1pXY2NzK0FVSE81?=
 =?utf-8?B?aHIzMXVNaEJTVWdNZ1RUK1pMcFBuZ0NxZHRCRW5LS2E2VDZVZk53OGJ1NGp0?=
 =?utf-8?B?dHlSamJWaDZwLys1Q04zNDhDNFV6S2s2K3JpalQyM0IzQUJHcGV2MlZPQU53?=
 =?utf-8?B?Y2FUTUhRMVNtRDZtcVB1Ym9tOC9PSjU3ZW9wN1FYUi9LcjNMM3Z1MU5oVVJY?=
 =?utf-8?B?ZDJ5eXErRHhEeFpXdElOeDNWeXZnWmdmMWhybVE1U2JBTWpWWnJrazI0UHh1?=
 =?utf-8?B?SVNiaW9tbTRHRjZxR0JHamh2OUJ6dXpRaTBFbkVGTnVibFVJVm5sQUFXUERz?=
 =?utf-8?B?NXJEWDZvUzdWM3UxNjkyYTJwcHUzekI4SEwySHB4TFNrclRacU9lMkJhWS9U?=
 =?utf-8?B?d2dRdzVYUEcyNWxpbjRIRjl4OEk0NWRqUW9oeUp4L0s0TU9YR0FONjcrbVls?=
 =?utf-8?Q?yOcyDCT2S1r4EP3Amr07RSfq9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 013240d6-f049-49f1-1fb1-08db9920fa5c
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5112.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2023 21:38:32.3115 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cHiGofVzF/wTdUMMy3zCovzInqxk2mab2yqQwq+5Lylj1GF/EepO8oWVeENw5gp5xpWzd2YGTsXFvkpC80G9Fg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7239
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
Cc: harish.kasiviswanathan@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2023-08-09 17:26, Jay Cornwall wrote:
> Previously asymptomatic because high 32 bits were zero.
>
> Fixes: 615222cfed20 ("drm/amdkfd: Relocate TBA/TMA to opposite side of VM hole")
> Signed-off-by: Jay Cornwall <jay.cornwall@amd.com>

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
> index 8fda16e6fee6..8ce6f5200905 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
> @@ -121,6 +121,7 @@ static int pm_map_process_aldebaran(struct packet_manager *pm,
>   	packet->sh_mem_bases = qpd->sh_mem_bases;
>   	if (qpd->tba_addr) {
>   		packet->sq_shader_tba_lo = lower_32_bits(qpd->tba_addr >> 8);
> +		packet->sq_shader_tba_hi = upper_32_bits(qpd->tba_addr >> 8);
>   		packet->sq_shader_tma_lo = lower_32_bits(qpd->tma_addr >> 8);
>   		packet->sq_shader_tma_hi = upper_32_bits(qpd->tma_addr >> 8);
>   	}
