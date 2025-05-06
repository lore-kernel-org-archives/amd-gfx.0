Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B72DC3ABBF
	for <amd-gfx@archiver.kernel.org>; Tue,  6 May 2025 09:11:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D72910E629;
	Tue,  6 May 2025 09:11:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kzSIUKHG";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2084.outbound.protection.outlook.com [40.107.100.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E5D0110E29B
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 May 2025 09:11:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d9UDp3yFSB+hif3bdUlxrxVJul0oowaM5q7r2dMheIOBHT9fxY0wbA2dnczxfQE0ZHZLoHBMVFyJgzD9xekSZIkVHN6cTmK2YjD+HonE5ucSzImOuqBQdSmHiCJ8r8TRvzzFCoase7+/5h1Cu4Y6QG5AuFeZj3cGdXgnxu/J6vmNlp2n+NIJteWeOqxqS+XnhEgPe6/cz40T77W2v6YA+1+ypoMkv3IVYCzW6ua6hfDmrkuqg0wAuFtzYRKhTw+Yyg+GMgKH+35VAWsQzA4gbbUoCpReQq4Ihpt8zEB5qhHIGRPyL5crabWN15aOQUCLC4/1anYSqgJJMOjDiaVMZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QD6RoQVpQWj93eOhTzCzg1gX1bb9A/+Ld+8K+m0ECFA=;
 b=GMwhUHxw2ClU4UBos6yOubhA+P3r3OG/+eqjjZxhR72AwWPTD9nkxAmwQbKhD6vD0PjH5hcoUUpjl2yF8s0tJyB/DeSXEVngQQfkRWjcu7siX2vKvCv4KKXIDnrzHx9jN0QdLgT/UeEduwaVGGtuwbZfmo9SdcuzSjBdDtQk8zIfxmgItZj3Un69vf+J3SD+EKGkS9ceYJO8i0lV4v/W8IzpfQgrYHDLCINx93fCCFIRrHXEoJW8VPSRDGSR+Rz6dl3LsF2Ae8ELoZ92bZOS5f6fgfg09EMxQ884JPIi6xdgQAmV0erdcNziys7KUNwbhkpWv3QERoLzEjaO0FePPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QD6RoQVpQWj93eOhTzCzg1gX1bb9A/+Ld+8K+m0ECFA=;
 b=kzSIUKHGaop5FkpEFQJNIiOhgvkXD48LTawcRYZXfEIoWdTV/T5cBOHPmHrVde1Ugx7OXEzsujTXMyISBHma9x2PSlXo/FKeZtf8T4EbZ+46p2sHyvwe/GTJ7oCvwndIcIitYawwC/pHmIzQ/ZEIjptvgETNGWeNuRem1h1j7og=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by MW4PR12MB5604.namprd12.prod.outlook.com (2603:10b6:303:18d::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.33; Tue, 6 May
 2025 09:11:11 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%7]) with mapi id 15.20.8678.028; Tue, 6 May 2025
 09:11:11 +0000
Message-ID: <68f1a2b6-35d0-4c8b-b317-6f56c4b1218b@amd.com>
Date: Tue, 6 May 2025 11:11:07 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/7] drm/amdgpu/userq: implement resets
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Sunil Khatri <sunil.khatri@amd.com>
References: <20250430154809.2665473-1-alexander.deucher@amd.com>
 <20250430154809.2665473-5-alexander.deucher@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250430154809.2665473-5-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0129.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9e::16) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|MW4PR12MB5604:EE_
