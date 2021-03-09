Return-Path: <SRS0=7mEa=IH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4220DC432C3
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Mar 2021 08:47:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EECB765266
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Mar 2021 08:47:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EECB765266
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3424088071;
	Tue,  9 Mar 2021 08:47:15 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5684E6E8B4
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Mar 2021 08:47:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T0elT/hqQ4j1yh/MlyAFciO2ZMJqC/oF4rE7fSdbcXRN8KifGs3rUFPkIphryTo1Jz3rrEeJVcdexsz5kVo5Hflb8/42PEdXct2Jxz669L8DEIwfW38SCVxC2cZIiPOjvD4iRCa2JrSJF2QK0vGnPaRIEjlp1B1A4T7IoSxjLp3FplD92EYTpEEsACY13Qx2UNKW9M0Et19U5+dF6mHPApWFVrWdwZVGcInXuQ9Tdac5x8jqU0p6otwwdo26rttG0wElmO4N0zzU8OlmFs1591inM7Sijkkeg+JqqXdH9WG2esSobO+FihPcqfROjNTfKQxDKTFqdN5kclyMQzuMIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t11/oh4lF+QZnZlhVMVlNQnlNpVmKuc8yQw9+04WfWE=;
 b=KKVw4v8eQrMr0qyesNKToYRKPmvYUFaJKzYeXRZ9oaGDEm8CbSFaauiHBhek57PP9xRYvRmbooL2WdUi99K59ViPrRVmfxJMrvMHeziDZfKuzzOM6xMXOrW3bFyAq/g4lfsZw65uYJ19luZ5bYzIwYupg/T12gVchb9zKPlX5LeLPGq2AXX55lBUdYoLMhwo4juzrkbrxwrvhj/iHSm5u1zodjmSatx7u7XtVoet2eDz03zOZqoROBI4GFJILtVa+ZaFsNazcJdM9LOtGmalqyPewIZggaLUFCN7k28yKypMjzdogFBjV7LdL4As559bRr9IbDDr32OO2NFVYNbvGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t11/oh4lF+QZnZlhVMVlNQnlNpVmKuc8yQw9+04WfWE=;
 b=WKaKEZGbQPfX6y19FGCAZf6pcqa9QLu3RBUbHiArmbs2H+q7lhG6FY+ZN81KMIMPdbPeX8MO7t6CLvtlsM7JGEkHm4VBOYId4lG1itAqMuxNZ7p63TIkFzUmCXU5h8Bf18wPojL7A+zquQn2eg5Nhb7q9mPAJqPJP0WfmoYh7Mo=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BN6PR12MB1459.namprd12.prod.outlook.com (2603:10b6:405:e::8) by
 BN6PR12MB1377.namprd12.prod.outlook.com (2603:10b6:404:1c::22) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3912.17; Tue, 9 Mar 2021 08:47:12 +0000
Received: from BN6PR12MB1459.namprd12.prod.outlook.com
 ([fe80::21cc:170a:9889:4460]) by BN6PR12MB1459.namprd12.prod.outlook.com
 ([fe80::21cc:170a:9889:4460%3]) with mapi id 15.20.3912.027; Tue, 9 Mar 2021
 08:47:12 +0000
From: Nirmoy Das <nirmoy.das@amd.com>
To: Christian.Koenig@amd.com
Subject: [PATCH v2 2/5] drm/amdgpu: introduce struct amdgpu_bo_user
Date: Tue,  9 Mar 2021 09:46:56 +0100
Message-Id: <20210309084659.37649-2-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210309084659.37649-1-nirmoy.das@amd.com>
References: <20210309084659.37649-1-nirmoy.das@amd.com>
X-Originating-IP: [217.86.127.127]
X-ClientProxiedBy: AM9P193CA0028.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:20b:21e::33) To BN6PR12MB1459.namprd12.prod.outlook.com
 (2603:10b6:405:e::8)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from brihaspati.fritz.box (217.86.127.127) by
 AM9P193CA0028.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:21e::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3912.17 via Frontend Transport; Tue, 9 Mar 2021 08:47:11 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c569ddd2-c97b-43a7-7e21-08d8e2d7ee79
