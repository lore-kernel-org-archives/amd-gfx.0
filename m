Return-Path: <SRS0=3ay0=CF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95DDEC433E1
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Aug 2020 05:12:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 640622080C
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Aug 2020 05:12:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="oLV8glWy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 640622080C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2BB896E22D;
	Thu, 27 Aug 2020 05:12:26 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2075.outbound.protection.outlook.com [40.107.236.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2B0D86E22D
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Aug 2020 05:12:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=StbsGiyVbXvvieNO5N/cf1d/2j0Uhpy7XS7DR7DXYnnfp4ZE5E1k/MzUs2nIyMYuuzoPPVwEwbue6I/fUx9uA2Q5sWI7RL0PLRwUXcscOavAsB80YoZHXZbzOIdTdrmlRm9gd2Fz7YTDUsMfOoz6TEnozcWBMoAUQG0i0g6PocRQwkQIUYH1PLr6aHLo2J2oE2ogRULie8IpR4ftEkLEBCO/wxbyTh+DtH+/Cg+B6phKk5uJ8NknV0IFrgiEn8HYMcA6feiC3gdY2B3/RZeZKY3JCsCuvTzxgPjdoT3Fi1nCUKgcHtbEt0pjB3n59Oo7pVHxnUylu6K+zc9uBd/MfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P3828+ZMfAIJCN5lt7lfWkL23Nw7hn0+dYY6CxvtZxk=;
 b=S/OT982TrcBm3p1nReCJmHnvvep9RtXhAaBPLkuX/Sq0jj0kIwNdpEOWFTZwi30PyjL8U7wWU6EmuWXG9XhoQA495hBZvPluHezMY4s1ieVnX/wv058YGDun4Mf4QN4U86mLK7s5zEA1PLYoAIKHgOSLW1FOYFOYmDkX9zE/8nePGZdLpqU/zjYsHDBqIQX5Sd4rueGRjhbtCRK4uJrSCOFzJL8vvpxPuT49tngDxn8eIfothksWDlwXspCr0guQpy/zn+BVjtriEl8dG5VNIIYwqjoBNlTrv6V7TU2hsKWpGvhUEkwiY7KJHuqcNYyNF0A+iAp04crny0xhmW0qMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P3828+ZMfAIJCN5lt7lfWkL23Nw7hn0+dYY6CxvtZxk=;
 b=oLV8glWy35m1EYSkoFujCKBWG11NemZlO1jGmxrEj4jchl7GX+yu612m8Rnq6eCB2wU+OneCpnS+1ycEqg02jf2iluRx5Jo5ur55QoD+MjWZoLD8itvYtz2RZo4zh3aURVZfT/R2UVRv/t7F3bu3fgaURyViFkt6jKslNjH6geI=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB3466.namprd12.prod.outlook.com (2603:10b6:5:3b::33) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3305.24; Thu, 27 Aug 2020 05:12:23 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::bcb1:de80:f60c:8118]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::bcb1:de80:f60c:8118%5]) with mapi id 15.20.3305.026; Thu, 27 Aug 2020
 05:12:23 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/4] drm/amd/pm: drop unnecessary smu_baco->mutex lock
 protections(V2)
Thread-Topic: [PATCH 2/4] drm/amd/pm: drop unnecessary smu_baco->mutex lock
 protections(V2)
Thread-Index: AQHWerRPN4Pcaa1V9UWTgWHo5KQioalLa9kA
Date: Thu, 27 Aug 2020 05:12:23 +0000
Message-ID: <DM6PR12MB2619BF25B061B86575C9D6DFE4550@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20200825074923.32345-1-evan.quan@amd.com>
 <20200825074923.32345-2-evan.quan@amd.com>
