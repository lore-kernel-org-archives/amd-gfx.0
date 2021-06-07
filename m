Return-Path: <SRS0=JNIh=LB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EC67C47082
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Jun 2021 15:57:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3372161059
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Jun 2021 15:57:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3372161059
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C48586E8F7;
	Mon,  7 Jun 2021 15:57:49 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2049.outbound.protection.outlook.com [40.107.92.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AB9F36E8F7
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Jun 2021 15:57:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SWuE2ujlRaDY0ljiFPc9KYiDX0V9qkmbvG9GMlDnsGLRByT9u8zeJLao90MCXXkV/lejo5ZKvovl2qTR629yqUmn6XUZwXzW+rdWqPDPzwwB2kY5qZr4Da9hB64XlKXl63ELzqm8fJBVZrer7VUqagB5czoePnWEE5IVfIgAc8gnpWXX/9iar2Qh8AtWaOM/1Zd9f5m+epiuCpPqku8EqJTr6xvuY1zXzEwMnSc2SJYsA0J02FoUk+GHN3rOILJhhwfdbJIf0RAORio8INYZQIXVrTkv1Vf7Q8LEUtyCn3J+a0AeDvesOHsESzCZ9S50LJRr4ZrfNHKp673de1rpLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HM06VjFirewYB9AudcHksY5mzqKUeRWkfYejjowFAJw=;
 b=M/8o0ZR17s0FpTLrpjX3Pq/V+E4wJwjJnMOTQuWPN9U5KywwFLjt8zk/Rcobk9zYK39tWRNEln5DG8/zWmS2MpRRVUlODTULulZjh9uC1wYPvAAbMsAZCQuYXChAQzO1ouyCf4+WhVIMQpVMMkbO2k5IjcsL7mYgkqPs7JrBDUQpk3BKVJGhupASRj9d4AycFV2/ULjrB8XmHjUnn5f81+gXWqC8VZ/rzfdBaq3B9/QGdvMtjr5Uw2FnoSN9lyFB7QYr59xMWoRDAyYfZRwlOrRm71v6s3AbKJo7ckNChx0R5MefgJWXQ76H7b5jP2dC/dAmBdFxhdqDTQ/aoFpHcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HM06VjFirewYB9AudcHksY5mzqKUeRWkfYejjowFAJw=;
 b=aZyyHPRFfCv2LFGDuMNUBJb7gP0zGsn81KBl9GuArm+6ofgsOi+jwnQfxBXD48oLo++ldX4fboo2a/ezJnqJIIYXcQGP0QNDPgXGDca7xCokuCZ8oAIswo2fDoSiFbbLiyzjU5dGucskY6yjDrlYjx8fJMbsQJqFTuBpYhDoJQE=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by BL0PR12MB2578.namprd12.prod.outlook.com (2603:10b6:207:49::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.22; Mon, 7 Jun
 2021 15:57:41 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::6d4d:4674:1cf6:8d34]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::6d4d:4674:1cf6:8d34%6]) with mapi id 15.20.4195.030; Mon, 7 Jun 2021
 15:57:41 +0000
Subject: Re: [PATCH] drm/amdgpu: Use PSP to program IH_RB_CNTL_RING1/2 on SRIOV
To: "Khaire, Rohit" <Rohit.Khaire@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Deng, Emily"
 <Emily.Deng@amd.com>, "Liu, Monk" <Monk.Liu@amd.com>,
 "Zhou, Peng Ju" <PengJu.Zhou@amd.com>, "Chen, Horace" <Horace.Chen@amd.com>
References: <20210607142343.13509-1-rohit.khaire@amd.com>
 <392d7f26-51d6-f60e-6081-870afe8276b7@amd.com>
 <BL0PR12MB4755039C3515004ADD1051AA87389@BL0PR12MB4755.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <da0025b0-308f-6f2f-e4d8-b5a68117828c@amd.com>
Date: Mon, 7 Jun 2021 17:57:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
In-Reply-To: <BL0PR12MB4755039C3515004ADD1051AA87389@BL0PR12MB4755.namprd12.prod.outlook.com>
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:ce67:4e4d:875d:ffeb]
X-ClientProxiedBy: PR3P189CA0060.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:102:53::35) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:ce67:4e4d:875d:ffeb]
 (2a02:908:1252:fb60:ce67:4e4d:875d:ffeb) by
 PR3P189CA0060.EURP189.PROD.OUTLOOK.COM (2603:10a6:102:53::35) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4195.22 via Frontend Transport; Mon, 7 Jun 2021 15:57:40 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 900f7124-d954-468a-c516-08d929ccfb31
