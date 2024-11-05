Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F89ED1CA11
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Nov 2024 07:06:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D96B10E3FD;
	Tue,  5 Nov 2024 07:06:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="w3AvT1zD";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2079.outbound.protection.outlook.com [40.107.220.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1C19010E3FD
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Nov 2024 07:06:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ABZQE2I3dQmvMBvxpGpMqIzvUZHxNcGwGwVxqUG7dzgW8Ao/LXFJSFZSHqS+frkiJyd2KNZ9h3fwasYxWKSiMCCc7SNpHyPjTYh2z5t/VquARYmOYHriePhKsxzS3VjxYaP6lA0rBs8waE+02HRVV1RaMf/p+XoQKjYfrXd4/qKPECwn2wEf+YQsIitf1bRBPvH8z8rFJQ80CERnJx7pQmf1vI99iFaztk5S382x0K+h66Bm2pOLcKC+11EYQZKZypgJ8CJ6BL8B4t3+y4xcaPlrdIKlyd06TW3CwpxPh2p9Yeq4PCD51zi+ljCG2jl6r7SucMz66vOB99Qb5Ivs0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OCpdQJCGlXROF6wzgTAgtcAtibH6RCecPU1JlJ4AY/o=;
 b=JW5Ylmu/A9Sy1Ebs0pwGF2RKicXW0bLQJS24cEymTYls9au49JlKXbC7XRljZUOiwi7ocRcIjCuUvmhnegoqSeWCtToYfGD6myV330AJutILY88H7sr2yfoWNI4UC20ark0o+gG+gItPSjUmSxTvE9KGVoZPoBhaWh6M0joDd0Odgx1fll05o3hjLCELKFphveMUqr0tRI/nmkk3zfJf2qt9Q++IFvri6Rx6wFLNVcmrQMGrIzYv6V7R+C/r1TbDXdTINVmZ81U8AQLWB4DXElXhvLInkHS3F33Mhpfuat72Hqcb0wJXcraTAK7YyDVUYtlP3MySXpq8yZqRKWplbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OCpdQJCGlXROF6wzgTAgtcAtibH6RCecPU1JlJ4AY/o=;
 b=w3AvT1zD3m0uZmWrLmpIiOGtVx6GDsV99QKslrQY4uoaFMPJq35UrjZH71WVYBrp2dg5IhjlZ8XUzzMWhz+qAYE2MQlNufVwQMm3Nk82zjK9MLFwwCBq9HeWY6wIMelasjufVmToPPXoDzAXV2RenahR6JawXEemGAwPvS+Acnw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 SA1PR12MB6847.namprd12.prod.outlook.com (2603:10b6:806:25e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.29; Tue, 5 Nov
 2024 07:05:57 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%5]) with mapi id 15.20.8114.028; Tue, 5 Nov 2024
 07:05:57 +0000
Message-ID: <7028c7e4-7355-46ad-ba72-a62c4c4ed11a@amd.com>
Date: Tue, 5 Nov 2024 12:35:50 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/amdgpu: Fix unmap queue logic
From: "Lazar, Lijo" <lijo.lazar@amd.com>
To: "Ma, Le" <Le.Ma@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Zhang, Hawking" <Hawking.Zhang@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>
References: <20241105053844.3242241-1-lijo.lazar@amd.com>
 <PH0PR12MB5404F8E5463D0157BE13BC32F6522@PH0PR12MB5404.namprd12.prod.outlook.com>
 <d99a7caf-a88d-49bb-b5b1-dd8ead9de174@amd.com>
Content-Language: en-US
In-Reply-To: <d99a7caf-a88d-49bb-b5b1-dd8ead9de174@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0121.apcprd02.prod.outlook.com
 (2603:1096:4:188::21) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|SA1PR12MB6847:EE_
