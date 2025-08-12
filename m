Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E0B3CA0EDB
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Aug 2025 20:03:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B30B210E63A;
	Tue, 12 Aug 2025 20:03:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PlU93D5a";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2076.outbound.protection.outlook.com [40.107.92.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A3A5710E63A
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Aug 2025 20:03:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pp5yoS1m+noQivmPg90+oVqmOA14cq/5dRy3uZGAGXD+KCjwi7w91XhmLjy1vMpJ0LNoBNcjYskHfI8Or8Ww4XHAs0c6UHYmNpGEwHEa6/uxInNFjbIIKpbfM1xNGOOUpSwMJBG6prgHolFtgxAAhpIK//PuDZU40dJk1ekBhgdc9P7X/hWZXzzFQjxdHWhB4K0jJLPzIS5LaxvNIWBemFgp3T4tefDRxTO/KawMez5GT3zfczO1Kwa37ovyH53mo97IbrYOnNxd60Yi4bTdLHgf7i/3G7s8SfYWu+YjdGf2IgAOnJHeuczuxwfybV0X/VjIw4Y4DxVdkAEs3vfXuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O1z7EJp41wHq5UWTbhQCwt1B+8CvzkiLAnHQ7HcCpyo=;
 b=VNq0cnMP0H/TR7l40RWPyOIsoLDG1HdmpA40Pv4XegVcryE+oB7mBAhSKrDv8BmdjTAZ5wlq7tU+96VWM54PGutASpOP0tLsNyT0iuIHUSE2PADiLIM4WX+lqx4N+q11mPu8UKIo+ZprXdJNL16Zax3e6lBckB1wxoLvhVQFsNTVWxcSmmNhz6kW0hZYx/JRjisl2xy/krP9lmYkkoDNvpoZPds/jfRKBhUtFITs2mC/Hs6FmOfuC86f3BCPmH77OURqaUU2SVehEiuVfvE+5Y4gbezbllUmBj6mh2uW/qk0Abmu5tOVyamrtI5sc7BgvOhxIbRMflyu6U4MORICqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O1z7EJp41wHq5UWTbhQCwt1B+8CvzkiLAnHQ7HcCpyo=;
 b=PlU93D5aH/zpp1ULFSeq31bhQybwQRp82iWm5B82JmuPdFVQ26OgF6wpbTZxzgaPxWwgORtJ3lIdX2l5at3mNyducl3Qx/xSK4oRG3JBM32DnmYuEVx6sUckx5HTOpxAJikMeshkruF1+/BA8BJl2l14mf0MHyhMpQQNbZeBOiE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6293.namprd12.prod.outlook.com (2603:10b6:208:3c2::22)
 by PH7PR12MB5830.namprd12.prod.outlook.com (2603:10b6:510:1d5::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.21; Tue, 12 Aug
 2025 20:03:31 +0000
Received: from MN0PR12MB6293.namprd12.prod.outlook.com
 ([fe80::49ac:e84e:ea32:d743]) by MN0PR12MB6293.namprd12.prod.outlook.com
 ([fe80::49ac:e84e:ea32:d743%4]) with mapi id 15.20.9009.018; Tue, 12 Aug 2025
 20:03:31 +0000
Message-ID: <b9397a7d-d02b-1f9e-69af-14c96ef5b7d6@amd.com>
Date: Wed, 13 Aug 2025 01:33:25 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH] drm/amdgpu/vcn: Fix video_profile switch race condition
Content-Language: en-US
To: Alex Deucher <alexdeucher@gmail.com>
Cc: amd-gfx@lists.freedesktop.org,
 Alexander Deucher <Alexander.Deucher@amd.com>, Leo Liu <Leo.Liu@amd.com>
References: <20250812145610.1300497-1-sathishkumar.sundararaju@amd.com>
 <CADnq5_P=kmQLOyjyGbOcW248TGO52nUNQo2xOK92rBRyPvAmmA@mail.gmail.com>
