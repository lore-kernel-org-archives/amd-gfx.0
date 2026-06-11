Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D75ACD98CE
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Jun 2026 14:34:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B164F10E042;
	Thu, 11 Jun 2026 14:34:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rcMrlFWP";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010009.outbound.protection.outlook.com [52.101.85.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8F0B810E042
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Jun 2026 14:34:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=htB8zVfTLgc4FCbwTVMZOiRbV0r9DgFmmKiqBUWuHQWQNbGpKiSYu8CHYLirH9ZSCGNP8H4lP1VGocswbiiGNbIDKG7T6f+pN3kxOe1Ho9Ztz2b0f4erlD8cFzfwl0sTprwTo6YMfe/5u5SfhTOBl/MV3hllBslCuaEOkyx75qCBzgByrF40lPYgESqlKQoIEkop2fN4Z7UrNO8G1X1jSHXQu2CDoaTKwlDi9s+7cFH/4uIxZJn69lcFexZUp+kabUzralU+fjTD+5E5jC9cBI6CHAJHfJXlvuAHTKg5YNFkTV/6q1ngDTzRaUzy6DJ0LrFMgk3p8WrV3DXg32KZFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B+S7+u5lRD95Hu+/vWAPD8qiMAdG3n4Zf9DGheaPh0U=;
 b=MjR0KTDqUbshOPV8EF55p0xCuMKytBKs1HU3PFYpwYd0TRBmlt3T0m8dK/GRNtCtKuY6CA5MsDzEnSaYrXSC5aPnDO/rQIaaDKI1AuEq2douG5Nd9rTR44p8exmLEA7kk/pXiW1dA9rBFqBWBg1/HJ1qHJDQAPK9pqvKzn0lBmg9kcmiNi0IXe/h7pEgYbZ0MwWKSp2SEV9cgHuHd3hN/fVrQsWXpgar/hZHEUMvmX7CbTHB12zp4b9XLSLYsDHVqvL1xiDCHxVzto0Le1rmtVOd+ypq0NMXz75jMga7IZ+XZoIxCa12rr6EGKtKx4ofud/f3aS9zJ1acJtLAdQPQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B+S7+u5lRD95Hu+/vWAPD8qiMAdG3n4Zf9DGheaPh0U=;
 b=rcMrlFWPWPbe3KzvBf9w3bSGE46T8OGZMAj6dzmF0I7I0eOIDFpiPdr+QHP7Ph2DaWNf91GTvbHR22tihD9PKr4rxlH37NqQt5HkFhn/plwQKpxAzIR7jvL+NAkEXlK4QVuR67tFwn4vjkkwHFtLvoy7QyamSXXpbdVSIp+QZIc=
