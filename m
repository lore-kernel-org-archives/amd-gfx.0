Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6072C83F1A
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Jul 2025 12:45:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5470E10EA42;
	Fri, 11 Jul 2025 12:45:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="D235k4tO";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2044.outbound.protection.outlook.com [40.107.223.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9EE2D10EA42
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Jul 2025 12:45:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HIrLsY/fwIjL3zqYC6brUvugn8N0vQenMJssF8VyhPnzVEHUopbJ1UegpsuvpCH6Vql11LJehPVp6oFxLTnwVZwEkjN2V9uax7JeTSVmo8x9zQLYiSirZ25l7EeC9FaIuX7AhPaMHhOsl1XyXxp3NWN/b0SDcTQ8YbGuT/H790SjSW/k5QVQKGengKZT8q3hdPce5Y8gcFKKUbTilldHek81evF+84Sq/AFQyUMgJqwBVT3/Kvo7t0s+ZegBArjRujFlP9rSFhQq4Z3JmOEYwORmT10vMnO3ZjU3rFwsYWWHGZ3RXFPUPgQjh5QJECEjApIbGCGZ2l5E7w8yayJ7TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HxlMGn/EpG/rFpvZPSSCr3cdPpGzdkRaDLARc6gdoks=;
 b=VbAXi5FV4Klm3/do4w1/kzur9Quep4X/ylJEGci3J5kUb5wCJU0tzMKAfaja3dQww3vWFlUc74foqWXZNznPcV4DVenHqgaJwkmteDp3ruy7W7rQlBD2es7DeLdGqgA3cI+Hij+LhWQKUzZd3t2w49+45cjya5a8tvnSUHY9Bym5tV5/SHM5XlF9m56gCQu3YaE5U5uHFHTdzkutGSJ70sPisPNZFT8IWPbf67QIrCRsicv/5JNTGTYH+aYe6P+ZcYLRFZKMp/6uclOwxhKqimJjudZcxpwp92tzF+aVrvnr8zC1Xm/2iBWhGQj4ITEvmIiK++1IVkkGFI4tXsK9WA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HxlMGn/EpG/rFpvZPSSCr3cdPpGzdkRaDLARc6gdoks=;
 b=D235k4tOkjVe2YUiW54g38ww39N4t2HDgVCQqmLVJUM87ruJqtYCYXse5LFyiiv1jorb4j/5Yt72K8wWIGKQbCD3wOkthIurbfmD5mIyNdIkwtFKTObtdNJ/r+1j5sIgP2hlmFz03thR10JZNvwGLd2H0xMGs6cSxnVdMP99BMU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SJ0PR12MB6927.namprd12.prod.outlook.com (2603:10b6:a03:483::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.27; Fri, 11 Jul
 2025 12:45:37 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%5]) with mapi id 15.20.8901.024; Fri, 11 Jul 2025
 12:45:31 +0000
Message-ID: <57da4e28-4968-409a-9861-3ee969bed541@amd.com>
Date: Fri, 11 Jul 2025 14:45:27 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] drm/amdgpu/sdma5.2: Avoid latencies caused by the
 powergating workaround
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Mario Limonciello <mario.limonciello@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
References: <20250711122338.44831-1-tvrtko.ursulin@igalia.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250711122338.44831-1-tvrtko.ursulin@igalia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR16CA0052.namprd16.prod.outlook.com
 (2603:10b6:208:234::21) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SJ0PR12MB6927:EE_
