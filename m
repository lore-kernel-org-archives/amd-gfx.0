Return-Path: <SRS0=mBQi=NO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E1A0C4338F
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Aug 2021 18:54:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD55D60E93
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Aug 2021 18:54:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org DD55D60E93
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A63189932;
	Mon, 23 Aug 2021 18:54:45 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2070.outbound.protection.outlook.com [40.107.92.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E2CC18970E
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Aug 2021 18:54:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XCSta3sxqXm8oP4l4igcusd6BmnySti2Y7grG1P3i9o+Ctxr3l39+7CsIlNN0lQTnPvKmHXl9dFyNeHbn/7QP2BdXudZbKP1t2Qm0BOICT6c4qSsLi/4DcJYO8lxvviyFbd9C1NMYZGFQ8Uis3HbJ/3zaXs5unLZK+fertDY2oIVfyN4c4nOcKrR/FoYP+jQ9q40syn+h3aIbAuWWwAqesiAYsBi3HIZbJxi4MkBdW1wfAObc6Ny439VaxZG/w/bbOoKiUj7DKHXaeVH2G7qRceTKRJ3F9TYR1s093Dfq+M43QCNWPmNagT6rNiFpBtXaqjqts100CbelkgU5Gl9qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MugBMO9YA9CnvBSE53RAZ3vFQXjCnSkc0jIzkhC+f8M=;
 b=Jb+N3OLD0Nx0Qks3d2OKDKRI5gcazwRmzRRQ8Cz32mtJfdr+A08edOY32j8kMLy6Z6tlJ3crm/A9jLMsL3gtOlxcp9/jdO1FHUe3FrhRDi1u/ubE9PTah2RipnziDEiBc9jQsjUDndA1Ikt5uZyE9x5LUZcgoAGTRBMciN3PUrXumV8KT14iwfB/dopcgJooUSdI/0WyNSDqbb3h0AX0w7MRS9mle9/lhp72y2qp44ga2mHiSf0H8SY/lGffp9RipqvUTm8F/o692ulDFmCka1MadWj/zmk/CccC4/59yAph2I/ex99MkS8MbWzgWXwVfqlswm6S0uqVoXDKodXKTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MugBMO9YA9CnvBSE53RAZ3vFQXjCnSkc0jIzkhC+f8M=;
 b=qBOoMeyy14EbsuLNQJLV/JDJcithvlWdOUDzdx+1TbYosRpU7MXJ6zsdZz2xQZRloolADk5ftPrxJJ0W77dfoLu8u97ypy2WnVkq4ar0ZOJoAgZJQ6knzzjnAtHEwyhbCNoNTQnCk8hfu7augs8/mM+lpgg+TusYRkBmWqudnhA=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5129.namprd12.prod.outlook.com (2603:10b6:408:136::12)
 by BN9PR12MB5132.namprd12.prod.outlook.com (2603:10b6:408:119::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.23; Mon, 23 Aug
 2021 18:39:42 +0000
Received: from BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::b891:a906:28f0:fdb]) by BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::b891:a906:28f0:fdb%3]) with mapi id 15.20.4436.024; Mon, 23 Aug 2021
 18:39:42 +0000
Subject: Re: [PATCH 15/18] drm/amdkfd: CRIU dump and restore events
To: David Yat Sin <david.yatsin@amd.com>, amd-gfx@lists.freedesktop.org
Cc: rajneesh.bhardwaj@amd.com
References: <20210819133713.4168-1-david.yatsin@amd.com>
 <20210819133713.4168-16-david.yatsin@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <ea582082-b4f8-5e9c-e946-7987b1685ed3@amd.com>
Date: Mon, 23 Aug 2021 14:39:40 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <20210819133713.4168-16-david.yatsin@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: YT1PR01CA0117.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::26) To BN9PR12MB5129.namprd12.prod.outlook.com
 (2603:10b6:408:136::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.186.47.3) by
 YT1PR01CA0117.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2c::26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4436.19 via Frontend Transport; Mon, 23 Aug 2021 18:39:41 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c70e1756-6fba-49cb-8e86-08d966655ea6
