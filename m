Return-Path: <SRS0=YYL8=OG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 496A1C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Sep 2021 15:45:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE9F761212
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Sep 2021 15:45:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org DE9F761212
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7DA9D6EB92;
	Thu, 16 Sep 2021 15:45:43 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2069.outbound.protection.outlook.com [40.107.244.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 09FE86EB92
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Sep 2021 15:45:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MutWYR3Pt31/6uK9l+5qfYAM7pjV9BgcLVqeSaf/wVu2TCh8nUfXhT3vtf/PYItWa0FvX1IGdOILH+uEXdMUaEcg7hzCE5myUkMNaWmSQcf8NyQM/Ik2mKc+Pr3halL64qm+HLeaQAW92gO65DfEsyt8MSwqzCBfyKMLKz1Oup6Ko9zWgRxZCT5VSSl8T6y905uq87WUQniotrMqnMJ52DEby3ttQTu8YVCgG3Mm/vUFbiiYllfqDIoRrbeFHYQP0qxSmDmWHT+T6Scss2awKB4mWwaEevwE/u4u9wUqFHqgBuFqKSM9e6/C5GpTg/bFkBcNc2c7o+wc9P7z6P9apw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=/tD8Y9tjp751yM+3wxgKjzkTs82kzhElwGgR25HKUb8=;
 b=Y1od0vE27TXn3nMsWpEVEY6VBXBJy7bgPn2ZsD5Km8cwggAkmMwD2jeh7iiikMR2Bl2wat/5sMzY/36oW4bsxc9iv2e7Ed9pSialMHqKBO2X/ocd+nbIfqk/zszMgyvcq1Y4aop8RDRHmXr74tGh1tttfr6NsG/vSHCeI2/Mx4kFbeFPj9EiCAWYgY1fDyjBm8lOhqWlOCT+4Cg3WAr9NuHy8asIWwwt0YKXeoiwqWx4AbWzRSs5T7sAWUssrx43ylx8yXvR0WUbTOfifn85qtz0KHQUAvJq7/T1sJFNp4Qv3OrgnpWE5RvhkYA/huZQu3TD3pnj9yIfDAut2HHSGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/tD8Y9tjp751yM+3wxgKjzkTs82kzhElwGgR25HKUb8=;
 b=BsfAJaTm/wvtOE+Kj2TQO3SyG2TZAtUP8l/K/kZW3AxoiJyhRbmNvizyUKe8lFLdIRKvoJ/CorN2bey+ve4iFuKDuuCKU+NpjAc2ZOGglw6CQB78hN1bK37YzBMlGUiN0TYc9TLzPVMqAtLEf7POPBOdkvbRLMXm18XnHv4M6/8=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB4623.namprd12.prod.outlook.com (2603:10b6:805:e9::17)
 by SN1PR12MB2400.namprd12.prod.outlook.com (2603:10b6:802:2f::25)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Thu, 16 Sep
 2021 15:45:39 +0000
Received: from SN6PR12MB4623.namprd12.prod.outlook.com
 ([fe80::c4ac:2505:5bd8:295d]) by SN6PR12MB4623.namprd12.prod.outlook.com
 ([fe80::c4ac:2505:5bd8:295d%6]) with mapi id 15.20.4500.019; Thu, 16 Sep 2021
 15:45:39 +0000
Subject: Re: [PATCH] drm/amdgpu: Fix crash on device remove/driver unload
To: "Lazar, Lijo" <lijo.lazar@amd.com>, amd-gfx@lists.freedesktop.org
Cc: evan.quan@amd.com, xinhui.pan@amd.com, alexander.deucher@amd.com
References: <20210915194153.455140-1-andrey.grodzovsky@amd.com>
 <e5f543f5-f2c3-294a-59f1-4c5ca99233ee@amd.com>
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Message-ID: <a0c98e67-9690-cfb2-35ef-806561d6bf44@amd.com>
Date: Thu, 16 Sep 2021 11:45:36 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <e5f543f5-f2c3-294a-59f1-4c5ca99233ee@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: YT2PR01CA0020.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:38::25) To SN6PR12MB4623.namprd12.prod.outlook.com
 (2603:10b6:805:e9::17)
MIME-Version: 1.0
Received: from [IPv6:2607:fea8:3edf:49b0:2565:1b45:13cb:473]
 (2607:fea8:3edf:49b0:2565:1b45:13cb:473) by
 YT2PR01CA0020.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:38::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4523.14 via Frontend Transport; Thu, 16 Sep 2021 15:45:38 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bc543bb5-c2ea-4342-c069-08d979290844
