Return-Path: <SRS0=1d99=JN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5517EC433B4
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Apr 2021 21:38:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F170B610CC
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Apr 2021 21:38:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F170B610CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 894BD6E037;
	Fri, 16 Apr 2021 21:38:58 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2058.outbound.protection.outlook.com [40.107.93.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D43886E037
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Apr 2021 21:38:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mxgq66THpybqvrtEIici4FNJfNaPNolBC8xKRQDkdCAPHt7QpwENygupEUqi9KcWhO1I08kx6Lv/JlcfpQxIkskilse1XuQvfkZ9xGNp7iJe4uWRBjPLtfAEEstXzgEk7IyQEtpERKfdig7RaOoG50Cp23l6diVrQGEmbaerOJnJkJfJfw5lenUztyv4Z8kkprktolSvyQoleX9qZdDo8UzeaKIOAV3iO7bTjwPqsaHyRXm2x4RHV0cd5OzmPYS7TIYx6TOy/ecjXipWvWnHiO7kE1y6Hx+nXNJT2XLZFKECTnDrAt3xKShLKCsNWM7otx9uqOYQQR+nQ1s/QPs9GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vbf4xgRVihylf8iChML+CcASgFE3x3XSCQiC9sofmTA=;
 b=OG4caHkKkibo9CGXGE3O1VWTHl3TOPpYAIoEZXkO/o4EHtvD7YnVgnp4FD7Iy4Br2HDs5UVzkI2LhBFFUYMsoFe3+gr1KPf1554fhbire9Ohck7KgidjQiV8b3dYSbiHYbsGuDMXoeXE0PIS9apI+NnHpo3oAhiYOJHuArRZGbaUSEgGPyC6ezLcbDF6D4ACGQKS9rDdtYAqxOV8g3LuSTx3gRpjN9ZLMVWjvPmgLQmiSy7QPcxzf5U0LKjz1ZnxGkY+Qra2VSz/qzd0qCWY5oeCpno+3rl+pFqmbD3Ohp1rNB3mZvGHufmfaK4Whnlbt2Hzu/ZzybXoL45pnmtFIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vbf4xgRVihylf8iChML+CcASgFE3x3XSCQiC9sofmTA=;
 b=msTmda47cg0xWy+uDdXz0zHtZQaqF+auK1P9wVLLU4r2IrZLeMxbDsD9LNRbJbqmyPtNFfMk6LafZmppwn7u1mIB+iaol2I6HQvWJlhz69NSS0x1bUKKhT0v69XKsl5df4BnZCiII6kuYpANquAbTgy7GUrm5rxGbYk/O7+UK0k=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by BL0PR12MB4611.namprd12.prod.outlook.com (2603:10b6:208:8e::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16; Fri, 16 Apr
 2021 21:38:53 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::3d98:cefb:476c:c36e]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::3d98:cefb:476c:c36e%8]) with mapi id 15.20.4042.019; Fri, 16 Apr 2021
 21:38:53 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu/gmc9: remove dummy read workaround for newer chips