X-MS-Office365-Filtering-Correlation-Id: 61862950-6f89-4c16-56e6-08dcfd684c03
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bVBkVzM2YWpmRE1VMEg3TUNVQ0JnK1JKcytld2dtZ05aTFJnMHMxNGRPdVlY?=
 =?utf-8?B?U0FBTi8xQnBwOU83c3lQRzJ4RkU5dDlOUElDM0ZSSW1YRnlzam5tYWRncmIz?=
 =?utf-8?B?V1VpOTlRMDVLQnJXV25vL0RYRGo2NzhENkJRVEpIc2ZCQ1VQMy9EdHZYNVJn?=
 =?utf-8?B?OVlGUFlqMjhWQnA2aGZNVVBaZFo4VTY1Ym9NQzFDMitobzZoMzNmZGRDUFVx?=
 =?utf-8?B?UFM5QlpnbVM1WVN5ZEUvRDloMFJmeEJzdTl6Z0J6cXdwM3dIVHJaOHB0WUhr?=
 =?utf-8?B?VVdJMW1ZYjdGRm5QTGxUcmZ6QlpyZnJHQTdYMXF5Y2VJelBlS1lidjdCVW1P?=
 =?utf-8?B?eTBWSVEvRUxSWHFSTldHMWlxbnhMclFsNUFxalFCTWhBVlI0ZG9rWDk5OHpr?=
 =?utf-8?B?NGFKTFNPL2lNa015SExnOHA3aUhHS1pycndvYTM0Zkt5bVpIRVVkWFNhOXZ0?=
 =?utf-8?B?UVd1T0JaMzU2YjdoMXBRZ2dmYmVYNmZxbFVtcTZvU1lZM2kyaHBHVm5waEVG?=
 =?utf-8?B?OWtORDZmRXdhQWlITllUdS9ydFZFNitubXFNN0hnMTVtZGlEMmRQM0FvMGdn?=
 =?utf-8?B?WTJOL3pCb3F3ZUJWMjUwMGdMYlRIenFNOUxsRS9WTitJcm1rWGJwek9FVUtp?=
 =?utf-8?B?aFpzdllrRnFrWHdEQ2VLeDlORDE0MnlsTExJejNXZ2VCSFFzZkMxYm9hVW5q?=
 =?utf-8?B?bnVFYXA0OVpLd0ZIS0lqR05VbFBCOElxZ3lYYmdwbmdGNDIvL2NiZ1JLRUFC?=
 =?utf-8?B?VGhMdjRFQkhuSG9BUzEzYldlT0w2bXFoVXdBSVNVZzB2NEc5b3Bpd05mczRl?=
 =?utf-8?B?SUVNaFFPMGF0T3IwM3hzcWR6cmlLRG9yNW02OEszdTd1MEQzMTJKSHpDOVMr?=
 =?utf-8?B?NVEzT3p5MVV1Z2NFQjU4VVY3ZWRDWlpMZ0M2dEU2OUhBaXlNcjlzNXhxOGRF?=
 =?utf-8?B?akxEWWFMcWZiTVF5UVoyT2M3UWRpQUhZRXFFVC94dzgyL0pwSVM4MFZHN09S?=
 =?utf-8?B?aC9UY2Q5MVhUMEc0d0ZWVEt1Q3NheGJtZ3VMK3lzRTd6dEFWd1hhSE9aYUxO?=
 =?utf-8?B?eEV3UGlPVkVZT0g0aXgxMUdrVmNIQmsxNCtCZTRXVUVZWWFGSmN3VHVKWEwr?=
 =?utf-8?B?WGdUTjRSNk9lQ2lvaTg4M3V4TllGY3lhcWxoYW80MVZ4SXYvbngrSWhsSGxh?=
 =?utf-8?B?YTNMdTV0WDZzQ2plU3BFRWYwRi82UEZCdWFPUnBMcEkyTERSbVF4eHBFMWtI?=
 =?utf-8?B?dUxZN1BDcHh1OXRIeHpkZk9JOGRZWkRGazA2RG9KQVBTa1E2NExFLzdCZjFK?=
 =?utf-8?B?T2ZiRHN6bmNUT0labk9oQ25CTGN5WUVjSHZJYW1ZVzluSkxsSjlHNmQza2xk?=
 =?utf-8?B?R0VvUndQenhJNXlTSXlSSUtucHNUYWRxZHAwRVl1aFdzdnR0QVF1dzhYOFRE?=
 =?utf-8?B?ZTErbUsyQXpjLzlEL0dFRzB6d3ZDSllXUS9JUmJMRlNXR2ZWd2FCRUJ6VThY?=
 =?utf-8?B?dWVlamx5WHM0VlFXZ0JSOWl2NmpGdlo2QjJlVjBiMmtlbnFKZkEwUzI4Si8w?=
 =?utf-8?B?dFltSHZ1MTNaUUhYUUdMRG5GUkszUjVKZ1dqTmM2TTZWMEhOenZoNXNUMXY1?=
 =?utf-8?B?NUw0dGVadUxzL3pTdjVPK1N0TDVtVXAxdXVYMlJpaUwzOGkycEVZUG9tcUVq?=
 =?utf-8?B?ZjZjRnJwNkJ2UnY3VEJpby9hTXFKT3d2NG1GZmhUMWdVdXl3cUxnZjZTNTh6?=
 =?utf-8?Q?u8WpK+uPQK0I6jEVqvjBnFzVEu/EFgBaeKUWU2n?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c2lXRlM4bUpDd3llUktqQ0hvYjN5ZmFGU0R6OUt0cm0xZDVZcDVlSGlZT3VH?=
 =?utf-8?B?aUNGSUtRWlVndURycGJDWVI4OG1uaG5vUUhrMXJ2T2s2MENMUThPMVdNS3Nk?=
 =?utf-8?B?aUhOZU9LSC92enUwVkYvSXJ0T1JrbWN3cUNYTURrSmVXVUNqZ3lWUDV1RmRi?=
 =?utf-8?B?M1lCVURlbG9XLzNiUnM5QjY0WHNiMHltUHYvYkpCRDZNQlFjNWNuQUh5aTdG?=
 =?utf-8?B?cmhtOWFsY0FEZi9NYWlTZ0V4NTgvTExYazNHNzJPTEkzbXdoMkVoOGdxTndL?=
 =?utf-8?B?TzdQZUNRckJqUkZsaEFSSjg5Um5iZ0xBTGNwaVlPS0h2Qzh1cVlJK3RGdmhX?=
 =?utf-8?B?WTJOYitBaU5mRmVSRU8vR0ZaaTNvUTVtMnVhVXJ5TDZtT2s2QU9VaXMrNEpD?=
 =?utf-8?B?OG5wMWJyeHpkWXBtcXE0SHppYzcvRDFpeHVKM3dNZUR2MVI0L0d3Z1hLMXVZ?=
 =?utf-8?B?cFkzK3lTcm1hcHQ5RkZCNVc4ZkV6VFRHSVNiN3lJaVIvaXdjM0UzdGI0NStv?=
 =?utf-8?B?UmxJZXowVStJeUN3MDZkekM5UFVOUGtycGIxeWlxYmJKdWxWaVhLVCtRTTdX?=
 =?utf-8?B?QUJzckFwN0dRd2VrOXB5TDVYSjFUakxSQXh0Sm0wekpsU3BFdkRUZWwyMzl1?=
 =?utf-8?B?U3R3b09aa3QyV04rM3luOU40ZmtqMWJpNVdqeUJRSTZQZ3pFTThyV0k3L0p1?=
 =?utf-8?B?ZkdEM0lka0xUMGJoY1NjOVlmbmh0eFpPSXN0U3AxRHFCVjFFSzVnMkt4OVkz?=
 =?utf-8?B?RTdBQmNNZTE2VWUzaitQb1pLMDlqK3lheVd6REkyOXo0aURZeCtiYmQyRU1D?=
 =?utf-8?B?TVQxL2FiVnBlNkl2M0ZIWjJnN1A1elpOVmRaUGxTQS9Ta1JOOW95SlkvTU12?=
 =?utf-8?B?UGt0NFZ6VmZlclR0dC9GRGpKeFEwQlJabjlkMmV0UjFHSnBaZEo0U2xiSkth?=
 =?utf-8?B?WldlSFFwaHd4VjJUR0hMT3E2VUh1WDB1V3I1eS9IZEFDeERIUS9ZZlA1bXpP?=
 =?utf-8?B?UTY5SWhBZkxnbE5sd0dROXRsNWpYWW44TFNpck1GK2RDNjROTkMxMWZIZGVy?=
 =?utf-8?B?UTgvMlNjREZhRk82SStDbndMcStKL2NvbWd6aGZmWDlnb3R1YjdLclBmSG9Q?=
 =?utf-8?B?S08ybWZPcXd4emVyU0JKcnM1a25IL3BFT1orVGNzVmNuODRGdnpEQlNFYitF?=
 =?utf-8?B?VmlYZVZoOVl3cmpVM01uVTh2ZlRCeE0xRUdQdHc1dlVIeHFSU2o5YTd3d3Fv?=
 =?utf-8?B?SE8yaDZzWDRpd3FTcU50WEEra2Jja0c1aFU2RVluTE5WUWJrQ2JtYzhnUGZh?=
 =?utf-8?B?VnBYOFhhbzB4eGZ3U1dvQ09COEE3MWdZNmI0WTVxNUVLcHYzMVhXT003Z3ZF?=
 =?utf-8?B?MEtORW5pZDBVd0hrejNrUEdhMXVNUCtFbUhQVU5rNnovZWE5SDYwN2pHQ3Vv?=
 =?utf-8?B?V2s2Mk45QmVIVDlBNWtFcTZYZ01DSGNvQldrWk9FbmhuUkV1bmRkSHhBdmxB?=
 =?utf-8?B?RitqNTg2Q000SkNSL2RPTGZMaVREVXo3MDVDaEp1UDQvUnRmYmYvV3QxR0Iv?=
 =?utf-8?B?ZGVhbEc1cmJ4ajFvVlhobWdVNHFScTRqd1lxUEY1SGdUVHlhZHBLUXRHNGVS?=
 =?utf-8?B?a1o3S0EwMEcwbkhjamI3bmN2cDNmRXluUHpzb3V6ZVR0Q0tZQXZqRThwVVFB?=
 =?utf-8?B?aEk3MXhaWlJoanFqK0lqNXFUZ1M2T0U0alFJMGRuRzFyQmdTOFhxT1c5WGk0?=
 =?utf-8?B?aWVBb0JzeFRDWFZCVDVjSGwrMG4rRnNOY1RSM2d5ZEZDVXZEdTM1bjJqWWtT?=
 =?utf-8?B?d1F5T2xVN3lMUUpDQ1hJK3ZUVXF1VExlZklsQkhjTXJCRGUzOVVOT0trblYv?=
 =?utf-8?B?QVZEelZwWkRYZFZ6UEJrd09GbzJVZXQ4enBPQlRhcUxualNKdXhXSUJScWVT?=
 =?utf-8?B?djhXYktpUndXMEMyeU9nUUJvTkZOaHU4ZVFCMnZTRmdHTncyODBvY2JxK0Yy?=
 =?utf-8?B?UUtDSlRZNkZreWNDSkE0YlpFMVhsSDhFMzU0Q2JDeXZDRy90bktUeStzTm1W?=
 =?utf-8?B?R1NCZGtOUVpwbVlsY2o3d09SYVc5Yi9SdWtmaStHZGhxVnZHNEdPV0NZTi9H?=
 =?utf-8?Q?Kac02MiefWOAs80Rsypywcb7Y?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61862950-6f89-4c16-56e6-08dcfd684c03
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2024 07:05:57.6766 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FFooPOXYey9z6bDkiprVISt15jfQ3NyLq9CkTL01jx0dM7GxctOnhjn8I8+NnZBn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6847
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



