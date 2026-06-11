Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9FC0CD98D2
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Jun 2026 12:00:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6C64810E1C1;
	Thu, 11 Jun 2026 12:00:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="oMAveuhc";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010018.outbound.protection.outlook.com [52.101.85.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7B9A510E1C1
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Jun 2026 12:00:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JHXIHRz5o1FBNSRTk7GRU8qP/OGQIfBU55vHtS4zy3yKmfHpPIEY8mQqZD028aDWiZofoR3K3ZhwLOjyWRHJEWzOZTv3ZZlKZwCNe0owwsK0iUb4kzJJ00hFOX7TfYlxX43hWGrDKQpIDDO6UYC9YKkWZ46U643X5JuNfX7BT2vc6NcMysPCCSjwPelsgwL8q6EcMNveC2kHKOafWdrvhX8x7bf57UFgjkWEH2sLCdyQd6rZqlQ21uXK0hrkQkD7X77fmGmWVay7UY/aLyVwq3to2SDHhmGeNLGlg+ya6KRuRHUt4l6nuFgHBo4GM43rz4/SqEh2CGY42pYrLLfBJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IiOGo92FXOnmLkWfrlz6lgVaXfsj4ZFWhK/UGSH4+2A=;
 b=lXiwt4WJgeZBSrav8AfNweT+P0KUkJ9XW6YnjUcmPQlZOz73HZ0slGztoKjZE23h+TdQ7Bj8yFYZXgg/oIMm/AFtIDr6A9c/TFRwMMvxpAGmoOgXib1sZjS/yrdTPxY28wk35DMQ1qvwm4iUaoOvIRbmlmA7ygCV23dAnt2qH7Eh0gocB0wUkOwUHztFIRmO5nkGj4zvDI5RVzQbzNXOl5WaVuO5RvJNDplRcHFzcPa+LZcnwdzrqFaU+tgmuoH409LCPuKSBBr0GjhPPMpAUg+xpupe4JFHdtitwVNrs7gUa/DzfPQnSKQkBou5sUovDCjmyvEG5uNMhxUZgeH/Gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IiOGo92FXOnmLkWfrlz6lgVaXfsj4ZFWhK/UGSH4+2A=;
 b=oMAveuhcwTfPsGE2DtY2YgxIARilBwzy6Ao4ydMIo3F2d7SczItPnYkdxFU4bLFjg4kr6sv762vlqGJfeVIVn0a94r5EB6jasVc99Z48RSX21hvSbUjRkbC1Ia1T5ELLw8DH1egvDP8pvbEshhNKNmxrcUCBwZpdlCbYfU8mlnQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by PH8PR12MB6891.namprd12.prod.outlook.com (2603:10b6:510:1cb::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.18; Thu, 11 Jun
 2026 12:00:16 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%3]) with mapi id 15.21.0092.011; Thu, 11 Jun 2026
 12:00:16 +0000
Message-ID: <9932ba6d-6d2e-49b4-a019-c3da3950e8f5@amd.com>
Date: Thu, 11 Jun 2026 17:30:08 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/4] drm/amd/pm: smu_v14_0_0: add DCLK metric handler
 via VCLK fall-through
To: Priya Hosur <Priya.Hosur@amd.com>, amd-gfx@lists.freedesktop.org,
 Alexander.Deucher@amd.com, Christian.Koenig@amd.com,
 Mario.Limonciello@amd.com, Kenneth.Feng@amd.com
Cc: Pratik.Vishwakarma@amd.com, Veerabadhran.Gopalakrishnan@amd.com
References: <20260611113628.3217-1-Priya.Hosur@amd.com>
 <20260611113628.3217-2-Priya.Hosur@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20260611113628.3217-2-Priya.Hosur@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4PR01CA0020.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:26e::6) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|PH8PR12MB6891:EE_
