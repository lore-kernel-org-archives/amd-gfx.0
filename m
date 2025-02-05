Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CADD9C02192
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Feb 2025 04:32:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F4ED10E183;
	Wed,  5 Feb 2025 04:32:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VJNJ3nqB";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2057.outbound.protection.outlook.com [40.107.100.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2319D10E183
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Feb 2025 04:32:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uCIkM9h20t6BAs9WMFpQFivEYHhFfkzwrWQXVMWVujwfm9NqGrYJiXVWefznDxMfWBY7+toGDw90lvoia7vA8LXRA0K4UkbbJnYiMipdpLbaERirwQFGDltvDcJ3hJhiSu4azLKiphsH4UAOwm1xeJ9sJ2kJDVXed8KF3CndSJ6qqWed2n3XDVTfFsOunLY/0qdDDPlOEeueJYpV/CHouSNcDsYQZ/3kfSoGrlCBHVMCyY55k1NQH58I6fZKFaOTp5UvPsNM8Qo8ahZGZ9xHeRBnQpUINVWM8k5r1Q3AxCepF6ucjFA+2Y8z2aO3Hw1I7hahMDteZoBJj/ohIx+thg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D21+D0erK20vdMEyWmwL8X0huffENM/UO+l0ASQVNXg=;
 b=YjwTKKlpGNGfWc9if8pwoMLMvEh6JXtl68UW8dtPdyrENbI1lUX3Bhg5Ho/taR/WqGDao/50GDFNpb9Gvmh6uv1q3U07kSF0ZYySUggTq6btVyTKvmM3OLQ+Ck3N/+ZKu/u3r/AC60PkC90bz5hN1GUAadLvdSbFN026JLl7gfwdZgmkljb/7jdwnjTJCqZZSn5m9gJR0fxnC4TVj+S4t1x+9Bze98ZuIftmp29erg2ZvKIr96twfgppE947N6jQVScknahnb7ni/bgfm8A7fkjz9963rDm4qv80YnFvqIZJJ9s7ePlj8wE927Dk0iwQ4gXwbPYW727Jf40Cb2KHnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D21+D0erK20vdMEyWmwL8X0huffENM/UO+l0ASQVNXg=;
 b=VJNJ3nqBDUJOhUWIPtnL/4/AOSNdFa6+n6xL6xUpFYmJhnaMeSsDK5sfayzrq4BXZglrx5+v9FuCfZHOy9LhEClwUSYDI4eVAPLkRrupC201ydXbPtRa9p0VDBFosvoV79zpu9mdEqWOMMZvm+9Zz9PngoP1rhNYNQ7wVqyXa10=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SJ1PR12MB6313.namprd12.prod.outlook.com (2603:10b6:a03:458::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.23; Wed, 5 Feb
 2025 04:32:04 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.8398.025; Wed, 5 Feb 2025
 04:32:04 +0000
Message-ID: <8dbd2b64-0ef3-4ee0-9e0d-f2d7161d2749@amd.com>
Date: Tue, 4 Feb 2025 22:32:02 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/amdgpu: add support for IP version 11.5.2
To: Ying Li <yingli12@amd.com>, amd-gfx@lists.freedesktop.org,
 ray.huang@amd.com
Cc: Richard <Richardqi.Liang@amd.com>
References: <20250205024837.976890-1-yingli12@amd.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20250205024837.976890-1-yingli12@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0P221CA0038.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:610:11d::24) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SJ1PR12MB6313:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ebc6190-167f-4d02-1391-08dd459e0a67
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dXlWaDVwdURBY0ZpenloTGRmaS9OM3FIWUtiME9wSEhwRjl6VmFYcWUrcSts?=
 =?utf-8?B?aTNGbHZHYnlWUU95T0l6c2ZWV1FHVXQvOEVnbEpVTkFnTTJVdlBUNnF5WmI2?=
 =?utf-8?B?aUtlMEZlaFBUL1VIVmF6REJEc2VWUmNySi94QW9NdDQ4NEFiWEtMcTZPek1m?=
 =?utf-8?B?N3MwUHBCeGd0c3Y1aFVUeEgvU04zK2xDQWh1ZHhyZS9ybjJaSS9jamhsR29X?=
 =?utf-8?B?UFZlVTZ0eXNJbUZXTW9DZks0RktoUG5STm5oTm52bmxIS0V6UUZ3WllWUjVE?=
 =?utf-8?B?bG4wbk5wSEl2UDU4Tnc5cFV2aWZhdnZyTnNudkQ1TmZZYXI1eW9IcVZ4STJv?=
 =?utf-8?B?Q2JNbzRvbk5zRFU5SGRzcWpjc1RKQ2VwTjVDYXQwOXJja1FHWkZvR1A1YkY0?=
 =?utf-8?B?L0NkajBTMlNXUzVpSnZYOVJNbWR1Wm1rY1A5RHRhSE1IUHhaTXhXQVJSQUIv?=
 =?utf-8?B?WVJ2ZlhpclZ5R2hxb25nSThEdnphNmhLMlltdXBlaEhsSTVwNzhNdEhRN1Rr?=
 =?utf-8?B?MHhQdUFuSjNEdG1zOTNIM0E2N1NteXJ1c1pVYndGdXJ3ZExjQUNDazJXTUdx?=
 =?utf-8?B?bUxwcUlNZ0dyZWE5YXFuNE8xb3o5WUwvRkJ0UUoyQlJVSG4zNWd3dElkWFYv?=
 =?utf-8?B?d3o4U0J5UTFhM0xZUmVjODgzb3l1a2dXNzArYjB2MGQyMkdmaHF3UklTSFNE?=
 =?utf-8?B?cGRBdnNRM01aZlM0WkRpVmxsSTl0NlkwSUZxMnhpVEhVZmFZa0s3U1hDSm5U?=
 =?utf-8?B?MGVZeXdqV1pkekJrcloxK2Fna2VrcHl0ZzFkMDFLNzVLZ2hSN3NIOVlUSk1n?=
 =?utf-8?B?RmJWbWk2OUt1dDRXcXcrSUVOZmQxbEp6RXpDTlpjNjEyVlBvM01YY1VDb1A5?=
 =?utf-8?B?MXR5YjRSVGJTWWhETXNncXV2Z3hXTC9jNTlpdUJiQVhxRklWckNDNzZBWFNj?=
 =?utf-8?B?UXNrRFBEYlFad1B1QlgzbEpCcVduWWk0aW13R0dGVm9FVUtSb3ZBZjNHdys3?=
 =?utf-8?B?Wno0N0tKbzMwYk9ZOFIxMVB6NGhuSFIxSjNtQzRMQXBqbkpubzJrRE1ZbVl4?=
 =?utf-8?B?aFdLNzRjQ3ZZU2R4Q2lGYStxbVhBcWZGM0p4dktpbTY4VmZaUk1zYjVLMDli?=
 =?utf-8?B?Vndpbm5Qc2pIV3RDTnhLRDNYT1M3QzNTZld1SE9iSy9pbE9IMFQvRENLdXZy?=
 =?utf-8?B?cm5LZmw1NFhsNS9GQkJvdENWdUxwbGlIMWxTV0ozbXZsRWVGcjJ4YVFEREt1?=
 =?utf-8?B?dkRIb0kzdDh6NlllSEl2MlF3cUJOZVB1SDN6SHNrRXMxeHBlNmluQlVTWlE2?=
 =?utf-8?B?VGtzVmk1RDc1TnhsV1JINjREMGIvVVpVaVlIMjd1dHprU1JzZ25nNkRoM3cv?=
 =?utf-8?B?Ynl3RngrUFBIeUdEbTBFQVdsUDJ1K0JPeHRiSzhJdFI5Qml0OW4vaytWVkxJ?=
 =?utf-8?B?a0ZXcVd4dnB4cXhPOXhwbEMvN0E1WE1jWE5nU0hncFpCOFdWVHY0RnJOandM?=
 =?utf-8?B?R2U3cFhOMk1BNkxFV1hTdE8vRXd6Z2VQd2NhT3oxWlY3czlFRkM5VGFoNHky?=
 =?utf-8?B?Y2tScE1rM3JQcHk4a0dsYWl0SU9PMU9CbHpaTVhDVzJ1TU9wVkxpRE5Zb3c3?=
 =?utf-8?B?U3RicUIraDRSRFlRaFFDZEloUktiZzk5SlZ0eFFOOFlDc0RmTkNpOFdrL1N2?=
 =?utf-8?B?K2wwOVp4c0ZuVTFMLzUvU3owcHlzMG45eFlGWHlTUkc5dGxzRzJIWjRpL2pj?=
 =?utf-8?B?dFcybS8vNE5JWndhYjA3Vit5OG9rcjZIQitLemRSYUprV0M0NDI0MG0zeEE2?=
 =?utf-8?B?Nlh4ZitRT0RHWGNvNXFQWlFzSHpXK2Q3SUQvM3ZBWkNZSkJ5ckhGME82TWR6?=
 =?utf-8?Q?cyzBgNg8TiqEv?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MzlwYXE3QUlYQlhPcDMwTzFOYU10b0Y0anZuRlZNbHFGTHBMZktxVVJYN3N3?=
 =?utf-8?B?K2FvSVpyYkVST0hiODZSTGl2SmpZTnlTeGJ1ZExWMk1DQmtRT0NnNVZ0bXRT?=
 =?utf-8?B?Y0FycTAyVTdWMGhiK2p6ek1semc3RGxEWkdOdUhQaXBCYStWek8yN0VxODdp?=
 =?utf-8?B?SExGZnNud0FiM3J6TGt3dXBpS1RudWgxbG9zZ3YzQjRUeGNaYkhSYm9xeDU3?=
 =?utf-8?B?RWpnTTNUYzlnTGdZNllIMEJzTTlqeGEzZFBEQ05IZGxHKzd2Q3FEYTlKemZX?=
 =?utf-8?B?UEFoSWVkNEVGUnFqT0lJTzdnbk5HSjBYMzhRUlZXOXN3dU9sb2pQb1EzNDh1?=
 =?utf-8?B?elFlVndhTVd6MzVuSlIyaFdpdmdOaGxMOE5ncHdMWVF0dkRDdXBzRUN5cnVY?=
 =?utf-8?B?b0ZmMVhQV0IvdEgwdFhRWm9LM2xQaDFYdU4xa1pjMGxCVmxqVjc4eUhZRkZF?=
 =?utf-8?B?cjJoZVZucDRPOWNyQzVBanU0YklDUE5DWXVHUUhqWGs4TmZIanVpMjh1cTA2?=
 =?utf-8?B?NzZIaVNZajMzZkNuWEFMOHNNWXE1bllnTXFPYUVaOXN6ZjE2eFVUMngrSisw?=
 =?utf-8?B?VlI0MXZWZ1l6SGd0YVhwRXlxNHdqNGEyK0NnZEN3K2Z6bGpteUxqVXc3QnlG?=
 =?utf-8?B?d0tvU0NRL2d3Q1RIMXJYYTZ4SkVSZkNkUmlHVlN1WUhBNjN2aVRkWXZBM3NF?=
 =?utf-8?B?bmtNUVY5dzJDU2JjdmlRTk4rRFJIN2tEQ3UvNTBTMDA0Rm91OEh0eHUxOWl0?=
 =?utf-8?B?WVJGNExON2dJWXNzRjZsd0MvME5xRXM4TmYrZUZTTzFFNElPOXF0dFF1VWJp?=
 =?utf-8?B?WHU2OFA2a0IrOTU0aWh2V2ZuRkl1eFBLRTcrcU1HMzZhR2JkbVh5emd3Vmhs?=
 =?utf-8?B?MXRUb0dIamtHSWtTaEM1UFJqVVAra2U1d1MzYk5oNUgxQS9GdHhEREd0NkFq?=
 =?utf-8?B?bkhtY2V3Zk11NzlqUkR6MENEK3dmM1pLeHUwcklqNm8xL2JHNHdaOWRvVWU1?=
 =?utf-8?B?UW1mQUdETFI4SEVBQjhubDdzeVNBK1orYVZMR3ZyakJPUWxpOUFjR3RxZ3dy?=
 =?utf-8?B?N2xzQUtVblUwS0VhY3lnaitMK0NiZDhUSWZDbGU0em5tc2xmTnhDUnBuSFNB?=
 =?utf-8?B?Um5nek9lU1JWTlU0K3NUUTZUZGozcGxQckQ4UkY1Y3BiRGRhN3JPcitkencx?=
 =?utf-8?B?YjVqYUovUkxsdU5kU3hiSFYreXZtSkhVRlZWQ1NON2VTVkZZY0QyQ0pNR0ox?=
 =?utf-8?B?YU9WMDRWenprcUxrSHlkMnVmR2czRmovQS8zcUNYVEU1SU54ejIvTWJYeWRz?=
 =?utf-8?B?RThtN2FOdWs0ODNQOW9RQmtoT1REbkhSS2YwUmI1Nm9VMHBXZ0hXT2VrN0ow?=
 =?utf-8?B?THh1NUsxVTJSUFgwNDB2WG51S2VYS2l1cGEvK010TWpYenhxTkRWdCtzL1N1?=
 =?utf-8?B?bGQvMVVRZ0ZtczhSeTRXamFpcnRTOW1Qa2QxRG5HbDFPczlIeG1RQXNlRFJz?=
 =?utf-8?B?OW13NTdJOW5pOE1La0cwbGdQU3ZnVUZQRGd5S1hWU25zSlpQUS9RakZYK3dK?=
 =?utf-8?B?VnJvQzdzYitjeTdMLzJYV1d5Vll1aHZrWURXc3hTeHhadlo2WWNBNXQ4NldQ?=
 =?utf-8?B?Ritmc2xtallpdC9pZGd3c1hOcGZMd3BTdHhGUkE1TENWci9qOUE5aG1jTDZN?=
 =?utf-8?B?WHIzYkFPUVNUc3ZGazFJV2U5cEsxck1RMUtpVUdpYkFxZ1RRYkVQbmpzMGg5?=
 =?utf-8?B?NjZxU3dJMm9mOWRDZUIxUVJsSlA2WkJaRHJJK3c1cDhDNU9xQng3cm4yVXha?=
 =?utf-8?B?UUNRRVlMdzVSQWdzbThOb3B3NVA0Zmc4a1puYzlKREtVd0g0SkxzTVRNelZW?=
 =?utf-8?B?L1B3Q0huWEF6UEp3QW95bEc3Qmx5MmFmbjh2QmNTWkM4VWljUXgrT1FiTE9a?=
 =?utf-8?B?ZGFnOTBUbGRNZnYxb0ZvQmhwVHQ5NzVLWkc1VTZvWkw1TnlQbHMzWU1USGYr?=
 =?utf-8?B?ZzlkZUNkeW5vblhEeXNzaGl3QzJLOU9FZVpQRFE4dXMyd0p5bndRZkpkNGZF?=
 =?utf-8?B?K0NPQVNOTW5EZVl0enZtekRFVy9iRTZ3bWY0UUtDS0tyODhsa05wSm1zZ1g0?=
 =?utf-8?Q?jschTeZZN4OVFhf1OAO/XeKbw?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ebc6190-167f-4d02-1391-08dd459e0a67
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 04:32:03.9279 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0WDND05DKm38qzx6TXxQyZlTblOHlNikxu2YhPJ5ABWN56p+zjcHTz0/m1B/w89aw8Js6CAayhtHdwJWCB2oUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6313
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