On 11/5/2024 11:52 AM, Lazar, Lijo wrote:
> 
> 
> On 11/5/2024 11:45 AM, Ma, Le wrote:
>> [AMD Official Use Only - AMD Internal Distribution Only]
>>
>>> -----Original Message-----
>>> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Lijo Lazar
>>> Sent: Tuesday, November 5, 2024 1:39 PM
>>> To: amd-gfx@lists.freedesktop.org
>>> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander
>>> <Alexander.Deucher@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>
>>> Subject: [PATCH 1/2] drm/amdgpu: Fix unmap queue logic
>>>
>>> In current logic, it calls ring_alloc followed by a ring_test. ring_test in turn will call
>>> another ring_alloc. This is illegal usage as a ring_alloc is expected to be closed
>>> properly with a ring_commit. Change to commit the unmap queue packet first
>>> followed by a ring_test. Add a comment about the usage of ring_test.
>>
>> Regarding the description " This is illegal usage as a ring_alloc is expected to be closed properly with a ring_commit ", does this only apply to unmap queue logic ?
>> The current logic to do map queue is also to commit once in ring_test but ring_alloc twice.
>>
> 
> Should be applicable for this case also - ring_alloc calls begin_use and
> ring_commit marks end_use. It could be working fine because those are
> not implemented for these rings currently.
> 
> But using ring_test without a commit doesn't appear to be the correct
> usage of API.
> 
> Will fix map calls in another patch.
> 

