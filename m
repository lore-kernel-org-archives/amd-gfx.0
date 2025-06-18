Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAB89C7115B
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Jun 2025 09:05:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 74D6310E79E;
	Wed, 18 Jun 2025 09:05:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BcaxbU8N";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2079.outbound.protection.outlook.com [40.107.244.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BEFE010E79E
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Jun 2025 09:05:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WFVcYSr1EQWkSKq0Up+Z7++LBe9c9ZCz8i+I1Jg5kNikPISiTlnUW5ZDQDGyDwokJsqr2fGTEI0Fjtz7x9d7Q+d/Lq8xgeCzZ7ip4rgCN6dIhTanmEVQUCPl7Snf53VAl0/LsLZU9DVnA3pq0O1FT3JY++umpQ7nTq90ubBdQo61MYCtj08VQfFOebgXhsVcUj77Zazq+ofDNAA96ayraCkPpIuysHbULKQtwvkZw/GT6ZMUHsFaktw/nz0rq4EkDScc9nA1HxSnUwpsj6Ea2hS3ZtKozFX35GzbME85XXAsoBrls1pY6yIHGU1Lkwy7DF6J2HJsuPVesy9CyqoPjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ukOM/M7tplr++uborLHZzeEE47aK2kKtNyqIbveZrhc=;
 b=UClueeAXLqpF4ivIS8+R1kXMwP5dMG93f/IELMMKh/IIhrny2Ld8Zi1UzrihqjD7LeDVy3tI/I2+XPriTTTADzAv6I1b7w2foVKswXC08HKW9pC2yeow0QO9+PxEIDSepygTTLs61L0e+ek+C5JyxgOckfcOSDZ1RPZF6V7nva6revAr7SL9OAW5T9ufq4aNPqTilzKbO6ndmoT1Ood2SbxADy+/+xI8ozKRhlxczZ1+7gWVhJsxnOPRpzlq/eTd8sMTYpeduB2DiHrP2ff8dUY30h0VAy3DLUFDHYKpqVAKVDfky31HwjTrrlocKPFjsXGRsF8LpBCSIMeJNxz/Yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ukOM/M7tplr++uborLHZzeEE47aK2kKtNyqIbveZrhc=;
 b=BcaxbU8NIfI/C59EnG6U5PHGGP7Aj+ePqcWqg204TSn9BpTsk41f1MRQAKhO5AUnMCY3LwveYxP1SMoyDCj0k9uCbJSx4n5fh26uHEF3Kx059KB+PR4Yb8DwR8t8g1n0InOwRf0mRWZg5u2LTLsMiUcz6kEkY+vaDng5UyEPDh0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH7PR12MB8794.namprd12.prod.outlook.com (2603:10b6:510:27d::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Wed, 18 Jun
 2025 09:05:49 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%7]) with mapi id 15.20.8722.031; Wed, 18 Jun 2025
 09:05:49 +0000
Message-ID: <f474345d-78f6-424b-8c0f-584c5f0c162d@amd.com>
Date: Wed, 18 Jun 2025 11:05:44 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: amdgpu vs kexec
To: Peter Zijlstra <peterz@infradead.org>,
 Mario Limonciello <superm1@kernel.org>, "Lazar, Lijo" <lijo.lazar@amd.com>
Cc: alexander.deucher@amd.com, Borislav Petkov <bp@alien8.de>,
 amd-gfx@lists.freedesktop.org
References: <20250616093945.GA1613200@noisy.programming.kicks-ass.net>
 <4f5f95ff-b97e-41db-b9fd-5204e6581a30@amd.com>
 <20250616145437.GG1613376@noisy.programming.kicks-ass.net>
 <2bbcc44d-9079-4a73-ba6c-e93fdcb9cf6f@kernel.org>
 <20250618085123.GF1613376@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250618085123.GF1613376@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN0PR04CA0020.namprd04.prod.outlook.com
 (2603:10b6:208:52d::19) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH7PR12MB8794:EE_
