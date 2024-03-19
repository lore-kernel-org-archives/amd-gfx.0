Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDFFAC54E60
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Mar 2024 09:55:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 525DF10F937;
	Tue, 19 Mar 2024 09:55:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NcjShoSn";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2135.outbound.protection.outlook.com [40.107.244.135])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8C46E10F937
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Mar 2024 09:54:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D0fo3hb002mQ7ND9Zdu+w0PTc2eTTNhsbQGeFiAY4yo2ZOQ/b8SFVXAIo7Pb2zFFayntt/ZeyBrHEOTHIeJj2CkCPswT0wHuZdJUuJrbHll/rrvkpvHZHfuDoff6xr0fPu+BGt6+OTq6eobjw+tAr36b31hIZHofczUxDTLgWnzzKLyv8gDXm0+09BSXXnPCUsH97xoebrdhQASTTWkvkLXvbx83wK8Wu+dTY5JVj7vFFLaxIaTeTYBrDRr+wmKMW00W/BCcE0kUeCQtg50zQMxzJc3+CNiHVByQU6B2ndbsqnpXs438iFBoytT/URhtMRKc4oMQy71GvRSAPsKXdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o32HT465VnrPQlx9mafQToF8uN+72E1T6HQhG1D9ILg=;
 b=VLi/pOEG6VV2ccfHmZ4IW2xoMKNGIb3TNtV9H8jx+UfvZ//55/XBsKRJmC+DuRigBZZokfC2hNARLsM4gAD9c/0szRYBTVrcylv1l2GyEOV75ApROLQmGFwB2XH3/AtSyzocEgu1aT6mnaVFIkoUyR/FAaBYs/HlbFA5tddZpGJ2Qz+tHoC8xaficJ4YtNOtet41DSMv7EkS+F5EtiUVS3CJ3h+CqKQrvaOMElrgLd1J43yhorPLRBw5GxOXYgUnU3ZJzPb4ohEyQqPleduy7Bp8pOD2rxatPyrxe3JzbZbXHSEOwuLXEiLOLKQgzN0E4Ja8ALDR1F1ipD5OQyEjRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o32HT465VnrPQlx9mafQToF8uN+72E1T6HQhG1D9ILg=;
 b=NcjShoSnz2NutNkZX5IsGnoF+VJON0R+Y9wG7GJ1LdCTO9lP0xLIWY0+bhnmTbKKAZSmTySKA4wBqcEYN1v9fK99kCwDh635EihqQ5QOLqk77tAA02rPMYj5KpslqstzwQ1pC2bX65Bvi0/u/k5tu/z+vlhP5fJMLPPfvR473Wk=
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SA3PR12MB7858.namprd12.prod.outlook.com (2603:10b6:806:306::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.30; Tue, 19 Mar
 2024 09:54:53 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::f2b6:1034:76e8:f15a]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::f2b6:1034:76e8:f15a%6]) with mapi id 15.20.7386.023; Tue, 19 Mar 2024
 09:54:53 +0000
