Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E173DC47DDB
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Jan 2024 19:22:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 717C710FD3B;
	Fri, 26 Jan 2024 19:22:09 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2089.outbound.protection.outlook.com [40.107.94.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F2E7F10FD3B
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Jan 2024 19:22:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dyRAtn0DFhpFUJWOg6VcdnNph1R1InxTidt/zR7nsH2EF79bdkw9Z/LgC2YzUCXcF5jGcwZRkSUcZNGi1AQsNIV0DUR3KS1gCLEAtOa3ibI6Gp7K+4jYUTsucjX4VUY3E8ZM/11eN4+M+PpCv4EgfMUOIYSBCmDdxIqDyI/puIVnL/lQjQaz5uqMPDkpzR+DwU2T0bUdtty8ryAKjWpcHx7ANMVr7+InA0cvU8V/GJJhS4BNYJWonjVfPV5aX051D0TmBM1b7mLlAmUw2A3Gj+8bThYumJWDK7IUCzQPvnqmt8fmrdNMNh8wQzj9WBoEs3NVCeeCI7xh7DUHHe3zDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h4+XYT91+45jHJkm+VD8O/EZVMgT1upf1H/jfiq8p/o=;
 b=Q0syOpBK2oVQVBsSk0pFEnDfcnx1oNQtNkSGYRxrNVJB6R3dn+asLAoLUj7SR7h/s/KvNCUmF3jzLXl4csYyUcLUbVD5Q4ADFMKLt/SIKJUsSbvmFQNPqYsNScR3B9H6AgKyPyfcYUVE5kvZ76LNRtsjWbi7P+BbHjTEOoI5NnZoY9bu1BcGETs4/Ud/BmzxorzaCK+IrZrLUCZgDCZgS1vuG2AsKP1MKPKPf54R6U7QxYnHVoPvo2tdQqWWQD+F2Tpb7GiN2uQmZ9BnXJM3FzsJubmWiZMMelR97Rj2UGRE+79bcqqwZW2/qY3kkYLEK9BUsS/f+141v4oUhUNTVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h4+XYT91+45jHJkm+VD8O/EZVMgT1upf1H/jfiq8p/o=;
 b=XtaEWyjEj/pLt2NNe0DVuXZQWbSfaQjn2/Fjiek75upBkFPz4tH0TqkUYD7SkXXGgrX823/zkZuDy4bqCpG0dc5jx4+Uaf+CmOfY9QJJtVxuDCSQ2pG4RtEplvtZoGUdPvfhk92JiPfKIC6WmwH1VzJrBclUJFqURVwbZ0PveDg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by PH7PR12MB5879.namprd12.prod.outlook.com (2603:10b6:510:1d7::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.26; Fri, 26 Jan
 2024 19:21:49 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::6f2f:7892:e9fe:c62b]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::6f2f:7892:e9fe:c62b%5]) with mapi id 15.20.7228.027; Fri, 26 Jan 2024
 19:21:49 +0000
Message-ID: <f41dadc8-3cff-4036-b78a-9bfe7fb353b4@amd.com>
Date: Fri, 26 Jan 2024 14:21:48 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdkfd: reserve the BO before validating it
To: "Yu, Lang" <Lang.Yu@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20240122090843.1540732-1-Lang.Yu@amd.com>
 <b1660947-5ee8-4b6f-a760-fb82d3d09399@amd.com>
 <MW6PR12MB8898D40BC526B6915B6FA71FFB792@MW6PR12MB8898.namprd12.prod.outlook.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <MW6PR12MB8898D40BC526B6915B6FA71FFB792@MW6PR12MB8898.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0251.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:66::15) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|PH7PR12MB5879:EE_
