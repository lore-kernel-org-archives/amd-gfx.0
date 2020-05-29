Return-Path: <SRS0=sMqH=7L=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0BE0C433E1
	for <amd-gfx@archiver.kernel.org>; Fri, 29 May 2020 02:59:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 83C3320814
	for <amd-gfx@archiver.kernel.org>; Fri, 29 May 2020 02:59:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="des+wo7p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83C3320814
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F2476E235;
	Fri, 29 May 2020 02:59:37 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2073.outbound.protection.outlook.com [40.107.237.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6DB206E235
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 May 2020 02:59:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mihcGBVqVOhAl9ACihCDwLgdyrSV/U3rhdL3D/OrK5FLR/KlkWH2567W29NNaopdokjJHvfu2aB1WFH+Qou04pABedcd1awXalcIgfa3+OvG8q38s1IORt8/oVkWb4Gf2qNwu3vSzhQAI7f+8RCjaKbDJO19qTLfBxua4WNZqPMTeNRCGVRMMsRn8N7b/Ak0lU5Ed4ntk7Tk8E8fMEGRAYQ3V3oqBFfBmhYNvs+0GGIbpBtUrj925vx+wHw9fHgi9NJ0o/6zvFmpyruC+2aWiqRr/1xui1dtAOtnRj8Pgih1XZ7VQ8MOs9wmtMjvULqWmRFLayVrE7xgh8ITsjWZ5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u7xx1YaxQPctHUSSF8XnM5PnT2KAt2cmCw8RQmaeP44=;
 b=J1mGlPzN/6PgWsVOIVqZKCp7lUaZAnm0rWMLBlLIMNde4kKJY7dl9yAEpe1SVdngMNAbIeuZ1RvZXjL2LrNc0lM32jVTKgcy5SpqhzunFIQCAdY5eueSjQMg4QK6ZZFFERjmt2i+q74o/lQOhotx6x41iTLqzemGnVWEjAAZ5Bga6qNbiHH/V8rs3Ju6n1grkyhTV9bPT51NXNjwIkvFJ9KRnrNHATwtBNHbC75xyASfuHSaXUO/ey+QQs6aD8mHTZ2/pGyTURR+w6QFzYFMTsBMtLLpZrFcJBxYz61PqQ144/RgU0L2ZjG4Ufh94ix72o8BBu3CRCGJDoyminoUdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u7xx1YaxQPctHUSSF8XnM5PnT2KAt2cmCw8RQmaeP44=;
 b=des+wo7pgDT3B4Z1cR4YvUoRb7Uq9ISHGTt8aRIb1LZUOrxQfCB65u7J49q4jRQTLIrA2qRjHuoQDYsSi+5NddDKUtxyQEa+S2WT+SgaFB8ityj7ildfdZR40QlKxWME6ahI9Qa4zEU2hathcJnOg5xLs3EieFXMJwS6/FUUkgY=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB4450.namprd12.prod.outlook.com (2603:10b6:5:28e::18) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3045.19; Fri, 29 May 2020 02:59:32 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f%3]) with mapi id 15.20.3021.030; Fri, 29 May 2020
 02:59:32 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu/fru: fix header guard and include header