On 2/4/2025 20:48, Ying Li wrote:
> This initializes drm/amdgpu IP version 11.5.2
> 
> Signed-off-by: YING LI <yingli12@amd.com>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 3 +++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c       | 1 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c     | 1 +
>   drivers/gpu/drm/amd/amdgpu/nv.c               | 1 +
>   drivers/gpu/drm/amd/amdgpu/psp_v11_0.c        | 1 +
>   5 files changed, 7 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> index fbe1e23526f0..e7f6d2592a32 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> @@ -2001,6 +2001,7 @@ static int amdgpu_discovery_set_psp_ip_blocks(struct amdgpu_device *adev)
>   	case IP_VERSION(11, 0, 12):
>   	case IP_VERSION(11, 0, 13):
>   	case IP_VERSION(11, 5, 0):
> +	case IP_VERSION(11, 5, 2):
>   		amdgpu_device_ip_block_add(adev, &psp_v11_0_ip_block);
>   		break;
>   	case IP_VERSION(11, 0, 8):
> @@ -2065,6 +2066,7 @@ static int amdgpu_discovery_set_smu_ip_blocks(struct amdgpu_device *adev)
>   	case IP_VERSION(11, 0, 12):
>   	case IP_VERSION(11, 0, 13):
>   	case IP_VERSION(11, 5, 0):
> +	case IP_VERSION(11, 5, 2):
>   		amdgpu_device_ip_block_add(adev, &smu_v11_0_ip_block);
>   		break;
>   	case IP_VERSION(12, 0, 0):
> @@ -2909,6 +2911,7 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
>   	case IP_VERSION(11, 0, 10):
>   	case IP_VERSION(11, 0, 11):
>   	case IP_VERSION(11, 5, 0):
> +	case IP_VERSION(11, 5, 2):
>   	case IP_VERSION(13, 0, 1):
>   	case IP_VERSION(13, 0, 9):
>   	case IP_VERSION(13, 0, 10):
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> index 4c794e8ca7bd..cdf595eb0849 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> @@ -193,6 +193,7 @@ static int psp_early_init(struct amdgpu_ip_block *ip_block)
>   	case IP_VERSION(11, 0, 9):
>   	case IP_VERSION(11, 0, 11):
>   	case IP_VERSION(11, 5, 0):
> +	case IP_VERSION(11, 5, 2):
>   	case IP_VERSION(11, 0, 12):
>   	case IP_VERSION(11, 0, 13):
>   		psp_v11_0_set_psp_funcs(psp);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
> index cf700824b960..3d9e9fdc10b4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
> @@ -1216,6 +1216,7 @@ static const char *amdgpu_ucode_legacy_naming(struct amdgpu_device *adev, int bl
>   		case IP_VERSION(11, 0, 13):
>   			return "beige_goby";
>   		case IP_VERSION(11, 5, 0):
> +		case IP_VERSION(11, 5, 2):
>   			return "vangogh";
>   		case IP_VERSION(12, 0, 1):
>   			return "green_sardine";
> diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
> index 47db483c3516..8d84dff58b7e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/nv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/nv.c
> @@ -454,6 +454,7 @@ nv_asic_reset_method(struct amdgpu_device *adev)
>   
>   	switch (amdgpu_ip_version(adev, MP1_HWIP, 0)) {
>   	case IP_VERSION(11, 5, 0):
> +	case IP_VERSION(11, 5, 2):
>   	case IP_VERSION(13, 0, 1):
>   	case IP_VERSION(13, 0, 3):
>   	case IP_VERSION(13, 0, 5):
> diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
> index 2395f1856962..bb5dfc410a66 100644
> --- a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
> @@ -129,6 +129,7 @@ static int psp_v11_0_init_microcode(struct psp_context *psp)
>   		err = psp_init_ta_microcode(psp, ucode_prefix);
>   		break;
>   	case IP_VERSION(11, 5, 0):
> +	case IP_VERSION(11, 5, 2):
>   		err = psp_init_asd_microcode(psp, ucode_prefix);
>   		if (err)
>   			return err;

