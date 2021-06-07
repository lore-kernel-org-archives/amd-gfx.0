Return-Path: <SRS0=JNIh=LB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8635C47094
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Jun 2021 16:29:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 778D861C62
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Jun 2021 16:29:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 778D861C62
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2D8816E927;
	Mon,  7 Jun 2021 16:29:57 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2054.outbound.protection.outlook.com [40.107.220.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 835926E927
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Jun 2021 16:29:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HvzAVgcCA4YhW60cBh39Q18/k3DEP30OSoJjD6of+7yv8+YuaWkIBY9AshBNww9So9nXn4jw67N6iQLoS4oCNtLo2SvSWbBO16Jz/nvzxqPjjwJheBAKsYjcFTFzX9eNtSN5HbnDSyBLg3wF8hZ/jiQW8m3urzDx4ZyRHm/Re3GPVr/BaHCcSqMLe9v0NjlD2qqFZ5O/zZ11pwKF0FM29FCozF56W7tAFPT1Csf8gY8Ejxg3LDpo95c7yyOgy6N0lVz+9FC0BEkKt0/cdKwwBlZHXFI3n1rF3R9yHnsRtazyV7UnTMQ2g8SSuaSOJHTOPQ58k+5xGYgTgR4e0Gen1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cTkN3bu0y/GAnycOGCJaACuRxmVYTrVk/gQ3o8G3BXk=;
 b=LhcmNpcvHKLRICEGbATIrK+AioqQ7FkHSufp20qywds5iHFFrRKR/kNG88lIfS8zbu/RH1JKIMROPtE04FW7YQHQnJy5iFeuvHVd4PGJdGi7vPZ3eJniodsxrGmgdDOZashcomaGn1oOI3jx4iQcX07HkktjgC//I5MquLYrAEYf7TvtkuE3R527mu3LVaARI8OIN6g21mCPGOFByreWhshrVF55C5mJGH6lcubznGUizrADGKxLM3tAsPOzSQCXNf1XzXIfVGWHjO+AIsr+eYO1lAqUy2Hbvg8fg6Xsw2XfL/m1g4JywLSAB/5Z9pT9v/vZPLmwsx83EcQOR0BEHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cTkN3bu0y/GAnycOGCJaACuRxmVYTrVk/gQ3o8G3BXk=;
 b=MUTANXCHY8stIxEt6mUuNrpm604dBO2gk9lX5kwKHGxjVV7K0alvkWU4+fJTb39KGxej7L28q08AZw+BlXM5eNZ9SR1fCvJyUpGzkM0pKa80g4GJj1ikwNvi8IwZh1lRNUkIhZsipqTgqi0+yaqy93ihZqmfiSyW+Br4CbbIouA=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB4549.namprd12.prod.outlook.com (2603:10b6:208:268::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.23; Mon, 7 Jun
 2021 16:29:55 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::6d4d:4674:1cf6:8d34]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::6d4d:4674:1cf6:8d34%6]) with mapi id 15.20.4195.030; Mon, 7 Jun 2021
 16:29:55 +0000
Subject: Re: [PATCH] drm/amdgpu: Use PSP to program IH_RB_CNTL_RING1/2 on SRIOV
To: "Khaire, Rohit" <Rohit.Khaire@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Deng, Emily"
 <Emily.Deng@amd.com>, "Liu, Monk" <Monk.Liu@amd.com>,
 "Zhou, Peng Ju" <PengJu.Zhou@amd.com>, "Chen, Horace" <Horace.Chen@amd.com>,
 "Kuehling, Felix" <Felix.Kuehling@amd.com>
References: <20210607142343.13509-1-rohit.khaire@amd.com>
 <392d7f26-51d6-f60e-6081-870afe8276b7@amd.com>
 <BL0PR12MB4755039C3515004ADD1051AA87389@BL0PR12MB4755.namprd12.prod.outlook.com>
 <da0025b0-308f-6f2f-e4d8-b5a68117828c@amd.com>
 <BL0PR12MB47552C90D8667E1107279AD487389@BL0PR12MB4755.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <bf87ed0d-d32d-5701-f9bf-c71f6a6b23b6@amd.com>
Date: Mon, 7 Jun 2021 18:29:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
In-Reply-To: <BL0PR12MB47552C90D8667E1107279AD487389@BL0PR12MB4755.namprd12.prod.outlook.com>
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:ce67:4e4d:875d:ffeb]
X-ClientProxiedBy: AM0PR10CA0117.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:e6::34) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:ce67:4e4d:875d:ffeb]
 (2a02:908:1252:fb60:ce67:4e4d:875d:ffeb) by
 AM0PR10CA0117.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:e6::34) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4195.20 via Frontend Transport; Mon, 7 Jun 2021 16:29:52 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b610fbd6-5884-4546-5ca4-08d929d17b20
