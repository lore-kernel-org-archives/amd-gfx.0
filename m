Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E320C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Jun 2022 20:34:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0414210E246;
	Thu, 23 Jun 2022 20:34:02 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2041.outbound.protection.outlook.com [40.107.101.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0201C10EA2B
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Jun 2022 20:34:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BFmTotG0W2U91hRzJWWCL3h6MG3oNCDD/cA8k8QH9H09IsOvWK63EofWVv7NwhIvXMoWKzD/8kDBrZN48KED8PKRhiOqWfl38x8m5puDmcaYW+ykty2kUxgSWbh9GB9LoQOIhpO0o5cV0MkHzWgIhBX+uSUvXxezOctQvuv2wUI4UxaifA792zjZngiPdKfm5vgbqazrCTCxkyZtFO1a9oikzckv+HucJ8kb877HeYGfyuN5ThEuJiy1+gwFM4U96UjV5/ozLDEbXXfpq00fL+h/K5+reArpzSaKVk+zE//HEvgzDx09RmMtwvznNxTQyEp0hVdiQI5/uWppZmARtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZSuWa4MtxUwAnhp1hX2oO1838Db+LfNgG1rJIBLvg4A=;
 b=LH8YmyXtigf20ku7LBXUAJYer2jPrCmUTBag31Eiz1Dfsn1eQtuef1f6uX5I898V6ww3QYRWhl4no1k3yilPdVG4vUTBp/R1zoL6VVX59fHi4uLCs25W7P+0tfTEt8uShBLm5RLAQSEpkXl07ibJv/KHpnD74h2cKyGzlZCHupYkJEfEYaapnrqxcy8T6h1gTISlta64mRuXGbF1wJHBM4pNdVqBWx8Z742mVy7ZRcSAbVnlzN+ywlZerQoOU1WrRUtFAbhs4MQQNihuF2oxFQaNR6JeZaZD2m273RL3ERRXaQrsWao0ezvznNGvRFv9UITgce2bQSKEgtChCYajNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZSuWa4MtxUwAnhp1hX2oO1838Db+LfNgG1rJIBLvg4A=;
 b=htz4TyFXYnluRKcBOdkalHeRaTXYTfME84F6CAurXu2sGxBnB6E0Uss2FNcBSLM5V9ZGhbyeT8++UB0tZwzVIwrgNP1dyl+eKvsUuC/OMxNwfOLI3PpeXPscp8QYHDoH7j3xBuYRWEm44N1o+DpeC8UQSSSRBdKAUFEUsa0UJTs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5311.namprd12.prod.outlook.com (2603:10b6:5:39f::7) by
 BN9PR12MB5193.namprd12.prod.outlook.com (2603:10b6:408:11a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.15; Thu, 23 Jun
 2022 20:33:58 +0000
Received: from DM4PR12MB5311.namprd12.prod.outlook.com
 ([fe80::2d53:42b5:4803:8703]) by DM4PR12MB5311.namprd12.prod.outlook.com
 ([fe80::2d53:42b5:4803:8703%7]) with mapi id 15.20.5373.016; Thu, 23 Jun 2022
 20:33:58 +0000
Message-ID: <563f4430-c36b-139d-bcfe-902168e7a2bc@amd.com>
Date: Thu, 23 Jun 2022 16:33:56 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] drm/amd/display : Log DP link training failure reason
Content-Language: en-US
To: Alex Deucher <alexdeucher@gmail.com>,
 Chandan Vurdigere Nataraj <chandan.vurdigerenataraj@amd.com>
References: <20220623073320.2632780-1-chandan.vurdigerenataraj@amd.com>
 <CADnq5_P7DPv+HXrUUdC_KxG8LmAdRyKH-5vZZcL2GdRYZUzVfQ@mail.gmail.com>
From: Leo <sunpeng.li@amd.com>
In-Reply-To: <CADnq5_P7DPv+HXrUUdC_KxG8LmAdRyKH-5vZZcL2GdRYZUzVfQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR05CA0055.namprd05.prod.outlook.com
 (2603:10b6:610:38::32) To DM4PR12MB5311.namprd12.prod.outlook.com
 (2603:10b6:5:39f::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 380b8217-8654-4c44-5c17-08da5557b2f9
X-MS-TrafficTypeDiagnostic: BN9PR12MB5193:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QMyqtdxNHeUX1lgObzTjQoyRmZNWupFvMlIAu8ByWmq3/YiFAWgbZ4bHsyQPDjwL5nAQR8D7xnq0EDOT99AL8inH8SZcIdjfoLc3UghfCtWrjNoP8OQeuzY5vDp3lOdOlOn05BitePgWQ0UxY7EkYBQTcig6FUAN75gY2/fOFxpt/q5+jpwhGSFY4vlFAx2b23dlv4lOgm0yfKzsK3/HjubVcXYS/90Z+quUx7Pmsup6ZQ+sT2+FqxagOTna6Z7RR17f7PUh37lxHbeaYCelZRVx/rBrL/YKQny6uQxdRAAfZRy/alGomQaGwqymTrUEFr4ewU0U/6Fl5tCYcJH4W2R6sQoEC1+IB6IR8pvBEpxuEHSBDkUat3Hs7W0HkvgEdTlJaZ2GWIcAs4X6v9MglKcCuiaiBayQ0aIRDkQY+LlZphqyCdt5RTP4tf2e8Hx5pFl6XCFOI9c1s1QG9hNriynXHXq8Fd0ZdDXOB38jo0vm2qQ5TsLL4e9lqj3tCNsKoRfsHoR7BLU3j+HV6j1KL02hTNyk5303xZDIIuBLBm/Lkfm1VRNKLlxzi+LmNNm2KdD824qaYAX0KrFmTUNr1xIR5CySqFLUPGQ6RcXJqW+kgCIzYeaTUZlIwy2dEP2hF+N+GSAUDg1dRyMSI32J4tBnqtCH6hELxF+hq0022L6FOGPexNkgmSQnzgVvChWTZ4uoS9ESZz9q/adeqfnABizZPAaSc6hIG4bq2qeD+Za2FPlqb3H8MvpuToXO6gqGedB685EXniE5VyujFYPKiMkX6h4ZNEtl8hIniWz79JS+75L/AQ8KSKL/MFST9mEWNOWh9y+nYieKM05ZkF/+VA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5311.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(396003)(39860400002)(346002)(376002)(136003)(366004)(36756003)(53546011)(2906002)(31686004)(2616005)(83380400001)(186003)(8936002)(41300700001)(8676002)(6506007)(4326008)(5660300002)(31696002)(86362001)(6486002)(66476007)(66556008)(66946007)(38100700002)(478600001)(110136005)(26005)(6512007)(54906003)(6636002)(316002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Rk4vTXhuOFpWSEpJTkRFS1JyZE1NVTFqdFFHM2p0ays4VDJlOWYzVVdVbUZC?=
 =?utf-8?B?Y3dYbmk1N0RLczk2N2V1eE5VSzJ0RjlkVlkvVzNQMWRXc2pCU2ZXeXF2YjhZ?=
 =?utf-8?B?eXVIZnd0TFpOd1VXdHNLV1B2VERYdFR5NENndFppOFFpcjBWcWdjQnJMaGFH?=
 =?utf-8?B?M1pLU1hEU3dBaHE3TEFEUHpPZm5HY2RPaFIvMGZIM3VIYkRMdzRkaDF6amxh?=
 =?utf-8?B?VjFzUWJZTDJaajN0VjFiNndsdUFCSXF0ZFJleWhGdXcxNFI5MWhmR3BqUUZY?=
 =?utf-8?B?ekcvK2l6clFGbkF5aDZnYjZCaURaT2ZqTmUrL3VHOFF0d0tVOUkyajhDRUpL?=
 =?utf-8?B?TjJsdm5XYnFLUWRNRCtaSnRKTFNieFZkMndYZlU5b3NKOEVtUERSV3hnRUx6?=
 =?utf-8?B?bk9zZURYV0wzS3ZWbTYvaGVVeWtNTFRQdTlPMnBlN0tyejJpSnJlZUpiWllB?=
 =?utf-8?B?S1l0dGI5RStQbmZZQlUydDRFejZsc1pXVmM3MUpEZTRtRlU0OVQwdVZrRGRt?=
 =?utf-8?B?OHByWnJsR3c5aC9vV0JEQVFCc01Ham92Mk5qTk5FMG9RZVFVQlF0bEpqZDhV?=
 =?utf-8?B?VWw1MldpWkR4VVNEclFPcGdpTFpEcEJmaTJqTWRTNjBmOTZWK0ZpclQ0Vksv?=
 =?utf-8?B?Vm9kNUg5a1V0RUgzQU1XVlpCRTdaaEk3VGJMK2twWC8rRmZXRENNbzVpcENK?=
 =?utf-8?B?UEJKWC9yc3RKU0ZHWk1hRmNkNEd6aTN3R201OXptUlRTejZ5ekZENlNtSzk4?=
 =?utf-8?B?N2FuWFlyVlNnZUExVHdZU3lRcFRzZG5uc3lBcVZwYnJFMXFhbDJLbllEUEpD?=
 =?utf-8?B?RjlMRlh0cVpRQUlIMWxIK2I3VUNwYUlFQ1c5b3J0aHA3cVhyWWpjVTI0bzdJ?=
 =?utf-8?B?OWt3S1l5N3FyM0xLYjR2bmhjTmxhWU02MXlNRWN4S0NuMTJVWHBpL0R5eHM0?=
 =?utf-8?B?d21Edk91TjF3M013b29xdC9MS1RWZnVpWmVlNi92U0ZFMlRjRUhpUXhSM3hv?=
 =?utf-8?B?YytHUDQ1R3ZKbTlkYkhjNDNteUJyRU1udlQ3UDh3RVcrSG9ENUVWK0NHbmt6?=
 =?utf-8?B?YnJOQ3QxYmFzaHdLTUJnZnBQemxXUVkxSWZ5U3ByQU1MOGFRQnIzaHgyQjZz?=
 =?utf-8?B?QUg0Z3crWU13Mit4dmtqZmU4TUg5OUM4TWUyaWtBSG5aQTZMMk0zRVdpczVR?=
 =?utf-8?B?NStWcE12SGp1ODVzUXYzOXFWR2w3YTFrV0QweVZJcE5FMTBudUxqT2h2UjEz?=
 =?utf-8?B?TTVFeUg0dFdWSDFSVCtBMlBlWXRzMzJTd3ViMjlSZXlqSzBuckxaQ2dzYU5S?=
 =?utf-8?B?dDZtdUhEUlZWK0JpVDg2WWJSK3VFN2NBcFh1anFSOG5mbEFTRE42d2RUUTBO?=
 =?utf-8?B?Z29BMTltRzVYRmlablpybjhnemlVVE1ZQkZEQzBjajRPS0tCVDRxbWJEZkdh?=
 =?utf-8?B?VWtwZ1RoYkF3M1FUVEt2aHIvK2JCL3hvU3pnMG5OYWZOSWJlNmFZSFMwSVd2?=
 =?utf-8?B?WisxN2ttOEZMNERRQXJvaGVDVWVPZUNLZzNFcjc4YmdRaUsrbmZpQWw0VW1h?=
 =?utf-8?B?M2sraTJEOHdtL0U3cDdrZ0pSM3VxRytKaUNLQXpmNGxEVGNPSCtNMlBKeFpV?=
 =?utf-8?B?aHVlL3NqVDRVN2x5S0F4SkhKZlkrVTRYQ2tYcSs1blYzWXR6SnRZbFBhSU5T?=
 =?utf-8?B?RENTK0RoOFg1SFhaOFVMUXdPMFVKMHRaN1JDTWcxOFBTWktranJRb294eHlq?=
 =?utf-8?B?MFlFUnJaYjNBeVNFejl1ajBvL1V1UDVtQ3BLQ1hickdXckJTcUM0V2UrUTRK?=
 =?utf-8?B?VXQ3ZUpOWDJONGc2T29Sc1RsVE1WcWlrTFZGdG4vcmROMlVMYTB4aUl2MU0v?=
 =?utf-8?B?SmR1ejhDY3ZNdmg2T01CZEZzeG8ySU9aRTErZjF5VXdGODRPeEZVNUJFODFq?=
 =?utf-8?B?cjBNSHFjSEhwRTJ3Y3RJeHEzckQxR2FSWnc1UytuTElzZElWYlVIdGM3MG9a?=
 =?utf-8?B?RDM1M1FXUWs5aFlLK2xYOG0yQW5XZ3VPQlRWVXNKUDUrQUlvUHdESlZRMDJ1?=
 =?utf-8?B?eGdvbUJxbFA4Z0RNc1dCNm1rOHNWeGdYVUIyN3AyTms1Um8xeFB5am5wcStM?=
 =?utf-8?Q?Bmytk1Hsgfcmw20Jl8fIRHpoB?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 380b8217-8654-4c44-5c17-08da5557b2f9
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5311.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2022 20:33:58.0486 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XJFrN0JVD+4PXAiz/7G17NVLg13v9i5Xj0pxHPnTjvp7Qai09/2OuSwQQQUHha7f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5193
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Harry Wentland <harry.wentland@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 2022-06-23 12:48, Alex Deucher wrote:
> On Thu, Jun 23, 2022 at 3:33 AM Chandan Vurdigere Nataraj
> <chandan.vurdigerenataraj@amd.com> wrote:
>>
>> [Why]
>> Existing logs doesn't print DP LT failure reason
>>
>> [How]
>> Update the existing log with DP LT failure reason
>>
>> Signed-off-by: Chandan Vurdigere Nataraj <chandan.vurdigerenataraj@amd.com>
> 
> Acked-by: Alex Deucher <alexander.deucher@amd.com>

Reviewed-by: Leo Li <sunpeng.li@amd.com>

> 
>>
>> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
>> index 4027f439a5a4..c8355acd3672 100644
>> --- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
>> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
>> @@ -2786,9 +2786,9 @@ bool perform_link_training_with_retries(
>>                                 break;
>>                 }
>>
>> -               DC_LOG_WARNING("%s: Link(%d) training attempt %u of %d failed @ rate(%d) x lane(%d)\n",
>> +               DC_LOG_WARNING("%s: Link(%d) training attempt %u of %d failed @ rate(%d) x lane(%d) : fail reason:(%d)\n",
>>                         __func__, link->link_index, (unsigned int)j + 1, attempts, cur_link_settings.link_rate,
>> -                       cur_link_settings.lane_count);
>> +                       cur_link_settings.lane_count, status);
>>
>>                 dp_disable_link_phy(link, &pipe_ctx->link_res, signal);
>>
>> --
>> 2.25.1
>>

