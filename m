Return-Path: <SRS0=q3BR=7P=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78656C433DF
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Jun 2020 12:38:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A94F20678
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Jun 2020 12:38:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="4FQZE0Qo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A94F20678
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 027C389DA2;
	Tue,  2 Jun 2020 12:38:45 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770082.outbound.protection.outlook.com [40.107.77.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C7AC289DA2
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Jun 2020 12:38:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CuYe50mGqiCNcy+DLaer7RJxW/ZoTY0iXmL7Vm5Paf0GRHagCtbYbT2gMGK9ZaGLfC983fxpStNC80fs80vkPnWI9myospg4QfDgzcxfHC/4Zb+gSvKM8uifhmoIGb69TDrqTeWfu/artdcVt084+I/avagMjTGSH5sno6vRGjbHS7W5HfvxGfg8U27/VeYv4vRdz5SGhq7xscUytEZtqcR5ygAoL1uDc3431zOzGSUG76k83g1JRLrF/pSWbpnhxPWmflCbkqF3i2VHTK/NEMw9P+n2uUMi80Qtlp8mvNTgxrL7CFWJMnt8Q6ywbLqk3g/MsH42BRVOmE9vDPIqLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AZGAbr+tzg273EIasGEcF97z6ma+ZTGlQ+x+cNcH+wQ=;
 b=Zz4GZ7su7ggUwsCPI4pu0pmT4B6T+aKRADtgj0GI6L643vZLschxchZURuCRWVNsQvq3vyKHURCMvQRKabTquk5+0tkS4glFkS3K9Xs4eRmsPprEboHESMryBnQNncT/WIiQzE7XrQtMhU0GBJY0RMuoIx+2MNeUZ5ZizeS3z4D3CY7+4HES5L3yc1Up2tghxunthNpAqdPBpt12Gv3UJ85b8lozE8fxgEFu53r9XM2Wx81Yb+J3n6Kl6PJjpmKKJBizVDY3AArDzKzxBUl0P+DoGqDcJORDXx4JczkQL2UdxlQIFKVNEWnTRqOnAjYDarwzUxR/mm9hVH6WCLJXEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AZGAbr+tzg273EIasGEcF97z6ma+ZTGlQ+x+cNcH+wQ=;
 b=4FQZE0QocjanZdy1YGFu2ToA4yZo0LUWr6mPP97XwFEXGLlkyMbaz7bq5BtB8j3vfZG4HtDs1KQZF6/nnjYUmM2rqYef1YsXAWnAkB8us3f0oKGr/xd2trW0ZKQQNNeC0cJTaDfWWE/8SKErzgODeIxLNojDI/uCj7uNB9g+DVg=
Received: from CO2PR04CA0132.namprd04.prod.outlook.com (2603:10b6:104:7::34)
 by MWHPR12MB1725.namprd12.prod.outlook.com (2603:10b6:300:106::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.17; Tue, 2 Jun
 2020 12:38:42 +0000
Received: from CO1NAM11FT011.eop-nam11.prod.protection.outlook.com
 (2603:10b6:104:7:cafe::50) by CO2PR04CA0132.outlook.office365.com
 (2603:10b6:104:7::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18 via Frontend
 Transport; Tue, 2 Jun 2020 12:38:42 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 CO1NAM11FT011.mail.protection.outlook.com (10.13.175.186) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3045.22 via Frontend Transport; Tue, 2 Jun 2020 12:38:41 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Tue, 2 Jun 2020
 07:38:40 -0500
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Tue, 2 Jun 2020
 07:38:40 -0500
Received: from emily-build-machine.amd.com (10.180.168.240) by
 SATLEXMB02.amd.com (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5
 via Frontend Transport; Tue, 2 Jun 2020 07:38:39 -0500
From: Emily Deng <Emily.Deng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu/sriov: Disable pm for multiple vf sriov
Date: Tue, 2 Jun 2020 20:40:03 +0800
Message-ID: <1591101603-21219-1-git-send-email-Emily.Deng@amd.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(396003)(39860400002)(376002)(136003)(46966005)(8936002)(478600001)(2906002)(316002)(82740400003)(70206006)(426003)(86362001)(2616005)(186003)(70586007)(7696005)(26005)(336012)(8676002)(6666004)(83380400001)(36756003)(81166007)(356005)(47076004)(4326008)(82310400002)(6916009)(4744005)(5660300002);
 DIR:OUT; SFP:1101; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 076126b9-51a9-43a4-8f37-08d806f1e1a5
X-MS-TrafficTypeDiagnostic: MWHPR12MB1725:
X-Microsoft-Antispam-PRVS: <MWHPR12MB1725AF5AFEC94AB85DA21B278F8B0@MWHPR12MB1725.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:346;
X-Forefront-PRVS: 0422860ED4
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TeNPONP57xCEdlgNOm9j89yJ7KsatLvNWk8jpimtD7fnFSl90xUfXIQZP08VU95N8LAgjPTmzrIT+yup9pyRU68nBXdbNM3VgodqyU3e+/zLE+hjYDLDGRNS6z/vAugZzRgimMzviDmrSBlO0ZinppcuyCy4DDd4mlr54herZ2RymeBwWvByZbSgYry5fbMqJRIeJ3aq/5yHxoeFCGGJG+mxVeez4QS+sC4K/AtaWLWP/5CFgYVdyYROU0HNPJ8vU5N7bd2ddTGfrKqUzVDN9cCD2Z6myHG620JTxqDo7R3DElDg3Z8ZMRe8CHE4kXvw5CTntK/V1PdXxEJe4WYrOGmP9iS8/bdtAcZqitD88itIRPK6lkRnu0d3kxVo6NALG+TSaiGq/vNBl0HZ/M79YA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2020 12:38:41.3934 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 076126b9-51a9-43a4-8f37-08d806f1e1a5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1725
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
Cc: Emily Deng <Emily.Deng@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Signed-off-by: Emily Deng <Emily.Deng@amd.com>
---
 drivers/gpu/drm/amd/powerplay/amdgpu_smu.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
index 5294aa7..8ed6c90 100644
--- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
@@ -1311,8 +1311,10 @@ static int smu_hw_init(void *handle)
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 	struct smu_context *smu = &adev->smu;
 
-	if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev))
+	if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev)) {
+		smu->pm_enabled = false;
 		return 0;
+	}
 
 	ret = smu_start_smc_engine(smu);
 	if (ret) {
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
