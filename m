Return-Path: <SRS0=wMah=N5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB4FAC433EF
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Sep 2021 20:30:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 750686115C
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Sep 2021 20:30:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 750686115C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CEE9F6E0D7;
	Tue,  7 Sep 2021 20:30:10 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2076.outbound.protection.outlook.com [40.107.223.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 878786E0CB
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Sep 2021 20:30:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fPRswtxUwIWuny6oYOUJ/3A+mEyWOKONOoVnq9YOsvT4aqU9QutiYD9S+MKpeEhJjtiaQoHCllMBdljjggcV45ShoE/XEbzyBjJMy8XVtXq9/YM5pMbFXkspK3SXB7vzfPqKmDGzm3Om95HmKlee6pCeZ1/qQBIBCGAFmraRA1sRT+MJF6/Uf8sVRoKnZFTUEjgPI6R277oGdHLIw4mKT8XtCt61mfasGM+SsUU6sDcpdauthSVd5UbAnUZf5PoiCQ8GTXiWHMSmh0DETaPRAlCi0XdtyNkmNYWkYADY0SK+IRVlhbLthftG5U20HDqllzdAo2AXPdrgrw1BGmrkDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=wbypjue9XuXQPuqWACKbmceRbi/a9EybwzK2sASJ9ww=;
 b=iylI66BGuSi8J3wetVZiAJAySH7GZwLm++dLLaXxeevLpnozhsuxDG8jcY/fZb6nQArFzLVVaVNM/YjJ7tYEvdTa6vwZnvGZcm8Ys8wkPn4C1paXWq7mLV+YFXMRWIOxoAjxhfEyP0xA4IgCREvj+HKzxyAcVA9V0AOUYwGxDUlcPpGKbgZYgtUI35voPWRdZUYFLBv3IrRclK+qUvUxjEzdHzjMT1CilNCv85pHujk/yRn3i6yWWrBH3tzX1gj76iISu80EsdE9gLbAE7zyt9vQKuPu/6bYvP+UnX0vKZ5s5xKditb0c9t2aiVXjGVD+Z7lvKRODKSBkLD+w016Eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wbypjue9XuXQPuqWACKbmceRbi/a9EybwzK2sASJ9ww=;
 b=oWzmONtA8IiF3ZFGD4kci2Z5iqRemeMiZYd+gMDYIGU7sxHUnV7GwtvCO7ZvaUvxKcNd+0Y/S4eB0pY6s55T4rMm6G3NcrjMzQkLAd6MdzyfTCX9YhIgN6+WnLl2b9lWsVh72AZHCenzVkO6zBblWu5YhWaX2rkOBxMEm3KL07k=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2517.namprd12.prod.outlook.com (2603:10b6:4:bb::13) by
 DM5PR12MB1721.namprd12.prod.outlook.com (2603:10b6:3:10d::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4478.22; Tue, 7 Sep 2021 20:30:07 +0000
Received: from DM5PR12MB2517.namprd12.prod.outlook.com
 ([fe80::e1d2:cc87:74b9:397d]) by DM5PR12MB2517.namprd12.prod.outlook.com
 ([fe80::e1d2:cc87:74b9:397d%7]) with mapi id 15.20.4478.025; Tue, 7 Sep 2021
 20:30:06 +0000
Subject: Re: [PATCH 3/3] drm/amdgpu: move iommu_resume before ip init/resume
To: Felix Kuehling <felix.kuehling@amd.com>, James Zhu <James.Zhu@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: kolAflash@kolahilft.de, me@jeromec.com, alexdeucher@gmail.com,
 ted437@gmail.com
References: <1631030843-18270-1-git-send-email-James.Zhu@amd.com>
 <1631030843-18270-3-git-send-email-James.Zhu@amd.com>
 <03c5e276-c478-c33c-9f75-e03a56ef16a6@amd.com>
 <adfed1a3-4e1d-8ead-bbf4-4c4448c0f7fe@amd.com>
 <3c196bbc-3799-44ff-d5f8-ade4ada89d93@amd.com>
 <ac2bef7a-d70c-8ede-bcca-d8e27a8fdcb6@amd.com>
From: James Zhu <jamesz@amd.com>
Organization: AMD RTG
Message-ID: <48cdc3d9-341a-2415-ddfd-fd3b31228000@amd.com>
Date: Tue, 7 Sep 2021 16:30:04 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <ac2bef7a-d70c-8ede-bcca-d8e27a8fdcb6@amd.com>
Content-Type: multipart/alternative;
 boundary="------------4E2F62A978F6369DCE3277C1"
Content-Language: en-US
X-ClientProxiedBy: YT2PR01CA0020.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:38::25) To DM5PR12MB2517.namprd12.prod.outlook.com
 (2603:10b6:4:bb::13)
MIME-Version: 1.0
Received: from [172.27.230.192] (165.204.55.251) by
 YT2PR01CA0020.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:38::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4478.21 via Frontend Transport; Tue, 7 Sep 2021 20:30:06 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d45f8245-ffcf-4c45-99ee-08d9723e47ba
X-MS-TrafficTypeDiagnostic: DM5PR12MB1721:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1721E6B675CDA6535D7725F5E4D39@DM5PR12MB1721.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4nVfJ+ZrICqU/4ZJwpUTQxZjFjnWsMQ+xL2phh9Ul9p/cllG8VlVoE74RvhYfSBQ3UmIj/yM7YY2Ht8KBn0BS/1TyxeZ9hP3sVCbAOPWTaFKfxZmAuMRfwQCnrlizse2aT/5yG6Out/+zpSuiyPtu4s6AheL+JUynfPznLbg+Rcw/3XjXOJqRJgHeto5tu0X/KDMOt5jIzYZD8MtWvWtshBdyTOWTNeKPh5IDjDbtUkJAVjdVO7yed49m1k8LM9MO87cpAmp5j8MwPi3gAIw3l7fjidWdCT35yEG/Zhh3dvlI7dz9BLb1FitsJ6VosG1zIRpkGyPltahVLjBIH8iYJqhbdKlcdGKVwApSIyXMdVEp6wC6ZSKaF52ORaJpSxakCv7nonmqgHdzhlJD/FZB604hZ2xx/o0rJFwpSln12QyBze3ziY6AUpvRn7Ec16CQNoJJYoKRZgwzCdnSL/g5b6ge9ec2DHm+OadmiU8aXmdOVBulvWe7UhtltUnrF/7VUUaZ2sEPKGBG4rKko0R35IKZeukQeqiDEbl3G9wIYOF7u55yOHbJ2B91sApS0wKqaunqZ2YGGJPvOFD4zQfSEQYS0xHZySEZIAdlMfWDuHv9TTuvjR7q3EoC9J22bl4RnSDpwbrSvTgyxLVdOQ2jkbtvPB0j0cNZgLH/vmP+P4YBJcbueQ5nxcmo7Z8I0KKzZ3XUXlWuLDEGUuFS/pANAm9g+2fE7QxqoabTgDUxW6WfUTvO3N47fLP+EziyTyVrQ4FIjNu5mFewsbYknsrT4E5lymBE38ztKqOFyd/ZMpGlaByzgq/6Ou4as7EV3Hr+uS5DLjaiyyd5MVfLJ8i6ynCMb0Yxl5qaNwQ3S8+6Zc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2517.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(376002)(39860400002)(396003)(366004)(346002)(66946007)(38350700002)(26005)(2616005)(956004)(38100700002)(36756003)(4326008)(478600001)(66556008)(166002)(8676002)(53546011)(6486002)(2906002)(83380400001)(66476007)(52116002)(316002)(31696002)(31686004)(33964004)(966005)(16576012)(110136005)(5660300002)(30864003)(8936002)(36916002)(186003)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NzRwdzFhWVJBaTEzQVY0MEhIa1dlRjJHMENDa3BOTDBBQnhNOFlIamh5dlkz?=
 =?utf-8?B?b08vMXlwaGRRSVlGc3RNNWYvWHhGVVc1OGlZeElmVWg3Y0REbTdUdnZjTlQ5?=
 =?utf-8?B?VFhTRys5Y2xRb2gxeTgrZENkQTJsclZwVlVSbXlDVFNFb0o4bUJpeEFVZE91?=
 =?utf-8?B?UmIxL1hMWC9CdkJ2OW42V1hScm80V0hQaUFtcFdlRlVNV0FJR3dCZDBFVmVk?=
 =?utf-8?B?cTJ2dStuNzdkOHJ0VHgwY0lGOHNQUFdjaVg4QWZ3ZkMrbWZTaHNQejNxbHFJ?=
 =?utf-8?B?T3VBSlI1UHhXODNVQTJ1Z0NMVWZOUWRZNWZCSGtRQ3hYcVo3TFJiT0trUElB?=
 =?utf-8?B?amhkTndVd2hyU3lOOVB3d3F4L0dOc216QWUwcUxaUTg2bHhtSE9iNno4TnY3?=
 =?utf-8?B?R2N3aEw1Qi9RVzR4YVlUZThnNGtrRXU4b1o0SGZkYm8xNmhNSDQ5QU81SUd5?=
 =?utf-8?B?aDdTV2Q4U3Mxb0lDR3NYcS9VMlhXODMwZi8vcG0vQXhDeFZWZVNxQkFrSGQz?=
 =?utf-8?B?cjBrdXcvZmErdkpTRFQycHNnelAzOHJGQVV1ZmZIaytVZGlaTVFiaU9VSFhW?=
 =?utf-8?B?bklSQ0Y4QzlkOHZNcTFBNGRpa2lBVktEQWQ3Y3piZFVobjltZFM4MGttb3NX?=
 =?utf-8?B?QUZiYTd1RlppN3ZobDNTMGJ4NnVXTjIybkZFTkRWTkpWNS9aaTQvVDhzOW5k?=
 =?utf-8?B?WWNNNnpUeklsRVU5cDIvdzJJbkRGK2RDWURhSHZUK05JUE41d295Nm9IQlVv?=
 =?utf-8?B?Q1hxSmZjb0RhNS8weVNxZzVCeGFsaExXYVFSa0ZWbzRLeXB4aXRtVkMyTXFo?=
 =?utf-8?B?L1VFZWpDVXJNa2d2WXNHdWticmFZK2tRZkpoRU9IVnBiaE4yYm1ST3NYa2Fl?=
 =?utf-8?B?SWgybmVieGw2aERBTlNwUEdTd1hKcDBPc2dpQ3FkOGRnS0FlU3g3Z1BLcHVZ?=
 =?utf-8?B?KzVsSCtlOS9WV3NIV2NRUUxpZVFmTFQvdjNhMkRQcGNBenpFcW8rS25SZVVH?=
 =?utf-8?B?b1BJQzI3a2tLakYxdjRNMTZiTWRVZXdpcDBJV2I2SG1IcThyVmZRVGJyQzBF?=
 =?utf-8?B?KytxbUZ5cGI2VTZzajYxa1ZaVlNoZ3U3QWxUbzIzRmNUNUxuZjl3YUZZN1Ny?=
 =?utf-8?B?RXdLbndnV2dGamtteTdiakhQT0ZXeTFVKzZyK3NoZWx4eVViTU5jRktvdSsw?=
 =?utf-8?B?WE1KUVRBcEMxUWEyWVd5MUlNVlA1VnoxOURZN2R6bEJKUmF5czNFREFlVFNC?=
 =?utf-8?B?K3U4bXFCb1pQZWNmbVJlTmVHTkJtTEZlWFl6NHVJVzdvUlE0NUd2SFVZNW9h?=
 =?utf-8?B?ZmhVWDFIcVBWQmxMYkF2NWdOUWl2bkNtanlkMTk0NFZvVk1Jbjd0NEs5ZEJy?=
 =?utf-8?B?RjhweW5rSEsxaHEvclpQSk1ZdjVzYXdLNnlrbHFnYVB3MU1LZkJaZmdLZW43?=
 =?utf-8?B?OCt0ZDdWSFRKUUdhYkNRaGFkSitBbThBMHRKa0JBT2J5UURBcVZTempRYlk0?=
 =?utf-8?B?ZDVrS2kyTjZMdGc4Y0EyRVR3eEVLR20vZ2VHbE96NUpSUDhCMmYyeVBuY1pP?=
 =?utf-8?B?dk0yQVZXcll6YzdtOUNjMEZ2RkFvQ1FyOVl4VXpIMWhDaWI3QVk2bW9hRmln?=
 =?utf-8?B?dDJDNUd1dVBiaGlqeFA1YS96a25pK0R1bXM0Vi9QTHprMmhYb1FocURSSG1a?=
 =?utf-8?B?RnptZXdZeVVXTk1SRkNpL0FoVHdVS0Y1K1BVRm9oVVdWM0R0T3B6RDc0dEY3?=
 =?utf-8?Q?KEnxgBZAOKjXPfieSwU3hDv/33w9scmiKBYVTJs?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d45f8245-ffcf-4c45-99ee-08d9723e47ba
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2517.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2021 20:30:06.8674 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: de5A05CQFlVrVgz2SP1YVoeN0/I2e6TccUxYDJJFh+OB1pBjFui8mElZ/wXlWj+P
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1721
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

--------------4E2F62A978F6369DCE3277C1
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit


On 2021-09-07 1:53 p.m., Felix Kuehling wrote:
> Am 2021-09-07 um 1:51 p.m. schrieb Felix Kuehling:
>> Am 2021-09-07 um 1:22 p.m. schrieb James Zhu:
>>> On 2021-09-07 12:48 p.m., Felix Kuehling wrote:
>>>> Am 2021-09-07 um 12:07 p.m. schrieb James Zhu:
>>>>> Separate iommu_resume from kfd_resume, and move it before
>>>>> other amdgpu ip init/resume.
>>>>>
>>>>> Fixed Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=211277
>>>> I think the change is OK. But I don't understand how the IOMMUv2
>>>> initialization sequence could affect a crash in DM. The display should
>>>> not depend on IOMMUv2 at all. What am I missing?
>>> [JZ] It is a weird issue. disable VCN IP block or disable gpu_off
>>> feature, or set pci=noats, all
>>>
>>> can fix DM crash. Also the issue occurred quite random, some time
>>> after few suspend/resume cycle,
>>>
>>> some times after few hundreds S/R cycles. the maximum that I saw is
>>> 2422 S/R cycles.
>>>
>>> But every time DM crash, I can see one or two iommu errors ahead:
>>>
>>> *AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0000 address=****
>>> flags=0x0070]*
>> This error is not from IOMMUv2 doing GVA to GPA translations. It's from
>> IOMMUv1 doing GPA to SPA translation. This error points to an invalid
>> physical (GVA) address being used by the GPU to access random system
>>
>> Oops: s/GVA/GPA
>> memory it shouldn't be accessing (because there is no valid DMA mapping).
>>
>> On AMD systems, IOMMUv1 tends to be in pass-through mode when IOMMUv2 is
>> enabled. It's possible that the earlier initialization of IOMMUv2 hides
>> the problem by putting the IOMMU into passthrough mode. I don't think
>> this patch series is a valid solution.

