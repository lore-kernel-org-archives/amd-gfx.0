Return-Path: <SRS0=2fSF=IP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77C74C433DB
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Mar 2021 08:03:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 240D064F7F
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Mar 2021 08:03:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 240D064F7F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D3B2B6E4D7;
	Wed, 17 Mar 2021 08:03:06 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2064.outbound.protection.outlook.com [40.107.223.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CFCE06E4D7
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Mar 2021 08:03:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RpWeQ1O7uj3e2yQjzzazUeI1MaYwfKITyQgMzRs7GqFp5TioWePQ5O+NLRURyk2XmuSYj0Dp7VBdvjnTwgofBl4ket3vGHq9iPq8f00DXDRywfjseGIyTMzf+iGvN+QE8XkIj9BYmZ9f0BjzDKg9ZLjzOFTEFSrGSDaJtj59zV5DQ+pQQAJfd8fViMx0Zffq5Ea0FCZ2uXWqReG+9xZ/4GIjYP+p4BKqEe5xtAlC1Pa23/LGj6VlIre+5Bq4ZZ6siQN/gMsZQQICv7SJrTwTxFbVdiNkonSrUSFSCJEkQjcmG7O/NB/7wKX0kai/FYGEV+ACFt/7orEtJp2y/qXong==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PjzYZnwh43SJjXrQiGWdeXjkROJEqtUlR9UwkpDtW4I=;
 b=grYTOjlpibWpu19PidG+Px3T5pqr+4A9Pva7N6wQ5yiU1ikoy3ZZYcl52bS9FRYYZuY+Ug6whvlejodAjDnKts+DNx+xE3HYXBi3kLxckNraBCqUfvapeTJiN3KRy9vGrCllNF54oOHndnwmrINlrqZUsfGIIcm++xjiy+bN7duy540S5JgzviU1AjVchqXvo4hIU/PxgkOvuyI95clbyj5NZN0gVueztUwVEpAGbifWwuj9NbayZVikl0X/vwoNvG8ZNoVpyvyDfqpDRERCK2X+a7P/t1g1efOo9ckdTwEnZ135YnVyN/t13zBwOHyoOd8QaJn0bZB+1XJ6mztyEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PjzYZnwh43SJjXrQiGWdeXjkROJEqtUlR9UwkpDtW4I=;
 b=lQnhr4CyzIbG4fpHJaARpW87qTK7upeLt3ODyHL6O2clkRgDLc0GORSPFzawELsiK/btVV15VSysJmXjpmbA8VhHiU1HJexj21+mdDiQWDKPgEd5eFE9Iu8MaAV7P4IisO8bwtyZ7OuiTpSoQcPwRNamx+odsoO4pyuzi86I248=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by BL0PR12MB4932.namprd12.prod.outlook.com (2603:10b6:208:1c2::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.32; Wed, 17 Mar
 2021 08:03:04 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::c1ff:dcf1:9536:a1f2]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::c1ff:dcf1:9536:a1f2%2]) with mapi id 15.20.3933.032; Wed, 17 Mar 2021
 08:03:04 +0000
Subject: Re: [PATCH 1/4] drm/amdgpu: introduce struct amdgpu_bo_dmabuf
To: Nirmoy Das <nirmoy.das@amd.com>
References: <20210317074716.5547-1-nirmoy.das@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <64dcd059-2552-b925-86c1-8d248d329686@amd.com>
Date: Wed, 17 Mar 2021 09:02:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <20210317074716.5547-1-nirmoy.das@amd.com>
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:ccdd:b6ca:11e:5cc5]
X-ClientProxiedBy: AM0PR01CA0093.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:10e::34) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:ccdd:b6ca:11e:5cc5]
 (2a02:908:1252:fb60:ccdd:b6ca:11e:5cc5) by
 AM0PR01CA0093.eurprd01.prod.exchangelabs.com (2603:10a6:208:10e::34) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18 via Frontend
 Transport; Wed, 17 Mar 2021 08:03:03 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d86aa0cb-1a10-46f3-74d6-08d8e91b1741
