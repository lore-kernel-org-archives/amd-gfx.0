Return-Path: <SRS0=G5aM=P6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 904D0C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Nov 2021 04:53:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3AEA861152
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Nov 2021 04:53:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3AEA861152
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 867ED6E8F1;
	Thu, 11 Nov 2021 04:53:53 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2070.outbound.protection.outlook.com [40.107.237.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8DADB6E8F1
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Nov 2021 04:53:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ofFIWEr/Y29cBHTF3qhpzyQgInyCrKu3fwnx4uXJDSmEVnt+8Vmy48QyraEeuijGcPuaYrPwiaUn6ytenELyV2GQCyEZKOQAf1nR9ATaOJHb4oLG0vbNSa+bjyVX1lHDZJlOwvQ1zx3Xarea3XrNnYP8MI5yfxPkw8nReGBL02P06WuXALsW9A+sdp7TXU9rg4H0zvSpabp65jOXycn91jV9yHR3ALTT+LIBbrnLM7mEL8AVgsBOP6BwUh85xh3S7tAmyvWhy55qBRUE9FmtVqY/uPfdeUHusOCz07aGmsdcd6VavBF53w0QptJzh1wYc7cCnr6eDuspjUDvJ99D6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7FoOtoItxUUr1xDKLB+yQOPGAoTKW7mW7473khrwxEI=;
 b=AfTs/oU41KeK5GKnXMePIdE3t55GGNzxAy4eC3rR02q7OxiWnU+13eGeLr56s3EMXlQb4FjEM3At+cBoMZS9W/VP58GeuZQuR0/D8sTdeaTGRFKpcaJ3IbY4FXAALlHSIHmuIlMtoFJ7LN2iTBOd+PzJR4zguHjFym0ny8c+Q61SBf6ot3RnTfU762ONsCH3Z9f+9EBQucpoLM+WUUJhIkRritL4JdkxW8ok3hI/v3wQftnM9UKkplZhPGYIRJqukyRA0w3b/TBEcLa6ghTZB+raWGuW9tFKevKy1UqLSJNz32pgHFTA+ZAN4BRgYR3L4HKCj+7IqHn3NVEi1KNypA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7FoOtoItxUUr1xDKLB+yQOPGAoTKW7mW7473khrwxEI=;
 b=Fs81ljUaPOcgZXcxACo+zmBE8pUN5nBqnQOAzlbLXFZNPleJ0Z4SUr/JSL6kI57RcYHnpKnDHR+wY0sy7mxVsxAzySYrQTXtL0Zq6S4xCh2nfwLZI0fvE7LMFZhwNSOUr4oGkI4s3oTy40M93vy+8Oq/0iFu81RYPQYKgE/8PaI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3930.namprd12.prod.outlook.com (2603:10b6:5:1c9::19)
 by DM6PR12MB4402.namprd12.prod.outlook.com (2603:10b6:5:2a5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.16; Thu, 11 Nov
 2021 04:53:50 +0000
Received: from DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::591a:8986:aca2:c560]) by DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::591a:8986:aca2:c560%3]) with mapi id 15.20.4669.016; Thu, 11 Nov 2021
 04:53:50 +0000
Message-ID: <aaecbe8a-8669-fd36-11cf-db6a1a314ea9@amd.com>
Date: Thu, 11 Nov 2021 10:23:35 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [RFC 2/2] drm/amd/pm: Add support for reacting to platform
 profile notification
Content-Language: en-US
To: "Limonciello, Mario" <Mario.Limonciello@amd.com>,
 Alex Deucher <alexdeucher@gmail.com>
