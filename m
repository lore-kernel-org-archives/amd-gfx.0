Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C1A9C3ABC9
	for <amd-gfx@archiver.kernel.org>; Thu, 15 May 2025 14:08:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F3D2F10E8BC;
	Thu, 15 May 2025 14:08:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="w7B0zlWE";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2084.outbound.protection.outlook.com [40.107.243.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 14B7F10E8B8
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 May 2025 14:08:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VkgnHZA0ZwzQ/nxYMn8W4lXSHGbItPwNRxMlGRHRKO9zg7zzf8R58BM5TJqDHA7ZrJBEtutg8hAO4fhZV+x9s2eUTnoVSL+h2C8zcIPy1yKG0Sp10qtLC9cBVqVxUpxRc1xRNOMzE336IUBILyKaOGhP6ABkU4x8FZammO4y3WwRj3jQEw0RAfyJgLIXWSYil0GhbodAtVgjaiK37OAeZ8D0CFD1GYZsF93HPKbnM6MS6z+MTA+tb1xI2tmBHQmrcAP6B6cWtX+xgdYiMsJo3SZlgXlJEwkBudRmiI4E1eazCGJxpXvhDWT3z9+hOsfHf2vmBavkRLT6oWnLS0IbCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/DB/Oae0Ntn5ocHCLKo4WsgFuYReKMD9RfWHHvBsHuw=;
 b=NmTPK41uKeXUdFcW2CK6h4Qa3pvILJwh23ogzSmwpaPDFOVDFwoiDii3ONE//TrXZhVXI5hpKqun1TI8p9L0PgQ7de51u0kl4eIfBUCnYkBeL/iDqFvzvKNHAgS05mHFAcCU+V5tXg5QbTiAySRFwxrFpjyK+8dula/RVz0eyVlIKVLEl5elq13O7y/21d8HO/qspNSphkqxCkAtR0wNCe4R17eMbE95KtI521xyRDAb4+t9oz8be8KC94Lj0PEiWQ2jPOkUgM+GPayJLq9f1cEGJ3JQMqk1jKMneK+pnixXSyABzNjG+fx/V0QTOtvbfHqKWdOBHe9+8MXx9NI+HA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/DB/Oae0Ntn5ocHCLKo4WsgFuYReKMD9RfWHHvBsHuw=;
 b=w7B0zlWEpH547h3vl6nglTi6Ko2uqrBnHkDGLLW+myh2P48v0VEPrfuev9TwklsqOMxFdflIIvg1sK2nNKr5f5xC5MWTa51tykxCikQGX8ConovC8KUz8PKQl4gcJMKESEXHcH3Ujabq0CykA9hR+NIFv2yKPtwoSfzbOKh9J9M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5052.namprd12.prod.outlook.com (2603:10b6:408:135::19)
 by IA1PR12MB8335.namprd12.prod.outlook.com (2603:10b6:208:3fa::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.32; Thu, 15 May
 2025 14:08:37 +0000
Received: from BN9PR12MB5052.namprd12.prod.outlook.com
 ([fe80::7714:4f80:f3e1:60cf]) by BN9PR12MB5052.namprd12.prod.outlook.com
 ([fe80::7714:4f80:f3e1:60cf%6]) with mapi id 15.20.8722.031; Thu, 15 May 2025
 14:08:37 +0000
Subject: Re: [PATCH] drm/amdgpu: Fix eviction fence worker race during fd close
To: "Liang, Prike" <Prike.Liang@amd.com>,
 "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>
References: <20250515070751.497828-1-Jesse.Zhang@amd.com>
 <DS7PR12MB6005CC0AA22150DA4B9A6F50FB90A@DS7PR12MB6005.namprd12.prod.outlook.com>
From: "Yadav, Arvind" <arvyadav@amd.com>
Message-ID: <d51c602f-c3da-521f-3105-4b3217263ab5@amd.com>
Date: Thu, 15 May 2025 19:38:31 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
In-Reply-To: <DS7PR12MB6005CC0AA22150DA4B9A6F50FB90A@DS7PR12MB6005.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: PN4PR01CA0070.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:26c::15) To BN9PR12MB5052.namprd12.prod.outlook.com
 (2603:10b6:408:135::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5052:EE_|IA1PR12MB8335:EE_
X-MS-Office365-Filtering-Correlation-Id: 8391febe-7b3d-4a37-2519-08dd93b9fc43
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SlpRMGREcFlaYnljSlAyN1M2N3FRc0psdHVUaXZZRkppeDhCTStKOGxyc3p3?=
 =?utf-8?B?eWIxRzRZQ3R5dE8rN3NKaHVLdHlSbnJEbnVBbVBGa0VLMno1cXd6Szd0RlNk?=
 =?utf-8?B?MU5sSzJuVWNnRUpkMXNoOEtiUEI2TU5vbzdJWTMrcFdHTk8vN1hQRksrS3Yr?=
 =?utf-8?B?WWhJODNVaExDbjlKNmYxNFJtOWtyZHhoK1FCbmVTVnRjaXlReVdxNlhQSkhT?=
 =?utf-8?B?dHlnR3h0aG9JN1Q3QTZ4ZzlUNU1xbWR3M1owMHN1THFiLzRGazdLLzlNZXlx?=
 =?utf-8?B?MG1uNzJRY0pQcG5NSGlPZFVNRTdtT0g5TGE2RnVRYWt3YTRkR1VRUnkzbklK?=
 =?utf-8?B?SkVUZjQ3OE9qcUtvTW1HdllSa3FIWDdheG9hVFF5cDhqdExza015bnpaanNj?=
 =?utf-8?B?ZzJDb29Ta0o1SUdHTjh5MXMyNkFpakttemNGaVJyYUNBak94MmVoZERFODRq?=
 =?utf-8?B?MUVkQmlOT2dscGIrc1hGMUJZQVBVSUpmMkdYQ243M3ZRamRoZ0djNkh0ODZa?=
 =?utf-8?B?TDRLcnNzT0ExYyt3VHpQYU8rck1LNThCM2lIbFhYWFBkOVZ3K2dQK01pbFpz?=
 =?utf-8?B?Mnp6UGk4cUhUUHJoWDZtSzY2a3d5QVJlMlpXcjFrb05nNW5GRUs1R1MvNURG?=
 =?utf-8?B?OGdFU25oYm5YVWlZcVkyZzlvU0NHUTF6V3hPZVZPQTRQV1YxRFBQUE10UUZC?=
 =?utf-8?B?eGh3dU1LdDRRQUJsRDhNRDNBU0gyT3A1RGVFY0pjOXBPQmUwTzJNU2N2dEFC?=
 =?utf-8?B?MUZBS1VGU01xVU9qdDNHQWE4QVdiOUd3UWZ2dDFKYlV6b0EyaDNPMC9vRUIz?=
 =?utf-8?B?dWx4ZmhyL21zajlwczVDQzlMTEo5OVJ2dUlZR2JpNkw5VGV2WDltNDViaUtL?=
 =?utf-8?B?Y3lCeTNiUmxENVBUL1pjc1VWWmJwbndjVFQ3Nm9oZ3g5S1F4L0QrVkFjZ204?=
 =?utf-8?B?b3Y3UkQ0RUkrUEdpNVRxTjVnNXJMNnJ0WFNOSnNzdEFtcENYWDU3YXVQOGI5?=
 =?utf-8?B?eXkrUFNXc0dWeWdqaUJFdElTSEZPaTRTL3FKYlFDU0x2Und3RjU0MGViVDR0?=
 =?utf-8?B?cGJvaWpNL3N0VUk1RXV3NmVyQXpsaHluQTJBT0gxMGx1blA1QWx6U2FTdnRt?=
 =?utf-8?B?R2Q5Y3JERFlJYzhqbmxoa3dRaWowckhFa1RpbjJIN3V2M0JucVB0U3RPRzk3?=
 =?utf-8?B?RjFvN3dmcjk3c2RicVJHbmdrRkJEdGFiYWlYZ3ArT0tNUzVaVzZCZ2RMVmJV?=
 =?utf-8?B?dHhNcWtFK2lndzdxM0VzM2pOVnRrTHhZbldEbHM1TzJqb1ZVQkJUUTJmMW1w?=
 =?utf-8?B?M3YwZHdhS1R2aUNKaVBVZjNDUWVVNTlhRXV6M2s5L2Vxd2MyOWxjSjdGR1lU?=
 =?utf-8?B?RUFjcmNFa0hxUGV2QXpCQUZvSXVtajYxR3dpR2lBOWZiYXA5QlYzSzFOMWdE?=
 =?utf-8?B?VlppSzBJY21UbkNSckx6eDN2azg5WVMrN0tIK3RaQUtGVlJKZWNUaWtVVUxF?=
 =?utf-8?B?WVpSVEJHQXVPRmlVckxQN1crQkNkZ3RsL01JZHpUbnVTR0dVWkNaVzhtRDRR?=
 =?utf-8?B?c2Y2NklNbjhaUTVjbmh0dzcyejBOVEI1a0hnaVk3eHZGMmhFcmdYbVNMaGNl?=
 =?utf-8?B?Zk9ic3NIdzU0ZW1qNTArZitNcGh6RkxXbnU3RGxjZEcwNXpyYWZxdTBFaEor?=
 =?utf-8?B?K0V6ZWQ0STVSTzg2cjVSSXMrTE1PVklNc1lmNitkOUtVa3c1TUp3L3h3aVJW?=
 =?utf-8?B?R256TFhFYW41ckdrM1h6ak1qOXY2bWdTWE1sTWQ1WnFWYWZVTTllejdVNVdD?=
 =?utf-8?B?YjVGbnNGZWFleVVnZXRvMGJTQVkvUEZmQzA0ZVpsNEViZFZxL0RrWnRQWHNG?=
 =?utf-8?B?TmorWVNTaElTUytOUEYzTGJYcDlIRkJQTEpMYmtDRWpMLytYWm12Y0daS2Iz?=
 =?utf-8?Q?cnYXNLUks+I=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5052.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dFFkdng5NjRjanV2QTBIRWtsR281YkpLT1B4UXljbm5GRzVHVmdDTVFBZ3My?=
 =?utf-8?B?c1kwRDB4WGR0Smthd09UdlZvSmt0TUx1SWw3TVNTMzdEWGNaaS9UQ3FJaHRQ?=
 =?utf-8?B?TEN1aTRKSUJKWEszUXpUMURIVGx5dmRxYjVjWlk3dXpvNEROV0xISnFFd1pw?=
 =?utf-8?B?dlVqRnNFWHVuTVp3NEdXZ2Y0OEFCNzJ4NHJVMURacXdiaGtnZjJVcGUrWUV1?=
 =?utf-8?B?S0ZQTUUwSnlTVGNaSjY3bkdNSWd1TEUrR2xYa0xqdEhBdGRpby96bWs5NzlB?=
 =?utf-8?B?ZDF4NzViaWI2NFA5WHRtL3NSOUsxMXJ6T0ppa3NnZDUrb1YvZEllQjJSU1Fu?=
 =?utf-8?B?RTJPR2plaW1Md1Q5TndmYUxNTUREVUNBcXpRTWxkYzBINVVnMk5Ib1VkNUJX?=
 =?utf-8?B?SEFtNy96a2VqTXdkRW5xUWMrMmQ0K0F4WnFsZ0kzeDgyNnFabU9EWDRJVkRM?=
 =?utf-8?B?QTQvZ1JKZWJIV0lORzU3blZFcXdoUGRWckdBWVM4YzRXQjZCdFNYWTNudC80?=
 =?utf-8?B?R1o3NzdsejFsbHE2NXpsUGFKNUxZNElPQjJqUm9UaStkREdRUmZueHd0UlB6?=
 =?utf-8?B?dzUwUE12eGdMdWFIWXZ6TFkvRW42SExsNnh6WSsreVJtWjduRitYY2NhZ2l1?=
 =?utf-8?B?RzNUWTIwaGF0czBrZmh1dVVWYXFSMTd3YkpjWVhoUXNnQjlZamFmc1RwRE92?=
 =?utf-8?B?TytIbmtVZWh0U1V1aTNrcUJqV25oS3NmV3VRdUExcHp1WXFnaTRVSkhhc1ZF?=
 =?utf-8?B?TjlCajZnM0xGamhaYk8xME1FdjFGbUdxMDMwYjltZW5rVXVtb3MzMTFLZndC?=
 =?utf-8?B?NlpKU0kxMXJzQlVKRkJQcW5KYjA0Slp3aVlwaXR0U3VWMVhYN0hxUXhoZmpy?=
 =?utf-8?B?cUpSVzMxbDF2dXE4QXhlMkNGeEErcHdtT1MvTkVFaFhNc2JmamhUMm8vWlY1?=
 =?utf-8?B?dnFWTFlGRDBjK0JKVGowZUxONngyVHZPT1lnbGloU2lsM2l4cGJFNFQ2MGN1?=
 =?utf-8?B?b2RrSE9Qbm9oaXc4NzFNMG95MDhpMVZva2hmNkk2K0pJbUZLMTNwWmtmY2Jr?=
 =?utf-8?B?Tm1jeEhscFVVZXhsRFIvcy9HWmZ2dnRzZ0hVQnBzRXBKTFpBRXBjQlFEUkZt?=
 =?utf-8?B?YU01U0ZQU2hodnkvczhZeDE3ZkpLcUw3TU1jYi9RRnlFQnRxOEVCYUdWZG5q?=
 =?utf-8?B?M2E4a3Rvc1g1NzArektadkJBL2VsUlh2dkEwQ2RCQTd1YVhNbFYwZXZDbnAz?=
 =?utf-8?B?bkwvZkg3QmtiLzN3WGFVYktDbnF6aDA4YjRsWHVNSmJkRGp4cDJob1FOVzlh?=
 =?utf-8?B?TkFaV0xERE50alRRTzdKKzdkYitudlhiVGJOa0lMKzZhS0NmSXJRUW9zY2Ur?=
 =?utf-8?B?bFlobFFXdDZMYytKWjdiZTdCSTBKNkQxTTllV2ZvaEUxNDNBQzVzbDQxcnBM?=
 =?utf-8?B?ZjZwdklWZ2hjUklwSVlpRVd6ZFFvK2EvYjQ0MnhtVC9MZlVpbXNPakJqMit2?=
 =?utf-8?B?dEJNZGV4ZzRwRHUzZTlsZzMxcUQ4MHVnSWVyTzR6ZUpLUTJFTnRINDdQbWxS?=
 =?utf-8?B?WnNsNlhMSWp4T2NnaVRWRXZ6aTFRUkFSb0lEUDlxbTlyT1FHZWdXMTF6STVl?=
 =?utf-8?B?SEp0QUN4dmFtNmsvQWhXNEV4OW5oUko3bzNvMHRDRGw4WWN5NXNxV0crbndV?=
 =?utf-8?B?ZWN3MUVJWUxkakhsRUNjS2dsYmV0NnlEZmlVM2s2Q2M2NTZJYTNlbnR3K3l3?=
 =?utf-8?B?aFplaHIrTXMxb1YwM1UrK0lNZlpLVk5MVDBDcnJMMHJ4elNqaW95SXVsUDdH?=
 =?utf-8?B?UkZ2QkxpSk5qbUx3QmpMTGNQRm55TVFWRHl6dUpnV3EvOXl5V3V6M1kwRE05?=
 =?utf-8?B?bGt0ejIrZjIwLzFhbE1qelFwT0FRS085Wmk4ZEpRVVl0Y1VsL2JuNWJsc05I?=
 =?utf-8?B?ZlJ5a1RzWGRCVzlhRFNCYzMyb3BrMmR1UmFkSG0zeGhLV0JHSDE3YitlaENz?=
 =?utf-8?B?azhJQmJpZDIrQTY1RjZKMmZZbkg1cHFNYWpjeElkb2xReE5KL29sT0JTeStQ?=
 =?utf-8?B?MzBoYTFNVFp4cU93dXFoQ3pNMENBdjFYdjU3TlBNK3h2dmZpMlJ1dzYxUEIv?=
 =?utf-8?Q?C0Ko6mA37T2XX1GFFrem3PK6m?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8391febe-7b3d-4a37-2519-08dd93b9fc43
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5052.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2025 14:08:37.0680 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CJDm6uBPHH+Vxdbk2g5IplSVCWKNH9YidcDWDOXe7FnkHZTIZ1BFRfSAzcx0N3V+h1uzXuqj3P4NeKHgPUg9mA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8335
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

Reviewed-by: Arvind Yadav <Arvind.Yadav@amd.com>

On 5/15/2025 6:49 PM, Liang, Prike wrote:
> [Public]
>
> [Public]
>
> I haven't cleaned up the userq resource destroy at postclose callback in my last patch, so here please remove the duplicated useq destroy. With that, the change in the patch is
> Reviewed-by: Prike Liang <Prike.Liang@amd.com>
>
> Regards,
>        Prike
>
>> -----Original Message-----
>> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
>> Jesse.Zhang
>> Sent: Thursday, May 15, 2025 3:07 PM
>> To: amd-gfx@lists.freedesktop.org
>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
>> <Christian.Koenig@amd.com>; Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>
>> Subject: [PATCH] drm/amdgpu: Fix eviction fence worker race during fd close
>>
>> The current cleanup order during file descriptor close can lead to a race condition
>> where the eviction fence worker attempts to access a destroyed mutex from the
>> user queue manager:
>>
>> [  517.294055] DEBUG_LOCKS_WARN_ON(lock->magic != lock) [  517.294060]
>> WARNING: CPU: 8 PID: 2030 at kernel/locking/mutex.c:564 [  517.294094]
>> Workqueue: events amdgpu_eviction_fence_suspend_worker [amdgpu]
>>
>> The issue occurs because:
>> 1. We destroy the user queue manager (including its mutex) first 2. Then try to
>> destroy eviction fences which may have pending work 3. The eviction fence worker
>> may try to access the already-destroyed mutex
>>
>> Fix this by reordering the cleanup to:
>> 1. First mark the fd as closing and destroy eviction fences,
>>     which flushes any pending work
>> 2. Then safely destroy the user queue manager after we're certain
>>     no more fence work will be executed
>>
>> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 2 +-
>> drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 2 +-
>>   2 files changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> index 4ddd08ce8885..4db92e0a60da 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> @@ -2913,8 +2913,8 @@ static int amdgpu_drm_release(struct inode *inode,
>> struct file *filp)
>>
>>        if (fpriv) {
>>                fpriv->evf_mgr.fd_closing = true;
>> -             amdgpu_userq_mgr_fini(&fpriv->userq_mgr);
>>                amdgpu_eviction_fence_destroy(&fpriv->evf_mgr);
>> +             amdgpu_userq_mgr_fini(&fpriv->userq_mgr);
>>        }
>>
>>        return drm_release(inode, filp);
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>> index 9fbb04aee97b..1fec3713fbf2 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>> @@ -1504,8 +1504,8 @@ void amdgpu_driver_postclose_kms(struct drm_device
>> *dev,
>>
>>        if (!fpriv->evf_mgr.fd_closing) {
>>                fpriv->evf_mgr.fd_closing = true;
>> -             amdgpu_userq_mgr_fini(&fpriv->userq_mgr);
>>                amdgpu_eviction_fence_destroy(&fpriv->evf_mgr);
>> +             amdgpu_userq_mgr_fini(&fpriv->userq_mgr);
>>        }
>>        amdgpu_ctx_mgr_fini(&fpriv->ctx_mgr);
>>        amdgpu_vm_fini(adev, &fpriv->vm);
>> --
>> 2.49.0
