Return-Path: <SRS0=Rd3N=H3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD2A2C433E0
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Feb 2021 18:56:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5415964F3A
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Feb 2021 18:56:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5415964F3A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 069C96ED22;
	Thu, 25 Feb 2021 18:56:44 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2049.outbound.protection.outlook.com [40.107.93.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E33D6ED22
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Feb 2021 18:56:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z/YitnZs+Bk8AOCRO6svUnFFWuChI0b0djz4ySgdrk3NY5TEvm2k6bXyTDyLOIReGGED7hvP2OBHQDf49fzVzHK01S0292I312czHwjrt6bzJsqJ0sytFrCI6LUhaQGJcfxogXhCzqn6lH2BGSkSXOnh+tBhZ8z8gI4v+oEGDAqRjq6AqqYJ/jKth4aWT1Tnn4lKbjF0+IwyAhIccy3vedTUAucpj8pYjH7nM1qLu6KGwCJZgHYoHkhpEcoWkJzRzB1EEu//Lfiq8AQi0Z3ANupCFAYdUG8PEi47nUavpf6nwGndvTGO2Z679/9u6i2t86xvePTXMV7HskPs1m2eKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3u/hJoH4lNb6SxnJTBXzT5Xb9y/7v5r7ZjHaqj5hS50=;
 b=D3zOc+imluWBb/54kwMEbjInfliMbMg0rH5204HYGIOnP+itDgKoNirhsVl0m3qigS2p3OH72+mVbH5Q7dQwdKWm5gNoz37/+qr2YSH1/M5Molj6qsRYS9s3r/DhtuQM6pXkufl2jkhsvdejR+E1LsukGNTZ7UnYlbIPQ8qBGNPreK2B05h1O/+1oL5cIwUHLNXruMYIwuQiBECYT2U1q+6lAzlbWZIsxXPNeUHb2dvd3V22YMTvwYBSkvA02K7vUSJb4F4j8/rXQuD9jE4+V3Y4XA/7c+O7Xviu2fZ78YSpSvEuDSeZ8adIUo1FHHWT6iJCDviTeiy1Vm/MIUdfIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3u/hJoH4lNb6SxnJTBXzT5Xb9y/7v5r7ZjHaqj5hS50=;
 b=uV1cKJUHQOEz/ueYMKFTk6+H4w+7KkkRlosdMWCcWDNs73Gl01D/avuaGOgaPAsIlD7BsZh6aq7fDZ8YrFT/LlTZBTgu89JFeGvKHIeVvr3Rm1eor9+EfaIPMhyRKMcE10Wo8Jnmm3PRpJecizAWFY8j9FKxBeSKICIOl9eCNbg=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4456.namprd12.prod.outlook.com (2603:10b6:208:266::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.32; Thu, 25 Feb
 2021 18:56:40 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af%7]) with mapi id 15.20.3890.020; Thu, 25 Feb 2021
 18:56:39 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 3/3] drm/amdgpu: harvest edc status when connected to host via
 xGMI
