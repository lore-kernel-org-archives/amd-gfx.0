Return-Path: <SRS0=ehRF=6E=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 970BBC3815B
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Apr 2020 04:17:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68AB020661
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Apr 2020 04:17:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="cH4MKK/x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68AB020661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E87A6E14B;
	Mon, 20 Apr 2020 04:17:37 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2050.outbound.protection.outlook.com [40.107.93.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 30A7F6E14B
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Apr 2020 04:17:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IUUbKEiNvG8YyP2cTtmORsfdHufCreHfR0mfEeCJDWK1czoqSxy5KT0Zb6QUqZnROb4NHAG112Tv/gPMt3Eh+NLw38JzLa7Gf5lQbEG+k/7mtJP5Wb1QsnTC/c+R+OucfnHT0pnUpNKmOYC+U6NfB+m3Ziu3nFbSV2hfdLtppn2/6mU6B35Ohta97/EiRg+mBa9eX9Oc+JPU1DTKHKpyQWdL1mn2MOc+w5wI0c8X0KOP4I7N5E2S/gDkQz1Db0951XNF6m7Ooq2vJRxb4ABKLWwX8ybQTW8VNkx7okiidVmqq7v49haidhoVBYa3SG49QqjB7l7Ytfp5mPgSQ6HENA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/cMGE0w5VRvalltErVkV+3PDOgIeoiBs2N7RkoLr4fY=;
 b=ZCoyThy3R/Eq/17x82AToZDOyz8QnofrrzsKZazoEEZGbjCAEKjeFA5li1hVKZZEg0hfzzMgV85QmvjlDPalmMTJ9WKXPZYyX3u202QjFsnC+Wi+L/Q47hp51rCTmANix+rOLPUN6AWeBpBtHRxiRSGOF7fnX2GIh0srjG71j2CAyM2lSmmPNxoUb+OOZFclTcUtgLAxmF5SNZkqgvMG5WYpBf8EB2GZQLWCbtU9j2bdnD7tBjIFCj7rs5FpUe+VjNdXo9Ifj2e9c/8qHA1SjSaDDE5CCnR3R3NuQ3faOpl+ysPsdyz3cqkn7iZqthn9oXvtrsC4PuYQ8S2cOe+ntA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/cMGE0w5VRvalltErVkV+3PDOgIeoiBs2N7RkoLr4fY=;
 b=cH4MKK/xHkPIlqD/iizVryFwqb1uFJKvf/yt++OH0gWw7BPrIWqqLkiV7ZBrtIS7nG5Th9mSjPZbCuVASYI2cCnRcdutmT2hjP4enzQ4ZjU0sP3gMNxfDMI0gXBlyNvNVjRBozHp7gRAelES7KmilWc+CiyrEK636uh3giiVvJo=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Xinhui.Pan@amd.com; 
Received: from SN1PR12MB2558.namprd12.prod.outlook.com (2603:10b6:802:2b::18)
 by SN1PR12MB2350.namprd12.prod.outlook.com (2603:10b6:802:24::31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.29; Mon, 20 Apr
 2020 04:17:33 +0000
Received: from SN1PR12MB2558.namprd12.prod.outlook.com
 ([fe80::ec5f:a26:8530:3b9f]) by SN1PR12MB2558.namprd12.prod.outlook.com
 ([fe80::ec5f:a26:8530:3b9f%6]) with mapi id 15.20.2921.027; Mon, 20 Apr 2020
 04:17:33 +0000
From: xinhui pan <xinhui.pan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: Fix kernel panic while gpu recovery
Date: Mon, 20 Apr 2020 12:17:15 +0800
Message-Id: <20200420041715.13436-1-xinhui.pan@amd.com>
X-Mailer: git-send-email 2.17.1
X-ClientProxiedBy: HK2PR02CA0138.apcprd02.prod.outlook.com
 (2603:1096:202:16::22) To SN1PR12MB2558.namprd12.prod.outlook.com
 (2603:10b6:802:2b::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from pp-server-two.amd.com (180.167.199.189) by
 HK2PR02CA0138.apcprd02.prod.outlook.com (2603:1096:202:16::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2921.25 via Frontend Transport; Mon, 20 Apr 2020 04:17:31 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [180.167.199.189]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7dd1e7aa-8930-4c88-220b-08d7e4e1bfdf
X-MS-TrafficTypeDiagnostic: SN1PR12MB2350:|SN1PR12MB2350:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN1PR12MB23504DF6A560A2E2E70AC74487D40@SN1PR12MB2350.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-Forefront-PRVS: 03793408BA
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN1PR12MB2558.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(136003)(346002)(396003)(376002)(366004)(39860400002)(6486002)(4326008)(6916009)(86362001)(36756003)(2906002)(8676002)(81156014)(8936002)(52116002)(1076003)(7696005)(66476007)(316002)(6666004)(5660300002)(26005)(186003)(16526019)(956004)(2616005)(66946007)(66556008)(478600001);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oonLBpcRyKoMfttlYC6YVCKhm46McODFaPsLofPD9VYKojb9uerBhTJk5979+fj7ogQGZCc+CugryMAaB0Z+Wb37KaUor/CfVAvtqBfvqpKLaiGNThAbfHGGfyxxigsD09ObMDg/YDbOSQsLq40Xl3GcJM8mzeUSud68DLSFNPW21p3227flGzY3XEEyowoiTjO8kX7qG9DTDq+qlq6i+BtMBBbig51uNCXkWtOMvsCOpCifmeZ7zTnLbaTT9RGIzQp3x/WsApSqJOmeNxe/rw0MReG0qnvq3yjoLXu90ejRhJIWBIjuPejDybxtIiPbRgs1t4pkg6+hmqDNGSKDDpG914V/Mp0lOuP6iXwYJgmTFonaxLVgmbatV5jy0vvchlb6RE6IDqSiyQ9e/RU/C78H2h66+btzRYIo3F3o7bTNL2sswTxU0asbKAYAkJPn
X-MS-Exchange-AntiSpam-MessageData: JV8K9pCJYdKkwxoPJJzc2wip6o8LO1u7Tf9ELOqR1vRfoG1FjgHDPh7yefomPvjaFBsVBRFaZ+wB7Uggs24E1UT1HE2++qbxa5CTI5qFfcvhuM4qxJnPwYs2xczzhkFORx+0C+qHdPgFW5I60DP1/w==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7dd1e7aa-8930-4c88-220b-08d7e4e1bfdf
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2020 04:17:33.5509 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XmJIjTHumem0sy1JT5HbWthshKC5ukXgn5/hQQoLMNqYy1gUEJaYVn/9GBnl8oXa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2350
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
Cc: alexander.deucher@amd.com, xinhui pan <xinhui.pan@amd.com>,
 guchun.chen@amd.com, Hawking.Zhang@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Ras error occurs while gpu recovery. We can not add its list head
to two lists at same time.

Signed-off-by: xinhui pan <xinhui.pan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 68b82f7b0b80..d753c38c3b1d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1449,20 +1449,16 @@ static void amdgpu_ras_do_recovery(struct work_struct *work)
 		container_of(work, struct amdgpu_ras, recovery_work);
 	struct amdgpu_device *remote_adev = NULL;
 	struct amdgpu_device *adev = ras->adev;
-	struct list_head device_list, *device_list_handle =  NULL;
 	struct amdgpu_hive_info *hive = amdgpu_get_xgmi_hive(adev, false);
 
 	/* Build list of devices to query RAS related errors */
-	if  (hive && adev->gmc.xgmi.num_physical_nodes > 1)
-		device_list_handle = &hive->device_list;
-	else {
-		INIT_LIST_HEAD(&device_list);
-		list_add_tail(&adev->gmc.xgmi.head, &device_list);
-		device_list_handle = &device_list;
-	}
-
-	list_for_each_entry(remote_adev, device_list_handle, gmc.xgmi.head) {
-		amdgpu_ras_log_on_err_counter(remote_adev);
+	if  (hive && adev->gmc.xgmi.num_physical_nodes > 1) {
+		list_for_each_entry(remote_adev, &hive->device_list,
+				gmc.xgmi.head) {
+			amdgpu_ras_log_on_err_counter(remote_adev);
+		}
+	} else {
+		amdgpu_ras_log_on_err_counter(adev);
 	}
 
 	if (amdgpu_device_should_recover_gpu(ras->adev))
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
