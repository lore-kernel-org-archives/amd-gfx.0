Return-Path: <SRS0=JmOw=7V=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07186C433DF
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Jun 2020 10:53:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D08512072F
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Jun 2020 10:53:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="me7Jm6rK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D08512072F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A18D48933D;
	Mon,  8 Jun 2020 10:53:42 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2047.outbound.protection.outlook.com [40.107.94.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 281C26E311
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Jun 2020 10:53:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UiZtMfYcTXi2KuEEsEjYVOQOAloJ0yOEdLF23PAl34qHf8No+k6MDskW42HvTvyZIcD0xYcRDxKM01aqSp7+Mqu8qM1iSVbmiwNvkhp3Ssi7dOTNYuBeNsRqPpOmQxHj/1/L/cLg0sfCm1xP1S/TitAjNBXZ/m+DPEWconz0yvZshbryn/12islz8K4/MoVcYNb5iQ7CQDHyXXFP77ac9RdCzqXZ53sQ/31PpA7rHgSQfacspoKrRVVxUKhNKAhcyzYVCqlKoHQhDgl3X6bx7a3D9As4d1WUSDes1Y85dZ5jkFUhF5YymvkoOQ/rz7r9mhBy3WICd9JnykifMKnqeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kssGpeb3S290+KKlua2CDTHc0mwh53ypnfkNRwqYpzs=;
 b=lwNpXjb6GWnEHwewDjpxe3cTjneRoVrKUG9X4cEgQspdr9NIejnPVP/7Zszg06ps8tKfGHfkSR1gYKXmeukU0E7+ca5qA35nHj67RSMF2BzzMujHx5jaDbUnYO8bf/WnimH7GQckz5ulIEE0w4RVZHeuFfiWhLcfWfAS8Ly1LcWhKt54qYuJEW7EWdHZIu8eogLvGk26RxBkeFE8JpRKFszkj2k95pl58Wd9kM4P6Mu2lJrjfTvnZmy4AiJNNBpdBsyjoXHQ7PQKb4eh8coGbKrsAty0qnJtIzEaYj82DGLraGmlCVCbnvh/GO8DYiLLj9eUarZqDSRlTL5eMiO6XQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kssGpeb3S290+KKlua2CDTHc0mwh53ypnfkNRwqYpzs=;
 b=me7Jm6rKnvOfrUVHgvnYu5jLB+VEOrV4T1a88TSXeEiWF4ioig/99LCNNNDCPOTnPfQ56Bkwz8K0bb1d5y120/2TJ6BZF5afK5avNxmam5NRhmfAfzX2B80ixwX8Trv4bj0gVwnehlrdnLLTust4GkUs7QGBNECAmskNqiTiIxE=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB3546.namprd12.prod.outlook.com (2603:10b6:5:18d::17) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3066.18; Mon, 8 Jun 2020 10:53:40 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f%3]) with mapi id 15.20.3066.023; Mon, 8 Jun 2020
 10:53:40 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 7/7] drm/amd/powerplay: add check for power limit OD support
