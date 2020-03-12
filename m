Return-Path: <SRS0=KrIT=45=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A97DC0044D
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Mar 2020 03:13:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 776DB2074E
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Mar 2020 03:13:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="FwymlkqY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 776DB2074E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BB6736E239;
	Thu, 12 Mar 2020 03:13:23 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2053.outbound.protection.outlook.com [40.107.92.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 499B56E239
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Mar 2020 03:13:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WkU+bBNsLVTDH2yK4vaPIC9ELEd6wT8r5zmMwMTqRE+vQgwrNO5L5pskJj6iQxgShjeBhpPDHrjSPGqEAhofzu1kzynXbfY2vm752quEvW/Wjf9clezZKuOLJ5Rijkq+GAyaR4QHOflIiutpcR8MIhyOad3KRCzx2PgJ2cJb+gDVttpDK65OTI51mk8fwxeJl0sW3Tg9Ead//SOcZqDA3X5n62vQ9cemNF3KxWhPh7OMC0FuGQ2OCGrBn9wGZavLbWrVHYHxG1MtA6JdYljr4AYlAw/yrqueodACsT81xh72MZYLequrrDPZjZLiznEYlzZ9RfGnTz1nToKtyWVU0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yNPB2Cfmt9ZflvQWrarPP2zoC3m2R0gfDJmvaTxhZiU=;
 b=AboJA80OxTLerHeweLY2JAneuLBCOYMRoY7XIiI9PYMGuP3lONebyQhcDgbXJMbBbRrVxVSw0RokhUHIphbgPwb0VXLoW8kEG4pE7mz9ZZvHrAdaf8nm936QszerG0Vxv1l6kE4czEsgZfEH6ySnoMKNIPYzTmh6m6C74EEsLNc9KkXIwHzUIwFYrnSeezp1uJ8R1JT4ywe/6SJh4WNOXeRFs1N29pGF1OtVfgjLBL4k6C3BbZwqCNas6zxNleTv+Pm7K4uJppPkRwHXkv/OLQqGrVOXojYI8gLvNXxNwmrkmfzVMSqX4o/22tOSEtSm1mu8OI6MtTI2fKVYWL97rA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yNPB2Cfmt9ZflvQWrarPP2zoC3m2R0gfDJmvaTxhZiU=;
 b=FwymlkqYfiM1zr5S+7rwNLMva2Z+ssyIqwPl4uplgNqWfog6AQysiMNefvGMP3A6r+t20BxAjUV7HScReN4qGSS7MOQJ8976q0BOaIKqu9fjz9Zz5SbUBxueGZbZXHhq55gr+nCoyFmlA3OB/cRaBr9PCf9jQxm4yF+bjxJtARY=
Received: from DM6PR12MB4075.namprd12.prod.outlook.com (2603:10b6:5:21d::8) by
 DM6PR12MB3737.namprd12.prod.outlook.com (2603:10b6:5:1c5::32) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2814.14; Thu, 12 Mar 2020 03:13:18 +0000
Received: from DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::796f:dc4e:4661:5273]) by DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::796f:dc4e:4661:5273%6]) with mapi id 15.20.2793.018; Thu, 12 Mar 2020
 03:13:18 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Chen, Guchun" <Guchun.Chen@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Li, Dennis" <Dennis.Li@amd.com>, "Zhou1,
 Tao" <Tao.Zhou1@amd.com>, "Clements, John" <John.Clements@amd.com>
Subject: RE: [PATCH 1/2] drm/amdgpu: update ras support capability with
 different sram ecc configuration
Thread-Topic: [PATCH 1/2] drm/amdgpu: update ras support capability with
 different sram ecc configuration
Thread-Index: AQHV+BmroLfLYZFOSECXmIz4qCDbEahERaSA
Date: Thu, 12 Mar 2020 03:13:17 +0000
Message-ID: <DM6PR12MB4075F2DB3C332761746AA69EFCFD0@DM6PR12MB4075.namprd12.prod.outlook.com>
References: <20200312025447.21000-1-guchun.chen@amd.com>
In-Reply-To: <20200312025447.21000-1-guchun.chen@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-03-12T03:13:15Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=5203a4b6-4f78-4c2f-ab86-0000ed58d7f5;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-03-12T03:13:15Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: eb2c3c72-2db8-427a-8b7e-000010e92af3
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Hawking.Zhang@amd.com; 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 24f4334f-b555-452c-7f86-08d7c6334fd3
x-ms-traffictypediagnostic: DM6PR12MB3737:|DM6PR12MB3737:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB37374226E7F6F93D9BF29756FCFD0@DM6PR12MB3737.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0340850FCD
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(136003)(39860400002)(376002)(346002)(366004)(199004)(110136005)(81156014)(7696005)(5660300002)(15650500001)(81166006)(8936002)(52536014)(478600001)(64756008)(86362001)(66446008)(66556008)(66476007)(66946007)(76116006)(8676002)(71200400001)(316002)(6636002)(6506007)(2906002)(33656002)(26005)(55016002)(9686003)(186003)(53546011);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB3737;
 H:DM6PR12MB4075.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: I6V52odbqv3gD1Oy9V1xfAzPXrmcIIUratsH1xQR9+o2kq6DOnkA5o7giLv9EcoSmSQls/aGkLvp7eZQ16xwkA7/fl5iwHdpOtUg+lGNzbwZG6qtMot4+fSOWxIDNwBeuWKHMneX8fEYBfjo1oOrkw5LthQ2IRBBwaOOtPebdJJPvddgP0PD8gC83oVLN0qpz0pwXGQ0ibPTtNWmPBa6JvF0HQffKtYbk4ASYP4J3oYx70F/2MMAmI9nO04WmenhzXS51cJDhdvBigdIkDzPHDOBwpQcu7FUumcAFzOHSVYFL8z3wTTNQpcGsWpUtJbrdxk36yixJhx5paRC2b1/VHnlYOBJ4SScRaqZhew/1IZDEaVBnJTJ+iUiGeUNcww/JH47r9pRhlg10puTJY1Cse9YVOapYlLiCH2cCjtP0NoQPerW381WWxo4JywEL1kZ
