Return-Path: <SRS0=ctnh=QC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5691C433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Nov 2021 16:06:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72F2B61BE1
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Nov 2021 16:06:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 72F2B61BE1
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D02806E09C;
	Mon, 15 Nov 2021 16:06:57 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2064.outbound.protection.outlook.com [40.107.223.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C806A6E09C
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Nov 2021 16:06:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nV4cVH7XV2aSsrNSWKrbQWFkjiupu7J7MbEHk8EZ+iFEG1wYS5PSot1KZn0zGpuGgIHWONdKx9ea6/hEdQA3Wp0DQPWpkv6oVIjBuR4AYa259vBjdg5f54MEiMFXAhAbzpepjjVFbxy3x5hbuL1aYTICmlXCwRXt0UmntguJi0I2fCbgSEbhyqjKJwM9ilD1SRzRX1xfKvW0nvb7xvxApX5jGg0W3M4UyEZja8wkcNQV6JpW7dtM3/72XDF+EJt/llN64zGgpcuB+j8B2OT0fE3Y4DFLsA6ab9u4v5tiBmGT1mGMWwa9TJh1q+PpbnzxZPaYcDHi4nLUWnq3DgMQiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+YYVie3xSju3cfug29fEDO7EctugSc6O8opjJlwr1qc=;
 b=f42jbk0kJbrUApahHrxV7zkS4/FL8rwiBq6oXva15XvV+DYTbH00GG8WqETlwJ3dPqQeL1lvttg9w1FvQkappgbMHVZ4KhM5ND6E5h4V5O//+7PLEcck+uRQ/wATWvFF0IZbu9EJAPU0LBn3f33F+IBdT7iLfzF3EAtAtyk1Ae0/INX9Q0dycZzHh99dy9biZXhsVyVSKlfxszxAOE7PsP73gFqpPy2j1rxbQbmDGs749egeWkR5mV6T8VpVshYuT6wrl3inoQx7zPiHgJYIYAVW2gAqFdyqrax98wEek/KVYYmgWtPeeJYmp31v2KDmoR73fCnws1KUX7clu9h2AA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+YYVie3xSju3cfug29fEDO7EctugSc6O8opjJlwr1qc=;
 b=bbjxvA0XKpNOZ8xei0R/s46yCoGJz3aiGTEz7Y/DXEIwdlnBoKVC8WvN62zabjPitidQqdvyf1TcEV0wnN9qsa1lZn/Av/6+9XDHUHCTx6E3DdKvNuytfMgt7vQ3MFy+oLndLcf1/k+Oi0l34dXmNUUS4e7OhAQ/nP3KRM/Y1fU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5112.namprd12.prod.outlook.com (2603:10b6:208:316::16)
 by BL1PR12MB5378.namprd12.prod.outlook.com (2603:10b6:208:31d::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.26; Mon, 15 Nov
 2021 16:06:53 +0000
Received: from BL1PR12MB5112.namprd12.prod.outlook.com
 ([fe80::b077:a0b3:ec59:19f3]) by BL1PR12MB5112.namprd12.prod.outlook.com
 ([fe80::b077:a0b3:ec59:19f3%3]) with mapi id 15.20.4690.027; Mon, 15 Nov 2021
 16:06:53 +0000
Subject: Re: [PATCH] drm/amd/amdkfd: Fix kernel panic when reset failed and
 been triggered again
To: amd-gfx@lists.freedesktop.org, "Liu, Shaoyun" <Shaoyun.Liu@amd.com>
References: <20211114175503.10197-1-shaoyun.liu@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <75704fb5-369c-f587-4b5a-81f7828a0cb1@amd.com>
Date: Mon, 15 Nov 2021 11:06:51 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <20211114175503.10197-1-shaoyun.liu@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: YT3PR01CA0052.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:82::34) To BL1PR12MB5112.namprd12.prod.outlook.com
 (2603:10b6:208:316::16)
MIME-Version: 1.0
Received: from [192.168.2.100] (142.118.126.231) by
 YT3PR01CA0052.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:82::34) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4690.25 via Frontend Transport; Mon, 15 Nov 2021 16:06:52 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a1705e33-bebe-4ef7-360c-08d9a851f07e
