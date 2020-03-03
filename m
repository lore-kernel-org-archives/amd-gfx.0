Return-Path: <SRS0=6yRT=4U=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C47DAC3F2D7
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Mar 2020 13:19:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A0B120842
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Mar 2020 13:19:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="wpG9+hUb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A0B120842
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4F50E6EA65;
	Tue,  3 Mar 2020 13:19:09 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2059.outbound.protection.outlook.com [40.107.236.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E873B6EA2C
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Mar 2020 13:19:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PJsOMpm6LVrwXt+62Z2eU42WneTNe5Kl+X2IXahFZzVuwiP3Ionf70I1QcLb+gsKIIpaWsJTdhGWGJ+7ewESLb2JqP3JORPMRt3hm36WYDAmbBs1rYdimFzrN1wM4jbFfu7xvhkyKUtm4bWqVQmkTrlRILXamiWdcdP7p9UsYofEmwzWIYNJsZkd2ZEyfKXwyBbABtFNo9+galH3GWZIJE6BO4XAGUJtW2AGE8mmGDl8JygBtiEBS5FTtofbIVwnTnXrJQdm8INP9c4JumZNRE7xECrRofMjee6HE0mrnNXPwXCMf5X9jMcrjTarJZQpb62TilPktO23xXIz0xQfgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lsMNI6kH/fnI13gbY3IFYhZSTdsKITST4LwoE1Vcbt8=;
 b=Y30sIh6fg8Ba0n6ZvkcFB4WBOWtxvcXaQ+mg4Gpp6HJIMq8JaBnIzXB3xozHhWwItmYZURbqkKx3L1HHGRdrApDNs9dl6q+swTPs4mG0w/464r94EWVbxo/NMe2pwAmUj3KmaKO7jh3m+yx2YbYn2kv2lxE39dKfZ1YcO3haA0mD/PK4l/TuE+Dj9/eBRXdkvjoKhQMjpAmm4I5Ntl/ZJHghQ51NTVtgX9Y3+PSW1X7QQdEvJbFzbdhy7lV1ef2nlam/NiWPw4FpEbKf5E84rJxtoIhHxrq4vUtsScJab3OIXgSkxA+hPDP+NEh5F5ZsJmDsYsefmFKcDsmDZFtlRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lsMNI6kH/fnI13gbY3IFYhZSTdsKITST4LwoE1Vcbt8=;
 b=wpG9+hUb91knHzE/Fxibprj5hqgqcK6hlGQeRjlax5qRRhgMwuvoOSz1zpD0wGuUq4wpf/qNg+ysS+46HmcY08NbPxHv7EqwDCmdwZFy3Hex4oqrb8oj0ix9wUgj5TcUtVWdB1qAo+rMi1D8n2Qwcx8TprSL5jIM4jQRlJliM4M=
Received: from CH2PR12MB3831.namprd12.prod.outlook.com (2603:10b6:610:29::13)
 by CH2PR12MB4294.namprd12.prod.outlook.com (2603:10b6:610:a9::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.14; Tue, 3 Mar
 2020 13:19:05 +0000
Received: from CH2PR12MB3831.namprd12.prod.outlook.com
 ([fe80::94ba:d933:5252:ae51]) by CH2PR12MB3831.namprd12.prod.outlook.com
 ([fe80::94ba:d933:5252:ae51%7]) with mapi id 15.20.2772.019; Tue, 3 Mar 2020
 13:19:05 +0000
From: "Wu, Hersen" <hersenxs.wu@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
Subject: RE: [PATCH 2/2] drm/amdgpu/display: navi1x copy dcn watermark clock
 settings to smu resume from s3
Thread-Topic: [PATCH 2/2] drm/amdgpu/display: navi1x copy dcn watermark clock
 settings to smu resume from s3
Thread-Index: AQHV7YYgld4ORuMO6kCKd4l5jJ+nsKgv6tEAgAEpcQKABE3fAIABfzZQ
Date: Tue, 3 Mar 2020 13:19:05 +0000
Message-ID: <CH2PR12MB3831A01E4623264573AEC041FDE40@CH2PR12MB3831.namprd12.prod.outlook.com>
References: <20200227155349.10993-1-hersenxs.wu@amd.com>
 <MN2PR12MB33448440496BD112CE52820BE4E80@MN2PR12MB3344.namprd12.prod.outlook.com>
 <MN2PR12MB38404E1958870D36B236B217FDE80@MN2PR12MB3840.namprd12.prod.outlook.com>
 <CADnq5_N3fn=oc=kWAfPThK0u9k8eNJv8EeiN0F8WTP_a6ChzNA@mail.gmail.com>
In-Reply-To: <CADnq5_N3fn=oc=kWAfPThK0u9k8eNJv8EeiN0F8WTP_a6ChzNA@mail.gmail.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-03-03T13:19:04Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=19868434-b776-42b3-ac33-000047dd914c;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-03-03T13:19:04Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 87c7ebb4-868d-4790-9695-000094fa4a5d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=hersenxs.wu@amd.com; 
x-originating-ip: [165.204.55.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f4c91916-5419-402f-2959-08d7bf7572e6
x-ms-traffictypediagnostic: CH2PR12MB4294:|CH2PR12MB4294:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR12MB4294F846A3CEABF94F73E72DFDE40@CH2PR12MB4294.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 03319F6FEF
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10001)(10009020)(4636009)(39860400002)(346002)(376002)(136003)(396003)(366004)(199004)(189003)(26005)(53546011)(186003)(76116006)(52536014)(5660300002)(64756008)(66556008)(81166006)(66446008)(66476007)(8676002)(66946007)(71200400001)(9686003)(8936002)(55016002)(81156014)(33656002)(6506007)(4326008)(45080400002)(966005)(2906002)(316002)(54906003)(7696005)(6916009)(86362001)(478600001)(32563001)(357404004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CH2PR12MB4294;
 H:CH2PR12MB3831.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DdOHbRZYPgzdRZ9dbwS7MP2iQjlrG+YxerKgv39ia7xeiSVpldMPR1WFcmCliPjY8EN+ggylAwH/XrLpnGbf1ITfL7zpMYfl9OwKeSQL0KefrharwRGGVNxJKYDimu6OasMy7g0pHasSw36rxLO2zYTLbRq9wBe5dhJYYehHeNmz2jxP78bMuIpqw4X10xHocq5hNXb3aeUfFhZWD9u9qedjU5wxKkepFgRx34wXiyAe+v9He2Cc++mirh1b/5HzDwJNrjbuh29LTduwcX0h5vv/g4xRdI4gKeZpJqye2JuOaPkl8J/Iie6IEGq4AwFpkM2bk/mjp8qDRbjfdg/FqY7gnHCOlvPfKLne2AB/TsUcghLVVf58IDZpQFpn4qchsD/4a/Xm65/4JxkhoS7wPX0cxaKLl/unB0n06c5ZKn0+UrnlkwmeepC/m4HRao3ERXBMdU/HIWbkL23R0ysPAscFMYlOZnocaFCBeda32VK/gU+qyh9lxsQXfnn6L4ZvlOP9Masn6X+LfAyk0ZrzmK6DKWDftgKYVKCQ58kjJFa1LRer2OPFx9Ggpnk9/ayqlGiL/cnzB47p/SZYjQa9qvL7Mm8hkC5CiszJA4Wo7oyOC1lJljc1hwEYSUW2iuFJzgTe12sKmqdJ4xiFNID7QQjbK5Gv39yF6hGzPi7YHF5+ISqBy4kuqo/rH1dWTCCkD0al23Rofdl72htHrmRCDw==
x-ms-exchange-antispam-messagedata: +GigAwOjLK5aZmF8QAp3URnn7ZUTZq4FcOiowhfuqoCgDP5KGtIl6VPLNMnctIEpVq8cF1xN3xCMaXkgmk2V1R7nw6H2p4YnJvFDkJ4ojVRxTdnSFM+8stuchNBWsoT2ObZxZr4oUMxF7ww0NdKvTA==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4c91916-5419-402f-2959-08d7bf7572e6
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2020 13:19:05.4180 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kkquays29oe3IqbDUNtkYC+bkMvWU+gArGL5uHYjhA6x265cMxi8WwiPl12RqrfzDHR23YDPSGDCC9hGknMrcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4294
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
Cc: "Quan, Evan" <Evan.Quan@amd.com>, "Feng, Kenneth" <Kenneth.Feng@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Hi Evan, Kenneth,

Would you please help review this patch again?

Thanks!
Hersen


-----Original Message-----
From: Alex Deucher <alexdeucher@gmail.com> 
Sent: Monday, March 2, 2020 9:27 AM
To: Wu, Hersen <hersenxs.wu@amd.com>
Cc: Quan, Evan <Evan.Quan@amd.com>; amd-gfx@lists.freedesktop.org; Feng, Kenneth <Kenneth.Feng@amd.com>
Subject: Re: [PATCH 2/2] drm/amdgpu/display: navi1x copy dcn watermark clock settings to smu resume from s3

On Fri, Feb 28, 2020 at 3:59 PM Wu, Hersen <hersenxs.wu@amd.com> wrote:
>
> Follow Evan's review, add smu->mutex.
>
>
> This interface is for dGPU Navi1x. Linux dc-pplib interface depends  
> on window driver dc implementation.
>
>  For Navi1x, clock settings of dcn watermarks are fixed. the settings  
> should be passed to smu during boot up and resume from s3.
>  boot up: dc calculate dcn watermark clock settings within dc_create,  
> dcn20_resource_construct, then call pplib functions below to pass  the 
> settings to smu:
>  smu_set_watermarks_for_clock_ranges
>  smu_set_watermarks_table
>  navi10_set_watermarks_table
>  smu_write_watermarks_table
>
>  For Renoir, clock settings of dcn watermark are also fixed values.
>  dc has implemented different flow for window driver:
>  dc_hardware_init / dc_set_power_state  dcn10_init_hw  
> notify_wm_ranges  set_wm_ranges
>
>  For Linux
>  smu_set_watermarks_for_clock_ranges
>  renoir_set_watermarks_table
>  smu_write_watermarks_table
>
>  dc_hardware_init -> amdgpu_dm_init
>  dc_set_power_state --> dm_resume
>
>  therefore, linux dc-pplib interface of navi10/12/14 is different  
> from that of Renoir.
>
> Signed-off-by: Hersen Wu <hersenxs.wu@amd.com>
> ---
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 68 
> +++++++++++++++++++
>  1 file changed, 68 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c 
> b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 931cbd7b372e..1ee1d6ff2782 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -1435,6 +1435,72 @@ static void s3_handle_mst(struct drm_device *dev, bool suspend)
>   drm_kms_helper_hotplug_event(dev);
>  }
>
> +static int amdgpu_dm_smu_write_watermarks_table(struct amdgpu_device 
> +*adev) {  struct smu_context *smu = &adev->smu;  int ret = 0;
> +
> + if (!is_support_sw_smu(adev))
> + return 0;
> +
> + /* This interface is for dGPU Navi1x.Linux dc-pplib interface 
> + depends
> + * on window driver dc implementation.
> + * For Navi1x, clock settings of dcn watermarks are fixed. the 
> + settings
> + * should be passed to smu during boot up and resume from s3.
> + * boot up: dc calculate dcn watermark clock settings within 
> + dc_create,
> + * dcn20_resource_construct
> + * then call pplib functions below to pass the settings to smu:
> + * smu_set_watermarks_for_clock_ranges
> + * smu_set_watermarks_table
> + * navi10_set_watermarks_table
> + * smu_write_watermarks_table
> + *
> + * For Renoir, clock settings of dcn watermark are also fixed values.
> + * dc has implemented different flow for window driver:
> + * dc_hardware_init / dc_set_power_state
> + * dcn10_init_hw
> + * notify_wm_ranges
> + * set_wm_ranges
> + * -- Linux
> + * smu_set_watermarks_for_clock_ranges
> + * renoir_set_watermarks_table
> + * smu_write_watermarks_table
> + *
> + * For Linux,
> + * dc_hardware_init -> amdgpu_dm_init
> + * dc_set_power_state --> dm_resume
> + *
> + * therefore, this function apply to navi10/12/14 but not Renoir
> + * *
> + */
> + switch(adev->asic_type) {
> + case CHIP_NAVI10:
> + case CHIP_NAVI14:
> + case CHIP_NAVI12:
> + break;
> + default:
> + return 0;
> + }
> +
> + mutex_lock(&smu->mutex);
> +
> + /* pass data to smu controller */
> + if ((smu->watermarks_bitmap & WATERMARKS_EXIST) && 
> + !(smu->watermarks_bitmap & WATERMARKS_LOADED)) { ret = 
> + smu_write_watermarks_table(smu);
> +
> + if (ret) {
> + DRM_ERROR("Failed to update WMTABLE!\n"); return ret;

You need to unlock the mutex here in the failure case.

Alex

> + }
> + smu->watermarks_bitmap |= WATERMARKS_LOADED;
> + }
> +
> + mutex_unlock(&smu->mutex);
> +
> + return 0;
> +}
> +
>  /**
>   * dm_hw_init() - Initialize DC device
>   * @handle: The base driver device containing the amdgpu_dm device.
> @@ -1713,6 +1779,8 @@ static int dm_resume(void *handle)
>
>   amdgpu_dm_irq_resume_late(adev);
>
> + amdgpu_dm_smu_write_watermarks_table(adev);
> +
>   return 0;
>  }
>
> --
> 2.17.1
>
> ________________________________
> From: Quan, Evan <Evan.Quan@amd.com>
> Sent: February 27, 2020 9:58 PM
> To: Wu, Hersen <hersenxs.wu@amd.com>; amd-gfx@lists.freedesktop.org 
> <amd-gfx@lists.freedesktop.org>
> Cc: Feng, Kenneth <Kenneth.Feng@amd.com>; Wu, Hersen 
> <hersenxs.wu@amd.com>
> Subject: RE: [PATCH 2/2] drm/amdgpu/display: navi1x copy dcn watermark 
> clock settings to smu resume from s3
>
> Thanks. But could you help to confirm whether this is correctly protected by "mutex_lock(&smu->mutex)"?
>
> -----Original Message-----
> From: Hersen Wu <hersenxs.wu@amd.com>
> Sent: Thursday, February 27, 2020 11:54 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Quan, Evan <Evan.Quan@amd.com>; Feng, Kenneth 
> <Kenneth.Feng@amd.com>; Wu, Hersen <hersenxs.wu@amd.com>
> Subject: [PATCH 2/2] drm/amdgpu/display: navi1x copy dcn watermark 
> clock settings to smu resume from s3
>
>  This interface is for dGPU Navi1x. Linux dc-pplib interface depends  on window driver dc implementation.
>
>  For Navi1x, clock settings of dcn watermarks are fixed. the settings  should be passed to smu during boot up and resume from s3.
>  boot up: dc calculate dcn watermark clock settings within dc_create,  dcn20_resource_construct, then call pplib functions below to pass  the settings to smu:
>  smu_set_watermarks_for_clock_ranges
>  smu_set_watermarks_table
>  navi10_set_watermarks_table
>  smu_write_watermarks_table
>
>  For Renoir, clock settings of dcn watermark are also fixed values.
>  dc has implemented different flow for window driver:
>  dc_hardware_init / dc_set_power_state  dcn10_init_hw  
> notify_wm_ranges  set_wm_ranges
>
>  For Linux
>  smu_set_watermarks_for_clock_ranges
>  renoir_set_watermarks_table
>  smu_write_watermarks_table
>
>  dc_hardware_init -> amdgpu_dm_init
>  dc_set_power_state --> dm_resume
>
>  therefore, linux dc-pplib interface of navi10/12/14 is different  from that of Renoir.
>
> Signed-off-by: Hersen Wu <hersenxs.wu@amd.com>
> ---
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 64 
> +++++++++++++++++++
>  1 file changed, 64 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c 
> b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 931cbd7b372e..c58c0e95735e 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -1435,6 +1435,68 @@ static void s3_handle_mst(struct drm_device *dev, bool suspend)
>                  drm_kms_helper_hotplug_event(dev);
>  }
>
> +static int amdgpu_dm_smu_write_watermarks_table(struct amdgpu_device
> +*adev) {
> +       struct smu_context *smu = &adev->smu;
> +       int ret = 0;
> +
> +       if (!is_support_sw_smu(adev))
> +               return 0;
> +
> +       /* This interface is for dGPU Navi1x.Linux dc-pplib interface depends
> +        * on window driver dc implementation.
> +        * For Navi1x, clock settings of dcn watermarks are fixed. the settings
> +        * should be passed to smu during boot up and resume from s3.
> +        * boot up: dc calculate dcn watermark clock settings within dc_create,
> +        * dcn20_resource_construct
> +        * then call pplib functions below to pass the settings to smu:
> +        * smu_set_watermarks_for_clock_ranges
> +        * smu_set_watermarks_table
> +        * navi10_set_watermarks_table
> +        * smu_write_watermarks_table
> +        *
> +        * For Renoir, clock settings of dcn watermark are also fixed values.
> +        * dc has implemented different flow for window driver:
> +        * dc_hardware_init / dc_set_power_state
> +        * dcn10_init_hw
> +        * notify_wm_ranges
> +        * set_wm_ranges
> +        * -- Linux
> +        * smu_set_watermarks_for_clock_ranges
> +        * renoir_set_watermarks_table
> +        * smu_write_watermarks_table
> +        *
> +        * For Linux,
> +        * dc_hardware_init -> amdgpu_dm_init
> +        * dc_set_power_state --> dm_resume
> +        *
> +        * therefore, this function apply to navi10/12/14 but not Renoir
> +        * *
> +        */
> +       switch(adev->asic_type) {
> +       case CHIP_NAVI10:
> +       case CHIP_NAVI14:
> +       case CHIP_NAVI12:
> +               break;
> +       default:
> +               return 0;
> +       }
> +
> +       /* pass data to smu controller */
> +       if ((smu->watermarks_bitmap & WATERMARKS_EXIST) &&
> +                       !(smu->watermarks_bitmap & WATERMARKS_LOADED)) {
> +               ret = smu_write_watermarks_table(smu);
> +
> +               if (ret) {
> +                       DRM_ERROR("Failed to update WMTABLE!\n");
> +                       return ret;
> +               }
> +               smu->watermarks_bitmap |= WATERMARKS_LOADED;
> +       }
> +
> +       return 0;
> +}
> +
>  /**
>   * dm_hw_init() - Initialize DC device
>   * @handle: The base driver device containing the amdgpu_dm device.
> @@ -1713,6 +1775,8 @@ static int dm_resume(void *handle)
>
>          amdgpu_dm_irq_resume_late(adev);
>
> +       amdgpu_dm_smu_write_watermarks_table(adev);
> +
>          return 0;
>  }
>
> --
> 2.17.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flist
> s.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Che
> rsenxs.wu%40amd.com%7C4709bedf60fc41d1ae0508d7beb5c120%7C3dd8961fe4884
> e608e11a82d994e183d%7C0%7C0%7C637187560164248086&amp;sdata=6wH59U4RtXQ
> lL6Z2EcIKQWvBNfV0shDAUD05ARVs2MA%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
