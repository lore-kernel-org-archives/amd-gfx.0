Return-Path: <SRS0=nf5+=NA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E005C4338F
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Aug 2021 05:31:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16AC560EE4
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Aug 2021 05:31:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 16AC560EE4
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9FCAC89998;
	Mon,  9 Aug 2021 05:31:27 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2064.outbound.protection.outlook.com [40.107.244.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5344189998
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Aug 2021 05:31:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vq+qGlFE6PnsQW53ZTc6+S6qjdfxl1mwVqystZpYEi8DaA0becg1BEf6QpZrC/VMtsqMzorva4p2YYVWqIKQpTfQfA+Le6eg1NkbjBT2CXCCuCRFnf3MM1XRGJz2vF4sgGrf2HglCozyt3oYvBpW8y1i7UC506sflwW6/VeA1wpvBFweodoJsarOcr1HhqB4/r8He2NxJ6LKAbN7dmrMCWoI++1SbqrtHm8VkjaFfQFvVuzQzP/21KuP5eDX1/7SXbzATm6VLnTX8F5b4WWvn0XNGyeEgMu4juetwyiH2rKZ2a+BIktws3j4WUibCX9IzPLzB4giga7uWQ4cswH+Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XqpnPIhuNSFSyNV3LjPV/eIdH0yN5zEQ/5jyZISW/1o=;
 b=QVWMVGwIafVfsoGBtW4Atw9OFqwOl8WO9m2f8zcFPnGd+29MOdUJ+yiKM5PmcXNFKCulF74KhWtUHXctexjAa+cZikjAyPjQVDJET57y9ESm1upTGH5wAdRq7ak/CKTV8P493aQuG6+/zkx4HznI4abs5Nki5UxYLIyXhXCNNpk1J/jjciuXDBne47uQa47O0RE62zMQlfFsJ6sdxakL6EABTtu/CCe5VuVvZAwTuSZer1qbcVj/2gfLV48ahizRMAnuHfUOjclJoeqXZAGcS0tHG54+qDv8Z0nOGI83Ra3wWPInjMoqJPqU9bfvw6SV4VxRKykzSgCxdH9fj1lr/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XqpnPIhuNSFSyNV3LjPV/eIdH0yN5zEQ/5jyZISW/1o=;
 b=GZM41Sd1n9sT0IwKB0d1GkGsLoVzZkL6EizmFQA5zoAv4Y7leeA3hNBTG3bouG+g1N8Bnqv1mOqXZd5afBBcrFsueA5bdzpoum7RixxklkkksAcASBwlbzuzcNFKbOZmHUsOxyMwzRMrQcghSwB3W7Z4Kal7SB77+e/8/z1/Y3A=
Received: from DM6PR06CA0049.namprd06.prod.outlook.com (2603:10b6:5:54::26) by
 BN6PR12MB1538.namprd12.prod.outlook.com (2603:10b6:405:4::11) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4394.17; Mon, 9 Aug 2021 05:31:23 +0000
Received: from DM6NAM11FT036.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:54:cafe::43) by DM6PR06CA0049.outlook.office365.com
 (2603:10b6:5:54::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.15 via Frontend
 Transport; Mon, 9 Aug 2021 05:31:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT036.mail.protection.outlook.com (10.13.172.64) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4394.16 via Frontend Transport; Mon, 9 Aug 2021 05:31:23 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Mon, 9 Aug
 2021 00:31:22 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Sun, 8 Aug
 2021 22:31:22 -0700
Received: from z-bu18.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12 via Frontend
 Transport; Mon, 9 Aug 2021 00:31:21 -0500
From: Peng Ju Zhou <PengJu.Zhou@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Victor Zhao <Victor.Zhao@amd.com>, Peng Ju Zhou <PengJu.Zhou@amd.com>
Subject: [PATCH v2] drm/amdgpu: Extend full access wait time in guest
Date: Mon, 9 Aug 2021 13:31:12 +0800
Message-ID: <20210809053112.3652-1-PengJu.Zhou@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a39eb1a6-b91d-4e52-ba36-08d95af6ed09
X-MS-TrafficTypeDiagnostic: BN6PR12MB1538:
X-Microsoft-Antispam-PRVS: <BN6PR12MB1538A581F08B5B5C31F71ADFF8F69@BN6PR12MB1538.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:590;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Fq5uLrDY8GaxKbOk3oLFs23fRsZB+UT2oKHSW6j+buNLvbDg7ibFO/TJEPf8w9TUQVfHIo63pXz9Ipr/qiGjfLWf37tHK6TwLdpAP57TiQaCktWaEDclNmbddjw2o1Vz/tAofRl+W9T5yFvRgVYePbhhLK4f6psTYOAkAP75+pslRbT7ZNJIQ8DLj2LHxYtXNt/+y9nWyv7aIc9TlTCv2jdOTFv33klHLup+S/AxC7VQ0i0p8YSh4mUQMo+60aPX12rMdY/UQ6B/arMzRiugYeohiqdvNFPeElPhgEGgnmvpBzg6nwArWM5ZaU+9gYY5GWWobpJB4fpgibQelhil5IRHUBBryY67t3DNNKfrbupfe1LmRasCH9wsisLFcTuH1prKNh204X1JG7cacDxUjEtxTSMuJNlrJ0laYemZUGeqd1CDJFA6FvQjZNIO0TToCFxwd7VpDXdR94iR24Ugo+EpziBEbPDCceYh3og5zITgaU5ipOK1Qa3KVTUnt3EybNu5ifR0s1YDTTBkF/p0DwYJg8ga43/zvI3Vs3JJEy8ckI1yfVv0QMt6QiK9iGviH8giGsKHwtJgYmmk+jYFIox2qd8alvyUSoNpmUHZ3IaUK3JTqLBwLlAaXBmKQoiz5ZjUIY9IWc3bds4TdRJAZzxhcc21DcvoZkpnOsyfhkkYMEKdF7Pi/Zanqjz/0/IilhDsLp5MrXJMl3x8HHxzdqtv2VTYHwlNgghpjnyjNJ0aVhoPWa4tkDSRItNdp5f/U+0CERzwgKF8tN1NZNBq4g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(136003)(396003)(346002)(39860400002)(36840700001)(46966006)(81166007)(336012)(7696005)(316002)(82740400003)(83380400001)(36756003)(26005)(2906002)(34020700004)(86362001)(82310400003)(36860700001)(70586007)(8676002)(6666004)(5660300002)(47076005)(6916009)(54906003)(186003)(4326008)(2616005)(356005)(8936002)(1076003)(70206006)(426003)(478600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2021 05:31:23.3978 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a39eb1a6-b91d-4e52-ba36-08d95af6ed09
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT036.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1538
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

From: Victor Zhao <Victor.Zhao@amd.com>

- Extend wait time and add retry, currently 6s * 2times
- Change timing algorithm

Signed-off-by: Victor Zhao <Victor.Zhao@amd.com>
Signed-off-by: Peng Ju Zhou <PengJu.Zhou@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
index 9f7aac435d69..b48e68f46a5c 100644
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
@@ -96,7 +96,11 @@ static int xgpu_nv_poll_ack(struct amdgpu_device *adev)
 
 static int xgpu_nv_poll_msg(struct amdgpu_device *adev, enum idh_event event)
 {
-	int r, timeout = NV_MAILBOX_POLL_MSG_TIMEDOUT;
+	int r;
+	uint64_t timeout, now;
+
+	now = (uint64_t)ktime_to_ms(ktime_get());
+	timeout = now + NV_MAILBOX_POLL_MSG_TIMEDOUT;
 
 	do {
 		r = xgpu_nv_mailbox_rcv_msg(adev, event);
@@ -104,8 +108,8 @@ static int xgpu_nv_poll_msg(struct amdgpu_device *adev, enum idh_event event)
 			return 0;
 
 		msleep(10);
-		timeout -= 10;
-	} while (timeout > 1);
+		now = (uint64_t)ktime_to_ms(ktime_get());
+	} while (timeout > now);
 
 
 	return -ETIME;
@@ -149,9 +153,10 @@ static void xgpu_nv_mailbox_trans_msg (struct amdgpu_device *adev,
 static int xgpu_nv_send_access_requests(struct amdgpu_device *adev,
 					enum idh_request req)
 {
-	int r;
+	int r, retry = 1;
 	enum idh_event event = -1;
 
+send_request:
 	xgpu_nv_mailbox_trans_msg(adev, req, 0, 0, 0);
 
 	switch (req) {
@@ -170,6 +175,9 @@ static int xgpu_nv_send_access_requests(struct amdgpu_device *adev,
 	if (event != -1) {
 		r = xgpu_nv_poll_msg(adev, event);
 		if (r) {
+			if (retry++ < 2)
+				goto send_request;
+
 			if (req != IDH_REQ_GPU_INIT_DATA) {
 				pr_err("Doesn't get msg:%d from pf, error=%d\n", event, r);
 				return r;
-- 
2.17.1

