Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3873BD711D6
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Dec 2025 08:46:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C4E1810EC92;
	Fri, 19 Dec 2025 08:46:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Y6l947rz";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012052.outbound.protection.outlook.com
 [40.93.195.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF58910EC92
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Dec 2025 08:46:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MTFqP4RLH2BuQkXBjUakq6zbXvsUwH+83Afp5r8W6q2klmibLyvnnWi1m1P5042STnk4dkkqMj9bzP1RG1zmuTD9yBGRDDpXdbwV5qYxbp9qOAfHCEtjm9+HkfZN2lCIJqTqhimJAxNR1DuaH0glu35ngS13rRc37baGPYjLZDLxPyg4AFdGXNsAnG9Mz/gp83o18BG3OM0U9S7by3biJJxvKfNHxcmhq1JIxIaoH32WEBbOasRnQaasxkUrsDEc08bk6pBsxZ1NmkkBA+/2W2oP3nvoLvkhNmfnGkZ4w182KRHeck+3XSDOzNswGrn/Z4gef2HZZwsjIsw5ZiYoZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X7RobMoswP5S+RgJwhFGekxS0PkrIdlB8uHk3mnLxaI=;
 b=pzu3Tb1o/316tCfQ20mtlNhSKj/54kih90rFwxg8CWQTwgKhE1KDc+TjRSZ6fVe5CnTtxbRB5nddoSXNOdZ3XjGgp0TYDbmyKcHMo+/sWYOGZ2wKox2kSYC/9FZtWvS0fR6MLu6Yv+6YJ04D//yQlUpM45C1iBPh4EUdLYAhPNnoiGumx9xcysQJ4OGDBZrrA6LzLXuLJiuGhVNSD2GJf2CCyfT9fUaYnrgYykm362zAm8OJD9J932RREXUUrzYk7hNgoBJuZSVmKpqa3VumDCwzDyotCDHFwSt8Oj1GhUCPgUZUP5l26UjUmU9YtWcMfpcPqXThMYZfYGM8OGWibg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X7RobMoswP5S+RgJwhFGekxS0PkrIdlB8uHk3mnLxaI=;
 b=Y6l947rzbb0LieDyx4tawoQJIqXOtVtdvnej5BL0OpUB0FlaEE+86VL3e73eirRld2MAL9aFQ7jpEJD9mQTXFho8mtPcnRgr/y2t+wc1YvEnzrbRhZDXtyIga8bTsCI0aKzJS4CFVdtlXJ1ew8QmxYWVK1GFReUXgfaFxX/i2s0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH7PR12MB6833.namprd12.prod.outlook.com (2603:10b6:510:1af::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.9; Fri, 19 Dec
 2025 08:46:43 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.9434.009; Fri, 19 Dec 2025
 08:46:43 +0000
Message-ID: <93bbe391-7034-4f7d-9f99-6e6cf8e510f2@amd.com>
Date: Fri, 19 Dec 2025 09:46:40 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 5/5] drm/amdgpu/mes: Remove idr leftovers
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Alex Deucher <alexander.deucher@amd.com>
References: <20251218150405.80502-1-tvrtko.ursulin@igalia.com>
 <20251218150405.80502-6-tvrtko.ursulin@igalia.com>
 <164893d3-e8dd-4a39-998c-bdb7a328168d@amd.com>
 <6d84c467-f401-4460-8cf6-62c5fab341c3@igalia.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <6d84c467-f401-4460-8cf6-62c5fab341c3@igalia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0205.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:ad::27) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH7PR12MB6833:EE_