X-MS-TrafficTypeDiagnostic: MN2PR12MB4549:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB454997A11283EA29BBE8EDFB83389@MN2PR12MB4549.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1227;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vvhdI6os8QoSeAk5raTBiDnKk5i3AymtdZqHb0QK6+/Ej+l1tEIhXvKFpo6dXXfzcr7tlcYZ6qSpJAbwbBx5WbQyG1yljNGH4YEp1a7GrVmHZ3JKSw/nkNC1dd7f5RO60kR7j1pDDt8dTe+132p/gmyd1hl/Z9vPJOWkG/dzoH4G/5f9nlr6HOUqLhgYStNITDhIa9mRtlVT58ywnsP1hxQOffZUTlkm/PZzUPI6DZY86l83nUEL/vFIzjzjQnE5+BOkiCAIEzd10QVKuB1PH+qxlUotVPZUPAzhMEHXrCDo/2UhaZIBoUQu6d4oEdsbtEJpmyD0EjW0zhQlsJQFLAI15snd7ntWMnhxqEMblntrfeupE5tEzhBbfT7r8riT0JVau3FW1uj3lTxKz9CLTMyUH4yAROixgqkO1ytWA1qF7BbS7aYS3REmTFeLKyP1v/T+58ROUM8t9mb2pmHWur0n27RKqUffq7sif6BSYrv9N7FLhGo4LKA1JD+pgYDk4pFQEwog69tmHXHu87ivp2H0Nh1tIwBwYGfq7ayfGMSn5qjU/7D/Evk82B3hvacP8WuA3EB9dgSuUnVs5ieJ2+ksQ+5jPiPjciSZzscRHFAO2c0epvr66bFCYRcGZHfGxGqJUvpJMucKKYoQor0TWiRr+Bfb59CRmCDfs8HWMc1dHrhaCwtNlqEmHybSG8brcagBuwALga+Qr6BICsp0fQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(136003)(376002)(346002)(396003)(39840400004)(8936002)(66556008)(921005)(478600001)(110136005)(316002)(31696002)(38100700002)(53546011)(4326008)(36756003)(186003)(16526019)(2906002)(6636002)(6486002)(31686004)(6666004)(66476007)(66946007)(5660300002)(86362001)(83380400001)(8676002)(2616005)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?NFdYMUwyUzcyRDZMSnhZUlkzcDFCLzc1MFpoWnpaSkd4QWhRQ2duSjNpbG9O?=
 =?utf-8?B?TzkwSldYWjk3UjRVUUpRWGJUbVNJWG5FVGhRQjg2dWNiaHBmdUdFWGNoTFBW?=
 =?utf-8?B?WU9rVWlhWkc4Q2VyYzhJSG02Qk1VeWhvZHpqY2trTFc5eFlBcHJMQStVK1BG?=
 =?utf-8?B?ZnJyVXMyOVpvUzZvN2FVNFp5eTU0VG0xbjFHRXNGRkYwY2t4bjhnSGxDTUxO?=
 =?utf-8?B?NTBhck8zYWFrWElaY0FzeVZzbDRpN25WVkNJQUlOSmU3ajlReWMzUnNuTm00?=
 =?utf-8?B?K1VpVWZQN1EzZStrSFAxdWJmYXJxWm1FTm5wYmxwKzR3YUhkOWw5eDBTZTVQ?=
 =?utf-8?B?TjgrL2tpcWVyR1RFT0Q1VEw1ck9CUDZoQ2VEb3FqNVFCUnBiMkNuTFdCSlZ6?=
 =?utf-8?B?VG5aQmd3czdRTml1RVFiRFJJR3haOVpEalFJQm4wd09wNEJ0SG9xVFpybzhC?=
 =?utf-8?B?STZ1SEN5Z3BWZHorUWF6d3VJWm5kVDhGU1lIM0NkblMxLzU3RzUvR3BlNHJ3?=
 =?utf-8?B?MTI2UTYrLytyd2pxMm9uVUNzTkxRWkNqeEdDWVZLTzUwNlFJZE8vZU9rTUJ5?=
 =?utf-8?B?ZnNlQmMvcmFHZmlnc1VhVEY5QnBzeVRCVjlZYnFRN2ZtV1ZQNlVLRml1b2xl?=
 =?utf-8?B?ZFRBanorSENjSUxUVEpzN21YdEYxb0J6ZWYwY0FqVjVWNS9VV1o0WVhWOWF6?=
 =?utf-8?B?ZjlxSStOSktjWjNQM3VDODFGUm1ya3BMc0F5SUdDZCtFaHNRbThhNzgxSEhY?=
 =?utf-8?B?UCtQaE8rOUdCamtlNG4vV0VpOTRTQ1ZiM2FBc1ZWSlprcFBoVzhXOUR1eW9M?=
 =?utf-8?B?aldRSkdEY2JIaEpqSFpSczJJNGhpbjY1bXJaN09jYnhnajk0V012VjBYT2JB?=
 =?utf-8?B?MzRNckdKYXYwSlhsMXA3UHZDVllyamRlSWc5clJzYlNXWWpmWjBaRFRZRkNz?=
 =?utf-8?B?S0tJek1FNXlkaGdaZzBhVlVoN3lpTndJVkg0SGZTeVd5akRkVTNyMTJhbTN0?=
 =?utf-8?B?OHZYeW9ndkxoRFRqdEw1c0dIcDRCZ3RIVkxwTlhPeXNMWmc1K282NkdLdjZF?=
 =?utf-8?B?UkVLYzZZdktmNjdINmJyV2FyMzZkMlZUaFNMR0FRWEEza2xoamJ5RnJBOGJI?=
 =?utf-8?B?eXlTVW91ZklranVZdk83aW5ncmZWZXkxdE81a2t3dDhULzdDYzkvNlJ0UW5r?=
 =?utf-8?B?bTdUMURrV2s2K0JHTldQc3ZWQUhoZ2pkNWxnazZMWnpoMHZxbkZESUU4dEFl?=
 =?utf-8?B?RlgvWldNbFMyWnlIZ1d2RHp2RitaVVZhTUdVUFJQTmM2ZGNXU0VzWW1KaXQx?=
 =?utf-8?B?U0lHYTJzL24rWDJyZVEzc2l1WXJqamVvQ0RjRDhVK1Fjckp4cVhWalI4TFVV?=
 =?utf-8?B?UEdLZGtzQk1TazJBTmZiN3J5QmlmbjhrdFJ3OFJlMUNScmVXUkpKampCdE5v?=
 =?utf-8?B?anZhKzRSajFvOWVXd1UyOWNzei9qWVQyMWdzRFRyRGE5R2k5TFBsRThTV0s2?=
 =?utf-8?B?TThTMGFMa1BxQnphWUw5dmRnS1k5bjdqYkgwUTJ5Z3U5bno2K1VMUy9jSWdZ?=
 =?utf-8?B?VHFDWlFIYkkva3ZtbjNva0lRTTBrKzdYdTgxWUxPbUhrcTFwYnpkTVB2elJO?=
 =?utf-8?B?N2dMN3lZWXFlU2xyUzAxRjJYRzQ2R0FaalZRVERZTFRITkEzMTBmTzdsblN3?=
 =?utf-8?B?TGZsVlF6TzNWL2w2MnllMHdHazFNdjcvTmw5Z0hGZmdNVkJvQVdCRlh0bk42?=
 =?utf-8?B?b3h1Mml3SXdRUk1HNUxUaHlRWEdUcjBBMFV5OE9YQW9nTi9mV0h1cDcxV2hC?=
 =?utf-8?B?eGZ6MnV2bGp1R3lId2Y5dEpaNjNaV3RQbGs0RGkyOGtvc01IRUlGRnlWbzJj?=
 =?utf-8?Q?83QbzkjaQu60p?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b610fbd6-5884-4546-5ca4-08d929d17b20
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2021 16:29:55.1401 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g6JbY9Xl+XBCHXTO88zs9ic0rR1b2V+y1rZQZkKi2464Q57KimWaRRC7F0kxiXe+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4549
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