Date: Fri, 16 Apr 2021 17:38:30 -0400
Message-Id: <20210416213830.1575820-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.30.2
X-Originating-IP: [192.161.79.245]
X-ClientProxiedBy: BL1PR13CA0335.namprd13.prod.outlook.com
 (2603:10b6:208:2c6::10) To MN2PR12MB4488.namprd12.prod.outlook.com
 (2603:10b6:208:24e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (192.161.79.245) by
 BL1PR13CA0335.namprd13.prod.outlook.com (2603:10b6:208:2c6::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.7 via Frontend
 Transport; Fri, 16 Apr 2021 21:38:52 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8d721101-a9cd-4dbd-2f4d-08d901200790
X-MS-TrafficTypeDiagnostic: BL0PR12MB4611:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB461119504DFCB13030413E41F74C9@BL0PR12MB4611.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2331;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3M3cJSIBrqvnF4KCaLQofa03IXSbbGQYiiVXz73QhjY3/byHgucF7+w6rukzkaKDCGAP/AZ9PHY1wovo3fFGkPeLe9ES9Dk+tDBRYJHlqp2F98eWXZn4c8WSR0+ue4bskF7iy267Yl8uIWZnbcxAPUxyXSByCAx+TZC0gBhhgOT2FNXg9fY1KO147jTLQabNdd4y8YPtEO2xfevWr1TNYrqsy1soFAM4T4Cpdo5nTQ43XoYKRFWuDKXolf9TTai5aUVF1iFlEPhyDqSjwebtHPNyiUWP2jsUSuqXE8H8ut3hKv2yFhdbCJPtZBYlfzE5erFaip4fxiweuEh39fAoQmGUb3iYJg8fZYPq4UfHWzKtqPey4wyPa6aru8GCwU1USZ+Lx/4HhPjoUm93w+wMoYdKann6KApa4mUhRuQIMERZ+dFaUrMbxYFJrIkqYk5GHE3H/lspp5RysYZyMMCBH2unUj7IfB+FPcb1r/kSd/ZiDve9LvE+vjYttVG64INxceC2LjFjioP8bHm71kAbHvGtlrp266sFZ9C5A8Vf13OFxKxvZeTYXox5hIPQkiSwsIQ4dngSXT29zjw5BYCEL6YLMzYJ6wKsNWXR+jGu1kjI9U6cNe3KhZrgoa642eCDzc1L9pVyS87KLhwPL6I2XMmRfTlQtLyqd3KIq/HkKJufgs7t8lOi+nfOYdUMUUVu
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(39860400002)(346002)(376002)(366004)(396003)(66946007)(16526019)(8936002)(66556008)(83380400001)(38350700002)(186003)(6916009)(316002)(8676002)(1076003)(66476007)(69590400012)(38100700002)(6506007)(4326008)(36756003)(6512007)(478600001)(6486002)(2906002)(956004)(2616005)(5660300002)(26005)(86362001)(52116002)(6666004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?rTPFo/db/uC/gQJOTFoZm892BI25vbLcplmRuYjQuRctJvTM7Hw/3tx4VtY0?=
 =?us-ascii?Q?DG5mfRCV0kCMq+L5EywltLbk/HHVjVEK/eZo91zed4dYaJWekxWTGzhkmLNA?=
 =?us-ascii?Q?Yp3uxNrEFgUQlyvnYSA0njK8aiwcrbPc2h5DYN9RPSMALuX3RzGQHsuWzzd8?=
 =?us-ascii?Q?gjhJKxV3VQC3HWaH2iUcdqh1S/gi/o0rxrzNJTppC4qljgZjzNxZ3uIzR3Cm?=
 =?us-ascii?Q?93+fK1fRzaoA2WFQIraJlyBovq1ptNhyrKTrNMYwF5ldmkfTa8+nTiEbXSo9?=
 =?us-ascii?Q?aIxLO8Bi5z9cQe/2Dd6f24zZU02+cowz/8U7pmGgYjemcEDz+rCZ/FA05IfZ?=
 =?us-ascii?Q?KXhIboDw9F7RNSdQv+9r2ICt6P/imG3YLxuCe/V1IDgZfB9qx4baRyhF2hGb?=
 =?us-ascii?Q?IxDmNafvoxbtxlZh1bscxXK2H/Px4iGeg2KPOREbvkHRmTns0/t0g2ETytqQ?=
 =?us-ascii?Q?OHfXLJ+k1+hc9c99BSuBydSXr1VuNeXEPB0Wsnf1aWb2X15Ex0ISOFZ1OiOt?=
 =?us-ascii?Q?cv8K/5yN1OZy4HhsYDwVG4xwI5KTnCaKG9PQJ8mltE532Y9IEcAvCtOMspq3?=
 =?us-ascii?Q?68IcaudrzrjgxgjxXW6zpO8bhXzC1F6cCOAgjWdrGRi//TJAhB7/Ie3+lw4Q?=
 =?us-ascii?Q?UL1mfAKHGl4qwSv/PW65zFoNR3eKDNPTNzIUiHTQceV+lQZym1WW6T+Vn106?=
 =?us-ascii?Q?UEi2cOSYUR/pUdX/yj3p3tNpLRIE7MNGQbO/raUtcKBdIlWHWR+tsKqCBAYZ?=
 =?us-ascii?Q?pJVIt1lY+bxlTiJDLELQVt3rtTCHvEm5w1e0cOVo/99qyVoj4D4wZOyg2GWe?=
 =?us-ascii?Q?OahGoYhbHElGyltfnCxlxZdfopKK/qj+L06XYTVbO7X5BOUobeJg23hZDGTu?=
 =?us-ascii?Q?KMZriPZogQKD/WgFKWmAzaBs5taAy+zfpajM4/rynrD/dAFLO+5WJD4oWBWb?=
 =?us-ascii?Q?FhcdffLdjmc+ZVy2/P6taFzwQ+scvwiFCQPzg6iSbr8XzXJrqC71yE6OSbAP?=
 =?us-ascii?Q?Xp0/PK2G1a+hpOaVYC3NjrWOjz/Her6ckjShv+D+xSfUTMcWu93RASXeC+LR?=
 =?us-ascii?Q?TcEOuvFzWU5ZZ/BEyLfJH5wEGGlgYF0FS/r4jo0ZFM+6Wl4/6jyVAzZTgSF0?=
 =?us-ascii?Q?/Xh66Mm78e/FO0oC14vvnyBeVxmOG+ntOnmKgtzuulRw8smKy6PFjXjFM7KG?=
 =?us-ascii?Q?8/RCSIF1wZR2E6l+DZAPr4m5qXJiANhItx4KsldXBBoiI/V6qj0RjKeNuspH?=
 =?us-ascii?Q?fZrqPgMKI/tzXoUNUdQNkDp8vZ8QT/DMnFxQd8KO60G6GOo74GALP3yN81tY?=
 =?us-ascii?Q?kqMB2vLErxFQZv2FCvCX7gj0?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d721101-a9cd-4dbd-2f4d-08d901200790
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2021 21:38:53.0362 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KTXksF8hZN1x31sHE3NqtX2biZyp3lHKTXNni7WFKDfPY/2DkVYxzksRyGWjtAYZDC7+st8NUpIpZGzPfRBPgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4611
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Aldebaran has a hw fix so no longer requires the workaround.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index f354f670c7ad..455bb91060d0 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -574,7 +574,8 @@ static int gmc_v9_0_process_interrupt(struct amdgpu_device *adev,
 	 * be updated to avoid reading an incorrect value due to
 	 * the new fast GRBM interface.
 	 */
-	if (entry->vmid_src == AMDGPU_GFXHUB_0)
+	if ((entry->vmid_src == AMDGPU_GFXHUB_0) &&
+	    (adev->asic_type < CHIP_ALDEBARAN))
 		RREG32(hub->vm_l2_pro_fault_status);
 
 	status = RREG32(hub->vm_l2_pro_fault_status);
@@ -802,7 +803,8 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 		 * be cleared to avoid a false ACK due to the new fast
 		 * GRBM interface.
 		 */
-		if (vmhub == AMDGPU_GFXHUB_0)
+		if ((vmhub == AMDGPU_GFXHUB_0) &&
+		    (adev->asic_type < CHIP_ALDEBARAN))
 			RREG32_NO_KIQ(hub->vm_inv_eng0_req +
 				      hub->eng_distance * eng);
 
-- 
2.30.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
