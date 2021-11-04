Return-Path: <SRS0=uIzi=PX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AD05C433EF
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Nov 2021 06:39:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 371D1611CE
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Nov 2021 06:39:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 371D1611CE
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A7CFD6E02D;
	Thu,  4 Nov 2021 06:39:53 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2080.outbound.protection.outlook.com [40.107.236.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C4CB46E02D
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Nov 2021 06:39:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QzcyqadbIbC7J2kwNJir4VRcBdMrWTH1oUtM3LMTMuRtJGuKcHsZRR8v+cLTcVDAjFsR84txXMrULpvrv+u8OJg8GXYs7M0JgP0ffcesAI5r74UIvoqG2T5zWOMRYh3u5eA/N/z0dUSLEFzH/DCkGMgGq7vor4tqXf6OgW3AWmh5RhgmLRZRpcAcA2x2RhKnNSgGE2cKTgLHi4agD4rG74So2Kp5U2rNhoxgSOoHF/qlD0HS0dFHQ/ymyhPYjWUbhGvvszcjjcwbKFqKc0CH78R1TtiEPGn2O7IpH+sZxIisPueQClZOoGqXZB77ng+RCx3Y80I3bDYSIrqpFn4vqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a+ZQGcsgK2MR294xpCmBWTZiedibSBNjjxUFN61XPxs=;
 b=aeDOaMH9kQbBQWs+eW5NOsU0nturh0DlmOECwnsc80jBxU5xkfCRMRX1HQOnNs8HLCMP9mcedtN2+hDmLq+tSrdN3TFPWHmQd0rnkYV2s3Jrcz7mhpjUM9hb4A8rw521Z2GrGEsMYRlfj64ntJcYooFTLdTV7o+4t6/b3jeaCVnn3mD/bzHkBMOhTAdRlharqYhqR+Gfjkl88uu1snLsY9KvaFHyf+W1k7waxc+2o1K6Hm+3RhSRsMFIGx1OqyTJqK2uiMU7Cgyp8uWweZeQgE54duYyYp8menAFpFw1JCpFnKsj0UXP41SLRkP8G4mzxaPC4BYJ+uFiEaFRzNygoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a+ZQGcsgK2MR294xpCmBWTZiedibSBNjjxUFN61XPxs=;
 b=whT0jmDHWcbrwL465F+ypps1ppv0ixVgNV+wfGqtE5+vHyJMErfyOIzDphFKDzr61gY3nVkA+OblOSEYsqxRyfY3SRnSU00jvm+im5KjPNYBNSid5AxXnSEUHOybvT3nJGTx2aQZ7+XDYm66r6qwIjRnoOgZEMFhQhA1yPjvDg0=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB3467.namprd12.prod.outlook.com (2603:10b6:5:3c::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4649.18; Thu, 4 Nov 2021 06:39:48 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::35c8:7b2f:1090:d3a5]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::35c8:7b2f:1090:d3a5%6]) with mapi id 15.20.4649.020; Thu, 4 Nov 2021
 06:39:48 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: fix SI handling in
 amdgpu_device_asic_has_dc_support()
Thread-Topic: [PATCH] drm/amdgpu: fix SI handling in
 amdgpu_device_asic_has_dc_support()
