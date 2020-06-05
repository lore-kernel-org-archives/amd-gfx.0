Return-Path: <SRS0=/kPV=7S=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCAB8C433E0
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Jun 2020 06:08:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9BDF3207ED
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Jun 2020 06:08:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Ar1qD5DN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BDF3207ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4F97C6E842;
	Fri,  5 Jun 2020 06:08:13 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2055.outbound.protection.outlook.com [40.107.236.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EE0E46E842
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Jun 2020 06:08:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hxdioQRRFk2dh3zpO9LQqNRhipuvDF6vAo7os5Ngzfq0xKEeVirzMRbwOs+Jnhhs6Ovf4VVob16qxLA+KdN6vrdDlQyuxeRBIONO02bdWPzrUYOcyG5qgDRk8I3RUHtK0eu/IuWBHlW6b+Yc0iGUML9lHAJWoK4HijDnX/hwxKyeEwmob5WN2rWa/EQ1k3Xc6u8TqvOV+DocrU2WVgxfDJqOWBM4sC81OOhTiUEKdmBMCriYgR1nk8BI4A9Qs8CnYGRM3EU8BTz/Oe6PcaUvgFuVkR7G7Q82Hwg1qU2nOb15sk0tDbSCupzARmlaQhrjIQ9HTvey+OOT191tqqh3WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PMZYh6gAzgIvBglpmD0Z2omn0qZS+WGTzxdZX6ba54U=;
 b=EO9CYZroVBF7Kt+Lh+F7wXxqfHRnWO6IH6FxPxBktUEQVueT6mKre9wAfhk3DaZ3bPJ0zzZAy3ftSfWtHtxQbonKyKQAvXSGrU+7LOWw4673dxKwd98sPVVvc5BcVLh5cxu+sPR/kHEDhNTWQf0MauSKFD8iY0Oe8rVIh/OaoEpKhTeZh/oVjLz3NODTBEVjhJBdTYHYgW0eAaiSl7HqmjIbjH11HfFRA6xeJCsnMd18V4P0Vxwo2X4XIVlMXs1mSD9qIUIq/+gwXXXGACXs7r7wlEria54gE6RfN9i5fIYUAzlbe/BwXJNkntx5RG3ujhW02s92piGM16yOMX0VmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PMZYh6gAzgIvBglpmD0Z2omn0qZS+WGTzxdZX6ba54U=;
 b=Ar1qD5DNrzi3dfdfqAHquh53bDQqLHV7ivBpZsfcsyXaU+7fszS4zNbhjRoLUBZ+EvWop2D091RlxQX1dT15IWMhphmMNGwL8uHHq72c6ziUqU+64LRjA77I21VAsGTf4RikkOkCgtmUHovpDQ+sKvaQ8IEoIxFChQ9bCZgKqXk=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB4332.namprd12.prod.outlook.com (2603:10b6:5:21e::23) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3066.18; Fri, 5 Jun 2020 06:08:11 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f%3]) with mapi id 15.20.3045.022; Fri, 5 Jun 2020
 06:08:11 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 4/4] drm/amd/powerplay: use the same interval as PMFW on
 retrieving metrics table
