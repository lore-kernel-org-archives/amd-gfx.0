Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99984C3DA7D
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Jan 2023 14:08:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2C65510E736;
	Thu,  5 Jan 2023 14:08:30 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2065.outbound.protection.outlook.com [40.107.92.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0710C10E736
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Jan 2023 14:08:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fFhnFCLbDqy1tcTzy90x/lC5MX4sp9Dt+m+eczB6EYssIPHxSfS5fmWSZalTcCt8VroXygNlEgIymUoMmJHBc32gwCXKUpVjL8UszE9rtDp0XppNskGSxSxnDfJK0i5tQ8KoPOY6tlk/5StBEhmI3J7698rwBnPobleCLPNvXJ7DVpiauUxbnwioLHkIniR31mlzHqs4eCtfKhp971+Qmv6tW5nR0r5qtympOt6WygERFH5bAfpm6sv+x0crrfALuOkrniX1HNe4Z/+BFIKVnBi+qvfHffiXsozoNJqz2HVzE/hEWCWH/b4UPSXai8vqGZzC+gDheWWeAjB0BtU8bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zwAk/ALUN3e1MiRuTHvnXDnvWtZOd19ogXDfAW0vKzA=;
 b=PW0irH6+HwfB8WiPUL8QcuDb6pY46MlAHFc2nDxes5Jmhovs6q9Y02uV9h9JTGIV7Ie6NJZka5zKHhYyc1ZBUbs1HD+oI8b1yHznj2VryGraFMcp/PRzCTZ6qIDS+HpYAOJyWQbWaQqj5GP+e2tUaJwSTBw+fpizWrtlXYeEbX6cpL2PsMq+5bNQ4TGH+/bRVrpQAasTvYLl6Bv3mBR01xSkPmHE2DffvoiQ8wBp8opDMN3e6AZzS4A/45EWQBIOWq5h0CsdMoiSDPaggHTxFDxRtPrt+c3IR3/Gg+VN44MVM7ZEMW0F0ITkTtV5DxYfNN2wp7GQtE5hkg8Fp/W3/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zwAk/ALUN3e1MiRuTHvnXDnvWtZOd19ogXDfAW0vKzA=;
 b=KUfjIhMXWQUDjxQnHs/hTPUv+08c2g53WsY2exkArSBhRaWlz+xDuABsqaxcz+HdlUdYEM7sykrXdyVkZ3P+9oz8Epz6ECiIUOdjJMIQOucNkfbWu27LMhYOBKaRlpjk4DSE3bOuycHvPpIU6CKbqpN2rRoWMT3h7MatUFnhbfU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by CY8PR12MB7753.namprd12.prod.outlook.com (2603:10b6:930:85::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Thu, 5 Jan
 2023 14:08:26 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::457b:5c58:8ad2:40fa]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::457b:5c58:8ad2:40fa%6]) with mapi id 15.20.5944.019; Thu, 5 Jan 2023
 14:08:25 +0000
Message-ID: <5bb75811-629a-4cb3-49e2-accd7e7ec23c@amd.com>
Date: Thu, 5 Jan 2023 19:38:13 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH 7/8] drm/amd/pm: drop the support for manual fan speed
 setting on SMU13.0.0
Content-Language: en-US
To: Evan Quan <evan.quan@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230105032259.2032789-1-evan.quan@amd.com>
 <20230105032259.2032789-7-evan.quan@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20230105032259.2032789-7-evan.quan@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0015.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:95::19) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4614:EE_|CY8PR12MB7753:EE_
