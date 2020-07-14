Return-Path: <SRS0=Dt/2=AZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12E6BC433EC
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jul 2020 09:27:42 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB90B208C3
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jul 2020 09:27:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="tuXeAAvA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB90B208C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5FFC06E0A8;
	Tue, 14 Jul 2020 09:27:41 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2043.outbound.protection.outlook.com [40.107.94.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 676C66E0A8
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jul 2020 09:27:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mJS3DgskoOHxON2/PtnaQ4gbF7mdNhWcVwu7ycp/1ESqZG5XYEalgQ+FEXxtvh4eb24cw1m/RR7z1m6yqA43XOWOwsSm+T9lpnfeFZCebEeqxsQXVtxNczvq0FjFSDZf10KIGvLNx02nJhLMnd0nrFGx2hhfhDOVKcRRAydPfUaOMY6hjcOSfcqBvFta/u5m2kMG35RU1WhwUAaZkwj2A5W2gPcm93LDbdddE1qZSQl4gABChWdTt/nF0K3rABGzEwXCdKA/vEBGVlfHoiGEboo1y2AUQ20NEn30/9b3ZQRl+SG0+9ROPDKqRHTAYtkLmyPlgu06CE0AfirD/OGQ1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RI6LVXMzAspIqWIyQ14cLShpitwyCVW4IqPEnJdpHfw=;
 b=cKsPE68WYs94s1KXQ+gUh04+JVD1WpAjzRR/v8JXBGGCn2pMcLe+8MZNOsSkc3EwFTQhovdh7oR5qSFS3ei23cEnPt5xTh9Sn6zafkgmeAb8zL7ZJBjhvmux+xxefMKlOYpiJbCPQ/km2R5KlYhdOUSUy2YCxwQLdbqwAUzSdE+chUctnCKfuun+SMunY0MARUmn3/eFlcSy+N/faNbMB3sEiB4lYxllK2E3kVij4ROc0vfMP4bSEBqqsbnX/Fb9SAu3MukStvi6k8vp3Cqgb63j4ZtW0/sNZgU3aafQXXJJyFXkUWChtxETWNpveKWzSQ9iWc8paMrV+7pcNsRi0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RI6LVXMzAspIqWIyQ14cLShpitwyCVW4IqPEnJdpHfw=;
 b=tuXeAAvAaZzdpelodleeauXz7+FKYjMJBIcEKBex6x2iWMjDD2KySoai0FOBSS+Yk5CUTYjv97K8a1K0SHp56zeaNY4ckELx+BIZlXah96ew6fkvQ7exNLGDlKABbHPtaW4Rcijjh3Ek7m8HRtvJJTYNioG6ZeI3x4/NQvK1puo=
Received: from DM5PR12MB2533.namprd12.prod.outlook.com (2603:10b6:4:b0::10) by
 DM5PR12MB1929.namprd12.prod.outlook.com (2603:10b6:3:106::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3174.23; Tue, 14 Jul 2020 09:27:38 +0000
Received: from DM5PR12MB2533.namprd12.prod.outlook.com
 ([fe80::2d85:c08d:4782:e3a]) by DM5PR12MB2533.namprd12.prod.outlook.com
 ([fe80::2d85:c08d:4782:e3a%7]) with mapi id 15.20.3174.026; Tue, 14 Jul 2020
 09:27:37 +0000
From: "Li, Dennis" <Dennis.Li@amd.com>
To: "Zhang, Jack (Jian)" <Jack.Zhang1@amd.com>, "Liu, Leo" <Leo.Liu@amd.com>, 
 "Zhang, Hawking" <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 3/5] drm/amd/sriov add mmsch_v3 interface
Thread-Topic: [PATCH 3/5] drm/amd/sriov add mmsch_v3 interface
Thread-Index: AQHWWYkUlv3CAvYm7ECtP2EwHnJbk6kGfTkAgAAq0lCAAB7/0IAAADrggAAHdNA=
Date: Tue, 14 Jul 2020 09:27:37 +0000
Message-ID: <DM5PR12MB25330817B8632081D931F0FFED610@DM5PR12MB2533.namprd12.prod.outlook.com>
References: <1594694808-7706-1-git-send-email-Jack.Zhang1@amd.com>
 <DM5PR12MB2533AF4D5366ABD73AFA4199ED610@DM5PR12MB2533.namprd12.prod.outlook.com>
 <DM5PR1201MB02044924FD97D6217D2DCB65BB610@DM5PR1201MB0204.namprd12.prod.outlook.com>
 <DM5PR1201MB020400CF71F56330AF9052FCBB610@DM5PR1201MB0204.namprd12.prod.outlook.com>
 <DM5PR1201MB0204812CFD0B3906FFE46593BB610@DM5PR1201MB0204.namprd12.prod.outlook.com>
In-Reply-To: <DM5PR1201MB0204812CFD0B3906FFE46593BB610@DM5PR1201MB0204.namprd12.prod.outlook.com>
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
msip_justification: I confirm the recipients are approved for sharing this
 content
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5a5780a7-58d3-40b3-b0b2-08d827d8262d
x-ms-traffictypediagnostic: DM5PR12MB1929:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB1929BC9BA1CA78D805C58A0AED610@DM5PR12MB1929.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: c0EYvhchFNRB1oVnm2xX2fxRgf15BZXD5U79LsVos1DGl+ZVA/qjmQpRReRjgW+VSYObj+hFIVvIpNRe2TwE1ShA7BFdmZ3DAbwlhtm+Qz7KSNUuGTrAWWAP5n6litjpoSWNbvZtFOvPSz6fiNPN1cpVWtoTuynpONZt2C+I1K8eWpguCOkw3s9CA6C+nzzzKKfoo2N60ON0pb8e0+Rpbb60ygTS5ykSbET/XLx4aXIRoLC2iV+9kDtPNZW6TJRECQqkjuWFh2jZlCqSi23NK1nryUxLoMgKSt+yoKIE07lF7UlWRFl9Bbx3We4sjVIRPig8E/7GRhszDXOdYNvxVxJYKuyIH26Z+mzQdT1kB4s=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2533.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(7696005)(8676002)(6506007)(53546011)(33656002)(110136005)(71200400001)(8936002)(186003)(45080400002)(76116006)(26005)(2906002)(52536014)(5660300002)(66946007)(86362001)(55016002)(66446008)(66556008)(64756008)(66476007)(83380400001)(966005)(9686003)(498600001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: sSkJX7Gk7uVFBeqMmllBVEYOrTALnE/4oroA32W7XAXSehDmajhOmKSo8eF6VYBf7W20UX/LONf0Fir4a9/ZMAGNyfUCb/7eS79UjCDW7lGxWA5qfODR+gaufAYVipJj6u9GvKk8xbNQ4oN5tbvohdBqnK8lC6il4uDl3dN7BbxfBrrVgIrL31GWLmTOEW6a/qwvPsr0swMPIvaOFm0a2Qo+jyhPvqBdjkt8GlJ8j2HBo2K6PWat46lwIKiT9ri3Ic78DZh3O56o41CVB0+5N8ka0DG6Mc0tWBXKDd8F63tsPtDsPRC7chiaAeN9/nNKjilKZKwOFjpyhxi5fwwP7lPIvPQOZ+tLgLGBsEEy+LhAsLqczTqdx5eELpyaQIIFbqQi6SVbL0PQ6tNopvx0WdgZe9tOEXoN/zxaNiU+ELaAjUU4bPc1XBHkMG+rvFHNiabaerXvVVTHDRde8IZhBbamn29hogkASC+9DQm+2FprlirO1ZD8exA5KWcerFzY
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2533.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a5780a7-58d3-40b3-b0b2-08d827d8262d
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2020 09:27:37.8443 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: d9LGhOf1VDZcXu9ahVmGprRtVeHWKbAn28o2kPjzZFBXi3duJixG0sWixNQVe8+L
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1929
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

[AMD Official Use Only - Internal Distribution Only]

Hi, Jack,
      Thanks for your expiation. It looks good to me.

Best Regards
Dennis Li

-----Original Message-----
From: Zhang, Jack (Jian) <Jack.Zhang1@amd.com> 
Sent: Tuesday, July 14, 2020 5:01 PM
To: Li, Dennis <Dennis.Li@amd.com>; Liu, Leo <Leo.Liu@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>; amd-gfx@lists.freedesktop.org
Subject: RE: [PATCH 3/5] drm/amd/sriov add mmsch_v3 interface

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