X-MS-TrafficTypeDiagnostic: BN6PR12MB1377:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN6PR12MB13778CA5772EE8B15F6FB81C8B929@BN6PR12MB1377.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PZCpsgSjjM+1cEbWsECAWbNA+hNtK84gAZA8OVMB9WZRuPbYFgD5Tujs5g2UxD8YohRSAZLBU8wb35An1FjKT0Ygm1xYdHKys/jJKeUpzjGuxgNTWvYvsehJfYo5ZuJtekNRUIpw3wGYtMAHMfw8WhVda7S0mg+PIWNdAAy1jmUsvBm2fPUQ5+1ZXNqAP6VAiEXlf07/F1+4NZixy6eOA4aR0JNVC88nve+8aXZ/jpO6p60WkA2acanh8Lve4vWkl5Shv8eDLReuZf25PBnAW2G4x6oLiq12MiWzyqhnBrPztNFaJmRjvmHO8nN1tMJ4fhmy8ch6CCEu+ECLL13rbdObuH7uogaZKSwO9ywAHF6VjXyA/VczqM1vGxL0Gx8YYBa+A777ZbwM1/3sBPySSRsZafz2zPRKAljgnz7kT1TDi/scxE1oYFYyPPh+GeCDLIss3qXyhiU60NUmucMPerNPiQTTULVO7au7Y59ghqQYEpaamGGnhKs0XwqU6VWr4OupQFZJEZ3GU/od52Dw6A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN6PR12MB1459.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(136003)(376002)(346002)(366004)(66946007)(6666004)(2906002)(83380400001)(316002)(4326008)(6506007)(36756003)(956004)(478600001)(8936002)(5660300002)(44832011)(37006003)(1076003)(52116002)(8676002)(6636002)(34206002)(66476007)(6486002)(66556008)(26005)(6512007)(186003)(86362001)(2616005)(16526019);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?l7VoRRPTseyN1DW3UWiJiZXfDY4Q7YYNfm6HmkKvRbt9CoBbIsL5Nebpka5/?=
 =?us-ascii?Q?ff7lyB0A7QqfZSgQqVMr1hzqiqxDPwWppXA60YyXG7tCLVAr0f7P5lB4Lonr?=
 =?us-ascii?Q?Zs/x/qAiT+BgNLvSgYlXHme5z43lKXdT+rXmhtlcqG1BPfJ2cuQ4D9Ra4lWt?=
 =?us-ascii?Q?83vx/4wUS9TF7A+iPz4lShi9V7ttk3KxVw8AT/4oBdh+GnmAGVhzjI8KC+xj?=
 =?us-ascii?Q?bqqtZfLgKTw9Z4VuBra3eqvjzejPKoXAFVLXLP6OfcYY4za8SBQ+4lkmZd2X?=
 =?us-ascii?Q?QsWHLLhSYRU6rBNtl4b7d2wfbnxq46tQeyeJC6LSbBL9bKRycVI+7kfNju2p?=
 =?us-ascii?Q?1Fwi9JyudKI00gdlzu7cVuLqvJPXa6s4oznfQSeayanY1j7RgumKHtKYCWed?=
 =?us-ascii?Q?1DUR1Ap8oq14BS16orFevEEMz8lyq6Wi3GsC1fq3ZjZRuuurXa94IkeP9iAm?=
 =?us-ascii?Q?J61lD+0b4/UQRDHNo53aU3vfdnHnRDAHqROskdtxgtvWUJp2T4Mvn52nfwhV?=
 =?us-ascii?Q?g7F1OS48z2DMqzI65Fm3NUNPfId62Le2mmnReXAWwD2pZVbZvSc2tpQ0ZDcS?=
 =?us-ascii?Q?qgRB80pFliMBWqo9EakCdOCFdvWk04DNML3V8GacemvD1s6meBwbIGR0akYB?=
 =?us-ascii?Q?gQ4pzFsOf794mNxOMA2vYKaruM9+ozPDe0JQuVQb487mrzrPKOhPs2SJFIsL?=
 =?us-ascii?Q?PpXPxLF5I8XnoncW7hLHn7XmNv9s2R1NyBdZad4uXak9JrjB1SNqNAl0Fp4F?=
 =?us-ascii?Q?ApcBWErqIjRYf9uNfD6iimWmL5RJg0Btf3/MouWnluKNtBeYREoFlAldVOrg?=
 =?us-ascii?Q?6zFsbqa6jd1oQPYDlQS5UtCio12gjcVsmikJQ/Y9P81BgkMzS7mGNokFkHXB?=
 =?us-ascii?Q?esXF0qCYpDwcrf/ESDS90Kh8JjJFifSvm3rkRepF+0FpKpXAhtRD/0jo/dNr?=
 =?us-ascii?Q?fPKfPLfH4vMjwjsXfg1olbPHim7aCooXk0YRwNnebG8ER5372N/Q2GvO3kj1?=
 =?us-ascii?Q?SicX8y53SqcNM9lgH4fDpJJKWIQs6Wu7l5txZ81LuETvGztcpxWcHJoIZB6Z?=
 =?us-ascii?Q?Dm0yY3in3HqKjiFfkaUj7CzlsiBLbciF8j5Sgpe+O6yIAVIsiKCrDpzaHfcd?=
 =?us-ascii?Q?m4eYvmGxnJrgyZvfzmSXoTEAFRTz2DpRDh8XFBKpxqN5RSz9WZp3+eeatOdp?=
 =?us-ascii?Q?Y0C0r7xmZf9d3vL6RrlkOqkvRPUlKI7CEbvB3QyaYgpqdXJ3QSxBFY4fxiJl?=
 =?us-ascii?Q?qrcHq5p+4VggGyZko6e6/ZoMPuEjJrEZv6kVSA4xg43YmnKGZe1NJo5VqsnH?=
 =?us-ascii?Q?0UoIL6bLZAnBd1mL0zAjDdy9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c569ddd2-c97b-43a7-7e21-08d8e2d7ee79
