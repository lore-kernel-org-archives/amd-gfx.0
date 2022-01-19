Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6493BC433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Jan 2022 02:56:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 08A7010E1EC;
	Wed, 19 Jan 2022 02:56:57 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2063.outbound.protection.outlook.com [40.107.94.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C3C4810E1EC
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Jan 2022 02:56:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=foUcr7MC3yCHqxpGH1R8q9C3GZtNzTq0zLLuhcQhU5pEDIWpMMx2w754KPSxpNdqNUeRF8eHedx3BAhWntxkObTublrDGoBr3j6tvqBUKWEo9UhbVrcykpZFkhflFhaXWPp+lNiDsg12zCM0RE8JChbLe6t6kNi/W/Gf7dEj/GvGi9+7TrVts3XTZqtpuQfnauzk0607zoUICCCQ8ORrcGWovatIzNHWO1bLCIPdgKzy1eI3aenPDkFmDTq+Ym9A1ptQ+pFjQasHTnfz2KYOxMI7ikgAUJcUGJRzIQEz2X1M72bfLkLQ1mFeFh221j/u3LKPlnedRDj0YJs5pMoeEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8qCsQZMSumU+z2WN91vyADk4j3lt7BwapL+Pbt2J7qo=;
 b=lNmBldAVgEiaMcRdQ0iUo+LiBTf9UVAVm/4Wyv7/xzPeO7ssT8wepsMtry5kiV6SKRxx9X6AUNMnbidYRiBXjZLIynLyYwHSwZrMaT5ir8/5jxxVSYU/4a4otjKi8DwZx2DnDxlSp265hdxRxNqhri9x7l03UGuybEvV8Iq3gf8vsRKhYERLWSVhG3FvFivCINyYz27PFdcCi+zH7ZKv6xkxzTpf5cHOu3cwXGHbnEAGfWuR3aa+hZbP/HBfIXwzMovQm1TvCi485DURUZ4YZjK0IDyesfvHl6JNwdKnp5JhideQxF/YRZ1DPeQbZTRZ6MmMVqkqiqqxGw4aaML8iQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8qCsQZMSumU+z2WN91vyADk4j3lt7BwapL+Pbt2J7qo=;
 b=qWwiTDJCeD24VsPEqITXUjyk3Xu8ig1sPEjbq3nsABvmc5dRDpiMF6YrGNPpXtkeEaYoAOXDY+zI8kzZVAuVgkzPiv6aY+owF/p5kUjTQZr0W5GiNm/p35kkx0aX+B8UMUXx1tBbiB520Pu15GrH0d3fvemKFwuc1I8n6Az5JjA=
Received: from MW4PR03CA0216.namprd03.prod.outlook.com (2603:10b6:303:b9::11)
 by CY4PR12MB1558.namprd12.prod.outlook.com (2603:10b6:910:b::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.12; Wed, 19 Jan
 2022 02:56:53 +0000
Received: from CO1NAM11FT035.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b9:cafe::5c) by MW4PR03CA0216.outlook.office365.com
 (2603:10b6:303:b9::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.11 via Frontend
 Transport; Wed, 19 Jan 2022 02:56:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT035.mail.protection.outlook.com (10.13.175.36) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4909.7 via Frontend Transport; Wed, 19 Jan 2022 02:56:52 +0000
Received: from thomas-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Tue, 18 Jan
 2022 20:56:49 -0600
From: yipechai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/3] drm/amdgpu: Remove repeated calls
Date: Wed, 19 Jan 2022 10:55:53 +0800
Message-ID: <20220119025555.197467-1-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b3d4e50a-a76e-42a4-cafe-08d9daf7589c
X-MS-TrafficTypeDiagnostic: CY4PR12MB1558:EE_
X-Microsoft-Antispam-PRVS: <CY4PR12MB155842D2E32BDBC1EAE70A60FC599@CY4PR12MB1558.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:304;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iOKvAZavc3ppUzQhBmp6oO5G6yZmFh/5ztkOsgoFVACuyEcRd+WsvjCHvLmq7PEPM06PySI9hwhcsul70726hebqdeENpR+zOi8Ey6VGYszAmeh67+CZ5GKf2mI/iku4d6XY2I+REhevrWzyOxvaaBDN4DkjIsUh8uik4ppOJX50v+F1ruTNg4QKyQGhsBmnjG87Q00F46WOTynBD0yZ0t1UEInHgZA9YkAYJ78XLJ3/7zikGLsqsiE+5tfgVeYkIbpyBNi/hsLER26Jpoz5o+YdDHJZTUkk3LCUJwRO/47f7l/bRmuEHiqnJoJg8K0yUxQZcMGaSXn0grZUHVHs1g3fu0CJTPYdqyGbuOmV0jQXxxM5uYB9P4WdKYTxUT7HBSoOVSdLn++IcwxYr24V/pe1xC7YSpzBzuE6VsLzOTDlEbX0igg/zvQruh+XbfmS5ZfUFjeOYSuB4TR6E198hcQR+fTHN0ymqtvrrouN0xiIB3BxBqpwS6VDDgctjtIGn/ilUrvsCaX5EKedQ8owbNJAoGJ/+mTnPzTc0z1e1UKxJGPtwkOxiJq6uO0nll6a5pqI0Kzxyu+x57rErAhZOgu0h4bjSFomW5ZzligparDqkzYMiUYPQNeJ6DeI/u8IqDigoC6wXp5OyaVkvzGD59yEZ4XARMmgexZh39I6b1MSdoW7yPmt/83GtFRIN97kHkD5J4h4FrfkLoo8wseMuLv5nLq4hof9mUKLxJRcinydiSejQuEwtxWG2jHpJwiN5G0j0L2EW7+/ncb9CvN6inC7i9ZKtd0R1zEhWPy1OODt2VMm2K0Z90nUsnPHKZj1
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(40470700002)(36840700001)(336012)(2906002)(47076005)(36860700001)(83380400001)(4744005)(81166007)(70206006)(86362001)(1076003)(70586007)(82310400004)(356005)(6666004)(40460700001)(508600001)(186003)(16526019)(6916009)(4326008)(36756003)(8676002)(2616005)(54906003)(5660300002)(426003)(26005)(8936002)(7696005)(316002)(43062005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2022 02:56:52.6521 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b3d4e50a-a76e-42a4-cafe-08d9daf7589c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT035.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1558
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
Cc: Tao.Zhou1@amd.com, Hawking.Zhang@amd.com, John.Clements@amd.com,
 yipechai <YiPeng.Chai@amd.com>, yipechai@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Remove repeated calls.

Signed-off-by: yipechai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 7a1d2bac698e..4992bc554c0c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1704,9 +1704,7 @@ static void amdgpu_ras_log_on_err_counter(struct amdgpu_device *adev)
 static void amdgpu_ras_error_status_query(struct amdgpu_device *adev,
 					  struct ras_query_if *info)
 {
-	struct amdgpu_ras_block_object *block_obj = amdgpu_ras_get_ras_block(adev,
-									info->head.block,
-									info->head.sub_block_index);
+	struct amdgpu_ras_block_object *block_obj;
 	/*
 	 * Only two block need to query read/write
 	 * RspStatus at current state
-- 
2.25.1