X-MS-TrafficTypeDiagnostic: BL1PR12MB5378:
X-Microsoft-Antispam-PRVS: <BL1PR12MB53782951D2807E73B1B0D44392989@BL1PR12MB5378.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lB8ANxRg5+409vHwcJ1O7iKp+1X2ow0VmbE+QraLRHoC/z7HMXzfki587VaniHJYyFpKR6C/9ntY1zkJTUg491BJa7vPdtFcS6iOWQ5ccQtwOPuhxRfQnfQmxJS8B2H42tf0pi5cupc9eJW4GOyrmV24zOTGW6esUcC+RcmAxZ1Rq/SXasGE1ECe5b2ZH+sT/v1hPF3hrfetuoiLRJng5rrBGUQ8wWG1SprOBvhC3kWvNm/zVez2hTU0Kl9OTrJE2MKmR7EHpz3VrJlPOLewwC5YDsUoIGYEr3gOCPpwTaPRPzGzRep+uK3jyRefwxfJdp3G87vVyhay+WccwM40YDapZdXD7zuzWa5F/x4LuuBqxsiMyILYi0KuUUAMNon7/QUBZM3/PjZl7QTb514+t+ynV8p4glMeflMueTDd1qr4+zZStbAVYtmORwV+mpJQlnuxC/udBYycxhEmWaOOB9tloTmrjkogI/0CtDT3nLNJUPRMyoZAFkenQStfU12+x/K552CbzIjaHPPuSKD7hOMERMwJIki363W6SrHwOaiWtWOEY4286qU2AP2ha1Yn8ESbQlGG56qy7A/bVEt9rUR4Va/Zjq5df8qSwqPOGYRhwgqjjCx6tE6uljAtAsenFwueU+1n8XS+dCTxYh62m3b12TS1rRNzRFrT3ctzOXL35PlKC5jylfJF0Qtkh/bMKaXRgKmLjYccR/lTK4u9cHeWUkAYO6Kb5QcHsl+j+y0tRusijRhd54pQotvR/uxK
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5112.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(31686004)(8676002)(66946007)(508600001)(8936002)(4001150100001)(6862004)(316002)(66476007)(66556008)(36756003)(6636002)(86362001)(83380400001)(44832011)(6486002)(16576012)(37006003)(2906002)(38100700002)(2616005)(5660300002)(956004)(186003)(31696002)(26005)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c2FIZmRXbkFDNDAyeHQ2VGZNd2k5bVBuQzViRENMQXdrUFM4aHlCR3daM3BR?=
 =?utf-8?B?d0kwR3dFQnVORXl5d1ZlWWw4WWdEY3p3dlQwUUprZ001dW1NVmVQN2V4anVS?=
 =?utf-8?B?U21LOEx4SncvWXhjVDdxMGo2bXNmdGFSY1MrS0RiOUtLbFBaUzBSSnRyd3Mz?=
 =?utf-8?B?ZHhvMGRQNnBJSDVmeGREZjBtVkdqV2FhdENUQ3RnQkxyMG9pZWpLMHAxVzRj?=
 =?utf-8?B?UUZwU0szWjY4WjFPRUpSS3FRQWl3V3F0L3Q4dW83TFdhWEE2cFNZTnlRa0Uz?=
 =?utf-8?B?Nmd1NGJnZWpSa0ZrR2trdFVKcnRKa1ROTEhlQUdSM29idWUxUCtWWjZVRGhD?=
 =?utf-8?B?ZUxvOG10YTFVdWZSOG94ZWVCTHFpZnZsNmtNSElLUnJ6NDJ5RmVDUVZGbzZr?=
 =?utf-8?B?OFNNakQ1QndmWlZ3b0d2RzErQ01jUkh4ckdwSlBRYllxVGh2M0hUNTUwU3cr?=
 =?utf-8?B?aFppTFpZeHZ1aWYwZmtMOTI3RVEyczFERmR2WmRTQ3hIVGcvQVEvR3B4b1Uv?=
 =?utf-8?B?ekc2V2c4MDcxTk16NnBhNVhtTzY5azBaai9pQnJkNWxKVXcrME5RL2Ivb3o2?=
 =?utf-8?B?V0pSd0ovRUY4ZDZmbEprRDR6VWVrWmZqRytmY2FKejNCK2xNTmxSY055azJW?=
 =?utf-8?B?UDZwcmNIOEtCUCs4T3JyRUt6T0FHZ3Q4Y0Z6NjdUcElqekhHY1h1b3dFK0p1?=
 =?utf-8?B?SEwyejJGWXc4T3BubGxNZ1V2T0pLeElnYWNhL3poYnlkaEVHN1BwNXo3S2lS?=
 =?utf-8?B?N1FmcEFEU21tR1VsaGdaMldXaGFKM3dCYkNzOG95RFdFclJzbFZtSzFONkY4?=
 =?utf-8?B?OTdkSDBoTm5zTGRBQUVERmVhZnNBYmVJOVlOdkRYYlFldG8zSk9DbXRiZ0dQ?=
 =?utf-8?B?NkJxdVRNeUZMSkNSRTVWTjhtS1RYYlBPemdKeWZrOGU3VUNDS1pyL0JGeit3?=
 =?utf-8?B?WkQwVmtSQk5RRmNkd2R3Mm52bUNBbzdvYm1YbXBzb0xWR3ZVUzc0YXlJQitZ?=
 =?utf-8?B?SW96YktQQno2L2JnOTNCcW5mcEpGSnNzcEJTQ1J3SjBHT3BGbzQ3ell0dFVE?=
 =?utf-8?B?Wjd1bTRiRTR6TW5vQ2xxclp6OU5YNU1HUGJPZDBoL2EvamJ2NlEzRkg1RndT?=
 =?utf-8?B?UjlJTHZ3NXl1TlJEUVdYL2d2SEVpa3lCN2N3OG1VTy8zT0t4RmNBa1U1UjZ4?=
 =?utf-8?B?K3VoNmFUUjVuMUNKcS9kMEpHcmhuNFozUVQ1SEVzWi85a1h0NGw4UWpINEJS?=
 =?utf-8?B?QU1VczFNQTBNWXZXbjdKT3dsbU1wZGdBZXMzMkx4RUU1cGFDVVUrN1dtWVVn?=
 =?utf-8?B?RTd0M3VGVGtSZlgvZDRmckRkRHNud1k5Y2RrNU14aGlYY245QURZbEVTTzFr?=
 =?utf-8?B?eENWUUFlcWY4WjFCdjV4SDEwUFdHUjRZS2Z2USs4WUlFSHdXQ2Q4NFh0ekNW?=
 =?utf-8?B?aDhRNEYveFpMY0VOWmxjamw1a0UreGRpMFJPWFM3NVJ3ZVZBMytEYzVscmwx?=
 =?utf-8?B?dzU2UklJVVh0WWFYeVdFZnVoTldFYkpqalE4UjdKOHBGUUc4ZWFtMkswRFQ0?=
 =?utf-8?B?cW1kaVYrVEtxdG9Mb3ZUZ09SS0JQMzZ3QW1uNkZ4c3BDTXlLRjFlWGl5YjdM?=
 =?utf-8?B?L0VKbGsyMmxrOC9aOHJGaTgxQWNkRnBWKzJ2MlJiZ054TzgyWTRUdU5UU2xO?=
 =?utf-8?B?MEVOa3lvWjZ3T2JUWmlLRkRqc3VIejExM2g1VUt2NHE1ZTZFR1NxZ2hGQ0tP?=
 =?utf-8?B?QlBad2h3eFpqdmtMSVhYbm9YNitWRStnK01lTUdUcjd1c05qQ01pUmxpMjhY?=
 =?utf-8?B?aUFNdXRzdlh5a1lSOWdDdlVXTlEwbWRsYjlEZHNKejRSdnd4TENXaUsvaUVi?=
 =?utf-8?B?Q2RCaDBlVXFwNGg2eVBpZGt0djNCcHhhOHZ1UlhuakZpa2lwZHZUOUdSMnpG?=
 =?utf-8?B?VThleDNPUzhMQmpBZHF0eEZuU2tVWExOQ3doM1J6L1BQZ3ZCY2lrd0xFdGdS?=
 =?utf-8?B?aDdQS3BsTVd2clFtOSs5QU9WdkU2TkRHTEU1NFdxUHptazkwNkk5dFV5M1RE?=
 =?utf-8?B?WHRPVnAwaGo3bXp5a0NSQk1OZTdxTEQxWGh0K1pSOU1NVlVWK0F5aFIzdFdq?=
 =?utf-8?B?YzRicTd3SHJKVWh3NUFmekhyMS9oSitPTmZjSk9Fb0ozVU9xS1JKYnloSEkx?=
 =?utf-8?Q?8+gQ1wu+HNKk/kPUJDQdeVk=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1705e33-bebe-4ef7-360c-08d9a851f07e
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5112.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2021 16:06:53.2018 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CkQ/zwdEG4w+CAjpLdi6ZzbBN8ce9KroVQa5f35lCKnGNe4AaKIROJKdXcmU/dqH4hkxlp2cEhqrsxJ3NoxoyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5378
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

