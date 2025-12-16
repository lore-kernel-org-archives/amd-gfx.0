Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 513F7D5B87C
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Dec 2025 06:23:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D192410E0D6;
	Tue, 16 Dec 2025 06:23:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gIc9JDXb";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011005.outbound.protection.outlook.com [52.101.62.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0AE8C10E0D6
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Dec 2025 06:23:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Apt1x5ZjRXVo9mo/jxOW1/fLcO6nvN+f/ZKtDm3/IcPPt/f8nkCcD3O0FfIlcLc+ODoNoS8a6RX7W4Sywyv/TYSVZMbBFbxyLly2DaWn64CoXx+/q5KEL/GE79CF+DOdTFN2C/6mBcxohLW7Im4RRM+8/9S3XIeOL9Gs+6WtBG8la2GIk3BlI3cqtbGLPK/f9SaC5H7abrlGYDahDVKfdOqq4KEVGbwleMQdjVfuRoZLowR4AUkWSJMitqKlwXROTcQRslIX7dmcyaWiMrPM9fQ1Rl96QWTgm3k96tuN1dbKf5bSoWoANQ2VF6JLuEv4qwk5raP46Cir8UXnCwITgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XXMfBkh+i+B+hGVOhgLTIz3J5ECIkqgRsKUksnqD1Co=;
 b=BQqkJkm/vQSM7nJvYIKrVMW3yJ+aIwlktq/psMaEHhHs5CuGhjwr6fWfquv/yW9mJhe/Ymm1/bMqpbTGiMwJCFwbh4YmFiChkS0sTah+C/m5Wt88SsWv4+f2DriqsPicI5Ejz3hqO0+Tou0JeggBXY6/V5L3HEMDsHzfuxwmtMQx4obamyoyQ0pGVmIHx0Q5iL7yFoSmNPsIiBP9lGF2Tuc2Ff032C1JXpb/KbJOoxHvHzPazomMg2isr7ykOJhSOpWoX1gMC3t4/POSP61NoFQbbkrj+gZyfeF5t2XXH/n37zc3tdgrWpfY8yF7tlhTMq69YSydVF/xMIS3BiSNeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XXMfBkh+i+B+hGVOhgLTIz3J5ECIkqgRsKUksnqD1Co=;
 b=gIc9JDXbptSKovqmlVY3N5/+/IE4vHCnal/SEFe3XEzRn3rODiPyUkUCSd8pI3mp57/NPTjX2uohWdBtkurgMLwIUQ4ZkmPoVTNHnbqCF0HiBy30gZRHWUjQWm7m9ulGB5c+LsUAx+TXnJSE9VXlsHwB7Plvomh8ngFFmYjx+h0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by MN0PR12MB6150.namprd12.prod.outlook.com (2603:10b6:208:3c6::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Tue, 16 Dec
 2025 06:23:04 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::d759:a62b:f8ba:461d]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::d759:a62b:f8ba:461d%4]) with mapi id 15.20.9412.011; Tue, 16 Dec 2025
 06:23:04 +0000
Message-ID: <3dc170db-c7d3-4818-9fe3-5981aa03cf42@amd.com>
Date: Tue, 16 Dec 2025 11:52:58 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] amdkfd: Add device links between kfd device and
 amdgpu device
To: "Mario Limonciello (AMD)" <superm1@kernel.org>,
 amd-gfx@lists.freedesktop.org
