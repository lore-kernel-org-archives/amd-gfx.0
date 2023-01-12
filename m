Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E645CC54EBC
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Jan 2023 16:22:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E35410E1A6;
	Thu, 12 Jan 2023 16:22:43 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2072.outbound.protection.outlook.com [40.107.93.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5C98B10E1B0
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Jan 2023 16:22:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BGn0zFmU87xSwW2XKyCVwQXCv+RMDF7DrEl3JIrlinRd8kjAKHWWc14zySmz5dRCXAObR5gHKr+njbPrRJ07uuTWdwHZiLceUVWLjjXCLcWQ7pn/Xn+0jQpSbsXglUhCSAgZeueyntIiJMwpFOtIMGcXircDKq5fFw/fAuhXAjZjBh1296OdiEIqjmtf0OlDAR3sj6DOVjVDioMf3L7y2I5+5yRKmg5UygIVs3JIcHGOmJqCscaKJkbSMsU5R7OVhe1JmUwF3E/4GgzV7VEodiU7vUZTrztMg5UwFOMXR7eK5HBFrgotN9dyLAzJNYvNcvCQ4l1kEuhVxnyPRbHaPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dp3tOsDu+/tt/F015wuIWT/JUa3dpCz2kzDoxb6+LZU=;
 b=WbtMdMryVI05wCUrMkPFcDJtilJzEOsSXubKl9xQqkiIowD2Qy1OVpRjtaX553XZGMpN3Z+O50z2ESwfTC27SfoWV/oC7ICX7u0Tevv3JPoLxaglsQOHP+trdFX8ExyOVGACct0ZjFQoEjM0WzRcdShuy/WzMJan1XI+huuCg+l6B+v3r6nvSMEG84P7P5JL99Br8HEoXBGb/rz4NVJ+k7E5jMaW5jUSbGxNrILGt8OudvyYUJkSbwyzvozh8P9DFwyESVpyeruXbNmtBsxs34COkqyDN3nr3qxbqX3pahbr+SI9FaXJ2tvIWb+jFppXehF2BsC0FnDgkdPKmcbMbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dp3tOsDu+/tt/F015wuIWT/JUa3dpCz2kzDoxb6+LZU=;
 b=O7nBTdVTur7jTVcURVjIz9jb4JIOfbGFTf+PxVHCr9XrX/USm3/uvUEPz8ayO7iBXKelrJLXHa6A1IIFpBxGg9IuLlbGRAVIafo4Y7WPNt/vvOQjs4KK2ek3GY5rutjXGYiZB7PlpP7o8+nkNOpSGp5s1/HuR5UJ7xj1EeFJVuE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by SN7PR12MB7129.namprd12.prod.outlook.com (2603:10b6:806:2a1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.13; Thu, 12 Jan
 2023 16:22:40 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::152b:e615:3d60:2bf0]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::152b:e615:3d60:2bf0%5]) with mapi id 15.20.6002.013; Thu, 12 Jan 2023
 16:22:40 +0000
