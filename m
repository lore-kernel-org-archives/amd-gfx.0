Return-Path: <SRS0=Dt/2=AZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2C81C433E7
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jul 2020 09:01:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A34E221927
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jul 2020 09:01:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="JWvXNRVk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A34E221927
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 665776E890;
	Tue, 14 Jul 2020 09:01:19 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2050.outbound.protection.outlook.com [40.107.223.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8D3036E822
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jul 2020 09:01:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ViDtkB1oL+Dn1T1OzUHBkfelOW1tQmzoVwXewkXsZjEEyb2DZKviRlnQ57ocaWx1Sh49lIRikf8YA7WOfITeWQ6E/U9oUnTEQCc6YJC+Ed98JxW3wA7JXO28q4ChgrFWDT+T59RdmV6h9mIgexPe25zpVU37ByHmwtbJiyrFla+otpuSfi+2lMtjTrq07ineoMOR1mhm8tfrtuiEnWYcUli46i2/7/Nx969CQ4T3y+Z3FKQnrH8v/7KGQjigQJFYu5idKE5+SzZfh4p87gBZUAUJHaoCQ4+MpGlYZPBGXOpeAyaNVZxvRKppArZZJRjeNZKnMWDtic9TE39PulZkrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UroG7G5rSDGuqYkXF6HBDUQI7qJrPBI0PpWiQh1OnHs=;
 b=IjpEGZvSr2D0e69Xi/jg6YqJHeTX3QUHSPsFWAiBxwC9ky9zw3e1AAyH36dLn/quqwlOeLL+7x/iVFo270s9VBWcVsQMMFk039UQvHFBb5bUQb5Ml2TmanHA42tGCycidddLBVcXPQLyHQSLGXxN21Dmr530ezfSGGrktXgovWJ7KUVtYFIVlDy+1lanabRG51perqxUs9NJ6GfDHDvrufeQpIezdt5En0L2irNI/LPrafPYTlwEu1qMj/wqT29ox/6VzFmd68s/KO0mftvJ00IsMoTw8nbnv1SC2YDWDNcu/+hvUyck1VGamOOK+GsAgJ9iVbSt2Q7MJuQuNvhdkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UroG7G5rSDGuqYkXF6HBDUQI7qJrPBI0PpWiQh1OnHs=;
 b=JWvXNRVkUXS63fZWEx0cUg87u3w1aV0ftS569esOkIrFSrPKqxAt9nF8nCoxTSMT8rt+G3dw/npU5vIbop2rmgy8LzUgOlOIPHlwY70daW9RtB/MeemIEo8FUmO9UOls50PxwfeweENEEb85zkgv9WHAbgsymlWSbi8burIBvEE=
Received: from DM5PR1201MB0204.namprd12.prod.outlook.com (2603:10b6:4:51::10)
 by DM6PR12MB2812.namprd12.prod.outlook.com (2603:10b6:5:44::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.22; Tue, 14 Jul
 2020 09:01:13 +0000
Received: from DM5PR1201MB0204.namprd12.prod.outlook.com
 ([fe80::d00b:39da:e9a1:8cfb]) by DM5PR1201MB0204.namprd12.prod.outlook.com
 ([fe80::d00b:39da:e9a1:8cfb%7]) with mapi id 15.20.3174.022; Tue, 14 Jul 2020
 09:01:13 +0000
From: "Zhang, Jack (Jian)" <Jack.Zhang1@amd.com>
To: "Li, Dennis" <Dennis.Li@amd.com>, "Liu, Leo" <Leo.Liu@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 3/5] drm/amd/sriov add mmsch_v3 interface
Thread-Topic: [PATCH 3/5] drm/amd/sriov add mmsch_v3 interface
Thread-Index: AQHWWYkVTJ3wNhLEzEm6pn8gsZsnuakGfTkAgAAq0lCAAB7/0IAAADrg
Date: Tue, 14 Jul 2020 09:00:55 +0000
Message-ID: <DM5PR1201MB0204812CFD0B3906FFE46593BB610@DM5PR1201MB0204.namprd12.prod.outlook.com>
References: <1594694808-7706-1-git-send-email-Jack.Zhang1@amd.com>
 <DM5PR12MB2533AF4D5366ABD73AFA4199ED610@DM5PR12MB2533.namprd12.prod.outlook.com>
 <DM5PR1201MB02044924FD97D6217D2DCB65BB610@DM5PR1201MB0204.namprd12.prod.outlook.com>
 <DM5PR1201MB020400CF71F56330AF9052FCBB610@DM5PR1201MB0204.namprd12.prod.outlook.com>
In-Reply-To: <DM5PR1201MB020400CF71F56330AF9052FCBB610@DM5PR1201MB0204.namprd12.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-07-14T04:35:01Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=917ecda8-6f28-442c-9002-7f1b0bc1d125;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6a3d8e50-5901-446d-55d2-08d827d475d3
x-ms-traffictypediagnostic: DM6PR12MB2812:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB28126BA17413545812CE9FD4BB610@DM6PR12MB2812.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EvWR64648nmRWDpoppQwvAbt2zxOSxV52Ladwuz7d11JEk0APJBgUVQK9lfZm+KrBJPCEbzU+TH3mOE3BHD9LPpubfVvNm/Wj0rYwKKcDJkt1/FnsWwK6tSnKQdmUOQxB/BPzliXrQDRe2BWDLuTD46dkkruxSXqPM9Xjan2eXcHxsasBn9yON7CAfRi2/v3NXri67PtKpGLAwRLfj8cpWNw9H1uobeOVSxZZmaNfXFRgNs62z9ngTlXGg7FjNl+Bys6NyvgnRMjKo3BU4nOW4rXOq0TGVm5ZQC4RRZy5vzK1vTyfFVCNTrPS0ZOMtD/ZfnvJvvjezFaxo2XiBKNxcMJcquJkepCoL2Z54rNFR8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR1201MB0204.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(376002)(136003)(366004)(396003)(346002)(966005)(55016002)(52536014)(8676002)(83380400001)(66946007)(33656002)(53546011)(9686003)(2940100002)(316002)(66446008)(110136005)(76116006)(66476007)(64756008)(66556008)(5660300002)(26005)(6666004)(2906002)(186003)(7696005)(86362001)(6506007)(8936002)(71200400001)(45080400002)(478600001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: mcvP8ZPW0vTPL5sYGW4SNn8dYebZNX19e1Re+xNha5+/gglpAUhnMT5mXEEae3HTI2lus2+OAUdah3tSI+9jlwiA0CMkJYH5DIMH8fOeWzDe/rLRdU2bd9cVnusbB5c1MZSuLNxe3jZ76C4JSEM5q2tFhVSz/NDBa/eWyyBucizbOE7kiUBpizzL6mIYFBNClsGyDEFJ2ZCL15wdKJHld8uI4jjejDJwqPfn+icig3gL9pyHbVzogDy3M+q2S7xc5gXv3Py2LXwQpOPEP54yK+oPrs8Ip5L9QhjoUMOZ2OXs3Rxcobrl7p+UwtsMeacIUhhB0Pdb2CXihbBKW1Tu4/2bb2eo6qt7eh3Vsy7c6Zbxw+ICstRr8oaXLjrO7vEUY3j/deTtCJKWo+fdTboaUzlOU+4bfiqOxjxlxs6EFXKFTMD5Qt+HKSRWMPAhwEBO7/Xb1sVzP1MF7UQe9h5PNBJPZINnbXuacoPbi2GxqTzLfC1UZDQjX0swdcQo9Fu5
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1201MB0204.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a3d8e50-5901-446d-55d2-08d827d475d3
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2020 09:00:55.6278 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mQye3p3otkNncFakytoXrIuSBbPSGnwVrrf9Clzr3B6kDOcnSEjVvqLNgy7igcO0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2812
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi, Dennis,

I gave some feedback in the comments.
Thank you for your review.

Best Regards,
Jack Zhang

-----Original Message-----
From: Li, Dennis <Dennis.Li@amd.com>
Sent: Tuesday, July 14, 2020 12:35 PM
To: Zhang, Jack (Jian) <Jack.Zhang1@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Zhang, Jack (Jian) <Jack.Zhang1@amd.com>; Liu, Leo <Leo.Liu@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: RE: [PATCH 3/5] drm/amd/sriov add mmsch_v3 interface

[AMD Official Use Only - Internal Distribution Only]

Hi, Jack,
      Please see the following comments. 

Best Regards
Dennis Li
-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Jack Zhang
Sent: Tuesday, July 14, 2020 10:47 AM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Jack (Jian) <Jack.Zhang1@amd.com>; Liu, Leo <Leo.Liu@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: [PATCH 3/5] drm/amd/sriov add mmsch_v3 interface

For VCN3.0 SRIOV, Guest driver needs to communicate with mmsch to set the World Switch for MM appropriately. This patch add the interface for mmsch_v3.0.

Signed-off-by: Jack Zhang <Jack.Zhang1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mmsch_v3_0.h | 130 ++++++++++++++++++++++++
 1 file changed, 130 insertions(+)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/mmsch_v3_0.h

diff --git a/drivers/gpu/drm/amd/amdgpu/mmsch_v3_0.h b/drivers/gpu/drm/amd/amdgpu/mmsch_v3_0.h
new file mode 100644
index 000000000000..3e4e858a6965
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/mmsch_v3_0.h
@@ -0,0 +1,130 @@
+/*
+ * Copyright 2020 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person 
+obtaining a
+ * copy of this software and associated documentation files (the 
+"Software"),
+ * to deal in the Software without restriction, including without 
+limitation
+ * the rights to use, copy, modify, merge, publish, distribute, 
+sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom 
+the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be 
+included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, 
+EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF 
+MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT 
+SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, 
+DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR 
+OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE 
+OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ *
+ */
+
+#ifndef __MMSCH_V3_0_H__
+#define __MMSCH_V3_0_H__
+
+#include "amdgpu_vcn.h"
+
+#define MMSCH_VERSION_MAJOR	3
+#define MMSCH_VERSION_MINOR	0
+#define MMSCH_VERSION	(MMSCH_VERSION_MAJOR << 16 | MMSCH_VERSION_MINOR)
+
+enum mmsch_v3_0_command_type {
+	MMSCH_COMMAND__DIRECT_REG_WRITE = 0,
+	MMSCH_COMMAND__DIRECT_REG_POLLING = 2,
+	MMSCH_COMMAND__DIRECT_REG_READ_MODIFY_WRITE = 3,
+	MMSCH_COMMAND__INDIRECT_REG_WRITE = 8,
+	MMSCH_COMMAND__END = 0xf
+};
+
+struct mmsch_v3_0_table_info {
+	uint32_t init_status;
+	uint32_t table_offset;
+	uint32_t table_size;
+};
+
+struct mmsch_v3_0_init_header {
+	uint32_t version;
+	uint32_t total_size;
+	struct mmsch_v3_0_table_info inst[AMDGPU_MAX_VCN_INSTANCES]; };

[Dennis]  You have defined total_size, why inst size is AMDGPU_MAX_VCN_INSTANCES, which will cause memory waste.
[Jack] In our case, AMDGPU_MAX_VCN_INSTANCES is a fixed number, which equals 2.  And struct mmsch_v3_0_table_info occupy 3 dws.  Thus there's not too much memory waste.

+struct mmsch_v3_0_cmd_direct_reg_header {
+	uint32_t reg_offset   : 28;
+	uint32_t command_type : 4;
+};
+
+struct mmsch_v3_0_cmd_indirect_reg_header {
+	uint32_t reg_offset    : 20;
+	uint32_t reg_idx_space : 8;
+	uint32_t command_type  : 4;
+};
+
+struct mmsch_v3_0_cmd_direct_write {
+	struct mmsch_v3_0_cmd_direct_reg_header cmd_header;
+	uint32_t reg_value;
+};
+
+struct mmsch_v3_0_cmd_direct_read_modify_write {
+	struct mmsch_v3_0_cmd_direct_reg_header cmd_header;
+	uint32_t write_data;
+	uint32_t mask_value;
+};
+
+struct mmsch_v3_0_cmd_direct_polling {
+	struct mmsch_v3_0_cmd_direct_reg_header cmd_header;
+	uint32_t mask_value;
+	uint32_t wait_value;
+};
+
+struct mmsch_v3_0_cmd_end {
+	struct mmsch_v3_0_cmd_direct_reg_header cmd_header; };
+
+struct mmsch_v3_0_cmd_indirect_write {
+	struct mmsch_v3_0_cmd_indirect_reg_header cmd_header;
+	uint32_t reg_value;
+};
+
+#define MMSCH_V3_0_INSERT_DIRECT_RD_MOD_WT(reg, mask, data) { \
+	size = sizeof(struct mmsch_v3_0_cmd_direct_read_modify_write); \
+	size_dw = size / 4; \
+	direct_rd_mod_wt.cmd_header.reg_offset = reg; \
+	direct_rd_mod_wt.mask_value = mask; \
+	direct_rd_mod_wt.write_data = data; \
+	memcpy((void *)table_loc, &direct_rd_mod_wt, size); \
+	table_loc += size_dw; \
+	table_size += size_dw; \
+}

[Dennis]  direct_rd_mod_wt, table_loc and table_size are local variables, it is better not to define them in macro, which are not very readable. 
[Jack] we inherited the code format from mmsch_v2.0 and mmsch_v1.0. And It will only be used in sriov. So it is not very convenient to re-arch the implemention of this part.

+#define MMSCH_V3_0_INSERT_DIRECT_WT(reg, value) { \
+	size = sizeof(struct mmsch_v3_0_cmd_direct_write); \
+	size_dw = size / 4; \
+	direct_wt.cmd_header.reg_offset = reg; \
+	direct_wt.reg_value = value; \
+	memcpy((void *)table_loc, &direct_wt, size); \
+	table_loc += size_dw; \
+	table_size += size_dw; \
+}
+
+#define MMSCH_V3_0_INSERT_DIRECT_POLL(reg, mask, wait) { \
+	size = sizeof(struct mmsch_v3_0_cmd_direct_polling); \
+	size_dw = size / 4; \
+	direct_poll.cmd_header.reg_offset = reg; \
+	direct_poll.mask_value = mask; \
+	direct_poll.wait_value = wait; \
+	memcpy((void *)table_loc, &direct_poll, size); \
+	table_loc += size_dw; \
+	table_size += size_dw; \
+}

[Dennis]  The same as the above

+#define MMSCH_V3_0_INSERT_END() { \
+	size = sizeof(struct mmsch_v3_0_cmd_end); \
+	size_dw = size / 4; \
+	memcpy((void *)table_loc, &end, size); \
+	table_loc += size_dw; \
+	table_size += size_dw; \
+}

[Dennis]  The same as the above

+#endif
--
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7CDennis.Li%40amd.com%7Cc07550519dd145540e3908d827a0355b%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637302916336069337&amp;sdata=a%2FFXCiFaX91GhQesxkKipSC0S0hpaKoDw5l1ZoCHrck%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
