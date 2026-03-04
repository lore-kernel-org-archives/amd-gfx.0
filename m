Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82401EFCE47
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Mar 2026 20:29:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0EAFA10EA9E;
	Wed,  4 Mar 2026 20:29:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ejTFpfmo";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012017.outbound.protection.outlook.com [52.101.43.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8C44810EA9E
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Mar 2026 20:29:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KFkE4xPY3KG5wm+jc/U++mokqwUsB1tWiD6osxb2r6UeLgFqjcaJjVnBD4G0bDiSxizWakKyEZr/GiGc7fonAlPSNKlimfxaRMs78RqKJfPQW+FJaFOxjsk064zMu0MAp+Qe+GgFLnQSfVXJ/SbKAZso0GhXbnes/dC9951lEUBx+JE01I+gkFoIzz2Z3vNrgdIoNqxI5Wf9mxG6cEgc9EdHhM5DqKan/VQBJCXWBBqJI+y+dF9GFqkDkm5ifj79VfNfWqRx0NLHAc4M2EJ1NpG+k2CtiZQaX7MZ0kHFPS8cTeLimcMkc6hvXbNpfxPeCsX5y2UoudSTfvrNhZFhcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=psvebdIueLbxY0zMG9J2D6kzKJx0ueVY+1aRykECBdc=;
 b=Kvn5ZG9jgBgPnbCEqEb2z9MJPV6Mi+OTHqxSRPTlNVHfcfv7WTKyXywjhTVKfu5rObLaBzD3VEcnH3gZXTw5WtwU4KvfyU/CyIAQq125shVPNAenwNRYGm81DiULDpBcMmFcPICtI8TV68Ffd0tgAi91eFcDbmFPNB64JGaWHonZ3NfFtxvLrMQOwtUvicsAvq59KFdwQ1uK05ZTbakKdUFLPLgiEKEd8NwM6zsXB7wSBC7ClqAQ4q0Ip/uJvXE46gLXclg8nEN99OfXUbnM6TraOXxawRm5DYNZRKxs5mGHZ1B+W8AMk4bwTGBMghi0TN2BIj6qFP90Sfz4k1f8CA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=psvebdIueLbxY0zMG9J2D6kzKJx0ueVY+1aRykECBdc=;
 b=ejTFpfmoiy1FnV9uY0hxVNt6g9PZKxQuZp6nRH5Z1nLLYgI5QLvntkKI0K5s1M6Wr3+cqxE459MMXYbhIRI9fOC8yGKf1pcsh02cotn30BF68WGkFBl9WM+iBz3E3r9vLQJaZhK415+e7qYUbDDxcKMZpI2KP0Z5eHRKWrIKGus=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4557.namprd12.prod.outlook.com (2603:10b6:806:9d::10)
 by BL1PR12MB5777.namprd12.prod.outlook.com (2603:10b6:208:390::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.17; Wed, 4 Mar
 2026 20:29:20 +0000
Received: from SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::885a:79b3:8288:287]) by SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::885a:79b3:8288:287%5]) with mapi id 15.20.9678.016; Wed, 4 Mar 2026
 20:29:18 +0000
