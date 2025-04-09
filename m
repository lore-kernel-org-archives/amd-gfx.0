Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79227C369A1
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Apr 2025 13:49:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 05A0210E8C6;
	Wed,  9 Apr 2025 13:49:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kYTrzorr";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2089.outbound.protection.outlook.com [40.107.93.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4643A10E8C6
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Apr 2025 13:49:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bvilJd4F40LMTVwh0kE/KEZ2ja3v0OBSrR45O5xUwD13+6NFdbBDyqALo1rwO+3kgBIV96/+xUjdpkPitc1YfmVrwNQ9bS2ZVBXjsQs8H7G6UILg1Uq8lICe392o9YWloBW2TdsgWtqmk3nvnvLBZ4KLAOH0jOTO6jg6NL00FPcTsMxKxbqG+IeqY4OYM0XxKpUwa/To/VtzNdTreuxHIHfhZpA0Ia1/bnuC+RXAWK/9ckxmIECNkvcGi95ZvvxEaoKocs1kSiLBSFKZI3CfMXTxEy8cFKpzfn06ZjlPbaLQDYILPJXsU7/r3ydmNzFEYoOax80gDPAhC2j5mgyxQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FQhjCqu3cP0xP6qDp5ZVhaEVxNsWG2p8pIn+q66xa9w=;
 b=toQoryjygA5RCchzkUyYajf+eHDRNQe/qiL5ca6RGwhUicjH+pc62dT+mbo7tjmQO6CH+qYaGPZwFpltX2vORrhpelTUHmWQmDFpfTLGNJ/LsKXaX49lkm5oc15/+9hJLNu/7rtsBBXTL7/Pya9n3vdJApKdg0uIcUf3pc9H0Z06/FqZPOQh4SgjnJUEBupKc++vX+D0an7G+2wMLeQUS8joptsF6S6Ks4NuAekd6a7LnCz/KZCjQIpP0XtIgXGJh2SRJaROzrlHhn0nh3omR1Weq4gIATeXopZxrANzFtERrpmuB9pUweQmxfLXyOgp2k7Ns/VMQOligAyD0RnlEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FQhjCqu3cP0xP6qDp5ZVhaEVxNsWG2p8pIn+q66xa9w=;
 b=kYTrzorrF2ZAHLWKwAhpm16RWp1bNxlCZRgrhOcR+7aMwr1No7SAjN0G70b0AyNxKbukqq3HDrFOa7fYqr8tkURAji36dGmAfB3Koi8p2GPFXhFTAAb9N8W7MquKW8Nh9aQUPPJbhtfslMhGxJe27EFlOWWKWaWUYaHmSsJEJdU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 BL3PR12MB6404.namprd12.prod.outlook.com (2603:10b6:208:3b4::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8632.23; Wed, 9 Apr 2025 13:49:30 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%5]) with mapi id 15.20.8606.029; Wed, 9 Apr 2025
 13:49:30 +0000
Message-ID: <a79917f2-0883-4855-9802-9c1f127c8f02@amd.com>
Date: Wed, 9 Apr 2025 19:19:25 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Replace tmp_adev with hive in
 amdgpu_pci_slot_reset
