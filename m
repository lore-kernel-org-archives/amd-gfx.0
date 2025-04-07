Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5FB7C36010
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Apr 2025 15:55:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9EF0B10E453;
	Mon,  7 Apr 2025 15:55:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nb69UykJ";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2044.outbound.protection.outlook.com [40.107.236.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DDC1210E516
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Apr 2025 15:55:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pj3/DapD1JVmtJGEL24mJ7UKZt5JrNC/pA40oeqpw8L3qOgNYnlSVV6SaOOWoHnXCIDWgzhTnCV9+hBIetn+FjRfARFawHmx/KrfRxmZa1SDuhC7oosQDKNGL1XafhLVV/PMv011E0YCjRgspd0W5OLxK9SXI2uawTm5WYxjuCP//dP+20iQqsBowmDksMkZSHzQ70oiHOXuWNSIIl+aaFcLMct+TZFqWsATSaMKWWq+m7tm5iqy7hIlY+pFD+UEKuD+0xpBIRg0Bnbm12J4K0OUfWpotEtsoJfiGxasfUowr9OBqTNJE4DR/vEG3jMM4QjP0AM0PCMOZHcv69LGtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qTRKOh8JrufJEyOQbB+2cegKmeXHCYpupB7pzPIiv6k=;
 b=wuc4ak3EtiBKAU/9DFzqWywYZhoQ2RO6omyrh+2TNdNuuGWaPc7DLdcIlJk5EDMB7dau0h0kRwB93bu72/vI58zTwxaWwMgv89akQWEPVh+enbI7LV5J85DWrVUbYUC1ZDpzEgC63lhlGkcw5cHSAGgKc2IWHmsrgdjXwBv8FaAEM8piBy0NrKtmrvXxJAXYq94hRx4rZ608aOE9KWOuVtU/fdWXH1z/nDugaCmFilEgPioiaFuro7gOEWS/iR/O4vfujw9mlMCjju1z4dbtXy0SqUzJ2p3Z5Rzd1G+1FWagGd6ysx7KR99n2X92o+EYfpx1fXNHXQ3JXD8x8dsvdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qTRKOh8JrufJEyOQbB+2cegKmeXHCYpupB7pzPIiv6k=;
 b=nb69UykJ/n8qvhPcrdy5c7HX83oadsLzvrIcmF8eikt06ljjgAw1Y0ER9LmKpp1/DpWXptUqwvjJ4btoIqdzaI1+sAgFG+MngkwtnWvMf2WpR7Fe9AQcx3Bz3rl7K1kE+xuVjhtkEYM8/PhZSNDjn5KcL/3Z20a0YXPH4b1fkds=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DS0PR12MB8070.namprd12.prod.outlook.com (2603:10b6:8:dc::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.34; Mon, 7 Apr
 2025 15:55:44 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.8606.033; Mon, 7 Apr 2025
 15:55:44 +0000
Message-ID: <58fe581d-db0d-4e7c-ae17-410b97089b64@amd.com>
Date: Mon, 7 Apr 2025 10:55:42 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: cancel gfx idle work in device suspend for
 s0ix
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20250406213647.48382-1-alexander.deucher@amd.com>
Content-Language: en-US
Cc: "Li, Roman" <Roman.Li@amd.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20250406213647.48382-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1PR03CA0023.namprd03.prod.outlook.com
 (2603:10b6:806:2d3::28) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|DS0PR12MB8070:EE_
X-MS-Office365-Filtering-Correlation-Id: d0761c4c-d289-48b7-aa67-08dd75eca7ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dDlUaDhDZmFuUWlqd2NjWlcwRUpxdk5KMHRrekZzZFB2R2lUQ2V4aWd5WHNh?=
 =?utf-8?B?QlJSS2dVNEFrK3BuRFJhZEZmWjRNUGptNUZpako3Sk9vVVdFdTlaTENKV2Uy?=
 =?utf-8?B?MkZVSzkvWi9RMWMwaDZZY2lUWmhqMlFhR0V3b1hkRDVnRjNQcjZCTHZlYVBt?=
 =?utf-8?B?bjNoSXRPcTlTa3RUWkIyajRzdjIrLzVhRjVORUpVRENtazFuaXYyZU9Nc0Zx?=
 =?utf-8?B?cDJEOXUxMmlzUWxLTERIdEZGNGRlZks1TXdDVEFRVHhuMmZUN2Yxck1WaUw0?=
 =?utf-8?B?NEFjL0MvakROK0Y1RENUZUtMYmFJMzNpU1pNV2Nac1RLc3ZQVWU2WXRkazFH?=
 =?utf-8?B?MlMwMlJLejdUcXJoUUtlUGtESDhOYVJMWW5lOHBPVjJqRjZVdHJyR3VmQU10?=
 =?utf-8?B?S0Z6dnZncE05YmdUUHdwRTVhUkJLejM1TFpTc2h1ZlUwdW5kZGZYaUo4d0ov?=
 =?utf-8?B?SGVTaUErSXh2VUhjNzllcFZQM3gzNnF0MVRXM1NuaFVpZGFKb3I0UE1KcWxH?=
 =?utf-8?B?NHg4UUNyVHV0d0R6d0djL2N3VFJCYVVuTXZMamo3bFdCLzZoL3N5Z2NMVlY0?=
 =?utf-8?B?Y3poZUVpOVhPZG1SRjZzRk54SVNnT0ZWS0JOYkxxWk51K2hxS2RBdVRzeFFa?=
 =?utf-8?B?QmJCZk5YQ0xyYVVEdk5rZ1g5SzYya1lWeHJWUjZxTTZUTDYvcktjVkhQejFL?=
 =?utf-8?B?bFJaTHNsUWRKREpud3ZkZ2J6dS9UTHdHbEdWMVRUZXByV2UrMUJ0ckp0YlM2?=
 =?utf-8?B?NnR5eDcwVXRUeExaQUtYQmJVOEtmd1Y0N1FsOUU0U3p6anIrRGRlWWx2UjBx?=
 =?utf-8?B?VXZqOFFEMmRrMzd4Snp1THFFWEtpNDMzOFJvSU84TklXUmxnNmNLY3Jya2dJ?=
 =?utf-8?B?RVU2RmRCSDRTL1ZxVk9XZmVCRVhTY1ZmUnUrRUpZNE51RklKRDFnTldYSkU4?=
 =?utf-8?B?L3cxNnRtL2xvRndYdzdSVXBrNkVtK0hEUTV3blIxZ1pjQXlZaWN0d1lEOEdK?=
 =?utf-8?B?VjAwZlNXdWxoM1I0NHJXSGZWN1dsNGpzTW1SVnBKTUZ4bVA5WGk0dWR3M2g2?=
 =?utf-8?B?M295QXIxWXNYUjlTUWsvazJrREhzQ1g5WXJRcGlTak1YQ1pHYVBLYWVqeFVz?=
 =?utf-8?B?WXNZc3JyVDFNQW9rZWlPeUdNemRnanNCSHNZWlE4VzZwdFlFSDdtbGdldDNl?=
 =?utf-8?B?NzFPc3gwS1JGMzdRbW5kR3hUZTN0YVI3a1RNL2p1Q2tLYUlJMjRNMG0xT2tJ?=
 =?utf-8?B?SzZSckZyV0JsZEVXdDE1S2Z4eUhtTnBIREF2cnpvNzM4MVlPMFFqTmd3bVdP?=
 =?utf-8?B?eWszQ0p4SHVNVTBiTEVUcWEzUUloZ0psZzA1R0VDbk5yTFExdWNDMVFhZ0pD?=
 =?utf-8?B?a2lPT1paYjBsRGN3dWV0RjlQM0thNzZIUW1ic3J4cllCRVZmc2dJS2p1MmRo?=
 =?utf-8?B?Z3Q4dzlJQk44cmQ3ZkxJR0ovOWt6NGlRQityNDNZS2ErVEVPUE9vaUp4UURo?=
 =?utf-8?B?QU82OGltUVRmSDV5anB2NkRManJlSVpNZ0NLdEZFOVQzK2RaZzh6ZTIzcnV6?=
 =?utf-8?B?aUViUThnL1M1STQvSWMraTNtQ0d2MmNRWkpIbXQvTTkrOFRQUTlBbnczMXUr?=
 =?utf-8?B?VDhMQVB6d0ZTbGNSMnhGRWJWRXdYaHgzZk9BdzRDWHF6WjlKVEVhdlJNRll4?=
 =?utf-8?B?NHZyaGlJQi9QcWFyUlhyS0loUUV5WHhjZHQ0cWNWR3lNMWpwNlo2Q0tDZVpQ?=
 =?utf-8?B?aUE0bkwxalRhWjhqci81TEVteG9yNnZSV2Y2OVJCWTZ2WG84dmk2WVZvYVVI?=
 =?utf-8?B?aHdkWFo0bkM5YzR4dTVTSmRoOFdQcGl0OTJOVVcrcmRCa2V4VUhyUmY4cUNO?=
 =?utf-8?Q?a2RElrYQLsdyW?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cXZTNnE3ZEc4eWF1aldIVGVPZFdoQ0VoM1c3VGcrbFNqNzBtcGVrbzQ4ekdW?=
 =?utf-8?B?SEtxdkNmRXF5akxrNCtCRWpybU5oSDZ1NFE2cmRCLzJpV2ZnZ0RSRUlzZnIr?=
 =?utf-8?B?MFowTXgrcWIzWE5mR2ZFQnFYVmYramRvZ2thMUdKaGg1T3RocDFlVjdrZE1R?=
 =?utf-8?B?OXBnL0Q2aUx5djY2NmRFZ08rd2w1eXpiTmI0bXBoeVVTbmV5eUtUc1BsM3Zi?=
 =?utf-8?B?NWxkSThSRGV2amxyTTlXcDZTS2k1YkZWMGRlenQ2YmtMUnFFdUFRRWpibE9N?=
 =?utf-8?B?c05hMlkxMlVvRGpETVVCdSsvRUJBTmloS0pxaW1JSjJvTDVvWlNIQzByckgr?=
 =?utf-8?B?RURkTTJWbDlaLzNUcCtxc3lVcjVUYkswWWc5YktWQ1F0cjJ2R1V2RGx5RmdB?=
 =?utf-8?B?SVFoeXpNRG5CcTBncDdmUXN2U2ZkYTMyNlJWU1J4di9BNytxekFIaHNNaDQz?=
 =?utf-8?B?Q2YzQzMxa1Y0d0hPMlh0amtkNVJRTGNIMURFTTNYZ25iWVhLQmEyMWdmdVNT?=
 =?utf-8?B?aGNBNTA1Z0dlNHkvZkt0NmdJZkpPcmpjMis1T0hBS0ZIOC9LQm5lTGo5RnQ5?=
 =?utf-8?B?T3dWQWt0My9NWTdHWGNZTlErM2VSYmMyRHN6b0UxYnN4amg1Uk1PM2FtWkRG?=
 =?utf-8?B?K2g2MTkxY3JHYkhKZm9WTjYvWTdYU3JzVGVibUZEM283L2lGaWQ1Q2lYTEJZ?=
 =?utf-8?B?ZERmZXNxdGY5UTBsMS9UOEg1Yk1DWXNWMUE1OUR5bUtOeS94UWdhN2dpN0ZL?=
 =?utf-8?B?cWRxUGYrMFJmUWd6MjNrUGN5Tko3TE5mN0FkSDJlemJjczBxMm4xR21sMmxW?=
 =?utf-8?B?L1g4MEcyMWpvenZ6SUxIU3p2dnhXaFY2Q2cwZnNmaC9OQ2grd3JmamtEUGlk?=
 =?utf-8?B?NjMvT2krYXk4NjZ1Lzdibmx6QVB0Y1pXRy9RaWU3ek9hanplRk5pUk9nVHpt?=
 =?utf-8?B?bUVNbDNIV3R3RHJnMVI0QVR0TE1aTjI1ZEE1TWMzOGJJZGVkVkJtMnRBem05?=
 =?utf-8?B?bC9UZkFhdzBTbnU5emtGSWkxR1dNbS90M0FlclRQaEZwWGJVZHRSSDBiL2JD?=
 =?utf-8?B?QzljN1ZuUDhBZEZ3bG10UjlYdElrK2tubjB2YXFydHdXbE0yRnhhQnlWNlk2?=
 =?utf-8?B?LzFVN1M5Mjg4YzVjWTR2TzcxTE8wUEJoM1FQV3BBbWRxTnhWdnRNM2ROdkFv?=
 =?utf-8?B?REN2T1hrVFJPamNZeUJ5WUJIWktCQ2ZNWU5MTFk2bFg4UjRueHF6MU54am1q?=
 =?utf-8?B?Ujh5MXFRQmd0d1BhbEpnOVdhUHlYdkIwRWFmd2lIMlJIZmh0VGVtbTRzRUhP?=
 =?utf-8?B?cWFQSVREVTdVUWxiZkJDT2FQQlhiU0tQNXZSVVdDM055QURCRFN0WUQ0Y2FV?=
 =?utf-8?B?UVVmVjdRNEVYOHpwbDZrYjFGcFc0RS9aRHJBNEIyWG9FcEZUTmVRSnJxdVlu?=
 =?utf-8?B?QlpNei92eGRrcTZRZ21zMlZ1dUlhVHVYUjUzeDM5VTQ4T052Qk9kOXZiaFEx?=
 =?utf-8?B?UlBRVmorRmRwdXdqc0FFNyt2RnhNUlpoMlcrY1NVa2Y5TjdacmxoK2FPYkMw?=
 =?utf-8?B?VVZxYWFGdmJUcmVZZ0VkZjdNVm8yWjdzb01GVzU1ZS9rZXpvQWRxc0RadURY?=
 =?utf-8?B?ZzdsNzhqbWl5SkoxOEVpK3lHZEY5emhGTTVlZklQYWRlN0NJTWsvSkNHeGZC?=
 =?utf-8?B?QXJzcmhiWjZBNkJPLzdBNnNMR0hZK1QvTlc0bGwydzhibnpENENNbjJ3YUlp?=
 =?utf-8?B?aGtlbmVpMytaRkowZ3JXTHN6QTdSMnVzSXlhZ1d1OTloQkdiVVhHU1N1M3Va?=
 =?utf-8?B?bW9EZ1V2TlRJYjhYRXdwbFBOS25YcHRwK3hwbzdRZFJmTFlieHVOazhwcnZ6?=
 =?utf-8?B?VEQya3B5ekQxL3NhdVJnYTFvLzJyWlRVMW1QQ1QwOHphOFVYMUdOUGZHZVEz?=
 =?utf-8?B?ZUNLQko1ZWxKVG9vSjd2UVFscnV2dlRTd21nVFBoc2tWc3NpMWdESnIwUVFT?=
 =?utf-8?B?Z3g3Y2NKdGdIeGJ6czdTVWJCWE5RaHp0dTd2K1QvYjYrZFJHRlhIUk8xckcw?=
 =?utf-8?B?QUJSOWJDdUdlNUZVcHp0VlJ4TmpWUTdqeUZTMld3T3JFZENEMFc2YnNQUkhN?=
 =?utf-8?Q?lQ/hcoMF6XCiSZjqMhFQ8oVP9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0761c4c-d289-48b7-aa67-08dd75eca7ac
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2025 15:55:44.5054 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yW+8TVX0GiSLR+Cc9L5MStQ1x1LTc5cGOfdlWsSNcOEhWDb81A5BMMCcjKHYuKhs0WkdoYth1Mn2eEmeB6tXpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8070
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

On 4/6/2025 4:36 PM, Alex Deucher wrote:
> This is normally handled in the gfx IP suspend callbacks, but
> for S0ix, those are skipped because we don't want to touch
> gfx.  So handle it in device suspend.
> 
> Fixes: b9467983b774 ("drm/amdgpu: add dynamic workload profile switching for gfx10")
> Fixes: 963537ca2325 ("drm/amdgpu: add dynamic workload profile switching for gfx11")
> Fixes: 5f95a1549555 ("drm/amdgpu: add dynamic workload profile switching for gfx12")
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index c2c2ca7922d5c..8a14caeb808dd 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -3641,6 +3641,13 @@ static int amdgpu_device_ip_suspend_phase2(struct amdgpu_device *adev)
>   			    adev, adev->ip_blocks[i].version->type))
>   			continue;
>   
> +		/* Since we skip suspend for S0i3, we need to cancel the delayed
> +		 * idle work here as the suspend callback never gets called.
> +		 */
> +		if (adev->in_s0ix &&
> +		    adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_GFX &&
> +		    amdgpu_ip_version(adev, GC_HWIP, 0) >= IP_VERSION(10, 0, 0))
> +			cancel_delayed_work_sync(&adev->gfx.idle_work);
>   		/* skip suspend of gfx/mes and psp for S0ix
>   		 * gfx is in gfxoff state, so on resume it will exit gfxoff just
>   		 * like at runtime. PSP is also part of the always on hardware

