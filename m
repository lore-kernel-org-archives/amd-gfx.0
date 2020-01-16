Return-Path: <SRS0=9Rk5=3F=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FC2AC32771
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jan 2020 01:51:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 129F8207E0
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jan 2020 01:51:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="zE/xh/pj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 129F8207E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AEB996E1E9;
	Thu, 16 Jan 2020 01:51:31 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2072.outbound.protection.outlook.com [40.107.223.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0EF9A6E1E9
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Jan 2020 01:51:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BB2avB1/TgUhEXgwsd4JP6EgqmUKMHd4DdEEV/nKnLr2FLBo+OBW0nUn5BRzImGO1qQyqTtVTaZpbxeVfoiMWzeIGriZFKMia751Gn+y5lgAsP7NWjiPVKSoCGpL6vr1OFFZvxt1F5Pb/n2KPB2izEtNkPO+on+y3AafxKeIFjfgRVVopTT2+pn0IGtExKXIrX64R/9tJt7t5YauouJFhdm2jvNCamVkbRGcNwzwy7q4SB/nyrhkC3tuO/D2YO0CN4iyvaAarexf12kAgdRKaOwhAN+ryaVs6Lp+46ZKL5Ter4fYi4kb9VPl4+pM580l1N/tkM+X273M7kJ9MUjY9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Us2dGeWQp+YRDBPmlEaysl3UHMBAjtjXRVygF89NB4Q=;
 b=gn+c1bBbMo+wRaU1Y71WG/O7Y4iAnSyr3hOdiK0tqCT8wqy8US5C+Sj3ix1b0js8GOTN2serlYqQBzT//eVHQJWhREk0sexxEZcqlZET++ZwnPplHVkS3hkmoRFTE4p+x2UucvFWNNRnnJtkQJ7R0UGiwsuPCfOg+tHXX/FfZuKgHvtbQnPlV0bryFKMchrWWRL8aOlmDWCw1uUNA9gzIJVuiYCktNziVbeyjwH5SurE0fn6LEvsB1GajFhEW1Fv0Bu3ecdkHBqcmzqoBOyb8AHta7gnWCw3H9LWofeVDFcmWJ+sQsy+eHdM3xJ9S6+1sZiqKH3ha/F2P4f9PHKxdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Us2dGeWQp+YRDBPmlEaysl3UHMBAjtjXRVygF89NB4Q=;
 b=zE/xh/pjOfRQISdjvEeEs/wdEYuvohN58FiupTt0WwsPXrhGQ8muXHBjWwAWkM2Ocwm6cAnQA5NQAAB4TXc7y3VgeQIiloGJVglKAmTd9RDIt/zcFeJyJMlpv6Mb0b9PUWXTmy7JJILoOlUZ8N6135EF6isoR/1tqlLtq7mWOh0=
Received: from MN2PR12MB3167.namprd12.prod.outlook.com (20.179.80.95) by
 MN2PR12MB2879.namprd12.prod.outlook.com (20.179.80.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.20; Thu, 16 Jan 2020 01:51:27 +0000
Received: from MN2PR12MB3167.namprd12.prod.outlook.com
 ([fe80::746d:8d3c:30d3:fd71]) by MN2PR12MB3167.namprd12.prod.outlook.com
 ([fe80::746d:8d3c:30d3:fd71%7]) with mapi id 15.20.2623.015; Thu, 16 Jan 2020
 01:51:27 +0000
From: "Li, Dennis" <Dennis.Li@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: attempt to enable gfxoff on more raven1 boards
Thread-Topic: [PATCH] drm/amdgpu: attempt to enable gfxoff on more raven1
 boards
Thread-Index: AQHVy8msd2Sn3Lqn80uTHER8/EdT/qfshOsQ
Date: Thu, 16 Jan 2020 01:51:27 +0000
Message-ID: <MN2PR12MB31672D3E94DEB4EBB91359CFED360@MN2PR12MB3167.namprd12.prod.outlook.com>
References: <20200115173139.1392429-1-alexander.deucher@amd.com>
In-Reply-To: <20200115173139.1392429-1-alexander.deucher@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-01-16T01:51:25Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=b6275727-c15e-4e32-8a9c-0000b20d7cbc;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-01-16T01:51:25Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: de3295f4-4634-4ae5-bdf5-0000429c5810
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Dennis.Li@amd.com; 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4e5f61ca-59b4-4d8a-3a9c-08d79a2699d6
x-ms-traffictypediagnostic: MN2PR12MB2879:|MN2PR12MB2879:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB28798D9723BCE94ED802BD18ED360@MN2PR12MB2879.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2958;
x-forefront-prvs: 02843AA9E0
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(39860400002)(366004)(396003)(376002)(136003)(199004)(189003)(66476007)(76116006)(64756008)(66556008)(7696005)(316002)(66946007)(66446008)(26005)(6506007)(52536014)(5660300002)(53546011)(33656002)(110136005)(186003)(2906002)(86362001)(4326008)(9686003)(55016002)(81156014)(81166006)(45080400002)(8936002)(966005)(8676002)(71200400001)(478600001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB2879;
 H:MN2PR12MB3167.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: x0p+1Ey+BgR5KwObaYkr+2rnNu8jH9hBtRSrHuhKriiP7C3o5gh4T+CGbNPOIz34Yapagmn594C229M2mu6rb//QG7paAacEgckqO89jFt7E+MbLtQ2T9tB7TH7euqKZDy0kTLrOCZ9HyJHNS8pZmPcuLr/EfJpum4cVWmu1yDVhHlr+358/XrcmcWLUngcmUKX8cs3TrPSj8LTM3HVkUXVZrFT0ZKU3Xr2T6uQGU+xzn8FFuQ5Xe8DkJVKgzB3qp3X8MAMTCO5Hyl4GoPTjpWw+JrldCC9AkpxJJ1yuI/rnYfW3WyAfNFZi8GMzHg/rsf15iXvFvsUs6FlsycjDHn1A/hMMGK86MTNr02MnsBI6qXXQnqQWyPav4anz0vcbXLtQEUJVPUi0GIG7RbRJOFdpbdnyJDg8/Yj41Laa6bNIAwmRBYEMRZA1n+5neCC4m0ah1s/7CAtCv1s1ckCs0yva0gyHUJ9V5KZphC2BmXw=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e5f61ca-59b4-4d8a-3a9c-08d79a2699d6
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2020 01:51:27.4444 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oa2oylC40DLuKB1FuK/pYlFDmmqFhKLUFVlnGu0ehy5zhRt8de2bGolnudu3Kv9Q
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB2879
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Hi, Alex,
      it is better to refine the patch as a common function, not only used for raven.

Best Regards
Dennis Li
-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deucher
Sent: Thursday, January 16, 2020 1:32 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: [PATCH] drm/amdgpu: attempt to enable gfxoff on more raven1 boards

Switch to a blacklist so we can disable specific boards that are problematic.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 42 ++++++++++++++++++++++++---
 1 file changed, 38 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index e3d466bd5c4e..b48b07bcd0fb 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -1031,6 +1031,37 @@ static void gfx_v9_0_check_fw_write_wait(struct amdgpu_device *adev)
 	}
 }
 
+struct amdgpu_gfxoff_quirk {
+	u16 chip_vendor;
+	u16 chip_device;
+	u16 subsys_vendor;
+	u16 subsys_device;
+	u8 revision;
+};
+
+static const struct amdgpu_gfxoff_quirk amdgpu_gfxoff_quirk_list[] = {
+	/* https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fbugzilla.kernel.org%2Fshow_bug.cgi%3Fid%3D204689&amp;data=02%7C01%7CDennis.Li%40amd.com%7C33990b7157714a2f943a08d799e0cda3%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637147063123345220&amp;sdata=2mT3Eug%2FEDKGGbI1bqymp2tnMqLX4x%2B2BAWnLUnq5m0%3D&amp;reserved=0 */
+	{ 0x1002, 0x15dd, 0x1002, 0x15dd, 0xc8 },
+	{ 0, 0, 0, 0, 0 },
+};
+
+static bool gfx_v9_0_raven_check_disable_gfxoff(struct pci_dev *pdev) {
+	const struct amdgpu_gfxoff_quirk *p = amdgpu_gfxoff_quirk_list;
+
+	while (p && p->chip_device != 0) {
+		if (pdev->vendor == p->chip_vendor &&
+		    pdev->device == p->chip_device &&
+		    pdev->subsystem_vendor == p->subsys_vendor &&
+		    pdev->subsystem_device == p->subsys_device &&
+		    pdev->revision == p->revision) {
+			return true;
+		}
+		++p;
+	}
+	return false;
+}
+
 static void gfx_v9_0_check_if_need_gfxoff(struct amdgpu_device *adev)  {
 	switch (adev->asic_type) {
@@ -1039,10 +1070,13 @@ static void gfx_v9_0_check_if_need_gfxoff(struct amdgpu_device *adev)
 	case CHIP_VEGA20:
 		break;
 	case CHIP_RAVEN:
-		if (!(adev->rev_id >= 0x8 ||
-		      adev->pdev->device == 0x15d8) &&
-		    (adev->pm.fw_version < 0x41e2b || /* not raven1 fresh */
-		     !adev->gfx.rlc.is_rlc_v2_1)) /* without rlc save restore ucodes */
+		if (!(adev->rev_id >= 0x8 || adev->pdev->device == 0x15d8) &&
+		    ((adev->gfx.rlc_fw_version != 106 &&
+		      adev->gfx.rlc_fw_version < 531) ||
+		     (adev->gfx.rlc_fw_version == 53815) ||
+		     (adev->gfx.rlc_feature_version < 1) ||
+		     !adev->gfx.rlc.is_rlc_v2_1) &&
+		    !gfx_v9_0_raven_check_disable_gfxoff(adev->pdev))
 			adev->pm.pp_feature &= ~PP_GFXOFF_MASK;
 
 		if (adev->pm.pp_feature & PP_GFXOFF_MASK)
--
2.24.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7CDennis.Li%40amd.com%7C33990b7157714a2f943a08d799e0cda3%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637147063123345220&amp;sdata=ON7UTCOhoCaW%2Bwp0KiMCjOQHt6QohngaFxx9hgfKS7o%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
