Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DF79C001DE
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Aug 2023 11:28:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9EEA710E4FA;
	Fri, 18 Aug 2023 11:28:44 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2062.outbound.protection.outlook.com [40.107.212.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BEB1510E4FA
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Aug 2023 11:28:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fbWhzr4Lu+k0cQsiVdCTX8iFcdDL1aDW68S5fRPnbCvXxpU0bLAYfx/5G6DSz4WVH6mNfkg1yyqe92YfHX+l1FwGMO1kyOJoME9jtZLZHAdldT+J4kZMQdv5MJFJ/1FHpmmy0+gMLGHdwYvIFJNJZgntPH920m7Cb75aBp6Rs4a8HI0owafd7Hd30IztRyma3cFy3Ttn4gYyIX0bUZZIgF1B/tLvtmlBaHVZmEoO56wL1+RRtjdNzYQ/oYv/Pz18YA8EB4pKE4LsIjXsaJaA/8FZcHSmwN7mqO+bWjrNaiYXGOFe5fSNDmU0djxszgVTGXOyTl8nBKo1y7ybOmefVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uaUtpaIRXIZLrsgUjf0Eep2fGx4xgSZ/Si33nMzaYcc=;
 b=f3C1E5Ta+NhsiXNnKZc+K3u2uhpmuo/P/09WDGzcZs9ISSTTnrrZX3vnK/WmURpSanowGtf+brLMyNhs+kjzSzd8ZH35KcY44beU8VyZF8jb4FZDIAWpRyFzCGHrbANhxnouywtQQM/n/cc4NeWgfUtav6x065tDT9vdwmVKu+HOixUvjCYPoBMCu6AbDS1Tsr0LmgiEtVz2GvtwkymztXC3kvG0DE/AKTXr8BLiIfCpiY0YE75ySMnXkHvpu7FFN8OZX3eYjzoRJIOu+PPlVnTrBje12gRpN8x5vqrHTiGHLHpCWlACEbZUUdGbWbNU8O/AFZWQ0y6xS93Je5vqxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uaUtpaIRXIZLrsgUjf0Eep2fGx4xgSZ/Si33nMzaYcc=;
 b=2gvnn6YHVl/2rBuZ4MCiVXjL24Nho1LNTZSs15kO4R4KQtZOhsysBhmt6noiBK7BZkK4gicjZJSQX81LAyt0RyJn7/xXuo/908Pc4HajQkyHD2bF45V1Jrk7ZUzy2nzhbMBocYbvmx72V1FhGfEGMuzHwJlTkIQLYc0M6SkhT1c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by BL1PR12MB5301.namprd12.prod.outlook.com (2603:10b6:208:31f::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20; Fri, 18 Aug
 2023 11:28:38 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::af11:a0ea:b4e4:d1e0]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::af11:a0ea:b4e4:d1e0%5]) with mapi id 15.20.6699.020; Fri, 18 Aug 2023
 11:28:38 +0000
Message-ID: <fdb66994-436e-e852-e289-7654364e2baa@amd.com>
Date: Fri, 18 Aug 2023 16:58:26 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v2] drm/amd/pm: Fix critical temp unit of SMU v13.0.6
Content-Language: en-US
To: Asad Kamal <asad.kamal@amd.com>, amd-gfx@lists.freedesktop.org,
 KevinYang.Wang@amd.com
