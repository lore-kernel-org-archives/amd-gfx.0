Return-Path: <SRS0=p2a1=3E=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7463C33CB2
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jan 2020 10:01:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC68F2467D
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jan 2020 10:01:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="GR7DpxE6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC68F2467D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 77F396E8EA;
	Wed, 15 Jan 2020 10:01:33 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760075.outbound.protection.outlook.com [40.107.76.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD2ED6E8EA
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jan 2020 10:01:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ps9p6zdrIQLwqyoJfCvBuGMjB6CHyzCRRYW5tOrHnQnoMjIazUSDNAwfrVanl2tyMMQPJMFqSZ1aAqeaGFtKjf/rvV4SZPzd9NHpzMlF2vyNamkr3LKhZryzSdsr1OoYwWTeti0w7evkDsl65iyA2ZypwvmzFcl1gjJxulvlzX38LgUc9TNsdFBbRCOAxjugjTDluAK3UhocUYSMGFsIxcNOhhEbPpn6J+k8xczJnHefyBHpnbkgvNGkCbt/OUpphIr1s7s2+h/LNpviRUjNW6Av+STVaiE954Y7PTA5/H3L4hM2uw0lKFxowj7PAlF6dj7u9k4WIJ14M5APlsmzkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AiX1dJ88TORvDhSd+c1tCK9fwax6gfvdfEQRUeaOMt0=;
 b=aMPx3rK2+qSR6NAEe4+fbOPmxbYAsoWqa/vPrhoMYR4664I2UQhtdpm7L2Q61KONB39FH5oZ0a8fKZlYbWg1aJM8JxxiRMDhtunqonv13qSuGKgipr0pb+rlQrk+q8t4jz+nNbtbDFyGuCJ7K7Q7mfHcPmej3vEQ90BUQvv4f1YwVnAvDnLGAl6LUihAHQ8iA6Tw4Oe82IWR2Ga408NU6e2llqkrzUMEsMbQBRYt03vC2EEmlsfU1FlFytCExgGCGn3pJ06FVsrDmSkymQBVygsNFU8SOfcYdGyQMO/tDymdk5v3Yh0i9vEDtLB0KdgHro7ANjMAhWNxcKJ9zudntQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AiX1dJ88TORvDhSd+c1tCK9fwax6gfvdfEQRUeaOMt0=;
 b=GR7DpxE6rsMq68ESNVqG/okGoP/o+hibIv7huoLMSk7iLFDeUhL/m38sx9wpx2Ovut7dOU0XS0EysNFU/LvSHoa2DVOPMPV2jAtikfbWBpGZcGvQkXUndhWVXN/fgul/7OaJ0Ltde3Mtkdq+vdYEXAXGQ4Ndpp1HYdr6Aig7mk4=
Received: from MN2PR12MB3069.namprd12.prod.outlook.com (20.178.241.23) by
 MN2PR12MB3005.namprd12.prod.outlook.com (20.178.241.88) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.10; Wed, 15 Jan 2020 10:01:31 +0000
Received: from MN2PR12MB3069.namprd12.prod.outlook.com
 ([fe80::9cf1:449e:8958:db19]) by MN2PR12MB3069.namprd12.prod.outlook.com
 ([fe80::9cf1:449e:8958:db19%7]) with mapi id 15.20.2623.015; Wed, 15 Jan 2020
 10:01:31 +0000
From: "Gong, Curry" <Curry.Gong@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
Subject: RE: [PATCH 3/3] drm/amdgpu: reading register using RREG32_KIQ macro
Thread-Topic: [PATCH 3/3] drm/amdgpu: reading register using RREG32_KIQ macro
Thread-Index: AQHVys+4gMuIBmYeKUe/FCuxDa+omqfqO0aAgAFA05A=
Date: Wed, 15 Jan 2020 10:01:31 +0000
Message-ID: <MN2PR12MB3069E9F01B077CB3BE39A06D9D370@MN2PR12MB3069.namprd12.prod.outlook.com>
References: <1579001495-20729-1-git-send-email-curry.gong@amd.com>
 <1579001495-20729-3-git-send-email-curry.gong@amd.com>
 <CADnq5_NxWS1i5b2E8PiKXUc_tB8DbgA2QunvUJvOiqM_w2qJbQ@mail.gmail.com>
In-Reply-To: <CADnq5_NxWS1i5b2E8PiKXUc_tB8DbgA2QunvUJvOiqM_w2qJbQ@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-01-15T10:01:27Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=ecefa3d7-31d6-4450-8889-000036218704;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-01-15T10:01:27Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: d88768d2-a719-4059-818f-0000aba41568
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Curry.Gong@amd.com; 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2153ed78-835c-4a1d-9ec9-08d799a1e553
x-ms-traffictypediagnostic: MN2PR12MB3005:
x-microsoft-antispam-prvs: <MN2PR12MB30051A7D920D12117E1896299D370@MN2PR12MB3005.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 02830F0362
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10001)(10009020)(4636009)(39860400002)(366004)(376002)(136003)(346002)(396003)(199004)(189003)(66446008)(81156014)(33656002)(45080400002)(478600001)(71200400001)(4326008)(8676002)(81166006)(966005)(2906002)(6916009)(9686003)(55016002)(7696005)(53546011)(6506007)(186003)(26005)(66946007)(64756008)(5660300002)(86362001)(66556008)(66476007)(316002)(76116006)(52536014)(8936002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3005;
 H:MN2PR12MB3069.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fVg9oBtxn6lMHDf9h0c/Vwhp0AKGSLkJ20UbrfhAskPaMEffLady/838DsYQjJfs8GYDIftgP5gHcDEaCGMkAzzr47Y6Xx2udfqY9D3Sy+/Oq3j9xy8Ldwf3Y0Is8yUESsg+MshjxNoy57Fvl4ootMYTlNrgXIEZy4PKg/pqb2d5AP0ZmyuushUVHOOs8sF5QKK575PFbtWdUBXuX9lLAd9+/2sSKH5FGu+h3o9xsiflNyl8VwBy2XL/zFos+VlCULspXGKrKV9z63tOjbCrOle2F4GOLgGMg7+gi1/6/NJBjdP+u48kIpR4I1GoAGq9W7Edm+B4vjp2H0HSazIxu6iDkClusvDEw2OJ4Jlcvxfyo/KoaLc51DrkCi0BWFzbCQnJ01rUSqrjPicnUb0UAX/nift2t0WYK29jAyQ7vVS99l/u4QezQSsqEtsCLs+cEI0gYicqgUNw27FBxoO2P7WGykzbXEvxyVpDxO+OzHjxkfUN6PtB+vRnIdn3vESVkLEqJ1d43Ai/052GyXU0k3DyYnT/J5I6M4wtSaNpYkW1wfMNXDPPDWzy7nQtYGmO9rw9C7bOXO27s3UyrxHdkA==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2153ed78-835c-4a1d-9ec9-08d799a1e553
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jan 2020 10:01:31.1502 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UpCvify8gz4Z4eYbMVK1xir55scKyt3RAz1ROY6YULlNlOky2Z7tK7tEFulGtCQ4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3005
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

[AMD Official Use Only - Internal Distribution Only]

Hi Alex:
Thank you for your comments.
'convert the amdgpu_asic_read_register() callbacks to use KIQ' is a good suggestion. It is something to look at in the future.

BR
Curry Gong

-----Original Message-----
From: Alex Deucher <alexdeucher@gmail.com> 
Sent: Tuesday, January 14, 2020 10:40 PM
To: Gong, Curry <Curry.Gong@amd.com>
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 3/3] drm/amdgpu: reading register using RREG32_KIQ macro