References: <20211110062343.10041-1-mario.limonciello@amd.com>
 <20211110062343.10041-3-mario.limonciello@amd.com>
 <CADnq5_MGbOh_Xbg6y4hH6qrSok_YKMj0c4Ma6ZKAE835cm2-hw@mail.gmail.com>
 <DM6PR12MB39300185FB03556E914290C297939@DM6PR12MB3930.namprd12.prod.outlook.com>
 <SA0PR12MB4510F4D9040A7EDA54FC73A8E2939@SA0PR12MB4510.namprd12.prod.outlook.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <SA0PR12MB4510F4D9040A7EDA54FC73A8E2939@SA0PR12MB4510.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BM1PR0101CA0046.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:1a::32) To DM6PR12MB3930.namprd12.prod.outlook.com
 (2603:10b6:5:1c9::19)
MIME-Version: 1.0
Received: from [10.252.81.250] (165.204.159.242) by
 BM1PR0101CA0046.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00:1a::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.15 via Frontend
 Transport; Thu, 11 Nov 2021 04:53:47 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5f4a3aa8-1a3d-40bf-6a64-08d9a4cf4066
X-MS-TrafficTypeDiagnostic: DM6PR12MB4402:
X-Microsoft-Antispam-PRVS: <DM6PR12MB4402331CB0E675ED4D96E86B97949@DM6PR12MB4402.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hjiY3TCl4W2WIMhhSiyPt0jvTdH2vCaDyTk1glAFfHCDR7ne04qC9+JTTe/d+W1mA+r6St21ZMTpqVhVznhhsRnYyir0vntBcf/lMjgn/nKjG33Bn2aRiB9l6LLgV3OBpp3O79q04ph7NxJqdA2yp7YpmOhzdZE6MqO2qUPpcriGCUBoLZSBwKn/uahJ9nVzaAGUU2JO+hK0GGzFKNKzjpXA2UFhgCkdloFI5Qr+Mn3fXK6e9U/zJk8eVP5FYylLa5ZvtsaFK3i2kMjd9bY0VKwNWV6re8t7pkRJBJJEoJIhNZyhshIYq3wWoXlHPhZYEOUIHS4vdAVbdPlpqfqvMllwA5ImZrbMsg/cDpzYm9Lw02M4Z2DVBUkEuuwaUE/SduydkL4gsEEjQTq9+F9UnZ7we0C8pBPfnmXPxeFbcq6sOPQUmYB2XYRjcGaVGCHyUyEuox1VU/dgBU1DyuBjucRi8rpu3uIc/JPQsvKCKPybHcIkJgLmRKg6ADc+W0HX6Ziom+GwkGxaQdEJotS7m21x0+1tn8KzlIVSeHdO+D89zFiGohE9F2eLpVbMl4kNd7rZ+7OtOzyPUamyA6XzAHW8IFPdC75OAyFQJXU/qvCtDMe7B5aBX4G6vS4k1L1HiiesipGbzjCiNj2teyHCdv+Jb3DrG8j5gREco/Q2poYeE2tEtnvQPajobdWGeG14qbTAxt5BmzMBQ2MRM9NzGC5M/5LGnhEefQQM4vEb8fk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3930.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(66476007)(31686004)(508600001)(30864003)(956004)(53546011)(31696002)(2906002)(316002)(66946007)(110136005)(186003)(2616005)(83380400001)(86362001)(8676002)(5660300002)(8936002)(38100700002)(6666004)(16576012)(66556008)(26005)(4326008)(6486002)(36756003)(15650500001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?akNHY0lvL2FxVkx3ZlZxUmN1L1RXWXNZVXNhT3pEMEo4Nm9NNUZPMHo2Zzh1?=
 =?utf-8?B?QlNZV1ZQYXZBQ0p3emNtNDRZbG93L0dFemEyWHhzNXJ4SnE3YWRrdWp4c0Rz?=
 =?utf-8?B?L0NHdEd0NStFQ1JuZDhNQjBVcHppeTdNbTZNQ1JWamJ3Z2FRUGhhd0F2OTZt?=
 =?utf-8?B?c2JqSi9taDMrSFdvLzRsRmZjTGdDSEVJRTMyRFV6ZnRaUWtpNitBMGZoek4r?=
 =?utf-8?B?WnhxSmErZ3FyaTF6bHo0UWVNQ2E0Y25KeEZQZmgzaEljQmJhemdwUi9jMm5L?=
 =?utf-8?B?bWZHNmJNUDFaQUNHWkovQ2xNNmgyTEZEb3NvL21rRW9SM0JCM05wTyt6a2JY?=
 =?utf-8?B?emFXYzV4WTllZmh0ZVhUWGpuQndHd2hyQWRoaXQrZWlmdm4yNG5rMVE0OTZS?=
 =?utf-8?B?S2d3NENQdldGSklQQ3NLcUhOcmoxUXVhVjRaODhjdU0yMjJnVmZSNEJpV05D?=
 =?utf-8?B?dC9YQi9qMXNZWERNSWpLbURJcTlZSGFLMmVhWXIwTnJuUVBjZVd0UlRpZ21H?=
 =?utf-8?B?akZYK2JOV0hSVExlZEUwOUtFSUZySWhSZGZOditTeUpVcUU5ODNYaDZsYWZY?=
 =?utf-8?B?NThwYjlLNlBRdFVNUFd2a2Y0ODNTTC8zUVBuUzNJNFFkaklRRk5JRmpNNURJ?=
 =?utf-8?B?dzc4QTRZWk9IaTRyWG8wVVpPV3VWOE5jbDU4WS9qRkxKVE9tSjJZM04yb3A4?=
 =?utf-8?B?VDFIQzFDaWVvbTlsSFJKR0ZRSXBNWjhsWktJNERmMFpVQ1IrS0U2cDdrOVlN?=
 =?utf-8?B?N0N2VHM5MU1oZmNYZ2lLTXBPVjl5c2N0TjVCdlBkMjMrQjVPNGszRUNnMUpC?=
 =?utf-8?B?cU1oQkVBWjdaUFRDRzBJREVNNW1tOSt5eFhDM0Ura25yV3AvSUkvQ1VHVk1E?=
 =?utf-8?B?dGxLT1UwcCsxcG1BMFU2L1BaK0x4VG1DYnlSMmVxSWcyMHBOMGZ2VUpBa28v?=
 =?utf-8?B?alNPMTVIRngwRUMzaHYzbWhWRWt2ck11Q1BTK3hrTXdmMVBqL3pwSEdGMnB0?=
 =?utf-8?B?YUwzdUFSR2hqMFBDYnRoRXZGVlFxaFBONldyZjlMMERMQ01aOElKQmI5cHpF?=
 =?utf-8?B?RXhLZDlFcWROMUxrenZ4N01ac2hUS1FHY3d0ckxkUldMWENwakdyOWtDSEVw?=
 =?utf-8?B?ejg0dW1uTFlNaEhBS1kxcHhqeGRwK1JmbklobWxjMFlUZi9Bc0ZqQXhqRCtV?=
 =?utf-8?B?c3FuTjRRbEw1YVgxc28yS2x5b2hBT3hSOUJFRGVWY1dZR09VMlBsUmVjZm1U?=
 =?utf-8?B?ODhsbytXcnJaZXFWcW1QdEhDT2RlakRoSlUyTnFXY2ZHazZhODd2aVg3aUIx?=
 =?utf-8?B?RnVWQ29KRWxOcSs2VGZPMlIrdU1TdUN2OXpZeW5TM3d3VVF5bElaWTlvODly?=
 =?utf-8?B?Njczc0VtZTVycm1WRDFrQjBkS2xGOG9aK0EvUDVWUjZZZ0hsYXUzVmY2dlFm?=
 =?utf-8?B?UHF2NGFWWlBRU3p1VDhVSE50M0pjc21IL0NGWWFmWTgxc0RtSHJKOVRId24z?=
 =?utf-8?B?eVY5YnhCV2M4MmF5anB3dmd2WksxVWFsY0JFT2NtVEtuYnJ2VEhrUXhZU0Ey?=
 =?utf-8?B?SDdxZHFvQVRpV0pWZG56K3lIU3Q3cHkrekRvajlSVnM1Ym80bDd3ejhIQ2JF?=
 =?utf-8?B?MG5SWFJPQ3RzMi9tVUxvOExOd2svMWswWWtOM2prZndMZmJCMzBiRTBGUGdh?=
 =?utf-8?B?cDdyTGx6TWlUYmM4elo1Zm9yWVpLK0swN0dDd0NFVndnWWVGUnYwWURWdzNB?=
 =?utf-8?B?S1ZveU8vNE1xUm5HUjFYZGdKZkNZUjJRMVJqR2VIdExDc1JjZ00vdW5EbXVQ?=
 =?utf-8?B?OGxjcUprNURFK3lrMWRpTmVBdGNVaFR2Nk5BRE9XNVluQStFd01Xd2pmNUox?=
 =?utf-8?B?OWM1aGlPWVI4YU1yenBHd0pHTDVPcXhIU3o3UXpLM2NCeUxEY0J3blBWampF?=
 =?utf-8?B?ZEFxck4vT2c1d0drZkpmbkhZTEtqVk5SSGoxRy9ES2RXTXZQYVBRcThWWGtG?=
 =?utf-8?B?VkN0akh6OGYyUFEwTHpjVUNBWXg4NFpnQVUxd1g5elp3QkVnSTVoWVB5bmV6?=
 =?utf-8?B?L2lLaVFMZnNLQ09ZcHBwKzBnOWJ5bmZPNEFjRDRnT1VDVjZhb0NzbEZuWkF5?=
 =?utf-8?Q?Z5Uc=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f4a3aa8-1a3d-40bf-6a64-08d9a4cf4066
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3930.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2021 04:53:49.9032 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F2tX1Ve7o8KmqcXgV5ZmqtzJ4sYvV0EBKMTSWNA3HFsGDB9bv+yPTBb5hd7Tt5Uu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4402
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
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 11/10/2021 11:01 PM, Limonciello, Mario wrote:
> [Public]
> 
>> I don't think we want to force the performance level.  This interface
> forces various fixed clock configurations for debugging and profiling.
> 
> Ah got it.
> 
>>I think what we'd want to select here is the power profile (see
> amdgpu_set_pp_power_profile_mode()).  For this interface you can
> select various profiles (BOOTUP_DEFAULT, 3D_FULL_SCREEN, POWER_SAVING,
> VIDEO, VR, COMPUTE, etc.).  These still use dynamic power management,
> but they adjust the heuristics used by the GPU to select power states
> so the GPU performance ramps up/down more or less aggressively.
> 
> Which profile mapping you think make sense?
> 
> My guess would be:
> 
> “BOOTUP_DEFAULT” for balanced
> 
> “POWER_SAVING” for low-power
> 
> “3D_FULL_SCREEN” for performance
> 
> Since recently we removed that interface for YC, and some earlier APUs 
> don’t do as much with it.
> 
> So I wonder if this is only really valuable to do this callback for !APU.
> 
>>I feel it's better to leave to platform vendors. For ex: for APU cases 
> they may have implementations in which their BIOSes talk to PMFW and 
> this might be driving something else here.
> 
> Even if changing the heuristic for workload as Alex suggested?
> 

