Return-Path: <SRS0=4FJE=CL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,RCVD_ILLEGAL_IP,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C745C43461
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Sep 2020 17:14:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B78342071B
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Sep 2020 17:13:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="kqA5lU/S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B78342071B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C7D16E06E;
	Wed,  2 Sep 2020 17:13:59 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2054.outbound.protection.outlook.com [40.107.243.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9AEF26E06E
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Sep 2020 17:13:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jSxkp9xkKkTTTnYKHPG4zXPH2u5v0QL6H66FvT4Gdce3k63L4B6N042Dqux3R3aGB5ddBLcgtgIwYAY28F62m5p3wdWwsr+Luk2xqHGc+fmKh6/gf2hq8qf5cKt6cz4yCMy4kTx+DKvTvpNKTLiZX5+Mkp9xVVI7ZUvhlSCnLK5NT+rUvKCiMWP7psoF70zAGHQRYpakKD+ZttezsAmTdGiLnKvnm9f+t6r5xvYdktdkpDMZee8dYYiwdp36NIZevGGhG8irTmvBZv4zOm9iXJu4epnMYQoTc+7uUbfRPBteIqV+y81qdiU31wZax5p1Us6PAYSkjt3TeUabbeUfHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tQvRoGcC9xqyyfjJSfWyGps7pCz04HSVkDwJEqennyI=;
 b=DPHnMRkCLw3gEi4sKatS4Zwyap9Fcj8Faowmm5GdtuN2ePZ1kbdMFSpTNykOBHe0zz6o14TNmAZ9o5jzP8cDOkTapZNFcyQsmXFjEUp2jBNSJxbixnJmEGd77tObqccpvXvcqkF/Fd41d6HdCZ8aNC0kPme52o5KZGTbIzKYCWswGxA7B8mEFoeOKsFsoWLWkG+H6/ABuTYjX43pWf0+Yb6pkxJyc2iPwbSIOaJrzbF8CNvr9t/CFchJw8i1/i+pTvV9xGqymN8zBNueG7C3c9stjViC8tpyF1eQ2Qy9JmRj4qsn9VLn4yJJceDlmK6bOCFAqwDAwsY4t1Wc7HJGtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tQvRoGcC9xqyyfjJSfWyGps7pCz04HSVkDwJEqennyI=;
 b=kqA5lU/SyTJdySP3+U+3nTnCjIqg7SaxtqmowCfujcF2PrWMn/ORivYvjZ/ejMjo2iNu13jYyi8FWWk3vuc0XBrenTTFc6aujWoiTYKaZKNtB3QJpVXJUzP8NcmeIzEsOs40tBr244bXS0D3ciRY5B5em/1EFOmSYyZmOu0wJUU=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from SN1PR12MB2414.namprd12.prod.outlook.com (2603:10b6:802:2e::31)
 by SN1PR12MB2512.namprd12.prod.outlook.com (2603:10b6:802:31::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.23; Wed, 2 Sep
 2020 17:13:56 +0000
Received: from SN1PR12MB2414.namprd12.prod.outlook.com
 ([fe80::d548:1236:cb4f:1be9]) by SN1PR12MB2414.namprd12.prod.outlook.com
 ([fe80::d548:1236:cb4f:1be9%7]) with mapi id 15.20.3348.015; Wed, 2 Sep 2020
 17:13:56 +0000
Subject: Re: [PATCH] drm/amdgpu: enable ih1 ih2 for Arcturus only
To: amd-gfx@lists.freedesktop.org, Alex Sierra <alex.sierra@amd.com>
References: <20200902170118.30751-1-alex.sierra@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <9fec14fc-ce59-cfdf-f142-181555e1e303@amd.com>
Date: Wed, 2 Sep 2020 13:13:55 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20200902170118.30751-1-alex.sierra@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YT1PR01CA0050.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2e::19) To SN1PR12MB2414.namprd12.prod.outlook.com
 (2603:10b6:802:2e::31)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by
 YT1PR01CA0050.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2e::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3348.15 via Frontend Transport; Wed, 2 Sep 2020 17:13:56 +0000
X-Originating-IP: [142.116.113.11]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 1a36a272-20e3-497f-e4fa-08d84f639351
X-MS-TrafficTypeDiagnostic: SN1PR12MB2512:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN1PR12MB2512E2631A5E0987499FF032922F0@SN1PR12MB2512.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sV0se0LHOtfcPKKVb7wr9ItgQH6je2+gmt5sgpTdjYWx1CtIfu7SqEdJCUvhATuLSLxMq1tQqSGmh1XjVmAt2jRSjtpnu9IXy5NhbUVeEOebeiyIyaehjjCLRkzcmKvYolVYWEEoL+DoFYiIU+LNCl0TXQ4MwgL/lc8a6i6sv7PC8zQZlzLePh523Z8H9h6Tfr+yqivXmcIpIQnnVcB958Jfmmql5rGSE2f4y9VcoPIJmrnf2MYUg/ED9D6IYZeKbS7T3LT9nh+OvCKo+0teX3JGNDaE3bOnTN/EmRanKEttPe/fROX3I2MvHyjlMjrngRjwei4JFl/5KDZcnuQbJbO8AK8Witjs6TriouFq2bjBuOVtwrnGVzw6KYA58WFTC6HIA2o72jvBp/V7ZubDtGeewSjaC1QD6D3rcYvZUPM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN1PR12MB2414.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(346002)(366004)(136003)(396003)(39860400002)(37006003)(6862004)(2906002)(31686004)(66476007)(966005)(86362001)(52116002)(186003)(478600001)(5660300002)(956004)(66556008)(36756003)(31696002)(6636002)(2616005)(66946007)(16576012)(44832011)(6486002)(8936002)(83380400001)(316002)(26005)(8676002)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 4J0bylM6DT64QRS/MDfNJjdvcTH/Ufot1Fs9j0wLssgevlwpCA8NrUU3bbHujMbCgklMsTGXktAAm3ANs/8Se+fHOGF/qVTlbAqpSIKPrhrzV5HTiBn6FiVDzI1TfMH8kn1uG44hJ7KRKyOBDmqrh0LWPiQhjqoMJoTyqfg2fultliPWLooDrcjSpI/rihP+nn2h68bK66N2pNbFhIO+ikanDLnOXtXNPaRKKepe2YyB0kd9LDZyyQzmc8lCkT4Xtn2rUYoBSijZdMmzkSfLLtOEYORr3KLUc8NA/8+CaxynbjxTYTCrddg72Y0DrbiZujfuBt85AQG2j7KB6x/QE5bi4ZaIC6YKyVdqhovBB/7ryPo7+ceX6q91z8jkjADVShOzqrJjRjA+XrTVLa5lhFVaRdQ1tnh1IxxcqXSAFkAq8c+qoRuUjzEzxHFp+mALz2/n9xoY/cP+Z8ALN4OH4zxyHWeNGwQmY32W0yko0N9vtOuDNrBqXtpQiQa4mrU6XqEGxqi1uEvqFcqBW0Zk7LsHrGhjxb0pQKfNxOMPjapUY6EGztPCOFgoxJvFFIR3ZgvnIlY1edll8hYSYE88bBikWoSKuq7wO4S3cNytbx1dHy8lCUy7gmd8/nN7Mu/tz6N/kyVDK07++V7aY3BHRQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a36a272-20e3-497f-e4fa-08d84f639351
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2414.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2020 17:13:56.6668 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n1iOB79zK88ldHKCbqEnbBYkp3FuabaqiTn6np8l75mx6ZMTuyre9Gz1eKhVuMT+hVf+Jt+Bm2Xl0zdkORJkAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2512
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

Am 2020-09-02 um 1:01 p.m. schrieb Alex Sierra:
> Enable multi-ring ih1 and ih2 for Arcturus only.
> For Navi10 family multi-ring has been disabled.
> Apparently, having multi-ring enabled in Navi was causing
> continus page fault interrupts.
> Further investigation is needed to get to the root cause.
> Related issue link:
> https://gitlab.freedesktop.org/drm/amd/-/issues/1279
>
> Signed-off-by: Alex Sierra <alex.sierra@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/navi10_ih.c | 30 ++++++++++++++++----------
>  1 file changed, 19 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
> index 350f1bf063c6..4d73869870ab 100644
> --- a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
> +++ b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
> @@ -306,7 +306,8 @@ static int navi10_ih_irq_init(struct amdgpu_device *adev)
>  	} else {
>  		WREG32_SOC15(OSSSYS, 0, mmIH_RB_CNTL, ih_rb_cntl);
>  	}
> -	navi10_ih_reroute_ih(adev);
> +	if (adev->asic_type == CHIP_ARCTURUS)

