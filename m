Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F98BEE0203
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Sep 2023 02:01:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D2E2310E21F;
	Thu, 14 Sep 2023 02:01:45 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2070.outbound.protection.outlook.com [40.107.92.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3660710E222
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Sep 2023 02:01:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yw3LVV3gTcne9FKL4+49ki0UDizxLY4eHfLV70ORO/9HjYgvlhG+YLJ54sxICqGphzU5WuPaXa4q6HPdavLz+fNapvoSDZGJPzJYPVTSxxdVGiRXrr2VpEY/AX+pBHWxKlBPJFLmfh80FieBX29+At9FYjo+4XAVwGXHIoGBTOnJ3Y/sArgxm+MKuu3pJ+Srw3Uk7PuRqyXq75UhgXCZrUKkgm7JnKP/QcBYknRHY7K1GX5o/TEG2743shwHDXESc+yJF2gYqYyogRP2N/wLuOARY/MNHsJc1HneYRdDRV1GstTVVYEZ0f+o7L09segnD7bj3A1OrG66+23ItuOlgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w0JfvML4wIqKESMAY0lW8hQfSKr13pSGKpuyQrRc9qI=;
 b=JddLXvYnQBInUOgZnRRO+UPHKFM1j27Z7rcbfJJ/XKADAxPAqlgwhJZI/2Mia5sprChtOeEWugEHcG80xlQ0usmGe0bvOwwdXeLAX34YQN22UoA8AV19KhOfybQE0LzHCkOyvGl2nc7pePaiz+lTdcvj1DibZxaIlPv68vK3JaBz3dJl4/fDNeg2WRVYNrt9+OYaa6C2j2vhE1HKSKyhPi7dDVaO79mwDT8DIcl6SKbe11HYCyEwNKrMfxIEeAJaT6lmAfESfy0QcuGMNSzaAPWAPxW/3y8FndA9WR2c06E40gH1OR6ULbfXYYkdRJoch9ofiOJtqO9oIEPEUNQ42A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w0JfvML4wIqKESMAY0lW8hQfSKr13pSGKpuyQrRc9qI=;
 b=425W/w1WEz5TAk+GQ1TlisbM1J7bzUm86kXUNvWQdKoBGWAaaJvJ3u8nt+Z7V3PezFkvmByXowuyRmLsIVTtZeZEUWSQG6kvvltSmnORVtz9Kq5hBs/q3bJWU0H9iZs4KwCbtzXMxIs5xJCkrQt9fcGKG9ByifuMjd6RMYEDJRs=
Received: from PA7P264CA0165.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:36c::13)
 by CY5PR12MB6033.namprd12.prod.outlook.com (2603:10b6:930:2f::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30; Thu, 14 Sep
 2023 02:01:40 +0000
Received: from SA2PEPF000015C8.namprd03.prod.outlook.com
 (2603:10a6:102:36c:cafe::8d) by PA7P264CA0165.outlook.office365.com
 (2603:10a6:102:36c::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.34 via Frontend
 Transport; Thu, 14 Sep 2023 02:01:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015C8.mail.protection.outlook.com (10.167.241.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.20 via Frontend Transport; Thu, 14 Sep 2023 02:01:39 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 13 Sep
 2023 21:01:36 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 11/28] drm/amd/display: Update pipe resource interfaces for
 DCN35
Date: Wed, 13 Sep 2023 20:00:04 -0600
Message-ID: <20230914020021.2890026-12-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230914020021.2890026-1-Rodrigo.Siqueira@amd.com>
References: <20230914020021.2890026-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C8:EE_|CY5PR12MB6033:EE_
X-MS-Office365-Filtering-Correlation-Id: 29f2e149-9a10-4b28-6b84-08dbb4c688a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hSBHqDHmpwPssFUc4N42dSwokZzND2S+gU47KuFQV6USLYrpD+H2G/S8JvDNGvucosiaMBXUK6vnKPbNmKp8rpQbq6JgWnoVsGQ5DM+cYto5ykpbQvbTiJTEUSrbhZsz7Sh9kbtNOYjC/vwWppP3dHc2V71W4br77l4WL/acVTPePDFSASa1+/XU2ItUonxXMmITRRzqEZcFfab+fsFAPHZ3LrzOje2Lxq1/klbRSaqa05h5btYi+ynMSz0BSiYKfhBNQywD1w+2pnAnGPS9/oo4lUT+AADtuYClcTZeBPu3EwPfyV0Lw/q+0oGzReAC9YpR2YBL5IuQhBMoX7Hg3NjXp7oc3wnE6v3CpdaOVZN3Ivi2Ggebnv5A6MXTo2Tk+SRzLb5f9gLYcWD4KE4aYdZlF8kUMRjVxeh0vLRdOd9jeU21Cb3MFhRx2rLVSiNdcZe6Kvq8soDx8q431UuejsC2k4jpOyUR8UIeRGRAz47U4GAF73D5yCswvms+ejcR7gP1EKnVJfneLqhvXA9uR00fbKyKonfUz81U65TSy+DfPGi8n7if7hGUzwoTFwDrvGsjaRmwHWZrQDKafAYwIrPfEuVUQf0TN+lgZwTZmx8G8niwcZatfxQTtqbtMSuGbGN2lasmufnqbqB12ckfG3mhTWcCY3rORkEGPXsS0hcweKRNv0oXuA+fxEOzVftvtTMi5p1yWfN+YPRG8xTzpmKCe72xK3II8a8t/QEFUFbNjDS9XZ4vB7LHSbQCh6f9Y7ZXIsjTO2CAi/RbKGqiZA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(39860400002)(136003)(376002)(346002)(186009)(82310400011)(451199024)(1800799009)(40470700004)(36840700001)(46966006)(426003)(316002)(54906003)(70586007)(70206006)(16526019)(6916009)(26005)(2616005)(83380400001)(36756003)(6666004)(82740400003)(81166007)(356005)(86362001)(40460700003)(47076005)(36860700001)(40480700001)(1076003)(336012)(478600001)(2906002)(15650500001)(8676002)(8936002)(41300700001)(4326008)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2023 02:01:39.1367 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 29f2e149-9a10-4b28-6b84-08dbb4c688a3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015C8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6033
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
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 Wenjing Liu <wenjing.liu@amd.com>, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Jun Lei <jun.lei@amd.com>,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wenjing Liu <wenjing.liu@amd.com>

Pipe resource interfaces were changed.

Reviewed-by: Jun Lei <jun.lei@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn35/dcn35_resource.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_resource.c b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_resource.c
index 02480920a5b0..9fc15a200133 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_resource.c
@@ -1712,6 +1712,7 @@ static struct resource_funcs dcn35_res_pool_funcs = {
 	.update_soc_for_wm_a = dcn31_update_soc_for_wm_a,
 	.populate_dml_pipes = dcn35_populate_dml_pipes_from_context_fpu,
 	.acquire_free_pipe_as_secondary_dpp_pipe = dcn20_acquire_free_pipe_for_layer,
+	.release_pipe = dcn20_release_pipe,
 	.add_stream_to_ctx = dcn30_add_stream_to_ctx,
 	.add_dsc_to_stream_resource = dcn20_add_dsc_to_stream_resource,
 	.remove_stream_from_ctx = dcn20_remove_stream_from_ctx,
-- 
2.40.1

