Return-Path: <SRS0=jISE=AF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B31CC433DF
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Jun 2020 14:43:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57B7220781
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Jun 2020 14:43:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="IJTaQZRC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57B7220781
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1739C6EB81;
	Wed, 24 Jun 2020 14:43:17 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2057.outbound.protection.outlook.com [40.107.93.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5DEF46EB81
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Jun 2020 14:43:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HxsNwprs2aJ7DSbfft4KKtQiZWNzmVrIG8HoRN3A5h29OTyR9Xa+bcN0+RLxouYsRn4b2Gv6F7yS1DT6+QNgCoXomoMP9Cm9f4CWchYoLL/eJmOaNKD6sdVgOvFHXwzikQOs37QVqjVWU39Nf8L+sdIIIDMRHM6Zs9ps9s2kyIJg0w0er2Kt0vphGW/wkg9P3CdCPwum2a5sRR1+VQBF12xXU4eVjJATO/JbX2zTF8/jGibFkfqOYuWgm7zW7xo7vyX6zj/acm6DPao5HO9Wn/PH87J1VTik6UpJjSE6P/Rr0ZrStI4oRFREP6eLb798GLS08bsPxn8Es/Q7CFod9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lLMsBL7gmnuxNyrMnqvI0YVphkSr5kUwQo5Xay7kVuo=;
 b=XZ5hpo+qsSomLgmTpRnZmbZbws0BQT8fU4Ic9BrYkqUhzQ4s0p+JXLcMGCmrbW4Zzcf2peu04YtPPEtC+FtRzdXYB5HQ6fqYVy6nWFbvu8SiuYwcAJr6ghRXe4UFglq8+SOMFZKGb/AeLOTOLDEk2Y2SlVC5lK8gHJjaEVlhwwcBbEsv5mIIgh/ooFEyDOHGy2B2MmoQsP1oY/UcBI1OJVxw5R9+3EpTluNl34IWOXL1rfALw+5f6a4mU/Ne/vx/ru1C2Y7zzyu9c8IYfOFRD6JjoGWSTfFdCrc/M2a3fVRxj8wwD1/egyjHRY55MNLJDINRIOKNQhw95ovQ5CDFGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lLMsBL7gmnuxNyrMnqvI0YVphkSr5kUwQo5Xay7kVuo=;
 b=IJTaQZRCxiykKKMzczoELsKPhPb/3wQ3CFxhVW/+bRTN866tQHwq2/LPV1hGlS+24KApSKvh/f5BQ3ZgmOetq8GbrUsZDbH+IfDc44arG6nSulLSZbRHKVgaiva4N/ptQGcx4vt3/HAcgNKQagpuvJACH4zqg1zQYVtkTNC6NSk=
Received: from CH2PR12MB4101.namprd12.prod.outlook.com (2603:10b6:610:a8::22)
 by CH2PR12MB3848.namprd12.prod.outlook.com (2603:10b6:610:16::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22; Wed, 24 Jun
 2020 14:43:09 +0000
Received: from CH2PR12MB4101.namprd12.prod.outlook.com
 ([fe80::b9c2:5b76:382a:c5d]) by CH2PR12MB4101.namprd12.prod.outlook.com
 ([fe80::b9c2:5b76:382a:c5d%9]) with mapi id 15.20.3109.027; Wed, 24 Jun 2020
 14:43:09 +0000
From: "Sheng, Wenhui" <Wenhui.Sheng@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: reduce ip discovery data reading size
Thread-Topic: [PATCH] drm/amdgpu: reduce ip discovery data reading size
Thread-Index: AQHWSjStotTuxWkJVEy9MdaDtAKDkajn1ZMAgAAAwwCAAACb4A==
Date: Wed, 24 Jun 2020 14:43:09 +0000
Message-ID: <CH2PR12MB4101A6243B81D6F0DC85052E8C950@CH2PR12MB4101.namprd12.prod.outlook.com>
References: <20200624143500.4062-1-Wenhui.Sheng@amd.com>
 <DM6PR12MB407577521877A857EB246E08FC950@DM6PR12MB4075.namprd12.prod.outlook.com>
 <DM6PR12MB407572BBC35F7DBCDFF5CFA6FC950@DM6PR12MB4075.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB407572BBC35F7DBCDFF5CFA6FC950@DM6PR12MB4075.namprd12.prod.outlook.com>
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
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-06-24T14:43:07Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: b701bd84-219a-431f-9a10-0000bbae4c5a
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [117.135.83.114]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c36d7ad9-6ffb-4cab-25a1-08d8184cea33
x-ms-traffictypediagnostic: CH2PR12MB3848:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR12MB38481792EED4F78D1E9DC2A48C950@CH2PR12MB3848.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:400;
x-forefront-prvs: 0444EB1997
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IY0iywP3udEIMLxas5YL10pMP4Pghs/15wgNMBtfE66/+XJWUeSodmzqe7UOGohtlzD69PzpvjoSu46n7rt+ASfcSN4zOCftBHY2sRnR8DgGm1bash6UjT5+kMd79a8I116mWN4wGI26ietLBlZhYqv2KI9KRmysHBSlAgO5D7j4SqTj9ptERGbHoPp0w+MTMQ43NimAvqu7cktzW9Ak9eEQTc7VDn0o5OWU6G27vU0avFjDkVV7Lx2PXBr8SNML6ayUBssMdvskWsBPqbYiCV30yMl0T1pfTr7/l9If+aFCvKQ5ndqTVWKCXgxKDKS6PRZBHfItezsYc/xDdIWTDUgdF+VaQf8F1yUo4LraN2s=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(136003)(376002)(366004)(396003)(39860400002)(66476007)(66446008)(110136005)(66946007)(66556008)(64756008)(54906003)(33656002)(8676002)(8936002)(6506007)(186003)(9686003)(4326008)(26005)(53546011)(55016002)(2906002)(966005)(76116006)(83380400001)(478600001)(86362001)(316002)(52536014)(71200400001)(5660300002)(45080400002)(7696005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: kEBD0kFTPJitY2B+MmnK95rbXQSw434oCxTZMlMRGJORQ7hAnPrZY13WNCcJa9p0GWlNnScpfIz4vZOMUPukv0WwFol5hLutROay7Cvf5BRB6DBEar+N5udfM8CymwlTLMVyHO/+/epSggGl1Lvxvrx2iQ+zyZWe6b+nhgJ0U+VtmFJsQ2O/Sf/Mfqr8yIqZlKavCwVIkROXhEmdRGz1kznF0ZdKklDTe6RUFGHE7BuN/VnbLSwqAQ0IGLkzDqddCdWkqcnqT5fm304jEcMAFUoYZVsDZCxPK2MxQD8VnIRJ5ufc+l2Z1SAaZ90P5ijDWQB4pxQm833oWn13LLsETLdUZ6eT87JD3umKYadiKlSgRwwRoswPiZcjGU/t4saxr0eEIGMUr4KvLUOPe+gKYszfaYvyUyt2HBvhMpx5AQe91/VOcDkVyxYbczQnJ9cEtGTDdgCpNKCV8pyOpUmE7o+1A78MetLFC3VzBjKRkRv9obdKtgAq8UMkkSShd7Mq
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c36d7ad9-6ffb-4cab-25a1-08d8184cea33
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2020 14:43:09.7407 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 64CaWKICnmiKxGzdtKCXAC8EBThT26Wg0qHbaXfRCyr4bUOI09kQv3US+d/Sy64nvTXpMg17iWK/wabo9RBmPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3848
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

Got it, will add more info in commit msg.

Brs
Wenhui
-----Original Message-----
From: Zhang, Hawking <Hawking.Zhang@amd.com> 
Sent: Wednesday, June 24, 2020 10:40 PM
To: Zhang, Hawking <Hawking.Zhang@amd.com>; Sheng, Wenhui <Wenhui.Sheng@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Zhang, Andy <Andy.Zhang@amd.com>; Liu, Shaoyun <Shaoyun.Liu@amd.com>
Subject: RE: [PATCH] drm/amdgpu: reduce ip discovery data reading size

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
