Return-Path: <SRS0=/TO6=LI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31DD9C2B9F4
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Jun 2021 17:10:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0F9D61185
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Jun 2021 17:10:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0F9D61185
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 821F389C33;
	Mon, 14 Jun 2021 17:10:24 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2073.outbound.protection.outlook.com [40.107.220.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BAA6489C33
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Jun 2021 17:10:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A/5IA1BVmnoPcmHP5mubVcMSHrZsfm4kn7gKvOHHfJmUxmZ81qRSKMNRrlJC40kjYFgt5WkXKNMD4xKLZEalcT/kFlP0iRtQwL2Z7nKr94+/7fdw7v0M1Hpe5lY2YwHxLA5pYnKF9PFBPJLbB9AHhj4gpKC6rCoQsJYHawad+UNaRL1RMt3Ca/gWaPLiDHPnlUR5QUKUZ4MbZ6AwNROrLVNzYLL0j8+KAkaLvAOvcrVVQEIUYQM+NaYGL3V6vgH5QkcFtBkuyVgG0x+p/9ZlR4Q/qheDwAvshOsMTbe8u8hJUA0nhAjrcY2G53J8XdViVlASQ5P5auR8Cnz72BEgGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aQjd/ego1vIXP5UH0Q14YBV+h1NtdVFlnPOYtt1hqBE=;
 b=iPG5e+e6VLAb9CVjjMzWSYZgLeo+5UJU9CHNA2/H7G1yk3wFf4YHepFDIa9AqQ6vzQsLC0nkQmKD9FHsUwG+PT6X9nU/DkMGpLhbzfNnKxGpp6qJf1cm/CUtmB7Ht9vO3/tOeZjNI43BRYDhQQh+XU11CwCxKLDEYVKtfE3oyPYG40mYUWdxpKTbSx9sp2nyE/CreyHhsN9LJjPxN+8HfKCFVAdUBrBm2FjUnVutPUggWmayYyyUjiKCTNwNqPh9Nh9ml/R6nPPrr5vtcdqg9ea2M/i6KRuvlHWtraowNdf8WhZpp3gjv0a8anSAoMYBBj6zekKk5c5zeXsaqDEvcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aQjd/ego1vIXP5UH0Q14YBV+h1NtdVFlnPOYtt1hqBE=;
 b=CizOm/U6rAl7CsMPIk/RkxPwx6VgpV2WxQV/ivDBmzFCbp7XRdO2IjfDMRJfsnl68uT6xb28Z0qu3LCsadIu56cYrV2XpkAhch6nlmSB4FvAAIgS2ENrIXQ7rgjdMMKbxZDg5fUtPh4nhug0ZEs3qx4nqZ4xJBy4K+auk4NCW+o=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB4374.namprd12.prod.outlook.com (2603:10b6:208:266::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.20; Mon, 14 Jun
 2021 17:10:20 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::6c9e:1e08:7617:f756]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::6c9e:1e08:7617:f756%5]) with mapi id 15.20.4219.025; Mon, 14 Jun 2021
 17:10:20 +0000
Subject: Re: [PATCH 1/3] drm/amdgpu: parameterize ttm BO destroy callback
To: Nirmoy Das <nirmoy.das@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210614143217.10285-1-nirmoy.das@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <66eef795-40bf-49a0-d98e-9ec2724b5d25@amd.com>
Date: Mon, 14 Jun 2021 19:10:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
In-Reply-To: <20210614143217.10285-1-nirmoy.das@amd.com>
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:e8cf:b51d:4c59:9c81]
X-ClientProxiedBy: AM0PR03CA0070.eurprd03.prod.outlook.com (2603:10a6:208::47)
 To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:e8cf:b51d:4c59:9c81]
 (2a02:908:1252:fb60:e8cf:b51d:4c59:9c81) by
 AM0PR03CA0070.eurprd03.prod.outlook.com (2603:10a6:208::47) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4219.20 via Frontend Transport; Mon, 14 Jun 2021 17:10:19 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5b508fdc-ca04-41f6-add8-08d92f574a29
