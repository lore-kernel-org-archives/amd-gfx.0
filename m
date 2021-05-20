Return-Path: <SRS0=8Dg8=KP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84A9AC433ED
	for <amd-gfx@archiver.kernel.org>; Thu, 20 May 2021 08:27:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 479F460FEE
	for <amd-gfx@archiver.kernel.org>; Thu, 20 May 2021 08:27:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 479F460FEE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DD53A6E41A;
	Thu, 20 May 2021 08:27:47 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2058.outbound.protection.outlook.com [40.107.236.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0F7A56E41A
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 May 2021 08:27:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UIFkeKbbyAeUPi85Etltsr+21zbj/uJqHfjRUGbPT5uyoIGb3CZV2Tk11UYSlKzjQoluujkp6HK9NjkxD6GvpGP49YAvQe0CptlRWV9AgWKyE4PcyGVG7qbucWcpQSa5ZmQtOLRIifSKzIR5cwyzzDoNVa0YRrwdDGJZvt7kY/rGZOrve0PQluZKfgJBknGTFLFm+fvzmTf4wQfYwA67JrGrUyGslg+7PLDq1XCLQ/5e5gE69+Xx/ImqwaVTzaiVUZti4SGLYTxufaIdO/mxjNL+080KngJvmNs0+ZaCO3TZ3FCk0zhVk5u4sUWiZsW/Rycr4M3CdLqhgjeS+Ggqlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4UO8bukGWszyivtVQvmS7PzL7hJOCOZEbushLDKxKU4=;
 b=ORvR1BYJYlWN3VHp+ZIzGgkJF+wqByP7D70ztCUrBAIqtg4DHBW/GgO/I0gDFRN5dyhv6gjVZstKCl26EzVI7qPIgS8Rn82RKXIYvnn7Th/xVTblprkL0XRheU8p9QJAjxNlc0V5hedD1FzmZ56ZOURdYVZqp4+AJxS7d/l3q/gm+q5IOkHldmQHduz+0gBRE6lxyCTjSPrpYtZrYsJaGaOZ3SdGwldDcQBpNe+cCGm3V4mVul8ZZThN6XOAchgnw2BV7j00OB+aBq4VsQwmWf2oebNlvFoGz3D4hcC4hc3R+8IhlBqMjmcSd6zywf5mSq2g7mZmiSxk25JAdyfxZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4UO8bukGWszyivtVQvmS7PzL7hJOCOZEbushLDKxKU4=;
 b=WaE520UpEzTGfgTixPOfv0YLr/7gMVJ7r0HZVlxeWBIiXpL+71/sraw+OWrOlL9sxEuSJ+i+w3xPQzIaUS0cfUChnRBJFfzfkq1ulFiXSmUA9bixFyA/1Ob8tQ2KoXS1O6c9pI6z3GmFVaXVD8flbPlhRqM5eQT0dfO+hnbNnwk=
Received: from DM6PR13CA0037.namprd13.prod.outlook.com (2603:10b6:5:134::14)
 by CH0PR12MB5371.namprd12.prod.outlook.com (2603:10b6:610:d6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.25; Thu, 20 May
 2021 08:27:40 +0000
Received: from DM6NAM11FT023.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:134:cafe::e1) by DM6PR13CA0037.outlook.office365.com
 (2603:10b6:5:134::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.11 via Frontend
 Transport; Thu, 20 May 2021 08:27:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT023.mail.protection.outlook.com (10.13.173.96) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4129.25 via Frontend Transport; Thu, 20 May 2021 08:27:39 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Thu, 20 May
 2021 03:27:38 -0500
Received: from jack-code-machine.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2242.4
 via Frontend Transport; Thu, 20 May 2021 03:27:37 -0500
From: Chengming Gui <Jack.Gui@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/pm: Update PPTable struct for beige_goby
Date: Thu, 20 May 2021 16:27:29 +0800
Message-ID: <20210520082729.14172-1-Jack.Gui@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bbdd7ff2-7270-4569-5c75-08d91b692192
X-MS-TrafficTypeDiagnostic: CH0PR12MB5371:
X-Microsoft-Antispam-PRVS: <CH0PR12MB5371B32AF3866891F5F38ED38B2A9@CH0PR12MB5371.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1247;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: e/ij5yvnqO5x7ADWUYomwtngo/mpMYVU1Fj0OBUVH6rqbXKVi9T7NaM8L5GOe0zEPweMRFU+39QIwHCnHRj2m1m9Cn9nJO677zQaRlQhks0pspRVxWWaNENhC4rfmqK0Grvy83J/Rc9PgDkKf6+r3sxnquqQC8F1M9r39pgTrFA1D0Kq3ST5HCgGi/wqWP6HOQWsLhhU16DeJK8th282tmcQeyk/sPfDybBAOIo5HYLoPK4wZdmBfDK+kmk57nTDj2xGKFisluwbg/z60oOYz1F88pbUxqcu0dDvk2CrZNEjXzr/+iPK9PN/Ga0E5CC+hsbtctoCUgBW3CnZ1p8U9pBk7X9Z6uzLZZUa5A0E9vWn3voShs+AB/3eJg4WuFopjkAc173b2+D1rzgiAW7IYROY5BVHb0oGidz/beCMp+GdwAAyFp4l/A7Mr+TZ077nImOr2BnSWwzcK3NvWqYTHwsOUpCKuru9E26Goj4CfFDCwnlmW5yPSAyEKlQZ4V6fYPG6o+RJxkp9viSvlrztK5u14TbvB3AIZZgpu0it/jgfMjFIoGGyRDxMMGMXAYtNh/ZGdsRwy9N88JBKE5UnhUIj1RIvEjNRqoZcJBbZVirQxSSbxbpWJpkJttTtBkeDETYKeCUjc/SD4t21Itqi2USQ8fzysdUfIkDK3ONmKE6b7Sn3mzWW1lkmRcNgvca8lKqzAp6YDpkQGn2e1s0AhA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(376002)(396003)(346002)(36840700001)(46966006)(6666004)(4744005)(54906003)(1076003)(26005)(478600001)(70586007)(2906002)(356005)(70206006)(86362001)(83380400001)(82310400003)(81166007)(186003)(7696005)(8676002)(15650500001)(426003)(2616005)(336012)(4326008)(8936002)(36756003)(5660300002)(316002)(47076005)(82740400003)(6916009)(36860700001)(21314003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2021 08:27:39.7482 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bbdd7ff2-7270-4569-5c75-08d91b692192
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT023.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5371
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
Cc: Kenneth.Feng@amd.com, Tao.Zhou1@amd.com, Hawking.Zhang@amd.com,
 Jack.Gui@amd.com, Jiansong.Chen@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Update PPTable structure since SMC#73.9/IFWI-XXX.013

Signed-off-by: Chengming Gui <Jack.Gui@amd.com>
Reviewed-by: Tao Zhou <tao.zhou1@amd.com>
Change-Id: I7f6a2dd85b367eb4ecbcfcd5141b1960a395ec24
---
 drivers/gpu/drm/amd/pm/inc/smu11_driver_if_sienna_cichlid.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/inc/smu11_driver_if_sienna_cichlid.h b/drivers/gpu/drm/amd/pm/inc/smu11_driver_if_sienna_cichlid.h
index 7a6d049e65e3..a1079256d318 100644
--- a/drivers/gpu/drm/amd/pm/inc/smu11_driver_if_sienna_cichlid.h
+++ b/drivers/gpu/drm/amd/pm/inc/smu11_driver_if_sienna_cichlid.h
@@ -1176,7 +1176,7 @@ typedef struct {
   uint16_t         LedGpio;            //GeneriA GPIO flag used to control the radeon LEDs
   uint16_t         GfxPowerStagesGpio; //Genlk_vsync GPIO flag used to control gfx power stages 
 
-  uint32_t         SkuReserved[16];
+  uint32_t         SkuReserved[55];
 
 
 
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
