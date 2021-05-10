Return-Path: <SRS0=4HPi=KF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2515EC433B4
	for <amd-gfx@archiver.kernel.org>; Mon, 10 May 2021 08:17:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3DA2613C9
	for <amd-gfx@archiver.kernel.org>; Mon, 10 May 2021 08:17:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3DA2613C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6AA3A6E425;
	Mon, 10 May 2021 08:17:37 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760044.outbound.protection.outlook.com [40.107.76.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9BA5A6E425
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 May 2021 08:17:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PORSimTls9Qlopc/J4eMPjJxDJzieU0BWFtntB9Oi9JdJYm2067WMTTYYdloo7IufZ4Jb9FcvKzsKJhmvybOMwRPki+yRN/kisfUlPTMZ+mO4D/NLAJtz6L/inG87qU2ZLzIYsZKBwd4l8QdLEMBCBiAcHRLup317ZmmBkICJuB/Co9LVq3pElelCITpxN+Rg6OD7mvUhhDewuPTEN0f9IAdLcCpDXORtJPllFbmCWvaCZfCjgRhreSmFcW1e+GacKI828H2ksSsN7uUv0inwhujxlr535AimR/WQhEW7dAvX3nPco/Kpxt5jeqUplSr+PMQtBZHqea4B1H1wJu1aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hvoiLGn8kcloqAwa9qV7q34pwnJOJeY56nuOVh6TSs4=;
 b=IAYxdx9rgraYYuE6obNB5we/bY/GNDHjBhl/01OoviPVcIclHCQeP8C5lMi3ljsEDdx0wdMEPv1MwZFWFaqUarkRbmYMctwB8ezdvczinR1BMw6ATbMne3N1ooA1VU0EwLhnbrtN2Kj+3BCXgLkqBnR1V3eKQMtl/fVxGP+ju4TfJQkVLQ3kMEG4yAkaj/kupEbVd1yMlxnzuqUZ3qs50csHcypedaVvg9wlp1TSh45O3lfvBdz1PhyzIyk9+BIUdsg49MwWuiDmEeP4cXUb/53iMt35lNr4zemNv0LU3KnDiKRhbpAaXtFniLXeiFwH6VUOAXh02TOJrjztueTn7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hvoiLGn8kcloqAwa9qV7q34pwnJOJeY56nuOVh6TSs4=;
 b=KiAwm0FqzZzHo+bY7t4Ux1AZ7dallMF6nOSYZmIBMXIJ9ClqFQtLR/ojRB4cuWpbJvmsnlup4aYQHxhcYNBW7WAGxgR3uITTzOjAinBsIhYMZB0VWCSk/WTONvQSmJjYNdzow5Pw5Yug7kKNiFSPHfsmfQAVRyEyWOek1uyCDeg=
Received: from BN0PR04CA0049.namprd04.prod.outlook.com (2603:10b6:408:e8::24)
 by BN6PR1201MB2529.namprd12.prod.outlook.com (2603:10b6:404:b3::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.27; Mon, 10 May
 2021 08:17:31 +0000
Received: from BN8NAM11FT022.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e8:cafe::c4) by BN0PR04CA0049.outlook.office365.com
 (2603:10b6:408:e8::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend
 Transport; Mon, 10 May 2021 08:17:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT022.mail.protection.outlook.com (10.13.176.112) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4108.25 via Frontend Transport; Mon, 10 May 2021 08:17:30 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Mon, 10 May
 2021 03:17:29 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Mon, 10 May
 2021 03:17:29 -0500
Received: from yajunl-gv.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4 via Frontend
 Transport; Mon, 10 May 2021 03:17:28 -0500
From: Dennis Li <Dennis.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Alexander.Deucher@amd.com>,
 <felix.kuehling@amd.com>, <Hawking.Zhang@amd.com>, <christian.koenig@amd.com>
Subject: [PATCH] drm/amdgpu: correct the funtion to clear GCEA error status
Date: Mon, 10 May 2021 16:17:19 +0800
Message-ID: <20210510081719.2638-1-Dennis.Li@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f9822832-2649-4fb5-5cc9-08d9138c0e74
X-MS-TrafficTypeDiagnostic: BN6PR1201MB2529:
X-Microsoft-Antispam-PRVS: <BN6PR1201MB2529A53B9C6222AFD720EFF3ED549@BN6PR1201MB2529.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1303;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K95DAoMANv1PMDqUU3o5M6SymB/0uWTgMbS+mwtQb7rCQNHvNWek7CQqm/+/Jcq8Ur/NZgASUClGAGuopvofpfKiarFWw6/KUUPF4SpQEKF/pSDK19n96i2dVNRN96RBXmgiqSWt0Ype+lcfd9mRCbtJYYzUnh3vIVNJbY7H77+SqryGeknlDrmXrKnFWnB0GO/JfzjqRDCnO0WEd0eoe/qJPuKmpyoHtme3uGJr2Z0GYRgQ4w0SeGnsB6n3y4ygE8DbAUiXKgko+ZxaJa56fqXKgOvYzi00dBsrAn9X/zWKpiB30mw69MrpJr997lEzbRrOrigk+wLglR17tt6BT2WXtrBgqpSLhqM1nImzVJljm843VFgUO3UBsGBorxWWCMMC7bBGtCl5uGlQZ4BJ1+1Az/EnmyeFyqDEgm9gsUUteEWu541s5/pZSSYRbkcge4lyZpVW+1NlSLWVh4/V350Z/UsgAmDoaiEZ4ghcqxRM/RQeGXngOYYzhut8qA38ZhEMoWt5FF/BSbbv7evhPdNIGMZEEqlX/KQgfAZ/2UPXq8LZqi6UkKLW2aJkiXqIunML2idDoxDkHP15AEdIQ/RWrl/+9yN5zXQIXxSLvGmisGsinkLzVMLT28oM0mHFzzF26h4+buXNWgIOYDdao9FQZ8QLqvJvre1kNpa1wWgGhUGDPIE4KeWCrsiDSAJDcrQHau7SdOXStuVFoH1LLQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(136003)(39860400002)(376002)(396003)(36840700001)(46966006)(2906002)(82310400003)(86362001)(7696005)(1076003)(36860700001)(8676002)(26005)(316002)(70206006)(70586007)(36756003)(8936002)(81166007)(6636002)(47076005)(426003)(110136005)(4326008)(5660300002)(2616005)(82740400003)(83380400001)(6666004)(186003)(336012)(356005)(478600001)(36900700001)(2101003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2021 08:17:30.8052 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f9822832-2649-4fb5-5cc9-08d9138c0e74
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT022.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB2529
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
Cc: Dennis Li <Dennis.Li@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The bit 11 of GCEA_ERR_STATUS register is used to clear GCEA error
status.

Signed-off-by: Dennis Li <Dennis.Li@amd.com>

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c
index e943cd2923ac..c63599686708 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c
@@ -1674,13 +1674,16 @@ static void gfx_v9_4_2_reset_utc_err_status(struct amdgpu_device *adev)
 static void gfx_v9_4_2_reset_ea_err_status(struct amdgpu_device *adev)
 {
 	uint32_t i, j;
+	uint32_t value;
+
+	value = REG_SET_FIELD(0, GCEA_ERR_STATUS, CLEAR_ERROR_STATUS, 0x1);
 
 	mutex_lock(&adev->grbm_idx_mutex);
 	for (i = 0; i < gfx_v9_4_2_ea_err_status_regs.se_num; i++) {
 		for (j = 0; j < gfx_v9_4_2_ea_err_status_regs.instance;
 		     j++) {
 			gfx_v9_4_2_select_se_sh(adev, i, 0, j);
-			WREG32(SOC15_REG_ENTRY_OFFSET(gfx_v9_4_2_ea_err_status_regs), 0x10);
+			WREG32(SOC15_REG_ENTRY_OFFSET(gfx_v9_4_2_ea_err_status_regs), value);
 		}
 	}
 	gfx_v9_4_2_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff);
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
