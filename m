Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 814C7C77B75
	for <amd-gfx@archiver.kernel.org>; Mon,  8 May 2023 10:48:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B239910E210;
	Mon,  8 May 2023 10:48:22 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2081.outbound.protection.outlook.com [40.107.94.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D724410E210
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 May 2023 10:48:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N/hE/bUt0dSv3FDaosmhhuqQ6FzDSc13LTX/svKIVdPTZsC7FpsejPnnoJbfdbWkpO+8Susu+6Halrh4hWc0u5ZxWdt54vYj/G0t7wutAgzHs7jF1Fyy34v3F0ryWs+D2bhByRh82NxCb181Af36qHharEYa9AW3WOySeQm1M+yCRW9SQeMOxKjr19VYYw5G92bFqIr5VwVxolbdn7faoDY9r3M0U+x3V2ysU9jkJOPWCqOu0xmz30wcSqcFVWDYAyhFW9A5T5o5+2UqlDu8oZ5Di746EgRq+8poUG46IiRkdPDABOHoHiDN03zG9qFXLHFSgv72GJEmhUYJ1M6vLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cc7y89Digh+I7yv1RwF5p+Nl+lRRchxMv+uAu3+PqsI=;
 b=l/cgI7WPIpWU2ZfNENavvOEUgFjtLFa94YKm8c2MMOVzzPGG6wgZvd2wmI4Y6vg+92++JZCh8S8JW5Foc8g+pgIItSrBi3Cv/JrW6W9GTnTDcEeI6LkqC9ggEkX4DMqdEm5BZDnggYC5W/+3xmXS9ng6olleCWoNyqcl/JZrKN/Wd1FrSA177oWN2CSpNacqPNWzgSWOfG+wKL8TVzUlaCmtGZbbRGbGWbVU3YhfRSHYetqKns5faYrf+cfy5YW7ltVeAai0qVNjtCniJr5TcH3bI5NDjWo5yY65EpoJoTf8GkNkDIAskLDTttu1EZ+354UzOmYyfCUBCflGEBnszA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cc7y89Digh+I7yv1RwF5p+Nl+lRRchxMv+uAu3+PqsI=;
 b=qvyFACsy96y5JJh9/I6iAN/J2BN7smD7pVpdpOvpjrUVs88igUAs5GqS6SOfzO5PqHypI3M7IIrpBBQ1cOyoXlzWbWStSxQwN9Bg7et4wYnrSYe+2ezqU5/SKIpKIJlILCUS3k+ZIdFuD4ZLXgYyU+SiGVI5R2p+vM4QQ0TWseY=
Received: from DS7PR05CA0040.namprd05.prod.outlook.com (2603:10b6:8:2f::33) by
 PH0PR12MB5403.namprd12.prod.outlook.com (2603:10b6:510:eb::19) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6363.29; Mon, 8 May 2023 10:48:18 +0000
Received: from DM6NAM11FT031.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2f:cafe::5d) by DS7PR05CA0040.outlook.office365.com
 (2603:10b6:8:2f::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.17 via Frontend
 Transport; Mon, 8 May 2023 10:48:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT031.mail.protection.outlook.com (10.13.172.203) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6363.32 via Frontend Transport; Mon, 8 May 2023 10:48:18 +0000
Received: from TRX40-1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 8 May
 2023 05:48:16 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
Subject: [PATCH v2] drm/amd/amdgpu: Fix assingment in if condition in
 amdgpu_irq.c
Date: Mon, 8 May 2023 16:17:56 +0530
Message-ID: <20230508104756.1007978-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT031:EE_|PH0PR12MB5403:EE_
X-MS-Office365-Filtering-Correlation-Id: 07d77b6c-8e98-4e1c-92b4-08db4fb1bbc4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5WvjOpEpmOJ/452UD7MHxe/ix3Cw2yQPp0yyejk5IZiK6AszPbuOmipVreWg8+qvEZnh77IFFrICE8ChjwY4VqvS73fp+eCRIVQnPo1rZcHI/9MtcJkwnuAJLFyv40+4GcfdpE3RUS87TCVPU1m4gTS5YcZqWhL8dYzzVsUXtHnWj4Q7WH4Z0xcF91zUEvvdubAGNEECJ9Jk1oUsP5qcDJptoYUEbBr+idWSui31RQb2yw7U1Dq4Ps2REqsPwQ6qUupvy9ToULnw1Ku+OkpB7WISA1UKtGQgro90BSxt7v8XbpyYFkxkGHHOLa5IqzAC45kzJGe+1o6K+6JnvM4j0aIaY2e3cQgdgGQT1SfHBeraJbuvYF2TAkGQfz3nDP5PEUqsygPZ/lqVYC39qPSaUuH2jV4p2zLqVEx9oUffw11SrMQG+WsUcMxEcRV4vzm4tiaiq/fND6TjK8FhLVoR/T8N+wgH0YpqqIkbKpg8YTbmjw7W4jbKZonVSKDCes3i6qyK3uY8YOQo8rEcrICrtMIanxMpEXrypqFqSkHs0COLgPGEUKysromaC1eQFE8Ybn4UV8+y/5GLi4XQeYJybOBzWINK7fYfcAY7tt/5wJqdgk/gMrqoOjGP2nAFaHM3eTfyQGLM31EH0w4BVPEuAee6ZEhnSDEmtsYfuFy9GFqzBb9+bqSzrEbK7MPNxeoffRbs0niRUsoCmcqR+oRaSvrSoqPLR59AAq04bhTvP2A=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(396003)(136003)(39860400002)(376002)(451199021)(36840700001)(40470700004)(46966006)(336012)(8936002)(82310400005)(40480700001)(8676002)(1076003)(426003)(26005)(2616005)(5660300002)(16526019)(110136005)(54906003)(70206006)(186003)(316002)(4326008)(7696005)(356005)(6636002)(70586007)(6666004)(478600001)(81166007)(82740400003)(86362001)(36860700001)(36756003)(41300700001)(44832011)(66574015)(47076005)(83380400001)(2906002)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2023 10:48:18.0303 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 07d77b6c-8e98-4e1c-92b4-08db4fb1bbc4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT031.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5403
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
Cc: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Assignments in if condition are less readable and error-prone.

Fixes below error & warnings reported by checkpatch"

ERROR: do not use assignment in if condition
+       } else if ((src = adev->irq.client[client_id].sources[src_id])) {

WARNING: braces {} are not necessary for any arm of this statement
WARNING: Prefer 'unsigned int' to bare use of 'unsigned'

Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---

v2:

- Validate the client_id and src_id values or otherwise
  this can crash (Christian)

 drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c | 29 +++++++++++++------------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
index c8413470e057..dfaedb0243ba 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
@@ -110,7 +110,7 @@ const char *soc15_ih_clientid_name[] = {
 void amdgpu_irq_disable_all(struct amdgpu_device *adev)
 {
 	unsigned long irqflags;
-	unsigned i, j, k;
+	unsigned int i, j, k;
 	int r;
 
 	spin_lock_irqsave(&adev->irq.lock, irqflags);
@@ -269,11 +269,11 @@ int amdgpu_irq_init(struct amdgpu_device *adev)
 		int nvec = pci_msix_vec_count(adev->pdev);
 		unsigned int flags;
 
-		if (nvec <= 0) {
+		if (nvec <= 0)
 			flags = PCI_IRQ_MSI;
-		} else {
+		else
 			flags = PCI_IRQ_MSI | PCI_IRQ_MSIX;
-		}
+
 		/* we only need one vector */
 		nvec = pci_alloc_irq_vectors(adev->pdev, 1, 1, flags);
 		if (nvec > 0) {
@@ -332,7 +332,7 @@ void amdgpu_irq_fini_hw(struct amdgpu_device *adev)
  */
 void amdgpu_irq_fini_sw(struct amdgpu_device *adev)
 {
-	unsigned i, j;
+	unsigned int i, j;
 
 	for (i = 0; i < AMDGPU_IRQ_CLIENTID_MAX; ++i) {
 		if (!adev->irq.client[i].sources)
@@ -366,7 +366,7 @@ void amdgpu_irq_fini_sw(struct amdgpu_device *adev)
  * 0 on success or error code otherwise
  */
 int amdgpu_irq_add_id(struct amdgpu_device *adev,
-		      unsigned client_id, unsigned src_id,
+		      unsigned int client_id, unsigned int src_id,
 		      struct amdgpu_irq_src *source)
 {
 	if (client_id >= AMDGPU_IRQ_CLIENTID_MAX)
@@ -418,8 +418,8 @@ void amdgpu_irq_dispatch(struct amdgpu_device *adev,
 {
 	u32 ring_index = ih->rptr >> 2;
 	struct amdgpu_iv_entry entry;
-	unsigned client_id, src_id;
-	struct amdgpu_irq_src *src;
+	unsigned int client_id, src_id;
+	struct amdgpu_irq_src *src = NULL;
 	bool handled = false;
 	int r;
 
@@ -446,7 +446,8 @@ void amdgpu_irq_dispatch(struct amdgpu_device *adev,
 		DRM_DEBUG("Unregistered interrupt client_id: %d src_id: %d\n",
 			  client_id, src_id);
 
-	} else if ((src = adev->irq.client[client_id].sources[src_id])) {
+	} else if (client_id < AMDGPU_IRQ_CLIENTID_MAX && src_id < AMDGPU_MAX_IRQ_SRC_ID) {
+		src = adev->irq.client[client_id].sources[src_id];
 		r = src->funcs->process(adev, src, &entry);
 		if (r < 0)
 			DRM_ERROR("error processing interrupt (%d)\n", r);
@@ -493,7 +494,7 @@ void amdgpu_irq_delegate(struct amdgpu_device *adev,
  * Updates interrupt state for the specific source (all ASICs).
  */
 int amdgpu_irq_update(struct amdgpu_device *adev,
-			     struct amdgpu_irq_src *src, unsigned type)
+			     struct amdgpu_irq_src *src, unsigned int type)
 {
 	unsigned long irqflags;
 	enum amdgpu_interrupt_state state;
@@ -556,7 +557,7 @@ void amdgpu_irq_gpu_reset_resume_helper(struct amdgpu_device *adev)
  * 0 on success or error code otherwise
  */
 int amdgpu_irq_get(struct amdgpu_device *adev, struct amdgpu_irq_src *src,
-		   unsigned type)
+		   unsigned int type)
 {
 	if (!adev->irq.installed)
 		return -ENOENT;
@@ -586,7 +587,7 @@ int amdgpu_irq_get(struct amdgpu_device *adev, struct amdgpu_irq_src *src,
  * 0 on success or error code otherwise
  */
 int amdgpu_irq_put(struct amdgpu_device *adev, struct amdgpu_irq_src *src,
-		   unsigned type)
+		   unsigned int type)
 {
 	if (!adev->irq.installed)
 		return -ENOENT;
@@ -620,7 +621,7 @@ int amdgpu_irq_put(struct amdgpu_device *adev, struct amdgpu_irq_src *src,
  * invalid parameters
  */
 bool amdgpu_irq_enabled(struct amdgpu_device *adev, struct amdgpu_irq_src *src,
-			unsigned type)
+			unsigned int type)
 {
 	if (!adev->irq.installed)
 		return false;
@@ -733,7 +734,7 @@ void amdgpu_irq_remove_domain(struct amdgpu_device *adev)
  * Returns:
  * Linux IRQ
  */
-unsigned amdgpu_irq_create_mapping(struct amdgpu_device *adev, unsigned src_id)
+unsigned int amdgpu_irq_create_mapping(struct amdgpu_device *adev, unsigned int src_id)
 {
 	adev->irq.virq[src_id] = irq_create_mapping(adev->irq.domain, src_id);
 
-- 
2.25.1

