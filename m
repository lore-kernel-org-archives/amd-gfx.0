Return-Path: <SRS0=jeuu=7X=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBB40C433E0
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Jun 2020 16:36:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 52D53206F4
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Jun 2020 16:36:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="XDiMJl25"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52D53206F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0F07789617;
	Wed, 10 Jun 2020 16:36:24 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2087.outbound.protection.outlook.com [40.107.237.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 995AB89617
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Jun 2020 16:36:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PZ4RwVDf9zSA9oJcGD06a3QVcXEAYESOxsHOM0y+A7mjSb82VdkITEAtBWr1y0+wXwmPyIDjAEcq4zyI4/05iUnoOu9il556XhxQYJaapUV7V5xMJXqwr4IB9jEGal47aiXWqN5Wx4Z4DVrzOQas+T3AaO15tjWKQlaOdoIKwdVldhuHpMx9zsHO+fn9TsfGX2A081H9h38J1VI1Y9N8TPAvzjNjtzrvRnUAawYa3U7YVUTCRTj7d+DgYsWMNzDUyLvqWx+hwJNONkOw7oVfKt9iOkvujTgjq3Xlw/sqOJUYFfZ+6o5FBtSOHufI0bAgxJhx84tKSSu4heMH53JW7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e+ll2WTs1BnQdRyV/1WOTB6yFk1AzTR5DjwoKtBsyK4=;
 b=lElPNWWcuOdrMMiLdttOeMZnCywFueidEoBYL6pVHWu74WXH7K0BWn9HhEYSzb2m+LejtwAdQf6i8qFzS3BlcagPBdrwB5MJVFT5OEGKPzF9a4AaBlUmGeaSjdi/FwFCuzIaeDIA/gAMI6V7zDTjFoIySeyKygfIVxA1e6NPqo3WNOSbEJJ+3aaMPOOAq0o+gXNZSwzmy0qcC+mCU1cZt7CqLrA5Gea56RIxy32pLn5AG4uCAcoaCg5AowUit8N9Qyhz5LZqdrqxLp6lqhjzu3nZzWgIJcRZmpJLSZITQQ3gRJFFPgAec3Wgm3A/9mAoKZRLI9rc+qi1wY9YGBOs9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e+ll2WTs1BnQdRyV/1WOTB6yFk1AzTR5DjwoKtBsyK4=;
 b=XDiMJl257RxvAVi+eJzKlvKe1I065Gn2mc6saV8dP8d9cBLNFr+aPSNKzesmbNuYX3v0LFUL3hHletdL8eGH+cJyAcUW2vqMsbALvyxIp1dEdn5Nn7bsRVg/MMOGACrwcm9STMIVnoPZp5qcORSYa7eXbtLxp+98mWyUKd3Yxsw=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2517.namprd12.prod.outlook.com (2603:10b6:4:bb::13) by
 DM5PR12MB2405.namprd12.prod.outlook.com (2603:10b6:4:b2::20) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3066.23; Wed, 10 Jun 2020 16:36:11 +0000
Received: from DM5PR12MB2517.namprd12.prod.outlook.com
 ([fe80::1c50:44e9:a4a2:2828]) by DM5PR12MB2517.namprd12.prod.outlook.com
 ([fe80::1c50:44e9:a4a2:2828%6]) with mapi id 15.20.3088.018; Wed, 10 Jun 2020
 16:36:11 +0000
From: James Zhu <James.Zhu@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu/jpeg: fix race condition issue for jpeg start
Date: Wed, 10 Jun 2020 12:36:01 -0400
Message-Id: <1591806961-11227-1-git-send-email-James.Zhu@amd.com>
X-Mailer: git-send-email 2.7.4
X-ClientProxiedBy: YTBPR01CA0015.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::28) To DM5PR12MB2517.namprd12.prod.outlook.com
 (2603:10b6:4:bb::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from work_495456.amd.com (165.204.55.251) by
 YTBPR01CA0015.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:14::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.3088.18 via Frontend Transport; Wed, 10 Jun 2020 16:36:11 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b1a36857-a799-4c31-f1bf-08d80d5c6296
X-MS-TrafficTypeDiagnostic: DM5PR12MB2405:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB2405097FD78E6600B2D42F17E4830@DM5PR12MB2405.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:16;
X-Forefront-PRVS: 0430FA5CB7
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kJWCvWW1Lpuw1bCMOtUF+nmtsPZcBgyIJbX0r58pMvzOZji3R4UULsf+Hs2o9lf6yO1XqOkR8wD3dhBeUUPTLL6CZjqdw9wmVzt2ow/vccGP5L5K3Whcid5sYoOc3OOmQHYPVmjqGQpJXmlq0+hC0ZGLHX7EvC91W/HQue/uqeZWsbmUAevcNykHZWa0hfu6+l/+woSPYqAQRvmM6PAJ+IsqviWqcVqnADRi1+ZcxHMCDR3oeNr57+6JSU7s32F48cKYV+QubtkoTkcT4j8pBzZEkwWNL5h+Un7DXiwnzuBqV+2xW/PSE4ACQoAYVodlxHcTK10YzOy33qz4ioAzFA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2517.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(39860400002)(346002)(376002)(396003)(366004)(66946007)(83380400001)(7696005)(6666004)(2616005)(956004)(186003)(8936002)(26005)(16526019)(36756003)(86362001)(52116002)(5660300002)(316002)(66476007)(6486002)(2906002)(4326008)(8676002)(66556008)(478600001)(6916009);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: na90dtJrVG5mY4cHTuC7Yuqymx+U7Fjh2hpAHqgLqQRQNLaG+JeBEL2dttMNd6mG/oE0qdZ6coO1kMI8v6Ex1/coAsvoWr3ZQvqEAO9JeZGPBAjxhyuV/WgMne02IsnH+IZIBO7K9PCikHbWAdPlLlI1gIIgTToWdBLPJOYCVKPX37l38Vpzvpm+Z0kC+w867H/1UNr3ESaOPwhyK9Z3lyFh5345Gaz49va1EAUMCDDoMfgWoSjE1fCcZ6cYgve/Yvn+GsfKrKW/j2O/4azpfygotfgMqpUo1LVpflZe+KyXwkgtk635x8QlUic7y1TxVGlac55ZqmJNhu12Pj2Zz2CnBVkqhhTJFhtiVys2KjKce/YMounzU8W1jeciuHOLQaVUkIZia+bg7BugfvOeUD7cSnBO/t76jmyudj7mA7YV835z7c6SQM1/RDQAZLPh7u5fMp1/CqyLAb/yY94st3krcF4+JtsWVabtbvo73ZxaeObMLQZgaq+AUh6A2sjX
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1a36857-a799-4c31-f1bf-08d80d5c6296
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2020 16:36:11.7535 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ONiFp/n5F74h/cr2fNTSJXPZTPYf6tBhraCF/Bdhyt/j99xx5SJMd4kWDybOhPMn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2405
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
Cc: jamesz@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fix race condition issue when multiple jpeg starts are called.

Signed-off-by: James Zhu <James.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c | 16 ++++++++++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h |  2 ++
 2 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
index d31d65e..8996cb4e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
@@ -37,6 +37,8 @@ static void amdgpu_jpeg_idle_work_handler(struct work_struct *work);
 int amdgpu_jpeg_sw_init(struct amdgpu_device *adev)
 {
 	INIT_DELAYED_WORK(&adev->jpeg.idle_work, amdgpu_jpeg_idle_work_handler);
+	mutex_init(&adev->jpeg.jpeg_pg_lock);
+	atomic_set(&adev->jpeg.total_submission_cnt, 0);
 
 	return 0;
 }
@@ -54,6 +56,8 @@ int amdgpu_jpeg_sw_fini(struct amdgpu_device *adev)
 		amdgpu_ring_fini(&adev->jpeg.inst[i].ring_dec);
 	}
 
