Return-Path: <SRS0=ysjs=55=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB498C2BA19
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Apr 2020 17:12:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6AE3220692
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Apr 2020 17:12:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="1eZybhqe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AE3220692
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2110889DB7;
	Mon, 13 Apr 2020 17:12:48 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2080.outbound.protection.outlook.com [40.107.237.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D11BF89DB7
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Apr 2020 17:12:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RgDAVQRiS3od/m2Grr09ZseGHKNXoYRWRZqwq+uA+OJm01TFKjfS6S39+CSJ52qMFPOVxU1+3QG7gx2QytrLZo8yGOxzn4G31JlAyuweQJGbVpX1kuOzy/eXpqXLVLCLnSITNs/jdzb3eOu0gafKxdGXlG1Qf0ulckizP6BQ8xgJKDmqCfoKJuAjV4bVp7wQhTXwZ8+Yu78P0Ze5f9q0S9qSQyJodbPHs5pxgOcyiZIEvkriUw1Dg+q31TNXWZ7HN6G53AUyfykC/YyAk8HMr1iSjEJMD7OpljerfIn4g1bMIjlQZblj+TOPeF0PHMHo6W98R6ePXtWgGkhBM3HMfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UMCidm+1wOjjqs9bt20wpkTFTv0j7bNU48TvlSxEx+k=;
 b=Nmy+5apdc63CKp4x7J2B8GvMaYWpdWAcYWZLFz+ZkLfRUwvjEoc5VJFLdsPBKFVFoakzS6fjVggCd3YmApRFzHApvNmAnU1pJJdLItVIGshg3OC2Ch/P6ONTxTinmqvZfkrSgxU1zzH3Jzu6uhG60jb5MiZw66VcWA6Opzbh7nBt74mVbDP+Q/JRIqp0pkLOq2q6+4NgbukYc7kc6dCu2vunGqci3aYJmbvy8AmpnF6LShcZHHRQYPZLQz08VAugPs2uoUE6SZ8hz21UWVePjtwgcq44GtFK2uzfEbLyU+r4DjJ9Oz6zUcKSztQfMDVCOK+9sJemyQEckEj9m+Dk0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UMCidm+1wOjjqs9bt20wpkTFTv0j7bNU48TvlSxEx+k=;
 b=1eZybhqe+syIWE4IA+RqNQswqmyQF3eJ2yIB/LUmn38i0juEtInFQPQ+7FGoY+CVdHa+C/W322sShxqzkWxwuMaRqdoF+6nKPRv1YyODoVSrmsNQAZk+DA/J1aM+InkdpJ9Z5VYRBnM3TybSqm5HUE+FEOiBkHwykVv2aNdVbWE=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=James.Zhu@amd.com; 
Received: from DM5PR12MB2517.namprd12.prod.outlook.com (2603:10b6:4:bb::13) by
 DM5PR12MB1274.namprd12.prod.outlook.com (2603:10b6:3:78::17) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2900.26; Mon, 13 Apr 2020 17:12:45 +0000
Received: from DM5PR12MB2517.namprd12.prod.outlook.com
 ([fe80::5cda:77e2:a6d3:7135]) by DM5PR12MB2517.namprd12.prod.outlook.com
 ([fe80::5cda:77e2:a6d3:7135%5]) with mapi id 15.20.2900.028; Mon, 13 Apr 2020
 17:12:44 +0000
From: James Zhu <James.Zhu@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] amdgpu/vcn: add dummy feedback message
Date: Mon, 13 Apr 2020 13:12:35 -0400
Message-Id: <1586797955-24224-1-git-send-email-James.Zhu@amd.com>
X-Mailer: git-send-email 2.7.4
X-ClientProxiedBy: YTXPR0101CA0039.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::16) To DM5PR12MB2517.namprd12.prod.outlook.com
 (2603:10b6:4:bb::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from work_495456.amd.com (165.204.55.251) by
 YTXPR0101CA0039.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2900.15 via Frontend
 Transport; Mon, 13 Apr 2020 17:12:43 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 671d07b9-145e-4d1e-3990-08d7dfcde106
X-MS-TrafficTypeDiagnostic: DM5PR12MB1274:|DM5PR12MB1274:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB127476B703627C6DC687EDAAE4DD0@DM5PR12MB1274.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:37;
X-Forefront-PRVS: 037291602B
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2517.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(39860400002)(396003)(376002)(346002)(136003)(366004)(316002)(66476007)(8676002)(8936002)(956004)(2616005)(86362001)(5660300002)(6486002)(81156014)(66556008)(66946007)(4326008)(52116002)(6666004)(478600001)(26005)(2906002)(36756003)(7696005)(186003)(6916009)(16526019);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9kls1duq/pubdXtXC2V2U52dCUH81DbObL4uxne/8XyQBZ3vl08vVaWZz3/jLXFFvJS/QkzdZEunFf55gAQjsPyoV6bwi/4P+TXvQD8bgEwO5DB6jEM04NUzoIwjZa841wtdw10UpiB2Xx0BKd37eLHvqbVPGEdJm8nbaaRUs+2lwBCdwgxH/63czrOul28rpRXVEFXyPiOv6ECXoRtJVbjsFRjWRsgS9tSh0qxJGT/Dl8qOpzbV4Bw2yhqPbd/podtaNVzFxQZ5O+PWkliAO4jp/ZLqdouRPRIe6EkvZtwIaTdsA4AcD4dRDRY0E+03u21+5PlAnZ8qbk6IowIlhIkIj3lAxxiw3dDqCLtOa/SRh1KfidGwB6HhRpJXW6iq2OyFvCgrhBlILBMbdvyCXTpouROLXNR60IkqDKteoE29c4iWoOCmZLLtG9mCc6XS
X-MS-Exchange-AntiSpam-MessageData: w6MI9djGy55gBG//1Rmuez7Wk7XBH0iOcVX1Enip7SeteufHYrZlpxE3Qo5+vwlJyf3il0C8J339MMSYXIHcHrBglYqLHYgILNV8L1tcP/EqRoM+EgHIl9tlPdLuj6X8xpGkPKb2MZJFkJf2NFvoZg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 671d07b9-145e-4d1e-3990-08d7dfcde106
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2020 17:12:44.3968 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3sfEYcoLPnJ3Cc9hMUSyR1qB+qkQoktjJyVCmfyvkMmU3d7f6u6zBPQULfkrsHjG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1274
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
Cc: Pauline.Li@amd.com, jamesz@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Latest VCN firmware has feedback header check.

Signed-off-by: James Zhu <James.Zhu@amd.com>
---
 tests/amdgpu/decode_messages.h | 4 ++++
 tests/amdgpu/vcn_tests.c       | 1 +
 2 files changed, 5 insertions(+)

diff --git a/tests/amdgpu/decode_messages.h b/tests/amdgpu/decode_messages.h
index bd6fe4b..0dd80a2 100644
--- a/tests/amdgpu/decode_messages.h
+++ b/tests/amdgpu/decode_messages.h
@@ -845,4 +845,8 @@ static const uint8_t vcn_dec_destroy_msg[] = {
 	0x03,0x00,0x44,0x40,0x00,0x00,0x00,0x00,
 };
 
+static const uint8_t feedback_msg[] = {
+	0x2c,0x00,0x00,0x00,0x2c,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
+};
+
 #endif /* _DECODE_MESSAGES_H_ */
diff --git a/tests/amdgpu/vcn_tests.c b/tests/amdgpu/vcn_tests.c
index ad438f3..0d8df81 100644
--- a/tests/amdgpu/vcn_tests.c
+++ b/tests/amdgpu/vcn_tests.c
@@ -333,6 +333,7 @@ static void amdgpu_cs_vcn_dec_decode(void)
 			avc_decode_msg, sizeof(avc_decode_msg));
 
 	dec += 4*1024;
+	memcpy(dec, feedback_msg, sizeof(feedback_msg));
 	dec += 4*1024;
 	memcpy(dec, uvd_it_scaling_table, sizeof(uvd_it_scaling_table));
 
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
