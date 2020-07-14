Return-Path: <SRS0=Dt/2=AZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10B37C433E1
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jul 2020 04:35:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF1AF20758
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jul 2020 04:35:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="RZDKoJxT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF1AF20758
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 853576E8BD;
	Tue, 14 Jul 2020 04:35:10 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2055.outbound.protection.outlook.com [40.107.243.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 111296E8B5
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jul 2020 04:35:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vnpbr2MPecTZanbheIMoM4RrsMar1eKOyGjt8ab3Cmj1SN1cUt9rlcn+pBIqRMEYEnRc8hAh2vv1HnrvWdqjn4w8lLyK8nhHU0Aq2+tHLqgEdJ+jgMBl3k8mjdmzPQHYnLhI178apZ7wIiaOkE7OPop37EDXqTr4z3zt0ybolt6AZkYy6Dv87zAL3T1ptKek9d6JTSwOLnnvPrIEoCb+ckBd1QwC9V+MHlHPvBdcrrS9bqlhe4zg/zSe1LhLuv2keGYUU3Vb+GamYW4pDWnNcPs/8JwPpOgyg6EE+OyhCsrynVDfok53iBx2Pn6TlEYgViEtox3p2PKJYFYdPOVP1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iN2gyoNgB4yKADYRXimf9c3GexzJO9nAhgoe4dAeocs=;
 b=l+61bZm/1EY6BE4pr/qMEkqU8fbdGjLdCmGh33EpTXcunanLgRu/NQ63taYNDB+meXBCkCuCS0+x0WPxhIvOIlAWj0xZPIpeBXGzAGNAaZc1xb+VEpEEKFa44WcX6KdXbNEO0dcbCyK8AP5VZyW8E671/nB/9K71yBSxBeNX/5Qtl+pO2f97nmaqBhPjSPiqH9h5V0BKIjEMx4Q7O8R++CUHEQg5eaBr+oJaRqKSWMvMkwdtdFqyOYiSlsuFd+9OEgax04J7fTVf3Ff7zxC9Z28gSNPrurqkSG3QQ6x//EteNS59S1DAEOSj6wACLMWO1+bCf6awggMdF7Wx7T1oNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iN2gyoNgB4yKADYRXimf9c3GexzJO9nAhgoe4dAeocs=;
 b=RZDKoJxTC4kZwIgbh3J6snHS6F2WpAlCxOMmsVpDPbocfRG35a5WZGMQj68YQLjt32Fsc65su88H45FI5pzYt1srDof3+lmxnjvJpoInoZGvsmGVFLIlcIbXFEvHnPpzNLtwYZ+sDgmS3XGvTMYF3C7OzXcz054zhQLfORWSIZw=
Received: from DM5PR12MB2533.namprd12.prod.outlook.com (2603:10b6:4:b0::10) by
 DM5PR12MB1705.namprd12.prod.outlook.com (2603:10b6:3:10c::22) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3174.20; Tue, 14 Jul 2020 04:35:07 +0000
Received: from DM5PR12MB2533.namprd12.prod.outlook.com
 ([fe80::2d85:c08d:4782:e3a]) by DM5PR12MB2533.namprd12.prod.outlook.com
 ([fe80::2d85:c08d:4782:e3a%7]) with mapi id 15.20.3174.026; Tue, 14 Jul 2020
 04:35:07 +0000
From: "Li, Dennis" <Dennis.Li@amd.com>
To: "Zhang, Jack (Jian)" <Jack.Zhang1@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 3/5] drm/amd/sriov add mmsch_v3 interface
Thread-Topic: [PATCH 3/5] drm/amd/sriov add mmsch_v3 interface
Thread-Index: AQHWWYkUlv3CAvYm7ECtP2EwHnJbk6kGbUDQ
Date: Tue, 14 Jul 2020 04:35:06 +0000
Message-ID: <DM5PR12MB2533AF4D5366ABD73AFA4199ED610@DM5PR12MB2533.namprd12.prod.outlook.com>
References: <1594694808-7706-1-git-send-email-Jack.Zhang1@amd.com>
In-Reply-To: <1594694808-7706-1-git-send-email-Jack.Zhang1@amd.com>
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
x-ms-office365-filtering-correlation-id: 270d67e9-5e82-4462-c59f-08d827af4900
x-ms-traffictypediagnostic: DM5PR12MB1705:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB170566505E24547300E8F10BED610@DM5PR12MB1705.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GFIODeeTnOwuVxlX5qFt+oi6Cm4uvVvB7OQZ06oC0F6xG6Gn6TSkZMuSIA9sye6Wn3ievBZ5qP5NR/Obz7glE0z0uucR/JSjVa/1qQe8bu2dIv/yMQcHBBemYao8Cwa9uImSh1AySOz2/DCmsi/6X1c0eey8At/YQHDWxoNhCqiYpiUk6srYm3jDGhUS4G6u/hD8BR1eeg5/OUYkp+Vbp1utrzEh+8HoEml7o3jObeIB+3f4WGGLr1EeXsO/OgorcGbXgFrKsUJ+UrVc+/Le48Rd3Lf+hHcg7YtkEwRjctyD5tBLA/ZqYHlo4ZRaEHJd6y2nbIplyluxsgsJcG9nY78axObTuntXwIeoijU3WWM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2533.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(136003)(366004)(346002)(39860400002)(376002)(86362001)(5660300002)(186003)(66556008)(66476007)(66446008)(26005)(66946007)(64756008)(76116006)(52536014)(83380400001)(55016002)(71200400001)(4326008)(33656002)(2906002)(478600001)(45080400002)(8676002)(316002)(54906003)(9686003)(110136005)(8936002)(53546011)(966005)(6506007)(7696005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: twbBIHxhR1ZRkeXlRrtTe354bpMdSfPaeiZ+B9sh2zgG+zcXVWlVIqAhy4zDamrRFtB/OrDOB+RgJxTWfSW/fY7f/JZjggmLl4JSyXUBDb5WJnriq6+IDeFPINOdgOG5jYqttBZ3o+gtdo57c44QvhrJewWwhCl5HRHl0wNuhcrI+mZSqzYAh9Fwrxz51FQlAAEleWQDPMpjY+8Q/4F3tvNwuVfoKwXwNLk9lD7LxJWtzk513AUytNQBYzuhY/gVjy4JwogEe+LIQdTE9lMElNMpeh1/MSX8+8ujPnubUmYal+WN/4GNZO9GzZVXzrn78MWEsHhDGdvtGMVwM0b3Kv7Wd+vjJvJ80f7FKCRCSDlgcKTieusxbUobj0xJzwcvXpWirYDeAfTXne35PjCOz/+ySzSKHQlZwXdZ9a2ezt1Fv8KVn1JQnHkj4UWRtIjkeJ7x0FIc7fsBf46iTOMtdCt9XxgbxpT+MGGSAKT9ItGLKnmAIPPXapGNrVtq8Heu
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2533.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 270d67e9-5e82-4462-c59f-08d827af4900
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2020 04:35:06.9033 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jm8fg9cXKeUglWPcuwgEiZx6ShIsDRJ7pjBcH0y2Bq980nVTcP45ASmBF4KplEFx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1705
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
Cc: "Zhang, Jack \(Jian\)" <Jack.Zhang1@amd.com>, "Liu, Leo" <Leo.Liu@amd.com>,
 "Zhang, Hawking" <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

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
