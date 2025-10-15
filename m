Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6D76CCD185
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Oct 2025 20:58:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5DCA310E8F4;
	Wed, 15 Oct 2025 20:58:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LbF5x6uB";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010056.outbound.protection.outlook.com [52.101.201.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A0EC710E8F4
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Oct 2025 20:58:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DufD5Tr3ZEwmL+lgnagwr5hUyKQt87HYlz/nFQ1mslQMIk04ogL9jS5dvzvT+DGeol5t90Hul8ocUctiCDbSlNa/ivjEI1+eQk7molPwpHOtchC6kYbPRBLAmXMQ1XvdH809kR20xcWnBkbYrLqz9QbU5zmcv4EkdE9lnzr9F3IK8URwEFynPrKWUfUzH28n35V3dJM3XvhFx4y2nmexz4MIAE0IqfyAC+LFu9NF9hp7Vl2PIUwLqn2bLKTEMXT+e2aitengQKSswSrpeTdlfsO1PSxwi1Mf9QeYTJ0vrPA2Amed3pJwc6bzgHOl/JtQ2zhm/+RYjxclSSbMI5h4mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H32DHIF+O54mISh+5J8owUven9oLvRNIXcLU4d/ZzKI=;
 b=IsBHDgisHk4XTXuGxIB7v2BBRM0qY1CpM7yROyx2ho6CYjOxw5wdv5F7whTIBfWN5a+Y8XNJKuFDK01j6nqJd6R247KYFHcoSCIJ2DN9WQJjTSu3KCzNJ/259lZc2t70z+hzn0khDI9bDNY+nirLY3rPgqmOchkYbfwwmjWaMNYXdS5HLvWOXWyZsRlxQiDFh9mY8yUJJxnAkdXLnkWF+rtyNOJV9BdJtsDD5kDBdL5W8TfBmhuh2ORYCp4dmZufYjwbWWkCO7Ikui7AkLeI5GCRFweJMwwhQtbSHf1un1SbDIfk4gE6Uv3fXLgT8spBc0B/JKjOhPHjFnSzhneptQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H32DHIF+O54mISh+5J8owUven9oLvRNIXcLU4d/ZzKI=;
 b=LbF5x6uByPhAKbk6TZ3Ovtn735UkYDM5lwKjxcYiquUFgORUUWOQI7W+EglaW8HE3umtNtHRVWxZSEYpMJbCC2DeX3l/ufkk/ZzRPdh0ipOTVz2WbmKWh9Bn4rMYD/kQbd27A0ALA+ZsXnaZdPEvAsXq5zspm1UUmf6jfy969WI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DS7PR12MB6239.namprd12.prod.outlook.com (2603:10b6:8:95::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.13; Wed, 15 Oct
 2025 20:58:01 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%7]) with mapi id 15.20.9228.009; Wed, 15 Oct 2025
 20:58:01 +0000
Message-ID: <0655e8f6-7e32-47e7-81d7-6c05b38a2a16@amd.com>
Date: Wed, 15 Oct 2025 15:57:02 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] drm/amd/display: Check if display HW is enabled in
 amdgpu_dm_atomic_check()
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Harry Wentland <harry.wentland@amd.com>, amd-gfx@lists.freedesktop.org
References: <20251014193036.595453-1-mario.limonciello@amd.com>
 <20251014193036.595453-2-mario.limonciello@amd.com>
 <CADnq5_P-9F0NsOK_5HG06YP98vqJH+1RXxfEnhnAhQ_U1Q=DNQ@mail.gmail.com>
 <d462f951-1b9d-4390-800f-9af09a7282d5@amd.com>
 <a1465fe4-f17b-4a72-935d-df0105a45e6a@amd.com>
 <6cc92ce5-908a-4b90-93d9-c648a48af49a@amd.com>
 <CADnq5_P_zwJveQ98HJUK5HetJVxWE-+FHYiU-MpVRSB-odV9kQ@mail.gmail.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <CADnq5_P_zwJveQ98HJUK5HetJVxWE-+FHYiU-MpVRSB-odV9kQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN7P220CA0015.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:806:123::20) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|DS7PR12MB6239:EE_