Am 2021-11-14 um 12:55 p.m. schrieb shaoyunl:
> In SRIOV configuration, the reset may failed to bring asic back to normal but stop cpsch
> already been called, the start_cpsch will not be called since there is no resume in this
> case.  When reset been triggered again, driver should avoid to do uninitialization again.
>
> Signed-off-by: shaoyunl <shaoyun.liu@amd.com>

If there is a possibility that stop_cpsch is called multiple times, I
think the check for that should be at the start of the function.
Something like:

    if (!dqm->sched_running)
        return 0;

Regards,
  Felix


> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> index 42b2cc999434..bcc8980d77e0 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> @@ -1228,12 +1228,14 @@ static int stop_cpsch(struct device_queue_manager *dqm)
>  	if (!dqm->is_hws_hang)
>  		unmap_queues_cpsch(dqm, KFD_UNMAP_QUEUES_FILTER_ALL_QUEUES, 0);
>  	hanging = dqm->is_hws_hang || dqm->is_resetting;
> -	dqm->sched_running = false;
>  
> -	pm_release_ib(&dqm->packet_mgr);
> +	if (dqm->sched_running) {
> +		dqm->sched_running = false;
> +		pm_release_ib(&dqm->packet_mgr);
> +		kfd_gtt_sa_free(dqm->dev, dqm->fence_mem);
> +		pm_uninit(&dqm->packet_mgr, hanging);
> +	}
>  
> -	kfd_gtt_sa_free(dqm->dev, dqm->fence_mem);
> -	pm_uninit(&dqm->packet_mgr, hanging);
>  	dqm_unlock(dqm);
>  
>  	return 0;
