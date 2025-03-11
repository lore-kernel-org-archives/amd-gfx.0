Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 004FEC282EC
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Mar 2025 21:56:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8F0AF10E5F0;
	Tue, 11 Mar 2025 21:56:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1OGH480H";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2051.outbound.protection.outlook.com [40.107.96.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5080D10E5F0
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Mar 2025 21:56:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DuyXr7MkXB3u7zKPZvXIksnMIS3oqSUURua+rq5RiQ6i0j6z1E+u471zkJh6M8t9E3zfbMQS+QOpnPj9Hd+2eabX2kTf1b2NM9OjkpubZ93muvZO8QzYAPDAjMUxz1w5dYFp/G+PFGnNTRN8cG8TqxBu68h4h5ljAd4QQ+1URJJCuHaOR7VKFadt8o/qyTfIf334HwrcDPsFweRPAGXjiBkFWjo1heQzYNu2I+59qSLlwvG0fpATsu8I47ZZfPXFCVS1o7dNUCtapWldGwPouddvCqJEEavMA5E/QNYlyoQG2xkKITSi7h0h50m84005OhnbEjko4ejtv/YBNqaxJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s4NKQ0A2oNPUadfssOtAJkTaLJoa7onxbIOUDVmCQKI=;
 b=Hh7OHixvrFdZ4zELfGxnhjWOmPRN1J07qsgfv4Bvqy6cyq5wvIS0s6K3sRCJ8X6p4szHjF14ankESy3B/KniuH2Pyg+9wtUnL7ELZyuKtOGn0AaP63nElsKSqAg5J6jBgUnC8jqfpGxsRW4+k4f/5gSlIfa0UAh/J6a/O3gm+PRV8xS3PBlzpuMwEgEciL3GFz6iwgXrbyMFildeZbhQT91NUvY6o4YDvf7m5ODzBewwRTBAWT0UM4Q6nmcJTOa13j8HxxIrg1uPlixWIVckSyEmGGIkuZ3BncUaXf1XSq4MmZDDw6DqzR7cF9b+L4cktMB5uq3cdjyG22QKIN5pnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s4NKQ0A2oNPUadfssOtAJkTaLJoa7onxbIOUDVmCQKI=;
 b=1OGH480HcVlB0qbmQaEP+Uhc1HWSetNfOaMPwS00yH/EEf3LzRNqPUBgGYXQb4Vpb0pWTZEP3qCHmGAVINY2NIZjd0+Xvn/gRwzky6vUZtzHA3C9aMXlE69qxeSWXMWRa0y/Hi8Ul1N/2q40uDGNXG06FlF0WqID5Qea0JZVJfk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV3PR12MB9095.namprd12.prod.outlook.com (2603:10b6:408:1a6::22)
 by LV8PR12MB9205.namprd12.prod.outlook.com (2603:10b6:408:191::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Tue, 11 Mar
 2025 21:56:26 +0000
Received: from LV3PR12MB9095.namprd12.prod.outlook.com
 ([fe80::e8c:f2db:ab98:4538]) by LV3PR12MB9095.namprd12.prod.outlook.com
 ([fe80::e8c:f2db:ab98:4538%6]) with mapi id 15.20.8511.026; Tue, 11 Mar 2025
 21:56:24 +0000
Message-ID: <d9e926ca-bdda-4237-b954-8b3a2e41eeab@amd.com>
Date: Tue, 11 Mar 2025 21:56:20 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdkfd: Fix instruction hazard in gfx12 trap
 handler
To: Jay Cornwall <jay.cornwall@amd.com>, amd-gfx@lists.freedesktop.org
References: <20250207233837.2738432-1-jay.cornwall@amd.com>
Content-Language: en-US
From: Lancelot SIX <Lancelot.Six@amd.com>
In-Reply-To: <20250207233837.2738432-1-jay.cornwall@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0097.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a1::15) To LV3PR12MB9095.namprd12.prod.outlook.com
 (2603:10b6:408:1a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR12MB9095:EE_|LV8PR12MB9205:EE_
X-MS-Office365-Filtering-Correlation-Id: 17410b96-1503-487c-5abd-08dd60e790db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZUtwU2IvSGhYM3FBUzRPZHU1b1BnV0kvWS9BK0lFUzNCaFRybUNZeENnYm1M?=
 =?utf-8?B?NlQybm1lME41RnJLZ1l5K3JqREtrZ0ZkTjRxeFBzVnZYK3Y3RUNPbFVHVHFQ?=
 =?utf-8?B?b3UzejlNbVhvT1FLb2t1aDVuYWtZNFRianFtZnFOekZyRnFMcmEyUk9QYThr?=
 =?utf-8?B?OEZjc3N6V1BWVlRyTStPc05ZQWNzOGRaaWZpU0xYSDJuR0RISGhxYXRHVVBW?=
 =?utf-8?B?ODAxeFdGblJLRlkvSEd6YzNrajF5RGVyNGlXT1hKa2F2UTNvQThsQW5IUW5C?=
 =?utf-8?B?OUpjMjJVOS9uTDlkbDJScnZ6cUsrMW9Mb3VzSUZaZVgxaWc4VmJVdXZ1cEcv?=
 =?utf-8?B?TXhUQlZEbmlPZVFvZDIxV3NBUHJHMDAvYjhxQVRWcVNEL2NaQzRVYUZRQ2la?=
 =?utf-8?B?bzNpUTJCZlJHMnA1TWE3eUNIVmJRVmZONDFYdzdveDh4OTV5WkdCTHRIT2hw?=
 =?utf-8?B?QVdra0NocGdlTmtkaWxBK0kvc3hGc2VDQlk2bnFWdmIwY3dHckN3d25RMUZa?=
 =?utf-8?B?dUROZkNwZHM2YTd1NlZQV3lmUFp5dXlrU2E5V1RSSzVpQ0U4Vnc0ZGd3MUZW?=
 =?utf-8?B?K0NYQU0zN0tVUFkrYVhPNzRXdDVLVzVHRGJUWmQ3OWpldDNka1RQeEc1Z0Vy?=
 =?utf-8?B?WFdVT21ZSEtTSnhyQVYrR0FrRFFINVpGaytxMm1mMzk3ZEpYZnZNLzd6dHlN?=
 =?utf-8?B?dDFHek83TTZ5dUVvWjlVRHYyY0pQM2hkOWIzTWN1RndEMU1SSXNRSlIvVUlu?=
 =?utf-8?B?ekNLbFlJUXFTcWU2L2lMdGF0eEJIL0VHYmplOHU0L2xyazIzbXJYWXl1UXN0?=
 =?utf-8?B?eG16QmQ5Y29RS1RGOHFsUEpFK0xOclc4S0hjdVRTcm0yaTRXSlkxNHArUXZi?=
 =?utf-8?B?VmF6bmxiOHdUUTVXTEdBT0hMVEFRcHcxbFhCdnMweFpTci9vQ3lhdlBtRnpO?=
 =?utf-8?B?OHVuMkNuTUdNSTBxUUhzMnptNjdZR1JsMCs0WEpIZW9FUGxVWFRNc0FmbjlC?=
 =?utf-8?B?aWRxbUQxa0s3UFlsc1RTUERTMDJZZThJY3pBbXJFYk5FT1hERG9iampRbjk0?=
 =?utf-8?B?NDZ1ZE11WmI4eEphVTdVTCtpenlvOWphaWdkUTk2aTYwbHpDTWdINVNDY1pS?=
 =?utf-8?B?TGViZHNtOXRRZk83NDExd2pXOGxOL2FZbTM2ZTcyRHBnNFcxejVsR09BSmtq?=
 =?utf-8?B?M1hLaGNXU1R0eGNTOGM4WExDTm5JRC9wRUNTdTRtUDBXaElOd0xHVVVMVkNl?=
 =?utf-8?B?dzhTcWozSEN0UllJWCtRZzk5RHg4NDQwcFk4WENYMGNueHNWcG1uSVpLdUJI?=
 =?utf-8?B?WWJoaEFURlhhZStPUnBidzJ3V1ZkZXpDUFVxY3FLcFRicDE3RE81Z0dUdTF3?=
 =?utf-8?B?SVkvdG9Ma3Q0UnBHK000SGpVU3kxL2IzVFYwRWJpMkRBVUt2eFIrSlJ6Ym1v?=
 =?utf-8?B?ZlZGOHg1b0dlaUx3NG1iUHdmVzV6ZjMwaVMrWlhZSENFZ0JLVVlMVkhQa2tk?=
 =?utf-8?B?bGlZY2ZSekZBRUxHU2MxOE5Eb0dnMFg3alYwaEZtZGRkc2ZOTmhhQXNyRWtC?=
 =?utf-8?B?WkFzY0ZZOFhMNmJ3V2JTOE9CWERzbTBNOVFSaVVyRDFCTW93ZEZ3U0sxUG1x?=
 =?utf-8?B?dFA0K2wzRitxbVJlRXQwc0hEcFUvTWNwbDhaMFdLUHkvdmhuZkRMSmo5TVd5?=
 =?utf-8?B?MDlnb0JNSkRlSmU2ZWptMUpnK3NBNi83SXRCSVY0elhDRCsrWThKWHBMNWhW?=
 =?utf-8?B?T1RGaE81N3FrWkNPQmVpYlJ2YjcxOE5NZjE0VHREM052cnltMnArZGVISDJL?=
 =?utf-8?B?M01zSUIxS1liY05VM2NmTkV2cU94eDNPWlhmbEhWRUZBNTRWSEIyOENocjNz?=
 =?utf-8?Q?95fwtEOlvxszI?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV3PR12MB9095.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NlhCVkdkejBadEFtQkgyb1ZuK3cxQklBdCtyeVVhSDZXMWhyUVh0MGVSc2x5?=
 =?utf-8?B?Q2w0aFpkNFJhLzJoNDBHZGhyc3ZscWtsc3cwMW1CV3dPY3cvOWNZbzlvMnpM?=
 =?utf-8?B?Y2JRV1JPdkYrWGoyb3oxamtPRmkyU1FZMHBvck1UNks0ODdYSHZnVGhFci9z?=
 =?utf-8?B?RXBjQ21FV3AraDZFNmoxTGZqZi9yU0FWeURtMERjS2RFcDE0ci9zd045eE1t?=
 =?utf-8?B?eFBScGd0TVV2NlVTSzFvajE2Um9DZDhKUTZ1a3EwU1k5TWI4b0FqUFVCaUxB?=
 =?utf-8?B?RU1nU3hJVVI0QzI0Y2VyZnpQb2NKV0tHakZXVXkvbjh1Sm5SMURieGJXVDBF?=
 =?utf-8?B?ZkhGdGJpS1ovZFVYVDZMK3JvU240dVB0NmMvVC9QY3g5MHhTUU1vaUdodjAv?=
 =?utf-8?B?QnQxdDFCeWZ6ZkkzN3NDT1hIVkI4S3pBNnE4Q2x1aXpMS2ZHVmRkZkE2VCtu?=
 =?utf-8?B?U1lRSTVQYm53bVJFQ2NabXJNaG0yMzI5RnVOU0VSMmxkRkRUTnc2ZHE5dEp5?=
 =?utf-8?B?UEVRYW5wcGp6c3FGRzdQUXpFejdRSm4xUGFkN1BkOVR0RENkeUlacFlOYm5Z?=
 =?utf-8?B?WllIOWpZS2JFYVBTTWFYTXUvMlF2Nitrd2dOT0VUaEQ3anhsdmNSMU5TMkJj?=
 =?utf-8?B?bGhPU0NKSzBmZ2Z2eStoRUFPUjEwL2ZDM3dPZEVMSzdhR3dveDRLanI2Ui9K?=
 =?utf-8?B?azA3elRGN0M4NUFsYmlxVEJFVEdLSDhXS1RPVCtWRWt6WHQyeGpEUXpyUDdS?=
 =?utf-8?B?VWV2T0FUYmNjQUIyQk9EYVlBdHRsY0ptU0g2KzNnZk9xaE1VSWZrcDJLUDhk?=
 =?utf-8?B?RjJnZDA3ck5uNUVJVFBodUlmbkxRa2QxbzlTeWJzbFUyVEdrL1RoQy8xemFG?=
 =?utf-8?B?bDJJaTQwL3NzWitiWlI0L1RjaTlzUlJhcCtjT3hva2E5cmxYVkc3UTRCNCtE?=
 =?utf-8?B?WWRtSDdSQlpzUGJrckJaRTFCR1lnRVgxWHVocFF3bkk2QmdLMkxUblhaZ1pV?=
 =?utf-8?B?cFF3M21kSi90SGsrZ2FBUGNRTzQySm9JSVdJUisrM2JaaXJiOUhLOEQ0UWNE?=
 =?utf-8?B?UXByMUpGcWdkNlRmSk1VSzVwU0VxaFhDdTVPSFlheGhoU0xkUTVSOVNCVWlO?=
 =?utf-8?B?UVovMm8ybzhWaWo2UTM4THhLcHhsaEdhMUh2NzJCRXV4em1jVVduTThXV2xY?=
 =?utf-8?B?SjdtMDNXa01YaXpFR2hWOHN5VVRIajhSbEZYQU16NEFoazMrMm56cDQ0cndG?=
 =?utf-8?B?VVl2NG9vTHFPbFFISFhMaDNLN3d1L0VocU1sL1NZMml6aFk4NUFnTkwzL3dh?=
 =?utf-8?B?UlRPN1M2d1lMOWNSNDM1LzBZNHpXWjdVc2dudy9nbnlXZDJxZUZuZitpMzZH?=
 =?utf-8?B?MGpLZzF4TWxOMk5FZER4eEdSVE5zZ25DNW8xaEl6aEJReExlM0VyemlVTzVy?=
 =?utf-8?B?akZkNktDenNEVCs1aG53cXRmRTZ1cW1hcVI1Mk1LMDlzT1hjL2hBRXBQNXpY?=
 =?utf-8?B?MHB5Mm90cy94VDFOOU1sYWVOSVAzNFFGT05XMFNTc3h2eFAvclBmL0FDWVVr?=
 =?utf-8?B?NG9HTkRFRURvVGZyaEo1VzNCNklXRkRQSk1YbTFoRS9EaXRCR24wZ0taZ092?=
 =?utf-8?B?UHF4N1AyQVBMTWZVT1hxanpnK3oxV0lPZWVrWEYrVXE2SnBLTWpOd2RWNy9k?=
 =?utf-8?B?MUt5bVlEem9EamUxN1AxWjAzcGtPNiswUFphZm4vcFlhRi92MjJld1hpUDBL?=
 =?utf-8?B?dDBzbU9XTXVxcUt2Mjc3c3JDVmtqWnQ5ZzdZa1NPTHFqT1FBcEpPTG9FeER1?=
 =?utf-8?B?YktxVnhHdmJHOU5yZmp3UFdnUThHbk1xRi9sS3gzZFByVTZ5Q3dmUzcyM1RM?=
 =?utf-8?B?OFdEbVB4U0drQXpXZks1R2lmSFNhTXVNZGJSbmNRMnBIWWRLU0c0TWtXcTZh?=
 =?utf-8?B?RCtDMm92eXljWGVKT0tYQ3VON3gzVStRN1YyVU1HY2lUSk1pWFFKcFlUc3p4?=
 =?utf-8?B?L3c0d0x2K0hrVCtWalJqYkJBMmw1VXhUM1hhWlAra2NLYlc3aDlXQW41ekxJ?=
 =?utf-8?B?MllGRy9DbTVSc2lVOXRpWFFJelRtOVJrYnNPelhYTStOdng3bFJFUVRMV3d2?=
 =?utf-8?Q?TIx3l1pn83HqJs2zvpMYsol8G?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17410b96-1503-487c-5abd-08dd60e790db
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9095.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2025 21:56:24.3297 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D3CE9vjwipl0/quvUxvTW+pLzRyOmiKb9NnQTDAQs+PFrbvNI12AE79TqC1BkM3T6Pz4KvNIwLH/kWE4lVRu9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9205
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



On 07/02/2025 23:38, Jay Cornwall wrote:
> VALU instructions with SGPR source need wait states to avoid hazard
> with SALU using different SGPR.
> 
> v2: Eliminate some hazards to reduce code explosion
> 
> Signed-off-by: Jay Cornwall <jay.cornwall@amd.com>
> Cc: Lancelot Six <lancelot.six@amd.com>

Hi,

That looks good to me, thanks.  Sorry for the long delay to review.

Reviewed-by: Lancelot Six <lancelot.six@amd.com>

Best,
Lancelot.

> ---
>   .../gpu/drm/amd/amdkfd/cwsr_trap_handler.h    | 677 ++++++++++--------
>   .../amd/amdkfd/cwsr_trap_handler_gfx12.asm    |  82 ++-
>   2 files changed, 404 insertions(+), 355 deletions(-
