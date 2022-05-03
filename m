Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03A5BC433EF
	for <amd-gfx@archiver.kernel.org>; Tue,  3 May 2022 20:51:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B44810F4C9;
	Tue,  3 May 2022 20:51:30 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2074.outbound.protection.outlook.com [40.107.220.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D60810F4EA
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 May 2022 20:51:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xmek0t4EQ6BdjmNk4MQOiCbOBBp7TWJfZEGBUHpCCQwTzrw0cjUzrtdURiDWjAOAFTgtnpLoaBur10TxpPVsCpZfNOCcKpZVZcNX5XrufMOL6QGwwf64eP2G8DOvQ+W3/qLJ0AU6Dg3Sj8/9Wi12PkujfL5rYNGA5AuCbGxxMbOkyNRlsf8Qq9FCDG7NWXEjvUWnwMU+pd/EVo3jeLVe/YRSbJQzuN7JZxz4hYsNV8YKifvSspCcL4kxT317YpM/8hac7Ll0ZrjeWj+qmyLdFFmzD1QwPplZ0GsR0Cw+9mu5/9an3qLj+8pYuwhD22cYAefajMLPpWl5fxVqy6diEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+MLSoki8ogrqmwLMmfBMnFtHqomtcxTE+EXyOIm3EvQ=;
 b=cW6ibf/dHDtwLXDNYtzNtnEc/ME/4bUiBodFUvjc9FDSL7F9Yo6tuqbv93orwFPWJ4XbICauR5PG3hBzQpKUIjyZKHfvD/HRylXQU6qSQdVSRa1eh/d37uyf5JMjuiUancCZdV9gryJQ5ESg/EfrecUpuMg/VuKC7VaDNOFcosBgdmY2yQHWxgpej63jYEuVn8POBTFue0B1GKTOTPU0+vYC6GiZUOpMJmJVlE7n8wZOC+2SpuJcmoqbp4RRWbAAtcCv8n4f939YpgeDFr9F0NGRWtIn2wlfPzeImevsy+RdhE/WUL87WotTjW0N3brQRE2EItpjx6KFRckDUYmarQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+MLSoki8ogrqmwLMmfBMnFtHqomtcxTE+EXyOIm3EvQ=;
 b=UNnS1tOf9OfJQbncebnGb6E14XRxKwW3Sp++oyzbKbOyt0fXkJK//KncG5MCP/Xp99OB4/UYvWQGQyzW7YC4fK1YXrEA0MPdbvr9IbomE/kU9pMi1n1dBFyVcMrdFluSfZYcRGzEwMkw3Gfk/U5RBZr3VWgWNQjW/p/jek7LPj8=
Received: from DM6PR08CA0055.namprd08.prod.outlook.com (2603:10b6:5:1e0::29)
 by MN2PR12MB4143.namprd12.prod.outlook.com (2603:10b6:208:1d0::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13; Tue, 3 May
 2022 20:51:28 +0000
Received: from DM6NAM11FT015.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1e0:cafe::e0) by DM6PR08CA0055.outlook.office365.com
 (2603:10b6:5:1e0::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.24 via Frontend
 Transport; Tue, 3 May 2022 20:51:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT015.mail.protection.outlook.com (10.13.172.133) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5206.12 via Frontend Transport; Tue, 3 May 2022 20:51:27 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 3 May
 2022 15:51:26 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu/discovery: add PSP v13.0.4 into the IP discovery
 list
Date: Tue, 3 May 2022 16:51:01 -0400
Message-ID: <20220503205112.1285958-7-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220503205112.1285958-1-alexander.deucher@amd.com>
References: <20220503205112.1285958-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ee8963a7-d64f-4d9c-e8e6-08da2d46b1cc
X-MS-TrafficTypeDiagnostic: MN2PR12MB4143:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB4143D57ED6DEDC5519FEA563F7C09@MN2PR12MB4143.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SVivqsPNHmvlwcVhoPThmA84wtPpsKwwp0eb6HrSrZP5ziIvrRZitBi7FADmcul1g+4vAltmysnLzmo8m2jhx+Zi24+pRwBJxp5XxXS81Q+8g7NQeXJ+fUeozNwkzPyT+Sy0hJ17Pj0BC+DgTeVhNva6+YcPiA1r3tXspl0kr4aL5Dc7QVqdjiaZblWwD41rie5ecpfAJkbMvAZ85jAFt6Q94nAAL5TUuMJGzdVOophMyyOIJIOz5XUNUWtZcr1hh9Ov6x4vdaiz29SlcOh2/yFwgQGbaVcMpUs+h6Mfvl2aLBvkUb3Al5wrMB7+er/sFJb566IRiJKpUjk/3lO0i0f5D/I4Lcdgp7M0LtEE888glyoIV1Wl29cdc6s5WnlXtvUIND1Svrf65j03zJqKCDIjIYwsgS01aHtXI3Mx1kyo6hIs/sjMoN3qMt5cmVGSRl6GNhm0Y+UhjD18X0UWqTgIHmL47TcZ24EABXdvyO7vmptxefW9R1/q8jndH5CyGw1DJifWljWVbOkWNyp3B4tB3mGD2Iq6iqGmyL9Paj5jmT96ize/ymcuwhBB7bgjNPEUqHp/GmwUuR6fzaNVifUyYPYlavHUnPxo3Jv726KG9FTe83uoHOKsBLNQbDZAqMZnZXw+L+QzRXUNjQK5Q/fGZ+KwTM70EGBvUAUCfQBtZsLeK2em4xNN1MdPTfGMsPULda3fkbkWR5sUCRxCpg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(70206006)(8936002)(36860700001)(81166007)(8676002)(2906002)(6666004)(7696005)(70586007)(4744005)(86362001)(40460700003)(508600001)(5660300002)(4326008)(2616005)(83380400001)(1076003)(16526019)(82310400005)(186003)(426003)(356005)(336012)(47076005)(54906003)(6916009)(26005)(316002)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2022 20:51:27.9209 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ee8963a7-d64f-4d9c-e8e6-08da2d46b1cc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT015.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4143
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Huang Rui <ray.huang@amd.com>,
 Xiaojian Du <Xiaojian.Du@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Xiaojian Du <Xiaojian.Du@amd.com>

This patch will add PSP v13.0.4 into the IP discovery list.

Signed-off-by: Xiaojian Du <Xiaojian.Du@amd.com>
Reviewed-by: Huang Rui <ray.huang@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 2ef93c8c63d7..2c742d46a837 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -1607,6 +1607,7 @@ static int amdgpu_discovery_set_psp_ip_blocks(struct amdgpu_device *adev)
 	case IP_VERSION(13, 0, 1):
 	case IP_VERSION(13, 0, 2):
 	case IP_VERSION(13, 0, 3):
+	case IP_VERSION(13, 0, 4):
 	case IP_VERSION(13, 0, 5):
 	case IP_VERSION(13, 0, 7):
 	case IP_VERSION(13, 0, 8):
-- 
2.35.1