X-MS-Office365-Filtering-Correlation-Id: 8fbeafbf-61fc-45bb-aee8-08dd8c7df17d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dGFaYVdEL2FIRmo3QlI1dUFqMlF0VjFPTUtwWGgwNHh4UXFtaThaK09XK3cy?=
 =?utf-8?B?VTBzU0dIV0RwdDBXUnNweDcwMEtsNFkxa0s2WWVnVEI4cmMyQVhzY0p5RGh0?=
 =?utf-8?B?QkpJYmRUSnFDTlVYcEhZWGZmZGVmZEsvc2dnWVlLMTNpT0gwZUlDZ1RPZnBX?=
 =?utf-8?B?U05WY1BPeUpON21GN3d6aTRld0xaR09pelg1WGJtY3VCVUtXODdhQUZwUXM2?=
 =?utf-8?B?R0NId0p3SFEvWVh5dk14S2Joam1lekhPbzZmemRTSXJ0QVNVWCthdVUxaUhD?=
 =?utf-8?B?S08zS05idWp6K0VnSkMrOVl2VjdISjdzUkV3YlNWNUMwSjJ5U3gzeWQ3cFdE?=
 =?utf-8?B?c3VmZ3pSaHN3bUtPTDg2VjNmcnpKZlNNV0tWQ1ZmUTZSNnZ0SmdVWG9WL3FN?=
 =?utf-8?B?a1BXY203bW50dlA2WE9pN2E1U3dHdlpwRVBRbGkwQ2R3aGIxVkVaNHBabFkv?=
 =?utf-8?B?Qk5acVcrMGhrYVVoaXBsbSt0UDdFaVhwNUg0dEM3SlF0c2NUUGVpclkyRGRP?=
 =?utf-8?B?SVFKRXpaWlk0MVIzbVdhT0VtTS9iSGl0UVIvS0o3M2dGWnFqMVpXdUpydlkv?=
 =?utf-8?B?YWFuTVp4SXVHTHJSNVhycHhBY0RYRHUrYVA2bUxhdEZKZTZPMVJkbjh6OTFO?=
 =?utf-8?B?Ym1KRlkzclVCdUVOV0V5QjJxbmt4VnI0QTBjWVoyOVdYaFYvV1orUFQrWnd5?=
 =?utf-8?B?Rnp1eG1zY3BGL1lab29NSHppUHVtUHVaMERBQk5iZXNNVWxMREZpM0tPRnY2?=
 =?utf-8?B?TFhxQmYyNVRQMFZHc2JiZU5ldisrZnB2RTdTbFpxOHA2bWsxYjAyTENvWDZh?=
 =?utf-8?B?c1Uzd1h3TEJkWjZKaXdRMXZrc0tiWE9TekIza3lUbWcyczBKK0sveVFQTnc2?=
 =?utf-8?B?aE42ZXdwbFVLQlpHSitDZDdBdS9vVktoNU9rTmtSaktTS0t3aVpFYStWZ1o0?=
 =?utf-8?B?V250RVZ0NlNFOStmQ244YW1lWjVQSEhCMGNYbnNodTVNbG12Q2RDeDgwMThX?=
 =?utf-8?B?R1hCelo2MjBRQlZZMS9DMmlvM3NlbytwNUdTWFpOSDROOGxJWkZxNkkvTTE1?=
 =?utf-8?B?UnY2TWJNVWdKNFl4eVZMeWRqTy9Nd1IraDZsTWozcGpiZTZrdXlqcm9zS1JY?=
 =?utf-8?B?ckFqeFRoT0VIWUxwVGd3VUJkR1kvSm1OdW5vRHF1S0F4WnA5emxDaHhkMzZ1?=
 =?utf-8?B?UlE1c05KWnRQSWxNMWp6YUlDZ0RLMk9ENmltWDU1YkFTSG5kSFRvMFZLcXJo?=
 =?utf-8?B?S2R6RmEvclZBMTF3YjhpN0N1UWRhNjBYTlY4akRmRUV3SkRmbEVLUngwVFZa?=
 =?utf-8?B?WjMrZzlPc1d1eGJyUGFGK0N0QkNDYTFoeFExZUpIc0RsMWJlOTlRNWFnT1RC?=
 =?utf-8?B?d2hqVEI2SVJEZithYUQzOFhJSXh2b3dDbnFMNGQrNGpCV3ZGaDhUSGZEVTVY?=
 =?utf-8?B?enRpK2NSZ1NNSDR6TEdnTHdZY2x0UEJWMStteTJmdnhtOEY5amZyZm9xaS9Y?=
 =?utf-8?B?N2l2TUVHb08wdVdpSExkaVFkb2IyT3FrNkt2WkVET2JqWGFpM0E0UE1WU2pn?=
 =?utf-8?B?Q3Bha3ZhY01XYm9JYlozZ25lVGJoc2tGRmhTZkxTaC9LcU9KTHpjVGFCRXhm?=
 =?utf-8?B?K2VKK0hPbXg5OVZvbFd5aG1ybzFub3lhakdzSDFvMHFhZ2swSFV1RWhOL3Ft?=
 =?utf-8?B?MlFJSDAvZ0RRMmNNc0ZHTHRWdFYyOEl6MEk5cTZBQWVINGdSc3FRSllTT0d0?=
 =?utf-8?B?TW1HdEJaVjc2czZXd3ZUYWhlNU5ZOXJOaGpiTUhncXc4UE50OVZrTGl6RTJQ?=
 =?utf-8?B?ZEo2L3VsNkZzQkFWdTZpKy80NlJUc0JPc0U1Wjd0NW5DSlQ3c1NLQUFRUmVa?=
 =?utf-8?B?dmJhbTROZml0VmxkQi9lMVViZDRzK25GNWowUXZneEtQYUFvZWZMVnN5YW4w?=
 =?utf-8?Q?bTRmf3jOfV8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MEN4R1RXT1ZoTmFjLzZ6d0NvNFRnN0xKQzE3WEhnWnl1YWZQc0xPRDcvc2Ni?=
 =?utf-8?B?RlVnRmNHd25JY1ZFOW14N1pkbHdLVGJ5SDZrQS9mckJJV2Vobm9OVlRxczJ1?=
 =?utf-8?B?QWxqeWxwaVlkYlo2TEkwdEp2RHloSnU0eFFKQU1NbmNaMzJWZFVqK1VGTjN2?=
 =?utf-8?B?LzVXZmxXVVpmZlJTeWRWVmo2QWR3clFoTEkyS2U3b243TVZROVpSMGd0azFw?=
 =?utf-8?B?ZVpXM25WMDN6TXJpQWp2TDZ3M1NWQkZUMEhPdmlpa3hJMGFDbGxZa2VWbzJL?=
 =?utf-8?B?V1J0VzdDWWRBS0M4Zjh4eHFkaGl1b0YvUHBsbXk3SzM0YTN0VXZwb3ErbGRJ?=
 =?utf-8?B?NXhUQTRuSWhIUEF3NC9BMGdlZXZGby80K0xmZ3pmOGE3Ymc0RHFCTG1HUHBa?=
 =?utf-8?B?WGsyUlhuS01DNGFVeFpncXY2Q3lGdFlIYW1nQ3pWbjlXQkF4UlJKWXMxOVBZ?=
 =?utf-8?B?UElqd04vazV4bVRrc3dVNWd5emVsQ2dTS2lXWmlnTWUyU1hWd1pPNmErQzBK?=
 =?utf-8?B?ejk1SmkwQnpteEdmMU5KRElRMlZKTDdiZG5JbGowU2I2WWNXVXBsU3N4enhm?=
 =?utf-8?B?VllwbVkyblBpU090ajZYUHBwVnBrRHQ1cEFjSFErTzc4QnhCLzBScTNpVmtt?=
 =?utf-8?B?TmNUM1o0TVUvT25xdlRJT2dVSWpKYTJXVXdNQ0g0TStIVEU0YkRObWRKZHU4?=
 =?utf-8?B?MjBVUUo3UG5sWFY5NmVqWE1KZkFYVHZESlhKaHlvQ1FGSUNkbzN5T0ZvVlVN?=
 =?utf-8?B?Mm5mSFpzcDlENHVBbWFLWGFRLzJDOG5YRmpveW9tdnd1SHJaSytVdC85Ukp1?=
 =?utf-8?B?QWVVWURKNTFHYUd4NjJzUTJ6dStzMkdyVEtnaVNjbStMWXdjZ3o2OXRrN1JI?=
 =?utf-8?B?ZXVuT1NiK0hFZjBTMnpVY2ExLzhkZXBWY01sTFg3NFpTQWZHZjBzaDZvcE9S?=
 =?utf-8?B?VStSeVUxdDRKMWI0L1J6VjdIcXdHL3g2dElzNXNNakprWStDNVpSempFOFpU?=
 =?utf-8?B?aHJOMTJESjlkRkZLSTA3ZjFpOTR6QW9PZ0lGWk91VHlnT0RadmZzRGZOS1d4?=
 =?utf-8?B?Z0I3UmZWWWV5b1ptYmxLT0xxbi9KZEd4Z29DOENHNzRMVFZOcm1lTHE5alpL?=
 =?utf-8?B?RVBTNjJlMlkrWWpaR21Bb2xsL0dNOGxTT08zSWs2L0hoRGZPSkh6b3l2WHRY?=
 =?utf-8?B?WlVOSXBxd3ZGS3J3dUVDWnRCckhtOXRuaDJYRWJnblFmUWxYZXN6ZFMzcSs3?=
 =?utf-8?B?aVVadThrTDBaTFFYMnFLdUlicVBFcHVlNVhhSzFhbzB0Vm04aldlakwrZ2NV?=
 =?utf-8?B?VE1wMGVLN3dtMGpQWEpkdHV0MkhnNnYyV1BVcm1iaXo2U1l1VmZwZXJpZUE3?=
 =?utf-8?B?ZTA0Z2YvSTNNdldBR08yaDRRTjBKKzViQ1lUZXY0YjJkOHAvTDQ0dHI0eVZs?=
 =?utf-8?B?bW85aklCY2dIM0NGWlJsUm44VFc2Q3hVeUo5Zzkya3p1bjFGSnQvVk4xOG5K?=
 =?utf-8?B?UGVUT2J0SjNqSURDKzhOYjZ5Zy92Mk9nTjAzcG1idDQ0Y3hjZkxlcDNqUXYv?=
 =?utf-8?B?RHpMV2dtL0o4QXRhWGV5SVdVc25ueHc0eXEzdHJTejZtMkZwQ0RZYlFac0ZO?=
 =?utf-8?B?SnBxcWVGL0VIckFKVmpFT21zWjJvckdsKzlBb25nd1dmaEFROEVmMXpNQlFS?=
 =?utf-8?B?Zk4zeVErMEpwblI2MFpDcmVHVWhtdEpCYmdjaFluZUhoMVAxdW9lU2F4bXVJ?=
 =?utf-8?B?WkptTDBlRnpSd0ZUSjR5eUxlVW9DNmh0TUFCbjkyU3JJbDUxa2JkbVh5ekNG?=
 =?utf-8?B?MUp0Wk9pZ0EyTkFQNWdUc2tsSjRFZmJ2b0hwMjlrN1JzUGhGVGN6eEVNTURu?=
 =?utf-8?B?K0sxVkVZL1plTWVrRzlEVE9TWlJkUzhVSWw5NWVIZ1hPK21nZjU3Q3FhQURQ?=
 =?utf-8?B?ZEo0VkJGclJlVmZBQURCenprMnVqUFB5MGtJM2RIdGlPMjBlazNONUlaL3lF?=
 =?utf-8?B?clBwOVZKdjNyL0twaXVhUnJEL1Z3VzJSUU5nYUNuY2pOVUZwV1UyTk5Pblo1?=
 =?utf-8?B?d0lzbk1IdWtnOHcvUTR2b1hoUHB6c0JnY0pUSGxzZGtCRmpLdUxXeUNwcDNz?=
 =?utf-8?Q?AT/FlefxhNxi0VFm7VHno/ZNu?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fbeafbf-61fc-45bb-aee8-08dd8c7df17d
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2025 09:11:10.9748 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cwD2bgQic2uy23yRu96cFEBCwR5jKJuhd1q4WLbOwf31AprAnKOcOtiL4q5S1y8q
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5604
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

