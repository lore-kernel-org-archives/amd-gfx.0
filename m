Return-Path: <SRS0=W/Sk=6I=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 613C9C55191
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Apr 2020 22:50:56 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 18C6F20767
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Apr 2020 22:50:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Qf+bD3Cr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18C6F20767
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 87B2F6E0EF;
	Fri, 24 Apr 2020 22:50:55 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2077.outbound.protection.outlook.com [40.107.223.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 46B2B6E0EF
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Apr 2020 22:50:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L2uuG68YY2BcERdEjPKSovSQNULk3Xk1mXiDYA8oe9m2GanYUtss6d4y/HbSFV9Fva7vPjZb9Ts61wADQcm31GUo9Nr7ShJ6PA76JEQjvdCU7BUSE3BDahaiGHbJ63IFUbF31yVKl8McYRn9k6XaClMr51eYgAgr+JumqcF+DLzPWAaANH1Am65KATj9dkEsSrdlKaQp/jUqaNQrsptgrdT670+6qeBsx7ooszSy4XzqNBIOo1dZfHji/qzkqOCrSs+uS7xKex8ccuEwmO2PEv5SyBQTybrn1yoqALkHuAUR78u01Fn2R/F1NztL/wmMzG3u0g14SiNkQGLKorbCQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vUpPZYdlKeteRG3z0DFijRh/ALDFg5413GepfHpEH50=;
 b=C0tySKGdNpX/tqLxk25k+tn7Nmzv9T6mLm6lApOf7UtqRr5XjJP40o/rAnqI+Pexdgjvq2XiKJsEQjbfmvRGlBH6XPqg7YbjaBaiVdzeKZTwfkRssXQg1n0hWypUe0FgJLbVHj3p0hMNvIEjcyIYK4DVKA/bvVaXnKO5SipHljMiSMFa5RD7HZ6dwRLWVqldQZT2Pxo+7wPRkM9ZOYd0gwPOkr+2+ovwiZ1aD28Q2SmxfXLPn0+8vrax/fEtqGuh4a04glLjjOh4JhjAiGpeLqIBP7MBCxSPn4eD2N/ecDbL1Wv6EicYY6yAdASgDDRFetiJCz6Hq1yRI2j2xrLpWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vUpPZYdlKeteRG3z0DFijRh/ALDFg5413GepfHpEH50=;
 b=Qf+bD3CrCUH4GScU83WX/8QNbCNsxBswmxCwpyKkdK4wQ7cPaV7cK3HHacVxnVsfmYbNQjfWRegFSw1yLeYEwye78oUpKzZhuhQukW0QxYRxf0lrIeOOoSNOTLPNPOHUgPyXYhWEo64hkmsBchbRl0I0iCcSIygo0Occna6f66g=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Felix.Kuehling@amd.com; 
Received: from DM5PR12MB2407.namprd12.prod.outlook.com (2603:10b6:4:b4::24) by
 DM5PR12MB2520.namprd12.prod.outlook.com (2603:10b6:4:b9::12) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2937.13; Fri, 24 Apr 2020 22:50:52 +0000
Received: from DM5PR12MB2407.namprd12.prod.outlook.com
 ([fe80::7d36:4eac:2088:637f]) by DM5PR12MB2407.namprd12.prod.outlook.com
 ([fe80::7d36:4eac:2088:637f%3]) with mapi id 15.20.2937.020; Fri, 24 Apr 2020
 22:50:52 +0000
Subject: Re: [PATCH] drm/amdgpu: sw pstate switch should only be for vega20
To: Jonathan Kim <jonathan.kim@amd.com>
References: <20200424222206.38743-1-jonathan.kim@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <20f873f9-b98b-ab9d-75f6-f8c5e4c1e2d8@amd.com>
Date: Fri, 24 Apr 2020 18:50:51 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
In-Reply-To: <20200424222206.38743-1-jonathan.kim@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YTBPR01CA0032.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::45) To DM5PR12MB2407.namprd12.prod.outlook.com
 (2603:10b6:4:b4::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.116.63.128) by
 YTBPR01CA0032.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:14::45) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2937.13 via Frontend Transport; Fri, 24 Apr 2020 22:50:52 +0000
