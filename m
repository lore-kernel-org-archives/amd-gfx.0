Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 110D4C282EC
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Mar 2025 14:43:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AB0B510EA01;
	Fri, 14 Mar 2025 14:43:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="h891Xmzg";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2087.outbound.protection.outlook.com [40.107.96.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0F5C510EA01
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Mar 2025 14:43:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PUNEgyhAkE61Xu7KhJBryiXcWsTgyRIPpMWkMLQde0ft0dK6bA1buFzZ7tGn49FynldETUkLVsfNA1yEfbmeUPNWi5wZyJeyi0c1DsnvO0KcXN2DC9eCgjiTcur+lFWv23mNMWGP7KdOQqo/C6ElIVoyXoje7n32tIMAfLiZ32LUaS7IluI6UL9PYwCYrkKxcM7Gq5kx3XWE0cr+2s4He0b0nZ+To8YcQXEja51OrsgjYpgzvOUnTYgmmIam1nlXipUxEW+nVg7q9bw8rJXb9plmBAvjSXOb+uP+lywkZeOFhAT63csRH5DSWeEEB2k28bT/86Kk4H/mYnkQA3yPtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GhvkG3SscAS/y5seGY7ILe2JtTjCzSVDtTfNjKmYo/k=;
 b=ok7jTPE/yBn6eYPP6qRXSicJbx5Q7IhP9f7BH8aAGWPDKZZ+wWZFvxHY0TsCcHqfxXH4NLUSkK2EhRPCAut2LHXikOZjGtWBPcBZIcNLeM1hfBge4Ft/OF1YWD4uHZhwMMgkF12Q6iqhJnKgSnmoCX7FdoZTlNHnyvzUUtSqemtpuyKNXVbtysiJO6xARiVFuCh8W/MfWWBe9P1Da9Kk3IY/hVc29kBrInHa6otM/ahe2VoIw76X8qJbXfyE/yuq6/U/gMXKzR4L2zMXrt0GAuPxM4otQWHq9f1s4ThB0dzPk5oMfGBQsbb9inGw6SdEMhVe0IjHe+nxOyjG1UpkwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GhvkG3SscAS/y5seGY7ILe2JtTjCzSVDtTfNjKmYo/k=;
 b=h891XmzgfilLTxSfSPhfIeMvFnCGVPPJ4XXK/RImq0WY2HHJAclzigArDdIzlukhfMjzIRVmj9TQKuc+Kzt06Y+JqigBAzPHeU+hir0uQxv2yNG9GwU0lRMMD4u+WzYkMc5p530ntcowhCzLHubiHhsUM8ke84LCTFTmMisuHnU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 CY5PR12MB6478.namprd12.prod.outlook.com (2603:10b6:930:35::19) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.28; Fri, 14 Mar 2025 14:43:47 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%5]) with mapi id 15.20.8511.026; Fri, 14 Mar 2025
 14:43:47 +0000
