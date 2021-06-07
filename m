Return-Path: <SRS0=JNIh=LB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D752C47094
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Jun 2021 16:48:29 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CCD4E60FEA
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Jun 2021 16:48:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCD4E60FEA
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 90ACC6E933;
	Mon,  7 Jun 2021 16:48:28 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2070.outbound.protection.outlook.com [40.107.220.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E02406E933
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Jun 2021 16:48:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KdjAFZoqcuqmh4Qkl8ACBtpUa5ViAD2/IlT0Bc5oJiQBmQQYx0FXYs4zAHDOMs1bsqrApABYiE4Ndw/hBFANNf9dYaSU+ynOxmgkMKo2jM0Kb87Y7gTNosfRIS8oSsuhqRWCmsra9J4W/v3/wn8NnTEwb53RHfWS3i/WFKmZMmt24qHfmlc2FdGhe0d/6gnR0aKCJy48oBa8g3R0+KVollxfBZU0ikdxB35yOzx3tSiXFsO+oe3uwjkZ27p4PDFGNsRXWfOXPHnIMPJUxDGQ0TRnvPbhwtXoTgZ2WZ3snXagffrRKcuQp+B5UZcfnNu5gUo9/sfk1Fe2kNpZF2KEgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MRrB+5HyfXox1NjgeJQz0rj2uFwza2Gb1sKx7CMyNXQ=;
 b=TUMM8sBU9ovUI+kCctA6OwRg/Di20jt5xV2YS2+o8BeJI6VnjhzY2I7waiJQSa/UNVtZ3qj0mnSJ7g3PaPCz0a365a+qnAVWZznep8h7PRWvaTwIK39eiCXXpenSTCNwHfjDnxVf0hBXtziMeKVUBjKbKWdqTnrm0LxUqvjdvDoopZUJuCe8KBGnV3Ws1PY/IK6NqmN4XMrSb0Ws3fbNNollpUZv9SjEWAkHvhCkjxFS8VCDzKOGO9N+UxyZNmr+UJQGoBEfR+t6JZJ2J8MDwHNaGsZwhiHrn8vvPb55ANKYiHcGp/6Tge/K5qgrYBvR2LzU+shZ76n5HgjzKqhgFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 165.204.84.17)
 smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=temperror action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MRrB+5HyfXox1NjgeJQz0rj2uFwza2Gb1sKx7CMyNXQ=;
 b=LEp7AUlzqUzEoyzVF/xRpwW6sSMtijsEzj0pZ68KuxIHuuCkvcDnWV638ireZG1wB79jMWyNdK9NMV7Xaiqf4opH71wkNaGq2zSTvvmXLRFkK9gp0CR6a3WEc85el/gonoMrXWbrEE96unxuh3RFEJH0Hyho7+T2cv8KlrAhxDI=
Received: from BN0PR04CA0163.namprd04.prod.outlook.com (2603:10b6:408:eb::18)
 by BL0PR12MB4738.namprd12.prod.outlook.com (2603:10b6:208:8e::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.20; Mon, 7 Jun
 2021 16:48:25 +0000
Received: from BN8NAM11FT025.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:eb:cafe::7f) by BN0PR04CA0163.outlook.office365.com
 (2603:10b6:408:eb::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.15 via Frontend
 Transport; Mon, 7 Jun 2021 16:48:25 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none
 (message not signed) header.d=none;lists.freedesktop.org; dmarc=temperror
 action=none header.from=amd.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of amd.com: DNS Timeout)
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT025.mail.protection.outlook.com (10.13.177.136) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4195.22 via Frontend Transport; Mon, 7 Jun 2021 16:48:23 +0000
Received: from stylon-rog.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Mon, 7 Jun 2021
 11:48:20 -0500