X-MS-Office365-Filtering-Correlation-Id: dccc64b6-02dc-4c92-5f14-08ddc078d274
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QnE5RVR5cUxEMHJjb0FLbTY3RHBYcXNKMUw0ZHl6Z08zc3ZVQTkxMkxWWndw?=
 =?utf-8?B?L0JMQWIxWFk2WCtSZVZJREpKZ3RUQytDKzNGc040SFFnMDNmTm9SaEg5NmRE?=
 =?utf-8?B?d0tXWHBYUWJWTHBaOGZNaTROZVgxbXpNeHFCVGg1aVZXTEpOWmYwc1Y1d1Fy?=
 =?utf-8?B?ei8ydVV1TEszSUFrWDBoMFg1KzZmQTd5aDZnaTNMQUVmaVJqTVpHZDl2U3da?=
 =?utf-8?B?S01OdzB2QzMxY25NNk13dHhOaXBZbWdjRlpIVkxzTW14YUxsT2tOOGtEVkZL?=
 =?utf-8?B?RWJKcXJQVytTdE05QjVIV0lLVE12Sm1CenB1UzlBNEo3SFdvdTNMQVF4M29B?=
 =?utf-8?B?bW8rY0t6YlZmRGJLZHUybmoxWW10QmI5YmlCRnFHZzJGL1Y2OGdWWFZ4NmZ5?=
 =?utf-8?B?Zi9EbDZObXFNallvZVFwMHVPZjZJNjlCa1VYNWdnMEpjc2FqU212QVloajZK?=
 =?utf-8?B?eFEvUkRUNmgwSXNEZ0VyQjdkRElFdk1ZRUUvSWN2WDRHNjZWVW9OeGp0ZWtH?=
 =?utf-8?B?dlB3Y3pETDVEeWJCTUZpbGFKQWZIVjZ0QkRRRnZSVjNKL1dWemd4VGNjNjNx?=
 =?utf-8?B?UXdlTHp0QlBPemliVjIvLzJ6bkhzMjFyNUpDb0hQRUkvWEVjL2l4U3pDWXBy?=
 =?utf-8?B?cmoyQ0VCQzlFQzZkbW8wM1JEOHhnbHRmUFRsSkUxbTR6SVZpNSs5SkpWRGxt?=
 =?utf-8?B?dDdOSXhHMmd0Rmp1SkVVNzVvRjNzcW5yNVNDYnZtSWRwOUNaUHFoTFlEOW5I?=
 =?utf-8?B?NHR1U3U1L2hUWjBvZWVHcldKSXNjVWJCNnBtU2JDaHF4RlRKdmEvWjZjclBR?=
 =?utf-8?B?RVBMbmo2bkxlTEtOdXVVc1UzNExReDM2R29zZTdrV1RXVzVlK1Y2cmUwbWdW?=
 =?utf-8?B?TzF6WklGSmVBZzVTeTE0eFdIYnVCMENka3hsbVo0cE4yOVBBYWlHekN6aXgv?=
 =?utf-8?B?djFXOGROdEhFcW81RHhqeGNCbUc5VGpsZUFTM0pFM2RhaWZPQ1BLaWJTNkEw?=
 =?utf-8?B?cDZvd1BleDl2V2UrckREU0VGYmNWZjJNYloxYUdWZTF2M0xnWlFrUU5OOGw3?=
 =?utf-8?B?elZ4MHVZVzJMNnByNWRydTVIZktpQ21FODA0b0hHc2xHZnY5dHlaVmhUWGV2?=
 =?utf-8?B?RFdGT2lrK2RhTlQ4UEhnSlNCVElHNlEra0JnMWsxN2MzN0JOR1d6V0lSMk9x?=
 =?utf-8?B?MHkrUnBCVk5QUUg2alpnVzlTSEZkVVJkVVNhL3poYVptanh6dEJZelY0NTEr?=
 =?utf-8?B?N1R4S2N6UW9id2xlbjc4NFNIcUZYUUd5a0QvcVhuYSsyWnp3cmNMYnVNc1VW?=
 =?utf-8?B?RlV5STRCQndGTTUzK3hWcVNhaTJUaEZLOVJkSjJmZkVtRWVDWmJPeVlrRmxN?=
 =?utf-8?B?MytvbXBNT0c3Tk5UdXM2K0dLSFhvanJxS2JDaW9VdDJXTzJScndvUnlmRi90?=
 =?utf-8?B?MS94NE15bEtRWk1hemVIbnJGWGI4NFgrMzFuVVVvUGJMekU0TzJMNTA5M3BS?=
 =?utf-8?B?VG1VcTVHZGgxc2s5NWJmYW8yNTRNb3haTS9mYll5NWFqYy9VUjduRXBNYTRE?=
 =?utf-8?B?TmZRS2l2R1p1MkI1WVBDK0VBendOSWtwbGY3RGVvbXNlM2lFenRIYjFRc1RX?=
 =?utf-8?B?TmFDMktZR091Y0wybzVHN3poaWxnQUNXendjYUJWMkpBeE16enZZVjhycXlK?=
 =?utf-8?B?V0RucmgyNzdTRGF3ODQxOWFuaGhMZ29zNWxBaG5qbE16TFVydnJHdUhRMmtL?=
 =?utf-8?B?SEIwY3JtSnFBUE5DQ2tXSnh0dCtwSldGTW15cTFqa3NsVnM1cTVKZzlGclNy?=
 =?utf-8?B?S2p2VUlpQ2VBS0JJUUdmV1lsaG04U0RkVmhWVzQ5d1JsbmY1clNTVytYVnkv?=
 =?utf-8?B?Z0paM1huSDE5akFOdFo3Vlg0SjY4WEJFTmtWSDBjSWJNTEdUVlQ4Rm4wVDdB?=
 =?utf-8?Q?fBqKczqkxcE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Tm1jRmtiTllmZE9oaWJ3bEd1OGhLcUZYcXlYd2lMMXQrZS9NcXY5ODZzRTRR?=
 =?utf-8?B?OWFxcWdyR3djWXkzU3NCZ2pFNktUZmRuaVVIT0ZpeHVra21UVnJ4SU5ueUtm?=
 =?utf-8?B?VE1tbmVUVXUyT20wQW1CK0ZwYWphaVBLeUIvTEJ5dnhWQkN0QWhob0kwOVMv?=
 =?utf-8?B?bVZuQjF4ZzJia1dsVVhRTWZDSy95UkxleUNVN2N2ay9INU1lMGJjZ2FQY3px?=
 =?utf-8?B?TzhEREJpckFpZFBuRXJvU1FDdFp5ZEx6Z3B3Ym42WklUN05neW9EOUpCbndi?=
 =?utf-8?B?LzNTekI1UldaWStSNjdHdGs3QmpqZjhENW9UWFVhUWZFSkdwVGNqZmZkZ2xH?=
 =?utf-8?B?Q2EzMWFNRU04SFdESkJReE5MZVpOdm1FQWVIWi83MVIyS3VOZlprMjBncEcz?=
 =?utf-8?B?VWFpTDFOR0pkYWJDNG50MThBcXZpaTJKK3Q4blRLcVQ5YlN6WTI0R1dqUlBq?=
 =?utf-8?B?OWlGN3N1TlU2V2FtNGFnL0pxREVSQ0dOY1c3OWIwY3lKZHhCbFJRTEZNdzRi?=
 =?utf-8?B?UlZ3T2xiUy84aGtRaXc3NWRLdktxSStoOTJsMnFoa3pucTNXK28rTTFOdDBJ?=
 =?utf-8?B?OHMxZHQ2bmgxQ2hkMTJ3Nm5IOUZ2aDZJQSt5VHNUK0JyTitLSmhtVlIzOEl6?=
 =?utf-8?B?c0wrcC80N2xOUU5RMkhDZWtSdm1ua2RpbFkyZ0hPTjZkRjdRcEJMRlpsclVY?=
 =?utf-8?B?NkFmdG1lZ0tJNEIycHBleHZMbnd0RzNtYmpydHh0UGxjQlJWT3lMREJWOTc1?=
 =?utf-8?B?RzdDTWJzQlp5T05VdGJ0dFJKeEJ0ckhCdXpmY1ExSGRCZWo5cXpQSWh5Q2dU?=
 =?utf-8?B?dDRMOHhGb3JJc2NMWFN6RjNzaTk5UFEwcHdLbXdwVHlCY0YzWjBvbUgwcDVC?=
 =?utf-8?B?U1JLbzFYREpwem5hR091ZzF6eml2ckN2TnFmRVc4TERXdWVQRHhTTGVMRmhW?=
 =?utf-8?B?Z3J4SWF0aG9FUWc4NnFyZXFQTjQ2Vy9NSFBBYlYyMFZnODBvdStWalNwTFUy?=
 =?utf-8?B?bzVRRkdsNkNyRFNZaGc3Wmh3WUZIRmtxeEJNK2dhd0gzb21wR0xuVWJ3b1lS?=
 =?utf-8?B?TjFkRXg5L3dqTkxqVnZtUXhmeFFYcC9KVWVNYTF6UGtFWFlGYnBzc1VnWGRU?=
 =?utf-8?B?bXZ1Z3BrSFNxSHgvWVlZYldmY0kzdHVKc29JM1hVK3dreFZmbnJ6ZzNzcUc0?=
 =?utf-8?B?ZHJ6K3lZVGdWUXkyYkdCcDdIazk0WXc3UkRXRzcxZnpIV2R5OSs5RXlTeUta?=
 =?utf-8?B?UnpNVnRjQlU2R0krL2ZFUzRWUFRYSmhlR1ArOUJ3RUtpeVBmelBPOFZoenNN?=
 =?utf-8?B?WENFMG9wREhHTVR4bVN2UnNrRFZKUytDbjlMaVJ5ckFHYjJKMW83VnNYZmh6?=
 =?utf-8?B?OGFuaDZMUzR5eE9Wa3lwY1JySkU5M1VsQVdFMlIwZ3phUmpYS0pwZTZxWDhh?=
 =?utf-8?B?UUZFWHoyZTFCWmx5U2lkR1IrN2xXSTJadDUwMmwvd2dnbFhlQUZXbW9zaDhV?=
 =?utf-8?B?eWtrUXBjK3dLeDZWOTM3bmpyOGZqdEhxQUIvbmgxTG9XTDhOMHdFZk5pVEdX?=
 =?utf-8?B?Uk5tbTdwUVkySDZYSXg0bDhwZEhyaEQzeThCVHZHalkyVnBSYzI0R2pnVzVS?=
 =?utf-8?B?RmlhLzdOWjl0b01rTTFLSHVBMVpIa3BraG5uMGI0TEx3Z0ZpMFBzS2VpSVZh?=
 =?utf-8?B?N2hHODFKaEpGMERUakpkWjBRbWlEL1JwdW1yQzJGRWdCUTdWdVd6WVh6V0g3?=
 =?utf-8?B?UUlPWW5FQXhxbnNRUVFiMVpaSFFFV1ZaR1llZU02ZjdwQXBvVWJOdWxsakpl?=
 =?utf-8?B?cGRmbGh4MFVuVms0SWFuOUdQYnBkRmJFZ08wbEdyZ1hZc2NOWWpCYjhhMzky?=
 =?utf-8?B?VEJ6am1IY1BQMUdSb2hNdHk2emNYcXFHZ1ZZcmNDZFFqM09lcW5XTTZwbEUy?=
 =?utf-8?B?a2FnNVhXM0JGZ0E0Q0xSWTVhNk5tQmROVmtDbWp3THIzNEVuWVhXTG9qNTJH?=
 =?utf-8?B?SDU1L0FyWVBHTTEvQkhZWGV0cGtJNEtzekQzMGdtSGg0cHBmYzlIeFB3OWJT?=
 =?utf-8?B?SGVKTjJVdktxbFY1eGdFdU51TGdQajBMRU95UUxDOG1tNHdFTU9MblBLcktV?=
 =?utf-8?Q?fRwiNxRuMxD6N+wXP/0SnNFJC?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dccc64b6-02dc-4c92-5f14-08ddc078d274
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2025 12:45:31.7263 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +F6ITGObJuaw3kLQYapi3Vkb207wAdK/0lscFKDErbpeH4MGmffVZHoJunWPu0oh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6927
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

