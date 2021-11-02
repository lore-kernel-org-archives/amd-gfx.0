Return-Path: <SRS0=itHt=PV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 258E1C433EF
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Nov 2021 15:04:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B26B960E98
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Nov 2021 15:04:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B26B960E98
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 499C46FF71;
	Tue,  2 Nov 2021 15:04:54 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2068.outbound.protection.outlook.com [40.107.237.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 33FE76FF71
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Nov 2021 15:04:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G5Nvd4WBNuLWaRMu8AmRYomne5neZC5buWgqKFtOjq6aiObwYS/sYBrxCp4qquGCP2HB8h+BF4XATgvYsoAwWcOGjfyCfMZ91C7GnnkjrFfBKHEMEKl9k1Aojb5ZbrrZu8j+4gDT51o8wY7bAXGDglVOj0sanPpSSmXheYvqqIyt5Qp0Rz8ghigy/pIfbYpowYkoLp/5g7Rzn5kaDGd5VRH/unSIprWkCOka0NE/W4VRnGXUbZ77ale61NU13xG8TGvnYwt/lnoulpQccoCqFa4Oz2c/oVLTgKbZKRBbK9D9sz8SEYCOcnI8EMsiEkDWvTFecICVM5EovZB3rKSKsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NX22M/6cLLY1s+Mb6mIp1eBZBzKYtZbJkyy2dLL96M4=;
 b=dfyTX8VufUOyQTxoOuKJ07NzoF/9nNVCVAZx9WkfxWPFLWamZL8q4AdhRZBce1mbOY7qGUxPqWX+DVBkwIvyJMWsrs5wo1oQjKvqUoFDoL/1HjaMbVb8xKXRNE0dVNuUeuWCmvzSyg0PyORMED7lrU9YqmlXz2/ET3trjasyiA8u2gmKtIjX5v5HvrXBRy5Mcs/DefkuWBvchE9pfG5KzZ//JvOiqyN6aSAH7sOCv2mOiMT2rkCsTIXKErAADttuXFRNRY/CWXHAU3nTm4Uk4IiG071+q+o1R2zjxySaeDAoBgIgFisBXVpWEvb6YdbVEPCZg/MhLP8YWN+R7ecouw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NX22M/6cLLY1s+Mb6mIp1eBZBzKYtZbJkyy2dLL96M4=;
 b=1vAfPQH1Db9UxloIPaAJJx8er91n9M3xdudbABNA5/ss6XmQZngB9jBBXNitw5Qu5OgS6iO5Dqqa1+TSe7GZgEerklY1G45NATOiuYPd5dZv6Z7Iwxz1p50q4zguy6AT17Id63Jj0DVxq8JdV4ZGYHOHYNquzLlGBgXbjTcr2Ns=
Received: from DM6PR06CA0014.namprd06.prod.outlook.com (2603:10b6:5:120::27)
 by CH2PR12MB4024.namprd12.prod.outlook.com (2603:10b6:610:2a::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15; Tue, 2 Nov
 2021 15:04:49 +0000
Received: from DM6NAM11FT018.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:120:cafe::8b) by DM6PR06CA0014.outlook.office365.com
 (2603:10b6:5:120::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15 via Frontend
 Transport; Tue, 2 Nov 2021 15:04:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT018.mail.protection.outlook.com (10.13.172.110) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4649.14 via Frontend Transport; Tue, 2 Nov 2021 15:04:48 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Tue, 2 Nov
 2021 10:04:47 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v3] drm/amd/display: Look at firmware version to determine
 using dmub on dcn21
Date: Tue, 2 Nov 2021 10:04:37 -0500
Message-ID: <20211102150437.19370-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1fb1f32b-0a46-4eae-7253-08d99e121d12
X-MS-TrafficTypeDiagnostic: CH2PR12MB4024:
X-Microsoft-Antispam-PRVS: <CH2PR12MB40241AE767313AA522A3997BE28B9@CH2PR12MB4024.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2399;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tENE9+RNQJv5LU2hpFyQ013XmL+FqMrJRuYLOlVAfecPUQ4KGZrBmcBtGyWFs4cMwNRQQy5JVlqTS3+gO/FoxCYRsynRTfm/0olRUUmiXLIXkAmM8rbeKhDb4bzoGSqOW8e0QC7Bf9aoRAMYm1KUxBVoURYNANZLZZgx83e996rFB7qyDkWeDFqkh5wn3/s+Zc8h079ghqP0O33cntmZRvQzEHWowX9I+/xx3lU+VDDmAvfIKeNXu3B6COWDEJyJnGIVpOoxU27HYtDOhmVn51kvQ+06ImQ3bi/IVYlplCAZfWt20XyZnJ7yhlPObFT+bYYQ6mNMVemocH1Wu/xBGR5lBXJoFaaH6KgTZ2FU5T6AM4+ah39Iu4h4N8jTx2T1qHTFYpmVumTJczzw5Cv5jaGOUUWayioABSBgvZ6XBarq6fWOXwARhkYsZHP9QAnJwxHPMqLCxE2LYkl1iNogqF6GyjW7O2GYnoXAv2auW9nJInAXg9UbRJhchOYkDue6dCGhITbw3//w4wgoB6X2RhJCOYOpeooLozoJ7bUSCcf6loOiDdLnpIS22d2Es3q4E/wQbdUeSTV4Sk6gdhwy5DxXBmGYd0KhgJyG/kvA+P9+ipS8nQPlfwLSltuchnj4mSywektSgkK3y6ieFGdZSQdIIkj7AFA0LSfnp2H2OcpTDzemtRMKigABXC0w7kBErv9IasUJCM5BdojqywwnFcRaPeecns1iLohvNfQGNK0=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(5660300002)(2616005)(2906002)(47076005)(54906003)(70586007)(8676002)(6916009)(1076003)(966005)(26005)(508600001)(186003)(8936002)(356005)(44832011)(36860700001)(316002)(36756003)(70206006)(16526019)(86362001)(81166007)(82310400003)(7696005)(426003)(336012)(4326008)(6666004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2021 15:04:48.3134 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fb1f32b-0a46-4eae-7253-08d99e121d12
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT018.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4024
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
Cc: Mario Limonciello <mario.limonciello@amd.com>, Roman.Li@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

commit b1c61212d8dc ("drm/amd/display: Fully switch to dmub for all dcn21
asics") switched over to using dmub on Renoir to fix Gitlab 1735, but this
implied a new dependency on newer firmware which might not be met on older
kernel versions.

Since sw_init runs before hw_init, there is an opportunity to determine
whether or not the firmware version is new to adjust the behavior.

Cc: Roman.Li@amd.com
BugLink: https://gitlab.freedesktop.org/drm/amd/-/issues/1772
BugLink: https://gitlab.freedesktop.org/drm/amd/-/issues/1735
Fixes: b1c61212d8dc ("drm/amd/display: Fully switch to dmub for all dcn21 asics")
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
Changes from v2->v3:
 * Don't special case Green Sardine / Renoir anymore
 * Special case the two Renoir firmware that have this problem
   (that weren't released for green sardine)
 * Special case development version of ucode version
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index b48f3cb5ddeb..dcc97ef28c50 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1410,7 +1410,15 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
 		switch (adev->ip_versions[DCE_HWIP][0]) {
 		case IP_VERSION(2, 1, 0):
 			init_data.flags.gpu_vm_support = true;
+			switch (adev->dm.dmcub_fw_version) {
+			case 0: /* development */
+			case 0x1: /* linux-firmware.git hash 6d9f399 */
+			case 0x01000000: /* linux-firmware.git hash 9a0b0f4 */
+				init_data.flags.disable_dmcu = false;
+				break;
+			default:
 				init_data.flags.disable_dmcu = true;
+			}
 			break;
 		case IP_VERSION(1, 0, 0):
 		case IP_VERSION(1, 0, 1):
-- 
2.25.1

