Return-Path: <SRS0=fQkT=AY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96941C433E1
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Jul 2020 03:50:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 65D662068F
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Jul 2020 03:50:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Z7LBjf3M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65D662068F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D68F6E151;
	Mon, 13 Jul 2020 03:50:19 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2048.outbound.protection.outlook.com [40.107.220.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 38E706E151
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Jul 2020 03:50:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ST3LPVcccdq6q2p9Ko0vXNlyvDY5zpekHfF/oOfmUj7Xwhf0wDJdGG7HolOINf173camHQRcnBX5ROmXOCnEvcfCOVgvma4I6nuBhfDlAgvlVz0ydLR+Uxq+AAIw7ufwCzY6ML2n7aUTDuwll0fGyejPIaNRvFgPJVLoFpXJISJj1PKxJjEu6hZIpzbbDO4iKa3BGjUXc3clu4gLySOTUJ6Jt+B33UdEbljkuh2SkhkBUt9DorUQvxGgmFXSS/lms95azknMvAsfD/nu3/rdbT2AQyGDpyIHEOCnjMkrxHuaGqVfoGGgZqFkfgHyyShBXTH/rVoQ6nBfFgw+zr7Icw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+fQSniUGKGVeg45kvgdgvNRKdeLfumcHK5pjc4CwtzY=;
 b=TWvsBRdCgoK4ylFRELsqqtJdQ+4RUm1ZBpEjHsZdcrCBFThUwmSkvP7F7F0LCapax+fIxipafbO+xpEOlWFCGl1al2jnC2xTPQ4uYGqlX5xnz85qhbJY3e4JF1gkWm2RLjm+NvjbQfrM5y5BTGVcUAVYujHjUVDYx/OaMk7QyfTitPuEqkJ1ImATo0sOdVf/xcznKExzoR7RrvVbt2muGY/p8tkLOjGX3p6Hbw6MgYzCqRO/Egfkg2zUaVfjojlGxhYM2ZzwOVefQxogi1Br1Lw4bh3yU6CZ4vAtLw5LFFSmvJMZheA3idW2H9xeEJfSUZYIsx/RwEhHGS94nu/1IQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+fQSniUGKGVeg45kvgdgvNRKdeLfumcHK5pjc4CwtzY=;
 b=Z7LBjf3M98DBeAvClDfTx7Xb3ILxFdNMKh5AWPVW/DYzNftNqLTh2yFGSng9SNkEvosW+JsUSgMQQH4s0fCrDLjGjpNdiY7rTAbkD02HrNnOgy7nORK7Awfuubq/BJ8mFmIkkNewi60OTUL2Fqx3hsUQVmO/ggMAhtpaMLlD+dI=
Received: from CH2PR12MB4101.namprd12.prod.outlook.com (2603:10b6:610:a8::22)
 by CH2PR12MB4166.namprd12.prod.outlook.com (2603:10b6:610:78::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.24; Mon, 13 Jul
 2020 03:50:16 +0000
Received: from CH2PR12MB4101.namprd12.prod.outlook.com
 ([fe80::b9c2:5b76:382a:c5d]) by CH2PR12MB4101.namprd12.prod.outlook.com
 ([fe80::b9c2:5b76:382a:c5d%8]) with mapi id 15.20.3174.025; Mon, 13 Jul 2020
 03:50:16 +0000
From: "Sheng, Wenhui" <Wenhui.Sheng@amd.com>
To: "Quan, Evan" <Evan.Quan@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 3/3] drm/amdgpu: add module parameter choose reset mode
Thread-Topic: [PATCH 3/3] drm/amdgpu: add module parameter choose reset mode
Thread-Index: AQHWVsTJimX8BCD3jEWMkXVx0EvoHqkE3joAgAAEnwA=
Date: Mon, 13 Jul 2020 03:50:15 +0000
Message-ID: <CH2PR12MB4101A9590AD9FD1C42A78B928C600@CH2PR12MB4101.namprd12.prod.outlook.com>
References: <20200710141644.1601-1-Wenhui.Sheng@amd.com>
 <20200710141644.1601-3-Wenhui.Sheng@amd.com>
 <DM6PR12MB2619E50018140895EA78C7D7E4600@DM6PR12MB2619.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB2619E50018140895EA78C7D7E4600@DM6PR12MB2619.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=bc815b64-27ce-45a0-8466-000090a8eab2;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-07-13T03:27:11Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-07-13T03:50:10Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 14ef5ce1-d4c9-4564-a709-0000a34383fc
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
msip_justification: I confirm the recipients are approved for sharing this
 content
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5ba0c9f5-70ee-4619-4178-08d826dfdaa1
x-ms-traffictypediagnostic: CH2PR12MB4166:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR12MB416609F1B3F4A9269957B0068C600@CH2PR12MB4166.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:84;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Giae89E7zQsKiwleNKrOh34KEo5Ol1fTNJvVbIj9y4n9rVrVRFJNqdddA3jq1y0vH9IBlIOpZ+PPT3JN0gAvc4KQJAK17astbZytOMeMZ1KdLmyTFTQUl3nwB/dkJoJZiurrzhtaeybmy1iXEBRfm/Un70kVwwYuK2IZmwIdLyf6u8RKBrQXT7iFipzcqqE+VlCZBwyCwszvNBe0TKh6dAb8EGnvPiOJmnZbOoq/Kokg5xYgZuSznDBqKBVKSB7oGaRG5+zFar5knKwuj9eGhsZBtuqaq6XDchGvxKBJz3MBTXkN+cRMkZ9i45a07cL7j68bg8r0KvGBjtI6iGhb/G3Px1LZ457is06Igx2qjbU=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(396003)(136003)(39860400002)(376002)(366004)(45080400002)(8676002)(2906002)(478600001)(83380400001)(5660300002)(4326008)(966005)(52536014)(316002)(9686003)(6506007)(53546011)(7696005)(110136005)(8936002)(86362001)(54906003)(186003)(33656002)(66556008)(55016002)(71200400001)(66476007)(66946007)(26005)(66446008)(64756008)(76116006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: pElfKX4ZTxaMAXP7+7T5oXPaed+P9BtFutlwIoJFlyz6kSRVyV2QdQeV2bBhGchs3mApupDTl+diZo0oXtFQClCBeSdSAI8Pd79mY3LKTEsTENNA+iVWmLKkWkWw7fQduv4Ph/WFiQJhLY3HWbC2+cY1gUAY+QyhNY0dgxOXUJNh78a+q+pGw+T1BJXkxpIu0RIGKsosjbBQq5dbGv2ACVMjaxPNP8q6Qf7zqZb0iYZqQ86l4KX+2BFqRCRIxCVvmFIs8AC4Px8fitxoK6XuXcXsQRPLdfWDwlCefcu5KoO2oBMJTsT9hm3tg/5Gpqqu75Gcdu3hFPXV6uZrgOY4AvP5fr0P558xQfJ+iLnKc+hj92wnnG3FgnvJO7PMGI2b/VB6sn0KdJilZF2sLd/ZXTCmxPjhutFbyfvPNwW3xQPjSr1NqELJ+FjkwljWYACWMBkggFwMHsRecKxvdSVmpNWMWi9/4a+ioUSGMyLKpQAaIsaIPkd9rlwsZVYbYkj6
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ba0c9f5-70ee-4619-4178-08d826dfdaa1
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2020 03:50:15.8935 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Qykp//AtCnIeu323rRors+KY9pK3rIe0dGBC1wnbJ9KDe0MoBKhj4yMkeEqcKy6x4rSz7v2I44K6Rs+iKCVqYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4166
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
Cc: "Gao, Likun" <Likun.Gao@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

[AMD Official Use Only - Internal Distribution Only]



-----Original Message-----
From: Quan, Evan <Evan.Quan@amd.com>
Sent: Monday, July 13, 2020 11:30 AM
To: Sheng, Wenhui <Wenhui.Sheng@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Gao, Likun <Likun.Gao@amd.com>; Sheng, Wenhui <Wenhui.Sheng@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: RE: [PATCH 3/3] drm/amdgpu: add module parameter choose reset mode

[AMD Official Use Only - Internal Distribution Only]

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Wenhui Sheng
Sent: Friday, July 10, 2020 10:17 PM
To: amd-gfx@lists.freedesktop.org
Cc: Gao, Likun <Likun.Gao@amd.com>; Sheng, Wenhui <Wenhui.Sheng@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: [PATCH 3/3] drm/amdgpu: add module parameter choose reset mode

Default value is auto, doesn't change
original reset method logic.

v2: change to use parameter reset_method

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Signed-off-by: Wenhui Sheng <Wenhui.Sheng@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h     | 1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 8 ++++++++
 drivers/gpu/drm/amd/amdgpu/cik.c        | 4 ++++
 drivers/gpu/drm/amd/amdgpu/nv.c         | 4 ++++
 drivers/gpu/drm/amd/amdgpu/soc15.c      | 5 +++++
 drivers/gpu/drm/amd/amdgpu/vi.c         | 4 ++++
 6 files changed, 26 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 4de93cef79b9..06bfb8658dec 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -196,6 +196,7 @@ static const bool debug_evictions; /* = false */  #endif

 extern int amdgpu_tmz;
+extern int amdgpu_reset_method;

 #ifdef CONFIG_DRM_AMDGPU_SI
 extern int amdgpu_si_support;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 94c83a9d4987..ed9f32b89f36 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -154,6 +154,7 @@ int amdgpu_mes = 0;
 int amdgpu_noretry = 1;
 int amdgpu_force_asic_type = -1;
 int amdgpu_tmz = 0;
+int amdgpu_reset_method = -1; /* auto */

 struct amdgpu_mgpu_info mgpu_info = {
 .mutex = __MUTEX_INITIALIZER(mgpu_info.mutex),
@@ -793,6 +794,13 @@ module_param_named(abmlevel, amdgpu_dm_abm_level, uint, 0444);  MODULE_PARM_DESC(tmz, "Enable TMZ feature (-1 = auto, 0 = off (default), 1 = on)");  module_param_named(tmz, amdgpu_tmz, int, 0444);

+/**
+ * DOC: reset_method (int)
+ * SMU reset method (-1 = auto (default), 0 = legacy, 1 = mode0, 2 =
+mode1, 3 = mode2, 4 = baco)  */ MODULE_PARM_DESC(reset_method, "SMU
+reset method (-1 = auto (default), 0 = legacy, 1 = mode0, 2 = mode1, 3
+= mode2, 4 = baco)"); module_param_named(reset_method,
+amdgpu_reset_method, int, 0444);
+
 static const struct pci_device_id pciidlist[] = {  #ifdef  CONFIG_DRM_AMDGPU_SI  {0x1002, 0x6780, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_TAHITI}, diff --git a/drivers/gpu/drm/amd/amdgpu/cik.c b/drivers/gpu/drm/amd/amdgpu/cik.c
index fe306d0f73f7..a99418cd2f5e 100644
--- a/drivers/gpu/drm/amd/amdgpu/cik.c
+++ b/drivers/gpu/drm/amd/amdgpu/cik.c
@@ -1326,6 +1326,10 @@ cik_asic_reset_method(struct amdgpu_device *adev)  {  bool baco_reset;

+if (amdgpu_reset_method == AMD_RESET_METHOD_LEGACY ||
+    amdgpu_reset_method == AMD_RESET_METHOD_BACO) return
+amdgpu_reset_method;
+
 switch (adev->asic_type) {
 case CHIP_BONAIRE:
 case CHIP_HAWAII:
diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c index 9f1240bd0310..309ff402d7be 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -311,6 +311,10 @@ nv_asic_reset_method(struct amdgpu_device *adev)  {  struct smu_context *smu = &adev->smu;

+if (amdgpu_reset_method == AMD_RESET_METHOD_MODE1 ||
+    amdgpu_reset_method == AMD_RESET_METHOD_BACO) return
+amdgpu_reset_method;
+
[Quan, Evan] I kind of wonder what's the expected behavior if user specifies amdgpu_reset_mthod as "0 = legacy" here? User's settings seems ignored silently?
[Wenhui, Sheng] yes, if this asic doesn't support legacy, should choose one by auto, do you think this is make sense? Do we need add more debug message here?

 if (smu_baco_is_support(smu))
 return AMD_RESET_METHOD_BACO;
 else
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index 8c739b285915..a8a134f7bb61 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -532,6 +532,11 @@ soc15_asic_reset_method(struct amdgpu_device *adev)  bool baco_reset = false;  struct amdgpu_ras *ras = amdgpu_ras_get_context(adev);

+if (amdgpu_reset_method == AMD_RESET_METHOD_MODE1 ||
+    amdgpu_reset_method == AMD_RESET_METHOD_MODE2 ||
+amdgpu_reset_method == AMD_RESET_METHOD_BACO) return
+amdgpu_reset_method;
+
 switch (adev->asic_type) {
 case CHIP_RAVEN:
 case CHIP_RENOIR:
diff --git a/drivers/gpu/drm/amd/amdgpu/vi.c b/drivers/gpu/drm/amd/amdgpu/vi.c index 4e5e91888d87..2cc8ad19ebed 100644
--- a/drivers/gpu/drm/amd/amdgpu/vi.c
+++ b/drivers/gpu/drm/amd/amdgpu/vi.c
@@ -710,6 +710,10 @@ vi_asic_reset_method(struct amdgpu_device *adev)  {  bool baco_reset;

+if (amdgpu_reset_method == AMD_RESET_METHOD_LEGACY ||
+    amdgpu_reset_method == AMD_RESET_METHOD_BACO) return
+amdgpu_reset_method;
+
 switch (adev->asic_type) {
 case CHIP_FIJI:
 case CHIP_TONGA:
--
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Cevan.quan%40amd.com%7C259262f416404c23d64108d824dbf044%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637299874389349093&amp;sdata=uyCH2W4ox82ta%2BZRO4PXeYhHf2o7RH3fMoawcsFy3M4%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
