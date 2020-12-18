Return-Path: <SRS0=OQM/=FW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFDB0C2D0E4
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Dec 2020 22:30:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7347A23B5D
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Dec 2020 22:30:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7347A23B5D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 09BDD899BB;
	Fri, 18 Dec 2020 22:30:07 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2080.outbound.protection.outlook.com [40.107.244.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9DCB4899D6
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Dec 2020 22:30:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R5jq4bjDi0964jb9dGLCciMc2s58aOdbLhKLJGSb8dBkIC9aLSzjriypXoul01b/1RBOHcrN5sIt7qFX6jHLBmqtsGsyZojYogxBO7C9eozJS5ALnjmJmDUervJd6DRhYUFHHR3ykzwCXHcSHB6mdlWpxvI8Xg7K8WyU8EaG8jXYhlvBUBPeZMLNqMG78CzVOZa+OMKeg2qaWXv8t5RmOLH1boc6T2LQZX2u4JGywUHSu1Z2iKgWSEcvacbq3zzbDsIafqnTBURmNZXMgHYPuPlym0a8pN2ZAlLqXeNa1eQzEB8K3S5RHt3nBbkVhMoAcDJyFHAax2H8EyjqWQ46Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=POuHKrBRysvKjFQIj67RTfMqMYfCRMmYXRwvkWViUXQ=;
 b=h907qIMkwITzA4rgsGUHeIdGyqcNRyUgasK1sFITsi6fS+f77UOUFkAyZnHOXUnSvpksrg94Inz2sCiZMQW2nqk0Ahc1XgDJ7IT9bUsVYmGkZo8x5AF7gcOY3diKdWIh/OynNsu/BcqFteKx69ruEFLR940aZSnkWP+CLpMooXTBsjrTcWNkSxDUgexpATKzSHbGTtNGxXIygiTm0G+LcLkghqWbzHqurkIRWkKIhD0ovRygmz+P7Yjuj1lsGC28d6uBZEPybCbP+vj6mOchSu3btq12Fx6v8jt7MWo7CfBzoVBXLmXF5Id1zqW9bcsadwO1iUvgirvLxSFJu8gWfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=POuHKrBRysvKjFQIj67RTfMqMYfCRMmYXRwvkWViUXQ=;
 b=kfV/bkCgQP1FTX7LsV5as1JYEFE67LojiWiE3qpb8jCzhg0lROFnUehBd3UMWU171/JDHzhZk3cytHvKC5leb5MQ80bgATJYgQgOxms8Xz2amHgZqY8p8ZTNVqkdGvOzJqAirSisgc5+zM/p7Wdbir3u2vDouK4jfd3xNdXcuCI=
Received: from BN1PR13CA0003.namprd13.prod.outlook.com (2603:10b6:408:e2::8)
 by DM6PR12MB3900.namprd12.prod.outlook.com (2603:10b6:5:1c9::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.12; Fri, 18 Dec
 2020 22:30:04 +0000
Received: from BN8NAM11FT013.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e2:cafe::8e) by BN1PR13CA0003.outlook.office365.com
 (2603:10b6:408:e2::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3700.21 via Frontend
 Transport; Fri, 18 Dec 2020 22:30:04 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none
 (message not signed) header.d=none;lists.freedesktop.org; dmarc=fail
 action=none header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 165.204.84.17 as permitted sender)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 BN8NAM11FT013.mail.protection.outlook.com (10.13.176.182) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3676.25 via Frontend Transport; Fri, 18 Dec 2020 22:30:02 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 18 Dec
 2020 16:30:02 -0600
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 18 Dec
 2020 16:30:01 -0600
Received: from bindu-HP-EliteDesk-705-G4-MT.amd.com (10.180.168.240) by
 SATLEXMB01.amd.com (10.181.40.142) with Microsoft SMTP Server id 15.1.1979.3
 via Frontend Transport; Fri, 18 Dec 2020 16:29:56 -0600
From: Bindu Ramamurthy <bindu.r@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 08/14] drm/amd/display: Remove unnecessary NULL check
Date: Fri, 18 Dec 2020 17:28:58 -0500
Message-ID: <20201218222904.393785-9-bindu.r@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201218222904.393785-1-bindu.r@amd.com>
References: <20201218222904.393785-1-bindu.r@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d9fca74c-9f9c-4cc3-3dd8-08d8a3a47631
X-MS-TrafficTypeDiagnostic: DM6PR12MB3900:
X-Microsoft-Antispam-PRVS: <DM6PR12MB390070B49CD82DA720BE090FF5C30@DM6PR12MB3900.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CweeLqqyMCgGALBR/nq+DLtYwFiThFIUs4p2sBNpt/N2CUTOkDY0KuF4105DpnNJ6mqPUCVK2cDk0YjykiQgYxqHKjmbmUeNxtX5SvQO2My/LdZX/Fag7/k0Q7CooyB9+hDGuQUiDcsuN9WBEsiFTfIpa8ebBuLVfQs+tdQsN/mfT7xa4hChsidjvk4Jo9Qx1wdqkDZ9s9cAmZzdy9zxJ2Y/9K5//n1VdSwqI+XjpTUJrIHGKbji1QIHANj/fBAJGgAXBT7lucIG9a3HC4rQR0z5eFeo46bNAYLTL5R/z6gJLGPCuFL8cVISPYw1PFnNjqEAf3rkTgjbGeC3gldfMAj17nc5gdQOMEma0rvyQaxi1nnSSUqE5oYUeoQ0AKQ7vJ+FKA8jVi15JeBEhoRnBA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(4636009)(396003)(136003)(39860400002)(376002)(346002)(46966005)(356005)(81166007)(86362001)(47076004)(4744005)(70206006)(7696005)(82310400003)(426003)(186003)(26005)(54906003)(5660300002)(1076003)(70586007)(2616005)(478600001)(8936002)(82740400003)(2906002)(8676002)(83380400001)(316002)(4326008)(6916009)(36756003)(336012);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2020 22:30:02.5388 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d9fca74c-9f9c-4cc3-3dd8-08d8a3a47631
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT013.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3900
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
Cc: Eryk Brol <eryk.brol@amd.com>, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com, Aurabindo.Pillai@amd.com,
 Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Eryk Brol <eryk.brol@amd.com>

[Why]
new_crtc_state is already dereferenced earlier in the function

[How]
Remove the check

Signed-off-by: Eryk Brol <eryk.brol@amd.com>
Acked-by: Bindu Ramamurthy <bindu.r@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 245bd1284e5f..ff4776877e1f 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -9455,7 +9455,7 @@ static int amdgpu_dm_atomic_check(struct drm_device *dev,
 		if (ret)
 			goto fail;
 
-		if (dm_old_crtc_state->dsc_force_changed && new_crtc_state)
+		if (dm_old_crtc_state->dsc_force_changed)
 			new_crtc_state->mode_changed = true;
 	}
 
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
