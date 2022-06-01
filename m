Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9B64C43334
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Jun 2022 23:19:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7729B112820;
	Wed,  1 Jun 2022 23:19:37 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2075.outbound.protection.outlook.com [40.107.92.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EAB90112820
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Jun 2022 23:19:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iqj0EMIOwXJ0on1cJdYxpTQ5rrPSFaPDht667RT+On/Q9439LFsTW/bpMkCyz8/jU1k1MzhRccQWhfDJdNaTGefN22jdBZVZDLQRWRZb6ZipJZUfe3gHwFQy3AKMmAjhmBoifN8py+cQc7DjbNy69eTUTrpS2Ng97QurZRWGZSog1krNPUiR98tLtq4I3lperw07VEYZYXsptgmso0y4zpxgow8KmKhuPAE+blsxujmhxis90z85+74RFjiCO9DEEH6mTMTwESY3oBmhjvjD1MlTEUs9ivyj+5BX0sr4QgPUgoEFEDKccYx807L4ookYOrpfflw2GwCbvgIEhlYePw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XymepGs45+5oTp/oucPeDgZFjz/uEihqDvQtOB2TcEA=;
 b=OWSAf1sTSgmIQTd8IbUQoP3ghLf6EPrptrd38scXQ37BIu5qso/drw//G9KjcpR4Ue5vTbXlCDlrOoqVJZJvqSjtQ2ET/INYDpRZi/oGW+vtgpNOECeux693MWndChlqm4qmN4Zk8ku86KZ0FJYLYbizm19K/RtltC9Kr7BYpJfr/qKNelp7jE6q7nHPMRkkNZMIPWTuflicWupy+x+qYbjFl5wdVIBiVIno/n/EBHi5t+at/hD2BzUVoa04pbMHastCccwwZ/TGG/FDII5An++6VZ3dPb+QSXP71iwQAP1UEGxI77WEFrgTLxw4HHazGFVGsJeFjB1oBzqm8vGJYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XymepGs45+5oTp/oucPeDgZFjz/uEihqDvQtOB2TcEA=;
 b=d0pSBeALU1TLOjkrGZGYmTQrNGeyXt5hl3a67a06D6lfOD0kzWuxqonOwV0CV3wPDmZgPYGixhfmkVuHPI53sSMUOySf8GMYODV25Yoj6+gHwxBJE9pr/gECod+e56l+HfUpA5MyvLJJ32N1F0lDp9KWF3BCe6/D+vXMJxL+IUs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by MN0PR12MB5931.namprd12.prod.outlook.com (2603:10b6:208:37e::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.13; Wed, 1 Jun
 2022 23:19:33 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::1cf6:2a9d:41d6:e8c3]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::1cf6:2a9d:41d6:e8c3%4]) with mapi id 15.20.5314.013; Wed, 1 Jun 2022
 23:19:33 +0000
