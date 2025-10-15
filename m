Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EFD2CCD18E
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Oct 2025 14:52:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1DD8B10E2B2;
	Wed, 15 Oct 2025 14:52:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ndHZtJQX";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011071.outbound.protection.outlook.com [52.101.52.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3090010E2B2
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Oct 2025 14:52:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DLIcTTm4nzRFZRFzywCDS2BMe6jjzx/VnOEJBWJUrU3aWBqvEpfciN9erZJJh2aqXhchDErt80awVKbhexQQGLLoEl3zmoNuVCLOKgkRbPwQv3EVPJOC0QeeYen99k5kR78aUsZnMPrlJzvDWzPE7Nm+1NNb2v58YkErANy8ePi1b+IfdpQjpAP8IvGQOx5LeCyAsZcbo6osY5x81TGH57lV0l9ZMLvneqUsQRkg2v/dMYvgNXE9BRiSyOTYrdQS3C+hIciTexiRPc8FObERd1hgkc/mrCKCpPdLRpTGRjpctqAWyejwWKg93I4yzAjnnclQmNnpbXog9sua0DDWIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RGb4atuaYtOZ0xpbEy1AECNiiUwps7HGSmooVj5lv70=;
 b=mRFalxUYAYMGoRKv7T9DN9agwJqf746ubs5v17FJaZ+cd614dPcQXDaTazT/MvbzsCWwbE6+aXi2QV01o47iR7UN2VuPpgJB4RzxSuBeadPPpmTvoZvyvyNaR4XNKBGwUnzvWpZ/6gSPDFIcAaLQz9MosX85iQ3fW9DA45dZlrujSgIvMzUJ8xqitfzdgsIt6qymme/+AF1tJn6ZOC+r8spBSkHJr3ABRefNWivNXatlrhhbzcE5m57AGWHVn3uauxzc5KsRPu8ZmIgN3/3KFSG0JGTOlTsLLPhql1mwgUZpr/Or/W+aFxqEQ428dZtmPjeGJsHARD5vWKlzX+ljKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RGb4atuaYtOZ0xpbEy1AECNiiUwps7HGSmooVj5lv70=;
 b=ndHZtJQX05qVTroqkHrVKuQxOhXPSkmwloZudDom+IXMwfTs2Te1cygZDDpKz+eM2MhKLtZGr++0m1RqPGrkJ9wkAG4XRBb+235pLI0lHKwCD6IHeuce8t4pcHh9Ao29JQ3hBgIvk8O2LtksnBDhKlXkGdxhKNOHhBtfVsQvDgE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by MW6PR12MB8997.namprd12.prod.outlook.com (2603:10b6:303:23e::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.11; Wed, 15 Oct
 2025 14:52:08 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%7]) with mapi id 15.20.9228.009; Wed, 15 Oct 2025
 14:52:07 +0000
Message-ID: <f455e878-fcc8-4635-9599-4119cbb6b8ba@amd.com>
Date: Wed, 15 Oct 2025 09:51:57 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] drm/amd/display: Check if display HW is enabled in
 amdgpu_dm_atomic_check()
