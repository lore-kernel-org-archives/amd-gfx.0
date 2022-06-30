Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44DE4C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jun 2022 19:03:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DE10F12A867;
	Thu, 30 Jun 2022 19:03:45 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2057.outbound.protection.outlook.com [40.107.92.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7171212A86F
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Jun 2022 19:03:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bMub7WPpl1SkuqSUcE1AA395r9pkK+dk7M30LRhk3av2x48HV5un9HKpw27KhkkuWirN3pILb0F5QM4ePKqYBTjwcpCcqz/j0mbCRNCfNAx1DmtyxKNv5xfqU2EIFoBUSPB0GWpyEEYHAjiE7dUujwljmj0kT/nTLOssA6XdvH0sWqgWkgrtC+2ge8qdzK8/4JOiPbd9NET5HzyYYPdOWxUy187XAEf2JOKwYeJKJPIeACbw9KqaIW12Rq+oCPt2m5ffe83JTOj9RACpsBFLzXUrcqErtioKOEVDWGatTszC8LCDHQXEzfXJ3BIgW/W2t+Ee3j/PpmOJO0YmEetfTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o7pT0gC3aNSkmW7t/BNLjsOmqahwwfO3oiBda/LufMc=;
 b=DOcJMKScnowUgLUwTJiWf5ZmMtYSl1Z8BsZFrkbdyDLC6C1Os4/7vi38Ly3LhHS8OycWgjFZzJXvYFhUb6FRBc79bWkitpYnNJ2vSRrKsND0MfpOzWpmt/CuASI1Qk9bv7vUncFmiC6ndvWNxUXt4ltDvKNKh+jQIPWBeSJOmlGX24vG5QdRWWpLtY76Oi1urFHHqalWTxv2GDjZf2K6B4Q3WD5aJACNobWE8fP3b+yamolf9WF1LywkskiKDmpMvvHFkcE5oeVGmb0pmqyzMP77OyxHj9lG3BY3qiybgfo1nCSb5UefdmDeG/wDUxqcEFeCbdTDUSc9H+dlSvnEqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o7pT0gC3aNSkmW7t/BNLjsOmqahwwfO3oiBda/LufMc=;
 b=W4to/NglM/4mE3DUEp7hDMQI+ntoDeNQpbCsOSltGvETBDrcUl9VkgEoCFSvLQd3VUQrQSgRgIPHmA0im288SFihD7xsgeGRDAYB/HrHtdp3KSr3Jr0sF4VQ6FGGTdkwAQZ1nW2yQKUwuv/OrJrrh1Tt3+g5KYkM5H/zEU+8Bi0=
Received: from DS7PR03CA0230.namprd03.prod.outlook.com (2603:10b6:5:3ba::25)
 by DM5PR12MB2390.namprd12.prod.outlook.com (2603:10b6:4:b5::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.18; Thu, 30 Jun
 2022 19:03:42 +0000
Received: from DM6NAM11FT010.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3ba:cafe::ba) by DS7PR03CA0230.outlook.office365.com
 (2603:10b6:5:3ba::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14 via Frontend
 Transport; Thu, 30 Jun 2022 19:03:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT010.mail.protection.outlook.com (10.13.172.222) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5395.14 via Frontend Transport; Thu, 30 Jun 2022 19:03:42 +0000
Received: from eric-hp-elitebook-845-g7.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Thu, 30 Jun 2022 14:03:41 -0500
From: Eric Huang <jinhuieric.huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 0/5] Unified memory for CWSR save restore area
Date: Thu, 30 Jun 2022 15:03:04 -0400
Message-ID: <20220630190309.119238-1-jinhuieric.huang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c4e4ad8e-f314-495b-dfe4-08da5acb4029
X-MS-TrafficTypeDiagnostic: DM5PR12MB2390:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8C+iNEwuL8bP9e/pHxTXQbNRTd8B9ZHshJ3Lw6a4nr+2J8f9dAydiG/4o0wmyG+9hlEKDw7nmStHn7ChprI2hkM6hEJ2NazLV0lhtYVsSncBzc+8j12RTJ/5SvdKl/FCfVTaM2vL2ltQ60msnwquRk2ACeuCr5rUmprglECZ06szcSm2OKJQPtsrvr6orszWkos0IVj8mKGn58auo932rWCItlvGclsA0jG+9qBa5VHYepBcIXWFnlWJ9JILAqVPZ8Ssn+n4KpSsoDWo/BS6eH6ZD70gdQkwXlB5I+P0MXCeXzYrC75YxPvACmZPjtRo/BsclWWcWg+Hm2uP5Liw8NvVFlTTK8GU3a9EQUEwk733W30ToNf3LSkX2R2VVh5eVrsHirJ4qM0GkpZcr/H8BjNYmX3lQtyzKrHTNSavJfSVuQOh3KtzUlndHic6SZcy/1J6JtXTAwZMxEb1LGVAlwxMFc5sbEil/5Md1XagGYVe49ZQOqk28Po+IzzSO9L9Pl5TePjo+Yll8ClldJ3UsErhor8LRoG1szTpWlxS8hs7nJpf5dSgQ34W+/jsDPfzPElb0rvvefCEnqzxENXDxUZvL7RXv88waLrKvnf0cPClv2xh19wOlPc6a2MNBI7t3Y/oed6yquEoUbIPGSPynbbGiHE75oKoPC0rwIvRyEa3b8GkYkdq2/WRwzOWHGdyfN+gY65yg+2nnxu7lLOX4/DuaNRS96QB35z9gZddp6/mvzKU2JkYfDI4EdTZMgRZ/dsLlugmcM0A4dcd2M6eTlgmLVrPC7cPxWnz97ZnKBeX3F4P0XtUZVCzPNyj7DhxjQNTLJssOj30R5Ot7NV1cwgVINFwdM3kavWPPXrPWJFjAkqfJUXYrn0aR8ut5T1N
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(346002)(136003)(396003)(39860400002)(376002)(46966006)(40470700004)(36840700001)(54906003)(186003)(966005)(6916009)(1076003)(4326008)(16526019)(7696005)(36860700001)(316002)(81166007)(40480700001)(82740400003)(36756003)(356005)(4744005)(8936002)(5660300002)(47076005)(336012)(83380400001)(426003)(6666004)(86362001)(70586007)(70206006)(2906002)(41300700001)(40460700003)(8676002)(26005)(478600001)(82310400005)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2022 19:03:42.6599 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c4e4ad8e-f314-495b-dfe4-08da5acb4029
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT010.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2390
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
Cc: Eric Huang <jinhuieric.huang@amd.com>, Philip.Yang@amd.com,
 felix.kuehling@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

amdkfd changes:

Eric Huang (3):
  drm/amdkfd: add new flag for svm
  drm/amdkfd: change svm range evict
  drm/amdkfd: optimize svm range evict

 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 13 +++++++++++--
 include/uapi/linux/kfd_ioctl.h       |  2 ++
 2 files changed, 13 insertions(+), 2 deletions(-)

libhsakmt(thunk) changes:
which are based on https://github.com/RadeonOpenCompute/ROCT-Thunk-Interface

Eric Huang (2):
  libhsakmt: add new flags for svm
  libhsakmt: allocate unified memory for ctx save restore area

 include/hsakmttypes.h     |   1 +
 include/linux/kfd_ioctl.h |   2 +
 src/queues.c              | 109 +++++++++++++++++++++++++++++++++-----
 3 files changed, 98 insertions(+), 14 deletions(-)

-- 
2.25.1

