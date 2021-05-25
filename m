Return-Path: <SRS0=WUpi=KU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD0B5C47084
	for <amd-gfx@archiver.kernel.org>; Tue, 25 May 2021 14:08:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D26A613FA
	for <amd-gfx@archiver.kernel.org>; Tue, 25 May 2021 14:08:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D26A613FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C79789EFF;
	Tue, 25 May 2021 14:08:19 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2070.outbound.protection.outlook.com [40.107.223.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 91D4F6EA33
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 May 2021 14:08:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dPnVVj7nuDmn8jPfjbFI/HO5xD2XXT3SNs5XcMWNjsdJNsyvrSjn27cz+ti6r4RN4bp3gxzgp912MKFrQ5K49AFkYPcz4fvHRWpLkvuK5bweXvSJiDsj9de8m5FJEkH/Rr+N8ecZFnnjzuNpjSITti/ZVLyX3JQjJDIXYsv4OS67X2+J2PUTfdArqH0CG9HYzCDyr6zbGfoz/bR8K6sa5EtalrCaSruW8/GrhBaq8RQh5cP10G+qkycfAkfG6c6Jy+iR5T2ioR3uGPixNhiMsgcRLva3AGpKalW6T6MtJKSY0OFlaVjdXG0XtJJetNViYTeLMxfbteZx4ahNrH38Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JzYsA1ib9iKGBfiwR67f8QzWqVAswLDUppNA+wclTAI=;
 b=IQMcr3WDhnMoj/MwJWlI4aWFEAMMa4O7TGqN+lO6ZebB3yBxre8cO8Fq92ds/JGBX4S9Y7QFgLdnqs2xiggnxfW2B7XCRmhBJWdlInKxGmTiMqpZNpAQ0TUZw68lh50/cx7EPxa9+3J9DTYCJ7mGPAdHnvimsNGh2tboWWuHwxb2uA32hdNzMaa6ti94vjJZb0nK0NerBWBUkUKeQ85KqzPVnf6vgQpeVyb4hkf0In636qFBp6bW6JRW7e60bWXDqgGParXxo5DyaVxA0RL83/O/8FqBKw78CXqp6xrllGm2egkLrUET9GLTPFnfSzD/EuHuVh5wO3l/zdg0YL39+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JzYsA1ib9iKGBfiwR67f8QzWqVAswLDUppNA+wclTAI=;
 b=G7vuNS9KBEY5MsWMkeIMmEE/VteP6LcVxKsli0zOYCkF1ric3oIFD7RFgF2YlkoKfjhLoaoszeK2MCi5AQme4Px+yJ34mynBJS/scQ9MUNPqdME7iKWaBymPXhXHd9MdwFkUX3NP1+UkNOdF935SAdArRt4+DPNp15Z975RKRcU=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20; Tue, 25 May
 2021 14:08:15 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::6d4d:4674:1cf6:8d34]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::6d4d:4674:1cf6:8d34%6]) with mapi id 15.20.4150.027; Tue, 25 May 2021
 14:08:15 +0000
Subject: Re: radeon ring 0 test failed on arm64
To: Peter Geis <pgwipeout@gmail.com>, alexander.deucher@amd.com
References: <CAMdYzYptw9L=5SECtVkNZruTT-x57+03vj0A+5efvq8cESzLyQ@mail.gmail.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <ea6a7137-f8c0-ecaf-2476-13b54cc72138@amd.com>
Date: Tue, 25 May 2021 16:08:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
In-Reply-To: <CAMdYzYptw9L=5SECtVkNZruTT-x57+03vj0A+5efvq8cESzLyQ@mail.gmail.com>
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:d67f:bd9a:6dbf:33b1]
X-ClientProxiedBy: FR0P281CA0001.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:15::6) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:d67f:bd9a:6dbf:33b1]
 (2a02:908:1252:fb60:d67f:bd9a:6dbf:33b1) by
 FR0P281CA0001.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:15::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4173.11 via Frontend Transport; Tue, 25 May 2021 14:08:13 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 33767862-4d92-4457-9f80-08d91f8689ea
