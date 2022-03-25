Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9234C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Mar 2022 22:58:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5284810E30A;
	Fri, 25 Mar 2022 22:58:17 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2051.outbound.protection.outlook.com [40.107.93.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 51A3210E30A
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Mar 2022 22:58:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jEyjcOJuuc0ZI6wMuSt4r/fFjMCmbT3qmlJhlz1d5u6IVXPvGEylDK8lfLyZAlr28MxNAXQTwy93rKh9MY/qW5Fj+bAlzHt9gZhWh2ZRNuIehhrkzJT0/slJs/J+jyhcS43lDB96dAerAmaB+rqEpRPr4PyQQHCO1g+0iSjwiD6F5sUg4fjm/mIuvOsUE5iXrYFls87zUPkz6W5EW3X+i+klJTVwsI70w12gpinIlEksxAP2aMBlCsfi8/5IPxmRcd/y/FR5cdD2KYQKrYySS4M3D4/DFk5TYTdV9+XRZe4Crp6rhViQtDUvwETOB5kJKimXWK/TMWdhjyTvAS9x2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+DTzQXSAjm2Asb/muaoWApdXbDqeSXXOMDBJ41k24p8=;
 b=OMSTSPMAmDTuStYJ6HpfiLCUtL0Lfa2yevfvFTZPEP4Fkcvmmo1yGSw/QIknJI+hDiGUQOs/EsAbwBR0PyTRXLOhEOui2kMxNWz/RwJENho4lvw5qELbkM4Iitj+K7XCFZPGEghAbo04/i9TRuaoY1LtakhkYbWnEBvjpSaX76+ATOmfhaGBvJ9nSwimpt8ue3fSji8QiWsaH15vIU926vs4/K0R/ojCPcKk+s0NrSnJtWXiH7oOkEWriiy4YCSX8WbREe4WbTogC3VFXYh4VRBC97bNBXilxQHX+C3ODnmrLXdZgglEzdTwymsy+zT62uAWcGoR0lUSL/rzAAK95Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+DTzQXSAjm2Asb/muaoWApdXbDqeSXXOMDBJ41k24p8=;
 b=WR1/49iZBGB2tbDQP26HzVEbbWugjRR/bGQCRJzxVdbg9B8qUxzGZr96keuzU5hFxQ5paXyAVEgw8l1S6f5uE+XBNcOd8JTzDt/YUq4VT5CTJdAV6l+PKJE09J9deyyxjf4plHqU53e2aJXlHgE7kh6Q++ItR548Wa1odTsP/lk=
Received: from MW4PR03CA0141.namprd03.prod.outlook.com (2603:10b6:303:8c::26)
 by CH2PR12MB4055.namprd12.prod.outlook.com (2603:10b6:610:78::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.17; Fri, 25 Mar
 2022 22:58:09 +0000
Received: from CO1NAM11FT036.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8c:cafe::a) by MW4PR03CA0141.outlook.office365.com
 (2603:10b6:303:8c::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.17 via Frontend
 Transport; Fri, 25 Mar 2022 22:58:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT036.mail.protection.outlook.com (10.13.174.124) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5102.17 via Frontend Transport; Fri, 25 Mar 2022 22:58:09 +0000
Received: from dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 25 Mar
 2022 17:58:06 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 15/16] drm/amd/display: 3.2.179
Date: Fri, 25 Mar 2022 16:54:01 -0600
Message-ID: <20220325225402.469841-16-alex.hung@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220325225402.469841-1-alex.hung@amd.com>
References: <20220325225402.469841-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8bce510f-20c9-4229-4ba3-08da0eb2ee70
X-MS-TrafficTypeDiagnostic: CH2PR12MB4055:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB4055362C13966E6575AD71B7F71A9@CH2PR12MB4055.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: er2E8XUC1eMKpRkvAf4/fxZSYhtOBkQy/KroRaLM1615ywnInOL4N5Y4cgkxAtUYk8Nr/Ofy0Nk1s9GjrX+PUwEJSgE9+MmgJEKXgrYYDvgLZkz2HmVgdvDY4kjnmtGTK0BSUhHRZNwxO08jKwwlOp1SeIhgRsBYMxBcRzG6Wn5R7mtanifhHB8RWuh8YeYxjrdVAaodGIfVA+rycWy78ry3x55/Oy2Foy5Kw1iFs0yPkKgfkf83N16B7Kk9qAte4/XkrsX0OTGu2yWgEgnrpsJrjg8xn68Ln8Wr2auzjEIIyzTPI4PO+13+O37kDutNbzhRWrbuihUdMvyRZsGMoiD/S5vt2T1bNkrM2LZ9TDytsgu9tGFnxSglmy4wwG+E9J49hBaDuLtNXNPJQhA1RQxCwDOKBnC7aoCukC2YlqYXstfCUK28CMglbaMXcv9A9DoxQBuNbukncvZE0+AOG8kusgRyzHFBqh2mTDuEKOg12N1pSWnzwAjn5erTUbcYyYMdVxOOYE78GpAZUaLWw5iayrxZ8fhl161MOPwMajaeN9mMotIelB04q+2TKpqRnVgvQfaSPpSg3rOrXYwXs2bUkWb0bLOzM9gpio2GzefSy/x8+AztLzctYJ2J9BVY/DHNLfHgvA5CGE2+U5YodxX+LHfCnD31VH+1/BpgeQUUOHORK5ax9NmVFUeHRpgWmm2z4psvKTb1P+scymsVrg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(2616005)(336012)(426003)(83380400001)(6666004)(82310400004)(86362001)(7696005)(186003)(8936002)(16526019)(8676002)(70206006)(2906002)(40460700003)(5660300002)(36860700001)(4326008)(26005)(316002)(1076003)(6916009)(44832011)(81166007)(70586007)(54906003)(356005)(36756003)(47076005)(508600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2022 22:58:09.1463 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bce510f-20c9-4229-4ba3-08da0eb2ee70
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT036.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4055
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
Cc: stylon.wang@amd.com, Aric Cyr <aric.cyr@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 Alex Hung <alex.hung@amd.com>, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aric Cyr <aric.cyr@amd.com>

- [FW Promotion] Release 0.0.110.0
- Revert FEC check in validation
- Update LTTPR UHBR link rate support struct
- Add support for USBC connector
- Add work around for AUX failure on wake
- Clear optc false state when disable otg
- Enable power gating before init_pipes
- Remove redundant dsc power gating from init_hw
- Power down hardware if timer not trigger
- Correct Slice reset calculation
- Enable 3-plane MPO for DCN31
- Set fec register init value
- Remove SW w/a for HDCP 1.4 1A-07 failure based on ECO fix
- Create underflow interrupt IRQ type

Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Aric Cyr <aric.cyr@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index ced40fe218ac..ef286aa30294 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -47,7 +47,7 @@ struct aux_payload;
 struct set_config_cmd_payload;
 struct dmub_notification;
 
-#define DC_VER "3.2.178"
+#define DC_VER "3.2.179"
 
 #define MAX_SURFACES 3
 #define MAX_PLANES 6
-- 
2.35.1