X-Originating-IP: [142.116.63.128]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 066d654d-4e6c-40db-ace2-08d7e8a1f0bb
X-MS-TrafficTypeDiagnostic: DM5PR12MB2520:|DM5PR12MB2520:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB25208AE22720B0853A9DC7AA92D00@DM5PR12MB2520.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-Forefront-PRVS: 03838E948C
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2407.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(396003)(346002)(39860400002)(376002)(366004)(31686004)(16526019)(26005)(66556008)(186003)(5660300002)(36756003)(6486002)(66946007)(66476007)(2906002)(6862004)(8676002)(2616005)(8936002)(81156014)(316002)(478600001)(86362001)(31696002)(6636002)(44832011)(37006003)(16576012)(52116002)(956004)(4326008);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ruzyfptvqYRicjXVOIFiDaoKUucCZrsZM+ddic19ib3/VNoz0s58WSom7drTRbmBTaW3Z6+LQVi6zqbOztB5BzAI0DsObdB7owr3SNCHPBn9kbUoLoGKXpa9EM9y+6feBAhwFKoznMdjLk14Jk7JA9jQV0S8HqcM2xinu17cU9x+hRb5rFCBKy9rQfGQeZPYVhLU3izt0PA4YMe80qfV0bORxfN6qPA2YBDUPuWJj1HTQ1FitT89UqD7RzdZizEXwYD+KZ+Mf6/jhxXH82vzNg9GYa8E2gourm4MFlgytVZfRNxeJb6GVpmJ8Zbwv3KQOUeWr9k7Xgi4ETzaKGR1962Mi+Kg2xyfOo/DNImxXwlK8F4yFGBeLoupsrb7Qws/mGhOvOJm0eyjTetBWiLeyTFn67SyCmm/KbKO7o0ntWT30KEEvvVzyqWwYg1jEJ/B
X-MS-Exchange-AntiSpam-MessageData: Rky+vWcPNWME3jeZFBMPgaB/Rbwebl1e0oXWV+um/vjqBGdcK0BBDyEOdWuNIs3rBe67g42Zmbg7KJlpzKBzFWOkqlmlGXlMcJ8A8m3dHBHA4OFdsuZO2EzJs3BQXyt4GQhelye4On/93zDvX5dyPnIN9WKJKVpYj/w4pu8LyUW7HWQcB4oVlYS9i8CbUS7cZ+SslhCgxviry97U+liOXbxh2FKbSkYFpAWqQWZTmLCFpkH2W+f7lZTe9Y1ZXkEV4M9loGiknNay7HlaQRSyhAnZPOcSUUUwxGmfOT+ZLV1Zx+vasp5AqqM7YnG2KIFm4CXlA3UM+CCl4znzzzZZ1aqpT33L4fcX0ERVp4GFvn3H6AhAUjZf0TYpY6ye7OPZQDM0X+RbBDDsJSJ3YOBHiCo69I1qMBLKkmrj2WNqkqmgZshRIL0tvJfxxOiNolvwlv4Hs8oK7RbAv54iHLBCOGjp1Fcr4fkqy/f1Yn/P1f2wPu8wW1oZxFbqv1ZEgyxUeGKp0F5yjfH1KLEWC3xb0QPaGZ82JXCcgf+YfZQ+6cG/YczERzJsIRUOcxe0E0NliBLcKOWsYYG7h6AMm7NvjiypEzcb+zma2guPIUgkqvYWTZo2rrPy7g6oiJ29VQveHSV7krv2F3qZYvyEfjvaHjkP1ZmqcAeUnewOmYU6C2I1wuPqwJGHAx1eMCm8C6WQAf8XfI2N6dXqN24ZQXZHJsjnSJa+ogAVwTfD+Ax5Fo93kKjQuVylWqqJvAwXRQ0RDiKn7EMdh2N7N/6ZfwLHuL0wJ6/5fe3ajCgJfn623rI=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 066d654d-4e6c-40db-ace2-08d7e8a1f0bb
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2020 22:50:52.4823 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uA56vRoDgICVGZQT1mw5O1lw/2HEftmamTE/bBiVnTVxLGkNO69VE/iuFTSv8skECqcqG7MvqKhlPymMDALSkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2520
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 2020-04-24 um 6:22 p.m. schrieb Jonathan Kim:
> Driver steered p-state switching is designed for Vega20 only.
> Also simplify early return for temporary disable due to SMU FW
> bug.
>
> Signed-off-by: Jonathan Kim <Jonathan.Kim@amd.com>

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>

I assume the early return would be qualified with a firmware version
check once a firmware fix is available.

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
> index 54d8a3e7e75c..48c0ce13f68e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
> @@ -395,7 +395,9 @@ int amdgpu_xgmi_set_pstate(struct amdgpu_device *adev, int pstate)
>  	bool init_low = hive->pstate == AMDGPU_XGMI_PSTATE_UNKNOWN;
>  
>  	/* fw bug so temporarily disable pstate switching */
> -	if (!hive || adev->asic_type == CHIP_VEGA20)
> +	return 0;
> +
> +	if (!hive || adev->asic_type != CHIP_VEGA20)
>  		return 0;
>  
>  	mutex_lock(&hive->hive_lock);
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
