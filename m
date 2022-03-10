Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 517A4C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Mar 2022 00:58:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C7D0E10E494;
	Thu, 10 Mar 2022 00:58:33 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2050.outbound.protection.outlook.com [40.107.92.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 91DB210E494
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Mar 2022 00:58:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZWoNQlRtLta3qUzP39IwH99ExkfaGj56s+j0aydYKv7KTwBScTybd4oIR52XyL+TqJom/QZdxD1kSuJrd1rjzPrfhwJJrer3OYxGLejumI0/gJQVsW3LZOXFZLSPFJddytlgSGc1CN0+TEajUMONxL6q6nPQiElZzgHpHKpvs4y6VJxMGpQPoUyEkDgkHpym23ZsI2e6etIQscM4rsGfjMke0FH6KDTHs+28q6VI5rb4d7vMc9Gp/9F6DMWzKfRC4MRZNRYmEyNMaa7azgxs+mnxjgSoAMxpU10L9W70Bt+KEr/BmKSeL8bKd9b+T/u0iirDk+gtepu/KGBU7FQ9lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yCJLA55zS0TBZsNZtiTVXirrinGhZ/LKTpOElJf9lPA=;
 b=ndUVszusCD3Tyck2wxOpQ1fl9Fi7wLF+e4csffYGD62rw/LJqB1Vy2zamxW4PBTymYa2/Lv6vFUUYgVfpmxe8RveEUhXbG12WBi4IhQoaENpr2tub/dONlFqV5xUpM3zcaHBXm3msaxPv2ihWKtQkduAXI0QQCysnjTEtgfZhshOsP+NPfR8xYcVKfPRm4mTUL0sSVmwWftyETJc+EikFjEch/xdXlHITlPIZDiDqegpucXZHxy/+MsEntZA7c3L6QxAHd0JKTSzhkqDd3+oTrNpevCo7wmatJMNZzoWsNrveTkSGKRz19yZutA391QomH4UoocmBxSaOJ+pH5htIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yCJLA55zS0TBZsNZtiTVXirrinGhZ/LKTpOElJf9lPA=;
 b=1PtO13c9qwibjPAkCRL9O4WAm09UAi+KSACRb/erYVdSpDsO1D4NBnp5vNZN5yse9p9ZDtg4bGA8pKB7tClXig+A4HqcmBeXtZ6Jyr6NtVovFi+PRBfdnsK1ioauOgJ4BghIYeH/Hld2AbFeLBoEFQSSz58UpNtzLEdWxfJ/3Ds=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by MN2PR12MB4111.namprd12.prod.outlook.com (2603:10b6:208:1de::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Thu, 10 Mar
 2022 00:58:27 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::b030:b1ba:4eb2:7fb7]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::b030:b1ba:4eb2:7fb7%6]) with mapi id 15.20.5038.027; Thu, 10 Mar 2022
 00:58:27 +0000
Message-ID: <e8004696-5131-7c9d-53bd-8a22828ab581@amd.com>
Date: Wed, 9 Mar 2022 19:58:25 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] drm/amdgpu: fix aldebaran xgmi topology for vf
Content-Language: en-US
To: "Kim, Jonathan" <Jonathan.Kim@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20220309221645.468184-1-jonathan.kim@amd.com>
 <99d17bed-06e1-45c2-7a70-449f1ae47eb0@amd.com>
 <DM6PR12MB3163413DD1FA0B1BFA460A7E850A9@DM6PR12MB3163.namprd12.prod.outlook.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <DM6PR12MB3163413DD1FA0B1BFA460A7E850A9@DM6PR12MB3163.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0353.namprd13.prod.outlook.com
 (2603:10b6:208:2c6::28) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f4053e78-6bdc-4f58-2234-08da02311616