X-MS-TrafficTypeDiagnostic: MN2PR12MB4374:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB437431A991EC99E3E32562E883319@MN2PR12MB4374.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: T8JkLR+i/wwna7jNnbFPk/NZwR7MCXv4c3L8NKCiIAYefpqOnJ8n7TuNg+xVRE1Mgc5PNdgEMo8MWTgPxegFVK8zztfmndIvUPJNAhIRM66hGeaT12CqLbySFXdI5oxoqc8Wie6im170k2ab9pKEK3vW8TPOD/ZbP0olg+1otLUfrqtY+5PaSX8hNoYdTDLlfzTyzpNv6UCLXgWbAk0RCGJJ07O9pB/4nT0oqw8dWqe8lIElCbwQ+WSHKUWXS2Gb5iFlec2VNpaRPL2oi2HdVnE8K8wJx6ujjtMMPjeAbyyjmLmUxUxiEmrRCD38dqiR5h+Ix/yIUycFAgsi5A4A1oluWu6x9DQeF5pZtgKJv57l2+iUMA2Zjk8RTW+QILh5K/7h8We25DdModwDSsgm/9iZenMPUsgnr/Zefb2EMhNL4e9VL4mMObnSIMeJTW06Xu4kw/6V4fDiGkwA+Rws0ssGPpydpDOmHL9ZRtAO+sSmfvGI3zpEjXKiENlv/2A92PjC8rljTlfaKMBDSlsbU4lxCfdXtveeSTdyS+JkaKjWDUeik6DWA3FNc+95q3xBIPv9IpaMR/PRxy9vraih1tOfY9LDaOipf72AuSXK839BkcFVtyRkhMAW37Tw37d+GxZO/1/S58WBBk8ZphfodUax217bvoUDL505frLQCA1AX7jlhKO8K9PnMYVz25MT
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(39860400002)(396003)(366004)(136003)(376002)(478600001)(2906002)(16526019)(316002)(6486002)(2616005)(8936002)(8676002)(186003)(38100700002)(86362001)(66556008)(36756003)(6666004)(83380400001)(31696002)(66946007)(5660300002)(31686004)(66476007)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bDV1OUpRNUhxcUNQM0JJN2w2bjRuRzVaQVlIbk90VWVIekFBdlNpL1Y1bXYr?=
 =?utf-8?B?UEViUEI5cjFKeTJnVTRudzdvcWVCb1gxd1BWZEVYMjhPbE1WYnZwQ3ZlaUxt?=
 =?utf-8?B?NS9aaUxEc0JMbGZ1akNzYkNVSnBxTXo4c1Qwb2h1NlhQb2NxYTlsazR2TTBi?=
 =?utf-8?B?YmNEVWV3MFgzZ2FHS0l4M1JwZ01CWHhtWVFxMHFaT2lJNGMwbXZEdkFWMlh5?=
 =?utf-8?B?RVpvUjAxNnFRdzI1QXFwVGoxTHhQbzMrcXd1a1lvTG5YYjZRNjkvcDBGWmZZ?=
 =?utf-8?B?eFVPMHoyMlNjRTNjZldBVlF0c2VUcW9ieFNXNld3Rm1RV2dramhtakZYTEQv?=
 =?utf-8?B?QXJmdXQ1b1JBS3FWVDlUZ3pJMElxc3d3U296U2lwTmxKVjQwZHRyWmdPVkdx?=
 =?utf-8?B?eDlsRHlyVzB4UDlEblR6bGpGcHViQzZPREtUVXRZRW91S2x5dTZiQUhCUTZW?=
 =?utf-8?B?cU5iK01CU0d3aDMrazh4YjFDNU4wOXdIUHBqUENFYnB3UEpZdHp1aEZVOVFC?=
 =?utf-8?B?NzBlZWxYbWhlRitKMDluSk1Oekh4S3RmSzhpeERhdlRhU0hNNS92Zm9YNmU2?=
 =?utf-8?B?WHdabTZHTHdlRHAvQ1QwVHIyYThwbGVRL1Q0QmUzMmFVZ09qeU9IeVV6aG1v?=
 =?utf-8?B?QkVqekhyME1hTDZyNm9URUttUGdCdVREaTJTS0h3UWVaZ1gyRUdISnZTcHM2?=
 =?utf-8?B?SFRWMFZBOS9pbkF3QThRK3NhNGNpR0Fmb3FqaHFkektSR2xWc05sd3piL3N2?=
 =?utf-8?B?UHUwNWhzS0U5dk4wekcrbDZYRHNEa2ZYZEtEQzZyRFlFdEFwaUVzZmhuamRU?=
 =?utf-8?B?M2pEWHBWU3dRaE9nSjBPelJGbGZtdXVRLzNEbG1pb2wzd2w1Ty9TeFhQcHU3?=
 =?utf-8?B?aENqeG1FS0ZMQ2U5RE1rSGVpTWN3ZSsySzExS1lSeVhmSmhQMys3M3V2YTRH?=
 =?utf-8?B?alR0VlNLOFVqczBxMTdxYlpQaVBVL0liNXVUNTMrL1VlcHVobzFxMlNZVE90?=
 =?utf-8?B?VVNDQlRaYnhXbm9lRHJsbXU3SjZiSi9rRktqc0R1dmNab053bGIrK1M1TDhE?=
 =?utf-8?B?WjFoTnVPN2dpWE44UGlDYldTVTN3ZENKQTZLTC9pYmphQmZMYzlNZXlDeHla?=
 =?utf-8?B?OUtOb20xQlgyS09xU1NKUWJDMDZWSUg1ZkpBWjB4RENtL0YwYllmTDRlZk9S?=
 =?utf-8?B?MzN3clAvRXRSSFV0L1Q5TWRUNjBRYkloTGd1dzQwUnkwbndEblFlV3dKM3Ra?=
 =?utf-8?B?QTY1bkhBODJ6ZFYycmYxcmRqU1pWTkhhM3lWalFlMngxdkxmRlZ1NExJL2Jv?=
 =?utf-8?B?aUt4Yk9rb0tyOUMwVTZvR0ZDNlZQblR5ZHV3OGloS3JpM2lWSUdRUEZhVTRU?=
 =?utf-8?B?NUlBU3NXbDh6bGhZam5lbzZQK1c5TnhEQlpqeVN6MDBvMmxkc2Vjd3hHbEpG?=
 =?utf-8?B?NjBQb0dvVnpBcVJRQVQzS0ZSZ1I5QXlZWEZMUGRGa3p6YTNlbHZYQ2lEMm5j?=
 =?utf-8?B?UGRNdXVHSEg2bGZkWCtHZFJQOXZQMFNuMVY0V21HYjNIMXpEa3NDRmVYZitJ?=
 =?utf-8?B?Q1NRSEdnb3lxSFRDS3BDbjU0eXlNWmRZSkw3cmJORGMvRThWUFNuV2ZBTHkx?=
 =?utf-8?B?L2Nnb3lPN2x0Zk9GeUorWk0xdFRQallOcFBJVmxEOWVXdks5TGwrdkNEOCtJ?=
 =?utf-8?B?OVp4Y0x3M0NpTVdnN0IzTTRuOUhMSysva0R1TWhYUWIwWVZaRG9RSXJJak85?=
 =?utf-8?B?YStaQ1psNDkybytlRHN4QSt2cWhsa2tWczdYSXZvNUFJMEVETU1RekxvcGJP?=
 =?utf-8?B?YUM2ZnFQNmpncGM2MnVQczlxZ1dkd2E2NlhEZTIvVmxSNy84am9MbVNmVmQy?=
 =?utf-8?Q?q+4KpdvGotXpF?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b508fdc-ca04-41f6-add8-08d92f574a29
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2021 17:10:20.4880 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t41XmwuwtbOgt1AMyrA/2l7VdNmQtVRr/1CslFyJL7eqoIUQXLNKbcvqIqy+kNgu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4374
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



