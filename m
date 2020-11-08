Return-Path: <SRS0=syDT=EO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C9D2C388F9
	for <amd-gfx@archiver.kernel.org>; Sun,  8 Nov 2020 13:42:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07D35206E3
	for <amd-gfx@archiver.kernel.org>; Sun,  8 Nov 2020 13:42:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="iOQ2rRj6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07D35206E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 57FF78987A;
	Sun,  8 Nov 2020 13:42:49 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2050.outbound.protection.outlook.com [40.107.93.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A38728987A
 for <amd-gfx@lists.freedesktop.org>; Sun,  8 Nov 2020 13:42:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=He/SaM7ByeyIY/JjUPG9PMkJ9YC07/k94waAl5zlSyvQQknyYaU8m9BanQrIOaim47cPFgDWSls+YFrOj28VU/94MvGwr9hZBBotPr5Yi9nwURKmY10j8ogby2qw6p7cd06bNXHeoK/3BUc2qW4+Pjy31tfB4NLsxKJEMaXwudvNkaArU3FsR6fn4PmsbH73BQFgDb75E8npxk/CBokhv72vmL9c0dJGcaV4nEZP4sIwFZizpdAKwIdDZMmg/jfOIQBivH50f97SZl8cmSjo4exq96A9ImrR3+EMUtvcwGZl7OrJ0JdW9eXOpVD3XUF9wuTaLdgGOLulmhSBp8o/1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+x7cFSqBs3gEAJZpDglox7Pj6aXT+6uXWs/zo8aHgmc=;
 b=Wn/DVEVgZjPzKdgVOpds46nPqr4rHCpUzuxel01/vs9CSJy2ftJ/MZqoLJynO6SuyED2DCTCAipmJ1Vu2OzNkxSZhZpPccUNhzKs8xXxHeAKFnbopAmRTVOewty/eQtHxCPjzDTCrgDI/9BJwLr7UR6sMRXOQOYfGhCUNS7KRLkx+efYTGdU/KpYzZaXzoEwGEGJTlbHRKlsYjcgHCjfP7MXwujy5BmyqNqkNpUWPrgvOXSK4StEntTFQCm7N2yWLR30tGDNa12doB4D04lJQx9zZA0wryyWFf2/kP8d7R7LLFMpephy4zrjdfMr/y752KAv/ZOTP73KbDltuDKjHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+x7cFSqBs3gEAJZpDglox7Pj6aXT+6uXWs/zo8aHgmc=;
 b=iOQ2rRj6iVpB2blBB83Z2hgy2bw4qxPErIjUXA1azKVewXwjZO88G9wDZULq5lDjkw7dEoOgYZPmMXsAQ2/gYZi1jJkQYxIzcYCcfWcrYEwpDTC7P5cGUIj6/ZAM68LaHGBqzGapnanT/LkTxgNqD6/e/H1EfAzRXQpFbuAj2nQ=
Received: from CY4PR12MB1287.namprd12.prod.outlook.com (2603:10b6:903:40::8)
 by CY4PR12MB1653.namprd12.prod.outlook.com (2603:10b6:910:f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.22; Sun, 8 Nov
 2020 13:42:46 +0000
Received: from CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::ad96:acee:5c1c:d92c]) by CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::ad96:acee:5c1c:d92c%4]) with mapi id 15.20.3499.032; Sun, 8 Nov 2020
 13:42:45 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Yin, Tianci (Rico)" <Tianci.Yin@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: enable DCN for navi10 headless SKU
