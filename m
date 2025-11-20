Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56501CF8553
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Nov 2025 08:15:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CAEDE10E2E4;
	Thu, 20 Nov 2025 08:15:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="q0luSfpy";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012021.outbound.protection.outlook.com [52.101.43.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 11B1610E70E
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Nov 2025 08:15:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bJyCqKD87GX/w3LUyNlvFNzdhDqO/J3a0VFeh8Akf1J+dG0aSEN3Ip1HKvbQbXPa/dCKFS3CDjb9ecCSYKeUehPjd2CnYCagXbJ1fqmh3crue25HgFGWRLz7PkYE1aRhZ/6DFa5woFpztqUDzuqXGIyE8l4D83q06I52X9g5xIoSxAdK9Jvho2DIEQ1i05qcM/yC/4Sf3+WDK1nUhWXbFiVsNDz86q9/4XyUB1Rc4U/k0sNxPAeuGmX/2sPJ6WlNuRhQJ8H/P12qlNwGEUD6W3uomVW7EcDyFhcq7UZReEVb81caAWxIiSbGK1pq0ZUQA0XfUFdA7P0vC7mOS7dxtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DnRichth74HTjXvVWDfn0VuyWtTzETP/WcMe4wg5Lpw=;
 b=ht7BCRBH6oq2jXtR73NGub8gvcAKuWJp5lKGU8dfw1Yayk6d/yV80NaONH4C7lwpTbJ6aSZjGOV12paGjRNWksliws8KJeMIO/GHGgRP8UGz2iS2/zgLnqZRw7LZHcRlYblrfcAi1xtkZ9Ql9mpMhL7h64F2vh05BFHo3wy11PlP1+BFhMUC7rEcUHcxzQa8pOFZzLIrpI2V6AQKMiWjU801jW9eU/T+bsmTt8dDK+ZR4Bf/xW5kqtwBMAj4l9yeoqExJf7p8lD1ptPJ1uwtDWpZErkzLnoTGM6/PkR7ZmV069YOG++y3ij71z1ZKhpAtma59RvmG1+JxbS1OOWQsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DnRichth74HTjXvVWDfn0VuyWtTzETP/WcMe4wg5Lpw=;
 b=q0luSfpyQ3QbzOxEWnnAQclNRJXYFkXOLO67KkcrGnl80LRo/c/9bU+Iw697e1neDEC3GaHyp6ayqzJaC/AxetNtO89KsExIo79nNepD6U1EREnlUSZW9/qVo5TYm/iNbmUXkI8w3FAYGLy3xgh/J6Nh6X6Rcwz6TgN33iFL8eU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by MW4PR12MB7264.namprd12.prod.outlook.com (2603:10b6:303:22e::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Thu, 20 Nov
 2025 08:15:15 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::d759:a62b:f8ba:461d]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::d759:a62b:f8ba:461d%4]) with mapi id 15.20.9343.009; Thu, 20 Nov 2025
 08:15:15 +0000
Message-ID: <c32727d1-2234-413f-b550-6a3c5f0ba019@amd.com>
Date: Thu, 20 Nov 2025 13:45:09 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/pm: adjust the visibility of pp_table sysfs node
To: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Zhang, Hawking" <Hawking.Zhang@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>
References: <20251030011651.1433120-1-kevinyang.wang@amd.com>
 <DM4PR12MB6012F6F0A577D1D47A950B9082D4A@DM4PR12MB6012.namprd12.prod.outlook.com>
 <2775ac42-de6d-40c8-ac72-5e3070529d3e@amd.com>
 <PH7PR12MB5997D81F138BDA8E645326CE82D4A@PH7PR12MB5997.namprd12.prod.outlook.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <PH7PR12MB5997D81F138BDA8E645326CE82D4A@PH7PR12MB5997.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4P287CA0008.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:26a::9) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|MW4PR12MB7264:EE_
