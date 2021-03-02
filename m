Return-Path: <SRS0=vakm=IA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46595C433E0
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Mar 2021 12:40:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C141864F70
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Mar 2021 12:40:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C141864F70
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3B45B6E0AA;
	Tue,  2 Mar 2021 12:40:38 +0000 (UTC)
Received: from NAM04-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr700088.outbound.protection.outlook.com [40.107.70.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D0DF6E0AA
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Mar 2021 12:40:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nJd+h82PqbFDdhn1x9MlYtz5g46J8Trr8VHbf0q0MdckXYs9ofMoWVeVKBDCMY30wfiX3Ji7nL9lkvWG1dIsMgoq144ktXnfTtSvcRrIx9PtQzQFdsOAPsewgCIsJ4WMO9U/Uji3y/fXjMnCt4A4jY1uOP3bEce7ViqraeLyq1qGbNWTnWgLwuoHvFvhdlV/jdMaq1M1RHoVM3Ybifdd5M+L2FeWrhZ1RfXzSNnzFbZAy6Ki7j4MEo6efJmhW27JckgxmrE9KzNW8gv3vjyXTsFmmSSLM9v57t8zeyhL1leRmqfSp5TNzaIT2S8DDf4m8thdzS+u6tb9F2/9Se+Vhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LQQSHVoyY77Ln7llRYp7n3VNn2DcNikowLAMzwxCDD8=;
 b=I32M1N/5zCqByQQqi7mF0XnxBrx0rnL5LuSJjLyiniSG1ZEK2xNgNtugNOjt+rXOz6JAPYtdnO2JdFTyyeZEwafbOCvNAojRTp7huIdd6NFqFldpDxN1X+Tbgp89ZRN2phvWdnU2g3z7SqEbxIPkzJnHLJyt4EfJVvVPF7bREWBtUPPsJuLakdgCTJK9gxMHlP2oa/8C0mxE5nul/MxQXbHb4YovV4HCK2EZPxFjDN5jYJmUfBiyaqxbZzstLVofDndO6QKEDVTZ0OVxLuGpZpzOZz8u5m0ermpAh860aK4Xf8SIgbzv4MG8rcnYHtE984ioz4fL0hWV0qoksnuPBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LQQSHVoyY77Ln7llRYp7n3VNn2DcNikowLAMzwxCDD8=;
 b=qhnEKPlEmgxBq0v/+WBtvYpdLSY64psZTgViAoml9gQ9OoFaOho0MClcFDf0qCA8mjtsTlgnGUV2U+FTI9l5d8V3sy1wm732lOP/XMdiemAiaE15Iq8l1vNvo3rMeTXw3aCnkZUD2oL+OF/JrkoPbyuycRqkB7EVPI2AqJFYjoA=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by BL0PR12MB2354.namprd12.prod.outlook.com (2603:10b6:207:44::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.28; Tue, 2 Mar
 2021 12:40:34 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::c1ff:dcf1:9536:a1f2]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::c1ff:dcf1:9536:a1f2%2]) with mapi id 15.20.3912.017; Tue, 2 Mar 2021
 12:40:34 +0000
Subject: Re: [PATCH 2/3] drm/amdgpu: introduce kfd user flag for amdgpu_bo
To: Nirmoy Das <nirmoy.das@amd.com>, Felix.Kuehling@amd.com
References: <20210302113341.74813-1-nirmoy.das@amd.com>
 <20210302113341.74813-2-nirmoy.das@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <2a73e3af-92a1-a356-0206-935c661c978a@amd.com>
