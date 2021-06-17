Return-Path: <SRS0=/AY/=LL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42842C2B9F4
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Jun 2021 21:52:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E214460230
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Jun 2021 21:52:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E214460230
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6A5C16E087;
	Thu, 17 Jun 2021 21:52:50 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2068.outbound.protection.outlook.com [40.107.244.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CFBD46E087
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Jun 2021 21:52:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EBClVWtMoC1NRe4KdwkS2Dmn/XZTUKS4uAsQ37aCjyipyGJUFi4cnTipL4wSmkozLMB5HvsFg4OIb4VVZ3RBd1bwt4v99RfZrXtmLh7rsMI1fEvx64s4hmke6EZl1wNG+gqNx5oqz3rjpfppGxrpMhpX07VQZYB9VJU/I6yRkjKqAQjpQWFIPuao9aeRQ84uDwC+MvgBO9QgNrHWx0raiHyBX2nwZrnlmiwrH2USVPRFNVqh7yC+vhtCSjZWvvpkOaABcm157D0ue0V1khvFxhl1Z1HG0vRdT/VubaWcvhD/IAgPc51Q66VG0OCFNMOMkPBBPiD9vfKjHsAJOLIxpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YbYameYRB32K0hSS+15o9hjfybjhAplyGZPjNvJ45wc=;
 b=OVyJ0wWhfVjJiItOhwAcvAW9H6fpCuE8XIeNFuFi9e+8w1P5fDf0wq6S8BULE1/r1kKo03+oeMNBU41um9a6di7GFkwvc663Kbysoe1NKMkl9FcH4r+T7Rtz6kY6vObpoXEM1DCNj3Vhf4VPpXXmkLFb3mETN6JCcytvJkwhfB1QEW2DYhc5eLcQkwFrLWYJue3lhowC1p2dTYMybiHqoJyrHy8S8e7N675cRw5WZS9Jc57fVaTHVIWZ5iFqbS90VORcDXP/rcg7IsNE7hzSZVu7zkLNvSqz20YLGX39NNW8C39v05vh+AlCIrTsb+TdEq44G1XwKnToKH9oouHGwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YbYameYRB32K0hSS+15o9hjfybjhAplyGZPjNvJ45wc=;
 b=4y9BDtyH9z6+v7bxSioGOFG0lWJvTkkeG9pE0LQI0KywN6zZah+OOynUITwC6SIxupUql9IHyDv2FmpPaz5LSh8tHYCb6JESTFOTNk3er1XBQqwXNoXvqCtp+C0/pJpnMtOXTI5Vju5oyBeplZa9iqEeovW4np/13qB3Ijl5sVQ=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5129.namprd12.prod.outlook.com (2603:10b6:408:136::12)
 by BN9PR12MB5275.namprd12.prod.outlook.com (2603:10b6:408:100::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.15; Thu, 17 Jun
 2021 21:52:47 +0000
Received: from BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::3c78:e58b:fba7:b8dd]) by BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::3c78:e58b:fba7:b8dd%6]) with mapi id 15.20.4242.021; Thu, 17 Jun 2021
 21:52:47 +0000
Subject: Re: [PATCH v2 2/2] drm/amdkfd: Walk through list with dqm lock hold
To: xinhui pan <xinhui.pan@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210617120246.1730-1-xinhui.pan@amd.com>
 <20210617120246.1730-2-xinhui.pan@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <1a74caa5-a368-2fb6-9268-fd5b3f6c8830@amd.com>
Date: Thu, 17 Jun 2021 17:52:45 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
In-Reply-To: <20210617120246.1730-2-xinhui.pan@amd.com>
Content-Language: en-US
X-Originating-IP: [142.186.84.51]
X-ClientProxiedBy: YT1PR01CA0102.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::11) To BN9PR12MB5129.namprd12.prod.outlook.com
 (2603:10b6:408:136::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.186.84.51) by
 YT1PR01CA0102.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2c::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4242.18 via Frontend Transport; Thu, 17 Jun 2021 21:52:47 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e15fa703-1821-4aea-d6b6-08d931da3ec0
