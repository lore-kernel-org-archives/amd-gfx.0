Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14B47C46467
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Jan 2023 11:50:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 80FA410E57D;
	Wed,  4 Jan 2023 11:50:23 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2085.outbound.protection.outlook.com [40.107.244.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D506F10E1C9
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Jan 2023 11:50:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kzLO7uDzqZ/fZpCjBvNBAGacTNlq/oiPgVwik85vKdnmVIJq8kUI3BVhJ6RS+SrdBs9A1xJP8x4W4bVAE4vrNCnRQHBhnnfjg76jXzcLt1oZU65VujWmEK8RnPToBW4Dz+B90WJbJolNfT3yZlN9LuSd9mt+DYDoeRpYnpwcBQLCQTIr5JZ1npKdBkAeZCAym7fG+S4ShNxGcBd+PQKtoiw43VDNELBxB39uqQbuT+E0/x9yEsiHHsUKx+2DiRx7IMGgZFxt3HMtL1KPe6nBaWybYaeZsqm33P83KqDw3J79cYFcR6QMkmVzANOBgBvMhTFaiPOJLe8W/xxujDFiSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LlFIAYdGC3cGkm81ZCF/CU5ffKSS/AmW8Utnh78Pl34=;
 b=dkWupmqJjkDMQ0y3CI0f+dfbdyEIpE2pZfqIrxWcK3I16b4VZIJWGlxch1Eb0HZgPtvk+omLqumhURQFlfsy0Cf5uVQJ6IlLlkckBEjFgxqcUW6ykQmoPko5Waoww81EyhLMw9pWJNw2FYj108WT1Vgf2t12B4cCG7r1+z+/djffku9pz/V3YwM18krDmpZf+jJiyNY1jwZd/hxJMPgr9CCn7yIRGKhPE04OzujkXqaM8kogkGiNbtPnrCMt4NgdhvFScomQgstibieq3wyTEz/KsYFgUertXwRbUr+40VyJNWEY0+RXwGsu6ujtRRWcyJyz7MFkh1h8hLeCgE/Ocg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LlFIAYdGC3cGkm81ZCF/CU5ffKSS/AmW8Utnh78Pl34=;
 b=1u3mzOxkZsc4BHlQOMrFkza8JpYzU71jfBed1UtkrZaGujnmT7Tfyv9dQs69REMPBvcdj+mOEVv2TBluidd0D2FV6AFhdPJT6b6a8Z2ZFAXwx5QSvjXXc4ZD/iU7/iqpuruZ+j+yeffH3XznahGd+wOY71tMH+rqnxHcmB0wW+E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by PH7PR12MB5880.namprd12.prod.outlook.com (2603:10b6:510:1d8::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Wed, 4 Jan
 2023 11:50:18 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::457b:5c58:8ad2:40fa]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::457b:5c58:8ad2:40fa%6]) with mapi id 15.20.5944.019; Wed, 4 Jan 2023
 11:50:18 +0000
Message-ID: <a90b0e8e-dd02-031f-0432-1c5f6f02e949@amd.com>
Date: Wed, 4 Jan 2023 17:20:08 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH 1/2] drm/amdgpu: return the PCIe gen and lanes from the
 INFO
Content-Language: en-US
To: amd-gfx@lists.freedesktop.org
References: <CAAxE2A720cJguG5b+0zbP=G4TxTjpqKBvOqDXXAP0LWHZEuj0A@mail.gmail.com>
 <0931a762-c3a3-16c3-33a5-88e83fca4bcb@gmail.com>
 <CAAxE2A5pBqOkny15tSRCWn_UW8=TTE=zYPChBZofZCrHZoQbww@mail.gmail.com>
 <35304b1e-98a7-d342-9f1b-50f07b45cf98@gmail.com>
 <CAAxE2A6KJWPJ3eqKoaiJZUJCNqRpx+WYwoGEZKxX2Kf_auLUWg@mail.gmail.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <CAAxE2A6KJWPJ3eqKoaiJZUJCNqRpx+WYwoGEZKxX2Kf_auLUWg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0069.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:23::14) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4614:EE_|PH7PR12MB5880:EE_