X-MS-TrafficTypeDiagnostic: MN2PR12MB4192:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4192735F90665C1DD8E1D47D83259@MN2PR12MB4192.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hGxx15RVv/VLdQIK7/HYZ2P0u+MbMMlEPa9I8HKWHDJBim1tTF+Sly9fnZkICWdjGiuZVXp92jgZKq8LeNEXlpb5f8McKgQsY42r/TJHczc0TZ3IV/TtJmjbaisC00fLS5YCjRLs13CGz0AeDYdU5SiAgbOJfH41BbEZDEgI9Oaw/o0zU7jVNEZv9D7cMRuDlkmm8l8DI6Q/myk2O3cCVGaO00N3+NkKnyc4J3ardxRHgK+q+RN1irgDawLlei75zpY+MxFtrdDFtQdIpJo4l4Y1NsHX8ly+JW1is7/V/cgAeWqX/PRGWpA0n+bjZTynre2j2g15JFH0Z3mnLSNl4zQQCXK+RIh65DZnL8WMf3V3UaNQnaT9XuK3f4m8aueAqTJyBAYFnqYjEWYasDDTiKDe3Rlly8KIrW2/vrWDtE4AM22xPtGA9nOROlTMx6m8TR04g9msSUHIWz+QD89+VmV8DNWJIRrGHkFReNFooxaURK2pPe+JeFz6rXpSEgz09V71pL60MDAXYjzIL66BjvNDa85977/blHlZ+dnsmOR54495kO5Tgl+aHz38E1RfGlqsIgqbwUaYT2pJwV1T+I8M8uatU7TEupCoLYO3eTo+B86PU2MPvXQtpqzhKS1k5jtMe4ek/PYjhzYRgzPikAExt1MR6jIb/Ym7NDe8yuLXtfKQdYWu1tOl5OSaQ//E
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(366004)(136003)(376002)(396003)(39860400002)(36756003)(83380400001)(66946007)(31696002)(66556008)(66476007)(8676002)(8936002)(2616005)(6666004)(2906002)(31686004)(38100700002)(6486002)(4326008)(316002)(5660300002)(30864003)(478600001)(6636002)(16526019)(86362001)(52116002)(186003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?V0RLYjQ0QjVMbS9kV0dHMzRZM0xpcTRXdkFrTG5LdC94SERiV1pacFRQME5K?=
 =?utf-8?B?bEtuMUdyUjNUZWdoQVYwWjNySjh0UDJPb0RMNTFPaUFQVEwyV0Y3QzZSK0Mr?=
 =?utf-8?B?NnB0QVgyV05acGdadm9NWnh1TmVxOFVLa1NhcTFrY3BlQUZNQnJLaENGZ2ky?=
 =?utf-8?B?SEdjSUZpVWxMZUtjL1VGUElaNmd6NnpYVHlYWURFREE1ZDRzTWRSdUNTMGF3?=
 =?utf-8?B?NndPZE1HdE5pbnZKaHo2SkdXOGlmR3VZVGc0YjlGMkVFMlVZQ3FwYThDNUxI?=
 =?utf-8?B?Tnh6Uy9aNG5BYzlnTmp5S3RVdkZ0VXBJMU1ITnhEMWhuZStmYUlUYUNKRURt?=
 =?utf-8?B?a2ovRVRQdkJrYmpSekp0QW84clZjQ2JtV1RhYmZxbWNLZG1WM1ViTWVQWThi?=
 =?utf-8?B?N2VmRVlUbThCYTdGbXdYRzlOc2ZjNFk5SmZQLzZ5R2xxMzEzQ0xkTkE2RzlL?=
 =?utf-8?B?dlFMZnd4TTVodDFBY1lleFlGbnI5d3JuZzN1ekR2cGRHRlRFNUFiYzJkQ3Bk?=
 =?utf-8?B?SSsyU05hcXlLQVhzNE5ielQvallIelRsS3FtMVgydVNTWTJUMTVMN3RYd1cw?=
 =?utf-8?B?WlNNUVNBY0ZDZzJPR3hvVzZ2THBZVFNTSStZOXVtRDlmMVBYQldwRzZEZVJK?=
 =?utf-8?B?b293cmtJc3krRTFJODhoN0E1azVFNWdBRFdnK0VicjdkMHNUVXhBSVJiTkxP?=
 =?utf-8?B?Q1ZzVTRYVmlLZTBaa2pHM0F3Q2QxZVlNTjNlVEpodUFDSnhqSUE3YWM4OUpF?=
 =?utf-8?B?N1R2aG1HNytEd1QrR0h0Q2NaWFYvdjdtMmxDMDVFN05xb0JvWm9sSXNBRnE3?=
 =?utf-8?B?aGVDR3F6ZGgxRTNKb1A4WGF3d1lDdE51eldrRGc5WTQ0TEVDMFRwd1l6VUt0?=
 =?utf-8?B?am0xbWxZSzRsbGlsa2NzdHl1NmpPNGNkOGF3V3h2SUJBVUVISGNWVWtoUEM4?=
 =?utf-8?B?T1FEa0pKWnpHWXhrdjFEaUI2SUNxU0pVWVo4bUpUVW1NN2hoOUFwdVJXcVVT?=
 =?utf-8?B?YjdSVXZxUml3K1JkYk8zYm12UFpqdGwvaG9ocExGTWs4ODQ1TTVVajJOMkN4?=
 =?utf-8?B?ZHBhYTNwMmRqdUNIRXVzT2tMUHI3eEFvS25OaUFzQkRlQmFjTk95U0pjdVBG?=
 =?utf-8?B?QURwVVBaK2RMc1pLVUNLWnJnK0ZBTFpadTBNejFtYktHcmtsNExTZ3J0enFE?=
 =?utf-8?B?REY1SGw1QVgza3UyTUtiUzVxOGNZUloxaEZTb2pzcEQyYVh3L2xRTlhpTHBU?=
 =?utf-8?B?T2FEbzBuUWZWMlAvOFpnYnMwdHpTK29ic0ZuZm1hWlA3bVJ0T1FOWDdQYWNy?=
 =?utf-8?B?S2FvbEsxNUVzbE13MS9OMzBLcmh0TWR6SFpCTUljc1ZpNk15UERQZFkxR2NK?=
 =?utf-8?B?VjZRbVR6VmU1MlFPcmkzM2dEL0I3SU42UXBoTFJqeHg1R3dwdURMdS9WMWhI?=
 =?utf-8?B?bXpSVERKYUJXMWhnUnRvZE9RVVQ2OXd2bmhna3o3RlplanhYR3ByR0NQWDBy?=
 =?utf-8?B?NXBFRi9Ec3ZmZm5GLzE0T0pjV05IWU1TR00xT3pZVVFRd2Z1VW8wZUE1WDNa?=
 =?utf-8?B?T1h1akVRSFozYkx4ekhydEplYVcwU0FpejJTRGx0Sm9YQkM0MU1iL3BWWW0w?=
 =?utf-8?B?RmEreWorc2crbGR6RHV6V3dHNVkrZkdWcGNZVWh2aHhPZEg3R1g3UmtmMklp?=
 =?utf-8?B?ajhJSmJ0K2p6bjIwU1dkZ2JDNFgyanI4Q0o5bll6RFFSVEVwOXJTaUt5Y1Yr?=
 =?utf-8?B?K1RWTjlMLzFieGMydWRxZ1Y4MlNHclE0SkU2MHhKaTYvQkFSM3gxRFA5REtF?=
 =?utf-8?B?RFRwSWxaQWdKbG9vdWwzT3F2bzc1K0xxLzc5aHNHcndJaFVXVUlUUkwyWW51?=
 =?utf-8?Q?T8a1wNGDxDaMl?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33767862-4d92-4457-9f80-08d91f8689ea
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2021 14:08:15.1248 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R2/rWECU8AIqCB+G1AbL2fO8bQb1lQidM4t0rUTf8Yjomdb9DpVWueaNdUjFr5Wf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4192
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
Cc: amd-gfx@lists.freedesktop.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi Peter,

some comment additionally what Alex said.

Am 25.05.21 um 04:34 schrieb Peter Geis:
> Good Evening,
>
> I am stress testing the pcie controller on the rk3566-quartz64 prototype SBC.
> This device has 1GB available at <0x3 0x00000000> for the PCIe
> controller, which makes a dGPU theoretically possible.
> While attempting to light off a HD7570 card I manage to get a modeset
> console, but ring0 test fails and disables acceleration.
>
> Note, we do not have UEFI, so all PCIe setup is from the Linux kernel.
> Any insight you can provide would be much appreciated.
>
> Very Respectfully,
> Peter Geis
>
> lspci -v
> 00:00.0 PCI bridge: Fuzhou Rockchip Electronics Co., Ltd Device 3566
> (rev 01) (prog-if 00 [Normal decode])
>          Flags: bus master, fast devsel, latency 0, IRQ 96
>          Bus: primary=00, secondary=01, subordinate=ff, sec-latency=0
>          I/O behind bridge: 00001000-00001fff [size=4K]
>          Memory behind bridge: 00900000-009fffff [size=1M]
>          Prefetchable memory behind bridge:
> 0000000010000000-000000001fffffff [size=256M]
>          Expansion ROM at 300a00000 [virtual] [disabled] [size=64K]
>          Capabilities: [40] Power Management version 3
>          Capabilities: [50] MSI: Enable+ Count=1/32 Maskable- 64bit+
>          Capabilities: [70] Express Root Port (Slot-), MSI 00
>          Capabilities: [b0] MSI-X: Enable- Count=1 Masked-
>          Capabilities: [100] Advanced Error Reporting
>          Capabilities: [148] Secondary PCI Express
>          Capabilities: [160] L1 PM Substates
>          Capabilities: [170] Vendor Specific Information: ID=0002 Rev=4
> Len=100 <?>
>          Kernel driver in use: pcieport
>
> 01:00.0 VGA compatible controller: Advanced Micro Devices, Inc.
> [AMD/ATI] Turks PRO [Radeon HD 7570] (prog-if 00 [VGA controller])
>          Subsystem: Dell Turks PRO [Radeon HD 7570]
>          Flags: bus master, fast devsel, latency 0, IRQ 95
>          Memory at 310000000 (64-bit, prefetchable) [size=256M]

>          Memory at 300900000 (64-bit, non-prefetchable) [size=128K]

This here...

>          I/O ports at 1000 [size=256]
>          Expansion ROM at 300920000 [disabled] [size=128K]
>          Capabilities: [50] Power Management version 3
>          Capabilities: [58] Express Legacy Endpoint, MSI 00
>          Capabilities: [a0] MSI: Enable- Count=1/1 Maskable- 64bit+
>          Capabilities: [100] Vendor Specific Information: ID=0001 Rev=1
> Len=010 <?>
>          Capabilities: [150] Advanced Error Reporting
>          Kernel driver in use: radeon
>
> 01:00.1 Audio device: Advanced Micro Devices, Inc. [AMD/ATI] Turks
> HDMI Audio [Radeon HD 6500/6600 / 6700M Series]
>          Subsystem: Dell Turks HDMI Audio [Radeon HD 6500/6600 / 6700M Series]
>          Flags: bus master, fast devsel, latency 0, IRQ 98

>          Memory at 300940000 (64-bit, non-prefetchable) [size=16K]

And that look rather fishy to me. The non-prefetchable memory on AMD 
GPUs is 32bit, bit 64bit.

Looks like something is wrong with the detection code here.

Christian.

>          Capabilities: [50] Power Management version 3
>          Capabilities: [58] Express Legacy Endpoint, MSI 00
>          Capabilities: [a0] MSI: Enable+ Count=1/1 Maskable- 64bit+
>          Capabilities: [100] Vendor Specific Information: ID=0001 Rev=1
> Len=010 <?>
>          Capabilities: [150] Advanced Error Reporting
>          Kernel driver in use: snd_hda_intel
>
> [    6.431312] rockchip-dw-pcie 3c0000000.pcie: Looking up
> vpcie3v3-supply from device tree
> [    6.434619] rockchip-dw-pcie 3c0000000.pcie: host bridge
> /pcie@fe260000 ranges:
> [    6.435350] rockchip-dw-pcie 3c0000000.pcie: Parsing ranges property...
> [    6.436018] rockchip-dw-pcie 3c0000000.pcie:       IO
> 0x0300800000..0x03008fffff -> 0x0000800000
> [    6.436978] rockchip-dw-pcie 3c0000000.pcie:      MEM
> 0x0300900000..0x033fffffff -> 0x0000900000
> [    6.438065] rockchip-dw-pcie 3c0000000.pcie: got 49 for legacy interrupt
> [    6.439386] rockchip-dw-pcie 3c0000000.pcie: found 5 interrupts
> [    6.439934] rockchip-dw-pcie 3c0000000.pcie: invalid resource
> [    6.440473] rockchip-dw-pcie 3c0000000.pcie: iATU unroll: enabled
> [    6.441029] rockchip-dw-pcie 3c0000000.pcie: Detected iATU regions:
> 8 outbound, 8 inbound
> [    6.650165] rockchip-dw-pcie 3c0000000.pcie: Link up
> [    6.652438] rockchip-dw-pcie 3c0000000.pcie: PCI host bridge to bus 0000:00
> [    6.653142] pci_bus 0000:00: root bus resource [bus 00]
> [    6.653899] pci_bus 0000:00: root bus resource [io  0x0000-0xfffff]
> (bus address [0x800000-0x8fffff])
> [    6.654781] pci_bus 0000:00: root bus resource [mem
> 0x300900000-0x33fffffff] (bus address [0x00900000-0x3fffffff])
> [    6.655782] pci_bus 0000:00: scanning bus
> [    6.656689] pci 0000:00:00.0: disabling Extended Tags (this device
> can't handle them)
> [    6.657605] pci 0000:00:00.0: [1d87:3566] type 01 class 0x060400
> [    6.658418] pci 0000:00:00.0: reg 0x38: [mem 0x00000000-0x0000ffff pref]
> [    6.659923] pci 0000:00:00.0: supports D1 D2
> [    6.660360] pci 0000:00:00.0: PME# supported from D0 D1 D3hot
> [    6.661053] pci 0000:00:00.0: PME# disabled
> [    6.672578] pci_bus 0000:00: fixups for bus
> [    6.673063] pci 0000:00:00.0: scanning [bus 01-ff] behind bridge, pass 0
> [    6.675021] pci_bus 0000:01: busn_res: can not insert [bus 01-ff]
> under [bus 00] (conflicts with (null) [bus 00])
> [    6.675993] pci_bus 0000:01: scanning bus
> [    6.676705] pci 0000:01:00.0: [1002:675d] type 00 class 0x030000
> [    6.677672] pci 0000:01:00.0: reg 0x10: [mem 0x00000000-0x0fffffff
> 64bit pref]
> [    6.678493] pci 0000:01:00.0: reg 0x18: [mem 0x00000000-0x0001ffff 64bit]
> [    6.679217] pci 0000:01:00.0: reg 0x20: initial BAR value 0x00000000 invalid
> [    6.679894] pci 0000:01:00.0: reg 0x20: [io  size 0x0100]
> [    6.680565] pci 0000:01:00.0: reg 0x30: [mem 0x00000000-0x0001ffff pref]
> [    6.682170] pci 0000:01:00.0: supports D1 D2
> [    6.682897] pci 0000:01:00.0: 2.000 Gb/s available PCIe bandwidth,
> limited by 2.5 GT/s PCIe x1 link at 0000:00:00.0 (capable of 32.000
> Gb/s with 2.5 GT/s PCIe x16 link)
> [    6.686670] pci 0000:01:00.0: vgaarb: VGA device added:
> decodes=io+mem,owns=none,locks=none
> [    6.688367] pci 0000:01:00.1: [1002:aa90] type 00 class 0x040300
> [    6.689168] pci 0000:01:00.1: reg 0x10: [mem 0x00000000-0x00003fff 64bit]
> [    6.691099] pci 0000:01:00.1: supports D1 D2
> [    6.702495] pci_bus 0000:01: fixups for bus
> [    6.702935] pci_bus 0000:01: bus scan returning with max=01
> [    6.703500] pci 0000:00:00.0: scanning [bus 01-ff] behind bridge, pass 1
> [    6.704171] pci_bus 0000:00: bus scan returning with max=ff
> [    6.704768] pci 0000:00:00.0: BAR 15: assigned [mem
> 0x310000000-0x31fffffff 64bit pref]
> [    6.705664] pci 0000:00:00.0: BAR 14: assigned [mem 0x300900000-0x3009fffff]
> [    6.706337] pci 0000:00:00.0: BAR 6: assigned [mem
> 0x300a00000-0x300a0ffff pref]
> [    6.707035] pci 0000:00:00.0: BAR 13: assigned [io  0x1000-0x1fff]
> [    6.707687] pci 0000:01:00.0: BAR 0: assigned [mem
> 0x310000000-0x31fffffff 64bit pref]
> [    6.708522] pci 0000:01:00.0: BAR 2: assigned [mem
> 0x300900000-0x30091ffff 64bit]
> [    6.709411] pci 0000:01:00.0: BAR 6: assigned [mem
> 0x300920000-0x30093ffff pref]
> [    6.710116] pci 0000:01:00.1: BAR 0: assigned [mem
> 0x300940000-0x300943fff 64bit]
> [    6.710897] pci 0000:01:00.0: BAR 4: assigned [io  0x1000-0x10ff]
> [    6.711516] pci 0000:00:00.0: PCI bridge to [bus 01-ff]
> [    6.712022] pci 0000:00:00.0:   bridge window [io  0x1000-0x1fff]
> [    6.712617] pci 0000:00:00.0:   bridge window [mem 0x300900000-0x3009fffff]
> [    6.713278] pci 0000:00:00.0:   bridge window [mem
> 0x310000000-0x31fffffff 64bit pref]
> [    6.716165] pcieport 0000:00:00.0: assign IRQ: got 95
> [    6.749839] pcieport 0000:00:00.0: PME: Signaling with IRQ 96
> [    6.751738] pcieport 0000:00:00.0: saving config space at offset
> 0x0 (reading 0x35661d87)
> [    6.752495] pcieport 0000:00:00.0: saving config space at offset
> 0x4 (reading 0x100507)
> [    6.753224] pcieport 0000:00:00.0: saving config space at offset
> 0x8 (reading 0x6040001)
> [    6.754217] pcieport 0000:00:00.0: saving config space at offset
> 0xc (reading 0x10000)
> [    6.754942] pcieport 0000:00:00.0: saving config space at offset
> 0x10 (reading 0x0)
> [    6.755640] pcieport 0000:00:00.0: saving config space at offset
> 0x14 (reading 0x0)
> [    6.756337] pcieport 0000:00:00.0: saving config space at offset
> 0x18 (reading 0xff0100)
> [    6.757073] pcieport 0000:00:00.0: saving config space at offset
> 0x1c (reading 0x20001010)
> [    6.757878] pcieport 0000:00:00.0: saving config space at offset
> 0x20 (reading 0x900090)
> [    6.758614] pcieport 0000:00:00.0: saving config space at offset
> 0x24 (reading 0x1ff11001)
> [    6.759361] pcieport 0000:00:00.0: saving config space at offset
> 0x28 (reading 0x0)
> [    6.760057] pcieport 0000:00:00.0: saving config space at offset
> 0x2c (reading 0x0)
> [    6.760752] pcieport 0000:00:00.0: saving config space at offset
> 0x30 (reading 0x0)
> [    6.761501] pcieport 0000:00:00.0: saving config space at offset
> 0x34 (reading 0x40)
> [    6.762206] pcieport 0000:00:00.0: saving config space at offset
> 0x38 (reading 0x0)
> [    6.762902] pcieport 0000:00:00.0: saving config space at offset
> 0x3c (reading 0x2015f)
> [    6.764350] radeon 0000:01:00.0: assign IRQ: got 95
> [    6.766212] radeon 0000:01:00.0: enabling device (0000 -> 0003)
> [    6.766911] [drm:drm_minor_register]
> [    6.770051] [drm:drm_minor_register] new minor registered 128
> [    6.770606] [drm:drm_minor_register]
> [    6.771958] [drm:drm_minor_register] new minor registered 0
> [    6.772640] [drm] initializing kernel modesetting (TURKS
> 0x1002:0x675D 0x1028:0x2B20 0x00).
> [    7.029251] [drm:radeon_get_bios] ATOMBIOS detected
> [    7.029814] ATOM BIOS: TURKS
> [    7.030100] [drm:atom_allocate_fb_scratch] atom firmware requested
> 00000000 0kb
> [    7.030901] [drm] GPU not posted. posting now...
> [    7.037575] radeon 0000:01:00.0: VRAM: 1024M 0x0000000000000000 -
> 0x000000003FFFFFFF (1024M used)
> [    7.038388] radeon 0000:01:00.0: GTT: 1024M 0x0000000040000000 -
> 0x000000007FFFFFFF
> [    7.039082] [drm] Detected VRAM RAM=1024M, BAR=256M
> [    7.039533] [drm] RAM width 128bits DDR
> [    7.040975] [drm] radeon: 1024M of VRAM memory ready
> [    7.041543] [drm] radeon: 1024M of GTT memory ready.
> [    7.042289] [drm:ni_init_microcode]
> [    7.042639] [drm] Loading TURKS Microcode
> [    7.043047] [drm] Internal thermal controller with fan control
> [    7.059713] [drm] radeon: dpm initialized
> [    7.060375] [drm] GART: num cpu pages 262144, num gpu pages 262144
> [    7.069457] [drm] enabling PCIE gen 2 link speeds, disable with
> radeon.pcie_gen2=0
> [    7.167901] [drm] PCIE GART of 1024M enabled (table at 0x0000000000162000).
> [    7.169257] radeon 0000:01:00.0: WB enabled
> [    7.169770] radeon 0000:01:00.0: fence driver on ring 0 use gpu
> addr 0x0000000040000c00
> [    7.170496] radeon 0000:01:00.0: fence driver on ring 3 use gpu
> addr 0x0000000040000c0c
> [    7.177636] radeon 0000:01:00.0: fence driver on ring 5 use gpu
> addr 0x0000000000072118
> [    7.182365] radeon 0000:01:00.0: radeon: MSI limited to 32-bit
> [    7.184105] radeon 0000:01:00.0: radeon: using MSI.
> [    7.184571] [drm:drm_irq_install] irq=97
> [    7.185619] [drm] radeon: irq initialized.
> [    7.186795] radeon 0000:01:00.0: enabling bus mastering
> [    7.187346] [drm:evergreen_irq_process] evergreen_irq_process
> start: rptr 0, wptr 96
> [    7.188118] [drm:evergreen_irq_process] IH: D1 flip
> [    7.188563] [drm:evergreen_irq_process] IH: D2 flip
> [    7.189006] [drm:evergreen_irq_process] IH: D3 flip
> [    7.189450] [drm:evergreen_irq_process] IH: D4 flip
> [    7.189894] [drm:evergreen_irq_process] IH: D5 flip
> [    7.190337] [drm:evergreen_irq_process] IH: D6 flip
> [    7.190811] [drm:evergreen_irq_process] evergreen_irq_process
> start: rptr 96, wptr 96
> [    7.530753] [drm:r600_ring_test] *ERROR* radeon: ring 0 test failed
> (scratch(0x8504)=0xCAFEDEAD)
> [    7.531564] radeon 0000:01:00.0: disabling GPU acceleration
> [    7.533961] [drm:drm_irq_uninstall] irq=97

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
