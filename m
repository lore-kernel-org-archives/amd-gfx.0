Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94F07EB64DD
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Jul 2023 19:58:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E48C310E34E;
	Mon, 24 Jul 2023 19:58:58 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2040.outbound.protection.outlook.com [40.107.94.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9CBA310E34E
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Jul 2023 19:58:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B/TqAkVvXsbVA9uT9lML5uV9xC3/gyVwAUqkaPKOPq2KWO2LD9HC+4Mu/tjdeeky0fFGAnKD766uEkAcxodOLg3Geurpqa5ZevRZNzOWRhPCh8s1ZfRLo0FB8YSmPBzN6Is9c4LDH+MsaVnCssBCzxaEo6hq0y7mCMVvX/159wDLoeYyPmtnVzs7E5XENCrfUFd6B6K54swuaq4gPN9s40620sPUdut5rvyltfkvrwCDZgmRwzWUidhLMJQ/zbBl1EpQSAfV6SNsGJqscyOhVHOwBIFZf1oWtBlEaid8dpwALJrAPk1rbNlSfyH3cOQ8XI6GFrCSfpttFNNToCUGAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MS0uECjcxJ58mIAVKDtWQbyz/5j2wuzWCbusM2mpgGo=;
 b=TNRt5T+olRiNR7A3YDPid5Hd3ug+lSFlT0hPSiIYcjOnTwVlnJGb2UWtdm6a7k5beveMkq31Rl6TGbBHh2CKMo3OF6JwMWaXqCmuozM9S2KeKgTQ+3rpgGYEUKsZEyk3DS+fkp8KfI2tH3mUvL3FORGkCGnv0dsVupYc5SwZiLMOt7lQ3yPwKQ3TM90637O3fQWXKBmFS4+00eO8mx0FU11Ja3tFw0/C8H9E+3lbnZjjlOhphL7M6vwAdjfuoDoc4OLUvDOASIvLgadr1/3uSvcUeJJ6/n13nTWgWQuUA9F1RZIdvo8hY9GqGiCxbkJgezPN0532tlvGkr7Lk8a4NA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MS0uECjcxJ58mIAVKDtWQbyz/5j2wuzWCbusM2mpgGo=;
 b=A1i68wlunKRth2LXzNA1eRaxmSU0uWtVSaRlvxv1lnqXgtHpKjjpDpYUoB1mP+bpA5SRnRtc1yHosULzWwDVR8YILc+zeUA6txm50Cf2XGjbLI41tbJzkSQRgoymkrWUfguofbRpWGj9LIWQNZAun8U72wVit716zpCnzRb2UE8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by DM8PR12MB5496.namprd12.prod.outlook.com (2603:10b6:8:38::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.32; Mon, 24 Jul
 2023 19:58:55 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::ca28:efb4:a838:58fb]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::ca28:efb4:a838:58fb%4]) with mapi id 15.20.6609.032; Mon, 24 Jul 2023
 19:58:53 +0000
