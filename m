Return-Path: <SRS0=P3OX=CR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C18F2C2D0E0
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Sep 2020 04:57:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5264B21532
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Sep 2020 04:57:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="BjK2qBAj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5264B21532
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BABF06E123;
	Tue,  8 Sep 2020 04:57:42 +0000 (UTC)
Received: from NAM04-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr700057.outbound.protection.outlook.com [40.107.70.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 846706E123
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Sep 2020 04:57:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cll2/q4m37/Bj0RE4Bqe//8kixIVv7AghT3VXR/8Z5GP55pEirfMvceWkv5uRrEVTgtNoatV4CFOhyYtkv1YdNhyae+oseu8m6NfQ5/an/7gHnug90a+2K8pNUJzBTmZ8m3YYVAFXOCjc+mVLIcdr93N3SN0w5xAaMkDBvnhWwGFxTstkrpnHrOSXjhs6duzUhABb3Wlc2vyJTKXW1xW38VptOElg+8iWSVyhjyCSrgKPg6zdFtpb22tktopu1MqczmgxISfpY3m+6IHYQLPeCd1vUaSx+Wa5460ePY2evjcyd5V6lM7Ix4M2baG971G0pF6Caw0FeUR+FCxNKYSbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t0pB3QayYJ2JyAqkPVwpz68V7Z6ASGSSAUAOC4VVWkA=;
 b=MQR1MY0hTPKJRRzq6TAIjh5Gd4gle/QBhoERTAPzRMeZmdR2p5L+uRx9YgQJ4xOyRjY4kqBj/WtOIA4W91+/aOtCEg4cLQwsHAZMvUndtNDDre9sLaVJWdy9asg9erLNe5hI1QUPM21tRNopc0rbkG8xTP9a724c+ZGrmfaEwPcvBrBTOBmymMbTIb/Iqrbr1h+HGzNhRg59ZmQDhk8j8Ab1QMZjwvS6iViuFk51UJIz+OxGXum17L54J9VauFbh286o18rnwnfr21aA8whuKMQ+wmlgau97Pp1YuZGjQ3zBJcZiFx5avR9d7s8N5Tu1eMARlbMLYQc+xa849x3fMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t0pB3QayYJ2JyAqkPVwpz68V7Z6ASGSSAUAOC4VVWkA=;
 b=BjK2qBAj3SduQNqpj8oHVzuatgqYNY74TbJfYccXjPOfjRY445dd5sJwxxHT49w1frk7us9/IVE07h0AA1NaRwfaP8PzazE9dMCrwk8k9ygbC2LWeT0xLEI5Q5WUsJLzB6WrL7dRWyNYC7ASuAbo526aSS9m65m/jEuEbJyaxrU=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from SN1PR12MB2414.namprd12.prod.outlook.com (2603:10b6:802:2e::31)
 by SN6PR12MB2720.namprd12.prod.outlook.com (2603:10b6:805:70::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15; Tue, 8 Sep
 2020 04:57:39 +0000
Received: from SN1PR12MB2414.namprd12.prod.outlook.com
 ([fe80::d548:1236:cb4f:1be9]) by SN1PR12MB2414.namprd12.prod.outlook.com
 ([fe80::d548:1236:cb4f:1be9%7]) with mapi id 15.20.3370.016; Tue, 8 Sep 2020
 04:57:39 +0000
Subject: Re: [PATCH] drm/amdkfd: fix a memory leak issue
To: Dennis Li <Dennis.Li@amd.com>, amd-gfx@lists.freedesktop.org,
 Alexander.Deucher@amd.com, Hawking.Zhang@amd.com, christian.koenig@amd.com
References: <20200902093257.18592-1-Dennis.Li@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <92d89089-b56c-6e8c-2402-a3ac4c9eb06d@amd.com>
Date: Tue, 8 Sep 2020 00:57:37 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20200902093257.18592-1-Dennis.Li@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YT1PR01CA0091.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2d::30) To SN1PR12MB2414.namprd12.prod.outlook.com
 (2603:10b6:802:2e::31)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.116.113.11) by
 YT1PR01CA0091.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2d::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3348.15 via Frontend Transport; Tue, 8 Sep 2020 04:57:39 +0000
