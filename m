Return-Path: <SRS0=vd7l=OL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F027C433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Sep 2021 02:20:30 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4936D611ED
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Sep 2021 02:20:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4936D611ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7FFC06E8DB;
	Tue, 21 Sep 2021 02:20:29 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2088.outbound.protection.outlook.com [40.107.102.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 228606E8DB
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Sep 2021 02:20:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IyvUEAzp6KLflY0CngyUu/iWlDzbnTSTKrkjqrlPJaWvmKWmDe7ftUqDhjANzzCYim/k/6qS+1Nm/StKeyS1NIwkA2Dq0AGx3185L3xWTpHbNMT+6zq1d3kBTXYvPMy12FGvw0OOhdp5E5lc4qgeA+w2stoZSCvszegruSQEdpcHf0S3Ee73XpsuJ4aCKN+gp40L7NZofqgi36QOtXTegplUD0g4uCLwwGp+0Hy9ay63tpyIgGlDN59TgWhVU0pAI3QJffGWhbD5o9PVxRHbYdCZMAaffHknApfdBPM96I/8U5e0cOVXD5znMV/ON5jvkz/c+6ORrplhvci7/lge+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=J3qUVlxMMPWLOL8yUxikaqnqSvn5ox3sIjnVRlD/ey0=;
 b=bwubc9UvUQJ7nO0QeMqnJtm2KRl1osWljC7+jAv3V8pzG+F6SeIMpoJcOpbYfUoKeJbgTBEpEv7idOFom4S+qWKzmr0n2r3qFHcgy9C0BQxzKoD2xtzlYTkzWyLR549NaVSvmEgCf4YAUaNw/hAWBJhL9GugCrkwahglI2PLEGXecFewKkTS7lqRArketixUsPbXm1tZeLfQBYompWM7CzP16Y/UjNU1B72lXWWFoR4tOfjltZlfoP5nJ7MjLsLqdjL/bVbVKz4y+URz7NBxjNvnC/YeXfv5Vn0p971jM4ZtbXBNNGpFWfsReWhyCsiaJzhzeg289Yp2LOJ8Pg7XSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J3qUVlxMMPWLOL8yUxikaqnqSvn5ox3sIjnVRlD/ey0=;
 b=cdyluOHHKzgU1vUK09JGTGjbDMEpVCY/5I7oa5qcWGXbHk1NNlAbSissCwj87yZfwf5NyoRWzpBEOtog/5zAcZlQqYqlrWCN1vQagd5Qaa5u1WWWd/Ktzm/TQuPRhfe1jaaviVuJYfAaRvxzQeUUgoxnAOWZFDH4qmdI2ESntCI=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5129.namprd12.prod.outlook.com (2603:10b6:408:136::12)
 by BN9PR12MB5259.namprd12.prod.outlook.com (2603:10b6:408:100::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Tue, 21 Sep
 2021 02:20:27 +0000
Received: from BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::94bc:6146:87a:9f3c]) by BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::94bc:6146:87a:9f3c%5]) with mapi id 15.20.4523.018; Tue, 21 Sep 2021
 02:20:27 +0000
Subject: Re: [PATCH] drm/amdkfd: fix svm_migrate_fini warning
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210920215532.26132-1-Philip.Yang@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <64c57694-ac14-5fa8-2424-b325b6e1229c@amd.com>
Date: Mon, 20 Sep 2021 22:20:25 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <20210920215532.26132-1-Philip.Yang@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: YTXPR0101CA0032.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::45) To BN9PR12MB5129.namprd12.prod.outlook.com
 (2603:10b6:408:136::12)
MIME-Version: 1.0
Received: from [192.168.2.100] (142.122.119.142) by
 YTXPR0101CA0032.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::45) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4523.14 via Frontend Transport; Tue, 21 Sep 2021 02:20:27 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9c44a7b0-0e14-49c1-1beb-08d97ca6604e
