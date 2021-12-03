Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B195C433F5
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Dec 2021 22:21:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D40A08BE9A;
	Fri,  3 Dec 2021 22:21:15 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2066.outbound.protection.outlook.com [40.107.243.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6499B8BE9A
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Dec 2021 22:21:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l2wl+MvCdWkjmrAXalmnIeHseWzsEXs6MCmDN4f41TbMQFy+F+GMzJT4Q5V3ER6u2YONF7KgAKrPDPNxkrYTFkyT9ZyPt3BQwbkhNVif72K7iSnBffOqF4rFOtiQtQDGVM0d+uONg73Sh9vJjp91rB/T+hgpaQrhyw8S1D1coLD8IyjpMDAEzETYIngAE4cvWr6Afq1OZrfGuX9HKFxEvm3q5zUNQBgwWxHFll2Go0u65um/2KjCkDoc+dE8YWuZG2zatM5DC1am2A6cnx9aNhQBTY7AFX1cWJK0V0fjVBOP4Vo3/3NSI0Sun+cnxn7cWHhhFpPT6FN2w7Oguy7RAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OHPQayWNkAF9B67fC6Zc+nUw13+OiIP56IqhGPH2jiw=;
 b=G8uvvLv7SD3QkW+ZcX9Jbxz/06vuStuKahNekdU8F4FjYPRRHEnKYlTo5i+C+1vhrBP411PPx00FFl2G5npV1UZ3T702jV6vhByJNdxBmQ3ogTd3wIvPNpsrWaktcE6Wa9zalk8uMmS1Drat7QjQnwNrre5bNiIVuqbxbyXwiq8p4zBBzHcXWRh4hwfAmgqdB0fcy9s9GO4MH2AeINW7+TFPqk5iHaEU/BqSNZuC4+TKorn3xDT0z6WSlbkAIVJ9d1u+rW9pL3zsrRQdhtH34sSLbhh1iLMWAxbBn3ukIC9sIdAhiDmunNXUeHaRnP5vW9PzGnuM4sCg69Gy/E6I+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OHPQayWNkAF9B67fC6Zc+nUw13+OiIP56IqhGPH2jiw=;
 b=4YDQhbGdqjW44XgJzFMebpopO6B0cATQUyBUZDSN+Ka5i3QzJLEBkI9vs4IoI+lQW7hUJgNP2NrRWJkmChnT10DPUk84OFNP5iP+WDGqFcKYTmFWz1MgyTPQZgzovFcLVZ3UFsE1d53DAjbVWW1L2fPijVULIzsrEezbSX5Lwps=
Received: from MWHPR20CA0021.namprd20.prod.outlook.com (2603:10b6:300:13d::31)
 by DM6PR12MB4124.namprd12.prod.outlook.com (2603:10b6:5:221::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.22; Fri, 3 Dec
 2021 22:06:11 +0000
Received: from CO1NAM11FT041.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:13d:cafe::4f) by MWHPR20CA0021.outlook.office365.com
 (2603:10b6:300:13d::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.17 via Frontend
 Transport; Fri, 3 Dec 2021 22:06:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT041.mail.protection.outlook.com (10.13.174.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4755.13 via Frontend Transport; Fri, 3 Dec 2021 22:06:11 +0000
Received: from Zhigang-WS.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Fri, 3 Dec
 2021 16:06:09 -0600
From: Zhigang Luo <zhigang.luo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: skip reset other device in the same hive if it's
 sriov vf
Date: Fri, 3 Dec 2021 17:05:43 -0500
Message-ID: <20211203220543.29433-1-zhigang.luo@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: efd6c689-eff3-478e-0581-08d9b6a91da3
X-MS-TrafficTypeDiagnostic: DM6PR12MB4124:
X-Microsoft-Antispam-PRVS: <DM6PR12MB4124D40297433C5A0177F18BF16A9@DM6PR12MB4124.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aXwCXOz8XB0BhvvzMDnRixDe5ACnngqof0VN7L42yNuslRrTcjmwcIlqH7tzCEQCldWtkVi8KD/KWSUrjc+PLdKytZZEDEJvvPJjOMnTqP6BEE9qP2eFv1s1Hzya/Js7Cmr8M15wRIodG8I7HuiH/k0PjL9cpxPDsYBrhd1WaGHFjohm0U58wqaD932QyBHVDaRiGVUO8mts8cdiVwOkS1kjhhPpqsosfXNr1i3Ka7iktlfb26+uennNpFEnZVuyd0zRZI/ZRxUctsSGNxjiEkegFLWS42JvI7C2u+hYN6Fd9FStgtuBv7ixSvvr/X1f49NF+3V/kFCd5lcwa3t65swK9kGKm4KrNTwKbhDA0+mNsFM/utLXqQjXJ8XoUzJzrT9IwWgbqvMzRRRiGgUz+uv2rCCcB3uIehvCJqKbPg1FmJLsLyPTeyrQFJ9J0UOelicUB+ii7moM2QqWksc/+TbB+3LCW04PkV+X7HlVSMfjAkzRGJu9TJ5abTWFPfWb+6HEhghVUC+tkKRkhEGw//ZcQxOI8MiUPouwKWgxgcg29QYgwV6mP8DpCWPQRbTG0+ZaBcY9x9dESCDhP+mqMNLtpjcQ2Lhlfl/OpGak3s318UF+IVnjS9VvySLE3wbfp6xPgtNdyFhHvofOabMhctqnIdW5mbl1lfoU8OhirVq1m0743gscMr7loAOB9L7QL6T7Xh62DcdVd5mPPRmz/8vH1tvpP7GUQYvJm0VqvrQSjFf598qrg4B3E54U45bMR/VApe7qOvY+AdpCmH/kqV2GnUHRvo4Y/HmR/Xp7OQc=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(40470700001)(8936002)(7696005)(81166007)(6916009)(1076003)(44832011)(5660300002)(36756003)(2906002)(36860700001)(186003)(426003)(316002)(70206006)(8676002)(83380400001)(508600001)(40460700001)(86362001)(82310400004)(336012)(6666004)(4326008)(16526019)(26005)(47076005)(356005)(70586007)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2021 22:06:11.1024 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: efd6c689-eff3-478e-0581-08d9b6a91da3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT041.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4124
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
Cc: Zhigang Luo <zhigang.luo@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

For sriov vf hang, vf flr will be triggered. Hive reset is not needed.

Signed-off-by: Zhigang Luo <zhigang.luo@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 3c5afa45173c..474f8ea58aa5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4746,7 +4746,7 @@ static int amdgpu_device_lock_hive_adev(struct amdgpu_device *adev, struct amdgp
 {
 	struct amdgpu_device *tmp_adev = NULL;
 
-	if (adev->gmc.xgmi.num_physical_nodes > 1) {
+	if (!amdgpu_sriov_vf(adev) && (adev->gmc.xgmi.num_physical_nodes > 1)) {
 		if (!hive) {
 			dev_err(adev->dev, "Hive is NULL while device has multiple xgmi nodes");
 			return -ENODEV;
@@ -4958,7 +4958,8 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 	 * We always reset all schedulers for device and all devices for XGMI
 	 * hive so that should take care of them too.
 	 */
-	hive = amdgpu_get_xgmi_hive(adev);
+	if (!amdgpu_sriov_vf(adev))
+		hive = amdgpu_get_xgmi_hive(adev);
 	if (hive) {
 		if (atomic_cmpxchg(&hive->in_reset, 0, 1) != 0) {
 			DRM_INFO("Bailing on TDR for s_job:%llx, hive: %llx as another already in progress",
@@ -4999,7 +5000,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 	 * to put adev in the 1st position.
 	 */
 	INIT_LIST_HEAD(&device_list);
-	if (adev->gmc.xgmi.num_physical_nodes > 1) {
+	if (!amdgpu_sriov_vf(adev) && (adev->gmc.xgmi.num_physical_nodes > 1)) {
 		list_for_each_entry(tmp_adev, &hive->device_list, gmc.xgmi.head)
 			list_add_tail(&tmp_adev->reset_list, &device_list);
 		if (!list_is_first(&adev->reset_list, &device_list))
-- 
2.17.1

