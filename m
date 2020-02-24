Return-Path: <SRS0=KDYH=4M=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7A5EC35679
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Feb 2020 10:15:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5568820836
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Feb 2020 10:15:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="iVzL0zBx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5568820836
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B59936E40C;
	Mon, 24 Feb 2020 10:15:27 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2066.outbound.protection.outlook.com [40.107.93.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 58CD26E40C
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Feb 2020 10:15:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NiVEAOQy3RY2EqJsuwo8KVSZ8k23Pn7X2DCoKDLIfjCYHM0ZFBiBLWaj5Sw8KJtDGSNJFrmNrAJDy0q0TJToAHmB7g9Vyijx03iUlYxcsdq6SqN9DhUpgtRl5A27nawd3B5+0BZs0aY4cM6ln1rSkHP8aq2OHyAz0qLz/SVc+SwTVBqTNBzDF0sJsDO0PxaAhqV8ZDeBRlb7g4vLGnOuOrZBIXyLRikFIPh8STgp/jKVjGH8HNQ0j1AbdF6Rs6HNmcabUQ4IU55uWV5Ci251oPS38IlNxAvOUPv5S4a4yDsEC2WmMvo05VnHOWCnKHfG8jTEzfcPKz7sBRQrSHqtIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KJfIm/25P95+b0To0EM2Tt6bdgTZGUam+UeUZUsfjxc=;
 b=ajmHfbfhxBKFHZFwkiKY261b+vrhsnTUzGpHLgMoNKcExhIIF/XF68szr44vmP0+TLu/nmVWWlwkD7aPRScC/UKI1oVy9cl5Oz5LXGkiRtEO6E+JCZgoTKFPzZ64GOqp43HtY+2j4zm7dxuN1MJCS5cC48vDWlwaQDoW5kgTHk+qlEncvkxYNusUaBvDRgJn8eMJ7G2593FQolsUdlE6+jePb9Gk3/rEOONmaRqctIllXPsF6+MJyTpw8fXwxxSqZUJG3wK5kp/RS/sr2YAaN7ZvMeCd3FBxt+fRc/IxPrXkurt196nMIfXkabEtbkG7XvW/3N3C/rGAzBtc2dJzew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KJfIm/25P95+b0To0EM2Tt6bdgTZGUam+UeUZUsfjxc=;
 b=iVzL0zBxDjNKH1ZqgX9DBiV1kbOoZjA6W0ITY5dVIb6OuTgnTxR9wvmwykcilr2APElmkgmi9otLQgJyeMgaF/bCEzNIQC5X0hhdSq3QCc8xlByKMUuVxgmK4zKQBp9mfd/r5rLOAlpeBATexjFe43wjN+Lz5glUzz+CXFApk3k=
Received: from MN2PR12MB3344.namprd12.prod.outlook.com (2603:10b6:208:c5::10)
 by MN2PR12MB4045.namprd12.prod.outlook.com (2603:10b6:208:1d6::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.17; Mon, 24 Feb
 2020 10:15:24 +0000
Received: from MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::69c7:b493:690:2173]) by MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::69c7:b493:690:2173%3]) with mapi id 15.20.2750.021; Mon, 24 Feb 2020
 10:15:24 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Clements, John" <John.Clements@amd.com>, 
 "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Feng, Kenneth"
 <Kenneth.Feng@amd.com>
Subject: RE: [PATCH 3/3] drm/amdgpu: toggle DF-Cstate to protect DF reg access
Thread-Topic: [PATCH 3/3] drm/amdgpu: toggle DF-Cstate to protect DF reg access
Thread-Index: AQHV6voNyDYpT5M8Rkuh3TteziaSG6gqIGXA
Date: Mon, 24 Feb 2020 10:15:24 +0000
Message-ID: <MN2PR12MB3344D99ADC45441911794383E4EC0@MN2PR12MB3344.namprd12.prod.outlook.com>
References: <20200224100550.13722-1-Hawking.Zhang@amd.com>
 <20200224100550.13722-3-Hawking.Zhang@amd.com>
