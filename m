Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DD13D37482
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Oct 2024 12:23:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 853A810E7FE;
	Thu, 17 Oct 2024 12:23:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RIn2WqRj";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2047.outbound.protection.outlook.com [40.107.244.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EBF6E10E7FE
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Oct 2024 12:23:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U4PSq8QxFOH4RrO3xLJuz2+71vKxCZiEQpDoZzbbhhh+wtbqzrMWmVAJSbN762jJBJT30YO20dSL5rbHlWC+FGm0gN/GoQxLZKYGAqQr2IqE6I3VyX9EiehGpOu4M4h+MqX0m1+BS5c4kbU+V5lsmrEEIDuLhO00sI4vTlRo7MLOojuQuLCie8FZLkuwOppaeoB4NR3SLrtHsMNhtY2T8vgyr/3X45JkAWKQRovdHX18ccpqexF0TsMJ6q819H8z2LGhITStzsnUKlAmfTnAVlhYvf6YX4EEE2ZCTfXWmzvufT/q6jKtO/H8H1Nzu8o03cDFq3qo4SRjPGlCe78a5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GiS34nrS2SyrUE/r7HTLqMbAatuhY5SQ/VFZyxQRiQc=;
 b=O5ZCRAZvhZbXb9XtSSMNqcEzrqfcU/snhlveqgfIPGe6hG7Gpqo2d6YT9txfZxEj9dt6uoytAbHSy8BkBkxlvtSJWEC+GEqrGigrGUBxckNxOQM1KitBRXkMFSixHOQW2l+8q7uZhOWePXbg2NfSadhnDOEmf41ccrqPwWC4fHaO2ijYAp3VznxwNiW2QoFM5HBybPWng1I/cSzI02uJ4X9q8Wl/Rfm0hvFBQhNSwoMRGnKvdO2SDulxIbtwmWnbOq/cdXmm2nhRSPvcJrPoRKcnwuW0q8JrV/tOet8nPKhuxWdArP42vpGy6aliuBjEOXvwWUPZbjKJTc71wBacmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GiS34nrS2SyrUE/r7HTLqMbAatuhY5SQ/VFZyxQRiQc=;
 b=RIn2WqRjK3D1d5dDGwH7ZVHpjtn6lWoAwofsxkEGN+JhVIeA9MJPbUOu5uISe2aoqh1lGcZ6eYoQ+SQjgBPKLw8POS7WGWtVFgnwE9NcHfkH7pccYA8bgf9QrQKgr3PT3W/UcY27U85+z2TGP7rW9eheXSE0xHhyCLdngNXpbWg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by LV2PR12MB5798.namprd12.prod.outlook.com (2603:10b6:408:17a::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Thu, 17 Oct
 2024 12:23:06 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%2]) with mapi id 15.20.8069.020; Thu, 17 Oct 2024
 12:23:06 +0000
