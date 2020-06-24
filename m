Return-Path: <SRS0=jISE=AF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04C68C433E0
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Jun 2020 14:37:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB8CE20781
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Jun 2020 14:37:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="klkWY7vm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB8CE20781
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B9FC6EB89;
	Wed, 24 Jun 2020 14:37:34 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2057.outbound.protection.outlook.com [40.107.244.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 057636EB83
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Jun 2020 14:37:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ync/ebMnEanZxwDxD7ENDOJ1LV0iGvIubWQ0+1ze3DemsQsixuXQLetCcsOKZ278FPJ6lwQLBCo+6sadcehnY21NCl0Q1stahc1jHqFEHXDekK9w/ysplWgtqtlOHdBmJfyvRwsAAPTSauf+KvjBi4LvVcomHIb3PFhF6MnaxU6G92qWYAu0XYb7V1uqwJkVCskt2Rd2W2vpGp8D7FWHOgzm3sQjLAnELf3Qgf01je25ttXL51ckvtIrhnuwyOJXs+eYpezLMZ7GAh7vZh69BVYzadoco9WPCYmn75fakdtAF8os3HXGSENv7NFThwTQz865DhUD1sTbLS82GwJJYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vZwTQj3PdqUjtx/Nh3deCtB+tyuNYhUXP0KMAjSrs7I=;
 b=GaKDvltagMyHaZJXK+h9ThsXYP6tGz5gIQdgRRpL6NL8u9JShEIWgpUlEp7CvcOuhk7nPPAgT1k7BHux56nojAE8HRy1z0wOQtvj/2rAE9vQ0YwjRgEQ0nfEmnhGZRGxgCSiKlvT3+s2QU9evbolkAEgz3Z33jOL8qTbz9gi4ZMcpY4pVckDhroDzjE+tBgxKHwChON4noHETmhqXBBHDbWlCopIHd/rWyqHpzWhmkv5vveuU+g5POR51eT9ydZZ5VAd5cg5ZDMWxVOtVQnfAXnhgpwOFpZw/A1DmwpNbxQHQmqutbwmx/SFvRXTxPh4WBxQ/3btopU/fn36E5MYeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vZwTQj3PdqUjtx/Nh3deCtB+tyuNYhUXP0KMAjSrs7I=;
 b=klkWY7vmelreIF/EVPyRFbJ/ghdrSBi6ZOuZS1gh4QGjlU9z68vStKvz5vfyJYExAQ++FulSANgGehXWTxZoAiS9hL5z1Ipe12+fSmh+9xPx7ynTJCJ/rpA0MZsHBOoEY5/7/Y/+r6qndHfjD4z98nUX4eJtYM//dKEhi/mz8ww=
Received: from DM6PR12MB4075.namprd12.prod.outlook.com (2603:10b6:5:21d::8) by
 DM6PR12MB4075.namprd12.prod.outlook.com (2603:10b6:5:21d::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3131.20; Wed, 24 Jun 2020 14:37:32 +0000
Received: from DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::81eb:c31f:a63a:20eb]) by DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::81eb:c31f:a63a:20eb%8]) with mapi id 15.20.3131.020; Wed, 24 Jun 2020
 14:37:32 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Sheng, Wenhui" <Wenhui.Sheng@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: reduce ip discovery data reading size
