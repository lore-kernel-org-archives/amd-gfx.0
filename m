Return-Path: <SRS0=/bSq=5R=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 081F9C10F26
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Apr 2020 12:27:05 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE2642078B
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Apr 2020 12:27:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="wv0anrzj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE2642078B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9E56D6E072;
	Wed,  1 Apr 2020 12:27:04 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2055.outbound.protection.outlook.com [40.107.220.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8C5236E072
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Apr 2020 12:27:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b8G+mKkBWsjgXsXZ+SpRnb5buGTfzc7LwXS+Uz07oqaDd9hHUEtEuhczR82Ny0oDWpQJCIt52GxehpLRQMla77eCy3fMjp1edH9MY/+2anB5luvPGwjvIDR4MhO4ySwiXe1GU9GEbcij8VXGLTyl4I+8r+CEKV6izEOEr0BGsEvfg6wr5aQTpOmHL7lLrOrhG0VZOEsaCD/9e9V7u0vjbaeJR0Hyk9jARk4BmZPb/05uCTL/J3GBFsZKBCTVLoxYTuryl+RF5pJ+0ovEz+kOaNYyFbw/+QbfuCbAnubUfcvfAcdBaZDJvh8GvErgqBj18VBc6ktPNPD/1WdZgfqAfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Neesj9wY7QfTxj4tCI+rXPssoYhA+dmUleQdOVEEn8=;
 b=dFhemGkQEe+o9mNm3FEGHblNnyZSorsHkBIs+PPLc168yVnZSCHC6lFwgTCtETfNSh5E3HxRtTqgcf/rqNgYqicHR4ae9jWWzm0H1ReeBxFxHTcxn6wca5QiDSBEsqzE/NflQbqHJHiYfe0ax3/SY1zpU5UIWsDhJs60vm4FT2Wwe3scuxsTjhgSQtb5er5HrbgmqY94cNRHaCe/+roC5wuoOgLUY8RFETyqHJWxGW/OUbeLy4GSS69jRQKOZtf+hfzFXMegFcuxZCynu9DJh942e6nbuFEO9CMeKeN+7TiqEGhRy153CCML6JPm30r6OqPpgKWKApcveGMu+DdEHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Neesj9wY7QfTxj4tCI+rXPssoYhA+dmUleQdOVEEn8=;
 b=wv0anrzjYQBd4ykfbSY6uLSnGM5QFwHQJf+V6azS8BV3qiM5VWUHr3K9NiPgIJKVTuUrIXYK+uCmeyBApFqUjyQeSAuVY5G3x2DX9qK+8rDwme6E+S11o041T7UVRPybhnnbFmYc57KCe8eM26yYrwsK1OBo82dAaT9mI7pWIXo=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Nirmoy.Das@amd.com; 
Received: from MN2PR12MB3872.namprd12.prod.outlook.com (2603:10b6:208:168::17)
 by MN2PR12MB4062.namprd12.prod.outlook.com (2603:10b6:208:1d0::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.20; Wed, 1 Apr
 2020 12:27:00 +0000
Received: from MN2PR12MB3872.namprd12.prod.outlook.com
 ([fe80::d8e1:aec7:6c60:d13c]) by MN2PR12MB3872.namprd12.prod.outlook.com
 ([fe80::d8e1:aec7:6c60:d13c%3]) with mapi id 15.20.2856.019; Wed, 1 Apr 2020
 12:27:00 +0000
Subject: Re: [PATCH] drm/amdkfd: kfree the wrong pointer
To: amd-gfx@lists.freedesktop.org
References: <1585743160-30110-1-git-send-email-Jack.Zhang1@amd.com>
From: Nirmoy <nirmodas@amd.com>
Message-ID: <12479d62-7971-8cb5-24e5-13d2abde183d@amd.com>
Date: Wed, 1 Apr 2020 14:31:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
In-Reply-To: <1585743160-30110-1-git-send-email-Jack.Zhang1@amd.com>
Content-Language: en-US
X-ClientProxiedBy: AM0PR01CA0026.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:69::39) To MN2PR12MB3872.namprd12.prod.outlook.com
 (2603:10b6:208:168::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2003:c5:8f2b:1800:463:6d89:d3d:5f49]
 (2003:c5:8f2b:1800:463:6d89:d3d:5f49) by
 AM0PR01CA0026.eurprd01.prod.exchangelabs.com (2603:10a6:208:69::39) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.15 via Frontend
 Transport; Wed, 1 Apr 2020 12:26:59 +0000
X-Originating-IP: [2003:c5:8f2b:1800:463:6d89:d3d:5f49]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 3644f1e2-ccfd-4c00-0830-08d7d637f9cf
X-MS-TrafficTypeDiagnostic: MN2PR12MB4062:
X-Microsoft-Antispam-PRVS: <MN2PR12MB4062D079D6C31E07C43A05688BC90@MN2PR12MB4062.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2887;
X-Forefront-PRVS: 03607C04F0
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3872.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(136003)(366004)(39860400002)(376002)(396003)(346002)(4744005)(8676002)(2906002)(52116002)(53546011)(81156014)(81166006)(6486002)(316002)(8936002)(6666004)(66476007)(16526019)(31686004)(36756003)(478600001)(66946007)(31696002)(5660300002)(6916009)(2616005)(66556008)(186003);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +GgNLTUV81H9zScBMFTtozd2gqmyq3qYKyHZRNZ6whi3zzUK7LbNksXhynK7lvhEVltFGNa3H9flv8kTlK34IQp3tNCipFZ+S6goIE/3ArKrV034Z7KFG2WTfIbfjn5Nd2J4OiNS1oCtoksHIWoTA9Bbz7FvCGEGPQSyj8V3TRjXMAabLDDFm7h/bzT+odBi3CwtaQuAXo1RYrGPvc+JhwxUvzt8EatW6dpbhigrZqwFA6nOpId6ycgK+BKl9bAdbUFPVAXgxWpJ/VggCCJBPk2THFn+BybsUbratfeIC+B3Fu+MGN3rrZO35qECgdXk16JJOPRfaTkqr0EyYkp8MLB1MikgFqmU4JzFz47uVW78isqwYB4GDMl6aZZT0sC2WlRNsYHAzGIrW8jA+YgN2m1WSJLnGOQTFEJuCcQCI+fb+eXYivLB0xzn1vVkVt1I
X-MS-Exchange-AntiSpam-MessageData: PA3sbuMT60zlr7b1slfArMGkTJgWnkxve5a9NWJhXRuqqpC1ehOc076iEFVdqNBG5NoK3Z8GXDNTdXOSHbqgE+wt0X2kldrKdyfjh13kcNW/v8pWLEZt4+UiHSBQt06L+LB+AAr8Zv5l827gwWa+e1RVgpt8CmPU/UnudtNYeTnmls0Le/YrXLJ0JnETPMlNjQW2KVHbnkC6mYXiyi0ScA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3644f1e2-ccfd-4c00-0830-08d7d637f9cf
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2020 12:27:00.1533 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QAC8oYFf+TqN0utGgefUR4P/lVm3EEUTSSi4AiZ0AAQDoYKe0q6zeDKnAUCMiA7jQGvi7c7SlBFrfNx9bNLJsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4062
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


On 4/1/20 2:12 PM, Jack Zhang wrote:
> Originally, it kfrees the wrong pointer for mem_obj.
> It would cause memory leak under stress test.
>
> Signed-off-by: Jack Zhang <Jack.Zhang1@amd.com>


Acked-by: Nirmoy Das <nirmoy.das@amd.com>


> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_device.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> index 7866cd06..0491ab2 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> @@ -1134,9 +1134,9 @@ int kfd_gtt_sa_allocate(struct kfd_dev *kfd, unsigned int size,
>   	return 0;
>   
>   kfd_gtt_no_free_chunk:
> -	pr_debug("Allocation failed with mem_obj = %p\n", mem_obj);
> +	pr_debug("Allocation failed with mem_obj = %p\n", *mem_obj);
>   	mutex_unlock(&kfd->gtt_sa_lock);
> -	kfree(mem_obj);
> +	kfree(*mem_obj);
>   	return -ENOMEM;
>   }
>   
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
