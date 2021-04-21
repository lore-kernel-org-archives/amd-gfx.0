Return-Path: <SRS0=nJCL=JS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27664C433ED
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Apr 2021 13:28:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B43D661440
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Apr 2021 13:28:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B43D661440
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 489DF6E155;
	Wed, 21 Apr 2021 13:28:17 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2062.outbound.protection.outlook.com [40.107.223.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5F22F6E0DE
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Apr 2021 13:28:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f/XoC5WaJsuM9Zsko5WZU3bykxPMa8gdJDlrr2QtvMCzTKAncgfp6ewcdPPKM2aGextT6Y9NTnuaGRyTYTfnkYgry6NyOq6Hv7I014y8hOjFf5942m6+iFwQbInMCC8gFO4luB33uj7A+v5/sTUbuMgIFqPUKga1g+JDR/wFnoImh0zrgm3eiucFjla5AQhi9OA88j54w3Q8f0USZzdxT74UkbimvWqN2b6U+NPilMv4KT25Vc50lVTZbwK+6dszgq2OqhACOJaRr3ovEjPQPAxDIav4jyPOztDJLLOYt47h7WX0GYMN5KrOeHV566uHHgXnTIlyQwNP54UFPwbrdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Li9RKI+g8emkXerdawRVTfI4Iw46N5i5CLWiaCuLlA=;
 b=abwOLvkK96+A3dvy8oHIb9vJoCdzGirI1Vo2VOqwCG1ewDs0oqjqeTZb6VI5Z9n7H6VbSqLXclm8cpMJo5FlrACljo4sWFG2+uTamRIGLALxYNSsRIFj8wAc6urqA/mdpzkxPvEIDZso1Pe0wCHsh5/BKxMaQk5tezgh4RUEFFh86JRX0s9dj0/1DRpkqXTSnM8pN26bhWm3S8WiA3VycuzEQc0e23MZwVnm9mscvNKwUujqx8wxKSrzc9z9jqUcwVPwgHYuW0JugyqMWmpigqbNwx4KArsiNPvghfnULDDazhzrnQWJLWoJQYYDbEWITCH4vUSyEo5+1glX+RrHlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Li9RKI+g8emkXerdawRVTfI4Iw46N5i5CLWiaCuLlA=;
 b=Zb3YxASumxIjqrlogDYfkYRwvn4+d7DIczH+W6q0YcXyaQdmclIk+4kKe+DBG/OfgpezOQpPjPRrxRHc6o6Jkls6yoa8NBvcbVlujH7revIJXe+D04eEQIrxWygKgJQv95eCjDvNUv/QOBIzDi4J4KVTzBL+Eg+Ys56XNCWSfLU=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB4550.namprd12.prod.outlook.com (2603:10b6:208:24e::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.20; Wed, 21 Apr
 2021 13:28:14 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::6d4d:4674:1cf6:8d34]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::6d4d:4674:1cf6:8d34%6]) with mapi id 15.20.4042.024; Wed, 21 Apr 2021
 13:28:14 +0000
Subject: Re: [PATCH 1/1] drm/amdgpu: implement and use
 amdgpu_bo_create_with_shadow()
