Return-Path: <SRS0=BBbY=NX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_ONLY,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68942C432BE
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Sep 2021 11:30:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A7606101B
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Sep 2021 11:30:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3A7606101B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EFED96E196;
	Wed,  1 Sep 2021 11:29:59 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2062.outbound.protection.outlook.com [40.107.220.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BCD4F6E195
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Sep 2021 11:29:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OPh17JO7pCoA5eInQG/O8S+AJXkJSJtSnfeg4rTeyeg9BdawshKSmovJ+6EK7ZQmILPR0/gXWLi3Zb7BgMStfDV3LRFlibY2ud65UZPrppB4eygML0MnFU8ZvJIUMEHloR+xpUu+onF8e6t5ireftjAZxLvBQ+olqgJUsHW5x2Fr0GGCI9JojES+mRAt5ZVA+12UlxjZ0XH9r9JWQLtAqrSeDjkAbV09vwcXRXaxJHo1jrJYIh1fxLgWIDG36NznNd0VB7BjZ1qgNNlCo0WnP+eJQ5h6tgLCs4OpcOpxvM7Rntvrk+ntS/CFvTn1XMbYS4RPRJEi8EVqWFc4MEGDWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ftIcAjk0a1tb9Wsrr38mcaWyRcZII1FG4exdBtBD5MI=;
 b=X/1ibEHLzw3LctZrvVP+DL77pkNebs5TlwIFa/7dV/jsQKgLXAAQ3iLEYyJdrUZXEmT7l5KHn1lcCSg1n4w8nVafQvwKZxH7P6Z2/g7in8HDepHhrJHsk+/6FuW6mL5h5HmVFMwIhswDtQwJuOXc102w/dcWTOl3yJ4WE9WoBqWT2z4xjSVZVb4ZMppURwOMgQ3YiCHqHbJRnT43N338JT0K00TjvbnmDnJ/URI5NM8xFlUY0m76BkoCN6kOQMyikG/rKRfPafZpk53g0F8UNUkyFi4TMQr3m85oq7i/+KCkEZkkhp8H5coctXwMcnzbah1Kl/SwuJn4B22h80lKZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ftIcAjk0a1tb9Wsrr38mcaWyRcZII1FG4exdBtBD5MI=;
 b=tFXDY5ypZZbVRDyTnQGwpSSz5Fq6GUHFzTCdFxTGUIp+YhuKNDujHNJeDwbNmYvIgjXYDbfmCcphVCpvBBX4BMoP9Ik0GbYxvdqBW/qEn/dLfS+kjKrkdT/Ou2FtiteAw00j9tQONvgNxrr9+c4VW/5MOZrdzoMCNoa5LZvDR+4=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by DM8PR12MB5429.namprd12.prod.outlook.com (2603:10b6:8:29::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.24; Wed, 1 Sep
 2021 11:29:56 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::5425:6607:8b21:1bab]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::5425:6607:8b21:1bab%5]) with mapi id 15.20.4478.019; Wed, 1 Sep 2021
 11:29:56 +0000
Subject: Re: [PATCH] drm/amdkfd: drop process ref count when xnack disable
To: Alex Sierra <alex.sierra@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210901024121.23964-1-alex.sierra@amd.com>
From: philip yang <yangp@amd.com>
Message-ID: <b690d7a8-6c4b-fc52-0076-7a8c0bc7a391@amd.com>
Date: Wed, 1 Sep 2021 07:29:54 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <20210901024121.23964-1-alex.sierra@amd.com>
Content-Type: text/html; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YTXPR0101CA0036.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::49) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
Received: from [172.27.226.38] (165.204.55.251) by
 YTXPR0101CA0036.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::49) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4478.19 via Frontend Transport; Wed, 1 Sep 2021 11:29:56 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7f9c50c1-5d79-44a4-590b-08d96d3bd318
