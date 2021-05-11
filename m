Return-Path: <SRS0=e+DK=KG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DB44C433B4
	for <amd-gfx@archiver.kernel.org>; Tue, 11 May 2021 15:40:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98708616ED
	for <amd-gfx@archiver.kernel.org>; Tue, 11 May 2021 15:39:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98708616ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 25D316EA67;
	Tue, 11 May 2021 15:39:58 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2065.outbound.protection.outlook.com [40.107.236.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F1D086EA67
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 May 2021 15:39:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V5JwKa573y1e4LJDI75Ujp4Px3skcX3nInnDj49KHzJheyEyBwYwVkQ7Fl7rOdlVBUQGB+z+KGIQw94kyc/51azciIWtRezGckhKIeESVicJIW6OENm7NTfhtIdskdjpXqRTglZwaE3q37hWk9LJwcnnDifoYWMA22YIa64g3t6RZtDVEsCUPrgPW1l+HQ9iZGnPE1s+2lIaZBDzHce2zrRupSpVk5KeD2c6cVz29tdAYfRf7gzUITDR0M0nk7igBM+VI5urvH1Ust9NMDQtxxpp+wWm/E/klvN5kKPa8lCsJtsVS4uQzlXPl3oOBBoK57N2D/BHPA10xbL3iLQF8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gBKnqFBx/kkDCh41pCXhAx9WA5f2JZooVzMIsxM836s=;
 b=EvrV1rOXvAmg6Xd+7yAdMyqMXUxOg015bPCC86IzobJiRZLEGasPdSilacpUi+L7Hj20viNElOuKbUp6CfplSd/VEDin/EiyUdxnd1z5KkC0OCe2EmaYavtjWE6Ix0FPO7JS8zYuuxXvJGJeF/PKxwJIro12iEMfWFYQrgAndBB1SUFWvSOlKCJPJyKb77fmqpf+eQKbeC+IBfHGP/IN4dhQgzvOSKRNN7goEjQkXbRIbV9K2qZXzWCiymgS25qH7tBwhtpU8VUogqIe1ojsJ66OXPPHThFguVL++3d3UGbn1ti4Y2+CgsMt5lA8nCrB4xoaEaHv0pES3vdhjldzBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gBKnqFBx/kkDCh41pCXhAx9WA5f2JZooVzMIsxM836s=;
 b=CshOJzI2W45vDV1wwg5auc5tubDcuB2DLznleY7NzwSPgnyb5OENdDIBf1AadqbCJVfrSowE5cvxwAw1Cgs8wm+yfIdDAuBeBz6avOUvx77qMkncI2X3Um0QDZWKTTX+Z5nGWwC9Pqb21yMslxoJCGxtSqbFowX+YWAyYFo+Rko=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5133.namprd12.prod.outlook.com (2603:10b6:5:390::6) by
 DM6PR12MB5568.namprd12.prod.outlook.com (2603:10b6:5:20c::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4129.25; Tue, 11 May 2021 15:39:55 +0000
Received: from DM4PR12MB5133.namprd12.prod.outlook.com
 ([fe80::cdbd:bd79:d9b2:ed90]) by DM4PR12MB5133.namprd12.prod.outlook.com
 ([fe80::cdbd:bd79:d9b2:ed90%7]) with mapi id 15.20.4108.031; Tue, 11 May 2021
 15:39:55 +0000
Subject: Re: [PATCH v2 2/2] drm/amdkfd: new range accessible by all GPUs
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210505175617.30404-2-Philip.Yang@amd.com>
 <20210511151504.31849-1-Philip.Yang@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <960a368b-ee89-9a30-2dd7-9c5dcba3129a@amd.com>
Date: Tue, 11 May 2021 11:39:53 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
In-Reply-To: <20210511151504.31849-1-Philip.Yang@amd.com>
Content-Language: en-US
X-Originating-IP: [142.116.138.207]
X-ClientProxiedBy: YT1PR01CA0030.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::43)
 To DM4PR12MB5133.namprd12.prod.outlook.com
 (2603:10b6:5:390::6)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.116.138.207) by
 YT1PR01CA0030.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4108.31 via Frontend Transport; Tue, 11 May 2021 15:39:55 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2f712906-8af7-421c-d4aa-08d91493067e