X-MS-TrafficTypeDiagnostic: MN2PR12MB4111:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB41119B676B08F9775649F0B8920B9@MN2PR12MB4111.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EWuC8OVc8ho1hOh3/wtCtSMot/NJKhXOtsxXcsJwXFRc3jxi3oRpzKGtGF9VGqhv2OJqcdm4OUSpdra/ezSbqMKnFe6eQnf0o2WQBqw8yIdXE0JxntmFiGPF77b2cMU4ygw+Uj7B/vZ5bfIMai76t3SFwv4P4N9HLU5qr0upCynIin0jtTvC0PdXAIuLXNGCcj3O42bUCKzJVCRzqJBy4303i2JPxCC6dVaItePfN19QnTHPr+4B38liYfNEPPldqBSQT28/gB3jM+Jem2fmJvLSJOjOKY/Rg7zEOy7Iz3RL84NkhUtpKR8gd6mMYZmOobb6Q3CejjLhU88jaaBD9kAE4CeES/V0ldiME1yPsJt+yu1QAApeFwNBEnUS6BDOb1/6jpx5YfkOw4XzP1PUZLnugi2Pe8Z2A52WIkyw+efmR++oRe2Oaxr47+kLYRGndnmSwFDqCnv4ntAen7pxfk/nVKTCMEz6i/AVcLXhAiHfyFkjeIsi20JdVRDM+H2w9QT7vGT8R+GtxI1fM5pkk6pjKCzEZhoiwkr2N4ywmUVbQGjKH+i0gB2fr79O3Qr6Gb8ykxFVT+9dwn74NBWsQLMajqwfFOu7jw2yZA6b+1zSDyjY8gQSWzWryv5lELvkqK//JZMJQvc2yLrRLMb27k3vDGvLjoe+hMD7y5Ug2MDf+DxOCN5cbTQO18HfU55EXKFJLV5J7NZ/59Nnq3Zfwt7Kn0LdLWkf3qrlz1asN+r7ve9PryiGtZPCMKMjfe+G
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(38100700002)(83380400001)(5660300002)(31686004)(44832011)(36756003)(6486002)(6512007)(2616005)(2906002)(6506007)(508600001)(110136005)(53546011)(36916002)(8936002)(31696002)(86362001)(66946007)(26005)(186003)(316002)(4326008)(66476007)(8676002)(66556008)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TEM5aXdlcW90ZFZmcmdXQkFpQ0haZXFSTWdZNDJTZDJ5MUNzUGRqWGQ0U09H?=
 =?utf-8?B?NTlWQTBRRzlWQmFxNDVHaXdmOXRvMmNqSmlGT0NOcDdTRkhRaUY3SGViVTha?=
 =?utf-8?B?QmZ5MEVsdEFvd0ZVMHpyMWVqRWcvUUZhenhGZklwZzJ6c214S1JyeXl1cTVv?=
 =?utf-8?B?SytzTU9aSC9mN0h2dzNHMDFmNTlvaGVHczcrc2FDcGY4NU1zelNrSTJQbERr?=
 =?utf-8?B?VDNWTHZyaUJ2ZlVPNHkvb1dxSFhMUGkxUTNpTFcrclFURXFDd1hTUDRVVVVj?=
 =?utf-8?B?RkpLRHN5NDd4L3R3NlptSjdiVWdOc01yMEZqcEtUdmtJUlU1d1lIZGpZUXg3?=
 =?utf-8?B?bU05d3J3RmM5YW85RVhXOGZvL05oTU43Z2RDTzFXTnFOcFBxSGFMNmlQa2Zm?=
 =?utf-8?B?a0c1dzRPajhOR1A5YS9ZbjhZZEc1dmo3ZGdSVGUxVUZyVjN0QUdrRzJKN0lT?=
 =?utf-8?B?bzZmenY2ZnRTa2pBTGwzTC9rc2tHMERScVNyZmEvZ1lYQ3JhVThGalpPbFEw?=
 =?utf-8?B?Q3pjTGp6MW53YUpSZzZvYTJqLzVEUjVNdVhKdFlyTXV6ZHAzOGJaakFJY0Fq?=
 =?utf-8?B?S2tMeGw2YjFldGlCdFBLM2NybVVBSWttOGpHYXhZME5VNlp4dXRndTlreXQy?=
 =?utf-8?B?MnBOYWRxN2tXaVpRdDQ4czN3dFo0eEQ1b0ZnZVZ6S083QjZCdUdicnhwcEw5?=
 =?utf-8?B?ZGY1WE9RUEMyY3Ztd1piR2JIZUZTc1RCMSs4dnVBaFI3NWcvV1FwSXFqeHZV?=
 =?utf-8?B?eVdxOUtFODE4WkhvVVRJa0tkUm94WXR4b3VzeW00bGlvY0w1M3U5UDVmcTBl?=
 =?utf-8?B?RjJqdDYrWFdyUkxNS2d5ZE1QbXhtOFJxVEczZG5ERmdWYlUzQVZuTXNiNVl3?=
 =?utf-8?B?ZmNYRGtxdEl6dm94VmpUakJybGpQNDF5QTIwVklQbEF2azUxSUt3MTE2R01l?=
 =?utf-8?B?SHhkaGE4THkyYUxYenA0dWZmbElLMnlCZFZNYUlLcW9SR29rWFovd0FmazVT?=
 =?utf-8?B?dzl0MmNyZjlyWXppRTdrSHF1Nk9nVzRBOXh0WUJ4K2daVkxaVDVnMWRpSnUz?=
 =?utf-8?B?ajZoVk16bGMvUTJvamV2czNLVHZuTEhSRWU2WCt5YlhzQnJEZE9aQmxVSWV6?=
 =?utf-8?B?T0FKMWpMMWYxeDhCVE5FcVdwR1RjcjRrOVUrMmR6UFlsOGRZajdGY1lGR3lC?=
 =?utf-8?B?aUFzamhUZGNLdFVUUjE2ZDE1S0lMS2Jvdi9obEsvcGRMMU1YdGp5NWdSbFBL?=
 =?utf-8?B?ZlcwVjBVV2FUSmJlaUJqdEhOZFh5Yml1TXFDUHZsZEdodm1aQ004MWUxRGh4?=
 =?utf-8?B?NDluaFRqS2JHNW5hYS90ejNhRXpDRlZYaUxFVWNQWFMybEN0OXJNOTM2dGF3?=
 =?utf-8?B?YzhjZmNSaTdHMlB1SFp1S00ySWN3bFlYVjBwVnFCRlErTEZPUi9idHZrL0k2?=
 =?utf-8?B?L3RtM1lhV3grb1E0NExEcUgzd1dxRGMzUzl5cVdkNXdHR3k5YXBsalZHbXpv?=
 =?utf-8?B?c0QvbVROME9SeTYzY0lhNE9zSDNQYk9NRHFMQnMrZUovQXF1bmw4STRYWmw0?=
 =?utf-8?B?N3VQVGtTMlhCSjdqNU5vSC9uTFRVWGRXTnhJcVFMM1gxMGJ2MjB6dFdsRlZk?=
 =?utf-8?B?T3doWlhxRVFSOHdEbHEybkRWZ25KbURVRDhJMmFLT3h5ZmFSS2o0U0FvUTla?=
 =?utf-8?B?cXRNVEhoVjBvTzh1UHVUdSsrSXFVVWxmOWdPOWE1WWZhV3RQdzNPeUc2bE9X?=
 =?utf-8?B?T3paTVBBbWdxTytDOC9nb2FSaTgzMVE3UDlDMklzN1hXUmlsOFBXaWNsdjY4?=
 =?utf-8?B?SFpHV1lQNEwrdjQwcDFoTUN3cEI5Z3hORjJLbU1xa2h1TkkweGlBRndFM0Ux?=
 =?utf-8?B?UFkwMTJ0SEVGVFRmTng4ZjJNOC9lVzZNMHR5MXk3YTdUUVZhQ0VZaWtGUDZz?=
 =?utf-8?B?L0g0OXVpR3VBZFVhekhWZXQ1L1ZleEhPOUMyVTZkbG5DVFYyaGtaWUZMdzkx?=
 =?utf-8?B?aytyZlpIQUQ5dy80T3VtNnZ1NWV2MUxsRTYxWU9kUndMZC8raks2bUNkc0Jt?=
 =?utf-8?B?Wkw3Y3FPSyt0eFNBTjN3TjNsdG5HSm96aDBQOGY3eWw4ZFRmVm9ka2xUNDJN?=
 =?utf-8?B?N1g1MzVRQitkMmFqVlIwd1RuaE1hT3A0dzVpRVB2UzdPRnFWcXkxOU0zYlc2?=
 =?utf-8?Q?nbHnwlqWu6RdZ5LMw3pUSsU=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4053e78-6bdc-4f58-2234-08da02311616
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2022 00:58:27.4798 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wkw3AJGjW/Mb2KhBMDkxiXsQYnKkrPdC2ro3iogvVs3bcY0hnNo8QFtRud7uT/+K2oln4Yzc2lnH4SXKz/OalQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4111
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
Cc: "Liu, Shaoyun" <Shaoyun.Liu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 2022-03-09 18:31, Kim, Jonathan wrote:
> [Public]
>
>> -----Original Message-----
>> From: Kuehling, Felix <Felix.Kuehling@amd.com>
>> Sent: March 9, 2022 6:12 PM
>> To: Kim, Jonathan <Jonathan.Kim@amd.com>; amd-gfx@lists.freedesktop.org
>> Cc: Liu, Shaoyun <Shaoyun.Liu@amd.com>
>> Subject: Re: [PATCH] drm/amdgpu: fix aldebaran xgmi topology for vf
>>
>> On 2022-03-09 17:16, Jonathan Kim wrote:
>>> VFs must also distinguish whether or not the TA supports full duplex
>>> or half duplex link records in order to report the correct xGMI topology.
>>>
>>> Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
>> I think I'm missing something here. Your condition for setting
>> supports_extended_data is exactly the same, but you're initializing it in a
>> different function. Can you explain how that change relates to SRIOV?
> I probably should have included more context when sending this out.
> The proposed support assignment happens after this:
>
>          if (amdgpu_sriov_vf(adev))
>                  ret = psp_init_sriov_microcode(psp);
>          else
>                  ret = psp_init_microcode(psp);
>          if (ret) {
>                  DRM_ERROR("Failed to load psp firmware!\n");
>                  return ret;
>          }
>
> and psp_init_sriov_microde doesn't set secure OS micro code info (this is where the support assignment currently is).

