Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78DE0EB64DD
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Aug 2023 07:01:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0040610E011;
	Thu, 17 Aug 2023 07:01:07 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2072.outbound.protection.outlook.com [40.107.102.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5C6B010E011
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Aug 2023 07:01:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GW/NwgVK5/23R2QaqVjiZn6SoOtMcgDQ0EqMUvtDugdmjpYIPK7Fm/iIy8hb1/ttXBteRuerIMTIlHQqPcbucor4GoqET06wBkJtQXfFMi0jpDCm1d0RRSjVjonEw/tl3BN8/ocJE5qQ6AqhYef9uOldFssEobBR3g6SxFNVa1Konqb6oqtbUo4J3J4WoegnlCNzaZPTyenq+UpaivSjATEx9bZUUC0/Tvg+emkyPePsTq8481l4+Oz6JPR42l0jBPT5JBkTH+0ztyGgu0mkWkhaZkvCozUc2y2dxi3uw+HUaxtSq4e1otCfvx7/z2rSSOUdHIn/u+g3M6ngN8hLqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SJqQ+XFvyc4ysBpxLZGBvzyJ4welS2gnjM/qV0MabEc=;
 b=UEKAimh7M4CdvtPxD2jlWrjEIs9SSggFMkmCTbClC7Lsi6OQxFStpv86vtrxXoVXLAA+hwLE+vjZOZu1bQQDWQ++IP3SFaEcrZs09mtFGHfGK/OD7gV6F4mNCf4KQnv9HcEanocnInISe0M47qRt/BzktBdrWizMKVe7SHVROGCGdqVxcPV0VZN7sztzNcvBHKuyuxYLPZiL7BPNYIjkJnWpofNqil9dD29uGmmXX8XjZxz8YdgL6tisok4fiuNNaD60bKbKfhbO1u8krNYzgvon1yLuDz6iKP3EXhT0WBvJ3pO5yr6Vrud/xn3npbTYPDaEVfcg1fjAUK6SJM4bRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SJqQ+XFvyc4ysBpxLZGBvzyJ4welS2gnjM/qV0MabEc=;
 b=Pz4uSi28Jr3divT0ufxKyCre1I63oQAeiC/W95pD1XPnDdzBxZwgCFCneIYAGw//fDYPrmlWrKNhpLlyQrRG5cTfiGIOhVw4kgHez1c6PR6J1ijxwc3JZalcDX96enWRAlVydWJFyK9sSezK9yO2Co9jwlc/EGuexTS839OUP0k=
Received: from DS7PR06CA0036.namprd06.prod.outlook.com (2603:10b6:8:54::14) by
 IA1PR12MB6483.namprd12.prod.outlook.com (2603:10b6:208:3a8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Thu, 17 Aug
 2023 07:01:03 +0000
Received: from DM6NAM11FT094.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:54:cafe::37) by DS7PR06CA0036.outlook.office365.com
 (2603:10b6:8:54::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.33 via Frontend
 Transport; Thu, 17 Aug 2023 07:01:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT094.mail.protection.outlook.com (10.13.172.195) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.17 via Frontend Transport; Thu, 17 Aug 2023 07:01:02 +0000
Received: from yifan.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 17 Aug
 2023 02:00:58 -0500
From: Yifan Zhang <yifan1.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: remove unused parameter in amdgpu_vmid_grab_idle
Date: Thu, 17 Aug 2023 15:00:42 +0800
Message-ID: <20230817070042.3135567-1-yifan1.zhang@amd.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT094:EE_|IA1PR12MB6483:EE_
X-MS-Office365-Filtering-Correlation-Id: cd004b19-1a52-4963-ee54-08db9eefb849
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qV0VQLZWu+xIdRYfAePqugQeSq1ADchM6guO+oaesVub9QDZaQON1H9DwAqT6DBFwtL5oOtlp/JKmoQJUk0/H95UOIXPBhM2+pHCe8dsVQK1Z1ezWTGyeXjVArC5Y+NVOPaudDe4Te/plLxGyxVV+x8Utg4CEeVmOqIHRSQ7UGYaCRbi8tQtqFVmaJKnt87rgiXFYWIMGEZM6ISDkzj7fOSOpYaCP8hVsRVk4io93nO/z9N8v53PtmmGcLWEMd4VI1khXweC/QbwCQ0dPUkn8r7kFzUwqxWKiWLpJA3Cm47yXKgafklpgkVHwXNRTguWAsDM2rssyjc2g//K10f044u6x0cMAE25qC8SUgKbRUle9ss9sSbOg6+Iy448dQmv/t4yY+eAlNAd90Xg3SFWR9nhweFvCCA4rro4XwKwr/JpQRlRj1MnvPYmYXj8VleEgLx2MGCxkm85OKHVXzhskuHZ3gj0QLkDjfW4RJEE5soql/1FGSDeLev/P5g62eZbeOKEKQxKiDkamadzZVy0sYCKOQqKKfydnrXS6Ny66Bk2IaG1tdCSLD/+WKHJsngTJuFK61yglKv8YKBy6XZ63znu9ztcSmJ8fJOQRqkAP72HtHb+yEnA4AUlzW7u8yXjGUsk9s4uDTCFm7Oz/fE++XM4f2Gmyiw//z4IpPNHzumtmDk2ryVffHRDQCvOX0fuErXMgzgwUMl1Ds7OhsSp3mirfu/AyqH8RS16TM3ZN8DZkmyCn7NFm1ft1iDkFUuVCUMaQTNNGjQZWL2Cwq/yog==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(396003)(346002)(376002)(39860400002)(1800799009)(451199024)(186009)(82310400011)(40470700004)(36840700001)(46966006)(40460700003)(2906002)(83380400001)(26005)(86362001)(40480700001)(336012)(478600001)(426003)(36756003)(7696005)(2616005)(6666004)(1076003)(16526019)(5660300002)(36860700001)(41300700001)(54906003)(82740400003)(356005)(316002)(70206006)(70586007)(81166007)(6916009)(4326008)(8676002)(8936002)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2023 07:01:02.8501 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cd004b19-1a52-4963-ee54-08db9eefb849
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT094.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6483
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
Cc: Alexander.Deucher@amd.com, Yifan Zhang <yifan1.zhang@amd.com>,
 christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

amdgpu_vm is not used in amdgpu_vmid_grab_idle.

Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
index ff1ea99292fb..ddd0891da116 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
@@ -188,7 +188,6 @@ static bool amdgpu_vmid_compatible(struct amdgpu_vmid *id,
 /**
  * amdgpu_vmid_grab_idle - grab idle VMID
  *
- * @vm: vm to allocate id for
  * @ring: ring we want to submit job to
  * @idle: resulting idle VMID
  * @fence: fence to wait for if no id could be grabbed
@@ -196,8 +195,7 @@ static bool amdgpu_vmid_compatible(struct amdgpu_vmid *id,
  * Try to find an idle VMID, if none is idle add a fence to wait to the sync
  * object. Returns -ENOMEM when we are out of memory.
  */
-static int amdgpu_vmid_grab_idle(struct amdgpu_vm *vm,
-				 struct amdgpu_ring *ring,
+static int amdgpu_vmid_grab_idle(struct amdgpu_ring *ring,
 				 struct amdgpu_vmid **idle,
 				 struct dma_fence **fence)
 {
@@ -405,7 +403,7 @@ int amdgpu_vmid_grab(struct amdgpu_vm *vm, struct amdgpu_ring *ring,
 	int r = 0;
 
 	mutex_lock(&id_mgr->lock);
-	r = amdgpu_vmid_grab_idle(vm, ring, &idle, fence);
+	r = amdgpu_vmid_grab_idle(ring, &idle, fence);
 	if (r || !idle)
 		goto error;
 
-- 
2.37.3

