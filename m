Return-Path: <SRS0=WUpi=KU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D4B4C2B9F8
	for <amd-gfx@archiver.kernel.org>; Tue, 25 May 2021 12:14:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 56D9C61402
	for <amd-gfx@archiver.kernel.org>; Tue, 25 May 2021 12:14:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56D9C61402
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8C30C6E9F5;
	Tue, 25 May 2021 12:14:46 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2065.outbound.protection.outlook.com [40.107.236.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 08FE46E9F5
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 May 2021 12:14:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cnq8drpXjy9zqHG1VOJGCzjyrlz9I7k9LpHyBp5AZbJ0i62I7UxHJHZfBWBStSG+BhRvDhMjpgZZkQxVlvLqi9brW4RctySji7qQ+ZgOHeEIEn3gaI9re37rabad06A9Qua+mVfsfu5c2kRkl3MoHGvos5wpEBLFW6YQ1QirDEsrpcO88ovCUqDC1FesNVASeMNJIFqWSNs+7DLWTzITXNHZI6LRKsQqxCfZFVViKyujBfKo+mysuE36UCU35uS4xCeckVgRgyEPC8Jd5m4wKCFwKyVMfBfN83fyP7h3daY05ZOYj8FkidN8je9dwwmw9uW2t+0H/JKaXdC/XAyoVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D/PpI+W9K4BoAg2X0nY4qc+B3mqkX7soveLYUVC4Ri8=;
 b=QJrfZUnEcfpSnjFmOeRx9ejpSa+5BHw6T2mGjQGAj53tY79jpvd1K6d8LPyzownAE2kGl23GH94NdeQn56+1e3U3Pn8/gYZnGwlyRrZDP1Us/p3btp7+NIy+lta2S6kM1zvMaXB1ijWXtTVsyZUPisiCVTVf42dQd2NJXrVJWg569bfO2ay7WsTWLJo75G8jAkAKAzpBp0mVNl6s+ft8lq2vi3XIOkfu7+wLQ1mRMbJP0uuO5G507U8+q65KJezLnZBzcPo7+D86jQH7L9j7ifTEZZbnSZR1woZEwW3SGcu42sdDl4FUDN+DMJqzZC8g5KWGvO4KEAprmB1UFaaBJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D/PpI+W9K4BoAg2X0nY4qc+B3mqkX7soveLYUVC4Ri8=;
 b=gg9ueU4BPgBZfwD0CI8hiGON2S+V2WsWwxdZ/1ER6sf/ymXNZCq6SeyZRdfXVQ/w8LZ7agOa1ExtxovxNoXQWxgXnoXHvdki0f5RMiIZUitJiuJaeJwu0kX+HX0g6KRsTpgGcPOv+9sF7RG3ZFnVuCZJ1V2In/mnm93Sjc8lLT0=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5136.namprd12.prod.outlook.com (2603:10b6:5:393::23)
 by DM6PR12MB5534.namprd12.prod.outlook.com (2603:10b6:5:20b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.27; Tue, 25 May
 2021 12:14:35 +0000
Received: from DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::4074:4943:244:a5fa]) by DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::4074:4943:244:a5fa%6]) with mapi id 15.20.4150.027; Tue, 25 May 2021
 12:14:35 +0000
Subject: Re: [PATCH] drm/amdgpu: fix metadata_size for ubo ioctl queries
To: Shiwu Zhang <shiwu.zhang@amd.com>, amd-gfx@lists.freedesktop.org,
 nirmoy.das@amd.com
References: <20210524115214.26792-1-shiwu.zhang@amd.com>
From: Nirmoy <nirmodas@amd.com>
Message-ID: <0b5f3072-f2f1-8619-22e0-32f20d4a7036@amd.com>
Date: Tue, 25 May 2021 14:14:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
In-Reply-To: <20210524115214.26792-1-shiwu.zhang@amd.com>
Content-Language: en-US
X-Originating-IP: [217.86.110.202]
X-ClientProxiedBy: AM9P193CA0019.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:20b:21e::24) To DM4PR12MB5136.namprd12.prod.outlook.com
 (2603:10b6:5:393::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.178.87] (217.86.110.202) by
 AM9P193CA0019.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:21e::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4150.23 via Frontend Transport; Tue, 25 May 2021 12:14:34 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f469db68-d44e-433c-c014-08d91f76a910
