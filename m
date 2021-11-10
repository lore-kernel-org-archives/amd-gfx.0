Return-Path: <SRS0=Yti/=P5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48D26C433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Nov 2021 20:20:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0C1C61247
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Nov 2021 20:20:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org F0C1C61247
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 200D16E049;
	Wed, 10 Nov 2021 20:20:09 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2076.outbound.protection.outlook.com [40.107.223.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B59D76E049
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Nov 2021 20:20:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SKIZPq1uU11FdHofgaruA25pyvzPCUeKMQ7T0HcYOlO6vu1ZfFSSWPs5/vCiGlGwws5IadBCDeeXuezVhQ+WzLCly+18qbMQ9NXHLxMeB25li4IfoqkfWkPW3Q7eVuPuUyUuICkIldy4iBXMT46p9qnP2RF8vSHnNkFCrPGxZ6ZKFMjlqQryKfZYB+jiOBZzEtXg0R/9SozwpFbekWDX5BgmlK7VBvnd69F9y77F0Qack/HtoiUop8KaaTUeQpwWl6kKePrxmiy2VId+/QMNgofbEMnK97BZrgIlWAIf09o6WueDW+f2MUX9t4seydrGl6VKDsY61s85Pdgf9aPwYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L2PGHVY5beCeUTw7mMS7ws4AobETrz+xUZkTgGnaLcA=;
 b=TZFAyCYUGZBglpG4M062AO/sKO+Gx2RG2FLH4V2T/jajKdLkjCXa+qa/YV03sFK2q07KnkKRpw6f4a/OqeEbImbkibqL0BCh5nqamhUkhvhS+AV1w45TW0MAYAeuj88O0nzt+GI265CTazIAOTY4VJp9Y7UQJOdsoyzY6dwzS7jVU8t2fX9OkdojSVGp+6vKjgCY2iNloCzT4ZaIqGmLrIJ9y3dET4Y9xkVyZf6a14lKfFwVlSYKal+F38EZ/RfM0vQV3QON6tBhcnJgfRmsVdY1x36i+LsyPR1jnpPBzpKrFUXL8gpLoOz6Al0hu9kl1yNcDYpqEAy0ZJNRT4e9WA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L2PGHVY5beCeUTw7mMS7ws4AobETrz+xUZkTgGnaLcA=;
 b=OjkQskMQQ4n/DE2D4xFSJEXpBXzgW+MRztE9NafOh29tx84n5UsX0KPcNK0+qNH4yWQzrDLJlM353J1Hm3xkfkK+58Ml5eDErkO1i7cNl2iHTF3TRvkrC4K699oFuel7fNVOF8JIS/Chb4FqPpNZE631k/UMCy4dypGTHCRSNjg=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3962.namprd12.prod.outlook.com (2603:10b6:5:1ce::21)
 by DM6PR12MB4484.namprd12.prod.outlook.com (2603:10b6:5:28f::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.13; Wed, 10 Nov
 2021 20:20:07 +0000
Received: from DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::7d09:bfe9:7aa9:6011]) by DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::7d09:bfe9:7aa9:6011%5]) with mapi id 15.20.4669.016; Wed, 10 Nov 2021
 20:20:07 +0000
Message-ID: <e6dc9b1e-c57f-61e7-9914-f35237b045be@amd.com>
Date: Wed, 10 Nov 2021 15:20:04 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.0.1
Subject: Re: [PATCH] drm/amd/pm: Enhanced reporting also for a stuck command
Content-Language: en-CA
To: amd-gfx@lists.freedesktop.org
References: <20211110201234.53851-1-luben.tuikov@amd.com>
From: Luben Tuikov <luben.tuikov@amd.com>
In-Reply-To: <20211110201234.53851-1-luben.tuikov@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT1PR01CA0064.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2e::33) To DM6PR12MB3962.namprd12.prod.outlook.com
 (2603:10b6:5:1ce::21)
MIME-Version: 1.0
Received: from [10.254.43.106] (165.204.84.11) by
 YT1PR01CA0064.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2e::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4669.11 via Frontend Transport; Wed, 10 Nov 2021 20:20:06 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 74f2784c-0643-4248-77ce-08d9a4877cc1
