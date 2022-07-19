Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0624CCCA483
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Jul 2022 14:04:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8345618B8B2;
	Tue, 19 Jul 2022 14:04:32 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0C3AF18B8AA
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Jul 2022 14:04:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mEirRJ/V1A5V0VZX18f39Vl4HAdSbo1iCuFCMxrls2IV19Swnza+IfZxH5ls51z9KdKHqmJJJ2TbA+hfaB36o0Ngefl6POGSHvmZr7+G+jjPA544NlY661F/P33krOFhXODLJXmL1TzqjiXfVqyaGJN6aF78Q0W/iTqYmuLkW9JjS9d7L3K4y7oGfNjDSN05rc/R+B0YWyoTe12nDHsXhRMlOTBIdBx6XntspXARlAP0e62hqA3tDpiUpqAI72OJor5VaG/mwuaGwjCsZ7X+JSyVl8uhUpExCVf310/lzmHs0DzY3K2hIWf3xKOqpgcspShTqYFRqaC0sDZrcE2daA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G5n/5M78VlsQmjuk3DZE67Zd3qgOoGd0hAyt0xzsZac=;
 b=JDwF1XgYY7ZuZYHddaaQByXKqlPYvyc45DgTgHHwDg2BhFm0ie6SH3ZowrnQ1ajw2Vj+hWTs54QhFNfTxiaem3/9BJqoPfp/A6XUV7aDuK5ecwQ0vhqflsD8igzlcHFP1yYwdFCIMrCf/bF7JT4XW/WPzNufm8SuiGWj+8EHMDGwe/PS84x2N0CSrgLKDAzSgKtYwz0B6LkVYJjFT+z7scjT0pNMEoSBzP4RCJSZBt746IJ6mGG9awHGSUX8vTcf5MxzNFY4PSyXKeyvjwe8wG3wBu57YFlCy0db8k//9X1TUrqlnKIH5kaIK45EH7jPydEwYEvKp2F7jluEVUrdHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G5n/5M78VlsQmjuk3DZE67Zd3qgOoGd0hAyt0xzsZac=;
 b=sdL5uK7x4TMZP1byMdo3ABHjHBP8s10/3ArgE87reAAj3kWTO9zW64/4rU1tDe3GB48TGPJJdvnJ9VCcl4gG1YTRtoFZDw1lzeeHZw6j9rToPBqKMBuYrPaGC6GkEKxpERrrVjc0xPlsWDsGVi8usi/pOk6UWXzmGpM1UC6T55M=
Received: from BN0PR04CA0161.namprd04.prod.outlook.com (2603:10b6:408:eb::16)
 by CY4PR12MB1333.namprd12.prod.outlook.com (2603:10b6:903:41::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.17; Tue, 19 Jul
 2022 14:04:28 +0000
Received: from BN8NAM11FT049.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:eb:cafe::1a) by BN0PR04CA0161.outlook.office365.com
 (2603:10b6:408:eb::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.20 via Frontend
 Transport; Tue, 19 Jul 2022 14:04:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT049.mail.protection.outlook.com (10.13.177.157) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5438.12 via Frontend Transport; Tue, 19 Jul 2022 14:04:28 +0000
Received: from david-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 19 Jul
 2022 09:04:27 -0500
From: <David.Francis@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: drm/amd/kfd: AMDKFD Sphinx documentation
Date: Tue, 19 Jul 2022 10:03:35 -0400
Message-ID: <20220719140338.1644486-1-David.Francis@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f557732c-3480-43d6-b2ba-08da698f987f
X-MS-TrafficTypeDiagnostic: CY4PR12MB1333:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PO4wveE425ZeHeuIgQdIdXOv/rBozyLYHG5eeU44ExFCwrgz/NdlkveqAkml/BrC07r9T7dZ2sHsmcJ5NkNG6lyZ9yQvGQIM4Uf7nEWCBeXadYT27sAsSMJNtpzIVbkPlY4cCI5tprl9ru0I6PinwuSZL57O4aQPDzb0bTj+QtI/RMQN76rmjdbmVrsjjpkL73NKX7r0ZrF7nIzXcKf7BvfhN95197irudhqBbe5oK6ngFYUpfGm3KxZIyKMIt1jffEmwLfycmMnLqG6xbTMA2/NHc9pILcASuLuUXYM8ShUaMkfB7nt/E9Z6EuR+gQR6+54qYyy65bcb9mhqoylS7BZccqWue5/zl4byKj6YgIUAwwEYapvpbEkgub9TaRpNfb0vLNghefbbSh9C4pq5sdm2sm28VDnE7glgtkJDBGk+CsyEORW2qyEl4buSg5LPwJw6tJCSQ2oNXYIYCQUq1Aja7pXLYuefWa4ZXW+IjuRJXNnYl0zkoSUwVFE9/Y1wzTwbOd313SCqdvsyTIQbHBgBxdFMsM6iiQXUxLixdTeLdsyJWYgs2gNoBzBT0W60iKB20VL9c/tyhX/IEa8fX0va7dk81WpWcAD+SoKNHptgWFI7v5AEcExytccljPyuLJJorxfJHQiZWiHYzsyu3FeiaLbCdbDEXPgpqWdi0G7YL9Czqm2YhkE3E1SLZvnUAXLeq8/fSjQonlNViMkBHB5YsxFp8DP3qqZsnDFB/WwAXu4HvU+7ND3/YaJvYXRpc1A2LDN38H7aswsrYZnE19Gpet0OkaSHzlKD2zYfWfVRt1tZsY4n2AtpgP208x0yKMZxvEfDidaByOiz9fcDw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(376002)(136003)(39860400002)(396003)(346002)(46966006)(36840700001)(40470700004)(47076005)(426003)(336012)(8936002)(16526019)(478600001)(1076003)(186003)(2616005)(7696005)(26005)(82310400005)(558084003)(6666004)(41300700001)(36756003)(36860700001)(40480700001)(5660300002)(316002)(82740400003)(70206006)(8676002)(70586007)(6916009)(86362001)(2876002)(40460700003)(81166007)(2906002)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2022 14:04:28.4373 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f557732c-3480-43d6-b2ba-08da698f987f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT049.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1333
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

Make existing documentation comments available through the
sphinx docs, and add new high-level documentation for 
AMDKFD features


