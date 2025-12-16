Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FF13D637AE
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Dec 2025 21:22:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E829410E6FC;
	Tue, 16 Dec 2025 21:22:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="e4tVKYyH";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012040.outbound.protection.outlook.com
 [40.93.195.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 36FB410E6FC
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Dec 2025 21:22:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nexrj/3XSj49qZ44fPEzu4ibjq3VXo8Rp9fDhidgHVLcBnw78Foh9YX8KM3thiqCcdk90Vey5oTHkJ1+tmU/gYegqeBE8JjikYCUKSsQxu0k7gbFjTUXxQHpCJE132A+AgRto6FBi51FZT8ugUH9NHmw0EtVAS7WDetLzDDLZ5Gy0O0RqSgot+W87Da4wol5JXcJetwfk6WyZJvCd5qkYL7tUKxwFiiRPQXQlQuig/1Qn1eXcP4TuxzeqNovDkw+g2mHK9ohnifW5imNV9vMTnPzD/DpQR5bgaF92dSFpqbi+QxRlZfgHdIaCyaUu+GbmYmREJ2qe0uh0p+uJsd2dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s2f9XgTan097ZDmLER8vPLNjI4LlQSqFp9riWVFRmUY=;
 b=aSH5nm3O9VoyxnKvgEXKHBzorX60Oo+c7tNmFFU/nXg+5g6Yz7JT1o4Gthh4TNfFp2P0drOj2w9rRXp7TM+1PU52kLyu8siyPJ/Sjq8XNqYm8DHZGrVmpP/ph2KiWOmhdboJwXyDLX0otxnUVlXZaZWom3GW6BsJpZFCK6Di+66AecLciSCQ4rXa0KF4HGIBmjIOtb/O6AEyxYq125y1gYUP5XtlaKx4DVi+fjHwUGXXyUoI1poVB2GJOFvHwy7rkITGBzqTdY9VzlFxYOL0615he7Z3B/nuVIvQdGaabes+gv8GVHSSXui5ZWt72liQPEdLfDCdL3UuUZTA6a36xQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s2f9XgTan097ZDmLER8vPLNjI4LlQSqFp9riWVFRmUY=;
 b=e4tVKYyHUjXPABwhzsZPv5BHMwaSrclRhxOxuPUGzJcCeZmQVEgO7qyrrgC9zQpfUH75SjIBysyZIXr4INfjC5SedSA5qAWqDjXnmgWHJr3uAbZCBPRlEQd7Qj0X92eJIFkQSjxS4fLt9b2+iK8We19RmJ9P9HHuF03KlMdCjUk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by PH7PR12MB8427.namprd12.prod.outlook.com (2603:10b6:510:242::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Tue, 16 Dec
 2025 21:22:07 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%7]) with mapi id 15.20.9412.011; Tue, 16 Dec 2025
 21:22:07 +0000
Message-ID: <946e5878-ac89-45fe-9850-13a0c8cae39e@amd.com>
Date: Tue, 16 Dec 2025 15:22:05 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: add support for GC IP version 11.5.4
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Tim Huang <tim.huang@amd.com>
References: <20251216194537.1872842-1-alexander.deucher@amd.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20251216194537.1872842-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR12CA0024.namprd12.prod.outlook.com
 (2603:10b6:806:6f::29) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|PH7PR12MB8427:EE_