X-Originating-IP: [142.116.113.11]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d01f8eea-b6dd-4eee-ca55-08d853b3b65a
X-MS-TrafficTypeDiagnostic: SN6PR12MB2720:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB2720CDCD8ADA8397FBD283EF92290@SN6PR12MB2720.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: c2+ovYdc2tLANloZ25fiWKrvvxGmYjviHdbe+4Up9tm1MCfbboo/iyfdhCjHX+Im71fNBnfqGpvHLvM9GJUWR/2ycefjycmQvhYjv3e9I0YjcQwF73Q76is7h4Ajhkjm7+37aCphCYgqLdzvbbZ2iV9RDsNRXx0tCX9HU7uJ5QJEX88EwlukWxg14qwCNOSrhWwag9eheA9yqVtsdhTHgi8vS6PoFyV6T/lqSplfGPNqPZ0kx9c8xDYHdiZS2wMATPFw+yZdvO6/m/wYdkuG5BpCJ7PT+CJ9Kh+0JHB781c6olR81NGDMynA5lRrkQ75BTwCRZF1PVjB3N4nsjqL9JURps/8nYtosvPIxkNAohTCwO1RhRLXLUjmPIpoL6W/
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN1PR12MB2414.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(366004)(396003)(376002)(136003)(31696002)(316002)(16576012)(4744005)(2906002)(6486002)(44832011)(8676002)(5660300002)(52116002)(86362001)(8936002)(6636002)(36756003)(478600001)(66556008)(66476007)(26005)(186003)(16526019)(66946007)(2616005)(956004)(31686004)(83380400001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: b+niNleSkRbEzZkN2uOf7J1DTZopsPfr+NIy4gFVFhE9ZlUqbDO2+eujfQHq9aPyNULhh9HNgCUk70+AiLShfc+N9D/q0PCTXMPV7hNFP9bQmbUpzszTQeOw/qcTtIkEI7Mbrgne9syt1L4cjomacx8SVPODliWu9hYiuoeErwhsACHjVrzgjNpRMzdq3E3tDTaOtteBPTTDn4bl+slOZBcXLP+6V3d8i0ua4898J+dfT71HKVyH73pTtWajIf8eO5M67riwPP+fAqSTf5rH/Ea4iPHUrPvfyCarWp5L9XHgpABLbJQfKpHcckEYHUfKXyzYm8Ki6qLkMlUcZzsWmU2J5eNf2qYEJbb5BBtYRB0eNzcU7fMuf1aRaCXGKD2HG3Ptu0GpXn6n6KOTzRZ4lOkoDfgJoUV9OgHDfMaMHhL90jfryVBzOVEiA+4a8LhPWKiD0oEESopQ+IAFNw+WB4GTSW7O8sA0RTJMpvd3v9eANj9om6tAZKGStLOaJBonKscJbdEpbA8UEQXxwBJfJR1vixb1LF/ULtDxBSDsK/nl/7HptbuPmYLp7zuLWVzgJgZDwbchQ1MTyAxOGRgauo8sjw3dnVck4XH2mBw+mkyyoLwp4RbxuRXA3N+IEfyKDS36KBzVNe41Do3GR4x14w==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d01f8eea-b6dd-4eee-ca55-08d853b3b65a
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2414.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2020 04:57:39.8288 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bpDdJTNwNlGgAcvioPpl0KTRTliyNEuCzd4xtAKlzzFQrf5ouEFy++u4CNyYhNsXsMDqk2oYZIrjz97bI9YJXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2720
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

Am 2020-09-02 um 5:32 a.m. schrieb Dennis Li:
> In the resume stage of GPU recovery, start_cpsch will call pm_init
> which set pm->allocated as false, cause the next pm_release_ib has
> no chance to release ib memory.
>
> Add pm_release_ib in stop_cpsch which will be called in the suspend
> stage of GPU recovery.
>
> Signed-off-by: Dennis Li <Dennis.Li@amd.com>

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> index 069ba4be1e8f..20ef048d6a03 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> @@ -1192,6 +1192,8 @@ static int stop_cpsch(struct device_queue_manager *dqm)
>  	dqm->sched_running = false;
>  	dqm_unlock(dqm);
>  
> +	pm_release_ib(&dqm->packets);
> +
>  	kfd_gtt_sa_free(dqm->dev, dqm->fence_mem);
>  	pm_uninit(&dqm->packets, hanging);
>  
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
