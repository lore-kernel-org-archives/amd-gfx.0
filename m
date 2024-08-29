Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CA05C87FCD
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Aug 2024 18:09:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 003C010E75B;
	Thu, 29 Aug 2024 18:09:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JSD/lbJ4";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2057.outbound.protection.outlook.com [40.107.92.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 229C910E75B
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Aug 2024 18:09:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MAxXH6FCF5DzOFYtW2SS0I4OEkeUSVhRWOtFufMxVLQgla070udeQ0Z3ESW/+bHuDS5DNNg3aCTDs3tJ3O6pBA8kal2imX09XTEZOJfOvwbG6U1lEmCRZ2ua6UDJ+dtd6ImkfNKYLDBGvPdgNjhuONTdgCrk2T0cxquUzw2FKc9pREBUlvNUWe+Cd3qF52D4LvpzcQP6M0h1nr+P7vMNX2dVjMgnCOSBiy6li+x++9LctmypIZ4cu9U6TQBxJyYlPXhCSJfrtXfI2xwDXXFR5kumW7szqeImdk129DcIX89IR7ap7zjQdNC1uqpgaqy5MxmnvXaeRwA6bpQkRtW0oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pw5a34Urv9g5DD/tkKhNZoNlHrhM3UQiHUFr/BY2dSk=;
 b=bDfLUrKr+ZeYXwAS+torp63flHdFmw8hZEE2jKgyDK3tOCoUQLNd0K4ojGDpRio/X8NCoi70F3aLALui2yRskNj/HHwJ8W2UV1HDIJV0hJtm3DFduT1exQFTvWolbSijvMSl2Srn9lO0B6vkbafnycGgC2RtlaB4sqE+xYn6suIPqstrconuo2IHp0dpFRKnG0d7DbxBns3uceJ4NfqwzQWOCiSus1E6KsUxyuPhT8/xdp/GNzi9Sxc8DtdqU6CSB7BjydAIDvEldnMfIK40d4VGA0R7htwaUxV9V3+oEBlO9Cxpov7tgKB2Gjays2WWoLp7yULfHtIFMkyfOr0fxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pw5a34Urv9g5DD/tkKhNZoNlHrhM3UQiHUFr/BY2dSk=;
 b=JSD/lbJ4lW0yjBLlgLIbHlhUdefJaW0bOO6mwGao3s+h1u/DIs67n1bSXa3tquM2Khi2l8pV5npewQuwjXWCS/PGGn1ljYqtWLVQ1PWZcDox9UU7kVU0tQkhvhZIT7IE8hqAoKWYq7nX42iLBE/mMh2ezFkGMKEGdcDe9R84Gho=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4342.namprd12.prod.outlook.com (2603:10b6:208:264::7)
 by CH2PR12MB4119.namprd12.prod.outlook.com (2603:10b6:610:aa::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.28; Thu, 29 Aug
 2024 18:09:30 +0000
Received: from MN2PR12MB4342.namprd12.prod.outlook.com
 ([fe80::c55f:19e:6896:cf3]) by MN2PR12MB4342.namprd12.prod.outlook.com
 ([fe80::c55f:19e:6896:cf3%4]) with mapi id 15.20.7918.019; Thu, 29 Aug 2024
 18:09:30 +0000
Content-Type: multipart/alternative;
 boundary="------------5hzJ3fxs2YBwW340AlIRaCsA"
Message-ID: <c52a3df8-dcad-4fc7-8051-b8a05e1b49f2@amd.com>
Date: Thu, 29 Aug 2024 23:39:22 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: always allocate cleared VRAM for GEM
 allocations
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
Cc: =?UTF-8?Q?Michel_D=C3=A4nzer?= <mdaenzer@redhat.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
References: <20240829172645.1678920-1-alexander.deucher@amd.com>
Content-Language: en-US
From: "Paneer Selvam, Arunpravin" <arunpravin.paneerselvam@amd.com>
In-Reply-To: <20240829172645.1678920-1-alexander.deucher@amd.com>
X-ClientProxiedBy: PN2PR01CA0243.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:21a::6) To MN2PR12MB4342.namprd12.prod.outlook.com
 (2603:10b6:208:264::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB4342:EE_|CH2PR12MB4119:EE_
X-MS-Office365-Filtering-Correlation-Id: 011d24b2-5b27-4d19-7e2a-08dcc855ba0a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NC9sVTE0bFNSV3ZFekIyQmhqWHY5OThTNHdnU1d6Y3RIWlNaRm8xTm1OYXha?=
 =?utf-8?B?b1YvV2t3a2dFMzJtbVBJTTE4Nml2UzQrUSszVE9KWWZVakduOFE2WnZIMUFV?=
 =?utf-8?B?QzRwdmgzMThNV3dUaTMvL2poYzI3dHBqTDVzYlhRZS9FQU96K0ljMHZ3SjR5?=
 =?utf-8?B?dWU4U0ZIMmxrb0oyQjZYVWFLTXJEaUVjTFdFVC9oS2c1aDI3WW5peG42NWJB?=
 =?utf-8?B?eUhNTVEyT29rbHUrSTdMWjkzRW5XSzZraVQxTTd6ZS9jT0RLV2d1NlEvcTcw?=
 =?utf-8?B?L0J6Ym9SamZodGNmZjQwN1dGM3FrUXVXenp1UDczZHpXVG5jait1bytFTGVs?=
 =?utf-8?B?dDk3aityVFhHY0p2aEFpN1ZoRm8xKzdjM3Jva2pPcFNndFFDeHowNXdacWlT?=
 =?utf-8?B?enp0UVRGZDdFWjdqTnFnZm5BTGpDckV4Zi91c3JPVnIzKy9VQ2JkR2U2dnZo?=
 =?utf-8?B?RDczN09GR1ZkV3BEaEhaZjlYeFRGcS9iZU40YmtoazdSeExZSnZTeXcwK1pO?=
 =?utf-8?B?Q3VORklEU2J5eXRjS2hOL05RUjFBbnl1azIveDZzOHJGV1RJaVhmTnJ6c2xQ?=
 =?utf-8?B?S3JlUitLSHRRcFc2UWJIV1dXMWJpdVh3OS9DTWZpMnNudXlQT0xpY0Rzd1JY?=
 =?utf-8?B?RE1jb2ZNeTlqRnpjYW02a3FZZ0VzV25sRVVYdlNGMllZUEFENHoza1ZyY0pR?=
 =?utf-8?B?aFhEeWFseFhMTkZwUVU5a0o5d1JTSzhWUGZ1OTJIWlZadlRPaW9aT1RKTUo0?=
 =?utf-8?B?SjJia2RpbnRPaDZyOFY3ejZiVElWQ1AzOHhZWk5QekxLeGZidU1Xa3lEZ1Bu?=
 =?utf-8?B?NGkyVFlZWk55dlI2Sm1sZ0gxSDg0Zkl6ellnZnZCaDhuOUQ5OHpiNmZ5VTJB?=
 =?utf-8?B?aGZDNFJnRlRRMEd0K2Y1UHBiNU1WZ2ZFU2NBZlZyTFd4OEpDYzl5RUg0cnll?=
 =?utf-8?B?MHZsblY1Mjh3Mmp2eDkwWEhUbXRqRnIvT3NvOU5lbVZxc3JIM3RleE5VcERN?=
 =?utf-8?B?ZkpBOXpTVHl1MHlEdmZuNDd1TlNBZCtuTXdDSUU0am5uWFNZZFRLbmwxNDZE?=
 =?utf-8?B?UnlyaDZRUTFOOURJdzVXNFJHSzRteUlHTWtqditFYWtsOEdMdnNuYzg3U2tV?=
 =?utf-8?B?dG9ZeFBvbitxWWNvNHBrUDZpWEtocjZhbDdiS004VVJJUlA4bVdUZW5XVHJJ?=
 =?utf-8?B?TjdSSDRzSkpEK011ZjdjMUh1Z2xYOTNYR1lKYVZZRUNHSlVlNmU3ZEswMUNV?=
 =?utf-8?B?UWdSWXdsVDM2MFlxYUY3NDk0UldiMnVrTFZKRGJIdVVXa2Z0RkNBM1VSRzU3?=
 =?utf-8?B?YzlaZkNYcHFqY0hJc0xmMFY0cHJONjkxcTBWVUhRV0k4NmVnOVJNMkZESUE4?=
 =?utf-8?B?MXJRZEY5OVVxTDhrSnpKYjNOcU81QWZaVEcxN2lXL0xZSFJZK1JodWRTd2dy?=
 =?utf-8?B?TEhCMVFXQTg4b0F3QmJvSEF1VFJ0Y20veDNSYWlEZ0kxR3h2a2FVUXgyQmFu?=
 =?utf-8?B?Q2h5Qk1vSUVxanZJczJ6WVB3R2JlaHdKQkdMUjR1RGFZNEJLZ0hFa1I5WGxY?=
 =?utf-8?B?bVdNUzUxUnhtUGpuQmtLdlFWelNjRlFlUmx1SWdFaTJwR0dEaFV0UUpUZmRT?=
 =?utf-8?B?UzhBOER6bi9JbzhKOUhiRndiQTd3aWhpNzIzbHZycGUvajVpVWZMLyt4R05D?=
 =?utf-8?B?WVR4ekZqSk44Qk02Nm9kOHJRUVJmU2NNTkFvQXM1eGtWcG8yTCtsUjZIMW5J?=
 =?utf-8?Q?F38jUKQNe4LtLtbYTo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4342.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SG5kUnNicmpOL2YwV3lhSVFENDNUb2FxQlFiQ0dJbXg1NGFYSVlwMVo0V0pX?=
 =?utf-8?B?NVVrUjZxNkNabzM0Z3p0N1RYeXQ3VWJpamo0WU1BTndQSmhIOG1UZXJXNDV1?=
 =?utf-8?B?d2UrNmJIUldrYUVtQWd5NTBhQklXUDZseG1wUkl6YU5IbGloSytwb1Zlc1pn?=
 =?utf-8?B?NnhtamVaQVgvbm5pcFphcXNoM3lJVFZtL1JJYXhaRU96aUdya1pBcWllZU5O?=
 =?utf-8?B?bHRxQmVuQXJHcElLdmZSeEhlV21mbGlZaWMwN2RwRWFNRHA2b0RoTjE0UzhJ?=
 =?utf-8?B?UzREZzdjZHgyaDZTM3JNUTFSQWFvOVdYOFlIVVA2TnIxTDZqUTJOT09DYi82?=
 =?utf-8?B?ZjIyb29UTno0V2dadlJwNmpDaEFwNHVyeGNzOThJNzkwTkhReTBCRFJjdStK?=
 =?utf-8?B?MUM5WVJRd0tQWmR3Ymh1QUU3YXc0Z1crbzlZNlZzc3RrVWI2MVRJZldGWmpv?=
 =?utf-8?B?cG5QQ3Y5SDJvRTd1NWZYc2NhZFlVU09pOE40V3hhODA5cnMzRk5mUzdteUJ3?=
 =?utf-8?B?eTgwdjZGNDVMcDUzb0kyYW5yL1l0dU96b2h0T0RXYzU3OWtYZFRLMklWYmZm?=
 =?utf-8?B?WUJqS2Qzeko4c1JSUitEM25TZzdwTmpXSDVDaDBkVjdNalRRQTdMajM4cmpD?=
 =?utf-8?B?UXQvQ0JkMGRRQStiVWUzWGV0T1FFODVNSG9EZnowSHh4aytKdmt4UXVqdHd3?=
 =?utf-8?B?dG9yd3ZNcFcwRDBwY1ZQWWNUNDRlUUEycnV1TUJKYlJaWmZjakhLNWVFNGdz?=
 =?utf-8?B?MG0vTVprRldnR0VhSXNhV0VqSG9YaFBnczFsemZONlJSRXhPaUpqWVN4Qkda?=
 =?utf-8?B?cDQ5dnl6SHRYNHVoMkdnRWwzSE1yYmJlU3U0V1RITktaQkhhdFl0UnpONEhF?=
 =?utf-8?B?Z09NT0tJUUVHRWl1SGRkU05yK3F0cDBaREFia012N3JXSU5mY0dyWDgzQ3Ba?=
 =?utf-8?B?UTNYVzRXVUd4cU05YUkyNWZ1SGo2V0JWT2xKVUNlREhUdHdGZGxkaTczbTNK?=
 =?utf-8?B?emhnOVhJUzRsL1Q3N2dxODdUUFIyNjRUREo4amZZNGQ2UDRFblB0OTRSUWMx?=
 =?utf-8?B?TW52aGFweGtQbHRZSTJCVTJnZlV1b0lkN052ZjBvRnNrbUE4WlNOejBtSndi?=
 =?utf-8?B?OG40ajg1NzkzSzMvVEMrSWFwbS9Zb2RGWldGWGpBUXVlQWhtZ0lMeUdPc0dW?=
 =?utf-8?B?cWV1ZytNSGltTldSNWNkRnF6eDV3ak1tY0RQS1c1KzFXN1ZrY0tPM2FZQXFp?=
 =?utf-8?B?aEg0RVRLWml1TUJYeG11V1J3TmhYdGYyZHp4YmNPREpXMWpvR1lpNmNIVCtl?=
 =?utf-8?B?MGR2L3dBTnFnekV2NXpJNWhCZDRER3VWRFFxc3RRLzNnNll3azlIcnNlOFFF?=
 =?utf-8?B?RnBacVdlOURnem9FcE9XaWRpV2t1eXJJNkFyNDhpbllaYVBGeldXam9McG9w?=
 =?utf-8?B?YWF1YjdrSGwwdzIrMTZVdGdEYjgxbStyMW1OSElLZTI0ZlVGT21VQkxQSkpa?=
 =?utf-8?B?TWR2K2RMMHRhZ2NIRTNaeWdqOFdENVBMNDk4SFBSZlRIOGFmTnFpZi9yLzJS?=
 =?utf-8?B?U2s1Ym1PREZpbUJRSDd2L2syeTI1V2J3N1llV3BZQUhXanloWUJjK1JjTFVG?=
 =?utf-8?B?MjB3bEw4T3M5VkxBa01vVE13aHUwZ3VjckkrNnArM3pTMXBURlljQUlRVjZF?=
 =?utf-8?B?aFhHamtOZTBzQjc3SjR2dHh6N0FQYVJKYWFLMTRkZ0VERGZlQ3JiQ2h1Rm82?=
 =?utf-8?B?cGhJWHozeXUrQmpseE1iRGlLUldCVlJTQ1pKR2tWdk84QUQvV1VQVHJSSVgr?=
 =?utf-8?B?b2FOZmlyTkhhQWRQSVJzVjNMaEdlbzk0TFB6bVc2U2M5YVVqS2U5M2xlYkdV?=
 =?utf-8?B?QnFzK1hJUURONE02TFQxdThRRE9oVU1saE9HbWJoREpsNlpoTFB2ZWt0ZnQ3?=
 =?utf-8?B?NWVabVRyYnJMYjV2WDZ1Q05WbEhPMWkvZ1FwQWh6Y2FlVW9pc0EwMzRkRmNZ?=
 =?utf-8?B?L2JwdmI2WnpBd2ZySW5iN0FJdVdWOTIzbFJhMVpCdklBMlR6OVFNdHZadTRP?=
 =?utf-8?B?blBwWlVSTXFMcTY4bDlxNlFndVRiKzJLNzBpNE9mSW1RbjFLZkN6Ynk0amJl?=
 =?utf-8?Q?fR+8uEhn0MghncWjVK0kdx7yC?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 011d24b2-5b27-4d19-7e2a-08dcc855ba0a
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4342.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2024 18:09:30.1854 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 59dbBDmqNiPKQAi/GyT/sboyktjELzfhBIVRR8xEqih3Y55obO7tnjO+ZLW3wuIApG048gyPR0yeOTZdH1cEqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4119
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

--------------5hzJ3fxs2YBwW340AlIRaCsA
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

this will fix performance issues,
Acked-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com 
<mailto:Arunpravin.PaneerSelvam@amd.com>>

On 8/29/2024 10:56 PM, Alex Deucher wrote:
> This adds allocation latency, but aligns better with user
> expectations.  The latency should improve with the drm buddy
> clearing patches that Arun has been working on.
>
> In addition this fixes the high CPU spikes seen when doing
> wipe on release.
>
> v2: always set AMDGPU_GEM_CREATE_VRAM_CLEARED (Christian)
>
> Closes:https://gitlab.freedesktop.org/drm/amd/-/issues/3528
> Fixes: a68c7eaa7a8f ("drm/amdgpu: Enable clear page functionality")
> Reviewed-by: Michel Dänzer<mdaenzer@redhat.com>  (v1)
> Signed-off-by: Alex Deucher<alexander.deucher@amd.com>
> Cc: Arunpravin Paneer Selvam<Arunpravin.PaneerSelvam@amd.com>
> Cc: Christian König<christian.koenig@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 3 +++
>   1 file changed, 3 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> index 1f149c9e2177..8794661b0bfa 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> @@ -349,6 +349,9 @@ int amdgpu_gem_create_ioctl(struct drm_device *dev, void *data,
>   		return -EINVAL;
>   	}
>   
> +	/* always clear VRAM */
> +	flags |= AMDGPU_GEM_CREATE_VRAM_CLEARED;
> +
>   	/* create a gem object to contain this object in */
>   	if (args->in.domains & (AMDGPU_GEM_DOMAIN_GDS |
>   	    AMDGPU_GEM_DOMAIN_GWS | AMDGPU_GEM_DOMAIN_OA)) {

--------------5hzJ3fxs2YBwW340AlIRaCsA
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <span style="font-family:Aptos">this will fix performance issues,<br>
      Acked-by: </span><span style="font-family:Calibri">Arunpravin
      Paneer Selvam &lt;</span><a href="mailto:Arunpravin.PaneerSelvam@amd.com"><span style="font-family:Calibri">Arunpravin.PaneerSelvam@amd.com</span></a><span style="font-family:Calibri">&gt;</span><br>
    <br>
    <div class="moz-cite-prefix">On 8/29/2024 10:56 PM, Alex Deucher
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20240829172645.1678920-1-alexander.deucher@amd.com">
      <pre class="moz-quote-pre" wrap="">This adds allocation latency, but aligns better with user
expectations.  The latency should improve with the drm buddy
clearing patches that Arun has been working on.

In addition this fixes the high CPU spikes seen when doing
wipe on release.

v2: always set AMDGPU_GEM_CREATE_VRAM_CLEARED (Christian)

Closes: <a class="moz-txt-link-freetext" href="https://gitlab.freedesktop.org/drm/amd/-/issues/3528">https://gitlab.freedesktop.org/drm/amd/-/issues/3528</a>
Fixes: a68c7eaa7a8f (&quot;drm/amdgpu: Enable clear page functionality&quot;)
Reviewed-by: Michel Dänzer <a class="moz-txt-link-rfc2396E" href="mailto:mdaenzer@redhat.com">&lt;mdaenzer@redhat.com&gt;</a> (v1)
Signed-off-by: Alex Deucher <a class="moz-txt-link-rfc2396E" href="mailto:alexander.deucher@amd.com">&lt;alexander.deucher@amd.com&gt;</a>
Cc: Arunpravin Paneer Selvam <a class="moz-txt-link-rfc2396E" href="mailto:Arunpravin.PaneerSelvam@amd.com">&lt;Arunpravin.PaneerSelvam@amd.com&gt;</a>
Cc: Christian König <a class="moz-txt-link-rfc2396E" href="mailto:christian.koenig@amd.com">&lt;christian.koenig@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index 1f149c9e2177..8794661b0bfa 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -349,6 +349,9 @@ int amdgpu_gem_create_ioctl(struct drm_device *dev, void *data,
 		return -EINVAL;
 	}
 
+	/* always clear VRAM */
+	flags |= AMDGPU_GEM_CREATE_VRAM_CLEARED;
+
 	/* create a gem object to contain this object in */
 	if (args-&gt;in.domains &amp; (AMDGPU_GEM_DOMAIN_GDS |
 	    AMDGPU_GEM_DOMAIN_GWS | AMDGPU_GEM_DOMAIN_OA)) {
</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------5hzJ3fxs2YBwW340AlIRaCsA--
