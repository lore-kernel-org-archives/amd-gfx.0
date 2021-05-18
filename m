Return-Path: <SRS0=uqvu=KN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4E9BC433B4
	for <amd-gfx@archiver.kernel.org>; Tue, 18 May 2021 13:30:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AEDB3610A1
	for <amd-gfx@archiver.kernel.org>; Tue, 18 May 2021 13:30:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEDB3610A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4AAC56EB81;
	Tue, 18 May 2021 13:30:39 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2068.outbound.protection.outlook.com [40.107.212.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA5046EB81
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 May 2021 13:30:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S4V/vvTkZC8uDWgZOegmpsGw+/eSGU8uaulgbXkI1zqfJf1hoXeW7gTvN5RS9TkIkjutomC63dbU1H1IlaQpqse0ComYLE3169x92rp8Rj3nqs7ZqtJlpv6pwtVP/aajYpqdJ/Z9HElMCdGowyM43ctErEzT+Yqev+g8H/YqhUXs4X6EHJI9qcTajK6gmLZ71UP1kl9oRzwKxLqCWr8yDg/NeBoYe45nGImVX3Xl0mFFldeJkjxZPebTmL+QnSLiwLTmLu9CovPOnJtwGGhjVhglzYrHrXR997bSElIy3IaZomwuHtuxx+QrifxLkGq00v3j848Q3N7G3wXVAZLMiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yCunhs/6pQ6Js4s57GM8uB4SWW/Lm/0K6cmwYjBz7qg=;
 b=MuHa3ApOMrJ7bkt/xZRwcDIjMeqcDxddtXjALIbpEc6mFuYiTD5331i/e0nqDt1gpg06AOFOLbI+QiePFuHEE7i6JC0fjKV+TJOxQZ1kznV7feHXiy5E3kJ84FMmNnkRRE9VOFenUGBROycuoABYr1heMHcNZ4JBRQTAJqHILr1/FkiAoRwj4r7YqJEs/ZZqpSt07fSgcpEPKibdt1zAyWPl/Hlkmr8prKYRCQKZFUfcIQF7bZtM6Go1fXA1qFxrFCuSdkJ70owZcYUoPrNJshRwbAa3U2ppJ0Ua9yCyLlm3Z26fR7U0Uo51V0JFVxQj5EbNGc5gJQUdkPzlO6gtHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yCunhs/6pQ6Js4s57GM8uB4SWW/Lm/0K6cmwYjBz7qg=;
 b=3PhepvWnnlWGbMJJTaA/YtLWvP1l7zsXHennvNv4vS5vhVQRonwz4E9mwo/ZIPTjnmBTWgfoPHQjTj3slvwcJ3OPHnpnskdS7TxAqps2ap9nuRmjxeLR4qnCHlVChw42v8aor/PSlA4HFIMnGkxYELrN06ru0x9LKA1jtCC+Hrk=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1787.namprd12.prod.outlook.com (2603:10b6:3:113::12)
 by DM6PR12MB4745.namprd12.prod.outlook.com (2603:10b6:5:7b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.25; Tue, 18 May
 2021 13:30:35 +0000
Received: from DM5PR12MB1787.namprd12.prod.outlook.com
 ([fe80::e516:6700:6c7:55fd]) by DM5PR12MB1787.namprd12.prod.outlook.com
 ([fe80::e516:6700:6c7:55fd%5]) with mapi id 15.20.4129.031; Tue, 18 May 2021
 13:30:35 +0000
Subject: Re: [PATCH] drm/amdgpu: add video_codecs query support for aldebaran
To: James Zhu <James.Zhu@amd.com>, amd-gfx@lists.freedesktop.org
References: <1621342064-18012-1-git-send-email-James.Zhu@amd.com>
From: Leo Liu <leo.liu@amd.com>
Message-ID: <5403a860-340a-7947-bc0f-e6a7ff374e6e@amd.com>
Date: Tue, 18 May 2021 09:30:33 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
In-Reply-To: <1621342064-18012-1-git-send-email-James.Zhu@amd.com>
Content-Language: en-US
X-Originating-IP: [2607:9880:2088:19:bf03:fc1b:6d6c:b08f]
X-ClientProxiedBy: YT1PR01CA0092.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2d::31) To DM5PR12MB1787.namprd12.prod.outlook.com
 (2603:10b6:3:113::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2607:9880:2088:19:bf03:fc1b:6d6c:b08f]
 (2607:9880:2088:19:bf03:fc1b:6d6c:b08f) by
 YT1PR01CA0092.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2d::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4108.30 via Frontend Transport; Tue, 18 May 2021 13:30:34 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4efc7193-c249-44ee-daeb-08d91a011ddc
X-MS-TrafficTypeDiagnostic: DM6PR12MB4745:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4745F173514D030BEB6171C1E52C9@DM6PR12MB4745.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1303;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ov3UJoS+GEtDlmKGUwaTw6OwJa3XNHHJNJ9GgIhyZJ+vz7K8bSaUFHBlHb9yun7GLCY9OTQW+nZYJgvVU1TOFWdxxtja2kOvKZCzWUvRma/YaSVNXmMwkLAAoHPg6SYPxydvmLhbbU3CzX+bLotfQTeZMRvI8oQBraBuSrwikW3/hjkCmM7Jh0+hs0WjjSOwTtJkTDClzv4FSlTzn6Gzn1kpXO5MS43Db+6oJvRBUtYK4bXNOCD8tfNPZbDofb04IxIOwWXAOwZUyno628HLzL5owyMROqIaROZjFdsY6xO0c2EPkEGnVGejqTvAVbL5i/uLftpUSyk1spwY1iRiCEIzvs7nl5TkYdpt8hFyJeYmPMLVDxIwjOOTzt9xgEgEF9G7pzkbsPbmAzoEeuZpAhS0qyRhjw/8RCHKADAd7F8wQVkV/E5MWlEY/Vw5+43hGluZTQVRtTY1wo2wEYbIS+nBI8xFadb2k7SdiyffwwinX4fy9/jL/SESQ8rBI93ruTtaymf4lCr6JH/6jCpO6WNtwi9L14RS0HDX2ninL+Cn3XkTWhAkK3EN5Ln91AMKCDGG1wjdLNDAKjyDjcvbbupc0L/enXaBEvK4nXzNyTZKn9/VJTiGDDC49OY2aywfV0hdXeBY6coDQO10skYypHRV2GiEhePK6YZmzOOXTTXT8IOGumYm3DTXtO5WDXD6
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1787.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(366004)(346002)(136003)(396003)(39850400004)(2616005)(53546011)(2906002)(36756003)(38100700002)(44832011)(31686004)(66946007)(8676002)(86362001)(5660300002)(52116002)(4326008)(478600001)(6486002)(8936002)(66556008)(4744005)(16526019)(316002)(66476007)(31696002)(186003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?YStOL0VTNVcreWFBcmF6NmZNWjVuMWV6aXBSUFFXdXFmdDVyLzEvR0paOCtY?=
 =?utf-8?B?T05rU2tlTWxqdk91WkxjRG13UW9wczNnMFhvSkFJOHhxQ3NZMFQ5cnJWbVZT?=
 =?utf-8?B?TkQ3NVJlVHdvMzgxRUJqdEQ0VmhxMnY4dWU3R2lJaUNZSnlDSXN0dVlaTFAy?=
 =?utf-8?B?b1JVMS9YTXVvUFF5dnBCRWpHajJFdS8xdTllaXFNeEdjSWxOK3RaR0ZyRHp3?=
 =?utf-8?B?Z2h6TDcvTkVaK3FuZzZmSmRPWkdOSDZLNmErcXFPbWtjZlU1cDkwaG4zM1lX?=
 =?utf-8?B?Rk0yczJDMnU5cEk5ZlVaellod3FjUGM1Z3U4cW9CUUFoYXMvSU9KZEkwY0RP?=
 =?utf-8?B?c1E1ajRrdHlBQzJEdXdCODhhTnV0WUtwdVFmUUdoSkpXVERGUlhNcUgzL21D?=
 =?utf-8?B?U0pTSkpITmJXR2dXVENib0drTnlEZmZORDJ0NW1UaTdqRGZ3TEw5ZThQM1VU?=
 =?utf-8?B?ckJmaGN6Uk55dXJUb0Y4aU10OGhlNjJmUVAzRW05ZzQ5a3paZEpVOW4yaHZI?=
 =?utf-8?B?aXQ1alpySEFVNXlOZTN6aXBRZWFFM2hjR2dMYnY0ZWVXVzFDUEdqbEk5TGlv?=
 =?utf-8?B?YWhZUG5FdzI3NVpVams3VjE4M0p6VmpSR3hDcHhOUDZzZExrWUliNXNxTGU1?=
 =?utf-8?B?c0dpRUFOdHFNZWgwQk9acUtIQWFuanJhUFFLQlB2YTU1Z3VxaDZwdkw5WGdW?=
 =?utf-8?B?TmUrWnYwQmQzYXQrVml1NFY3enU4Z1o5Q2Jqc050TnAydjZaVXZnWU4vaUcv?=
 =?utf-8?B?bmRSd0ZEQnpicm5oUjZOb2d1d1lVOXQ4amcvaHlDRHZxQk5Mc0QxWG1PYTc3?=
 =?utf-8?B?OFJaY1VHWnZjV1NURTBPZ1JENXAyUWpDUEtseHVKTG94SEYyM2pHS2JvNFZV?=
 =?utf-8?B?eDNJb0pvRGtIbFpHQzBmZzhOZUxlYWRUNlJsTktPYUduelpUVWFISkFzUktw?=
 =?utf-8?B?SGNxN0l1cVByQlVqUmRiZFRkSi9WNTNqcUU3cmhpM3VHQVlBRGZxajcxR2pk?=
 =?utf-8?B?L0tob0R4Y3U1clZOQWkyc1ZsMVljK3htTHpXUCsvdGN5dUpHdjNqNHVZdngx?=
 =?utf-8?B?V25CYVVVVXd3OEl6a2kzc2FYd1lzQzV1NXhtWFYyUTFWVEpZU1BPM2t5NGtv?=
 =?utf-8?B?SW0zQnlSem5nR2hjS1FNZWg2ZHNUZzY3SWxZMEdXMVVJYlNnZDRtUlgyUDkz?=
 =?utf-8?B?K3MrMVNWVXJVNHgwUWNrOUdrQUFVVTN6UXUvWm1va3JrL0NManVPcXJQOExa?=
 =?utf-8?B?cGZmL0x4UWpvRitkR080U25hQmJUbFp6ZTdGUE9XTE11em4vaTluMHhWanhx?=
 =?utf-8?B?WkoreUNlcGdzd3dTekNuaVljN1pSOUNIWE9YTVVkdGgzeUpIYXVXbkl5YmJt?=
 =?utf-8?B?MmVTTHY0bG5qZkk4K2tLdWVod2JIVmZESXZYN2Nid0FsNFg2ek1xcGt6QnZV?=
 =?utf-8?B?Z015T0VYNmhNQmdMbDAyZ2RRUENYYS96bm9lV3lXUWhXT3hFQnREWUpNVEVO?=
 =?utf-8?B?VmpCNFRBaUNRdktueEhOajFkMFZKSzVZaER5TTNnUmpNNDdxcEFGcDlYWXEz?=
 =?utf-8?B?bU9yQ0lab3UvOEpxdjFMcVVObVRwMjJUeGJZU0VpdWp5aW1lamo5YXVPZkRI?=
 =?utf-8?B?Q1g4YUkrNUpwdVFqcmZoZ09vYVZjRkZxeXBJa1ExRFk2RWNlcGNDV00rM3Nz?=
 =?utf-8?B?anprTnZsZEF2QWlkV2NjUUx0TFZTVzBtb2l1RkQ0M0w0Z3hNdW9vZzYzT3pX?=
 =?utf-8?B?a2hsMFlYVFl6eC9TUG1lYUZ1V2VKZlBuS2pUM21RazNocE9rdlUvSHBMN2FE?=
 =?utf-8?B?aEJQVytkb3VxS0NrelVCVGZTSng3VERMZ3JyTG1oMnJoS09UWUw2QVYwL1M5?=
 =?utf-8?Q?iFYEaZEanqv3j?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4efc7193-c249-44ee-daeb-08d91a011ddc
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1787.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2021 13:30:34.9427 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TTxbHkxD/bRF3yNdhCzHKZdZZCtk86ca4tNK+mzkRuDpGT9na/LdNLBHhdUVXImn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4745
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
Cc: jamesz@amd.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Reviewed-by: Leo Liu <leo.liu@amd.com>

On 2021-05-18 8:47 a.m., James Zhu wrote:
> Add video_codecs query support for aldebaran.
>
> Signed-off-by: James Zhu <James.Zhu@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/soc15.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
> index 080e715..75008cc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/soc15.c
> +++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
> @@ -302,6 +302,7 @@ static int soc15_query_video_codecs(struct amdgpu_device *adev, bool encode,
>   			*codecs = &rv_video_codecs_decode;
>   		return 0;
>   	case CHIP_ARCTURUS:
> +	case CHIP_ALDEBARAN:
>   	case CHIP_RENOIR:
>   		if (encode)
>   			*codecs = &vega_video_codecs_encode;
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