Date: Mon,  8 Jun 2020 18:52:34 +0800
Message-Id: <20200608105234.29864-7-evan.quan@amd.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200608105234.29864-1-evan.quan@amd.com>
References: <20200608105234.29864-1-evan.quan@amd.com>
X-ClientProxiedBy: HK2PR02CA0189.apcprd02.prod.outlook.com
 (2603:1096:201:21::25) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (58.247.170.242) by
 HK2PR02CA0189.apcprd02.prod.outlook.com (2603:1096:201:21::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3066.19 via Frontend Transport; Mon, 8 Jun 2020 10:53:38 +0000
X-Mailer: git-send-email 2.27.0
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2841c8ef-d3f7-48d9-54f0-08d80b9a33e5
X-MS-TrafficTypeDiagnostic: DM6PR12MB3546:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3546F4643318133C99FBBF12E4850@DM6PR12MB3546.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1051;
X-Forefront-PRVS: 042857DBB5
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: J+v8FEyLv/rtNJiViZdxfFdUr2fsEaAMdMCw0o6qAC7iCPiHZVdJcvsI+RoxCabTD01QpuqDyWsKyHSxdkMkBLGZ1xykcXVp5ASCG5hQIlGZrmsKUe226KOKeDh5AdrqMqTx9An3S4YTOB34zJxd7Gx0/Drk7fB/E1/fjVR/Bdi6JPwJXijE5CtyvlAtqPSZSqSbHAuNlpeww+K8MlwJwQoYSx/ix3pcBrpImAr5PWGPxDiJb9VKD+2n7Sik+GHMTk84vr2lDy3I85v0gIZToaZPYrrTW6t9AVIrjaP6MU4icQcg80ucZ2+2l1vfWE/D
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(136003)(396003)(39860400002)(376002)(346002)(66556008)(2906002)(66476007)(6666004)(6916009)(8676002)(956004)(66946007)(2616005)(8936002)(26005)(5660300002)(44832011)(4326008)(86362001)(6486002)(478600001)(83380400001)(316002)(186003)(52116002)(7696005)(36756003)(16526019)(1076003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: /0wjtZYUuBreTyAW+VY+CC8IyE5dQemSisLS6ImLMyKafzklwCRr8I8hrnF2wa4LesF1wW4K+QsR2VANn/KapMvJH6KGgkt0Vbz/JNr4VWXqKLULTq5ron5w9Rxq+lkvBT6NvDrwAjp8ra/J3hSV8bsaxu9ufqAAe+j/nOBQqMJbzR7QujNyGuIcUr/9TfGTq81ZudyLGGm8sj186FnbcAC43YbNbHtfU688XV6Dlih7VNkXD1EE1JIgJAOk8JWMWOiM7oZstb48RMi/eMqwr8696aOcVWHNh+P/KxjyK1WXm8ea/m2q/TjE55TrU0+PwqZIn7OiHgrHNWzjuCE5XAdD+TEqYEyW95ZoVLpy9H+lzMmtTS9COTu4HZg6MZ/LYDDxsUBj8ASY9v8lXREWRO2laRlkqrKAjsyyLQ2602cDk9Il9VpKyBGGX4buPOGLPlB7NIZoJqwEce5c/xHEE/znLVo1y7afSlnm48cJXKp+zBP/2vjIp3rxbGXMBuVP
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2841c8ef-d3f7-48d9-54f0-08d80b9a33e5
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2020 10:53:40.2608 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x1AVl3QsWiX8EvkKCBqLwtWMtDEAZWPOfFm5rzLOEuBAZHa+i3R39bJ0FEsEZeze
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3546
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
Cc: alexander.deucher@amd.com, Evan Quan <evan.quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Before counting the OD percent into max power limit margin.

Change-Id: I83b24d614e07fbc5eac41ff7cd668a1c2f33c6b2
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/powerplay/navi10_ppt.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
index 186cdf6696f8..115794557190 100644
--- a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
@@ -1920,6 +1920,7 @@ static int navi10_get_power_limit(struct smu_context *smu)
 {
 	struct smu_11_0_powerplay_table *powerplay_table =
 		(struct smu_11_0_powerplay_table *)smu->smu_table.power_play_table;
+	struct smu_11_0_overdrive_table *od_settings = smu->od_settings;
 	PPTable_t *pptable = smu->smu_table.driver_pptable;
 	uint32_t power_limit, od_percent;
 
@@ -1934,7 +1935,8 @@ static int navi10_get_power_limit(struct smu_context *smu)
 	}
 	smu->current_power_limit = power_limit;
 
-	if (smu->od_enabled) {
+	if (smu->od_enabled &&
+	    navi10_od_feature_is_supported(od_settings, SMU_11_0_ODCAP_POWER_LIMIT)) {
 		od_percent = le32_to_cpu(powerplay_table->overdrive_table.max[SMU_11_0_ODSETTING_POWERPERCENTAGE]);
 
 		dev_dbg(smu->adev->dev, "ODSETTING_POWERPERCENTAGE: %d (default: %d)\n", od_percent, power_limit);
-- 
2.27.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