From: Stylon Wang <stylon.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 11/30] drm/amd/display: Update scaling settings on modeset
Date: Tue, 8 Jun 2021 00:46:55 +0800
Message-ID: <20210607164714.311325-12-stylon.wang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210607164714.311325-1-stylon.wang@amd.com>
References: <20210607164714.311325-1-stylon.wang@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1e91532a-d0b0-4c0e-0956-08d929d410a4
X-MS-TrafficTypeDiagnostic: BL0PR12MB4738:
X-Microsoft-Antispam-PRVS: <BL0PR12MB4738D08E2263C65123D4A14AFF389@BL0PR12MB4738.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1091;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IHbw44AfjgfZCvFEOMfcDR7ESGZxOCKVLKbjos89Pf3RPyVzX6ub3MrAK3S9VO8R41RJWgzHUv/prjrwt+araiwJ/jIJIzHLkRYpQcMLKmDlxmieJRu+fOxYcckq3Kv7j3RwxZ/rg3p0alIxTRgOHAJOKmSbm4vNIikZ4HHV8klmVSLRqTPJ6zz+/spYvAgiMiiUItK8ohuOOuyIcJKx/hbCpMp3IHGvonuf2Q/0C5FYJs1DfRCExPAONTCLx9fwLz/81e8F0DezsL9HYS7wTlKHjSN1Y1FxxFGN5FMYOg/QnVsTmjSLouMQn6VyywyOyAfBxfcCAte9xhsonA3JSbmqIiVUc95SjYU7UAuLLUrna7MKkSKB8uLprW9oSfYLMgbOrY/iZmK+ypIc2zCNEmmnX9jQjiq1FAaR7JGHURzVzuUN8dKW5g2ib0ykCnNWf+tsWUlP0On98iQOR4RhpfXGv5I0xhIZhds92FnNoFlzdozVxF7KcXoKoq88JiWjNZh9QV4VXE6bQEpXcotFqVVPxcRnB0iSrnWz7ydYYosU9Hnj6lOcHciVraCpDyxqW816qRlFk8M/Bypg838UUaxkZsMp0mjJU+LAR7UbqrfZaQ6C1NCEt8/cBmWCyJuztwl3hZUUZr3aofk2qHv9Tzj4otFj0XHJg/pHEX8UJ9HiAD3nSuv6JvpRpmYhTTt0
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(376002)(136003)(39860400002)(396003)(36840700001)(46966006)(82310400003)(63350400001)(2616005)(63370400001)(2906002)(26005)(5660300002)(316002)(1076003)(15650500001)(186003)(47076005)(16526019)(70206006)(82740400003)(426003)(44832011)(54906003)(336012)(70586007)(7696005)(36860700001)(83380400001)(478600001)(356005)(36756003)(6916009)(81166007)(8676002)(86362001)(4326008)(6666004)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2021 16:48:23.8192 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e91532a-d0b0-4c0e-0956-08d929d410a4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT025.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4738
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
Cc: Stylon Wang <stylon.wang@amd.com>, Eryk.Brol@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Roman Li <roman.li@amd.com>, Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com,
 Bhawanpreet.Lakha@amd.com, Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>,
 bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Roman Li <roman.li@amd.com>

[Why]
We update scaling settings when scaling mode has been changed.
However when changing mode from native resolution the scaling mode previously
set gets ignored.

[How]
Perform scaling settings update on modeset.

Signed-off-by: Roman Li <roman.li@amd.com>
Reviewed-by: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Acked-by: Stylon Wang <stylon.wang@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 09bbec4dab7c..0b12299da93d 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -9737,7 +9737,8 @@ static int dm_update_crtc_state(struct amdgpu_display_manager *dm,
 	BUG_ON(dm_new_crtc_state->stream == NULL);
 
 	/* Scaling or underscan settings */
-	if (is_scaling_state_different(dm_old_conn_state, dm_new_conn_state))
+	if (is_scaling_state_different(dm_old_conn_state, dm_new_conn_state) ||
+				drm_atomic_crtc_needs_modeset(new_crtc_state))
 		update_stream_scaling_settings(
 			&new_crtc_state->mode, dm_new_conn_state, dm_new_crtc_state->stream);
 
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
