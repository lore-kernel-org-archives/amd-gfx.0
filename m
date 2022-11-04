Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEDAFC433FE
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Nov 2022 04:17:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 05F8A10E063;
	Fri,  4 Nov 2022 04:17:00 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2070.outbound.protection.outlook.com [40.107.220.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1E9AD10E03A
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Nov 2022 04:16:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BX+i0i2Hz/UvOlOyNaXujCthUAVSWIBRC39a7bGbKz464IkXC3ME0s+UyS91u6bWdTIRysMVF9yTOCA0wcX7wftbBXnxllNkBUh6f0a0uiyCYLniNH8X0dYdT7M2J3Ey1Phh2nAo1XSrdShOY9xgsS7ohBIByPB0OZvYNPVYUoJke4mxOnEETrAgZWf05OsbFiTxJRs3y8Y6271OcWIDTCdzObelB8AhTUKYvB6kiDdekkO0FhznMguHzgS6U7OH8bBxQrMhKILwtU+ZJXFnF7NUoJNsjYmzhOwD4IChD9+IY4Cm1TFQl/95mO/DZQhbFUE8/czMhL6u6uiyu9bxxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cuit58soBKoXgain01KsRXz4tCKl1U0sBUyBV5h52nk=;
 b=CczUq9ME1FsPTSjZLFJuasOGNo0m/D7cqtf5oJUvMn9BC1SGrg7w0vBiV1vhAivHj+nMvmBlozbhKZBHjV7fq1Pyc0F7hmlbeYf3Tw/ebfn5wR9rFABC9FZAbvry/G0eJHoYK0LU0FqQyy3qmBRP4QkpwzoQau8Q3y3wbJw6dI0nHbaz+v6Z+dNFHnRC57MyGGT/yNaBNp0RnLKpv8iyztRnIzQDQXOM6PnDv7BCf8AGJ67Uy4sS+obDxPQmFB0f1JvyxYTJNw1qTOM5W2VDMfafewZJjbBB5Oz6Ngap6oc0PVeBxqsZ5NED4NRH3RHoY+WCF2Crdqmokr6lfv8S5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cuit58soBKoXgain01KsRXz4tCKl1U0sBUyBV5h52nk=;
 b=yycIGcyFGSH9Ujnq9K5kiVDJG3DYy0h3l9hkT9aL2JKJ8aFvjl3xvfbOB8t3rH1yFR7Nl3lgxjyayVla7Qm0JnQQG1GX6dkYuk+rqgmsfekakxFUvXcOQfPHfNh75L2iALAcFV2Wf7SF9fmzYmAFgZpHvPmndUY2Ljre0YtzGms=
Received: from DM6PR21CA0014.namprd21.prod.outlook.com (2603:10b6:5:174::24)
 by BN9PR12MB5210.namprd12.prod.outlook.com (2603:10b6:408:11b::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.22; Fri, 4 Nov
 2022 04:16:54 +0000
Received: from DM6NAM11FT072.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:174:cafe::97) by DM6PR21CA0014.outlook.office365.com
 (2603:10b6:5:174::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.8 via Frontend
 Transport; Fri, 4 Nov 2022 04:16:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT072.mail.protection.outlook.com (10.13.173.181) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5791.20 via Frontend Transport; Fri, 4 Nov 2022 04:16:53 +0000
Received: from ETHANOL-3.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Thu, 3 Nov
 2022 23:16:51 -0500
From: Harsh Jain <harsh.jain@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: wait till Gfxoff allow signal completes during
 suspend
Date: Thu, 3 Nov 2022 21:16:34 -0700
Message-ID: <20221104041634.963830-1-harsh.jain@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT072:EE_|BN9PR12MB5210:EE_
X-MS-Office365-Filtering-Correlation-Id: 138a1160-90a1-4a17-0ec0-08dabe1b6791
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cA4ejX00pbqA9xs+9U3gbcOjnib6PMQvoGysNADzlvc9xWxgGvbL0JMita4DBzADpt53tv7TXJ1Nzk3aR8GmEYVfOs1U4vsJVmUsTn7wYhSjCrZNGcrCA+SL1eEQUEC1KyLN7e0sMUTGB3rRb0uNh0pELOuJNW6xYbXIWLstMRGNbui9eHoW1VarnEap3Sp7JsLdnYlpjJ2lgSAl0+GGhPx0DgGdzWN0R54GJHd7tBG/2j6lyhm7CeMEvd3z2qHmWmjXfUqdhJNbyxIR2CTpOiGCAx3ykmu/xpHLeCw9bXb9E1xqyQQ7GHS5XCYHGoYIclXpTeCd5wPWy9o2ARt3jxaqAb1WBEnDe1wiwQKkfy9rx09ZpwKxiJEba8caQdK+e1CsuTLxT57c2chi8Cc3K1kT05g+FMB+GuTLQx2fkY/68KESS1qp/4LLZGelpZJu88N/NTAdT3Z3VKvF+8ilaxrkrEpLC2MtDLqggWBbSzkXfXX+lPJ1Nd3j3zcpjKkWxqIU77TiqyEv1opU22WoipYyW5vfvhclTikTayoQu72lABik6iN7I8IclafWPdWs1dwlD6Xy9TPUy2L1iJuBYD/RNICaY+4abE/3DxIe+6lEycQbTzqezwHflvUCh0Yb/0tjkSS1h9jvIl+45F+Vg6cWjC8RTLYVwxdsyFDaXbKuG/RI6zM29pkkbzrf+B+maSQx4Iwn0kAarPOPSlJtBTXltDOW4hPHiJye37CxQHdrlh8oMrLj8qf6hmtUD5iNusq7rS9GSh88KZtynYXlEdykDCEM0lcdCrPDwq8A/2o=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(376002)(346002)(136003)(396003)(451199015)(36840700001)(46966006)(40470700004)(40480700001)(356005)(82310400005)(36756003)(81166007)(41300700001)(40460700003)(26005)(8676002)(70206006)(4326008)(70586007)(44832011)(336012)(1076003)(16526019)(2616005)(86362001)(6862004)(186003)(5660300002)(8936002)(478600001)(7696005)(6636002)(37006003)(54906003)(6666004)(15650500001)(316002)(36860700001)(4744005)(82740400003)(2906002)(47076005)(426003)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2022 04:16:53.6363 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 138a1160-90a1-4a17-0ec0-08dabe1b6791
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT072.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5210
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
Cc: Harsh Jain <harsh.jain@amd.com>, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

change guarantees that gfxoff is allowed before moving further in
s2idle sequence to add more reliablity about gfxoff in amdgpu IP's
suspend flow

Signed-off-by: Harsh Jain <harsh.jain@amd.com>

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index 222d3d7ea076..5b2afe348c23 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -581,11 +581,11 @@ void amdgpu_gfx_off_ctrl(struct amdgpu_device *adev, bool enable)
 
 		if (adev->gfx.gfx_off_req_count == 0 &&
 		    !adev->gfx.gfx_off_state) {
-			/* If going to s2idle, no need to wait */
-			if (adev->in_s0ix)
-				delay = GFX_OFF_NO_DELAY;
 			schedule_delayed_work(&adev->gfx.gfx_off_delay_work,
 					      delay);
+			/* If going to s2idle, no need to wait */
+			if (adev->in_s0ix)
+				flush_delayed_work(&adev->gfx.gfx_off_delay_work);
 		}
 	} else {
 		if (adev->gfx.gfx_off_req_count == 0) {
-- 
2.25.1

