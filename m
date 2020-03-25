Return-Path: <SRS0=Seja=5K=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AA9EC54FCF
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Mar 2020 03:59:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A980206F6
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Mar 2020 03:59:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="t4QuGuSf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A980206F6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0772C6E58A;
	Wed, 25 Mar 2020 03:59:02 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2083.outbound.protection.outlook.com [40.107.220.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 839506E58A
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Mar 2020 03:58:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oJOHAW6zUPiumQL/wkygeg+K6f3+8wp02T4R9d+bQki57JTsCCJaIwaEAQo5xpOnO90buMUuJO95LPGpLgZp0kySOneDW9QUGnbhyRbGnnkz5Sp3wjr+ZwAuNlP3mAs0CfRTb4W85Le3qy9gAM+QtAT0JA/lK2KwNQ5qRVtvs8tatTbeIZRGCHth0coQYVs+QaXd5VXYbFhBs2lMgIfWkPKsUJ62iYpAE38cj0GpDDApipXs/VucTi/HxbnfuGiiz3oTPYQuP9duNJ8h2B5UFUIg9we2Ve3ReFoLrE8y+Eq1axmB9mkAnb29UF+ST+7g8NeWrONFH4B8vUqTT/f4/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yDjT+CCLUIrgaQ0sY7hADIsnbYERpIu5SZn+VOl6HR0=;
 b=PrxRguvXFbL+GLZCANrNEgQ4zz8PxcZwBwJyRqHwaS/pALgEh5UNnA8A7TxFwrb+SrsYRar6+nZVv5IUD2zank4W0gBToy9f6VzkwJd0maPiZY/MltIrrqNB+Y9NOMI6CmuF+nHr16kiY0WReXpJJuK0qQGi/Hr4iHOucoTzPpuHnmdOD3N8KKWXUh+6y+AefyOHzQDfKznueiE7YQuk8/6GPm7LJ8LA90pQc5eR0PDs+orZruEgFTtIupfW7hdGvwXy5BolACk9J30ho4o0uUWwuvB1ymEMoZvh4znCJK0Qbkeb3hxySPr1wA5SY7DZTs1sZEI81fehFi5Qe4V8Mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yDjT+CCLUIrgaQ0sY7hADIsnbYERpIu5SZn+VOl6HR0=;
 b=t4QuGuSf6V/l/MuvheBVKa1GfGnp0oHAkWDKwrMmAM3cfVtmuo+cqn2Xsnm7rlFKpuJEyj1N/lzfPNph0Hjn2jdiSKG6hlvsrLcsDPoDKT81HwgFa60V4aMQY8o+vKWvgp3HFJgvcMYoa/9faGi5teN0VYO+UnKNia9s4Mki65s=
Received: from MWHPR17CA0067.namprd17.prod.outlook.com (2603:10b6:300:93::29)
 by MWHPR12MB1950.namprd12.prod.outlook.com (2603:10b6:300:110::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.15; Wed, 25 Mar
 2020 03:58:54 +0000
Received: from CO1NAM11FT032.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:93:cafe::8) by MWHPR17CA0067.outlook.office365.com
 (2603:10b6:300:93::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.20 via Frontend
 Transport; Wed, 25 Mar 2020 03:58:54 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 CO1NAM11FT032.mail.protection.outlook.com (10.13.174.218) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2814.13 via Frontend Transport; Wed, 25 Mar 2020 03:58:54 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Tue, 24 Mar
 2020 22:58:53 -0500
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Tue, 24 Mar
 2020 22:58:52 -0500
Received: from monk-build.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Tue, 24 Mar 2020 22:58:52 -0500
From: Monk Liu <Monk.Liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 6/7] drm/amdgpu: adjust sequence of ip_discovery init and
 timeout_setting
Date: Wed, 25 Mar 2020 11:58:41 +0800
Message-ID: <1585108722-19098-6-git-send-email-Monk.Liu@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1585108722-19098-1-git-send-email-Monk.Liu@amd.com>
References: <1585108722-19098-1-git-send-email-Monk.Liu@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(396003)(39860400002)(346002)(376002)(428003)(46966005)(316002)(6666004)(356004)(426003)(81156014)(4326008)(86362001)(81166006)(5660300002)(70586007)(7696005)(2906002)(70206006)(8936002)(2616005)(186003)(478600001)(47076004)(36756003)(336012)(82740400003)(6916009)(26005)(8676002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MWHPR12MB1950; H:SATLEXMB02.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0dff79c4-8339-4dba-1e4a-08d7d070d615
X-MS-TrafficTypeDiagnostic: MWHPR12MB1950:
X-Microsoft-Antispam-PRVS: <MWHPR12MB1950D5666CB1D210DCD0CDE284CE0@MWHPR12MB1950.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-Forefront-PRVS: 0353563E2B
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sYYetSQqjo4tO8746uGYcr0mJqqHS3mDEADEvEwm1yPS/JKllZMJLX5PZDMZKb9jBiWGZPH4DD6qNLYNcdw9O5tl04Hc4/VCS+9rphPhL5elTSUTC0vex4oEjkhCDFUW7WmbowljVb8gBQiXZqriGbYKrqBH13J88OpfUHR/PURKf/YAuySYeII5Xi8gMWEn67hvh5XprIkPeNnd4hhgN7gISp948ZI4nMwwotQZ8Bt3/nE7xRHLLkzjfdNlJMuIO1IYe3Te8jhnx70qRmABBAmQfY2LUUEkCRxfgYDD9qtkodfjBva9rKUyQFR5+8gIf23EaqTDmPmEtH6bNRBhX/4LeggX5kJ8RQ5gkd/C9ZuqIWkG29eHBZX3aaJHAixMF0/bh0BfUbJW5kt1DxC98XTDFzSSDT3BgILtkbO5FA9cnbhv8D1/tgVSusqfGgFCYmG7mEV1EfZQ67idvb2JsEVaoffRbTLf2rqm9Nbqn3/xK+DdKX/wql72KdaswFh6ZY21eeJY+1FaEJv44wfmAg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2020 03:58:54.1138 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0dff79c4-8339-4dba-1e4a-08d7d070d615
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1950
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
Cc: Monk Liu <Monk.Liu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

what:
1)move timtout setting before ip_early_init to reduce exclusive mode
cost for SRIOV

2)move ip_discovery_init() to inside of amdgpu_discovery_reg_base_init()
it is a prepare for the later upcoming patches.

