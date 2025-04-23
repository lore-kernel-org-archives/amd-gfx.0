Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEC2AC369CB
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Apr 2025 09:54:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9487810E677;
	Wed, 23 Apr 2025 09:54:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cMI++UGE";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2040.outbound.protection.outlook.com [40.107.223.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 941F110E678
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Apr 2025 09:54:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GZt0vx2SWg97D2CmwCDx/LywQg441f5coUDQ7fQd3vjZAffSlth2TIpRqN0YpQbEQb9qdrmu92h74fqm3T71hnRA2FyOvn+8LCc+2b8uHQN+pwQXCdT0NsMeikOW7tjjzZlzC4XEh1LW7RFMzVKcjac8RgFMKapWlyIzx/mFZ9slVWEMyn+RdU60rRfEQkguiZMO+728tJSvevZOa2dZQZU+WOTldNgdJlp73XqRXGNSRWLGbTD8rEGWUHt5/3m4JqGrDqs4yPxqOWZ2MCOR1b19YNvf8lptSbk8fG97HIY6WLiPIgkcBH7pTctl5vahfUb0yfjn+tGF6LI8bTWn9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=80Q861Yhv9077O/Y/Fr1kONE+qk+aYEhuGU0Mh8xycE=;
 b=KdqYOwv0Eg0Jk+dFfxPym5tGsRLoa6FysSyOisZmQosomudBlOYbmZol9+HZOHfrVo+HITdU0wMW9z3TXCFzTW5UyTtgdTOcTWRUSKdf/0rgHXwfNFFuO2Taw3Ky/IUh2zqFczrP3cKr4p5NVtxOF9eh6pksfJAnA02yjd2KI3YRcRmZScSmhWkNP07BKn4zp2eefmKLdIISlusLLkVjbYm11+5x2joEb8X8bHvFjVMceCBYuusiV0VDBF9alYCFF/FrOims401XRYxkLM0KcWuxHjBZv59BtDt50yyfcLp+PEpxIMO7neXMWmgXMAbSyV0KLw0U/rJ1XEumJxiWRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=80Q861Yhv9077O/Y/Fr1kONE+qk+aYEhuGU0Mh8xycE=;
 b=cMI++UGECOEH1X8f8N0mx5mwCjiAtUwrNn4Vqem8W1vtS46QTE+Wz9M6fSkrRIXUn6ja2ch7VQlxXetnJvF9n7e+2pO3NelFVd/FxMytRuURpHgJSVKNuCz7sIpyTFjLAl+VZ110Ffwf54pGsF1NUgZs0sx7zBI0BiPBvCZb4ek=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5753.namprd12.prod.outlook.com (2603:10b6:208:390::15)
 by BL3PR12MB6618.namprd12.prod.outlook.com (2603:10b6:208:38d::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.23; Wed, 23 Apr
 2025 09:54:32 +0000
Received: from BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::2b0e:7fc3:1d21:5d2e]) by BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::2b0e:7fc3:1d21:5d2e%3]) with mapi id 15.20.8655.030; Wed, 23 Apr 2025
 09:54:32 +0000
Message-ID: <7bd591c8-8101-431c-980d-edadfe26b047@amd.com>
Date: Wed, 23 Apr 2025 15:24:28 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdgpu: remove DRM_AMDGPU_NAVI3X_USERQ config for
 UQ
To: Arvind Yadav <Arvind.Yadav@amd.com>, Christian.Koenig@amd.com,
 alexander.deucher@amd.com, sunil.khatri@amd.com,
 Arunpravin.PaneerSelvam@amd.com
