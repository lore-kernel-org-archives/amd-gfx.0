Return-Path: <SRS0=vd7l=OL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FE87C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Sep 2021 18:59:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55F9760FDA
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Sep 2021 18:59:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 55F9760FDA
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C4FA36E59B;
	Tue, 21 Sep 2021 18:58:59 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2066.outbound.protection.outlook.com [40.107.102.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1F3976E59B
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Sep 2021 18:58:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oQJ64mBO2EiWeJqahLoeeUR+zdOg+RmCxOPWrv0O3bBqlpJkrutQDyWcarFRPrWxG+Gyt6h3q9Ldi2AHo6ok7bGyCPteEmqeSnoYp9KGbPP70ZqjxCV52R2eKjDfaR6hVjjQKsl9JXznuclweQvU3bCbDZGKbkUA9YZMV7KirKZPlOPrmTbqqQ6z1A6hauwWAvmieweFEM4TJWHfXbXMiuxEAU3JTfkh4Jss4aHunrEKpZFDU4vyeX+GhHiidxdxtq6lwaa6T+uqqdGJ3yWezkDxvumiKBr0Ylk0NROglEXURH4DM3Y9Pz9gbVaW41g4IBSHhsTdkH5HarXE5I77FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=HRR0bvu8taWmefOZhMgXp0lpIgjBlfR7iq+hyJLin6g=;
 b=SqwDeKPZwu+b0fqK10+eIyst35sQnxzm0PzpDS4wzqjDGET91GtVFZRORMmLdusIfAjlpO8wAWR/YoX5SI6aI+ilaSzz9lcmcg/CpCOEt3LwbFEP1DJVQqiATH/HTwBwIvECgp670DVsXOmHAtppAU2JcrPjQ8+eZD75gejS8CTTtItYkjDO9i1LkUFZXI+I5EQM6nxitlQa1ZRXyTU9MSvA3ov+ENdNLjJE6vTbiG3loYqFctl5CpNdj8tMrBLKS5KCo0Lm5moGsoiBFQr3boS4NdtJzHkKkmQlNdBDnt8X53fuyLaGQKoGnh9qC9PopMqjWidl6HD1Qf3xPh/t9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HRR0bvu8taWmefOZhMgXp0lpIgjBlfR7iq+hyJLin6g=;
 b=4bKebmnVp2QO2PvwAzJk1VwCvV6VhxRhrrOiKYFHQoFymbGAxwvW6gR0mfIz/Om+5XqmxzvQon6u/L6Z6nEESSlRZhi5owfjKZ1B3PtnkL2JNe2Qfy/n49+QBP6uRstffo7IGVVdSCyvP8WQlsT9LkYGxE8Rt222AnE+ybn/O+4=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1947.namprd12.prod.outlook.com (2603:10b6:3:111::23)
 by DM6PR12MB4329.namprd12.prod.outlook.com (2603:10b6:5:211::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13; Tue, 21 Sep
 2021 18:58:57 +0000
Received: from DM5PR12MB1947.namprd12.prod.outlook.com
 ([fe80::3153:3d7b:e216:74c0]) by DM5PR12MB1947.namprd12.prod.outlook.com
 ([fe80::3153:3d7b:e216:74c0%11]) with mapi id 15.20.4523.018; Tue, 21 Sep
 2021 18:58:57 +0000
Subject: Re: [PATCH v2 1/2] drm/amdkfd: handle svm migrate init error
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210921185307.25811-1-Philip.Yang@amd.com>
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Message-ID: <476938b2-1e11-2fe3-f471-fda9ca417a9d@amd.com>
Date: Tue, 21 Sep 2021 14:58:55 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <20210921185307.25811-1-Philip.Yang@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: YT1PR01CA0145.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2f::24) To DM5PR12MB1947.namprd12.prod.outlook.com
 (2603:10b6:3:111::23)
MIME-Version: 1.0
Received: from [IPv6:2607:fea8:3edf:49b0:591f:ecc8:119a:23e7]
 (2607:fea8:3edf:49b0:591f:ecc8:119a:23e7) by
 YT1PR01CA0145.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2f::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4544.13 via Frontend Transport; Tue, 21 Sep 2021 18:58:57 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f1f6c2d4-fc3e-49b4-2561-08d97d31dda8
X-MS-TrafficTypeDiagnostic: DM6PR12MB4329:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB432940FBA60796502670AF37EAA19@DM6PR12MB4329.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1186;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6khHAuLQrxx6M+PI9Kl6dmU5aYnFSZoRsluOhF+ng7mJkO5DHnI7gtOWkLIbaZHB3ks4DZfaLNnJpvUFjT1xpYeXlihrBaKF5RIuoBAs7g7pRZNeT5LxaZ5Q+ehRjPV0cm+eM4xC8dewC3pTxIlHdALMxeggOyMrj7VhYDVVoBv/kAHvNvh9wC4QfaRCJX5n8Nf2S+l80liZy9QZbcWoLIgU4jn5jP4wUyOPvsS8oNCj+Duyq4Bk2bXU9ghBU8A/oSh5I3LLkRHMPMqIDTXi8MAeefguGCkmuLf6sOlIokDU5g0fcDK7ZZ02zHb9wuvts7YDx8QyIhWrTlHGYjI87CW4Onf6DS32VVRNpOSnV3ZQjuaJ1el6u7Bi8yRxMGVSYl53v5L2YbqNKtHJaA1H8JkTjCGh2Q/lBmMHqmSpQp7AhIyRNVPztLanLDjBn3txcx66BwewLht8JhnCwSkIzSxUT70Qb2V+EZl3xxLPKcGBwrGotbZ5+ZGGRfd8078MVUCoxlLRFTongx1iM+w9GIYoxfQIAy/boO1sf1lW1VyCmXqCyx5PBsiAUsZa4tZInb+6By6WyeI+sAUeJrMUhAitjEGPVeoaUmXss5y729O2g7qeEgpGG6oEd6XrYhq07a8v2gp7DGKr8J76Hkqv9tJzIrMSy3oMxBZ8ZQuhCHjTDps0+SXyHNM+QjgZX1X2r4iM9HAwlCCfXu5cD/zkPBfXwcwKEcSZvz2iKG0Mkeo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1947.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(6486002)(508600001)(4744005)(186003)(38100700002)(44832011)(53546011)(2616005)(66946007)(31686004)(8936002)(31696002)(316002)(66476007)(66556008)(5660300002)(8676002)(86362001)(2906002)(36756003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YVhUR3BtSFhCdFE3V0NrLzRXSWNVb051cFpFUDJxL2ovZklWNW9ucmtIcXJ0?=
 =?utf-8?B?Q1ppL1QrVzkrb1BRMzM4Lzh2YXNrYjBzTE5HTXR2Z0ExNmtUQmF5YjRUT0Zs?=
 =?utf-8?B?UVZkb2pQZWFQUjZMa2xRcnFabE9ZbmxXMWdnNGNXRlNhNVF4R21CUndDelRG?=
 =?utf-8?B?Sk9iK2J0ZE5NbVNobkV0WXhWNkhxNU8xcWdrRzJrQ1NjdkpGQXpUekNUb1dI?=
 =?utf-8?B?bkI4UjZHWE5zVFFCK3o1SU53V1krT2E3K0pITC92NTdDUm5JKzZkYncwOWwr?=
 =?utf-8?B?TDRJMnpJeHE3ZWg1QkRJSmZmNldrcm9LOHhmQUNwU0puSDY2ZUN3ZXdkYzJx?=
 =?utf-8?B?QnQ2NndKR1FJUGlaL21SNU1GYloyWloxWEZ0TUttR3prWmdKYW4zYloxU1Az?=
 =?utf-8?B?N2Q3ZHRsQ0RCeWpteTRFVFg5SGwwQUpuR1dBTmxLaStwSkpwd2c4S2pTVWQz?=
 =?utf-8?B?M0VzbG5aLy91M1haWHlxMjBGc3hzZHZQV2dudFNpWnJEY2M5Q3ZCTHk5SGx0?=
 =?utf-8?B?TUVqREQrUzk0aWoyMW5YQ0hnNmIrSDFLY25CdmE1dzJ1dXVDeGtpQy9kbDNP?=
 =?utf-8?B?WEFjeTE0WElVUE5VTEZ5clkxdTZ0VElxUWRmK0QyR1FJZWQ1Um1HZXVVWmdX?=
 =?utf-8?B?WWYvcWx0eTVSNHpGQ1g0bUlEYjdQdmJxY2dvQ3cxYTI4S1M4a0tjbVZ4cGhC?=
 =?utf-8?B?NUF5QUorNmFRNDE3T2VzVXM3VFhDN3JLOVZHZHJRSC9UVHlraGNBMXNLaW5S?=
 =?utf-8?B?eVVrZEJXU2ovajlIRTRSSkF1VTBOTlhPdC91OUZsOVJjZ2JtbFU0WFh5bEgy?=
 =?utf-8?B?a09TODJPTkNrRlN5ZEo1NGVOYnJHV2lnd21KSTBIaE9EaEQ3ckxpWjlsS0Yv?=
 =?utf-8?B?ZU90WUErcGpiSW5LcW1KRTdtRERUclc1SGQvNk83RzZ2TEptV1d5WlpzRGlY?=
 =?utf-8?B?RnRKalpoZFhwdlI2eG51QTZYWkdRS0drNk4zODNQT285WUY3UDJoSjJlSmMz?=
 =?utf-8?B?NFNZQ0NRcFlVL2wyb2xxNFdKeWJEWXk0bHoxSGtnS2wwdVZzWklDWXhqUUdh?=
 =?utf-8?B?SEo1NHdVeXhNVTdKdnJyQlMyNVVMb3FuUnNwQnZMY25ndXBnMWtjeEd0b3Ax?=
 =?utf-8?B?eWh6RVp1M2VOdTFOOUtLNjBnV3hxeDJaUDJOVVFueTVtNEd6b3RuMkNvSXZx?=
 =?utf-8?B?RXZvdW1MRjNveUhndWYxK2h0ZVdzS1hjY2dzTENsNWJsODJuQnk1MUsxUnhW?=
 =?utf-8?B?dmhBbjR0Q1k3WTAzMFFuQVpaeGcvN2tQL2VFam1PMGMzWmFvU1ozaVF6ZGJ6?=
 =?utf-8?B?OEtWaDJVRUQzRjFwYWx4bXJOYzlEejBlT08vZDJkbTZBdXNUYnkwUDJSMm9a?=
 =?utf-8?B?RUNiVjJRU1BTR01nWUgwaUlVbC8vVitqZFlXdVBNbGFFQkJiTzcwZjg5M0dw?=
 =?utf-8?B?enVQeWNpWkVRQTlnOXp6WE12YUgxeDg2WlZKeUQ2ZEwwTFU5NEUwOGtPY0FR?=
 =?utf-8?B?c1BPOElFWWw3NU5VZ0h2eGIxMnhTMVp5WCtnS3VxcHgxMnhsbUQrMDlpUktE?=
 =?utf-8?B?cDEvZW40NGJUdEtPWGtGOTE3WVQyUU9vKy9mSHgwWjZ1YmU5TEhoMDdsQytO?=
 =?utf-8?B?QkpmMi9YaUxlWlE5VmFsRkl0eHV5TWFKVUhJa1ZwdFZxYmoySGdvTXc4T3pB?=
 =?utf-8?B?cDBaQm91eldWQjRvR1VtS1lCNlJaV2lmQ0FmN2xNeElJZ3hFa1picHlEcXdo?=
 =?utf-8?B?Q0V1WDVUUmVLeHFGZXhFdnFtd0RmVmx4YldteEc0Sm5lSGFzUm9lM3Q3ZGJY?=
 =?utf-8?B?ZUZYWnlBR3A1TDZ1SFR2aldvUUt3cTRWQldYaVExTy9sMFQwcUozMEVNaDZE?=
 =?utf-8?Q?ThdQ3c8zRqGjl?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1f6c2d4-fc3e-49b4-2561-08d97d31dda8
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1947.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2021 18:58:57.6958 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rtf4sjPp4EPdaxCc4zuOBZ56ML1Yk2fV0YLiJmMk2PqMz5hOEs0ROi28wQPsRNhkPuPAyrgfEd6SqxK3FR6kPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4329
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

Series is Acked-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>

Andrey

On 2021-09-21 2:53 p.m., Philip Yang wrote:
> If svm migration init failed to create pgmap for device memory, set
> pgmap type to 0 to disable device SVM support capability.
>
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 3 +++
>   1 file changed, 3 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> index dab290a4d19d..165e0ebb619d 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> @@ -894,6 +894,9 @@ int svm_migrate_init(struct amdgpu_device *adev)
>   	r = devm_memremap_pages(adev->dev, pgmap);
>   	if (IS_ERR(r)) {
>   		pr_err("failed to register HMM device memory\n");
> +
> +		/* Disable SVM support capability */
> +		pgmap->type = 0;
>   		devm_release_mem_region(adev->dev, res->start,
>   					res->end - res->start + 1);
>   		return PTR_ERR(r);
