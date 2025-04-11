Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFD25C36010
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Apr 2025 16:49:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7038410EC34;
	Fri, 11 Apr 2025 16:49:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FJt4zCLG";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2056.outbound.protection.outlook.com [40.107.244.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9EE2010EC34
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Apr 2025 16:49:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rDuc5/FCre/rgGQoV36nKGdEf5WoLBc4+2tfGYPZ7jld/6CjkW8698Hq+PK89nGgX92v7qIxDC5PbulcaT2QcLFRPaxwzPpaCIdiLa2u5Krwr9slRGQ/dgmBVJ6OFCeeUy5FDsAQRdGFQbgqvsA+ymdW4oARqkjHAMR54lKqOpMn4gKHXxcAS3fOsVT53kQX//ckpVFggGnTb74COUUF4nuHhKv84CfeQXfqNmFRNG2uJuhGlLNS+HGifMeNA8ppo6UVids6AIcsqXcc1Hf4key+Cyw0D0BKtCK8Dd07/IZBzFBapn5wqkAFAyMsd8bmWJC+h/PH42hT2/r/Ik/MaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d0hTyqMYAyBBofn81m3gpefkoXhDeCDl9LrvsDHJCY4=;
 b=hbrSWaZz1ljEBuC/JG6nMwZOwzy9/6VisLQdNkTFUO1OEL492CONzlZnUHsKnUDpkZFLfajq0Ecb9IMJndyQePjzGot7XL+N/PrWFwO+Rfy3/BHM2gMI7JWddDBR+OMo2SOfS6k+Zc+jKe4gcyEpn7pgfn3cMObvdbHflOwLU3PLfzbJzo7OUxn02OwjDKLrko7dI+8g0Sr0i0lL8ppW6FXa+NKPI5OaawG30/ScgSTbyplovwWnxMOFpwFSfMFpzRBwb19HwE99T6t9Smj/vV7ELpI3/irNSrpK+8t9jCHR3KJJ67TJVCZ3TXBZLP8pzBw3VUKr98OEaE6sD1cN4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d0hTyqMYAyBBofn81m3gpefkoXhDeCDl9LrvsDHJCY4=;
 b=FJt4zCLGJ0wJZK4u3ueJF6UYU8BSI7e66uXzcL2+5Xh96Vba9FJTEwj/eJS3MVx48xpakheJm1s6XkQqK97VnjqnplbvB+zdP6t7hyfj/x3pxlvCeZtaw07fTLpDvqGGDnl7ZNA5Lk8+wasuGEqfyVojJme2lGV37joS/06x/wM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV2PR12MB5776.namprd12.prod.outlook.com (2603:10b6:408:178::10)
 by CYYPR12MB8869.namprd12.prod.outlook.com (2603:10b6:930:bf::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.22; Fri, 11 Apr
 2025 16:49:52 +0000
Received: from LV2PR12MB5776.namprd12.prod.outlook.com
 ([fe80::6628:31a5:4bbe:ffec]) by LV2PR12MB5776.namprd12.prod.outlook.com
 ([fe80::6628:31a5:4bbe:ffec%3]) with mapi id 15.20.8632.025; Fri, 11 Apr 2025
 16:49:46 +0000
Message-ID: <434e4631-7b80-4ba0-9ba4-979d0ad576f7@amd.com>
Date: Fri, 11 Apr 2025 22:19:43 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/13] drm/amdgpu/userq: add UAPI for setting queue
 priority
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20250410185402.2352109-1-alexander.deucher@amd.com>
 <20250410185402.2352109-2-alexander.deucher@amd.com>