x-ms-exchange-antispam-messagedata: Wa5qKwfkKDUSh+FbXw9zEM+gIKExs5qPc8cn2+VqTXyGv3v0eX9Q1pAfccboHLAXZGq1iI/uSFSnQjTcZbV3HTy8VFeJX9LJAZMjRr6t4jhDW+A1kQ0jLgcInjkGOm8USSCZGXoe32L5YyysrdXhaw==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24f4334f-b555-452c-7f86-08d7c6334fd3
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2020 03:13:18.0121 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: x8tbaxauGeivaXxJBgRfRc5awdZKg0OohS8bZ+0KOTGbW1HMf1mqQ4kJdFlp82D3heQIm/hsoLj1/CBDDTc3vA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3737
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

Hi Guchun,

It seems to me we still have redundant function call in amdgpu_ras_check_supported. The atomfirmware interfaces are possibly invoked twice?

As I listed the steps in last thread, we can assume hw_supported to 0 or 0xfffffff either. 

Check HBM ECC first, explicitly indicates it is present or not, and set the DF/UMC bit in hw_supported
Check SRAM ECC, explicitly indicates It is present or not, and set other ip blocks masks.

After we run all above checks, set the finally ras mask to con->supported.

We'd better keep the message consistent as what we had in gmc_v9_0_late. No need to highlight the what IP block get disabled, that should be transparent to users.

Regards,
Hawking

-----Original Message-----
From: Chen, Guchun <Guchun.Chen@amd.com> 
Sent: Thursday, March 12, 2020 10:55
To: amd-gfx@lists.freedesktop.org; Zhang, Hawking <Hawking.Zhang@amd.com>; Li, Dennis <Dennis.Li@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>; Clements, John <John.Clements@amd.com>
Cc: Chen, Guchun <Guchun.Chen@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: update ras support capability with different sram ecc configuration

When sram ecc is disabled by vbios, ras initialization process in the corrresponding IPs that suppport sram ecc needs to be skipped. So update ras support capability accordingly on top of this configuration. This capability will block further ras operations to the unsupported IPs.

v2: check HBM ECC enablement and set ras mask accordingly.

Signed-off-by: Guchun Chen <guchun.chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 37 +++++++++++++++++++++++--
 1 file changed, 35 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 69b02b9d4131..b08226c10d95 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1748,8 +1748,41 @@ static void amdgpu_ras_check_supported (struct amdgpu_device *adev,
 			 amdgpu_atomfirmware_sram_ecc_supported(adev)))
 		*hw_supported = AMDGPU_RAS_BLOCK_MASK;
 
-	*supported = amdgpu_ras_enable == 0 ?
-				0 : *hw_supported & amdgpu_ras_mask;
+	/* Both HBM and SRAM ECC are disabled in vbios. */
+	if (*hw_supported == 0) {
+		DRM_INFO("RAS HW support is disabled as HBM"
+			" and SRAM ECC are not presented.\n");
+		return;
+	}
+
+	if (amdgpu_ras_enable) {
+		*supported = *hw_supported;
+
+		/*
+		 * When HBM ECC is disabled in vbios, remove
+		 * UMC's and DF's ras support.
+		 */
+		if (!amdgpu_atomfirmware_mem_ecc_supported(adev)) {
+			DRM_INFO("HBM ECC is disabled and "
+					"remove UMC and DF ras support.\n");
+			*supported &= ~(1 << AMDGPU_RAS_BLOCK__UMC |
+					1 << AMDGPU_RAS_BLOCK__DF);
+		}
+
+		/*
+		 * When sram ecc is disabled in vbios, bypass those IP
+		 * blocks that support sram ecc, and only hold UMC and DF.
+		 */
+		if (!amdgpu_atomfirmware_sram_ecc_supported(adev)) {
+			DRM_INFO("SRAM ECC is disabled and remove ras support "
+					"from IPs that support sram ecc.\n");
+			*supported &= (1 << AMDGPU_RAS_BLOCK__UMC |
+					1 << AMDGPU_RAS_BLOCK__DF);
+		}
+
+		/* ras support needs to align with module parmeter */
+		*supported &= amdgpu_ras_mask;
+	}
 }
 
 int amdgpu_ras_init(struct amdgpu_device *adev)
--
2.17.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
