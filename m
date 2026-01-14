Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBAC6D29FF1
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Jan 2026 11:35:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F8F210E167;
	Wed, 14 Jan 2026 11:35:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hlJ8TbHJ";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010004.outbound.protection.outlook.com [52.101.56.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ABBFC10E167
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Jan 2026 11:35:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TacPFkHio4ZlPAF9jGArXxGKPhw4xgqS2A9p9Oo27ynBz7G15wNZkYpiq/0rdIxcEhep8bIM7IMrZ6vttU4Cv0rQxPXPCIW2UfBr6oWHNeT+d5iw/D7e3jM33V6gSJXwKo9rPgSYnrcsICF+ETKx5uGThghIAvHnAJCw0GrOmyABduvhQb2NtUBLfqQYNKENrXdnShGFgokflOKM+E3F/MQeLteas1R5WIVWUJqK2lD7Dxpi4i+nWNziqNcManfJrkHjbM6cUbRNr7BP62ruNX98rXi9MuNdq2WEiJq83P2lrrWqDd4mQNNpEfKhkcsftDIUu4MqU9YSM7U5dSixiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jLUJE9esXyjJT7F3Zy+AvPlhvQ8Ny0xQqx3OnW5utlU=;
 b=AQMIUhZ5U0DNxOLQyII9DaDgw8CXnKFq/ShsH7T7pSAlJ8V8Ub+Sh0cIZuNt8Bpoc/hiCva3YAUFTy8AcB8rACGXXAU0SMEVRmHfrJljNnU7CZypPPkk/kslBMvHRmSZUQL6Dd1JFqQ+bE5MWCuIQOn6cPRdjgTt0AXBAEqdrZZdjQdfy1oTAkWOcjDK2G2OGV//qOYVTd1vUwJNO6YxKVVK8R2SVY5wH11s7A88f2aT0qxreZb+GC7nh/1QKJkYu2EIJfjlo5FmS81LZQVXY0wSYlKcC7HQKZe271R+Pcx3QMZC+ljpaear/H0P0/hOsOczH4rDThmG7MZ51SEtnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jLUJE9esXyjJT7F3Zy+AvPlhvQ8Ny0xQqx3OnW5utlU=;
 b=hlJ8TbHJ5FyuRv/172IR0ItSCEMVnuxLldHKRk0CfctAxy0F7BN9siTJAPwNQl5F5HtKfOwV2Bbx5sodQ0OzrdVffcJfpPN9ZwcnxF3IrSMqdJzj9Li7u45jVSI/FGjel77lNXSm+eQtD7YciDQT0BbBr1JiNDKAGctwdv6WIq0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS4PR12MB9611.namprd12.prod.outlook.com (2603:10b6:8:277::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.4; Wed, 14 Jan
 2026 11:35:46 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.9520.005; Wed, 14 Jan 2026
 11:35:46 +0000
Message-ID: <34e9d172-b289-4550-a251-f08588475b93@amd.com>
Date: Wed, 14 Jan 2026 12:35:43 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdgpu/userq: Fix fence reference leak on queue
 teardown v2
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20260114112843.122884-1-srinivasan.shanmugam@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260114112843.122884-1-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0341.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:fc::27) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS4PR12MB9611:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f8a0e5e-db75-4fc7-0d6a-08de53610efc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VXJlaUxIQXpoc2p5YitOSzh4QmpTYnVaT0d4MlFsMjJMODJnYjFrVVNjd1NM?=
 =?utf-8?B?UkZXbEtGMDBrdlk0VjFKVGdGNmhWbmF1cVN3Y1ljRzFBRG9nVVE5Q1JtdkI0?=
 =?utf-8?B?OWw2ck5VZFlWcFFyQVpySkZDRldzT1FVdWQ3OUZhbmczQjlGZnBOc3B3Yk5N?=
 =?utf-8?B?ejhUdEYzZFJ0bXZsNTlMUUVjcVhhb1BaYmhHUzZlT1lQV1pIY2JtRDJya01h?=
 =?utf-8?B?OUpmakxjbFd1R0JqVjhVdkV2ZHNvTWpLeEN3cjBPNk45aWNQdGJkVFEwVElT?=
 =?utf-8?B?cnNhdnd3QWI1VitnRVpTRXVOQ1MvMkV3LzdOUC9lamgvZ0RNUXppdlBzU0xM?=
 =?utf-8?B?RlRhMDJhei9hUC96eHl3ZHl1enJVV2V6dmhMZFFDZGJBOVZtc2xyd1BaK25z?=
 =?utf-8?B?dWV0dmMzRVoyMmZCL2cya0ZkamEwTVNsUzNnK2ZrK3J0b2pMdWpJVHEwblhZ?=
 =?utf-8?B?TE15enpwNksyWGVFMUl4dnE5Ym5uY3ZwL0Y3cXhqK2dnT0wvSXZ3NExHUVRq?=
 =?utf-8?B?dG12VGdLSXpMMnBGQVU0Vk9ySnFhUUpZZHZhYkRGZjlmYlQ0TzhWS0o2clFh?=
 =?utf-8?B?L1lzdzhnblVCc3IvUGYreFM3blQyMkU5cUR6YWtUcmJqanBvT1BJOWpTcW1u?=
 =?utf-8?B?RVNoSGlCK1crcFhBSDY4cHRWSnNaUXVScEw1d3daSGtXM29BN1REYlpVa2s1?=
 =?utf-8?B?aVU2dGpwQ3Y3MFAwNjJBbml5aEQyNkpGZE42eWlCa24ySXdOMk43ZVVJbGJh?=
 =?utf-8?B?d0wrblRYNGN0L1JwSENiVkNxMkdrcjNMMnloWXlGU00yNkdwVlB4VFJqYjZO?=
 =?utf-8?B?ZWJFYW1POHl3NFpYbDNZZXlBZDBWVE9KaS9mSDJoMHFXblVOMzBxN2J5MmR6?=
 =?utf-8?B?UUpPUzBLeW9WaHlUdXhYallQM0RwOXFWSWt6c0dueWhpMlZvVG9sK1lMZTlm?=
 =?utf-8?B?YjRibW4xMy9kNnlVVHY2VDVxK3dXQUdERG44L1UraVhTMzFPcWUzQnhqa3pw?=
 =?utf-8?B?bUludE9RWk5DRTY0UWpTVmdsaFgwdHZDcS80R1JnenQreXp3L212THYxWU5a?=
 =?utf-8?B?VkFJTXVnVGltcEpqdGZSOXBLQmJGelZMeHBqcG9CUVRFeEFyOFNiS05yUkVn?=
 =?utf-8?B?VmF1aFhVSXZ2L1NyQmNiYnFRazdJazhzWEpFSTNnZHdBalQ1SFdyc3VuMitm?=
 =?utf-8?B?RTFaeWFiNlh2OFBQSUt1TXlHUThUSHFRUXNmRjBHbjNlKzNjZW43dXlwYmhS?=
 =?utf-8?B?dDlHS3hXdXlSK0YxRkUxTzdFTWYvanZXRHZWbndvNCtnZEVpNVlwNVprY0ta?=
 =?utf-8?B?K3dHRVlmUHBldXg0UU5PdXcrR3d5YTYvMHpDYldvdCt0dE93aUZjWTkwYUJn?=
 =?utf-8?B?U3dlNG1Kb21Mc1R4ZGJoTVBMaCs0RlN0ZmJCVXJzdGhPWWtvbXB3RU0rTEJY?=
 =?utf-8?B?dk5na3lzNUdmOUxHSXdBN2NPRHJCenhSQ3NhZUhQUmRtaU9aUzNkMjVBMDVS?=
 =?utf-8?B?U1RtR0VhcjYxTmZqUDVxYjhSWWpnblUyLzloTXdIN3h3ai93bHJCK1J4WUpw?=
 =?utf-8?B?TXVGZ3Vmc2QySCtFalVaZlRPTlVTT3FUUkNrU05XZjcxS3RDL1g1ajVhV3Jh?=
 =?utf-8?B?NWZZNHY4cm5SUGlIcUlZTkxRemp5azlrZWlVMFZGUzRUYlNIWVZDVGN6bEVF?=
 =?utf-8?B?N25ySnJnY2R6RVIwcUtoM21melYrQ0kySEtuenhJWnlONWtjU1VnNEZXa3Nj?=
 =?utf-8?B?WGtPRlo4VVBkbGdQNTM3Rm43R0liRVhJTG1CNkdpSHN5dkIrOWkvNDZ5eVlN?=
 =?utf-8?B?ODg3R2xLclYvNmN3NUdJeEZZMXR4NXlLWlhDSFZPVUM3TnFTeEhtKzgvdEFN?=
 =?utf-8?B?MjlJdW9FZEczMFdISitFUDV2bnB5Q2NkRzBUbHMxR1NJNzh0YlVDQldqRTVP?=
 =?utf-8?B?Z3lDZ2NSbXlmSEFTVFFhNCtQZGlHVkF0R2ZrWjhmdDZzNzI3ZWR5THBDQ3pS?=
 =?utf-8?B?VXZ2Q0NOVmMzVG1CVUVsbTNqWkdrVGMwZVNVaU9GYVVISWZqa0dvd2NEb0p2?=
 =?utf-8?B?djJWNytLVm1VT3VaNzgxaXR6b3UzdnFSRTNSWlpyeDQxbmc1WDIvamJlUk5P?=
 =?utf-8?Q?ji24=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UkpoTXlwck0wWi9kRTJmQlIwbEZoUU1jOTZySHFWM2xhdE0wc25DVUt5Mmdj?=
 =?utf-8?B?SFNubTJ2RERRQTJuRmlwc2l2UU1oNmVzTnNEWEgrd2pXa0Q0Mnc3aXo1OG82?=
 =?utf-8?B?bkdmNWNLWXU3SkxjWklGYVpMcTdMRWJBSURjeTBqNkx0MzNTN3NuK1VoQkxN?=
 =?utf-8?B?d3hhVkoxYnBFdlV6am40YWh4SjE5MXdQSE1kRGlYajNlVHlnR1lMd3c5LzZW?=
 =?utf-8?B?N0JJQWxTMGNpdTZ5NERjTW91Wmg0ZkxPdTRlZjEzUkpYWkhTOE5MbkxBMUhs?=
 =?utf-8?B?R0k2Ukt6Y1p3QmlOeGRoVkJuVDc2Nnk4M1Y1Z0IyTWhrOGJQMndEbjhTa1RK?=
 =?utf-8?B?M1hrbXR4eVlZbmowNEpNYXB5dFhzdzZKSDYyODBHcDE2R2RjMFZhajNnOFh5?=
 =?utf-8?B?YmY1bzNDSWI3UzdJOTlZbnkwMjlNZm01N2ZkMVFZMjg1RTVNdjlOWi9rbmVj?=
 =?utf-8?B?OHpRT0ZRd1VjNU1uVmJ2MDZqV1E0elRadEwyNlRzMVdaQUZ1M1U3RWNrMXUy?=
 =?utf-8?B?L1lISEdZRlZLRGl5NXNNMHlYc2RxYnZVT3lJaDdMRnJWRzR6NjQwUXhzT3E3?=
 =?utf-8?B?aHpTME4wRWZJNFZZZlZISFAyK1NQRVNlL2JSMlM4YU1TallqRWZiamRGOGo2?=
 =?utf-8?B?NEJPY0RFOE0wK0kvemowRGRaM04vcUhjanlEdjNMMTZGVW91Q1Q2SjhVSnhX?=
 =?utf-8?B?aWJaZ1ZmUUM3SHVGbmJvRm9ZRUdnUE5sYWk3VDMydEtodC92ckh2VTRnQmJ6?=
 =?utf-8?B?SHZ5SThnTUhGUWhVcS9hQzREMFJ1RWhSMmtQa1BWOVA0bnhsVE5Ndm5Ccjhn?=
 =?utf-8?B?UHpOdDNEWEsweFgzVFZISnFMc0J5T0NlSkdxTWc0alNWUGx2NEdoOWpleXJ1?=
 =?utf-8?B?NDMvREhJMzZrWUZacGlQTmZkc2xxL3k2bXBDcW40c0t6UTk1aUpRWHlpUENs?=
 =?utf-8?B?UThXbXd0Nmd0VC9ndEMxVzlBVTQ4ZmxQeW95ZmNuVGtUcnF3czgzQnVXT1J3?=
 =?utf-8?B?KzV0azBRUnh4NllDUTNhK0tvZzRJVnEwQnB0NmE3ZlN2dm1jWnVxOGhuMXFs?=
 =?utf-8?B?bkVzVXhGVFhhQTlJWXAvcVJDQm1BOExqY1k5SnBzdnRlQnpxWHVKNUI5a05U?=
 =?utf-8?B?M1hjMXlxc01KejR2MWJNWXVKeTJ6d3llY3lPNWF1SjdMZGFmWDlKdWYzaFI3?=
 =?utf-8?B?dEJqZDM5bGpxRUY1TmJKVmtCVVhFWkFLMkorTDhLQWlobENidlhzUnlJVThr?=
 =?utf-8?B?YWhBNXo5WW9ySk1IdHFsQWZTbFNqRDRhTEVvL2RTYWRBN0VIK0JJd1c3MGVP?=
 =?utf-8?B?WHBqSExIVlgrUllUTUhJcmI3VlVES3RleUM5c2Mvc1lxWTNMUVJKOHN5VjBD?=
 =?utf-8?B?R0lTak1sOXlKVTVXd1N1cmtmWjZGSVBqUmF2Z2UyMTEyMXcyWTNiTHgxK1hN?=
 =?utf-8?B?NDVZbTd6ZU5rQ2NpNU1KTk1Ba2QzRUxyamFvdHUyUEJPNEZPZERiVlgyM205?=
 =?utf-8?B?QWNXc2t4NXZTNlJwYWhhSlZaQlE1dDAwdnBqNFhxVVBwNmxXTUdCVi8wV3Zz?=
 =?utf-8?B?cWlMZ0Q4eXlCd2tXMFRybFBXMnczRjlIQW5XMTIraHdwOXU3R3ROTWQxbEVl?=
 =?utf-8?B?SjhtMnhZUTZKRTlSM2gzSS9EQ1hZZk5MTHFHWk1pU1g3bnJDM2s1M0hKM1kx?=
 =?utf-8?B?VWwxdnVhTmwrNVVMNGtjZ0Q2SGZZZ21DaWVjcldPZDZvRXhJS3ZLeUcvNG8x?=
 =?utf-8?B?UjJiL0R6elRldHhCTDR6NnB1UFNjZmdHRmNIczhwRTZFeWpvOHZWaEpZNDRJ?=
 =?utf-8?B?cXNybU1DckdHK0ZQbnlmK3RObThBV3ZjaU1YTHBYMWxxUzVVSE5wSnNqK2Zp?=
 =?utf-8?B?d0JTU1Y0S0t0ZnhEVlpGdkczT2dtVXFsSXFPbWQ1TnVReHlXMXNCMzRTOTVy?=
 =?utf-8?B?RFFJTHZCY1orZllYeGNJdTlPRDdSVDB6bE9BQk9VR3RUWm1kMS85bVNURWtj?=
 =?utf-8?B?MGFob3VUR0FZZmVtc2hpekQ4ZmRHcjBIVTJmOUpaSG1adW9qUlVXK084Z0hk?=
 =?utf-8?B?Smk0UUExRjBiMHNjUit5RnoyTzRDQjRzdHFEWGorc1BCK1B6SlVZbld2NlJz?=
 =?utf-8?B?M2c5cktoR1pmdVZHcmd2eDJhSnRNYWx3NStBNWp1bForRmt5MTY4aXNtM0lk?=
 =?utf-8?B?dHdwd1FtaWdvU29EZ0VuSXlqWlBaNUV6OU1nZXRZVmR0ZmlTaFNWeEpXQUhM?=
 =?utf-8?B?WExObnI2NzRSNkZrVHk1dkZ2VXhrdEw3czdjd0gzL0RMMFNLd3lWZnY0V2NM?=
 =?utf-8?B?YUZqWkl3TndLbUNlMkNLS1duZUE4UENyNDZSWHlvaWhUd3RNRnR0QT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f8a0e5e-db75-4fc7-0d6a-08de53610efc
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 11:35:46.2675 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O+St3iFqy7LpJmOpS4PGS8b7QYsgSWBMu9tUmq0xSXqqYObzPza20XMI2qzyOLH3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9611
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

