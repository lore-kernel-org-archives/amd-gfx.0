Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB1D4C3DA78
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Jan 2023 20:00:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7EF0210E340;
	Tue, 17 Jan 2023 20:00:11 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2072.outbound.protection.outlook.com [40.107.243.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E77410E340
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Jan 2023 20:00:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z1skPjR+WU5iYGt9wAdZhK2dQLixn2hpeo6Q00AH2zBFA+VRO3gXMPNeo2Ikr2f0iA6VR/z7EoqPVudoPMpel0pFp7oqRsOF8NsXUv8oi/MhAkNjCU2VOFpE+mIPP0d9R0GUgXTrP3h6kXZaNAZpXHchEfvr9u2F1n5sBe4ChAzGKKy0p1d2DZYgWtL//UF+zxDDK3pFZhhLQb/+2VEqgQF+Eji8So0G0c6BGhcCpdG/xFsGSDdIhrcoCH5kPhH8v7GrD9w7a8TqfyHFNwn6J9iBcxaJiTEV0rzp6f+DIbDPqftodgFYEDT+Da+eswaioXduLgx96K8NNVb294MwsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bl6rS3q6XYnn3ko0URc8OYCZjVsLJFHJGQovg855K6k=;
 b=c9G5gDL0Pll8ObjSSTkfMHDg2YXHlnhuktmJcEFEi91iILjatXQP5EXY5nZ0WXRwHMlv7N2mbWh1bSfaNUtt7uOAJ29O6hVLIXhaT9bFHRT0Nka6rRO8lckscLw1malI6YLDIdjyxR1HB9R1YbF0pvrB9myWUfZSz5Dquhit+HzDq7U+OWqZGqGTihDmH7o+aGanjA1rnRmcvrw8ZFwQos5NwdtOjFrIG1TxghDEDWLJIDEw3474aTGz7KZaE5vG+8Xqo4jeAGrroLCpkzO83nNWLqma08z0J7U9mP6LNmA7WqKoYzT7X4vvg8OUPmVbi5P/opYs659qe7FJnZKdnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bl6rS3q6XYnn3ko0URc8OYCZjVsLJFHJGQovg855K6k=;
 b=pu5ztHaS2bdl3zkBlWfQkKlozAK/hnMwD1f1Vmy9bkOrrDA09dvziPXe+L6Ubm0V5w/XZJomlLw+24mQFmTP0HrbQnLP1isBTmVC0ZIzyE9Vku4e8zRePyHZ1H6+zEfkfdmKacuCOxon9bos0TWwMOWjzNkm//tddZ/aZd+RsT4=
Received: from MW4PR04CA0279.namprd04.prod.outlook.com (2603:10b6:303:89::14)
 by SA0PR12MB4590.namprd12.prod.outlook.com (2603:10b6:806:93::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.23; Tue, 17 Jan
 2023 20:00:05 +0000
Received: from CO1NAM11FT047.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:89:cafe::7e) by MW4PR04CA0279.outlook.office365.com
 (2603:10b6:303:89::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.19 via Frontend
 Transport; Tue, 17 Jan 2023 20:00:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT047.mail.protection.outlook.com (10.13.174.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6002.13 via Frontend Transport; Tue, 17 Jan 2023 20:00:05 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 17 Jan
 2023 14:00:03 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/4] drm/amdgpu/vcn3: fail to schedule IB for AV1 if VCN0 is
 harvested
Date: Tue, 17 Jan 2023 14:59:47 -0500
Message-ID: <20230117195949.1729608-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230117195949.1729608-1-alexander.deucher@amd.com>
References: <20230117195949.1729608-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT047:EE_|SA0PR12MB4590:EE_
X-MS-Office365-Filtering-Correlation-Id: 600ed75e-7967-4ed3-efa1-08daf8c56d41
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cEDFgx6ilaAoqcay32yTnyqy2MW8Fa02tkil4SC/wiR2ihWbbSOvft31Q+WnKdhHWutxrBIhiUQpWKlpixxIvNYH6A8n6NfCf0olDFLsCfY72vGKT6lsEDUZPvpw4DZPdWbO5+8Cz8f89GtqMUKAfSAo/3HdkJPLZk4pvcMYdTrASbajFaV+i1g/FAlq5XlPZVcYX311DZg6S0ibfFaxbluN1ZwWLUCYdHLV1xI+haae6qJM8XSHLM6BrScO6aBP0aI9SEgQlkbXbQHjKxrhSdtmvg2ZExG8HsuU6tHAUh6hjM98575kjtyBjFEQUvpgvnzNoSP7H2MHyvVVMplsrpUFmW3/Fd0GZ5Guto1s6hgeO2IqaArW5gip47JCuyTV1+bMicnAFZt2n4XmBlxqPuV4qeeY8RQD0DItyAnYwin+gFY7z480lMhbLFzdPuDU2X8aecInuevrZ3ian3NDBOmOuneRJf5mzThqoZB/NYS5nTuK/WxPWAsnO34JZJgXg1txnYphbweWH/Eed4awgi0QjefY77s3ECGEtLaqpmDTbum9tc2eqQvO5JooDtSaAjo1x4LG2uwPP1lDjDfqSXhqEP4s/VYHviWOmCllzyQdYwCpAiq0MuZIqPJUJ9YEmkB3xLhxAD9ZXPaCvH81mWm/qyLns/sIuhSDvpRHkm3K5Sd70ZKVIKiBqwA56PpOIfL8F+rT1dLSqxd8YboYxTxKRcDV5P7FZdAd/bYo06M=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(376002)(346002)(396003)(136003)(451199015)(40470700004)(36840700001)(46966006)(82310400005)(6916009)(47076005)(426003)(70586007)(70206006)(41300700001)(26005)(186003)(8676002)(16526019)(4326008)(2616005)(36756003)(86362001)(336012)(36860700001)(5660300002)(8936002)(82740400003)(1076003)(478600001)(6666004)(316002)(83380400001)(40480700001)(7696005)(4744005)(81166007)(356005)(2906002)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2023 20:00:05.0223 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 600ed75e-7967-4ed3-efa1-08daf8c56d41
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT047.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4590
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Only VCN0 supports AV1.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
index bd228512424a..66439388faee 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
@@ -1771,6 +1771,10 @@ static int vcn_v3_0_limit_sched(struct amdgpu_cs_parser *p,
 	if (atomic_read(&job->base.entity->fence_seq))
 		return -EINVAL;
 
+	/* if VCN0 is harvested, we can't support AV1 */
+	if (p->adev->vcn.harvest_config & AMDGPU_VCN_HARVEST_VCN0)
+		return -EINVAL;
+
 	scheds = p->adev->gpu_sched[AMDGPU_HW_IP_VCN_DEC]
 		[AMDGPU_RING_PRIO_DEFAULT].sched;
 	drm_sched_entity_modify_sched(job->base.entity, scheds, 1);
-- 
2.39.0

