Return-Path: <SRS0=BT7C=ID=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40767C433E0
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Mar 2021 17:52:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E86A764F67
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Mar 2021 17:52:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E86A764F67
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A92186E222;
	Fri,  5 Mar 2021 17:52:31 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2088.outbound.protection.outlook.com [40.107.93.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 72F326E222
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Mar 2021 17:52:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kAoybSsKJyWJira/CMugdiUZlmtM6+jZVYwidcMhRj9NBH8uQIYHIb4ZUJ2eg1sasfpfO1uJaE+nw4HrwY9foN8QFlJlSU0YnLfkwWKG3dgYMTvNyuADcMR+ve/gVLWW+duoRCN2uVCIivDoyNd/l9z/ZHKyA/WVXdUp6PoawMCBmisVLslnzjPY/szYjsdswucRz1lUwK1ssOMh00GjYweW5J5um1B4mtyCxUJ8lQywyGeYxIbopIsMm6uKDUS9k4BYK4X06i7bDoyZwV5/B7XAzvG0pVMbB6Jfa5K0JzRcD70CSQtccYZNB8W0JxlfpLGoybEuDCHjyvHydH+Whw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x070ftZxWjeVLsWlWllRs7uZiMyiPa0J2BaRIZBC624=;
 b=m/+0khKvf1cWknJU7TqEC1E69uON8qXSML9tz5nWVAw4dCCVARH5XVobs0QpFFM11l0QT+gOfP5xcr1NtxnMDgXitJlrYK2FrCzIURltJpmx2K2VSkMSK1i5rzqoexKEp62BYMcgePg8E+fOQ9C35vO3niRQfwN6WN+1sylWUUmzp7G2Xlld8nGkRuEhOXzq3OsqJ5ww6h5A8R97poDJuFUrS7WSB5FLntuEmOQvPVlu8+n6mib6z3ODjQNiQy8gI3ZkRYbsK1Uim8j6wCm+JxoyjHl3Vy80RRopKgUBZyEOA3YL1PDiFIHy6LfGU86xilH04j35EQP+SoQ2489bIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x070ftZxWjeVLsWlWllRs7uZiMyiPa0J2BaRIZBC624=;
 b=wZg46GvLWWb62iWywJej8Vxof08Pqnnr8SVYdnSIEEh01LGC3dexc45bsJ1UTWLVpa6CYqybeannbOxWBG67GxOf+3g/J4k9lZi3CQBvS1GAQ3vVrnFjlzhFfkWSlgYgEMsM47GDxvDHrjYHVU7jzQg1gH26ZoIinWxonu+X2GU=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3835.namprd12.prod.outlook.com (2603:10b6:5:1c7::12)
 by DM5PR12MB1754.namprd12.prod.outlook.com (2603:10b6:3:10f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.20; Fri, 5 Mar
 2021 17:52:27 +0000
Received: from DM6PR12MB3835.namprd12.prod.outlook.com
 ([fe80::102:2c9a:54ce:63e9]) by DM6PR12MB3835.namprd12.prod.outlook.com
 ([fe80::102:2c9a:54ce:63e9%6]) with mapi id 15.20.3912.025; Fri, 5 Mar 2021
 17:52:26 +0000
From: shaoyunl <shaoyun.liu@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 3/5] drm/amdgpu: Init the cp MQD if it's not be initialized
 before
Date: Fri,  5 Mar 2021 12:52:14 -0500
Message-Id: <20210305175214.32118-1-shaoyun.liu@amd.com>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.250]
X-ClientProxiedBy: YTOPR0101CA0038.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::15) To DM6PR12MB3835.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from shaoyunl-dev1.amd.com (165.204.55.250) by
 YTOPR0101CA0038.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:14::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend
 Transport; Fri, 5 Mar 2021 17:52:26 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7b9ddc10-0ee4-4fcd-b60d-08d8dfff703f
