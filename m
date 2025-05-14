Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC43AC3ABDD
	for <amd-gfx@archiver.kernel.org>; Wed, 14 May 2025 17:35:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4701210E2CA;
	Wed, 14 May 2025 17:35:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="M7134vlD";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2056.outbound.protection.outlook.com [40.107.212.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 66C0A10E2CA
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 May 2025 17:35:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kzIsSI6aLyo2EjE4bi5VxQriNzXFPNDyISaS27RhiGj2Y9jvv+OijKB4HYciBtzh2jZxYerp2UIA84q38gdJ6qOODSiPs7VrgFvUbfoUQD3+mrwAzWcBylSm5So0/Q5nk0tDHymjXMGOmHgaLz2JOcEnnS2VlJbPNF0I5KavCM67QeVFtCfUF447TNuUR6nvzOkr+POYVTZckOPcn8fyrgBIJdcYi+q/FtI2UK5f3E4wW2CPbLOq24GnEpxEF+8rTo5dVUHu0iGiClrE3b8uud2yJRsPcSzzl8RmUVjBHoQ1EqQXYJqB9WqpLbNoqimEnZrVY3ktr0R56dijNsrV/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JD0gK2HJt/4tgCUuSXmQO1awlHykW6v1+ZMTXo1zyjI=;
 b=xAv4aPcSAGylk69gkZVQli5y/mMFY9bCKaRO3MrUi/w00nEXix+ht7fiRuJ3pm2GluhmYGi3BF9TYWwHWcC3moCZ6xD4LpwxymBkTiT/blANRNK4v39/EGE98CW8fixLK4tf9lSw5jU+6C1pWGXzJWXWNcMh4a5q17fpZ1VL8ege40LAS38iWsHwIJ7rNRyN3vi7bevtKz8zcTtL7NwZOKQGgjDOiKDk8bZK5BT18WHAtTIn5HGxPq5rmE37ClUeE4GVcc2Gv4eofUHswd+0xuUWwm8ZZVe+gnkICh79blAv2+bfG7H4acjeotEj1HJM0wpuWDzBUIOwvjnxR8uNaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JD0gK2HJt/4tgCUuSXmQO1awlHykW6v1+ZMTXo1zyjI=;
 b=M7134vlDEIRNA9s+8pauoJdXEBe76vwUBDWN7viXJFbzHOAr3l3F4iTWTAS9aATl5z7/MwV1YCQFqwUuRDbE1Wi2+VPj7g4DRrC85GPKn49QtxMqVJdEtYsvDNdQ6H46uqiDJAg6fMlOhLuuj517Jz1ngdSzfjqlDHJAx+jN85w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5052.namprd12.prod.outlook.com (2603:10b6:408:135::19)
 by SA5PPFCB4F033D6.namprd12.prod.outlook.com
 (2603:10b6:80f:fc04::8e2) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.31; Wed, 14 May
 2025 17:34:58 +0000
Received: from BN9PR12MB5052.namprd12.prod.outlook.com
 ([fe80::7714:4f80:f3e1:60cf]) by BN9PR12MB5052.namprd12.prod.outlook.com
 ([fe80::7714:4f80:f3e1:60cf%5]) with mapi id 15.20.8722.027; Wed, 14 May 2025
 17:34:57 +0000
Subject: Re: [PATCH v2] drm/amdgpu: lock the eviction fence for wq signals it
To: Prike Liang <Prike.Liang@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexdeucher@gmail.com>
References: <20250512022016.395502-1-Prike.Liang@amd.com>
 <CADnq5_Oept2rLB4Wi1eVYt_8V-sZzUkM_rSw1-h64kSmHKhMxQ@mail.gmail.com>
From: "Yadav, Arvind" <arvyadav@amd.com>
Message-ID: <2c4a8b43-8ef1-41d1-0f6b-f1a8d4507300@amd.com>
Date: Wed, 14 May 2025 23:04:52 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
In-Reply-To: <CADnq5_Oept2rLB4Wi1eVYt_8V-sZzUkM_rSw1-h64kSmHKhMxQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: PN4PR01CA0088.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:2ae::10) To BN9PR12MB5052.namprd12.prod.outlook.com
 (2603:10b6:408:135::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5052:EE_|SA5PPFCB4F033D6:EE_
X-MS-Office365-Filtering-Correlation-Id: 7cff2695-ef7a-4f70-9ee0-08dd930da53d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OXRRajdaSTJJaGxtTHZVRjI0dnord2RmNStleFBWczJIc3FoTldjMGFETm9O?=
 =?utf-8?B?UUFJOGxKRGFPSmRBV3JOa2ZWdFdLVkQ3bHlRbmh1TTdIQkJ5ZkVBVDlHc1VH?=
 =?utf-8?B?eE8wQzhseVBCSWg4ei9XOXBiSEUrdlptall5UDlqUHZneStxeHVJcUFqYUJP?=
 =?utf-8?B?d2ZvMjJYNWwyM2F3ZlBOWkJLcmtiUGc0N241czlwVnJCTnYxOEJWMkZqd0NL?=
 =?utf-8?B?R1ZZV0lKOURCYURPZFR0WEpCRTZLUEY0THlPYVlOUms2Y0hkbWFHQmdFUllp?=
 =?utf-8?B?TlJnKyswWjVBZVR1RktsaDVnQ2dhemUvaEN1QW1EQzlrVnF0ODZMU01tSTVs?=
 =?utf-8?B?RkEwdnVIMm1mQjNzajJIRGQ5KzNXTkhVYVVTcGg1U2pCekxteHVSWi9HRy9z?=
 =?utf-8?B?Q0JxWEtsQnBQYjRIUmVydkd4Y3JlOHZWVGljbzR3NVplNUhTT21iREowMDZ0?=
 =?utf-8?B?ZysyWDlqbWlrajkrRzdPcDBWOU9nbitMMHUvWFIwL3o1UjhtNVZxMFdZSDBS?=
 =?utf-8?B?REVNL08zLzdYc1ZleVM1L29NZ1kveVF4NS9aUVNvMGJTWFdtbWo3QlJ2eTFi?=
 =?utf-8?B?TEg4Z2RwbWNrcEhrWXNaVlhZRG1jMHpFRm95S3hxY2s0TmgvN25TdlhxbjQ4?=
 =?utf-8?B?YnRRaVpsU3FuL0xrUDBRa2pKOVpIUTVrTTVHeHZxdXR1RlJpa0tmOHhmTDJ2?=
 =?utf-8?B?SWQ0KytCd2JPZVFxQ05oTUxBaHlwT1JkbU5jdWNhbUZOcEtHTlNvbTRYN3NL?=
 =?utf-8?B?REUrbFJFbXloVVUvZTg1TmlOaHdwQWVka3dlMDU3T2VEVTFCMFJFSDNQU1pZ?=
 =?utf-8?B?blNlTnBhbEQ3MGRQdVp6MWRMSlozenRKcU5PSEJCbHlKSGpSOGhSRTRzZy9N?=
 =?utf-8?B?Q3IvelB0UFpJc2xrVXZhVzduS29FbnlxbXJUM2hZNDdSMXdFRmdCWUYyVnZx?=
 =?utf-8?B?YmFaRkNvWWk1Skoya2xXRm83WWRMTVZ2OGt4T2F6bk00Tk80SVExVi91TU1y?=
 =?utf-8?B?YnQxYnFXMnROWUdLdWhNc0VLby9nKzZuMGt4NnVaMlpnenVCQ0wxbVVrTmpk?=
 =?utf-8?B?eVZmWGhXN2NrYS9LcjcyRC9scnJjbFZSU2RGV0pldlEveitHV2Y4WWttQS81?=
 =?utf-8?B?UUNyeEVBQzBjY1E3MGhoVWp2SEtsNk9UMi9QbDN1WXZhdXZibC8xUElISzFo?=
 =?utf-8?B?WHVsN3ozZ2FkemxPUzFmM1NCVUhqcmR4NFptSXVQRThqWXR1M01Fd0tXNmw1?=
 =?utf-8?B?Wm9EU0VRZTMwem5Qd0tWQzk5MFdzazdoNDNxUHN3cnRNMVgrN1R3eWdMeENM?=
 =?utf-8?B?eWdzbVpwNmgwd3M1aEhEUWhPR3VnSUp1YzdUMUZzeW5MWlVpbnBodDlBMk5j?=
 =?utf-8?B?TmNzUUlYWGhJTjhtT0xHMHNjWCtLd0dqYWNtbTlxYWNIdlRheVRRM2tBc3I1?=
 =?utf-8?B?WWg5UjVXbGJMcUtUL0NJd2V6a0ZIV2pPTVJtREh2Wm1YbTFnZzU3QUdXZXBQ?=
 =?utf-8?B?R094cVlCNkJYbFdLL3EwYUt4UUNBN0lCd3duOHozMDR4R25KYW5hYnp3Q1pU?=
 =?utf-8?B?QjVrMDU2Q002NCs3TTJkVVhFMTBqalFRbWFRSDJJK04xcm1ITmVSYzBPZ3Y1?=
 =?utf-8?B?Z1IyTzdGRWZ6a0wwdnBiOHhkMGhMWEZUSUx1L3NaTHBjUkc0UEJOT1M3YVU3?=
 =?utf-8?B?TGZZTUNHb2R3M0t6MnRWL2xYanZXTGh5NDJxMkcvZlhCN0pSV3ZSRk05VDc1?=
 =?utf-8?B?d29sYnBtOWx5N1djWTZqcUlHeEJlWVVrUTQ3RjF1ZFFCQzA1LzQ1dldocHRt?=
 =?utf-8?B?ZDhMc3k4WFp3bzN6RGd5c04wNjJ1bk5wQ25vTkQrUWVoN0tsNlpITXdQMGJ6?=
 =?utf-8?B?eVdobHdXYWVZTnVFb0RmZk92MVhHeGRXTnNoSHI5YjRjalpBYTE2REwzUDlW?=
 =?utf-8?Q?9Gd0ElvQWBc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5052.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V1JVQXJYOUd6Ny9GMUhyaUhaR2tITEY5S2t1enh2QWlxenZCa3oreUsweGRN?=
 =?utf-8?B?M20ySjN6Q1NpcHZ3QW81YTJ0aVl1eTR0MlNuN0tjVjd1N2J4dWp4NUhsVERN?=
 =?utf-8?B?VE5sT3BGRTJOdzM4cnNZSDhiMHJ1emVuOE1FRFEzNWFlb09lN2twaWVXbHho?=
 =?utf-8?B?OW8ySWt3ZGk2QW5GZWlublhYMVkyTWxpMDA3RHJOaUtVaXZSMXpQWjhXUVZQ?=
 =?utf-8?B?dDJCcGZOOTM0TTYycG1sNmhlMmprelZBc3NIckFsa1A1YnY0MnRvQjVCSkhZ?=
 =?utf-8?B?NmhIN0N5SktoK3FOUFZWaWVtNUtmaTd6UVBVM0NuYnRmQ2hKNHVHNEFqc3pu?=
 =?utf-8?B?SlYwcU84N2xyYXVtOGdETSt6Wm9Ic0Z6bFMwVUxMZm1kTTFXa3ZQemJockZu?=
 =?utf-8?B?M1NqYWFBNVJyUEpHWWNmcGhFYVEzT0hKMUZVMlRZUVFsN0s1WEt2U1gvRmFQ?=
 =?utf-8?B?a25idk1DNmRneDlEU2UxVzhtMVpTeTNUbk5SL3EvS1BHWm5BM3N3dlUwd1dk?=
 =?utf-8?B?eGVXN29McTQ5T0w3NUxqSVM2UW1QS2JIWmlXRnhLYUZyVmpwMXZuUk9NMTVh?=
 =?utf-8?B?MjRTZDNTR0J4bmVOczk0djNXd0sxSHVIcjJpbnUvUlZ6dkVpUFVHdnRSU3lw?=
 =?utf-8?B?L0pPa2cvTWh2ZW9WQ3R3d3M0cFRFdjBnVVUyU1FJM0d1R2luVWJYVmxIUWl4?=
 =?utf-8?B?WUNvRWk0MUlIVEdGa0hBZmk4SlJTT2RyODJodTY1Nm5kWTBWbnRIQVZ5WVN1?=
 =?utf-8?B?QVhSTTRQZFhGNERPVkpOYy9TRkZsWlE2QUVpbWhucGY3K1BaRm80a3dVSld3?=
 =?utf-8?B?NEhBZ250RzlpM2VHMHlTYVpyOG42eUJmekc4TWt0TmhmQWkraDRtakVZUXhE?=
 =?utf-8?B?OVJQOVBUR014OWMvRWxXTTNyRVhYNTRqTmRJQmMzT1Vwd1dJeXNTU0ppVktD?=
 =?utf-8?B?RlNMZjk5SmFJUkZCZEt4R3lYZTh4MVBaLzBkaUVmdTdSMDdIZ2o0amhkbG9S?=
 =?utf-8?B?YTY1Ykd5OHc3KzVCdkdvUHROd25NOWxONTBYVU1RVzlyVkkxU0FMWW8ydnBL?=
 =?utf-8?B?V2svUitwcjdaQjBtTEdCbUtSNUVrb0FFeHAzRmp5VTZjdlAwdUozVjR3b083?=
 =?utf-8?B?SHBwZkhiRXpzRGQzMmkzY0d2eHg3Ynhia3FBWWFPNHUxVWZ5MkVoTlJ6aWM0?=
 =?utf-8?B?RFBpeUhobDJXZEJQYmlSVGtPd2c0MVBkWWZTRFd6K0x0UU1mYjZUT2pYRjBN?=
 =?utf-8?B?aFJqL2U2WVMwS1lVNjVTdWNjMmE5cDE1dHlRZEY4K3JoVm1QK0puQnppaHdK?=
 =?utf-8?B?T0N4NFcvek0rQWtoelplYWZTdktjR0VqZjRCWkZ6RW1ITUp6L2ZubFhCT1RE?=
 =?utf-8?B?U29VVVhkVU5LbDNXUU5wNXlUYzMrQTJnTHZIOExRWlQyMmlQZGxJRm53SzFx?=
 =?utf-8?B?ZHp0dWZDRnpXUmw4dHh2NXAxWGtaaHFjUWpNOXJvVHluM3J1WFU3RmRvSC9t?=
 =?utf-8?B?ZjN1cFl1REpaWXhWREZaV1ZvMlFSa1l1ampOSm5HWDR4QnRUWVhxL25OM3Fy?=
 =?utf-8?B?Rk5XL1dCb2tjcHVvaTNaeEpDcFNiRUYxQ0IxSzNsdEljRVBsc0lFdGMvMUdk?=
 =?utf-8?B?ZnI2UHJaUThBcGR6TUlJRUlETmlSK3E4SXJzTG9od2dYYkppSHUrbXRzQVlN?=
 =?utf-8?B?OWhjSldtZFpkTXJuQ2xPVWIwOWd0akFvNTJHd0ErSXlhQWtScVh6cXRVL1Zk?=
 =?utf-8?B?Z1d4Tzg4VFI1SXBBc2xabDhGMk8vZFFrQXFwKzFYUk81WWNISDBvbTlZdnJp?=
 =?utf-8?B?SjdHNndpMmFnQ2dBMCtSNEhxQTZxc0hOOUlPWEhGeXBaSEVQRk1lZ3Y1SFha?=
 =?utf-8?B?WWF0WElSVnR1QTNBUjlEaEt4bHkzN29oQ2FhSXV5S2xmSUtDckdJM0tWNG9B?=
 =?utf-8?B?OFdwUUxQRnhlSnozUlhueFI0cnI1cEpBUm91elJwbnVGYURlQmlieW9pSDNJ?=
 =?utf-8?B?Z2F0UmkvakhQSlc5aFE3SG9Sa0xpRXlob3Y2d3FJRXBTZVRBSVZrZDY2TDhF?=
 =?utf-8?B?YW5QeFMwMitLT0RxY1preXcwTlJWcmJNUUFzU1RZaVVZelBXbElXNDNwZHhz?=
 =?utf-8?Q?b32ySddUw1Hug2UZwP94bKnRL?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cff2695-ef7a-4f70-9ee0-08dd930da53d
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5052.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2025 17:34:57.6133 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w7oRCGpCXvmu58UYUBZIjNhqDPiRyHm0m2k003Rg/l/VcTawWX5OwYw1BVi3vxYw4ZMnwz10ABioSbDEdbpOMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPFCB4F033D6
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

On 5/14/2025 9:02 PM, Alex Deucher wrote:
> On Sun, May 11, 2025 at 10:21 PM Prike Liang <Prike.Liang@amd.com> wrote:
>> Lock and refer to the eviction fence before the eviction fence
>> schedules work queue tries to signal it.
>>
>> Suggested-by: Christian König <christian.koenig@amd.com>
>> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> Acked-by: Alex Deucher <alexander.deucher@amd.com>
>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c | 8 +++++++-
>>   1 file changed, 7 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
>> index 1a7469543db5..d5f176fef357 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
>> @@ -108,12 +108,18 @@ amdgpu_eviction_fence_suspend_worker(struct work_struct *work)
>>          struct amdgpu_eviction_fence *ev_fence;
>>
>>          mutex_lock(&uq_mgr->userq_mutex);
>> +       spin_lock(&evf_mgr->ev_fence_lock);
>>          ev_fence = evf_mgr->ev_fence;
>> -       if (!ev_fence)
>> +       spin_unlock(&evf_mgr->ev_fence_lock);
>> +
>> +       if (ev_fence)
>> +               dma_fence_get(&ev_fence->base);
>> +       else
>>                  goto unlock;
>>
>>          amdgpu_userq_evict(uq_mgr, ev_fence);
>>
>> +       dma_fence_put(&ev_fence->base);
>>   unlock:
>>          mutex_unlock(&uq_mgr->userq_mutex);
>>   }
>> --
>> 2.34.1
>>