References: <20230818110055.1231261-1-asad.kamal@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20230818110055.1231261-1-asad.kamal@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0082.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9a::17) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4614:EE_|BL1PR12MB5301:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a81bdeb-6e11-44ea-ee46-08db9fde445e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PMPPdiABzBgTQ9cVmk2hDaRjKWDKflVClA1tW6OXLLq+OLc84+5PxxmeynfLYBH/5a0HYZFKIBq3bOvTp9GbnzEytWhemyWftalwzuPn9tQiPDjknxmxom+MUSwqXE2+jLmtjhCnTJzmCDu//xjaMIeHM6r4rfRASKKHX2GUikGD1I1bPlN/dgMjRs/a3dPrhPCMVFFcnxdh/xM6f5kZn0EcQp7x9Y3Pa6CwFBSvP98/TI2GGz7pPj2Cj/X+Q8gi6MQy8R08LYICfXa042dbJJlBx1pFXQBqj2GYhCdrcrEhDmy8nQl+GS6lySwVIzWZpWBQilach8lLQjiU2O1bzHJcLCvRkKQeD82s39bj90M0+fBm3EIvBPqFv2IVNR1rvt45w+a7hzkL2GOhP+IFjp/PsfkiAspr6ThPHvSKGjq+3yBlhxj1vE+VntMIbywNjEJ/eRGmvqk3oiRrM8ouXBPaj8j6eRcxlA5UQJtAwONIl8oB49ss7KZbsA2TH0SWd2ImYSc97H5We3SjfNCaVhbrn1Orkvq1BAB7+mO9oodyKcmqjAMkTvca4Yc6C5ii1r5zIVCf+byPpVziVkvJ9Db2g8n3axC3HIoRTyWzxs1CAPBd5UWI5WyqVqGn+aqGvEvKmH0E9Ozi8yMQuJi3lw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(376002)(346002)(396003)(39860400002)(136003)(451199024)(1800799009)(186009)(316002)(2616005)(6666004)(26005)(6486002)(6506007)(53546011)(6512007)(83380400001)(4326008)(5660300002)(8936002)(8676002)(2906002)(478600001)(41300700001)(66476007)(66556008)(6636002)(66946007)(38100700002)(36756003)(86362001)(31696002)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TnQ5dCsrdHRydDFya1JRMlM0ZEVMT1dheG1WTlgrVlpSalk0YWQvd0s2Tmxs?=
 =?utf-8?B?Y3lVQUljNTVOS3RpWUxzUW5Bc0JMWDBTY21xaWF3UGNUc1BRaHhiNHBBVnFU?=
 =?utf-8?B?RE14dTduaDQ3WjBIc05MaUpheVJpSnJBdHpzbnpGeTBvejVZK20vR0JhaEJ3?=
 =?utf-8?B?M1JzTUhpMFEwc0swU3RiMnllR1EzQTkyS1hab2pYbmVLamIxK0Nya2MrYWI4?=
 =?utf-8?B?NDlENkphOTB4aVpQQkJUN3B1ZjNJeVBuOWN2Z1B1cWZwL3RNMXVycUF1bDhU?=
 =?utf-8?B?MDFQL1llaU1TdGpiT1orYUxOQUVxcTdhTjBEaE1hV213S2l5eHk5ekZ4Y2tW?=
 =?utf-8?B?V0xhdEdvWkRhRGE3UUN1ME9LeUk4QlloYlh5RmdwdzFnYStkT1kvUU9Xdmdl?=
 =?utf-8?B?MThzSmtGUjQycWs1M3plTGFabS9udnc1WFJ3OFZVZFZHalJ4Z3JsMHhwWjR0?=
 =?utf-8?B?WTVyU0FKcFl6SGsyd3NZTVJSRjc2eVBoaFJsZHo0MEowSlZHRHE3QUE1aGdI?=
 =?utf-8?B?Mi9VdG8wOUVDSHNDbHdrb2ZwMzVWaFNGWkNFWDdBOFhjV0ZjYmc2U3Nzcjdn?=
 =?utf-8?B?eFIzbldXMUVsQ2dxa1UwSWRFV3EyVlNINFRsTFFSM3ZIdnd5RkFkUENkWEVq?=
 =?utf-8?B?WHFBVlBQb1NLYVRCbGpFZEtvb1lYSEFBK3RNREkvaTdPcGNZT2ZjZzkwRHVj?=
 =?utf-8?B?WVFvUFNqMkhIYTczMkpacmVjcGFpMWNvSTBHanduakpqQ0lPSDZPbzh5M3cx?=
 =?utf-8?B?VGR4cXVjWlVYeEdySjB1RzZZV0hQYzdReVBkVm92NHAyT0hqNG94WE5GTXRp?=
 =?utf-8?B?SUtBT2pZUENkRzlVMlF1STdNdFhXclFhVFM1TzMzVzdKVFhmcC9POFpHMHNh?=
 =?utf-8?B?Q2V3NFEzaXJjQkxaUmF3ekRNZUtid1R0R3EvenRiR1dRbUt5QXdtaFpLMWd4?=
 =?utf-8?B?T3JwUFJsOHJVcUFlSk9TcW5ZcDFBSWdkMCtRQTdpYlo0ZGQrbWR1OS9NODBo?=
 =?utf-8?B?Y21oSm9wek5LQzJCc1l4UnBXNWxSTXdOUXAwZ3kzdU43WjFUQVBvbHh0TkZE?=
 =?utf-8?B?QTJXU3hjMnZ2SWNPT281eG9HNzN6b08veU5WTEFWdDJGSWkvWE5XYjE0dWl0?=
 =?utf-8?B?OUxYR1JicU01UzZEUlZKZGwvY2pBRWhhNmJvTHhBbG0za0F1b0hMVlFZa1Bs?=
 =?utf-8?B?ZVY4YVRiTFhPR3FkMWxLYTJnQTdNZlVtTUVJRHRMQVhnZXlheDkvaFBaVnpX?=
 =?utf-8?B?TzAyMDFYQkV1TGdrRWEyU1hicWt4cWQ3TmNMQ0Urc0UxMGVscFRhZ2pYV05l?=
 =?utf-8?B?WnExUWxmQnQyOWgrRm1mQjR4M3JaU0h0bi9KbTNseVlNamVFZnNiQURDcU5r?=
 =?utf-8?B?OTBxUW5PZ1dFMVlDeTB0cVRJTHU4SS9jaG1hN3dTZ1Z4c3F5aWZWUkZoL2Uy?=
 =?utf-8?B?SWMzQVNUY0Nma2c3SUY3T3dPRVpSNzR0aTd6MXBQMXlQRU9qYWkvYnIvcEdX?=
 =?utf-8?B?b3hoN0NZaDlERnlTZmpFUVMxU1QyRUgrTmwyc2EwKzVpZ1lBU2hkR0dsSkVD?=
 =?utf-8?B?Q1I4MXhGT1hQNGd4a2pXYmZOVnJmd2xkOW9jbUtYSFp3WkxBd0htZ2I5UEpJ?=
 =?utf-8?B?d3B1Yyt6Ykc1SnJOMU1IZTVwa3hwQVZYQ2hOSkNRdUJXaVBoY0VnQ0tYOE1i?=
 =?utf-8?B?MlMrVjZwS21ZZ3paQWo2dVk4cUJ2TG9YcmhOSXFlU0dReVdQNWpJNXJMcjEw?=
 =?utf-8?B?ZFRJTDRjVWxUTkViTmFSTjIvRGtsTDI4eVd4Ukt0cDVaNjdiREdIQkdXbGY5?=
 =?utf-8?B?L2d3VC9sdTA2MTR5ckdkWTVzUWFhcWpDVWNzM1JQQ0VsVmtwK0N4dVNGNlBY?=
 =?utf-8?B?KzhtaVo3cDNsdDR3WDF1a1ZsWDlvUk53K0VaL1l0T1Q0ZDNGYm11TUdEYUNk?=
 =?utf-8?B?YkJ6dkxmcGJpSWhUVC9Gbm9ZMWY2WXpsMjZFSTkybS9oRGJZa3RkK2gyWnlm?=
 =?utf-8?B?YXV6NjFZNXNCQ3F5VzBNa1c2Q2h3T2hpRmRZMVdJR2s1R1Jwc21ua1R3eXZh?=
 =?utf-8?B?TS9ETlFBR2FQM3lzRGpvbFVNRkovb3hwbzBmdTBEamJQRlhyN0ZLRXE3YkJD?=
 =?utf-8?Q?Zb7OMyZ0Z74E/U6YHkQ65R55S?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a81bdeb-6e11-44ea-ee46-08db9fde445e
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2023 11:28:38.6090 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BKzgCaYYDDhw6NpCSrekzYy637gSmhVTzPWLJe/fUJHZBoGxBbUOouZF3a48l3A+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5301
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
Cc: le.ma@amd.com, shiwu.zhang@amd.com, hawking.zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 8/18/2023 4:30 PM, Asad Kamal wrote:
> Critical Temperature needs to be reported in
> millidegree Celsius.
> 
> Signed-off-by: Asad Kamal <asad.kamal@amd.com>

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> ---
>   drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c | 9 +++++----
>   1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> index 7d8af9b309b7..d3b578e6bc2a 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> @@ -2086,7 +2086,7 @@ static int smu_v13_0_6_get_thermal_temperature_range(struct smu_context *smu,
>   						     struct smu_temperature_range *range)
>   {
>   	struct amdgpu_device *adev = smu->adev;
> -	u32 aid_temp, xcd_temp;
> +	u32 aid_temp, xcd_temp, mem_temp;
>   	uint32_t smu_version;
>   	u32 ccd_temp = 0;
>   	int ret;
> @@ -2119,13 +2119,14 @@ static int smu_v13_0_6_get_thermal_temperature_range(struct smu_context *smu,
>   	if (ret)
>   		goto failed;
>   
> -	range->hotspot_crit_max = max3(aid_temp, xcd_temp, ccd_temp);
> +	range->hotspot_crit_max = max3(aid_temp, xcd_temp, ccd_temp) *
> +				       SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
>   	ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_GetCTFLimit,
> -					      PPSMC_HBM_THM_TYPE, &range->mem_crit_max);
> +					      PPSMC_HBM_THM_TYPE, &mem_temp);
>   	if (ret)
>   		goto failed;
>   
> -	return 0;
> +	range->mem_crit_max = mem_temp * SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
>   failed:
>   	return ret;
>   }