X-MS-TrafficTypeDiagnostic: DM5PR12MB1754:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1754C7FDBE1DF2271B456594F4969@DM5PR12MB1754.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C/XM6HpbddbiC0hrrTazgAdwJXcwo0fSCSlpTKPUpFeC/iCacLMvm4SP1iDZKvf8Z/+r5dZ965QLXi5A2AlLEMArCzb7I11evNaNkqCS8+MEbjzT/+4dSUMD3ftqz2hNgnsXvdbLZDYQb1EGa1Tpi84Kfvh6ZJ/vZR1PWfif3EbrPrKD/BMYuSCPjuGAYHEF4OZHE+gFnNxdf75AdW9SYfSimwLDJ15EkAubx/jGIjK8LSdHduUcgCP/2gumeZZi/CXYAsRbEek+MmME4IPLkau87LjASkLc6z968MY8rktvhRGUj1FHO12lGxQdKSDm7s8YaaQEI/vRehBCXHIJwIfHSLXfpA+CP5pa2GshBRK7uhXjYobIcsqYTG+08C9shW98l1G3ujChOGEPa2twRlFY4Sttky24SIyr3EGAaILf+9XF67CKtnEUpaq1vXz/rNsgXUh3kkEUgMNUz20HL+HkzjrvFJgTR56yiduvDLF27ytLTsDGHaM3y3+/Abpz9qMLZnWNN/zUwPvlIQATHUqp5X4CCHOThv4v8GG5YZLcffTQQx3bjhoS93hi2ivx
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3835.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(376002)(366004)(346002)(136003)(7696005)(52116002)(26005)(2906002)(316002)(8676002)(8936002)(86362001)(478600001)(4326008)(2616005)(16526019)(186003)(956004)(6666004)(83380400001)(6916009)(6486002)(36756003)(66946007)(66476007)(5660300002)(66556008)(1076003)(43062004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?BBZT6b/Qizvua6VKiO0RLi8UYxBAPJO/KEhAfmeOx9QTJ5TdXKM5PJ8PzYWB?=
 =?us-ascii?Q?xeVV1itu64+AF1skDl6lpGMEgB14WZbq0IwvgggLbyhmW1L8ICATitN2ypvu?=
 =?us-ascii?Q?NWnPN5AbtmPeB+tId4FUW9A8cda8FNB2L7nH4+Yfs0cAAJXv3sYsltWCpvAZ?=
 =?us-ascii?Q?jNxoThAn0J9+LZn8eA2bTdjADAE3QWwmj5fViHqWGm0OLF3BHG8RpTL37ttX?=
 =?us-ascii?Q?3v7gGdOmH5D+PZYM9rSzWl8hfqLbxQaGOniTtGqX7htWhqFwYWl/HeLesJzC?=
 =?us-ascii?Q?7hyi3YuOp/lH1zd/HP3ZDAuh4/E0GgSau8EMFhqZUPQUpD6n6gPa7+GDmVld?=
 =?us-ascii?Q?+EkwfjbveSs/tEtUQ7TjVOul+eWpzYOy4iE45esEapSNPWBtpWx6nRMpS3Ap?=
 =?us-ascii?Q?pYUXtnEn6KJq8UpuaVQWPzdfZs4pb3CfSeuWf37V5d5eQWaM4zziSSON2CBW?=
 =?us-ascii?Q?+nzCp3wKr2vXYIhSJyUDoRP40IfaizfKmDWDIirmZc2F2bu+KzQzmolOWU/t?=
 =?us-ascii?Q?OYHanGcLrE7OawtWZ0Z095NZ1VNOIFKtpxe7fWD9vsLmgpvpzkZ6poxA0W0H?=
 =?us-ascii?Q?FDzwWGwb4EIcq022ToL5T/YykAEnAgk51fgLM3q2qcXD7n/w4GR0foOM588U?=
 =?us-ascii?Q?j3kvsyFjeFsAKP9uwkPIh+rjdamxL3CQESH6o3KlEJcbipjPuNSFmzuEuUim?=
 =?us-ascii?Q?yDt0RizhjGAnolXzpz4zQ9GaLUBvJiLSgKIiOSaxGFIF4sYRvDzehU/FcGRN?=
 =?us-ascii?Q?dp+c+UNwNAc+1KwKdMtTnfQMGnPdpwpRd3fFHRA2AEotC7ddQ4knyn+9N1rk?=
 =?us-ascii?Q?yLkM1hNTy6KU+MLjrOW8ZrZWMn7nbpTABdYjJA50yHMjB8kyHE6U+i1mqOx/?=
 =?us-ascii?Q?NeS780FY7v0IkaQlee/YZG1WMahWdB1MDEquHAcSW+TFBs2ghu/gNrG+BtJM?=
 =?us-ascii?Q?qCI5WFrpgFkcRIOSnV22Yysz+CjaaBN7CbGNc1ls9qo4ESs/mHCOl6BgyhmT?=
 =?us-ascii?Q?8N1/q89YaH3WXb+s8Fij73sk8e4n1yglqk9LtNcNfuL++Vs6XnoqiLnQ55g5?=
 =?us-ascii?Q?eAmbCy0yqC0e08H01d0xub9g1S0hmzHiXyc/lIq6aBrh41Sjx7ZjyMO6ClpB?=
 =?us-ascii?Q?BBa/ZoxCVQAEbplZlv39nHbrD0lKmpOReGSQzoPFe0OmoU+miwiVwjiIvAca?=
 =?us-ascii?Q?Nkzr5lCoJAwItt3qq63TZga5CXDJtrD/A0OnE+bGqi4837QvYIsF6tuLkQh3?=
 =?us-ascii?Q?gdMfHU4NX+H0ZJuo+bcIjRJ4QSOUqMD5Rzf9TvpeIo2Pp6HxBHSJG7g+Uxiq?=
 =?us-ascii?Q?T6qui8BiuG5gEHJFNKJP6N7C?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b9ddc10-0ee4-4fcd-b60d-08d8dfff703f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3835.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2021 17:52:26.8431 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fe1F5bgGouGdhohVXAcoRrlpHZkbTq7vKBlpi8DF9GjAiMEEIpVo/Ccbdxs1aqP4D7vmPWc0+48wgoW8bGlhcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1754
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
Cc: shaoyunl <shaoyun.liu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The MQD might not be initialized duirng first init period if the device need to be reset
druing probe. Driver need to proper init them in gpu recovery period

Signed-off-by: shaoyunl <shaoyun.liu@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Change-Id: Iad58a050939af2afa46d1c74a90866c47ba9efd2
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 300a07227597..7ee4bbb1d325 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -3707,11 +3707,18 @@ static int gfx_v9_0_kiq_init_queue(struct amdgpu_ring *ring)
 	struct amdgpu_device *adev = ring->adev;
 	struct v9_mqd *mqd = ring->mqd_ptr;
 	int mqd_idx = AMDGPU_MAX_COMPUTE_RINGS;
+	struct v9_mqd *tmp_mqd;
 
 	gfx_v9_0_kiq_setting(ring);
 
-	if (amdgpu_in_reset(adev)) { /* for GPU_RESET case */
-		/* reset MQD to a clean status */
+	/* GPU could be in bad state during probe, driver trigger the reset
+	 * after load the SMU, in this case , the mqd is not be initialized.
+	 * driver need to re-init the mqd.
+	 * check mqd->cp_hqd_pq_control since this value should not be 0
+	 */
+	tmp_mqd = (struct v9_mqd *)adev->gfx.mec.mqd_backup[mqd_idx];
+	if (amdgpu_in_reset(adev) && tmp_mqd->cp_hqd_pq_control){
+		/* for GPU_RESET case , reset MQD to a clean status */
 		if (adev->gfx.mec.mqd_backup[mqd_idx])
 			memcpy(mqd, adev->gfx.mec.mqd_backup[mqd_idx], sizeof(struct v9_mqd_allocation));
 
@@ -3747,8 +3754,15 @@ static int gfx_v9_0_kcq_init_queue(struct amdgpu_ring *ring)
 	struct amdgpu_device *adev = ring->adev;
 	struct v9_mqd *mqd = ring->mqd_ptr;
 	int mqd_idx = ring - &adev->gfx.compute_ring[0];
+	struct v9_mqd *tmp_mqd;
 
-	if (!amdgpu_in_reset(adev) && !adev->in_suspend) {
+	/* Same as above kiq init, driver need to re-init the mqd if mqd->cp_hqd_pq_control
+	 * is not be initialized before
+	 */
+	tmp_mqd = (struct v9_mqd *)adev->gfx.mec.mqd_backup[mqd_idx];
+
+	if (!tmp_mqd->cp_hqd_pq_control ||
+	    (!amdgpu_in_reset(adev) && !adev->in_suspend)) {
 		memset((void *)mqd, 0, sizeof(struct v9_mqd_allocation));
 		((struct v9_mqd_allocation *)mqd)->dynamic_cu_mask = 0xFFFFFFFF;
 		((struct v9_mqd_allocation *)mqd)->dynamic_rb_mask = 0xFFFFFFFF;
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
