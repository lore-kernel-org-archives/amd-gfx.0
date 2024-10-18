Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC724D2FFEC
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Oct 2024 11:19:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5760410E101;
	Fri, 18 Oct 2024 11:19:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Sl/rtQeX";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2073.outbound.protection.outlook.com [40.107.96.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D8DB410E101
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Oct 2024 11:19:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w7sMEMmqJV4PUgdquWnmz4mHpwguYXWRTgdML9lQYPA6NNYc6h2Yv9kVXQxV5AxePHSs6taDiwFTu7GRbUUcDx04aagrUwQMtmB71tU98XVEb/7jTto2uEBxhupDileAy5ptyhtXRCO3RbsHb/kMOjl0KgCSjqbEZEZvVp6hwbhF4VH3Rj/15LczzO58j7+x5Ks/N6YgLiiQ37gok5fIvHyQRK2yHZVz6Wu/2jtgp/HU//vdVrWU61xVtJrFd2ptWpF80jO1dhZ+PohfuExWMrncjkHHpnm4yHao55RxXYPmerIlqfJ0xCE1QWE7f69Bed7SfvuHV+/s2R2LUAt76A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=buWMZD0ha6apfanaUAPdz00Hsbx8Y6en+Wx0v/SVzVU=;
 b=DdsTdeA8TnHaMaXEFV99+ZL8wGVKgs5ha+NUSfw0KOzl0ez2fDRHUTO8vwWHd9EXVLYEgIFWgwrYeIpZgt3hGEWlMmkbva80mL0Zza4HxpeNXJgKtpEJCS7aQHMjw3Ugz/wnQI4aQFPBacvH28lMqH4KWnPUIoArAtvCvFasINMUHAQzBPVQ/HrqHs60G/CnilBxAUrbPuebgD6VQX79b512yeVJZGo64Xc0es0Uek2G5tG4SE99VrDTTnvCOc8AVkPJEM7wvrKCTUAfJ2Ejem7Xiz29N8YuMI1L16zLY+UODvYuZMzWGiG2tMS1LeB76wJVInEA6fLada4H13WNwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=buWMZD0ha6apfanaUAPdz00Hsbx8Y6en+Wx0v/SVzVU=;
 b=Sl/rtQeXfE74Rc6H6qqHImCG/dEFG8mL2M/TKuvM0I7R1+DW63zACWgerWtr3qurV54sjQUW0EhVEmqpJ+ekAdlDmqL3AdkYI6KGoIfg149J5e478w5FCS3QSv8vWNwSeh3Jfck68+sDywS1GMt0kfGUJk2oHhQVxERHofEwXps=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH7PR12MB6000.namprd12.prod.outlook.com (2603:10b6:510:1dc::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.20; Fri, 18 Oct
 2024 11:19:35 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%2]) with mapi id 15.20.8069.020; Fri, 18 Oct 2024
 11:19:35 +0000
Message-ID: <fc91c475-1c9c-4835-a203-86f0cec6198c@amd.com>
Date: Fri, 18 Oct 2024 13:19:30 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: add the command AMDGPU_INFO_QUEUE_RESET to
 query queue reset
To: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
References: <20241018081934.2185681-1-jesse.zhang@amd.com>
 <5963f22c-eba6-4c9a-a341-a5a1b6d45f37@amd.com>
 <DM4PR12MB51521F1CA0607071EE23EDC8E3402@DM4PR12MB5152.namprd12.prod.outlook.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <DM4PR12MB51521F1CA0607071EE23EDC8E3402@DM4PR12MB5152.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0044.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:48::7) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH7PR12MB6000:EE_
