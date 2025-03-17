Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA0D4C282EC
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Mar 2025 08:17:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F3B710E387;
	Mon, 17 Mar 2025 08:17:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1YZ8hyD7";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2056.outbound.protection.outlook.com [40.107.236.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0364910E387
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Mar 2025 08:17:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KBYi4e/Pnfusyt1wJz70iUAEV/6GCB57KLSaLb3ogLjRY9zNMUZIf8hQweTwkZ4hwcthObRRuQREu03EJNwdDAP8e6MoqJGZ5M6DdicMuPyNvKjJR6siEEVMa3ZBbnVvsYyqFCCPuYxNGiJQcqtfCOPFiIiii/wTDtY00kPYHXGpMmiPeyBsI9eWx+D4KPUQqm2nb3LSHHShlTXF2x3fP4sntkTp5dpF7Qe7bptUkjhc75GumSyMqeypuFRFOkF12ft4Q4PzKIqblZbPTPQ2iLXeos04V6FLKK8pYj9pkcscrxviYF9Lx0rGnen+z0QKn1Ik9bQ9lFf/l/OynVBcIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PC1gf2yvbyBtJAQ3upcNCNde/NNWNztrqlCejKzZno4=;
 b=jGt4mckCEwb3gq3xJokZbuzVOXKJ5TZZGbfgyBb1tiYdrtSRn/7OtyxNnlFs56rPKzT+NIu2qseya7sFasFRsw8JkXkb+82jH5SMYlKlVvYEzDYqIMOabMc54zL2dStkjUFTsR2z6VS0pF19k+mjToZLC5Nc2lyT8Dsp5BhZywsZFZNC7WqgVwJyRHcX9sJTYsJzjC4cSIv8rNpSLm/BwZF+8kaqtTJsOkkwLJQBqtEFYqWMdwcWkoWJOYLvDxK6vQVUFP29zYYyALF55fYo0YjIY5XbOye54B7CYsmLHcNb9nOjtxrLUC1LUJNFeCAvPdaqVzFXvffqbBYa4LFtxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PC1gf2yvbyBtJAQ3upcNCNde/NNWNztrqlCejKzZno4=;
 b=1YZ8hyD70ogwkff5Rji7DFL5vmO+dYJw/uzOfkBzCiUZIZjiEQtAYIUUtMVQX6fljk6i5MzmgC6DgPvJV2558LBRrpBRgTdQdIojm2ov7lTB4GbuVJPYD7b/FYKu0JgbjuYnbNxDMFM9AHraZx2Qpj7leRmPZp6a3HVhJk8k6hI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 SN7PR12MB6909.namprd12.prod.outlook.com (2603:10b6:806:263::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Mon, 17 Mar
 2025 08:16:57 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%5]) with mapi id 15.20.8534.031; Mon, 17 Mar 2025
 08:16:57 +0000
Message-ID: <0300d3ff-750c-467c-a176-340445747ff0@amd.com>
Date: Mon, 17 Mar 2025 13:46:50 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/amdgpu/gfx: adjust workload profile handling
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20250314184559.3607419-1-alexander.deucher@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20250314184559.3607419-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: KL1PR01CA0075.apcprd01.prod.exchangelabs.com
 (2603:1096:820:2::15) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|SN7PR12MB6909:EE_