Message-ID: <11ff65ac-eef5-aa86-359a-67422fc547c6@amd.com>
Date: Mon, 24 Jul 2023 15:58:50 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] drm/amdkfd: start_cpsch don't map queues
Content-Language: en-US
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230724175206.11054-1-Philip.Yang@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20230724175206.11054-1-Philip.Yang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR01CA0158.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:7e::16) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|DM8PR12MB5496:EE_
X-MS-Office365-Filtering-Correlation-Id: 8cd6e8fa-e78f-4acd-a190-08db8c8067e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Y9pABrV5TcH2l5DH+WIvSC9kwKjjwHvgsTBbsLlOvVRWfRjaaODSKkEpTqZju3Rs43mvLBqv1hpc/pR8gCx5WtnjeIj+u62lExcCxnSH1+6vT7dDNew4esmOy1wKSOGPg2yP+kCkB+xi3nT8smY7/64ZezpW5gSiNRYr6HyHuVBkjaZz5SovmcG56eR8JILXbJsa+9FbtDpndIriQZo2rj2yWY2vebRaHIOskwC3Lhex9j+vtBokpy83mFvrG8/bM0QXgrCjHGXKjWnX+8ykaa869TegE2X76zknZf5NthYZrVWGbusFfgozc66xH1EmvLtaESG3U+UGwzJK4Rom2m0kZ58atPXpm50ydDLB30QmrOS05TxtrhkUbPQMRYdzvttMBjKUADOFpfU+H0W+YrX9BwZJDDGfZrsWNFKw2BuRpK70jEt5HgIoue3XOB7q3PqZ7ezcP61mNyRa/mg0mrXLkT59NMVgHBNGouO4YrDZDgCkf9tlZn0AhnNUa1O4VBr/E1A2Gz/RuKotqsS/bmh82v5t8Sar/JSrG3krw40LJSFoej0uSA4TjJhdIeaTIrvbVPViJ58HISNki6yv65TZOAUhBQLFmctR0pLmr6Nura2U+E4cS5QV47z9Rg4XEEyB93Vsv+o/amCKdlKHtA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(396003)(376002)(39860400002)(136003)(366004)(451199021)(38100700002)(66556008)(53546011)(2616005)(36756003)(83380400001)(8676002)(8936002)(5660300002)(44832011)(478600001)(66476007)(4326008)(316002)(66946007)(41300700001)(186003)(26005)(6506007)(2906002)(6486002)(6512007)(36916002)(31686004)(31696002)(86362001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WFJML2I3YlN4TFFCV0haT0ZqMm5CdTE5S25Yd2JtK0hqdVNLTmh5OVJNeVJx?=
 =?utf-8?B?YlU3TUtGNTVWYnFOL3VHMVRpL1o1bHhSUk9Fd3RZTndob2taK08zd2F3dmJw?=
 =?utf-8?B?ZStla0xWekx3cWFLV0ErUGgydTEvQTRjbDBlaE5KVHpNL2ljUElVandvd3pE?=
 =?utf-8?B?d2oxUXc1TnROcFllakF3cVZ4QmlFTkd5d2ZHYXlDYnJtbkhDVDVPQnBZVVNJ?=
 =?utf-8?B?Q2RlQ0dvaDRrZkFiYkJxRVBnU280L1MwdGZvRjhkb3A2Y3dnZDVBaDByNVM1?=
 =?utf-8?B?NWN6NllFaVBBRHVDMGRHVXFNTjArSEtoM0Z1UW5ERHhad2RUdlN2QjlMNWw1?=
 =?utf-8?B?ZWREK0sxMDQvZW9yckptbXlpeEdURHRBMi9PS0NoSGhtdUJyVUNqT09SZjkv?=
 =?utf-8?B?dGZxWUR0bnhvSnBNRXRGK2NxUE80aEovTU9QMEt3dm96L0k1UVl6NnBVd1hQ?=
 =?utf-8?B?TGVNMnZ3Ti9rYlhHTVF2ZUw2aDF2RXVLMkdnUnVoYlRYL3R4aFUxVE9XZ3Zj?=
 =?utf-8?B?cWhFYm9EdTdQY3VQbXIyWDc4Ym9Td2pNK0I3ZzNlVFI3Y3NKTFZvUTdlWHJN?=
 =?utf-8?B?SEhJaUswODB2M0t2Y3N4ZHlSelBRNFpKNE11SnIyVkc0RzJ2d3M3cmFUV3ZS?=
 =?utf-8?B?Y201NXhhdHg4S2k2Y0FoWTllUGIzaW02STJlc1Z3SHVqWGJDV2Npd3kwNXE0?=
 =?utf-8?B?Nkh1VTZNZ2NEMlA1SWREM1N6WldSS25NYzFBTzZpd01ZMWJ1SXpKd3BxclRv?=
 =?utf-8?B?ZkdzSVJic1pRdGh2Sy9VK043eGhoeUhRL1duVEF0VXE0Y2ZWaTNvdjlOSU9S?=
 =?utf-8?B?VG04bE5SZnB0SFRobGlpa1NmMjMzM3g2ZXkzNFVqci8wa1dYRlZhaW1TZXIz?=
 =?utf-8?B?MkFiOGxtTGVoc1oxOHNlTzBEMU1RMWExdUt0TnEvVjVQZWtTNWFENVVVYUdW?=
 =?utf-8?B?RzRaUFIxL3VlZU82a05Hamhhc0RqU0QraFBVeFg1RldXUldHUjRoZmV2TXEy?=
 =?utf-8?B?bXhWTkRrd3BSMDEzV056dzYvSlA3R0ZMc0hjUFQ5TzF3a0pXTC8vdkFXbDlu?=
 =?utf-8?B?Rnk1ZlRJOFRtMDJDbzVIaGZlSm55M0g4ZWdNNEhuUVZCNHJoUTV3b0wvS2Vk?=
 =?utf-8?B?M25xbEtSbjAraC9YYWNpTFZiWjRrSURFSjNONVlxNmhHdWUzTGUrYmU2RDhn?=
 =?utf-8?B?V3cwRGkvVDRJbHMxejZLN21NVVFBSnY5QStLK1ptNzJrYWU4cDNRdlhGSSs1?=
 =?utf-8?B?MThQR3YxRkc1bUZIT0tXZzZqdTlBbkI0YzFpMDBJRC91TVc2SUhMZUNkVmJv?=
 =?utf-8?B?NzhOZ3BQMUdaai9nbHpuc0hsSTEzNy9TU0RMelkxb2FyV2IzMnlYaXhmZXdR?=
 =?utf-8?B?UnhYaEppU3BITlRoaHVPYTJLUzRMZWkzcGYycGpTOEs1d0JxTjhRL3l1SXBv?=
 =?utf-8?B?S0ZzdHl2ekNqVElkTXFIYURUMHBrZ0oxTE5GNmZGV0FkWENwYXR1dktjdFR5?=
 =?utf-8?B?aUMzd2IzM2J4cDVJSnpuUGFsTnFlMUJYWHYwcHJJalZNTUZlSlEwMjhOOEh3?=
 =?utf-8?B?c2ZuV0FHL2NDV2RRdVN5M2JDY2l6dkhQU1NmZ1NaWmNQTFZZMVJXQkdXOFY2?=
 =?utf-8?B?N085dWhLM0VrcDBRS3dOMGxxV0VEVVBvMUJwVU1FeXhSczZ5KysyanhlMjFj?=
 =?utf-8?B?MS8raExnc0sxR0lRaUo5OW1kb0NuSnBtc1I5NHZ3dXlkb0xBTGg5RTZXTXN1?=
 =?utf-8?B?aGpQYWJMaFNRWEFZQkpQUXYwajRJRU56UlhGaS8rTEFabkJTRzlnT0V6NEpP?=
 =?utf-8?B?WGkvZXhtVDg5UzVnRUo0Q2NJOExEME1PdmU3UG5XZ24zMFUvSG9BMWlMWWVj?=
 =?utf-8?B?MHJwV09CaDlmelNQaFJCMDlwSTFGU3JaVUpjcThHY0hKQXFFWVZTWklsVFY2?=
 =?utf-8?B?ZHdrL04wQlp4NnZXdGp5VG1zMzNmQmJYOWs3VkY0Q1d6dTk5V0pWWGlXTUU4?=
 =?utf-8?B?WnYyYkgrc05IT2lnNTRCaVJaMnZXbHdHNC9nVTlxTENKa0h6YndCNHRKcmhq?=
 =?utf-8?B?YkdUMlJ4SUhCdGwvRGs5dlNhQ3Z1TXorcVlmOGEwQmIydm5kSkNlNWV2VldW?=
 =?utf-8?Q?1ua4q0ZVA0Htq/rqzEBLoKk+x?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cd6e8fa-e78f-4acd-a190-08db8c8067e3
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2023 19:58:53.1253 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qjXmcaLiLauegMZuOcLEVTHa8THkh/1yX700VyvM6i1/n7E3irBWD4BF3K/Pw4do+atfnMKn41qLO0d1aL3qsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5496
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
Cc: michel@daenzer.net
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2023-07-24 13:52, Philip Yang wrote:
> start_cpsch map queues when kfd_init_node have race condition with
> IOMMUv2 init, and cause the gfx ring test failed later. Remove it
> from start_cpsch because map queues will be done when creating queues
> and resume queues.
>
> Reported-by: Michel Dänzer <michel@daenzer.net>
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>

Michel, can you test whether this fixes your regression on Raven? Would 
be good to get a Tested-by for this patch, since we haven't been able to 
reproduce the problem yet.

Thanks,
   Felix


> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c | 3 ---
>   1 file changed, 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> index 71b7f16c0173..a2d0d0bcf853 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> @@ -1658,9 +1658,6 @@ static int start_cpsch(struct device_queue_manager *dqm)
>   	dqm->is_resetting = false;
>   	dqm->sched_running = true;
>   
> -	if (!dqm->dev->kfd->shared_resources.enable_mes)
> -		execute_queues_cpsch(dqm, KFD_UNMAP_QUEUES_FILTER_DYNAMIC_QUEUES, 0, USE_DEFAULT_GRACE_PERIOD);
> -
>   	/* Set CWSR grace period to 1x1000 cycle for GFX9.4.3 APU */
>   	if (amdgpu_emu_mode == 0 && dqm->dev->adev->gmc.is_app_apu &&
>   	    (KFD_GC_VERSION(dqm->dev) == IP_VERSION(9, 4, 3))) {
