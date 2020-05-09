Return-Path: <SRS0=XXlo=6X=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4B1EC28CBC
	for <amd-gfx@archiver.kernel.org>; Sat,  9 May 2020 04:44:36 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9CA31208DB
	for <amd-gfx@archiver.kernel.org>; Sat,  9 May 2020 04:44:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="MUgy9TF1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CA31208DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 383E16E2DA;
	Sat,  9 May 2020 04:44:36 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2054.outbound.protection.outlook.com [40.107.236.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7968B6E2DA
 for <amd-gfx@lists.freedesktop.org>; Sat,  9 May 2020 04:44:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O2sSqCmqiPAEoCd7hIbz24fNxVArO0APxMje9kWqdb/JAg1trLooXgL485RdyzAOyCHfZDKjB8VuukxPLhbQc2g2cSIfV+MWGZ4Fgfl5ZWrIW5IguHl4pZGS3LRRL7v8xvA75w2KO4khqhyc+clvRzM4byyl5FSZwdgfb2ar7p/mETaeIq2fkgJ2UQXqUHAYxYtXfWo/OdYINJvMWzi/f/CpTIJjDMrZAheG6dbfvAdsIK2GZ6YR/+IPOwVWz6DUrojGTlu3KhUhHecG72zX4fyLGkTAMy1bZnk+djCvRquBuxv00b2MLARPmuq3fC/EWqrHlLujD5ZqG4s6seuJIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yv+PJXndd6OCo8yH0+AnkAtpkUlaJy+rJ2KaoKOJ/qA=;
 b=Z7P2PSQ36T58sFSzMUmJiPyTn2B8VsBuwkyVTXRaeK+ZhxBMORebPS5EyE3P05P43pg+xl3zTcuCJnBf1E/I6e91GifyVUmnjcgU01NCln+AygorP7tD14Ok0VIl2nYWe6UDfBlo5GPqoeaWvAewBulqvSOPnWwUjPYYjq3sFyv93px6cjT0845pf0ymMs9wu0kU131yh8UdN62gHQpIoCpelB7s8n54o8sRxFdcBymLyT8oD77t3wILsu2erkS+vkiPWuNCe7F9K//XqmkCv+dgSmyKpLIfC+Ex6V00ydjDR/oBvkMr54wHF0/VzviKqKq0Dhy49//fxdMQ8qga8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yv+PJXndd6OCo8yH0+AnkAtpkUlaJy+rJ2KaoKOJ/qA=;
 b=MUgy9TF1rjADK+VfkltuQDcO4I5VGT7IQ5xX4eLjZgnZrCj5oMQRkwBR8uziwstML0Z2Rl2gdR8xb+N2Ok+kQxHW5jI+2rsTV03YflNoOGulqWJR4dDGsu8ye5ydVsr7QQfI0u3pc4chrNdh87k5x4z/WYD+vU9VKTpRLrbYJYA=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB3769.namprd12.prod.outlook.com (2603:10b6:5:14a::26) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2958.30; Sat, 9 May 2020 04:44:30 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::5c27:185c:be20:1fb6]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::5c27:185c:be20:1fb6%5]) with mapi id 15.20.2958.035; Sat, 9 May 2020
 04:44:30 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amd/powerplay: report correct AC/DC event based on ctxid
 V2