X-MS-Office365-Filtering-Correlation-Id: 0fd0c087-219f-41f2-29bc-08de3edb22ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aVRTZW1xSkluNnpSVzk2dUFyRWo4RHUxdzI3QzhBN0tESG5uT1NyMU9ySm45?=
 =?utf-8?B?MGhMUHBkNXhpeDRLUWU1YXBMSjhRY2hOOTZQRkxYQXlXbFJSOHY5Z2dzanFr?=
 =?utf-8?B?amkyWGNlcDFLNXhiVmpjNHhEYjNmemJMY0gwdUNQSzNKQ1UyWWhsOWFRSlFY?=
 =?utf-8?B?TDJMcmtoNEc2bGZHWk0vOHk5Y0lJRy91ZFp2T1NRU2FiMWkyajRNd0U0N3pU?=
 =?utf-8?B?VDVNVXJzUmU4MWxzOWRHTGdWaUMzcjR3QWFRTzZFalVRYTA2QkZ5TVExaytL?=
 =?utf-8?B?Z3ZsbnUwS1lyRzJncHlwRXcrT2xla0pJK2JJQ1ZZTi85anFYZVpzVUViS2gx?=
 =?utf-8?B?Tk15cDNlNjdnejRZcDlabWdOcWhtVC96OG5rbGlORUNmdUV0eFlWUU9wM3Bl?=
 =?utf-8?B?enU5THlyMWI0WGk5NExVc1pjcDVCeXJqL0dwdDRYbnVwbGRxMFl4UUgyeE9R?=
 =?utf-8?B?WUlEcll4VHd2QkowU3BtTWMwMUFVWXUyUXN6Rll5L2dVYjh0Ty84eDUybElr?=
 =?utf-8?B?WjJibXFWNUh5Z3hjNm1MK3VvdkI2OW9uTS9nWnUrZWdkK3FUSzRGR2E3TTlF?=
 =?utf-8?B?QW9FbWZZa25UYWg4SmZpaTJOSjYwQmxlUWxmdjZZZEN5azNvajY0dGVXaDJ4?=
 =?utf-8?B?TTNjWHExdTNBSkVqY2VlRm9OdmNkOWhPdVFFWURvZUx2TC9GKzhnblh5QTBU?=
 =?utf-8?B?eTNXdmNBVTlGTFYxWnNJWEFYbCsrRTZwemV5Rm8vZWxYYmNuNndNenJwU0hX?=
 =?utf-8?B?UUxSd1hXVis4dWh6WE5EeERuWnVvazl4dVBVMWxQMVZwdmRXU2lwYTVNbG0z?=
 =?utf-8?B?V2RpL2VCaUlnMHAyTUpmV2t3QmxXWm8wQnpkdFFmSDh3bWFCeUhLNGIvdFpl?=
 =?utf-8?B?aVo4bnA3WG1KbFNxcjVDTStFTU11enIzVHREUVFUNklxWjd4QnVwa2lhVGFQ?=
 =?utf-8?B?Z0UxK1ptbktBcXc0akdUM1VsVkNxdks5TklYVmNCZkJzU1Fya0FZRlJiUFJL?=
 =?utf-8?B?M242aTU4NTRhbzRXeVkzSDV3MXkxZDNsdDZyaVJjeC91OGRxM0xZR28wTjZO?=
 =?utf-8?B?akZoNlZURDdqQXpNZTBKTHI4cm40blZMMlMvaU9wRlJBK29zUFZGT2xoYXBY?=
 =?utf-8?B?eVAxamlqNmdMK2h0Zlg4RUhhbUpubHFHV0h6TkZ0bTJTZTBwVEVkOGZReG5v?=
 =?utf-8?B?cmN4MzB2YXY3Vk5hWjFOU2pNM1hybDRhT1BxK1Z5M2oxT0lwN0hEQmhNV0c3?=
 =?utf-8?B?YysxYWF4eGxKbmYxRkNuRlR4eGtHQ1VWTmVxNHhzOEZWL3lKK1lkeGpUUXpv?=
 =?utf-8?B?RFJPYUpsYWlmUndzb2dncUs2VncvUS92MzlzUXZVYXVkallXcWxCUktvOWNB?=
 =?utf-8?B?d0hoREtWMGJreStsYndtd3I0VTBxSmlrUXFGM0RZa0dJUFN4RGpnb0xJSkUr?=
 =?utf-8?B?VzF1NTBrSm9sSTViU1Z2R1dMRGhWOEVwclhxSWZCWFA5cnlIeG1YT0hXY0tz?=
 =?utf-8?B?dTd1dm91azZwM05KUkVETXdmZDdLNW1VQUFkOXRzYnFaOFRnTHlYb21EZkcx?=
 =?utf-8?B?N0d2TWFwUUtId0lwNCsyYUU3elBWRC83T2RXUHFwZVhZNzJWT3NjSXNYUW04?=
 =?utf-8?B?YkozdVBQZU42WWJVaXJqUXlYWXpCUkJqTXFBUmxPSWpZMnpETjZndXJyUGRW?=
 =?utf-8?B?VnlKN2xWczFoZkswdnBidXZrclBkOENiMnFqdVpLNUd4dUVaczhiSXR3SjlF?=
 =?utf-8?B?emEycmxLNnRJWU91WC9rSTlIZnFXTmt5MlpLbFNwMHJvbEVpcEFIU0VFNDQz?=
 =?utf-8?B?OFlxZkJkY0FuZTY4eXJNcWo5cTNUOW0yMGM5TnhHZHphMDEvSysxZkxrYXNZ?=
 =?utf-8?B?aGwwaytuVjRGcHZGUkxXV0kwYzM5MEhlbS8zR1pVc0dsZEFNYWErQ2xyVGF3?=
 =?utf-8?Q?8+FJLJsK3vlLeid8Gpy5e4k5lCrUHPA/?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YnN1UUdhSHhxSWZ1cXdHYWp5eVZMWHVoSXhqS3ZjTXhNZ1BNZlQ2WUZPU0FE?=
 =?utf-8?B?VmdoaUlrczhWNzUyOHQ0c1FjTlZ3QTdLdjk1MmtXN0llcDBNKzBpTGZIN1Fp?=
 =?utf-8?B?SUlrT2oza3pyOHovaE9IZ3pUeHoyVnFzZjdqcXkyVjdvY2E0bDZubHpPNWVj?=
 =?utf-8?B?NjZYVG5MVzU1ck5JTldWVzVEQkpxTEgwcjRlTmw5eExVbTkxRWZ5b2piOU5G?=
 =?utf-8?B?d1BvRXN2UjJkL0lUc1VZNDZoQUM0TFNvZSs0UWxrRUNWenA4YlBySUcrblhm?=
 =?utf-8?B?eGNTTlllaXVoSUFyN2NtaStNb1lvWUtDRDB2TGpESk5qZzNYTyt6eFBodU9B?=
 =?utf-8?B?aU8xZENna1l4cjhqQU5VY1I5dVNGUWdHNEVLMDFzL01WYnQvNHZ5c0prZU13?=
 =?utf-8?B?YklNVEJrbjJGZ0JtSnc0L3luQTVqL2FPYnloR1k1M3dSc0NnNWU0SDJDaTBE?=
 =?utf-8?B?blZVeW52WVhCWDh1bm83N2x6TVVsZ1h0WXU2RVA3eHJtRWRFYmVOZ1pjNDVl?=
 =?utf-8?B?M2l2ZTlEUjBjSlIraTlIT1lDcVc2VlREbXhmSSt3ZzkxcXk4THpuR0pLOFZr?=
 =?utf-8?B?TUVEZUdFMVZxZzlGM1pWT1Q1OEsyenlEYUV5QnJVUitLb1hhLy9mS0w0U0dx?=
 =?utf-8?B?YkN1Wk5HMUF5Z1VSUDA4UTI1enRObGRUeStSbmREWEZSem1QUitkcFN3dlE4?=
 =?utf-8?B?UWM4cFFqNkxqa09ZYXNscGU0SU1wWVF6ZFZXeHZsbWdxU2NEcE92eUtrenhW?=
 =?utf-8?B?K2x5RG0zdEpUMktITmFNMjIxdGxZRmhKRlhJWVZYVjZMSG5wK2lyOG40bkNJ?=
 =?utf-8?B?SU5TL3JEaFVSbDg2bjdBSlpYRFh2R0l0QTRNTktYa0ptS2pqdlRjY3p3d0dq?=
 =?utf-8?B?WC9wSUJWUFpBa0huNTArRDlBcitWb0dUYi9ndHZ6YnROcWVENEY0cWNERGNM?=
 =?utf-8?B?Wk84Yks2M3FqbkZDMW9MZjVpQVJEaFdZNU90cWhnUWlRRTFsY2dVY3VCTWV5?=
 =?utf-8?B?dlRGdms5U09XUDFlVmNZNnRhT0p3SEdBRFlFMERuWG4rWU12ZktEYXBrWUo1?=
 =?utf-8?B?UnNObjJ4UzFnZUxwRVk3d3pDS2JsVDA1MEJ6SVFkTjlLeHY4UVhXSEVQWkJX?=
 =?utf-8?B?L1hTdzFPZ2NQWDArMzZ4RUxxNHlPdG0rRzN2M3lTM3RvQ0E0dVpNcVZwcXk2?=
 =?utf-8?B?L1JEcEhFbytpeTZXdDdXZjduTUZKYnpzUjJwMkg3S250WUlCNmgzeWdpWStH?=
 =?utf-8?B?ZEo2RDVNaFNFQWVzZnhnMGlEQ1dxRlNvcU4vQm5tejNjekM0NzJXcThBUkRX?=
 =?utf-8?B?eXhELzFwZWlmTk9xNGJpZnFrWU1TWHJ1WUJjS0VMZHdhajZEcXJGWmUzbzYv?=
 =?utf-8?B?aiswNGpLclpicGlmRGFWd0V4Wk1YeGR3Sm8vdkVENzdlQ2V6R0xCUmJDT1Zo?=
 =?utf-8?B?bHIvMmV3NWtvZmFJVkpKSno1KzhMRGFkSjV2Q3Mva3hwZjhqbEtJTTVWN2ZY?=
 =?utf-8?B?R1UzNWJGREs2dWQxd2RBWEIzTjRMbi9sOG5OLzRWOW9wTDhaSXVHZmI5c2ZN?=
 =?utf-8?B?QTdncyt1OXEwei9sZ3ZvZ3lud01uS1dVY2RLY3U1YTROVXR3KzNxdWtaMzd5?=
 =?utf-8?B?VmVaaUFLTzBXM3ZudE5hVFlrcXBUWm1zeEpWZXdZOE43dWFQOUNINVQ3S2VM?=
 =?utf-8?B?aURrc0s1VXdIQnJUa0x2UHRaU0hmSXo0Y01sNmV4bHdYbjg0bWxnbjZTQk13?=
 =?utf-8?B?a2t4T3N5RjhNMjdFbmx1NmJaMHR3Y0Zaay9XOFJDbUMzZUVQU0ZHaGxSM0FM?=
 =?utf-8?B?NkkvTGJIYUZVYWIrWnBoOGlrc0t2QkUyQkdua1oxeWlRMTk1dFIzc3Z5UHVl?=
 =?utf-8?B?WGhRS2NNOGdURTBhMWFkOEdPZUdBaG9PZlBxY0VFZi9mWVVBWnZWd0RWNXZj?=
 =?utf-8?B?M3JUR3g0QjdnTWExOVl3QzJ4OFNMUHZneDN0Slh1V1d6UEt3UTNIUjdMOGpO?=
 =?utf-8?B?ejlmQUVGUG10dWI4RDA0NnVWT0xPMmxkUXQxZ2VlVFh1cVVLWENqZ1RPK2tv?=
 =?utf-8?B?U1AvRWtsaXZGT2lxT3gxZCtHYWowOXlOWWdWeEUzd2F6Vlc2aVBRVTlVeVBw?=
 =?utf-8?Q?9t0IB55SVcE0N4eARrUi2Z1F4?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fd0c087-219f-41f2-29bc-08de3edb22ca
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2025 08:46:43.7502 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xe6RWqaeFl5Svfl7dt1Ce8m2sMo7EMSsHlYnf0fR2/36xkwYtsZhBpLEC9G9YkeJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6833
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