X-MS-Office365-Filtering-Correlation-Id: db56da98-1d31-4fa8-9bdb-08dcef66bf09
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aldRa2lvUzUxUUpHbTNzc3E3MS93VWpqdXp2bGVLYUFTUWNLcHJKOFJpOGZI?=
 =?utf-8?B?c29vaHZEcEIvcURIc0FXOXRoTERyZDFXa0xoa0JTaHZrYkQ0UVc4azU4YmNI?=
 =?utf-8?B?ZHZLYUJYNFV5VkZoK1pOR2VDMXkwSCtwVE01VzNHZjZzZHl3aWptb3I5OVo4?=
 =?utf-8?B?dEJwRjA4cmpFTFJ6Rjg4UE5hQXFGZXlVdFFIcXVNMGdTRTB0OGVhTjVEK3B4?=
 =?utf-8?B?dG50R2JUaHc5cGJPWkY5aDR5dEFGMENjRFZnR0dta1gyRHZFVUw1czF1bGlv?=
 =?utf-8?B?eDhLRmZ6Zmp0WURIR0x1VzVGUFptOEYxNTh2YjEvcHdsRGxZQ3JkMEs5NGM2?=
 =?utf-8?B?azlCc1dGdm5xcHF5QzRXME9LWVJ1cS9OVXlZem9oaHAxdjR2YjZHQjhkZmJm?=
 =?utf-8?B?U1lobEs3SmlTZWNvNGdhZEdNSEl4cHBDdVk2QzdjTCtEaldBZ0pZQzM4anB2?=
 =?utf-8?B?b3NJMks3ME9VeW52VjVBVVNMY0JkekxwMU5TZEE2R2RmSHczNFd6eDg5ZmxV?=
 =?utf-8?B?UzczZ0pSNjBTSmlrRThkTDBFUmJYa1Z1cUh4STNjVVdZQjF4cU5XL3ZWL1JB?=
 =?utf-8?B?NjBWNFNFTHJubVNZbmhyM3E5bEJ0dlhjYzFoaGxFQWF5TVNpbVVldXp0WkNx?=
 =?utf-8?B?UFlpWXkzQ2k5YWxDV2kyK1JXNEhaSlNkbWtyTFE2VGhWQWpYREtOWUdFRjZF?=
 =?utf-8?B?UDJDN29tbi9ZZWRGUU8wcFFwQmtRRTMvbmo3cWZ0Vis1TmJ4ZjNObXRYK1NV?=
 =?utf-8?B?MWE2dzY0bFM1SjgwZXZjNUFIdFB6VmpIU01memoyaWg2QklZTWs0b3RlaGhh?=
 =?utf-8?B?RDhSL2dvUFR5T0hCWXhseEtET1FRd2ZleHhHQmkyb2ZwbXRuRkc2SGVPbGdu?=
 =?utf-8?B?NXdkMUFKVHZQQTQ3MjlPSzhISEhEZXVYaGxmejV2Q092b3o4Mit3Mjg1Y3hJ?=
 =?utf-8?B?TlpMSldMU0tKUFg0MUszN0N5a1Jtc2xQT2lWWlJGeTh4ZDRnQTZ6cVBkZzJI?=
 =?utf-8?B?Q3QvaklNWFdTOEwvK2FodTVDc05KM2YyNDBaQlViTDhMSEdIaTlkZjhENk5M?=
 =?utf-8?B?U295ZEJpbmtWVWhpWi9LWCtBbW4xTW1IeFdYZDJlMmNNTDhWRlFVL00ydXBa?=
 =?utf-8?B?ZEd3MVBVRXVRK2xzcE9NMTlzTytEcXNsZytJaWtYeDN5MVJXQ1QvWlpZWHI0?=
 =?utf-8?B?QVdyeVMvUnJVRmJzdTBTVFNTakRLcDNteE83NDFiblVSY0pyY2RBU3h1OEJt?=
 =?utf-8?B?SXczRkpMMmV0b0F6VE5HeElyNEJ2MDNqZ2haQjdZNmxCWTljT0FhVXowYUVW?=
 =?utf-8?B?MTZMeE9lSVFqeXVMOXhEcGQyamowZjg1MUhpTE5BVXFFeDE4bFVtL3JEM1Vz?=
 =?utf-8?B?ZDI5MGI0ckl2RDQ1QkcvUVFmZlhJaVNaSGJvS3UwcmJXeURNLzdJVTdiRGwz?=
 =?utf-8?B?eVQ4dlk1MmwrSFRCMEh1Y2x5U2lGRlZwYk1mTVM0NVg2T01aK3RISFlGNDQ3?=
 =?utf-8?B?dUo1RHJIcHNSejFpMHVoUWwvOVVxTEc4Q3hYS2ovcmFPTlA1U28rMmY4Z1Np?=
 =?utf-8?B?d2Q1WlNUaHNKOURLMFhKeVJUSk1rKzA4TEsrUDBmZkJOdFNNaERscC9MSHFu?=
 =?utf-8?B?T21EYVZ1VXdvUUtPODVZSFhtMlhLTnhRaEJpNmpncTlLaDRGZGdWM0VMbHkr?=
 =?utf-8?B?cVE1eiszbk5lcWlMNmF5NzFXczZIQkVYaWFDRW9nRk81VVMrYktCbk1TV3hO?=
 =?utf-8?Q?NQDK2QLNwUSV+isWNzdtEhB1LauaLcyb5aJ3qTt?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VDZxblNSRklGQ2JRaTR6RlFzMjhpNzJpNXhUM1FwMmZoVUJFRGpGenNqK1Mx?=
 =?utf-8?B?QmI5aUtRYWc0ejR4L3VDWUpaVGp3MWtZcGRuMlNldWJDWGppQXZIeE5BU2dE?=
 =?utf-8?B?T3pCVS95MTQrc0Y1ZzFwZ3VvSFB5UlVuVEM0UXpuVSt1dW9EL0JuMTU5ejZ5?=
 =?utf-8?B?R0haRWdPaGF2NXVqOE4rMkxWaWpRZ01KditLNW9KREhha0ZRZU9EQURDMk5i?=
 =?utf-8?B?c3owQStKeFltUnA2NVAyZi9iVVZSQTRiRkR4WnhOd1F4ZW0rMkFZbGpRZkFR?=
 =?utf-8?B?MzBnRnBDeVlBOW1IdmtFMDNnMzdOQ2hFNHpzYmR3dzdJWEVWTTBmVXM4Zzdu?=
 =?utf-8?B?VnNVVUhvdGx4UTl1czhEY1pneTEwN3dzWkk3Q1lrSGE1NGlyeXFTZEl2MUNj?=
 =?utf-8?B?L0taSGh3UHNlYW11dmhBQ3F4aUZOZW03N1pxb3AvcHkzMkVSK2IyckZma0Vo?=
 =?utf-8?B?bWZxSi91eEozdzdzVWx5NHFCUHBZQk9qWG5IQWd2MFJRUW9xUm0rZjNUM2Zo?=
 =?utf-8?B?UHdRVm5KQjZUZ1FIOERtUEpsRk43NG1mODFRckJzTnVURjg1M3V4V0JWSnZL?=
 =?utf-8?B?RHN3ZDlXR0xyZFIyQll5dk5PMTFXdUlmSStMVTFmcDIvMUlURGM3YmErQ0Y3?=
 =?utf-8?B?b0RUOHJvMml2RFJURXErc3R4UlE2a1M4MFY4VHZSTEhUUmlEbHo1S0UrN0ti?=
 =?utf-8?B?ZG5ZZU84U3dSdERSakdpSUtPV1lNNjVuaGE1d3V0alpoRlFsNnZGb2VDbTJ2?=
 =?utf-8?B?bDBDeDRDRldnZjdKbW9hUTREL0VpMm0vWm5KaUxINHFBald3SzF6Skh2NTd5?=
 =?utf-8?B?b3Jacm10VURXKzJlSElnYzBCRjN2RE01YVNSM0s0c0JBejdwdE1oSDQ4UTc2?=
 =?utf-8?B?K1hoV3dtQXNMMGwyZFdHek5Tek1GbEpSTnQrNVFhTkNWd1grcHVHZ0R0bFNu?=
 =?utf-8?B?SStuWitYNFdhd1o3WURRVHhkM1FsbG1LS3NnQ3EycDl3OXlGemMzak1DVFdx?=
 =?utf-8?B?bFlTSmt2dmt1SWNla2lPdGVTd1I0dGFwOVRkeE9PMGNoYkJKYXBLdzVoTlJ4?=
 =?utf-8?B?clA3UnNBTzdhQlR5MHFJSEtCc1JDdFV3MzBiUmMyRXQ2ZlRCb2lIZ09Iekg5?=
 =?utf-8?B?K3BRaFU0cllCYmtCZkMvSXJHbmx2L0kvb3B1T3NQL0ZFdmdDdjVoSjVlL3p0?=
 =?utf-8?B?aUUzeGV6MysrbWhaYUhpVnpQQUF1S2J1OU93N3E1bHdITlpDZEoyKzQ3TVJy?=
 =?utf-8?B?V1JLNC9NSW9QNW1vZGlFK0tBSWM2OEVmVW9US0NZS09VcHhCVXBod0pSSUgz?=
 =?utf-8?B?eHA3S0FnSVA0TTQzTVdyK2VpTks2WDcxaDJIV1JlSWZlSTFwRlgzTjhuSXUx?=
 =?utf-8?B?b0JwSU5mOHExWlNHM25YejNpQlBSTlVYamR2dVVjbFMxWU9HQ0xZYTI1RnlR?=
 =?utf-8?B?UFJvREtwaFNvcXZFUm5aT3RreTY3bVhLWEZ2QmY4S0VCTjVTOC9UdUhFamF2?=
 =?utf-8?B?eklkMFQ5SFdZSm1XQUdKNGVNN0JUVmNUT0RveUE1ZXcwMEM1Qm0yOExmZGp2?=
 =?utf-8?B?SG9TUnVYenJiWnhPbjV5Wk9aQjVUWUc1SmVUNXRLb0Z6c3d4N3RSMWVnZ0RB?=
 =?utf-8?B?MWR4U0lJNUhYd2ZIZzVoSmxLQ1pibllKekJUclp1VFJLSlUwbVNjOUVaS29F?=
 =?utf-8?B?MlMwMEthbGMwL2owb3F0T0RCU2RhbVl0TG1RaGFQR0x5SUxEVzBrMnIvY08y?=
 =?utf-8?B?bi9VbWI3OGNoMGlOc3c1S1RDOGN0L1QvbStSYTJ4WkQzVzVYWmkrMWd1NmIr?=
 =?utf-8?B?OHhaUGxmc25EczVTeW12eG1ZcHp5ak05cmp0WUtxRHdJQ0JHb3Nid0RGZDRU?=
 =?utf-8?B?QTFLcDh6RjBSTDI0cEdmYXVnMkkwbXpTdkorK3BHZG1VY3dIOURnVE1jU0c0?=
 =?utf-8?B?MTdIcFVxWUdlUnFqVFhFeGtSUm00RndvZ1pLcFVxRkd5TTczZGFvWklPVUNv?=
 =?utf-8?B?Z0ozWGZBWHFQVE5jbXVUNkcrdFhWcnk3UkFQQ1VYSmZiUy9zUlFiMGZwZWRR?=
 =?utf-8?B?dnhiUDFkSm8xZEhqbUtsMVZmbmhqN1lGbTg4cXU0T1l5OWJtSDY1aHpyNE1r?=
 =?utf-8?Q?QeX7Majk/TXKMeNREdTksYuBe?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db56da98-1d31-4fa8-9bdb-08dcef66bf09
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2024 11:19:35.3120 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NYSS0OtnhAIA4vQBJ9e4Kn6FEAqP0RmOXvvma7I46SJyBUOz1rdexr9ehClLXezy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6000
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

