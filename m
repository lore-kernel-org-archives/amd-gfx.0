Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76CAFC369DC
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Apr 2025 13:50:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 01DDA10E496;
	Tue, 29 Apr 2025 13:50:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1Hw17GgN";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2083.outbound.protection.outlook.com [40.107.236.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8D97810E496
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Apr 2025 13:50:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vmpApKMaSxThGb2vwyTkQVmo11uoJjZp+pPrYsLVQtP7eCvmDZGNwmRYa/h6AsZsdjVoX28nrmeXkh8TVdrL4oy/q60vVsJoyZtMo6ZWUi9YrL0PO240lRy7h5RvxyenfxudWOAdGn/A7Y/Mr5eqQJ9AL/skXwz92pdl4W8tE0qNqgoKmk62RxjKZVN5SszlN6+OkF55xbKAQmXqMyRxCV2ZaBx/wnFP31jVIuOkOPqsLDqsCOMq3MXSHawlVU2mUMP0YDC8N5erTu1a+damhFnlkKMP+bjjvZWYvYDfhn0nTPudLgc2tTEfe12M02mTg5tXsuOTBPFMjrJW3M+4qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qf7u1nGmEr6HPgeu4ZmBd1wy7gmFRyoe9fW1L3W74OM=;
 b=osbtSNc3H8WWmxdMqc0j9Fd9LR5YCq9KtuCNdejCDitBBdLDEWWQKl3m5TzjqgLJ0qrU9avbmrjPcRgxLpgVjy7H+k2SG5TLUFGo+XAft2BJDL61HCewfV4oz+8pvbi5JLrO79tMvTjT0VbcWvbcKJ89GT3jYrEBkKinXfrffVlV+wWtr946Z9L81Xf6Bc6Rdn63un+4zRRgcDalVLapYHQ4rM8lXzYVynMacFYdyi6ICRiFfQq1BHZGEL9otKW++2LN7EBm4IdbxNlWuUqiNt7pdGqaMJYTVD/E040N4gEyRVi994i12uy7YznCF615ZP7JMfvVbpgnKJSY09oXKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qf7u1nGmEr6HPgeu4ZmBd1wy7gmFRyoe9fW1L3W74OM=;
 b=1Hw17GgNeiSunXOiNtJZO785TCM0hiNEA7eKIsQiINKI2hurtGdyrcCeAVp8S/0p27l04RAT5s2kk7dh+ft7OjXrH747GOt0KSpkruszL6gPOg14AN9AYtBefrG/jRAFUxBsxpBaSblYu+1TFGKPJYWnzaE+xRyU6GaGAPRwPps=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS7PR12MB6095.namprd12.prod.outlook.com (2603:10b6:8:9c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.31; Tue, 29 Apr
 2025 13:50:30 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%7]) with mapi id 15.20.8678.028; Tue, 29 Apr 2025
 13:50:30 +0000
