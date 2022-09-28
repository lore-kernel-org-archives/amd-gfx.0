Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB0AAC04A95
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Sep 2022 19:41:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A4C0F10E9C1;
	Wed, 28 Sep 2022 19:41:53 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2045.outbound.protection.outlook.com [40.107.92.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8544B10E9BA
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Sep 2022 19:41:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AgqfJEo77n0RsggNVYv0Q19OtIpSwfkz18Q1jn3HP2FvyddLLYOT3+5dx+OViWpmAFVS/89EPnCqsx9Q2N+um9AmEZqhbkDwHnc9YunnJAGZp3D4raHhgeq0Wp9uaKKZtGKBnzxJjR10Bm2vIMOrJzimhmbegQuotz0xJMVoSChIJZ8wMkgzO5r/s73ou7TK4bww60npK6yDE0esR3h3m8zDkBMbgEWbvPYhEkgSXBVKHtnKg0/dfyP4BjS3njElaYpSagRjnViuxEiorLaO2jI2dTFnre4m2cHm21zb7KtL8SV4zhl9+Z+MAY+vrKLN1stSRGg1sxv2to7G25Me9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yPyvE3KWkvFVMd1K3govwwFwh9cReD6mNhZjHgsaZVk=;
 b=og2jnCXCNXuxERli+KkR2QlJ5LQr5WkXoytjERnNH3rDnvLJv9kw7wxgm2KADhJQSImSaA2jQ/Lm55Gu3RLsVnuFMZmyf61FEReUWCEgdmV3xgid0fvBFVMrQiDt6NYlLdHn3SiU1JRHyVbfreBp66w9ngC2PGFiCkd5gnCUeNxDm2b96j7vGLfIil9fMG5iQoiMmltVr7SOWHOOTel6GfLTp95MckLdBB2l9XHshs9gCOXUKuXHO/JBt+UCXoqak4WYfXq5vvj6EwVy+Z6FCa+vKcU4D8sN0QFQqgLxZeUC7hejFkG5AKzmuO8VB4xfgjdDBpjWQ+FV+Bu1UlBCKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yPyvE3KWkvFVMd1K3govwwFwh9cReD6mNhZjHgsaZVk=;
 b=eCMJz0RhtLg/OhyQFQPM0snigzB2FJ0kumJbqAeAhEMFrQacTr9jXF/GH/QsmoeOA6yK0CZoZkj2OUeZlaBSgCfJJkDpiCrA69VIbf9IlSbmwFbCyJKOnSqZDw63SH9PiJ/xhIAxLor6KInMXIOjj2YIOshTz3I08AhbPkjs15k=
Received: from BN9PR03CA0726.namprd03.prod.outlook.com (2603:10b6:408:110::11)
 by DM4PR12MB5247.namprd12.prod.outlook.com (2603:10b6:5:39b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.18; Wed, 28 Sep
 2022 19:41:31 +0000
Received: from BN8NAM11FT031.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:110:cafe::32) by BN9PR03CA0726.outlook.office365.com
 (2603:10b6:408:110::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.17 via Frontend
 Transport; Wed, 28 Sep 2022 19:41:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT031.mail.protection.outlook.com (10.13.177.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5676.17 via Frontend Transport; Wed, 28 Sep 2022 19:41:31 +0000
Received: from hamza-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 28 Sep
 2022 14:41:27 -0500
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 24/36] drm/amd/display: Update DCN321 hook that deals with
 pipe aquire
Date: Wed, 28 Sep 2022 15:40:16 -0400
Message-ID: <20220928194028.144879-25-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220928194028.144879-1-hamza.mahfooz@amd.com>
References: <20220928194028.144879-1-hamza.mahfooz@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT031:EE_|DM4PR12MB5247:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f8c496f-e922-4122-5561-08daa1897192
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MFwK9WgXZYmRRixg/mPglItsJpRC9jfPieCzhhwB1NwvZfcGT+Z+FcmwA6vXg8di+hod8a2kj0yCQlQKWWbkcr+dJpahgHaEzbbDRWquQlKOJs2YC69Z4qRZ6b/ss0XHWDeVcziP5rww72n5EjPEnbQWUoWCPnyP35587IDn+umBLn7cCfXHl2UXJ9iQgzIyO2fK5E1fIDvAzVSS0lSF6JvXUgY51SfQfICvIa9CdSMT4tjzY6HwC7gCFd4iGMVlbdA/UuVy06gx4Uxj6nhYxWzIDk61aGauZRkcyuEDF1NA/dtMi++6Os0CpOVeO30SZXSSiQvIsQD/4ZS1YqECSC7a/wVZ8yCtm25gGBiFeqfrCi4+RspZzp7KgfqUSZBSCUrd+iD8cbX/0qfWpQPQXv9Rv7e7ctuNeE2PnanDk1Jq8JY2dXHTSel1tXPg/KA0Cs3E3HlU1zWFEkKVE2IsQYHAlgfuFTEpt4WFaK00GYbaCydaCfOt6luahx0cPSBbM+r5U3394kQG1+CLdnf9kx4qe1nWTy3ETLbHAlM5xkdMR+tC7zzlITrv786byWakZ3caYOw9HDsHELNXP0fn2YMn5Jrbv/S3mlv+pzHTKd0tsPcRk9/RF7HYLrvJcWsPBG4kw35xOALTgHwUvsfTpbokG7Xs0X33hHAA8nLeme44y+NQKvBkTo0ItX1Ok2WZvYqMPTgm0zkv/TW10JXBLo3jZCoOUCIXhCZUo3j0igMoojeHRY+A1Nf4zbrkSD1slD2L9WfbHJezCZi/756FmE6n6Ef1ezQkc1dhyNE7Cj77O+vuEASMtl/1+0fCbYTUA0m1HN+CqXU9WeTsKV4ikA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(346002)(376002)(39860400002)(136003)(451199015)(46966006)(36840700001)(40470700004)(2906002)(83380400001)(36860700001)(6666004)(7696005)(478600001)(36756003)(316002)(82740400003)(81166007)(8676002)(4326008)(70206006)(40460700003)(70586007)(356005)(86362001)(82310400005)(44832011)(15650500001)(41300700001)(40480700001)(8936002)(6916009)(54906003)(5660300002)(16526019)(186003)(2616005)(1076003)(426003)(47076005)(336012)(26005)(16060500005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2022 19:41:31.3728 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f8c496f-e922-4122-5561-08daa1897192
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT031.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5247
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
 solomon.chiu@amd.com, Aurabindo Pillai <aurabindo.pillai@amd.com>,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>

DCN provides a hook to check if we can have a new pipe allocation based
on some DC constraints. If the current configuration supports the new
pipe request, DC updates its context; otherwise, it will keep the same
configuration. This behavior is similar across multiple ASICs, and for
this reason, we reused DCN20 on DCN321. However, this DCN32x has some
peculiarities which require its function to avoid weird pipe split
issues. This commit update this issue by using
dcn32_acquire_idle_pipe_for_head_pipe_in_layer instead of
dcn20_acquire_idle_pipe_for_layer.

Reviewed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c b/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c
index 910b63d874d5..6658849d5b4e 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c
@@ -1604,7 +1604,7 @@ static struct resource_funcs dcn321_res_pool_funcs = {
 	.validate_bandwidth = dcn32_validate_bandwidth,
 	.calculate_wm_and_dlg = dcn32_calculate_wm_and_dlg,
 	.populate_dml_pipes = dcn32_populate_dml_pipes_from_context,
-	.acquire_idle_pipe_for_layer = dcn20_acquire_idle_pipe_for_layer,
+	.acquire_idle_pipe_for_head_pipe_in_layer = dcn32_acquire_idle_pipe_for_head_pipe_in_layer,
 	.add_stream_to_ctx = dcn30_add_stream_to_ctx,
 	.add_dsc_to_stream_resource = dcn20_add_dsc_to_stream_resource,
 	.remove_stream_from_ctx = dcn20_remove_stream_from_ctx,
-- 
2.37.2

