Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31AB2C197A0
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Nov 2023 19:02:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 288D010E141;
	Thu, 16 Nov 2023 19:02:13 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2063.outbound.protection.outlook.com [40.107.244.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 33D3410E141
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Nov 2023 19:02:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aSJ2QTWlmeN8/Tms4QT54CiodNl4WduHGo75atgFefZRyMKHF1KH6byE8/Fd4gTnRwM0AZY4LJMBLj9f6fLhRbY+3lWBCBtb0w06EtcPV1Z0tlwHwWmsVKbOVDp/H6iVEpTYsK0uRqJLSR/IiK2QPLaQ2RgQC9ehZzmRQJ5IAPplMbWvgeRpYCimLaKFDyrLfWEUXYVf5dQKYc+u0dwQ/5LBuf81qq36iaZ0zz3qsK0HFHdKiqYro8+VomlxLmt8KKyJGQfzL3JbX7oForTtAJ8Bw/TXZwCATCJXzfTibmrKMfriKmyazo1MmQcXzAgU5OfrSjzREjZoNxxXwLBJ/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2gwFane0815iSW0eRv8AMnUd+mea/p27NjLI37GTua0=;
 b=favt26KKfIIjyQonuiqdHxpmhY39UzRsOWUQtCkJyFwokeYxPA753wgfUpPEjdxWUsLZtKgs25KVQsbRSf2Z+kUwhGXKvN6nx0TzutBHRYqBaSKIpGA4poyo9op6/1ScdqO24yRpfJxFG9xRf8ndzl5oNwpEJV2sITms9+xYVE8OJXqMsZ8eK3R1wboBCU/GDM0DdwaLo8xM6KeHiiIceVjn6c21QzFbbQnH2Atzj3ZVvj+/skjqJxFvxIuenfJt6nQJvQ8CWHk0M/Lp2En80ZmULDJ1AZKRI1u3QRFLrBfHwiYSfTl0XUy33YesVIukCsemzIFnQz9cBlT/HrABng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2gwFane0815iSW0eRv8AMnUd+mea/p27NjLI37GTua0=;
 b=LkJ3OxhqBurLXVzA7ChaqgJmeipm2WhlL05R3xQpN8/1ukrufqtZnbHPTU6U/o41UZ0jVv7aITKZ3LiA0hVtcY2IpYotyln8+vnXFouXt5s3p71zYJwHiVV7Z/3ft7/5z8WKvCvqxeqbxIrWi/tHjGMt0jA/1EXe7gPa18y5B9I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by CH3PR12MB7641.namprd12.prod.outlook.com (2603:10b6:610:150::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.20; Thu, 16 Nov
 2023 19:02:06 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::83d7:9c4f:4d9b:1f2a]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::83d7:9c4f:4d9b:1f2a%5]) with mapi id 15.20.7002.019; Thu, 16 Nov 2023
 19:02:06 +0000