X-MS-TrafficTypeDiagnostic: BL0PR12MB4932:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB4932F441CBC74346C77F93D6836A9@BL0PR12MB4932.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mrmntsryjLiSOri5/2IH6F/CgZ4+s4KAInW6d794jYdF82iAPeGdrABkXmwS+xTAXEYk/VofW/bO7IPi0G28PUkEz7obG4927wJYAUeV8cIMscyyixPgxf9KC9ddZOzmiWvss1XxOGYJn8CoqTUeKJdHenxr50/EaHV9QPEiufPQb6m66mDPtl91S/jz/vRMfZ4r7OR75apLtJ+Qoo6GZe9x8CxJ1KJGkP1OTKGdIVA/G8v2JQSvqJhHLcqsYkTPwpB6kPSQKzX+rh/SpqBdp/tNsrhVGr1ItCK9NWusjb3EnbOAVJRhXAlRd8YKA9f7Pwm5L/RvC4BlD0S0jtCb9UENfYcsUcRYcG41PjUTMKzOXBmvDuLjq0oAS4v8qR69dGnqWmchli6VvE96GBSjVqw80rwi9m1I+Bhex3xLL2XMPg+ccKJ5/HRy7AnQy6OF+TDmTmJcfFXlth8pNHkb5CngoDm1lKcRCtyrJqDlMksZHDC32+V5+LO0NjDg5isTxYr3ps3Hm72GqCYXQ7s0ky09o2uraujKn/ajXGxfMCBGkaJo+iv3dKFfLWu83u4yYzdT3DyQQy97pl6z1dI32QutPkbdQ0Ry8FgNfxC79km90gVa72XrcuocCNdfqkNC
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(346002)(396003)(366004)(39860400002)(376002)(6666004)(37006003)(186003)(83380400001)(6862004)(5660300002)(6636002)(316002)(8676002)(52116002)(2616005)(16526019)(478600001)(2906002)(36756003)(66556008)(31696002)(8936002)(86362001)(31686004)(66476007)(66946007)(6486002)(4326008)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?NGR3ZUhlekNoMkhvWEpCMkhoTkFmbWx6TFlvZWkxVE9lTEltQm9tcjZXNWJn?=
 =?utf-8?B?RnJuRW5ETUsvNStadHpSVFF5NzBJeTlwcFdmRXhDTmh5WUs1dUlES0NIUWJU?=
 =?utf-8?B?cE9mTTM2VnFUWUlHcDE1WjNKci9NSWdybkwwa1BpbVUyMm9TYWx2QWhFNTI1?=
 =?utf-8?B?azB4YjhXQmdoeWdnaSthOWlydzBiVDN3WGc0U052czVqQnNvSHV3MzdVSTRI?=
 =?utf-8?B?bVJUVDNUb24ySjgzQlZCTDN4OW11b3RaZlZmZnB0dGQrMVRZa2NPbkF2RzlW?=
 =?utf-8?B?OG9xVVpWbitURTdMZ3NDZjFQMG4rS3JQSTFxL2lGWExlUHlaaDdacCsrbnRG?=
 =?utf-8?B?OE4rT0laeWtsbHVSMjl0dzNVWDhJR3VzbzFnM3pnUzZMaTlMM3RnSXhGY2hQ?=
 =?utf-8?B?UldQZHJHeHF4MThwa1R0UjQ2RURMaWk1ZE1DTXJPYkMyV0hiM1E2SHNybGNN?=
 =?utf-8?B?elFaeDFJUENpZmtUMTlxVldzMFdDQ0lHUk5oRzhRK2crcFhCczkxR1JPcUFL?=
 =?utf-8?B?Rkt4c3NPNlZkdERReWQvb016d0tHam8xbnF2WWFMSDNxc3o2YWJxY2M3RW1r?=
 =?utf-8?B?ZlJTMEp4QjlIWlo1bm0yaHU4cHZ5SThiQ1hnNXZoc1d3WXFBWDRjN2FRUzdQ?=
 =?utf-8?B?bVVocnRramRkZE9tSGZPdjk0Wm4rNGQzWTErYlNQRkVFekZSRmNTS2JBSldL?=
 =?utf-8?B?VGNqKzdzR0RWNHVlb1ZmVzFuQmM5SFlXaXVBUitBTXp1ekNSOC9VZVpCZksw?=
 =?utf-8?B?Q0tYM0lxK2FvZ0NFaGpnU2RKdEVvOFgyK0JoSlhjWFhuU2FncE52NFVLa3Vx?=
 =?utf-8?B?TTZOYmhBcWNGQmZMSUZ4SW9RNWJ0QXBEQy93VUVMdVFXQ2w5UFllNEc4Nk1D?=
 =?utf-8?B?N0NnamhRbFlPU21FRWZiUzRydkgvckNMam9rYlhsZmVhVm9NOCtrbUkyREJi?=
 =?utf-8?B?aXJpOUlsR2RwUENRUUdJSzR0MklRZ2srRm02dlRlMGxDVk1wOXVMMUF5YzRX?=
 =?utf-8?B?bmc5T3pYY1JvTVgvSlNuWDNMSVdobVJHcDhraURKYWp2RUhJL1VUaUNuZFJr?=
 =?utf-8?B?M3dJNjliaGVPSUhmSTFLczVRSExnVVpXNnZteHlvUXd0RVI4dzdCLzM3dUZG?=
 =?utf-8?B?RWVmalRFcFNock9KZXh5T2Q0OVBwKzlpa2dhNDYrMGFMdWhDWWhuNm1JQ0pJ?=
 =?utf-8?B?d0NnTXlSNDlGcGIvZzg1MUt5V1J5U0wrZUFES1JrWk5neThwQUNBRlo0MFRa?=
 =?utf-8?B?M1VhbTYzTmlqQUhHMHZWY0RCK3VFMEw5d0VkVUViOHBLcko1NXNFNXl0K01Y?=
 =?utf-8?B?aU8rcEszajg4eExnRC9MbGNlYlhWc3dMVER3OU1hb1AwcjZiVkszWWdrVkNN?=
 =?utf-8?B?a005b3EyaDkyZDN6eTc1Y2FhdlpKWXB5NFBkaXk2TlV2M0hvSG44eW9ncnFv?=
 =?utf-8?B?Mkd1Rk81dE9acFl5OWhhUkpzWWRVcmh3RnBnU3d2N3RBdXFldUNGdzFXRllB?=
 =?utf-8?B?VEFDVytLQ296amE4WTEvOWlUUW9lQVVyUm1CVWZUdWVQaXFrajg5QUJ0SnQr?=
 =?utf-8?B?em0vRVVMeCtGUVZ0WGVSVmpSZXZFbklsZVcyS3NaNHBFMVNsakN2bU1TN3Fr?=
 =?utf-8?B?VkRGOFBsaDRZUFgyU2xKRURRZFBWenFiRHR6ZzNRV1phQXlHa3BhbnhYYUg3?=
 =?utf-8?B?cENEMzlpazBwVEdMcEJJUTJFcmdqNDJlNkZQVmFUc0lQbGhqaWo1dXhuVmlq?=
 =?utf-8?B?TzRTaC9HSlVZb2tqQ01PanIzUkErZXJSVTZNWlJKdENBQjhBUlFNSndBY0N5?=
 =?utf-8?B?NlFqZ3NZNHZPM1d6SitKWjh3cXhXaDVVdTlsQkdVV3V6cy82VU95RC9GVWx1?=
 =?utf-8?Q?3n3tSBL2DZkfk?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d86aa0cb-1a10-46f3-74d6-08d8e91b1741
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2021 08:03:03.9148 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rNu5wmPYk3Cd/WTeyNyQXu+FtzpltriFFE7/Ml35rKEi+q50K5MgsNK8XXJTsORX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4932
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



