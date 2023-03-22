Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 709DCC6FD1C
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Mar 2023 09:16:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0842710E8C8;
	Wed, 22 Mar 2023 09:16:21 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20608.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::608])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0AEBD10E8C8
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Mar 2023 09:16:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SyAz5o8owJTO7hj6QzMkP4cMl/g4Y98J5JSu1/hw60qEU20oPzhxeH+Z7DIr4gQHAEaIgAIeN0pwIacqV49iFcvLyO+FKfUmnJED81Mrbybtr4FspDd5lw2wS3inPGVNVG7z71uAYOomsUTCIHyUDy3B9DL5b/uyuK3T8tKo2z9jt/HGIoFqczlPi6qGqJZif9Lf/YmYsqpV23hFCJcy8skWZBn9pJWt+V+Fw+lhrwOSXFCz5iXQwWzLXP2UhslhiSxKXGRfUQYu7sWXXmS3StRN7Ew+GRc4WAEP+fSNi+Tvj0FxY/u/TFVvDTbZAcFyYmSYU+v1RIEnvx1KZK2Luw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TwPeyXsRwXHEYtdWtfT4GLlU2E4H2e8F6pKL4yx+Ee0=;
 b=c6pzIklGStvIdZC+msiUHsTMyssEdl1AC5dceAGLPP7q57InVIldb4NjC8ibsmaDpFRMMl9fz12+MTfTNvcMi2vpHMmekvzQvXCxg0ejZLeFRvdIvVG3tHubvrn3Fpob/KIiBDKsji82F70PaxDPAti003UtHmpGDmNqc4EKPwDbNzro3Fyi7u3Fh7AqgYk6D/EFF2M5cviXTGTPAZSg1rVMZ8MgYxu4HYldcHxB4St21peO/kB9pe9OBTzcGcXcNoTLJJR60Ko9Zoc33PK/PORmXn81B1COzlbxZsLs/KagNfyu5mNRaaIGUsFKESOEuyZCeXBJ80Uxihe9B6BAqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TwPeyXsRwXHEYtdWtfT4GLlU2E4H2e8F6pKL4yx+Ee0=;
 b=a30okWnwq7KuXHIOD9g/yMqZ7kUJCz56YkCQvDv25WMSywx2Tdb7pYr+J7M0HzVYrvd3fBzl3uEoh1Q+vUXLMlKFiZqJuoYjNLRn5tZbgTnTMeiO14/NQQIKslCYACQzUONl5ZE5OGM3Z3XPwwx2SzvIJdeTyECdICHv9BoGk1o=
Received: from MW4P220CA0030.NAMP220.PROD.OUTLOOK.COM (2603:10b6:303:115::35)
 by DM6PR12MB4418.namprd12.prod.outlook.com (2603:10b6:5:28e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Wed, 22 Mar
 2023 09:16:17 +0000
Received: from CO1NAM11FT099.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:115:cafe::27) by MW4P220CA0030.outlook.office365.com
 (2603:10b6:303:115::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37 via Frontend
 Transport; Wed, 22 Mar 2023 09:16:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT099.mail.protection.outlook.com (10.13.175.171) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6222.17 via Frontend Transport; Wed, 22 Mar 2023 09:16:17 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 22 Mar
 2023 04:16:16 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 22 Mar
 2023 04:16:15 -0500
Received: from archlinux.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Wed, 22 Mar 2023 04:16:13 -0500
From: Wenyou Yang <WenYou.Yang@amd.com>
To: <alexander.deucher@amd.com>, <christian.koenig@amd.com>,
 <Xinhui.Pan@amd.com>
Subject: [Resend PATCH v1 0/3] send message to pmfw when SMT changes
Date: Wed, 22 Mar 2023 17:16:04 +0800
Message-ID: <20230322091607.1609145-1-WenYou.Yang@amd.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT099:EE_|DM6PR12MB4418:EE_
X-MS-Office365-Filtering-Correlation-Id: 4dea2307-fe25-47d4-20c7-08db2ab617aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: igFXn0/st6wjFU1ynT4fNjwtaztMNfFpSoKFn0ifaIPDVh1RDMsmkA48f1Vi1F9Uw0awlnh+cfcR4fWT7FEMkHZt96x6fYkyNJ5e2TBt/Xn615emowK4jS97VXYUT8LJ3ughEtodAhe0+AfTD6JBUbnSg0ckkWNqTQyOB99Yc8xqUZpG9qR1w71cVcKIVUochvKfsAkwKmXo27LJuWCodKJVaiXAdABiCf/j0rdIExzmiGCxyIPrPXhMuFqFlk1wCNoMzn1mfQWl+v8+hKXMySjjLWrxkwaAWOADAMqHC4Pn+F5EkqCSJXAFA+Q5jnl7WMoHPOSbPhXuOpZOd/Uc0/Q4HUque2cf9JVYSKoaFOmeC33aD9OeyJIfhHpDMUau4Ly7KG6yVm2ClR/hn0Rt/i/HpO1MW5zVuiLOH9FQ4WJPwXI+FU7fYpHWF4YMZv/nXwhjE6QS5HgtPvsBDd1gEc2ulD7LzQVYkNT1gOyq3xPvoNS6b0tSMmd5HBKHQmpBvtzPuIVefF8i3JyXcBJM0eCDR1XfC4HVP/qL2zLjWCINFYh3Tw3HMxaLmIZ11pVtzawxHlQ6GNiNgTQJqjC3pF2SHAH29BFXJW3AhIM1BFAQMSVRkC+LZ4nSU49P5KukreFRYmu9KweQl9wAKGViPUu4O+NxSXeOAVVxg0jubEViPY2dRjDbkQMqfReGignbidobSDStz8+L++UGPR+X229Gq+UQT2yKSro1K0ZhUSA=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(136003)(39860400002)(376002)(396003)(346002)(451199018)(40470700004)(46966006)(36840700001)(2616005)(7696005)(186003)(426003)(4326008)(47076005)(478600001)(83380400001)(336012)(6666004)(6636002)(316002)(70586007)(110136005)(26005)(70206006)(8676002)(54906003)(1076003)(41300700001)(36860700001)(5660300002)(4744005)(40460700003)(81166007)(15650500001)(82740400003)(2906002)(356005)(40480700001)(36756003)(82310400005)(86362001)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2023 09:16:17.0934 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4dea2307-fe25-47d4-20c7-08db2ab617aa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT099.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4418
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
Cc: weiyuan2@amd.com, ying.li@amd.com, amd-gfx@lists.freedesktop.org,
 Wenyou Yang <WenYou.Yang@amd.com>, kunliu13@amd.com, richardqi.liang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

When the CPU SMT changes on the fly, send the message to pmfw
to notify the SMT status changed.

Wenyou Yang (3):
  cpu/smt: add a notifier to notify the SMT changes
  drm/amd/pm: send the SMT-enable message to pmfw
  drm/amd/pm: vangogh: support to send SMT enable message

 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 41 +++++++++++++++++++
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  5 +++
 .../pm/swsmu/inc/pmfw_if/smu_v11_5_ppsmc.h    |  3 +-
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h  |  3 +-
 .../gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c  | 19 +++++++++
 include/linux/cpu.h                           |  5 +++
 kernel/cpu.c                                  | 11 ++++-
 7 files changed, 84 insertions(+), 3 deletions(-)

-- 
2.39.2

