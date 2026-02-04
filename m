Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDDE1E95375
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Feb 2026 10:30:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8BCB410E5B8;
	Wed,  4 Feb 2026 10:30:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Syxz0hqY";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012048.outbound.protection.outlook.com
 [40.93.195.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EFB5010E5B8
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Feb 2026 10:30:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q14MTj+ULA1AvkkbCM/KelH/m4tKcNhOstyXU1UDsoqfA5GTdIa4Od4lA8smAgTZ4emTu+kCKLJ8M1EBx+fWLHSsCa0P9/hVpUNmPd24OcNVB+7s2ZwdgGEopR2JF8+Vs+qP+2hs1mkTlxKWQ5qBLhO73KIIbqP5iGiS7zRGuVwJkLkBXE/z6sYgd0lA2gvup2aq74W66vuAgAGPrb5uEtQcjZXXBtoNCjiMfd+uaoTYx3IsfyDOqXmt86XM6+KeGPnvgWKtCy28QxUII1BJWPg/nGIjQVQjV9q1ykauhgCBiw888bYCNfZ/XjweDWmDHW9lxXUSMDcffRmhAmMI2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qteseZAn+qXGt0FeYnbQcDB1YIZqPxwqswErD9UQ0WQ=;
 b=qjjCn7HGaR4BpUcDFPuQJm6fivQu8CB4yd924yHzsFzJGppB4GsHy2hErW6nymIVXD37cw5dxJwb+CRg4WKo7arZ1dR2pm0JsFSI1df3kr1ucpnMrpYMYNqG2nrQHr2V7up+6jDV1gOAHx1ttjojJe5//hFk744Os8DxNPdv9ICTaUj0jMUuqM/kJeE5SVqacQbTfgY99LakC0t6MQGWt2lHkhfZB0Rpto1IzPqs3UlUUWD5YoX9oWbw9qzj1uKoXs2cSehlNpGEHwg+0zwnGkPv14WyAI88XXCelHUwaImtVcnyMdrLAPfZnoluWuZiIbGv36pwd8IAyeuFo5u/Sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qteseZAn+qXGt0FeYnbQcDB1YIZqPxwqswErD9UQ0WQ=;
 b=Syxz0hqY2ioyehnf9035kNPqeA+4YbHlv+ouM2s9T9R79Z9Jh3Vv7dKkeXtSM6frb13kJsEuRwB4FeH0mj/W1RzOYCt0l9IwcBUd2cWtxc+czKo8VEPWr+TwSmK6AXUPcuve/iQlXmL6SY+puprEB1CkO6xAgni1LOJdDKQ+BNQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SN7PR12MB6885.namprd12.prod.outlook.com (2603:10b6:806:263::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Wed, 4 Feb
 2026 10:30:24 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9587.010; Wed, 4 Feb 2026
 10:30:24 +0000
Message-ID: <6cc26bc6-1ca9-4d6c-838c-08f8b7b17a36@amd.com>
Date: Wed, 4 Feb 2026 11:30:20 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] drm/amdgpu: clean up the amdgpu_cs_parser_bos
To: Sunil Khatri <sunil.khatri@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org, kernel test robot <lkp@intel.com>,
 Dan Carpenter <dan.carpenter@linaro.org>
References: <20260204093410.2566700-1-sunil.khatri@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260204093410.2566700-1-sunil.khatri@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN0PR03CA0028.namprd03.prod.outlook.com
 (2603:10b6:408:e6::33) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SN7PR12MB6885:EE_
X-MS-Office365-Filtering-Correlation-Id: 44864d53-657a-45cd-055a-08de63d86818
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NElCeHdJOXQ5MFRnRVA0WE5wZVo3VGFiUHUzKzg2SlhubmozY3EvYnRaYWZ4?=
 =?utf-8?B?c1hSRGU1Q1h6ZmtYb2pNTWY4NXlUeDJwaHRLa2d3MDRlOGV0ZU45b3dCVXZJ?=
 =?utf-8?B?QjdCS1hMOXZEbG5jRE96N3RVU3cvQzJZV0JHZHVKWGVrQkpCTURsQW5tWXJZ?=
 =?utf-8?B?V2hFaEN1RFNQUERGY0IvcllaU3QrTVZYRTZ4MDQzZ0FUSU9wdGhiYlRjSmtX?=
 =?utf-8?B?YUV1NndMd0tjcDh0ZTN5UkwxenpvSGRHUVFYS3Ywenh3M0NsdlZnaHVSV2xy?=
 =?utf-8?B?ZHRSTnM3ZWJBWW9FZmU4N0VjbEhlZFR4NG5OYUltdnRiaUFuRUMyeE1ZeVRi?=
 =?utf-8?B?QjdHVmFoMkxTMFNhNkgzWmZ4OXdTK1lMTTl0c2gxL3o3YzVXd2thSVMxVEI4?=
 =?utf-8?B?ZnFNT0hQWlBSQlhqZU9NODEvYmpNb2VXeFIxUlRMNVQ1MGJsMGlOczlXcEda?=
 =?utf-8?B?L0d5SEl3UTRnYnVma0Q4a0dEQmV4d2ZSWHVpbWZaMFg4SS9JSG1HMEFyejdy?=
 =?utf-8?B?bWpzZE1WQ0srM0JXODBPN2FhY1NsM0hxaE82SjlwZC9WQXk3Z3d2bXRaRGQr?=
 =?utf-8?B?Z0p6cmhYOEluRkR3RG1ZRVFIakhCVk4rdzRRRm5xdi9VV3UwZ0xmNkpFM3RH?=
 =?utf-8?B?N3UwS1ZwUWhTQ2k4S28yOU1sbHJjdlRMQUVOMkdkNlVHdVFFeXNzUndmaDFT?=
 =?utf-8?B?VmF4TFNHd1pxV0Y4S3U0S3JzanpXM3hYeTRtZXVIRFh0ajJjUFhhaXpQWGd5?=
 =?utf-8?B?RnVnblF1N0lVYzM3ZGUybGdpdkdCUWlyVlQ4YkRLRXdjUlJScGxvVzZQMytt?=
 =?utf-8?B?WlVFcDFmMEVicGM3dWMrWnI0UGthcmQwTUwwS3VTT3h5UnI0VWlpWWNwMTdS?=
 =?utf-8?B?WkNsN3pCNG5NemdTaStDd1FlbXptTVhGRnN3ZmRQK1dqNENkZWkxcmdqZWNZ?=
 =?utf-8?B?dkp6dFdMV1VDQnBoSVF1V3RBVC9scUNkZW03OU5rQ2VZL1NJVFBXTVR0aWFk?=
 =?utf-8?B?UXlycTJHSTlwUVlPMFVxUWtIR1ZGZFZydVBmL3hJVXZEK09FUjROOXBLbEVT?=
 =?utf-8?B?ek1JOXREZEJSSWhsSFdKR1E1a2M2RVRkNlVIa28yQlVsMnBVb1FmdTFRUDNV?=
 =?utf-8?B?eE9lTm05YWdLdmpyUWVLVDN5bXJRb1dKeUR1TTBPaENyTXhsbVJhMHRoWUdl?=
 =?utf-8?B?b3JJWGNhakkyNGpjWERhN2VPbGd6cFgycjU5WHM4OXBuSzJQa0I3V0FjVWxI?=
 =?utf-8?B?QndxczlJRVFaaE0xbmZUeU94UGRXbDEyWjJ4cHMxdjZscXBNRCtlbHZKU2dy?=
 =?utf-8?B?cWdybHYvRlI4VmVLcW94d3FOZUdUV2haKy83TWwvQkU0NkJhNGVDRGkycDRC?=
 =?utf-8?B?d0FzRjQ3K3liNE5kditvSUJrY0lzVlFaZzV1OWdEZGMxRER0U2UwYkJsUVVz?=
 =?utf-8?B?Y3lOaGRMdzJIOThqZ3RFVjYvdllTUm9JdEJsRGd6UGFWdy9QYU9VREoyZnN4?=
 =?utf-8?B?dlpNN2ZaUDUrN3NBKzlwRHB6WjhXL0VaWHFQQVAxY3M1bktwMy9hSnAzMmJX?=
 =?utf-8?B?aTB4N2xZRU9ZM0M4WnVHR2ZMb01MdkR6TXRHNHNzQlBJeVo4TnBSbWIyWnRK?=
 =?utf-8?B?eUhlVjMzQnJQbEJHSFJHb0tmTDlvZ3I1LzYxRGdyTlp5dUZaQXZZWXNnTE9y?=
 =?utf-8?B?WFJOUVhzOTR5S0VvRTM0Sk5JR3pEaVM5bXlSUXNtQ3VWaDIyNGFmNTBFbUNP?=
 =?utf-8?B?RlpHMUNKSkxFWjJ6bWNwUnhRcHRHSzhLUkhkV3AwQXc4UThRMEZabWVtS3Ev?=
 =?utf-8?B?M2pJM1hzcHZTZUVGaGMvaFladXUyb1JSeXo1SWpZdERwOS9yWUZzRzBITFEx?=
 =?utf-8?B?Yk83Vms4S1lQcTVXUkNWTTZBUjYwY3liRFdWMGZocXlVQjJXRkE5MUZCZnd3?=
 =?utf-8?B?VHBXOUo0NzRMRmJqejcrbkVXWVV3TWFzV1JJQW5QNWZkZGM1QXcyakswZXBE?=
 =?utf-8?B?dEZhUzNGelZ5SFU0dTN4bnN6QUhXL1pBcldtS0JTenRUQWxuN3Z0UG9Sd0RC?=
 =?utf-8?B?blJveTUyZ2VDcFdWSVIrMmx1VjdaNW1GVnptZkMxRnNENDNXN0RVeVp1OVdy?=
 =?utf-8?Q?gbmhehBCVzMycKTBf8Ld9tfRd?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QUdsaEYzNEN2WU1XK0Y1VXYycEdINFRGdUh1WWltVGlHenZiZ0R3Z1FjeGdz?=
 =?utf-8?B?YWRFcUplb1U4dllFQ2JtajYyUzlZU2RuRjIxTzVHNE9ubGJlY0JyWWdxWGY4?=
 =?utf-8?B?cVM1VEphYkY2VitnMCt1QnNha3hvYmRDZXczOEl2OHFnUk5yOUpjazFOVjNE?=
 =?utf-8?B?dDVkZHhZRjlXaWxsNFdvejhBRG5KK3BmQVJpMkZBK2hGYnRlb3V2dnJvYk9a?=
 =?utf-8?B?L0hvSUE3ODBYZnNySGd5YkcvNWlUQllPcEZYS3MvMXJTYVJ2Tm1vS0VZMGts?=
 =?utf-8?B?VmVmVGlpb0VIQjFFU2JLaW0zOUI5K0VqY2N6aFN3UkJaSlg3NlRsUXhFeU9T?=
 =?utf-8?B?OW5GVGJ3VWYwMHY1aXlLaCtqeGlyQjRsS01KakVpNHlDMDBTcEFnN3FJVzBC?=
 =?utf-8?B?RmVybEg4Y3dXL2NWdHFkSGRsR1NuTEJWTittMm5aTC9yWWl1ZnVBWUMrcHhz?=
 =?utf-8?B?M1VkQnlrbDd6Zkt6REczS00rS2l0c1JidnZ3d3hVMEVjazVwMGQ3dVdkcVE4?=
 =?utf-8?B?TmtKVndwcWJVMXhVRytvczJSNmVvM2NRcEUzcWYzdURJTXhiQzZYbWRwOEFO?=
 =?utf-8?B?ZXgrazdJNmhabW12aHY3WmZ5Um0vYkJEOTJlQzBaeHIzS1VFb1FPbVVCUzBr?=
 =?utf-8?B?bEk0eTRKZEFIbnVmV1Q5cWQ0eXJwR3dxK2dSTUdPVjNLZ09sMjVpZXdOYVU5?=
 =?utf-8?B?bThDTGVQYWFtU1g3R29BSnpGZnppeUhNQ0ZLSDBjUmRtZnYyTUlJUXhVZ0N2?=
 =?utf-8?B?WVNweVRKSFpyc2wweFd4VFpObDFMZ3RYamhDSnlzclRJN1VvVXlPZWhaZkRN?=
 =?utf-8?B?SS9DclRsUFhVRzllRlNyVnJON0l6eDFUcVNEUTdRZVZmcFRrc0N1aEQ5ZjJn?=
 =?utf-8?B?UHAzYlpyVUJOc2dZdVdBOVU4SHNRT1llUHNhc1ExSjlsTkdzT3k5S0h6NWJC?=
 =?utf-8?B?LzkrdXdUU0o4UTNtSEhYUzZCenlLWVlTY1l0Z3JlMFE1UGRuZU44YVhLbHBm?=
 =?utf-8?B?WFo3UFBTNXIwbUxxVmszT0lXTzFrbmtoWGdHRGdMdmovOG9YckpFZ1FKMDdv?=
 =?utf-8?B?ckJ2c1M2eDlacDRtbzNBOG42T0kzZVViMHdPWlhkeDlkTlZQdWpjMzZLKyts?=
 =?utf-8?B?NnVyZndZN016YitNeEFPVVRIZ0dtNERQcndlUkNiNXpiNlpHTTBuekx1aHFm?=
 =?utf-8?B?cjZEalRGczdENFdjckJweGhkb1hDRWZ3WHhJNGxXKzBDMzA1amxXT2NIRDJX?=
 =?utf-8?B?T1JrY0NpeUFtQTJOVnJ4RTArV0NmQURobVRJRURBaEVqSnRRc3pqSEZMV01N?=
 =?utf-8?B?d3RFRkhTTnVoc0xSTVBYVHhTZXVYbklDRWc5Z3RGZXg4TmhwVjhhQ3pYS3dl?=
 =?utf-8?B?LzVtcGdMUmhsb2ppbFoxK0MwcWZqZHZ0Y3hMbDFNT3RnT2dRaUdERDllSERV?=
 =?utf-8?B?dUtzWnVRYUVLQk9jL2xodW0veThqczMzMXgwRWZ5emZobXFXWXZIYlMrR1g3?=
 =?utf-8?B?N3Rqanp6MDVkVHlUclladUFxeisvVDlQTGdWWjc4WjZ3Y2FPYzN2elk5SjU4?=
 =?utf-8?B?Z1cyK0JEM0NCa2hENGxGV1JlVFh2SER1TXNMNG1ERkFZMExjVzgrcXQ5Skhn?=
 =?utf-8?B?czdBakpzMGZtUkpRWVlqbldlbkpUM3lja24xNDRWM2NuWlZzU0NhTUtPQUs2?=
 =?utf-8?B?cDFsdzd0NE1HUndDeS9CakZxVUh2dlB0NEwrVWFBT0R0WE9RTVNoRk1veDFh?=
 =?utf-8?B?ampLRTVIL2w4dDRWb2RUVDg1b2Mwd0RvMHZhQ2RuUXJJbXJ2c0FXczl4R1lB?=
 =?utf-8?B?L3dPQ1dEUWpFVWNjeXBva1JZS3ZLS0Qva1A1TklWZVhlcDNBTVpLd0tEU3Rn?=
 =?utf-8?B?N2pDaXNqTXhPZVZOdDJxL3JLTnJVTUU3TUk0QTQyMGJCZWtDLzdYU25EQUFG?=
 =?utf-8?B?bTMyL2MzU1UvQlZDejhkVWVPd3FQQkg5bk1kTU85c093UkRtclhwaERjSFd1?=
 =?utf-8?B?YVg3NnpJYW13WDlsWFgvaExFOWtTRnJKbkRzNGtDZzZUcGErRG9XazEvSm9P?=
 =?utf-8?B?R0ZhN0F4WmRpQUZJQ2JHM1MrS1o1Q3hXenJJTW1uQnMyOWp3Y3dYR0Qyb2tS?=
 =?utf-8?B?UHQ1UjcwcGcwKzV0M1oyL1ZUNjE1ZWUzbVBFK0l2VGprYW00ZEdGdHFiN1Ru?=
 =?utf-8?B?UlJJOXBWWndNd3JtMEJQcktSekRlckRkcll6c2RTWWZaUUtQVXQvZVBrM2d1?=
 =?utf-8?B?SEpmdHVwV3U0dlptZUhjM0JjU1ZDNDFjNjVlODVtY2xmMWhqR1JZNmxKTmNi?=
 =?utf-8?Q?9JjweV1ghgtAwn/IZe?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44864d53-657a-45cd-055a-08de63d86818
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2026 10:30:24.5533 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HAMmMZ0EeOikp/Hlbw249OMFEUA+Ji89vF6cie0QTu3Zx1D8MWw7S1JMHrrq5Pja
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6885
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

On 2/4/26 10:34, Sunil Khatri wrote:
> In low memory conditions, kmalloc can fail. In such conditions
> unlock the mutex for a clean exit.
> 
> We do not need to amdgpu_bo_list_put as it's been handled in the
> amdgpu_cs_parser_fini.
> 
> Fixes: 737da5363cc0 ("drm/amdgpu: update the functions to use amdgpu version of hmm")
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Closes: https://lore.kernel.org/r/202602030017.7E0xShmH-lkp@intel.com/
> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> index d591dce0f3b3..f3b5bcdbf2ae 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> @@ -892,8 +892,10 @@ static int amdgpu_cs_parser_bos(struct amdgpu_cs_parser *p,
>  		struct amdgpu_bo *bo = e->bo;
>  
>  		e->range = amdgpu_hmm_range_alloc(NULL);
> -		if (unlikely(!e->range))
> -			return -ENOMEM;
> +		if (unlikely(!e->range)) {
> +			r = -ENOMEM;
> +			goto out_free_user_pages;
> +		}
>  
>  		r = amdgpu_ttm_tt_get_user_pages(bo, e->range);
>  		if (r)

