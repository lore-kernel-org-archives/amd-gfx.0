Return-Path: <SRS0=VIdG=L2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACA59C11F69
	for <amd-gfx@archiver.kernel.org>; Fri,  2 Jul 2021 09:02:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60CFB61402
	for <amd-gfx@archiver.kernel.org>; Fri,  2 Jul 2021 09:02:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60CFB61402
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E27486E073;
	Fri,  2 Jul 2021 09:02:56 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2076.outbound.protection.outlook.com [40.107.237.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5AEBD6E073
 for <amd-gfx@lists.freedesktop.org>; Fri,  2 Jul 2021 09:02:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MmrpOjvh9yyp+1N/iCUd+t4et5DWTima4+tRQRG0DanRqfhvfoa/Kx3UuVyChhf1vu0TnX/FzcxYoQe7MBX+Y/RAqSaNs+xc8kKwPdlqjk4xm/yO6ROhYNzzJmysO6A3J0tRY1JXxcTQgCKZyYlTelqqnHgc2gQhKDgacd8PmxgSseKjv/kEN2yT4qK19qCv1KMQMPA1LFfK7+UUcBhxkp5uReAmzynPJjagM9ydoOKZk0DOiM0OWDCBBAkHmq+Mty3qyLRr7SErnI3Q0m0zz86zqS0aUznIf6nZ9YnLPsHyq+n2gxDP+qqK6GpQEYq3rzdfNPsJ8G4mwY6lv0y4vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mQ0znPnSyDA8Zi6nH2hWqUbUFVk9cRRg7OB31STxuu4=;
 b=nOdaXtizBAVHGgH/CzBuHgg7bcGsMQNtjoKquy2fk2sj2rwR3ClP3EPO7gjffDu3iZSabhSvRBCxLc6YjbNI+hBRe6gky2RB+AZBe0F7pspuLqrpIuaNyiH9uoY9eQvV3WWdHxciijQ+jCncs2h5RhL8Xun75RQIzHPe9QSU0M9yH5j9iamoPlW57/6l3RqUvRHQSQs5tltRBOX24Z7Rnf1ldzVcyN8hzShzn9cx/kSzVNUsruHzno4GT7TOTmf0anubvAv2525/vcOe8WrOj/fkuMFa2rbyUqAK8wvvSszDgrCqRkw12PcVDrpFHAIW0hXtpc37t0Tsc2nAdHj8Ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mQ0znPnSyDA8Zi6nH2hWqUbUFVk9cRRg7OB31STxuu4=;
 b=1fhs9/oimsZXNocoL/8kH7qpPZrRVpcY2xg3gHxxnPadom4yPspqbB5Ym580Lus9oKJexpvNxIJusXw5jjVRD0u6gIJfyIQO9uj08MVmu45WUEsUbwIni5WiGlxZXZaM/gqhJcObdbrYuAphkIy55YUBgTVj20DiX8L5eQW9NTM=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5136.namprd12.prod.outlook.com (2603:10b6:5:393::23)
 by DM8PR12MB5399.namprd12.prod.outlook.com (2603:10b6:8:34::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4287.26; Fri, 2 Jul 2021 09:02:54 +0000
Received: from DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::fde0:6f07:7dfc:8097]) by DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::fde0:6f07:7dfc:8097%5]) with mapi id 15.20.4287.026; Fri, 2 Jul 2021
 09:02:54 +0000
