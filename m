Return-Path: <SRS0=OLwD=MI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D117C636CD
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Jul 2021 15:37:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5BDF0613F9
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Jul 2021 15:37:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BDF0613F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 733E66E9BD;
	Fri, 16 Jul 2021 15:37:07 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2046.outbound.protection.outlook.com [40.107.93.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2E96B6E9B9
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Jul 2021 15:37:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AO1T2C7MUOG4ToqCBZfH0ydJjzVFsg79zI3uxy0oSLEuMFMBbmpmoOILZYYRNZokQqnGSd0norWAdCSfCJLvTFxQxRBfv45EOjf80c6DXq5pdoHshouzaNVGqSAE9yvUQGQoGBbrfW1P7hoAtZqUfnqRxid6kZbC+zIBRVKPXxpjuiedgm0sqWXU6RqKzMjQF7wyNnplp/JWxpUQLSPetUAjscjFCRIytARg/Pgxa3V6muciLRqXyhucq4faXM58Obsvi0nrSsu2e4XQRfie/W/Js6rulyXBe6tmessN4jSFHf0jch50QSFQJ5eN82FiGtx2X6HPu0H7VXo1nbiPWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mMAgftTl0Gi0JdWfghvn3ENHP7hcDBzB946OuG2luSE=;
 b=OEg4s+ubHGm2nFNWplVdcizs53XpDztv5/z/okgYI7aoQLzbdzsN37PTPnJ3pH5s0PXncY0dizmv0p9B/sbzpc3LU6A3Re5wvjGKDFIHPBeN4lwtYP5d3H5o6iwMeT3AGJW/N3X1Er6kDEIKDQqYEifvfyBmmPojL1ljf4+4sipG2Qw7rhDSpwPPcpFSvUlEm23YQWossTfJA7j3A6nyfzoVjGo1O9YK915KgIm74pHHA6HYDGo/P/r92Fvnx9Vq8dUGg6xaLChDJTNHmgr3O9ZvwrJdoiJDxQ2A6Qj9cssMSjtIX2eGoVH3u2HfTtJEcxI+zS0IFNJJgR6ui5Bp4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mMAgftTl0Gi0JdWfghvn3ENHP7hcDBzB946OuG2luSE=;
 b=CFQVafremlEkV0rY8dfUEOpddSnR7yflHVuGHeL7nAK7c9nztCk+9e4asDxnfV5z1bXW6gtjAmFg754nz3kgreetTMr6y8eJmID0eGUqy16mZnfXkJWPhlscKrrscWK7TuU3EZAh6O+03fmERFxszm3/lnSMzwzezwkFXQ0Zvz4=
Received: from BN9PR03CA0752.namprd03.prod.outlook.com (2603:10b6:408:13a::7)
 by SN6PR12MB2656.namprd12.prod.outlook.com (2603:10b6:805:67::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21; Fri, 16 Jul
 2021 15:37:01 +0000
Received: from BN8NAM11FT025.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13a:cafe::b1) by BN9PR03CA0752.outlook.office365.com
 (2603:10b6:408:13a::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21 via Frontend
 Transport; Fri, 16 Jul 2021 15:37:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT025.mail.protection.outlook.com (10.13.177.136) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4331.21 via Frontend Transport; Fri, 16 Jul 2021 15:37:01 +0000
Received: from ozeng-develop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Fri, 16 Jul
 2021 10:37:00 -0500
From: Oak Zeng <Oak.Zeng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 4/5] drm/amdkfd: Set priv_queue to NULL after it is freed
Date: Fri, 16 Jul 2021 10:36:49 -0500
Message-ID: <1626449810-18044-5-git-send-email-Oak.Zeng@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1626449810-18044-1-git-send-email-Oak.Zeng@amd.com>
References: <1626449810-18044-1-git-send-email-Oak.Zeng@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: abb480a3-ca08-4d5f-90a5-08d9486f8e19
X-MS-TrafficTypeDiagnostic: SN6PR12MB2656:
X-Microsoft-Antispam-PRVS: <SN6PR12MB2656FF35636CBF9D90F561C780119@SN6PR12MB2656.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:923;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vS7rieZTDm6fghV02N/BAuVLw9tOYVUpEln7plmRtSdEzkcnilfpmRUMUilkrvaUBPnrd5DLPtyKqxkY5VYjhAjKq4H/aye/B27JZqXNrt84t/20jDquJinGSq6r79giQBp3Lrpd1xJNuiF8vtM9lBnBmQsODG8MfwrMLgITn+U8v0bJ1IqfdKpbtrOd+KwLgS3VHc18wj0MDSxWATxrRG8kg+QxFdDhoY2hWBAqb2HdWVFWfWxt4qhY5rf4NbbZ8whBhHsglXYFEIjJGkXeXS4JqEySthWBx9VT8JjL9DBIAD0PePI1KNgrhpgKn60Gfc+GsU8ujY7aisTEOOoi8VtuH+2pcvi2DpRXu1gKOXgx6VWbFqBRDwDDCMgnxxhgfqhfyRrIUWbxG1rK+/VDVoHBiRpSfemgSBP9/oRTnsDRmqSHJZ7zoWsUWaKSvzws/Zp6S2tKigv1qrj5egceT1D6jiIDjuF86oBnag57qJiJGqw7xrSPfK0J/sCUWmmt4iNxJQPvjfMWWaMLyPOhiudrhS7bZzhgonE29CE5eNvsH4y6KDm29NF6uNaWCbpivqGaiwk1pUoJLU267m9rRI0+0TzZgKyiqLrBHlJSErHL9zh86L6Gm7FD3dCvB1MGCIpr4wibOYgXxqdTXFAx5M9fBHFQrd7/cB2CpD46qRTLnpvBYLq+Y47gkWxE+7y2uwI+dla5BiXa32krd5lj4Rp2wEnv+gTOsv+2EdzXVb4=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(376002)(39860400002)(346002)(396003)(36840700001)(46966006)(83380400001)(478600001)(7696005)(16526019)(6916009)(186003)(81166007)(2906002)(36756003)(6666004)(70206006)(26005)(8676002)(356005)(5660300002)(47076005)(36860700001)(82740400003)(8936002)(4326008)(82310400003)(336012)(70586007)(426003)(86362001)(316002)(2616005)(4744005)(54906003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2021 15:37:01.1725 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: abb480a3-ca08-4d5f-90a5-08d9486f8e19
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT025.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2656
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
Cc: feifei.xu@amd.com, Felix.Kuehling@amd.com, leo.liu@amd.com,
 Oak Zeng <Oak.Zeng@amd.com>, hawking.zhang@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This variable will be used to determine whether packet
manager is initialized or not, in a future patch.

Signed-off-by: Oak Zeng <Oak.Zeng@amd.com>
Acked-by: Christian Konig <christian.koenig@amd.com>
Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
index d8e940f..b130cc0 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
@@ -278,6 +278,7 @@ void pm_uninit(struct packet_manager *pm, bool hanging)
 {
 	mutex_destroy(&pm->lock);
 	kernel_queue_uninit(pm->priv_queue, hanging);
+	pm->priv_queue = NULL;
 }
 
 int pm_send_set_resources(struct packet_manager *pm,
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
