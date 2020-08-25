Return-Path: <SRS0=LR/f=CD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34D7AC433E1
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Aug 2020 02:38:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1A96205CB
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Aug 2020 02:38:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ImifhsCb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1A96205CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A60B56E7F1;
	Tue, 25 Aug 2020 02:38:09 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2084.outbound.protection.outlook.com [40.107.243.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3986E6E7F1
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Aug 2020 02:38:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ly0nRA1wEWhfj3SGDcGcw9sCXcR/iYnDe7xxfA2c20Vm/EtDVQk/xxuQfcY+qzeNrF2jQpoKAqO8IL877xLYhOwOAAoJiD6aPkYUEC2+SBMORNNdlsFVRWwwvT5mLwzx67vRJvqTXyq5GxIf5DLxFj5I54f6KJFT2CpISeUWIV1jwrmdU6tz9eFM/8h4TuCajrgJx8yWgXUqfh5oLp6jASkxA128f1aoxBxizye2ZQe4R3QwFDK3epPRbqjMq+SRBFwHlBDvfJxKruCrvH3O6O55C2CxUUqc6Dd5DqTXXqhHK3mFCl+CXkAD4ucNApzYtbtcg21gz4iBQDRomzJvuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wWCvlr/vIZgRPqRSNrr79Zlrrfj4c4H/CeqlGicabHo=;
 b=RwADjEg37csXl/y/br457nBQxjddM7HVhB6RDiSzUV1LJiI9Wep9eBLjFrKi4UxJ5fFfc7dfD0kV1cj7RC62OFjYuQsDTak26WrG6qXghWZdz6nOf/BwBIDUJ8RqRrS7rcAjlnGmwArV8jgxtGg/ALz/5iWXmkjz54ckDakjiop8GriRglj6qGwrddvPGJDDXn8cj31sLa6B6W9MWUva0DWIVctv8ez0XChr5XzDC3Ku4XBntye8KtqiEEOz5noeF3HlvGC6utdX3aZ3eMKkvpPFHBFiqK3p/5iqNmPQS5fHWn4yAjmMeUCzvSw2VZivwMugd4/IuamPg1mPCd2u9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wWCvlr/vIZgRPqRSNrr79Zlrrfj4c4H/CeqlGicabHo=;
 b=ImifhsCbqNNOS+/vvOrxFq9rmMI7Tf0SgFfOOfgX4gJ1OkUSMxAfvFFx3Z19bIsuLbOjYzCmZOeNa74qd4+aB062bi+l2N4wMBZuty+0cre8jY2SFhkWQeYvubUM4yxVdu9aEjQCcgRDvKP40cZsJu310uBKfqp2ZWhEQnJmkXw=
Received: from CH2PR12MB4326.namprd12.prod.outlook.com (2603:10b6:610:af::11)
 by CH2PR12MB4133.namprd12.prod.outlook.com (2603:10b6:610:7a::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.24; Tue, 25 Aug
 2020 02:38:05 +0000
Received: from CH2PR12MB4326.namprd12.prod.outlook.com
 ([fe80::f564:86dc:de1a:63b7]) by CH2PR12MB4326.namprd12.prod.outlook.com
 ([fe80::f564:86dc:de1a:63b7%3]) with mapi id 15.20.3305.026; Tue, 25 Aug 2020
 02:38:05 +0000
From: "Chen, Jiansong (Simon)" <Jiansong.Chen@amd.com>
To: "Wang, Kevin(Yang)" <Kevin1.Wang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH v2] drm/amd/pm: fix is_dpm_running() run error on 32bit
 system
Thread-Topic: [PATCH v2] drm/amd/pm: fix is_dpm_running() run error on 32bit
 system
Thread-Index: AQHWehOZ82aK7Sj8x0CuvaxtLCH/TqlIHS6Q
Date: Tue, 25 Aug 2020 02:38:05 +0000
Message-ID: <CH2PR12MB43263495D01D1893960194DAEA570@CH2PR12MB4326.namprd12.prod.outlook.com>
References: <20200824124100.2151128-1-kevin1.wang@amd.com>
In-Reply-To: <20200824124100.2151128-1-kevin1.wang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=51ee7c50-f7c3-4313-b01b-4f10c4e0ad7d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-08-25T02:37:25Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: cad33869-7ab0-4fbd-35c6-08d8489fe53f
x-ms-traffictypediagnostic: CH2PR12MB4133:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR12MB41338D1B33DEFA72DB2749FBEA570@CH2PR12MB4133.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:923;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: v6CPino267JjRiadYo9yYghl8uhlI6jAcmRm8wRJ5zzWR0J79hfWaNNW2J3YpZKUwontz6YiUJO59feplVgBDLiGx5iLArI+Ifyt6aDdwmVR/gWyMwmoJCpEJOzKJf9tSX+BPWh+E99iNqvDPyMV69L/tkYtKmD6TRttDTu4UtBOQmf7mrBqd+9gzj3E1JcHrX0jKzlXo0E7KF53hdQBwJtrsKvw0wlVmNiqOro4EbmvB56GezSnwvNdWN9K8jXz8pSpv3Zqt8DdxUm8p+S1ePWx4F5xZZ35CmbsXofE+NorVRVFF2LyxV6i9cVjmG6lFhCEdus7vZYzJBZpeYsdxw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4326.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(376002)(39860400002)(136003)(396003)(346002)(2906002)(8676002)(86362001)(33656002)(26005)(186003)(53546011)(6506007)(54906003)(7696005)(83380400001)(52536014)(110136005)(8936002)(76116006)(66446008)(64756008)(66556008)(66476007)(66946007)(478600001)(71200400001)(4326008)(55016002)(5660300002)(316002)(9686003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: rxi+8WfI5CqBN3Wu3oS5YlCiUQG970u0h5fVezt2WD650XBT9poDorIjNs3yBy5K1U5XspFr4saSTEPix1n5qDbO5ZlGiXn8x4cenqciq1Kqagzzd0ofL2F9rT4qjDds9Wctapk6tF8Z1LtRdeYgVxnZ4LtG9Nfgl3HSbnuzkv8dQdSJFj4RtoFgIA3D+apnz9rGtJvXiGbEzDq2DE1PnQL//MNBi4gkPHlWJNMOEPJSZYcWR6oRA6+QSNAkP771LB/JnvdZo5DRi+Ksfu/Np/jUUpkb6OTa9wRCNjCUqGHukcoW0pBm6wxUIKDgg2e1n0x5GIdO6lwUzThe2nsYdQ63N/mhPAI/hr94p8T3LR8kltBqP0RdSk5ISI+Kh6c6ukvrYU6HlENooxzw9qKEyOQEOuBIk+KBa9uMKLmOFpu5EfQ3uRWpOc4d8bmsIP3rU8z+eSuYJpUJrdXIfHPa59mB0iIIbPh/7GVh9eZ3N7ZD9Nc5En3zyQpjehXUl2tXrvkZF5ZryiMMW3FG9vT+AI74O/Hyfvb+lW9nRMsm42tTMf8gBM4+IdRbYF5h6IPgoDpBIkX/J/n/lGXaI42maRGldeqnHHdfDzQpQ1uSABwpSV7q9InPNCakxRMTQGk4idbl0J9b2vu8TRSeli2lWg==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4326.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cad33869-7ab0-4fbd-35c6-08d8489fe53f
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2020 02:38:05.4755 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ES65/unoH0igx1HnjyAFKcSIaVenRH9/DYp1U4VPZX2vzQPCZ/YAax2Mea3Z2D0q1l/YCHqCoKKfKoDHstU2BQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4133
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Huang,
 Ray" <Ray.Huang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Reviewed-by: Jiansong Chen <Jiansong.Chen@amd.com>

-----Original Message-----
From: Wang, Kevin(Yang) <Kevin1.Wang@amd.com>
Sent: Monday, August 24, 2020 8:41 PM
To: amd-gfx@lists.freedesktop.org
Cc: Huang, Ray <Ray.Huang@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>; Chen, Jiansong (Simon) <Jiansong.Chen@amd.com>; Wang, Kevin(Yang) <Kevin1.Wang@amd.com>; Chen, Jiansong (Simon) <Jiansong.Chen@amd.com>
Subject: [PATCH v2] drm/amd/pm: fix is_dpm_running() run error on 32bit system

From: Kevin Wang <kevin1.wang@amd.com>

v1:
the C type "unsigned long" size is 32bit on 32bit system, it will cause code logic error, so replace it with "uint64_t".

v2:
remove duplicate cast operation.

Signed-off-by: Kevin <kevin1.wang@amd.com>
Suggest-by: Jiansong Chen <Jiansong.Chen@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c      | 10 +++++++---
 drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c        | 10 +++++++---
 .../gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c    | 10 +++++++---
 3 files changed, 21 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
index 8347b1f2509f..59b245c6c4d7 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
@@ -1844,10 +1844,14 @@ static bool arcturus_is_dpm_running(struct smu_context *smu)  {
 int ret = 0;
 uint32_t feature_mask[2];
-unsigned long feature_enabled;
+uint64_t feature_enabled;
+
 ret = smu_cmn_get_enabled_mask(smu, feature_mask, 2);
-feature_enabled = (unsigned long)((uint64_t)feature_mask[0] |
-   ((uint64_t)feature_mask[1] << 32));
+if (ret)
+return false;
+
+feature_enabled = (uint64_t)feature_mask[1] << 32 | feature_mask[0];
+
 return !!(feature_enabled & SMC_DPM_FEATURE);  }

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
index 72f3d68691d8..cc67d5c60f3d 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -1345,10 +1345,14 @@ static bool navi10_is_dpm_running(struct smu_context *smu)  {
 int ret = 0;
 uint32_t feature_mask[2];
-unsigned long feature_enabled;
+uint64_t feature_enabled;
+
 ret = smu_cmn_get_enabled_mask(smu, feature_mask, 2);
-feature_enabled = (unsigned long)((uint64_t)feature_mask[0] |
-   ((uint64_t)feature_mask[1] << 32));
+if (ret)
+return false;
+
+feature_enabled = (uint64_t)feature_mask[1] << 32 | feature_mask[0];
+
 return !!(feature_enabled & SMC_DPM_FEATURE);  }

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index 66d655958a78..b48ac591db8b 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -1150,10 +1150,14 @@ static bool sienna_cichlid_is_dpm_running(struct smu_context *smu)  {
 int ret = 0;
 uint32_t feature_mask[2];
-unsigned long feature_enabled;
+uint64_t feature_enabled;
+
 ret = smu_cmn_get_enabled_mask(smu, feature_mask, 2);
-feature_enabled = (unsigned long)((uint64_t)feature_mask[0] |
-   ((uint64_t)feature_mask[1] << 32));
+if (ret)
+return false;
+
+feature_enabled = (uint64_t)feature_mask[1] << 32 | feature_mask[0];
+
 return !!(feature_enabled & SMC_DPM_FEATURE);  }

--
2.27.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