[JZ] Good to know, thanks! So amd_iommu_init_device is for v2 only.

And it is supposed to be safe to do amd_iommu_init_device after amdgpu 
IP init/resume without any interference.

>> You can probably fix the problem with this kernel boot parameter: iommu=pt

[JZ] Still not working after apply *iommu=pt*

BOOT_IMAGE=/boot/vmlinuz-5.8.0-41-generic 
root=UUID=030a18fe-22f0-49be-818f-192093d543b5 quiet splash 
modprobe.blacklist=amdgpu *iommu=pt* 3
[    0.612117] iommu: Default domain type: *Passthrough* (set via kernel 
command line)
[  354.067871] amdgpu 0000:04:00.0: AMD-Vi: Event logged 
[*IO_PAGE_FAULT* domain=0x0000 address=0x32de00040 flags=0x0070]
[  354.067884] amdgpu 0000:04:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT 
domain=0x0000 address=0x32de40000 flags=0x0070]

>> And you can probably reproduce it even with this patch series if instead
>> you add: iommu=nopt amd_iommu=force_isolation

[JZ] could not set both *iommu=nopt *and*  amd*_*iommu=force_isolation 
*together*. *(does it mean something?)*
*

BOOT_IMAGE=/boot/vmlinuz-5.13.0-custom+ 
root=UUID=030a18fe-22f0-49be-818f-192093d543b5 quiet splash 
modprobe.blacklist=amdgpu*iommu=nopt amd_iommu=force_isolation* 3
[    0.294242] iommu: Default domain type: Translated (set via kernel 
command line)
[    0.350675] perf/amd_iommu: Detected AMD IOMMU #0 (2 banks, 4 
counters/bank).
[  106.403927] amdgpu 0000:04:00.0: amdgpu: amdgpu_device_ip_resume 
failed (-6).
[  106.403931] PM: dpm_run_callback(): pci_pm_resume+0x0/0x90 returns -6
[  106.403941] amdgpu 0000:04:00.0: PM: failed to resume async: error -6

