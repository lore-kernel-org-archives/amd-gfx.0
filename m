Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94E15C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Mar 2022 21:44:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE1A110E1FA;
	Fri, 18 Mar 2022 21:44:52 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2083.outbound.protection.outlook.com [40.107.237.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6688110E20D
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Mar 2022 21:44:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XsMOVgCDOl4aZBsyWeqaktNhh2q8cFvYIse3iP9HBHu2w7XWTEa8cbEffjk+nhKFcEx+HgeoRL52iOcOnC0xW+O0UyyAnCfZi9VTrjRhTJfZoi34wg0+ZjmFGPCaktf607JV425rYUTOJRYajxKwIf7nqT4ET73jCpf7/CwDkX5cQ90HHk6LRJ4BSHIlE99OEDZVg6lxQTCxi9rgWcCN4h5/UI4pHqRCVGlYB8fkYM+kzSOXEcPOD3vcTYMiIW1qnJlZDoFhgjt41h9xBrOnAwzOhDxA3DbHjQleImhXr3L0QjRmhzv7CJBmvhMrJOvDYybY4kex+4e0v/13nYxByQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yCe617p8qMfQwRgcbzCbSRXHdj5LdGSBQhb4kWcmGZQ=;
 b=d9xGhXmnaGO+3unt38Mbqygcz+cy1hgmHj0HA75SOKSsIYoOJ/PsxHLtBzSqozH21HoSJTx4SQeBIHkRU8fJCjcnuBCTvQJuqkvMZKktffgk0479tmPTyu/hmTC9Z7UJXoIBElaIuFSZAR0A2MGXLXu8VZ8Ie7sheFbdBYYSosl47pwHN+dgpOVU85yVez/bRuFtCkGgCRIzCzdwF639BFPdJk4j5tb8iZohySULFujls6DJKYs1JypX3zH0t6zaob71KaRfz+YC++F/V1x1NmEJJRgxbRIARYG+0YYO+40rOILvrXqZLqAE0H3BF8CvHw3JgER0R7N4tBTgkfkqQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yCe617p8qMfQwRgcbzCbSRXHdj5LdGSBQhb4kWcmGZQ=;
 b=EPxyoPKZVN+UKs2M6RQZE5Kxsh0VSRpg4W+RV2BkLAm2Ukb3SSIumzBpi1lKVt/V/s60SzU1u47aphVQhTIviTHzf12kfZPoPQV4cvcCRB7dKgDaUw+m6HY9NVTl8w7ItMJ1TwbNCRCjmJgIEpYcmWGfsGdEuOyPUSgyhKIu0as=
Received: from MWHPR18CA0029.namprd18.prod.outlook.com (2603:10b6:320:31::15)
 by CY4PR12MB1734.namprd12.prod.outlook.com (2603:10b6:903:121::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.15; Fri, 18 Mar
 2022 21:44:48 +0000
Received: from CO1NAM11FT004.eop-nam11.prod.protection.outlook.com
 (2603:10b6:320:31:cafe::95) by MWHPR18CA0029.outlook.office365.com
 (2603:10b6:320:31::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.18 via Frontend
 Transport; Fri, 18 Mar 2022 21:44:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT004.mail.protection.outlook.com (10.13.175.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5081.14 via Frontend Transport; Fri, 18 Mar 2022 21:44:47 +0000
Received: from dev.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 18 Mar
 2022 16:44:45 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 0/1] Title: DC Patches March 18, 2022
Date: Fri, 18 Mar 2022 15:44:33 -0600
Message-ID: <20220318214434.3558191-1-alex.hung@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 121a9870-bc73-45d9-9373-08da092885bd
X-MS-TrafficTypeDiagnostic: CY4PR12MB1734:EE_
X-Microsoft-Antispam-PRVS: <CY4PR12MB173429307E4BF011A71B97F8F7139@CY4PR12MB1734.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1PuOeGH0yFCS43hZZu14yG8p95hiaZMCxi4ZRxbebhjfjbr7oG+tWhz20dszVdziFYtLOkJv8/LkYqlG7tYXVa4VAlWcrJbHaqTKBMTz30G5TvbRj5mlRS7GO1pc13gGxONKVCjEQxO61QXrqaQxe567ouVzmcv0HVErNYtNGbwh8F1v8zQQwYHPSnQaSbmP968V3/I1qGFfZEQQm8GrnOcnJo8AT8fL/gCv8AjTQgj80Qz8na1Gtl267C6ptdhHZ8FKuaAwWsqztMpOV3uyO/6wHoahUkwb6pPPs+VmeZL3szvJ08rax9en59fdivJ2zOyVzMaJ6GF4PfQOCkwPqeF5ZXcy8AjjmjS5DLZYaGv8ObjPhqsHqsSLl9maKk95Oxga81YJp+CqD4mvg70S0Q5zMYsObqajacVYb6ZEHs6Tw2zDRDVwssM1Vi+pwvHxuq0APLrWmu1VOMTyiep5x+PzoN4l7XLhXMLVkoKDc+qGxwf5Jn2PAKac248zHxq1UfHPp7KEFDKe0AYokDDsOttInEHu4oQrRAkD7F8qjpK9C7yzz7RpBOzNsdP/F4epyfgxNAQhAfpaDtvchM+HX4ijdmrl5mvDLG+rXbq1UBh0wj1eeLMwMHeqtXGf81POmOGRRorejCpMQgW4z13Y4dFz9GB0LXaFG6KIVOFvHFM9iZq66tOPxtyUuHOZHaUFKHMjjO29yqcYMjzYzrKzuA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(6666004)(8676002)(7696005)(70206006)(70586007)(86362001)(4326008)(508600001)(82310400004)(36860700001)(47076005)(316002)(6916009)(16526019)(40460700003)(1076003)(2616005)(356005)(336012)(186003)(26005)(426003)(36756003)(83380400001)(5660300002)(44832011)(4744005)(8936002)(2906002)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2022 21:44:47.1607 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 121a9870-bc73-45d9-9373-08da092885bd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT004.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1734
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
Cc: alex.hung@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This DC patchset brings improvements in multiple areas. In summary, we highlight:

* HDCP SEND AKI INIT error
* fix audio format not updated after edid updated
* Reduce stack size
* FEC check in timing validation
* Add fSMC_MSG_SetDtbClk support
* Update VTEM Infopacket definition
* [FW Promotion] Release 0.0.109.0
* Add support for zstate during extended vblank
* remove destructive verify link for TMDS
* move FPU related code from dcn31 to dml/dcn31 folder
* move FPU related code from dcn315 to dml/dcn31 folder
* move FPU related code from dcn316 to dml/dcn31 folder


Aric Cyr (1):
  drm/amd/display: 3.2.178

 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.35.1

