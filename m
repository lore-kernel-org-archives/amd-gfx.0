Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D45AC433FE
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Feb 2022 21:52:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B591610EB45;
	Fri, 11 Feb 2022 21:52:13 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2060.outbound.protection.outlook.com [40.107.236.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2973210EB44
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Feb 2022 21:52:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Js4UkSzNMl4BtzaWY9zv5kPgdM6Zqxi4wadXOObrsVxNWq8pEn1znrRKDmNOfx3GWbFTdDmuKVG5bO/Pb30PPsao7jMF8UeLSsxCuhJE9EIhjIqHLuzuta4yR1C7zwT+Mh8jmI0MU1PbXGnJGNX8DCYyxNpIXMY4NYqYV6u0ZiA4jBbD1CW9ZVW2csknqt0CpOcZKzus36DnQbFPvv2mHHTkqG6B1WCP9dCgd3ro0WqgYDyYmt7BNX5jbCjVIKZuuhQrb03pDLbKzvlmPmFN1NidI5GOqA4uY9rYHZR709ACfADvJV0vasnK2aLPKb/3pV874m+7cgIUjJnXYpc+DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zrCMA5c6MV+vTItrO9QYDhCWKV35eWnLo+OYktXkJ4U=;
 b=iJk0I+pfp0GALGw77M/+vI9zjzKzFv6n6xF7ZkcNw5Keo1QVn/ZaLkeUyqH4V658Q4jM+EqKNucd1ym6+UFE2G7RFlcXsrRHf1Hu05UaWPb/MoJFnsC8FeMVEGnu8FGsseuiU9Ha0zam5aAoIDUBpPjxfPF+zN1c9IR51VYyojgKyUsJ4J3V4qfwd+RDNp6ujEOi4C+UuwRAXdAa+TnQCBXkV6TS5CXAzmHsawMSATPrcKePBMZv6UvO6hbkc/KH21zu7r6d/yAq1kOShyUZ3RZygE8z+hCsEww9TnQ62bM9h7gzwsapLNh5w3wFkOaHudEHZI7R07nVArRKAUwBvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zrCMA5c6MV+vTItrO9QYDhCWKV35eWnLo+OYktXkJ4U=;
 b=Fkp+IlrlIRKe/MyA/JbgzJBkL6uUl1uJxQVDWgG9ctv+PDaOuQYrWRKyCmu6oWAVujgVNML26jtmItsUjEX3qjdsU8pN+u1suiw3xZIyID3NHArWRIDZzpTVmHOhAY/908a/VZwaricP/m3iGpXzPVopkIGpR8/zv7SSML/cvZg=
Received: from MWHPR14CA0013.namprd14.prod.outlook.com (2603:10b6:300:ae::23)
 by BL1PR12MB5302.namprd12.prod.outlook.com (2603:10b6:208:31d::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Fri, 11 Feb
 2022 21:52:09 +0000
Received: from CO1NAM11FT026.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:ae:cafe::95) by MWHPR14CA0013.outlook.office365.com
 (2603:10b6:300:ae::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11 via Frontend
 Transport; Fri, 11 Feb 2022 21:52:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT026.mail.protection.outlook.com (10.13.175.67) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4975.11 via Frontend Transport; Fri, 11 Feb 2022 21:52:08 +0000
Received: from jasdeep-System-Product-Name.hitronhub.home (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Fri, 11 Feb 2022 15:52:05 -0600
From: Jasdeep Dhillon <jdhillon@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 06/11] drm/amd/display: Add affected crtcs to atomic state for
 dsc mst unplug
Date: Fri, 11 Feb 2022 16:51:37 -0500
Message-ID: <20220211215142.94169-7-jdhillon@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 5eea3866-4f45-4d63-756a-08d9eda8c086
X-MS-TrafficTypeDiagnostic: BL1PR12MB5302:EE_
X-Microsoft-Antispam-PRVS: <BL1PR12MB530240FAA6C0567F389C4F1DFB309@BL1PR12MB5302.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oxj6Q/WBnoANcksJIr2cQORMz68tvyTaHSzRk7Q+3xE1de9QCTFLEcmd9FM+CyMfvKZoOUNxLrXGi51U6Wy05H4cBc5NwyF/3gQanHw4bzn/+G768+IiT0ymb3nr9iDAN1Jy4VXqtJYzzlNX42b+JQAilC0kJaLYiZgMMICvWbs63Vu8RTs1fyFzryiNjDkuOmcryXtocMIUO5rmuKXndlzKx99qGLYXvIbNY/bFqP5Zu3tS0yUOeL+pWiEgq4d625DowxTYEwInxR1QfAjeliWJ3lGuTtMXBPD6QXJ+/mbBFKpIULgaM18Wjhq7djQMXyS7lovcQ0mV/0XRq6H9HTlbnA5Ubd0/pwB8XkQzBdhHXQqRt13uMjysViLO2XNigmHc4DtlWz4JqRjpg03bYzPqdPJZDvXeNK+/aMVHha0H1L96RONhiTcTOGk4/0ta989LJ2Y4ag+AFPI2oT8bo+45k/RbaQAfC3qgbPiwUfQIAVCc/jt5aCnPry4u0s6GyeeSmpeJIMhmhs8CSr1HUHUOqoTVSDObsIUkvyl2vg6wI4kX+fZfObtPgMTwLGIBo0Aj3a+Ura6dne13Qzc1YF0o2AUSXiGEa2CMMyTnMYEF+h0ZHtaji8bCRb2LdzeFU6nQfUCnLljKDRQYV1FSwKEOwyeAWjnHmzvsdLufPF/jgUqE/Ns/GebmHks83IiafM6JulWK6FQ6hDYoMrvkOA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(2906002)(81166007)(36860700001)(336012)(426003)(83380400001)(356005)(54906003)(6916009)(316002)(4326008)(70586007)(8936002)(8676002)(70206006)(16526019)(2616005)(82310400004)(508600001)(5660300002)(186003)(1076003)(36756003)(40460700003)(6666004)(26005)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2022 21:52:08.8086 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5eea3866-4f45-4d63-756a-08d9eda8c086
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT026.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5302
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
Cc: stylon.wang@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Jasdeep Dhillon <jdhillon@amd.com>,
 Rodrigo.Siqueira@amd.com, Roman Li <Roman.Li@amd.com>, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, Hersen Wu <hersenxs.wu@amd.com>, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Roman Li <Roman.Li@amd.com>

[Why]
When display topology changed on DSC hub we add all crtcs with dsc support to
atomic state.
Refer to patch:"drm/amd/display: Trigger modesets on MST DSC connectors"
However the original implementation may skip crtc if the topology change
caused by unplug.
That potentially could lead to no-lightup or corruption on DSC hub after
unplug event on one of the connectors.

[How]
Update add_affected_mst_dsc_crtcs() to use old connector state
if new connector state has no crtc (undergoes modeset due to unplug)

Fixes: ("drm/amd/display: Trigger modesets on MST DSC connectors")

Reviewed-by: Hersen Wu <hersenxs.wu@amd.com>
Acked-by: Jasdeep Dhillon <jdhillon@amd.com>
Signed-off-by: Roman Li <Roman.Li@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 10ca3fc6d91e..e26217e46c57 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -10851,10 +10851,13 @@ static int dm_check_crtc_cursor(struct drm_atomic_state *state,
 static int add_affected_mst_dsc_crtcs(struct drm_atomic_state *state, struct drm_crtc *crtc)
 {
 	struct drm_connector *connector;
-	struct drm_connector_state *conn_state;
+	struct drm_connector_state *conn_state, *old_conn_state;
 	struct amdgpu_dm_connector *aconnector = NULL;
 	int i;
-	for_each_new_connector_in_state(state, connector, conn_state, i) {
+	for_each_oldnew_connector_in_state(state, connector, old_conn_state, conn_state, i) {
+		if (!conn_state->crtc)
+			conn_state = old_conn_state;
+
 		if (conn_state->crtc != crtc)
 			continue;
 
-- 
2.25.1