On 11.07.25 14:23, Tvrtko Ursulin wrote:
> Commit
> 94b1e028e15c ("drm/amdgpu/sdma5.2: add begin/end_use ring callbacks")
> added a workaround which disables GFXOFF for the duration of the job
> submit stage (with a 100ms trailing hysteresis).
> 
> Empirically the GFXOFF disable/enable request can suffer from significant
> latencies (2ms is easily seen) which are then inserted onto the
> amdgpu_job_run() path, which slows down the CPU submission of ready jobs.
> 
> 1)
> If the premise of the GFXOFF workaround is to keep it disabled while the
> SDMA engine is active, the current workaround achieves that only
> partially, for submissions and jobs which take less than 100ms (the GFXOFF
> re-enable hysteresis), counting from the ring write phase, up to
> completion.
> 
> 2)
> If disabling GFXOFF affects the GFX engine too, basing the workaround
> solely on the SDMA activity creates, at minimum, a needless "chatter" on
> the SMU communication channel.

IIRC that is intentional. This "needless" chatter is what the workaround was all about.

> 
> If 1) and 2) hold true, we can improve on the workaround by; a) only
> re-enabling GFXOFF once the job had actually completed*, and b) apply the
> same workaround on other rings which share the same GFXOFF powergating
> domain.

