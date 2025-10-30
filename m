Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B9C8CCF9F1
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Oct 2025 11:13:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D60FD10E8D6;
	Thu, 30 Oct 2025 11:12:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2KrZ8wOH";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013031.outbound.protection.outlook.com
 [40.93.196.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C646510E8D6
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Oct 2025 11:12:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LPDl6LRXMDwfxE9uvFmFD8GeUgTAf83coFFRd7j/055bUtCz9R9/t7MFWPk1Avo79RiJ+CPIDf5cmaEStSoTTsCY3Tcf/fygt+7IeGgf3sPBoSPATQeT6THNsZXUZ/UshBa7AzeDYpKWyZjrNSC+8W7zXmg+YKuf4xAHdOf7xdd1kN2M+eMYol1DXACQkMjkXPjcTwRHG9PWXpX8peZesrwC2l5tGZpTiFzeqIWKlNcbLHxwEMmtc6hiwueZ7J5w8hk/PnCl5tuU1K5LPOzGd53w0UZYw/p6Qw/AxrIcWDwVyJ5IVrEWY8pHKKiK1eBCYQHTzmRuX2fnb+CpOMHCjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wQb+0HS/rtVp1QrRPOevrXjf1zO58PP5idyTR23n/+0=;
 b=nL4Yqrz3F+f98wHGWDLFQxDYzBV8xx1quZ8oPeeIspa6/pOvwADvpbwKbXQCaocaHXQdiAKZrv0a/FABhxqY1DVTa1H0DDEMa145ROPTMOZxkCgTyoeKoFIfP1VlaIjj42EP2VUjap2aShD7lt6CC9ZATT4sg54uBAvTRB40lX6OVy9ekTE61a1EvllTNQl0BBt1b3EOecrctnfU1MvZF8TvUo7qHHXnhC3u8XyY8AHYBIwja7+I0yW23uepxgCy7FzbaJLhrwbAF1MucQFkUtvXDXvqd2nQLzHBBqAQkSCPhjJ3KZfrTuycRQ1bv4IYH0XKJL3JK8vz863MTm71bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wQb+0HS/rtVp1QrRPOevrXjf1zO58PP5idyTR23n/+0=;
 b=2KrZ8wOHtYgk6iwYVXrEMeeFuYB27u414UaaprdPN9akturIg9S/ddSuRBjrioAIT9kLTOmsypaLBL0nVYMY7ZUpYPQZHu6miNmECSon9/C/MTcczkplz40HbJhkCxDcabftN1pXqa3f2J42vaVNtPR2Pn0h1T3nUBA+cafd2og=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS4PR12MB9564.namprd12.prod.outlook.com (2603:10b6:8:27e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.14; Thu, 30 Oct
 2025 11:12:54 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.9275.013; Thu, 30 Oct 2025
 11:12:54 +0000
Message-ID: <3c44c0eb-b60d-44af-987d-c29edd3991b7@amd.com>
Date: Thu, 30 Oct 2025 12:12:50 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/14] drm/amdgpu/vce1: Implement VCE1 IP block
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 Alexandre Demers <alexandre.f.demers@gmail.com>,
 Rodrigo Siqueira <siqueira@igalia.com>
References: <20251028220628.8371-1-timur.kristof@gmail.com>
 <20251028220628.8371-11-timur.kristof@gmail.com>
 <9da7f3f0-58d8-4a7d-bbf9-1223e458e710@amd.com>
 <18151c2a64164be39f257a407752a5f5dab1eb82.camel@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <18151c2a64164be39f257a407752a5f5dab1eb82.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4P288CA0055.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d2::12) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS4PR12MB9564:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f1c47f8-ab39-4674-34ad-08de17a545a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?K0NDb29wQjl6MkcrQmNSWk1lTm84Tnc3ZWtxUG5VeFJ0TjF6bjR3UjByV0N2?=
 =?utf-8?B?a2h5bW9NSEJPWDVMZGVhU2w1eE9nTzdRTWhoSFJHV29Ka1UzUXBzbC83djAz?=
 =?utf-8?B?d1lYOGFhc3VyM0lDSHlPSCtZRWk3ZFVLakw1NXJyU0l5Y2FQVFpyT1dBWmdr?=
 =?utf-8?B?dklxeldzVDlBSzdMVkdmY0IvTW9DUUhLNERVOWlwNzI5TUJNZ0hMcitZb1Ji?=
 =?utf-8?B?dm5sMEJ5TVh5aXBIVDQ5VlROS3VTYUh6cnJhMXJEUG5JSm1GdXBoV3ptUm9n?=
 =?utf-8?B?ZURuWEtxY3N6aHU4NkpDY0ZLSWZuRWhBSWo4Z2xNRTFwRUJnV1haVTltRzlr?=
 =?utf-8?B?alZCVGlEdStlNHZDZFh6M1puVXVVd0M5V0w1b1M2ckJ0TE9IaS9CSUkxQkx0?=
 =?utf-8?B?U2RTaTdxZEd4MjRQNU1UWVY2a1p4bVBJNmk1VFN0eDJEZ0Nxa1BmbTdTVUVB?=
 =?utf-8?B?QmxmVExWYnRBb2tSWjdxcGZ0WUdubkR4cXhLUFpGSWthbXhZM0tIblV2ajNa?=
 =?utf-8?B?RHA0cWxRVVpoc1FiOVU3cy93SU5wQmdXa25mK3RmdlQ4TW1LSENXMXdMWTlY?=
 =?utf-8?B?MGs2Wkl6VjNneTNpT1E0Mk5uTTRWNFpkYjVJUWZLY3dDRHJEMW1ReXVUb2hM?=
 =?utf-8?B?RDZLdDUzZTlwWTh0S1Q3bElVVFlWaHRjZjc5TjFVNm16b0RleTdiVWFrdGhl?=
 =?utf-8?B?WmdKRjFJRnRGOHdGTU1IbjVSNkloOTNuSXBHZ2s2VWsvSThnVFFHOVBhTHVk?=
 =?utf-8?B?MSs4U3ZXWmhwV2VuTHhRQUdUMUxrWTFBQTFsVGlhTkhqR21UZ3AxMklqZWhx?=
 =?utf-8?B?TVhqdGRSUGsvQXdsa1g1NlZBUWdYaFhkWVJDalE0Y05CVm53WjJwSVlybmxP?=
 =?utf-8?B?dkhIOFFYaWEycEQ0dCtvOG55KzByS2R4cnNKRzFLK1JGZGo4b1p5NzNRcm0z?=
 =?utf-8?B?b0dEc25teWpYYjZZRks4Q0I0OHl2UG9tOUFqMXk1K1cxUjhEQXBtM1k1bW9U?=
 =?utf-8?B?b0FBQmtseW9pQnc4NkZtb3NkWHRQdXpsY3FsYmhFT0oyS0t6cDJIUmswdmFm?=
 =?utf-8?B?OGU2aHFQNmIva1JrOWw2VXYwcDhodHNRZHNuZVlmL1JmZ0dKOUpYWmRSL3FC?=
 =?utf-8?B?KzBrUzZJbk9oVlZ0MFdmM2xhenFreEdIRTY3TTVlZHVOWWh6Sk0xd2w4ZmJl?=
 =?utf-8?B?SGs3SkpXdGYvQnExY2lGVWVZNzdqVzZmOUp0ckc1TUIxWStlZEJhSG0zcGM1?=
 =?utf-8?B?Z21vU1hYNUpxYkQyU3U5eHhPY1lYUW5iRG9GNi9mbGpSNW5GTWMzQjBuMXdo?=
 =?utf-8?B?MTAzeHArWEZVU2VaN3RLWTVYK0crNXE0UHZVeThuM3k0bk84MUZGVXhvMHRC?=
 =?utf-8?B?SnUyM2FJTXdvV1NzT2Zna1ZrR3pNWjdVaTMxM2ZtNW5pMHplUExkemh2ZkhR?=
 =?utf-8?B?aHluZDZMUitzb2FoNlcvK3B6anNYVzRoLzE5TVBpYkY1WFpEMUJBSHMvaEw4?=
 =?utf-8?B?Z0tibjhST0VzN05aOUZlOXJ1SDgxcWZhTzZrVGJtSVkwRDcxcFNSNFJwSE5y?=
 =?utf-8?B?T1ZEUFltK05SM1lPNU5yRmlaek5NL3E3VTlRZWMxS0QwVk9SMXBZMUJROGV1?=
 =?utf-8?B?SmlVNFZETytocEVZbVNRMER6SDZVcWMwMi94VytYdjM0bit4SGZzSHg5S01L?=
 =?utf-8?B?TW5HSnVQc1lYTmlYLzRmT0UvTGhnejdiYWhzOXcxV3lySHBKZnhkUzJrbVZS?=
 =?utf-8?B?c3NCTTVmR2pnNDdzYkxmVDNlaUJEWlFhbk9QeS9NU2kzUFpxL2ZaRmphL2NE?=
 =?utf-8?B?QVd1N1JHT3d1d1ZmYmwvdURUY09wTDQ5U1JDMDBqNUlicTQySWpybXIzTmtK?=
 =?utf-8?B?MFJxSFVxSUdXU2ZSU2VtTEQ0NzRDZGJ1anZOUjNZS3Z2VVpjNTFBZjJTOVhu?=
 =?utf-8?Q?BrZSYxBem5Qc6umoCArXS3I6hUuuQdjr?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OWR2Vkpua2x0M0NrbGVsYmJFVWN3UkdOVk45aXlFY3NUQkRPLzV4VHkyVFJx?=
 =?utf-8?B?M1F5cy84endUZEJxL01oMEJtMytxMnA1THJ5THp6OTVwVEEycElGalhHU1dH?=
 =?utf-8?B?OStPVGIybFZiMEl1UjZIKzNYbnJkSHdTN0NJdEZCMTF4aStVaXkvYndTaEZw?=
 =?utf-8?B?QXVlR09UUkRSV3liM2ZRVnArTmlaZWdzWEVLeTczTVVyaUREOCtuTWdPN2lt?=
 =?utf-8?B?UHg3QWovYlRpTEZ2WWlLOW9mbElUOThEeFlJeTBodVNYSVFtMm5kMzNpTkg4?=
 =?utf-8?B?YjJtNXZ4Zkx1alk4VUdVa1IwK0gzd1k4dUo0c0RpcVF5R0ZFWFVmcHJ2MWsx?=
 =?utf-8?B?Um9jN2dqNEQybnVtTXJ0U3lUanNmMUxTcVpqaDdLcHJHMTRhQzMwOGpxSGpz?=
 =?utf-8?B?TngzaWQvWGxZWUg0b1VKWmhtOS90U2N0Q2tBVDBzS3VteE9OUFVIbENzMXZk?=
 =?utf-8?B?S3BLME9id1RsQy9DUy9Ya2FuRzAzWWZLK0Q2RzROYndJclB6R1JpRHJrTjdu?=
 =?utf-8?B?dGE4dm51YXJYSm5CRERNa3AwSkN2Y3ZkTHBXdS9qQ0NIRU1xT1hISzRRelYz?=
 =?utf-8?B?YjlROUxUYzh0Tnkwa3pGL2Vldk9YcW04eU1hdVRzL1QrQ0VXQ3FkRkV0WTFL?=
 =?utf-8?B?NmFBQmlNaC8rMEZ2S2N6ZTZrdFM4ajVXRmo4Mkd2RnZPUlVjVi83Slo5MmtT?=
 =?utf-8?B?Rmt0Mng5cENwQ3dyVUdFejVYVzRpTWNldTdTejkrOVNYNll2NEN0bnp1MFdx?=
 =?utf-8?B?b2p4bFNUTmVpUzE2U2ZRbUxzVkZOaTlEVVAzOFJMcnI1YWNHUnQ0UEJDbEJF?=
 =?utf-8?B?S2lsWmx1VUhVTGpMTmM1RWtodGJ5YmV3RXFWb3JjN1g2eHExQ3ZmQUZxZ0dW?=
 =?utf-8?B?djJIZVhQSE13VWNRamU1N3d5MGhVZE1EZDg3MXZIejZDK1U2WXdLS2w2dU4w?=
 =?utf-8?B?b1JjR0JwWFRHbTVWKytjS1JvOThHSEpRWkRpOHVMQnB1MXZvQTcyVG1oVzBZ?=
 =?utf-8?B?YkI0T0JYZk9vNmhVbzdrRzhWcmNJaURzMDVRWDR4UjVXWmI0NktPcFdJd0F2?=
 =?utf-8?B?Q2g5ZmxvZ3lkQjQ3SHhkVVJCRDRjM3JEeVY0bEdCV1hXU09BSUhZM3J1QXhr?=
 =?utf-8?B?SjdHbmloUWJja2ZhbEMwdGRPVVB1NTBKUFozbWJWNFF5MmxJNHBiWUliL2VU?=
 =?utf-8?B?SFlvc1BETEhKSEtjS3F1cjlDclkxOWVQOGw5UXk5MHdDemc1S2RYcFVHYjRI?=
 =?utf-8?B?WVBUd3JETUtZYytac0VwbldVL250WGxwNi9SVG5yMThFbnQxdlNRT0loUUcx?=
 =?utf-8?B?c1E4eXNramh1RHpJbUo4bDYwV0lBVTFpRlNKN2lUanZ3UGJRZDFUNStDNWdl?=
 =?utf-8?B?YTZuMkdrZFdvdldqa1NjdENKSTlxaFZDVkQvajF0SGRGcjhCWjJJanl1Rjdn?=
 =?utf-8?B?dE5UWmdlSjVoZjFTa2s0VTlld1dpdUZUbkIxNm9BTDRlU0tDaTNKVmpWN0pr?=
 =?utf-8?B?MVdpM29MMVdaQ3ZLQy9ZNWtlV2JBK2dzS1lYQWxBOGlHK2F0WWFBa2d2bU1i?=
 =?utf-8?B?MVRyY2lKZCtBQmVodXVDWHpsaGNtdDQydFc5eTJnb1hKTUJVbi9nSHFweXR4?=
 =?utf-8?B?M0RkZXFVTWg2bnBXM2VNS0VxRTNHSmwxQzFxU0NEQTFyTm9FeklwY3lKMGlZ?=
 =?utf-8?B?RXBiTUw2Z1dzOEFFelBXRURVTW10aStScFVWWnc2K0JOd0l1U005cHlFamFu?=
 =?utf-8?B?SkhiaTRockZubVlZbUJqS2NVajZoVnhXMHV4a0YrNWFnNHQ5NjB4eFZhT2NB?=
 =?utf-8?B?WEVuQUduZk5qZmRCalgvMTNLZVJnNEh2SXMxRUhCYjZKKzlrM2VQQ2J4ck5a?=
 =?utf-8?B?UVliU0dlcVdzUjJQczRUSTVJaUlCZytFL2hOYVQrdVZGcEhWVTlmZWhKZGlH?=
 =?utf-8?B?UjByRi83aXg3dFVsMHg2aE1sYjU0ejR0UFByTzJ5eHNvTVVsU1NkWk1CdE9R?=
 =?utf-8?B?N3NqT29lUDRucC9UR2t1UzZYcnpyNnR6ZzFJM0x2UndWZU93cHJ5M0lodjNP?=
 =?utf-8?B?U1gxclpKQzBHNkVjOUR4djF0eW5oaGxVT21IallLYlNPVDdqNE5PeFU2OUth?=
 =?utf-8?Q?jtduFUwy0tGPchTAI6bt5ZDoJ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f1c47f8-ab39-4674-34ad-08de17a545a5
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2025 11:12:54.0848 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZoZMAzmKPXXFyy/8MQl5Lj6vdK092ScVvHrSi8LlA56lTuhjId6bnJRMpwSVac4x
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9564
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

