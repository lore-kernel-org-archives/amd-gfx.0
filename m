Return-Path: <SRS0=z84W=H2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1705C43381
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:19:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E44D60233
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:19:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E44D60233
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 09B836EB2F;
	Wed, 24 Feb 2021 22:19:50 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2055.outbound.protection.outlook.com [40.107.94.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CBB126EB21
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Feb 2021 22:19:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gi+YhOWpnxEjxQTl3zlEzOrbz301eb150SXs93xG4D9RMP9mvYfY5WTiNl2iVV6/2AIoCmPc6Uh4v7IoCwrB0eXkWmEKndcKR8aVPzFPM73Q2eSzrypcgccFfciRdFYGVKelVXfreOC+R45jTpMpzPbC3it53Hq6eFdXCH0CXWwJ8M4wzFRiVO9ZHzRtDC0FAltZOnf9bWmhOtZhSxN0NagM/jNyphaQ/aYF2tt86m48eTX6I0L2sYkaiJ98q8NauDIDdQC0IKOG8xf5fy21A1OFqBgLYt8UOXVIf6q8dk1fDtAqXMOSEifvfkP+W0zv5ww1L8pbS/dzvOxr4HV0OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Vvf4T39Ja8+tE3Zl6wXNTJcpAPSf03uWkYWvkFLY2Q=;
 b=MQUD+qIPE0MNHS8oEwqKt+EtAsSlmWKad/tG+vbLc067L5Ql+XeRmNdEqviPF+dLpe0n5sPdt/8Y1pH8wQjzMNmkScso6wo5itR6pp8kE6051Ed2FXJ2k/emBRjwm7N/EKpvVwEPAx+V19YUWr/67AZO6oWXzxo11RBq/P8qdKex4HvW+ju2uix3TvvGhX6BQtEQel5qiwBoAge35mPqot65oB8kfjWsq35Ztf0e80P8Rv+ay+eKfK3EaaX7KL+csEy3Jm8ctwuirQ4jk4yvgNSQg+dIdTQP49xTrAd8HdlOx4hHhKwuYP7JPtkmLUXuWKHq4U41mxm/oVQQtLKP4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Vvf4T39Ja8+tE3Zl6wXNTJcpAPSf03uWkYWvkFLY2Q=;
 b=uejT/YX/BP38zi/lzPFZe0hnaajbwqocIf8ERPKJOmqWub5U5maZYIRtlAjntdvoRusgOsvRNMVAA1uh97cH1pzS1BePMJnDtvCKnq3pe3uhn0Fx1sXpCC1f/BEsWE8q5oF8KR/BKiNErWdSo158hlW48faNI9hF7NHWbjl7Gyw=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4175.namprd12.prod.outlook.com (2603:10b6:208:1d3::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19; Wed, 24 Feb
 2021 22:19:40 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af%7]) with mapi id 15.20.3868.033; Wed, 24 Feb 2021
 22:19:40 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 031/159] drm/amdgpu: fix incorrect EP_STRAP reg offset for
 aldebaran