X-MS-Office365-Filtering-Correlation-Id: 744211db-d587-46c8-a459-08dd652c15c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Y1hjNVQvcGJkVkJRRTd4ZUFlYjBzZWFsdXZPeHd1N0xQZ1ZkNnNpQjVpcUl2?=
 =?utf-8?B?dEVsSFRGY0xtRkVZcUlzTnIxcHp3UnhqL2FyUllQb3BKMDM3Zk5tc3NYdXIv?=
 =?utf-8?B?UmY5T1BvZkxvUWFHMm9BdjFrckJveDA3ZTM4d2QrL0U5Y1FRVWdvaXBjaFpG?=
 =?utf-8?B?b3o2dzU1QVlqMnV2ZDQxbUFCUyt3T1A1UXcvZkpsUkYvYjNzU0ljMHY5MG9D?=
 =?utf-8?B?OE9ZWVVycGZYbVhIK3VLdzJUWVl1TUl2cEwyN3ZaSzN0eCtBMnhpZVM4S3N0?=
 =?utf-8?B?aGxSQmd0YWZoelYyc1ZlajV6Q1JtUzQ1QlJlUkVyTm5GNzdDdENGdGgrY2Ex?=
 =?utf-8?B?R1dNaElSMXY5Uzg3TWZpTzJoM3ZxNVR0VkUrMlgranprckhVNFE4bklsVjFp?=
 =?utf-8?B?cjg2RjZkT2Vaa1VHenp1Y2ZZL1FUckFxQ055WjYzaUR4U3VhNW5kUVF2bnV3?=
 =?utf-8?B?TkMwTllsY1NVSFUzRU5RaDVUaFZ2K2k4bmtDa3FnQThpcTEwN0FyN293UFN4?=
 =?utf-8?B?eUh4cTdybXJjb3FJU3gycWVZalNuQUZrelVib0JaNlhLUjZ5MzdYenRQUVBj?=
 =?utf-8?B?dEY4Vzg5aG94SDdMYWM1ZXdSQ0d1MXdvaHN4QXJNMGdkblVGZWd1T2tDaE9l?=
 =?utf-8?B?L0NKbzdydDBERlNlNkhoMFA5Q2RpVm91cUE0cVhCc2V3ZHNCZWwvWXFvUnlC?=
 =?utf-8?B?RmtNMUM2dFFPSFVJMUxxam1CWFRrZmFoZUtydWJrTnRoKzFRKzlwS3VmQ2JI?=
 =?utf-8?B?SmVDbVZRSDYvRjYwVU9tSVVNdjlwZkNBaDN0V1RHallGVndDUzViVjJYNEFO?=
 =?utf-8?B?V29tY3Z3ZnREWVI1YVYvQ2hJVm12TFplV2Q0RWtmWXFUSGRZVy81a3AySk1m?=
 =?utf-8?B?NVdhbWtRNUthd2tRbHZqdG5UdDNEQ2ZZbExzMTVpZXFFTXdvVURkN0F1eUJI?=
 =?utf-8?B?N3FoelRyazQ2VWEzbjgvRUpvN0dyNUhnMHNBMWsyb3o5TE5DdGFVNjhIU09D?=
 =?utf-8?B?ODNVcXE3a1VMMXVmYnFpKzhrVDRlemVUaks1WG12VGZROXhaQjJtTEs4VFov?=
 =?utf-8?B?d0krWjgvK2luTnoyYkVsS1UwZjFpVHptK3RLZm5PSFJWeWd5L0dtZDZjRFVS?=
 =?utf-8?B?c1RBWU95c0xTRGcrWmdXSnNtSmtxak0rNGw3ZUYwRmRWbUpCZjR3VlVUN1dk?=
 =?utf-8?B?NU1JVklBdTdRMlZOMjdoRE4wc09UV0lrNjUxL1FBQTRySGZocVFaQ1BGakZ6?=
 =?utf-8?B?b0tlcGlEWVZsTHA0b3pMTkVCSVFiNXdJb3JmeWtidEhLNEJvYk1DeHZtMkp0?=
 =?utf-8?B?cE80aFZicUJ6RVM4STRLWEVwa1JDQUNjVmxhdjZCMFh3K0hJUnhEdWJQYmQ4?=
 =?utf-8?B?bXhLQklZbDY1R3FmWEpvRGtoTm0yZkd3MjEwb3NGa01pT1orSjBiOUVmV0pt?=
 =?utf-8?B?YXVSZmxWdyt6TUNmV2N4cFFOc3JVZk9KR0d2ZFA4RFlEYmNCV2lSUUdCeEh2?=
 =?utf-8?B?eVZ2VzRWbWFxZUtXR3RDYXoweE43d3lKSWhTUWlNSWJjV0xhOHpqVVFlZnlh?=
 =?utf-8?B?MExiRHVWbGQ5QUZjOXhDQ04vOCtzOUVpY2p2Z2pEbFRyamJGc0ZRKzM0b2x6?=
 =?utf-8?B?cHdPQWQ5WFRVU25HZVNxcjdDUUx5U3E5MGR0VVU5VHljQk9BSHpkdDMxYnpz?=
 =?utf-8?B?QVZzcjRGckg3Y3pMK2kwMUFBWERUZGVFdExYZlJ2UTdCOG9IekUwcEZQTVha?=
 =?utf-8?B?UmdjenZKY3NPSWo2bVhrNForUkhWT3JaUGdNRFduQmdCUFEvSFNkMmdHb2ZN?=
 =?utf-8?B?eGNualVnQzZReTFOV000dnJmUVhBSHZPa3phOXhrcGVac2tMVkIvQnZQUmgz?=
 =?utf-8?Q?6NZgwqkRATICq?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dkxYVFBHaXNlVnZTNERnb1NpMkxoUTl0bkduTHgvc3Y3Tm1ZVmJVWW9aT0Q4?=
 =?utf-8?B?TmVwNUhZL2pmZ2pyMlF6WnN6YjlJVXlFTVZXVTlHUlVocW8xVmgxTmJSR2tB?=
 =?utf-8?B?My9Hd0w2bE1zSUV6eTQ0RTBpS3V6RkxVOUc4WUkzdFlKZXZQWWs4QnVNTVZ0?=
 =?utf-8?B?ZFFmN09tMjNvRkxGTFdIUU9ZakJTZ3JqYXRJNnBkUSs1SkxlelJrc0h0T1c5?=
 =?utf-8?B?NGZEVmVsMTZZMzhKckpSR0lsaWxqcUZ4aXJmT1pWaVlGMEc1SFRpc3BzSGFs?=
 =?utf-8?B?cXBiWlRoMWpyQVpZZWxHUXNVSC8xOHZLL2J0Z3pZU1lSa1BTQW01SkdkMTNV?=
 =?utf-8?B?Z3NjWVd6WDJFczg5TDRnS3RyK1lmdWJaY3BUZ0loaVBibWUyS1d5RTlDMHMx?=
 =?utf-8?B?RHhmcFF4RVFCRWhKVTNPZ1hkbUNHL1FUTXhieVVZSXlzWERzRlRWLzJNTk9v?=
 =?utf-8?B?MXE2eitMWmtvc2FyS1h0UzZqdDg1WHJ2U1RMQ0xJdXl3VmZuVnVqaU1LQmpG?=
 =?utf-8?B?b1phVGtJNkZPVVVZcHNRbktKakR3MTcwT3RCbVF4Ukd1WCt3cVBEWWNkRTh6?=
 =?utf-8?B?WEFnckM4NEhVcGJ1b2FGYzJ0ZUpZQUdXQmxkWkVndFJKMnRJSzBCaUhIZ1Zk?=
 =?utf-8?B?blp6U0g2MGVLSXlTcnJ6d1ZDbnBsMnRWL1ZnanlCSi84K3BtMitJTE51MmVY?=
 =?utf-8?B?anRLblZQZ204L1hueVFkRDBpZXJUN25hY0dFbzhyVmFNQ1UrU3Jkd2twMHZC?=
 =?utf-8?B?NDNwc25GZ3JpcnhBR2pQbHdPMWtOODlVVVByNXdiQ1VvT0RSODhRQW5MTVhQ?=
 =?utf-8?B?MVNQb25TMTR5YVVrMEtsOUZ4YVB5ZGtkd0Y3OGtzRms3U05ZcXVYRitxelZF?=
 =?utf-8?B?eXFpcGdaRFZPa0N6N2tCaUM4dTM4R1BZcEE4L0MxV2VqOTREdWZ1V2tSYUFu?=
 =?utf-8?B?dXNEZDJVOTQvd2hNZk5EVDg3cmZFc0NyUzg4bi9TTGRjQ0dTZFBBTkFRcExz?=
 =?utf-8?B?N3JWdXU4eU1hdEJ0azQ5NVJoTnF6YmFQcERPd29yWUJYTTJpQmNLUkU0SFFK?=
 =?utf-8?B?ZnRhSjNtcTJwNW9XMGg0czYxTmhINXRWbkUxVVBFdlR3bFFvYm5RM0N0OTBn?=
 =?utf-8?B?c1daRndCQnNtc3hRbktBUjlsdURBQm9Ddzcxb3ZpRkJIa3hmbFlUelNKdWdY?=
 =?utf-8?B?UVhIaVZoVVZKdUxpM1ZWWjhBT2h1clg0WUdUOTlCOGpwT0VKOTljYjliUkx0?=
 =?utf-8?B?dWF2MENLa1llSGFYV0NRcUtNM2VLeW5ySlBCTmw4VDlnQnJBVTUvQW1vaTV0?=
 =?utf-8?B?UzhsUjJTU2VvbzlyMmxJZnZDTkJ0RHdNK3JtajdLV0IyNmlHSldoNVhrMGZl?=
 =?utf-8?B?Qjhsem1PUHZpVXFpc0t6bGhTY0EwdU51UktDNVRwbHBob3lNVG9yZnJSQ2FW?=
 =?utf-8?B?T1Y1eER5R1FJeVBLSWZaQmFkNGs5d3krVElFN3RGUXRZRnRYcXl0L2pUYXYy?=
 =?utf-8?B?ajkvcUkxd3dBbmtMWGQrTnJCTWRmR3VpN04vSDF3K2RFc1JHUDkyWjNBdnpo?=
 =?utf-8?B?UlRvcGhhNzVHd09GMU5ONHFEOEtGcTBWbU05UnBneDNzSHQxL3pTTlI0MjZy?=
 =?utf-8?B?UE9BSFpwWk5pa2VsTGtIQ1J1ZkZBdFpZSVRnalVlcGN4bHFVN0h5Z05scis5?=
 =?utf-8?B?Y2dJdjZURWh4bU05U0NMLzVPcjhNUWtuNkprdmg3RnR5SnZsN3RWQVl2V1Vh?=
 =?utf-8?B?VUE3SVdwYitXQVA4QTJUVWhOeDBGTzRVVHdZZDdtS0JXTHFKeFMwVlQzajQr?=
 =?utf-8?B?R3Rac21rTnJxeVhhdnA0Q0ZhdkwwdUFSZS9jc05wOU9IMVVqNDVZL05sM01u?=
 =?utf-8?B?N2twWXg0M3Z3Tm9sNW5ETW1VWkZnRGpUSStDcGUySTROaFc0b0VyM0RaWTZG?=
 =?utf-8?B?ZW03UHBKckJtbFN2d0FYamRxWlE4SEJiL1NhNzZock5VUnA3WTNMRk1vdWl4?=
 =?utf-8?B?WUdvZDZzSE41cnB6S2pRYzFUVnZHNFBjTjFPTEJ4SzN2dmtwSTBPdGFCQ0Fo?=
 =?utf-8?B?dTYzK1BCQkhxbVJzdDRHZzdMeFRaaWdSVlFlVmc3djJaRTJ5SGhiRzUvWjBu?=
 =?utf-8?Q?uH64=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 744211db-d587-46c8-a459-08dd652c15c3
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2025 08:16:57.5881 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zUo9qwPjUFzsOn6KjarSprLFfz13dGoD3fcaXWIQHBZMfaI/dkS4lKmh4L0xeuC/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6909
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



On 3/15/2025 12:15 AM, Alex Deucher wrote:
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
> v2: bail early if the the profile is already active (Lijo)
> 
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 29 +++++++++++++++----------
>  1 file changed, 18 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> index 099329d15b9ff..4beb0609e7034 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> @@ -2188,18 +2188,25 @@ void amdgpu_gfx_profile_ring_begin_use(struct amdgpu_ring *ring)
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
> +	/* We can safely return early here because we've cancelled the
> +	 * the delayed work so there is no one else to set it to false
> +	 * and we don't care if someone else sets it to true.
> +	 */

The same may be extended to vcn also. Anyway, series is

	Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> +	if (adev->gfx.workload_profile_active)
> +		return;
> +
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

