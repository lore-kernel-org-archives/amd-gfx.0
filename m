Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDC10E9461F
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Feb 2026 23:14:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 80F1110E492;
	Mon,  9 Feb 2026 23:14:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xgvvjUwL";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013007.outbound.protection.outlook.com
 [40.93.196.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5184810E492
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Feb 2026 23:14:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BEVnLPIysOd0mWlf4Uq79imEzK1ziG5CYodAoPLqo58ym6d3HMXypCHxyhIZj/fg30RXmk0wqIc3KlBC+qLDCtSDAtten93aWLUhha5WEydbCVU6YuIOouiAOfzLG8d82ggw8kdHrQGAptW0Dg+Jo0oVCseqgfmTQMTHerskwbi82Dk3ETc4luq+Bj8EurCW/XGMZMVdJ7WZTiQk3AxgD66CCGRDfwFyIenW23AiOAiyS51BJ5K6qwHAKabCFnzrAl4KqQFwOiA614YrD8GzI4eEtyLffGgBylfRCN8xV4gKqB0RYhjoEw5Pt2jD9880rPfo5l1wmUBPlbfAaWNiOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E48EptMPtg1BaHlcaGXfERf9jrt/NjbdnKDF05Yj/hA=;
 b=NAo+qqIq2CZSrjdDakLSf0dAowEnldYSgPnXDUu8XFe/a3r5xhos0gO4dCXLhMRZFgxy+nhc8hAYpzs3MYH8tIYdi0MibnBgQZLB8PHFAnqjDyVtXuGd0Q9gxQaMjS1gqL1cPQ1j4wLOWPtniWu08NNlXnQR1RE0Jg82wfzl+TWmBC1YWi/Eq+x+N1n4yEoJYTBdOEk9SdU44us5fqT9zb/irkQmKskI6xXI5UiBiSPy0vLS6ayosg4UXQGhVRILh27y+JmGaz3aVfTTbRll+u6XUJfZEe8LVY+mnbH9/P1gCFsj6XCtoT1lDYFwVITH93H6t7cMNahvKTzfBthHPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E48EptMPtg1BaHlcaGXfERf9jrt/NjbdnKDF05Yj/hA=;
 b=xgvvjUwLdcgyrtZvVOo79ktxwtrNRB7o9VknNyAzEf1w+POvihbk1nmlsPBXX3aYJYrGZb7qj1BrR3leJ6+W8Fq6g7YCYCHDry0C2OYdD2JsM2wxWEEC8qdlGOPHsPxaPZKh7B0vz9d9RhLW22zOtkgb/lbAhHPvf78V8obJR6o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB8476.namprd12.prod.outlook.com (2603:10b6:8:17e::15)
 by MW6PR12MB7071.namprd12.prod.outlook.com (2603:10b6:303:238::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.19; Mon, 9 Feb
 2026 23:14:10 +0000
Received: from DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2d79:122f:c62b:1cd8]) by DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2d79:122f:c62b:1cd8%6]) with mapi id 15.20.9587.017; Mon, 9 Feb 2026
 23:14:10 +0000
Message-ID: <1667a2b2-ee16-495b-b3cd-e1a39b6a33ef@amd.com>
Date: Mon, 9 Feb 2026 16:14:07 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/14] drm/amd/display: Add support for external DP bridge
 encoders in DC
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 "ChiaHsuan Chung (Tom)" <ChiaHsuan.Chung@amd.com>,
 Daniel Wheeler <daniel.wheeler@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com,
 Christian.Koenig@amd.com, Mario Limonciello <mario.limonciello@amd.com>,
 Ivan Lipski <ivan.lipski@amd.com>, Prike Liang <Prike.Liang@amd.com>,
 Leo Li <sunpeng.li@amd.com>, Ray Wu <Ray.Wu@amd.com>
References: <20260126210837.21885-1-timur.kristof@gmail.com>
 <aYn9dPS0R5lh7hQO@atmagalia> <b98dca3d-15b3-4202-94eb-cd4063ec12a5@amd.com>
 <4945608.vXUDI8C0e8@timur-hyperion>