X-MS-Office365-Filtering-Correlation-Id: 0784142d-3ea2-490e-4f51-08de0c2d86e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YXhYdmVKampkSVRLcHI3YWdZSFdzT3oxdnZBelFYN2U3bVVEYUxuVGlvNk1t?=
 =?utf-8?B?SUxTd3c1YjJwZWxqTm9VU0FqM0RqQ3hmVkFOZEZWd1R4S3dURENPMVlXMGdv?=
 =?utf-8?B?WGVCOFZEQkpVeTU2bzQzU2NpcTE1UlYyYWhIcGRXNnR1bTAwTDl3cnRXRGxG?=
 =?utf-8?B?NTBEUXhkcE5NZVF4VVlSNjBjaEg3bUd4ZEhJZzBQa3hFZHB0NWNHaktscEJL?=
 =?utf-8?B?T0c3SFA1R3lTTXl2aWgwZVYzTG1YeXMyZ3QrYmVycHFEM3c4bjIxMlVvY2pq?=
 =?utf-8?B?SXhnMjNoaHoyYWY3NDNLeFRxTk1IYk9BSUhhcEF2MGE2RE41bHJSQTJnMXVN?=
 =?utf-8?B?OXkrSFh1WVNIWmdmY1FubFJiWFhGK3lmbDR5cmlzdTcxNW1xRzRmWHQ1c0tV?=
 =?utf-8?B?K2tvK1c5aDZsM051QVA1aDRvbk5KSnA3dXJHRE9RMUhqRmppTFlaMGxvR2pC?=
 =?utf-8?B?dUU1OEdjR1NiaHZuS3RNVzZxQmlYZXNLL1FDMmFkL04ycUlUaXdSZ0RwN2NK?=
 =?utf-8?B?dTYwbHpWSHczdUVqQ0VHMTlybzFhZ3dGY28vWnVMaXA4MVQvMFNuV2M3QTZG?=
 =?utf-8?B?U2hFWjNKMUEwakRjS0dqWWkwQ1hVbjNjL3BZaGRmTUhUa2k0QWZHRG90MTRn?=
 =?utf-8?B?bGhWSGhialRKdksxZkI1aUNDTisycmhUMlluRGtSTlo3TTJEb29LaUhNUElR?=
 =?utf-8?B?VmpKdy9iOHNOSS9zVUFTRnRINWVnWkxQUFRsdytXckFyVnRHRWhhUHEvaThP?=
 =?utf-8?B?eXVYVm93QlI5NUF6N0kzb1IwZWZyR1RHVjI2VmpzUXhQZGU1N0tlOC94aVpD?=
 =?utf-8?B?NHp3TVBHcHQ1YzZubEpuRlRqS2hFckdVL0cxREpQL0YxSng3OG9QV24yUTIw?=
 =?utf-8?B?aUxZUnJwMnRBVzJRZ2o1ejh6OEM3WnJhSmdKYTFRazQwSzdrc05qUXcvMk5a?=
 =?utf-8?B?cWpqZmJDSTE5ZnV5SzFHbTRWS2dYV0YyM2JKdHZqaytwcWpGTVJTR3NHRFFo?=
 =?utf-8?B?TlRsbEhwSWpEZ25vQSszUzlQbU1BODlWN0lRY2VkY3cxYnUxbjFqamdTWmlG?=
 =?utf-8?B?d0VlR1I2Z2x4UUU2R1o0MmRLZzFCeDRUZXZaYnFPZW01aWE1Vy9GNGNwSEN1?=
 =?utf-8?B?SDRHSStOVm9FalBraWcvVnNRT01QQjEzV2NUbUUwYWZFR2haNkx6ZnlyOTdB?=
 =?utf-8?B?ODRraE9tOWVzdDMwNC8yZXFUQ1lhYzMycnUrQ280K3F1V3RRVFZBbnhnZVJ0?=
 =?utf-8?B?U3VxeGFHTUNqZkszaUp4S0VFSWNWc01LaFA4VVQ3bDZEZG1WSlNxdGZ4azVW?=
 =?utf-8?B?bWorUXp0SHBFOVU3bkszS0M2TWkzaUx2TStCeWE3d1RuRjVtV3cxYitIN3Mx?=
 =?utf-8?B?UWdzSVBEalR1dDFaM2EzcUxBM0JTQlJlQkVOWHRHWTJJSEwwcXZFTHJwakhl?=
 =?utf-8?B?U1NkK0VYaHlDUVpwMytTVHdQYnNlMFdNSWNRbU52bGhqbURwSFdpUk9RMmhz?=
 =?utf-8?B?MHJveEdNWXdqUDFFMzV3QldGWXJIMm1RMFdYRmVJUHpwZjIrS0xhMHF3bG5G?=
 =?utf-8?B?T1EraFp4U3l2OTNHU0Y0TEdqenZLbC9iOXYwaHJqY0RKMWVMdFdWRmorZnpM?=
 =?utf-8?B?RlFBeWlIR3dHU000cVU1ZHAybS9BNmZHaW1wU0xPVjd3UUFIRGc2aWl0TzNT?=
 =?utf-8?B?djZ1eFBxK1Q0RUVJRDk4R2tBd0c4RDRLdzBuUFpvRUFNSEJoRUIwNVFhajBE?=
 =?utf-8?B?eU9ZUWl5WFpKdTRPdUptYlJQa042K1dBL0NQbEFlRE9jQXp3Z1hubWZHL2xX?=
 =?utf-8?B?ZnUxZmgvYmxkWFlQV1c5YThBKzBUNTdMZ3ZraWs0N0xOeElSV011T0JCcDlT?=
 =?utf-8?B?ZDFNZ1ptQzN5cGJLeklyTytyMG81am5URFNKbkxBQjMybU1SMVUxWkhXVmt4?=
 =?utf-8?B?UEgydWVYbVFpRkxVMzVlUjRHaUFsNjh6aXR2YTRQL2dLc0NnemRYRWRLQ1RI?=
 =?utf-8?B?S0VoSW1XYnJnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WDB3UU1adHJadUV2VlpwUEdKZmNYWWM2Z2dKZlJZalNSSmtzUWxCa2gyVFpw?=
 =?utf-8?B?aFVRZ0tSTWFwNkVrQmtUcXAwZG5Wejd0L1ZIdzB5bzVScWxMMTlsS09raGpm?=
 =?utf-8?B?ekthL3hCMDBvakhZVHg2NkJDYzd0aEMxZFJQaEI2dkltMXJqQkJVSDh2c0Mw?=
 =?utf-8?B?ZDF6WXBJc3ZqNEk0NTNqY0QvSk9hMXFva21oYzJ4YVZFbFdNT3VSRjZiMi8y?=
 =?utf-8?B?VklwclVHeWduTFM1SG1ZK2szbmN4bzlOZ05zUktGZ3MvQ3dCaUVrL0NjU0Rh?=
 =?utf-8?B?d2xRQlg0dDRvbHMvaHM0MlRSWjVzTW1PV0wxaW84V2JhMWxMS2h5ZjUvQXFG?=
 =?utf-8?B?U1A3UE1ud241Y2hnOGE3MDBjSU0rUEZlcC92eG0xR29hOEFXZk5nZ0lrWEJ6?=
 =?utf-8?B?NFdYR0FUcEpLUlowZm15MzE3b1B6WGJlSXdpMStKZlFyeG5XcXJ6VkxweGI3?=
 =?utf-8?B?ZWlGbGZhai9Wb095NVcyY3NIeDNwOWZjTnVZMkhjU3RZVGViUzB0MzJ2cUxE?=
 =?utf-8?B?S3k3TWxrWlQzbklTcGZHUDFWeHdPWGhCdjR2YlEwVEt2U2dTMzdYdzVsbzls?=
 =?utf-8?B?eEtya09PNVNaK2YyZTh0M28vRi91Q2ZNaGd2R21zS1RzT3g1Y0g0TENMbTlm?=
 =?utf-8?B?K1lXUExCb29scy9KR2pMbDluTFR5MUxYWUJUS3RtOStSK1duQUowR1lVQVdP?=
 =?utf-8?B?NG5PQW9Ba1lXTit4emw0SHR2d01TTng3cWtidzhEZDQ5ZStkMXRXQzBuTUl6?=
 =?utf-8?B?S2tsTW5JQW9hZElhYmg4cDcveG1VejVLa3RvMDdqOTFpQWpnM2xHRUVxTlJ3?=
 =?utf-8?B?dkViNWdwTHllTXh1M1dXTnMzZHhsOTl0Q3dMQlNMRlhLWXRVUmV5dHhJV1Q1?=
 =?utf-8?B?eVlPTForWXJTUVErQjExMGVRb2F3aHNKT2FxTzkzUVdwMi9XakJnelp3cFk0?=
 =?utf-8?B?M3NEeTB1SENOMy8yRkhhblRyS0VMeDY0UWtiYkNYWkxqelRWc3JpZlVCK0F2?=
 =?utf-8?B?SWRPeDFSK0ZUSkVaYUNDNEJPeng5UVdSK0ZaVjRIRGg0ZmdLWldQUWZqaUtt?=
 =?utf-8?B?b3RQVThJaTZGYmwxbmVWMHhiOUlIOWtuRUJaT2pEcU1ORXV5dlY1TFU0akhx?=
 =?utf-8?B?MW9pcTZLaUZiRUZBU2ZyQ0gvZDRIbEV4a2VzRUMxRUFGbkJQT240NnB5Um5U?=
 =?utf-8?B?clFjb2tOS3FmV0RkbFVSa2M2RGRHbUVobStCR1dqUzNOd1JoVXpZa0lMMGxX?=
 =?utf-8?B?YzRVZXlUOGJCWmMwSm5HaXFuRVRDa21MazV4cGZkbmRGRi8zbTZvcDlpMXV6?=
 =?utf-8?B?OHdnRFhQVEdmcUtvTitKZENBNlljamtHbk92QVplNXhrSFF2SHJMSHhQVTcz?=
 =?utf-8?B?Mlp1SmtRR2tXcVZBME92Z05ENWlUcXh5NExGNDhxTjE4aHh6VFcxMWpBa2xU?=
 =?utf-8?B?bGpDUVc4Y1A4bWJ3VzExNEppdXFJaThlb29xdmtJMHNLUENKSUtWZWxMQWxM?=
 =?utf-8?B?MmVtTnVpNnk1QVJBaUV2ZUtxN1VtdXZEM0VDdGoxci8vU0x5NWhLNDhMblRW?=
 =?utf-8?B?UW5BV0pRTmhQQklYUFAzdlFYTE5qV0ttRHBaTE9kbUNKaTIrME0yaS9PeXlZ?=
 =?utf-8?B?MlY5Y01FR0JBQm5OM1piem41Sk5TeE8vdS90QVRDRkVvK0N5d29tOUVLZzVQ?=
 =?utf-8?B?N0c0cjJXWk5rU1V3aWlVQkE1SmJ2WFFJYmpVUDFtaVR6bzAzL2c2M1dsbmNm?=
 =?utf-8?B?ampvNytKeEZHR3E0NGV5TjJwQ1huSk44Q1NTeUNMSnl0NFhWV1RYMTZYT2p1?=
 =?utf-8?B?MkxKYUdZRTd0Y2pNK2pFbHhtV0NSZEhkdXB2TzB3aGZ6blIxZERlQkt5T0p1?=
 =?utf-8?B?TkkyRWQ4bXhaYkZNSE1mT3J3bC8vTnV5b0IvclA4ODRjY0xsUm1uZUZjU2Zx?=
 =?utf-8?B?L0hnZjJEbEVHREc1bWd4UVZObUtJSWpZcm5Gd0VmSnFiTHUrK3Q5d2VFZWQ0?=
 =?utf-8?B?M2ZiQUFrQy93bEZPSkM3dGtPdTdnd29Ldnd0QkxtUjdzYlJPNEJRTVJNSkEr?=
 =?utf-8?B?MzJRZ1A3d3lXWEJYQk9PMXpYclEwRnUxNlVobkJGeFNseWtjRm9OSGNoWTZX?=
 =?utf-8?Q?YYT+KE3p1tCJSKalkmFSQyZUT?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0784142d-3ea2-490e-4f51-08de0c2d86e0
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2025 20:58:01.1944 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WJiakkAJs+P03lNMRrE/J5BpoWCBwaFULluLwrX6ynQNZi0HwqkwVetffgkz3I+ndKZm0NwJ4bsYYRhfHpon1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6239
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

