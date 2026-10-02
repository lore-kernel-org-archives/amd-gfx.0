Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 006CCCA5FC4
	for <amd-gfx@archiver.kernel.org>; Fri,  2 Oct 2026 16:13:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6ED3210E623;
	Fri,  2 Oct 2026 16:13:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="HiLJuVqh";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011053.outbound.protection.outlook.com [52.101.62.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3B5BE10E623
 for <amd-gfx@lists.freedesktop.org>; Fri,  2 Oct 2026 16:13:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y/BCXY94vAQ0x9IQoPQgljVXfg5n+Bk8QAZYQXlrNucCQEg6IjvFV2lxLycZS1422yjapTCnBRGsesBDDDcFlTpxB1fIjq1wXU35lmOIMDRBDa9tRCHLI53guCDRq7afsH83bBUhf02PamgDBgckAd6dEGxlOvobdG7lD6y4WROlp+Kf0/R2vzNvrfaeZRd1RydNb9cOfvCVug+uCh/2sXrFNlw46IoXTIpL+Jv2BtrwdEJnHcXBK5kAfCKBk+niWYT2FFMw9UfjPjvtgJ0fiH22E53HZlohkFMxgGrR7Bh+pJ5SO2qKJAd6u/Kw9EozaUWs0vmm4qrKU4xP8kpaiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BSzPbeGK213bvABY9acxOLPss2fOBTTuOu1cQ3iBwhQ=;
 b=i7JIDJDvI/ocHIl7QuDQJGfRy3vpxKw2MOeEwn0y8+Z8josXjP1ShrBXwNwj93phaNcwNLwEKf5JcD0QtEO9ZbwyCNaQvz5EHJ3I+kU90+hT93MYOQfvg2sam3Ahrx2Xx2qmYMEijuZj7ASO1uPBgP2fofooCMWlAbwqvNabKa2WMd/L/6suu47M5HiYdmJn2fZ0r3tUgNWomTu+dYQEC/Bl1n051z6jTYrGrSmlEnJ+XGX4hr4yV7Cst6VVESxMyAGVW/U9AUpw+Ehad9pf40BzEEAqPrtY+O3O9sARcjPfBuRV7s0BNI5S+HNzVGaldTGHj5g25F1YDR4NYppvNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BSzPbeGK213bvABY9acxOLPss2fOBTTuOu1cQ3iBwhQ=;
 b=HiLJuVqhkAzvUq2j0NC2NKSS8PoKtq5KPWe3Eyx8bf76TDKlmQOM9puoXhshvO6MlkIB6hgVhWtzIBdJGAA40pGJ0lEqlnGHOkbqi7dq7ldGnzPK4FeRyCvTuO0iZgZ6bJjeQyJxsnMnYDBgvgm1uM9DsFjM++N+h/WyE5c8mMc=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB6914.namprd12.prod.outlook.com (2603:10b6:510:1cb::21)
 by MW4PR12MB7215.namprd12.prod.outlook.com (2603:10b6:303:228::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Fri, 2 Oct
 2026 16:12:13 +0000
Received: from PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000]) by PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000%7]) with mapi id 15.21.0472.016; Fri, 2 Oct 2026
 16:12:12 +0000
Message-ID: <2b4560f5-3458-4218-89f7-509c298b2126@amd.com>
Date: Fri, 2 Oct 2026 11:12:10 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: amdgpu causes boot failure after BIOS update AGESA ComboAM5
 1.3.0.1a on Asrock X600