That's a workaround for bare metal and as far as I know doesn't apply to 
SRIOV.

We only need the additional IH rings for page fault handling or log 
handling and as far as I know that is incompatible with SRIOV for the 
moment. But Felix might have some more updates on this.

So as long as we don't support that under SRIOV we don't need this patch 
either.

Christian.

Am 07.06.21 um 17:59 schrieb Khaire, Rohit:
> [AMD Public Use]
>
> The hash is 5ea6f9c
>
> Rohit
>
> -----Original Message-----
> From: Koenig, Christian <Christian.Koenig@amd.com>
> Sent: June 7, 2021 11:58 AM
> To: Khaire, Rohit <Rohit.Khaire@amd.com>; amd-gfx@lists.freedesktop.org; Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>; Deng, Emily <Emily.Deng@amd.com>; Liu, Monk <Monk.Liu@amd.com>; Zhou, Peng Ju <PengJu.Zhou@amd.com>; Chen, Horace <Horace.Chen@amd.com>
> Cc: Ming, Davis <Davis.Ming@amd.com>
> Subject: Re: [PATCH] drm/amdgpu: Use PSP to program IH_RB_CNTL_RING1/2 on SRIOV
>
> Do you have the hash for this commit?
>
> Thanks,
> Christian.
>
> Am 07.06.21 um 17:30 schrieb Khaire, Rohit:
>> [AMD Public Use]
>>
>> We don't need RING1 and RING2 functionality for SRIOV afaik.
>>
>> But looking at the description of the original commit message it affects RING0 too?
>>
>> " drm/amdgpu: add timeout flush mechanism to update wptr for self
>> interrupt (v2)
>>
>> outstanding log reaches threshold will trigger IH ring1/2's wptr
>> reported, that will avoid generating interrupts to ring0 too frequent.
>> But if ring1/2's wptr hasn't been increased for a long time, the
>> outstanding log can't reach threshold so that driver can't get latest
>> wptr info and miss some interrupts."
>>
>> Rohit
>>
>> -----Original Message-----
>> From: Koenig, Christian <Christian.Koenig@amd.com>
>> Sent: June 7, 2021 10:31 AM
>> To: Khaire, Rohit <Rohit.Khaire@amd.com>;
>> amd-gfx@lists.freedesktop.org; Deucher, Alexander
>> <Alexander.Deucher@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>;
>> Deng, Emily <Emily.Deng@amd.com>; Liu, Monk <Monk.Liu@amd.com>; Zhou,
>> Peng Ju <PengJu.Zhou@amd.com>; Chen, Horace <Horace.Chen@amd.com>
>> Cc: Ming, Davis <Davis.Ming@amd.com>
>> Subject: Re: [PATCH] drm/amdgpu: Use PSP to program IH_RB_CNTL_RING1/2
>> on SRIOV
>>
>> Why are the ring 1&2 enabled on SRIOV in the first place?
>>
>> Christian.
>>
>> Am 07.06.21 um 16:23 schrieb Rohit Khaire:
>>> This is similar to IH_RB_CNTL programming in
>>> navi10_ih_toggle_ring_interrupts
>>>
>>> Signed-off-by: Rohit Khaire <rohit.khaire@amd.com>
>>> ---
>>>     drivers/gpu/drm/amd/amdgpu/navi10_ih.c | 20 ++++++++++++++++++--
>>>     1 file changed, 18 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
>>> b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
>>> index eac564e8dd52..e41188c04846 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
>>> @@ -120,11 +120,27 @@ force_update_wptr_for_self_int(struct amdgpu_device *adev,
>>>     	ih_rb_cntl = REG_SET_FIELD(ih_rb_cntl, IH_RB_CNTL_RING1,
>>>     				   RB_USED_INT_THRESHOLD, threshold);
>>>     
>>> -	WREG32_SOC15(OSSSYS, 0, mmIH_RB_CNTL_RING1, ih_rb_cntl);
>>> +	if (amdgpu_sriov_vf(adev) && amdgpu_sriov_reg_indirect_ih(adev)) {
>>> +		if (psp_reg_program(&adev->psp, PSP_REG_IH_RB_CNTL_RING1, ih_rb_cntl)) {
>>> +			DRM_ERROR("PSP program IH_RB_CNTL_RING1 failed!\n");
>>> +			return;
>>> +		}
>>> +	} else {
>>> +		WREG32_SOC15(OSSSYS, 0, mmIH_RB_CNTL_RING1, ih_rb_cntl);
>>> +	}
>>> +
>>>     	ih_rb_cntl = RREG32_SOC15(OSSSYS, 0, mmIH_RB_CNTL_RING2);
>>>     	ih_rb_cntl = REG_SET_FIELD(ih_rb_cntl, IH_RB_CNTL_RING2,
>>>     				   RB_USED_INT_THRESHOLD, threshold);
>>> -	WREG32_SOC15(OSSSYS, 0, mmIH_RB_CNTL_RING2, ih_rb_cntl);
>>> +	if (amdgpu_sriov_vf(adev) && amdgpu_sriov_reg_indirect_ih(adev)) {
>>> +		if (psp_reg_program(&adev->psp, PSP_REG_IH_RB_CNTL_RING2, ih_rb_cntl)) {
>>> +			DRM_ERROR("PSP program IH_RB_CNTL_RING2 failed!\n");
>>> +			return;
>>> +		}
>>> +	} else {
>>> +		WREG32_SOC15(OSSSYS, 0, mmIH_RB_CNTL_RING2, ih_rb_cntl);
>>> +	}
>>> +
>>>     	WREG32_SOC15(OSSSYS, 0, mmIH_CNTL2, ih_cntl);
>>>     }
>>>     

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