X-MS-Office365-Filtering-Correlation-Id: 6cc3f463-53c3-4091-fcf6-08daef264fef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lWnn5B9xtk8T8KIHLmldhhV9qfke/pGuFaeTWI5eZibpiygSvhaZAGil8F6Qlk0h1KDcF9FRAwDFLrlFCwhgr0v4uYhnNK6KgPE0JG4jXJ8gHqmKjRoAqh0WaKaKEmjOrXH1lYv77qVrwyosbpXsRS0HlsiZvBZ37lEjZ/oNObNkF6HSmKbIglg+VL/Ie7ZVg6tUXZ3qtgmbQMGUCDeWPJikRipdUFGXtDQ9oKkObN8Y8PMUO0jT7MtyzA5ZPcJx8ryRfV1nyWJHkGphQcLQe4o7VjdbGIDezFhN5iOgNZYLztv324WgsCz3B+WYHnxID8O6r8tMR878zVKlieB3aiVndd5bzz6Ndln4gLVVeveJQA6rSvVhOBdIGKxeSYhy1p8QOrMBfdDbBk+G3MBEpaeGiOpNO/nYql+X7b7YvLGo1nCj3T0n1Jn/PIhQ5I2OeuMB18tznf9P7svv1y1AODzpbvKD1oCz1LvD4h/JuHkw/daPbYwjTUVwCjJV95IZZwpyQ/iFrX3yn+UHYY86k8FQDd0tdf/ONJ1xws66HGQ0g+yjrPfBVurcw0nHvmC/tgLZR63c3YskONYswVtKeGPLiNYJy0rUXeusGNd3GuUvloicGRjJ4AnV15d3dmjfAExXRhZhWW7zaXGNDDtVM3qAYCdKt9uTB3V49hKZU4rMBxhRM5cDPgW9b5HjU+xdmcRBYcHcoikS56M5k8ictMHwRYkOLb10u5pBBEs2foc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(136003)(39860400002)(366004)(346002)(376002)(451199015)(6506007)(53546011)(478600001)(6666004)(36756003)(86362001)(38100700002)(31696002)(186003)(26005)(2616005)(6486002)(6512007)(5660300002)(31686004)(316002)(66556008)(8676002)(4326008)(66476007)(66946007)(8936002)(41300700001)(2906002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N2Fab1dBc2JPVHU2bERJNXVDVlN6N3NCMTJyZ2ZOd25kWkZpZytGa1hJOVVs?=
 =?utf-8?B?OEwzRDNMTFdQMnRNN1NsYUQ3MXFQdU8wc0JTVnJFU2hHM3k0OW45UEVBQ2Y3?=
 =?utf-8?B?UGovV3RGYVBnTlFMaGhTTTRhTi9GOERHV2ZCZVF4dVo3a1ErT1NrQ2VJR0t0?=
 =?utf-8?B?ZXNtN3RPbEFHeVNEKzBMMk5YZUl6eEM4L0VqZzZsWWRVVGpReENabzFyeWVI?=
 =?utf-8?B?N1h4cy82cG5FNDNSMHJwTmduVGgxb0xNVEtKYUk1ek5JdndmTllHMUNIYjhG?=
 =?utf-8?B?RkpEbWFpaklsSWhSdzkwMHR5ckVuRzVmdGhEVlgyZ2RyWmgrcGFCMHVwbS9G?=
 =?utf-8?B?MXhvbThidWg4b3lTcjNtS3czSFhlZXZJWkMzeFpYRUhFU1VIekZaTG9EaGk2?=
 =?utf-8?B?bTVOV3RHcm42a0pSaFFYcTlYVFEzSzN5aUZ1dnpGbkFCdlF2TndiajFTaWxw?=
 =?utf-8?B?WThGck5aSkQ2bDE0bW1jYkRjZzU0cTV0QnFzNyt0MDZnQzU1N0dQU3pzNHpV?=
 =?utf-8?B?bWNYR25EYUNUUzE0YnhveHVWdjlreXpKL3FBODVFa0twdVZ5bDJjSklmT05i?=
 =?utf-8?B?bE1xVHM1TFA0U3NCQlhuSmI5WUpreGxwR09nUXVOVTVyK3lMRXpSWVlwditK?=
 =?utf-8?B?Y3YzUmdTdHpXdXdjT3ZEYldhQjVaUVpkSlQ3bzRwdHY1UHRZVVNhMEQ5RXhy?=
 =?utf-8?B?MVJrcDl1b0xPZlA1VXpBdG1JM3pkTU0xZ3JNNldZbmZsdmpXVXZBZUtaUWVS?=
 =?utf-8?B?bko3M3BqN1pZUlI1cThuakxPUTBOUDJTcWFmaFMxWDhTNWg3NTUxS0F6RHhu?=
 =?utf-8?B?eTR0SFhMOHF2OWhpWncyZnc0eThrM3VqbHdpOFdTSmowdnRHNGV1WVUyaW5R?=
 =?utf-8?B?OCs4MnpacDI0dXVTUzIydHFkalFzM2RxUmR3TXQrUW01dEZuRmpFeHJOZkhH?=
 =?utf-8?B?YVlkeFNFVlRDd3NQVlJXRVEraHBEUzNMZ0ozVVgxMmp3cmVyRjI3U2UxTVli?=
 =?utf-8?B?S1BIU3A0cUIyYW9hQjF1a2FiVFVCS3NUQk1GbXQydnJTMlZ0OGhGSjhPYWpY?=
 =?utf-8?B?bHkyVEZzcmhvTG9WRzNPWUdMSUtOMkthY01OeC9sWEdtUHFFV2N0bGliNDJ5?=
 =?utf-8?B?TVFybGsvUWliVXZ6K1d1L0VubU9xMkY0M2p2MFFoaTJ3TTAzYk5CYlcyM3Q3?=
 =?utf-8?B?MTJVbE1EUGFBdWpoYWd6TCtkR0llSTR5V2ZBZ1ZNMTJXUmpmS01FaTM5NkJs?=
 =?utf-8?B?UVk5L2JuUS9qRnNWdG5zbUJmdklleU54OG1aVWJTQm53K2tEazBPVHY3VDAz?=
 =?utf-8?B?djlVbzNoSUJBOHhjZmJQZDRQNFBLcHR2akhDOTZBRDNBYXh5VGkyRjFiVWlp?=
 =?utf-8?B?QmhmeVNBeEdaSWsxVC9SazViZG9CQWdFejhSeXI0eTlaVjkyZ3BzMTViZGRC?=
 =?utf-8?B?Z25tSGx0T1RYTFhxZ3diR0JqNVpkUlpqK0hQRFBPazgwdEFoZHhSQ09yUlBD?=
 =?utf-8?B?N04yaVp4SnM5LzlnSk9tbm5OMHFmWU1ZOTl6WlhqajNJTXJuWUg5WDBDc2Ev?=
 =?utf-8?B?UmVHb3ppN0FRVkJlS3NEYjFLcUFmZHdwY2RKQzFBRDNJdTFiUm5pcW5RSFhE?=
 =?utf-8?B?cnhFa2hiRmszaXpsWktOSEZMbFJrZExlTXpVTXNSMUhFRVZOdzhKa1pKK0xM?=
 =?utf-8?B?aUgrOWE2aHQ0L0YvaGloeWQ3bjRtNVZka3YySlJpTkZIVzB2aW5BdTA0Tkpa?=
 =?utf-8?B?cUNSbU5hSE9PYThFQjdwdHhkbkd3RmlWWEFJQ1BSR0pPc29nNlFLM1dXcVlC?=
 =?utf-8?B?d0d5Y3FZWUxDQ1U1WWdkNGtYUHJqeWVmMlhWZUVGUU1yMjRCUDlzeldZMGk2?=
 =?utf-8?B?bSsvZE51d2MzdnpxcWNudFAwNUNuTjlSMDdmNHVRK1lPRW1Jd3NWT0M1NDlk?=
 =?utf-8?B?NTlMMDlUM0tPUThxSk54K0VNZEZPVy9FWnpZclY4VEJjVjZKOVpVd2k5OGJL?=
 =?utf-8?B?eENtM0tid2JwM1JKNTQ1TXRGU0V0WDVhb0xsdlYxWHFqK3VVSCtoTldnQk1C?=
 =?utf-8?B?S1FxU1BEQ0ViQkdxdFF6ZUdnOGRiVkcvVVlWS2dYeG9aNWxvS2MzZ1laOFFt?=
 =?utf-8?Q?0bYTT/luV6BBhpDECqlced/M9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cc3f463-53c3-4091-fcf6-08daef264fef
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2023 14:08:25.9332 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0lWrsKtW6t2Dr17tzRh0Smhnzfu2GOVHwaXCIZ0I6Jj/gtRgB1SlUhR4mRSYW6ZF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7753
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
Cc: Alexander.Deucher@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 1/5/2023 8:52 AM, Evan Quan wrote:
> Due to lack of support from PMFW.
> 
> Signed-off-by: Evan Quan <evan.quan@amd.com>
> Change-Id: I5d466d3d521b26a484bd837e173b9b289d4020ec
> ---
>   drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> index 75c9f510e713..59cd68862973 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> @@ -2061,4 +2061,9 @@ void smu_v13_0_0_set_ppt_funcs(struct smu_context *smu)
>   					      BIT_ULL(AMD_SYSFS_IF_PP_DPM_DCEFCLK_BIT) |
>   					      BIT_ULL(AMD_SYSFS_IF_PP_SCLK_OD_BIT) |
>   					      BIT_ULL(AMD_SYSFS_IF_PP_MCLK_OD_BIT));
> +	/* Drop the support for manual fan speed(RPM and PWM) setting */
> +	smu->adev->pm.hwmon_if_attr_mode[AMD_HWMON_IF_PWM1_ENABLE_BIT] &= ~S_IWUSR;
> +	smu->adev->pm.hwmon_if_attr_mode[AMD_HWMON_IF_PWM1_BIT] &= ~S_IWUSR;
> +	smu->adev->pm.hwmon_if_attr_mode[AMD_HWMON_IF_FAN1_ENABLE_BIT] &= ~S_IWUSR;
> +	smu->adev->pm.hwmon_if_attr_mode[AMD_HWMON_IF_FAN1_TARGET_BIT] &= ~S_IWUSR;

This will be taken care if you set the corresponding set ppt funcs to NULL.

Thanks,
Lijo

>   }
