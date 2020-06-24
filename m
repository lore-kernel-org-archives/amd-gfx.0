Return-Path: <SRS0=jISE=AF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82924C433E0
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Jun 2020 14:40:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5558B20738
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Jun 2020 14:40:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="fSEiC3BE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5558B20738
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D7886EB6F;
	Wed, 24 Jun 2020 14:40:19 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2072.outbound.protection.outlook.com [40.107.236.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 146CF6EB6F
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Jun 2020 14:40:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZW+OWQXX/nX+AauMCfubIPY/krsetXIXxG2ak6PHxHyoEuXwywKNi5oe/49yDZzePDkiMoqXVOk8q3Pt24GFLbkoRoxOuVcTbej23430X8FGfIaSUzyLWx7OVEc/sXItkYfqY9VMjuiC38ShWR240TwnfcGyEOIEk/oLLswLyxVpDN9QcapFcxmbqhnjL6lgHjeUVLjdBWKBgJAkdAf6uhNbHZLgaEW/xzGhtDRCGJlT1+3POZ9cDuVVruwq8k6YuIhBc1ZOAjlkWukEcC4k3MfjaAYxOMP4nHE3L7sVnx9+ITLGpJ6fcnHJTQu1TB/FPxKVDTRiEYAzvq+YYJPfDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KOLQJDFptyMkedRd1TtaYfusir8LXQ6aLpBKcaASBGs=;
 b=LFFo5SaSv8csvzZg3m1eUtVsDoDotReY1nLr0lRDxKUzY/0JRTXwoyiGHhTWq3FK+59xoMmQ+2bWZ4VPrBfd0a+FZEz7QGscwHj1C8UlJE/EAJg+iqEWKLPHKzbPJw3AlfwBLXt8wwOzWhIE6kN/NbpCIiwAqlvWIORHGh/0l1311B01tzJlhPYsJy9Ls7gsSok5QgiFXuD5vb9lSgaoClrHZHazkw4BsxBD4aUwJPFfxhkGkPG0MjHqgTYciGdNwRoIg1Kw6mtxSJgPezL8NNyzxXKGGyZwBpuWTkHBufHgJ48hlSZTKwXHRi1+ny7G/Ot1njuEIfwVqHkF44KeUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KOLQJDFptyMkedRd1TtaYfusir8LXQ6aLpBKcaASBGs=;
 b=fSEiC3BEZT0kN54yGQspyf4KS0PpzoxYNVE6MD85oCmv2Sxj1qtg8OOkvpROhQldN5GyzfXXr889T5MfdIix+pWNKm7koT1VFMgC4Ztdf5o69E8OE5EA3ppsYRqCZn32gLA9mrLAj6HGxmyzlfiB/sc7cBYzxUafodsUxQzmn24=
Received: from DM6PR12MB4075.namprd12.prod.outlook.com (2603:10b6:5:21d::8) by
 DM5PR12MB1162.namprd12.prod.outlook.com (2603:10b6:3:72::13) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3131.20; Wed, 24 Jun 2020 14:40:16 +0000
Received: from DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::81eb:c31f:a63a:20eb]) by DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::81eb:c31f:a63a:20eb%8]) with mapi id 15.20.3131.020; Wed, 24 Jun 2020
 14:40:16 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Sheng, Wenhui"
 <Wenhui.Sheng@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: reduce ip discovery data reading size