*iommu=nopt**: *Passed at least 200 S/R cycles

BOOT_IMAGE=/boot/vmlinuz-5.13.0-custom+ 
root=UUID=030a18fe-22f0-49be-818f-192093d543b5 quiet splash 
modprobe.blacklist=amdgpu *iommu=nopt* 3
[    0.294242] iommu: Default domain type: Translated (set via kernel 
command line)

*amd_iommu=force_isolation*: failed at 1st resume

BOOT_IMAGE=/boot/vmlinuz-5.13.0-custom+ 
root=UUID=030a18fe-22f0-49be-818f-192093d543b5 quiet splash 
modprobe.blacklist=amdgpu *amd_iommu=force_isolation*   3
[    0.294242] iommu: Default domain type: Translated

[   49.513262] PM: suspend entry (deep)
[   49.514404] Filesystems sync: 0.001 seconds
[   49.514668] Freezing user space processes ...
[   69.523111] Freezing of tasks failed after 20.008 seconds (2 tasks 
refusing to freeze, wq_busy=0):
[   69.523163] task:gnome-shell     state:D stack:    0 pid: 2196 ppid:  
2108 flags:0x00000004
[   69.523172] Call Trace:
[   69.523182]  __schedule+0x2ee/0x900
[   69.523193]  ? __mod_memcg_lruvec_state+0x22/0xe0
[   69.523204]  schedule+0x4f/0xc0
[   69.523214]  drm_sched_entity_flush+0x17c/0x230 [gpu_sched]
[   69.523225]  ? wait_woken+0x80/0x80
[   69.523233]  amdgpu_ctx_mgr_entity_flush+0x97/0xf0 [amdgpu]
[   69.523517]  amdgpu_flush+0x2b/0x50 [amdgpu]
[   69.523773]  filp_close+0x37/0x70
[   69.523780]  do_close_on_exec+0xda/0x110
[   69.523787]  begin_new_exec+0x59d/0xa40
[   69.523793]  load_elf_binary+0x144/0x1720
[   69.523801]  ? __kernel_read+0x1a0/0x2d0
[   69.523807]  ? __kernel_read+0x1a0/0x2d0
[   69.523812]  ? aa_get_task_label+0x49/0xd0
[   69.523820]  bprm_execve+0x288/0x680
[   69.523826]  do_execveat_common.isra.0+0x189/0x1c0
[   69.523831]  __x64_sys_execve+0x37/0x50
[   69.523836]  do_syscall_64+0x40/0xb0
[   69.523843]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[   69.523851] RIP: 0033:0x7ff1244132fb
[   69.523856] RSP: 002b:00007fff91a9f2b8 EFLAGS: 00000206 ORIG_RAX: 
000000000000003b
[   69.523862] RAX: ffffffffffffffda RBX: 00007ff11ee2e180 RCX: 
00007ff1244132fb
[   69.523866] RDX: 0000561199f5bc00 RSI: 000056119a1b0890 RDI: 
0000561199f2021a
[   69.523868] RBP: 000000000000001a R08: 00007fff91aa2a58 R09: 
000000179a034e00
[   69.523871] R10: 000056119a1b0890 R11: 0000000000000206 R12: 
00007fff91aa2a60
[   69.523874] R13: 000056119a1b0890 R14: 0000561199f2021a R15: 
0000000000000001
[   69.523882] task:gst-plugin-scan state:D stack:    0 pid: 2213 ppid:  
2199 flags:0x00004004
[   69.523888] Call Trace:
[   69.523891]  __schedule+0x2ee/0x900
[   69.523897]  schedule+0x4f/0xc0
[   69.523902]  drm_sched_entity_flush+0x17c/0x230 [gpu_sched]
[   69.523912]  ? wait_woken+0x80/0x80
[   69.523918]  drm_sched_entity_destroy+0x18/0x30 [gpu_sched]
[   69.523928]  amdgpu_vm_fini+0x256/0x3d0 [amdgpu]
[   69.524210]  amdgpu_driver_postclose_kms+0x179/0x240 [amdgpu]
[   69.524444]  drm_file_free.part.0+0x1e5/0x250 [drm]
[   69.524481]  ? dma_fence_release+0x140/0x140
[   69.524489]  drm_close_helper.isra.0+0x65/0x70 [drm]
[   69.524524]  drm_release+0x6e/0xf0 [drm]
[   69.524559]  __fput+0x9f/0x250
[   69.524564]  ____fput+0xe/0x10
[   69.524569]  task_work_run+0x70/0xb0
[   69.524575]  exit_to_user_mode_prepare+0x1c8/0x1d0
[   69.524581]  syscall_exit_to_user_mode+0x27/0x50
[   69.524586]  ? __x64_sys_close+0x12/0x40
[   69.524589]  do_syscall_64+0x4d/0xb0
[   69.524594]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[   69.524599] RIP: 0033:0x7f2c12adb9ab
[   69.524602] RSP: 002b:00007fff981aaaa0 EFLAGS: 00000293 ORIG_RAX: 
0000000000000003
[   69.524606] RAX: 0000000000000000 RBX: 0000556b6f83f060 RCX: 
00007f2c12adb9ab
[   69.524608] RDX: 0000000000000014 RSI: 0000556b6f841400 RDI: 
0000000000000006
[   69.524611] RBP: 0000556b6f83f100 R08: 0000000000000000 R09: 
000000000000000e
[   69.524613] R10: 00007fff981db090 R11: 0000000000000293 R12: 
0000556b6f841400
[   69.524616] R13: 00007f2c12763e30 R14: 0000556b6f817330 R15: 
00007f2c127420b4

