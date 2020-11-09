Return-Path: <SRS0=C2iJ=EP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20AD8C2D0A3
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Nov 2020 19:41:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A32F7206A1
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Nov 2020 19:41:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="jZaG5cDI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A32F7206A1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 145DC891E7;
	Mon,  9 Nov 2020 19:41:24 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2059.outbound.protection.outlook.com [40.107.237.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D34B8891E7
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Nov 2020 19:41:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ph9N2ZS57N3qh+tklDQGVHf8Cudu3K74OxvR/9P8jGUI2WsPlN2D/gyp6p5BQ4pNjLs7OU+dgm8lcUzBLgDvKjjUHbsYyDOtlsTA//VcZlA5kuuB2udTajScgnyC79e/vWYLBksgNzjV0SgBRmQ7dEeIx5nIhyUq3rT35G11uc4/MYhPSRQ1+0iGo8QoznEcvufPtEZGG5ENfNDAZQu1OT1RZWWE8YUm6k8FLGXmDcivxJb/DWcJTkMTN+dbh8KTK0YxZSS9UyXV0YLB9aZISAuWSYl0KFPYzJuQf/zIl736ZUPHkZZQuwUvDdqn7K6ZaUjcMyFcPpeqk6iLgI+4OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uibIq8AlUzjPIxM8OHCvRZ5bVU7CXkgXUHr7zPdECvU=;
 b=lByKFJ5IMS/8tpTvSIqU6s5XEJ4Y/SivVhw3URyO0KNtGIc1zaKDtfvbgwKKzQxlMYJSOimFYCm1jm84E0iJLN7VwNBGm2/V0DTbUKrX2b2annT9/+9cp9nuKkitqBa7D2JsNTq10ifNo1pLt62qhz88vz14vcdAP4h514OlfoCAlvM1fJOTDRAulZ4et/9xouhSzZut2ZSrjA79hAIuN0HwtvWu+VfgTDOIGoOQsJbIPtTWqeFkiu0iCMtkDzdygdTbMS0tEDFSxFZom0aBFDJ7LJk1tdxsMe5rXquAEAcqWhI6O5+UPDitkauhodQjz7P+inPafB2smBSw5u05hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uibIq8AlUzjPIxM8OHCvRZ5bVU7CXkgXUHr7zPdECvU=;
 b=jZaG5cDIu79ZmCGRwvXXBIy20WIJekdZUJ/Aq+nWXTmARidMXi4Q4YNslzoDR1KokwyyGkb6bqSQD4Kw0KrgDXu/uQvhE/Ab6XUqH820mr3RksAky9TcjvAcn0VfgvZWOnNy7+0GoqUz2y7B+TUkYAGvQ3AqgAeBqwXdhta8rUE=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3433.namprd12.prod.outlook.com (2603:10b6:5:38::14) by
 DM6PR12MB2634.namprd12.prod.outlook.com (2603:10b6:5:49::27) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3541.21; Mon, 9 Nov 2020 19:41:18 +0000
Received: from DM6PR12MB3433.namprd12.prod.outlook.com
 ([fe80::6009:8864:b920:1dcc]) by DM6PR12MB3433.namprd12.prod.outlook.com
 ([fe80::6009:8864:b920:1dcc%7]) with mapi id 15.20.3541.025; Mon, 9 Nov 2020
 19:41:18 +0000
From: Sonny Jiang <sonny.jiang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH v2] drm/amdgpu: fix SI UVD firmware validate resume fail
Date: Mon,  9 Nov 2020 14:41:01 -0500
Message-Id: <20201109194101.7082-1-sonny.jiang@amd.com>
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [165.204.84.11]
X-ClientProxiedBy: BN6PR11CA0017.namprd11.prod.outlook.com
 (2603:10b6:405:2::27) To DM6PR12MB3433.namprd12.prod.outlook.com
 (2603:10b6:5:38::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (165.204.84.11) by
 BN6PR11CA0017.namprd11.prod.outlook.com (2603:10b6:405:2::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3541.21 via Frontend Transport; Mon, 9 Nov 2020 19:41:17 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 98fc73ce-c032-4e9b-55c3-08d884e76d6f
X-MS-TrafficTypeDiagnostic: DM6PR12MB2634:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB26348330E5FAE445F2B5CAFBFDEA0@DM6PR12MB2634.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8/YVPLQjcVBej6rcQMsE1JmZ/WGMs59pT7NfCdZ7CbVtbel2NgFfRHs2bPgzofhn7rBvl7ul1T3wBeiDIhN/HvPx3thv9Mk/LIyYU0IxTagrZDhVFXi2EAaeS6aAuqrL3LisjFKCwpRITT5db1lljrq8En1JUL5LM2C/q83tNtEN01x/Gr+bYIhxIpe6AMrRxgcQUD/8fEi0RI0y51KgXgXI4H8kR5bybBdU1JA8dyDsKgnJ0MyQiaT1G9pDjhQXhKPlccv43qVB0/VrnEFKh+gTbvarW7WQXmPBdAk0ri9tPSlf3Dhf7OABTPlYARi2qa/VRUQERCSCL6WUVbALZRoL06bwREd5iINvDOV7lyskMd/SWks+/cfPdQFn3jzJ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3433.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(366004)(396003)(376002)(346002)(2616005)(1076003)(83380400001)(16526019)(6666004)(8676002)(8936002)(52116002)(26005)(956004)(186003)(6506007)(44832011)(478600001)(316002)(36756003)(5660300002)(6916009)(69590400008)(2906002)(86362001)(15650500001)(66476007)(4326008)(6486002)(6512007)(66946007)(66556008);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: luqNSSHoJDHhVgElwUU7vqxN3XP6EyWzLcX6bC4T+BNPlZUKLLQZFnZyLLFusm+fNFic121N8IPa7alL408cs8qgju5uuO+YbQHISvAAUhlLjrLAKy5LSXjGc5dpUEEvthefBh4URe0v2DIoTg2t9bGB2ULRz4irT9KLIfAjzBIxhD3uByuZzCwxX3rwHGTtvjqrePtrBYF70qXb2qmGHsqu5on8c6+D+8dwOcF5xgFtVvtD+wPBgBuHkI9dyWEAE3auqo3cNYBhRrCazDCExF/sxsMjQ2LKNmPxQEynWRZN1jbk6lY9i58URZ6qvHgp7NEDIW7vST+1kWGX6rNdtLxPPyeNbZ7zcAw5yCplCjw/kWgvf3w54OHHaCTma7FNz1C6gLsWmkVGwFbUePyAzLsPrJCSbzbx+QpIFcByp0Woi0jEQpQHpm+HGse8QWI7cUOlomCIxRDAPZ1O3pa0H0J8iY3lFa652sFsirdHlasIYl88rWORvjVv+iLgHEfl8cdvvzi+5gLJFN7fbK8MSxDzIX6w1y3ZFjfkkZsUbVS25gnwVcJPI3dVJRC2RimTstoehfRRcR9m3xYvU6ego/88zEqh1K0TpIV+JaVdH+0Z4m4mJdDEY1SKqID3hxZF9gGjmwhvfAcYsdzUyAOAXA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98fc73ce-c032-4e9b-55c3-08d884e76d6f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3433.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2020 19:41:18.5017 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GRHfbFnSYj7UwE3zbxgXns6kgHs4kv+ACdOlzJY/WERZ4t7z/lhkK4sfeE+VXCwTXi9xpXct5BhL+CCpTm1Y/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2634
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
Cc: Sonny Jiang <sonny.jiang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The SI UVD firmware validate key is stored at the end of firmware,
which is changed during resume while playing video. So get the key
at sw_init and store it for fw validate using.

Signed-off-by: Sonny Jiang <sonny.jiang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.h |  1 +
 drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c   | 20 +++++++++++---------
 2 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.h
index 5eb63288d157..edbb8194ee81 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.h
@@ -67,6 +67,7 @@ struct amdgpu_uvd {
 	unsigned		harvest_config;
 	/* store image width to adjust nb memory state */
 	unsigned		decode_image_width;
+	uint32_t                keyselect;
 };
 
 int amdgpu_uvd_sw_init(struct amdgpu_device *adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c b/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c
index 7cf4b11a65c5..3a5dce634cda 100644
--- a/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c
@@ -277,15 +277,8 @@ static void uvd_v3_1_mc_resume(struct amdgpu_device *adev)
  */
 static int uvd_v3_1_fw_validate(struct amdgpu_device *adev)
 {
-	void *ptr;
-	uint32_t ucode_len, i;
-	uint32_t keysel;
-
-	ptr = adev->uvd.inst[0].cpu_addr;
-	ptr += 192 + 16;
-	memcpy(&ucode_len, ptr, 4);
-	ptr += ucode_len;
-	memcpy(&keysel, ptr, 4);
+	int i;
+	uint32_t keysel = adev->uvd.keyselect;
 
 	WREG32(mmUVD_FW_START, keysel);
 
@@ -550,6 +543,8 @@ static int uvd_v3_1_sw_init(void *handle)
 	struct amdgpu_ring *ring;
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 	int r;
+	void *ptr;
+	uint32_t ucode_len;
 
 	/* UVD TRAP */
 	r = amdgpu_irq_add_id(adev, AMDGPU_IRQ_CLIENTID_LEGACY, 124, &adev->uvd.inst->irq);
@@ -560,6 +555,13 @@ static int uvd_v3_1_sw_init(void *handle)
 	if (r)
 		return r;
 
+	/* Retrieval firmware validate key */
+	ptr = adev->uvd.inst[0].cpu_addr;
+	ptr += 192 + 16;
+	memcpy(&ucode_len, ptr, 4);
+	ptr += ucode_len;
+	memcpy(&adev->uvd.keyselect, ptr, 4);
+
 	ring = &adev->uvd.inst->ring;
 	sprintf(ring->name, "uvd");
 	r = amdgpu_ring_init(adev, ring, 512, &adev->uvd.inst->irq, 0,
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
