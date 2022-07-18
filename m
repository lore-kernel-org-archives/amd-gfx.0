Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2158C43334
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Jul 2022 12:35:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 594A31125E4;
	Mon, 18 Jul 2022 12:35:25 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2051.outbound.protection.outlook.com [40.107.220.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 68B4B14A2DF
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Jul 2022 12:35:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K+/Fp5Gqk2iXotJ3G1HkLeZTcG81gXKjO1ES4EJigv+tMXgbL4P7a03b9gGJ78ooURrB72yk53llDzNJmNhJQ28ZIRwDNWhaDCsjGdCXWOSz+M2ULOM2JatO7ULSE0+ieZIxeRFIeF32MSMbELUVKtb5Grzilp0zim8ve5aZ4ca1CAWGbcmsSGUn2uF0XtRS9w1SJu02Dl/Ji3NQ1UveViIMGQy2mb6ImQG17Bm75VlZZhvb6xKMbmxv7u6dDg5jXYVywal5vw+p7w8s+LO4l9gSjcLGAiN98FuBd341Zp4BM/G4ctAvB3vlniefSYhknI7neS1IhRSg6pViGvEgcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FLTFPvb+UZTVynqutJJdpUD4etN4kktqPjf0GGqlyfg=;
 b=JLVqzfrI7RXR7zwyn+qV6xFa7m1GAa09MeR3Z4kPaCPZEnOOnti3dBVa89OdxEvsd/nJsmLkS7KtCzzvZ+NKjWO0gPmdne2bpvHWXV0e80D4shukpzd+qUSabb/0C4kbc135z6CKu059i94+EKdl6A4Zrw4YcKmEscd14F0JmSFQs/8252EaJMu9uQDsm1/tBqDTLO1cWs6wXYYHVxcfBGrqqXV5/ELn9PneiCgRxiGQqwatgeAHWNDrHfXT49a+VldXwpLvv3beqh5r9fUP/kt2OM1XHsaKIEFF8rnF8fTekDDtVpbsFNWf8lgf+KxZFnA+N9c3KUtRNqtiy0AzUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FLTFPvb+UZTVynqutJJdpUD4etN4kktqPjf0GGqlyfg=;
 b=EA48Y+TGql98lmB5JYhNDOr1d4ES5FtTilsBvodoy7T2TxnY3c1si3qs5a6i4mNwfEmcvSUI8LdXPF8Y5u6LGhQVyYpF1DShDbwsZdGw3zK9jiQxnnKXmUGQPK851k0jou/y3ATd5tjcgG6k6FRRGBJoJAkHL2DwNFxnk6XSsP4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by BY5PR12MB4802.namprd12.prod.outlook.com (2603:10b6:a03:1fc::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.14; Mon, 18 Jul
 2022 12:35:19 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::905:1701:3b51:7e39]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::905:1701:3b51:7e39%2]) with mapi id 15.20.5438.023; Mon, 18 Jul 2022
 12:35:19 +0000