To: Ce Sun <cesun102@amd.com>, amd-gfx@lists.freedesktop.org
Cc: dan.carpenter@linaro.org
References: <20250409133955.26169-1-cesun102@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20250409133955.26169-1-cesun102@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4P287CA0124.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:2b2::10) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|BL3PR12MB6404:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e76ecac-56f8-449a-750a-08dd776d59bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Qm9KSENjNGRrZ2doa2VZVmdxZzlpaFNHS2tOaGNKMnBEd3lTaG9iRVBocEtn?=
 =?utf-8?B?RW5JR1VkajdCN3VCaXY4bW4xZDZkYUtyVDU2WVFnS2tpQU0wbzE0RUhOSFNs?=
 =?utf-8?B?d01wNmVJaHZLbjNLSUJSWWdEanBndzBZMEtZUlF5b1h0Rm53bXEzdGVWMmRW?=
 =?utf-8?B?bUQycHV6eE5wZHd1NDBpUUNaV1BSMlFEZzdCdVl5TFlXMVIzcUZENnVsM2hR?=
 =?utf-8?B?R05NMkJBM2dvQlFUODk4NFM0dTJYam1JSWgxSWw3ZkFFV2trTENMelptRFVX?=
 =?utf-8?B?ZmFlQm1XeWU3NVltREVMcGE4dXFNR1ptRGR1Y25xZXNGWmI0TUJJUzJRZVpW?=
 =?utf-8?B?am1xMnUzYWMxV3R5VWdPQU03d2U4S21waTR4dTFJZnRxajVzOGdWWXptdkR2?=
 =?utf-8?B?ak83V2VUWWxHK2VvT0xqVHpuZ3k0VFBzQUhmRUthdVVDb3BYeEJPZVM4Nk00?=
 =?utf-8?B?TTNiYkdPU3hRYkNGc0hBYXk5T0V5M2RwZ3dIWGdVNm50ZmhNNjcxRVBFVmxu?=
 =?utf-8?B?NzNaT0cvZjg4VTV2WmlYeStJbjVvYkdyb1VvcVdJaDBwUlhxZFVabFJFYzNP?=
 =?utf-8?B?K0RRU3p6L01QQ21EaFhBTmF6Z29iNEZaTEJkNkwrM3FuYnF0N3NrS2VCSWhH?=
 =?utf-8?B?eWdGWjZxTjV2bzg2NWxJTGkrRFpPSWhyWDhNVFhuZ3hUWUtxRDByWGRZMk12?=
 =?utf-8?B?REVCY1l2Yi9hT29jOUtmekJ6VGtEUC96MmxLcm1BMElEV3JnbUtzbnZ4dENp?=
 =?utf-8?B?TlFVYnBKQ1Y5aTNrNldyNWNKczgya0svVzhEK2pTYkU3dFBpWDlQUFBMYlVX?=
 =?utf-8?B?Yi9VeTNaZUhJbFNTZlZCMGloRVFSc1RGYzR4UUpPdCsvR1FGa1I5bXAwbURm?=
 =?utf-8?B?WnJaU2c2eFc3U3lrdHI4b1BQK0JoYUsyNUVPNlZwdnY4S1hSNWhkV2o0OWVV?=
 =?utf-8?B?eE1uaUFET1B4eE5BU2VxY1JOcWlpSWtnb0NOUVQ3bTEyS2FLd3FFUXhUTXU2?=
 =?utf-8?B?NFlCOEU1WDBnam1YWmJ6bHQ3VjNxalBzUGluMEpDQmRqQVlBdTZQVjZwN05M?=
 =?utf-8?B?Qml0Nm9qYm9GZjNRSy9NUkVsbEtoZUp3Uy9xMXRwanE3VDA3b213RkFkOVJ3?=
 =?utf-8?B?WWJMRnVTekdUL0U4THZQYkp4bjllVGdrOWhGMHM4S1VsNDFJTThZNVZtMXkr?=
 =?utf-8?B?R3RVSFcrUUtGMHl1eUJrMExLUUhndVFNajh5eENtMVhTUEpwSzV5MFBCeHBO?=
 =?utf-8?B?bGllbDFVbFdhOW9tNnJUbjVOK1ptNnMvNVloQytNNzhJVFlKTllyNjduSDZr?=
 =?utf-8?B?alc1ZkYyTkZYWXFtSlZiNlEyY3J5S2tDS0ZpTS9NSUJFWDkzZTFqcERQWFBi?=
 =?utf-8?B?M0hubDErR3dGbUFsVW0yQVJSTFRDejdvWHhhbWJDREREQzVidUZwVXhMWm5v?=
 =?utf-8?B?WHhPV3ZVSGdGNWY0eGJVSStXVEdDL3JSMUllVEVRVFNVWjZZZm84ekE2L2pM?=
 =?utf-8?B?QkRDNXcxbldraXRKNG5IK0JTWXVPSzhXUVU2angrWDJxWVNtZ0Rxd3JUK2t5?=
 =?utf-8?B?U1FlQWdZTVBzYjBzQzJXOUEwaE1JM0k1L1RpSHloWDQ4QnRLRmNSaGVJMDhz?=
 =?utf-8?B?NnJad3ZKUlRHc0hPaXpJcG44dTJZVUNyRmxhUjBGbGxES0VCdjl2NWZ5Ullq?=
 =?utf-8?B?OXNsYm5TUFpDOU04bmhyNFZaOG5XOTFFY1JGZjZmRTFSTjNoVUR5VG5aV2FB?=
 =?utf-8?B?QU16U0tnM3pPNG94QW1uM241d1ErVUw0WnNGcktLd0pGektOcWhIays3TDU5?=
 =?utf-8?B?TE94dTRZTGtVajdyRncrOTY3bUFjdThXMWJnVGRldWtuZWFDV2M2L096TTNR?=
 =?utf-8?Q?gCLhl9LQ9wi3X?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YnZES3d5VWVST0p6a2JzNEJMWUs3MVZ1d0x4cnJXd1RUWUthNkRwMm5ack9j?=
 =?utf-8?B?Q0tKZzVIZlRGN0EyUnloVmF6c0wzWVRtZjZaTlJJQnRCRTFUVzFHWlVFeXYr?=
 =?utf-8?B?ZTF6SDJNNnZBYnp4N1NuQW5jcjBkeW4wZkU5VGR4b1MyMjl6alRQZlgvT1M2?=
 =?utf-8?B?WUh6Z1BWbXVRZC9rdk1tSmRuODZVeHpOSHo0Sk1aSng0eFFnM3FqWk1EMnFW?=
 =?utf-8?B?dyt2VE1XYkJIYXhsRnY1UEdqVU5rTE5hZWlTemQzVjVBMFZqaVdCYjJqeEJD?=
 =?utf-8?B?b1RqbzNHN0ptZEhXT2ZVMTZlR0VFWkt6aEFLMC9LMmVmNWxpMWlUeVdld1ho?=
 =?utf-8?B?YnU2WnRCVGVFeEpueG43VHBkaFFsRVVnRGVROTc3NHpYRFJocGJJSDhZQlN5?=
 =?utf-8?B?cW5McEVxU3JUOVJNdTdWVXVubE12Z0R6bkdXa1J1SjA1Vmc0K0RpMjdENG9o?=
 =?utf-8?B?bDF4VTRpR1dGQVRmQWRadjMwV0hDRGlnVXZBSGlVSE5wWGhCT3Z0bGtuZTR6?=
 =?utf-8?B?OE5XZ2p3SnFwK3h4d0tvNDhoTUdNT1diYTZCOUdzS1JLRmFVb2x6M1l2Tmdj?=
 =?utf-8?B?bFdPK3ZrOEw1aFpKdnh5UEdYQ1JvUVJta1ROV2VkVGZmSm9OK0hwaXlYVDE3?=
 =?utf-8?B?d01pNmIzSFQxSXlwTWFpUjErMjU3aUNsSkhoeWllRXhoQWptRnhSOEgzdlhL?=
 =?utf-8?B?VGhaTUZxYkRTMCtMc3lhVE0rbExjcUp4NEkyWEIxZmNPazJ6Ny93eUIvZWRM?=
 =?utf-8?B?ZVBjc3BEclRVTDBZVS83RUtvNkNDTFpnKzgreC9nSkk5V1dPcit5ckpPdDBp?=
 =?utf-8?B?ZE9wMEhwdW53aGhnWXExZ3J1cEdoYW9rbld5MjFSc3ZWNXUvVUxXVkpTZXBT?=
 =?utf-8?B?c0VGYmo2N1RESWNvSWliY3pwRTRIRUFUUndNeENkeU5CVU02clV1RHY5bUlL?=
 =?utf-8?B?OE9kUWJDalJIMUNIVWdRd1dTeExhdE83Vk5RZmhJNVc5eDUrWUViRXZQcWRY?=
 =?utf-8?B?NXZnbHozYnRNSVdUaVhibHdDOFdGeXhCbUFlaEd3b2RNUEw3bnYreGRSK3lG?=
 =?utf-8?B?VncxeFhwRUVDSzF2UmVvTnJiVXJNeE1nekJWczN5TWxlTUJuZm9GVXQ1dm5T?=
 =?utf-8?B?V1ZoeFhuSkVsZzBCMGVUNUtXTjNVZEdhdERvQlJTN203S05MVU9laXQvMTZ0?=
 =?utf-8?B?T2lBT1VhQ1pKNEJxTWcxQ0Jzc2pKaHhZR0ZQL0N2U2ZtS01OTi9vR2N4ajNt?=
 =?utf-8?B?Ky9qenJHTHlHN0tZVDFhYVZKNFc3RmtSSS91YmxVTkdvWmxEOXdsd1VyL2JI?=
 =?utf-8?B?QjdQRDJMWUcyV2luQWFjRm13ZTNkSjB1T25hUElEMzBFVXBuNUttWklJRk5o?=
 =?utf-8?B?UFlST2I3QUdPQVJFQzROZjBZdFJNQzR3T2drNkxnK1JOT2NSclVwSk9GNUJz?=
 =?utf-8?B?Yk9MU09sbmZUemNOOHRMaXloQ1RaWlJrVHNTcVNZVVh6dys2bDlnVWQ4V2No?=
 =?utf-8?B?ZU1CYTlxNkdla0dvZW9ndks3Y05sL3ZZS2dvd3NIdjMwTlVkZjBYOWxHTTlW?=
 =?utf-8?B?VVozdHNNbnhMU0x6R0tpVlVwUlQxczlsQ3M2ZUpDV09NcHZlVE4rcUZmWU9T?=
 =?utf-8?B?dHhod3JSdHhYekdkdjdCdlJsN2w3dE1GbVU1WHN6L3crSllMQ0xjQlpQT052?=
 =?utf-8?B?Y3pFYXREcWM5TXQ3N251OHRYR1B0WUwrRVpzak1JSEFkSnhESHNOS0VRQ2pr?=
 =?utf-8?B?U1hBU1o2OHBUY3RVdFZIN0FZUXdvcnNmY2ZGTHRmdHdhWEwzZHZRZUtDZHJB?=
 =?utf-8?B?S21rOENjaWFrSjd1L04rM090Q0dzOUlJdWc0Rm5GbEpYbkgyRFBRaGh1L2py?=
 =?utf-8?B?S25DVis5L2RPRG5INEtieUJIaFI0SU8zdHF2OTRzVXJuMTljaTZ4WjJVMk45?=
 =?utf-8?B?eS8rSzJQVG56VTZXbUJobmdKb3BxZzVNS2pnd0k0MmJ4ckxueXhpZDY0cmpP?=
 =?utf-8?B?UWwxOTZ2Y3NOaWdXcHlRbWROaXpZc2R4ZUQzcFhkZDBhWmRSVmN4NEQ1dTFF?=
 =?utf-8?B?VWc3d3ljSm9VbGNoc01tVEpqck10SnBCQUdoWHVEeExQcVhrTW8wU2NCeEJD?=
 =?utf-8?Q?F5x4kFlDPIzrQbPRTlMOMQa5Z?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e76ecac-56f8-449a-750a-08dd776d59bd
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2025 13:49:30.1846 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D2pmHvGNr9FBRd1DPfNjBZkHNmObzSormfBCFxnxL8Fhba7pxw+MnG1TXTwVUG2g
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6404
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



