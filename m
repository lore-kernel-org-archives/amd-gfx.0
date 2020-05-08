Return-Path: <SRS0=8BNM=6W=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 989ADC47257
	for <amd-gfx@archiver.kernel.org>; Fri,  8 May 2020 10:03:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6DDD421835
	for <amd-gfx@archiver.kernel.org>; Fri,  8 May 2020 10:03:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="OyNr/sJS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DDD421835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2AA756EACC;
	Fri,  8 May 2020 10:03:25 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2053.outbound.protection.outlook.com [40.107.237.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A2DD86EACC
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 May 2020 10:03:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kolRJQEi3KDFjdzZb68Fn2xAL+jijB8yYcMQGosVMRevC09nQngodQoidjLRo4CQ5SJjUrHF20bFvNrIW3K+dViGRdT/WfQ4MdUfqweecyEeEOZB6en/pMEAFV8FeyTrJxunKPydOtji00q5EpPoe29Hb0eGUaokgskcSkGgU6R2jNTXOK6uurX95WEG7ibuYgSV3HZN6+QNS0LAjivpPT7ma3LiDhELnVQAb8BdYKQ5jdFsDKdFzFEPzL9raskugAWYGfsvHFMMtaS7Sbvv3vXzzyVZ82mfRgnWmS06ElvH+rbGxmPfdXg9aDpyhAK7bR5JQVdw4aH3nZnrCb+Fiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=if8Qt6kC57qzwmNlxV5La8LJtHSIeQdH5djbWOYgbIQ=;
 b=AKrgMaMw+RJjXZPlbpI2WlKWjow2yTfYAzIZfNo8LgRqT5SNbG/FDRg4a1mlfSzNt4NDzirUPCtV7a8VSsn1RGUJpqLlHK9f9SxYkUn9g29FUPLa/mYtxOoJMyjnPx8/J2/zX25He0J4IKaST3pwMbV/d5DIue27hbbNJ17/5Mslnd9T+HPzYxu3YQyZ9DLTu9DvGLZ7PMTrnKsPQs3SkGd8cFdE3sKlGNnI1aqzX5UrC6CVtezGZ0Lkx1YuxJXFwjS0X7wcZ3fSB+tOk0KA6yCSCU/XQV0sqOE4m53LL+tF68sqnCmhsxeq9TcDYtlLMLci1FIQmwB7GajDJ2w+sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=if8Qt6kC57qzwmNlxV5La8LJtHSIeQdH5djbWOYgbIQ=;
 b=OyNr/sJSXgtNApb+lLx+wjZ6KXX1xEjKYDGUPE+q3ojsyP91h7UqudD/Wvnn/P7yUGgIba7iO1AwHZT+GaeLhiHu2o/AjJJ8GdjX9r3e6rv4NBWamzgBWOjPwMbUj6rEeT6g889iUorW4bT3GRq+E24FYR6JmYAsP+PQLrFw4wY=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB2729.namprd12.prod.outlook.com (2603:10b6:5:43::17) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2958.27; Fri, 8 May 2020 10:03:23 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::5c27:185c:be20:1fb6]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::5c27:185c:be20:1fb6%5]) with mapi id 15.20.2958.035; Fri, 8 May 2020
 10:03:22 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/2] drm/amd/powerplay: report correct AC/DC event based on
 ctxid