From: "Sundararaju, Sathishkumar" <sathishkumar.sundararaju@amd.com>
In-Reply-To: <CADnq5_P=kmQLOyjyGbOcW248TGO52nUNQo2xOK92rBRyPvAmmA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BMXPR01CA0076.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:54::16) To MN0PR12MB6293.namprd12.prod.outlook.com
 (2603:10b6:208:3c2::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6293:EE_|PH7PR12MB5830:EE_
X-MS-Office365-Filtering-Correlation-Id: 330da582-cf8b-45b8-3e37-08ddd9db4f1d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?d1hiaVNnMEFFWkFvcHpUaEJ1cU9uOFBJUGQ3dWcyM25tVU5LemxjM0dDVlJG?=
 =?utf-8?B?RnBhbWM1UmlsVDVrNTU1NEEzdHVmMFhRRnUrOEcwWmFxbVY4bU05M2ZlVy9H?=
 =?utf-8?B?dytnTnVKcVB2ZTJ4MU9NblFGMW1ZbXVrcWJKR0dIUzVKZmdRNnNxWGhlSGpw?=
 =?utf-8?B?STQrQXJwbVYzdDA0MkVMRDIzalNZZHZXWmFYZkpmZjdidVpVd1BPWFNVV1Nw?=
 =?utf-8?B?M3ljajdrWmV0VnB3Um82eGVmdzdsRmN0NVEvdENNdm1wNUlBaWpuQW8vTzVP?=
 =?utf-8?B?cFZ3U0dXRWtzUW4zWUpjdmUxNTNBd2dsdHViTmlkTGpYL09oVm1mUE9iMXdz?=
 =?utf-8?B?R01pU2kyVVBjd0pEay91NHZRTi80cDNJaVhJdXVBcWJIVVVjN253cTl2M0tI?=
 =?utf-8?B?WnZtNVh4Z3RnMDVJbk85emVpVDBuTk5FWFp6c1VWYzhVVmNjSDlPa2EwT2Y0?=
 =?utf-8?B?VWtPR3NRMUM0RWYrbDdSYW5mOTR2YWRQcjdpbDB0Q3N5cFJtYTMza1pLeWYw?=
 =?utf-8?B?c2ZTbVRCM0s1RHc3NGNJZHFzY3V4K25GbXY1dGt2WW5ZUTBIYWc3MGFqRFVT?=
 =?utf-8?B?YjBiVDBhNXk4NWQvbURPb2FGdi9iYk1oQVZCSHpnNVVieHJsOFBnRllma1cz?=
 =?utf-8?B?aGFvcW5sc3dwU0J4ZnROZCtCdnNhSFFadGV5SVliL29DK090bnFiaXI2clRQ?=
 =?utf-8?B?VFMxMXZkdCtOR0dmUlJJVkNNUDY2WVRuZmptOTdpNS9UM2luTDI1US9HVE1a?=
 =?utf-8?B?MHNjaDluRGxvYldXVkszRTRXYkp6ZUF3N0FYWkl5SFdNZGFzOEZMaTc5bUI1?=
 =?utf-8?B?TXU0UEkvNXYwRzVVU21xaFdvakw0YkVkWFVFZDB1UWVYREczdHNEb2JFbHE2?=
 =?utf-8?B?eWZKejdOcllQakcwQ0hBN3B1aGVRY2pUZ0J3elRma244Mks4R0FvVG15RWdt?=
 =?utf-8?B?ejh6Yk0yVnVtWkdwVDdZVXROSTFqVlo4anpMTzYwRDB1b2pTVDhQMmhNM05t?=
 =?utf-8?B?dEl4SndmNzJVcXNWUmhLbHNjZEw3bWFUbnZldGZaR1YwdmpOTGJWSHlQVGJ2?=
 =?utf-8?B?U2JOWEZ6UTMzYjRYbnNGVkh0OExCOXJSRVhaWGZ2S0RUTEtGMkFGcVhPYnF5?=
 =?utf-8?B?ZEU1YUVrZzUrbkFFZEdvUjdrajdxT2d3UWdXWUlUWURjMngvZlpJVEdIWXpz?=
 =?utf-8?B?VDVtOWZaelVmT3NLZk9BbW81dWxNWTRueVRZNEt4M253MEFLNi8vdkowZW1s?=
 =?utf-8?B?YmhmMWdxckF6QmJrTEYxZzZ4elFvdisrTTZaZjFkcUlPa3FTdUUrVkl1QzUv?=
 =?utf-8?B?VTJ3VU9zQno2alpBWjd3MEhKQVJWdGNIWmVOY2Z6QnFDcWg2K0ppWXFGb1l1?=
 =?utf-8?B?SThxcjVRV01GT2MrbnVhSWxjcktZZ1Y1TUh3TStEY25WTU8vbWNKc3lIYk1p?=
 =?utf-8?B?Ymd3R3ZzWVBvU0F6c1NXZW9pRzZuMzRubWdFZGZ6ZVJvbXZ2RTFwM3FaSGwv?=
 =?utf-8?B?QjdEYTFFMmc0Vk1jYnd6M2tlaFU3QkJ3UEFCRnpQWmoyd1Q5bHliYnVxVHNk?=
 =?utf-8?B?ZDI5YklzeWVac2dhZGtWQjRRVm44dDc4ZTJHM2ptSFJrdHVqeVd4R1Fqc3lD?=
 =?utf-8?B?Sk1SZjFFV2xhRzZaZGdzTFg3cE5rQlBVYnJCWkxCZFBRQUxWcFR5WlpkRHRP?=
 =?utf-8?B?MllocTIraXRwWWhqM2xWNXRSaTN6c1o5TE1OUE1zSDhWUERJWGxxWVMvais0?=
 =?utf-8?B?ZERnYVpGMnYvVm1nOFlsK0xka01iL2wxUUh5aUZpN0svMGM2cVZmdFU3amsw?=
 =?utf-8?B?ZllORC9BRndVVkthVG04RHVoZXV4VzQ4MVVqbHdUTjJ3ZU0xK2Y1cUh0cVJ3?=
 =?utf-8?B?eklTMDFPbEo4N2FtWDNjUGJSN2k4S3NFdk1UOU42QUpyLzl0aFBOOCtHaS9m?=
 =?utf-8?Q?kimgJW7Xqoc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6293.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aUpzazUwb1FBYU9oTTkyS3Zxc3IrWTk3QzdxVVZtcmdycUJNTmExN1lQZHlU?=
 =?utf-8?B?SWlSSzlCcDhEZmZ3aFlGS1MyU3ZENW5GSUpkSWVETW95enM4eENORFJ3OFE5?=
 =?utf-8?B?bzVhZU9jWlVORVg5bnMwTVcxSk8yandzcEVWOHh1UDE2QlgxYlBqUzh2dEdu?=
 =?utf-8?B?T0pXbTA1bEFvVkVsS01nc2NqWmZqUU1ONkZSdkVUdWhYemFWbktrTzlkTDQy?=
 =?utf-8?B?WEhkT3g2ZVRubWI2dk4xelc0NEtnSHJseTZ3aGdFSnFWWmNFeXgvb2t2MmRz?=
 =?utf-8?B?cElmTE1ybHduMGR5RXVCZzZ6M2JnYnJId0ljL0lxTDVIbi9yMGlwcUhPcVVV?=
 =?utf-8?B?OG55UjlBakp5OTlkTDRjZURCa0NYaUpna3NqRUlETVVSM2lmWVR3dlRnMlBD?=
 =?utf-8?B?aG1YOWdlWVEwU1VuM05MVWhwYkVmWnVQVnFscElQVXVsYVJ0elBnNjVqWEg3?=
 =?utf-8?B?dDlkaEltem5PelRnNDZMZVRaMkdZa0xQSW1McG9hRE1QOXgycVRLcjNWMGI1?=
 =?utf-8?B?TWdUd0Q4OGtxeFpLTHBWYkVYZDczelczUWFHMGw3UXBDSkdhemtZS3dyTDF1?=
 =?utf-8?B?WUxlNEFKU1dwVThnY1VkQ0ViYlNXVElkM01ZN1h2cExnaUlHQmdxcllGRWZ5?=
 =?utf-8?B?dFRubFFrQlB1QlBtb1VVSk55Ly9DTFVDS1NEdE9WUkx3SXl1RzdIWlphSmw0?=
 =?utf-8?B?TUR3WHV3aWkvMmVCZ3dIOVBIZkZBblo0QTVxT1dlNm1KbjZ0UGlkTWZPcW94?=
 =?utf-8?B?ZUFLWFRmbFJoVi9FdVNSUDRoVWhwWWVNQTVYS280cnRSTHhDbk5EV2xJNXdJ?=
 =?utf-8?B?RnluRmFHTnp1a2drVEl4bjdJdk1EN1hOQzZmOU9KVEpPMmx5YXNYMDUwVTFv?=
 =?utf-8?B?VjVoVk9ISW9zSVBWMm1VQTBjUWZsYkYxWGlDUUVqazU2aFNnK2c4aTk5Y2tL?=
 =?utf-8?B?SlVaRnhaUXZqcVFrVktNbDEvTVFJMVdqaGw5RG1kV0N4bzZSbjRTbnY3dVlJ?=
 =?utf-8?B?R3BSTmhaZm1jQVRVQ0V6NDNVTk90RG9SZjJGa2U5d0xQMGluY2pTTXgxcVpN?=
 =?utf-8?B?TnhUL2t1NVMzMjdQNFlyT2xFSjlRQWpZblFKQjFBRlFsV0VWNWFJV1JxN3J1?=
 =?utf-8?B?ejVoQWcrVnR6QjNxRG9zazBRNHJaTXNvOExldG1HSTZ2Tm9HcDl3OWlVTGp3?=
 =?utf-8?B?N1JRUTNaUExERFd3NEhVeHR0MHY5WEUxZ2lUU2pnNnVCczhjbEFvblhPQW10?=
 =?utf-8?B?VzlYWXJ2Zjk0QTMyR1pyYnZMYysxaHZUN203d0NXcEw4Y3Y0N01aOUFBWkZm?=
 =?utf-8?B?M2ZkSVpFendjV2ZxR2kvL0Z3SlZBVVVpNlJGaWVHL0lpWTBmNjJpOWtrZGhU?=
 =?utf-8?B?UUk3NXpoMjl1QmEyM0VaVDJsSmZ4OHp3cTNHNUZaNjVrWW1jQzdXRmNzeTBp?=
 =?utf-8?B?VGdSMnduL1lTTDBFRHVMMUVYQVplT1FtWmRmaDRmTUpBS2IvN0ZFUWR2Wmth?=
 =?utf-8?B?WS9ZaXBNRW5DMDF2TmFQR0NERGlhdHZMY1JOVE5zdjQxQTFLdUExT21sTEg5?=
 =?utf-8?B?ZGVieFMvRzNUYXJQZzNscDhFYkwzay9FR0d2ZE9HUm9UY3cwWGdEcGk0MzZ2?=
 =?utf-8?B?QURQdlprYUw4VWhzOW5DSXpvVE5rRTQ1QVRZbUplMmw3K1ZyOVpvWXpYMWdu?=
 =?utf-8?B?WXZvMkdKSHRyOHdBOGFwOUhvcEZNNkNINDU0QlVqeU9wZVdQVEN6b2U3dERN?=
 =?utf-8?B?RU1iQlBWU21HUXpoMEc4cEkwT0tQVlhQcmpKbHJrQWt6aENhWDQzbzhDNHdi?=
 =?utf-8?B?K1F4U2JJUHh6Uk5DWXR6eDBiQ1pqL2N1REZoN0QyZVU1dXBKY3RiWnRReExS?=
 =?utf-8?B?K0d0VlhCM3RpUmtWOXY4UWxsVmY1QURNTUpGanJuNkdQUUtRRExRZ1lHejFi?=
 =?utf-8?B?Qm5tTm1qZFRtRHdCZ0FIU0RhL3J0ejVPUFlCVXZVenRrYy9wdXRhWENhK0c3?=
 =?utf-8?B?a2F1b2dRWmFHa2dxeWwxL2F6RVBSTUcxTTRMR2VkSWZnN0VUcW9MMjluVWVo?=
 =?utf-8?B?a2Fxa29xcDBwT3R4UENzMG5JZHgyb01iUVhGY0llZWp5VHdQcW1tNnJqVUhN?=
 =?utf-8?Q?0Mgybc9EYW6V3knTIEEGlRfxO?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 330da582-cf8b-45b8-3e37-08ddd9db4f1d
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6293.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2025 20:03:30.8897 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zgqirvgIhdg7dOluaySwNeZvN9sYSt2Z4ygUiBgaNuRawwTSUcLYXk6ZMDBWddPK7t87g/zaqHDzP++k+cJAAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5830
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

Hi Alex,


On 8/12/2025 9:38 PM, Alex Deucher wrote:
> On Tue, Aug 12, 2025 at 10:56 AM Sathishkumar S
> <sathishkumar.sundararaju@amd.com> wrote:
>> There is a race condition which leads to dpm video power
>> profile switch (disable and enable) during active video
>> decode on multi-instance VCN hardware.
>>
>> This patch aims to fix/skip step 3 in the below sequence:
>>
>>   - inst_1       power_on
>>   - inst_0(idle) power_off
>>   - inst_0(idle) video_power_profile OFF (step 3)
>>   - inst_1       video_power_profile ON during next begin_use
>>
>> Add flags to track ON/OFF vcn instances and check if all
>> instances are off before disabling video power profile.
> I think you could also just look at the outstanding fences on the
> other instances.  Something like the attached patch.  Either way works
> for me.

Yes, checking other instance fences is simpler, your patch is :-

Reviewed-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>

Regards,
Sathish
>
> Alex
>
>> Protect workload_profile_active also within pg_lock and ON it
>> during first use and OFF it when last VCN instance is powered
>> OFF. VCN workload_profile_mutex can be removed after similar
>> clean up is done for vcn2_5.
>>
>> Signed-off-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 24 +++++++++---------------
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h |  4 ++++
>>   2 files changed, 13 insertions(+), 15 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
>> index 9a76e11d1c18..da372dd7b761 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
>> @@ -445,16 +445,16 @@ static void amdgpu_vcn_idle_work_handler(struct work_struct *work)
>>          if (!fences && !atomic_read(&vcn_inst->total_submission_cnt)) {
>>                  mutex_lock(&vcn_inst->vcn_pg_lock);
>>                  vcn_inst->set_pg_state(vcn_inst, AMD_PG_STATE_GATE);
>> -               mutex_unlock(&vcn_inst->vcn_pg_lock);
>> -               mutex_lock(&adev->vcn.workload_profile_mutex);
>> -               if (adev->vcn.workload_profile_active) {
>> +               adev->vcn.flags &= AMDGPU_VCN_FLAG_VINST_OFF(vcn_inst->inst);
>> +               if (adev->vcn.workload_profile_active &&
>> +                   !(adev->vcn.flags & AMDGPU_VCN_FLAG_VINST_MASK(adev->vcn.num_vcn_inst))) {
>>                          r = amdgpu_dpm_switch_power_profile(adev, PP_SMC_POWER_PROFILE_VIDEO,
>>                                                              false);
>>                          if (r)
>>                                  dev_warn(adev->dev, "(%d) failed to disable video power profile mode\n", r);
>>                          adev->vcn.workload_profile_active = false;
>>                  }
>> -               mutex_unlock(&adev->vcn.workload_profile_mutex);
>> +               mutex_unlock(&vcn_inst->vcn_pg_lock);
>>          } else {
>>                  schedule_delayed_work(&vcn_inst->idle_work, VCN_IDLE_TIMEOUT);
>>          }
>> @@ -470,14 +470,8 @@ void amdgpu_vcn_ring_begin_use(struct amdgpu_ring *ring)
>>
>>          cancel_delayed_work_sync(&vcn_inst->idle_work);
>>
>> -       /* We can safely return early here because we've cancelled the
>> -        * the delayed work so there is no one else to set it to false
>> -        * and we don't care if someone else sets it to true.
>> -        */
>> -       if (adev->vcn.workload_profile_active)
>> -               goto pg_lock;
>> +       mutex_lock(&vcn_inst->vcn_pg_lock);
>>
>> -       mutex_lock(&adev->vcn.workload_profile_mutex);
>>          if (!adev->vcn.workload_profile_active) {
>>                  r = amdgpu_dpm_switch_power_profile(adev, PP_SMC_POWER_PROFILE_VIDEO,
>>                                                      true);
>> @@ -485,11 +479,11 @@ void amdgpu_vcn_ring_begin_use(struct amdgpu_ring *ring)
>>                          dev_warn(adev->dev, "(%d) failed to switch to video power profile mode\n", r);
>>                  adev->vcn.workload_profile_active = true;
>>          }
>> -       mutex_unlock(&adev->vcn.workload_profile_mutex);
>>
>> -pg_lock:
>> -       mutex_lock(&vcn_inst->vcn_pg_lock);
>> -       vcn_inst->set_pg_state(vcn_inst, AMD_PG_STATE_UNGATE);
>> +       if (!(adev->vcn.flags & AMDGPU_VCN_FLAG_VINST_ON(vcn_inst->inst))) {
>> +               vcn_inst->set_pg_state(vcn_inst, AMD_PG_STATE_UNGATE);
>> +               adev->vcn.flags |= AMDGPU_VCN_FLAG_VINST_ON(vcn_inst->inst);
>> +       }
>>
>>          /* Only set DPG pause for VCN3 or below, VCN4 and above will be handled by FW */
>>          if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG &&
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
>> index b3fb1d0e43fc..a876a182ff88 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
>> @@ -366,6 +366,10 @@ struct amdgpu_vcn {
>>          struct mutex            workload_profile_mutex;
>>          u32 reg_count;
>>          const struct amdgpu_hwip_reg_entry *reg_list;
>> +#define AMDGPU_VCN_FLAG_VINST_MASK(n)  (BIT(n+1) - 1)
>> +#define AMDGPU_VCN_FLAG_VINST_ON(n)    (BIT(n))
>> +#define AMDGPU_VCN_FLAG_VINST_OFF(n)   (~BIT(n))
>> +       u32 flags;
>>   };
>>
>>   struct amdgpu_fw_shared_rb_ptrs_struct {
>> --
>> 2.48.1
>>
