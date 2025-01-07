Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5868E77198
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Jan 2025 16:45:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 464A410E740;
	Tue,  7 Jan 2025 16:45:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="sJrM46Cm";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2060.outbound.protection.outlook.com [40.107.236.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C972A10E740
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Jan 2025 16:45:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yi9/joFNW3ab3Toc5CZ63QF4fxQv83FPwGrg8b1xxezGEQ+2WiJSd/7cV688Ef2NLRQ2lY0aiGq3nc6DZN/oTpw+Ic10HFFsExByNFfer3zHTjC3JEyubuMkWBERuWPsJCt9QNe0iQyo5clkD7fEKVY3QwB5L1PWrbN0brcU3Lhmo1iHgoMlvTCgQO+CtB1DfPn6HS6XNIVR/a5grJ6S61i4EMkVWTRv5RmZ+9nFK571AQgy+UAKd9DMrsbNoq2qSsU0ZTTa/3ulR2fkZtkpIvq8fl7FmNIrVmh7g+Sd7uGqfvjC/fRibQED+fd1vgd1te8MDHEl2hwurOEYptRZaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=34ab5PddeRyLoT514QWq79Ly+uIfye7elhM29Jk9xwc=;
 b=UbJGu1AaW2pnMbvCKAi7NM3Gaa9hArgck9dLL4pETwrQiQyg0k6qmoOM56glfZsoyy7VRj0TsuSEHELFuR08SI+bf3aUpzrbb/FOKf71I+hFWdEyDsmg7mMcHH4qJSxpDjJVYjM4OohVaiNtbtupt6kKjw5aGS/QmNDgmQgvSeIy0U0RVQ3AyBOPnWpJS+EIXYvrvwNniFE5byFHRTsB516lGTmLi3YAIIVQm0eVoapRReqArX4uskulUl7frjP/284qlTPIJ9y0TTbupLlhTl0dANXTmIs3fcTPuXPV7itiB4lYb4Qn5eDNV6T/JaYYYkOFp0tGDVWBnsv+YsqfQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=34ab5PddeRyLoT514QWq79Ly+uIfye7elhM29Jk9xwc=;
 b=sJrM46CmWmjpIUGQglrW1ETJrnRxRcVnCcOl+uClWlx6AQhIaDROtLBT+P41tNraCzXO4Do++E3I0BZLfqbGChLNoLW3BmlINUXnCxyMMYOAcjopdFI6WdKbe9J8k+hIxyz7RK5YCTYN+mmmi96cdO9cmWo7PDrfHWlzz/Js0AM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY5PR12MB6108.namprd12.prod.outlook.com (2603:10b6:930:27::15)
 by DM6PR12MB4058.namprd12.prod.outlook.com (2603:10b6:5:21d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.14; Tue, 7 Jan
 2025 16:10:56 +0000
Received: from CY5PR12MB6108.namprd12.prod.outlook.com
 ([fe80::46e5:5b51:72c3:3754]) by CY5PR12MB6108.namprd12.prod.outlook.com
 ([fe80::46e5:5b51:72c3:3754%6]) with mapi id 15.20.8293.000; Tue, 7 Jan 2025
 16:10:56 +0000
Message-ID: <0cc3a3fd-8693-4435-aeb3-7af4b349973f@amd.com>
Date: Tue, 7 Jan 2025 10:10:55 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amd/display: add CEC notifier to amdgpu driver
To: Kun Liu <Kun.Liu2@amd.com>, amd-gfx@lists.freedesktop.org,
 harry.wentland@amd.com
Cc: richardqi.liang@amd.com
References: <20250107120850.213843-1-Kun.Liu2@amd.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20250107120850.213843-1-Kun.Liu2@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0094.namprd04.prod.outlook.com
 (2603:10b6:806:122::9) To CY5PR12MB6108.namprd12.prod.outlook.com
 (2603:10b6:930:27::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6108:EE_|DM6PR12MB4058:EE_
X-MS-Office365-Filtering-Correlation-Id: 03a2bcc9-ca74-4e40-c680-08dd2f35de3c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?a3lBWjYzL2hoQkwvRXRjY1RXeURXazExeE9BT3QyMFFEMVg5N0tJZWt0NTBo?=
 =?utf-8?B?QkVCS0lINFB3MmRMam85VEhiYzVkRnVrbGNUZkNSOEdaRmtNVTlWaVZ4NW1l?=
 =?utf-8?B?dytuRGtnVDBkNCtYallYK1dQUWRZY2hmS0ROV3NvV3VCMXJKL2pMQWVyZldZ?=
 =?utf-8?B?N1lkUUJTREJabHJSZnBXWXVFZXZ0T1NtOHF2SHZMZVpWa3FRU3Z3VCszbzNK?=
 =?utf-8?B?U0o2VStZcnFXeDFya3Y4bTdiWVFUdU9OOXo1WDdXM1RUVldzUFVQRGxtK21H?=
 =?utf-8?B?UWUwVnUzZGpuc2J2ZTFyYVRsUWxSTVlFN3p4Wk9ESmdtRTBXRFR3NFdzM2NH?=
 =?utf-8?B?MmFhczM4TGFlNzhLM0xvUTN1aVdYVThlNThtamg1ZUFURWpQa1VQM2hzNlhM?=
 =?utf-8?B?Wi9YOUpsVWkybVp0T25lMytUeGMrWjhhUFR6NGVEYUNqbHlGM3pkS1hsc1J1?=
 =?utf-8?B?M24vZlRadTlYRmRyMXpBZU1JNThLelZRbFRyVUs1M0ViOVRSaXU1WSs4SjZB?=
 =?utf-8?B?NlVpM01zd0JjUEJkOGZnYUEzV0RNTmdPNmM3bzBJelBpR1liajRVSU1LTUs5?=
 =?utf-8?B?aFdFUmFad2NLcFl3K0dtcHlTeFdRMldUTG94KzNMQlgyS3k3NmxUWVFpWnFR?=
 =?utf-8?B?WStBZGJkVG96N1cxRmJWbytSUE55OGNGTUtKdnNLYVg5akxTaGZSRTlJNlMy?=
 =?utf-8?B?bHVoVnMwQXIxNjVuUUVGT2FZaG9UQjNkbDBadENNVWI1MTRpRHpRMlRqSmhz?=
 =?utf-8?B?OXpaTmRlcy83NnNDNWFySmRyWFlYWUNPZ2kzYW5ESFhEcTNGWE00cXBSZ1pT?=
 =?utf-8?B?ZlB6NFEycmhvUUtTUDIrbUExMVl3Y0kyS3VnMmE3OUJycWZQMDFydDR0ZDdW?=
 =?utf-8?B?OFN4S1hmcHRrR0JpYlZ3aTRCMTJvVzRFVnZoaVRDNnMrWHMyN1pmYk5QSXFa?=
 =?utf-8?B?OW1XTEMvWVA5T1JKRVo3eFZ5Ymd2aGpocWVTV1RWRlNBSUtXRFBBZTZHRGJL?=
 =?utf-8?B?QUpUNEpia0tiUlFYM0VhN0JuekVjRWNYeWpLdWVocjhWUGVmSWx5eXNLOWNE?=
 =?utf-8?B?RG02OXBiWEdNdWlYZkpqazZFbkRvQXBmcDFxbDZBaUVUN2Z2MFhjVGR2cm54?=
 =?utf-8?B?djR3dEtCNGRhaVdQT3VlZlZPSU5LQkk5MTdpRjZha0hCUmIrNE9HT2FZcEZD?=
 =?utf-8?B?SG1aWjdtOU93Uk5jUVExMnYxVDFJWDVRdEdSanpNaXNxejQxb2ZzZHYyQ05n?=
 =?utf-8?B?ZnBieGxyNkU4SnlKR0N6emc5NmJGSGNFMmxzdnlLYStQMDN2b29SOTBtd1BL?=
 =?utf-8?B?eDVraFFyeVpCUW51NlZFMUZsdW1wL1ZhbWxRMWM0blQ2TXluZ01VY1hRMlpj?=
 =?utf-8?B?L3oxaEhKSjFPa1djTkZVdDIySkFMSkF3dmhtRTRrNXVEK0ppVmpxT1FTeUYw?=
 =?utf-8?B?WERDdXhkTXJUdWtrak5JODYrZHkwKyt1Uk51S2ZxekwxZ3g0U0tKdW15Uk9O?=
 =?utf-8?B?bmNobUpxSXpVbi91ZVR4UmZKQ1l1NWRtcHQzQVNZVWs0UmVoOEkvamZCWnRL?=
 =?utf-8?B?cVAxb3V3U2V1aVhMVmt0ZVhuT2wzOStnMVVmbk5sMm9tRGZYUHUrNyszdDN6?=
 =?utf-8?B?TGlGRy9mZzYvY1VzaG9yTGViUXFVTkFFNGtmYmpEYkFkWFlzaTl2WFA0ZWRs?=
 =?utf-8?B?a3RYNmtjTmVxVTJOV1NnYkczMVdYYTZpVGhkRWxFU3p4WkhxbnN6NE1LUDVm?=
 =?utf-8?B?VmsrWDVvc0dSbWlCUlhWUlRuaTZtc2xnMkdjT2pQOW5YRGhQK0hZakJkeGpD?=
 =?utf-8?B?MDAzaHM3K0FtUi9EZ2s0UT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY5PR12MB6108.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eTA5OGt6eG9CZlkwZk5DSkRjTnUyYWpsL09CK2lnOElVNVp3WWpLM0JuTzFm?=
 =?utf-8?B?RnFkalJYNlNpZjE2OW80dTlFRnpyelJtQUlLNzR6OGo0MTNsYnRCUU5ZTXM2?=
 =?utf-8?B?UHVqMndNNnlXemtmSkhMZDgydlVWVDYyajRLZG1xdzl6L0Y0Q0g4dTVsamtm?=
 =?utf-8?B?QWFLUXdaaVlQV0QrajdsVW55VjMxbmJYUEJqTXJTLzVvR1htbXU1NDdWamcr?=
 =?utf-8?B?bXYvcmtlWHE5aTdnYUREM2s4MlBmaWtkTGZOZzdjUzA3REEwZWpTeXBkaEgy?=
 =?utf-8?B?QnM2MnAxUXVrVWZENkRFRHVhMXVVQmM2SlRVd05ZU3d3bmVZdUFpUFFLVkZx?=
 =?utf-8?B?eUx0UXNPT0NGTE9zeXFkZW5ZSThzRHJGKzJ1NGtZVFJKSDA0UXoxVFJCaGxV?=
 =?utf-8?B?QWxkdVZDejV0Snd1UEZpdkhOeEFFazJ3aUZOYlg4UWJCYXlMeDVpRkJKSVVn?=
 =?utf-8?B?NGxxMkpwbWRqdjFOdk1sRUVaejFwL0dpRGNLSi9NYWd1UDlLRTZGZ3FDSkYv?=
 =?utf-8?B?anhQY0sxVjcvbDVaalFLaDNwL0R4Z1prdHBYV3lVUDA0LzRuV290dzlLeXJR?=
 =?utf-8?B?OEdJaVRiYU03czA3NkRZZFpDalhVZnh3b2xyMFF1RE1MWG9UdWZkY0Vibjg5?=
 =?utf-8?B?ME5aYU02aWJJUHFZOGRhRlh4ak9CeVlFWkdnZGxzWEU1L1NoU09IYTlQeVZG?=
 =?utf-8?B?d05Ldi9Vb1YwOW9wSzIxaHgwNThBeFNkTXBseTdreTZVRmtEUkliYTNwOTJB?=
 =?utf-8?B?VlY3VGlPZk1LVUFaTXZNTGtyMEMvUmZSRHR5ZThOajdEU0IxY3R4eEJQMnhL?=
 =?utf-8?B?N0pkVHUzaytqK0NzUmhzdUd6OGtDbFR6YkozQUFWSDdQcEYwbzBKV3lCWFVD?=
 =?utf-8?B?YmxVNU9URGZaN2ZnZ3V0ck4zZGNTWWZtUW1WMnl3Sjhnem9kSUN2a0UwZ05O?=
 =?utf-8?B?SDNkeldpY1FjdFF5QjRUVGxVcnltSHB3M24wNVpyZjAzTnhQR2FXTkgzVWFh?=
 =?utf-8?B?YjNmT2p4WklQc3loeTVBVGxpN2QvMW9ZNUovcC81bDBJVVY1SjBEN2VPUUow?=
 =?utf-8?B?WXk4S1hjTGdsbnJ3c09RY0pvTUVVRHB3c0lTVDJER05zMi9vUWwzRlhpejJh?=
 =?utf-8?B?azh5NS9lT0ovSkhhZGlUaVArQkc5RXRqOXkzbXR5eTN6SjNTU2cxdmhaQ1N5?=
 =?utf-8?B?VzUxNU9pTnNuaTBDaUF4ZGdQR2dpVUNnSUlzRTlDWGlOUjhqQk9YbE13a1BP?=
 =?utf-8?B?cy82TGU0UTZ3ckVKV2c2NUJaY2txYkdaaW5kSE5SVE50L0QxNkozeUNIMjJW?=
 =?utf-8?B?TVJWZEVDWHVSNFRCUW5BYUh5a1hxSVJ6SWpSQjIxSmhaZE4zTzVnZW93ZXkv?=
 =?utf-8?B?UHlFR1dPNWdzODY3RFVsQUJPWGdLeEJEblEvMk93OVZyMGJSWnZIT3gvbVU0?=
 =?utf-8?B?elh0TVQzSHBZOFFPdVhCb01KWW1tNmJiRUlNbjBodDQ1OWkya2o4aTg0UkJD?=
 =?utf-8?B?eFA3aGY4bGJwZ3hjRVEzcVlDV21JM2oyM2NjLzUyQnNTWldzb2VyN0svNFZ6?=
 =?utf-8?B?enRYQS8zWStJL1ZyMURGYUhyQ3NCU2s5MThoVVZtS2p4eUxFNGRSM2Zmblk1?=
 =?utf-8?B?aFhEWWErb29NOWMyb1FqQ3lXZUR5SmJaTXl4YVc1NVYvdUpPRXpiQnZDb1Vt?=
 =?utf-8?B?MlpiN0wrSDUrei9RNlE0Q3pQcWFBV3JxZCtVbUlSYmNyaTBzMGJMUTdNS2hs?=
 =?utf-8?B?U1hnaGIzVWNhaVpiQnl6M0hEQllpelV3dzJiQldoK3o2TzZOVDh6SG52bEpk?=
 =?utf-8?B?YWZuSEp6MmFDSStDUFVTMG5MWUxBSE9WTkhZbnNRYWxybGJUa1pnL0NFU0Rh?=
 =?utf-8?B?WVhlNk1tT0JWZHdrZFkxN1VqZGFhMGNta3U4dUVxVXM1N2N3MEFjK0JYcDB6?=
 =?utf-8?B?blpveEJ6NWM1UjBKQ2ZjUUNKSGl5SHFBRldDT2FuS1Q1dkpDNHpOaGtHOWg2?=
 =?utf-8?B?SmJObVhUVGdpMVc5V3lSakJ0b0hTaEFJdXZMOS9mQWtCUlpZT1owRjJKcjMw?=
 =?utf-8?B?NW9mczBsTVAydE1EVFZ4UVNMWTN2NUNzbWd2cnN5aXRkNTZQZzk5U25DZy9B?=
 =?utf-8?Q?djlkV38GHtSfQYBUUc2tRvvl4?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03a2bcc9-ca74-4e40-c680-08dd2f35de3c
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2025 16:10:56.6237 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2A4g9x9ERCDtO9nla/F74W3ECitYIrnp7NEdJhsP9CFa79sjxld/37kmE37A0YttwARWoBDk7XTEOLu0F96BKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4058
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

On 1/7/2025 06:08, Kun Liu wrote:
> This patch adds the cec_notifier feature to amdgpu driver.
> The changes will allow amdgpu driver code to notify EDID
> and HPD changes to an eventual CEC adapter.
> 
> Signed-off-by: Kun Liu <Kun.Liu2@amd.com>

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>

> ---
>   drivers/gpu/drm/amd/display/Kconfig           |  2 +
>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 76 +++++++++++++++++++
>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  6 ++
>   .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c | 66 +++++++++++++++-
>   drivers/gpu/drm/amd/include/amd_shared.h      |  5 ++
>   5 files changed, 154 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/Kconfig b/drivers/gpu/drm/amd/display/Kconfig
> index 11e3f2f3b..abd3b6564 100644
> --- a/drivers/gpu/drm/amd/display/Kconfig
> +++ b/drivers/gpu/drm/amd/display/Kconfig
> @@ -8,6 +8,8 @@ config DRM_AMD_DC
>   	bool "AMD DC - Enable new display engine"
>   	default y
>   	depends on BROKEN || !CC_IS_CLANG || ARM64 || LOONGARCH || RISCV || SPARC64 || X86_64
> +	select CEC_CORE
> +	select CEC_NOTIFIER
>   	select SND_HDA_COMPONENT if SND_HDA_CORE
>   	# !CC_IS_CLANG: https://github.com/ClangBuiltLinux/linux/issues/1752
>   	select DRM_AMD_DC_FP if ARCH_HAS_KERNEL_FPU_SUPPORT && !(CC_IS_CLANG && (ARM64 || LOONGARCH || RISCV))
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 49baef9dd..1db955c28 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -97,6 +97,7 @@
>   #include <drm/drm_audio_component.h>
>   #include <drm/drm_gem_atomic_helper.h>
>   
> +#include <media/cec-notifier.h>
>   #include <acpi/video.h>
>   
>   #include "ivsrcid/dcn/irqsrcs_dcn_1_0.h"
> @@ -2751,6 +2752,48 @@ static void resume_mst_branch_status(struct drm_dp_mst_topology_mgr *mgr)
>   	mutex_unlock(&mgr->lock);
>   }
>   
> +void hdmi_cec_unset_edid(struct amdgpu_dm_connector *aconnector)
> +{
> +	struct cec_notifier *n = aconnector->notifier;
> +
> +	if (!n)
> +		return;
> +
> +	cec_notifier_phys_addr_invalidate(n);
> +}
> +
> +void hdmi_cec_set_edid(struct amdgpu_dm_connector *aconnector)
> +{
> +	struct drm_connector *connector = &aconnector->base;
> +	struct cec_notifier *n = aconnector->notifier;
> +
> +	if (!n)
> +		return;
> +
> +	cec_notifier_set_phys_addr(n,
> +				   connector->display_info.source_physical_address);
> +}
> +
> +static void s3_handle_hdmi_cec(struct drm_device *ddev, bool suspend)
> +{
> +	struct amdgpu_dm_connector *aconnector;
> +	struct drm_connector *connector;
> +	struct drm_connector_list_iter conn_iter;
> +
> +	drm_connector_list_iter_begin(ddev, &conn_iter);
> +	drm_for_each_connector_iter(connector, &conn_iter) {
> +		if (connector->connector_type == DRM_MODE_CONNECTOR_WRITEBACK)
> +			continue;
> +
> +		aconnector = to_amdgpu_dm_connector(connector);
> +		if (suspend)
> +			hdmi_cec_unset_edid(aconnector);
> +		else
> +			hdmi_cec_set_edid(aconnector);
> +	}
> +	drm_connector_list_iter_end(&conn_iter);
> +}
> +
>   static void s3_handle_mst(struct drm_device *dev, bool suspend)
>   {
>   	struct amdgpu_dm_connector *aconnector;
> @@ -3022,6 +3065,8 @@ static int dm_suspend(struct amdgpu_ip_block *ip_block)
>   	if (IS_ERR(adev->dm.cached_state))
>   		return PTR_ERR(adev->dm.cached_state);
>   
> +	s3_handle_hdmi_cec(adev_to_drm(adev), true);
> +
>   	s3_handle_mst(adev_to_drm(adev), true);
>   
>   	amdgpu_dm_irq_suspend(adev);
> @@ -3294,6 +3339,8 @@ static int dm_resume(struct amdgpu_ip_block *ip_block)
>   	 */
>   	amdgpu_dm_irq_resume_early(adev);
>   
> +	s3_handle_hdmi_cec(ddev, false);
> +
>   	/* On resume we need to rewrite the MSTM control bits to enable MST*/
>   	s3_handle_mst(ddev, false);
>   
> @@ -3603,6 +3650,7 @@ void amdgpu_dm_update_connector_after_detect(
>   		dc_sink_retain(aconnector->dc_sink);
>   		if (sink->dc_edid.length == 0) {
>   			aconnector->drm_edid = NULL;
> +			hdmi_cec_unset_edid(aconnector);
>   			if (aconnector->dc_link->aux_mode) {
>   				drm_dp_cec_unset_edid(&aconnector->dm_dp_aux.aux);
>   			}
> @@ -3612,6 +3660,7 @@ void amdgpu_dm_update_connector_after_detect(
>   			aconnector->drm_edid = drm_edid_alloc(edid, sink->dc_edid.length);
>   			drm_edid_connector_update(connector, aconnector->drm_edid);
>   
> +			hdmi_cec_set_edid(aconnector);
>   			if (aconnector->dc_link->aux_mode)
>   				drm_dp_cec_attach(&aconnector->dm_dp_aux.aux,
>   						  connector->display_info.source_physical_address);
> @@ -3628,6 +3677,7 @@ void amdgpu_dm_update_connector_after_detect(
>   		amdgpu_dm_update_freesync_caps(connector, aconnector->drm_edid);
>   		update_connector_ext_caps(aconnector);
>   	} else {
> +		hdmi_cec_unset_edid(aconnector);
>   		drm_dp_cec_unset_edid(&aconnector->dm_dp_aux.aux);
>   		amdgpu_dm_update_freesync_caps(connector, NULL);
>   		aconnector->num_modes = 0;
> @@ -7044,6 +7094,7 @@ static void amdgpu_dm_connector_unregister(struct drm_connector *connector)
>   	if (amdgpu_dm_should_create_sysfs(amdgpu_dm_connector))
>   		sysfs_remove_group(&connector->kdev->kobj, &amdgpu_group);
>   
> +	cec_notifier_conn_unregister(amdgpu_dm_connector->notifier);
>   	drm_dp_aux_unregister(&amdgpu_dm_connector->dm_dp_aux.aux);
>   }
>   
> @@ -8280,6 +8331,27 @@ create_i2c(struct ddc_service *ddc_service,
>   	return i2c;
>   }
>   
> +int amdgpu_dm_initialize_hdmi_connector(struct amdgpu_dm_connector *aconnector)
> +{
> +	struct cec_connector_info conn_info;
> +	struct drm_device *ddev = aconnector->base.dev;
> +	struct device *hdmi_dev = ddev->dev;
> +
> +	if (amdgpu_dc_debug_mask & DC_DISABLE_HDMI_CEC) {
> +		drm_info(ddev, "HDMI-CEC feature masked\n");
> +		return -EINVAL;
> +	}
> +
> +	cec_fill_conn_info_from_drm(&conn_info, &aconnector->base);
> +	aconnector->notifier =
> +		cec_notifier_conn_register(hdmi_dev, NULL, &conn_info);
> +	if (!aconnector->notifier) {
> +		drm_err(ddev, "Failed to create cec notifier\n");
> +		return -ENOMEM;
> +	}
> +
> +	return 0;
> +}
>   
>   /*
>    * Note: this function assumes that dc_link_detect() was called for the
> @@ -8343,6 +8415,10 @@ static int amdgpu_dm_connector_init(struct amdgpu_display_manager *dm,
>   	drm_connector_attach_encoder(
>   		&aconnector->base, &aencoder->base);
>   
> +	if (connector_type == DRM_MODE_CONNECTOR_HDMIA ||
> +	    connector_type == DRM_MODE_CONNECTOR_HDMIB)
> +		amdgpu_dm_initialize_hdmi_connector(aconnector);
> +
>   	if (connector_type == DRM_MODE_CONNECTOR_DisplayPort
>   		|| connector_type == DRM_MODE_CONNECTOR_eDP)
>   		amdgpu_dm_initialize_dp_connector(dm, aconnector, link->link_index);
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> index e46e1365f..76fa3e785 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> @@ -671,6 +671,8 @@ struct amdgpu_dm_connector {
>   	uint32_t connector_id;
>   	int bl_idx;
>   
> +	struct cec_notifier *notifier;
> +
>   	/* we need to mind the EDID between detect
>   	   and get modes due to analog/digital/tvencoder */
>   	const struct drm_edid *drm_edid;
> @@ -1010,4 +1012,8 @@ void dm_free_gpu_mem(struct amdgpu_device *adev,
>   
>   bool amdgpu_dm_is_headless(struct amdgpu_device *adev);
>   
> +void hdmi_cec_set_edid(struct amdgpu_dm_connector *aconnector);
> +void hdmi_cec_unset_edid(struct amdgpu_dm_connector *aconnector);
> +int amdgpu_dm_initialize_hdmi_connector(struct amdgpu_dm_connector *aconnector);
> +
>   #endif /* __AMDGPU_DM_H__ */
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
> index 0d84308c5..d189dddb1 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
> @@ -25,6 +25,7 @@
>   
>   #include <linux/string_helpers.h>
>   #include <linux/uaccess.h>
> +#include <media/cec-notifier.h>
>   
>   #include "dc.h"
>   #include "amdgpu.h"
> @@ -2848,6 +2849,67 @@ static int is_dpia_link_show(struct seq_file *m, void *data)
>   	return 0;
>   }
>   
> +/**
> + * hdmi_cec_state_show - Read out the HDMI-CEC feature status
> + * @m: sequence file.
> + * @data: unused.
> + *
> + * Return 0 on success
> + */
> +static int hdmi_cec_state_show(struct seq_file *m, void *data)
> +{
> +	struct drm_connector *connector = m->private;
> +	struct amdgpu_dm_connector *aconnector = to_amdgpu_dm_connector(connector);
> +
> +	seq_printf(m, "%s:%d\n", connector->name, connector->base.id);
> +	seq_printf(m, "HDMI-CEC status: %d\n", aconnector->notifier ? 1 : 0);
> +
> +	return 0;
> +}
> +
> +/**
> + * hdmi_cec_state_write - Enable/Disable HDMI-CEC feature from driver side
> + * @f: file structure.
> + * @buf: userspace buffer. set to '1' to enable; '0' to disable cec feature.
> + * @size: size of buffer from userpsace.
> + * @pos: unused.
> + *
> + * Return size on success, error code on failure
> + */
> +static ssize_t hdmi_cec_state_write(struct file *f, const char __user *buf,
> +				     size_t size, loff_t *pos)
> +{
> +	int ret;
> +	bool enable;
> +	struct amdgpu_dm_connector *aconnector = file_inode(f)->i_private;
> +	struct drm_device *ddev = aconnector->base.dev;
> +
> +	if (size == 0)
> +		return -EINVAL;
> +
> +	ret = kstrtobool_from_user(buf, size, &enable);
> +	if (ret) {
> +		drm_dbg_driver(ddev, "invalid user data !\n");
> +		return ret;
> +	}
> +
> +	if (enable) {
> +		if (aconnector->notifier)
> +			return -EINVAL;
> +		ret = amdgpu_dm_initialize_hdmi_connector(aconnector);
> +		if (ret)
> +			return ret;
> +		hdmi_cec_set_edid(aconnector);
> +	} else {
> +		if (!aconnector->notifier)
> +			return -EINVAL;
> +		cec_notifier_conn_unregister(aconnector->notifier);
> +		aconnector->notifier = NULL;
> +	}
> +
> +	return size;
> +}
> +
>   DEFINE_SHOW_ATTRIBUTE(dp_dsc_fec_support);
>   DEFINE_SHOW_ATTRIBUTE(dmub_fw_state);
>   DEFINE_SHOW_ATTRIBUTE(dmub_tracebuffer);
> @@ -2860,6 +2922,7 @@ DEFINE_SHOW_ATTRIBUTE(psr_capability);
>   DEFINE_SHOW_ATTRIBUTE(dp_is_mst_connector);
>   DEFINE_SHOW_ATTRIBUTE(dp_mst_progress_status);
>   DEFINE_SHOW_ATTRIBUTE(is_dpia_link);
> +DEFINE_SHOW_STORE_ATTRIBUTE(hdmi_cec_state);
>   
>   static const struct file_operations dp_dsc_clock_en_debugfs_fops = {
>   	.owner = THIS_MODULE,
> @@ -2995,7 +3058,8 @@ static const struct {
>   	char *name;
>   	const struct file_operations *fops;
>   } hdmi_debugfs_entries[] = {
> -		{"hdcp_sink_capability", &hdcp_sink_capability_fops}
> +		{"hdcp_sink_capability", &hdcp_sink_capability_fops},
> +		{"hdmi_cec_state", &hdmi_cec_state_fops}
>   };
>   
>   /*
> diff --git a/drivers/gpu/drm/amd/include/amd_shared.h b/drivers/gpu/drm/amd/include/amd_shared.h
> index 98d9e840b..05bdb4e02 100644
> --- a/drivers/gpu/drm/amd/include/amd_shared.h
> +++ b/drivers/gpu/drm/amd/include/amd_shared.h
> @@ -344,6 +344,11 @@ enum DC_DEBUG_MASK {
>   	 * eDP display from ACPI _DDC method.
>   	 */
>   	DC_DISABLE_ACPI_EDID = 0x8000,
> +
> +	/*
> +	 * @DC_DISABLE_HDMI_CEC: If set, disable HDMI-CEC feature in amdgpu driver.
> +	 */
> +	DC_DISABLE_HDMI_CEC = 0x10000,
>   };
>   
>   enum amd_dpm_forced_level;

