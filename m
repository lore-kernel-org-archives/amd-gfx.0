Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3247FE7717D
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Dec 2024 10:54:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D279210EFBE;
	Fri, 13 Dec 2024 10:54:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="k4ap/JY1";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2060a.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2415::60a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DCB7210EFBE
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Dec 2024 10:54:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nz2KS5XpQ4HFVjEXO76xtyQT9tYnY1zvUGKWnsQxUnxryVif3OHvnUPkfBjj2LmYjujB+wproEIeOJqV8tN3TJ7y8cND6RXvQtBRMUx4xGtWF1/tEBF4G5wAur4AmhrML/yMSAPnsd5ZwEyDnK1WATjwhZGhwiY4dMCosoH2e2EkFUnYT6hyzKpEH76NRCHvYbgiXrUuYBSweSGTvqie/ZKVTbOWkdfrVB4fpoOrwE37DLs+7nus+biqXDDtMLujnH3QvXo0S0QHRznfXXw2RACzAAjPSBfl+iEYLd5viXuq8emWofj5zJus6n8GQhzIFYudGQhuadciHSb/X1Q/Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v17U++BKGBoYN2h7ki6MSyBj+De81i/qqhp6Ukyj6nw=;
 b=l0xY6IoCoH+9w1/U6NbAsYR51E/deH9ty0JOW271poOPtJG6lMJnsaztx2poDKL6ApZMRAW4S+CTHnl1ilJ3/WN0sAECI0dgsDIOLFR2w2nzgqEtyRG6OZHGqO3kyppG1LpDSVN6J5hwlzihEPzJDrxcKxeqRceohwhr9KisNac4FSZR/XEtKS73v2mgdxBWYIXGMdaSzLDBAXtsVbgXHxpJ9umlb4iHM1v3zuLE5NbCZsu7c4ekDISNxE1E/ImiQY0wG7yyudKAg8CWYvEULgPG0EkDNvSCFmRYmgRIrfZvs4WdyiLAq1o4wiwYIusr9dQqKfAkbQxaFL3ORldsrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v17U++BKGBoYN2h7ki6MSyBj+De81i/qqhp6Ukyj6nw=;
 b=k4ap/JY15Y4xjEVB/WhbV0uHHi7rcd9ZnddXV0OrWRy52+jNkGQSKBgBNHkmuT7Kx1E3/vGMBoyl+G3380hi5rabba1ehpL4bbW7g71MBYkznk75L90gmUn8ImHR1SBBe6wluJcj2bA/zPYeg8+CyVYKIDrsyHyNxDCMkNcZRvc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SA3PR12MB9178.namprd12.prod.outlook.com (2603:10b6:806:396::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.16; Fri, 13 Dec
 2024 10:54:41 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%5]) with mapi id 15.20.8251.015; Fri, 13 Dec 2024
 10:54:41 +0000