Thread-Index: AQHX0SvK8xKiw1NMhkW5brBTAPL8pavy6xUg
Date: Thu, 4 Nov 2021 06:39:48 +0000
Message-ID: <DM6PR12MB2619B212D6F15BA3C350BFF6E48D9@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20211104032616.233937-1-alexander.deucher@amd.com>
In-Reply-To: <20211104032616.233937-1-alexander.deucher@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-11-04T06:39:45Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=141940e1-e38c-4f5e-bc17-0df17f454327;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bc988ad1-3b48-4326-2fef-08d99f5de5a2
x-ms-traffictypediagnostic: DM6PR12MB3467:
x-microsoft-antispam-prvs: <DM6PR12MB3467C00316E405EE4F236E65E48D9@DM6PR12MB3467.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3631;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xXaGhfcGTbkHB36o307KRYo/yb8NJ5dnvZdoTDQPmcevbbl4ziAYJRIOurO/ft2fgFIxKr1uh8wD75lZ1PB0lrYfpnHJdWfKOORGGjvaDJGUhyQZcoo9W9H7MmXRFGXKUzMjgQ+iLzW2nv/HGonEdJw99QCIVRwhFe/DhZsrck0QN4AqkAdmLNKW+kjTE4mMzjzqfzfuVqvQ/RqV+rvvJJ9pjX8qR9rNV9W04rAYZEZJlvV/uDPTBhlCumcb20HvWovsXnVujPUy6Dpl8V2bIHgrwNPPJoucWvkIKw38Nn2vHvtUn0CitalUfOM0vivx2Qwn4TLiUaoyG0yEkow/7gdPKw7h8py12AcYktLh3WPC68BXsR8Ebu/YUQT40mD4cCbvYx0XKuZO2HfCA2pzL3va9K9QLsH90QYKZr5iY6zMmWCy1gjqqFJDhUaXFSVZREGXKo8N+gHY/LccjMsyT2oXU4ZoHV0jpCnRkb96f0IE6jfu80Z5YcohIQeo9XNTFSCmiejJL6BJkfivRzbaxpVYViF1iNAc9X4XTUTrGmDUWFptUvKjCBC3hj/N65RF+Bx5C/gY5jg1lA54u1rKT2KYhS9GE11qUiKExYDZ8C6LC+a+mJxDzIoEJFDp30GdSUOsMtN4X51+zg0X4cLPMc18zrj+wg4EmqsM7C4sZSD6vS1TYs+UUbPnzBcJ7qDHV74V8OKl0DtJPBSbmhFhQA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(66446008)(186003)(66476007)(53546011)(9686003)(38070700005)(71200400001)(6506007)(26005)(76116006)(8936002)(8676002)(66946007)(55016002)(122000001)(66556008)(5660300002)(38100700002)(64756008)(2906002)(86362001)(110136005)(508600001)(4326008)(52536014)(316002)(83380400001)(33656002)(7696005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?vMZKFQ2TDvNhBPKliZHbdfQ7MRcMzAB56APJFSr2FBq65MPn9uPnppwKG9cQ?=
 =?us-ascii?Q?OIAI+rFug9N0UktkKHpLt8UScr85mC70hqXC78R03HMK+S9pvQIqtqpsHg0Y?=
 =?us-ascii?Q?/2yDdODlt+JEyXO65A4FStyvaf1/7gFmzP9z0SvDgRceDq/4nE5vCZuq1fXi?=
 =?us-ascii?Q?e8mZOGASfrtFk9cYM4Y2zcmmZpDae5lz/HTTNkmafflRWk38iSNRigVNdJ8A?=
 =?us-ascii?Q?Hfw4AXVw8HrvCkWddDHtjp4haMLkSNeHJmKc5ntaahIwdd3T+0WPrabnM5cC?=
 =?us-ascii?Q?wyzsZZwFqBIY4JxggRckyQKBPI4Hr5Wi/kZUu3dtK35h30yv/Xw/d91h3Nin?=
 =?us-ascii?Q?fncHDzvTqH60jBKhklGIoIlGZTSEWNuCQBczk1XapsX1unNfY86qH86rQhlL?=
 =?us-ascii?Q?zY7vIaOVwBYXMR7SWrERWur8sjalNgqO2R4xzVeDWxc2FZuJ2P2oA5kntuQB?=
 =?us-ascii?Q?brUv0JVf9brpOm/h9qWL2w378XPySq6URp6HkW9DL1uxYugDnWlwUBdvI6lw?=
 =?us-ascii?Q?BHwHGg5ZYiG8SJZKsDkxBt37iC0FXrpWFiekTlqsqrZhS/1nQ/jTLNat/B0T?=
 =?us-ascii?Q?6aFoN3ngUounYE9gJFes+TGVYEoeWV/N8pggdIWR9xuVuhz8N655JrLprr8X?=
 =?us-ascii?Q?UtlD5XqccmQLorfX7odC1w2Qh30fiKdU8uTEft18Vt758pU+qsb+8byk6IzS?=
 =?us-ascii?Q?ZKwRJtCdlns8Nh/PQlaFRp7RPtRo5BQnWl9s963rI+/xBwUQQLHkn2D6xIzx?=
 =?us-ascii?Q?oDB3Q2PjUpRIBN77HFjSmQvnu0MOJUudCOxtNt9Ejj+1e+0Pfq6Ckv/Bllj5?=
 =?us-ascii?Q?KEaEczoO9r8lrh6BQ9pbnIXI5hBn62MwioZg/Y0Fx6D0gqzzo0D1R8UWP6b8?=
 =?us-ascii?Q?/7sPaAszTFZZelU1CRSzeCgFAGS253zuAXHXNx35Z16hMYT7PNQknV8t1MlU?=
 =?us-ascii?Q?u9KUYUpN0dcDcujfi65LWhVBHRIAJ8Jl85tmGwyQAV552vkao80AGhFvLYKj?=
 =?us-ascii?Q?cmkYnoCNkSSV8jf8oCxw05x7v/buZJhjGfkHPnHzSCN/4jU51PSBjlvePmAk?=
 =?us-ascii?Q?oOVojWzsddnxSTmRKXkQ8rUgSBtCVyylv6wozqVgQRLAmNKrYJBn46twMSPf?=
 =?us-ascii?Q?Xg2ehig2a+D+rrTTeehWIcbN/jKPJMs9HW3vpk2Q9As5Wx6oNLv4wA8T8fXq?=
 =?us-ascii?Q?xltdaWPqzyVWCMzAdOSgkF1h7vwr9S5KksYaTdbsEGmDsOs20tXTPux2Ap0S?=
 =?us-ascii?Q?L/50sP/74ciBGuDDnde97JRzUUZcGqufHIGvloHemo24Ak54swI5TuyGPmV+?=
 =?us-ascii?Q?tCnSSJyGqghAr3QbMrOP3WP3mumlgL80XySE0FMItQMqWwA4aHTzIkHQ7Rkm?=
 =?us-ascii?Q?ZFgIGAGdCrpfbBm73rR726UgtLXx9igSFOJ1SJDwxjQ3p6qrRooG1TtRWWzj?=
 =?us-ascii?Q?uoiI5cZgR+T79M5NFfrC9u/PKhMRBEqb5DmXY3iPONWV/sj3VSVc/2uzg39Y?=
 =?us-ascii?Q?KbV0rGjLo3RDFYdd0fqj1giC7LHo9wAF5ViQwd0668zFIbHDwhfLm5HbYj7h?=
 =?us-ascii?Q?K37gMtVAOQOQMDghapU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc988ad1-3b48-4326-2fef-08d99f5de5a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2021 06:39:48.1723 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eAV8A2et27OHdLUIF+JMMDi8GpYDPXSsDvZlFUBUjRqCWs1o3WuIvD44YKN9tl/n
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3467
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]

