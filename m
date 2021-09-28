Return-Path: <SRS0=UpsA=OS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26739C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Sep 2021 16:43:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E673061262
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Sep 2021 16:43:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E673061262
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 527D16E101;
	Tue, 28 Sep 2021 16:43:16 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2047.outbound.protection.outlook.com [40.107.223.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E394D6E101
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Sep 2021 16:43:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RHqAXqbLfdD465/u2kYkoqoZwjVwW2vTzc02QYovP6K596t8UfZeNdow3mhRsfHsMJlyXFL7l/4cwHJuRDKlFY+U5v9j71W53GYiaQXOHx0YmaE7RqGeUnY3yRnqzcBUXjS2GK4o052JNynYstnKhobMduV3U4veJ0GywRnT202Mwa/uvGpe2nsCfm47I+MOnmBXEeKzcB105rWdhCU+143eXxoc5uRnaACTXH4uF1SvEV5ovh4NC9Y5cUA06FOl0SAIFwQaIKvz7TIHxXxicsOaZ9YdfhG4QAqar8/zZM9O3IFoBAnONzgeGHnFOqUvrj1sQQfLlKYVWXm5zk9Hpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=zNAlk7cVBrEFFa9OhWQ5QLLGK0OXtZVOYUewG4USBHs=;
 b=oGgvwVVywXPBevlhC0qN5lADlQmJTAAixgW08+SiwyB8BlYXSU1l0Hka5XkDOKJSycjUvPVlRZwBRPe8ic2Dz2jk1jj/geEOIpKm1VUZdvv1TTXTYXRP2ivFsVk4QGgkAxLLoBi0z+IddEQG6Cr4jeaci4B0NQg29rfxYi4cuf1wcn/LJpRM9wqQjT2zFjhqvdq/R8bofAFO64+FMwwj94pjtmRfA+d3XEsliX0TiKteyARCUkFB0zS5npQQBh6eWeh9XIYHXJfGQTrb51R4N8UbHpHIiZNDz4USA1iyd4nCZ5KoQruBTVazoaR54fqMUN+NJp+ks0rUY7dyouUhtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zNAlk7cVBrEFFa9OhWQ5QLLGK0OXtZVOYUewG4USBHs=;
 b=3CmJm/vb7xnAgmXcIHdEs8YtqSeuJ5QFGabfpPorVeTkdaK8NGhy+pIhtSt85x1xl8D3UpeSv52oxVR5/Cxdn+tLfY126y3RMsrjluGilovEYUnYaY1v55Y0aFl7dXdLUsfYcKNaPLHMt+doXvc4II4Wl8bgrGLiei5jqTVuGCs=
Received: from DM5PR22CA0024.namprd22.prod.outlook.com (2603:10b6:3:101::34)
 by CH2PR12MB4838.namprd12.prod.outlook.com (2603:10b6:610:1::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.14; Tue, 28 Sep
 2021 16:43:12 +0000
Received: from DM6NAM11FT039.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:101:cafe::ec) by DM5PR22CA0024.outlook.office365.com
 (2603:10b6:3:101::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.13 via Frontend
 Transport; Tue, 28 Sep 2021 16:43:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT039.mail.protection.outlook.com (10.13.172.83) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4544.13 via Frontend Transport; Tue, 28 Sep 2021 16:43:12 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Tue, 28 Sep
 2021 11:43:08 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Subject: [PATCH 03/64] drm/amdgpu: store HW IP versions in the driver structure
Date: Tue, 28 Sep 2021 12:41:36 -0400
Message-ID: <20210928164237.833132-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210928164237.833132-1-alexander.deucher@amd.com>
References: <20210928164237.833132-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b4295a48-e085-46c7-1121-08d9829f0f9c
X-MS-TrafficTypeDiagnostic: CH2PR12MB4838:
X-Microsoft-Antispam-PRVS: <CH2PR12MB4838EA3BB6A79E6037A5F19BF7A89@CH2PR12MB4838.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:854;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XMJKlSqT0+Wb9rRKrCgxQvjW8iNQ6ZsgjqG4/+FKxhBkq0Q+j/sevohn5S8wN2mYHa//CXTOFh2zLz1U+0FkRMZA00GURiRQ1Jzs6qAE+Iox/WzozdgcZNCa9Rbi9kJ9vypVda987gWxoTzA1nlIDsCjx01vhcd9ZgILNdoSdaWfQ/iIhHkZGig+WavSTuYpruZs1/DJilmg+QwpSUK572tHwBEmRE6YkhJyVugzqIj3k/p0MB3kS+hiU8EGUKjX8QOEXAlW9dVQ7eo8wNIS8Dgll+N92NUTQySZsR+V6wFQ1lFLihwzpQo1cvUmM75U93DA+ZTbkZM4U3MOrgpXg1kXYh1RnhctFppYbdKo0EUIbASzXznlAICt9bgbixAFF494WlFEzD1LVQdr1pO4yeXD5shFqiEnjjLoe9ba5VMxkPcKt34mTBOiZlBiwaLvMn1PsZZjLdqp1y19nd0MAWQXxC7je1QpEYhr7pIZ7pzasFIO+qIbWc/1cFriG0bITPDxzsoE6vwjXzuuyk8Wt4RlTIP6OXQ0xunY/u4an91xqh8Jvt96wjloLjnMkwSfD5YqG+/n3p8iVHOiojv8cfHFU8JQ5epMW8JhKOEEGIuRg57ZRg/6jwBAHRIGxZuJPtXdiXsrv1+GHrF5aVmexIcCgxNvDy8UtuRH8rTMN84SuN4ZdNftREpBzSC0mJdtfTWxT9615PHFYyPbpGw78o+z5J2gg91FaElijMi0/9k=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(426003)(336012)(356005)(36756003)(70206006)(66574015)(83380400001)(8676002)(6666004)(8936002)(47076005)(2616005)(4326008)(7696005)(508600001)(36860700001)(70586007)(6916009)(1076003)(186003)(26005)(54906003)(82310400003)(316002)(16526019)(2906002)(5660300002)(81166007)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2021 16:43:12.2143 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b4295a48-e085-46c7-1121-08d9829f0f9c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT039.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4838
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

So we can check the IP versions directly rather than using
asic type.

Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           | 4 ++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 1 -
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index cdb963b9bea0..61ef0d81a957 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -760,6 +760,9 @@ enum amd_hw_ip_block_type {
 
 #define HWIP_MAX_INSTANCE	10
 
+#define HW_ID_MAX		300
+#define IP_VERSION(mj, mn, rv) (((mj) << 16) | ((mn) << 8) | (rv))
+
 struct amd_powerplay {
 	void *pp_handle;
 	const struct amd_pm_funcs *pp_funcs;
@@ -1090,6 +1093,7 @@ struct amdgpu_device {
 	struct pci_saved_state          *pci_state;
 
 	struct amdgpu_reset_control     *reset_cntl;
+	uint32_t                        ip_versions[HW_ID_MAX];
 };
 
 static inline struct amdgpu_device *drm_to_adev(struct drm_device *ddev)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index cbe817a5e7bc..d195b814712d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -30,7 +30,6 @@
 #define mmMM_INDEX		0x0
 #define mmMM_INDEX_HI		0x6
 #define mmMM_DATA		0x1
-#define HW_ID_MAX		300
 
 static const char *hw_id_names[HW_ID_MAX] = {
 	[MP1_HWID]		= "MP1",
-- 
2.31.1

