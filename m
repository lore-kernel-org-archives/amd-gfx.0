Return-Path: <SRS0=mcQQ=MM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFEF4C636C8
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Jul 2021 15:44:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7903961029
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Jul 2021 15:44:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7903961029
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 20A6389AAE;
	Tue, 20 Jul 2021 15:44:07 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2056.outbound.protection.outlook.com [40.107.93.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4826089AAE
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Jul 2021 15:44:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ofPDTNOrty76o+hJH221Edlzlr2Jv5pCZCpXsdjbZ3NYPUs37mwGASUe3muaL785Ish2huXZphHvUm+YpM2zvo7HCizG0yDsN5ZK3FxiI3LqTmEPkkIWbg6NID27VX1o3PvGSdPNo/t7/SZif6OxaGQIdXmiM5R+HfM+KCCK9MkTza7ldxfGzknb9Z77WEiCX8f9uUQ245T1cvxx+D2KmE7oR8JuKaCXGhaEWij886lkEhGVmCRtMOK8pXPEchHt3auirgFcokXAxImp+MmlN7Es6wB2DpJ71K0Xut+b8ipdW6vsGZ+uEC2O4fBGlOyNsFj2JkLH3FEZG7+duaZ5AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FrGqU9fL6a0+54zwRLN3F+V2tFLW+IIoUHpNpUlvkPY=;
 b=M2IicoKZRHZcS97twq4CnNhqkjx4HmJ7UHl676LGcRwFgX2EY13anXoBE/SKjwYyhpKsSaxv6FeMacqyMVKUEM+q3YSMDt0XiOrWuoouSWj9MtDKp8QeLlKPEssuKpPivbnELKpC7lBwWUVkrAT6qWpldh/z8ZUBCEfW1LyNj2MsB1LRh7DF0UHtfpHJqSTF9ZazyXDPGqNhJpeJ5Hdd/ppyxP5rM9W6H/jNDQ14xBeOw1TYlj68leuF9j5pxf+mbhb6FDlPYvstI4ZKLX1p80TMcxt6tZq/LzwbebCOaVqqxdkl+YBdhtzcrXE5+jTnE4tPS4BBrezcexDAcTfdAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FrGqU9fL6a0+54zwRLN3F+V2tFLW+IIoUHpNpUlvkPY=;
 b=V6KnQeqD2cziU5q7O1S4yhQ0E4JctbWiXUQ5JacBwg7mnIXfhm/f+1GLdAysFPMhTCGXVk++SxgtSPL1z04HxKQZWW3lDwHGNaSYgCGaQel1AHs8s50t9nYyYJqSYHLUxzlDNNAuUvKZBckmvbfzyzMj8gCcr3DifBOBZFHd0Ho=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by BL1PR12MB5046.namprd12.prod.outlook.com (2603:10b6:208:313::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.24; Tue, 20 Jul
 2021 15:44:04 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::8cb6:59d6:24d0:4dc3]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::8cb6:59d6:24d0:4dc3%9]) with mapi id 15.20.4331.034; Tue, 20 Jul 2021
 15:44:04 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 01/29] drm/amdgpu: increase size for sdma fw name string
