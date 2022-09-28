Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 261A2C04A95
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Sep 2022 18:27:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A31710E6CC;
	Wed, 28 Sep 2022 18:27:15 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2059.outbound.protection.outlook.com [40.107.220.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1C3CC10E6CC
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Sep 2022 18:27:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BMaSxGUq9XzIhiJz8P1TT5mkkvOc5Lb2IVPZZLf8Fi6RD9QZ24rQsXL/xM6KeUqrwsYxj0K4FsDRbK0jwX5fUeJmY5RCJX/hibx9DiKUBfYksmzXVT88SqTFt2TZtRKeaqtMTZ6FxnbFtmkYZH1AaCUNQW6itCd9G6MTfOcltWmcblTuv4detHOe2k9xUmX+sezbPk+1ncX2AmoCqiDAydwHCc1Lja/uHAEvp7ni2Dm7/tCIlRoK/A7cDJ1+z96MgIaNS0MinjM/9Q+1qF2AXZLs0pTZJvDE4NReOUnokclm+Hm1Gidr558qO8rED6AjEja3Ba3tXMw++Z1g4QaNrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jaVAAK1EJQRdL4x1Ao/J7QtHS4rJnGr0AHeaMj42wUs=;
 b=bdJ/HwncjXDdbSZm5GQdMxZPYrCxTUTvGtd3r92xWSfcHouTd4HAquzgtzaNBEIS+ShmkdvZqm46XkcxsLKKEe07XB+ts9Cq0s6OzI+Hn3AjL5RtvAaN18Q4xcwv/ql+VUCYn2mO6q70Z4BMIdr1rSZf0NlMULk9wG78dCb8hnYNzH/+QDTIbNjMrjQhDGoGT8zaG2wt04EkeB4O/AkbBtxKl/QK1tHLVbCgF5JisLGyQ7Hg42OwKwWwCFKZ9aqwZPQ+KNUGvBzyE8RsIa5wDQ/ycCacebaQk2GQQLheRJdOEHpZjBuCCm5Assun+Du5KiITO46IhWtEZ4T8Kx5wgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jaVAAK1EJQRdL4x1Ao/J7QtHS4rJnGr0AHeaMj42wUs=;
 b=OxHTfzS07kRFgPkxjoukOO0k1Zyu6dfmymUN7IlQBJFWXtO6khfbO0uWPe8gdCe8NC56BXIiYUMRx73H2tG3i7pm7JGiKenMJsBTshMiKM6GrmvN+Ca1k0q3iEX7y0z3ZhNWlLWYEZaE4z0x/dzo2+F54zLYh96h0S5AcOLxxtM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by MW3PR12MB4587.namprd12.prod.outlook.com (2603:10b6:303:5d::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.25; Wed, 28 Sep
 2022 18:27:10 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::805b:58b6:1f27:d644]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::805b:58b6:1f27:d644%6]) with mapi id 15.20.5676.015; Wed, 28 Sep 2022
 18:27:10 +0000