Date: Sat,  9 May 2020 12:44:11 +0800
Message-Id: <20200509044411.30645-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.26.2
X-ClientProxiedBy: HKAPR04CA0017.apcprd04.prod.outlook.com
 (2603:1096:203:d0::27) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (58.247.170.242) by
 HKAPR04CA0017.apcprd04.prod.outlook.com (2603:1096:203:d0::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2979.26 via Frontend Transport; Sat, 9 May 2020 04:44:29 +0000
X-Mailer: git-send-email 2.26.2
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 54370cf0-122e-4703-ba99-08d7f3d3a961
X-MS-TrafficTypeDiagnostic: DM6PR12MB3769:|DM6PR12MB3769:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3769D9F67816D35BBC963308E4A30@DM6PR12MB3769.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-Forefront-PRVS: 03982FDC1D
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 46awCxPrT5gfM3vTRB9bnkkPHjQ/nM3aNG1v9cCrxSHGGf/61GYoyRIhHLb9jJC7F70HlqoOm5UIRcaGwXYd2FobDRdSKLgIRF0K5ObZDP5yK6KRgTSC+WAz0ot0dVOMVaMpromDvdfDZvXT7SiVzjRfPeqndprVvgh690Q4DNZ+hLDt5Un5CMPdIRXpXOAUa0hwDdgf8RjndECeLpzEmwYm1aPDZKOgH9w8vcYZSDM1A24zXChROk8nIrBK/nXQfKaIpnJue5C/ZKV2/kweo/AV0MXqyqe7WkxSMe56TQVW6vaOwEUuB006eZ0Dxf6hTns1vpUMKF034pgg978sklQauvX8DAaJWljj+peRuR04+Vhk1LOduYvWwvcGg/1akNpBHUaiHHIz/7yaFMHok+QK3sjxiVl8lgRm8Yaqx4pivZKE8e3szJdUuD9+enoZ9lwyQCVdRg0mwMN4yUnSytpRYYoZ/V6TuBC/O6v2R9UeqQ3xWLqDoy8Nrp4sQCTgRNLu0ndt7N23i4MILr0SEw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(376002)(136003)(39860400002)(396003)(366004)(33430700001)(1076003)(26005)(8936002)(86362001)(478600001)(52116002)(7696005)(16526019)(2906002)(6916009)(956004)(36756003)(186003)(2616005)(33440700001)(6666004)(66946007)(44832011)(316002)(66476007)(6486002)(8676002)(4326008)(5660300002)(66556008);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: NzFH+SFb1bs1GjuT3EDrFrP7OOY84kGFouBTwe9sx1fiJf6djlTuP4ufyuUPA5qBD7iXZfeRVkhu009yin3dtMofPgNEYIKrj1POJZX6BuwN4xLX8c3ziOXs4hTDNkEbNGRgbkt2775VWmMp2PdnT0N3hvAfKNWbhC7XSfRAaRWw2xmkqhbpuGGg+/L2H+T9KSECtYJvPlbsUyVsMpe753fPI+SqLx4YZmUxOBqVCI+CrJFeSl1LWFgf75UUY55Wwg9dir2UibvZ5k4Cx+c99/W3ft3LWsJ0CTTOLwYweZj/ctsW0FaSjoMEdvm+eoL6a+jwehJtHJeL+L796bxnL+Qh0prqgeiKtetpmpeERqunsFQfUtDmxd2dV1GlqcI+H0AGnNtnq6wxGer1NdhhUt3G2+QaOlONK6len2hiNcwc6NK9UCXu4xjvzVu/TawSeX9J5gSP9UFQcOfwVAKSFxSVYrboofaWDHMgJeTUAUTaMW+147Z5ZkHNgu222kaP
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54370cf0-122e-4703-ba99-08d7f3d3a961
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2020 04:44:30.3439 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kR8Ga6HnukBbkhTlF2Q+YSX6Hem5YiePDd80J5qaX+eWE7rf9uOiNt0VuiKVcuhi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3769
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
Cc: alexander.deucher@amd.com, Evan Quan <evan.quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

'ctxid' is used to distinguish different events raised from SMC.
0x3 and 0x4 are for AC and DC power mode.

V2: update the way to retrieve the ctxid and change the log level
    to debug

Change-Id: I7dbcb053fe9cea7c70e0a33afc2115b3745f6186
Signed-off-by: Evan Quan <evan.quan@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/powerplay/smu_v11_0.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
index ab727f33b8d9..5792b224b0c3 100644
--- a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
@@ -1522,6 +1522,11 @@ static int smu_v11_0_irq_process(struct amdgpu_device *adev,
 {
 	uint32_t client_id = entry->client_id;
 	uint32_t src_id = entry->src_id;
+	/*
+	 * ctxid is used to distinguish different
+	 * events for SMCToHost interrupt.
+	 */
+	uint32_t ctxid = entry->src_data[0];
 
 	if (client_id == SOC15_IH_CLIENTID_THM) {
 		switch (src_id) {
@@ -1547,8 +1552,18 @@ static int smu_v11_0_irq_process(struct amdgpu_device *adev,
 
 		}
 	} else if (client_id == SOC15_IH_CLIENTID_MP1) {
-		if (src_id == 0xfe)
-			smu_v11_0_ack_ac_dc_interrupt(&adev->smu);
+		if (src_id == 0xfe) {
+			switch (ctxid) {
+			case 0x3:
+				dev_dbg(adev->dev, "Switched to AC mode!\n");
+				smu_v11_0_ack_ac_dc_interrupt(&adev->smu);
+				break;
+			case 0x4:
+				dev_dbg(adev->dev, "Switched to DC mode!\n");
+				smu_v11_0_ack_ac_dc_interrupt(&adev->smu);
+				break;
+			}
+		}
 	}
 
 	return 0;
-- 
2.26.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