Content-Language: en-US
From: "Khatri, Sunil" <sukhatri@amd.com>
In-Reply-To: <20250410185402.2352109-2-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0025.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:97::9) To BL1PR12MB5753.namprd12.prod.outlook.com
 (2603:10b6:208:390::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5776:EE_|CYYPR12MB8869:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f675732-127e-4b40-4b78-08dd7918ddb9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Y1ZEMGRaRHdScVVqcEY4aGRqQnZUck95VUpacUtUeTJJRHFnRk9Dd0VIUytk?=
 =?utf-8?B?UE1lMVQzbzlWUlBrakZERkxKVEFNelFGcjZjdE1jOHZzUEN2YVExRCtGbFNZ?=
 =?utf-8?B?QjZubUo3R003YXp5TER1RUVZMFJYL3ZrNCtQNnd2cVNBcmNVeDIvNmtrWEYv?=
 =?utf-8?B?bzV6Q3hwUDQxeEdzZkFtT3h6U1ZkUUFjeC9BVVlHR2lKdEV4cDRKa1VRb0pt?=
 =?utf-8?B?Q3VsY2dTYlZyWmdQMGxER3diSUptQlhJeFNVVXBRRkY1N3NZQU9HY3JpMG1w?=
 =?utf-8?B?ZWVZS2FUWENDZm8vUDhla0lrK3RtWkhINk5JQzJXM2xEUVNIL1Jja0pNVkk5?=
 =?utf-8?B?cUlrYW9IeVBVY2E1MVkxZEwzZ2liSXZGdjFlZVd4T3B0dGxDK3ZiYVMza01a?=
 =?utf-8?B?NnB3UEdBU0pkSzM4UGk5RXppczlSM0dHZm1pQktCTms2Q1Z6MTNROGtYTUdK?=
 =?utf-8?B?SGYrck5wKzVWL3RreU0wVnhOZlJmNU9UeGxoY3BxaytmSGJCYWVpdW8wRXB0?=
 =?utf-8?B?UnhmbDBEQ1ZmSjFxS3d2c0ZKMk1ESjRCblN1bGZCTGpmME1tR3RqWjBvWTVp?=
 =?utf-8?B?UTY5YnpKM1dLNkdZTHJ4N0d6ZXJEUktJMy9Zc1dTMVpGQU5oaTVvZk1lcjYx?=
 =?utf-8?B?NlNIQlFjMFlVaFo5OW8vamdYMVZpRDQyWitFZjQrbE5JSlFuWE14Z0dRckk0?=
 =?utf-8?B?a1dVN1BJU0IwYWdMekM3b2lQQXRFK2RkaUNvcjdkVVBMZTNkZmdOTmJwZ1c0?=
 =?utf-8?B?MHRiVGxxdmVPVnh2bzhNdVBHZVF6ZG1wRGUvci9sL3gwVktuUk9wc2VuaGQv?=
 =?utf-8?B?YnZiLzhCR1ZIYU9jM3JZSnFJL1lUY2JrQjRnU1V5dFp1WjZOdFNJYnVoVXRH?=
 =?utf-8?B?WWpaYkVOeDhNSC9mTnZ3R1h6dWtwcUJSYU1VTjJOVmhVSmdzbFltdnVLWkxi?=
 =?utf-8?B?OWFaQ3Rlazh0dzg0NUpWZ0hFeEhqWWRTTnJWQVdzcERJTGdhb3NVeGJSQktC?=
 =?utf-8?B?TWhkamhGeTM3YXJUVkFPQTRqOHRuLzRwOGw0dXJsVUN1WktubmE5eGZpQWR6?=
 =?utf-8?B?ajVvOWhBcDNNN3pHbGZrYU42WGNxbXFjMHFqU2VwcXJVakdvRjk0WmF0NFp5?=
 =?utf-8?B?VXpkaTFHQlFPODZHMVNMU0F5bXdNYU9UR1NQK1RtZm5NL1kxMmtjZUFJUVk0?=
 =?utf-8?B?c0RUZVpNU0U2NWxHTDBMclpOUk1CaEFwcEpsL1RvVjQyUG0rUmRwKytYa0pu?=
 =?utf-8?B?VnZ4bGliOUIxTkFmSEIwQ21uTFZPRURYTTNZUWN3UEk3WlJCUzAzNG1hUWFU?=
 =?utf-8?B?ajRTeTdDNmtqbE9FTnNEZURGSDBOWjRzT0h1bjUxN1JDeng1cWpDV1psdDJ0?=
 =?utf-8?B?b3JxckVHakZERXNIbFdIQ3EwWU1OYityUjIwc0xTaHVHOXZxbGVLVDRZTkR3?=
 =?utf-8?B?V0h3bWN0T2VVUjA2bXBKYk1kSEFCOEMyQ3ArMlNRTG9MZVdSa0dBSllRaThk?=
 =?utf-8?B?eXI5SzlJVzA2dmpubGtFRWdTK2VXUFY3NEV6YkZCc1Avb1gvckpoSXY0RVpJ?=
 =?utf-8?B?aTVWWHlBUkwxWWc2T01pVE1uYWFWMnlReE9jVTdndUgzVGJITjhwK2JlTHNS?=
 =?utf-8?B?THZJSWFTbXJMM3dZYXhFY2JVSGhpdlFkVUYyMC9ld29UdDRRdEdWVFY0NjEy?=
 =?utf-8?B?UjhSVFdERjN2ZE1TQWRIOGt6N1NCUXRIdnR0K3R3cCsyZWVBc0RxZWZnakpl?=
 =?utf-8?B?Z01qUEU3M3NwcXlVbW54b3V1aVM2ZDFiNmk4RTRuMHZ6WHJUajh4bGNObkl0?=
 =?utf-8?B?OGJGaXZIZzducHVUNFlTK2I5N0ttamVra3FsZUxPT0J2ODJiYXlaOVBiV293?=
 =?utf-8?B?STFHME1GeG93Rnd6RTZLMUhCVE5uVHVxaFpEUnE5R1l4ZStRbStHV1hRQWY0?=
 =?utf-8?Q?cy38PDEs0hI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV2PR12MB5776.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QytHL2R6bDludStFdGF5ck9TSlRSMldOaytLMEJlTmpaK2hhNU5nVmxURG9n?=
 =?utf-8?B?bGZJQUR4THQ0bmZUd1QwYThUbFB0Ym1yenYvRlh6ak5wQ2hTNnhacldhVUlK?=
 =?utf-8?B?VEp3VmVyb0k5VDFyWDlrWUhodnltdzVOQjRLQ2U1SmZ3M3RpUHRIbW1sNTRs?=
 =?utf-8?B?Qm81c1RpZmN2TDRrQVJHZmx6bGdLYzM0amFieHdiTUxUNmdUZm5MOWZqUjFp?=
 =?utf-8?B?a3BDWmljNXNCZjUxWVVwNW9FM3NMVEtKQUN1T200cnVrU2R5bFYySTVtRkx3?=
 =?utf-8?B?RjVOZEY3TTJLTFFLVUNMRkpYdm1oVzZkQUxuVVJlQTFyM1cwSG1nSWdOMitZ?=
 =?utf-8?B?b1FtQXJhckdWcTNFVXF6Sms1MktFQlNmU2ZmeFhIQ3Y2am5oNnR5Y2h0VFlC?=
 =?utf-8?B?TDBaZWR1elg3NmVnMDZJZmZLeUhSMm9xa2c3Y2xhU28xQW1SM21KNzE1R3gw?=
 =?utf-8?B?Y2tGYVFzZ1B2MGlMNU5TYnI5bXErbjgxTitGUG44Q3kvZjZ6bXlVM09lNWp4?=
 =?utf-8?B?SXJGOFFkU1JDeEFRVlZQL0w2MTEwWDhWUG1ndjcxUE1RUGtiSEVmZXJhOEtj?=
 =?utf-8?B?STB4Um11L0Y4V2RTUU1DZ1hvekp1SzhOODJKOG01WS9wbDlYRmk3UXh3ZG5u?=
 =?utf-8?B?ZHNkSjgzV3ZWV2ZKYTh0TmgvWFB4RmNFOFozT0FROUpCdUlkK3pjUmRLQkVu?=
 =?utf-8?B?OHJ4VHdmakVZaUhhL1k0VU1sMWdYUGVDdW5JWmszeFVXRGdiVk9mRVpIa3U5?=
 =?utf-8?B?bWsxNThFRDE0NTdqbmpkYVpCenZpVzhVbkV5RlovVFl3R1BtWm0yc2ltaElX?=
 =?utf-8?B?WVJRTzZWRmlkRU5HamkxOFcwZ1N0OTdLbFptUFowTmdwUW1LRFNvT3FzZUZr?=
 =?utf-8?B?d3ZvbE4zK3gvVlBsYjlJRnI4SHJLVG9ja3RMT2dGbXExV2lBZm5TZGVobUxi?=
 =?utf-8?B?cGVWUnpvZ2JEZlJuVlZvbThIZ3RsVGR4Z0RVWFNPdDAwTFNlVmJQN0hOTkQ0?=
 =?utf-8?B?MjFhQ1BXQkYwZ0V1bGFlNUlSSWNoc3JvbDQveW5wWXdXVTBQeUFXQVZYR3VF?=
 =?utf-8?B?bkFpellGOW1NaVEwcXUxczZWTThmZFV3VjByRjFhU2c5WHRpZ1lmNUVwTnJE?=
 =?utf-8?B?MHVTR3ZwVTJWN24vdzVIcXdLVEhlVkhoYVoyQUlFZXFieEtEUVh5RkNrOEky?=
 =?utf-8?B?R0M0TVpSSTk5R0c5VlI3TjdZNHpvZUpyOGI0eURVNHZTcmx3NmNtc2F6SkFa?=
 =?utf-8?B?WW5CMDlDOTBXUXBSZmlSTUNxeG9wRCtWdUt3cmt6UDJFWXB5ZHhVRTBJWWRF?=
 =?utf-8?B?WVdKY0NVWGZYTHlpajVmZHJTMnd3ZXE1aW4wNERFb3lTUHBzTTVPM1ZNS0Nv?=
 =?utf-8?B?S2ltK0YwbWhtZEI3eEJHNkg5SWRZbzFVWEpjU1RZbm02eVVrbWFMWFVYdExu?=
 =?utf-8?B?RWpVbEJnVm56dWZKOG9DZkExeEVJMDVzcTFURVRvTnhuVkM0TzRPQTZkMmdX?=
 =?utf-8?B?a3NIbGcrenRBdlJCMUNYRFRUSGNwekpVVEp3WEFtS0ZDSUh6TlB6TnUxTzY1?=
 =?utf-8?B?T1VtOTFxbVBPZ1ZOaFRqWFZHNlFLdmhwd0ZsRzVaZDJ5WXQ0Sk9tZjZmQ0tv?=
 =?utf-8?B?RVVQb1VuOXdvSTdUZHI3aVJnYkp6M3gyMXFnOTUxK3hRTXJyYXppa2RDQWVB?=
 =?utf-8?B?ak1Xa1lNNDFMVnV1Q1FYc0NPcE1MQ3YyakJmaTJuUW1qdGtEUi9wSy9jazU1?=
 =?utf-8?B?MWZhcFg3QzhuMjBZL3hRekVtZzh1TDdSc2lHQjg1eHhOUTE2MFJlYkdkUWVS?=
 =?utf-8?B?b1RRRzlHeFVjcWxOY2dqOVFSeE1CUmNNcmd0bFFJdHpSejRFSnF6Wkk1RC9M?=
 =?utf-8?B?MVU5aHdNcWZYMytVcFYxYU8yUzhEaFIyUkJiVmI4NEpkR2hJd3ZZWUxDd0cz?=
 =?utf-8?B?RmxuYVBkY1lyUFJLZ2RjOHZpNzZ2cTIzQzdQcy80RXdrSUZ2V1RrcFBWZHhN?=
 =?utf-8?B?M1N6TCtBMVBPRkNlMlJUVnNrQnBLc1RDMnJ2Zm1tNDd3M05hemd0aGk1SEda?=
 =?utf-8?B?QWMrNHp1TWZndXMwWXdvSHozV01jcjErdUdnZnNDMkYxNW40amxmZmRmYkhY?=
 =?utf-8?Q?0MDrFDajJ0Kin46axG4nbwWSW?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f675732-127e-4b40-4b78-08dd7918ddb9
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2025 16:49:46.6212 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AptXmqQPmI/cV32gtJtLlEExDkT8RfIiz+FC1BXB4Kq7eVocJsTOzgmNa1UyJrqtS8ZgrDEgoakntyERyTNJxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8869
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

Reviewed-by: Sunil Khatri <sunil.khatri@amd.com>

On 4/11/2025 12:23 AM, Alex Deucher wrote:
> Allow the user to set a queue priority levels:
> 0 - normal low - most apps (maps to MES AMD_PRIORITY_LEVEL_NORMAL)
> 1 - low - background jobs (maps to MES AMD_PRIORITY_LEVEL_LOW)
> 2 - normal high - apps that need relative high (maps to MES AMD_PRIORITY_LEVEL_MEDIUM)
> 3 - high (admin only - for compositors) (maps to MES AMD_PRIORITY_LEVEL_HIGH)
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>   include/uapi/drm/amdgpu_drm.h | 8 ++++++++
>   1 file changed, 8 insertions(+)
>
> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
> index 1a451907184cc..8719754c777b4 100644
> --- a/include/uapi/drm/amdgpu_drm.h
> +++ b/include/uapi/drm/amdgpu_drm.h
> @@ -329,6 +329,14 @@ union drm_amdgpu_ctx {
>   #define AMDGPU_USERQ_OP_CREATE	1
>   #define AMDGPU_USERQ_OP_FREE	2
>   
> +/* queue priority levels */
> +#define AMDGPU_USERQ_CREATE_FLAGS_QUEUE_PRIORITY_MASK  0x3
> +#define AMDGPU_USERQ_CREATE_FLAGS_QUEUE_PRIORITY_SHIFT 0
> +#define AMDGPU_USERQ_CREATE_FLAGS_QUEUE_PRIORITY_NORMAL_LOW 0
> +#define AMDGPU_USERQ_CREATE_FLAGS_QUEUE_PRIORITY_LOW 1
> +#define AMDGPU_USERQ_CREATE_FLAGS_QUEUE_PRIORITY_NORMAL_HIGH 2
> +#define AMDGPU_USERQ_CREATE_FLAGS_QUEUE_PRIORITY_HIGH 3 /* admin only */
> +
>   /*
>    * This structure is a container to pass input configuration
>    * info for all supported userqueue related operations.
