Return-Path: <SRS0=BT7C=ID=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EDF7C433DB
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Mar 2021 14:35:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C7F364F11
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Mar 2021 14:35:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C7F364F11
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A588F6EB8F;
	Fri,  5 Mar 2021 14:35:53 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2078.outbound.protection.outlook.com [40.107.93.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E8D736EB8F
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Mar 2021 14:35:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XKVOAtcM5vuR3OgkdPTFQyFXwGBUSj5vWG2w11q17zSkoQA8GtSfWgAXoIZ8czuCO/mt77aVz1DLr08b8++nRexIHEet6VSy9jpzPGZPF1mcIb5dXM4l+SUxoDpV+QYSr5VSQvGA+0208PD7IobqAyPtMCFUAaVUwlM7Y7WxIQ9bgWpXANajS7dEjebzbzKt9NhBRNbUlFMmwp28akuzYTYBapsShacOlF9j1P1lIpd07z4UqMnDNHzW7Vv57MetKl6OAyl45RyppeD6KoE4XyCkVK2tsf3b8aR+0N53BC+dMzHYfY8x1czxtGA1Kdbtvena0JtTDMY8aLnO33ourQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3zvPloFErzojU3puHWynwFCdkhZtMR4H1+eDOn/KPTo=;
 b=Lv8diVMYjzX9uLTFDFSqZ7N3MMhShbNTsBz+HzeLavZbXx5d8MfqdsoU7FjQw5sZf+kTkTh0larjBZGIajJWCL6VTabYvFG1Qf4yHf+hb7OziTkEBgwmQL5dZvvNgWPmugFdAckPmhquQTfKnK8Xnxbf0uS0TooRs/kRrZ0byX85Bg8GgiAXQQL3JkS3kaRVQ4RUjawLNEmxZb+ffa1fv7PE/MtAA8/3+TbrvuKCls1vj1mPPHgqdjVEsnh5He5KbLIUsoq8BYSw2/FB5Ux1MZQJibmhh1rGx0lvc0WJXr/9SNoc285GYq54dxkAKMXP2WxkbUG4u4t9bzOULhVzDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3zvPloFErzojU3puHWynwFCdkhZtMR4H1+eDOn/KPTo=;
 b=pTzeDk1NULXYYABBvSfCxQh446inLKSQI3KOxKlkCHLD2DsMQcQeHxmJ+brMfHcLU7fHooLwixz7TfTDcaY0vmX7O4yV/r/hU9eycCGHjfkgz0SoBDcHdM6QWYTV5GVuKL5aNnl5rV2VrRff2inChEG0OjApzCXPfq7NqA07KkM=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from CY4PR12MB1463.namprd12.prod.outlook.com (2603:10b6:910:e::19)
 by CY4PR12MB1845.namprd12.prod.outlook.com (2603:10b6:903:126::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17; Fri, 5 Mar
 2021 14:35:52 +0000
Received: from CY4PR12MB1463.namprd12.prod.outlook.com
 ([fe80::6504:7fc4:d02f:77f2]) by CY4PR12MB1463.namprd12.prod.outlook.com
 ([fe80::6504:7fc4:d02f:77f2%3]) with mapi id 15.20.3890.030; Fri, 5 Mar 2021
 14:35:52 +0000
From: Nirmoy Das <nirmoy.das@amd.com>
To: Christian.Koenig@amd.com
Subject: [PATCH 4/5] drm/amdgpu: use tiling_flags of struct amdgpu_bo_user
Date: Fri,  5 Mar 2021 15:35:31 +0100
Message-Id: <20210305143532.5936-4-nirmoy.das@amd.com>
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
 15.20.3912.17 via Frontend Transport; Fri, 5 Mar 2021 14:35:51 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 71dc5ae9-9c6a-423e-425c-08d8dfe3f9f1
X-MS-TrafficTypeDiagnostic: CY4PR12MB1845:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR12MB1845FC8213CD0BC2A811B3958B969@CY4PR12MB1845.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6sdTn5nGGYfltp/a4TuB00IpgQOSEj+4wf7+uKFKytmfwh/R9+LU4DmujzCy31rQD1znYVzIoC1/tztw9dZtiaF3iYUSYxvIHg6x/S7NX9IZPcj9GzQwseZNUbHcwKdYMjqKGs17C/mSHSv4GPaQAEov5tiTf0YFMYYiyEYvNxhVMPeJoUVsJhCieEInwAdTXYxEtoYPz/c2ApvsRpxLqpPg1ngBNA5PLGVteVtgJZU9oDwyOZe9QGAm/jcTLD28xQclSkD3CmeVlDpxb7f34K5J3wZhXLKfda9fi7LjKaKpqOYJlIfyfeCuO94KH8HbahkUjI4RWTYBnkbUvDCO2G6khd29qYJaIsPM0/1j6pWBwk6P0Zi9pv0ofTM3tjLdGMSAKbIA414X5jhoGKOp83gJMPOnHg00QEq0AKqBFjXgCh5a00odShdpX3M7OLfgqRov1RDXHXbDi+E7lawUWQ/SVl02aTv7yvpE6E3hqFUV1JX4hG7FzG7K+El1FwsbOxuyHIRnsJ2SZSQWunQ+RA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1463.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(396003)(376002)(346002)(366004)(39860400002)(44832011)(8676002)(2616005)(6636002)(16526019)(6666004)(26005)(956004)(83380400001)(6512007)(4326008)(37006003)(66556008)(66946007)(186003)(5660300002)(6506007)(86362001)(8936002)(34206002)(6486002)(316002)(1076003)(52116002)(66476007)(2906002)(36756003)(478600001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?n22B9e4lAh1Dm0ECfTQf6qYljthLFxm0fpGZ6HSjokYRL5V3yfak32zaMj2t?=
 =?us-ascii?Q?SWgEv2yTvk6QH0nmU6eOd/OarNXLX5tacDRu2b+9GIKcL1lhCVVbcgFU3oMb?=
 =?us-ascii?Q?3XMRRyU6BPY0YX7OBlofNUq50atpolnYRjyLS0s9y8olGpyAQLZgDXqlPqas?=
 =?us-ascii?Q?xxdAVB7eMMkNPXtGAeSun33T+2hLpIZZD5nvISnuSPv9u+sv1ZbWFJY6DDX1?=
 =?us-ascii?Q?j49/O8K4Bmx8vnrmXkP2nIHwPbI+VRKdc3AAS5xZTXllEedq4gJ+mapwSAyZ?=
 =?us-ascii?Q?04QzUcJ4TATiFEjUGX8IP7yj0zBxxdkuR5iyQ1S7MN/+2naShSWU38906C2a?=
 =?us-ascii?Q?k+1NTb5T4QhmrQr+JVZgs228wXANEkIEUNTwhM8g+XSNBoW9Z+oAGcvsXYQp?=
 =?us-ascii?Q?ULUz/svwcvDkMcErx6T/7f5lCWo9VpD6sxkwGLP7Cx4a+HkG0NmtonZPIIVq?=
 =?us-ascii?Q?yl2DhXKCe9s3K4IW/7/kn/JJykB6deJMLLGnDK+WdFhA609oxnCVtF8ShEwj?=
 =?us-ascii?Q?upgJ52NwA+lCPeKiid9SP7IllnjfiOjzjVNONJywoD7cl/c8FFEd5/C5UKE2?=
 =?us-ascii?Q?a85625rqw6shfv56guZUsIrwuhABPSZNVR0GZX3FqOacqv5blYiAoe3E3T5Y?=
 =?us-ascii?Q?qLwbq4EmWPhLcELre1godqi32d44Nza8kFye3UMx3dvIIFTp+CpoAXM9pxva?=
 =?us-ascii?Q?h4Qbye5jC+IjFGqm+e0JaHS0Z+Z8zIsD4jRN7JDffSdo95wmwEBrgE9+fjxR?=
 =?us-ascii?Q?L/pUloBLGWOpB3lwcaFAP/TyAsQh5gNEi4dNmw3kxNjzwjxJ973ka2fjgaV/?=
 =?us-ascii?Q?EZWVF8mOBlM1bOHbCtA9QonxcH94W7AsuBV6a6fwSjjgnrggsoCMTVqebrcc?=
 =?us-ascii?Q?j6x7JQjsMtEkhP2oJLU4XBGMDygNlpl0CmFAi/LDPp81m4RxZ+2uJsAZtTkq?=
 =?us-ascii?Q?z/leQlPoTlWQBnlDKk/HNcVOzCriSPypFIE3zIKrgX+1TDOXgfhyIbk8xchm?=
 =?us-ascii?Q?wlQFzhczfo8UKTWM8BIU6/kiz4rLQ0gc+oAuFlTSMA8rC/8hOo+hKxqg2jWk?=
 =?us-ascii?Q?siWXQG4y4GP43fJGJbIy6AXRl3z5zt1tCDZsuzhLQSzwtrbt+3dSpLnPpSks?=
 =?us-ascii?Q?2rlSLwsKrFehj/WCvAncc6c6NRuvqycbrHA+gZtpUjS05PXrmsCP6vRmMATz?=
 =?us-ascii?Q?S1umB87UcdbMlm7dtGVBOPxLSLQTqzBQc3/Kwa5JNTJvzoIMEPXq/ynVroWL?=
 =?us-ascii?Q?IwUUEnULcg4vyfXxT4iTre4tVjbZiR9EDFvEfGKlHVnugIuk7CYyqtgNqYoM?=
 =?us-ascii?Q?eaqgRyLUw/zEbZD4zhRBaNlF?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71dc5ae9-9c6a-423e-425c-08d8dfe3f9f1
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1463.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2021 14:35:51.8272 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OARfLUL3gdL9AO5JTP/m+C/IDLGbJdbQ8l3120NHCcBs/95M2uDfbEJXF0wevMNyS25knieiZsiVZf0fTWH6Sw==
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

This flag is only needed for BOs created by amdgpu_gem_object_create(),
so we can remove tiling_flags from the base class.

Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 19 +++++++++++++++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.h |  1 -
 2 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index 355d01ebce51..2e5cf46251af 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -1174,12 +1174,19 @@ int amdgpu_bo_fbdev_mmap(struct amdgpu_bo *bo,
 int amdgpu_bo_set_tiling_flags(struct amdgpu_bo *bo, u64 tiling_flags)
 {
 	struct amdgpu_device *adev = amdgpu_ttm_adev(bo->tbo.bdev);
+	struct amdgpu_bo_user *ubo;
+
+	if (bo->tbo.type != ttm_bo_type_device) {
+		DRM_ERROR("can not set tiling_flags for a non-amdgpu_bo_user type BO\n");
+		return -EINVAL;
+	}
 
 	if (adev->family <= AMDGPU_FAMILY_CZ &&
 	    AMDGPU_TILING_GET(tiling_flags, TILE_SPLIT) > 6)
 		return -EINVAL;
 
-	bo->tiling_flags = tiling_flags;
+	ubo = container_of((bo), struct amdgpu_bo_user, bo);
+	ubo->tiling_flags = tiling_flags;
 	return 0;
 }
 
@@ -1193,10 +1200,18 @@ int amdgpu_bo_set_tiling_flags(struct amdgpu_bo *bo, u64 tiling_flags)
  */
 void amdgpu_bo_get_tiling_flags(struct amdgpu_bo *bo, u64 *tiling_flags)
 {
+	struct amdgpu_bo_user *ubo;
+
+	if (bo->tbo.type != ttm_bo_type_device) {
+		DRM_ERROR("can not get tiling_flags for a non-amdgpu_bo_user type BO\n");
+		return;
+	}
+
 	dma_resv_assert_held(bo->tbo.base.resv);
+	ubo = container_of((bo), struct amdgpu_bo_user, bo);
 
 	if (tiling_flags)
-		*tiling_flags = bo->tiling_flags;
+		*tiling_flags = ubo->tiling_flags;
 }
 
 /**
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
index cbb881afe6da..6cc38b71f7ca 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
@@ -91,7 +91,6 @@ struct amdgpu_bo {
 	struct ttm_bo_kmap_obj		kmap;
 	u64				flags;
 	unsigned			pin_count;
-	u64				tiling_flags;
 	u64				metadata_flags;
 	void				*metadata;
 	u32				metadata_size;
-- 
2.30.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