Reviewed-by: Evan Quan <evan.quan@amd.com>

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex
> Deucher
> Sent: Thursday, November 4, 2021 11:26 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
> Subject: [PATCH] drm/amdgpu: fix SI handling in
> amdgpu_device_asic_has_dc_support()
>=20
> Properly handle SI DC support when CONFIG_DRM_AMD_DC_SI is not
> set.
>=20
> Fixes: f7f12b25823c0d ("drm/amdgpu: default to true in
> amdgpu_device_asic_has_dc_support")
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 95fec36e385e..db3728a11481 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -3166,11 +3166,21 @@ bool
> amdgpu_device_asic_has_dc_support(enum amd_asic_type asic_type)
>  {
>  	switch (asic_type) {
>  #if defined(CONFIG_DRM_AMD_DC)
> -#if defined(CONFIG_DRM_AMD_DC_SI)
>  	case CHIP_TAHITI:
>  	case CHIP_PITCAIRN:
>  	case CHIP_VERDE:
>  	case CHIP_OLAND:
> +		/*
> +		 * We have systems in the wild with these ASICs that require
> +		 * LVDS and VGA support which is not supported with DC.
> +		 *
> +		 * Fallback to the non-DC driver here by default so as not to
> +		 * cause regressions.
> +		 */
> +#if defined(CONFIG_DRM_AMD_DC_SI)
> +		return amdgpu_dc > 0;
> +#else
> +		return false;
>  #endif
>  	case CHIP_BONAIRE:
>  	case CHIP_KAVERI:
> --
> 2.31.1
