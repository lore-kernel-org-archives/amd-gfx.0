Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8493FCCF9E9
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Oct 2025 11:41:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 20BF189954;
	Wed, 29 Oct 2025 11:41:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kqlCqWsL";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010057.outbound.protection.outlook.com [52.101.46.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 076B110E7A3
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Oct 2025 11:41:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zWv/bIrJRLAU6o/YULOoIXrtLf92ARWNCERkef1ZMoBvErQpTdzO3NefKoAirLs+jP7nkrdUis5ZAJk+uy3I01effiOvxSe9M1NJ8/wx2QYASwCeCe0O8JgMgWbxGnlMH5YmVCETE8ZkYXIA9K3R8ne3dILIACkAfG+bN2k5cHJgYM+zb+Yeooh/ojIqU5G9obaCiQWInq5nCXHcEXzK4JSKyhrrGmtJK42ui1XvRAa8MT+VuTY5es1TePGJDtJGVsZjQDnU+TOMUi/UMTwoG86tJusDKOeZCgp/p8vTq/opNp1l+8bExRQCjsy7/qX1vzxa8SC7L7jhUWyeUddrUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FVKyS80GePxfFdjkHzINE0M9GZ8dQ+kTpTEF3NtJ9BQ=;
 b=J6tC1VytXenYmy7EbstUEJz1zYFzKhTQQbYbWWf9wui04j95Smj5U2LHzA2dzhqPpff+7uPEqaruHAQFIucqfMjNiu7PnEuujgo1TIQMtEWGxa7uFszPsnPXFvpR7VHwb3jkD/QzB2uUYKTYppmzIZSlmme2n+n15aX8tgNQKORh6xv10mnwBYfBDGMoILr94UgrucQLzlDIvqgQFKN20eLHvopmarH06rqFAaciVn19EyX9ZzzjDMCuG8YgUkxF9QRhGu8ihjU36CdDXclMusa5hYJ9KDX0z9S7Q4605zpC18DNO2Y/X+AifQvhAjeMQbs0t9CbFNGNTpGYKUpgVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FVKyS80GePxfFdjkHzINE0M9GZ8dQ+kTpTEF3NtJ9BQ=;
 b=kqlCqWsLyepqB0BFlRcXOCR8Fm5u33o8DHh/exw97Iu+lhD3e5Ll3gSOzkfXbaWXzUlt15Ny/0s42EKT+FJFl1T38eAUWjkGzf5HBtFIxYH/1TstPQwAnCEWE9Fxs3W1K9za2fILAHMdu+B/uiGG7PsEviwIgjfQdH4kyZqzNvw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SJ1PR12MB6145.namprd12.prod.outlook.com (2603:10b6:a03:45c::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Wed, 29 Oct
 2025 11:41:11 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.9275.013; Wed, 29 Oct 2025
 11:41:11 +0000
Message-ID: <8d716ca2-43d3-4c69-8d6a-e270c357c44d@amd.com>
Date: Wed, 29 Oct 2025 12:41:07 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/14] drm/amdgpu/vce1: Ensure VCPU BO is in lower 32-bit
 address space
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 Alexandre Demers <alexandre.f.demers@gmail.com>,
 Rodrigo Siqueira <siqueira@igalia.com>
References: <20251028220628.8371-1-timur.kristof@gmail.com>
 <20251028220628.8371-12-timur.kristof@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20251028220628.8371-12-timur.kristof@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0063.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:93::19) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SJ1PR12MB6145:EE_
