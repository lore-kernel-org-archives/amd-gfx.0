Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 748A7C4708E
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Jan 2023 14:19:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EA0E710E20F;
	Wed,  4 Jan 2023 14:19:09 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2044.outbound.protection.outlook.com [40.107.93.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D52B10E20F
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Jan 2023 14:19:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=glV8whuolrypcmvShV/UsB10j93jVLRFEGfnilsaCsOtcDoZwuz0fR3O7cWSevrCMZVHKNO+m55rJ3osUjOkl3CQaHLlzxgaz/Qk4Nqy5pCixIIBLaB/P7EzVdmMjCNq1yIW+9WjFi3mThdq5/80T+AoBBd9CE97ngu6kmf4bLFg3WR0RAdid9xT/lyQPEPQurSTfypB4usf+dWNHOQ9P3NJ2TeSHVgfzB8IgShhyfXy48u+Jja6QjBFQQjWqSMmnW3obax67TnxaGVTYuR9kO1B6N2mVQxxV1ySkostgiW522qpjniyxUDjme2nH2xgdjWIK/GxGgmUwlgdCYlRbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9uaWpAvD3ca+bAzsUg6gOIdPfB2Gdxs2dKk9lvWEfPQ=;
 b=gkzPO8HYvxkdOUiWz1IMsb6ZZtjch1AMqAornGrBbAIJ1MEo/fQ+Rr9mZnlAD6P7N0JJ0J4GzVhvzPoIlvP1/BIuDPz3AP5x4cDne7sdBNJnVKlUnsAx52JB/9dNq9iOl8uTaMvJOMPSTJFGLCeDhSbJiQr54oprm7waBhMaYGVtwtIaygbp20sOy4sD0U5MO8dmi0kk1YrXEZxq3wUDTKQn6mOIDkAVpp+9PV/OF3jraZO3i38rkrDrq4MvCpnZukmBxG/e1/MXjUeSFvTPU+lxFipE4SXfNZAkOlpkwZfW3cBQISOAhMuPa/L8+MnOUIOupGv4U6H7TZ/fO17xtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9uaWpAvD3ca+bAzsUg6gOIdPfB2Gdxs2dKk9lvWEfPQ=;
 b=lJnBSWhOGJY1kJmhoMAl694/DqqPlaqBnQ78mETIQOeeGI1MlSsBE+fus/2/gEjkE4ocw/tqrYIctXzS2z9WlhLY7g9soRT7OrWKDpiUjLZI/IZWL0CWRmFCyc2BEDnS4Fi8kH1pMdENEYcVos+qp22m2v/7tT81n/Zi0uVh92Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by SA0PR12MB4544.namprd12.prod.outlook.com (2603:10b6:806:70::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Wed, 4 Jan
 2023 14:19:05 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::457b:5c58:8ad2:40fa]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::457b:5c58:8ad2:40fa%6]) with mapi id 15.20.5944.019; Wed, 4 Jan 2023
 14:19:05 +0000
Message-ID: <8ec2b238-fa8b-a693-b9d9-3a590cc05664@amd.com>
Date: Wed, 4 Jan 2023 19:48:55 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH 1/2] drm/amdgpu: return the PCIe gen and lanes from the
 INFO
Content-Language: en-US
To: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>
References: <CAAxE2A720cJguG5b+0zbP=G4TxTjpqKBvOqDXXAP0LWHZEuj0A@mail.gmail.com>
 <0931a762-c3a3-16c3-33a5-88e83fca4bcb@gmail.com>
 <CAAxE2A5pBqOkny15tSRCWn_UW8=TTE=zYPChBZofZCrHZoQbww@mail.gmail.com>
 <35304b1e-98a7-d342-9f1b-50f07b45cf98@gmail.com>
 <CAAxE2A6KJWPJ3eqKoaiJZUJCNqRpx+WYwoGEZKxX2Kf_auLUWg@mail.gmail.com>
 <a90b0e8e-dd02-031f-0432-1c5f6f02e949@amd.com>
 <CAAxE2A7PJdiPORP-X+7kFmix9pCo63PqeamP20BZJx4GDfJdEQ@mail.gmail.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <CAAxE2A7PJdiPORP-X+7kFmix9pCo63PqeamP20BZJx4GDfJdEQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN0PR01CA0047.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:49::11) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4614:EE_|SA0PR12MB4544:EE_
