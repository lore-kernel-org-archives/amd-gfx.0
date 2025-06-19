Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E587C7115A
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Jun 2025 02:30:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EA70510E911;
	Thu, 19 Jun 2025 02:30:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DXqSkMwb";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2088.outbound.protection.outlook.com [40.107.102.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F0C7610E911
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Jun 2025 02:30:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EcW2xx5KSO+UL44V8rqjghrq/MacbDFA0qD1hfRLH3/vp7+ymDBQ402HcsOUnCH7bqWCdXOAT11jR95BpgNiiO3J+rliE2O4mLqsgmgWEG/cvHVRG3Aw6eUD+CZAD629DdScz7ExFGHbdDsryjhK6R8uWLd7syFqqw8a1EqNbPaDWp2wRYHZuIrOZFXE/JQUpPWBx4nC0twcLcmX0WqSB+ZvAfxXCM0gpzJNTiap02JeJRmLbTyyiWSX7asSdyRJeTi0YWEJ6z/ixTkzuQq2+B8Fv0ZPs6G9/TpvQ3UV1r/q0I4DIDqsrHscWJBLLuXFKVCp/10qVe2M13Sew2117g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=obctOLNB3bjt1mtiYNe+MsLoOAeirepAK38Wyu6nuxI=;
 b=xbX7kKhUOPVH2lJdjPrZf3sPp2XK2IJdI93bm/JSG42s520ZuH45TRSAR6fXHKgX7BQVXyhE84PWglkRYjyYmTMQGTyGmrvC/p0iRpFXKsb30p20FwlI3NqrIUMp7xPAwh0pxnuwjkyFFEyWrChBebFOdkOffWa+mXvZTX+Yl/NbLYHERHukOAziZNanMCn31lZDMwj0mTPA1Eg1UExw+3avdS/bLKj1YNPiY+HIu6g0uH3K+oM5ebCy7ch5LWFR3SSyzWf76bGAyZN9MWyMzE+fddTKcpkyrskEj0Prn8dXKw3vf/itTz+OOWEUNLQ8PryzsLNri46/jAhJ+yh5HQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=obctOLNB3bjt1mtiYNe+MsLoOAeirepAK38Wyu6nuxI=;
 b=DXqSkMwbvHUYNTxTISLHq0Rcz1k9BamA1KrlKPzYouYDIG8On3Ru23RCLoT5ISXWuEohtvA5cT5k84V8aFdQ1b/iVSrLjDKQgb/w/GZVEWkMP1HuWQK51DiYwwMrluDM1VlJanZWgFj/sLFImqAa1qkhviYAxqqorsvkuiy+Yuc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5136.namprd12.prod.outlook.com (2603:10b6:5:393::23)
 by DM4PR12MB6159.namprd12.prod.outlook.com (2603:10b6:8:a8::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.28; Thu, 19 Jun 2025 02:30:05 +0000
Received: from DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::bc87:6c1b:cadb:67a]) by DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::bc87:6c1b:cadb:67a%6]) with mapi id 15.20.8857.020; Thu, 19 Jun 2025
 02:30:04 +0000
Message-ID: <fac75e5e-2d2f-9dc9-6321-24f7a838a76b@amd.com>
Date: Thu, 19 Jun 2025 10:30:00 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 2/4] drm/amd/pm: Add support to set min ISP clocks
Content-Language: en-US
To: Pratap Nirujogi <pratap.nirujogi@amd.com>, amd-gfx@lists.freedesktop.org, 
 mlimonci@amd.com, lijo.lazar@amd.com, alexander.deucher@amd.com,
 christian.koenig@amd.com
Cc: benjamin.chan@amd.com, bin.du@amd.com, gjorgji.rosikopulos@amd.com,
 king.li@amd.com, dantony@amd.com, Phil.Jawich@amd.com
References: <20250618221923.3944751-1-pratap.nirujogi@amd.com>
 <20250618221923.3944751-3-pratap.nirujogi@amd.com>
