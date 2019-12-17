Return-Path: <SRS0=JueS=2H=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23785C43603
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Dec 2019 04:12:06 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E061E2176D
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Dec 2019 04:12:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="hxIe2fDa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E061E2176D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 926BD6E938;
	Tue, 17 Dec 2019 04:12:05 +0000 (UTC)
Received: from NAM04-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr680051.outbound.protection.outlook.com [40.107.68.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 78C9F6E938
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Dec 2019 04:12:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jSyhZDMnlfXq+XofL/iGMsBCdQ6yvtxSaB4Jy2tsf8Ee/Dtig/t6zrgSaJtzxb4QeN1/Fp6EoUJysfc9lJEZscBqmqIL2HHMJKhj9oD+KCOBtOEJhMRkhpgb3Oa4MP7NopDTNtfr2rsqqNHqe1VyFwbGYgwc0fBYUGfnbHzYFumGA1auVOqQ8uN1FtI31BQIpCjkfbTBX1jWAQrXzE489tJvb3ld9CfuKJly4jh75PqoH4hnkdLWqsTOL/EpYSGk5gRjtYDlZVlDtnIEOpZo8RyUEMKprle8rtnhj+fEo2xe7TDYywCfjFiEIFqJVKChkgbxsx1bsfssU4Lv55s1AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6IWrEIcjWQs9kSYv1+mlsqMa9kKKJ9WygkS9U+79V7k=;
 b=J4OSQEHPQXXmGHMSM4zuTIgNsC4KrrjGfXrz5Jo7ll4/8RlmvUiyHDM5AfbWqC1TRDRC/Q5VRqynEdENZI7Uf8x1hhmUK4x7QdNdZ0pLdRquhJzkddvqcJ2YUsdtbJOZ+ag900PeBa4Vg5LM/ZQCMMxeihYjrbkh3hBS5u/txVTVyc9mEtOXtUG5Y6OUQF0MYStZa6xyxWTLlYm/IEYQnBVnJ4kpWwl3G95TANPNnskAV01A7oNCnbqucGRSxiXbx6JWguer7ABMG3diyHYDYydLzJMZprPDjaIzkv2ItLTDYsQmhkCVvsTDwPUZcB7GFvfK+bkdkHTm66Q45rfhCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6IWrEIcjWQs9kSYv1+mlsqMa9kKKJ9WygkS9U+79V7k=;
 b=hxIe2fDayslYh6cinWH6flizIr3ym6VZhwq1Hq5RNlh49RHi7obvMavaMBPKy+F8K/xDYH7c3mQC1xFUbnemDJBk6mPKY9u6hQqCeTruzzYg8vqNUAxBOV/bm3MUN/kWNTG7WRs50gGGXMdg97/A0UKGgjCdyCA7Yxo4F6NDM+w=
Received: from BN8PR12MB3329.namprd12.prod.outlook.com (20.178.208.93) by
 BN8PR12MB3297.namprd12.prod.outlook.com (20.179.65.209) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.18; Tue, 17 Dec 2019 04:12:02 +0000
Received: from BN8PR12MB3329.namprd12.prod.outlook.com
 ([fe80::d5ed:d8ec:ae3b:2482]) by BN8PR12MB3329.namprd12.prod.outlook.com
 ([fe80::d5ed:d8ec:ae3b:2482%7]) with mapi id 15.20.2538.019; Tue, 17 Dec 2019
 04:12:02 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu/smu: fix spelling
Thread-Topic: [PATCH] drm/amdgpu/smu: fix spelling
Thread-Index: AQHVtEy1ePObVFBahUOZkn5Y8FBHGqe9t42g
Date: Tue, 17 Dec 2019 04:12:01 +0000
Message-ID: <BN8PR12MB3329A7BB996F4B8DC69FA4ABE4500@BN8PR12MB3329.namprd12.prod.outlook.com>
References: <20191216200859.314406-1-alexander.deucher@amd.com>
In-Reply-To: <20191216200859.314406-1-alexander.deucher@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=bd8772cd-460d-4ec6-8835-000051197ee7;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2019-12-17T04:11:38Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Evan.Quan@amd.com; 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 23e6b4a7-901f-4c25-f9bd-08d782a744c9
x-ms-traffictypediagnostic: BN8PR12MB3297:|BN8PR12MB3297:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN8PR12MB32976F963FC99F457AECB4F4E4500@BN8PR12MB3297.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:196;
x-forefront-prvs: 02543CD7CD
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(376002)(366004)(346002)(136003)(39860400002)(189003)(13464003)(199004)(45080400002)(966005)(66556008)(2906002)(66476007)(33656002)(86362001)(478600001)(7696005)(4326008)(66446008)(76116006)(64756008)(8936002)(66946007)(9686003)(6506007)(316002)(81156014)(81166006)(5660300002)(26005)(186003)(8676002)(71200400001)(52536014)(55016002)(110136005)(53546011);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BN8PR12MB3297;
 H:BN8PR12MB3329.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BHN3IXPxCrX/9iuLRlM12/TmaXe5v3YsNR2ogGQ6k4STEoXbV2T/klzzAP6JrvggcKMTBnLUULzYcUu0KpuaxnA1DTK1TDTDqNgIS9QzfV1UaIMjGxbo/wTLI32di31pDaCdi+FFZUSRX5Rfs0H9Tmq0mze6noeRqNxLJCla55o3e0XAIRJXWwUX26hpbhSLxg5gfYpAG8426huTHcQ6O4lrqsutZhJ+WZu4GUvCVWjMYmM/DJ7cFqPXQi0ZcuCe/OMj1YbTyeeXbkdO5G+JFfpN56g2Y6O9CZ6yMpB5gw0ySQ4/3+3F/TQPyTAPGZcYUX7J37woXtyCtl7yaSgiCFG/tgplh0KbT8bMJ5sPa6XZHsj/OTZ4D23A7jVZDONLAojDk85qP6QIhjq54F+Yo55ZLcrvhT2XigqRz2U1DwCf1pu3PxvBGT4ab0nZ6o5UWnOg2S8Gyb7Lfw//YSykZEiGQBJrkTYydiNPqI8xZShxSKssmsRn0Ws7P+SI5uP1MX66XemadtbKMKF9wV0CIQb4zLBRrpw+jk+b8zxQZ4I=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23e6b4a7-901f-4c25-f9bd-08d782a744c9
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Dec 2019 04:12:01.9812 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KRseoE10wQi3sy42NevJRQxQ/vY1ks0N50oCZ0FVTivnp0alHZ8fjIX2F/SQLjMN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3297
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Reviewed-by: Evan Quan <evan.quan@amd.com>

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex
> Deucher
> Sent: Tuesday, December 17, 2019 4:09 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
> Subject: [PATCH] drm/amdgpu/smu: fix spelling
> 
> s/dispaly/display/g
> 
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/powerplay/amdgpu_smu.c     | 2 +-
>  drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h | 2 +-
>  drivers/gpu/drm/amd/powerplay/navi10_ppt.c     | 4 ++--
>  drivers/gpu/drm/amd/powerplay/smu_internal.h   | 4 ++--
>  drivers/gpu/drm/amd/powerplay/vega20_ppt.c     | 4 ++--
>  5 files changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> index 6dddd7818558..f76a1717ffbd 100644
> --- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> @@ -1670,7 +1670,7 @@ int smu_adjust_power_state_dynamic(struct
> smu_context *smu,
>  	}
> 
>  	if (!skip_display_settings) {
> -		ret = smu_notify_smc_dispaly_config(smu);
> +		ret = smu_notify_smc_display_config(smu);
>  		if (ret) {
>  			pr_err("Failed to notify smc display config!");
>  			return ret;
> diff --git a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
> b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
> index ca3fdc6777cf..a7d0ad831491 100644
> --- a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
> +++ b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
> @@ -443,7 +443,7 @@ struct pptable_funcs {
>  	int (*pre_display_config_changed)(struct smu_context *smu);
>  	int (*display_config_changed)(struct smu_context *smu);
>  	int (*apply_clocks_adjust_rules)(struct smu_context *smu);
> -	int (*notify_smc_dispaly_config)(struct smu_context *smu);
> +	int (*notify_smc_display_config)(struct smu_context *smu);
>  	int (*force_dpm_limit_value)(struct smu_context *smu, bool highest);
>  	int (*unforce_dpm_levels)(struct smu_context *smu);
>  	int (*get_profiling_clk_mask)(struct smu_context *smu, diff --git
> a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
> b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
> index 15403b7979d6..7b42e72dc939 100644
> --- a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
> +++ b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
> @@ -1374,7 +1374,7 @@ static int navi10_get_profiling_clk_mask(struct
> smu_context *smu,
>  	return ret;
>  }
> 
> -static int navi10_notify_smc_dispaly_config(struct smu_context *smu)
> +static int navi10_notify_smc_display_config(struct smu_context *smu)
>  {
>  	struct smu_clocks min_clocks = {0};
>  	struct pp_display_clock_request clock_req; @@ -2047,7 +2047,7 @@
> static const struct pptable_funcs navi10_ppt_funcs = {
>  	.get_clock_by_type_with_latency =
> navi10_get_clock_by_type_with_latency,
>  	.pre_display_config_changed = navi10_pre_display_config_changed,
>  	.display_config_changed = navi10_display_config_changed,
> -	.notify_smc_dispaly_config = navi10_notify_smc_dispaly_config,
> +	.notify_smc_display_config = navi10_notify_smc_display_config,
>  	.force_dpm_limit_value = navi10_force_dpm_limit_value,
>  	.unforce_dpm_levels = navi10_unforce_dpm_levels,
>  	.is_dpm_running = navi10_is_dpm_running, diff --git
> a/drivers/gpu/drm/amd/powerplay/smu_internal.h
> b/drivers/gpu/drm/amd/powerplay/smu_internal.h
> index 60ce1fccaeb5..77864e4236c4 100644
> --- a/drivers/gpu/drm/amd/powerplay/smu_internal.h
> +++ b/drivers/gpu/drm/amd/powerplay/smu_internal.h
> @@ -129,8 +129,8 @@ int smu_send_smc_msg(struct smu_context *smu,
> enum smu_message_type msg);
>  	((smu)->ppt_funcs->display_config_changed ? (smu)->ppt_funcs-
> >display_config_changed((smu)) : 0)  #define
> smu_apply_clocks_adjust_rules(smu) \
>  	((smu)->ppt_funcs->apply_clocks_adjust_rules ? (smu)->ppt_funcs-
> >apply_clocks_adjust_rules((smu)) : 0) -#define
> smu_notify_smc_dispaly_config(smu) \
> -	((smu)->ppt_funcs->notify_smc_dispaly_config ? (smu)->ppt_funcs-
> >notify_smc_dispaly_config((smu)) : 0)
> +#define smu_notify_smc_display_config(smu) \
> +	((smu)->ppt_funcs->notify_smc_display_config ?
> +(smu)->ppt_funcs->notify_smc_display_config((smu)) : 0)
>  #define smu_force_dpm_limit_value(smu, highest) \
>  	((smu)->ppt_funcs->force_dpm_limit_value ? (smu)->ppt_funcs-
> >force_dpm_limit_value((smu), (highest)) : 0)  #define
> smu_unforce_dpm_levels(smu) \ diff --git
> a/drivers/gpu/drm/amd/powerplay/vega20_ppt.c
> b/drivers/gpu/drm/amd/powerplay/vega20_ppt.c
> index 12bcc3e3ba99..2b1c3f8a0415 100644
> --- a/drivers/gpu/drm/amd/powerplay/vega20_ppt.c
> +++ b/drivers/gpu/drm/amd/powerplay/vega20_ppt.c
> @@ -2232,7 +2232,7 @@ static int vega20_apply_clocks_adjust_rules(struct
> smu_context *smu)  }
> 
>  static int
> -vega20_notify_smc_dispaly_config(struct smu_context *smu)
> +vega20_notify_smc_display_config(struct smu_context *smu)
>  {
>  	struct vega20_dpm_table *dpm_table = smu->smu_dpm.dpm_context;
>  	struct vega20_single_dpm_table *memtable = &dpm_table-
> >mem_table; @@ -3200,7 +3200,7 @@ static const struct pptable_funcs
> vega20_ppt_funcs = {
>  	.pre_display_config_changed = vega20_pre_display_config_changed,
>  	.display_config_changed = vega20_display_config_changed,
>  	.apply_clocks_adjust_rules = vega20_apply_clocks_adjust_rules,
> -	.notify_smc_dispaly_config = vega20_notify_smc_dispaly_config,
> +	.notify_smc_display_config = vega20_notify_smc_display_config,
>  	.force_dpm_limit_value = vega20_force_dpm_limit_value,
>  	.unforce_dpm_levels = vega20_unforce_dpm_levels,
>  	.get_profiling_clk_mask = vega20_get_profiling_clk_mask,
> --
> 2.23.0
> 
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.free
> desktop.org%2Fmailman%2Flistinfo%2Famd-
> gfx&amp;data=02%7C01%7Cevan.quan%40amd.com%7C6d2832e1dbb641656e
> 9808d78263d06c%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637
> 121237626177402&amp;sdata=QPVaM%2Bcv3Mwql5VXrEzZy%2BHJyZh%2FZ1
> 8DwwmcWko9FHQ%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
