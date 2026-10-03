Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66F6ECA5FE3
	for <amd-gfx@archiver.kernel.org>; Sat,  3 Oct 2026 00:18:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC47910E6E6;
	Sat,  3 Oct 2026 00:18:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CAC8uJfc";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012018.outbound.protection.outlook.com
 [40.107.200.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B989610E6E6
 for <amd-gfx@lists.freedesktop.org>; Sat,  3 Oct 2026 00:18:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kzLsz/EA+XKzNwzRihL1jXhOluw6rxoT42NtMGux2FfiKU9Jrqcul8YHjNMfxPqvo4ORKs0OWmhbhXlDxzX108z72xPa5NcTBgvq9qf2uLl6Z4xCBqYFGPTLPfWz9sPEL54YVls/owLBXkcPqs+nKkK3Ke4ytMd6tvYSl77NzXh/XjZqkCQD0ZY+1EQYGst3CTswkXnmaHgMPX+JtE9Yke9/S+L2DSIrKwLsbmqRpICTF84IZEhtAPaRIDIdN4XA7EFaOT4mmj81nDXHintqLcceyWqUKK68Hsmr4EtYbBwDVuWiapFQKGshrvYEoER4xBt1rAiutPrnZ/HIJRJS6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IuxafkauWSqjA/MzQPy0amErPcnrVulykTeqE3AEqJY=;
 b=E+a26dOTWLHqeAiNMQlHJEWD0NVouNRiSiedBEAKpsjmgoLN0smBYtxfuRVV7E9saf4UVK2BqGZMJiq3SomA9xIRVNihf2lfNjOCqyy4rag1K8FwlFPa66S7g2NGPULUi/CMOFOHv3sB/G+onxsMeA85EDV3BVPYw9WLqK1hK+dAn/TJl0XdkbBG3i/xfANoXXFbux7nANyEev20QYm63HKUGjZBU+4xEsDW2aBEyMn7onLb+74y3Agh4ud/KzQpOkidQ2sASPMNugyp7r47dYFuNqK1i5/cC0fjyQbaRRkc7jlXglE25AjJ4LS/6qab1ilEniBmESFr10cnPjxNaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IuxafkauWSqjA/MzQPy0amErPcnrVulykTeqE3AEqJY=;
 b=CAC8uJfcP6rRm+93VvGdv9b1ByP2lBsCsvSNXYA2jX4ZZmZk/rN/eBAzuJYp8UlkZEZerrf0IjjHJBUHl+32YBMmjQU8Vr7ZluXmIYG0XKtZegs2dlj5Kx/Mxx8LlkAIFQFL2rXDUEmq6g3xChFqbXaBV0O+45pgTzr+MhXDJVY=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB6914.namprd12.prod.outlook.com (2603:10b6:510:1cb::21)
 by SADPR12MB333558.namprd12.prod.outlook.com (2603:10b6:802:101::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.18; Sat, 3 Oct
 2026 00:18:33 +0000
Received: from PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000]) by PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000%7]) with mapi id 15.21.0472.016; Sat, 3 Oct 2026
 00:18:33 +0000
Message-ID: <4a73247a-a3b3-4858-8678-b3da485b5b06@amd.com>
Date: Fri, 2 Oct 2026 19:18:31 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: amdgpu causes boot failure after BIOS update AGESA ComboAM5
 1.3.0.1a on Asrock X600