Content-Language: en-US
To: Alex Deucher <alexdeucher@gmail.com>, Johannes Stezenbach <js@sig21.net>
Cc: amd-gfx@lists.freedesktop.org
References: <ar-GzWfyQMeRTRCt@sig21.net>
 <CADnq5_ODecWYOwbBYDnV-aeAi+pCMoxJvufuzY8_4yf5cF0dEg@mail.gmail.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <CADnq5_ODecWYOwbBYDnV-aeAi+pCMoxJvufuzY8_4yf5cF0dEg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA9PR03CA0027.namprd03.prod.outlook.com
 (2603:10b6:806:20::32) To PH8PR12MB6914.namprd12.prod.outlook.com
 (2603:10b6:510:1cb::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6914:EE_|MW4PR12MB7215:EE_
X-MS-Office365-Filtering-Correlation-Id: eb8a08f8-b724-4d0e-6539-08df209feb0e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|20046099003|10067099003|11063799006|3023799007|18002099003|4143699003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info: 2MNWOsBm/ertVi0lboXwf1gr94RHAnAFHIb2Y6J7BtxZLfVM2+xo+pu6/xhZw9bkJ9vbNorIVA2AK/ShlE7JSWdY+BVDkKnc2VFJ+TxP5kOXV66lE5LHDkXGRvEnpEUMAtBdYhU2KMtadOTEHW2dBCirFm4gf9Ki6hQpSGGJRLVtUvP0k3z0gSHlB990Hf+HFl/N5qMb7X4sk8kMJ5+nc45YEU3AYkVGnKn+P30Y+m51r9TaSbuXIUF21rlbO+DBDkNFRmAGzCW/IvnSyMRUZFVwCOo4PAXIsJJGuc2+FR1m9dRjGMh4+15Ygep3nJtJJ9PuwqbJNcV2jR86DOwFiBbveeDcvsf6/FHoIL80ZLw8Uw0a5+/FXy5I9YXjgv4vA/Wl8P2D0GSoUekqr8um9Xm3I7LUT/ZDsgfgdqTxmTbpif7vzxT+JchBQ1nOGmFNe7GmZzqgnoYXMfGZcNOgmFeRRs/6rxtTcN9uFopl+B6QHHZXRWIg8hKvqaPWcZgZxzrg/No79ciDJHCPE8UGdvuMDnvYMrj3JVXPalWg8/R0PwUmHmicSGcS0+JRlRVWI4i8bheItJG8hk7UWenJi3kVBOa1QJ/TD7KtLTldj/jjoHYEjxSErh09sNFjLaC0
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR12MB6914.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(20046099003)(10067099003)(11063799006)(3023799007)(18002099003)(4143699003)(22082099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dmJ3R0YrNHpFb0xYdDAzcjl6SURxOHJKYytheFdrOUdoOHZmOURMNVlEdHU0?=
 =?utf-8?B?cUxVaWlUTXZvWE9CdzJGa3pWU0FGaVdQNS85TG81cXBxc2VjQ1pBZjUzS3BE?=
 =?utf-8?B?cVZkNkNMT24zWlZHbHZyZklOUUZqSzNWZm9XUTlhUnJ5cXhnbkJnR3dBN2d4?=
 =?utf-8?B?elovYTQwaUtYbi9qcjY4bGE0aHhoNkhHRzIzMXN4YU9hSkQwajIzSElCQmZQ?=
 =?utf-8?B?Z2ZWVC9XYUpIcXJHckNUM0dFTlR4bVRlaktyWkxrV29MSHkyU2ZRYkZmakRP?=
 =?utf-8?B?anR2NjQwWTZwM3pWUUZUazZLZjRPTlk5RFpZb0ZPQmNaRUU1bld5V0p1TFJm?=
 =?utf-8?B?NmNvaWh4MW91NnRjbFh6eWxHVTYzUFZOb3VqMkg1K2F1dHVGOExoYUZ4RmNI?=
 =?utf-8?B?ZmlUVmN3TUpBOTNHTTVJMWZsYWltZzl5UXF1QTNob0haempScVRQcndsWUhm?=
 =?utf-8?B?QXgzTVRmK1FXdGYrV0dPNGlsU05sN1BGT0dyOTJ1eW9OcFVudW1kek9Qd3VX?=
 =?utf-8?B?VjJ0bFZzRUNESTFaK0hCMVNteTRuQm5FTmI3SmVqRVZZZGJMM3phejRIYTdK?=
 =?utf-8?B?aG1iV2l5ckpLRk5oTTdZbXFjQ1ZIYllzZERJRXEwVGJLcnJ2QlVGdnd2RXFX?=
 =?utf-8?B?MzlqbEJ4MGRsYmFobWpvUm5JNS9YaFhKRktxZVJBV3NXTWZNM3F4MnlIejlm?=
 =?utf-8?B?N01OTG1MdmdGeW5KbHlPbnpid2FKNWlYSVNKRjlWcU1aS0l6V3YzY3hBMGNR?=
 =?utf-8?B?cFc2aTdqSjIrdTNzT2hkR0w2ZkdBd0VQYk1jbUpJZFBMOHp2aW40WFM0SXZu?=
 =?utf-8?B?dkg3ekd2T3dhaWVQSU94Wk4xR3FhNVVoYXJQQjV3TXFFWVQ5Y1gwaDdrNVJr?=
 =?utf-8?B?T1pTRmZxd0VzS0pubmE2ZjNGdjk1Zk9JM3FXckEyd0hqVDFwZUhWQ3cwYWNW?=
 =?utf-8?B?QitYRDM4NVhhcEM0cTBHQWxTL1FCM041OGJSRjhZcndhUFY5bkMyckJCeGo3?=
 =?utf-8?B?bkpuRjU2S09jMFI1N00zS0JZVWwwTU0vUWdIcHlsWEJHQ1ZVTDZ6cHpNYmJs?=
 =?utf-8?B?bWIycXdoS2F4SU1qbUtTeitzRndYakJ6VWRSdUh2aWdZbkVVaXhrdGdMaldX?=
 =?utf-8?B?UmFxWTNKVm16THJYczFDMW5lNk5wcFhXTHFONUFkVTJyditnZC93WUV2QnRJ?=
 =?utf-8?B?SUFCWDVORTc5NlcrbmlMbzBPV0FSaTNScDMxVmt6VjR4Qmw4ZTgxZUdZVnE2?=
 =?utf-8?B?ajhWUHVFWVBEU1hRaU5MNWI1aXFqMTQvemVyUzVqNzlmellBNHlYTzZZZHEz?=
 =?utf-8?B?ajVnR0pzNU5uWTI4MnZGSmZvTXpoN25iQTVKOGNRVVhhUjJlcVpQZU1zaENy?=
 =?utf-8?B?SmVkcnJDL0V4cnF1OHBWTjdSL3F6MnZVVUlmcTRveHpoSFY4WUtrY1ZyaGtO?=
 =?utf-8?B?NGxIZkVkRkcwL05Cejd2K25DUE9oSTczVFgrdzI2MXVldkdmVi9rZTdmN2d3?=
 =?utf-8?B?MU1RaG9tNVRQVFRpaXZnSnBodHkrVitZL3crdVZaK2xOTzdwSkg1bU5GWUZW?=
 =?utf-8?B?RklHcVBZeTRDV0MvcGRsWHpsOFI0dzVrQTdFZXhzNkxwUjhYR0dnSit2SXpu?=
 =?utf-8?B?Y1hBenRmZHY2RzcvMFN6M08yWUJ1N1BtYy9aQ2hkZzVRa04xdnJQMFRDenp2?=
 =?utf-8?B?RU5LUTFRRWUrN1dQdjNFUzhjUUFiaHo1cEt3NlB6V01rQWNyWlhlY3BGbkpx?=
 =?utf-8?B?UDUzNzZHY2FzZzhHMXRwVks0d1ZBcDlpWkJTd2hxOTQvYmJMQkx1VUd0WDk5?=
 =?utf-8?B?eFI5eVdrQjFDbFdhSXBURkdvdzVPOS94RklOdlQrdnpzMGU5NGlFSE5ZOGNO?=
 =?utf-8?B?QWRxdExwZXBuTVNXaHloaUFpQTVNOTZ6WWNQdzRoNXpTWlVwclAvQmswd3dy?=
 =?utf-8?B?VnZrRnVQUGZBNHZaQ0o3ZXVtVlM1WVVrMDBTOWU4d3o4WEhaL3VESGthRVpW?=
 =?utf-8?B?UEVTakdpUXROeUNZVTRyWklHdmRCMEgwWXFaeXRpV1lrTVV3MS9YK0UxSG1M?=
 =?utf-8?B?NXlxMXVyZitEMW1iNVFOMHJVMFV4S2FCMEsvY0s5M1FNaytyMmRJODlpcWFk?=
 =?utf-8?B?dEpkdmp0V3FCNW5CQXNhSnM3ZHZWeTVHN2pub09nNmxXZE41eFhmTjF6M1E5?=
 =?utf-8?B?eXhnU0hSL1d2bWRJZmhIS1YrMk9DbkpObUxkaGowTnB4ZEh4MEVhdGkyUldz?=
 =?utf-8?B?ZVM4c0JYYUg5M0xoRyt3amY4cjI0Vk5PeERWeUdZUUdCcDFXcEtTQnh4Z3NX?=
 =?utf-8?Q?9UFISObX1N0Y7AlKGr?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb8a08f8-b724-4d0e-6539-08df209feb0e
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6914.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2026 16:12:12.7782 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K7IvJbNGayEnaCk5oeG+YZw/2vr1Ns4o+YuOXoZnF0SkeaRgiC4NR1eoVC5e7OevrfSTORx45xNvcxOiNlx36g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7215
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



On 10/2/26 10:47, Alex Deucher wrote:
> + Mario
> 
> On Fri, Oct 2, 2026 at 8:52 AM Johannes Stezenbach <js@sig21.net> wrote:
>>
>> Hi,
>>
>> I have one Asrock Deskmini X600 with Ryzen 8700G.
>> Recently a BIOS update was released which updates
>> AGESA ComboAM5 from 1.2.0.3g to  1.3.0.1a.
>>
>> https://www.asrock.com/nettop/AMD/DeskMini%20X600%20Series/index.asp#BIOS
>>
>> The result is boot failure before any message could be printed
>> with my self-built kernel, which has the amdgpu driver built-in.
>> However, a Debian rescue image with kernel 7.2.8 could boot
>> (in text mode or vesa graphics mode).
>>
>> Using the rescue system, I installed the Debian kernel 7.2.8,
>> it can boot but hangs after the amdgpu module is loaded
>> (no error message or crash output).
>> It can boot successfully with module_blacklist=amdgpu.
>>
>> https://packages.debian.org/forky/linux-image-7.2.8+deb14-amd64
>>
>> If you have any ideas what to try please let me know soon,
>> otherwise I'll have to downgrade to the previous BIOS version.
> 
> Can you get ssh access to the system?  Can you boot without amdgpu and
> then log in remotely and manually load amdgpu and get the dmesg
> output?
> 
> Alex

Depending upon how early it hangs, anything saved into the journal from 
previous boot?  You can try:

# journalctl -k -b-1

Also; what is the version of your DMCUB 
(/lib/firmware/amdgpu/dcn_3_1_4_dmcub.bin.zst)?

You can use this script to parse it:

https://gitlab.com/kernel-firmware/linux-firmware/-/blob/main/contrib/get_amdgpu_fw_version.py?ref_type=heads

If you upgrade to the latest upstream version does it help?

Thanks,

