Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22551D3A678
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Oct 2024 17:46:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C60F810E6D1;
	Tue, 29 Oct 2024 17:46:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cjB1JPis";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2071.outbound.protection.outlook.com [40.107.212.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC72A10E6CD
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Oct 2024 17:46:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q5dUT4cXeO+L54JhkXrz1Gr8OQqHLEqp5dG7oKgwopo7tXf1X00v37QDcniDxOknX5dxOCtmcWqQSzdN9xMIgEVxuVs7KKCEsiXYGgETuo3o5wGxZ4jo+xg34VnOd3rkxQKjpLE7Mrx3aOqPAzEK6j5wQo7BpPhGUxZKyxTplAyq8hNbLnL0kfNZtJp2GfYgJcFASsoOEXMJczmeMD8MZfDDeQLbDDdGVa+74HjTUqah34CtVC3vgoVIig5Y5BEms0MOv0A2kssWs18O4B+/1d+92LNIFLK+juFnJLmD3reP3zSvIvhGADfk3aJ64LzazboNkBAtQuriXT2DJKwN9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wTuCoFo84L76n4l84aaxhDWXN4yhn0dmT1tn8yFEj0w=;
 b=IzzExaFmZGbIx9lA8m1oaWRYP7v2HwSOhwy3HXhtzcbmfnbnu0CjMqDhlpGMjpKITt9LhVbcBkd15aTwx9EoZOc1YoCsffIP+StOHrbnBS2A0bsDKdhAlPQ7oZz0roSvVQXH7a2CzNnksxeVvKFj0Oh5nlmqYxI5AR6K0OTOdJlV+2odDvNKdRJ6ai2Hc7tBvD2Qqsx7BKOuTJcsfGLyLF/kqw6Ciu6PTb6z6iJWWvF+RK2V2vYZ9SOBpNXBwGaWRhGn0lOuIlj05683uWDVtI2oY86LfNtsthM9vA4mkuwBxBfYkS4TiloW8EZGIbiKjerFKvDqo91/A79B62v7Qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wTuCoFo84L76n4l84aaxhDWXN4yhn0dmT1tn8yFEj0w=;
 b=cjB1JPisEKd8j3sI3yfqpmM1cQ5R+DRTPJxX5KPhZpcQmVYZ7Xq6q8OyDhtY6b8rFKbbEupjbsiPwMt5UvfM9Dr09F+Acismk+Pz/jeall2DFPwBPMfZt7ZgsPctffgfCfV6OpHI+DfKFoHqv21Uu2nZ8VwiRqmb6rcxWVhpv+A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY8PR12MB7491.namprd12.prod.outlook.com (2603:10b6:930:92::15)
 by CY8PR12MB8300.namprd12.prod.outlook.com (2603:10b6:930:7d::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Tue, 29 Oct
 2024 17:45:58 +0000
Received: from CY8PR12MB7491.namprd12.prod.outlook.com
 ([fe80::217f:1ab1:9a5f:fecc]) by CY8PR12MB7491.namprd12.prod.outlook.com
 ([fe80::217f:1ab1:9a5f:fecc%4]) with mapi id 15.20.8093.023; Tue, 29 Oct 2024
 17:45:58 +0000
Message-ID: <b61a55a5-4439-422f-9463-7205ea4cee0e@amd.com>
Date: Tue, 29 Oct 2024 13:45:55 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/29] drm/amd/pm: add inst to dpm_set_powergating_by_smu
To: Alex Deucher <alexdeucher@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, leo.liu@amd.com, christian.koenig@amd.com, 
 alexander.deucher@amd.com, sunil.khatri@amd.com
References: <20241025023545.465886-1-boyuan.zhang@amd.com>
 <20241025023545.465886-6-boyuan.zhang@amd.com>
 <CADnq5_Nro=8wKAP=4HAs2ykaDcJerKan8bGsZZosmDGY8hnTzQ@mail.gmail.com>