X-MS-Office365-Filtering-Correlation-Id: 249b424f-19a5-4d75-8e03-08de3ce92a94
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZzdhMmY0TVZaaUtNUS9wV3pvbVdwNXJkWmwxcG9Rb3hGQ29jV2t4TVg1VjBt?=
 =?utf-8?B?Ti9ZVzhJUmZqaC84eWV1N1BXLy94YUxzSW9NZzd3SXVuTEYwSDZXb2xER0V5?=
 =?utf-8?B?eUtUUkVicC8xNDFWM2VidjhMZFhZUTZoSDRnQmUxdGZYWTNNUXl5amVVMWJx?=
 =?utf-8?B?L1hoR2pRRHFhR1FNbFhLSk42UXdjem56cmhnL2ZGenFJak13UzV5UVZRaFB5?=
 =?utf-8?B?dmZsQ3BnK1pqKy9kVWVuRVZuMzg4eVZBdm52RCsxZTlZYzhIa3d1T2llV2pJ?=
 =?utf-8?B?NTZwR004VE9XNlpTcS9QZmdhSzB4V0dFRlpXQm1aT2dCUzRxTytkMVhWYXJh?=
 =?utf-8?B?UHV0RWxYNUx5WVdEZkZDN0FGNVJFbm1wbTFRZklWMVFSZEJRRnRaa25sR1E4?=
 =?utf-8?B?WnQ5VkcvQy9XZ3BCRzFUYzN2Tndia2l5WWdhU3I3S3o2dmJvamFWQXR3QkRv?=
 =?utf-8?B?M0hNenpZNGhHY3RSZ1JDR0ZhRTZRS1g0cHMrNjRkRVYveVZOMXp3U1FmWEJa?=
 =?utf-8?B?TlU4OGZ4bU1QYWxWN21aeU8vejVSai95U2Y2TGpWeHdiL0I0ckRDWHljc3JR?=
 =?utf-8?B?TXhJVzBNVGgvUnpGVGJWTHZ4MXAxT240clhDTkFjcDgwQXJOZ0I4bDVOeEx3?=
 =?utf-8?B?MldFckl6RmxHblExbXY5VEUyNmlxaEltNWJ3UGxySmVvYkZYYkEvUGMraHMv?=
 =?utf-8?B?WXVQY3g1bzJ1amlaM1kwMzl5N2dhQVpRMVN3K0FSMnBmeG51M3FJWHJvOURh?=
 =?utf-8?B?bGhEcEhQb3M2cEdzUXJpRGVUZ1BWclpZL2p6ZFIxc1BPaEw5TUcvdzZuRmNh?=
 =?utf-8?B?TVd0NlgzQjVCQ1J1Wnl4SExodDRTdWlJZm96eE5vdzRPcVNWR3BlU29tdGJR?=
 =?utf-8?B?dktzaTBVMW9YRm5sZzhHbG9Sc3FZOFFuNmhIdG5aYzdYTWtqQllweG4xK3lY?=
 =?utf-8?B?SHN2ZDdnMUNEMDhBa3VleGIrbkVFLzJSeThGQUFFYkx0emJnS3JGMC9FRVF2?=
 =?utf-8?B?ejA0MGpsQS9HdU1CbFhBZEVlcWpjNHc2U3dUUTJmRkNGOHdaVFVXM0kxc2xQ?=
 =?utf-8?B?VFZnODI2a29ST2RhcUwyVWsvZ3VFT3RFM0wyL0E3R043MGJoM24xZ3cvQ1M2?=
 =?utf-8?B?S0pJOW8zeENIQUZVbDRJaGE0RUlrVlJYQmRtdkk4c01oWWN1SEM4dTBSN1c3?=
 =?utf-8?B?cDlqdEI1OVVnMmxjdmNMYWhFbVgwZG1nRXpKZ2YrL1hpVFV4bnlHckNPemVi?=
 =?utf-8?B?c2pWUklZLy92elNGdWlhb0hnc0VlRzhTSkpFWS8wU2JCZDZJQ2VrQkxvRUhi?=
 =?utf-8?B?Nm1USXQ2SzBNNFJOMWhQRWhSMlFyOU91VCsyVms5NHRJTENHelN2SS85L3Jm?=
 =?utf-8?B?Q0dGbWZSeXlGMEovYU9vNUdmVHd5NDN5VjBadkdKczEwS25kRDR2QlBpaDlP?=
 =?utf-8?B?RGpzSVdXRTVOdXhCRzNLbStmSWFqR3FkNmFpK2FEQTk3R1hIc201UzZaNmda?=
 =?utf-8?B?MDRUb3ZlVWJtb3dNam1BeTkxYXF4MGNHZ2J6VWduODJTdk9JS1ZIUmFVditN?=
 =?utf-8?B?NDBrR2xnbWpmVkVKcisvZTlFVWxEWVZOQVlPLzlKSTRIYlRqSGlTNW5lekN6?=
 =?utf-8?B?VnVpMGpVOXY4NVMvRVc2cGJHMCtzaVFMNGxsSVNsYVlrcjZkOXBXUjY0eTlw?=
 =?utf-8?B?Ums2R2wrREtGaUhjV05zOElCczZ6ZndMa0FTQzNmYnFxajBMTk5KNWM4cHpj?=
 =?utf-8?B?RWh0cEIxN2ZuWWVxVk0xem12c0MxN2JGTEM0ODlVQ1YwTGxuMHFzZlJrZFpo?=
 =?utf-8?B?SFFFNDdsT2VXRnNCOEJHTnRrelZQQXE0Z012L0poamVKdjQzbTVWS0x6eDBK?=
 =?utf-8?B?TlZxTXBMdEJSU1dlMlpGT3lmeXIrOExHcmRXYmI3WEtwYk5oNjlyQVExTTJB?=
 =?utf-8?Q?4OtMDK7wBLvCQLo4riV6dtIqMSSW15NS?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b0IvZ3Mza00yNnhyRm9KbmYydE4zTEl1czN6YW83YXljaWN4TlcwVHE1Ylll?=
 =?utf-8?B?dnlOZytObGJLSTJ2cXVOVHRCbDlsNFJ4TXpnY3ZSTnVTeHJwZHpLWmdTTktE?=
 =?utf-8?B?N1hqZ3hLZld6dDVpNHd5clBzc0JpTTZZeUkzbHNqV0E3ZVFqNnRhYkRMN2M5?=
 =?utf-8?B?cTBoQXZLRng2ZDJHQlhycE14YjMwZVNZak5rSHUwNytpMmNwYUVCeVNoQnE1?=
 =?utf-8?B?UGgveVdWOXJ0MENlVXUwaklBaU1KMmQ2STRqcS9UMlpLSHp0UC9KRFNmK3V1?=
 =?utf-8?B?S2F5UGxkZWYyaFFpMDhlUkRDbW5RVlNjMFdzVnpqVFViSVM0eTYwMlBKUUEr?=
 =?utf-8?B?VUIybWJBaGFwTXgvVGJ6TWlIUDVNMS9nOG93SHQ2NXFkZzRnMHIrcElEVUx1?=
 =?utf-8?B?SXJ6VG1Tc0I1dU5XdTZQUWI5WlIzZGtBdU5SaUhuRnlMdHVXK3JiQW1Ebld2?=
 =?utf-8?B?eEE5M2FTbTFZK0R3aDlYaG9LelZuWWJrY2x3bVJmbk12aHhLQnBQRG9MNEZW?=
 =?utf-8?B?ME41UDVEUjZQY0FMTmM1T3VjUHZmSTJxUlNrK2NYdktrKzY3OTlkc1RvWU5v?=
 =?utf-8?B?TzRUSC9NY3kwTDNWY0NKWDZPdFNpdWNwckNXa0w2c21jMFV2aVRuVE5hQXBw?=
 =?utf-8?B?TlJ6eHpWN0lHa0kxcFo3QU41eVZCOWxtSmFRRjhacVRxalFGVWQ0dDJqZEVq?=
 =?utf-8?B?TWhJMG16T0p5K0YrVFI3QjE0MzdlRTlKZEFjTzZ0emxHSEVFSFpvUWxOYk8r?=
 =?utf-8?B?ZXI1ejlJejR6Z05oRnJwcHVuTGZIWXRVYmgwUm1DQjdBMVgweHBETkVTcjUz?=
 =?utf-8?B?bGxyMkZEM1RTKzBFSjh3dTl0Rmp3VnFzY29RM2Q0blRSNjI1RnBvNGRuei9Y?=
 =?utf-8?B?Z09JaG9pWlVXbFZIbTl3NmxLalRSeUJXVFY2RkltZDZuTE91dEZSNkcrdnFP?=
 =?utf-8?B?NitIVHNsMVJZaGVXRFYvQnNLUjJXcmsxVG9SYm9WWXNrNEJtM1BxdTVwUW5I?=
 =?utf-8?B?VXpiRDllZU9Kb0U4d3ZKTm0rcDNoS2tNYU1va2JrZFh0NDQ2RFdVc2NQdnQ5?=
 =?utf-8?B?TTZ3TFAwaXVCSmdRMkRGaThkUVVkMUhBTU1uLyt3c3RVOGZDbFNPeWZRZjBF?=
 =?utf-8?B?TjRQMlJZaTB1eFpaNnVOSko5dmV4UjVTVDVVQzJ0UjdrU2IxVXdHdUpxQlpl?=
 =?utf-8?B?WjR0dUJMT2VFMFJqdXQxcFB6Sks3WGJoRE4zMUJTL09jQXFsc1gxTm9RdWN2?=
 =?utf-8?B?RjNxdmJ6a3d0SDVYNCtac2VoOXE4cDNLMGpTMmJGWStUbHUvekRmOGtwcWVE?=
 =?utf-8?B?ZWFBWm1jbHYvUHdsZWYraU9ybmhIbGNjK0wzcVczWXBpS2tCaUFPNEpCb0lU?=
 =?utf-8?B?QUJHd1gxaEVxUzZGZit0VmsrY0d0cmd2OTBPNXdpTnNIUzJjNHd2d29tSUZl?=
 =?utf-8?B?dTBMN3loU0J4TFRKeUF4aGJ3bXBleWlzbUgyclFhQ1BoRWU1SmU4T0YwYXVN?=
 =?utf-8?B?akQ0eGYrM2szY2MxTEQ4ckQ1SFBBSUtnQ1MrR3JPOWd2a0RDQUthRHZoQzNO?=
 =?utf-8?B?QjlmTDVZTFhDK3B2NWFUQXh3VXZvQm1Ba3JkdWpxSE5QaVJ5Z0o5TkhVaTBM?=
 =?utf-8?B?UWtzc3h2aHNNVUpkTHlKa2RSV3BnMERxN09OZFpmZUZCcnlsRnhvcmlPVG9a?=
 =?utf-8?B?WUtWQmw5bS9IQVFvYktnalFPQ2ExWmNBbXFrUlhQTys2bDVEVW5xclM3b21a?=
 =?utf-8?B?NWZvRk5va2lWeitxT1BhS203eFQ1Smd5YkQ4RnZOYlJmZFJFSXI0WlhPV2Jn?=
 =?utf-8?B?UmRNSmhBU3JQUWQveVlBVHhsRTJTNVBaZHcyNDBOZ1VwbnhQcm1LcGFHN2RO?=
 =?utf-8?B?VDFnR1dKVUkvSG1xNy9KMUVLRUxtUVZqbFhMNVVWbVhYT0srWmd2dW1LTCtl?=
 =?utf-8?B?UGtQeC9vYUV1RHgxSjc1eXR0ZVVMdHdzcUlOMnFWZmxCdUUycndXYklvRnE4?=
 =?utf-8?B?ci9UOWhIQWNoK0EvU3NtSThyWHFuVXpCbWdYaWd0VEpURnIyYmoxbzhvR0Jp?=
 =?utf-8?B?Q3Q3a3NwUW51L3FjUmVMYTB5R3p1MWpzT216aXV4RUFweUhiVTVIQm5UNUpV?=
 =?utf-8?Q?bm2CNmIWiEiHYW/PvIg3srlEJ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 249b424f-19a5-4d75-8e03-08de3ce92a94
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2025 21:22:07.4891 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q8rxEUR6bGbeysCGDGAkczB5NdjCGvdHN3Lk+bUJrGk+ZzqyPfBqqqbMDDgoaRfgragUGwQf72KOJzVxZNLy1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8427
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

