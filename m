Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AE5AC021A4
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Feb 2025 16:53:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F1CE310ED1A;
	Fri, 14 Feb 2025 16:53:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ffOUICOL";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2066.outbound.protection.outlook.com [40.107.102.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A70E10ED20
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Feb 2025 16:53:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OM9heilt2tQ6bxQgPM6F3j3LabF9OsvCJm07Q3j5SsnuNIultpv35Ia56UoLarxvri6PpRs+6/BjeSAURfQob99u5BvXNT6Kf0QGuFZdjA9wCr5R5dM42TJ6+x9DwDR1gu8icKDsznnz1NIhuTcZXXE2ejm5G+IMdqjmF8HwlHtBP54fbHoy0ueBZe/3V+ZSsp1NhEd46gxlO2dUr97Jo0cjTLOvjRtklyyegt59oXlYnSLJ0aQlxvYSpqLAfJMgIuXqqs1zbGeEXttEOqixCjQL0j9rJqvQMj0Uwhlnq699tpMvczhJ3zdNyaBxQ8ITv1g3pvud4yVvaIpdqI1ipQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7CVgXG5R68nWu4pa2O8vZyIHSgElYAt8DvyNtMnK69g=;
 b=MA2hOZ1mZAQ9JCtW7WeWXJOdC6l4tZxIr5BSjfCv5VcY7VxWlVOUDj8bx6j4hMTZLb4DY1ktpoxfTLtvh7YQsqytHdGoesdSsTgNdG/JsrP/SU8XqaROgFAo+yBXLml0W7PsPNsEk5CqZLeHJbm3YP3WkVjr+0j3CgVrHWqb3XScOy9unSPwvR4yE8VWIWjIW8kPji4krQWjLS43F57SuPx/NM5c2f1wk/9g43bfVnYlgzotku16XMxaUjcUITeWPkcvAA8j5e//PtGbSPNFWKEjcW5XKA/dGRt0hH4+1AFBIY/Kevh3lTxNU6FE2+cMawquulgPaJQTPdJ4eqk1Aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7CVgXG5R68nWu4pa2O8vZyIHSgElYAt8DvyNtMnK69g=;
 b=ffOUICOLaOghPWDtz9pMRRJI35UaA4lTfSGlpG6cLxT6qxbVECTQyOiNPl2xfLkN6W6Xs7aMLJUDom7Qz6QQBlOwOj9XYV/J/UN8ATZ9x4iAXK2LFTI7SKs9EJovSXZHF/Ho7l8wnCX1HG+7dJ2eYVje+iNQZok/Li5BLmJtHi4=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by PH7PR12MB6668.namprd12.prod.outlook.com (2603:10b6:510:1aa::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.13; Fri, 14 Feb
 2025 16:53:22 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::491a:cce3:e531:3c42]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::491a:cce3:e531:3c42%4]) with mapi id 15.20.8445.016; Fri, 14 Feb 2025
 16:53:22 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Liu, Shaoyun" <Shaoyun.Liu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 2/2] drm/amdgpu/mes12: allocate hw_resource_1 buffer once
Thread-Topic: [PATCH 2/2] drm/amdgpu/mes12: allocate hw_resource_1 buffer once
Thread-Index: AQHbfvPRnxLqKvOK+02RJB3+fiwCRbNHAcaAgAAB77s=
Date: Fri, 14 Feb 2025 16:53:22 +0000
Message-ID: <BL1PR12MB5144F31AC0DD465DD9D63EB6F7FE2@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20250214151901.2071738-1-alexander.deucher@amd.com>
 <20250214151901.2071738-2-alexander.deucher@amd.com>
 <CH0PR12MB5372425560C5BE3E4FED28B8F4FE2@CH0PR12MB5372.namprd12.prod.outlook.com>
