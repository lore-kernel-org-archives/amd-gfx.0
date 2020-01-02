Return-Path: <SRS0=MtTs=2X=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47EFFC2D0DD
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Jan 2020 06:19:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16F432053B
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Jan 2020 06:19:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="mMi9wSSC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16F432053B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B741389C16;
	Thu,  2 Jan 2020 06:19:09 +0000 (UTC)
Received: from NAM04-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr680061.outbound.protection.outlook.com [40.107.68.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ED48889C16
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Jan 2020 06:19:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l8D/Yos4WgwCOEVAJcke0q6IrZqj+5oYwbhXxVzT6NWcDjN9G+JGSB8LeHcnNQceNdCugJ24EdU/0AGmSpZVqI0GfxnhpwV153ORPpCzJcydqE4fL5ocu4KbBkOHCeIh2gEL2uaahFqRuMzR5iTF1tG/DD96FmVmQg7DIoWBZZYTd1f8XMk1Q1K4fImZWXDBGxpsLhJgMbDV3CDAM7u4EsEbGO3p3NkwqMF4MgAACVsJwluWk3QjTkvSjWXIlOA3ah+Y153ulO+QbCmuDa16OBqycjPekCBXauwZ0IXENOMNaQW51kuofdLeKfkk7pImEr+u4LUGppqONTXTPZcX5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fIAzGkEiKHlttYffNmAlXphcGqe/uNbfymCfQa9drN4=;
 b=LtzRU9SnOzk6kEVOkZmn/+Ep9VJWFmWl2G2eiO4vt+DG16yVGIDGMN/JCnJpvLpO1EYEuv0K8OAFh/kLTdIwkj8d0od/DYEqcKdYxcnRvvqrZP28kPntnem48a/hRnf2nFiJCRvumRQ/fF7n7WRvBqKtl6kzuASweapmwlEr6ExdvjljxxWOSL5iCph/BA5ghleoqDlcHNyi9h8pEjvkCDdo4MFqGgJQIXpMDkmT8scU331XszcUPL91R4UW88Ih3KrVdqTkoJD37JfhmtkZRrG/+vX7e2Mbs4UoUAj2GLaAxvMResxpmG6VIMih+AExvJfwSMF+H/8d9ZCwQ2rKDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fIAzGkEiKHlttYffNmAlXphcGqe/uNbfymCfQa9drN4=;
 b=mMi9wSSCR+0YrwiUYf72oOR7fZ7m8Tlt60ABhPDQXJ61R8xM2kmxTPj9+q4Re3yPgP8krbzhVDp01kOt7KTMLc27XxvTad5FQ+y0PxXGfQNew0Qy/pNQtBpFmhsOlqigjZZp/bsIKJMMcEROeQWdHXtPXRRahDksmTgkEmHPGHs=
Received: from MN2PR12MB3344.namprd12.prod.outlook.com (20.178.241.74) by
 MN2PR12MB3805.namprd12.prod.outlook.com (10.255.86.92) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2602.12; Thu, 2 Jan 2020 06:19:07 +0000
Received: from MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::1010:4621:68dd:5b47]) by MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::1010:4621:68dd:5b47%5]) with mapi id 15.20.2602.010; Thu, 2 Jan 2020
 06:19:07 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Zhang, Jack (Jian)" <Jack.Zhang1@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/2] amd/amdgpu/sriov tdr enablement with pp_onevf_mode
