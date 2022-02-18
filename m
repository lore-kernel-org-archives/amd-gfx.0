Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D00BFC433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Feb 2022 22:05:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 570DF10ECC2;
	Fri, 18 Feb 2022 22:05:48 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2078.outbound.protection.outlook.com [40.107.102.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C015910ECC2
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Feb 2022 22:05:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QDnrkEEjh5wAeJ1Qu4InC00ge6OfiL3sNbbyBSGnk4A/LZH4yzjvmxo9p6B89xay9tXiDRDsmHjTv1ewLwSTssURlMjhL9lRU2RXMEzkT3wgecFgocdJvdpGPqxm5Gy0YxLS83g0BNhvyAnAnocTLkxfi9QM48fYO6l0UmgB6nlnS9LHSJxEXotMFG891zbYhc5O/MhDhXIWydW9j6SGYcZpIAyYf8JW3s6kCh9ICvvX+H/DYwzMs13+/AEFwHyKtuar0fx/yCvwh+GBM2BsENWKErRa7Po+nyggwvvtVmtxs9jw4XQUYRfYgMYLuD2kR7WJJ4Hgr3LPkpFJPAVrlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r+1GGpkOX4DROY/gzqZetAcEMziMEcmGnGM9nSnNA00=;
 b=IH1kkQgl8NjftaAQYKEOZtkxE6BRN+udEushCr0XbIx+nCWNz3wMh1tFo6lOa7Ogw5Rpm5rG6/VnHdVi3473aZwbWDVForTZNrKqYUCxKCXHRO7r1lOAm4f6+nLuQw0ZuXWOFNbPtoHh9oTDdzdEUcAEyxsqWuYbdDvNKeR+ZeeggpMJgcZjD9q3J0pevPnCiHvkcYjV4hIXofTNNa+PDdaNbqRdLbbv1gO0FjJfzAPHQhAiLcRNCqOM0yhiz1uJwgNmITAvE15rsiMr9FGtnWWuhTl//wnL20JPs14vWkksUNSnMOKL1PXIvY2DArQdtOr7gF1tKW/X1IHxY2KKqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r+1GGpkOX4DROY/gzqZetAcEMziMEcmGnGM9nSnNA00=;
 b=Oj+ICn0J6CEg6YTOBEocGRO00Xyhl1hiSHO1S/8+Zju65fZ/WghIcM3p7U7RAAeE44uFpYqd7HT7wvbeWwg3HTpQBSDLugJ6of08tMzf/N/uBg19u6b07fzLkaFygx3lkrEionawPIfAM9YhANScpZsnl80eaaO9h2omnztG+5g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by CY4PR1201MB2551.namprd12.prod.outlook.com (2603:10b6:903:d9::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.17; Fri, 18 Feb
 2022 22:05:44 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::38ec:3a46:f85e:6cfa]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::38ec:3a46:f85e:6cfa%4]) with mapi id 15.20.4995.016; Fri, 18 Feb 2022
 22:05:44 +0000
