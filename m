Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 545C4EB64DD
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Jul 2023 18:38:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8BC1E10E427;
	Tue, 11 Jul 2023 18:38:57 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20630.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::630])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BDB6810E427
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Jul 2023 18:38:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WToQ7dbTqsnv4VT+3tp0pL4mtmF7gH2u+DMZTiEhHHCQ36/MNFF/A6V2hqoQzTIhV64/n+C6pgB9Rrpkrhfr0yojM+EDb1p9ewG9I1YSgv3Sjnxqv00YI1t9xiDzE7lmHQf6J/LRIL0pBqwPyCLiVbq6t9oGOA9rma93iUqGrcyp9VKmtldhE3h0Nob/1I1X2sBM+el+jyNf06Ev0B+25XAJOz58Zo5v2T2oFTFtzy3F3tY1OWyHo93hq75VpH81MDT7nMq2CQEFixxewAFKcCMxViuxSMuxEuacgjRfn9W5SxPlsyyLKyuACNwngPtpeQCJ8lUAvkjHKoY7ZwD4+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8QgQUO+ia52aA+ygKggrtHbJA1E2NGil7oR6GsCVYKY=;
 b=Zuut69j0ASKDBWScOkBoZSgWayHFqQtasmvKPPmLpc3Vmr44JtEwCcVJ99uSH+LOtLOs/V57SmquS0kS+yo21IaCVqGz5xNphzG7SrTJMGoTET3CCb4N6a1YTch2MjoEOV8mtPWQpkgGWKrsck4RimbwqJzSEoG1IHXTvY9MO+Q1+hUgfBUldPZk0rNb8xtkowHrjUE3sRQBP9VvsE7mmFJ9WrJE+7wyRoaAjdTzrOe1ZxL+voqcjFlK0aggDx9A1RA4iCzeRPiqF+OoVZ4tjEbDA4YnX5bA8Xxnb5F7qoVAucO3R6YEQYtNNaZwvv/WkWpfr8NE5YSF6luXAX6bYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8QgQUO+ia52aA+ygKggrtHbJA1E2NGil7oR6GsCVYKY=;
 b=QOrk1Ez3McALNmLtr3/dJUX4yCpsCOIrRrZHXYbjJb44+Hl6AZpoli6a9ZlR+78OCDtdwEmq19TRStLMRI0M+T9nmuuKPmnwAfxGC4D/H1J7R45qZ6Xgvr6rmTh3Mn0DIwgt8qXo0oTLJTDzZcCU0G6GkE5RlWSR5nvzYa7P5FI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by DS0PR12MB8575.namprd12.prod.outlook.com (2603:10b6:8:164::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.30; Tue, 11 Jul
 2023 18:38:50 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::2dc3:c1:e72d:55bc]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::2dc3:c1:e72d:55bc%7]) with mapi id 15.20.6565.028; Tue, 11 Jul 2023
 18:38:49 +0000