X-MS-TrafficTypeDiagnostic: SN1PR12MB2400:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN1PR12MB2400D3824E3E81C815C1F80BEADC9@SN1PR12MB2400.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DS8HgMznLh9vPPSUd1pRKyut+X5nTZfAkdpNuE+wQeGHA4F2EL1ajCYXiNk3OOzK+4uwsbFnOUUsKunpaz+5PrsOYaFN6qycKUz448bq7fvpKDWG/USDyyasn6bCWvcjTYPjsyPHB6esGRKSRXJ6sZYibIcqhcR+EXUZfryfDCAinoY5gv2fxYNFfoYVj5DjSEJpvCsxBMtUqmNn4jIUgd2LBp+Gu+ab7rCOiSevc2461ovK780lB+7zczXMzH4NkCAp7mGYUPRT4HVSy7m8Ni+0qpdC6Pkg8Ob1eJ2pLbS4WdXS8fFeT59sXQP1s+5r6spIQdK6LHEESKNdRNhdVqbwTJVlONeLCRap2RrXME906urz5nwsVB6mYFBsrNkyPqZBdSBcQNxyFkatp8P/N4RHCk35qlRor77eVMG2EKr4Vjs3HE28Z3Wgxwl04J5LGUovBB+sDQ6eWYGRlnS51S9Dpr6vU4Z0RyssH9psRUstTIMkLJAQS5SMXefATEzOCcKJQYqBdhD1am4fzul1ydMWkxyWceBgGyyo+E3HKxUJLeA2ddqloOdgDhzRoWrOwY7LBDDqCwrA5sWfAdUeKe7LjMR/CX8VKjPgVsvEUH4CSEps4eY99yQmqluSdh43rcGsFqY3b0cAa2xTImXp6ML2e+rqxzP2JI/goukxk/cPAIgRGk5l+8hrVQ3ed92OOlKqC2xhuUOZH/WMPryNqG5xo85wg0oCiBw0OazyNvs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR12MB4623.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(346002)(39860400002)(366004)(136003)(376002)(2906002)(6486002)(44832011)(316002)(186003)(31686004)(8676002)(8936002)(66946007)(2616005)(4326008)(53546011)(66556008)(66476007)(30864003)(31696002)(36756003)(478600001)(86362001)(83380400001)(38100700002)(5660300002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a2F3bDJZQlNnVGJOSjliRHJCZ0NqS09FOHFOcnBHcmhKWjRTdHR4RndNRFN3?=
 =?utf-8?B?U0g3RXRUU2tGTWJvR2FnUWpwcStTZ2NJQURxQXJjaXdmUzhsa1FYVWNXRHdB?=
 =?utf-8?B?dkxHemVYM2VDajVMQUhNS2NCbVlMdlQ0NVF0SmNhUUozQ1RQV0VBRUdJSXdo?=
 =?utf-8?B?K3JtQmhpR245NWczSWR3VmZZT211R28zcmZmVjRPUkN2cVZZdUErVHBwZjhr?=
 =?utf-8?B?aGtRemVFNTBOK2xod1FLNEpBdU5PQWVnSC9MM0ZFd21rTnRHWjB3dkszcTE2?=
 =?utf-8?B?enIzL0ZqWlZkSlRwRmgwM09zRlVGSlBqbFB1NldlcGkrQkVIS0NUVUIxR2wr?=
 =?utf-8?B?YzVMZmJIdmlVc3piT2Z2TGdGb0x2T25td3JQWTNFQjMwYjc4bFZJWkF2T1p0?=
 =?utf-8?B?REZUV2ZseHk0ZlBLRFB4WUVsWCtzUWJIZ3daTnFIWkNZeEdscHpnOHBtcVd1?=
 =?utf-8?B?WnlIZWFQK0tXTjVnTjhTOWFoUjVqVXgwalNSZFZQS1hJc3dXWmFvTGdqZmJQ?=
 =?utf-8?B?dEZGYW5ZOG5nL1J6OFhraUtnT3VEMUVHNmR6cXJ3RWIvdnZJbURscTNwSVNo?=
 =?utf-8?B?VnoxbjhhTGhaeHkrSUFhZDlROGF0Y3JzcFVkZTR1ZDM0ZWlIWm9zY2UzblRM?=
 =?utf-8?B?d1IzR3MrWWp2RDJnWWNvdkNScGxwK1d1MmJ1UjUwd3Y1VTIrTGVKQnRHWkVG?=
 =?utf-8?B?NHhpVFVmRXQvQzhjV043MC93SFNUK0R1b1k2YjhuWU1lY1lpcUt5cGdzamdq?=
 =?utf-8?B?eGRLK1IwNGZ4SnJHZjNHa2tWOEZNNEk2dm9RQTNjVHBST2NyMEJHYVJMM3F5?=
 =?utf-8?B?eTUrZm03MjBIU1phQ2Y3MVoyVDBWSXExWFZMRlZ1dHZMNVVhMmVSYTk2bTF0?=
 =?utf-8?B?WmRmVHFvcWxzcXV1SzUzTEV3OWFkdWlRaldnWE1YU2xCU25CKzBXYzRzZUhp?=
 =?utf-8?B?N0lLN3hyN3djREdkZGhpc3M3bmtaRThEcCtQTmI1NUtpaGNKbnpZRlpxTnhC?=
 =?utf-8?B?OVVBNTlBbWRrWU1XNDlSUFNTMzhaZnhxWkh0bndFd2dDTkUyempreFdndjlj?=
 =?utf-8?B?UlpES1JqY1NScGZTQkdTM2JPNEIwL1JBV3ByQnRLUUpoM1F0TlF0WEpFazJ1?=
 =?utf-8?B?L3BkSG1DMGtWWW5KaDRkRStXS3VPN1NDemV3UG1sZmJmOG9JRFhZYjdJT3By?=
 =?utf-8?B?TW5VLzVFOE1pYUtZVWU2WnRiWGM0b2VNNWJKdDZqVTF6SjB1aEM0MHRCZnFS?=
 =?utf-8?B?Qys0bFhxRjBBYmFTYzVyRFhqeEtXd0k0dDhJc2NmWldjNXdrTy9ZMjlPakJD?=
 =?utf-8?B?QVQ1bnovaHVnUFhxK1BMSzhDRzBITFdaTG92OGMxOXcxUE9wUmxxQm5rODBC?=
 =?utf-8?B?MHR6MHMrL1BvLzAzMDllVEJyMDBoNVlGZTNHZXlxekt6aFAweTdhYWdFN2k4?=
 =?utf-8?B?WC85VEYzSWZ5MGt1RTA5MnE3OHBlUnNMUHMxNkFOMEwvaG1NNlJSVkNCU25h?=
 =?utf-8?B?Yy92bDhDc096bThDaE9WZnh4TzB3RE5wT3Z2UUJHZkxvVHBMNEJSWDZtR2dV?=
 =?utf-8?B?OXpuMCsvR0FNSElVaUVka3VyczljSElwWlRhbFRFU3JGK08wUEl6bS84Rmhj?=
 =?utf-8?B?L2pPRVJGd21MZ3JHY2t3V1FhYmdjOExiYm03OTdnVlpDb05OVDVsNHU3dEpZ?=
 =?utf-8?B?eENnUW93Qm9FSGQxeHAzT1BmdTBkWDBRWTRkTDdRWFVFbVI1WlJOb2hqd3Qv?=
 =?utf-8?B?UE9IZ1QxalozSUoyTXpka3NXbmRMdEx6dUpZV1JOWm1pUVBxWHRQUUhxamxY?=
 =?utf-8?B?RmppWWNxSGcyU2M2N09IOHJEUmJJTVFhWlY3cDVpMzl2dm1wM2RVckZZaisy?=
 =?utf-8?Q?L0WXtuXSlNxXp?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc543bb5-c2ea-4342-c069-08d979290844
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB4623.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2021 15:45:39.2127 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NeKrJjSZIm+UOA2pddT/XOOWlEe91dA9EMfglGDj1CnpGrU3yLEPOumM6if152xfm5ZzrF/1aT+Liy31S6LSLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2400
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


On 2021-09-16 4:20 a.m., Lazar, Lijo wrote:
> A minor comment below.
>
> On 9/16/2021 1:11 AM, Andrey Grodzovsky wrote:
>> Crash:
>> BUG: unable to handle page fault for address: 00000000000010e1
>> RIP: 0010:vega10_power_gate_vce+0x26/0x50 [amdgpu]
>> Call Trace:
>> pp_set_powergating_by_smu+0x16a/0x2b0 [amdgpu]
>> amdgpu_dpm_set_powergating_by_smu+0x92/0xf0 [amdgpu]
>> amdgpu_dpm_enable_vce+0x2e/0xc0 [amdgpu]
>> vce_v4_0_hw_fini+0x95/0xa0 [amdgpu]
>> amdgpu_device_fini_hw+0x232/0x30d [amdgpu]
>> amdgpu_driver_unload_kms+0x5c/0x80 [amdgpu]
>> amdgpu_pci_remove+0x27/0x40 [amdgpu]
>> pci_device_remove+0x3e/0xb0
>> device_release_driver_internal+0x103/0x1d0
>> device_release_driver+0x12/0x20
>> pci_stop_bus_device+0x79/0xa0
>> pci_stop_and_remove_bus_device_locked+0x1b/0x30
>> remove_store+0x7b/0x90
>> dev_attr_store+0x17/0x30
>> sysfs_kf_write+0x4b/0x60
>> kernfs_fop_write_iter+0x151/0x1e0
>>
>> Why:
>> VCE/UVD had dependency on SMC block for their suspend but
>> SMC block is the first to do HW fini due to some constraints
>>
>> How:
>> Since the original patch was dealing with suspend issues
>> move the SMC block dependency back into suspend hooks as
>> was done in V1 of the original patches.
>> Keep flushing idle work both in suspend and HW fini seuqnces
>> since it's essential in both cases.
>>
>> Fixes:
>> 2178d3c189b9 drm/amdgpu: add missing cleanups for more ASICs on 
>> UVD/VCE suspend
>> ee6679aaa61c drm/amdgpu: add missing cleanups for Polaris12 UVD/VCE 
>> on suspend
>> Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c | 24 ++++++++-------
>>   drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c | 24 ++++++++-------
>>   drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c | 24 ++++++++-------
>>   drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c | 32 ++++++++++---------
>>   drivers/gpu/drm/amd/amdgpu/vce_v2_0.c | 19 +++++++-----
>>   drivers/gpu/drm/amd/amdgpu/vce_v3_0.c | 28 +++++++++--------
>>   drivers/gpu/drm/amd/amdgpu/vce_v4_0.c | 44 ++++++++++++++-------------
>>   7 files changed, 105 insertions(+), 90 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c 
>> b/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c
>> index 7232241e3bfb..0fef925b6602 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c
>> @@ -698,6 +698,19 @@ static int uvd_v3_1_hw_fini(void *handle)
>>   {
>>       struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>>   +    cancel_delayed_work_sync(&adev->uvd.idle_work);
>> +
>> +    if (RREG32(mmUVD_STATUS) != 0)
>> +        uvd_v3_1_stop(adev);
>> +
>> +    return 0;
>> +}
>> +
>> +static int uvd_v3_1_suspend(void *handle)
>> +{
>> +    int r;
>> +    struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>> +
>>       /*
>>        * Proper cleanups before halting the HW engine:
>>        *   - cancel the delayed idle work
>> @@ -722,17 +735,6 @@ static int uvd_v3_1_hw_fini(void *handle)
>>                                  AMD_CG_STATE_GATE);
>>       }
>>   -    if (RREG32(mmUVD_STATUS) != 0)
>> -        uvd_v3_1_stop(adev);
>> -
>> -    return 0;
>> -}
>> -
>> -static int uvd_v3_1_suspend(void *handle)
>> -{
>> -    int r;
>> -    struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>> -
>>       r = uvd_v3_1_hw_fini(adev);
>
> "cosmetic change" comment - hw_fini is supposed to be the final tear 
> down call. So instead of suspend calling hw_fini, perhaps it makes 
> sense to read the other way - hw_fini just suspends the hardware?
>
> Thanks,
> Lijo


Not sure what you mean ?

Andrey


>
>>       if (r)
>>           return r;
>> diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c 
>> b/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c
>> index 52d6de969f46..c108b8381795 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c
>> @@ -212,6 +212,19 @@ static int uvd_v4_2_hw_fini(void *handle)
>>   {
>>       struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>>   +    cancel_delayed_work_sync(&adev->uvd.idle_work);
>> +
>> +    if (RREG32(mmUVD_STATUS) != 0)
>> +        uvd_v4_2_stop(adev);
>> +
>> +    return 0;
>> +}
>> +
>> +static int uvd_v4_2_suspend(void *handle)
>> +{
>> +    int r;
>> +    struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>> +
>>       /*
>>        * Proper cleanups before halting the HW engine:
>>        *   - cancel the delayed idle work
>> @@ -236,17 +249,6 @@ static int uvd_v4_2_hw_fini(void *handle)
>>                                  AMD_CG_STATE_GATE);
>>       }
>>   -    if (RREG32(mmUVD_STATUS) != 0)
>> -        uvd_v4_2_stop(adev);
>> -
>> -    return 0;
>> -}
>> -
>> -static int uvd_v4_2_suspend(void *handle)
>> -{
>> -    int r;
>> -    struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>> -
>>       r = uvd_v4_2_hw_fini(adev);
>>       if (r)
>>           return r;
>> diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c 
>> b/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c
>> index db6d06758e4d..563493d1f830 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c
>> @@ -210,6 +210,19 @@ static int uvd_v5_0_hw_fini(void *handle)
>>   {
>>       struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>>   +    cancel_delayed_work_sync(&adev->uvd.idle_work);
>> +
>> +    if (RREG32(mmUVD_STATUS) != 0)
>> +        uvd_v5_0_stop(adev);
>> +
>> +    return 0;
>> +}
>> +
>> +static int uvd_v5_0_suspend(void *handle)
>> +{
>> +    int r;
>> +    struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>> +
>>       /*
>>        * Proper cleanups before halting the HW engine:
>>        *   - cancel the delayed idle work
>> @@ -234,17 +247,6 @@ static int uvd_v5_0_hw_fini(void *handle)
>>                                  AMD_CG_STATE_GATE);
>>       }
>>   -    if (RREG32(mmUVD_STATUS) != 0)
>> -        uvd_v5_0_stop(adev);
>> -
>> -    return 0;
>> -}
>> -
>> -static int uvd_v5_0_suspend(void *handle)
>> -{
>> -    int r;
>> -    struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>> -
>>       r = uvd_v5_0_hw_fini(adev);
>>       if (r)
>>           return r;
>> diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c 
>> b/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
>> index b6e82d75561f..1fd9ca21a091 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
>> @@ -606,6 +606,23 @@ static int uvd_v7_0_hw_fini(void *handle)
>>   {
>>       struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>>   +    cancel_delayed_work_sync(&adev->uvd.idle_work);
>> +
>> +    if (!amdgpu_sriov_vf(adev))
>> +        uvd_v7_0_stop(adev);
>> +    else {
>> +        /* full access mode, so don't touch any UVD register */
>> +        DRM_DEBUG("For SRIOV client, shouldn't do anything.\n");
>> +    }
>> +
>> +    return 0;
>> +}
>> +
>> +static int uvd_v7_0_suspend(void *handle)
>> +{
>> +    int r;
>> +    struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>> +
>>       /*
>>        * Proper cleanups before halting the HW engine:
>>        *   - cancel the delayed idle work
>> @@ -630,21 +647,6 @@ static int uvd_v7_0_hw_fini(void *handle)
>>                                  AMD_CG_STATE_GATE);
>>       }
>>   -    if (!amdgpu_sriov_vf(adev))
>> -        uvd_v7_0_stop(adev);
>> -    else {
>> -        /* full access mode, so don't touch any UVD register */
>> -        DRM_DEBUG("For SRIOV client, shouldn't do anything.\n");
>> -    }
>> -
>> -    return 0;
>> -}
>> -
>> -static int uvd_v7_0_suspend(void *handle)
>> -{
>> -    int r;
>> -    struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>> -
>>       r = uvd_v7_0_hw_fini(adev);
>>       if (r)
>>           return r;
>> diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c 
>> b/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c
>> index 84e488f189f5..67eb01fef789 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c
>> @@ -481,6 +481,17 @@ static int vce_v2_0_hw_fini(void *handle)
>>   {
>>       struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>>   +    cancel_delayed_work_sync(&adev->vce.idle_work);
>> +
>> +    return 0;
>> +}
>> +
>> +static int vce_v2_0_suspend(void *handle)
>> +{
>> +    int r;
>> +    struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>> +
>> +
>>       /*
>>        * Proper cleanups before halting the HW engine:
>>        *   - cancel the delayed idle work
>> @@ -504,14 +515,6 @@ static int vce_v2_0_hw_fini(void *handle)
>>                                  AMD_CG_STATE_GATE);
>>       }
>>   -    return 0;
>> -}
>> -
>> -static int vce_v2_0_suspend(void *handle)
>> -{
>> -    int r;
>> -    struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>> -
>>       r = vce_v2_0_hw_fini(adev);
>>       if (r)
>>           return r;
>> diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c 
>> b/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
>> index 2a18c1e089fd..142e291983b4 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
>> @@ -492,6 +492,21 @@ static int vce_v3_0_hw_fini(void *handle)
>>       int r;
>>       struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>>   +    cancel_delayed_work_sync(&adev->vce.idle_work);
>> +
>> +    r = vce_v3_0_wait_for_idle(handle);
>> +    if (r)
>> +        return r;
>> +
>> +    vce_v3_0_stop(adev);
>> +    return vce_v3_0_set_clockgating_state(adev, AMD_CG_STATE_GATE);
>> +}
>> +
>> +static int vce_v3_0_suspend(void *handle)
>> +{
>> +    int r;
>> +    struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>> +
>>       /*
>>        * Proper cleanups before halting the HW engine:
>>        *   - cancel the delayed idle work
>> @@ -515,19 +530,6 @@ static int vce_v3_0_hw_fini(void *handle)
>>                                  AMD_CG_STATE_GATE);
>>       }
>>   -    r = vce_v3_0_wait_for_idle(handle);
>> -    if (r)
>> -        return r;
>> -
>> -    vce_v3_0_stop(adev);
>> -    return vce_v3_0_set_clockgating_state(adev, AMD_CG_STATE_GATE);
>> -}
>> -
>> -static int vce_v3_0_suspend(void *handle)
>> -{
>> -    int r;
>> -    struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>> -
>>       r = vce_v3_0_hw_fini(adev);
>>       if (r)
>>           return r;
>> diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c 
>> b/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
>> index 044cf9d74b85..226b79254db8 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
>> @@ -544,29 +544,8 @@ static int vce_v4_0_hw_fini(void *handle)
>>   {
>>       struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>>   -    /*
>> -     * Proper cleanups before halting the HW engine:
>> -     *   - cancel the delayed idle work
>> -     *   - enable powergating
>> -     *   - enable clockgating
>> -     *   - disable dpm
>> -     *
>> -     * TODO: to align with the VCN implementation, move the
>> -     * jobs for clockgating/powergating/dpm setting to
>> -     * ->set_powergating_state().
>> -     */
>>       cancel_delayed_work_sync(&adev->vce.idle_work);
>>   -    if (adev->pm.dpm_enabled) {
>> -        amdgpu_dpm_enable_vce(adev, false);
>> -    } else {
>> -        amdgpu_asic_set_vce_clocks(adev, 0, 0);
>> -        amdgpu_device_ip_set_powergating_state(adev, 
>> AMD_IP_BLOCK_TYPE_VCE,
>> -                               AMD_PG_STATE_GATE);
>> -        amdgpu_device_ip_set_clockgating_state(adev, 
>> AMD_IP_BLOCK_TYPE_VCE,
>> -                               AMD_CG_STATE_GATE);
>> -    }
>> -
>>       if (!amdgpu_sriov_vf(adev)) {
>>           /* vce_v4_0_wait_for_idle(handle); */
>>           vce_v4_0_stop(adev);
>> @@ -596,6 +575,29 @@ static int vce_v4_0_suspend(void *handle)
>>           drm_dev_exit(idx);
>>       }
>>   +    /*
>> +     * Proper cleanups before halting the HW engine:
>> +     *   - cancel the delayed idle work
>> +     *   - enable powergating
>> +     *   - enable clockgating
>> +     *   - disable dpm
>> +     *
>> +     * TODO: to align with the VCN implementation, move the
>> +     * jobs for clockgating/powergating/dpm setting to
>> +     * ->set_powergating_state().
>> +     */
>> +    cancel_delayed_work_sync(&adev->vce.idle_work);
>> +
>> +    if (adev->pm.dpm_enabled) {
>> +        amdgpu_dpm_enable_vce(adev, false);
>> +    } else {
>> +        amdgpu_asic_set_vce_clocks(adev, 0, 0);
>> +        amdgpu_device_ip_set_powergating_state(adev, 
>> AMD_IP_BLOCK_TYPE_VCE,
>> +                               AMD_PG_STATE_GATE);
>> +        amdgpu_device_ip_set_clockgating_state(adev, 
>> AMD_IP_BLOCK_TYPE_VCE,
>> +                               AMD_CG_STATE_GATE);
>> +    }
>> +
>>       r = vce_v4_0_hw_fini(adev);
>>       if (r)
>>           return r;
>>
