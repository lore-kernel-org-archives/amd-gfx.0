Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE612CF3182
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Nov 2025 09:20:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 586F310E5A8;
	Wed, 19 Nov 2025 09:20:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="R9EOFkbd";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011012.outbound.protection.outlook.com [52.101.62.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AB3C510E5A8
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Nov 2025 09:20:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RNVNeztH+XvX57B6UhumKzkqiFjZPlzilxlsbkJryIn1rEU/o5T28TnkwicRLkJf8ww5RclnRZfnr7KK95aNbFDczYOv7l/9vsMYm18wH9j9Xl6UM7MlQLre1GHgPA63IgMOQoI6X6p0ovguKGaaArwU9uGtWmRt97BtlmbzostVXzkY+BQt6Pd+MoCnQEEoW5YHvqFR/tJbeSqfV4K6odkqmhtpMGN4+LnE0v8cWq6lJ9ZTdH5LJsqqEMM+Atr67ygA+A0nFmd8MBq4fAt5IarLmAMQyG/ws6GIa38midsKyuK7k3lkRYdVurmw+tnU+cMtWY8vxkVXWJZzhjGrgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FpBD60LmOVagb1YVd+y1BUPBwzW/mr0wcaZLS65pizk=;
 b=kOhBpHYtjq6c5Rx2gCdmqMzS7XvCuXbQeecQI/agofi1fVgyjKkDMP2xJ4Gs9uG7fApMiaEUSnBJroDXrmU6lbh9UNwrjvX7EYfgKT4gmRdGqpBe8OdK4vbXkCrKxiEKK+j0imW/6M46HjCoUNOQiS5f3uFlhJFQ9wCvMHWB64kSTcA6RSQtSStCqIkDLKJJg3b3upiZpgDKRYQjbFoAdvZz9gUCIwoVWFfo9xVJQ21+pkr4x4rk+2WPsUA4kChhrxRIIl3vRIf9N9nJzbxJVs0fj9S1U/M15P8m7Qrk5/1yEuapPccQw8nD9xgy2EY3x3RYIYYDbbvqSpVPsJSfhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FpBD60LmOVagb1YVd+y1BUPBwzW/mr0wcaZLS65pizk=;
 b=R9EOFkbd6pzBsb0T7z6OmwXiD/gsrAPhjKfdga60AbNa3nc5m0OE9fj4JGRureKsUoowdDeqNQ040DrbLJmgr335VpNkJZkjs5Mpmc7kj6mjxMS3YuZUG6BJybGEyUet9y4+3gdON/4ND7xuv/QsCNvNWNdnDxsfHNgtope0dZo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by IA1PR12MB6457.namprd12.prod.outlook.com (2603:10b6:208:3ab::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.21; Wed, 19 Nov
 2025 09:20:32 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.9320.021; Wed, 19 Nov 2025
 09:20:31 +0000
Message-ID: <462b1556-264b-4ee8-afb9-e5e0869192f0@amd.com>
Date: Wed, 19 Nov 2025 10:20:27 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] drm/amdgpu: Fix GFX hang on SteamDeck when amdgpu
 is reloaded
To: Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Mario Limonciello <superm1@kernel.org>
Cc: Robert Beckett <bob.beckett@collabora.com>,
 amd-gfx@lists.freedesktop.org, kernel-dev@igalia.com
References: <20251119002348.4118647-1-siqueira@igalia.com>
 <20251119002348.4118647-2-siqueira@igalia.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20251119002348.4118647-2-siqueira@igalia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0077.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cd::17) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|IA1PR12MB6457:EE_