X-MS-Office365-Filtering-Correlation-Id: 180a1d2f-30a0-44c3-0ac9-08de280ceef3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dzdhQ3ZNMWhkb1d4TE9BTk10MUZvNHNkTWkyckxGM1ZoaW1YUlV4bHJvZjUv?=
 =?utf-8?B?K2d0Szk1cEdSSnVrYnY4UTNuVXhFaC9PWFpRdjZEYlYvYlRwZUVNM0tXWWRT?=
 =?utf-8?B?cTJIK0wzblUvbEtDN21QbTJVTVlTNzB5dldZcTM2Sk1TangvTTVOQ24vdmZT?=
 =?utf-8?B?SXpnWjU2NUhlNkFKTTFOWW5icURDektRNCsva2FITzZHRXhFaytnd0ZENllp?=
 =?utf-8?B?Rk15SVJDSTFMbFhQbGlXOFB1dE8wRG5TbTE4ZEswaktNblZWbEF2U1M1T2Uv?=
 =?utf-8?B?RmpNV2pDRS9KNHZQV1R3QlNieE13OXRXckI2YmhRaEdsUm5HWGpzTWFpOGsr?=
 =?utf-8?B?dkZ4OUQ1c1F5RVh5dDlNSmpZdy9mTTR2M2k4NmJYMUlHMmNveDRTdiswT1or?=
 =?utf-8?B?NjBydDFRQnFYUkJ1RmRmRUx2eldKeXQ1NzFzVkVNZDdFVk5scWJnZTRmeUEx?=
 =?utf-8?B?MnJmcEs5SVpvR1J4NW94UDE4N0gwUGZmdkZHeGQ1VjQyZ012cWs0aDV1L1V3?=
 =?utf-8?B?Y1kwR1E3d1pIUTYwcEZhUTk5MnNFUVl0UkdIS0JJZFIyd1NieWFpa2hXcDBl?=
 =?utf-8?B?V0hveGNlRjFXZ00yRkFIQWNEVmZkbHdIQ1dYa212YjRhb283WTFsM1NuTzlB?=
 =?utf-8?B?dkVPQXFyUmdBTjVCdzJhVHdUVUN1R21SU0cycGptWEVaK1RGaDNFQ2JGMFdn?=
 =?utf-8?B?d2JqMms2SWxUeUV2M2E5RE53Uzl5K3p1aTdLNldSSDdKbkRDcjMxbUc1ZG9Y?=
 =?utf-8?B?U1JzUjE4VjZVUDZMNDFDRXgrSHo5WXRFUEpMdUlUeEpLTm00RDJuREw0V3ZH?=
 =?utf-8?B?MUYvUk85VDZhcmUwOGlXUElnWEtVUmlHMWJxakk1MmV1eTVpZ2c3aElaY0t6?=
 =?utf-8?B?bU5nb3Z5blVnbnlRQUd6RG1rdERER2o2Z2lQZ1FpbjBxNVBnSUh4dy9VUWRm?=
 =?utf-8?B?Sy9FdlFXaVd3OHV5cEpBMkF0NlVkZ0pUdTFLS2grZm5kWWx6QnFPdldpanlp?=
 =?utf-8?B?N2V3ZEUzYmRrd0EzcG1SdFVZTGNtZUxLSkdxOHREdjRLMHlQdEl6YW92ZzNR?=
 =?utf-8?B?RS9NaHFabEZ0UDRuWElrTEIvYVR3NXoxbWE3Q3hEcDBzb3N3OG1PeGRITmF3?=
 =?utf-8?B?NkxEOE5qZDlZa0ZVQ0tHSjd1RmJiNC81WDZqdmFOWENyZ01qYTk0Y1BCbFZN?=
 =?utf-8?B?YUtDWVo1ckZYZ0lVaGFPSVpCNkxGUzkrN013TXFjYjdhRE00d1cvbjd6eVNI?=
 =?utf-8?B?L1I0d2E5dlpCS1lRZ1J1aHhVUlNRS0ZQRUhWREVBMWF2MXBoREVSYk1sMEZ1?=
 =?utf-8?B?YzRhYzZjQ0lBZkZiU2RTSE9TVHlxR2tVUDdiR0x6NlFwcm5QL0ZRL0U0U29V?=
 =?utf-8?B?WWR2UHY3cHNLRS9iYzU5VFdpWUJJN29UYkFZYzl4TXVQc3EyUkw4U0U1eUF2?=
 =?utf-8?B?N1lhQWdpWmIxdEJTeWdrSzJEd01ZcERlamhWeUNsVFM1OFNVM29seEFSNmxk?=
 =?utf-8?B?bmozbCtNZnJzbUNIUkRJSFh0SGlnTHc1UEhVSXJ1MjM5MXl6MWp1S1ltclNl?=
 =?utf-8?B?ejJpOFRYMDlFMVl3RGUzYk0rd2lFRnBtY3dEZDlYVmRkRURaVGpnWHVxODJV?=
 =?utf-8?B?VFN3YTA3MTM5eHRzLzNzMlJ2NWVVOHpzeHNxOUJhNzh0OUVVd2puejR4NnpE?=
 =?utf-8?B?OHQ1SjdhbEUzcmVQck1nb2NxQ0pXb2N4SDZ5NkV5TDM4SEx2d3pCdlpuMDdC?=
 =?utf-8?B?ZTFZUmtaZUFUWmVGOEQ4U09reTNXTTRJRVJOcjhiOTVJaHNneTlGaEJCTW9Q?=
 =?utf-8?B?S053Ymh1RGV6cFF6SCttTkZvS3dRYlltVVNwRFZSSXVsa1Z1R0VHT1Y4c1dW?=
 =?utf-8?B?QjJDSVBWOTltT0pCV0N5ZGtQMDNhekRDdFIwVkt6Uk5xM21GWWZYemgxNzUv?=
 =?utf-8?Q?qIZxYErDk9H9h0Em6XNHrSk+CUEDGVCS?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eWxqbGFTc0dZNDNNdGF2SkFZNEI4RHVyZkIzQkV5SnFFaGJtNitoTkI0c01C?=
 =?utf-8?B?TitlQldqS1NXUyt1d0JMSyt5MURmUDlKaGhWZ0IwUlR6b1dxN0dmcll3RmFy?=
 =?utf-8?B?bVpVVGxBYjh3TUFOZFA4U01JamVLM1lHTmpQZkMraVZwdCt2T1ZLaEpQSytN?=
 =?utf-8?B?dm9oQWo0d0JobEtsZjU5ZjNhVDJvcWtZMS8vSHh1YSs5K1NodHI3QjljMlFJ?=
 =?utf-8?B?ck9ISTFyQ0lnSG5qcktsOVJndWpJbVhYN1JDRUVpcFd1Q1B2Y2NzYjIzSkUr?=
 =?utf-8?B?d1RObUk3ZVUxRko3b25XZ2lsT3JYL1NYb0xabTlWSk1Xc1FlY1grRmw3VCs2?=
 =?utf-8?B?R2ljajdKcGErNFkxMkF3dkoyYXhjZmE4WFcwSFZMWTErTHRLRkVYamZuS0du?=
 =?utf-8?B?b0dNK0czUlRVMks2ajZ3NUNIQXhJY1NVZ3lLeFdWODA2NVV4NmhlNmg1WDhE?=
 =?utf-8?B?QVJJYVdRNDFyQ2RGbWZXSXRhNmRXaldObllsMk90eVpqakFrY29mZ1RpUGpS?=
 =?utf-8?B?Rkd0QzJzV3BMNzlqN1JEVnUzSnRhZkNmQ2tjNW1HVmpDcHorOUJCZE03WDN4?=
 =?utf-8?B?Mm1zSGw2c2ZrRG1UQjl2ejcveXU1TEZqaHBhT0FQMWlKUGxLNzBpVG54QUJ0?=
 =?utf-8?B?VmVFZHlwU21Gc3Yycmp6Q0Y3a1IvdlV3ZGxNa2VHMlJwVW96ODIvdWFGZG5l?=
 =?utf-8?B?eWpxbnlHdGRBU2o3TUpHOXIrK1Y4cSt5N0pGZHZjbU5RYUxxdFh4TkgzR20w?=
 =?utf-8?B?RU5iMVBOZUlCSEs0SktGYlpneWNoUHNpZTZ3emMwOGZmN3hBS2Y3UGpBNE85?=
 =?utf-8?B?SGhCSVY5SWYxWVh0MWpvTkd2blhFM2s0YTJua0haT2h4RG1ycWVPMnBiUlZI?=
 =?utf-8?B?NVNZKzBiaWQvT1BBTmJLVzNLZ1NTOFBZaVA5TjV3d05wZUt5TXF5TFEzRGRm?=
 =?utf-8?B?ZzR1VjJaZkR5MkZXd1o1b1NCaEppbzZZUStVU3M3UkZoa09rZkZGZUxjL1ZW?=
 =?utf-8?B?NWhDRjEySldubFVtbzRQcHJ4VWVha0FUdHlmeE1CdmU0akNoYno1R0VHSUVy?=
 =?utf-8?B?Q1d0Y01WN052NFA2NzkwdHBXTkUyWGZnUE03RURWSUIwVE40OFdubEdhNVo3?=
 =?utf-8?B?cTVqQ0tHZVNLRms4S0YxdW1QWHI2SVZIeDBMRGpzYUlGRU84UUpNVG1Uc0g5?=
 =?utf-8?B?TkNYUUNRTjJLTDlqOFRkM1JBZTVZVzdMc2owSWo2Nnd6RDA2TmQxSVJ5cEZR?=
 =?utf-8?B?cU9yTEtuOUIzVHBsbkJMR2lCQ3JkeXVnNUUrejRBM0RxQ2hhR0NmcFcyN2I0?=
 =?utf-8?B?aVQ3SUVNRzNTZC9JVFh5RjlXYis4VkZnc2pSNm5paSszOHFzOTJCMXI5U2tz?=
 =?utf-8?B?L2xJcHlTb0VYVjhpWGVhRHpNQTRPWEJqQlFLdDMyYlBmdkcrQWpOTEMxcEUr?=
 =?utf-8?B?b1FZa1JZdjFSTVdld3dnY0FxWWxRbU11blVzUUx0VldQZmFBNzlXcGtaRUR1?=
 =?utf-8?B?dENML3E2dnpNZFJ0dEtablF2MENFUnJod2RDUDJINHJoeExGSURaZVkxTURF?=
 =?utf-8?B?ZWtFVXlJRm1tTG1WVktaZ2hjVGVqdnlFZUdUZ2VHOHVCWFRFalU1b1MrNXdM?=
 =?utf-8?B?L1NqU3M3d2NkMUIvb090Z09TaWVSbmlzS01uK1prRXpsbTVmb3ZTMm9GemV4?=
 =?utf-8?B?dDRNM1dWMllCYXdic0J0NTBjb3k2S2NHdm5KTDlRQzB3aWh2VmR3VHB5Z3lo?=
 =?utf-8?B?ei94ajZ4aTBtL05idUpxdFREdDlPaUZncTMxRXdqck84NzBXQkZEMkRsZGtH?=
 =?utf-8?B?UitrSmlsMERINWw5YjYvS3RIK1YyVTZ2RGNtSFFjSnE2VmZab0tIWEJDbk9u?=
 =?utf-8?B?QndCUzBIRE9EUUtrQmkySGR4VldPbm1OOENuNmtxT2ZuRHk5NElnWDNna1V3?=
 =?utf-8?B?OVJsUjFHUmplaUx1aTVOKzU5VURFMXlSQnk1T3pDRElONHNXN09ZUy9pK1pW?=
 =?utf-8?B?NVhReDN6QXhvY3YxQ05DZ1pYZUg0UVZYSlVNcDhUVlRTeTRmR1dJOEtjOG8x?=
 =?utf-8?B?SzN4TFdvUTFFaXJaNGtqQk0vdW4xZ3lmSHdzWHpwN0NlLzZ1Z0tTSHRzTHNz?=
 =?utf-8?Q?PTcnZl8Ffc6sa+XgoVRb3xglO?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 180a1d2f-30a0-44c3-0ac9-08de280ceef3
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2025 08:15:15.0788 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qjNjjAglLJGTi8W15Ro+TP5ReJkqnJ9gAHu7k2sV7jEoOI5FKCBBwYb/ruje0w9m
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7264
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



