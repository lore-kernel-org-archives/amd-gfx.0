Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5ADEE8FDD8
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Oct 2023 07:40:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3826A10E33E;
	Wed,  4 Oct 2023 07:40:11 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2042.outbound.protection.outlook.com [40.107.92.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ECED210E340
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Oct 2023 07:40:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jyfayYFl2JXhQqNoTsW+bzb93LtPTzWJ1WF9Qm6CZDvAXqE/zwAiauBVLN3hXRwMLH+J9abFA1Ee035/pyF0DF+VW8EDfInIDl+tqUijzy1dyJE8EQn9Ge7GnhfvsbppMytU3Kp6+rs/KBaPemg6buSMKvigdoUh0IgcbnAW7LB/VJWG4kAHOHSK6xzNokwfDBBI7r9yX1I0+EvY2N2kXz/N6JVhDex/jxyVUWaUTlL36VYb4e8rZi84jb/dgkMVE+L/mkxYf4OGIg8sgAvPYkDA/xVgiG6LUcHwWlQRHowjHSqrqp2yxxt9kG34QkS/mD/GaLaFuas+oClbFhHIfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U2nARm3/eu1CJ6Uq737NDWSfCaswCucJzrS4X6uZi0s=;
 b=OMjl5+xDDBHQYr8/10lpRs43LbsjGZtkHAnhCCEi+jgKGcvTUhjeZrEs+2U5tXCF1w1CLi/6cp7eBRDFLFgh+4hg7+mAVn18TlPyODkGdFbH33HT5ATCBorEmnSjat+eOdwgdogAoQfUddo7ThNFIXz8B6063kLaBbsTiwxMibkhyU/6ZBDwAXPeQhzUPFBBBN8NsknbXt7szj4yfnGQLutNMQTzDF5zrGD4pE7iYdagUskSQXA/wjg4sXJmjOO2WU/8npiDDv2pVhP8ozCDVM6qmVWiD0hq4bppjoQybS8r5mNa7yWf3i/VD+VbXDjM2o9r50MIobKjXbsHagYMJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U2nARm3/eu1CJ6Uq737NDWSfCaswCucJzrS4X6uZi0s=;
 b=byNvOuGEMYpN0QX8j7TVZtuV/aT6jKqMuIaw8y24UU6RscoTOG05J74GUf2xC1+POaySPqyVFNfWkPpsS6aef8NglahLk5Do/99IJj49hAgEtIDUYp709qQwaF86C/05pgAxwrgg9F4nH6Aku5SoqhjLaFx65NJWB9MszMsIKtY=
Received: from DM6PR03CA0008.namprd03.prod.outlook.com (2603:10b6:5:40::21) by
 CY8PR12MB8313.namprd12.prod.outlook.com (2603:10b6:930:7d::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.30; Wed, 4 Oct 2023 07:40:05 +0000
Received: from DS2PEPF00003440.namprd02.prod.outlook.com
 (2603:10b6:5:40:cafe::b7) by DM6PR03CA0008.outlook.office365.com
 (2603:10b6:5:40::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.26 via Frontend
 Transport; Wed, 4 Oct 2023 07:40:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003440.mail.protection.outlook.com (10.167.18.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Wed, 4 Oct 2023 07:40:05 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 4 Oct
 2023 02:40:03 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 4/5] drm/amdgpu: Add sysfs attribute to get board info
Date: Wed, 4 Oct 2023 13:09:40 +0530
Message-ID: <20231004073941.1489693-4-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231004073941.1489693-1-lijo.lazar@amd.com>
References: <20231004073941.1489693-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003440:EE_|CY8PR12MB8313:EE_
X-MS-Office365-Filtering-Correlation-Id: 620c6217-81d7-4f65-cc06-08dbc4ad205d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mQ0NMocxDwO4ksF57zSLPWJvAgUwRoP4nlwGfwGZEwAmpScdQq6A+Nlcaa/ihEHzd1MPrNc/JSTluFCescK6zW6cr9BQkZabt1Qb3IyMTozCHkWEBx1UXPAfs/2Ww5NB4ydUf0H+8hNrLVX6juxp4JD8K43/yCrjt1e7oWet8K6hgick0P89MSTf3sfLTTw9LSL93C6c/Ad1wC8QGA6G0lWQWAXN4klCzwZTpJQdRDbVB/NZelOBBP+P3n52acrX2uUjE7NyOH9Kbpk4ExRkZgMecnw8FPtRMV0zFOd/iq7CeyISyPUiOO2S64LX8DEPmWaIf4z3YLskEOAUOBYe4eORqzG3wzk6HzlZGNIbL5aJ8UbD0MAjTx3/B2ly0cfsSr6nu7zTxEZvZmOPKL3hCrQ9l6UO+Y9ld3lgIGl6a08eh4oT7SFqu3DIDKYdkH9dGSJAOGcXijPwwpLrXqwkTBC9m6cJE+KL75wfph54Miu0WPuGQxTtpagCPbX6ECo+USI+oTiaxApA85zWVmvR14ZNTN4vL0wZ1n8PO6OFyS35yb6ZYtRC/dvU1y3oPoeyCEEX5exZAbRJYjC8CtmEc4ls3TGXQD15BdKTAUmADoslJaicrGVBhvNkvGZGxwlLmQ6LPi2UFFvUGZkoLZBJnDwgDLaAmBaAZo0nSm+1V2j5Z8JhgOdvxT/53CPeF7sAwi7jth/4vRy9hRvUAXaQz6pwjd79jKUa4aYFnT2MBo6T+KLG3uBGTcO17ZbJ1pqbfj/d5Ny9A48d3ehU22FRcw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(136003)(346002)(376002)(39860400002)(230922051799003)(1800799009)(64100799003)(82310400011)(186009)(451199024)(46966006)(40470700004)(36840700001)(36860700001)(336012)(478600001)(7696005)(6666004)(426003)(2616005)(16526019)(1076003)(70586007)(41300700001)(316002)(6916009)(8676002)(5660300002)(4326008)(44832011)(8936002)(70206006)(54906003)(2906002)(36756003)(82740400003)(86362001)(47076005)(81166007)(356005)(26005)(40480700001)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2023 07:40:05.3836 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 620c6217-81d7-4f65-cc06-08dbc4ad205d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003440.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8313
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add a sysfs attribute which shows the board form factor like OAM or
CEM.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 57 ++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index bad2b5577e96..10f1641aede9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -162,6 +162,58 @@ static ssize_t amdgpu_device_get_pcie_replay_count(struct device *dev,
 static DEVICE_ATTR(pcie_replay_count, 0444,
 		amdgpu_device_get_pcie_replay_count, NULL);
 
+static ssize_t amdgpu_device_get_board_info(struct device *dev,
+					    struct device_attribute *attr,
+					    char *buf)
+{
+	struct drm_device *ddev = dev_get_drvdata(dev);
+	struct amdgpu_device *adev = drm_to_adev(ddev);
+	enum amdgpu_pkg_type pkg_type = AMDGPU_PKG_TYPE_CEM;
+	const char *pkg;
+
+	if (adev->smuio.funcs && adev->smuio.funcs->get_pkg_type)
+		pkg_type = adev->smuio.funcs->get_pkg_type(adev);
+
+	switch (pkg_type) {
+	case AMDGPU_PKG_TYPE_CEM:
+		pkg = "cem";
+		break;
+	case AMDGPU_PKG_TYPE_OAM:
+		pkg = "oam";
+		break;
+	default:
+		pkg = "unknown";
+		break;
+	}
+
+	return sysfs_emit(buf, "%s : %s\n", "type", pkg);
+}
+
+static DEVICE_ATTR(board_info, 0444, amdgpu_device_get_board_info, NULL);
+
+static struct attribute *amdgpu_board_attrs[] = {
+	&dev_attr_board_info.attr,
+	NULL,
+};
+
+static umode_t amdgpu_board_attrs_is_visible(struct kobject *kobj,
+					     struct attribute *attr, int n)
+{
+	struct device *dev = kobj_to_dev(kobj);
+	struct drm_device *ddev = dev_get_drvdata(dev);
+	struct amdgpu_device *adev = drm_to_adev(ddev);
+
+	if (adev->flags & AMD_IS_APU)
+		return 0;
+
+	return attr->mode;
+}
+
+static const struct attribute_group amdgpu_board_attrs_group = {
+	.attrs = amdgpu_board_attrs,
+	.is_visible = amdgpu_board_attrs_is_visible
+};
+
 static void amdgpu_device_get_pcie_info(struct amdgpu_device *adev);
 
 
@@ -4038,6 +4090,11 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	if (r)
 		dev_err(adev->dev, "Could not create amdgpu device attr\n");
 
+	r = devm_device_add_group(adev->dev, &amdgpu_board_attrs_group);
+	if (r)
+		dev_err(adev->dev,
+			"Could not create amdgpu board attributes\n");
+
 	amdgpu_fru_sysfs_init(adev);
 
 	if (IS_ENABLED(CONFIG_PERF_EVENTS))
-- 
2.25.1