Thread-Topic: [PATCH] drm/amdgpu/fru: fix header guard and include header
Thread-Index: AQHWNPYws32RLwHmZ0iroGRnpdYtbai+YGYA
Date: Fri, 29 May 2020 02:59:32 +0000
Message-ID: <DM6PR12MB261957D22ED45EB8FFD50ACCE48F0@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20200528134445.246773-1-alexander.deucher@amd.com>
In-Reply-To: <20200528134445.246773-1-alexander.deucher@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=678631d5-ee31-470a-bca6-000096082afd;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-05-29T02:59:26Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 64f6a386-8d05-4f0f-471c-08d8037c5005
x-ms-traffictypediagnostic: DM6PR12MB4450:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB44508F562C3A597D9457F5E8E48F0@DM6PR12MB4450.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 04180B6720
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UPOZEpyA4EfqsT8fgLyBAmPlW/eEyjuO3OAaA8XYlf3OgNcebqpF3yTt3bgAosZDJ/1+4Xwmh7FsPzS41nLN7igCnJyVomAifTtvmPQdgTNq+OxPmdl0J5gCpsXfdzLPiU9XQHhbJAJJglVd312vWrjgL+syzbyBPm+OGhI0vQLt52BJWsEs4YlZWSw00FsKocBsFtP2749dtqbnfD++LMkdTNRfUpF7N2BF54iKd9VfM+Sl4y8m/+w0UzyfC8GEAVLdAH4YmtKw2J+BfLBHjrkS45aNB400f99DHL7b/fBcKO+3VkqVErgXqMz3AgPYSpua8tmAoz4T22XLKQWKOyPvFR8AD46K0MpPjpX/KZA=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(346002)(376002)(136003)(396003)(39860400002)(83380400001)(5660300002)(33656002)(9686003)(55016002)(26005)(71200400001)(66476007)(64756008)(76116006)(66556008)(52536014)(186003)(66946007)(66446008)(110136005)(8936002)(4326008)(53546011)(6506007)(7696005)(86362001)(316002)(2906002)(45080400002)(478600001)(966005)(8676002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: AGx3hXxQyhhjixTg2y0ic5wNP+qSElqsKRmStfy3hJIyqwJJPbj0pec6+yMPKJacWN09pYyKPIcwaE4LVjsIURorRK67ljKfCXHqqXdxUps9cNxNd7E0Tmu27Z+jszXYIRI2uScNPMbeKnIW4McCY8dZJdyYj0duBIFQd13jPXCZW828dWsokEKinu+s+o86wBryrFVair2KCwFu/S29U25HSaiP9hAsf4xjZvVCtOhqvhy1j/tldENilVb25wNG3wqoqYQu75QEjddTaM5nD54IUlVZq9WUuBvdNmsOkCmr/mJB5UnhnwXi2/j8Zlqz/D59/N10HvZpNVlpwfhl2A3xxP7Ni33QgJ5gtT/L/V9aYkC8AN5WeKF3lHVdrcByKCsJvnA1XCWVxS94VdYnPsAQd7Va6YgUhKypWDJJyhWJn1UO9zrrtrPkRrLyOkcwLaaUnZAB5VirIXI17yyjxibPM/+I12qYHRNZSON6R8BshvrhsLSR3fsFOCtBjOkv
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64f6a386-8d05-4f0f-471c-08d8037c5005
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2020 02:59:32.4717 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ufsxg/8ful3+mJ3E70eYB4LUQd4rTW+6/KOpuuDisXyYAECgd+r6cBFLvMaTOKGL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4450
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

Reviewed-by: Evan Quan <evan.quan@amd.com>

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deucher
Sent: Thursday, May 28, 2020 9:45 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: [PATCH] drm/amdgpu/fru: fix header guard and include header

Fix the fru eeprom header guard and include it in the .c file.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c | 1 +  drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.h | 4 ++--
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
index 815c072ac4da..6ae80b33182c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
@@ -26,6 +26,7 @@
 #include "amdgpu_i2c.h"
 #include "smu_v11_0_i2c.h"
 #include "atom.h"
+#include "amdgpu_fru_eeprom.h"

 #define I2C_PRODUCT_INFO_ADDR0xAC
 #define I2C_PRODUCT_INFO_ADDR_SIZE0x2
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.h
index 968115c97e33..f29a8611d69b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.h
@@ -21,8 +21,8 @@
  *
  */

-#ifndef __AMDGPU_PRODINFO_H__
-#define __AMDGPU_PRODINFO_H__
+#ifndef __AMDGPU_FRU_EEPROM_H__
+#define __AMDGPU_FRU_EEPROM_H__

 int amdgpu_fru_get_product_info(struct amdgpu_device *adev);

--
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Cevan.quan%40amd.com%7Cb5ab699c12e54a474a9708d8030d4f59%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637262703031199462&amp;sdata=gZqz%2FC9%2FFxdj6Cowb72g6RqjsI4L9kxIsyOwVPlS2kA%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