X-MS-TrafficTypeDiagnostic: BL0PR12MB2578:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB2578745FED49B89B2777123083389@BL0PR12MB2578.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:758;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XStA7L3GmydPnngG+D7FSpQ9jcphERvkBaXfKXpYQe3xFkVFJL2rxTlcZ9J1jzBtNtl4yc46KwTZPQN/2ywQ9Z8f6qkEC404OV8ooT9NvHsSNvCQvBbmpQ6+tVQq94JuZNoT41Ra9ZGwKE3EXHElVd4T10XDv1gFmO9ExK4Rm44a4fJJZiIJPVfVIQP9sdhIs2QGBfOrfo4SM2ug6kY8q6JcvI6iyYoGVwPdO+rjMw4gUGeGmYyE2Dmc/xt2pSRngJ6flrsl/oiWEQpOetC2C81yYQRwYy5yI23JiRcRJpI+RtrzkGy4L6gL3FfnDDjrmEw++BpNIQ+3Oi4zQaKjEo5pd1P5FK/cZGSJMLrtEDHFEHCquxLHcT6o0aZntYIQ/AeTe2uQlI65X1pak8kTch0wckrkTvVMDUhgzWoyXlFOaOLCWdmFwD3LOtHrDdyy9BtoI+FSBUGb/TTqSlbICrlyEn+7RufcjBFd6GqvERGb0nI5GJ5OMaWBKaR6sCXbhCorKa4aHZHl0Dh9tSeCYsUWsXMmCdZEF53ga5MMgyFvzfjWfTJrEtR5LPvolYYnADIrTT/HbYX89t0NzvEDp2bELkmyeo9KWlblryH8ITxFTFnn9b0i7kakv1QjddhJsKKwr+TpZnBR3tuRB0mnesMwMnEXOFCHu+CiGwfrpcTJLM83zXjj+Q4luZe+FLoeLcZNcgfZfN6w1yBlpyzKYw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(346002)(39860400002)(376002)(136003)(396003)(110136005)(86362001)(6486002)(316002)(31686004)(5660300002)(53546011)(6636002)(8676002)(186003)(38100700002)(2906002)(66946007)(66556008)(66476007)(83380400001)(16526019)(8936002)(6666004)(478600001)(2616005)(36756003)(921005)(4326008)(31696002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?SXNBa3ZvYko1QVdsYThybTJVSkFlZGdRbW9EMHRhOVdndThtQzNrcTdCSXdJ?=
 =?utf-8?B?cS9LREZWZFZ5dGZoeEc0RG50allHSExrUWNxenNoRE5nK1JCaFJyeUl6V0d0?=
 =?utf-8?B?Qkh0RkRWeDBiYnU3VU5vSzRueW9UUmRLOG56SEtISngwSTgxdGlELzhnVEpL?=
 =?utf-8?B?Mi9pc1Z0SHg2MS9Fbk94c0JVRDA4dFBlTEhxcXE2T2RmWThNNFJ0V0hKempN?=
 =?utf-8?B?L1VpWEJFZ29pNjdpSDd0Y1lINTVDZExPTEhUV25vcElyUlZ2SzJPSlYrN1dW?=
 =?utf-8?B?NU80T0dSUUorUGUraHZJc3Qyd21wYW95OTNrcEl3SDNlNEc4UlNNTUhzbWtD?=
 =?utf-8?B?aVNvQUo2Q05ZOUdpaG5LcmxJcGZuaFIvT1JGeThXeWRvNm42YTErTVRBdmNC?=
 =?utf-8?B?c2w3NnlCeTNrOWFpK2ZkUG1aeFVZTWNpNGVkOVB2aHhQMUhENXNTdUVZRkNW?=
 =?utf-8?B?Z05kVVYvNXRKby9hemFlMGFET0dLY1dXMXpmdk5veXltK0k0YjRLYUU1Skd0?=
 =?utf-8?B?NVRlZ1hXUVhMMU9NbUkvbUFLajZwNjUxb05mM3hkTjBCSGloczRxMC9ETHp6?=
 =?utf-8?B?Z1RGV0RaaUNSc3FtT3dLMmJlcEJKRXUxUWkxcGZsaWFUQ2tqL3dTVVlOb2ln?=
 =?utf-8?B?Qkg0SGRmcHg3cnZoM3dGUFRKTXFQdVVFMDFrRlRZRnQ1Slp6U0tpZGptZTFS?=
 =?utf-8?B?YmpEZ3VmSWg2bWtZR3FhRjkxQ0VvdURHWmwrYjZmMTJyVVFnd3ZJYml2UStH?=
 =?utf-8?B?RU54bVk1eVV4Z0Jka0x3c3l6V1FoZ1dBMFUwZHZOcEUxWFV3OUhyQi9XQU5m?=
 =?utf-8?B?eVMwQWNDQWNLVzhTMHFkWE5iU28wdDdwc0RpZm95b1pJQlpaZG9DUmc3cXMw?=
 =?utf-8?B?djViVm9TTEhreWY1Skd1U2thdUgzNWtoT0tobEh1eDJ4dDkxcDE1UDA1Y0lh?=
 =?utf-8?B?QWVjZldXanRhazJqZnV2aWRuVVhaNDZCM0pyZUF1a3BadmJPaWFmODRpMWxI?=
 =?utf-8?B?LzBZU2d0N1BUajJZYXZOd3ZxbkdvcTFiZmRnaGhCT1V4dE1TdWVFbTFwMW1N?=
 =?utf-8?B?bXhVMlBLMVlmUnNkWGdNZ1Rld045Nkc5cXo2WDJLRG9UZktjNXJUWk1LNU9N?=
 =?utf-8?B?Q0ZEWS9zMW51S1F0aUcrVVJTdmU0MXFzT3NqTXFLQm11QjE1UlhSTjNrYTcw?=
 =?utf-8?B?L2ZzMVl1ckpINUllMUI3dVBZdVU1Zm5UckZpeGpYK2dVakU5NUwvb2hjM2x5?=
 =?utf-8?B?bTJMS0hOT0ljbGVNSlFYc2JiTjBJR1hqaUNrdjJqODZFRWgvQ0dlMUNMZys3?=
 =?utf-8?B?aEVweEtvdytuVzFpUTNVV25iZDZkOTlHdFBZS0tCNm1lMElZQWNQMjhTWFJv?=
 =?utf-8?B?aldVWWU1WGIwR3IzenNSUGUvTXlCRTlGOUk4a0ZKSWpoSE9BdFViSFpOeDFu?=
 =?utf-8?B?ekw4eWoyTnF3UkluKzIzRDM4RENwY0FaL2ZQYWhiU1dLQkJWWDNiVmRIUW1v?=
 =?utf-8?B?UmNpSjZ6TmZ2K21NZzdLajJkdit1SWVtaWIrOC9VN0NLL3pPRXdEY2NaMUNW?=
 =?utf-8?B?Ny9JSHZkQkx3T1lVS2tjZ2hqaStnQkRIWG42aklHNmxlVFN0OVJBWW9qRXBl?=
 =?utf-8?B?R2JsSCtDNWhZaVA5dXBUNnc1b2dIZGRDeHVzQ2w0MFRTQXZlMFRRT285UWJR?=
 =?utf-8?B?OGx1QjdSN280R3JxMzF4QTA4V0Y4Z1VNa2ljbHBTY1owSCtWbUVjbjlZOU1w?=
 =?utf-8?B?bVVaWEk5NmJ5YlR3VWNXVnU4UmVZRFFOdWJWWGg5cWtJWVBTNHNISkR6bmtp?=
 =?utf-8?B?eUFhQjhjOE5JaFBwQU9qWXhVbFFUMzFXK05Hd2J0SytJTzFadnBJdWpWRjYr?=
 =?utf-8?Q?q1mKC9c4Zdb1q?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 900f7124-d954-468a-c516-08d929ccfb31
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2021 15:57:41.5755 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vUeGOJ9YZpC2fB3HZ9z26HZ9miVibwzUNEwOc93HfO3dGoVp9p6fO/40sI/acGfg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2578
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
Cc: "Ming, Davis" <Davis.Ming@amd.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Do you have the hash for this commit?

Thanks,
Christian.

Am 07.06.21 um 17:30 schrieb Khaire, Rohit:
> [AMD Public Use]
>
> We don't need RING1 and RING2 functionality for SRIOV afaik.
>
> But looking at the description of the original commit message it affects RING0 too?
>
> " drm/amdgpu: add timeout flush mechanism to update wptr for self interrupt (v2)
>
> outstanding log reaches threshold will trigger IH ring1/2's wptr
> reported, that will avoid generating interrupts to ring0 too frequent.
> But if ring1/2's wptr hasn't been increased for a long time, the outstanding log
> can't reach threshold so that driver can't get latest wptr info and
> miss some interrupts."
>
> Rohit
>
> -----Original Message-----
> From: Koenig, Christian <Christian.Koenig@amd.com>
> Sent: June 7, 2021 10:31 AM
> To: Khaire, Rohit <Rohit.Khaire@amd.com>; amd-gfx@lists.freedesktop.org; Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>; Deng, Emily <Emily.Deng@amd.com>; Liu, Monk <Monk.Liu@amd.com>; Zhou, Peng Ju <PengJu.Zhou@amd.com>; Chen, Horace <Horace.Chen@amd.com>
> Cc: Ming, Davis <Davis.Ming@amd.com>
> Subject: Re: [PATCH] drm/amdgpu: Use PSP to program IH_RB_CNTL_RING1/2 on SRIOV
>
> Why are the ring 1&2 enabled on SRIOV in the first place?
>
> Christian.
>
> Am 07.06.21 um 16:23 schrieb Rohit Khaire:
>> This is similar to IH_RB_CNTL programming in
>> navi10_ih_toggle_ring_interrupts
>>
>> Signed-off-by: Rohit Khaire <rohit.khaire@amd.com>
>> ---
>>    drivers/gpu/drm/amd/amdgpu/navi10_ih.c | 20 ++++++++++++++++++--
>>    1 file changed, 18 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
>> b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
>> index eac564e8dd52..e41188c04846 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
>> @@ -120,11 +120,27 @@ force_update_wptr_for_self_int(struct amdgpu_device *adev,
>>    	ih_rb_cntl = REG_SET_FIELD(ih_rb_cntl, IH_RB_CNTL_RING1,
>>    				   RB_USED_INT_THRESHOLD, threshold);
>>    
>> -	WREG32_SOC15(OSSSYS, 0, mmIH_RB_CNTL_RING1, ih_rb_cntl);
>> +	if (amdgpu_sriov_vf(adev) && amdgpu_sriov_reg_indirect_ih(adev)) {
>> +		if (psp_reg_program(&adev->psp, PSP_REG_IH_RB_CNTL_RING1, ih_rb_cntl)) {
>> +			DRM_ERROR("PSP program IH_RB_CNTL_RING1 failed!\n");
>> +			return;
>> +		}
>> +	} else {
>> +		WREG32_SOC15(OSSSYS, 0, mmIH_RB_CNTL_RING1, ih_rb_cntl);
>> +	}
>> +
>>    	ih_rb_cntl = RREG32_SOC15(OSSSYS, 0, mmIH_RB_CNTL_RING2);
>>    	ih_rb_cntl = REG_SET_FIELD(ih_rb_cntl, IH_RB_CNTL_RING2,
>>    				   RB_USED_INT_THRESHOLD, threshold);
>> -	WREG32_SOC15(OSSSYS, 0, mmIH_RB_CNTL_RING2, ih_rb_cntl);
>> +	if (amdgpu_sriov_vf(adev) && amdgpu_sriov_reg_indirect_ih(adev)) {
>> +		if (psp_reg_program(&adev->psp, PSP_REG_IH_RB_CNTL_RING2, ih_rb_cntl)) {
>> +			DRM_ERROR("PSP program IH_RB_CNTL_RING2 failed!\n");
>> +			return;
>> +		}
>> +	} else {
>> +		WREG32_SOC15(OSSSYS, 0, mmIH_RB_CNTL_RING2, ih_rb_cntl);
>> +	}
>> +
>>    	WREG32_SOC15(OSSSYS, 0, mmIH_CNTL2, ih_cntl);
>>    }
>>    

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