Message-ID: <0fe51df2-9db3-7be2-3df3-e13e3611e430@amd.com>
Date: Fri, 18 Feb 2022 17:05:42 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] drm/amdkfd: Drop IH ring overflow message to dbg
Content-Language: en-US
To: Kent Russell <kent.russell@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220218220134.806815-1-kent.russell@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20220218220134.806815-1-kent.russell@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YTXPR0101CA0052.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::29) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a159fbc4-883c-454c-035e-08d9f32acf57
X-MS-TrafficTypeDiagnostic: CY4PR1201MB2551:EE_
X-Microsoft-Antispam-PRVS: <CY4PR1201MB25516DB03DE3FB707D9BCDB892379@CY4PR1201MB2551.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6iWbsaVlzzJXuNjpczVLW3JDouj/38fetIb/QMUcEH42wgQrW5HfRMpugat9hiZx2CWj2GrFjcphOCuBASIedCo3mzSutc1hgmD0BNub02T6VGMoIzHN1DiQBV85GuUHF1ZmAlQeU5itwr9xmTw6Qhv99HyPtM3CrNxV/qPYIfS6lIgzaE9lXEV2BpRHxLHz3A9XmoDRIudPGPYbnSm/RlyKDjlgVttLkLjMMOs3nHK9C8jOd0fQh3PYgQPMnvHWLOZRTqvLEaBvgmpiRElMc3UGYMDbjZ/qOZ1sTcZoDVRnvTTxsc8iL74OiN/vqD92BusY6M/2ub9PWi/ndg/pnmhVn8yVMM+pCrKh1SKeyT5VNuGw7SgMgaRxDZANT1Sfyrbrgaz8JflbpQJlPbaYY1adCCYl0Oz8ydLCuEjZF6tgY5hF0U8GdGmpul88WBRmbFLPvhRdpPcj7ZIAUB25oPyngYUvKrpPOnF/jQHpOjWrRkHhRdK7bF2hldtZD1R5DYBAXZp1wBk0kIYyqsgWbzxpl5GLcYe2TjCvf0FKhd47BOqT1ZsYBz5Jl99PVaQIkGYR/wMLu7nTSQjxkTpjdLIZgIUTW/We3L6lOykWjF/p9EPiZNqEuhmlDMSd2Wotm5WBNfPBgmSwPTs1H/IMBaNhECQ2/TnkGEuDtP9EiAenkpDpij1BjuGpjhLagv6rY1zTOTK7fTNHWfuSyJyFhX8lrnNDp83lM1q+CdA/DSo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(86362001)(44832011)(2906002)(31686004)(15650500001)(36756003)(5660300002)(6506007)(31696002)(38100700002)(6486002)(2616005)(66946007)(66556008)(6512007)(66476007)(8676002)(83380400001)(26005)(186003)(316002)(8936002)(508600001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aUwwTXZobGUwRUJRRmlCZWFzcVYyVXJZSTBpUFF1Tk9sMGRNZXRNcCtIeGpC?=
 =?utf-8?B?elp4WHk1bCtCVjdDY2J3eDcyMWVmQmxQRXNyaDNkTWtOYXFQOXZTcGtUYWdE?=
 =?utf-8?B?Tm1QYUE2VmszVFFkNGZ1NjdOSm50RkswUjdJb2g5WXdGdGI5ZUMrZGdxN0hs?=
 =?utf-8?B?ZmpCMmZaWFc2aHpTWEM5eXRpUUtHNE5XaGFyeW5CdlZ5ckYyaDUzSjVOckts?=
 =?utf-8?B?cUh3R0tVMjRBZEhsUGFFSzdqajdHZU5TUFVXZitoWXhlR0ZGZThOYmdzTk1s?=
 =?utf-8?B?V3dUaXF0V2VwbzB5bjFEQkVLK0N0U0RyRXlpYVkzMnFVU2cxN0s5N1c4eE5i?=
 =?utf-8?B?dkF6NlZrRDBNQmlnZXlUVDVoejNxSDc1MlZlbURzNCttZW9qNGdWTmVxSThD?=
 =?utf-8?B?ZHdqVk1RMnJVam1VTEJwK21ROTVxUGV1My90d0ZzN0dEK0ZtdjVqeEMyVW1o?=
 =?utf-8?B?TDB1YnlhUktNc29xN1NndTVzbmFRL2JSK1BNbHZ4TDN1QnNOcEVaU0Z5Sis1?=
 =?utf-8?B?M2UzcGlGVlg2cjNhSjRQa3ZJZ05xdnRzRW96SGZoN3NGUkVEcnVITE1kbzBy?=
 =?utf-8?B?bXBlV2dDTXM0RnptWFZmeU9nT1V4UTZua1gzUjdHMzBIMnZzL0RYWkhhWThN?=
 =?utf-8?B?L0RweklaWWJzT1krMFliTXNMOXJwU3VHTElSR0djWVZIVm01L2tTNUlyeEgw?=
 =?utf-8?B?aWJMWk1EK28yaFpKdWpULzBqUnJoYkhySy95UGx1Ky9OMTZFQnNkUWZmS2FW?=
 =?utf-8?B?dWNlV204T0tNYjZGMk9FeFkxV3NDRzYrUmNFRXZldTh2QW1POFV6eFlEY0Nj?=
 =?utf-8?B?ZWdVa3htVFB2dzJ0azZBNWszdTVZc0FCbjRqYzJ6N1RRWGxrK3J0aEpoblda?=
 =?utf-8?B?WkUwR3M4RkwyOC8rT0ppZlF2S3d2alYvS0NidkhBcTl4NGNDQzUwak5FOGt0?=
 =?utf-8?B?RDhnaXVnbEtEOXNOR1N0MndvY2VPTmNtLzhUbFB1R1FidWxqZWlKMFVGSXpr?=
 =?utf-8?B?Y2NoZkFTQ2dIaFZtNzNvMFVLQlBtL3U2alRHVjR6NHU4ck94VHhpSmR6RFBQ?=
 =?utf-8?B?VXNXdkl5bnhzQzJYNlNGaUE3TE5GRXNYWGJvOUNoZGF3Z0dEOUNvT1A2ZFJr?=
 =?utf-8?B?TjBUQWp2aGo3eUh0OE10ZXlCRCtTYVBPM2ZHcXltR2tWb3I2dkplbnQ2MWxW?=
 =?utf-8?B?TXpJaW40Z0lyK0ZHa1hBYzAvbThFNFpJNEJ0cnRTSnkxa002L0VoLzhFYUtG?=
 =?utf-8?B?SGlNbS8zUkVVZmdWZWYwOGxKZnRXb2pCVEU3VndITnFIcmJ3VnBFajRvdEpR?=
 =?utf-8?B?aHdOcnhmOFJZTXh3UXRGRjdvTk5HemNRdzQxbzV5bXNPNUwwdDFJMitlZXJk?=
 =?utf-8?B?RHVMVG15R0xZVFI0WkxEQXptVkRKa21GOUJMQzdsalExMnhjNWxsQXRneUN2?=
 =?utf-8?B?MjYwNW1pcFYzMEQzcmFhNnA4eUJMSDhUb3IvZUx5RlU5UjE4U3dDRGhWcWVF?=
 =?utf-8?B?M3E5alJIOVRGRW1OUEl3UTJRZkNCREkycUc1L2libGw0ZnhzYmxFVkNwRnpy?=
 =?utf-8?B?ckF4eHp6Q01PRVMzZ3AzbVMrSlZWd2JQamxxWGJXbEhuei9Gb2dpeVVmWWJ4?=
 =?utf-8?B?cG1PQytwcHJVYi83WjZNb2lwY3dpOFFxSUZKWnk0OFRIM2liOHprNTJPQmtm?=
 =?utf-8?B?YnQxS2JPSHBLTllxajFtVW5Uc3BLMzNiejZKUjJUbDQ0bUwzaERVQkU2b2lk?=
 =?utf-8?B?Y2gydkNsdEN4eXZlblJqKzR3Y3l5MDFZZU9WbFJ1c0lCOU8yQWh4R0tpUDEv?=
 =?utf-8?B?MFNMdXR6NDBNcjg4Tk40bDRCNjhoaEJMdDFacUJMVW00OUE1OXc4RHF2Ri9P?=
 =?utf-8?B?UGt6bXJhcUhKWjNUZ1JaRzRreVhlT3llWHJXVjJaMlBNNGxrRE9qVmJ6NkRv?=
 =?utf-8?B?WjQ0UkkrN284YkloSTRYWkpsY0hVakJPc21pMDZYQm9tZThlbDE2TXVKYmdT?=
 =?utf-8?B?dWpWMkhuVlBFcU00dHczNmlpRCs1d2FRL0d5Z1I5RG5Wd0VWNlZCL21TMEx6?=
 =?utf-8?B?TmJpT1NBUys1VE5mVjlmZy80TUg3WkNMNC9tSHRKUU5LUjNKb2oyMTZkbGFa?=
 =?utf-8?B?c2thNlpyaEluclp2V2RLQVJCRkxCQ2JGUGtKMVMwTllLcVBUSEFSZkVRRXpx?=
 =?utf-8?Q?u2YUKH0zTgkPMu+V03gKLsg=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a159fbc4-883c-454c-035e-08d9f32acf57
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2022 22:05:44.4115 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0mSoWvGtm7ClA6MSM5RVbirjZ5MU3lYzxXd5DjUcy8BM6mwLFMc72j2xJDaSxfvMCkPCrcpD5sNOILXFP1Uq+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB2551
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

Am 2022-02-18 um 17:01 schrieb Kent Russell:
> When this was first implemented, overflows weren't expected in regular
> operations, and tests weren't in place to cause said overflow. Now there
> are cases where overflows occur with real workloads, but we know that
> the kernel can handle this robustly, so move the message to a debug
> message.
>
> Signed-off-by: Kent Russell <kent.russell@amd.com>

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_interrupt.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_interrupt.c b/drivers/gpu/drm/amd/amdkfd/kfd_interrupt.c
> index 9defdbbb4ff8..7041a6714baa 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_interrupt.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_interrupt.c
> @@ -117,7 +117,7 @@ bool enqueue_ih_ring_entry(struct kfd_dev *kfd,	const void *ih_ring_entry)
>   	count = kfifo_in(&kfd->ih_fifo, ih_ring_entry,
>   				kfd->device_info.ih_ring_entry_size);
>   	if (count != kfd->device_info.ih_ring_entry_size) {
> -		dev_err_ratelimited(kfd_chardev(),
> +		dev_dbg_ratelimited(kfd_chardev(),
>   			"Interrupt ring overflow, dropping interrupt %d\n",
>   			count);
>   		return false;
