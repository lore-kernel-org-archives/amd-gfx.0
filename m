Return-Path: <SRS0=S/Du=4V=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0EF2C3F2D1
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Mar 2020 03:04:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5534420838
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Mar 2020 03:04:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Tcd6AuTI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5534420838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CDD4E6E99E;
	Wed,  4 Mar 2020 03:04:49 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2086.outbound.protection.outlook.com [40.107.243.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 480426E99E
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Mar 2020 03:04:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KkKUhv/Pjxk7qlyIXW5dzLOGAe2rzdoLiK6F1geP/IgNqznvZwdnLNqoC8PYmqSGnCO60SitXByU5VeQHYEumAsKpKnuLfARQPtV2RUJwOSThOhVmw2hyYA+yZ7BDKZJWb8auL2pCTZNim2g0+8oh7bFd7AkVi4cSryEBnFviSUckK3jowO6RyCWR9wHQRo8mniWgS3u0IgvNKfziQXUdRL7Ccs/SaZ5MLffkM9kJws9Mfs6ekvkg7cpd98zISgm1AhmU3gBf+2onNl5ohBqES0iIACjzxZUdJFH1ITogpw9nNjW0NM1nQjGExf/vULm2fx329slkEvR/UJRdTdhFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lPDLzGjKSiMx6O77SfTGXY2H7OGYN28K8TUlxvBmIuI=;
 b=OYbC4+LCDgZpxbuX7kaJNf06e93ZBRjYK9lKBArpQTloHnd3GxpBgr9UpB2Qt7QoC7hEBkaINEItXYJJUi5ZJGoagWOGTfvy7LXk+yrX2r2zdEvZZuXZ8m2U6dk2e4Hyvl7wNzGL6Yr0vkAVOu5zBDKQj0YZidLdbLJSPQQ24Ea97Owoglftk8cA6lseZ5b/auAI7bOungEylAeP7hTJsHH1bY27X4I10N2AUjIAsg57fF7i3/Uu80Uq8jde+ezGZOpcqtlt2Y651wbftm2SARwsBU/TcxDGuoNEN1hgynaIgIADyim2vOA40ltYypOParL2OnOBH9yrxIIfxuameA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lPDLzGjKSiMx6O77SfTGXY2H7OGYN28K8TUlxvBmIuI=;
 b=Tcd6AuTIU5c1loWdHe1q8q34nMyb2MYH3FbkQaE+EZYAcRw1uepueYlD7aasZ8CinO7FzQQT22Ny4BebhxmrhTX1L+HgEsj/H5bXy5nt6XLOrh6WCNPvMfUzbzRK+WCuUvNH8d51RC5sFgneYqJXqX1STzMIBSsHG8u6SH7eaEs=
Received: from MN2PR12MB3344.namprd12.prod.outlook.com (2603:10b6:208:c5::10)
 by MN2PR12MB3551.namprd12.prod.outlook.com (2603:10b6:208:104::30)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.16; Wed, 4 Mar
 2020 03:04:45 +0000
Received: from MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::69c7:b493:690:2173]) by MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::69c7:b493:690:2173%3]) with mapi id 15.20.2772.019; Wed, 4 Mar 2020
 03:04:45 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Wu, Hersen" <hersenxs.wu@amd.com>, Alex Deucher <alexdeucher@gmail.com>
Subject: RE: [PATCH 2/2] drm/amdgpu/display: navi1x copy dcn watermark clock
 settings to smu resume from s3
Thread-Topic: [PATCH 2/2] drm/amdgpu/display: navi1x copy dcn watermark clock
 settings to smu resume from s3
Thread-Index: AQHV7YYgrtvifOjtV0Ge4g/Lc3C3bKgv6n+wgAEucoCABEkwAIABf3KAgADmaYA=
Date: Wed, 4 Mar 2020 03:04:44 +0000
Message-ID: <MN2PR12MB3344F3D3020BB3A002274DA3E4E50@MN2PR12MB3344.namprd12.prod.outlook.com>
References: <20200227155349.10993-1-hersenxs.wu@amd.com>
 <MN2PR12MB33448440496BD112CE52820BE4E80@MN2PR12MB3344.namprd12.prod.outlook.com>
 <MN2PR12MB38404E1958870D36B236B217FDE80@MN2PR12MB3840.namprd12.prod.outlook.com>
 <CADnq5_N3fn=oc=kWAfPThK0u9k8eNJv8EeiN0F8WTP_a6ChzNA@mail.gmail.com>
 <CH2PR12MB3831A01E4623264573AEC041FDE40@CH2PR12MB3831.namprd12.prod.outlook.com>