Am 18.10.24 um 11:33 schrieb Zhang, Jesse(Jie):
> [AMD Official Use Only - AMD Internal Distribution Only]
>
> Hi Christian,
>
> -----Original Message-----
> From: Koenig, Christian <Christian.Koenig@amd.com>
> Sent: Friday, October 18, 2024 4:47 PM
> To: Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
> Subject: Re: [PATCH] drm/amdgpu: add the command AMDGPU_INFO_QUEUE_RESET to query queue reset
>
> Am 18.10.24 um 10:19 schrieb Jesse.zhang@amd.com:
>> Not all ASICs support the queue reset feature.
>> Therefore, userspace can query this feature via
>> AMDGPU_INFO_QUEUE_RESET before validating a queue reset.
> Why would UMDs need that information?
>
> To verify queue reset.
> Now the igt uses many asic filters to hard code if queue reset is ready.
> Alex suggested that we can get the information directly from the driver.

Ah, ok got it. Mhm in general sounds like the approach is cleaner, but 
the IOCTL interface is supposed to be used by the UMD and tested by the 
IGT tests.

The problem is now that it's documented that the justification for 
having the IOCTLs is the UMD and not the IGT tests.

Could we also do this as debugfs interface?

> Another problem is that our driver has added code about queue reset.
> The reset function is complete (adev->gfx.gfx_ring[0].funcs->reset),
> but fw partially supports it.
> For example navi31,   KCQ invalid opcode case can be recovered by queue reset,
> but KCQ invalid packet length cannot be recovered now.
>
> So for this case, I am not sure whether we can return true for this function.
>
> More information can be obtained from the link:
> https://confluence.amd.com/display/AMDGPU/Phase+1+-+Validation+of+Per+Queue+Reset+for+Kernel+Queue

