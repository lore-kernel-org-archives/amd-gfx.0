Return-Path: <SRS0=i8pd=27=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDF15C32771
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jan 2020 03:15:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B47320673
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jan 2020 03:15:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="eqEMIz6o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B47320673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1EBE289CAD;
	Fri, 10 Jan 2020 03:15:16 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2064.outbound.protection.outlook.com [40.107.94.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F283589C88
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jan 2020 03:15:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i4vLUIsPR4HaUjFXNyKGEMukzGB2F+d1lQVRzRIWdxifkME2FERoPdPaUuMs+C8SZLRtvLPAxzoH37oL0CmwJmofPxFvGPi9jFb6goEinCJYrizfOe+GGCjLxyK43A5C17qDRU/MNjb8u5gDpxjwpL8D4Hx+x/LPv9pkF6H1YaBHt3Q+Qa0ixTLPzwEqpKfgMJkIWtlU2gYVm31sLqVgGfRdISRO1kJ1YZ8V63hJk1XdEJw6ZcUEIfY0cdcKZ2T2Z6ZQLbcia5YVsnGTZxEgwITzn1OKy06VkWm2cbZtM2YKIOBi8FKyEBQ7itfYDh/Y4UYRSqTgGYcR1WsYHOiqyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=meMEd24bNRqMZngBXp4neMBP0xnGNhdYPQbV2DeHpYI=;
 b=DVHrsKTwiOwxyNRhPwanKCxNRpoIMg2co+RSmmqvcOcRB4g4mhTT10tvDqWOSwQYoenfm9Uy1etdqMPHe0IEmEasfYLdoVtN6Nn1//h+WF8/L/Hnx49LV6MKhDjyvDD2zBGJJbk+VuSggyw/Wv4yxdv7sjqIoxU6v0+g7J+1f2p/kH/FpcUIg2InxUjVmP7fsy7WuGEJUDwrjDieb+G36g32qcprNYzfa8RorCjbek4Od32wJWJKPdz8zWOpn5Ohu0OqLWzchr9fgvaOVJviJzORCbSo4klNV/ovN60clY1/tV4OcOtHePINSEmyMHShfC2gO4eqD74xA2b27opnMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=meMEd24bNRqMZngBXp4neMBP0xnGNhdYPQbV2DeHpYI=;
 b=eqEMIz6ocyvu7dZ/tFIyhXPAD3aD6CrB9+CtugKzUpp5OnLFSmbQmJ0WNN0RbDRX1Lxi3RDM5K5DyPkt3Saey/Z1avb2A0uXtnumbAl4mDbtlPvJuSU+nigLVV3lxealoyJqJeOSRU8UUHdARvKRXAtVXTvXlTiWY7OF+ne+Dws=
Received: from MN2PR12MB3344.namprd12.prod.outlook.com (20.178.241.74) by
 MN2PR12MB3680.namprd12.prod.outlook.com (10.255.238.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.9; Fri, 10 Jan 2020 03:15:08 +0000
Received: from MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::1010:4621:68dd:5b47]) by MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::1010:4621:68dd:5b47%5]) with mapi id 15.20.2623.013; Fri, 10 Jan 2020
 03:15:08 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu/powerplay: fix warning in smu_v11_0.c
