Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C522E606A319
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Oct 2026 04:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=UwOHs+bm
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6139E1122EC;
	Thu, 22 Oct 2026 04:59:17 +0000 (UTC)
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010052.outbound.protection.outlook.com [52.101.46.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5BFD11122EC
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Oct 2026 04:59:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xmFzPHJTzdtdCEZy9r7G+AEDMv32pOGSbxUng81uJDfOnomd+na8kB+v0SS5h7cJe2Ir9Bh9o88SmxtiR52yLSRUd6txZvZk+3byshNm5/NNWu9kqcaJOmtnS1dbxH/PYXphTZESoSPU6E+a2+IOTOi+eC4j/Pm3CVRDnCuVV2JlMAAFMdXpmQ2V9Ao+bYlQ5OugRFWcHweA9EnhetWqqpoj/msYFBOFfLovWu/H+AN8S5LKG2uoPbMaM7QuQMtopa0AIywibKY9lW4W3uA1RAvqcCwKh0MyGooBuBbvfWHHLHvU+GNcSW559EgKf8I34WivHmwbWhTp+dCY4lWsTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3wSsMWWxsQVfTw/LXSGy5GdYg5baqHM3Y4d2xiETuyY=;
 b=YkVDPqqD3yADt1W1ys0VZgOVDNoXhA7jOo80K2Yoy7MigZ/hG5w6rxc5shWNkgI4ucrYIC88FfROHhFRZTtOlkZmFPtbv0i79Q6rLw7jgxRzTe/0M+CU2FTGh3n6hmG6NrqOENlC7T2YxVXY1W+QWykUqhKsTRjbL73n+MVLPgo13z/vdNdoYw82mD62TO/k0XRn2GgGvsxuIYBUKBhoEoYlQDDSo70IoX/65XPNAjfAZgM7l8evxraM1VfxgtJThrvwjChUn3hnPPPtOaZ7NJ9hepEr1gpPclu+5MXgSTczxCXi3XI7ydueRCWIdwAKblGp0hnDvkwjyURZYCCkAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3wSsMWWxsQVfTw/LXSGy5GdYg5baqHM3Y4d2xiETuyY=;
 b=UwOHs+bm8tMG0pbGNL3IxpocdAqxeHS87nMiHOPbfBScf1ANNVdRHEskQ6SL/IyezYE37ceT+8ZLz9NdS919RU1QvesLxcFag7v6hjQpXVL5mYIjASWXPn/uMamyktavaZ/dGNeh28kqgYO1mZXvPcjZyvZ3TYpb+N3Y0MTQcBk=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB9189.namprd12.prod.outlook.com (2603:10b6:a03:55b::15)
 by BL3PR12MB6449.namprd12.prod.outlook.com (2603:10b6:208:3b8::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Thu, 22 Oct
 2026 04:59:07 +0000
Received: from SJ2PR12MB9189.namprd12.prod.outlook.com
 ([fe80::7923:8cd0:a2d8:ac7e]) by SJ2PR12MB9189.namprd12.prod.outlook.com
 ([fe80::7923:8cd0:a2d8:ac7e%5]) with mapi id 15.21.0546.016; Thu, 22 Oct 2026
 04:59:06 +0000
Message-ID: <c8645c3a-8b49-46be-9c04-8b481e7965a2@amd.com>
Date: Thu, 22 Oct 2026 12:59:02 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: add DCN36 OPTC RSMU underflow registers
To: Wayne Lin <Wayne.Lin@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander Deucher <Alexander.Deucher@amd.com>,
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>
References: <20261022025620.3664022-1-Wayne.Lin@amd.com>
Content-Language: en-US
From: "Chung, ChiaHsuan (Tom)" <chiahsuan.chung@amd.com>
In-Reply-To: <20261022025620.3664022-1-Wayne.Lin@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TPYP295CA0050.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:8::12) To SJ2PR12MB9189.namprd12.prod.outlook.com
 (2603:10b6:a03:55b::15)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB9189:EE_|BL3PR12MB6449:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b871190-c5e4-4d44-069f-08df2ff9333e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|261009223027099003|56012099006|11063799006|10067099003|22082099003|18002099003|6133799003|261021121427099003;
X-Microsoft-Antispam-Message-Info: gRxxfXe/ZyaPypcNP0prp8Rv+fwxSePrjxdpCtutcwt1l81EpTQSDJ/SAXACnMjjMJ7DzLqW529DNFaRr0EwNNkhV27BVRhyHRt6jAX5XmpTOitosSqQnNJWtlv/vpJRFzaBgQQTAYcZ4V5Pcqs3xoms8HsB5DyzVEbVzJdu6HQVJtPAIPIpFP0tw59f0j2cAjfFfONgoHfzazCQyToVbu6oVn8PvHi0QdfLOlOGNEKYj3SgYquW7mCAYJaRsJCOHcbfeHpypaC5KnbOL9MoF8Jzy3LHXT1GXxEez29EF6AiU6y++ciJvD4A2s9HESjTkK4TtWnvcvDuY+Kfqins7kviJzCP+JbmAd0BZcmZmGIdOLAkiH2BPtyk5goBY7i8PE57ssTKY4Nq4V62lDbh/I8p1lLfQpEtyq05Z3TlR/fL2+VKVUrjQGrQtz4/i+rkYL+BCQ5VUfWHvO31mjylwg/5FNYi5zjC1QF4M+iBtjnZ0bV17Na164AJwzMPHXPlh/AqVLBHfT4psPvtMbE177bPInDlmt6U4Iwp9KSZJWheu78VDYRvjOC+LeDu0IkTKkpVEEihdS7N42lfACUz6Iz1Kup8OeZXIGT0dMyIwjd9PwgvIn30Gh//09HquZqTAK9y7XM2ftNYcOGsjcuHZsFTcAEcj2Bd9iieQnf0gjs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB9189.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(261009223027099003)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003)(6133799003)(261021121427099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WFZaWllHaVdpZWE3SmVRdDUrTjRpc2lMc0J2bzRkTlJtTjN5MUZyUVU4S080?=
 =?utf-8?B?T0tlWW1ONkx5djBCY0hnRytXZ3IxK2JrR2hBYmdoOCtIUXV2d2Y5bHB1bmdS?=
 =?utf-8?B?cEd0WjQ4Nmc0L3V5czczck9WRFZFeTgwdjdBZWZYQXVXSzlxYXl1ZTdic2lp?=
 =?utf-8?B?QjY0VThiM05oR25Yc0JabjhlaU1kZnYyaERZNnplQ3VHY0ZjRndSckpKRnlS?=
 =?utf-8?B?Q29PMzFubldNRkErWlJzNmE2R0hpK2xoYytTQmt0ZmIrWHd0ZDM2ZjVpS3NK?=
 =?utf-8?B?bUUvbkkzOHAralpJN0hFaW5GZDJONEFpbElaMnJmYXNHUTJnRVUrdE02d1dY?=
 =?utf-8?B?dUFtL2E1T1ZtSHhSbFVvWDdDbWwrYzl2emcvRFZleHUzYWJTVDhqWWR0Uzlw?=
 =?utf-8?B?WEJnWFNLS0ZXalNtVE85TnJPU0ZMdmpJZ1dZTmNTVkEzSHo5SlZOUzF1S1R2?=
 =?utf-8?B?UzJ3RzBxcGQybHAxaGJHZzduVmdxV0JYanNJeUJtUGdXbkhOdzc3cWhQNXI4?=
 =?utf-8?B?OEhvak1FaTkxc1JjL0JITWFJYzkray9HaWtBb2c0MXNwWWVaa29BV0Y4UUJ6?=
 =?utf-8?B?R1RMcnhEeHhOTzY0eTFaNnVBZ0FGb3VGeU1zOHdoUGtieTVXTHY4c0R0cFgv?=
 =?utf-8?B?K0dQQVoxREVrclZndHNsblhHRmtuQXRwSm5qampHWW9SR0dlMTJIQUFGZUMy?=
 =?utf-8?B?elp6bXNxdlN4cDRaUmpNOHB4bFJXYlo2ZjczU2U1L2czTWtRbWpLM1Zvd0NJ?=
 =?utf-8?B?RUd1ZUtoejRNVkR1cFZHeEE4ZVo2bVpjWjBGTVU4d3pvcGJCOUszMjMvNDJw?=
 =?utf-8?B?bVFMZWV6RXhNVTV4aHdFR0tuNDlPUUE0U1FnK3FyaGxPWjg5MGFST1VjZFBw?=
 =?utf-8?B?RkNpMy9LZmdXempEVHpQL0xpNnZuNXFNaWRLUk5EWlpIYW92aVlENnhQbWxL?=
 =?utf-8?B?WVo1THFRUFVtYVRSM3FuMWtnR2wxMCtmUStUQlJtbFg2Y0NQWG5FdUcycit6?=
 =?utf-8?B?d2NBYVBNVU1JYjZXcU05R2dXWDVjazNxRmdmMTlGSUFBdUtqQjNOY1BOQVc5?=
 =?utf-8?B?ZHdMSmtqUWFtaGJPTHp0UVAxN1o5akJNZ3czTjgyd1hSd3JhRGVVMTVjRkMz?=
 =?utf-8?B?Snh4cHhEdWdEdFIzRUlhSzJXbG9yYm1zN2Z0TmNSbDZFdXI4aHJyYnFkRjJR?=
 =?utf-8?B?S1pJQUx1dWw0UmdWREtvL21qV1dwL0xOUlFNNUIySUMyS1Y2NkJ6UWNWL2xW?=
 =?utf-8?B?bGtwUUlkaUFXaERjMmJGeVJBa1A3ekdKSmowZElsYWJmdys5bmNaeFB3WkFU?=
 =?utf-8?B?YkJ2VGVLYmdUK2VYSmVNYVZnLytFZnJTZzVXU0wzTHVFcUNKQzBtWUw4YzN6?=
 =?utf-8?B?WUZlcjlhVm1uNGZjdGRuU2VKVzRCYXBQV1RBMUhkdUpzamJzam1ncUNmdTFK?=
 =?utf-8?B?TUYyTWRNL3d6bDBMSGdjTHp6OERUelg4bUgwSGFhSTIzdURMZURkUWNCbVpq?=
 =?utf-8?B?ZHBWS09OZmhOZ0hWRklXRGRoTkZaT2o0MW1ITkx0eVQzc1ZZL1kxVTRERnFN?=
 =?utf-8?B?bU9xT0U2TiswVDZxeFRyd3dtNHJCR3piOUl4ZThDN1gyd3p1U3VBTS9uNnZY?=
 =?utf-8?B?a1gzZWlqVzltN2J4WWhZeFJnVlJVSmVFUzV1QmhEV3RxOXB6YVkxTjBWNjln?=
 =?utf-8?B?eDA1RFZVZ2E3QVZtc2JKWmlkaFc1VDRaUGVCeDVHNmVmVlRaeEthRGF4Yllp?=
 =?utf-8?B?UXp5VmMwRFAvZWRWbVRQS2pUQ1dTYWd2aTlFeFl5aHQ2c2FucHVGZGhCaWdC?=
 =?utf-8?B?alNYY0RjZ09KYUJVK3FMTXZzbWlDUDZtdUMwMmtCK1FJV1VvbzJCdXhLSW5s?=
 =?utf-8?B?cVRLMXhRSWI5bDhmK29YbTFKVnRTMzJDN2RQMmV4Z2JMbHhHTG9UblJGdTVU?=
 =?utf-8?B?bFQrUE9hMm5hQ2Q1elU3OXFMeW56K0szZ1hwdWlITEh1L3plMFI3VnBzS3R3?=
 =?utf-8?B?SENYMmo5Wm8vOW11RXl2UDRwcVhJYWJSaHBqQy9zMEp4dkhXSFBvUTJEOVJG?=
 =?utf-8?B?NkxURGJTaVdTTElqNkJsdGpGUXZsdHdvdERSeTd6TFh5Uk5hUTdTZkNROERI?=
 =?utf-8?B?aEI3UkhhNDJqOHNFN3dYRW1KcnNEYnFyRzVMNXg5eUx3OFJDOXBRaFE4UFlH?=
 =?utf-8?B?SUc2UE5EODNpWkpzTVlIa0ZHejVkTUtRTzZjMHdtc2VIZWhRSjJRK0pCK1d2?=
 =?utf-8?B?eE1Mc01IWE5acEpoRHdZczB0aEtzL2pXZGZTT1ZheFNwbnE2ekNOWXlMTEQ2?=
 =?utf-8?B?ZnVJU2RJaE03bXBPUWhKWmVFcWpRR042WmdSV1ZjL3ROc0ovS1pxQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b871190-c5e4-4d44-069f-08df2ff9333e
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9189.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2026 04:59:06.5503 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YZTIGXgRNpXQqQIDjIb9xneClfjflf8xHgIZPehnROVkQGdb0x2MPbjlBGY6b62uzgcB9RArSADxH4HX7EvJ2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6449
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UPPERCASE_50_75,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Reviewed-by: Tom Chung <chiahsuan.chung@amd.com>

On 10/22/2026 10:56 AM, Wayne Lin wrote:
> Expose OPTC RSMU underflow registers of dcn36 for later usage.
>
> Signed-off-by: Wayne Lin <Wayne.Lin@amd.com>
> Assisted-by: Cursor:Grok 4.7
> ---
>   .../include/asic_reg/dcn/dcn_3_6_0_offset.h   |  8 +++++
>   .../include/asic_reg/dcn/dcn_3_6_0_sh_mask.h  | 36 +++++++++++++++++++
>   2 files changed, 44 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_6_0_offset.h b/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_6_0_offset.h
> index b070f9b91f17..90d624d22b3a 100644
> --- a/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_6_0_offset.h
> +++ b/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_6_0_offset.h
> @@ -8329,6 +8329,8 @@
>   #define regODM0_OPTC_MEMORY_CONFIG_BASE_IDX                                                             2
>   #define regODM0_OPTC_INPUT_SPARE_REGISTER                                                               0x1ad1
>   #define regODM0_OPTC_INPUT_SPARE_REGISTER_BASE_IDX                                                      2
> +#define regODM0_OPTC_RSMU_UNDERFLOW                                                                     0x1ad4
> +#define regODM0_OPTC_RSMU_UNDERFLOW_BASE_IDX                                                            2
>   #define regODM0_OPTC_UNDERFLOW_THRESHOLD                                                                0x1ad5
>   #define regODM0_OPTC_UNDERFLOW_THRESHOLD_BASE_IDX                                                       2
>   
> @@ -8351,6 +8353,8 @@
>   #define regODM1_OPTC_MEMORY_CONFIG_BASE_IDX                                                             2
>   #define regODM1_OPTC_INPUT_SPARE_REGISTER                                                               0x1ae1
>   #define regODM1_OPTC_INPUT_SPARE_REGISTER_BASE_IDX                                                      2
> +#define regODM1_OPTC_RSMU_UNDERFLOW                                                                     0x1ae4
> +#define regODM1_OPTC_RSMU_UNDERFLOW_BASE_IDX                                                            2
>   #define regODM1_OPTC_UNDERFLOW_THRESHOLD                                                                0x1ae5
>   #define regODM1_OPTC_UNDERFLOW_THRESHOLD_BASE_IDX                                                       2
>   
> @@ -8373,6 +8377,8 @@
>   #define regODM2_OPTC_MEMORY_CONFIG_BASE_IDX                                                             2
>   #define regODM2_OPTC_INPUT_SPARE_REGISTER                                                               0x1af1
>   #define regODM2_OPTC_INPUT_SPARE_REGISTER_BASE_IDX                                                      2
> +#define regODM2_OPTC_RSMU_UNDERFLOW                                                                     0x1af4
> +#define regODM2_OPTC_RSMU_UNDERFLOW_BASE_IDX                                                            2
>   #define regODM2_OPTC_UNDERFLOW_THRESHOLD                                                                0x1af5
>   #define regODM2_OPTC_UNDERFLOW_THRESHOLD_BASE_IDX                                                       2
>   
> @@ -8395,6 +8401,8 @@
>   #define regODM3_OPTC_MEMORY_CONFIG_BASE_IDX                                                             2
>   #define regODM3_OPTC_INPUT_SPARE_REGISTER                                                               0x1b01
>   #define regODM3_OPTC_INPUT_SPARE_REGISTER_BASE_IDX                                                      2
> +#define regODM3_OPTC_RSMU_UNDERFLOW                                                                     0x1b04
> +#define regODM3_OPTC_RSMU_UNDERFLOW_BASE_IDX                                                            2
>   #define regODM3_OPTC_UNDERFLOW_THRESHOLD                                                                0x1b05
>   #define regODM3_OPTC_UNDERFLOW_THRESHOLD_BASE_IDX                                                       2
>   
> diff --git a/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_6_0_sh_mask.h b/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_6_0_sh_mask.h
> index 3ffb6ec8b40a..390b164fba5e 100644
> --- a/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_6_0_sh_mask.h
> +++ b/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_6_0_sh_mask.h
> @@ -27326,6 +27326,15 @@
>   //ODM0_OPTC_INPUT_SPARE_REGISTER
>   #define ODM0_OPTC_INPUT_SPARE_REGISTER__OPTC_INPUT_SPARE_REG__SHIFT                                           0x0
>   #define ODM0_OPTC_INPUT_SPARE_REGISTER__OPTC_INPUT_SPARE_REG_MASK                                             0xFFFFFFFFL
> +//ODM0_OPTC_RSMU_UNDERFLOW
> +#define ODM0_OPTC_RSMU_UNDERFLOW__OPTC_RSMU_UNDERFLOW_INT_EN__SHIFT                                           0x0
> +#define ODM0_OPTC_RSMU_UNDERFLOW__OPTC_RSMU_UNDERFLOW_OCCURRED_STATUS__SHIFT                                  0x1
> +#define ODM0_OPTC_RSMU_UNDERFLOW__OPTC_RSMU_UNDERFLOW_INT_STATUS__SHIFT                                       0x2
> +#define ODM0_OPTC_RSMU_UNDERFLOW__OPTC_RSMU_UNDERFLOW_CLEAR__SHIFT                                            0x3
> +#define ODM0_OPTC_RSMU_UNDERFLOW__OPTC_RSMU_UNDERFLOW_INT_EN_MASK                                             0x00000001L
> +#define ODM0_OPTC_RSMU_UNDERFLOW__OPTC_RSMU_UNDERFLOW_OCCURRED_STATUS_MASK                                    0x00000002L
> +#define ODM0_OPTC_RSMU_UNDERFLOW__OPTC_RSMU_UNDERFLOW_INT_STATUS_MASK                                         0x00000004L
> +#define ODM0_OPTC_RSMU_UNDERFLOW__OPTC_RSMU_UNDERFLOW_CLEAR_MASK                                              0x00000008L
>   //ODM0_OPTC_UNDERFLOW_THRESHOLD
>   #define ODM0_OPTC_UNDERFLOW_THRESHOLD__OPTC_UNDERFLOW_THRESHOLD__SHIFT                                        0x0
>   #define ODM0_OPTC_UNDERFLOW_THRESHOLD__OPTC_UNDERFLOW_THRESHOLD_MASK                                          0x01FFFFFFL
> @@ -27388,6 +27397,15 @@
>   //ODM1_OPTC_INPUT_SPARE_REGISTER
>   #define ODM1_OPTC_INPUT_SPARE_REGISTER__OPTC_INPUT_SPARE_REG__SHIFT                                           0x0
>   #define ODM1_OPTC_INPUT_SPARE_REGISTER__OPTC_INPUT_SPARE_REG_MASK                                             0xFFFFFFFFL
> +//ODM1_OPTC_RSMU_UNDERFLOW
> +#define ODM1_OPTC_RSMU_UNDERFLOW__OPTC_RSMU_UNDERFLOW_INT_EN__SHIFT                                           0x0
> +#define ODM1_OPTC_RSMU_UNDERFLOW__OPTC_RSMU_UNDERFLOW_OCCURRED_STATUS__SHIFT                                  0x1
> +#define ODM1_OPTC_RSMU_UNDERFLOW__OPTC_RSMU_UNDERFLOW_INT_STATUS__SHIFT                                       0x2
> +#define ODM1_OPTC_RSMU_UNDERFLOW__OPTC_RSMU_UNDERFLOW_CLEAR__SHIFT                                            0x3
> +#define ODM1_OPTC_RSMU_UNDERFLOW__OPTC_RSMU_UNDERFLOW_INT_EN_MASK                                             0x00000001L
> +#define ODM1_OPTC_RSMU_UNDERFLOW__OPTC_RSMU_UNDERFLOW_OCCURRED_STATUS_MASK                                    0x00000002L
> +#define ODM1_OPTC_RSMU_UNDERFLOW__OPTC_RSMU_UNDERFLOW_INT_STATUS_MASK                                         0x00000004L
> +#define ODM1_OPTC_RSMU_UNDERFLOW__OPTC_RSMU_UNDERFLOW_CLEAR_MASK                                              0x00000008L
>   //ODM1_OPTC_UNDERFLOW_THRESHOLD
>   #define ODM1_OPTC_UNDERFLOW_THRESHOLD__OPTC_UNDERFLOW_THRESHOLD__SHIFT                                        0x0
>   #define ODM1_OPTC_UNDERFLOW_THRESHOLD__OPTC_UNDERFLOW_THRESHOLD_MASK                                          0x01FFFFFFL
> @@ -27450,6 +27468,15 @@
>   //ODM2_OPTC_INPUT_SPARE_REGISTER
>   #define ODM2_OPTC_INPUT_SPARE_REGISTER__OPTC_INPUT_SPARE_REG__SHIFT                                           0x0
>   #define ODM2_OPTC_INPUT_SPARE_REGISTER__OPTC_INPUT_SPARE_REG_MASK                                             0xFFFFFFFFL
> +//ODM2_OPTC_RSMU_UNDERFLOW
> +#define ODM2_OPTC_RSMU_UNDERFLOW__OPTC_RSMU_UNDERFLOW_INT_EN__SHIFT                                           0x0
> +#define ODM2_OPTC_RSMU_UNDERFLOW__OPTC_RSMU_UNDERFLOW_OCCURRED_STATUS__SHIFT                                  0x1
> +#define ODM2_OPTC_RSMU_UNDERFLOW__OPTC_RSMU_UNDERFLOW_INT_STATUS__SHIFT                                       0x2
> +#define ODM2_OPTC_RSMU_UNDERFLOW__OPTC_RSMU_UNDERFLOW_CLEAR__SHIFT                                            0x3
> +#define ODM2_OPTC_RSMU_UNDERFLOW__OPTC_RSMU_UNDERFLOW_INT_EN_MASK                                             0x00000001L
> +#define ODM2_OPTC_RSMU_UNDERFLOW__OPTC_RSMU_UNDERFLOW_OCCURRED_STATUS_MASK                                    0x00000002L
> +#define ODM2_OPTC_RSMU_UNDERFLOW__OPTC_RSMU_UNDERFLOW_INT_STATUS_MASK                                         0x00000004L
> +#define ODM2_OPTC_RSMU_UNDERFLOW__OPTC_RSMU_UNDERFLOW_CLEAR_MASK                                              0x00000008L
>   //ODM2_OPTC_UNDERFLOW_THRESHOLD
>   #define ODM2_OPTC_UNDERFLOW_THRESHOLD__OPTC_UNDERFLOW_THRESHOLD__SHIFT                                        0x0
>   #define ODM2_OPTC_UNDERFLOW_THRESHOLD__OPTC_UNDERFLOW_THRESHOLD_MASK                                          0x01FFFFFFL
> @@ -27512,6 +27539,15 @@
>   //ODM3_OPTC_INPUT_SPARE_REGISTER
>   #define ODM3_OPTC_INPUT_SPARE_REGISTER__OPTC_INPUT_SPARE_REG__SHIFT                                           0x0
>   #define ODM3_OPTC_INPUT_SPARE_REGISTER__OPTC_INPUT_SPARE_REG_MASK                                             0xFFFFFFFFL
> +//ODM3_OPTC_RSMU_UNDERFLOW
> +#define ODM3_OPTC_RSMU_UNDERFLOW__OPTC_RSMU_UNDERFLOW_INT_EN__SHIFT                                           0x0
> +#define ODM3_OPTC_RSMU_UNDERFLOW__OPTC_RSMU_UNDERFLOW_OCCURRED_STATUS__SHIFT                                  0x1
> +#define ODM3_OPTC_RSMU_UNDERFLOW__OPTC_RSMU_UNDERFLOW_INT_STATUS__SHIFT                                       0x2
> +#define ODM3_OPTC_RSMU_UNDERFLOW__OPTC_RSMU_UNDERFLOW_CLEAR__SHIFT                                            0x3
> +#define ODM3_OPTC_RSMU_UNDERFLOW__OPTC_RSMU_UNDERFLOW_INT_EN_MASK                                             0x00000001L
> +#define ODM3_OPTC_RSMU_UNDERFLOW__OPTC_RSMU_UNDERFLOW_OCCURRED_STATUS_MASK                                    0x00000002L
> +#define ODM3_OPTC_RSMU_UNDERFLOW__OPTC_RSMU_UNDERFLOW_INT_STATUS_MASK                                         0x00000004L
> +#define ODM3_OPTC_RSMU_UNDERFLOW__OPTC_RSMU_UNDERFLOW_CLEAR_MASK                                              0x00000008L
>   //ODM3_OPTC_UNDERFLOW_THRESHOLD
>   #define ODM3_OPTC_UNDERFLOW_THRESHOLD__OPTC_UNDERFLOW_THRESHOLD__SHIFT                                        0x0
>   #define ODM3_OPTC_UNDERFLOW_THRESHOLD__OPTC_UNDERFLOW_THRESHOLD_MASK                                          0x01FFFFFFL