>> Regards,
>>    Felix
>>
>>
>>> Since we can't stop HW/FW/SW right the way after IO page fault
>>> detected, so I can't tell which part try to access
>>> system memory through IOMMU.
>>>
>>> But after moving IOMMU device init before other amdgpu IP init/resume,
>>> the DM crash /IOMMU page fault issues are gone.
>>>
>>> Those patches can't directly explain why the issue fixed, but this new
>>> sequence makes more sense to me.
>>>
>>> Can I have you RB on those patches?
>>>
>>> Thanks!
>>> James
>>>
>>>> Regards,
>>>>    Felix
>>>>
>>>>
>>>>> Signed-off-by: James Zhu <James.Zhu@amd.com>
>>>>> ---
>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 12 ++++++++++++
>>>>>   1 file changed, 12 insertions(+)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>> index 653bd8f..e3f0308 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>> @@ -2393,6 +2393,10 @@ static int amdgpu_device_ip_init(struct amdgpu_device *adev)
>>>>>   	if (r)
>>>>>   		goto init_failed;
>>>>>   
>>>>> +	r = amdgpu_amdkfd_resume_iommu(adev);
>>>>> +	if (r)
>>>>> +		goto init_failed;
>>>>> +
>>>>>   	r = amdgpu_device_ip_hw_init_phase1(adev);
>>>>>   	if (r)
>>>>>   		goto init_failed;
>>>>> @@ -3147,6 +3151,10 @@ static int amdgpu_device_ip_resume(struct amdgpu_device *adev)
>>>>>   {
>>>>>   	int r;
>>>>>   
>>>>> +	r = amdgpu_amdkfd_resume_iommu(adev);
>>>>> +	if (r)
>>>>> +		return r;
>>>>> +
>>>>>   	r = amdgpu_device_ip_resume_phase1(adev);
>>>>>   	if (r)
>>>>>   		return r;
>>>>> @@ -4602,6 +4610,10 @@ int amdgpu_do_asic_reset(struct list_head *device_list_handle,
>>>>>   				dev_warn(tmp_adev->dev, "asic atom init failed!");
>>>>>   			} else {
>>>>>   				dev_info(tmp_adev->dev, "GPU reset succeeded, trying to resume\n");
>>>>> +				r = amdgpu_amdkfd_resume_iommu(tmp_adev);
>>>>> +				if (r)
>>>>> +					goto out;
>>>>> +
>>>>>   				r = amdgpu_device_ip_resume_phase1(tmp_adev);
>>>>>   				if (r)
>>>>>   					goto out;

--------------4E2F62A978F6369DCE3277C1
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2021-09-07 1:53 p.m., Felix Kuehling
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:ac2bef7a-d70c-8ede-bcca-d8e27a8fdcb6@amd.com">
      <pre class="moz-quote-pre" wrap="">Am 2021-09-07 um 1:51 p.m. schrieb Felix Kuehling:
</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">Am 2021-09-07 um 1:22 p.m. schrieb James Zhu:
</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">On 2021-09-07 12:48 p.m., Felix Kuehling wrote:
</pre>
          <blockquote type="cite">
            <pre class="moz-quote-pre" wrap="">Am 2021-09-07 um 12:07 p.m. schrieb James Zhu:
</pre>
            <blockquote type="cite">
              <pre class="moz-quote-pre" wrap="">Separate iommu_resume from kfd_resume, and move it before
other amdgpu ip init/resume.

Fixed Bugzilla: <a class="moz-txt-link-freetext" href="https://bugzilla.kernel.org/show_bug.cgi?id=211277">https://bugzilla.kernel.org/show_bug.cgi?id=211277</a>
</pre>
            </blockquote>
            <pre class="moz-quote-pre" wrap="">I think the change is OK. But I don't understand how the IOMMUv2
initialization sequence could affect a crash in DM. The display should
not depend on IOMMUv2 at all. What am I missing?
</pre>
          </blockquote>
          <pre class="moz-quote-pre" wrap="">[JZ] It is a weird issue. disable VCN IP block or disable gpu_off
feature, or set pci=noats, all

can fix DM crash. Also the issue occurred quite random, some time
after few suspend/resume cycle,

some times after few hundreds S/R cycles. the maximum that I saw is
2422 S/R cycles.

But every time DM crash, I can see one or two iommu errors ahead:

*AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0000 address=****
flags=0x0070]*
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">This error is not from IOMMUv2 doing GVA to GPA translations. It's from
IOMMUv1 doing GPA to SPA translation. This error points to an invalid
physical (GVA) address being used by the GPU to access random system

Oops: s/GVA/GPA
memory it shouldn't be accessing (because there is no valid DMA mapping).

On AMD systems, IOMMUv1 tends to be in pass-through mode when IOMMUv2 is
enabled. It's possible that the earlier initialization of IOMMUv2 hides
the problem by putting the IOMMU into passthrough mode. I don't think
this patch series is a valid solution.</pre>
      </blockquote>
    </blockquote>
    <p>[JZ] Good to know, thanks! So amd_iommu_init_device is for v2
      only.</p>
    <p>And it is supposed to be safe to do amd_iommu_init_device after
      amdgpu IP init/resume without any interference.<br>
    </p>
    <blockquote type="cite" cite="mid:ac2bef7a-d70c-8ede-bcca-d8e27a8fdcb6@amd.com">
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">You can probably fix the problem with this kernel boot parameter: iommu=pt</pre>
      </blockquote>
    </blockquote>
    <p>[JZ] Still not working after apply <b>iommu=pt</b></p>
    <p>BOOT_IMAGE=/boot/vmlinuz-5.8.0-41-generic
      root=UUID=030a18fe-22f0-49be-818f-192093d543b5 quiet splash
      modprobe.blacklist=amdgpu <b>iommu=pt</b> 3
<br>
      [&nbsp;&nbsp;&nbsp; 0.612117] iommu: Default domain type: <b>Passthrough</b>
      (set via kernel command line)
<br>
      [&nbsp; 354.067871] amdgpu 0000:04:00.0: AMD-Vi: Event logged [<b>IO_PAGE_FAULT</b>
      domain=0x0000 address=0x32de00040 flags=0x0070]
<br>
      [&nbsp; 354.067884] amdgpu 0000:04:00.0: AMD-Vi: Event logged
      [IO_PAGE_FAULT domain=0x0000 address=0x32de40000 flags=0x0070]</p>
    <blockquote type="cite" cite="mid:ac2bef7a-d70c-8ede-bcca-d8e27a8fdcb6@amd.com">
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">
And you can probably reproduce it even with this patch series if instead
you add: iommu=nopt amd_iommu=force_isolation</pre>
      </blockquote>
    </blockquote>
    <p>[JZ] could not set both <b>iommu=nopt </b>and<b>&nbsp; amd</b>_<b>iommu=force_isolation
      </b>together<b>. </b>(does it mean something?)<b><br>
      </b></p>
    <p>BOOT_IMAGE=/boot/vmlinuz-5.13.0-custom+
      root=UUID=030a18fe-22f0-49be-818f-192093d543b5 quiet splash
      modprobe.blacklist=amdgpu<b> iommu=nopt amd_iommu=force_isolation</b>
      3
<br>
      [&nbsp;&nbsp;&nbsp; 0.294242] iommu: Default domain type: Translated (set via
      kernel command line)
<br>
      [&nbsp;&nbsp;&nbsp; 0.350675] perf/amd_iommu: Detected AMD IOMMU #0 (2 banks, 4
      counters/bank).
