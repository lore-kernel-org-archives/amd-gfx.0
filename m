Return-Path: <SRS0=BheJ=2B=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AF4FC43603
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Dec 2019 15:33:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C50D52173E
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Dec 2019 15:33:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="YNjSeWhi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C50D52173E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 68EFF6EB71;
	Wed, 11 Dec 2019 15:33:20 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2058.outbound.protection.outlook.com [40.107.93.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C682C6EB70
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Dec 2019 15:33:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EKznBBG8XRr4H1GW6Tj5amxsN9bCKEgVW/BJBnFiiWDaFoF6RNbe6Mvfe3CdKQnNL5jPgVrN6blS1ivDc7533SgLUzzV3xH1MW8eIr26Hmvu9hJFcDQGwKlQ0xEK+4z/h/gSmxcJeVU9MFw3ktcTnOmqePc+PnktKYmWfY+G41X9wz1ckK/JxfHYJTgR/C2M7OajyZ/pDblqxlz4RTgVd1kcU6A02oOFB+6BGM2Tq0wm/VM7GdYTjzjSKSzrnyU4lku3+BBVHtEf/8s+KozVyX/cnyLVVBOtNXDXdq3K5jNTUoZLlt0Cito7C53kB+1SujNEpQ/4h74VPsl+L/TuMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wd7rbZNxeG8+FdJLwIpUbzXMt3GKKzi4p84Onl9ENV8=;
 b=ZycN5WKnrVKBHxGo1W5tiMPA2KYZCz599R12hkZ9GRL7Zdbg3D7/JqmTO15vzbQwyPreTyzgUqvdMKaBgWIQO6jtur+lL/BQTVpjSHeHB8x+Q8zAnS9esW2dPJWSvkjLusIyiFP0AYdt3dbfZUUDN/+Bla+Cc7lx+kmCV5ljp9owBLRnH5B4Amf9G/7O4zR5oIN0Fep7KfEQXrzyKoByv8Wlw2JdHQ9sHzrsPFF+bYz99NxoSAHJuBruk2NWDjx7qMePoJplKp3EIJm+G+wT0nPyJuFP3ifV19ErGzMaG4kx4TAv6SQd3mHp3EQ4//Sy7v+pykcynQdVXd6OTLVUdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wd7rbZNxeG8+FdJLwIpUbzXMt3GKKzi4p84Onl9ENV8=;
 b=YNjSeWhiaNK8yT/8EPG2drxmGPen690c7PacosYPoj7YXOrF5jnEggjbC+VPHMhT21gt9pH6/GeW0jULUya9X5MPKOLiIB0vWIEa9GDghjxR1krjYZFRlhzDRhAroPDnFkkEKNiUold1oS1vLN6lA2lyfvzV6byHHYFfK03v4ME=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (52.132.180.155) by
 MW2PR12MB2570.namprd12.prod.outlook.com (52.132.181.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.15; Wed, 11 Dec 2019 15:33:17 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::3d1f:4c20:e980:6e69]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::3d1f:4c20:e980:6e69%5]) with mapi id 15.20.2516.018; Wed, 11 Dec 2019
 15:33:17 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 02/39] drm/amd/display: disable lttpr for RN
Date: Wed, 11 Dec 2019 10:32:16 -0500
Message-Id: <20191211153253.2291112-3-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191211153253.2291112-1-Rodrigo.Siqueira@amd.com>
References: <20191211153253.2291112-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: YT1PR01CA0007.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::20)
 To MW2PR12MB2524.namprd12.prod.outlook.com
 (2603:10b6:907:9::27)
MIME-Version: 1.0
X-Mailer: git-send-email 2.24.0
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d6683a33-fa9e-4dc9-8888-08d77e4f71c1
X-MS-TrafficTypeDiagnostic: MW2PR12MB2570:|MW2PR12MB2570:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB25706C489A211A42AC1F9AEB985A0@MW2PR12MB2570.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1303;
X-Forefront-PRVS: 024847EE92
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(189003)(199004)(54906003)(81156014)(81166006)(36756003)(66946007)(4326008)(66476007)(498600001)(8676002)(186003)(66556008)(6506007)(4744005)(26005)(1076003)(52116002)(86362001)(8936002)(2616005)(5660300002)(2906002)(6916009)(6486002)(6512007);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MW2PR12MB2570;
 H:MW2PR12MB2524.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3NRa/Uow+riachyxE/ka7xM5zf9ursJvaEmVRgzrn/0xWfxxxSAtS+Npo7PztIF94OSTwaPmsPNon1J8XxtK70feAdO+zrvpAcUFdK0bk/rMbmoNVv5cU0dHz89g8K1sa/+ar8eGQGlxnk8dC6g7Hzig1XzqxHRz7CdWjvaOlgI5EMFvo7jCTPnh5zytT5/LFTI9C4kPhAXa7PBtHzIWePaOfiRXMwjXsTblbIxJ4uHBA22BFv34RMZEEWL10CVCDqNety2AgyKsjMJfLxTde88VA4Ehtbmt6KySPNBAUq9Y8JkVsC0bsYcCnLiqN3QvD8/in5MgiDPH2a+vUVShkGCb0v1vu5XCZ4A7GaHclfV50CeZjeKE6p/Z8s25VXMqIEENTrNWa4586hV7DocfTL1a5iGXxcOTNeyGdZ1fwwB6QbuRcKBXENz0hTSWeZS1
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6683a33-fa9e-4dc9-8888-08d77e4f71c1
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2019 15:33:17.5097 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KdmvPbIp996v2pxtQDUBoRornBGrarB4+5QBEIF+ApAZRcMmyp2LSggjV9Nq26KiCOdmfI3SFLKhI69rEOMSew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2570
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
Cc: Sunpeng.Li@amd.com, Bhawanpreet.Lakha@amd.com,
 George Shen <George.Shen@amd.com>, Harry.Wentland@amd.com,
 abdoulaye berthe <abdoulaye.berthe@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: abdoulaye berthe <abdoulaye.berthe@amd.com>

Signed-off-by: abdoulaye berthe <abdoulaye.berthe@amd.com>
Reviewed-by: George Shen <George.Shen@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
index 8fa63929d3b9..98f0267300a0 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
@@ -1677,7 +1677,7 @@ static bool dcn21_resource_construct(
 	dc->caps.max_slave_planes = 1;
 	dc->caps.post_blend_color_processing = true;
 	dc->caps.force_dp_tps4_for_cp2520 = true;
-	dc->caps.extended_aux_timeout_support = true;
+	dc->caps.extended_aux_timeout_support = false;
 	dc->caps.dmcub_support = true;
 
 	if (dc->ctx->dce_environment == DCE_ENV_PRODUCTION_DRV)
-- 
2.24.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
