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
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAE96C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Sep 2021 14:06:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 827A86058D
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Sep 2021 14:06:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 827A86058D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2EBF589C14;
	Tue, 21 Sep 2021 14:06:49 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2048.outbound.protection.outlook.com [40.107.92.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 399A989C14
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Sep 2021 14:06:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O+AmI0cDtTNI53v1zvfBunlqlDei4+yQUuy3tj3woTTg8Y2sp2FdZU0czpgLh3ELR7Wfqa2PPt9Z4cV3dzoHhk1vm6GzUC0aVpxLP07oqbnvOvUZEXxreu4aKeOTTqVJSG2rXE9WNykaAfIVpE9/vBbzTo2Oa336Vagdb1rvm40pMfRH1MElqdGSVxvi58w6QByiF2/3QuKun2vdzx4z9xISbSW8kyQiz3wdJBBdEQRk9GhptHRdmZSzZ0s5BhuaerCCEKxjwlUieCsV7Nk/pqCCInudslgZAH/YUIPP7OxRuD2DHwV9rQCWoloA06vnP0blqsxXcrOFnrRwYmvUNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=hjHXE+LpJsVWQnR0b3WQEOTte1wRNb6+EQG0wt1XGVc=;
 b=VJ83vYePEKFcT2y2UZce7Q9l/Lk1aq/Tdi0hsBot9ywPY/d7FnbWsK47fts87bAkPJuo/1aExPGD/8Y9BOOpvqFVMhY53EKjiuNy1y85F13U+eipsOS0kgeqciFFy9ibUJeEP/UmquocZWXc87Q80j6s+N9GYyKGB7Z0g0gHbWGZ7SRL1ycpU1+1eUouQjjmuCQS8XqOkij039b+zG5rSvtnHRMdevk83tsR1PUPice94kgQN8DVncAd927wJ9j7vQ1ycYqzm9CjOmaSA/+iSHyYAi38ZHYYkZLdzj+4kbBUsmYHxguLnA5yakgZ4SJtzzNiThmRT3QRtb6xOSmOGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hjHXE+LpJsVWQnR0b3WQEOTte1wRNb6+EQG0wt1XGVc=;
 b=YOzxjcfnk7/FYb2Wg7JIf4EoK+8KztSSbYXALcR5HP3kyK45M2+egLeqA8JCLbQdMYGjmlQzqUSUOEnZvcewOG4KRi+C++xe0BQH/7cezjITutmfP9LPB6QmL88Qs8THPntbNRbCuOFlRTkoxWkexTwDWI8gt1cuYx5JqTYtJ10=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1947.namprd12.prod.outlook.com (2603:10b6:3:111::23)
 by DM6PR12MB4298.namprd12.prod.outlook.com (2603:10b6:5:21e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13; Tue, 21 Sep
 2021 14:06:45 +0000
Received: from DM5PR12MB1947.namprd12.prod.outlook.com
 ([fe80::3153:3d7b:e216:74c0]) by DM5PR12MB1947.namprd12.prod.outlook.com
 ([fe80::3153:3d7b:e216:74c0%11]) with mapi id 15.20.4523.018; Tue, 21 Sep
 2021 14:06:44 +0000
Subject: Re: [PATCH] drm/amdkfd: fix svm_migrate_fini warning
To: Felix Kuehling <felix.kuehling@amd.com>, Philip Yang
 <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210920215532.26132-1-Philip.Yang@amd.com>
 <64c57694-ac14-5fa8-2424-b325b6e1229c@amd.com>
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Message-ID: <4326da04-cb8c-b4d8-02cd-c13f19e86341@amd.com>
Date: Tue, 21 Sep 2021 10:06:42 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <64c57694-ac14-5fa8-2424-b325b6e1229c@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: YTXPR0101CA0010.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::23) To DM5PR12MB1947.namprd12.prod.outlook.com
 (2603:10b6:3:111::23)
MIME-Version: 1.0
Received: from [IPv6:2607:fea8:3edf:49b0:591f:ecc8:119a:23e7]
 (2607:fea8:3edf:49b0:591f:ecc8:119a:23e7) by
 YTXPR0101CA0010.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4544.13 via Frontend Transport; Tue, 21 Sep 2021 14:06:44 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d5acc51e-dd6f-4cb5-62fc-08d97d090b2f
X-MS-TrafficTypeDiagnostic: DM6PR12MB4298:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4298BFA5979F6F0B96644E38EAA19@DM6PR12MB4298.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I+lebCNNyxbMmOBP1ONwMuZ9k7409kdkk9kAayPM2mWAlKwEIWmcQGBUuU78ZV2j4fB1W1OebC+FgXdldq3ph+pgIVtX8V94Dso61Dp7/uqPhZqEKflXFN0eSod1EHdSmPd3rGtOmutZuaF1XtoLs7N1jZTQxHKvCi6Rgi/PDyjgaKaBG0qC0B6WegdUyVGKsEIheAbpiQiUpOrDVt/odZmhS7Fs6HlMe+WOJDLmlVSbo+WKxPG2fyUb173TXBsKK1xs9EboLeHgkU54tsIEbv4iR+xGGgmVq0eDwZqqmmS3tfo0UkOcDAvmVzC2qfkiWkFY4nzlByiSa8B3ULszRx0hD0EyzJZGaqOZefhJeNrRpDI4sl6YZigdq1/0CiJKELe4ZSIYljrd6T9gEHNcthvaE4mCM1sl3MkbwHGtHxEV1KLxKatAyN1Z7wPpgDBl0IH/G3oq2SJrN8MbdiheIcuZUdHhNiHY+nBYF9bWo/tH4hrYPTGCi89bddLqZHwGbm+lcjNKow7BDMcXm0yOuI17m3BsbtSRqWkkdcbybsnZ9Ze60YqvjwUDOx9m7cI6eWBwC+VR1Y7MDsRxoHNnvxMPsD7SjdeReHW1Nx4GsIV+BMXGejKya2RjUmKnrY8FmCeaUWf7ZKUqLsbq0k7klNp6XcVNFvo9uHp4pW32EcXQct2FPWXXRekg3ylrBSrFoOQSwjmO3zhYVD9R5OoU9KxugXIR5rso4sCKX/KgKdU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1947.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(508600001)(6486002)(186003)(38100700002)(44832011)(966005)(83380400001)(53546011)(2616005)(66946007)(8676002)(31686004)(8936002)(31696002)(316002)(5660300002)(66556008)(66476007)(86362001)(2906002)(36756003)(110136005)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T0svUDdsUE9mclR6RXl2Nk5ReU5xenZrbzBSVlplM2dIY1RQUEFrTFhTWkRj?=
 =?utf-8?B?bXBYTUVlWHZpQ2xiRTBzTGErWEIwV0NpM1FKdWNWcjk4bnRqbHozL2tQc2lr?=
 =?utf-8?B?bUJBbHZsYWJyM3VwNzhHZjNuemdTdXBFbkdjTVg2cVpiT0k1bFF1d2FwbHRk?=
 =?utf-8?B?ZTV1NmEwakorVU1GZG9pTGZtMy80UUsyemQ4Y1hqZjZaNWFSUTNYMGZsZEhB?=
 =?utf-8?B?cXpPbGsrQzFUenVUNnB5OFd6bUtsWTRGV2d6UCtZYnhhL2NEYnd0dnBvdHBa?=
 =?utf-8?B?c3dtb25uWkQwNDBEZnRZR1lhSEMvNE9kWVFOTWV2TGFGK096cllmSmtmZnM1?=
 =?utf-8?B?SU9tTmw2R2R2eDA1RUVsTTdkclcxRTZZMnozc1lWMWtCV3FaQitBOWxWTDRu?=
 =?utf-8?B?NnZjZ1ZrK01SLy9iTU9tVG9PMFI5WXUrVXJ1aDR1UW0ySlMwRmFLU0VWR0hB?=
 =?utf-8?B?N2RBUkh2eElOSHhORUNLV2dreW9FR1dJWHpQOTZPeXJwS0JwTXU1ZCtZWUU4?=
 =?utf-8?B?WWE1UkFTRGpEMzAxcGdhQzJVbzRpa0g0MXBrVzkxalRRbW85T01tRlN3Wk5k?=
 =?utf-8?B?TmNwbG9xM0gxUmpOSkZCT0NMVVd6K3ZvRTNnbUMvTGZmWnpFQ0dTWlkzRUhR?=
 =?utf-8?B?UEI3VUZ6WE5kalRUQ3FtaTJuVDlhSjZlOFhvVGxLMGthamMwOUJXemZscEwy?=
 =?utf-8?B?SVRVREt1NFJYaSsra0E0WFFoMjZJQUdBOHg5ekIxZ1Z6WUtTbDBuVmpyaU1h?=
 =?utf-8?B?N095azNOS1BieXZDcFlYb3ZtTkoxMzlacm41UVEwVy9IQmE5eFlDTDJRdHZQ?=
 =?utf-8?B?UmRiVzhBVnVyQzBXc1lKNjN0WWxxQlN2MHFCOEtXcGtmVElNTEErRmxaV2Iz?=
 =?utf-8?B?RmpVWU5qbTVwRG9kQlhJL0pMZFdhTWMyNEI4WGZZdTNXS1hXMk45bGEyTHF1?=
 =?utf-8?B?SHo4ZTZhYktrT3c2QWN0bFRKNkxZUy9WaDFTR2dEZk5zR05YS0FWaDA2Q0Ra?=
 =?utf-8?B?YzU3QXR1Mnk4T3VtdWVJVThMUmtKUkpOUmhKSWxvYVNxOHlNbm9yc0R5TGxm?=
 =?utf-8?B?RHExRW9IcURVV3VsMCs5aWFXdk5CSmU2TGU5ZjMvWlFPTWpQZXp0eGJqdTJT?=
 =?utf-8?B?azRKUGpjUGVzVFRoMnJ4aFF1ODhRNzVNa0dxMkhQcFV2VzdmcElQQkFxNktV?=
 =?utf-8?B?aG83bEE2MmxFVzhpZVRhV3AzT3ZBTHFUWGNtcS95VUxQVDZyaWx4dkZ5b05p?=
 =?utf-8?B?UzY1RGVvdElDdzhXL2pIOTRVaWVTeWw4RlZPRGI2K3YyemJmdEIzVkNqMmha?=
 =?utf-8?B?NFpIZ3FtQkRYdTZuYW5OdDBvbTRFMy93R01iZ3NZVDVJK3pXOGNId3AxNFg1?=
 =?utf-8?B?dTZ5Zi9UUnRmcW1QcTJET3RzSjNDVzFoVTRzOWlJVFd1cGFRNit1Sm9EejAz?=
 =?utf-8?B?Q1FhVWpmWExMRmZpcXZLYmN5clllbEpMcG83V01WajNmemdyN0VmTmFnNUNS?=
 =?utf-8?B?d1lPeUJ1cGdJRmtSdEMxbzNlaDdnZWVlbmlMOWUxRVBHZXlpVEtQUlBjc0tX?=
 =?utf-8?B?M1doSHlBWDFnUnM0ZjNxeUluOXNJanIrTTZzQ3dpWEZwNlVPVTRqSlFTV1hY?=
 =?utf-8?B?Vmh2U0FZc3A5cUdFWkNTSVhDWDJ6WFNCRVM0YVlVSXNRZUJ6OWp4VU8zQ282?=
 =?utf-8?B?T2dWV1dsTHp3NTBFcnJlQzhDQkhvQlhLNU1aRjRCRTU0MFF2MGZOTnB2MGlI?=
 =?utf-8?B?OStxMHRuYU9seC84UzNaOXNWVzlEMGNVT1AyUFVoQmtEUVBtVmtQci9aWjdR?=
 =?utf-8?B?MFlkRVVIQnZwN09Gb2xhcFV2eVNlZ016ZWZPTWhRRCt4amlET1BGWDE2ajN5?=
 =?utf-8?Q?bwK+H7m+rOjKl?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5acc51e-dd6f-4cb5-62fc-08d97d090b2f
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1947.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2021 14:06:44.7887 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RnRgNLox7xdZcEr0WgDKZa5vWcrK5VKdBafk1EsKDaX2DIiqZZT/rGLgUV6Iph6h/NeDDQtieEZLCcLt41iP8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4298
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

In any case, once you converge on solution please include
the relevant ticket in the commit description  -

https://gitlab.freedesktop.org/drm/amd/-/issues/1718

Andrey

On 2021-09-20 10:20 p.m., Felix Kuehling wrote:
> Am 2021-09-20 um 5:55 p.m. schrieb Philip Yang:
>> Don't use devm_request_free_mem_region to alloc VRAM region for pgmap,
> devm_... refers to a device manager that automatically releases
> device-specific resources when a driver disconnects from a device. So
> maybe that just means, our devm_memunmap_pages and
> devm_release_mem_region calls in svm_migrate_fini are redundant, and the
> best solution is to remove those calls.
>
> See Documentation/driver-api/driver-model/devres.rst
>
> Regards,
>    Felix
>
>
>> because driver__detach releases all device resource region, then calls
>> amdgpu_device_fini_sw, which calls devm_memunmap_pages generating below
>> warning trace:
>>
>> WARNING: CPU: 1 PID: 3646 at drivers/base/devres.c:795
>> devm_release_action+0x51/0x60
>> Call Trace:
>>      ? memunmap_pages+0x360/0x360
>>      svm_migrate_fini+0x2d/0x60 [amdgpu]
>>      kgd2kfd_device_exit+0x23/0xa0 [amdgpu]
>>      amdgpu_amdkfd_device_fini_sw+0x1d/0x30 [amdgpu]
>>      amdgpu_device_fini_sw+0x45/0x290 [amdgpu]
>>      amdgpu_driver_release_kms+0x12/0x30 [amdgpu]
>>      drm_dev_release+0x20/0x40 [drm]
>>      release_nodes+0x196/0x1e0
>>      device_release_driver_internal+0x104/0x1d0
>>      driver_detach+0x47/0x90
>>      bus_remove_driver+0x7a/0xd0
>>      pci_unregister_driver+0x3d/0x90
>>      amdgpu_exit+0x11/0x20 [amdgpu]
>> Trying to free nonexistent resource <000007fc00000000-000007fdffffffff>
>>
>> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 13 ++++++-------
>>   1 file changed, 6 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
>> index 21f745e0b86c..aa96767920a9 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
>> @@ -880,7 +880,7 @@ int svm_migrate_init(struct amdgpu_device *adev)
>>   	 * should remove reserved size
>>   	 */
>>   	size = ALIGN(adev->gmc.real_vram_size, 2ULL << 20);
>> -	res = devm_request_free_mem_region(adev->dev, &iomem_resource, size);
>> +	res = request_free_mem_region(&iomem_resource, size, "amdgpu_vram");
>>   	if (IS_ERR(res))
>>   		return -ENOMEM;
>>   
>> @@ -891,14 +891,13 @@ int svm_migrate_init(struct amdgpu_device *adev)
>>   	pgmap->ops = &svm_migrate_pgmap_ops;
>>   	pgmap->owner = SVM_ADEV_PGMAP_OWNER(adev);
>>   	pgmap->flags = MIGRATE_VMA_SELECT_DEVICE_PRIVATE;
>> -	r = devm_memremap_pages(adev->dev, pgmap);
>> +	r = memremap_pages(pgmap, dev_to_node(adev->dev));
>>   	if (IS_ERR(r)) {
>>   		pr_err("failed to register HMM device memory\n");
>>   
>>   		/* Disable SVM support capability */
>>   		pgmap->type = 0;
>> -		devm_release_mem_region(adev->dev, res->start,
>> -					res->end - res->start + 1);
>> +		release_mem_region(res->start, res->end - res->start + 1);
>>   		return PTR_ERR(r);
>>   	}
>>   
>> @@ -919,7 +918,7 @@ void svm_migrate_fini(struct amdgpu_device *adev)
>>   	if (!KFD_IS_SVM_API_SUPPORTED(adev->kfd.dev))
>>   		return;
>>   
>> -	devm_memunmap_pages(adev->dev, pgmap);
>> -	devm_release_mem_region(adev->dev, pgmap->range.start,
>> -				pgmap->range.end - pgmap->range.start + 1);
>> +	memunmap_pages(pgmap);
>> +	release_mem_region(pgmap->range.start,
>> +			   pgmap->range.end - pgmap->range.start + 1);
>>   }