Message-ID: <be92a672-8d30-9863-e9a8-ad8bd1d96898@amd.com>
Date: Tue, 11 Jul 2023 14:38:47 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] drm/amdkfd: enable grace period for xcp instance
Content-Language: en-US
To: amd-gfx@lists.freedesktop.org
References: <20230711142807.68327-1-jinhuieric.huang@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20230711142807.68327-1-jinhuieric.huang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0107.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d7::16) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|DS0PR12MB8575:EE_
X-MS-Office365-Filtering-Correlation-Id: cdc4d886-4187-4c96-54c2-08db823e110f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xPi2vWLHVIfozVcX0kA8fyJl+w3eUo97IfzwKZPxwryw1KyWnd8QK0fUlAdeIpmYCtaUlf2qeVWqJYe+jrnXfJt0mPCOeTqxmPRdsmaTyvc5rb8VB0BoGPJ2fdWXI1f+jKESqAhk9Qm39lG10a6h7CWK/666L6P0+Uf5UwomaV7eFWVJ0+7icRksEAJ0ej6Nu6Dhx6F/I7B+nMYBO5l26TtHC/LdVl7VCrlEISjlt+q2QXGpmvOlVEbrGIuRSanpapn36Rqt+m9mICo7mBQ+up5Du3ggNEUAIkFek7j8i+e7hKcKcOcP1FUZbCwZ/QA6QF3guw138jcAXHBiF7HCd6cgK0LQhQ2B/IXhRd24wkTPZIsABXMIA7a/tdzxJUuMOa2AL8RnpniFWxIQEk7XrepnEBm3Bl/aLTPGFB5BdV1QsN7hRp64SRkMOl3VYCI4sXEVqSAnG4QXD28ij1NubooDGGqA/jAtjFbxaf6p7JMjH79l9U/OdwBARycniZM/SrxnE0Sof92uXoiPqezMe9i1oPKUu2oW2Emj/y3YW/YvJtCRxPrRJ5CoxgpCHZ4wW7TGxfJtroKSJYpemHipBhNYLNJRM5TyHLqJeRfdzjHLFr2P9Gv+pN+TXbailXfspQ+ljFfdFFhInVvWDWfbtQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(366004)(396003)(376002)(136003)(346002)(39860400002)(451199021)(26005)(186003)(6506007)(2616005)(53546011)(6512007)(83380400001)(44832011)(41300700001)(478600001)(6916009)(2906002)(316002)(66556008)(5660300002)(8676002)(66476007)(66946007)(8936002)(6486002)(36756003)(36916002)(31696002)(38100700002)(86362001)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QkNkTDVBUmFTb2pJT3E3bTNqaDFJRFNwUGJBN2ZnamhURGtDTWFobFo4d2JM?=
 =?utf-8?B?R1N5RWFaaTNLbE1WZkhzYXRqdlhMOUdqUEh0NnVrWjlpVUQweGRJQ1E0Qy9U?=
 =?utf-8?B?UXZqZEpwVHJkV0puUnM3Z081c0kzeC9nV3ZlamtBYVRnSnZiQkw5QUJtRHhF?=
 =?utf-8?B?aWNjZGhlMnRFaWxiVllEcjkydUVyYTBWakVVWFV3ZWlyeExSaTlTY2NmSUh5?=
 =?utf-8?B?UHlIaGFCV0hNVzBYcXJoMVE5Q1dSRTJQMnViMzNVN1NBcmdETitsRDJQSHE0?=
 =?utf-8?B?dVRHYjFnRktkV1lTUVhkaS85NlJvSHFkTGNIZHlIVnpKU1d4Q29rZGlJL29j?=
 =?utf-8?B?ckdNWXpyYUlzVHFWMThXRTBlZE1sbVJnL1cvQU84WEljdThSL0RmTXlXcENp?=
 =?utf-8?B?cTVBL25HWllvSUR4WHBCaGM0dGZTSVJaNmZUZ2E4UW90UmNnanhBR1BVMVBB?=
 =?utf-8?B?VWFQL2lOTXRacVJGRnZnYjU5QitocmNQcmN4RkQzV3h1VXlQb3BlNlBVT3hT?=
 =?utf-8?B?TjJteFdhNCt0UWxheloxRnVGakMzekJmNE9LU1llU0grSE5rVVkzZFI0S0Iy?=
 =?utf-8?B?ekJENUR1am9BTDVPbU9rOTljY3N5dk0wcDZRVzdzYWcvVTczRmd1VkZTTHVZ?=
 =?utf-8?B?MHdQZEt5bnFNdVdSd1hGK2dFNTVWWk50Mng5UG1DWjVJMkdzTEhzZFNxSzhS?=
 =?utf-8?B?a1JNcnVzTWg0TG8xTjZMSTRRSzZPNmNOemUwWHdvSXN3dWd4N0l4Tyt3dFBQ?=
 =?utf-8?B?MFhndG5Bc016ZzRNQXFOb2dBS3B5QzhkZ1dTd2NURjdNMjZ3VXArL3ZPclFp?=
 =?utf-8?B?K0syWDlIc0REVk1MK0plZThwVWxBRmhEa0VFQ0M4Y3o5SHJXSzV3bVFKb2Ft?=
 =?utf-8?B?WnB5WW0rUXpQMXVsRnd6ckhFUmpBUEdJNnFDTmtFcFpiUkdhRjY4MzhwSG5a?=
 =?utf-8?B?Z2RWOURVbjVYcks1d2dXejUrbUxWQkw2Yzg0aDBVL2RVWFcrTzZRdFJEZTZZ?=
 =?utf-8?B?UnJldkY2TUZDekVncWlHS3ZxVDRiMHRXbnUxWFRTeUk5dE45a2lNRWxhQ0xS?=
 =?utf-8?B?bkthN1NNVnZMMDZyYzJvRmlJV2wvUDVxWmJDV29GbkVOTnV4MVo4U1ZCYzNU?=
 =?utf-8?B?ZmtmREU0ckRhWnpacDlncDg2UDE0SEVTWU05NUt3OXplUDhvRFc3R3I4cVZY?=
 =?utf-8?B?Q25SK1d2eEJSbGgrT29DVHBhUk1FVStINlhwVTZlMWFKUnpPdjBrZGdFbDdM?=
 =?utf-8?B?WFAyL1ZuUlN3dVl2SFI0SXc0RzdRVVdTaG5KSzEyMXg2OTVmZVVzQzJtWEZW?=
 =?utf-8?B?WjE4ZWlJNitqdE1nOERqQjhKT05MVmxta29BV3JpZlZxcVlQc3VIV2dLUCs2?=
 =?utf-8?B?eXlQNHJKVFAyekFjNVluWXAxeGZGS2xvY09NRVpBTE1ablNxN0h6Z1pwaDUv?=
 =?utf-8?B?WXdOYVJzRnZWYW1SYkpQanZROTM4S3RoNlZuMDRsTzdndXNsbDJKeWZ5T3pN?=
 =?utf-8?B?TUcyL0JBSE8zYjFqWEJzZFJEdmxKL0ZkcE9iNWNxc0svMzdHT0dkVmFWVFho?=
 =?utf-8?B?cDJtenpNbHh4eFN2L3JVVlgyUFNRdEJDUTRQOTZ3V1grbjRpZTlSOS92TmlS?=
 =?utf-8?B?Y2sxcTZpTzVmQ3VqdmhGVXBUNEU1NzA2NXJiZiszaHNRN2NsZW8rMlJaMW9G?=
 =?utf-8?B?WjByWDkvRTU1VHVnWDVSSzFSNVY0dGU1ZE8xRjNKSUtPT0pEb21GSXhCZWRr?=
 =?utf-8?B?Mk01M0JZNGhlKzFMSEdwOWlQVklScVhXSFIyNjJ4RkE5OElUQUgwaU12QXJM?=
 =?utf-8?B?cEJURWZmN1FmVVNRYmttQk5SRVRHUTFWRVFUbDB2ZXpHZUEwRkVGNlZGczUv?=
 =?utf-8?B?RWs4aThjaktLbG9tNytiTlpEblJYNU41UUJnTmNLaUREWHZKOXJWRldDcXZT?=
 =?utf-8?B?aTBxUDAwMytaOEVkRkg1OUROeWt6S3N6R1k4Q2ZIZFBQbVg3UFFyN3NaNVdl?=
 =?utf-8?B?NGU4Q1BxNkRNeFg3N25ldXdkUC9Rd0lDa2hRL24yb0hTREo5dFMrTERnaWw3?=
 =?utf-8?B?RXpDUS85S2hWYmNuVzJiR2EwdGRzYXR6UEpjNVFhVmlYaU1EWjlKNWtGODFU?=
 =?utf-8?Q?1DYbuglmvsixYg99C6/sAEXw3?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cdc4d886-4187-4c96-54c2-08db823e110f
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2023 18:38:49.0459 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +Jq8lX8in1x24ZoF0pmUrJQ3GRkO5e8P4jphEVdvICYRDyefGTUT0SBBHouQQCTRj1z5eJF9kk6zFX7/Ki6xRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8575
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


