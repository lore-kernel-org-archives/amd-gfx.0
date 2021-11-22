Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96AE1C433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Nov 2021 22:25:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1B7C789E57;
	Mon, 22 Nov 2021 22:25:43 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2049.outbound.protection.outlook.com [40.107.95.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AC9AB89E57
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Nov 2021 22:25:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nA1sb1gehddGV3VNkCjoC4vam7M2qw7EwAWfQicKBH3HONzcj3uLrZ0zKaaJev2W6tQ+NP78LmaliG5E26AN5eujnAm/TWtD3wUmcII+4Cdi9HC2R9QaOcTacsbFza7k3JBenYUYojbji1UOmyyJuOzeMw5tRFO9SXH+0xcJYTMKlBisaQhsUcRWS47XrToEzo3JRNG5BHDChGENfWxdANtL6TIJshdpoyTIaf6t9BKJ2zO3aKlAeahulE0TSNxXbj3IH/AOoHVoTQ3T3b8Km1yCd70DKBphi5nZuJHBIOWZxnwHv1iuzw1WVxHoWlrmsgPZy2D2Vf4dYItqe1awEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tLc6YnfGQBRlc2e52KpBr6SHfKnzuSgC6elTg2boke8=;
 b=ZVH8ASd27uy8hKyMTUyTKTxDyo06QxSAKmIZ2DCq/EqhUU2avvZMhIsY9Wyx/Dq++zt3+fDsY/MaICbSy0dPDscCArrkCqefHL5J1N6Vgisl9w4iqTUDqSF4xi0oKkiW+jVUMrLwC69NP5lgNxI88SmDX7VHRN092DVgivl3KCGd17J+b7o9zDTPPjQ6aCbScFY2YK25uY4tTcSp35QTIy39Uy5hnuKm3AEXOj+A6HA0RT/0rXZJSuhoBbj6uewA4E/c+Jyy34ZE1m39L1WLEfLHGRxILqBS9khAoaY52hXlOLEuHO3d59E4g+TtHbATAvdiZwp6mYq8gf1du27w3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tLc6YnfGQBRlc2e52KpBr6SHfKnzuSgC6elTg2boke8=;
 b=s0rp30d5aGQwOJJgxEZHoze6BVKA6OwUJKHfwLfwQdWRtB+/Rf6EkUCqUi2sImRO/UFhX+mfUclQs9iIBfZnIqNfjgBaNpOk0UQhNwK5f/qdASOwa55R4j35tsZBYgpFYgYdo8XOEfQoNUpMVSCh9982bO/5z6r9fAkbR3ox/ZA=
Received: from BN9PR03CA0914.namprd03.prod.outlook.com (2603:10b6:408:107::19)
 by MW3PR12MB4409.namprd12.prod.outlook.com (2603:10b6:303:2d::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.22; Mon, 22 Nov
 2021 22:25:36 +0000
Received: from BN8NAM11FT055.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:107:cafe::33) by BN9PR03CA0914.outlook.office365.com
 (2603:10b6:408:107::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19 via Frontend
 Transport; Mon, 22 Nov 2021 22:25:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT055.mail.protection.outlook.com (10.13.177.62) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4713.20 via Frontend Transport; Mon, 22 Nov 2021 22:25:35 +0000
Received: from localhost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Mon, 22 Nov
 2021 16:25:33 -0600
From: Luben Tuikov <luben.tuikov@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/3] drm/amd/pm: Print the error on command submission
Date: Mon, 22 Nov 2021 17:25:12 -0500
Message-ID: <20211122222512.58886-3-luben.tuikov@amd.com>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20211122222512.58886-1-luben.tuikov@amd.com>
References: <20211122222512.58886-1-luben.tuikov@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6be3e88b-7fe6-464e-8420-08d9ae07010e
X-MS-TrafficTypeDiagnostic: MW3PR12MB4409:
X-Microsoft-Antispam-PRVS: <MW3PR12MB4409ADE743F57807B128ED3F999F9@MW3PR12MB4409.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Y9N4MG0y2CJK7acZ6mmk6G9t0wK66wF95kwFnbiX3LWgrOJFF6iNgIxy0/uekIYM+mJwLRtID6GgpFswgpobJw8t8EC6dlvs8cKEPN5OMIa3nGOJcQWZ8LwN2btno69Mfk0tt/y3x+i5EAsl46aeOUKJoGkcNuy/1aBl7N7VnPp0UGG7aFzBbQZ+FcwbuuBZG4QYae727r7AEiMPJmf3rkqVWzYbMFUIiOFKVWwGRTGwRvLL8CAnrCpaWknQZw564gCs+FdKWXMFUlb7gwTGRWU/njNUq/IJNyLtduhCHtBlMGqOk8Z9vt4z0M8nSNaxUxRDWEBc/NSuTy1CVjZ+CtAiwjuRnz8/z6KpWhYs7uCub9ODLkRYKNaP+uzcW7yfdcetyaWzhKiUpW6Ozh4KyB1VyPZphrUWbFIiJ9DjtvZmfs2FkaXDPQOHaADAyIqODYz/fapr4ZtHCY4DMSlBSpkqFwuWatPWPiW9s/yU0g6CrQGSWnRoPwk8r6NJcRQ5VSyzDMI6KWGQfTaQG7/paugX70uvhFbYXwHwxBsSAa35wv0EjzFrYSYLnZp/zWhTuVFkE+ulgR60q08Jc7YPS7yWsSIbMvFvbBdqhy0roqmFGCyZZqLCKHbH7fskxTzyFytVLEyBt8ej4Hs5YX2+2vmFOfc+42bmNpEMQ1lnOZDZNYu7mI44S7H0x+U2PJJ4Hwy+nK0/z/OR2wY+/vVAIOkVwPUN9gQEJtAQql17lDM=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(54906003)(36756003)(47076005)(36860700001)(7696005)(8936002)(6916009)(1076003)(316002)(2616005)(86362001)(2906002)(44832011)(83380400001)(4326008)(16526019)(186003)(81166007)(336012)(5660300002)(426003)(70586007)(8676002)(6666004)(26005)(356005)(70206006)(508600001)(82310400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2021 22:25:35.4908 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6be3e88b-7fe6-464e-8420-08d9ae07010e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT055.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4409
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
Cc: Alex Deucher <Alexander.Deucher@amd.com>,
 Luben Tuikov <luben.tuikov@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Print the error on command submission immediately after submitting to
the SMU. This is rate-limited. It helps to immediately know there was an
error on command submission, rather than leave it up to clients to report
the error, as sometimes they do not.

Cc: Alex Deucher <Alexander.Deucher@amd.com>
Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
Acked-by: Alex Deucher <Alexander.Deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
index f9a42a07eeaebf..048ca16738638f 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
@@ -352,7 +352,7 @@ int smu_cmn_send_smc_msg_with_param(struct smu_context *smu,
 	__smu_cmn_send_msg(smu, (uint16_t) index, param);
 	reg = __smu_cmn_poll_stat(smu);
 	res = __smu_cmn_reg2errno(smu, reg);
-	if (res == -EREMOTEIO)
+	if (res != 0)
 		__smu_cmn_reg_print_error(smu, reg, index, param, msg);
 	if (read_arg)
 		smu_cmn_read_arg(smu, read_arg);
-- 
2.34.0

