Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC723CD4F5B
	for <amd-gfx@archiver.kernel.org>; Tue, 19 May 2026 23:17:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1511010E12B;
	Tue, 19 May 2026 23:17:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Vc7TYogK";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012061.outbound.protection.outlook.com [52.101.43.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0616210E013
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 May 2026 23:17:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ebg8dXNNDRKaothPnTrlnpUA+uR8YO5/VmL0gG9w8u+3W0+XYOGXuCNB6ln4uRuetYKMQnk9gPyEXg2lQYtMITCAmhmjGvF+rgSsPR3GOOFxgp2acKwb8a3IMHOQjnbD/Qjd35Jz6e58xk0yTfZYnY2i3lLY9qX1zekjXQdoZs2TzlB2U9xglJ3fGAywLK0e+mzgmvKw4WNG8/yWNEAZtwRnWfTa8xC2t96g5zS7JQpVZ/p4D0nZBfDGXIhNctOmNNQKI+Ahx+LE+vaqV6mlFrCD+9l1AMfesKwUIjANFl8ZjA47eBRnqbyF1+mlX5IV+ngH6P/tXjLW5YZgHdG0+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YweA8jb2B22wJtchFxw3DuyttXKk0jrx+ibjIuJzOO8=;
 b=gKkGwrTrxPwdDktFoo6byHhzIVagmP2PHgFRT+r92akMs1i/dlMWi8p45oTjpPq1E17Y4FD3kXtNkcE8pYSZSdMRHzdiHlWpBAGbF4bg/lpe4ctlNC4EMZtWxr7Vfi0nxxYmTCwGIgunJg+HoyMaix8q0pCzWSRVWdjE3jyxp6kN86g2t5GAKMhhc0ul8mgOqeUvnFRylf3vNIpOhBqy4nAqSH83Y0z0ndEt+61Y5fjXjkCrwf0NOuj4w/yVbYaLt4hqVp6t2LzfEGfWqjicd2jwDadsqqH1PMW8ddcChiOk1dlrP446JhM5xeDyqjREiC/g7083HInKAceQ4fUKtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YweA8jb2B22wJtchFxw3DuyttXKk0jrx+ibjIuJzOO8=;
 b=Vc7TYogKMvzxQBevlBAeB1EAF02A6Da426C2eweEbyuhlab026g2d1ciYF5e2+SEcW0ar+/Fv4USPlEiz4ENZsbHzZP+8KfLLry6uHngg9Rr3ijFbPUsx9+1DEfI88gHb124JHkyK8/2F4sY6yqMn/q7uY4BlusiPWO8Oe16C0Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS4PR12MB9612.namprd12.prod.outlook.com (2603:10b6:8:278::5) by
 DS0PR12MB7679.namprd12.prod.outlook.com (2603:10b6:8:134::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.14; Tue, 19 May 2026 23:17:15 +0000
Received: from DS4PR12MB9612.namprd12.prod.outlook.com
 ([fe80::5e55:25ea:365c:f99c]) by DS4PR12MB9612.namprd12.prod.outlook.com
 ([fe80::5e55:25ea:365c:f99c%5]) with mapi id 15.21.0025.020; Tue, 19 May 2026
 23:17:15 +0000
Message-ID: <838b2839-0d53-44f5-838c-1e96ad757385@amd.com>
Date: Tue, 19 May 2026 19:17:13 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdgpu: add ioctl to handle RAS poison error
To: Alex Deucher <alexdeucher@gmail.com>, Yifan Zhang <yifan1.zhang@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com,
 christian.koenig@amd.com, David.YatSin@amd.com, Kent.Russell@amd.com,
 Perry.Yuan@amd.com
References: <20260515132702.1494187-1-yifan1.zhang@amd.com>
 <CADnq5_Ntk=4aG9+Y5RsH-oeAcHUDCamS9i4+nY5eDr1NW88n0w@mail.gmail.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <CADnq5_Ntk=4aG9+Y5RsH-oeAcHUDCamS9i4+nY5eDr1NW88n0w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0114.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d7::19) To DS4PR12MB9612.namprd12.prod.outlook.com
 (2603:10b6:8:278::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PR12MB9612:EE_|DS0PR12MB7679:EE_
X-MS-Office365-Filtering-Correlation-Id: b940ec0a-b556-424f-b3e4-08deb5fcc37f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|4143699003|22082099003|18002099003|56012099003|3023799007|11063799006|5023799004;
X-Microsoft-Antispam-Message-Info: uXEa9C4Z58K3UMOPGMt2wbxoHXL82toNC3rvbiey+R1uQzhWUzGQWM1iUO48e8PNEHYOtSeQ870z0O60scCqRiBAYnRJvfJZjJGeijk98Y17vZm0Bud+A1FLB9hzP7ypXj39cXS9zdxAorIIz3YieW6jlBCwLGwzGFeApku1eC3B2Am9RJr+1d5ipvwfTGvksfAIpYTnUAAIQxEb0dk4q9lkL5U6DGUhc+GncqbpFwnhkMdRHOEhryMGJXPJWikTj3A8e8IouEvFPhFc+7L5JzM+fCl893HGSQb6+HIiwh8EaYxAtnRe0cWWAWoT7UyVy/VRhGnkC5KCELno9jfMwMcTviO600Y/B9wnZVzdgXZ4OLDc3c9uymdKwNNYdKVseMLlLumoVNablin+RaE1TpNMwoLTxYKEoJUdeZqB4tq+GqfpJaiKtTWgnODdCYSQBwBpSNcqupMtLGL3uSc1hOIIEW0qriwEqP+SSz5vBzVSCbVS7Zg3Dk6Nlvo62Liqti2KU6siAwf6286wQopJF7KUeuAG+r42i+4WjTfQMOSfB/uI1PKu9zoE/nnc7+tuQofC8ltP6oHx36L0CcM76iGqKdPKaZpbQxqf0BBo3vOtPVZrFvBTpBvYnBYGXyDfHRz7mtl3PmLVodeyZtiXmUJmt9tKKt5xHuP2A7fOD7RRBjKdyk1u/Lbjra0L62IqwCVFYMsNxsi2olcCj8hGKA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS4PR12MB9612.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(4143699003)(22082099003)(18002099003)(56012099003)(3023799007)(11063799006)(5023799004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Umhyb1owYnJmVEZUZ1NpVmd0U0hqRHhlOHBHT1VCeTRsRFRGbFNuVkhIeVRK?=
 =?utf-8?B?MkVWU3FlR01XbGEyTnQ4bWJIUExwcndSWUxEbWJjVjdTeHFOMkVKcVUvRnNl?=
 =?utf-8?B?THIweGMxeGtiZHZhMFgzUGpMYXl0V0ZpZDh3OFZ6ZC95R2FRSUNsNVM3WWtz?=
 =?utf-8?B?cjhrZUNDS0dRUHJJQUQxc3J4UW1JbTA1ZnVoQ2RhVDQzYU5xRnB6U2wrbHh4?=
 =?utf-8?B?LzE2Wi8wVzl0V2dYUllvRlUwN2xSTVRZTmc5a1pyRGpkTGV0bmZPRUZFeUxB?=
 =?utf-8?B?YU90MDdlaUlMN1dGODlTQmh4RTgzdFBWQ2ZEbWs3eUZ1Z0hSNUQvYm5hT01l?=
 =?utf-8?B?Q3lKTEpiUGM1d3dFeVlCRW16bndBOHZjNGp6NEZybzJRb2RxcFQ0SFdsRkQ0?=
 =?utf-8?B?NFhqbTNxSnJ4dGkvTU5tVWZSeFVNaTE0a0FxRzJsaTdON2VuN2c0eWpsa2Nw?=
 =?utf-8?B?VlFEWGNjZk5lK1lpMXl5OU9qcFFtUERLTmZnejdJSDZTbzFtYVBhOFk0eE5V?=
 =?utf-8?B?ZDR3bzVTSlI4eWlrNWt6WDczVFloNDJkR3dzZFhBZURyRUQwQ1FIZStjbnk5?=
 =?utf-8?B?VTlJclZwNzBFQ2gwdUFtTFNQbWhreXRXMmtTZDIyOWhyMXpBaTdwb2ZzTVpn?=
 =?utf-8?B?a0lFRXpUWWY3MGpYckpoZFlvWFhqVDdmaVBFL2hLQmJ3TUExdElFOUNET2hW?=
 =?utf-8?B?RXlQaXgxL09pU2k1cm1XdkFnRSsvR0lEUWl3QXlKMVBXQTRJSVR4bVdjemdh?=
 =?utf-8?B?YS8yQ3g3aTRrTWpkdnhRRkdtV2JrQlRSMkVBSDUxa3ZkQXltOEtsY013VFV5?=
 =?utf-8?B?YkxneElmMTdsN3J3WUFUZUFkMjgyL1h2bUFEdy85S1d4blJ3YkVHak0wQWp1?=
 =?utf-8?B?NkJWZ3VCcDNsNmIySmNuWDErWnd0U0RUNkJKeStzQ21BSkxXeUQ1WmVQT2tm?=
 =?utf-8?B?akpkWGR6M2s5cWxqaWs3cFBTN3d6cGFsRzR4OTZjdjA4bndYUlQ3M1FscXZh?=
 =?utf-8?B?WnptWHdqT2ZIaGlDTkFVbUFzV3llZGtaWnN6ZThVL2V0clBRZy91RDhRUmE3?=
 =?utf-8?B?OURaRDhKT3RjanVDY1gyVzdlNVB2Y1VrR0ZVTXlrTHR6U0xMcmUwTm93REpa?=
 =?utf-8?B?czRyMjFCeFQvN0x3K2hTRkUrNHpQT05Zc1Z4RUUxU0JIZEhhcTYzcEtZQkcv?=
 =?utf-8?B?OTNGOUlQdVJsc0xaYWRRWWM3RHdMUS9xZE5WajIyZnltRHNWRHhicVhYNm9J?=
 =?utf-8?B?T2pnMWpFdUJKZDgwdE45UGh2RkFZMFBCRkorY1BFdFNjWDYzbzFsNk01QXNK?=
 =?utf-8?B?UW9LRUQrZmhuVDU4ZDhwNFlhSGc0dUpDWmVVcGRrZFJZeHZUWGZ4blJEaVQ0?=
 =?utf-8?B?TlM2VW1FMlgzUkFjTkpxZTRXN0ppRHNnTzFidTNKK0x6NHcyVGxScFhwZ1Jt?=
 =?utf-8?B?aWR0T2d3ZVl3eDlUVGk1VzUweDNGcWlWSkdFei9mNWcxMGFLMVV5ZnNtZ2dl?=
 =?utf-8?B?RWpVb0VSNXZ0dW5sL2doYWRZdUNvQTgwTDhTVXQ5RE9VVlp4Rk0yV1hhVWc4?=
 =?utf-8?B?cVFKMDl0UTBsTEl2NVhOUEt1SXdIbW16Z3B3WGRDOHVtaW42aEhTSzlFWFpK?=
 =?utf-8?B?Rm9hOWFXVWRuQ2NYRWtHYUkwNXFCSkFsaWw5alZmaXBHMHhZMCtvSU5iZjNi?=
 =?utf-8?B?V1lFZUxJcjUzOHpQdDJNVExrWGducHB6YXdUOUdiS09JUDFSUjF2YzI1c3Q4?=
 =?utf-8?B?SVlDWEhaY0VsRUNoWm5mQ3ovNCt0RGJkbUx2SWZEMUNtV2cvS3N6cFNZVllz?=
 =?utf-8?B?N1dqclUrQjhQNXMyem9Zdnd1ellNRjlKekdWZEFGRGdlWUxMY093NmZBWlRr?=
 =?utf-8?B?ZVJZWTZoSy9ydFNxNjBwclhXUmY0em0vSENqaHFMVWxDY1IwQ05rQm5NMFRT?=
 =?utf-8?B?VE9MdlNmQTVaT1lOZXNuVXd1eW5RcHlLYVFDNWxTb0FXTnBZR29xVjJWbUVT?=
 =?utf-8?B?MkxxbmxsZlVwc051Znd3Vkk2QXlUd1QwQWx1MFFMYzFGRSs2cXRsbjMxTk9l?=
 =?utf-8?B?VFZ3TXF3M3RjYWlZQ2h0WkhhMThOME1JSXNDNHRQdUs1dFUrTmxIMURoQ0JI?=
 =?utf-8?B?aGp2WkxKV1NPNGJLWFdKeSt3dy95ZFVFTStpZWF5bUVxZWpleEF0NVRqcXk1?=
 =?utf-8?B?bzBJajRkdmhRaDhzS3RQTG1oNDBIdE1iN285VnNWSnBDLzJieUw4SjNMdXgx?=
 =?utf-8?B?SENCTnhCN2R3YWNvQVp4REZSaUc1WVI0dng1d041ckJxbklNVGQ4NkhkOHVr?=
 =?utf-8?B?M0VTcXdUV0hHVy9yWW1mMDl4OVNjMmlUUDExam81K1ZFeUV1ZXBNdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b940ec0a-b556-424f-b3e4-08deb5fcc37f
X-MS-Exchange-CrossTenant-AuthSource: DS4PR12MB9612.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 23:17:15.1129 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Cp2a9qYqxDox4bogVeqXzlCjP5SFzTYGeQ0bNplHKzp32621B5d8XdJSEH5ESbN/7pTOvWkIrcPcWv8k/5OKyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7679
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


On 2026-05-15 14:56, Alex Deucher wrote:
> On Fri, May 15, 2026 at 9:27 AM Yifan Zhang <yifan1.zhang@amd.com> wrote:
>> Add a new DRM_IOCTL_AMDGPU_USER_OPTIONS ioctl with the
>> AMDGPU_USER_OPTIONS_OP_KFD_SIGBUS_DELAY option, allowing userspace (ROCr)
>> to control per-process SIGBUS delivery.
>>
>> Userspace for this can be found at:
>> https://github.com/ROCm/rocm-systems/pull/6148
>>
>> Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu.h     |  12 +++
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c |   1 +
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c |  29 ++++++
>>   drivers/gpu/drm/amd/amdkfd/kfd_events.c | 114 +++++++++++++++++++++++-
>>   include/uapi/drm/amdgpu_drm.h           |  25 ++++++
>>   5 files changed, 179 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> index 5d7bfa59424a..6a5459b59af2 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> @@ -455,6 +455,16 @@ struct amdgpu_fpriv {
>>
>>          /** GPU partition selection */
>>          uint32_t                xcp_id;
>> +
>> +       /**
>> +        * @kfd_sigbus_delay_ms: Per-fd KFD SIGBUS delivery option (set via
>> +        * DRM_IOCTL_AMDGPU_USER_OPTIONS / AMDGPU_USER_OPTIONS_OP_KFD_SIGBUS_DELAY).
>> +        *
>> +        *   0          - send SIGBUS immediately (default)
>> +        *   0xFFFFFFFF - suppress SIGBUS delivery
>> +        *   other      - delay SIGBUS delivery by this many milliseconds
>> +        */
>> +       atomic_t                kfd_sigbus_delay_ms;
>>   };
>>
>>   int amdgpu_file_to_fpriv(struct file *filp, struct amdgpu_fpriv **fpriv);
>> @@ -1467,6 +1477,8 @@ int amdgpu_enable_vblank_kms(struct drm_crtc *crtc);
>>   void amdgpu_disable_vblank_kms(struct drm_crtc *crtc);
>>   int amdgpu_info_ioctl(struct drm_device *dev, void *data,
>>                        struct drm_file *filp);
>> +int amdgpu_user_options_ioctl(struct drm_device *dev, void *data,
>> +                             struct drm_file *filp);
>>
>>   /*
>>    * functions used by amdgpu_encoder.c
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> index 99688391e70b..cad18bd6f8b3 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> @@ -3078,6 +3078,7 @@ const struct drm_ioctl_desc amdgpu_ioctls_kms[] = {
>>          DRM_IOCTL_DEF_DRV(AMDGPU_USERQ_SIGNAL, amdgpu_userq_signal_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
>>          DRM_IOCTL_DEF_DRV(AMDGPU_USERQ_WAIT, amdgpu_userq_wait_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
>>          DRM_IOCTL_DEF_DRV(AMDGPU_GEM_LIST_HANDLES, amdgpu_gem_list_handles_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
>> +       DRM_IOCTL_DEF_DRV(AMDGPU_USER_OPTIONS, amdgpu_user_options_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
>>   };
>>
>>   static const struct drm_driver amdgpu_kms_driver = {
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>> index 24526e92f9b8..7903587b8bbb 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>> @@ -1423,6 +1423,35 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
>>          return 0;
>>   }
>>
>> +/**
>> + * amdgpu_user_options_ioctl - set per-fd user options
>> + *
>> + * @dev: drm dev pointer
>> + * @data: pointer to struct drm_amdgpu_user_options
>> + * @filp: drm file
>> + *
>> + * Sets options stored on the per-file amdgpu_fpriv. Currently the only
>> + * supported option is %AMDGPU_USER_OPTIONS_OP_KFD_SIGBUS_DELAY which
>> + * controls how KFD delivers SIGBUS for poison/RAS events to the calling
>> + * process (immediate, suppressed, or delayed by N milliseconds).
>> + */
>> +int amdgpu_user_options_ioctl(struct drm_device *dev, void *data,
>> +                             struct drm_file *filp)
>> +{
>> +       struct amdgpu_fpriv *fpriv = filp->driver_priv;
>> +       struct drm_amdgpu_user_options *args = data;
>> +
>> +       switch (args->op) {
>> +       case AMDGPU_USER_OPTIONS_OP_KFD_SIGBUS_DELAY:
>> +               atomic_set(&fpriv->kfd_sigbus_delay_ms,
>> +                          args->kfd_sigbus_delay.value);
>> +               return 0;
>> +       default:
>> +               DRM_DEBUG_KMS("Invalid user option op %u\n", args->op);
>> +               return -EINVAL;
>> +       }
>> +}
>> +
>>   /**
>>    * amdgpu_driver_open_kms - drm callback for open
>>    *
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_events.c b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
>> index e9be798c0a2b..2ff6348105b7 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_events.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
>> @@ -29,10 +29,12 @@
>>   #include <linux/uaccess.h>
>>   #include <linux/mman.h>
>>   #include <linux/memory.h>
>> +#include <linux/workqueue.h>
>>   #include "kfd_priv.h"
>>   #include "kfd_events.h"
>>   #include "kfd_device_queue_manager.h"
>>   #include <linux/device.h>
>> +#include <uapi/drm/amdgpu_drm.h>
>>
>>   /*
>>    * Wrapper around wait_queue_entry_t
>> @@ -1337,6 +1339,115 @@ void kfd_signal_reset_event(struct kfd_node *dev)
>>          srcu_read_unlock(&kfd_processes_srcu, idx);
>>   }
>>
>> +/*
>> + * Per-process opt-in for poison-consumption SIGBUS handling.
>> + *
>> + * Default: kernel sends SIGBUS to the process immediately when poison is
>> + * consumed, in addition to delivering the KFD HW/MEMORY exception events.
>> + *
>> + * Userspace (ROCr) can opt-in per-process via the
>> + * DRM_IOCTL_AMDGPU_USER_OPTIONS / AMDGPU_USER_OPTIONS_OP_KFD_SIGBUS_DELAY
>> + * option. This lets the app's registered system-event callback handle the
>> + * RAS error first, instead of being killed by SIGBUS.
>> + *
>> + * Encoded value (set on any of the process' amdgpu render fds):
>> + *   0          - default: SIGBUS immediately (no opt-in)
>> + *   0xFFFFFFFF - opt-in, never escalate to SIGBUS
>> + *   N (other)  - opt-in, escalate to SIGBUS after N ms if app does not
>> + *                handle the error in time (safety timeout)
>> + *
>> + * Per-process scope: the option is honored if ANY of the process' amdgpu
>> + * fds has been configured. This matches the slide deck's "Per-process,
>> + * App set at init" semantics, while keeping the UAPI on amdgpu where ROCr
>> + * sets it.
>> + */
>> +struct kfd_sigbus_delayed_work {
>> +       struct delayed_work work;
>> +       struct kfd_process *p;
>> +};
>> +
>> +static void kfd_signal_sigbus_delayed_fn(struct work_struct *work)
>> +{
>> +       struct kfd_sigbus_delayed_work *dw = container_of(to_delayed_work(work),
>> +                               struct kfd_sigbus_delayed_work, work);
>> +       struct kfd_process *p = dw->p;
>> +
>> +       if (p->lead_thread)
>> +               send_sig(SIGBUS, p->lead_thread, 0);
>> +
>> +       kfd_unref_process(p);
>> +       kfree(dw);
>> +}
>> +
>> +/*
>> + * Resolve the per-process SIGBUS opt-in setting by scanning all of the
>> + * process' KFD pdds (each backed by an amdgpu render fd). Returns the
>> + * "most lenient" value across all fds, in this priority:
>> + *   DISABLED (no SIGBUS)  >  any non-zero timeout  >  0 (immediate)
>> + *
>> + * Rationale: if the app has explicitly opted in on any GPU it uses, it
>> + * wants the chance to handle the error in userspace.
>> + */
>> +static u32 kfd_get_sigbus_delay_ms(struct kfd_process *p)

If you're looking for the delay time for a specific GPU, you should also 
have a kfd_node *dev parameter.


>> +{
>> +       u32 result = 0;
>> +       int i;
>> +
>> +       for (i = 0; i < p->n_pdds; i++) {
>> +               struct kfd_process_device *pdd = p->pdds[i];
>> +               struct amdgpu_fpriv *drv_priv;
>> +               u32 v;
>> +
>> +               if (!pdd || !pdd->drm_file)
>> +                       continue;

Then compare pdd->dev == dev.


>> +               if (amdgpu_file_to_fpriv(pdd->drm_file, &drv_priv))
>> +                       continue;
>> +
>> +               v = atomic_read(&drv_priv->kfd_sigbus_delay_ms);
>> +               if (v == AMDGPU_USER_OPTIONS_KFD_SIGBUS_DELAY_DISABLED)
>> +                       return v;
>> +               if (v > result)
>> +                       result = v;
>> +       }
>> +
>> +       return result;
>> +}
>> +
>> +static void kfd_signal_sigbus_with_delay(struct kfd_node *dev,
>> +                                        struct kfd_process *p)

This function is called for a specific kfd_node.


>> +{
>> +       u32 delay_ms = kfd_get_sigbus_delay_ms(p);

But the kfd_node is not passed to kfd_get_sigbus_delay_ms here. So you 
just get a random delay time from any GPU, not the one from the correct GPU.


>> +       struct kfd_sigbus_delayed_work *dw;
>> +
>> +       if (delay_ms == AMDGPU_USER_OPTIONS_KFD_SIGBUS_DELAY_DISABLED) {
>> +               dev_info(dev->adev->dev,
>> +                        "SIGBUS suppressed for process %s(pid:%d): app opted in to handle RAS error\n",
>> +                        p->lead_thread->comm, p->lead_thread->pid);
>> +               return;
>> +       }
>> +
>> +       if (delay_ms == 0)
>> +               goto send_now;
>> +
>> +       dw = kzalloc(sizeof(*dw), GFP_ATOMIC);

You could avoid the dynamic memory allocation if the work struct were 
embedded in struct kfd_process_device.

Regards,
   Felix


>> +       if (!dw)
>> +               goto send_now;
>> +
>> +       /* Take an extra reference for the delayed worker. */
>> +       kref_get(&p->ref);
>> +       dw->p = p;
>> +       INIT_DELAYED_WORK(&dw->work, kfd_signal_sigbus_delayed_fn);
>> +
>> +       dev_info(dev->adev->dev,
>> +                "Deferring SIGBUS to process %s(pid:%d) by %u ms (RAS error opt-in safety timeout)\n",
>> +                p->lead_thread->comm, p->lead_thread->pid, delay_ms);
>> +       schedule_delayed_work(&dw->work, msecs_to_jiffies(delay_ms));
>> +       return;
>> +
>> +send_now:
>> +       send_sig(SIGBUS, p->lead_thread, 0);
>> +}
>> +
>>   void kfd_signal_poison_consumed_event(struct kfd_node *dev, u32 pasid)
>>   {
>>          struct kfd_process *p = kfd_lookup_process_by_pasid(pasid, NULL);
>> @@ -1345,7 +1456,6 @@ void kfd_signal_poison_consumed_event(struct kfd_node *dev, u32 pasid)
>>          struct kfd_event *ev;
>>          uint32_t id = KFD_FIRST_NONSIGNAL_EVENT_ID;
>>          int user_gpu_id;
>> -
>>          if (!p) {
>>                  dev_warn(dev->adev->dev, "Not find process with pasid:%d\n", pasid);
>>                  return; /* Presumably process exited. */
>> @@ -1391,7 +1501,7 @@ void kfd_signal_poison_consumed_event(struct kfd_node *dev, u32 pasid)
>>          rcu_read_unlock();
>>
>>          /* user application will handle SIGBUS signal */
>> -       send_sig(SIGBUS, p->lead_thread, 0);
>> +       kfd_signal_sigbus_with_delay(dev, p);
>>
>>          kfd_unref_process(p);
>>   }
>> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
>> index 9f3090db2f16..dfc91d25c80d 100644
>> --- a/include/uapi/drm/amdgpu_drm.h
>> +++ b/include/uapi/drm/amdgpu_drm.h
>> @@ -58,6 +58,7 @@ extern "C" {
>>   #define DRM_AMDGPU_USERQ_SIGNAL                0x17
>>   #define DRM_AMDGPU_USERQ_WAIT          0x18
>>   #define DRM_AMDGPU_GEM_LIST_HANDLES    0x19
>> +#define DRM_AMDGPU_USER_OPTIONS                0x1A
>>
>>   #define DRM_IOCTL_AMDGPU_GEM_CREATE    DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_CREATE, union drm_amdgpu_gem_create)
>>   #define DRM_IOCTL_AMDGPU_GEM_MMAP      DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_MMAP, union drm_amdgpu_gem_mmap)
>> @@ -79,6 +80,7 @@ extern "C" {
>>   #define DRM_IOCTL_AMDGPU_USERQ_SIGNAL  DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_USERQ_SIGNAL, struct drm_amdgpu_userq_signal)
>>   #define DRM_IOCTL_AMDGPU_USERQ_WAIT    DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_USERQ_WAIT, struct drm_amdgpu_userq_wait)
>>   #define DRM_IOCTL_AMDGPU_GEM_LIST_HANDLES DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_LIST_HANDLES, struct drm_amdgpu_gem_list_handles)
>> +#define DRM_IOCTL_AMDGPU_USER_OPTIONS  DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_USER_OPTIONS, struct drm_amdgpu_user_options)
>>
>>   /**
>>    * DOC: memory domains
>> @@ -1673,6 +1675,29 @@ struct drm_amdgpu_info_uq_metadata {
>>   #define AMDGPU_FAMILY_GC_11_5_4                        154 /* GC 11.5.4 */
>>   #define AMDGPU_FAMILY_GC_12_0_0                        152 /* GC 12.0.0 */
>>
>> +/*
>> + * Definition of user options
>> + *
>> + * option: AMDGPU_USER_OPTIONS_OP_KFD_SIGBUS_DELAY
>> + *    0:          Disable sigbus delay - SIGBUS will be raised immediately
>> + *    0xFFFFFFFF: SIGBUS will not be raised
>> + *    other:      Set the sigbus delay in milliseconds
>> + */
>> +#define AMDGPU_USER_OPTIONS_OP_KFD_SIGBUS_DELAY                0
>> +
>> +#define AMDGPU_USER_OPTIONS_KFD_SIGBUS_DELAY_DISABLED  0xFFFFFFFFu
> AMDGPU_USER_OPTIONS_KFD_SIGBUS_DELAY_DISABLED should be 0xFFFFu
>
>> +
>> +struct drm_amdgpu_user_options {
>> +       __u32 op;
>> +       union {
>> +               struct {
>> +                       __u16 value;
>> +                       __u16 _pad;
>> +               } kfd_sigbus_delay;
>> +               __u32 _pad;
> You can drop the __u32 _pad here.  the op and value and u16 _pad are
> already aligned to 64 bits.
>
> Alex
>
>> +       };
>> +};
>> +
>>   #if defined(__cplusplus)
>>   }
>>   #endif
>> --
>> 2.43.0
>>
