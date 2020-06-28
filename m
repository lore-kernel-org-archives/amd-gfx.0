Return-Path: <SRS0=iA7k=AJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1204C433E0
	for <amd-gfx@archiver.kernel.org>; Sun, 28 Jun 2020 11:19:29 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7A8720B80
	for <amd-gfx@archiver.kernel.org>; Sun, 28 Jun 2020 11:19:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="qYz9Hq1e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7A8720B80
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7836789FF6;
	Sun, 28 Jun 2020 11:19:29 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770045.outbound.protection.outlook.com [40.107.77.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C465F89FF6
 for <amd-gfx@lists.freedesktop.org>; Sun, 28 Jun 2020 11:19:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JZOzOW/nret4mThWrnfXGS7biUopMy8hdz5jlxhUvVd40YLFb1f6Ce0WsLFvJ5KAN42m/w52lkIROqGzKES47LK/YFnRT2QqGqAwjmhme663byJ6Qn1+N7doCl4+KuzD4YbeVlvFakT2/Onx84ICvQuIr/aRPObTssAAt5HqEWdZLe7cQD0sKVtkL4X3PT5v7wbJZZA5zpH1qfXJj64xL35aYhM0tq+eZIfv3YBnr/EaOhcKqfZn9xh6vRG9CSunTb9vY+O9zmYQ6YU9oaY5CtIWXDkiTkVVop9VdJ2+i7S5c2XJJ4BulpdADukEcJF+9DPBHw6WrdURu+6kU4jfYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MfzHoH2tdkig9JBQfmdaJQ4AOKJwes/q9jzQ9IRRY+c=;
 b=YmeOdSZvznKDE4RHa12Sj25r0DS5rnu0KhTWg/wPXMro32mg2iRmFO8D/gSPKC9iA+PGJC5cCdfQwVh2ehrTvztE/utHiftNZFZE0PqvN444htAnmRGOgX1iQ+pSD9TFq8nombqfUgOg+gz8f5jpZh/HPMoYi/tUTlclhK3jtgCgj1YPQRzKeSAEgpTclyCXp2fjGuwh6iUaM4xpEyLsyEmTyd6KAwZkHNv2DpXDvZax0n/zH1LgoK5Xzg8riL5K7B9XKZAEq/JdZk6g59Z3MS6+F3fNNOTe/ijjAdoI2Bqf5yfiZM4fFj2kRQfGFcQVLilSXWUVGWX6iHQgeKFPzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MfzHoH2tdkig9JBQfmdaJQ4AOKJwes/q9jzQ9IRRY+c=;
 b=qYz9Hq1eo1Kh9L9p3XwvYD8UKlGKYN8BGHcbj676efSh4krb5OZ+f4Vqu9vLu+DKuRo/8V/hzMM7EXD9DpfQV+tRgthoEv6CHIcDbQQEpV51lu/HOZOS1SkACcrvOf99r6r0Fj++aGFa5cYmH/4J5Jlwnv9JF4ySambC0jEH48c=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB4153.namprd12.prod.outlook.com (2603:10b6:5:212::22) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3131.21; Sun, 28 Jun 2020 11:19:25 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f%3]) with mapi id 15.20.3131.026; Sun, 28 Jun 2020
 11:19:24 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amd/powerplay: fix compile error with ARCH=arc
