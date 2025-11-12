Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6EAFCCF9E3
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Nov 2025 15:03:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 68CC610E74C;
	Wed, 12 Nov 2025 15:03:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="e3z2/tfv";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012062.outbound.protection.outlook.com [52.101.43.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AB64910E0A9
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Nov 2025 15:03:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D+i/6QgmrfIQi2ap8UBHaiNANEhjWYP5PAJby43f6qg8zy6mkCIGCSQq5UgTaQt0g8/+5kILINUTG8q+5kvB3JSMydHxXGTBch03xKzaYsvZpixkfwmki6lHT5fVYkvJHvfSTxQ8eZmull5JxIYNON/keHsab8uH20RFADWTXlbgeo+nguIBGB5zYOm0ZBOdpsHNDrfNsIaDzlhXVuBXznx3hbSjEHL5kriCLYwsmrBLPy5JAsrTNH0KEJVtAxm4NWrlRbIep9gmPyiqrEqJWXUx5aqDzlUWMLdn8X+gV+QXkpLRKXbMYAWqoNluVdwChzK4KW0HMpbUXFBTK9PUZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FgV5L2PcukGojqYfYLzqjvjOFIDqMhHEJ5XZeqfuGGc=;
 b=yLPlHcFb82Io7DNyqMInbfgoSc2dOOwCdxHtoLFn3Bhvv/wL1Pbx+i57eYjc+v8Z8y6xnX2QG9c1lvto1UCl0cFl9G6OhW3r8K67SjfYNC/XKxFjHMQFVcKk4RdwfWE6oYSdL+Oo5lO4vsIwdtMcemcR4Oz17SlfC9vwQwxh2L2nhKKZ93OU7eTXKkxRZy3Zp5I/xFu+jWhYURM6l4CofFy4VPj/LrCoUuZInuQwc21f3E4f6AiqHR1MijzduONy6ajOBESBHchbuOHjpeq66ue31G2z0loLYPrlfJTYXssPpsjNyFhxWS4pKXqfPeMOqeQ3cdzVKDEmX1ZHkY4RVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FgV5L2PcukGojqYfYLzqjvjOFIDqMhHEJ5XZeqfuGGc=;
 b=e3z2/tfv7E7UXiFgGXR2fbnQWNg8DfJtIkCAXPzUMP5B7JZkmZ0my7fOXoTO6UMeKPHY6WjhBTkcgTg3ihdGtSSw7HnmwgysZaPDVMSOOF7uLFl9RtZzAWCwp8EeBsl1b+qkwQBcbCN/loY1WMikuBAeyZ94aXLFgdkqU+aBsv8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by IA0PPFB67404FBA.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::be2) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.15; Wed, 12 Nov
 2025 15:03:35 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.9320.013; Wed, 12 Nov 2025
 15:03:32 +0000
Message-ID: <931c33cf-26cd-4d23-827d-8c61f9028ca9@amd.com>
Date: Wed, 12 Nov 2025 16:03:28 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: Bug#1118349: dpm broken on Radeon HD 8570D
To: Roman Savochenko <roman@oscada.org>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 1118349@bugs.debian.org
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <epyf7tdz3azb3fflb6rwuhax7mpccmqlsmzqqe2pcm7mxrdur4@zpx2uo5pvoqs>
 <BL1PR12MB51448357F3CCE2B2F9D346ADF7CEA@BL1PR12MB5144.namprd12.prod.outlook.com>
 <176078292467.2932.7155687538828443067.reportbug@home.home>
 <f689f22a-f53a-435a-b79c-d79b4cfd810c@oscada.org>
 <2qxsyt34y4gmwuxwyvs7qh6ekypair6mt3h7n5txdhletjnpsc@vygqxoo7oacn>
 <e0d85321-733d-4b89-ba5f-5efd5f1b18ac@oscada.org>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <e0d85321-733d-4b89-ba5f-5efd5f1b18ac@oscada.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN9PR03CA0248.namprd03.prod.outlook.com
 (2603:10b6:408:ff::13) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|IA0PPFB67404FBA:EE_