Oh, yeah good question. Alex should probably answer that.

Regards,
Christian.

>
> Thanks
> Jesse
>> Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
>> ---
>>    drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 27 +++++++++++++++++++++++++
>>    include/uapi/drm/amdgpu_drm.h           |  2 ++
>>    2 files changed, 29 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>> index b53c35992152..87dee858fb4c 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>> @@ -577,6 +577,7 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
>>        uint64_t ui64 = 0;
>>        int i, found, ret;
>>        int ui32_size = sizeof(ui32);
>> +     bool queue_reset;
>>
>>        if (!info->return_size || !info->return_pointer)
>>                return -EINVAL;
>> @@ -1282,6 +1283,32 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
>>                return copy_to_user(out, &gpuvm_fault,
>>                                    min((size_t)size, sizeof(gpuvm_fault))) ? -EFAULT : 0;
>>        }
>> +     case AMDGPU_INFO_QUEUE_RESET: {
>> +             fpriv = (struct amdgpu_fpriv *)filp->driver_priv;
>> +             type = amdgpu_ip_get_block_type(adev, info->query_hw_ip.type);
>> +             ip_block = amdgpu_device_ip_get_ip_block(adev, type);
>> +
>> +             if (!ip_block || !ip_block->status.valid)
>> +                     return -EINVAL;
>> +
>> +             switch (info->query_hw_ip.type) {
>> +             case AMDGPU_HW_IP_GFX:
>> +                     queue_reset = adev->gfx.gfx_ring[0].funcs->reset ? true : false;
> Please never ever use this coding style.
>
> If you want to convert anything into a boolean use the !! operator.
>
> Regards,
> Christian.
>
>> +                     break;
>> +             case AMDGPU_HW_IP_COMPUTE:
>> +                     queue_reset = adev->gfx.compute_ring[0].funcs->reset ? true : false;
>> +                     break;
>> +             case AMDGPU_HW_IP_DMA:
>> +                     queue_reset = adev->sdma.instance[0].ring.funcs->reset ? true : false;
>> +                     break;
>> +             case AMDGPU_HW_IP_UVD_ENC:
>> +             case AMDGPU_HW_IP_VCN_DEC:
>> +             default:
>> +                     queue_reset = false;
>> +             }
>> +
>> +             return copy_to_user(out, &queue_reset, min(size, 4u)) ? -EFAULT : 0;
>> +     }
>>        default:
>>                DRM_DEBUG_KMS("Invalid request %d\n", info->query);
>>                return -EINVAL;
>> diff --git a/include/uapi/drm/amdgpu_drm.h
>> b/include/uapi/drm/amdgpu_drm.h index d9bff1c3b326..3b17d82fd1ee
>> 100644
>> --- a/include/uapi/drm/amdgpu_drm.h
>> +++ b/include/uapi/drm/amdgpu_drm.h
>> @@ -1052,6 +1052,8 @@ struct drm_amdgpu_cs_chunk_cp_gfx_shadow {
>>    #define AMDGPU_INFO_MAX_IBS                 0x22
>>    /* query last page fault info */
>>    #define AMDGPU_INFO_GPUVM_FAULT                     0x23
>> +/* query queue reset */
>> +#define AMDGPU_INFO_QUEUE_RESET                      0x24
>>
>>    #define AMDGPU_INFO_MMR_SE_INDEX_SHIFT      0
>>    #define AMDGPU_INFO_MMR_SE_INDEX_MASK       0xff

