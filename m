Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABC4BC433F5
	for <amd-gfx@archiver.kernel.org>; Sun, 30 Jan 2022 07:12:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 37EE010F5C2;
	Sun, 30 Jan 2022 07:12:18 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2086.outbound.protection.outlook.com [40.107.220.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 646AF10F5CA
 for <amd-gfx@lists.freedesktop.org>; Sun, 30 Jan 2022 07:12:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lsyk4LrUBCWvY5sZD2MLoWZLd76pXf6ebWOCpb5TwYi1vQ2S25YipXej/+9FhUpw5bCsTN0DLX0ZfVzuMKTNDOniC3sI1l6Uf8AJU+hApJwYXd3ekPBoXg3nhHj4bPvOCclM56iArPENT0X9zgM/9d1DPwAzb998xAg1oZ4yf5q0DVOcFXWSsO3aVTJLfqbBeuxIYIxMteD8Npirv296g1rEkwknOUr5UjuvYImJbriC8XQvFbdgsV1A/dQo+7UrvbJtqQ/2P77OSvar8VRet/F1dcb4SyLl0Jlb9XP9a8Iwxho1zOjG452L1pxQC42U5+ENx/VbFeQSCBX9VM6DtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OvxGKSCdkQOT5RvJb/sKJH+rWtrKJWzpOgroBHYxEro=;
 b=HBkbmlD4Wu4oM5OxGV+0hqi90Oond506GcWs8bOEEp+duNHEwNgbOliuqhvz+5BkUFD2k29QhXXL0bG3UebzI0AttUYVsI/boniM81apI+qDMEEMTOE+78bFAP8Rbb4fTIDWjz+lBQzXhHMgIvnUvfP7IyQ3ClxgBoYzI/RKV/MQSddjObdh/eN5UUaPOYqwhRn6Qzs5gZCsCl8TKNYq0ZPLZP8MUftWMLOcmQmfUQ7YeQ0nzqsElopX7y1bfeAiDLnjLeiyi52VKZFJfmfsqCiSKfiEcSqXdiDcGbM40ng8pfuBxPFRokecqJSlR4zugvs/x+54kdbprB7yBoKQmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OvxGKSCdkQOT5RvJb/sKJH+rWtrKJWzpOgroBHYxEro=;
 b=be0TNE9F/k4XCRpvSerDVV3WgjFYCBjc3kTdIhY9tIgjlYQfxit8O0MnxzNbJBW2njDC2XvjjflAkPPkwI8lTaK5i0C16ta41HKP/zx0cZeSRImkLM7leIARe0rfColkgkcJ1W3+tu7cVmVVxCx3UuaH0FbKn2in6uTw/KDETYY=
Received: from BN6PR17CA0058.namprd17.prod.outlook.com (2603:10b6:405:75::47)
 by DM5PR1201MB0155.namprd12.prod.outlook.com (2603:10b6:4:55::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.18; Sun, 30 Jan
 2022 07:12:14 +0000
Received: from BN8NAM11FT021.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:75:cafe::50) by BN6PR17CA0058.outlook.office365.com
 (2603:10b6:405:75::47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.20 via Frontend
 Transport; Sun, 30 Jan 2022 07:12:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT021.mail.protection.outlook.com (10.13.177.114) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4930.15 via Frontend Transport; Sun, 30 Jan 2022 07:12:13 +0000
Received: from thomas-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Sun, 30 Jan
 2022 01:12:11 -0600
From: yipechai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH V2 2/2] Revert "drm/amdgpu: Add judgement to avoid infinite
 loop"
Date: Sun, 30 Jan 2022 15:11:40 +0800
Message-ID: <20220130071140.3846493-2-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220130071140.3846493-1-YiPeng.Chai@amd.com>
References: <20220130071140.3846493-1-YiPeng.Chai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f12db819-b33f-4534-5894-08d9e3bfd722
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0155:EE_
X-Microsoft-Antispam-PRVS: <DM5PR1201MB01559338600A350D137E4480FC249@DM5PR1201MB0155.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:159;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ysUJh0FFMwU7EcuCo2EqU9uazRxxJCX1RISEbTKpHbs1KSB6avTZft8GpklbZ53TqWV4I0im6qQOe2ZQ2Mhh+XsyzrAakG6IYsf9q+aErjPWyaHSGytx40MWEPT4UVNodNX4gOT3DZ8J7n185ouQQbsCFGSYQcPdTTSjkuG8qddPUKuIV0EiUqNBGLc/4oX571Ty11Dr17+VcUXhMCLuEHZ/jbLwblH19w0SJkwmvPsrhNgcyjc0Jd1LIwybQMZK7uUlp80gKi+NODKJMFHjXT9V+qhP7/8EpOfTyZEIfyiKnrAkW0r2WIkj4lvKEgTrA0IjAtSiGTInFL94cIxJzKlv36n8IpUNoZD3ewRPBRUZLQPhWGrbZ4+SnBwCYAc1VOa6LRI5QRKM0icgJUS3mHZdVzhQov97jmGJ0tGMhIIHoNZNieuZyuj5cCpIMF+DhViA02/vwMOLmtSiUPb1vOEZNvEo5dKPe8fjnOjx7b/gTOqClYO3Kt0sbqFEM1PFAP8HSU1BYWWe7miisvvwmJowNvDHvA4iXIzGp45J7//pZPYr4PE8rIBPSI6P96QBMmipIK6BpKxp1SzQEOnoLAMKzFgqwsOOUXNOMjAzgmIT+nDc0kQhyrDnpCqhJAFq++EkZvk4iOi9RG3vShUwBqzQIa8SCUAVPUqzy9EhOUv+ZF+h5B+F5y14YDdwdmYA13S0kOJ0m9ScNP8rFIFpHoDpdtr0zyosHz84yiI3DxM=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(86362001)(2906002)(6916009)(54906003)(6666004)(81166007)(2616005)(83380400001)(36756003)(356005)(40460700003)(8936002)(4326008)(8676002)(5660300002)(336012)(16526019)(70206006)(70586007)(7696005)(1076003)(186003)(508600001)(26005)(426003)(36860700001)(47076005)(82310400004)(316002)(43062005)(36900700001)(20210929001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2022 07:12:13.6621 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f12db819-b33f-4534-5894-08d9e3bfd722
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT021.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0155
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
Cc: Tao.Zhou1@amd.com, Hawking.Zhang@amd.com, John.Clements@amd.com,
 yipechai <YiPeng.Chai@amd.com>, yipechai@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The commit 8583c8983f1b ("drm/amdgpu: Fixed the defect of
soft lock caused by infinite loop") had fixed this defect.

Revert workaround commit 76641cbbf196 ("drm/amdgpu: Add
judgement to avoid infinite loop").

Signed-off-by: yipechai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 9b94c9c4960c..5558df3b21f3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -886,7 +886,6 @@ static int amdgpu_ras_block_match_default(struct amdgpu_ras_block_object *block_
 static struct amdgpu_ras_block_object *amdgpu_ras_get_ras_block(struct amdgpu_device *adev,
 					enum amdgpu_ras_block block, uint32_t sub_block_index)
 {
-	int loop_cnt = 0;
 	struct amdgpu_ras_block_list *node, *tmp;
 	struct amdgpu_ras_block_object *obj;
 
@@ -910,9 +909,6 @@ static struct amdgpu_ras_block_object *amdgpu_ras_get_ras_block(struct amdgpu_de
 			if (amdgpu_ras_block_match_default(obj, block) == 0)
 				return obj;
 		}
-
-		if (++loop_cnt >= AMDGPU_RAS_BLOCK__LAST)
-			break;
 	}
 
 	return NULL;
-- 
2.25.1

