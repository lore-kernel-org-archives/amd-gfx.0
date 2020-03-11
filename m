Return-Path: <SRS0=Izb8=44=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2EC5C10DCE
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Mar 2020 01:57:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 450BC21655
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Mar 2020 01:57:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="yjcN+I4v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 450BC21655
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 21C6A6E3F3;
	Wed, 11 Mar 2020 01:57:36 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2079.outbound.protection.outlook.com [40.107.243.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 942F26E3F3
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Mar 2020 01:57:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=enTft2mgpu3XqsVGSsn4+UZFvWHhszMBPe97oX/OukHD+X9yqT1Od7lK7NhIhnKsjHvnt9du0lj0mQzpTaKPwLnkXweH/rc2BiMPqwLf5jbIJdV+UcVpzWRe/nL2s2FO2XQsBHnxVGXdIPx4bOxSYL29Yal2X2L0/jFAExfnbOHCP0z6pzdov20iUt+NRv4pFcpOAffW8BiVm0GIWOs3DSGzyT+kxKu0j6iyZAZfLKZD1T+qRVxgdZwTByI1VlYQMoM9c3+1vPAOXGdzWubf/looSvPFHw67lLxDfk63rhhYattH1iIBGy7zoV2jYNjynGO8RGy5K9QQdIen+2UtcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GvWH4asQ7KaCrBI39+7cBudtf+QdWi1Cgmj5KtEyjss=;
 b=LdjRvuXoPMHI82+iyM3oAFOCVzkMdZFuT5tMYE9ZyZ4WzAx0ejbCmOYLc67OnECJzf+x4ys9Uizj48RJoy3BJsriXrxrLsidX92voE2mG4xql/EQK7jXnSPOFUo87M9YYoltTkkhlLHgfTrOYGS+JuZxotmF8aXdVFaXoaxRJIcJtukqmFhau+QeJlngvxcMMbQyBnf1b4OvpLpuD3672fSZWltbz3Sesd+LCmAJk3LgBBurIpeEToLQZ1neie6IOrBAMCxgj3GuyPmjpxkcevpMIaq2ZSQdqNpV7oXjlFFWkLU60GyqpWyLJNls8aGlcqVyBwrd7zX4zOVIB0q1pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GvWH4asQ7KaCrBI39+7cBudtf+QdWi1Cgmj5KtEyjss=;
 b=yjcN+I4v63jpi+ueJm47mpDOjt7QzgPvwmni9BefgDFDDFrrWPML5OnxQwXOIaeZw3osj1NB0fQhE/RlUkZF5qrVqeUG4iyeugQA5kUaUIweilWvLtu0cd9ZcpFr4mOABGKsSDK0S9C8RGUIMpaaJ9w2TMHB6loqllVfv9eQLrI=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Guchun.Chen@amd.com; 
Received: from BYAPR12MB2806.namprd12.prod.outlook.com (2603:10b6:a03:70::20)
 by BYAPR12MB3221.namprd12.prod.outlook.com (2603:10b6:a03:135::29)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.17; Wed, 11 Mar
 2020 01:57:32 +0000
Received: from BYAPR12MB2806.namprd12.prod.outlook.com
 ([fe80::5034:d0dc:246d:399f]) by BYAPR12MB2806.namprd12.prod.outlook.com
 ([fe80::5034:d0dc:246d:399f%7]) with mapi id 15.20.2793.013; Wed, 11 Mar 2020
 01:57:32 +0000
From: Guchun Chen <guchun.chen@amd.com>
To: amd-gfx@lists.freedesktop.org, Hawking.Zhang@amd.com, Dennis.Li@amd.com,
 Tao.Zhou1@amd.com, John.Clements@amd.com
Subject: [PATCH] drm/amdgpu: update ras support capability with different sram
 ecc configuration
Date: Wed, 11 Mar 2020 09:57:13 +0800
Message-Id: <20200311015713.23363-1-guchun.chen@amd.com>
X-Mailer: git-send-email 2.17.1
X-ClientProxiedBy: HK0PR03CA0099.apcprd03.prod.outlook.com
 (2603:1096:203:b0::15) To BYAPR12MB2806.namprd12.prod.outlook.com
 (2603:10b6:a03:70::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from guchchen-System-Product-Name.amd.com (180.167.199.189) by
 HK0PR03CA0099.apcprd03.prod.outlook.com (2603:1096:203:b0::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2793.15 via Frontend Transport; Wed, 11 Mar 2020 01:57:30 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [180.167.199.189]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: fa8fadad-b470-4ba7-6541-08d7c55f8fd3
X-MS-TrafficTypeDiagnostic: BYAPR12MB3221:|BYAPR12MB3221:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB32211742BC5C8CDD86408682F1FC0@BYAPR12MB3221.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 0339F89554
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(39860400002)(346002)(376002)(136003)(396003)(199004)(6486002)(6636002)(316002)(66476007)(66556008)(7696005)(52116002)(4326008)(186003)(6666004)(36756003)(16526019)(66946007)(15650500001)(26005)(956004)(1076003)(44832011)(2906002)(81166006)(81156014)(478600001)(8936002)(5660300002)(8676002)(2616005)(86362001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BYAPR12MB3221;
 H:BYAPR12MB2806.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: U7/Uk+yyLZPk78b8Q7buCDZCGjEoj8gOzczb2HgNg4a+cOurq0t1EmnZcfqR1EsRrMJsERrkjrhI18TXJSrScfQvr0oEgiVlg/eGke35uHMsQajycl1vDASb/1INlQryQYSSW/gMoe54iFnn8utRnNzX1RVnElIgMhuHBsnqbmHBolg5UpTMr1PGRGqn6/z8gYGkbHqvrK/AcMMl1pU5hObk49U03KVWacwSpqP0HA5dFrdRQb0hegsruG3NMzOgO6EcwcbOAvl6XlXn+qvnDyIF8c5IBjJahgfSNXC084JLsBLod7GKAVNf8GqzT9cCmetVoLHaD5dtdj2W/HhWV/aqn+3m6+bElt4lk6ONwee0lK6mqvLQRQCGnDsUgC0w08x6l1yMmVXUHumJRA2+DZpw7SKg3bsDLGY5zYktSIOLM6zZ0DvdqXdChqxIzq8w
X-MS-Exchange-AntiSpam-MessageData: 0IEwgv5LhPa3HH5a9C+E4Jv9iINH/FQ0kuU4ZWf2XwV6kKtVhWgKSF86icizlyVrfzbV4C6pYXm3cWgWKu6sFMcTWl811b2Ldtnu78TXs6kDj/3cmGfqsyzQJ1p/1Xjxd9B7wKdvvRu0HLRbq4vEkg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa8fadad-b470-4ba7-6541-08d7c55f8fd3
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2020 01:57:32.5013 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kcpsyekRJHN2Jg6Uly5NXrxiB+otvcktXLD/E6QgUeNoBN274rxHE3Jhsp+wMJ4NyZ5aDy/DgneljVkWE8y8wA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3221
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
Cc: Guchun Chen <guchun.chen@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

When sram ecc is disabled by vbios, ras initialization
process in the corrresponding IPs that suppport sram ecc
needs to be skipped. So update ras support capability
accordingly on top of this configuration. This capability
will block further ras operations to the unsupported IPs.

Signed-off-by: Guchun Chen <guchun.chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 69b02b9d4131..79be004378fa 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1748,8 +1748,23 @@ static void amdgpu_ras_check_supported(struct amdgpu_device *adev,
 			 amdgpu_atomfirmware_sram_ecc_supported(adev)))
 		*hw_supported = AMDGPU_RAS_BLOCK_MASK;
 
-	*supported = amdgpu_ras_enable == 0 ?
-				0 : *hw_supported & amdgpu_ras_mask;
+	if (amdgpu_ras_enable == 0)
+		*supported = 0;
+	else {
+		*supported = *hw_supported;
+		/*
+		 * When sram ecc is disabled in vbios, bypass those IP
+		 * blocks that support sram ecc, and only hold UMC and DF.
+		 */
+		if (!amdgpu_atomfirmware_sram_ecc_supported(adev)) {
+			DRM_INFO("Bypass IPs that support sram ecc.\n");
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
