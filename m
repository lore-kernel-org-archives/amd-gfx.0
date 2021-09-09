Return-Path: <SRS0=g6Hj=N7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81A6CC433EF
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Sep 2021 16:19:56 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E25C61179
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Sep 2021 16:19:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4E25C61179
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C769F6E8B2;
	Thu,  9 Sep 2021 16:19:55 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2086.outbound.protection.outlook.com [40.107.223.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 946FD6E8B2
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Sep 2021 16:19:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EyCsMXrNhmDTK3CiSrbkJtNgsuM7RZs9OF8JEv8n01VLtRXIOOuFixTLpPOo4EZN5ItyTURQ9+XRCvzmH9TgQdPsKk4h0YmFIlfzED8lx8WUL6n8MDBpRhED/B9sIX6kcowZvinfH6+vC2YiXlQkDmd9yycLfj900jMPvLAKNv4jJGsAitDzxi3qSthzqX+IA5JfjOEHQbRBrt3l38r7lDzsPPqHoW9vOmQGooIE7YyN5zOOlnEIz0PnnJjnzMIL8wefOei4/CyruB2e8fDuwrXxnsPYOMyKMqc2rdyuxAnoArEKL1ipDiE9n73amNl99aoMhZXk9Di1xgVmkA61BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=xqqMwOWlLAFYGPIeWPfqPUGQy2oPahcVSF2dipWg6BE=;
 b=DabCxbL66ZG0wv7Ym5v1C/MnBnbjvVhpNyYDQhZmsLNT/6ymiHJUa617leJdyMoqRmwDdyImy2kdA39fWv5H4dyZuo+uZCJx2/8OqwRTb/T6H4GErcEihiEoK/t/36a/y4jI9yR7fTBXxePDGMUk0nTShxdzVmmZ2LJ0H2j3GiZtXuOuCNEPEQSCPXpQvKdmQu6v/YxpIZcTGO7aeVV+rcIpK2EaK/Mu0Dt79Jq6Ue/JFLh9i26Do5Tfik/dOpGfC0JdW0I0uybCpVtEsbMUqc6dDqf4hlb5LZwF835Ec7UrJ07XrNLdxNrhT97cdQp/Gd/HwBEBmNcgux3ahgLFQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xqqMwOWlLAFYGPIeWPfqPUGQy2oPahcVSF2dipWg6BE=;
 b=06+jqJBtvnILFIfcn/eidjzJZmUjXaHsPwaVAnL8gtRLsswfDgVQOEzu0gOo3oXA8F+wS6zbCU+EOCWj2pdZxJk+Ri2zKsaxK0vA3gflcwDsw9FDg5hIsvvIvjPWq10O3JJmHvllWQmceKAUPd2eEpfOpQtowff6RY5FFSdHQu8=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2517.namprd12.prod.outlook.com (2603:10b6:4:bb::13) by
 DM6PR12MB4844.namprd12.prod.outlook.com (2603:10b6:5:1d0::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4500.14; Thu, 9 Sep 2021 16:19:51 +0000
Received: from DM5PR12MB2517.namprd12.prod.outlook.com
 ([fe80::e1d2:cc87:74b9:397d]) by DM5PR12MB2517.namprd12.prod.outlook.com
 ([fe80::e1d2:cc87:74b9:397d%7]) with mapi id 15.20.4500.016; Thu, 9 Sep 2021
 16:19:51 +0000
Subject: Re: [PATCH 3/3] drm/amdgpu: move iommu_resume before ip init/resume
To: Felix Kuehling <felix.kuehling@amd.com>, James Zhu <James.Zhu@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: kolAflash@kolahilft.de, me@jeromec.com, alexdeucher@gmail.com,
 ted437@gmail.com, Huang Rui <ray.huang@amd.com>
References: <1631030843-18270-1-git-send-email-James.Zhu@amd.com>
 <1631030843-18270-3-git-send-email-James.Zhu@amd.com>
 <03c5e276-c478-c33c-9f75-e03a56ef16a6@amd.com>
 <adfed1a3-4e1d-8ead-bbf4-4c4448c0f7fe@amd.com>
 <3c196bbc-3799-44ff-d5f8-ade4ada89d93@amd.com>
 <ac2bef7a-d70c-8ede-bcca-d8e27a8fdcb6@amd.com>
 <48cdc3d9-341a-2415-ddfd-fd3b31228000@amd.com>
 <8d26e2ce-5161-60fa-9c0e-3a87431f57e7@amd.com>
From: James Zhu <jamesz@amd.com>
Organization: AMD RTG
Message-ID: <75d218ac-467f-f608-3f60-c05946acb32c@amd.com>
Date: Thu, 9 Sep 2021 12:19:48 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <8d26e2ce-5161-60fa-9c0e-3a87431f57e7@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: YT3PR01CA0112.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:85::30) To DM5PR12MB2517.namprd12.prod.outlook.com
 (2603:10b6:4:bb::13)
MIME-Version: 1.0
Received: from [172.27.230.192] (165.204.55.251) by
 YT3PR01CA0112.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:85::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4500.15 via Frontend Transport; Thu, 9 Sep 2021 16:19:50 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b63a5e48-f2ce-4633-bf25-08d973ada683
X-MS-TrafficTypeDiagnostic: DM6PR12MB4844:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4844A8752761CF8EC052C982E4D59@DM6PR12MB4844.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DgExyQhr7C+hkn0Odvq5O8aAcW28IdPJ49eSY/106iclz718n4HukKlPeVmqo6vtz/cuBWuxBzt29YMMccsk6ih3htiB0/3FOAcbtLltWpNelkUIKco0b7f6ExH4qf7F101Rqox1CAoYdYt5Zq6CyEEtvq1/qRhI1vj7THfieM1iTEV8iLJfxSsoFVpYItZtEvN9w/apU9EeDJFK+vnWtRbHzZRSTURiBXy+RIGudCvYcvk+J1GnSFhqvN6lQE2X51w75re8V/WgilhwFnBY6UEdoeWUyH2x8Py8It/iwVphpPbjEHGcjARcOR/B9v+UaGcux66jG8B03yoo9W1j9u8xwheOismcRNg8DvRVMDSSquq0npTPcyVlp0M9rKA8jn1sKJCtcZF/ce8aRcHQr95dMfjBRmHXnnk6vJ6A2qY4VhWjnxc/L7n+u9rHAo/b2fZJGbet3IDppTtmS0tdw7MNqo1lCDYpNig2G3v6BC3V4S7fkGD3Q2iTu6+DEU2N2H+wqLxRmIGX3OJXHhU0FfvnbIWiI6WwkT0ST1Tak3UKYYlXNTNbkCERbMQqL6zOBC/vqaInWyDfoyQpzULe1F7gic+9ONxYNDTYcPh1oSOUXkmq06wIuq9+UKyE+FSY0Df54cdfDnBNt/pI7zKiq980BzVwylLN7Po/kXQX7v17F1oRkbYuK7WzQ34HDUrt+PuPBuNPhemNJHeQldfhM5cTXyA99va+Iq1TVFQhHUDXfNDKKCU9fbNQcUURIWdg7I3CBI4T+QBmadvEzO8ugcyigxlW1KBRjnsNSPfqlviT32uIPJ5HNfslfIBHz5Go+Q7t6CjG+OkbwXME7S91P5bHgiNZZldc6AUZzIyZvNg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2517.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(346002)(366004)(376002)(39860400002)(136003)(2906002)(66476007)(966005)(30864003)(4326008)(52116002)(36916002)(53546011)(8676002)(26005)(2616005)(5660300002)(83380400001)(6486002)(66556008)(110136005)(31696002)(31686004)(16576012)(478600001)(956004)(66946007)(36756003)(38100700002)(38350700002)(186003)(8936002)(316002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZmkrZGRiZHduVGNraVFtYWNtM2gxblExSUV2SGpZT2RLa1BWZlQxYlZBOWli?=
 =?utf-8?B?OHgxajNsRm8wdS9FSmoxYlF2QUFzV2dBcGdNNFcyODNHN2xmR2xYMDBpdXFJ?=
 =?utf-8?B?UVFBYVBPRjBoZFN0MWtkMm1wK3JhODJNMWw2Y2RjUm1BR3ExV283NmpWaU1s?=
 =?utf-8?B?blA2NmZTaE84azdUNVdCeWcxaFIrTWx2WTFVZitybHkrSDgxNzlGcVh6c1dr?=
 =?utf-8?B?V0g2Z3FyUmFReU1kRGJrR01hSGtUQ09nZ3RPYXlxLytNWDlrdjBNQkxzSjJX?=
 =?utf-8?B?QUhRUy9PYW9pM2JhVHhNNnpXRDgvWDhnZFlRendrRlpwcU9iRGMvYmlFem5r?=
 =?utf-8?B?WEUyZ3NnZllRUGNiVFBTbWRydlUzZVZWUEU0QUp3dWpWWGtsZ3ppZTNvWVEx?=
 =?utf-8?B?dG5Jam9jSkhvNHJ1MEJWV1pNTEdxR2xoZ3JGYU1zK0tBY1RMOXV5bUtWd0M1?=
 =?utf-8?B?TmdCYnJXRUUxKzVVZmlHM3JDM1U4QVp1Y04xN2FOcklhdWljbmlyZmFHYWxG?=
 =?utf-8?B?K2p4aXFOa2F0Wk9IMVBvbWFYUFdTZVFSMmtJcm5RQ3BwcUtFSThmYmw3SGh5?=
 =?utf-8?B?aVViQ056VFR3Zi8vNTUvUzFPRTYwTXRsaDNHRDNiOE9JeWxNam1wOTRsS09Z?=
 =?utf-8?B?SXJicXlZRkd2enlacHRacmhJQ1dZWUE0SFpyNlhoOHlUb2NLTXpwKzVyZ3lT?=
 =?utf-8?B?TnJPajEvL3lIWldtVUtXMW9UZkVDcmswWTJYOVZ3eUhKcGFnWENqcW9tR2F2?=
 =?utf-8?B?TWRCYmpBZWhUYzJLQWExQzdsTTdacUtnS3hJTnBhQm1RRkkvNGRQUmkrWUtm?=
 =?utf-8?B?bUhUY0J4ZlpZSGUraExxaUpxdndPVEtBRXdZbU9sN1RLZm9YbUo4T3lXcTU0?=
 =?utf-8?B?dVpBQjBGdXhrWEYxbFNjeW10NHFXTXpCcUpoNUtRcmRCcEVnKzZhQ2pCOVJR?=
 =?utf-8?B?SUdlajRaWEZNY2YrZjBVdHNZVTFONzZEM2NRYzF3Skt6dnNxbGR1NW0wa3Fu?=
 =?utf-8?B?NjVyTloyays3WGcxaGJjRnB3NUxkaHM1YU8xU0xlVWpvWlpiTWUzRlNLYkx5?=
 =?utf-8?B?VWVrU2ZMeFpVY3ZMcW9waGM0dkt3c1M2NHhFVVg3Z09vc0huOEVaYTFReHZr?=
 =?utf-8?B?eGtHd0dvSnZKaU1IUUUyODgreEhOMzRpYzUyT1VYZGJhR2VvYzFEZzVrKytT?=
 =?utf-8?B?OFJnM3FNdk5CUTJMQWVEWHpZZFN1K09NR3hINWphUGU5Z0NtYlJlNGdIektn?=
 =?utf-8?B?blpKcnJMN3hVM2NlMHhTR3lpNjgycmRLbTdReEwzYm1sc2RLYitkQ0dYbjAw?=
 =?utf-8?B?Nm4xZzVXOXh6angzaVQ3THczY21yMHZwK1ZzVXBwdDUwVjVDbXFqSEgvNkhH?=
 =?utf-8?B?T0Iva0Erc3FKWDIvUFBvaWlIdStOcGtySFovckdIVW92WGw4alR0RmNhUGhl?=
 =?utf-8?B?akIyY2srcTFnTXZtaDE2Tkl2bWVhT24vWThXK1NadXd5NGtCb2hQamVBdFZq?=
 =?utf-8?B?R0ZuV1NhUG02cThrb3hDWkZYWWgvdGROV05sMDBxVS9PYk0ybStZaGU4MEdP?=
 =?utf-8?B?bnVyY1JVYXRYcWdyeDBTOWpjUmZVd0o0K3J6RjM2c0FmSkFiQSsxUkpVVE01?=
 =?utf-8?B?TGRseEVWU0hGN0gvdk5vNlZjZjFBbjdYci9BWGxYanRQTXVONkpPKzcyQkIv?=
 =?utf-8?B?a3drb004MWpiR0RhdGdVSUhualdGNVN1T1pCQ2RadUYzWm4zcGxhYkRCNGpI?=
 =?utf-8?Q?pbTY9b2+EwJu4nH5uS0yRbdBNkn3r+uISgw3X/6?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b63a5e48-f2ce-4633-bf25-08d973ada683
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2517.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2021 16:19:51.1903 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PSHu5KLARfHhTd2UsPsvp+vqzMs8CAldNxz6YqEVj7dokni+YIUFDAjVvVLTiAZa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4844
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


On 2021-09-07 6:20 p.m., Felix Kuehling wrote:
> Am 2021-09-07 um 4:30 p.m. schrieb James Zhu:
>>
>> On 2021-09-07 1:53 p.m., Felix Kuehling wrote:
>>> Am 2021-09-07 um 1:51 p.m. schrieb Felix Kuehling:
>>>> Am 2021-09-07 um 1:22 p.m. schrieb James Zhu:
>>>>> On 2021-09-07 12:48 p.m., Felix Kuehling wrote:
>>>>>> Am 2021-09-07 um 12:07 p.m. schrieb James Zhu:
>>>>>>> Separate iommu_resume from kfd_resume, and move it before
>>>>>>> other amdgpu ip init/resume.
>>>>>>>
>>>>>>> Fixed Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=211277
>>>>>> I think the change is OK. But I don't understand how the IOMMUv2
>>>>>> initialization sequence could affect a crash in DM. The display should
>>>>>> not depend on IOMMUv2 at all. What am I missing?
>>>>> [JZ] It is a weird issue. disable VCN IP block or disable gpu_off
>>>>> feature, or set pci=noats, all
>>>>>
>>>>> can fix DM crash. Also the issue occurred quite random, some time
>>>>> after few suspend/resume cycle,
>>>>>
>>>>> some times after few hundreds S/R cycles. the maximum that I saw is
>>>>> 2422 S/R cycles.
>>>>>
>>>>> But every time DM crash, I can see one or two iommu errors ahead:
>>>>>
>>>>> *AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0000 address=****
>>>>> flags=0x0070]*
>>>> This error is not from IOMMUv2 doing GVA to GPA translations. It's from
>>>> IOMMUv1 doing GPA to SPA translation. This error points to an invalid
>>>> physical (GVA) address being used by the GPU to access random system
>>>>
>>>> Oops: s/GVA/GPA
>>>> memory it shouldn't be accessing (because there is no valid DMA mapping).
>>>>
>>>> On AMD systems, IOMMUv1 tends to be in pass-through mode when IOMMUv2 is
>>>> enabled. It's possible that the earlier initialization of IOMMUv2 hides
>>>> the problem by putting the IOMMU into passthrough mode. I don't think
>>>> this patch series is a valid solution.
>> [JZ] Good to know, thanks! So amd_iommu_init_device is for v2 only.
>>
>> And it is supposed to be safe to do amd_iommu_init_device after amdgpu
>> IP init/resume without any interference.
>>
> Yes, it's supposed to. But with your results below, this is getting very
> confusing. It's as if the IOMMUv2 initialization has some unintended
> side effects if it happens at the wrong moment during resume. If you
> want to debug this further, you'll probably need to work with the server
> team that's working on the IOMMU driver. I'm not sure it's worth the
> trouble.

[JZ] Can you point to me who is the right person from service team? I 
wish they

can give a review on the patches and issues? Thanks!

Also I got advice from Ray, and used ignore_crat=1 during modprobe to 
get iommu v2 fallthrough,

and it  also fixed the issue.

> The series is
>
> Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
>
>
>>>> You can probably fix the problem with this kernel boot parameter: iommu=pt
>> [JZ] Still not working after apply *iommu=pt*
>>
>> BOOT_IMAGE=/boot/vmlinuz-5.8.0-41-generic
>> root=UUID=030a18fe-22f0-49be-818f-192093d543b5 quiet splash
>> modprobe.blacklist=amdgpu *iommu=pt* 3
>> [    0.612117] iommu: Default domain type: *Passthrough* (set via
>> kernel command line)
>> [  354.067871] amdgpu 0000:04:00.0: AMD-Vi: Event logged
>> [*IO_PAGE_FAULT* domain=0x0000 address=0x32de00040 flags=0x0070]
>> [  354.067884] amdgpu 0000:04:00.0: AMD-Vi: Event logged
>> [IO_PAGE_FAULT domain=0x0000 address=0x32de40000 flags=0x0070]
>>
>>>> And you can probably reproduce it even with this patch series if instead
>>>> you add: iommu=nopt amd_iommu=force_isolation
>> [JZ] could not set both *iommu=nopt *and*  amd*_*iommu=force_isolation
>> *together*. *(does it mean something?)*
>> *
>>
>> BOOT_IMAGE=/boot/vmlinuz-5.13.0-custom+
>> root=UUID=030a18fe-22f0-49be-818f-192093d543b5 quiet splash
>> modprobe.blacklist=amdgpu*iommu=nopt amd_iommu=force_isolation* 3
>> [    0.294242] iommu: Default domain type: Translated (set via kernel
>> command line)
>> [    0.350675] perf/amd_iommu: Detected AMD IOMMU #0 (2 banks, 4
>> counters/bank).
>> [  106.403927] amdgpu 0000:04:00.0: amdgpu: amdgpu_device_ip_resume
>> failed (-6).
>> [  106.403931] PM: dpm_run_callback(): pci_pm_resume+0x0/0x90 returns -6
>> [  106.403941] amdgpu 0000:04:00.0: PM: failed to resume async: error -6
>>
> This is weird. Is this happening during resume or driver init?
[JZ] this happened during init, not resume.
>
>
>> *iommu=nopt**: *Passed at least 200 S/R cycles
>>
>> BOOT_IMAGE=/boot/vmlinuz-5.13.0-custom+
>> root=UUID=030a18fe-22f0-49be-818f-192093d543b5 quiet splash
>> modprobe.blacklist=amdgpu   *iommu=nopt* 3
>> [    0.294242] iommu: Default domain type: Translated (set via kernel
>> command line)
>>
> Interesting. That's the opposite of what I would have expected.
>
>
>> *amd_iommu=force_isolation*: failed at 1st resume
>>
>> BOOT_IMAGE=/boot/vmlinuz-5.13.0-custom+
>> root=UUID=030a18fe-22f0-49be-818f-192093d543b5 quiet splash
>> modprobe.blacklist=amdgpu *amd_iommu=force_isolation*   3
>> [    0.294242] iommu: Default domain type: Translated
>>
>> [   49.513262] PM: suspend entry (deep)
>> [   49.514404] Filesystems sync: 0.001 seconds
>> [   49.514668] Freezing user space processes ...
>> [   69.523111] Freezing of tasks failed after 20.008 seconds (2 tasks
>> refusing to freeze, wq_busy=0):
>> [   69.523163] task:gnome-shell     state:D stack:    0 pid: 2196
>> ppid:  2108 flags:0x00000004
>>
> I've never seen this before.
>
> I think if you want to debug this further, you'll need to work with the
> IOMMU driver team.
>
> Regards,
>    Felix
>
>
>> [   69.523172] Call Trace:
>> [   69.523182]  __schedule+0x2ee/0x900
>> [   69.523193]  ? __mod_memcg_lruvec_state+0x22/0xe0
>> [   69.523204]  schedule+0x4f/0xc0
>> [   69.523214]  drm_sched_entity_flush+0x17c/0x230 [gpu_sched]
>> [   69.523225]  ? wait_woken+0x80/0x80
>> [   69.523233]  amdgpu_ctx_mgr_entity_flush+0x97/0xf0 [amdgpu]
>> [   69.523517]  amdgpu_flush+0x2b/0x50 [amdgpu]
>> [   69.523773]  filp_close+0x37/0x70
>> [   69.523780]  do_close_on_exec+0xda/0x110
>> [   69.523787]  begin_new_exec+0x59d/0xa40
>> [   69.523793]  load_elf_binary+0x144/0x1720
>> [   69.523801]  ? __kernel_read+0x1a0/0x2d0
>> [   69.523807]  ? __kernel_read+0x1a0/0x2d0
>> [   69.523812]  ? aa_get_task_label+0x49/0xd0
>> [   69.523820]  bprm_execve+0x288/0x680
>> [   69.523826]  do_execveat_common.isra.0+0x189/0x1c0
>> [   69.523831]  __x64_sys_execve+0x37/0x50
>> [   69.523836]  do_syscall_64+0x40/0xb0
>> [   69.523843]  entry_SYSCALL_64_after_hwframe+0x44/0xae
>> [   69.523851] RIP: 0033:0x7ff1244132fb
>> [   69.523856] RSP: 002b:00007fff91a9f2b8 EFLAGS: 00000206 ORIG_RAX:
>> 000000000000003b
>> [   69.523862] RAX: ffffffffffffffda RBX: 00007ff11ee2e180 RCX:
>> 00007ff1244132fb
>> [   69.523866] RDX: 0000561199f5bc00 RSI: 000056119a1b0890 RDI:
>> 0000561199f2021a
>> [   69.523868] RBP: 000000000000001a R08: 00007fff91aa2a58 R09:
>> 000000179a034e00
>> [   69.523871] R10: 000056119a1b0890 R11: 0000000000000206 R12:
>> 00007fff91aa2a60
>> [   69.523874] R13: 000056119a1b0890 R14: 0000561199f2021a R15:
>> 0000000000000001
>> [   69.523882] task:gst-plugin-scan state:D stack:    0 pid: 2213
>> ppid:  2199 flags:0x00004004
>> [   69.523888] Call Trace:
>> [   69.523891]  __schedule+0x2ee/0x900
>> [   69.523897]  schedule+0x4f/0xc0
>> [   69.523902]  drm_sched_entity_flush+0x17c/0x230 [gpu_sched]
>> [   69.523912]  ? wait_woken+0x80/0x80
>> [   69.523918]  drm_sched_entity_destroy+0x18/0x30 [gpu_sched]
>> [   69.523928]  amdgpu_vm_fini+0x256/0x3d0 [amdgpu]
>> [   69.524210]  amdgpu_driver_postclose_kms+0x179/0x240 [amdgpu]
>> [   69.524444]  drm_file_free.part.0+0x1e5/0x250 [drm]
>> [   69.524481]  ? dma_fence_release+0x140/0x140
>> [   69.524489]  drm_close_helper.isra.0+0x65/0x70 [drm]
>> [   69.524524]  drm_release+0x6e/0xf0 [drm]
>> [   69.524559]  __fput+0x9f/0x250
>> [   69.524564]  ____fput+0xe/0x10
>> [   69.524569]  task_work_run+0x70/0xb0
>> [   69.524575]  exit_to_user_mode_prepare+0x1c8/0x1d0
>> [   69.524581]  syscall_exit_to_user_mode+0x27/0x50
>> [   69.524586]  ? __x64_sys_close+0x12/0x40
>> [   69.524589]  do_syscall_64+0x4d/0xb0
>> [   69.524594]  entry_SYSCALL_64_after_hwframe+0x44/0xae
>> [   69.524599] RIP: 0033:0x7f2c12adb9ab
>> [   69.524602] RSP: 002b:00007fff981aaaa0 EFLAGS: 00000293 ORIG_RAX:
>> 0000000000000003
>> [   69.524606] RAX: 0000000000000000 RBX: 0000556b6f83f060 RCX:
>> 00007f2c12adb9ab
>> [   69.524608] RDX: 0000000000000014 RSI: 0000556b6f841400 RDI:
>> 0000000000000006
>> [   69.524611] RBP: 0000556b6f83f100 R08: 0000000000000000 R09:
>> 000000000000000e
>> [   69.524613] R10: 00007fff981db090 R11: 0000000000000293 R12:
>> 0000556b6f841400
>> [   69.524616] R13: 00007f2c12763e30 R14: 0000556b6f817330 R15:
>> 00007f2c127420b4
>>
>>>> Regards,
>>>>    Felix
>>>>
>>>>
>>>>> Since we can't stop HW/FW/SW right the way after IO page fault
>>>>> detected, so I can't tell which part try to access
>>>>> system memory through IOMMU.
>>>>>
>>>>> But after moving IOMMU device init before other amdgpu IP init/resume,
>>>>> the DM crash /IOMMU page fault issues are gone.
>>>>>
>>>>> Those patches can't directly explain why the issue fixed, but this new
>>>>> sequence makes more sense to me.
>>>>>
>>>>> Can I have you RB on those patches?
>>>>>
>>>>> Thanks!
>>>>> James
>>>>>
>>>>>> Regards,
>>>>>>    Felix
>>>>>>
>>>>>>
>>>>>>> Signed-off-by: James Zhu <James.Zhu@amd.com>
>>>>>>> ---
>>>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 12 ++++++++++++
>>>>>>>   1 file changed, 12 insertions(+)
>>>>>>>
>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>>>> index 653bd8f..e3f0308 100644
>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>>>> @@ -2393,6 +2393,10 @@ static int amdgpu_device_ip_init(struct amdgpu_device *adev)
>>>>>>>   	if (r)
>>>>>>>   		goto init_failed;
>>>>>>>   
>>>>>>> +	r = amdgpu_amdkfd_resume_iommu(adev);
>>>>>>> +	if (r)
>>>>>>> +		goto init_failed;
>>>>>>> +
>>>>>>>   	r = amdgpu_device_ip_hw_init_phase1(adev);
>>>>>>>   	if (r)
>>>>>>>   		goto init_failed;
>>>>>>> @@ -3147,6 +3151,10 @@ static int amdgpu_device_ip_resume(struct amdgpu_device *adev)
>>>>>>>   {
>>>>>>>   	int r;
>>>>>>>   
>>>>>>> +	r = amdgpu_amdkfd_resume_iommu(adev);
>>>>>>> +	if (r)
>>>>>>> +		return r;
>>>>>>> +
>>>>>>>   	r = amdgpu_device_ip_resume_phase1(adev);
>>>>>>>   	if (r)
>>>>>>>   		return r;
>>>>>>> @@ -4602,6 +4610,10 @@ int amdgpu_do_asic_reset(struct list_head *device_list_handle,
>>>>>>>   				dev_warn(tmp_adev->dev, "asic atom init failed!");
>>>>>>>   			} else {
>>>>>>>   				dev_info(tmp_adev->dev, "GPU reset succeeded, trying to resume\n");
>>>>>>> +				r = amdgpu_amdkfd_resume_iommu(tmp_adev);
>>>>>>> +				if (r)
>>>>>>> +					goto out;
>>>>>>> +
>>>>>>>   				r = amdgpu_device_ip_resume_phase1(tmp_adev);
>>>>>>>   				if (r)
>>>>>>>   					goto out;