Subject: Re: [PATCH] drm/amdgpu: Correct the irq numbers for virtual ctrc
To: Emily Deng <Emily.Deng@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210701043743.10663-1-Emily.Deng@amd.com>
From: "Das, Nirmoy" <nirmoy.das@amd.com>
Message-ID: <f5db6355-1894-a796-75a4-8b2c9e5780d1@amd.com>
Date: Fri, 2 Jul 2021 11:02:48 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <20210701043743.10663-1-Emily.Deng@amd.com>
Content-Language: en-US
X-Originating-IP: [2003:c5:8f22:6c00:4d88:c460:df07:5204]
X-ClientProxiedBy: PR3P192CA0014.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:102:56::19) To DM4PR12MB5136.namprd12.prod.outlook.com
 (2603:10b6:5:393::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2003:c5:8f22:6c00:4d88:c460:df07:5204]
 (2003:c5:8f22:6c00:4d88:c460:df07:5204) by
 PR3P192CA0014.EURP192.PROD.OUTLOOK.COM (2603:10a6:102:56::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4287.21 via Frontend Transport; Fri, 2 Jul 2021 09:02:53 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3d04c13d-73fd-41d1-6b41-08d93d382d89
X-MS-TrafficTypeDiagnostic: DM8PR12MB5399:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM8PR12MB5399FF219AA3DBFFB24F6F818B1F9@DM8PR12MB5399.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:40;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RMuNDmKkJj9utn/dU74oy79yt5dSigCK1/EgKay+dyI5VkkMdz9X6iN3oeASRVoubchqiNUK3njEUNiU8gPDkYhY5/QgHz0wtQw7fYLChLEpKtuQVAOFg3MyYvzHT4fynsKr3pmATqS3Bvwvk9K/H1eAc9jEQeibkPx+h2ewWDBM5oU9b4ifhrfS6lvrlEJomZa1379yjVsOw50zlpDQK4cdDjFMDjwkCvqcVnjhnrsZdW7VjPsfF3ULE86BRBkwuldyixyflEHFw2x4kbfGWyyfVy0POJ4RrYsCAx7jqjJElCCZ+7Z1dcKBC1ANeO57kruws0UOGU2FAIBCj4dXBYD6/MpsiOyyHo4Q/zr7xd/shouZvHX+dyMXUhOgpJggQOm8Zmdg20ijFsl7cmJofRNw0xk0V8dyss+qNz0WeSEfhic5ex3OK/I/CKeKPq3p8CMo1Jyzq3GS5ZQ71nTfl51EplhT7y9wOAMVFMqWGONrR3PPoldVd8JQAM5LLUNIDgqjMOQ3Bs7n/nqpTbTcDOe5uoh1Yk9P86A2QeI+RtTt/RI/Vz6RFlBkBtlNtsm5S9g0+4oArHP0JjMkxIamFmmwCtkiGlarsco1iDq9a7hZI19hJ94B7dU9nVGluEsZtXAElCCAQvEWywHTVW0LVpLX8454PXkcQpLTijp//R9LQw29a3rUuy9LhgzSZ2hKM0BOYpu2noXX/sZPEm15k8YGkSHYyygqLhoCfJYD/Gg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5136.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(376002)(396003)(346002)(39860400002)(4744005)(8936002)(31696002)(53546011)(86362001)(31686004)(2616005)(36756003)(4326008)(186003)(16526019)(8676002)(83380400001)(66556008)(2906002)(6666004)(38100700002)(5660300002)(478600001)(66946007)(316002)(66476007)(52116002)(6486002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OFBDUG1KT0pKWE1oRFhKQklqcUJVbVdISWlTZW5DK2dwTzZ6ZUYxSklTRkNO?=
 =?utf-8?B?Q3pydldUaUlSTXB1Q09DK3ZoTitaUHFZZU1xemQzTXVRbTVYM2d6Z2VjS1o2?=
 =?utf-8?B?Wi9MTUtobzZydktYM0NQYWR6ZUJDai82WWo3RHlyRFZVR3orSGxkdUZmaGdI?=
 =?utf-8?B?bSsrY21wcWJaQ2E5UkFFUS9RcURCeHhkaHNaOFp6UFNKK3lERHhncldIQnJt?=
 =?utf-8?B?elpCMmZKNWFyVC9JcFF6cTIxc1A2b1RycnBFVlplYjU5R29nWWxKZzFVK244?=
 =?utf-8?B?M2JUdjl3ZW0yRTUzaW9obk55dXdzZEgvQUZNMXRkTExTV3FadzIxVFU2RG93?=
 =?utf-8?B?RUxKNG1CajVkbG9kQWFLVjF6V0hOUlhpSXB6dFpiRm8rVUpLVnJJSWpKVFZL?=
 =?utf-8?B?T2FjdVRmOTAwSjZYNzVhWW1ZYWRzR3BadzlpL0VUWkZ4QjgzdTFiSXpIRVZT?=
 =?utf-8?B?TjdiSmdwanRrWXl6YW9uSWVTRUUyZTZRQjlYd3RpQXkwT0tZNElrdnIwS2lP?=
 =?utf-8?B?bnZETGQ5RkhqK2dnTnMzYmRQQ09oWkxzNjljTWxUNlJzNmRuNDNnZWZTekJ3?=
 =?utf-8?B?Mmo2YllrUE1FMFpJdmp4YW42dGFCTDFMdW0xTURyQzN3dVBGd2QxMVdYQjhM?=
 =?utf-8?B?Wk8rOVZHb0pESWlIZnptTVNoM1dzbDZvZlAvMEgzRjV6RzA0UC9KakJwRi9i?=
 =?utf-8?B?U1hKR0JxY1ZJU1JqY3JzUnJBNG45ZEE0c21SUVBFeWx0S1R1YXEzbVlKOVow?=
 =?utf-8?B?U1dzaXRUSkpOQ2J1UGRHME14eVFTNE1KSXJCZDl4WWZTcXNTL2tpcTdoZEY0?=
 =?utf-8?B?c1ExdHkwckJFWUU5RHdlWnJRWEtIa1N1V0s0Vk9JR05ZL3I5WCtLcUxpaFd0?=
 =?utf-8?B?WDIrMEYxMHQ4TXR5dmJwUFhZY0MrUFExR253b2t6S011QStXKzB6dENrWUpn?=
 =?utf-8?B?NC92Q1J4RmloWGxnNmExVjVuR1J5N3NCajJBRi9SbENldFhnbXhWOHNteFRy?=
 =?utf-8?B?OWJkZjlOMDc2Sk15NlNhdmFzLzFWcmJNckhPZjRpUFBWa05iZUxXRG43dW5H?=
 =?utf-8?B?NmQ0Vk92MUszT3E0Q2FrT2V0bStCNXdaekg5NXVHTlhtcURRK1VaQjA0ajQ1?=
 =?utf-8?B?MzNBNzdsalZzVklFRngxQnM3UC84OTJGRGFzRDYvWUpNcTdtYmtaUU1jNkUr?=
 =?utf-8?B?cGVTUmVoY1lucXBBM3d4N2RBYVNNQWhZaXFvajN5dU1QMkI0dCtlekVweHMr?=
 =?utf-8?B?eSs2WHJjWmNrVDVpbXF4MnoxYlc4Q24zYmRQMVZzVGFZODl3UkhCRmtNeXIw?=
 =?utf-8?B?M2ViMXUwZ2RUUlRiTnY3TUFrem5UN0l0NjVYcUFidW9vQlN3dnZCUDIxenpk?=
 =?utf-8?B?Qk95WGJPVUozR3RXTEpyUVc2c2lGWGpDa3JnbTF4TlJRK01BS3lOR21waUxQ?=
 =?utf-8?B?S1dpV0ozZjhUbHROaktrR2VQZTVqMTJlY29FYzlCdWkzYTRLbkZXZXJ0Sy9t?=
 =?utf-8?B?czlITUo3TTUxODBFcmN0ZDd3VlgzKzVGdWtjZTlBKzYwUmxKZytnMWlzb3Fv?=
 =?utf-8?B?YUJlMnFpVDNidk5LUlhDUDNpZmVyTjRJam1xRGQwdUFrTTArVW10UlBuT3NB?=
 =?utf-8?B?WVp6M1ByeGFNdnBhTUZLem1mTjFoZ2dFYjBJZThkTVloempjQnJXeWQvYTB4?=
 =?utf-8?B?UHp6RForOXRXL3FPd0VpMCtST0tkdUFZM3BJTnhQUkxQUzFBYXhmL0V6Vjhi?=
 =?utf-8?B?NmN2VGQzU0V4WkRZcnRzVERGV0JUYktGcFdScHhNMjRGRlRwMmFlZWdqMTU1?=
 =?utf-8?B?OFpJOUZWY2lOaDFXVUo3eEs5bGl3YTVmOHhkLzBHNXl1dTUybkJ3SkIxTWNv?=
 =?utf-8?Q?Iyn3pDpDjZroe?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d04c13d-73fd-41d1-6b41-08d93d382d89
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5136.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2021 09:02:54.2493 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XGB7uNiNQ/7+sBEFAQrsEFSb9jQEG5kzVh2/M3l+471NxPjxhoKwxCTWctEnTvGFpemTdki0phR187ZqNVR7Tw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5399
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
Cc: Victor <Victor.Zhao@amd.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Please describe bit more with a commit message.

On 7/1/2021 6:37 AM, Emily Deng wrote:
> Signed-off-by: Emily Deng <Emily.Deng@amd.com>
> Signed-off-by: Victor <Victor.Zhao@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/dce_virtual.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/dce_virtual.c b/drivers/gpu/drm/amd/amdgpu/dce_virtual.c
> index 33324427b555..7e0d8c092c7e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/dce_virtual.c
> +++ b/drivers/gpu/drm/amd/amdgpu/dce_virtual.c
> @@ -766,7 +766,7 @@ static const struct amdgpu_irq_src_funcs dce_virtual_crtc_irq_funcs = {
>   
>   static void dce_virtual_set_irq_funcs(struct amdgpu_device *adev)
>   {
> -	adev->crtc_irq.num_types = AMDGPU_CRTC_IRQ_VBLANK6 + 1;
> +	adev->crtc_irq.num_types = adev->mode_info.num_crtc;
>   	adev->crtc_irq.funcs = &dce_virtual_crtc_irq_funcs;
>   }
>   
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
