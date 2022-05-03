Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91B4FC433F5
	for <amd-gfx@archiver.kernel.org>; Tue,  3 May 2022 20:29:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0BC0210F3B2;
	Tue,  3 May 2022 20:29:49 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2059.outbound.protection.outlook.com [40.107.95.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9C9B110F39D
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 May 2022 20:29:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RQfw3WB8TtLYL8Q4chpMWWPWGsoX1k4NqIdJtvTXGdgF6npS5AMMMQwcaHyM4HyNwcPJ83Mgu/56liOMEJO81HUfsKhHJpOWw/aJQaDH/ocIdTIiegYzj8/QAaPy/Nt9YAI8ImteaDRrO6KCjkzFJ04qs078P37mn4RdJ/oQ7kbUBEFfnSEKP/TUV/wRjwEhQccDTtrgaGtPOXIIoxrTQzJiGYTnOMqUj0w09wmNzWyB71rV5qFvxFYbQnYfaYZoF41zY4YKShqkTbd65+b9dmaDfxnhfiQU5Qp+YIYiyMg8dDPY+gfqFFD75jF2BuDqRu2cprNTGsN+sVW/ca/wDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4ACOhzYVclTbuQ8DZnIHM1Z9H7utUzHBR0sIJQ0n5tU=;
 b=FOhyb3Di07H+rl4j6VDdX/Jg/42fwchG8uqjk68h4HmNz4BGSFlNQfzkABSde0W7+gyKblV40+RtfarRnp3IwcSWx084LcM+dXUVgO2jr1+y0JOliSd/AO5JZpFqHnWW4bsINekhy2PSffXXFAy7JStMT8q3VVBMjG+6mMWNozBA5F5LQOrPWpx9S3DIqznXvq2/L1yQc0sBHwBC0W59eRKS6bWFETG2mWINRDEnKBkk/45GNe15hJzyjOgvytXavHofRi5uuGeDGhLR+hfmJPVO8KB4SCj2gfMeTcA6FpTC32IxFg0I2pZccV2W/b/Sho/dZC0i1jobSs9peuqKQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4ACOhzYVclTbuQ8DZnIHM1Z9H7utUzHBR0sIJQ0n5tU=;
 b=TrxmeY1Za4KZDu964lU208cV29asRxdwRqsr3rYrI6PMJqf/pao0a5yCZvdZzia3QdiS7/37rKa/oQu8jc88/moxn3Q8tAgH0C45YJr3It1BWNDPOWjqhM9+ZbXmlJQyjq83qNp+2GxpMXOElbe6GDOjvi0qpK38qkkcaU8G8FE=
Received: from DM6PR02CA0147.namprd02.prod.outlook.com (2603:10b6:5:332::14)
 by MWHPR12MB1405.namprd12.prod.outlook.com (2603:10b6:300:13::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13; Tue, 3 May
 2022 20:29:40 +0000
Received: from DM6NAM11FT063.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:332:cafe::5f) by DM6PR02CA0147.outlook.office365.com
 (2603:10b6:5:332::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.24 via Frontend
 Transport; Tue, 3 May 2022 20:29:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT063.mail.protection.outlook.com (10.13.172.219) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5206.12 via Frontend Transport; Tue, 3 May 2022 20:29:39 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 3 May
 2022 15:29:36 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu/discovery: set family for GC 11.0.2
Date: Tue, 3 May 2022 16:29:11 -0400
Message-ID: <20220503202912.1211009-24-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220503202912.1211009-1-alexander.deucher@amd.com>
References: <20220503202912.1211009-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c4f0d99e-fac2-4aec-2750-08da2d43a619
X-MS-TrafficTypeDiagnostic: MWHPR12MB1405:EE_
X-Microsoft-Antispam-PRVS: <MWHPR12MB1405724EDFD84A7DFC10280DF7C09@MWHPR12MB1405.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5I9RzAu9X7zGvjR1XD20/s+fJ7c3cGLOYIdZLf55GZZY9e6Nfj1jaY1ws7dKR9hrmgQtyBUuFHATKTlYPnsaG+r7Ot19zG7W688NV1fKLUOZmH/1Cn6Hga/2GsYMHAVDhz7z8Hj32RkS5tHeM0hOVhB5lZCui3Le/8HWu+LDPPHRBZJ7nG464Be/zaOXMk7XBvH91HiUcdRM9aQfzrTLckNG7wFN1QypZf/9TxTcADlgPTWw5q4KW4YPRV/iECZixF7OWs+cdsl1SfkMk0rSc07+O32HgdhLl0+7wHcnjC2EfE0QuJ//42nBbh1XrIxvSSP7wPo0euUAQWhWKuJMVcT+qQrSHwtfCqW0QSce72PyR3rQhcLgPdvyUjdv7fdVuiwFwAJX6as6AYOaGj4HpF3WSM9diYXlInRQnjaMwNW+W6q2w9cFVHT3AIwhaBYJe/7paKzeDVAwsNeeG01fOJPqOYnF8URcaGPzrIKFgoq9KtQbzaM4PSXfzzhWYiqDrHkWxSSlD/zESImpU9jvR8bUrIJH2yIP/xtBgkLjgfIBZWaNqhGmChEN60bd9kQn1j+ExNpq5Z/i+tvLaX19UDg8fiDiLhkmX9kXEXnnrlYDsi4nmUECrEpC0+Ap1RIBXNbbdQAWC2XG8BfL/d0G6nk/srtIntVM6aSZ6w7PRcdREEXzbnGbSudX2lDcW3YDuWNowJRq3kaUIwB83MJZXw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(83380400001)(54906003)(81166007)(82310400005)(26005)(1076003)(6916009)(86362001)(7696005)(5660300002)(4744005)(2616005)(508600001)(186003)(16526019)(8936002)(356005)(8676002)(70586007)(70206006)(4326008)(336012)(426003)(36756003)(2906002)(47076005)(316002)(36860700001)(40460700003)(6666004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2022 20:29:39.8134 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c4f0d99e-fac2-4aec-2750-08da2d43a619
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT063.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1405
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Flora Cui <flora.cui@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Flora Cui <flora.cui@amd.com>

Set AMDGPU_FAMILY_GC_11_0_0.

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Flora Cui <flora.cui@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index b9e04bdafcdd..7ffbe38450cc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -2125,6 +2125,7 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
 		adev->family = AMDGPU_FAMILY_GC_10_3_7;
 		break;
 	case IP_VERSION(11, 0, 0):
+	case IP_VERSION(11, 0, 2):
 		adev->family = AMDGPU_FAMILY_GC_11_0_0;
 		break;
 	default:
-- 
2.35.1