In-Reply-To: <CH2PR12MB3831A01E4623264573AEC041FDE40@CH2PR12MB3831.namprd12.prod.outlook.com>
Accept-Language: en-US, zh-CN
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
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Evan.Quan@amd.com; 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2eb3d544-4062-4ff8-cae6-08d7bfe8cab4
x-ms-traffictypediagnostic: MN2PR12MB3551:|MN2PR12MB3551:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB35515E40495931A54754EF70E4E50@MN2PR12MB3551.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0332AACBC3
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10001)(10009020)(4636009)(136003)(366004)(376002)(346002)(39860400002)(396003)(199004)(189003)(9686003)(26005)(71200400001)(5660300002)(8676002)(81166006)(81156014)(55016002)(316002)(186003)(53546011)(66446008)(66946007)(54906003)(66476007)(76116006)(66556008)(64756008)(45080400002)(478600001)(86362001)(6506007)(7696005)(966005)(52536014)(4326008)(33656002)(8936002)(110136005)(2906002)(32563001)(357404004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3551;
 H:MN2PR12MB3344.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5zp0X0FGqoHbHdwYfqWB6UpHA3UgQqyYLvU/32weA3MxVXvGg5lhhQeRM8S1GXK5xrOw5YXdX0MJnKiuUUmJUVk6OXQkzrCTR3F2jj+YhIPiy9UCNqXbO16NnDymWgcW+t1SrJtUYaWwNod3bdCQs0YBuehJ4PWHlS2m28rUj2CR7R4Xoh1f28qFKNhCc9RNFXxCwXVIgUkfyhdq39ajgn2RqidGMzxPtJXH4VnU4jW5rP/ZN638YvL6NAsrQvbvCNlJJpbKk7wvCKq9jYPuTIZEaakHS2iQKPgYI1JF/M/YvjvnS68CRLVi9ToYrlUcS6r8P3tFEAfkFoofkRm4hYCyJ6I34nkEiX/9R2/nUvdqRKvXUQ6Gl4phwTOckigJOsNa+if2v4a72V3isj5Qhr5E6w2hSX33WucdIRhQMxKKb3eVY7DyLrNo2bwCvfSFAM7T/gfUUqcOssujOiNyIEnbvL0xPC1vRmL7qViZSlS/E0z6RNgPwRNMCj3306MZZQp7qQM3Q0Ul9dQhqruG0C4F+n5Trh7k87IXrgkPk2IhVhyIs5h8J3ZUjNu/1gLsdFTZ8Cgr22IDu5dvloDAjqLT76k5BsxIWRUTqqksrOZ94awJL6UpCK214EBasbbC+xP+RYg3otqFBOZKPmqvzJOt8YhzhwTbGH0ydpzKRJxwgPI0jWJKyIXCLM0lnijQ3opBf3jUJYgtkWN0Q35HQQ==
x-ms-exchange-antispam-messagedata: hKM8Btl3qOEEbDUGyx6o+MMbxaCgkk+ImgkkC1Mk5y4K//OeXZpwcHfXYlVesoMDrX3vYoOZDmxtBHApmnPwdezhT2Zo3vJz0hGHeXnFnqsmrz1iXBT+lxkOz+A+FyZQR4Yar+WRdDCnav+eA01BPQ==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2eb3d544-4062-4ff8-cae6-08d7bfe8cab4
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2020 03:04:44.9359 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jBOXxTveQpY0EK2xzrxjuxJB/UhxCEuvXSGlzfSxzkr7pZeR77ba4/J+Ev1ByyRw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3551
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
Cc: "Feng, Kenneth" <Kenneth.Feng@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Sorry for miss this. With the Alex's comment addressed, the patch is reviewed-by: Evan Quan <evan.quan@amd.com>

-----Original Message-----
From: Wu, Hersen <hersenxs.wu@amd.com> 
Sent: Tuesday, March 3, 2020 9:19 PM
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Quan, Evan <Evan.Quan@amd.com>; amd-gfx@lists.freedesktop.org; Feng, Kenneth <Kenneth.Feng@amd.com>
Subject: RE: [PATCH 2/2] drm/amdgpu/display: navi1x copy dcn watermark clock settings to smu resume from s3

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
> This interface is for dGPU Navi1x. Linux dc-pplib interface depends on 
> window driver dc implementation.
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
>  dc_hardware_init / dc_set_power_state  dcn10_init_hw notify_wm_ranges  
> set_wm_ranges
>
>  For Linux
>  smu_set_watermarks_for_clock_ranges
>  renoir_set_watermarks_table
>  smu_write_watermarks_table
>
>  dc_hardware_init -> amdgpu_dm_init
>  dc_set_power_state --> dm_resume
>
>  therefore, linux dc-pplib interface of navi10/12/14 is different from 
> that of Renoir.
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
>  dc_hardware_init / dc_set_power_state  dcn10_init_hw notify_wm_ranges  
> set_wm_ranges
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