X-MS-Office365-Filtering-Correlation-Id: 696fc10c-a811-4963-9bfe-08de21fca55e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZGpHMjVyYlBldm1HTjd5c2U0K0xid3EweldscENqeWJqcDQyVXVCWGZwVUVm?=
 =?utf-8?B?MkZ1em5oaVprOUJnTVpjUlRhbnp4NlZKOHl2ckFDNTRTNmVuWFJlUnFxY21v?=
 =?utf-8?B?czFNZUkrcmNrK0Mzb0d2ZEZFa3Y1RkxmbkJqbktTL05TeldvK1FPL1oxK1NT?=
 =?utf-8?B?RHZmbkJGMVdsWVdVZ1lZdmp1R1dEbzhNS2JJYit2clpSTUVTZ0pHbGptN0hM?=
 =?utf-8?B?cWgrdVY1eEg4RkVGYUh6aVhGTUU2dkhneVpCTDVITWNrOVdJU1lhWFJIc3RX?=
 =?utf-8?B?OWJnNFpXeXhMamhzdE52aFgwVnYyR1dyc29kRzRDekVlTngzczVoa3Nnd2VY?=
 =?utf-8?B?MVg1SFpweDNlQ0g4L3NLVWFTR01HUUxVanc2NWg5OWdiMWh2enQ4R3Fjd0JL?=
 =?utf-8?B?TGR3Q3B1V1JTOEIyRHZKSTJMSU5icWs5djFtbUVPUHBSWVhyWnEyekJlL2Y0?=
 =?utf-8?B?cWZQS1dwQVNKZHY2TCtZV3JoK05oR21LWXUvcjJSRkFaWDEzMCt0ZjA0enQr?=
 =?utf-8?B?dzBjUHNuTGY2dEhxTlBCVTRJZzBZSDVPM1BtSk1vdmJHZWRPbkFXZUxrbldY?=
 =?utf-8?B?WTdiUG81OWh5VXV5VTc0OWliVlNuQm1WbnV1NjZzdm4rM2Erb0p5WCtmUWM3?=
 =?utf-8?B?LzR1Z3o2U1VpaEo4OStjcEUwVnVqbDFMY3Bzcm1nNTIxb0xTeDhtblVLY043?=
 =?utf-8?B?R2RxWHZUcGU0c3BzbVpBMDZsQmNPVnNnY25ublRjMDBQeFZwcUlnV2RsK003?=
 =?utf-8?B?ckxIUndwTFZoSDdRZ0RHMGhsTXNMZWowbVZaTmgrZ0ZWcVFRYUt5a0cyTkMz?=
 =?utf-8?B?OVl2UjQ5Vzg3dEx6bEdKcXI2YWQyeW9Oa2wzaU4zdjMvUEV2SkZsTXhOa3kr?=
 =?utf-8?B?WWJSWDZyK296eXA5YS9STXhoSnVreTI3NlFUQW5HaFFSaWxCS0hHTktmSEdz?=
 =?utf-8?B?YnpZSWpyMms0L1VTL3RYajNZbDNPL013Q0ZmTUNCWjh1bXJTUGxkT2ZCOHRB?=
 =?utf-8?B?STI4U0dSMGNlejdvNExNaFBqZVdtL0xCRXBvQnN0U0pTMmV1TWtVWkJmY2w1?=
 =?utf-8?B?MjFUK1YyTWE3NFY5SFk5NURaNVhYbUw1cUI0U2pBSlE4eFNiWmM4RllUcTdp?=
 =?utf-8?B?aTMyK01VMEJBRStiY05OR05rajRGUnYxTDczYWJOc3Fpb3ZoZTZQTTEyZWVt?=
 =?utf-8?B?S2NwMFpBUm5MeUE0TGl2UmQ0RG05dTVNMmhkZkFDaG1RM2grMnBCak14Ykkr?=
 =?utf-8?B?aS9BelJGUjlaWTlncGI4Z0hTOFc2aU9NN3BmR05LUG5WdHZac01PekV4Qlox?=
 =?utf-8?B?d0pBZ2pBSU82MFAxR3V4eklBQ0xzdXRSVGhXdTBCRUU4NjZnbkREeDJSVXdi?=
 =?utf-8?B?dDBqbDlKcEE0Y1VNT1F6dmM1WldDVXUvcXh0WUN1elgyS00zYVdBS3Frbll1?=
 =?utf-8?B?M2Nod2ZwSFVQMk9xSm90c0lncEM1bWNacjgwYVBOT29OUTZNclVHTGhjQVVi?=
 =?utf-8?B?Zi9yN3VqcmFEZVhFczM5OU5ZeGNjSUsyR21sT0dTZFlEOWJuOG9pcklZZksx?=
 =?utf-8?B?RzZRYXgrZktHYzVJUkdNejJUT1VGV1JlNndIY1EyeHRkek8ybFFxYk1Wdjcz?=
 =?utf-8?B?T09QRXZKbUpoTkcxbWNwWHg3UzUyeGYxTnp3TldCVFo2TUxFdjBjanhNU2Jm?=
 =?utf-8?B?Z08wVTRLRTJ2WWpna1hMSjREeWgxLzZFUkZmNDZ2VnQ3NjIwd3BPcWRKMDdN?=
 =?utf-8?B?OUtVR0lJWFluaU1vdFB5eVhRSmhVUEdhWjNRQytrTkZ0S2RoSC9laWVvL0FW?=
 =?utf-8?B?OFhNRTJadXBvdE9aNDJ6bnNmYWtFc1VHWnNzZGJNSnBrN3BvSzJsMWFXL09C?=
 =?utf-8?B?WktLYzV2R2NVS3hWdEl4ZCs3OUZSMXREa1ZrOUxkV2pYOGc9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?blpQRnVpTzBMNFBUQ1RZU0dQNkV2bHlpK1YxQXZvYnVuMFRvbXFxTE9hNVJn?=
 =?utf-8?B?RTVoT2ZnZG1hVUp1anBUcnhsTnprOWJtM3BBVmxTL255by9qcmJKRFptYngv?=
 =?utf-8?B?UlFZZ2NnREZHVUcxZ3JwZWI2WG9nZXJlZE5UODJzVGlzNzE2c0sxVTh1YXFn?=
 =?utf-8?B?VFN0MkNSNGpzVVlKUHRaL2h2Slg3dWY2aThtTk9rYlJYcUMvd0Z4b1dCZG1D?=
 =?utf-8?B?Q0lWL3ZuZVpDeXpnWUpwVWZBQjdlRml0UWM5eHZLYXc1RGJwcVNDT0FWTW81?=
 =?utf-8?B?UmYxVVRlQ0orblBSZHZDU2JtdXF3OFpEcGNvRm9SZ2dLWW9DSitGdHdNejRr?=
 =?utf-8?B?VnRqVkdwcHhmOWVKei9JZ1d0V0ZxMWxMRG5BT0VJUnFOSHZNYjFRT28zNmVZ?=
 =?utf-8?B?RTVacmpTd0FQWEtsN1NibklEUlV0NS95RWZKWGdFVy9KVjBscXNhQXdpeXZH?=
 =?utf-8?B?eGdOZUtWZXdNOUpaU1RQcE5aVUE0VHkyNGVMclNlT0pWVXVvR2tsTmVRVlBP?=
 =?utf-8?B?OHhpSEEvK3BoUkRrQmVtcFVFcWZ2UmRLbE05ZE03THc2N2VpN2xkSGxKNE1O?=
 =?utf-8?B?YUYrYzlIOHRlTXN0bnk4RVpJamhNQjJjc3A1MzVwOVdBVjMrMVcrTWdxUFBO?=
 =?utf-8?B?Ry9IL3JYNzRqZXRvYldielc5c29UbVR1bEVnejdMdUJ3RnhaTVY0K2tDTWxL?=
 =?utf-8?B?M2crYnBlaFR4TkVaMGFxNENncDAvUDY2TnJPd21KcVQ0VE80T2RrOGxjMjVS?=
 =?utf-8?B?a1ZqdHR3dVdxR3NUM1p3ZlFTalBqMVlHa3BUTndrU2VwOVB3c2xtQlJPaWxN?=
 =?utf-8?B?YU1tdGVQdmVSWnc4d1E1blFTRTdYZmJTeldiOGFXUzh4NVV3bXJRSlk5eUFs?=
 =?utf-8?B?T0dBV0hSN1NSV2dpd2JucTgzWURtMlNsSUt5NktSRHBEYWVlSGNxTVVySFZE?=
 =?utf-8?B?OC8vcVk1cGJ3Z3RzTUFGTTZvcncwVVdjaXg1TzhndUlVSlg5OWY3YjZJZzJk?=
 =?utf-8?B?MWVkbDZpZlR5TzVOaGp0T2lEaEMxYXJwY1pWMThma3pMMmlhd1MwWWorWFF1?=
 =?utf-8?B?TU1WeWRZa2g4T0QxWmRYQWp4VjRZbHpsU0lRODBBNi81bWE4SElrYjlBWFFW?=
 =?utf-8?B?bjVRVzFFNm43WGtid0lram1MMitmUHd2RldrbkdDQ09aTFFVTVVJemF2Z2Rv?=
 =?utf-8?B?b2plYmVFeUtNa2Ntd1FQeVFnZjFMMCt0aHJUOExNaEY4aXNyU0Q1ejRXZFV4?=
 =?utf-8?B?MWo0VkluQStHU0d2V2VobjN1dk1zaEN3UXNQcWUraXpwaDdWSjNMdDJYbVpx?=
 =?utf-8?B?S2ZCNGRKazQxZ2M2cnZOdmlwVkxsM0FTMXBTVUFTSy9QWHgxbWhWTkhWNFVJ?=
 =?utf-8?B?MXJHYm9MR0paU1BTd014RzJUM01wVWRvN1VTcm5hcUs4WTB6L0FyZXRUVHk0?=
 =?utf-8?B?TUdQdUJNaFNKcTZYREhRS0Y2U3duenhPekFzNWVJdFFxeGFmamlueThVMVpI?=
 =?utf-8?B?enJRaDNkNHAvcXdMZ1dyYStIaXB5TnhjZVJDbFlRZWtZaHd6eVNEQmJxRE4z?=
 =?utf-8?B?VVYrSmszSXp5d1BoUkxFLzNjNXBYeFVLZ1VVM29SYitEeXVEQUxOSGd1M0FK?=
 =?utf-8?B?UkF4N3hTWmR4bm1PajNGY2ZBYXBMN1BKakRVNTVuQ1RwMFNqSEtrdWNxTUhR?=
 =?utf-8?B?bzgvQ25GWDNxdEhjSmNRNVc3Uy9Nb2xYOHRrbzBvakc4VnAxekFmMTcvSTFC?=
 =?utf-8?B?ZUFHREJjbS80ME9LMmdSZGRWQUhTOHJTVkRBakxURkd1bDU1aHByLzF4MWtj?=
 =?utf-8?B?STk1RStzd2dyWWVLeWx2Z0JNQndCWTdIdnd0L0pGNkdRN051YVQ0U0xma2xL?=
 =?utf-8?B?NmpNMmUvdG50elltcmxxbytHcE16SXBzWWtIWG5hV0VyUzc5eXN0eThlNmc3?=
 =?utf-8?B?ZjFjRHRoeDBITTVUQkVJNkhpRUdWYzB6YzErZk5VeDkxSDBaVHlRRGc3NDBw?=
 =?utf-8?B?bFl2bXIrYlZNTWpFNU4rOUZjTXloR1NTdWw5ekFieTFTZWFwcjJES0tZRUpl?=
 =?utf-8?B?dlNmQVR0OWFRVlI0K2ZGY3lMb1VzVkVTbTJBUFdaLzZHaXQ2WTBrUWR1R1Jz?=
 =?utf-8?Q?yqGShoBxQoEe+fa4ZAFMQC0WJ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 696fc10c-a811-4963-9bfe-08de21fca55e
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 15:03:32.5527 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Tq8r10JyUhf1za/r0gJhPvjRKA91U/VCgaSkL3bKg2/+gLQyPRiLlUIVDai+HGLp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPFB67404FBA
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

On 11/12/25 15:28, Roman Savochenko wrote:
> 12.11.25 13:14, Uwe Kleine-König:
>>> On my hardware that doesn't work and there is no specific.
>>>
>>> Now just I set "radeon.dpm=1", I got immediately restart with disabling USB,
>>> so I have needed to restart for successful download with "radeon.dpm=0".
>> Can you try a different monitor?
> 
> I have only one, connected through DVI, and there is no problem on Linux Kernel 5.

Kernel 5 what? E.g. which concrete version number? (output of uname -a).

> 
>> Can you try which Debian kernel was the last one working fine respective
>> the first being broken in this regard? You can find all kernels on
>> https://snapshot.debian.org/. Please ask if it's unclear how to do that.
> 
> I can try all kernels in Debian starting 7 and finishing 13, but I have traced that before and the problem reproduction started from Debian 9, terminated on Debian 11 and renewed on Debian 12.

How keen are you to compile the kernel yourself? That is usually relatively easy to do and git has a bisect command which allows you to pinpoint which kernel patch actually changes something.

Regards,
Christian.

> 
> Say which Debian version you need to try.
> 
> Regards, Roman
> 