To: Alex Deucher <alexdeucher@gmail.com>,
 Harry Wentland <harry.wentland@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20251014193036.595453-1-mario.limonciello@amd.com>
 <20251014193036.595453-2-mario.limonciello@amd.com>
 <CADnq5_P-9F0NsOK_5HG06YP98vqJH+1RXxfEnhnAhQ_U1Q=DNQ@mail.gmail.com>
 <d462f951-1b9d-4390-800f-9af09a7282d5@amd.com>
 <a1465fe4-f17b-4a72-935d-df0105a45e6a@amd.com>
 <CADnq5_PuRs-kuP=dnvmazwgZhf0TkvBcvBxjm0iPxn3C=v3q9A@mail.gmail.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <CADnq5_PuRs-kuP=dnvmazwgZhf0TkvBcvBxjm0iPxn3C=v3q9A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DM6PR08CA0039.namprd08.prod.outlook.com
 (2603:10b6:5:1e0::13) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|MW6PR12MB8997:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d72075b-4f16-43f3-cd70-08de0bfa69ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WjhKaUxtUWFqYnd4UFN0dWxOR25ZcGpRR09RTGF4eVRnTlZLU2hiaTJndXR5?=
 =?utf-8?B?akVmL1RFano1aEZVT0hFUWp6cU13bFpLYXBjMDE0TFJNSjd5RXRZM0dXWGNs?=
 =?utf-8?B?MnJMZ1hSQnI5YnJNOFZGdDBHRVFhNlJLNlFRRTQzbjlDSUk4N1dBQTBrMHVl?=
 =?utf-8?B?R2d4aml0MXY2dFltZVphNW80WDhydTdMVG9idWdGSjM3bHM2Wjc0MmE5QmUr?=
 =?utf-8?B?M3hnV3NMaFNGcThXTlZKMWxhajllYURWZ1o1UWt1c1VqbTdMSy9HNGRES0xT?=
 =?utf-8?B?QUlyU053anozSHI4NUZMc201Q2IvRFFDd1JQaWhXMVdUeUpSMWdFaUNFZFZP?=
 =?utf-8?B?bXBLRm9EL3YvaHR3VjJIdlZ5dkNHVGtxMFo3MzZXUFFUdzBtY0FFTS9rbGdQ?=
 =?utf-8?B?b0lWRmkrd2pqUkZuVlltRS9XVUg4UDNBODMwUkozTUh2dGNSZUEzbXZhUzlB?=
 =?utf-8?B?WHdkR3czeVM3aW1mVHFtZk1zL3ptSmxRbzBTN0dYQTJOeGd0WjhycE9RR2t3?=
 =?utf-8?B?dHhVWExTOU96TFdldzEydnhSK1Q2Q0dXK1pmaVArVVc3Nk1Fcjdvd09rQ3Vx?=
 =?utf-8?B?ZURheG1OTXRyTmtaazVIbHFrOWVLR2gyRm1LNHVVZy8wdU81MWZTanUrWjY3?=
 =?utf-8?B?d0w2VS9yYlo0TmMyMTNucUZKaEY5S3Y4Q0xkeWNYNFFkaG05REVIVU9OQkpN?=
 =?utf-8?B?TnVvc3ArZmtxRXBIaUg0RHRZWWlVcUlyZ3dubXFzWFhNYWhpdnFEU3QzMnR6?=
 =?utf-8?B?eEVzUVAvdkJwWjFSZUlPeDZySitKWEZEVStaT3p6UU01V3RaOStEYS95eWwr?=
 =?utf-8?B?OGVvUDRoTlZVU2t3Qitxd3BoMFh2bElrV0J4TXdwUXZ5ZGF5ZExoQnR3YnpW?=
 =?utf-8?B?d25EYmMwVFRaN2tqQzNKOWRnTXA2R0c3K0ZUaFBTdW11b0ZNM0FGeHc1RkN0?=
 =?utf-8?B?WUhLSkhlZ1pVaTRhSTA1YS9zU1Q0MXVFeU1Sc3hmRWNYajI2d3hhVE1hVHk2?=
 =?utf-8?B?SkJiWldRbTQyTXlUUDE2YzZiL3FKRGFHUGJENXZPYXdNTGY3dXlxaW5aNGU4?=
 =?utf-8?B?bmVUajJMOGpVeUJTaGVRSFRoRkNwYVp2Sm5CUmdTQ3hrSEJXZjFhL2FVaTUv?=
 =?utf-8?B?MUdwQm5KWG1tWEk3aWljMEUzTVMzVlpPRXhGcG5XcmRteWhHbDRWOXdlWTAy?=
 =?utf-8?B?M05zZmJnWVlEZEtZK1pwNG1Za0dXMGcxTDVldzlQcVB0ZnQ1QVVpZVdsczVJ?=
 =?utf-8?B?N3BDSUpmem5KOVA5aDJUTTcvV1M4bitkNVJ1NFRhcmNuUXJNWFdyd1E3YXpD?=
 =?utf-8?B?QmdOeTdhaUhEd045ZlZoQytRV21NSlJ3MW94STlneHAxa041YUpSdXcxOWZE?=
 =?utf-8?B?SUF2aGhtemhGZUxUaDFxMTJwUmNGbE9UZVFqQXBESkFyL0QxdUVHOVY0WnEy?=
 =?utf-8?B?SWN5b29FYkxqcnpxYjgzbHcwMUZ5Lzh4THlUOGxuU084eDJaaC9IdHVrNWFu?=
 =?utf-8?B?Mlo4b281L0t1M29pQkVpMnd2aEp3UTNGMzRqenZKaGpIZTZHTDZMTkJZRDY4?=
 =?utf-8?B?MWpBOU9zemZTK2FXZUxwK3d2OGh3dnRGK0MxUjhndGFkcmZzSkF0MVZ4N3BC?=
 =?utf-8?B?SDF2VjZSMU56eWwvdG5OeTVqTjRMK2VHMUhxejVPQ2ZkeUhKekNNQlVxaG85?=
 =?utf-8?B?TnU4ZS9aT2Q1T2tMOXBHMytvdi8yUVJRS0VNZGc2dmNxZkpLRFIzU0lqMmIx?=
 =?utf-8?B?QU11dkVEZ3hvZWk2RnpmWUN0UE44cFA5eldoTmlKeTNFVHAyVy9KTVk5WEdL?=
 =?utf-8?B?OHhqcVoxSXR4cDZ1cXdENUN0Sm5ORStSZFcwZi82TCtnMDVrUkNXL1dUd3N1?=
 =?utf-8?B?eERuVjhxVUN6V0R0SnNmNUptV2xiSkQrdCtPOUJGT09wYUE9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SDlNTFd2M3RNdFcvZEJOQVJMN1UrME5iSmN1WGR5VS9PQkJxT2hScmxJYmk2?=
 =?utf-8?B?SGx3Ymh6cFpVUkhSeklYMXYzeHVnNGtFYkJSMGxOT1NDT3lIZC9hMnI1Y3Vu?=
 =?utf-8?B?M2VNL1Yvd0ZCS01hb0RDY3VRQmtpNEpOQ3ZuNXlOV1dGeHFFTlMxdGdXZFlC?=
 =?utf-8?B?bGZQc2lLNmRNNmVxZFVreWZEenJPaDdzb2l6VHgyM1F6bEdNTHgwSUZURVJL?=
 =?utf-8?B?R1h1MFlGRFNZNExEcmhoVDdMSDJUUGhBckZibERMdHpMQTdsRHlMamlEWCtM?=
 =?utf-8?B?UFMzZVNVZDBTQzFvdlpRQVBJL1QwbW0xOFlDcS9mNTkwSDNqbzNwVTdpcTVC?=
 =?utf-8?B?Nk1oVzJTNVdKS2NocExUZkI3c3pKakV6Q0NEeGVRQzgrTEEvSVc4YmlwZkRo?=
 =?utf-8?B?Z2pTZ3R6ZTg1bk44ZkQ3cXRkRnB6em1OWFczKzFwWkpFY05VcjlKNlRMWG9I?=
 =?utf-8?B?VCt3Mnd2S0N6MEs3enIvdzBDSUdPb3FyREFDRXpWRkpqMXliRDJuRlZNM1BN?=
 =?utf-8?B?aGFSa2lyMmE1UnJPUm13T2RJZE9ycFJ2M3pnQzZsZlhmRnk1TzBMT3NLU0Z6?=
 =?utf-8?B?c0N0ZXlJcE5MVUUrS0ZRMGVHZVN3SzIwSjN3Slkrc0kxSjVEZFdiK3d5eVJI?=
 =?utf-8?B?cFE5VFFsNGxkZEhwQVJOVElUSDh3MlJ1QWNxbFFrd2Q3d3d5RHJlTFgyaS8y?=
 =?utf-8?B?UlR3NHg2Vk92L05QUEMrbnhaR1Q5VXUxNFdqcHVyU1FpcWZmNVBDMER3QkxJ?=
 =?utf-8?B?R2Vncm9TcWtoYTRvdXBzb3N4WVY4UkhwbWJlRGRQWDBidDl0UnhQUDBtUG5v?=
 =?utf-8?B?YTY5T2VNOWNYUTF5SGFQSkV1ZkJmVDd1bXBhQzZ2RlVTVVFITnhJdDZPY3RL?=
 =?utf-8?B?RDFJZVNXZjRka2pvcC9GdVNEMjMzbE9PSjdzS1hjNjdDMUxsTFZnM1ExbVdF?=
 =?utf-8?B?UVBqcncwUmN0OXFFTW1OZFFDTDMzQmc3K216eElkb0hEMklzZVoxZEZhRW1p?=
 =?utf-8?B?SWlUK05IUU5qOW8rSmx3UHMzU2J0UE9PaFpONHJJbTh0SUgxUVUwVHp3MlI1?=
 =?utf-8?B?UUdSZTJFYjgxMkkzcU9nWTNlbG9mNXk4WVBRN1l4OG5ldm5hNjRJZUNJR2hW?=
 =?utf-8?B?ZGNTN3FBZndya2g0QURsN3o5V1A0QW9nTWlOd2NiWDFRN1BveHBWT0dUQ2JD?=
 =?utf-8?B?TFBXd1Y0dG9DM0o5dlBaTCtrSFN6c0VSaWoxQjhsSXV6RmNCTE80cXgyeU9S?=
 =?utf-8?B?RjJsVStySlJ3KzJ0b1VvTkl4OVlHTW5lOGlYd1NXOEtsbStEQ0srRWRTRDJM?=
 =?utf-8?B?THRNUVNUQ21LWmtMcW1LWWFyam1KZ2xjYUtrZW4xOWNtTDVpZFJTdWEzeUd1?=
 =?utf-8?B?dDhyWjdKenBhVGNQRjBabFhDVVhyaThiUFJIUXFtSHpPMkxqYjRFWGdzeDYv?=
 =?utf-8?B?QVV4UnFhQ1Ryclc2b0VVRERkaWNNOWxlOFB4WVN0c1phWGxSTi9XclFsb1lh?=
 =?utf-8?B?ekVNcVAvN0tQRGExUHg5NkhEQ1l4c0x1WjZVOGE3V002ZlZJWTZFa3Y2ekND?=
 =?utf-8?B?RUp2dWw3dStWUmF6QjJhUE8xYVRPSGw5NDg1MTRFNjByWW9kTmNQZVBFSlRx?=
 =?utf-8?B?ZURsRU1rVGc0cDRCTVV2WEUxSGdHanNHRjRnSlR4MUNNWG5GZUpCZE94MUt5?=
 =?utf-8?B?bHhmRWU4aG93WGNYYTFYbVF1SmJWeWV3ZjdQanFnam9BNGZRY0pNS1F0Vjly?=
 =?utf-8?B?eGRBUS84bGJ2L2hTQ09OblljcTNNdEh6WlQ0dHVZMGMvWGpoUFpadGNaWm8y?=
 =?utf-8?B?OG5hanRwVkZMUDdxVGkzQVhYK21tak5rUndYNEp2dWlVMUZXb3dmSjdQWTNO?=
 =?utf-8?B?L1FQd1dqYkk0bTN4REd5UU9WaFU4SGg5eG95UGQyeHloeGVIY2FkQ1EyT1Zs?=
 =?utf-8?B?aGFWSDg4TUxXVnMyWGtZblRBRVYvYkdIZ2FLU2wydk1SaFVqbWpvRUdaUHI1?=
 =?utf-8?B?MTF5NjJKclVGQlpRT3ZrckxWZWZvUkdqaHY2K09IVkR6OTZwVzRWUzROeUlC?=
 =?utf-8?B?b1NmOWQ2OXpKM2NBUnV0UnhoZklOczFsSXpPQkhLR2ViM25kYmMrT1FQM3VZ?=
 =?utf-8?Q?ay7svP2YKcF/U76s5TEy6MteK?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d72075b-4f16-43f3-cd70-08de0bfa69ac
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2025 14:52:07.8020 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sLL6v+kjIi+Yt03k6EOX4P1Dz0ugMtKGTorU6AFVKzKzwhAcRqjdEjJ36Vl4A62u76o/gjSYqF9MPTvONXnmLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8997
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

