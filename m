Return-Path: <SRS0=oZ58=PJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41941C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Oct 2021 10:30:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07FC760FD9
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Oct 2021 10:30:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 07FC760FD9
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9D83A6E0EB;
	Thu, 21 Oct 2021 10:30:31 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2061.outbound.protection.outlook.com [40.107.244.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BACC26E0EB
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Oct 2021 10:30:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iQX3A4WEzQ4hr1iYgVepIP5MsvF7p3o7VB0YgTTnH7kuGU315RkYYa+7wSEYepCeLEvEHYGIhUz3Q8zvZx6es02XxmQQfZ8jfFkYV749D1RsMYccFxFxs15MGc3RYeWSOdVlBbofQ7p11yBV6Rp+gzf4z9ldMKbKOe3KWtNRI4dV5qWP9UOYTg8F/lPCBRnh0vGd9e8kt/YyqT6ARsKKTRLUCpC2ovS9ZLZCgbvMGU3WKVVx+0v6BJSNqmWxHmjNzOUfkVid1ysWEy9cYZ8lSAeTKyohXM9HNxldtuMV0X/U735r2ffF2X1KPv1C2N/G3YaDWZwRFsdxzOjW1j5OOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5NWuV8LSbKK2jNbC8UM4Y+MCNbLyIRuKZxxDRJN/Eb4=;
 b=f1zD3hObtjNl/PJ1q3EMld4TLleglbhuUfvF9aS+Ls7goO0/FJFVOVGoMzytHkxYqD4d43j2oA5zCHGCP47xRiZLfxl1DelSsRlv1ZAlMsF6UwYDd8JpxTRqGRFWM46nmyEZj3XuAbhHqX92TathNAv0eEgraKVxLVpTt6tqBmMqy+DVKAJRyuJ5P6HSEM/ZTtn4zXucLBdo3bRBncV+DmF0gkzIPp2dKXVVVMwsjE3RYsDoVTtLF+HYxXU2ztQyF4LBAUHWWLbZ9nynBMu5poDOL5re1fQ0KmjpshWahhf7nIl/dm+E3Cu0ey/v7LX5tL42aYkoTfXxhk6iCt+xjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5NWuV8LSbKK2jNbC8UM4Y+MCNbLyIRuKZxxDRJN/Eb4=;
 b=on3D6qujo5auMbtWngma0AWgAQTR4XVAFaucmYrA18f6P6vVdx8xWqpQbIbkh6OgPuMVDx5E5/tbLaR1FduLSTidKODAjjMImyGjBIeVnDKdRhbvd3CQvZv9jJS26rKRYfYmPJpQ8iV46JNnDs4l0YR4lU3MBUXiu4FSV3twKz8=
Received: from DM4PR12MB5072.namprd12.prod.outlook.com (2603:10b6:5:38b::22)
 by DM8PR12MB5414.namprd12.prod.outlook.com (2603:10b6:8:3e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.17; Thu, 21 Oct
 2021 10:30:24 +0000
Received: from DM4PR12MB5072.namprd12.prod.outlook.com
 ([fe80::1d8c:66e2:7b88:8369]) by DM4PR12MB5072.namprd12.prod.outlook.com
 ([fe80::1d8c:66e2:7b88:8369%5]) with mapi id 15.20.4628.018; Thu, 21 Oct 2021
 10:30:24 +0000
From: "Chen, Horace" <Horace.Chen@amd.com>
To: "Chen, JingWen" <JingWen.Chen2@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Liu, Monk" <Monk.Liu@amd.com>
Subject: RE: [PATCH v2] drm/amd/amdgpu: add dummy_page_addr to sriov msg
Thread-Topic: [PATCH v2] drm/amd/amdgpu: add dummy_page_addr to sriov msg
Thread-Index: AQHXxmQYHTzEG9OcW06L3Lw6qUv9AavdQGVQ
Date: Thu, 21 Oct 2021 10:30:24 +0000
Message-ID: <DM4PR12MB5072A3DA78E326CA7C88CB0AE1BF9@DM4PR12MB5072.namprd12.prod.outlook.com>
References: <20211021101137.1147917-1-Jingwen.Chen2@amd.com>
In-Reply-To: <20211021101137.1147917-1-Jingwen.Chen2@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=62983e58-0925-4db6-a32b-6827191e0598;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD
 Official Use Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-10-21T10:29:55Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c0c24cc5-aac5-4470-1418-08d9947dcaf1
x-ms-traffictypediagnostic: DM8PR12MB5414:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM8PR12MB5414CDC51CF3556C608BBED2E1BF9@DM8PR12MB5414.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2276;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ICvPmohJMA68pZy+e/iMQz8dAVWOK4VlQ66MaVz3MsSnDelRdO/nxJvvULf/mo6rK3fzFIpXMOwnJZ2V+sMiiukUNQV0ex4tYHHWFwQ6uEQq+vRY5UvOAcApHHrjufPUCzfQUTjvde+T3lN8TJb+0hmtNFAtj/9TVXcVymp1dhDxS0Ab3jZvu5IRuQmQluhIjb6AO1Gxk8+cPrIGFbJvpeIaYGhEpguaE6ptl/skWLzjdPcJb+IuxMSwcjTJpi3v2wlvz6sXubnF4UjHv+P9oVA8YiLg0iXYlyLI9LtaqD7GcxPBmyA/6WPBJeDIcnFqO6yMZPPvufGqmLxyw1bDP2JsT8IyW0tp5qKYMzs1I2TBh1nexTAQVbNSDDehc5tJyYM1QoRVEO7UZZJrHPk0QD9w9v4lWzDoEiAT3Lsvgb+cbvC5bmYCvgJBldSzlc7bp50XhM71+csoek0mj4ugO9wEjaBiRaw254ftPZ6SP5I1Qhq3uKI4Mz/4YuE3Nx8lW6vsDVoYv8JhixUHhAjdR/zlAuKT4Ntp1bNCzKt34juyAM1h0Jt9Cy580pr9NW19B8Zoy0McQgITKHvnIKo8RuB4dNHWm8W7TEQFC1mkpFlWAV3fC5tH7KyYKrKX/3zHcB/tmXpV8+2ds/uEKsw5B4ri2DtLOAlmaLQAjdwSUoMrwqWmNRcz2ixzA1jfXx06OmSYPxaHHMM4UCivcdkJAw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5072.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(38070700005)(122000001)(7696005)(8676002)(6506007)(5660300002)(508600001)(110136005)(53546011)(38100700002)(86362001)(186003)(8936002)(33656002)(2906002)(52536014)(316002)(26005)(66556008)(64756008)(66446008)(4326008)(71200400001)(9686003)(76116006)(83380400001)(55016002)(66946007)(66476007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ri6zcqXcYMvkffAH5jExLVQ1gYlrY9xb+NyebhRyF6N3CSms0CRIEASu9Ndn?=
 =?us-ascii?Q?CRaxyFIVsdQIkN8zbxQzewAIJWp72+1AcXD0VBO5QsVN33GPFVbbcxdD+azt?=
 =?us-ascii?Q?XSY/rCEOHRZhKf3TCL7GvT0QzkPGHaiornT5PwN4HAdTgsMQtx4xdhVa0MlK?=
 =?us-ascii?Q?AOMxyjByG4j+Zd+x1mtz5kYU5OnL7koeKVvLdONmIDEK2Ox9jUMutssHOz8X?=
 =?us-ascii?Q?+wZ//80QMEbnjukE5CcYUxLaITkD7/7L0OvBJotS8XEJA9EwGVqcy4P0KTe7?=
 =?us-ascii?Q?xKBfNLgKm+aH921Uz+PXOV6mg2a1eRkw5Ws49QfOQn+21C/O900W2UbJ6qMB?=
 =?us-ascii?Q?f6EV6PJTJJqqPgcNt58hzVgBcBtg59HwIrhlCuDPmEhYuIhn2ceJBQKm3uUA?=
 =?us-ascii?Q?m3JLuRICdlzwfsE0Pmr9lle6FmK06Kfef9mbY0/iKs8uOiI0wSdF71XWdTOt?=
 =?us-ascii?Q?pElKxbBIsa2tDOirzWKcL2/tOIgVc40Ll6UM5LJich1azfky+pCY3EBLkH9A?=
 =?us-ascii?Q?EC4G4q2z2wLCoqpozDkcIzQVtyiu5CxfvyeQnKoyHOPglTugMaXYQ88W5PUb?=
 =?us-ascii?Q?zl3JZhhv1pKQk1+GssHMfMSk11+gdyVwFpnzoJGC2DSrMdiKla1mdMQkoElL?=
 =?us-ascii?Q?MgdqY0Jo4GEaRutZHjVd0z6cR9ZpbdrRiFQKN6F+vdYafS56wzPhvCVMpOKq?=
 =?us-ascii?Q?mkvW0Ydh9pPIHNKkkCNKslfOd/DOspGuSVj+UhP62URSynjgD3SO8JigONEF?=
 =?us-ascii?Q?v0+Gwvwie7m+nOrKJeT3BXVoukVlclQGj+iuH5YRUueYTOpQiTWI/fvIYZaj?=
 =?us-ascii?Q?lR+/m/NKG+aE7leB2+3gJ1CFNihOIFnabCriQ3v9A+8tQF22jMAaBTPAfJul?=
 =?us-ascii?Q?x2cJkAhpfRA1HPix7M9c3hdJo9gHMkate5wE8tQC16OdsiftPKVzbFEqrJUX?=
 =?us-ascii?Q?APiOKqsJ0mKYXE2PbDW3K70Ic7iMke5QE+1zMCQmqtwqXgIC4BqqC70Y7bEn?=
 =?us-ascii?Q?ZcMUuXo7vehQxSSXnZ/xOZeoB3VeYJEUGfJcPH0Acvaktdd9iuGuyyK2Aytr?=
 =?us-ascii?Q?mr/KJMOtGP364vWheV9To6Kc4NlKvKT6dxt/knUQuJQCLzLnXM285JS6CHh8?=
 =?us-ascii?Q?iaBv6vO2lcjkUSziJKGQENyUhy5n/yF9WAhYkrLnIU6wLjgSKSr/tpL+mfA1?=
 =?us-ascii?Q?7J45gBKFXylMEBOUR8wbOhFAtyjfJK1xdPkCGNf9fRtsfkBgK53G2T7n/EVU?=
 =?us-ascii?Q?4MEUUxCm0/h+AHWvROXSgXC+uYCO6BxtHFb5MtTspHuaY0gVknaGWuLaUxXB?=
 =?us-ascii?Q?0ugszlyEsRs6iA6Z97sydyJC?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5072.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0c24cc5-aac5-4470-1418-08d9947dcaf1
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2021 10:30:24.5628 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: horchen@amd.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5414
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]

Reviewed-by: Horace Chen <horace.chen@amd.com>

-----Original Message-----
From: Chen, JingWen <JingWen.Chen2@amd.com>
Sent: Thursday, October 21, 2021 6:12 PM
To: amd-gfx@lists.freedesktop.org
Cc: Liu, Monk <Monk.Liu@amd.com>; Chen, Horace <Horace.Chen@amd.com>; Chen,=
 JingWen <JingWen.Chen2@amd.com>
Subject: [PATCH v2] drm/amd/amdgpu: add dummy_page_addr to sriov msg

Add dummy_page_addr to sriov msg for host driver to set
GCVM_L2_PROTECTION_DEFAULT_ADDR* registers correctly.

v2:
should update vf2pf msg instead
Signed-off-by: Jingwen Chen <Jingwen.Chen2@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c    | 1 +
 drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_virt.c
index 88c4177b708a..99c149397aae 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -584,6 +584,7 @@ static int amdgpu_virt_write_vf2pf_data(struct amdgpu_d=
evice *adev)
        vf2pf_info->encode_usage =3D 0;
        vf2pf_info->decode_usage =3D 0;

+       vf2pf_info->dummy_page_addr =3D (uint64_t)adev->dummy_page_addr;
        vf2pf_info->checksum =3D
                amd_sriov_msg_checksum(
                vf2pf_info, vf2pf_info->header.size, 0, 0); diff --git a/dr=
ivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h b/drivers/gpu/drm/amd/amdgpu/amdg=
v_sriovmsg.h
index 995899191288..7326b6c1b71c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
@@ -261,9 +261,10 @@ struct amd_sriov_msg_vf2pf_info {
                uint8_t  id;
                uint32_t version;
        } ucode_info[AMD_SRIOV_MSG_RESERVE_UCODE];
+       uint64_t dummy_page_addr;

        /* reserved */
-       uint32_t reserved[256-68];
+       uint32_t reserved[256-70];
 };

 /* mailbox message send from guest to host  */
--
2.30.2

