Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68001C433F5
	for <amd-gfx@archiver.kernel.org>; Sat, 12 Mar 2022 00:52:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DF97110E06A;
	Sat, 12 Mar 2022 00:52:45 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2069.outbound.protection.outlook.com [40.107.94.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A69BA10E069
 for <amd-gfx@lists.freedesktop.org>; Sat, 12 Mar 2022 00:52:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RxO4gAn0lslFHLTcP6smRD6AzOoV8Fl2Wf3vx+/BORpZrV1x2KAiiqf2nGexTj51yL57Wf/tbBG4oBaCAJXfDYbaUgKhUccfoKa1OcfSavDsxQs28yKSovdO96o7pFsS2V3hvf+WZ2s9vGhCNYSxSqtlIefZMwj6GDWIUBVW2yU5d6t6aYXc8TvDGvigUvPzaEB8HCSEaWFvl+R5zpJ1dXzRUfzB0EhzElqBfoKXe7pP5DiuXa8LlfLIKupr1RSiEyOWaTiLrQOhzCXkeOqRT8CCznkzlV3DpwMSojaK92OJquiAlSVJjUxQTAWxctNZQjujA6k7rvp/XYhsMB/y5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ybSfP/MZPjepZEqlccj3dS94y/fd5A97JY9pqx4wr1M=;
 b=PAVrUsUbdnV5fWMbalJif4fTDVZfTKLNGBZOD+7ntHdTRiZRqYfOg4NhYNlRMNs7/UaUNzLog2cc1puVB7gV/vfTOZmYePcSTJcDdK6OFqQZA9BdaSfIzVvYZHANLkKXBIlzJLbNpModRNUrF+EzSv3OBWwlWd66lkTrdfasg53tW0LIQ1/IEctxJGlFmqerBMGc8AGtmlSpH7KNqwmm3iZanPacU+YVTDaglpg708iYzEWzQiBdL/MHNSHSEna0xdudidQieVFwdv4l4OuxIVeysOCKadKVQhbXxIbt5lwGQHITclQn8hBkX6v6dB/n1zNcj5Gh4ZbC5YTCjgBShg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ybSfP/MZPjepZEqlccj3dS94y/fd5A97JY9pqx4wr1M=;
 b=AX37w95j96t3hptH4CNOwA8Uiicrfsj0EDPgvK6pARc7z6XIKVmZqioVVAugE/DjoLFhTQ+Xc/xhEcbTsGLuAwihLgFD62oYut/7nBAejYIA/jZWFA5RKGTp3dBBT6Te5B+YeN1omZp6sARAErX11DHkp3jFpk7KLIUUfWdGE0E=
Received: from DM5PR1401CA0010.namprd14.prod.outlook.com (2603:10b6:4:4a::20)
 by DM6PR12MB2970.namprd12.prod.outlook.com (2603:10b6:5:3b::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.22; Sat, 12 Mar
 2022 00:52:37 +0000
Received: from DM6NAM11FT056.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:4a:cafe::74) by DM5PR1401CA0010.outlook.office365.com
 (2603:10b6:4:4a::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.21 via Frontend
 Transport; Sat, 12 Mar 2022 00:52:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT056.mail.protection.outlook.com (10.13.173.99) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5061.22 via Frontend Transport; Sat, 12 Mar 2022 00:52:36 +0000
Received: from localhost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 11 Mar
 2022 18:52:35 -0600
From: Luben Tuikov <luben.tuikov@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v1 1/4] umr: Print errors to stderr
Date: Fri, 11 Mar 2022 19:52:03 -0500
Message-ID: <20220312005206.26588-1-luben.tuikov@amd.com>
X-Mailer: git-send-email 2.35.1.291.gdab1b7905d
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8af866d4-2716-4e4e-b01c-08da03c29a21
X-MS-TrafficTypeDiagnostic: DM6PR12MB2970:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB29709E7624AA5EBFB7C8D4FE990D9@DM6PR12MB2970.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iPW0pyjzMiKsyWTy7CUphCSKnsOweKsz1ll8XzGsFDAm48SM85QmB5RK4f6DetJwUbqM6ttwm+8DaRVDdnRE/rV2TGopDT++xF8UhvLzWFtN89nz0yMt/uh5EgiYVz/RxsFRN55JBhXVgjbSrjSFGsLGG2wFi31Gfdfg0vzKcsjNwpUTLkGQoWjXDVlewl90bX+/iy5bBTU42RvY7Lzyex3qoNkgoLqQX6Ru4fDOjxoY3+/v6V8dzs/Be5aAO8DXzbVZ+M6eJMT63AvYsk8MZUgM5cRKB0zaqmGDKCqptoG0BRYxefMWIx4ErSTfmiuegEY2RwTWS/b9MeMEnDBI3t4gkjS4J32lg6T+KhHmfSIYDHeYnpy46drias63Ge7uKJn/WAs46fWi6ZhC5YofLGiUtyHzB3IjuIkGL+SpkFtvny6veaaTicdNiNHiACy9TM+EueqicH2CXgywLzjTRzfKr29b+iz+AHEto+5FQH14zGmi+fiFyFrNepBR9KcoUqB96XqkJDnJPinQQDOXtYIMrjQ47BIpf7zSZsSqoZ+3MYdfxKp7e3fyz1MU1QjgvOjaPxqL7WmpRBZlGF9vGW4HeQZ2UrM8ORYTob0asQvmf7O38/Rdxzn7YH3A1SQX5bcJ2e6pnnRYwwnf5V39wv9Bp2RNeoz0gLy//gvoJhBPD5Qiiz5QnvIwoy4/+AI1F9zaWtnEM3JKzxM4NVdYLg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(316002)(36756003)(81166007)(2616005)(356005)(2906002)(26005)(186003)(16526019)(54906003)(6916009)(83380400001)(7696005)(8936002)(70586007)(70206006)(44832011)(8676002)(4326008)(1076003)(336012)(426003)(508600001)(36860700001)(86362001)(82310400004)(40460700003)(47076005)(6666004)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2022 00:52:36.9690 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8af866d4-2716-4e4e-b01c-08da03c29a21
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT056.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2970
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
Cc: Alex Deucher <Alexander.Deucher@amd.com>, Tom StDenis <tom.stdenis@amd.com>,
 Luben Tuikov <luben.tuikov@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Print the following error message,
   Invalid gca config data header
to stderr, since printing it to stdout,
confuses parser scripts.

Also modify this message to be clearer. For instance,
   Invalid or unknown GCA config data header version:4

Cc: Alex Deucher <Alexander.Deucher@amd.com>
Cc: Tom StDenis <tom.stdenis@amd.com>
Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
Reviewed-by: Tom StDenis <tom.stdenis@amd.com>
---
 src/lib/scan_config.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/src/lib/scan_config.c b/src/lib/scan_config.c
index c7f4e9d3c69faa..6dd752a1149754 100644
--- a/src/lib/scan_config.c
+++ b/src/lib/scan_config.c
@@ -122,7 +122,7 @@ static uint64_t read_int_drm(int cardno, char *fname)
 }
 
 /**
- * umr_scan_config - Scan the debugfs confiruration data
+ * umr_scan_config - Scan the debugfs configuration data
  */
 int umr_scan_config(struct umr_asic *asic, int xgmi_scan)
 {
@@ -246,7 +246,8 @@ gca_config:
 		case 4: parse_rev4(asic, data, &r);
 			break;
 		default:
-			printf("Invalid gca config data header\n");
+			asic->err_msg("Invalid or unknown GCA config data header version:%d\n",
+				      data[0]);
 			return -1;
 	}
 

base-commit: 818bb1e8f1b5a26fda0e3d7abfc1e68605ebad28
-- 
2.35.1.291.gdab1b7905d