On 10/15/25 9:30 AM, Alex Deucher wrote:
> On Wed, Oct 15, 2025 at 10:19 AM Harry Wentland <harry.wentland@amd.com> wrote:
>>
>>
>>
>> On 2025-10-14 17:38, Mario Limonciello wrote:
>>>
>>>
>>> On 10/14/2025 4:27 PM, Alex Deucher wrote:
>>>> On Tue, Oct 14, 2025 at 3:46 PM Mario Limonciello
>>>> <mario.limonciello@amd.com> wrote:
>>>>>
>>>>> [Why]
>>>>> If userspace hasn't frozen user processes (like systemd does with
>>>>> user.slice) then an aborted hibernate could give control back to
>>>>> userspace before display hardware is resumed.  IoW an atomic commit could
>>>>> be done while the hardware is in D3, which could hang a system.
>>>>
>>>> Is there any way to prevent this altogether?
>>>
>>> The obvious way is that userspace should be freezing user processes. That's what systemd does.
>>>
>>>> This seems like a recipe
>>>> for trouble for any driver.
>>>
>>> If we want to uplevel this kind of check I think we would need some helper to report hardware status into drm and drm would have to call that.
>>>
>>> Most distros use systemd, and this only happened in an aborted hibernate.  I guess I'd like to see how much this warning actually comes up before deciding if all that plumbing is worth it.
>>
>> I was briefly thinking about a generic solution as well and don't
>> think it's worth it at this point. This is mostly about internal
>> driver/HW state.
> 
> Allowing userspace to be running while the kernel is either entering
> or exiting suspend or hibernation is a recipe for problems.  It seems
> to me that the kernel should stop userspace before it tries to do any
> of this and only restores it when everything has resumed.  Having
> userspace stop itself seems broken by design.  Applications can
> allocate memory or call IOCTLs into any driver which may not be
> functional at that point in time, or depending on the timing, the
> user's state is lost because they did something to it after the kernel
> already created the hibernation image.  Fixes like this seem like
> playing wack-a-mole.  It might be the GPU driver today, but it might
> be a usb driver tomorrow.

