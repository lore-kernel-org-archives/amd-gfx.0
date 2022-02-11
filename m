Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60011C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Feb 2022 21:52:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C1CFD10EB44;
	Fri, 11 Feb 2022 21:52:12 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2049.outbound.protection.outlook.com [40.107.223.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0D2E310EB44
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Feb 2022 21:52:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oFDW3/2CotYoGCn6VsSM3xvdVRjoHwB/Gc91qAGjV7KUDXyXH+GJNsAcQIcHK3mKIYPZm2F64U4/xVqoRP8ZyEMRhLAFWBcxjSFbh9QzQ2l+h2R9QIZl0i8QTYpIwt/W4bYs+9lGS9m/3zd5ywUkloSZ8xYwba4KcKtoTOQlLiFRFFdQTuL0QnfN/FS2Du/lLPG/tjnSZEwMfS0sWJ7jC9BDKusf7x1oBfcs4cAZZbGd+xqB6ZDKLneWxtZOtj7Q4ur2LWCm0f3mawBgxp/SxawqfjPmj6TiPCOIfeSdhepZ2VMyWp+IZl0nN2BwTBNSyNyXZ5ywjnP0siOgNkqvEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=43LSOSyxfpg94DX+PYQvb8DRyXb4RhqRzs5BhWj7d8M=;
 b=PjsM08lOnAOykyscapdGjoz+vFkEzo0qrVFlWgtRxuAzGIvsvDltxVkpcf4EXazcADZ3gFMQiXKtAs+u+eWXNAK7MsamgO/O0+ceQxjecGX5UIraTUkfT+X4tPUqsHlyqOSTF5XPPjJKb6i0JnJ5KnCRmEDlIqGhd+ANpMfy49ChcEsLDEu4T8Da0E6eyQBR9Id1Bl3ZaBw9z4kWtkJ+uwON0gg9vYu3F/+gFekhCmb6cLTaA9Oe40eGg+IFkt8Mwmo3LM+1y+5DLLaCcotzZhdfNo9GsIrvabj0gyt0yPwL0VMcwKlQhuiPEtfIq3EsY4kxmkerUKNCo63FP7iNZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=43LSOSyxfpg94DX+PYQvb8DRyXb4RhqRzs5BhWj7d8M=;
 b=X+KZx522TiTgXrxluoYix/gx6wg3rrjw+tbYf4UPqY7zKVzelwZMb4rgRTf+3gWnrgF/77w4XZpt1wmZU8JQaTFwo+DI/gWbPmfE/jK+db7TT2B7lmlEBl5+2fN+zKuccEcmGCzqBYsak8lcFiXZeUjt7YQB0wgFvl8dQBYko28=
Received: from MW4P223CA0017.NAMP223.PROD.OUTLOOK.COM (2603:10b6:303:80::22)
 by BN6PR12MB1905.namprd12.prod.outlook.com (2603:10b6:404:fe::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.17; Fri, 11 Feb
 2022 21:52:07 +0000
Received: from CO1NAM11FT063.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:80:cafe::3e) by MW4P223CA0017.outlook.office365.com
 (2603:10b6:303:80::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.12 via Frontend
 Transport; Fri, 11 Feb 2022 21:52:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT063.mail.protection.outlook.com (10.13.175.37) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4975.11 via Frontend Transport; Fri, 11 Feb 2022 21:52:07 +0000
Received: from jasdeep-System-Product-Name.hitronhub.home (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Fri, 11 Feb 2022 15:52:02 -0600
From: Jasdeep Dhillon <jdhillon@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 05/11] drm/amd/display: enable z9 denial interface by default
Date: Fri, 11 Feb 2022 16:51:36 -0500
Message-ID: <20220211215142.94169-6-jdhillon@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220211215142.94169-1-jdhillon@amd.com>
References: <20220211215142.94169-1-jdhillon@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d6c2228f-5174-47c6-d288-08d9eda8bfc6
X-MS-TrafficTypeDiagnostic: BN6PR12MB1905:EE_
X-Microsoft-Antispam-PRVS: <BN6PR12MB190553F5F6ECE85C9B291D19FB309@BN6PR12MB1905.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2449;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Xrvd5rdjkGBwFuwVcmVt+V6vGwwnUUryVGmpUzaNNsl+w6PSEuncNO1Ty3Q48cuzIlKzYlAu8DUbM6qoP8IUYA7LmPkiRtLmQdKkNGbhNbqYL57xdIHqN2nB26JdjqUBzTPMFmuVqKkzelZvfaTlV/EnJOZtOofaiZXGNC/6D29MAxyaHSd2GbGOhODj8w1sajAPANAMRFzsE4CO/0M72FOD4Rdu55wf1UhaiLEiyZ4r55C/zsDwVlqW6CbY4HQidxbQdjRsILSqsAXikEA9ueZAH2vFDfRsaaGsFu/NThLrtd4/zpKOfqTjv+cacM+T9cgD8NSqkd9brlHOPpdu7eAuYkPGMYZDLeDc/UWXvIRkuXHRI1hutMuAvY5kRLAXYgK1FXEi4gXJswt+9CgArp7KslKVUg/qaZW2fIxOlwBEyLFQ0J/n5xCYGBPssSumWxJBfpx+pL9h5WcZDvn8phIetJsnsDEO09Akuii3ssU9NoyPJYFOosFFJtA6+MeapATfwtxvg8K2VmXz9faFCwgdS+63SV5vvhcNs8uQSloEbXszWa/cyQcn+agacp9LnsVCV0Cv+iwtomL8/UgvdN9biockZ9WA93Dq8Tgxuu1WsZcJoZnrUYn4RBrawvW6sJxBY0T/PFyx6leffLFGjB1E6VUvH3e0zDg5slEtCB9wdKAjVITzEJypOyGZ+CSMf9fWEKF8aOL4BBc6zi/MoA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(5660300002)(2616005)(36860700001)(70586007)(70206006)(4326008)(8676002)(8936002)(6666004)(4744005)(82310400004)(83380400001)(47076005)(1076003)(16526019)(186003)(2906002)(26005)(356005)(508600001)(426003)(336012)(81166007)(36756003)(40460700003)(316002)(54906003)(6916009)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2022 21:52:07.5215 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d6c2228f-5174-47c6-d288-08d9eda8bfc6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT063.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1905
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
Cc: stylon.wang@amd.com, Eric Yang <Eric.Yang2@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Jasdeep Dhillon <jdhillon@amd.com>, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Eric Yang <Eric.Yang2@amd.com>

Reviewed-by: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Acked-by: Jasdeep Dhillon <jdhillon@amd.com>
Signed-off-by: Eric Yang <Eric.Yang2@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
index 007a7dc4f5be..5f5c21a2023e 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
@@ -1033,7 +1033,7 @@ static const struct dc_debug_options debug_defaults_drv = {
 	.optimize_edp_link_rate = true,
 	.enable_sw_cntl_psr = true,
 	.apply_vendor_specific_lttpr_wa = true,
-	.enable_z9_disable_interface = false
+	.enable_z9_disable_interface = true, /* Allow support for the PMFW interface for disable Z9*/
 };
 
 static const struct dc_debug_options debug_defaults_diags = {
-- 
2.25.1

