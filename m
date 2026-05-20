Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0159CCD4F54
	for <amd-gfx@archiver.kernel.org>; Wed, 20 May 2026 23:17:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D59810E424;
	Wed, 20 May 2026 23:17:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="sxA6ZxoX";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012020.outbound.protection.outlook.com [52.101.43.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2662910E424
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 May 2026 23:17:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iqLimDZXAz0i7tREbKONrnDWb2ittipchlTYOLcugsqba8feGpJ97WME1z+yv5VoM+VqIyOhqGqLDbJCmFq+qwDia9NVd30+lqeNAimN2n9nL3D4VqAb1bb9D3FtSqRek/oX/ZrNgMRpSnjmwCgnkwoC6U57XXSdixskmXPh9/2NmNzfYQPE/sJ2sMPckcQEZ6jHDEEiVlaXWLbdOjsXkB7AWch/QDj9SbFBvxJB40AK4LElQtOsUqmSj7qUT8Z2UeQJlfca8d4eirXWA/cpRVhV0U1OKQBulJpj7qBMmebQ9Tl5JNgOJ7QFabPpmE2uDdI4zhpDzMULT+IKzNjJ1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1WX3xeQ/1XHDT0BxqdP7rClEEq7eICzInCVyuEDQwrw=;
 b=liYjPzdSSVL1XY2fDvEW5Wj9X1Sq8ARm+8I7huUcEsS5I0uOaJpDeD8tsRs4TYUUFU4gn2JqeQKezOdOMc4wiQEuFOkWbTZfkaxx6aHRCIpLU3TfwWE7ELG6+ppFmsWjochOmEotVwwdJjL2ac4EHMv95aBeb80IWJkHypAS/ZUhPt2bsrdpslTaY1rLz1rbyoUbyxf05+kQZDLwMeNppA7AEJvItAsghhUuKyzu5VGheH4FT8YHPV7Eb8qJYj2vHhGC2D5licjmc8ph0GXVHtqSgYRB3OpmhBzmNmkWbG/NJpPl7F4gYBcj5ayrk+32gkLtG3BbLtVodupJ7rdixQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1WX3xeQ/1XHDT0BxqdP7rClEEq7eICzInCVyuEDQwrw=;
 b=sxA6ZxoXzavUKOmGQQO9C0QqvXg/T5FnKsKGgK53SW48yRTYvSZbwa65fKNtA1HgizLpNDz8BC9iR3dn6utLloifK5ekzPWEySyBmkZFXV0DwqerJyJHr0oYXCNcEhGITYMLirfJ920NlV+8aCZtwvU+Ac9rCE9bfIMbNdsXT/k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS4PR12MB9612.namprd12.prod.outlook.com (2603:10b6:8:278::5) by
 CY8PR12MB7516.namprd12.prod.outlook.com (2603:10b6:930:94::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.14; Wed, 20 May 2026 23:17:17 +0000
Received: from DS4PR12MB9612.namprd12.prod.outlook.com
 ([fe80::5e55:25ea:365c:f99c]) by DS4PR12MB9612.namprd12.prod.outlook.com
 ([fe80::5e55:25ea:365c:f99c%5]) with mapi id 15.21.0048.013; Wed, 20 May 2026
 23:17:17 +0000
Message-ID: <680ad25e-e677-4515-92fa-60aadfbc6ae6@amd.com>
Date: Wed, 20 May 2026 19:17:15 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/amdkfd: check per pdd sigbus delay time
To: Yifan Zhang <yifan1.zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, christian.koenig@amd.com, David.YatSin@amd.com
References: <20260520071336.1573860-1-yifan1.zhang@amd.com>
 <20260520071336.1573860-2-yifan1.zhang@amd.com>
Content-Language: en-US
From: "Kuehling, Felix" <felix.kuehling@amd.com>
In-Reply-To: <20260520071336.1573860-2-yifan1.zhang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0429.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10b::19) To DS4PR12MB9612.namprd12.prod.outlook.com
 (2603:10b6:8:278::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PR12MB9612:EE_|CY8PR12MB7516:EE_
X-MS-Office365-Filtering-Correlation-Id: fd8d1dfb-120f-4112-116a-08deb6c5ef72
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|22082099003|18002099003|56012099003|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: Q8HDqcr/VYtqS9k5B3c7PU9727w6/fXqE4YA4dYhNOKrhBVvv5kk3gEa+ZRfqVUL+sFxln6sN8UpN9yHn3JGfBVQOWzZOxhgmsYyHAbnsbhj7wg8v4ABq5j/4oXZ5Zx8x0RhrYQqsYvUQQaJ/jzpZ/ZZaQ2yqu4i/TqW6S9QTrcGU6kE5Q/oITN3xsURt13o6cJvmf6/5wGz5ccnesUISTBZbDeAD+pEXJim1/LlLmZZIB1H4AY/39iFN5iG7AfuUVsrEo+deFnrQ4O7eCUJLEnVKHqaloN2ocF0orm5a+V+MsH2IgHMLUe+N2WJLkuBEZoqhFSM1N0f5jLzZm0d777et8aUcUMaju4lYNtrFBQ5L/5S18qmK0K5V6xOVS5PhljWLhLeo4xebv7zs4twFnqvP7qnbSvYjG12TbAm0LQwDJTd3EEEFTOUJNtudDS7UEScjdPkdkuerm0PI2oilIV23meyxFKfdffR55zLyYwi41Uyd8FXeUSlVC7CPJ+kdbcbnseF2W/upjSo23ElmU+jEsG2fYccl/hVbg4PzA+0iYPaA1vZWQ73IX7A3OB0lb35MC8LA1Clv2kD0ma4aMyC5qpddJdErXGAoDqaF+NlCquGr73vEKsEr/Q2CLMewnQ2+1WXrZvujpWen4ZMit0ofptP15F8tsjmhnKdbQNUIo7YmEu85NwHG7VchehI
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS4PR12MB9612.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(22082099003)(18002099003)(56012099003)(11063799006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z0lmMzVnMVExQmtMOFpPalhUZDczMW9ZN0F3VWlUMW1Bbi9pN3U5VngwamlH?=
 =?utf-8?B?RVRKUzhaVGF4VU5BeXYrdkloVWdZekFncXpYZ0pIVmtXU29XK2pLdkRoeVRo?=
 =?utf-8?B?RXp0YXdxRGFyUjFlNUd0U0hIZWVIdUw1c0x0enZHME5OYkpLZGNxYzdyUmI3?=
 =?utf-8?B?aDE2MzV4dXlOc09XbzFtdWxCWTJVMHBqYkRwNmhyTytjL3c3Z0wxakhEcVZu?=
 =?utf-8?B?eit1SklBNlJ6SVlqSDJPTWt6Q2ZGOHJRQ2tqd3dGSkpQNjdjVXZaMytkb1Rr?=
 =?utf-8?B?dmVuampYd2V5Nllmc3Rpb29yakRsT2FvRWlxRE44TTdodVYrZjdtL2NDU2tz?=
 =?utf-8?B?bDdzbTFUTEU3bEV0YWlXZ2dRSGFzQ2ozZ1dDeTNKY1g5K3pZeEduOWM1UFp2?=
 =?utf-8?B?aURVTTMyZklXVUdXUFhobTRQQ2VRYjl5bkpNeVNxaFZDM3Znd0l6OTdIaE5o?=
 =?utf-8?B?T2NUUFpZODBvUFNVOENVaXJwaFgwYkNnTTRvQWw3dFpnYmNJQmUwWGVjUlpm?=
 =?utf-8?B?QWNwWTE5bmFwYkVnbU5sSCtMTlZXdHl1dzZNMEFzUXBhU2llcGYrN1h2dE1h?=
 =?utf-8?B?dkpXV2J0anIxSmV5MTdQeFk0eTgrWWxLYU45b0JqWll2Ny8wVkFSM1QwbUVm?=
 =?utf-8?B?KytZNGlWNnBXOGQ3MCsyOXUrOEpZT2lDTjFkMVhsS1pSTW5Sb04rVVpSUG5u?=
 =?utf-8?B?cE5maC9obUtNWlRGOWk3UUJ3dHJxTzZZNU9JaTZ4cDJkYnFtS2pIcmpPVHZK?=
 =?utf-8?B?bzkxTkcvQXdqMnpLUXRuM2lsRHJhYit1cmZtMEVXVC9OdDV6N3VnaG90Wnl5?=
 =?utf-8?B?dlB4TWZTWGovK1RJOS9CRHdGb3dMcHk2b3dVMDZzVkw2ZjJxWUNqU0Y4aC9p?=
 =?utf-8?B?Qnp2bi95eXFuazJQTHdXWFljVTcyL2s5K2xwTHh3Tmp2OVBqUU1udytRSlRD?=
 =?utf-8?B?VVBhZ2I2NU9oM01oNENOdXhwbXc2Qm8wdWYxYUtoeENjS3doOURLd2x2dGYx?=
 =?utf-8?B?dThoYmQwdHo1UWlaUlJobHlGSC9JbDN2VWdqdm8wbzFFOTZhS0FQKzdMS3hk?=
 =?utf-8?B?QUZVb3N3SldlUm1GSUZ0ZVliSVZOUFJZNldEeWNWb09RN1BrMDZYM1dGUEZV?=
 =?utf-8?B?VEJFclA2WU5kUVZlNUZsemZ4MlhOV0pLZUEyZ01DdmtpaXFiMURXak0vMWhm?=
 =?utf-8?B?R3hWZWFGWlNrbWhmUndQbXgxdStpbjNqbGNnUVJpSC9kOU94bGZxR2t1M1hT?=
 =?utf-8?B?UVExWGwvYUs2SlJKckxFUHhKOHp6ZXJZYi9mbFNNOGZKbWRBK0xGYy9TWkly?=
 =?utf-8?B?cTFqcW1tYU1Vam5FUkV2dG1xNjhDTWQ3UHNyTnlQYStlZlVPY0U5MldxU1BX?=
 =?utf-8?B?YkszZStNN2ZLQ0xVUDZ3U2lkUmtMSHBsN09wOGZNM2cxWXNXa1doSWRVeC83?=
 =?utf-8?B?dHQ3Tmd6dkJLYmJLVi9nb1JabzZIZ1QvVGFiT1Bza3BBRnVtSSs3MFJ6SGp6?=
 =?utf-8?B?UHhPbVVCbEYzaEwrQkpQYTRjdzgrU0tDQ1d1MGUvWHZPMDJmTVdqaFJQODlP?=
 =?utf-8?B?SEV4dDlpa2twNHBlMmNnVkovNzQ0N2xKRzRkRjVhRzFkRis5Y01ISW43LzFW?=
 =?utf-8?B?VWNCaGovaW9xNkpTeXN6Rllvd3pQeVNaRzFSVXhFU1V5NmRRMjFQQ3NTRkNL?=
 =?utf-8?B?VTgvZXA4eVBCL016WjBBbVV5b2ZLcjBNTTQrUDFxSmpkWkZ1cEJ1UUxQN2RL?=
 =?utf-8?B?OGtzOUxDUjNTRFcxUnZKb081c25paUI0T0QvN3VSWmVCem40SCtOTGhDOGVs?=
 =?utf-8?B?Nzlkc2hYZDJseTNZKy9lL2E2K0VhY21yL0FxVEVNTmVwWHhhcE8wVkRucjB4?=
 =?utf-8?B?TEZKQjNGWXNHbGhJdzNoL1Q2eFh3blNhSDhRek1Fa1FhSjFsb29qMXR1Nkkw?=
 =?utf-8?B?OGxCM0VzazVhaVNoczBWUEFBODgyeFFEQVNRT0U1UkF4bldmelI2OXhqM3lJ?=
 =?utf-8?B?MjRNT0JlQzd0WmVKK1NHL3pRVm92d1VmQXM0THplSmFGTHFJbjl5clBseEls?=
 =?utf-8?B?MDIzUnFLK1pjR08vMzVSN2dNQnM5YlByeFVUUFcvdjBZK1NLK1VYdkE0ZmQv?=
 =?utf-8?B?VGVhdmNXVDVsZWdnc0dROE1QZFhlTVVoSTVHQUVNRkJJeGhRTHNOZDF4WnM1?=
 =?utf-8?B?bTBUeHYyakxScmE4VXFGaklOWXBTMzM3TkxEZWZBT3piZytuT3lJbnczNjU5?=
 =?utf-8?B?UkdHKy9KTFp0RmoyTzZha2dNdTd2T0I0RlF3ZldZM0szYjNoWmxaK3cyd1dp?=
 =?utf-8?B?ZmczeXJlZUQrSUhjYUN6TWk2MjJFMHJucE5SeURtR0V2aXZNczYwZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd8d1dfb-120f-4112-116a-08deb6c5ef72
X-MS-Exchange-CrossTenant-AuthSource: DS4PR12MB9612.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2026 23:17:17.7032 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y+EiTXdzyqKuhJABnGzoZRHUmiZiZtQAquvgRFBhMbwf2hlNXsPmHbrPmyqAS9lEU74rhVI866DMvMtt8cnF3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7516
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


On 2026-05-20 03:13, Yifan Zhang wrote:
> This patch is to check per pdd sigbus delay time.
>
> Fixes: f207b038bc38 (drm/amdgpu: add ioctl to handle RAS poison error)
>
> Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>

Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_events.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_events.c b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
> index 8b4e0a208e86..69fed7e5b122 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_events.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
> @@ -1388,7 +1388,7 @@ static void kfd_signal_sigbus_delayed_fn(struct work_struct *work)
>    * Rationale: if the app has explicitly opted in on any GPU it uses, it
>    * wants the chance to handle the error in userspace.
>    */
> -static u32 kfd_get_sigbus_delay_ms(struct kfd_process *p)
> +static u32 kfd_get_sigbus_delay_ms(struct kfd_process *p, struct kfd_node *dev)
>   {
>   	u32 result = 0;
>   	int i;
> @@ -1399,7 +1399,7 @@ static u32 kfd_get_sigbus_delay_ms(struct kfd_process *p)
>   		struct amdgpu_fpriv *drv_priv;
>   		u32 v;
>   
> -		if (!pdd || !pdd->drm_file)
> +		if (!pdd || !pdd->drm_file || pdd->dev != dev)
>   			continue;
>   		if (amdgpu_file_to_fpriv(pdd->drm_file, &drv_priv))
>   			continue;
> @@ -1420,7 +1420,7 @@ static u32 kfd_get_sigbus_delay_ms(struct kfd_process *p)
>   static void kfd_signal_sigbus_with_delay(struct kfd_node *dev,
>   					 struct kfd_process *p)
>   {
> -	u32 delay_ms = kfd_get_sigbus_delay_ms(p);
> +	u32 delay_ms = kfd_get_sigbus_delay_ms(p, dev);
>   	struct kfd_sigbus_delayed_work *dw;
>   
>   	if (delay_ms == AMDGPU_USER_OPTIONS_KFD_SIGBUS_DELAY_DISABLED) {