Message-ID: <f1e96940-b437-e096-4e94-a2537998fde1@amd.com>
Date: Wed, 28 Sep 2022 20:27:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] drm/amdgpu: Skip put_reset_domain if it doesnt exist
Content-Language: en-US
To: Vignesh Chander <Vignesh.Chander@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220928182229.14683-1-Vignesh.Chander@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <20220928182229.14683-1-Vignesh.Chander@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0149.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:96::16) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|MW3PR12MB4587:EE_
X-MS-Office365-Filtering-Correlation-Id: 82f5f2b0-0fc6-42bf-e2bf-08daa17f0e58
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bCzEWVFgOe5GRXd459QF2AZ2TH2wPXUYbnsI9wgEU/qVKsr7b7yQvrHcr2E2CF3OcbA9c4SR+bz+19yRKs4Z/FK40A8ThWNiLdAZULW7iXWUzbxYa2WRU+PDg4XiXbh2oI/FDvvWpi1k2wQNK8NSBwDWVQRLIXQ9YNEmEcmhZarqIB6mFKiiBXh2HwfohEWI5dXk2uTEOML1idTltJbmqdCtsFWHd0xgpFtgNSCMwSFcF+wEn0uqv5B1z1q1MggD/OECieiyCVCFCY64KMC9u6sCjpOIHuyo8Hx2krFcfUt4Wixwzjd8lE2Y7GZP3ZmzfmTyQP7IKfo2Dd0ig0dWtlNc5SdWrfU4CpNMvVqs3ycOKRuR6TvzV+CBBZfM5QaK7nqDDVBkpakl6im3VoWKVCruVWT92YzH5pVMK4BCldB6+h0rV/kc042OKmEwupi9BzpyOrgOp6ckY630yeH3FbXXwNnCIhWmLkKVkLFLkem6qUvu6Y9DwtQQd9ElV1IMZNZquOFJmgwyuABOOXENYn7P0LCb374et5gSvUtiSPBHkKJ+Kzi2NHZt23sKduoHUDRR4vRPAOgxWQk6CYHyOlU5vIWJDJKHtdtfhzZN0zbMEmyltEc7ZsY6WVLA7RDKYGdsLQleUSdwG81BZeFvMqxliV6xLLcthuuuYm5X8qXuS3FbLgvL8WYwFxbnVVvlrkboxn/ds2R5AjFw2sVLsSeTEcxMPguqPWu6nNaV9nt/Jr1wamGbJj1WwWib1kglfBI85XpFCJ9jOkuBKx/d0U/U+XwKahjVL1EmkZe1akw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(366004)(346002)(39860400002)(136003)(376002)(396003)(451199015)(31696002)(31686004)(66556008)(36756003)(2906002)(38100700002)(86362001)(83380400001)(66946007)(8936002)(5660300002)(66476007)(6512007)(4326008)(186003)(478600001)(316002)(41300700001)(6506007)(8676002)(6666004)(6486002)(2616005)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ai9GRHJZWlo1M213em1rNEtvbnl1bW4rNXRjNmJ3RFZhOEFMb3AwMjZpdHVZ?=
 =?utf-8?B?b09UQlRPS2ptZjg2WllDcGY2R1NLN2l0SXpaTE50TVRBRHVFeVdQLzZwaFJM?=
 =?utf-8?B?VVFtUlBRQnozNjNJcnl5UzIvZHNsaWV5ZHEyQmR5bzBCK2R3YURIaFBUSlZw?=
 =?utf-8?B?WTUrdngzbm1LMEd6OFRFR3AraENiWjVLcVJwRFdyMCtXbkhoeW9RaVFLMjlG?=
 =?utf-8?B?V0NGTTlZUjBURHltQytDMjJHT0Y3ckhwR0RDdHk3OXVOcDJ0MGNITHNTUVVE?=
 =?utf-8?B?V2lyTGVxdHprWlJiOW9wanNHdjZYYlhKdWtmaVRiUm93ZTJpYU03dmQ4UHNZ?=
 =?utf-8?B?KzcvUVBsUWorVXZiWjl3ZjFEd3ZLNjU5R3pHd1ovNXlFZTQ3WTBnamxEZGlN?=
 =?utf-8?B?S0g4M3dEWHZLUjMrUVp4N1liUGk4YWZhWWRoUEZHc3k5Q0g5aUM0dzhNVzl4?=
 =?utf-8?B?UG1qUzlrWmxKVkY2RHlSbTJ4clhrNXo0Z08yaHRHbkNxQ2Q1REVOWFV6cXlr?=
 =?utf-8?B?Z1R1R3plbUZpUjdSeFU2TUcya25GN3NNK3F1aFI4NlZOVWVxMTY0TFo4cHJ4?=
 =?utf-8?B?VlhkLzMrN2V2eHR3YjFMUDZRa0E2TjFsU1VMbVVsMU8xK3k0WC85aDBFRUpR?=
 =?utf-8?B?T2t2M0dJNVQzenBteDlGSVE5dEYybE1VVEZpRUk0dEJ6eU12OTAycUFyUkJU?=
 =?utf-8?B?dUp6YlBNRk9Rb1UvNkM1eHV3TG55Yi8rU0ljZWRwaHZNc05xVldMM09WYVNk?=
 =?utf-8?B?VTUyT1N3NVlzQzREajZ0TjkxUDNEM1htdDc1N2NkZ2p0NTd2a2VaRVBwdVZr?=
 =?utf-8?B?Ym1BM3RYZE5IZXloSkJKNTFoakV6RXJFVWxFS095T1QzZDd4UjlvQXRLVWJl?=
 =?utf-8?B?MUVlcjZNVTViT2NTM2VBNGxXS21sVFNTWm8xSkpySndncXkwbHNyb1ZRNWRK?=
 =?utf-8?B?VUtFOEpzRXE2NWErRTBNWjkvS2k1OGRtdVlLSFVMVysyc1pZRmV1Y0NWY2Rh?=
 =?utf-8?B?MjZNN1VVcStHbUhwWU5pYXdqKytYZitTbkNOR3lIQUwwK0JSajNBdGR6d0po?=
 =?utf-8?B?OU9sZ3h5Zis0bXcxK201QU9GcDZEY0dSaWZkc2pXOHlLRWorWVl2V09lMFZZ?=
 =?utf-8?B?Y3hLbnRjZ2pyU0NPZkNGSVNjMUdXdjJPNjd4azBXbDZTVyswSURDRUlheHZJ?=
 =?utf-8?B?VjdXcjF1L0NpaWpPTVVpMzZINHBQRlBRY0YwN09PYzM2V3dqTkxUY0g2bE5J?=
 =?utf-8?B?MXFMRkNrd2VXcW1xWjA2bC9iNjlxYWcwMVdwVFJXZzdpK3VFbUJNUGJxa0ps?=
 =?utf-8?B?N2hqK0xDYVNUL3lpbzQrbUx1RHF0VDJ4WVhwa0tBYStMR1VEZUwyTHBBWmho?=
 =?utf-8?B?aHc1Q0NoSWFSSWFNQ205NVlMT0hpZXQvZE9pYysxdHBCa3lHQ3F5YzRNaXNW?=
 =?utf-8?B?T3h3RTl4ZTgrV091VUpsNlFPT1MyaE8zT0hZOGlKeE9TckpsTTl0NkQyOFBa?=
 =?utf-8?B?N2JOR00rVEljamxtbFZ2bFU2VkZyWDZJRTlJZUVzOTFYbmpVM3BIM1hoSXMv?=
 =?utf-8?B?Nk53Yy9hS1lIRm9jOGVkZVpJTWFOVFVRZXNhYlNsQUg1U0dETFcrcFpOM0RP?=
 =?utf-8?B?Z1d2U3Eza0o0d0JCaFJiRjJXYk4xSzh1OHNHakNENXZFanh0clhROFhjMUdM?=
 =?utf-8?B?N3o5eHhGR3J4bTNCM0xxT3VlMXdld2JjZHo4Rkg0S1prUmk3TStkTktrUTlP?=
 =?utf-8?B?elNwc0RsV2pKZkRDVkYyZGhUSkxCVkQ0ZWprRnk1UWhMUTc2ZkZFaHo4OHBr?=
 =?utf-8?B?RXZzQTBYdGREU1U5azloYy9UNUdPcWhPOVVwWTZvQlZWQmhYUGRRSWZYVmZI?=
 =?utf-8?B?eTIzd2E2b0VJWFVnYVUza3RKOFNNWktFSzJGKzZ0by9DeVRNMTdxRnAwbWNN?=
 =?utf-8?B?VDczd0p5bmxnTS9UZW9hcnhrWS8wTWkwUnRvaUlUMS9EamM5OEdHTXB1dkky?=
 =?utf-8?B?UHVnWm1ielc0UGJRMjVkd3QvaFZKOUpYSmVRREhhdzl1eTd4MGF6U1ZOT2sv?=
 =?utf-8?B?M0pNQm5RNjdCK1dQemxNL2dTaW1wUDltbkN5Ukg3OG1IUHI3RGd3VjN4Mngw?=
 =?utf-8?B?VFQ1cVh4RjRLSlorK0NJYlRQZ092cEVEZWlzY3BKbXBFZy9nN015RWo3OHBS?=
 =?utf-8?Q?OAOcUPzfmFkt/UNeKhYC3jxD3F8jHe4B9UA7pNpciWFw?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82f5f2b0-0fc6-42bf-e2bf-08daa17f0e58
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2022 18:27:10.3096 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gKDIcb1dao7se7eC2TSfqmSZ2wQw7xylk3seMU76HFTG6GyUJc+UWY+CCIbBMTk4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4587
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
Cc: Shaoyun.Liu@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 28.09.22 um 20:22 schrieb Vignesh Chander:
> For xgmi sriov, the reset is handled by host driver and hive->reset_domain
> is not initialized so need to check if it exists before doing a put.

Once more: General practice is to make the *_put_*() functions NULL 
tolerant.

So rather make this than this patch here.

Regards,
Christian.

> Signed-off-by: Vignesh Chander <Vignesh.Chander@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
> index 47159e9a0884..80fb6ef929e5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
> @@ -217,7 +217,8 @@ static void amdgpu_xgmi_hive_release(struct kobject *kobj)
>   	struct amdgpu_hive_info *hive = container_of(
>   		kobj, struct amdgpu_hive_info, kobj);
>   
> -	amdgpu_reset_put_reset_domain(hive->reset_domain);
> +	if (hive->reset_domain)
> +		amdgpu_reset_put_reset_domain(hive->reset_domain);
>   	hive->reset_domain = NULL;
>   
>   	mutex_destroy(&hive->hive_lock);