Cc: Harish.Kasiviswanathan@amd.com
References: <20251216060046.3131-1-superm1@kernel.org>
 <20251216060046.3131-3-superm1@kernel.org>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20251216060046.3131-3-superm1@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4PR01CA0081.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:26d::10) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|MN0PR12MB6150:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ffa8d6d-b08d-48af-fb0f-08de3c6b91be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RWtSK0dNSUtTQTR6eW5YNWZTN0hJSzJIOGI1OS9GUUNMS0I5SzR1ZEQ0eHFq?=
 =?utf-8?B?eGUxemdseWlpb1QwSnIyTmdLVkprdkVhNmlNZEJ6eXc3RElMOHNKVXRUQ0tF?=
 =?utf-8?B?MFN0RnN1b3ZSU3JmTUkrdXNGSXJ2cTBpUm0rLzRtWFBwRkl2N09qekFrd1U4?=
 =?utf-8?B?d1pQa29GT0JPZUVSSXF0Ym9DTmRDOXB5alVYR21GL2dwOSs1MmVlZGVyZXM1?=
 =?utf-8?B?OEVDa2hOMURkZGVuSGI1VmNTeHFmNk9PdWhPbGY2SXdjSFZET1lRcDlVbG1D?=
 =?utf-8?B?QWtTVjFKTHk2VFJtMlllMElQNmVkRFZGWENIblgxbTZSZnhicEFzam05eTRY?=
 =?utf-8?B?WTFZTnYzV0R1NGM0cGJQM0l4SlZxNXNGUWlvak9LY0l1NkNqZk5ORmpYMXd1?=
 =?utf-8?B?Ykx5bXRBOXA1ZDZGTEZTWDVmSEdGZldBZERKZ0VDczFDY0hUeXhoSWh2ZUtL?=
 =?utf-8?B?VmlKdlhST1dVQndaVy9jTnN4WVViKzkzY0ZiWUphRUxQSWs3TGdNUCtHUzBk?=
 =?utf-8?B?eVNZMHY5RW91RENYNjNhWHF0cElUK0xDWXJoOUJ0U2hONnNoSVllQWFBVUJm?=
 =?utf-8?B?blA4eDkwWElmNUJOYTNzWVI2TFhoWGpycE14bnluejlvSTNLaGw0ZWpIdUdr?=
 =?utf-8?B?V1J1WFFObWdiYzllUkxvWE1jaXhjbGN0ZFkyMXo5VjcxVjZ4QnA4MFZLQW02?=
 =?utf-8?B?MmVyVVNxOS92K3Nrdzc2VXZCS3Z6QmZXUVBhOExVN3NHWjVOaldvY1VBazVO?=
 =?utf-8?B?WjVpTzB1OXdNSGRiVGQ4UG9adEhQcENjeCtTTGNrOVhWQnRvUGxHMmc3d0R2?=
 =?utf-8?B?Ump0REtWSnZyMmtkdU10ZWMyZ29iUEltS1BPWUVSTG5SRkQ2b3hXaDFUSFF4?=
 =?utf-8?B?SjNwclZkN3lTQ1BDSDFBMHltKzhGNEloeEJOMEJ5Snhady9ONE5QcUZVSzhL?=
 =?utf-8?B?NUFQaXZ0akc2M1dDUTByZmVGdW1KL2h0SFJTS1MzWHM4MTNGck5CVWYrOEJm?=
 =?utf-8?B?dHRlaHd5RC9YRjlGRmJKaENFNG9rQnBNM1lMVWtkYnNnbGVveUh6ZnhpT1NY?=
 =?utf-8?B?WUFlejVhUWJtS3RHU2NxSklOQzNPOHoxWEUvUVpSeGZTMXNFZFlmRFBaWTFQ?=
 =?utf-8?B?MUZ1Umh5RHpVZFgySFNxMnUvMFFteWg4d3YvVGRBeWx2bUVabnNDVmpiNWVC?=
 =?utf-8?B?aTFVeHZVNlhCamVUZ09XZGxwclQ0VWh4TWJ0L25HZ01MR0U5Sll4TEp1MVMx?=
 =?utf-8?B?UFhDTkIwOURqSGYxTkN1RE5FS3l6bWhFcFQ4SmF6bjNlaWk2M0UzZGtsdzU5?=
 =?utf-8?B?cTVaRVJQQTRYU3lUa0xkemdoVWNFU0lBVTR2WEhXSTJrazE0OVpldGZsd044?=
 =?utf-8?B?QkNxZFBYTllYVjdhemxVdDdscXpCaStsZldjRHNVdmhLaCtyZVZLNUlIZFRR?=
 =?utf-8?B?MGdjd2ovL050bVRSeWJyais0SmxxWFN5V3h3VkQ3U3hrblQrZnFwYlN0UkJ2?=
 =?utf-8?B?NkxTR3F5Mk1xbjQ1Y2Q4OGZwc0x0eTVSYzRFcHFyY1hROHN2NmFjY0hNMFZ5?=
 =?utf-8?B?QW1jUWJpWkFuMU9ybzIxN3REZjlLenc5NHh3ajVBNVBNcXhXVVVuTVp0OGJ5?=
 =?utf-8?B?bUFWNU1nOS9qSzZEdWFuRVNsbVp3N2IyNGdmVTlVZlVCOThUKysralNGaURu?=
 =?utf-8?B?cmFvU2gzZEVxTGJQTzdMbzYwNXpuemlPdGU4NTU2ZnRCdnAyK3AvcVROcGRG?=
 =?utf-8?B?dkdwcFRmSHd5YzJIYlBRdVhmOWJJZkRpM2dLL1k5TXNZak9BWGM3ZFB6RFZy?=
 =?utf-8?B?MDRZYjRKb3V3N3I3dkM3bjZjdWdSUXB6V3NpOUF6YllDVHlxUTZxVVpGcGpB?=
 =?utf-8?B?RGNJTUt5dncyZnRkbkU1WTZUaWJVbEErRjg5T3N0eUIxakNwTkNEUzI0Mkxi?=
 =?utf-8?Q?LsDoaX9RC8yBasJKROOi+bO+btgHWW99?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cW5RK2toTjBKTkdMMVl0WkFXYlFzZy9CdTZNWDM5eXBQMVlXeDhVU1F6ek1W?=
 =?utf-8?B?VGVjQnIxQ1pmMGZmVHY3TlBTbnRDeWpwM0xMQlJ3NS9BMVBDZjNWS2srajM1?=
 =?utf-8?B?bElPYndkbTJhbkkwazkxSVRsanNJWG9DSTUwY1hhMFU0ampLUHdXT0pYcUMw?=
 =?utf-8?B?SDhJeUlCaG05MVlZNEFPZEY5Q1BMbjNOWG1iLzNXaW9DQWJweUJyOHFjYUtv?=
 =?utf-8?B?U0tWc2c4R1hZNmhzcFFQNFRtZWt1WDlQek9TM2srdkFyZ0lvUzdRWG9FOVhL?=
 =?utf-8?B?UVNWeEFUdEIyYTl1YmkweHBnOEMzZS9XUUJ4VFJ1SjdJTXBZQ3VSKzVKdVIz?=
 =?utf-8?B?V0RzT0VFeUF5VStNbmQrSkdtVGwyeVd1aEJaOEpxdWJhN3RtbVZ2YTkyUGEy?=
 =?utf-8?B?M2x5cGJNS0NXOHhielNGVjdNcGVadUJWbStGWWNJYUh6Y0VPamlzWjVNSkZP?=
 =?utf-8?B?N3A0eGxoaGcwWUw4UTM3WWJIMnBVU0dkQnpFUnRSeFFHOEdna011MzJWRTZi?=
 =?utf-8?B?anloUEtyTGVsVFZ6WElsa1VpRHZQSnZob3dmRVBBbzQ0amNsVytNcXVpaWp6?=
 =?utf-8?B?R01McnBlLzMwbUZ2S3RhMFJIYUMxTnZPZS85ZGcvQzJJMnpyYUU5M3FyeE92?=
 =?utf-8?B?aWVGeEloODNxWEJhR1JzVmlERkkxcUUvZlh0eGhUOXREby9VSEg3NzhoaUR1?=
 =?utf-8?B?bm9tZ2tJdUFVWXZ0TDcrQUJPeVgxdnBCSnJqQ0hKQnJFT3ZmSEMrUDBTMkc5?=
 =?utf-8?B?U0UwS2hwUjdVSXpxZHMvQkRHWFdJVFFvRTlDNllUQjMwdUhNb044N2ZIbUR0?=
 =?utf-8?B?dDFURGc4dW11K1RkQzdsUVc2YVM3MStJdHhkVUM3dTFNY1kzZ1g0aFRFc1Ry?=
 =?utf-8?B?S25CeERzTjN6MEE4TC85YjhiclBUd2hqZUNiYXNibjV3OVBrNVE4S2V3Mnkr?=
 =?utf-8?B?TGVpQTErOWdOMVowY2RNSkZPWEpJdjVmdlViNXFNcWFUZ25sS3dFRU1vVlQ4?=
 =?utf-8?B?alpRZU1yR081Ynpja1ZWZVh2TVd6dEFCL2Z6NlU3KzBHZjNXbTkraG03QlBH?=
 =?utf-8?B?cm9hOFNqVFRKYWQzN2hxVzBLRXJSV0U5eUpaeW9RcXE4RkRWbGppT3dpOGlZ?=
 =?utf-8?B?MDVpR0loeERXeGNXekF5Q3hwMHRPcWsvdEExVjl3SXlZVWp0QktOTHFzREtB?=
 =?utf-8?B?NFRzcHBndXhEVTdzTVZGc2hlMGhMdUR0bEdvYnc0K3lacHUxVlVBbjYwazFr?=
 =?utf-8?B?VisyZHVoWXlhUDZ3SjUrc0xrMUUwMy9GU1pxQkk0WHpkUGpxTWRWRlhUaVFR?=
 =?utf-8?B?ZXkwSTYxU1grUVdGamd0OFY4MnpNUEoxV29NeTQzcW56cUF1S3JUallIaVNS?=
 =?utf-8?B?MHRXWUNyVzNwUEI1MVUwTkdINHM2blpiRlhSem55Y2g0WnBYWWhiOGljbVMz?=
 =?utf-8?B?c0swRFd5UUxvQnBYMkl4YlZ4dlFwb1RxVURVZi8wTk9VSmlJL1hyM2o5N1Np?=
 =?utf-8?B?eVZ5VnFPR0ZQR1pGTDIwZ2luZVVVWFM1WFE4OUcvUkZPRkFJOUZycFU3Y3dv?=
 =?utf-8?B?a0s0bWxRQUFSN1U5enMwTmduekxTUDdvOFZLem0zYXB5VWZHQ3lUR050VGRv?=
 =?utf-8?B?MytwUDRVTHRvREFEbzYyU3Y2MnVBSjdHUHlnck9WTUg4QWtvY1A2TlBJZXJM?=
 =?utf-8?B?dzFwNWFpMjhqbzJ0aTFWNTdXV25iMkxhVFpZVURVMEhhZ0lxMmxVUWg4cEZ0?=
 =?utf-8?B?Z1B5dFpQL0FYbGo3Tm5YLzgwaENrcWZMYkV0VVU4YWlKL3kvQ3FmTGFmb0pt?=
 =?utf-8?B?RkNTUkdFUlBzam1jTjZjZ1ZiVHNPWVNzUlNDY0lFaWFPR01ESTZTbnVISjV3?=
 =?utf-8?B?cEtqMUUrT05FSU5hU2dvaWt4Y2FTWkZrRkhFcENyTDRvbitERGtZWXRoZDB0?=
 =?utf-8?B?WW4xNGw3Q2FzTTlza2xISEkxUUVhMmJkbGthYkZNeWVTQ1JlT0FGaFV3T0dW?=
 =?utf-8?B?VTN2SXVqRDlMUjJQazZkQ1ZHUWhJR2xkTXpSOEN3cUwyT0ppbS80N3V0T2sy?=
 =?utf-8?B?RVJLQ3ZrWXk0MGEyd2pmZDZ1ejBrcmtSQ1BxdU1qTFRieFAwZDU3MWpPeU8v?=
 =?utf-8?Q?yfnn6x0C4BPvJXzgbqnFd36Vl?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ffa8d6d-b08d-48af-fb0f-08de3c6b91be
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2025 06:23:04.1029 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XALVBgDUMhQBBZXpYGcfU4eJCOIw9ui0jW6jyxW+ZlTMEDF05zxRAbaJ/1tme41h
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6150
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



