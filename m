Return-Path: <SRS0=mBQi=NO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20C62C4338F
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Aug 2021 08:54:56 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DFA336102A
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Aug 2021 08:54:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org DFA336102A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3AFAB89CF7;
	Mon, 23 Aug 2021 08:54:55 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2073.outbound.protection.outlook.com [40.107.94.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4243D89CF7
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Aug 2021 08:54:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cT7wWgOcQd4XIpm6UsC4+ttRaGqv9Kmk33thPknL1ktduozKJ/Mfe2cMgLS6GPf6vvNol9EA48vaaYN4t2zw9gKnjld13j9br150q4aFa4/Vzbvh4ObJ9nF7TsbNYZ1ltqB+dGCWGc9AsPh2clTlbRoZ01noplcmFWvd7ZzlhOKPMJjm4/BsEzlCrdYg753nX/sxZGVqjcehguhlR1mscI5VEZM2tZoTQu1ePvMlmxE9FgB+zU4BTuIbFr1veV7fj7HhKQ8LaV5GfxoPgSVRlYcK7/7v8Ka/bZ1vBeCqX9uOI4ukSNNp9l6veRH1gyiy8DlhM4zGXoKYMJq8lAMziw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pd3V9CmKoI+mewBZSn/Nb3tuO19z2fnLLp0b+1v8XI8=;
 b=HGmqFevDXo6iAnqIW4r57Mcbr94FDCa9hAs+8+saIV1HWmyCNPfZs3i8hUIPdRtvzTX2KnKgJWRQnpObsAGtAfWArZKZxZERJBVr7wyXQ+ETsekjLRjrQ12ZyglZ8WSS8+06lwZzaGcdpx4G1o0zCQmBIT4tx0ONUGOzLAYMNhHEhlohOv2hHqA4CPv+1BuUl6+c3qVQPGkDudTCmh7bFU+15kZWqW9w/Eo1oAdVSGcYIHz63yjGZZ3JCu6rLawY0yZR8sVaAoQTtnVUh7pqinA4aBmgdgskx5bZWWXhnPLTYU8TovyGZRLvJvJJatJqXZJN0v3aMeAou3lsDu+d6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pd3V9CmKoI+mewBZSn/Nb3tuO19z2fnLLp0b+1v8XI8=;
 b=sYVghcp1W/NnRaTJuYmDXJQMfokvsBQwoQ0a3odoX9twiqoSYF+a46aHLkg3WoBtIQaTvA84nIpz6/Ar6/kx08pJaDabK5qo5AxaEVcAdRIdRKInY3bFf1LE8DmEKcpC7O7nyNkXrOAIeD+9iz5Jq/7A3iduVTUst273yxiJvBc=
Received: from DM3PR12CA0108.namprd12.prod.outlook.com (2603:10b6:0:55::28) by
 DM8PR12MB5447.namprd12.prod.outlook.com (2603:10b6:8:36::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4436.19; Mon, 23 Aug 2021 08:54:52 +0000
Received: from DM6NAM11FT030.eop-nam11.prod.protection.outlook.com
 (2603:10b6:0:55:cafe::ff) by DM3PR12CA0108.outlook.office365.com
 (2603:10b6:0:55::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend
 Transport; Mon, 23 Aug 2021 08:54:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT030.mail.protection.outlook.com (10.13.172.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4436.19 via Frontend Transport; Mon, 23 Aug 2021 08:54:51 +0000
Received: from canli.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Mon, 23 Aug
 2021 03:54:50 -0500
From: Candice Li <candice.li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Candice Li <candice.li@amd.com>
Subject: [PATCH] drm/amd/amdgpu: add name field back to ras_common_if
Date: Mon, 23 Aug 2021 16:54:26 +0800
Message-ID: <20210823085426.5998-1-candice.li@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 73c188b3-a859-4ad7-e966-08d96613aba9
X-MS-TrafficTypeDiagnostic: DM8PR12MB5447:
X-Microsoft-Antispam-PRVS: <DM8PR12MB54473909ECBA66439D500C1291C49@DM8PR12MB5447.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:374;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xFgsXpDKFnOlzWEtxqXgfGKkCNriJERyWhq+kswflRNvYJZCYDTCIh6JaqnAWDNbVG3SDnMiuEUelcDQkuvWYLnTFySvSkSTixyDaIl+WK/T5ND9QXeXXqhgm9O8Q73njRBsHhEiYtvvIGKMhwz/pjbo9rkjMoxINb9R8NyR5iw7Hkpi8IDciJgK2ITB3pO19/oxPaXC8vl8tj8K3SfX3e9UG+SYD9MniJbHDmKjDVzG3OsFNrO+5sT8E1cirBgTUbQ/tdp7nQpvm5DUTid7ijutJw+DueiK9Svt2S69A9Ch5luJWyrxRfJJEQqBSRnCu4XlTtVsbVbYOpj3F1u1Z4MtHitfwDiIDLTQEAmFTHh85MXoSDX49dQoQufXZ64/VNUzVdHJ7cHTWEe8TDzsGIM02oP2NNFSKAubbRiTq9f7UI5INZP2l8NOlVC/l+gHAvklxKQBUHK4xEDUOPmZZQIc1IU2Qd5iXIJTyybcs4HaLKDBkxnl4sIvXUADboKkCZkSXLe2Dgy9pzDXuCkCIdaPcGrBIX7UdLsFjE65RNaj/gBOVX+I/8UtSUw+yqO/2oATkuSjjbgNWN5SmT6F80bZao3yU74AJcMvmsF3ob0JDvz7381YYmJflo/esxgrFV/iJQnZpF/segIiNvUklzLnZpDuPea8t5BV8rryTsqeprlWNEei8hZeh8Wy41XT1Mzrf3GYMyyQA399Nr/U94eG2DAs7pe0M7t39VC9G0ZTVCa6EGLwPNPaLPRGS6HCGjrNCedqGWXqS0rlEARU8g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(396003)(136003)(376002)(39860400002)(36840700001)(46966006)(82740400003)(186003)(81166007)(8936002)(16526019)(26005)(8676002)(2616005)(44832011)(316002)(1076003)(4326008)(82310400003)(36860700001)(4744005)(2906002)(36756003)(34020700004)(7696005)(83380400001)(426003)(336012)(70206006)(70586007)(478600001)(6666004)(5660300002)(6916009)(86362001)(356005)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2021 08:54:51.9057 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 73c188b3-a859-4ad7-e966-08d96613aba9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT030.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5447
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Adding name filed back to ras_common_if to work around error
injection failure with amdgpuras tool.

Change-Id: I9d181a4153b055e22ac6adeb3b51a521c8c2793b
Signed-off-by: Candice Li <candice.li@amd.com>
Reviewed-by: John Clements <john.clements@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
index abc5710898e803..5b5163357fcb61 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -309,6 +309,7 @@ struct ras_common_if {
 	enum amdgpu_ras_block block;
 	enum amdgpu_ras_error_type type;
 	uint32_t sub_block_index;
+	char name[32];
 };
 
 struct amdgpu_ras {
-- 
2.17.1