Date: Sun, 28 Jun 2020 19:18:48 +0800
Message-Id: <20200628111848.1234-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.27.0
X-ClientProxiedBy: HK2PR02CA0147.apcprd02.prod.outlook.com
 (2603:1096:202:16::31) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (58.247.170.242) by
 HK2PR02CA0147.apcprd02.prod.outlook.com (2603:1096:202:16::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3131.20 via Frontend Transport; Sun, 28 Jun 2020 11:19:22 +0000
X-Mailer: git-send-email 2.27.0
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: eacceef3-8be2-4042-629d-08d81b551cb3
X-MS-TrafficTypeDiagnostic: DM6PR12MB4153:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4153C15A96CE523A88DF9E70E4910@DM6PR12MB4153.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:235;
X-Forefront-PRVS: 0448A97BF2
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EQ+t/+f8KcQPOKa1vsVVyfuns76z0m3FXrXlFVOWsZzBeSxe2sjypYYiRfo3jCWAWePFqbvRYbEvk6ZXLYWD5oJAn4Dbg2cUgfY5rnJ8OM4S+G+3O4zCp3o9mq9VjRXm36e7fEpLjyCtUSHe9Xp/POz49cgopBuGd6vUuq5CHNFHONV7cSE6pHg9KiVw1bUkKp0yAkUihc2KmYUxgWocOiCilt7uECNFinIYcI2zC5l2KOBBWlsm2aR72HNCT9K0XpRFal3Id8ARzRiSHPE2aUlistZJJwNwbXhfiSV59hP0rYmxXAQUkq6l7FU1Ozdsrcwy36yG8MBDhekeH8VJeg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(136003)(39860400002)(376002)(366004)(346002)(66946007)(956004)(186003)(6486002)(86362001)(83380400001)(1076003)(26005)(8936002)(16526019)(6916009)(66556008)(66476007)(6666004)(2906002)(36756003)(5660300002)(4326008)(8676002)(52116002)(316002)(2616005)(44832011)(478600001)(54906003)(7696005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 7OXhjNru9Jk0BWkaNWakmCh+QVzQW0Y8/hrf5jcvRpGdjuWgqC2FgvXQt5gi+qhgQ6O5H53tyyLXcA4pYAySSn+tWauwGdtwVTQU7y5K08tCOh2sQaDw7N17xxMi5Sc39enqoqMwb/bN2vKC6clSy/FDQlxmjVzI9lBmGyyILQwBP8EgzKpcpaT7NodwZ3Ssgo96D0/OCkLzMmF0xj6OJv4cNohFbvzc+TpeB2oBL2J9hcvZSMgwDlXhgTtNuIedjAf+yUxwB1FM24TMJSpv0MXYj7tzWOX9IVfe74Axef5hWrwSxpVi4oZF2l0WO7r45WgR7Zitk+Mwhb2c89azB35PO8oBtzL9naw9QK3FnHhggmNmPU3O0R4WoZS/5/h++xDQxk0CMFAgnVX1cQuo/OjeKNPZQOzJrt6snt1PMDRxsL2ysby3adBpE0uOMf/i0ZNdEv5zW1MZEvI6iegAHbSu74Rvc0MGqj0kmuHlSJ73Gk9C3p5VRITTTS+/14m7
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eacceef3-8be2-4042-629d-08d81b551cb3
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2020 11:19:24.9518 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BKrji0fyJRl6Z65BsgaALU8Yo0KAv6wXaDX4jBtzvwA31FQWJu1qA+DPdXEZ7NrX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4153
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
Cc: alexander.deucher@amd.com, Evan Quan <evan.quan@amd.com>,
 kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fix the compile error below:
drivers/gpu/drm/amd/amdgpu/../powerplay/smu_v11_0.c: In function 'smu_v11_0_init_microcode':
>> arch/arc/include/asm/bug.h:22:2: error: implicit declaration of function 'pr_warn'; did you mean 'pci_warn'? [-Werror=implicit-function-declaration]
      22 |  pr_warn("BUG: failure at %s:%d/%s()!\n", __FILE__, __LINE__, __func__); \
         |  ^~~~~~~
drivers/gpu/drm/amd/amdgpu/../powerplay/smu_v11_0.c:176:3: note: in expansion of macro 'BUG'
     176 |   BUG();

Change-Id: I4e969082c41f8a8c91f1b0d19eb853eb0a2e0c0d
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/powerplay/smu_v11_0.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
index 677f8adb920c..48e15885e9c3 100644
--- a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
@@ -173,7 +173,8 @@ int smu_v11_0_init_microcode(struct smu_context *smu)
 		chip_name = "sienna_cichlid";
 		break;
 	default:
-		BUG();
+		dev_err(adev->dev, "Unsupported ASIC type %d\n", adev->asic_type);
+		return -EINVAL;
 	}
 
 	snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_smc.bin", chip_name);
-- 
2.27.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