Message-ID: <5ed306a4-3557-4b75-8410-adf0aa9bb1d6@amd.com>
Date: Wed, 4 Mar 2026 14:29:15 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd: Fix NULL pointer dereference in device cleanup
To: Alex Deucher <alexdeucher@gmail.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20260304200741.1096953-1-mario.limonciello@amd.com>
 <CADnq5_My9MnHifeCLVSAEdd7xjNBeErYfMob4bZwaeSZqWX=Fw@mail.gmail.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <CADnq5_My9MnHifeCLVSAEdd7xjNBeErYfMob4bZwaeSZqWX=Fw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR03CA0100.namprd03.prod.outlook.com
 (2603:10b6:5:333::33) To SA0PR12MB4557.namprd12.prod.outlook.com
 (2603:10b6:806:9d::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB4557:EE_|BL1PR12MB5777:EE_
X-MS-Office365-Filtering-Correlation-Id: f5dbcf04-c14b-473e-df44-08de7a2cb605
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: omE5MDIMroiF5Nl3zDG6j726jV7RxbQxGayVgIJnHM2sx2IaJXUcKqc1TGFdVmlbV+3nnnJW6xTiXVScUcdH4hcOs17/gpA4O7hxJpvcDGTgRGDhqeho0VuiAdcGhTmT/ygXlvcLeajwHqm9Rvy/eqsRTl4MczmFtF5gCZ3eDjpgDCb3kMdzCJHnLpTgMva1OcAOsyDqmvTF6420NpzUDxm7PY211ytoR12GRRON/XeHBm8SXCH4jXr1eYeMSV8zuadgVbwIKUrvp+W/6Nk8vG4oBoWrrP7z+icvpk/A8nqXV5oGPXy1N87Ce5mCKwYrFxgli1k9NmPPxsKbmhlA5QTir9SmqDjbdF8T7pkGlafK5jPX0TiNCqXNAnisE9YJOh4uQCRfHEO7pkyQiuz/ThKSpf129ZGVwhSaCqAuToYnbmXGg2ocGNiUIHmB+V1uRE156CKjJreBwZOVY3fiHEj8rmhzH9fwrdMg4dyDtoJjLprBu0B0R3juUbE0UYo8RUfrI9TFoUuTyjylpf5hsRxn7yFOr1Up4Lx8qPa6TmeWB2e8C5kO9lKfyzdwMq84ySHUyJ5aSdR77J1od6q4QqBg+HtROaKC6EZPoMH0Kt1Zkxt80Am/AvW5VgUbYTe1cB+GObpR4y98iZDgu/Nv7Ojr2VYnxR7MO4d5Q3PW+VgGxw8d2/v1JwOohc6YaPbJCuAgoBEutsyUHxM1khl0IcoEolexPgZuMJ+wJp+EKY8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB4557.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OHFMSG14emFYcnl4aHZZY1RYTE5lODFRdS9XWUEvcmtyRHR3L3ZJNllwNnow?=
 =?utf-8?B?NjZCRyt1N1l0c1M5aTB2a2tMTlBibFV6a1hvdlJDOXZLYXZ1VnYrQ25raWhH?=
 =?utf-8?B?QVJSSFRlOHBhMjNRTzM0QitySGlFNkJFNzlYNGNLbmlDNUZCbUxjY1NtaVhk?=
 =?utf-8?B?UE03bi9lalVJSDQ3ZVRXSTJRTUVKa3RGZkpzRnpUaHN4OEVaZHdENjg2RVlo?=
 =?utf-8?B?OWRNNG1Yam80WWFxbncwOG1WdVEzNTY1RjBHZDlOUUZkbmtkeVZzamplOXps?=
 =?utf-8?B?R2xselZqWVVMVG5Vb2Zzb0lKTVdabHJ0ZlJrVUJ5RVd6dkxBcUdLaEJJLzB2?=
 =?utf-8?B?RXlKbkRkeDJ6bkdEYWRtb2o4RzBpNFlEL2cxSGtQRE1pRmdOWXFiQUFNWjRz?=
 =?utf-8?B?UW1uL1BWblJvelYvYXErQ1V2TVcrOG5EaEl3encxbUVVSit1cXlCbG0yZEhi?=
 =?utf-8?B?S3ZwZ3J6cDdYRnl3SVhXTFFQQWVkLzFtVGNOZ0tiS3ZJZGgzMzJsNGhaQXVC?=
 =?utf-8?B?eW9oWERUdmZneisrcUd5Tjg1ODZxK2tOSWdhNDBQUkNYREF4cVA3eGJQQkJG?=
 =?utf-8?B?b0ZBaWJjdHRIU20ybW1Cdy90MDU1anJJZHBMMkMxckZUd2c5c2FjanZVQzRN?=
 =?utf-8?B?Y2JaelEzbDZvQmRrVDNFSktVQUgwZ0pxVFpUTVhnNG1LaVlqelpJb3VDTURj?=
 =?utf-8?B?QUdHakw4b2RiZXFiUFlBME9UTFcwTzVKbzdyZGptejYrbXl2cDFmeWtjbldL?=
 =?utf-8?B?cWptSi9FRmd3VVNpTUhyT3krT0ZUMUNyblJ6RU1CLzMvWUp0ZngyRzhlRVo1?=
 =?utf-8?B?dnBpSkp5dVc1VmpzbFhQeUpEM0JaVDhvcFdWNjI4VzJsbFUvQzA4TlNMNWNx?=
 =?utf-8?B?WGQ5akhuTC93MHI5SDFzV0JCeXN3dENON25UZkxQakxHb1hoc2JPOEh0SDBv?=
 =?utf-8?B?M0VGay9HMnhEcHcyeVZBY29ISXFjMUJmaXNaUjNFUk1malAyTUlDaHd4dGc5?=
 =?utf-8?B?NWxBV1EvUmNuenNzWkpHU28vcjBCc3IvSGxoMHdTaTk2alB5N3FWKzFFMUUw?=
 =?utf-8?B?Y01EYjNvNVk3L01TbnJDYnZMMTJIa3drV0srcGxwbDZPOWtPT1Y2OFZIa2Qr?=
 =?utf-8?B?L3k4Rk1OcjlodkN1ektLQ0NHelk0Q1NqME10T3B6aVdUOWdCVytJNHdXZmgr?=
 =?utf-8?B?bzhkZXoxbTdCWURBT2x3YWgwaVc2eEJaZmFLVmhIY0ZLeW9KN2o0TUo3Rmkx?=
 =?utf-8?B?Z05zOWpOME04K0xtQ2ZVVjRpcENveEJhY0hTRkFBRm9qcDlXOWFadVNoNmpT?=
 =?utf-8?B?TmFrN2VibFdUSjQ5Vko3NjQxdWVGU1FmbCtzRTY0aTV3SnNYRW5Uc2tsSFY2?=
 =?utf-8?B?VXFic2NtZW5WSmZJMkpXUEl1dDZvSzVNNUQ0UTRTOWFzVlJUd3FFbUVId3A1?=
 =?utf-8?B?VG0xdnArSHZoRzBSZnJoOWd0a0M4NFh2MGdveldFb3ErazIrcTIwNkhtdUpM?=
 =?utf-8?B?S0c3SFowdlpoUmh2UGRMUS9wQTdZTXBKcUFQdlM0ckVyWFpuQkpQN1Zvc0E5?=
 =?utf-8?B?NTRuT3dMWnNWaGMrOE5DMTRiNnNzaXRyc1M0bjZJWUk2NC9CMWN3SFVMTlRm?=
 =?utf-8?B?Q2Y4dmhEdUE1dXB1ck9JQVF2WDl4MnNVS3RLZmw0VUpMdGgwUDl2VXBXUVcr?=
 =?utf-8?B?N1FCeFRsTkk4ZHdtSEZUNTc3UFIwUFVUbjIzMTVoRnlLTW9DNzVEK0hzb2tz?=
 =?utf-8?B?RzAybXkxZkpaOTk4RzdZM0FKRUZGSjE2a0tVZkRUcENvSmJDR0s1emc2cm9t?=
 =?utf-8?B?K0JBR2htelZqWC9Db08xYWJ3WnFYOTR1YUZpcHgvTHp0a2FwaHhvOGJ0S2JV?=
 =?utf-8?B?cmY5YVpqRjJ5QVkySWkrc3U2OVFzUHYyUWVxdUpTMjNLL3hUMHdOVzF1YjVv?=
 =?utf-8?B?UnFlUHdHaDFTbk8vQ0NQNHVxQ0U3N3NSTkNTTlRTcmNFbyt2SFBSanJjZDkz?=
 =?utf-8?B?OExVYUVvK0Y1a0RTTnU1MGpIdUkyQXl1ejI4VUo5V0l5NVZDWEhENU9GVDJH?=
 =?utf-8?B?OWVLL0Y0TmRON2VvSCt3NnFCNDdsaWJYUkxTeiticVFTWDVnUG5Da0NrTkRj?=
 =?utf-8?B?SjVTZ2lHNUMzVmt1RlE5RTN5RFIxNmhMZzhSOG5XLzdPaXI1QjJKbVhvUklY?=
 =?utf-8?B?ZzlSTy9XZVFEenZqR0FCakdvRlFBL3plMkMrb2pmVk4yOHV6amUxWDVicWpu?=
 =?utf-8?B?SHU2REtYTWN6K0VvL1A2b3lwU0V0MlVRZXZqLzJvVWNYbzY0bElJdTB4d0tu?=
 =?utf-8?B?R1loUjhZbW1LSWc3SldOVEJDajVLbjhVYmVXWnhWckh6V2RBQTkrZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5dbcf04-c14b-473e-df44-08de7a2cb605
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4557.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2026 20:29:18.5916 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tIVesaoD9WcnyWpTU1HewNl5Ypl62gJVVV4Bc/FQOFOGLBEw7UtBXkTufa4NruNmNuSHcmm0PiEIb3/GQwNJag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5777
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

On 3/4/26 2:27 PM, Alex Deucher wrote:
> Fixes: 39fc2bc4da00 ("drm/amdgpu: Protect GPU register accesses in
> powergated state in some paths")
> 
> Reviewed-by: Alex Deucher<alexander.deucher@amd.com>
Thanks, will add while committing.
