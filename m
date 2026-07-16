Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 122A2C44512
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jul 2026 13:21:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A213B10F2F7;
	Thu, 16 Jul 2026 13:21:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wZtfT24W";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010059.outbound.protection.outlook.com
 [40.93.198.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D71A810F2F7
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Jul 2026 13:21:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cuk4ti+UxdrRmr/72hv9VPdtQMTfTy1osJ4iJGZb7ltHVy0nzMSUonH8aolXC7QdKZ7+xwY5MDNHKGOWQC0PQpAUayd/+A3sxVfChfPLEV3SnWUOc1C02uCTtIiOfhjAa7EYAAbIcP+42IAOXuK95BurRdfHFMsy6jB/f416z20jripyv7LABF2yix2yVj/Q317mXUOeYJjd+yyW3PnQkABEYihD98v5iOtaKJs5v4VpJejbaLCspG3KEYVf/vEscvC3wnKm4raPAguyG4mhmbD1ckupNorQf9ekT2wKxuRct6oMedx1WvDLWOhEaz+CrcpZVRr6YTghPyhUr9mv+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JEZAP6ONZUYplgS6ERUyv5HIKaXpjmq3r1xwQrGqsIw=;
 b=g4tpzFVFQt61x1eB1erwDo/2n3PeMxxVazPTgfEJYUyoc//WJcbIdk690I1HzpV/gCUh5KH6caIRSOTNJqGKY9K7KmUccjPk2fVELMLXO6PQAqEKsbxvL3Qv6DhPlZGyTdgchhspV3SdQl53A/c/bLVqJw1FkwS9f92xTUWJm3sFm7UuGyct1XIJvnJbHj40jY2RcIzhdRHJjC96BbQb0S7jouzAxP4kZSLPfHrYSeVmksWmMPapQg3KkmOImk3j99kK3xVLEonTBzXduArXJAmcS1jABVYiFLQ/Z8GRqSXUXjZ7iCTKOWW0USaup0e4YZVi+e8fqwM05i0Z9rWk8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JEZAP6ONZUYplgS6ERUyv5HIKaXpjmq3r1xwQrGqsIw=;
 b=wZtfT24WHHS38F/0IrtMXHTWW8NPurR5Ke5MrwisOauwHJZjn839862wuYhP6wROcgmMdnrIyjqBRzGA7t13MUUz/w3XZy6GUgB5GAW7tdRPs99GKm6oFI49Y4Xsx81jcy+eDePCgdw3etvt0jUa7KRek/BvT1czNCIFKq7sm98=
Received: from DS7P220CA0025.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:223::22) by
 IA1PR12MB8520.namprd12.prod.outlook.com (2603:10b6:208:44d::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.12; Thu, 16 Jul 2026 13:21:34 +0000
Received: from DS1PEPF00017095.namprd03.prod.outlook.com
 (2603:10b6:8:223:cafe::91) by DS7P220CA0025.outlook.office365.com
 (2603:10b6:8:223::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.12 via Frontend Transport; Thu,
 16 Jul 2026 13:21:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS1PEPF00017095.mail.protection.outlook.com (10.167.17.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Thu, 16 Jul 2026 13:21:33 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41; Thu, 16 Jul 2026 08:21:31 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH v12 3/5] drm/amdgpu: Remove queue-scoped WAIT_EVENT records on
 queue teardown
Date: Thu, 16 Jul 2026 18:50:58 +0530
Message-ID: <20260716132100.3496327-4-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260716132100.3496327-1-srinivasan.shanmugam@amd.com>
References: <20260716132100.3496327-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017095:EE_|IA1PR12MB8520:EE_
X-MS-Office365-Filtering-Correlation-Id: 9fe7790b-d230-47dc-4090-08dee33d27ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|376014|82310400026|1800799024|56012099006|11063799006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: cul/FSHVl+cs0EZJtXlAlNNVyBWBLrE0xJq1ywCV+H5GsCBRUKCri/ovgxR6A42qZ6zoA5WkUq2Xp0m7ZVtIVMDkb0cJ3rfelxx3Zkc86oBW1j98UoGjXN22ZJfpfw0bDF/25a3z3Yy0Gc9mFIefUz7MjERjZfaV1G+riNJJOZ5+bc4QmuHmqL7b5PKfSZqQpkFGfwtJsDC9GkeI7St+5TxeOtfUqJns195GXlzrxD3/FQXY8ftokR/uP206kMVYYz6DluLcUj//jT+PkfvJOXBuTfuhMx3Y5avCnjIy9WikD4T95S/Y2OgUVsMDFRJrd/vnrQb35UzDH5VLE4BS3KX8KyJJAI478i990BuTd1djdgIr2X0H2FhSuC2h3HllfgmTeNIjnBEbQvTS6zoMDtX8+Dz46zMIPgyTV2gNXFyJTgHffN6+mApllTOuEa1ofpqKbHzbyAJdDkPcihzfYLqcfJjU8h9/zwRS11h1zj0mOOL8iFJjb3cKJhz1UOFps1ezaZsUFgY0tIYTBAgwKNjy9G5y8MKOnGjIWHwVQR/uEgxXNr+mf8w/Jp3ve4nDB5aEvMTuegULJ4UfGyVK3IcqIIfKLb91oOex3Iq4dueKWOxdnF0ioaVNQzRPNyvHI/zXaF+xd+4DTXE35eSmk3ANQFF55hhNpF7DzyDmEqkTlboG6laLqwmC+YlpBHbSy7/RzsAySotRmT/2NBvvvA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(376014)(82310400026)(1800799024)(56012099006)(11063799006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: lBbxWGm6QrnhFmbuyOehHPBkZPabPQNAxS+ilu//HLqf6XYk34xUCBFWfjJ2dEQ2zzoL/kViz3hBVGuG0M7F9IIp2rue7DxHso1EPA5Rd+0GCvM0+lfD4ZsTqGtEVlrXPqsKOj1Z/wQIAxAqJKYx6mbjFMdiD8/lWR3oVnevefnZH9k+MukV4dKDevl01xU+s1P5+u4GShwxUx5gWDW0o7qd/TqF11fFo2+zMZMepd4sngPfk6Ruq0Q+8+HZu828u5c95klp6NbWQ7JLHJLAyM5ZKjdz+eaE3fM1FP+BEyS7ieQaGnNp9i9zZ+pQ9lfahjoxGgjRldl9PTw4BYDqBT5AGLy5b/GmiPVDCL4iVwr8wrQyUrE98ZRloyJf08Kg7E2DSLdwLNpKPhHJjdy0+kJJy8p/2MnBMU6eJ7BrOexnkxHqWd0dBvtMl1ev0Vcc
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2026 13:21:33.5960 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fe7790b-d230-47dc-4090-08dee33d27ff
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017095.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8520
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

Pending WAIT_EVENT records for queue-scoped events store queue pointers
and own queue references while queued.

Remove all WAIT_EVENT records associated with a user queue before USERQ
drops its queue reference during queue teardown. This mirrors the
EVENTFD queue cleanup path and prevents pending records from keeping
stale queue state after the queue is removed from USERQ ownership.

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 21 +++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h |  2 ++
 2 files changed, 23 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index cc30e07a4aa4..db97cd42e81a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -56,6 +56,24 @@ amdgpu_userq_eventfd_mgr(struct amdgpu_userq_mgr *userq_mgr)
 	return &fpriv->eventfd_mgr;
 }
 
+/*
+ * Get the per-file wait-event manager associated with this userq manager.
+ */
+struct amdgpu_wait_event_mgr *
+amdgpu_userq_wait_event_mgr(struct amdgpu_userq_mgr *userq_mgr)
+{
+	struct amdgpu_fpriv *fpriv;
+
+	if (WARN_ON(!userq_mgr || !userq_mgr->file))
+		return NULL;
+
+	fpriv = userq_mgr->file->driver_priv;
+	if (WARN_ON(!fpriv))
+		return NULL;
+
+	return &fpriv->wait_event_mgr;
+}
+
 u32 amdgpu_userq_get_supported_ip_mask(struct amdgpu_device *adev)
 {
 	int i;
@@ -1050,6 +1068,7 @@ int amdgpu_userq_ioctl(struct drm_device *dev, void *data,
 			return -ENOENT;
 
 		amdgpu_eventfd_remove_queue(&fpriv->eventfd_mgr, queue);
+		amdgpu_wait_event_remove_queue(&fpriv->wait_event_mgr, queue);
 
 		amdgpu_userq_put(queue);
 		break;
@@ -1436,6 +1455,8 @@ void amdgpu_userq_mgr_fini(struct amdgpu_userq_mgr *userq_mgr)
 
 		amdgpu_eventfd_remove_queue(amdgpu_userq_eventfd_mgr(userq_mgr),
 					    queue);
+		amdgpu_wait_event_remove_queue(amdgpu_userq_wait_event_mgr(userq_mgr),
+					       queue);
 
 		amdgpu_userq_put(queue);
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
index fa4df8d135eb..babee989a9d7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
@@ -203,4 +203,6 @@ int amdgpu_userq_input_cwsr_params_validate(
 	struct amdgpu_cwsr_params *cwsr_params);
 struct amdgpu_eventfd_mgr *
 amdgpu_userq_eventfd_mgr(struct amdgpu_userq_mgr *userq_mgr);
+struct amdgpu_wait_event_mgr *
+amdgpu_userq_wait_event_mgr(struct amdgpu_userq_mgr *userq_mgr);
 #endif
-- 
2.34.1