Instead of looking at the asic_type here, it would be better to check
the IH ring sizes. They are also used further down in this function as
the condition to enable the extra interrupt rings. It would be more
consistent and this way, the ASIC-specific condition would be limited to
one function, navi10_ih_sw_init.


> +		navi10_ih_reroute_ih(adev);
>  
>  	if (unlikely(adev->firmware.load_type == AMDGPU_FW_LOAD_DIRECT)) {
>  		if (ih->use_bus_addr) {
> @@ -668,19 +669,26 @@ static int navi10_ih_sw_init(void *handle)
>  	adev->irq.ih.use_doorbell = true;
>  	adev->irq.ih.doorbell_index = adev->doorbell_index.ih << 1;
>  
> -	r = amdgpu_ih_ring_init(adev, &adev->irq.ih1, PAGE_SIZE, true);
> -	if (r)
> -		return r;
> +	adev->irq.ih1.ring_size = 0;
> +	adev->irq.ih2.ring_size = 0;
>  
> -	adev->irq.ih1.use_doorbell = true;
> -	adev->irq.ih1.doorbell_index = (adev->doorbell_index.ih + 1) << 1;
> +	if (adev->asic_type == CHIP_ARCTURUS) {

This may apply to the Arcturus successor as well. I'd use asic_type <
NAVI10 instead, to be future-proof.

With these two issues fixed, the patch is

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> +		r = amdgpu_ih_ring_init(adev, &adev->irq.ih1, PAGE_SIZE, true);
> +		if (r)
> +			return r;
>  
> -	r = amdgpu_ih_ring_init(adev, &adev->irq.ih2, PAGE_SIZE, true);
> -	if (r)
> -		return r;
> +		adev->irq.ih1.use_doorbell = true;
> +		adev->irq.ih1.doorbell_index =
> +					(adev->doorbell_index.ih + 1) << 1;
> +
> +		r = amdgpu_ih_ring_init(adev, &adev->irq.ih2, PAGE_SIZE, true);
> +		if (r)
> +			return r;
>  
> -	adev->irq.ih2.use_doorbell = true;
> -	adev->irq.ih2.doorbell_index = (adev->doorbell_index.ih + 2) << 1;
> +		adev->irq.ih2.use_doorbell = true;
> +		adev->irq.ih2.doorbell_index =
> +					(adev->doorbell_index.ih + 2) << 1;
> +	}
>  
>  	r = amdgpu_irq_init(adev);
>  
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
