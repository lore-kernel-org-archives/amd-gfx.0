Return-Path: <SRS0=i8pd=27=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 379B0C33C99
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jan 2020 06:38:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E6A920721
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jan 2020 06:38:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="jUKYIewS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E6A920721
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C1CE36E98F;
	Fri, 10 Jan 2020 06:38:24 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20626.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::626])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2B8856E98F
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jan 2020 06:38:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RDehbxyxy1GxVx3m7xij1HIm/MtTKWKRDijQknDv5NjOgsxAJ81/VHx5FaDvsjfxw4n8LOpVcCulIQ0n1HlXOZ+tkwFd0tMxlxHQ9CeJpRtkgDhm4PP/00FXm87mnwwoyFMiiDA/qrKqkCoiRvrvyjnV6OdZF/esIEXMuaIuGbCVsrbHHmfWasBdSC5DSFF3itI/wHZbkTnQsRhxwJ4Y8v2ucQhBmcYpFu1uaWopoxnmph1H+hfRfjClhBWkyEiF5QDeH6541i1PQp+slDYphnQoFn7jIWqFaNp0E4xVUIEv7nH22yxa/FvDCBQXViaAmlm1ApZzgr/WtbGNUkdAVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a7Q72OOiHEbZsYjs8j8yIxI+fFaoSZOZfOLZ294HLjs=;
 b=PeC+OhLSDA6zYJ7ZJdlV+wnAenxWo3wD0hOZdU6TDVxI5F0pYJr4koFUTu6S71GOgkjkKf2g9D9I5jYPjJ76SgzAlKXuGetGsbD7BPcCcikqlvZlHgcJxoyaqxAWZ+IA8JFAvroCAiXiE6qplUWe+Xxmq7J0UsktE3qtZ7HXOy1o3oNO2rJZ7/FKR5L4Jivu3wlVdsQhdTFOFIeNVyDtZ4KganCTX/pPlvMVlK2AtXlYsg4WzeqghBmksPlWsFqS2Rqtgr7IJOik0nujVlHqQE5qfXK6g2E2jU9XTf7D2HGHULQWKOh/JUoWa4oBf48VkBDUZSiS55Ps76tS/vATjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a7Q72OOiHEbZsYjs8j8yIxI+fFaoSZOZfOLZ294HLjs=;
 b=jUKYIewSR20gejpn32Gcba8qmj7lK1hPKrOXXKrVRmobqGQ3DHDnbk68lOGlPVwNnm0pqc1FB+Sd/P2aB87Wc1pg6ooxaGpDTzSrgFZcEpIvY7NIEpBXGaHeNvz+Qp/6a1gGdBK4LZYLumiMotTugj2JS2EFBirhuHvG7O2eff0=
Received: from MN2PR12MB3344.namprd12.prod.outlook.com (20.178.241.74) by
 MN2PR12MB3053.namprd12.prod.outlook.com (20.178.241.216) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2602.15; Fri, 10 Jan 2020 06:38:22 +0000
Received: from MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::1010:4621:68dd:5b47]) by MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::1010:4621:68dd:5b47%5]) with mapi id 15.20.2623.013; Fri, 10 Jan 2020
 06:38:22 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/1] drm/amdgpu: Fix kernel oops in
 amdgpu_dpm_switch_power_profile
Thread-Topic: [PATCH 1/1] drm/amdgpu: Fix kernel oops in
 amdgpu_dpm_switch_power_profile