X-MS-TrafficTypeDiagnostic: DM6PR12MB5568:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB5568C020A12D8950E977145B92539@DM6PR12MB5568.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hrrc2HPUvTFWDibftoS0k5ykJam+XIoQFJr1NZ0jrWzQJuhfLjlr0iIuRbVq0sYSd3F+pRnThZmwegkam9HpjOZZw0pXZ4SThpvQt9Shq5P5o2jJ3oix0l2a4xM1INXnD/lP+k/XblG865n3vrNKwDFN18/cOOhWr5fODGTyaSKY7/T+s/u0/FaXwbk48Vat7Mva+SnmkLwr/GlyxTB16Uw3x/IRCCeT9y2+LmOtGcD3zciBhw1QvMLT4y5QiUImm2Ox1HWWt4+UPQCWOLZ11r1iNXScuZCB6+ImvRapgDiTzP9co9JwhQ+xxdYn9Vcwt5bzkkDzjEvDjdDTSK4mxzZVWEfb0p/q/qb5n3gwj+HrFL1+pUDzwaooW0ovNUvVNn2cZGolfLw2aN4ZuoOTGUMQSHuXSWyBTiWGtrrpifrZLtxewWjubAmrhHRO/xam9mFrJ2JigU/XOR0m8G6oLTudYhFs1COtrRxUDuy1BWM2R5X1sqNdS2MHqx3SBpQHm429JCVePZCbGcHEFkRiSJAd9U/kpRWxhb+q89EmAHRa3gqy0MiSPUp72wQoQVctair6bXSO4VOLJMH2xnWoLnN7QHDxgHxCdbrFdpJarulkvL6QUFvDQfpn1kW3oSGIAlY8ZItXd/8TJfkKzrnwKUN7Dbk5E75xNxpJH/c3DlcAh1sp2OqDczCW9Hs6Eca+
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5133.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(136003)(346002)(39860400002)(376002)(366004)(16526019)(186003)(66556008)(66476007)(66946007)(2906002)(31696002)(31686004)(316002)(83380400001)(44832011)(478600001)(36756003)(5660300002)(38100700002)(6486002)(8676002)(26005)(86362001)(956004)(2616005)(16576012)(8936002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?ZEU2ZmR6cVkzUlUwVnJGVU5qZjdHeVpxY3hLQy9LWVdyNG1peTIrTWJRQkIr?=
 =?utf-8?B?U1dnK0psc1Z2WW1WbHRXZHBLeWpGTlVGa2tZNE5DdzM1bDVETmVKa1JNM0dZ?=
 =?utf-8?B?NE84RjJ5c0xjMkh6NjB0azlTWnNNTG9JSnVpNWJqZmVkbGROVzdDbmpNTzhY?=
 =?utf-8?B?TVA4elJFRkdQd254NVl2Ujc4SVB3eGZPVDJCc0dMR3VTMUo0MHBsc3lXWVVF?=
 =?utf-8?B?N0ZiM1c1TFhnRGZDTVczRWs2NU1pT3l4Qm5lcVB6bTdwWDNUZ1lZWEFLcWxM?=
 =?utf-8?B?d1M0RG1JVTM0bDVZTU1pSTh4VWlIZU1kYmNVcml5T3Nkd05iQmZVVkhROXQ2?=
 =?utf-8?B?Qm1ZWG5yRmdLdkYrRHprb1AxZFp0K1lZdVFieWIrTjRSdEhBb241MU1jZFZD?=
 =?utf-8?B?dnJSRjArZkJHR3B4aTFMMlZFVFFjVjROWVRudTNZeDZEcWlHSit5TEhabklU?=
 =?utf-8?B?Zk14citSU2lzMTVIb0FSMkNubHhmQWx6UzFwbkRlY1F3am4wOUErVDJxZmlX?=
 =?utf-8?B?ZTlEdy9FZE53UHYwUzYxWWY2b3graU9BRmY1UDZNQ2hrcU9YTGRFcDVMMGlO?=
 =?utf-8?B?VXJwTjdkNkZqWVRWT0RlVWYvTHRlRjlXaTl2dlcrbUxTUEtyekE4ckNMM1Br?=
 =?utf-8?B?aFBmSVpUZWFtUTd2VXQ1V2dCbUxsTFJ4b05nVmxMOXpMdXdObDNsUDVmRFgx?=
 =?utf-8?B?WE1GT0pZUWJudUZpMUs1WDRwNXlFK1BBN1VKdE5raXdhcngrWE8xTmpTREV1?=
 =?utf-8?B?TUpXQTZoZFY4d1hkeW55Vk9qVld3MW5Ob2ZXamRyRU15aUQ0NCsvT0I5L3Rk?=
 =?utf-8?B?Y0hjMDEwdlR0SnpBV3pnNjFZTE14M1ZVR1o0TWF5YzV2Zm9EWU5VOG9TaS9L?=
 =?utf-8?B?endERlJmMnBCWEdTYTdvMm5Zc2QvN1VhcHl3ZVllTzRzQmtLWmw2UTZBRmFG?=
 =?utf-8?B?YVRTTFF2Y1VMMjR1cUpZRVI5NldLN3lsL3hFOVpTRGk5ODVvNDI4WGFBOFp2?=
 =?utf-8?B?bVZienZ3UjVGNWIwaWJBeUVUeUpHeXJXQU9tRXIrVFpmV2JwTjV5b0pjQXQz?=
 =?utf-8?B?WEZXTFFuQVR3OGgySCtQYXRoNjRwWjlGVTZGYU5pRTFWU0hDVzlCZ0VVd0ZG?=
 =?utf-8?B?Rm9MejlielZjb2dMTFR2blRCWUpyWG9yUDZ4V3BGY1dGQlVERUxKSlJveWVp?=
 =?utf-8?B?aDh5eVV0L0NGWVNGZ1l1dWxBazNaVG55ei8yT1k5YlZmNndmVERWaXZ1YWRR?=
 =?utf-8?B?Vm5lSE1HYm1tbWU4LzdsMWpQY29GTEpLcXg0SzQzNHl6aXB0UnlaUTZ2ODdY?=
 =?utf-8?B?UVEya21FbWhZWlRaOElrbW9mY2U0bGM0NnBOVGFhZm5qbVU2ejZKMmprbGdx?=
 =?utf-8?B?MVpIQzNSd3V6WXAycDZOTWJPQUFWZ3haQm1TNmtKUTBYMHNJN0JEVDlLMURp?=
 =?utf-8?B?MHN6dFFtZWVwWERTak9PSWRseTJNREt0cHBoYXBDVENhQjdKdjk1VXFON0Zu?=
 =?utf-8?B?bm1VWXRaVGtwVzI4bDlIc2ZRQzZYc3BXWm8zT0QzbDB6cUZGTVNadXRuKzk3?=
 =?utf-8?B?bFh1R0hiVXBJNngwNm4vRVRaQ3BuK2cvRy9vS3A1MnBqUDk1K2JjQXhtWWUz?=
 =?utf-8?B?cnE3RHN2MEVJUm5zWjhEa1h3cDc3L2JIbzFiRDhqelRzR1JQYThzajdMR1R4?=
 =?utf-8?B?aS9sZFhxL0JNNDlQOXJTT1pERlRCWFBFS1JrVlNBQXQzTkdzM1NTNHQyZGUw?=
 =?utf-8?B?aFI0UzVDcU5aNGZadUMwSXJBeitTYkZhdDNlVTVLbENBTXE4VHJCU0RDMDJO?=
 =?utf-8?B?aEMrREpPeUJXT0F1ZDB6dz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f712906-8af7-421c-d4aa-08d91493067e
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5133.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2021 15:39:55.2364 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9dVsjy/O4f+PtVXYzKvcZWcC/vCLv61WoD0R59BE/nd07GA07Xffzbvfx+m4PntDCke6395/5XuuwKaEgMgxOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB5568
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

Am 2021-05-11 um 11:15 a.m. schrieb Philip Yang:
> If xnack is on, new range is created to recover retry vm fault or
> created by SVM API calls, set all GPUs have access to the range.
>
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index d9111fea724b..6a677bdfcadb 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -258,6 +258,7 @@ svm_range *svm_range_new(struct svm_range_list *svms, uint64_t start,
>  {
>  	uint64_t size = last - start + 1;
>  	struct svm_range *prange;
> +	struct kfd_process *p;
>  
>  	prange = kzalloc(sizeof(*prange), GFP_KERNEL);
>  	if (!prange)
> @@ -277,6 +278,11 @@ svm_range *svm_range_new(struct svm_range_list *svms, uint64_t start,
>  	prange->validate_timestamp = 0;
>  	mutex_init(&prange->migrate_mutex);
>  	mutex_init(&prange->lock);
> +
> +	p = container_of(svms, struct kfd_process, svms);
> +	if (p->xnack_enabled)
> +		bitmap_fill(prange->bitmap_access, MAX_GPU_INSTANCE);
> +
>  	svm_range_set_default_attributes(&prange->preferred_loc,
>  					 &prange->prefetch_loc,
>  					 &prange->granularity, &prange->flags);
> @@ -2243,7 +2249,7 @@ svm_range *svm_range_create_unregistered_range(struct amdgpu_device *adev,
>  
>  	prange = svm_range_new(&p->svms, start, last);
>  	if (!prange) {
> -		pr_debug("Failed to create prange in address [0x%llx]\\n", addr);
> +		pr_debug("Failed to create prange in address [0x%llx]\n", addr);
>  		return NULL;
>  	}
>  	if (kfd_process_gpuid_from_kgd(p, adev, &gpuid, &gpuidx)) {
> @@ -2251,9 +2257,7 @@ svm_range *svm_range_create_unregistered_range(struct amdgpu_device *adev,
>  		svm_range_free(prange);
>  		return NULL;
>  	}
> -	prange->preferred_loc = gpuid;
> -	prange->actual_loc = 0;
> -	/* Gurantee prange is migrate it */
> +
>  	svm_range_add_to_svms(prange);
>  	svm_range_add_notifier_locked(mm, prange);
>  
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