X-MS-Exchange-CrossTenant-AuthSource: BN6PR12MB1459.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2021 08:47:12.1649 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gU779xxXlk+CqBlqsVnND1mRrZHIZip/BNfMRJwefYFMjQ6OvWB9AQpCSGedUBjbMg6HADAJyY8TxGxJCL/SWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1377
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

v2: amdgpu_bo_to_amdgpu_bo_user -> to_amdgpu_bo_user()

Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 28 ++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.h | 14 +++++++++++
 2 files changed, 42 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index c30f10f931fc..bd89d44a1f2f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -694,6 +694,34 @@ int amdgpu_bo_create(struct amdgpu_device *adev,
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
+			  struct amdgpu_bo_param *bp,
+			  struct amdgpu_bo_user **ubo_ptr)
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
+	*ubo_ptr = to_amdgpu_bo_user(bo_ptr);
+	return r;
+}
 /**
  * amdgpu_bo_validate - validate an &amdgpu_bo buffer object
  * @bo: pointer to the buffer object
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
index 8e2b556f0b7b..06b6fa35db99 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
@@ -37,6 +37,8 @@
 #define AMDGPU_BO_INVALID_OFFSET	LONG_MAX
 #define AMDGPU_BO_MAX_PLACEMENTS	3

+#define to_amdgpu_bo_user(abo) container_of((abo), struct amdgpu_bo_user, bo)
+
 struct amdgpu_bo_param {
 	unsigned long			size;
 	int				byte_align;
@@ -112,6 +114,15 @@ struct amdgpu_bo {
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
@@ -255,6 +266,9 @@ int amdgpu_bo_create_kernel(struct amdgpu_device *adev,
 int amdgpu_bo_create_kernel_at(struct amdgpu_device *adev,
 			       uint64_t offset, uint64_t size, uint32_t domain,
 			       struct amdgpu_bo **bo_ptr, void **cpu_addr);
+int amdgpu_bo_create_user(struct amdgpu_device *adev,
+			  struct amdgpu_bo_param *bp,
+			  struct amdgpu_bo_user **ubo_ptr);
 void amdgpu_bo_free_kernel(struct amdgpu_bo **bo, u64 *gpu_addr,
 			   void **cpu_addr);
 int amdgpu_bo_kmap(struct amdgpu_bo *bo, void **ptr);
--
2.30.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