From: Xiaojian Du <xiaojian.du@amd.com>
In-Reply-To: <20250618221923.3944751-3-pratap.nirujogi@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0054.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::13) To DM4PR12MB5136.namprd12.prod.outlook.com
 (2603:10b6:5:393::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5136:EE_|DM4PR12MB6159:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b03f278-572f-4d8c-2f13-08ddaed932c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eVRLUXZ5bDZ2YTY1Tk1qcDNmR3dzVXcyL1VWOVREbC9NTDFnZHFGa1JyTDdT?=
 =?utf-8?B?YTRsYXJZaFFFcEhPRlhuYzRBYjZLc3Y0SmE1clh1T2h1b1NlZVRCNkV1czNO?=
 =?utf-8?B?ZkJJQTB3bEFJa29oQXgyVWFDZklweUdzYzNzL0wveTczbTJ1U28yNy8zOHl2?=
 =?utf-8?B?WGVHQUc2aHl3WThWOW16OHpGUWtaV0YySDluK2l4bWNwSW9PZmwybWFOcWJw?=
 =?utf-8?B?WTkxM0lWVlFRcGtnZzRTZVRLSFplQUxrOXFlMHhja2Ewd1hzUndKOEJIUEJo?=
 =?utf-8?B?anAxdXordWhSbElzQ2p6bE0zZEF5SUN2bzhST2p4THMxUTBoNHcvblNMNGdJ?=
 =?utf-8?B?d0NWL1B5bERSV3EvL0FLaXMyZnR3OHErOS8zaW1LbU1CMExTRFdHQXlCQ2tK?=
 =?utf-8?B?cUZmSnZHSUZya3FuSGwrK1l3Y0s0anJXRzRpa1JGd2RRMEwwSTN6RGZNSDFQ?=
 =?utf-8?B?cklnajd4emNhemNhckwzK3BweFd5UEVPRloxNk1Gd1M5YVIvMnNvMUYyR2cr?=
 =?utf-8?B?c3dDa3VYU2lRTjl1alJDVHdiZFJtOWZ0V2Ria25qUEJMMm8vbWZvQ0pMNDg4?=
 =?utf-8?B?RHQrZ3NHWmRsVWVQNVV2MHd5b0VDcUlLV2Q1dXZZNVpmUUlKT2I0Q1JqRW1N?=
 =?utf-8?B?Q3JraFZsMkRSMHNaOU1EeFFrakR3bnlqVldLRURLUUk5Sit3QVpyZXpWMnBP?=
 =?utf-8?B?RmdEZTB6TTRFQjNCTXZHZ05Ja1ZuZmtWM2lIem1MRWEvcmgwQWMxMHJVZDhU?=
 =?utf-8?B?eDNOZklneE81MlVxTmhOUko2UjZNVzJLeGRSR1hRL3FRY0FvY28wYVhJNm9H?=
 =?utf-8?B?QXEzZVVxa2FRMUFRS3JRK2k2WjIxZVhObGlseHo2YkYyQWVSc09adDZHMzhJ?=
 =?utf-8?B?dnIwYUxoSkh3dzhWclNIOUZyb1JDOFN5TGU2RGJWbFg1dGlvbjNDZlJSL3dB?=
 =?utf-8?B?L1AvWEtuRnBQUnk1aXVBQWxaUlZINVNvLzB3T3U4SGhyYSsvWXdVZ0FjSFlI?=
 =?utf-8?B?WHRPVW82MGxVRGdPQ1YrbEpFV0xaU3RDS2tEYnJZUHpjZjVEeVRXS2ZpRTl4?=
 =?utf-8?B?TllIZkp0S05LcEJzNEdGVk5UOTBqV3RSbUF2ekZFeFlISDd0a0hxRHc0MW9H?=
 =?utf-8?B?NXMxeWJKQ2M3bkN3YXRNaGZpU0R6LzVJT0xnOEVVMmtJSVJEMzVmMk9PZVcy?=
 =?utf-8?B?V1p1d0hGdzNycWhTcXRjSnorZlZPMzJHKzYxL3hsdzZMSzRPczBHdHp3aElz?=
 =?utf-8?B?MWxsdlJvNzlSUEZlc1drU21xeDRDMjJEZlpkQytOckFuNUtCWGNJbXh0OFpH?=
 =?utf-8?B?YUpQSlNXWTNFcVZ4YmhuaUFFdnhydnFCaVlMaUs0c3dhUlc1V3ZvcXg3L3li?=
 =?utf-8?B?ajFOM2paQ0pHYmN6bmg5cnZQLzE4N2JRYWZGemIvNXdJZXFYaW9CTmlNR0Qw?=
 =?utf-8?B?dG5wR1RldTRReG1CTmY3TldpTFN1TkRCNURzVVhaUVExU1VFeDlwRlpQMVVJ?=
 =?utf-8?B?b2UxU0p1VWl6RWRuc2d6TTZBSEsrbGlPY3hPb29lSjNyMWNJNlNIaEtJUTJ6?=
 =?utf-8?B?TDMvdW1QY3pCSEF2REFxQzMzb3RtV29QSklCcXdMY1B0WHFoU2RuNDFrb3NW?=
 =?utf-8?B?N2g5Und1ZzRoZHMwaUZzaGtJMDVQQ05LMWFMdjZPTWlGaUtrUGV6ZlZiVVMv?=
 =?utf-8?B?MUQ1aUZxRmgxZkxEaGhJcjhlMVo3Vy9kU0tINTc4UE1BeHpibFpOeUluWXpZ?=
 =?utf-8?B?YThZSThlc3lKWG9jd3ZDdUhVWVNUeVlwYktLS0d1Y2Y3UVdlNzZDYU9PQ3Na?=
 =?utf-8?B?VEZUQ1FSb2RrL3l0NGIxTDRadDBNTkZPalBDRHY5d3dYMHVzMnp4cTNraGVq?=
 =?utf-8?B?cFF3SjF6YWdURkEwQXJvVEZ3RkJndnVOcks0d2ZJdUdnSGVuWWplZ2tsV3hH?=
 =?utf-8?Q?tBTc9+ODAx0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5136.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YmFwdVlST1VYRGYyQUE0MWVqcDBkZFhkaHZGV1hyMFlTSXcxQWk1a01VcFBN?=
 =?utf-8?B?SzJNV01xRWZ5K1BZTWw2S0gxSEtJU2RHZmQxajJBUkJmVXFlMEw4cFcxSlVl?=
 =?utf-8?B?UmZndVVFN3YybzlNVXF4NnV3VnZhTkJ1OGVQRnY3VU4zUno1djZ1bkl2V2Z3?=
 =?utf-8?B?RkxFYVhBTTVNbWE5eFFqQmljWS9IRS9SU09lRWpIRkt4U0hZVDhKRXFZTmZ5?=
 =?utf-8?B?eTlPVFNCN0UxRFpVOThDU2NaZUtpR29wQWhVcU1UeFY2RDk5YmYzTVV4N0pn?=
 =?utf-8?B?cXQ4d2hZTnhiZCt0anFvY2ZzR0twU2lNaDRiOTgyUkQ3WmgxUlc0cjFoQ2xO?=
 =?utf-8?B?KzUyYzF4bFZHNTVLekJyTDlEUHpoOVlmZ1c4a0JQVGFWcDI2UmJvK3BZVGhl?=
 =?utf-8?B?M2VzWlBvSHhFS0JPQWszaHBFSm5vdk1wRktqQW9zQXdYYmt0VXhmMnRlUmgw?=
 =?utf-8?B?anZvY0NqWXFqSERZR1hqOGw4a3FJQnZIWExsNDI5aVdmRVlhZGV0NlBLZ1BE?=
 =?utf-8?B?dWdpc1BCdkQxdVZ0MjhLb3lxMGxURE42VUdEN0ZEQkhiOXBSTUR5RFBsTi9D?=
 =?utf-8?B?QmlpRGxFbHdpelpMbnprSzlNcG14WWZVNldxMHZNOVduTnkxVVJFKzZBcWNu?=
 =?utf-8?B?NVNwVzA4QkNrQ1BXMmVnRUlQVUJuWnFXMDAwSTF3eVZWTjlaR3VGQ09GVTFp?=
 =?utf-8?B?b3FYVUVCZjZCNVpQc2NIU2tDeFpCNHF2SDc2ME9ZM0d4bWNXMlRYU0EzY0kr?=
 =?utf-8?B?UE1GMTlRRGhTWVhLMTJUbGZnZVFNUTV4ZEI1T283VFhGc3JIUFVkS2xubGEr?=
 =?utf-8?B?UkNTMkhkUmU2MGo4Rm4vVERQQmFBRVdtSUVEdUtHQVpReEI5VGxaZXM3MDVC?=
 =?utf-8?B?ZlBSeGFldDNyV0MyVityTmtHUVYwck4vT1Erd1NrZkRIWlBnTDVOc25ZRUJR?=
 =?utf-8?B?QTYrcWpic25yV2JUYmdvc2JhODhKeVFUZVhHNTRZNjVVSytNUE00YTdUN2ty?=
 =?utf-8?B?OGVIL09uUk5uWUlYMmRPbGpSVnhWR3ZURFhab1orblhteS9tblRkNFNzdE9X?=
 =?utf-8?B?RVhxQlNMMGV6b21FbjNzZ0x6RjlwSFlDdnUrejhUTlBpT0dqZGdGMmpJNjdI?=
 =?utf-8?B?S2ZKNVpwaTJTK2xTSjZCRzhUeU90eWNlRmFXMTArd2pLMzRadWFCdmQybHMw?=
 =?utf-8?B?dE8vMWJCREUxSjI0M0JiN3lwZHYvZkFMeWQ2cGtZSWVlVWVldHVrZVRja1Vu?=
 =?utf-8?B?ZjI2Ykwvcmh1TUJMYVFtc1JZRzAxZDdta3lEbEQzZElTU1VjQkgxV2U2MzlV?=
 =?utf-8?B?endwbU9ielFramlaTUZFZTFrUEV2UTZEbEpOMDdYeGtGaytDQmN5RGkyZ2or?=
 =?utf-8?B?Z2ZvVUIrdHFGcnI0N1BmV2hwZ3VxYUVDVzFWWTJ2aFBKaTkvb2FwQWFMUjZJ?=
 =?utf-8?B?WHdlcXN4RERmd0VlYVBkNTM3MmFGWExmb3BBK1FhUS9iM3hlbENzTFhZRjNH?=
 =?utf-8?B?VzQvMGZMUzRiZkFIRm04WkhJWWpKVi9BVDJKaytoQ2M5R0JoenYwSkw3dnBh?=
 =?utf-8?B?NDFCYldKTUd6ekJjU3Zpb2RyeW1OU1ZCdzNCMEQ2MTJ0dHV3OTRWOHA3Qkpp?=
 =?utf-8?B?LzlwM0w1OUpXTGRYRU5qSnJ0NjRTR3ZFNnhoQTFVZkh2Wk1mTjJVNkw3ZlEw?=
 =?utf-8?B?Q1ZHcGdISnBvUUx6MUlVaDg2SGJQNldTeUNPb0c1N0EwWFdYU212N3Y2SUFH?=
 =?utf-8?B?NHJTdWxnV3RFOHdoaFRLZ0gxNmVhVzNlY0xQWDFCd0N5UjFaSURXVHl1U3l4?=
 =?utf-8?B?Zk9peE1KbWswamFqZnYrQS8xY2lvemVkL29aV0V3S3Fmc0Zzalh6aXBOS1g0?=
 =?utf-8?B?S0FPb0dwTHRKd3lPVGJydEYza2t0Q1pUL1djcXJLc21TbFdFSEZ0b1NDVWRR?=
 =?utf-8?B?aFBsaEhISzM4ZWpMM3kyeGxJSHErbm9VYmtwVTUycE1aNTREWUVJYzNBODlZ?=
 =?utf-8?B?bk0rV0J3STJldUlzbVcwR0JneUhpVC8vNFo1ejNwNVRZTE00NWJWMlJqOVg3?=
 =?utf-8?B?RzhuZ09QQ1FOQ1JoK3hFUWpCa21yWlRCQjk4aG1WTGdRSDI2V3c3ckgrV1hU?=
 =?utf-8?Q?a2HyFbzWowiOJYyNeVK5GiFHn?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b03f278-572f-4d8c-2f13-08ddaed932c3
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5136.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2025 02:30:04.4548 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mXa4Ks2ZLAFSFn6gHmvMsTieAywv2zoZxzqwQwBgjTbft2T/n/it5OZLRpels6Xml7HEmLV0y71ATgNwzaQM9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6159
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

Reviewed-by: Xiaojian Du <xiaojian.du@amd.com>


Thanks,
Xiaojian

On 6/19/2025 6:17 AM, Pratap Nirujogi wrote:
> Add support to set ISP clocks for SMU v14.0.0. ISP driver
> uses amdgpu_dpm_set_soft_freq_range() API to set clocks via
> SMU interface than communicating with PMFW directly.
>
> amdgpu_dpm_set_soft_freq_range() is updated to take in any
> pp_clock_type than limiting to support only PP_SCLK to allow
> ISP and other driver modules to set the min/max clocks. Any
> clock specific restrictions are expected to be taken care in
> SOC specific SMU implementations instead of generic amdgpu_dpm
> and amdgpu_smu interfaces.
>
> Signed-off-by: Pratap Nirujogi <pratap.nirujogi@amd.com>
> ---
>   .../gpu/drm/amd/include/kgd_pp_interface.h    |  2 +
>   drivers/gpu/drm/amd/pm/amdgpu_dpm.c           | 14 ++---
>   drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 14 ++++-
>   drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  2 +-
>   drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h  |  2 +
>   .../drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c  | 51 ++++++++++++-------
>   6 files changed, 56 insertions(+), 29 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
> index f4d914dc731f..e2b1ea7467b0 100644
> --- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
> +++ b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
> @@ -108,6 +108,8 @@ enum pp_clock_type {
>   	PP_VCLK1,
>   	PP_DCLK,
>   	PP_DCLK1,
> +	PP_ISPICLK,
> +	PP_ISPXCLK,
>   	OD_SCLK,
>   	OD_MCLK,
>   	OD_VDDC_CURVE,
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> index 95f1fff442cb..71d986dd7a6e 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> @@ -853,22 +853,16 @@ int amdgpu_dpm_set_soft_freq_range(struct amdgpu_device *adev,
>   				   uint32_t max)
>   {
>   	struct smu_context *smu = adev->powerplay.pp_handle;
> -	int ret = 0;
> -
> -	if (type != PP_SCLK)
> -		return -EINVAL;
>   
>   	if (!is_support_sw_smu(adev))
>   		return -EOPNOTSUPP;
>   
> -	mutex_lock(&adev->pm.mutex);
> -	ret = smu_set_soft_freq_range(smu,
> -				      SMU_SCLK,
> +	guard(mutex)(&adev->pm.mutex);
> +
> +	return smu_set_soft_freq_range(smu,
> +				      type,
>   				      min,
>   				      max);
> -	mutex_unlock(&adev->pm.mutex);
> -
> -	return ret;
>   }
>   
>   int amdgpu_dpm_write_watermarks_table(struct amdgpu_device *adev)
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> index 97572fe26ddf..756afe78a6e5 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> @@ -76,6 +76,7 @@ static void smu_power_profile_mode_get(struct smu_context *smu,
>   				       enum PP_SMC_POWER_PROFILE profile_mode);
>   static void smu_power_profile_mode_put(struct smu_context *smu,
>   				       enum PP_SMC_POWER_PROFILE profile_mode);
> +static enum smu_clk_type smu_convert_to_smuclk(enum pp_clock_type type);
>   
>   static int smu_sys_get_pp_feature_mask(void *handle,
>   				       char *buf)
> @@ -134,12 +135,17 @@ int smu_get_status_gfxoff(struct smu_context *smu, uint32_t *value)
>   }
>   
>   int smu_set_soft_freq_range(struct smu_context *smu,
> -			    enum smu_clk_type clk_type,
> +			    enum pp_clock_type type,
>   			    uint32_t min,
>   			    uint32_t max)
>   {
> +	enum smu_clk_type clk_type;
>   	int ret = 0;
>   
> +	clk_type = smu_convert_to_smuclk(type);
> +	if (clk_type == SMU_CLK_COUNT)
> +		return -EINVAL;
> +
>   	if (smu->ppt_funcs->set_soft_freq_limited_range)
>   		ret = smu->ppt_funcs->set_soft_freq_limited_range(smu,
>   								  clk_type,
> @@ -2980,6 +2986,12 @@ static enum smu_clk_type smu_convert_to_smuclk(enum pp_clock_type type)
>   		clk_type = SMU_DCLK; break;
>   	case PP_DCLK1:
>   		clk_type = SMU_DCLK1; break;
> +	case PP_ISPICLK:
> +		clk_type = SMU_ISPICLK;
> +		break;
> +	case PP_ISPXCLK:
> +		clk_type = SMU_ISPXCLK;
> +		break;
>   	case OD_SCLK:
>   		clk_type = SMU_OD_SCLK; break;
>   	case OD_MCLK:
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> index 41d4a7f93660..b52e194397e2 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> @@ -1642,7 +1642,7 @@ int smu_write_watermarks_table(struct smu_context *smu);
>   int smu_get_dpm_freq_range(struct smu_context *smu, enum smu_clk_type clk_type,
>   			   uint32_t *min, uint32_t *max);
>   
> -int smu_set_soft_freq_range(struct smu_context *smu, enum smu_clk_type clk_type,
> +int smu_set_soft_freq_range(struct smu_context *smu, enum pp_clock_type clk_type,
>   			    uint32_t min, uint32_t max);
>   
>   int smu_set_gfx_power_up_by_imu(struct smu_context *smu);
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
> index eefdaa0b5df6..d7a9e41820fa 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
> @@ -305,6 +305,8 @@ enum smu_clk_type {
>   	SMU_MCLK,
>   	SMU_PCIE,
>   	SMU_LCLK,
> +	SMU_ISPICLK,
> +	SMU_ISPXCLK,
>   	SMU_OD_CCLK,
>   	SMU_OD_SCLK,
>   	SMU_OD_MCLK,
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
> index fe4735d5ebd4..fe00c84b1cc6 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
> @@ -1207,11 +1207,13 @@ static int smu_v14_0_0_print_clk_levels(struct smu_context *smu,
>   
>   static int smu_v14_0_0_set_soft_freq_limited_range(struct smu_context *smu,
>   						   enum smu_clk_type clk_type,
> -						   uint32_t min,
> -						   uint32_t max)
> +						   u32 min,
> +						   u32 max,
> +						   bool __always_unused automatic)
>   {
> -	enum smu_message_type msg_set_min, msg_set_max;
> -	int ret = 0;
> +	enum smu_message_type msg_set_min = SMU_MSG_MAX_COUNT;
> +	enum smu_message_type msg_set_max = SMU_MSG_MAX_COUNT;
> +	int ret = -EINVAL;
>   
>   	if (!smu_v14_0_0_clk_dpm_is_enabled(smu, clk_type))
>   		return -EINVAL;
> @@ -1240,16 +1242,23 @@ static int smu_v14_0_0_set_soft_freq_limited_range(struct smu_context *smu,
>   		msg_set_min = SMU_MSG_SetHardMinVcn1;
>   		msg_set_max = SMU_MSG_SetSoftMaxVcn1;
>   		break;
> +	case SMU_ISPICLK:
> +		msg_set_min = SMU_MSG_SetHardMinIspiclkByFreq;
> +		break;
> +	case SMU_ISPXCLK:
> +		msg_set_min = SMU_MSG_SetHardMinIspxclkByFreq;
> +		break;
>   	default:
>   		return -EINVAL;
>   	}
>   
> -	ret = smu_cmn_send_smc_msg_with_param(smu, msg_set_min, min, NULL);
> -	if (ret)
> -		return ret;
> +	if (min && msg_set_min != SMU_MSG_MAX_COUNT)
> +		ret = smu_cmn_send_smc_msg_with_param(smu, msg_set_min, min, NULL);
> +
> +	if (max && msg_set_max != SMU_MSG_MAX_COUNT)
> +		ret = smu_cmn_send_smc_msg_with_param(smu, msg_set_max, max, NULL);
>   
> -	return smu_cmn_send_smc_msg_with_param(smu, msg_set_max,
> -					       max, NULL);
> +	return ret;
>   }
>   
>   static int smu_v14_0_0_force_clk_levels(struct smu_context *smu,
> @@ -1278,7 +1287,7 @@ static int smu_v14_0_0_force_clk_levels(struct smu_context *smu,
>   		if (ret)
>   			break;
>   
> -		ret = smu_v14_0_0_set_soft_freq_limited_range(smu, clk_type, min_freq, max_freq);
> +		ret = smu_v14_0_0_set_soft_freq_limited_range(smu, clk_type, min_freq, max_freq, false);
>   		break;
>   	default:
>   		ret = -EINVAL;
> @@ -1426,7 +1435,8 @@ static int smu_v14_0_common_set_performance_level(struct smu_context *smu,
>   		ret = smu_v14_0_0_set_soft_freq_limited_range(smu,
>   							      SMU_SCLK,
>   							      sclk_min,
> -							      sclk_max);
> +							      sclk_max,
> +							      false);
>   		if (ret)
>   			return ret;
>   
> @@ -1438,7 +1448,8 @@ static int smu_v14_0_common_set_performance_level(struct smu_context *smu,
>   		ret = smu_v14_0_0_set_soft_freq_limited_range(smu,
>   							      SMU_FCLK,
>   							      fclk_min,
> -							      fclk_max);
> +							      fclk_max,
> +							      false);
>   		if (ret)
>   			return ret;
>   	}
> @@ -1447,7 +1458,8 @@ static int smu_v14_0_common_set_performance_level(struct smu_context *smu,
>   		ret = smu_v14_0_0_set_soft_freq_limited_range(smu,
>   							      SMU_SOCCLK,
>   							      socclk_min,
> -							      socclk_max);
> +							      socclk_max,
> +							      false);
>   		if (ret)
>   			return ret;
>   	}
> @@ -1456,7 +1468,8 @@ static int smu_v14_0_common_set_performance_level(struct smu_context *smu,
>   		ret = smu_v14_0_0_set_soft_freq_limited_range(smu,
>   							      SMU_VCLK,
>   							      vclk_min,
> -							      vclk_max);
> +							      vclk_max,
> +							      false);
>   		if (ret)
>   			return ret;
>   	}
> @@ -1465,7 +1478,8 @@ static int smu_v14_0_common_set_performance_level(struct smu_context *smu,
>   		ret = smu_v14_0_0_set_soft_freq_limited_range(smu,
>   							      SMU_VCLK1,
>   							      vclk1_min,
> -							      vclk1_max);
> +							      vclk1_max,
> +							      false);
>   		if (ret)
>   			return ret;
>   	}
> @@ -1474,7 +1488,8 @@ static int smu_v14_0_common_set_performance_level(struct smu_context *smu,
>   		ret = smu_v14_0_0_set_soft_freq_limited_range(smu,
>   							      SMU_DCLK,
>   							      dclk_min,
> -							      dclk_max);
> +							      dclk_max,
> +							      false);
>   		if (ret)
>   			return ret;
>   	}
> @@ -1483,7 +1498,8 @@ static int smu_v14_0_common_set_performance_level(struct smu_context *smu,
>   		ret = smu_v14_0_0_set_soft_freq_limited_range(smu,
>   							      SMU_DCLK1,
>   							      dclk1_min,
> -							      dclk1_max);
> +							      dclk1_max,
> +							      false);
>   		if (ret)
>   			return ret;
>   	}
> @@ -1670,6 +1686,7 @@ static const struct pptable_funcs smu_v14_0_0_ppt_funcs = {
>   	.gfx_off_control = smu_v14_0_gfx_off_control,
>   	.mode2_reset = smu_v14_0_0_mode2_reset,
>   	.get_dpm_ultimate_freq = smu_v14_0_common_get_dpm_ultimate_freq,
> +	.set_soft_freq_limited_range = smu_v14_0_0_set_soft_freq_limited_range,
>   	.od_edit_dpm_table = smu_v14_0_od_edit_dpm_table,
>   	.print_clk_levels = smu_v14_0_0_print_clk_levels,
>   	.force_clk_levels = smu_v14_0_0_force_clk_levels,
