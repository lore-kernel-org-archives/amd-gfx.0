Return-Path: <SRS0=PoT7=EI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAC84C00A89
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Nov 2020 17:25:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D61F21D91
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Nov 2020 17:25:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="KPczcTsN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D61F21D91
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 189D06E203;
	Mon,  2 Nov 2020 17:25:25 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2052.outbound.protection.outlook.com [40.107.243.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C04C36E203
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Nov 2020 17:25:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C72nG1KGn4K5WhnONHH1hr7DeqzJFcshySEwJ+fbmUXSkiscEZXznnRsM9EeKyVdH2YtcNqe7RT++T8Y34Y51Sx8dbZwbgq9aR7oqoMTVs51v8GAkVJDJUG+MKJNQHGAYgg3JwJuVu4na1Du2tmoILHie7eINtpluI/L1SzwqaStLMtIIo0i9q3K16b+VRURYe94LDOXlN9sShVQHkEBI6MQ89x1Gu3/P9vzE358guPa1SISthzikV3cljA3JWmmH66dSsb/4nR/4iEVNOh8VMV1vWMFnUbc8EG9SFfPYx0hFwPjZWpbtuGhB8zEIcHOzvKoN7FNd7cP7IqdiS9FAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hkRJ6KuAEqr8KORaXVFhR+4mk8lHuxqSiGOGzYJKKYI=;
 b=hV+ixQe8pfU+5QITfnyLRhxmbFnZDtA+a4zxUNGL+L7sbKR1eRDxolOCkGMCh4tOpwcWFM7rbmra/G6vCo0hQSjf/0pjWzMBP4w+ZWHj/bGhaHxaKN09Yv8aitCuJxdMd2l7siGS6/mMeahSa9Sxc0bN8pv15m37EPLp/Ef6hGpcT3sXIyly68j+x0pUSSjOLEaOermaAVY1ZRi6uElixt2hTaHPvfzQJY9Wo00yzVozqNtOLQHEtbfUXJV1FooxQwoPDlxdabVpW9AIm0UoksFNGMGQZT3LXmUKCBmVhJRzseeVU3HpBm13wSupJps+qGKxJyPc/6FuE+Mtld2Hmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hkRJ6KuAEqr8KORaXVFhR+4mk8lHuxqSiGOGzYJKKYI=;
 b=KPczcTsN3bABiiwJbx1eFTTbb7unLE7DXLlPrfxJBKBjDK7OYoOEdauO7ZmxvSAfCd0Sa8qtSDp3sVWecbq4Jvert561BkS64c82zpTMN4KBVX4SV6kJQf+KvWtp7TsCPNa7rP9+X9wN+JccIYILI+DddJhku2ZXf0dHOQJU1A0=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BL0PR12MB4948.namprd12.prod.outlook.com (2603:10b6:208:1cc::20)
 by BL0PR12MB2355.namprd12.prod.outlook.com (2603:10b6:207:3f::25)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Mon, 2 Nov
 2020 17:25:19 +0000
Received: from BL0PR12MB4948.namprd12.prod.outlook.com
 ([fe80::b07d:ede5:2f45:5de8]) by BL0PR12MB4948.namprd12.prod.outlook.com
 ([fe80::b07d:ede5:2f45:5de8%9]) with mapi id 15.20.3499.030; Mon, 2 Nov 2020
 17:25:19 +0000
Subject: Re: [PATCH] amdkfd: Check kvmalloc return before memcpy
To: Kent Russell <kent.russell@amd.com>, amd-gfx@lists.freedesktop.org
References: <20201102162724.14396-1-kent.russell@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <fc22b10b-74e1-03ee-1519-a9c05f001c54@amd.com>
Date: Mon, 2 Nov 2020 12:25:17 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20201102162724.14396-1-kent.russell@amd.com>
Content-Language: en-US
X-Originating-IP: [142.116.13.173]
X-ClientProxiedBy: QB1PR01CA0029.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:2d::42) To BL0PR12MB4948.namprd12.prod.outlook.com
 (2603:10b6:208:1cc::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.116.13.173) by
 QB1PR01CA0029.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c00:2d::42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.18 via Frontend Transport; Mon, 2 Nov 2020 17:25:18 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2353d2fa-dd9d-4c18-5a48-08d87f54455f