Message-ID: <12f135d1-3924-4053-8c22-3e68ffdfc08b@amd.com>
Date: Thu, 16 Nov 2023 13:02:03 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Revert "drm/amdgpu: fix AGP init order"
Content-Language: en-US
To: Alex Deucher <alexdeucher@gmail.com>, ivlipski@amd.com
References: <20231115214029.960838-1-ivlipski@amd.com>
 <CADnq5_MU3qcH_wMxkL257+cWmWB25qgXGuH8jX7GgWUXRa2m-g@mail.gmail.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <CADnq5_MU3qcH_wMxkL257+cWmWB25qgXGuH8jX7GgWUXRa2m-g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DM6PR11CA0037.namprd11.prod.outlook.com
 (2603:10b6:5:14c::14) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|CH3PR12MB7641:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ee39a78-240c-48d0-a7dc-08dbe6d68677
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Uf64IhSzPtuF5PDz+WQIz3PnsNS3pNCPoUObSsZ8BWHJvezqCyd/Kruj6Fqrhmh/umQvSeSrjcDWtWlVgQETueNzPhqcNpK3x6OuJFy2Xo4R4m5vI8zqYpLls11NNsljhQopWwKGfBQS3mo6uXRv3/vX8lU4xDsC9ypHLobhOuL8i/I29Me2HLGxrLgQEEWI27qUuNOmOa9ps82OfTGj94z1JDCrCKUWOlpqb6hJZeTQne/iwX95EPXx9X37L3LIeeTj5iVcaIHPE+Ol30G4mxwVpaytKweuRDhJkXusa+eFVm5r6C6GrYjGsvoH2g/TK74QdKSBwVWNPo8/YqfqhgRIFNB0+nD1ea7UneQ9VbMzvfB9p4gFdSbGVouSJg5WbR51Y3X3SQ2e7ci2EgshB/GQUprF3jnlXscqr8UUoNpdmYagPK6+ty15LlvjeH0hhRK04h/8f4HhK4zCQXyO9CEmWBqpvyokgl4D0/N57WgD7DH2aC1AVLYS78D8e0fgwCtmjG00q4cm+mX6F+aM6o8iLopI6QtOp6R3dCulURUuQfpDMJZm1KWKMasXrD6CPi4+MIU9Xet84LNwJPLUKp+8cSUW/dNRbl+D+KderDZeDH4sW/D3L3vwCVamyDHo4fkW0Q79sOSobyYmz4hjuzW+TbsyDFa5DOJOaeomp1w=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(376002)(346002)(396003)(366004)(136003)(230922051799003)(186009)(451199024)(64100799003)(1800799009)(6486002)(966005)(478600001)(6666004)(2906002)(2616005)(45080400002)(31696002)(6506007)(5660300002)(53546011)(86362001)(8676002)(4326008)(8936002)(44832011)(6512007)(30864003)(66476007)(66556008)(6636002)(316002)(66946007)(41300700001)(31686004)(83380400001)(38100700002)(26005)(36756003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MmNQVXJMYW9sK1hZVjlNTzVpeXNUTXJHNWJwTkkxVnk2RSsrS0ViQjlPcllM?=
 =?utf-8?B?V3g1cWVJdU0zRlNSZjBYRWtJbWZQdjJYNU9pNi9EbDljZzRacmZ3N3lJQzA2?=
 =?utf-8?B?ZHRDQWJJbS95UEdXVjdyZXBHVHB3NngwNHd6SU41cmtINnprcmUza0dXc3ox?=
 =?utf-8?B?Um5kQkN1VGtiWENIRmF1LzVMNVZyYVZuU25uV1RsOHpyR29OazlYR09qREdW?=
 =?utf-8?B?WU5XeEpQVWZDZWlLS1UxVjRKa241MlhsRlJ1Tkw5eVk3YkJra25OaDdiMnpr?=
 =?utf-8?B?NVNFUGEvRngvUjk0WkVOaWU1VERoMFp2TWEzZ2doOEp6eGVxSHBjQ3RXM0Iw?=
 =?utf-8?B?aEpxZTkrZ3JDcUVLeHk4YWpGaDYxQ1pwZi8vR3JTd3l6UG1zRE1QWituSzFK?=
 =?utf-8?B?WDZaS0lDaFhtbWFzOG9ibVNUVnFIVmdnR09CakcxTmNTbERYNVBYZ0x4STUv?=
 =?utf-8?B?VzdNVTNZM04zZ3dJRkxxcVEzcDhoSUtCRkpLRC9ZZmlyMnlUTUtObzdLTmc4?=
 =?utf-8?B?YlJxZW11Mk9JaHdNNVRJQTFPS0JnajJpVUVBbmNvbHJkVlNKY0pWNWI5T3Nk?=
 =?utf-8?B?WmI0N3lSeWFFeTQ4elJmWWQ2cm1MSThtUnc0RVlsNDEvR0tuRFgrazRFbmhT?=
 =?utf-8?B?ekdiVUhUcjFGQzRteGk3cGp0T2J2aUt0SkRZVzFxcWgzTm1JQThWWDlLam1N?=
 =?utf-8?B?Nk4xL01kQWVaZEcraDlCRXVobFBvd3RvdlpUVi81Y2lGWWhXQWtOdnZLSE95?=
 =?utf-8?B?UC84MmtUL1hFeFVYS1MyZm02NjdHSlltTTcrZk03dERDVHBaZzBtMkVCNlg3?=
 =?utf-8?B?RGZpbzEwODh0MmFob0RGS2tiKzZGWXpXQjZBOWI4TmdtR0dsUWlzcVRJTEJu?=
 =?utf-8?B?TlpQNktYcC82cmdVVGZiV0U0dGRmNkJzckNndS9ZL1ZrQ3psQk9yaXBlT3l0?=
 =?utf-8?B?MHIyc3dGK1gxamhVR0NsU2kwK2k2NCtSV1hmVTVDK1VqVGFaZE5mQ0ZzeWpj?=
 =?utf-8?B?TG11aHZkUSt5TjdkT1BVZE5hVEVVSVJBUC8rWUZ1MExhZEt0aTBHOThsN0s4?=
 =?utf-8?B?MnJVbFpRQlZhWVgrZGUrenIrczMvbEJCVkVIeitkRGw5NVR4d1hvaHhOYm9M?=
 =?utf-8?B?MlA3N29xYndGU09MbmlhMTlWZXQ5QklONkRIQkttaDBGbzBhc2k4cXZrN3lU?=
 =?utf-8?B?SE5SNGM3QnZqWUVGSjcrTzdzSnBjVGNpSHA4YTZ5QlBGRmVCNTQ1Skh3WFJH?=
 =?utf-8?B?SGtlUzNScHAreWJGM2VIRyt2SmxjL2l5eXlhTGFhZVFOeU0zM3VpMTdTVWN5?=
 =?utf-8?B?NmtXTEV3WUxFRGJFU3JYQVhlZzk2YkNhZ09ZMW5IcUFzYmJrR1d4SDYrNFda?=
 =?utf-8?B?dXNqbml2azB0b3FOckFMVWZCZjBMbUUzeGJCbm8rYzFvZGJyWDhpZmJxL2do?=
 =?utf-8?B?bjYzaW15VHRXR1dKSGlCWVZDaFJ2WHFUdUFMbW4vL0RkWFY2LzV2WW8xbVJU?=
 =?utf-8?B?NWZkL0tNMWx4K2NrUENWV0I0UGtxM1FZZ1JpWUI1alE4Rnl2YWlhV0Y0TEFC?=
 =?utf-8?B?UTVaSkpxbzB5VWNyemE2MTZ5MDBSaFlKN0sxMGN4cm9CN054YTRTRDNKSWx0?=
 =?utf-8?B?SUwzZXh5Y1ZFNzE3c0hvZU5pM21KRkt3czZlcnJyNFR1Y3cwWUZ5eTI0dEFO?=
 =?utf-8?B?Rk01ZUVxZDNlcExBOFRHMGUxeDQvZ2FBQ0JKUGFUZ0diOEF6YTQ5NVI2WTl6?=
 =?utf-8?B?VzFaem9OeUEzZ0h2YmRvRXNMUVpsWmUvazBTdFB1QUswUldmVldhYVpNSU01?=
 =?utf-8?B?UFU1WTlKM0pGYVJod0JlOTNvdndVZWVMK2w1MGsyL1NUdjhKWmxPM3FIeUh5?=
 =?utf-8?B?Z0h6Y2FQb2FsVkVjTmMyNG9YVlQwa1owV3owSGxyK3ExNWUvWXZiU1Vmb3JQ?=
 =?utf-8?B?Y2hOZnNvUCs2QURGaGk3dUZQaHNvdE94Q0hyaDZkenBaK2g1Q2RPdy9kV1gy?=
 =?utf-8?B?UG5YOWFiNk5uY0NtSDR5OHJ3azVUaFI0bThNZEpJaFVRS1VxRHp4R1ErZlUv?=
 =?utf-8?B?WGhLcmg0cERoNVpHc3hjV2Q4bTJSaktLb1dmWGZpVXI0cCswN2Z1RE5WZVhZ?=
 =?utf-8?Q?BPMoKjEUvMhpx+uSCwbaDTxWL?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ee39a78-240c-48d0-a7dc-08dbe6d68677
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2023 19:02:05.8661 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wmta4ZDwE3icwrRzn/kz8M6ubUsuPdVVlp1bpzh5fEOE+GEMHa7yE2eexo8IY0fwj9ldMo+4s6+E3OIllXDMqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7641
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
Cc: kenny.ho@amd.com, rodrigo.siqueira@amd.com, amd-gfx@lists.freedesktop.org,
 aurabindo.pillai@amd.com, nicholas.choi@amd.com, hamza.mahfooz@amd.com,
 alexander.deucher@amd.com, harry.wentland@amd.com, christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 11/16/2023 09:00, Alex Deucher wrote:
> This will break other things.  The proper fix is either:
> https://patchwork.freedesktop.org/patch/567101/
> and/or:
> https://patchwork.freedesktop.org/series/126220/
> 

I applied the both of these series on 6.7-rc1

e5e258131973 (HEAD) drm/amdgpu/gmc9: disable AGP aperture
88c7088cb01e drm/amdgpu/gmc10: disable AGP aperture
873787b04834 drm/amdgpu/gmc11: disable AGP aperture
9a33a54eb5dd drm/amdgpu: add a module parameter to control the AGP aperture
fdc3daa185e5 drm/amdgpu/gmc11: fix logic typo in AGP check
8a51f3ea4ed3 drm/amdgpu: fix AGP addressing when GART is not at 0
b85ea95d0864 (tag: v6.7-rc1, origin/master, origin/HEAD, master) Linux 
6.7-rc1

But I end up with a NULL pointer dereference on a Phoenix system during 
bootup:

[   28.980823] [drm] GART: num cpu pages 131072, num gpu pages 131072
[   28.980846] BUG: kernel NULL pointer dereference, address: 
000000000000000c
[   28.981424] #PF: supervisor read access in kernel mode
[   28.981849] #PF: error_code(0x0000) - not-present page
[   28.982259] PGD 0 P4D 0
[   28.982469] Oops: 0000 [#1] PREEMPT SMP NOPTI
[   28.982817] CPU: 10 PID: 547 Comm: (udev-worker) Not tainted 
6.7.0-rc1-00006-ge5e258131973 #175
[   28.984060] RIP: 0010:amdgpu_gmc_agp_addr+0x16/0x60 [amdgpu]
[   28.984828] Code: 00 00 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 
90 90 90 0f 1f 44 00 00 48 8b 87 88 01 00 00 49 b8 ff ff ff ff ff ff ff 
7f <83> 78 0c 01 75 2e 83 78 28 02 74 28 48 8b 40 18 48 8b 97 60 01 00
[   28.984829] RSP: 0018:ffffc90000ff7998 EFLAGS: 00010282
[   28.984831] RAX: 0000000000000000 RBX: ffff888103f83800 RCX: 
0000000000000000
[   28.984832] RDX: 7fffffffffffffff RSI: ffff888103f83858 RDI: 
ffff888103f83858
[   28.984832] RBP: ffff888102f0f020 R08: 7fffffffffffffff R09: 
0000000000000000
[   28.984833] R10: 0000000000001000 R11: 0000000000001000 R12: 
ffff888103f83800
[   28.984834] R13: ffff888102f0fdf8 R14: ffff888102f0fe00 R15: 
0000000000000000
[   28.984835] FS:  00007fe6aa26a8c0(0000) GS:ffff88844e880000(0000) 
knlGS:0000000000000000
[   28.984836] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   28.984837] CR2: 000000000000000c CR3: 000000011556e000 CR4: 
0000000000750ef0
[   28.984838] PKRU: 55555554
[   28.984839] Call Trace:
[   28.984842]  <TASK>
[   28.984845]  ? __die+0x20/0x70
[   28.984850]  ? page_fault_oops+0x151/0x4b0
[   28.984854]  ? srso_alias_return_thunk+0x5/0xfbef5
[   28.992663]  ? do_user_addr_fault+0x65/0x6b0
[   28.992672]  ? exc_page_fault+0x74/0x170
[   28.992676]  ? asm_exc_page_fault+0x22/0x30
[   28.993714]  ? amdgpu_gmc_agp_addr+0x16/0x60 [amdgpu]
[   28.994455]  amdgpu_bo_gpu_offset_no_check+0x1a/0x70 [amdgpu]
[   28.995110]  amdgpu_bo_create_reserved.part.0+0x109/0x290 [amdgpu]
[   28.995786]  ? __pfx_amdgpu_bo_destroy+0x10/0x10 [amdgpu]
[   28.996400]  amdgpu_bo_create_kernel+0x3f/0xa0 [amdgpu]
[   28.996992]  amdgpu_device_init+0x15fa/0x2b60 [amdgpu]
[   28.997591]  ? pci_bus_read_config_word+0x46/0x80
[   28.997598]  ? srso_alias_return_thunk+0x5/0xfbef5
[   28.998385]  ? do_pci_enable_device+0xd4/0x100
[   28.998390]  amdgpu_driver_load_kms+0x15/0x190 [amdgpu]
[   28.999194]  amdgpu_pci_probe+0x180/0x570 [amdgpu]
[   28.999781]  ? srso_alias_return_thunk+0x5/0xfbef5
[   29.000232]  local_pci_probe+0x43/0xa0
[   29.000552]  pci_device_probe+0xc5/0x270
[   29.000883]  really_probe+0x1b4/0x420
[   29.001194]  __driver_probe_device+0x84/0x170
[   29.001558]  driver_probe_device+0x1e/0xb0
[   29.001901]  __driver_attach+0xe5/0x1f0
[   29.002224]  ? __pfx___driver_attach+0x10/0x10
[   29.002594]  bus_for_each_dev+0x75/0xd0
[   29.002919]  bus_add_driver+0x112/0x220
[   29.003243]  driver_register+0x5c/0x120
[   29.003569]  ? __pfx_amdgpu_init+0x10/0x10 [amdgpu]
[   29.004148]  do_one_initcall+0x41/0x300
[   29.004471]  ? srso_alias_return_thunk+0x5/0xfbef5
[   29.004876]  ? kmalloc_trace+0x25/0x90
[   29.005197]  do_init_module+0x64/0x250
[   29.005201]  init_module_from_file+0x8b/0xd0
[   29.005207]  idempotent_init_module+0x181/0x240
[   29.006235]  __x64_sys_finit_module+0x5a/0xb0
[   29.006238]  do_syscall_64+0x5c/0xe0
[   29.006868]  ? srso_alias_return_thunk+0x5/0xfbef5
[   29.006870]  ? syscall_exit_to_user_mode+0x27/0x40
[   29.006872]  ? srso_alias_return_thunk+0x5/0xfbef5
[   29.008000]  ? do_syscall_64+0x6b/0xe0
[   29.008004]  entry_SYSCALL_64_after_hwframe+0x6e/0x76
[   29.008703] RIP: 0033:0x7fe6aa125c7d
[   29.008991] Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 
48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 
05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 6b 81 0d 00 f7 d8 64 89 01 48
[   29.008993] RSP: 002b:00007ffe22be7618 EFLAGS: 00000246 ORIG_RAX: 
0000000000000139
[   29.010434] RAX: ffffffffffffffda RBX: 000055b2f8dee0f0 RCX: 
00007fe6aa125c7d
[   29.010435] RDX: 0000000000000000 RSI: 00007fe6aa33544a RDI: 
0000000000000017
[   29.010436] RBP: 00007fe6aa33544a R08: 0000000000000040 R09: 
fffffffffffffde0
[   29.010438] R10: fffffffffffffe18 R11: 0000000000000246 R12: 
0000000000020000
[   29.010439] R13: 000055b2f8f12ba0 R14: 0000000000000000 R15: 
000055b2f8f49ef0
[   29.010443]  </TASK>
[   29.010444] Modules linked in: binfmt_misc squashfs vfat fat 
snd_hda_codec_hdmi intel_rapl_msr intel_rapl_common amdgpu(+) 
snd_soc_dmic snd_ps_pdm_dma snd_soc_ps_mach snd_hda_intel 
snd_intel_dspcfg snd_soc_core snd_hda_codec snd_compress ac97_bus 
snd_pcm_dmaengine snd_hda_core snd_seq_dummy uvcvideo snd_hwdep uvc 
hid_sensor_magn_3d hid_sensor_gyro_3d snd_seq_oss videobuf2_vmalloc 
snd_pci_ps hid_sensor_trigger videobuf2_memops hid_sensor_iio_common 
snd_seq_midi snd_rpl_pci_acp6x snd_seq_midi_event 
industrialio_triggered_buffer kfifo_buf videobuf2_v4l2 snd_acp_pci 
edac_mce_amd industrialio crct10dif_pclmul videobuf2_common snd_rawmidi 
snd_acp_legacy_common polyval_clmulni amdxcp gpu_sched polyval_generic 
snd_pci_acp6x joydev i2c_algo_bit videodev drm_suballoc_helper 
drm_ttm_helper snd_seq snd_pcm ghash_clmulni_intel ttm sha512_ssse3 
snd_seq_device drm_exec sha256_ssse3 mc snd_timer snd_pci_acp5x 
drm_display_helper sha1_ssse3 snd_rn_pci_acp3x snd_acp_config wmi_bmof 
snd rapl cec snd_soc_acpi drm_buddy soundcore i2c_piix4
[   29.014048]  snd_pci_acp3x k10temp amd_pmf platform_profile 
hid_sensor_hub amd_pmc hid_multitouch serio_raw kvm_amd ccp kvm 
irqbypass iptable_filter ip6table_filter ip6_tables br_netfilter bridge 
stp llc arp_tables parport_pc ppdev lp parport loop fuse ip_tables 
rtsx_pci_sdmmc mmc_core video nvme crc32_pclmul crc32c_intel thunderbolt 
nvme_core amd_sfh r8169 rtsx_pci wmi i2c_hid_acpi i2c_hid
[   29.023590] CR2: 000000000000000c
[   29.023856] ---[ end trace 0000000000000000 ]---
[   29.024220] RIP: 0010:amdgpu_gmc_agp_addr+0x16/0x60 [amdgpu]
[   29.024886] Code: 00 00 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 
90 90 90 0f 1f 44 00 00 48 8b 87 88 01 00 00 49 b8 ff ff ff ff ff ff ff 
7f <83> 78 0c 01 75 2e 83 78 28 02 74 28 48 8b 40 18 48 8b 97 60 01 00
[   29.026324] RSP: 0018:ffffc90000ff7998 EFLAGS: 00010282
[   29.026737] RAX: 0000000000000000 RBX: ffff888103f83800 RCX: 
0000000000000000
[   29.027290] RDX: 7fffffffffffffff RSI: ffff888103f83858 RDI: 
ffff888103f83858
[   29.027848] RBP: ffff888102f0f020 R08: 7fffffffffffffff R09: 
0000000000000000
[   29.028401] R10: 0000000000001000 R11: 0000000000001000 R12: 
ffff888103f83800
[   29.028960] R13: ffff888102f0fdf8 R14: ffff888102f0fe00 R15: 
0000000000000000
[   29.029521] FS:  00007fe6aa26a8c0(0000) GS:ffff88844e880000(0000) 
knlGS:0000000000000000
[   29.030147] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   29.030600] CR2: 000000000000000c CR3: 000000011556e000 CR4: 
0000000000750ef0

