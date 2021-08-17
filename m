Return-Path: <SRS0=1/w8=NI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 043BEC4338F
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Aug 2021 09:17:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C182460720
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Aug 2021 09:17:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C182460720
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6192B6E11A;
	Tue, 17 Aug 2021 09:17:48 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2071.outbound.protection.outlook.com [40.107.243.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 20B856E11A
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Aug 2021 09:17:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ac7TYmlAiwWia94NHjU+hC86Xzg1baFgR15qIZMulSHmuS2IPjY2A9GkmaFGktQoXaNVcGUJErT4bOUMtMbYIqJQgjjNi9VLSAKzEmIzFvVFJ1/IMGhDLJqZJStrPGTee9rcAXZZrfcwCg7x9voD3mhowarT2AupNJMMdKIXRKK/gkk//pPfm2ADklYaFVI6alvNTPrw3oJRzATjD/8VvFr0AMq4QiZCw4+JjfY9Xsk+cwQjct+9UPl605sREpEeZ4nVj0i9ujFbi/FS+lICaeLJSVrfeOffOrjxWR7LvPJ99lQeHi8HQRcE9JH2fuVnzoNx34OO0tyj71PLxpvWfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rgdq59TloBkHK3mF65v/5dqLw1ljpqFmHVkRmGSrENY=;
 b=fdIW7D1+T+iA9v0EFS1LRsw0XX6ZnWsvnX8Kdz8aUYURpFPtnV7fAO8nZH0uYgVq9KFj8lqBRqqPak8zlYRNASavrvzs8lOM5eLj2VtFMfVe73hacYAb4F7/7NutIQcKMqNqmhvt0ybMP4MeRqpGHAOc7E0bEdbITJ/DxkIWGCKjWleyMPWgd9pCqMFOFc7NDd9ktdUdr8v5XnRwbirGMiCLhmHRFMXS502R5MXPstnL/nI2I67SMv2CkyLR+nXBCVWTNtiKggL629FoQx2zey9s+37zcyxWtQSKS2RBlvVFf1TJ5fcfQtytLukerWg+KvnEvJpARlXym5EUfTqzSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rgdq59TloBkHK3mF65v/5dqLw1ljpqFmHVkRmGSrENY=;
 b=kIDJQxUdoN7sVlOzYZK/wzTcc7ON5/7pGOsi3EaUM8gFwJPh8HmQCX2a7YB0gxcuT6yXcKSqb1MGu0IRwOQnjWgQHylxSNMNrFD064CHAT5OmmXpqcDCNTMg+DbVS39CTEDyW9f2XPRKO+Rk3Y3K4ayqrTIbo0BFtCkPUXBwVUs=
Received: from BN8PR04CA0029.namprd04.prod.outlook.com (2603:10b6:408:70::42)
 by DM6PR12MB4716.namprd12.prod.outlook.com (2603:10b6:5:34::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.21; Tue, 17 Aug
 2021 09:17:45 +0000
Received: from BN8NAM11FT038.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:70:cafe::61) by BN8PR04CA0029.outlook.office365.com
 (2603:10b6:408:70::42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.16 via Frontend
 Transport; Tue, 17 Aug 2021 09:17:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT038.mail.protection.outlook.com (10.13.176.246) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4415.16 via Frontend Transport; Tue, 17 Aug 2021 09:17:44 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Tue, 17 Aug
 2021 04:17:44 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Tue, 17 Aug
 2021 02:17:44 -0700
Received: from yifan.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2242.12 via Frontend
 Transport; Tue, 17 Aug 2021 04:17:43 -0500
From: Yifan Zhang <yifan1.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, Yifan Zhang <yifan1.zhang@amd.com>
Subject: [PATCH 1/2] drm/amdkfd: export svm_range_list_lock_and_flush_work
Date: Tue, 17 Aug 2021 17:17:39 +0800
Message-ID: <20210817091740.4031348-1-yifan1.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7151e3d8-51d3-4748-08e3-08d9615fdf7b
X-MS-TrafficTypeDiagnostic: DM6PR12MB4716:
X-Microsoft-Antispam-PRVS: <DM6PR12MB47163C6A15507B88380BB93DC1FE9@DM6PR12MB4716.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1051;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uixhTdE7TtdS4xEhjqYwpbX3jnFABroHolhviYOs5dpyjx7edbZkdprnA8boCDPcuSulY63LZuEyXHpzBQNssnhEHqF1DAvdkHVKoTK4IzsN01x2KRbcAhwjmG/dGRoblb/zJs/wO8YAGpU9i0Uzs2yvrb+8So72fLjn2HT+LXBaGuMhmnyqadXUbf9bIadS4NezK559OVB1tUqJFPSi9P/UT+AGzNqJhpYxnchlCAf4FFaCKLj6OgdADQu2Xq4PjaWrjon/9o46XKQwK64yxxKDaXed9gERxo7qXJjUALjKdpUuVD/qJHiMPkn6kMIbSpRSWjP3wKR9r1fhWo3AH2xxQqHvFFA5Sx1z33riFVXzst0MLI2fFiZTJ2tx4wOvb34dmvcCAq9OFO1UE2U4v1B9M8TjEUMQ2woNqfcg0OQYlJgqQwKYUmxTNxEf6judH2uSPT4zVYRXz2Na6gjXWbmcjkSNmd3G/Sbj6Y8QI+Gayq5Mr8iLnn/LUgS5k8B4OhwRtEkDemJCGUNxx00V2+WcgFVn+dzZ4TSy8cHiXpq0vq+SrhtPYaTrGOHmKZ4uwMEAzpSg93yfnFAn3j4jWdaPm993T2ewjl8qZVXSJc2GIP5Eczk8PeqJuNs9fs50vcJWfUV1+sW6iZMW1/em3AtxjcKm9TxhCBxaSyE74PL+TD0PRsFVvpQrOMAgarZN8InAfCH2rd6PdEUbYcdJP+puvLFL0PqcfasjwtXUJt4Y+QZuHIzIB8H6RIrhietVl/TyKRZYXoWqFqKeTscjmA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(396003)(346002)(39860400002)(376002)(46966006)(36840700001)(316002)(6666004)(70206006)(70586007)(336012)(356005)(47076005)(26005)(81166007)(34020700004)(478600001)(82310400003)(54906003)(86362001)(8936002)(7696005)(4326008)(82740400003)(8676002)(186003)(1076003)(426003)(2616005)(83380400001)(36860700001)(5660300002)(6916009)(36756003)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2021 09:17:44.8375 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7151e3d8-51d3-4748-08e3-08d9615fdf7b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT038.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4716
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

export svm_range_list_lock_and_flush_work to make other kfd parts be
able to sync svm_range_list.

Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_svm.h | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index c1833acc54c7..d4a43c94bcf9 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1500,7 +1500,7 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
  * Context: Returns with mmap write lock held, pending deferred work flushed
  *
  */
-static void
+void
 svm_range_list_lock_and_flush_work(struct svm_range_list *svms,
 				   struct mm_struct *mm)
 {
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
index 3fc1fd8b4fbc..e7fc5e8998aa 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
@@ -188,6 +188,7 @@ void svm_range_prefault(struct svm_range *prange, struct mm_struct *mm,
 			void *owner);
 struct kfd_process_device *
 svm_range_get_pdd_by_adev(struct svm_range *prange, struct amdgpu_device *adev);
+void svm_range_list_lock_and_flush_work(struct svm_range_list *svms, struct mm_struct *mm);
 
 /* SVM API and HMM page migration work together, device memory type
  * is initialized to not 0 when page migration register device memory.
-- 
2.25.1