Date: Thu, 25 Feb 2021 13:56:02 -0500
Message-Id: <20210225185602.661486-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210225185602.661486-1-alexander.deucher@amd.com>
References: <20210225185602.661486-1-alexander.deucher@amd.com>
X-Originating-IP: [165.204.84.11]
X-ClientProxiedBy: BL1PR13CA0206.namprd13.prod.outlook.com
 (2603:10b6:208:2be::31) To MN2PR12MB4488.namprd12.prod.outlook.com
 (2603:10b6:208:24e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from tr4.amd.com (165.204.84.11) by
 BL1PR13CA0206.namprd13.prod.outlook.com (2603:10b6:208:2be::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.14 via Frontend
 Transport; Thu, 25 Feb 2021 18:56:39 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 805601c9-a365-4aff-a9b2-08d8d9bf156a
X-MS-TrafficTypeDiagnostic: MN2PR12MB4456:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4456F2A25EBB607F03AF7988F79E9@MN2PR12MB4456.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:40;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cZr24C8QapkZxYTct06UltlPJ9g0Mrw0pIK99TbFwmGMaN97197vgECuF3GNT8aBjsb7it8I1tZfIwm7IHaoSUd1K/mbhkKyJZihC5MtoUP6qm6czGnMOoaeca2k7kcvD3E4ySisDuU+fM5fGP8QpaYphgaprWmFW3Sqs6uuGJHP9k8D7tghOQuPkLBj4CUnvE6dijawi6PBy3J8XNHRlUngc2kSbtCpOmqfKjU91kwfWL6KMbdiMKSbp50rEV8bXPFVgy3tWHa+Az3EoszgMco7MO/erUaNnDo52ZUM0YR/5Hz8/Uipbdb9Yp/SZWruOKnWoZWjm4r3cBsCRQHFvkuUFKfCIqMTqN+tFFaj5C7FSTRJkBlJHPCZTX3Do/8C2uB4TFQIeugbfSWNZQKuDTF9nWJitzJXRUW/+trFoOZZzv5AZJqCgRsCDF1pYvP1FM+ZRIX6QoWgXuKcp5K5HcVCLM2fO18QrV0HyqK96SdjNqCoDuyi6C4dVL0EW49rzj598uFwa6YdxY5r7kItaw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(366004)(346002)(39860400002)(396003)(136003)(52116002)(186003)(6486002)(26005)(5660300002)(66476007)(54906003)(6916009)(956004)(16526019)(7696005)(8676002)(36756003)(2616005)(30864003)(316002)(6666004)(86362001)(83380400001)(66556008)(1076003)(478600001)(8936002)(66946007)(4326008)(2906002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?xaKXIf/rA5oXM4tuXOJqdRUlo73ArIu6RMV4QsBqztgaQfRJwb2KR9S/wIaW?=
 =?us-ascii?Q?aYbJyWLJgLOGJBRXwwID1xULXk7Yt1wHCoDr0PQXSsKLNOpDenZuadZS9p9Z?=
 =?us-ascii?Q?plTaHRFZp2kxV2wgXdcw17K3jE2lCKDa7m123mqQYuPfLPYXShJnxRa3sfxq?=
 =?us-ascii?Q?z5APxB1gNF+rBwzYxd+NTSBQXPBylVLdfV6dNbmAsvOlOTiElZMZXB4UA7mn?=
 =?us-ascii?Q?5YjmLOqAD3PDAOZPgEnMe4d4IChg75uAACPEOVFsRnixE9oucOIvBG5f1O3k?=
 =?us-ascii?Q?tx6eFc1gyG6RONcrVjl8sL0/G5lUyjQ62UkX/qxqwjOxn1n23zZLFsHylRxp?=
 =?us-ascii?Q?vPXuiof/9VJ01wl6or55cB+qmuAMimMPUOdiGirAS39rCZo8VSYY2wWV+3mz?=
 =?us-ascii?Q?KUQImLXLdlqbiX6UQDwTysvKcppgWnEK7nWNQxP/Z7wFegjO5JOMWjppM0sT?=
 =?us-ascii?Q?vpqFJ3225T9bnlDaP+r9M7g110AA1sneW0llpIufF9TpufjlBgZzmhHocal+?=
 =?us-ascii?Q?LT4dxAXtm4UWEkA/tghsdHElB/GUQybSc7Q90dizvXL7c8jka52VzoyaJdUs?=
 =?us-ascii?Q?qzJqDkArjWsfSgoisoGMpCNLIkGXUti0irv5mHkkdPYo8rQsjYbEoJErZaKV?=
 =?us-ascii?Q?GzKFcioPZIolvilHgFqmy4kOLGiZ0oLksgubbZQzbgEnu6NSA3s6Qz0pxyFu?=
 =?us-ascii?Q?+YqXPZz5yeIrVIY43/SczCcIV8FMsJEYJXJPX7wIJVvZway9aSX6FEyQ8uDo?=
 =?us-ascii?Q?KOLPzKepyRYMFTVyLVs2ierJQNGUZ21jQu3Rw9v3EgKntDvyl+NXM8snmtrx?=
 =?us-ascii?Q?phbM6yKYjkapGFv8a3mTWIuuJ1gZ9E3MB0WAiOgFDu3Uzbz0F5PlyZBYnuX4?=
 =?us-ascii?Q?cpkaNAa1qt6IyI2EgLXKLnorS+QwBs5rNQCuRad4mglJesc4Mk9tq35RLknE?=
 =?us-ascii?Q?cSiFiUUOQwhZ9nB6jnfbTTJUC7zXFlBUgZeOuSG3uYEJfEB85Cgsy+Mwd2eU?=
 =?us-ascii?Q?R4TKtkf/MbfpEWussEc9V8gD9LhWyiVxmgOjC3c73TpEGEfLXUhlwXqlSmU3?=
 =?us-ascii?Q?iLvPY1jwQukX8jPdoDSFOF+voCI43lhUvAjnD0Oc5YLuHpWU957JyWqzu8G5?=
 =?us-ascii?Q?DzEDx8Me9MoJGLExdRZz4bQZyCH+3UxTaJjbenBLYIo3rME/HUX/tXvTEX5p?=
 =?us-ascii?Q?QVmV5/z/dFHWrYFZIDeBgqboR+dLFLodJely16Ll/dau86c+d4NVUhDUgPpZ?=
 =?us-ascii?Q?/T+E9fikwjfSy/wbaXQcJOywhQp54EinwvUpv1SgHIcJD/z8YJU6FWqZSsLh?=
 =?us-ascii?Q?i9LllCOnNhJnhmkN82feURtf?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 805601c9-a365-4aff-a9b2-08d8d9bf156a
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2021 18:56:39.8429 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jgYGQhDo/N85eaXGIrLb0BLdnpoTEXv5JuSa7onK2tfSxE/n5MzVpNszDuwYzr9SILXQATYs+3mmml7p8dtl3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4456
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Dennis Li <Dennis.Li@amd.com>,
 Hawking Zhang <hawking.zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Dennis Li <Dennis.Li@amd.com>

When connected to a host via xGMI, system fatal errors may trigger
warm reset, driver has no change to query edc status before reset.
Therefore in this case, driver should harvest previous error loging
registers during boot, instead of only resetting them.

v2:
1. IP's ras_manager object is created when its ras feature is enabled,
so change to query edc status after amdgpu_ras_late_init called

2. change to enable watchdog timer after finishing gfx edc init

Signed-off-by: Dennis Li <Dennis.Li@amd.com>
Reivewed-by: Hawking Zhang <hawking.zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c |  9 ++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 50 ++++++++++++++++++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h |  5 ++-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c   | 12 ++----
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c | 54 ++++++++++++++++++++++---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.h |  3 +-
 7 files changed, 107 insertions(+), 28 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index 8e0a6c62322e..689addb1520d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -601,6 +601,7 @@ int amdgpu_gfx_ras_late_init(struct amdgpu_device *adev)
 	struct ras_ih_if ih_info = {
 		.cb = amdgpu_gfx_process_ras_data_cb,
 	};
+	struct ras_query_if info = { 0 };
 
 	if (!adev->gfx.ras_if) {
 		adev->gfx.ras_if = kmalloc(sizeof(struct ras_common_if), GFP_KERNEL);
@@ -612,13 +613,19 @@ int amdgpu_gfx_ras_late_init(struct amdgpu_device *adev)
 		strcpy(adev->gfx.ras_if->name, "gfx");
 	}
 	fs_info.head = ih_info.head = *adev->gfx.ras_if;
-
 	r = amdgpu_ras_late_init(adev, adev->gfx.ras_if,
 				 &fs_info, &ih_info);
 	if (r)
 		goto free;
 
 	if (amdgpu_ras_is_supported(adev, adev->gfx.ras_if->block)) {
+		if (adev->gmc.xgmi.connected_to_cpu) {
+			info.head = *adev->gfx.ras_if;
+			amdgpu_ras_query_error_status(adev, &info);
+		} else {
+			amdgpu_ras_reset_error_status(adev, AMDGPU_RAS_BLOCK__GFX);
+		}
+
 		r = amdgpu_irq_get(adev, &adev->gfx.cp_ecc_error_irq, 0);
 		if (r)
 			goto late_fini;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
index d92f0f14cbeb..38af93f501e1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -225,9 +225,9 @@ struct amdgpu_gfx_funcs {
 	void (*reset_ras_error_count) (struct amdgpu_device *adev);
 	void (*init_spm_golden)(struct amdgpu_device *adev);
 	void (*query_ras_error_status) (struct amdgpu_device *adev);
+	void (*reset_ras_error_status) (struct amdgpu_device *adev);
 	void (*update_perfmon_mgcg)(struct amdgpu_device *adev, bool enable);
 	void (*enable_watchdog_timer)(struct amdgpu_device *adev);
-	void (*query_sq_timeout_status)(struct amdgpu_device *adev);
 };
 
 struct sq_work {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 5805c78c356b..517e19fae34f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -109,7 +109,7 @@ static ssize_t amdgpu_ras_debugfs_read(struct file *f, char __user *buf,
 	ssize_t s;
 	char val[128];
 
-	if (amdgpu_ras_error_query(obj->adev, &info))
+	if (amdgpu_ras_query_error_status(obj->adev, &info))
 		return -EINVAL;
 
 	s = snprintf(val, sizeof(val), "%s: %lu\n%s: %lu\n",
@@ -434,7 +434,7 @@ static ssize_t amdgpu_ras_sysfs_read(struct device *dev,
 		return snprintf(buf, PAGE_SIZE,
 				"Query currently inaccessible\n");
 
-	if (amdgpu_ras_error_query(obj->adev, &info))
+	if (amdgpu_ras_query_error_status(obj->adev, &info))
 		return -EINVAL;
 
 	return snprintf(buf, PAGE_SIZE, "%s: %lu\n%s: %lu\n",
@@ -757,8 +757,8 @@ static int amdgpu_ras_enable_all_features(struct amdgpu_device *adev,
 /* feature ctl end */
 
 /* query/inject/cure begin */
-int amdgpu_ras_error_query(struct amdgpu_device *adev,
-		struct ras_query_if *info)
+int amdgpu_ras_query_error_status(struct amdgpu_device *adev,
+	struct ras_query_if *info)
 {
 	struct ras_manager *obj = amdgpu_ras_find_obj(adev, &info->head);
 	struct ras_err_data err_data = {0, 0, 0, NULL};
@@ -787,10 +787,16 @@ int amdgpu_ras_error_query(struct amdgpu_device *adev,
 	case AMDGPU_RAS_BLOCK__GFX:
 		if (adev->gfx.funcs->query_ras_error_count)
 			adev->gfx.funcs->query_ras_error_count(adev, &err_data);
+
+		if (adev->gfx.funcs->query_ras_error_status)
+			adev->gfx.funcs->query_ras_error_status(adev);
 		break;
 	case AMDGPU_RAS_BLOCK__MMHUB:
 		if (adev->mmhub.funcs->query_ras_error_count)
 			adev->mmhub.funcs->query_ras_error_count(adev, &err_data);
+
+		if (adev->mmhub.funcs->query_ras_error_status)
+			adev->mmhub.funcs->query_ras_error_status(adev);
 		break;
 	case AMDGPU_RAS_BLOCK__PCIE_BIF:
 		if (adev->nbio.funcs->query_ras_error_count)
@@ -826,6 +832,35 @@ int amdgpu_ras_error_query(struct amdgpu_device *adev,
 	return 0;
 }
 
+int amdgpu_ras_reset_error_status(struct amdgpu_device *adev,
+		enum amdgpu_ras_block block)
+{
+	if (!amdgpu_ras_is_supported(adev, block))
+		return -EINVAL;
+
+	switch (block) {
+	case AMDGPU_RAS_BLOCK__GFX:
+		if (adev->gfx.funcs->reset_ras_error_count)
+			adev->gfx.funcs->reset_ras_error_count(adev);
+
+		if (adev->gfx.funcs->reset_ras_error_status)
+			adev->gfx.funcs->reset_ras_error_status(adev);
+		break;
+	case AMDGPU_RAS_BLOCK__MMHUB:
+		if (adev->mmhub.funcs->reset_ras_error_count)
+			adev->mmhub.funcs->reset_ras_error_count(adev);
+		break;
+	case AMDGPU_RAS_BLOCK__SDMA:
+		if (adev->sdma.funcs->reset_ras_error_count)
+			adev->sdma.funcs->reset_ras_error_count(adev);
+		break;
+	default:
+		break;
+	}
+
+	return 0;
+}
+
 /* Trigger XGMI/WAFL error */
 static int amdgpu_ras_error_inject_xgmi(struct amdgpu_device *adev,
 				 struct ta_ras_trigger_error_input *block_info)
@@ -921,7 +956,7 @@ unsigned long amdgpu_ras_query_error_count(struct amdgpu_device *adev,
 			.head = obj->head,
 		};
 
-		if (amdgpu_ras_error_query(adev, &info))
+		if (amdgpu_ras_query_error_status(adev, &info))
 			return 0;
 
 		data.ce_count += info.ce_count;
@@ -1451,7 +1486,7 @@ static void amdgpu_ras_log_on_err_counter(struct amdgpu_device *adev)
 		if (info.head.block == AMDGPU_RAS_BLOCK__PCIE_BIF)
 			continue;
 
-		amdgpu_ras_error_query(adev, &info);
+		amdgpu_ras_query_error_status(adev, &info);
 	}
 }
 
@@ -1467,9 +1502,6 @@ static void amdgpu_ras_error_status_query(struct amdgpu_device *adev,
 	case AMDGPU_RAS_BLOCK__GFX:
 		if (adev->gfx.funcs->query_ras_error_status)
 			adev->gfx.funcs->query_ras_error_status(adev);
-
-		if (adev->gfx.funcs->query_sq_timeout_status)
-			adev->gfx.funcs->query_sq_timeout_status(adev);
 		break;
 	case AMDGPU_RAS_BLOCK__MMHUB:
 		if (adev->mmhub.funcs->query_ras_error_status)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
index aed0716efa5a..a9fd655ed5ee 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -590,9 +590,12 @@ int amdgpu_ras_sysfs_remove(struct amdgpu_device *adev,
 
 void amdgpu_ras_debugfs_create_all(struct amdgpu_device *adev);
 
-int amdgpu_ras_error_query(struct amdgpu_device *adev,
+int amdgpu_ras_query_error_status(struct amdgpu_device *adev,
 		struct ras_query_if *info);
 
+int amdgpu_ras_reset_error_status(struct amdgpu_device *adev,
+		enum amdgpu_ras_block block);
+
 int amdgpu_ras_error_inject(struct amdgpu_device *adev,
 		struct ras_inject_if *info);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index c37139d2c487..015bd6c1c9cc 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -2121,8 +2121,8 @@ static const struct amdgpu_gfx_funcs gfx_v9_4_2_gfx_funcs = {
 	.query_ras_error_count = &gfx_v9_4_2_query_ras_error_count,
 	.reset_ras_error_count = &gfx_v9_4_2_reset_ras_error_count,
 	.query_ras_error_status = &gfx_v9_4_2_query_ras_error_status,
+	.reset_ras_error_status = &gfx_v9_4_2_reset_ras_error_status,
 	.enable_watchdog_timer = &gfx_v9_4_2_enable_watchdog_timer,
-	.query_sq_timeout_status = &gfx_v9_4_2_query_sq_timeout_status,
 };
 
 static int gfx_v9_0_gpu_early_init(struct amdgpu_device *adev)
@@ -3967,9 +3967,6 @@ static int gfx_v9_0_hw_init(void *handle)
 	if (adev->asic_type == CHIP_ALDEBARAN)
 		gfx_v9_4_2_set_power_brake_sequence(adev);
 
-	if (adev->gfx.funcs->enable_watchdog_timer)
-		adev->gfx.funcs->enable_watchdog_timer(adev);
-
 	return r;
 }
 
@@ -4733,14 +4730,13 @@ static int gfx_v9_0_ecc_late_init(void *handle)
 	if (r)
 		return r;
 
-	if (adev->gfx.funcs &&
-	    adev->gfx.funcs->reset_ras_error_count)
-		adev->gfx.funcs->reset_ras_error_count(adev);
-
 	r = amdgpu_gfx_ras_late_init(adev);
 	if (r)
 		return r;
 
+	if (adev->gfx.funcs->enable_watchdog_timer)
+		adev->gfx.funcs->enable_watchdog_timer(adev);
+
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c
index 44024ab93577..2e94998c9812 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c
@@ -79,6 +79,9 @@ static const struct soc15_reg_golden golden_settings_gc_9_4_2_alde[] = {
 	SOC15_REG_GOLDEN_VALUE(GC, 0, regTCI_CNTL_3, 0xff, 0x20),
 };
 
+static void gfx_v9_4_2_query_sq_timeout_status(struct amdgpu_device *adev);
+static void gfx_v9_4_2_reset_sq_timeout_status(struct amdgpu_device *adev);
+
 void gfx_v9_4_2_init_golden_registers(struct amdgpu_device *adev,
 				      uint32_t die_id)
 {
@@ -1055,8 +1058,6 @@ void gfx_v9_4_2_reset_ras_error_count(struct amdgpu_device *adev)
 
 	gfx_v9_4_2_query_sram_edc_count(adev, NULL, NULL);
 	gfx_v9_4_2_query_utc_edc_count(adev, NULL, NULL);
-	gfx_v9_4_2_reset_utc_err_status(adev);
-	gfx_v9_4_2_reset_ea_err_status(adev);
 }
 
 int gfx_v9_4_2_ras_error_inject(struct amdgpu_device *adev, void *inject_if)
@@ -1097,6 +1098,8 @@ static void gfx_v9_4_2_query_ea_err_status(struct amdgpu_device *adev)
 			if (reg_value)
 				dev_warn(adev->dev, "GCEA err detected at instance: %d, status: 0x%x!\n",
 						j, reg_value);
+			/* clear after read */
+			WREG32(SOC15_REG_ENTRY_OFFSET(gfx_v9_4_2_rdrsp_status_regs), 0x10);
 		}
 	}
 
@@ -1109,16 +1112,22 @@ static void gfx_v9_4_2_query_utc_err_status(struct amdgpu_device *adev)
 	uint32_t data;
 
 	data = RREG32_SOC15(GC, 0, regUTCL2_MEM_ECC_STATUS);
-	if (!data)
+	if (!data) {
 		dev_warn(adev->dev, "GFX UTCL2 Mem Ecc Status: 0x%x!\n", data);
+		WREG32_SOC15(GC, 0, regUTCL2_MEM_ECC_STATUS, 0x3);
+	}
 
 	data = RREG32_SOC15(GC, 0, regVML2_MEM_ECC_STATUS);
-	if (!data)
+	if (!data) {
 		dev_warn(adev->dev, "GFX VML2 Mem Ecc Status: 0x%x!\n", data);
+		WREG32_SOC15(GC, 0, regVML2_MEM_ECC_STATUS, 0x3);
+	}
 
 	data = RREG32_SOC15(GC, 0, regVML2_WALKER_MEM_ECC_STATUS);
-	if (!data)
+	if (!data) {
 		dev_warn(adev->dev, "GFX VML2 Walker Mem Ecc Status: 0x%x!\n", data);
+		WREG32_SOC15(GC, 0, regVML2_WALKER_MEM_ECC_STATUS, 0x3);
+	}
 }
 
 void gfx_v9_4_2_query_ras_error_status(struct amdgpu_device *adev)
@@ -1128,6 +1137,17 @@ void gfx_v9_4_2_query_ras_error_status(struct amdgpu_device *adev)
 
 	gfx_v9_4_2_query_ea_err_status(adev);
 	gfx_v9_4_2_query_utc_err_status(adev);
+	gfx_v9_4_2_query_sq_timeout_status(adev);
+}
+
+void gfx_v9_4_2_reset_ras_error_status(struct amdgpu_device *adev)
+{
+	if (!amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__GFX))
+		return;
+
+	gfx_v9_4_2_reset_utc_err_status(adev);
+	gfx_v9_4_2_reset_ea_err_status(adev);
+	gfx_v9_4_2_reset_sq_timeout_status(adev);
 }
 
 void gfx_v9_4_2_enable_watchdog_timer(struct amdgpu_device *adev)
@@ -1209,7 +1229,7 @@ static void gfx_v9_4_2_log_cu_timeout_status(struct amdgpu_device *adev,
 	}
 }
 
-void gfx_v9_4_2_query_sq_timeout_status(struct amdgpu_device *adev)
+static void gfx_v9_4_2_query_sq_timeout_status(struct amdgpu_device *adev)
 {
 	uint32_t se_idx, sh_idx, cu_idx;
 	uint32_t status;
@@ -1241,4 +1261,26 @@ void gfx_v9_4_2_query_sq_timeout_status(struct amdgpu_device *adev)
 	}
 	gfx_v9_4_2_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff);
 	mutex_unlock(&adev->grbm_idx_mutex);
+}
+
+static void gfx_v9_4_2_reset_sq_timeout_status(struct amdgpu_device *adev)
+{
+	uint32_t se_idx, sh_idx, cu_idx;
+
+	mutex_lock(&adev->grbm_idx_mutex);
+	for (se_idx = 0; se_idx < adev->gfx.config.max_shader_engines;
+	     se_idx++) {
+		for (sh_idx = 0; sh_idx < adev->gfx.config.max_sh_per_se;
+		     sh_idx++) {
+			for (cu_idx = 0;
+			     cu_idx < adev->gfx.config.max_cu_per_sh;
+			     cu_idx++) {
+				gfx_v9_4_2_select_se_sh(adev, se_idx, sh_idx,
+							cu_idx);
+				WREG32_SOC15(GC, 0, regSQ_TIMEOUT_STATUS, 0);
+			}
+		}
+	}
+	gfx_v9_4_2_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff);
+	mutex_unlock(&adev->grbm_idx_mutex);
 }
\ No newline at end of file
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.h b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.h
index e01fa6afa8e4..c143d178ef98 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.h
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.h
@@ -35,7 +35,6 @@ int gfx_v9_4_2_ras_error_inject(struct amdgpu_device *adev, void *inject_if);
 void gfx_v9_4_2_query_ras_error_status(struct amdgpu_device *adev);
 int gfx_v9_4_2_query_ras_error_count(struct amdgpu_device *adev,
 				   void *ras_error_status);
-
+void gfx_v9_4_2_reset_ras_error_status(struct amdgpu_device *adev);
 void gfx_v9_4_2_enable_watchdog_timer(struct amdgpu_device *adev);
-void gfx_v9_4_2_query_sq_timeout_status(struct amdgpu_device *adev);
 #endif /* __GFX_V9_4_2_H__ */
-- 
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
