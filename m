Return-Path: <SRS0=K+jV=JX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A31B6C433B4
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Apr 2021 18:46:14 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4FC5160724
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Apr 2021 18:46:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FC5160724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B6FCE6E0D2;
	Mon, 26 Apr 2021 18:46:13 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2075.outbound.protection.outlook.com [40.107.237.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9B5536E0D2
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Apr 2021 18:46:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mno/GGjwfqQBr6+wPIFqf3dToEDinFA0ORjqPMBB4e9B0blX8gaszPixdm3AM4EUH5XoZSQ9GWhFcnuc2pwuQn3s29C9qrhjxF5BUFHUL/bhcxRcGQebiLUqFzqEnl/OAvCGmSiauwZ04C9k+iF7jF0wFANYRgkGxSMDqEKUcJl0CiWpu0mjJub5iLzcjBha65YSxxwjf20PnNpUZi96jK1i3z3e3vT2LeTcsFUO5O/j9OaMsndNuB571Ufz2QiB8FEE4YgMV1tBE52GV3so0wyv83HZLBap000+ASDFwFUGymlDAGHrJmlsZ+NgYhxDcgDR/SjAWRc4AvwXcjHLyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3tzKdVhbfI3dsjbWFc6LSWpMzbVAH6FeSh744NA9hw8=;
 b=kVirz6g1WwKi3GczGgvrrWVSonJMrxEKbqkyTiYjm/yI3/ps3Uf/rBmBhIdPnc++OBIgY/v+U17dSrvYKqjezia1I5Hw5+pH7YNDwu5LPDpIL8oTqbKTn3tsprcj1b9I/RujDXPVq3qRWK8JlO2GBdI7TqqPdkQxwy3+bEsTuaZ80pRR7meW8OU4sawrgfOBpcyJGzaKaextoA+7aMIb+20kgTJUjUWtkFbh8iRpOloRl/9OvezDI1J9hIs28aNj65mDRcjy9Ogc3h4WhtkrlVX2AFYczi5aXcVccyZvxyELxwZzBAAURpJaw82ZGDQbAu4YCJcT120lSu+dwLJcNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3tzKdVhbfI3dsjbWFc6LSWpMzbVAH6FeSh744NA9hw8=;
 b=YGajuEAnQBgBNnRKuirp+c7JgICUrurP4qHJtCykZGiXQEr/VMZvLjvdnqY4k/p8tZFxhypSGOWUenBJ7Tjj5AeDurPKWwdlPmWmYKw9JTMf/vUk7qSLP8aqpNo+o7A1WwpJ3VTWeHbG+rPNs2dkzRqij/DxL8DmcfnaXYuJ+NQ=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BL0PR12MB4948.namprd12.prod.outlook.com (2603:10b6:208:1cc::20)
 by MN2PR12MB4095.namprd12.prod.outlook.com (2603:10b6:208:1d1::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.22; Mon, 26 Apr
 2021 18:46:11 +0000
Received: from BL0PR12MB4948.namprd12.prod.outlook.com
 ([fe80::70f5:99ed:65a1:c033]) by BL0PR12MB4948.namprd12.prod.outlook.com
 ([fe80::70f5:99ed:65a1:c033%7]) with mapi id 15.20.3933.040; Mon, 26 Apr 2021
 18:46:11 +0000
Subject: Re: [PATCH] drm/amdkfd: fix double free device pgmap resource
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210426184104.4360-1-Philip.Yang@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <b63a2505-277d-0bf7-cf48-f441b07f847a@amd.com>
Date: Mon, 26 Apr 2021 14:46:09 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <20210426184104.4360-1-Philip.Yang@amd.com>
Content-Language: en-US
X-Originating-IP: [142.182.183.69]
X-ClientProxiedBy: YT1PR01CA0025.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::38)
 To BL0PR12MB4948.namprd12.prod.outlook.com
 (2603:10b6:208:1cc::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.182.183.69) by
 YT1PR01CA0025.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4065.25 via Frontend Transport; Mon, 26 Apr 2021 18:46:10 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 86556716-5f7f-4174-4d6a-08d908e38f85
X-MS-TrafficTypeDiagnostic: MN2PR12MB4095:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB40950FBBE293176C73C4A7B292429@MN2PR12MB4095.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:398;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PckZSiEmp/WkYjZvOK9WQleluHw6wZdKhUeY8gRrDTEtxwcKyVJ7GyKXMk238luiw/WK3iG8SnymGEAa6iE4jPcNifsaTw9R+CuDVqoICsbSecY8ISNIAj0O52ya5Mn1jXQCAEK+a4mrXuq22ilS1zRD70mibeBPOShC/vIxngOWwButoCZjAd4dZTXz3cd1l4hDUQkZM7iE6aAG2bVLRNU08Ewf+tyt0WnIwubVXBdZBU20s5vCcxeldiGBwFh5WnLJZ8mdaoxj3QcQd+JMY2X7q9pWHaEIRNFC5USlVtZ31MpkC+tF+M7th6RcAyU99cHfqccVQHoNY+pWHnD9U7gdB9+ODUA/MRLqdgDMYdvMAWINkRHWkM4vxjNaeE5wYJx+n59qtXA+ifeELN/tTbQz43m5gCS7z/irMg5zmYmzaB+QKKCvaF4dpkx34hdJqvLpKRo11kwxfk1ay/x0bJb3W/qpj5n+qVSGWW6ZM2Fw6m6JLlcdn5+N6Vb6bFZAWNXn7gCHEFghnbXqi3QTc3PMiWdRV9SiXY+dYZnKg62i1i5wJDCOEqKoI/vbGlIc2QfDYkxBbNh0zKGFx0R+1U4OAPGZspyuo6aLw2tnv5b1HricOcOeD44L5m+F0G2p65EQ1gSgQGZJoD84XDV/RH3AgWvaCV99ZUWLtxFemfavoCRmeQc4riZbdaNBkISe
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB4948.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(396003)(366004)(39860400002)(346002)(376002)(26005)(8936002)(2616005)(44832011)(8676002)(66556008)(16526019)(956004)(186003)(6486002)(83380400001)(36756003)(478600001)(5660300002)(16576012)(31696002)(86362001)(316002)(2906002)(66946007)(38100700002)(66476007)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?bmFXRmFOOC9JVXhXQjB2N3RzRkh2OWMyU2xhemxUT3RRL2xqV0NlcThOc0c3?=
 =?utf-8?B?YkR6TE9yWWIweklyd3hHNXBPUTJHNk9aKzhvcmx2UzJGV1VCUmJFaGttN1FO?=
 =?utf-8?B?M1RQbWpnVmZPMHlNRGlSV3hqeWNJSmVpZm1FRUIxcjkwMkJMbE5LWEZxQVUz?=
 =?utf-8?B?U1lTTzV5a0xNT3pHTnhIUW5vbDcwcUdEYWNtZll1VC9CRzJUUnE3QWhxWEFK?=
 =?utf-8?B?T2lDdWtiQ05HZlplaFQ1WVlFMHRNOFk3WHB2QTRFMkZPZCtxTXBIUU9WcW1r?=
 =?utf-8?B?Y1VMbklNcnlJQS9zcXZrVmpabCtnS1Jsemx4THBzZEJIWTd6SzBPeTQ1Y0Ft?=
 =?utf-8?B?R2hXQk9zUytFTEYvaU5pamhUVTJ0MDU1bDB6REFTUUdNQUlUSTBURHZ3ZVgy?=
 =?utf-8?B?TDN5NUdUK0NvUUFKTU9LbUZOKzZ5bldadFNlcWFPeXVQbEFxVHBCRzRQUEZB?=
 =?utf-8?B?dE9ZLzUzVjg4ejh3WEJhdUF2eTZ5K2hZRWd1b3AwWUVQOEVQNTEvbHJQaGt5?=
 =?utf-8?B?LzhJZkZIZnBpQ3MzYTR1emcyZzZRVnR4ajBBQ3IyY2pibWs1Y1Roa21ZdFZl?=
 =?utf-8?B?S21vYVhqbGgrZ2Q4WWp6ZG1Zd0wvMWYxK2IxcGdiZXZiZkJQRURrRkF3aHpr?=
 =?utf-8?B?NFg4Tm9aWXZKUXpSMlUyWUxCR0xsOVcrbWd2SEpwTk5KTXlmeGtNWlRGaXRy?=
 =?utf-8?B?a3NHblo3aGxYS1U3dFZBTFIwMFErNGptU012MDNsTjhrVm5mcGRjbmZkb0d3?=
 =?utf-8?B?Z3k3MStVeW9lNWJKMzhhWnpUWm4rMk8zUEVjL1F3SEtPcmRjb3FWdVdBcmhD?=
 =?utf-8?B?N0VUVkVqR2FxbXdxWnZhajJDSlF3VkNsZVVReDRldFV3WjRJMU91RUNvTnFx?=
 =?utf-8?B?bkZhaDhnRXFwM0thUmxlZzNpUEVLMjRYczRyYlcrNjRTNXlYdXNpL1NEZzMz?=
 =?utf-8?B?YmtpOEk2QzFzcHdkaTd0K3hVVVZIQ29uYThGYlJQQnM2ZkE4RGhXWHgrMzNa?=
 =?utf-8?B?ZUJ3NzMyY0c2VXU2b2x0S3lxZ014QmdJY2dKelRGNnIyTzFBSGpINmlXQk81?=
 =?utf-8?B?M3hKdnhJQTRUS0JtQmpRYURMbnZrM0JzQ1ZGRDZTdWRWZHZvaDlwMWM3cG90?=
 =?utf-8?B?SGtaVFVuMDNObEFmZnVNYUNvVzZOVTQ3Vm5UZjZFREw3RHUrZXRVVWFubHF1?=
 =?utf-8?B?azdSRklvMks5V1NaQ0VlOUlXdVk0dHVkbUV0SGJuNFFwMDVoNk5ERDJHT3U2?=
 =?utf-8?B?Mk8zK3p6UjNGYzh2eW8yVXo2eHozbkNGQW03aGhOenZSUENnRlUrTWN4SUlD?=
 =?utf-8?B?bWlFYjRRK3lsRXV1aFhyVUVJY2dsYTVaTVV5eWh3dWV6SDdSVTQ0VWRSbG5x?=
 =?utf-8?B?aTZtcHIza0RmRGQ5YjM3VmhpNjdJaFJOcnVTM3YzRTAxMnlXRGx6aXpUeE9a?=
 =?utf-8?B?bjkxZkpodnNDYzN6MXp1MGxPclNCdVl6RXBXcjczbmU3amNvMzdyS2lUZHlh?=
 =?utf-8?B?WkFVVkJXRGt0OEpsK2xIdnJ0YW51UGp4SGpabnlZRTlpQVoxL3l5eFFKN2ZI?=
 =?utf-8?B?RVpFME1Jb0h5aWRUbVJMdzZHY3JHSzdqOXRqclhOdE1Jd29hVEtFZWpOUnlU?=
 =?utf-8?B?aTFtZ0FKMUhwQjUxd1VqVU0xT2lsaWgwZytrZkd1V3UzTHFQZ2JKVkRRZnZT?=
 =?utf-8?B?OHJZZGM1YmE5OEF0L3VaY3ZKZWgwUFp0U2w3SFJVUTFjSXVnSFdlaEVXaXJH?=
 =?utf-8?Q?QG8uXChXrUei1AiPCSCK8hd3/WQBFCpcNEL9nA8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86556716-5f7f-4174-4d6a-08d908e38f85
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4948.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2021 18:46:10.9426 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3rD3d9xni6lA6u1+4HbKnswpj/HvMzPxyLuVm0JNI7Yg12hd2xx+33NGibB6HP8odhVkHU2i4YFdsvM+bZiAdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4095
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

Am 2021-04-26 um 2:41 p.m. schrieb Philip Yang:
> Use devm_memunmap_pages instead of memunmap_pages to release pgmap
> and remove pgmap from device action, to avoid double free pgmap when
> unloading driver module.
>
> Release device memory region if failed to create device memory pages
> structure.
>
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> index a66b67083d83..6b810863f6ba 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> @@ -912,6 +912,8 @@ int svm_migrate_init(struct amdgpu_device *adev)
>  	r = devm_memremap_pages(adev->dev, pgmap);
>  	if (IS_ERR(r)) {
>  		pr_err("failed to register HMM device memory\n");
> +		devm_release_mem_region(adev->dev, res->start,
> +					res->end - res->start + 1);
>  		return PTR_ERR(r);
>  	}
>  
> @@ -927,5 +929,9 @@ int svm_migrate_init(struct amdgpu_device *adev)
>  
>  void svm_migrate_fini(struct amdgpu_device *adev)
>  {
> -	memunmap_pages(&adev->kfd.dev->pgmap);
> +	struct dev_pagemap *pgmap = &adev->kfd.dev->pgmap;
> +
> +	devm_memunmap_pages(adev->dev, pgmap);
> +	devm_release_mem_region(adev->dev, pgmap->range.start,
> +				pgmap->range.end - pgmap->range.start + 1);
>  }
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
