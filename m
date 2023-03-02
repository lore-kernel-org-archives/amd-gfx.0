Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53905C6FA8E
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Mar 2023 17:04:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B69ED10E284;
	Thu,  2 Mar 2023 17:04:37 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2055.outbound.protection.outlook.com [40.107.244.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C343210E4C0
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Mar 2023 17:04:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n5uK6Ky73+WC7hWwmJ+wC0W6ggEp7T06P8pjZK9iOOachzTZGUd7GsKv0yqXo3lod+oSqLAq1PN9TzN6K8S9/c2d03NXhwlKNwcKvOX9lc+r4SninbNITuv00JnL7XoZDL9QdmSmBvSzrHXDO8UXk6Pl0EfeA4ioFcLNDgu2T0YLzQDKkHQJ6frihmH/ro8xED1xSDMYt0OTBjU/jXvlcAMHk4rjCjIzak8rYjIZBa7kElYNvlrms9uqslOsMx45NRcXrd5pHK26ZMhJmTYUus46gdshD0WPTZQe/uvkPXxKmlLmEZdG5MKykwENs3JT0+SiiPJPnctTe2+4+ameiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=egr+fEy7jSK70+mrIOrbDrx3k4iwWQZhTwLtD96OWBU=;
 b=Mupo+inXIz5KFsLqX73zqo6igyS4CssuFwp8hJN+/RohOlIRAmylh/ePhDXc185y6Cg+sSoRcc3mUAk+C0cTsRJEl8Znas+hs1+4qJecNXLj2OnRyP9oFO6N2JODEbJgz+jPWz+JbY9Yhb2a6dxBw8PixiUbVbr1YOFgm/67DlDMxH/xDAwEuKkLcGR6YXSSMWuDCyf5CSA8OrmyosYPc/j+E5+/PTnmgFpwLPeKtksehEAsX6AQH/oVJ/4jeQ2KxJw692i+Ml+U8zGGbJnmupS8tIPRIrK3DKMOQCBgh3kHmMwxqeq08R4rzcCqW0ANKLa7FkzjZfbHYH3pWJkVbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=egr+fEy7jSK70+mrIOrbDrx3k4iwWQZhTwLtD96OWBU=;
 b=aAGrcyE318XleX6jUIW64dUXsbr3TpaOhPVDLT2Gc91ea1G3heCAXkKGxG+4tWhE55rGl90Mea44dHB6Z09oSoSMG4ppE6BRn3KQjiwzzh/8vlj9QLnMXbDZV0GWq1KqsREkam9vBMvYZF0jbCEq9DXzBjU5Pk31QRzroW6qZOI=
Received: from MW2PR16CA0068.namprd16.prod.outlook.com (2603:10b6:907:1::45)
 by IA1PR12MB6018.namprd12.prod.outlook.com (2603:10b6:208:3d6::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.30; Thu, 2 Mar
 2023 17:04:33 +0000
Received: from CO1NAM11FT050.eop-nam11.prod.protection.outlook.com
 (2603:10b6:907:1:cafe::67) by MW2PR16CA0068.outlook.office365.com
 (2603:10b6:907:1::45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.19 via Frontend
 Transport; Thu, 2 Mar 2023 17:04:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT050.mail.protection.outlook.com (10.13.174.79) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6156.20 via Frontend Transport; Thu, 2 Mar 2023 17:04:32 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 2 Mar
 2023 11:04:28 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/4] drm/amdgpu: initialize ta ucode for psp v13_0_6
Date: Thu, 2 Mar 2023 12:04:00 -0500
Message-ID: <20230302170401.20386-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230302170401.20386-1-alexander.deucher@amd.com>
References: <20230302170401.20386-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT050:EE_|IA1PR12MB6018:EE_
X-MS-Office365-Filtering-Correlation-Id: f774d84a-2482-4587-c306-08db1b4031e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: p9mU6/+GSymUIPEMCqn2XF/QRGSmYVWkCJ1jJZ7wgBLXhWIwAmgfQ7IK5g3wXBOTTphn/pyHX74kZyJaqTOPWSDRPiSNAJS9bLuGielyHw5KoCsgHc3gbsi/+bsNk+dvcmnEoO7OYcaBXrOwYb2HNDhskaXM9RW2zh+Lu6CW4gjTSnnE3kpevKa0SUM5b3HdM9ofNI/CiI6hK4CjjxkDGxEjC0+PlI5fj/w2N2ZWSBjW3nfl4SUVQU8W2r373XchSzt2Sh2Fb8MegmKatzUQLfmp/GFeh27TtKdxO/FdTTzZcwcJbhzImqnSwTW/eWq1G9BQBQR5MG1YKym7WheMuMc9tPVMolGBfTlPWjPMBrQ63ZrJiXhG4VIazTgQdPGpO6SSf0/y9Zn7aspy0RVt0euPxuJ7ELpv9dMQxZYP4aYJJzMl7/mhWAVTEz6POavvl68wj6f3B9r3DMt04kAF8Pwau0Ej4tTyv+W+95cvw2uWfb1dy9pmpd5kqcgdb9AV+AGmH/Eqh82+m3AEIQDWidAj22W4uquWNdVkP6pLORqVQhrPO+djLy6jw2aAXDQqCAk4texXcpgG92ayGy7WrKBQR5FW4EaRy+cDnuNFpwNKGMGOlYDdMcDCX+4+lRhPTaOjrZRYbDe9bV2lVp4ve2RAO/lBR6KSk0W4IN0w+yln9YwMyOgS0PGZet353azUB0qFzrJ/d5AZsqf30SPm4hnKrqbVYSYpMSiGJb0jkh0=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(396003)(346002)(376002)(39860400002)(136003)(451199018)(46966006)(40470700004)(36840700001)(356005)(36860700001)(81166007)(82740400003)(86362001)(5660300002)(36756003)(6916009)(4326008)(70206006)(40480700001)(41300700001)(8676002)(2906002)(8936002)(70586007)(82310400005)(83380400001)(1076003)(336012)(186003)(426003)(40460700003)(2616005)(47076005)(6666004)(26005)(16526019)(7696005)(316002)(54906003)(478600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2023 17:04:32.9933 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f774d84a-2482-4587-c306-08db1b4031e6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT050.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6018
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Le Ma <Le.Ma@amd.com>,
 Lijo Lazar <lijo.lazar@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Hawking Zhang <Hawking.Zhang@amd.com>

Initialize ta ucode for psp v13_0_6

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Le Ma <Le.Ma@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/psp_v13_0.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
index ceded7eb9771..caee76ab7110 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
@@ -88,11 +88,6 @@ static int psp_v13_0_init_microcode(struct psp_context *psp)
 				return err;
 		}
 		break;
-	case IP_VERSION(13, 0, 6):
-		err = psp_init_sos_microcode(psp, ucode_prefix);
-		if (err)
-			return err;
-		break;
 	case IP_VERSION(13, 0, 1):
 	case IP_VERSION(13, 0, 3):
 	case IP_VERSION(13, 0, 5):
@@ -106,6 +101,7 @@ static int psp_v13_0_init_microcode(struct psp_context *psp)
 			return err;
 		break;
 	case IP_VERSION(13, 0, 0):
+	case IP_VERSION(13, 0, 6):
 	case IP_VERSION(13, 0, 7):
 	case IP_VERSION(13, 0, 10):
 		err = psp_init_sos_microcode(psp, ucode_prefix);
-- 
2.39.2

