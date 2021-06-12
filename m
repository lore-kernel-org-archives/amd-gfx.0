Return-Path: <SRS0=63DL=LG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93169C48BE5
	for <amd-gfx@archiver.kernel.org>; Sat, 12 Jun 2021 06:05:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2089461263
	for <amd-gfx@archiver.kernel.org>; Sat, 12 Jun 2021 06:05:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2089461263
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8B23D6E0B6;
	Sat, 12 Jun 2021 06:05:56 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2083.outbound.protection.outlook.com [40.107.220.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4B6F96E0B6
 for <amd-gfx@lists.freedesktop.org>; Sat, 12 Jun 2021 06:05:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ADrBjqB/WvAZFXhZvr25UZUv4DZMTSulJNSWvgKhilqjYSgZaH0xtq1zxNX/2NliDEp/go4H6DhHBFuTcHqHvUmtgTRNMlsnmmvFX36Ylr+kNOlDENBPkZPO/yl/rghCjQxWdBA0NDkjQMSxzWBBhCvmdbDvxNxAwMsyT6hN2uFvecpp/VqV3rFz0DFIEdbsNpWGLSNppBVMdGKw6yqxDNnFVVaIY9KEFKPRvTUuuj5Gemd0VPv4TPE3AXLHJdDRF9e3IGl42/cl+N39aiUJkZco9EI4z6MeTNlQvtA8gobdZy+L/HHe7PEuVoqNE3VHISxJ6T+Kn6o6d1pfcXoJeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7yf/dLT4RoB1mBZfTpv10BevzM/5nrqcn84pPjfoBv4=;
 b=Fxi4Aei1LFENb/+6xjYmVCF1wGaPSrh2hKRKxaC2FwiAS5R2elumofqF+6GuE41aUQIakFpGtoSmvEhXN66nRHcyuB61a9A5UKiwj9GLPJ2cYTt8C542rQPIHpBR762sQbT6VG5oHXPuTJ43YgrB8ZnOadzk3+vHNwshOgMnty4yxYU+GBkC8Q7hU/zMuK6kiSmhzPx3DxqaHhkUtPFtLjmLYBBmuiW4q3rdeQpdOxK+6TzRbrWmbnwtHs27otX6BaTpIxTq5jkIbJIOS2Nxyxi29JepIPnttnyEZvI4j0zdJs0RrOTlmPs6zXw3DGZKYjWasA2T0EI7StyXXOtFPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7yf/dLT4RoB1mBZfTpv10BevzM/5nrqcn84pPjfoBv4=;
 b=FOVik9GDJzmrhZQJUsXKOOzQ9HDSnCHpkIGvv7Ih9MtpxKiX4LJWzlRiaP454qmF9eSqFp9sPlvolWnnSQeKayFY2D1bJ0uzaMkA/5m0Yz03AzhgILfoTlxYHXLJZIIm5Vibo/TTxhgmxMf7jjhKG0E7VxiUNNP4TEO74dLeqlg=
Received: from BN9PR12MB5226.namprd12.prod.outlook.com (2603:10b6:408:11f::11)
 by BN9PR12MB5180.namprd12.prod.outlook.com (2603:10b6:408:11d::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.20; Sat, 12 Jun
 2021 06:05:53 +0000
Received: from BN9PR12MB5226.namprd12.prod.outlook.com
 ([fe80::d863:def1:2b7e:fc89]) by BN9PR12MB5226.namprd12.prod.outlook.com
 ([fe80::d863:def1:2b7e:fc89%7]) with mapi id 15.20.4219.024; Sat, 12 Jun 2021
 06:05:53 +0000
From: "Clements, John" <John.Clements@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdgpu: correct psp ucode arrary start address
Thread-Topic: [PATCH] drm/amdgpu: correct psp ucode arrary start address
Thread-Index: AQHXXuPY4/2cPVk7OEa1Hds4+gD6basP5BRg
Date: Sat, 12 Jun 2021 06:05:53 +0000
Message-ID: <BN9PR12MB5226C9AAF63FEF00E1CF5CD4FB339@BN9PR12MB5226.namprd12.prod.outlook.com>
References: <20210611170413.9447-1-Hawking.Zhang@amd.com>
In-Reply-To: <20210611170413.9447-1-Hawking.Zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-06-12T06:05:42Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=e8aab4b9-0bc0-40b7-abfe-ccabafa26da2;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_justification: I confirm the recipients are approved for sharing this
 content
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.134.244]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 94a5a1c3-dff1-409b-0306-08d92d68230f
x-ms-traffictypediagnostic: BN9PR12MB5180:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN9PR12MB518032AF2ACB04816EB9FFF5FB339@BN9PR12MB5180.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3fCn9wU7YKTEX8nD0sbepovtF8Getics2u4bEmzGsmTjLB6t5PSmjteTORMDOkDbvcGNLDevX7bwzrMxuDWBl1a7hjohM5urk+Jp8HDT3FIyvite0p5G8qnhHoaJ9A2rmjyu9iImcwlew0162FrVJoxiL9UcNoZkkgeDFBPx635vh8nmbsVpcLY93HNy38zhOR7gJAi97NiUV0DhUHKRd/Uv4+fYuKV9vAqS+GHHxMF9jfeF44OvUFGcdkh3/oZx9KB+sQcCmH85mO96TZkhTpW6B2ZjbaAI8mgzhTWsvo8XfFo45r/qt9cBVezsGbRsyvG91gio8cnOmy/sBbROiqgpuD8jL++j5ZKcjwahtXH79LE/OAwRmiFXzS2JE28zqc3NJoXs6rdMdbW+WvpdRdMJyEMTGb+Ymslxu+GRDeu/1DO94NNvAJhnmHdqSsXWIUh62suznp2/NCdXGtw+aMzfYWQLzHsn579m4UzQ6Iv8hEGvgDOiFhftaIVAz/i6FfIzQ4lXedYMMNQxCsrQ+4liu6VqGh8GjfAYXLVUusdSSqvjDI1fko5ZKHP6nP+EXiVE13fLVFMT16cE1JQZzXgUG564POJXy5OMMxkDWLk=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5226.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(39860400002)(346002)(136003)(396003)(366004)(478600001)(4326008)(8676002)(26005)(66556008)(66476007)(86362001)(316002)(6506007)(71200400001)(83380400001)(110136005)(66446008)(76116006)(53546011)(122000001)(38100700002)(64756008)(2906002)(186003)(33656002)(6636002)(55016002)(5660300002)(52536014)(66946007)(7696005)(9686003)(8936002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?uVtrZLHEHMX5DRLFPU3/eIe97OKU9L2fOdln6gDgtxzmsju9OxHEZuk6PGAm?=
 =?us-ascii?Q?APkXVSCckGy1xy4ja/jTh2l0pGaP0VWk8S2OTwsf7Ge7HEMZwg+5IVTlWBKg?=
 =?us-ascii?Q?MhOaUKcbYQ2KReeXI6bWJ8dK3f+pbEAB2tvqDZlVmLR2cJkXzatxhboDgUCf?=
 =?us-ascii?Q?/44AsgPkrtqcG/tV+dNAtwo1xl29+R+hsAQOJG2GSdC6YvVbkmxjFQQy0oSZ?=
 =?us-ascii?Q?+zEWpe0OTt3WJiYswcmB14U+ogEzsciJaTTFwN5KDWZ1Du25oLLc5qo5HaJj?=
 =?us-ascii?Q?QLj4WX+r+mHpOcWzyw4+XbMy4YHmoMfq2S5h5G/wwh27hBV/AP3MJMnhlNKU?=
 =?us-ascii?Q?UKVMcwmBnV65HDwaBIRdCtxwqdj921+HqG8SCQqZ7Akok+x0p4wWwd0H51k1?=
 =?us-ascii?Q?CV61o6QbdAPvqIxe93+QUHOoO6d7O9KQXS0UP3e6TBJdEhGr+YB6eZt+6e3y?=
 =?us-ascii?Q?debX0MzWpj4bZAdJVblts8/WdN1pY5NDH9FqEhXePUtyvcFI4E9IIxg1WhK/?=
 =?us-ascii?Q?Irc1//94f7khbzUWHkOvfExyDsqs+96l4ZRos7g7tscQZdNDGzTvDeOzNMeQ?=
 =?us-ascii?Q?KdkDJJVwme37Fl2u8AgbsfoAUTnko0MeDSBKkNgogl3s07dNEudM9HSzUGoa?=
 =?us-ascii?Q?3Y3bAiTUy4AePG5chMiU+hMOH4aAwJjUU9CuAQmVvN/u3X/mJlDT1fGQ5EOj?=
 =?us-ascii?Q?ZeiaRQ7Yk5bC9FNuFm6SJ380hplW+OfEKu+PvMtlOVdY1XZOb4QDd/T7a2eW?=
 =?us-ascii?Q?n+XgzhEUA0XZddJFZEq9v4rFMouRJxJOndScvZeGMTyyKTv4kWJXPgxT8rqm?=
 =?us-ascii?Q?akwvKj5M+F3ucqNaIXL6fELvUvf5Zy3aibyyvb4lGI/8Y3JtIvolTErtlbr2?=
 =?us-ascii?Q?AuTOHOU7TKR4YQMfCNmY6OcpFu69HcgsiS6EfuzbcAeVuwlROhavqGpkmUwB?=
 =?us-ascii?Q?3AQeHj3oUZTcXg6Alvi4lqhhMTdKASD/Y6cPGsNN6e8mjkkojGBe3t+m+dev?=
 =?us-ascii?Q?W+XP2jn1ggsyytNLLT8LtqXwKAP4RcZtdn6pODytiDRTGjClMoPJ/Wi5xz4V?=
 =?us-ascii?Q?o1YhKEn+UEFmOkx964MT5Rppzd+I24HIVHOnCm10qTqF/weg3Zc6Z+ZFMUoh?=
 =?us-ascii?Q?KhlbmnOf1YMMAY4Hs/aaoWYGFeHsRZVNfzNiqW83N5GA4/PuEtCNznwOgRE0?=
 =?us-ascii?Q?llPe4psg2drgrFLhUgpazHc3NNbbc75CTyEnMQYly5YeqCc3em6AcvPLZQHb?=
 =?us-ascii?Q?jcPoshhlu7tOLCF5+zMbRbTFQvFNaQwjEm2ATPeApt3dHgLhP7wb3UKKfBnd?=
 =?us-ascii?Q?Gzidm3MLDIJ1dCeOXDSLLUDT?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5226.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94a5a1c3-dff1-409b-0306-08d92d68230f
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jun 2021 06:05:53.6585 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iLjQhBQtEs6TOzo6XYvkBfn9QoPzz9RaeeD3Lac4s9U0P0GQ2YRiKMjnDj66dH1z8bcQ59cjD6brDiIKrt40og==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5180
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
Cc: "Li, Candice" <Candice.Li@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Reviewed-by: John Clements <John.Clements@amd.com>

-----Original Message-----
From: Zhang, Hawking <Hawking.Zhang@amd.com> 
Sent: Saturday, June 12, 2021 1:04 AM
To: amd-gfx@lists.freedesktop.org; Deucher, Alexander <Alexander.Deucher@amd.com>; Clements, John <John.Clements@amd.com>
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Li, Candice <Candice.Li@amd.com>
Subject: [PATCH] drm/amdgpu: correct psp ucode arrary start address

For ASICs that need to load sys_drv_aux and sos_aux, the sys_start_addr is not the start address of psp ucode array because the sys_drv_aux and sos_aux actaully located at the end of the ucode array, instead, the psp ucode arrary start address should be sos_hdr + sos_hdr_offset.

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 066d1cb1a5e1..f7fbf0604631 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -2957,19 +2957,21 @@ static int psp_init_sos_base_fw(struct amdgpu_device *adev)  {
 	const struct psp_firmware_header_v1_0 *sos_hdr;
 	const struct psp_firmware_header_v1_3 *sos_hdr_v1_3;
+	uint8_t *ucode_array_start_addr;
 
 	sos_hdr = (const struct psp_firmware_header_v1_0 *)adev->psp.sos_fw->data;
+	ucode_array_start_addr = (uint8_t *)sos_hdr +
+		le32_to_cpu(sos_hdr->header.ucode_array_offset_bytes);
 
 	if (adev->gmc.xgmi.connected_to_cpu || (adev->asic_type != CHIP_ALDEBARAN)) {
 		adev->psp.sos_fw_version = le32_to_cpu(sos_hdr->header.ucode_version);
 		adev->psp.sos_feature_version = le32_to_cpu(sos_hdr->sos.fw_version);
 
 		adev->psp.sys_bin_size = le32_to_cpu(sos_hdr->sos.offset_bytes);
-		adev->psp.sys_start_addr = (uint8_t *)sos_hdr +
-				le32_to_cpu(sos_hdr->header.ucode_array_offset_bytes);
+		adev->psp.sys_start_addr = ucode_array_start_addr;
 
 		adev->psp.sos_bin_size = le32_to_cpu(sos_hdr->sos.size_bytes);
-		adev->psp.sos_start_addr = (uint8_t *)adev->psp.sys_start_addr +
+		adev->psp.sos_start_addr = ucode_array_start_addr +
 				le32_to_cpu(sos_hdr->sos.offset_bytes);
 	} else {
 		/* Load alternate PSP SOS FW */
@@ -2979,11 +2981,11 @@ static int psp_init_sos_base_fw(struct amdgpu_device *adev)
 		adev->psp.sos_feature_version = le32_to_cpu(sos_hdr_v1_3->sos_aux.fw_version);
 
 		adev->psp.sys_bin_size = le32_to_cpu(sos_hdr_v1_3->sys_drv_aux.size_bytes);
-		adev->psp.sys_start_addr = (uint8_t *)adev->psp.sys_start_addr +
+		adev->psp.sys_start_addr = ucode_array_start_addr +
 			le32_to_cpu(sos_hdr_v1_3->sys_drv_aux.offset_bytes);
 
 		adev->psp.sos_bin_size = le32_to_cpu(sos_hdr_v1_3->sos_aux.size_bytes);
-		adev->psp.sos_start_addr = (uint8_t *)adev->psp.sys_start_addr +
+		adev->psp.sos_start_addr = ucode_array_start_addr +
 			le32_to_cpu(sos_hdr_v1_3->sos_aux.offset_bytes);
 	}
 
@@ -3005,6 +3007,7 @@ int psp_init_sos_microcode(struct psp_context *psp,
 	const struct psp_firmware_header_v1_2 *sos_hdr_v1_2;
 	const struct psp_firmware_header_v1_3 *sos_hdr_v1_3;
 	int err = 0;
+	uint8_t *ucode_array_start_addr;
 
 	if (!chip_name) {
 		dev_err(adev->dev, "invalid chip name for sos microcode\n"); @@ -3021,6 +3024,8 @@ int psp_init_sos_microcode(struct psp_context *psp,
 		goto out;
 
 	sos_hdr = (const struct psp_firmware_header_v1_0 *)adev->psp.sos_fw->data;
+	ucode_array_start_addr = (uint8_t *)sos_hdr +
+		le32_to_cpu(sos_hdr->header.ucode_array_offset_bytes);
 	amdgpu_ucode_print_psp_hdr(&sos_hdr->header);
 
 	switch (sos_hdr->header.header_version_major) { @@ -3047,16 +3052,16 @@ int psp_init_sos_microcode(struct psp_context *psp,
 		if (sos_hdr->header.header_version_minor == 3) {
 			sos_hdr_v1_3 = (const struct psp_firmware_header_v1_3 *)adev->psp.sos_fw->data;
 			adev->psp.toc_bin_size = le32_to_cpu(sos_hdr_v1_3->v1_1.toc.size_bytes);
-			adev->psp.toc_start_addr = (uint8_t *)adev->psp.sys_start_addr +
+			adev->psp.toc_start_addr = ucode_array_start_addr +
 				le32_to_cpu(sos_hdr_v1_3->v1_1.toc.offset_bytes);
 			adev->psp.kdb_bin_size = le32_to_cpu(sos_hdr_v1_3->v1_1.kdb.size_bytes);
-			adev->psp.kdb_start_addr = (uint8_t *)adev->psp.sys_start_addr +
+			adev->psp.kdb_start_addr = ucode_array_start_addr +
 				le32_to_cpu(sos_hdr_v1_3->v1_1.kdb.offset_bytes);
 			adev->psp.spl_bin_size = le32_to_cpu(sos_hdr_v1_3->spl.size_bytes);
-			adev->psp.spl_start_addr = (uint8_t *)adev->psp.sys_start_addr +
+			adev->psp.spl_start_addr = ucode_array_start_addr +
 				le32_to_cpu(sos_hdr_v1_3->spl.offset_bytes);
 			adev->psp.rl_bin_size = le32_to_cpu(sos_hdr_v1_3->rl.size_bytes);
-			adev->psp.rl_start_addr = (uint8_t *)adev->psp.sys_start_addr +
+			adev->psp.rl_start_addr = ucode_array_start_addr +
 				le32_to_cpu(sos_hdr_v1_3->rl.offset_bytes);
 		}
 		break;
--
2.17.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