On 16-Dec-25 11:30 AM, Mario Limonciello (AMD) wrote:
> Mapping out a KFD device to a GPU can be done manually by looking at the
> domain and location properties.  To make it easier to discover which
> KFD device goes with what GPU add a link to the GPU node.
> 

Access to the full device is not desirable in container environments 
where it is restricted to the particular partition's properties.

Thanks,
Lijo

> Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
> ---
> Cc: Harish.Kasiviswanathan@amd.com>
> v3:
>   * Create link when topology created
>   * Only call update topology when amdgpu is called
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c      |  8 ++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h      |  1 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c      |  4 ++++
>   drivers/gpu/drm/amd/amdkfd/kfd_topology.c       | 17 ++++++++++++++++-
>   drivers/gpu/drm/amd/include/kgd_kfd_interface.h |  2 ++
>   5 files changed, 31 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> index 67a01c4f38855..870a727d6e938 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> @@ -910,3 +910,11 @@ int amdgpu_amdkfd_config_sq_perfmon(struct amdgpu_device *adev, uint32_t xcp_id,
>   
>   	return r;
>   }
> +
> +int amdgpu_amdkfd_create_sysfs_links(struct amdgpu_device *adev)
> +{
> +	if (!adev->kfd.init_complete || !adev->kfd.dev)
> +		return 0;
> +
> +	return kfd_topology_update_sysfs();
> +}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> index 8bdfcde2029b5..07aa519b28d45 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> @@ -268,6 +268,7 @@ int amdgpu_amdkfd_stop_sched(struct amdgpu_device *adev, uint32_t node_id);
>   int amdgpu_amdkfd_config_sq_perfmon(struct amdgpu_device *adev, uint32_t xcp_id,
>   	bool core_override_enable, bool reg_override_enable, bool perfmon_override_enable);
>   bool amdgpu_amdkfd_compute_active(struct amdgpu_device *adev, uint32_t node_id);
> +int amdgpu_amdkfd_create_sysfs_links(struct amdgpu_device *adev);
>   
>   
>   /* Read user wptr from a specified user address space with page fault
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 467326871a81e..d4c8b03b6bf57 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -5123,6 +5123,10 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>   	 */
>   	r = amdgpu_device_sys_interface_init(adev);
>   
> +	r = amdgpu_amdkfd_create_sysfs_links(adev);
> +	if (r)
> +		dev_err(adev->dev, "Failed to create KFD sysfs link: %d\n", r);
> +
>   	if (IS_ENABLED(CONFIG_PERF_EVENTS))
>   		r = amdgpu_pmu_init(adev);
>   	if (r)
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> index a95be23fd0397..5f14c66902f9d 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> @@ -571,6 +571,9 @@ static void kfd_remove_sysfs_node_entry(struct kfd_topology_device *dev)
>   	struct kfd_mem_properties *mem;
>   	struct kfd_perf_properties *perf;
>   
> +	if (dev->gpu)
> +		sysfs_remove_link(dev->kobj_node, "device");
> +
>   	if (dev->kobj_iolink) {
>   		list_for_each_entry(iolink, &dev->io_link_props, list)
>   			if (iolink->kobj) {
> @@ -819,6 +822,18 @@ static int kfd_build_sysfs_node_entry(struct kfd_topology_device *dev,
>   			return ret;
>   	}
>   
> +	/*
> +	 * create a link to the GPU node, but don't do a reverse one since it might
> +	 * not match after spatial partitioning
> +	 */
> +	if (dev->gpu) {
> +		struct kobject *amdgpu_kobj = &dev->gpu->adev->dev->kobj;
> +
> +		ret = sysfs_create_link(dev->kobj_node, amdgpu_kobj, "device");
> +		if (ret)
> +			return ret;
> +	}
> +
>   	return 0;
>   }
>   
> @@ -848,7 +863,7 @@ static void kfd_remove_sysfs_node_tree(void)
>   		kfd_remove_sysfs_node_entry(dev);
>   }
>   
> -static int kfd_topology_update_sysfs(void)
> +int kfd_topology_update_sysfs(void)
>   {
>   	int ret;
>   
> diff --git a/drivers/gpu/drm/amd/include/kgd_kfd_interface.h b/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
> index 9aba8596faa7e..0ee1a7d3a73f5 100644
> --- a/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
> +++ b/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
> @@ -335,4 +335,6 @@ struct kfd2kgd_calls {
>   					  int engine, int queue);
>   };
>   
> +int kfd_topology_update_sysfs(void);
> +
>   #endif	/* KGD_KFD_INTERFACE_H_INCLUDED */