The point of GFXOFF is to turn GFX on/off *without* kernel driver interaction. Otherwise we don't need it in the first place.

We just have a hack for the SDMA because that moved into the GFXOFF domain with Navi and is broken on some HW generations IIRC.

> 
> With these two applied, the GFXOFF re-enable requests are avoided
> altogether during persistent activity on the GFX ring and simultaneous
> sporadic activity on the SDMA ring.
> 
> This has a positive effect of drastically reducing SDMA submission
> latencies. For example during the Cyberpunk 2077 benchmark, they are
> reduced from an average of 64us (stdev 60) to 9us (stdev 6). Or more
> importantly the worst case latency, averaged to a one second window, is
> reduced from 305us to 30us**.
> 
> *) For ease of implementation we put the re-enable at the job free stage,
> since doing it on actual completion is problematic in terms of locking.

Absolutely clear NAK to this. Never ever base anything on the job livetime!

We already had enough trouble with that.

> 
> **) Submission latency ewma averaged (DECLARE_EWMA(latency, 6, 4)) -
> Approximately 30 SDMA submissions per second, ewma average logged once
> per second therefore significantly hides the worst case latency. Eg.
> the real improvement in max submission latency is severely understated by
> these numbers.

Well that would indeed be quite nice to have.

Regards,
Christian.