On 4/30/25 17:48, Alex Deucher wrote:
> If map or unmap fails, or a user fence times out, attempt to
> reset the queue.  If that fails, schedule a GPU reset.
> 
> Reviewed-by: Sunil Khatri <sunil.khatri@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Acked-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h        |   1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |   8 ++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c  | 128 +++++++++++++++++++--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h  |   5 +
>  4 files changed, 131 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index cc26cf1bd843e..936e1a0ac02f1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -1251,6 +1251,7 @@ struct amdgpu_device {
>  	struct list_head		userq_mgr_list;
>  	struct mutex                    userq_mutex;
>  	bool                            userq_halt_for_enforce_isolation;
> +	struct work_struct		userq_reset_work;
>  };
>  
>  static inline uint32_t amdgpu_ip_version(const struct amdgpu_device *adev,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index fe68ba9997ae4..317c86c1493a8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -4420,6 +4420,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>  	}
>  
>  	INIT_WORK(&adev->xgmi_reset_work, amdgpu_device_xgmi_reset_func);
> +	INIT_WORK(&adev->userq_reset_work, amdgpu_userq_reset_work);
>  
>  	adev->gfx.gfx_off_req_count = 1;
>  	adev->gfx.gfx_off_residency = 0;
> @@ -5777,6 +5778,10 @@ int amdgpu_device_reinit_after_reset(struct amdgpu_reset_context *reset_context)
>  				if (r)
>  					goto out;
>  
> +				r = amdgpu_userq_post_reset(tmp_adev, vram_lost);
> +				if (r)
> +					goto out;
> +
>  				drm_client_dev_resume(adev_to_drm(tmp_adev), false);
>  
>  				/*
> @@ -5999,6 +6004,7 @@ static inline void amdgpu_device_stop_pending_resets(struct amdgpu_device *adev)
>  	if (!amdgpu_sriov_vf(adev))
>  		cancel_work(&adev->reset_work);
>  #endif
> +	cancel_work(&adev->userq_reset_work);
>  
>  	if (adev->kfd.dev)
>  		cancel_work(&adev->kfd.reset_work);
> @@ -6109,6 +6115,8 @@ static int amdgpu_device_halt_activities(struct amdgpu_device *adev,
>  		      amdgpu_device_ip_need_full_reset(tmp_adev))
>  			amdgpu_ras_suspend(tmp_adev);
>  
> +		amdgpu_userq_pre_reset(tmp_adev);
> +
>  		for (i = 0; i < AMDGPU_MAX_RINGS; ++i) {
>  			struct amdgpu_ring *ring = tmp_adev->rings[i];
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> index afbe01149ed3f..4be46fa76ceba 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -26,7 +26,10 @@
>  #include <drm/drm_exec.h>
>  #include <linux/pm_runtime.h>
>  
> +#include <drm/drm_drv.h>
> +
>  #include "amdgpu.h"
> +#include "amdgpu_reset.h"
>  #include "amdgpu_vm.h"
>  #include "amdgpu_userq.h"
>  #include "amdgpu_userq_fence.h"
> @@ -44,6 +47,44 @@ u32 amdgpu_userq_get_supported_ip_mask(struct amdgpu_device *adev)
>  	return userq_ip_mask;
>  }
>  
> +static void amdgpu_userq_gpu_reset(struct amdgpu_device *adev)
> +{
> +
> +	if (amdgpu_device_should_recover_gpu(adev))
> +		amdgpu_reset_domain_schedule(adev->reset_domain,
> +					     &adev->userq_reset_work);
> +}
> +
> +static bool
> +amdgpu_userq_queue_reset_helper(struct amdgpu_userq_mgr *uq_mgr,
> +				struct amdgpu_usermode_queue *queue)
> +{
> +	struct amdgpu_device *adev = uq_mgr->adev;
> +	const struct amdgpu_userq_funcs *userq_funcs =
> +		adev->userq_funcs[queue->queue_type];
> +	bool gpu_reset = false;
> +	int r;
> +
> +	if (unlikely(adev->debug_disable_gpu_ring_reset)) {
> +		dev_err(adev->dev, "userq reset disabled by debug mask\n");
> +	} else if (amdgpu_gpu_recovery && userq_funcs->reset) {
> +		r = userq_funcs->reset(uq_mgr, queue);
> +		if (r) {
> +			dev_err(adev->dev, "userq reset failed\n");
> +			gpu_reset = true;
> +		} else {
> +			dev_err(adev->dev, "userq reset succeeded\n");
> +			atomic_inc(&adev->gpu_reset_counter);
> +			amdgpu_userq_fence_driver_force_completion(queue);
> +			drm_dev_wedged_event(adev_to_drm(adev), DRM_WEDGE_RECOVERY_NONE);
> +		}
> +	} else if (amdgpu_gpu_recovery && !userq_funcs->reset) {
> +		gpu_reset = true;
> +	}
> +
> +	return gpu_reset;
> +}
> +
>  static int
>  amdgpu_userq_unmap_helper(struct amdgpu_userq_mgr *uq_mgr,
>  			  struct amdgpu_usermode_queue *queue)
> @@ -51,15 +92,22 @@ amdgpu_userq_unmap_helper(struct amdgpu_userq_mgr *uq_mgr,
>  	struct amdgpu_device *adev = uq_mgr->adev;
>  	const struct amdgpu_userq_funcs *userq_funcs =
>  		adev->userq_funcs[queue->queue_type];
> +	bool gpu_reset = false;
>  	int r = 0;
>  
>  	if (queue->state == AMDGPU_USERQ_STATE_MAPPED) {
>  		r = userq_funcs->unmap(uq_mgr, queue);
> -		if (r)
> +		if (r) {
>  			queue->state = AMDGPU_USERQ_STATE_HUNG;
> -		else
> +			gpu_reset = amdgpu_userq_queue_reset_helper(uq_mgr, queue);
> +		} else {
>  			queue->state = AMDGPU_USERQ_STATE_UNMAPPED;
> +		}
>  	}
> +
> +	if (gpu_reset)
> +		amdgpu_userq_gpu_reset(adev);
> +
>  	return r;
>  }
>  
> @@ -70,16 +118,22 @@ amdgpu_userq_map_helper(struct amdgpu_userq_mgr *uq_mgr,
>  	struct amdgpu_device *adev = uq_mgr->adev;
>  	const struct amdgpu_userq_funcs *userq_funcs =
>  		adev->userq_funcs[queue->queue_type];
> +	bool gpu_reset = false;
>  	int r = 0;
>  
>  	if (queue->state == AMDGPU_USERQ_STATE_UNMAPPED) {
>  		r = userq_funcs->map(uq_mgr, queue);
>  		if (r) {
>  			queue->state = AMDGPU_USERQ_STATE_HUNG;
> +			gpu_reset = amdgpu_userq_queue_reset_helper(uq_mgr, queue);
>  		} else {
>  			queue->state = AMDGPU_USERQ_STATE_MAPPED;
>  		}
>  	}
> +
> +	if (gpu_reset)
> +		amdgpu_userq_gpu_reset(adev);
> +
>  	return r;
>  }
>  
> @@ -698,6 +752,23 @@ amdgpu_userq_evict_all(struct amdgpu_userq_mgr *uq_mgr)
>  	return ret;
>  }
>  
> +void amdgpu_userq_reset_work(struct work_struct *work)
> +{
> +	struct amdgpu_device *adev = container_of(work, struct amdgpu_device,
> +						  userq_reset_work);
> +	struct amdgpu_reset_context reset_context;
> +
> +	memset(&reset_context, 0, sizeof(reset_context));
> +
> +	reset_context.method = AMD_RESET_METHOD_NONE;
> +	reset_context.reset_req_dev = adev;
> +	reset_context.src = AMDGPU_RESET_SRC_USERQ;
> +	set_bit(AMDGPU_NEED_FULL_RESET, &reset_context.flags);
> +	/*set_bit(AMDGPU_SKIP_COREDUMP, &reset_context.flags);*/
> +
> +	amdgpu_device_gpu_recover(adev, NULL, &reset_context);
> +}
> +
>  static int
>  amdgpu_userq_wait_for_signal(struct amdgpu_userq_mgr *uq_mgr)
>  {
> @@ -724,22 +795,19 @@ void
>  amdgpu_userq_evict(struct amdgpu_userq_mgr *uq_mgr,
>  		   struct amdgpu_eviction_fence *ev_fence)
>  {
> -	int ret;
>  	struct amdgpu_fpriv *fpriv = uq_mgr_to_fpriv(uq_mgr);
>  	struct amdgpu_eviction_fence_mgr *evf_mgr = &fpriv->evf_mgr;
> +	struct amdgpu_device *adev = uq_mgr->adev;
> +	int ret;
>  
>  	/* Wait for any pending userqueue fence work to finish */
>  	ret = amdgpu_userq_wait_for_signal(uq_mgr);
> -	if (ret) {
> -		DRM_ERROR("Not evicting userqueue, timeout waiting for work\n");
> -		return;
> -	}
> +	if (ret)
> +		dev_err(adev->dev, "Not evicting userqueue, timeout waiting for work\n");
>  
>  	ret = amdgpu_userq_evict_all(uq_mgr);
> -	if (ret) {
> -		DRM_ERROR("Failed to evict userqueue\n");
> -		return;
> -	}
> +	if (ret)
> +		dev_err(adev->dev, "Failed to evict userqueue\n");
>  
>  	/* Signal current eviction fence */
>  	amdgpu_eviction_fence_signal(evf_mgr, ev_fence);
> @@ -914,3 +982,41 @@ int amdgpu_userq_start_sched_for_enforce_isolation(struct amdgpu_device *adev,
>  	mutex_unlock(&adev->userq_mutex);
>  	return ret;
>  }
> +
> +void amdgpu_userq_pre_reset(struct amdgpu_device *adev)
> +{
> +	const struct amdgpu_userq_funcs *userq_funcs;
> +	struct amdgpu_usermode_queue *queue;
> +	struct amdgpu_userq_mgr *uqm, *tmp;
> +	int queue_id;
> +
> +	mutex_lock(&adev->userq_mutex);
> +	list_for_each_entry_safe(uqm, tmp, &adev->userq_mgr_list, list) {
> +		cancel_delayed_work_sync(&uqm->resume_work);
> +		mutex_lock(&uqm->userq_mutex);
> +		idr_for_each_entry(&uqm->userq_idr, queue, queue_id) {
> +			if (queue->state == AMDGPU_USERQ_STATE_MAPPED) {
> +				amdgpu_userq_wait_for_last_fence(uqm, queue);
> +				userq_funcs = adev->userq_funcs[queue->queue_type];
> +				userq_funcs->unmap(uqm, queue);
> +				/* just mark all queues as hung at this point.
> +				 * if unmap succeeds, we could map again
> +				 * in amdgpu_userq_post_reset() if vram is not lost
> +				 */
> +				queue->state = AMDGPU_USERQ_STATE_HUNG;
> +				amdgpu_userq_fence_driver_force_completion(queue);
> +			}
> +		}
> +		mutex_unlock(&uqm->userq_mutex);
> +	}
> +	mutex_unlock(&adev->userq_mutex);
> +}
> +
> +int amdgpu_userq_post_reset(struct amdgpu_device *adev, bool vram_lost)
> +{
> +	/* if any queue state is AMDGPU_USERQ_STATE_UNMAPPED
> +	 * at this point, we should be able to map it again
> +	 * and continue if vram is not lost.
> +	 */
> +	return 0;
> +}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> index 24d201cdc9887..6ede08dd821d2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> @@ -132,4 +132,9 @@ int amdgpu_userq_stop_sched_for_enforce_isolation(struct amdgpu_device *adev,
>  int amdgpu_userq_start_sched_for_enforce_isolation(struct amdgpu_device *adev,
>  						   u32 idx);
>  
> +void amdgpu_userq_reset_work(struct work_struct *work);
> +
> +void amdgpu_userq_pre_reset(struct amdgpu_device *adev);
> +int amdgpu_userq_post_reset(struct amdgpu_device *adev, bool vram_lost);
> +
>  #endif