(On Tue, Jan 14, 2020 at 6:42 AM chen gong <curry.gong@amd.com> wrote:
>
> Reading CP_MEM_SLP_CNTL register with RREG32_SOC15 macro will lead to 
> hang when GPU is in "gfxoff" state.
> I do a uniform substitution here.
>
> Signed-off-by: chen gong <curry.gong@amd.com>

Alternatively, we could wrap this function with amdgpu_gfx_off_ctrl() like we do for the AMDGPU_INFO_READ_MMR_REG.  Maybe it would be better to convert the amdgpu_asic_read_register() callbacks to use KIQ as well?  That can be something to look at in the future.

Alex


> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c 
> b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> index 425762a..cdafacc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -4714,12 +4714,12 @@ static void gfx_v9_0_get_clockgating_state(void *handle, u32 *flags)
>                 *flags = 0;
>
>         /* AMD_CG_SUPPORT_GFX_MGCG */
> -       data = RREG32_SOC15(GC, 0, mmRLC_CGTT_MGCG_OVERRIDE);
> +       data = RREG32_KIQ(SOC15_REG_OFFSET(GC, 0, 
> + mmRLC_CGTT_MGCG_OVERRIDE));
>         if (!(data & RLC_CGTT_MGCG_OVERRIDE__GFXIP_MGCG_OVERRIDE_MASK))
>                 *flags |= AMD_CG_SUPPORT_GFX_MGCG;
>
>         /* AMD_CG_SUPPORT_GFX_CGCG */
> -       data = RREG32_SOC15(GC, 0, mmRLC_CGCG_CGLS_CTRL);
> +       data = RREG32_KIQ(SOC15_REG_OFFSET(GC, 0, 
> + mmRLC_CGCG_CGLS_CTRL));
>         if (data & RLC_CGCG_CGLS_CTRL__CGCG_EN_MASK)
>                 *flags |= AMD_CG_SUPPORT_GFX_CGCG;
>
> @@ -4728,18 +4728,18 @@ static void gfx_v9_0_get_clockgating_state(void *handle, u32 *flags)
>                 *flags |= AMD_CG_SUPPORT_GFX_CGLS;
>
>         /* AMD_CG_SUPPORT_GFX_RLC_LS */
> -       data = RREG32_SOC15(GC, 0, mmRLC_MEM_SLP_CNTL);
> +       data = RREG32_KIQ(SOC15_REG_OFFSET(GC, 0, 
> + mmRLC_MEM_SLP_CNTL));
>         if (data & RLC_MEM_SLP_CNTL__RLC_MEM_LS_EN_MASK)
>                 *flags |= AMD_CG_SUPPORT_GFX_RLC_LS | 
> AMD_CG_SUPPORT_GFX_MGLS;
>
>         /* AMD_CG_SUPPORT_GFX_CP_LS */
> -       data = RREG32_SOC15(GC, 0, mmCP_MEM_SLP_CNTL);
> +       data = RREG32_KIQ(SOC15_REG_OFFSET(GC, 0, mmCP_MEM_SLP_CNTL));
>         if (data & CP_MEM_SLP_CNTL__CP_MEM_LS_EN_MASK)
>                 *flags |= AMD_CG_SUPPORT_GFX_CP_LS | 
> AMD_CG_SUPPORT_GFX_MGLS;
>
>         if (adev->asic_type != CHIP_ARCTURUS) {
>                 /* AMD_CG_SUPPORT_GFX_3D_CGCG */
> -               data = RREG32_SOC15(GC, 0, mmRLC_CGCG_CGLS_CTRL_3D);
> +               data = RREG32_KIQ(SOC15_REG_OFFSET(GC, 0, 
> + mmRLC_CGCG_CGLS_CTRL_3D));
>                 if (data & RLC_CGCG_CGLS_CTRL_3D__CGCG_EN_MASK)
>                         *flags |= AMD_CG_SUPPORT_GFX_3D_CGCG;
>
> --
> 2.7.4
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flist
> s.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Ccu
> rry.gong%40amd.com%7Ca53ec98e6f2848143fd308d798ff9e89%7C3dd8961fe4884e
> 608e11a82d994e183d%7C0%7C0%7C637146095959110200&amp;sdata=zbCMK3WYn%2F
> nWZol8IO3cA1EvGefPpD7WzAchoA9A%2B1A%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