X-MS-TrafficTypeDiagnostic: BN9PR12MB5132:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN9PR12MB5132D3B62328D4A350585AF592C49@BN9PR12MB5132.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:161;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: y11yknU4o/TEw7HanBPUVvQ31btdBmh5cmyJTUNDYtNLg7lSH2StMDG+Ay2ZEDq6DK4RUEP3fg716wNwx1fnW60rHud/u8OazkDiLui6WG9csdQ3zwl07xdvguaIyv30RM2R3ojuxiOHZYesfDGHDGRUo/ZDZqOxS+H43j955a53WDRBpvbLB5iiwkIYEwlvpCG8zuWghvPFyvTHU8Z64eD3i3ll4m7xT1XRUqUE/DVzzWEEwDCx2a1d8RxsuAYAbwEiW1ttwK/YkYmYfrEan61+b4nx9gs/3CFSqgg6WjMW3Gc0oqAFu0OiZ5sWbJx0/DhVs3Dg3KxAEvSHaZWoV6TdzHKOb4QAp8xmlOQ/4Axp3uEa37g4zTPfzvmK/ugtqEQxgIMXRYSpdWlleabvRDIbq2dHDCbCIuZ14WPdXn6wMwxkjnWfguGqFkQT2YQQxFTbesayxPf//hSE1rnXeuWqOSkoYY7p9FWwDi2Giqg7Rk6Bit1TDx1dSnEE7rqYq2wDhuBPZfUjhn7bvCJjF1djVn6xBH6DOWs4cemOHdn+mKevS0EtF2GzvggEwaEKolfavpeb8h8kQW1VUavheiYrM98yq2CAAiMTxcW4k9aQVKytMH3eughderFv5fT1D7CTA9VPVcjzfPdaO4jh1KGMENLk8v5nYlF+54Lp8MTwFWhQvWsvAXyIc458AM6cxEx71zf3VJ7vsh3C8v3rztduD5gLbofaiCz0GDBx2K8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5129.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(376002)(39860400002)(396003)(346002)(31696002)(8936002)(26005)(478600001)(186003)(5660300002)(36756003)(30864003)(2906002)(44832011)(16576012)(66946007)(66556008)(66476007)(86362001)(38100700002)(31686004)(6486002)(2616005)(8676002)(956004)(4326008)(83380400001)(316002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z1RnazFMQUsvTXBMOWVEV29nV2hvMFVxVXRRZENPL3I1Nkt1SHh6aUxuQ0hT?=
 =?utf-8?B?cVVDSkMwK291Wnk4Yk0zUU5JVUhxVjNUU3krajY4cVRTb2s5WUE2em1kbVJv?=
 =?utf-8?B?Y2tSRjlvSTgxaENYVGdmWkJKUTl3VEluOTZjUG9IekY4V0VrM2p4SHUvQU85?=
 =?utf-8?B?cnNwd2JsUkRTd2tJc1dUTnRyS0pQZFZOZ1ZNQUc0R2lCSWZqamtBSENFb2tv?=
 =?utf-8?B?dGY5M0FhV0NERDJqbC9xT3BkbzU0S1Zkcnl5UGtncElsczNaNjlkSHRsUW9L?=
 =?utf-8?B?VGx5V0hwTWx0MU83NWduNTVYTTUyQSt4aFA4bHZSQkczSlVKZkkvalBBZ3V2?=
 =?utf-8?B?QjJHQXlBazUvVmh6SWdoVEQzWXo3Zkh1UStuY1A2bUg5SkJzRVlhOGplWWVE?=
 =?utf-8?B?ZjlKTTdNdkxTMDR1cmNqWTIvZHpJNXJhNktrRjdIMU5GMG50K0MreXdxTUEy?=
 =?utf-8?B?MFlHZk5GMFd4d1RTZFV2T1JMUEZCM1JJSTJ4WjRSK245T1hqbkp2T3dmaytk?=
 =?utf-8?B?ZXQ3dC81NXJDRjJoZUcxR1VUTTR5WHN0bU9yUVhXa25QSzBic3NraXdlNmRW?=
 =?utf-8?B?UTR6ZmlZcTF0RXdMQmV2Z3dyTXpNYzlzVDlxVUk1VGxGRldUYUNVdE5Ld0t4?=
 =?utf-8?B?Tk1sa0lIZExESmgyMVl2Q3RtdkVZNEJkdEdvY0p2VjIvWkFocFlZT0pGR0FQ?=
 =?utf-8?B?cXJYcVJRUDFqQ2JKT01STGljQ3BoU1hoTGdzNmpVdXZpeXA5RWphQytmUnZL?=
 =?utf-8?B?ZnJsZFhGU1pNaFpRSWZDQVVLWGtZSzBtM1dEYzRkaXNpQ1orajVWY3g1Y3hT?=
 =?utf-8?B?dGN3RDJsYi9hdlp4MUhuYkZ3Y0hCdnJCOENYOFZQUGR6c29UN2hYL2x3MDls?=
 =?utf-8?B?L3IrZGF1L0FEU0pIanBKcHdvZHVJWTNiSG0yNU83K3JCYXYvQkU1alM0WjhF?=
 =?utf-8?B?cDh0c2xjUTlKRlZKZDl1MWRRKzVDcU1rNWtjYXd5R3dtM0ttN3p6Nm5JNXFl?=
 =?utf-8?B?UTZzcVBFa2tlU2VpZmZtNS9mcExTV1psTWFvOVBQTWpGMThiRzZMY3U5Q1Br?=
 =?utf-8?B?S01tQ2xnRll4aVR3SzZQR0tnbG5ac1FadDlCUFZoMnIrWi8xdHozM1pBTkpE?=
 =?utf-8?B?ZzVwdy9uTmQxWW9IcmNYU1E5NEVjemVKUURaNEszbllyT2dhL3JwY1ExbmRU?=
 =?utf-8?B?cDdnUi8rT0VpbHVrcmo2MlQ4bGo1UnJSUkNjQnNRa3ZIVThnaHBVSEJmT2FZ?=
 =?utf-8?B?RTdyUXBsMFRzMTUxNHlSZ0JzbGhvWFA1MGtadHFvdlo0aTNJakZOSEZ5eXVx?=
 =?utf-8?B?dE9ZclBORVZJUlBOMGUzZXA3bThvU051cXRIdDBNaVJvKzhoWGhMVmFkWVZ5?=
 =?utf-8?B?Yml6Y3JBNWs1ZGU5VVkyVjlwblF4eFhKcVg0bnh2UkttSFp1NXUyR3EyYlNi?=
 =?utf-8?B?QmhncFlvRkhIZEppV0x6S3FMM0tqSm9KVG04eFNpTEFHZGQxVVI2SEllalZC?=
 =?utf-8?B?VDRjK3JOaHk3c01DTk1GeG0rcG1RVVNzOWd5TFRTSFlINTFiejJuODBySGI3?=
 =?utf-8?B?bzkzS3QwRU52a3A1VkVReEhZUTBKT0ZJeTg2dis4MHF5MDM3eWNsN25QdDJY?=
 =?utf-8?B?TXpneWc4OGVaQ3gydFRUZUNZenNhaW5Db0lkQ25nSGNyU0l6c1RKZjdkZlIr?=
 =?utf-8?B?dlo2UmpIanRDVGhYZldTMXpTL0lVZ0paUHhqRUpwcXVwdlQvbGE2dWFCRjJL?=
 =?utf-8?Q?/N69DgX40TFdqWWNDLdA72woKJmCpr7rH+MxeuC?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c70e1756-6fba-49cb-8e86-08d966655ea6
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5129.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2021 18:39:42.0686 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SBLBNq5XAPT83LFlVtyxYvxRBcN9JahuGegp3kQLkKezIl0v+NbH8cte7vFw0LBzYJYRgUvT5dtVPVVOsHMa5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5132
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


