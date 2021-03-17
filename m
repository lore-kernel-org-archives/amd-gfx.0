Return-Path: <SRS0=2fSF=IP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACBD9C433E0
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Mar 2021 07:56:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA7A064E41
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Mar 2021 07:55:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA7A064E41
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A48576E4DD;
	Wed, 17 Mar 2021 07:55:59 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2083.outbound.protection.outlook.com [40.107.220.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3CFE46E4DD
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Mar 2021 07:55:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iCIsh97chWEGhO/W7LNk9jUU10E4VEZwaW9w4i6BNg/OD5fr46vY293L0KZ9uyHRXFXGn08x62sRjM5vqEDYnx/qWqYuLuruT46FevjkuLU96O4y9KiDbEsj5DAuDo4pDs3QNyiVprmhXE5LPLaMPVI+a5oF+BQhzuo5Z8sSkgvXWV1zdG/pPZDervwdd7sEgDIDGbXeIGM4cR9uUz9HT5mOyiv/9bHEaXz2OaSplhlFsR0pPvRz3M0eiUy5RCAgsgwUpVZ1M5mGmS3BreMadcHpdNxO2tpSQMDSzNtpd2qiVLpXyHPOwNG0yMip440EqkrEI8m+0NRiZbaC7AiMiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aF69InZUx9wiBj0JeO4lJAxF1bJBCMNKuj1nrr28J1g=;
 b=kx7UZio5C2VVOWBMlrk6w/goxUc2Ds2ioNNGUsqX6dRN0rPnVqyArIUBx4KqKIpQL8/YK32Jp717s/ucFnGteSIuhA0KP3U/buN1Fhm8djsIEq2HBObopSt5JwF3EZAaVlMiLl+u9TIY7xyaTcjmfWF3P1/Zy5ftH4KEXFGVBOACbE4D2U1ECYuFIcLhSDc96uROuXPAVJWo90S5SGBN91s206A0QOFlCUmcc/LDX5G3+dKEkOzJj/29h148dGNTOPEgHj8g5B6uDt2mOGunj3HvnFB7R4w2jXqiVI3pV/KizuLUL+hrHVvTLvssT1GesgubnNtrd/YrVLzZ+kihzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aF69InZUx9wiBj0JeO4lJAxF1bJBCMNKuj1nrr28J1g=;
 b=UF58cpzj6R7XW+P4N+XMlPugUMNwvrr2GwUcd+A9CvmpRCLDi6yYKXqXnU4YnarDtqzFXSROHECdgVhXkqrNJ6a+0XRGRvIKUA25KrEucvXdiEHuKrv94p5QgcYRe+fq0ON21TLCsT76oWAQ02auH4zkFSooqAWa9zwUPRMTCfc=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB4336.namprd12.prod.outlook.com (2603:10b6:208:1df::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.32; Wed, 17 Mar
 2021 07:55:54 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::c1ff:dcf1:9536:a1f2]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::c1ff:dcf1:9536:a1f2%2]) with mapi id 15.20.3933.032; Wed, 17 Mar 2021
 07:55:54 +0000
Subject: Re: [PATCH] radeon: use kvcalloc for relocs and chunks
To: Chen Li <chenli@uniontech.com>, amd-gfx@lists.freedesktop.org
References: <87czvyz4dd.wl-chenli@uniontech.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <03eefbb1-4d33-8a96-a53c-df1654a7d3f6@amd.com>
Date: Wed, 17 Mar 2021 08:55:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <87czvyz4dd.wl-chenli@uniontech.com>
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:ccdd:b6ca:11e:5cc5]
X-ClientProxiedBy: AM9P195CA0008.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:21f::13) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:ccdd:b6ca:11e:5cc5]
 (2a02:908:1252:fb60:ccdd:b6ca:11e:5cc5) by
 AM9P195CA0008.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:21f::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3955.18 via Frontend Transport; Wed, 17 Mar 2021 07:55:52 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b3866359-fc7a-415c-f40b-08d8e91a16d6