X-MS-TrafficTypeDiagnostic: DM8PR12MB5429:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM8PR12MB5429D7860CBCB8B9D671D044E6CD9@DM8PR12MB5429.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: s58MQd8JRIYxn3HLWQfM0LPS5qDsgy6WdM7kY0RUmDAYsEjzcKn6OvQieV+gLcP5Su0ITh5j2LNTzR6YQFqS6bTP3x/74rFQFG64Lm8c2MI6+ERtRHwU/Z1jtcjkB3UY17QEJhiJmgE00hVSgittKhmYOx/sRWQtHYTPyN7KW1FHbdzcWCHFiqV2GBkLyehAoHudT8i+hEV1RACfMeBLvyUbRjACk+UGwRCzpToF0E4Mp5AsKgKWPRMea8nGUkWUwj004TwxixoWbDP51zIXzWJyw6Cds/OKWXYRPgwQHTj2/OXGhi4fIdb4nEN+fE/DnSmZ3HSZ3fujFp0oJtmKkcVaWHDSxfD+U1QWjVtA+gdq2Cqx/L5xWGD2MzMupOx2YM/ITYvxDhtNJdIGE1l3dYjHQU250jttjCKR0NJQAOZB2Q8w1h/O1tNg/sYGtgEGDziTnCAYWxhEikQe7UYY8AGCKb8Px8mathYpduSouN2MucZa6k0E9JSOL/QVyhtO4RXwhL/7COIgsUSJ+6/VrzrGtrhLjPF1YmN5LCP6g005fWG8t/4rvU4+F70MJ80WtbEttELn3y9TwACD/HiRQQ6b4ScO4OSJzNAuU0DFWjIMsWrjlZjYJEVLgwtldIqnvfr1LShnJrRet/8rfl4PIWoP9X0Jn68kH6dwLKMdTma8jqSqa+UwRYoQHQJkcCieKed5byfYhokdZkYKme4MTXMvH6Jyj4eXqdAhvCLF6nk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(396003)(376002)(346002)(39860400002)(136003)(38100700002)(8676002)(31696002)(5660300002)(478600001)(53546011)(316002)(66556008)(6486002)(16576012)(66946007)(4744005)(956004)(31686004)(36756003)(8936002)(83380400001)(186003)(2906002)(26005)(2616005)(66476007)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NkI4M0loTzllTi96VnBWZmsvNmhXL0N6U0ZGVGVaWkZEclRQeWRnRmVCZ3Zx?=
 =?utf-8?B?dmVVbWQ3cnBDNm1ZMG85dWNOZXk0Mnh3Qm9TUTl1TitiQkpNN05PNlljQm9G?=
 =?utf-8?B?dU84L2FyVmlHdVZxY1cxRGlRUGZuTWVmSHlpaHBUcW1aN09SR2tiTXF1bkxV?=
 =?utf-8?B?TzF1UEt4a0FtYlNiSi9oU3hwVGEwc1JhRHJYWUI0R3EyNUJzblNKYllJYzY3?=
 =?utf-8?B?ZkRUektJN1EyWHRvSE1aVEpuLzFUYU9sczlUUk11SjhLNElsUFNBejViZTlH?=
 =?utf-8?B?bmM3OXZtek5SUTJEZTBOZEJvY1JQSncwWk1EZlFjSHRleEJuSHhESjRZRks0?=
 =?utf-8?B?YWZHL1llRGMxYzVXQ041T2RTdG9GWXlReUF1RE5QUWlnc3Qydjh0YlJHYzEv?=
 =?utf-8?B?d0pmZEhtck9BSGlqTFcxbXdrZEpwb3FURkxBRHUrdmdwMWZMZXhBcGhqQVZD?=
 =?utf-8?B?TTZLaHZqcnpsRWJkNkZvMklJcmdTWW9UOGJlNzNRb0gxUm1LblVmMU82N0N3?=
 =?utf-8?B?M1ZaK29ibUprbStOOVgwVG05VnBab3lnOWVtMFp1dnJLZWozbGFybi8zNllr?=
 =?utf-8?B?bmR3djNOZHIxSVVBTzhmVzVzc0F6Z2xNeVVFOExYOXo2N216d1lRbVdlYlRG?=
 =?utf-8?B?WEZqaFJyZjJBSnlnR1RWc29hRkF5T0pOaUJWbklKb3laYjU0bVBldTU1NnhL?=
 =?utf-8?B?M3pZZGNzdktHQzdWQ0pWeTZRYm1aZXBBTUtLVlU5Ykk4ZHQ3T1ZtNENVcXRU?=
 =?utf-8?B?WFlDdDE3V3puSThrRDk4ZXRTRFdybkVGZU5zWVlkZjRsUDErdFdXRDVlVm9Y?=
 =?utf-8?B?dUxESmIyNEFxTFBEWEUxQkswTDc4OUxkU3crOHFWQjB4YksySjc3RXNxTmVV?=
 =?utf-8?B?clFRczdNVnM3SEljdXZVeGQvM0JXN1lnMkNtZk5IMWRHV0lrTUs3VEZEcy9a?=
 =?utf-8?B?T0o2aURxYXZyay9SUmdUUHZtaDdtN1VYRWJkTUdXcmJ4V3NJbWVtNzR4ZW9q?=
 =?utf-8?B?aDRmMmJRNHNyUVJLTGY3Ulh0Q2J0OWJTZ1k4Wm9MOStmZldDQ1Bld2tZUzEv?=
 =?utf-8?B?U3BwZmtZUXovTGNWSWFWaDgwWXBlQ1FSYldud2hkMHg3czQ3ZHF6ZWhsU21C?=
 =?utf-8?B?NWRwdGJQVURJL0YyV0xNZVRXb3JjcGU0eEZSeFFOSlpOTGFtOW1oUUVGdDB2?=
 =?utf-8?B?T1doZHYvNWNZem1oWG5BSCs1eGRKZW51SlNNWE9xNWVBb0V0ZEdNbjdjTFNM?=
 =?utf-8?B?a2dhcE9ZV3RlMXZuN0tQK0Ewd0NzTTNwTFRBWGlYeEREWGFuSVBvMlhJQ3Bq?=
 =?utf-8?B?MnFuTFF1S0pqRkJmemJZSjFFdnRsa05CUnMrRUhCVm5GbmtsVm9BOVdOWHRv?=
 =?utf-8?B?SUlvUllsbVFTYnF1MjdNZmxFRGVhRlBwdDl1eVdjWjNnc25ncW5jQisyUEFO?=
 =?utf-8?B?L1Y1ME9ab0w4NE1ZeHdVSEtrS1dMbm0zZC9XRkdVYVVBYUxBMDVURnNncmRD?=
 =?utf-8?B?SFVFUll2eUszemtJY1NTdVZJczdWSUg2Vm9QbmVDWCtaT0NVT3ZvUnc5d0s1?=
 =?utf-8?B?RkQ5Y21JZ1JJWW9Ma3J0eUZwU0xSRjdwcVE0RzZ3VmRGN1VLNG56bjl0TXU4?=
 =?utf-8?B?UmdidnZlNlRQZjlzTGtZSDRiQll4Y3R0VlY0Nm4rN0wvN0dhU25yQi9kbmZr?=
 =?utf-8?B?ZVkvcTdsWjVmcTNNdGZCajR0bjNvdGxucGhyV0p2MWFxcmdvSlFGeWVFc21j?=
 =?utf-8?Q?PoXK/U+cFjnAIYCqJp3oe9Rt/g7HzdhVKykhMPY?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f9c50c1-5d79-44a4-590b-08d96d3bd318
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2021 11:29:56.3812 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kmgMOhhIzfAEFhM6O68py7cD8qXH16lDA3+u/+Leo3Ef8z8a1ImNXa12EFlqJbkE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5429
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

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2021-08-31 10:41 p.m., Alex Sierra
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20210901024121.23964-1-alex.sierra@amd.com">
      <pre class="moz-quote-pre" wrap="">During svm restore pages interrupt handler, kfd_process ref count was
never dropped when xnack was disabled. Therefore, the object was never
released.
</pre>
    </blockquote>
    <p>Good catch, but if xnack is off, we should not get here to
      recover fault.</p>
    <p>The fix looks good to me.</p>
    <p> Reviewed-by: Philip Yang <a class="moz-txt-link-rfc2396E" href="mailto:philip.yang@amd.com">&lt;philip.yang@amd.com&gt;</a><br>
    </p>
    <blockquote type="cite" cite="mid:20210901024121.23964-1-alex.sierra@amd.com">
      <pre class="moz-quote-pre" wrap="">
Signed-off-by: Alex Sierra <a class="moz-txt-link-rfc2396E" href="mailto:alex.sierra@amd.com">&lt;alex.sierra@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 8f9b5b53dab5..110c46cd7fac 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -2484,7 +2484,8 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
 	}
 	if (!p-&gt;xnack_enabled) {
 		pr_debug(&quot;XNACK not enabled for pasid 0x%x\n&quot;, pasid);
-		return -EFAULT;
+		r = -EFAULT;
+		goto out;
 	}
 	svms = &amp;p-&gt;svms;
 
</pre>
    </blockquote>
  </body>
</html>