To: Johannes Stezenbach <js@sig21.net>
Cc: Alex Deucher <alexdeucher@gmail.com>, amd-gfx@lists.freedesktop.org
References: <ar-GzWfyQMeRTRCt@sig21.net>
 <CADnq5_ODecWYOwbBYDnV-aeAi+pCMoxJvufuzY8_4yf5cF0dEg@mail.gmail.com>
 <2b4560f5-3458-4218-89f7-509c298b2126@amd.com> <asAFItSKC74Lm9mT@sig21.net>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <asAFItSKC74Lm9mT@sig21.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA1PR02CA0011.namprd02.prod.outlook.com
 (2603:10b6:806:2cf::28) To PH8PR12MB6914.namprd12.prod.outlook.com
 (2603:10b6:510:1cb::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6914:EE_|SADPR12MB333558:EE_
X-MS-Office365-Filtering-Correlation-Id: 68eb51ec-bf13-41d1-3b17-08df20e3dbcc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|23010399003|1800799024|260925021311599003|260925022911599003|10067099003|260925021911599003|56012099006|11063799006|3023799007|20046099003|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: XTLBoVzVFxiOqJBmNdrYH4mIErmAKvC7i9qRzJtafqAYWQIC7i2FQ0OYwNNIiKwgxsWMe3NTEo7cxKN55djEiKzcl1ya5Do9RmGoyvO+q5eaYh66FtbJRe18SbcGOouP/j1W2piS0kXiRaHis+oEnanm7tCrhf4w3NyPTP8WB9OD70pC9Xvo9XDPIzCWDGXRZDNDoqUPbBBoMNziPDmciFqgA/jufVWWJhzbkP2mcgTnBm4iPROhhzMeias0J8gL7AZIHMzXdYFdkVHT6iG6UdspQpdndbV+8KjSvcSM0LHzB0c1zw0xQ+mMPO2yhEmbg0I9jzTJKbvTTJsY4bfsc9EkN060K15zxFg3UxPE0lgHGHZZb1K4ZMwSeGjldyS/dWUVbVvAkt0ntZMJ4I5zDBQNjRGrsarlyQgr9YbRZBi2bE2Wgj82IFJceWDphM8xxYMshiZe6rKptWgGcq1V4t73Bpy4rLxAdk6SkjjuO0NqJ6hENubjumdP/AYEGz7at8XhugBO9gE+ROaTjmBjg/y5NVQh3+wPSamOZsNhum8H0o0aIXzyO0nz9l5GTTBBKh12+BlQcX8SfgQ9ZgJEfmhQCL8NApdt894+l39WARHtcmvNsetT2N92llltPPM1
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR12MB6914.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(260925021311599003)(260925022911599003)(10067099003)(260925021911599003)(56012099006)(11063799006)(3023799007)(20046099003)(4143699003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d1NmN3BGbzZZYzBscFVEdEozc3Z5c0FsY0wxQmoxQUlCdEYvdlpaOVpnUzVs?=
 =?utf-8?B?bzVWZWRqV0V4RFJJM1ZJYWVUQ01PS01jaE1QcDFBcjZxYS9wd1ZnK2JPRWxX?=
 =?utf-8?B?ZDhXTHo4VCtMT3ZpK015SUNnOTFTbmpkYmZxYWxiQmgxSXNySFFsZSs1TUFS?=
 =?utf-8?B?MkRjY0huQjU5c3ZCeGRWY0J4UmJNbnFqNlQwSm4rTjlPNDBZUy9wY01vMDYr?=
 =?utf-8?B?MkE4eXRDUXpKWVUzVjhYSE9YRXFWcDZjTXZTazJ1bHNjQm4xZncxOVJ3MW81?=
 =?utf-8?B?QllVMjFxRDVyRFROZEJaRy9aa1d4T0w0VFRGVWpHbkYwd0MzN3NWNUw3Q1lp?=
 =?utf-8?B?N0hiVStUVkJpN1p4MWFDZ3NtNFpvL0ViMHlLekNRN2xaKy9NVDlFRW9YK3hw?=
 =?utf-8?B?bDVIRWdQRENLTWtoelhlV3BDVXMzeWM3MlJraERiWlZWeDg3T1djL3UwN2sy?=
 =?utf-8?B?UFNaM0tpR3VmcmJoK2VOaTdibGwybVVxOXdWTnZsU0VuZDM3cnAyMXo1RDV6?=
 =?utf-8?B?TnEvWG8rakNUb0RjdC81OUdPdnN1Mnk2WitGck5uTlVPSlZna3JBUnAzVmZ3?=
 =?utf-8?B?N09CWGthUHpwUERpWnR6c0JKRklIU0ZRakxhQzBlZnBCTWFaUk11ZGtIVlkv?=
 =?utf-8?B?WkEzM0RQL3lSSUF3MEl6b3RWdG04cGZld2IrQ1VLMG4venZXdE0rekExazVY?=
 =?utf-8?B?cmR2a2p1MmtuMFBnVHV3OHJLbVU5K2xqSWs1UGE2dThEeUVPWDJmVmZ6NHM5?=
 =?utf-8?B?Z0RlU0JMOEprQ01Ka2JoUi9YUzVscFh0eHNUM3NaZFBSVEFlLzN1bnJCelNY?=
 =?utf-8?B?MFpQTDFLMVhHeHdZaXd1MGcwQXpaZnByVnV6bGpOYzJodmxmNXMzRjkxUzB2?=
 =?utf-8?B?N1BxWUFKWGozSWFURVRzRDl4SEpmb3BKTXdoRmtidFVpYVZlN0VsZGhLdVJk?=
 =?utf-8?B?a3VZOStVc3d3ZUNoVExpMTErNUpBQUU3VTdNYlVoaXkreFlWSndCdW1reDEv?=
 =?utf-8?B?dFZBOTNRZVVIaTVGaUZ4aDhPWWI1aHVMOEJZbkU0cUp2TUt2ZmRwVVZXK0xI?=
 =?utf-8?B?VmxqekVMYWZVc3Z6cDNPRFEwNzVrR3lEVHd0aTgwZXlBYTJWZW5MdmJUYVRS?=
 =?utf-8?B?WlNScnZBK2pMSXE0SzhQZGpRdlBSRnBoTE9GNHdLNEVKN1cvTDBZWGd1a24z?=
 =?utf-8?B?YUdKV2pud0swWTZSKy9PMEFGUlU1Rmhnd2lmeml0RXIveWZjaU8rbEFJZzVM?=
 =?utf-8?B?dHFoVkZwSzg2ZkZURmhkTWdsRzhXS3dLSFRwSTZMQnhoczA0RVYvRGtoVmVt?=
 =?utf-8?B?K0ZXT1pla2kzUnk1c0tkVnpPWmlEVmhGeTJHa1VLaHBMT09Gb2RqYTZSaVlS?=
 =?utf-8?B?eTErRXJ4TkdpVGtNRVEwREx1ZU1DRDJqSVdhWkcwZElrRTFqWUZZaGNoY3JQ?=
 =?utf-8?B?eDhiMTFicHM4VWtsSzFoVjlwQTdKak9GYTJ4cWxyNTVpU1Q1YWx5blo0anMv?=
 =?utf-8?B?TWJHTzh3THBKTEZzb2thaDZMbmZveE03YzFBUVBkVUNXdllBNWF5VWtqb3JI?=
 =?utf-8?B?U2VWTkRaN0dNVXltSUJxQXZ4b0Zsc1RuRHYzcldBaUhtSlo3VmtLRzRRVWhL?=
 =?utf-8?B?eGFiNWJuL3pXSGh1WjJDSlZaZVhjNWNVWUtvQzY1SnZBbklJSFhZMzZGdVRU?=
 =?utf-8?B?MWdXU1NWTWNqTFZ6SVlyRHJEWVFTTXdCN3B5SDBhM1JtUWh2ekVLTk1RU0Y3?=
 =?utf-8?B?UHNHSDQ0N3Z1ZHA4d1hNTnBOV2hvTEY1WnVsMGNEWGQrVVZDSndxRm5MMVhs?=
 =?utf-8?B?cnFXWUxZcnZWRXZuNkN5NE9xa2t0b0pweDAzNW9wYTlnaitSZ0RqOXovMGsw?=
 =?utf-8?B?YzlTaUgrWDhxQU01Qi9DaThUb0RyMzJsUUtycDNlL0lDa2tEVC9GYllXeUtG?=
 =?utf-8?B?RHhXeXE2eEhXZTkrRG5aclNYZ1VNbnk4QUh0V3NoNzVzNmx0czNKM09hZElS?=
 =?utf-8?B?QXYrbEFaVVNUYW1xRjgxWGp0VGpnZncxS1BraW1xd1ZIU2JkYWtwaCtMRnI1?=
 =?utf-8?B?eTJoMDh3eVd0akpvb2VMdG1jL08vTk10aWFNaytFTGkyMys5akdSRFlkVUM2?=
 =?utf-8?B?UStkN3FhWUJla3RzNzZtbzk1ODQvenBlczk2UVJZTjRKWUI4NjQrZU90WnV4?=
 =?utf-8?B?cUZsc2h1b3U5QWJtN3hZVk0xZUh5Sm9xQXVNWGpya3FXeWJQMzNkQ0ltNG43?=
 =?utf-8?B?VG8xVlVmOHpLM2lRZVorTFFEK0owMEVRalJnNzFGSTZIZHBxQ2RzbVJpYWFT?=
 =?utf-8?B?YmxrTzBWSHpZLzhuSlcrMitHUDZ1TDJOUnJxSFhuSXZ5NXhaT2hPUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68eb51ec-bf13-41d1-3b17-08df20e3dbcc
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6914.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2026 00:18:32.9095 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6I3stIQPjEAWZNxKDnr90ZIDOp9aQ5zIe1Kk0z4iocxySNwNXr9kQbL/C2uRWEWYbrrN2VDIPXTOMPIimrUZLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SADPR12MB333558
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



On 10/2/26 14:25, Johannes Stezenbach wrote:
> On Fri, Oct 02, 2026 at 11:12:10AM -0500, Mario Limonciello wrote:
>> On 10/2/26 10:47, Alex Deucher wrote:
>>> On Fri, Oct 2, 2026 at 8:52 AM Johannes Stezenbach <js@sig21.net> wrote:
>>>>
>>>> I have one Asrock Deskmini X600 with Ryzen 8700G.
>>>> Recently a BIOS update was released which updates
>>>> AGESA ComboAM5 from 1.2.0.3g to  1.3.0.1a.
>>>>
>>>> https://www.asrock.com/nettop/AMD/DeskMini%20X600%20Series/index.asp#BIOS
>>>>
>>>> The result is boot failure before any message could be printed
>>>> with my self-built kernel, which has the amdgpu driver built-in.
>>>> However, a Debian rescue image with kernel 7.2.8 could boot
>>>> (in text mode or vesa graphics mode).
>>>>
>>>> Using the rescue system, I installed the Debian kernel 7.2.8,
>>>> it can boot but hangs after the amdgpu module is loaded
>>>> (no error message or crash output).
>>>> It can boot successfully with module_blacklist=amdgpu.
>>>>
>>>> https://packages.debian.org/forky/linux-image-7.2.8+deb14-amd64
>>>>
>>>> If you have any ideas what to try please let me know soon,
>>>> otherwise I'll have to downgrade to the previous BIOS version.
>>>
>>> Can you get ssh access to the system?  Can you boot without amdgpu and
>>> then log in remotely and manually load amdgpu and get the dmesg
>>> output?
>>
>> Depending upon how early it hangs, anything saved into the journal from
>> previous boot?  You can try:
>>
>> # journalctl -k -b-1
>>
>> Also; what is the version of your DMCUB
>> (/lib/firmware/amdgpu/dcn_3_1_4_dmcub.bin.zst)?
>>
>> You can use this script to parse it:
>>
>> https://gitlab.com/kernel-firmware/linux-firmware/-/blob/main/contrib/get_amdgpu_fw_version.py?ref_type=heads
>>
>> If you upgrade to the latest upstream version does it help?
> 
> I have the latest upstream version (it is in Debian sid):
> 
> $ ./get_amdgpu_fw_version.py /lib/firmware/amdgpu/dcn_3_1_4_dmcub.bin
> dcn_3_1_4_dmcub.bin: DMCUB FW
>          ip_major = 3 (0x3)
>          ip_minor = 1 (0x1)
>     ucode_version = 134242816 (0x8006200)
>       ucode_bytes = 350240 (0x55820)
>             crc32 = 3448435613 (0xcd8af39d)
> --------------------------------
> Detailed uCode version:
>             major = 8 (0x8)
>             minor = 0 (0x0)
>          revision = 98 (0x62)
>           is_test = 0 (0x0)
>          is_vbios = 0 (0x0)
>            hotfix = 0 (0x0)
> 
> Now it gets a bit mysterious: The Debian kernel booted
> successfully a few times in a row, while earlier today it
> always failed in a few tries. But eventually I reproduced the
> failure and got the attached log.
> Screen output stopped after the "[drm] ATOM BIOS:
> 113-PHXGENERIC-001..." line (i.e. before "Console: switching to
> colour dummy device 80x25").
> 
> I notice now that I still have the amd_iommu_intr=legacy option
> which I needed to fix hibernation, let me know if you think
> it's related. For all I know I still need it.
> https://bugzilla.kernel.org/show_bug.cgi?id=221036
> 
> However, my self-built kernel still crashes early after I changed
> amdgpu to be a loadable module. So there is something else going
> on, but lets concentrate on the andgpu failure with the Debian kernel.
> 
> 
> Best Regards,
> Johannes

Here's your first indication of a problem:

[   13.423543] amdgpu 0000:6e:00.0: [drm:amdgpu_ring_test_helper 
[amdgpu]] *ERROR* ring mes_kiq_3.1.0 test failed (-110)
[   13.423719] amdgpu 0000:6e:00.0: hw_init of IP block <gfx_v11_0> 
failed -110
[   13.423723] amdgpu 0000:6e:00.0: amdgpu_device_ip_init failed
[   13.423727] amdgpu 0000:6e:00.0: Fatal error during GPU init
[   13.423732] amdgpu 0000:6e:00.0: finishing device.

Basically there is a graphics ring buffer test that happens and fails.
Then the hardware init fails as a result of that failing.

 From your logs the notable versions:
[    0.414349] AGESA: AGESA!V9 ComboAm5PI 1.3.0.1a
and
smu fw version = 0x004c6700 (76.103.0)

Was the only think you changed BIOS?  Or did you happen to upgrade 
linux-firmware recently too and that could have been the cause?

Can you downgrade back to existing BIOS and see if it's OK?