Date: Tue, 2 Mar 2021 13:40:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20210302113341.74813-2-nirmoy.das@amd.com>
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:9804:8dfd:7f6e:acec]
X-ClientProxiedBy: AM0PR01CA0073.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:10e::14) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:9804:8dfd:7f6e:acec]
 (2a02:908:1252:fb60:9804:8dfd:7f6e:acec) by
 AM0PR01CA0073.eurprd01.prod.exchangelabs.com (2603:10a6:208:10e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend
 Transport; Tue, 2 Mar 2021 12:40:33 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 3f19742c-7849-4804-d542-08d8dd785f67
X-MS-TrafficTypeDiagnostic: BL0PR12MB2354:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB235417BEDD1D23E8E4CC464283999@BL0PR12MB2354.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JDCaGNkKeLgH1azMLNbIJaYK3hFC8xXu8mub5fGEk7x/7ydPsE5Fn5p/tSVgYp4uJiyuE/z8y3WX259v3rvX60xx+O9z/Wc2tEuLOId/XTVFOOK7LtazCkiDSqilqKjyngN2ys89QNeUSiehDuoMhNk0LF9GtmR42X4LrTgqxP1LEUT4uGgqVZHhR8TGG+kQgQ0RJvfbdy0PyIe36l/ODUXRr4K2F0wx16amwlWfyUGuDAmKRG4jaIIHatZEvw0hSQk/Pr2O6k3xJbkrD0xvBZtGZ8k11bz1vqSovtscMQDu144ZKoJH6q5X4k7uvYYbvNCjF4957mFjjq/oYa2aF5fyNrU0wYA/95/OUwuRkCw2chtrXJdqDHfY1LztVJhP32IwRVA+KQNI1CMpInWI+xjj6zMMwD30uOlv11WeYK97D14p3PQTTyltITfvjpEzZDONdrbc4K6emPmWPxH4HrnLVNCWTmt+dX4IDRmmiHG4KtZwdscFl8MRzAguEyX9EyY+x6GJobJRkDWnSeGgJuDtab5EPCSJ6DPCz9mB9ojdf9Kd940wDlQdChm0gAO66HXsJPWoZgvFtiXnIoCv2Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(136003)(376002)(366004)(346002)(39860400002)(36756003)(83380400001)(66556008)(316002)(2906002)(4326008)(186003)(31686004)(66476007)(2616005)(52116002)(86362001)(66946007)(6666004)(31696002)(8936002)(5660300002)(8676002)(478600001)(6636002)(16526019)(6486002)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?b05MaExENTNpY1QxbDBrN3Z0aHRnSlUvR1d3UmpCei9qVjE3OFZuRU4rWHo4?=
 =?utf-8?B?N00xM25IMnhBQlUzQUw2S0FnTWZqcktXOHJMK25jb3pYakZzTlBtdThYejJQ?=
 =?utf-8?B?SXVnWTAzdFl0Q1Y2MVkySDUrOStNQjJUclVEREVUdE1DUGRUY1FuZ3d3a3Vo?=
 =?utf-8?B?enFzMXBTSnlTUGN1VUp0RzFmZlJvRGUvZDV6Y0piQ0YwNFFSWGVkSHRqSFJl?=
 =?utf-8?B?SVRDenRJSTdOSGo4RzZXOHNTWUVMNSs4N0FYeTlBOGdZbWNuUlRnRDdKODZP?=
 =?utf-8?B?aEpLeWNYbFFWMnZETTcrb0hNSEZra1FtS1BNWko4bE5HeEc0VDBWN3lmWjQ2?=
 =?utf-8?B?UnhZejNvaUlsT2JEbjhuTEViMmc2aVJEaEphQ1NWczc2eFY2Y3hhM0RFYk9W?=
 =?utf-8?B?ZHB0VVdRY2VGTkFqS2tsZExxVTN3OXUyZHd5cGR6MG5GcDFkQkNneDhob2F1?=
 =?utf-8?B?RmF4VTEzKytMM25iWFlvaENocFBrQ2tJcHRVM1BtM0toN0FWNzFuU2xTaGIw?=
 =?utf-8?B?ZzBITUFGTENzQmxhcW9NRjZ5K1NUQU1wMURlQ1RZY2JDN2RWcFVCdG53eWxC?=
 =?utf-8?B?elNNZGorTk1uZ1Fibk5CRHE1czd2R1RIRGhGM0tDZUJxNFgyajY2dExvQnlr?=
 =?utf-8?B?YWdLT1FjYUZiUG9GQ2U1U0t3My9VS2tsc3NGZXRhNEdzWVNnOEZqMUxWblpn?=
 =?utf-8?B?SlF5V1I1cFllWmhyTWllT1JUR1hvUkJRWmtpQWc1OUQvdmFCa0JOQi9jcENX?=
 =?utf-8?B?UVdqZkdJUjhKMXd3dU9hakxXOFRDa2k1WW9LR3orRjhuMG5Fb2F2eVY2anB4?=
 =?utf-8?B?elBNVVVvbFVTZkdUcmJxdmhWWWxzTFM5cjk3dnhYWkVicHJneDRPeFhreXVI?=
 =?utf-8?B?RWpiRWY3cnVBQlUxTWRuR1hXejlOaFV5VHpZQXRsVnBKeVIxWGhjRjBCaDlL?=
 =?utf-8?B?SUxyb3o4ZEtlU3V6ODdRMEpSTnNTa3U5SVMwMlA4VlJaV0NQVnhHN3prdzZR?=
 =?utf-8?B?WThoQ3l2bmxTcjVvREVjbHZSeHJONW9DMGR1eVhUbHoxRkpUQmlrMUhZYk9X?=
 =?utf-8?B?MExsa1QzU2tPMjBpMlIxUmtjVHB2ekp5MXFoMC9abFYzbGgydjNkYU15WW5q?=
 =?utf-8?B?NU1PaElHSkE2Zk11N2QwbDRFRGpLS25WZE04aGp6RlJlOEk0RGZFSExIa2Ry?=
 =?utf-8?B?NXZSbVAwalJtcXFFY3p3N2JTUXFwRlp1R0M4N3hUVFIwNHdacG0xbmpGc2I5?=
 =?utf-8?B?VmUxWDFzTit3SkszRk5FanJvVnVHTTF6YmZtUEVTTXFqaEhCSHFGQlg2TVFa?=
 =?utf-8?B?S2N3eUpmVTBJYk5Nc3FxandzM09HSllpZXdVWXhlTWhhRjlydWNPZDlSNnlG?=
 =?utf-8?B?bnlIa1BwV3RlRC9pNTNiQ0hGK25iZW80aWphWXhZYzhweHVDc1pKTXMwR1V3?=
 =?utf-8?B?TUdLZ1kzUlkzVXhFbis5YWlCdDVVaU04Yks3bjVadEdza0tmNDJnMndRVTZh?=
 =?utf-8?B?NkdZQ3ExeCthSngwaXZmQk42L2FlbkllV3pVUkJHVnRUZ2s1V0NENmpyTHBH?=
 =?utf-8?B?VWY0Vlhva1FqbklDeWF5Ky9qY1REdXBiOUFrVzQrbENrTTlZVCtOalJSdTJV?=
 =?utf-8?B?d3ZOd0lqZVVYeHEzU2toZEtSWmdoUERHMUp6N2hqbnl2eDFRNmtNU0dzcFh1?=
 =?utf-8?B?NEZzWHhGU0hmanA4ZUNWelIzVStrWXRtSE9Jd3lHeWQwdkUxYzQ4UVFWcVZL?=
 =?utf-8?B?TWkyb2MzTmV1bGtKRjlKeC9BUTZEOEgvdjJnSVJJczR3aGp1b2pmMTUzcHlJ?=
 =?utf-8?B?WWFrU0hWdWtwWjdZU0RnT05McHpsSXN6YWljb3JPb1hwNVdsRUVGVGVDZ3JB?=
 =?utf-8?Q?smllWAvW+fwmW?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f19742c-7849-4804-d542-08d8dd785f67
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2021 12:40:34.1488 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W7B6/O88UckaT0+Ba92W6aSgRBFFak+dnRkO1aV5l6e7uY37ujb/mhoKL6rDf7Ip
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2354
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
Cc: amd-gfx@lists.freedesktop.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



Am 02.03.21 um 12:33 schrieb Nirmoy Das:
> Introduce a new flag for amdgpu_bo->flags to identify if
> a BO is created by KFD.
>
> Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
> ---
>   .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  |  2 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c       |  3 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.c    | 48 ++++++++++++++++++-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.h    |  3 ++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c       |  2 +-
>   include/uapi/drm/amdgpu_drm.h                 |  5 ++
>   6 files changed, 59 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index 89d0e4f7c6a8..57798707cd5f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -1227,7 +1227,7 @@ int amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(
>   	bp.flags = alloc_flags;
>   	bp.type = bo_type;
>   	bp.resv = NULL;
> -	ret = amdgpu_bo_create(adev, &bp, &bo);
> +	ret = amdgpu_kfd_bo_create(adev, &bp, &bo);
>   	if (ret) {
>   		pr_debug("Failed to create BO on domain %s. ret %d\n",
>   				domain_string(alloc_domain), ret);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> index 8e9b8a6e6ef0..97d19f6b572d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> @@ -234,7 +234,8 @@ int amdgpu_gem_create_ioctl(struct drm_device *dev, void *data,
>   		      AMDGPU_GEM_CREATE_VRAM_CLEARED |
>   		      AMDGPU_GEM_CREATE_VM_ALWAYS_VALID |
>   		      AMDGPU_GEM_CREATE_EXPLICIT_SYNC |
> -		      AMDGPU_GEM_CREATE_ENCRYPTED))
> +		      AMDGPU_GEM_CREATE_ENCRYPTED |
> +		      AMDGPU_GEM_USER_KFD))

