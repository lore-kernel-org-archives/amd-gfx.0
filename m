Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3932CA9ED0
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Oct 2026 01:34:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 51BE610E6FE;
	Tue, 13 Oct 2026 01:34:10 +0000 (UTC)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011051.outbound.protection.outlook.com [52.101.52.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7FF4710E701
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Oct 2026 01:34:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gFYxR4pCPhgZUhNIoQzMZgeRthkyUl92AJEgi+Mnez/sfvOcVKei7fKjGkwbiGfs3BTWU8YalS93N7Ztw8q627WBmX+EgVNx8PwiDyjwvoD0ZnkwXjxAM8mEZGIQL0DQjCq9Wg5XOgwAPU7vBdCbbNEgMverA4hiUKYL2yt6Xd2mgOKa7IdZ1PzblUNAMIp+T6eSEBtcYqb2JKrRzcApCxHGohrvzxgleNvNZIU/M0cUdKbw9deIG4LRwckDiXDD6rfZuuV8kQLoMAL+JrnI4p3dZt7/hyWICs6lINsCwRjmLqE5Tibldx1w98d21hsv5PIoKdOdPEfDO6MA+UyulQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WmtYS8oYwa++viG+lgnmW6pGY7Q97Ji4LlFNXIVgr4U=;
 b=nkKjh1RgHh5uKMlC6IVehUBICGYQzqH0Hu2PkUrUtcZMKQAATyd8d6kP3KnUXnVXsZ/8rirotSOOBDv+N3GM3fJFqCyxL+0UobIkN2BM7kmSZOrXz9iZp6WKDl1eEFBCefQ6M9tlbotkwVeb+ssxzQHQTfUv5bNOaTx0pN61/Wg2Rz9NNvlVsteIlfJgt7V+Hn0Jji8MGuK0QEXl7f/UIcFVQWhDJU11eJ2sUVKTUwMyszRIjWgrSA+vIJIJk7e6cEvSSi7ubR5j+vm/Mo/mfgH/AG2Kb3WEDJZXPJznWYDNxB10lc9oJk5PEwLEDkDDiZJSntONcv8PLIy34xzDrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WmtYS8oYwa++viG+lgnmW6pGY7Q97Ji4LlFNXIVgr4U=;
 b=UFFpeJ1P9UaHDYQIthzcRp1P8baagKcI50C0Jw7DumDWurk/F+EGhRzzIMkYVSj+vlCkB40znhwlahGoR8gAVh/NSb1XRGV75x4v0/66dlKanIqKuBhgNVN01H3to0N5/fYtF9mamTHgtpSLdY4B4AWRWjS0aIgYY9+MNfd3rLM=
Received: from BN9PR03CA0799.namprd03.prod.outlook.com (2603:10b6:408:13f::24)
 by FT1PR12MB727195.namprd12.prod.outlook.com (2603:10b6:170:2c::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Tue, 13 Oct
 2026 01:33:59 +0000
Received: from BN5PEPF0004698E.namprd02.prod.outlook.com
 (2603:10b6:408:13f:cafe::76) by BN9PR03CA0799.outlook.office365.com
 (2603:10b6:408:13f::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Tue,
 13 Oct 2026 01:33:59 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN5PEPF0004698E.mail.protection.outlook.com (10.167.245.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.14 via Frontend Transport; Tue, 13 Oct 2026 01:33:59 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 12 Oct
 2026 20:33:53 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Mon, 12 Oct 2026 20:33:51 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <prike.liang@amd.com>, <sukhatri@amd.com>,
 Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH v2 3/4] drm/amdgpu: keep the eviction fence until the last
 handle is closed
Date: Tue, 13 Oct 2026 09:33:37 +0800
Message-ID: <20261013013347.2015715-3-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261013013347.2015715-1-Jesse.Zhang@amd.com>
References: <20261013013347.2015715-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN5PEPF0004698E:EE_|FT1PR12MB727195:EE_
X-MS-Office365-Filtering-Correlation-Id: 5247f2ef-4de0-4e14-2b7a-08df28ca0e3b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|36860700016|1800799024|376014|18002099003|22082099003|10067099003|11063799006|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: GkKaCzwt0UofqTRrLqgWAhbfwtWyyMv4ibxTIWP1nouejZpfJlm4UDnFoizu27wy9lNpNhJQkgAhilsNcxUdfKqCv1NQDHBnpQ80YPP56xsVf8fw8ltCXiVUQpdpSuPydi/s29SZsdogrvY1SXPvc3qUdHisuFQukAsSMgNoCq3PEuD++pRD0MUIcx9EmbpLx8XK7smrSCwc2HQ+H5IhdGb20HxXURLNCx2eUCRIMpKq/HJe+SMxzbz7ur9SfpuO9q0P6FdejcEgR873tlspmGF/nlqRJ+uqV+2l5irbn2qKsW/fKzb/OPt4K0r8QaC+41W7NtjpAPgfa59rKfVTktl+4H6x+QiAr51anWJiH4Vfe+pcsyjv60wpeCqVg9TfQ/LMS6UD62pzVNzUsFZC0y8fRSdBrBzqx0IfRPVCh5+c5JMjON1O2ZJnUvCNEWBhVttcfPP0DxXV/zx5OXrKKqPJW5KVDbrT7HI4+oPbHKYgGEcD2NtyC+CwISAJtBfw5hPdOR9vpY3UCWX7/1+aM2xIawqy1sZOySfiwk4MICihAMHZvKJtAa243vF7ia12r5K7kOrxK9Y8CVBTeDDAmz0Gi3LHt37yWG8zf27WxCfTy5qml3zadezx0TaUa1nc5N9J0BRfvJDz3WMISGULkP4J64lmmP6dJXP68+gf31AuYNydI+b17HTbWDg25Og0VPIr80JpzTpj9nHjnKb0lA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(36860700016)(1800799024)(376014)(18002099003)(22082099003)(10067099003)(11063799006)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Y8hfublxEJNQp//759CkAXzp5DiK1Feigc8MLIZ94mE456Fawvm+m/rBTBtJoKgwpZiOtduoNolnZnUY1n2DSsH1Bxyl03rlS6NZ6HZkUbOYCARPHLKmWhORuyV8osuex3rzs0jZC5LyGj5voAtPqp+MMjm3P5T269xNY7y6Y+/WlCoGRK8N8midV9BRs2oW/OJ60dttkaMfWlKt96eps2dfl8EW5Tew99i1E3g1KAQuPxiZ6y0kqM88WzjfUGIURV9GeV6rGhVwX7elGSkubKvpAaegGTafcJKRF3hdQvdoXwHOQlyAfWQWFHL4CHoueHhnXD9j/8+OUzqq5ioqIn7xHHWM/ggujgRrGmL9en8GzAk0ZOxSBBmTIF8xLWRepjI/YlEsGHc86hbYzOyxY6WVpzEs9VJTHfkuPJ4rAG3tJ6AjFaFOC7NRRtRxWT70
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 01:33:59.6749 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5247f2ef-4de0-4e14-2b7a-08df28ca0e3b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN5PEPF0004698E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FT1PR12MB727195
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

amdgpu_gem_object_close() detaches the user queue eviction fence from
the BO before it checks bo_va->ref_count, so closing any handle of a BO
removes the fence, even when the file still has another handle to the
BO and the bo_va with its GPU mappings stays. The BO can then be evicted
without suspending the user queues of the file, which keep accessing it
through mappings that are only marked for update.

Seen on navi31 with a SDMA user queue: a BO opened twice in the same
file (GEM_FLINK + GEM_OPEN) loses its eviction fence when the second
handle is closed (traced attach/detach of the fence):

  attach bo=ffff8c78a6c84c00
  GEM_CLOSE handle=7
  detach bo=ffff8c78a6c84c00

while handle 6 and the mapping are still in use.

Only detach the fence when the last reference to the bo_va goes away,
matching amdgpu_gem_object_open(), which attaches it only when the
bo_va is created. With this the fence stays until the file is closed.

Fixes: 31f7efcdca4d ("drm/amdgpu: enable eviction fence")
Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index 8dbd7bb77305..0552b17d9aa8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -351,11 +351,14 @@ static void amdgpu_gem_object_close(struct drm_gem_object *obj,
 			goto out_unlock;
 	}
 
+	bo_va = amdgpu_vm_bo_find(vm, bo);
+	/* the fence is attached once per bo_va, so keep it for other handles */
+	if (bo_va && --bo_va->ref_count)
+		goto out_unlock;
+
 	if (!amdgpu_vm_is_bo_always_valid(vm, bo))
 		amdgpu_evf_mgr_detach_fence(&fpriv->evf_mgr, bo);
-
-	bo_va = amdgpu_vm_bo_find(vm, bo);
-	if (!bo_va || --bo_va->ref_count)
+	if (!bo_va)
 		goto out_unlock;
 
 	amdgpu_vm_bo_del(adev, bo_va);
-- 
2.50.1

