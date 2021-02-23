Return-Path: <SRS0=GAon=HZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7852DC433E0
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Feb 2021 22:45:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 311ED64E57
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Feb 2021 22:45:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 311ED64E57
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9D2B26E870;
	Tue, 23 Feb 2021 22:45:21 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2060.outbound.protection.outlook.com [40.107.94.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 802E36E870
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Feb 2021 22:45:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NJoABs8Koew3R+8p9u3ucULLPVjYDQe2T70y7EU0DLUGBPfsspbrpbQHpnEw0zE07jw2zJJHGz23Jav45S3UkU24rjOcm0FfyuG/eramqCF+jfeBKuUAyJcFe7BWDE999kMTnll6T6dw+IsIKx19ohTtEUTklzOYbSOw9ZwtNuwkI3A06TfhdIaz8+wPIMuDkPUJpN5dTf5lRa8TB1a+lJ2e5lxBxOUFqBWwBdo4n3zN4YNNFR9AGfPBtKS/dZyHHyJpS+xYMDq141IfroF6Mio8S+lijDIqbkaToukmqmLbmZHRPzeL1FiVldlklPvIl4j5kSymsqVvF16pQYZP/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H9dwONwM53Dm8h+EpCWfO+mSfouefm8m1LWEFrBpILY=;
 b=I9wPrYvJs9yZmK8g5pRo4vjb7J7gJVx63JjXxtAs1ID5zESanCL8LV4mxNNSsnAXxFZr2KJcQA8F2qn6gcaHTJMWnPo1O4AS2jeUrisgM1bqUQ0oStwCd4z0wShI+UuqUWsG/Kf3S4qsgTcvZZcdYVLF6sa0ZVNxn1hmrtqmgSB0hwDHCVHSkHXBuBdMtpCpkkX7+YRxO4J765qIDL3lk/ka/WkQgU8qX7ncv2ovI+hw999ySZ9SYCck7EgiFZqzFDlQXrUNG+czISQYs0B8Wga5tFG2pwlX+ikO8jExqhCHTfXnTAo1aaVPFi3TP9RpXLJbG/zO3xvRzHRM9PCnlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H9dwONwM53Dm8h+EpCWfO+mSfouefm8m1LWEFrBpILY=;
 b=Wd/NoalnxzC3nYPy7FtExJNzxA83ui92lU/06hgRm0+4n/HFc51hrtjqlLN/nzBcUzTUu4nN52e0Qeu18XU9PTKQks+Iax6AV5uFMazMCigbULQPbbymbTu9V5ZLz3Egjblp1jZdRmN69+Iurpkp/nMH/xvk35pp6SsfrOYDgxg=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB4623.namprd12.prod.outlook.com (2603:10b6:805:e9::17)
 by SN6PR12MB2813.namprd12.prod.outlook.com (2603:10b6:805:69::27)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.29; Tue, 23 Feb
 2021 22:45:18 +0000
Received: from SN6PR12MB4623.namprd12.prod.outlook.com
 ([fe80::41b1:11f5:fd1e:fc5f]) by SN6PR12MB4623.namprd12.prod.outlook.com
 ([fe80::41b1:11f5:fd1e:fc5f%5]) with mapi id 15.20.3868.033; Tue, 23 Feb 2021
 22:45:18 +0000
Subject: Re: [PATCH] drm/amdgpu: add ih call to process until checkpoint
To: Jonathan Kim <jonathan.kim@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210223211026.116403-1-jonathan.kim@amd.com>
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Message-ID: <c8f2c2ba-e284-7194-e04c-2a5faf53297a@amd.com>
Date: Tue, 23 Feb 2021 17:45:15 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20210223211026.116403-1-jonathan.kim@amd.com>
Content-Language: en-US
X-Originating-IP: [2607:fea8:3edf:49b0:994a:4dd2:59a:30]
X-ClientProxiedBy: YTOPR0101CA0055.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::32) To SN6PR12MB4623.namprd12.prod.outlook.com
 (2603:10b6:805:e9::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2607:fea8:3edf:49b0:994a:4dd2:59a:30]
 (2607:fea8:3edf:49b0:994a:4dd2:59a:30) by
 YTOPR0101CA0055.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:14::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.31 via Frontend
 Transport; Tue, 23 Feb 2021 22:45:17 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d1324c25-6381-40ff-c65e-08d8d84cb138