> 
> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> References: 94b1e028e15c ("drm/amdgpu/sdma5.2: add begin/end_use ring callbacks")
> Cc: Mario Limonciello <mario.limonciello@amd.com>
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h  | 1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c   | 8 ++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_job.c  | 7 +++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_job.h  | 2 ++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 3 +++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h | 1 +
>  drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c   | 1 +
>  7 files changed, 23 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> index 08f268dab8f5..eee40f385793 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> @@ -475,6 +475,7 @@ struct amdgpu_gfx {
>  	uint32_t 			compute_supported_reset;
>  
>  	/* gfx off */
> +	bool				gfx_off_held;	    /* true: rings hold gfx_off */
>  	bool                            gfx_off_state;      /* true: enabled, false: disabled */
>  	struct mutex                    gfx_off_mutex;      /* mutex to change gfxoff state */
>  	uint32_t                        gfx_off_req_count;  /* default 1, enable gfx off: dec 1, disable gfx off: add 1 */
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> index 206b70acb29a..bf9bffe40235 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> @@ -191,6 +191,14 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
>  		return r;
>  	}
>  
> +	if (job && adev->gfx.gfx_off_held &&
> +	    (ring->funcs->type == AMDGPU_RING_TYPE_GFX ||
> +	     ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE ||
> +	     ring->funcs->type == AMDGPU_RING_TYPE_SDMA)) {
> +		amdgpu_gfx_off_ctrl(adev, false);
> +		job->gfx_off_held = true;
> +	}
> +
>  	need_ctx_switch = ring->current_ctx != fence_ctx;
>  	if (ring->funcs->emit_pipeline_sync && job &&
>  	    ((tmp = amdgpu_sync_get_fence(&job->explicit_sync)) ||
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> index 2b58e353cca1..4cfd175ac6df 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> @@ -191,6 +191,7 @@ int amdgpu_job_alloc(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>  	if (!*job)
>  		return -ENOMEM;
>  
> +	(*job)->adev = adev;
>  	(*job)->vm = vm;
>  
>  	amdgpu_sync_create(&(*job)->explicit_sync);
> @@ -268,6 +269,9 @@ static void amdgpu_job_free_cb(struct drm_sched_job *s_job)
>  
>  	amdgpu_sync_free(&job->explicit_sync);
>  
> +	if (job->gfx_off_held)
> +		amdgpu_gfx_off_ctrl(job->adev, true);
> +




>  	/* only put the hw fence if has embedded fence */
>  	if (!job->hw_fence.base.ops)
>  		kfree(job);
> @@ -301,6 +305,9 @@ void amdgpu_job_free(struct amdgpu_job *job)
>  	if (job->gang_submit != &job->base.s_fence->scheduled)
>  		dma_fence_put(job->gang_submit);
>  
> +	if (job->gfx_off_held)
> +		amdgpu_gfx_off_ctrl(job->adev, true);
> +
>  	if (!job->hw_fence.base.ops)
>  		kfree(job);
>  	else
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
> index 2f302266662b..d4ab832ac193 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
> @@ -46,6 +46,7 @@ enum amdgpu_ib_pool_type;
>  
>  struct amdgpu_job {
>  	struct drm_sched_job    base;
> +	struct amdgpu_device	*adev;
>  	struct amdgpu_vm	*vm;
>  	struct amdgpu_sync	explicit_sync;
>  	struct amdgpu_fence	hw_fence;
> @@ -55,6 +56,7 @@ struct amdgpu_job {
>  	bool                    vm_needs_flush;
>  	bool			gds_switch_needed;
>  	bool			spm_update_needed;
> +	bool			gfx_off_held;
>  	uint64_t		vm_pd_addr;
>  	unsigned		vmid;
>  	unsigned		pasid;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> index 426834806fbf..22cac94e2f2a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> @@ -350,6 +350,9 @@ int amdgpu_ring_init(struct amdgpu_device *adev, struct amdgpu_ring *ring,
>  	ring->max_dw = max_dw;
>  	ring->hw_prio = hw_prio;
>  
> +	if (ring->funcs->gfx_off_held)
> +		adev->gfx.gfx_off_held = true;
> +
>  	if (!ring->no_scheduler && ring->funcs->type < AMDGPU_HW_IP_NUM) {
>  		hw_ip = ring->funcs->type;
>  		num_sched = &adev->gpu_sched[hw_ip][hw_prio].num_scheds;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> index 784ba2ec354c..afaf951b0b78 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> @@ -202,6 +202,7 @@ struct amdgpu_ring_funcs {
>  	bool			support_64bit_ptrs;
>  	bool			no_user_fence;
>  	bool			secure_submission_supported;
> +	bool			gfx_off_held;
>  	unsigned		extra_dw;
>  
>  	/* ring read/write ptr handling */
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> index 42a25150f83a..c88de65e82bc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> @@ -1944,6 +1944,7 @@ static const struct amdgpu_ring_funcs sdma_v5_2_ring_funcs = {
>  	.nop = SDMA_PKT_NOP_HEADER_OP(SDMA_OP_NOP),
>  	.support_64bit_ptrs = true,
>  	.secure_submission_supported = true,
> +	.gfx_off_held = true,
>  	.get_rptr = sdma_v5_2_ring_get_rptr,
>  	.get_wptr = sdma_v5_2_ring_get_wptr,
>  	.set_wptr = sdma_v5_2_ring_set_wptr,