Thread-Topic: [PATCH] drm/amdgpu: reduce ip discovery data reading size
Thread-Index: AQHWSjSuqRLQ4Ii+R0mZ/VlIucS3J6jn1VbwgAAAZ3A=
Date: Wed, 24 Jun 2020 14:40:16 +0000
Message-ID: <DM6PR12MB407572BBC35F7DBCDFF5CFA6FC950@DM6PR12MB4075.namprd12.prod.outlook.com>
References: <20200624143500.4062-1-Wenhui.Sheng@amd.com>
 <DM6PR12MB407577521877A857EB246E08FC950@DM6PR12MB4075.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB407577521877A857EB246E08FC950@DM6PR12MB4075.namprd12.prod.outlook.com>
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
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-06-24T14:40:12Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: 5a463b47-11b3-4177-8ebc-00003df4cf9f
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5f16253b-a15e-4a1f-aa8c-08d8184c82a5
x-ms-traffictypediagnostic: DM5PR12MB1162:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB1162F3535F8F16B08C54B204FC950@DM5PR12MB1162.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-forefront-prvs: 0444EB1997
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Djf/YcSPeupiuKgBJmMIMs6utYtZu1ih/LA8x8dH34tHprxOwACCp5bXmXBtBb44JMA52zyAyzdXDc7/vZm4w2EDPe3IcBSz9r6P79GRczrinOAMgDceVv50PvB3S6qRo4kCsPafIjQmPQjZnYdWeC5KwTpHBh9H71IrjnmZHR2A1337nBXXqVWNoUvVwaAMPNxq9r1HJvghReDwG0s7+hZRZYucw8H9IY4HKKD/P7E4lW9iQiNzFcqMXdYg5I+lkIi++J9q+U6Qqhp0Q2u75o9LQvUhMg5FXVgpvtTP43OeV7pWW0WKGpMa0q0UpQ1Zpyoi3FCrrzeHQnMsurmbYg38BHN7vrEG7q3MQbbRb+s=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4075.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(346002)(376002)(136003)(39860400002)(396003)(83380400001)(5660300002)(76116006)(66556008)(45080400002)(2906002)(66946007)(66476007)(478600001)(64756008)(66446008)(33656002)(71200400001)(9686003)(4326008)(55016002)(316002)(186003)(26005)(86362001)(7696005)(110136005)(6506007)(54906003)(8676002)(53546011)(52536014)(966005)(8936002)(2940100002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: OSM/CrOcVdlh/gYscECkYRMNLQoJOYTeBnIUfkHEwhf6Y5B3fI15t4DgSTkA8TkDG8Wwehi+kHuGJcFwI2mlcFGlwDFw3pyOBIjPxn29zCt7ALMqq1K2zZ5kys3b6MfM4ehX2y5c72TvqVPpI7SvKoT48pjcdv3Xg1NN2q3iiIay6upqnJHkoMkNEG2MzZ625d3mlhY5nfzvfHyi54apSWjVJA20t3nvCubEkUIjEk+gQM1wrLZV8n1JCr2dRn+m9c9PmqfHv13CQ9QPUwuK0sCi8F0HzaZqPVw3XxX4Ym5dC30gzX90qlknIMTzJTRe8oRF4qej6cj42NfQPFkKw1ndfax574bVRKrkcdoNQH9IWJ37CEsYroVMIiCeKJdPjmJhpGXOPLES1WRYx16AklsmELlM7Lx8ZWg18gVOSF2LKAx0I/v/GA10QHMqDeb5ZzRFSg2T4EbNAE6BdHzecpC6br6FfGbKxOQeHisjyxtMJahRTLeHzkzK6uyA2qxD
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f16253b-a15e-4a1f-aa8c-08d8184c82a5
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2020 14:40:16.0853 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NSIQTpPLGIU2Odxk438IwRsVDn1XvLRG1unZP83CkCpRiSnUZoPx6+b983nFUwW7zssqpSvmF5Y5c9n9ht0w2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1162
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

To make the description accurate, Let's say only read the first 4KB, starting from total_vram - 64KB, for ip discovery data. 

As discussed, no matter the TMR block is 64KB or 1MB, the ip discovery data block always located in the same offset and with the same size (4KB)

Regards,
Hawking

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Zhang, Hawking
Sent: Wednesday, June 24, 2020 22:38
To: Sheng, Wenhui <Wenhui.Sheng@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Zhang, Andy <Andy.Zhang@amd.com>; Liu, Shaoyun <Shaoyun.Liu@amd.com>
Subject: RE: [PATCH] drm/amdgpu: reduce ip discovery data reading size

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
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Chawking.zhang%40amd.com%7Cc75e531858a14284e76308d8184c237c%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637286062575076037&amp;sdata=SPvXL4K0IFq%2F2d1p%2FXYqGpOT%2FITSyDsKnBktFbBgW0M%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