On 2023-07-11 10:28, Eric Huang wrote:
> Read/write grace period from/to first xcc instance of
> xcp in kfd node.
>
> Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>
> ---
>   .../drm/amd/amdkfd/kfd_device_queue_manager.c | 21 ++++++++++++-------
>   .../drm/amd/amdkfd/kfd_device_queue_manager.h |  2 +-
>   .../drm/amd/amdkfd/kfd_packet_manager_v9.c    |  8 ++++---
>   3 files changed, 20 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> index 31cac1fd0d58..9000c4b778fd 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> @@ -1619,10 +1619,14 @@ static int initialize_cpsch(struct device_queue_manager *dqm)
>   
>   	init_sdma_bitmaps(dqm);
>   
> -	if (dqm->dev->kfd2kgd->get_iq_wait_times)
> +	if (dqm->dev->kfd2kgd->get_iq_wait_times) {
> +		u32 first_inst = dqm->dev->xcp->id *
> +				 dqm->dev->adev->gfx.num_xcc_per_xcp;
>   		dqm->dev->kfd2kgd->get_iq_wait_times(dqm->dev->adev,
> -					&dqm->wait_times,
> -					ffs(dqm->dev->xcc_mask) - 1);
> +					&dqm->wait_times[first_inst],
> +					first_inst);
> +	}
> +
>   	return 0;
>   }
>   
> @@ -1675,13 +1679,16 @@ static int start_cpsch(struct device_queue_manager *dqm)
>   						grace_period);
>   		if (retval)
>   			pr_err("Setting grace timeout failed\n");
> -		else if (dqm->dev->kfd2kgd->build_grace_period_packet_info)
> +		else if (dqm->dev->kfd2kgd->build_grace_period_packet_info) {
> +			u32 first_inst = dqm->dev->xcp->id *
> +					 dqm->dev->adev->gfx.num_xcc_per_xcp;
>   			/* Update dqm->wait_times maintained in software */
>   			dqm->dev->kfd2kgd->build_grace_period_packet_info(
> -					dqm->dev->adev,	dqm->wait_times,
> +					dqm->dev->adev,	dqm->wait_times[first_inst],
>   					grace_period, &reg_offset,
> -					&dqm->wait_times,
> -					ffs(dqm->dev->xcc_mask) - 1);
> +					&dqm->wait_times[first_inst],
> +					first_inst);
> +		}
>   	}
>   
>   	dqm_unlock(dqm);
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
> index 7dd4b177219d..45959c33b944 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
> @@ -262,7 +262,7 @@ struct device_queue_manager {
>   	/* used for GFX 9.4.3 only */
>   	uint32_t		current_logical_xcc_start;
>   
> -	uint32_t		wait_times;
> +	uint32_t		wait_times[MAX_XCP];

Why do you need an array here, if it only saves the wait times in one of 
the array entries [first_inst]?

Regards,
   Felix


>   
>   	wait_queue_head_t	destroy_wait;
>   };
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
> index 8fda16e6fee6..960404a6379b 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
> @@ -292,17 +292,19 @@ static int pm_set_grace_period_v9(struct packet_manager *pm,
>   	struct pm4_mec_write_data_mmio *packet;
>   	uint32_t reg_offset = 0;
>   	uint32_t reg_data = 0;
> +	uint32_t first_inst = pm->dqm->dev->xcp->id *
> +			      pm->dqm->dev->adev->gfx.num_xcc_per_xcp;
>   
>   	pm->dqm->dev->kfd2kgd->build_grace_period_packet_info(
>   			pm->dqm->dev->adev,
> -			pm->dqm->wait_times,
> +			pm->dqm->wait_times[first_inst],
>   			grace_period,
>   			&reg_offset,
>   			&reg_data,
> -			0);
> +			first_inst);
>   
>   	if (grace_period == USE_DEFAULT_GRACE_PERIOD)
> -		reg_data = pm->dqm->wait_times;
> +		reg_data = pm->dqm->wait_times[first_inst];
>   
>   	packet = (struct pm4_mec_write_data_mmio *)buffer;
>   	memset(buffer, 0, sizeof(struct pm4_mec_write_data_mmio));