On 4/9/2025 7:09 PM, Ce Sun wrote:
> Checking hive is more readable.
> 
> The following smatch warning:
> drivers/gpu/drm/amd/amdgpu/amdgpu_device.c:6820 amdgpu_pci_slot_reset()
> warn: iterator used outside loop: 'tmp_adev'
> 
> Fixes: 8ba904f54148 ("drm/amdgpu: Multi-GPU DPC recovery support")
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Signed-off-by: Ce Sun <cesun102@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 60269fba5745..6fb234832ff3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -6784,8 +6784,8 @@ pci_ers_result_t amdgpu_pci_slot_reset(struct pci_dev *pdev)
>  	struct drm_device *dev = pci_get_drvdata(pdev);
>  	struct amdgpu_device *adev = drm_to_adev(dev);
>  	struct amdgpu_reset_context reset_context;
> -	struct amdgpu_device *tmp_adev = NULL;
> -	struct amdgpu_hive_info *hive = NULL;
> +	struct amdgpu_device *tmp_adev;
> +	struct amdgpu_hive_info *hive;
>  	struct list_head device_list;
>  	int r = 0, i;
>  	u32 memsize;
> @@ -6846,7 +6846,7 @@ pci_ers_result_t amdgpu_pci_slot_reset(struct pci_dev *pdev)
>  		dev_info(adev->dev, "PCIe error recovery succeeded\n");
>  	} else {
>  		dev_err(adev->dev, "PCIe error recovery failed, err:%d\n", r);
> -		if (tmp_adev) {
> +		if (hive) {

This doesn't look correct. I think the original logic is to have a
single device list or multi-device list when there is a hive. Now this
skips the step for single device case.

Thanks,
Lijo
>  			list_for_each_entry(tmp_adev, &device_list, reset_list)
>  				amdgpu_device_unset_mp1_state(tmp_adev);
>  			amdgpu_device_unlock_reset_domain(adev->reset_domain);

