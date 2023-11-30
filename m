Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9954C4167B
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Nov 2023 10:47:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0822810E222;
	Thu, 30 Nov 2023 10:47:25 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2060a.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eab::60a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7335E10E222
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Nov 2023 10:47:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B4pVxkgGzx7HuwUkpn4RgXuZOgBwSRNDkwnrBo/arqbuC10qFPLsMftHRSTXuJedkMjyzsccfviJPIDC0N2tp9/i4nnfhdj3kaVixTNIj0zSedcBMxKSpTmKZnW2GokTYrALzxdsxm58Qv8AZdJSvCBksAC141VIMY7eRpzg9vyBUQyAxafcUT4WDqgG2vgYoG7MmuzWGLCi1R+tyP7s9hbYAbpMRm6QXC4OGDIe+Fpb9th/p37Hp9ZlSxX4Yw2/hCfpJwaCrMHzLL6/fhHz5GfaI4bynkG4cYxH2S4YbjAeq7souglTRykGqEoGE1FLsJ1ocmj9LkV0qEpi9TC8rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2q0aOYNMvkNDth2qktb+B52G0gZLXHt6ejJ1h+ThJvU=;
 b=RGQRCH0A+ul/l2FP0CrSZUBNocKNGnv+O3wdELG44nVnzeDWVxDz7QJKMDH+0TDbf8YnxqR5+kYe8Zznub9K0syE3LM91y+mwRD3sZwH6IY+QMl1DLxxz5tjo5q64Iast03n1CYGsJ5suSzGDSrXkTKQy4y8i3QPlO17Ik/8KmhNix0lZUXqRbW0e77TceStkLslGDn1iNe4HJXGdZHnvIYzdheFeLkn34Icvaty/f16hFkHlPik6n+KOaMBfeDQ8+xcj4tyY/kED5x03IOnRRV1zhUpAU5xz/sfIt3SFoc0SghTvoLY1OaSZ/QEoM5pkxd+3PyhJbSsqQKFcWAhfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2q0aOYNMvkNDth2qktb+B52G0gZLXHt6ejJ1h+ThJvU=;
 b=ql44W3CGWLncSWtNTunQE/SnAT3T8PpZ0jpOKnK26yaPhTwz9a9R9aGoix9rf+yUY+K3PZQaZ7bvVwxvE/MpKLqq6a2AbQC4t/fzcuAWgzLiIJZOMPAwXGnl7NrujLM+Yo65D67qQ4iwI8BaUUX94koRUzBLaANUF17p4pSmEVQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6351.namprd12.prod.outlook.com (2603:10b6:8:a2::6) by
 MN2PR12MB4470.namprd12.prod.outlook.com (2603:10b6:208:260::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.23; Thu, 30 Nov
 2023 10:47:21 +0000
Received: from DM4PR12MB6351.namprd12.prod.outlook.com
 ([fe80::8650:7935:179:f18c]) by DM4PR12MB6351.namprd12.prod.outlook.com
 ([fe80::8650:7935:179:f18c%4]) with mapi id 15.20.7046.015; Thu, 30 Nov 2023
 10:47:21 +0000
Message-ID: <24200e4f-ec60-418b-81ee-d7adf79174a7@amd.com>
Date: Thu, 30 Nov 2023 18:47:11 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Add a new module param to disable d3cold
Content-Language: en-US
To: "Lazar, Lijo" <lijo.lazar@amd.com>, Alex Deucher <alexdeucher@gmail.com>, 
 Ma Jun <Jun.Ma2@amd.com>
References: <20231129085156.30698-1-Jun.Ma2@amd.com>
 <CADnq5_NX1hfyq34+HkVirXxS28j69-hFdH-q9jwnfDwmdcBsLA@mail.gmail.com>
 <42d53ace-3cfb-469a-ad10-f2a2ee8609fb@amd.com>
 <f03a4515-b73f-4e13-8eec-384443c75503@amd.com>
From: "Ma, Jun" <majun@amd.com>
In-Reply-To: <f03a4515-b73f-4e13-8eec-384443c75503@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR01CA0015.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::15) To DM4PR12MB6351.namprd12.prod.outlook.com
 (2603:10b6:8:a2::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6351:EE_|MN2PR12MB4470:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e1e4b9f-29d3-4bea-e943-08dbf191bae6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BuuQVMxFANzpszVxI5YdyIideDatFWWiyMb1BUwBGPqALJZMSdhdbDH8BIAgvQ93ognqsfEGvQcxFSkAzGxfAEF4bX+yLltPN50t1tY/y/cHTiTIIi5wHsrpl0c9w9D5xcGnvmeh/d15346sR8r9TJM8SDM92BA//qrSOwJ80KD4NcyX0/NPB2hhWZ+pPw9q4FvkaCytPWlxhFYIhIkMPDtbHV6xlbbtu54KczT1rXOYp0AJcKdTPAlAe77M66VgJXnoL4aM6r95nqTrV6A+n+fwcq58R+fJ65sS4H4M7Dnst1pzA3UOh68jVxi5+3G8w2RZq+fvlBOmyyZtz7o2SdNZGL1SEP4ZQPPXdd6khqaPcmC10x9+9QMLtCR6PdV9S/RguERU+h8LYrMtBS04AMGIlH4DVX7ZlpurD6tEuO0OEL7pOwehWqVTzkq3TW2tqGqIRTDEbsEspY4VXIzX/sFIlmBL3DnRQhRY/uZpgpVVHi/vVmuIald3/uSfUdXi+PBO4PtspyV+SFqSe0lXegDQvpElxijNoH4PLgiu2E9LiBa+K23WSY1kHZEP1hI6uVnPZNXnc8mStHlsLw6jPyAvSg7Qw+rAdPd5sNRS4ZyQk76NRXPTFAS5AoF850XaSZ0LbcpuKQMBzgBYy/hyNMD6DO+hZ3X/HvteZaE2v8Fn+/GvE3tQCpP9U056+7FIsZx9zM8pPriRAQ16a3u3BA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB6351.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(396003)(39860400002)(136003)(346002)(376002)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(31686004)(202311291699003)(478600001)(2616005)(6486002)(6666004)(53546011)(26005)(6506007)(6512007)(38100700002)(36756003)(31696002)(66556008)(5660300002)(66946007)(41300700001)(6636002)(66476007)(2906002)(83380400001)(8676002)(316002)(8936002)(4326008)(110136005)(32563001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dnMxL0x1SnJzWUtzR2lqRzhqZEc4Z0hCL1paeHZPa09RM0FQZnlDWC82QXVs?=
 =?utf-8?B?RTEwNjRSZmVwbzY0amtzekorQmFheVVXREtUN3ovOGlWZ0NieXBrbXNpblAy?=
 =?utf-8?B?YjJ4WWNHVG1rbXUxVUFCMlpFNStodENlUCs4Rk9BdURyZjZ5Y05KRk5IUjlw?=
 =?utf-8?B?cndqdU1UTkZmMmFFTkN2TDR1bGNZUUY1Wm9xK3JKREVqYXJlQmlCeEYwdmt4?=
 =?utf-8?B?Q00waFpHdURNQVBwZDBKcEpzN0I5M3hGL1Z6cGl6Z2lwV2RCdU5qRkY2ZWNo?=
 =?utf-8?B?dTlNdGtad29BT1JWdEk1d2s3bHZYbjhGaUhkRS81elFXbTkza2hxQmZ5NjZr?=
 =?utf-8?B?aCtjbUxGNnRRUHBCc09RTEpkbm43OWdMYUlWOGRvMjBYYVZPOHFYMDd6RGxr?=
 =?utf-8?B?bjIwcHlrOFBaOW9JRzZGckFHY3BsSkhQbWRUdWxhdUhMMmVBOTQ2TGJLQkhR?=
 =?utf-8?B?M3pzQ3E4SnkrQzBoenp4NjlRRGp6VmU4ZXc3NlpzT3VXMENNbldPY0ZQODlT?=
 =?utf-8?B?TWQrZ1MzZjZhT01pSll4eURGVnJkenZ6dVhqM1dqYmFJSmRCaXV4bUNxVG9t?=
 =?utf-8?B?dnhnc3RyeTg1MlkzbXFzZ1Mvckd3VTNZMVZXY2I1U1RndSsreURSSCtENXVF?=
 =?utf-8?B?Zks4RW1KNHRzTmg5NTFVWUJvaG54K1ZJNVVKY1djQjh3UlFpQ3huYXRkTkFv?=
 =?utf-8?B?NCtaUGJ1V1hmS21kdkQwMTZXOGlMRGJuU3lRZ09ncXk4SkNhMWx4SUQwMDRS?=
 =?utf-8?B?bXk1N0drdkFreTdqdC9vS3BZMUtNM1RweTh2SVpmOGczMmg0OXg1bGZMZlZm?=
 =?utf-8?B?Qy9NM2RaVkRKYzhlWERTalUyN2hOdUlTS0ZZTEcraWJyMG1PRXRLcWVsRks4?=
 =?utf-8?B?VlNqODBJVnNGU1g4eTM5NjNDWndibGxhVm5tZXVSUGVCcnBTeWpTTUw4MU9N?=
 =?utf-8?B?aDg5OC9DUktjQ1loR3Q0NlJnSGVNOHo4RHJBNU9KSWEzdVFvcmh6UXJxaUxU?=
 =?utf-8?B?eVZJSCtKeHZwbW1EVyttb2hxOXRJZFdyWStCNVlHS2tsdlAzVHA3MEhyOEFC?=
 =?utf-8?B?SUpUd0ZaVFNoT054YWJrRHFRMWxXVXhTZHFwOVE0NE5YS3R5a2xvWWo4ckgx?=
 =?utf-8?B?QUpZRzFUc3ZFK0g5VUJoZUlHTzhiUnYvbTB2ektCYUIzWlFVcWxEcXhtZHAw?=
 =?utf-8?B?UXZBQ1pwRWI1RTcvYk5UaUhqVW1iSjJIcVhIVFV4YU1HNlpGMm5sQzQ3UHN6?=
 =?utf-8?B?Sm1pdFBMcERIZUl1SlJHanY4V1VxYVQxajBTeGpad2tFRTBicDNOSlVVSEZR?=
 =?utf-8?B?VTBmb0kvWndvNXoxWFJiTE1nU3llWkxvazdLdU1icDkzeGhJK2dyNlYvTWd6?=
 =?utf-8?B?S3NQUlMzWkxzK20vS3hBcFdLQUU1cndoL2E5NTNFMGlvb0wrR2EyU09PMWxy?=
 =?utf-8?B?aGZpYk5pMnhsbVhxN1poSEhKMHcrV3I2d2d4cTJuWk43eUdrZmVPZE9CZjJl?=
 =?utf-8?B?cEdSOEc3K2p4Ui9PSUVHdjhyUnRUUUFyZXU4K2lHTzIrNUV0WjlSSTNXRDlk?=
 =?utf-8?B?VTVMOXFTOG5qNjF6emNDZ1YxU1pJajZCRTNKL2t2UE1udGEwUEh1SkVDRklp?=
 =?utf-8?B?REMxV2ptelJuWlM1UnhvVFQ5RDAwT2N6RzVFOCs2MGFDNG5ORTdoempqVGly?=
 =?utf-8?B?dkVSN0c3ZitUeUVzNmJFdXgzTXZIbVpYZE5lOXBuWWdQeXp0Mkl6QWphM3kz?=
 =?utf-8?B?RXpjSUR0Ky8vQTJhRTNiSmI1V3JCaFFmSUVDZ2djZnFDK0ZoL2kyRm5oK0pt?=
 =?utf-8?B?U1V3bWRzSmRFTy8rVDVzeWZXRjNFMjdoNHpDWWFSVjllZjdEeTVBWmEvdHIy?=
 =?utf-8?B?V25iSHJVblB2VUFiN2tBMkdTTCsrTUplTkxjRlBsZWdQT2p6MnJac0FNVy95?=
 =?utf-8?B?c3hHSWxIcjlLZDNLMkVZNHJ1RmVrUXhlbjVzWlVSRXRtYTNqeHJKRVpZdVVO?=
 =?utf-8?B?NHk0NDRQd1l3bjZxaWlvV3dtUTFCTTZPUTF6eVFacG9nMkNxVnlFNW1YRTNk?=
 =?utf-8?B?OWNJSGRzV2RrcWNzUlo3dWRRdHQ4T1l4SXQxOXpUMFR5UTFYMUpKeHBwMGhv?=
 =?utf-8?Q?NTdL7Nm8tbZQQaLrVb5knN8/A?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e1e4b9f-29d3-4bea-e943-08dbf191bae6
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6351.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2023 10:47:21.2534 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OMMk2bgYrKDJ5q5GS4JjFA7xnAQTtt+InxepjxL5ACZZlqLeE149VErIJ5hGp29S
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4470
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

Hi Lijo,

On 11/30/2023 5:18 PM, Lazar, Lijo wrote:
> 
> 
> On 11/30/2023 11:59 AM, Ma, Jun wrote:
>> Hi Alex,
>>
>> On 11/30/2023 12:39 AM, Alex Deucher wrote:
>>> On Wed, Nov 29, 2023 at 11:37 AM Ma Jun <Jun.Ma2@amd.com> wrote:
>>>>
>>>> Some platforms can't resume from d3cold state, So add a
>>>> new module parameter to disable d3cold state for debugging
>>>> purpose or workaround.
>>>
>>> Doesn't the runpm parameter already handle this?  If you set runpm=0,
>>> that should disable d3cold.
>>>
>> runpm=0  prevents calls to driver runtime_suspend/resume functions.
>> While d3cold=0 allows calls to runtime_suspend/resume functions and puts
>> the device in d3hot state instead of d3cold.
>>
> 
> Why not use the sysfs node to change "d3cold_allowed" on the device's 
> upstream bridge?
> 
It seems the same question as Mario. Please refer to my reply to his question.

Regards,
Ma Jun

> Thanks,
> Lijo
> 
>> Regards,
>> Ma Jun
>>
>>> Alex
>>>
>>>>
>>>> Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
>>>> ---
>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu.h        | 1 +
>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 7 +++++++
>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    | 8 ++++++++
>>>>   3 files changed, 16 insertions(+)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>>> index a9f54df9d33e..db9f60790267 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>>> @@ -166,6 +166,7 @@ extern char amdgpu_lockup_timeout[AMDGPU_MAX_TIMEOUT_PARAM_LENGTH];
>>>>   extern int amdgpu_dpm;
>>>>   extern int amdgpu_fw_load_type;
>>>>   extern int amdgpu_aspm;
>>>> +extern int amdgpu_d3cold;
>>>>   extern int amdgpu_runtime_pm;
>>>>   extern uint amdgpu_ip_block_mask;
>>>>   extern int amdgpu_bapm;
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>> index 22b6a910b7f2..90501c44e7d0 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>> @@ -264,6 +264,13 @@ bool amdgpu_device_supports_px(struct drm_device *dev)
>>>>   bool amdgpu_device_supports_boco(struct drm_device *dev)
>>>>   {
>>>>          struct amdgpu_device *adev = drm_to_adev(dev);
>>>> +       struct pci_dev *parent;
>>>> +
>>>> +       if (!amdgpu_d3cold) {
>>>> +               parent = pcie_find_root_port(adev->pdev);
>>>> +               pci_d3cold_disable(parent);
>>>> +               return false;
>>>> +       }
>>>>
>>>>          if (adev->has_pr3 ||
>>>>              ((adev->flags & AMD_IS_PX) && amdgpu_is_atpx_hybrid()))
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>>> index 5f14f04cb553..c9fbb8bd4169 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>>> @@ -145,6 +145,7 @@ char amdgpu_lockup_timeout[AMDGPU_MAX_TIMEOUT_PARAM_LENGTH];
>>>>   int amdgpu_dpm = -1;
>>>>   int amdgpu_fw_load_type = -1;
>>>>   int amdgpu_aspm = -1;
>>>> +int amdgpu_d3cold = -1;
>>>>   int amdgpu_runtime_pm = -1;
>>>>   uint amdgpu_ip_block_mask = 0xffffffff;
>>>>   int amdgpu_bapm = -1;
>>>> @@ -359,6 +360,13 @@ module_param_named(fw_load_type, amdgpu_fw_load_type, int, 0444);
>>>>   MODULE_PARM_DESC(aspm, "ASPM support (1 = enable, 0 = disable, -1 = auto)");
>>>>   module_param_named(aspm, amdgpu_aspm, int, 0444);
>>>>
>>>> +/**
>>>> + * DOC: d3cold (int)
>>>> + * To disable d3cold (1 = enable, 0 = disable). The default is -1 (auto, enabled).
>>>> + */
>>>> +MODULE_PARM_DESC(d3cold, "d3cold support (1 = enable, 0 = disable, -1 = auto)");
>>>> +module_param_named(d3cold, amdgpu_d3cold, int, 0444);
>>>> +
>>>>   /**
>>>>    * DOC: runpm (int)
>>>>    * Override for runtime power management control for dGPUs. The amdgpu driver can dynamically power down
>>>> --
>>>> 2.34.1
>>>>
> 
> 