Message-ID: <3eb0cf64-9ab7-d20e-a98f-31a50ec038f5@amd.com>
Date: Mon, 18 Jul 2022 14:35:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] drm/amdgpu: Fix the incomplete product number
Content-Language: en-US
To: yehonsun <yehonsun@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220718120847.9719-1-yehonsun@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <20220718120847.9719-1-yehonsun@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0050.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4a::19) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 28200168-1f23-46d2-3645-08da68b9f994
X-MS-TrafficTypeDiagnostic: BY5PR12MB4802:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6IUf5k7SHlNFiSaJxllfE0ZFOaj0TOwHKsylCxs6gbAoW9SU00Wy9vpaF3JIMkecuWvMnqVnCQ/FYc762EMvY5sBTPNXFueKG0ZonMGJpx4IrepKuvQfSx8Kx6F2XWydO0suq/M63VqZGjunpLB2ISRA9hK0T1kqsnvuZ/yq5bCrO//iM967zeSVyPcRUyYys1dwZbhOq5003suYNwqTzLP+ykKXFAymTbvsVJBROw5tws6NgQSTHUdC838y36OdwcilCVdfBC5j1pOoHY7rmUD9acc6C3lKJvWU8t9PRNfFkQ1lU4oOUIqVQqHdOFY9cvudwR7qVaZRWalxyY+ggir7oUoQ95BKwcv5yNP18Ndpl2czXkFmXod8ffwtouZLOw/oXs0eMU/4QtJ6Cep1SlksdZzC2aC09UR630DcRQlLO+zYPnjT2CsmB+Rbg/IPecWbYCXWNwieYvnInTO20uHgFWpVw5Of96z1CSowAx7wENfP9uVZ4+JB5Jhi+64vsFQavR2+3hIsruvWxKcqEr6VB6XKsLYY6B0FWmyGw64okezVQZz/ULVxGHMePC9/x1ylZc7RKFHB78GL+d7Nh+BFjGQJIm/c41sw7KeKqlfkqQEQuCIR0lcANwKyIqjRNjwdNHiN3SweIyNYlRDkhakNLgirTzSzoQ6QHaYBOfVWXxqDWVm+TdMhfZAG0MlsO5H2pmg7izrdgyXHEG1jACAzlTw+1IYrcw0u6//x23f6XKP8HxWVkRODtIYX/TJ4/SUQBLW+MAmW6JtOxqcChbEbyifmbr+9CM3IMxTwdKky9uuNsoFbRiX1G/Hr/2yYdrqWSweqB+WJ308qbtzxhg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(136003)(346002)(396003)(39860400002)(376002)(366004)(83380400001)(6512007)(186003)(41300700001)(6666004)(2906002)(86362001)(6506007)(6486002)(5660300002)(2616005)(8936002)(478600001)(31696002)(38100700002)(316002)(8676002)(66476007)(36756003)(66556008)(66946007)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TmFaRXdKSEtQRFJXSitXdHBPQlVjOXlRVDdIaG9zbXZ6NkVoSFdYZ3djc2xj?=
 =?utf-8?B?ZkgvVFhWYVJTKzRyQ0dqRStWZkFuZnBWQTZPcGNkd1hvWU1wdlNibm9PQjNY?=
 =?utf-8?B?WStKWkowNmdvckRGbHkyZzNwbzAzei9OOHBWYnFZTFVCd2VYR0U5bDQ2cUhp?=
 =?utf-8?B?cklOTDcrVXppSWQ3cW1hN1pPL0xTR0JyNXlGaGhHaUV6UW1xc21hdWhZTEd1?=
 =?utf-8?B?R2E1dGdNdmRmYkFMdUgzQjR5Vzk2M0F6QnMzZkE1YTZoQnlPY2FQTUl6Y3dk?=
 =?utf-8?B?MFFyNG5sR0luZm9VTThZUlBSNTRjRFRJUHZIV3NuNkw3YmV0dVZBQUFRaVo5?=
 =?utf-8?B?OU5RL2R4V21FVlZRQjBHYlZDVGIzUDRweUs0RzR5U2xWUzFPZEFhNkV5UHhH?=
 =?utf-8?B?ckpGd08vcURscUNldCsxYU5SbEFmYjlSWEMzTGhtdXNqVWNiSWp5WDhGZERi?=
 =?utf-8?B?eDF0bUVuT1d6UUhRVXBjN21sY2N3dDczbU5sWDBHbDRvZCtBSVFrNTZzL24v?=
 =?utf-8?B?dGZUbytWdzVOZTMvVWJXYXZOZnd2ZjZJZ2V4aWppanRaVStpQjRVVmZ0cTZY?=
 =?utf-8?B?NFhZS1d1SFdRVmtmMkg2T3psMDhFSkxzcWlrMjBtTXRHNFNKVUZGRDVoV0FQ?=
 =?utf-8?B?Rms1NDgwR0pCbEh2OUdVRjFGVHdidS9BeExHWkxINlhTaDRyaUk2bjE2cmJN?=
 =?utf-8?B?bUtmK3UyQnNBY01yVktnYjVqRHE3OWNBMUVwRnFRVExEUGYvZnhnS3dWeGd2?=
 =?utf-8?B?R3ZWS1d2YTNGWVg1N2ErL2RYUWlTbVdBVk00MWJSN1p6RkZJTEZKeXM1UWpu?=
 =?utf-8?B?KzIwMDlVV244SXFEdlk2c0dGRmVHamFicHlOQ2ZON21hYUUwMnVJZ0xUenZO?=
 =?utf-8?B?UHdKN0tSQkJjejdwUU5EbUpGUUZ1eHRvN01BNjJBV09VRkdJNkd1Q2xxbDRP?=
 =?utf-8?B?RVF3SldhNk9tNGFndTN0TldrMy95aW14QUg3a2ZiRVhxUGdQeTNFamxXdVhH?=
 =?utf-8?B?aklIQjVZc3EwalhibTQ0dlh1U0toRW5kZTY1czEwcnh5S2Q0RkFpRTN6eE9P?=
 =?utf-8?B?MTlMaFZqcCt1K3BQQ3FFU05sWG9OZExYYjc1alZ2Vkg4SG5pWmRHZ0RGWkI2?=
 =?utf-8?B?elk3TzVMREtyemkwbkI2dnlBdGhvcnZGRk81TFVZTkRyS1FVK09CdllZZ3V5?=
 =?utf-8?B?UW41ZDFFY0Q5YkpyM2xIZkVIN3pQTkJtdFFDcTZvMHpJZ3FRVHpHU3I0a3lY?=
 =?utf-8?B?cFlFN2xYV1R1clBZVUVCUWduaU9EUkN1TzJDdTY0YkhkM2tUem10MmZqQmR2?=
 =?utf-8?B?ZWZRRW9ENk5oRGN5Z1hVby9wdi9FUVQ3cVN4ajc5MEFnM3FkTkNCZENoQXh3?=
 =?utf-8?B?ajJGOUhxN09TdEladXZzMUtyeEhuam5Pc3VNdVBiQW1KbVZhMTZoRnpVVThE?=
 =?utf-8?B?d3d3aU8vcGhiZUlJR2ppNkVWdjFSc3BTQ1d6WXpldllGZVFXb1l0SUJhcXVO?=
 =?utf-8?B?b21FQkNCSm9MTzgraVlqaWZoK2U2WFZiK05HdGUyRDJmOWFyODNNTXNhOVhR?=
 =?utf-8?B?dGo5bWRVUjBEZVE1TjlRYzd4Y21tSmdQaHEySU1DZWVXKzVTcTEyOEYxNm1t?=
 =?utf-8?B?UWdvbGgzbk9mczNBaU9icWJnRnNCQmtmTXBYU0tiN1VQQ0p3UnU2MGMwd1I4?=
 =?utf-8?B?YVBRQ2RPdGxuMW5iVUlna3JJRkVzQk5EQjhoRGZES3FIdXhCTkJCdTdxV21x?=
 =?utf-8?B?UlFHOGNJbHpoNHZVYW83aDkzQy9pSEF2YnowZHhRV2cweGRpaVIvd1V1bkhM?=
 =?utf-8?B?T0xjS3FMM2U3c0pCU1BVcjd4ejZtbzdQZHB3WUpaUHFwVGZzN2FwenRwbTg4?=
 =?utf-8?B?cjlPZHlObEFLT0tqdlNFaE5ETEs2TGc2ZzRVWXlVYkdJZTNSdk1BMnZxS2hr?=
 =?utf-8?B?RGl3UmJSV2ZyRjQzVDQySUQyK0MvczZMMm1MWXFZNTlyUzg1UWEzQ3ZTMGo5?=
 =?utf-8?B?UTRwK3E2aWRZcEtUNDdseUNvS3MwdlBieFZseTErNWpaVzZwK0RBeEtxelE3?=
 =?utf-8?B?NVMyODMya2cyaGJQaVJZd2RJMndTZEg5MmZCaE5JbDJzcXhqamw2ZEdNNUhI?=
 =?utf-8?B?MnJPU2FFZ2RidEQxOW9USmlnZ1J5ams4S3RMYVZBY250SkJtM2ZpSmpocVBI?=
 =?utf-8?Q?E81+ZKdKwBG93W+hnGt/FfWcpUCbWsWOV3YbVnQM0dvm?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28200168-1f23-46d2-3645-08da68b9f994
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2022 12:35:19.5730 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gMKWoeJC1tVCDvlTUoUZ1YKHevsXfVzpzwwKk3P/D2MhD+K7sxHqfCBYAW/FFDNH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4802
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

Am 18.07.22 um 14:08 schrieb yehonsun:
> The comments say that the product number is a 16-digit HEX string so the
> buffer needs to be at least 17 characters to hold the NUL terminator.
>
> The comments say that the product number is a 16-digit HEX string so the
> buffer needs to be at least 17 characters to hold the NUL terminator.

Well first of all you repeated the commit message twice.

Then when it is fixed 16 digit Hex string then we probably don't have a 
NUL terminator in the first place.

Please double check.

Regards,
Christian.

>
> Signed-off-by: yehonsun <yehonsun@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 9f729a648005..187e3dae3965 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -1019,7 +1019,7 @@ struct amdgpu_device {
>   	bool                            psp_sysfs_en;
>   
>   	/* Chip product information */
> -	char				product_number[16];
> +	char				product_number[20];
>   	char				product_name[AMDGPU_PRODUCT_NAME_LEN];
>   	char				serial[20];
>   