X-MS-Office365-Filtering-Correlation-Id: 65ef7bcf-0128-4c98-a833-08dc1ea40b86
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5F82PkOgbXHeoqjo90mZSlCQCddu99fXYiJKZGdkKu+w/eXXhgqVISrY1ucSCccmK0rnalVKNF1s8inxa32Jj7QxhP+rNTkuvduAeGsDqak7HEpYHfKvzMnF3TQCsQcp0Sif1jygp4Gn4H0TG1I+doZLbP28l9krvvLNeEK3wRVrZu/5ZrviBbiV5KokcMU1Cf/6o4d1gZ8psrQCEoEcJUGlngcUSlclS5v9bRgKUKjD83PJl1tHjrskuHbo/WtfGRArNTXNgztkEviLPcT+fsAMD+vvVQgCjl52I5i/anChmGMQCdqrhhSvnYX2357wRy6qIL4YowV7ncxltyfe9x9WeLsGQ/4s4NjZ4wmfuczyynBcQkq/bqC/s5yepDhHiDU691k2/B9Fa0lAtyZX/4Qeo4yHCzfgK6M9xDeNLtgzyg6Gn41t5DH5JC9Y9HCBjRU400gpvAuzQq3PJ0kzcfF24soq4dnCD8fiHS4jVYKzQNdMzU2vk2xy87Y0eWsO1ZwYE/4niZis1mKUvNcRhF78KqY2l7g2m8eFoGVeXcFxLUQI0m+CBH7xwEyzlxnuYIdzHaOG+iiOzlW4mIXgygwpa6muxATMZyZ3DoXb+FzvgmyPdzpiRxq1GuuJBZ5v4rXJLKSBRv5dCLgxc5mETOOx/8Z1o9njgHcdu3vj3cWsKDeF0hXtiP0dsmvZs2aW
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(376002)(39860400002)(366004)(396003)(346002)(230273577357003)(230922051799003)(230173577357003)(64100799003)(1800799012)(451199024)(186009)(41300700001)(83380400001)(2616005)(6512007)(6506007)(38100700002)(26005)(6486002)(478600001)(5660300002)(8676002)(44832011)(36916002)(2906002)(53546011)(66476007)(4326008)(8936002)(66556008)(316002)(110136005)(66946007)(86362001)(31696002)(36756003)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WGVqS3hZS0JlRmdOWWRKbkYwUXZhYWdtWlV5eHBUcFhNRkdvNU5NMWJzYXU5?=
 =?utf-8?B?ZitybjJydjR1cmZWeFl4ZGZ3Q292Q01ma3hJV25IR0pIUFhubHdZNXgvaTV5?=
 =?utf-8?B?UDNpSHdNSTV1c0hOVGJUMlZPSVpZK1ZBeHBNODUraVBoYlJVWGFwandJQ21k?=
 =?utf-8?B?R1I1STZWSFNTMzI4cngzRml0ZVVXQU9KaC9xZmVsMjdvLzltaHlKV3ppMm44?=
 =?utf-8?B?RnQwZDVVVDc1dGUrMmtUZml2ZmtYVzZ0NDVJRjlNRDl3alFpaEhneVNWaTlF?=
 =?utf-8?B?SlFzZFBocERISm9sTktnaFZVR3VtVlZnN3VtdnZrc0pZTXlUcWVrbDZxNEho?=
 =?utf-8?B?ZlVlWEh4bUxNUG1BQXJhbDJnMW05MFR4eEhPTWpjSVBReXlkay9TWGFyL1VN?=
 =?utf-8?B?TU5sdlJvaDVQVnNSekNKc1ZTakF4YlJ3K3F3b2JTZW1Mb1VIcERnYjRaakFG?=
 =?utf-8?B?QjBpZVdtR2Mvc2lDaG8xNStKRUk4MGlWVk9KdXdWcE9wbTBYMndaa2RkVzhZ?=
 =?utf-8?B?ZUFzcFNiNnM3ZGpOUjA2ZVAwVCt0N0p2UUFtcERrZkNkS3FNWXR1bjNtVEk4?=
 =?utf-8?B?RzdnRklTbjg1cnB5WElnU0JYWERMQUN4NHpBQjRtaDdzTG16MGRKemM2OUp1?=
 =?utf-8?B?L0RiS2QvREl4VVJzYUZKNjFZN1ZuNXdES202WUZwRDJEK3IzTEllNnFQcnNh?=
 =?utf-8?B?RERhOVBTOE9QTklNalB6STBmRVA1dzJ2ODhsRzR1N0EzQ2tQdFpiQ2x2elNr?=
 =?utf-8?B?dnF4blVlbEVlMnQyVzF2YkRKMk5pazV5UjVNOEZNSzIrd2xiNnM1MGI5b25s?=
 =?utf-8?B?TEt5SkFnVUEwYWg1djgzSUNLOEJqQk1yR0tJckZkQ3JzbWVnSzk2T0Y4aWFB?=
 =?utf-8?B?QlNYNTlNZXJaVUduVW5EOHFnME9UZE0rR2w5Y1kvKzBndHYvUm92QmcvME94?=
 =?utf-8?B?QXJUMGcrSzdiLzRyN1Y5TFl4QlAzVGVDa0hSVHhiLzI5b3lCNEY4QlNwZnVB?=
 =?utf-8?B?UnZUeHRFZGNyZnRNTE1kR1MxU3hVd2hNWFo2T2lGNzdFek9tSXlDSE9wa1lq?=
 =?utf-8?B?UkVNODlaYnRmMHpRcWVhbmhibUNLMUppZUlqU0c0SGoxMVEyVjhoWHk4T2hy?=
 =?utf-8?B?MFJrQzByVHl4bzFJSGRmNWJOMzJ6UEtMNUprbmVnZWlYUzdGK3V1dG5YRExC?=
 =?utf-8?B?K2ZudFI2K3pMdkxieXZBaWJIRUcrYVBtcWdjZDdKTUVKSjA4MGNwSUdOQnUw?=
 =?utf-8?B?QW9qV012SU5ITTJSSlV1anJPcC9iVHNXYVJOb1J1aGVxMUI3VUZURUxpVGVD?=
 =?utf-8?B?SzlrcVptUU05MXBxWTJOcTk4aStHbjhkbWlMTmJKVnJPWGJMZGd4ejZjVkgx?=
 =?utf-8?B?WERQdmQ5eWpPMWJ3bHQxUy9Jc20xQ3FieFFRRldYQ0JxVkdOSVdoOFM5TmJa?=
 =?utf-8?B?TkhDVUlzZERpM2pyZkJxeDFYOHVVUDRtMDloOHl5eVdNd1BFVnRIRWF2VmV3?=
 =?utf-8?B?MUNvV2h0R2FhZTFmMHIwamxTbThsYktCWDFNQWJFZ3N1ejNlMHlCMkZVNVho?=
 =?utf-8?B?MWVRVXBiSmpXL0h1aWJnVkVpdUtmVmx3UHQrc3B5UzBYN1M1TlUyYUlKRlVI?=
 =?utf-8?B?M0xDcGtRQjVEUEtGdXFaM1lWNHVqV2hPNzJvLzJKUjl1c2c3eWVYN0ltaFEw?=
 =?utf-8?B?TUpHazM4OWFxNXV1MzZqUTB3TVFNR21jSnlpMHFDajVyMy9LZGpFWTJOaGtx?=
 =?utf-8?B?YUUwS01IUXdDWXl4MXppYmpsMXNHRmhMM0drL3NEWG1oZStIcVZLdU9nOUky?=
 =?utf-8?B?cVh2SzJ3cE5WLzhxVjUwcGNQWFZuZGk2aGJuZUdlSnNkNUZQVUNIdXBZQUlt?=
 =?utf-8?B?eGpFUk43YnZ2UVRnMDU1d243WDJkZGhVQzIwdWdpaDlveGRKemt6eHdjZGlL?=
 =?utf-8?B?R1lqUTI0bEhIdjk5U0JadTF3MWo0dUlXd2hDYXhHeW5BaDM5UmU2Vmtwdjc2?=
 =?utf-8?B?emcvUi83VVRZRGhyR0IxL1VXRGVuT2JyTFVnSGsrRElBS1FGd2VFRUc0eDcv?=
 =?utf-8?B?K2xkSkh0KzFQTDFhTlk1VFJxU0lYUEFMc0F4Qm5GKzhrWGIwM2xxTEpPYitY?=
 =?utf-8?Q?Vrh24vvj9lG5hBEnquATkETGz?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65ef7bcf-0128-4c98-a833-08dc1ea40b86
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2024 19:21:49.8085 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KnVnsTp/sxt/2qscofg+HEy4sve/GdP+5+yJMtKhSOJd8cp8aEZez3ssbBX+ExbCLEHqPDY5MPjxEPtksWm0xw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5879
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
Cc: "Francis, David" <David.Francis@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 2024-01-25 20:59, Yu, Lang wrote:
> [AMD Official Use Only - General]
>
>> -----Original Message-----
>> From: Kuehling, Felix <Felix.Kuehling@amd.com>
>> Sent: Thursday, January 25, 2024 5:41 AM
>> To: Yu, Lang <Lang.Yu@amd.com>; amd-gfx@lists.freedesktop.org
>> Cc: Francis, David <David.Francis@amd.com>
>> Subject: Re: [PATCH v2] drm/amdkfd: reserve the BO before validating it
>>
>> On 2024-01-22 4:08, Lang Yu wrote:
>>> Fixes: 410f08516e0f ("drm/amdkfd: Move dma unmapping after TLB flush")
>>>
>>> v2:
>>> Avoid unmapping attachment twice when ERESTARTSYS.
>>>
>>> [   41.708711] WARNING: CPU: 0 PID: 1463 at
>> drivers/gpu/drm/ttm/ttm_bo.c:846 ttm_bo_validate+0x146/0x1b0 [ttm]
>>> [   41.708989] Call Trace:
>>> [   41.708992]  <TASK>
>>> [   41.708996]  ? show_regs+0x6c/0x80
>>> [   41.709000]  ? ttm_bo_validate+0x146/0x1b0 [ttm]
>>> [   41.709008]  ? __warn+0x93/0x190
>>> [   41.709014]  ? ttm_bo_validate+0x146/0x1b0 [ttm]
>>> [   41.709024]  ? report_bug+0x1f9/0x210
>>> [   41.709035]  ? handle_bug+0x46/0x80
>>> [   41.709041]  ? exc_invalid_op+0x1d/0x80
>>> [   41.709048]  ? asm_exc_invalid_op+0x1f/0x30
>>> [   41.709057]  ? amdgpu_amdkfd_gpuvm_dmaunmap_mem+0x2c/0x80
>> [amdgpu]
>>> [   41.709185]  ? ttm_bo_validate+0x146/0x1b0 [ttm]
>>> [   41.709197]  ? amdgpu_amdkfd_gpuvm_dmaunmap_mem+0x2c/0x80
>> [amdgpu]
>>> [   41.709337]  ? srso_alias_return_thunk+0x5/0x7f
>>> [   41.709346]  kfd_mem_dmaunmap_attachment+0x9e/0x1e0 [amdgpu]
>>> [   41.709467]  amdgpu_amdkfd_gpuvm_dmaunmap_mem+0x56/0x80
>> [amdgpu]
>>> [   41.709586]  kfd_ioctl_unmap_memory_from_gpu+0x1b7/0x300 [amdgpu]
>>> [   41.709710]  kfd_ioctl+0x1ec/0x650 [amdgpu]
>>> [   41.709822]  ? __pfx_kfd_ioctl_unmap_memory_from_gpu+0x10/0x10
>> [amdgpu]
>>> [   41.709945]  ? srso_alias_return_thunk+0x5/0x7f
>>> [   41.709949]  ? tomoyo_file_ioctl+0x20/0x30
>>> [   41.709959]  __x64_sys_ioctl+0x9c/0xd0
>>> [   41.709967]  do_syscall_64+0x3f/0x90
>>> [   41.709973]  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
>>>
>>> Signed-off-by: Lang Yu <Lang.Yu@amd.com>
>>> ---
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h    |  2 +-
>>>    .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  | 28
>> +++++++++++++++++--
>>>    drivers/gpu/drm/amd/amdkfd/kfd_chardev.c      |  4 ++-
>>>    3 files changed, 29 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>>> index 584a0cea5572..41854417e487 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>>> @@ -311,7 +311,7 @@ int
>> amdgpu_amdkfd_gpuvm_map_memory_to_gpu(struct amdgpu_device *adev,
>>>                                         struct kgd_mem *mem, void
>> *drm_priv);
>>>    int amdgpu_amdkfd_gpuvm_unmap_memory_from_gpu(
>>>               struct amdgpu_device *adev, struct kgd_mem *mem, void
>> *drm_priv);
>>> -void amdgpu_amdkfd_gpuvm_dmaunmap_mem(struct kgd_mem *mem, void
>>> *drm_priv);
>>> +int amdgpu_amdkfd_gpuvm_dmaunmap_mem(struct kgd_mem *mem, void
>>> +*drm_priv);
>>>    int amdgpu_amdkfd_gpuvm_sync_memory(
>>>               struct amdgpu_device *adev, struct kgd_mem *mem, bool intr);
>>>    int amdgpu_amdkfd_gpuvm_map_gtt_bo_to_kernel(struct kgd_mem *mem,
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>>> index 6f3a4cb2a9ef..7a050d46fa4d 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>>> @@ -2088,21 +2088,43 @@ int
>> amdgpu_amdkfd_gpuvm_map_memory_to_gpu(
>>>       return ret;
>>>    }
>>>
>>> -void amdgpu_amdkfd_gpuvm_dmaunmap_mem(struct kgd_mem *mem, void
>>> *drm_priv)
>>> +int amdgpu_amdkfd_gpuvm_dmaunmap_mem(struct kgd_mem *mem, void
>>> +*drm_priv)
>>>    {
>>>       struct kfd_mem_attachment *entry;
>>>       struct amdgpu_vm *vm;
>>> +    bool reserved = false;
>>> +    int ret = 0;
>>>
>>>       vm = drm_priv_to_vm(drm_priv);
>>>
>>>       mutex_lock(&mem->lock);
>>>
>>>       list_for_each_entry(entry, &mem->attachments, list) {
>>> -            if (entry->bo_va->base.vm == vm)
>>> -                    kfd_mem_dmaunmap_attachment(mem, entry);
>>> +            if (entry->bo_va->base.vm != vm)
>>> +                    continue;
>>> +            if (entry->type == KFD_MEM_ATT_SHARED ||
>>> +                entry->type == KFD_MEM_ATT_DMABUF)
>>> +                    continue;
>>> +            if (!entry->bo_va->base.bo->tbo.ttm->sg)
>>> +                    continue;
>> You're going to great lengths to avoid the reservation when it's not needed by
>> kfd_mem_dmaunmap_attachment. However, this feels a bit fragile. Any changes
>> in the kfd_mem_dmaunmap_* functions could break this.
>>
>>> +
>>> +            if (!reserved) {
>>> +                    ret = amdgpu_bo_reserve(mem->bo, true);
>>> +                    if (ret)
>>> +                            goto out;
>>> +                    reserved = true;
>>> +            }
>>> +
>>> +            kfd_mem_dmaunmap_attachment(mem, entry);
>>>       }
>>>
>>> +    if (reserved)
>>> +            amdgpu_bo_unreserve(mem->bo);
>>> +
>>> +out:
>>>       mutex_unlock(&mem->lock);
>>> +
>>> +    return ret;
>>>    }
>>>
>>>    int amdgpu_amdkfd_gpuvm_unmap_memory_from_gpu(
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>>> b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>>> index ce4c52ec34d8..80e90fdef291 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>>> @@ -1442,7 +1442,9 @@ static int kfd_ioctl_unmap_memory_from_gpu(struct
>> file *filep,
>>>                       kfd_flush_tlb(peer_pdd, TLB_FLUSH_HEAVYWEIGHT);
>>>
>>>               /* Remove dma mapping after tlb flush to avoid IO_PAGE_FAULT
>> */
>>> -            amdgpu_amdkfd_gpuvm_dmaunmap_mem(mem, peer_pdd-
>>> drm_priv);
>>> +            err = amdgpu_amdkfd_gpuvm_dmaunmap_mem(mem,
>> peer_pdd->drm_priv);
>>> +            if (err)
>>> +                    goto sync_memory_failed;
>> This handles the case that the system call got interrupted. But you're not handling
>> the restart correctly. When the ioctl is restarted, you don't know how many
>> dmaunmaps are already done. So you'd need to make sure that repeating the
>> dmaunmap is safe in all cases. Or what David tried earlier, find a way to track the
>> unmapping so you only try to dmaunmap on GPUs where it's actually dmamapped.
>  From previous discussion, no one likes add another variable to track the unmappings. So I'm avoiding adding another variable.
>
> Actually, all memory attachments use sg_table, ttm->sg is NULL? can be used as an indicator to see whether an attachment is already unmapped.
> That already unmapped will not be repeated.

I think that should work. I'd add the checks in kfd_mem_dmaunmap_userptr 
and kfd_mem_dmaunmap_sg_bo, where we also set ttm->sg to NULL. In fact, 
both those functions already have that check. So looks like it should 
handle the the restart correctly with your patch.

Regards,
   Felix


>
> Regards,
> Lang
>
>> Regards,
>>    Felix
>>
>>
>>>       }
>>>
>>>       mutex_unlock(&p->mutex);