On 10/15/25 9:52 AM, Alex Deucher wrote:
> On Wed, Oct 15, 2025 at 10:31 AM Mario Limonciello
> <mario.limonciello@amd.com> wrote:
>>
>> On 10/15/25 9:19 AM, Harry Wentland wrote:
>>>
>>>
>>> On 2025-10-14 17:38, Mario Limonciello wrote:
>>>>
>>>>
>>>> On 10/14/2025 4:27 PM, Alex Deucher wrote:
>>>>> On Tue, Oct 14, 2025 at 3:46 PM Mario Limonciello
>>>>> <mario.limonciello@amd.com> wrote:
>>>>>>
>>>>>> [Why]
>>>>>> If userspace hasn't frozen user processes (like systemd does with
>>>>>> user.slice) then an aborted hibernate could give control back to
>>>>>> userspace before display hardware is resumed.  IoW an atomic commit could
>>>>>> be done while the hardware is in D3, which could hang a system.
>>>>>
>>>>> Is there any way to prevent this altogether?
>>>>
>>>> The obvious way is that userspace should be freezing user processes. That's what systemd does.
>>>>
>>>>> This seems like a recipe
>>>>> for trouble for any driver.
>>>>
>>>> If we want to uplevel this kind of check I think we would need some helper to report hardware status into drm and drm would have to call that.
>>>>
>>>> Most distros use systemd, and this only happened in an aborted hibernate.  I guess I'd like to see how much this warning actually comes up before deciding if all that plumbing is worth it.
>>>
>>> I was briefly thinking about a generic solution as well and don't
>>> think it's worth it at this point. This is mostly about internal
>>> driver/HW state.
>>>
>>> Harry
>>
>> FWIW IGT testing seems to have thrown up some problems with this which
>> didn't show up in my unit testing.
>>
>> [  471.261018]  ? drm_atomic_helper_resume+0x2b/0x150 [drm_kms_helper]
>> [  471.261031]  ? dm_resume+0x459/0x8f0 [amdgpu]
>> [  471.261396]  ? amdgpu_ip_block_resume+0x27/0x70 [amdgpu]
>> [  471.261635]  ? dpm_run_callback+0x9c/0x200
>> [  471.261640]  ? device_resume+0x1b4/0x2b0
>> [  471.261645]  drm_atomic_check_only+0x5d9/0x9e0 [drm]
>> [  471.261672]  drm_atomic_commit+0x6d/0xe0 [drm]
>> [  471.261697]  ? __pfx___drm_printfn_info+0x10/0x10 [drm]
>> [  471.261729]  drm_atomic_helper_commit_duplicated_state+0xcd/0xe0
>> [drm_kms_helper]
>> [  471.261739]  drm_atomic_helper_resume+0x93/0x150 [drm_kms_helper]
>> [  471.261751]  dm_resume+0x459/0x8f0 [amdgpu]
>> [  471.262119]  ? preempt_count_add+0x7b/0xc0
>> [  471.262125]  amdgpu_ip_block_resume+0x27/0x70 [amdgpu]
>> [  471.262363]  amdgpu_device_ip_resume_phase3+0x54/0x80 [amdgpu]
>> [  471.262598]  amdgpu_device_resume+0x188/0x3b0 [amdgpu]
>> [  471.262842]  amdgpu_pmops_resume+0x4c/0x90 [amdgpu]
>> [  471.263078]  pci_pm_resume+0x6b/0x100
>>
>> The issue appears to me to be that ip_block->status.hw isn't set again
>> until the end of amdgpu_ip_block_resume().
>>
>> I am tempted to move it before the call to
>> ip_block->version->funcs->resume().
>>
>> Thoughts?
> 
> Then it won't actually reflect the hw state.
> 
> Alex
> 
> 

FWIW I misinterpreted the original issue.  The actual problem was that 
there is no recovery sequence if suspend fails part way through.  From 
the PM core perspective the device is operable, so it never runs the 
restore() sequence like it normally would.

With some contrived failures I experimented with an ASIC reset, unwind 
the suspend sequence and call the whole resume sequence and landed on 
the whole resume sequence is the most scalable and workable approach [1].

[1] 
https://lore.kernel.org/amd-gfx/20251015204920.1305839-1-mario.limonciello@amd.com/T/#u