Thread-Topic: [PATCH 2/2] amd/amdgpu/sriov tdr enablement with pp_onevf_mode
Thread-Index: AQHVwTCu0iulcskBzUKshz2GzSgAsKfW5pUA
Date: Thu, 2 Jan 2020 06:19:07 +0000
Message-ID: <MN2PR12MB33446F4420A7AB2A0C29C3E0E4200@MN2PR12MB3344.namprd12.prod.outlook.com>
References: <1577944273-32245-1-git-send-email-Jack.Zhang1@amd.com>
In-Reply-To: <1577944273-32245-1-git-send-email-Jack.Zhang1@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=5e3638e6-e48b-446a-bd30-00001d37edb1;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-01-02T06:18:44Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Evan.Quan@amd.com; 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ac8cf207-cf15-4873-db28-08d78f4bac88
x-ms-traffictypediagnostic: MN2PR12MB3805:|MN2PR12MB3805:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB3805EBDE1FCE68A4AB140BEAE4200@MN2PR12MB3805.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:510;
x-forefront-prvs: 0270ED2845
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(136003)(366004)(39860400002)(376002)(396003)(189003)(199004)(13464003)(4326008)(5660300002)(6506007)(52536014)(53546011)(8936002)(81166006)(81156014)(9686003)(55016002)(7696005)(66556008)(64756008)(66476007)(66446008)(86362001)(76116006)(316002)(110136005)(66946007)(478600001)(45080400002)(966005)(2906002)(8676002)(71200400001)(26005)(33656002)(186003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3805;
 H:MN2PR12MB3344.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8NWzY7w7Ahm8qQk0mOB5bQXlGP018arviGCzCy2AKdKuUw5Yn3Z01/g4haxlCZkb/JHKq7yKlvauX89A3cRskYtqcBPEI1EaDuGifAI60eVdFEusT759JfX1hnEdy0N3eNb1qgWg7ggpfSCxbx65hm1jkfb3FsvUUFliJeQiVxTklvFhujDPWJhK6U1nRcgcCkAg2QNQHO6bRUhyY2rZSyvo/NxVjXC7Fs9w2r2y4TJlZ6mn5Sx89PcjBVKapDK/at7Clb5lGkIMIbOhQM8/phdmqUdvUZog9dVZUtx7jHzFFKDVhk3SQaPovI7h1E2P0xOnfxvc8Uko2pmn58QBRDwX++Wezca3/BO2Goydb4Hilpyz/Vc8ICXq6xFVYq6l/mmlz3QHyVY/XVv1frv+Vgpz/+WmRLS+F+Ke0S5+V3Mew5R9PHOB4V4WhxtlYTM0YQ1HSXMt8j8kivHxb6dUUYULr+OUfdlP4U4Q2Uy6gUOVyIsRX3eag+SFDwH+fBSJTC3xhbkOP8G7reASh9RyvGKi4Esq8moycY+aY8XFHZg=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac8cf207-cf15-4873-db28-08d78f4bac88
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jan 2020 06:19:07.4824 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: c1pJdNmcOWhHPf8rcuBSTe8Og0h7hIS7njynSSYGFUyLw5UO6bcTkPPRyLQjzxzV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3805
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
Cc: "Zhang, Jack \(Jian\)" <Jack.Zhang1@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Acked-by: Evan Quan <evan.quan@amd.com>

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Jack
> Zhang
> Sent: Thursday, January 2, 2020 1:51 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Zhang, Jack (Jian) <Jack.Zhang1@amd.com>
> Subject: [PATCH 2/2] amd/amdgpu/sriov tdr enablement with pp_onevf_mode
> 
> Under sriov and pp_onevf mode,
> 1.take resume instead of hw_init for smc recover to avoid
> potential memory leak.
> 
> 2.add return condition inside smc resume function for
> sriov_pp_onevf_mode and pm_enabled param.
> 
> Signed-off-by: Jack Zhang <Jack.Zhang1@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 6 +++++-
>  drivers/gpu/drm/amd/powerplay/amdgpu_smu.c | 6 ++++++
>  2 files changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index bdd9502..f003e9a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -2462,7 +2462,11 @@ static int
> amdgpu_device_ip_reinit_late_sriov(struct amdgpu_device *adev)
>  				block->status.hw)
>  				continue;
> 
> -			r = block->version->funcs->hw_init(adev);
> +			if (block->version->type == AMD_IP_BLOCK_TYPE_SMC)
> +				r = block->version->funcs->resume(adev);
> +			else
> +				r = block->version->funcs->hw_init(adev);
> +
>  			DRM_INFO("RE-INIT-late: %s %s\n", block->version-
> >funcs->name, r?"failed":"succeeded");
>  			if (r)
>  				return r;
> diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> index fa17265..2e4a8d2 100644
> --- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> @@ -1420,6 +1420,12 @@ static int smu_resume(void *handle)
>  	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>  	struct smu_context *smu = &adev->smu;
> 
> +	if (amdgpu_sriov_vf(adev)&& !amdgpu_sriov_is_pp_one_vf(adev))
> +		return 0;
> +
> +	if (!smu->pm_enabled)
> +		return 0;
> +
>  	pr_info("SMU is resuming...\n");
> 
>  	ret = smu_start_smc_engine(smu);
> --
> 2.7.4
> 
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.free
> desktop.org%2Fmailman%2Flistinfo%2Famd-
> gfx&amp;data=02%7C01%7Cevan.quan%40amd.com%7C510c8150ee8c4c48b2
> d808d78f47cc1e%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637
> 135410904680615&amp;sdata=xmMYgHzXPQGykGDvTGvPrZX2W5yfOS3nOkNh
> AF%2FQYQY%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
