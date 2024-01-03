Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B93E4C3DA6E
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Jan 2024 23:15:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1484910E349;
	Wed,  3 Jan 2024 23:15:53 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2076.outbound.protection.outlook.com [40.107.94.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C372010E349
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Jan 2024 23:15:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UsVVC/7W9q9QLlznsg8u5yRNP/bS2k8BveTYHtqB6H6KMvl8P4uUpBHzDCL9i3/HjJGoOBXVSMqVz1/nvm64S8XoTP9Vo4UIHR5wOJ5Uw9H8mjFwgk1Ry6EK6OwiuECZWBpX8ilGuBk5/SHHuj4G4/qJEJ7/PGNCSyAu8/yBr1rndWxoTEqSKZ47bJnRxbUL4cIaTCUUw9+LQvwvAo2r8ZSMSjfLufdTYUcc9lXgLA6F1+2pFzVHRr0OpbxukrmtjvVqvL2GOmwxlw51F+MjVtb6mInKz43EsXk3qZgPzWASzSW4cIwLvMAU8RNJyw1xFOzbMmxHxkR9r5NozQq62A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ElsKb2l0kW0bNv3i4+s6fxLNwrzarDg3ok+BKpjj+gY=;
 b=k9A9KT+lCJeqvNS/qyzsrdhwX2wD1ru2UOXUlQkxGjKLhjzN3Iny3BFIvPIbvM20aBZW4iALDwCEWl33JlltFDdcf3XAMstWdpJqtf9/iPom5CWeBBH5UKW9Dot+8yQpSWtjygd5DiGI0+VTNV33a7bp2cfkTh4thr/WpAHefsHVSv3IiqZCcg3CgJj+fNBCgCO1fTugOjWn7UzvJQWk26+ENPBshPe8ItuIzSSMnyEnjhVZyEGGniDrlT46iz6vzOaXDx9E71zzRJ4TjjEmLRFCrmTJ5Oa60egCh2shznfma1Ogh/NXSD8RIOXREks6/cTKcetky07wDZwro5rmug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ElsKb2l0kW0bNv3i4+s6fxLNwrzarDg3ok+BKpjj+gY=;
 b=iGp0Nm+y1VSqKrXy2YPL5QjdwDnpSAYGBKRF0w4tUx1qwHx1P+RO1iC9Rb4iSDfyUR6tncN88XkWJAC8m41uq29w3t19ugiLP6W67dN7vv9/SzkZiGBNMo/CmK8MH4wUj8JQwJfWLk6gthWe3lQX0f50+8/hKhNbjqC1lQvbx5A=
Received: from CY5P221CA0068.NAMP221.PROD.OUTLOOK.COM (2603:10b6:930:4::39) by
 MW3PR12MB4410.namprd12.prod.outlook.com (2603:10b6:303:5b::24) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7159.13; Wed, 3 Jan 2024 23:15:49 +0000
Received: from CY4PEPF0000EE35.namprd05.prod.outlook.com
 (2603:10b6:930:4:cafe::47) by CY5P221CA0068.outlook.office365.com
 (2603:10b6:930:4::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.13 via Frontend
 Transport; Wed, 3 Jan 2024 23:15:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE35.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7159.9 via Frontend Transport; Wed, 3 Jan 2024 23:15:48 +0000
Received: from Harpoon.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 3 Jan
 2024 17:15:46 -0600
From: Felix Kuehling <felix.kuehling@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v5 2/2] drm/amdkfd: Bump KFD ioctl version
Date: Wed, 3 Jan 2024 18:15:03 -0500
Message-ID: <20240103231503.339427-2-felix.kuehling@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240103231503.339427-1-felix.kuehling@amd.com>
References: <20240103231503.339427-1-felix.kuehling@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE35:EE_|MW3PR12MB4410:EE_
X-MS-Office365-Filtering-Correlation-Id: 224ee669-4db8-4d52-4c10-08dc0cb1ec0a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: A35Ta+1mu93RcXhUWQHm/pVecAkdcB2KRioMW7rZMauxblXwKujP5Yi5S85gGJcFNIETOUaNYHw+b8Sc+O94vrR7z1/aWVHM2EpH7NGtjfxdiihuAN06DDyPgo72RpulxzK0fnLk/qAybH2biBSI/1+luOVpK7V3VAXEs7xwNPDRr9NAeLsnVoclbngeueeuuV4pn0RsnrDOL4Kz0ehk/IrT2mTBqYHyBciys1A/DA+uH1Tc19rR7t0e4kFqLs/UxYr9Wq8iM71jioyY6mWmB0LSGa8ob2RhxuAuzvt37Cxvju5O9TpGojTUxDTfOjO1ciJ3JGUDbMsqTW16GTH1FIluVyBWQHzaxcYlKeKnULUSuiQt6aJtmIFQlahH/0PnNzBWtnn1C4j2mG5AWTLNZG02XiAVyCMJpr1XsPd1CPfiJKWo1gxtENxZdG0kTIFimTKg+KKVom1FlQivJG/YoeDqswI7+7JaIi91nvXgtjjaUb02hOR9b8kFrybm9dHovktsFY9P6MaEc7Vr8NO5HPGAusSYvaeKB5EphHyIwGTgBvW65i4jCfUQrkwTDbYTLHrDsVTpRHMVzWHcN7g+LLwmwVFHBNU5N01qG9k3qZQz5OEViS3D9bpxKgUq+gxPecOaOw3ytW74pSDG/MIkMMXwxCbgL4xf8gbOSoIZ4cbTH7IThvrPGklc45/J9Ca4LPn8+KfYKoxaDmKfeoZ6Ft9Ow0lEpno5pa9aqPYvrISFH2lf1CI0vTYKa9kzXSOBxQkun+tKBPPpO8MNGAJ2LQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(136003)(376002)(346002)(39860400002)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(82310400011)(46966006)(36840700001)(40470700004)(336012)(426003)(2616005)(47076005)(83380400001)(1076003)(26005)(5660300002)(4744005)(41300700001)(16526019)(86362001)(36756003)(40480700001)(40460700003)(82740400003)(36860700001)(2906002)(478600001)(44832011)(70586007)(70206006)(316002)(54906003)(8676002)(8936002)(4326008)(6916009)(6666004)(7696005)(81166007)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2024 23:15:48.7360 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 224ee669-4db8-4d52-4c10-08dc0cb1ec0a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE35.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4410
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
Cc: xiaogang.chen@amd.com, christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This is not strictly a change in the IOCTL API. This version bump is meant
to indicate to user mode the presence of a number of changes and fixes
that enable the management of VA mappings in compute VMs using the GEM_VA
ioctl for DMABufs exported from KFD.

Signed-off-by: Felix Kuehling <felix.kuehling@amd.com>
---
 include/uapi/linux/kfd_ioctl.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/kfd_ioctl.h b/include/uapi/linux/kfd_ioctl.h
index f0ed68974c54..9ce46edc62a5 100644
--- a/include/uapi/linux/kfd_ioctl.h
+++ b/include/uapi/linux/kfd_ioctl.h
@@ -40,9 +40,10 @@
  * - 1.12 - Add DMA buf export ioctl
  * - 1.13 - Add debugger API
  * - 1.14 - Update kfd_event_data
+ * - 1.15 - Enable managing mappings in compute VMs with GEM_VA ioctl
  */
 #define KFD_IOCTL_MAJOR_VERSION 1
-#define KFD_IOCTL_MINOR_VERSION 14
+#define KFD_IOCTL_MINOR_VERSION 15
 
 struct kfd_ioctl_get_version_args {
 	__u32 major_version;	/* from KFD */
-- 
2.34.1