On 11/20/2025 1:37 PM, Wang, Yang(Kevin) wrote:
> [AMD Official Use Only - AMD Internal Distribution Only]
> 
> -----Original Message-----
> From: Lazar, Lijo <Lijo.Lazar@amd.com>
> Sent: Thursday, November 20, 2025 15:41
> To: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>
> Subject: Re: [PATCH] drm/amd/pm: adjust the visibility of pp_table sysfs node
> 
> 
> 
> On 11/20/2025 12:11 PM, Wang, Yang(Kevin) wrote:
>> [AMD Official Use Only - AMD Internal Distribution Only]
>>
>> Ping...
>>
>> Best Regards,
>> Kevin
>>
>> -----Original Message-----
>> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Yang Wang
>> Sent: Thursday, October 30, 2025 09:17
>> To: amd-gfx@lists.freedesktop.org
>> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>
>> Subject: [PATCH] drm/amd/pm: adjust the visibility of pp_table sysfs node
>>
>> - make pp_table invisible on VF mode (only valid on BM)
>> - make pp_table invisible on Mi* chips (Not supported)
>> - make pp_table invisible if scpm feature is enabled.
>>
>> Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
>> ---
>>    drivers/gpu/drm/amd/pm/amdgpu_pm.c | 17 ++++++++++++++++-
>>    1 file changed, 16 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/vvvvvdrm/amd/pm/amdgpu_pm.c
>> index c83d69994380..3a14e0ff38ae 100644
>> --- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
>> +++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
>> @@ -2507,7 +2507,7 @@ static struct amdgpu_device_attr amdgpu_device_attrs[] = {
>>           AMDGPU_DEVICE_ATTR_RO(pp_num_states,                            ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
>>           AMDGPU_DEVICE_ATTR_RO(pp_cur_state,                             ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
>>           AMDGPU_DEVICE_ATTR_RW(pp_force_state,                           ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
>> -       AMDGPU_DEVICE_ATTR_RW(pp_table,                                 ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
>> +       AMDGPU_DEVICE_ATTR_RW(pp_table,                                 ATTR_FLAG_BASIC),
>>           AMDGPU_DEVICE_ATTR_RW(pp_dpm_sclk,                              ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF,
>>                                 .attr_update = pp_dpm_clk_default_attr_update),
>>           AMDGPU_DEVICE_ATTR_RW(pp_dpm_mclk,                              ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF,
>> @@ -2639,6 +2639,21 @@ static int default_attr_update(struct amdgpu_device *adev, struct amdgpu_device_
>>                   if (amdgpu_dpm_get_apu_thermal_limit(adev, &limit) ==
>>                       -EOPNOTSUPP)
>>                           *states = ATTR_STATE_UNSUPPORTED;
>> +       } else if (DEVICE_ATTR_IS(pp_table)) {
>> +               switch (gc_ver) {
>> +               case IP_VERSION(9, 4, 3):
>> +               case IP_VERSION(9, 4, 4):
>> +               case IP_VERSION(9, 5, 0):
>> +                       /* No PPTable support on Mi* chips */
>> +                       *states = ATTR_STATE_UNSUPPORTED;
>> +                       break;
>> +               default:
>> +                       if (adev->scpm_enabled)
>> +                               *states = ATTR_STATE_UNSUPPORTED;
>> +                       else
>> +                               *states = ATTR_STATE_SUPPORTED;
>> +                       break;
>> +               }
> 
> What about using a dummy check with amdgpu_dpm_get_pp_table(adev, NULL)?
> 
> Thanks,
> Lijo
> 
> [kevin]:
> 
> The linux amdgpu sysfs node provides both get and set capabilities. Therefore, relying solely on the get function for speculative analysis may not be sufficiently rigorous.
> Additionally, modifications must be implemented concurrently for the backends of both Powerplay and SWSMU.
> this is purely a software logic-related adjustment and does not require low-level operations.
> 

This has nothing to do with sysfs. It's all about querying whether 
pptable is supported or not. If it can be done with the least 
maintenance that is better, otherwise need to keep adding checks with 
each IP version.

Thanks,
Lijo

> Best Regards,
> Kevin
> 
>>           }
>>
>>           switch (gc_ver) {
>> --
>> 2.34.1
>>
> 