Message-ID: <816653ec-b44b-4923-a47d-81857643276e@amd.com>
Date: Fri, 13 Dec 2024 11:54:35 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/7] drm/amdgpu: Fix wait IOCTL lockup issues.
To: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com
References: <20241212142533.2164946-1-Arunpravin.PaneerSelvam@amd.com>
 <20241212142533.2164946-6-Arunpravin.PaneerSelvam@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20241212142533.2164946-6-Arunpravin.PaneerSelvam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0027.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1c::14) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SA3PR12MB9178:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a35a8c6-2db2-4953-a666-08dd1b648b9e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WkZoa1lRZVkwKzg5RTd4YmhWa3VFTkpwTHVvNEt6TjFINU9yT2JOL3VTbTB4?=
 =?utf-8?B?ZklJNjFJVHdNYTVEalNkNGF1NVRFSmllNFFRTjBFcGd4V1BOeFJkVjVSZ094?=
 =?utf-8?B?blhNNi9wdHZ5UmJHcXNhNjE2dkoyQk1HdUloWTNNdXBSQWQ5M25DKzVvRVVu?=
 =?utf-8?B?LzQ3YWRCWHZpVm45aWs1YmtJWWQ5ZVl0UEtqaStzcVFGbjlQT0dKQVkyN0Ix?=
 =?utf-8?B?R1NsdnoySDk2NThnYTZVS3pSYm9ZYTBGVlhVN3lTK1NNc2tKYzFodWpxZWdi?=
 =?utf-8?B?S3lLa2ozYXJWeFBmTDdwc0JwYlZxaWd4SUg5OWNOQytWTUJqNU1paENLcU9q?=
 =?utf-8?B?Q2FyY01UQVdTWVdFY3NDOWJvWUpaWmYyUEtxck0yNVVjZlJpclN3bzZlbWE0?=
 =?utf-8?B?UTdCbzltYnpHeU9walh2S0pCV0k1V0loRExONENQK0h4L200OEpISU4rczh6?=
 =?utf-8?B?YjlnQnVBcTV2eTNDK2crTGhORGRHU2F2VSt6V3NjdGZBdTB1dTJMdFlMWVVQ?=
 =?utf-8?B?Uy9EdFN5NjlMcEtIUEpiZS9zVnZQdVRINzlwejBTR2UrdFdkRmREZUExSzMr?=
 =?utf-8?B?RjZuc0NUWG03MGZ4alA1NzhTWjd6cUw3cE9xdWJyN282ZDBQeXhFemdmVmdP?=
 =?utf-8?B?MUE3UDR4eElzUDVOZk91QjNmWlpYcXdxQ25DQmJwYjdDUHVZYXJoM0wwVDFi?=
 =?utf-8?B?NE9ydkFoQTVTTG8wa01vb0xQR2tDUGwwaDhvRGh1ZE9UNkswNS9mL2hUcXVQ?=
 =?utf-8?B?SXJNZzA5YlB2b2VqMG9WNy9NZmZ1VTlxNVFlaWJmVG90a0VVZnRZUE00Qi9Q?=
 =?utf-8?B?SWQ1NVNDeStMTnpLMjNSSUxON1c3S2FrTjF6eWdkRWY3dXE4bjRNM0JrSUhK?=
 =?utf-8?B?bTlWajdJVXVXalNxZ0NGWHIvWnZjSTVEd0NLbzhqalRNSW1tejZkL0hFRGxu?=
 =?utf-8?B?U2hxRjExOXpCcmhYelV0aXFYcE40SVlOdVJoS0tWZktLUjRUOUh4STBhM2hH?=
 =?utf-8?B?YkYzSm5STGhLaDhLWXhMelpyK2p4b2RqTFppa2dyMURyUklkb3A1VjlSQ2xl?=
 =?utf-8?B?S0Flby94eG43OGVudFZjYmNpL1kvZ29IT2Fkc3lTWFpJY1pJK0dtWk5sU090?=
 =?utf-8?B?R0MvUTl1K29idmVoSU1DZTRtOEtQbWlvMmdjUkJGNFV3eGlDVlBORTdyQjFX?=
 =?utf-8?B?OFVkUlBKa0JzZm5zcnpBZnV5UDdFTytxS1AwRFZqelNzMmU5bk1ZNDJVWWZS?=
 =?utf-8?B?ZkNrYjRWb2gxVllBaVJRR2JhazI3WlI5ZGxtck9Wa040dlBmeGpDYU5YZXpz?=
 =?utf-8?B?eWNkS2tPK3h6WnRqamhSRm03WmFxYzFhVmI1R2hPSjR4K0tab1RUbmZrbWJ5?=
 =?utf-8?B?eHp2QlNmT2puWjlBd3dteVI1ZGR4TUFNZmkxaTA0Q2JXT1Y3a0I3VHphbjhX?=
 =?utf-8?B?SldOcUdsODhSemlwTGdhZmpZV2Z6Q2RZR1E0V3plVmJxVCs2Y2VTZ2E5Q2VI?=
 =?utf-8?B?clh2VTZXQUxEdWZ0aFAySlBBUGJiK2V4MlhEdXZZM2wreUNoYVZubmZaRWhB?=
 =?utf-8?B?dHA4M1Q0Yy9UY09hUDlxSE8wem1aRUJROFc3WEFsLzdrLzJydUNWRDFESm1S?=
 =?utf-8?B?UE1ZVFlHbklRUVI0NHp5UWNwN0NnN2IzYzB0b0RDY3h5K1dhQ01COVNOa3Nm?=
 =?utf-8?B?NzJEazlsallaMTlBeHFGeW5qOHZXdWJidTdHQTIrY0hFMDBTYkRHNjgxYjVF?=
 =?utf-8?B?SzlZMExDd0FlZFNGOFVlOE9sOTNNbExBOWV6WFZMZzlpbHQ1bVZEYkhKVGRz?=
 =?utf-8?Q?44N9cYiby3pgs2s2PCKaCbmjk2NtuwN1mPXeo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T3JoYm9GSC9ZNGloN3pVTC8ramYxUkM4cHgwVDkvVXg5TXdTZSs2RDBnZEhn?=
 =?utf-8?B?WFhIQjN2MnRNR1hwejh2aXhleWl0RllvNmxvdzRSSDU1R2t2QVU3NzV5SDdO?=
 =?utf-8?B?djA1Tkx5VVhRV0IxeEhLb09CL1Q5SUZGa1NlSTdDb093QmV3TEhKN2VrYmxX?=
 =?utf-8?B?NU9hN3V3Nm0vVDRWOHBGNThMU3gxMnVwOWE0ajhFTm40UWQrQlhUZFJjWlNj?=
 =?utf-8?B?Vjd0b2R4SGw0c0FrZFF1YTFONGEwUTdtYVNqRlMzQWRzTkpBU1JkaHlmVVNV?=
 =?utf-8?B?VU54YzZrbUs5M3Z5ZHZRQWUyN2FHRnoxaVZkaVBydzltVkhnanZmaS8xL1p5?=
 =?utf-8?B?L1duZ1ZkVlNJb0hQdVZvNE9HVDRaaWVuQ1BUVDh4emFpR2JNb1BCQ3VaM2dQ?=
 =?utf-8?B?MU5RZGxnUi9XbjlHTXVVdENsVk9RTTBjZnIzYTZzYUI2ZE5QREw2ZWdTUk5n?=
 =?utf-8?B?ekFkYW5UTlVobllTT0NVSllnaHBOREl3T0ZsQ2RKdXo4S0pHaG5PWVpDRUdG?=
 =?utf-8?B?dEtlS2JwU3FjOU5kN00xZVVScEZnYVg1Z0Y2ZVBVSCtjR1Q1UzZpZjJjVHp4?=
 =?utf-8?B?S3lmcXY1SE9Eb0Q1UDdBTWM5Q1VKakp4V3NQSGJUZlF5Uy9uNjRuS3kvb3gy?=
 =?utf-8?B?UmRCVkVOUmdSbFBOVUswSlV5WkpuaGpCdVVDSlVxc3ByRGN5NkVQU1NaMG02?=
 =?utf-8?B?enBsRVR2R2pvZDY5N2Z4Q0ttNFNNM1BWUVFXNytTT1pYY3pWZHBFL2QyOVRW?=
 =?utf-8?B?YUVKL29mSXFhNVExbWt4TGJ0bmxtL25hclpLWVdZcFFNZ1JLOWIzSXNCSk1W?=
 =?utf-8?B?OC9sekQxZHU2em1uSmhVdDM3WmF6cVR2NVl3Z3YxN0ZmNGE4c3hpT1RuOW9R?=
 =?utf-8?B?SlJNYllic3BIcS9KL3VUQ1pxT3Q4VXFadWRtczVSY0g2TnJCSHZoaEdFMTcz?=
 =?utf-8?B?QVVNTUZKMnRhc1BHTFhWWHlpdTJUUWlaWHhSZ3lIM3MxcDU1RnJONXhIRktB?=
 =?utf-8?B?V0o1QVdxeW5TY0RBdjJDTFNaUm1pb1pEYlQ1YVIxakN0M1hnanlydHdZZjVx?=
 =?utf-8?B?V3BPc290WWlnL1BKZFdUSlM3ZXBBZEdud1FTdXlUazVDb0Nnb0lQWEViUjEw?=
 =?utf-8?B?RGVqWnNaT0JESnlPaWFaUUJsSnZXekhUVDB1NHd2UFRuRlhQWE5QOTIyWGdp?=
 =?utf-8?B?ZzdRQTZRUU9Yd01nSXNPcTI1d1BwZTlqR2hxNzN4cEhHSlRaekI4VlliRFds?=
 =?utf-8?B?eFh5blppOHRZNENqT0xKeXQ0RWxKSWFUSjVpSFlPRXB4RUo1WTdXOTNFeTVQ?=
 =?utf-8?B?dENLU1FVd1hQaUVjbkw5OFNpS1hhZmt5cENGdk52QWNjWGgra0xQZmQ5RmRa?=
 =?utf-8?B?dUFicjdBK1hUTXlhRFprY0l5WWNnc0NVZkNJVlpLVVYzMlNYN3JXdi9lbm00?=
 =?utf-8?B?Y0hrczJ2TmRoWFlqNFcxTHE4eVYrdVZoK1lRRDdoZE9KRVlUSjNrNUYvcUYw?=
 =?utf-8?B?ZjJVVitYbGlFcmRvcEIxaHY0U2c4NVRjS1gvb01ia01Cc3BraWpnbzAxUmpO?=
 =?utf-8?B?RXFKc0VHSS9NaDdVT0M5VjNENGRHTm1LRkF1MkVLSWRiOU5EYkQwVG1QUmsv?=
 =?utf-8?B?eC9OeVU1V3JkUGFuMW5EYnVDbmc5SzA5UHc2UU9TVmlIUVpwYmlqRGtpcUpS?=
 =?utf-8?B?Z2VvdnRibWd5YnhIWEVOY2Y5ZHlHRlNQOUNVcUpZbk5pSSswSlp1a0FOM3dr?=
 =?utf-8?B?cUFWVzcrVFFST3hiMDZnZGhydVNaR1ZrcC9VejU4QWxxbXhHeWdjVUNmOE41?=
 =?utf-8?B?TDlnWHRaTmdzbnMzcXZDMnh3dENjLzJTRzlYYTUzdG5jc01PWFp2SW9KL2V6?=
 =?utf-8?B?YjUxclF2YnlhcU9BaEhzeDUvR0FjTGtYRVorcnQ2M1NXNkxjUWtYVER6Q0VU?=
 =?utf-8?B?TUx0ME9vaEtIYkVrNEVESDZxeUtuU0U2V281OTAyRTRENTg3RjF4d1ZqUzdl?=
 =?utf-8?B?bnhtWHZPR21UU3VEKzBEcDdLb25UUVpaMWREY2hYUXM1aHFKa2RHdWcrekNv?=
 =?utf-8?B?SFNac1MzL0UzTHVpTjN0V29CNGZyNkZRSDExVHdoQ3RDWmZYd2tXVEVGTFJx?=
 =?utf-8?Q?V64JxafAXFmZ2zLW96iQwpap7?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a35a8c6-2db2-4953-a666-08dd1b648b9e
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2024 10:54:41.2483 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LoObbUwG71DLLVzmuZnpIfLbeXssMWwBSju93ET46vKcioziWHtct7aef5pFi+wx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9178
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