On 12/19/25 09:39, Tvrtko Ursulin wrote:
> 
> On 19/12/2025 08:29, Christian König wrote:
>>
>>
>> On 12/18/25 16:04, Tvrtko Ursulin wrote:
>>> Commit
>>> cb17fff3a254 ("drm/amdgpu/mes: remove unused functions")
>>> removed most of the code using these IDRs but forgot to remove the struct
>>> members and init/destroy paths.
>>>
>>> There is also interrupt handling code in SDMA 5.0 and 5.2 which appears to
>>> be using it, but is is unreachable since nothing ever allocates the
>>> relevant IDR. We replace those with one time warnings just to avoid any
>>> functional difference, but it is also possible they should be removed.
>>>
>>> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
>>> References: cb17fff3a254 ("drm/amdgpu/mes: remove unused functions")
>>> Cc: Alex Deucher <alexander.deucher@amd.com>
>>
>> Reviewed-by: Christian König <christian.koenig@amd.com>
> 
> Thanks!
> 
> Do you think the drm_WARN_ON_ONCE's are worth keeping or I should remove that completely?

I wanted to discuss that with Alex after the holidays, but my gut feeling is it is superflous.

> I wasn't sure if there is a code path or not to enable the required condition:
> 
>  adev->enable_mes && (entry->src_data[0] & AMDGPU_FENCE_MES_QUEUE_FLAG))
> 
> If there is interrupts would get silently not processed. Although that is currently in the code as well. Maybe it is impossible?