Message-ID: <34919514-46de-4e4d-9eae-e58bb8c7bb94@amd.com>
Date: Tue, 29 Apr 2025 15:50:25 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/amdgpu: remove re-route ih in psp v12
To: Huang Rui <ray.huang@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: Trigger Huang <Trigger.Huang@amd.com>, Zhu Lingshan <lingshan.zhu@amd.com>
References: <20250429102954.3913983-1-ray.huang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250429102954.3913983-1-ray.huang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0131.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b9::9) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS7PR12MB6095:EE_
X-MS-Office365-Filtering-Correlation-Id: c41b2d97-ac78-4426-6e80-08dd8724cdc4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eHFJUFdIazRkY2dhZmRWNlhMWmdycWVGbml2bHExVEVaNnpkTk1WZUtMbUVa?=
 =?utf-8?B?MUxsR0xQeGlTaEEyNlM5QVFjajROQmRWSXFvempENEsxL3k0RzhYVHpMY1ZP?=
 =?utf-8?B?RUpZMUk1b3k1SmRQcjJJdkVRWlpteXJpYTk3cXo2cndhL21LUTl1dlZPY0Jx?=
 =?utf-8?B?TzFSZnRVUXZscHVLTDlYZ09Bc0VaNEpxZ1V2RmJUYVhNTGpqb0E3VDIzMHll?=
 =?utf-8?B?d09FT01ZaW42dE9vbC92cngxRTBNaS80UDV1WGpGS2p5dUxvZVhYQkRWZm9Z?=
 =?utf-8?B?TGpGZDFyQXNSWEl1RmUvR0FlODJiZXRZM1hSbmdPbDlHNnhFNDV1dlR4S2dU?=
 =?utf-8?B?akc0QU1IRHRPSHBEaS9tVVpVZGhDcXpaU0hIdWZUYm5aczBFL3crd2pMTkps?=
 =?utf-8?B?Z2ZBWjlmUzdOdzJpWENBaGhLaGFVeVIySXJWR2NrRkxHWThRRGVNVnBjS0Nt?=
 =?utf-8?B?WkFIdzJTZ3pxVzA4dGVTMVF0UUZPd3RjWkthUTZzeThrcjRrTU9hemdheStH?=
 =?utf-8?B?WEVSRWRkb3VZUk1mSUNtMnJVQmdDZ29kbDkwNzhFcXpRc3ZxLzFvanFGZ1VN?=
 =?utf-8?B?d2kvNFRZbS9jSkRVVm1GWnNzLzJrUGphZUUrejZCcTgxTEpWbW5pRXBnN3Ja?=
 =?utf-8?B?NjRWaS9mU2V2Q0JOdi8zbmVNc1dqVkR5SEVybXJDa05IUTZlcWw4M3UrY0VM?=
 =?utf-8?B?SDJ6K2F0d3NpZE1mUnNtQWhvYjhMUStSR2dFTUV5MkRQMU1aaXZDOFk4YXdr?=
 =?utf-8?B?UU9ocHBGSGJaZlovdjRLWS9sZjJLcTkvNVBhcDdzVWJId0ZqTUtJdXVmOWlG?=
 =?utf-8?B?TThoQUwzbkQ0SjVxcjdUV1Q2bnNVU0tBUzVZU2tWSU1hdjlxV1M0T3VnU3VC?=
 =?utf-8?B?azl3RUoyd3pNL3MyS2s3RSt3WnVVWWZKWnhFVTBDcEhPU1FyQWRyczVYZEJD?=
 =?utf-8?B?MnU1d216VlBENzQxdVNySUF4Ukc1U1YxU3N5YURjREhabnRvdHNMVHZEY3FX?=
 =?utf-8?B?dnlUb21oZzEwZ1Y3ME1xbVNDbHF1YjZTUjFtL3E0SFg5U0gramJraitvS2hS?=
 =?utf-8?B?U0szTGMzYTJPNURJbzgyNzNIOE1waGIwaEp1MTJsU2tabjluakp0UnBlNzFT?=
 =?utf-8?B?SWk1M08wUVhONXRVaWtobjNzOWdaekNkV1RFT0xVbHMwN3p1Z3pUVlNRM2RP?=
 =?utf-8?B?N041WFhScUs3QzhpRzV2OTY5Yi9VMzVmYWgyUWNmdE82QkppTGk3T1B6ejh1?=
 =?utf-8?B?blVkemZpc3lRazlhUkQrSUp3b0F4c09HT0xKOWJSd1I4SEU1YnFJWkcrbXlo?=
 =?utf-8?B?U3FOT0ZIZ2VPRXVXd0pmRVMwRWxoRjVmMXhaQW5CK0V1V0pRV0x5OGcxZ0tQ?=
 =?utf-8?B?a1VtZ1pQOXk3aHhEY1FRcGtIS1djSE9OdlArTE5WcmlDSi92dmpkSjhFRE5v?=
 =?utf-8?B?QkFpSDVtRU0rdzVaSGwxQkdIaVJvVVpuMFR0cWZ6eTJHNnlDK20yTWZMbklq?=
 =?utf-8?B?TnJEN0I5R0Ewam0wWnY2amVTTVorbGd1dGUzdkZRcXdIODdSTWtnQTZEbTgy?=
 =?utf-8?B?TGpvZUpCaE9LcjFiMzZxMmMvVHArcm1jOXAyRURkOUhnN1hYMncrUmJ4cXhr?=
 =?utf-8?B?enVnTCtlaWxsZ1BFNkJBbERCUkNoVnRFanBFODVrVVRnYmJvZTdRa3drSE5h?=
 =?utf-8?B?UmlvWWloR2lLUmFUOWdGU29xWlgvNkdXdW5UYlhrYTA1RlBDeER1RjAxcHlS?=
 =?utf-8?B?R0lJQzN3RzEwOURYbklpYTFHNHZabHZyOUt5UVBKQVhxWEpZQWxtUWtHVkZt?=
 =?utf-8?B?QkdTeGxzY1gxY2x2c1VMdmlRb29PaFZoRGpFYlVKVFhjOFducXRJa2lZZkkv?=
 =?utf-8?B?djg2aGFLYnJleDRVNFB5N3pHMVFnc21pZEQwcm5QU1FnM1FsSFcxb1JqYjMv?=
 =?utf-8?Q?+rkwABwKFO0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eHZoOEViQkxUelRPQlVPVmpsVTZBUnZ2clk2MTcvMDFuRElBZHNWL0ltWjgv?=
 =?utf-8?B?UklTY0taZTNBZzlwUk4zcmZkRnpWc3dRTGdEYkQ3K3p5dDVFWWNNWmtEdGpB?=
 =?utf-8?B?bWpXUU1LdDNjTVUxSGFvUEhnZXlEc01DOVZtcUQ4RDVlVXowaGl1alFOV1Np?=
 =?utf-8?B?UHBPcEhFOHpQUGd3YzRDUW5EYW00MERSQzJJNjNPYzNTcEdNeUhMZ2FkUFlE?=
 =?utf-8?B?YTQ2ZDQ1bDNGZ0JSWTVlYkFncEpYSXR0TFEyQ0k3SGVxdml0M2FiamF6dEhQ?=
 =?utf-8?B?MFdGSDVqS1BNd1VRakxtem1vNVA3ZmVKb0VKN0FuZkZLVmF6RURQcjIrUkN2?=
 =?utf-8?B?UjhsT013cVhyaC9LTVFhbkFlOHA2Tm5sRkdTRzdqTjZOZGZwc0RleUU5NkJK?=
 =?utf-8?B?K0UwYy9Wd1F0NXBhQzgyUWtQS1FNVHFmODQ3VnFFVVErblR4cEtQQ3QrY2k0?=
 =?utf-8?B?L2tFS3M1R0g3VXpQeFJPc0JyeUNkNm1kN1dxY0Y3VFlzM3MrYzA4VE5tWkJ0?=
 =?utf-8?B?ODNiS0x4ODhRNi9ybTBsakFRdnh2cUF4MWFURXBUSEtMMGpnTVhMb0VkS1M0?=
 =?utf-8?B?N2ZUNU00T1pQQWl4V2hlSkh2SVRDanZTSTNOaHExNG1FUEZkdUxmQ2JhR05F?=
 =?utf-8?B?UDkrcDVKbXMyZkREdHJKUlB1NS8rZ1RYRGJzbjVkTlJNUUcrK2tFend1aDRH?=
 =?utf-8?B?MFZiK3ZxRWxGUGJmcTd2eXpoeUgzb0dMQ3NFaFJHQTFzaE53RWh4Wk9RVmRs?=
 =?utf-8?B?Z0d5S2J2aXM3NHBxdGl0ZVFmUzJ6WWMrOFZHSFAxdUYzTXY1aE5POEE4ek1H?=
 =?utf-8?B?Wm9HZXNCUm5oODlhamdJMG95OTh6SDh2bkRiOGdUbkpBYTl2K1ZGKzI2RjM0?=
 =?utf-8?B?aW5Bc0szZCthQk1zWGpSOUE5RXpnbVlsNmlJbnFyZlVBWmpLVlVKOWM1dEVw?=
 =?utf-8?B?cnE4UFpYVGxPZ05mM3EyUTN5MEM2Mjl5bzhNY1llTVpZZkhyaG5RL3BDUzFz?=
 =?utf-8?B?VWV3THZONUFjSnUyTUwyT2t5Y3c3Sm5YQzJXbjRlRFVhNDRKNHhVcUE3Ukp4?=
 =?utf-8?B?VmdGV3VPMVQvTmpFejNZUW56VVM5OUpuWmZraUVLM3BLVHcyWC9maUpCRnEw?=
 =?utf-8?B?SjU1WEtTY2ZwQnlvSUs4bHVmM2t5VnJobDY4K1RmU1RBRUpUd2JqMWFNdDRN?=
 =?utf-8?B?RndPeWRLUVkwVFFZTW41bXp4M1ZZR05UY3gwdTh0c29vZFBVY0g5MzJjRUQ5?=
 =?utf-8?B?UE5ldjMvdlFpV3BDVzQ2VHJSa2RMWjZIdzdHUGdrdUJwR08ydkRRYXh3emhz?=
 =?utf-8?B?SzBhT1BSdUpQcDVYS3pqTzMzTVZXQUEwRk54Zk9pdWpFRnZSZzZGLzlTaHpM?=
 =?utf-8?B?OHB2cHJCYmY5R0p4dUVjTXU1ZmRySC96RzRvQWFCaXBDcklRZnBpZVNyT1pG?=
 =?utf-8?B?MVpwVHN1Z1BNdUU5OCtHMHdpOVJ1SjAvbGx5emVHQ21IUzIrUUgrSGxPRHM2?=
 =?utf-8?B?Znk3S0IzNjVCSVAvV1RGY2ZnaUFodUtrMXB4K0x1Ly9XbmxwOFVadUE4VTd6?=
 =?utf-8?B?S0hXM3FlZFhkZkhRNFhzNG5HZWd5UTd1YWpibHZ2Qmcyd2VpQzd2Nzd5UmRr?=
 =?utf-8?B?WGkrR0J3THJXWnlNcXNCRE9QWXlrdU44Vy9BNE44TUx6TmNuQ05UY3RuS2pB?=
 =?utf-8?B?RzFQUjR1NmlaWGtOQXpjT3dRWWlXMXJlYmJHbTdqOVU4WlB4RlNWcHlza24v?=
 =?utf-8?B?KzNkTTV1QjdxNXhBaGxTOTZUTGg2aDd2aG9zUXdwbkR3TEd4STFHUWxtWlZZ?=
 =?utf-8?B?dFNNaFQwazdrQnBOWnNrRVk3M0F5eVk0anNkV3RHVHQ4NlRVV3ljbFR3VklZ?=
 =?utf-8?B?NDRSUUpNenVSRVI2VHVzSWxIZGdVd2w0ZU5nemM0QUhQOTJTUnBIYnVyblFi?=
 =?utf-8?B?bFpPYVp6bCtmTFRWZ2RYdG5Td2oza3prczhud0FEei9yekhwL2tiN0xGRXRD?=
 =?utf-8?B?NnB2UGVaaWZvY2NBcURSanVsUGYrSXdrN01JRVhCK2lUN2tHSkZ2WERlQ2Jh?=
 =?utf-8?B?VjdsWXlWVFBaM3UyNUtIRFdmS2liNXhHZlFVRTl0TWp0WFhyU29kNkNOSk9M?=
 =?utf-8?Q?ssRGOUlGxJh9fygM/XY1ZTHaI?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c41b2d97-ac78-4426-6e80-08dd8724cdc4
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2025 13:50:29.8759 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fesFGNB8vULeNBXygSwCtOr33t+JB4mrU4k5Ndg9i8/IquaxGVQHj0dWH+f8iti5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6095
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