X-MS-Office365-Filtering-Correlation-Id: fd0458a5-aa6a-41f8-affb-08de16e00f33
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dkNHYzM1RW9qV3dqVDd3NnpveERoOExva1VlZGcwRjFacGFaSE9kRjBBUzdk?=
 =?utf-8?B?cXdBL3Q1NnJSaHkreGlqdzZsYlQxMUVpNUkyOUhhb0p1UFRPTjlmZmJGcEtw?=
 =?utf-8?B?VXRXRWhZS1kxcEJheFdZbUJBMERWemc5ZTFHZkVBTXZKeFU5cUdSaHRDUHo2?=
 =?utf-8?B?VzE3RUNpNDljOTZQUmtuVWVHSzkvLzBPU0tXbUlPQVd6YzB5VmhZSnNvaFlz?=
 =?utf-8?B?TGpJWHhPSXpnczJVcGxUeVNiKzdxaVZIaHB1YW4wNmg4M3lzY1FOSUNxVi83?=
 =?utf-8?B?Z0NiREZvY2lhbHB6LzczbTdEOHZrdFNwa3NWQ2RvU2pQVXJueDcxODJ5VERJ?=
 =?utf-8?B?WWJkUXlKUHliQXhpQXo5Y3lReFZ3NUFEWkwrUVVLdDV5YTRCdXh2cnZ2dXo1?=
 =?utf-8?B?a2s0TmNWWjhLYzR3Y3YrWDJqd3JPaGpsdG1GYzhyODNsYzdXOFdzTXNtVGo1?=
 =?utf-8?B?dWRvbGdIbzJOQVd5ellXVi9GS3lxNTBFNUkyRElMb3dURDRadEFHaWNaY3pE?=
 =?utf-8?B?ekxWN2d0d0VETm5FMndiejF1cEtjVmJOdmJLQWMySURTa2VONHRWdHJRUTg2?=
 =?utf-8?B?STd6THVObVpWaTFKb0JobE1nNXB4ODZQbzc0TjcyMmh3eldmei92TkJqTm4z?=
 =?utf-8?B?aG5UTlVwWkdqSWdWdlFIWC9xdEpFdDJTNzlMc0d3U3JleVBrTmdraURlVExU?=
 =?utf-8?B?enNzSTNFc3BEd0Z5eFpHb3YvWnNrcjA4dkl6dHNNUExiaGpxRzlhTVBzMVho?=
 =?utf-8?B?T0JFZ1BheERkSEc5RkxLZm9LT2FuWFVPb2txRDFrUzN6eUJKekErdEhXVnRB?=
 =?utf-8?B?WTZFcUdsSEtzSHNmMDhMQ0IyK3B6aW9mYW1vUHpBMVp5bEV2dEdvUElROFBx?=
 =?utf-8?B?ZDdyQzZvalNkSm5peWtISWtyZjVIN0VERTdYMlc5QWJzWW9QdkQzNFd3enNh?=
 =?utf-8?B?Y2Z2UDVXNktheTJlZGhNbTJYTjRVL2lIOW1WVTdBeFpaSlJIUFlGZDFwUXpD?=
 =?utf-8?B?NUdYM3BpQUI5SnZCYmNmb3E0OVdZd1ZYN0FJTC8xMGp5RmJCUDg4dktZUEtD?=
 =?utf-8?B?ZkNuc1NEZ3VKVVdMZVNqZmsyV2NHSU9qa2NSRFhJYmFWSmJURHgrQjRhMnN4?=
 =?utf-8?B?K2s3MGtLZzhXcVVYZlIxMnZWcDNXVk5HZGFZblFJZ3REUjFRc2FVT2RFODRU?=
 =?utf-8?B?MEQweDVSbUZiYjhPSVRkamZWM2JMRkFVTUlNRTZkOFFhamFHODlmeEVNVTZL?=
 =?utf-8?B?SU5oRisvZGM4azV3ZWYrdGs1Sk9yUWtuUHVWSHN1eVZXVWtWd2Q5V1NyOU1q?=
 =?utf-8?B?TzRBMTJYNkcyWDNybHVWSTR5dm14OEdzeUNxaldpeTRwUE1yL1ZiYU1nVW85?=
 =?utf-8?B?U1FRTkJuWlRzN091OTY0QUlUU2hXTE5WVGJWeHd2Zk1NKzRudTg4eFJtdjdL?=
 =?utf-8?B?QmJONEVYOUh3OFRnRStyZmxLQ1F3QXl0d1A1by84RXplZmZjeHFDR1JiRkd3?=
 =?utf-8?B?K0xWbjlGcTBVM1plSUk1NVhyaVZaYlJVTmdyRjMvbk1uN0E2RXQ0WlBtQzVT?=
 =?utf-8?B?RGxzZVQwbTNOVXBOWFNGRTY1R25ZVkduNjRLOWxHTUt3MHRDWVk1MEdSMDZB?=
 =?utf-8?B?czA0c2VHRzIxakdYVFhDcG9SZEVpdXdoaktyQUdHRktPTXRGNjZCTnphYk9M?=
 =?utf-8?B?Y3dQMVRXL2l3SDllaGF0cXB3NndsVm16T1dBcUxhQ2h4RHNVYXZJSTN1cDFx?=
 =?utf-8?B?dGhjVXZIdDNRbW1zWmRVV2F4clZad2Vpeit0YXkvZmtEcVdiWFl0UnJNcUNK?=
 =?utf-8?B?cTBvL0kydkFtWXh5Z3NDZmlDbUQ2YU9SRWVvakYweHQ3ZW1DQUZJakgvYUo0?=
 =?utf-8?B?NVBmZDJzaXMwOGxRVVMzdzFVeXB1S2RFK2N2QjN0czgxRytGb2hyUmxpZjFk?=
 =?utf-8?Q?XIhqLULN4G6G+vOgRP+kxvwdfssDoO6J?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NUd5SmZ3UUREM2ZldXd3K2NvYUtTMGtHS05zZ09yK2RrdDhqc0xuang3TGFj?=
 =?utf-8?B?YWJiOVhzc2pnOTZFOC8waDVDZ2Jzc1dDc29lVjVoRFE2SjlhTmt3Y0lhTExN?=
 =?utf-8?B?MDBSaFlRQTB1L0FJZnYwQVAzdXhNTzFjd1pqZTZ5SUd6Z3REYzNkZDdqMlVE?=
 =?utf-8?B?OEF3eVVXY3JBamYva2ViV0NGYkZPSGpHVlR3cHU2Q3ZHZEVJaHNieW1XSFVw?=
 =?utf-8?B?R21Yd0ViNVI3MUFVeUxCeWZnMXBPTm1DenVXS2h3cXpFc1BQQ0ZhVnRCbXRt?=
 =?utf-8?B?N3djVVBHcTR0SmtRZ2huKzQ1c09VK3JKTFdGMkVDdk1RVnMySm9JVkEyd0sw?=
 =?utf-8?B?aGtTUkJDMlFCcEdwaHNQSnFPdEFOdEs5TXh6dmRXOXA1b3NybkJ6UVJjN0Z6?=
 =?utf-8?B?N0doMmN0dzQ3Q0I5aTZQYXh5U3lmakpPTG4xenRlQXhXVmlxK1ZkQkphSjd0?=
 =?utf-8?B?c3lub1BKVTgzV09CaDJpS1VJeWZQR0hsOFJsMXh0TGdzRHZ6ZWxFc2N2SzM1?=
 =?utf-8?B?M21Kck9aR2pwMWJwa2VKMDNvQnRXc0IwY0NhNDRhdTZBOFRIb2pHZFNtSEVi?=
 =?utf-8?B?MG5SU0NFTkpYNVdJcnBERk1JWWRaZGVpLzZTcUdudHExSTk3dVZUQ2FXbEF6?=
 =?utf-8?B?c2NCNWpUOUYrNWxJeitnQTQ1Q3Z0Tkp5OWl4RzIrbTMwTHFKZ0p5Und6TGFV?=
 =?utf-8?B?Z2VUYytXd3ZraExNYzRvREM2V0hhOWVoalpiSDJLWDY5NGFtRHhZS09vZGpm?=
 =?utf-8?B?dGllQW5mdkNUd0diKzF4Nks5ZjEyZWtYcGhOWVFLZFRZWlgvVTlUNTZzZ0Ur?=
 =?utf-8?B?QS9DZTBJNHVDRUQ4VGtZL1ppZW1HVXUvSko0Yi94S2t1bkMvNFArcXp4bDZI?=
 =?utf-8?B?WHgxRTBnL21BcUlvOFVsL2dLUHVSTnIxS0ZkVHJ2ZGhpU3U3b2VoSjJ1Z0o5?=
 =?utf-8?B?VngxcGFNWmliYUhPeEYzTFgzMHlyYWxwby9LTldOclArSVk5eTVadmkzNGox?=
 =?utf-8?B?OS81eElBRFBqdWJUWXNpVkVudXdsbm9mV3BvYzdCY01wZHdpUmhCd1c1RHc0?=
 =?utf-8?B?MGFXWTRqbGE0NndnNlpUMU84TVhPMU5lUWUwVW1zczN1Y252dUJRcDA4OFB6?=
 =?utf-8?B?VmNQcm1NaEZjdEFxMTBuSCtmN3pZWUJBdTVOaWNKMnlTTFRScWY3ZW1kVzg2?=
 =?utf-8?B?MnludWJBeHdnaHREZHB6Z2xjRjdTbi9lRG91akRqS2ZuTU1OQU1vanpsdVhu?=
 =?utf-8?B?NnprREhiMWE4N200OG4zTFpWd2E5LzZNTjdOcmYyY3c3WjNVMFphQWVxZTZr?=
 =?utf-8?B?K09VOVlYd3VTbDdqL0lCd1NuTVhoU0FYUGlNaTFNZ3RpaCsxeTVKeHNhMitG?=
 =?utf-8?B?d1BYWFNkWEJUTCt0cllXVkVGZkpBMlp2V0R4OG85RUZlRXZlYWJxUzZWWjdT?=
 =?utf-8?B?U05mM1Z6WUNRUUU3M2FudWZUNHhvamlGbjR0UndqbmVVRXdpTTRUQUozajNx?=
 =?utf-8?B?bkFRSjZRRlhUVmRtNTZ6VTAwV3E5ZXMxL0l6OGFWRVlCamF2YjFhTEVoZVQ3?=
 =?utf-8?B?bDZsZEFVMklJNXJ2MHRwN2N4dWM1RW1zQ3R5R1NubGNpZEYzS3FqVlR6bkxP?=
 =?utf-8?B?Q0VSYVV5ZktYUHFWMmhXdWIyWXAwZGlHVHp1aVFyellNUjM3QWNpVTdYcXR1?=
 =?utf-8?B?KytNYzE4THdzWHAxY3E3eGVlY2hDWG9GYSszaERsTWFLNFBIUHIwRyt6clpB?=
 =?utf-8?B?ZHZqMTV1N01mWGxTa25tc3NEV0ZLRUhMekk4VFdSdEdySjNPOFVKVXVsNmU3?=
 =?utf-8?B?RTZOckRuUmk0RnV0UjdpYVVzZVkzMVlQbFpwWi9RRlRkb2s0aFF4dlRCcy8v?=
 =?utf-8?B?eTBvc3pGODk0Z0M5VlNrZGM2K3BMTU50eG1ZdE9MN2lzVVp6elJweVRCc2Z5?=
 =?utf-8?B?WkIvL2Y1RHNmNHlTQkpCZFk2cjJBMytYbWhMVzdyVG9GeWRPb1Yxd2s1ZHJo?=
 =?utf-8?B?RUx4OUI4MVlkTEdCQU4ydnNLQkQvVlFGYnZDU1Z3c05PbGxwTTFTM2w4Qjl3?=
 =?utf-8?B?NGNtcFJPK0xUbU5iamdUWXRQNVl2aEVwMDlWekMwR2g5K1REZ0VSbWVxc3Zi?=
 =?utf-8?Q?ydta3QCu63dCsrCEvdO0VbI9J?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd0458a5-aa6a-41f8-affb-08de16e00f33
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 11:41:11.8609 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nE0h6kcWHj5E631h57JP++H0sKkxfEmXyZNYUQrKxl/R/euYSYrMGAFgFf8ucp/2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6145
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