Message-ID: <f4aa8b1e-7ba9-4e10-bb71-71871c2cb920@amd.com>
Date: Thu, 17 Oct 2024 14:23:00 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 00/15] validate/clean the functions of ip funcs
To: Sunil Khatri <sunil.khatri@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20241017100615.1492144-1-sunil.khatri@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20241017100615.1492144-1-sunil.khatri@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0373.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f8::20) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|LV2PR12MB5798:EE_
X-MS-Office365-Filtering-Correlation-Id: 35cca217-7558-44b6-399b-08dceea6743a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aUE5UUQ1OVJSaUhjUWFsVUZodkI3UkIwUktVemlPb1c5bVpDS3pIeSt3c05n?=
 =?utf-8?B?N2I4Q3M3L1RlTmxsYklFeEgvOEh5OC9rZERKL0VJMEh3UEtFNHZHdWk3a3Iy?=
 =?utf-8?B?empJWmZkbC9DSk5YMDhCTWpKWFU3WlloZ2xxRDErTDhxRngvRnZSa0NwYlBl?=
 =?utf-8?B?TC85WGxiT01BYnFjOU5Gc2pQR2p3R1J1K1VOTnUwZDVJa1hVQWc5ODNveHFB?=
 =?utf-8?B?U0s2Tk5kYlF5bEExNjFZMmN2aHd2aktQRkJxbmQyY3NVZVBqUlJNZGc3eG1Q?=
 =?utf-8?B?TGpTRkMwbWxLdVNwYjB6Kzcwd1N0elBSK1hUMzNUZndCek5JZkVVNnN6eGwy?=
 =?utf-8?B?Nmo1NHpTT0FRYkNOQTZnS0JGQWpMM3JoeFlhUVNKZDBnb2E0SGRFY3YxdzRo?=
 =?utf-8?B?WFNzM1hpOTVEYlU0TE8vWXF3SzdOd3NqeDE1M1k0QURJWU5YMytNVWFzRElS?=
 =?utf-8?B?TWxUMERjWUdTTWtaVDI4RkUyQWVYZkFHcGh4UjhkbTNLNlBXS2NtR3pMNHhI?=
 =?utf-8?B?amZuclpxc0hBZ2xWeGxWQ3V0YWhjUElROGJqNytMS2VMeVk3SER3V1RuNm1Z?=
 =?utf-8?B?TlJ0YXAyeGNJTmRuaER2SkZvc25icXBtWWg2OFg5aWlkZEd0bVJmNkxlQTRL?=
 =?utf-8?B?bHJNbkxZYlNub3FNZlIxeUtVRFN5S1BBaENQWkVMZHVUdExpMTZwQS8wM0JB?=
 =?utf-8?B?WGdYc2VSb3B4R3RQelF3eDMvQzU3dG9aQXZXZUx3SGpaQXJZVTJUZ1RpKzRU?=
 =?utf-8?B?cjZ4RUNsMjRWRjE4cmhITkJ0Vko1YndCMnVsaW1pdlF2OUcrRksrUWpuNTlU?=
 =?utf-8?B?T1FWUkJnZ0dISVlzQ3o1V2JFbU1mMnU3bGlMeEFxMmpPZ0JlMGh2NHFHcHNy?=
 =?utf-8?B?ZUxrZFBZTVB0QXljdzVxV3didXR6R3ZWTzF0eWxpdWQzdjRLV3VPRGZCQnQr?=
 =?utf-8?B?SyttQ3ppZVdJT3FSUHNUWWN1STV5ZzM3ZEJUZUdoOE1RN3l1alNpTHRabHdO?=
 =?utf-8?B?Mm1seVJhZ3VXOGV5QTRodkNDdEo4eHpsOC8vTG9neVI3N3cvY0JNTm9MaDJr?=
 =?utf-8?B?anRLT1ZET2N1S3FzalZvSVpueUZGT3hYaktVZkhWTXp2MDRicHJEN0tRb0R0?=
 =?utf-8?B?dm9EN3RwczJoaDBYTW9vK0JYd0YzRXRjRlZ2Wlg0U3RLak5idzIzUVpROXQ0?=
 =?utf-8?B?eUN5RlhpeU4zQXFrL0lRS2hXNEYycGJ0SkRadFRqUVFLNjJGbmNzY2xyNnJ0?=
 =?utf-8?B?SmU3MWIraXpONWdMQkt6bUlha0ZyZStYekhSK2lvUGpxYlFoMWN3bHh2Q1BH?=
 =?utf-8?B?VFNBQkwxWkNHY3d1ZzhQNGo3WlFHYWtlK01VZU1XM2R1WGx3WXh5TEZ0Nm43?=
 =?utf-8?B?ZnhqdlBlRjFMaUY3My9UZmFLTFZWVkx6elV4bnhPNDNPZlNLd0JNODJrUE1G?=
 =?utf-8?B?dHpLeHhRTGExTS9MMTRaUEp4U3ZxdjdjUzROSjZmcjBXOGZPZEk4Q3czd2du?=
 =?utf-8?B?L0FzdjRZWndNbEp2Wi84TlZ0b05vNjVLbmJIOHNUNEFBYThlZzQ2TysySGx3?=
 =?utf-8?B?WE0yNlcwS2RlY05HN3Mwb2dvVC9obWNBUWU2TXBPTlNYbGtPZmdYZUVac3RT?=
 =?utf-8?B?VUtOYVVSS2gxbXZqVUlQY1VCNHFHNWhOWENxbFc0M3BMZWgrK0Nkb3E3TGU4?=
 =?utf-8?B?aHIrQzRsbEQ2ZzlMdW5zSHRNcndaUHM0MHpVS0dlTjZKeUxHRE42b0ZQMGNG?=
 =?utf-8?Q?Q0SUfiLLRne0zVSGx+MowmNr2YEByKDz8qTQiW1?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QVdnekl0b1dRa21OWFRjUkZiaHdBYjI4ZStiU1I4aEJGbEI5QTZodnpFRjQr?=
 =?utf-8?B?cm84azl6NTdLalV4NVpWZ0czQmNHMG5uUXRvNVpwSUNzaXZjTVVhbHg4S3l5?=
 =?utf-8?B?NXFJRytvVlFKN2twdXpTY2o4d2dOc0Z5WXo0MUV4ckR1bE9Kc3NzalhYNXZE?=
 =?utf-8?B?VWs2QWRFK3pqSU92ZnI3TnVDUkJVWTF5TTl1bG5JWVNsMCtWNTU5QmZUNUZn?=
 =?utf-8?B?blI3d2xRWXpqbkhITkNuTklJWlFEYnQ2RjlzTEpsT3J3UzFNL0NJMHNBUDRo?=
 =?utf-8?B?UmUxN2NKT1dDR1VWUmMrRTFSc2NvcmhJMUpFcWR3bjUwK3A0cTV5NDZZZ2dC?=
 =?utf-8?B?MjBzZmlhWFpxSU9vM1gxbjczdElTNkxRcU5ybzg1dzJGWGd6cjFSd200K3pU?=
 =?utf-8?B?Z1FtVmhRWW5FWkp0aDV6Y1NFQ3M2R2RFQUZWYlAyQUlzdm5OV2k4R29FM1lm?=
 =?utf-8?B?djgzem9BbExtejJERXhsZE9qWGZVcitYU3VSWDBtQjhHZkt2UWxwdlBsSmI4?=
 =?utf-8?B?dy9OVXI5VXlUSmc1bnZxR2gwa3BjeDVXUC94UVNnZ0VRZFJRWDNsdC93ZEtz?=
 =?utf-8?B?b243MUVRS09LdzJFYXVXZzhSc3hocmpRZXZnM2VXUW5HTEVRT2ZFQTU0Qitu?=
 =?utf-8?B?U0xWamxZN2xhZWpsaUFuaGRYVzF5VHpvNG1lZFFta3JKSXVRTWs5R2xnTzAw?=
 =?utf-8?B?VVRLeGs3aCtTTmsyb1V0MXNlQjE2RlRnYUp6MDQ3TVY4WkwyRm52MzVwZUJF?=
 =?utf-8?B?UlJCMWhtKzJWdXM5TXZ5ck5Vd0ZnNGZsd09YU3gvNzRveDF0VmtQMUh0a2Y3?=
 =?utf-8?B?QnM5aGNxcmxiNU5VL25Jc0pjaTJPRTJIRU0vNWl3TEgxV1JYbTRwQms5cFkz?=
 =?utf-8?B?aERjUmRYZGJ2dlB3VEwydm5md2xuRXpabmhmNWVuNjNqdnFpYkpGZFZsYkpn?=
 =?utf-8?B?VHh6ZGpsaDdkVFlON3Ntdko0Tk9tNWhnZzhRQUNCd1dGc2VlZ2JvUVVUT2NN?=
 =?utf-8?B?OS84amJRWjk3dW5LaEZUb0VTV2gwQTU5amphSjNXZGNsSDh6U01RM2tNb1Fh?=
 =?utf-8?B?MzV6c0E4YnlhMVcydDhzOXlhYmovbVJBQXlCUVZCcmQ4OU83Mjh3SGxwNnA5?=
 =?utf-8?B?WWs1dnU3WngvZHlyWTJQdlRVS3NaNElkQzdjQy90d0tLMkVWVm9Yd2o5SGFK?=
 =?utf-8?B?cnRsek9wVjd2UnZDUDAvNkJVWlRNWGtYTVIxUFdHTEk0TGpmSHUzTmtFQlBF?=
 =?utf-8?B?OG5rUitWRHZxdnRjRGRHTTBjNlZCcFZnTHg5QU5VSVc5WXNqa004aU96ejND?=
 =?utf-8?B?czhLNmsxN0xTZHpRa20rZXU5Q2hPZlJPeUhNV3ZPR3FMYldBUmtzVnpvSWN1?=
 =?utf-8?B?MktSTlU4aVBUdEhkSWMyWmlVU1BNdWJOOE5TN3kxMzVPQURrVkdoNDE4Njh3?=
 =?utf-8?B?RU1BR3AwZkFyOXNJTFNzOTR1RHNkZmkveU1JMGo5SmdhN2t2QlBhWnlsMDRu?=
 =?utf-8?B?ZjRXTUQ5NjNPcmxZUFBpc1Z1a1RkUkJ6cmlCNlZtaUNTT1RLYkllOU9yQ1lx?=
 =?utf-8?B?bllWUVV3eGhQd1ErRGEvdFVZOVpKbGMvM3ErUTBPZlAxTjZZeHlEeDlVNVF2?=
 =?utf-8?B?cnZmRGJoNmFpVlFQY2J2YnVJVzVTdHNtN25nVHhNUm9wUHN5S2ZuSE45OXlK?=
 =?utf-8?B?b2YxSjBJOWNocnBGTUtNWVZUOU16L1dFdDRmTWpuM0R3T3MrbUxDaEpzS3Uw?=
 =?utf-8?B?cEVORjZjajYzNmJoUEVIMDU3cHhiVmpyd1VKY3AyaE9JREN2VFFLQVZtVGE4?=
 =?utf-8?B?YmU0RkkwQ1hLV0VqOXNzcFFBM2Q1Nkxab29pRHFnN1ZHQVJOK1prZlRQV2ZV?=
 =?utf-8?B?bGQwY21PSHoxVnJPRXhlcXBvcHczTm9LYjZneFJZRzJjNXloUVd4YTlWK1VY?=
 =?utf-8?B?bVlHelY0OGRWNWlJdzZGSmNrekx0REI5SlhWYThUWHF3V1djQ3Nzd2l6MzJs?=
 =?utf-8?B?OFcyRkhGa3E4L2xaNVcyMmxabjN3ckRzQUllODBHSDNpa05mM2UzUytJTkdY?=
 =?utf-8?B?amRNcXhjNlphVG5uTksvMVNFRUk3ZUtqVU5MaXh5cXhENFpQSFFGVVNVd2xX?=
 =?utf-8?Q?C8HwJk7ntdYEAUTqJLRE6bnKr?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35cca217-7558-44b6-399b-08dceea6743a
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 12:23:06.3385 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fOhn2iAYV25LgvYPMi7+hndz5i9mT/KIT/ZbV9M/y0UthM6w8Qtczbty76UtQeev
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5798
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