X-MS-Office365-Filtering-Correlation-Id: 43fd3dae-f4d9-4e4b-995c-08daee49d9ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: i6h5swxRr906A6N+7DPh5rfG9YG/L7BN0TDDdcsKC/YNpb/3Q2Hcj3RRTyay8JYDFMtC9gUBN7hblSGf4GMmPnBL/N5c8x5Kj1AfChEqW5x1e/viYAHHLgG1AHec7b0hsz+g6L/AohZkVI9rJJzKjIpaD9f2t0kLaBXNvrrXqMULmQGG1/GgO9UU7NNDReOp7HvI+pkhKCJ083ug6jkSnd/TsJ3G4K0TOjXPqmg+af5ZkKQ/WjyIzzGZ+YGlc8OvJRYFEin9PG0UcXhdYxUNMkC7/VFU2Qx74r5gLTwtnK41AZN7Uf3AKH72W2bTyiDarec0w/WbnDqZIxvtmNfYSqWb7RIrmusldwx6qdm5cBhZd80xfu44a2fI7bbUmB4u9Hto04zLWdtmVz/0PGc+jQCrckhXLFsnbj3AN9r9jkh2Oa5tO9nN3T5iGsJpchtEAb7kVs0BW8h1o3/3jgsWDK2RkGeXHQAb/F+rg7LATcOaxRyMqOy0bKaNI6P6n0rEJipvJxpFHjLfM37UL20rUN9RJDpI5sQnzpdpPtxa3AaUsmehZ8R8XTyt3vcXeOyEjQw2jgpz3rn8PYZWOJUJmqPf/JABd3p03qf56L0OvS2DlSx7RN1RmgV96bIxeqhkH2qK/sLUG8QgqmcZCho5FOcv1FlbFbiS2TQAtE9mkryHvLB6DMytwea6F8+J/Acxm9vANz+Xj+A/h6GqCxWU/U72HILdQTnJjJvm9Hn1pY8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(366004)(39860400002)(396003)(376002)(136003)(346002)(451199015)(41300700001)(8936002)(66946007)(5660300002)(8676002)(31686004)(6916009)(2906002)(66556008)(316002)(6486002)(6506007)(53546011)(6666004)(478600001)(66476007)(2616005)(6512007)(86362001)(31696002)(26005)(186003)(83380400001)(66574015)(38100700002)(36756003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?LzJFbThvc2dtaFkrdlhRaDduSk1UbUxQUU9JOVpYaXVjVU5PUytmT2FtNHMr?=
 =?utf-8?B?bzA4dUxoRG0wUGR1OWpoYjNqam96cGdkRXY4U3VWYjl1K3JoSEIzSXVZNGM0?=
 =?utf-8?B?dWppbWZDQUYrSUdxaFIwNldBOHlDYUw0WnZraEQ1RXllcFIzdk9sTm05SVNM?=
 =?utf-8?B?emVWdXBPcFVodjZUblJPQ3RIRGZFamtBZzlEcEllaEhRcHR3YTdlZjVXMXV4?=
 =?utf-8?B?NWlOTFhHaXI2NG12dnprMW9kWUU3ZloxRDh0bkI5QXRQcms0Q05kSmxWcytG?=
 =?utf-8?B?bkw1bjQzcGJLejlXUC80bUFqbzY4dzVQa1FEVllLWXB0SHAzMkR3cExPZzVG?=
 =?utf-8?B?RDI3UWRTVXVENTZ4WmJoWHR5RUNJdzBkSFd6Yi9XN1ZEL3hoWTA4b0ZTZTdk?=
 =?utf-8?B?bGJWWlJSYk85VEhZTS9BS0psMUtLZm4vUEhhL0F1bmZRY01iNktDdDNlTEY1?=
 =?utf-8?B?a3F5LzlpUVowclNubHRoMStQckRRQ1NhVmhyd3gyMjcxRGFVeGZoT0xqc0wr?=
 =?utf-8?B?QVJGT3BXMTNIa0IwZXdMSHI5T1NBVHUzemg3cno1TElwRlAvUktGcTVaeE5m?=
 =?utf-8?B?SkRFUFZsRFZJdncwdzBZSnlHRkdEUSt0czhienVzTTdmbnBGMi84eFRMcGR5?=
 =?utf-8?B?bmN3YkdaaVdmMFl1bXZ6dEE5WFZManRUeEFsMVE3S0k3V0l3RzdYZ2U5dk9G?=
 =?utf-8?B?UlRvb3BodDczMHgvaE5lMmNIVVE4SDJGT1QzYWdlcXNQcTBDandKY3pYQUlE?=
 =?utf-8?B?a0VVVklCMW9XcDJIVVJGYWxjSVFsSTIyblVyZTdXVWlDODNQK3ZNOHhsWjlF?=
 =?utf-8?B?YmlQbFJEL2ZTQ3BCVlo2ZndMd3h5V25hN3ViRmQzY1pMc2xTdG5xeHVlcUNR?=
 =?utf-8?B?dmYrd2FZKzcwUlJTbTZDSi9oQXFmSFNZaCt0a0E3SW1sR1p6R3JWRHlncUlG?=
 =?utf-8?B?RlI5TnF2VXQ2TFcvQTdINUpXLzZIeFJhdzBqS0xCWEh2ekRPMDhSa29nclNw?=
 =?utf-8?B?Ymp3WWY3V3lPM2lPYk1rcThZOHByRG5yME12VWtuMGpkdXo1NUxsaGNOdW12?=
 =?utf-8?B?Q0NjY0kvOVBIQTBRdXoydjMyQStVdDlOR0tMVFIwOEdZKzRoUlBxN0dia3RS?=
 =?utf-8?B?d013TUFHWGVQVlZhclNBMGtJUjJrTGVXdi9Uc1oxRzYxRGRyL0ladEdDUFpB?=
 =?utf-8?B?SEVLQnpJeUQxNFNsSVBnZXJrdTdjVmUzaUpMb3MwYkwydHFrL2V3U1loZ042?=
 =?utf-8?B?VnBxU1F4NlZ6aXh1N2hJbmF0OG14SDc2bmhzNkZKNUlKcjJpSHpDUUorV1Y3?=
 =?utf-8?B?dUt3SlBNbndNTENmbmFpY0lFUmV0RGVFbElnWGNFQ0djVGFQQWU0dldDV29C?=
 =?utf-8?B?eWJWQlhqS3AxQUttTGF0ZmV5a0NwbWFTcFNLTkFoK1EwclpJQW5FV2ZHV0dY?=
 =?utf-8?B?cU54N2JKUnFKK2NQd2NrZnp4cVNNNm5wd1ROdSsrNXh5bGpBVjhNT2dORm9G?=
 =?utf-8?B?dXduQ25IT3hiZW9lK2l3c3A5RmVvc1N4a1dBbTdPODNselFtV2gzRVVyUmpD?=
 =?utf-8?B?VzZqc0hMZ2ZOaHBkRmc3akxEYnJkcEhVSGtyZC9IOStkSUxUZmQ4MEpDd0hw?=
 =?utf-8?B?dVF0MG5wYWR4emx1dU1oNFdxVnVBOG16UmwrWDlwTzE4OVVSajdPbHVYQWIx?=
 =?utf-8?B?Qm1TYW5CbFljOU9LZ3I5ZWZIOGxkNW54d2NzdG9UZFdOS3RoZ2x1eUxUTVVs?=
 =?utf-8?B?SzZyaTl6azNmOFpxemF5ZUlvVm84UFZYQjZRWVlJOENuRlNidUN6WXZSNDNr?=
 =?utf-8?B?VkwyYVBSYkRUcmszYVFhaGlzbW1lYmE3Y3FIRCtWS1JSTXR1bEZHY2lRSDR4?=
 =?utf-8?B?TFZiK25iQ2lOL1IzL0hzaHBvbTMxREJya0YwcUdJUUtsUmgwcURaYW12UG41?=
 =?utf-8?B?V3RFL0M3WHN3M3lIVHBhaEk2aTdmNTBNYzhoMGRnUEk1OGJxRlc4N3FsK3JQ?=
 =?utf-8?B?VGxHUG1oWE4wVlVqSTRIdUF5NFFJdkZaZkhQdWxQZ2ViNzNDWXE2U3dNdDl6?=
 =?utf-8?B?TFoxQjlVRDZMcVVOL3k5Q3l2UzFRNUNrNis1d2Z2VWNQb04zUjlPbW01czE2?=
 =?utf-8?Q?QC2El3vKHW1UPqW1rPPsk4VXW?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43fd3dae-f4d9-4e4b-995c-08daee49d9ea
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2023 11:50:18.5681 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CmK8naHMZC7jnY0NoNiiNm0eYUh/DVU2lNd3gjYqvFMfOros7S4u1efQunQkY2Yv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5880
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



On 1/4/2023 4:11 AM, Marek Olšák wrote:
> I see. Well, those sysfs files are not usable, and I don't think it 
> would be important even if they were usable, but for completeness:
> 
> The ioctl returns:
>      pcie_gen = 1
>      pcie_num_lanes = 16
> 
> Theoretical bandwidth from those values: 4.0 GB/s
> My DMA test shows this write bandwidth: 3.5 GB/s
> It matches the expectation.
> 
> Let's see the devices (there is only 1 GPU Navi21 in the system):
> $ lspci |egrep '(PCI|VGA).*Navi'
> 0a:00.0 PCI bridge: Advanced Micro Devices, Inc. [AMD/ATI] Navi 10 XL 
> Upstream Port of PCI Express Switch (rev c3)
> 0b:00.0 PCI bridge: Advanced Micro Devices, Inc. [AMD/ATI] Navi 10 XL 
> Downstream Port of PCI Express Switch
> 0c:00.0 VGA compatible controller: Advanced Micro Devices, Inc. 
> [AMD/ATI] Navi 21 [Radeon RX 6800/6800 XT / 6900 XT] (rev c3)
> 
> Let's read sysfs:
> 
> $ cat /sys/bus/pci/devices/0000:0a:00.0/current_link_width
> 16
> $ cat /sys/bus/pci/devices/0000:0b:00.0/current_link_width
> 16
> $ cat /sys/bus/pci/devices/0000:0c:00.0/current_link_width
> 16
> $ cat /sys/bus/pci/devices/0000:0a:00.0/current_link_speed
> 2.5 GT/s PCIe
> $ cat /sys/bus/pci/devices/0000:0b:00.0/current_link_speed
> 16.0 GT/s PCIe
> $ cat /sys/bus/pci/devices/0000:0c:00.0/current_link_speed
> 16.0 GT/s PCIe
> 
> Problem 1: None of the speed numbers match 4 GB/s.

US bridge = 2.5GT/s means operating at PCIe Gen 1 speed. Total 
theoretical bandwidth is then derived based on encoding and total number 
of lanes.

> Problem 2: Userspace doesn't know the bus index of the bridges, and it's 
> not clear which bridge should be used.

In general, modern ones have this arch= US->DS->EP. US is the one 
connected to physical link.

> Problem 3: The PCIe gen number is missing.

Current link speed is based on whether it's Gen1/2/3/4/5.

BTW, your patch makes use of capabilities flags which gives the maximum 
supported speed/width by the device. It may not necessarily reflect the 
current speed/width negotiated. I guess in NV, this info is already 
obtained from PMFW and made available through metrics table.

Thanks,
Lijo

> 
> That's all irrelevant because all information should be queryable via 
> the INFO ioctl. It doesn't matter what sysfs contains because UMDs 
> shouldn't have to open and parse extra files just to read a couple of 
> integers.
> 
> Marek
> 
> 
> On Tue, Jan 3, 2023 at 3:31 AM Christian König 
> <ckoenig.leichtzumerken@gmail.com 
> <mailto:ckoenig.leichtzumerken@gmail.com>> wrote:
> 
>     Sure they can, those files are accessible to everyone.
> 
>     The massive advantage is that this is standard for all PCIe devices,
>     so it should work vendor independent.
> 
>     Christian.
> 
>     Am 02.01.23 um 18:55 schrieb Marek Olšák:
>>     Userspace drivers can't access sysfs.
>>
>>     Marek
>>
>>     On Mon, Jan 2, 2023, 10:54 Christian König
>>     <ckoenig.leichtzumerken@gmail.com
>>     <mailto:ckoenig.leichtzumerken@gmail.com>> wrote:
>>
>>         That stuff is already available as current_link_speed and
>>         current_link_width in sysfs.
>>
>>         I'm a bit reluctant duplicating this information in the IOCTL
>>         interface.
>>
>>         Christian.
>>
>>         Am 30.12.22 um 23:07 schrieb Marek Olšák:
>>>         For computing PCIe bandwidth in userspace and troubleshooting
>>>         PCIe
>>>         bandwidth issues.
>>>
>>>         For example, my Navi21 has been limited to PCIe gen 1 and this is
>>>         the first time I noticed it after 2 years.
>>>
>>>         Note that this intentionally fills a hole and padding
>>>         in drm_amdgpu_info_device.
>>>
>>>         Signed-off-by: Marek Olšák <marek.olsak@amd.com
>>>         <mailto:marek.olsak@amd.com>>
>>>
>>>         The patch is attached.
>>>
>>>         Marek
>>>
>>
> 