Date: Fri,  8 May 2020 18:02:53 +0800
Message-Id: <20200508100253.12839-2-evan.quan@amd.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200508100253.12839-1-evan.quan@amd.com>
References: <20200508100253.12839-1-evan.quan@amd.com>
X-ClientProxiedBy: HK2PR03CA0060.apcprd03.prod.outlook.com
 (2603:1096:202:17::30) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (58.247.170.242) by
 HK2PR03CA0060.apcprd03.prod.outlook.com (2603:1096:202:17::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3000.12 via Frontend Transport; Fri, 8 May 2020 10:03:20 +0000
X-Mailer: git-send-email 2.26.2
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 814cec54-7f19-4fde-a439-08d7f33709e6
X-MS-TrafficTypeDiagnostic: DM6PR12MB2729:|DM6PR12MB2729:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB2729ECF22A7545FD66A6C986E4A20@DM6PR12MB2729.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1923;
X-Forefront-PRVS: 039735BC4E
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ejT3ax0qH2t+sbSH4rcBdkCrKdU8h8R9SQ1gZNTNnfFjZLBneGe+Cn53EtDe4qex9Tj6ex4tyWOWVPdkF1JdElHqvfoKiOtSBICR5XSpotsjcHgHOHFjX6jeaNGOl4WM0c5uikSvDNN4E7GoKq9QCtyDAFq00I2Bw+t85mWfc6V9wQC2tJdiLORDpEqAy4p7VBY37E9DnwinkzUqS80QFBnNhwkKNYvSD7S7IT7lGloDHXjCoJBZZadI/HSvvST1LF6Lzxdx2q0f5/1Xf7zPuofIM09gnWjqbOIBs7OCL2f5OtxCdzfjd7oEC0DTlaZG1D0WEi+W1uSCcy1GbGUa1obHRoIFixukYPhWMXcYwKyefHIZFsGl+YRkDskkjJnXeBSrzgAJ26wGOkjtFyWrAMWjF6FW+PL/+k8p91MRhFqwfNIdvJQcLrnCmOf298itDKFFZOW1o52ckJjzCaojdv9FF89GtqBhzXKXANBv6JnbUDsmxfLSI7O+fUZ+Q8UU9dVt7r1/n5b+AWonTQqPBg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(39860400002)(346002)(396003)(366004)(136003)(33430700001)(8676002)(8936002)(6666004)(44832011)(478600001)(2616005)(4326008)(1076003)(956004)(6916009)(6486002)(36756003)(86362001)(2906002)(5660300002)(52116002)(26005)(33440700001)(7696005)(16526019)(66946007)(186003)(66476007)(66556008)(83290400001)(83300400001)(83320400001)(316002)(83280400001)(83310400001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: mnLBBO+88sTJbiP3i9PuhG6XkV+EPdrBVv9iqQAILzLn43vMWnKvxcNFLHXk6zHq3fwFY8CsuPXCRjDy6QpqWZLZ5K2Jzmvc1t0N9K7U0YMAG0H3qxQLyjh9cnW+AekqOZf+owYYk/vV/tLynSMl2eia9Bxfs61JCftjSUD6c+qKTAkoth8PpLUtekCJC+Sy1eD7sVCen9L5l2huWLhBLOoLin3Qs8TCGoHKOfNGsqm2buZ9sXXGmgrHTm1wAoXzq53e63syCVLQXpv53eGDkwJVZ+xgAt4HvBHzROmSxzE8LKUqhNol/YdEhY+NssXlK5aVorfpb/jJv9rwzwNyEy4qhuvJflUkjwLtJCr776dW2hMs0yuqSbSDa5VwoiNnbmwGwqRhAOw8a1rNKWE7ZH2fOCjti9cci6xSqTYAwMKtnt1sg5O257nU7j9HAxBOFI/5zfaxX2T3EdwpsBT3XCeb5jmUeZf9DWdjw9v9tDbyjCJpuwVq+Lk8sU6xOqpV
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 814cec54-7f19-4fde-a439-08d7f33709e6
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2020 10:03:22.6102 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3hIcLaHrQ/MxrVC5t0EqxVwE2+ffHwMWmOxkv7OwSF4LwoWdmplPCg4bQTHAX9Jp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2729
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

Change-Id: I7dbcb053fe9cea7c70e0a33afc2115b3745f6186
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/powerplay/smu_v11_0.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
index ab727f33b8d9..dcd3a54d18a3 100644
--- a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
@@ -1522,6 +1522,7 @@ static int smu_v11_0_irq_process(struct amdgpu_device *adev,
 {
 	uint32_t client_id = entry->client_id;
 	uint32_t src_id = entry->src_id;
+	uint32_t ctxid = entry->ctxid;
 
 	if (client_id == SOC15_IH_CLIENTID_THM) {
 		switch (src_id) {
@@ -1547,8 +1548,18 @@ static int smu_v11_0_irq_process(struct amdgpu_device *adev,
 
 		}
 	} else if (client_id == SOC15_IH_CLIENTID_MP1) {
-		if (src_id == 0xfe)
-			smu_v11_0_ack_ac_dc_interrupt(&adev->smu);
+		if (src_id == 0xfe) {
+			switch (ctxid) {
+			case 0x3:
+				dev_info(adev->dev, "Switched to AC mode!\n");
+				smu_v11_0_ack_ac_dc_interrupt(&adev->smu);
+				break;
+			case 0x4:
+				dev_info(adev->dev, "Switched to DC mode!\n");
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