Received: from BY3PR04CA0030.namprd04.prod.outlook.com (2603:10b6:a03:217::35)
 by LV3PR12MB9331.namprd12.prod.outlook.com (2603:10b6:408:219::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.14; Thu, 11 Jun
 2026 14:34:09 +0000
Received: from SJ5PEPF000001EF.namprd05.prod.outlook.com
 (2603:10b6:a03:217:cafe::83) by BY3PR04CA0030.outlook.office365.com
 (2603:10b6:a03:217::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.14 via Frontend Transport; Thu,
 11 Jun 2026 14:34:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001EF.mail.protection.outlook.com (10.167.242.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Thu, 11 Jun 2026 14:34:08 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41; Thu, 11 Jun 2026 09:33:42 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH v12 0/5] drm/amdgpu: Render-node EVENTFD subscriptions (toward
 KFD/KGD event unification)
Date: Thu, 11 Jun 2026 20:03:21 +0530
Message-ID: <20260611143326.2870571-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EF:EE_|LV3PR12MB9331:EE_
X-MS-Office365-Filtering-Correlation-Id: 519bb5f9-480b-4241-0bfa-08dec7c67f7d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|82310400026|36860700016|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: fCyQCqLqEwBwv4TfFyEET+Cdrv0wFTKYxixIKGVf63TdlJrrWtza/6JjIng55AeplZ6S8TeSnFH1lvHrHnxZFQT+I1zql/9TiM0E6XmfPnJEjbyxDe+Yj3c7uYWPLqAm62Ee+eMA0nYIkyjFRTHrd7h5KKVKvuuwND0uOHUa8R6mRVJW78NfqmVDf9byWRAz+opOjx9RpcpTOOB/hCb/SIh0Pmp6PpWlROQleUvQj36ZxLdKsEppwBoQ9zdEeJgjbjZI9rO8E+yuXHJ+kK/AUXN8qLTNRnWP0cUGHWz6g6jty8UoETdXMDn6MDXulF0GBpy61uvibiNKkZGxPPSmV8zmCTjiVKKlgBR2zsHXgzTtM/7jCKV4qWviNuqGjbCYiZCNyecUpFNEn6b8+QmjDApCudbFjOB+3h+dKvDMj6HTapGWhkCaIOw6GzkhXrdXG5MgEFPgRhYqGqnl6Dvs0Fyu/VIbKSsRJkjdFiK3rW4kP+84tRywunIppTLZSbEM/0STY0r0K0XO+OnBgMoFdcZuY7kKGkZyHNDgm8xE1LLsTqQACwpV+YV9iLUumFNQ9FTHyEP8SjcNxMzaYGTDlksooxfzuzLByXuNAdLEH3C0lpLEBPSTgKBiMjYmZvZKYJhGkT+e5inA1vNIyjKfsSOZXqX03zGfwi2bh88a1YG35y65pkjU7nXF233ZT9WOYFz3KVQD/FoweDbYABxbHskRi34X7dRRDMIVG6thKY4=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(82310400026)(36860700016)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: MMUghDa93k8EsR8hTa/vYlId6++HQjH7BsEL7aHC1YHnnQAqvVjImMxlOt4npFrtsl0hhtJwpwhAA2vWBNEgtPj0Gb4nNQa6EoZe7HXgCQPeXFHYlqZ52R3iWXdsrFo6dlDvxJTS285lWxQdlRduBXVzlPFvVht8G3GE5QMZvJxce0IwJK6667YYgZFq6q1vOGDs3++NG+5+MHEhFHWTr3aobxnn/imYZKK3I8coBvtLz61KKxlga8iZ7p7DzwGijx/TCkcC29kxL7XQUatn7FJTxrRqr8ZT9jGvMzO3g+uXKx7wpf3LodXYzdvrIDd13drdu9Uyh5RXJxg1Yl3e+WCAfa1h7EdMyLuBjuxg/kYglfY3t1da+ZuKKz7IkjT/ChtUYrnZjfnr66x25gDPtNT2/vwU40O2qgjajPEjYHrvkFFmkJ/kFRgAZ3jOZqMG
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 14:34:08.8162 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 519bb5f9-480b-4241-0bfa-08dec7c67f7d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001EF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9331
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

Changes in v12:
- Remove explicit NULL checks before amdgpu_userq_put() and rely on
  amdgpu_userq_put() to handle NULL queue pointers.

Srinivasan Shanmugam (5):
  drm/amdgpu: Add render-node EVENTFD manager core
  drm/amdgpu: Embed eventfd manager in amdgpu_fpriv
  drm/amdgpu: Add helper to access the fpriv eventfd manager
  drm/amdgpu/uapi: Define kernel event types for EVENTFD subscriptions
  drm/amdgpu: Use queue references for queue-aware EVENTFD subscriptions

 drivers/gpu/drm/amd/amdgpu/Makefile           |   3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |   8 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_eventfd.c   | 429 ++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_eventfd.h   |  73 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c       |  99 ++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c     |  25 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h     |   5 +-
 .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   |   1 +
 .../drm/amd/amdgpu/amdgpu_userq_internal.h    |  37 ++
 include/uapi/drm/amdgpu_drm.h                 |  43 ++
 11 files changed, 720 insertions(+), 4 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_eventfd.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_eventfd.h
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_userq_internal.h


base-commit: d27c2dad1c9cbe1032a149db375b79f6dd1de03b
-- 
2.34.1