+	mutex_destroy(&adev->jpeg.jpeg_pg_lock);
+
 	return 0;
 }
 
@@ -83,7 +87,7 @@ static void amdgpu_jpeg_idle_work_handler(struct work_struct *work)
 		fences += amdgpu_fence_count_emitted(&adev->jpeg.inst[i].ring_dec);
 	}
 
-	if (fences == 0)
+	if (!fences && !atomic_read(&adev->jpeg.total_submission_cnt))
 		amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_JPEG,
 						       AMD_PG_STATE_GATE);
 	else
@@ -93,15 +97,19 @@ static void amdgpu_jpeg_idle_work_handler(struct work_struct *work)
 void amdgpu_jpeg_ring_begin_use(struct amdgpu_ring *ring)
 {
 	struct amdgpu_device *adev = ring->adev;
-	bool set_clocks = !cancel_delayed_work_sync(&adev->jpeg.idle_work);
 
-	if (set_clocks)
-		amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_JPEG,
+	atomic_inc(&adev->jpeg.total_submission_cnt);
+	cancel_delayed_work_sync(&adev->jpeg.idle_work);
+
+	mutex_lock(&adev->jpeg.jpeg_pg_lock);
+	amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_JPEG,
 						       AMD_PG_STATE_UNGATE);
+	mutex_unlock(&adev->jpeg.jpeg_pg_lock);
 }
 
 void amdgpu_jpeg_ring_end_use(struct amdgpu_ring *ring)
 {
+	atomic_dec(&ring->adev->jpeg.total_submission_cnt);
 	schedule_delayed_work(&ring->adev->jpeg.idle_work, JPEG_IDLE_TIMEOUT);
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h
index 5131a0a..55fbff2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h
@@ -46,6 +46,8 @@ struct amdgpu_jpeg {
 	unsigned harvest_config;
 	struct delayed_work idle_work;
 	enum amd_powergating_state cur_state;
+	struct mutex jpeg_pg_lock;
+	atomic_t total_submission_cnt;
 };
 
 int amdgpu_jpeg_sw_init(struct amdgpu_device *adev);
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