<br>
      [&nbsp; 106.403927] amdgpu 0000:04:00.0: amdgpu:
      amdgpu_device_ip_resume failed (-6).
<br>
      [&nbsp; 106.403931] PM: dpm_run_callback(): pci_pm_resume+0x0/0x90
      returns -6
<br>
      [&nbsp; 106.403941] amdgpu 0000:04:00.0: PM: failed to resume async:
      error -6</p>
    <p> <b>iommu=nopt</b><b>: </b>Passed at least 200 S/R cycles<br>
    </p>
    <p>BOOT_IMAGE=/boot/vmlinuz-5.13.0-custom+
      root=UUID=030a18fe-22f0-49be-818f-192093d543b5 quiet splash
      modprobe.blacklist=amdgpu&nbsp;&nbsp; <b>iommu=nopt</b> 3
<br>
      [&nbsp;&nbsp;&nbsp; 0.294242] iommu: Default domain type: Translated (set via
      kernel command line)
<br>
    </p>
    <p><b>amd_iommu=force_isolation</b>: failed at 1st resume<br>
    </p>
    <p>BOOT_IMAGE=/boot/vmlinuz-5.13.0-custom+
      root=UUID=030a18fe-22f0-49be-818f-192093d543b5 quiet splash
      modprobe.blacklist=amdgpu <b>amd_iommu=force_isolation</b> &nbsp; 3