On 10/28/25 23:06, Timur Kristóf wrote:
> Based on research carried out by Alexandre and Christian.
> 
> VCE1 actually executes its code from the VCPU BO.
> Due to various hardware limitations, the VCE1 requires
> the VCPU BO to be in the low 32 bit address range.
> However, VRAM is typically mapped at the high address range,
> which means the VCPU can't access VRAM through the FB aperture.
> 
> To solve this, we write a few page table entries to
> map the VCPU BO in the GART address range. And we make sure
> that the GART is located at the low address range.
> That way the VCE1 can access the VCPU BO.
> 
> Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
> Co-developed-by: Alexandre Demers <alexandre.f.demers@gmail.com>
> Signed-off-by: Alexandre Demers <alexandre.f.demers@gmail.com>
> Co-developed-by: Christian König <christian.koenig@amd.com>
> Signed-off-by: Christian König <christian.koenig@amd.com>

Make that a suggested-by and drop co-developed and signed-off-by for me.

The code was solely written by you if I'm not completely mistaken.

Patch itself is Reviewed-by: Christian König <christian.koenig@amd.com>

Regards,
Christian.

> ---
>  drivers/gpu/drm/amd/amdgpu/vce_v1_0.c | 44 +++++++++++++++++++++++++++
>  1 file changed, 44 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v1_0.c b/drivers/gpu/drm/amd/amdgpu/vce_v1_0.c
> index e62fd8ed1992..27f70146293d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vce_v1_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vce_v1_0.c
> @@ -34,6 +34,7 @@
>  
>  #include "amdgpu.h"
>  #include "amdgpu_vce.h"
> +#include "amdgpu_gart.h"
>  #include "sid.h"
>  #include "vce_v1_0.h"
>  #include "vce/vce_1_0_d.h"
> @@ -46,6 +47,11 @@
>  #define VCE_V1_0_DATA_SIZE	(7808 * (AMDGPU_MAX_VCE_HANDLES + 1))
>  #define VCE_STATUS_VCPU_REPORT_FW_LOADED_MASK	0x02
>  
> +#define VCE_V1_0_GART_PAGE_START \
> +	(AMDGPU_GTT_MAX_TRANSFER_SIZE * AMDGPU_GTT_NUM_TRANSFER_WINDOWS)
> +#define VCE_V1_0_GART_ADDR_START \
> +	(VCE_V1_0_GART_PAGE_START * AMDGPU_GPU_PAGE_SIZE)
> +
>  static void vce_v1_0_set_ring_funcs(struct amdgpu_device *adev);
>  static void vce_v1_0_set_irq_funcs(struct amdgpu_device *adev);
>  
> @@ -535,6 +541,38 @@ static int vce_v1_0_early_init(struct amdgpu_ip_block *ip_block)
>  	return 0;
>  }
>  
> +/**
> + * vce_v1_0_ensure_vcpu_bo_32bit_addr() - ensure the VCPU BO has a 32-bit address
> + *
> + * @adev: amdgpu_device pointer
> + *
> + * Due to various hardware limitations, the VCE1 requires
> + * the VCPU BO to be in the low 32 bit address range.
> + * Ensure that the VCPU BO has a 32-bit GPU address,
> + * or return an error code when that isn't possible.
> + */
> +static int vce_v1_0_ensure_vcpu_bo_32bit_addr(struct amdgpu_device *adev)
> +{
> +	const u64 gpu_addr = amdgpu_bo_gpu_offset(adev->vce.vcpu_bo);
> +	const u64 bo_size = amdgpu_bo_size(adev->vce.vcpu_bo);
> +	const u64 max_vcpu_bo_addr = 0xffffffff - bo_size;
> +
> +	/* Check if the VCPU BO already has a 32-bit address.
> +	 * Eg. if MC is configured to put VRAM in the low address range.
> +	 */
> +	if (gpu_addr <= max_vcpu_bo_addr)
> +		return 0;
> +
> +	/* Check if we can map the VCPU BO in GART to a 32-bit address. */
> +	if (adev->gmc.gart_start + VCE_V1_0_GART_ADDR_START > max_vcpu_bo_addr)
> +		return -EINVAL;
> +
> +	amdgpu_gart_bind_vram_bo(adev, VCE_V1_0_GART_ADDR_START, adev->vce.vcpu_bo,
> +		AMDGPU_PTE_READABLE | AMDGPU_PTE_WRITEABLE | AMDGPU_PTE_VALID);
> +	adev->vce.gpu_addr = adev->gmc.gart_start + VCE_V1_0_GART_ADDR_START;
> +		return 0;
> +}
> +
>  static int vce_v1_0_sw_init(struct amdgpu_ip_block *ip_block)
>  {
>  	struct amdgpu_device *adev = ip_block->adev;
> @@ -554,6 +592,9 @@ static int vce_v1_0_sw_init(struct amdgpu_ip_block *ip_block)
>  	if (r)
>  		return r;
>  	r = vce_v1_0_load_fw_signature(adev);
> +	if (r)
> +		return r;
> +	r = vce_v1_0_ensure_vcpu_bo_32bit_addr(adev);
>  	if (r)
>  		return r;
>  
> @@ -669,6 +710,9 @@ static int vce_v1_0_resume(struct amdgpu_ip_block *ip_block)
>  	if (r)
>  		return r;
>  	r = vce_v1_0_load_fw_signature(adev);
> +	if (r)
> +		return r;
> +	r = vce_v1_0_ensure_vcpu_bo_32bit_addr(adev);
>  	if (r)
>  		return r;
>  

