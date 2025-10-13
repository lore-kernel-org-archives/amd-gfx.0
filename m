Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6191CCD185
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Oct 2025 07:21:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 47F9E10E3D6;
	Mon, 13 Oct 2025 07:21:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Pg3D9xI9";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011008.outbound.protection.outlook.com [40.107.208.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0351410E3D6
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Oct 2025 07:21:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wKAdTLC+I4uBz5SnBE3emxN/sHKMO9I6t5E1mpVUUMdSrKIOn6NHizA3UXa7EUb9DFJmKU3ZwkGdHG+ZwaAA52GHVtQFRiZh7P2AAXVELDbWQqaJGBMvDSYAEzN3/vDez5DsHljcRMrk6TvR3ch3waAIVaMfhHjgYwJ4Xn8AzBbzyOg4KcyJQyyRoOeYwcHa4iYP8rotSXDg1QwFHL5CNoIAdd7uTp8Ke6G95/a3tmQB2frAMjoVcbptwRo4BX6z4kEm6Zsd/4pgVo6iOQ373aV6JwJcRV55ap3QmaQi/Ve7UP8m6jojA1kA+lZWE8Jf1KX1cr5nbMpLI84FZ8CLkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0aR612Skab4Iy3Z4LL/j1s4W/HwLppkub+xVEww9tAA=;
 b=S0s6m4J152IGfvKSnzN0oQ7ErC+WskzdkLnJooQcZ1azE+Vf8CsBfZJkMsMRXxz/pnscOZ76Dm2CNH/aRRr3gcIjfjSA9/CHveuTXuM91ySD2RICGzbI8V2g6CN+dKaiHQsXs5mtznH1crpgTR9PXrPohnRYhua57wytfsTCi6cj/qt9ajnPPXWl6iA42fsTBQZGcty5X4pXtOTa9WHG7CNcDAnDi/mw04RahaCYd7JluA9Qa1Fj6xJ8PIB8ndoHBWVCWDwqNxLWYddBBas9yyMz+g5aZxKbuB3/vltzk0jOcGRqMx7AYxURlQVoQhVbYQ0RXoD7AQXWRaMsJT3KLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0aR612Skab4Iy3Z4LL/j1s4W/HwLppkub+xVEww9tAA=;
 b=Pg3D9xI9yhq+/2q6l/YzfVvZ3BPnYv0eVk1aVQre6JSBMrgZxr6ZvaTDM/8Y2QRfeKWBZrRdBUP+auicCpk+9xc3k4VMc1cd4PI9uULs/ic6puzzv9pB+wD5xKv4alxHiXMeNytmMQ2s04hQDSAyLTMXiEqVfc97AVQ+3vuRCdw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.9; Mon, 13 Oct
 2025 07:21:40 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.9203.009; Mon, 13 Oct 2025
 07:21:40 +0000
Message-ID: <3e99bd77-4117-4869-8156-90203d38ad9e@amd.com>
Date: Mon, 13 Oct 2025 09:21:36 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v4 1/2] drm/amdgpu: update the functions to use amdgpu
 version of hmm
To: "Khatri, Sunil" <sukhatri@amd.com>, Sunil Khatri <sunil.khatri@amd.com>,
 Felix Kuehling <felix.kuehling@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20251010140712.3983709-1-sunil.khatri@amd.com>
 <af6a5ced-07e7-400b-83c5-613ed7f06a30@amd.com>
 <20987a17-e3f7-487d-ba9f-c2296534d56a@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20987a17-e3f7-487d-ba9f-c2296534d56a@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN9PR03CA0889.namprd03.prod.outlook.com
 (2603:10b6:408:13c::24) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|LV2PR12MB5990:EE_