Date: Wed, 24 Feb 2021 17:16:51 -0500
Message-Id: <20210224221859.3068810-24-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210224221859.3068810-1-alexander.deucher@amd.com>
References: <20210224221859.3068810-1-alexander.deucher@amd.com>
X-Originating-IP: [192.161.79.246]
X-ClientProxiedBy: BLAPR03CA0027.namprd03.prod.outlook.com
 (2603:10b6:208:32b::32) To MN2PR12MB4488.namprd12.prod.outlook.com
 (2603:10b6:208:24e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (192.161.79.246) by
 BLAPR03CA0027.namprd03.prod.outlook.com (2603:10b6:208:32b::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19 via Frontend
 Transport; Wed, 24 Feb 2021 22:19:40 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 6331c225-3084-4e8c-dddd-08d8d9124787
X-MS-TrafficTypeDiagnostic: MN2PR12MB4175:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4175370DD9ECCBEEEA70075DF79F9@MN2PR12MB4175.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1265;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aSdvk/qhjZ4Ocsp3+uSIomriyIS3ALCVcsuXMW+dNxZWSQY3dtoNQQYwWGDw02pNgk+lB3SLwxY1jV33tiI6Wr6JftWxpnz/o/aXkdn2wvbgYp51cXJbJjw18Ifug81TwwN7SX8Xq+NEXmyuDB/8aVN7b81/Cw1uE/HK2ieQLkYIF/pZd4EUY1lv5T4JuUdEqacJC8+9rxWQk3ONizJmlLzu+dma6dXconYrxFKj7dX+ubhqYUa8rsduJdKVYHkkhrvyWvhZotGOZurbEOeKIWMD3HCJrqsIJDfbozWJwDS5hYwy/eg/zlVaObJRMdE/qv/1VurE96Ruumk50+dxt9o2B4RiM0pOLO9Ta5wPkSEVs7XFXf3Z+LBBg8rGxufIQwzAMl+JDrDbxshgQiCJ9QorcCcOyErv9bYYu+KO12ll0t+M6IxxBT//uPA9PneRtxlVIKzGmjWjkuMSJju7MTcPi/Rt99tkEBB7V8SmXv5FYvjlPpZ8WcCFeom4QfN+IMK0tGxrswLn7T2O29j+o7/f7kXNb6/gCdOWTVS32dN0cW7YzFIzD5AUI/j6oc+R++69aqHiK0XMFha+T4QD3g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(136003)(39860400002)(346002)(396003)(376002)(66946007)(5660300002)(4326008)(6512007)(66476007)(6916009)(26005)(36756003)(66556008)(2616005)(186003)(956004)(16526019)(478600001)(8936002)(6506007)(2906002)(69590400012)(86362001)(1076003)(54906003)(6666004)(83380400001)(52116002)(8676002)(6486002)(316002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?vFn3R0f1S7uqapKuJi7QQYz8K/OtFapVFy4nPLUyRiRb1DP6vsQdiNVKUA1Q?=
 =?us-ascii?Q?UsBwMJ3PALf0liuET4KGPfiCwwwQDru+m8nDHDD9YTF3mUF7Zfu/QR0lYBCw?=
 =?us-ascii?Q?jonOl8dh/e1DfZD0JkLaoj0rcXk4oaFTMA9I0PsNdkBrwCNIsKliz1X1AXf/?=
 =?us-ascii?Q?IuLtg3fnSZ3bzhavwoO64XmVvRVlQyuR+6M0Z1rgsOw6L9ry+cllkwBtg3d0?=
 =?us-ascii?Q?s2PyFgljvbWe2tpl/cvHWmrFM1FBTW0JW6VFeyHTSi/R3irzScJivHI/oyhO?=
 =?us-ascii?Q?o+HrgfgSW6A1b61R1aOajKHjnja7ecGRVPbZn2fg44JlOjzvWDxohPgOOg53?=
 =?us-ascii?Q?2c3aKI46MMIV+/poNIdVt/vAigaUy3vy8AK5ubby5Sj7UJqGBm9XlxiZDaKi?=
 =?us-ascii?Q?O2ZB4BaDJNDCNTTPMTuUWdTGpEwAJaayElD4itXjXQJ5M1C8L8kefglmXZ3e?=
 =?us-ascii?Q?QdN66HZOVLjSmSCH0W6+WPaS59XE94wTJWtJ9gItRgSlhfC3Jj2iPddFmqGF?=
 =?us-ascii?Q?oiBaiD3s0M5VOErHwD4MmsxhSib22mDu8jdKHOukz5ZG6mZH1vANz867x/Hu?=
 =?us-ascii?Q?dtSoc8G6FntZss0mPgFqjLPoPLceU9wabKHt8NO4nnVafd8+1k0WQoFQMo73?=
 =?us-ascii?Q?ALKtz6YdmbvvNMSXBiNmkcKDbzFM/YD//uNA+bmV/RUavOY+vcDz2jkgfylZ?=
 =?us-ascii?Q?Q4PAeb5+ZuPy7/r0Ui7MvcrExDlYhMME6fRvSZDMAW2cqyXQiKTLG/8Myma3?=
 =?us-ascii?Q?R3CSb4TYc24D5coXFyMgz0FUyLNMyAQAqyKbHCZhFhj5514HI8Y+inBLnFDD?=
 =?us-ascii?Q?hIiEWtKvwQbpmgbSqW//tXmSJF5lDfESX7Lf7MOVKD2XoqC3NaJ1tHpwejc+?=
 =?us-ascii?Q?RJ/LajoiF0yH5beEVToqpU0OqQRjO/+QAAUTS/tfN/WBAJn98PGWHG3KX8V2?=
 =?us-ascii?Q?tYL51MuGaOVqdpiL+rjepjzp691vkW8ohxfbL0Zv+w8q23Wueq6gUcgwp7ra?=
 =?us-ascii?Q?Kcx0LTU4ojsqZWwwZcBEU4pI+0ZBpauoviezATyrCevh1GOjdw4ZnJ3NvMrt?=
 =?us-ascii?Q?4PbIydrHYBTITuYFZeU5D2VwA4auNNf5wZt2hd5xWs0biG2QBKGmAJFmES9f?=
 =?us-ascii?Q?BPjl1dmKE4oXVDUlp80oeZy2sAbX7duFv94IJsox0LTnNc0pqzuveh/bLWo0?=
 =?us-ascii?Q?grNfUpmfHx2GU5UCBJq+CuqL8gbuu+Mf/lLLJLPisXfh2teFh4p1qAQjw+il?=
 =?us-ascii?Q?yKddM4ZeA8cZcrHsddu0aLwB4ARNJxhCOCalF0c7RE4Z1Tzc++ekSfPw5Qpf?=
 =?us-ascii?Q?q0M+hZcAD/ySExfLzHl4fT3X?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6331c225-3084-4e8c-dddd-08d8d9124787
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2021 22:19:40.7691 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1Db8pv9nWG4/WQBPRT2L/OKspdQHaey5kGKSFyVf+wS/KMq9LK14pzc25W72jVs76uJUTO+Nw5cGsaAs1YdNUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4175
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Le Ma <Le.Ma@amd.com>,
 Kevin Wang <kevin1.wang@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Hawking Zhang <Hawking.Zhang@amd.com>

mmRCC_DEV0_EPF0_STRAP0 offset in aldebaran is changed
from arcturus

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Kevin Wang <kevin1.wang@amd.com>
Reviewed-by: Le Ma <Le.Ma@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c b/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
index 5332fed91cb1..5dbe03d3b0dd 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
@@ -52,6 +52,9 @@
 #define BIF_MMSCH1_DOORBELL_RANGE__OFFSET_MASK          0x00000FFCL
 #define BIF_MMSCH1_DOORBELL_RANGE__SIZE_MASK            0x001F0000L
 
+#define mmRCC_DEV0_EPF0_STRAP0_ALDE			0x0015
+#define mmRCC_DEV0_EPF0_STRAP0_ALDE_BASE_IDX		2
+
 static void nbio_v7_4_query_ras_error_count(struct amdgpu_device *adev,
 					void *ras_error_status);
 
@@ -65,7 +68,12 @@ static void nbio_v7_4_remap_hdp_registers(struct amdgpu_device *adev)
 
 static u32 nbio_v7_4_get_rev_id(struct amdgpu_device *adev)
 {
-	u32 tmp = RREG32_SOC15(NBIO, 0, mmRCC_DEV0_EPF0_STRAP0);
+	u32 tmp;
+
+	if (adev->asic_type == CHIP_ALDEBARAN)
+		tmp = RREG32_SOC15(NBIO, 0, mmRCC_DEV0_EPF0_STRAP0_ALDE);
+	else
+		tmp = RREG32_SOC15(NBIO, 0, mmRCC_DEV0_EPF0_STRAP0);
 
 	tmp &= RCC_DEV0_EPF0_STRAP0__STRAP_ATI_REV_ID_DEV0_F0_MASK;
 	tmp >>= RCC_DEV0_EPF0_STRAP0__STRAP_ATI_REV_ID_DEV0_F0__SHIFT;
-- 
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
