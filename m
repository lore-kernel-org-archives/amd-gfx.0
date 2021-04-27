Return-Path: <SRS0=7Ry8=JY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FE0BC433B4
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Apr 2021 04:03:56 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 022716101C
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Apr 2021 04:03:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 022716101C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AF9166E8F1;
	Tue, 27 Apr 2021 04:03:55 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2085.outbound.protection.outlook.com [40.107.237.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8C74F6E8F1
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Apr 2021 04:03:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EkFBTMO1uFe3t8Wmrq8v+s9u76xb356whVNnwYq3h8bC/wel3hYZA9LLJfr6Lj2cqYcqQdQynCrahCjmS4evPPnKTbMBb+FMnZKhNMvx+SaUDXoW6YrR8PIHBEmgzz/MXTuQdBt5Jve9Yo6uuGQ7lWihLSfv+JoGB5Gy2jzgDMTHNeFW3ahpcWeiOuQFTCONQMjKqcZRe1E7WA2+5/eSyZfPXViv49PWC/5K74L3T5weTILg2ZMP2SYF6pnSnmMuI2gWRwFZUBSayzZ2L2FP3TwJtF5hI5n07ISK/xrvv7PSO6wvVJ5d8Jy4UVTOxlUgu6osznAl/tiL5d07umuVnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0hf2rAHpV7SaXwd9BjPYFmyY71cf0hJKeKi+RcO+Ze0=;
 b=gpJH1Y9yBF6V0omreNSFaBjw2d+ue6lnXmkxUVd1uPD1Gaarz/9WN7a3f/O5MMz3u4JYWwleP40n6qy2Gfs94tCJz/WdNKpC/jyVENKYC5TivuHPCzH3blA0WQZSHdJN1Uj2qWtRzXJsMRiYcaAxhtBJcunASzqW5Lt487w9v4iquCtdMAL/p8Wbau3oZQV/4n/XMxmXhl7dj2VJJCR9Ttd3X7IORGgjOHSkk/dZi+geeAHrizvCsipcSs33k6uO0s+gi2/aR1COILicdvJw79DqfH6Q4wL1O0H0BGe7Eq6QiY0oNO35PPVMO/TWtvemr+TTpJ1SAVP68coJtab1Fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0hf2rAHpV7SaXwd9BjPYFmyY71cf0hJKeKi+RcO+Ze0=;
 b=H/th9fispWeqSlySlgKFvCLS3CQVS3t39fWIpk81QMB5a9LFSONArucuUIruTw3vwlsXqWGMwiZCFdBSiVDcW1hKC8Vx/GlDYltDcgPycIByiWHc6kdKrzEwKeZayf6Rx7U/44W92d9E+ztzqWPTHgvVB1HKYwbG7y5NirIAmF8=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BL0PR12MB4948.namprd12.prod.outlook.com (2603:10b6:208:1cc::20)
 by MN2PR12MB3839.namprd12.prod.outlook.com (2603:10b6:208:168::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.21; Tue, 27 Apr
 2021 04:03:52 +0000
Received: from BL0PR12MB4948.namprd12.prod.outlook.com
 ([fe80::70f5:99ed:65a1:c033]) by BL0PR12MB4948.namprd12.prod.outlook.com
 ([fe80::70f5:99ed:65a1:c033%7]) with mapi id 15.20.3933.040; Tue, 27 Apr 2021
 04:03:52 +0000
Subject: Re: [PATCH] drm/amdkfd: fix spelling mistake in packet manager
To: Jonathan Kim <jonathan.kim@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210426194434.83501-1-jonathan.kim@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <ac2c7c2a-6756-bc71-3aa4-5535087a63f1@amd.com>
Date: Tue, 27 Apr 2021 00:03:50 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <20210426194434.83501-1-jonathan.kim@amd.com>
Content-Language: en-US
X-Originating-IP: [142.182.183.69]
X-ClientProxiedBy: YT1PR01CA0080.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2d::19) To BL0PR12MB4948.namprd12.prod.outlook.com
 (2603:10b6:208:1cc::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.182.183.69) by
 YT1PR01CA0080.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2d::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4065.25 via Frontend Transport; Tue, 27 Apr 2021 04:03:52 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6298a628-bce7-4e27-ab73-08d909317820
X-MS-TrafficTypeDiagnostic: MN2PR12MB3839:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB38399E8080BD5E38DD6B1F9892419@MN2PR12MB3839.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2089;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VPhvyxJ29Rb6b7KkCAMKW9y6NIiwfEcgd1pwgxSoDXq5NWKunpvSkCpj4QjcmfhTwGEspwmIxnHu/79eYYmbV7ZI4b01HhJPDWAJiL+GKC2Ud976iBIyqSolmKmq/19ONW2PvCM4JRU5nwJXIy33xPmt+0JEXyiUklezlBM+UNvw0oVOuBbE2u1YkuEKkKEP6LYv5cbt9KOXZeTGz97itg8ytkaDw+FTntAvhbdyrYLUOT+sLz6ii/nN8O9LWvEibDYMfFI+XXpwUFz9NgZ+lNl4s59ODQfYOxqaLy6i0w++vS6cVNqETLizhRWNtm1ahgcxa007/77Svk5s80VA9ZXHJR6jiRIvbO1FQyS1wUWBSZjikH15+1HCHmlJSSEZ+Id+aUKkc3+3gnt5M2DdKjrqyjT22RFQL/+pov3i6V+Rn6JoH5x59nG3Jv7Spl4WnQU9U0pd36xzhZqOaj+sdiNTGjrsF8Er/HqLswg9K08bsZwZiyAHaS9MYD3LEnhySd//BFTTBiYaWzghMi9qEVL7AzynpSinaYRFrjjv0YQvGBz6/pQfLbZlZe4CWHd9tErphenuXrW71j5yG932BiBwgVl4opaCpZnn5lMb0Eu/HW3WqX2tufuB9KadnqpYsp8/Q0qCw9Z/3KtJ0A2FKY5NWcT26wvOQvhvzyvocigkTSdj0qgnbXGCKJ45G3WO
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB4948.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(39860400002)(346002)(376002)(396003)(366004)(31686004)(316002)(956004)(44832011)(16576012)(16526019)(83380400001)(186003)(66556008)(26005)(2616005)(478600001)(31696002)(5660300002)(66946007)(8676002)(38100700002)(86362001)(2906002)(8936002)(66476007)(6486002)(36756003)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?Rzc5SXl4UXBDcVhzdzZZTHM3Z3BuN3hoY2Z2N3I3Y3BIWVZISElhbU00RUJz?=
 =?utf-8?B?eFIvZ3BNMVVpSjZLZ1ROUWl0ZXlzV0h3NjFPNjN6QWgwUXN6REJtMXRyVGtJ?=
 =?utf-8?B?eDg3WGszMDJwUnUyazZpcUxOYytPN0ZjTlZTdUtFRVVMNjA3S09ldTROSWF3?=
 =?utf-8?B?UUpVWXRkdW1hMUR6ZjVvTUorWmlUUWlnejN0eGJvMm1BaThxN3ZmRDVhQlhv?=
 =?utf-8?B?ajExMHg2OTF6K3B5MTdUc3V2bmN2RzliT2JxWVRTQ2hDeDFNZnVCb0FSWmRK?=
 =?utf-8?B?eXVjTk0vV2RPd2hIYVdlSDFKTUdoNTQ5cGxHMUVXaElEYkxJZ3FSNUxDYzFT?=
 =?utf-8?B?RjhnU2NoTG5QM1B5dDlCZU4yVGs1cFRsM25PTEIzNFVaK2xMRHp5a1E1Vlh6?=
 =?utf-8?B?UitkakNnRHdOK2FDaWJ4dkhrcWIrRUtReCtCSDJxMGhoV0M5M2NaOHdiTFlt?=
 =?utf-8?B?TTIzMWhJaUp5RmxBRmRFZkxBd1dkMHFkR3paVHUveXdiclh1WlByaTdrQ0ZT?=
 =?utf-8?B?RHQ0MThtRzk1UEljYjd5OVpKdEtZR0JER1RTRk52d0haOWhSUThvQ3pLbTRp?=
 =?utf-8?B?eWV6aG80QmpWbTVTZFpYZ1lSaVhQRldlTGZPTFgyWm5xVXF2YW9MZGtmclhw?=
 =?utf-8?B?Y20zR08ySlljWG5uRVR6Q2VQTlBQNUlCc1B4L3hPNU9HNFJYWERpdGYvMWxM?=
 =?utf-8?B?SXdOUzZlS2MyL3FBYWQvWFVZbFhoVmhLWHJQb2F0bm03QnNLZWx5eXdBTGlG?=
 =?utf-8?B?T3YrelpyWGx2eHdUemZlWWFldEYvcmd2azlST3cvdEtWcFNpcmJya1JZSDJ0?=
 =?utf-8?B?SVVuK2praWxCNW02VzJnSUxyZU9JYXZ6TEdsZnlxWDc5VmM2WlF2ME8rYzRh?=
 =?utf-8?B?dmFjK2RoWVQ3bVdUSlBDSkdVSG84amlLQUdlRTJORFFDNkpIaW9sLzU4ZGti?=
 =?utf-8?B?cDhmcGUwbjVDendjaVZJV3ZVYjY5YUI2NzhwdjRDN2tuamJSK09LSVJoOHBP?=
 =?utf-8?B?anlRalR6OHNFSkU1a1ErTG5qaGU4WW1ydkQ4REFscm9obW5mb0JRNm9ubm9D?=
 =?utf-8?B?RzRXcERzS2JJY0JZbytHaUpXalhhemYxV0VyRGZEWTVyVFNBWXB0WjFhMzNU?=
 =?utf-8?B?b05XWGRsZ1F2dTlhVmhmUlp0WisvT21HY25vR2c5YTBwL3I2K3J3SVQvcjgz?=
 =?utf-8?B?OGNsVHdBNTkzNWp6djhyOEhFMlBHalRUcjcvbXhuOFFWaS9YMlBQaWRxbGlv?=
 =?utf-8?B?Q2J2NXN6cURUVUZZeFZlVmF1dGU5bE1qM3MyZTNrNW5rMWJrSjcyVWlQd3g5?=
 =?utf-8?B?MEV6TFpOdmJqd3M2bGpvSHJjRjZteUNVSXFuNVFiZjVUNldPRytyMDhreUtL?=
 =?utf-8?B?c3h2QWZOZVJmemhkVFZzbFd0N28zT1puRzNTNlkxbWhKamxKTzdDR3paSEhh?=
 =?utf-8?B?aVRnM3NLanNMWWx0d2o0Zm9tMURlZlNVOWViTjBrZWFOc2dPREIzb09yYzU3?=
 =?utf-8?B?T0pLaHA1bzFyNVlYb1NRZkp5aENUQVRqb2xvTnpWUXNGcGZUSDQwOHMyOUdY?=
 =?utf-8?B?SUQ2YWRMZ1h5SUZTVHgwZnBqZkNzMXV2Z25GVVVJT0FRcXhnRkFlaHBKTUlM?=
 =?utf-8?B?TnZzaDBYakp5OUplZWo2YWNndkFRRlRqdjBTUlI3azhkVHNKbXp3TlNoSEZt?=
 =?utf-8?B?ZU1qaUZrdEU5bDRHZ3laQXFVY3BCbDJHUnNOMkZkRTMvdjY3enBJamQ4ZXJB?=
 =?utf-8?Q?mUbT88G6nNX7jTlCBXsUTmpF2ki4ndYc8RLd7aP?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6298a628-bce7-4e27-ab73-08d909317820
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4948.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2021 04:03:52.4115 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xXzh6czR9WWvv1ofqCtBGQS4uES7xBL4uJe/wrgat3blio+RzPnuKC33+SocC9jh1ZuK9gmy9hJpQxOibPzFSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3839
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 2021-04-26 um 3:44 p.m. schrieb Jonathan Kim:
> The plural of 'process' should be 'processes'.
>
> Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
> index 0ce507d7208a..f688451cb299 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
> @@ -124,14 +124,14 @@ static int pm_create_runlist_ib(struct packet_manager *pm,
>  {
>  	unsigned int alloc_size_bytes;
>  	unsigned int *rl_buffer, rl_wptr, i;
> -	int retval, proccesses_mapped;
> +	int retval, processes_mapped;
>  	struct device_process_node *cur;
>  	struct qcm_process_device *qpd;
>  	struct queue *q;
>  	struct kernel_queue *kq;
>  	bool is_over_subscription;
>  
> -	rl_wptr = retval = proccesses_mapped = 0;
> +	rl_wptr = retval = processes_mapped = 0;
>  
>  	retval = pm_allocate_runlist_ib(pm, &rl_buffer, rl_gpu_addr,
>  				&alloc_size_bytes, &is_over_subscription);
> @@ -148,7 +148,7 @@ static int pm_create_runlist_ib(struct packet_manager *pm,
>  	list_for_each_entry(cur, queues, list) {
>  		qpd = cur->qpd;
>  		/* build map process packet */
> -		if (proccesses_mapped >= pm->dqm->processes_count) {
> +		if (processes_mapped >= pm->dqm->processes_count) {
>  			pr_debug("Not enough space left in runlist IB\n");
>  			pm_release_ib(pm);
>  			return -ENOMEM;
> @@ -158,7 +158,7 @@ static int pm_create_runlist_ib(struct packet_manager *pm,
>  		if (retval)
>  			return retval;
>  
> -		proccesses_mapped++;
> +		processes_mapped++;
>  		inc_wptr(&rl_wptr, pm->pmf->map_process_size,
>  				alloc_size_bytes);
>  
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