X-MS-TrafficTypeDiagnostic: MN2PR12MB4336:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4336EC19BF0C91F9197E51D5836A9@MN2PR12MB4336.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IQju41iOskCRJq7R31wOQdYgehKCwttyQ8dCNwCsmafIl3DYLU0ciZ0rgYld0huRW+0Scq+yTU/T/MqwrLak1jjEAxi9Gc4w30QZlp8ZHhjS3+KMp8usNGBgBectTJr/PQFwRwEbc0tfSeuResRGD6ORKfsfcrp6+GX1t0ZpidbOI9Pq4mhDAgohIquX6oiyTflhxVM5Ibu2YwAfGEV2SBOa6qaJWPe2UVWX8tgvirsaEHYftl/RQM7Opwe02uxxgo+T021coiIH9ENY9YVNqaNvoqoQcGunuKS7mzmI4guB03j50bGiuM4CKfhYLYWvvPZO+LD1GoKagQlB3o8Unmf3BJbdfSoefhotsDYGWZQfeqPHrBMVoqzGWwFytddPShopdmB224UYiQ6PI0u2Bwx3Oro/En0mAhLNkIDJ9vKAWOx55zOj5wBRNUMMQjoXKxjHvGKXtWQSmYO6QXD6LztY7YlSHAxBGKXElk/3+O1mJuLTbX52t2Nh2ZG7unZVM9EFABTWVF9TiKOAKi5c7Tccsol1NS19CvP89FiJGHqEQDR93QhtXP4Qa5fH0H5HHZ4fpbWslXNRVPPUy/EYWnX5P+OCH9FmUSzFqHvJoHKMfyQ0oKnWKGt5FnkUyA0nXJ7B8+9sNo1dp2C+4GCyJA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(396003)(376002)(39860400002)(136003)(346002)(8936002)(52116002)(6486002)(5660300002)(6666004)(31696002)(16526019)(66476007)(2906002)(83380400001)(66946007)(8676002)(66556008)(2616005)(31686004)(186003)(86362001)(36756003)(316002)(4326008)(478600001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?VS9Yalk3a2dXc3VwaFIyYmtxTS9rV3F5V1dOZi9zWjlvR2VhUG8xdWxQSzU4?=
 =?utf-8?B?QTdwSzVVRnJic2xreEhzcVh5T1UzM1ZwSXVmNEhwdi96T0lERHpzL01ORDYx?=
 =?utf-8?B?citxa1ozdWhubVM5T0ZqVDAzalh4Q2NhbE5veTdTRi96SnU3dzRvTzFsMWY5?=
 =?utf-8?B?Vlh2a2tOSHE3MTVDaWJsR21haU9SNFI3MStPdy9manhkcTA1TWtDWXhCU3Nt?=
 =?utf-8?B?cUJwYmhQSkpKNUNEcWNzclV3QWpuclJybHFKakFmREtHanZzdWtMVUxkRTE4?=
 =?utf-8?B?bGw1TGV4K0V6UEdBcjdHekoyWmJyREJKMmpHTmZud1R6Nmp5dlhEWVdpcHJT?=
 =?utf-8?B?SEl5aVFkRVc1ZENaemU5elIycExUdWkrRjFsMmJZWVRxV3VEdzkyNTVZdUNp?=
 =?utf-8?B?OUY0SkhXQy8zaW5qQUhHZXBVUEhlc3hva0ZPMTZtWE5YdjIxMGJ0MVdoc051?=
 =?utf-8?B?SUpVamh1UzdFTVdIeDhlVmJZUWpTSFd0ZnpWcHFhRWhRSC9pZGYxK3EvcjRD?=
 =?utf-8?B?RGN2Wk9SMDlMWUZMSXpSYWR4b1dwU0gvYllGOXVJaTFyNkxoZ0dTaEpvM1hk?=
 =?utf-8?B?azljSjQ3UGtXZi9JSTRCaDVsQmE4NENCYzcreWFDTzJTY0N1YnJZL0VuWGFL?=
 =?utf-8?B?SUJmdlUwNW8ycWU1WGpTczVGTlluN3VuTTk5RUNWN1ZGazhRQnBJbGVvRG1B?=
 =?utf-8?B?NXYreHhvM3RKbEpleUVnNmVpcTJMRjhQTmFESTZiQnBicE1CRTZrVU9NVHhz?=
 =?utf-8?B?UksvOGROY0I1T0tyZU5hUWtaOUtMVUtRMXF0QnJDZlp4VHpzbjdPTlVTbWpR?=
 =?utf-8?B?UC9XLytYTDlaclhuc0V0ZGVwMlY3Y2FUZDZqWGpJTGJ2RXlVWGM4bm81QjV2?=
 =?utf-8?B?S1l3RndCS29Pb1M1LzdOMEhjbkIxS1lXZWJCTjY0VmlWaGYySzNLQjhmcXRK?=
 =?utf-8?B?WFZvc1MxNFh1TjlaeGNhQ3M0T1hGOThHRzlMQkFBVkpnYkFpOXN2N245aXpP?=
 =?utf-8?B?RHk2QSsxcnNIeThPT2VkQ1NEaG9BeStLSlhTY2JJQTNvVFRjK043V3JKbUV3?=
 =?utf-8?B?YXhwdEw0UFJhcVlzREFiVW9BWXpvSFNjajJ3aUJvcmt5WDlGRU0vWXl0dnZU?=
 =?utf-8?B?WDUxeW1ySmczWlk4MXRlTzJlTU81UVdXa25IT3BXa3psQi8wTGxiZWVrNnRO?=
 =?utf-8?B?SFdOQ0dQU3h0dEQ5eGg0UDJGQ1kxWW1tR3RRTDRKMnQ3UnBKNkZjUTYwQnZl?=
 =?utf-8?B?NjA0bGdyWHhpLzRkUjBuMjA5Y1RvSDkrVDhvRzV1OTA0UVRRU2FsNkp2Vkow?=
 =?utf-8?B?ZkZVbmxIdkhQSFNMcGluZndmUUpyNmY5U0d2dkhSOEhDdWVMTkVYMDNzYk1N?=
 =?utf-8?B?QnlHZGpRcVJRejNZMTY3TjZiNmROckdpN1hvQzJLdiszMTdSWG45Sll3NTZ4?=
 =?utf-8?B?L0QwY3ZsbVAyRkp3cUYvZUZMODhXNytMQWFJRElCbFBsRm02RGV1ckVGM3VD?=
 =?utf-8?B?SkpValN0UG12VGpZM292RmhDSlJJVkNMQTg0UGdsdGd4TmNRRWQyTXNVOGFo?=
 =?utf-8?B?eEpsSVk4aWt1UGlZMnhJeUJrQndPOFVqREZ5OWwxZnBDYVBYOEJzYnNWaHlz?=
 =?utf-8?B?SHp3WEVDNUc0MTZvOWRIb3c0TGlRSnZxVGJNajRnU21WcldpRGlnL1BTcTlm?=
 =?utf-8?B?TmErWUxaNStnYXBBeUVOS1BMRFFlRDROUWZreGlpNDVFN001c0Y4QmFURDhF?=
 =?utf-8?B?VWhGanJuanl3RW8wTXpEbnNEelQyVVhzNjU3YnlFU2MremVqY0V1RmNXZE9K?=
 =?utf-8?B?MWRKa1h2ZG1pQ0dvbWVzdllRMGxUclRtNUVmVDNjZGp3eUNRQUdiMlQ0QXdU?=
 =?utf-8?Q?infOQJgcKTnhq?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3866359-fc7a-415c-f40b-08d8e91a16d6
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2021 07:55:54.5656 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VWxSIEDNtbRPv0D84RoXO5lmfQv9bqzq36LIIK10EhTeWc9zymk0J53SGE78N9yW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4336
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 17.03.21 um 07:22 schrieb Chen Li:
> kvmalloc_array + __GFP_ZERO is the same with kvcalloc.
>
> As for p->chunks, it will be used in:
> ```
> if (ib_chunk->kdata)
> 		memcpy(parser->ib.ptr, ib_chunk->kdata, ib_chunk->length_dw * 4);
> ```
>
> If chunks doesn't zero out with __GFP_ZERO, it may point to somewhere else, e.g.,
> ```
> Unable to handle kernel paging request at virtual address 0000000000010000
> ...
> pc is at memcpy+0x84/0x250
> ra is at radeon_cs_ioctl+0x368/0xb90 [radeon]
> ```
>
> after allocating chunks with __GFP_KERNEL/kvcalloc, this bug is fixed.

NAK to zeroing the chunks array.

That array should be fully initialized with data before using it, 
otherwise we have a much more serious bug and zeroing it out only papers 
over the real issue.

How did you trigger the NULL pointer deref above?

Thanks,
Christian.

> Signed-off-by: Chen Li <chenli@uniontech.com>
> ---
>   drivers/gpu/drm/radeon/radeon_cs.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/radeon/radeon_cs.c b/drivers/gpu/drm/radeon/radeon_cs.c
> index fb736ef9f9aa..059431689c2d 100644
> --- a/drivers/gpu/drm/radeon/radeon_cs.c
> +++ b/drivers/gpu/drm/radeon/radeon_cs.c
> @@ -93,8 +93,8 @@ static int radeon_cs_parser_relocs(struct radeon_cs_parser *p)
>   	p->dma_reloc_idx = 0;
>   	/* FIXME: we assume that each relocs use 4 dwords */
>   	p->nrelocs = chunk->length_dw / 4;
> -	p->relocs = kvmalloc_array(p->nrelocs, sizeof(struct radeon_bo_list),
> -			GFP_KERNEL | __GFP_ZERO);
> +	p->relocs = kvcalloc(p->nrelocs, sizeof(struct radeon_bo_list),
> +			GFP_KERNEL);
>   	if (p->relocs == NULL) {
>   		return -ENOMEM;
>   	}
> @@ -299,7 +299,7 @@ int radeon_cs_parser_init(struct radeon_cs_parser *p, void *data)
>   	}
>   	p->cs_flags = 0;
>   	p->nchunks = cs->num_chunks;
> -	p->chunks = kvmalloc_array(p->nchunks, sizeof(struct radeon_cs_chunk), GFP_KERNEL);
> +	p->chunks = kvcalloc(p->nchunks, sizeof(struct radeon_cs_chunk), GFP_KERNEL);
>   	if (p->chunks == NULL) {
>   		return -ENOMEM;
>   	}

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