In-Reply-To: <20200224100550.13722-3-Hawking.Zhang@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=2c3c5eb4-c635-4c4a-9141-000089674e47;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-02-24T10:14:19Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Evan.Quan@amd.com; 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e6a678ce-ed72-417a-57ed-08d7b9127659
x-ms-traffictypediagnostic: MN2PR12MB4045:|MN2PR12MB4045:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB4045F454A90BC2DCA7BCE329E4EC0@MN2PR12MB4045.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-forefront-prvs: 032334F434
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(346002)(376002)(39860400002)(396003)(366004)(199004)(189003)(6506007)(7696005)(9686003)(33656002)(55016002)(186003)(81156014)(6636002)(8676002)(8936002)(71200400001)(81166006)(110136005)(2906002)(478600001)(316002)(64756008)(66556008)(66476007)(66446008)(66946007)(5660300002)(4326008)(86362001)(52536014)(53546011)(76116006)(26005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB4045;
 H:MN2PR12MB3344.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Nw3N/zTJWhU7mcTVsSwh43WazhJpa+GdnFACcq4Exabm6Tx8sfL/XS/Hj6X2uXpIFWxGpNS8BT36rPo1fpnmWD5po1MxccnOaGCVL+RWKQaFjPVL78rhVtqfVTHmjlTTvj3mJRzL3zsh2A+BGR+2WD658KWMz3Tooe5sFlYPT3jhqr00MVlB90RHjpjZdcq6wOY38Qftaynz+G3HgEhtkkX2ZszAduAxy4WEoqDOVNyynFDOe8/lvEAiY3fuS8DX7hNu7wGgVmAVj8pDghMUk8QUKWem4Wg61N5m3gJvvy7k+ZRIgOPQRDMYedFiOgyRZ6xNu3CWla27ZtgSklIKMPvfafnxoebfWik56oBZp8fH9tTLuUrOxq0eDrsqahGNspMqiMFMiFbb9FnfblNHWgqOjnoGLhCYcPDy8jfXe4Fkm9KqMocms30n/i/vE8gM
x-ms-exchange-antispam-messagedata: pKzQRAsBPxKbZecicjUKilQ3Xi9tAV4ZlfYRz7IhGPXdp56cw7BG268BnSSFPb/X4+Elhx0iSbCVX32bPec4WropxykPOLOQJhvKHzJdXEoGLM82tkh/G4WHzetzdVQ9zIsoXepe7l0Mt4r0j2N8pw==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6a678ce-ed72-417a-57ed-08d7b9127659
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2020 10:15:24.0712 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wXEfawCSiQ+bJLN4s1LNCdWAZHgwjcdJPqB5lZBw8byvEhOQNtO1W7ETHbH4A998
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4045
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

Patch1 is reviewed-by: Evan Quan <evan.quan@amd.com>
Patch2 & 3 are acked-by: Evan Quan <evan.quan@amd.com>

-----Original Message-----
From: Hawking Zhang <Hawking.Zhang@amd.com> 
Sent: Monday, February 24, 2020 6:06 PM
To: amd-gfx@lists.freedesktop.org; Clements, John <John.Clements@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>; Feng, Kenneth <Kenneth.Feng@amd.com>; Quan, Evan <Evan.Quan@amd.com>
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: [PATCH 3/3] drm/amdgpu: toggle DF-Cstate to protect DF reg access

driver needs to take DF out Cstate before any DF register
access. otherwise, the DF register may not be accessible.

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c | 25 +++++++++++++++++++-----
 1 file changed, 20 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
index 8edd1db0d1ce..856dd22465d4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
@@ -535,13 +535,28 @@ uint64_t amdgpu_xgmi_get_relative_phy_addr(struct amdgpu_device *adev,
 					   uint64_t addr)
 {
 	uint32_t df_inst_id;
+	uint64_t dram_base_addr = 0;
+	const struct amdgpu_df_funcs *df_funcs = adev->df.funcs;
+
+	if ((!df_funcs)                 ||
+	    (!df_funcs->get_df_inst_id) ||
+	    (!df_funcs->get_dram_base_addr)) {
+		dev_warn(adev->dev,
+			 "XGMI: relative phy_addr algorithm is not supported\n");
+		return addr;
+	}
 
-	if ((!adev->df.funcs)                 ||
-	    (!adev->df.funcs->get_df_inst_id) ||
-	    (!adev->df.funcs->get_dram_base_addr))
+	if (amdgpu_dpm_set_df_cstate(adev, DF_CSTATE_DISALLOW)) {
+		dev_warn(adev->dev,
+			 "failed to disable DF-Cstate, DF register may not be accessible\n");
 		return addr;
+	}
+
+	df_inst_id = df_funcs->get_df_inst_id(adev);
+	dram_base_addr = df_funcs->get_dram_base_addr(adev, df_inst_id);
 
-	df_inst_id = adev->df.funcs->get_df_inst_id(adev);
+	if (amdgpu_dpm_set_df_cstate(adev, DF_CSTATE_ALLOW))
+		dev_warn(adev->dev, "failed to enable DF-Cstate\n");
 
-	return addr + adev->df.funcs->get_dram_base_addr(adev, df_inst_id);
+	return addr + dram_base_addr;
 }
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
