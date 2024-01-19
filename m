Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78DD2C4725D
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Jan 2024 04:23:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 16BA610E94E;
	Fri, 19 Jan 2024 04:23:06 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2077.outbound.protection.outlook.com [40.107.93.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CA70010E94E
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Jan 2024 04:23:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iDNAJB8oYX0dDshUh2rRYidUDIMfovPb/9L1PgBzVBgHvy7FU3X8ASHBOtfaXnAno2VeGYDzuwoZVALU/P4QfF2uc53udcWPD0RfPsArPLWi5ORHsk91h4p+dizyZOjWQvHKx/HAQ6E2uiMkN9fAHvprXXP2parJEQWgLukvBUI8dTjSGviwRt3wLm+HukeV2HnqwfBgUHV8Y5+uHdlEZWNut7A1CjLcIdNk7RET15aH/NcHuU3nXehUDmgZFVxV2yg4zT42x73V/sDKqVPbSq9tMO4YMZQmQJ5YPKIIGfk6QDfRflkYw4EcDZ1cqi0gjKI7fEmQawodJ7Q51DLs4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mB8k8M2WGaM7gKpuIIWGWwq4116uPNGFpNiRk/HGGoM=;
 b=Yk09IqKqRjrf/U6aKHN9oQPTJMbxwmzjXjMUQlThMZ431hdWUbB/1Vb7kZVBbIO3zggkbbNUcyVEwoc1ZHe/YBxa1RIcI+RBcK0bbtjvoHl6V81DkS5Yccn6JME8Owm+HKba5YmfwCCar0z+TbQqqFKjvLs5ntgCctNTxACXSNWC4y63xoxNrxcXJ3KLFERXZq56uIkZDtqyS8voyAPFNkJroVGa8koDHibORCbYhy4YVk0Ldg9Feb0HNC/bDUcSI9ppOruYYscledOLcCxbQ9VOHa2uxjcQGUT+a+oYo6gm7HZAOngxbGN2gGML8oYb7XJKHAlSNTl3SGokX42bXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mB8k8M2WGaM7gKpuIIWGWwq4116uPNGFpNiRk/HGGoM=;
 b=Rcz1qQgTEsQmL3PkZo3e1jSTuOowTxEaMNM2MpLCKpjoZ5QlXK5XpJRJuhpZc5dxuYXDzmu0i+hARoN7FUaRTUmTLE343VpMNaCjCr0ZhGC2A76nxGKnlcr5lrJfSt8p6rUj0cTsutQgETMuVwF8eS3sgIDJb698FV++Z/YTeC0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB7820.namprd12.prod.outlook.com (2603:10b6:510:268::8)
 by BY5PR12MB4886.namprd12.prod.outlook.com (2603:10b6:a03:1c5::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24; Fri, 19 Jan
 2024 04:22:45 +0000
Received: from PH7PR12MB7820.namprd12.prod.outlook.com
 ([fe80::5b3b:867e:c8bd:8bf8]) by PH7PR12MB7820.namprd12.prod.outlook.com
 ([fe80::5b3b:867e:c8bd:8bf8%6]) with mapi id 15.20.7181.018; Fri, 19 Jan 2024
 04:22:45 +0000
Message-ID: <488a5857-172a-418d-a34f-f4201682b7cc@amd.com>
Date: Fri, 19 Jan 2024 09:52:37 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/pm: udpate smu v13.0.6 message permission
Content-Language: en-US
To: Yang Wang <kevinyang.wang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20240119034731.2271175-1-kevinyang.wang@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20240119034731.2271175-1-kevinyang.wang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2P287CA0013.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:21b::15) To PH7PR12MB7820.namprd12.prod.outlook.com
 (2603:10b6:510:268::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB7820:EE_|BY5PR12MB4886:EE_
X-MS-Office365-Filtering-Correlation-Id: 180271e9-7dfc-4863-64ef-08dc18a64928
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NvNQqNGM9CJn9Axi5V+RDIQlJDIdctfqkfFtfIZ+xMhEHU2CkHrj/gsKfpQOikbo5l8YFsFdxGX20OQvoFsmweZm/kqHXH7iKoAb3S6LF2SrKS5Nyd35Q04IXFnF0AYNqnvTMOIW8N5kHTUpfwC3xdhJsJd1Yls5N8X879wJky6rlsDoJSqs6Gl2FQq/dU5wAfzNeTFu2XfJOI0EICIO/qhwkZL9ykLptY7ovDk+EddSvf2d7UsUWKmodtrn5jkVxUwduTnGHpQsKeWmmVXhywdfBCrImdj2oP7gPM7Z+5P6YC9YeB38rtuczgh70MK7An+Mb78HLfatd0R54oObBQQ408KPkdUxT6pZAUh49NikdKQii4LexbEoZV/SdnZfZtVh2veJl11EeX3/r9xlUOz8+YYayceqPvTdBh/7DJee3W7Rh3f33diW54ZoqjfmNl93FDt3iGN2WC9kM2kK/aDqHAwjPKHUORPsi40S2zF5I1CjplqG6CqqSIMNTSLWfCfCjwuidJYdd/JqMtqWhGtdG9pmAWvIH/vVzSmsfJMMeDprOvruVoYolhdJ34ZYLB5W+KbH/+nBSyQP0tysMCx672vef5D7idQgiHJQ2aR64fojhwcBERxUX4SPjg/ppfDoehG8Fq/6tYHtVbW5IQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB7820.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(396003)(346002)(39860400002)(136003)(366004)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(66476007)(66556008)(66946007)(316002)(38100700002)(31696002)(86362001)(53546011)(6666004)(6486002)(478600001)(6512007)(6506007)(8936002)(8676002)(26005)(83380400001)(36756003)(2616005)(15650500001)(2906002)(5660300002)(4326008)(31686004)(41300700001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dUhmNGRtdzcwMmRXckNSQURLMXc4aGpvcTRQa2lvQWx1R1drL2lBUzZZTHRk?=
 =?utf-8?B?cEk0akEraDIyMUo2d0VBa3VaaERHT3JyNXlzZHdxL2ZpQXhWaGhYWm9jQzhS?=
 =?utf-8?B?cEc4Y1FVNnZiSEVKMXAvb2EvZzlKQWNCZUQvNE9MMFRlc1ZTeXIxVzNhZXBE?=
 =?utf-8?B?TE9iUnZ6c0kxZGtIRC93MUh5TmhYTHFSM0U5NitYNEEyTWNoVHM2NXY5aldh?=
 =?utf-8?B?RGo2eVlJN25RRDI0Z1l6alU0cDlTZGxQbWNIZUZTT1hxMENmeGFLbWExUjFC?=
 =?utf-8?B?aE8zcjB0WnF1UGRwanB0OHliWTRPOHdCVTU5L1MxUmk1bXVhUm01S1o1eURr?=
 =?utf-8?B?VDdmTVF3TUw1eG9vaXN0bmlzMUpCZ0xhdU1kSk5EZGxLampYaHUwUUh0UXVu?=
 =?utf-8?B?RWdvRmRzN052emNyZ2JISGNjQnhhcko5NSsyMnM4eDFiYW94WkJhWXVvMEo4?=
 =?utf-8?B?TlNhNCs4OUNVWjAyZWlSdllGUGZjc3Z2em9OOVgvdFFqK2M0Q202ZTkrMzVX?=
 =?utf-8?B?RS9kSTFHSk9SSGx0V1JKSjJydWhENktGbDVOWDg1VHhvci9pS2dEVVVHZEZJ?=
 =?utf-8?B?eEpSUFF0bFM4UndZRkhtSmZJYjdxQlNmZXRHUE04YXV0UCtVazZtMmZDTlZW?=
 =?utf-8?B?N0I3TTR0aE5SRlJkbHVWSWlhWFVsYmVUNE9zWVg2dWQ5U2FWdndzZEtWV2RD?=
 =?utf-8?B?aENZUzhTUzY2QnFNdXhxa0E2U1cvMDBwOVVyYkxod09GcjUrSVRscS9RWGk4?=
 =?utf-8?B?RHRsS1dNakxUQUsrNHFzOWZTSmVKdDZtZ1BGZjhlajNuOVpUZWd4NWhHVkt3?=
 =?utf-8?B?RkQvd29qZStFR3BibUp6TUd5aDdZRmhRb2ZBUnAyNlZGOXdldWZXMXhZa1hv?=
 =?utf-8?B?S0VJd042OENqR05kcEtsVCtNRmUyeDR3Z2h1QThEYXZab0Yvc29YL1RGb1Zh?=
 =?utf-8?B?cW9LcjdRTTNQZjROdzRFQzNRVldDMURDVVViTTg3TGdETnB6bWJRclFaVDBp?=
 =?utf-8?B?UGt4WC9xNzI0cHpXMEorcXJrSnJTUm9uUUlkMzdpUDIrbHpueTZhZDZhbXBC?=
 =?utf-8?B?aHRVTVozT2dmQi9QeHVUeDdycTZQbTM5bFUvcW9zUDg1bEU4TUpoSFl6RVhS?=
 =?utf-8?B?VW1uUEU3WTFPUTIrUEpUVlZQQzF3RUFzWmU0ckRMSVgxSEx4dkFGaS9kWjJ1?=
 =?utf-8?B?OXoyekU4SytDRzh6c0hac3hXYzluQko3bEx2VFpYQ2JFUnk1Q01MVzFQeEtX?=
 =?utf-8?B?VWdaT3d1MHp5c3VUWGN3ZGdITHVTRlNJenVINE5VRUxLKy9ML256SlVGR3Ni?=
 =?utf-8?B?c2dFQjVpYnIvQ0ZtUm5hVFJzQUtmYTZVcmZJMHdFZ1hSYURnelVvRXJPT1Rv?=
 =?utf-8?B?WktYUUo0NERpMks0NTM5N0NwS2lIS1FVcTZYOFE1Tm5ndlU3VGM4NzVnejYv?=
 =?utf-8?B?L1FrekRrNE0zYWhxNTZKMVpSaEM3aGprbjlqUGxmSFNUS3Q0amcvNTk1NW9j?=
 =?utf-8?B?MTNLcGNIQWtlRW5BcDZJeTU0bk5jUkx6UVpud3RIQVJyNmE0T1c4ZU5qV3hz?=
 =?utf-8?B?Qy9QZXNpSllWaXZreUNOb0JWSm9rR2ZXMGltdWN4dXIzZ2lnUkNQWEtxL3kw?=
 =?utf-8?B?anhxK1JUanY2NXhWWFZmR2xDeDhKcUdtWXpYUzBaOXJZdWJMMEtoUUNONkJU?=
 =?utf-8?B?UVc4MTY5YjNsQmZqM2d1c1UzOCtEa1Z2Zm9qUmdKRjV3TnF6b2h3cGFSeVlH?=
 =?utf-8?B?YjBlOEZ4MXp2Qkx2cFkyR3JDWXoveFRyTGRFTVZmSU1CQzRlb2pPS2tMKzg5?=
 =?utf-8?B?Y2tySWV6eWU1WHBmRXppQTZEdjA2cmsvUnZ4Z1MyS3R0aDVUVHVzekluRDJT?=
 =?utf-8?B?OHFmZ2hYczRXQXhjcWlmdndjTHVIK2pGbk5XRm0zOGhnNUdzOWZuWnBPckhu?=
 =?utf-8?B?NXVHSzhKOHdKR3drNGFWWlFvV2ZKam80MVJRT0xwekF6K2hIeW9pRTM5RFUv?=
 =?utf-8?B?QlZSS0NOcTlrVmcyK1pBSk03eHFCVitSUDVxd0FKT0J1SHI1US82UXVBYlVO?=
 =?utf-8?B?OGtWQ1ZRc3hEOVd2cHlVZ0dKZE1lRHAzVWVLZDlsa05JVkMrQlcvdHUrV01q?=
 =?utf-8?Q?5p01g9f1f5Nf5dl9C3YCBzIYJ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 180271e9-7dfc-4863-64ef-08dc18a64928
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7820.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2024 04:22:45.4437 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p6wMTvZXz1BlSRJNdoE4InbogwH9bGNIzcF+/92UD68bikyt2HjL2gCnXk+QqpbX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4886
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
Cc: victor.skvortsov@amd.com, vignesh.chander@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 1/19/2024 9:17 AM, Yang Wang wrote:
> update smu v13.0.6 message to allow guest driver set gfx clock.
> 
> Signed-off-by: Yang Wang <kevinyang.wang@amd.com>

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo
> ---
>   drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> index 952a983da49a..35d8a309eaf7 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> @@ -161,8 +161,8 @@ static const struct cmn2asic_msg_mapping smu_v13_0_6_message_map[SMU_MSG_MAX_COU
>   	MSG_MAP(GfxDriverResetRecovery,		     PPSMC_MSG_GfxDriverResetRecovery,		0),
>   	MSG_MAP(GetMinGfxclkFrequency,               PPSMC_MSG_GetMinGfxDpmFreq,                1),
>   	MSG_MAP(GetMaxGfxclkFrequency,               PPSMC_MSG_GetMaxGfxDpmFreq,                1),
> -	MSG_MAP(SetSoftMinGfxclk,                    PPSMC_MSG_SetSoftMinGfxClk,                0),
> -	MSG_MAP(SetSoftMaxGfxClk,                    PPSMC_MSG_SetSoftMaxGfxClk,                0),
> +	MSG_MAP(SetSoftMinGfxclk,                    PPSMC_MSG_SetSoftMinGfxClk,                1),
> +	MSG_MAP(SetSoftMaxGfxClk,                    PPSMC_MSG_SetSoftMaxGfxClk,                1),
>   	MSG_MAP(PrepareMp1ForUnload,                 PPSMC_MSG_PrepareForDriverUnload,          0),
>   	MSG_MAP(GetCTFLimit,                         PPSMC_MSG_GetCTFLimit,                     0),
>   	MSG_MAP(GetThermalLimit,                     PPSMC_MSG_ReadThrottlerLimit,              0),