X-MS-Office365-Filtering-Correlation-Id: 08ce2626-78d0-4fd0-1b98-08daee5ea296
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bfgajT2XgU1P7s4mOr5bekYHIUDLAiAkmDw8Dz5or2gB4VD1yGzJuU8M+WDg5Ebvpv6CgbdkubJUtIcZjMfQPGV1HLf1LyomRZmNCZuUFUaIwjwbZn5doTMqpr8YQfs0R8ZiDjWngVXT/mGKhl92Z3utQwqctgWeVTHbbw8Qe55FqFmw6YDarPWo6AEHEXIFWQdvWvHdYCVJuq8GArW7MhPf+47ATVFOKPWlURxR8XVDV73lkPO5Cl2CN4HGSmMf74acGJ6liA/mxj5ez5gn6iyOWk3eH94XF5/eGXudZFjV1PAg84AGbNTFyDClxkOoJxf1YRP6Rm+/8elb2uqRSmRE22MG3L/gfCqbyD9NfNcWeSroVQ73mBPKvb4np6TEwmfWEllMohVvH84Gz6ZtDibpl1D0qJaZcMGgYICAgZSktQlhzloth0EoaW/VfSlZlNpmsbu/zxdpmBOYFxEFv4mYR5H/No8bgszQCsEVHJWBr9AzHzH74ea/eru8lVhGc5yB+PJlt4rv3j87cmFyHDowTNPVGan26pb/v0y0x1qoeL8E/U0X6qpmAQmvd2RMeIlmiHnvotwl3kHMZn08vfrpumtr442qyY1DMFLFZVaQyrndkUnUxfp2DnjJRuf6CFkvnQeNJ+fXDB9/xXVIEdk+BWcZxBl6TzpeLYhxFqXYtULbFMTR7xoRo1cD+XIT+F8vF+h718/nVeU3a/Onh2a4784bkHN+IIirfBKI+6M=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(346002)(136003)(396003)(366004)(376002)(451199015)(6512007)(26005)(6666004)(6506007)(86362001)(31696002)(36756003)(53546011)(2616005)(38100700002)(186003)(4326008)(478600001)(41300700001)(8676002)(2906002)(5660300002)(8936002)(316002)(66556008)(31686004)(6486002)(66946007)(66476007)(6916009)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ek5IYVZVOHR1aWN0dXRIWVRpZkxodHpwUnRpSEpZb0tZdFJVcEpoTk52MnB3?=
 =?utf-8?B?TmJNTHYxY0RoL0ErZ3hHZkIyWDJuV3VUdHRONkgvQVZ0ZUpnTVZhY2lZZVFq?=
 =?utf-8?B?STdsMmdrOVJUMXNQODFzeFFlTjFaNkVrZ08zWktkQzB1NnhlajhyWURzckxL?=
 =?utf-8?B?VTBVY3pxa2RQK3hDNlAzU3ZpQTJDeWVoNEN5MDljdkR1RmJ3dmRadndqSUxV?=
 =?utf-8?B?V3BEU3dhQlFjYmFORER6dTBCaG5VN2kxK0NKbktCM1c5bGVOeWNqcjNYZ1Vk?=
 =?utf-8?B?WHg2UHlaWmVLdmNuTWhFTko0Y3NrRkVMV0psb3ZkaTZRaGk3WS9xVFJqRGFT?=
 =?utf-8?B?RzlpZHVnbkVEY3hCVU9qQnRNYlBxdEJpMVI4aElDWmdMdzlJMGc3MGJuaGla?=
 =?utf-8?B?Z01DQkdlYU9KOXpGa2FlUCtoTjhzQncwdnlYNHQ0UDVYMWZDT2dPTkVKRjR0?=
 =?utf-8?B?RDhhbk9RSUlVVmx6cndvaXRCR3NqQXVSdnlmQUJpbTdsQzdXK3N0SnZybHRR?=
 =?utf-8?B?aUQrMjFWbXRPQlRyK3JmWmVJdkpkQkc2eXRJZDlsTWdVNFh3SmR6dXphQm5t?=
 =?utf-8?B?TVMyMUNHbm00VlVESjlpZjFGZTdpTFZEanV6SWlndE5VVnY2ZHAxbDRTOFdi?=
 =?utf-8?B?R0FYVzFEaFhXS1d5djJ0OFpVK2ZMQnRMNDF6YWt3Rmk1SFNyZkJBeVBDYkF3?=
 =?utf-8?B?c0FNSmNzQlVUUGFrZ0ZUZUFlMlFXZlhuRjNKQUJaRHo0UU1PNk5Oc0U5TW42?=
 =?utf-8?B?dkNSLzJ1aGxDZWdielhLNlBvV0h3QTQxemc2UVVTeWpDS0NSRWdOVTlJTU1E?=
 =?utf-8?B?SXd0U0hudVlRWU03Y29wcVhJeU5TeXNIdTlhd09ETFVIWkhySjRzOUg4N3dO?=
 =?utf-8?B?TVg0UnFJRytuNEpPV1BOZlJnUjArNXpMMnVIKzZDVVFTUUVoa1kybjVOMzVx?=
 =?utf-8?B?S3NQeVFsVkdMbW82ZlNuSjcyMEZ5K3hpQTE4NWxlNHd2OHJxZEdETGpORmJE?=
 =?utf-8?B?OG1rUUdJcXErR1BSSTlzdC9uemZNeWZwWTB2Y25SSUgwRlFHWi9YZTZnRUxj?=
 =?utf-8?B?RWNjc2xnVnVZajh4djg3Y2ljVTZ0NmgxOUloZ09XdXUrVURUOWs0QWpFTDRN?=
 =?utf-8?B?TTIzeERiM2N1YkI1bktwVzhIT3pJT2FhSTVXNy8rbjdpcFZXMjNGbzM3bE9P?=
 =?utf-8?B?Nkc3YWVkb0oyTFJEdkpWMjA0UWdGb3gwdGtsdmtVaUFLQmJXdXgwVUVDTDBl?=
 =?utf-8?B?YVpvWmdMOEpVREFETUtzUDE4R3JnV2xzZ2FuSWFEK1VjbGc3WkdxWFFpYWRC?=
 =?utf-8?B?Ym1rNHRuT3M1TlkzUjZ2V0p5UXpXNXJsSlYwQWZuVDNGRmgvSXB0eWNhK2hr?=
 =?utf-8?B?bTZZZFNVeVJFcDF6UGkvb29iUlF0VlNOVXFvcFRMN1NVZzcrNXNxRnBzcDcz?=
 =?utf-8?B?cWU4V1ErR0ZWUjRubjRxV01tbi9lU01KdXVLNXZHWmkrSWdTSzRTNjVsMGRr?=
 =?utf-8?B?eWF0aW9tYXd4QlE3Q2ZLcnFnNkg5V1pocFNObG9qNmVaZjNDNnl2WnhvYlQr?=
 =?utf-8?B?YTZUL0dZQzVRT3p5SlQzSnVzanNPdE13YzJuVStuVGNjWmEzcHBZa1A3YXBG?=
 =?utf-8?B?TVEwNzFXYmdKVlA5aDI1Zm9HMU9BcHFZalNTS01aNG9LbWlCZGFNTWFxbE0v?=
 =?utf-8?B?ZDZPT2owUDdOb2g2eUQvT3ZaMm5iZWJSRUswNVNCWFZOd0h4ZGx4N2ZidkVV?=
 =?utf-8?B?ZTZ4VkZtZDFXZ3RCa3dkOW5jKzUrTWRkNWNjaUhmNVJRcEVkV3ZzMWovT3pC?=
 =?utf-8?B?TmlWMzNXbmQ5eGxZWDhjdHhnem8zV0grb2pWbFcxQUhva0ZmSS96eExVN01T?=
 =?utf-8?B?eWZzTW1jbC9ISC80QzZCeW5vc21PZFFJRUp5MDhUZTdFS0VRYW9DZDF1WXFD?=
 =?utf-8?B?MU1rS1IvMFMramcwY2tJKzAvQ1pwVnAvaFljUnZrTjNCWWpTd2x1VFJQNEhX?=
 =?utf-8?B?WHd5Uzh2UUZBOENGUmpLTzN3Nm91Q3B6S0xhZDFSa0F3VnhWWFV0QnJrdkRz?=
 =?utf-8?B?VXdKQXZsNkpBV01NSjNJRWZHQlBoMWg4ek01MnFTQjRrOU1pM2JxUUxRSlhS?=
 =?utf-8?Q?DNAaGM0pwktQ0TaId+r/bLk8a?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08ce2626-78d0-4fd0-1b98-08daee5ea296
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2023 14:19:05.1866 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ijCIKCjTkFGcaDUW0gt0o+sG7hKQR3OARFgBzFsvpHF1gAlrFsWywRejqn2HXgR6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4544
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 1/4/2023 7:43 PM, Marek Olšák wrote:
> On Wed, Jan 4, 2023 at 6:50 AM Lazar, Lijo <lijo.lazar@amd.com 
> <mailto:lijo.lazar@amd.com>> wrote:
> 
> 
> 
>     On 1/4/2023 4:11 AM, Marek Olšák wrote:
>      > I see. Well, those sysfs files are not usable, and I don't think it
>      > would be important even if they were usable, but for completeness:
>      >
>      > The ioctl returns:
>      >      pcie_gen = 1
>      >      pcie_num_lanes = 16
>      >
>      > Theoretical bandwidth from those values: 4.0 GB/s
>      > My DMA test shows this write bandwidth: 3.5 GB/s
>      > It matches the expectation.
>      >
>      > Let's see the devices (there is only 1 GPU Navi21 in the system):
>      > $ lspci |egrep '(PCI|VGA).*Navi'
>      > 0a:00.0 PCI bridge: Advanced Micro Devices, Inc. [AMD/ATI] Navi
>     10 XL
>      > Upstream Port of PCI Express Switch (rev c3)
>      > 0b:00.0 PCI bridge: Advanced Micro Devices, Inc. [AMD/ATI] Navi
>     10 XL
>      > Downstream Port of PCI Express Switch
>      > 0c:00.0 VGA compatible controller: Advanced Micro Devices, Inc.
>      > [AMD/ATI] Navi 21 [Radeon RX 6800/6800 XT / 6900 XT] (rev c3)
>      >
>      > Let's read sysfs:
>      >
>      > $ cat /sys/bus/pci/devices/0000:0a:00.0/current_link_width
>      > 16
>      > $ cat /sys/bus/pci/devices/0000:0b:00.0/current_link_width
>      > 16
>      > $ cat /sys/bus/pci/devices/0000:0c:00.0/current_link_width
>      > 16
>      > $ cat /sys/bus/pci/devices/0000:0a:00.0/current_link_speed
>      > 2.5 GT/s PCIe
>      > $ cat /sys/bus/pci/devices/0000:0b:00.0/current_link_speed
>      > 16.0 GT/s PCIe
>      > $ cat /sys/bus/pci/devices/0000:0c:00.0/current_link_speed
>      > 16.0 GT/s PCIe
>      >
>      > Problem 1: None of the speed numbers match 4 GB/s.
> 
>     US bridge = 2.5GT/s means operating at PCIe Gen 1 speed. Total
>     theoretical bandwidth is then derived based on encoding and total
>     number
>     of lanes.
> 
>      > Problem 2: Userspace doesn't know the bus index of the bridges,
>     and it's
>      > not clear which bridge should be used.
> 
>     In general, modern ones have this arch= US->DS->EP. US is the one
>     connected to physical link.
> 
>      > Problem 3: The PCIe gen number is missing.
> 
>     Current link speed is based on whether it's Gen1/2/3/4/5.
> 
>     BTW, your patch makes use of capabilities flags which gives the maximum
>     supported speed/width by the device. It may not necessarily reflect the
>     current speed/width negotiated. I guess in NV, this info is already
>     obtained from PMFW and made available through metrics table.
> 
> 
> It computes the minimum of the device PCIe gen and the motherboard/slot 
> PCIe gen to get the final value. These 2 lines do that. The low 16 bits 
> of the mask contain the device PCIe gen mask. The high 16 bits of the 
> mask contain the slot PCIe gen mask.
> + pcie_gen_mask = adev->pm.pcie_gen_mask & (adev->pm.pcie_gen_mask >> 16);
> + dev_info->pcie_gen = fls(pcie_gen_mask);
> 

With DPM in place on some ASICs, how much does this static info help for 
upper level apps?

Thanks,
Lijo

> Marek
