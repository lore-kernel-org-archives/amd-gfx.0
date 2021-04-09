Return-Path: <SRS0=E5im=JG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2BD6C433ED
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Apr 2021 13:52:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7996661056
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Apr 2021 13:52:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7996661056
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1536A6EC28;
	Fri,  9 Apr 2021 13:52:11 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2047.outbound.protection.outlook.com [40.107.237.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6B1146EC28
 for <amd-gfx@lists.freedesktop.org>; Fri,  9 Apr 2021 13:52:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mvHdfeOVYUQ+bGdgOgsnfvgS6xbZFvmm3l4WmlWf2DiRDKb0jWMT7Px5Ds2SESrdZQqKEigKvCl8TwbgrwZkruFPyPm96G76Ctcrjr1gXAFhbwFxjxEgOYB5/W08KgNRjn47ndWGcU5bRkCJINpm1j57iEFNBiBDG2d5cJf5a6zCdkQnT7NHLojGn+ETIYPtbLtzMZmaURQJgja2kKbw1Pl+dcUG3qelfD40WzbiHyO48EOAhOIES/a/ULfFhF/6b9qvpR9ppNW9sbcNbvNZJqd6DSAxCJ1zM4Gl6tF5bTapJSa2DkhrH7qMY9VLY0N0Hhy/93yddTBDMigRZUMr7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RgyMMF3jX5tWX49lPWJySIuJEaAXyMeSmQaxGU4GNvs=;
 b=c3hXkip32QJpGruh1535PfiX1M7KbCbfdrb7D2jQx0uCyKgEJxLoh4OW7Npf6wGZRfMMlCt7kAxW2qYj+5dzNA2B3+qIobeieq1qUkWynfw3O9s210/LGLcjUzvX4v/ji3ECm7CrZECsS2wXQviBe0h89h9amk/Cc5bBNoAkZh2IHLXdPSrHURmcwI47SDF+bKU/X8uJytldefZz8VQ3hgooYG0Y3MCWmWj06IYzF60M3wEXxk5KK6q/XVlitYdegI4O7gX06dpHEqB66G4BOqjyoRVgMqq2IOSdOorqlX2sk0kbfNXwOy8Cqpqdb9FsZjLcXdyB/7OnAGh6rnhiuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RgyMMF3jX5tWX49lPWJySIuJEaAXyMeSmQaxGU4GNvs=;
 b=KqXUmav1wszbVWtLhBe3VMTqHHcHrFt1+Kv/bCETiVPAOOz46kRGj+ReTWpgLUdHCVJ/AozIj1R1bYxZCnykPXpq969huShyRp91mwJ6eYQIbRCd1tU02i8OyZLRX5/kRb80JAVwgFujJh0ruABlWeUTmdJoSZr8roySU+fivN4=
Received: from DM6PR12MB2761.namprd12.prod.outlook.com (2603:10b6:5:41::27) by
 DM6PR12MB3564.namprd12.prod.outlook.com (2603:10b6:5:11d::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3999.26; Fri, 9 Apr 2021 13:52:07 +0000
Received: from DM6PR12MB2761.namprd12.prod.outlook.com
 ([fe80::c5db:878f:cbb4:f136]) by DM6PR12MB2761.namprd12.prod.outlook.com
 ([fe80::c5db:878f:cbb4:f136%7]) with mapi id 15.20.3999.033; Fri, 9 Apr 2021
 13:52:07 +0000
From: "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>
To: "Zeng, Oak" <Oak.Zeng@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 3/4] drm/amdgpu: Introduce new SETUP_TMR interface
Thread-Topic: [PATCH 3/4] drm/amdgpu: Introduce new SETUP_TMR interface
Thread-Index: AQHXJy5i2nJczUz+8Eq9y6Ehz80cXqqsQETg
Date: Fri, 9 Apr 2021 13:52:06 +0000
Message-ID: <DM6PR12MB2761E2E617996470F3CC326C8C739@DM6PR12MB2761.namprd12.prod.outlook.com>
References: <1617305803-5767-1-git-send-email-Oak.Zeng@amd.com>
 <1617305803-5767-3-git-send-email-Oak.Zeng@amd.com>
In-Reply-To: <1617305803-5767-3-git-send-email-Oak.Zeng@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-04-09T13:52:01Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=c0bda370-3af7-41f4-9cc8-12cc7d512d9f;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_justification: I confirm the recipients are approved for sharing this
 content
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [2607:fea8:3ae0:384c:4df5:cab0:d20d:80cc]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cbbde0fa-023a-425c-5411-08d8fb5eaa0a
x-ms-traffictypediagnostic: DM6PR12MB3564:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB3564EF567B9024B3DD8655B88C739@DM6PR12MB3564.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: x8bnFtaYXfGCfTQ2pXa/+VzG7lz8BjrryBfLPpu/UmO/WQ9fniTBZzT2SAETyfmQT8ccOyDPlX2Lq8jBlNZgLUKVyet/1KFwF/PTvhp3mXf0f8v7Pgu5rebMArMgkhJD2GBT0TI2TB/2q3K0mMnMxTgiNCn3wgYvVRCQjq4re6jGXmoaXafAQk86TvtdrwCjSH3Y9Jj6YnVzT1OhFOntXzWybYXKqHkMFstcaAm+uGp5ccjdsvcBnvyQfRltQgIS5R39a5Dv7qJRuFT2sp7f0dXF1kV4buH5UFjNfGkGh/jQL91ii8JHswOkNt2ucK7NJTw3n70ghXl9DIaVi+ysEqYnze8S8FxtQKZ0qyTn29sk2U9km+UycTc4hz8bks+DczYIglDRnMZ6EApPsIWa29zzd5Dkg8AiLtnocBbC9Z+BxlwqIWdVxoFDdQL1yNYfCVDhTIgXHf1vCYgnX5J/G+pfPzvslcD7mcaV5YwaYtaEFZDt0pmbZO8+vWC36sKr4xoC/qK52mmjQ08GPgsUens4rG21wDHsE1FpOzgLVfxc3Dk7pCdtz21c+vHG8zT1Esp7PDfzLbxk7Ad9XMyNVP67OJC5wXg446crOYhixXelNHjYUbTFgFZeE3f9HiinQWFGRGjB52tmUeH4dAo71QVIQicXQoSFaMOw5+mqANA75TUqu887111yTr4oMhcW
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2761.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(376002)(346002)(396003)(136003)(39850400004)(76116006)(66946007)(66556008)(966005)(52536014)(66446008)(64756008)(66476007)(186003)(110136005)(55016002)(2906002)(5660300002)(478600001)(54906003)(4326008)(33656002)(9686003)(45080400002)(6506007)(7696005)(53546011)(86362001)(71200400001)(316002)(8936002)(8676002)(38100700001)(83380400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?UuFulcPCLUpcW3nwgzveSlZXWBuJ2hNtBauI9RbVcI4rRLsfzZfXcgn9HqYG?=
 =?us-ascii?Q?Am31RBToVdwNC9zvgnUlaXDEkGVF5RXHRV0dK3OIDSbBRE3X4dJfSzO24OUb?=
 =?us-ascii?Q?o0BbDncIRnSdI7/i5Fi4IHkPvytOap2u2KryM0OqSXKtp92QCFP7lW0TEi0w?=
 =?us-ascii?Q?6WDDKNGJ9VF6xeBht3HCtX/R3qGgxzk1/j4Yy+RhSrlU+zgjvGiYmP67X9oO?=
 =?us-ascii?Q?tkHkGal1cNcoEFT7uMrjC0fNoH+k0XloDvwVTD5XUFTCGx+B+yjKpwaDh7bb?=
 =?us-ascii?Q?3HxQLy5or51dHKh2AH2SBYV8ZELqvdu8mVKSw4tENtWTX4quUi2ERoWFrKkL?=
 =?us-ascii?Q?gpOOuHU61p5x71wCwavQxSCsg3Qjk5HV+YivY4owZY7V8ILzaGMzspBTQs8X?=
 =?us-ascii?Q?XEToEAeSkMkrRhGxEXUL8Ij2JhQ4YD6zOl6cIhNL4+55bREKfzflqZbJq5i2?=
 =?us-ascii?Q?VOBJusVQMwErieimmQungS47E3rYaHsYBbKMAQiUL1Xo3SccSiQ58M2G6jvN?=
 =?us-ascii?Q?bKpJQaMixsQYP1CcMWiwAIvoxSMhG+FZUrzmtiy4Qb7ezlMrSEZ8YvdbDj5K?=
 =?us-ascii?Q?38XFKcYU8U+ZNP6FoDMEdmE7goJ1gBk2Fk0qrjWjt0d3aKroEXr2iQVBB66l?=
 =?us-ascii?Q?yXF1XqlSwtHoY/xzPlnW3l6t/18kN7WfgQgQGojcBRll9lkbUByMep1hsYVv?=
 =?us-ascii?Q?I+CJJ3B2ol68aDfgU7sdN03NVHFvWImFTXC6oo7uoBPhtuKOPXGBTK3iy2dt?=
 =?us-ascii?Q?rVjxMSGhjU/fs7jcnMlfXuI+/rtJXZn1T4kTXqRic0pFkzd3ggdn5QhauclY?=
 =?us-ascii?Q?GMW4MiYTHhV+tP4aWwb84nf+p5TJbZjFjSd4w7SO9cuWYyh9JiB20D/EN4B3?=
 =?us-ascii?Q?FDiEkAgO1lIc2awmxhpMzyl9OaLsEwvCdKfWmZgc6dw/yWrZGLYFe/8PwnIv?=
 =?us-ascii?Q?vh/Dl7D4pLwTiGhhrfsoqbLJxj/dI8zOXoPHous1YYvkYxHGDgxTgH2bdll1?=
 =?us-ascii?Q?lQkFE8ucZL6UJAgYbdbTu4ZMSVpAltphzHtoPkb6jvZ/SzqWiCVbmdDdw4gj?=
 =?us-ascii?Q?qom13TI+ed1gCRtFYOcqr5jx5Jv6JAL2R/j8v1PdIeDW/eUPBQhNVXXZUffj?=
 =?us-ascii?Q?NvJjUM8cudjhBKhGrlORzQ9Dv49z23mERZBGHPJbQFVDaFB4Yuex79O7dZnW?=
 =?us-ascii?Q?73qQVzwXTOhGzng4hO1nzpradn2UGwRLlBybhj9I97VsbV7gqaKf3+300oNR?=
 =?us-ascii?Q?ezMlUmQNv4PU6tZoiDt3mVnF7++XmG3s7slZSV3fRuv/BgjLWVL2kK3YPhpY?=
 =?us-ascii?Q?41YDj9K4o92XHcaUjStPzGXKKLSQ4GvNJWV1BHeIhRifbRyB2ePv7lz8njZj?=
 =?us-ascii?Q?Ot2OekjxTRw53/qPFX2DcN9Oyyl3?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2761.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbbde0fa-023a-425c-5411-08d8fb5eaa0a
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2021 13:52:06.9187 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 58/QEWvATVNfDUt892T3yayKxjtJLFNdq0WxI5TUZ10HNnFLBgAnr8J5QW8Cncc864n2M6R+AdPjmqigV20rjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3564
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
Cc: "Kuehling, Felix" <Felix.Kuehling@amd.com>, "Lazar,
 Lijo" <Lijo.Lazar@amd.com>, "Koenig, Christian" <Christian.Koenig@amd.com>,
 "Zeng, Oak" <Oak.Zeng@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Minor typo. See below. With that fixed Reviewed-By: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>


-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Oak Zeng
Sent: Thursday, April 1, 2021 3:37 PM
To: amd-gfx@lists.freedesktop.org
Cc: Kuehling, Felix <Felix.Kuehling@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>; Zeng, Oak <Oak.Zeng@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: [PATCH 3/4] drm/amdgpu: Introduce new SETUP_TMR interface

This new interface passes both virtual and physical address to PSP. It is backword compatible with old interface.

<backward>

v2: use a function to simply tmr physical address calc (Lijo)

<simplify>

Signed-off-by: Oak Zeng <Oak.Zeng@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 12 +++++++++---  drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h | 11 ++++++++++-
 2 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 9e769cf..123ab31 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -328,8 +328,12 @@ psp_cmd_submit_buf(struct psp_context *psp,
 
 static void psp_prep_tmr_cmd_buf(struct psp_context *psp,
 				 struct psp_gfx_cmd_resp *cmd,
-				 uint64_t tmr_mc, uint32_t size)
+				 uint64_t tmr_mc, struct amdgpu_bo *tmr_bo)
 {
+	struct amdgpu_device *adev = psp->adev;
+	uint32_t size = amdgpu_bo_size(tmr_bo);
+	uint64_t tmr_pa = amdgpu_gmc_vram_pa(adev, tmr_bo);
+
 	if (amdgpu_sriov_vf(psp->adev))
 		cmd->cmd_id = GFX_CMD_ID_SETUP_VMR;
 	else
@@ -337,6 +341,9 @@ static void psp_prep_tmr_cmd_buf(struct psp_context *psp,
 	cmd->cmd.cmd_setup_tmr.buf_phy_addr_lo = lower_32_bits(tmr_mc);
 	cmd->cmd.cmd_setup_tmr.buf_phy_addr_hi = upper_32_bits(tmr_mc);
 	cmd->cmd.cmd_setup_tmr.buf_size = size;
+	cmd->cmd.cmd_setup_tmr.bitfield.virt_phy_addr = 1;
+	cmd->cmd.cmd_setup_tmr.system_phy_addr_lo = lower_32_bits(tmr_pa);
+	cmd->cmd.cmd_setup_tmr.system_phy_addr_hi = upper_32_bits(tmr_pa);
 }
 
 static void psp_prep_load_toc_cmd_buf(struct psp_gfx_cmd_resp *cmd, @@ -466,8 +473,7 @@ static int psp_tmr_load(struct psp_context *psp)
 	if (!cmd)
 		return -ENOMEM;
 
-	psp_prep_tmr_cmd_buf(psp, cmd, psp->tmr_mc_addr,
-			     amdgpu_bo_size(psp->tmr_bo));
+	psp_prep_tmr_cmd_buf(psp, cmd, psp->tmr_mc_addr, psp->tmr_bo);
 	DRM_INFO("reserve 0x%lx from 0x%llx for PSP TMR\n",
 		 amdgpu_bo_size(psp->tmr_bo), psp->tmr_mc_addr);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h b/drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h
index dd4d65f..96064c3 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h
+++ b/drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h
@@ -185,10 +185,19 @@ struct psp_gfx_cmd_setup_tmr
     uint32_t        buf_phy_addr_lo;       /* bits [31:0] of GPU Virtual address of TMR buffer (must be 4 KB aligned) */
     uint32_t        buf_phy_addr_hi;       /* bits [63:32] of GPU Virtual address of TMR buffer */
     uint32_t        buf_size;              /* buffer size in bytes (must be multiple of 4 KB) */
+    union {
+	struct {
+		uint32_t	sriov_enabled:1; /* whether the device runs under SR-IOV*/
+		uint32_t	virt_phy_addr:1; /* driver passes both virtual and physical address to PSP*/
+		uint32_t	reserved:30;
+	} bitfield;
+	uint32_t        tmr_flags;
+    };
+    uint32_t        system_phy_addr_lo;        /* bits [31:0] of system physical address of TMR buffer (must be 4 KB aligned) */
+    uint32_t        system_phy_addr_hi;        /* bits [63:32] of system physical address of TMR buffer */
 
 };
 
-
 /* FW types for GFX_CMD_ID_LOAD_IP_FW command. Limit 31. */  enum psp_gfx_fw_type {
 	GFX_FW_TYPE_NONE        = 0,    /* */
--
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Charish.kasiviswanathan%40amd.com%7Cbb65c9ed8c29468e999708d8f5458378%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637529026202976628%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=352fDfwixS%2FXTvz%2BsfQGU6oR6Xr3gRsOqzuWMEDfaBY%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
