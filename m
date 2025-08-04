Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91340C87FCF
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Aug 2025 12:13:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 34F7910E1E9;
	Mon,  4 Aug 2025 12:13:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="n3m9bAvx";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2077.outbound.protection.outlook.com [40.107.93.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2251F10E442
 for <amd-gfx@lists.freedesktop.org>; Mon,  4 Aug 2025 12:13:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f4k0RNT2ErnTvYIExWU4zrws/iFITWxGW0IAEzFeu5IKDztnkUZKmB5I8lgkEVqd3JhlBDTibmqZ2KLEjgo0bllzARODH7TgkPWmrgN+J3+H/iCxyD0DvRTP0NkCn26BeY78E6hEVIK2DAWFidnzgZQWCZmv4pCDfqi7RmwlAl83s1jfI0FNOxu2AqqswgNTtwJHeXTSxVKnZzU9MtpuOx1ZQSKV9gGiugw5hS1E7ydjRvEL75pbfsWAftRgHAljvfAaMC2oJ/5HJTkEkKX6o99VC3ebrTfgwz/XMc6GjeUJoT2lB8/OeBHA6o3t++HdphVpkpKiI6g4eNtccLO9fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iHu5PKEryxyMnapjYCY12R+JNHLcJE5uPz6YolEpVBM=;
 b=VPXgQ+vr6juUJ6lXD4PW4HtW/v1BsguO1bsSMxKvQzmkhhR5FndYjHcJojH52YzTBmQ7amZNtCXRt+/B/HO1UJsRZAhvVu2mFRolroyo7h8AP8kHJRp8/puUPD74kIg+aERWwQt1ytUb95W4BiaG5CoZJ/BGTxU3l2He+UYQleripkVMCXAAPFnhTOWHv1QVlQEq3K/gcY7+vNsvSD/q5w33K9CvCrYHnyWZ6XYQZUzBkKfWqhsQhAMOCfZ/j2dHzcDoHi6nGYxIAN6hNSJjBCUqMGmqMGQ69KolGvhClzG6pyLscmEvcev/4bde+AXElErve0MmGkcig5bIe8wqEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iHu5PKEryxyMnapjYCY12R+JNHLcJE5uPz6YolEpVBM=;
 b=n3m9bAvxpUc7FdozwC8oYG4a4wWCscor1OEUeR9JLesW/fsd1k9IVvmIYYlp1WutIcndgyw8n3mXr1uC69ZjAaQVc1u3FIa2r05wBFIQVK0a2+bVA6sSu2JtJgTFWGLsy4SDXhygzPRwSUQR8tjJXc0vdH2rgWkwnjdqNMnscGc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB7820.namprd12.prod.outlook.com (2603:10b6:510:268::8)
 by SN7PR12MB7024.namprd12.prod.outlook.com (2603:10b6:806:26e::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.20; Mon, 4 Aug
 2025 12:13:30 +0000
Received: from PH7PR12MB7820.namprd12.prod.outlook.com
 ([fe80::7606:59:8d0d:6d4c]) by PH7PR12MB7820.namprd12.prod.outlook.com
 ([fe80::7606:59:8d0d:6d4c%5]) with mapi id 15.20.8989.017; Mon, 4 Aug 2025
 12:13:30 +0000
Message-ID: <c54f1e07-6f8c-4357-9304-e7d62fbca55e@amd.com>
Date: Mon, 4 Aug 2025 17:43:23 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/6] drm/amd/pm: Add dpm interface for temp metrics
To: Asad Kamal <asad.kamal@amd.com>, amd-gfx@lists.freedesktop.org
Cc: hawking.zhang@amd.com, le.ma@amd.com, shiwu.zhang@amd.com,
 alexander.deucher@amd.com
References: <20250804110539.637463-1-asad.kamal@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20250804110539.637463-1-asad.kamal@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0228.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:eb::16) To PH7PR12MB7820.namprd12.prod.outlook.com
 (2603:10b6:510:268::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB7820:EE_|SN7PR12MB7024:EE_
X-MS-Office365-Filtering-Correlation-Id: 017b4b7d-23ad-4f31-6dbd-08ddd35052ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WnFQSXVYaVA3UXpqYXpPQkpvSDFCQ0tPbk9BRnpyNkpxV2tCd0Y0QlFWL0dt?=
 =?utf-8?B?ZFRoRkhYY2RJUFVrZ2t3Y3dUNEpBU3ZWRU85WmszejNYRStxMmRuRllkSWdF?=
 =?utf-8?B?dkgxTEJ4dlNOUFpPQitnV2xRaWkzem1ST2dicmZ3QmFsdlRGNUV6VzdYalJW?=
 =?utf-8?B?OWVxeFNSczB1dlN0c3VLSlZWL1UycUM1ZnFmUmk1MGU4R1BmMGZKZzdzZWM2?=
 =?utf-8?B?aDlSWHdxK0tCSGJSMG9oZHB0QzNrV3hmTkVySjZwV21RYWU1QTE5U3BlWmc3?=
 =?utf-8?B?RVFWQUVPc2xEYzM1c2VjeHNLMGtJZ2NkWEJHZWcyWnBRSE83ZDhmVUE2VExq?=
 =?utf-8?B?UEpjZ2o5eUg2Ymw3aWhSL1JpMzl6eVowQmhUWFlqK3FpUThnb0ZZT3lXWmdX?=
 =?utf-8?B?cUhSb2FUUWZGUUFPQXpzZTJKdUFueGUxTzdwbWZINWVlcXpKaHlMdVF4OEtl?=
 =?utf-8?B?czZRSW1JWlBKa2RCU2R4Z2htazdVaGlEQ1dNMGZrZzA1byt2MWJ6QnZ0MlJt?=
 =?utf-8?B?VzVYQnh5aCt5U1hlMzVUam1KcmE5YUkxRG5sUU1RVytFSGJ5ZnA3OHFlWURv?=
 =?utf-8?B?Z1RRU3c4OUl1L1lLVXY4NzBsakVwM013SU5GWWVYTjRSNlZzQmJvaFRYSjZM?=
 =?utf-8?B?Wnh4QWl6TjR1ZlVzZTZ4WHFmSkNrSEhtdXZGUnpoT2pweW5weFA5akF5Y3p2?=
 =?utf-8?B?NkhDU2NVUzBqZWRFRU9BbHNKZ25YMlZTR2IrdmhRd1QwN3FpdU1tQXhyNXY4?=
 =?utf-8?B?WEl2WkxjOTZHbHVnUHdlU1ZpZGRUcng5Um02OFNvemFNWS9iSklSVWM3REQ1?=
 =?utf-8?B?REZMK0xRZ0J6eVhTME9HZXcyckVSVG5PRC9xOUN1aXNHemw4dGpMZ1pMTVUy?=
 =?utf-8?B?a0hVYzgybURrdjg3RXdIOEtBbU1FaThoQkhkdHFMM1l2YUVQSlNLbzBic2lq?=
 =?utf-8?B?cm52NG9YSS8zM2MyNDZJR21vdjBFYS82ZVkyTWZzdmVMSWw2R2o4R1oxa21O?=
 =?utf-8?B?WTI4QVZkTGVxM0NzdWJ4SWQ5NkJQMGI1amorQW9CTDg2MldXL2ZFUWVKZHJt?=
 =?utf-8?B?V2VObGV4TU9LZ2lNNzF3OUpqZVBjSC9RdGJxcjlWcG9LaEZQeFNhUUZxc3dn?=
 =?utf-8?B?WnFYZGpTZC9Keks4b2MvRHdEQUw1WDZ2ak1sNjN6T3YyOEJOTElZTlg0dFVa?=
 =?utf-8?B?TWd0Q3BvQTcrbHc4WHBicXpLK2ZZMXdRTklIdWlFaklrNnI3djI2ZEtTMjhH?=
 =?utf-8?B?d1U1TUk0UXNaSmJVMFZ0UlR3M29VTmdSb1JncFdVZlUvdG9rcW50ZS9HUXNp?=
 =?utf-8?B?bFJreHdLaVBFMGVKdUtEb0xZZ0JZVkU5Q2UxNTFGcWlETzJ1Yi9lWWxVNGhE?=
 =?utf-8?B?bTU1UEJRQ2Q5Q1ZvL0h5WWk0NkZXa2lta3R6SmVpdlNBMkRtYjVwYVN2RlFW?=
 =?utf-8?B?Z282MFJ3OS9UMnF5bHlaWjhhT29vTGtNRWdNUkVpTDYyRE10dllWWW11OFBW?=
 =?utf-8?B?VnYxR1B2emxhTnc2R0RKZ2VCSldJNlh6Rm9mMjR2a2ZVTWpQaEk3dEl2bUR5?=
 =?utf-8?B?UWh5bjYyMUF5bUJpaU9WUVU3R2U2NVloc2tPQTNXV1J4cDFnVk1SZnJXb1li?=
 =?utf-8?B?ejNoWDJDZEg2T2pKTElWOE9DYnI3Q1IxTHF4OFdkT3M4TXFtakJES3ZKMHE3?=
 =?utf-8?B?eTdWYmo3c1hvWFlJMUdXSGZ2aVorRzk3WmFkT2k3U3pmK054K1crYkVJVlFX?=
 =?utf-8?B?QnRFcVprZTNnMjlOeG8zRVZWY2p4T2dsT0RCSVlsR0hHVjl0K0lvYVk5L01F?=
 =?utf-8?B?U3Z2WDR1WEdpQXhwWEVCY3Y2TTQ4OUhyZitPSklxV1dTaEdQcHlibTBUTVFi?=
 =?utf-8?B?Mmd0aVhncDhLM1VzcUh6djEzNFc1UkNiSUZSdDFLbFhzRlE9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB7820.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SG4rVkJyUFZJWW1EVzhGODV6RFNmM2EvYmx5VWZMTnNnZDVPUEJpU1B2cnV6?=
 =?utf-8?B?aXY4Q0VJNEI1WmZkdnN4RGh5N3ZETUNtY0R5NXlUUkVpQkVySTNSbEJJVVhv?=
 =?utf-8?B?T01NaXV4Tk9xVmtzdGV5WW54YmkrUkdUTjVNWDI4TDNGSUw5SVo5UG12NXVl?=
 =?utf-8?B?ZnBRVTJVOHJFM3B2dXpxZFVpazNhWnQva2l4YVNJeWV4ekdnWGVMOHNLeHZD?=
 =?utf-8?B?YktZRzZFdEhnRERTNWVHK2ptczdTb0M1SWJNc1JrNjQxRERCdXhUSHh1YVAz?=
 =?utf-8?B?NlJodTZKaDllMVQzajFOY1NFN2FQN3VydkV5R2p6Q2h5aGYvY3hGOXdyWjNS?=
 =?utf-8?B?TndvTFhWM1Q2VUE2NG9kaFc4NlFoU1REbG5aaXZ2dDM0VllnTjMyV0QxOHlp?=
 =?utf-8?B?TE1SZ1dUS3hSNmlZa1dHd0JUcUVkK05IUExQaU1kb1hrMkhoOGs4cmhiNzhK?=
 =?utf-8?B?RnJ6b1dIUGNYU0NGZGFDUUNXOGJvZFIvcllYb01kb1BEampRYWUzSWp2SkNN?=
 =?utf-8?B?cWliTy90b3BteHAzbStIMFBWQXNJR1FiWkJGQ3R2d085bW1YOFcyLzJPTmRQ?=
 =?utf-8?B?UnJKeit3MzFPMWZBNXR6QWxScEQ2aDI3WlFZdFFUS3NoQzREbkw1L2RhdEVl?=
 =?utf-8?B?dVNRYVFlNTN3TWxuQ0s4MDd3RW4yTDVDaHd0T0hnRGFveEhZRHFwQ2l6cnlC?=
 =?utf-8?B?Wmp2Y3lKRTJxMlRDUmR1V0lRTkR0eFNJMVI1OW1Ra1g3Ky9YM2h2bUtLQ2lM?=
 =?utf-8?B?Q0t6cEZLcVJTR3lWOFBhSGdxcHA4dDRxRm5qMmJHZGQ3WHI1YVkxY0wrV2lw?=
 =?utf-8?B?ZktaM05rYy9yWEk2MjhYdzNrOWpkUUtjc292NFliTVVZbWVZRk1VQkJydVNn?=
 =?utf-8?B?cCs3WUdSUHFpaUx2VnN6azlvcFA5dDJGc2NPekYzNWQxaDdsVnhiVm1mLzdy?=
 =?utf-8?B?cFRjR0VuT29kQVlwRFU0Q3ZBTEtkY2NPNHEyTEtBd2k4L0YwUHRPS0FLaWVu?=
 =?utf-8?B?S0RyTHI0bXVUM0FFN1I0T3c0VkFPNFZ1bHcxai9TUW96RXpYQUhsZTNVKzBS?=
 =?utf-8?B?S09EOFJKTGg5K2tHcGlyNXBJNWE5UEtSWDdSUjVOZkw5a003UHZ5QWJxbW05?=
 =?utf-8?B?VUNTS2VxV2w1S0N2YnEyb1FEY1lZR2M5aDNQU2ZnL0l1Skp5bE9SK3JVYmwx?=
 =?utf-8?B?RUlpNVV3RmtYK3I5TEtNV28rdDM2RzR2OW41bU11SmtEMmtyTWE0bVFFOXpN?=
 =?utf-8?B?emRDS3FLd3pLSFEzbUVUR1FIUGcxMlJSS1NXVUpndzhtY01kZWdodmxuamk0?=
 =?utf-8?B?bm5MU1VWYXptOG0yV01YRi9OdGdKU0p3ZFBONTFYWVhyNXFRZ1p2djUrNllC?=
 =?utf-8?B?aHZ1WURJQ1dDUHh5UUFFQUVvREwvUGI4Qkt6cXFqMUxjSHNTSVRrbnNtY0tn?=
 =?utf-8?B?U2oyMmg3aTlleXZOQ040MHI2Q0JTeklIcFpYczVLRzBHcS93TFNVaWN0Smhl?=
 =?utf-8?B?NE9sdmgrWTRNRWlvelEySDZpQ01DeDVmRHFEMFhuWlQzU0FqUjNSYUlyYjBa?=
 =?utf-8?B?S1RTZjk0QStzN1FRQU94YmdGK2VHZUh1MDlDSjJXeVBiMzBKbnBiKzlBNmF6?=
 =?utf-8?B?aldGQWpXVWd4clZlMnhIYjdXVE5oczJhWUM2UUZhS2EyTlZYdlExNnM3bU82?=
 =?utf-8?B?L0k3MVRndWNLbjR5dU1SZW9QMFRZWVNJRXRwK2lDZ2JrdWF5NW96ZEFlS05D?=
 =?utf-8?B?TXdHVkNJWEczV2p4ZndkNkMxZGVLSXREUDVxU0E3clZiZzV5NVEwOTVseEJX?=
 =?utf-8?B?T2FMbCtpa3hrWGs1cTlzdDRGU1kxekFxMDBHaDFCZmpwUHF6Sk9VUGN1RWJ3?=
 =?utf-8?B?MVh3YUJzNS82aTdhOXpmNWZnZjk4QU42dUZFNnNMclk2QmxPQTNZRzNyOCtv?=
 =?utf-8?B?YlgxY2tTR1UyRFRyZEQ3SzllZDNpQmZrdldNWnovdElNOGJUQUJvejVjU0lW?=
 =?utf-8?B?RUZ3aktSMnJ2aEVmeVlITnNFVTl2bXlHbkdaN2tTemRUSEJoQ1JOcDFMaWhZ?=
 =?utf-8?B?MVlxUWd4MWdvYWRVZmE5S1h3NzRyVkUyQkkzbThHdVlXY1JKdUM4SVVvaEhB?=
 =?utf-8?Q?Ob0Y1tpBtM2h0ZVWOpFtwFjyE?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 017b4b7d-23ad-4f31-6dbd-08ddd35052ad
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7820.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2025 12:13:29.9369 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p3skP8vJl4B4Z9Abvu10rMbF6fMTYxyC5Xyt2YZV8SBUqVhzVCLwBS+bxs8iOdnu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7024
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



On 8/4/2025 4:35 PM, Asad Kamal wrote:
> Add dpm interface to get gpuboard/baseboard temperature metrics
> 
> v2: Add temperature metrics support check(Lijo)
> 
> Signed-off-by: Asad Kamal <asad.kamal@amd.com>
> ---
>  .../gpu/drm/amd/include/kgd_pp_interface.h    | 81 +++++++++++++++++++
>  drivers/gpu/drm/amd/pm/amdgpu_dpm.c           | 60 ++++++++++++++
>  drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h       |  4 +
>  3 files changed, 145 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
> index e2b1ea7467b0..2f7e4b5bebf3 100644
> --- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
> +++ b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
> @@ -30,6 +30,12 @@ extern const struct amdgpu_ip_block_version smu_v12_0_ip_block;
>  extern const struct amdgpu_ip_block_version smu_v13_0_ip_block;
>  extern const struct amdgpu_ip_block_version smu_v14_0_ip_block;
>  
> +enum smu_temp_metric_type {
> +	SMU_TEMP_METRIC_BASEBOARD,
> +	SMU_TEMP_METRIC_GPUBOARD,
> +	SMU_TEMP_METRIC_MAX,
> +};
> +
>  enum smu_event_type {
>  	SMU_EVENT_RESET_COMPLETE = 0,
>  };
> @@ -496,6 +502,8 @@ struct amd_pm_funcs {
>  	int (*set_df_cstate)(void *handle, enum pp_df_cstate state);
>  	int (*set_xgmi_pstate)(void *handle, uint32_t pstate);
>  	ssize_t (*get_gpu_metrics)(void *handle, void **table);
> +	ssize_t (*get_temp_metrics)(void *handle, enum smu_temp_metric_type type, void *table);
> +	bool (*temp_metrics_is_supported)(void *handle, enum smu_temp_metric_type type);
>  	ssize_t (*get_xcp_metrics)(void *handle, int xcp_id, void *table);
>  	ssize_t (*get_pm_metrics)(void *handle, void *pmmetrics, size_t size);
>  	int (*set_watermarks_for_clock_ranges)(void *handle,
> @@ -1595,6 +1603,79 @@ struct amdgpu_pm_metrics {
>  	uint8_t data[];
>  };
>  
> +enum amdgpu_vr_temp {
> +	AMDGPU_VDDCR_VDD0_TEMP,
> +	AMDGPU_VDDCR_VDD1_TEMP,
> +	AMDGPU_VDDCR_VDD2_TEMP,
> +	AMDGPU_VDDCR_VDD3_TEMP,
> +	AMDGPU_VDDCR_SOC_A_TEMP,
> +	AMDGPU_VDDCR_SOC_C_TEMP,
> +	AMDGPU_VDDCR_SOCIO_A_TEMP,
> +	AMDGPU_VDDCR_SOCIO_C_TEMP,
> +	AMDGPU_VDD_085_HBM_TEMP,
> +	AMDGPU_VDDCR_11_HBM_B_TEMP,
> +	AMDGPU_VDDCR_11_HBM_D_TEMP,
> +	AMDGPU_VDD_USR_TEMP,
> +	AMDGPU_VDDIO_11_E32_TEMP,
> +	AMDGPU_VR_MAX_TEMP_ENTRIES,
> +};
> +
> +enum amdgpu_system_temp {
> +	AMDGPU_UBB_FPGA_TEMP,
> +	AMDGPU_UBB_FRONT_TEMP,
> +	AMDGPU_UBB_BACK_TEMP,
> +	AMDGPU_UBB_OAM7_TEMP,
> +	AMDGPU_UBB_IBC_TEMP,
> +	AMDGPU_UBB_UFPGA_TEMP,
> +	AMDGPU_UBB_OAM1_TEMP,
> +	AMDGPU_OAM_0_1_HSC_TEMP,
> +	AMDGPU_OAM_2_3_HSC_TEMP,
> +	AMDGPU_OAM_4_5_HSC_TEMP,
> +	AMDGPU_OAM_6_7_HSC_TEMP,
> +	AMDGPU_UBB_FPGA_0V72_VR_TEMP,
> +	AMDGPU_UBB_FPGA_3V3_VR_TEMP,
> +	AMDGPU_RETIMER_0_1_2_3_1V2_VR_TEMP,
> +	AMDGPU_RETIMER_4_5_6_7_1V2_VR_TEMP,
> +	AMDGPU_RETIMER_0_1_0V9_VR_TEMP,
> +	AMDGPU_RETIMER_4_5_0V9_VR_TEMP,
> +	AMDGPU_RETIMER_2_3_0V9_VR_TEMP,
> +	AMDGPU_RETIMER_6_7_0V9_VR_TEMP,
> +	AMDGPU_OAM_0_1_2_3_3V3_VR_TEMP,
> +	AMDGPU_OAM_4_5_6_7_3V3_VR_TEMP,
> +	AMDGPU_IBC_HSC_TEMP,
> +	AMDGPU_IBC_TEMP,
> +	AMDGPU_SYSTEM_MAX_TEMP_ENTRIES = 32,
> +};
> +
> +enum amdgpu_node_temp {
> +	AMDGPU_RETIMER_X_TEMP,
> +	AMDGPU_OAM_X_IBC_TEMP,
> +	AMDGPU_OAM_X_IBC_2_TEMP,
> +	AMDGPU_OAM_X_VDD18_VR_TEMP,
> +	AMDGPU_OAM_X_04_HBM_B_VR_TEMP,
> +	AMDGPU_OAM_X_04_HBM_D_VR_TEMP,
> +	AMDGPU_NODE_MAX_TEMP_ENTRIES = 12,
> +};
> +
> +struct amdgpu_gpuboard_temp_metrics_v1_0 {
> +	struct metrics_table_header common_header;
> +	uint16_t label_version;
> +	uint16_t node_id;
> +	uint64_t accumulation_counter;
> +	/* Encoded temperature in Celcius, 24:31 is sensor id 0:23 is temp value */
> +	uint32_t node_temp[AMDGPU_NODE_MAX_TEMP_ENTRIES];
> +	uint32_t vr_temp[AMDGPU_VR_MAX_TEMP_ENTRIES];
> +};
> +
> +struct amdgpu_baseboard_temp_metrics_v1_0 {
> +	struct metrics_table_header common_header;
> +	uint16_t label_version;
> +	uint16_t node_id;
> +	uint64_t accumulation_counter;
> +	/* Encoded temperature in Celcius, 24:31 is sensor id 0:23 is temp value */
> +	uint32_t system_temp[AMDGPU_SYSTEM_MAX_TEMP_ENTRIES];
> +};
> +
>  struct amdgpu_partition_metrics_v1_0 {
>  	struct metrics_table_header common_header;
>  	/* Current clocks (Mhz) */
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> index 71d986dd7a6e..a5e97582d853 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> @@ -2037,6 +2037,66 @@ int amdgpu_dpm_get_dpm_clock_table(struct amdgpu_device *adev,
>  	return ret;
>  }
>  
> +/**
> + * amdgpu_dpm_get_temp_metrics - Retrieve metrics for a specific compute
> + * partition
> + * @adev: Pointer to the device.
> + * @type: Identifier for the temperature type metrics to be fetched.
> + * @table: Pointer to a buffer where the metrics will be stored. If NULL, the
> + * function returns the size of the metrics structure.
> + *
> + * This function retrieves metrics for a specific temperature type, If the
> + * table parameter is NULL, the function returns the size of the metrics
> + * structure without populating it.
> + *
> + * Return: Size of the metrics structure on success, or a negative error code on failure.
> + */
> +ssize_t amdgpu_dpm_get_temp_metrics(struct amdgpu_device *adev,
> +				    enum smu_temp_metric_type type, void *table)
> +{
> +	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
> +	int ret = 0;

This init can be avoided.
> +
> +	if (!pp_funcs->get_temp_metrics ||
> +	    !amdgpu_dpm_is_temp_metrics_supported(adev, type))
> +		return 0;

Better to return error code when not supported.

Thanks,
Lijo

> +
> +	mutex_lock(&adev->pm.mutex);
> +	ret = pp_funcs->get_temp_metrics(adev->powerplay.pp_handle, type, table);
> +	mutex_unlock(&adev->pm.mutex);
> +
> +	return ret;
> +}
> +
> +/**
> + * amdgpu_dpm_is_temp_metrics_supported - Return if specific temperature metrics support
> + * is available
> + * @adev: Pointer to the device.
> + * @type: Identifier for the temperature type metrics to be fetched.
> + *
> + * This function returns metrics if specific temperature metrics type is supported or not.
> + *
> + * Return: True in case of metrics type supported else false.
> + */
> +bool amdgpu_dpm_is_temp_metrics_supported(struct amdgpu_device *adev,
> +					  enum smu_temp_metric_type type)
> +{
> +	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
> +	bool support_temp_metrics = false;
> +
> +	if (!pp_funcs->temp_metrics_is_supported)
> +		return support_temp_metrics;
> +
> +	if (is_support_sw_smu(adev)) {
> +		mutex_lock(&adev->pm.mutex);
> +		support_temp_metrics =
> +			pp_funcs->temp_metrics_is_supported(adev->powerplay.pp_handle, type);
> +		mutex_unlock(&adev->pm.mutex);
> +	}
> +
> +	return support_temp_metrics;
> +}
> +
>  /**
>   * amdgpu_dpm_get_xcp_metrics - Retrieve metrics for a specific compute
>   * partition
> diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
> index 768317ee1486..09962db988d6 100644
> --- a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
> +++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
> @@ -526,6 +526,8 @@ int amdgpu_dpm_set_power_profile_mode(struct amdgpu_device *adev,
>  int amdgpu_dpm_get_gpu_metrics(struct amdgpu_device *adev, void **table);
>  ssize_t amdgpu_dpm_get_xcp_metrics(struct amdgpu_device *adev, int xcp_id,
>  				   void *table);
> +ssize_t amdgpu_dpm_get_temp_metrics(struct amdgpu_device *adev,
> +				    enum smu_temp_metric_type type, void *table);
>  
>  /**
>   * @get_pm_metrics: Get one snapshot of power management metrics from PMFW. The
> @@ -613,5 +615,7 @@ ssize_t amdgpu_dpm_get_pm_policy_info(struct amdgpu_device *adev,
>  int amdgpu_dpm_reset_sdma(struct amdgpu_device *adev, uint32_t inst_mask);
>  bool amdgpu_dpm_reset_sdma_is_supported(struct amdgpu_device *adev);
>  int amdgpu_dpm_reset_vcn(struct amdgpu_device *adev, uint32_t inst_mask);
> +bool amdgpu_dpm_is_temp_metrics_supported(struct amdgpu_device *adev,
> +					  enum smu_temp_metric_type type);
>  
>  #endif