Content-Language: en-US
From: Alex Hung <alex.hung@amd.com>
In-Reply-To: <4945608.vXUDI8C0e8@timur-hyperion>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0359.namprd03.prod.outlook.com
 (2603:10b6:303:dc::34) To DM4PR12MB8476.namprd12.prod.outlook.com
 (2603:10b6:8:17e::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB8476:EE_|MW6PR12MB7071:EE_
X-MS-Office365-Filtering-Correlation-Id: f84b9be0-d3be-4ee8-d3b2-08de6830ee5d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aTkrQXdsdnM4Z2gvUnhaVE1oVDlLcUE2N1lHeXRFZkFyQVBzWXN3d2RKT1or?=
 =?utf-8?B?NmUyWVV4RXZrNGhCRVJzcXBXVDZ2NTNMblpYOTVpdkQ1OUtiamQ5ZkxRVEhG?=
 =?utf-8?B?NnhqR3d0R1dvNmNNMTJ4SjUySjNMMzM1NFdPaVFqRGdqTVU1VkdMNlMwMHN5?=
 =?utf-8?B?R0dtd3ZrUUdBUEVLNHZGQU9VSHZkOW5yRXp3ZFBsL0YxQjFpaVRvY0JMYjMz?=
 =?utf-8?B?dHJuRU1hVXNXZDVDbHV4cTAvazM2dkNpQVZBNk1QMXFOMGk4aDlnaWhGZWJT?=
 =?utf-8?B?Si9temN4azZsdFUzVXl2NzlSYk04cWNXUWV4SG9idmgrVXYrVndvYklnYTdP?=
 =?utf-8?B?V0tRZHN2Q0NJNzNsZy90S2lpL3p6ZWsvSjVVejZJM0pZUkh5bU1Bamx0N2FZ?=
 =?utf-8?B?SFlndUxvbVV3V1MrN3VCL2loSmR1c0xicVF0bm1jQmxTSHZENUVPZEtjRHQ3?=
 =?utf-8?B?Zkx5SHh4Z0huNDFwVTF6Slp6Z0VKTGFlanZ3TnZyaE1DMmt0cmVlK29KT2Ji?=
 =?utf-8?B?SzNmQVpDT3JWY0RTb1JhWW9HVVdBY1hvb0JZVncySGlwYXp0eDdvOHJ0MExt?=
 =?utf-8?B?Rjd1bCtvQVVtVE9oYzRya2VPRjMrV3pYOTk1NCs5WWhHWVZkaVlxUXhqSWI5?=
 =?utf-8?B?UzFHQ2hHU0s3Qmp4ZFRFbXc3RWZadjFLYlFqT3BoYmVnR0hjMjFWb1RYdkZi?=
 =?utf-8?B?V2EyUi8xQjVRL24yKzFuWGdkQkdIU1FnZy95enRkN2JDOW02bjJvQWx6MkVa?=
 =?utf-8?B?b0o4YjBZWmo1WnRuR2RWQkd2NnJNSnJRMTlSYTNYRUducWs5VVIxWWt1clVK?=
 =?utf-8?B?NWVsSE9MM3NkL1Bwa2dlcTl1UUgzUjZHVkZVbmIvZ200cXBjV0t2TnRSa2Fp?=
 =?utf-8?B?WjkyMVBNVmtsN3FYalNET1hZRjUxbmxxR2NkWnEyVDltUmhGdSt2Z25jdUlE?=
 =?utf-8?B?OEFObWx4Snhsb3JUTzRKRHJGcHlxWUZrN1JLbzNJL2RGM1U0VTZuVDlqWlBY?=
 =?utf-8?B?MzdRUG0vQ1YyU0UyZ1drMFZCLzdyOGtqaktnSTFFVEx2MHZGZ1A5d2h0ZVlS?=
 =?utf-8?B?QkdLS3JtL2E3NnltR0ZwMXZEUWVacjhESm9zOTRPamMzVEtlbmVmVk51c0U4?=
 =?utf-8?B?S1FZbldVNHFIUDdDdC9PT0RaMTB2Z09YNmQxUDJTZDRtU3dxempPanRjZVhQ?=
 =?utf-8?B?RlgvQ08zVVdsRUpVM1RCR3BtbmhKdy9FTWRQbGZubGNvOVd5d1RqL2RReFpU?=
 =?utf-8?B?cWovREVkWWo1UGxQNVlKU2R4emwrVzhndTlyK1pKcVh2ZUVPQTdpWlk1aE4v?=
 =?utf-8?B?MDVTVHhmT29wSlNrbEthM1M1a00wREhXd0hXUUs3NEpnSTNUNDJXcUxVOVJo?=
 =?utf-8?B?QjA2dmkzY1g5RVNiY0hac2pkWTdwaldVUUQyRC9iR09yZm90S08vNU1nR0Ru?=
 =?utf-8?B?bTRsdTZlbXJ4TXdOa2RUT0Nwa3JhTWVnbFJUQTZjUlUwNEJnTzBYVUkvVlhX?=
 =?utf-8?B?amk2MHd1bjdMVnhSbUpzVHk0UXF4WXpTVTN6ZzNPamxLci9XK0NrSi9FT2xT?=
 =?utf-8?B?N3F2cTdEMmZNbnJtRXM5YnJudzNlYWNVQjJSS0VJZFdsZ3VTdzRicFNzeUFG?=
 =?utf-8?B?L0JtZ0dhMjg2dXB4YWI3TnF6L005eE8rTGpsMW5mVnRQbHJwTmlPVWhQMzdj?=
 =?utf-8?B?RXFxVnlFeXp0YjJURE1hSHdTdWZBaXpEeURFMktvT0hiMXUvMVNpWFkrcmY2?=
 =?utf-8?B?anZoS1pkVTd0czgra2UweDJHODRSdTU1a0c2V1Y1N1pCbUpiRy9BNmpFb0o5?=
 =?utf-8?B?RE5ycVBCRXFVakNsNVp5ZDl0QXJmSjhuUzdJeGdaa24xNlY4YTJhbVFqV3Q4?=
 =?utf-8?B?OWJub3I4Sm1IWkV4NXN0UmNNL2VhRmJxOUs5OWdOVnd6cm82VVByaWhWUTdK?=
 =?utf-8?B?NkxZVFFiVEZBRldSNkM0NFFlMjYrV1dBUzBDYjZHQzZMVkI5TG84c3JRRExK?=
 =?utf-8?B?WkVWd01wYldxaFJrampucDJWY2svdVkreFpDVzF3Z29LbDc4UlovRmliZEN6?=
 =?utf-8?B?cDJtTyttc3NsWUdTMHlkeFN0YnlXQmFDT2NhY25Hb0QrRDdVQWljdUhialdT?=
 =?utf-8?Q?Dj/4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB8476.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Tmw2WGNreWFXYjRHTEptRjBtbjV1MklmM1BLaE51bUZIM0pLWjhkT3hGVzEv?=
 =?utf-8?B?cjM3K2hYSDIza0FHSmMreFNZeDNIZzJJWFpOMHBIM1BzZ0YyR0JNenJHbG1P?=
 =?utf-8?B?bXMrWlVhRm1TZ09iaDlEbFA4b1JpaWMxamNpbzhUS3JrZWszRnd5ODkwUUtH?=
 =?utf-8?B?dHY1cDA5dWN2QUpUVVA4OFE3MEhkcnhSektHQzh2NnRRQ0dOVU9ZSEtIejRN?=
 =?utf-8?B?a2xYdmZnV2t2NDVWaFpCbkVuZW9xSUhtcjIybHhiMnZtYzRJOGtjeGRnNk1k?=
 =?utf-8?B?NWV0NEVGT2JPY09aNDBQTnJTaXBlNHpDdTNPR1RocnRNVVN0L0FZdkpjRGw4?=
 =?utf-8?B?Zk5mOHdqbjdZUlkyRmsrTjJyeFY0Q1l4RTJjWis0eGpHNUo4VHRjZGlKeTJm?=
 =?utf-8?B?Ymp1ZzZNcXpOQVJPcHQ0bGtSamRxU3l1Y3ovSGNDaWd4NmJGdzN4YVpFaTIv?=
 =?utf-8?B?SS95L294WEZoSm00RS8vSks0WGhFY1lja002NlYrMWZlQVV4aHJOY3VVMVNt?=
 =?utf-8?B?UmNOam0zdWxQN1Z6amhONmxTS2loYTBnWm5sRmtnU01vRlZKR1pZZUlMSFBw?=
 =?utf-8?B?eU1SVkExMkdUZnU5T3g3M2Z0K0xNZk1YSGx2YTR5eXJtY01vc05scFJ2NWht?=
 =?utf-8?B?SWZac3dubVREVWFLR2pVUE1BeWJPY2FHY29NU09Cb3BzVWNETmdGQ0VTNVRx?=
 =?utf-8?B?bWplZ3ZlVWlaOS9LZ3BrVGprUUpXNHF5RU1idHNJdVZ6dXZVSk9pK0xWNWNY?=
 =?utf-8?B?YjU0VURGSGx6L2VtMXIrZ3hkRVBHT3pZYnQwNjFyRU5SeWFMaGd0c2pyQWRq?=
 =?utf-8?B?V09nQ2l4QkpDeUhHZ09nNlFVMEt2OWowTTEzU2VhNDY0bnQ1Mk1WMkJwekgz?=
 =?utf-8?B?Ynhac0NqSHNvN1lFZ3g2aG1TREFPZmxQMFMrang4NXFlOHc2TkRuVkdSbngw?=
 =?utf-8?B?TlhIMDJYZFdzNVVDVnNSNktNa0xJZ3VjSGpxYW9GTHFadVlLVEE3VE1BMExz?=
 =?utf-8?B?NmxRZ3VzWjVXM1FUdXNidkY4RVQxMEpwcEFLWDB1RkdSQjVaYi9OUTNaa294?=
 =?utf-8?B?QllDQnRTU0FkL0twTWNxM0ZPdjdQY0tTTmQ4OHllRzdWQTR4TnNtVFBmYWFO?=
 =?utf-8?B?RG5WVFc1RkhMRlFuRzFndlBxOWwybnEzbFhLTVNiMjlUNjlpb1lxcy9nZDVJ?=
 =?utf-8?B?M0lzektWS2ZrU20zQVhXMHNvbnFzVkgyREFIWWpSQS9SUUlpQjVlOFpIOVNn?=
 =?utf-8?B?M1hGckVIRjFLSmVLMXBCQ3c5K1dCV3RDNEh0UEdrcDV5RGZuaXRpSTZkaGNw?=
 =?utf-8?B?a09OSnFpcGd5MFJrdHFuUWpaczRuQ0kwWWFmSlBMNGNYOUU1aHpkbW9hblV6?=
 =?utf-8?B?ME0wNkYybkZYb29XTzQwbVByZC9WZ2xocEc5SFZ6ZkpBNEhGY0F6UEM5bVZE?=
 =?utf-8?B?UWNuQjk1dVhQUXFHRnlNN0t0VmtIQU1zL1c3cmtCWFE0dk5lTmFLQ1dxYVUx?=
 =?utf-8?B?QVBXdnhPeXFUZkNrdE9aejlnb1ZMT3YxQnAvVFppdzUwQVdRclplbXM5Q3V0?=
 =?utf-8?B?RmorS1lkeklmdjdzYmkrWk1XMEQrSlV6V0RmSkhBN2ppYkhFRUZDZWpqa2hH?=
 =?utf-8?B?VXBCT3FIZE1UTjNJaE5iSGZlZVdLQ2FqU0hpVUNOMXAvTUVMVFN6ak1iMEVZ?=
 =?utf-8?B?Z2xBcnRUbFhMSHZpTy8vemhUUHdHaDNnRFNEaHBoSFBLQzViUXpKSFBYaEE3?=
 =?utf-8?B?OC9WK1JqaDNLK3JYY2FFek9hWWd4WUdoSkFvYkJ6ZEhzRFd4Wnk0blB2R1ht?=
 =?utf-8?B?b2V2TkR5THRHMTBwM2dUUFE5WngxTUVseTdTQWxTUFRVdGFDZVdXbUVML1VU?=
 =?utf-8?B?MmJYblRtSzhuM3FxN3pzRjFnbTdiRnVsbmJSN3VYZFlBUEpsNTFsYTU5UjZp?=
 =?utf-8?B?dkR2aktTaHFiU3kzQ0J6OTRYRGo5azdnMUlQUXF1cnpweXRwM1BqUlFuWEhu?=
 =?utf-8?B?RXI0VEJROXM2c3BVSm5hallIZkRDb2ovN0dHRXI0M08xVElIVUFPU1MvUENW?=
 =?utf-8?B?c0ZFdE5xZFlsRlJDRU5xN0RJbWpWTWp2TmMrcmFkZVlMZU9yWW5sR3RZc01u?=
 =?utf-8?B?Rk1zREdteHBqaG8wSHUvU0M4V3pudllrT1ZhbEEvQXRGYTN4WUhOZzhtR1h5?=
 =?utf-8?B?NnZMYmdVN3o4L0twcHZhYmRiNitrM1BqWlROOTFwMytIamgzNnFEdHcrbnha?=
 =?utf-8?B?YWs2ZGdoeWE1cVpIRTRjVFhMYUlkRFc2eDZDQzFxSXBLeTcvQ3hkSXZGUWp2?=
 =?utf-8?Q?CprIgPCCTEjRo5LiVy?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f84b9be0-d3be-4ee8-d3b2-08de6830ee5d
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB8476.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2026 23:14:10.3029 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TY1uKOjLazmUYY6bAUCG9SNJbpxFmK6OQqvJy/OXTPTRlvqSA8WveHQvGLuPPaMRqA16Ij6litsg8Wj1TWk1+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB7071
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



On 2/9/26 15:10, Timur Kristóf wrote:
> On Monday, February 9, 2026 7:12:23 PM Central European Standard Time Alex
> Hung wrote:
>> On 2/9/26 08:35, Rodrigo Siqueira wrote:
>>>
>>> Hi Alex, Dan, Tom,
>>>
>>> This series is the last to enable amdgpu as the default for all GFX7
>>> GPUs. In this sense, could you include this series in the weekly
>>> promotion to check whether everything looks ok from a feature
>>> perspective?
>>
>> This series was included in promotion test in previous week and no
>> issues were found. However, it breaks CI tests and we will figure out
>> what the causes are.
>>
> 
> Hi,
> 
> Can you say which tests are broken, and on which GPUs?
> And which patch of the series is responsible?

Some internal diag tests failed so we will into them ourselves. I don't 
know which patches are the cause and I will provide updates later.

> 
> Thanks,
> Timur
> 
> 
> 
> 
> 

