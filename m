Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 237D1C433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Nov 2021 15:34:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A7BAE6E2ED;
	Wed, 24 Nov 2021 15:34:02 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2074.outbound.protection.outlook.com [40.107.243.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1DBD26E2ED
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Nov 2021 15:34:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DoICjqXqqXzCyI/CmijKhcHSG6cRDjTIVzaKona5+2tWW0axFYy4hUHz1oZVbTgTfg5j9jx1u1uCXUXVOFodS9dIKBkGGZj5fTWNpfoD4IM//CLrW5fagWUwaauHV5bkZL6RhDECu0mbK+7qE1rzaW7x1WNeMIMgqKZebMcgH+OWUi62yVwCUQghi/c2rdYgL5UEl5vKyb58aEDx8FhmX0fJIL2+IOnsZERhNF5A9hFNM+YcBl7mINTKwAt4U49txz8Ss7UtLHIwjlrHD7+jkF+nx2q6WFAh8OEIbr/+I1yS6s9h8Q9PYcBaDExwnx/4b+Nb/xcR29h2gvFccCwTBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0bcI4NGGE5TVwPr570Bym+UeBd5j9+SNgMVM2HJVZUM=;
 b=nJte5B1ppa4MhNlggvIf6DIt625NqvQGz5aWRkGks7kEvFlqVDXPduxHC28/tqBYWL7bW+Vt8Ld1vKXzlmFpQuRGpPOgX/OEjVTzZAJQZ7WU3bW6NiWkPYk0Ksn1onEVGIFPCvwZcWV+C9UV/AFrFCvO5I53UrAZii75WxsstBjm/RGdTGeCGyjAXn/rR32UFh1Pk53xz0KwRNvzqIfG20HQvwF/qmlVxbiJOSLLgxjXK+rGZuOO9cMbCeoN6NDyNn3wip3vzCnRhoP8CQVj8oN2EpC6DdBXWZ5saOmV+au2hddJL5GWeKOUdl/IzJc5KPiiY13vycmf8g7vlueKWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0bcI4NGGE5TVwPr570Bym+UeBd5j9+SNgMVM2HJVZUM=;
 b=hSWKmclGb/W1MptIJTDDhcawCf2XY5WgMYXc2ea3GXttn+IHU5b8XUdhkPG9wTrDsYreWQSybYkRpNiBOCsA8e9JjndSuDkW85KaV9DW7/vzzDJIiXCykE2Xv0Wq+/m77UdGeQyM6RLuaDctDiU8Ly0wT8jONKZK5WJ0BIpEN6c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MWHPR1201MB0192.namprd12.prod.outlook.com
 (2603:10b6:301:5a::14) by MW2PR12MB2364.namprd12.prod.outlook.com
 (2603:10b6:907:b::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19; Wed, 24 Nov
 2021 15:33:59 +0000
Received: from MWHPR1201MB0192.namprd12.prod.outlook.com
 ([fe80::2d02:26e7:a2d0:3769]) by MWHPR1201MB0192.namprd12.prod.outlook.com
 ([fe80::2d02:26e7:a2d0:3769%5]) with mapi id 15.20.4713.026; Wed, 24 Nov 2021
 15:33:59 +0000
Subject: Re: [PATCH v5] drm/amdgpu: handle IH ring1 overflow
To: philip yang <yangp@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20211123192254.21681-1-Philip.Yang@amd.com>
 <3d17fd21-751d-6f87-95b9-d120db7f4a0e@gmail.com>
 <5ec42928-995f-04c6-c7c8-3d2e33744457@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <bc4b8eb7-698f-a522-ef33-6d2232612167@amd.com>
Date: Wed, 24 Nov 2021 16:33:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <5ec42928-995f-04c6-c7c8-3d2e33744457@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: AM6PR01CA0043.eurprd01.prod.exchangelabs.com
 (2603:10a6:20b:e0::20) To MWHPR1201MB0192.namprd12.prod.outlook.com
 (2603:10b6:301:5a::14)
MIME-Version: 1.0
Received: from [IPv6:2a02:908:1252:fb60:1d92:1b11:e635:a5]
 (2a02:908:1252:fb60:1d92:1b11:e635:a5) by
 AM6PR01CA0043.eurprd01.prod.exchangelabs.com (2603:10a6:20b:e0::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.20 via Frontend
 Transport; Wed, 24 Nov 2021 15:33:57 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 03875c33-749d-4e5e-99a4-08d9af5fd5a1
X-MS-TrafficTypeDiagnostic: MW2PR12MB2364:
X-Microsoft-Antispam-PRVS: <MW2PR12MB236464D4A36D01599A3EAB7A83619@MW2PR12MB2364.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DIpI6clbNfJbMbihGRsZn3pZkFvwZnhDQw0MONHN1jpXuulenjPtl9VW/Q96rnIriuLMB78/mSLcGccQlo8RMQA62z5SAt70FzUIA3X4ukpiz+GMLBPRY38mkTjFM6cJ5tGV1D1UlU7wBUv7v1fhpkw0UDETAXCSyuBaynUjHurGxA+QVOuK1ErHTwBbIvm/CgANedatqybOZ8PXiWr+jSgYh304UA8MqxJp8hIz5VuBRU2JTTChMZXiwqVzI2Gyy5/iqO1o92W1kDxb5HPFWOYqXEUW20pmEHoEv/2gFurhQJLH2JzMsMVIjZuMQkmm39zwPB/5wRqXJJCSGCP1dGOfDpFYH2yzUFFRGJdg8L4iXk62QMIYq1a7QVv+1FGLSkipyyEiSdg5i6r2lehrc8g0DJr37j87k+rbA3ahbus6zrhREYaOwOuMNOUFzy0Tc+Avm+UxHqCkLyRjmFVaGSasIO7shqtoSU91hqNTEGodma9XkEkbvnAINRTnFjZLOAS1BP+zTLD00TJx5x9kausZOEcr3U7pRORKQC1+Ee5TpE+Pp7HpxQSq8OE6fIh83xk+MbVObEcTxMWzt/vHrHwS99ahMS19gBXPD904A7DS4UReuXwUB3wCymDLD0OaJGnAk1b7R9mnUQ6yQyY0GwXc7o9RzGR3SMsVuJqfiB6Bp5jeEpwfdAVk08geHZAu6ewqSgD0Et9uJM/j2J25lA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR1201MB0192.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(110136005)(508600001)(2906002)(66556008)(4326008)(8936002)(86362001)(38100700002)(5660300002)(8676002)(36756003)(6666004)(66946007)(31696002)(66476007)(316002)(6486002)(186003)(31686004)(2616005)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TnZYaTFIQkZpc1ZGa0pyMmgxcDBKUy8vVng2T2hlcFo3WGF6SU50ZHBGcWYz?=
 =?utf-8?B?RjJTN2crVEN2WkNsQjVhSmwrbUJnSTVqUmp5YWFrTFJOejd6WEhFRW82WGJ3?=
 =?utf-8?B?aXhLVTVkRm1WMXNQNm1iWHArRmozUWxNQnVxK2tJbGFqQlNwS2tXcStCSk9a?=
 =?utf-8?B?MnZpMHQzc09VYkhlTGdhSjBic2ZYWFEwcDJaTElDUUFjQnc4bEYzelJSOGpW?=
 =?utf-8?B?S3lMSjg3OUF0N25kQTJKLzB5Qm9ZWHB4cUhjVm5DWFNldTZ3OVJnci8vOGNv?=
 =?utf-8?B?aVFqY1hrL3NWTG0yNUdMTlVGYkR0OVVNV3ZuZGFqNFBtS1l4WG1Sekkxejkz?=
 =?utf-8?B?UndFMm9XTFVwQnE3NWIxamtzMGFFWHdmQ3lzYk1XYzN6NGkyK0NVY2UrUktj?=
 =?utf-8?B?Z3pyd2JJSmp0OXF2dzVzcmhoMmhCZGJpbVlIamxubGZoK21hRkdyU2s2T1B2?=
 =?utf-8?B?YWcxRWUrcXhacWFZdWMzYml0b3BTZ0JXMlNycjRIeElBeFlnc0lySEVFR3N5?=
 =?utf-8?B?WExLSlZUWnE1eHZiT2dEREZxRkFTWGVSTjhNNWRWdzN6RVFoNFhvUjIwMmpY?=
 =?utf-8?B?UWlGb01mQkhTNzhiQkpENHBveFpJRVNXNFpiTHpwaDM3bUVGYVZrTUtNOEtx?=
 =?utf-8?B?MmJGS2h1WDJjNTd5QzBqNW5idEpjZzdHbWhMa0VmRVk4dXlwd1BnL2VFNTJm?=
 =?utf-8?B?Q1JDL0dLbkZDR0w5QngyZitGR25OWGdnY1J0dTE5L1YrUENFblAvOUp6Lys5?=
 =?utf-8?B?bEtjdm5idHhUd3QzSTBsODZyOFJXY0NEcm8yaGpLZWVLekVCalpxZjRWV3U1?=
 =?utf-8?B?aWcrMzR3WlYvREtTM2VTTXR1bzc2enprck1TMFMraXFzN0o0ZytGU05mMHVa?=
 =?utf-8?B?L2oydTIxamxXOVh0dWZjT3VhdXhUaSs2NW4wZ2lMVXpnd0Z4a0IrTUE5d0g4?=
 =?utf-8?B?V0hSYWJIdXdzcHlnS1p4aDVOTTVtbTkzOVEvMGRZV3VWcGZWcEs5SU1wVlhI?=
 =?utf-8?B?cThtOTRobkNrbGRQT25WZ0JuS1ZITHpJRUEwWk5oSTM5QTEzNUZoc3hxUE1V?=
 =?utf-8?B?ZWc3Z2MzU2c1SmRycXF3SGtrTyswanlyb2EwaWt0SGdEUkk4V200WEpiN2lQ?=
 =?utf-8?B?QjdSVHJTSGtsb3R2Q1pLMXJmUVlqTUxuRGJuS1pjK29adzNzT25kVkxmejNy?=
 =?utf-8?B?Z2UyeUhieUlmL1ZXYUw0b0JLTUYweXl3dmtiQzE3U1crcVdKMWkzVklFUmZt?=
 =?utf-8?B?VWE0V0NueXBDMU53R2FKd0p6ZmEyTFBsOTR3d0xXUWNKeXpCZzNLbVFHTnlh?=
 =?utf-8?B?R0NzVkNrMGJueEU4WVY0R3ZUVmJlWDJMaFJBQUhPbkp2eGNuZ016ekRmTy9j?=
 =?utf-8?B?aFBrRTFGam5CUlBuUFpUbUk3L0FMeHBRemFZcmk0czlmWVd6VmFWQk00NWJn?=
 =?utf-8?B?emIzQzhaajlBdCs2ckd5Y0d6SHpNRmg0elV5T1FJcllTamxhVUxKWGgvOW1r?=
 =?utf-8?B?dExUNStpQ2w5Q213Z3ZTLytiWTZSQzFDNWZFUlNwYTFYanJUOWVlOXplS0k0?=
 =?utf-8?B?L0k0aWV0MkZjWEdINGlvejVLc0NkR1BxRmliTDRLcVAvM3k2eFB3NDR4bXZx?=
 =?utf-8?B?c0N3UE1LVEswK3pnVlhnRjdXTk1uZkdGekFMeC9ZcjNFNGRXY3JUNm5hS1Nm?=
 =?utf-8?B?bmVaK0xzdXVLSDVLSi80L3JlK0VqUVBsZ1IrN2FTYmVjTXlIbjdybVJWcFVw?=
 =?utf-8?B?eG9IZ214NWZ2clpvOVpjZ2FMMytKYWhRbTlEZzdKNFI3SWZnOEJTT0g3UE9h?=
 =?utf-8?B?d080QkhaY09iYTl1Vk5zOGVNMW5abUZPczhybVhjQzBLRmkxNTVsMk8yVTd5?=
 =?utf-8?B?V2k1WFFWQy9Fcm16WVpQYzBHSVhjeTlWQUV1OThIbk1rTTRnVmZRakEvZ1Vu?=
 =?utf-8?B?YlI3b2JEWXpKWDlrVTJoN0tpSVhwczdnMit5UVNmaTZtRTZQblc1WWt3T0l5?=
 =?utf-8?B?SEFaNGp0c1dBVjI2NlA5NHBNNHAvOEtGV1ZOa3dvcGxpckRkaTRJS28xZW9S?=
 =?utf-8?B?RkVnM0hJV0ZzSjZsUjhqVnh5ZUZseU9qU2t0OWlBemFwblRIbjY3dDdWTUg5?=
 =?utf-8?B?OFBkT3dEQXNiTWdHOWoyajBoRjZROVV4OXVjRzYrYnl5YStZZFJjMjFOZ0pO?=
 =?utf-8?Q?BaR+OlxaQeP6T2j/f6zRaZI=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03875c33-749d-4e5e-99a4-08d9af5fd5a1
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1201MB0192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2021 15:33:59.3216 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HSp2wTe6H0E8mf3i29spG6p8glOHd9v3Z2dOSRVWRD92XIGbPvw9y8yhFnk6vRPK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2364
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
Cc: Felix.Kuehling@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



Am 24.11.21 um 16:23 schrieb philip yang:
> [SNIP]
>>>   +/**
>>> + * amdgpu_ih_process1 - interrupt handler work for IH ring1
>>> + *
>>> + * @adev: amdgpu_device pointer
>>> + * @ih: ih ring to process
>>> + *
>>> + * Interrupt handler of IH ring1, walk the IH ring1.
>>> + * Returns irq process return code.
>>> + */
>>> +int amdgpu_ih_process1(struct amdgpu_device *adev, struct 
>>> amdgpu_ih_ring *ih)
>>
>> I don't think we need this new function any more.
>>
>> The check if the timestamp goes backwards can now be done inside the 
>> page fault handler.
> Do you mean to merge this into the original ring0 interrupt handler? 
> Then we need add parameter (ih->overflow_enabled) and process two 
> different cases in ring0 interrupt handler, I think that is not good 
> to maintain later so I want to separate them.

What I mean is you don't need any different handling any more if we use 
the timestamp anyway.

Just keep the last processed timestamp in the page fault code and ignore 
faults when it starts to go backwards.

If IVs should be dropped or processed as much as possible is depending 
on quite a bunch of things and should probably not be handled in the IH 
code in general.

Regards,
Christian.
