Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 733C8C4332F
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Mar 2022 16:01:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A55AA10E606;
	Tue,  1 Mar 2022 16:01:34 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2071.outbound.protection.outlook.com [40.107.93.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4468510E60C
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Mar 2022 16:01:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eFcMOuuC/+7A7tFdalv3lyGqkNzydvYF+xKhy2hGbYYm8Ocix73i28PMtv+I5JPBaKliltdv+V/euaxrrrSfrwRjjKQsUqVAQly4a611SmHTjb+/fWFhsry38bpXD3cQfJVGCsViGJMIDbXGlObZJClXQ+0uiNRt6lGcLnNv7jMdXXDXR0L5eJ0o7klHcb+uW46YWpIAfc5pmF9IvzOyq9/eIpaCqcHO6Hd9Cmd9vwN2HGBZC6ky8P/rmEeU1re1HKuNoEAtEwv3Rya43yb0vqDQi07S6g09jdmzvY9FCILfWF4mJzkpba6fwj8hn68JueoBlNg6uYPW2SAoR/MZuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wE6ZggY77x+e3QFwEI5bGvNKv5U5qKi4nLRTefC9kGk=;
 b=gUi04pNZLqLvOAM639H8A0wZN/36st4ZXheq3Jmy8YywdXUkxDxkZvUlqdnSSHYBCzYmFdb6/R9hgP6bECEchWQ+y5s4GKszQgTDzqES3qYJ9n6/aSl368A6sDb5nCOq/6kbb89y6wDIvKs3kaFSg7+TuDfSbdzocHTLZ+C4UtXDqOQ0SocfO2Vo+mxgZjipgrZJrpABn2/16BZRxXMetme0QeC+nV3jJjRcIL/olmPu8lLBbwwONZGbQOlRdP+5z8KWkYykDYcLu73iQ57Q8uAp6v3P6AXtOw+hFhEUxm0s+BqOHnpCyW5vSDmqxur1ODciAYraDTqppPqZ2CePlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wE6ZggY77x+e3QFwEI5bGvNKv5U5qKi4nLRTefC9kGk=;
 b=5UBoHHg9kNtjpiL9W0v2rjqhgkK1z5Dr1nKME2BtU/w+tnDaYvEjLGhq9Yk4+msdt05CVLff2AtzHU9P7RP7nZFb7h9tU5L3wInqgxfm4FW6axEyNZyuk0QbbY3Uy3+/1OUao6g2OEruQsDUXD8ZX6lpQ1mS0jN3zgnkPnrZIlc=
Received: from DM3PR03CA0012.namprd03.prod.outlook.com (2603:10b6:0:50::22) by
 MN2PR12MB3696.namprd12.prod.outlook.com (2603:10b6:208:169::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.22; Tue, 1 Mar
 2022 16:01:30 +0000
Received: from DM6NAM11FT034.eop-nam11.prod.protection.outlook.com
 (2603:10b6:0:50:cafe::e7) by DM3PR03CA0012.outlook.office365.com
 (2603:10b6:0:50::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14 via Frontend
 Transport; Tue, 1 Mar 2022 16:01:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT034.mail.protection.outlook.com (10.13.173.47) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5017.22 via Frontend Transport; Tue, 1 Mar 2022 16:01:29 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Tue, 1 Mar
 2022 10:01:28 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/3] drm/amdgpu/sdma5: drop unused cyan skillfish firmware
Date: Tue, 1 Mar 2022 11:01:14 -0500
Message-ID: <20220301160114.1404305-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220301160114.1404305-1-alexander.deucher@amd.com>
References: <20220301160114.1404305-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 90e1a46c-bbad-4d06-ea50-08d9fb9cbf9c
X-MS-TrafficTypeDiagnostic: MN2PR12MB3696:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB3696345D051CE3190F2B29F2F7029@MN2PR12MB3696.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BoR0AeS1qB6R17li5OukwPmfQwg1jKTFIqLfuXDgBazJSbiPzo3mYLLGsfCPVy+k2kgxCzgTVJTvNKo4lKk5g22KyHzlVNMECqewS/9ISZsE/ljlgR3frIExcjD4J0wJ6pXpImOVjlQLIXZphd6GyigOhCaXC18uSu7SaZQ4V353vG0Llq85vYaAcLJS4gvnorH+Bz4iDIvWMVVMF6Kzi+P8XaZPNHiInmDLvcdd2iE/KyRQn08cm2p9vFvJO5FDr0hU4mmHDn7d5PnQme9KE1HiMmA6RUiHm+opEmzY9nhLp1O0kwpqdAmq3GiS8KjLwmZbBrjdhI0eF1ETKuOXZmStvuAipNBcH7UBzmyd+rM3hJRkfEa4AwNT1lC/HBsesWpJS4+wUHaOQQaR3uGsmU9gpbc1U80GacywKFFPLHK9gscJII6X7H/zVdKkLBijwOIZNuqGotEY/SZD0O8enHLaNExU5ZWquYYuKGihory34fcBfco3VACxkzl9dQXcsnB9ZoCkNU/j0bgTTIpnPB+W4jG1EHkPTo4qI0j7nAjtNk6HcYKp4ztVHgxj+nJr+/JSDw7z2UCnfWxdT/RfD3WHt7FKpnIcQCmHtEqwr8Zgo8H5YczSggUnV/6HPJv0oqts8oh300XBy4KLxaElWMVpAL+sm4P8z1RxGx0Rq/yovev01HB2NeR8OGTUisHiKPA+7/icSJgSAquW5zzYvg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(356005)(7696005)(6916009)(316002)(81166007)(70586007)(8936002)(508600001)(4326008)(86362001)(6666004)(70206006)(40460700003)(8676002)(82310400004)(2616005)(186003)(16526019)(1076003)(5660300002)(36756003)(2906002)(26005)(426003)(336012)(36860700001)(83380400001)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2022 16:01:29.6900 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 90e1a46c-bbad-4d06-ea50-08d9fb9cbf9c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT034.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3696
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Leftover from bring up.  Not used anymore.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
index 81e033549dda..53a8df4b030e 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
@@ -51,9 +51,6 @@ MODULE_FIRMWARE("amdgpu/navi14_sdma1.bin");
 MODULE_FIRMWARE("amdgpu/navi12_sdma.bin");
 MODULE_FIRMWARE("amdgpu/navi12_sdma1.bin");
 
-MODULE_FIRMWARE("amdgpu/cyan_skillfish_sdma.bin");
-MODULE_FIRMWARE("amdgpu/cyan_skillfish_sdma1.bin");
-
 MODULE_FIRMWARE("amdgpu/cyan_skillfish2_sdma.bin");
 MODULE_FIRMWARE("amdgpu/cyan_skillfish2_sdma1.bin");
 
@@ -264,10 +261,7 @@ static int sdma_v5_0_init_microcode(struct amdgpu_device *adev)
 		chip_name = "navi12";
 		break;
 	case IP_VERSION(5, 0, 1):
-		if (adev->apu_flags & AMD_APU_IS_CYAN_SKILLFISH2)
-			chip_name = "cyan_skillfish2";
-		else
-			chip_name = "cyan_skillfish";
+		chip_name = "cyan_skillfish2";
 		break;
 	default:
 		BUG();
-- 
2.35.1

