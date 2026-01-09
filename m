Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1847D1A623
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Jan 2026 13:45:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 77BAD10E8D6;
	Fri,  9 Jan 2026 13:45:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="d2RCeLI4";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010070.outbound.protection.outlook.com [52.101.201.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7CEFF10E8D2
 for <amd-gfx@lists.freedesktop.org>; Fri,  9 Jan 2026 13:45:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Sficai5Rj3H7uu9xQLzxzPCyw7tDDrRGQKK6SDepXUUxlBnl+fY5stt1C+MUdC/a+BLUSVdfzPOX/F+GGJIZLx/ceUe/OHWdgGGU+t8ngovqFVpTqnJyNxnMzJSRHebDHoT28Jibg9atpENp3HmtF2EvxnIM2roVD3IJJVhU9Fs2hLNpNMIJcBTsl35f9fkVwp3qICgt+ZSJa4BGxKVtAMBYddq18g08lcF/ff6ebcu0590rlowF62vEAk7xGwsSTpQem55v55rDlqGUZUYvWfwzCc2h5QGFo6fFabdyYT4lcIpRwoVm79UxoM5CK4sLiUe8KRXzwkIsreqjWbL5IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jwKrPLq9clrfKI3WaWctIbXPr5IpaLZnCcYgwtP4LB0=;
 b=ak13voh3JVfBDLX8XboBdSLKqgDadS33IcN/qb+nPkOal2qCBSVvann72b6JW/CjVNhyKrr7r4+ysO2LsgqFMakFdNMmF3yTHDZtE0VRMczhxpOY0g3YLx66rCFo3afowibPt9vS+QrsBIPmpge2B6Dmz1UPgu1frIdcUeBl1ihrdqGWHjpdmjZ3HTlIshRHW0hNBb2aoytLwo9dAgtzLNjGDIQL+wcFOslv44w0AOlAH2LCfyM+OoBn47WmpQTXnaCvnSz6dwHdn4kZ75iHYUMUjiBXjcATITRNrxk4LC7J/UyX39rWXWkHmt6Chs5MwJXf+S6QI3LUYF6YNWwpng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jwKrPLq9clrfKI3WaWctIbXPr5IpaLZnCcYgwtP4LB0=;
 b=d2RCeLI4pMFWEe2lgOLVvcW8QPzroijjIgWWciLNcpbg8kkJWp4L1Yc76J2iAm4XyWJFnGhAroNgCh3ATGYiOxhMVFIvMpVOtsJAPkUkyKcMdv0S1Lw+W1vevgmxzRdJXOxj8NKfFmcqWvQkwquLpVDCP9yGasE7XUg8xwaJf3I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SJ0PR12MB6781.namprd12.prod.outlook.com (2603:10b6:a03:44b::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Fri, 9 Jan
 2026 13:45:46 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.9499.003; Fri, 9 Jan 2026
 13:45:46 +0000
Message-ID: <03bd0339-330b-490d-9716-b5d923230b0a@amd.com>
Date: Fri, 9 Jan 2026 14:45:42 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 03/12] drm/amdgpu: Drop support for variable struct
 drm_amdgpu_bo_list_entry size
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Alex Deucher <alexander.deucher@amd.com>
References: <20260109133314.88548-1-tvrtko.ursulin@igalia.com>
 <20260109133314.88548-4-tvrtko.ursulin@igalia.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260109133314.88548-4-tvrtko.ursulin@igalia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN0PR08CA0017.namprd08.prod.outlook.com
 (2603:10b6:408:142::24) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SJ0PR12MB6781:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f15e91a-f29f-49f9-6eac-08de4f856400
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?d2VMK1FDMS94VEtOK1piS1J2Rm84NVZJek1KNDd4cnFUR0xRaW8vZzJPL1dj?=
 =?utf-8?B?a3FJeWNVNUNpYmFUVlBXOE9xWGorL3RJR0JjWEd1Z1UxYUMrRVhYVkJBWC9u?=
 =?utf-8?B?OWppc3RKclFRYWVsYnB4NlBDV2pQQmEzUWhnd2ZKS3ZhWUIyWW1qN3Vra0M4?=
 =?utf-8?B?Wm1NLzVsb21LekN5eitrd0VFbzlSaVFpT3ZOOXM0ZGUxdWloc0dkeVdnTGQy?=
 =?utf-8?B?SnNzUnRLOUFyMWMzcE5ZNnJjbEtsVGd4clI1OEpiS2U2ODRzS2k5WVdYMHZw?=
 =?utf-8?B?aXU0czBJaDVLMnhaUy9XZStjRm0xQlJpc1BGYTB2ZWxNcjVzVVJTUzJ6N2ox?=
 =?utf-8?B?cjdRaUZ4L3gzaGxycWFUYlJGcGRKMjBCbHY1Y1czblB5YVJ1ZVFtOWFDK0J2?=
 =?utf-8?B?TUExVFNFSzQ1M3kyU2xTMnBPZUowNkRLOW51VHMwNHRHbDQ5VXB1a3h1N3k1?=
 =?utf-8?B?T0MrRThxTkhaK0VRUmIzcnArQTlPdlo4UjJKVTRrS1VIdkJPZ0hZZmhIOEdw?=
 =?utf-8?B?d21EODVCMzJ0ck9lZ205alFoSTNybW1TOTh0TnloeVJQVUNrang1aXpyQlZI?=
 =?utf-8?B?Rm1IR2tMUnI3akRZRTRUeVFvYm91c3lqNXRwZlMxc0RPU2hCci9PUGo0R0o1?=
 =?utf-8?B?Q25KZDBYd29OTEM4cDhvVFlwMitTdnFtVld5dXVrajZabVpqZWlwMEVyTnBL?=
 =?utf-8?B?RWtqSzFrdnFRSUhEVnpLZCtxbm9peE1MR1VUV0JIUVBCMFlhYlFTU1R1YWRJ?=
 =?utf-8?B?WUV3c3hieXNBZUFNd0NESW1ZbGtGdndwNC9OZE9aQllHWmxTKzdRSVI3OE5R?=
 =?utf-8?B?Rk1Edm0xSUhvL3E0U3FjcnRIVEwyU1VZM2hUQUlJY2JrZnNSem9xREwrR25B?=
 =?utf-8?B?TTN2cGdzWjFwMG1LODY3YUlQcU1zanZ5Um5zaTJOay9iU2FETkExbWN3WUQw?=
 =?utf-8?B?VHd6UDd3NkRueVREbVUrZ1AvOFlTZGZ2ciswNmpQOSs3ZWhFd0Z3SGNUb25s?=
 =?utf-8?B?dlViUlZaRzJVWGlJYWcxT0NZU2RraUtrR1U4QVBvaE9UU1NTU1o4VzdjaFph?=
 =?utf-8?B?T1lRN1ZRcS94blJKOGZsczZWYkNNU2RFenRWRlk1d2tINDUxdGNVTzJVQ092?=
 =?utf-8?B?QVJwZUtXb0JkRjZCVmpHOUF5UVA2UDBESXZOUXlPZWNaWUdqOW1QdmVYamtW?=
 =?utf-8?B?Z1BQYVcvanptYTk4c280RGxBNkJDaGJTczB5NHhUMFREelpuam5yaHV0UEhY?=
 =?utf-8?B?cFo2OGVhR1hLMXRJRkI0VGdyc0ZZVWRheG1uYnkyTEVXK2FrR1JxS2JNOWJI?=
 =?utf-8?B?cWRLYnpTN3ZCTDdkdW90dmFObzVQYXFBY1E5dXA1bkdwQUpEUStPMG1GeDlR?=
 =?utf-8?B?OWdocDBZSGE5T2lUQjF5SjcwOVN0Y09xeHZpZ3J5eHJ2YmJyeUZBNS9pVngr?=
 =?utf-8?B?QXVIS0M4aGkweDR0ZlJMdWV2M08rSDcyS0x5NDYxTnQ1L2oxYjdyZ2tOUi9y?=
 =?utf-8?B?ZkNTaTJ6UEMvcVczODc1SFMrWnFMT0h1M2ZsUG0rY0M1dk5sUUtTSkM3V3E0?=
 =?utf-8?B?a3M0UjdMZWlXc2pFSyt6RkE2VlhoK3BuMm5hQmpUbzFQZHRBanRJNGdyRTZO?=
 =?utf-8?B?TFJxbnVEN1MvekVxRU0vT3hrM01iKzlvMFJqTFhuc25MV1VlMHFkcW5IUENl?=
 =?utf-8?B?UWVYcy94ektaRTRqWkJiOHoraU1ZWWdsQm5ZVmFCSWp3T1A2SXdsVWRJTFFa?=
 =?utf-8?B?dCtCdW9pTjVDWTJSY3RlaWVmQUxmU0owdlhwUTdEOEJlRi9HTDBDMncxeGpv?=
 =?utf-8?B?TWZKUDRZZUJBTXBJZ1pIM0h4WmpzZ200ZTl3ckVCd1ZYUkJVRUJpR1owMWVO?=
 =?utf-8?B?aDgwYlk2RXh6dHd5Tk1keW9JeTNsK2podHNPNjhsaWpxaEpRSmpHOUNQNzJZ?=
 =?utf-8?Q?nHR/qOkkIPyEbCWbqQD/QNtqHXp0mUKZ?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V3Z6RTgyc3Z1OTZ3MzNFejVwS2UvZDhsTnhreTQyUnY3SUZSajNMVm54Nkk2?=
 =?utf-8?B?cFZMTUlmMDNDNk5QQzdPamFseHN3djgyaVlFbGZTb1ArQ2diMkVYYUlnYy96?=
 =?utf-8?B?NDdQR0lhQVdSZkFQdG1lLy9ZQkQzRTlQVWlzd2lQVDhSc3NVV2J5TGhzM05I?=
 =?utf-8?B?aFFZeXh0SndnMXdGL0dySEdCRStzYnh0Z0tuaU14ZEtRaG5GeVE1Z3Mwbjkv?=
 =?utf-8?B?V1NHMFJuVndqRFBMZFVRYnFObUgyejBpcVRiakdIS1VuSnUzNEZ0TnFiRVBj?=
 =?utf-8?B?cFFVeU1aaVZKZnVObTc4U2pSRFlIcXNNYlJzSzIxOUtXVXB0T3VLT3YxRUhW?=
 =?utf-8?B?eHBGNWFJekJqa1FKbWxweVJpcjBXaU5TYXovekNDUFNNQWV6bzJEbk9wdG1a?=
 =?utf-8?B?dFZJWjVtWFo3UzZreVY1TUpEVXpFUWI0RkxaZEZRR1Y5L1lta3E4THltSU5p?=
 =?utf-8?B?QkxiL2JmZGwveStIaWo0KzJGeXkrSUxlQWdhNFMzbGlCdnFsVXFlRnlXSGZQ?=
 =?utf-8?B?MUxvRzFjSC8xQlo3ZjJMU21tSEpPRDBaeXJGb2lWTi9ZVFJDU1V1WVNwenRC?=
 =?utf-8?B?Y2JqOFU0SFY3dkVEM2xKUEZ1NDJ5cExkQXhPbkszS1ovZGdEb244a2FPYlFF?=
 =?utf-8?B?MHhiT3luY083cWJWZ3pBWCttVFhySDhodzdwM0lpMU1SZzN6TEJJV2VpQWE2?=
 =?utf-8?B?VFZySW1iZnYwcjBseDJDSWhjNUoxQXlXZ0VmZ1Rzcm5Ia0Z5UkFaZm8rQllS?=
 =?utf-8?B?WWFySGVHVkUwV05XcUVoSEk1TlNPQm14NFJHc1hINHFIb1EyZjFIOWl1MHhn?=
 =?utf-8?B?OXltM1Vldm10MlpUeFBIc2tGQTJTWHpOc1lKZ3lRVXFDVWE2ck41bnROTWcw?=
 =?utf-8?B?YkMvNnFyYkljY0ZUWXdGSUFDMVMvbkpsNzRYckp5SjVmUTR5dGFzaFEyRDhO?=
 =?utf-8?B?ZzMzSzY2VTg5WnFIbzFzZkd6YVZ6VlE4bC9iTzhIelZ3bHp2WXIyTy9qWTdD?=
 =?utf-8?B?VENpR20xUGhCZzdkRVZpQmhNMWJRK3pKWXpBVU9vZ05Md3RmNWk0Q29IeGNZ?=
 =?utf-8?B?eDBVY2VpM0N6Q0JyVjRqbmF1OWdoT0FzSkRScEdZalR5L0tBb0tVK3lIN29E?=
 =?utf-8?B?YXlhK2pBc3JDU0hmLzBoUTV2Ni9rMkRCMzJ6SmVtWU16SDFucnJRNnkzWUY2?=
 =?utf-8?B?YUszYUtTblY3d1YyclI1Rms0MHpjQTZjNnpLNFF3aitSb1FKaUM3djM1cDR2?=
 =?utf-8?B?clZuNVdVaGgxaUhDWGhxbXF0RkszU3ZLTCtMdURITXJaTmxSRkRHMHQ1ZGRH?=
 =?utf-8?B?V1FqR3A3Q2I5SVp1NVBRTFZHd01weUZ4aEhSVGk4VkZHQ0JOR084UGhabFBo?=
 =?utf-8?B?ZjMrbC9XQytreEx0MDlrUWphbjFXTWRxV3doTmRVeHFKTUg5Mjh2dmpHcXpX?=
 =?utf-8?B?ZFdQNE5Vb0MwVDFYMElRdUFnQmN1azNkSTZnaElQa21ZWmZBOGhnZWh1eFBT?=
 =?utf-8?B?N2l2QTR4L2VpVW9haSttZ1IvN0xFczNuZFZKZTlyN3lIK1k1eEhNbmRLN1Bi?=
 =?utf-8?B?aVZQZ05JaDZjaVhmbUNoUmdLZitTK2hqZG5YV0l5d2RNMUt0eUpFQkpkYkJu?=
 =?utf-8?B?a0RZVk1qbG5oKzNuVlVJL2NBaWNTeTZDTmhINXR2L3pJRXU2VmlORldsRWVX?=
 =?utf-8?B?bTJLUTRyaHI4R3JVVkl4bmxzb3FDZnM3ZFFsS0dldFBXTTNsc0o5TzZsSnMr?=
 =?utf-8?B?K2JJTVIxL3pHc0ZzLzN4MnJ6RHVGNlNhVmJTaHdkb2pvWHpOYXREd1YzTUFu?=
 =?utf-8?B?Y25zNzF1dmhQdGc1ZE1zemRsRm1wczg2Ny81c2JTU0hHVmhKY0VLb1kwSWpi?=
 =?utf-8?B?Ykc4TlhMVjYvdHQ1N01pWEIrZ3RieXhvNCtYR1VTclRzK2Y2STZzdFhKQzRY?=
 =?utf-8?B?ZGN3cWJ1SEhkS1c1NEh2Z3FhSW1wY3FJVGp6NWJmN1lZVUZvS2tudXVnNG1W?=
 =?utf-8?B?SlczWFM3b0lDTTU0c2dkTUNlemM2MUFpVlBzc2tsTlhsWkJQQzVwMEdDMWhh?=
 =?utf-8?B?OFhrbHdXVXVGWWx5d0FTVlNrci9FNHB2S0ZOeEJXVjdkTTJ3b1RMcmY4bVoy?=
 =?utf-8?B?OUx0R1ZHbHpVcWVMaitGb0tEYnNYYmZSZVJoVWsxWHRGeFBFQUxpV3lEdXNk?=
 =?utf-8?B?NUJST0RrTFg4REFtMTRVWFJMTytGdW1WT1FZZ3FOUVJwNjZ6RlpiU1daLzg3?=
 =?utf-8?B?aW05TkdFTlFWZjNMWmYvNjNHcjUzeXlaWWxDRTNZUzJNR2lnVW5Ba3U3MVdM?=
 =?utf-8?Q?FabtzN7DcONgFQXUR7?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f15e91a-f29f-49f9-6eac-08de4f856400
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2026 13:45:46.1883 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jghv5cGMZ1MiDn4Ze3PdcUP/48XcyALqc9jX+zbomwva++HcKE9cuZrI2OXQ5OhV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6781
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

On 1/9/26 14:33, Tvrtko Ursulin wrote:
> Userspace always uses struct drm_amdgpu_bo_list_in->bo_info_size equal to
> sizeof(struct drm_amdgpu_bo_list_entry) and there are no plans to extend
> it.

Rather write something like ..."even if the structure is extended at some point older kernels should note that they don't support additional fields by rejecting the new structure size.".

> 
> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> Suggested-by: Christian König <christian.koenig@amd.com>

With the commit message clarified a bit Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c | 31 +++++----------------
>  1 file changed, 7 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c
> index 87ec46c56a6e..d340a6438aaa 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c
> @@ -182,33 +182,16 @@ void amdgpu_bo_list_put(struct amdgpu_bo_list *list)
>  int amdgpu_bo_create_list_entry_array(struct drm_amdgpu_bo_list_in *in,
>  				      struct drm_amdgpu_bo_list_entry **info_param)
>  {
> -	const uint32_t info_size = sizeof(struct drm_amdgpu_bo_list_entry);
> -	const void __user *uptr = u64_to_user_ptr(in->bo_info_ptr);
> -	const uint32_t bo_info_size = in->bo_info_size;
> -	const uint32_t bo_number = in->bo_number;
>  	struct drm_amdgpu_bo_list_entry *info;
>  
> -	/* copy the handle array from userspace to a kernel buffer */
> -	if (likely(info_size == bo_info_size)) {
> -		info = vmemdup_array_user(uptr, bo_number, info_size);
> -		if (IS_ERR(info))
> -			return PTR_ERR(info);
> -	} else {
> -		const uint32_t bytes = min(bo_info_size, info_size);
> -		unsigned i;
> +	if (in->bo_info_size != sizeof(struct drm_amdgpu_bo_list_entry))
> +		return -EINVAL;
>  
> -		info = kvmalloc_array(bo_number, info_size, GFP_KERNEL);
> -		if (!info)
> -			return -ENOMEM;
> -
> -		memset(info, 0, bo_number * info_size);
> -		for (i = 0; i < bo_number; ++i, uptr += bo_info_size) {
> -			if (copy_from_user(&info[i], uptr, bytes)) {
> -				kvfree(info);
> -				return -EFAULT;
> -			}
> -		}
> -	}
> +	info = vmemdup_array_user(u64_to_user_ptr(in->bo_info_ptr),
> +				  in->bo_number,
> +				  sizeof(struct drm_amdgpu_bo_list_entry));
> +	if (IS_ERR(info))
> +		return PTR_ERR(info);
>  
>  	*info_param = info;
>  	return 0;

