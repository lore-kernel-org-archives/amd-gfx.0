Return-Path: <SRS0=BT7C=ID=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B5C5C433E6
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Mar 2021 14:35:56 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 044C464FD2
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Mar 2021 14:35:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 044C464FD2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AB3F66EB9E;
	Fri,  5 Mar 2021 14:35:54 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2078.outbound.protection.outlook.com [40.107.93.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9B05C6EB8F
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Mar 2021 14:35:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QZZY98JGtUbVB0nDsscdWPc5WMKQ0skxnaQMxn0181W1d8uumyaAXNYKuIEe+yNW6eRKxStJ1KIbeC82tMtaPpHgAcu6WTWqAVepB+zf7JclGr7g0KvvTpjNxUQ0j5UcvJwqHFj3vmtK33yJH9O7Mb2G8ypI1lf1e6TpzEUdDGyeXvGAl8JUXqCgaHvpMJEOTcFBY3fI1IZe4XNnYzdztkWuiI9IL0K1nOPnOB4he71ofpLA/7LWcTiVFW+ygfaFgfCzYNfnmiZ6gv4pWpLdH5Yi/E7bCRABFyijlw3vYejCxGE7Qpu7UAcpvr0xkp6yecVkqxF/6GKScevJhNkHfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ws1d5bNJWn3Cd9p2lvhX8eHXmmBlISmWDu7fjRVsoAQ=;
 b=CJBBKUvEAkoFUmfpDnGv0JV95qNWUFUqBXiJ3JBGQcp9ArdOnCXd2eEVHGdSKas+PRdGglQVXnNpCUvcIv1hRNLJwim9rJbEtInzZ6rpXCFGuY2pV3/SrNGeJaqihlmKcP3h9qIeDK35rnphMvqiZitcpEfRSObM7Q3UaPumL+9beEd4CPLKfKhkrRzXqXpm3jes0c3hwKOJ8L7aT1TgAZmVENR4r3dGMSZ+CS95Ixp1E7Fza864MI9r9Foga/2ob/uuEZC7ZqBfE+KRN8cU8lh9mEzIAymZCZRiZKs0pMEICzjtqGS5ScUrmdcbVbyhaD0NBWKmZM2eUlKChAmhpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ws1d5bNJWn3Cd9p2lvhX8eHXmmBlISmWDu7fjRVsoAQ=;
 b=Us2vgx2/YrqYgvawPleQuMrgUKTrr5WAdcQLypos6xX9i78DlOjJp04f2p0y7aypudb62K3wynhqQwuu6Zhpdu0sian/bM0vyjMK1XZi9dxICHl+rqcv8U8IbreZTjFTzBZ97hibIGdE3VIKN/7YKbVb00TmVTSZTK0hK4bAmzk=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from CY4PR12MB1463.namprd12.prod.outlook.com (2603:10b6:910:e::19)
 by CY4PR12MB1845.namprd12.prod.outlook.com (2603:10b6:903:126::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17; Fri, 5 Mar
 2021 14:35:49 +0000
Received: from CY4PR12MB1463.namprd12.prod.outlook.com
 ([fe80::6504:7fc4:d02f:77f2]) by CY4PR12MB1463.namprd12.prod.outlook.com
 ([fe80::6504:7fc4:d02f:77f2%3]) with mapi id 15.20.3890.030; Fri, 5 Mar 2021
 14:35:49 +0000
From: Nirmoy Das <nirmoy.das@amd.com>
To: Christian.Koenig@amd.com
Subject: [PATCH 2/5] drm/amdgpu: introduce struct amdgpu_bo_user
Date: Fri,  5 Mar 2021 15:35:29 +0100
Message-Id: <20210305143532.5936-2-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210305143532.5936-1-nirmoy.das@amd.com>
References: <20210305143532.5936-1-nirmoy.das@amd.com>
X-Originating-IP: [217.86.122.77]
X-ClientProxiedBy: AM0PR04CA0038.eurprd04.prod.outlook.com
 (2603:10a6:208:1::15) To CY4PR12MB1463.namprd12.prod.outlook.com
 (2603:10b6:910:e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from brihaspati.fritz.box (217.86.122.77) by
 AM0PR04CA0038.eurprd04.prod.outlook.com (2603:10a6:208:1::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3912.17 via Frontend Transport; Fri, 5 Mar 2021 14:35:48 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 44bb9a12-88d1-46a1-42ac-08d8dfe3f850
X-MS-TrafficTypeDiagnostic: CY4PR12MB1845:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR12MB1845B5C555217E27B43E1BEA8B969@CY4PR12MB1845.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tzp0G4QXmiajz0mG5J+8QzQdP0HDEmvCAY8o+TE1GCRTSDubjlwNk7GK3fZ51lQftff71jg6VYCAWkR4vlDW9I6l5j+vxNTs5tUVCNt2Mpvfe8kaBW9URCFQAoX735G9GFZDAQL+s1wq51gfKvlpZKZva/z81vY/D47AettGdGQo7HjsJD2w9ziux3eK8kPbL/gSjWBQrNKau4UstHFazXe6i57qZcTRu0A0lxCOGag25qw7Hg3MAfoDiRjHrHR6hUKcMRkk5ttdvL+jediCJgEiYsvGX6/aoG6Vom+xFsRG/teJ+rQfdAlqPHDow1nw2KyKuXSXz1eHLrMJoYc/6bjKQUgGR7m3WdqYe8Qyduf1NEZpL//B43PVbMybghiGfC8kmF+3UPqCOEVBSpzhOQRWqcSfaOwP/Dg69xbZQ2w6LDkbccT8prbIWhXrJ2VELM7wh4UmxZLZjYiTErmOz1ohjC3PeavqA1lSvcjUePV5sso9vnVtJVlU+1GAHpmhtYzoUUXn1MLJhtD3DSdSxA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1463.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(396003)(376002)(346002)(366004)(39860400002)(44832011)(8676002)(2616005)(6636002)(16526019)(6666004)(26005)(956004)(83380400001)(6512007)(4326008)(37006003)(66556008)(66946007)(186003)(5660300002)(6506007)(86362001)(8936002)(34206002)(6486002)(316002)(1076003)(52116002)(66476007)(2906002)(36756003)(478600001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?M54RfZLa2W6SiWveacwqZ6ePBaaKFNZma+a3hJvQ9IKhGBbbHxU1tnuz8ntL?=
 =?us-ascii?Q?JQTD3gmfxC4cvySu3p7pADhpo/tiOwipjFlAAEL4LOOTJgExFl17Gr0ySvwc?=
 =?us-ascii?Q?NsCJk5x4heokBHzhrfsiFN/gBupqGLtR0qqNtGFsdEXd2Svb8yie9vr2YWeR?=
 =?us-ascii?Q?8fChOU9wdnCBQQGkaSkVsS96NV+HLempn917H/MCAiSH9lW3yLFqDM5k3ThI?=
 =?us-ascii?Q?KTcAjqbJ6crfLpzPSFMVQzsQm4Ud7+yWNc8cD0taMx0JnHsPibgz/STTrwfS?=
 =?us-ascii?Q?xanJAPIcW+OAW0mZh4pbMNkioJDSFETHR5EEAP/I/zirlBF00DtDhnRgbIco?=
 =?us-ascii?Q?Q3vEIb2E3lWWY8d0+YMieinAgTJgku6K4/JmNMww9Wi1S24wFYOcNs+tp0d8?=
 =?us-ascii?Q?nfoxeo8iiGVSP0MfYnhfD0zgHZg8lXvCFrn0Vqpg2Q9FB4yFFbdmJi/Ukv66?=
 =?us-ascii?Q?rBy8rnlbXF8USPhFXE8Zo2nJiq1KsVdqQBGXyFWoZvqWabNjCtatBX+gGWZS?=
 =?us-ascii?Q?8fFUE76npx1KDn0UcgNeiaYo3PpBVpLgjqJME2OV6an64KsoP00wmGY2b8RW?=
 =?us-ascii?Q?xP+EnMPxk8S+2nlgr2wFMZkxnsjL8dilh6nE6KDYJmNOS/dErm7mVwjCSr0L?=
 =?us-ascii?Q?s30/PIf1LFG/BztKYObAEjLG1aerp1kCddoDbK8RNrVx23bwHQfJubfuypjV?=
 =?us-ascii?Q?WmXVHIprpeKpcDf7BnGsV+cexmwfG+otBg48/W9u2yl/COYqh+OZTIVvlXGC?=
 =?us-ascii?Q?I5iWXAd83ecE+4kwAb1Is0wRNdqOA1UNUyRA4hnGl3V4UXV95vA3+400KoZ3?=
 =?us-ascii?Q?CoxzanNsRT5jCOZQyVYv8zZeEXjTG/QJ+fUhEr7DamYTRg2JVaHpNC1x8fNl?=
 =?us-ascii?Q?aGQ59h1V4HE0IlCvnjB5yp4K/CTfQtZ1/ciy5ZMc/LX2k8WjPth1mw7QO469?=
 =?us-ascii?Q?qhaSFHRPxKTM3XxmvV+MXjR/IsOIJYXcUODKLQ/BZ6KWEjiBDNwiA9Bf6qJY?=
 =?us-ascii?Q?AxFqRiA/QefYyCX9Y3KUOX31Z0Yy98r/+nT4pSkdTyGIpoyGbWksdl8EKcgW?=
 =?us-ascii?Q?j8Vi28xLEIWew/mV5OuKeGWOgSX61pLFOiM3Hbae6255dkIqzBaGTEmt0WOX?=
 =?us-ascii?Q?jAHnHoWswnTbvVJOa9GCQS/p7SkeLL0pKT9rgNmzYE16q/DuCkeWe9ANsKbm?=
 =?us-ascii?Q?wBbbokNZWU+75YIeUR/8D3NE+1WWVakqgKh+o2NVXSVId3AOqdTlISnTU2D9?=
 =?us-ascii?Q?WGSQjWmeoXwHYtGopmgtjcl1PQOE2efBZjYhltTocM91ChABZs++5/UJ4yEG?=
 =?us-ascii?Q?zGBcT6/4JC4hEvnoABPynmmb?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44bb9a12-88d1-46a1-42ac-08d8dfe3f850
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1463.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2021 14:35:49.2653 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qiypYslUdwy6iOvRNSImNy2em2VVO7KBmPk4oINApNEo7bcdATZEttKIZImuugZkUx6XHKIX/yNVvBdFPP+JTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1845
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
Cc: Nirmoy Das <nirmoy.das@amd.com>, amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Implement a new struct amdgpu_bo_user as subclass of
struct amdgpu_bo and a function to created amdgpu_bo_user
bo with a flag to identify the owner.

Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 28 ++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.h | 12 ++++++++++
 2 files changed, 40 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index 745393472564..355d01ebce51 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -699,6 +699,34 @@ int amdgpu_bo_create(struct amdgpu_device *adev,
 	return r;
 }
 
+/**
+ * amdgpu_bo_create_user - create an &amdgpu_bo_user buffer object
+ * @adev: amdgpu device object
+ * @bp: parameters to be used for the buffer object
+ * @ubo_ptr: pointer to the buffer object pointer
+ *
+ * Create a BO to be used by user application;
+ *
+ * Returns:
+ * 0 for success or a negative error code on failure.
+ */
+
+int amdgpu_bo_create_user(struct amdgpu_device *adev,
+		     struct amdgpu_bo_param *bp,
+		     struct amdgpu_bo_user **ubo_ptr)
+{
+	struct amdgpu_bo *bo_ptr;
+	int r;
+
+	bp->flags = bp->flags & ~AMDGPU_GEM_CREATE_SHADOW;
+	bp->bo_ptr_size = sizeof(struct amdgpu_bo_user);
+	r = amdgpu_bo_do_create(adev, bp, &bo_ptr);
+	if (r)
+		return r;
+
+	*ubo_ptr = (struct amdgpu_bo_user *)bo_ptr;
+	return r;
+}
 /**
  * amdgpu_bo_validate - validate an &amdgpu_bo buffer object
  * @bo: pointer to the buffer object
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
index 848dc0a017dd..cbb881afe6da 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
@@ -114,6 +114,15 @@ struct amdgpu_bo {
 	struct kgd_mem                  *kfd_bo;
 };
 
+struct amdgpu_bo_user {
+	struct amdgpu_bo		bo;
+	u64				tiling_flags;
+	u64				metadata_flags;
+	void				*metadata;
+	u32				metadata_size;
+
+};
+
 static inline struct amdgpu_bo *ttm_to_amdgpu_bo(struct ttm_buffer_object *tbo)
 {
 	return container_of(tbo, struct amdgpu_bo, tbo);
@@ -257,6 +266,9 @@ int amdgpu_bo_create_kernel(struct amdgpu_device *adev,
 int amdgpu_bo_create_kernel_at(struct amdgpu_device *adev,
 			       uint64_t offset, uint64_t size, uint32_t domain,
 			       struct amdgpu_bo **bo_ptr, void **cpu_addr);
+int amdgpu_bo_create_user(struct amdgpu_device *adev,
+		     struct amdgpu_bo_param *bp,
+		     struct amdgpu_bo_user **ubo_ptr);
 void amdgpu_bo_free_kernel(struct amdgpu_bo **bo, u64 *gpu_addr,
 			   void **cpu_addr);
 int amdgpu_bo_kmap(struct amdgpu_bo *bo, void **ptr);
-- 
2.30.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
