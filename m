Return-Path: <SRS0=Z3Jh=FT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53F51C4361B
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Dec 2020 06:52:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB41122285
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Dec 2020 06:52:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB41122285
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5CD176E0D8;
	Tue, 15 Dec 2020 06:52:48 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2064.outbound.protection.outlook.com [40.107.237.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B08EB6E0D8
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Dec 2020 06:52:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cDCb52aepPcai8F8wJX1vKH+1vrI2ZiuFI4rFtdFWPeXNuUkAeIRhnCho6WxR9FZZfpZwhJdFlJSvVL3m1uZD/vwcBdZ7MFGU2a9QV9lI8l75HHoX4IPh84+cC7fYC0zaBNmZLeZ30ig+e5uygj3aqsfh/nRwYgcOVLjCo0xySLV8VpdWdXRcntcsU3vUXJ4Fjbi3rHWgc9gjW/aZxQAwo5hn7yumPK1U88vfKZ5mIsw2URz1MrYgH36c+1u2FzsX4SNLAhy+YmHnL4y09ZQpNHpHfbKGbJ3ln1kwC/NZScHknON6HsfSMYlNJ/0BdMLgoWNQujtMzL766VcNm3UTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wv+kL5x0LWpddiuNV7VmaJuSQj2xCIjhcgiAtqkZCiA=;
 b=gfYT5L7JbBc6FwNFVKJbc6SwKu9trY+cnwdplF/hk9StyNZbmVno1aavliYWYx3pr0+kQJA3gOKPhlchmbB1pGTizKaOIXATrLfbSdN/hLuyZOnM6l6C97a4xaaovmOw5fUOtOc268At1S5D0Df7Xw0isXSM0Tj6JJC9IrlYqk768FagpCGTt3vTpP75JliQfqOPQbqolWXI3zx2G1q1ZrZXfwrMScILUUeypSmp1TyKqITJwjSiAv5kVEbf494dhhTv6iXNWC2gThBFxua5IdMQgSJhxlsI3d1jYAX4JoYs1sVLwzFgXfNBSiVyFNmexQ6WrCmTRR9AWi3271QLvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wv+kL5x0LWpddiuNV7VmaJuSQj2xCIjhcgiAtqkZCiA=;
 b=awSl3w3g63nYjkpn3VnvpOY5vQazi9AECFlYxBobFh88ytLn6gAJE7hiTLcjzrmeycI4/TT7xHa6iphNaKrpqhI1MHMzNSjewwjWTcu//XcT6LvF/CAM3rKKg21O/l3oM11rD4PVhveCuWpg0lKFOKSxUJf3H7iT66oFUbQIlEc=
Received: from CY4PR12MB1287.namprd12.prod.outlook.com (2603:10b6:903:40::8)
 by CY4PR1201MB0037.namprd12.prod.outlook.com (2603:10b6:910:1c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.17; Tue, 15 Dec
 2020 06:52:44 +0000
Received: from CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::bc0f:dd2:ef80:de2]) by CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::bc0f:dd2:ef80:de2%12]) with mapi id 15.20.3654.025; Tue, 15 Dec 2020
 06:52:44 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: fix regression in vbios reservation handling
 on headless
Thread-Topic: [PATCH] drm/amdgpu: fix regression in vbios reservation handling
 on headless
