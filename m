Return-Path: <SRS0=hzS6=OF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFB76C433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Sep 2021 14:04:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7DF2B61164
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Sep 2021 14:04:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7DF2B61164
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EDC486E93B;
	Wed, 15 Sep 2021 14:04:22 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2049.outbound.protection.outlook.com [40.107.93.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D7836E93B
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Sep 2021 14:04:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PGc9if2laTXDjn8zx4Jz1Y7V/yfcoxNqlvWWQKsaMrNuJELEnv1HCI7O+IS0PQYKVi0rT6frgc3z36AwDCeyM5y3tmS85vmoBALrRXvTfe57VtPVEkhPBFnRJ3hSwsEH1F7+dJgNPZ8SJOByYg9NWS7E3jSJGTdO8MR2K/vAYE9bekDwOerD0Fdtm7IgGarPyr8gFQEXt4Ui7tdhemjs1+Fypuh5UtisJ0I2/YjHOK27klH/9qccl9F3qhZgfGv6md8p3dvk/36FVUFQE3WxGRaZ8wOQmc1OE0N7ph70cbOGbnP/kj0gh54Qujm74sqD3mUbVtFmk33MY0xiCLma1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=fuRFpyS4RlkU1OVAAYApHnhjnxUABILrrVKYWaWTV/o=;
 b=NB4XBPKF4eThbT+4P2FhMI2UQjn2DYzF57w1GYwbZxey3eBrynd7nsj5RHwB2+Ar4hDemy5c/os/tRAYPLz2AkI0XO2LabO1j4uyHKqD2ufI+5wFGgagKOgvuWUEIejlZnT+EUUHxTMG0jGl3F0HJORDdqALM6xWr/KSay6yVZx2RuqjXNgwu1IGlbonYcDboE81pBo+24uscDWDaJ94RwyQIWyiPqi30cYM/XlCsLyCrxqfktX/E5JxgZR1AMMkJ+b7Ix306z293D8ofO0ZxPPjrlFc6B0PDJtK1jjmgk/BMPFM0xaPf6HiDnu5gq+1lWpdssqVneTZAqh4wJHljg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fuRFpyS4RlkU1OVAAYApHnhjnxUABILrrVKYWaWTV/o=;
 b=0/kBaWaEMOxyESXcR5gyNKbSOQpZ7SQU6hbzIs2uWKPBICjm8w8w0PpnO+p10oqqF97wb60CrkUgs5stTYdQiBedWS3GRUpAiBStkPWenmnO2WjZWgRg6YZ0NhOSZf6EDFI+8Qctk7ZvyHK8tOIkUPIvUqocsnv6lMqrWkRZBfQ=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB4623.namprd12.prod.outlook.com (2603:10b6:805:e9::17)
 by SN6PR12MB2847.namprd12.prod.outlook.com (2603:10b6:805:76::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Wed, 15 Sep
 2021 14:04:12 +0000
Received: from SN6PR12MB4623.namprd12.prod.outlook.com
 ([fe80::c4ac:2505:5bd8:295d]) by SN6PR12MB4623.namprd12.prod.outlook.com
 ([fe80::c4ac:2505:5bd8:295d%6]) with mapi id 15.20.4500.019; Wed, 15 Sep 2021
 14:04:12 +0000
Subject: =?UTF-8?B?UmU6IOWbnuWkjTogW1BBVENIIHYyXSBkcm0vYW1kZ3B1OiBQdXQgZHJt?=
 =?UTF-8?Q?=5fdev=5fenter/exit_outside_hot_codepath?=
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>
References: <20210915063739.31244-1-xinhui.pan@amd.com>
 <DM4PR12MB51651F702F35D31B4B76F90287DB9@DM4PR12MB5165.namprd12.prod.outlook.com>
 <5a18c2bb-c919-817f-2dc1-a6bb0bfd9701@amd.com>
 <db1dd9bb-9879-216c-47c1-f21c7d2d9434@gmail.com>
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Message-ID: <0be26097-837c-4c7e-b32c-af705413c465@amd.com>
Date: Wed, 15 Sep 2021 10:04:09 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <db1dd9bb-9879-216c-47c1-f21c7d2d9434@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: YTXPR0101CA0029.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::42) To SN6PR12MB4623.namprd12.prod.outlook.com
 (2603:10b6:805:e9::17)
MIME-Version: 1.0
Received: from [IPv6:2607:fea8:3edf:49b0:b7f3:c5bf:cc7e:9d39]
 (2607:fea8:3edf:49b0:b7f3:c5bf:cc7e:9d39) by
 YTXPR0101CA0029.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4523.14 via Frontend Transport; Wed, 15 Sep 2021 14:04:11 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b8c6d897-e47f-49bd-cebb-08d97851b1ab
X-MS-TrafficTypeDiagnostic: SN6PR12MB2847:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB28479A8F40BCE2CCFC3F0B56EADB9@SN6PR12MB2847.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JARKZHPpNatI+LRQsZ7RmA9j/SeXO6DeCODrvM8NPRDiVojYoTpkJWmtAPIxtUt+wnYDqMC/L6yh8SD6Q1UFYlvoGRAXRouTtKJR5pHL27NvUSlCcVggajNscSQYwgQ3lkxyNdl+KXzhVrD3HVRy9FBjIwABMdFdx0QrksuzUituCGKjK2jOQRiSLuzGXJHCe9KUqeLhOcU4GQ2cAep8nmZYKxUVbaMYkfwHJhi6iUOOxrHT2TufNd3ahNGrXMyBTBBykNCgrV4HZJOsB5EcI69lTCssJo4+6bVIu9O79g9FglwIFwnQGTJEutB4F76tgwINjQ375e5E2CJfOqNl5d1lS0NDqi1lUJZ5fO+MumUO9sEiQAFPlADVt2eqcsL9e/FUk6y6yrEbYmvJV84H+ZdSHP4DfKEm/T7oVW03S0w6Che0JnzR7AYdZGu5XbMJmrxfpblqpUkv/41zM1DLkeEJ+Esm6LrYxc038sWo+C2YqA+MTY/F+Ws9vUMEf42o27BchrqArkmw2Mn9MKtQklyrhLQeAr3wUIAeB7xa/T+NoOpgsj7Bjc2EE457tagUhEGkv67/2UNKFwzDnDZJYC8t3faLQ+mj7qobY8C9C1xSoUnjh3A2qC9ngkEm0eHpZ9Bnf6O5ZefcOp+gk+Uv6RQaD5A0dTkihPdWLpoyWXlfoQakgfrGZuLNfe2vM4AEB4hDWPUC6MKj7AvdrOy5p/JRi0VAp2SAacx+D7jfoaY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR12MB4623.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(396003)(136003)(346002)(366004)(39860400002)(66476007)(66556008)(2616005)(66946007)(31696002)(224303003)(86362001)(83380400001)(66574015)(36756003)(44832011)(8936002)(38100700002)(30864003)(53546011)(2906002)(4326008)(54906003)(5660300002)(186003)(110136005)(316002)(31686004)(6486002)(478600001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q202a3A1OHFJTWVkWDJXSWdoekpmZG80ZVo3SkZTZGRRU1dZdUdzL3R6NHVx?=
 =?utf-8?B?ZDZMNkVVendTSmdEc294NUtjUGhJdHJ5UXpMQ1M1S0Rxck4vOVZOOWE2Tk9r?=
 =?utf-8?B?WXVQOGVoUUZZME5GUitPQmhEODdqMHFKK1pCTTVBU0Y1NFFtY2R3OEVaSlRL?=
 =?utf-8?B?aEcyWWFwekFLcHB4NGMzY3B2R051TU85SzVyUmVacVRZRVB5N05KR2toMk9y?=
 =?utf-8?B?ZGVFMU5wUkNjaTVzRmVQWThZd0lLMmJ2M2RpdllvY3puRXFJZUhoeDlJcVRH?=
 =?utf-8?B?MHdXYWhzTVNsMTJJZXhQOXZZeUpsQ2N4Yi9ZcUVJMGk2akRWS29pRDh3cnRh?=
 =?utf-8?B?U1BqT1k5WGZIdEtYNk1qTWN1a3hualRRUXJRczJpcEhseTViTjRSV3pSMDVl?=
 =?utf-8?B?bFRZRTJJNlNFMDNJUUliVXFRekZlM0VZNm1nWEEwYnJKd0pWRWZncnl2aXp6?=
 =?utf-8?B?VytWNW1BSTREcHVBSzlOekp2a0tDelJndDEybDBjQlpHMi95a3pVQWhOQmdX?=
 =?utf-8?B?NU0xK3c1RWMxL1p0cXVqV3BoUWZsODJQemVXb0dzcmRTNG55NmVGNElBYlJy?=
 =?utf-8?B?WXllTEJyK2JpZWt1T2lNM01TQU5uMGdoZ0dkaUFTdXBoay9oYW1uZExOcG5z?=
 =?utf-8?B?bVB3WTJnZkpzU3JHclhuU1VtZlNnV2pmZEVvcnpTK0svUHdVblE4R291NGVC?=
 =?utf-8?B?N1h4c2VMdDZyamtENWM1anBTN1h5cFZiRW9rTHZJczNGQXp3UU5pNU5ML2Yy?=
 =?utf-8?B?Ry8xci9SRjVOb0dZMVlxNTBkR0EwOWtDdGdkOTZza0hWajgxeGdCYW11cy8x?=
 =?utf-8?B?Z2EvV1l6UVMwMHJBQUZycElvaVZzc3owUlp0enJyWWF1UTV6Y3R0Tmw3b21k?=
 =?utf-8?B?aWdsSFYrQXVRenhWVUlQRFhmdDRwNEFpWUxoWml2Tjd6MmRiLzF0bWNnOW9z?=
 =?utf-8?B?QVF4S2hTTCsxejhGbDJRTHY0MzZNa1draU9xbU83WmtUNDZxYm9NSjdNOWRz?=
 =?utf-8?B?NnpJY0VHd1ZMdzNTVzhKZmJXMXkvYWFYVXdyQ3NMa0ZZWmlHckJ4eFdnQVho?=
 =?utf-8?B?U3cxdTdaYmZ1dktxVi9qY0pSL29vRWcvV2J3bjBUQW1PMjdwc2JSSmVFdGQr?=
 =?utf-8?B?d1VIVWF5TmJ3dmcrZXJPMWx3ZHJiY3dXT1hjdUEvQytFQWpVN1ZvUG9TdWpi?=
 =?utf-8?B?b2NxazdWZ2FaSmgxM3N1N1RPQzRnUWE3bUFTWGdRLytFUnM3b205S01uVUdG?=
 =?utf-8?B?OVJUQW13STlSeGw5TlRFc1NTRE1mN2tCRVpyS2J3UXQ3SDhrRldvZ2hOUDcr?=
 =?utf-8?B?RlBCZ3o3eEd2cUZCVkd2QkxSVit2aE5LSFZVVDQrSTRQN1J3Y052dGxVWXNm?=
 =?utf-8?B?RVpWZndieC9QRnVJWWNGU2Y4cGRwajIyOE1jd3hQV3J4OTdzU3A4VkFMejlx?=
 =?utf-8?B?bVpaYldxdmxmeTd0M2xSRGRTaGVzaWY4bDRFdmJPcGNZTzZiaERoa3JlbEgy?=
 =?utf-8?B?U0FPa1ZET0R6ajhteVlnN3NmTmx3T3pVaVExdXdiOVRMMjdqYVllVFVWSlI2?=
 =?utf-8?B?dk9nTXcvYXUyS2wwbUlZUldIbUVJMGNZRVZ1djNXR3AyWmRZUG9QN3BOa1FT?=
 =?utf-8?B?QklQNFRya1ZORlY5cnRZMElycmZBVlJ3K01QR0VyUENYM1k1c0xJRFVrejVm?=
 =?utf-8?B?aFhqUDJZSXdTRWM0ZG5kSHVQeFRTWFMraS9EVzhNYkd3Z09JcjM2ZXNvTVln?=
 =?utf-8?B?bFlITUxLZVNmazYwcy9lN0ZIUEtsNlA2MWpuQWJBOEJtWSthNkVnWS9RcEtk?=
 =?utf-8?B?TWFGOWVNc25HRHl2NFNsZFBERTI0elVaamtPa2plQ3NQbzVVZzFJcndWb21k?=
 =?utf-8?Q?SykEJ4u5wypaG?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8c6d897-e47f-49bd-cebb-08d97851b1ab
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB4623.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2021 14:04:11.9795 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 70LEcsFYHcdFovJmmIDoYIQ+F/7eTfagEsiAd45+IVN+7hNweTMUD+oQgzgBEKiOv+Svp9lv1HSq22XO9FWYLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2847
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


On 2021-09-15 9:57 a.m., Christian König wrote:
> Am 15.09.21 um 15:52 schrieb Andrey Grodzovsky:
>> On 2021-09-15 2:42 a.m., Pan, Xinhui wrote:
>>> [AMD Official Use Only]
>>>
>>> Andrey
>>> I hit panic with this plug/unplug test without this patch.
>>
>>
>> Can you please tell which ASIC you are using and which kernel branch 
>> and what is the tip commit ?
>>
>>
>>> But as we add enter/exit in all its callers. maybe it would not 
>>> impact plug/unplug.
>>
>>
>> If you add enter/exit in all callers then why this solves the problem 
>> ? Is it because in one or more callers
>> amdgpu_gmc_set_pte_pde is called many times and so calling enter/exit 
>> many times creates the problematic
>> contention from multiple threads ?
>
> The most likely cause of this is cache line bouncing I think and yes 
> moving the enter/exit a level up should fix this.
>
> But I strongly suggest to test this with lockdep enabled and 
> hotplug/GPU reset a couple of times.


Xinhui already tried testing with Hotplug and there is a regression 
crash as you can see bellow. That
why I wanted to know which kernel and which ASIC to see if I can 
reproduce and fix the regression quickly.

I will try on my side with latest kernel and vega 10 anyway since i see 
vega 10 functions from the trace.

Andrey


>
> Christian.
>
>>
>> Andrey
>>
>>>
>>> [ 1109.041095] BUG: unable to handle page fault for address: 
>>> 00000000000010e1
>>> [ 1109.086353] RIP: 0010:vega10_power_gate_vce+0x15/0x40 [amdgpu]
>>> [ 1109.196706] Call Trace:
>>> [ 1109.199374]  ? pp_set_powergating_by_smu+0x1f9/0x4a0 [amdgpu]
>>> [ 1109.205843]  amdgpu_dpm_set_powergating_by_smu+0xa6/0x150 [amdgpu]
>>> [ 1109.212776]  amdgpu_dpm_enable_vce+0x36/0x100 [amdgpu]
>>> [ 1109.218563]  vce_v4_0_hw_fini+0xe1/0xf0 [amdgpu]
>>> [ 1109.223747]  amdgpu_device_fini_hw+0x333/0x483 [amdgpu]
>>> [ 1109.229650]  amdgpu_driver_unload_kms+0x80/0xe0 [amdgpu]
>>> [ 1109.235577]  amdgpu_pci_remove+0x37/0x70 [amdgpu]
>>> [ 1109.240853]  pci_device_remove+0x3b/0xb0
>>> [ 1109.245127]  device_release_driver_internal+0x100/0x1d0
>>> [ 1109.250857]  device_release_driver+0x12/0x20
>>> [ 1109.255535]  pci_stop_bus_device+0x79/0xa0
>>> [ 1109.260016] pci_stop_and_remove_bus_device_locked+0x1b/0x30
>>> [ 1109.266197]  remove_store+0x7b/0x90
>>> [ 1109.269990]  dev_attr_store+0x14/0x30
>>> [ 1109.274002]  sysfs_kf_write+0x48/0x60
>>> [ 1109.277998]  kernfs_fop_write_iter+0x14e/0x1e0
>>>
>>> ________________________________________
>>> 发件人: Pan, Xinhui <Xinhui.Pan@amd.com>
>>> 发送时间: 2021年9月15日 14:37
>>> 收件人: amd-gfx@lists.freedesktop.org
>>> 抄送: Deucher, Alexander; Koenig, Christian; Grodzovsky, Andrey; Pan, 
>>> Xinhui
>>> 主题: [PATCH v2] drm/amdgpu: Put drm_dev_enter/exit outside hot 
>>> codepath
>>>
>>> We hit soft hang while doing memory pressure test on one numa system.
>>> After a qucik look, this is because kfd invalid/valid userptr memory
>>> frequently with process_info lock hold.
>>> Looks like update page table mapping use too much cpu time.
>>>
>>> perf top says below,
>>> 75.81%  [kernel]       [k] __srcu_read_unlock
>>>   6.19%  [amdgpu]       [k] amdgpu_gmc_set_pte_pde
>>>   3.56%  [kernel]       [k] __srcu_read_lock
>>>   2.20%  [amdgpu]       [k] amdgpu_vm_cpu_update
>>>   2.20%  [kernel]       [k] __sg_page_iter_dma_next
>>>   2.15%  [drm]          [k] drm_dev_enter
>>>   1.70%  [drm]          [k] drm_prime_sg_to_dma_addr_array
>>>   1.18%  [kernel]       [k] __sg_alloc_table_from_pages
>>>   1.09%  [drm]          [k] drm_dev_exit
>>>
>>> So move drm_dev_enter/exit outside gmc code, instead let caller do it.
>>> They are gart_unbind, gart_map, vm_clear_bo, vm_update_pdes and
>>> gmc_init_pdb0. vm_bo_update_mapping already calls it.
>>>
>>> Signed-off-by: xinhui pan <xinhui.pan@amd.com>
>>> ---
>>> change from v1:
>>> add enter/exit in more gmc_set_pte_pde callers
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c | 11 ++++++++++
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c  | 11 +++++-----
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c   | 28 
>>> +++++++++++++++++-------
>>>   3 files changed, 36 insertions(+), 14 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
>>> index 76efd5f8950f..d7e4f4660acf 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
>>> @@ -34,6 +34,7 @@
>>>   #include <asm/set_memory.h>
>>>   #endif
>>>   #include "amdgpu.h"
>>> +#include <drm/drm_drv.h>
>>>
>>>   /*
>>>    * GART
>>> @@ -230,12 +231,16 @@ int amdgpu_gart_unbind(struct amdgpu_device 
>>> *adev, uint64_t offset,
>>>          u64 page_base;
>>>          /* Starting from VEGA10, system bit must be 0 to mean 
>>> invalid. */
>>>          uint64_t flags = 0;
>>> +       int idx;
>>>
>>>          if (!adev->gart.ready) {
>>>                  WARN(1, "trying to unbind memory from uninitialized 
>>> GART !\n");
>>>                  return -EINVAL;
>>>          }
>>>
>>> +       if (!drm_dev_enter(&adev->ddev, &idx))
>>> +               return 0;
>>> +
>>>          t = offset / AMDGPU_GPU_PAGE_SIZE;
>>>          p = t / AMDGPU_GPU_PAGES_IN_CPU_PAGE;
>>>          for (i = 0; i < pages; i++, p++) {
>>> @@ -254,6 +259,7 @@ int amdgpu_gart_unbind(struct amdgpu_device 
>>> *adev, uint64_t offset,
>>>          for (i = 0; i < adev->num_vmhubs; i++)
>>>                  amdgpu_gmc_flush_gpu_tlb(adev, 0, i, 0);
>>>
>>> +       drm_dev_exit(idx);
>>>          return 0;
>>>   }
>>>
>>> @@ -276,12 +282,16 @@ int amdgpu_gart_map(struct amdgpu_device 
>>> *adev, uint64_t offset,
>>>   {
>>>          uint64_t page_base;
>>>          unsigned i, j, t;
>>> +       int idx;
>>>
>>>          if (!adev->gart.ready) {
>>>                  WARN(1, "trying to bind memory to uninitialized 
>>> GART !\n");
>>>                  return -EINVAL;
>>>          }
>>>
>>> +       if (!drm_dev_enter(&adev->ddev, &idx))
>>> +               return 0;
>>> +
>>>          t = offset / AMDGPU_GPU_PAGE_SIZE;
>>>
>>>          for (i = 0; i < pages; i++) {
>>> @@ -291,6 +301,7 @@ int amdgpu_gart_map(struct amdgpu_device *adev, 
>>> uint64_t offset,
>>>                          page_base += AMDGPU_GPU_PAGE_SIZE;
>>>                  }
>>>          }
>>> +       drm_dev_exit(idx);
>>>          return 0;
>>>   }
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
>>> index 54f059501a33..1427fd70310c 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
>>> @@ -153,10 +153,6 @@ int amdgpu_gmc_set_pte_pde(struct amdgpu_device 
>>> *adev, void *cpu_pt_addr,
>>>   {
>>>          void __iomem *ptr = (void *)cpu_pt_addr;
>>>          uint64_t value;
>>> -       int idx;
>>> -
>>> -       if (!drm_dev_enter(&adev->ddev, &idx))
>>> -               return 0;
>>>
>>>          /*
>>>           * The following is for PTE only. GART does not have PDEs.
>>> @@ -165,8 +161,6 @@ int amdgpu_gmc_set_pte_pde(struct amdgpu_device 
>>> *adev, void *cpu_pt_addr,
>>>          value |= flags;
>>>          writeq(value, ptr + (gpu_page_idx * 8));
>>>
>>> -       drm_dev_exit(idx);
>>> -
>>>          return 0;
>>>   }
>>>
>>> @@ -752,6 +746,10 @@ void amdgpu_gmc_init_pdb0(struct amdgpu_device 
>>> *adev)
>>>                  adev->gmc.xgmi.physical_node_id * 
>>> adev->gmc.xgmi.node_segment_size;
>>>          u64 vram_end = vram_addr + vram_size;
>>>          u64 gart_ptb_gpu_pa = amdgpu_gmc_vram_pa(adev, adev->gart.bo);
>>> +       int idx;
>>> +
>>> +       if (!drm_dev_enter(&adev->ddev, &idx))
>>> +               return;
>>>
>>>          flags |= AMDGPU_PTE_VALID | AMDGPU_PTE_READABLE;
>>>          flags |= AMDGPU_PTE_WRITEABLE;
>>> @@ -773,6 +771,7 @@ void amdgpu_gmc_init_pdb0(struct amdgpu_device 
>>> *adev)
>>>          flags |= AMDGPU_PDE_BFS(0) | AMDGPU_PTE_SNOOPED;
>>>          /* Requires gart_ptb_gpu_pa to be 4K aligned */
>>>          amdgpu_gmc_set_pte_pde(adev, adev->gmc.ptr_pdb0, i, 
>>> gart_ptb_gpu_pa, flags);
>>> +       drm_dev_exit(idx);
>>>   }
>>>
>>>   /**
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>> index 0126ece898da..daa16d2f89da 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>> @@ -800,7 +800,7 @@ static int amdgpu_vm_clear_bo(struct 
>>> amdgpu_device *adev,
>>>          struct amdgpu_bo *bo = &vmbo->bo;
>>>          unsigned entries, ats_entries;
>>>          uint64_t addr;
>>> -       int r;
>>> +       int r, idx;
>>>
>>>          /* Figure out our place in the hierarchy */
>>>          if (ancestor->parent) {
>>> @@ -845,9 +845,12 @@ static int amdgpu_vm_clear_bo(struct 
>>> amdgpu_device *adev,
>>>                          return r;
>>>          }
>>>
>>> +       if (!drm_dev_enter(&adev->ddev, &idx))
>>> +               return -ENODEV;
>>> +
>>>          r = vm->update_funcs->map_table(vmbo);
>>>          if (r)
>>> -               return r;
>>> +               goto exit;
>>>
>>>          memset(&params, 0, sizeof(params));
>>>          params.adev = adev;
>>> @@ -856,7 +859,7 @@ static int amdgpu_vm_clear_bo(struct 
>>> amdgpu_device *adev,
>>>
>>>          r = vm->update_funcs->prepare(&params, NULL, 
>>> AMDGPU_SYNC_EXPLICIT);
>>>          if (r)
>>> -               return r;
>>> +               goto exit;
>>>
>>>          addr = 0;
>>>          if (ats_entries) {
>>> @@ -872,7 +875,7 @@ static int amdgpu_vm_clear_bo(struct 
>>> amdgpu_device *adev,
>>>                  r = vm->update_funcs->update(&params, vmbo, addr, 
>>> 0, ats_entries,
>>>                                               value, flags);
>>>                  if (r)
>>> -                       return r;
>>> +                       goto exit;
>>>
>>>                  addr += ats_entries * 8;
>>>          }
>>> @@ -895,10 +898,13 @@ static int amdgpu_vm_clear_bo(struct 
>>> amdgpu_device *adev,
>>>                  r = vm->update_funcs->update(&params, vmbo, addr, 
>>> 0, entries,
>>>                                               value, flags);
>>>                  if (r)
>>> -                       return r;
>>> +                       goto exit;
>>>          }
>>>
>>> -       return vm->update_funcs->commit(&params, NULL);
>>> +       r = vm->update_funcs->commit(&params, NULL);
>>> +exit:
>>> +       drm_dev_exit(idx);
>>> +       return r;
>>>   }
>>>
>>>   /**
>>> @@ -1384,11 +1390,14 @@ int amdgpu_vm_update_pdes(struct 
>>> amdgpu_device *adev,
>>>                            struct amdgpu_vm *vm, bool immediate)
>>>   {
>>>          struct amdgpu_vm_update_params params;
>>> -       int r;
>>> +       int r, idx;
>>>
>>>          if (list_empty(&vm->relocated))
>>>                  return 0;
>>>
>>> +       if (!drm_dev_enter(&adev->ddev, &idx))
>>> +               return -ENODEV;
>>> +
>>>          memset(&params, 0, sizeof(params));
>>>          params.adev = adev;
>>>          params.vm = vm;
>>> @@ -1396,7 +1405,7 @@ int amdgpu_vm_update_pdes(struct amdgpu_device 
>>> *adev,
>>>
>>>          r = vm->update_funcs->prepare(&params, NULL, 
>>> AMDGPU_SYNC_EXPLICIT);
>>>          if (r)
>>> -               return r;
>>> +               goto exit;
>>>
>>>          while (!list_empty(&vm->relocated)) {
>>>                  struct amdgpu_vm_bo_base *entry;
>>> @@ -1414,10 +1423,13 @@ int amdgpu_vm_update_pdes(struct 
>>> amdgpu_device *adev,
>>>          r = vm->update_funcs->commit(&params, &vm->last_update);
>>>          if (r)
>>>                  goto error;
>>> +       drm_dev_exit(idx);
>>>          return 0;
>>>
>>>   error:
>>>          amdgpu_vm_invalidate_pds(adev, vm);
>>> +exit:
>>> +       drm_dev_exit(idx);
>>>          return r;
>>>   }
>>>
>>> -- 
>>> 2.25.1
>>>
>
