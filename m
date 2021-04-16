Return-Path: <SRS0=1d99=JN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36BD7C433B4
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Apr 2021 14:49:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2C5961107
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Apr 2021 14:49:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2C5961107
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5EDBC6EC01;
	Fri, 16 Apr 2021 14:49:18 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2072.outbound.protection.outlook.com [40.107.223.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AB5106EC01
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Apr 2021 14:49:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VijuJUK+sidmY0LBTEVniLcPW0RtOFImj3DG0uba4V0zwVK2RlTavM3bi5S1+qw8Ar3J/CnOO0lBo2q4WHNov1GvtjW3mluTXBHSD0/xjIoWbhm8cFT8MPW3p2LjMrpyuNuq+P1ladqz2uFfyymUhQJK34c0u06i7phhXd8wLh7p3dzWW5jrV//ZQKqa5f+iW/azg31NDr+vDnKZa6fOM8TSK99oSpwv3Sn5pTUmxs2TGejtOzI0SHXdwVXRkRH+BjruP2AVFEt88PcD4baUViWbA3LVblQ8uRbjixKR4eEFRtgpckUE+lJZcmBroSQrnjsWHdUTNBaHyUvQMH474Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nn7o65AcD0I8eGT5agJNYYCcdhibWcXb6DBlExyN+kA=;
 b=ikhfIp1lc4cywSRJ4t2oB3BIo+GmZYzsnrR5g5k1pMJokcnUr5L3hfrdbYiFKUngeSProUhdcPA3G+Gck/W7kpVoiXfMuBpISgD6x3hwne0kyp0fZ2DIKOwweA4TbiiaifZ5F/m9d0BGroJzfDVgFwJ3hrNCBHFyFSohzDBCkkyegYLybwlT4a5iMgoQk/ogZN3MkC48j//xaXTepeaQendXznttKqDPczy/6UvW6txUBZUaKX1uPLDQKQT8P+FG04a3sPOzwL7xW9bOk1NIfSkK6yzwFB3nNBgFM7TQQ/uOc/xh58cq9UyrhM2vvnpF03Y8ZOHTD2DXOwgmjEmQcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nn7o65AcD0I8eGT5agJNYYCcdhibWcXb6DBlExyN+kA=;
 b=VeuQJWeFTJWZHVfrcB9+T/R9AKNcEA9tua2n1BV1NvNeKKR8ddFAJcCm4RX9Wn1iINe1YNj7W+NN4JZcAve50OqnXvb+lt7KC1IAKEs/w3gku8PUPbPKa+4oZ7qEwQEkKZvH+H7wrM6X4tBEzpDX774FFPY4n/3FFmvMFJ++zwI=
Received: from DM6PR08CA0017.namprd08.prod.outlook.com (2603:10b6:5:80::30) by
 MN2PR12MB3919.namprd12.prod.outlook.com (2603:10b6:208:16a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.18; Fri, 16 Apr
 2021 14:49:13 +0000
Received: from DM6NAM11FT041.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:80:cafe::4d) by DM6PR08CA0017.outlook.office365.com
 (2603:10b6:5:80::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16 via Frontend
 Transport; Fri, 16 Apr 2021 14:49:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT041.mail.protection.outlook.com (10.13.172.98) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4042.16 via Frontend Transport; Fri, 16 Apr 2021 14:49:13 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Fri, 16 Apr
 2021 09:49:12 -0500
Received: from yajunl-gv.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4 via Frontend
 Transport; Fri, 16 Apr 2021 09:49:11 -0500
From: Dennis Li <Dennis.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Alexander.Deucher@amd.com>,
 <felix.kuehling@amd.com>, <Hawking.Zhang@amd.com>, <christian.koenig@amd.com>
Subject: [PATCH] drm/amdgpu: fix a error injection failed issue
Date: Fri, 16 Apr 2021 22:49:02 +0800
Message-ID: <20210416144902.16434-1-Dennis.Li@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 36016cca-1a4c-4fdf-d635-08d900e6cd4d
X-MS-TrafficTypeDiagnostic: MN2PR12MB3919:
X-Microsoft-Antispam-PRVS: <MN2PR12MB3919BBA67572BBE6D11EB7C8ED4C9@MN2PR12MB3919.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oK9RYRxe+YDNNBcm81txPLTeRR8R3767ZXSzIhFQNjz/GMLanAAcMg9GxX6tlPpgv8vOELrmOEn+OCZx3tlRRKD60ixS7+6qUsfmAvOHZEi/lMFxczJ97lsEwO3assgdLVSJRFJhjV7bcM1IlB8KdW30abRDc0bgEPgi1zRAHoGdoXSR+eiaqfTHbWPg1+u5WoP4yCdlLQOGptnieKAvmJkYL9Dn3QH2d/LArrnnY8tgtx9uF2zR1qcEVUww+GpX7F0UCqP7aSaZZkF4xw/M+n9lqAk0mzQ9Q+IB07/QmrhIjA+Q7eupmeksOxij0LEphL5KZ2G/4Gg2YaR3U68pXaWtoU4UbAr0bjqPOEtM0UF1zJ+ea1gTL4WXkMTpT61wENC/DQKslsl6Z4v5d4jgUjNrtvcGG52MshFMqI+vta0/ah6m3y6DEWeB2mDd2MYFg400qypQXOiaTLdDvTmWjCg9GlhtuW6YdZ3eDEOZO8nJFJvg8zDFEB72tPD/w1NjBy6IRlXQyzK4OjdKOImotsglPxFoqc2XDM05gwkBaoL1ttgAyzSQHNCOIUAk+yRd2yUFTNV/Y8EGyKZWn2QOXxDu4mDEBEGOgR+IEoXwXs4IdbMb5PdXFQZDQydRvhKKARgBg0n/hdQj3EJYQGA06Q6gdXiBw0ifqpahL/TvSVA5lQ5ydqt+sciSW0EkUbWTMhnbxMb3He2/VDx5Cqip7A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(39860400002)(396003)(346002)(136003)(36840700001)(46966006)(8676002)(336012)(8936002)(26005)(426003)(186003)(36860700001)(2906002)(2616005)(86362001)(1076003)(36756003)(6636002)(6666004)(70586007)(70206006)(4744005)(5660300002)(7696005)(4326008)(83380400001)(316002)(47076005)(81166007)(82310400003)(110136005)(356005)(82740400003)(478600001)(36900700001)(2101003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2021 14:49:13.5494 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 36016cca-1a4c-4fdf-d635-08d900e6cd4d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT041.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3919
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
Cc: Dennis Li <Dennis.Li@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

because "sscanf(str, "retire_page")" always return 0, if application use
the raw data for error injection, it always wrongly falls into "op ==
3". Change to use strstr instead.

Signed-off-by: Dennis Li <Dennis.Li@amd.com>

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 38a691a3b600..7438d4e84776 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -221,7 +221,7 @@ static int amdgpu_ras_debugfs_ctrl_parse_data(struct file *f,
 		op = 1;
 	else if (sscanf(str, "inject %32s %8s", block_name, err) == 2)
 		op = 2;
-	else if (sscanf(str, "retire_page") == 0)
+	else if (strstr(str, "retire_page") != NULL)
 		op = 3;
 	else if (str[0] && str[1] && str[2] && str[3])
 		/* ascii string, but commands are not matched. */
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
