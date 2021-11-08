Return-Path: <SRS0=eROb=P3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CC2BC433EF
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Nov 2021 13:57:14 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3C4761054
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Nov 2021 13:57:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D3C4761054
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4797B6E0CB;
	Mon,  8 Nov 2021 13:57:13 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2042.outbound.protection.outlook.com [40.107.236.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8F0536E0CB
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Nov 2021 13:57:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dFJEtYW+Pkog8iJs/gl1+DjMx98G2b5LrZsfU2ea49HvmGoeVyAzKSJGPI/6u3etbboWgZCWM9EuUeRBCGmYJygpHFrtcjVomu2Ken4F17dR7yfUYuFgXIAWODhk4Fv9J4NF90WRIlfV+mw46HVCDf48lsbYroP112Xua1y7Q9Zvu17pFNHIQKGS40NAQO+G535jq23YktqmmX3VBfLZVac01fA2/rL3kcFZGOy7WGMHY7B7ADPrebYnFF/KDAxi9YrQ29Ig3NpZ+h1NnqNvn4POBFsoYj/Sn2cgCq8+7FQWa3KTSIag8P00K66yzcGmxEuMk/aMkxJC6dVEoKLcng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=roHT+VkbWzSXSKPr146IH7cbwMPk+RxsPMlgvrNI3gI=;
 b=KRYkzUVUvCBXPoEm2Iu4/y2+NQ8vpXsEsy6S1/DbaR3/thuWJau9X6inxvCSi4VQGiltaEohBVb3J0M1qcnR01tMl3hxKN+MKu5Tntz6kZ7NS1r7x53p7ZlKcLGVfDYw7mV2L2cCjz5bh7cwEj8nTl1Py2+OOiVlJweu7esVX1stjeRM7eUiYU5ZrM0RB020oIag+a4wi2175mUl5nUXIw//F6ih+AMzcTYlDkR+EcW7x5GnL1DenMl4cS3Lm2QZ0uAmhddQ7BITz2Wk4MJYCljjxfZzJw2RmBm+kBabMmMPx+7gOUePOW08r0wdRkdc38s4HDQ+H4ck8mIW6ifz9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=roHT+VkbWzSXSKPr146IH7cbwMPk+RxsPMlgvrNI3gI=;
 b=XdwuJWIQSp24sdFYwAXacUmfQAg4T2YwNZTRRdm7rMDPapPJ9hR1Xe7fsSXMRoanmRO7nu3YT0D0E6jseVQI3ryLCHLl5IM6epls0t3uadYqGUEffvCEr/oPZ5CubhcxYemrFUKBwMRNaH3650qdyW4M5l0aeeeyj8QGZ4XsRw4=
Received: from BN6PR2001CA0030.namprd20.prod.outlook.com
 (2603:10b6:405:16::16) by BYAPR12MB3480.namprd12.prod.outlook.com
 (2603:10b6:a03:aa::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.13; Mon, 8 Nov
 2021 13:57:04 +0000
Received: from BN8NAM11FT020.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:16:cafe::fb) by BN6PR2001CA0030.outlook.office365.com
 (2603:10b6:405:16::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.16 via Frontend
 Transport; Mon, 8 Nov 2021 13:57:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT020.mail.protection.outlook.com (10.13.176.223) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4669.10 via Frontend Transport; Mon, 8 Nov 2021 13:57:03 +0000
Received: from amd-WhiteHaven.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Mon, 8 Nov 2021
 07:57:00 -0600
From: Shirish S <shirish.s@amd.com>
To: Harry Wentland <harry.wentland@amd.com>, Nicholas Kazlauskas
 <nicholas.kazlauskas@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amd/display: fix exit from amdgpu_dm_atomic_check()
 abruptly
Date: Mon, 8 Nov 2021 19:26:45 +0530
Message-ID: <20211108135645.20317-1-shirish.s@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 28d179d2-583c-4f97-f6eb-08d9a2bfa4a8
X-MS-TrafficTypeDiagnostic: BYAPR12MB3480:
X-Microsoft-Antispam-PRVS: <BYAPR12MB34801F82E1A786AFEF751669F2919@BYAPR12MB3480.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +JO2SyUBuZdHeRWCX0M9n0qBls+g7Kdsl8S7vrAcoq5acL7c0ElkJiPHe71ZsDq9SCM0K7QYObEimLpArFJK7j45JBolrP7pTyjFi3vHoW60lbGShiMnAnqzIx08tjyWIj9kjt80ZFCCpPMj10UMwf7rRiQjIYWhspptbKqHNP8YVSrzwMHhXvqEpkqqqz1db/vTH+DiJgeqbJvEuDOp6IQ5olsVOqoA+o/VgJZJi7LBVyigwQ6AZhpvAMflJVUa81/GTdce6prQWIIYO5T4AGVaIh6AwwqhIu6euqeCUrSOky8X1tug1K8CMbQ3AnE59sS4pg99zstd4UFaIIEq6zptk3Y6T1HRnQ2CpOEmkbP8BD8xB5H39L6HZ/rqEGNDeYRnY/QhRfvPgcWivxj572/uIq/Y8R460JKqM8vfDuy6bJqMSR0F/s8/RH8wtiiWNR1hfdywUoOGKzA5hEERkWa9QerejTH5gfSdwC8SbHdxG4iXyLOolRwxLcmM8kSf4OB9AH2Q/Sx0gUPNMLBDdGxnjoNtvtIt6hDn23L7XEs9BAExbCnNgfEYw8F4QiBzFoARLAJVV49HPS8C5E3Yhitxza2G5E8RyHlwoCwv/kL0BIxd1ngVZPCW8xM32szvkAVwvL9nZ2+aYs3swL7DV0blrGPLDEXpyYAQnwsM+dmDKBloLJfhhwqzsy3v5n7NdBfbG8vaNce6q6Isry9cfJvE0rK0SEUK5tINNKo3gk0=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(4744005)(2906002)(70586007)(316002)(1076003)(5660300002)(83380400001)(6636002)(8676002)(110136005)(70206006)(86362001)(54906003)(26005)(2616005)(4326008)(82310400003)(47076005)(16526019)(7696005)(336012)(186003)(81166007)(6666004)(356005)(8936002)(426003)(36860700001)(508600001)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2021 13:57:03.4186 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 28d179d2-583c-4f97-f6eb-08d9a2bfa4a8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT020.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3480
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
Cc: amd-gfx@lists.freedesktop.org, Shirish S <shirish.s@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

make action upon failure in "drm_atomic_add_affected_connectors()"
consistent with the rest of failures in amdgpu_dm_atomic_check().

Signed-off-by: Shirish S <shirish.s@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 1e26d9be8993..a27c246143ac 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -10801,7 +10801,7 @@ static int amdgpu_dm_atomic_check(struct drm_device *dev,
 
 		ret = drm_atomic_add_affected_connectors(state, crtc);
 		if (ret)
-			return ret;
+			goto fail;
 
 		ret = drm_atomic_add_affected_planes(state, crtc);
 		if (ret)
-- 
2.17.1