Message-ID: <bc45f314-3720-49c3-a836-b409f8b89595@amd.com>
Date: Fri, 14 Mar 2025 20:13:41 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/amdgpu/gfx: adjust workload profile handling
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20250314134707.3012124-1-alexander.deucher@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20250314134707.3012124-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0129.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:bf::8) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|CY5PR12MB6478:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ee5d40e-d108-42de-f6ec-08dd6306a053
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SWFsSzlhclhxN2E1bW5VaW5lVW5OSkxIYUNXSGZDM3psTlBZUVg5Q0NCYnZX?=
 =?utf-8?B?aEIyS3VNNWs2cDNFUUNvbDBMalVKU3IrTEFBY053c2hnd2pIK1N4TnAvVUtq?=
 =?utf-8?B?dldkMWMwdklLN2Z3aE00TmpiNnJKakZqZWM4aW1hazhNQUJzTyswcldKRmM0?=
 =?utf-8?B?MmUwazJCeHlXMUxzazdESUs1cnVyY0RzRkRSVytBOWNtemFIcE1UbmtLcUlU?=
 =?utf-8?B?VmFiRGVuOGQ3Q0JaUjlDdUEwWEIwYy9PbndMaDF1ZE9vT3pDSnNWeko2cndN?=
 =?utf-8?B?S2FNUzBwQ09QbGhMZ29LcS9jZjJUMW95V3ZKVDI5aHd5NHc5eDVvWCtpRU5J?=
 =?utf-8?B?L2dWdStPdGdVRGpOdzN0WFVvLzNxNlhjbHFxcFRCYTc4aW9BeG94MmZRNWZH?=
 =?utf-8?B?UDNCWmk0L0R1N1pZK0xJN2haUnNLRDRpaEFqSXYxOElRUmQ5TllKVWhSQ2tM?=
 =?utf-8?B?cWxHNDlmcGYyZUI2Tm1tZndPQ01CUHFVK05tbUxscU9HQlV6c082QlZmSDlX?=
 =?utf-8?B?ZFZsL3l4TGNwWFhUbm54T2thVHM3RjlBN0wxdDJ4YTV3cE14cXlSUFVLNDVj?=
 =?utf-8?B?M0Vpa2RxN0QvT3lNTlg0OThiR1pNRWNQbEx1WWo0NUp3ZmtuSExSd1BnRWh0?=
 =?utf-8?B?WWJKcTlFWFhuOWN6QWVTTGNtUjBWbWord0FNb3plcFZlV0kvRW5iWUE4ZnVj?=
 =?utf-8?B?T3l1ZTdPZTRUVGpsMXlHUHVBMXl0UDZhOHVKQ0pYQUlTRlhaU0RxQmYwbXBM?=
 =?utf-8?B?WWJnaEN2ZTMzMExxZi8yQ0RTbW9SYzcwdCtzdlNsalpVdEJiMjNyeTZPeEZ3?=
 =?utf-8?B?NitSVjhjVzNYTFB1OFlHeWwwVUlVYzgzY1FGRDhSQXorRDhPb2ZLVUkxdDdz?=
 =?utf-8?B?UHc4MlR3UlVEWk5kQzlCTXlQL1FuMzMvWnFENWZhWmFHVVpZc3BTUzdYQVdt?=
 =?utf-8?B?OEY2NlVRNW1NMEhGWjg4bk85K3dUM25Wcm83U3hHYlpTekkyeXhHeG5PaXl6?=
 =?utf-8?B?QXNKaGVrUDA2SVpkak1oMlNyQ2FaUm5ucHBZeHNoVTVNMmNBMHZhVXdnTTNL?=
 =?utf-8?B?U1ZZTnE1a1B4QWdGWEw2ZmR0OUppckEwdlA5Qi9oTkc1aW9nQ2o1MVpwZ1pK?=
 =?utf-8?B?ZG0rNEFORjFRWk5UM3ZpSHBYNTVPQVIzcUVtSWg2UXNsbUh4TmlpczJkb1d1?=
 =?utf-8?B?OHZmY0c3Z1JVSVN1bkh4Q0Y3RUtTYk1PUlFRT3JBSTMvSW5SZUcyZmNNK3hZ?=
 =?utf-8?B?dTBxRFFaUGV3QkxDZnBBRHViem1LSXFrenB2RGtMT2U0VW45dlRTSzJLWFZL?=
 =?utf-8?B?UG40anVrWEVMYU8xcDE0ZXZKTThtNFN1R0VzM1IyY0lncHhSeVpUcXZ6TFVi?=
 =?utf-8?B?YUFTQUg4UHFZR0JwVTVaZ2xrMmwwMURsam9Pei94RTZvaDByWmp2SjFnTHJ6?=
 =?utf-8?B?cWY0dkQzSkpSUVZnZHVaUitkWC9lbEJKZEV3dGJIMmhBZTFUMkZBM3kwSGZl?=
 =?utf-8?B?bVU1bHlMYU54ZXJxMHV6bGtrL0IwN2VpTS9nUjUzOEk5WStic1BxcWxYWHFs?=
 =?utf-8?B?YWZtMkdYTi9UR2xSZVhsZWF4Rzd5SnliUWdZOUZMMlBZdUswM0prUjNwNlBi?=
 =?utf-8?B?b2hrZ2YzMEdhcGo1NnJWS01zenB2U0NTMGxwM00xVG1LZHhDalBxTjdFOVVW?=
 =?utf-8?B?TzBmeXo5aDRsWlRSNkNreE9WaGcxMUwyR1IzRkRZUzhvNEp4TkZ0MzFKelRz?=
 =?utf-8?B?YTRiR3hMTDhXdDYxVDhSbHMzdUhOUllrbWFaQkgwazlqZXdZNmhPTU1qM0Np?=
 =?utf-8?B?YkRDcDIwc3VhMXlCZG9saGJ0Z3BEU0dSRktTblpkbVBNQTNhZFBhN3FKUkRX?=
 =?utf-8?Q?xgv9JE7i57HE3?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MzRiR09lMVVMVGxSZ2F0akFzYUMwQUNOaktVcUpFVks5YldpNmJvL1ZrSFFo?=
 =?utf-8?B?TEZoaWZmbjAwWVFTbmdBZVVUaHhWQkxMY2oxNjBrSklJa3hCcVRlWTBuT293?=
 =?utf-8?B?VjI4enZZejhrUGF3eUJqUWg4RVFVdUVxVUYzZVZnMmtReThwYkRLejVLQjFF?=
 =?utf-8?B?ZWw3ZkJNU3JhTVl6Z3ZhVVp5U1RHaFZhdmlXV1l0aWpUN2Y3TU5xU08wWm5y?=
 =?utf-8?B?OW1BZDZsa01HSTVBajVCdld3QzgxakJJMCtJYW43dTM0TnIxOEZBbFgwTTRm?=
 =?utf-8?B?VzFJU0dXUGJEdHVzVzJCWWtYN3FsdCtOYXJzQmJOYWdCRWhEWklUMWlSUmZE?=
 =?utf-8?B?eWd5K2ZrSWlMZkViQnFLRXNYOUFrczYvLzMvbWRiSDN1cVR4cEpjR1RpMWNE?=
 =?utf-8?B?ckFsWW5MS3BoZEZQOHpnNXhORkVIS2h2ZEJaOEFyUFlRM25NeWdqZC9vaVdX?=
 =?utf-8?B?WE5FMVREcjE2dUVtMmhlS2hnS3NvWU5yT3hTaDlHd3dySzBKU2xLWGRKVjlD?=
 =?utf-8?B?K0FxY3crNUhOQ210bVlIbFlIdzNvWkJnSTQvNFN3ZHBuVkY3UllncS8xeUUw?=
 =?utf-8?B?bnZFNWNSSENYK2hmNnBYVWFxVVlZZXF4aklqeERsZkg0MXBPRVBkeWxmZHhZ?=
 =?utf-8?B?Nzg1RHFmayt3SzhMV3dnOG51OVpjMnREUzA5VGQrMDZ5dTZTakpPaDRzRHpo?=
 =?utf-8?B?UTZxcGZBN29ybTAweTFoZzU5cjlHM3JpNXZnY0sxOVBPV0JoNE5MR2J1eXoy?=
 =?utf-8?B?QVRmWTFuTU9IcmhIMjR1WGxxM0FWWGxydlp0QTQ2Q05oSW41R0FMY1E1LzUv?=
 =?utf-8?B?Ylg5L0hnem1nd09yY25QbzhOLzl1bHhOM2Y3a1VlMDlWSUdrby93QklQMmVG?=
 =?utf-8?B?SjJoSGU5cndlUHVyQXRrLzFCSGNZNTZuWkoyQTdqYXJoQ2RoNXJTekhKK3Ja?=
 =?utf-8?B?OWNFc1JLdXhzMm5uMHB0VE03U1d3Vjg2dW1keC9neW1FelZRQjE4ZjRKNndU?=
 =?utf-8?B?QzF1S2FGSitxYXkvNDhkTW96M1RUNzA2cEx6cXZwYUxHREZkL1RteGVaTjRl?=
 =?utf-8?B?bzlmRjZiTFViTFkyT1dnL1BBeTlub0tmUU1yalpobHk4ODcwZUFicnlGakhu?=
 =?utf-8?B?RnpGMjJCaS9GVVVvcFZDOW9lc0M1akQ3UUllK1lqdGFXMzc2dGlWOEtTNWto?=
 =?utf-8?B?YmROeGF1VDJkYUExbWtkV29yRVhYbmt0bGhubjJXTlVjRHJ2M0NpS04wa1dh?=
 =?utf-8?B?aUhYT0NtZFFCZEpOb1g1eTNKWHZ4cVpKUjk3T0ptRHErZWdsbUdvVEpuY005?=
 =?utf-8?B?M0ZZaGlLcUlRakI4VmtUMEpQOXZqZWJrYXptS0dxR3kwR0hiTDVYbnJXZXRN?=
 =?utf-8?B?d0xRNEY1eEgzTEVOekZBYjFCVHVCUmw3TGg3K2xQQ1F5OXd2OTBUNUFzVzRX?=
 =?utf-8?B?ZjN6RTJGbjNPby9QQTJ1TUxjdEc2Z1ZJWXQ5OWpZemRQT0FhV0RPSmViUUdY?=
 =?utf-8?B?c0g0V3R0UXdvQkpzM1BkMnlZdGpRUzdUaHRESlh3TWRjM0RnOU40SnBQTEhF?=
 =?utf-8?B?a3kwNXBzWTVoU0FEbGNNZkp6Mkg2emk4ZHBPVldKOXlZeFVQQWpsZnh1cG80?=
 =?utf-8?B?dGluK053UFBnVnlNbWZhZ0lBejhEZmtLNGVOMTh1K0kyR2tXelI2ZTYyUnlD?=
 =?utf-8?B?dVlJWEZXMWtGanlVL1poWE9jNDZuOUJMeHBRbXVlOCtieHlIbitobFFBZitI?=
 =?utf-8?B?dXljMmY5bGRpUk1tcFd5R05kRjU5L3pUVDVra0tWaG00UThYVCtpS0hHMllj?=
 =?utf-8?B?MGUrNitTUm5nZHdTVXJSaE5EZXBHUWJLYXo5a0ZwV3gvajZRdzF2TWtXN2JG?=
 =?utf-8?B?OWhqRnVlVnl0Uk9aa3RXcUhTTG1YT2RhZm0vcGlWZGtPWmhwVGMyMDNvTFlB?=
 =?utf-8?B?Y2xFRGFOQXQySWFDK3YwbURTUnk2aS9tT29JVlNTVWtKSU9aWGxIY3lJRkRw?=
 =?utf-8?B?NDVtUEpKTjE3MjdEalZOMWcrTUdIZG9GQ2pCaE4wdXFrNmlVT0RUaTlXekJB?=
 =?utf-8?B?UXVpV1J5OHpnRXlycU5jalZyeGJQVkFtOXZCZDd5RnZENy8xWTN0Q3RWTytk?=
 =?utf-8?Q?pk7gpOdi27SOEaRhDCeMecCXh?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ee5d40e-d108-42de-f6ec-08dd6306a053
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2025 14:43:47.1073 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zme9nkwT3pZRPGKaFrj1G1TmRG8ZaY8wWG+g69wnthSi9fP+fJrE8sNPKKKn/f6f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6478
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



