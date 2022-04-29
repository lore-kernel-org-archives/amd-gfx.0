Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2250C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Apr 2022 17:47:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D88FC10F4D4;
	Fri, 29 Apr 2022 17:47:16 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2053.outbound.protection.outlook.com [40.107.93.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CCED910F3BE
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Apr 2022 17:47:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kTlMraNxWZKCo+YrlapEqOJdnT0BYOdadKIWjstJSpY1yYWshPDD2RvcLgAAAH6vKfodgab98OoS5/tSC8sgHorD1HCaCFT8ZfWeFz+j9gveSfGRjRZyI0/hg1NDFBovKwRQx/OZ8lYbS+ZjGqo6/SaiLeWBB+dMD9BSOSTMY/8Q2QUJeGsPeW3UvAv/9lLUVObg3W/Y80kscTqo7ikvHeHE2U/C2tFK8wqhaWlT6MCzVKbIceuznrWocMRMjdiXj0fTq5pEjt48hxvsSXtqLiEDD1+vlJ0gQF3v/PS/KsuoUrZXXmrbBuHoIljsp2eAe9VfhZSw7S8tPGTopO+zCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dKqunUZVglhyCzP9ffiiw4QBzLJlpz9UmbOywyS1Na0=;
 b=Mms3dAu/ivBu1iPU8FHq+AcjnYRdMGtru4E3gRWvU8DEZjmvQRxEGW7xxDh1GPPIVIGWGDihCXhXyje0N9yhQx1g8kmfUJWGk5IFipSiPJ5b9r+oVqiTPNRyrUmeGS1r9r1Of7IKsklvcu4REozelZK6q+a5+2vQUITcZQPIASa1FHA1QJqoAfDcuSoEJj7T5e8UpCaZF1k+8RnRmMklscsGNwbErNrZ5+F29zbhiN4UyA83h+yAUAcQREkySHe1/u6bVTw5M05+pTbFJN7Hn7TQL+BW9VqS8JfDkXBBIMb80to9cKC/6E5W/2121cb2Rrzs5vKt+hjSV7W2yxSnDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dKqunUZVglhyCzP9ffiiw4QBzLJlpz9UmbOywyS1Na0=;
 b=L92Nj8Zj57pR9HQaz1ZVp+GXt8p+VIBqCtP8lX+vU+ffcyIAgmqccfyxK/VyseV/IEqt/ZpQJtuwIzd8CklBlom5Qygu3IswJjWOU1JfJt2mLcgl6/qmmIXULcz8picK2+poxB8Zyd5LtZFLozKw4k16nE/d0GAWyhjqIEaiRB0=
Received: from DM6PR02CA0079.namprd02.prod.outlook.com (2603:10b6:5:1f4::20)
 by MWHPR1201MB0272.namprd12.prod.outlook.com (2603:10b6:301:52::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Fri, 29 Apr
 2022 17:47:11 +0000
Received: from DM6NAM11FT054.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1f4:cafe::2b) by DM6PR02CA0079.outlook.office365.com
 (2603:10b6:5:1f4::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.14 via Frontend
 Transport; Fri, 29 Apr 2022 17:47:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT054.mail.protection.outlook.com (10.13.173.95) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5206.12 via Frontend Transport; Fri, 29 Apr 2022 17:47:10 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 29 Apr
 2022 12:47:06 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 51/73] drm/amdgpu/mes: implement resuming all gangs
Date: Fri, 29 Apr 2022 13:46:02 -0400
Message-ID: <20220429174624.459475-52-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220429174624.459475-1-alexander.deucher@amd.com>
References: <20220429174624.459475-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a43c7563-8274-447a-0eaf-08da2a0849a8
X-MS-TrafficTypeDiagnostic: MWHPR1201MB0272:EE_
X-Microsoft-Antispam-PRVS: <MWHPR1201MB0272103FF09EF35BF5E067DBF7FC9@MWHPR1201MB0272.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EtBbzSfMuba9ezjlknpB6D/AZ3+enx5V0GmrJhAcoxJebOCC1DnE5F0NGvVWaxFVnuzRTto5fFQUzNt8sMXFQQqoViI/7GGVs0X6pCo/r2k8g3r6FGa59Y8APvAeGhplBJ+6F7TSou9Tt1Hmbugi7QS07OwhnDWBsuJXiUSw8DGk075AxgOubZWTZfnEgrnC3WjQ/GyhKr9cnfWpk/SxOePFkWUOyyBIe8Hjd7G9dTpXQsMyn6a9o5afodCHAoGBfNDZ89bZzvyqxkumjDm9zX2QHrWLVXIMe6d7tfn/6s1g07wGrx6+yka8a/7/jPGPDlRMdNYEXe6dOTAA+RKUWflk4kD4DB+SZkcehtvZ/mVLQFLSecf7z4brf/GmPhkBQnxP6fMBImd0sJfbXWR9wbOA0wfrcWsOg+/PT208igWJVODjqS9hUDjwF9a2yJEYiLOO4KbjTk9dAbvnnObg+gz9k6/qSOHe0QncxXk3nOSpruVIokV6F3DJ4oO00ZGzWFVIaLMteIACZgMRPGHfEiuuMFeN91BIxgwDPk++hW2tGUhf8CoPFbl32NsrSebetub4I3HNf1oiN4f6L1JeeaWZZhwkSJtY11JKhtBWZXL8ipzr30qqj+6oxbBMHU9wuTFNV/HLQ8YT92aiyaQUqJHYFS9Ywpdt9luCWsO+cQBTYWTUtyTw0PiCqtC7hR/J26iELWbPF2YV4Tu+RZPLxQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(36860700001)(8676002)(1076003)(4326008)(6666004)(36756003)(66574015)(5660300002)(2906002)(336012)(426003)(47076005)(26005)(186003)(16526019)(356005)(8936002)(508600001)(40460700003)(86362001)(83380400001)(316002)(7696005)(54906003)(6916009)(2616005)(82310400005)(70586007)(70206006)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2022 17:47:10.9108 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a43c7563-8274-447a-0eaf-08da2a0849a8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT054.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0272
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Jack Xiao <Jack.Xiao@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Jack Xiao <Jack.Xiao@amd.com>

Implement resuming all gangs.

Signed-off-by: Jack Xiao <Jack.Xiao@amd.com>
Acked-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 25 +++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h |  1 +
 2 files changed, 26 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index e64f2a4b5a3b..b58af81f04a3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -471,3 +471,28 @@ int amdgpu_mes_suspend(struct amdgpu_device *adev)
 	mutex_unlock(&adev->mes.mutex);
 	return 0;
 }