X-MS-Office365-Filtering-Correlation-Id: 6823185a-e944-4c8e-9cc1-08ddae475157
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aHZTK1dyaHRlb3ovRjMrMitXU1ZURlRWbWtWNDVsbzUvUmFXMHJUSE81V1VJ?=
 =?utf-8?B?NUNSSWdDRzNYRnZRMWp2Tk9CRkt0ZjFjKzJkQ3M1bGsxeFdNMHIvb0NBTVd4?=
 =?utf-8?B?MG01OElMS2k1TlpXOUVLbUpFUHhOQzZ0TEV6U3lvb0swRDl4RFlBUFZHbTBR?=
 =?utf-8?B?dWowNWkrUURpZzUvVEpMcHdWemozSnBiRnpDT2t4bURqdEQyS1NxWDhnSkJK?=
 =?utf-8?B?bFBORmx3d0prclVDSFF0VzFhVGZrcWV2RlR6YXlWcEZmR01PMk9VcFNTeTc4?=
 =?utf-8?B?N3NnMUw0RmlCdk9JZWMrcEFiRm9sTTlseHBZZTU1RUlyUGk4RTgrV3BGUHJ4?=
 =?utf-8?B?SWtUQmdZVVVuS2VZOHdqOWNDcGwwVElnNk5IWXdieUMvY0l5Wjc4UnE4c2x2?=
 =?utf-8?B?ZVBjRFZBR294S2FVTlBiQnVMTHkyQTJNSURNbTJYME5hOTlSYjltRWdBdGJH?=
 =?utf-8?B?bE9aWGdxWW40TDNPcWdic1VjMDFTOGNYRk4yRXlld0hiYk9PZW1OVUFHbG8y?=
 =?utf-8?B?dDcweUthc2JXTjdQL28ycFFwek9QMFZjT2tuWEpob3V2TkFpd3VPYWxUZHdF?=
 =?utf-8?B?aW9CbmptSjgycnhLbExJb25FL1RMeVMra1hmNDBlMGhrd0NqcjNWSTFOSm14?=
 =?utf-8?B?alcwb2U4T2Y0QVRNTndoTUJ1N0tKTXFRczdZZFgxWTl3NDhRR3BzS05aRFFi?=
 =?utf-8?B?bTBMaXlsZXMrR0lRMjA0bVB2L3Bqam93MCtUVjNyNk5RUFBCRC9PVXFqazll?=
 =?utf-8?B?RE8yQUJQaXRGRHVpeTRPZ1VzV05tVUxBdVVYQ1VBNHNPQWd0YXRqZndSYllV?=
 =?utf-8?B?bU4vZ1FJVWMvMnpwQnNiSks2emlpOW4vRkQxRFNYSHNWVk9vM2JtVkFHQkhZ?=
 =?utf-8?B?dUJYc3dMMmhUa29LaUk4WERrUStoeFh1TVh4dHovcWV1TVExVWJmRml2NVl5?=
 =?utf-8?B?dFNMc2Q1cXBFd1ZtVEtVOEIzSE5IVlQ5emVySnNuc1gvUGNldHVvczU2THM5?=
 =?utf-8?B?T0ZQaTJnWnVia2l4emQ2TjNvOEtRYmpVc2kvRFhnVkoyRUZQa2lCQXpLOUNn?=
 =?utf-8?B?WW51YldBQTJKSXZtc2g0bXVIMml0NXgrS09FdFRIbTJiemd6Y0gzNThwV2FF?=
 =?utf-8?B?MUgxYlZrUEtOMkliWHJhL3JlVEhWaXNhWlB3SzV0ZWhZSG94L0xNc1FXcHMy?=
 =?utf-8?B?OGc5MzlSazFkcm5tVEJiQytvYmc1NW1taTVEa1NpbHZCZHpEMjRidEUxOWIw?=
 =?utf-8?B?RFlpYnVQRG94QzlyWDdlS3FPVGlIdWpYQVZlVHZ0a2d2RDcrbGk2Z0pnWkxL?=
 =?utf-8?B?T1Z1bFU2U3k3aDg2TGptelgzVVlndlBjbTJHa1ErMHZjWUpDck9QMGJPWmJK?=
 =?utf-8?B?MGtmL3c2YUJVdzhXc0UwbDhyVXZQQ2J2d0RmTmE1VG5QYzRSTUdqdEtjNncy?=
 =?utf-8?B?ZWpMdWpjcjFRRW5nalcrVGZhallUUFlETi95YWhiZlhQTnRrY09wRmNKRUVl?=
 =?utf-8?B?RzlDY3hzeEgrYWxJaUxqN1pUNFhqM3E4Uy9hVkUwa0ZlN01MbHdwcEFrdU93?=
 =?utf-8?B?SmlGWm5mUnRtVURDeGZVWTZzREJ4MGQ4eGM0eFhTbUM2NUVidWRuRjNobW1r?=
 =?utf-8?B?ZGVHaTd2aDNLNVVuN1Q0b3YrekEwNzJmVitaSVZ3WFpIMTYya1Z4UVoxQnls?=
 =?utf-8?B?YkZBMTBZT3REWmRaTStFRkhEaVVMYnEvVnVYZGduNW94Yi9oOUdvVWVRMmRq?=
 =?utf-8?B?elNkOUhxT0I3UkcxS0Nlbis1eDB4b200OThORkUyRkZIelMzNFVYNmQ3czI2?=
 =?utf-8?B?QXVXUlJUNTFiNEtkaStLdkxvd0hyN2p6QUtSRkFBNE5FaUMyb0VDdk5aekFj?=
 =?utf-8?B?K3kwRkVCK1Z6ZDlja09yK2VLNDFZN0pOMk1zNHNpSUpLZDYra2VXWGxTM2Y5?=
 =?utf-8?Q?rx1FJI8+430=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SFdFeVNKVHRCSFFvVkNyWld1VkQya1hZK2dKaDVtc1NEMzRuQjZLQjdTK1lO?=
 =?utf-8?B?MmxhcWI5MVQyY281OG5CY2Z4RkFUVUN3QTZYSHg0Y0RpUm03cTVyME9ZZmc1?=
 =?utf-8?B?VVAvUkd4cnQrSEtzZklvdzk0N25qN0VUblhwMzY3M2U3ZlMvemp3WFdVa0gy?=
 =?utf-8?B?RWJpM0c4VUxGblVrRXBISWtTc0pvZDAvcjdMOFpWeWZwc01YamFqbTdyWkZu?=
 =?utf-8?B?N3JjNGlsQTEwZWxNbnFxYmtVMnlLNU9kSzB2NHp6Y2d6VDFCcFJJWVdOU1pJ?=
 =?utf-8?B?eWQ4QVdaT1gvS2RadDhOTVNuUUZQL0pTVEREUEhqMjFaQURnbnRGQmxsS3Nu?=
 =?utf-8?B?ZFZqNXFaSFBxRk5HLzlWeGhHN3A5V0xRS0dYTzVlaHhKbG9wUFVhTVRkanJz?=
 =?utf-8?B?THlabXREUWIweEV3QnloQWV1OWdKcktWT050WXduMmp6ZG16bnovZDlFeGZN?=
 =?utf-8?B?QWJWMDFldVdaOTNSNHVPUGJodmcrdDVPK21scndNUE8rSk5zVHRUTk16S214?=
 =?utf-8?B?RVFhTkVjWWJPL3Z1YSszMTNrR1RaRVlETFg1NjJKRlZZaUVRUjNhdmxrc0hu?=
 =?utf-8?B?ekpySGZnbHZ2bTg2ZndhQlhPYTc0OVNDcHFqMWRML285dUloTzZaSEtycUx6?=
 =?utf-8?B?dFRmeFkwYXdLMk5KeDFyWFVHNUd2N01jcks1UFFBMm8rVzEvSFhhbUplcEor?=
 =?utf-8?B?Z1ErcGFvSnBOcVBOa1hkSkQyNnFvRVROU1EvcXdyYzRVMzZFNUVETGMrNWwr?=
 =?utf-8?B?RUtVcnBLRlR5VjJjdXREREgyekZlTGxZWklyUzVOVUZaU0NPc3d0c3J4ZzRh?=
 =?utf-8?B?WkpPam5XSERCeHB1c1p5UGpJMkxISE4ya0UzMkJrRHcwRFYyUHRXc0NZakMw?=
 =?utf-8?B?UklONEo4eHhMWDg4bzF5NWJjNCsyR0dHMFBNaVN3SjkzbC9USUlKa2ltckVl?=
 =?utf-8?B?UTFxWHpPbDBKWUtuMldIQnNLYnhuYlNSSSt4TzdHdGVKejZKMnFUWmlqUWx4?=
 =?utf-8?B?cUlPOVZUUVVObHpzNmlMcDdueUxiMmJXeElIcnF1aWhoeHQ0VWs5L0x4dEJq?=
 =?utf-8?B?UVp4bEJKSWp0R1F5dW9tc0oxRlY2TzVYUVJ3a2syYmY2Qlo2YjFiSW5NMUpL?=
 =?utf-8?B?NzRxSmRib2I5anhRN2NESHpIK0llY0VISHBuY2w1WU1PSGwxcjJjSmJRUEda?=
 =?utf-8?B?SmY4c3UvUGhPTkxVNUQ5YUNrTDd2alZ2NkIrZGpjcHpIYzFHOVFPV3VIaHY0?=
 =?utf-8?B?ZjJDVXhNY05nMFRHOWtqSGVJNnhrTjdlV2NGV1hNU09rWFpFV1FGa09saE5x?=
 =?utf-8?B?WGhoNzZNajQyYzE0dVhmVWx6azVaRWcySEVmN3QwRXBuS2xIYnZtWFZrVFFN?=
 =?utf-8?B?ZlBMVW1aZXJOcElyTWRKZDRuMFVWdnlQWFRUM0R4NDljNUZJb2FMdWN6Rlcz?=
 =?utf-8?B?MjdHRSthNFcvakdIKzNNZmNGc1lraGFqaS9CMjdZcVRtc1hGNjloakd6R3JB?=
 =?utf-8?B?dm9RNEpsWmx5dE5hQjF0TFlaWGlLemcxd0duWTJQQ1QvcUE1M2JNdkpoZG9q?=
 =?utf-8?B?bzNEV21qcHNLYXUxQzE5dTFYMHd6MHRYQTZqRWFESHNGejBmQUVLSFo2TlAx?=
 =?utf-8?B?Njhtek1FR0llN3N4MW52a0tESGw1ZUtNcGVJd2lHY1FiVm1tZEZiT2xnY2Fa?=
 =?utf-8?B?M2NSNVpDRm10Rk44YXAvN0MzWjBZd2Y3VGFIYWVVZHFkSFhnb05uNmRqRmFB?=
 =?utf-8?B?VTJyUGwyaENubU85RXhLWHRlRlBwYkdvTGprL1VZb0dZVlRiUm1VRkd3bHIz?=
 =?utf-8?B?TUtxS3V1Y3l2L3Rid3RmbVBhcG81MXBmTHQ3dGF0OFJ0NXdLMUMxTFQrTHVU?=
 =?utf-8?B?SE94ZlFYVys3VisxZmtBcks4SURBVHYwZ0VmRUZmbDBzaVNvMytnVzg5SStL?=
 =?utf-8?B?Z3VSL0wxdEh2R3pwNytVSTl4RU5MZWd6dURxQlAzVUNuOWFnQVNJMjBzMm1F?=
 =?utf-8?B?enlRMVd6NHpjRlpOQStOYWxER2E3bmNMeG9BN1V6SEg0U0E2a1o3UXU0bW9Y?=
 =?utf-8?B?L2xqNDBkemIwcFp4QlFtMUljZHV5QXBNN095MHlBODVLcU5nLzZLV21NTkRF?=
 =?utf-8?Q?ohy0ZuJvtHnuas8EyDx9XBKlB?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6823185a-e944-4c8e-9cc1-08ddae475157
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2025 09:05:48.8548 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bRgdIy/48BDNHUG/m19ppnoZiE7Ceg3JzhOxOwxhsAqVgKyRhDHZ0wmPuGsO1ii7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8794
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