Message-ID: <cbc7739a-21c3-4872-bcb0-4fceaf607d32@amd.com>
Date: Tue, 19 Mar 2024 10:54:48 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Remove pci address checks from acpi_vfct_bios
Content-Language: en-US
To: Kurt Kartaltepe <kkartaltepe@gmail.com>,
 Alex Deucher <alexdeucher@gmail.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20240318065211.11097-1-kkartaltepe@gmail.com>
 <CADnq5_MxfDSaOoD9J2DfdkM2wzX_HfRPkLv8CSSVPzJSKi1aUQ@mail.gmail.com>
 <CACawnnzv5Ro32h3wJ_5EQ=9k=b8mGA4FEGjXbWTUP-jdmWERBg@mail.gmail.com>
 <CADnq5_N4eZ9LbDRLwbAv0NVnmp1GrMwp+cDs4tP0FHwf1r7YRg@mail.gmail.com>
 <CACawnnz17jd4f+VrVhx5oH_DmOSb7jSLGZnmj0PcOZeQ+=UD5A@mail.gmail.com>
 <CADnq5_Mj_9=hBC47K5urr5VLTiaUQsv1Lib0uPTq8-XGSDh-tw@mail.gmail.com>
 <CADnq5_OtProx-8d_0epm9TrYtE_rHLYDhEb6XrK9bgOPi7MicQ@mail.gmail.com>
 <CACawnnx8Z5jbBdzct9Omeq3Y6iJhMDTDy_C3DRPe9irjoHRn+Q@mail.gmail.com>
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <CACawnnx8Z5jbBdzct9Omeq3Y6iJhMDTDy_C3DRPe9irjoHRn+Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0263.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e8::10) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SA3PR12MB7858:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: d/I2Tb2CL3Xse+O9QEpWsJ+pkr+3L5xItzSc4EdeCwzRD61GbFROnutFv0xLDqQpPYp3lPV7eSEWor0ak4kT2RspnJgFPRM+WPkvTnD9dzVj/gKP9KqkVCfZ3605SI6hKp9R3xYY4DKYjT0TZoySq/+nLDPBVYFVyDvqUzs1FPNZ/l5X4GeyyqQ8REvzZs5L375iEi5h0c7o/kBtIWT8WOJ4kbJxVWssA1tRE0bGc5km48IthWfYZZFBhLFb6naM35KTbeZeKZFlzbNjkABc7ykiddAKPZeWETbXMWSpr5dftot77p4nPJQ4SqLgvKb6VzPX5c1szAHLglaeAA2sPDTk1gDTMKqZJO+rG0Uyj6Rm75ZLoE8mG9GNkS9GxDOxoxVZs4HNsUlhPx3oDe/SKTxtYmo8hfFZ4XltY1ypB0/YI4gsDb+Isrt6N54oSF3qZk8zL0fOSEr+rtKaFE4jOBdiV9RwU1lKb1PBgUhI2RIBi1wQyhwLq6Jexm4ejDXrxSHWVnykuUmjqiChMDFkulW/ojjyuXjzc/6fghRxXNqQjW664V3Ha5byCts6FJ34P9ABFm2g2lHSH0m7D478uOMzyp8+HUDS+tvjbWc46xINq1J0lde2O4/M7TC+bbY4Ki4GJ0Pp4ezQ7A+JcxvmacPhnBDWEhAxhgKJ31oN7p8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(366007)(376005); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T1ovSk1LSXpibUFYOVM2eEMrdjh6NGxHUEVkN25tNUsvS1FlZmdHem1KUld1?=
 =?utf-8?B?dklTM2UwcEJuUWpKN0tWVWxobzFtV2syUDU5cXZaRHYrWGEvR1dOUFdJRURC?=
 =?utf-8?B?N09ZOGNlSnVoeW5pVUNxWXpvbllZY0xaYnljNVdDVkthelN6cDNFUmFWWThY?=
 =?utf-8?B?MFBsNElEcjl2M0Mya3NXZUJFSkllVlJ4TW13MTJabVUzbjRVSDY0Q2VlcmVk?=
 =?utf-8?B?SzA0dHdKeS9tdWg2dXlKTm5UczVObnF1VnhyUUlJWDhsalhkZnNQMFMvQTZv?=
 =?utf-8?B?Y1VrWWlhNFBCdFI1bnV0UGtnRWFlVVZsRzlGY1JQMnJTVm01ZDRvWW5wQ1lh?=
 =?utf-8?B?N0N3OHRuWlllN25wL29BRkdsVVpHc2FkWjkyc3ljbWJGb2NRa3VjeVVQZE1M?=
 =?utf-8?B?Y2RRbm5yUjNoTTF5VzBDS1Y0WTMzRkdwODhWMGQ5Nk9td1BZeEZhUDc0ZlVa?=
 =?utf-8?B?cmVuQ2g0M1BWQkYzb0dacDJ1Rit3V2p5YTJHV1NmK3JZNEhCOE93M21RZVBa?=
 =?utf-8?B?Tnc0SlVNYVJ5aDBHQzNnSkhiZng3R2xpYnRCSkplTnlHYWNYMXlIUWhPV3Iz?=
 =?utf-8?B?U0dXdm5SYmdlUzBZcDV1eHZiSlFadnNIbDI3QkRINVhyYVZKRDA1emFCL095?=
 =?utf-8?B?ZkxaR0VWNTJzK3ZQdHd4cGEvelJxcjJJTDBmdjBYWTRTQ1JhL3NhR0xJTnh1?=
 =?utf-8?B?ald0TzBFRmE4MmI2bWpDK2NoelEzNVZWOVBpUHhMYzFJM2dPaVZERUxTb3Y4?=
 =?utf-8?B?cHJ1dkFuTGhCeERiNm1aZ1QyMDJXZTUyQ1F4M2JJZHp6TkFkamMxU09ibCtH?=
 =?utf-8?B?ZzdjWEJvanVsdFZXRDh3a1NseTU3dCs1MWxIbTAwdE9aNythQm05eDUxdDNR?=
 =?utf-8?B?S0FKcXF2SnJrZm1LZ1BYNkpZNERSNzVEMUc2dStSTXRIV2lhUGZLMVNJZGpL?=
 =?utf-8?B?N1RaL3RFb0xWRU9hdGlMUUE1TGdMSW51a3BuL2Ivb2RlUWltMXN6Q2xkTjdL?=
 =?utf-8?B?MWN4eFBJTm9hS3dmdUFhamV5dVhOU1lJejFTYTRBdnBReitRalEzVCtOOW8x?=
 =?utf-8?B?WWZUQUZVNXJHM3JDd0t6eHZqRzAwYXlHL2ppZFF2UFBtYkVLK0dLMFoydWMx?=
 =?utf-8?B?NHg4YUR2ZTBBNXZZelZUMGxLekJBbXpLaFY3ZVZOWnZnSkp0MUx6RlNjWkZF?=
 =?utf-8?B?SlYvNkcvcG5BSm5ubi9PMjZ6a1o5QWtIMXIrazNRSjVLUjlvdndlK0Fqalc2?=
 =?utf-8?B?eDBtV2VGZm5SUGMvc2ZXYXRpNDYwSDhMM05wUmJ4UVd0c1Judk1CZ28yU1FD?=
 =?utf-8?B?SFYra0tMYzZSRVhRMEo1ejlVdmt6RFEzNEwxUitKdHpQanZneFF1YjdmTzdu?=
 =?utf-8?B?R0RPRC9laWR2UlAvQVJuN3lDMXQwSkVNcUE2b2pwWjlJaS9nV2Vhd3pkSVI5?=
 =?utf-8?B?aHlGQnIzc0M0c2tjK2xWWkZML1RVdFVRZDN1RUw2Ri8wZldkR2tsQ0c0ekx4?=
 =?utf-8?B?eGgycDFadXNnaTBQc1VWd2lHcHhmdVc4T1ZXYWdjcFZJU2Q4aWRadC8vQkJF?=
 =?utf-8?B?Q0gzNmNnR1VTN0RKa1ZlaWlnbjQ3RWxaSWY1K1hMeVJkUDJJalBFTEdPdDJS?=
 =?utf-8?B?OHlaZHhEWTVTbi9BV01ld1FWcVp1TFFYdnZpWjJDaUpBTVNaKzVnTGlEQWpO?=
 =?utf-8?B?V2w3MDNWaVh4L2FCNWRVY3VkbDJZVFJJNXY3N0s5QVBiaXRXWUhudk8xdElu?=
 =?utf-8?B?QTlDT2hWRkhtWGhMZVVYWG96dnJxREZMc0k2Ti9JMSt4eE5rcGZ1eFc1VFky?=
 =?utf-8?B?eHBkMVRLWFIwaStKWXA3NW53RVlCVk1tL0ZZN2FGelk0Ly85RkgxN3JBZzBr?=
 =?utf-8?B?eWlNdUtuRkt4aVVNVHA0ME14QmlnVFBZUkVOTjJvaHk4YUgxYmhwSk83a0t0?=
 =?utf-8?B?UXBmUS9XYTEwaS9ZZ3BZVitwZU1RUDc1ZlpzRUJUVUtlbU92aTcrNWQ4Q1Rz?=
 =?utf-8?B?TzZSSk1vMitxN0VPR0hDaFFmU045SVp1UFBwNmJQcC9uY2s4TFdCK1Zyc2RI?=
 =?utf-8?B?WFJSK2I4eHVIMGhYV05sbVcyU3NQeHowei9GRklQcHlmK1ZXQlEvS3Jvbm9J?=
 =?utf-8?Q?n4H8t6NvvfmTRVaW3dA2y4fHG?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f84854ec-e957-45c6-5cb8-08dc47faa00f
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2024 09:54:53.5154 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VAhKHbDOogoP3DmPEiWunGDOseCkc3r1UFCDEGCO8yY+dA7kw3BoDnH7D8Gdu4ni
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7858
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