X-MS-TrafficTypeDiagnostic: DM6PR12MB4484:
X-Microsoft-Antispam-PRVS: <DM6PR12MB448434A8EAC6CF890EDCD5C099939@DM6PR12MB4484.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M0+GqJ60av6cpDMlMuZAU1AyMi7EpDd01ChSTJGD2rVUfeFgWRTb4PhKYW7vtDCYptCjXvfef91agFba+YDdniJuNpArF5T0iWE73fO39GJg/KwHhaAieUJLo0D/pt/3YGnuVJlFAB7pupwt2gZ+a1O1km8nEe9yEZh897si9muITSddSrABgXNh5PHXH8sVD6gf0H1Mj6nE+VD2LoMvg1VjbWysFPEi30lCO8pWIELZRf54iOw6nXZGDFZR8JjCOzw+jVLg4wSvLBFd7CSHqo2rN/z+Likq22Lm+u+Vd3JEKp4U9KdO7x748/2GoZebrwQrZNDLCN3yUW7SalTfcOIjJGEd9doh2KWk+xmMgywmLgVYBzxzNuldEmyBAq45HmUjpE6kor/HzJM+p8lNuJfYQpnR3COt2pFkgdoijMn5CIxTwZHap2QInbuXgo2QapiA8Iu9vLDCmN9Fy/L88BbFntNBQ60qYe3av1yk2zKkrEmZZdZPOa+6tx+tXEeFPEl20yjlasbMSH/QxfMal+KlqkEMSNdhHHvbjatt/wm2+gtCwTyZL3UeIBB0D/53K5zBVgGkY5EfR0Awatw18pyns/uGikiOs3ndl1QYBLbT3uypXCGWIol83BkQbqzRjfNa0HSg+K3bIGFfuO7zU4cBN5xPrIYHxUz2bt8wReJhVp5/aehnUPXVQr7oW01BUOnbKmIqCFAOF7KkFYVPuzy0V1wYbqjLpeepSMmAIMo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3962.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(26005)(66556008)(8676002)(66476007)(6486002)(2616005)(5660300002)(66946007)(316002)(4001150100001)(186003)(4326008)(16576012)(53546011)(86362001)(38100700002)(36756003)(508600001)(6916009)(2906002)(31696002)(31686004)(44832011)(956004)(8936002)(83380400001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZDJSUXJRT3F5QStoWER6c0ozZ3p5dFhmdW5JUlMrV0hsK3NndmU0ZWI2a3Bj?=
 =?utf-8?B?VTdrOUV3dWU3R2ZxZWtEL3NFbGdtUmgzSyt4L2IyOStiaGJnZXpjZzFTQ01l?=
 =?utf-8?B?bUNKWEpYZWZXVHpPQ1diQVc1Tkd4UTQrSVRWR3pnWWJ1Mi9va3dKUzBER3h6?=
 =?utf-8?B?VC9hOGxzMXVKczhkZm1ZYXFsRUtNRTV4QjlLRDRGVGdJTjdoMDNTQU1LTC84?=
 =?utf-8?B?VVJ5d1BuU3BxaE5OQjVjUm8rTE92Skp5RWlQalVpR3BBQ1BxbzNrVklzOFZC?=
 =?utf-8?B?UEFCZXR2QjBSRkZXcU5GNHY0aFliQzVMbE95RVhST2IvOVdJMURwakRVcHRn?=
 =?utf-8?B?azVtTWk3cDBwcXY0Z1IvZXdMeWxZNGpobDYwdU1uSkE4TWprYlRTeHl2SXJ6?=
 =?utf-8?B?cjNrYVJSVkExNW1BQzNSbm56ZjFXTTYyYVJjQ01sZDFhMVc1N2VLV05RUE0x?=
 =?utf-8?B?dk51TitzZWdaKzkxcjI3RTQvMEhES09NN2RZT2l1V2t3K016ZFlCcDlpejh4?=
 =?utf-8?B?UGdNemdsb0ZaT3FmVUZyTGJOb1ZtQVkrdThMTm5HQkJGTWhDUXRjS1EycXlz?=
 =?utf-8?B?VUp6UEtsVnJhWEJMWDI0ak56OTVXSGswUFM0M0xkbUl2Rk1mcjRiK3ZXbFFi?=
 =?utf-8?B?ekVrMlpmQzBHZUVhNkM2VG5VSDRNdlFHOTRGS2V4OXNFdEhGbnh6TVZtSmdF?=
 =?utf-8?B?RjZ2aG9kUTZYNWtLOFIvQW1jdis5RTkvNlpKbG1jcFA2RHpjU3J0ejlhU1Uz?=
 =?utf-8?B?WFF3Nk1oa2ZVdjJxMWQwS0kxczN2b3VGUE1RanBldVp1N0dKY0pqUWR3UXRo?=
 =?utf-8?B?SzBKY1phVk1tcDJjLzRyUnNEV2JvVVdiQkVNNm4waUFRZG9pM3NJZFEwM0hU?=
 =?utf-8?B?a0FJQ1pCQ1VNZjJsVEdXdWxwNmFsN29oWkJZaG9Rb1VYR2FLQ2hzem9NWnQ1?=
 =?utf-8?B?SlJRNjExd1RNSlJxOGw5Rm9yK3VSaFg1UDVWSjlOeXBwa1hndDd4TXpMRXR4?=
 =?utf-8?B?cGJ5T3JjODhuelpBdEhQRzNIZTFvYlJLWWphZDJ1NlhqUGQwdlpUZGhjc0Y5?=
 =?utf-8?B?ODlocHMwcUdUaHQ1NkZCZXBnUUFnd2tzczAzSXdqelc4d1Z2Nk96M1lIOUJJ?=
 =?utf-8?B?c1JwK2xvTTA1dmIyNFcwVklwZFUzdTF2aHVHZGoyb240RldidCtSa2NTdWp2?=
 =?utf-8?B?SWQ5YURSdWJIZU5naTRXaXAwRlVsQUtTblpFTDNiaXU1MitVY3Bza1ZibHF4?=
 =?utf-8?B?dTJBSmU0YVdrejRTYnZIcDBmQ0txbk5idGQ1dkJ2K21LaHl5NzJ3M1BIOWFV?=
 =?utf-8?B?VFowcFc5bGhFWnYzZyttNUsvMFJQT3Vsd3BkUnFrK0xzVXk1QlF4NTZtbDlr?=
 =?utf-8?B?SXZVNU5yMFdPU0tzaVg5VFYyblNUc1lYcG9vamJtTGp2aEZRYW9VbWRULzFz?=
 =?utf-8?B?NjR0NUxTdnJvVjVPTGZFak40ZllFeHRqNDNLS3RVQkVuQzQrTGxWN05udEFJ?=
 =?utf-8?B?dEMxdnZ1c092cW1tSGN0Zy9xMVgwdUxMK1BZVGtVNkNMUDM5OVlyS3BqZC90?=
 =?utf-8?B?eXlmZlNxWE5VOHBFaVVmMnZiVU1JQklDZVNoRXl5Y2g2THI5U0xYcWdPTGVh?=
 =?utf-8?B?RmdEVGVwL3JsMW9oT0Z0bGZvVHZGeW92NkhYYURHV3NqZXNNYlVzQWYxeEVw?=
 =?utf-8?B?N3cwdUlNZUNpbEt4eTcxS2llelVOK1JiMHFudW02UUxqaTJsdlU3RW1ZeWU5?=
 =?utf-8?B?WjFzVTlxQ2dpZTZLOWFpTmFnay9IdzNaYzRKN0w1c1h6L2thaVVqS3JJeCtC?=
 =?utf-8?B?TmU1YnE3L1NhblJOaU5qbUhWcnZTRFA3eTBCN0FoTUVkYk5JMWQydFBCMnZW?=
 =?utf-8?B?RFJUUU8rM3BWazNCN01vMkZURlY2Y0UwaURkTnJGWGFqczJZTXI2bGRxUTU5?=
 =?utf-8?B?QWE3MStwWDRNcGRKWHJJUUliRWlLTVAvb2RaMm40RHh3OHpsWTlwSGY4cFZs?=
 =?utf-8?B?RUplU2Nod0JnWW5LRTlsZWhKYjB0UlBzeTNaRDBXUlc1WjNsbGxuamZRa2E3?=
 =?utf-8?B?aWFTWjhjaW5EV0NEbVJjK3RJbEF5UHUxVTJzcjg1dVZrR1gwYkZCejRMY0Fl?=
 =?utf-8?Q?urbo=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74f2784c-0643-4248-77ce-08d9a4877cc1
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3962.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2021 20:20:07.1419 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ceeF739F32xRTq/nRXBnyfW6XkVq86ptAAf6yQABzdDY/UeXdyKUiM0tf0g6G1Jc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4484
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
Cc: Alex Deucher <Alexander.Deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Never mind--the index and param are for the new command we want to submit not the last.
Ignore.

Regards,
Luben

On 2021-11-10 15:12, Luben Tuikov wrote:
> Also print the message index, parameter and message
> type on a stuck command.
>
> Cc: Alex Deucher <Alexander.Deucher@amd.com>
> Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> index 843d2cbfc71d4c..63cab6173206e2 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> @@ -141,7 +141,8 @@ static void __smu_cmn_reg_print_error(struct smu_context *smu,
>  	switch (reg_c2pmsg_90) {
>  	case SMU_RESP_NONE:
>  		dev_err_ratelimited(adev->dev,
> -				    "SMU: I'm not done with your previous command!");
> +				    "SMU: I'm not done with your previous command! Index:%d param:0x%08X message:%s",
> +				    msg_index, param, message);
>  		break;
>  	case SMU_RESP_OK:
>  		/* The SMU executed the command. It completed with a
>
> base-commit: 14271bc7f5e7ec276c58927ea87af9e81d97fdf3