Thread-Topic: [PATCH] drm/amdgpu: enable DCN for navi10 headless SKU
Thread-Index: AQHWtA+pYekxxD6aCkGUUoUTcRLkXqm+QagQ
Date: Sun, 8 Nov 2020 13:42:45 +0000
Message-ID: <CY4PR12MB12870FD6197853EEAB216DE9F1EB0@CY4PR12MB1287.namprd12.prod.outlook.com>
References: <20201106073659.53993-1-tianci.yin@amd.com>
In-Reply-To: <20201106073659.53993-1-tianci.yin@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-11-08T13:41:59Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=5ae9abdf-17bd-483d-986d-0000045308cb;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-11-08T13:42:43Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: 13df8097-4259-42d3-aace-00009110ef27
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.158.166.36]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e4d0f37e-98e8-411b-827a-08d883ec2cc5
x-ms-traffictypediagnostic: CY4PR12MB1653:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR12MB1653E61B79DC077AF6B44604F1EB0@CY4PR12MB1653.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wS3uArUca5xW8dUsJA1XW9UbORKuOug1QjF6BKDBVljWDEbQuwsXiJo/lOtG1P6AkudfeCSN67WAfONaJpLkCdmMIGVcMcDm6HBB13dIFulbKL8tbFAgwSJ8fBHi+AO3xYv16RUg0f8L29kXCs3ZlNuXNTM2Ce4UHk2YTyiBTOkiNe10yjuTsu1RsJn2hQR1yD2EbI18G1F3kbHoNofI0f9jRZrVTQKOC13pHcvwdSiP8THetR3lTC3nEWQsaL5kKbmFOhQ2iDy5imp02AOL7/VQLBV5AasBy23kDjGofmTQECiDUntlM4gcUGLBY1A8jss8ZQGVH4/Kueuvd13OtMN4tXNYwIgHsSuPW2aDPpg=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1287.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(396003)(366004)(346002)(376002)(64756008)(66446008)(76116006)(66946007)(71200400001)(83380400001)(7696005)(86362001)(26005)(186003)(53546011)(9686003)(55016002)(6506007)(33656002)(8676002)(66476007)(8936002)(966005)(2906002)(5660300002)(66556008)(110136005)(45080400002)(52536014)(478600001)(54906003)(316002)(4326008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: 2iWn4QrSRFvDh0W04212ULjaycTtUqu9Ucev7vGCn5wdWbZnceCg5fs8t+NH5GdYLVpoOYK1ihxaBAqbIMdhQeW6C1MyoGohylYiSG2Zdh5mF1F6Jf7QUmC5042IOM/zQUzdlqHyNkXqtYUAnutTa152RNFHIrx5/CFH6XrejkQ/Un38h5AL15ZzWW5LfOepvGNwuTDJtcYKY/FskNJp/leYMLQC+32PyMrhIeFLeO0I7jbB7LU9iqaQO4psgFS74E+0o9DSVTDfO4RMnP3sJSLJewVLAYcb3Wj9t4UO7+WQ2Fm9FauDWW0rMchbPC8ptcczXIFUvY2wpAhpOzKoEw6zoYJ58FrX91eqxwHjqop+Kax+FxZUj7mDgoc+gUKKngF/D+eOwf52hzjkk70tH1FgS73ml6ok0LJVqZ5x+QXiGCol6pWVIk85g9P/Ymt80RCDo/WDXYYNVfXRQRKbsjWsmdMEO8z0O6tUCoT9QDT1ION5qlOZb7VkFst4inFFVqe5SZT8+aGMnCdUZrXaTzCKpGc8jpwp0hgsHU/+M4JIkqKGD7DgNuQP2kq4Bduxc9dgGMjnaL2Xl5v7NjXcN44hnx/JJMvpDINWbnwYalW/eR9mKwbXboliLQYFgJzth9xVY0uUe7Nj4y3RtzvyBg==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1287.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4d0f37e-98e8-411b-827a-08d883ec2cc5
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2020 13:42:45.8197 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JoWD6u9d2z0FWNDlUYofJfVypFP9Kvhj6lVKAIYbqMwPDHewr3rU7aoSgN9l+pIQw+7VVOeUKoMImBCpbp9vpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1653
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
Cc: "Long, Gang" <Gang.Long@amd.com>, "Xu, Feifei" <Feifei.Xu@amd.com>, "Yin, 
 Tianci \(Rico\)" <Tianci.Yin@amd.com>, "Tuikov,
 Luben" <Luben.Tuikov@amd.com>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "Cui, Flora" <Flora.Cui@amd.com>,
 "Zhang, Hawking" <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

Reviewed-by: Guchun Chen <guchun.chen@amd.com>

Regards,
Guchun

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Tianci Yin
Sent: Friday, November 6, 2020 3:37 PM
To: amd-gfx@lists.freedesktop.org
Cc: Long, Gang <Gang.Long@amd.com>; Chen, Guchun <Guchun.Chen@amd.com>; Xu, Feifei <Feifei.Xu@amd.com>; Yin, Tianci (Rico) <Tianci.Yin@amd.com>; Tuikov, Luben <Luben.Tuikov@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>; Cui, Flora <Flora.Cui@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: enable DCN for navi10 headless SKU

From: "Tianci.Yin" <tianci.yin@amd.com>

There is a NULL pointer crash when DCN disabled on headless SKU.
On normal SKU, the variable adev->ddev.mode_config.funcs is initialized in dm_hw_init(), and it is fine to access it in amdgpu_device_resume(). But on headless SKU, DCN is disabled, the funcs variable is not initialized, then crash arises.
Enable DCN to fix this issue.

Change-Id: I33bc30210e3420e60ceb59175e39855d00b05b06
Signed-off-by: Tianci.Yin <tianci.yin@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nv.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c index e33d8022cc32..67375b2948f5 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -535,8 +535,7 @@ int nv_set_ip_blocks(struct amdgpu_device *adev)
 		if (adev->enable_virtual_display || amdgpu_sriov_vf(adev))
 			amdgpu_device_ip_block_add(adev, &dce_virtual_ip_block);  #if defined(CONFIG_DRM_AMD_DC)
-		else if (amdgpu_device_has_dc_support(adev) &&
-			 !nv_is_headless_sku(adev->pdev))
+		else if (amdgpu_device_has_dc_support(adev))
 			amdgpu_device_ip_block_add(adev, &dm_ip_block);  #endif
 		amdgpu_device_ip_block_add(adev, &gfx_v10_0_ip_block);
--
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Cguchun.chen%40amd.com%7C317e06850aac4667ccb608d88226ca40%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637402450416710143%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=kF9LlID5Di%2FFivWvtiBQWhtXefE%2FuZ3C7tgXCEQFuQU%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