Am 12.12.24 um 15:25 schrieb Arunpravin Paneer Selvam:
> Fix the wait IOCTL lockup issue.
>
> [Dec 6 17:53] watchdog: BUG: soft lockup - CPU#4 stuck for 26s! [Xwayland:cs0:2634]
> [  +0.000002] RIP: 0010:amdgpu_userq_wait_ioctl+0x3ce/0xfe0 [amdgpu]
> [  +0.000003] RSP: 0018:ffffada901f4fc38 EFLAGS: 00000202
> [  +0.000003] RAX: 0000000000000001 RBX: 0000000000000000 RCX: 0000000000000001
> [  +0.000001] RDX: ffff9fc28b974048 RSI: 0000000000000010 RDI: ffffada901f4fce8
> [  +0.000002] RBP: ffffada901f4fd58 R08: ffff9fc28b974148 R09: 0000000000000000
> [  +0.000002] R10: ffffada901f4fbf0 R11: 0000000000000001 R12: ffff9fc28ed1ac00
> [  +0.000002] R13: 0000000000000000 R14: 0000000000000010 R15: ffffada901f4fe00
> [  +0.000002] FS:  00007f3a00a00640(0000) GS:ffff9fc99e800000(0000) knlGS:0000000000000000
> [  +0.000002] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  +0.000002] CR2: 00007f8e92137020 CR3: 000000013380e000 CR4: 0000000000350ef0
> [  +0.000002] DR0: ffffffff90921610 DR1: ffffffff90921611 DR2: ffffffff90921612
> [  +0.000001] DR3: ffffffff90921613 DR6: 00000000ffff0ff0 DR7: 0000000000000600
> [  +0.000002] Call Trace:
> [  +0.000002]  <IRQ>
> [  +0.000004]  ? show_regs+0x69/0x80
> [  +0.000005]  ? watchdog_timer_fn+0x271/0x300
> [  +0.000005]  ? __pfx_watchdog_timer_fn+0x10/0x10
> [  +0.000003]  ? __hrtimer_run_queues+0x114/0x2a0
> [  +0.000006]  ? hrtimer_interrupt+0x110/0x240
> [  +0.000005]  ? __sysvec_apic_timer_interrupt+0x73/0x180
> [  +0.000004]  ? sysvec_apic_timer_interrupt+0xaa/0xd0
> [  +0.000004]  </IRQ>
> [  +0.000002]  <TASK>
> [  +0.000002]  ? asm_sysvec_apic_timer_interrupt+0x1b/0x20
> [  +0.000006]  ? amdgpu_userq_wait_ioctl+0x3ce/0xfe0 [amdgpu]
> [  +0.000162]  ? amdgpu_userq_wait_ioctl+0x3cc/0xfe0 [amdgpu]
> [  +0.000156]  ? finish_task_switch.isra.0+0x94/0x290
> [  +0.000010]  ? __pfx_amdgpu_userq_wait_ioctl+0x10/0x10 [amdgpu]
> [  +0.000161]  drm_ioctl_kernel+0xaa/0x100 [drm]
> [  +0.000025]  drm_ioctl+0x29d/0x500 [drm]
> [  +0.000017]  ? __pfx_amdgpu_userq_wait_ioctl+0x10/0x10 [amdgpu]
> [  +0.000160]  ? srso_return_thunk+0x5/0x5f
> [  +0.000004]  ? srso_return_thunk+0x5/0x5f
> [  +0.000003]  ? _raw_spin_unlock_irqrestore+0x27/0x50
> [  +0.000004]  amdgpu_drm_ioctl+0x4b/0x80 [amdgpu]
> [  +0.000141]  __x64_sys_ioctl+0x95/0xd0
> [  +0.000005]  x64_sys_call+0x1205/0x20d0
> [  +0.000003]  do_syscall_64+0x4d/0x120
> [  +0.000004]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [  +0.000002] RIP: 0033:0x7f3a0bb1a94f
> [  +0.000002] RSP: 002b:00007f3a009ff870 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> [  +0.000003] RAX: ffffffffffffffda RBX: 00007f3a009ff9f0 RCX: 00007f3a0bb1a94f
> [  +0.000001] RDX: 00007f3a009ff9f0 RSI: 00000000c0406458 RDI: 000000000000000c
> [  +0.000002] RBP: 00007f3a009ff8f0 R08: 0000000000000001 R09: 0000000000000000
> [  +0.000002] R10: 0000000000000002 R11: 0000000000000246 R12: 0000561824bf39e0
> [  +0.000002] R13: 00000000c0406458 R14: 000000000000000c R15: 0000561824a25b60
> [  +0.000005]  </TASK>
> [ +27.998164] watchdog: BUG: soft lockup - CPU#4 stuck for 52s! [Xwayland:cs0:2634]
> [  +0.000002] RIP: 0010:drm_exec_unlock_all+0x76/0xc0 [drm_exec]
> [  +0.000002] RSP: 0018:ffffada901f4fbf8 EFLAGS: 00000246
> [  +0.000003] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000001
> [  +0.000002] RDX: ffff9fc28b974048 RSI: 0000000000000010 RDI: 0000000000000000
> [  +0.000001] RBP: ffffada901f4fc10 R08: ffff9fc28b974148 R09: 0000000000000000
> [  +0.000002] R10: ffffada901f4fbf0 R11: 0000000000000001 R12: ffff9fc28ed1ac00
> [  +0.000002] R13: 00000000ffffffff R14: ffffada901f4fce8 R15: ffffada901f4fe00
> [  +0.000002] FS:  00007f3a00a00640(0000) GS:ffff9fc99e800000(0000) knlGS:0000000000000000
> [  +0.000002] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  +0.000002] CR2: 00007f8e92137020 CR3: 000000013380e000 CR4: 0000000000350ef0
> [  +0.000002] DR0: ffffffff90921610 DR1: ffffffff90921611 DR2: ffffffff90921612
> [  +0.000002] DR3: ffffffff90921613 DR6: 00000000ffff0ff0 DR7: 0000000000000600
> [  +0.000002] Call Trace:
> [  +0.000002]  <IRQ>
> [  +0.000003]  ? show_regs+0x69/0x80
> [  +0.000006]  ? watchdog_timer_fn+0x271/0x300
> [  +0.000004]  ? __pfx_watchdog_timer_fn+0x10/0x10
> [  +0.000003]  ? __hrtimer_run_queues+0x114/0x2a0
> [  +0.000006]  ? hrtimer_interrupt+0x110/0x240
> [  +0.000005]  ? __sysvec_apic_timer_interrupt+0x73/0x180
> [  +0.000004]  ? sysvec_apic_timer_interrupt+0xaa/0xd0
> [  +0.000004]  </IRQ>
> [  +0.000002]  <TASK>
> [  +0.000002]  ? asm_sysvec_apic_timer_interrupt+0x1b/0x20
> [  +0.000006]  ? drm_exec_unlock_all+0x76/0xc0 [drm_exec]
> [  +0.000004]  drm_exec_cleanup+0x77/0x90 [drm_exec]
> [  +0.000004]  amdgpu_userq_wait_ioctl+0x3cc/0xfe0 [amdgpu]
> [  +0.000206]  ? finish_task_switch.isra.0+0x94/0x290
> [  +0.000010]  ? __pfx_amdgpu_userq_wait_ioctl+0x10/0x10 [amdgpu]
> [  +0.000159]  drm_ioctl_kernel+0xaa/0x100 [drm]
> [  +0.000026]  drm_ioctl+0x29d/0x500 [drm]
> [  +0.000017]  ? __pfx_amdgpu_userq_wait_ioctl+0x10/0x10 [amdgpu]
> [  +0.000163]  ? srso_return_thunk+0x5/0x5f
> [  +0.000005]  ? srso_return_thunk+0x5/0x5f
> [  +0.000002]  ? _raw_spin_unlock_irqrestore+0x27/0x50
> [  +0.000005]  amdgpu_drm_ioctl+0x4b/0x80 [amdgpu]
> [  +0.000143]  __x64_sys_ioctl+0x95/0xd0
> [  +0.000005]  x64_sys_call+0x1205/0x20d0
> [  +0.000004]  do_syscall_64+0x4d/0x120
> [  +0.000003]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [  +0.000002] RIP: 0033:0x7f3a0bb1a94f
> [  +0.000002] RSP: 002b:00007f3a009ff870 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> [  +0.000003] RAX: ffffffffffffffda RBX: 00007f3a009ff9f0 RCX: 00007f3a0bb1a94f
> [  +0.000002] RDX: 00007f3a009ff9f0 RSI: 00000000c0406458 RDI: 000000000000000c
> [  +0.000002] RBP: 00007f3a009ff8f0 R08: 0000000000000001 R09: 0000000000000000
> [  +0.000001] R10: 0000000000000002 R11: 0000000000000246 R12: 0000561824bf39e0
> [  +0.000002] R13: 00000000c0406458 R14: 000000000000000c R15: 0000561824a25b60
> [  +0.000006]  </TASK>
>
> Signed-off-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
> ---
>   .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   | 122 +++++++++++-------
>   1 file changed, 72 insertions(+), 50 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> index 49dc78c2f0d7..5c39681c9720 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> @@ -383,6 +383,34 @@ static int amdgpu_userq_fence_read_wptr(struct amdgpu_usermode_queue *queue,
>   	return r;
>   }
>   
> +static int amdgpu_userq_exec_lock(struct drm_exec *exec, u32 flags,
> +				  struct drm_gem_object **gobj,
> +				  u32 num_handles, unsigned int num_fences)
> +{
> +	int r;
> +
> +	if (!exec | !gobj)
> +		return -EINVAL;
> +
> +	drm_exec_init(exec, flags, num_handles);
> +
> +	/* Lock all BOs with retry handling */
> +	drm_exec_until_all_locked(exec) {
> +		r = drm_exec_prepare_array(exec, gobj, num_handles, num_fences);
> +		drm_exec_retry_on_contention(exec);
> +		if (r)
> +			drm_exec_fini(exec);

You need a "return r" or break here.

> +	}
> +
> +	return r;
> +}
> +
> +static void amdgpu_userq_exec_unlock(struct drm_exec *exec)
> +{
> +	if (exec)
> +		drm_exec_fini(exec);
> +}
> +
>   int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
>   			      struct drm_file *filp)
>   {
> @@ -476,45 +504,31 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
>   	if (!queue) {
>   		r = -ENOENT;
>   		mutex_unlock(&userq_mgr->userq_mutex);
> -	}
> -
> -	drm_exec_init(&exec, DRM_EXEC_INTERRUPTIBLE_WAIT,
> -		      (num_read_bo_handles + num_write_bo_handles));
> -
> -	/* Lock all BOs with retry handling */
> -	drm_exec_until_all_locked(&exec) {
> -		r = drm_exec_prepare_array(&exec, gobj_read, num_read_bo_handles, 1);
> -		drm_exec_retry_on_contention(&exec);
> -		if (r) {
> -			mutex_unlock(&userq_mgr->userq_mutex);
> -			goto exec_fini;
> -		}
> -
> -		r = drm_exec_prepare_array(&exec, gobj_write, num_write_bo_handles, 1);
> -		drm_exec_retry_on_contention(&exec);
> -		if (r) {
> -			mutex_unlock(&userq_mgr->userq_mutex);
> -			goto exec_fini;
> -		}
> +		goto put_gobj_write;
>   	}
>   
>   	r = amdgpu_userq_fence_read_wptr(queue, &wptr);
>   	if (r) {
>   		mutex_unlock(&userq_mgr->userq_mutex);
> -		goto exec_fini;
> +		goto put_gobj_write;
>   	}
>   
>   	/* Create a new fence */
>   	r = amdgpu_userq_fence_create(queue, wptr, &fence);
>   	if (r) {
>   		mutex_unlock(&userq_mgr->userq_mutex);
> -		goto exec_fini;
> +		goto put_gobj_write;
>   	}
>   
>   	dma_fence_put(queue->last_fence);
>   	queue->last_fence = dma_fence_get(fence);
>   	mutex_unlock(&userq_mgr->userq_mutex);
>   
> +	r = amdgpu_userq_exec_lock(&exec, DRM_EXEC_INTERRUPTIBLE_WAIT,
> +				   gobj_read, num_read_bo_handles, 1);
> +	if (r)
> +		goto put_gobj_write;
> +
>   	for (i = 0; i < num_read_bo_handles; i++) {
>   		if (!gobj_read || !gobj_read[i]->resv)
>   			continue;
> @@ -522,6 +536,12 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
>   		dma_resv_add_fence(gobj_read[i]->resv, fence,
>   				   DMA_RESV_USAGE_READ);
>   	}
> +	amdgpu_userq_exec_unlock(&exec);
> +
> +	r = amdgpu_userq_exec_lock(&exec, DRM_EXEC_INTERRUPTIBLE_WAIT,
> +				   gobj_write, num_write_bo_handles, 1);
> +	if (r)
> +		goto put_gobj_write;

Clear NAK, that won't work like this.

The old code was actually correct as far as I can see, e.g. you need 
something like

drm_exec_init(&exec);

drm_exec_until_all_locked(&exec) {
     r = drm_exec_prepare_array(&exec, gobj_read, num_read_bo_handles, 1);
     ....
     r = drm_exec_prepare_array(&exec, gobj_write, num_write_bo_handles, 1);
     ....
}

Otherwise you break the drm_exec contention handling.

Regards,
Christian.


>   
>   	for (i = 0; i < num_write_bo_handles; i++) {
>   		if (!gobj_write || !gobj_write[i]->resv)
> @@ -530,6 +550,7 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
>   		dma_resv_add_fence(gobj_write[i]->resv, fence,
>   				   DMA_RESV_USAGE_WRITE);
>   	}
> +	amdgpu_userq_exec_unlock(&exec);
>   
>   	/* Add the created fence to syncobj/BO's */
>   	for (i = 0; i < num_syncobj_handles; i++)
> @@ -538,8 +559,6 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
>   	/* drop the reference acquired in fence creation function */
>   	dma_fence_put(fence);
>   
> -exec_fini:
> -	drm_exec_fini(&exec);
>   put_gobj_write:
>   	while (wentry-- > 0)
>   		drm_gem_object_put(gobj_write[wentry]);
> @@ -650,26 +669,6 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
>   		}
>   	}
>   
> -	drm_exec_init(&exec, DRM_EXEC_INTERRUPTIBLE_WAIT,
> -		      (num_read_bo_handles + num_write_bo_handles));
> -
> -	/* Lock all BOs with retry handling */
> -	drm_exec_until_all_locked(&exec) {
> -		r = drm_exec_prepare_array(&exec, gobj_read, num_read_bo_handles, 1);
> -		drm_exec_retry_on_contention(&exec);
> -		if (r) {
> -			drm_exec_fini(&exec);
> -			goto put_gobj_write;
> -		}
> -
> -		r = drm_exec_prepare_array(&exec, gobj_write, num_write_bo_handles, 1);
> -		drm_exec_retry_on_contention(&exec);
> -		if (r) {
> -			drm_exec_fini(&exec);
> -			goto put_gobj_write;
> -		}
> -	}
> -
>   	if (!wait_info->num_fences) {
>   		if (num_points) {
>   			struct dma_fence_unwrap iter;
> @@ -682,7 +681,7 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
>   							   DRM_SYNCOBJ_WAIT_FLAGS_WAIT_FOR_SUBMIT,
>   							   &fence);
>   				if (r)
> -					goto exec_fini;
> +					goto put_gobj_write;
>   
>   				dma_fence_unwrap_for_each(f, &iter, fence)
>   					num_fences++;
> @@ -700,12 +699,17 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
>   						   DRM_SYNCOBJ_WAIT_FLAGS_WAIT_FOR_SUBMIT,
>   						   &fence);
>   			if (r)
> -				goto exec_fini;
> +				goto put_gobj_write;
>   
>   			num_fences++;
>   			dma_fence_put(fence);
>   		}
>   
> +		r = amdgpu_userq_exec_lock(&exec, DRM_EXEC_INTERRUPTIBLE_WAIT,
> +					   gobj_read, num_read_bo_handles, 1);
> +		if (r)
> +			goto put_gobj_write;
> +
>   		/* Count GEM objects fence */
>   		for (i = 0; i < num_read_bo_handles; i++) {
>   			struct dma_resv_iter resv_cursor;
> @@ -715,6 +719,12 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
>   						DMA_RESV_USAGE_READ, fence)
>   				num_fences++;
>   		}
> +		amdgpu_userq_exec_unlock(&exec);
> +
> +		r = amdgpu_userq_exec_lock(&exec, DRM_EXEC_INTERRUPTIBLE_WAIT,
> +					   gobj_write, num_write_bo_handles, 1);
> +		if (r)
> +			goto put_gobj_write;
>   
>   		for (i = 0; i < num_write_bo_handles; i++) {
>   			struct dma_resv_iter resv_cursor;
> @@ -724,6 +734,7 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
>   						DMA_RESV_USAGE_WRITE, fence)
>   				num_fences++;
>   		}
> +		amdgpu_userq_exec_unlock(&exec);
>   
>   		/*
>   		 * Passing num_fences = 0 means that userspace doesn't want to
> @@ -737,7 +748,7 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
>   		fence_info = kmalloc_array(wait_info->num_fences, sizeof(*fence_info), GFP_KERNEL);
>   		if (!fence_info) {
>   			r = -ENOMEM;
> -			goto exec_fini;
> +			goto put_gobj_write;
>   		}
>   
>   		/* Array of fences */
> @@ -747,6 +758,11 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
>   			goto free_fence_info;
>   		}
>   
> +		r = amdgpu_userq_exec_lock(&exec, DRM_EXEC_INTERRUPTIBLE_WAIT,
> +					   gobj_read, num_read_bo_handles, 1);
> +		if (r)
> +			goto free_fences;
> +
>   		/* Retrieve GEM read objects fence */
>   		for (i = 0; i < num_read_bo_handles; i++) {
>   			struct dma_resv_iter resv_cursor;
> @@ -756,6 +772,7 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
>   						DMA_RESV_USAGE_READ, fence) {
>   				if (WARN_ON_ONCE(num_fences >= wait_info->num_fences)) {
>   					r = -EINVAL;
> +					amdgpu_userq_exec_unlock(&exec);
>   					goto free_fences;
>   				}
>   
> @@ -763,6 +780,12 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
>   				dma_fence_get(fence);
>   			}
>   		}
> +		amdgpu_userq_exec_unlock(&exec);
> +
> +		r = amdgpu_userq_exec_lock(&exec, DRM_EXEC_INTERRUPTIBLE_WAIT,
> +					   gobj_write, num_write_bo_handles, 1);
> +		if (r)
> +			goto free_fences;
>   
>   		/* Retrieve GEM write objects fence */
>   		for (i = 0; i < num_write_bo_handles; i++) {
> @@ -773,6 +796,7 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
>   						DMA_RESV_USAGE_WRITE, fence) {
>   				if (WARN_ON_ONCE(num_fences >= wait_info->num_fences)) {
>   					r = -EINVAL;
> +					amdgpu_userq_exec_unlock(&exec);
>   					goto free_fences;
>   				}
>   
> @@ -780,6 +804,7 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
>   				dma_fence_get(fence);
>   			}
>   		}
> +		amdgpu_userq_exec_unlock(&exec);
>   
>   		if (num_points) {
>   			struct dma_fence_unwrap iter;
> @@ -885,7 +910,6 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
>   		kfree(fence_info);
>   	}
>   
> -	drm_exec_fini(&exec);
>   	for (i = 0; i < num_read_bo_handles; i++)
>   		drm_gem_object_put(gobj_read[i]);
>   	kfree(gobj_read);
> @@ -908,8 +932,6 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
>   	kfree(fences);
>   free_fence_info:
>   	kfree(fence_info);
> -exec_fini:
> -	drm_exec_fini(&exec);
>   put_gobj_write:
>   	while (wentry-- > 0)
>   		drm_gem_object_put(gobj_write[wentry]);