Date: Fri,  5 Jun 2020 14:07:40 +0800
Message-Id: <20200605060741.5280-4-evan.quan@amd.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200605060741.5280-1-evan.quan@amd.com>
References: <20200605060741.5280-1-evan.quan@amd.com>
X-ClientProxiedBy: HK2PR04CA0046.apcprd04.prod.outlook.com
 (2603:1096:202:14::14) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (58.247.170.242) by
 HK2PR04CA0046.apcprd04.prod.outlook.com (2603:1096:202:14::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3066.18 via Frontend Transport; Fri, 5 Jun 2020 06:08:10 +0000
X-Mailer: git-send-email 2.27.0
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 8aab5183-6273-4409-c34a-08d80916d352
X-MS-TrafficTypeDiagnostic: DM6PR12MB4332:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4332FE9E63E831D28E6EB42DE4860@DM6PR12MB4332.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:565;
X-Forefront-PRVS: 0425A67DEF
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tWBqFlHyqzjDEJNi6aK9/37onnVgi336FjKZCPP5hxcUN+Zgin19L1mvmWfRSEmZL0dnMC9806YOIOa2LAV0FsjQAbusQ5H7s9QvJJIWvczHb7lesvv/98VTdK5EXuEfNNqZnsWQbBj0fwmzWV6GcWdpn2/d1QeiV773PYpyBmSk+bbxcTdcIHAtrAn7oTL91pQ298RzSqVuX5MkGGnqGQJSl3K0XZ4IM9s+62tZ5QaDIfbi8GG1jiUyKNS6Jli8yI1TStX7rvMQornsapjg7g03d8VAT5/No4G8g027KLB0MPPVnSveccsSmRAXwR4S7KLEjhWtnzrxD8yW1io/Jg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(136003)(366004)(39860400002)(346002)(376002)(1076003)(478600001)(83380400001)(6486002)(8936002)(2616005)(956004)(36756003)(4326008)(6916009)(8676002)(6666004)(186003)(2906002)(66946007)(44832011)(26005)(16526019)(86362001)(5660300002)(66476007)(7696005)(316002)(52116002)(66556008);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: /O+NIsuohyyUEhl4+KT51cXWSrAIorcItZ1mSt1gk98nY4ymks31FEd8kt1WzzRtBE4sVnJrIkenrusb/OMi52Pyoc7clirghaaBawPcCJrVl3a6kxDa449+E7luILzQoxiWlidY/lJ3gKUuBXaBzQyf7jLeTcAhFCYcY4jCzeEQM6rWGRjpqkmphgCYP3wcNB21I1FknzClKYSz6HS1BbxP69IgXVhA1qr4cPve2M5RgF6Cr2FXBWg6yqyZS4Hav+uReaQYGRtdm/7pepgQpbW+A2g7kNWCvIS85k6pV46HxXH1O+jjtZr4XOye80ZEIjRsIfONhGHtTFXIioRg4nsyeX+lqmSiUJ/UoyjNEUfo94UmjiSrcj3OUExmW8bzI3YBT8rZfqjAX4LPe5dAw04A7EaPiP3eGsHY1h6yk6nn+IEnPRbWuMSWrYFYV6oqSmnZCzwCbmezesgHJDV8rwv2xr1gJ85npvHjOq3lbOXaJXYJ1f6AZ1rXXO6HCNk/
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8aab5183-6273-4409-c34a-08d80916d352
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2020 06:08:11.7479 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jAVH1Q/61NNRrCYk3PU3Hn7u+BoSj3zv+iYwRzat4lobTfE+NMS/tkN6YNGYLs6Q
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4332
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

Current 100ms interval makes no sense. User gets outdated
data due to this.

Change-Id: Ie1d950285460443d493f1647463b68cbe4a5ec67
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/powerplay/navi10_ppt.c         | 2 +-
 drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
index 25653f5f8d16..4cfb1efbc541 100644
--- a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
@@ -571,7 +571,7 @@ static int navi10_get_smu_metrics_data(struct smu_context *smu,
 
 	mutex_lock(&smu->metrics_lock);
 	if (!smu_table->metrics_time ||
-	     time_after(jiffies, smu_table->metrics_time + msecs_to_jiffies(100))) {
+	     time_after(jiffies, smu_table->metrics_time + msecs_to_jiffies(1))) {
 		ret = smu_update_table(smu,
 				       SMU_TABLE_SMU_METRICS,
 				       0,
diff --git a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
index 13ec103575f9..78657696b427 100644
--- a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
@@ -557,7 +557,7 @@ static int sienna_cichlid_get_smu_metrics_data(struct smu_context *smu,
 
 	mutex_lock(&smu->metrics_lock);
 	if (!smu_table->metrics_time ||
-	     time_after(jiffies, smu_table->metrics_time + msecs_to_jiffies(100))) {
+	     time_after(jiffies, smu_table->metrics_time + msecs_to_jiffies(1))) {
 		ret = smu_update_table(smu,
 				       SMU_TABLE_SMU_METRICS,
 				       0,
-- 
2.27.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