X-MS-TrafficTypeDiagnostic: SN6PR12MB2813:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB2813DB8C24E486C59AF6832DEA809@SN6PR12MB2813.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o4L+aMM8FQHpFdN8HjhOvFMquUcQr8F5MFtyaFAXzHpM3VoK6m8iaNmglixGdRNyM30iwlDieRWeRYOwlacoVDkKG6z7QUgJc/ey1esRgIhOrwnV6mGh8t6j3xeO+lkbSXh+491X/4gzGMXNChOc2zM4Eq/fYa8U0cGxsdEskdQdzKH8tIP3SUruXhBRI3uKC7HI61hdiAAMWIUbQgTU+MDtq9NJuCHlZJUzgce8jdVBJONlrZbFXhPvm3eeOuRJztGoZa1Q3lrYaqCWCzzVYBfN8bEJOgK18Ty0wq7yNja3GSK6M243GlhE+J+E0etwOtx3Y6HxtQhRqNF9DdLvR8mP3z9YDhCD4BTJ5IZcFRAUXk6l/pCdVEF08aYPC9xzxmwNUXBFtSU2LccWYyt9NrmimVrMU+e6M/DjMiJVy72SwFUS/7DDI/2QLs/NQWgVdbbIGoQ21NPJAxoifa8E73v+7Qhb9MBSjLvN1LIUnlo65wixqaMgqOYKzH/d8StAp7ltoaMpJvcBStnyPDWQr+hmx1VnhVu5W+IRUsFYg5y6xfAlPidfjLio5+wePcdJu5PPGI+Ue+VOCTQQ2unXx4PJWhwR07RA8NitG9HwMIM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR12MB4623.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(366004)(39850400004)(376002)(346002)(136003)(8936002)(53546011)(4326008)(52116002)(186003)(44832011)(36756003)(31686004)(66476007)(5660300002)(86362001)(2906002)(16526019)(66556008)(478600001)(316002)(8676002)(2616005)(83380400001)(31696002)(6486002)(66946007)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?dEZuNTlKQk15ZVM5UXdScGsza1Roa1dqc3ZlU0VGNVpCakF6eXFKR1NWN1Zt?=
 =?utf-8?B?VjdvTzlCNklmSEkvUmxBWlFmRGhHWndTMGV4dWVnTGkvczh0OGlmaGZpdkM4?=
 =?utf-8?B?Z1hiZkFXTjRBNVpVanJrRGVmK2ZRb1E5TjAvVkFFVlNBcFRGQzQ2M2RkeGNI?=
 =?utf-8?B?QTVSVkQyTzJFemJMd0plRWl5WjB3bTlnVnBhQ2RPK3Jzdytxa3BlZGtmUTFq?=
 =?utf-8?B?ZjZISWFoYk93RlZFL3dtMjg0SStBc1pEbjJKT1FXeWxrY2h6RXQwQ2NIMVNk?=
 =?utf-8?B?L0ZTbHYva1J2M0JPUFpJVDF0UWliMUNBejljZUlxVThKNncxYmFVdHFSaUp3?=
 =?utf-8?B?eG85SnJZRG9aREdUbXdUSmQwdDRtL1oxRWNlWllvMDBFUDN6d1dGKzFCQno1?=
 =?utf-8?B?RTZTcGorOTlhcFh5SFVCeUhIS2YwZSs5Ym9HYm9xVWRkdlgwaDdaTXlxM1BK?=
 =?utf-8?B?UDFsMjNYOXIyMHZnZ2c5VW5PNGRVd2lwVHA5d2VpQ1pHZGRWT2VrbzZVaUJo?=
 =?utf-8?B?YmpJMzJEaFNHalNFQzJCL21aNTRNbDkyR1hXWUh4TlVjamJyVU5ndkhMejBj?=
 =?utf-8?B?ZEpPM2pTWHplaFJ2cUhYUFRkQ3l1UjJzcThVRzByMWlMOUZCUDEyZm54cUZV?=
 =?utf-8?B?ekhTUGNjc1ExSnRHL2I4VldGKytMUTVmL0U3RWNnbC9JdjlZeFEwVnZpWmcx?=
 =?utf-8?B?VnVGZFQyUHJ3YjNCZWtqUzNNc0RZMGxpM01OQ3BtSXFaOEFHVjlzdEFzQ3Nj?=
 =?utf-8?B?K1pjd1Yxa3dJR0xFakp6U25qYnB4ZHZYY0E3UVFoaVpuN1pIVG55NC8reVRI?=
 =?utf-8?B?TEErOHhZdk5vU2l3UUwxL09hZTFZempKQmNjcGgveXNCL01uMjZWQTI2REt2?=
 =?utf-8?B?NTVua0toMkhkdEtYNjBPTlZBZXd6K0t3UmJETnRUbnRnL0VUSmNnWkxoZTlp?=
 =?utf-8?B?dHJxOGtlZkNUVDZYWURDN1hwZFR6aXNPQi9xdUZPazVDQ3VSTSt5YmhidWtx?=
 =?utf-8?B?ZXBRUEJPVWhTQi9WTlR5WVArMmU0OGFGMG9RZUV1R1E4NWhTaG4yaGJGaTc5?=
 =?utf-8?B?ZG9oOVlzZTJlS2kyZy9mM1BOOHhjRDUvcjhSZHBESkFRY3U0T1cyMVhxRW5Y?=
 =?utf-8?B?ZzIvUDVNRVNrOGwyUmIyNjRYM2N3d2YzT3c2cHRkYkt1QVpwMkdkQ0wxY1F3?=
 =?utf-8?B?MWdkUURsQm1BT2xYbGFreVVjR1dzZUN5RENvRjVrNzRDdDk5dGFkdVVpMXRM?=
 =?utf-8?B?b2RlYVMzS2haaTNKc2pmU0laSmhQMmRoWlpSRUhyVm5yMVFkMTMvK0xxSWl4?=
 =?utf-8?B?aWR5ZmRVTERIcERPazk4aHFUN3g4VnNlZXJQT0FCd21HdUcwTE1BTVdyZTZy?=
 =?utf-8?B?VzhrdW9nSmk2NGs5UXBGYzFCTGZibG5lTndzTVZQb0VjWk9ubllzdmUyc2xC?=
 =?utf-8?B?TTE1N05INDRVa0JRdlVkUlN4U25JYW1INi9BWExHdG9oMTZETjBtcWJWWDhy?=
 =?utf-8?B?SmVsbmpMVXVhYnpaRTlJSUZjbENqV084dUV2V0pyQzRGY1lybHozdTBhZUt1?=
 =?utf-8?B?cnQ0eU95aEZUaW9WbUFsNjlMY1ZhWnJ3NVdBZ2g2bUFRWlgvWCtHYUtjYkhx?=
 =?utf-8?B?T0dNeWdKdytVdmhNdDhUS2YrMndORGoxU2FqVGgvTkpVR0NyZGJmcUtuZkFp?=
 =?utf-8?B?N0dpeWthNG9CdVI1T2FtbGJrWm56UDlJMVViSXdZZHA0NklySUlVcGcvMWNn?=
 =?utf-8?B?WU85c0UxMHhCQ2tVT2JrQ3ZkdFZybTlQS3FEOXdROVFRa0VsemNSWWZQU0pJ?=
 =?utf-8?B?eGx4QnNsKzEzd1VmSlBhYTI1OGhodC9WSVZKZVVkajhQYWdoYjlRRXlYaW1K?=
 =?utf-8?Q?ouGFsEucM6J3w?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1324c25-6381-40ff-c65e-08d8d84cb138
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB4623.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2021 22:45:18.7450 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l9krNYy5LDPjPN/6FQ0u89I8tmez6fkYRPFuguVUZuuAFe6Idk9S0/vY1Cb4X2MIoY/hrIoVLrIl6VAAcfHKOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2813
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
Cc: Philip.Yang@amd.com, Felix.Kuehling@amd.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 2021-02-23 4:10 p.m., Jonathan Kim wrote:
> Add IH function to allow caller to process ring entries until the
> checkpoint write pointer.
>
> Suggested-by: Felix Kuehling <felix.kuehling@amd.com>
> Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c | 46 +++++++++++++++++++++++++-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h |  2 ++
>   2 files changed, 47 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c
> index dc852af4f3b7..cae50af9559d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c
> @@ -22,7 +22,7 @@
>    */
>   
>   #include <linux/dma-mapping.h>
> -
> +#include <linux/processor.h>
>   #include "amdgpu.h"
>   #include "amdgpu_ih.h"
>   
> @@ -160,6 +160,50 @@ void amdgpu_ih_ring_write(struct amdgpu_ih_ring *ih, const uint32_t *iv,
>   	}
>   }
>   
> +/**
> + * amdgpu_ih_wait_on_checkpoint_process - wait to process IVs up to checkpoint
> + *
> + * @adev: amdgpu_device pointer
> + * @ih: ih ring to process
> + *
> + * Used to ensure ring has processed IVs up to the checkpoint write pointer.
> + */
> +int amdgpu_ih_wait_on_checkpoint_process(struct amdgpu_device *adev,
> +					struct amdgpu_ih_ring *ih)
> +{
> +	u32 prev_rptr, cur_rptr, checkpoint_wptr;
> +
> +	if (!ih->enabled || adev->shutdown)
> +		return -ENODEV;
> +
> +	cur_rptr = READ_ONCE(ih->rptr);
> +	/* Order read of current rptr with checktpoint wptr. */
> +	mb();
> +	checkpoint_wptr = amdgpu_ih_get_wptr(adev, ih);
> +


Isn't rmb() enough in this case ? If I understand correctly you just 
want to confirm that
you are not reading stale checkpoint_wptr while reading fresh cur_rptr.

Andrey


> +	/* allow rptr to wrap around  */
> +	if (cur_rptr > checkpoint_wptr) {
> +		spin_begin();
> +		do {
> +			spin_cpu_relax();
> +			prev_rptr = cur_rptr;
> +			cur_rptr = READ_ONCE(ih->rptr);
> +		} while (cur_rptr >= prev_rptr);
> +		spin_end();
> +	}
> +
> +	/* wait for rptr to catch up to or pass checkpoint. */
> +	spin_begin();
> +	do {
> +		spin_cpu_relax();
> +		prev_rptr = cur_rptr;
> +		cur_rptr = READ_ONCE(ih->rptr);
> +	} while (cur_rptr >= prev_rptr && cur_rptr < checkpoint_wptr);
> +	spin_end();
> +
> +	return 0;
> +}
> +
>   /**
>    * amdgpu_ih_process - interrupt handler
>    *
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h
> index 6ed4a85fc7c3..6817f0a812d2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h
> @@ -87,6 +87,8 @@ int amdgpu_ih_ring_init(struct amdgpu_device *adev, struct amdgpu_ih_ring *ih,
>   void amdgpu_ih_ring_fini(struct amdgpu_device *adev, struct amdgpu_ih_ring *ih);
>   void amdgpu_ih_ring_write(struct amdgpu_ih_ring *ih, const uint32_t *iv,
>   			  unsigned int num_dw);
> +int amdgpu_ih_wait_on_checkpoint_process(struct amdgpu_device *adev,
> +					struct amdgpu_ih_ring *ih);
>   int amdgpu_ih_process(struct amdgpu_device *adev, struct amdgpu_ih_ring *ih);
>   void amdgpu_ih_decode_iv_helper(struct amdgpu_device *adev,
>   				struct amdgpu_ih_ring *ih,
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
