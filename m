Return-Path: <SRS0=UpsA=OS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98107C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Sep 2021 16:44:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 671D661266
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Sep 2021 16:44:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 671D661266
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F193B6E8C6;
	Tue, 28 Sep 2021 16:44:10 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2057.outbound.protection.outlook.com [40.107.95.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 612D96E8C5
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Sep 2021 16:44:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HEbvNpPM7Sk0+JNeBAkVHzFxDd2YtTG/n0vo8WZ9q6xfZA5ITg8kB48aMBcvG2sskxgnnYz+BB05lDoLuF4QqYgLcwa8WomnvRangGa08X9lkDSGwVyl0dURu6uLJAMHGzJCknmViH0s1qZSLtKnqd1RrizaBzL8gWYqeIO9cgzl3yPDLsAgXxqRBacTabobfNvPAinV/kyLyDuPLUZ7ugVawVKLCDc5uYX1FiqrDP7N1YmIAKzLSmKRwcN9o2GtuzaT9jnjo/37OJMi4iu4OMIHuPFzdjxMTpf89282zj9uNmS8OyP5av1LrFS/OUkf7KWwBkVzJzFOZXdx3Cf99g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=yQ3Ur/n8ELSoIgM8efV1MZlgU6trZ0FxjzSTy2Muy70=;
 b=ZkK7jY95vIYhYkYdsweQY+pJKzp35damQoVPDl/X5cSUTOq1FwUzn0OPrUhJWt49V9cSpGcXizrT5rNcXaydwtHRY5Eu8ygAMUo1UWx4QQHsTsWdZvQwwZsIG9eC+uhCJuYEWhO27iZxH8DE8hCLjB0pSpxJMZIVDAi+Vw4pLvVPviRKftmHMum0WVEEEr0/kJWRYkLNZQl9imtXsOTeMFt3MmSDwtYiwVIhoB5WwsnLfJUkyzOdee+eYtj6F887OQbNxIVE7FgkuCR2Oe/ryZG/Etuvq40HR4GJ3L/3U8U+dksOf5qPkALYcpdP9duaBF6csygGGS/ogojBZlulRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yQ3Ur/n8ELSoIgM8efV1MZlgU6trZ0FxjzSTy2Muy70=;
 b=akzhOt9w1uQTsCcxybxeJeG9posUeVXuYzr2Cmc2CRnLyGaxKInrEGwSkFQ4Z7Sn2NOolMC9zQNe9+4FEDN1cX/l2hTEr45nDhnFVQ2fHqWGW6pdMErBuEKz/ER90yMXYnabDtbyPjH8cJt5NIzPPK79jN985rA3xWZiNCz1Siw=
Received: from DM5PR20CA0002.namprd20.prod.outlook.com (2603:10b6:3:93::12) by
 BN9PR12MB5065.namprd12.prod.outlook.com (2603:10b6:408:132::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13; Tue, 28 Sep
 2021 16:44:06 +0000
Received: from DM6NAM11FT018.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:93:cafe::74) by DM5PR20CA0002.outlook.office365.com
 (2603:10b6:3:93::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.14 via Frontend
 Transport; Tue, 28 Sep 2021 16:44:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT018.mail.protection.outlook.com (10.13.172.110) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4544.13 via Frontend Transport; Tue, 28 Sep 2021 16:44:06 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Tue, 28 Sep
 2021 11:44:02 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Subject: [PATCH 18/64] drm/amdgpu/mmhub2.1: convert to IP version checking
Date: Tue, 28 Sep 2021 12:41:51 -0400
Message-ID: <20210928164237.833132-19-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210928164237.833132-1-alexander.deucher@amd.com>
References: <20210928164237.833132-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bf2ab53e-5c3b-40f8-32a2-08d9829f2fda
X-MS-TrafficTypeDiagnostic: BN9PR12MB5065:
X-Microsoft-Antispam-PRVS: <BN9PR12MB5065B4A2452916239FB43270F7A89@BN9PR12MB5065.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:361;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: O8V+ZOQldygxbReD8/iOA1uMekApYPTB6N/83gc3SGW5iEupOH50QWdNaLdKSIS5UlgnLvkGjc8hiMd3pTJRlgX0OBv/yvBHe1TTc33co1XrkQjSkjxZY9OQ+ywPgIj+To/JK1+ol7phL8P+ukfqOJwEsN078WWlQURgo66SYt1ZofpczYz8L9oI0sYPWgh0DkJJrpgfRebLsOaWjeTxy8RIMkAVdS7Y+um8gdcrifs1usiMhyl9H3JLdNg2N1cFnhgnEDOGekSaJmz/t0N8fWsrTf8yQhqlF5HJi5xCXmqh2khb0etGbnyw1KqLuzWWbEfqfttiG+/17h0cDiGTXR5QEf16XyiyfK7Cf67s3VzHbL19c5v8Xxk+LrAuWmuObHFIQTw0ngU+z0vse1Rdx/cA60938jmo8Cta4YWY4WaEw/RVL+xQwO8YRrYT5XQxpau9k8Z3biSiED4yhhVW4nDKn+AdcldtNZ2BBT/WlpjR1UoOWdHAG6t51FCyJ6qcV4zuZezYzge2U9KSYPohWimD8IGfYIcFMiZs/lWeaTk+z/r1LQvWeK937DRg/ZlZy1731te5a3ya89/dZTvRSzwFGUuR7zPcXSbq4mB3+FKHsg8i/9XjWpaI4kizmoHAGNnX/1KxM7mhZbE149ZbSA6qb0PcvVfp8pWmjlinX+bKpURjm52ffa1Ja7z2Yu0kq2q/289wZQ9MVTDD2ZEyAVeRu9DL2HgGn4KUxl7nMaY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(47076005)(6666004)(83380400001)(8936002)(316002)(1076003)(4326008)(186003)(5660300002)(16526019)(86362001)(26005)(81166007)(356005)(7696005)(36860700001)(36756003)(70586007)(70206006)(336012)(4744005)(426003)(2616005)(8676002)(82310400003)(2906002)(6916009)(508600001)(54906003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2021 16:44:06.2816 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bf2ab53e-5c3b-40f8-32a2-08d9829f2fda
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT018.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5065
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

Use IP versions rather than asic_type to differentiate
IP version specific features.

Acked-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c
index 88e457a150e0..4cf5d0595bbe 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c
@@ -90,9 +90,9 @@ mmhub_v2_3_print_l2_protection_fault_status(struct amdgpu_device *adev,
 	dev_err(adev->dev,
 		"MMVM_L2_PROTECTION_FAULT_STATUS:0x%08X\n",
 		status);
-	switch (adev->asic_type) {
-	case CHIP_VANGOGH:
-	case CHIP_YELLOW_CARP:
+	switch (adev->ip_versions[MMHUB_HWIP]) {
+	case IP_VERSION(2, 3, 0):
+	case IP_VERSION(2, 4, 0):
 		mmhub_cid = mmhub_client_ids_vangogh[cid][rw];
 		break;
 	default:
-- 
2.31.1