X-MS-Office365-Filtering-Correlation-Id: faf8743d-0299-4b02-a475-08de0a292765
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?a2w5NHowY1U2azU0dTdwblpOeTlxd2lXcHljcDhiVmRKdTBwSjY1M0xnOFhD?=
 =?utf-8?B?SnBaZTdtWVo4cFdaZDc1a3VQVkFnQWpnc2pSWDMzOXdlbzJESlRHVCtOWEpu?=
 =?utf-8?B?NTZ3WEhyb1NnUGZ5OTR3TlpBRC9FOVBHWldRSTQ4a0lSYnBDRDVjc1JGN3cr?=
 =?utf-8?B?WVBQY2ZUM1l2UkZEMjdMT1pwYUk0RGNyQkVYQ2tmMWo1eHZMN0hROUc0TWNr?=
 =?utf-8?B?VTRsK0o2VFI2TDJYUkgwV3JrNWVaOEtsWERwUHlFbzQ3ODJsb3RjSGdpQ0Jp?=
 =?utf-8?B?OGdEeTVVaHZURmtveGpUcTBXbkJDQXZtK3RBbDNwWWk4UmNYYjhrQmJsYm4z?=
 =?utf-8?B?QWREV1NrZ2tYa0FqelF5dmdPdHR4dU4zZEpxRG9Bd05NYmwwQlZmWUFCK1B4?=
 =?utf-8?B?V3AvNm5tdWtDU2FaSkZHNjAvd2szeHZWU2EwL1RteTVQOFdXQ1p3S2laaFdP?=
 =?utf-8?B?VllDZVZaUUdYeWZPSkN3UStrRjhzZmJQK2ZkTUJZNklqaWc2dzF4NGJiQzR1?=
 =?utf-8?B?c0R0L0R6Y0U0cEdpVlJZYTdtRW5WY3oxSTBTUUZQeUt5a3VzZSthUUJiT1lv?=
 =?utf-8?B?bzg0R0tYWGZCMU9LMDJiczNncENWQ2c5RVNBNnZsTzRMZHBTSEdJbWRrOXh1?=
 =?utf-8?B?cXlER1QweUlrMG53Mkt4NDNJdGNGd05kK2o2SWwyeVRIUlh1NzF5R25zcmlU?=
 =?utf-8?B?eWFGS1N2aHpraGNhSEZZdHA5T2xYdjBaelVVR3Iyc1lFZzRFLzd6Y21wU0Mr?=
 =?utf-8?B?bmJnTUU0ZGw1cmRLa0EwVWcwcmliQlJvWUozbVJxT3J4VVpIVzBHeTZtd2dE?=
 =?utf-8?B?Z0hFMTBwYXA2Qm41UU9KZUc1NVBmY0NvRnA5Z0Rtc1kxZ1lCYk1wNHcyVjhl?=
 =?utf-8?B?OEkwdVYzNnd6M1lObVpBT21LR3NpbXNjSFVnNnFUN0k0bW14dUFPeVVLckVj?=
 =?utf-8?B?Tmw2TXU5OElFTHJxMVhwcitJbzkxNU05dEQ2YjNhWWhsWi81Q1dZYXJCUzJ4?=
 =?utf-8?B?MUVPblZwUE5Fb0FJRUk5OWFSTWM4a1B4S3Bsb0JNQzgxWGU3SmM4ODNJZlFH?=
 =?utf-8?B?Q29XUFFHTFYySFBzM01SR3UxUUxLQzZQOHpLZUowbG82UDM5TzNkTTJySk5q?=
 =?utf-8?B?Y0VPbGlta09aSnZiRXVQYVErQS9SeDMwNXYyeGw5MTZkTmdCRHFDMFNvb1Vt?=
 =?utf-8?B?RVN3YWRBMTI5Qks4eFpVeXc1aEVIZ3lybmdDMVF0OVR0Q0U3VUM3bFZMQ3ZK?=
 =?utf-8?B?SDkzU1NLazBHQVpjMEFGTitxa2t4Nk84VjcyVWVEaUdQRHFMYnlVOE1nSmll?=
 =?utf-8?B?dklpYUZtcFFWMWR5WjJ0K0NvbENscDFhSVYwN0FDY253dkZnaWEvTExIVEZJ?=
 =?utf-8?B?cjFWa0lrMWYydXVIQVhiclNsVnhOMDFFcVhiK1oxNm1LVERuYkNwVG9DNEdq?=
 =?utf-8?B?OXVRWExyZmZVUE5EU1VvbThXRWllYjZZaFg0Y1ZObzhHbit1am0rLzA0eU5G?=
 =?utf-8?B?ckNsQnlGbEdWUDBhQ2xOZXRsTUdIYUhobElENXo5Y2x0L3BubzR6U1lJMHNZ?=
 =?utf-8?B?akJSaE5OSENmY2JiNWlZWXJEU1M4dW9VdjR0SHdROGFkaHEwMmR0V0d1alY1?=
 =?utf-8?B?ZGtKODFsU0lIZXd1cDdMQ050UXNxUjJmTUlkMnA3THRDelJQZklkTkhQNnRq?=
 =?utf-8?B?TWlVTjlKeXJTaGl1ZVJhQmk3Y1I4eVlVZUhNbVk3amxjYi9XSEhZOUtOb2xJ?=
 =?utf-8?B?cXFvU2VqZUtZZVNvamdDYXZodlJoN3RKWUM1WkpqV2xEeDgyWkJCeUhlSkgv?=
 =?utf-8?B?Nmt3a3FuZUVCenFmbTBrbjQyK0R1UXB2ZjRqcHAyeFJsM2M3dDNkWmpGQTU5?=
 =?utf-8?B?OVJqOVZaTHhBVmFCZFpzNzJ5S1ZxVG1pT2lEY1BDNlRMQzVzQmZCYWpRSGo4?=
 =?utf-8?Q?u6cqLF8RL2euA04zItsSzFZ9t9mkEVN9?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZHlzV3YvWU5NYXJucVhmd2VrREtwdTNSRGFEejB5UU80a0Y5N3NQUGY4SjJl?=
 =?utf-8?B?S2huR3NBdHh1NlR2aGgzWEZtQXJGM0ljZmxYL2pwekFEanA5dEh4cE01Z1Jy?=
 =?utf-8?B?Tncvb3NyL2YrKzVTODNQcjA1L3ZpUFAxaFZkOFR3WGlwUDVvdG82Z0VOKzFG?=
 =?utf-8?B?YU8zbVIwNFI2dlpNazBkalo2cFhuRkV4YThHNjdYenJaYmkweHhZbGxsd3ls?=
 =?utf-8?B?aXZLYzhPVnZXeE5XWTNzenp1YWhvRERkTDN0UnM1RXdiUWpXTUlhb3ppc2Zr?=
 =?utf-8?B?NlJKRVZRcURwSW5xdUVqWm1qcFgyUHBKV1gxRHExdGNlMVJ0Z3V2SzVpWnFX?=
 =?utf-8?B?dGRRVUVrVkw3V2J2ZUg0alFUaFNaOHlGWHZrR25zY05pbDB4THRBWjJvZnUx?=
 =?utf-8?B?VzVOU2tleHgwNENrL2dJbGY0VXhMaWxSRXRzeVQ4OHBPRklsLzJublVRL3Bl?=
 =?utf-8?B?MDkwV0RsSzh0S1lxa0xqVzhoRzhqTVh2djhkNlN0ekFBZWVJZTlNczcyYWhu?=
 =?utf-8?B?OGl1cklCVzh0eUxXNkxnNTArdXIwZFI2QjNHM253S1VxWFl4alRsbUJ0TlBR?=
 =?utf-8?B?R0g3cUwyRkFOSGdBRXVpRnVFNUdycEVxbTF3a3cxV1pYcVdVYWwyVWNWMU00?=
 =?utf-8?B?VWN6UVlXRFFDQ2xtYW9tQjBxMisrZEJvTlRDTEpDcW1NRFBjK1c1eTJGYXFX?=
 =?utf-8?B?QUhhazlIMHBudTFsRG5PZDRzVXhrTVZMTW9uempmSnZYbWJ0aXlqM2J6eDFo?=
 =?utf-8?B?d20raTV5MnVEdGRIM1p4STYvU2NXcllJWFRkUk4rSHNZdzh0YU03VGZXVy9H?=
 =?utf-8?B?TkRhaXd5bUpQVStHa3VIVmx4bFAzblk0ZVppRUVqYlNISm5BSktYMkpmY1dF?=
 =?utf-8?B?NzVranU0bGkyamNKQVprdXBuek5nbUNxcForVzkyTjd2ZkYwNnpZcU0zb281?=
 =?utf-8?B?SXB0VDlWQzM4QStVaG5yVVl4S0FveFVFUlI0SkYxMXdzYXUwVGFBd2FTVjNV?=
 =?utf-8?B?T1NZeWF6K0VXL1ZYdnNIR0FzckNEUitDeVBucGgvQ1gxbTRRYlpFb3NqbUs5?=
 =?utf-8?B?Zkd4d29ZdlUxeU83N3pMSWFCZENJV3lCZXdmdVpkRXlkRnJkR0l5ODloTG9C?=
 =?utf-8?B?OVgwZDJLb2IrR0x2NWlLM2lIS2NleUlJZXR0cy9EMG05WEI0NmxLWmpaVm1y?=
 =?utf-8?B?TldTUnAxVk5rOHFDWW9xZ0d3VjlxTHF6amVJRE5tdDBpZ1haWkVkUVlvZ2Zs?=
 =?utf-8?B?MjQ2MVdKWWNMbEtKWm9zeFFqTWd0ZEdkTHhrNG11TnlqcmQzbHlqQTFHZU9l?=
 =?utf-8?B?TGlhZHdNZEdYMi91cVRXd1pJek5xazRTZEdzYkJ4ME4rakx1WFVDWCtBTFc5?=
 =?utf-8?B?TXQ2WkpXdk9tclhRdlg5T1VGKy9TNldZWllKbnJMVFJ6UHFIaEhkQXIzL0Fa?=
 =?utf-8?B?Ty81Z3hPN1hadnlVSXdWbm51ZXNOZndLS1RQaUk2MHEvSHRlQlZRdEhYeXpZ?=
 =?utf-8?B?djhGait5T2tIMElHdURIOHFkM1RZa2JrZXExbENMUDFra2RTYXpjUmM3cVNU?=
 =?utf-8?B?N1htSnBJNlF2MzNUK05NT2R6VUI4Qi9xaDVTUXRLenRqc1Y2djJXc1IzYVJR?=
 =?utf-8?B?Rm5aMTNvdHZob3lOcWs1enVjdERYaXdvQUpYbnFaTk9PUFFpaFRSMWc1VEc1?=
 =?utf-8?B?TmJUVTY5L1FyZ3EvVzljcXVOU0ZNSURlU2taZVYzMmhPN21vK0xiWlp0VG1l?=
 =?utf-8?B?cUF0VnJOTlVRRXNGSUdWL1BUc0xScmZNb3ZoUkdPNXVuR3ptcDY5S3VVNEt1?=
 =?utf-8?B?ZVY0OTY1SU5ycVpudnA4am9XcndscEE2Tm8vTnQzeUNxR1BZMmlWVnpzU1Y1?=
 =?utf-8?B?bU5LUEo5WXJEZFp4dHJlRnlFWkNrSkNxZytRQi8zUWo4L2ZOQ2RIQVY5UlZR?=
 =?utf-8?B?T1Q0eW55bzAyUnhwVTlUbXgyUnNJUDBORk9MN3IxeXhCSUNTQnpXT3hJSUhp?=
 =?utf-8?B?TmlYOHYxWEhtVklldVRwZ3FGVWlzWmpQVTlLQW1yY2l0ZlVYbHFKQ243U3h1?=
 =?utf-8?B?SWtaSTRTQ1FncFBRRFNOR2dHN1B2amR5b3Y0SUtLalVxYm1NWFRXNnJrL0tF?=
 =?utf-8?Q?ghi3yg7axVqfBCl18smC6Iwfa?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: faf8743d-0299-4b02-a475-08de0a292765
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2025 07:21:40.6279 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hpctt5RiXATSWBm0Cn6YUb4M4tPPzlaiIZS4JlsMNFu3GzNbfl3Gbw7n9hbskSgB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5990
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