<br>
      [&nbsp;&nbsp;&nbsp; 0.294242] iommu: Default domain type: Translated <br>
    </p>
    <p>[&nbsp;&nbsp; 49.513262] PM: suspend entry (deep)<br>
      [&nbsp;&nbsp; 49.514404] Filesystems sync: 0.001 seconds<br>
      [&nbsp;&nbsp; 49.514668] Freezing user space processes ... <br>
      [&nbsp;&nbsp; 69.523111] Freezing of tasks failed after 20.008 seconds (2
      tasks refusing to freeze, wq_busy=0):<br>
      [&nbsp;&nbsp; 69.523163] task:gnome-shell&nbsp;&nbsp;&nbsp;&nbsp; state:D stack:&nbsp;&nbsp;&nbsp; 0 pid: 2196
      ppid:&nbsp; 2108 flags:0x00000004<br>
      [&nbsp;&nbsp; 69.523172] Call Trace:<br>
      [&nbsp;&nbsp; 69.523182]&nbsp; __schedule+0x2ee/0x900<br>
      [&nbsp;&nbsp; 69.523193]&nbsp; ? __mod_memcg_lruvec_state+0x22/0xe0<br>
      [&nbsp;&nbsp; 69.523204]&nbsp; schedule+0x4f/0xc0<br>
      [&nbsp;&nbsp; 69.523214]&nbsp; drm_sched_entity_flush+0x17c/0x230 [gpu_sched]<br>
      [&nbsp;&nbsp; 69.523225]&nbsp; ? wait_woken+0x80/0x80<br>
      [&nbsp;&nbsp; 69.523233]&nbsp; amdgpu_ctx_mgr_entity_flush+0x97/0xf0 [amdgpu]<br>
      [&nbsp;&nbsp; 69.523517]&nbsp; amdgpu_flush+0x2b/0x50 [amdgpu]<br>
      [&nbsp;&nbsp; 69.523773]&nbsp; filp_close+0x37/0x70<br>
      [&nbsp;&nbsp; 69.523780]&nbsp; do_close_on_exec+0xda/0x110<br>
      [&nbsp;&nbsp; 69.523787]&nbsp; begin_new_exec+0x59d/0xa40<br>
      [&nbsp;&nbsp; 69.523793]&nbsp; load_elf_binary+0x144/0x1720<br>
      [&nbsp;&nbsp; 69.523801]&nbsp; ? __kernel_read+0x1a0/0x2d0<br>
      [&nbsp;&nbsp; 69.523807]&nbsp; ? __kernel_read+0x1a0/0x2d0<br>
      [&nbsp;&nbsp; 69.523812]&nbsp; ? aa_get_task_label+0x49/0xd0<br>
      [&nbsp;&nbsp; 69.523820]&nbsp; bprm_execve+0x288/0x680<br>
      [&nbsp;&nbsp; 69.523826]&nbsp; do_execveat_common.isra.0+0x189/0x1c0<br>
      [&nbsp;&nbsp; 69.523831]&nbsp; __x64_sys_execve+0x37/0x50<br>
      [&nbsp;&nbsp; 69.523836]&nbsp; do_syscall_64+0x40/0xb0<br>
      [&nbsp;&nbsp; 69.523843]&nbsp; entry_SYSCALL_64_after_hwframe+0x44/0xae<br>
      [&nbsp;&nbsp; 69.523851] RIP: 0033:0x7ff1244132fb<br>
      [&nbsp;&nbsp; 69.523856] RSP: 002b:00007fff91a9f2b8 EFLAGS: 00000206
      ORIG_RAX: 000000000000003b<br>
      [&nbsp;&nbsp; 69.523862] RAX: ffffffffffffffda RBX: 00007ff11ee2e180 RCX:
      00007ff1244132fb<br>
      [&nbsp;&nbsp; 69.523866] RDX: 0000561199f5bc00 RSI: 000056119a1b0890 RDI:
      0000561199f2021a<br>
      [&nbsp;&nbsp; 69.523868] RBP: 000000000000001a R08: 00007fff91aa2a58 R09:
      000000179a034e00<br>
      [&nbsp;&nbsp; 69.523871] R10: 000056119a1b0890 R11: 0000000000000206 R12:
      00007fff91aa2a60<br>
      [&nbsp;&nbsp; 69.523874] R13: 000056119a1b0890 R14: 0000561199f2021a R15:
      0000000000000001<br>
      [&nbsp;&nbsp; 69.523882] task:gst-plugin-scan state:D stack:&nbsp;&nbsp;&nbsp; 0 pid: 2213
      ppid:&nbsp; 2199 flags:0x00004004<br>
      [&nbsp;&nbsp; 69.523888] Call Trace:<br>
      [&nbsp;&nbsp; 69.523891]&nbsp; __schedule+0x2ee/0x900<br>
      [&nbsp;&nbsp; 69.523897]&nbsp; schedule+0x4f/0xc0<br>
      [&nbsp;&nbsp; 69.523902]&nbsp; drm_sched_entity_flush+0x17c/0x230 [gpu_sched]<br>
      [&nbsp;&nbsp; 69.523912]&nbsp; ? wait_woken+0x80/0x80<br>
      [&nbsp;&nbsp; 69.523918]&nbsp; drm_sched_entity_destroy+0x18/0x30 [gpu_sched]<br>
      [&nbsp;&nbsp; 69.523928]&nbsp; amdgpu_vm_fini+0x256/0x3d0 [amdgpu]<br>
      [&nbsp;&nbsp; 69.524210]&nbsp; amdgpu_driver_postclose_kms+0x179/0x240 [amdgpu]<br>
      [&nbsp;&nbsp; 69.524444]&nbsp; drm_file_free.part.0+0x1e5/0x250 [drm]<br>
      [&nbsp;&nbsp; 69.524481]&nbsp; ? dma_fence_release+0x140/0x140<br>
      [&nbsp;&nbsp; 69.524489]&nbsp; drm_close_helper.isra.0+0x65/0x70 [drm]<br>
      [&nbsp;&nbsp; 69.524524]&nbsp; drm_release+0x6e/0xf0 [drm]<br>
      [&nbsp;&nbsp; 69.524559]&nbsp; __fput+0x9f/0x250<br>
      [&nbsp;&nbsp; 69.524564]&nbsp; ____fput+0xe/0x10<br>
      [&nbsp;&nbsp; 69.524569]&nbsp; task_work_run+0x70/0xb0<br>
      [&nbsp;&nbsp; 69.524575]&nbsp; exit_to_user_mode_prepare+0x1c8/0x1d0<br>
      [&nbsp;&nbsp; 69.524581]&nbsp; syscall_exit_to_user_mode+0x27/0x50<br>
      [&nbsp;&nbsp; 69.524586]&nbsp; ? __x64_sys_close+0x12/0x40<br>
      [&nbsp;&nbsp; 69.524589]&nbsp; do_syscall_64+0x4d/0xb0<br>
      [&nbsp;&nbsp; 69.524594]&nbsp; entry_SYSCALL_64_after_hwframe+0x44/0xae<br>
      [&nbsp;&nbsp; 69.524599] RIP: 0033:0x7f2c12adb9ab<br>
      [&nbsp;&nbsp; 69.524602] RSP: 002b:00007fff981aaaa0 EFLAGS: 00000293
      ORIG_RAX: 0000000000000003<br>
      [&nbsp;&nbsp; 69.524606] RAX: 0000000000000000 RBX: 0000556b6f83f060 RCX:
      00007f2c12adb9ab<br>
      [&nbsp;&nbsp; 69.524608] RDX: 0000000000000014 RSI: 0000556b6f841400 RDI:
      0000000000000006<br>
      [&nbsp;&nbsp; 69.524611] RBP: 0000556b6f83f100 R08: 0000000000000000 R09:
      000000000000000e<br>
      [&nbsp;&nbsp; 69.524613] R10: 00007fff981db090 R11: 0000000000000293 R12:
      0000556b6f841400<br>
      [&nbsp;&nbsp; 69.524616] R13: 00007f2c12763e30 R14: 0000556b6f817330 R15:
      00007f2c127420b4<br>
    </p>
    <blockquote type="cite" cite="mid:ac2bef7a-d70c-8ede-bcca-d8e27a8fdcb6@amd.com">
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">
Regards,
&nbsp; Felix