X-MS-Office365-Filtering-Correlation-Id: 26b2634f-ebc8-4f56-c5dd-08de274ce2d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?c29rMnQyMGNwRU8xVFM1bHVLdklqNks1NHNTakd2amp4VFdhOU5yWVhZdVZV?=
 =?utf-8?B?aGZSTzJlL3ZzQTh1TDVUM054Lzd5TllkK2ZOOG90anVaQmFabXdpYWdTNyth?=
 =?utf-8?B?RUlVSnFpbzYyUVRmcGpUMHB0N25lOHg4TnRJd1Q4YVgrOUo2ZmU0dGMxRHFE?=
 =?utf-8?B?NTdqZ2tDd1pVVFNxMm8vamZXWW9RV2FkNVBVV2k5SDBNNURqTFJiS2l5T0s5?=
 =?utf-8?B?NWN0cGtDZnJXTDhNc1RKejJVNjYvSk96R05KVGExczBoWERGcmpCYzhPQUh3?=
 =?utf-8?B?Z1A1RUV0cUs2MEJ5bXJ5MHRRV3dpcnZjRVUycjNpS053NytvRlBabmRvOEt5?=
 =?utf-8?B?WHhRcGlnMXk3b1IrSThwLzBZUXV1RklsWEdzK1ptaVF2ck9yaHY1K09mVW1j?=
 =?utf-8?B?bndHaVBtcnRYYW5FUlFDamtNVE1JL2szanlMaXNPZldPWUk3MGtJSHpzR0JG?=
 =?utf-8?B?bmtleEViaUZoOGw1UlJOVWZSam0vdzQ1OFFiWGlwRnQ4WTlNNjhVZndlVlpk?=
 =?utf-8?B?NERXY0J3OUlmbkUxczBNWWwwZExWM1J5bTV5R3JCM0g2bEZHVmM2SmtCbFFF?=
 =?utf-8?B?WXhtN2J6bG5Xd3E4d29XVFAyVHFyUUdxb0puaTBrWTM2RVNoSjBqT3FaUy84?=
 =?utf-8?B?bUlTR0FKQkw4MmowQnNiVTNETGdwRTIzU2U2cmJnSkhXTGdKRjJaMk1LN2xQ?=
 =?utf-8?B?MXNjS1VLMGRhVjZkbTQ4eVowQmtBYkRRdUVXajd1Qk8rTzg4T1lBUUN4d3ZH?=
 =?utf-8?B?ZkhvRFZoQlB3bUl0b2FnUGp1ZUJhMnZnWVZFbVhoelh5enpSdTcvWG9kVmE2?=
 =?utf-8?B?bHNGenBxQmFGMHNpdWxuSzN4YzUyQVZwdEE4a1I0MkM3alpGY3c2SEtNcnpo?=
 =?utf-8?B?VENVNUk3SHowSDFPVUhYZ2ZmMTlxZEw4UGM3OWlvMGRiL210cGMzTW5HdGN6?=
 =?utf-8?B?SDgyOHNyNmxQRERFRjRNZUYrTzMyWERZYnpwRGdRYXdZWFJoNHpBaGNkS2pv?=
 =?utf-8?B?RmZITkFmVlZINkNpZ05WbFlDMktCNnF4VFJkV1J2MGgwUlBvVGZobHgrdkZR?=
 =?utf-8?B?ODF3eHZ5S1lIa2hhQTAwYkdQbkVEam5acG5keHFuWkd1VWNxUXh1WWVxYVAv?=
 =?utf-8?B?VmR4SVZ4WGU3TjlRaVhKWGhxbkQvMFV3N1JxVGdLZ1ZoWmxGY2VTS3FvN3Ay?=
 =?utf-8?B?NmdVQzgzQUtIOWxSbzd3SnVrSVpIRUdJNXNjSDVaUDhEZk1HUk8yaXhEajBW?=
 =?utf-8?B?RzE3REdVeE40emlOUXBwNHpFYzR1RkcxeUMyU2lZemZBQkRWYWsxVXZSUVVG?=
 =?utf-8?B?VkpIckY4VHBFYmF2MzFJWmNjYy9TMFNwdWN6Q29WNVZYb0dBQStVTWY2RGs5?=
 =?utf-8?B?TEhnSHRQaFk4RWJnMm5qRStVV0cxZVE4QlJWWEdTZ3Z2dnhKOHU5aFJJNndz?=
 =?utf-8?B?M1JLRHo0bXhVMTRvaVFIeTZBZStVUkF2UFU2V0M4NnhvMVBGNHZoYzlqNENP?=
 =?utf-8?B?d2QxZS9ubUFqNTIwelcxc2lkVzZoUjZ2Q25GUGY2R1Y4cUlIM1BjLzNWeldV?=
 =?utf-8?B?MEw5b0szcVBmcEcvWDFEQ2h6Z1p4dVBTYjBXVFh4TkY3cUhzMHV0K290R09t?=
 =?utf-8?B?ZCtYVExmSkkvT2J1RzVLV2VPbXRvVFV5Z2ZScnE5djRWb3NZaFdHZ1hmSUJH?=
 =?utf-8?B?QXR1MVQxYjBnR01xUkduNEJLSGRobTZrVEZhMVF0MGplcXBJSmszMnFiVXo1?=
 =?utf-8?B?RUtYMGJOTEFPTHFhb2czdnRVMk9rdmNMcU9rSVZGaUZ6QzA1Rjgrb2VNVDg1?=
 =?utf-8?B?VHZnTzJ4WjZPa3QxM0NmUjdWUHRHem9FalA2dFRMRG1ySE5FVUxnV0swWmtJ?=
 =?utf-8?B?U1U4dStjVXVVNHFUQ3pOREpHK21ucFVuSzlzclhJUm5ublpXd2pKRWlTcHJM?=
 =?utf-8?Q?+krRCDC7Lwir6XnF2wnVQc61E6PjrTvT?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RmNnWDFVWVdlcEdxWjNDeEE0a3dpNi9OVHNLMEVIcVBFMDdFd0h4Q2hkdmt6?=
 =?utf-8?B?N2loSmhTWDI2V3JjdDJrbEJUOFVTSGVEUmFSRVUxK2ZVZW9uTmZFRy9HVDVX?=
 =?utf-8?B?bXBSMGFnb3FGdkRpbUJXT3J4eW42TGgwMDdGNlhtTXVlK0JhbFRMcGJORTFO?=
 =?utf-8?B?M2w4a3J4TVF2cm5OMTdqQ0tsditKK3FKNVJzWGpIS0luTEVRN3NUamwvaFF4?=
 =?utf-8?B?dll1NENWd1RKVXR0U002U3VFNThNZjNucTdJMFRsU0h5cVBXenVCSVRubjRB?=
 =?utf-8?B?STdwcVpaOUxUTXRKeURiVFNIOGpuVEJTTWNuMndOSDA1aWNEL3dUYnJ2Wk5m?=
 =?utf-8?B?UG90dStvQTIxeTdRRTMvZGtDbzJINW9wZWZWY1NJYnprMklrSy9RdEFjWkRx?=
 =?utf-8?B?akFSaUdCenZoL3pLTWV2SEEwVmREVUpoY1duZDhCcTJISnJSR2pmWDQ1YVYx?=
 =?utf-8?B?THNYYnNYTVBlU1RZWGZQUmZoZWkvc0tKQ2FqSGFzYUhvd2VRbkZOT3U2Mkdp?=
 =?utf-8?B?KzdydUpKUUhiYW1reWtYMFRsajRGdVluSjJVSnNZVit5c0hWTk83NTRLb3JG?=
 =?utf-8?B?QncvMi9WL1VGRTY2RktZQWhpaUNVcDNnQlUvWWpRZ0h3UGpWbENodUN3T2sy?=
 =?utf-8?B?MTRZTXh6ZFNJOG9rdVZnTkhqWXBuVGJvc2p1SHd0MHJUZVNQMnZBRW9ueUE3?=
 =?utf-8?B?eFNzREJyd1dSeVVWSkZ6UXpOMzBwbEk0Qjh4R25zMUxVZTNqbjB1d1FyeFVC?=
 =?utf-8?B?VTltS0ZrTVF6aE5wRVl0N3Zsa3UrbHc2cHpDVUJ4NXJLclpzRkw5RW1EaDVI?=
 =?utf-8?B?TC9FSWFGb2I2Ni8zWW1taUFndFRISjBtWFVBZXRFK1dKWWdwa3h1cC92TG1E?=
 =?utf-8?B?NEszcHR0eVZ2U1V5WWxFRUk5OTJqeSs3RXpOME9NMk9rdGpaUjY3MzJ5cXRB?=
 =?utf-8?B?aGxPN2lPSHdyYWQzYWx3cmZxOS9wNytKRUEvZitvNDdEU2dtRUhtRk9jSVhF?=
 =?utf-8?B?TDFHOWF6SkVMbmtXYndpMlYrTEdyTmEyZTZkUnBpdFFZREdsNlFlaTloc2k3?=
 =?utf-8?B?TmpKQ3c0RVNVYkJKTFVscFJmMnllWm4wV1JrY1p1MEwyRTAzSWloRzNtK3oz?=
 =?utf-8?B?YVRzMTIxZWV0TmxQZmpDZFBHenhkWlhDRXZ5ZU16Q0ZncDRJalBPWk1sYThy?=
 =?utf-8?B?YTBRSjBhOUZkVkx3anlyT09raHIwbU02RjNUUGo0aW9SZ2VydTJuTUw1NmJT?=
 =?utf-8?B?cWFoeVlBRW5RZHZpeGU2OEU5eW02SE5NbTlSMFVYZ1ZCVHZnbm5zdXUzOVFu?=
 =?utf-8?B?ZThaNkJGZ1JSZ2RmT0ZJdkVMU1kwV2ZhM0tZZ2NqSWxMbGRQSjVkMWdEeE5q?=
 =?utf-8?B?NXQ4YVNodFI2dSt6U0dNUWxIcUhhV3lMd01OeUNBYnlrSlpJb3RoTE9TR1hG?=
 =?utf-8?B?ZE1lMnBkK3NORUczZ3Z6b2VWeGM1SlRaMVVHdnNjbElRbFE5OWVBT0J6RzFD?=
 =?utf-8?B?ajJVRS83M2xxclRTcDEzOUs1Sm4zUzJtVndBUEVLTk43bFFQUmhjWVVHdFc2?=
 =?utf-8?B?V2s3eEErZzVXNXRZRnhteTFQVk5mUVpEakljbDk4LzdKbnNOT3BkcFNJYnM0?=
 =?utf-8?B?VjlSZTVYQVVEOXpSRkdMa0p1czJ4aXE0QVRrMllhbDhIRmhCODRRVW5HRGVM?=
 =?utf-8?B?KzZYRU5JdmhrQ3YyRGJzTHBSSWhnd1hUZ2pCckF6ZXd0R0RUaU9oWFBvUnFJ?=
 =?utf-8?B?Nll4bDFiNjU5U1FkUy9DNG93V2JKN2JUT1RJNmNuN1QzMnlFdUd4OVNubVA1?=
 =?utf-8?B?N1QrUWNTckx4MEplQ0diS0lrYW5YeHNOaVhqVUQzL1lMek8vSGZLbFVyNEZJ?=
 =?utf-8?B?VWVZNGVQT2hEUjU2a093aHhwaUF5Ty9VRERRYi9pV2krUVR3SjZNOWlmMCtl?=
 =?utf-8?B?M2FsUW1rMHp5VEtQZWVwcGVGUWttQlhJQysxclI3a0MwcndVajVxcXI4TUhm?=
 =?utf-8?B?WnN5Y1l4T1ZacEJ5Q1RKaTA5MG5YaG1tS0NaVzhVa1l2ZThSY1NLWGJzbEh3?=
 =?utf-8?B?N0hiZlUvSGlYZ0QvNVdNeUNyVnYxbDc5UmV3MjZvOXhsMWl6emI1THFKczlC?=
 =?utf-8?Q?fuhLWoSHusx7Fo1D7fTkp9vij?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26b2634f-ebc8-4f56-c5dd-08de274ce2d8
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2025 09:20:31.3520 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: asFR4AVAa9N1MYDJplNt6tsaAa5utmY9iZKLpEJGAz74N6vu3VCzFNKp52PfJqm0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6457
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



