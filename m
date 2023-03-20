Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EED76C6FD1D
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Mar 2023 17:38:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 63D9A10E600;
	Mon, 20 Mar 2023 17:38:33 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2088.outbound.protection.outlook.com [40.107.96.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E7B1110E600
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Mar 2023 17:38:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X1xL0c3s6/3S3J43Z2rcW7QFKK/y94OTWT34GjwfVHnftTmwNI/xj9lx0OUpoWJqjGVmVzQBJrzVkoENh9XY8s8moeWZvDxqyFVZn7t1Esz3IM1SIK0gVoW45KR6Mkad6vxnjwh//j/XD3P+bpejXgnLQ0zF1XFQieHQz+tsRLa+wQ3SesCxdMTmsGWnPUi1IrwsMrYX5Bn8WR4O3Hl9oCP3mbyvla4UoxuTsrJKxT2WWxnux0N60EoCkpcPf67cKsr8KMjY7RavzfHNMIuF/XMB2quomRYfo0j7KjG/QF2QqnEup1ke1x/dhbO8hBS54ZA3UzHx5vW0GtSqma9Klg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kQ1+AQub+8tqgyceDqesPZdzz3RulNBrz8CniU/DIzI=;
 b=EGVU4O/tsuS6HT4SrSJfuhiJP7soQBnZVv6kCTkwwlmVOZA43jjz9XEdk8jtiKuwh5k8in/K7XFjB/9u6uluW5nbv+67e4GWpGhKCBswxCBA2RNNZZRgkLNY9SAueiOiKFdBe3KYNGoCeMe1+VswBtQ4P1LyZWFm8G5fsHkRmQb7HZFwramN+KGzUNo6ZIB4ZfHEjqqirciJqUvY+H/0Oj6SEmJcwc+FgWv0NQCLGB+fI9lNuusw5uonXnTmzdWdf6uz6TsaF0hEay86c4iWduWUw6f0SxUgDwowLZuvnVNBxebnLWOqqQbGgjfz0Y0yVrKP2rDLZYd/yl+cTNKx7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kQ1+AQub+8tqgyceDqesPZdzz3RulNBrz8CniU/DIzI=;
 b=CD8RJm8ZMtvzOQyOaMvKIvVbY+zQmrIz5BnW2hGrEmAxGdvaW42oAqiVTPqjWWcLir3KZBJHbLZ8xq7Whn7PqHmQ5RcGlDsGmx09w5ZphjR3oNKcllqTi9/Kl2Jx8NVC/0kOHNqn1u/uXhJunuVFAcGc4xCpFWGFQr9xc0HxMSI=
Received: from MW4PR03CA0171.namprd03.prod.outlook.com (2603:10b6:303:8d::26)
 by CH2PR12MB4152.namprd12.prod.outlook.com (2603:10b6:610:a7::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Mon, 20 Mar
 2023 17:38:28 +0000
Received: from CO1NAM11FT078.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8d:cafe::c9) by MW4PR03CA0171.outlook.office365.com
 (2603:10b6:303:8d::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37 via Frontend
 Transport; Mon, 20 Mar 2023 17:38:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT078.mail.protection.outlook.com (10.13.175.177) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6222.15 via Frontend Transport; Mon, 20 Mar 2023 17:38:27 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 20 Mar
 2023 12:38:25 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 02/11] drm/amdgpu/gfx11: check the CP FW version CP GFX shadow
 support
Date: Mon, 20 Mar 2023 13:38:01 -0400
Message-ID: <20230320173810.250835-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230320173810.250835-1-alexander.deucher@amd.com>
References: <20230320173810.250835-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT078:EE_|CH2PR12MB4152:EE_
X-MS-Office365-Filtering-Correlation-Id: 3bf8fb66-7885-4f42-06c7-08db2969ea21
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 96q+RY702cB2OiedSfQ5q7Xj5YkxO9f0fU55vp2KRyR6OP0wofjqDmNal/GOnob9ZqnXscqoCr3RIn7xByCHBfA2LpF6UwykfNy3SsmVxbhCSSDrQUu8r+X1oCqYDlDYHYxSmke8nqLuBKuoDBny3G/qwJYRqiT9zlQD7TTjQz1CPlh1uGHrV25Kl3Sujo94tTPbEZ1XG58Z/H2lh5spcqBa8TLQMS5j1rshCSl2yhpR/QSHN8jBmB71i6uhH3sbDZGr+lFtayBDOKvH+lmNW+PXf0TmQr2mJpENqmPMzWXBLLHd9pXtwKMdAwIqgIUP995xgsPBTyvEUet1yBDnkUARAOEan7/2KGJCAolyCuMmwLPwZN7kz83WgzbJ6+T1FMQj3ijVQYqfQc8q3rn/M7QNqqVMId5GLTbyqeWOEQPcAUPg0NgO81s1umcitoPypQFlx5jRixObZ0kEQjGhe88vgD8S7vjEqcqD68AHs0NlCy881490Bgbht3wPQVc8AgLSmxXuUrkWqAERnOrlXaQCt7i46EzloqarGHAsfT3ZO26MeYNlaZUqBMi3CyTDXQRF+22WHuVqN9qtS6x3DsP9Ck9AHeLWyUYONRHSE+LMPzrsrayKN4KxA7BkbPIMsZ9fvRGElovXH97xEUmM6ykCEdTVqcUCWCW98+WW+SzaiBhApJFeOJuNBeRiXbv0ifB+ipfOTQ048Lxo2fyON5UqZhxnKB3VcFo9DJl2f8XfHyjxSqarpzAbnDAjh5bw
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(346002)(136003)(396003)(39860400002)(376002)(451199018)(46966006)(40470700004)(36840700001)(8936002)(5660300002)(36860700001)(41300700001)(82310400005)(356005)(40480700001)(86362001)(40460700003)(82740400003)(81166007)(2906002)(36756003)(4326008)(426003)(336012)(47076005)(6666004)(478600001)(7696005)(2616005)(16526019)(186003)(1076003)(26005)(8676002)(316002)(70586007)(70206006)(6916009)(21314003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2023 17:38:27.7832 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bf8fb66-7885-4f42-06c7-08db2969ea21
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT078.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4152
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Only set the supported flag if we have new enough CP FW.

XXX: don't commit this until the CP FW versions are finalized!

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index a0d830dc0d01..4a50d0fbcdcf 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -469,6 +469,15 @@ static void gfx_v11_0_check_fw_cp_gfx_shadow(struct amdgpu_device *adev)
 	case IP_VERSION(11, 0, 0):
 	case IP_VERSION(11, 0, 2):
 	case IP_VERSION(11, 0, 3):
+		/* XXX fix me! */
+		if ((adev->gfx.me_fw_version >= 1498) &&
+		    (adev->gfx.me_feature_version >= 29) &&
+		    (adev->gfx.pfp_fw_version >= 1541) &&
+		    (adev->gfx.pfp_feature_version >= 29) &&
+		    (adev->gfx.mec_fw_version >= 507) &&
+		    (adev->gfx.mec_feature_version >= 29))
+			adev->gfx.cp_gfx_shadow = true;
+		break;
 	default:
 		adev->gfx.cp_gfx_shadow = false;
 		break;
-- 
2.39.2