On 10/29/25 23:48, Timur Kristóf wrote:
>>> +	ASSERT(adev->vce.vcpu_bo);
>>
>> Please drop that.
> 
> Sure, but can you say why?

ASSERT either uses BUG_ON() or WARN_ON().

BUG_ON() will crash the kernel immediately and WARN_ON will warn, continue and then crash.

The justification for a BUG_ON() is to prevent further data corruption and that is not the case here.

What you can do is to use something like "if (WARN_ON(...)) return -EINVAL;".

>>
>>> +
>>> +	r = amdgpu_bo_reserve(adev->vce.vcpu_bo, false);
>>> +	if (r) {
>>> +		dev_err(adev->dev, "%s (%d) failed to reserve VCE
>>> bo\n", __func__, r);
>>> +		return r;
>>> +	}
>>> +
>>> +	r = amdgpu_bo_kmap(adev->vce.vcpu_bo, (void **)&cpu_addr);
>>> +	if (r) {
>>> +		amdgpu_bo_unreserve(adev->vce.vcpu_bo);
>>> +		dev_err(adev->dev, "%s (%d) VCE map failed\n",
>>> __func__, r);
>>> +		return r;
>>> +	}
>>
>> That part is actually pretty pointless the cpu addr is already
>> available as adev->vce.cpu_addr.
> 
> I don't think so. amdgpu_vce_resume actually unmaps and unreserves the
> VCE BO, so I think we need to map and reserve it again if we want to
> access it again. Am I misunderstanding something?

Yeah, I see. But that is a totally pointless leftover from radeon as well which we should probably be removed.

The VCE BO needs to stay at the same location before and after resume since the FW code is not relocateable once started.

So we need to keep it pinned all the time and so can keep it CPU mapped all the time as well.

Regards,
Christian.