On 6/18/25 10:51, Peter Zijlstra wrote:
> On Tue, Jun 17, 2025 at 09:12:12PM -0500, Mario Limonciello wrote:
> 
>> How about if we reset before the kexec?  There is a symbol for drivers to
>> use to know they're about to go through kexec to do $THINGS.
>>
>> Something like this:
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> index 0fc0eeedc6461..2b1216b14d618 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> @@ -34,6 +34,7 @@
>>
>>  #include <linux/cc_platform.h>
>>  #include <linux/dynamic_debug.h>
>> +#include <linux/kexec.h>
>>  #include <linux/module.h>
>>  #include <linux/mmu_notifier.h>
>>  #include <linux/pm_runtime.h>
>> @@ -2544,6 +2545,9 @@ amdgpu_pci_shutdown(struct pci_dev *pdev)
>>                 adev->mp1_state = PP_MP1_STATE_UNLOAD;
>>         amdgpu_device_ip_suspend(adev);
>>         adev->mp1_state = PP_MP1_STATE_NONE;
>> +
>> +       if (kexec_in_progress)
>> +               amdgpu_asic_reset(adev);
>>  }
>>
>>  static int amdgpu_pmops_prepare(struct device *dev)
> 
> I will throw this in the dev kernel... I'll let you know.

Mhm if the drivers are informed about the kexec then we could also send the unload/reset packet only to the PSP IIRC.

That might have a better chance of succeeding than a full ASIC reset.

Lijo should know more about that.

Regards,
Christian.