In-Reply-To: <CH0PR12MB5372425560C5BE3E4FED28B8F4FE2@CH0PR12MB5372.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-02-14T16:53:22.015Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|PH7PR12MB6668:EE_
x-ms-office365-filtering-correlation-id: ac336b96-3365-44f3-d068-08dd4d181767
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|38070700018|8096899003|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?LSKlYNJSZfH1HqCJaL5ylVCsVM8+j+0weWTyfsbmjNh0wZaLYGA+LvUtSSGa?=
 =?us-ascii?Q?J2zo4s/Bet5prblZ8UVMJy782kClZdlaa5MOfyZy4kFRv5rpWAZvo7u2eOvM?=
 =?us-ascii?Q?j8DTcSG74IrqMeGo4hiRY+Z6nCbmeLBSY9+eUrb/Ly6ioKjZW/6wVeCcbsi6?=
 =?us-ascii?Q?3lT/mDFyjYvhqDIrHbNBKQQkICZknmgZL7o/hXu0eLLnITrppYy5fLYa2Ds4?=
 =?us-ascii?Q?MDiYyIDojO+bzVYEZhUVfuLYPq0smjCkYGcA+Ki3+KUkHZ2evf3iunrJnJz2?=
 =?us-ascii?Q?n65lnUh8qGwLzqUQlWlt8qzyt/+K2Eyvg6lj6ehPx0zouVOhG1Q+zvLBUyZW?=
 =?us-ascii?Q?Vi+zHNiBsghsRVX43S9WAJIPcLjza0n/WW0Nq4yTUD9ODuy7gQdpWB0NW8pM?=
 =?us-ascii?Q?pSAm0czffKfZs4xaM6AZxCVbQqVJ4f2CAURcNguzoXBiaxy9qcUiTN0hy43u?=
 =?us-ascii?Q?gWMd9NMQ7X8Lken9gCozUO/jJ4RtN5VtymG/t6ec5Okfy6ulTX/8RdnrA4RF?=
 =?us-ascii?Q?4dd+jNQzDtyZq/Jctt0pA83Gl/9peEelf+Suxfbdsbd8DGVSDkZ5o+QQ/ZNW?=
 =?us-ascii?Q?FVcqifvdgIROdhMgLa2PnXGuoFYE+QFehVT3umGaiV721H14sn4Ip1vsZ5Ld?=
 =?us-ascii?Q?5nJQW+8Rqp9TKmUfVoxw2ox8caHB5/PvJD4It0dQ4vb+jLodc6AJBAKrcPxR?=
 =?us-ascii?Q?djJTU5wiV03cChvYVvMdKlfmdXW590S6J0YGcF8oT1H2TmwtMDlDcyyIGHVf?=
 =?us-ascii?Q?2MexHZzTziLx+/bDEeLaZX7yPmG93n5abTlK9H9s+zjJi3ydN3H1fM0sRfK5?=
 =?us-ascii?Q?rJ5sNYL0F2wrOwpYOyJrZqPS5x3C4esLgC1hXL1kiRzi0lNX1Qv9XG6IYPgu?=
 =?us-ascii?Q?AVIvjEA6RsCMTsdNaAUtggtBnRtLZ9C49bQivmWTnFU8w2BHCnVka6iuELef?=
 =?us-ascii?Q?Ix+JLbtJvYsj8Xkgd10VqSdp2U95Rg62K+Dtzv/KzfJebxdc/Vxq4pSQ7wIj?=
 =?us-ascii?Q?ntWWVJszAgukPAYxMjubVSw3A1Xn5I83u5/FbkaA2g7Yx4ckSL2J+Tl7QcDW?=
 =?us-ascii?Q?C/N1AJfBaM+HspKypHF/QAGy5Q2m+cqYGltxQ8cYTfGIKBax3FZVUEoIO8Tx?=
 =?us-ascii?Q?4/lRH2EPpnfASbeRnzJIrxLrKQvEhK5rJa9j8BnKjnY123OlYJWNEUtp/tHd?=
 =?us-ascii?Q?pmm/LYHwhOx2cIMmN4ZNajpnfsu7JgqVD/AmsKssgPtCIcHdYvGG2dYPCNkx?=
 =?us-ascii?Q?DLPO5Yor4SG9d1uE0qJRr9kP0rZDcrJYOz9D9ndkAiAAxLd86aMfjXx/dKAz?=
 =?us-ascii?Q?eIhW3CXPzzw+N3d2C+hfqj1pyzKIfsEs3f+hIvyz0ku+2T924cwyEfNQsDHB?=
 =?us-ascii?Q?TXGtwEf1SMT7LyOtSOzMLFUJ/r3azBK5u3tA6qIux7C4zzRqPTTAZZQqYhzU?=
 =?us-ascii?Q?xq7vndwHfK4VeQl9RO1Qksu0J4Jx1yAd?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018)(8096899003)(7053199007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?XtvscOUcAr5GnMA93DY3TQ3hglyf/zQyg7hv3tozot5YOvmtTWbMEoQ8BRZ9?=
 =?us-ascii?Q?h5xbUokkQs4f3ooEa3fWfmTQuDIhDxqymcCNPCyVhxl8qujsOLqTvxK0nFs+?=
 =?us-ascii?Q?4497m7J6iz9vqYCqVhP6uV8Qi/ikt0we2QDl+Y03YLANFls5rBFa7WM+HDsc?=
 =?us-ascii?Q?kTNB7tmaW16gs+K2orgzrBKvdHRC5mzj5Kk0Q0pOGQwpsOTa+9Z7OmAdE6U2?=
 =?us-ascii?Q?hMsDpoKWem1xbyGYcq94Y82VMaNmyG7/QFYjct4/anM/VqhfWnMGvVPSizRC?=
 =?us-ascii?Q?Mc087cbafvVGtsB//QTWGVK+PJ5BPjKeQfmC+yTqxnW7JjMaWfTtHae4LKFl?=
 =?us-ascii?Q?zY7BOvRqTwuTpIxs7ZHaPwsG/9d8R1oI2XXn8hSBzvfFqfQRjfH4OSGQtZ5X?=
 =?us-ascii?Q?9IaKELByjfLgk5ASeZGbJtvrQyZNvvJuB/tQNmK2MG6LdyzAOS69vqyGYYNF?=
 =?us-ascii?Q?3TB0zZuZz4F5814WEPqmEHV8NWuHZMuELjSSxmaQwKsRv7ydNpoxwf8AyW+N?=
 =?us-ascii?Q?GAuwqFPyV8CaFsuDrwjT70i3YxA6v+HNYgV+pW0JFN3NMT17DkFXJZvh05fb?=
 =?us-ascii?Q?D08IXLcke+oNfb/flSPwBghGKxpDZ3iqzm7vFqnr7r0z5Ky4ZIHUw8qTJiho?=
 =?us-ascii?Q?Vwqg8vjiHxKEf6KsrYMDWa9dlmn4koKfth1FSPvsXri/Z4tBaYKWU+7Rbusk?=
 =?us-ascii?Q?GAP9LGSmWy9dt751YBsHl3cg+/419bMCrFbxrpl8nBjUc2yBhdV/ZpWAj2l3?=
 =?us-ascii?Q?zTFEJxn+uHXPnNvDMQA0f++lBtWLp4URA585l2ZMZE5Ul/SoqGgMbdTpOFft?=
 =?us-ascii?Q?1OYXFQDpfE0ngtyjzVq29CkuAHlrwkToCTqs0eQoPv3x1BFPq2YGRYAP+5Ag?=
 =?us-ascii?Q?IdF6pQl384CLwDqd6da3xT5ccxOTU0qdlBA0ToQuRd5Q3WQDN+9mhyBzGszY?=
 =?us-ascii?Q?CijhOUsffNXGsClzO7sJ/NX6KgMGvU2F6I1RAeBLmzbrhD+zKUfjWCzxHkFd?=
 =?us-ascii?Q?/LhxLOnBbi82SVbFVpR9zMBvDFjZovImnUBTXIYvGOJLwQEaDrUaH8755qA2?=
 =?us-ascii?Q?iUN5ShqfPMRt0AOxzklwa8Tg+Y0AEsPMlX38wYITQGjn9PDJK5tQFEh/VtB2?=
 =?us-ascii?Q?CS9fwU22rIKFBiqC1G9kiQ5r4k5H6dR//qV2YoFidJ6RgwuhJdszP1RyOYui?=
 =?us-ascii?Q?mP58pftJ/DD85jAjIxq3h0Dkuxendhrsxld0D2fkW8+X5m6+sweRE5EJp2Fl?=
 =?us-ascii?Q?kXezW+hKVWEuRAmxlF8bkMa1Ds46PQj6GBnONsXqyG8Gn2tQZgp9F+TYjPvL?=
 =?us-ascii?Q?saINu+5kDntTsFLpHJxIpO4LXjL7IAslS+5rRFqSBADlY3/R3GPIFheoKz3z?=
 =?us-ascii?Q?Mj3zYY1dHPuBoegbyJ/9IaQFqblwLgOw0t8necQVy711TRclH9FCG3xMfqLg?=
 =?us-ascii?Q?EW9vHbVr5VSkGtqBpr4Ps4fpOcJQ8b1ZafGx2XUDln/+mxuzrLBCTZA1EkCW?=
 =?us-ascii?Q?T/p1EtIgj+m2Cx8n6Wsc+tASw2jgyo8Wv5Lot83hHxW+W2u5PuuK9y4I9yXP?=
 =?us-ascii?Q?MwH9yg7r4QhTMbqWEe0=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB5144F31AC0DD465DD9D63EB6F7FE2BL1PR12MB5144namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac336b96-3365-44f3-d068-08dd4d181767
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2025 16:53:22.3668 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gTkLBfJtXBbXraNNMMV38DDP0LVEMREqvD138KzfbJ+WLltqR206syXukq7z4/wDc4IyYwooUzd7g6DdvKvmfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6668
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

--_000_BL1PR12MB5144F31AC0DD465DD9D63EB6F7FE2BL1PR12MB5144namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - AMD Internal Distribution Only]