X-MS-Office365-Filtering-Correlation-Id: c2f297fc-e4ba-4b4e-c65c-08dec7b1001a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|56012099006|11063799006|4143699003|5023799004|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: sqv9rGGq5hKalSOxES1ia7QbTHYqsYGuO8nECV5heRHwbapaP/vNbmKvzjbIYR/yV+QjoGxl7you8NMEC4g/WLyWVdCWcIffqRThvnm7RUhr0RcNcAFcSbZh82XRg92PpmRayi5LLB9KTKO+0h5iiIZSuAAaUqTWM0Wk7SxjnCfGdTPgOa14lqlOZtxDt0iiZmHqJgkvp4FGRbdHSpEMrLBf8fjxdidU/2rYrtfDniZ+/vQCWQORFnDUyOqncRwfdfE8GndpkS6HxoOzzdlH76zpSB13vZGym7f33U9ZkA3CeE4/Vjs6VuiqWGqx6CRcHfg8TtLP4rbvsngjUt83Bb7W0pA8yM55vApYt6xztN537aLW1y9L0RggYrzwjwkbblEXQhFnbUN9h/g++q+bhpoYY46OFB0nISn4k/xD9tcb4x1PaTpILNW2SSZtTjAMQo8yB8UBBLP5ngs/ryAHsRnZmYSlMOpYKfrA6khWv0wjhe6YBex2inCN5W1BVoSZZYOeLGdxzVWaHAB0pcax9L38h/9LcpZZi8+nMRL+Khxq2QWq8o47K0cvqM3QsnmLktTqJ0YMEzcIFU1U74VSAyiC+RjQHMoM6/zNOQhmIRGfbdITlQXzCwiHnIwTYeSzeBSQ0CUgwxgEn+Ro0QU4bN73JMB2jjzqrxF1hzgqdmgu8FIkm4/j3LQZmyZTJiur
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(56012099006)(11063799006)(4143699003)(5023799004)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VysxM20vUHRWaVd4N29ETmhKMldVS1UzcDlQNWJ1TkJXT2dTcWdlSTkySnRS?=
 =?utf-8?B?NGhWMXg3WjIvY2wyVE5OWkdBNzUydWRoNHNtc0ZjSm9CeFBwdVBEZkxnQmZu?=
 =?utf-8?B?ZHhVMmpITjc5UkxFelNHdnl0NkQrNHNXS2kyM21ydktkOHdiTE5DNm8zMEcx?=
 =?utf-8?B?c0RpZjhYekRxZXNJZkU1WEl6M3hYOEhPZS93QjdlUit2OVRxWjBsVnIxTXM0?=
 =?utf-8?B?ME53ZldnZml2Z0JpOUp3MFVUR1U0KzlEVlFvalo4eVdqMzZKd0M5YTFyS0No?=
 =?utf-8?B?bHk5c2thY2t0ekdHeTNPM0hIa0tBMFlOUGJLYytBdXZ4SmhIbGt5dldFZzFz?=
 =?utf-8?B?TTN5U0xmRENWVkhZRWxTeXB0RVlxcFNrSDRIalFoWVZaUlRRTi9lL3plUmZE?=
 =?utf-8?B?cUhpZDZTVFZ0UnErNnkyYUdrQ3BXVFp3Z3BPQUQvYkUramk3VnRRZ3k0dVVR?=
 =?utf-8?B?RlQ2YmZhaDNUQXBTVVhBc090Um9PbWlQT3hVb2tmM0VZZXg2WHRuMWNNL1RH?=
 =?utf-8?B?eitGUURFN2JRMG1pY29xa3YzNXFhK2tJeTg5anZRWVVrMEV5QWlYSEZydUk0?=
 =?utf-8?B?QW50d1lGVklWRitkYmFhVkhGMlNsbnBOTW5DYU5CZTBIMjZmSXFTNThQN04x?=
 =?utf-8?B?WVA4WXZvU0lhaGVWdG9EL25penp1MURWRFovUjd1SlhIelFXaWoyOVN0UHhD?=
 =?utf-8?B?UDk2dmtsZTBNajZqZDl2SU01MEExRkVOREhydnB2eFE4LzEyRjB4TW1CQmFw?=
 =?utf-8?B?eHh4aVQyc00rMEM3RDJJR3AvNFhkanZGakZFSnNzT0JKbUpOcUNSWmxpdEd0?=
 =?utf-8?B?RnE2Z202Mm42THBmVmZpRjczcUxIVCt0c1VEVHB6bVg4NlJnTmhMNnEvM0JR?=
 =?utf-8?B?SnBYK2RpbzlXRUYrbEN3Z29JakNsM08wVW1hSERJMlVkZGRkNWpGM29yQW9h?=
 =?utf-8?B?VGUyNVEvWTlWT3g4N2F2U1hrZkcvWHZSa2RVNXJjUzErb0RPcTdKbk5FL0VH?=
 =?utf-8?B?bXpPT3VsU0hKY0xRSDVsM000OUhJSG1lbWNoRk5tWUlEUlBJanh4RTRQcnpH?=
 =?utf-8?B?ZDJSN0hFek5FK3pyb0FPbFRYTjNuQ2NpNXNFNXdtTmpqcEF2QlF1bmVqSlh2?=
 =?utf-8?B?eTMyeXVvN1FxMG5OY0o2TmxRQytPM2tEdkdyNDhRdWswK1FKWXl4ZkJLUmpJ?=
 =?utf-8?B?MjE1ZnRGS0VrYWJxdkN3Ym16aUEwMW5TYUhiaHg5Qi84OFFsQjhUb3BzMVdR?=
 =?utf-8?B?Q1BCenNCWmJGeW9jTGc2ZEhmUHBEZnBzd0ROSUIyc1BTVHBJL0dlekx3ZmQr?=
 =?utf-8?B?NmRvWjB2VDFhYWhWbnM1UXpyVTRrNlBkQko1WEpzd2tXQ21FWm94OFFVV0hE?=
 =?utf-8?B?c0JDZDZicEtOaWZiMEpMQzdQc0x4OFJCUUp4dXJ5UjV4SlJPUVAvREJYbXdZ?=
 =?utf-8?B?Rml3bzJITDAzSVFZSFFGdGJEaHllc1lnSzFoaWRSa0M0dHBjMllFbXBpRDhu?=
 =?utf-8?B?azh5MzVIOFAvbnZEV2E4YWt0aW5BUEpzK2tvcmJoMzV3TXdtTnVxVUZZTm5G?=
 =?utf-8?B?TGdjL2RjbWhTZzlMdXB6QUVMYytxOU9QMXpKYWNYOHY4endlWWl3MDNmQmFD?=
 =?utf-8?B?dmJTVTd3R0E1UUYwY3djQncvZHptaXI0VzlPMWc2OGZBd2lhYUc4ZU42cG9O?=
 =?utf-8?B?M2tYZTFpZVlQQmZPZUpWQWRPa1RueE5WVEFlUGp2T200c3VPSGIwb2owVlRJ?=
 =?utf-8?B?NEpTNk9FSnBGdWFGdUVHbWY3ZUVpR0xjVm5hcFR3V2l1R252d1F1MkczMWtU?=
 =?utf-8?B?MHVXc0xRTkRUWTFQQ25vVjhxZjdPWGtXU0RMRnpLM3k4YU13dnZqVDYraHE1?=
 =?utf-8?B?aHNwZDVrd1ZpQmVkL004YmVQd3JKaGJ3a1pHMkVQeURNSWMwWUdIbC84R2VV?=
 =?utf-8?B?QmZFUmgwZGtBc3N4QWpQMktKRTZJY3pqWFowUVVESm8rMTFMTXl2NkdHWEc1?=
 =?utf-8?B?R0wyZ08rUURPclVSMnoyZmUyallEMWMxbUc3bTVKaU9xd3hkS1dqbkJlTDF2?=
 =?utf-8?B?WEFZc1RyOGw3bmVmMUZsWVU3QmxUaG85eW9KWlJvWWVhUkpsWjVlcS9Nb3kv?=
 =?utf-8?B?WHZrWTBtcG1xQzh6YnRucmNKR3VPa2NDV3gxUnhTZkg3YmVQaFBzLzh6Q3Rn?=
 =?utf-8?B?eDNudmhPcGpyRFFuNElpWE8rQ01BV1Zrb3M5VXpCa2lmSHJ0RzZldDhuOU04?=
 =?utf-8?B?MGxLNGYyVjBMOGFiYmlpTE5pMTNmOXl6c3ZQMklvdXdEc2JkblE5RjdOQUJM?=
 =?utf-8?B?SDdqdzJrSU9NVmhXUjVPOUJIM09xeFF0UklndHlodWx3bEJucWhHUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2f297fc-e4ba-4b4e-c65c-08dec7b1001a
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 12:00:16.3232 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u/8bnZR9LOThDt7WHmnzdGCm3LtZ+U5RagQvT/r1mTyZOCsoxyYDzkHogMQq46x+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6891
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