Thread-Topic: [PATCH] drm/amdgpu/powerplay: fix warning in smu_v11_0.c
Thread-Index: AQHVxy217mTFZ485002JoBtS2krpaqfjOeXA
Date: Fri, 10 Jan 2020 03:15:08 +0000
Message-ID: <MN2PR12MB3344EB096AE902436576C5A2E4380@MN2PR12MB3344.namprd12.prod.outlook.com>
References: <20200109204436.1184619-1-alexander.deucher@amd.com>
In-Reply-To: <20200109204436.1184619-1-alexander.deucher@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=3c8dc3ee-bcb2-4cd8-ba54-000030654da6;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-01-10T03:14:54Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Evan.Quan@amd.com; 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 39c253d9-654a-4978-3e33-08d7957b4c35
x-ms-traffictypediagnostic: MN2PR12MB3680:|MN2PR12MB3680:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB3680BDDFD425DB2959897D2EE4380@MN2PR12MB3680.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:459;
x-forefront-prvs: 02788FF38E
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(366004)(39860400002)(346002)(376002)(396003)(13464003)(189003)(199004)(5660300002)(478600001)(45080400002)(8676002)(53546011)(7696005)(4326008)(26005)(6506007)(186003)(33656002)(81156014)(110136005)(66946007)(966005)(2906002)(81166006)(52536014)(55016002)(66446008)(71200400001)(76116006)(86362001)(64756008)(9686003)(66556008)(66476007)(316002)(8936002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3680;
 H:MN2PR12MB3344.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 37q+14HyypRMrzZRHPuxYAhmdk5940fTtvQO2C0C4qC8exXLwhkIjKrSbmBU4zUZkdFoTVUvXq/DTzGrTNuS1xHtbIc2/jTgzeAIqZTWqtGme5u6WQgJwhqSgW6fuwacwBka4vU2ro/FzTpIQ+CS7hMkgeIpArBLnazcgzXx97PND1PmubMYBQROwKi+w6dF6T9K68ZQn7DQ2UeINoPlc+b953IZ2ciPELG/d8fAKSpYQ72rLRBOhPyWonehaCRgSQVeHpyZayhOy+6VjdF0BKoJZm8N7gq/OGTGBO21gdNazDTDzlCNtijr2vaU2Qqb0vtktr2Stmw5jplQVkaPdv1l/xkLg/Hgb05R7V2nm2v6RVEUEQ2H06ExSsda9dFKi39rmRjOSDIWpT+olYMCWfT/nYcLP9KWXn89/ph9U1EjYGFvB9IuqtJKg06uwRqETqJDYoImuIGVJmpUdDB1rWYXPT34yx203asdnWI3iG+LQUtivQyVZUm0zPX0WMsJvpNvgXeLbJ/7g7ZzrVSXycNGBGnHqoDlyXAGlY2YU+E=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39c253d9-654a-4978-3e33-08d7957b4c35
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jan 2020 03:15:08.7278 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: M5+iOcxxBAGCsAilw3gwZ05s0XhlCmvwQCll3RT6ibMLoJofCZ5JPrJeHuWsw44Z
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3680
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
> Sent: Friday, January 10, 2020 4:45 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
> Subject: [PATCH] drm/amdgpu/powerplay: fix warning in smu_v11_0.c
> 
> Cast to make min() happy.  The values are well within
> range.
> 
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/powerplay/smu_v11_0.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
> b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
> index 76bddd582c60..02f8c9cb89d9 100644
> --- a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
> +++ b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
> @@ -1159,7 +1159,7 @@ static int smu_v11_0_set_thermal_range(struct
> smu_context *smu,
> 
>  	low = max(SMU_THERMAL_MINIMUM_ALERT_TEMP,
>  			range.min /
> SMU_TEMPERATURE_UNITS_PER_CENTIGRADES);
> -	high = min(SMU_THERMAL_MAXIMUM_ALERT_TEMP,
> powerplay_table->software_shutdown_temp);
> +	high = min((uint16_t)SMU_THERMAL_MAXIMUM_ALERT_TEMP,
> powerplay_table->software_shutdown_temp);
> 
>  	if (low > high)
>  		return -EINVAL;
> --
> 2.24.1
> 
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.free
> desktop.org%2Fmailman%2Flistinfo%2Famd-
> gfx&amp;data=02%7C01%7Cevan.quan%40amd.com%7C4672d7f3341f44a41fa
> 608d79544cd4e%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C6371
> 41995209778022&amp;sdata=TRtFdbV9rFibTHYzbpeFqo8nxMYMi%2Fk9mikRTf
> yDwaM%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