For the series:

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>

On 12/16/2025 1:45 PM, Alex Deucher wrote:
> From: Tim Huang <tim.huang@amd.com>
> 
> This initializes GC IP version 11.5.4.
> 
> v2: squash in RLC offset fix
> 
> Signed-off-by: Tim Huang <tim.huang@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c |  6 ++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c       |  1 +
>   drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c        | 12 +++++++++++-
>   drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c        |  2 ++
>   drivers/gpu/drm/amd/amdgpu/imu_v11_0.c        |  1 +
>   drivers/gpu/drm/amd/amdgpu/mes_v11_0.c        |  2 ++
>   drivers/gpu/drm/amd/amdgpu/soc21.c            |  5 +++++
>   drivers/gpu/drm/amd/amdkfd/kfd_crat.c         |  1 +
>   drivers/gpu/drm/amd/amdkfd/kfd_device.c       |  5 +++++
>   9 files changed, 34 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> index 20d05a3e4516e..116cb437c81bb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> @@ -1988,6 +1988,7 @@ static int amdgpu_discovery_set_common_ip_blocks(struct amdgpu_device *adev)
>   	case IP_VERSION(11, 5, 1):
>   	case IP_VERSION(11, 5, 2):
>   	case IP_VERSION(11, 5, 3):
> +	case IP_VERSION(11, 5, 4):
>   		amdgpu_device_ip_block_add(adev, &soc21_common_ip_block);
>   		break;
>   	case IP_VERSION(12, 0, 0):
> @@ -2047,6 +2048,7 @@ static int amdgpu_discovery_set_gmc_ip_blocks(struct amdgpu_device *adev)
>   	case IP_VERSION(11, 5, 1):
>   	case IP_VERSION(11, 5, 2):
>   	case IP_VERSION(11, 5, 3):
> +	case IP_VERSION(11, 5, 4):
>   		amdgpu_device_ip_block_add(adev, &gmc_v11_0_ip_block);
>   		break;
>   	case IP_VERSION(12, 0, 0):
> @@ -2358,6 +2360,7 @@ static int amdgpu_discovery_set_gc_ip_blocks(struct amdgpu_device *adev)
>   	case IP_VERSION(11, 5, 1):
>   	case IP_VERSION(11, 5, 2):
>   	case IP_VERSION(11, 5, 3):
> +	case IP_VERSION(11, 5, 4):
>   		amdgpu_device_ip_block_add(adev, &gfx_v11_0_ip_block);
>   		break;
>   	case IP_VERSION(12, 0, 0):
> @@ -2559,6 +2562,7 @@ static int amdgpu_discovery_set_mes_ip_blocks(struct amdgpu_device *adev)
>   	case IP_VERSION(11, 5, 1):
>   	case IP_VERSION(11, 5, 2):
>   	case IP_VERSION(11, 5, 3):
> +	case IP_VERSION(11, 5, 4):
>   		amdgpu_device_ip_block_add(adev, &mes_v11_0_ip_block);
>   		adev->enable_mes = true;
>   		adev->enable_mes_kiq = true;
> @@ -2961,6 +2965,7 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
>   	case IP_VERSION(11, 5, 1):
>   	case IP_VERSION(11, 5, 2):
>   	case IP_VERSION(11, 5, 3):
> +	case IP_VERSION(11, 5, 4):
>   		adev->family = AMDGPU_FAMILY_GC_11_5_0;
>   		break;
>   	case IP_VERSION(12, 0, 0):
> @@ -2988,6 +2993,7 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
>   	case IP_VERSION(11, 5, 1):
>   	case IP_VERSION(11, 5, 2):
>   	case IP_VERSION(11, 5, 3):
> +	case IP_VERSION(11, 5, 4):
>   		adev->flags |= AMD_IS_APU;
>   		break;
>   	default:
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> index cd4acc6adc9e1..48605e41cfb94 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> @@ -949,6 +949,7 @@ void amdgpu_gmc_tmz_set(struct amdgpu_device *adev)
>   	case IP_VERSION(11, 5, 1):
>   	case IP_VERSION(11, 5, 2):
>   	case IP_VERSION(11, 5, 3):
> +	case IP_VERSION(11, 5, 4):
>   		/* Don't enable it by default yet.
>   		 */
>   		if (amdgpu_tmz < 1) {
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> index 79a6977d56b0e..0e5b255eeda40 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> @@ -120,6 +120,10 @@ MODULE_FIRMWARE("amdgpu/gc_11_5_3_pfp.bin");
>   MODULE_FIRMWARE("amdgpu/gc_11_5_3_me.bin");
>   MODULE_FIRMWARE("amdgpu/gc_11_5_3_mec.bin");
>   MODULE_FIRMWARE("amdgpu/gc_11_5_3_rlc.bin");
> +MODULE_FIRMWARE("amdgpu/gc_11_5_4_pfp.bin");
> +MODULE_FIRMWARE("amdgpu/gc_11_5_4_me.bin");
> +MODULE_FIRMWARE("amdgpu/gc_11_5_4_mec.bin");
> +MODULE_FIRMWARE("amdgpu/gc_11_5_4_rlc.bin");
>   
>   static const struct amdgpu_hwip_reg_entry gc_reg_list_11_0[] = {
>   	SOC15_REG_ENTRY_STR(GC, 0, regGRBM_STATUS),
> @@ -1113,6 +1117,7 @@ static int gfx_v11_0_gpu_early_init(struct amdgpu_device *adev)
>   	case IP_VERSION(11, 5, 1):
>   	case IP_VERSION(11, 5, 2):
>   	case IP_VERSION(11, 5, 3):
> +	case IP_VERSION(11, 5, 4):
>   		adev->gfx.config.max_hw_contexts = 8;
>   		adev->gfx.config.sc_prim_fifo_size_frontend = 0x20;
>   		adev->gfx.config.sc_prim_fifo_size_backend = 0x100;
> @@ -1595,6 +1600,7 @@ static int gfx_v11_0_sw_init(struct amdgpu_ip_block *ip_block)
>   	case IP_VERSION(11, 5, 1):
>   	case IP_VERSION(11, 5, 2):
>   	case IP_VERSION(11, 5, 3):
> +	case IP_VERSION(11, 5, 4):
>   		adev->gfx.me.num_me = 1;
>   		adev->gfx.me.num_pipe_per_me = 1;
>   		adev->gfx.me.num_queue_per_pipe = 2;
> @@ -3052,7 +3058,8 @@ static int gfx_v11_0_wait_for_rlc_autoload_complete(struct amdgpu_device *adev)
>   		    amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(11, 5, 0) ||
>   		    amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(11, 5, 1) ||
>   		    amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(11, 5, 2) ||
> -		    amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(11, 5, 3))
> +		    amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(11, 5, 3) ||
> +		    amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(11, 5, 4))
>   			bootload_status = RREG32_SOC15(GC, 0,
>   					regRLC_RLCS_BOOTLOAD_STATUS_gc_11_0_1);
>   		else
> @@ -5640,6 +5647,7 @@ static void gfx_v11_cntl_power_gating(struct amdgpu_device *adev, bool enable)
>   		case IP_VERSION(11, 5, 1):
>   		case IP_VERSION(11, 5, 2):
>   		case IP_VERSION(11, 5, 3):
> +	        case IP_VERSION(11, 5, 4):
>   			WREG32_SOC15(GC, 0, regRLC_PG_DELAY_3, RLC_PG_DELAY_3_DEFAULT_GC_11_0_1);
>   			break;
>   		default:
> @@ -5678,6 +5686,7 @@ static int gfx_v11_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
>   	case IP_VERSION(11, 5, 1):
>   	case IP_VERSION(11, 5, 2):
>   	case IP_VERSION(11, 5, 3):
> +	case IP_VERSION(11, 5, 4):
>   		if (!enable)
>   			amdgpu_gfx_off_ctrl(adev, false);
>   
> @@ -5712,6 +5721,7 @@ static int gfx_v11_0_set_clockgating_state(struct amdgpu_ip_block *ip_block,
>   	case IP_VERSION(11, 5, 1):
>   	case IP_VERSION(11, 5, 2):
>   	case IP_VERSION(11, 5, 3):
> +	case IP_VERSION(11, 5, 4):
>   	        gfx_v11_0_update_gfx_clock_gating(adev,
>   	                        state ==  AMD_CG_STATE_GATE);
>   	        break;
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> index 7a1f0742754a6..ad5e512e3fb8a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> @@ -602,6 +602,7 @@ static void gmc_v11_0_set_gfxhub_funcs(struct amdgpu_device *adev)
>   	case IP_VERSION(11, 5, 1):
>   	case IP_VERSION(11, 5, 2):
>   	case IP_VERSION(11, 5, 3):
> +	case IP_VERSION(11, 5, 4):
>   		adev->gfxhub.funcs = &gfxhub_v11_5_0_funcs;
>   		break;
>   	default:
> @@ -778,6 +779,7 @@ static int gmc_v11_0_sw_init(struct amdgpu_ip_block *ip_block)
>   	case IP_VERSION(11, 5, 1):
>   	case IP_VERSION(11, 5, 2):
>   	case IP_VERSION(11, 5, 3):
> +	case IP_VERSION(11, 5, 4):
>   		set_bit(AMDGPU_GFXHUB(0), adev->vmhubs_mask);
>   		set_bit(AMDGPU_MMHUB0(0), adev->vmhubs_mask);
>   		/*
> diff --git a/drivers/gpu/drm/amd/amdgpu/imu_v11_0.c b/drivers/gpu/drm/amd/amdgpu/imu_v11_0.c
> index cc626036ed9c3..46d25d55ebbeb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/imu_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/imu_v11_0.c
> @@ -41,6 +41,7 @@ MODULE_FIRMWARE("amdgpu/gc_11_5_0_imu.bin");
>   MODULE_FIRMWARE("amdgpu/gc_11_5_1_imu.bin");
>   MODULE_FIRMWARE("amdgpu/gc_11_5_2_imu.bin");
>   MODULE_FIRMWARE("amdgpu/gc_11_5_3_imu.bin");
> +MODULE_FIRMWARE("amdgpu/gc_11_5_4_imu.bin");
>   
>   static int imu_v11_0_init_microcode(struct amdgpu_device *adev)
>   {
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> index 5159f4a9787ca..f8678a7bec93c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> @@ -56,6 +56,8 @@ MODULE_FIRMWARE("amdgpu/gc_11_5_2_mes_2.bin");
>   MODULE_FIRMWARE("amdgpu/gc_11_5_2_mes1.bin");
>   MODULE_FIRMWARE("amdgpu/gc_11_5_3_mes_2.bin");
>   MODULE_FIRMWARE("amdgpu/gc_11_5_3_mes1.bin");
> +MODULE_FIRMWARE("amdgpu/gc_11_5_4_mes_2.bin");
> +MODULE_FIRMWARE("amdgpu/gc_11_5_4_mes1.bin");
>   
>   static int mes_v11_0_hw_init(struct amdgpu_ip_block *ip_block);
>   static int mes_v11_0_hw_fini(struct amdgpu_ip_block *ip_block);
> diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgpu/soc21.c
> index 55c3781fc7304..99c4db3b2a232 100644
> --- a/drivers/gpu/drm/amd/amdgpu/soc21.c
> +++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
> @@ -799,6 +799,11 @@ static int soc21_common_early_init(struct amdgpu_ip_block *ip_block)
>   			AMD_PG_SUPPORT_GFX_PG;
>   		adev->external_rev_id = adev->rev_id + 0x50;
>   		break;
> +	case IP_VERSION(11, 5, 4):
> +               adev->cg_flags = 0;
> +               adev->pg_flags = 0;
> +               adev->external_rev_id = adev->rev_id + 0x1;
> +               break;
>   	default:
>   		/* FIXME: not supported yet */
>   		return -EINVAL;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> index 5f2dd378936ed..36ffc3c785367 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> @@ -1705,6 +1705,7 @@ int kfd_get_gpu_cache_info(struct kfd_node *kdev, struct kfd_gpu_cache_info **pc
>   		case IP_VERSION(11, 5, 1):
>   		case IP_VERSION(11, 5, 2):
>   		case IP_VERSION(11, 5, 3):
> +		case IP_VERSION(11, 5, 4):
>   			/* Cacheline size not available in IP discovery for gc11.
>   			 * kfd_fill_gpu_cache_info_from_gfx_config to hard code it
>   			 */
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> index b91843b2af6a6..01e5b3416716f 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> @@ -164,6 +164,7 @@ static void kfd_device_info_set_event_interrupt_class(struct kfd_dev *kfd)
>   	case IP_VERSION(11, 5, 1):
>   	case IP_VERSION(11, 5, 2):
>   	case IP_VERSION(11, 5, 3):
> +	case IP_VERSION(11, 5, 4):
>   		kfd->device_info.event_interrupt_class = &event_interrupt_class_v11;
>   		break;
>   	case IP_VERSION(12, 0, 0):
> @@ -441,6 +442,10 @@ struct kfd_dev *kgd2kfd_probe(struct amdgpu_device *adev, bool vf)
>   			gfx_target_version = 110503;
>   			f2g = &gfx_v11_kfd2kgd;
>   			break;
> +		case IP_VERSION(11, 5, 4):
> +                        gfx_target_version = 110504;
> +                        f2g = &gfx_v11_kfd2kgd;
> +                        break;
>   		case IP_VERSION(12, 0, 0):
>   			gfx_target_version = 120000;
>   			f2g = &gfx_v12_kfd2kgd;

