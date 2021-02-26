Return-Path: <SRS0=SLyk=H4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E9CDC433E0
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Feb 2021 04:28:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BCEE564EE3
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Feb 2021 04:28:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCEE564EE3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A9716E8DF;
	Fri, 26 Feb 2021 04:28:45 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2070.outbound.protection.outlook.com [40.107.236.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 609AF6E8DF
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Feb 2021 04:28:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cebgQoVvSt3WFHd2bpcGVXDni1VI1GnUXWfx41OrOOVdkG7JLNJCrGSoYKxK1gULDtdXEM4MGzRO7zQzbXMQgGn3SJLvAWEM47UnB4fq94ZEOq/+JYBXmte/upibLZ90v+fYDpvrtM4YdLQM2nTuODqHAaNfBiMXKNPGaD66JFEMuOG5AiZit0LILzDDzf4DRpUZxPpCBRsUqHAK04pfqc2IMiqt3qouXBb6OLk3ziIAgSTUYV6FKOh0UMLOx14uN60l9uI4elSk1JwXDsjJ9WSNrFvmw/sHchmE/u8D5wncSLNBrGnwW2cfe1q+O10BkymCjkffhq7tGXQCZh9oWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CFzg4bu8nf2E7zCUlC9ExLkSKbFn0r5l45buOf64Bfc=;
 b=XVnpL33ijS1ZgU4sH3F5Qt1vs/Hq3Kz7hTjw1tahYKvnTR+ksek2rkuKsbNjN6xbBOIc5H/S/A3d1KX+e4ZIkwyshZjYmpubRmOhJbXY77ac27NGpERwvC69zMwNsm0JSFJOR9ENS7WsccjMTD8fPpJJMgSnWamFnABkd+m+8iG2rPC2JWzoXBkdu7tX9T9651C2OL2uEEidFClL/3Dfiehfcy9gWScQh0v/k5+0qk6dTBfIWgw8iTYLOh81f9Y9OqkfBmXgST6cVIkpAVq+PPmpIUb4uotqxkBdxvctxi65kQF2V7AitPzigSm2fFrhaUap0YhoYSy5LiiCrtogLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CFzg4bu8nf2E7zCUlC9ExLkSKbFn0r5l45buOf64Bfc=;
 b=4qzFVob2BPyfktUQZbeuR5JRucSS1j1G8ozm1vzzry4sxeQBB1vSC+5/m9/YeO+t/D4E/An4UYOno52fYBRKDmPZ7W3e9C7QVduTo9LzTEtXpROS9FGjNCVLllTa3Ucrcrpd2vzitB2b367DzuyWP3HliFd2IC4yQ9n4GKe/uy0=
Received: from MN2PR12MB4078.namprd12.prod.outlook.com (2603:10b6:208:1de::18)
 by MN2PR12MB4063.namprd12.prod.outlook.com (2603:10b6:208:1dc::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19; Fri, 26 Feb
 2021 04:28:42 +0000
Received: from MN2PR12MB4078.namprd12.prod.outlook.com
 ([fe80::f8e7:bfb4:8183:b7d2]) by MN2PR12MB4078.namprd12.prod.outlook.com
 ([fe80::f8e7:bfb4:8183:b7d2%8]) with mapi id 15.20.3846.047; Fri, 26 Feb 2021
 04:28:42 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Wang, Kevin(Yang)" <Kevin1.Wang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: remove unused variable in
 amdgpu_dma_buf_unmap()
Thread-Topic: [PATCH] drm/amdgpu: remove unused variable in
 amdgpu_dma_buf_unmap()
Thread-Index: AQHXC/dfz5cI7XzhIEeDrr4/tF5pZ6pp166w
Date: Fri, 26 Feb 2021 04:28:42 +0000
Message-ID: <MN2PR12MB407839343C4D7F582212B550FC9D9@MN2PR12MB4078.namprd12.prod.outlook.com>
References: <20210226042447.39296-1-kevin1.wang@amd.com>
In-Reply-To: <20210226042447.39296-1-kevin1.wang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-02-26T04:28:40Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=f26e7a10-f7ef-4788-9c52-91aa440182a4;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ad12c5d8-ec13-4849-c844-08d8da0eff83
x-ms-traffictypediagnostic: MN2PR12MB4063:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB4063EBFD869A0ABA8700645AFC9D9@MN2PR12MB4063.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2276;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CtehCp1iIYFGnkOImqTBmVdJ5LlkBC9hDknSNZmpK46Ke5eOSHIah73K1cXPOGmSJK29U1mOuedxmSIOmDzvK6to8sHAbm3aqCfxGfXEX5A1619C9Bsjssh0SuXDpvkIVUjbKofidXmteRGtuSpSzlonTNInOGhn3aAZHNxQ0M0s62FbEc9f12qBXJo0ujrSCHP7gWD4kMu+4u6mNipNDyu+sGCrWlupKErQz+aucSWKqIrlEXEYHX91KS0jl5P4bNE96yTe9jaLsibJyNHgH8UbFvy4qOgWvzqInpDkinqgMpfPhhsM68uXomjGYzkrKFCmBWVQLP0tqtsHXgjWAo0lDofds+H4YnlvC42BGonGuPZckBtCpu9eZqz2DYESzXklfA90kZOMAopU5xObSfe5cPmCYvTz89l3GVTuFvHewr2lLrFPvVotZ4EZraXszOMVfTM2nuGbI+ZxWqXdI12bu8w+piVi8f1gvSghxZ2Ods1FQgrDZS+0/6tN201Ma/cb6iUwceYGd63eicainofT5sRt30TaGDNvXkm6Zyala66INpLCapYOEdrk5pT4
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4078.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(396003)(39860400002)(346002)(376002)(366004)(64756008)(66946007)(55016002)(86362001)(66446008)(76116006)(66556008)(71200400001)(8676002)(26005)(66476007)(7696005)(186003)(4326008)(33656002)(53546011)(966005)(9686003)(8936002)(52536014)(478600001)(83380400001)(5660300002)(6506007)(2906002)(45080400002)(316002)(110136005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?K58ZE3WeOXvKrh5GbpqUooX1De6cKdo7YT6wnsCbu6pDafXOSM0N8i1YL+G1?=
 =?us-ascii?Q?6VmwQqrwaKP+KT2PEdRcMJIU09sdWC/VupZqsHEMbMwh1WR6eUwhNt1Ob5QR?=
 =?us-ascii?Q?tf1933m/8uk7ObqmVuvvOzVi+xXOQn4MYwkX5QPR+18sO+tsuQIgF5GeJKkz?=
 =?us-ascii?Q?lIYdFu6Q9eaumi1urITq8ObkrIgIO3FyywG/9vw/lQf54Yyz/9300Aq3jxMz?=
 =?us-ascii?Q?XMiFsVRNvf3Q4iWIwFlaj7rLLxSkdCw8m2r0hPbSF4cY3umSAhVF6xx2R2w+?=
 =?us-ascii?Q?oJYy3du95kretbNNIj/uxTrJFFhYt861i5hd5JbyKZ1CixWKcefctqtcOyA3?=
 =?us-ascii?Q?CPF/J+Q720uhO1MMBbleGVSmuZjCSvjDU9XX8oVdv8/CIFSirEH+VBWM22p6?=
 =?us-ascii?Q?y2m4shCWvcXXHU9/msxD+GWUwfPPH97vYWf21/N69hHiXnOeJH79/fin/9dg?=
 =?us-ascii?Q?RFxpz8P6wGyLlzaORUPMAHO3GusesGTzK61nIFpnt8X7KBitKxKzHblX/bOz?=
 =?us-ascii?Q?4TCmIYoR8nP93pbUf/C+J5ICGYPNXP8NPHLL1UBNYITL3/lZ34WN1s4hdUuW?=
 =?us-ascii?Q?B3P5BNZmSzio8Xs2Nhcc1L11RMpNOHJbeSMRtYsaz2U5tppJ4Fb7l1wzLGOj?=
 =?us-ascii?Q?azQXADSgawQinq4An0qsFH9/8UAyuksW07qOgCuk4E0dUIazweW/VJRBZ04+?=
 =?us-ascii?Q?s15o7rYcmIYDVzF3n8TdJP7ECNi61kvOnRdGVNwZ6dosdF3kuz89qgaU79UM?=
 =?us-ascii?Q?BQfogX/YwwyvjuZ9PikLxmo7E5zrcdD7nFRAVIotG6xbgzJwL1Qb9jpaI5ki?=
 =?us-ascii?Q?tkf1wWVfeCzl9YPYBaP/zzEZlvktO8I9/Xr/wKssgbeA1r2sAAN2Xau0OhlJ?=
 =?us-ascii?Q?NcyqWFJb8Ueo1nAj14m7nFdnvQ/Os8OTEQ9WYKtxpzTJq9HGJaL5h/TGtr0x?=
 =?us-ascii?Q?mYU5D3Ot5S4z0cDI3zeCQoycXoVWu7nz7yM1gQjv3K0kZde/yFDHojKPCF8c?=
 =?us-ascii?Q?nHUPxE2t/5cif7dBP9cjv3aTeHmB8xVDvCj4KD7SAQl6EwFxaB4TUssx9yIV?=
 =?us-ascii?Q?YtCCSjE1f2KBmUMpwHj3fxK+JROICMbwK7OLeehxCAYsa1dSYA98gKX3KLbC?=
 =?us-ascii?Q?W6vb2equGfp/NbbUU0QlRdb9pRYBEbPkFdLlpCci3ef67DT8UsvTr9dZMhbN?=
 =?us-ascii?Q?vfF8sP2HqrTO+9tOq4BpQxeUz2VUlWSRH/rzDSTu5ZKzGooSN4/wEAZZRzTm?=
 =?us-ascii?Q?Um1v22SzyZlpUc/PoCi1O7JX3IzLObWRTYB7NYAqF/+rlblcw+GswjYFcG+n?=
 =?us-ascii?Q?eyhwLoX12LJ6nHTkZfwYX1GN?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4078.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad12c5d8-ec13-4849-c844-08d8da0eff83
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2021 04:28:42.3392 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 46MgHcSem4i7YvLA/FtR19d7pHqeBCW2Wi15DK21vCLP9k/cOWFy8bdmU1nT0XROlNjqYAGgFWE3UTli0Uqs/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4063
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
Cc: "Wang, Kevin\(Yang\)" <Kevin1.Wang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Kevin Wang
Sent: Friday, February 26, 2021 12:25
To: amd-gfx@lists.freedesktop.org
Cc: Wang, Kevin(Yang) <Kevin1.Wang@amd.com>
Subject: [PATCH] drm/amdgpu: remove unused variable in amdgpu_dma_buf_unmap()

clean up unsued variable in amdgpu_dma_buf_unmap().

Fixes:
drm/amdgpu: Remove amdgpu_device arg from free_sgt api

Signed-off-by: Kevin Wang <kevin1.wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
index e83d73ec0e9d..5ec6556ebf7a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
@@ -356,10 +356,6 @@ static void amdgpu_dma_buf_unmap(struct dma_buf_attachment *attach,
 				 struct sg_table *sgt,
 				 enum dma_data_direction dir)
 {
-	struct dma_buf *dma_buf = attach->dmabuf;
-	struct drm_gem_object *obj = dma_buf->priv;
-	struct amdgpu_bo *bo = gem_to_amdgpu_bo(obj);
-
 	if (sgt->sgl->page_link) {
 		dma_unmap_sgtable(attach->dev, sgt, dir, 0);
 		sg_free_table(sgt);
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Chawking.zhang%40amd.com%7C9555021bae2f415e1bef08d8da0e8125%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637499103125405709%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=y21rsObIUGSeS2XiFfVMrUNuD5%2Fc%2BrfXjOd%2BamdLa60%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
