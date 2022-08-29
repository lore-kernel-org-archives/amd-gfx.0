Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7F46ECAAD4
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Aug 2022 21:18:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 08ED510F3D7;
	Mon, 29 Aug 2022 21:18:52 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2058.outbound.protection.outlook.com [40.107.223.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7B82210F172
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Aug 2022 21:18:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HDEG++pM7jQCK805kVipB5+AL7eXBTz5kTtt2WLXqZJo82iQe3jst7fqYBX81XXvqU29c3D7RC+DBIddaXJoUXbSCa+y6UKPC0a++5rPs5yHzTvpLy9FAktjn24BiRw59/CxryRqw/nQRzhwk+nfgojfUX2z6ZQ2xYIHvyKtLqYJGkEKA09jAAOjdzT6wK8kPG1wM8LB22sK8sxRwkm6LDDEAulDMLvPO0aRMzT1ljGiqM7XVTjs4lAqE/rnMrk17DAzgimCfpB4L87QDa/v7mRT/DPZyVEf1gmEbfJ5WQ21FczHLYkf5tFgm+5KsSrGBcZyDWYAU+7y5504qukplA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o9xMhvGB/5CiAKy4GE+Fjj4JFrJHPEsXedgfiA3g+OA=;
 b=Hnqfy+zM23ZrR8YwrJ2VQQ3pYejij8uH4Viikq2hI/SM5e1AsqEYxzNH1lRF0Ny4bIywGwJ+ADVies3YUx4l2hue03+n231PVl9QLnRM1C65ZkJk2lsX2Qvm2lUyUTJZ+vqWgQJe8thLQEIaHjlySZthr3PL8G7sQyx6c1zQKO//6jQB/1aWdHcUpn0nfuFP41nZ8nHAfmeV+TpGiBvmUcZYiSNB5Fhyqsu0DDlbcgaFpLqGQt/8Ds2PBIVTMjdH6gRV4CbG/KyRgPif7csEUlAvyTGUPUPVCRDlTrMwpi1hhWtsK9/FOQ2M908w0L8wWqLYXARUP4ZxyOOoe9tz+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o9xMhvGB/5CiAKy4GE+Fjj4JFrJHPEsXedgfiA3g+OA=;
 b=tiGdwIlIYSNtJN2+H6SnVR70xu1qmSHzRxfKokWVlX/0aGen9N7pttjudBNPJuEHlqqIDCRT5e6ivx+QQyuYR7Yni2k30VW2J0fKr11Pj+bw21xMh6f9T8rCC0mxXSZlVkbDXDntacaeMmszb2U8hsp5W5VWdQso4+s6xDDFnbc=
Received: from DS7PR05CA0081.namprd05.prod.outlook.com (2603:10b6:8:57::6) by
 DS7PR12MB6285.namprd12.prod.outlook.com (2603:10b6:8:96::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5566.21; Mon, 29 Aug 2022 21:18:29 +0000
Received: from DM6NAM11FT089.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:57:cafe::9) by DS7PR05CA0081.outlook.office365.com
 (2603:10b6:8:57::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.3 via Frontend
 Transport; Mon, 29 Aug 2022 21:18:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT089.mail.protection.outlook.com (10.13.173.82) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5566.15 via Frontend Transport; Mon, 29 Aug 2022 21:18:29 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 29 Aug
 2022 16:18:28 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 7/8] drm/amdgpu: add new ip block for GFX 11.0
Date: Mon, 29 Aug 2022 17:17:55 -0400
Message-ID: <20220829211756.1152505-7-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220829211756.1152505-1-alexander.deucher@amd.com>
References: <20220829211756.1152505-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dd76030e-e359-41a9-7da5-08da8a040505
X-MS-TrafficTypeDiagnostic: DS7PR12MB6285:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oijHN8iPvx8UxidGx8O9eEd6RXlh3aP1+UzMmkhMAG93uCNXMM5wHwoWkslgReMssept7aM/7Zn/eUifqsJTweETwe4GeNiczZ0CBhli+FkkqTuJ1pUmMawt0cWOlEN/aygIrNd8864Lb2Ptiuca6FbdTzJb0x+AYvwOQeVMynaPMyn3VDS9OUj2B7JheaKuduvGceesZOoC8j1hiGUgKCG0164bthNZgAYRSQWBVP6leU0voA2IsMVKK9/ct6l+j3joTbfqjRcZPV8zo/l6aMXxZp5LNgvsAoDwPftkZgEK2mtlf85I7/L3cYrr4Tz+LaAcD5TbRjI5RYG4WL/lIjsxR8y813ygyRTcr0/EubkzAbEQsvJCCJPiD+Q1ammGIB55FwjQGL5wId5AHKk7keS8aWh6bVBhXtI1U4sRI/Pxlo6FYHqbGTI54mxjAPCTrOmc/5ENRCCgqLdRg4S1LtldzMesQ7qtdKFu+Ri2iX537KEqqtlx7IjkL6tZieK5nHHw2n26fxVOgzhiG/jp0YlWrvHwAN53/fIl0EF+GW5Heixjwg/Af9Qs6d1OkEwl5+85S18unlzhKUcTObsqR/LL1VgRdRB8Ndlo/K/MLB2jRtZYMYHnF9ELRng2pP/kc2s2Bq9aZh4vqp9taPReZKQj4vKFva0JKRVqmPMOufz13Y00WsbyvxEgN2jIRnR16EB00scYIeXt43C4kRpnc/VFi4aNcQJ42MKrCCpyFNsGkTZgmp2Zc5PmjSOftZRT071SgTUF+N/515OvY0VuW1hZ0NA6cjRb/D5I8Gvwu/c=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(136003)(346002)(39860400002)(376002)(396003)(40470700004)(46966006)(36840700001)(8676002)(4326008)(316002)(41300700001)(54906003)(70206006)(70586007)(6916009)(86362001)(478600001)(5660300002)(81166007)(8936002)(36756003)(356005)(7696005)(82310400005)(2616005)(4744005)(2906002)(82740400003)(26005)(6666004)(40480700001)(36860700001)(40460700003)(47076005)(426003)(83380400001)(1076003)(336012)(16526019)(186003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2022 21:18:29.4157 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dd76030e-e359-41a9-7da5-08da8a040505
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT089.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6285
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Frank Min <Frank.Min@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Hawking Zhang <Hawking.Zhang@amd.com>

Add ip block support for gfx v11_0_3.

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Frank Min <Frank.Min@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 2d419bb18787..ee4ae555c487 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -1784,6 +1784,7 @@ static int amdgpu_discovery_set_gc_ip_blocks(struct amdgpu_device *adev)
 	case IP_VERSION(11, 0, 0):
 	case IP_VERSION(11, 0, 1):
 	case IP_VERSION(11, 0, 2):
+	case IP_VERSION(11, 0, 3):
 		amdgpu_device_ip_block_add(adev, &gfx_v11_0_ip_block);
 		break;
 	default:
-- 
2.37.1