Thread-Index: AQHVx3s2bQYAeJ8wJEyROm3kuGkWSqfjcf2w
Date: Fri, 10 Jan 2020 06:38:21 +0000
Message-ID: <MN2PR12MB3344841A25043A15FEC022E4E4380@MN2PR12MB3344.namprd12.prod.outlook.com>
References: <20200110055933.28218-1-Felix.Kuehling@amd.com>
In-Reply-To: <20200110055933.28218-1-Felix.Kuehling@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=50866771-bc6b-4ae0-b5a6-000013bd563d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-01-10T06:37:50Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Evan.Quan@amd.com; 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: db2f2aa4-4cee-430e-9f06-08d79597b00e
x-ms-traffictypediagnostic: MN2PR12MB3053:|MN2PR12MB3053:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB3053A7CF764AF64FF4717950E4380@MN2PR12MB3053.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 02788FF38E
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(136003)(396003)(376002)(346002)(366004)(189003)(199004)(13464003)(51914003)(66476007)(33656002)(76116006)(2906002)(64756008)(66556008)(66946007)(5660300002)(66446008)(110136005)(6506007)(53546011)(86362001)(316002)(7696005)(478600001)(52536014)(186003)(26005)(8676002)(71200400001)(81156014)(81166006)(8936002)(9686003)(55016002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3053;
 H:MN2PR12MB3344.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HO7SH2ropBDwBi53mMqLEPhqwtJHGBPKswZL14K1YoNJU9bxMDMgkSFuWCW7QViuQepExzBQUMLMlgarwMbX8I9xGroCYg2mV+vy/WPNYBCl7J3/9OV1hJNiKsiuwoAJAMYMSmX7Z8lDAPkokQBJ08EpMfo5H+SXbt0huydVdRLagNYJww7UiDgi7t0zZ9EQ/LQKf//GT1SzC8HsWUqbXG1fazQBB+2p7iXiPq+2URdCCCEuvOuxxVO6YZeDd/6qWcoF+4SQV1a9SnM60f9K8Q6Dbi/QSiGSyV90lulfWe+ROZP3yx+/LW50iwna26Mf+YhpBfUG8tW/T7+yxySNKxEH8SVCrcpG+fJLj0UUHtGPZN4U+gWQPq2OoeZ8t6iTOxvSluHQ+4k94tI45CS2orE+Jm9djTehkLb6FoS1WgsdwjK+MuaI84wu7CAjZXUncUh5FRA/2RcWeamlKc/81pZQv28Zs45CTHCr0r0+6uxBcmeOAFi04+nGkaVW98fVMqmyvhh/ungnSkKHiNv1hg==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db2f2aa4-4cee-430e-9f06-08d79597b00e
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jan 2020 06:38:22.1283 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aYaxuNPHSXy8G3W+mGSaKMm530VoTFsr3RAEGuxqbvZnOkUhpUQHfJ1hklM98qO9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3053
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

Thanks for the fix.
Reviewed-by: Evan Quan <evan.quan@amd.com>

> -----Original Message-----
> From: Kuehling, Felix <Felix.Kuehling@amd.com>
> Sent: Friday, January 10, 2020 2:00 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Quan, Evan <Evan.Quan@amd.com>
> Subject: [PATCH 1/1] drm/amdgpu: Fix kernel oops in
> amdgpu_dpm_switch_power_profile
> 
> Pass the correct pp_handle to pp_dpm_switch_power_profile.
> 
> Fixes: 9bbdc6e48ec0 ("drm/amd/powerplay: cover the powerplay
> implementation details V2")
> Change-Id: Ia6998a836815c274509bd7967c1c148475252fa6
> Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.c
> index f7c0ae6e0f8c..6c7dca1da992 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.c
> @@ -1123,7 +1123,8 @@ int amdgpu_dpm_switch_power_profile(struct
> amdgpu_device *adev,
>  		ret = smu_switch_power_profile(&adev->smu, type, en);
>  	else if (adev->powerplay.pp_funcs &&
>  		 adev->powerplay.pp_funcs->switch_power_profile)
> -		ret = adev->powerplay.pp_funcs->switch_power_profile(adev,
> type, en);
> +		ret = adev->powerplay.pp_funcs->switch_power_profile(
> +			adev->powerplay.pp_handle, type, en);
> 
>  	return ret;
>  }
> --
> 2.24.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
