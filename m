Return-Path: <SRS0=RZx8=MG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46ED0C11F69
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Jul 2021 15:25:56 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13BDD610A7
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Jul 2021 15:25:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13BDD610A7
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8DB356E40F;
	Wed, 14 Jul 2021 15:25:55 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2051.outbound.protection.outlook.com [40.107.220.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 193006E40D
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Jul 2021 15:25:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Awds6KIy1elsP7qN46rodf4fgrGhD5g3jgkTAT1WYjlxuxdGRc5BmQL5sIMRJebaH4URPJKHHAo95CzFD5h3iG//pO0CbuJdkUkMc30gtKvKOV6eONMSZHraM66RlDLSdKQQMq+zbZQSKNTbwlySR4BR88rpNd7ZGV3dtrugsGM6x/JgIfjDjAy1s2yBKVxKgQpbNVT9UCQVH5GHENNrwa0dy81lJb0f4G0dyhnepbwZEKvPdcy5crZ2cXQ4kxWaMAiQnuEi98tSzUnS7b8afb38e05DyHGwKLLKSgy/0fn2kbjv9d7M1EyYOABO8GVqnXU1yaMJyLV/GnP+49zf5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VKzNqo28b88rhAAkoXz2XWOBUISX7Rjm6gl0kgJaO/M=;
 b=R9QhIx1WcBr5dGTlExEA8mhR9FOozylYYvkHoDZe4p0AtGB6zK2f+nvTFVgxwmt0q3PIa2S5+PYUKmU8tOtZda6F+E3SGw3knvt1XOXExk8tGXqXO6/DwLPPIyQnMIkfAtpF1QHQ59j2q0LzXPdFHjcQGztsj5kDtAGP3XR8xqCi56rDaKPZ69cgLGrP642KXCSRB7h2ui3rg7T2xM/AtgYxWEfdB/Y/MA4XkKN7rf/Er3n/qSLo6pkSLfgZ6LGZs6Oy8nD4gRfWggb/cWyKNa+eQi/ZsKnX2Sps9+2o1j4k9aW0og6P8jPXUPH5PFADeH4Hpc7bL2iY5PjJ+SZh8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VKzNqo28b88rhAAkoXz2XWOBUISX7Rjm6gl0kgJaO/M=;
 b=jeeAvHlAh8tFWkmFXUp6Cyt6jGX53+qcDhesl3hhMLCyYwm+Dbbc/xB504TWD5ayyhTWymDsM3t02rujYFjXBuGy0Pan7ME17QL0J0qfOe14tgdh+tXHjZU0ya+8BSpEtrS1XsiA1a1HvS9Qri2Vv6aT28hakvD0Ss1YLrM3Yng=
Received: from DM5PR16CA0007.namprd16.prod.outlook.com (2603:10b6:3:c0::17) by
 DM6PR12MB2923.namprd12.prod.outlook.com (2603:10b6:5:180::17) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4308.23; Wed, 14 Jul 2021 15:25:52 +0000
Received: from DM6NAM11FT064.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:c0:cafe::11) by DM5PR16CA0007.outlook.office365.com
 (2603:10b6:3:c0::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21 via Frontend
 Transport; Wed, 14 Jul 2021 15:25:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT064.mail.protection.outlook.com (10.13.172.234) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4331.21 via Frontend Transport; Wed, 14 Jul 2021 15:25:50 +0000
Received: from ozeng-develop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Wed, 14 Jul
 2021 10:25:48 -0500
From: Oak Zeng <Oak.Zeng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 0/3] MISC fixes 
Date: Wed, 14 Jul 2021 10:25:40 -0500
Message-ID: <1626276343-3552-1-git-send-email-Oak.Zeng@amd.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 01a3d396-e827-4084-97fa-08d946dba96c
X-MS-TrafficTypeDiagnostic: DM6PR12MB2923:
X-Microsoft-Antispam-PRVS: <DM6PR12MB29230F75C0222C47F46FDC6F80139@DM6PR12MB2923.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1332;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RZ5nzU5UDsuMD2JwP62zMbNoKJdnFPBOamoyWNT+L/Btb6afuqD86ypEJ/A1poozBG7r7XYLI0Iw4phihQaToSG3ebFILM5gGOAXQRjMn+AAf2cmV6k4dw/G9lBtsDSmTikMfXe53wlZ2M6Go+FBeKfPa3QZLcQWqabroxwRKGT1XG7kuNYA7Lts/hqvL6AciRkKpDqVHzdRxq52LquS/7/uftX5dUTKiZN6q07B+AaeFoQmy9kzDRomQi9AkFbyDtxj0PxVZ8frA4Vcw38/6G9slfi34uDD2hVMzynKSiMelYSaSPE4SR1ED5yREhWXcdBLRPnUAkJZ3vurQNTLLHzMl6LEaiKmMqdYRM6gpU39uLvToGDCZQ/bziFC+A/CpdsPzRW4XBJ1zDCB7rAWCLyRftjp4OPjQnNiihvcmVF8GI6tt9tEqJXM+Xul7nFXMViIwaCpHQY3t7ZwkvnNO92A9u83niGEu/X9Sbdq9+yTsWAKfLe3ZGkF7gfAnfVLsdCU28DtTfJMkTfqSK7z+C7OBf6cbUqVV7dDWHSQmO3+8z6Fd2KMkgivumrGCi1cqUjrxUsDR+jLwyCFnS80ipXlQZPBnnUSxNo836H9/bOQXsE/MP7Xy127JCmFLX/rrNfsWIn5HJK5uOpvHCSxMes3YUz7F1nBmJ5ASZwtuemJAvZIihnet+EhoEdIM2+u4b2yStS8RMwCRNCSWUGUsLUkzq7R7kjtoc/vwzoQ1JU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(376002)(346002)(39860400002)(136003)(46966006)(36840700001)(4744005)(54906003)(316002)(5660300002)(47076005)(478600001)(4326008)(2906002)(8676002)(36756003)(81166007)(36860700001)(7696005)(186003)(356005)(70586007)(336012)(82740400003)(2616005)(4743002)(26005)(6666004)(426003)(8936002)(82310400003)(16526019)(70206006)(86362001)(6916009)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2021 15:25:50.1955 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 01a3d396-e827-4084-97fa-08d946dba96c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT064.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2923
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

Oak Zeng (3):
  drm/amdkfd: Disallow debugfs to hang hws when GPU is resetting
  drm/amdgpu: Fix a printing message
  drm/amdgpu: Change a few function names

 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 16 ++++++++--------
 drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c   |  2 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c   |  2 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c   |  2 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c   |  2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_device.c |  5 +++++
 6 files changed, 17 insertions(+), 12 deletions(-)

-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