Message-ID: <f2209fa1-7fc7-617b-396d-bc949f68da2b@amd.com>
Date: Thu, 12 Jan 2023 11:22:36 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] drm/amd: Avoid ASSERT for some message failures
To: Mario Limonciello <mario.limonciello@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20230111215231.20122-1-mario.limonciello@amd.com>
Content-Language: en-US
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20230111215231.20122-1-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4P288CA0074.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d0::7) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5427:EE_|SN7PR12MB7129:EE_
X-MS-Office365-Filtering-Correlation-Id: 29f659a5-1226-4f37-736d-08daf4b9397d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gIzK/mB3d5pb2uU2+Qr9xiWJia4h5eSusXYNpj9vc+U5Ao3Hfi9sskB+VfNaYnIwxBlaJDBZnKD9k/OGrjwb+QcB9K55tB3+UYYGhtOT7DBg+ItzBmYx2HITnnLeW1LXdAeX72U0d9Ng39u0akXdt+8hUfh2qY9m7OpPMIHRkwMAAqKUrwH0j/P/Bcge/we+9ITP7bp98gg1NqtUivC4cZH5ws5/nMv2qUZOHrqjSyyH4Lvj/WiPNEjmf6U2QJFx5b10sN+I+JNWnxdnQB3tBMh/luiTrsfppkXBHNbU9yloj2Y4LRi8OtUMcotuafGDP7nUzoMYYH0hxSNzX8F7ouHhcm+mH2PeLY7uvfoMZAjAvs0QKgx2bunQA1KmJsMCxBhSHX8Ae+K58AjOqMuPauOAxaCWXxdzOKR5QMcZj4rd3VvQYLbRu6nKbeuOMC7QTVwmM0zNrRr19y1fxfKpzwti4K1xoQQirtYT32E/hrxznGkG4F3jEDarKZLb84VsAbsSKPufqOypwOzORYNqoNOccts79teeQO+6b8brP2bfoUSFVCrjMCicZ/dJsYSJ+RqaxRZJaBNocacEL1Io233wB5Cu80PB2M0odsg2J8mQwIBN+2wE1NkZ9j8zlYL8t/2u/7o6uP9NG5wgpGGfz5jO6AjkqI++aiWczq7yXrLNISL87Uedf2m39SdlJKg/IKHBrjUsbWJOSU/AabpeMJ04cmBO9fhkfPIoxtmkQcM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(366004)(136003)(396003)(346002)(39860400002)(451199015)(478600001)(6486002)(41300700001)(6512007)(38100700002)(86362001)(31696002)(316002)(19627235002)(2616005)(26005)(66556008)(66946007)(186003)(66476007)(4326008)(36756003)(5660300002)(53546011)(6506007)(2906002)(6666004)(31686004)(44832011)(8676002)(8936002)(83380400001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QWtPZnRuWWdUZzYyOEhpQlZqeXJuVHZvSmNhVFA5aUliUG1kMHppUHMwSGtz?=
 =?utf-8?B?Q1JxR2xlRDdWdHJWVHdUVU54QldwUW5PRTEzVWEweUF5ZjRmajVJemROWXB6?=
 =?utf-8?B?eTFBRkNEcGs2MytaRHRGYzdLT1hucENUaHlnZ3gvWmJFSzlWa2FHQmE3b2Nm?=
 =?utf-8?B?YnhEcHVJUklyZ2lSdjB0V0xrcEFKNCtjeWhuZm81MUhGNW4zRjdvSDdiMFVU?=
 =?utf-8?B?ajZ0QVY3ZHFhOEY2VEROUytBYkJILzQ3d3B1SEdPR3BTeVFGbTdGZ1ZLUFht?=
 =?utf-8?B?bTM4Znk5dENIM2Y0ZnBJTDdEOEJxOHlDVDgwcy9DaXZpMmtFWXlvRzBJY200?=
 =?utf-8?B?SnJYb0NMM3lwSGpOMzJjeHd1U1haQkFjTG0zdVRtV0M0eFo0Kzg4MDZmNytC?=
 =?utf-8?B?bzgzQzcrWkVraFdQb0VNOWNkdXBySDVOR0FQb1Zud1VnZnJROFBaOUJZRWJr?=
 =?utf-8?B?Y2c5dlBjdFErNjdWM2ZLZUx2eER4NUp4MGNSMDFtL1pNYmlHTWUxMTcwektw?=
 =?utf-8?B?Rk9UcWRHUGVNdW1jYisvMVFCby9zT285Zk5rODlVbXpUcVRKN2lINmtWUEg0?=
 =?utf-8?B?STArNE1zWC9LTnFPS1RsS3oxcTdUTFIzNmh0MDNSS0UvK3IrWEhVL0ExeVho?=
 =?utf-8?B?dG5TTjM0T2RCVVpzOEY2Q1YwRytjVWN4OHlJODduZEpQb05wdGFITDEwOHZC?=
 =?utf-8?B?Wkx6bHdyOUZpWWpadGtHZndCOUtLSC82T1dVMFdPdWJrV2dJN3NCTFQyWjhD?=
 =?utf-8?B?RU02NlcxZUVqSVlyTG0xQkF0S0kwd3o0bHpsaks5NFZER2w2bWJLcXhQeTE4?=
 =?utf-8?B?Skk4M0RoSzQzZkdyU1ZtV1kxTWVYdWw4WHZjbyt0bHlFTTlIZ3hXMllFblhk?=
 =?utf-8?B?QTdJTGx4eTBsdGtoVW0ydWh5TVVROExPOHZGaGNicWIyd1NYNnNibm9SL3Rh?=
 =?utf-8?B?VHBTMld4Rkoyanl0YzBLZHlhVTRvbjN0Y0xSRWJRZ3NWTDFyMkZWeTVLdkZX?=
 =?utf-8?B?cmZFdklubTNrUXpDK3JSclFXZC9RVFdGNG9BK3RlWkpWaXdpSjE4Q2tRb0sx?=
 =?utf-8?B?cjVPaDVGci9taDNUZ0JGTy9PMXU2VlNJa2VzcVpTMG5ialh0M0FGQkN6bE13?=
 =?utf-8?B?dHFsQXkrMW13VUozUDhjRG1EVFFVTXNxYWVLUkFsMStKV3JtU0h1eGdqM2ph?=
 =?utf-8?B?UGFIdktMMngvSnBJd2NtVmNnYlNhUW1yeDgrRjVOQTVUUXgwcDZhSExkTHJa?=
 =?utf-8?B?S28wdktZYzloUTdKU1BkTFg5dU1tS1VQeEI0WEpLMDByak11VTAzdEJUeWF5?=
 =?utf-8?B?dXF4NlQyN21sazBKaVlITnVlVFBpWlBpNHcrekcyQ0pMelB4akFxZ093dXhh?=
 =?utf-8?B?bmRGeVdsb0VpTU0xMHV2RHhQbld0OVZpaVFNUDFoSlVzWFhhckd0MXFBSTVO?=
 =?utf-8?B?RVIrdHE4T0JoZFpBL25LNjdXSnJrZ2dkckI1SUxsUWZXdjVsTzVPeEVaWEl2?=
 =?utf-8?B?ejU2NXo0eDBwSmY1QUZWTmJObXdBSDNuUDBQdGp4WVN2Z1RjLzdJbHRjWnNR?=
 =?utf-8?B?ZVNhWUxibWg2QVBEb1BFcVptYUNnMUVTZkNPdTBnVUtXVzI2UjdMZjNFRndv?=
 =?utf-8?B?VTBOZG1pSVF3SXRJZml1STNDOFZSTXVlRXY4S2NLcENXWXlWdEczeGxHWjE3?=
 =?utf-8?B?cUh3WE1TSjRkNEltNVVkSTlkQ0pRQ05YcVArY1paQTRnOGgrdTF4M1VJdDRL?=
 =?utf-8?B?OEV4TzE2MUg5cFhxejk3WENWYnR5K210aG5iSmV0ZlFIb3hsNVJsQklsSGtI?=
 =?utf-8?B?bkxGUThBK1NtaVg3eW5HY1VuYTBKaUdJcXU0MllVWkFldzRsVWxlZmJEWVVZ?=
 =?utf-8?B?WVgvUEZTN3hKdkV1YlpQUTBjRXFTeU96eUJYaGMvSFBkZVcyK1B2VGtpWW5D?=
 =?utf-8?B?SGRNMDc3OFJsdVhZdHNFZ3ppbFp2SHZ3MDlqdHVsN0I3R0ZDcjJrU3JZcVlv?=
 =?utf-8?B?Z1VlMUw4QjNzaHk0Ykk0Y3VmUXhVaHVMOHJSbXcvcytESkl2MDVPTkZzNzZZ?=
 =?utf-8?B?YW1OU3I5aEQwRkR1bEh4RG5IOEtEVUJCcDVZUmZ1b0IxZnNEMG1qUkxZNHdM?=
 =?utf-8?Q?0MX8sNomMWMpACBdTKEi6rdZP?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29f659a5-1226-4f37-736d-08daf4b9397d
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2023 16:22:39.9964 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KLDjuPgZ820bXa66w4nrhsVdCQ3vbA6WsJpQb+UAHQ3mhZ2zYW/vqcKrJrb7D65gY/dW8Zo7ISMwXAiga4Q/ow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7129
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
Cc: Richard.Gong@amd.com, Roman.Li@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 1/11/23 16:52, Mario Limonciello wrote:
> On DCN314 when resuming from s0i3 an ASSERT is shown indicating that
> `VBIOSSMC_MSG_SetHardMinDcfclkByFreq` returned `VBIOSSMC_Result_Failed`.
> 
> This isn't a driver bug; it's a BIOS/configuration bug. To make this
> easier to triage, add an explicit warning when this issue happens.
> 
> This matches the behavior utilized for failures with
> `VBIOSSMC_MSG_TransferTableDram2Smu` configuration.
> 
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Harry

> ---
>  drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_smu.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_smu.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_smu.c
> index f47cfe6b42bd2..0765334f08259 100644
> --- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_smu.c
> +++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_smu.c
> @@ -146,6 +146,9 @@ static int dcn314_smu_send_msg_with_param(struct clk_mgr_internal *clk_mgr,
>  		if (msg_id == VBIOSSMC_MSG_TransferTableDram2Smu &&
>  		    param == TABLE_WATERMARKS)
>  			DC_LOG_WARNING("Watermarks table not configured properly by SMU");
> +		else if (msg_id == VBIOSSMC_MSG_SetHardMinDcfclkByFreq ||
> +			 msg_id == VBIOSSMC_MSG_SetMinDeepSleepDcfclk)
> +			DC_LOG_WARNING("DCFCLK_DPM is not enabled by BIOS");
>  		else
>  			ASSERT(0);
>  		REG_WRITE(MP1_SMN_C2PMSG_91, VBIOSSMC_Result_OK);

