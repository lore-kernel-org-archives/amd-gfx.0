Return-Path: <SRS0=+arJ=BK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E682C433E0
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jul 2020 03:48:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4DB89208E4
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jul 2020 03:48:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="TXs6NLrE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DB89208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F36846E994;
	Fri, 31 Jul 2020 03:48:48 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2056.outbound.protection.outlook.com [40.107.220.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2B1AD6E994
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Jul 2020 03:48:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JQD9xxkJwdUMVmGj8K69G7HZWuxXIQze+pjhkRnevi6JEo0hQ6+tf0y3YEEIhppwQpJG5HtEyjGfHnQ0RsS8APDGH486ZjGZmc32rnw9ln/z8fq01W7gVUSnUy9nZZ0236VU/XcLTvxFATjKZMqlLwn0BSWqUiogF+WgWQq+4RyJQRTDhY6bcUmoQEiT0tyAjl3286SuEDKk8wygstWH+0XOi1uoqFvju3M0XkXxe6KD4glrKUaD+QjpMjHSdCbKMySgulUNmaoMYXBrFs0FF0zbysH/Ccvhaz6gLoIyJgBDbIECjl7N4nhT32ZKGz80sAQhvtnEZYIyKwxEDIc7Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZUt7lVHC1/YE7WuoUKS2nsRDSt+AY5CpfahPrKCGxMc=;
 b=bVzvR6JuEtdiuYhIHskwrPWAxvd3fF2IgtwPecKOB+srST79eM9IX9YI5IrtQtXQXNyZTLhQQabZiLGX2z7fEuEtJjVj3XTzflhQnTeaWGJwCFph/x5IMmyEpIe9F5Ij4aTOTdmocllQ7nlXgnqZRoV0FYLvekV4eAhjO1TWigdtuNdwFjYyZIFQ2vKvgRYb6hAxQC4t18ksgFenLYjlMVufJ/j8eb2yZR0at9Rl5DrCMuogQKCnxUY8t3Q9HFwMd+w2T30Dv3aoD7Zr9ssfSjB3tu0lGWTi/vQZC+MZDL+0fCIbnRHKUn0dN327MHpdFyvNP45gDniEPNSpaEwumA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZUt7lVHC1/YE7WuoUKS2nsRDSt+AY5CpfahPrKCGxMc=;
 b=TXs6NLrEhhaLrCQE/VT1ml2xdX8eMul7n+vqCfL6lxAsTeoUs4hmXfHtp0WC+jevFemQiYwQU26AtJJriKulkfBMU/mQqSwHcDKTzRPeANVw5wnjvTms7zaH4dtIKob1DqvUhvPLsplsUgTNjCI3V8fxVg0KyW0o7tLRVccytWQ=
Received: from DM5PR12MB1708.namprd12.prod.outlook.com (2603:10b6:3:10e::22)
 by DM5PR12MB1866.namprd12.prod.outlook.com (2603:10b6:3:10c::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.16; Fri, 31 Jul
 2020 03:48:45 +0000
Received: from DM5PR12MB1708.namprd12.prod.outlook.com
 ([fe80::7865:b161:9dd1:7c5]) by DM5PR12MB1708.namprd12.prod.outlook.com
 ([fe80::7865:b161:9dd1:7c5%10]) with mapi id 15.20.3216.034; Fri, 31 Jul 2020
 03:48:45 +0000
From: "Liu, Monk" <Monk.Liu@amd.com>
To: "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: introduce a new parameter to configure how
 many KCQ we want(v3)
Thread-Topic: [PATCH] drm/amdgpu: introduce a new parameter to configure how
 many KCQ we want(v3)
Thread-Index: AQHWZL2aDozQFeOfiE6RuRTYm4GaoqkdD/2AgAPknmCAAAQPAIAAGJcA
Date: Fri, 31 Jul 2020 03:48:44 +0000
Message-ID: <DM5PR12MB1708E60CF4F88BE0AFF0F72B844E0@DM5PR12MB1708.namprd12.prod.outlook.com>
References: <1595926842-12994-1-git-send-email-Monk.Liu@amd.com>
 <ff150645-5527-bad5-7155-6e60734b3297@amd.com>
 <DM5PR12MB1708D46BE6245D9A563C1195844E0@DM5PR12MB1708.namprd12.prod.outlook.com>
 <1d4c6a0d-f3c6-558d-d4a9-408ce9de9f9e@amd.com>
In-Reply-To: <1d4c6a0d-f3c6-558d-d4a9-408ce9de9f9e@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=6cbc9bab-34ff-47cc-bfa3-000017f8ec3f;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-07-31T03:47:53Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c4c7c1b9-5ba3-4c0e-1f83-08d835049fe9
x-ms-traffictypediagnostic: DM5PR12MB1866:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB1866FAACA28F99EE144F2CD2844E0@DM5PR12MB1866.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AdAFId1RhD+EKh/b2GWbuZaPeMhYpdV8Tcon2Q4eGXKMhlIxG05hO3/OmFWSumj6p1MCPQ7yWCPl2eccdC2kwbjR0GIr8m8ldrdj3NcxqvGrweIKOSgqR6nbnGpyuThEMUB5ldWCXXy2HDFu4OKbvu/CyeuKlFSGt6q9ukHhgKuhaZDZJFBmYOCVdEeJovQRlT5+YYUY+WKV6YnKKAqZBgGentgmeKtJYXjdKh3DSshglTHU7ZnFKmICddWNdk2ikJUu2fneE6kEvVZLHe4PsAhTjHqbvNSWawwmsjjXV+gzA8UMjkW7Goz7+6+sClnkkzSEXg8G7mAeFGTrdM+l9A==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1708.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(136003)(396003)(366004)(346002)(39860400002)(52536014)(2906002)(86362001)(5660300002)(6506007)(53546011)(8676002)(83380400001)(110136005)(66946007)(76116006)(66556008)(66476007)(64756008)(33656002)(66446008)(316002)(30864003)(186003)(26005)(71200400001)(8936002)(55016002)(7696005)(9686003)(478600001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: RP/4GfmVEkGybF6kDwbfJ9EWMYTnlvH+wjm7LcU1YrjUFfmhrytueAGk4FUwMiWPjD1hh73EE1WMMxTzW29l5HfBU5XXBFeRZbaCk6JbDhlU/NvO7bfD1n/R3Uo/uIngWKcFYkt3y78U2EgsTFY/NGjekGxdmch6sL2vnprZ3HZ1ML3WWGFU/hGtmZ/v0VKJkukQH4dF/2hPJ0mub7Tty9s+LPE7hWGeoHb4XeNsdZXcYTEGx+FoGBdQJralMXEFgYeDAvDgXaEz3jgvyM2XAyBPin/v13xNpYRDxZj97h7hUWkBw411EYmb5evZVYAUtfoGf+gZFlz0QpwFVPCdYSOZmyy2KtMkhDuTuYaaRWZBrP5wzJTU+XINqH3fRp1JehjmHPAyGcQikpO+gDRBXv95XVNrpHEl2hBU4Cc9wm6sgfK/DAUqWrz427bGyKwXDWbbYOfaWfRk0JYJcyK+mHP3ONci264e2fUjsPOLVMSm7zp/cUiW5GBFe8cW1cSH9ZeAbm1e5LnYJeTws1QtejxFqeUAfJ/I0uKUPjEZeoBp+K0A5gjssnU3nlxPLho9H8sbXeW3/iYiOLFynGm3I13meANYCd0LX1o7ZZOz0WZUX45WgTe969XAfamhshpn0EDzCAk1zwoFF+TuBflJ5A==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1708.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4c7c1b9-5ba3-4c0e-1f83-08d835049fe9
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2020 03:48:44.9802 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 60R5MjmN4H8LMjJDFusocOj5+38Dtti0SKxgtxn9wpkPq1h6oLOX/85IBhgV9yV2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1866
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

My latest patch  was already based on visually 8 SPACE per TAB config, but the TAB was *not* replaced by real eight spaces

_____________________________________
Monk Liu|GPU Virtualization Team |AMD


-----Original Message-----
From: Kuehling, Felix <Felix.Kuehling@amd.com>
Sent: Friday, July 31, 2020 10:20 AM
To: Liu, Monk <Monk.Liu@amd.com>; amd-gfx@lists.freedesktop.org
Subject: Re: [PATCH] drm/amdgpu: introduce a new parameter to configure how many KCQ we want(v3)


Am 2020-07-30 um 10:11 p.m. schrieb Liu, Monk:
> [AMD Official Use Only - Internal Distribution Only]
>
>>>> Indentation looks wrong. Did you use the wrong TAB size?
> My TAB size is 4 space, and I don't know why it looks strange , but I
> can use space to replace the TABs anyway

The linux kernel uses TABs for indentation, and TAB width is 8. Do not replace TABs with spaces for indentation, that would violate the kernel coding style guide. Please change the settings of your editor.

See Documentation/process/coding-style.rst.

Regards,
  Felix


>
> Will send v4 patch against other suggestions from your side soon
>
> _____________________________________
> Monk Liu|GPU Virtualization Team |AMD
>
>
> -----Original Message-----
> From: Kuehling, Felix <Felix.Kuehling@amd.com>
> Sent: Tuesday, July 28, 2020 10:38 PM
> To: Liu, Monk <Monk.Liu@amd.com>; amd-gfx@lists.freedesktop.org
> Subject: Re: [PATCH] drm/amdgpu: introduce a new parameter to
> configure how many KCQ we want(v3)
>
> Am 2020-07-28 um 5:00 a.m. schrieb Monk Liu:
>> what:
>> the MQD's save and restore of KCQ (kernel compute queue) cost lots of
>> clocks during world switch which impacts a lot to multi-VF
>> performance
>>
>> how:
>> introduce a paramter to control the number of KCQ to avoid
>> performance drop if there is no kernel compute queue needed
>>
>> notes:
>> this paramter only affects gfx 8/9/10
>>
>> v2:
>> refine namings
>>
>> v3:
>> choose queues for each ring to that try best to cross pipes evenly.
> Thanks. Some more suggestions for simplifications inline.
>
>
>> TODO:
>> in the future we will let hypervisor driver to set this paramter
>> automatically thus no need for user to configure it through modprobe
>> in virtual machine
>>
>> Signed-off-by: Monk Liu <Monk.Liu@amd.com>
>> ---
>>  drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  1 +
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  5 +++
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    |  4 +++
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c    | 58 +++++++++++++++---------------
>>  drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c     | 30 ++++++++--------
>>  drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c      | 29 +++++++--------
>>  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c      | 31 ++++++++--------
>>  7 files changed, 87 insertions(+), 71 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> index e97c088..de11136 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> @@ -201,6 +201,7 @@ extern int amdgpu_si_support;  #ifdef
>> CONFIG_DRM_AMDGPU_CIK  extern int amdgpu_cik_support;  #endif
>> +extern int amdgpu_num_kcq;
>>
>>  #define AMDGPU_VM_MAX_NUM_CTX4096
>>  #define AMDGPU_SG_THRESHOLD(256*1024*1024)
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> index 62ecac9..cf445bab 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> @@ -1199,6 +1199,11 @@ static int
>> amdgpu_device_check_arguments(struct
>> amdgpu_device *adev)
>>
>>  amdgpu_gmc_tmz_set(adev);
>>
>> +if (amdgpu_num_kcq > 8 || amdgpu_num_kcq < 0) { amdgpu_num_kcq = 8;
>> +dev_warn(adev->dev, "set kernel compute queue number to 8 due to
>> +invalid paramter provided by user\n"); }
>> +
>>  return 0;
>>  }
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> index 6291f5f..b545c40 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> @@ -150,6 +150,7 @@ int amdgpu_noretry;  int amdgpu_force_asic_type =
>> -1;  int amdgpu_tmz = 0;  int amdgpu_reset_method = -1; /* auto */
>> +int amdgpu_num_kcq = -1;
>>
>>  struct amdgpu_mgpu_info mgpu_info = {  .mutex =
>> __MUTEX_INITIALIZER(mgpu_info.mutex),
>> @@ -765,6 +766,9 @@ module_param_named(tmz, amdgpu_tmz, int, 0444);
>> MODULE_PARM_DESC(reset_method, "GPU reset method (-1 = auto
>> (default),
>> 0 = legacy, 1 = mode0, 2 = mode1, 3 = mode2, 4 = baco)");
>> module_param_named(reset_method, amdgpu_reset_method, int, 0444);
>>
>> +MODULE_PARM_DESC(num_kcq, "number of kernel compute queue user want
>> +to setup (8 if set to greater than 8 or less than 0, only affect gfx
>> +8+)"); module_param_named(num_kcq, amdgpu_num_kcq, int, 0444);
>> +
>>  static const struct pci_device_id pciidlist[] = {  #ifdef
>> CONFIG_DRM_AMDGPU_SI  {0x1002, 0x6780, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
>> CHIP_TAHITI}, diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
>> index 8eff017..f83a9a7 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
>> @@ -202,40 +202,42 @@ bool
>> amdgpu_gfx_is_high_priority_compute_queue(struct amdgpu_device *adev,
>>
>>  void amdgpu_gfx_compute_queue_acquire(struct amdgpu_device *adev)  {
>> -int i, queue, pipe, mec;
>> +int i, queue, pipe;
>>  bool multipipe_policy = amdgpu_gfx_is_multipipe_capable(adev);
>> +int max_queues_per_mec = min(adev->gfx.mec.num_pipe_per_mec *
>> + adev->gfx.mec.num_queue_per_pipe,
>> + adev->gfx.num_compute_rings);
> Indentation looks wrong. Did you use the wrong TAB size?
>
>
>> +
>> +if (multipipe_policy) {
>> +/* policy: make queues evenly cross all pipes on MEC1 only */ for (i
>> += 0; i < max_queues_per_mec; i++) { pipe = i %
>> +adev->gfx.mec.num_pipe_per_mec; queue = (i /
>> +adev->gfx.mec.num_pipe_per_mec) %
>> +adev->gfx.mec.num_queue_per_pipe;
>> +
>> +set_bit(pipe * adev->gfx.mec.num_queue_per_pipe + queue,
>> +adev->gfx.mec.queue_bitmap);
>> +}
>> +} else {
>> +int mec;
>>
>> -/* policy for amdgpu compute queue ownership */ -for (i = 0; i <
>> AMDGPU_MAX_COMPUTE_QUEUES; ++i) { -queue = i %
>> adev->gfx.mec.num_queue_per_pipe; -pipe = (i /
>> adev->gfx.mec.num_queue_per_pipe) -% adev->gfx.mec.num_pipe_per_mec;
>> -mec = (i / adev->gfx.mec.num_queue_per_pipe) -/
>> adev->gfx.mec.num_pipe_per_mec;
>> -
>> -/* we've run out of HW */
>> -if (mec >= adev->gfx.mec.num_mec)
>> -break;
>> +/* policy: amdgpu owns all queues in the given pipe */ for (i = 0; i
>> +< adev->gfx.num_compute_rings; ++i) {
> You could also use i < max_queues_per_mec here.
>
>
>> +queue = i % adev->gfx.mec.num_queue_per_pipe; pipe = (i /
>> +adev->gfx.mec.num_queue_per_pipe)
>> +% adev->gfx.mec.num_pipe_per_mec;
>> +mec = (i / adev->gfx.mec.num_queue_per_pipe) /
>> +adev->gfx.mec.num_pipe_per_mec;
> Then mec will always be 0 and you can eliminate that variable.
>
>
>> -if (multipipe_policy) {
>> -/* policy: amdgpu owns the first two queues of the first MEC */ -if
>> (mec == 0 && queue < 2) -set_bit(i, adev->gfx.mec.queue_bitmap); -}
>> else {
>> -/* policy: amdgpu owns all queues in the first pipe */ -if (mec == 0
>> && pipe == 0) -set_bit(i, adev->gfx.mec.queue_bitmap);
>> +/* we've run out of HW */
>> +if (mec >= adev->gfx.mec.num_mec)
>> +break;
> And you won't need this if (...) break; any more.
>
> It'll make the two policy cases look more similar, so it's easier to see how they are actually different.
>
> Regards,
>   Felix
>
>
>> +
>> +set_bit(i, adev->gfx.mec.queue_bitmap);
>>  }
>>  }
>>
>> -/* update the number of active compute rings */
>> -adev->gfx.num_compute_rings =
>> -bitmap_weight(adev->gfx.mec.queue_bitmap,
>> AMDGPU_MAX_COMPUTE_QUEUES);
>> -
>> -/* If you hit this case and edited the policy, you probably just
>> - * need to increase AMDGPU_MAX_COMPUTE_RINGS */ -if
>> (WARN_ON(adev->gfx.num_compute_rings > AMDGPU_MAX_COMPUTE_RINGS))
>> -adev->gfx.num_compute_rings = AMDGPU_MAX_COMPUTE_RINGS;
>> +dev_info(adev->dev, "mec queue bitmap weight=%d\n",
>> +bitmap_weight(adev->gfx.mec.queue_bitmap,
>> +AMDGPU_MAX_COMPUTE_QUEUES));
>>  }
>>
>>  void amdgpu_gfx_graphics_queue_acquire(struct amdgpu_device *adev)
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
>> b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
>> index db9f1e8..3a93b3c 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
>> @@ -4022,21 +4022,23 @@ static int gfx_v10_0_mec_init(struct
>> amdgpu_device *adev)  amdgpu_gfx_compute_queue_acquire(adev);
>>  mec_hpd_size = adev->gfx.num_compute_rings * GFX10_MEC_HPD_SIZE;
>>
>> -r = amdgpu_bo_create_reserved(adev, mec_hpd_size, PAGE_SIZE,
>> -      AMDGPU_GEM_DOMAIN_GTT,
>> -      &adev->gfx.mec.hpd_eop_obj,
>> -      &adev->gfx.mec.hpd_eop_gpu_addr,
>> -      (void **)&hpd);
>> -if (r) {
>> -dev_warn(adev->dev, "(%d) create HDP EOP bo failed\n", r);
>> -gfx_v10_0_mec_fini(adev); -return r; -}
>> +if (mec_hpd_size) {
>> +r = amdgpu_bo_create_reserved(adev, mec_hpd_size, PAGE_SIZE,
>> +  AMDGPU_GEM_DOMAIN_GTT,
>> +  &adev->gfx.mec.hpd_eop_obj,
>> +  &adev->gfx.mec.hpd_eop_gpu_addr,
>> +  (void **)&hpd);
>> +if (r) {
>> +dev_warn(adev->dev, "(%d) create HDP EOP bo failed\n", r);
>> +gfx_v10_0_mec_fini(adev); return r; }
>>
>> -memset(hpd, 0, mec_hpd_size);
>> +memset(hpd, 0, mec_hpd_size);
>>
>> -amdgpu_bo_kunmap(adev->gfx.mec.hpd_eop_obj);
>> -amdgpu_bo_unreserve(adev->gfx.mec.hpd_eop_obj);
>> +amdgpu_bo_kunmap(adev->gfx.mec.hpd_eop_obj);
>> +amdgpu_bo_unreserve(adev->gfx.mec.hpd_eop_obj);
>> +}
>>
>>  if (adev->firmware.load_type == AMDGPU_FW_LOAD_DIRECT) {  mec_hdr =
>> (const struct gfx_firmware_header_v1_0 *)adev->gfx.mec_fw->data; @@
>> -7159,7 +7161,7 @@ static int gfx_v10_0_early_init(void *handle)
>> break;  }
>>
>> -adev->gfx.num_compute_rings = AMDGPU_MAX_COMPUTE_RINGS;
>> +adev->gfx.num_compute_rings = amdgpu_num_kcq;
>>
>>  gfx_v10_0_set_kiq_pm4_funcs(adev);
>>  gfx_v10_0_set_ring_funcs(adev);
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
>> b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
>> index 8d72089..eb4b812 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
>> @@ -1343,21 +1343,22 @@ static int gfx_v8_0_mec_init(struct
>> amdgpu_device *adev)  amdgpu_gfx_compute_queue_acquire(adev);
>>
>>  mec_hpd_size = adev->gfx.num_compute_rings * GFX8_MEC_HPD_SIZE;
>> +if (mec_hpd_size) {
>> +r = amdgpu_bo_create_reserved(adev, mec_hpd_size, PAGE_SIZE,
>> +  AMDGPU_GEM_DOMAIN_VRAM,
>> +  &adev->gfx.mec.hpd_eop_obj,
>> +  &adev->gfx.mec.hpd_eop_gpu_addr,
>> +  (void **)&hpd);
>> +if (r) {
>> +dev_warn(adev->dev, "(%d) create HDP EOP bo failed\n", r); return r;
>> +}
>>
>> -r = amdgpu_bo_create_reserved(adev, mec_hpd_size, PAGE_SIZE,
>> -      AMDGPU_GEM_DOMAIN_VRAM,
>> -      &adev->gfx.mec.hpd_eop_obj,
>> -      &adev->gfx.mec.hpd_eop_gpu_addr,
>> -      (void **)&hpd);
>> -if (r) {
>> -dev_warn(adev->dev, "(%d) create HDP EOP bo failed\n", r); -return
>> r; -}
>> -
>> -memset(hpd, 0, mec_hpd_size);
>> +memset(hpd, 0, mec_hpd_size);
>>
>> -amdgpu_bo_kunmap(adev->gfx.mec.hpd_eop_obj);
>> -amdgpu_bo_unreserve(adev->gfx.mec.hpd_eop_obj);
>> +amdgpu_bo_kunmap(adev->gfx.mec.hpd_eop_obj);
>> +amdgpu_bo_unreserve(adev->gfx.mec.hpd_eop_obj);
>> +}
>>
>>  return 0;
>>  }
>> @@ -5294,7 +5295,7 @@ static int gfx_v8_0_early_init(void *handle)
>> struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>>
>>  adev->gfx.num_gfx_rings = GFX8_NUM_GFX_RINGS;
>> -adev->gfx.num_compute_rings = AMDGPU_MAX_COMPUTE_RINGS;
>> +adev->gfx.num_compute_rings = amdgpu_num_kcq;
>>  adev->gfx.funcs = &gfx_v8_0_gfx_funcs;
>> gfx_v8_0_set_ring_funcs(adev);  gfx_v8_0_set_irq_funcs(adev); diff
>> --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
>> b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
>> index e4e751f..43ad044 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
>> @@ -1938,22 +1938,23 @@ static int gfx_v9_0_mec_init(struct
>> amdgpu_device *adev)
>>  /* take ownership of the relevant compute queues */
>> amdgpu_gfx_compute_queue_acquire(adev);
>>  mec_hpd_size = adev->gfx.num_compute_rings * GFX9_MEC_HPD_SIZE;
>> +if (mec_hpd_size) {
>> +r = amdgpu_bo_create_reserved(adev, mec_hpd_size, PAGE_SIZE,
>> +  AMDGPU_GEM_DOMAIN_VRAM,
>> +  &adev->gfx.mec.hpd_eop_obj,
>> +  &adev->gfx.mec.hpd_eop_gpu_addr,
>> +  (void **)&hpd);
>> +if (r) {
>> +dev_warn(adev->dev, "(%d) create HDP EOP bo failed\n", r);
>> +gfx_v9_0_mec_fini(adev); return r; }
>>
>> -r = amdgpu_bo_create_reserved(adev, mec_hpd_size, PAGE_SIZE,
>> -      AMDGPU_GEM_DOMAIN_VRAM,
>> -      &adev->gfx.mec.hpd_eop_obj,
>> -      &adev->gfx.mec.hpd_eop_gpu_addr,
>> -      (void **)&hpd);
>> -if (r) {
>> -dev_warn(adev->dev, "(%d) create HDP EOP bo failed\n", r);
>> -gfx_v9_0_mec_fini(adev); -return r; -}
>> -
>> -memset(hpd, 0, mec_hpd_size);
>> +memset(hpd, 0, mec_hpd_size);
>>
>> -amdgpu_bo_kunmap(adev->gfx.mec.hpd_eop_obj);
>> -amdgpu_bo_unreserve(adev->gfx.mec.hpd_eop_obj);
>> +amdgpu_bo_kunmap(adev->gfx.mec.hpd_eop_obj);
>> +amdgpu_bo_unreserve(adev->gfx.mec.hpd_eop_obj);
>> +}
>>
>>  mec_hdr = (const struct gfx_firmware_header_v1_0
>> *)adev->gfx.mec_fw->data;
>>
>> @@ -4625,7 +4626,7 @@ static int gfx_v9_0_early_init(void *handle)
>> adev->gfx.num_gfx_rings = 0;  else  adev->gfx.num_gfx_rings =
>> GFX9_NUM_GFX_RINGS;
>> -adev->gfx.num_compute_rings = AMDGPU_MAX_COMPUTE_RINGS;
>> +adev->gfx.num_compute_rings = amdgpu_num_kcq;
>>  gfx_v9_0_set_kiq_pm4_funcs(adev);
>>  gfx_v9_0_set_ring_funcs(adev);
>>  gfx_v9_0_set_irq_funcs(adev);
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
