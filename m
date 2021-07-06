Return-Path: <SRS0=iwxs=L6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D739C07E96
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Jul 2021 08:23:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13A6B61361
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Jul 2021 08:23:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13A6B61361
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B9DB689B68;
	Tue,  6 Jul 2021 08:23:20 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2045.outbound.protection.outlook.com [40.107.94.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1B63B89B68
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Jul 2021 08:23:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VxegDifjBS3nm7M0PkwpzG0MUuw2tQEYmVmVYaZw7O14uNxneBXasht2QJCwv/6n/ES/rcQHrScwi8YQlQoKknX+BOEgDtpWsI3rPZFo3uM1TAcFWxWBzXIl4tTDkGq94iKSpHAx55j4wJfWewlErj8WU2ibxeXNjOllaYxWDTqNcZRJzo04ioSFSkiRuvLsOZUxKQ9UoPO7z7Nx2tOciMNYNumi3jtIxIF4ktJCISB48ew2ZwFhiL9pJh7Oh3AfhLTHAaQKFrBTgOTnN4uX6WCUOluC82O3u2d15ZAufn1oLPLGtPoHltcWV2lHIdSMmC4ozYx0upux95NH61zN3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SWo6sEttAkmrGRO2uMmjfLrRryU0GXnORmXATCySmxI=;
 b=cKNOZehgTHBwr4g5J2JMSfigiA5MAJhZANM2XMMbSAMz9TPyYL5/tSBKaSilXkwtd2toyPH4k5O0hKpihhp8KE9mCxXP2qzBeaFMQM9y2MUBtpwCkAu12KiIylqnI0pQS9O5Tkz5hQR3m0zg71UJYP2+Pltf85QhkA9XcoUsH977tR+CNrFd5NevM2J5ref3hlOltp+hCy5BOWt5pZ4QBip0henT/KD+pC0v9bShBQ56EThxhzjwXMSFjtbAg8iGTs0DqQxuW7QMzMQ46xnKPVOPaD5q8rTYCzXSX1IZqlWmMYKuV0uqTZQ++oK6LdkAvT/IkdN0JnrG49kuaayguQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SWo6sEttAkmrGRO2uMmjfLrRryU0GXnORmXATCySmxI=;
 b=5tLwzhRq0uIJqIpmz9oJu+Vm8fYKLjpGYz9CdtX6cvJqAqcDgMRWSTI6NJOn5NjZ1P9Ou7nbZaz/JD/KZGkRqwy7v7BiUD3puD3uBLlDRkMjuMNSuQ2rwI7SMfGPeoIyCfDhMRlXDVhd9YQD3eRkAMboR4smF8rS4+HHT0ZHVuU=
Received: from DM5PR18CA0053.namprd18.prod.outlook.com (2603:10b6:3:22::15) by
 BN6PR12MB1265.namprd12.prod.outlook.com (2603:10b6:404:1d::11) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4287.23; Tue, 6 Jul 2021 08:23:16 +0000
Received: from DM6NAM11FT037.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:22:cafe::82) by DM5PR18CA0053.outlook.office365.com
 (2603:10b6:3:22::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.22 via Frontend
 Transport; Tue, 6 Jul 2021 08:23:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT037.mail.protection.outlook.com (10.13.172.122) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4287.22 via Frontend Transport; Tue, 6 Jul 2021 08:23:16 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Tue, 6 Jul 2021
 03:23:15 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Tue, 6 Jul 2021
 01:23:15 -0700
Received: from emiy-Z10PA-U8-Series.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2242.4
 via Frontend Transport; Tue, 6 Jul 2021 03:23:14 -0500
From: Emily Deng <Emily.Deng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Correct the irq numbers for virtual ctrc
Date: Tue, 6 Jul 2021 16:23:12 +0800
Message-ID: <20210706082312.71013-1-Emily.Deng@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b65048f1-101a-4a13-605d-08d940574ddb
X-MS-TrafficTypeDiagnostic: BN6PR12MB1265:
X-Microsoft-Antispam-PRVS: <BN6PR12MB1265D65DA15AE52AD73BC9858F1B9@BN6PR12MB1265.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1360;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yFPCOJfTXpQfoX/HRxtudvzCzN9lM7P0bCVPMhwdZSummCMqmIE+94xNDaQOQgj22h2HvmNKllzv25ZhNXxgJ0jaStz+YM5gAAmz2L79bQZrcVbaXDAIYAkgnHGqpG2WdjRzjY3PaUhO0Um7/Z6mXAA0bCYjouBFYr9CkJV2KFF2os58sBN8q1KqWYPKB/uP7AOeZLqhTwvTRBaXLPPXRqN/22U0EcGfLLkQ2A1Q96xQxF9ZVUY7gYd7k8Xat/Zds7m12EnnT+xEU36ZvZWzik5RZYUPuLDDE8m8hqDm33Ja/QrRhl2Uwm8z205VamqoKHEL4fX8aYYopZwjND9leIxLFXKkHERv1DDo/ZRzb0Y6fYWIvObMJSOPw2naAgu0BV5ZVjjK9KQ7553iKDXES6GSwdi1Uq4QUBuNuLx/mFyJxMIzcQ+K444KMaHu28bnvfU0ew253noeWW+Jm3lI9JKKnCDJ0nDMHvy4ufF36IYANVuj1C3yVBRDSYN1A73pjpYzDou0FyAht4drto9kTusr3to+rR5NKnHblTRWEmCIg3H+P5hbRzhSYrj4hP8O3zAN87uuClRq+SzrZ8a1gfXzFoxvXzppsdFzSGiFLhv7DumLRKZs8wNOykabUwwa1Yqp421DUMVDL9RBFo1A16zz2/CTnq8HjV5Fwe/FHybO6Ca11g15OA1ytTJeyACqg/C7t6MpLwkG8iuZas5hRsxvd/XpmKguO5Tsat/LGco=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(39860400002)(346002)(396003)(136003)(36840700001)(46966006)(4744005)(47076005)(6916009)(82310400003)(336012)(356005)(316002)(4326008)(86362001)(5660300002)(186003)(426003)(36860700001)(70206006)(70586007)(36756003)(8936002)(2906002)(82740400003)(7696005)(1076003)(83380400001)(2616005)(8676002)(478600001)(26005)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2021 08:23:16.1251 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b65048f1-101a-4a13-605d-08d940574ddb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT037.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1265
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
Cc: Emily Deng <Emily.Deng@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The irq number should be decided by num_crtc, and the num_crtc could change
by parameter.

Signed-off-by: Emily Deng <Emily.Deng@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/dce_virtual.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/dce_virtual.c b/drivers/gpu/drm/amd/amdgpu/dce_virtual.c
index 33324427b555..7e0d8c092c7e 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_virtual.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_virtual.c
@@ -766,7 +766,7 @@ static const struct amdgpu_irq_src_funcs dce_virtual_crtc_irq_funcs = {
 
 static void dce_virtual_set_irq_funcs(struct amdgpu_device *adev)
 {
-	adev->crtc_irq.num_types = AMDGPU_CRTC_IRQ_VBLANK6 + 1;
+	adev->crtc_irq.num_types = adev->mode_info.num_crtc;
 	adev->crtc_irq.funcs = &dce_virtual_crtc_irq_funcs;
 }
 
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