The kernel does freeze threads once you're far enough "into" the sequence.

I'll look through the aborted hibernate flow and see if I can find out 
why this is happening.  Maybe they are thawing at the wrong time.

> 
> Alex
> 
>>
>> Harry
>>
>>>>
>>>> Alex
>>>>
>>>>>
>>>>> [How]
>>>>> Add a check whether the IP block hardware is ready to the atomic check
>>>>> handler and return a failure. Userspace shouldn't do an atomic commit if
>>>>> the atomic check fails.
>>>>>
>>>>> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4627
>>>>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>>>>> ---
>>>>> Cc: Harry Wentland <harry.wentland@amd.com>
>>>>> v2:
>>>>>    * Return -EBUSY instead (Harry)
>>>>> ---
>>>>>    drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 5 +++++
>>>>>    1 file changed, 5 insertions(+)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>>>>> index 6446ec6c21d4..f5cd9982af99 100644
>>>>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>>>>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>>>>> @@ -12010,6 +12010,11 @@ static int amdgpu_dm_atomic_check(struct drm_device *dev,
>>>>>
>>>>>           trace_amdgpu_dm_atomic_check_begin(state);
>>>>>
>>>>> +       if (WARN_ON(unlikely(!amdgpu_device_ip_is_hw(adev, AMD_IP_BLOCK_TYPE_DCE)))) {
>>>>> +               ret = -EBUSY;
>>>>> +               goto fail;
>>>>> +       }
>>>>> +
>>>>>           ret = drm_atomic_helper_check_modeset(dev, state);
>>>>>           if (ret) {
>>>>>                   drm_dbg_atomic(dev, "drm_atomic_helper_check_modeset() failed\n");
>>>>> --
>>>>> 2.49.0
>>>>>
>>>
>>