</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">Since we can't stop HW/FW/SW right the way after IO page fault
detected, so I can't tell which part try to access
system memory through IOMMU.

But after moving IOMMU device init before other amdgpu IP init/resume,
the DM crash /IOMMU page fault issues are gone.

Those patches can't directly explain why the issue fixed, but this new
sequence makes more sense to me.

Can I have you RB on those patches?

Thanks!
James

</pre>
          <blockquote type="cite">
            <pre class="moz-quote-pre" wrap="">Regards,
&nbsp; Felix


</pre>
            <blockquote type="cite">
              <pre class="moz-quote-pre" wrap="">Signed-off-by: James Zhu <a class="moz-txt-link-rfc2396E" href="mailto:James.Zhu@amd.com">&lt;James.Zhu@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 653bd8f..e3f0308 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2393,6 +2393,10 @@ static int amdgpu_device_ip_init(struct amdgpu_device *adev)
 	if (r)
 		goto init_failed;
 
+	r = amdgpu_amdkfd_resume_iommu(adev);
+	if (r)
+		goto init_failed;
+
 	r = amdgpu_device_ip_hw_init_phase1(adev);
 	if (r)
 		goto init_failed;
@@ -3147,6 +3151,10 @@ static int amdgpu_device_ip_resume(struct amdgpu_device *adev)
 {
 	int r;
 
+	r = amdgpu_amdkfd_resume_iommu(adev);
+	if (r)
+		return r;
+
 	r = amdgpu_device_ip_resume_phase1(adev);
 	if (r)
 		return r;
@@ -4602,6 +4610,10 @@ int amdgpu_do_asic_reset(struct list_head *device_list_handle,
 				dev_warn(tmp_adev-&gt;dev, &quot;asic atom init failed!&quot;);
 			} else {
 				dev_info(tmp_adev-&gt;dev, &quot;GPU reset succeeded, trying to resume\n&quot;);
+				r = amdgpu_amdkfd_resume_iommu(tmp_adev);
+				if (r)
+					goto out;
+
 				r = amdgpu_device_ip_resume_phase1(tmp_adev);
 				if (r)
 					goto out;
</pre>
            </blockquote>
          </blockquote>
        </blockquote>
      </blockquote>
    </blockquote>
  </body>
</html>

--------------4E2F62A978F6369DCE3277C1--
