Return-Path: <SRS0=S/Du=4V=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 437C8C3F2D1
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Mar 2020 03:21:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E2C320842
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Mar 2020 03:21:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="CaGBcIA1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E2C320842
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE7506E9A8;
	Wed,  4 Mar 2020 03:21:01 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2057.outbound.protection.outlook.com [40.107.236.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 408E26E9A8
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Mar 2020 03:21:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qzt2+AC0tGO0Infsbliyt+eIwdVUPPanLqo7JXmxZnTX+RoDotdy/Svqtz2cVA2M9WXhr3f5bMGP8MIbjAai7mH8+OEt40VxD/YlQVMFzc37FnPbXD7c/VDieD2kzQyU6a64Gwe26G8Edz6c1ghn9ulZoTjfD40kxeUDavUnvSLIZvR4ao/fd85gpXiRjAMxZ+sn0icu7mFrv7LWovHUXn8ovof6wCQyerG7DPvsPNLk6lVtV0t7iQ6WNdThMCKfWKiGakgdQNDRwZg/iwkhwo+z91sWbcwARR6fJAbwqEEhT5d7EuDBPUuj0xBSR31IdCFC9qQ5eZx+8j5Vq9koDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HEuNIrVNDxFE527mrnNS5QcNdUpXQXbwdoS2SHoxLhk=;
 b=abLthppT4awMT8X7JSX0yUgevvUa+A3kRTH9qnHE47Uuf2ox4Aqf9DspvFR8Zk1OdCw6bD8FRvrQG/9SnM+KJxkqElkbXtO61G8NXF1stvvLcT3EgNZYCrZEVWx4AK1DzjGKtJ1dne7vsflUr4l6fbTK8jB88Zli2Lz4kq8TnzZSNVbpOHz1lKZpt93/z0eYC/KixWM6c5z8Tb7LZDm2MpLZ6pz+vSReBFHNJeT8NDc6U0ZvQKw8kN65onZHKkbx1v5OQfYUfaHC5vGfbwygTVclL/qaf/pa1sVJBe9yNxQZiJQ9jHoOZkrGQMxg74eOujrn8DsbHIue2pNTkZgFlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HEuNIrVNDxFE527mrnNS5QcNdUpXQXbwdoS2SHoxLhk=;
 b=CaGBcIA1H+HRwBnRlOqzQmdulX45CFJuM76tZmKh+toLQauZkparts3+yl+Pbh9JQEbTC+mgDb1Al8bx7fpo39WErc6DB7D2NZDPDbXDLyTkbjmMMntH/Omtew2EqkRGRv9FhQM8BgXywn+0OlNJfmHEmnZLNS79P1r5Aoy4hQY=
Received: from MN2PR12MB3344.namprd12.prod.outlook.com (2603:10b6:208:c5::10)
 by MN2PR12MB4568.namprd12.prod.outlook.com (2603:10b6:208:260::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.14; Wed, 4 Mar
 2020 03:20:58 +0000
Received: from MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::69c7:b493:690:2173]) by MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::69c7:b493:690:2173%3]) with mapi id 15.20.2772.019; Wed, 4 Mar 2020
 03:20:58 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Liang, Prike" <Prike.Liang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/2] drm/amd/powerplay: map mclk to fclk for
 COMBINATIONAL_BYPASS case
Thread-Topic: [PATCH 2/2] drm/amd/powerplay: map mclk to fclk for
 COMBINATIONAL_BYPASS case
Thread-Index: AQHV8dCTvuc+E3Lz40SGHYfj9GwpAqg3xB8g
Date: Wed, 4 Mar 2020 03:20:58 +0000
Message-ID: <MN2PR12MB334475538AA17E78AF4B775DE4E50@MN2PR12MB3344.namprd12.prod.outlook.com>
References: <1583290538-30426-1-git-send-email-Prike.Liang@amd.com>
 <1583290538-30426-2-git-send-email-Prike.Liang@amd.com>
