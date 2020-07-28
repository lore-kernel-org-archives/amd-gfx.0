Return-Path: <SRS0=z2P7=BH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32CCFC433E1
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Jul 2020 15:43:29 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 043D020786
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Jul 2020 15:43:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Cp55XOhS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 043D020786
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 986416E1F8;
	Tue, 28 Jul 2020 15:43:28 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2056.outbound.protection.outlook.com [40.107.236.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3B9766E1F3
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Jul 2020 15:43:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MoZ28mNKH7gBnhKsIKBKQ/irDGF3ZFqA7dgUbb1B13vo7XErt0iafffGPFEUEDJT/SUJqyQORsIqdTI4u3JUCSm86QhTSyXoyYStkWvYx3TbRq8Fzyb2ANgJBbYoe76iOKgACYOSbCeRxoKpdQXqVqYX5qKUwSD68QlAtj2d3+SWqV2h0t1+dJH5w6fF6QI95rJSrG1feooHpvcCW8qzgdK09KDponZ63EGkaAKqhpjonncDe5pSGHy07jf4Ff8tcFGmi/eZ4yqZDCv16dLc8jabOZFaJUm0MLBrwAQEhU0CIl2YFE+zC3o/ULVLvR/cRrFjqXz9O+F7oGWaUgukbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HQe61qLlSK1OALvzBVbkn3YOK7LPfGM2t2OVU8IXc2E=;
 b=gSrSMFzaUWuy4qmYFRGjTr0TYky6QNyqCEFFqF7hTUPfMiHqL3m/f2wJ3a9/8lPBZDeSqLZiAHbd1FDyLMy+R55Vgp+tdQ8aNyNfSgeSUumMOfN16TpD26I0hD46UziheYSimcetXUQrFj+vtlCgbVqiiJsN2NLLtg5IqYZvfXsgOaND9vP4t//C6bYNcFvKNowYYqhpwyaKIk4qSi1mO5yAtVbImr+mwEtYcAemQmxQztJ+xqcX6jZ/6PetS9ZDR+y/8m+iftjgfWYmdvPbVEBPLeW/QUSdHEDwdawZmKx0hDgtqpjQ7rAx5aYzUTBUp4NerYX6WCTxdzPhq/WhIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HQe61qLlSK1OALvzBVbkn3YOK7LPfGM2t2OVU8IXc2E=;
 b=Cp55XOhSbI06n3WdYriBrkL7JWyEb+9Hr7vanZkWEn/wJnvsPGII/AwckjJBO34djGRBD0qhIxrb/gwEXvhxy7pnJ6Bu8hGUDG6p2zO1O/63RYiUXow3ogJn1ue/cz2WcV1ID2edMmdesPNbEAn+LvjhZ7Kx+L07X99AkXCjcuM=
Received: from BN1PR10CA0007.namprd10.prod.outlook.com (2603:10b6:408:e0::12)
 by DM5PR12MB1130.namprd12.prod.outlook.com (2603:10b6:3:75::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.21; Tue, 28 Jul
 2020 15:43:25 +0000
Received: from BN8NAM11FT048.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e0:cafe::7d) by BN1PR10CA0007.outlook.office365.com
 (2603:10b6:408:e0::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.16 via Frontend
 Transport; Tue, 28 Jul 2020 15:43:25 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 BN8NAM11FT048.mail.protection.outlook.com (10.13.177.117) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3216.10 via Frontend Transport; Tue, 28 Jul 2020 15:43:25 +0000
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Tue, 28 Jul
 2020 10:43:23 -0500
Received: from blakha.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Tue, 28 Jul 2020 10:43:22 -0500
From: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
To: <nicholas.kazlauskas@amd.com>, <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/display: parse ta firmware for navy_flounder
Date: Tue, 28 Jul 2020 11:43:18 -0400
Message-ID: <20200728154318.29805-1-Bhawanpreet.Lakha@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: be667a90-2ae3-45ae-a2b3-08d8330cf718
X-MS-TrafficTypeDiagnostic: DM5PR12MB1130:
X-Microsoft-Antispam-PRVS: <DM5PR12MB113005D8E2E1340A3A635CCBF9730@DM5PR12MB1130.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:983;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Bl5NyjtXCSuWJancQhtTAPUMmkt2NPXVNliqcijS5ToP8BTtoY33moGEDHe7inM9JQhqFnrSqv1osr32dSoZ9RYaSapsaWOBpxhiu+f5pC4D0Pfbx91YqKFatRahzXSq09658ODPyWsp6Tq8wICQ3dH0zrp3NIKUdeg7Cr68nH2BQhULigomNNYdMZ6LfyNV1UiXYlzoe5yRuoQ+7LxWiBqEQ5Vluc/4OexyIT4wAd/12PyW1n66KX6qc+kLG7C0ZoNj2qUwJlCg5e/7rRUzOOxYdZHxWNyw/vUWdLqTSmKYWAHBdIX2o1inQ1Ukz4HQpSUSK612i0hFklkXWukPOm8czRt8aN8Vmv0CV/X7rdsylUVNLuYhCdqIZ+B5FoJJ8N6TkhpkvJi4JRZx8KOqTg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(39860400002)(136003)(376002)(346002)(46966005)(70586007)(70206006)(36756003)(426003)(110136005)(86362001)(356005)(83380400001)(2906002)(82310400002)(316002)(4326008)(7696005)(6666004)(8936002)(336012)(4744005)(1076003)(54906003)(2616005)(81166007)(5660300002)(26005)(82740400003)(186003)(47076004)(478600001)(8676002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2020 15:43:25.0706 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: be667a90-2ae3-45ae-a2b3-08d8330cf718
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT048.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1130
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
Cc: alexander.deucher@amd.com, Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Use the same case as sienna_cichlid

Signed-off-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/psp_v11_0.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
index d488d250805d..e16874f30d5d 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
@@ -179,12 +179,11 @@ static int psp_v11_0_init_microcode(struct psp_context *psp)
 		}
 		break;
 	case CHIP_SIENNA_CICHLID:
+	case CHIP_NAVY_FLOUNDER:
 		err = psp_init_ta_microcode(&adev->psp, chip_name);
 		if (err)
 			return err;
 		break;
-	case CHIP_NAVY_FLOUNDER:
-		break;
 	default:
 		BUG();
 	}
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
