Return-Path: <SRS0=mx+S=6H=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C536C55186
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Apr 2020 08:13:05 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1DAD021582
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Apr 2020 08:13:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="h1UxcNID"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DAD021582
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CCCF26E16D;
	Thu, 23 Apr 2020 08:13:04 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690079.outbound.protection.outlook.com [40.107.69.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 26C736E16D
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Apr 2020 08:13:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MdhrdgQA/+wD7pcUbPvYB8o+lIJd3k91WBTevVK/eDSBoBDx/NJWR4ULedJnr4ZSEEcFwIT7OnHczWC3FVo8/b2Stkh4EI66jikUW+b7m+xYswEgFj6L9K3cYPzluT8uqJjRwJP02Kl4Sbd7cZMLpb/E8xR1KULdUrQURiFzRHKdig47UlfUt5IbTwh4JWJH8/XOJp6NZr3nKRskebc6HfSrJnQ/9FmHxrD1r6RYfMSPyGsewT+tWVtscMe7dApOJySjrePH5fbCNczTmD5KFwfcR609A6Czpr6IAzoYcPFWixLvwpfUy8t9WlLFYsdzzliTPNiwyY+yNQGTh716aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jKBHM6FVoowwt518aAHFQNVPXgatYoItwZ0FYxJhNRs=;
 b=fX280JvOdO2XWWrwt/QJlpsnVvO3OtEAkCFN30nl860emIFee6YOOKtPH5qIvCBP7VELqF4M34nmCdh1l6Wup3hLMb3z8ElDpNJV+GJFRdKpQ71IuubYE7ABzGt0ejqIrhXF6mywRKhuBRv8GBnXx4AnlwgGP9mAF7mH0Bgf2GEJB1NSrJlpZIivWr5Sc1P2WGep8e/x7OO+G+1EJN+ZznBOc6wUan0IlSgTDPhZks7TbYiX+AVbAT/it+wbGA9ZxJJEv7bpJDyj9tQoFDZU/YEFnp5ODqFEJ4g2PKlrA7gWA+HGSpW2nK63eZVzg0xDpY2NrTWOXfIgu1TPF8KQFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jKBHM6FVoowwt518aAHFQNVPXgatYoItwZ0FYxJhNRs=;
 b=h1UxcNID76USaA9vMHdtqSRAIWiDklLdyyvWEXLirgivVP9rKc6kHnwc/mKDH+vgQGBboU5T6EjP+yjlCLskQ3bEXv+CAjWxjGCQArCJ2BpI67sYqpI6ra02/wkbfYIIz74+JemB1KzEK3Yg/yORNbHwNfUNdLLgxRR8vSYrXWk=
Received: from BN6PR03CA0066.namprd03.prod.outlook.com (2603:10b6:404:4c::28)
 by DM6PR12MB3963.namprd12.prod.outlook.com (2603:10b6:5:1cd::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13; Thu, 23 Apr
 2020 08:13:00 +0000
Received: from BN8NAM11FT048.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:4c:cafe::18) by BN6PR03CA0066.outlook.office365.com
 (2603:10b6:404:4c::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13 via Frontend
 Transport; Thu, 23 Apr 2020 08:13:00 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 BN8NAM11FT048.mail.protection.outlook.com (10.13.177.117) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2937.15 via Frontend Transport; Thu, 23 Apr 2020 08:13:00 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 23 Apr
 2020 03:12:59 -0500
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 23 Apr
 2020 03:12:59 -0500
Received: from monk-build.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Thu, 23 Apr 2020 03:12:58 -0500
From: Monk Liu <Monk.Liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amdgpu: limit smu_set_mp1_state to pp_one_vf or
 bare-metal
Date: Thu, 23 Apr 2020 16:12:47 +0800
Message-ID: <1587629567-32108-2-git-send-email-Monk.Liu@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1587629567-32108-1-git-send-email-Monk.Liu@amd.com>
References: <1587629567-32108-1-git-send-email-Monk.Liu@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(376002)(346002)(136003)(396003)(428003)(46966005)(2616005)(86362001)(82740400003)(6916009)(8676002)(2906002)(81166007)(82310400002)(356005)(70206006)(4744005)(4326008)(6666004)(70586007)(336012)(81156014)(426003)(8936002)(5660300002)(47076004)(186003)(36756003)(316002)(478600001)(7696005)(26005);
 DIR:OUT; SFP:1101; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0755d3c8-4bc9-4ff0-c877-08d7e75e234b
X-MS-TrafficTypeDiagnostic: DM6PR12MB3963:
X-Microsoft-Antispam-PRVS: <DM6PR12MB3963C45E7A427ED7F1A0BCAE84D30@DM6PR12MB3963.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2887;
X-Forefront-PRVS: 03827AF76E
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lo/+YCmp40F328Wz8sncxsfSAbHdBB232G/0ME+o+LD4WH+uJhewbNPsdJqeKdln6brjqxcGfM58jmD0IHcIZT/QqwRGLDhbTTX1QqPHFU/ze/+7KkkG/OE1TY4+XGj6fkIWNXNOjpDP8zthH5K2ek0I8PuNQ4UZifHEF6Fn5IYWSp7db5AHPiTu05Bh/cN0seqwt+pG28y301DsMK3blvz3TCruRVu7eBkfhG1XEBXxabgSpfZz0l89ECRJBiEH4p96p+wSTQnLrT1QVwRv4Uul5etSvgN8EAfbhv1w2o2ZzRLYf0YDEwSTek783e2lvc9MWWIOdAaTsUmlkRnanSsjyniWS7SqVtZfNJKSr7wB3We3O0XjghN2rmaaAyraTEcl0EXQeVqlYhR0gF7fsfUMeAmKBCzq9q6snzW/MO2OsXLbsfPYfrs8ZWW/8CbtwuCvHz1z9IWJxrEUfPwPjAA2SmV3Moo4fIz53pHy9BGi+uTPbDpKgel/fSmN3QpZPL2Eh1mttiUmGnnxGwOmug==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2020 08:13:00.0895 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0755d3c8-4bc9-4ff0-c877-08d7e75e234b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3963
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
Cc: Monk Liu <Monk.Liu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Signed-off-by: Monk Liu <Monk.Liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 3d601d5..810141f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2465,7 +2465,7 @@ static int amdgpu_device_ip_suspend_phase2(struct amdgpu_device *adev)
 		}
 		adev->ip_blocks[i].status.hw = false;
 		/* handle putting the SMC in the appropriate state */
-		if(!amdgpu_sriov_vf(adev)){
+		if (!amdgpu_sriov_vf(adev) || amdgpu_sriov_is_pp_one_vf(adev)) {
 			if (adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_SMC) {
 				r = amdgpu_dpm_set_mp1_state(adev, adev->mp1_state);
 				if (r) {
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
