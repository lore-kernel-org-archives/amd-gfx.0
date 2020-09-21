Return-Path: <SRS0=OtMv=C6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F281C4363C
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Sep 2020 20:47:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B45B216C4
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Sep 2020 20:47:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="J/p7wWwZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B45B216C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 33A0A6E079;
	Mon, 21 Sep 2020 20:47:54 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2060.outbound.protection.outlook.com [40.107.220.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A385C6E079
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Sep 2020 20:47:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J0tG/QlbmuADuWuVTTFDgDpcnbHRyh4YxbUgsmOGjoipl2YVwDUn5ucZm6n8fxeZDJSHYDTgbge5cdJDDdyMxD9AbsOAw1o7xV3Ckme0icCZFzp4AT0AYos933j4UVGAQiKRKfoAkRv7UYbnzOi2UqszwshhwzTNYx+aCSXR/kSdIKgM+B9WKq3uImKAPSlYL4/tj1kFXghwkP/+flbVf/chnIsbVBTOfZz/Wjof1m19WVqkCVL2dNj0mSso9dk4BpKbaieiEqDfvnfQ/CxcNR3+yuCQcZjU9rmkMoSFNS/xEM/0bGWtYlwq/L3oQYoMcuAv+pxI9eVax7RHD/8ZMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TEchlc9ebbyr/b+niOt6WA36aZPPKHP84u1Gv0diJ14=;
 b=L2mlG+GtVf0dlVWrTvlg3dqK4nyfdf+rAmzn/H0/oWKd3yZvyI8BTubaJbbfhznivC5HIhS76/up8A+XNjmE+C0lPov1VXha9kPmY5w/23EGqUI0A9FjSabsMBjS8yW9JO4glC5kpLInvoxRD1up1X0b9CQXD/8ZkriEsfmFpiVlLr0/YkaNg9lT7KTVriJ4OiwZJY7WCMAw4rlHcDF+/V1brMA9+rYt5pDas7P4TVKuKaUpTzD6ZUiR+vIEk+RFk76ZxPUFh267gi38YRknF7ZCNOvRmU+O06/XUNbjxpwjbSVyEny1i4NWFbkbF+t1JE3YMCfozUywk+xNmTaQIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TEchlc9ebbyr/b+niOt6WA36aZPPKHP84u1Gv0diJ14=;
 b=J/p7wWwZNuoqkF/OXUWIkwO4SL3jHnxoobJP7fM+4usDGxuWd6xJL0RwtFX5VUp4aEk6uEVT0moDmtnE+ZS5DSJ3NeT0fHV88OjIenTnX5zQm1UdqqREFMtv4dqs6oGwg/VDeIDFDr53I8gN3bu917FldQntEHbkbONPBEdyiu0=
Received: from BN6PR12MB1620.namprd12.prod.outlook.com (2603:10b6:405:10::23)
 by BN8PR12MB3281.namprd12.prod.outlook.com (2603:10b6:408:6e::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.14; Mon, 21 Sep
 2020 20:47:51 +0000
Received: from BN6PR12MB1620.namprd12.prod.outlook.com
 ([fe80::8d47:77ab:f061:a0c9]) by BN6PR12MB1620.namprd12.prod.outlook.com
 ([fe80::8d47:77ab:f061:a0c9%6]) with mapi id 15.20.3391.024; Mon, 21 Sep 2020
 20:47:50 +0000
From: "Khaire, Rohit" <Rohit.Khaire@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
Subject: RE: [PATCH] drm/amdgpu: Workaround RCC_DEV0_EPF0_STRAP0 access issue
 for SRIOV
Thread-Topic: [PATCH] drm/amdgpu: Workaround RCC_DEV0_EPF0_STRAP0 access issue
 for SRIOV
Thread-Index: AQHWiIdVkvscc500tEyqHLH1Ytu47qlnmycAgAwDA5A=
Date: Mon, 21 Sep 2020 20:47:50 +0000
Message-ID: <BN6PR12MB16206C10B1245468DB4690F7873A0@BN6PR12MB1620.namprd12.prod.outlook.com>
References: <20200911220240.2848-1-rohit.khaire@amd.com>
 <CADnq5_Mhid2qV+cq8ywjrBSoKedjdf1gnMO13Wv+8JBWK0FbZQ@mail.gmail.com>
In-Reply-To: <CADnq5_Mhid2qV+cq8ywjrBSoKedjdf1gnMO13Wv+8JBWK0FbZQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-09-21T20:47:35Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=16f145a7-5b1a-456c-a503-e4c013c46b50;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.55.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 79bbdf08-02d7-4007-ec57-08d85e6f9b0f
x-ms-traffictypediagnostic: BN8PR12MB3281:
x-microsoft-antispam-prvs: <BN8PR12MB3281E657EF4CAD7ACB5AED6E873A0@BN8PR12MB3281.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LElJPx/lNxhMJPUK8mBW+hyD0eISu0Z46kn2C58l3+Cru5n4nLVbtywinwj1swXfIb2W6uoS2e9pxJgRojMNH9MmD4eiAgsN74l6LXu7HCgoiM8qyKSM3jBfBVJZWGGYEzDBBjJeMLPHmiLujM9TFb9OTJSb++JK9mt1X61Nq/BXTpOXbko/ONuROAtfM9q4UMof8E0GdFYIeTuvbTIk1H8Var3iZJkOXxCmuQ+P6HhxVBoJ7hBBONHE9K0HaYEJf9dc3pJ9yxdGaN05DQsUqmIFGayT9hPQomjeKSqetIoeIM6woPQPk4+qf8ihgtF5MIxTt86dSIyR46I7icFIDS+7/MbjE1SnjwyGmXz3bmU=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN6PR12MB1620.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(396003)(376002)(346002)(366004)(9686003)(52536014)(86362001)(26005)(8936002)(6916009)(8676002)(55016002)(186003)(966005)(71200400001)(5660300002)(316002)(7696005)(53546011)(76116006)(83380400001)(6506007)(66946007)(33656002)(66476007)(478600001)(4326008)(66446008)(64756008)(66556008)(45080400002)(2906002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: jcvTOtWWYq8MoJyfULDggQLMlXQ0Dpf/0Wbyh2C3kM9EJeXJ6zAJKCIHISE73/kRuBK62k+s1/jb8SM9tGm9a7qammXUkTgoPYIMUeZTCocAvFu4JbPTZJdfHapYE2JQ/+sSKX/uOWSDs+Mf6lWkSWwXCloC3y0CGU6fRrfASmYM9wAbQgn1o2UIEDkT8Tp0r+j21lUboMl0AjpVPZrsWym8kzTaQ0z3Hh69jFRFODUVlEPdGBqKit9t/9DphBHsnMRva+7srSM9SD1xi2fLm+tUGn+1zCU2WwXtwM/iVipRhuyiScZy9oOssVNt0Hu9dSHArkUy980MyIN4OCNWM7msmGanJQAbyzYZ8IzfESgDKbOl4fOh56USOBEhKAaOD9q7wuXBUN+r2fp07F8j48Dhs4plY8dLbjRBs4Xl5bE+uwGKrQoxabXQkxDEZoc8E3WXdYbke2oplIGf8ap7xlmArUPlRwkZeWvG9EJWFUmJRWzLbxi//Kf5SA/KAr8VdqUEVXZ74SyAv+7W8ay9t2UjpqgEq39oAlRdZ04TfncRR5vW6Ujwwz7RSRzE+LLiu23d5WvAH7R/FOEJ6HfVqpcCs4DYP9ZeeTXcJuv4l/bqEhGpk5Kod5dRipmX7xHWYu2xzVuxWswvwIMDInXvvg==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR12MB1620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79bbdf08-02d7-4007-ec57-08d85e6f9b0f
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2020 20:47:50.7268 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: x9FnMhO6/dK5LSGSVRMA3EWwHY6xRSbRerlUyLOSGHXoI2M2m/Nqc53pLH5OIoSS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3281
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
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

Hi Alex,

I discussed this with my team, we are fine with PCI_REVISION_ID for SRIOV.

I am resending my patch with the change you suggested.

Thanks
Rohit

-----Original Message-----
From: Alex Deucher <alexdeucher@gmail.com> 
Sent: September 14, 2020 1:16 AM
To: Khaire, Rohit <Rohit.Khaire@amd.com>
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu: Workaround RCC_DEV0_EPF0_STRAP0 access issue for SRIOV

On Fri, Sep 11, 2020 at 6:03 PM Rohit Khaire <rohit.khaire@amd.com> wrote:
>
> Signed-off-by: Rohit Khaire <rohit.khaire@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c 
> b/drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c
> index 7429f30398b9..fdfa075e6d5a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c
> @@ -51,8 +51,20 @@ static void nbio_v2_3_remap_hdp_registers(struct 
> amdgpu_device *adev)
>
>  static u32 nbio_v2_3_get_rev_id(struct amdgpu_device *adev)  {
> -       u32 tmp = RREG32_SOC15(NBIO, 0, mmRCC_DEV0_EPF0_STRAP0);
> +       u32 tmp;
>
> +       /*
> +        * On SRIOV VF RCC_DEV0_EPF0_STRAP is blocked.
> +        * So we read rev_id from PCI config space.
> +        */
> +       if (amdgpu_sriov_vf(adev)) {
> +               pci_read_config_dword(adev->pdev, PCI_REVISION_ID, &tmp);

This is not going to do what you want.  The pci revision id is not the
same as the ati rev id.  If you actually want the pci revision id, we
already have it in adev->pdev->revision, no need to fetch it directly.

Alex


> +               /* Revision ID is the least significant 8 bits */
> +               tmp &= 0xFF;
> +               return tmp;
> +       }
> +
> +       tmp = RREG32_SOC15(NBIO, 0, mmRCC_DEV0_EPF0_STRAP0);
>         tmp &= RCC_DEV0_EPF0_STRAP0__STRAP_ATI_REV_ID_DEV0_F0_MASK;
>         tmp >>= RCC_DEV0_EPF0_STRAP0__STRAP_ATI_REV_ID_DEV0_F0__SHIFT;
>
> --
> 2.17.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Crohit.khaire%40amd.com%7C3f71c48028984d067a0208d8586d4528%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637356573621338868&amp;sdata=4Z0WFnTuSqp4NaCtUc%2B0iJcH5y%2FbRT9yTz6sP8vm8Vg%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