To: Nirmoy Das <nirmoy.das@amd.com>
References: <20210421132028.6154-1-nirmoy.das@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <02522c4c-c9b7-88e0-557a-c22e7a224f47@amd.com>
Date: Wed, 21 Apr 2021 15:28:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <20210421132028.6154-1-nirmoy.das@amd.com>
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:30c1:a1b7:433d:2c5d]
X-ClientProxiedBy: PR3P189CA0035.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:102:53::10) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:30c1:a1b7:433d:2c5d]
 (2a02:908:1252:fb60:30c1:a1b7:433d:2c5d) by
 PR3P189CA0035.EURP189.PROD.OUTLOOK.COM (2603:10a6:102:53::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4065.20 via Frontend Transport; Wed, 21 Apr 2021 13:28:13 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 661d4494-ae0f-4d3a-8e84-08d904c950f6
X-MS-TrafficTypeDiagnostic: MN2PR12MB4550:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4550216BEF1909C05C1BD47683479@MN2PR12MB4550.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LoDkZPzEUBcQd87R95AO9DHOCht6vzrelApEbRQUfVB9JXCTei+o9SL4qSZegjrvUjHCSGk6LPJdj7bR38TxhWt7FeoEkIbhN2k+njLz2Aw+eZ+hvUzMGAwa2Ynq4eWl4GWGuNbjmaRehFv+Ms8sTCJeD1OR1lXCqIr7kwayB8g5YUTbh/NAO82SRCtE08AibPX4M4USaogyCQESLjYMS2CdlMNHkGuPF2g1R8lsvgnloszMU7zd3tU9FuGaMVo9TPuDGLlbAyLc1v76wR2cHh2/Qjdb+ZdnXJ6OPrwcXocqYtzaNFcBGoaQpwk6QlTFOyhyBSSGXX+crI7Ydc0Zs0gppyzu9Tqrz+4gDoXRw8D+ReiB04FokvgSGzOYOAP+GoafU7L0n4nRTJSyA3PZRYsxECTHXKFS0vQxaAY/dhT3R8JX1E922hFrTAApLU5FXG8Zi0zwugUQWEdsGqDO4qKyFXS6eNI1p5ZLpq3ZObMcdqidPmkd88tBux+lzgmOyIcM0a3UL/OP47AbAZaaPjPh78ECirczD88VjuEgEdJKcqr5+y+WqYNEMtuT8wtUp9UoEpjX6O5VsS3U/ABsL8A6ZMz8hVy7HtkkpPXCCBCVXT7QgmT3ynSH9eRPp8abpTWZzCwQIC09Vn5q3RbEGCNl8v6nr3yk1ZpiZBXkHx7nUR4bvzL3oGFSevh4Yhz7
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(346002)(136003)(366004)(396003)(39840400004)(316002)(6666004)(2906002)(16526019)(186003)(2616005)(66946007)(83380400001)(66476007)(6486002)(5660300002)(8676002)(4326008)(6862004)(37006003)(8936002)(36756003)(86362001)(31686004)(31696002)(38100700002)(478600001)(52116002)(6636002)(66556008)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?T2xLZjdERnVYREVaclUwcUlFZXUzRFhPM0daSFBwVXlQM2c3OTdRenIxdGM2?=
 =?utf-8?B?TCtsekp1TVhJNllXVUZJbHhkUzhhbnZyaWhtemtJcnQyamJJR2FUb1loTzRK?=
 =?utf-8?B?bXN1cnJWM3p4aEJoT3hGeU91V3hDMUkxenFSUis5RDlpSFNQNjRvOFBDYkJR?=
 =?utf-8?B?TTg0WlZWNkJUZ2gvNGxJeTliMjNWQTVQRGtXYmNQdmtLZ2psUytvOG53dXR5?=
 =?utf-8?B?TnZ3N2UxVEt1T2NUdU1QNXNYcFpXU0VJVkFsbVhXaWx6d0kwQmR4aEVOS2lN?=
 =?utf-8?B?bjRVakpPUUVmYzNNejNINjB0eldnRHYrVlBRcDJhNEM3L2RJTks3MHhNeEp0?=
 =?utf-8?B?bEFmTVFtL1VLbmt2V09FcnhwbmRVVFl5KzlWU1B6V0lpL0hqYnBKMFV2aEpG?=
 =?utf-8?B?WThmOStaR2dPbVp1OFRIZ2ZRczVmZ0FUcHZBMDZMOEJpYWxtc1VPdlg1eFNr?=
 =?utf-8?B?bjRGYzNxSmZZN0JEQnFrRzdzQW42MHp4SUx1TS9HYmtnZ3FTMWtLQWtKT0wy?=
 =?utf-8?B?TGlGOTF6bFdRWVJSU29iaVlJaGNZYUVUaTYrblNSTVpOOWJHVGMwQmhMdFFO?=
 =?utf-8?B?a2hyZlNlRXVVOTg4aUJsSDNFWUR3eVBYTkxxeTRpWTN1bmoxQmRrM2xvS3R5?=
 =?utf-8?B?bUR2Qmg5aXYrc1JDVW5vMkI3bnUzVDdQVkFvbGgxNzNJWVV2NVA3Q1l0K0J0?=
 =?utf-8?B?ODc5OXZNYWNocHdMVnJlaU5qb3dZLy9seXFNQURRL2pYZCtyYTR1b05NSlho?=
 =?utf-8?B?dWQyTElyY01xb1YwT2hvTHRWT0F3d2xjODJVbDlwVWdLdTJnaWRpblUvcGRU?=
 =?utf-8?B?Y29iMHl1L2RLQVp4NGZJeGpSN1ptb0wweWkrMFB1Uy81Y1NVYnZEdmRIdGgw?=
 =?utf-8?B?M0QwZnFVNjdqZlhFMWVQTUVxRll6TURzWnBha2hIdDE4SW5md1BXRzc3NTBQ?=
 =?utf-8?B?dGhNdmpZMTNlQmRsSXpaa1FscE0vZ1RRaVNTMWc4YVEwMEFCTmpQTUtUTjRM?=
 =?utf-8?B?YW1KU3AxS3JneVpOa09GR2FtSjJNcGJBVTkzUDFiSzF1b1VnaDZiY1FSRG5r?=
 =?utf-8?B?bjdZVFNwNW9zZVhPVElJWnAzR096UlRDOTF3OXpBUE5nS1VBS1NWZjczTmFS?=
 =?utf-8?B?Q3VnRVZxcitVcHBIL1ppZ2FTZHFpUVJRcmNQWjFjd21wLytrcUhucSs0OTdn?=
 =?utf-8?B?bTNRSW82Q2pMVW5MdnB5TzluMWpPWGlPSmdEWTc2eU1mY2ZHdmI3NStmVVRG?=
 =?utf-8?B?QWR0MEcwMzJjZVcyaUFZdENyZTkxUzh0TzJUUDlPTXZYVk0wemw1QjJYUk5s?=
 =?utf-8?B?M1M4UUExanJuQjl1VXYvWVRqRXl3a1FNa0R5cHFCRlNnQlZ5MkpqSXZ5cW53?=
 =?utf-8?B?WVJMMnpuYWVXSVZrU0hLeXdYbjZaSDNod2psYUlOd1lsckQrYXc4SXIwQkxy?=
 =?utf-8?B?ZVNKTG9jUHcwSDdEZXRTcVM3UGRkS2ZINWQzQWVSRHBmNEVOSEZ4b0JBdDZh?=
 =?utf-8?B?bExVMEwvbC9KL0dKNmNRSDR5UGwyVjhDWGJvUFJwN3FBUnBmcjlJUVFlajV5?=
 =?utf-8?B?TjBoVHNsUFI1czZBRmI0Nm9qdThHQWZpZGNEd2ErdHJhZmFid29BUURCM3E2?=
 =?utf-8?B?dldVOUxTczZ3N21UTDZTMzVrQmsyUFdTWVlkWVJCbEZTYkRoTTdLMGlyL2RW?=
 =?utf-8?B?MzdibnBMcFdXQUdndVNtMGFPaGhjcy83STdXT29HbDFyblR0ZTkwb0JOR3U2?=
 =?utf-8?B?WGJjRVBvV2FhZFFxc3NaL21wNCtxeWRvcVN3am5IUEJDWi9abnNLV1BvWkVp?=
 =?utf-8?B?bThEWFJ6UmJqc01pN2xuMDhYSlFMR05zdyt0OWNJaXpxdURTR2dDOGNHbzRm?=
 =?utf-8?Q?uGHRLZYGMhDQC?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 661d4494-ae0f-4d3a-8e84-08d904c950f6
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2021 13:28:14.4957 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LKN/LvgAJvkKTaWH+ZLQS0bv35NvsQRk2+e3ESvTOyEtvFOsPf9qe1V3mu1Ftc7z
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4550
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

Am 21.04.21 um 15:20 schrieb Nirmoy Das:
> Shadow bo is only needed for some amdgpu_vm allcations.
> amdgpu_bo_create_with_shadow() should make it clear that
> a bo is for amdgpu_vm and will also remove unnecessary checks
> from amdgpu_bo_create().

I was the one suggesting to make the shadow thing general handling.

But since that never took of I think we could just move it back into the 
VM handling and maybe even drop the flag.

Christian.

>
> Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 26 ++++++++++++++++++----
>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.h |  5 +++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c     |  5 ++++-
>   3 files changed, 31 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> index 1345f7eba011..608f07377d20 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> @@ -661,10 +661,7 @@ static int amdgpu_bo_create_shadow(struct amdgpu_device *adev,
>    * @bp: parameters to be used for the buffer object
>    * @bo_ptr: pointer to the buffer object pointer
>    *
> - * Creates an &amdgpu_bo buffer object; and if requested, also creates a
> - * shadow object.
> - * Shadow object is used to backup the original buffer object, and is always
> - * in GTT.
> + * Creates an &amdgpu_bo buffer object.
>    *
>    * Returns:
>    * 0 for success or a negative error code on failure.
> @@ -673,6 +670,27 @@ int amdgpu_bo_create(struct amdgpu_device *adev,
>   		     struct amdgpu_bo_param *bp,
>   		     struct amdgpu_bo **bo_ptr)
>   {
> +
> +	return amdgpu_bo_do_create(adev, bp, bo_ptr);
> +}
> +
> +/**
> + * amdgpu_bo_create_with_shadow - create an &amdgpu_bo buffer object
> + * @adev: amdgpu device object
> + * @bp: parameters to be used for the buffer object
> + * @bo_ptr: pointer to the buffer object pointer
> + *
> + * Creates an &amdgpu_bo buffer object with a shadow object.
> + * Shadow object is used to backup the original buffer object, and is always
> + * in GTT.
> + *
> + * Returns:
> + * 0 for success or a negative error code on failure.
> + */
> +int amdgpu_bo_create_with_shadow(struct amdgpu_device *adev,
> +				 struct amdgpu_bo_param *bp,
> +				 struct amdgpu_bo **bo_ptr)
> +{
>   	u64 flags = bp->flags;
>   	int r;
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> index 973c88bdf37b..6a9187ca0496 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> @@ -255,6 +255,11 @@ void amdgpu_bo_placement_from_domain(struct amdgpu_bo *abo, u32 domain);
>   int amdgpu_bo_create(struct amdgpu_device *adev,
>   		     struct amdgpu_bo_param *bp,
>   		     struct amdgpu_bo **bo_ptr);
> +
> +int amdgpu_bo_create_with_shadow(struct amdgpu_device *adev,
> +				 struct amdgpu_bo_param *bp,
> +				 struct amdgpu_bo **bo_ptr);
> +
>   int amdgpu_bo_create_reserved(struct amdgpu_device *adev,
>   			      unsigned long size, int align,
>   			      u32 domain, struct amdgpu_bo **bo_ptr,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index f95bcda8463f..2770d3b8dbde 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -920,8 +920,11 @@ static int amdgpu_vm_alloc_pts(struct amdgpu_device *adev,
>   		return 0;
>   
>   	amdgpu_vm_bo_param(adev, vm, cursor->level, immediate, &bp);
> +	if (bp.flags & AMDGPU_GEM_CREATE_SHADOW)
> +		r = amdgpu_bo_create_with_shadow(adev, &bp, &pt);
> +	else
> +		r = amdgpu_bo_create(adev, &bp, &pt);
>   
> -	r = amdgpu_bo_create(adev, &bp, &pt);
>   	if (r)
>   		return r;
>   

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
