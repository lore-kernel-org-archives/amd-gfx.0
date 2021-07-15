Return-Path: <SRS0=bMdI=MH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34D46C07E96
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Jul 2021 07:12:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8E986128D
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Jul 2021 07:12:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8E986128D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4D1946E573;
	Thu, 15 Jul 2021 07:12:53 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2073.outbound.protection.outlook.com [40.107.244.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB4CB6E573
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Jul 2021 07:12:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hMQGTAOOLUhuKBkhxR+w0O9c9osq2LUAxvxMa/YHztWg67S31tCmAWptSFftosXd2+gv2bJshMw3U1ex90iRWF6lLI5Tc9bI/3nnOypji3YjyqZIb5Z+ZTFqsnSs3UIek4asqnIPLxpl882IG+V88IMZ4uw9muplEpF6pNm2mgKzkOqCIZbR5UMjo/m0pYPpIbyF3kV+/gMYII7B7h2rZ5DJevBDRlcy05veDRup3z2FONYapyGSGkJnrof3vtDnWVqZQbck/t2fIOeV8YcSaE5LdaOK3niwpa/CppATbODYxvKdxeSSZMotnAekwb3PT2LqUG8bdJGePseszo0FCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vDn2naauNQqjSmJsnaXuD6/g1C9VUUQ1lA4K46Meujg=;
 b=nyFC3g1vi+H8KU9oOdYccB4byKWdFwQ4V5UCOaU6oyVGXIeaBqlgY0bMup8qFSG5nNC6y0WwtEI0WYF8vSR8H/jlKcVkwxLSGgQnBR+dUWNK3dHOpuuSzD0AaGcUQRjwhf6qcOG8xL2vuC6Gi69fRi2DD/04VfI8TZZkdHd5YT2dkO5FVHAV5ulwUqkkw06O6rYqt/Q78cS2WwGwrpWDiRIWCSTvoxzFXhhHlxulAtPsY0fTW58wYnG3T3zw/5rLsn+UBZwr62PrPxAYZNTyRgJ2vvuCAAn1bIA1P5CJFw8p2c3qWMeP2kinITT0KgK4Gx8rOLeRYrTDmuXwjhwbqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vDn2naauNQqjSmJsnaXuD6/g1C9VUUQ1lA4K46Meujg=;
 b=kL58Tt//EjIQCmvavIIZgMaQ7+Kk6JdX6fSJ789n45FDk7TNQbAGO3CCKRkFsjyhs3ALCrk5HOqpbzGZVEXSLOt7IJvPrauiyHATNQK0+Bi1rXkcCnZLc8bSy4pBmvhg2qnOyJFAnxgYi+odqBKcjJ7XD5BV3Tb6qDWaAY1EonA=
Received: from BN0PR02CA0056.namprd02.prod.outlook.com (2603:10b6:408:e5::31)
 by SN1PR12MB2414.namprd12.prod.outlook.com (2603:10b6:802:2e::31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.21; Thu, 15 Jul
 2021 07:12:49 +0000
Received: from BN8NAM11FT064.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e5:cafe::9c) by BN0PR02CA0056.outlook.office365.com
 (2603:10b6:408:e5::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21 via Frontend
 Transport; Thu, 15 Jul 2021 07:12:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT064.mail.protection.outlook.com (10.13.176.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4331.21 via Frontend Transport; Thu, 15 Jul 2021 07:12:49 +0000
Received: from taozhou1u2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Thu, 15 Jul
 2021 02:12:46 -0500
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <jiansong.chen@amd.com>,
 <jack.gui@amd.com>, <hawking.zhang@amd.com>
Subject: [PATCH] drm/amdgpu: update gc golden setting for dimgrey_cavefish
Date: Thu, 15 Jul 2021 15:12:37 +0800
Message-ID: <20210715071237.32320-1-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3d91f62f-afcb-427f-125a-08d9475ff434
X-MS-TrafficTypeDiagnostic: SN1PR12MB2414:
X-Microsoft-Antispam-PRVS: <SN1PR12MB241481A30479916DC2F040DCB0129@SN1PR12MB2414.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IHA/aFS4SX3Pl18Ts8yMHK+TDiyPHkTXmIxltcuXEZrbrhyZrZFWbsxC2A3ouZFRmy6dK+orsLWUscXeb8xYMutqduRg+tpHE2+n04IDku1Y27tRUBBaLMhMbfKUxOLEpD53WHM3pXfcNRZr4duY3HVphde/tFeFCc7hE5NMNX72OEPb7HU/cR95wRcbMh9q8waAmtPypeYKiaEzpwzRYtZvIEo8KYWBP3rucGdRMySOSlBqeELRmF6liwBYOsmKvtY85OFhOw/+BVLR8Ig/i4otptYxUR1RCVSw1BJQdBZps1PQIJwxUeYWUnqe7o61COtdefHQIis+PP2/HieJwCoisysSUc1wkp2FFIGX0TR/YRaiJFg66pfTc5Z1P3dnX7/T+MaWlMFXWMNbV4aF5tImaXXtMkcbH/bnw+cNXRVhYg2beLb0OnG+YySeiwArfnz/keZccw9REFad2IMUN1gkiW9u9VPlvKuuZN+7Pwb/GABrICoPyx0oi+9n3Pq4JEPhame9GTSx9X254bY/zvP/VygSMj7Ref+cLNnTbClKY46CXc69/rGJW/bqQkXK5EvoyqMmD0dJ0HcnZAgqNOrvQO5jzkVLSje0IRBUcu+gtwxl4a5x1Z+ar4rGNdW5dammayQbq+MFhZ1D/hs+dukEKJbpMkpYN+moDaB/5R4OPSHIay9ANCCGbaf1eP6PZe45jVV4f0od/U24CgO2Grlq9TxQRXAjuvCeJ+Cv1Ls=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(346002)(396003)(376002)(36840700001)(46966006)(1076003)(426003)(4744005)(8936002)(110136005)(316002)(336012)(478600001)(6636002)(2616005)(5660300002)(4326008)(86362001)(82310400003)(15650500001)(8676002)(7696005)(47076005)(356005)(70586007)(70206006)(36860700001)(83380400001)(36756003)(82740400003)(6666004)(26005)(2906002)(16526019)(186003)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2021 07:12:49.3514 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d91f62f-afcb-427f-125a-08d9475ff434
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT064.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2414
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
Cc: Tao Zhou <tao.zhou1@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Update gc_10_3_4 golden setting.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 80e7069e12ac..454293ea5b02 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -3451,6 +3451,7 @@ static const struct soc15_reg_golden golden_settings_gc_10_3_4[] =
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmSQ_PERFCOUNTER7_SELECT, 0xf0f001ff, 0x00000000),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmSQ_PERFCOUNTER8_SELECT, 0xf0f001ff, 0x00000000),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmSQ_PERFCOUNTER9_SELECT, 0xf0f001ff, 0x00000000),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmSX_DEBUG_1, 0x00010000, 0x00010020),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmTA_CNTL_AUX, 0x01030000, 0x01030000),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmUTCL1_CTRL, 0x03a00000, 0x00a00000),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmLDS_CONFIG,  0x00000020, 0x00000020)
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