Yes. I think this is meant to be BIOS driven for APU platforms and AMD 
APU + AMD dGPU with smartshift.

>>Also, not sure how to handle a case like, say a laptop with Intel CPU 
> and AMD dgpu.
> 
> I was actually thinking this approach where there are platform profile 
> callbacks is best because of that specifically.
> 
> It would allow an Intel CPU system to have a platform profile driver 
> implemented by the OEM, but then still notify amdgpu dGPU to tune for 
> power saving or performance workload.
> 

After seeing that this is coming under ACPI, I thought the intention is 
to have this driven by firmware primarily. The purpose of platform 
driver itself could be to optimize for those power profiles and while 
doing that it should have considered all the components in the whole 
platform (assuming platform driver testing covers the behavior of these 
modes on a particular platform).

I am not sure if it's appropriate for another driver to plug-in to this 
automatically and tinker an 'expected-to-be-well-tuned' setting by the 
platform driver. The modes selected by another driver may or may not 
match with the conditions assumed by platform driver - for ex: some 
profile could mean fans running quieter with EC control and then the 
profile chosen by another driver could disturb that intended setting.

Thanks,
Lijo

> *From:* Lazar, Lijo <Lijo.Lazar@amd.com>
> *Sent:* Wednesday, November 10, 2021 10:05
> *To:* Alex Deucher <alexdeucher@gmail.com>; Limonciello, Mario 
> <Mario.Limonciello@amd.com>
> *Cc:* amd-gfx list <amd-gfx@lists.freedesktop.org>
> *Subject:* Re: [RFC 2/2] drm/amd/pm: Add support for reacting to 
> platform profile notification
> 
> [Public]
> 
> I feel it's better to leave to platform vendors. For ex: for APU cases 
> they may have implementations in which their BIOSes talk to PMFW and 
> this might be driving something else here.
> 
> Also, not sure how to handle a case like, say a laptop with Intel CPU 
> and AMD dgpu.
> 
> Thanks,
> Lijo
> 
> ------------------------------------------------------------------------
> 
> *From:* amd-gfx <amd-gfx-bounces@lists.freedesktop.org 
> <mailto:amd-gfx-bounces@lists.freedesktop.org>> on behalf of Alex 
> Deucher <alexdeucher@gmail.com <mailto:alexdeucher@gmail.com>>
> *Sent:* Wednesday, 10 November 2021, 8:44 pm
> *To:* Limonciello, Mario
> *Cc:* amd-gfx list
> *Subject:* Re: [RFC 2/2] drm/amd/pm: Add support for reacting to 
> platform profile notification
> 
> On Wed, Nov 10, 2021 at 1:24 AM Mario Limonciello
> <mario.limonciello@amd.com <mailto:mario.limonciello@amd.com>> wrote:
>  >
>  > Various drivers provide platform profile support to let users set a hint
>  > in their GUI whether they want to run in a high performance, low battery
>  > life or balanced configuration.
>  >
>  > Drivers that provide this typically work with the firmware on their 
> system
>  > to configure hardware.  In the case of AMDGPU however, the notification
>  > path doesn't come through firmware and can instead be provided directly
>  > to the driver from a notification chain.
>  >
>  > Use the information of the newly selected profile to tweak
>  > `dpm_force_performance_level` to that profile IFF the user hasn't 
> manually
>  > selected `manual` or any other `profile_*` options.
> 
> I don't think we want to force the performance level.  This interface
> forces various fixed clock configurations for debugging and profiling.
> I think what we'd want to select here is the power profile (see
> amdgpu_set_pp_power_profile_mode()).  For this interface you can
> select various profiles (BOOTUP_DEFAULT, 3D_FULL_SCREEN, POWER_SAVING,
> VIDEO, VR, COMPUTE, etc.).  These still use dynamic power management,
> but they adjust the heuristics used by the GPU to select power states
> so the GPU performance ramps up/down more or less aggressively.
> 
> Alex
> 
>  >
>  > Signed-off-by: Mario Limonciello <mario.limonciello@amd.com 
> <mailto:mario.limonciello@amd.com>>
>  > ---
>  >  drivers/gpu/drm/amd/amdgpu/amdgpu.h |   3 +
>  >  drivers/gpu/drm/amd/pm/amdgpu_pm.c  | 105 +++++++++++++++++++++++-----
>  >  2 files changed, 90 insertions(+), 18 deletions(-)
>  >
>  > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h 
> b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>  > index b85b67a88a3d..27b0be23b6ac 100644
>  > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>  > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>  > @@ -1097,6 +1097,9 @@ struct amdgpu_device {
>  >
>  >         struct amdgpu_reset_control     *reset_cntl;
>  >         uint32_t                        
> ip_versions[HW_ID_MAX][HWIP_MAX_INSTANCE];
>  > +
>  > +       /* platform profile notifications */
>  > +       struct notifier_block           platform_profile_notifier;
>  >  };
>  >
>  >  static inline struct amdgpu_device *drm_to_adev(struct drm_device *ddev)
>  > diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c 
> b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
>  > index 41472ed99253..33fc52b90d4c 100644
>  > --- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
>  > +++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
>  > @@ -32,6 +32,7 @@
>  >  #include <linux/hwmon.h>
>  >  #include <linux/hwmon-sysfs.h>
>  >  #include <linux/nospec.h>
>  > +#include <linux/platform_profile.h>
>  >  #include <linux/pm_runtime.h>
>  >  #include <asm/processor.h>
>  >  #include "hwmgr.h"
>  > @@ -200,6 +201,33 @@ static ssize_t amdgpu_set_power_dpm_state(struct 
> device *dev,
>  >         return count;
>  >  }
>  >
>  > +static int amdgpu_get_forced_level(struct device *dev, enum 
> amd_dpm_forced_level *level)
>  > +{
>  > +       struct drm_device *ddev = dev_get_drvdata(dev);
>  > +       struct amdgpu_device *adev = drm_to_adev(ddev);
>  > +       int ret;
>  > +
>  > +       if (amdgpu_in_reset(adev))
>  > +               return -EPERM;
>  > +       if (adev->in_suspend && !adev->in_runpm)
>  > +               return -EPERM;
>  > +
>  > +       ret = pm_runtime_get_sync(ddev->dev);
>  > +       if (ret < 0) {
>  > +               pm_runtime_put_autosuspend(ddev->dev);
>  > +               return ret;
>  > +       }
>  > +
>  > +       if (adev->powerplay.pp_funcs->get_performance_level)
>  > +               *level = amdgpu_dpm_get_performance_level(adev);
>  > +       else
>  > +               *level = adev->pm.dpm.forced_level;
>  > +
>  > +       pm_runtime_mark_last_busy(ddev->dev);
>  > +       pm_runtime_put_autosuspend(ddev->dev);
>  > +
>  > +       return 0;
>  > +}
>  >
>  >  /**
>  >   * DOC: power_dpm_force_performance_level
>  > @@ -264,29 +292,13 @@ static ssize_t 
> amdgpu_get_power_dpm_force_performance_level(struct device *dev,
>  >                                                             struct 
> device_attribute *attr,
>  >                                                             char *buf)
>  >  {
>  > -       struct drm_device *ddev = dev_get_drvdata(dev);
>  > -       struct amdgpu_device *adev = drm_to_adev(ddev);
>  >         enum amd_dpm_forced_level level = 0xff;
>  >         int ret;
>  >
>  > -       if (amdgpu_in_reset(adev))
>  > -               return -EPERM;
>  > -       if (adev->in_suspend && !adev->in_runpm)
>  > -               return -EPERM;
>  > +       ret = amdgpu_get_forced_level(dev, &level);
>  >
>  > -       ret = pm_runtime_get_sync(ddev->dev);
>  > -       if (ret < 0) {
>  > -               pm_runtime_put_autosuspend(ddev->dev);
>  > +       if (ret < 0)
>  >                 return ret;
>  > -       }
>  > -
>  > -       if (adev->powerplay.pp_funcs->get_performance_level)
>  > -               level = amdgpu_dpm_get_performance_level(adev);
>  > -       else
>  > -               level = adev->pm.dpm.forced_level;
>  > -
>  > -       pm_runtime_mark_last_busy(ddev->dev);
>  > -       pm_runtime_put_autosuspend(ddev->dev);
>  >
>  >         return sysfs_emit(buf, "%s\n",
>  >                           (level == AMD_DPM_FORCED_LEVEL_AUTO) ? "auto" :
>  > @@ -405,6 +417,59 @@ static ssize_t 
> amdgpu_set_power_dpm_force_performance_level(struct device *dev,
>  >         return count;
>  >  }
>  >
>  > +static void amdgpu_update_profile(struct device *dev, enum 
> platform_profile_option *profile)
>  > +{
>  > +       enum amd_dpm_forced_level level;
>  > +       const char *str;
>  > +       int ret;
>  > +
>  > +       ret = amdgpu_get_forced_level(dev, &level);
>  > +       if (ret < 0)
>  > +               return;
>  > +
>  > +       /* only update profile if we're in fixed modes right now that 
> need updating */
>  > +       switch (level) {
>  > +       case AMD_DPM_FORCED_LEVEL_LOW:
>  > +               if (*profile < PLATFORM_PROFILE_BALANCED)
>  > +                       return;
>  > +               break;
>  > +       case AMD_DPM_FORCED_LEVEL_HIGH:
>  > +               if (*profile > PLATFORM_PROFILE_BALANCED)
>  > +                       return;
>  > +               break;
>  > +       case AMD_DPM_FORCED_LEVEL_AUTO:
>  > +               if (*profile == PLATFORM_PROFILE_BALANCED)
>  > +                       return;
>  > +               break;
>  > +       default:
>  > +               dev_dbg(dev, "refusing to update amdgpu profile from 
> %d\n", level);
>  > +               return;
>  > +       }
>  > +       if (*profile > PLATFORM_PROFILE_BALANCED)
>  > +               str = "high";
>  > +       else if (*profile < PLATFORM_PROFILE_BALANCED)
>  > +               str = "low";
>  > +       else
>  > +               str = "auto";
>  > +
>  > +       dev_dbg(dev, "updating platform profile to %s\n", str);
>  > +       amdgpu_set_power_dpm_force_performance_level(dev, NULL, str, 0);
>  > +}
>  > +
>  > +static int amdgpu_platform_profile_notifier_call(struct 
> notifier_block *nb,
>  > +                                                 unsigned long 
> action, void *data)
>  > +{
>  > +       if (action == PLATFORM_PROFILE_CHANGED) {
>  > +               enum platform_profile_option *profile = data;
>  > +               struct amdgpu_device *adev;
>  > +
>  > +               adev = container_of(nb, struct amdgpu_device, 
> platform_profile_notifier);
>  > +               amdgpu_update_profile(adev->dev, profile);
>  > +       }
>  > +
>  > +       return NOTIFY_OK;
>  > +}
>  > +
>  >  static ssize_t amdgpu_get_pp_num_states(struct device *dev,
>  >                 struct device_attribute *attr,
>  >                 char *buf)
>  > @@ -3506,6 +3571,9 @@ int amdgpu_pm_sysfs_init(struct amdgpu_device 
> *adev)
>  >         if (ret)
>  >                 return ret;
>  >
>  > +       adev->platform_profile_notifier.notifier_call = 
> amdgpu_platform_profile_notifier_call;
>  > +       
> platform_profile_register_notifier(&adev->platform_profile_notifier);
>  > +
>  >         adev->pm.sysfs_initialized = true;
>  >
>  >         return 0;
>  > @@ -3519,6 +3587,7 @@ void amdgpu_pm_sysfs_fini(struct amdgpu_device 
> *adev)
>  >         if (adev->pm.int_hwmon_dev)
>  >                 hwmon_device_unregister(adev->pm.int_hwmon_dev);
>  >
>  > +       
> platform_profile_unregister_notifier(&adev->platform_profile_notifier);
>  >         amdgpu_device_attr_remove_groups(adev, &adev->pm.pm_attr_list);
>  >  }
>  >
>  > --
>  > 2.25.1
>  >
> 