Am 2021-08-19 um 9:37 a.m. schrieb David Yat Sin:
> Add support to existing CRIU ioctl's to save and restore events during
> criu checkpoint and restore.
>
> Signed-off-by: David Yat Sin <david.yatsin@amd.com>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 130 +++++++-----
>  drivers/gpu/drm/amd/amdkfd/kfd_events.c  | 253 ++++++++++++++++++++---
>  drivers/gpu/drm/amd/amdkfd/kfd_priv.h    |  25 ++-
>  3 files changed, 329 insertions(+), 79 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> index 19f16e3dd769..c8f523d8ab81 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> @@ -1008,51 +1008,11 @@ static int kfd_ioctl_create_event(struct file *filp, struct kfd_process *p,
>  	 * through the event_page_offset field.
>  	 */
>  	if (args->event_page_offset) {
> -		struct kfd_dev *kfd;
> -		struct kfd_process_device *pdd;
> -		void *mem, *kern_addr;
> -		uint64_t size;
> -
> -		if (p->signal_page) {
> -			pr_err("Event page is already set\n");
> -			return -EINVAL;
> -		}
> -
> -		kfd = kfd_device_by_id(GET_GPU_ID(args->event_page_offset));
> -		if (!kfd) {
> -			pr_err("Getting device by id failed in %s\n", __func__);
> -			return -EINVAL;
> -		}
> -
>  		mutex_lock(&p->mutex);
> -		pdd = kfd_bind_process_to_device(kfd, p);
> -		if (IS_ERR(pdd)) {
> -			err = PTR_ERR(pdd);
> -			goto out_unlock;
> -		}
> -
> -		mem = kfd_process_device_translate_handle(pdd,
> -				GET_IDR_HANDLE(args->event_page_offset));
> -		if (!mem) {
> -			pr_err("Can't find BO, offset is 0x%llx\n",
> -			       args->event_page_offset);
> -			err = -EINVAL;
> -			goto out_unlock;
> -		}
> +		err = kfd_kmap_event_page(p, args->event_page_offset);
>  		mutex_unlock(&p->mutex);
> -
> -		err = amdgpu_amdkfd_gpuvm_map_gtt_bo_to_kernel(kfd->kgd,
> -						mem, &kern_addr, &size);
> -		if (err) {
> -			pr_err("Failed to map event page to kernel\n");
> -			return err;
> -		}
> -
> -		err = kfd_event_page_set(p, kern_addr, size);
> -		if (err) {
> -			pr_err("Failed to set event page\n");
> +		if (err)
>  			return err;
> -		}
>  	}
>  
>  	err = kfd_event_create(filp, p, args->event_type,
> @@ -1061,10 +1021,7 @@ static int kfd_ioctl_create_event(struct file *filp, struct kfd_process *p,
>  				&args->event_page_offset,
>  				&args->event_slot_index);
>  
> -	return err;
> -
> -out_unlock:
> -	mutex_unlock(&p->mutex);
> +	pr_debug("Created event (id:0x%08x) (%s)\n", args->event_id, __func__);
>  	return err;
>  }
>  
> @@ -2208,6 +2165,41 @@ static int criu_dump_queues(struct kfd_process *p, struct kfd_ioctl_criu_dumper_
>  	return ret;
>  }
>  
> +static int criu_dump_events(struct kfd_process *p, struct kfd_ioctl_criu_dumper_args *args)
> +{
> +	struct kfd_criu_event_bucket *ev_buckets;
> +	uint32_t num_events;
> +	int ret =  0;
> +
> +	num_events = kfd_get_num_events(p);
> +	if (args->num_objects != num_events) {
> +		pr_err("Mismatch with number of events (current:%d user:%lld)\n",
> +							num_events, args->num_objects);
> +
> +	}
> +
> +	if (args->objects_size != args->num_objects *
> +				  (sizeof(*ev_buckets) + sizeof(struct kfd_criu_event_priv_data))) {
> +		pr_err("Invalid objects size for events\n");
> +		return -EINVAL;
> +	}
> +
> +	ev_buckets = kvzalloc(args->objects_size, GFP_KERNEL);
> +	if (!ev_buckets)
> +		return -ENOMEM;
> +
> +	ret = kfd_event_dump(p, ev_buckets, args->num_objects);
> +	if (!ret) {
> +		ret = copy_to_user((void __user *)args->objects, ev_buckets, args->objects_size);
> +		if (ret) {
> +			pr_err("Failed to copy events information to user\n");
> +			ret = -EFAULT;
> +		}
> +	}
> +	kvfree(ev_buckets);
> +	return ret;
> +}
> +
>  static int kfd_ioctl_criu_dumper(struct file *filep,
>  				struct kfd_process *p, void *data)
>  {
> @@ -2246,6 +2238,8 @@ static int kfd_ioctl_criu_dumper(struct file *filep,
>  		ret = criu_dump_queues(p, args);
>  		break;
>  	case KFD_CRIU_OBJECT_TYPE_EVENT:
> +		ret = criu_dump_events(p, args);
> +		break;
>  	case KFD_CRIU_OBJECT_TYPE_DEVICE:
>  	case KFD_CRIU_OBJECT_TYPE_SVM_RANGE:
>  	default:
> @@ -2676,6 +2670,40 @@ static int criu_restore_queues(struct kfd_process *p,
>  	return ret;
>  }
>  
> +static int criu_restore_events(struct file *filp, struct kfd_process *p,
> +			struct kfd_ioctl_criu_restorer_args *args)
> +{
> +	int ret = 0, i;
> +	uint8_t *objects, *private_data;
> +	struct kfd_criu_event_bucket *ev_buckets;
> +
> +	objects = kvzalloc(args->objects_size, GFP_KERNEL);
> +	if (!objects)
> +		return -ENOMEM;
> +
> +	ret = copy_from_user(objects, (void __user *)args->objects, args->objects_size);
> +	if (ret) {
> +		pr_err("Failed to copy event information from user\n");
> +		ret = -EFAULT;
> +		goto exit;
> +	}
> +
> +	ev_buckets = (struct kfd_criu_event_bucket *) objects;
> +	private_data = (void *)(ev_buckets + args->num_objects);
> +
> +	for (i = 0; i < args->num_objects; i++) {
> +		ret = kfd_event_restore(filp, p, &ev_buckets[i], private_data);
> +		if (ret) {
> +			pr_err("Failed to restore event (%d)\n", ret);
> +			goto exit;
> +		}
> +	}
> +
> +exit:
> +	kvfree(ev_buckets);
> +	return ret;
> +}
> +
>  static int kfd_ioctl_criu_restorer(struct file *filep,
>  				struct kfd_process *p, void *data)
>  {
> @@ -2698,6 +2726,8 @@ static int kfd_ioctl_criu_restorer(struct file *filep,
>  		ret = criu_restore_queues(p, args);
>  		break;
>  	case KFD_CRIU_OBJECT_TYPE_EVENT:
> +		ret = criu_restore_events(filep, p, args);
> +		break;
>  	case KFD_CRIU_OBJECT_TYPE_DEVICE:
>  	case KFD_CRIU_OBJECT_TYPE_SVM_RANGE:
>  	default:
> @@ -2799,9 +2829,13 @@ static int kfd_ioctl_criu_process_info(struct file *filep,
>  	args->queues_priv_data_size = queues_extra_data_size +
>  				(args->total_queues * sizeof(struct kfd_criu_queue_priv_data));
>  
> -	dev_dbg(kfd_device, "Num of bos:%llu queues:%u\n",
> +	args->total_events = kfd_get_num_events(p);
> +	args->events_priv_data_size = args->total_events * sizeof(struct kfd_criu_event_priv_data);
> +
> +	dev_dbg(kfd_device, "Num of bos:%llu queues:%u events:%u\n",
>  				args->total_bos,
> -				args->total_queues);
> +				args->total_queues,
> +				args->total_events);
>  err_unlock:
>  	mutex_unlock(&p->mutex);
>  	return ret;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_events.c b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
> index ba2c2ce0c55a..18362478e351 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_events.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
> @@ -53,9 +53,9 @@ struct kfd_signal_page {
>  	uint64_t *kernel_address;
>  	uint64_t __user *user_address;
>  	bool need_to_free_pages;
> +	uint64_t user_handle; /* Needed for CRIU dumped and restore */
>  };
>  
> -
>  static uint64_t *page_slots(struct kfd_signal_page *page)
>  {
>  	return page->kernel_address;
> @@ -92,7 +92,8 @@ static struct kfd_signal_page *allocate_signal_page(struct kfd_process *p)
>  }
>  
>  static int allocate_event_notification_slot(struct kfd_process *p,
> -					    struct kfd_event *ev)
> +					    struct kfd_event *ev,
> +					    const int *restore_id)
>  {
>  	int id;
>  
> @@ -104,14 +105,19 @@ static int allocate_event_notification_slot(struct kfd_process *p,
>  		p->signal_mapped_size = 256*8;
>  	}
>  
> -	/*
> -	 * Compatibility with old user mode: Only use signal slots
> -	 * user mode has mapped, may be less than
> -	 * KFD_SIGNAL_EVENT_LIMIT. This also allows future increase
> -	 * of the event limit without breaking user mode.
> -	 */
> -	id = idr_alloc(&p->event_idr, ev, 0, p->signal_mapped_size / 8,
> -		       GFP_KERNEL);
> +	if (restore_id) {
> +		id = idr_alloc(&p->event_idr, ev, *restore_id, *restore_id + 1,
> +				GFP_KERNEL);
> +	} else {
> +		/*
> +		 * Compatibility with old user mode: Only use signal slots
> +		 * user mode has mapped, may be less than
> +		 * KFD_SIGNAL_EVENT_LIMIT. This also allows future increase
> +		 * of the event limit without breaking user mode.
> +		 */
> +		id = idr_alloc(&p->event_idr, ev, 0, p->signal_mapped_size / 8,
> +				GFP_KERNEL);
> +	}
>  	if (id < 0)
>  		return id;
>  
> @@ -178,9 +184,8 @@ static struct kfd_event *lookup_signaled_event_by_partial_id(
>  	return ev;
>  }
>  
> -static int create_signal_event(struct file *devkfd,
> -				struct kfd_process *p,
> -				struct kfd_event *ev)
> +static int create_signal_event(struct file *devkfd, struct kfd_process *p,
> +				struct kfd_event *ev, const int *restore_id)
>  {
>  	int ret;
>  
> @@ -193,7 +198,7 @@ static int create_signal_event(struct file *devkfd,
>  		return -ENOSPC;
>  	}
>  
> -	ret = allocate_event_notification_slot(p, ev);
> +	ret = allocate_event_notification_slot(p, ev, restore_id);
>  	if (ret) {
>  		pr_warn("Signal event wasn't created because out of kernel memory\n");
>  		return ret;
> @@ -209,16 +214,22 @@ static int create_signal_event(struct file *devkfd,
>  	return 0;
>  }
>  
> -static int create_other_event(struct kfd_process *p, struct kfd_event *ev)
> +static int create_other_event(struct kfd_process *p, struct kfd_event *ev, const int *restore_id)
>  {
> -	/* Cast KFD_LAST_NONSIGNAL_EVENT to uint32_t. This allows an
> -	 * intentional integer overflow to -1 without a compiler
> -	 * warning. idr_alloc treats a negative value as "maximum
> -	 * signed integer".
> -	 */
> -	int id = idr_alloc(&p->event_idr, ev, KFD_FIRST_NONSIGNAL_EVENT_ID,
> -			   (uint32_t)KFD_LAST_NONSIGNAL_EVENT_ID + 1,
> -			   GFP_KERNEL);
> +	int id;
> +
> +	if (restore_id)
> +		id = idr_alloc(&p->event_idr, ev, *restore_id, *restore_id + 1,
> +			GFP_KERNEL);
> +	else
> +		/* Cast KFD_LAST_NONSIGNAL_EVENT to uint32_t. This allows an
> +		 * intentional integer overflow to -1 without a compiler
> +		 * warning. idr_alloc treats a negative value as "maximum
> +		 * signed integer".
> +		 */
> +		id = idr_alloc(&p->event_idr, ev, KFD_FIRST_NONSIGNAL_EVENT_ID,
> +				(uint32_t)KFD_LAST_NONSIGNAL_EVENT_ID + 1,
> +				GFP_KERNEL);
>  
>  	if (id < 0)
>  		return id;
> @@ -295,8 +306,8 @@ static bool event_can_be_cpu_signaled(const struct kfd_event *ev)
>  	return ev->type == KFD_EVENT_TYPE_SIGNAL;
>  }
>  
> -int kfd_event_page_set(struct kfd_process *p, void *kernel_address,
> -		       uint64_t size)
> +static int kfd_event_page_set(struct kfd_process *p, void *kernel_address,
> +		       uint64_t size, uint64_t user_handle)
>  {
>  	struct kfd_signal_page *page;
>  
> @@ -315,10 +326,55 @@ int kfd_event_page_set(struct kfd_process *p, void *kernel_address,
>  
>  	p->signal_page = page;
>  	p->signal_mapped_size = size;
> -
> +	p->signal_page->user_handle = user_handle;
>  	return 0;
>  }
>  
> +int kfd_kmap_event_page(struct kfd_process *p, uint64_t event_page_offset)

This function should be static. I also think that this function and
criu_dump/restore_events could be moved into kfd_events.c.

Regards,
  Felix


> +{
> +	struct kfd_dev *kfd;
> +	struct kfd_process_device *pdd;
> +	void *mem, *kern_addr;
> +	uint64_t size;
> +	int err = 0;
> +
> +	if (p->signal_page) {
> +		pr_err("Event page is already set\n");
> +		return -EINVAL;
> +	}
> +
> +	kfd = kfd_device_by_id(GET_GPU_ID(event_page_offset));
> +	if (!kfd) {
> +		pr_err("Getting device by id failed in %s\n", __func__);
> +		return -EINVAL;
> +	}
> +
> +	pdd = kfd_bind_process_to_device(kfd, p);
> +	if (IS_ERR(pdd))
> +		return PTR_ERR(pdd);
> +
> +	mem = kfd_process_device_translate_handle(pdd,
> +			GET_IDR_HANDLE(event_page_offset));
> +	if (!mem) {
> +		pr_err("Can't find BO, offset is 0x%llx\n", event_page_offset);
> +		return -EINVAL;
> +	}
> +
> +	err = amdgpu_amdkfd_gpuvm_map_gtt_bo_to_kernel(kfd->kgd,
> +					mem, &kern_addr, &size);
> +	if (err) {
> +		pr_err("Failed to map event page to kernel\n");
> +		return err;
> +	}
> +
> +	err = kfd_event_page_set(p, kern_addr, size, event_page_offset);
> +	if (err) {
> +		pr_err("Failed to set event page\n");
> +		return err;
> +	}
> +	return err;
> +}
> +
>  int kfd_event_create(struct file *devkfd, struct kfd_process *p,
>  		     uint32_t event_type, bool auto_reset, uint32_t node_id,
>  		     uint32_t *event_id, uint32_t *event_trigger_data,
> @@ -343,14 +399,14 @@ int kfd_event_create(struct file *devkfd, struct kfd_process *p,
>  	switch (event_type) {
>  	case KFD_EVENT_TYPE_SIGNAL:
>  	case KFD_EVENT_TYPE_DEBUG:
> -		ret = create_signal_event(devkfd, p, ev);
> +		ret = create_signal_event(devkfd, p, ev, NULL);
>  		if (!ret) {
>  			*event_page_offset = KFD_MMAP_TYPE_EVENTS;
>  			*event_slot_index = ev->event_id;
>  		}
>  		break;
>  	default:
> -		ret = create_other_event(p, ev);
> +		ret = create_other_event(p, ev, NULL);
>  		break;
>  	}
>  
> @@ -366,6 +422,147 @@ int kfd_event_create(struct file *devkfd, struct kfd_process *p,
>  	return ret;
>  }
>  
> +int kfd_event_restore(struct file *devkfd, struct kfd_process *p,
> +		      struct kfd_criu_event_bucket *ev_bucket,
> +		      uint8_t *priv_datas)
> +{
> +	int ret = 0;
> +	struct kfd_criu_event_priv_data *ev_priv;
> +	struct kfd_event *ev;
> +
> +	ev_priv = (struct kfd_criu_event_priv_data *)(priv_datas + ev_bucket->priv_data_offset);
> +
> +	if (ev_priv->user_handle) {
> +		ret = kfd_kmap_event_page(p, ev_priv->user_handle);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	ev = kzalloc(sizeof(*ev), GFP_KERNEL);
> +	if (!ev)
> +		return -ENOMEM;
> +
> +	ev->type = ev_priv->type;
> +	ev->auto_reset = ev_priv->auto_reset;
> +	ev->signaled = ev_priv->signaled;
> +
> +	init_waitqueue_head(&ev->wq);
> +
> +	mutex_lock(&p->event_mutex);
> +	switch (ev->type) {
> +	case KFD_EVENT_TYPE_SIGNAL:
> +	case KFD_EVENT_TYPE_DEBUG:
> +		ret = create_signal_event(devkfd, p, ev, &ev_priv->event_id);
> +		break;
> +	case KFD_EVENT_TYPE_MEMORY:
> +		memcpy(&ev->memory_exception_data,
> +			&ev_priv->memory_exception_data,
> +			sizeof(struct kfd_hsa_memory_exception_data));
> +
> +		ev->memory_exception_data.gpu_id = ev_bucket->gpu_id;
> +		ret = create_other_event(p, ev, &ev_priv->event_id);
> +		break;
> +	case KFD_EVENT_TYPE_HW_EXCEPTION:
> +		memcpy(&ev->hw_exception_data,
> +			&ev_priv->hw_exception_data,
> +			sizeof(struct kfd_hsa_hw_exception_data));
> +
> +		ev->hw_exception_data.gpu_id = ev_bucket->gpu_id;
> +		ret = create_other_event(p, ev, &ev_priv->event_id);
> +		break;
> +	}
> +
> +	if (ret)
> +		kfree(ev);
> +
> +	mutex_unlock(&p->event_mutex);
> +
> +	return ret;
> +}
> +
> +int kfd_event_dump(struct kfd_process *p,
> +		   struct kfd_criu_event_bucket *ev_buckets,
> +		   uint32_t num_events)
> +{
> +	struct kfd_event *ev;
> +	struct kfd_criu_event_priv_data *ev_privs;
> +	uint32_t ev_id;
> +	int i = 0;
> +
> +	/* Private data for first event starts after all ev_buckets */
> +	ev_privs = (struct kfd_criu_event_priv_data *)((uint8_t *)ev_buckets +
> +						   (num_events * (sizeof(*ev_buckets))));
> +
> +
> +	idr_for_each_entry(&p->event_idr, ev, ev_id) {
> +		struct kfd_criu_event_bucket *ev_bucket;
> +		struct kfd_criu_event_priv_data *ev_priv;
> +
> +		if (i >= num_events) {
> +			pr_err("Number of events exceeds number allocated\n");
> +			return -ENOMEM;
> +		}
> +
> +		ev_bucket = &ev_buckets[i];
> +
> +		/* Currently, all events have same size of private_data, but the current ioctl's
> +		 * and CRIU plugin supports private_data of variable sizes
> +		 */
> +		ev_priv = &ev_privs[i];
> +
> +		ev_bucket->priv_data_offset = i * sizeof(*ev_priv);
> +		ev_bucket->priv_data_size = sizeof(*ev_priv);
> +
> +		/* We store the user_handle with the first event */
> +		if (i == 0 && p->signal_page)
> +			ev_priv->user_handle = p->signal_page->user_handle;
> +
> +		ev_priv->event_id = ev->event_id;
> +		ev_priv->auto_reset = ev->auto_reset;
> +		ev_priv->type = ev->type;
> +		ev_priv->signaled = ev->signaled;
> +
> +		/* We store the gpu_id in the bucket section so that the userspace CRIU plugin can
> +		 * modify it if needed.
> +		 */
> +		if (ev_priv->type == KFD_EVENT_TYPE_MEMORY) {
> +			memcpy(&ev_priv->memory_exception_data,
> +				&ev->memory_exception_data,
> +				sizeof(struct kfd_hsa_memory_exception_data));
> +
> +			ev_bucket->gpu_id = ev_priv->memory_exception_data.gpu_id;
> +		} else if (ev_priv->type == KFD_EVENT_TYPE_HW_EXCEPTION) {
> +			memcpy(&ev_priv->hw_exception_data,
> +				&ev->hw_exception_data,
> +				sizeof(struct kfd_hsa_hw_exception_data));
> +
> +			ev_bucket->gpu_id = ev_priv->hw_exception_data.gpu_id;
> +		} else
> +			ev_bucket->gpu_id = 0;
> +
> +		pr_debug("Dumped event[%d] id = 0x%08x auto_reset = %x type = %x signaled = %x\n",
> +			  i,
> +			  ev_priv->event_id,
> +			  ev_priv->auto_reset,
> +			  ev_priv->type,
> +			  ev_priv->signaled);
> +		i++;
> +	}
> +	return 0;
> +}
> +
> +int kfd_get_num_events(struct kfd_process *p)
> +{
> +	struct kfd_event *ev;
> +	uint32_t id;
> +	u32 num_events = 0;
> +
> +	idr_for_each_entry(&p->event_idr, ev, id)
> +		num_events++;
> +
> +	return num_events++;
> +}
> +
>  /* Assumes that p is current. */
>  int kfd_event_destroy(struct kfd_process *p, uint32_t event_id)
>  {
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> index 7ed6f831109d..bf10a5305ef7 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> @@ -1069,9 +1069,26 @@ struct kfd_criu_queue_priv_data {
>  };
>  
>  struct kfd_criu_event_priv_data {
> -	uint64_t reserved;
> +	uint64_t user_handle;
> +	uint32_t event_id;
> +	uint32_t auto_reset;
> +	uint32_t type;
> +	uint32_t signaled;
> +
> +	union {
> +		struct kfd_hsa_memory_exception_data memory_exception_data;
> +		struct kfd_hsa_hw_exception_data hw_exception_data;
> +	};
>  };
>  
> +int kfd_event_restore(struct file *devkfd, struct kfd_process *p,
> +		      struct kfd_criu_event_bucket *ev_bucket,
> +		      uint8_t *priv_datas);
> +
> +int kfd_event_dump(struct kfd_process *p,
> +		   struct kfd_criu_event_bucket *ev_buckets,
> +		   uint32_t num_events);
> +
>  /* CRIU - End */
>  
>  /* Queue Context Management */
> @@ -1238,12 +1255,14 @@ void kfd_signal_iommu_event(struct kfd_dev *dev,
>  void kfd_signal_hw_exception_event(u32 pasid);
>  int kfd_set_event(struct kfd_process *p, uint32_t event_id);
>  int kfd_reset_event(struct kfd_process *p, uint32_t event_id);
> -int kfd_event_page_set(struct kfd_process *p, void *kernel_address,
> -		       uint64_t size);
> +int kfd_kmap_event_page(struct kfd_process *p, uint64_t event_page_offset);
> +
>  int kfd_event_create(struct file *devkfd, struct kfd_process *p,
>  		     uint32_t event_type, bool auto_reset, uint32_t node_id,
>  		     uint32_t *event_id, uint32_t *event_trigger_data,
>  		     uint64_t *event_page_offset, uint32_t *event_slot_index);
> +
> +int kfd_get_num_events(struct kfd_process *p);
>  int kfd_event_destroy(struct kfd_process *p, uint32_t event_id);
>  
>  void kfd_signal_vm_fault_event(struct kfd_dev *dev, u32 pasid,
