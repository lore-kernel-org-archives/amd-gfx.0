Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0224BC4167B
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Nov 2023 06:29:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7401310E220;
	Thu, 30 Nov 2023 06:29:41 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2078.outbound.protection.outlook.com [40.107.93.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B953010E220
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Nov 2023 06:29:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ofzT/DLlI8vSO+42MClJiS32Fb5yskLGxdkBAQRXnXXOT0FDFjMO2Ad5KBF1GHaXy65VK/GCjb+DZVAwGgCdmMIbB5EVgZqTK8/lTQ1NkLlSaUBz3UPzM3PusdU1cSri9I9ZpfEVU8pm09ovEIMWKYBc+BralbE7JbuecDMRsgseOtBUYanIq3e4XrnfjJPoHgMtwCxhIngsREbjlmXo/fFfcupfQxqnIyhItbGCRcGjpCHBrJYit8ggbBNpa1vvICY73Ai8xa3ZIM/n0yKDomUQvST3QN80VTntdxKBF/7Pk1rq0aGNL//ExPspTymkeORyytlAW9fdWNHfmuwpyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N0+IXIiIjU4kI6guMcY78H6MIOVVu+aHRBxPMRxq1Os=;
 b=Jipcwo2BAD6UbpAu5cINjXNZGXKfkewBGtoqkiTfwyKNwZTjkhWqa7wegnGUjt2JUeeudWbuf4oqVKqs1jLmCRc85g4bQz0pZDZii/OOZr54vcZ9CvK+9tpTzAQ59WbSGBlskA1b48LXQX5j43dNPSXEXLy8f8T/0zR6dmSjayBaBq5Ow44NAnMcg7d3MhTb2KlRvYWWlS9+BQpk/+Y0qzTrR12o7j64Orz3D4o03qyrIE+hejs/6M7G995nr/VPC/yxrXihOc4onET12xzXX3qudUJ9n8E/ptmc8Klna72LQ9gWX3EJV+gMNMaXhAHXMjYCt11dZ3Xoa0pcGq4GTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N0+IXIiIjU4kI6guMcY78H6MIOVVu+aHRBxPMRxq1Os=;
 b=znapGoclyPzGrm6yCofZoHorbhhQh0S48K34YMDwXBlKJ4HibCR2+HyMluvt6pJVHSg/KbTSnxP1g0zjA/OEsahUH56RualbH5WPsKie8usUNGHe0kmncfnu1lMjqqj1oj6Vk7WYcQS/KJDbXrLHhs+cemFzM4Z2i6LZzv7Po9w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6351.namprd12.prod.outlook.com (2603:10b6:8:a2::6) by
 DS7PR12MB5742.namprd12.prod.outlook.com (2603:10b6:8:71::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7046.22; Thu, 30 Nov 2023 06:29:36 +0000
Received: from DM4PR12MB6351.namprd12.prod.outlook.com
 ([fe80::8650:7935:179:f18c]) by DM4PR12MB6351.namprd12.prod.outlook.com
 ([fe80::8650:7935:179:f18c%4]) with mapi id 15.20.7046.015; Thu, 30 Nov 2023
 06:29:36 +0000
Message-ID: <42d53ace-3cfb-469a-ad10-f2a2ee8609fb@amd.com>
Date: Thu, 30 Nov 2023 14:29:27 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Add a new module param to disable d3cold
Content-Language: en-US
To: Alex Deucher <alexdeucher@gmail.com>, Ma Jun <Jun.Ma2@amd.com>
References: <20231129085156.30698-1-Jun.Ma2@amd.com>
 <CADnq5_NX1hfyq34+HkVirXxS28j69-hFdH-q9jwnfDwmdcBsLA@mail.gmail.com>
From: "Ma, Jun" <majun@amd.com>
In-Reply-To: <CADnq5_NX1hfyq34+HkVirXxS28j69-hFdH-q9jwnfDwmdcBsLA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2P153CA0016.APCP153.PROD.OUTLOOK.COM (2603:1096::26) To
 DM4PR12MB6351.namprd12.prod.outlook.com (2603:10b6:8:a2::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6351:EE_|DS7PR12MB5742:EE_
X-MS-Office365-Filtering-Correlation-Id: 8289c62f-f125-477b-cd71-08dbf16db8ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: i72uItHJHOWxoehThh/Iyp4eOukHub/j+VTiOirBN87EFoqgSRBH8yHZWDwtAPixhTMlX6ur56xVuB1s9NrJAgbG6mF98t5kRHGFnhEXAJUjpSr2L8uKnwfbLD34IoXm+fn9gXRDw8ZhRClapOzh2n4DScLWWVR4cqHGfD0701MKjB6wrGX1ihhkQFASmyZfij/IWmT6gMSiD3RPzlukn3MiRsoHL/UsZ+iA3K7bkkjm152YBKvHcbMMBrKJm3mlYKIMiQC9ugFHFUatrzHbo8d42Gi0/k5qXyEMyfspWtRL8LpOVhCdSYPwLFhg6msHiM1ibB2qB9Iv1OJwHPpixN+w/U1/cftOYspx9UEWKnNkG4mFosEtoSx1UbHk/6xGSLUg2HDUMq4C3SgJT4hxCqkNFKRgQRLw3Y95nE6DYRz/J22UdbdEQ69mnBr/AWfK0rqT6Ay1DDr/UQB6xpRo8R/HBwGmMY/hW6xOeS3LE9Vg5UlxqY8BPwnqRacUJvVgWYdNuncWmiAkDJkqaGfDBLKdo8Icj00rFRSvIKAsRPOMfyGYL43qyGkdMgZMB7YGkECAVyarNKdDRRfGBj6g6uVeNiFCjWUBskMipUvdo4P+oyD341pBm5Se88sa/XUx28kVgyDpvyj0hiDrmn9n3ua5XKK7xVyq1/Yu+11vS45mkpm5rw8A9BwI2kpnFjPdlEx0Ih2tbMazHMW7l29j0w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB6351.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(136003)(39860400002)(396003)(366004)(376002)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(478600001)(6666004)(6512007)(2616005)(26005)(2906002)(83380400001)(41300700001)(6636002)(6486002)(110136005)(53546011)(8676002)(8936002)(66946007)(5660300002)(66476007)(66556008)(316002)(6506007)(4326008)(36756003)(38100700002)(31696002)(202311291699003)(31686004)(32563001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TTFqWFBxOFZSSW1uNHdvZkF1djY5cS9nM3dyYnFnYUZUU0FSUlVWeWxwSUxP?=
 =?utf-8?B?SCtwSjhPYlpIdnJ1YlBPYWFkd003ZTY1Y1lkNnhPeElRUHBnNk91cVRCRis0?=
 =?utf-8?B?Q2Eyd2FIRUpJT3d1QkZjNHllYXM4TzJ2QWZpQnhObkJ2dW5ZaWtaUkNsaEVY?=
 =?utf-8?B?Wit2RUhrWHhlQStUcE1ZaEc3UE41NnQrUWpycDdDbityS3k3dWpkL1FaSStK?=
 =?utf-8?B?NGhkLzlzUkZCdUFueGxWNlB3RlNiZmpUaGRQN0pSSVVsUSt2dld4TjQ3Wk9n?=
 =?utf-8?B?Q2tsVVlGU2R2c3FGcTY3dnQ0UitzU3RvNVZ5OTM5WEthOTMwcU92NFZkK2Rv?=
 =?utf-8?B?aWNTYW96R2NhL0E4Zm8rWERhM0pVSGF1ajRoclUza2ZOZU80U1RBUm1iVFNp?=
 =?utf-8?B?NkxLdExyODdabjFrOVlod0FXc1BxSjlTZUNYSmJFQktNUS9YVDdwZ2lZdTFL?=
 =?utf-8?B?aFhSM2ZFTjN6MzJiNFpjQ3dvbVBpRlNNWU0zVnVMYlNPUFFrYnBMZXczSGk3?=
 =?utf-8?B?UytjNUsySTM5RGd6SW9CNUtLSUFud1FBSkwxMzNNL0JzeDE4WjF4eVJ2Ty80?=
 =?utf-8?B?RnNSSUJqYzUwbWhuQk83UkllSEZoTnpkdGt4Q2IvY0hCdUZyMUFiS0dYRTZx?=
 =?utf-8?B?RUNwbC92V1orUkVtL2ZnWnhMYkNRMVB2VUlaWU92NExZNVFaRi9STHdHT0E5?=
 =?utf-8?B?WmxueFZEazloT0k1dEdjOElMTExGMXErcW9oUGZMNG1oZkppcllzOFpBSXQw?=
 =?utf-8?B?dit4QVpJSVJnN2s1WlpIVlhuZzZaQWREbXA0Z0VQT3hsUlFKYXJGbTlleFVK?=
 =?utf-8?B?bEF1U3V6UElCRjNBOGhYOW9RWGcramlaVHZaZnJpK29WSVpBWEIwZlVmQ1A4?=
 =?utf-8?B?YlJQQVlWYnRBZjdVU2NKSGdkYkY1UHIxQU5pdU9IYzhNZ1VNeXBGZVdNNHlB?=
 =?utf-8?B?aTg0UW1CTTU2VTlCTmlxcGRybFZVcC9BSzRyMW00UGlubDNCaVBWN3FXWmpy?=
 =?utf-8?B?OGk2RVI1Tk5sYWRMSlNBUnJyc2lLZnBLOElRNmsrSnJYZGY5VE85UlJFRVRu?=
 =?utf-8?B?VUlvQllNZUJ3bUd2Ty9mZXJoS3NFS1dIa3VsUzZ5TXlDU1hIS01udmY1alpn?=
 =?utf-8?B?VXBueWRRejN4OUJtT3Y5eE5Wc3M4Tklham1vWGt5Ukk5NDFwVW5reTh4Vmhm?=
 =?utf-8?B?d1E2S2VNZG9GUVVRZnhEVXB3RENvVG94TFowZTVYdkJ1dEVmbWk0ZkMrV2wx?=
 =?utf-8?B?a1BvR201NzFON01pMm9HOGpzUUxyUC9ldkkydzhweFo5cjlGRXVDMitoU0p1?=
 =?utf-8?B?NENraThSL01wU1BIZk5RM1pxeUQyY09jOTlJMDV4QnIvMFhIYS9zV3RpaUpn?=
 =?utf-8?B?YzN2R0VkemEyN2g1YnlQakY5VnpSK0FiWkRzeGExT3FKSzNsR2pxNVhuM2ln?=
 =?utf-8?B?TlBiWGN5Qmp3aFVONDZEYi80aEQyZHpzTWpFTlAxNGhTemtnMzNHRUFVQUVV?=
 =?utf-8?B?WnJWcXhCSEZ4UmV4ZDJmM3BnYUdlemhEakFES09jSm1DbFZyZk0wYm5WemhO?=
 =?utf-8?B?cy9sWjQzazlZc2FTK2NjYSt4WjJyVlBMeUZPOFU5UytBNGw4Y3liTFBKVks3?=
 =?utf-8?B?K2xjN3JQQXVsa1N1MjE2SDZLaVYzd1B1TmFkNnluZWZmNDBJVjJHcEFaR1l0?=
 =?utf-8?B?cG82YnJ2MXhFZVdUOHF2Szk5VzR2Zm1EenRMNzBidjNRSFZINkpuSjJOSExr?=
 =?utf-8?B?K0dKWjdxTlZoTkRQMVZzQ2ZvNWhwak5xd3gvWDBLV2xwNFRXRlo4L2cwRHNq?=
 =?utf-8?B?TlpDSlhIVFpCRzl4QWZnVjM0cGRyMzArZGltc29YbVV5UHNlam9ETkpyTDd6?=
 =?utf-8?B?TFZpcWs3TDFVTk5iWEh6ZUhnbUtyVW41MTBFV3Zuc0JGeU1XUFROV29EV3ZG?=
 =?utf-8?B?UDZoWFlCYWUvZzdIdFFpT1p0b2Z3Q0FoYUZPc3FPMVFCczhxNk9nUFJpVDJG?=
 =?utf-8?B?ZmY1dEFxT01qcjk1VGFUR3VvNkF4QmJhNmRJMHFQZG9QZFdIWU81NGUycWhM?=
 =?utf-8?B?MVpydHI1VHlibDdtZFJUa0d3ZCtNSG8vTFhvOWowRHhjeE9XUEFHR0JJZUJV?=
 =?utf-8?Q?klQhUW46YkSRHERL7F5PF1xfR?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8289c62f-f125-477b-cd71-08dbf16db8ed
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6351.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2023 06:29:36.2578 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Sr/UIzmw/NXhHJhImXN27OYA/1KS0OPHxwdCoZXubPZ3y7uAGWoE5pTKIdCt/30k
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5742
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
Cc: kevinyang.wang@amd.com, amd-gfx@lists.freedesktop.org,
 mario.limonciello@amd.com, Alexander.Deucher@amd.com, Kenneth.Feng@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi Alex,

On 11/30/2023 12:39 AM, Alex Deucher wrote:
> On Wed, Nov 29, 2023 at 11:37 AM Ma Jun <Jun.Ma2@amd.com> wrote:
>>
>> Some platforms can't resume from d3cold state, So add a
>> new module parameter to disable d3cold state for debugging
>> purpose or workaround.
> 
> Doesn't the runpm parameter already handle this?  If you set runpm=0,
> that should disable d3cold.
> 
runpm=0  prevents calls to driver runtime_suspend/resume functions.
While d3cold=0 allows calls to runtime_suspend/resume functions and puts
the device in d3hot state instead of d3cold.

Regards,
Ma Jun

> Alex
> 
>>
>> Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
>> ---
>>  drivers/gpu/drm/amd/amdgpu/amdgpu.h        | 1 +
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 7 +++++++
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    | 8 ++++++++
>>  3 files changed, 16 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> index a9f54df9d33e..db9f60790267 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> @@ -166,6 +166,7 @@ extern char amdgpu_lockup_timeout[AMDGPU_MAX_TIMEOUT_PARAM_LENGTH];
>>  extern int amdgpu_dpm;
>>  extern int amdgpu_fw_load_type;
>>  extern int amdgpu_aspm;
>> +extern int amdgpu_d3cold;
>>  extern int amdgpu_runtime_pm;
>>  extern uint amdgpu_ip_block_mask;
>>  extern int amdgpu_bapm;
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> index 22b6a910b7f2..90501c44e7d0 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> @@ -264,6 +264,13 @@ bool amdgpu_device_supports_px(struct drm_device *dev)
>>  bool amdgpu_device_supports_boco(struct drm_device *dev)
>>  {
>>         struct amdgpu_device *adev = drm_to_adev(dev);
>> +       struct pci_dev *parent;
>> +
>> +       if (!amdgpu_d3cold) {
>> +               parent = pcie_find_root_port(adev->pdev);
>> +               pci_d3cold_disable(parent);
>> +               return false;
>> +       }
>>
>>         if (adev->has_pr3 ||
>>             ((adev->flags & AMD_IS_PX) && amdgpu_is_atpx_hybrid()))
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> index 5f14f04cb553..c9fbb8bd4169 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> @@ -145,6 +145,7 @@ char amdgpu_lockup_timeout[AMDGPU_MAX_TIMEOUT_PARAM_LENGTH];
>>  int amdgpu_dpm = -1;
>>  int amdgpu_fw_load_type = -1;
>>  int amdgpu_aspm = -1;
>> +int amdgpu_d3cold = -1;
>>  int amdgpu_runtime_pm = -1;
>>  uint amdgpu_ip_block_mask = 0xffffffff;
>>  int amdgpu_bapm = -1;
>> @@ -359,6 +360,13 @@ module_param_named(fw_load_type, amdgpu_fw_load_type, int, 0444);
>>  MODULE_PARM_DESC(aspm, "ASPM support (1 = enable, 0 = disable, -1 = auto)");
>>  module_param_named(aspm, amdgpu_aspm, int, 0444);
>>
>> +/**
>> + * DOC: d3cold (int)
>> + * To disable d3cold (1 = enable, 0 = disable). The default is -1 (auto, enabled).
>> + */
>> +MODULE_PARM_DESC(d3cold, "d3cold support (1 = enable, 0 = disable, -1 = auto)");
>> +module_param_named(d3cold, amdgpu_d3cold, int, 0444);
>> +
>>  /**
>>   * DOC: runpm (int)
>>   * Override for runtime power management control for dGPUs. The amdgpu driver can dynamically power down
>> --
>> 2.34.1
>>
