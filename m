Return-Path: <SRS0=Izb8=44=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3F9EC10F25
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Mar 2020 05:55:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85B37208C4
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Mar 2020 05:55:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="v3ltMzxW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85B37208C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E0BC56E41A;
	Wed, 11 Mar 2020 05:55:00 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2084.outbound.protection.outlook.com [40.107.220.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 485786E41A
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Mar 2020 05:54:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PiPEwYE5ELyLdTiDue1KumiQRZs0X7PHD3cdqE7++Yjg/Jf0/CDZBnGmBpFXhZ3hFM+PGidfyUCO7zyfIokwD4SEhqz1js9PZfOXBS0djMBw8dz0P4OcVOPuAv1aivUqVofqXxHyNk17pq/XmJ7KkJZ1a+oV/qer8Fs8eduZ3o0Yq+v2A7PJBbDs3IxYwsDX0GkFRNm/yt5EqJvPaKUeFlZskxojGvrMxuXQpu+LSxeVIDxR8sz4Nufz4ieYBvoGI5qI0tQITx2v+gm9L2zVDbuolr6/fwrlExZowedIGpLVdCiBhuv4HpiD7O2yNWKeNNLMd+dnsWp1yJofWmmVrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xStYcWJxtHIpYtPEuQcutx+kCBOAOgzUo/BHtBBXQX8=;
 b=j9jXSFHotdVRm+Bf7kTfE58Tb1uwGPZcQ2HGgAp9FbvCIxbsO+776dfRP0AC//qxUOGeVRXAvX4meBlzug+q3SVdNGqUaaDYnLipt29CAYSQZWAKE2IDZ+eBKPF3E/d2L8WguCaRdM/ErYdBl7JQsqtyNbVZqorKmYVul2qotHI3WAkSmV4JKIXrphYVj46x+ekyPUgBVxXWS5omaRKIVdcnLEyUzu/D4q3RAolu1D/ftxVobY4swqP0aOTFEqJAJ/fYgFsv+IvGZ3ZuXNr3XwJ/hPzaruG3JAeljYvGso00giIvJSi4Sb4xq5Nz/KJYjTnCinrKrxAix8+V6ReF6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xStYcWJxtHIpYtPEuQcutx+kCBOAOgzUo/BHtBBXQX8=;
 b=v3ltMzxWzYzNQiy4fUISuJMmQKCkW8cpLv5aJbB1oZDSYh9dnbgy+1QK3ppHDim8IsGEISrEOytanyy1wSh2lMB8JpuivY4ojTG0pxEPbBu81eHG7embv9rn7QA9O5w1XNjjk9yck7vAu7WWhrn264WGOUzD8TniN8/UKAOH+Ls=
Received: from MN2PR12MB3933.namprd12.prod.outlook.com (2603:10b6:208:162::18)
 by MN2PR12MB4582.namprd12.prod.outlook.com (2603:10b6:208:26b::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.17; Wed, 11 Mar
 2020 05:54:57 +0000
Received: from MN2PR12MB3933.namprd12.prod.outlook.com
 ([fe80::3147:1ea1:8fcf:2cf4]) by MN2PR12MB3933.namprd12.prod.outlook.com
 ([fe80::3147:1ea1:8fcf:2cf4%7]) with mapi id 15.20.2793.018; Wed, 11 Mar 2020
 05:54:57 +0000
From: "Liu, Monk" <Monk.Liu@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Chen, Guchun" <Guchun.Chen@amd.com>,
 "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Clements, John" <John.Clements@amd.com>,
 "Li, Dennis" <Dennis.Li@amd.com>
Subject: RE: [PATCH] drm/amdgpu: check GFX RAS capability before reset counters
Thread-Topic: [PATCH] drm/amdgpu: check GFX RAS capability before reset
 counters
Thread-Index: AQHV92lWeFL65B1M902bCzGnVsQ2O6hC5Enw
Date: Wed, 11 Mar 2020 05:54:57 +0000
Message-ID: <MN2PR12MB3933C1EFF05C22B1E92DA1C884FC0@MN2PR12MB3933.namprd12.prod.outlook.com>
References: <20200311055246.30089-1-Hawking.Zhang@amd.com>
In-Reply-To: <20200311055246.30089-1-Hawking.Zhang@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Monk.Liu@amd.com; 
x-originating-ip: [180.167.199.185]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4f2b7293-b3dd-409e-8d24-08d7c580bab5
x-ms-traffictypediagnostic: MN2PR12MB4582:|MN2PR12MB4582:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB4582EB8EB944F8853A3E8C6E84FC0@MN2PR12MB4582.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 0339F89554
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(39860400002)(376002)(366004)(346002)(136003)(199004)(66476007)(64756008)(45080400002)(478600001)(66556008)(53546011)(8676002)(81166006)(66946007)(5660300002)(76116006)(71200400001)(8936002)(66446008)(9686003)(966005)(52536014)(6506007)(6636002)(2906002)(55016002)(4326008)(316002)(110136005)(81156014)(186003)(26005)(7696005)(86362001)(33656002)(921003)(1121003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB4582;
 H:MN2PR12MB3933.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Afze92+R26NGQoyv5xrK/6mkctj5pe/WSYdg1IClCpMN2WKpXoTnikzVluiUm6VkRMvtJ0Ta1dEHmVdXS/sppToYswii8xegpwtRu4Kjd5Xy0LhSjgpULYW5cEjViSbH+sy4FneXCib64mPj/WQgEkriMbIiguqDUQ4xyLLz8Q7xDGsxc7o1d/PpQ8Z0vLhB6+rBdhoah+466p52eU46+l6FOFFwcgV80zv+HxUBR+ooDaFbn1Lguoh0sXVfOH60QRYk09Jds+fvXkWSocT5mkK+I+JvrjdHJeLU/MVyDRxbGcc9a9Yqe2S3ui5dhu9pVJRXsi7pYzub1/hWnS1YXQ5/LibBMPCMJcUnE3+bL978zTHdODSGgt0AlrmbzYDZlbobuhhRaLBJX4XCNJK+eFo8ce88sxrnKagFtd0QxUXmY20HI02XsQ7QqDljs9b0u8o9GJC4g/ur8f4cwfbrk3BMVstGL4iY482YWw3ay4wSykxPv+oUBLjodidKkFeLjVDr6wcFJyEJhbQcYmpQdkKj46FRx3t2ErneIekO6UyMZBavB7/GcVk6eJZ81Jp3ArGlUjwxRR3I8wMrMAthHg==
x-ms-exchange-antispam-messagedata: zm3eIo309mzw5f9923yCvHXq6DEteV/wLHvWVjMAoN6mA5ZM0XvraHNNPLdrEby9mk/Uezxfb5qxA1yklFw3ep6G7RYihugNa1VszqWBMnYAUByUY8e4RNm7+oIsGiUpDylI+nU6J4+dk+jl40jXog==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f2b7293-b3dd-409e-8d24-08d7c580bab5
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2020 05:54:57.4690 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: C4MwqargZR8U/fs5d6lPCRmpzM0NsPdbxIVT5bKfpXi1EDWxQc6Wc+DgJPcjw9hj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4582
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
Cc: "Zhang, Hawking" <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Reviewed-by: Monk Liu <monk.liu@amd.com>

_____________________________________
Monk Liu|GPU Virtualization Team |AMD


-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Hawking Zhang
Sent: Wednesday, March 11, 2020 1:53 PM
To: amd-gfx@lists.freedesktop.org; Chen, Guchun <Guchun.Chen@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>; Clements, John <John.Clements@amd.com>; Li, Dennis <Dennis.Li@amd.com>
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: check GFX RAS capability before reset counters

disallow the logical to be enabled on platforms that don't support gfx ras at this stage, like sriov skus, dgpu with legacy ras.etc

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 3 +++  drivers/gpu/drm/amd/amdgpu/gfx_v9_4.c | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index efd52bcf8785..dd8e68fdbd90 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -6328,6 +6328,9 @@ static void gfx_v9_0_reset_ras_error_count(struct amdgpu_device *adev)  {
 	int i, j, k;
 
+	if (!amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__GFX))
+		return;
+
 	/* read back registers to clear the counters */
 	mutex_lock(&adev->grbm_idx_mutex);
 	for (i = 0; i < ARRAY_SIZE(gfx_v9_0_edc_counter_regs); i++) { diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4.c
index 17f1e7b69a60..cceb46faf212 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4.c
@@ -897,6 +897,9 @@ void gfx_v9_4_reset_ras_error_count(struct amdgpu_device *adev)  {
 	int i, j, k;
 
+	if (!amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__GFX))
+		return;
+
 	mutex_lock(&adev->grbm_idx_mutex);
 	for (i = 0; i < ARRAY_SIZE(gfx_v9_4_edc_counter_regs); i++) {
 		for (j = 0; j < gfx_v9_4_edc_counter_regs[i].se_num; j++) {
--
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Cmonk.liu%40amd.com%7C9bd134aae9bd4be2cc3408d7c580771f%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637195027861178518&amp;sdata=VzcSAVLQMOEvoZ%2FPBHx2FTx81OYUU0j0SnntXDAuFCw%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