On 4/29/25 12:29, Huang Rui wrote:
> APU doesn't have second IH ring, so re-routing action here is a no-op.
> It will take a lot of time to wait timeout from PSP during the
> initialization. So remove the function in psp v12.


Not 100% sure, but I think this code is also used for non APUs.

So we need to keep it around, just don't try to re-route faults to the second IH ring on APUs.

Regards,
Christian.

> 
> Signed-off-by: Huang Rui <ray.huang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/psp_v12_0.c | 34 --------------------------
>  1 file changed, 34 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v12_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v12_0.c
> index 6331941440d9..ed24f61e1ab8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/psp_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/psp_v12_0.c
> @@ -34,9 +34,6 @@
>  #include "sdma0/sdma0_4_0_offset.h"
>  #include "nbio/nbio_7_4_offset.h"
>  
> -#include "oss/osssys_4_0_offset.h"
> -#include "oss/osssys_4_0_sh_mask.h"
> -
>  MODULE_FIRMWARE("amdgpu/renoir_asd.bin");
>  MODULE_FIRMWARE("amdgpu/renoir_ta.bin");
>  MODULE_FIRMWARE("amdgpu/green_sardine_asd.bin");
> @@ -142,35 +139,6 @@ static int psp_v12_0_bootloader_load_sos(struct psp_context *psp)
>  	return ret;
>  }
>  
> -static void psp_v12_0_reroute_ih(struct psp_context *psp)
> -{
> -	struct amdgpu_device *adev = psp->adev;
> -	uint32_t tmp;
> -
> -	/* Change IH ring for VMC */
> -	tmp = REG_SET_FIELD(0, IH_CLIENT_CFG_DATA, CREDIT_RETURN_ADDR, 0x1244b);
> -	tmp = REG_SET_FIELD(tmp, IH_CLIENT_CFG_DATA, CLIENT_TYPE, 1);
> -	tmp = REG_SET_FIELD(tmp, IH_CLIENT_CFG_DATA, RING_ID, 1);
> -
> -	WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_69, 3);
> -	WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_70, tmp);
> -	WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_64, GFX_CTRL_CMD_ID_GBR_IH_SET);
> -
> -	psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, mmMP0_SMN_C2PMSG_64),
> -		     0x80000000, 0x8000FFFF, false);
> -
> -	/* Change IH ring for UMC */
> -	tmp = REG_SET_FIELD(0, IH_CLIENT_CFG_DATA, CREDIT_RETURN_ADDR, 0x1216b);
> -	tmp = REG_SET_FIELD(tmp, IH_CLIENT_CFG_DATA, RING_ID, 1);
> -
> -	WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_69, 4);
> -	WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_70, tmp);
> -	WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_64, GFX_CTRL_CMD_ID_GBR_IH_SET);
> -
> -	psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, mmMP0_SMN_C2PMSG_64),
> -		     0x80000000, 0x8000FFFF, false);
> -}
> -
>  static int psp_v12_0_ring_create(struct psp_context *psp,
>  				enum psp_ring_type ring_type)
>  {
> @@ -179,8 +147,6 @@ static int psp_v12_0_ring_create(struct psp_context *psp,
>  	struct psp_ring *ring = &psp->km_ring;
>  	struct amdgpu_device *adev = psp->adev;
>  
> -	psp_v12_0_reroute_ih(psp);
> -
>  	if (amdgpu_sriov_vf(psp->adev)) {
>  		/* Write low address of the ring to C2PMSG_102 */
>  		psp_ring_reg = lower_32_bits(ring->ring_mem_mc_addr);

