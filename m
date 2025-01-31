Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1189CC0218D
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jan 2025 07:52:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AC6C710E070;
	Fri, 31 Jan 2025 07:52:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="12Ltg1Kt";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2041.outbound.protection.outlook.com [40.107.243.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D9E6E10E070
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Jan 2025 07:52:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RP264sJTZFD1DTBOZCcJfQJloQbPJQH2uXsxutbZuNtPML1cpnI2xAMweW1D2IYp9TItzxUHfGd1Fs8jRDXlPafSo0aREumvLQz8U9HvRAYuJyt8fb1EimvoA8gAWDb+uipAsSfMihcw8wliBYrALYhrNlYXS8eGS/566/W/Oavrq+/YHEnBttcMJ6opFgqNwS3TmRKSlXj4JrpA51Al9hU4w7JE31+DvSJI7cqj44XLgY0U+1kil7GS96LbireyGb6gIuLYceTgiILdsJhVCaZPtWWNEvo4diVJIMnFRkWOql2YUVnxGPu0d+oQL2PEHif+dbpvT3iLX5jEua9eZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hcxe2h9laogBVFJtU6sWuUo9vvo2K69C0jUVQlNS4Qo=;
 b=xfsYD+l+rYdHQm4rj/r5iZlbPYjWLPdc+v+OzqUgMEh8wl1+Z7dYDqMA+AI0NppHXqFh270/GJvfhyGPp7h/TeM9ebVhn+FwXXCa6XAU8yr95i3t+YpFgPj1gXrZgGmVfFDJPqchF+HspXKm93rM5arlSpeo345DcdLFmKeasieJ/+RsD9yMyGce08sl2QmyYMKW5Q1YUzvDpjSmsUKlyiZ9LOYy5rh7oTaSr9YOkbJZm67n4qlAXUVype8DPv4sbRwSi4lNQGTkU0AuJT7Ug44MIcTzUzLoOpiBq4urMhryU6WJpszfWjKCJ9d9VC+hVIJX/VT5wHgnRd06frk9jQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hcxe2h9laogBVFJtU6sWuUo9vvo2K69C0jUVQlNS4Qo=;
 b=12Ltg1Kt3dhnVU+b28sNxDEDHEca2MhJR8aDqQytPoI1CzQefSeax8zQ5RtO1VJ9InsuhBR7WDIFrYtyGoG+Wih0vajA2UoJY0ex0rb+UQ4Ofj0veKEZO9cwQ3+CK0y/WBuNNtuTs1vR5FFqvLXEYwRkWPgujdmpiogLVLwaUhY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6293.namprd12.prod.outlook.com (2603:10b6:208:3c2::22)
 by SA1PR12MB6679.namprd12.prod.outlook.com (2603:10b6:806:252::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.18; Fri, 31 Jan
 2025 07:52:30 +0000
Received: from MN0PR12MB6293.namprd12.prod.outlook.com
 ([fe80::49ac:e84e:ea32:d743]) by MN0PR12MB6293.namprd12.prod.outlook.com
 ([fe80::49ac:e84e:ea32:d743%6]) with mapi id 15.20.8398.020; Fri, 31 Jan 2025
 07:52:30 +0000
Message-ID: <1fa96910-b574-478b-a895-072f4302fd00@amd.com>
Date: Fri, 31 Jan 2025 13:22:25 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 02/10] drm/amdgpu: Add helper funcs for jpeg devcoredump
To: Sathishkumar S <sathishkumar.sundararaju@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: Leo Liu <Leo.Liu@amd.com>, Lazar Lijo <Lijo.Lazar@amd.com>
References: <20250130095113.534630-1-sathishkumar.sundararaju@amd.com>
 <20250130095113.534630-3-sathishkumar.sundararaju@amd.com>
Content-Language: en-US
From: "Sundararaju, Sathishkumar" <sasundar@amd.com>
In-Reply-To: <20250130095113.534630-3-sathishkumar.sundararaju@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0248.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:21a::19) To MN0PR12MB6293.namprd12.prod.outlook.com
 (2603:10b6:208:3c2::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6293:EE_|SA1PR12MB6679:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a41ea1e-a45a-4e3a-f25a-08dd41cc36a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UlB5V1BQV2N5di9pL0xWWjBnRUNWdzB4TitycE44YVZUUTZyN1ZqeFpDVUNP?=
 =?utf-8?B?Sm1nUGE1NEF5Q2pGVVNhbVcvNHg3TGlkOEdsazk1SW8wVlFqQ1F5aGJ3eVhx?=
 =?utf-8?B?bjNPR1hKVzlLOTd6L3FvdytpV0VzbFRHUnZWTjhzMnRuTXRYVHVoUWFNQUNa?=
 =?utf-8?B?ZnlhRHV4eDBJVEQvc25VTHZWazhPWmNmcFJLMG5BakhOZ3VJcUtZRENoNllH?=
 =?utf-8?B?SDJvdnBVS0UrQUF0K2hGVUR0WXRXamNSOHMwaVlKVENFOUN5eHZzL3NFTzho?=
 =?utf-8?B?T3BkK1BIVXpWaUZpM044dEsvWU9VUkJhK0RYL2tUR0VyYXFmRUVvbWlST2gz?=
 =?utf-8?B?d1VUTGxRblJNUWRleDE0bzEzQ0U3OWdHVVpLRWF6dm15SnFxMElqZUwrZ1lC?=
 =?utf-8?B?QUx5OUptOHhQYzFOYm45TlNWQ3JOT29nL3RWY05zWklaWS9WaHRQdEErU2Zw?=
 =?utf-8?B?VWkrb09taGl4TWlqTHJQdVlKSUc0KzliMHJvMlhQRXZvUTdSU2hhcU5HMHJ6?=
 =?utf-8?B?RXlEVXpaZEtvQVZxRXBWZTRwVEpROVRFcVJEQXJNMXZpQzE5N0o0S014dmlL?=
 =?utf-8?B?eFJIcTZkaUsrelBnU0VSMWxZU0JyMDQyZ2pjWEs4U3VoYzd3UHM1K3VnWXdl?=
 =?utf-8?B?VTZJMEhWbnlzUnNmN3JGRVZEWTMwUEFTUEdEMldIajRuUHg1djJrS2NXVnVR?=
 =?utf-8?B?N29Wa3pnOTFqT01PNjNBcXM4Sk1QMWE1a04raFlJNUQ2VmpPaDV4RGVVbTZJ?=
 =?utf-8?B?Y0tVRnU3MGwwaERLa0N3Zy9QOHdrRTJkdjdwUk8wVC9BTWJYVVQ1WXY3QzZi?=
 =?utf-8?B?Z3FOOVRySGFaY2pLeXhYRzIvcXdURXQ2TndYRHJTaWNtUjY3RG8rSURnWFZu?=
 =?utf-8?B?SGM4WmR6L0ZUOTNZU2tQQ21odGJ5eVdnYTlyaW1LWlkvcG1KM1RzQjVzTm5p?=
 =?utf-8?B?TFphMHlqaEVHRlJ6Sjc3T3JjbGFPV2Q0cCtJM0Q3WkFqdmppRGNTSzRlSTZP?=
 =?utf-8?B?VWplQVJoTW1hQjZ5RWF4cjRUNUkyeFFHWkwvVkpET0tIdkl1dHlYN3Q4VW56?=
 =?utf-8?B?TUNabXA0SDFBb2lGdWZhQ0d5dmp0ZElkbmlNZ2FJSlB6RDlmdW44STRWclNx?=
 =?utf-8?B?U1JwM0JlMG4xcWRMeDFCUUcvWlUxSG9kMGUyRW1oM09mT0I1WGx4M3hVdWMz?=
 =?utf-8?B?ZzBNM3dVZXZ1eitsNXBiVHcyVEt0Vk5RVUhxV0srVkNVcGtobURrSVhiZHJS?=
 =?utf-8?B?RGJ2dG5NWXFXWnlUZGhVdnUzV3NGbXh5STlicDdrKzlENXR4SFNET1pObkk0?=
 =?utf-8?B?S2daZzU5Y0RIblN0aTlROEFQemxzenRLRENsZENuSHRGd243VWZZcUJRVnNu?=
 =?utf-8?B?WkRNbVpIQ2dyOVpjZGFCZmlRS1BYNXFHQkJscjJjOXM3U0lidDdCZWsvK1Z5?=
 =?utf-8?B?YjlVVWJ5OXB3VlhNcEljRjNjWjhyaEN6L1lSUTF4V25hYU9UZGVFY1ErY0sx?=
 =?utf-8?B?bllhdktvZWZaM1RzQ0NJd000MkszVlpWNm10ZGxKSUl1R1F2cE43eHkybTFI?=
 =?utf-8?B?TElzejYwTDAvWVhCdVpNTDI5UjZ0VmVySUFHczVFMGNidVdTOGpJMkRqL3Nl?=
 =?utf-8?B?cVhma1Q5S2FrN3JGc0t5YkFEM2Z0N1FxY1JGN3dqQWVZM3Y4ejFLSTM1QzdW?=
 =?utf-8?B?Q1NqMEJuUVpVNDEvNlkyeGhkUDJ0aHNCNXZ4dHJFeGxwZUNKc25GbytTcmpE?=
 =?utf-8?B?OHo4ZEdIWG56T29oWDFLZTlPK1B0VDJDaVZGbFpWVXRvMGhna0VQOWM1ZmRl?=
 =?utf-8?B?cllKdmhWUUk1a0hoZ1hHSDBTdHlNc0lyZTBHa3dvZTU1WGRXZnU0dTAwL3Fl?=
 =?utf-8?Q?dpGPGHp7UQIfy?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6293.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SmFHRzNwRXJhZDVRdjI5VEZGenR3YkNVdHhaM2R6bnhkL2JUZCtFMzBoZGFh?=
 =?utf-8?B?VjBRR1EzK3Baem9sMTV4T1IzeFo3TXRYN0lQYWZXeFdTZnUweU5TdTJlemNo?=
 =?utf-8?B?V1BST0oySmgxQ0QrN0lRVFR2Zm43UThJNUdkWldSQlYranlLcjA0LzRKemJW?=
 =?utf-8?B?dmxSWEJyTEpJMys5VnBwUDFnRmoyc0JHcmJmZjNyeGpDTlM4NE1uSDlpYXNu?=
 =?utf-8?B?S1pYYkl2ZkRhazU0MjQrODI4U1pNdmJUeXVDOXByZUx6M2M5WVl0NmRWUzBO?=
 =?utf-8?B?T2hwTmRzV2R3NUVPWHZRWXBKSStsT2U2Ym9JQlVhQjNpYy9JRCtXT1gzZDNP?=
 =?utf-8?B?cVJrNzIzQzA2QU85Q0RCZXdXQ0F4cjcyeW5mUzl0YVJna1JWZWNXQkZ3Q2xi?=
 =?utf-8?B?Yi9LeCtLWkszSlhLMjdoTm9HMEZVTHJhT1p3Tm5ZSTZLNWUzVldkcDBCMEJ4?=
 =?utf-8?B?RUdWYTZpR24xSlZDQlE0NTIrem1Qd1F5U2ZlaC9qS01vT0NKcFJVNnhIL2Iw?=
 =?utf-8?B?RTBkUHhwK2RKQWxKNEVyNkJKQTA4emU4Y1NJdVJkQVJJVXB4ZkxHK0pQQUFs?=
 =?utf-8?B?NjEwaGt2bEJtc2pVYW4zUGFheXNZS200QUp6eEVvQlNVMnJrQXB2b0hKM21t?=
 =?utf-8?B?MUVld00wR0JqbnFtWUFqRFVvRlZrSXFvYytiQ20zbEZDbDFSRTNBbkwwdWdO?=
 =?utf-8?B?QlozckoxSGRza21qcEN5MWlFNjFUbWFEMHBiZHpTVXFYMy9rZS8yRC9WRURi?=
 =?utf-8?B?Y0t0MXNmY2pjemd4ZGcxM2hqSXppZEQvd1NGeEpaMlNPdERmSzkrSDBRZjVB?=
 =?utf-8?B?TlVUUnpiZUQ4YnpFRTZSek1vZ25ZZERpT1JOWnoyNGZubVZlZ3lJYTlKbXdS?=
 =?utf-8?B?cVdXVlAzOU1nZkRjbUhKeUt2OHR1elVEN25CSHJBWWhtc2ozaVJ3M0sxOEYy?=
 =?utf-8?B?a3B6QlEyZ1BlNHllK2c0T0NqZS9kSzVWT2MzcUY3cUFKWTRLeVowZVJRTG9N?=
 =?utf-8?B?dWhvandnLzFLQ3daS2NtbWlEcXJaWkkrcDJTOVA5dmM2SmdqQWIvYXZjaUNP?=
 =?utf-8?B?dVIzVDZQTURYUm5kQmF5RjJZcHJTSS9POHdPbEdoUGF5YnYrcUxGSU1uTFZO?=
 =?utf-8?B?R2NsUTgvWWpqSmJqTHNXbGhjdmhqMXFnNmVsZWZVa1VrK2E0UWYxaEsvOUFF?=
 =?utf-8?B?YWQvdU8rOFBkS0l4VEtyRkRCTE5Ra1U5eElHVEU2VERxRnVSSm9zQno0M09T?=
 =?utf-8?B?Z0w4THNjRmpYSUhWQkZHUXdXU3Q4MVJNdm0zM0YrV3BjdUlSbG8xOENNOWtj?=
 =?utf-8?B?aURNRXQyRVRUQzdZcHZxbGc0bHRmekVlRzRPMW9SNGNsYm52TUthaThqSk9l?=
 =?utf-8?B?eTNtd1FkdzAreWh5Ym9sWkNPN3JVNjAzY0Jwd3JmREZHWkpxNFJqNFVYRC9O?=
 =?utf-8?B?MjhvK1BNL3lsTVZtMDRuY2JheHZMcHJuRUpXU3hrK2ExZ1ZqNGtHMDRTOGdH?=
 =?utf-8?B?VVFnR0E4SnRwLzVQdGo5dkZKYzlNbkVCQXZUemNtOGVXeEF0Y3UyNmY0NGNo?=
 =?utf-8?B?S0NUZlRodXJUVG42SWZpMnZUdnZSazVCUjdldWV4TzJwS1hLQkEwUGIyeTJF?=
 =?utf-8?B?YWZkUGMyUXlVbFpSUC82dVM1UHRMQkVJeWpkQWFibWt4VG9mc3ZoL1g4VDY4?=
 =?utf-8?B?bHhjVlNkTm5kMHFXdUM3SHNrT3JLcGd5TmlvWkI1bXZLVi84Z2lneUN5cXJI?=
 =?utf-8?B?QW1LeUpPeTlLN2NGOVhpMFNGWGtiV1ZOdmt5TGZaMHpwc01HbXJpbDVIS0Yy?=
 =?utf-8?B?OGJ4TXVYSHFsbWdRQ0J6T0Q2MmNzd0N1dEswTWRkUnFiYngwd29JdFI4NkZj?=
 =?utf-8?B?bFBITmUzMXp2b3dmZW9qNW1RZUF1eGxiVEs2WHh1OTdJSWVlclpydXh0UlhC?=
 =?utf-8?B?bXBFeGdDVVBFZzR4bDAxMHpFK201aWszcXdRblZtMmJHemtoOHF4Mk9KYllZ?=
 =?utf-8?B?alo3OWVHSzNNNHIyb0NXcU1RdnljY1NMRXFudnE4THhNTW0xeEJaUHhrOG1J?=
 =?utf-8?B?SHJ4d1MvZVZFcHk1di9hcjBCb0EyUUN0UkNpT05yNnVzMDJTOUlJRWtRWFVM?=
 =?utf-8?Q?0QHLE1k6ANIkcc4HXZ66H1UVy?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a41ea1e-a45a-4e3a-f25a-08dd41cc36a6
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6293.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2025 07:52:30.5568 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ampRAxU1hvSgCtfsYby8f76+6tUAex2KljVjMTW1XURCBBhl2TZpTih3wOejmvKaiElqbvUWesQIU79SNIkJ6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6679
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

Hi Lijo,

Gentle ping, reg_dump_fini() is now moved to sw_fini() in this version 
as suggested.

Regards,
Sathish


On 1/30/2025 3:21 PM, Sathishkumar S wrote:
> Add devcoredump helper functions that can be reused for all jpeg versions.
>
> V2: (Lijo)
>   - add amdgpu_jpeg_reg_dump_init() and amdgpu_jpeg_reg_dump_fini()
>   - use reg_list and reg_count from init() to dump and print registers
>   - memory allocation and freeing is moved to the init() and fini()
>
> V3: (Lijo)
>   - move amdgpu_jpeg_reg_dump_fini() to sw_fini()
>
> Signed-off-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c | 84 ++++++++++++++++++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h |  9 +++
>   2 files changed, 93 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
> index b6d2eb049f54..dda29132dfb2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
> @@ -33,6 +33,7 @@
>   #define JPEG_IDLE_TIMEOUT	msecs_to_jiffies(1000)
>   
>   static void amdgpu_jpeg_idle_work_handler(struct work_struct *work);
> +static void amdgpu_jpeg_reg_dump_fini(struct amdgpu_device *adev);
>   
>   int amdgpu_jpeg_sw_init(struct amdgpu_device *adev)
>   {
> @@ -85,6 +86,9 @@ int amdgpu_jpeg_sw_fini(struct amdgpu_device *adev)
>   			amdgpu_ring_fini(&adev->jpeg.inst[i].ring_dec[j]);
>   	}
>   
> +	if (adev->jpeg.reg_list)
> +		amdgpu_jpeg_reg_dump_fini(adev);
> +
>   	mutex_destroy(&adev->jpeg.jpeg_pg_lock);
>   
>   	return 0;
> @@ -452,3 +456,83 @@ void amdgpu_jpeg_sysfs_reset_mask_fini(struct amdgpu_device *adev)
>   			device_remove_file(adev->dev, &dev_attr_jpeg_reset_mask);
>   	}
>   }
> +
> +int amdgpu_jpeg_reg_dump_init(struct amdgpu_device *adev,
> +			       const struct amdgpu_hwip_reg_entry *reg, u32 count)
> +{
> +	adev->jpeg.ip_dump = kcalloc(adev->jpeg.num_jpeg_inst * count,
> +				     sizeof(uint32_t), GFP_KERNEL);
> +	if (!adev->jpeg.ip_dump) {
> +		DRM_ERROR("Failed to allocate memory for JPEG IP Dump\n");
> +		return -ENOMEM;
> +	}
> +	adev->jpeg.reg_list = reg;
> +	adev->jpeg.reg_count = count;
> +
> +	return 0;
> +}
> +
> +static void amdgpu_jpeg_reg_dump_fini(struct amdgpu_device *adev)
> +{
> +	kfree(adev->jpeg.ip_dump);
> +	adev->jpeg.reg_list = NULL;
> +	adev->jpeg.reg_count = 0;
> +}
> +
> +void amdgpu_jpeg_dump_ip_state(struct amdgpu_ip_block *ip_block)
> +{
> +	struct amdgpu_device *adev = ip_block->adev;
> +	u32 inst_off, inst_id, is_powered;
> +	int i, j;
> +
> +	if (!adev->jpeg.ip_dump)
> +		return;
> +
> +	for (i = 0; i < adev->jpeg.num_jpeg_inst; i++) {
> +		if (adev->jpeg.harvest_config & (1 << i))
> +			continue;
> +
> +		inst_id = GET_INST(JPEG, i);
> +		inst_off = i * adev->jpeg.reg_count;
> +		/* check power status from UVD_JPEG_POWER_STATUS */
> +		adev->jpeg.ip_dump[inst_off] =
> +			RREG32(SOC15_REG_ENTRY_OFFSET_INST(adev->jpeg.reg_list[0],
> +							   inst_id));
> +		is_powered = ((adev->jpeg.ip_dump[inst_off] & 0x1) != 1);
> +
> +		if (is_powered)
> +			for (j = 1; j < adev->jpeg.reg_count; j++)
> +				adev->jpeg.ip_dump[inst_off + j] =
> +					RREG32(SOC15_REG_ENTRY_OFFSET_INST(adev->jpeg.reg_list[j],
> +									   inst_id));
> +	}
> +}
> +
> +void amdgpu_jpeg_print_ip_state(struct amdgpu_ip_block *ip_block, struct drm_printer *p)
> +{
> +	struct amdgpu_device *adev = ip_block->adev;
> +	u32 inst_off, is_powered;
> +	int i, j;
> +
> +	if (!adev->jpeg.ip_dump)
> +		return;
> +
> +	drm_printf(p, "num_instances:%d\n", adev->jpeg.num_jpeg_inst);
> +	for (i = 0; i < adev->jpeg.num_jpeg_inst; i++) {
> +		if (adev->jpeg.harvest_config & (1 << i)) {
> +			drm_printf(p, "\nHarvested Instance:JPEG%d Skipping dump\n", i);
> +			continue;
> +		}
> +
> +		inst_off = i * adev->jpeg.reg_count;
> +		is_powered = ((adev->jpeg.ip_dump[inst_off] & 0x1) != 1);
> +
> +		if (is_powered) {
> +			drm_printf(p, "Active Instance:JPEG%d\n", i);
> +			for (j = 0; j < adev->jpeg.reg_count; j++)
> +				drm_printf(p, "%-50s \t 0x%08x\n", adev->jpeg.reg_list[j].reg_name,
> +					   adev->jpeg.ip_dump[inst_off + j]);
> +		} else
> +			drm_printf(p, "\nInactive Instance:JPEG%d\n", i);
> +	}
> +}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h
> index eb2096dcf1a6..4f0775e39b54 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h
> @@ -92,6 +92,8 @@
>   		*adev->jpeg.inst[inst_idx].dpg_sram_curr_addr++ = value;	\
>   	} while (0)
>   
> +struct amdgpu_hwip_reg_entry;
> +
>   enum amdgpu_jpeg_caps {
>   	AMDGPU_JPEG_RRMT_ENABLED,
>   };
> @@ -137,6 +139,9 @@ struct amdgpu_jpeg {
>   	bool	indirect_sram;
>   	uint32_t supported_reset;
>   	uint32_t caps;
> +	u32 *ip_dump;
> +	u32 reg_count;
> +	const struct amdgpu_hwip_reg_entry *reg_list;
>   };
>   
>   int amdgpu_jpeg_sw_init(struct amdgpu_device *adev);
> @@ -161,5 +166,9 @@ int amdgpu_jpeg_psp_update_sram(struct amdgpu_device *adev, int inst_idx,
>   void amdgpu_debugfs_jpeg_sched_mask_init(struct amdgpu_device *adev);
>   int amdgpu_jpeg_sysfs_reset_mask_init(struct amdgpu_device *adev);
>   void amdgpu_jpeg_sysfs_reset_mask_fini(struct amdgpu_device *adev);
> +int amdgpu_jpeg_reg_dump_init(struct amdgpu_device *adev,
> +			       const struct amdgpu_hwip_reg_entry *reg, u32 count);
> +void amdgpu_jpeg_dump_ip_state(struct amdgpu_ip_block *ip_block);
> +void amdgpu_jpeg_print_ip_state(struct amdgpu_ip_block *ip_block, struct drm_printer *p);
>   
>   #endif /*__AMDGPU_JPEG_H__*/