On 3/14/2025 7:17 PM, Alex Deucher wrote:
> No need to make the workload profile setup dependent
> on the results of cancelling the delayed work thread.
> We have all of the necessary checking in place for the
> workload profile reference counting, so separate the
> two.  As it is now, we can theoretically end up with
> the call from begin_use happening while the worker
> thread is executing which would result in the profile
> not getting set for that submission.  It should not
> affect the reference counting.
> 
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> index 099329d15b9ff..20424f8c4925f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> @@ -2188,18 +2188,18 @@ void amdgpu_gfx_profile_ring_begin_use(struct amdgpu_ring *ring)
>  
>  	atomic_inc(&adev->gfx.total_submission_cnt);
>  
> -	if (!cancel_delayed_work_sync(&adev->gfx.idle_work)) {
> -		mutex_lock(&adev->gfx.workload_profile_mutex);
> -		if (!adev->gfx.workload_profile_active) {
> -			r = amdgpu_dpm_switch_power_profile(adev, profile, true);
> -			if (r)
> -				dev_warn(adev->dev, "(%d) failed to disable %s power profile mode\n", r,
> -					 profile == PP_SMC_POWER_PROFILE_FULLSCREEN3D ?
> -					 "fullscreen 3D" : "compute");
> -			adev->gfx.workload_profile_active = true;
> -		}
> -		mutex_unlock(&adev->gfx.workload_profile_mutex);
> +	cancel_delayed_work_sync(&adev->gfx.idle_work);
> +

To avoid locking/unlocking mutex for each begin_use, I think here we
could do like

if (adev->gfx.workload_profile_active)
	return;

Thanks,
Lijo

> +	mutex_lock(&adev->gfx.workload_profile_mutex);
> +	if (!adev->gfx.workload_profile_active) {
> +		r = amdgpu_dpm_switch_power_profile(adev, profile, true);
> +		if (r)
> +			dev_warn(adev->dev, "(%d) failed to disable %s power profile mode\n", r,
> +				 profile == PP_SMC_POWER_PROFILE_FULLSCREEN3D ?
> +				 "fullscreen 3D" : "compute");
> +		adev->gfx.workload_profile_active = true;
>  	}
> +	mutex_unlock(&adev->gfx.workload_profile_mutex);
>  }
>  
>  void amdgpu_gfx_profile_ring_end_use(struct amdgpu_ring *ring)

