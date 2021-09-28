Return-Path: <SRS0=UpsA=OS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 765D9C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Sep 2021 16:46:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4012F6101E
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Sep 2021 16:46:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4012F6101E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C738C6E8EB;
	Tue, 28 Sep 2021 16:46:31 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2045.outbound.protection.outlook.com [40.107.94.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6408A6E8ED
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Sep 2021 16:46:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cBhYgmcMyOrMZSeDv83mUe7jg84gnabtTOqkw85KPhrx04q6jjlsAfg0u2GQq9xhQF8ekO1tfnxKW0My0CCYkvgqonAws2PN0v4UzrQWIfAGm6rScFdIzKaeJkoyc+CQL1cCK8L5IfFruDvxad5aD1ilbshm6LCPCmq5edTkCj0ugrmfwLRgjOc5tcqrdJsAPyCEXAaVn9WsH71f0cJTEjczZY/LLgGowrfbPKmU+LPeDDD8biB51NJhSgAs4MqouAqd6udKxY3pPsTvnpd4B7Y16rJLt7DbAdd8DqNVLQwNOeOg41vwrbBNojYgOwwvyqqrIHeyJkjAG6y7MZv0nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=l4Amlv5WEZxT6qq2QPY/UpqK1aACNGQU+zZWxn/0JMQ=;
 b=IM1PJV+P/7lpiQID8A919yDAUP5xp+le+FquKqBmHWlDuEfFXYq7qnJeqFuOSAdxzkn315eenEsFFHX2lbOSxWeaQ8bJyN+rrHpDEqZg1w2F04xtzS+aX/YABQj6arYeR9qHSY0wAqSNLSARzM6QfQLvs3TPGiL2Y1WNoUtd+vGTQbS2W893VOQZa0rCoGK58fa2T/P2UpHueuyb28d6tMLGW8YSuqI/VqPO84DGA60eBTzVpi64amHpV4mdYuP2fK5nlemOQNBRzTMPapwcaJX5HA1zmdbXmLEfZHbCpDcTPMUYCGmiHy/uI48+9GdO8z4EuNMS37UVoNl2fbWadQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l4Amlv5WEZxT6qq2QPY/UpqK1aACNGQU+zZWxn/0JMQ=;
 b=ZwgLWZIw/5bepDXZPv2azw8hk26qlRvWZ1gRqYpgZLhVSYiyf1IQ+Vi/OAnWXLpScQXpLUhyxk33VzKX+rwUOxNFbmsJdzvZouGSfVjrGnobJZ6yXiI0f2cPoRvw7Z7XVx3S6sogFxw5BgYzdiYAIDyk1DHWg/ET3EbVMj8OY3g=
Received: from DM5PR15CA0043.namprd15.prod.outlook.com (2603:10b6:4:4b::29) by
 DM5PR1201MB0138.namprd12.prod.outlook.com (2603:10b6:4:56::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4544.18; Tue, 28 Sep 2021 16:46:29 +0000
Received: from DM6NAM11FT068.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:4b:cafe::7a) by DM5PR15CA0043.outlook.office365.com
 (2603:10b6:4:4b::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13 via Frontend
 Transport; Tue, 28 Sep 2021 16:46:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT068.mail.protection.outlook.com (10.13.173.67) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4544.13 via Frontend Transport; Tue, 28 Sep 2021 16:46:28 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Tue, 28 Sep
 2021 11:46:24 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Subject: [PATCH 58/64] drm/amdgpu: set CHIP_IP_DISCOVERY as the asic type by
 default
Date: Tue, 28 Sep 2021 12:42:31 -0400
Message-ID: <20210928164237.833132-59-alexander.deucher@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: b09800df-ae8e-4663-0b4d-08d9829f84a9
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0138:
X-Microsoft-Antispam-PRVS: <DM5PR1201MB01384CF9B4F7CF3425275027F7A89@DM5PR1201MB0138.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2399;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JeGMBUY6fLLNPdEc5PoP8GLrlmrPIdcrQYqqBcoq5AfwN15zJupwFJENP87XGwDlaoEdgz5vilXGV4fquz2g29psZ3gDP5f+6hHygoVFrWZxyhWxtK/1VV0TiBaWUPFLgPyG8xw0iQK9xPbd0XdLknjslZYESvIWF5OwRP3dq8IJAmCt2Hf7YsmYM1yN4fcE/Hb+CFvTUvwt3OZAEZa/FNyQYpFVNG5LYZOd5x39umAwgzlylAq+SSji1ZYxlYvc5I+sor9Kh3PjbKEibLbKSHJRZ2WDdxXYF6PVVJcRBh3xPUK4KMEpZq1QUhuvRVWlytFatRe0sUT/eOcRvMZ73T2Ga/q9cKpf5yYw/V6CrkDggTL2On1SZ6cFVTSw1ApcHsyeegAUcNkVg3qFiQW+1EtrYWdq6/5/pAj+ekbdv+drgMwImpmYZF0T+TFyF/j4wTtJJVsrwwgs/2OIenD4nVFZkNFRyu5bW4OD62h4+Pbnc3s/u+6Qu4ihsv4DnSyRfxxhLi1YC68POWMJ4SQW0hXCfqMeZs+YEULcLOjpKRRVCEKTn7vbdBG6RmAJ8+iNYkJqwFfZi7Dyyka46XwcYq/g6uYsFFgaiFhN6BqwYhjw7+g1GnstIkSEsG/n3/hjYBpGVKfcbZ3ldeZ2N/Tivs3TCWgU+o3zVFxN0tA1Ul1xFBNzPu4UMYShCfvn/WIM6B9oDR3e79rQIdWpdmfU8RFR9qtrKepGjiVWuEqje5E=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(4326008)(26005)(5660300002)(6916009)(508600001)(426003)(4744005)(336012)(36756003)(2616005)(7696005)(6666004)(8936002)(8676002)(70206006)(70586007)(16526019)(186003)(1076003)(82310400003)(83380400001)(54906003)(2906002)(356005)(36860700001)(81166007)(47076005)(316002)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2021 16:46:28.5918 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b09800df-ae8e-4663-0b4d-08d9829f84a9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT068.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0138
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

For new chips with no explicit entry in the PCI ID list.

Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 8953cd430506..670b09fb5d34 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -1873,12 +1873,12 @@ static const struct pci_device_id pciidlist[] = {
 	{ PCI_DEVICE(0x1002, PCI_ANY_ID),
 	  .class = PCI_CLASS_DISPLAY_VGA << 8,
 	  .class_mask = 0xffffff,
-	  .driver_data = 0 },
+	  .driver_data = CHIP_IP_DISCOVERY },
 
 	{ PCI_DEVICE(0x1002, PCI_ANY_ID),
 	  .class = PCI_CLASS_DISPLAY_OTHER << 8,
 	  .class_mask = 0xffffff,
-	  .driver_data = 0 },
+	  .driver_data = CHIP_IP_DISCOVERY },
 
 	{0, 0, 0}
 };
-- 
2.31.1