Am 17.03.21 um 08:47 schrieb Nirmoy Das:
> Implement a new struct amdgpu_bo_dmabuf as subclass of
> struct amdgpu_bo and a function to create amdgpu_bo_dmabuf
> bo.
>
> Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 30 ++++++++++++++++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.h |  9 +++++++
>   2 files changed, 39 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> index fdf23e439b42..fa4686fe95c4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> @@ -727,6 +727,36 @@ int amdgpu_bo_create_user(struct amdgpu_device *adev,
>   	*ubo_ptr = to_amdgpu_bo_user(bo_ptr);
>   	return r;
>   }
> +
> +/**
> + * amdgpu_bo_create_dmabuf - create an &amdgpu_bo_dmabuf buffer object
> + * @adev: amdgpu device object
> + * @bp: parameters to be used for the buffer object
> + * @ubo_ptr: pointer to the buffer object pointer
> + *
> + * Create a BO to be used by prime BO export;
> + *
> + * Returns:
> + * 0 for success or a negative error code on failure.
> + */
> +
> +int amdgpu_bo_create_dmabuf(struct amdgpu_device *adev,
> +			    struct amdgpu_bo_param *bp,
> +			    struct amdgpu_bo_dmabuf **dbo_ptr)
> +{
> +	struct amdgpu_bo *bo_ptr;
> +	int r;
> +
> +	bp->flags = bp->flags & ~AMDGPU_GEM_CREATE_SHADOW;
> +	bp->bo_ptr_size = sizeof(struct amdgpu_bo_dmabuf);
> +	r = amdgpu_bo_do_create(adev, bp, &bo_ptr);
> +	if (r)
> +		return r;
> +
> +	*dbo_ptr = to_amdgpu_bo_dmabuf(bo_ptr);
> +	return r;
> +}
> +
>   /**
>    * amdgpu_bo_validate - validate an &amdgpu_bo buffer object
>    * @bo: pointer to the buffer object
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> index 25411b2c4dd9..4b9339c3f3eb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> @@ -38,6 +38,7 @@
>   #define AMDGPU_BO_MAX_PLACEMENTS	3
>   
>   #define to_amdgpu_bo_user(abo) container_of((abo), struct amdgpu_bo_user, bo)
> +#define to_amdgpu_bo_dmabuf(abo) container_of((abo), struct amdgpu_bo_dmabuf, bo)
>   
>   struct amdgpu_bo_param {
>   	unsigned long			size;
> @@ -119,6 +120,11 @@ struct amdgpu_bo_user {
>   
>   };
>   
> +struct amdgpu_bo_dmabuf {
> +	struct amdgpu_bo		bo;

That won't work like this. Imported DMA-bufs are also user BOs and can 
have tilling flags and metadata.

Christian.

> +	unsigned int			prime_shared_count;
> +};
> +
>   static inline struct amdgpu_bo *ttm_to_amdgpu_bo(struct ttm_buffer_object *tbo)
>   {
>   	return container_of(tbo, struct amdgpu_bo, tbo);
> @@ -265,6 +271,9 @@ int amdgpu_bo_create_kernel_at(struct amdgpu_device *adev,
>   int amdgpu_bo_create_user(struct amdgpu_device *adev,
>   			  struct amdgpu_bo_param *bp,
>   			  struct amdgpu_bo_user **ubo_ptr);
> +int amdgpu_bo_create_dmabuf(struct amdgpu_device *adev,
> +			    struct amdgpu_bo_param *bp,
> +			    struct amdgpu_bo_dmabuf **dbo_ptr);
>   void amdgpu_bo_free_kernel(struct amdgpu_bo **bo, u64 *gpu_addr,
>   			   void **cpu_addr);
>   int amdgpu_bo_kmap(struct amdgpu_bo *bo, void **ptr);

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