X-MS-TrafficTypeDiagnostic: BN9PR12MB5259:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN9PR12MB52592F817A96ACA02241DA0C92A19@BN9PR12MB5259.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3173;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +5zHboB/wKAsew3+KVSOGznmAfhNIUg2iEWRSAQlRot+myYnmsqszs5nGdk2gxDsHGsNcgBNwZSrwgy+03mlG/gOY4pNKlYxiwXCaWVNkDoHOLfXHbTXGOh6awEWiEHVXfTEU64UqOUowPAw0QWIGpR+RQNEgo7oPhs0d1rjik+Ah/N7XZtyscfBYbi4hIkTBSMV9cU8PqJtDeOhUjsX19z/7WjnaQn1sbN9oCsTOPzcSp1F5BR0mKIorD782ITTO4Bsx/iEK97jErBFY8eAheoXM7v1Ms3dLhSJEUqueVZUwfnEtQlcms2D0bPPbWfYWNSYY33vBVUSNzmrlmlTU/QJz00ptulxR/gOlMSj8ZiHutA0LN3A5N4F5Ef58dBIyWzSrhy6Rt+x/0XJ0gQ6XdzeQE/r3KdslvKPVL96COpJmx5qbmNNfnQz20Iu9jWOmOjXqK6AKGL1+AgbWALg4oMhwnJBtfTdW1KqHm13EvQJ3oWUtLT7BEQVMBwq6C3n+M8IpKKmIauymA4b9k+yRrqqZ9ozwRNle2bTDi5CGCFqsmlxIET+abQZpSnbn2NREjmmrgzr1+zApbcqShjZcjdaYeibrSvktzz02fX4R0KgduSuQNDFd0OUTYQTGCgJqJJbert0sjeZ0j6NiC/HWUX7tlcEcHswr5UY9SOYRA+YpPW//upkpjcXo2Jifbu/O9WBwVtAZl8hf/+vB0qqTQSWw+PMp2KTkHLotQm6pGXEb9MaKMrhvcmrolGsguwt
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5129.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(346002)(366004)(376002)(39860400002)(136003)(38100700002)(86362001)(31696002)(44832011)(83380400001)(956004)(2906002)(66946007)(2616005)(6486002)(26005)(31686004)(8676002)(8936002)(16576012)(478600001)(66476007)(66556008)(316002)(186003)(36756003)(5660300002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aFNlVkp3ekRLaWdZZXJYS1ZQMklYSjRBTTUyZ2dCZCtUZ1JtbjJUS3BUK3Nj?=
 =?utf-8?B?MEtHTDlmREJWcGUwR3I1VW5wTDJ2Vm5MRVRndFBMOUZsL2hwSnBmVmhKUlpV?=
 =?utf-8?B?SWlVbExWcWhnaWNqbStQOGxHbnFYeWRtRUNpbHNlUkxBUnY3aTJsUkFWMDZ3?=
 =?utf-8?B?N0JJNnE0N1FDN2RqQk1rS2J4WjRhRklxZDdDMlpNbSswRzlqVTZDL2VteGRn?=
 =?utf-8?B?WXJVWS85UmFwV0N4eXhJdUVSbkN3Nmh1Rk1FNGlHOGhaSFdjZ3p4KzJiM2JS?=
 =?utf-8?B?dlFydHQ0S1hIRWJlK3htYk9NWXZDUmJMQXZBbnRHNkw4QnBCUHpVU2FseXNL?=
 =?utf-8?B?Wk1yZkZsZFBZM0MrTVNKRHhPbVRUOUtucWtlemE3NWprcHNHSWRjbEVBUlNI?=
 =?utf-8?B?aUQ3WHJ5Nmg4MEhaSFBEK0F5YzNrdWlUZTQrTkc5VHA1NTFMMlZ0SU9hYzlN?=
 =?utf-8?B?WjNRV0lFUmJqNVp1UXNPWHFzSFpXTWNaakRYb0xocHppdVBvSkVETG5nNGJE?=
 =?utf-8?B?bFlXcHR3VGlZclNlT2h6VzU3aWJORXF6NDFYMFo3MHgwdC9BMDFUamx5MWFw?=
 =?utf-8?B?dzU3WHVIZVppdWVoeWJCY3Q2bHpOcTc5K1FNNlBJZUVzazI3aEdhb0xvVC9u?=
 =?utf-8?B?enRMYkFoZ3J6cnpxTDd1dTM1MWdMejFvQjlGVFNKclNDV3d4c1JoN3gzWGwz?=
 =?utf-8?B?bVZCSGpLeEQzbVBmemFBZWlHV3ZIN0tQdnZUUGYzUFBZSktGMG16dU1aNmtB?=
 =?utf-8?B?UkFkSjNWSWU0aWdHdHQ4djVRRVRUMDBEbEZmSjEwdWxZcHMvL01kbEFNaWps?=
 =?utf-8?B?cU5wTGNjWG9rb1FWMUFIRnFxeWdmQ0hrTFhITUZsdHpTcEpabHIzd2Z1a2pp?=
 =?utf-8?B?a3NTSzMyQ29OZGJwSW8rcVQ4N0YxK1VnQmp0NWQwb09tNGlBcCtFY1FCOC8r?=
 =?utf-8?B?VE5CLzF5Z0tOU29sNElid1ZabzllcVVGZTZwZHVvZUdJOFQ0Z2luUDMzK21V?=
 =?utf-8?B?Q2JPWm5neHBKTzRrekdZclVnaDQ1ZjlEcEdIWDNrUVRmcHV0OWJML1VKU09j?=
 =?utf-8?B?NTV4aFFBN3VHNkNVZjAwWEFSWDhrMzBJeHNhU1hYNTJSeUFwRnB2Z1FsZU1w?=
 =?utf-8?B?QStibDFqMGd2NVg3ekkveEV1L1dORlg1cHRHZnBJV2tLTTBnVHdBV1pwMEFr?=
 =?utf-8?B?Q2FtNURnYW0wdWpTRUtIUlAvbGVhQlpnVTdjbmFWak8xVkZwMVRmZWU3czBq?=
 =?utf-8?B?a0tjc0dIRjdoZjIwYURBTVRwbXVvOTIrWGhtSWozYXZ2SjcxRjZNazlQY0dW?=
 =?utf-8?B?STFxMlJZdFo3akpNODZpcjJVZkVOZCtzejR6MlY4ZHB3ekNRQzhGRGkrczZD?=
 =?utf-8?B?MUZTaXowZnU5UkpkdEFrM0VMS0oxMU43eXBkREdEczVGSjBLMDBDOXpSZTB0?=
 =?utf-8?B?Mk5rcDRHU3lDdi85WE1OZy91S0U4M1MzeVozS0RWdGhWeWxHbUZOL2VlZUNM?=
 =?utf-8?B?N2lEN0ZWMzErMENScHhzcUpHc1AycURHR0VtOU5GZlcxN0NVVFBJWEhGcVNP?=
 =?utf-8?B?eU5xRG0yTDRCVisvbnVIVUFKRGFEVmJMR2NKcmwwRUJPckJHSDJPZ01RRUQy?=
 =?utf-8?B?NjJJY0xZSDJrb2tYS2xUdHp5a0d4WFFneE9BcFhzQ0Y0TWJVTUZnMDM1SkVH?=
 =?utf-8?B?N1pOeHRGVW5jU00xZVdJbmlTM3Qwa0RLT2ZrS29QcnY4OHRCWlh2NjdyUzJ3?=
 =?utf-8?Q?iUrmP0GLR3t6UijJdYBO9D9lBy6NysJSMLj3II2?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c44a7b0-0e14-49c1-1beb-08d97ca6604e
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5129.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2021 02:20:27.2828 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gfI8Yr4joyKde5ln4AxvcZfTStnc4NmalXm+Bi0Q1PLY69t/Sw3Wo9QeG555Pro0f4Py5413zudNXExRgrq0JA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5259
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


Am 2021-09-20 um 5:55 p.m. schrieb Philip Yang:
> Don't use devm_request_free_mem_region to alloc VRAM region for pgmap,
devm_... refers to a device manager that automatically releases
device-specific resources when a driver disconnects from a device. So
maybe that just means, our devm_memunmap_pages and
devm_release_mem_region calls in svm_migrate_fini are redundant, and the
best solution is to remove those calls.

See Documentation/driver-api/driver-model/devres.rst

Regards,
  Felix


> because driver__detach releases all device resource region, then calls
> amdgpu_device_fini_sw, which calls devm_memunmap_pages generating below
> warning trace:
>
> WARNING: CPU: 1 PID: 3646 at drivers/base/devres.c:795
> devm_release_action+0x51/0x60
> Call Trace:
>     ? memunmap_pages+0x360/0x360
>     svm_migrate_fini+0x2d/0x60 [amdgpu]
>     kgd2kfd_device_exit+0x23/0xa0 [amdgpu]
>     amdgpu_amdkfd_device_fini_sw+0x1d/0x30 [amdgpu]
>     amdgpu_device_fini_sw+0x45/0x290 [amdgpu]
>     amdgpu_driver_release_kms+0x12/0x30 [amdgpu]
>     drm_dev_release+0x20/0x40 [drm]
>     release_nodes+0x196/0x1e0
>     device_release_driver_internal+0x104/0x1d0
>     driver_detach+0x47/0x90
>     bus_remove_driver+0x7a/0xd0
>     pci_unregister_driver+0x3d/0x90
>     amdgpu_exit+0x11/0x20 [amdgpu]
> Trying to free nonexistent resource <000007fc00000000-000007fdffffffff>
>
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> index 21f745e0b86c..aa96767920a9 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> @@ -880,7 +880,7 @@ int svm_migrate_init(struct amdgpu_device *adev)
>  	 * should remove reserved size
>  	 */
>  	size = ALIGN(adev->gmc.real_vram_size, 2ULL << 20);
> -	res = devm_request_free_mem_region(adev->dev, &iomem_resource, size);
> +	res = request_free_mem_region(&iomem_resource, size, "amdgpu_vram");
>  	if (IS_ERR(res))
>  		return -ENOMEM;
>  
> @@ -891,14 +891,13 @@ int svm_migrate_init(struct amdgpu_device *adev)
>  	pgmap->ops = &svm_migrate_pgmap_ops;
>  	pgmap->owner = SVM_ADEV_PGMAP_OWNER(adev);
>  	pgmap->flags = MIGRATE_VMA_SELECT_DEVICE_PRIVATE;
> -	r = devm_memremap_pages(adev->dev, pgmap);
> +	r = memremap_pages(pgmap, dev_to_node(adev->dev));
>  	if (IS_ERR(r)) {
>  		pr_err("failed to register HMM device memory\n");
>  
>  		/* Disable SVM support capability */
>  		pgmap->type = 0;
> -		devm_release_mem_region(adev->dev, res->start,
> -					res->end - res->start + 1);
> +		release_mem_region(res->start, res->end - res->start + 1);
>  		return PTR_ERR(r);
>  	}
>  
> @@ -919,7 +918,7 @@ void svm_migrate_fini(struct amdgpu_device *adev)
>  	if (!KFD_IS_SVM_API_SUPPORTED(adev->kfd.dev))
>  		return;
>  
> -	devm_memunmap_pages(adev->dev, pgmap);
> -	devm_release_mem_region(adev->dev, pgmap->range.start,
> -				pgmap->range.end - pgmap->range.start + 1);
> +	memunmap_pages(pgmap);
> +	release_mem_region(pgmap->range.start,
> +			   pgmap->range.end - pgmap->range.start + 1);
>  }