Yeah that's not so much of a problem. At worst it will create a performance problem because we only check the fence after a timeout.

Regards,
Christian.

> 
> Regards,
> 
> Tvrtko
> 
>>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c |  9 ---------
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h |  3 ---
>>>   drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c  | 18 +++---------------
>>>   drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c  | 18 +++---------------
>>>   4 files changed, 6 insertions(+), 42 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
>>> index 9c182ce501af..505619d504ea 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
>>> @@ -94,9 +94,6 @@ int amdgpu_mes_init(struct amdgpu_device *adev)
>>>         adev->mes.adev = adev;
>>>   -    idr_init(&adev->mes.pasid_idr);
>>> -    idr_init(&adev->mes.gang_id_idr);
>>> -    idr_init(&adev->mes.queue_id_idr);
>>>       ida_init(&adev->mes.doorbell_ida);
>>>       spin_lock_init(&adev->mes.queue_id_lock);
>>>       mutex_init(&adev->mes.mutex_hidden);
>>> @@ -218,9 +215,6 @@ int amdgpu_mes_init(struct amdgpu_device *adev)
>>>                         adev->mes.query_status_fence_offs[i]);
>>>       }
>>>   -    idr_destroy(&adev->mes.pasid_idr);
>>> -    idr_destroy(&adev->mes.gang_id_idr);
>>> -    idr_destroy(&adev->mes.queue_id_idr);
>>>       ida_destroy(&adev->mes.doorbell_ida);
>>>       mutex_destroy(&adev->mes.mutex_hidden);
>>>       return r;
>>> @@ -248,9 +242,6 @@ void amdgpu_mes_fini(struct amdgpu_device *adev)
>>>         amdgpu_mes_doorbell_free(adev);
>>>   -    idr_destroy(&adev->mes.pasid_idr);
>>> -    idr_destroy(&adev->mes.gang_id_idr);
>>> -    idr_destroy(&adev->mes.queue_id_idr);
>>>       ida_destroy(&adev->mes.doorbell_ida);
>>>       mutex_destroy(&adev->mes.mutex_hidden);
>>>   }
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
>>> index e989225b354b..f45129277479 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
>>> @@ -68,9 +68,6 @@ struct amdgpu_mes {
>>>         struct mutex                    mutex_hidden;
>>>   -    struct idr                      pasid_idr;
>>> -    struct idr                      gang_id_idr;
>>> -    struct idr                      queue_id_idr;
>>>       struct ida                      doorbell_ida;
>>>         spinlock_t                      queue_id_lock;
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
>>> index 8ddc4df06a1f..ab9e6199b01d 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
>>> @@ -1704,24 +1704,12 @@ static int sdma_v5_0_process_trap_irq(struct amdgpu_device *adev,
>>>                         struct amdgpu_irq_src *source,
>>>                         struct amdgpu_iv_entry *entry)
>>>   {
>>> -    uint32_t mes_queue_id = entry->src_data[0];
>>> -
>>>       DRM_DEBUG("IH: SDMA trap\n");
>>>   -    if (adev->enable_mes && (mes_queue_id & AMDGPU_FENCE_MES_QUEUE_FLAG)) {
>>> -        struct amdgpu_mes_queue *queue;
>>> -
>>> -        mes_queue_id &= AMDGPU_FENCE_MES_QUEUE_ID_MASK;
>>> -
>>> -        spin_lock(&adev->mes.queue_id_lock);
>>> -        queue = idr_find(&adev->mes.queue_id_idr, mes_queue_id);
>>> -        if (queue) {
>>> -            DRM_DEBUG("process smda queue id = %d\n", mes_queue_id);
>>> -            amdgpu_fence_process(queue->ring);
>>> -        }
>>> -        spin_unlock(&adev->mes.queue_id_lock);
>>> +    if (drm_WARN_ON_ONCE(&adev->ddev,
>>> +                 adev->enable_mes &&
>>> +                 (entry->src_data[0] & AMDGPU_FENCE_MES_QUEUE_FLAG)))
>>>           return 0;
>>> -    }
>>>         switch (entry->client_id) {
>>>       case SOC15_IH_CLIENTID_SDMA0:
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
>>> index 51101b0aa2fa..4f78dd93939c 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
>>> @@ -1617,24 +1617,12 @@ static int sdma_v5_2_process_trap_irq(struct amdgpu_device *adev,
>>>                         struct amdgpu_irq_src *source,
>>>                         struct amdgpu_iv_entry *entry)
>>>   {
>>> -    uint32_t mes_queue_id = entry->src_data[0];
>>> -
>>>       DRM_DEBUG("IH: SDMA trap\n");
>>>   -    if (adev->enable_mes && (mes_queue_id & AMDGPU_FENCE_MES_QUEUE_FLAG)) {
>>> -        struct amdgpu_mes_queue *queue;
>>> -
>>> -        mes_queue_id &= AMDGPU_FENCE_MES_QUEUE_ID_MASK;
>>> -
>>> -        spin_lock(&adev->mes.queue_id_lock);
>>> -        queue = idr_find(&adev->mes.queue_id_idr, mes_queue_id);
>>> -        if (queue) {
>>> -            DRM_DEBUG("process smda queue id = %d\n", mes_queue_id);
>>> -            amdgpu_fence_process(queue->ring);
>>> -        }
>>> -        spin_unlock(&adev->mes.queue_id_lock);
>>> +    if (drm_WARN_ON_ONCE(&adev->ddev,
>>> +                 adev->enable_mes &&
>>> +                 (entry->src_data[0] & AMDGPU_FENCE_MES_QUEUE_FLAG)))
>>>           return 0;
>>> -    }
>>>         switch (entry->client_id) {
>>>       case SOC15_IH_CLIENTID_SDMA0:
>>
> 