Thread-Index: AQHW0jK2bM3uWivptE+5lwcfGieyh6n3uS0A
Date: Tue, 15 Dec 2020 06:52:44 +0000
Message-ID: <CY4PR12MB1287AAC9F459FB3DA433EAEFF1C60@CY4PR12MB1287.namprd12.prod.outlook.com>
References: <20201214160335.771801-1-alexander.deucher@amd.com>
In-Reply-To: <20201214160335.771801-1-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-12-15T06:52:02Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=f5c6a869-7e6c-4a06-9a50-000003eafcb6;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-12-15T06:52:42Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: 338e272c-9b38-4804-8da7-000069f75fa2
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
dlp-product: dlpe-windows
dlp-version: 11.5.0.60
dlp-reaction: no-action
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1379e930-b843-4def-2032-08d8a0c60683
x-ms-traffictypediagnostic: CY4PR1201MB0037:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR1201MB0037A0B84D9121A602CE2B7CF1C60@CY4PR1201MB0037.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:224;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sYc72OZu+i8IxzhtUQG4km9FcwLo0DyQhlLE1bJoXxUwb0IKVRIH9XMAQ99Gvk/O0+hI8SGIdIfDuujxAQF1Ztr693pCyb1zxXi6T5wwXiHygw/XiXvmxLMLQRJU70fV7scYA4p7k4p4WcDC/K2ngEVHxEbRz7O7j7ruU5t2pjsOiT3csnTV5n1F1vlL8iDJ2B8IVLh9dnu5opjQF3mHdt9Z14CoDiGWVTegK1ayKGlaJaa+VAj3ShRJRswUDxrOGdA6KUew8aTsw2Qh1OlZ3+yXkY/bdx8rVYNUZK5ULH8vZIjP8f2gWFKOokfKg9eRpbXkoeeadzxl4F6ZQbc4fstmydjeY5cbyRRIn4IVvgQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1287.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(366004)(376002)(136003)(86362001)(66476007)(66946007)(66556008)(8936002)(76116006)(186003)(55016002)(64756008)(8676002)(966005)(26005)(5660300002)(53546011)(508600001)(6506007)(9686003)(66446008)(4326008)(33656002)(45080400002)(71200400001)(110136005)(52536014)(83380400001)(2906002)(7696005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?jh7bylQWt6SXXBKiNvQjqUlWuNhSQ35fOVpB6re998UOPSn+7WSDOcOpGYiR?=
 =?us-ascii?Q?nst41m62ex+HHomt+6cJH3/xPRSYxf0NawC+mxmx5P7g4gdwwHKRaMLcHa/4?=
 =?us-ascii?Q?5OEfRk88WHKZfzbXo1zkqbyhc7e+sYRMI0R5j6Kqg1GhDg6J4fhBgt+bx3/Y?=
 =?us-ascii?Q?CZSr16WNqZ6t3ll0WzqeLNkX01KuMlJaq83BzgOI40L+R1j6BKwgQHfMsLEx?=
 =?us-ascii?Q?UvR25/envaSYvkIeO9hksg43QhJFh0QxxdZS9EQ2D333axyFsFLMXdi6Ckdf?=
 =?us-ascii?Q?I9Ix6Rv5uctFLwYtuVq+/yLayyUqCr1zbpwAKxML+xcegwPoMHTl5xst7Dwi?=
 =?us-ascii?Q?dGXCaJl5h0yFlBzzYTzaNbRE0Xm7G1C2UMIVdXvM7oj1PdwhN0feYFYHkT/I?=
 =?us-ascii?Q?yFpeB/hRuPGm/61o3OnA3i6zR+osRjkIGHdsgFUKVcmhLOPNHvyhxtZ2FyZM?=
 =?us-ascii?Q?oBlakhdV3WZPq352dSxUEnXT2+ab+eJMgHSOs13wFQLOYnJnQnV3GBLOcVaD?=
 =?us-ascii?Q?Jr+rojJil4QzievMzt2z5d8sQYJtaRY50jdmVLAopGwQcuczshcC1HSKw4R0?=
 =?us-ascii?Q?hA4wv6IAb+uM1PH72Bv4FEgv13fBd/O0xPFp/sc8iHJPKa0ynlXT/BPCF01T?=
 =?us-ascii?Q?IpkVJFuVRZHH8/aQX07WtjdagmyjV3olz77HIm5pz/L9KBMp3zmj+qUxrVPS?=
 =?us-ascii?Q?Ob5DL415KOV4u0NqymSG24i4vL636XWw7c/yh9rpuLztqIMQN/HHYz6JhDje?=
 =?us-ascii?Q?sy7S8IWwHSWfV1DGCy6Gq19FURIlal42bUr/vCZ/Jr4TleAUoGdHokAhqF3I?=
 =?us-ascii?Q?YYEXy4Z6S9wKslYvYTlV0uL8S2/fCnOzfb+Z/A4O7ZR66EVqgCzAvcFxNE5e?=
 =?us-ascii?Q?KpXPwWlV9XxuwqhUhFjv4Xp7CZVPObvsKe8T5mDOZFFxtGLqM2jHDNPCslBQ?=
 =?us-ascii?Q?ZkcOJ1X6HUTukg9F+juCD/KyhN/geg6sTx97Yl6CN3db/EHbV0W6ljnARawH?=
 =?us-ascii?Q?V9li?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1287.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1379e930-b843-4def-2032-08d8a0c60683
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Dec 2020 06:52:44.5321 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HH1YKQ/vS/doSU9tMoxDrz2WrAoBQO5BtI8TDPOM+itBuFeHz68MRh+cS+T2GBYhfMmk70/SfQQkorUC/v2RYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0037
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

[AMD Public Use]

Reviewed-by: Guchun Chen <guchun.chen@amd.com>

Regards,
Guchun

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deucher
Sent: Tuesday, December 15, 2020 12:04 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: [PATCH] drm/amdgpu: fix regression in vbios reservation handling on headless

We need to move the check under the non-headless case, otherwise we always reserve the VGA save size.

Fixes: 157fe68d74c2ad ("drm/amdgpu: fix size calculation with stolen vga memory")
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index 02af47ddddbc..c2ced5be6d7b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -496,13 +496,14 @@ void amdgpu_gmc_get_vbios_allocations(struct amdgpu_device *adev)
 		break;
 	}
 
-	if (!amdgpu_device_ip_get_ip_block(adev, AMD_IP_BLOCK_TYPE_DCE))
+	if (!amdgpu_device_ip_get_ip_block(adev, AMD_IP_BLOCK_TYPE_DCE)) {
 		size = 0;
-	else
+	} else {
 		size = amdgpu_gmc_get_vbios_fb_size(adev);
 
-	if (adev->mman.keep_stolen_vga_memory)
-		size = max(size, (unsigned)AMDGPU_VBIOS_VGA_ALLOCATION);
+		if (adev->mman.keep_stolen_vga_memory)
+			size = max(size, (unsigned)AMDGPU_VBIOS_VGA_ALLOCATION);
+	}
 
 	/* set to 0 if the pre-OS buffer uses up most of vram */
 	if ((adev->gmc.real_vram_size - size) < (8 * 1024 * 1024))
--
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Cguchun.chen%40amd.com%7C6e2ac830fdaa4d6cb9a008d8a049d71e%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637435586296954490%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=1hJTxX95ydbW92ukjgJHvc9L3kC2%2FWCDJKBpAVnbpuc%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