Thread-Topic: [PATCH] drm/amdgpu: reduce ip discovery data reading size
Thread-Index: AQHWSjSuqRLQ4Ii+R0mZ/VlIucS3J6jn1Vbw
Date: Wed, 24 Jun 2020 14:37:32 +0000
Message-ID: <DM6PR12MB407577521877A857EB246E08FC950@DM6PR12MB4075.namprd12.prod.outlook.com>
References: <20200624143500.4062-1-Wenhui.Sheng@amd.com>
In-Reply-To: <20200624143500.4062-1-Wenhui.Sheng@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-06-24T14:37:23Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=99c75768-f6f8-4119-988c-0000673ac7a1;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-06-24T14:37:14Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 940c72a5-5c40-478d-94fa-0000d10d441a
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-06-24T14:37:29Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: 4ed215c8-577a-407b-aeef-0000e746c601
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7d397191-e3c8-4520-0913-08d8184c2106
x-ms-traffictypediagnostic: DM6PR12MB4075:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB40754A452BBEA851A4A02EEDFC950@DM6PR12MB4075.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2657;
x-forefront-prvs: 0444EB1997
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RHI5qKpLukp4srwi81gsKZEBiBwL4rtuB5HMflwojctxDbffasrkhq15qMo9m5MOZdSJ4uMjjMHp8rORtoUtuucVUmfHcOuGORKHFQ1Ii73YUd9XRNAHvVlJVfrFjnorOXJzNmZyjBKFQKzOnRC1+Jnydp9CTtFAOjxyVYIy7gxiZN3JQC10ncLUlmhGE3sgk1XtntkG2FEaH4vjmoSv3DcuNzDqoXedw/oTEKCgOVDjDq1T2mxtFJ2FyjPdq8JPbFWN8wuDM165PMKpetGoY0jAQ9gNdpPBO1IHkboq592g9IWkcC18bg1e2S/ipjb0anvqw5kmLWIpib7h7scBSQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4075.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(136003)(39860400002)(396003)(346002)(366004)(4326008)(186003)(76116006)(26005)(86362001)(66446008)(55016002)(9686003)(66556008)(64756008)(66946007)(66476007)(52536014)(5660300002)(71200400001)(7696005)(33656002)(478600001)(6506007)(53546011)(8936002)(2906002)(54906003)(8676002)(83380400001)(316002)(110136005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: MxcjGZM/vGiFk5lScSDbKJ9gTefb9OP4k+U+RMw4t6/ORyBbL+O9IS5g6aYW9ZTw0ib9l0YeJakWdhYFt0yEuUh4xSVbfaxARqK05Qr5Gdp58Lrg6kloqzH5GBJv0apgAdx2bnHlKBvb86zLkTzJ5dCfcVf5RhKpRXakBU/bq2T7g2hWDOx4onMtDs/gehf9d78CUgjXUzaJFpNFlQkD/h/XoPIWoFoVc+7FamJCADweqE6QN5cpqyZsatuseGBTU07HnXZ2JtC3XHeeuXhFFGSTyi6bedmaCkXf/VJ0SKYXHdVGV4Vgx3zB5xA9V1gdeLAiWdKFDLVobBRwh6nCofBUBOroDY2q4D416XYiOR8sK0BCzVcnwXMUC6yHV0pxac47ntuhJf8wLaY7YiiPRO1gDkrC2jtJC9zgRxjMaV9Z7KuRcHvokJ0RyT5aeEGWFg0scVj3gjQn0HNiP+yUu/bWXRvuaq5ICDxkLRqj5AxTOppkZdA4XjOOkdyUSacF
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d397191-e3c8-4520-0913-08d8184c2106
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2020 14:37:32.0752 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FMDJPbK4vynVtJ6eCMJ2bjQ30WhflGzVcm4JQ9ONIru6O0TKISvREVrKoD2hdNgPHIudVJSCIyzjueiKMnB1kw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4075
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
Cc: "Zhang, Andy" <Andy.Zhang@amd.com>, "Liu, Shaoyun" <Shaoyun.Liu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Sheng, Wenhui <Wenhui.Sheng@amd.com> 
Sent: Wednesday, June 24, 2020 22:35
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Sheng, Wenhui <Wenhui.Sheng@amd.com>
Subject: [PATCH] drm/amdgpu: reduce ip discovery data reading size

From: Wenhui Sheng <Wenhui.Sheng@amd.com>

Only read first 4K data instead of whole TMR block, so we can reduce the time in full access mode.

Signed-off-by: Wenhui Sheng <Wenhui.Sheng@amd.com>	
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 2 +-  drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index b5d6274952a5..82c048766745 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -133,7 +133,7 @@ static int hw_id_map[MAX_HWIP] = {  static int amdgpu_discovery_read_binary(struct amdgpu_device *adev, uint8_t *binary)  {
 	uint64_t vram_size = (uint64_t)RREG32(mmRCC_CONFIG_MEMSIZE) << 20;
-	uint64_t pos = vram_size - adev->discovery_tmr_size;
+	uint64_t pos = vram_size - DISCOVERY_TMR_OFFSET;
 
 	amdgpu_device_vram_access(adev, pos, (uint32_t *)binary,
 				  adev->discovery_tmr_size, false); diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h
index d50d597c45ed..8f6183801cb3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h
@@ -24,7 +24,8 @@
 #ifndef __AMDGPU_DISCOVERY__
 #define __AMDGPU_DISCOVERY__
 
-#define DISCOVERY_TMR_SIZE  (64 << 10)
+#define DISCOVERY_TMR_SIZE      (4 << 10)
+#define DISCOVERY_TMR_OFFSET    (64 << 10)
 
 void amdgpu_discovery_fini(struct amdgpu_device *adev);  int amdgpu_discovery_reg_base_init(struct amdgpu_device *adev);
--
2.17.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