Patches #1-#4, #8-#10,#13 are Reviewed-by: Christian König 
<christian.koenig@amd.com>

Since those patches should be independent maybe push them to 
amd-staging-drm-next before continuing working on the set.

Regards,
Christian.

Am 17.10.24 um 12:06 schrieb Sunil Khatri:
> v4: hw_init/hw_fini functions are mandatory and raise error message if
>      these functions are not defined.
>
> v3: Added 2 new patches to clean get_clocking_state and hw_init
>      validation.
>
> Sunil Khatri (15):
>    drm/amdgpu: validate sw_init before function call
>    drm/amdgpu: clean the dummy sw_init functions
>    drm/amdgpu: validate sw_fini before function call
>    drm/amdgpu: clean the dummy sw_fini functions
>    drm/amdgpu: validate hw_fini before function call
>    drm/amdgpu: validate suspend before function call
>    drm/amdgpu: validate resume before function call
>    drm/amdgpu: validate wait_for_idle before function call
>    drm/amdgpu: clean the dummy resume functions
>    drm/amdgpu: clean the dummy suspend functions
>    drm/amdgpu: clean the dummy hw_fini functions
>    drm/amdgpu: clean the dummy wait_for_idle functions
>    drm/amdgpu: clean the dummy soft_reset functions
>    drm/amdgpu: clean unused functions of amd_ip_funcs
>    drm/amdgpu: validate get_clockgating_state before use
>
>   drivers/gpu/drm/amd/amdgpu/aldebaran.c        |  38 ++-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c       |  16 -
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    | 138 +++++----
>   drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c       |  35 ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c       |   5 -
>   drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c     |  12 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c  |   2 -
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c      |  25 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c       |   2 -
>   drivers/gpu/drm/amd/amdgpu/cik.c              |  33 +-
>   drivers/gpu/drm/amd/amdgpu/cik_ih.c           |   3 -
>   drivers/gpu/drm/amd/amdgpu/cik_sdma.c         |   3 -
>   drivers/gpu/drm/amd/amdgpu/cz_ih.c            |   3 -
>   drivers/gpu/drm/amd/amdgpu/dce_v10_0.c        |   9 -
>   drivers/gpu/drm/amd/amdgpu/dce_v11_0.c        |   9 -
>   drivers/gpu/drm/amd/amdgpu/dce_v6_0.c         |   9 -
>   drivers/gpu/drm/amd/amdgpu/dce_v8_0.c         |   9 -
>   drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c         |   9 -
>   drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c         |   2 -
>   drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c         |   2 -
>   drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c        |   6 -
>   drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c        |   6 -
>   drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c        |   6 -
>   drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c         |   2 -
>   drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c         |   2 -
>   drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c         |   2 -
>   drivers/gpu/drm/amd/amdgpu/iceland_ih.c       |   3 -
>   drivers/gpu/drm/amd/amdgpu/ih_v6_0.c          |   3 -
>   drivers/gpu/drm/amd/amdgpu/ih_v6_1.c          |   3 -
>   drivers/gpu/drm/amd/amdgpu/ih_v7_0.c          |   3 -
>   drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c        |   7 -
>   drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c        |  14 -
>   drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c        |   7 -
>   drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c        |   7 -
>   drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c      |   7 -
>   drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c      |   7 -
>   drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c      |   7 -
>   drivers/gpu/drm/amd/amdgpu/mes_v11_0.c        |   2 -
>   drivers/gpu/drm/amd/amdgpu/mes_v12_0.c        |  11 +-
>   drivers/gpu/drm/amd/amdgpu/navi10_ih.c        |   3 -
>   drivers/gpu/drm/amd/amdgpu/nv.c               |  29 +-
>   drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c        |   3 -
>   drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c        |   3 -
>   drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c        |   1 -
>   drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c        |   1 -
>   drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c        |   1 -
>   drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c        |   1 -
>   drivers/gpu/drm/amd/amdgpu/si.c               |  40 ---
>   drivers/gpu/drm/amd/amdgpu/si_dma.c           |   3 -
>   drivers/gpu/drm/amd/amdgpu/si_ih.c            |   3 -
>   drivers/gpu/drm/amd/amdgpu/sienna_cichlid.c   |  43 +--
>   drivers/gpu/drm/amd/amdgpu/smu_v13_0_10.c     |  29 +-
>   drivers/gpu/drm/amd/amdgpu/soc15.c            |  14 -
>   drivers/gpu/drm/amd/amdgpu/soc21.c            |  26 +-
>   drivers/gpu/drm/amd/amdgpu/soc24.c            |  24 +-
>   drivers/gpu/drm/amd/amdgpu/tonga_ih.c         |   3 -
>   drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c         |   3 -
>   drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c         |   3 -
>   drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c         |   3 -
>   drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c         |   3 -
>   drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c         | 284 ------------------
>   drivers/gpu/drm/amd/amdgpu/vce_v2_0.c         |   3 -
>   drivers/gpu/drm/amd/amdgpu/vce_v3_0.c         |   3 -
>   drivers/gpu/drm/amd/amdgpu/vce_v4_0.c         | 275 -----------------
>   drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c         |   1 -
>   drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c         |   5 -
>   drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c         |  10 -
>   drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c         |   5 -
>   drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c         |   5 -
>   drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c       |   5 -
>   drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c       |   5 -
>   drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c       |   5 -
>   drivers/gpu/drm/amd/amdgpu/vega10_ih.c        |   1 -
>   drivers/gpu/drm/amd/amdgpu/vega20_ih.c        |   1 -
>   drivers/gpu/drm/amd/amdgpu/vi.c               |  20 --
>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |   2 -
>   drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c    |  15 -
>   drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c    |   8 -
>   .../gpu/drm/amd/pm/powerplay/amd_powerplay.c  |  14 -
>   drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     |   4 -
>   80 files changed, 171 insertions(+), 1208 deletions(-)
>