Cc: amd-gfx@lists.freedesktop.org
References: <20250423093359.4424-1-Arvind.Yadav@amd.com>
Content-Language: en-US
From: "Khatri, Sunil" <sukhatri@amd.com>
In-Reply-To: <20250423093359.4424-1-Arvind.Yadav@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4PR01CA0015.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:26e::12) To BL1PR12MB5753.namprd12.prod.outlook.com
 (2603:10b6:208:390::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5753:EE_|BL3PR12MB6618:EE_
X-MS-Office365-Filtering-Correlation-Id: d547d03a-c61d-475f-2540-08dd824cd8d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?S0hUR0wxcnJOOVY5QUJZTVNCUHJhSlBZQ0hEQ1RkNGlIZGo3c1FINmdhVW5L?=
 =?utf-8?B?TlZaNU51ZzVtQlU2MHJ2NUZEVjQ1QTNxWVN2SUVVVEpWcVZLYUxIQTA1SGtt?=
 =?utf-8?B?MlpGTlFmUUlKTlNZUDNpbHpDT2VyRXJCTmZRdDBsNHU2cGs2VllyTFRCZGFw?=
 =?utf-8?B?UE9Ec0p5VUdlQzJwQWZSY2lmVnZza2JsNVFhUEVpUXkrYjhibFFhU2ZIYmFI?=
 =?utf-8?B?TW04VDA0SmFWVHBwbnJSMkwwQ0FvSXFWcUxKWm5lWFlDeERJQzRwUmttc1Z4?=
 =?utf-8?B?aUFlWVZSK003ZmFIRWgyLzVld0g1U2dabTlEK2lqdFNGZ0JKN2MyUE5UdFBk?=
 =?utf-8?B?YlVvUVJFY0txdFRtVHdXNXJoUzJCcStYLy9aQkV6RFZFWGplcTBiVmc3NFJk?=
 =?utf-8?B?NGZ3Skg1ZzBrQnE4cmV1VDAwamZJYnlJb1lWNHVETitDc3ErVGF6cjkxSUpN?=
 =?utf-8?B?dG5kY1lodWFPZTMvU1A4QTNPb3dOcWF1M2cxUGMxVjJNM3ZXZ0prMWZ5Z0Nh?=
 =?utf-8?B?c0hNRGgreElZZDdHVWtnQWRoRlN3TlhmZ3JLQWlBQStpbXBIWWozNlVQM2Zo?=
 =?utf-8?B?SFZXanN2YS9iaVpoWWtmdTd6ZXpZNDRzTHEyelpIbXNjeTBabWlkQVFNaERo?=
 =?utf-8?B?WjVUK0dScWo0SnVDaGx3QW5VSzZMOFRJZk9aL0JTeWVTRVcvS2RydGxZWVZV?=
 =?utf-8?B?cVNYdnI1WW12NkRrRGlXVzBsMVdDOWxYS3pQL0I5RXN5cmxYWEt1K045Nm5l?=
 =?utf-8?B?WDlHa3lKclN4VDJEbGZtVitwc1VuNVNuQjdNYWE1aDgzaXI2dDdnR1I5Q0Jx?=
 =?utf-8?B?K3YwUW4rcTNBSFJFU0NZWkY2UEozcHpiNG4vOGZid0RPWjRQd0tkU3pWS05u?=
 =?utf-8?B?UGUrbHJLK3VHTXFuanZlaCtEMGpLOENYR0V6di9aa0NWWk81c2g3ZWpPVzN1?=
 =?utf-8?B?NStobm5HQ2xWb1VwYkR3djRxRVlydmV6cXI5UzZwaFpSdVVQVEd4d05LSllZ?=
 =?utf-8?B?c3pRcnUwNHMyOEpaanJtSlptTzM4TnI5d2dhcnI5UHYvNXYreXA4amRlOXB1?=
 =?utf-8?B?OGJvMmVWekFieFlyR2dOYkVWditya2h0bHlSSjNaNzdJY0hKbkkwUEFiWFhY?=
 =?utf-8?B?dGM2SDF6dmNPUjBJdFJVV3VYRGQyWFp6VFdmZndmMFo0bk1SdmZ6QjRKeGY0?=
 =?utf-8?B?NmptVE1oTnNPcnVKdGppMGI1NXYxY2licHRYUmh0ZTE0Rzh5czVVRlcrN3R2?=
 =?utf-8?B?SGROTDFLRzYrRkRnUGxwbUtEY1MySER5WEYxdU1MVGhtM1JtY3BlVmhSQTNz?=
 =?utf-8?B?eFM5U1ZFL3FWdnR2dkxkYk03K2VwenpsVVphbkhCTUR6QkduV3M3elBpbnNU?=
 =?utf-8?B?TUh6MUs2REQ2QkJkUnEvVThoOFR1UzcyUHQraWVsbkgvTFVOaTc4b3V5MlpS?=
 =?utf-8?B?cGJyekx3dVpFVHZvbVZvNkxVb1NlSFNoaFNkVE1WeEtJL0lzYmxaeHUvZklX?=
 =?utf-8?B?OG1HejRsc2JwOEZUeUhXSW5aY2w0bzZZYVk4eEo3NThiWUVjanVtSldPbGxn?=
 =?utf-8?B?QUZlTXgrRC9lYVVFTEpIcTg1aUpubDRYWmdJeUIreDhabGF6WXFqbGFua3JK?=
 =?utf-8?B?cHhDSkQxeFJwSzlSdTBXenErU1QrYU10bHgvL1FZVGV6MlBSRnBLNHRLRmJX?=
 =?utf-8?B?cG1zWHBndjcxeVpVU3hubFIwVDVZSm1XMGVLa2x0R1RLMkpXNDQvY29PdHh1?=
 =?utf-8?B?eFJKcy94S0VFTjVtQkJnV2Q0ZkZSTnR0eHphVkNUcG05WlJPeWp1SXhoQUZN?=
 =?utf-8?B?MUNIVWZ2TzZSRnV3MllRN2pjb0E5a2dNci93dVlrbUE2V0FKeVdvSVk1TGta?=
 =?utf-8?B?VWlMZnBlNEt6UjFrVjFkY3RURnFlL001d1RkQWYxbmVEVW94aG5Fb0orenFN?=
 =?utf-8?Q?VmRFSgE60a4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5753.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R3NKMkpSR1JybjcyK3dUYUF3MkxXVlRDWG43OVJTNlFyOU5uSGNIRVRnNE54?=
 =?utf-8?B?OHBoRjdVTlE5dXc0NERHazVSV2hGVjRuVzRkQTVqYXJXQzRxN0tERXVRZGgx?=
 =?utf-8?B?Tlp2Y0t4b3E2clRZSEhvUmV3YmdBdVlKWnNhRFRpMzUwd3ZIL2l2TDRtMlVv?=
 =?utf-8?B?TWpIY3hJRlY4LytrRXBZUy9NbVlheW9rckdvN0pwK3Vaa2MydGJXd3BZQmFN?=
 =?utf-8?B?cjdUN200ak1pbGV2SXhPM1J5VnhGZDQrbnVHeE1oK3o2Y3VvREdGVElpdi90?=
 =?utf-8?B?UEZQVGdqbHRicEVFbzNnZktlNG40VUNNTzVxV0xQeVQzVHBCSWgveDJqQVFk?=
 =?utf-8?B?d1h5YWl4aEx5eDZsd1RSUWhySXZ3eEdkUGlEQnFkS0ozZ1JraUlBcVdRUmhB?=
 =?utf-8?B?bVpBNXJSQmxNczZoSXhXdGxTSkFvVFJKNU1tOFlXTllsRWd5aU9wSkhZZG9y?=
 =?utf-8?B?bENSSnVqK0RVdHNEbHRXUWJYd2I5MHcwZlRwNGxCaVFBem1va3ZBUWtyczBs?=
 =?utf-8?B?WGtYSWl2VUhOcUhJYzN2b1hSQVFxVk5kVHNJQ3RUU0c2b1RFNXZRZHR5bnRn?=
 =?utf-8?B?am1EaVRMKy9TanVYQUQ4b2xxSDFZd1Y0YXRQT3k2cTdjWS85VUVwbEU2bFRK?=
 =?utf-8?B?dWowdmdMenZ0NEh3VnQrQWFqdDdDbWtWSlhGN3hIcVl0WkM4djR4WE1yTlZ4?=
 =?utf-8?B?Q2tuaEhkTzF2R2lYaVVVQTM1emsrY2NTbzA5QXlvY282RTlJcXZRckdkOHZQ?=
 =?utf-8?B?VmFibTV6cE1wNVNWODBQM3J5MERFaVpUSVdjS2NJR2lFMHJUMktLbGVQVWRn?=
 =?utf-8?B?cDNoZC8xZGZGTzlrMXhNTm1TVUdkZlZHWUdzbHBHMzNRNUwvbWc3N3BSNGpF?=
 =?utf-8?B?Rk1xUEoySzhPdkFnOUNXRHpHdzFaRDFGU0poU2FpZTlDWkdyRXZoL1FQOVA3?=
 =?utf-8?B?elcwQzJCYVM3L2FHT1RsekI2UGo2cDA3cC9SdzA4MmpUQzRUaHUzQ2pJRk53?=
 =?utf-8?B?by9mQmNmZi9oOHJUaU9YYkJGdTQ2d3U2TE9TYVYzem5qZ0FxcXFtaHRtRVVk?=
 =?utf-8?B?eUlRWmU5UFlua1NaY3hVMUZsZFJFQXJ4ZmNJYUc2Qk5PTDc5ODlOSGFNdFEx?=
 =?utf-8?B?SGV2OGRtSkxScTRIZCt3MTMxdUNUdXArTHUzVkRPRlJRMk1OR0J4UzdLN2lz?=
 =?utf-8?B?VnBiWW9EKy9GQS9TTWw4RGI1NDNqTkNyMjY5S3NXN25JZ2tjYnFySU1ndkFC?=
 =?utf-8?B?eVl5UTZKQWtCRHZuSDBnV2lRMVYrcmZtOGpJQjJlemRRaU1ha2dvUzdCUzRq?=
 =?utf-8?B?NWpSYUJuZEg1NDUweFdaTWdYR0Z0clU5aTdiTS9iS2tWL05qb1A5bzhaY3JZ?=
 =?utf-8?B?bXdTbmYrb1gyelJLczkwbDBLMWhubXNQRStCV0RjdDFmT3ZZSERyY3kzWWFz?=
 =?utf-8?B?VmRuWURQeFhxT29sQ25SM2ZtOEE5MEV4V1p6WEF2NS9PUEVmK0UwMzNSTTQw?=
 =?utf-8?B?ZlUvV3h1UDhIbDR4c0tTN0VTbXcxeDFmNldwa0RndW40S0F4UjhKanAxanl6?=
 =?utf-8?B?dDY3YUgzMnh6LzNtb3ZtdHVuRWh1RTF6YW1udkp0S2lyZ1FBTUN3VEtHd3J6?=
 =?utf-8?B?dUN4S3c4UXVoRkJvY0xiMmVlb2s3aCtmRlMxaGFXK0pTRnhocGhrZE9aZjB1?=
 =?utf-8?B?SlljaS83UVVTYTBKVnkwWXg5U3k5bzRoczRQRTJKNHhnVjYxMDI3MW1QcmI0?=
 =?utf-8?B?YVRsek0wcXN6YlFJOVRpdnFqRG5BOXg2K1c1d1lXVXB5UVJuWGo2aWdYNFlk?=
 =?utf-8?B?N09uOHUrbkZ2Ynl5dEJ5b0ZMeVdnUFN5VHdvWWt6SGZ1dlFydTRIWGRLQU9K?=
 =?utf-8?B?YVhOY1BIRVFtcVY2RC90amt0VDdwRUs2T2taUmJmWTEzdzBWTUt0TnJhSGZD?=
 =?utf-8?B?WXVObUZGVWtwazRWRUNRK1lyR1VVTU1oRUxtSXdkWEdKS3RaeHFSQlRVOG5J?=
 =?utf-8?B?R21kSEpnTWZ1QWZ2UkNVVm1GVnpUWjlnOVluNWVjdVU4bDRlc29qbVRmbzJt?=
 =?utf-8?B?NEE2WVVYd1IwcUpxVy9oQnFNUWNiUFVyZWs3MGpPQXJDMlI2MXpZRWxKRXVu?=
 =?utf-8?Q?HvZWNkDFdR7GNP0sD9g9gJUHf?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d547d03a-c61d-475f-2540-08dd824cd8d8
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2025 09:54:32.6764 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LW1MAnOSGfVi/bhVKm16HRA5XY3/wuzBwnpFwz0Jk2z6vZvwe+cbH4uMObRMBvTh2JFZK2wGMK1mw1VgQpKLxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6618
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

LGTM, Reviewed-by: Sunil Khatri <sunil.khatri@amd.com>

I think you should also get an acknowledgement from Alex too before 
pushing to ASDN.

Regards
Sunil khatri

On 4/23/2025 3:03 PM, Arvind Yadav wrote:
> DRM_AMDGPU_NAVI3X_USERQ config support is not required for
> usermode queue.
>
> v2: rebase.
>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian Koenig <christian.koenig@amd.com>
> Cc: Sunil Khatri <sunil.khatri@amd.com>
> Cc: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
> Signed-off-by: Arvind Yadav <Arvind.Yadav@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/Kconfig             |  8 --------
>   drivers/gpu/drm/amd/amdgpu/Makefile            |  2 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c     |  7 +------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c        |  5 +----
>   drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c      |  8 --------
>   .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c    | 18 ------------------
>   drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c         |  4 ----
>   drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c         |  2 --
>   drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c         |  3 +--
>   drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c         |  3 ---
>   10 files changed, 4 insertions(+), 56 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/Kconfig b/drivers/gpu/drm/amd/amdgpu/Kconfig
> index 7b95221d2f3d..1a11cab741ac 100644
> --- a/drivers/gpu/drm/amd/amdgpu/Kconfig
> +++ b/drivers/gpu/drm/amd/amdgpu/Kconfig
> @@ -96,14 +96,6 @@ config DRM_AMDGPU_WERROR
>   	  Add -Werror to the build flags for amdgpu.ko.
>   	  Only enable this if you are warning code for amdgpu.ko.
>   
> -config DRM_AMDGPU_NAVI3X_USERQ
> -	bool "Enable amdgpu usermode queues"
> -	depends on DRM_AMDGPU
> -	default n
> -	help
> -	  Choose this option to enable GFX usermode queue support for GFX/SDMA/Compute
> -          workload submission. This feature is experimental and supported on GFX11+.
> -
>   source "drivers/gpu/drm/amd/acp/Kconfig"
>   source "drivers/gpu/drm/amd/display/Kconfig"
>   source "drivers/gpu/drm/amd/amdkfd/Kconfig"
> diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
> index 8595e05c691b..87080c06e5fc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/Makefile
> +++ b/drivers/gpu/drm/amd/amdgpu/Makefile
> @@ -177,7 +177,7 @@ amdgpu-y += \
>   	mes_v12_0.o \
>   
>   # add GFX userqueue support
> -amdgpu-$(CONFIG_DRM_AMDGPU_NAVI3X_USERQ) += mes_userqueue.o
> +amdgpu-y += mes_userqueue.o
>   
>   # add UVD block
>   amdgpu-y += \
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index b96e0613ea7e..fe68ba9997ae 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -3513,9 +3513,7 @@ static int amdgpu_device_ip_fini_early(struct amdgpu_device *adev)
>   	amdgpu_device_set_cg_state(adev, AMD_CG_STATE_UNGATE);
>   
>   	amdgpu_amdkfd_suspend(adev, false);
> -#ifdef CONFIG_DRM_AMDGPU_NAVI3X_USERQ
>   	amdgpu_userq_suspend(adev);
> -#endif
>   
>   	/* Workaround for ASICs need to disable SMC first */
>   	amdgpu_device_smu_fini_early(adev);
> @@ -5086,9 +5084,7 @@ int amdgpu_device_suspend(struct drm_device *dev, bool notify_clients)
>   
>   	if (!adev->in_s0ix) {
>   		amdgpu_amdkfd_suspend(adev, adev->in_runpm);
> -#ifdef CONFIG_DRM_AMDGPU_NAVI3X_USERQ
>   		amdgpu_userq_suspend(adev);
> -#endif
>   	}
>   
>   	r = amdgpu_device_evict_resources(adev);
> @@ -5156,11 +5152,10 @@ int amdgpu_device_resume(struct drm_device *dev, bool notify_clients)
>   		r = amdgpu_amdkfd_resume(adev, adev->in_runpm);
>   		if (r)
>   			goto exit;
> -#ifdef CONFIG_DRM_AMDGPU_NAVI3X_USERQ
> +
>   		r = amdgpu_userq_resume(adev);
>   		if (r)
>   			goto exit;
> -#endif
>   	}
>   
>   	r = amdgpu_device_ip_late_init(adev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> index cb9ffb17ab98..cc5d6250ac69 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> @@ -1980,9 +1980,7 @@ static void amdgpu_gfx_kfd_sch_ctrl(struct amdgpu_device *adev, u32 idx,
>   		if (adev->gfx.userq_sch_req_count[idx] == 0) {
>   			cancel_delayed_work_sync(&adev->gfx.enforce_isolation[idx].work);
>   			if (!adev->gfx.userq_sch_inactive[idx]) {
> -#ifdef CONFIG_DRM_AMDGPU_NAVI3X_USERQ
>   				amdgpu_userq_stop_sched_for_enforce_isolation(adev, idx);
> -#endif
>   				if (adev->kfd.init_complete)
>   					amdgpu_amdkfd_stop_sched(adev, idx);
>   				adev->gfx.userq_sch_inactive[idx] = true;
> @@ -2040,9 +2038,8 @@ void amdgpu_gfx_enforce_isolation_handler(struct work_struct *work)
>   		/* Tell KFD to resume the runqueue */
>   		WARN_ON_ONCE(!adev->gfx.userq_sch_inactive[idx]);
>   		WARN_ON_ONCE(adev->gfx.userq_sch_req_count[idx]);
> -#ifdef CONFIG_DRM_AMDGPU_NAVI3X_USERQ
> +
>   		amdgpu_userq_start_sched_for_enforce_isolation(adev, idx);
> -#endif
>   		if (adev->kfd.init_complete)
>   			amdgpu_amdkfd_start_sched(adev, idx);
>   		adev->gfx.userq_sch_inactive[idx] = false;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> index b0e8098a3988..451890ee3fb7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -129,7 +129,6 @@ amdgpu_userq_active(struct amdgpu_userq_mgr *uq_mgr)
>   	return ret;
>   }
>   
> -#ifdef CONFIG_DRM_AMDGPU_NAVI3X_USERQ
>   static struct amdgpu_usermode_queue *
>   amdgpu_userq_find(struct amdgpu_userq_mgr *uq_mgr, int qid)
>   {
> @@ -520,13 +519,6 @@ int amdgpu_userq_ioctl(struct drm_device *dev, void *data,
>   
>   	return r;
>   }
> -#else
> -int amdgpu_userq_ioctl(struct drm_device *dev, void *data,
> -		       struct drm_file *filp)
> -{
> -	return -ENOTSUPP;
> -}
> -#endif
>   
>   static int
>   amdgpu_userq_restore_all(struct amdgpu_userq_mgr *uq_mgr)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> index be068e8e37d1..3288c2ff692e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> @@ -216,7 +216,6 @@ void amdgpu_userq_fence_driver_put(struct amdgpu_userq_fence_driver *fence_drv)
>   	kref_put(&fence_drv->refcount, amdgpu_userq_fence_driver_destroy);
>   }
>   
> -#ifdef CONFIG_DRM_AMDGPU_NAVI3X_USERQ
>   static int amdgpu_userq_fence_alloc(struct amdgpu_userq_fence **userq_fence)
>   {
>   	*userq_fence = kmem_cache_alloc(amdgpu_userq_fence_slab, GFP_ATOMIC);
> @@ -288,7 +287,6 @@ static int amdgpu_userq_fence_create(struct amdgpu_usermode_queue *userq,
>   
>   	return 0;
>   }
> -#endif
>   
>   static const char *amdgpu_userq_fence_get_driver_name(struct dma_fence *f)
>   {
> @@ -343,7 +341,6 @@ static const struct dma_fence_ops amdgpu_userq_fence_ops = {
>   	.release = amdgpu_userq_fence_release,
>   };
>   
> -#ifdef CONFIG_DRM_AMDGPU_NAVI3X_USERQ
>   /**
>    * amdgpu_userq_fence_read_wptr - Read the userq wptr value
>    *
> @@ -594,15 +591,7 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
>   
>   	return r;
>   }
> -#else
> -int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
> -			      struct drm_file *filp)
> -{
> -	return -ENOTSUPP;
> -}
> -#endif
>   
> -#ifdef CONFIG_DRM_AMDGPU_NAVI3X_USERQ
>   int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
>   			    struct drm_file *filp)
>   {
> @@ -968,10 +957,3 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
>   
>   	return r;
>   }
> -#else
> -int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
> -			    struct drm_file *filp)
> -{
> -	return -ENOTSUPP;
> -}
> -#endif
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> index ac7ac58e25a6..519b82f77cff 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> @@ -1630,7 +1630,6 @@ static int gfx_v11_0_sw_init(struct amdgpu_ip_block *ip_block)
>   	case IP_VERSION(11, 0, 0):
>   	case IP_VERSION(11, 0, 2):
>   	case IP_VERSION(11, 0, 3):
> -#ifdef CONFIG_DRM_AMDGPU_NAVI3X_USERQ
>   		if (!adev->gfx.disable_uq &&
>   		    adev->gfx.me_fw_version  >= 2390 &&
>   		    adev->gfx.pfp_fw_version >= 2530 &&
> @@ -1639,7 +1638,6 @@ static int gfx_v11_0_sw_init(struct amdgpu_ip_block *ip_block)
>   			adev->userq_funcs[AMDGPU_HW_IP_GFX] = &userq_mes_funcs;
>   			adev->userq_funcs[AMDGPU_HW_IP_COMPUTE] = &userq_mes_funcs;
>   		}
> -#endif
>   		break;
>   	case IP_VERSION(11, 0, 1):
>   	case IP_VERSION(11, 0, 4):
> @@ -1647,13 +1645,11 @@ static int gfx_v11_0_sw_init(struct amdgpu_ip_block *ip_block)
>   	case IP_VERSION(11, 5, 1):
>   	case IP_VERSION(11, 5, 2):
>   	case IP_VERSION(11, 5, 3):
> -#ifdef CONFIG_DRM_AMDGPU_NAVI3X_USERQ
>   		/* add firmware version checks here */
>   		if (0 && !adev->gfx.disable_uq) {
>   			adev->userq_funcs[AMDGPU_HW_IP_GFX] = &userq_mes_funcs;
>   			adev->userq_funcs[AMDGPU_HW_IP_COMPUTE] = &userq_mes_funcs;
>   		}
> -#endif
>   		break;
>   	default:
>   		break;
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> index dfa0830a4eb1..f09d96bfee16 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> @@ -1416,7 +1416,6 @@ static int gfx_v12_0_sw_init(struct amdgpu_ip_block *ip_block)
>   	switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
>   	case IP_VERSION(12, 0, 0):
>   	case IP_VERSION(12, 0, 1):
> -#ifdef CONFIG_DRM_AMDGPU_NAVI3X_USERQ
>   		if (!adev->gfx.disable_uq &&
>   		    adev->gfx.me_fw_version  >= 2780 &&
>   		    adev->gfx.pfp_fw_version >= 2840 &&
> @@ -1425,7 +1424,6 @@ static int gfx_v12_0_sw_init(struct amdgpu_ip_block *ip_block)
>   			adev->userq_funcs[AMDGPU_HW_IP_GFX] = &userq_mes_funcs;
>   			adev->userq_funcs[AMDGPU_HW_IP_COMPUTE] = &userq_mes_funcs;
>   		}
> -#endif
>   		break;
>   	default:
>   		break;
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
> index 6bb36187a53d..da5b5d64f137 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
> @@ -1363,11 +1363,10 @@ static int sdma_v6_0_sw_init(struct amdgpu_ip_block *ip_block)
>   	else
>   		DRM_ERROR("Failed to allocated memory for SDMA IP Dump\n");
>   
> -#ifdef CONFIG_DRM_AMDGPU_NAVI3X_USERQ
>   	/* add firmware version checks here */
>   	if (0 && !adev->sdma.disable_uq)
>   		adev->userq_funcs[AMDGPU_HW_IP_DMA] = &userq_mes_funcs;
> -#endif
> +
>   	r = amdgpu_sdma_sysfs_reset_mask_init(adev);
>   	if (r)
>   		return r;
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
> index 943c6446a0a7..befe013b11a7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
> @@ -1338,12 +1338,9 @@ static int sdma_v7_0_sw_init(struct amdgpu_ip_block *ip_block)
>   	else
>   		DRM_ERROR("Failed to allocated memory for SDMA IP Dump\n");
>   
> -#ifdef CONFIG_DRM_AMDGPU_NAVI3X_USERQ
>   	/* add firmware version checks here */
>   	if (0 && !adev->sdma.disable_uq)
>   		adev->userq_funcs[AMDGPU_HW_IP_DMA] = &userq_mes_funcs;
> -#endif
> -
>   
>   	return r;
>   }