On 1/14/26 12:28, Srinivasan Shanmugam wrote:
> The user mode queue keeps a pointer to the most recent fence in
> userq->last_fence. This pointer holds an extra dma_fence reference.
> 
> When the queue is destroyed, we free the fence driver and its xarray,
> but we forgot to drop the last_fence reference.
> 
> Because of the missing dma_fence_put(), the last fence object can stay
> alive when the driver unloads. This leaves an allocated object in the
> amdgpu_userq_fence slab cache and triggers
> 
> This is visible during driver unload as:
> 
>   BUG amdgpu_userq_fence: Objects remaining on __kmem_cache_shutdown()
>   kmem_cache_destroy amdgpu_userq_fence: Slab cache still has objects
>   Call Trace:
>     kmem_cache_destroy
>     amdgpu_userq_fence_slab_fini
>     amdgpu_exit
>     __do_sys_delete_module
> 
> Fix this by putting userq->last_fence and clearing the pointer during
> amdgpu_userq_fence_driver_free().
> 
> This makes sure the fence reference is released and the slab cache is
> empty when the module exits.
> 
> v2: Update to only release userq->last_fence with dma_fence_put()
>     (Christian)
> 
> Fixes: edc762a51c71 ("drm/amdgpu/userq: move some code around")
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian König <christian.koenig@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> index 3c6bd5531627..8d7420a9a113 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> @@ -141,6 +141,8 @@ static void amdgpu_userq_walk_and_drop_fence_drv(struct xarray *xa)
>  void
>  amdgpu_userq_fence_driver_free(struct amdgpu_usermode_queue *userq)
>  {
> +	dma_fence_put(userq->last_fence);
> +
>  	amdgpu_userq_walk_and_drop_fence_drv(&userq->fence_drv_xa);
>  	xa_destroy(&userq->fence_drv_xa);
>  	/* Drop the fence_drv reference held by user queue */