Date: Tue, 20 Jul 2021 11:43:21 -0400
Message-Id: <20210720154349.1599827-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210720154349.1599827-1-alexander.deucher@amd.com>
References: <20210720154349.1599827-1-alexander.deucher@amd.com>
X-ClientProxiedBy: MN2PR01CA0024.prod.exchangelabs.com (2603:10b6:208:10c::37)
 To BL1PR12MB5144.namprd12.prod.outlook.com
 (2603:10b6:208:316::6)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from tr4.amd.com (165.204.84.11) by
 MN2PR01CA0024.prod.exchangelabs.com (2603:10b6:208:10c::37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4331.22 via Frontend Transport; Tue, 20 Jul 2021 15:44:03 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0be93a4c-504e-4ec5-f691-08d94b9533a2
X-MS-TrafficTypeDiagnostic: BL1PR12MB5046:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL1PR12MB50465661A3667080FFF7B27BF7E29@BL1PR12MB5046.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:243;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0zW2Rc1xDv0x1myvf2M2KakiyHWbjZg3Hg8c1qMSO+yBlZD5Zr3c5g/ul+dfGYnipDcyhMiaLir6iBILtg2iAhtgkqiL8xmwC1poYbWcY0hUit7DDktkkkXqSFIMESNzWRcK45jhkdj5NwEcOK+xXtHa4IvzYnYMQcPriS0glFYuDozKTQceEGm9KOXvpPYfdFLHa9B4bAZdMe7WZKDgaMu5ksj7DdW/L+45t/6WLDh1f//akBvmxE3uz4+bOa82/ztllxrjKIYzLWtD2JWsXg/5/nMerZrNGbc0+r6zzBKhzXMpBnBlK4QCIHKWBXKSrrcFJhyouNljnpZffD+B7iX1mUfQitWAe/zfQj/j7prcPAIIbxWLX9AnaxPRLK6bd9mPvMIgSZGbtDALTjy91uGPmFVTT50RwziULwAHD1HyL25FjEkoJ+RQPlEwJqOpcNKBQhcA8GBgRu6ujlYU4f5QQGiGYvL1YNDQF8IdUx9A2d1zGU/v6e/L4wEz908VTESlpXSRupesClgqIfqjRdGlt0Cizsy97DsULIqm80AHqkEV6sOz9fsHv0btcNGhDCS+zo6lHR/moDd2A6BuHhO5BSFrm7KvX7NfSSv5Lesp7ik85xxuVQXyF1DYS1CRAICqVrFzn2onRjPuafHSQL4DY+w5tEO1t4IljMzlgGB1+KqH4dRUhz9LjhUE8BxarY+22Qya1Dx9KOe0pUZlOoglsewzA1yk/IiXHTuH8Qc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(376002)(396003)(366004)(346002)(39860400002)(38350700002)(4326008)(478600001)(1076003)(316002)(956004)(86362001)(5660300002)(2616005)(6666004)(6486002)(38100700002)(4744005)(54906003)(36756003)(26005)(8936002)(6916009)(66946007)(66556008)(186003)(66476007)(52116002)(83380400001)(8676002)(2906002)(7696005)(106533001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Polm0Of6gbo3Wrrax1QHqHLR9gvWSftW1c36mzqmLyzS0lrQaAyvGAyjET/J?=
 =?us-ascii?Q?LITN1q16TyCL2qDcQSTwG6tAH8l1dKWjGDQl2fMik9QisrlQAj2SS41etfFw?=
 =?us-ascii?Q?0yOJaOSxq/Lr8GicbIooY4sc5w9b0BJKXDIzDzQSDn8OO9qSt+nZl6u6xJ0z?=
 =?us-ascii?Q?QD3Hxw5xso/9kGky28np6JOkXcMh+ykqRpcsC/VAlxYrqyz/2jREL3pzenKD?=
 =?us-ascii?Q?YCDyBCxGqms6S0Y16uSG/isWiYggci4E0ENRo76AGePgmA6Ez5O4DBiWEgzn?=
 =?us-ascii?Q?o1V4BRAX/lyjdBaDiuO7L2upa8V2qYpdGaA+zFsQCshszIWm5ily7i18pdh9?=
 =?us-ascii?Q?nHu3ipEIr8OB0qlslEG70oaEoYFm7bOG2c0C0vVYNE+4XUe7gIYOCOOkVKfe?=
 =?us-ascii?Q?R8+l08klKbbpxCoDOzPDij2+DePVpYfwNDW+1TQigGqso2lL0hviT/ebk0q7?=
 =?us-ascii?Q?2aRXwGSkzwRz1TwgOeId/5yjVC5TfVZ5ZBg9xr7lJ3Gl4hVdqlt1+EzNr6Z8?=
 =?us-ascii?Q?N7XqnREcv78AjR6KhZ/dkVGWry9ZpTFUPRGJxKxLIH9bYCXTICc4EUk+nMAQ?=
 =?us-ascii?Q?Iw6vws3LEK4AXFBpmsf4KgRWMe7r+qAPKdBEWNyoIfPTw2iDL6HyxDfNhmgH?=
 =?us-ascii?Q?vGPA52XnokiASUrtKr05Ffm076OX5Xz+UqGYtROgh6xIcHMzvFUGqu/fXpxR?=
 =?us-ascii?Q?X1rlgVRqCR4y+wDahW4ayNOWB0Lx2klsy7B69CPap3zu/ydzwEAbjacYuIwo?=
 =?us-ascii?Q?S9uZNkkPpSFeyZreH7VjnKAoJZ5LkKzwFidl283Rl6h/i1rwGonad1xA8xPb?=
 =?us-ascii?Q?kNmfPK7LYkMnlWfrR5453qTA6q6euLHbyc7gsDIiWVScZuhwFXH3wiinrcyW?=
 =?us-ascii?Q?C1Mh+69/+6SpnLEGACFW6zwDNwpPs8p0AhO2rQXtRs8HKbwTwrFQIyAlxULf?=
 =?us-ascii?Q?KGakKPqM837MKwLV49q0aOl4shJWOCunkV1HIGsw1w48qson7yZQpq2jXD83?=
 =?us-ascii?Q?v1IQ4TAl/w0aWYe2HVxorR3NkBE/Ko/kWuPaOAzTMtncGMFWhrAf3farpalz?=
 =?us-ascii?Q?e8H8N3Et5CvKA3zwLt5xP2XAhgVRXlg/2WKXIIu/u5pqGBherx8CIrsYy1GQ?=
 =?us-ascii?Q?RjoQtrMueHoaSSrwDIvXhlan2WqK/wspcCYAte7PX3T5IF0T9R51Xiqi9Tke?=
 =?us-ascii?Q?e1BfEpw5eE5iJjmL4C39b64dQTu7mWokUeU2tSfbaj8DrgL1fFTajtnymZki?=
 =?us-ascii?Q?WqnA8LSS+EIk9PRL9kfOMtkA26Xlut+Z1ENrLeCWPJvOHNuAXgeVkjLnhba7?=
 =?us-ascii?Q?Qq7SQBP7m4qRGh7e6MQ2G4oh?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0be93a4c-504e-4ec5-f691-08d94b9533a2
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2021 15:44:04.1061 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oYn6ZuqdDZYZdC2g+E9QfIg6oTVyTLCOiVIuPWY+G7dolgXqDXfqMTQUp856MeL5BCd/UlwIAaYHqAar2zfbqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5046
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Tao Zhou <tao.zhou1@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Tao Zhou <tao.zhou1@amd.com>

Longer firmware name needs more space.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
index 6117ba8a4c3f..67f354475d6d 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
@@ -200,7 +200,7 @@ static void sdma_v5_0_init_golden_registers(struct amdgpu_device *adev)
 static int sdma_v5_0_init_microcode(struct amdgpu_device *adev)
 {
 	const char *chip_name;
-	char fw_name[30];
+	char fw_name[40];
 	int err = 0, i;
 	struct amdgpu_firmware_info *info = NULL;
 	const struct common_firmware_header *header = NULL;
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