Am 19.03.24 um 02:55 schrieb Kurt Kartaltepe:
> On Mon, Mar 18, 2024 at 12:57 PM Alex Deucher <alexdeucher@gmail.com> wrote:
>> On Mon, Mar 18, 2024 at 3:52 PM Alex Deucher <alexdeucher@gmail.com> wrote:
> ...
>>> Depends on the platform, but recent ones use VFCT.  That said, there
>>> should only ever be one IGPU in the system so I think we could just
>>> rely on the VID and DID for APUs in this case and check everything for
>>> dGPUs.
>> Is there a reason why you need this option?  Even beyond this, I could
>> envision other problems related to APUs and ACPI if these changed.
>>
>> Alex
> So there are multiple factors in play. I am trying to make use of the
> lovely usb4/tb3 controllers on the 7940HS with the reportedly Intel
> Tamales Module 2 pci/pci bridge over the usb4 interface. This provides
> a handy way to expand the pcie bus but configuring ACPI and pcie
> topology isn't generally an option on consumer BIOS (unless you want
> to enlighten me). This leaves us in the situation where the bios can
> enumerate devices poorly resulting in inaccessible devices due to
> address conflicts. To resolve address conflicts the only option I'm
> aware of is pci=assign-busses, maybe this could also be configured at
> runtime but assign-busses seemed nice in some ways.

Well what problems do you run into? The ACPI and BIOS assignments 
usually work much better than whatever the Linux PCI subsystem comes up 
with.

The PCI subsystem in the Linux kernel for example can't handle back to 
back resources behind multiple downstream bridges.

So when the BIOS fails to assign something it's extremely unlikely that 
the Linux kernel will do the right thing either.

Regards,
Christian.

>
> I havnt experienced any issues with the APU (graphics, hardware
> encoders/decoders) but I do think assign-busses might be renumbering
> again after suspend/resume/pci rescans but I need to debug further,
> maybe suspend/resume are just broken when ACPI addresses are wrong.
> Obviously the graphics user space (compositors, mesa might be working
> as expected) dont handle the device switching addresses while in use,
> for amdgpu kernel side I haven't inspected deeply yet.
>
> I'm not sure if this is the right approach to solving the problem, and
> given your input i'm considering it may be better, though not
> upstreamable, to implement renumbering only for specified devices like
> this pci bridge or investigate runtime management of the pci bus
> addresses. The current assign-busses implementation is quite the big
> hammer admittedly.
>
> --Kurt Kartaltepe