In-Reply-To: <20200825074923.32345-2-evan.quan@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=5e4a0396-4a9f-4ba5-a0be-6591927969ab;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-08-27T05:12:16Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 11de6c61-422e-42b2-7af0-08d84a47c83a
x-ms-traffictypediagnostic: DM6PR12MB3466:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB346651D3021C73D23DD5F230E4550@DM6PR12MB3466.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:626;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Vep63Li1KnlLCkILHZbGw10W2at1ELbwmC1JFrBjQwOmEZ5lUFP8SVoG3Y/MfZggfefia9j/+tJ+WCGRPVH9g0DXj0IS2+bU+3brl6LRla3j06ZrZvQYAL2COjLgt2kAzYegB63zFYc+JeUl7RgGPKLQs6eEq6qmj1kwRKwvyFhUMrvbJoq/msuiZXFw4f7Mb0MnG8fP+QrIYhyNnunGpVbSA/wt/epBidOaDkfO4o9yugPRAEy0TuFApUb+2Uq4waEyOZDYLoUoRdKQeVElx8sBkUkWgMHQ2W51Gd44kDU8rYn7V99bBNXgbauR7I9u
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(346002)(39860400002)(396003)(136003)(376002)(53546011)(316002)(6506007)(8676002)(4326008)(71200400001)(478600001)(9686003)(8936002)(76116006)(6916009)(52536014)(26005)(86362001)(5660300002)(66946007)(186003)(2906002)(33656002)(64756008)(66476007)(55016002)(66446008)(66556008)(7696005)(83380400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: Q1i4j/N/Y9jJp1ZxLCLwkL00rESSX13mUHUrNeUnXg/H7wtOuXYrbst6MdA24XJP5Zcua1RgqJ4odp8EmgfmNe4fJkPhvr2fZ1Rz9Wp04muFw+KHfASiodr7BIMJ5hF+adwRi9VZBxA3EhHNBrei6HQQkbvfcns/y31vRd9gEXLJfMZaIV5WnVRnrbUd4vuVU5tUne+aB3J35NrcCHs1e3Izrlce3Gu9gSsrSf7eDRlCI6snBzTUOeaQPWj/eFqwTlRki3gMf4EqyPW4PZ229ce1hlWdGfwaN+KKgXI/rxDJlu7BK4Oqv22pEScggcjUKGGZWWL/RlZaI5CI6lQb3nDUnEBaSAf39LL99JvOr18EjblZfEqnMExCXHCz8KxzfxeopHftQlYaMDHCXDY3zOWb2AMEgJfnLkB0qY4zTFFjqZnidKWzxs9RiGMyL3EdCfM30TJfR+oxDQk8ZeR2ekoq97A6qga7zbFM3g5pnSuUNCYVIHAI3YcRonqJC+HQyeDhrXLl0UVXzov0QMmKMR7RvhNB/X5O4ozHq+JfSS4E/1T4ouwjEbOHbYMWCLA6fhj6iQmlmGDc+EfPKG3/dAxaQVhJxftbK8dJL8gkcc1USvlEfP51xS0zZaDVEkE0gl3Zrx/6DnrGdfEdlTj+Ug==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11de6c61-422e-42b2-7af0-08d84a47c83a
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Aug 2020 05:12:23.4944 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sDKCmcNKKaTZreXtTBRkiHs/MqTD587vc1yNM/jdhb8+w4Jf6mb+i4O1azfsHqRJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3466
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

Ping..

-----Original Message-----
From: Quan, Evan <Evan.Quan@amd.com>
Sent: Tuesday, August 25, 2020 3:49 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Quan, Evan <Evan.Quan@amd.com>
Subject: [PATCH 2/4] drm/amd/pm: drop unnecessary smu_baco->mutex lock protections(V2)

As these operations are performed in hardware setup and there is actually no race conditions during this period considering:
1. the hardware setup is serial and cannnot be in parallel 2. all other operations can be performed only after hardware
   setup complete.

V2: rich the commit log description

Change-Id: I7078ac26ae71eb6c7cbf918a127adfc2f56acf7d
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c       | 2 --
 drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c         | 2 --
 drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c | 2 --
 drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c          | 7 +------
 4 files changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
index 8347b1f2509f..4195b5b9e8e5 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
@@ -386,11 +386,9 @@ static int arcturus_check_powerplay_table(struct smu_context *smu)
 table_context->power_play_table;
 struct smu_baco_context *smu_baco = &smu->smu_baco;

-mutex_lock(&smu_baco->mutex);
 if (powerplay_table->platform_caps & SMU_11_0_PP_PLATFORM_CAP_BACO ||
     powerplay_table->platform_caps & SMU_11_0_PP_PLATFORM_CAP_MACO)
 smu_baco->platform_support = true;
-mutex_unlock(&smu_baco->mutex);

 table_context->thermal_controller_type =
 powerplay_table->thermal_controller_type;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
index 72f3d68691d8..f4b26399b413 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -347,11 +347,9 @@ static int navi10_check_powerplay_table(struct smu_context *smu)
 if (powerplay_table->platform_caps & SMU_11_0_PP_PLATFORM_CAP_HARDWAREDC)
 smu->dc_controlled_by_gpio = true;

-mutex_lock(&smu_baco->mutex);
 if (powerplay_table->platform_caps & SMU_11_0_PP_PLATFORM_CAP_BACO ||
     powerplay_table->platform_caps & SMU_11_0_PP_PLATFORM_CAP_MACO)
 smu_baco->platform_support = true;
-mutex_unlock(&smu_baco->mutex);

 table_context->thermal_controller_type =
 powerplay_table->thermal_controller_type;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index 66d655958a78..c19f526c5a22 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -296,11 +296,9 @@ static int sienna_cichlid_check_powerplay_table(struct smu_context *smu)
 table_context->power_play_table;
 struct smu_baco_context *smu_baco = &smu->smu_baco;

-mutex_lock(&smu_baco->mutex);
 if (powerplay_table->platform_caps & SMU_11_0_7_PP_PLATFORM_CAP_BACO ||
     powerplay_table->platform_caps & SMU_11_0_7_PP_PLATFORM_CAP_MACO)
 smu_baco->platform_support = true;
-mutex_unlock(&smu_baco->mutex);

 table_context->thermal_controller_type =
 powerplay_table->thermal_controller_type;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
index 28a19ffd22a1..005673bedc2f 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
@@ -1434,13 +1434,8 @@ static int smu_v11_0_baco_set_armd3_sequence(struct smu_context *smu, enum smu_v  bool smu_v11_0_baco_is_support(struct smu_context *smu)  {
 struct smu_baco_context *smu_baco = &smu->smu_baco;
-bool baco_support;

-mutex_lock(&smu_baco->mutex);
-baco_support = smu_baco->platform_support;
-mutex_unlock(&smu_baco->mutex);
-
-if (!baco_support)
+if (!smu_baco->platform_support)
 return false;

 /* Arcturus does not support this bit mask */
--
2.28.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
