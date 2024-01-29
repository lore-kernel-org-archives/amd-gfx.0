Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79B66C47422
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Jan 2024 03:54:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 189E310F5D7;
	Mon, 29 Jan 2024 03:54:23 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2055.outbound.protection.outlook.com [40.107.243.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1456110F5D7
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Jan 2024 03:54:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E7FO8rqlkLf7CMpB7E6CdKOBqdAgQktE+1c64f0TmTGIphu0Om/ksaf01lMiEoMMp1kmzoEdgJrJozVLz7sqnlGF5Jg5kGAcRCIldHDIrGO7sD7i0sBexBUAIhxReLzbJVpY4AGuHyhM2ZAxw3Up89od9ww4xHDuoqrp4LpCmNNhrw3pGtWLdQxyjaCxq66BRvPFmHaAhBmZOhB9Rwxx9C92zIOJBF3O0FHgQ0WBmlsSnILNsZEs26rTo6vUQE0DdyW6bxZmnuveMIDFfXV/x0XzKbnzza+Qwq7M4uypLfbNNn1A105r7nplmvwKeYW/GssAmYZsL1l3mjqrTsMAgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wx2pEvyiHyhflYZwaU7dNqphp0LdgHudGCp9aZ+Vs1k=;
 b=DIfL4SnTuiF4Ku+12pkI0ABEZuEBK0gMO0sLQxOuNlAedaNDkfONROYrHV4Xd92qlYb+cwhfsN6smi0xdjWtx50gMj3bIbRysO1WKJJJn1N1ljF75eUUQTPordV3tgO/T7CqRMJ2HaRpnLs4vksl0qhae4YID9AmTZ0m0Qtp9FsUtqCurXDvQBStqhgKkrgwQoyXfYJcI+3CbhqnVViuvAH2eTwAwV7xCsl5XTslco5T57BcruvaD0USs9Xhf/ueiMUXy3wQGFu1Zy5TwKHB645Rvo8TuZAV4Z99qmOhMAyBSMjIvdgWJ6nqmN6LFhWFsT2F8TGRKhwcGW8KRw6eYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wx2pEvyiHyhflYZwaU7dNqphp0LdgHudGCp9aZ+Vs1k=;
 b=b/KVGZekLiwrLlp00cn0dHPxtiCzPowQ3GCvDs7oc+CgZzNQsk2Tiu2Pfe9N3lwiANnMMrdCXBPhW/UK/8egjVOlPtn3ETM7CIn5nXdMrqxdBc+loklgyGDuuSGiPCCJN53zrw3GU6LYfUdpYLjCEc4Q1O74uSVSmvjTqnMaihg=
Received: from BLAP220CA0022.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:32c::27)
 by MW4PR12MB7481.namprd12.prod.outlook.com (2603:10b6:303:212::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.32; Mon, 29 Jan
 2024 03:54:18 +0000
Received: from MN1PEPF0000ECD8.namprd02.prod.outlook.com
 (2603:10b6:208:32c:cafe::71) by BLAP220CA0022.outlook.office365.com
 (2603:10b6:208:32c::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.32 via Frontend
 Transport; Mon, 29 Jan 2024 03:54:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECD8.mail.protection.outlook.com (10.167.242.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Mon, 29 Jan 2024 03:54:17 +0000
Received: from tao-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Sun, 28 Jan
 2024 21:54:15 -0600
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: disable ras feature when fini
Date: Mon, 29 Jan 2024 11:53:52 +0800
Message-ID: <20240129035352.292199-1-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD8:EE_|MW4PR12MB7481:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f778ae2-1e17-4126-25d9-08dc207df7bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IG7VK8bKCaYvywtlPmv4+tEieqkBUe21HYWG7fOVc/dZzCKaA8iRHnhqGoeiBcWW+xcxbQG/Ei2VnJvEnY5LEVGidTicYRRZPG9VtANKKoPx2uy4g5MCaYpdkw/snK3Xcb/T/2P0QCTiZI9nC1O9emw7F6JyfKnhsLyTSOmOJbuVWg2JUO10VGgsStaUjwoo2hJhHc4auxUazwUqUpM9slUjBaOFNrsJEUauPbzsdtAQ92msVz9M0hhwDK3xj5h4h5fg1OnplHILbrE70l+3gT9GN9154166/7s1tDW8LxuUvp4J7XlHJLwd9I+O/l996Wzz33g05Xef0+N3O1Gl9t6z/wcwTDZ5fzWIPl2OfPNYECNvohl2bNWfFF9utJNdekJLAedFT2us2H6hd/ZFWlIUADsyFqwzgSJnspycwLoUwE4RD6ockJXSKkUIS2RWVFRwzC1YWEmgykYgO19RBvQDiIWOAcEY6A8/+aBVwoESceC7t0DsSsmpZ7dyci2eWMUo1/Jbu/3uE7vSTVxOsbYCxL1yZSPpCyx1Y7h0WEKE8mY6Tcp6PPuGmxH7+q0/IiNk8etB70IHa/TVD7S//SQR104S7eGA0V/sljHybrwRAEbvf/EUTVlfcd8phR9PiopInSOv9f7s1zNURLTdrHkYI1IjTKsaPTQUEiwUUxZ0ZYsjWWhHmkKytgSPiWsMPNEoxx73JQ0zqsHfse2SYc6YtbZCtm3JHIWe3sPYFe/uLyFHzx5xyfEmpKJ8uB6OUpLgAIVOT9Y2qJ00uETlog==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(136003)(346002)(396003)(376002)(230922051799003)(64100799003)(82310400011)(1800799012)(451199024)(186009)(36840700001)(46966006)(40470700004)(40460700003)(40480700001)(83380400001)(86362001)(356005)(36756003)(81166007)(82740400003)(36860700001)(47076005)(2616005)(1076003)(26005)(426003)(336012)(16526019)(7696005)(2906002)(4744005)(478600001)(6916009)(6666004)(41300700001)(316002)(70586007)(70206006)(8936002)(4326008)(5660300002)(8676002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2024 03:54:17.8758 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f778ae2-1e17-4126-25d9-08dc207df7bc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7481
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
Cc: Tao Zhou <tao.zhou1@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Send ras disable feature command in fini.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
Change-Id: I95f1d1e0a46fb613631e5cd77497e64c0551c4c7
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index a249f24ed038..a9fa2d134670 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -3437,7 +3437,7 @@ int amdgpu_ras_fini(struct amdgpu_device *adev)
 	WARN(AMDGPU_RAS_GET_FEATURES(con->features), "Feature mask is not cleared");
 
 	if (AMDGPU_RAS_GET_FEATURES(con->features))
-		amdgpu_ras_disable_all_features(adev, 1);
+		amdgpu_ras_disable_all_features(adev, 0);
 
 	cancel_delayed_work_sync(&con->ras_counte_delay_work);
 
-- 
2.34.1

