Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56469EB64D9
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Jul 2023 07:00:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A296E10E433;
	Thu,  6 Jul 2023 07:00:58 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2082.outbound.protection.outlook.com [40.107.212.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A00DD10E433
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Jul 2023 07:00:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TY+d3UoL+6kMQEaujVP0ul9RY1OmCGN/1f7Gp+wU6XTV3IFv7F8hkAoeUC/lGMHwUGpAIrNclOJA56ar2Yj2RJjItrRSqUZZGxiju8MI5wCQHJDghPg43L933LfHLeVymxl54GVTANEFeEob41TJ+62MQEnVwxHUZGHCULqrVrEtT3jFAhfQPtP3xQ99zffkaWPHBP04xBl73hrse2sp6kKUQhkEA8Ck3PZ7jFs8gDJGjNDz3hgDte72lYAKubdalNyw0Q48Bkv7cukZTYDYayHkrlYUZUwAv+j3o3CLxWoSlV6bH0RKKVh8myNdWKLeQY+mlsAtJwM/fCnEV4xUSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aPd167LVEKqhBwdFUMMVbv31JEt+bjRvMsKtyPfqoKI=;
 b=eCFDj+vlzlv/4w5eTKjAinBKCMb3ia7U8YroMahhHLUb1z2ti4z+FI6kfRb4vjLGBK2x0XsdQIjbHSN/bcydZl7WKxLLjeuwmiGjVcEeJkO2jmYVEUZImUV5t9n0K5/yRgope2HHDBhbbD8c6XPVmguMkOOgHHDm1U5KqowQexzsd0BIBzlzcjkDytLA8yAp/T2K8eAwXKO8JnfmnZE+cckbAhRPiHFgAfSLbj/Cda7h0HwSupnjCTRyxk5ctVI8f2OIsBefUULccOx5QHUMy0M0lmcm5q/BsBBBey0yxc0kBgaJhzHjisF5546MEwEvrDfSJ98mIzc0nLzlwQSuUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aPd167LVEKqhBwdFUMMVbv31JEt+bjRvMsKtyPfqoKI=;
 b=oTEbbyzZL4Xc5Q3xxetJvtte8Zc6pkVhImyZOKCF1fMYNlMHcyIHZS1u3uc7hePa+mfVlArvdXd/zgeq3xFphIx6Y/mQKYaWdkW8pTkz4DMM42b/yOSrSnRIufShdBXp2FVQA74ukjBSgDI9KnClHy7wFduhLDxp3xRqyzMPmPU=
Received: from DS0PR17CA0004.namprd17.prod.outlook.com (2603:10b6:8:191::12)
 by PH8PR12MB6819.namprd12.prod.outlook.com (2603:10b6:510:1ca::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Thu, 6 Jul
 2023 07:00:52 +0000
Received: from DM6NAM11FT090.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:191:cafe::81) by DS0PR17CA0004.outlook.office365.com
 (2603:10b6:8:191::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.24 via Frontend
 Transport; Thu, 6 Jul 2023 07:00:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT090.mail.protection.outlook.com (10.13.172.184) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6521.45 via Frontend Transport; Thu, 6 Jul 2023 07:00:52 +0000
Received: from stylon-rog.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 6 Jul
 2023 02:00:48 -0500
From: Stylon Wang <stylon.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Add dcdebugmask option to enable DPIA trace
Date: Thu, 6 Jul 2023 15:00:30 +0800
Message-ID: <20230706070030.3970121-1-stylon.wang@amd.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT090:EE_|PH8PR12MB6819:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d1fe80d-2f0e-4195-e840-08db7deebca3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7Mew3dMdlkeA+d0qmpcIHb3uIl98gDtlOBCRufrHPAqoLXl72sdAAvk1/w4oeuSeGAOSRoCn/wT0VxanaEsMaQzjipcpYOroxvDaBNEVKP+7lQgNBreaxneFlyKHHh8BkbtebC/w6ZKvzgiR4hjCVlfRa9G/MOrau7CDkONO8SOQlKHK/phCqEwmFbTjXk8lXW667HixRSq2TXLu0/owQ7dj2/7GvOcIsLsr3cEbtZUzNRKwd21V9AFah5gaLF4sKptdqt5M/fNUf0TA8bf5N3MejkIP/b4IpoZdtShx3nbxhuU6l/SnBIL8s+k7VdSmFvO6vmPkC+NJRaa1WEWPhZvNwMKFv9zwDSf/9NNt34weS5tDSyV8SBawcRsSmnff/xWNLOzK31Cti4tYKYdzec11HD75/Q4nODDg1cnD3z5GhSRo+omIBYxImhyvsiE0epb5pdq3qN1bs5YvRD2YjHMj0HXb9hez9zDKDkEKHL/jBxP5thXsg8WadBgDwJju6nn2E+hrhXUG/zpCyB3JYIPa8Knnw3Bo32iiAMxsYfLpfUVadS/vmi9T10qRdk7Zh6Qnxz9p44yp+2NiDlm3cMqpkVI1dBaBTkwmuCy7m2N6UWBi9JR/vQkz9+lFTHWsG78hOB0JJymLCtUeEzsQnEY2l7YQyvnjzSUYobokBHiV25J4RCd1fjzg5JoUUB1BpcsdrsESMTECmucprGvQiudw9aEAZ+OrhtHHEm98ksMTlAN3pnbDrTd1hJDLnDe5yRlozQyJlLivuf2jD97yig==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(346002)(136003)(39860400002)(396003)(451199021)(40470700004)(46966006)(36840700001)(5660300002)(26005)(478600001)(82740400003)(1076003)(6666004)(2616005)(16526019)(186003)(54906003)(81166007)(4326008)(6916009)(70586007)(36860700001)(356005)(336012)(426003)(7696005)(70206006)(316002)(86362001)(47076005)(8676002)(8936002)(44832011)(4744005)(40460700003)(41300700001)(2906002)(40480700001)(82310400005)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2023 07:00:52.2823 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d1fe80d-2f0e-4195-e840-08db7deebca3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT090.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6819
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
Cc: stylon.wang@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why & How]
It's useful to be able to enable DPIA trace with dcdebugmask
option, especially to debug DPIA issues involved in transition
of system power states.

This patch adds an option to amdgpu.dcdebugmask to be picked up
by amdgpu DM to enable DPIA trace.

Signed-off-by: Stylon Wang <stylon.wang@amd.com>
---
 drivers/gpu/drm/amd/include/amd_shared.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/include/amd_shared.h b/drivers/gpu/drm/amd/include/amd_shared.h
index f175e65b853a..abe829bbd54a 100644
--- a/drivers/gpu/drm/amd/include/amd_shared.h
+++ b/drivers/gpu/drm/amd/include/amd_shared.h
@@ -250,6 +250,7 @@ enum DC_DEBUG_MASK {
 	DC_DISABLE_PSR = 0x10,
 	DC_FORCE_SUBVP_MCLK_SWITCH = 0x20,
 	DC_DISABLE_MPO = 0x40,
+	DC_ENABLE_DPIA_TRACE = 0x80,
 };
 
 enum amd_dpm_forced_level;
-- 
2.40.1