X-MS-TrafficTypeDiagnostic: DM6PR12MB5534:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB5534FC92ECA92024A5F5042D8B259@DM6PR12MB5534.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2512;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mHniUWkntC5pvr96upQAbwNpil+Vm8PdfAL5d/yzPXEPabPz6oVTFp5Nx2xXyKRrkWxIco8/jDTcIaYreCAlstJ3c3/I3pw2uEcLKT+VuEovs71EBSSEIIag19V/35OQRGCnH5w8l/jKV1IkIBAj2r9KdZ4hcDfjWaEPVawXQRHtIEw6mJDR1G8wgKJxV4vWxFASMEYfTsrYl0lDEhcOMUd3CovRbmpy+J37FXFF0msiCkexdGysUzGId0nw2uI0dqZVtIj7bIr7+MndCDtEtEtmH9EPI83OEny6phHLGTqQRPyYksbpagzOpokKxM+OwgatLejRrxSq22Tp42h92FqxhI8wixzocHl+4G477lJfsfK/b/MWEEqpYO6V9KVWghW2wklPN7rFwYWkfPNaybtvtdwsr52wjN7eAQX4dpeu5qgftI1qPWSuzy7JxkpP34V6V3/CaETM1ZQQNV3STReAwrdIXOzgIC+qipPXW1lUdk7L15ctUwA1kf54u6Ukh/7iWWinYWKRe6zeKYohkCZXijEuwCBemCfM+OgMPJeXHSaYO2jMEhS041PmLIMYNginfNmT1Ms5rN+bLtz+JCqEZd5u8u25cwauXvkmUh/KrTWZpOnrQDlpizB3TfmzpSDLtjre0dVgNxN4YMUWaOJ6eAu4J5Q9n9H06FTrCEnxk24n/f5F8sfmu7jm7Acfkub9Pn/WlprLTleOKlWCvQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5136.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(396003)(39860400002)(366004)(136003)(36756003)(83380400001)(53546011)(66556008)(8676002)(26005)(31686004)(52116002)(66476007)(66946007)(16526019)(8936002)(186003)(38100700002)(2906002)(5660300002)(956004)(2616005)(16576012)(316002)(6486002)(38350700002)(6666004)(478600001)(31696002)(6636002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?QXljVVlWUm1welkvTGpRbFFYcDFHZytYdytVS1FhZlBPd1BuSG0yWjNzYTVI?=
 =?utf-8?B?R09DUWhkcXVkbCttblBRc1U2RGlUMnVBTVd3c1doUWsrSkovL3FDYlVDb0F1?=
 =?utf-8?B?MjRSQ2VQaGQramhtV0h2RURoWitoYm1sTG9QenJNMEgzelNyL3RCWC9jYWk3?=
 =?utf-8?B?dW9uRnRXbW9ZandCM0hnUGgzRG9YRUVrUnp6Q1FWdXkreDNwU3FpSGFMSnho?=
 =?utf-8?B?VWc2YW85ZzQ0ZFFnZDFzZHdqYVlFZnhOdmluYmkzc0lhVE1peWM1ekFoSDli?=
 =?utf-8?B?SThsWXA1Y21YTHJaalBnVC84YWhUSkQyZ3JwR0F6MWxFa0VFbnd5d0kva3Zk?=
 =?utf-8?B?RTk2cU9VNUlDc1dXVS9DS1NZZGxpdkpmMXpmcTloWGs5RzZLMk94cWFCYjB6?=
 =?utf-8?B?RXBOUEdyN3JXV0FMc2xJalIxRXVQZTlmTy9mWGtrOG5MZUQxR0NjL3JTalVp?=
 =?utf-8?B?WGo2cDUzbzh0TkYvdGx3ait0dTVVSW1SVWxUcEoxS3BmZ2N3TlpvenhiM1Nn?=
 =?utf-8?B?a1FoL0kxdXVaSGhCT09ZMnpoKzRkRjBGVTJMUEhZbnlFL3pOOGJKbDZpWk43?=
 =?utf-8?B?MFJrd2lKYnBmM0MvVys1VHptVnJOSjJZVlZ2SEhDeFVFTk5mWXdMOVdVbWRa?=
 =?utf-8?B?ZllHTit4M09iR3dVN0xuYUUveEVUc1E4Q2NFMFQyTnBsbml3bGJuUEs2cmho?=
 =?utf-8?B?bWY2U2dBVGdtb2dRUlNoZE51cGJMOHp0L2lxTU5pcE5xQ05QNVoyejU2QlVC?=
 =?utf-8?B?UVJrTjBiSHFxVGt4QmVkd1E2Ylc2cG9hUkVLOTZPbTRIRzlVdDZoUFFzWk1X?=
 =?utf-8?B?OHJjVDkrNTNDQnRNNlJxdzVhRmp0U2pacEV3dDIxWHR2N2NHWUJUcnllNEFt?=
 =?utf-8?B?UFBrMHZaNkUzaVNqUTM3Q0dhTVk3bUlvTXdEazRYc1oxaVdreHZENXdhd3RJ?=
 =?utf-8?B?STRRUlJ3NCtoTm16SWF2UWNWOEQvOG9odjdFeWp0WmE3eU5JZElnMzNZcHdk?=
 =?utf-8?B?LzdVdFdzMDhnQytnWnBNVC9rQ1owTDk2Y0I4bEVSWVJ6Tm5HY3ZDQzkwRlBm?=
 =?utf-8?B?d2YrbVpidTlzK2svdTRHWDFHRmYreFBqQ0JJd29FQzluVU9kOGZFQWdTUVdv?=
 =?utf-8?B?Zjg0dmdudU81aG5td1hyQ1FKalZmTFV0cU9MQVNmRGl4S1RyTEY2YThmbzhX?=
 =?utf-8?B?bHFrUkpDMVdIamtVdE4wTllsRmJWbzJQMXZMUmhtdUZTb3BtZzlxU1pxWTg5?=
 =?utf-8?B?RnNVaTBkOE1Lc0JCR1VYTFhzZ3ZVYTlmd2FwT0FrMHlmeGlreHlBa20zVUpv?=
 =?utf-8?B?d2w4eWRnWEpoTUE1UlBxbGxpaFIxWWcrWHZxUEQxOWdMekJoeDlibytHQm9R?=
 =?utf-8?B?VFE3N21VZ0hPaUI1bENUZ29DTjB6QzF6eGtOK2RTV3YwOCt1TU82TTBBZExI?=
 =?utf-8?B?K1dpTWhWTExhMVU2Q09kUHFWL2dlT3FhVDZWQnEvVnlxZ1djVUNQUFNjZW9V?=
 =?utf-8?B?LzZxRVA2WGpkVDM4UUNHR1Jtand4SThGS2FyOEVkZk92R1RmSi9WQXFMSkFH?=
 =?utf-8?B?OUdMSHY5Snh5RDhDMkcvbWtPQWRiNjV1cjkzRmdibk9wY1BFS0NCbktvU1hk?=
 =?utf-8?B?VVkzbkxVVTI1SXpJT1JVNzZ2WGUwZ1FlSnRCcis3dXk0dUtBb3FSeDRUVStT?=
 =?utf-8?B?aW1RTVl2dXVqcUZVeUZYMlZNYjRTWXdwUHNGQnVhVFF2dDBFcEpycWtHSVM4?=
 =?utf-8?Q?rbjdqecUEKtSIGhkwImrG0R2I8yl5qLkTVWObza?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f469db68-d44e-433c-c014-08d91f76a910
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5136.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2021 12:14:35.4407 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YPYo4VlR6reGynYZMeRRlVlWZAU61SlSm+kGJsWJFJLIGcszASOibBj8shdIHoDmPrkCVDVpJp/PWHdTfNtl6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB5534
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 5/24/21 1:52 PM, Shiwu Zhang wrote:
> Although the kfd_ioctl_get_dmabuf_info() still fail it will indicate
> the caller right metadat_size useful for the same kfd ioctl next time.
>
> v2: free the metadata buffer for sg type when to destroy BOs.
>
> Signed-off-by: Shiwu Zhang <shiwu.zhang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> index 3f85ba8222ef..e9f8701fd046 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> @@ -95,7 +95,7 @@ static void amdgpu_bo_destroy(struct ttm_buffer_object *tbo)
>   	}
>   	amdgpu_bo_unref(&bo->parent);
>   
> -	if (bo->tbo.type == ttm_bo_type_device) {
> +	if (bo->tbo.type != ttm_bo_type_kernel) {
>   		ubo = to_amdgpu_bo_user(bo);
>   		kfree(ubo->metadata);
>   	}


This should be a separate patch, it is unrelated to the below hunk.


> @@ -1213,6 +1213,9 @@ int amdgpu_bo_get_metadata(struct amdgpu_bo *bo, void *buffer,
>   
>   	BUG_ON(bo->tbo.type == ttm_bo_type_kernel);
>   	ubo = to_amdgpu_bo_user(bo);
> +	if (metadata_size)
> +		*metadata_size = ubo->metadata_size;
> +
>   	if (buffer) {
>   		if (buffer_size < ubo->metadata_size)
>   			return -EINVAL;
> @@ -1221,8 +1224,6 @@ int amdgpu_bo_get_metadata(struct amdgpu_bo *bo, void *buffer,
>   			memcpy(buffer, ubo->metadata, ubo->metadata_size);
>   	}
>   
> -	if (metadata_size)
> -		*metadata_size = ubo->metadata_size;
>   	if (flags)
>   		*flags = ubo->metadata_flags;
>   
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