Please stick with the naming here. And why _USER_KFD and not just _KFD?

Christian.

>   
>   		return -EINVAL;
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> index 0bd22ed1dacf..5ebce6d6784a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> @@ -697,6 +697,52 @@ int amdgpu_bo_create(struct amdgpu_device *adev,
>   	return r;
>   }
>   
> +/**
> + * amdgpu_kfd_bo_create - create an &amdgpu_bo buffer object with kfd user flag
> + * @adev: amdgpu device object
> + * @bp: parameters to be used for the buffer object
> + * @bo_ptr: pointer to the buffer object pointer
> + *
> + * Creates an &amdgpu_bo buffer object; and if requested, also creates a
> + * shadow object.
> + * Shadow object is used to backup the original buffer object, and is always
> + * in GTT.
> + *
> + * Returns:
> + * 0 for success or a negative error code on failure.
> + */
> +
> +int amdgpu_kfd_bo_create(struct amdgpu_device *adev,
> +			 struct amdgpu_bo_param *bp,
> +			 struct amdgpu_bo **bo_ptr)
> +{
> +	u64 flags = bp->flags;
> +	int r;
> +
> +	bp->flags = bp->flags & ~AMDGPU_GEM_CREATE_SHADOW;
> +	bp->flags = bp->flags | AMDGPU_GEM_USER_KFD;
> +	r = amdgpu_bo_do_create(adev, bp, bo_ptr);
> +	if (r)
> +		return r;
> +
> +	if ((flags & AMDGPU_GEM_CREATE_SHADOW) && !(adev->flags & AMD_IS_APU)) {
> +		if (!bp->resv)
> +			WARN_ON(dma_resv_lock((*bo_ptr)->tbo.base.resv,
> +							NULL));
> +
> +		r = amdgpu_bo_create_shadow(adev, bp->size, *bo_ptr);
> +
> +		if (!bp->resv)
> +			dma_resv_unlock((*bo_ptr)->tbo.base.resv);
> +
> +		if (r)
> +			amdgpu_bo_unref(bo_ptr);
> +	}
> +
> +	return r;
> +}
> +
> +
>   /**
>    * amdgpu_bo_validate - validate an &amdgpu_bo buffer object
>    * @bo: pointer to the buffer object
> @@ -1309,7 +1355,7 @@ void amdgpu_bo_release_notify(struct ttm_buffer_object *bo)
>   
>   	abo = ttm_to_amdgpu_bo(bo);
>   
> -	if (abo->kfd_bo)
> +	if (abo->flags & AMDGPU_GEM_USER_KFD)
>   		amdgpu_amdkfd_unreserve_memory_limit(abo);
>   
>   	/* We only remove the fence if the resv has individualized. */
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> index 8cd96c9330dd..665ee0015f06 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> @@ -245,6 +245,9 @@ void amdgpu_bo_placement_from_domain(struct amdgpu_bo *abo, u32 domain);
>   int amdgpu_bo_create(struct amdgpu_device *adev,
>   		     struct amdgpu_bo_param *bp,
>   		     struct amdgpu_bo **bo_ptr);
> +int amdgpu_kfd_bo_create(struct amdgpu_device *adev,
> +			 struct amdgpu_bo_param *bp,
> +			 struct amdgpu_bo **bo_ptr);
>   int amdgpu_bo_create_reserved(struct amdgpu_device *adev,
>   			      unsigned long size, int align,
>   			      u32 domain, struct amdgpu_bo **bo_ptr,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> index 7b2db779f313..d36b1932db78 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -164,7 +164,7 @@ static int amdgpu_verify_access(struct ttm_buffer_object *bo, struct file *filp)
>   	 * Don't verify access for KFD BOs. They don't have a GEM
>   	 * object associated with them.
>   	 */
> -	if (abo->kfd_bo)
> +	if (abo->flags & AMDGPU_GEM_USER_KFD)
>   		return 0;
>   
>   	if (amdgpu_ttm_tt_get_usermm(bo->ttm))
> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
> index 8b832f7458f2..f7157bd8a1f0 100644
> --- a/include/uapi/drm/amdgpu_drm.h
> +++ b/include/uapi/drm/amdgpu_drm.h
> @@ -142,6 +142,11 @@ extern "C" {
>    */
>   #define AMDGPU_GEM_CREATE_ENCRYPTED		(1 << 10)
>   
> +/* Flag that the allocating BO's user is KFD. It should never be used by
> + * user space applications
> + */
> +#define AMDGPU_GEM_USER_KFD			(1 << 20)
> +
>   struct drm_amdgpu_gem_create_in  {
>   	/** the requested memory size */
>   	__u64 bo_size;

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