On 13.10.25 09:19, Khatri, Sunil wrote:
> 
> On 10/13/2025 12:42 PM, Christian König wrote:
>> On 10.10.25 16:07, Sunil Khatri wrote:
>>> At times we need a bo reference for hmm and for that add
>>> a new struct amdgpu_hmm_range which will hold an optional
>>> bo member and hmm_range.
>>>
>>> Use amdgpu_hmm_range instead of hmm_range and let the bo
>>> as an optional argument for the caller if they want to
>>> the bo reference to be taken or they want to handle that
>>> explicitly.
>>>
>>> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h    |  2 +-
>>>   .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  |  6 ++--
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.h   |  2 +-
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c        |  6 ++--
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c       |  4 +--
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c       | 36 +++++++++++++------
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.h       | 19 ++++++----
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c       |  6 ++--
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h       |  7 ++--
>>>   drivers/gpu/drm/amd/amdkfd/kfd_migrate.c      |  1 -
>>>   drivers/gpu/drm/amd/amdkfd/kfd_migrate.h      |  1 -
>>>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c          | 14 ++++----
>>>   drivers/gpu/drm/amd/amdkfd/kfd_svm.h          |  1 -
>>>   13 files changed, 61 insertions(+), 44 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>>> index 9e120c934cc1..8bdfcde2029b 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>>> @@ -71,7 +71,7 @@ struct kgd_mem {
>>>       struct mutex lock;
>>>       struct amdgpu_bo *bo;
>>>       struct dma_buf *dmabuf;
>>> -    struct hmm_range *range;
>>> +    struct amdgpu_hmm_range *range;
>>>       struct list_head attachments;
>>>       /* protected by amdkfd_process_info.lock */
>>>       struct list_head validate_list;
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>>> index 22c1bdc53d2e..56097fb6eecd 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>>> @@ -1057,7 +1057,7 @@ static int init_user_pages(struct kgd_mem *mem, uint64_t user_addr,
>>>       struct amdkfd_process_info *process_info = mem->process_info;
>>>       struct amdgpu_bo *bo = mem->bo;
>>>       struct ttm_operation_ctx ctx = { true, false };
>>> -    struct hmm_range *range;
>>> +    struct amdgpu_hmm_range *range;
>>>       int ret = 0;
>>>         mutex_lock(&process_info->lock);
>>> @@ -1089,7 +1089,7 @@ static int init_user_pages(struct kgd_mem *mem, uint64_t user_addr,
>>>           return 0;
>>>       }
>>>   -    range = amdgpu_hmm_range_alloc();
>>> +    range = amdgpu_hmm_range_alloc(NULL);
>>>       if (unlikely(!range)) {
>>>           ret = -ENOMEM;
>>>           goto unregister_out;
>>> @@ -2574,7 +2574,7 @@ static int update_invalid_user_pages(struct amdkfd_process_info *process_info,
>>>               }
>>>           }
>>>   -        mem->range = amdgpu_hmm_range_alloc();
>>> +        mem->range = amdgpu_hmm_range_alloc(NULL);
>>>           if (unlikely(!mem->range))
>>>               return -ENOMEM;
>>>           /* Get updated user pages */
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.h
>>> index a716c9886c74..2b5e7c46a39d 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.h
>>> @@ -38,7 +38,7 @@ struct amdgpu_bo_list_entry {
>>>       struct amdgpu_bo        *bo;
>>>       struct amdgpu_bo_va        *bo_va;
>>>       uint32_t            priority;
>>> -    struct hmm_range        *range;
>>> +    struct amdgpu_hmm_range        *range;
>>>       bool                user_invalidated;
>>>   };
>>>   diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
>>> index 087e5b5497e4..87872c0282e4 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
>>> @@ -29,7 +29,6 @@
>>>   #include <linux/pagemap.h>
>>>   #include <linux/sync_file.h>
>>>   #include <linux/dma-buf.h>
>>> -#include <linux/hmm.h>
>>>     #include <drm/amdgpu_drm.h>
>>>   #include <drm/drm_syncobj.h>
>>> @@ -886,7 +885,7 @@ static int amdgpu_cs_parser_bos(struct amdgpu_cs_parser *p,
>>>           bool userpage_invalidated = false;
>>>           struct amdgpu_bo *bo = e->bo;
>>>   -        e->range = amdgpu_hmm_range_alloc();
>>> +        e->range = amdgpu_hmm_range_alloc(NULL);
>>>           if (unlikely(!e->range))
>>>               return -ENOMEM;
>>>   @@ -895,7 +894,8 @@ static int amdgpu_cs_parser_bos(struct amdgpu_cs_parser *p,
>>>               goto out_free_user_pages;
>>>             for (i = 0; i < bo->tbo.ttm->num_pages; i++) {
>>> -            if (bo->tbo.ttm->pages[i] != hmm_pfn_to_page(e->range->hmm_pfns[i])) {
>>> +            if (bo->tbo.ttm->pages[i] !=
>>> +                hmm_pfn_to_page(e->range->hmm_range.hmm_pfns[i])) {
>>>                   userpage_invalidated = true;
>>>                   break;
>>>               }
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>>> index 82ddc8c22b64..ce073e894584 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>>> @@ -530,7 +530,7 @@ int amdgpu_gem_userptr_ioctl(struct drm_device *dev, void *data,
>>>       struct drm_amdgpu_gem_userptr *args = data;
>>>       struct amdgpu_fpriv *fpriv = filp->driver_priv;
>>>       struct drm_gem_object *gobj;
>>> -    struct hmm_range *range;
>>> +    struct amdgpu_hmm_range *range;
>>>       struct amdgpu_bo *bo;
>>>       uint32_t handle;
>>>       int r;
>>> @@ -571,7 +571,7 @@ int amdgpu_gem_userptr_ioctl(struct drm_device *dev, void *data,
>>>           goto release_object;
>>>         if (args->flags & AMDGPU_GEM_USERPTR_VALIDATE) {
>>> -        range = amdgpu_hmm_range_alloc();
>>> +        range = amdgpu_hmm_range_alloc(NULL);
>>>           if (unlikely(!range))
>>>               return -ENOMEM;
>>>           r = amdgpu_ttm_tt_get_user_pages(bo, range);
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
>>> index b582fd217bd0..9da1c5c69632 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
>>> @@ -168,12 +168,13 @@ void amdgpu_hmm_unregister(struct amdgpu_bo *bo)
>>>   int amdgpu_hmm_range_get_pages(struct mmu_interval_notifier *notifier,
>>>                      uint64_t start, uint64_t npages, bool readonly,
>>>                      void *owner,
>>> -                   struct hmm_range *hmm_range)
>>> +                   struct amdgpu_hmm_range *range)
>>>   {
>>>       unsigned long end;
>>>       unsigned long timeout;
>>>       unsigned long *pfns;
>>>       int r = 0;
>>> +    struct hmm_range *hmm_range = &range->hmm_range;
>>>         pfns = kvmalloc_array(npages, sizeof(*pfns), GFP_KERNEL);
>>>       if (unlikely(!pfns)) {
>>> @@ -226,25 +227,38 @@ int amdgpu_hmm_range_get_pages(struct mmu_interval_notifier *notifier,
>>>       return r;
>>>   }
>>>   -bool amdgpu_hmm_range_valid(struct hmm_range *hmm_range)
>>> +bool amdgpu_hmm_range_valid(struct amdgpu_hmm_range *range)
>>>   {
>>> -    if (!hmm_range)
>>> +    if (!range)
>>>           return false;
>>>   -    return !mmu_interval_read_retry(hmm_range->notifier,
>>> -                    hmm_range->notifier_seq);
>>> +    return !mmu_interval_read_retry(range->hmm_range.notifier,
>>> +                    range->hmm_range.notifier_seq);
>>>   }
>>>   -struct hmm_range *amdgpu_hmm_range_alloc(void)
>>> +struct amdgpu_hmm_range *amdgpu_hmm_range_alloc(struct amdgpu_bo *bo)
>>>   {
>>> -    return kzalloc(sizeof(struct hmm_range), GFP_KERNEL);
>>> +    struct amdgpu_hmm_range *range;
>>> +
>>> +    range = kzalloc(sizeof(struct amdgpu_hmm_range), GFP_KERNEL);
>>> +    if (!range)
>>> +        return NULL;
>>> +
>>> +    if (bo)
>>> +        range->bo = amdgpu_bo_ref(bo);
>> The functions amdgpu_bo_ref() and ...
>>
>>> +
>>> +    return range;
>>>   }
>>>   -void amdgpu_hmm_range_free(struct hmm_range *hmm_range)
>>> +void amdgpu_hmm_range_free(struct amdgpu_hmm_range *range)
>>>   {
>>> -    if (!hmm_range)
>>> +    if (!range)
>>>           return;
>>>   -    kvfree(hmm_range->hmm_pfns);
>>> -    kfree(hmm_range);
>>> +    kvfree(range->hmm_range.hmm_pfns);
>>> +
>>> +    if (range->bo)
>>> +        amdgpu_bo_unref(&range->bo);
>> ... amdgpu_bo_unref() have intergrated NULL checks. So checking it here is superflous.
> Sure will do that.
>>
>> It would also be helpful to have some kerneldoc on amdgpu_hmm_range_alloc() and amdgpu_hmm_range_free(), but that is not a must have.
> 
> I guess that will be in a new patch set. will see how it is done and if i can use and existing one to update that.

Works for me. A lot of people also prefer to add kerneldoc as separate patch at the end of their patchset, so that you can see first how all puzzle pieces fall together before you add documentattion about it.

Regards,
Christian.

> 
> Regards
> Sunil Khatri
> 
>>
>> With that fixed the patch is Reviewed-by: Christian König <christian.koenig@amd.com>
>>
>> Regards,
>> Christian.
>>
>>> +
>>> +    kfree(range);
>>>   }
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.h
>>> index e85f912b8938..140bc9cd57b4 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.h
>>> @@ -31,15 +31,20 @@
>>>   #include <linux/interval_tree.h>
>>>   #include <linux/mmu_notifier.h>
>>>   +struct amdgpu_hmm_range {
>>> +    struct hmm_range hmm_range;
>>> +    struct amdgpu_bo *bo;
>>> +};
>>> +
>>>   int amdgpu_hmm_range_get_pages(struct mmu_interval_notifier *notifier,
>>>                      uint64_t start, uint64_t npages, bool readonly,
>>>                      void *owner,
>>> -                   struct hmm_range *hmm_range);
>>> +                   struct amdgpu_hmm_range *range);
>>>     #if defined(CONFIG_HMM_MIRROR)
>>> -bool amdgpu_hmm_range_valid(struct hmm_range *hmm_range);
>>> -struct hmm_range *amdgpu_hmm_range_alloc(void);
>>> -void amdgpu_hmm_range_free(struct hmm_range *hmm_range);
>>> +bool amdgpu_hmm_range_valid(struct amdgpu_hmm_range *range);
>>> +struct amdgpu_hmm_range *amdgpu_hmm_range_alloc(struct amdgpu_bo *bo);
>>> +void amdgpu_hmm_range_free(struct amdgpu_hmm_range *range);
>>>   int amdgpu_hmm_register(struct amdgpu_bo *bo, unsigned long addr);
>>>   void amdgpu_hmm_unregister(struct amdgpu_bo *bo);
>>>   #else
>>> @@ -52,17 +57,17 @@ static inline int amdgpu_hmm_register(struct amdgpu_bo *bo, unsigned long addr)
>>>     static inline void amdgpu_hmm_unregister(struct amdgpu_bo *bo) {}
>>>   -static inline bool amdgpu_hmm_range_valid(struct hmm_range *hmm_range)
>>> +static inline bool amdgpu_hmm_range_valid(struct amdgpu_hmm_range *range)
>>>   {
>>>       return false;
>>>   }
>>>   -static inline struct hmm_range *amdgpu_hmm_range_alloc(void)
>>> +static inline struct amdgpu_hmm_range *amdgpu_hmm_range_alloc(struct amdgpu_bo *bo)
>>>   {
>>>       return NULL;
>>>   }
>>>   -static inline void amdgpu_hmm_range_free(struct hmm_range *hmm_range) {}
>>> +static inline void amdgpu_hmm_range_free(struct amdgpu_hmm_range *range) {}
>>>   #endif
>>>     #endif
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>> index 96bd0185f936..fd00ec7c99a1 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>> @@ -709,7 +709,7 @@ struct amdgpu_ttm_tt {
>>>    * that range is a valid memory and it is freed too.
>>>    */
>>>   int amdgpu_ttm_tt_get_user_pages(struct amdgpu_bo *bo,
>>> -                 struct hmm_range *range)
>>> +                 struct amdgpu_hmm_range *range)
>>>   {
>>>       struct ttm_tt *ttm = bo->tbo.ttm;
>>>       struct amdgpu_ttm_tt *gtt = ttm_to_amdgpu_ttm_tt(ttm);
>>> @@ -762,12 +762,12 @@ int amdgpu_ttm_tt_get_user_pages(struct amdgpu_bo *bo,
>>>    * that backs user memory and will ultimately be mapped into the device
>>>    * address space.
>>>    */
>>> -void amdgpu_ttm_tt_set_user_pages(struct ttm_tt *ttm, struct hmm_range *range)
>>> +void amdgpu_ttm_tt_set_user_pages(struct ttm_tt *ttm, struct amdgpu_hmm_range *range)
>>>   {
>>>       unsigned long i;
>>>         for (i = 0; i < ttm->num_pages; ++i)
>>> -        ttm->pages[i] = range ? hmm_pfn_to_page(range->hmm_pfns[i]) : NULL;
>>> +        ttm->pages[i] = range ? hmm_pfn_to_page(range->hmm_range.hmm_pfns[i]) : NULL;
>>>   }
>>>     /*
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
>>> index 99c46821b961..0ebb99e8d792 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
>>> @@ -28,6 +28,7 @@
>>>   #include <drm/gpu_scheduler.h>
>>>   #include <drm/ttm/ttm_placement.h>
>>>   #include "amdgpu_vram_mgr.h"
>>> +#include "amdgpu_hmm.h"
>>>     #define AMDGPU_PL_GDS        (TTM_PL_PRIV + 0)
>>>   #define AMDGPU_PL_GWS        (TTM_PL_PRIV + 1)
>>> @@ -191,16 +192,16 @@ uint64_t amdgpu_ttm_domain_start(struct amdgpu_device *adev, uint32_t type);
>>>     #if IS_ENABLED(CONFIG_DRM_AMDGPU_USERPTR)
>>>   int amdgpu_ttm_tt_get_user_pages(struct amdgpu_bo *bo,
>>> -                 struct hmm_range *range);
>>> +                 struct amdgpu_hmm_range *range);
>>>   #else
>>>   static inline int amdgpu_ttm_tt_get_user_pages(struct amdgpu_bo *bo,
>>> -                           struct hmm_range *range)
>>> +                           struct amdgpu_hmm_range *range)
>>>   {
>>>       return -EPERM;
>>>   }
>>>   #endif
>>>   -void amdgpu_ttm_tt_set_user_pages(struct ttm_tt *ttm, struct hmm_range *range);
>>> +void amdgpu_ttm_tt_set_user_pages(struct ttm_tt *ttm, struct amdgpu_hmm_range *range);
>>>   int amdgpu_ttm_tt_get_userptr(const struct ttm_buffer_object *tbo,
>>>                     uint64_t *user_addr);
>>>   int amdgpu_ttm_tt_set_userptr(struct ttm_buffer_object *bo,
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
>>> index d10c6673f4de..3653c563ee9a 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
>>> @@ -21,7 +21,6 @@
>>>    * OTHER DEALINGS IN THE SOFTWARE.
>>>    */
>>>   #include <linux/types.h>
>>> -#include <linux/hmm.h>
>>>   #include <linux/dma-direction.h>
>>>   #include <linux/dma-mapping.h>
>>>   #include <linux/migrate.h>
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.h b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.h
>>> index 2eebf67f9c2c..2b7fd442d29c 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.h
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.h
>>> @@ -31,7 +31,6 @@
>>>   #include <linux/list.h>
>>>   #include <linux/mutex.h>
>>>   #include <linux/sched/mm.h>
>>> -#include <linux/hmm.h>
>>>   #include "kfd_priv.h"
>>>   #include "kfd_svm.h"
>>>   diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>> index 91609dd5730f..f041643308ca 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>> @@ -1698,7 +1698,7 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
>>>       start = map_start << PAGE_SHIFT;
>>>       end = (map_last + 1) << PAGE_SHIFT;
>>>       for (addr = start; !r && addr < end; ) {
>>> -        struct hmm_range *hmm_range = NULL;
>>> +        struct amdgpu_hmm_range *range = NULL;
>>>           unsigned long map_start_vma;
>>>           unsigned long map_last_vma;
>>>           struct vm_area_struct *vma;
>>> @@ -1737,13 +1737,13 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
>>>               }
>>>                 WRITE_ONCE(p->svms.faulting_task, current);
>>> -            hmm_range = amdgpu_hmm_range_alloc();
>>> +            range = amdgpu_hmm_range_alloc(NULL);
>>>               r = amdgpu_hmm_range_get_pages(&prange->notifier, addr, npages,
>>>                                  readonly, owner,
>>> -                               hmm_range);
>>> +                               range);
>>>               WRITE_ONCE(p->svms.faulting_task, NULL);
>>>               if (r) {
>>> -                amdgpu_hmm_range_free(hmm_range);
>>> +                amdgpu_hmm_range_free(range);
>>>                   pr_debug("failed %d to get svm range pages\n", r);
>>>               }
>>>           } else {
>>> @@ -1753,7 +1753,7 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
>>>           if (!r) {
>>>               offset = (addr >> PAGE_SHIFT) - prange->start;
>>>               r = svm_range_dma_map(prange, ctx->bitmap, offset, npages,
>>> -                          hmm_range->hmm_pfns);
>>> +                          range->hmm_range.hmm_pfns);
>>>               if (r)
>>>                   pr_debug("failed %d to dma map range\n", r);
>>>           }
>>> @@ -1764,12 +1764,12 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
>>>            * Overrride return value to TRY AGAIN only if prior returns
>>>            * were successful
>>>            */
>>> -        if (hmm_range && !amdgpu_hmm_range_valid(hmm_range) && !r) {
>>> +        if (range && !amdgpu_hmm_range_valid(range) && !r) {
>>>               pr_debug("hmm update the range, need validate again\n");
>>>               r = -EAGAIN;
>>>           }
>>>           /* Free the hmm range */
>>> -        amdgpu_hmm_range_free(hmm_range);
>>> +        amdgpu_hmm_range_free(range);
>>>               if (!r && !list_empty(&prange->child_list)) {
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
>>> index 01c7a4877904..a63dfc95b602 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
>>> @@ -31,7 +31,6 @@
>>>   #include <linux/list.h>
>>>   #include <linux/mutex.h>
>>>   #include <linux/sched/mm.h>
>>> -#include <linux/hmm.h>
>>>   #include "amdgpu.h"
>>>   #include "kfd_priv.h"
>>>   