On 11-Jun-26 5:06 PM, Priya Hosur wrote:
> Merge METRICS_AVERAGE_VCLK and METRICS_AVERAGE_DCLK into a single
> fall-through case mapping both to VclkFrequency. DCLK and VCLK have
> separate DPM clock tables but SmuMetrics_t has no DclkFrequency field,
> so report VclkFrequency for both.

Just to confirm - if you are seeing different DPM tables for DCLK/VCLK, 
this shouldn't be done. If they simply follow the DPM levels, then you 
could match the level for VCLK and report the frequency at the same 
level for DCLK. Otherwise, ask for a proper update from FW team.

Thanks,
Lijo

> 
> Signed-off-by: Priya Hosur <Priya.Hosur@amd.com>
> ---
>   drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c | 9 ++++++---
>   1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
> index 2fe006de927a..eeb508336349 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
> @@ -281,10 +281,13 @@ static int smu_v14_0_0_get_smu_metrics_data(struct smu_context *smu,
>   		*value = metrics->SocclkFrequency;
>   		break;
>   	case METRICS_AVERAGE_VCLK:
> -		*value = metrics->VclkFrequency;
> -		break;
>   	case METRICS_AVERAGE_DCLK:
> -		*value = 0;
> +		/*
> +		 * DCLK and VCLK have separate DPM clock tables but
> +		 * SmuMetrics_t has no DclkFrequency field; report
> +		 * VclkFrequency for both.
> +		 */
> +		*value = metrics->VclkFrequency;
>   		break;
>   	case METRICS_AVERAGE_UCLK:
>   		*value = metrics->MemclkFrequency;