> Alex
> 
> On Thu, Nov 16, 2023 at 7:27 AM <ivlipski@amd.com> wrote:
>>
>> From: Ivan Lipski <ivlipski@amd.com>
>>
>> This commit caused a page fault issue on RX7000 series GPU.
>> It would occur when running different IGT tests, including
>> kms_properties*
>> kms_cursor_legacy*
>> kms_prop_blob@blob*
>>
>> It would also occur on desttop after some time of idling.
>>
>> The easiest fix for it seems to revert it.
>>
>> This reverts commit b93ed51c32caad2b96cbc8e4754802078ede87ab.
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 3 +++
>>   drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c     | 1 -
>>   drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c     | 1 -
>>   drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c      | 1 -
>>   drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c      | 1 -
>>   drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c      | 1 -
>>   drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c      | 2 --
>>   7 files changed, 3 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>> index cef920a93924..0dcb6c36b02c 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>> @@ -1062,6 +1062,9 @@ static const char * const amdgpu_vram_names[] = {
>>    */
>>   int amdgpu_bo_init(struct amdgpu_device *adev)
>>   {
>> +       /* set the default AGP aperture state */
>> +       amdgpu_gmc_set_agp_default(adev, &adev->gmc);
>> +
>>          /* On A+A platform, VRAM can be mapped as WB */
>>          if (!adev->gmc.xgmi.connected_to_cpu && !adev->gmc.is_app_apu) {
>>                  /* reserve PAT memory space to WC for VRAM */
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
>> index 0ec7b061d7c2..a43d1aa42e11 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
>> @@ -672,7 +672,6 @@ static void gmc_v10_0_vram_gtt_location(struct amdgpu_device *adev,
>>          /* add the xgmi offset of the physical node */
>>          base += adev->gmc.xgmi.physical_node_id * adev->gmc.xgmi.node_segment_size;
>>
>> -       amdgpu_gmc_set_agp_default(adev, mc);
>>          amdgpu_gmc_vram_location(adev, &adev->gmc, base);
>>          amdgpu_gmc_gart_location(adev, mc, AMDGPU_GART_PLACEMENT_BEST_FIT);
>>          if (!amdgpu_sriov_vf(adev))
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
>> index ba4c82f5e617..ee7f3f8c1b4a 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
>> @@ -637,7 +637,6 @@ static void gmc_v11_0_vram_gtt_location(struct amdgpu_device *adev,
>>
>>          base = adev->mmhub.funcs->get_fb_location(adev);
>>
>> -       amdgpu_gmc_set_agp_default(adev, mc);
>>          amdgpu_gmc_vram_location(adev, &adev->gmc, base);
>>          amdgpu_gmc_gart_location(adev, mc, AMDGPU_GART_PLACEMENT_HIGH);
>>          if (!amdgpu_sriov_vf(adev) &&
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
>> index 42e103d7077d..7f66954fd302 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
>> @@ -211,7 +211,6 @@ static void gmc_v6_0_vram_gtt_location(struct amdgpu_device *adev,
>>
>>          base <<= 24;
>>
>> -       amdgpu_gmc_set_agp_default(adev, mc);
>>          amdgpu_gmc_vram_location(adev, mc, base);
>>          amdgpu_gmc_gart_location(adev, mc, AMDGPU_GART_PLACEMENT_BEST_FIT);
>>   }
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
>> index efc16e580f1e..61ca1a82b651 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
>> @@ -239,7 +239,6 @@ static void gmc_v7_0_vram_gtt_location(struct amdgpu_device *adev,
>>
>>          base <<= 24;
>>
>> -       amdgpu_gmc_set_agp_default(adev, mc);
>>          amdgpu_gmc_vram_location(adev, mc, base);
>>          amdgpu_gmc_gart_location(adev, mc, AMDGPU_GART_PLACEMENT_BEST_FIT);
>>   }
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
>> index ff4ae73d27ec..fa59749c2aef 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
>> @@ -413,7 +413,6 @@ static void gmc_v8_0_vram_gtt_location(struct amdgpu_device *adev,
>>                  base = RREG32(mmMC_VM_FB_LOCATION) & 0xFFFF;
>>          base <<= 24;
>>
>> -       amdgpu_gmc_set_agp_default(adev, mc);
>>          amdgpu_gmc_vram_location(adev, mc, base);
>>          amdgpu_gmc_gart_location(adev, mc, AMDGPU_GART_PLACEMENT_BEST_FIT);
>>   }
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>> index c1f2f166f064..83733156ee53 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>> @@ -1621,8 +1621,6 @@ static void gmc_v9_0_vram_gtt_location(struct amdgpu_device *adev,
>>   {
>>          u64 base = adev->mmhub.funcs->get_fb_location(adev);
>>
>> -       amdgpu_gmc_set_agp_default(adev, mc);
>> -
>>          /* add the xgmi offset of the physical node */
>>          base += adev->gmc.xgmi.physical_node_id * adev->gmc.xgmi.node_segment_size;
>>          if (adev->gmc.xgmi.connected_to_cpu) {
>> --
>> 2.34.1
>>
> 