I see, so psp_init_sos_base_fw doesn't run on VFs and therefore the XGMI 
info wasn't correct. Moving this to psp_sw_init puts it in a common 
place that is executed on VFs and bare metal. Makes sense.

If you add that explanation to the patch description, the patch is

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


>
> Thanks,
>
> Jon
>
>> Thanks,
>>     Felix
>>
>>
>>> ---
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 6 ++++--
>>>    1 file changed, 4 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
>>> index 3ce1d38a7822..a6acec1a6155 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
>>> @@ -310,6 +310,10 @@ static int psp_sw_init(void *handle)
>>>              return ret;
>>>      }
>>>
>>> +   adev->psp.xgmi_context.supports_extended_data =
>>> +           !adev->gmc.xgmi.connected_to_cpu &&
>>> +                   adev->ip_versions[MP0_HWIP][0] == IP_VERSION(13,
>> 0, 2);
>>> +
>>>      memset(&boot_cfg_entry, 0, sizeof(boot_cfg_entry));
>>>      if (psp_get_runtime_db_entry(adev,
>>>                              PSP_RUNTIME_ENTRY_TYPE_BOOT_CONFIG,
>>> @@ -3008,7 +3012,6 @@ static int psp_init_sos_base_fw(struct
>> amdgpu_device *adev)
>>>              adev->psp.sos.size_bytes = le32_to_cpu(sos_hdr-
>>> sos.size_bytes);
>>>              adev->psp.sos.start_addr = ucode_array_start_addr +
>>>                              le32_to_cpu(sos_hdr->sos.offset_bytes);
>>> -           adev->psp.xgmi_context.supports_extended_data = false;
>>>      } else {
>>>              /* Load alternate PSP SOS FW */
>>>              sos_hdr_v1_3 = (const struct psp_firmware_header_v1_3
>>> *)adev->psp.sos_fw->data; @@ -3023,7 +3026,6 @@ static int
>> psp_init_sos_base_fw(struct amdgpu_device *adev)
>>>              adev->psp.sos.size_bytes = le32_to_cpu(sos_hdr_v1_3-
>>> sos_aux.size_bytes);
>>>              adev->psp.sos.start_addr = ucode_array_start_addr +
>>>                      le32_to_cpu(sos_hdr_v1_3->sos_aux.offset_bytes);
>>> -           adev->psp.xgmi_context.supports_extended_data = true;
>>>      }
>>>
>>>      if ((adev->psp.sys.size_bytes == 0) || (adev->psp.sos.size_bytes ==
>>> 0)) {
