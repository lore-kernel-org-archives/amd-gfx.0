Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED8D0C4332F
	for <amd-gfx@archiver.kernel.org>; Tue, 31 Oct 2023 07:08:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5FE3910E408;
	Tue, 31 Oct 2023 07:08:20 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2052.outbound.protection.outlook.com [40.107.244.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EAB6810E408
 for <amd-gfx@lists.freedesktop.org>; Tue, 31 Oct 2023 07:08:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gMl2ziTVTaWbROHWub44htcizhgGx3UoTkdA1T2ISkKcL/z7i9MQcsL/TgiQjhvMDVYuIiLM3+5x238TE2stYjZr/goGqnWdk5Ru/CKkNWtmR2GUZHdpr6I9iROn9hjSsliOCew8FyV9IdyGGYBPp0s097ND0DDuaEX0M/Njpw4xAMzBqnnnUDYcnwdHlmoBdQ42TzXTwGVQ8//RlrfOe42mr2BTQzUBEqZ68Aljz4J6cfGT5L7lroYn8IXRMskiI3Y3qYrzbRHB9CtQMng3W+k8ecZTq/kc/KtCgd++Tmm+wy4OvNKVQxYv6bwBxenPaxr6EeZYlMwmDjTheKSeAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3GiNHHCQGlkbSVO3CByySYbFQsH0zn9ivvJE8jWf7pA=;
 b=Ke/GN24VCp/3DaR1Gblsoo2HbVyzC98f2JSyzhL26nIHcOAhLMxAPdZJbg3LUL09OocWenikjLiPq6mibk83x+H86pi6/WUtegRl66JntNFt/35tU8a9Rq5TtLH8lLbhM5gtmrOCe3LNXzCWsKmbwW6U4DqpMp6l/aA5ldXkbQRqfyvh6OwCL5XJypmePACYmM110tS0t3Hguo0QJetn2nAJuGR/iZxMNv2quUJyQK2jou7efQ9SBpX89nrMT1vJvNTqVsb4yNyXSXgWathyw0RBuoe1/lYrruFYabK4ndjvmMfdfSmoTDE0gUS2gqS9sXZEx7SkZVnVsMBOfcIjAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3GiNHHCQGlkbSVO3CByySYbFQsH0zn9ivvJE8jWf7pA=;
 b=o4CYt+SeCe3Bjq+xhGcaeM6Ot5vZ5CcpvYNnKMrX9w8GuH3jvoZk724mDjPsaSFClBpJJauCA/pj7C1yy85jgI6D1EvVR9QRVjmFw9ey/uTjRVgsC8KU1V2e4eRsmWE7Ar58v01ypVh0T1Uih2qHyopm3gfPuKlHF3nIlUfnVlE=
Received: from DS7PR05CA0108.namprd05.prod.outlook.com (2603:10b6:8:56::27) by
 SN7PR12MB7300.namprd12.prod.outlook.com (2603:10b6:806:298::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6933.29; Tue, 31 Oct 2023 07:08:17 +0000
Received: from DS2PEPF00003443.namprd04.prod.outlook.com
 (2603:10b6:8:56:cafe::c0) by DS7PR05CA0108.outlook.office365.com
 (2603:10b6:8:56::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.17 via Frontend
 Transport; Tue, 31 Oct 2023 07:08:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003443.mail.protection.outlook.com (10.167.17.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6954.19 via Frontend Transport; Tue, 31 Oct 2023 07:08:16 +0000
Received: from taozhou1u2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Tue, 31 Oct
 2023 02:08:15 -0500
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Don't warn for unsupported set_xgmi_plpd_mode
Date: Tue, 31 Oct 2023 15:07:56 +0800
Message-ID: <20231031070756.16404-1-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003443:EE_|SN7PR12MB7300:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ffaaa6a-5fd1-4f77-5ca3-08dbd9e027e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LKdmX7DAFele7+jQIpsm37pQi8zjfwf/ZDC8i651877N9YrvJuJkIcvfR8uSbbbtdrYhMjv+41r8jrZo+0MwjAgGXa6vTGwJy/HUeEY7+IGHW+ac09Ulpz83LkLIRbym6+1y/tfJEPSEFrd3KCdxRDT5zky3Y/gUIxs3kxABlFpvVRMtRTUomq+x1YBIiuZEbPao2ZAvRPaSRXaXkupmJN0/nEcfzJMtL3I7LA1ouaO68VU9Amx+j3FJQghpyQjA/zVip25wfvOLjbdr2/HYkrxz73z1V8P1/mwcQrnPZI51qj1tgrLdlkR+t/yXgfeq2X/c+bCn1qIgKsaIdYvDsm70QkWHae3mpEikivaq6A/9JxeP58+ARJiyJbjH+hdUqnKPupISYM/78njAuqlwtRQPpWjWGfTFErN/mBKf1N9fQgFw+Kvxu++dZk/9GuxQ1tgr98boNZEK7a0w2CEBT4ixwcxCQuZcOk/7F0kPxQvvDOTCm86Y1fzWASEP6OENj9e/3y57vDQwhcslIGi4A9c2fHDi06TFNU8ZONL5zufwJxRJf4B4XSE2vbSduESOzz43VkZScrwaQYGPHeKggaRa/lFumSL2wQ3sBYy0sOBQaS3Fg/G08OWxvbxwLf8CAjKSENs8XVcf9wXYuYhv0dxeb9CG/31bn46qdWPfkSUkiwxHIoOUfs3cK8RQEBe4Efb/zZjcEdTRt89jvLMGv/wuS9/kJiH7i3kP4pStORGNSane40Q3HUfpAEgqMmKzMUyGCM1TJeJJHmUqcTYcf+nS3aId/u613CP0HttsSlZGTEFI9WCUaA46syh5ZK0x
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(39860400002)(396003)(346002)(136003)(230922051799003)(230173577357003)(230273577357003)(64100799003)(1800799009)(186009)(82310400011)(451199024)(46966006)(36840700001)(40470700004)(26005)(16526019)(40460700003)(36756003)(40480700001)(86362001)(82740400003)(81166007)(356005)(426003)(336012)(2906002)(83380400001)(478600001)(7696005)(2616005)(1076003)(36860700001)(6666004)(47076005)(8936002)(8676002)(6916009)(316002)(4326008)(54906003)(41300700001)(5660300002)(70586007)(70206006)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2023 07:08:16.7651 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ffaaa6a-5fd1-4f77-5ca3-08dbd9e027e7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003443.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7300
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
Cc: lijo.lazar@amd.com, Tao Zhou <tao.zhou1@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

set_xgmi_plpd_mode may be unsupported and this isn't error, no need to
print warning for it.

Suggested-by: lijo.lazar@amd.com
Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
index 0533f873001b..c9b09bddbcdc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
@@ -1138,7 +1138,8 @@ static int amdgpu_ras_error_inject_xgmi(struct amdgpu_device *adev,
 	if (amdgpu_dpm_set_df_cstate(adev, DF_CSTATE_DISALLOW))
 		dev_warn(adev->dev, "Failed to disallow df cstate");
 
-	if (amdgpu_dpm_set_xgmi_plpd_mode(adev, XGMI_PLPD_DISALLOW))
+	ret = amdgpu_dpm_set_xgmi_plpd_mode(adev, XGMI_PLPD_DISALLOW);
+	if (ret && ret != -EOPNOTSUPP)
 		dev_warn(adev->dev, "Failed to disallow XGMI power down");
 
 	ret = psp_ras_trigger_error(&adev->psp, block_info, instance_mask);
@@ -1146,7 +1147,8 @@ static int amdgpu_ras_error_inject_xgmi(struct amdgpu_device *adev,
 	if (amdgpu_ras_intr_triggered())
 		return ret;
 
-	if (amdgpu_dpm_set_xgmi_plpd_mode(adev, XGMI_PLPD_DEFAULT))
+	ret = amdgpu_dpm_set_xgmi_plpd_mode(adev, XGMI_PLPD_DEFAULT);
+	if (ret && ret != -EOPNOTSUPP)
 		dev_warn(adev->dev, "Failed to allow XGMI power down");
 
 	if (amdgpu_dpm_set_df_cstate(adev, DF_CSTATE_ALLOW))
-- 
2.35.1