Am 14.06.21 um 16:32 schrieb Nirmoy Das:
> Make provision to pass different ttm BO destroy callback
> while creating a amdgpu_bo.
>
> Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 28 ++++++++++++++++++----
>   1 file changed, 24 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> index 9092ac12a270..71a65525eac4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> @@ -522,15 +522,17 @@ bool amdgpu_bo_support_uswc(u64 bo_flags)
>    * @adev: amdgpu device object
>    * @bp: parameters to be used for the buffer object
>    * @bo_ptr: pointer to the buffer object pointer
> + * @destroy: ttm bo destroy callback
>    *
> - * Creates an &amdgpu_bo buffer object.
> + * Creates an &amdgpu_bo buffer object with a specified ttm bo destroy callback.
>    *
>    * Returns:
>    * 0 for success or a negative error code on failure.
>    */
> -int amdgpu_bo_create(struct amdgpu_device *adev,
> +static int amdgpu_bo_do_create(struct amdgpu_device *adev,

Please don't. Rather expose an amdgpu_vm_bo_create function.

>   			       struct amdgpu_bo_param *bp,
> -			       struct amdgpu_bo **bo_ptr)
> +			       struct amdgpu_bo **bo_ptr,
> +			       void (*destroy)(struct ttm_buffer_object *))

That rather belongs into the amdgpu_bo_param structure.

>   {
>   	struct ttm_operation_ctx ctx = {
>   		.interruptible = (bp->type != ttm_bo_type_kernel),
> @@ -594,7 +596,7 @@ int amdgpu_bo_create(struct amdgpu_device *adev,
>   
>   	r = ttm_bo_init_reserved(&adev->mman.bdev, &bo->tbo, size, bp->type,
>   				 &bo->placement, page_align, &ctx,  NULL,
> -				 bp->resv, &amdgpu_bo_destroy);
> +				 bp->resv, destroy);
>   	if (unlikely(r != 0))
>   		return r;
>   
> @@ -638,6 +640,24 @@ int amdgpu_bo_create(struct amdgpu_device *adev,
>   	return r;
>   }
>   
> +/**
> + * amdgpu_bo_create - create an &amdgpu_bo buffer object
> + * @adev: amdgpu device object
> + * @bp: parameters to be used for the buffer object
> + * @bo_ptr: pointer to the buffer object pointer
> + *
> + * Creates an &amdgpu_bo buffer object.
> + *
> + * Returns:
> + * 0 for success or a negative error code on failure.
> + */
> +int amdgpu_bo_create(struct amdgpu_device *adev,
> +			       struct amdgpu_bo_param *bp,
> +			       struct amdgpu_bo **bo_ptr)
> +{
> +	return amdgpu_bo_do_create(adev, bp, bo_ptr, &amdgpu_bo_destroy);
> +}
> +
>   /**
>    * amdgpu_bo_create_user - create an &amdgpu_bo_user buffer object
>    * @adev: amdgpu device object

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