After checking, it seems better to have those changes as well in a
single patch. Will send a v2.

Thanks,
Lijo

> Thanks,
> Lijo
>>>
>>> Also, reorder the current pre-condition checks of job hang or kiq ring scheduler not
>>> ready. Without them being met, it is not useful to attempt ring or memory allocations.
>>>
>>> Fixes tag refers to the original patch which introduced this issue which then got
>>> carried over into newer code.
>>>
>>> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
>>>
>>> Fixes: 6c10b5cc4eaa ("drm/amdgpu: Remove duplicate code in gfx_v8_0.c")
>>> ---
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 13 +++++-
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c    | 47 ++++++++++++++--------
>>>  drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c      |  7 ++++
>>>  3 files changed, 49 insertions(+), 18 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>>> index c218e8f117e4..2a40150ae10f 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>>> @@ -844,6 +844,9 @@ int amdgpu_amdkfd_unmap_hiq(struct amdgpu_device
>>> *adev, u32 doorbell_off,
>>>       if (!kiq->pmf || !kiq->pmf->kiq_unmap_queues)
>>>               return -EINVAL;
>>>
>>> +     if (!kiq_ring->sched.ready || adev->job_hang)
>>> +             return 0;
>>> +
>>>       ring_funcs = kzalloc(sizeof(*ring_funcs), GFP_KERNEL);
>>>       if (!ring_funcs)
>>>               return -ENOMEM;
>>> @@ -868,8 +871,14 @@ int amdgpu_amdkfd_unmap_hiq(struct amdgpu_device
>>> *adev, u32 doorbell_off,
>>>
>>>       kiq->pmf->kiq_unmap_queues(kiq_ring, ring, RESET_QUEUES, 0, 0);
>>>
>>> -     if (kiq_ring->sched.ready && !adev->job_hang)
>>> -             r = amdgpu_ring_test_helper(kiq_ring);
>>> +     /* Submit unmap queue packet */
>>> +     amdgpu_ring_commit(kiq_ring);
>>> +     /*
>>> +      * Ring test will do a basic scratch register change check. Just run
>>> +      * this to ensure that unmap queues that is submitted before got
>>> +      * processed successfully before returning.
>>> +      */
>>> +     r = amdgpu_ring_test_helper(kiq_ring);
>>>
>>>       spin_unlock(&kiq->ring_lock);
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
>>> index dabc01cf1fbb..6733ff5d9628 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
>>> @@ -515,6 +515,17 @@ int amdgpu_gfx_disable_kcq(struct amdgpu_device *adev,
>>> int xcc_id)
>>>       if (!kiq->pmf || !kiq->pmf->kiq_unmap_queues)
>>>               return -EINVAL;
>>>
>>> +     if (!kiq_ring->sched.ready || adev->job_hang)
>>> +             return 0;
>>> +     /**
>>> +      * This is workaround: only skip kiq_ring test
>>> +      * during ras recovery in suspend stage for gfx9.4.3
>>> +      */
>>> +     if ((amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 3) ||
>>> +          amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 4)) &&
>>> +         amdgpu_ras_in_recovery(adev))
>>> +             return 0;
>>> +
>>>       spin_lock(&kiq->ring_lock);
>>>       if (amdgpu_ring_alloc(kiq_ring, kiq->pmf->unmap_queues_size *
>>>                                       adev->gfx.num_compute_rings)) {
>>> @@ -528,20 +539,15 @@ int amdgpu_gfx_disable_kcq(struct amdgpu_device
>>> *adev, int xcc_id)
>>>                                          &adev->gfx.compute_ring[j],
>>>                                          RESET_QUEUES, 0, 0);
>>>       }
>>> -
>>> -     /**
>>> -      * This is workaround: only skip kiq_ring test
>>> -      * during ras recovery in suspend stage for gfx9.4.3
>>> +     /* Submit unmap queue packet */
>>> +     amdgpu_ring_commit(kiq_ring);
>>> +     /*
>>> +      * Ring test will do a basic scratch register change check. Just run
>>> +      * this to ensure that unmap queues that is submitted before got
>>> +      * processed successfully before returning.
>>>        */
>>> -     if ((amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 3) ||
>>> -         amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 4)) &&
>>> -         amdgpu_ras_in_recovery(adev)) {
>>> -             spin_unlock(&kiq->ring_lock);
>>> -             return 0;
>>> -     }
>>> +     r = amdgpu_ring_test_helper(kiq_ring);
>>>
>>> -     if (kiq_ring->sched.ready && !adev->job_hang)
>>> -             r = amdgpu_ring_test_helper(kiq_ring);
>>>       spin_unlock(&kiq->ring_lock);
>>>
>>>       return r;
>>> @@ -569,8 +575,11 @@ int amdgpu_gfx_disable_kgq(struct amdgpu_device *adev,
>>> int xcc_id)
>>>       if (!kiq->pmf || !kiq->pmf->kiq_unmap_queues)
>>>               return -EINVAL;
>>>
>>> -     spin_lock(&kiq->ring_lock);
>>> +     if (!adev->gfx.kiq[0].ring.sched.ready || adev->job_hang)
>>> +             return 0;
>>> +
>>>       if (amdgpu_gfx_is_master_xcc(adev, xcc_id)) {
>>> +             spin_lock(&kiq->ring_lock);
>>>               if (amdgpu_ring_alloc(kiq_ring, kiq->pmf->unmap_queues_size *
>>>                                               adev->gfx.num_gfx_rings)) {
>>>                       spin_unlock(&kiq->ring_lock);
>>> @@ -583,11 +592,17 @@ int amdgpu_gfx_disable_kgq(struct amdgpu_device
>>> *adev, int xcc_id)
>>>                                                  &adev->gfx.gfx_ring[j],
>>>                                                  PREEMPT_QUEUES, 0, 0);
>>>               }
>>> -     }
>>> +             /* Submit unmap queue packet */
>>> +             amdgpu_ring_commit(kiq_ring);
>>>
>>> -     if (adev->gfx.kiq[0].ring.sched.ready && !adev->job_hang)
>>> +             /*
>>> +              * Ring test will do a basic scratch register change check.
>>> +              * Just run this to ensure that unmap queues that is submitted
>>> +              * before got processed successfully before returning.
>>> +              */
>>>               r = amdgpu_ring_test_helper(kiq_ring);
>>> -     spin_unlock(&kiq->ring_lock);
>>> +             spin_unlock(&kiq->ring_lock);
>>> +     }
>>>
>>>       return r;
>>>  }
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
>>> b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
>>> index f85e545653c7..553a6113fa67 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
>>> @@ -4823,6 +4823,13 @@ static int gfx_v8_0_kcq_disable(struct amdgpu_device
>>> *adev)
>>>               amdgpu_ring_write(kiq_ring, 0);
>>>               amdgpu_ring_write(kiq_ring, 0);
>>>       }
>>> +     /* Submit unmap queue packet */
>>> +     amdgpu_ring_commit(kiq_ring);
>>> +     /*
>>> +      * Ring test will do a basic scratch register change check. Just run
>>> +      * this to ensure that unmap queues that is submitted before got
>>> +      * processed successfully before returning.
>>> +      */
>>>       r = amdgpu_ring_test_helper(kiq_ring);
>>>       if (r)
>>>               DRM_ERROR("KCQ disable failed\n");
>>> --
>>> 2.25.1
>>