X-MS-TrafficTypeDiagnostic: BL0PR12MB2355:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB2355CADF8FEE24402E92AF4392100@BL0PR12MB2355.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:989;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: U78KSUB6tOs53xYlhtRBCcAwpiujGHhaNV0ZTVwlSMSekgu3uZEEQKmaQxSydIUFnIWmFfVQTIhoSvxqymVCjMkhPtZcZS/2tCVVmj6uh0Tn5egLCRu0UT0oyw10qxP8melW0xh2KzW+F28F3WCzQl1I4HEfc2t3XW/9neqVnxyNm0JoYPC+mDdh6iSrYnne1KJD70aR2/p2fi+OSarRnmxbT4VbfzkqfwVQruROGdcTg9H9gA2PqgPFquVZI/W5HLly9aPpDbu04pWQhjfvgJFWexya6T8hCkSz2ZkdPKpcJ8Hkih3ycs1LpcOH8f0KJxXz1fA6APtgihBUrKZ5brhtJ127pNQZUzF2wqgxsnn00VgVGI3wGcyhJkhWO3bI
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB4948.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(376002)(39860400002)(346002)(366004)(396003)(16576012)(36756003)(316002)(8936002)(8676002)(66556008)(66476007)(66946007)(83380400001)(31686004)(2906002)(16526019)(26005)(186003)(956004)(478600001)(86362001)(6486002)(44832011)(4744005)(52116002)(31696002)(5660300002)(2616005)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: IWF70LJrixl6mxBIZFfkFZzVoeiX6IA14nYy33WczSE+N/sp5A44H6ko13gf1YpN3gi59l/zcbet5/Uv8BBS057MpvaW2aYj9jxFyNywlBpjRUU3T6MHpTWQVBl5/T6hqhR7B038yXgGRGHkiy9GssXCJT4zvjOLmgPFni7k+NBPRAxtGxT9UeblSkX9T0yL3HYg5PaC0B7zzeZEQvidCiOoofgQW1LuU1exa9say4a51Leo0aXlwi2uJr7x5QQZ/P8o018zBK+IeA6VTIQcDmG7zeSxI3o7VeHfqc3/iJpFyjs0ROXLpiIhaXnLDOkBIyxYAZ+Hh5m4DL9u7eh+3S90ALYnQMq1g0iQVR/w1T9njJhxZg4n+BCX/Gt26mcUcVNrzfAWClzhSSiWuozA//LKDmrzBE2e4Qjyz0eOWDS67atmzfZMreeN/KjKbiageTE4BxQHZwH8PKTWyFdH/hHVwddpND41ztHTxNp50ijZGF7UZzEGjCGMnNN45hbMlNhHwsYXf9y8yPqrDcpk8eQkbMLv+Jtwbhdz4Mwa4BqDL/BB0/hpT02hC7ZuswKnUbFgbVf2XXgF0kZe58lGyVLgj78X6OAd5FW2T19Gq2pEUyIQjo8pnJZkDSNIEdPnx1rkLF6qVRVC1qKpOEGf0Q==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2353d2fa-dd9d-4c18-5a48-08d87f54455f
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4948.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2020 17:25:19.1867 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cimkqfYXfLA54MJ2g/tkVg1o/xRyKhRQiP8cjPQp0vSwir4gUqZUF+y4X+MEjD6THZ+9Zr0iy/pNgueknqVw6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2355
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

Am 2020-11-02 um 11:27 a.m. schrieb Kent Russell:
> If we can't kvmalloc the pcrat_image, then we shouldn't memcpy
>
> Signed-off-by: Kent Russell <kent.russell@amd.com>
> Reported-by: kernel test robot <lkp@intel.com>

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_crat.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> index cdd5032d5c0e..a0acf2310357 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> @@ -804,10 +804,10 @@ int kfd_create_crat_image_acpi(void **crat_image, size_t *size)
>  	}
>  
>  	pcrat_image = kvmalloc(crat_table->length, GFP_KERNEL);
> -	memcpy(pcrat_image, crat_table, crat_table->length);
>  	if (!pcrat_image)
>  		return -ENOMEM;
>  
> +	memcpy(pcrat_image, crat_table, crat_table->length);
>  	*crat_image = pcrat_image;
>  	*size = crat_table->length;
>  
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