I can add that as a follow up patch as I don't want to change the current b=
ehavior to avoid a potential regression.  Should we submit both the resourc=
e and resource_1 packets all the time?

Thanks,

Alex

________________________________
From: Liu, Shaoyun <Shaoyun.Liu@amd.com>
Sent: Friday, February 14, 2025 11:45 AM
To: Deucher, Alexander <Alexander.Deucher@amd.com>; amd-gfx@lists.freedeskt=
op.org <amd-gfx@lists.freedesktop.org>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: RE: [PATCH 2/2] drm/amdgpu/mes12: allocate hw_resource_1 buffer on=
ce

[AMD Official Use Only - AMD Internal Distribution Only]

I'd suggest remove the  enable_uni_mes check, set_hw_resource_1 is always r=
equired for gfx12 and  up. Especially after add the  cleaner_shader_fence_a=
ddr there.

Regards
Shaoyun.liu

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deu=
cher
Sent: Friday, February 14, 2025 10:19 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: [PATCH 2/2] drm/amdgpu/mes12: allocate hw_resource_1 buffer once

Allocate the buffer at sw init time so we don't alloc and free it for every=
 suspend/resume or reset cycle.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v12_0.c | 39 +++++++++++++-------------
 1 file changed, 19 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd/a=
mdgpu/mes_v12_0.c
index 8dbab3834d82d..6db88584dd529 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
@@ -678,9 +678,6 @@ static int mes_v12_0_misc_op(struct amdgpu_mes *mes,

 static int mes_v12_0_set_hw_resources_1(struct amdgpu_mes *mes, int pipe) =
 {
-       unsigned int alloc_size =3D AMDGPU_GPU_PAGE_SIZE;
-       int ret =3D 0;
-       struct amdgpu_device *adev =3D mes->adev;
        union MESAPI_SET_HW_RESOURCES_1 mes_set_hw_res_1_pkt;

        memset(&mes_set_hw_res_1_pkt, 0, sizeof(mes_set_hw_res_1_pkt)); @@ =
-689,17 +686,6 @@ static int mes_v12_0_set_hw_resources_1(struct amdgpu_mes=
 *mes, int pipe)
        mes_set_hw_res_1_pkt.header.opcode =3D MES_SCH_API_SET_HW_RSRC_1;
        mes_set_hw_res_1_pkt.header.dwsize =3D API_FRAME_SIZE_IN_DWORDS;
        mes_set_hw_res_1_pkt.mes_kiq_unmap_timeout =3D 0xa;
-
-       ret =3D amdgpu_bo_create_kernel(adev, alloc_size, PAGE_SIZE,
-                               AMDGPU_GEM_DOMAIN_VRAM,
-                               &mes->resource_1,
-                               &mes->resource_1_gpu_addr,
-                               &mes->resource_1_addr);
-       if (ret) {
-               dev_err(adev->dev, "(%d) failed to create mes resource_1 bo=
\n", ret);
-               return ret;
-       }
-
        mes_set_hw_res_1_pkt.cleaner_shader_fence_mc_addr =3D
                mes->resource_1_gpu_addr;

@@ -1550,6 +1536,20 @@ static int mes_v12_0_sw_init(struct amdgpu_ip_block =
*ip_block)
                        return r;
        }

+       if (adev->enable_uni_mes) {
+               int ret;
+
+               ret =3D amdgpu_bo_create_kernel(adev, AMDGPU_GPU_PAGE_SIZE,=
 PAGE_SIZE,
+                                             AMDGPU_GEM_DOMAIN_VRAM,
+                                             &adev->mes.resource_1,
+                                             &adev->mes.resource_1_gpu_add=
r,
+                                             &adev->mes.resource_1_addr);
+               if (ret) {
+                       dev_err(adev->dev, "(%d) failed to create mes resou=
rce_1 bo\n", ret);
+                       return ret;
+               }
+       }
+
        return 0;
 }

@@ -1558,6 +1558,11 @@ static int mes_v12_0_sw_fini(struct amdgpu_ip_block =
*ip_block)
        struct amdgpu_device *adev =3D ip_block->adev;
        int pipe;

+       if (adev->enable_uni_mes)
+               amdgpu_bo_free_kernel(&adev->mes.resource_1,
+                                     &adev->mes.resource_1_gpu_addr,
+                                     &adev->mes.resource_1_addr);
+
        for (pipe =3D 0; pipe < AMDGPU_MAX_MES_PIPES; pipe++) {
                kfree(adev->mes.mqd_backup[pipe]);

@@ -1786,12 +1791,6 @@ static int mes_v12_0_hw_init(struct amdgpu_ip_block =
*ip_block)

 static int mes_v12_0_hw_fini(struct amdgpu_ip_block *ip_block)  {
-       struct amdgpu_device *adev =3D ip_block->adev;
-
-       if (adev->enable_uni_mes)
-               amdgpu_bo_free_kernel(&adev->mes.resource_1,
-                                     &adev->mes.resource_1_gpu_addr,
-                                     &adev->mes.resource_1_addr);
        return 0;
 }

--
2.48.1


--_000_BL1PR12MB5144F31AC0DD465DD9D63EB6F7FE2BL1PR12MB5144namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Calibri;font-size:10pt;color:#0000FF;margin:5pt;fon=
t-style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[AMD Official Use Only - AMD Internal Distribution Only]<br>
</p>
<br>
<div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
I can add that as a follow up patch as I don't want to change the current b=
ehavior to avoid a potential regression.&nbsp; Should we submit both the re=
source and resource_1 packets all the time?</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Thanks,</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Alex</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Liu, Shaoyun &lt;Shao=
yun.Liu@amd.com&gt;<br>
<b>Sent:</b> Friday, February 14, 2025 11:45 AM<br>
<b>To:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; amd-gfx@li=
sts.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;<br>
<b>Subject:</b> RE: [PATCH 2/2] drm/amdgpu/mes12: allocate hw_resource_1 bu=
ffer once</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font face=3D"Times New Roman" size=3D"3"><span=
 style=3D"font-size:12pt;"><a name=3D"BM_BEGIN"></a>
<div><font size=3D"2"><span style=3D"font-size:11pt;">[AMD Official Use Onl=
y - AMD Internal Distribution Only]<br>
<br>
I'd suggest remove the&nbsp; enable_uni_mes check, set_hw_resource_1 is alw=
ays required for gfx12 and&nbsp; up. Especially after add the&nbsp; cleaner=
_shader_fence_addr there.<br>
<br>
Regards<br>
Shaoyun.liu<br>
<br>
-----Original Message-----<br>
From: amd-gfx &lt;amd-gfx-bounces@lists.freedesktop.org&gt; On Behalf Of Al=
ex Deucher<br>
Sent: Friday, February 14, 2025 10:19 AM<br>
To: amd-gfx@lists.freedesktop.org<br>
Cc: Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;<br>
Subject: [PATCH 2/2] drm/amdgpu/mes12: allocate hw_resource_1 buffer once<b=
r>
<br>
Allocate the buffer at sw init time so we don't alloc and free it for every=
 suspend/resume or reset cycle.<br>
<br>
Signed-off-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/mes_v12_0.c | 39 +++++++++++++------------=
-<br>
&nbsp;1 file changed, 19 insertions(+), 20 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd/a=
mdgpu/mes_v12_0.c<br>
index 8dbab3834d82d..6db88584dd529 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c<br>
@@ -678,9 +678,6 @@ static int mes_v12_0_misc_op(struct amdgpu_mes *mes,<br=
>
<br>
&nbsp;static int mes_v12_0_set_hw_resources_1(struct amdgpu_mes *mes, int p=
ipe)&nbsp; {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int alloc_size =3D AMDGPU_GP=
U_PAGE_SIZE;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D mes-&g=
t;adev;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; union MESAPI_SET_HW_RESOURCES_1 =
mes_set_hw_res_1_pkt;<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memset(&amp;mes_set_hw_res_1_pkt=
, 0, sizeof(mes_set_hw_res_1_pkt)); @@ -689,17 +686,6 @@ static int mes_v12=
_0_set_hw_resources_1(struct amdgpu_mes *mes, int pipe)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mes_set_hw_res_1_pkt.header.opco=
de =3D MES_SCH_API_SET_HW_RSRC_1;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mes_set_hw_res_1_pkt.header.dwsi=
ze =3D API_FRAME_SIZE_IN_DWORDS;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mes_set_hw_res_1_pkt.mes_kiq_unm=
ap_timeout =3D 0xa;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D amdgpu_bo_create_kernel(adev,=
 alloc_size, PAGE_SIZE,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_GEM_DOMAIN_VRAM,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;mes-&gt;resource_1,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;mes-&gt;resource_1_gpu_addr,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;mes-&gt;resource_1_addr);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; dev_err(adev-&gt;dev, &quot;(%d) failed to create mes resource_1=
 bo\n&quot;, ret);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return ret;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mes_set_hw_res_1_pkt.cleaner_sha=
der_fence_mc_addr =3D<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; mes-&gt;resource_1_gpu_addr;<br>
<br>
@@ -1550,6 +1536,20 @@ static int mes_v12_0_sw_init(struct amdgpu_ip_block =
*ip_block)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;enable_uni_mes) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; int ret;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ret =3D amdgpu_bo_create_kernel(adev, AMDGPU_GPU_PAGE_SIZE, PAGE=
_SIZE,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_GEM_DOMAIN_VRAM,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;adev-&gt;mes.resource_1,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;adev-&gt;mes.resource_1_gpu_a=
ddr,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;adev-&gt;mes.resource_1_addr)=
;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (ret) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_err(adev-&gt=
;dev, &quot;(%d) failed to create mes resource_1 bo\n&quot;, ret);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
<br>
@@ -1558,6 +1558,11 @@ static int mes_v12_0_sw_fini(struct amdgpu_ip_block =
*ip_block)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D i=
p_block-&gt;adev;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int pipe;<br>
<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;enable_uni_mes)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; amdgpu_bo_free_kernel(&amp;adev-&gt;mes.resource_1,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;ad=
ev-&gt;mes.resource_1_gpu_addr,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;ad=
ev-&gt;mes.resource_1_addr);<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (pipe =3D 0; pipe &lt; AMDGP=
U_MAX_MES_PIPES; pipe++) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; kfree(adev-&gt;mes.mqd_backup[pipe]);<br>
<br>
@@ -1786,12 +1791,6 @@ static int mes_v12_0_hw_init(struct amdgpu_ip_block =
*ip_block)<br>
<br>
&nbsp;static int mes_v12_0_hw_fini(struct amdgpu_ip_block *ip_block)&nbsp; =
{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D ip_blo=
ck-&gt;adev;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;enable_uni_mes)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; amdgpu_bo_free_kernel(&amp;adev-&gt;mes.resource_1,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;ad=
ev-&gt;mes.resource_1_gpu_addr,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;ad=
ev-&gt;mes.resource_1_addr);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
<br>
--<br>
2.48.1<br>
<br>
</span></font></div>
</span></font></div>
</div>
</body>
</html>

--_000_BL1PR12MB5144F31AC0DD465DD9D63EB6F7FE2BL1PR12MB5144namp_--