Message-ID: <0795b580-c16a-f269-aa17-23db915b654a@amd.com>
Date: Wed, 1 Jun 2022 19:19:31 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 1/1] drm/amdgpu: Update PDEs flush TLB if PDEs is moved
Content-Language: en-US
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220601231246.28716-1-Philip.Yang@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20220601231246.28716-1-Philip.Yang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT3PR01CA0125.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:83::26) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 570769db-7613-4096-8e13-08da44252fcc
X-MS-TrafficTypeDiagnostic: MN0PR12MB5931:EE_
X-Microsoft-Antispam-PRVS: <MN0PR12MB5931ADB5C3B4493FA55F0FDF92DF9@MN0PR12MB5931.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zvfpWpDoZQK6jN/44u7ZKwgCUPYC1u1oMDS3d1wIsugLdvMomjgDOyEqVNUB3gtwif5LdIP2ONYNHvv9z+0GGBeCXeUP+F24rUeow4brdCFXdHzCigLFqy1pii/JazyJu85n5d3Q6h06tf9wJYgsUyC5ixmk5+dO01DjpIjVLpz0QDDd0ncmx8buiO+nXw1BXGNDBAxJORA/uQzv59waKfc3qvyYA8twlJ29r6ch4Ju3ysVfB+0quX5LqYED5Rt1Ydr2smG303h2ab9ieFrJe0PcKauqu3ZW9dvp2yQJxnmiLInfizE0ndMdJGFkfAPxS2du6gKW5XNpuMqUp9mgyHsfy7jpf8DZB6yfHxC1ovStO6+4P7FC57eTL6IftBoXuzTjPLwKe0CeiZFhshhxHCW6bBnQW76XTmwzhbIojq7EJxSTuo8BSI1KlodkWIfWUSO33b0nqoR8BdTWCmPEEqrUTy0nRXSjNItgw/wYVajQUw6D+xNvqQsUJDExACh77ip26glT/t/2H4n6xd4uh6bokAtXK4a3NoXqzhqpv/2dU+/zGz5Ol20XZfFiUiEirvETlfts+pF1hXxCKE18Nn+sE/DAxKeiY9Q/TV0IU4D5QGMmV9tDzKGhEJWX8g4IJN55XPzhbiYHlfPQuWTMRkOsbsppd/J4y23v78l7cHp6jWdYR8meOoLZQH4jSkSpdiRym/8UiRIfJ0UcdDgGI/IvHZ4xAKfkptJ/LjMkRow=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(5660300002)(44832011)(38100700002)(31686004)(8936002)(6486002)(15650500001)(36756003)(2906002)(83380400001)(66574015)(26005)(186003)(6506007)(2616005)(31696002)(316002)(508600001)(66476007)(66946007)(8676002)(4326008)(66556008)(6512007)(86362001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Wmw0dGpmcENqTERhdzk2ZVZFK2Z3QjNEMUJ2bTNLL1ZMZnpPSUI1ODNUb3Iv?=
 =?utf-8?B?QStQamFuMDNURk1JMndRRnlNcS9UcThvbjhmaElmVnZCZnVTMWVBZFhESGdl?=
 =?utf-8?B?VDdKaWlaN1VRbTM3Z1BDVFFtZEN6SWk0ZnBObGhQMjg5RVhHMUtLQmIzaXRP?=
 =?utf-8?B?S2VVYnVGbkFMNU54M1kxejZZd09SRGJ1bmYwdlp5SnM3U3dTNnZZYm5UNU9w?=
 =?utf-8?B?Qm9JUGtPMlR1Yk5mS2tCVHhYT083VmtaMU8vVXdoenZ4ZjcweTNFWUhYVVdR?=
 =?utf-8?B?eHY4YTIrMlpYYXNFcHM3NC9uTzZDbG9NK2V4TUZlL0tuTC85TklJT29SZkF5?=
 =?utf-8?B?aTMzaGEvMmtuOG9Wc2J4K3FjUUxkaS9vd3M0Sko2WXhia2Z0a1E2cXg0SFlu?=
 =?utf-8?B?aFk4Z2c0WUVBWmFsNVRSTTEzY3lRVW1kVVcyRXdRQjZWTEQyMHBKOEVGMkVn?=
 =?utf-8?B?NTRMS2Q5MDRNcFN2VXNnUE5VMVcvOFRZSWZldDZKTmwyQzV3b05CVFowczUw?=
 =?utf-8?B?K0VPaFJCSEZ6ZUhKQUxIakJoQTArZHdZU21ybGRUdXBYbUt0SkhYdDRuSEgz?=
 =?utf-8?B?Z1lXVURMVXE4ekpONlhKMnJtWmRvcVNybFNydlh5dENIOWtHT0RCZ0JqKzhT?=
 =?utf-8?B?RGtPSkRvNitSOUVTUUQ0SUI0QXZCbjEzNWV5eGNnaVdkL0lWS3NvU3hMdnh4?=
 =?utf-8?B?cXowVUlLa3ZFSlhtZWZMd2FtVHk5c0RZRjZaL1RwcW1aWTBPZWNaeTdmOWlD?=
 =?utf-8?B?bDhQUjVEQVB5UGVGVkx2YzFiUkprU0dnQ2lxWEkzcWZnYzJUTTJkNm9aOFJl?=
 =?utf-8?B?Y0NxS25WR3dOTEJWK0tzRmN1c2haZjZhT2NjRTNEdUZJeWtLUGZQdDRLSGNN?=
 =?utf-8?B?aDI3QlpXeFZNN2p6YTlURURSMW9YYkVqd2pKUVZJMFNnb0l2UjluYnFqTWYz?=
 =?utf-8?B?RGl5L29MRHliTXh1R3Vmc05tVVJOMWR1S3JOR25IT2Qwa1JwUnRPN2ZVWnJQ?=
 =?utf-8?B?MkVNQ2Fvam9xWmhxN09uMzhmU2VhQ2VweWRGSmxuRWdJUHhWVldZRzFXZEJy?=
 =?utf-8?B?Y3dlTnhYck9uZW54b1JjWmlDYmw4OUNTVkNoRUhUVUpRYWc4TnRoMHFGU1hV?=
 =?utf-8?B?V29CcmFtdXJkeEh4ZVhmbFNFU3ZsZituRTFqM3hVZGhzZEU5ZHI5Q0c5N2s3?=
 =?utf-8?B?NThBbW5FeU96MkVML1pJS21KZ01oYVhqOHZFZytDdW1LUGlkdW01YlUyRmF0?=
 =?utf-8?B?Z3hBRUsxblJjZk9WSXI1cVJiVEYzMnN2bTRhYzh5c0F5MDdOdUNsZHZMVm9R?=
 =?utf-8?B?c3lJU2RqVmRoV1FQZHJwK3FjWSs4WE5iTXJGN2dyS3VEMER3SmJsTHZYU2Zr?=
 =?utf-8?B?SmJHY0RMaytzUGFZLytDN0xUWm9QbWpac25Lem5qQlk3RTNERkRGR21Yc0F6?=
 =?utf-8?B?bUJCR2ltWVVXcFZkaFJkYXBhenhSbkh6RDI4ZUhaSjJzbHM2VU9WNDNwZ0tK?=
 =?utf-8?B?ak9iRVhkYmlPOVpkNWhHOEljYlB2UGtwRHBjOURWakY5WmxoQ0tMNFY2bGxq?=
 =?utf-8?B?RCs3YUd2SmdIaVNFakJLWXdhOERVZTMxZElTeWQwVklYc1ZpWE1XQ0V1OHJC?=
 =?utf-8?B?ak0yR0dFY3h4Qm9rc1pQR2UzRDREN2J6NFBWUUdualpXMVZyaW94M0YwWXBX?=
 =?utf-8?B?QVlzdFFaWEE3Z2RtY05pRmpWSk10T0xrNFlRWVhnNjhkb0dGcVh1bmpVT00z?=
 =?utf-8?B?elhXVW5oOXhEVlJITDE2WlliN0I4czY2cm1WT000SnI0K3Vpdjd3Z2lSNjAx?=
 =?utf-8?B?RXdkRWsrcnV0cGp3cVdiYXhVS0R0b081R2JqNFJkMUUrVmhJUnBvOWtEaXkz?=
 =?utf-8?B?aW5udERleiswQ2dibUVEWHY4Y3NwRGd6dDkxZ2g1cnV6dDNtbElZcFE4VHp2?=
 =?utf-8?B?ZVEwRWpuOHJudTJ3QVZuUTJzVmNxWUh3KzNoU2RObkdyTnJRa1dKOHJuckV6?=
 =?utf-8?B?QnFtYW00UlUzWWp3RHVTbSt0WU1SNElXWGdKQkEvYXVqcFB6SzU3dkNiTnp1?=
 =?utf-8?B?djZ0Z0ZrdDNGdnByd01KczdnSytPMXFIK1RvU1EwNjdQMkF6bmd3dEwrZmJC?=
 =?utf-8?B?cTQxYWJHTVJTcHBnbmJGcjBrWWtQNHZMbllCZm4yUFhqVi9rSUdXZG5rWXlV?=
 =?utf-8?B?c0xqL1JzMXpPZ2svaDhyczRZdTZSRnBhRWZsVVBxYjFjTmhyTHNUL1Flekk2?=
 =?utf-8?B?cEZBVDdVVFREakhuRnBuTHd2djh2WmpZbmhqNXR1Nm9RUUpjU1dWV0VNbHVw?=
 =?utf-8?B?RTdBbUVkcWZlUHlPcDlLanNXRkRqdkZ6ZkNkQXN2ZnF6cXp4bVVuQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 570769db-7613-4096-8e13-08da44252fcc
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2022 23:19:33.3853 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lbjPdm+SLdDDisBcflYrFhCtoCpzG1INCT4M2cFmlVwkgi/fxTFkFER6PCwyKe1/bJrK61dYbfrFCoE3nL6b6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5931
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
Cc: christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 2022-06-01 um 19:12 schrieb Philip Yang:
> Update PDEs, PTEs don't need flush TLB after updating mapping, this will
> remove the unnecessary TLB flush to reduce map to GPUs time.

This description is unclear. I think what this change does is, flush 
TLBs when existing PDEs are updated (because a PTB or PDB moved). But it 
avoids unnecessary TLB flushes when new PDBs or PTBs are added to the 
page table, which commonly happens when memory is mapped for the first time.

Regards,
   Felix


>
> Suggested-by: Christian König <christian.koenig@amd.com>
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index 9596c22fded6..8cdfd09fd70d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -755,6 +755,10 @@ int amdgpu_vm_update_pdes(struct amdgpu_device *adev,
>   		goto error;
>   
>   	list_for_each_entry(entry, &vm->relocated, vm_status) {
> +		/* vm_flush_needed after updating moved PDEs */
> +		if (entry->moved)
> +			atomic64_inc(&vm->tlb_seq);
> +
>   		r = amdgpu_vm_pde_update(&params, entry);
>   		if (r)
>   			goto error;
> @@ -764,9 +768,6 @@ int amdgpu_vm_update_pdes(struct amdgpu_device *adev,
>   	if (r)
>   		goto error;
>   
> -	/* vm_flush_needed after updating PDEs */
> -	atomic64_inc(&vm->tlb_seq);
> -
>   	while (!list_empty(&vm->relocated)) {
>   		entry = list_first_entry(&vm->relocated,
>   					 struct amdgpu_vm_bo_base,
