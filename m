Return-Path: <SRS0=K+jV=JX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36BB5C433B4
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Apr 2021 14:35:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9685961004
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Apr 2021 14:35:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9685961004
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2EFAA6E1EC;
	Mon, 26 Apr 2021 14:35:57 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2059.outbound.protection.outlook.com [40.107.243.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8771F6E1EC
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Apr 2021 14:35:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DLx5gJd8nQ72N1f49m94JIAqNE2NmkgttKtJVo0/EN88BhOXf01RMSt/h8X/5VLUtPplUAzVWF4pAbN7UWpghDib4v7DUAR4QezzziY21rfMj4BXIzXf0Gb6gx7/8sHm2PkNtHhri45kWavzYEGyf51kocxnYgx+psRJxOsTHkEHXdnnDFZC0YmUB8hzzC0qCP55tuoter8jH8XJJjZ6cIGb1JN3WUMXn9hHkeRyl67DqB+80TxhPLjZmsdQDaKJVMo8lF19ChI8HFoJoBxP+Ll3DNjfJUC5peDXAjE8LloDjZpl7/3EWlNUt8f3w1l8NOcEPSUe/a5iWgPxGynp/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lQu3aVpHmDkFiMPUreGLG13XGLbX9vceUqUo9fgWwpQ=;
 b=eNEDjWF0OnWqkOo6VIMNsnpaC2dt1G2qr2MFKj9dlKHKhsKE7VHjcEjGQaUUGQKHX/ODhIMNZUpgGTMC1grk/5BTYIvcxpQ5L0UO4VwbnNOOho4XyReYs0Dv89CS/Cs20JVLmTNDmhQ1UIEt9GdFeV3ZzBF8nkHgSzuM6pqsTuHG53XJpyFpjaPyC0t/t/r+xIvWBChZZJeVfZoSk96Rfwy3Qr4A28+xoENGQb/IH5/scAS/iT1uK29hWzM/OhAGYMtNUOTqef0zMSMilDlqfJcycV1FggvhQiil7Hf4RoLSW4+XPWIfiUWhzvO4EaSkrHv7kPdKJ1LJHY2t54Z5pA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lQu3aVpHmDkFiMPUreGLG13XGLbX9vceUqUo9fgWwpQ=;
 b=JnyqLzGA25rFve3n6ZZ8RjYjZ4ugllhlOb80b4eiDzai1yK+s1vZ/jmZsXBuCWQajRyahk1JFnnmtH1PjjM/FPJbOaC5c7g8D3tmVCR/9gvpAn3GaIpnTd9yhJpXoRV+n/VJicf2jKtdkLA7h4xYVlUiIz6kIMszcqRR7M+iW+s=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BL0PR12MB4948.namprd12.prod.outlook.com (2603:10b6:208:1cc::20)
 by MN2PR12MB4253.namprd12.prod.outlook.com (2603:10b6:208:1de::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.20; Mon, 26 Apr
 2021 14:35:53 +0000
Received: from BL0PR12MB4948.namprd12.prod.outlook.com
 ([fe80::70f5:99ed:65a1:c033]) by BL0PR12MB4948.namprd12.prod.outlook.com
 ([fe80::70f5:99ed:65a1:c033%7]) with mapi id 15.20.3933.040; Mon, 26 Apr 2021
 14:35:53 +0000
Subject: Re: [PATCH] drm/amd/pm: Use correct typecast
To: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20210426134418.2198220-1-Harish.Kasiviswanathan@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <4cf79a65-0925-7047-cdfb-0dde3c491b57@amd.com>
Date: Mon, 26 Apr 2021 10:35:51 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <20210426134418.2198220-1-Harish.Kasiviswanathan@amd.com>
Content-Language: en-US
X-Originating-IP: [142.182.183.69]
X-ClientProxiedBy: YT1PR01CA0067.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2d::6) To BL0PR12MB4948.namprd12.prod.outlook.com
 (2603:10b6:208:1cc::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.182.183.69) by
 YT1PR01CA0067.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2d::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4065.25 via Frontend Transport; Mon, 26 Apr 2021 14:35:53 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ea756209-51b9-457b-8b23-08d908c09878
X-MS-TrafficTypeDiagnostic: MN2PR12MB4253:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4253BC62C7F5682DA4250B5892429@MN2PR12MB4253.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1107;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 92x2u2U4O05SPW5ruCkE4DEXcQyxZRzdro4/j/OVmPNbc6L6sKBNh8p7/zDUhJdcF4WGxNRZFFdUnvi8Ss7B5ebla3wki+XQxFgWvJnEcrD82mBR45MxVBzPhWupE0uYXRbTxLyYkgpdhJLiNsmZ50IxKuaqX/1NxSrxKthJ5Gk7wUpcebOHqgi0p53TMFklvU1tYZlMhX7p7gbuYQz/VsqdAVrzIs8i+ocV1CJiJShM5bCs5DoPv1KbXuXOfVcLSdMWJJ6/bOxmdS5r9lfQl35HZLoV9EzY0SvJKZU64Mb8nIQpNKyfFPg8SvGQkdri7ngQL3Wv2XNjDqwAYq9R1udiS593R2ZCSRPMM4jNgaoGjsBVvUlHA07xEUqD7JenV7OQ7GAerSa12dZzm3oEoenPPX81RtBdrOx16c6SVmEyaBcdS9evD2em08ncJsBy8IeFWo/S4in1v8hbOrYJ0s6VtDt+IGmyVw/keVYK6q4KkqlQfjFSWJ9FxzotP1RKPHoDkFYhHNq5TXjrgCeMvU2Y7fkJOiEyy1z7g2xfmWeaR5C6DFw+7CRQuVz9o3KYMMSmkEiYN2s9cI8KJIgDEe7BbcEzqPZB0bwukPBmJuYISCGGaB3rLuoZxOnRM+CoNPjLhlSE9IEGFg1AVD+TzqYkHVQKzS5nQZ3d+O30T++i7Yr2FFkA42NqQJ9mzLgQ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB4948.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(6486002)(36756003)(5660300002)(31696002)(86362001)(19627235002)(66556008)(66476007)(44832011)(66946007)(2906002)(26005)(83380400001)(186003)(8676002)(8936002)(498600001)(31686004)(16576012)(38100700002)(956004)(2616005)(16526019)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?STYrREpQbmxtZlI4dzEwUTV2QXAyVDJsK3hTb09DclZ3Qis1QUc3c2JaOTlN?=
 =?utf-8?B?eFBpWGhzRWdoN04ybmdsa0pqTU41WmxGNGw0THJLdmtBUDkxUXo3U01Qclkx?=
 =?utf-8?B?R0VaWldvYTFueUxIb1IvREw5VnBmTm9yUk5QWGh3alY3a0NmRHpsdUtoZnAw?=
 =?utf-8?B?U1ZpcGRTRXU1Y1RtZys1WTFqYUJrNVZ4ZGNpWXFybi9QcFk3d2JML0xHMEky?=
 =?utf-8?B?dDlhbGZWS2RtbDM1aGxiRDBKN1VMT1hwZEdsT2NhaGJ5STQ2dkVEVFNVc0pI?=
 =?utf-8?B?cXoyNUFjUVR3cFFoaVRLaTV5d2VMeGtyaHdaeWwrZStqckdvMjVQK2RzQnNh?=
 =?utf-8?B?bHR1WGlCRm9ReDJXWkl4ZnNRRTlRNG10LzV6RkcyV0Q4U1p2WjBEaTZtRmdu?=
 =?utf-8?B?YXc4SGtsd2V4SjEzT0cyMHUvUVNxK2c5TENGMjNEOWExOVVCYXJwMnRIMW13?=
 =?utf-8?B?cnZXalp6MCt0azVlMnBNZzZ0OWVUZ25wRFZGaklJaExJSk5JMTlOc3lwWVBC?=
 =?utf-8?B?eVlrZkIvVTFScm1YU2RiNlVHR1MySy9xaElvemxPSUZDOWkrOUx4QlA3Z3hC?=
 =?utf-8?B?V2JIZmN5bzlZZGtPVDQ0d3YvR3JqRzRBcWNHcVNCTUZ4d0hST0RNTmdtRDcy?=
 =?utf-8?B?eWZZR2NTbUY1N0toenRzYU5YSE43L1loMmp1UXBEUWF2dXhmWkovMzZPT0dn?=
 =?utf-8?B?T0FPdC9PQlRMMmZoeXJVK25tUkY2dzJCTENFWXk0aWJXOTJPeE05UWwvWjY5?=
 =?utf-8?B?QXd6ZHNUTXphbDNZTjFDZGhZRSs0TnNsUmt3QThFOGQ0a0lWdm14OXFtVUJT?=
 =?utf-8?B?YmlLUzFiTVVuNHJhVFNYZzJZK0JnVDlUaHc5V0hQaWVRQ25PT2wrY0hYcXFT?=
 =?utf-8?B?OTQ1TG5qcG5XY2EvNUFUYklpQS9RMkFTYkhKZ2JVQUsvQVJCQThzNWFJU0k0?=
 =?utf-8?B?MHppYU5KTmhyQ3lyUGhmQ0FHd2xwVHFMWENYdDZqVmwvbHFzUGUvb3FJQVNu?=
 =?utf-8?B?VHZLYUcvcU1QOElDdVZ0SVdSaEh5YWNkWGVTWWpjaGdzVFNJaHZ0MjZYWVRB?=
 =?utf-8?B?RTJVNjNZbkdSSXU3SHJUNGdZdExyS0RORENXdDFCTmlWaXBEaFpRN2ZZc1ZH?=
 =?utf-8?B?OVUxdEVWVE1LWmxWaVFaM20veTEwQko1NkxSVXNwQmVOVFdYenNiQUZIa2dK?=
 =?utf-8?B?RzNsY1FwWnFlN0M5cHEvNkhKelpLeGViZGdrQkhpRGp4Sy9oOTJ1MU5JTnlK?=
 =?utf-8?B?RWNBYkhMUzFlQlFmbkV2V2RvdUhTNDlLeDFwQlg2RGFCN1pTSUgrdHkyOVZp?=
 =?utf-8?B?Z1hqbGNNSEczMnV3RDBwUWFpcTRKb2ZMb0hXSnBZYnBzcmVBemlBSHpnNFY2?=
 =?utf-8?B?YndhT2xyd1dTa0RxektqN1BJQ0hpMytWN2VDSkZDQmtxUkxZRzFzTmFJTmtr?=
 =?utf-8?B?WkZHNHc5OGJKZVZpWTUzRVVkL1dZVU9BZlVhZWVPQVdiNlp0ZkN4Z3JNT3Z0?=
 =?utf-8?B?U0JmTU43T1MvSlpHUTFOek1zS3hicWR4ZHJSZ3RzQkRUTVNHaGVUYnBvWnZC?=
 =?utf-8?B?YUsrdUhIYkp5MFBtWE5zczBtSGhTM0Y4REcwUC9JNUNReFVxVmtCUWdyVXhR?=
 =?utf-8?B?Q0taV0NXL2VaTnlGRlpTQWxWTmRIQm1vdjVub0hzbE41UXJvbjFnaFFpR1ph?=
 =?utf-8?B?ZWNBZkpQV3Y4V29tR1hEVDhxMklPR1kvUCtqZUZrdFlNdlVwTWQ3Vm1aZXBL?=
 =?utf-8?Q?KN0vHViNuXGT1pAYILFLL2QWR+A4LVSrT3yTJs6?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea756209-51b9-457b-8b23-08d908c09878
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4948.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2021 14:35:53.5251 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dmap8LRRXyd3Ga11lI+EEkknkAK2YOKzY4oqJitpwTz2l7PL0Lqzjp+Reryg4CUkonpM9v0HYqhb6sTlpg7cmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4253
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

Please add a patch description. With that fixed, the patch is

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>

Am 2021-04-26 um 9:44 a.m. schrieb Harish Kasiviswanathan:
> Signed-off-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
> index 1f02e4ee2909..771e2f0acdd3 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
> @@ -1657,8 +1657,9 @@ static ssize_t aldebaran_get_gpu_metrics(struct smu_context *smu,
>  	gpu_metrics->average_mm_activity = 0;
>  
>  	gpu_metrics->average_socket_power = metrics.AverageSocketPower;
> -	gpu_metrics->energy_accumulator = metrics.EnergyAcc64bitHigh << 32 |
> -					  metrics.EnergyAcc64bitLow;
> +	gpu_metrics->energy_accumulator =
> +			(uint64_t)metrics.EnergyAcc64bitHigh << 32 |
> +			metrics.EnergyAcc64bitLow;
>  
>  	gpu_metrics->average_gfxclk_frequency = metrics.AverageGfxclkFrequency;
>  	gpu_metrics->average_socclk_frequency = metrics.AverageSocclkFrequency;
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