Content-Language: en-US
From: Boyuan Zhang <Boyuan.Zhang@amd.com>
In-Reply-To: <CADnq5_Nro=8wKAP=4HAs2ykaDcJerKan8bGsZZosmDGY8hnTzQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0179.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:f::22) To CY8PR12MB7491.namprd12.prod.outlook.com
 (2603:10b6:930:92::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB7491:EE_|CY8PR12MB8300:EE_
X-MS-Office365-Filtering-Correlation-Id: 533a2691-b00f-4b7b-4f51-08dcf8418b88
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cWpWcmNQNUY2bGtIc0szMW8yeElxb2N5UFVzZFoydGEvdVdidHo5b00yNk1h?=
 =?utf-8?B?SnFWa0hEMWxIWCtzREdZRW1EUHQ1N2hZNGRxc3lnYWZwM056NG5VVFBFZnpV?=
 =?utf-8?B?MWdlUDhISkJnY0dQQ1UwUlJvTTJhcDVuMWxTaEtrWEIvWHR0UzR3K1RlV01r?=
 =?utf-8?B?S1M3UHAwL1hEcWRwNWUxcHVHVk9DMEorNW1PVkhjT0t0VkxnV0xjemMxSXdC?=
 =?utf-8?B?MUNSQWE4eC9MT3Bick1KYkhMSEpYU0VYRmR1U0ttd3gvUzlqR041SW92TE82?=
 =?utf-8?B?QWlRRmVOaXUzZXdXSmhkWTFtUTNodkRqQVpoU3FCQ3lJYnRZRzJ5bXp2dWdr?=
 =?utf-8?B?b3hhWlVSK1QrU3I1emRHZHQxMlJ2Y0RqM2s3SFZ1L1hFRkxUdzNPVnNkMUxX?=
 =?utf-8?B?cUFmK2ltTUhhS2J0NExQL1VDQnI2NC9QaE9ESHh2NHlWUGh3YXVNbmdMeEk2?=
 =?utf-8?B?MHpUVW5uRm1MYWV4MHpjKzNOQjB4U2JhNWNmZSt6ejdiZ1RjaDdpZmFvcFNh?=
 =?utf-8?B?VGx2YXBCbHRBdXR3SkE4VjBOc2FWdFhrLzJCSWNRS0s2VW96MnZsVFZCdkJj?=
 =?utf-8?B?QktwMS9mY2k4Y0NyK2ZVMWpTakhDRVY5OEJMUzFLMTdCYUY1bE0zNFFzcEkr?=
 =?utf-8?B?TU00aFBJY09QQXRDeUhaL3NSRksvM3dKcTVkcCt6N0FVTUVheXhKUDVrT3BZ?=
 =?utf-8?B?U2VHdnQ0eEJveWc4aHNMQSt5QVZhalVmVlVaRm9pWFdISkt2Z05GMENUWi8r?=
 =?utf-8?B?dTFRdkhIYS9UNU5vb0JQM21KUnh4NitBekFsZFNaLys4aTNTMlcxWkVsRTI0?=
 =?utf-8?B?M1lqR2l1SkNwRWk1L3pseTFxVHg0RTl3cXZmR2IvODkrVTRDdk54NDJwSDYr?=
 =?utf-8?B?WHlyK2RmS3hmUHVXL3hrSkxNNFVwQVdTVmdPajN0MW1JYWo1akY3eG5yTjAx?=
 =?utf-8?B?eVIweUVibHpDQ28vSjYwR05KeXhnNGo4aXhBMTZPT0ZQcUxrSVlRQWZyb2JF?=
 =?utf-8?B?cktXcytBaWFRem1URnBBU0p2dmxtY2xNaWR0NURTNFlnT0pGU2hEZDdlMklC?=
 =?utf-8?B?aENkVTM3VEdrbUtaU0IzKzUyTWZvSHVrUUVKOUZFdDd0SUlFU2ZTNmErcXlX?=
 =?utf-8?B?NTlDMnJRM2RDSTFpbExmUWxxTVhhaVUwSVpUUUxKV1EvT1BLTVg4WmJqcFUy?=
 =?utf-8?B?bmVLWGVuZWx6QmR0NUN0NWFNdU9zVGtiNy81bFVDVVRkaGNxUU9zRDYzYmI0?=
 =?utf-8?B?NWdMOG81T28zNS9VbTk2RENhQmJYUHF6UHhIaWJKYUZ4TGFjclZjRUNOYitq?=
 =?utf-8?B?YjJVQjNyRHNhL25hTlpsNzZUYnJpZTBVMmVJQTlVWkg4WG5CcnN0VFRocUlj?=
 =?utf-8?B?aUdFSG1TWGV2VXRTeVNaN2sxK1AvdWNBZVl4ZzN4WVVLeXk0bmRpNkF3Skhw?=
 =?utf-8?B?eEMvREorTUcrSHgxai9oYVBSSCt3UzZ1ZVlkUVQ0cUxPNVhLU3o0ZlA1SXlY?=
 =?utf-8?B?bnVDb3RRbGFlR1ZadXA2Y0w5bnE5WCtFaFV6WllpTzN1L2NwUHdvak5MTG0v?=
 =?utf-8?B?Mml2amhpOEZFajF2T24wM3N3SExPLzhkZ1NTR0xtN3JRZGdwbTd4Um5YMVlF?=
 =?utf-8?B?N2U5MVBRSmo0TkpNR1NFSkFmV01GQ3p6NVc5STNXeDRwN2ZYRVVNVXVxc2Q4?=
 =?utf-8?B?Y3ZreElVVVdBZW9EMzk3cFJzQ09yZUhlT1MrV0JnVDIveHJ2MjhycThmUUVy?=
 =?utf-8?Q?3fMAFlNp6Jmxhf6L5E=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7491.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bDB1Z3JhRUVGU3ZDNmFSWXZUYURPT2RYdUZYOHdzTjRJeHByRUpia2pZc0Zr?=
 =?utf-8?B?WVdIRGZBblpoNE5nR1YyNkpUT0pBY1ZvU3g1WnZEY3JLUTREMGF2TUw3bWZY?=
 =?utf-8?B?dFBqYmlkTGhGVGp5TTNVb3lYdWZvTGFIWDd1OXRvSm9aU09VZ0xZa3MrSU8v?=
 =?utf-8?B?aUZ1L2VlOWVoc0h2aGlhSHJkZDFMM0creGFsT0wvWjcvRUovV1J0Z3YxWTBH?=
 =?utf-8?B?V0ZkS1VlWFhlMFlmOFJYbW9hMldLeVMzUUE3V3BrYjRqbzZiQjJueWw4SGt3?=
 =?utf-8?B?VDRkREUxaTdYQWV0WmwyTGVFL29yT2NGVmROakhiWFlnWkZMLzFzUHZ0R3Fh?=
 =?utf-8?B?VTgvZXdWZVIreVNldUQxV1Ixd0N0RlBYQ3gyN1hlS3lGTzBrSVJWajZjdW5p?=
 =?utf-8?B?M0lCazZTaEFjVHh4T2cyQU56RTk0ZmNOK0FwUWZISlNGdGN4cUtVMGhsbWMv?=
 =?utf-8?B?ZXhBR3Z0UXBaMWlVa2NMR3dBVlRyYnZKVVhzVWlWcEFuaVl3TVBTYVpzTXZo?=
 =?utf-8?B?allyUnhrTEZGWTJIeGNSc256L2hFUUFqZVkwVmFlQ3ZpYnpURGkrZWlRK1pj?=
 =?utf-8?B?NFpORHAxdUc5TjZ6S1dYaGVSREV6R3BTdTVPSFVMTytSZjJubzBHKzBub2NU?=
 =?utf-8?B?ZzcxdE02Z2xCTFpvbkJnenRxcXRXVlNWN2I4eksxc0JTbzNUUHA0Ym9PY3E5?=
 =?utf-8?B?M2d6MjZuS1RZZzlPVXRhRy9rZHk0VEJPcDBzUDdwS09XVVRuQnNWQjVnMTUv?=
 =?utf-8?B?c3VRSVFicS9qQXlGdm12ZU1zR3BxOTB0dHFRNWhENE9jdmtndk02a1ZsM3Np?=
 =?utf-8?B?V3gweVR1aXUvNEtoMlQ3V0xTempObFAzd2wzT0R3aURXc2xRSUcrQlZkbzZm?=
 =?utf-8?B?bUZxV1RMdFlIMy90WVllM1NMeE9URUtJeW9IRzdUVCtIMENHK3lCd1krRlg3?=
 =?utf-8?B?ZFo3QVR5U2UxL1VFVnlQRW0vVlFmejRJbExPUnliT3ZRbVZKZmV5eW1IZGRi?=
 =?utf-8?B?d2ZtUDY4Ni8wU2NtQzJ1SnhxMGc2bXNzWkJkQndhcXdCbFhoUDNURFVtV3Fk?=
 =?utf-8?B?NW5COFc3OW95a3dneUhSaVJRUmZMUC8vSm9XVTNZY3dZbVFMMU1LMUFRM1BF?=
 =?utf-8?B?ejI0eTFqeHE5MkxZZTZsQUJnempFaWRvYXhVL1F5ejh2NzUrOTBZcHcrb3pY?=
 =?utf-8?B?U2dNYkhYcUN5YW9kVEg2L1BDTXZHbFZtV2hZUWlxZ0Y1SnJUdjFxRGMxdFVJ?=
 =?utf-8?B?NDVzTis1MlY3RGhaQlNLNjd3NVNWNmxqRUtBOWZGYmJrazdwd3AxM3lKTWNM?=
 =?utf-8?B?UFVEQ0hWUEIvNllMaFhzNU90RWJZOTMvOGF4dks1TmNIeTlaZG9hU0pJLys2?=
 =?utf-8?B?NXgzenpMdEhoNzBHWDJFK1RVOUpUbzJ3VUpQVmZGQjcvVkJ3dDFsMmlFSWpB?=
 =?utf-8?B?Z2xyZzhDem9lU2ZabWJvTlR4TGJ3YmhqMEtYZFVCWHZzOVFKQS9sNFdZb3FY?=
 =?utf-8?B?ZFFFSWpyQVJOdWZ0WjJjNmFsa0QyMS9VblRpYmxHNVJkdlREWE96aHpKSWRF?=
 =?utf-8?B?WlVuSjAxY0FpbUFuNC9oR0VYZ0dvMVFlUUptQnFXSE92a09GaTV6OTZXTGxa?=
 =?utf-8?B?VlltNHc4SUlYaFF4aGwzVTA5YnBzT3lqOHY2TDB3RkZ1dm1ZZ1NTTFk0Y25R?=
 =?utf-8?B?UmQyTlJrWDNnOVpnUlZ4Ty9rSHlQRnpNTjJOYjh6dS9Oa3RWK2RjY1pvUHZW?=
 =?utf-8?B?TE1sWjQxN2w2VU5yT3NtTHpxZFpZSjJRbkxxSkgxUU4xNkhwK0lPeWpTdjZO?=
 =?utf-8?B?RlIwOUlaam5wSlo1dFNCUHoxR0xGRjhuRlpZeEUwYkJKMEN6MDV1akxTcEZM?=
 =?utf-8?B?VmJSOXJOZmZCQUhheEF2ZCtQWkUxalMyUFlHSHZPTUhYRW1rZkRmc1ltY2E2?=
 =?utf-8?B?dGh2Q1dMMnZtbXJ1bHFCY2NhclUwWHJmQ2JObXJUYlRZNkQ1eFRlelRXR0Iw?=
 =?utf-8?B?L3YyOUtoblI5UUx0amU2WjJvOUJrYUkwUFM0aFQ1d1N4SEdxTFZ3ZnhpSjBt?=
 =?utf-8?B?cUt5dVQxSmNDaWR6UXF5UVdLV3RURkh4Z2FQUmxjTEZDOU5JckZsV0E0RXMz?=
 =?utf-8?Q?oGvFfTdRxWplhGolpSTRD5RgF?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 533a2691-b00f-4b7b-4f51-08dcf8418b88
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7491.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2024 17:45:57.9614 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j/qocsw60abAbGPyhNV1rMICE/eQCUfGWdKNxaKxE/ucMzCyb2Atd8hONJPSHS1OVeX6eeVsVXUBfufUezqhNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8300
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


On 2024-10-28 15:11, Alex Deucher wrote:
> On Thu, Oct 24, 2024 at 10:36 PM <boyuan.zhang@amd.com> wrote:
>> From: Boyuan Zhang <boyuan.zhang@amd.com>
>>
>> Add an instance parameter to amdgpu_dpm_set_powergating_by_smu() function,
>> and use the instance to call set_powergating_by_smu().
>>
>> v2: remove duplicated functions.
>>
>> remove for-loop in amdgpu_dpm_set_powergating_by_smu(), and temporarily
>> move it to amdgpu_dpm_enable_vcn(), in order to keep the exact same logic
>> as before, until further separation in next patch.
>>
>> Signed-off-by: Boyuan Zhang <boyuan.zhang@amd.com>
>> Acked-by: Christian König <christian.koenig@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c    | 14 +++---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  2 +-
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c    |  4 +-
>>   drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c      |  2 +-
>>   drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c    |  2 +-
>>   drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c     |  4 +-
>>   drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c      |  6 +--
>>   drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c      |  4 +-
>>   drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c      |  4 +-
>>   drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c      |  4 +-
>>   drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c      |  4 +-
>>   drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c    |  4 +-
>>   drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c    |  4 +-
>>   drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c    |  4 +-
>>   drivers/gpu/drm/amd/pm/amdgpu_dpm.c        | 51 +++++++++++++++++-----
>>   drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h    |  3 +-
>>   16 files changed, 73 insertions(+), 43 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c
>> index ec5e0dcf8613..769200cda626 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c
>> @@ -140,7 +140,7 @@ static int acp_poweroff(struct generic_pm_domain *genpd)
>>           * 2. power off the acp tiles
>>           * 3. check and enter ulv state
>>           */
>> -       amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE_ACP, true);
>> +       amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE_ACP, true, 0);
>>          return 0;
>>   }
>>
>> @@ -157,7 +157,7 @@ static int acp_poweron(struct generic_pm_domain *genpd)
>>           * 2. turn on acp clock
>>           * 3. power on acp tiles
>>           */
>> -       amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE_ACP, false);
>> +       amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE_ACP, false, 0);
>>          return 0;
>>   }
>>
>> @@ -236,7 +236,7 @@ static int acp_hw_init(struct amdgpu_ip_block *ip_block)
>>                              ip_block->version->major, ip_block->version->minor);
>>          /* -ENODEV means board uses AZ rather than ACP */
>>          if (r == -ENODEV) {
>> -               amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE_ACP, true);
>> +               amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE_ACP, true, 0);
>>                  return 0;
>>          } else if (r) {
>>                  return r;
>> @@ -508,7 +508,7 @@ static int acp_hw_fini(struct amdgpu_ip_block *ip_block)
>>
>>          /* return early if no ACP */
>>          if (!adev->acp.acp_genpd) {
>> -               amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE_ACP, false);
>> +               amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE_ACP, false, 0);
>>                  return 0;
>>          }
>>
>> @@ -565,7 +565,7 @@ static int acp_suspend(struct amdgpu_ip_block *ip_block)
>>
>>          /* power up on suspend */
>>          if (!adev->acp.acp_cell)
>> -               amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE_ACP, false);
>> +               amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE_ACP, false, 0);
>>          return 0;
>>   }
>>
>> @@ -575,7 +575,7 @@ static int acp_resume(struct amdgpu_ip_block *ip_block)
>>
>>          /* power down again on resume */
>>          if (!adev->acp.acp_cell)
>> -               amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE_ACP, true);
>> +               amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE_ACP, true, 0);
>>          return 0;
>>   }
>>
>> @@ -596,7 +596,7 @@ static int acp_set_powergating_state(void *handle,
>>          struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>>          bool enable = (state == AMD_PG_STATE_GATE);
>>
>> -       amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE_ACP, enable);
>> +       amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE_ACP, enable, 0);
>>
>>          return 0;
>>   }
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> index 6c0ff1c2ae4c..2924fa15b74b 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> @@ -3469,7 +3469,7 @@ static void amdgpu_device_delay_enable_gfx_off(struct work_struct *work)
>>          WARN_ON_ONCE(adev->gfx.gfx_off_state);
>>          WARN_ON_ONCE(adev->gfx.gfx_off_req_count);
>>
>> -       if (!amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE_GFX, true))
>> +       if (!amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE_GFX, true, 0))
>>                  adev->gfx.gfx_off_state = true;
>>   }
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
>> index e96984c53e72..0c3249db2f98 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
>> @@ -787,7 +787,7 @@ void amdgpu_gfx_off_ctrl(struct amdgpu_device *adev, bool enable)
>>                          /* If going to s2idle, no need to wait */
>>                          if (adev->in_s0ix) {
>>                                  if (!amdgpu_dpm_set_powergating_by_smu(adev,
>> -                                               AMD_IP_BLOCK_TYPE_GFX, true))
>> +                                               AMD_IP_BLOCK_TYPE_GFX, true, 0))
>>                                          adev->gfx.gfx_off_state = true;
>>                          } else {
>>                                  schedule_delayed_work(&adev->gfx.gfx_off_delay_work,
>> @@ -799,7 +799,7 @@ void amdgpu_gfx_off_ctrl(struct amdgpu_device *adev, bool enable)
>>                          cancel_delayed_work_sync(&adev->gfx.gfx_off_delay_work);
>>
>>                          if (adev->gfx.gfx_off_state &&
>> -                           !amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE_GFX, false)) {
>> +                           !amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE_GFX, false, 0)) {
>>                                  adev->gfx.gfx_off_state = false;
>>
>>                                  if (adev->gfx.funcs->init_spm_golden) {
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
>> index 480c41ee947e..9f5a5b2e6de6 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
>> @@ -5314,7 +5314,7 @@ static void gfx_v8_0_enable_gfx_static_mg_power_gating(struct amdgpu_device *ade
>>              (adev->asic_type == CHIP_POLARIS12) ||
>>              (adev->asic_type == CHIP_VEGAM))
>>                  /* Send msg to SMU via Powerplay */
>> -               amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE_GFX, enable);
>> +               amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE_GFX, enable, 0);
>>
>>          WREG32_FIELD(RLC_PG_CNTL, STATIC_PER_CU_PG_ENABLE, enable ? 1 : 0);
>>   }
>> diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c
>> index e9a6f33ca710..243eabda0607 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c
>> @@ -356,7 +356,7 @@ static void mmhub_v1_0_update_power_gating(struct amdgpu_device *adev,
>>          if (adev->pg_flags & AMD_PG_SUPPORT_MMHUB)
>>                  amdgpu_dpm_set_powergating_by_smu(adev,
>>                                                    AMD_IP_BLOCK_TYPE_GMC,
>> -                                                 enable);
>> +                                                 enable, 0);
>>   }
>>
>>   static int mmhub_v1_0_gart_enable(struct amdgpu_device *adev)
>> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
>> index c1f98f6cf20d..3f5959557727 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
>> @@ -1956,7 +1956,7 @@ static int sdma_v4_0_hw_init(struct amdgpu_ip_block *ip_block)
>>          struct amdgpu_device *adev = ip_block->adev;
>>
>>          if (adev->flags & AMD_IS_APU)
>> -               amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE_SDMA, false);
>> +               amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE_SDMA, false, 0);
>>
>>          if (!amdgpu_sriov_vf(adev))
>>                  sdma_v4_0_init_golden_registers(adev);
>> @@ -1983,7 +1983,7 @@ static int sdma_v4_0_hw_fini(struct amdgpu_ip_block *ip_block)
>>          sdma_v4_0_enable(adev, false);
>>
>>          if (adev->flags & AMD_IS_APU)
>> -               amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE_SDMA, true);
>> +               amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE_SDMA, true, 0);
>>
>>          return 0;
>>   }
>> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
>> index 10e99c926fb8..511d76e188f2 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
>> @@ -303,7 +303,7 @@ static int vcn_v1_0_suspend(struct amdgpu_ip_block *ip_block)
>>          idle_work_unexecuted = cancel_delayed_work_sync(&adev->vcn.idle_work);
>>          if (idle_work_unexecuted) {
>>                  if (adev->pm.dpm_enabled)
>> -                       amdgpu_dpm_enable_uvd(adev, false);
>> +                       amdgpu_dpm_enable_vcn(adev, false);
>>          }
>>
>>          r = vcn_v1_0_hw_fini(ip_block);
>> @@ -1856,7 +1856,7 @@ static void vcn_v1_0_idle_work_handler(struct work_struct *work)
>>          if (fences == 0) {
>>                  amdgpu_gfx_off_ctrl(adev, true);
>>                  if (adev->pm.dpm_enabled)
>> -                       amdgpu_dpm_enable_uvd(adev, false);
>> +                       amdgpu_dpm_enable_vcn(adev, false);
>>                  else
>>                          amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VCN,
>>                                 AMD_PG_STATE_GATE);
>> @@ -1886,7 +1886,7 @@ void vcn_v1_0_set_pg_for_begin_use(struct amdgpu_ring *ring, bool set_clocks)
>>          if (set_clocks) {
>>                  amdgpu_gfx_off_ctrl(adev, false);
>>                  if (adev->pm.dpm_enabled)
>> -                       amdgpu_dpm_enable_uvd(adev, true);
>> +                       amdgpu_dpm_enable_vcn(adev, true);
>>                  else
>>                          amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VCN,
>>                                 AMD_PG_STATE_UNGATE);
>> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
>> index e0322cbca3ec..697822abf3fc 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
>> @@ -978,7 +978,7 @@ static int vcn_v2_0_start(struct amdgpu_device *adev)
>>          int i, j, r;
>>
>>          if (adev->pm.dpm_enabled)
>> -               amdgpu_dpm_enable_uvd(adev, true);
>> +               amdgpu_dpm_enable_vcn(adev, true);
>>
>>          if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG)
>>                  return vcn_v2_0_start_dpg_mode(adev, adev->vcn.indirect_sram);
>> @@ -1235,7 +1235,7 @@ static int vcn_v2_0_stop(struct amdgpu_device *adev)
>>
>>   power_off:
>>          if (adev->pm.dpm_enabled)
>> -               amdgpu_dpm_enable_uvd(adev, false);
>> +               amdgpu_dpm_enable_vcn(adev, false);
>>
>>          return 0;
>>   }
>> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
>> index 6aa08281d094..0afbcf72cd51 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
>> @@ -1013,7 +1013,7 @@ static int vcn_v2_5_start(struct amdgpu_device *adev)
>>          int i, j, k, r;
>>
>>          if (adev->pm.dpm_enabled)
>> -               amdgpu_dpm_enable_uvd(adev, true);
>> +               amdgpu_dpm_enable_vcn(adev, true);
>>
>>          for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
>>                  if (adev->vcn.harvest_config & (1 << i))
>> @@ -1486,7 +1486,7 @@ static int vcn_v2_5_stop(struct amdgpu_device *adev)
>>          }
>>
>>          if (adev->pm.dpm_enabled)
>> -               amdgpu_dpm_enable_uvd(adev, false);
>> +               amdgpu_dpm_enable_vcn(adev, false);
>>
>>          return 0;
>>   }
>> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
>> index 6732ad7f16f5..b28aad37d9ed 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
>> @@ -1142,7 +1142,7 @@ static int vcn_v3_0_start(struct amdgpu_device *adev)
>>          int i, j, k, r;
>>
>>          if (adev->pm.dpm_enabled)
>> -               amdgpu_dpm_enable_uvd(adev, true);
>> +               amdgpu_dpm_enable_vcn(adev, true);
>>
>>          for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
>>                  if (adev->vcn.harvest_config & (1 << i))
>> @@ -1633,7 +1633,7 @@ static int vcn_v3_0_stop(struct amdgpu_device *adev)
>>          }
>>
>>          if (adev->pm.dpm_enabled)
>> -               amdgpu_dpm_enable_uvd(adev, false);
>> +               amdgpu_dpm_enable_vcn(adev, false);
>>
>>          return 0;
>>   }
>> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
>> index 5512259cac79..d87850dec27c 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
>> @@ -1089,7 +1089,7 @@ static int vcn_v4_0_start(struct amdgpu_device *adev)
>>          int i, j, k, r;
>>
>>          if (adev->pm.dpm_enabled)
>> -               amdgpu_dpm_enable_uvd(adev, true);
>> +               amdgpu_dpm_enable_vcn(adev, true);
>>
>>          for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
>>                  if (adev->vcn.harvest_config & (1 << i))
>> @@ -1615,7 +1615,7 @@ static int vcn_v4_0_stop(struct amdgpu_device *adev)
>>          }
>>
>>          if (adev->pm.dpm_enabled)
>> -               amdgpu_dpm_enable_uvd(adev, false);
>> +               amdgpu_dpm_enable_vcn(adev, false);
>>
>>          return 0;
>>   }
>> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
>> index 0d5c94bfc0ef..6fc52a1bda31 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
>> @@ -1092,7 +1092,7 @@ static int vcn_v4_0_3_start(struct amdgpu_device *adev)
>>          uint32_t tmp;
>>
>>          if (adev->pm.dpm_enabled)
>> -               amdgpu_dpm_enable_uvd(adev, true);
>> +               amdgpu_dpm_enable_vcn(adev, true);
>>
>>          for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
>>                  if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) {
>> @@ -1366,7 +1366,7 @@ static int vcn_v4_0_3_stop(struct amdgpu_device *adev)
>>          }
>>   Done:
>>          if (adev->pm.dpm_enabled)
>> -               amdgpu_dpm_enable_uvd(adev, false);
>> +               amdgpu_dpm_enable_vcn(adev, false);
>>
>>          return 0;
>>   }
>> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
>> index 71961fb3f7ff..398191a48446 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
>> @@ -1001,7 +1001,7 @@ static int vcn_v4_0_5_start(struct amdgpu_device *adev)
>>          int i, j, k, r;
>>
>>          if (adev->pm.dpm_enabled)
>> -               amdgpu_dpm_enable_uvd(adev, true);
>> +               amdgpu_dpm_enable_vcn(adev, true);
>>
>>          for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
>>                  if (adev->vcn.harvest_config & (1 << i))
>> @@ -1278,7 +1278,7 @@ static int vcn_v4_0_5_stop(struct amdgpu_device *adev)
>>          }
>>
>>          if (adev->pm.dpm_enabled)
>> -               amdgpu_dpm_enable_uvd(adev, false);
>> +               amdgpu_dpm_enable_vcn(adev, false);
>>
>>          return 0;
>>   }
>> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
>> index fe2cc1a80c13..58f0611b8fb4 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
>> @@ -762,7 +762,7 @@ static int vcn_v5_0_0_start(struct amdgpu_device *adev)
>>          int i, j, k, r;
>>
>>          if (adev->pm.dpm_enabled)
>> -               amdgpu_dpm_enable_uvd(adev, true);
>> +               amdgpu_dpm_enable_vcn(adev, true);
>>
>>          for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
>>                  if (adev->vcn.harvest_config & (1 << i))
>> @@ -1009,7 +1009,7 @@ static int vcn_v5_0_0_stop(struct amdgpu_device *adev)
>>          }
>>
>>          if (adev->pm.dpm_enabled)
>> -               amdgpu_dpm_enable_uvd(adev, false);
>> +               amdgpu_dpm_enable_vcn(adev, false);
>>
>>          return 0;
>>   }
>> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
>> index bcedbeec082f..8531e0993b17 100644
>> --- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
>> +++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
>> @@ -70,13 +70,18 @@ int amdgpu_dpm_get_mclk(struct amdgpu_device *adev, bool low)
>>          return ret;
>>   }
>>
>> -int amdgpu_dpm_set_powergating_by_smu(struct amdgpu_device *adev, uint32_t block_type, bool gate)
>> +int amdgpu_dpm_set_powergating_by_smu(struct amdgpu_device *adev,
>> +                                      uint32_t block_type,
>> +                                      bool gate,
>> +                                      int inst)
>>   {
>>          int ret = 0;
>>          const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
>>          enum ip_power_state pwr_state = gate ? POWER_STATE_OFF : POWER_STATE_ON;
>> +       bool is_vcn = (block_type == AMD_IP_BLOCK_TYPE_UVD || block_type == AMD_IP_BLOCK_TYPE_VCN);
>>
>> -       if (atomic_read(&adev->pm.pwr_state[block_type]) == pwr_state) {
>> +       if (atomic_read(&adev->pm.pwr_state[block_type]) == pwr_state &&
>> +                       (!is_vcn || adev->vcn.num_vcn_inst == 1)) {
>>                  dev_dbg(adev->dev, "IP block%d already in the target %s state!",
>>                                  block_type, gate ? "gate" : "ungate");
>>                  return 0;
>> @@ -98,11 +103,9 @@ int amdgpu_dpm_set_powergating_by_smu(struct amdgpu_device *adev, uint32_t block
>>                                  (adev)->powerplay.pp_handle, block_type, gate, 0));
>>                  break;
>>          case AMD_IP_BLOCK_TYPE_VCN:
>> -               if (pp_funcs && pp_funcs->set_powergating_by_smu) {
>> -                       for (int i = 0; i < adev->vcn.num_vcn_inst; i++)
>> -                               ret = (pp_funcs->set_powergating_by_smu(
>> -                                       (adev)->powerplay.pp_handle, block_type, gate, i));
>> -               }
>> +               if (pp_funcs && pp_funcs->set_powergating_by_smu)
>> +                       ret = (pp_funcs->set_powergating_by_smu(
>> +                               (adev)->powerplay.pp_handle, block_type, gate, inst));
>>                  break;
>>          default:
>>                  break;
>> @@ -572,12 +575,38 @@ void amdgpu_dpm_enable_uvd(struct amdgpu_device *adev, bool enable)
>>                  return;
>>          }
>>
>> -       ret = amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE_UVD, !enable);
>> +       ret = amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE_UVD, !enable, 0);
>>          if (ret)
>>                  DRM_ERROR("Dpm %s uvd failed, ret = %d. \n",
>>                            enable ? "enable" : "disable", ret);
>>   }
>>
>> +void amdgpu_dpm_enable_vcn(struct amdgpu_device *adev, bool enable)
>> +{
>> +       int ret = 0;
>> +
>> +       if (adev->family == AMDGPU_FAMILY_SI) {
>> +               mutex_lock(&adev->pm.mutex);
>> +               if (enable) {
>> +                       adev->pm.dpm.uvd_active = true;
>> +                       adev->pm.dpm.state = POWER_STATE_TYPE_INTERNAL_UVD;
>> +               } else {
>> +                       adev->pm.dpm.uvd_active = false;
>> +               }
>> +               mutex_unlock(&adev->pm.mutex);
>> +
>> +               amdgpu_dpm_compute_clocks(adev);
>> +               return;
>> +       }
> The SI logic can be dropped.  There are no SI parts with VCN.
>
> Alex


Good catch! Fixed and re-posted! Thanks!

Boyuan


>
>> +
>> +       for (int i = 0; i < adev->vcn.num_vcn_inst; i++) {
>> +               ret = amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE_VCN, !enable, i);
>> +               if (ret)
>> +                       DRM_ERROR("Dpm %s uvd failed, ret = %d. \n",
>> +                                 enable ? "enable" : "disable", ret);
>> +       }
>> +}
>> +
>>   void amdgpu_dpm_enable_vce(struct amdgpu_device *adev, bool enable)
>>   {
>>          int ret = 0;
>> @@ -597,7 +626,7 @@ void amdgpu_dpm_enable_vce(struct amdgpu_device *adev, bool enable)
>>                  return;
>>          }
>>
>> -       ret = amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE_VCE, !enable);
>> +       ret = amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE_VCE, !enable, 0);
>>          if (ret)
>>                  DRM_ERROR("Dpm %s vce failed, ret = %d. \n",
>>                            enable ? "enable" : "disable", ret);
>> @@ -607,7 +636,7 @@ void amdgpu_dpm_enable_jpeg(struct amdgpu_device *adev, bool enable)
>>   {
>>          int ret = 0;
>>
>> -       ret = amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE_JPEG, !enable);
>> +       ret = amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE_JPEG, !enable, 0);
>>          if (ret)
>>                  DRM_ERROR("Dpm %s jpeg failed, ret = %d. \n",
>>                            enable ? "enable" : "disable", ret);
>> @@ -617,7 +646,7 @@ void amdgpu_dpm_enable_vpe(struct amdgpu_device *adev, bool enable)
>>   {
>>          int ret = 0;
>>
>> -       ret = amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE_VPE, !enable);
>> +       ret = amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE_VPE, !enable, 0);
>>          if (ret)
>>                  DRM_ERROR("Dpm %s vpe failed, ret = %d.\n",
>>                            enable ? "enable" : "disable", ret);
>> diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
>> index f5bf41f21c41..e7c84d4a431a 100644
>> --- a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
>> +++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
>> @@ -393,7 +393,7 @@ int amdgpu_dpm_get_apu_thermal_limit(struct amdgpu_device *adev, uint32_t *limit
>>   int amdgpu_dpm_set_apu_thermal_limit(struct amdgpu_device *adev, uint32_t limit);
>>
>>   int amdgpu_dpm_set_powergating_by_smu(struct amdgpu_device *adev,
>> -                                     uint32_t block_type, bool gate);
>> +                                     uint32_t block_type, bool gate, int inst);
>>
>>   extern int amdgpu_dpm_get_sclk(struct amdgpu_device *adev, bool low);
>>
>> @@ -442,6 +442,7 @@ void amdgpu_pm_acpi_event_handler(struct amdgpu_device *adev);
>>
>>   void amdgpu_dpm_compute_clocks(struct amdgpu_device *adev);
>>   void amdgpu_dpm_enable_uvd(struct amdgpu_device *adev, bool enable);
>> +void amdgpu_dpm_enable_vcn(struct amdgpu_device *adev, bool enable);
>>   void amdgpu_dpm_enable_vce(struct amdgpu_device *adev, bool enable);
>>   void amdgpu_dpm_enable_jpeg(struct amdgpu_device *adev, bool enable);
>>   void amdgpu_dpm_enable_vpe(struct amdgpu_device *adev, bool enable);
>> --
>> 2.34.1
>>
