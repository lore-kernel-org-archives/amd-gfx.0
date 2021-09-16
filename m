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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72BF5C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Sep 2021 16:17:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E2A361288
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Sep 2021 16:17:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2E2A361288
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BAAC96EE2C;
	Thu, 16 Sep 2021 16:17:48 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2088.outbound.protection.outlook.com [40.107.223.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 646A96EE2C
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Sep 2021 16:17:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jQy2282Khv8JnQJzZL1JNZolOoQP4g6JzbaGqYziy77sFTye/WyMDTupiAh5OxydaHmUZbmXkj2kx5EdLlbBcFLZGZShVyiDGr0W0dc/XN1dODyThNV+fLlXewbD8Efu5lVoHvQQfUkcXGeZB0dG7R0+XU2HsXR4lCJLPNW4l/Fq/08kcUTTHqjx1gQOKBRaeXI3F2NtRW0Rp4hTQBRHCxNu0rMfwPQ1Fjg6WtSIt7yVrwTAUFElOT5K9W8e6Sarv6vPMuRwrHVoYkGYXSe/TPoWRgdruXMBiEe0pAk+KeS9SINjhtnLby2G3uij0SHwnxdXpLeG0Xfd566UhAp6OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=JHlJ5M3aP9jTD6tEm5XOK8MSKgwP92pf4deFmoOi+gQ=;
 b=aW5s7YJzgJdpdz5D1kagp6LoRMonAHMHkan0XWzvzo1rtzB8jkjbnvqhCRdGwSpccjvzaZRht4S71fRAdsiIbTBaRhsyNd+hgNQhaLWgbacr3kNrvIc4eNGc7VEvcpxSk+DV4pJii4RijJZ3ypEmOGEx05fPZTdwa6JKtNHPGbSlQvrG1O0VT9jEm1X9fmPWZJz/epn2kQ8E7M+r+Wkzpw+pMSrtpsNXkLFXW5spio6RGHsZR0lqQ7CgLM9A2ZVRoUqrM694x2xyGInzqi5kYYvs7Cs1R0UHB5LhMP8U6LI3R/UGKvXKPV5e7fDvvSqVjqecFSyf1u95cm/+62zZLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JHlJ5M3aP9jTD6tEm5XOK8MSKgwP92pf4deFmoOi+gQ=;
 b=AgC8AxG6AfMmXEZxPydWVxFRyUnQFav8WJhYZ/TWb6EtpePd6q5qRQGV9rTo8QDfDOELZb8NAR4otp4GBRm6OD2tctERM7lvdmR4ZdoLpShAMaZqZIFnEj83ugqCtY169PeINY86I4UqN7IJLGVSqr/BfAN8Ki3JxRrpfXTGOew=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB4623.namprd12.prod.outlook.com (2603:10b6:805:e9::17)
 by SA0PR12MB4494.namprd12.prod.outlook.com (2603:10b6:806:94::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Thu, 16 Sep
 2021 16:17:44 +0000
Received: from SN6PR12MB4623.namprd12.prod.outlook.com
 ([fe80::c4ac:2505:5bd8:295d]) by SN6PR12MB4623.namprd12.prod.outlook.com
 ([fe80::c4ac:2505:5bd8:295d%6]) with mapi id 15.20.4500.019; Thu, 16 Sep 2021
 16:17:44 +0000
Subject: Re: [PATCH] drm/amdgpu: Fix crash on device remove/driver unload
To: "Lazar, Lijo" <lijo.lazar@amd.com>, amd-gfx@lists.freedesktop.org
Cc: evan.quan@amd.com, xinhui.pan@amd.com, alexander.deucher@amd.com
References: <20210915194153.455140-1-andrey.grodzovsky@amd.com>
 <e5f543f5-f2c3-294a-59f1-4c5ca99233ee@amd.com>
 <a0c98e67-9690-cfb2-35ef-806561d6bf44@amd.com>
 <8269157a-fc6e-37ef-63e4-9b2de79a6b05@amd.com>
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Message-ID: <45b4cd29-bed1-6243-0e9d-da6bd33c195e@amd.com>
Date: Thu, 16 Sep 2021 12:17:41 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <8269157a-fc6e-37ef-63e4-9b2de79a6b05@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: YT1PR01CA0043.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2e::12) To SN6PR12MB4623.namprd12.prod.outlook.com
 (2603:10b6:805:e9::17)
MIME-Version: 1.0
Received: from [IPv6:2607:fea8:3edf:49b0:2565:1b45:13cb:473]
 (2607:fea8:3edf:49b0:2565:1b45:13cb:473) by
 YT1PR01CA0043.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2e::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4523.14 via Frontend Transport; Thu, 16 Sep 2021 16:17:44 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bc6026ab-832b-4b9d-c842-08d9792d83fc
X-MS-TrafficTypeDiagnostic: SA0PR12MB4494:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB4494687A3902BC6D5AA41316EADC9@SA0PR12MB4494.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kNb6WHfMEiBTIGKePj26mhM9CLkgKEkdrdMUvSQ+rlz5/VhCbFVzjoXQiaxlCYGqauCExozZvfIhqFXG7g6iJ9fB1VPJkQVL6ruCkr+V1v5PNSYmK3+38SnN9xcd7Sx3fMm0blh/0d8He/W3Nrv73LjP9WNO/F/a/XXUamKwkU1do99p+PfTII9AJxf8SSmvLfPeNN9Tsgcg3a7I37iXqr/CuOck5rQWWeAT5+ksUGXlZh1T6jTiAnV+Fv8hXlE3/ofaHY2DRCOMz2cnewBPd08mGZCxbwCT4VpMPKN9ZyR2Y7ztbxXWVYJeNCTSP68cqiMNfiXxrrV+bc0kYxQbpg8Vyt/MXtye+kQr/50dPC5otYkokeOconj43HDdM4NKLSenYaDgfiaJ/Y96tv175STmt8vxI3D0tlqUEkpgq9kd4OTaSyfmb3GYbCqmxKZbxcamg83/rflL4eVXmVzcmBxnFvIoBDv8204is8cqb8nCc9ZE/zTbkAd6lHBz+VnUjYXCfaxsImrTXRY8IPnWHaGi5KEEGjlB1ou6agMxfEmiunrb6Zt0pL9cbphkvt3VJiLKeeymT80sf8D2H/1KWmWwZRv49RW0ek+UCSO/pK2BAiTzAIRkJJm4Ax2W+2mDVC1axZZ6IZEkJqLAGFsGwRzDzjtoxPb2DEbPLIkaYwjs74ppF80rR40Chwz4x4P08/z8EjplFdy+TKecPi56QfOhymC+oy7V3Gjp038WDFk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR12MB4623.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(366004)(346002)(136003)(376002)(396003)(316002)(5660300002)(38100700002)(36756003)(478600001)(31686004)(86362001)(6666004)(4326008)(83380400001)(31696002)(66946007)(6486002)(8676002)(66556008)(30864003)(53546011)(2906002)(66476007)(186003)(8936002)(44832011)(2616005)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VitLV3V2RHExRmhxb09qaHRHVTlJUVNhdURSOS9nSGFLanVBaHJqeCtHdTY1?=
 =?utf-8?B?Z2FSZEQzUUN6bUQ5RnhqUGlpSmUzaFducTFFTEVDM1M4MDBGWlB2U3JsYlh0?=
 =?utf-8?B?Q2pqZmsybHp3VDRXcnV5ZWg5Y2E5NkI1SjRWVVVhVXcyR3lxNktoay81dEFS?=
 =?utf-8?B?RytOcHQrK3pTbkpvSVliMzZtaUNBNzBWZ0kxeFpteHBmanNEQTNEbFRXWjhz?=
 =?utf-8?B?RjlGT3hpOFRiVnAweEd3ZFp0ZTBDUEd2S1ZPU29zaW1jRGswZk9EV21RSklI?=
 =?utf-8?B?UFREZEJ2Z1hhT3BGM3FIWlJmNmh3cGRwVU1MY3E1dGppVEVqa0FLakh3Zzc5?=
 =?utf-8?B?UllscG8wYk0welZwaEpLWm9wQ3JmSkxLZVFaNkJzeVVtUzB2K3ZEbEwzc0VW?=
 =?utf-8?B?eU5GQi9yZjh2akJpUGFvOVVUUVNxd2dwTHFHVVFZa24xMUZKS1pHOEt5NjlU?=
 =?utf-8?B?bWpaZmdkNDJDVFd6REFOTG1tTjg3MXpZb2NUQUdxOC9XK1lRdXRZdzJPamE3?=
 =?utf-8?B?QmVodFJRbTE0aWh0SG5CUXlQbnJOZmlTbCt6Tjlpai9EQmVXN0txQkJOQTVk?=
 =?utf-8?B?clRUNFZ1bkNXNWY4NkxwajcyNDB4TDloSXhaVENZZXZ5b0xMalRyN3BMUjcv?=
 =?utf-8?B?OXdOSkhYSHY1RkJ6NE9FYm1oeVdFb3Y4UExFdm9LS1UweXpFODVDMU1oeGtY?=
 =?utf-8?B?d01zWHFNcUEraUdHendKQng4a2I5ZkhDV0tMWUZEZ1loVDNTc2NlOVpGOTF3?=
 =?utf-8?B?M2h2M1RLV0VPT0dpc0VVdHZkTDdYT3M3K2xPUzQvQmxuV2k2aFU0eHRxc1NU?=
 =?utf-8?B?c1pFSjNCWFltREE5Q0o2V3VjQmY1dTI3Q3R4M2k2Z1M0K3lnMXppN0tTeWRY?=
 =?utf-8?B?c3hxamxYZXlKaWxQbXNpdDVCYmtQeldROUlhc0g1VUl4cVdORmt6MnBSbjJy?=
 =?utf-8?B?R2FueStjMURKT2NFdXdxY0RvMFM5d1FLclFzQWpoUW0zSVhwL2JobXB6cXpX?=
 =?utf-8?B?d2M3WEN2Y0kzRVlqWVhBS1NSbTczL3d4ZkZqMi9zTjJEOVFrZ0ZGNGhCQlVB?=
 =?utf-8?B?c1NnZmdqQkFidjByOGFBZmlhVUNFNHJreUQ0UndmYzZOTmczVXFoZnRDS1Fa?=
 =?utf-8?B?bGxKcjNoOUF4bjRyYVB6dmpud25lbmJsMmI0Y1RrUUhaTlBTWDJzbzNsVm9G?=
 =?utf-8?B?RVd6Mi9VT1pqejNDWVNvZy9uTWZPMS9DZEJHS3lkY0lxSVdURDB6UVlNZ2Jn?=
 =?utf-8?B?Mnd4TTRBS2NsK3dmK3VZT0luWE82ekMyV3ZOTUdrWEdjR0NjcGRSU3JTSGdW?=
 =?utf-8?B?UG1vbXFYWFMwVjgySk1PRjcvZVdjZTMvTExDbnEyRFZOMWFzeFRBMlVVdVV1?=
 =?utf-8?B?SThIWEovWGR5a21hMG5LQUs3bWdwVjVEckZYM294bmVudVpxaHhoTFFIU3Vk?=
 =?utf-8?B?NFNSZ292M2tMelJaVkRkSHE1U2l5aWFqWE5sZVdJUnpVRk1YOXVIWnVXRk1i?=
 =?utf-8?B?b09mTGZaVURKOENvVjdCZXg4Ty93RmtjcGtEblo3VlVpeDlRdlpva2diWFhy?=
 =?utf-8?B?cjd2NGRPcWI1N2hvRFNKMlZYVjBRTUJXd2gvNk1yRmYxN0VuNWRRRHNKUGZZ?=
 =?utf-8?B?N3hJblh6bDZzWnlieEZxcGo2dXJpdEZ3ZWdlZHhiSE1SY1pkY29xeDZDUk5O?=
 =?utf-8?B?Si9ZUU5ubk53enNLM3lKYkc4bDY2R0tOd28wRDA5QjF6N1k0a1JZTnNvYzN0?=
 =?utf-8?B?bGgyMWdkNHFPS3hqSjhLdVI4TXU3cjFhQjQ5VmkvaFpUbElzUGNycnpBL002?=
 =?utf-8?B?YnFGSWJ3d2Z3VWFsNjIvSUZxVDk0dTcwNDUwcm9vL2lFWU9XTEpBNVBHdmJL?=
 =?utf-8?Q?K+6qYebaJQKPw?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc6026ab-832b-4b9d-c842-08d9792d83fc
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB4623.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2021 16:17:44.6065 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qBh3fXOPON8HwEhp+eIGkJtQI8dNY0Lyw431LYoyjdHfHfe91o8Gl3Z7X2+6O/7L+Dxn+81fxZGBwOpiC+xjJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4494
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


On 2021-09-16 11:51 a.m., Lazar, Lijo wrote:
>
>
> On 9/16/2021 9:15 PM, Andrey Grodzovsky wrote:
>>
>> On 2021-09-16 4:20 a.m., Lazar, Lijo wrote:
>>> A minor comment below.
>>>
>>> On 9/16/2021 1:11 AM, Andrey Grodzovsky wrote:
>>>> Crash:
>>>> BUG: unable to handle page fault for address: 00000000000010e1
>>>> RIP: 0010:vega10_power_gate_vce+0x26/0x50 [amdgpu]
>>>> Call Trace:
>>>> pp_set_powergating_by_smu+0x16a/0x2b0 [amdgpu]
>>>> amdgpu_dpm_set_powergating_by_smu+0x92/0xf0 [amdgpu]
>>>> amdgpu_dpm_enable_vce+0x2e/0xc0 [amdgpu]
>>>> vce_v4_0_hw_fini+0x95/0xa0 [amdgpu]
>>>> amdgpu_device_fini_hw+0x232/0x30d [amdgpu]
>>>> amdgpu_driver_unload_kms+0x5c/0x80 [amdgpu]
>>>> amdgpu_pci_remove+0x27/0x40 [amdgpu]
>>>> pci_device_remove+0x3e/0xb0
>>>> device_release_driver_internal+0x103/0x1d0
>>>> device_release_driver+0x12/0x20
>>>> pci_stop_bus_device+0x79/0xa0
>>>> pci_stop_and_remove_bus_device_locked+0x1b/0x30
>>>> remove_store+0x7b/0x90
>>>> dev_attr_store+0x17/0x30
>>>> sysfs_kf_write+0x4b/0x60
>>>> kernfs_fop_write_iter+0x151/0x1e0
>>>>
>>>> Why:
>>>> VCE/UVD had dependency on SMC block for their suspend but
>>>> SMC block is the first to do HW fini due to some constraints
>>>>
>>>> How:
>>>> Since the original patch was dealing with suspend issues
>>>> move the SMC block dependency back into suspend hooks as
>>>> was done in V1 of the original patches.
>>>> Keep flushing idle work both in suspend and HW fini seuqnces
>>>> since it's essential in both cases.
>>>>
>>>> Fixes:
>>>> 2178d3c189b9 drm/amdgpu: add missing cleanups for more ASICs on 
>>>> UVD/VCE suspend
>>>> ee6679aaa61c drm/amdgpu: add missing cleanups for Polaris12 UVD/VCE 
>>>> on suspend
>>>> Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
>>>> ---
>>>>   drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c | 24 ++++++++-------
>>>>   drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c | 24 ++++++++-------
>>>>   drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c | 24 ++++++++-------
>>>>   drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c | 32 ++++++++++---------
>>>>   drivers/gpu/drm/amd/amdgpu/vce_v2_0.c | 19 +++++++-----
>>>>   drivers/gpu/drm/amd/amdgpu/vce_v3_0.c | 28 +++++++++--------
>>>>   drivers/gpu/drm/amd/amdgpu/vce_v4_0.c | 44 
>>>> ++++++++++++++-------------
>>>>   7 files changed, 105 insertions(+), 90 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c 
>>>> b/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c
>>>> index 7232241e3bfb..0fef925b6602 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c
>>>> @@ -698,6 +698,19 @@ static int uvd_v3_1_hw_fini(void *handle)
>>>>   {
>>>>       struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>>>>   + cancel_delayed_work_sync(&adev->uvd.idle_work);
>>>> +
>>>> +    if (RREG32(mmUVD_STATUS) != 0)
>>>> +        uvd_v3_1_stop(adev);
>>>> +
>>>> +    return 0;
>>>> +}
>>>> +
>>>> +static int uvd_v3_1_suspend(void *handle)
>>>> +{
>>>> +    int r;
>>>> +    struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>>>> +
>>>>       /*
>>>>        * Proper cleanups before halting the HW engine:
>>>>        *   - cancel the delayed idle work
>>>> @@ -722,17 +735,6 @@ static int uvd_v3_1_hw_fini(void *handle)
>>>>                                  AMD_CG_STATE_GATE);
>>>>       }
>>>>   -    if (RREG32(mmUVD_STATUS) != 0)
>>>> -        uvd_v3_1_stop(adev);
>>>> -
>>>> -    return 0;
>>>> -}
>>>> -
>>>> -static int uvd_v3_1_suspend(void *handle)
>>>> -{
>>>> -    int r;
>>>> -    struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>>>> -
>>>>       r = uvd_v3_1_hw_fini(adev);
>>>
>>> "cosmetic change" comment - hw_fini is supposed to be the final tear 
>>> down call. So instead of suspend calling hw_fini, perhaps it makes 
>>> sense to read the other way - hw_fini just suspends the hardware?
>>>
>>> Thanks,
>>> Lijo
>>
>>
>> Not sure what you mean ?
>
> Now it is - suspend()-> calls hw_fini()
>
> What I meant is hw_fini() -> calls suspend() and that is read as "to 
> do hw_fini() only suspend the hardware and nothing extra is needed".
>
> In short implementation stays in suspend() and hw_fini() calls suspend().


Sorry, still confused, what about amdgpu_vce_suspend being called from 
vce_v4_0_suspend for example - we don't want that to be called from hw_fini.
Can you maybe show draft change of what you mean for one specific UVD or 
VCE version ?

Andrey


>
> Thanks,
> Lijo
>
>>
>> Andrey
>>
>>
>>>
>>>>       if (r)
>>>>           return r;
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c 
>>>> b/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c
>>>> index 52d6de969f46..c108b8381795 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c
>>>> @@ -212,6 +212,19 @@ static int uvd_v4_2_hw_fini(void *handle)
>>>>   {
>>>>       struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>>>>   + cancel_delayed_work_sync(&adev->uvd.idle_work);
>>>> +
>>>> +    if (RREG32(mmUVD_STATUS) != 0)
>>>> +        uvd_v4_2_stop(adev);
>>>> +
>>>> +    return 0;
>>>> +}
>>>> +
>>>> +static int uvd_v4_2_suspend(void *handle)
>>>> +{
>>>> +    int r;
>>>> +    struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>>>> +
>>>>       /*
>>>>        * Proper cleanups before halting the HW engine:
>>>>        *   - cancel the delayed idle work
>>>> @@ -236,17 +249,6 @@ static int uvd_v4_2_hw_fini(void *handle)
>>>>                                  AMD_CG_STATE_GATE);
>>>>       }
>>>>   -    if (RREG32(mmUVD_STATUS) != 0)
>>>> -        uvd_v4_2_stop(adev);
>>>> -
>>>> -    return 0;
>>>> -}
>>>> -
>>>> -static int uvd_v4_2_suspend(void *handle)
>>>> -{
>>>> -    int r;
>>>> -    struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>>>> -
>>>>       r = uvd_v4_2_hw_fini(adev);
>>>>       if (r)
>>>>           return r;
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c 
>>>> b/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c
>>>> index db6d06758e4d..563493d1f830 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c
>>>> @@ -210,6 +210,19 @@ static int uvd_v5_0_hw_fini(void *handle)
>>>>   {
>>>>       struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>>>>   + cancel_delayed_work_sync(&adev->uvd.idle_work);
>>>> +
>>>> +    if (RREG32(mmUVD_STATUS) != 0)
>>>> +        uvd_v5_0_stop(adev);
>>>> +
>>>> +    return 0;
>>>> +}
>>>> +
>>>> +static int uvd_v5_0_suspend(void *handle)
>>>> +{
>>>> +    int r;
>>>> +    struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>>>> +
>>>>       /*
>>>>        * Proper cleanups before halting the HW engine:
>>>>        *   - cancel the delayed idle work
>>>> @@ -234,17 +247,6 @@ static int uvd_v5_0_hw_fini(void *handle)
>>>>                                  AMD_CG_STATE_GATE);
>>>>       }
>>>>   -    if (RREG32(mmUVD_STATUS) != 0)
>>>> -        uvd_v5_0_stop(adev);
>>>> -
>>>> -    return 0;
>>>> -}
>>>> -
>>>> -static int uvd_v5_0_suspend(void *handle)
>>>> -{
>>>> -    int r;
>>>> -    struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>>>> -
>>>>       r = uvd_v5_0_hw_fini(adev);
>>>>       if (r)
>>>>           return r;
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c 
>>>> b/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
>>>> index b6e82d75561f..1fd9ca21a091 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
>>>> @@ -606,6 +606,23 @@ static int uvd_v7_0_hw_fini(void *handle)
>>>>   {
>>>>       struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>>>>   + cancel_delayed_work_sync(&adev->uvd.idle_work);
>>>> +
>>>> +    if (!amdgpu_sriov_vf(adev))
>>>> +        uvd_v7_0_stop(adev);
>>>> +    else {
>>>> +        /* full access mode, so don't touch any UVD register */
>>>> +        DRM_DEBUG("For SRIOV client, shouldn't do anything.\n");
>>>> +    }
>>>> +
>>>> +    return 0;
>>>> +}
>>>> +
>>>> +static int uvd_v7_0_suspend(void *handle)
>>>> +{
>>>> +    int r;
>>>> +    struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>>>> +
>>>>       /*
>>>>        * Proper cleanups before halting the HW engine:
>>>>        *   - cancel the delayed idle work
>>>> @@ -630,21 +647,6 @@ static int uvd_v7_0_hw_fini(void *handle)
>>>>                                  AMD_CG_STATE_GATE);
>>>>       }
>>>>   -    if (!amdgpu_sriov_vf(adev))
>>>> -        uvd_v7_0_stop(adev);
>>>> -    else {
>>>> -        /* full access mode, so don't touch any UVD register */
>>>> -        DRM_DEBUG("For SRIOV client, shouldn't do anything.\n");
>>>> -    }
>>>> -
>>>> -    return 0;
>>>> -}
>>>> -
>>>> -static int uvd_v7_0_suspend(void *handle)
>>>> -{
>>>> -    int r;
>>>> -    struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>>>> -
>>>>       r = uvd_v7_0_hw_fini(adev);
>>>>       if (r)
>>>>           return r;
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c 
>>>> b/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c
>>>> index 84e488f189f5..67eb01fef789 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c
>>>> @@ -481,6 +481,17 @@ static int vce_v2_0_hw_fini(void *handle)
>>>>   {
>>>>       struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>>>>   + cancel_delayed_work_sync(&adev->vce.idle_work);
>>>> +
>>>> +    return 0;
>>>> +}
>>>> +
>>>> +static int vce_v2_0_suspend(void *handle)
>>>> +{
>>>> +    int r;
>>>> +    struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>>>> +
>>>> +
>>>>       /*
>>>>        * Proper cleanups before halting the HW engine:
>>>>        *   - cancel the delayed idle work
>>>> @@ -504,14 +515,6 @@ static int vce_v2_0_hw_fini(void *handle)
>>>>                                  AMD_CG_STATE_GATE);
>>>>       }
>>>>   -    return 0;
>>>> -}
>>>> -
>>>> -static int vce_v2_0_suspend(void *handle)
>>>> -{
>>>> -    int r;
>>>> -    struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>>>> -
>>>>       r = vce_v2_0_hw_fini(adev);
>>>>       if (r)
>>>>           return r;
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c 
>>>> b/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
>>>> index 2a18c1e089fd..142e291983b4 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
>>>> @@ -492,6 +492,21 @@ static int vce_v3_0_hw_fini(void *handle)
>>>>       int r;
>>>>       struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>>>>   + cancel_delayed_work_sync(&adev->vce.idle_work);
>>>> +
>>>> +    r = vce_v3_0_wait_for_idle(handle);
>>>> +    if (r)
>>>> +        return r;
>>>> +
>>>> +    vce_v3_0_stop(adev);
>>>> +    return vce_v3_0_set_clockgating_state(adev, AMD_CG_STATE_GATE);
>>>> +}
>>>> +
>>>> +static int vce_v3_0_suspend(void *handle)
>>>> +{
>>>> +    int r;
>>>> +    struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>>>> +
>>>>       /*
>>>>        * Proper cleanups before halting the HW engine:
>>>>        *   - cancel the delayed idle work
>>>> @@ -515,19 +530,6 @@ static int vce_v3_0_hw_fini(void *handle)
>>>>                                  AMD_CG_STATE_GATE);
>>>>       }
>>>>   -    r = vce_v3_0_wait_for_idle(handle);
>>>> -    if (r)
>>>> -        return r;
>>>> -
>>>> -    vce_v3_0_stop(adev);
>>>> -    return vce_v3_0_set_clockgating_state(adev, AMD_CG_STATE_GATE);
>>>> -}
>>>> -
>>>> -static int vce_v3_0_suspend(void *handle)
>>>> -{
>>>> -    int r;
>>>> -    struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>>>> -
>>>>       r = vce_v3_0_hw_fini(adev);
>>>>       if (r)
>>>>           return r;
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c 
>>>> b/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
>>>> index 044cf9d74b85..226b79254db8 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
>>>> @@ -544,29 +544,8 @@ static int vce_v4_0_hw_fini(void *handle)
>>>>   {
>>>>       struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>>>>   -    /*
>>>> -     * Proper cleanups before halting the HW engine:
>>>> -     *   - cancel the delayed idle work
>>>> -     *   - enable powergating
>>>> -     *   - enable clockgating
>>>> -     *   - disable dpm
>>>> -     *
>>>> -     * TODO: to align with the VCN implementation, move the
>>>> -     * jobs for clockgating/powergating/dpm setting to
>>>> -     * ->set_powergating_state().
>>>> -     */
>>>>       cancel_delayed_work_sync(&adev->vce.idle_work);
>>>>   -    if (adev->pm.dpm_enabled) {
>>>> -        amdgpu_dpm_enable_vce(adev, false);
>>>> -    } else {
>>>> -        amdgpu_asic_set_vce_clocks(adev, 0, 0);
>>>> -        amdgpu_device_ip_set_powergating_state(adev, 
>>>> AMD_IP_BLOCK_TYPE_VCE,
>>>> -                               AMD_PG_STATE_GATE);
>>>> -        amdgpu_device_ip_set_clockgating_state(adev, 
>>>> AMD_IP_BLOCK_TYPE_VCE,
>>>> -                               AMD_CG_STATE_GATE);
>>>> -    }
>>>> -
>>>>       if (!amdgpu_sriov_vf(adev)) {
>>>>           /* vce_v4_0_wait_for_idle(handle); */
>>>>           vce_v4_0_stop(adev);
>>>> @@ -596,6 +575,29 @@ static int vce_v4_0_suspend(void *handle)
>>>>           drm_dev_exit(idx);
>>>>       }
>>>>   +    /*
>>>> +     * Proper cleanups before halting the HW engine:
>>>> +     *   - cancel the delayed idle work
>>>> +     *   - enable powergating
>>>> +     *   - enable clockgating
>>>> +     *   - disable dpm
>>>> +     *
>>>> +     * TODO: to align with the VCN implementation, move the
>>>> +     * jobs for clockgating/powergating/dpm setting to
>>>> +     * ->set_powergating_state().
>>>> +     */
>>>> +    cancel_delayed_work_sync(&adev->vce.idle_work);
>>>> +
>>>> +    if (adev->pm.dpm_enabled) {
>>>> +        amdgpu_dpm_enable_vce(adev, false);
>>>> +    } else {
>>>> +        amdgpu_asic_set_vce_clocks(adev, 0, 0);
>>>> +        amdgpu_device_ip_set_powergating_state(adev, 
>>>> AMD_IP_BLOCK_TYPE_VCE,
>>>> +                               AMD_PG_STATE_GATE);
>>>> +        amdgpu_device_ip_set_clockgating_state(adev, 
>>>> AMD_IP_BLOCK_TYPE_VCE,
>>>> +                               AMD_CG_STATE_GATE);
>>>> +    }
>>>> +
>>>>       r = vce_v4_0_hw_fini(adev);
>>>>       if (r)
>>>>           return r;
>>>>