why:
in later upcoming patches we would use a new mailbox event --
"req_gpu_init_data", which is a callback hooked in adev->virt.ops and
this callback send a new event "REQ_GPU_INIT_DAT" to host to notify
host to do some preparation like "IP discovery/vbios on the VF FB"
and this callback must be:

A) invoked after set_ip_block() because virt.ops is configured during
set_ip_block()

B) invoked before ip_discovery_init() becausen ip_discovery_init()
need host side prepares everything in VF FB first.

current place of ip_discovery_init() is before we can invoke callback
of adev->virt.ops, thus we must move ip_discovery_init() to a place
after the adev->virt.ops all settle done, and the perfect place is in
amdgpu_discovery_reg_base_init()

Signed-off-by: Monk Liu <Monk.Liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    | 16 ++++------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 10 ++++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h |  1 -
 3 files changed, 10 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 273706b..724ad84 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3079,12 +3079,10 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	/* detect hw virtualization here */
 	amdgpu_detect_virtualization(adev);
 
-	if (amdgpu_discovery && adev->asic_type >= CHIP_NAVI10) {
-		r = amdgpu_discovery_init(adev);
-		if (r) {
-			dev_err(adev->dev, "amdgpu_discovery_init failed\n");
-			return r;
-		}
+	r = amdgpu_device_get_job_timeout_settings(adev);
+	if (r) {
+		dev_err(adev->dev, "invalid lockup_timeout parameter syntax\n");
+		return r;
 	}
 
 	/* early init functions */
@@ -3092,12 +3090,6 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	if (r)
 		return r;
 
-	r = amdgpu_device_get_job_timeout_settings(adev);
-	if (r) {
-		dev_err(adev->dev, "invalid lockup_timeout parameter syntax\n");
-		return r;
-	}
-
 	/* doorbell bar mapping and doorbell index init*/
 	amdgpu_device_doorbell_init(adev);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 37e1fcf..43bb22a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -156,7 +156,7 @@ static inline bool amdgpu_discovery_verify_checksum(uint8_t *data, uint32_t size
 	return !!(amdgpu_discovery_calculate_checksum(data, size) == expected);
 }
 
-int amdgpu_discovery_init(struct amdgpu_device *adev)
+static int amdgpu_discovery_init(struct amdgpu_device *adev)
 {
 	struct table_info *info;
 	struct binary_header *bhdr;
@@ -255,10 +255,12 @@ int amdgpu_discovery_reg_base_init(struct amdgpu_device *adev)
 	uint8_t num_base_address;
 	int hw_ip;
 	int i, j, k;
+	int r;
 
-	if (!adev->discovery) {
-		DRM_ERROR("ip discovery uninitialized\n");
-		return -EINVAL;
+	r = amdgpu_discovery_init(adev);
+	if (r) {
+		DRM_ERROR("amdgpu_discovery_init failed\n");
+		return r;
 	}
 
 	bhdr = (struct binary_header *)adev->discovery;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h
index ba78e15..d50d597 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h
@@ -26,7 +26,6 @@
 
 #define DISCOVERY_TMR_SIZE  (64 << 10)
 
-int amdgpu_discovery_init(struct amdgpu_device *adev);
 void amdgpu_discovery_fini(struct amdgpu_device *adev);
 int amdgpu_discovery_reg_base_init(struct amdgpu_device *adev);
 int amdgpu_discovery_get_ip_version(struct amdgpu_device *adev, int hw_id,
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