On 11/19/25 01:22, Rodrigo Siqueira wrote:
> When trying to unload amdgpu in the SteamDeck (TTY mode), the following
> set of errors happens and the system gets unstable:
> 
> [..]
>  [drm] Initialized amdgpu 3.64.0 for 0000:04:00.0 on minor 0
>  amdgpu 0000:04:00.0: [drm:amdgpu_ib_ring_tests [amdgpu]] *ERROR* IB test failed on gfx_0.0.0 (-110).
>  amdgpu 0000:04:00.0: amdgpu: ib ring test failed (-110).
> [..]
>  amdgpu 0000:04:00.0: amdgpu: SMU: I'm not done with your previous command: SMN_C2PMSG_66:0x0000001E SMN_C2PMSG_82:0x00000000
>  amdgpu 0000:04:00.0: amdgpu: Failed to disable gfxoff!
>  amdgpu 0000:04:00.0: amdgpu: SMU: I'm not done with your previous command: SMN_C2PMSG_66:0x0000001E SMN_C2PMSG_82:0x00000000
>  amdgpu 0000:04:00.0: amdgpu: Failed to disable gfxoff!
> [..]
> 
> When the driver initializes the GPU, the PSP validates all the firmware
> loaded, and after that, it is not possible to load any other firmware
> unless the device is reset. What is happening in the load/unload
> situation is that PSP halts the GC engine because it suspects that
> something is amiss. To address this issue, this commit ensures that the
> GPU is reset (mode 2 reset) in the unload sequence.

Mhm doing that on unload sounds like a bad idea to me.

We should rather do that on re-load to also cover the case of aborted VMs for example.

Regards,
Christian.

> 
> Suggested-by: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Rodrigo Siqueira <siqueira@igalia.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 860ac1f9e35d..80d00475bc9f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -3680,6 +3680,15 @@ static int amdgpu_device_ip_fini_early(struct amdgpu_device *adev)
>  				"failed to release exclusive mode on fini\n");
>  	}
>  
> +	/* Reset the device before entirely removing it to avoid load issues
> +	 * caused by firmware validation.
> +	 */
> +	if ((adev->flags & AMD_IS_APU) && !adev->gmc.is_app_apu) {
> +		r = amdgpu_asic_reset(adev);
> +		if (r)
> +			dev_err(adev->dev, "asic reset on %s failed\n", __func__);
> +	}
> +
>  	return 0;
>  }
>  