X-MS-TrafficTypeDiagnostic: BN9PR12MB5275:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN9PR12MB5275AA8F31FD330AF32A031B920E9@BN9PR12MB5275.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xa0DPlZN0NKmqcl098dOePJ/b3u/CUdw/lUpqjlQE0fDncFxicIse4q2RbkJG1OR0aybiRjhypd6oPlanRzNxXmIABpMD9gi25IgxDl6BQn3EnYfLAriqnMH8+fzxPGDirfLSQobkpO32SMXr+gJ7kUJBew1VIKrCGBsUPG8NAd0AruvCw94TfScqyESFGkzvkiAu5QPY2OLmYqILc5jnG6sjNhmd+g5ip+U5SgxGBimUyWywppii/INN8z7MhCFXCtMzEQc8i981JaT2H09RUK04igih2YliDW6Hg1y+SVZOViK2zkv/LJFo7yBtToypV8QHZFXRdNbCY5kuiANGP4jE5kq4pqYr/dGYVjZ2rz4N0XydzipmB7eWjMDvo1gTtfUH86b94w4TUUER7bRLkt+S80Dm4H/bizPXS+X9UW3MYP0uNACm0dAzjEDQ97uCaqkxeR3ulYWZllkWv985VPpRHIh3OnPT1nfc0f4ZyUULjXKPte+oFPxrQbBOdKwfl6hvmn8774d2z+WBcJgfzFcRJppuiyIP549ILEhp2zMjT2v15DvgSVN7M6TTjTY7jTb7nJri2Wwu0GmCb5lAsfKANqZI33Hd2FYvzSX/6DkRtLEZ/EMv4lzQtoxvkEkIQPWOolVtkQ48SRbOHAtGF+5CsDzCUBZvuqs0vnHmdcHqhIyyQdVBXv21w4U+0M2
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5129.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(39860400002)(396003)(366004)(136003)(376002)(5660300002)(38100700002)(956004)(66476007)(4326008)(186003)(66946007)(8936002)(16526019)(316002)(16576012)(2616005)(83380400001)(44832011)(2906002)(66556008)(26005)(36756003)(31696002)(6486002)(86362001)(31686004)(478600001)(8676002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VVhnakFXMDRvSHBxZWF0K3VCZitkYmpCVDIzMCthYzB5SXlOc1BWZmZPQlp3?=
 =?utf-8?B?RVlNeElmL09jbFgrb3F5TXppSTdKbEpMU0tDZ1NocTFudVpXdkk1L215VlpU?=
 =?utf-8?B?MVdkZVdCemMwMVBNNTV6RUhzZ0pSU01BSURPTXpTZmh3RzVxNkFCaFRTbTds?=
 =?utf-8?B?QnFBTjdnOW5QTFVSZnNNR0EyYy9ZeVowSnd6UGhUaG9zYlNVQmxMMmt1MTYx?=
 =?utf-8?B?UmhzMG9vYWR2K1ROTDJHTGhEMHg0bUpCTnRhSmp2Vm1yeU41UVdaVEd2RHZF?=
 =?utf-8?B?M2tBbENjQ3R5WCtOYlFOcVljRkg2NWFkUEdOWVdLaUloUEJSMGdSbEpOZlhZ?=
 =?utf-8?B?bURPVjlEUy9WMitBNkgwR0srQVJUejcrSnhsTU5zOEppVkZ0NW5pTGhBR05j?=
 =?utf-8?B?QStwczBMV1hUVGc3QWRBdWRxRzlVblVRbEtHaDJiaDg1ZWROT2ZDeEZvOExH?=
 =?utf-8?B?clBtK1JYVThiTjFHSzRqVTNUVks3TWZRVmcxaHdWcmtZTEl3ZlQ1THRHdWFn?=
 =?utf-8?B?WGtYVUtYOFBoZ012UzlEL2szb1p4S2czMThLL20reTQrSk1rMmpNSkVoYUFn?=
 =?utf-8?B?N1d2SkV0Ti8rcUx4bU11bVBSTzVPTXlNd0txSEI1cjZUV2I2c3N1OWE2cEpN?=
 =?utf-8?B?ZnZmb0QraFlWa2k3Z3J3NktTQng5NjR1Z29PbDlqcVNSSE1mMW41MElhMDk0?=
 =?utf-8?B?Mng0MjJLaHQ0bzl0YVNKUVpZL0QxWE55TXRiYmZNU0p4WklWU2UxbFpRNE5O?=
 =?utf-8?B?ZXNOSFRabm5UZ1AzMVgzbVhacUpaeCtwQ3FHL1hQaGV1a2gvbCtSVG1xRVpj?=
 =?utf-8?B?ZU9CUGRtd3JibU4zUloyUHBOYjI5S1JtSUxFbjE4SWZtWlhnSEQ3Q1FlR24w?=
 =?utf-8?B?VnpObFpuZFZTV2h0RENpQkRzTEkxaHQvN2dJaUYrMWJuTDFZSitIdlJSRWlz?=
 =?utf-8?B?SXlqdllWMWRGYkdOMkxkbXRybVViNU0wUEhJeXFtcGFsaGVNRW53Vm1VZER2?=
 =?utf-8?B?QnQ0bnJ6c1hsam9nM3hKa0J5SFJKMC8xN3M1VTRDQ00zQzhsM25zdjVvd3li?=
 =?utf-8?B?L05QUkVZWmdtaDQvQ1B5THVGN0EvRUd4aFdFdDhVa1YzV0pXMnFJbGVnYVdE?=
 =?utf-8?B?dkhMN21sbGVNNDAwVDFsa2NrU3JTVklxYmUyRGVTNVdUdExzUjcyaUpHTnRX?=
 =?utf-8?B?d0NJbmkyWGplaERuR0cyN1UvM09HanpxbzRFcFZpZTNhbkN4SXQrUTcrWStD?=
 =?utf-8?B?YzlacUdlSmNvQkQrUXFLbHBsanhuZUpFVkJ4NVROdStvdFJ4cDJDT3ZTcnRn?=
 =?utf-8?B?TGltZDRLWjhwNjY5b3RYdDR6M1RBT1BpMGl3RW1nMXNWZTNQZTlHUmYwQzVQ?=
 =?utf-8?B?c3E2NE1rQ0tmb0JtVUJSS1REbmZmYVNGcjc2RTNpK0xaalNHQ25nQlU4MVJI?=
 =?utf-8?B?OFdwQXJ2OWZrdmcva3Iwc3lhaTFQazdJVERNSXIrTGZjcTBPYk1naEU4R3Rw?=
 =?utf-8?B?bHFEQjdRdmovd1pYeHVCVzV1bHZzNWF3VjFKbERMMUhCd2VkUjVWNy9ac3Y3?=
 =?utf-8?B?bUk3VVhneTJXNEdiQkhlVDM1U2NFdkxDOTY1QjF5ZHNTVmpzM2locWgyeXBR?=
 =?utf-8?B?LzRRMWs3TFhEcTVRUDNBWHQzd1R4cUhZc2VpaDIycEJQdDdCaUVqdGNPSC9s?=
 =?utf-8?B?dXdoNFZCSmJ6djJpRE5qbVVKTS9zdnBEYSs1b3lzQytnS3RvbjlNTHBJTXpk?=
 =?utf-8?Q?1ZWiQGTjCG9RRAHgRnGJ99jYebjCrj6nDEsY87b?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e15fa703-1821-4aea-d6b6-08d931da3ec0
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5129.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 21:52:47.6277 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2ILjxot6WGzqu0iacRxc8n02FCb92tPxvzNLmzbvFi21EulEhe8qNi1Ypg0X8gkoQU4C/9eVl7WCNSKZnkRQ/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5275
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
Cc: alexander.deucher@amd.com, christian.koenig@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 2021-06-17 um 8:02 a.m. schrieb xinhui pan:
> To avoid any list corruption.
>
> Signed-off-by: xinhui pan <xinhui.pan@amd.com>

This patch is

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>  .../drm/amd/amdkfd/kfd_device_queue_manager.c | 22 ++++++++++---------
>  1 file changed, 12 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> index 63a9a19a3987..d62374746c93 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> @@ -1722,7 +1722,7 @@ static int process_termination_cpsch(struct device_queue_manager *dqm,
>  		struct qcm_process_device *qpd)
>  {
>  	int retval;
> -	struct queue *q, *next;
> +	struct queue *q;
>  	struct kernel_queue *kq, *kq_next;
>  	struct mqd_manager *mqd_mgr;
>  	struct device_process_node *cur, *next_dpn;
> @@ -1779,24 +1779,26 @@ static int process_termination_cpsch(struct device_queue_manager *dqm,
>  		qpd->reset_wavefronts = false;
>  	}
>  
> -	dqm_unlock(dqm);
> -
> -	/* Outside the DQM lock because under the DQM lock we can't do
> -	 * reclaim or take other locks that others hold while reclaiming.
> -	 */
> -	if (found)
> -		kfd_dec_compute_active(dqm->dev);
> -
>  	/* Lastly, free mqd resources.
>  	 * Do free_mqd() after dqm_unlock to avoid circular locking.
>  	 */
> -	list_for_each_entry_safe(q, next, &qpd->queues_list, list) {
> +	while (!list_empty(&qpd->queues_list)) {
> +		q = list_first_entry(&qpd->queues_list, struct queue, list);
>  		mqd_mgr = dqm->mqd_mgrs[get_mqd_type_from_queue_type(
>  				q->properties.type)];
>  		list_del(&q->list);
>  		qpd->queue_count--;
> +		dqm_unlock(dqm);
>  		mqd_mgr->free_mqd(mqd_mgr, q->mqd, q->mqd_mem_obj);
> +		dqm_lock(dqm);
>  	}
> +	dqm_unlock(dqm);
> +
> +	/* Outside the DQM lock because under the DQM lock we can't do
> +	 * reclaim or take other locks that others hold while reclaiming.
> +	 */
> +	if (found)
> +		kfd_dec_compute_active(dqm->dev);
>  
>  	return retval;
>  }
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