+
+int amdgpu_mes_resume(struct amdgpu_device *adev)
+{
+	struct idr *idp;
+	struct amdgpu_mes_process *process;
+	struct amdgpu_mes_gang *gang;
+	struct mes_resume_gang_input input;
+	int r, pasid;
+
+	mutex_lock(&adev->mes.mutex);
+
+	idp = &adev->mes.pasid_idr;
+
+	idr_for_each_entry(idp, process, pasid) {
+		list_for_each_entry(gang, &process->gang_list, list) {
+			r = adev->mes.funcs->resume_gang(&adev->mes, &input);
+			if (r)
+				DRM_ERROR("failed to resume pasid %d gangid %d",
+					 pasid, gang->gang_id);
+		}
+	}
+
+	mutex_unlock(&adev->mes.mutex);
+	return 0;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
index 667fc9f9b21b..43d3a689732a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
@@ -231,5 +231,6 @@ int amdgpu_mes_add_gang(struct amdgpu_device *adev, int pasid,
 int amdgpu_mes_remove_gang(struct amdgpu_device *adev, int gang_id);
 
 int amdgpu_mes_suspend(struct amdgpu_device *adev);
+int amdgpu_mes_resume(struct amdgpu_device *adev);
 
 #endif /* __AMDGPU_MES_H__ */
-- 
2.35.1