In-Reply-To: <1583290538-30426-2-git-send-email-Prike.Liang@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=b2694179-77d0-4456-962b-00000309c1b9;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-03-04T03:20:38Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Evan.Quan@amd.com; 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 317971f8-b8a4-4eb8-75e6-08d7bfeb0f06
x-ms-traffictypediagnostic: MN2PR12MB4568:|MN2PR12MB4568:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB4568058EB3C44ED82664AC86E4E50@MN2PR12MB4568.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1824;
x-forefront-prvs: 0332AACBC3
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(396003)(346002)(376002)(136003)(39860400002)(189003)(199004)(86362001)(8936002)(55016002)(186003)(478600001)(26005)(8676002)(9686003)(81166006)(81156014)(4326008)(110136005)(53546011)(33656002)(2906002)(52536014)(5660300002)(71200400001)(7696005)(66946007)(66476007)(64756008)(76116006)(66446008)(66556008)(316002)(6506007);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB4568;
 H:MN2PR12MB3344.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: outLjuX/ke+Ifa4PGdzCbLBt1oACxT/t/lSic94XN+GLmhHXg3HfBziPmNEqxzu5c9Ho/cWDPVTccXd+nG9EI3GdtsO3O5g/5KTJsKQPbC0iOdorjZ8VmAvMWpdmKg43+W4N55b49faJUd3p9gnrwhfgpR2u9j+h2fZxOqYpBL0MJqwoSthJrcxvJhRuAthTlVKLqaJjU1syfkgeeFxM4tezaaBCQRSSfOUdZApKHrE/vBWBrl2lpokVbq69AeEU1v+U5J9uPqqfvCttzqA9/BwSq1wqYKlT5kYiTNX5WrutHWv/eMrTRqaPTqW/3BBVSSoQc9GE1IPaHpxsemir0F7+/74SgTjLjKnov76z/IkzBe7LEdbwGk0ZioCNodYp8XH35JnBMlA8KdHuOo/bg5aR0TKeX8P5jZzF3ZTKZPL1LZ3szKwzpLzp6r8l/m6M
x-ms-exchange-antispam-messagedata: xHyWai+x5wDuhwPwVB8C5snBOnCZ/YU7Zx14fY2KMbwjQla/JLJXdZDT1977M+wSUwQG9KxSQhxZBa/0ciTjd0/XsdODwwICs7fK3Dr8avCpcxzxiZejkX9YY/gsgpkvAfv1rbsoFN3K1TlZKL1MyA==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 317971f8-b8a4-4eb8-75e6-08d7bfeb0f06
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2020 03:20:58.5536 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: v4Wg9tUcSFmOd5XgFzB0s54h4r5TH53S7hIjt+Q/nU2sOD2rH2eFirgy9WS2MN9J
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4568
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
Cc: "Huang, Ray" <Ray.Huang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Series is reviewed-by: Evan Quan <evan.quan@amd.com>

-----Original Message-----
From: Liang, Prike <Prike.Liang@amd.com> 
Sent: Wednesday, March 4, 2020 10:56 AM
To: amd-gfx@lists.freedesktop.org
Cc: Quan, Evan <Evan.Quan@amd.com>; Huang, Ray <Ray.Huang@amd.com>; Liang, Prike <Prike.Liang@amd.com>
Subject: [PATCH 2/2] drm/amd/powerplay: map mclk to fclk for COMBINATIONAL_BYPASS case

When hit COMBINATIONAL_BYPASS the mclk will be bypass and can export
fclk frequency to user usage.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/powerplay/renoir_ppt.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/renoir_ppt.c b/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
index cca4820..653faad 100644
--- a/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
@@ -111,8 +111,8 @@ static struct smu_12_0_cmn2aisc_mapping renoir_clk_map[SMU_CLK_COUNT] = {
 	CLK_MAP(GFXCLK, CLOCK_GFXCLK),
 	CLK_MAP(SCLK,	CLOCK_GFXCLK),
 	CLK_MAP(SOCCLK, CLOCK_SOCCLK),
-	CLK_MAP(UCLK, CLOCK_UMCCLK),
-	CLK_MAP(MCLK, CLOCK_UMCCLK),
+	CLK_MAP(UCLK, CLOCK_FCLK),
+	CLK_MAP(MCLK, CLOCK_FCLK),
 };
 
 static struct smu_12_0_cmn2aisc_mapping renoir_table_map[SMU_TABLE_COUNT] = {
@@ -280,7 +280,7 @@ static int renoir_print_clk_levels(struct smu_context *smu,
 		break;
 	case SMU_MCLK:
 		count = NUM_MEMCLK_DPM_LEVELS;
-		cur_value = metrics.ClockFrequency[CLOCK_UMCCLK];
+		cur_value = metrics.ClockFrequency[CLOCK_FCLK];
 		break;
 	case SMU_DCEFCLK:
 		count = NUM_DCFCLK_DPM_LEVELS;
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
