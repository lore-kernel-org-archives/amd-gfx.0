Return-Path: <SRS0=l0jK=2O=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5776C2D0CF
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Dec 2019 06:33:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 757AB206CB
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Dec 2019 06:33:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ZxwKM63d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 757AB206CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 01F8E6E0A1;
	Tue, 24 Dec 2019 06:33:45 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2064.outbound.protection.outlook.com [40.107.92.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3FD0F6E0A1
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Dec 2019 06:33:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LwYEUSQ4+qGt2KE2FO5z6u3NW2dc3DR5qWtmgfEU2eQdKEsp+OnJQm5r+vodEmdqMNkid8+8j0b+FgV2OGCY9jCben6cSTWYzlGIXBVlPedTa8wjVxmsmUm67eRDs52NmWJXI3oYJruok+ooCEa7HzSCz7ktDuo/i+/eRGWEOBKAH+5JOzIkT/kk9/SztglhgIcOQz0eOROiHECG2Dj/K7ixIW9SHkMgPf2//FvqYfXoJ/RV4Z/scGbdCGaBmXzV2cVKa45Q7RpCrmFSUSnP8UP8+54FPJsLEPV+tZSLkU3x53keGLRmUB5LAg0Ry/s0rEPt+Os9YgsoXwnMVODXYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Vh2NbOkZztGJCbAQsdA+afFMmaK8Oz5Ea6F/Fb09+s=;
 b=KtI4XC6dnO59RPY/sQpxeovGbRIdCqtF2nJRwrpC+4kigIORjvfwRxFK8iAnJt9vyJ44Qy53rWQEIGJa9tpRvcWMYmJPmcUYVC1DwEIoazPZcLQIF629wfYen+5xMhVccw3bairR1arYlnAS1FPW6L0lNZPE8Cloagi6FKZ0G2E1Pq4taMKIfK6xIq61Pb7p/5v7bZz2RDBG+9Y8BeD48mM2yFDTOuvH0GkGebjiUEdZTDATinhNDw+Hi0BX0m1VdBdm7vaCPt6isymTiC8cOen3pXYzBRcd7Tn6pnis6Z1kxw4zHgi6rFEDKy5Eh6f+MfLV6DU2Izp+KfOc+jwMEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Vh2NbOkZztGJCbAQsdA+afFMmaK8Oz5Ea6F/Fb09+s=;
 b=ZxwKM63dzirD96SK8cokqv3cMEfWePvbQvpZLVe9UIP5BNxOso8PYaE8bDpUReKrR4/4mys3//9ebMuyWs7YJAnf6SvQts9yra7JKtC4aZ74oN5vSo1sMrBL2O9D15mqeYazbHrXRRw1LSCv57HKknbldmmguSVBxs7Ncm4GHrA=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Guchun.Chen@amd.com; 
Received: from BYAPR12MB2806.namprd12.prod.outlook.com (20.176.254.20) by
 BYAPR12MB3127.namprd12.prod.outlook.com (20.178.53.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2559.17; Tue, 24 Dec 2019 06:33:40 +0000
Received: from BYAPR12MB2806.namprd12.prod.outlook.com
 ([fe80::bccf:40ec:3b93:4269]) by BYAPR12MB2806.namprd12.prod.outlook.com
 ([fe80::bccf:40ec:3b93:4269%6]) with mapi id 15.20.2559.017; Tue, 24 Dec 2019
 06:33:40 +0000
From: Guchun Chen <guchun.chen@amd.com>
To: tao.zhou1@amd.com, Hawking.Zhang@amd.com, Le.Ma@amd.com,
 amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: simplify function return logic
Date: Tue, 24 Dec 2019 14:33:21 +0800
Message-Id: <20191224063321.4359-1-guchun.chen@amd.com>
X-Mailer: git-send-email 2.17.1
X-ClientProxiedBy: HK2PR02CA0211.apcprd02.prod.outlook.com
 (2603:1096:201:20::23) To BYAPR12MB2806.namprd12.prod.outlook.com
 (2603:10b6:a03:70::20)
MIME-Version: 1.0
Received: from guchchen-System-Product-Name.amd.com (180.167.199.189) by
 HK2PR02CA0211.apcprd02.prod.outlook.com (2603:1096:201:20::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=) via Frontend Transport;
 Tue, 24 Dec 2019 06:33:38 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [180.167.199.189]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: a9c2aec9-9450-4b71-5992-08d7883b3698
X-MS-TrafficTypeDiagnostic: BYAPR12MB3127:|BYAPR12MB3127:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB3127EABDA9C2924ECC74C7D8F1290@BYAPR12MB3127.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:346;
X-Forefront-PRVS: 0261CCEEDF
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(396003)(39860400002)(376002)(366004)(346002)(189003)(199004)(81156014)(44832011)(81166006)(16526019)(5660300002)(186003)(8676002)(316002)(36756003)(86362001)(4326008)(66476007)(66556008)(6666004)(478600001)(2616005)(26005)(52116002)(6486002)(956004)(66946007)(2906002)(7696005)(8936002)(1076003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BYAPR12MB3127;
 H:BYAPR12MB2806.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nuqSjVaq1KvIXsI3p2GuXhhesfE8xsdNRXx1X3rfCx2tkbzIjzqDzzuPaA2z9UG6ltyUcTv0dcCHVdq8mrllSOcSb2tMYIxkqJGDkQf6vcA2b8Slz/Yz2QtsnAMwBWb5ePlk64UiP5IHRcbysFfd2mTB+FiP3OobjTcLaBBFkvoiKsmBIPAJndjyLl2dy5TmBT+v+1kyA8dA0S4Wbbkd+jL5CwTraZrJyxxshCTlgHVblBEd7ebbrAB5VJNoL8HgdL9aBkwr5945AT1nRo7HvzVouxGkNqqIK0y5Emjnyp/ja2NOgx0DymbYDbZvY2PMJob0TpR6GFjW/10bAFv88g6kuCYU742yZyNf25fa++hsLuCsQsGELuSXKr0sFiERVGBxNu3O+fhJVH5bV90NPdQzIIOq4FD1PFpV3lSVuu8UBSB1Nh9E3CL5siz42JXu
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9c2aec9-9450-4b71-5992-08d7883b3698
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Dec 2019 06:33:40.1074 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tfZNdlaxZ1GT06SNuuk9mVOWeNkP6RMjJcPNC3QWaAffHnTH+pZaCqdImtHPMdaco5fSfDYBVeve0WteqGyE2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3127
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

Former return logic is redundant.

Signed-off-by: Guchun Chen <guchun.chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c b/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
index bb701dbfd472..41af6d0801d9 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
@@ -456,10 +456,8 @@ static int nbio_v7_4_init_ras_controller_interrupt (struct amdgpu_device *adev)
 	r = amdgpu_irq_add_id(adev, SOC15_IH_CLIENTID_BIF,
 			      NBIF_7_4__SRCID__RAS_CONTROLLER_INTERRUPT,
 			      &adev->nbio.ras_controller_irq);
-	if (r)
-		return r;
 
-	return 0;
+	return r;
 }
 
 static int nbio_v7_4_init_ras_err_event_athub_interrupt (struct amdgpu_device *adev)
@@ -476,10 +474,8 @@ static int nbio_v7_4_init_ras_err_event_athub_interrupt (struct amdgpu_device *a
 	r = amdgpu_irq_add_id(adev, SOC15_IH_CLIENTID_BIF,
 			      NBIF_7_4__SRCID__ERREVENT_ATHUB_INTERRUPT,
 			      &adev->nbio.ras_err_event_athub_irq);
-	if (r)
-		return r;
 
-	return 0;
+	return r;
 }
 
 #define smnPARITY_ERROR_STATUS_UNCORR_GRP2	0x13a20030
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
