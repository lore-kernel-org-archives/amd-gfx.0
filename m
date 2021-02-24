Return-Path: <SRS0=z84W=H2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E170C433E9
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:22:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C334064F03
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:22:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C334064F03
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 90CD46EB8F;
	Wed, 24 Feb 2021 22:22:00 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770058.outbound.protection.outlook.com [40.107.77.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3446E6EB80
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Feb 2021 22:21:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DaSvgLUN1qGIBhAj2wBhUpW+zUMPqZ4vAMuFA/dTGQ2eo37LC572J0pddsq5AiGzKRU0uD3zWkZmSNDgtqQbJX+MP9wv2u3PY6zG5tKeJ3DRMoYlZAYmT7rLIRZIED3jyKmP5rPU+7+Lhxe1xqotPsph6+7mIn88O2FG3C3RyDSbeRRgEmf4SBF9iT6wni2WA5/jlDqnoG3PT0GoODmau7yYCbZFi3GUZaA4MYZKjXgGhGx04aLc6I9n723I16Urd0cCffY4yF8fyDPrsLHmeV/118b/cEWSVPx1SaVL4YHctfVStGsdW7gWh3DB2bgk2osspA4tAJmWct/zKOu8uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j+2cudVQ22FqRVdTJ78Ze6Ps6XYoyTaENbzJQJBn6iE=;
 b=Mfu4lo5edjergrBOHTcbBsGuVyP98cba04qQj7NwrzTHPzFdvUTZGkg9bNC9gc2zIXEUWG9vcD+zTogvqgIW1D4dUjRkyDJ1zggQbPnOk5fXwjfRGtdjpekgB60J0HKMme0b38nu2g/WJ5NWa9u5KKSjGn4rfQ/iJA/DOzNFyGmaOXa8m0+sUj2P8Z+RUCDGfAEdm53EiTVYuawLzFIxtH9d57eIBwv90ZKfjwSeSo5IsbOOo0Ntw8pgUtctrjN3du6EmJHNS6rRBdzTMg96XllTxM0mitjGTv4ZWGP+IvfATGx7Au/RbHLUcOywHFUN7fPy5JeMTxWBF8Z9YOv48w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j+2cudVQ22FqRVdTJ78Ze6Ps6XYoyTaENbzJQJBn6iE=;
 b=QFE3ef5wziqGuJAdIS1GkxuVqEYyFsdAbqj1IdDn6KkqVKUAFixh2Te3w44aPVVAAz/ULqAVfCKfcqWSUBJyUWkbrpaRGvNZAyb1IKeLocbq/FiXnnILgNlLlvZqYGiHxAraxwHdl7GV+rhT2N7Y5GkDFBT6e59h9mkdQhNrPRo=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB3807.namprd12.prod.outlook.com (2603:10b6:208:16c::30)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.32; Wed, 24 Feb
 2021 22:21:49 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af%7]) with mapi id 15.20.3868.033; Wed, 24 Feb 2021
 22:21:49 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 119/159] drm/amdgpu: enable retry fault wptr overflow
Date: Wed, 24 Feb 2021 17:18:19 -0500
Message-Id: <20210224221859.3068810-112-alexander.deucher@amd.com>
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
 Transport; Wed, 24 Feb 2021 22:20:44 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: f87b4c9b-5c21-4811-9872-08d8d9126dbd
X-MS-TrafficTypeDiagnostic: MN2PR12MB3807:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB380772B6B579F8CBF51D3A8AF79F9@MN2PR12MB3807.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2803;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bOhX/a/moI41NKnh5fCoo4H65XE5VvStMA4hVd0Hz6X1+LuILhq4WqIEZ8KxO81WQujBw5DNpobtnwABJ52Qrg4b6e6J5phTXeXkqLGkAAskFAM+rG952VGIN8hh7Ix/L5RK6jgSJC7HF88pKDK5ATMZlRiSOJEVOYILfIAaLCH9Zu+fNG/HQt83g8OvhsvLs+jXmhPHhYqnCOgc9yEskzD8ztt22st5cOIuEQrJfdd6mv7ipn6Y6C+hHr2DJoq8ZAp2KkT4OA19AErsuwbUZdpD8eTH+0t3gYG2xOTu8GVU1Z7bJdi0Kzr2LKP5QZ6qSGZW5vX0P18sEs2pV7CADVWG/8bXL+JOgS8OOEA3iC1HKL2UFzLrQISz4RMKk/V+yIF9Kh+bLk4YiHsPkC67ghL2ykBt9wKTBsAZLYQl9SmF6DB54h4kcEN1go9J60pA8EAy5ZJEIfyqXw0mVQwMUEfujGBUg9qqN0dmokSgrwmhr0VN5oTbr2Vmu2TcgCtWnFJ/7cHfaLPRch9EbGtbrwQk891sbzoMTO8ZzD2p8RKDd8bc5uKhvgGYEfvkGuh1nvRnXLrdRe2CBPWgsLp80twB1BoOqmojRjepL2vSNIk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(39860400002)(136003)(366004)(346002)(396003)(54906003)(478600001)(4326008)(86362001)(83380400001)(16526019)(2616005)(186003)(36756003)(66476007)(1076003)(6506007)(6666004)(66946007)(69590400012)(6916009)(8936002)(6486002)(6512007)(52116002)(5660300002)(956004)(316002)(2906002)(26005)(66556008)(8676002)(309714004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?ahAfILMniXMFHwKBeKVWBzZFTyg4vcSMXXnbVyhvicuQ32vmFJS1kmWd/dAh?=
 =?us-ascii?Q?Vr++PP4N/RLKbce+R6EyfnSdARtZGipmGskZGy435wbkyzSy4onBVfXTCNFO?=
 =?us-ascii?Q?i76MqIUP+B5Pc6lMC4TDxNPQULq4McO8ldBoJhhGJj4SY7q38JDw/iORumsd?=
 =?us-ascii?Q?2pPJbxfV/dwuPj8kAut/z5eQLQAIwYcaFd1sYbxVEIkSPsLCiY2Yww3hTscr?=
 =?us-ascii?Q?5+oVOcP/jiikGfXNvQrrpTW+Q+y6il2srY6TjPTahFF1ZwTo9ceBfEusuNIP?=
 =?us-ascii?Q?pK5Svly2w5gfIP431oQcR2YRoS8Lb3Vkc4F54hPiaIgUYkSxaTnDnp/wRjzq?=
 =?us-ascii?Q?JRMz3ZNAGG04Wk6tJHDb21GS8YICgfPoz+s5oQxzgquIbGo9PsiUwByr+bH0?=
 =?us-ascii?Q?B9pbpin6mXRr5WYXu8sg+XSprMSqXTGXibidvffNKFVesqQHHwnu58LWv1fK?=
 =?us-ascii?Q?sUNT54Y217+JmI3/NRa8szJwc10o+BNGMhtseyocg9M+dGEO4cx0Nh6Zan0m?=
 =?us-ascii?Q?cblhV+d/W+yCjLtKzpuiQLkMtheEhntJ8Uo5l09hskm7PWRhZ3P8XM/Xhr52?=
 =?us-ascii?Q?wjUI1vIwbbG/pr5q2k9iDV/1C9RncdznsJl3McfKlZQ2t5Urjr/1X8KmjXfo?=
 =?us-ascii?Q?orRqOWhJsc34dTEOkQhNN7RD4Rz/U+ILUi/p/PEyjYMul6XDnYMWYnvhua0V?=
 =?us-ascii?Q?yqcmB2UVPNgMwIxtA/a6y1Dmm61REymJyqzocvNc8xutSMsYdEF4pBVC7R5E?=
 =?us-ascii?Q?c2ic1DrjWoaUloCkPNOWvoon2VaG65HlyupJ9a1KEsbxH9q02WQYqV43NTqy?=
 =?us-ascii?Q?A5LA791SEAE9SXpgwvpw4YkgcOSs3p0dPEcdreJUdlNpQCeXDtk8TYVOFddW?=
 =?us-ascii?Q?GgGgEUBOTHW1u1ny48UZGV+w5H0pvunk7Q4FvFcf9i3uL5BJLTLZt+zIaeU5?=
 =?us-ascii?Q?LIqLxhF24G+6VyH8OhDSmwzFcBA3lidHf/bm/LWnkCGkK86gRW++agU4lJ4W?=
 =?us-ascii?Q?oiEIUHX+rBf9f+zHg9unDAX6VQDsFWCNlU18vcRn2L6uptRYgxKPlLvQQcGN?=
 =?us-ascii?Q?lMX7kdCRKTzhLAVcCvXnJ3Vz/AmtHVJBHmcjTyrj/pfQ82bZQPZep0ambTaf?=
 =?us-ascii?Q?WGF5jpqEXd+T0wvhPdYh9X6hqBYrJJPwDOcXsCeAqqsV5PNAViduHHr97iPn?=
 =?us-ascii?Q?HSXmy3oePFg5pqg8cKZtJQ/HuGuoSUyOaDqMYml56lnzSnAYyBM/lMDXI979?=
 =?us-ascii?Q?xHDMOR8riND/HCG3ww9WcmowS449o+YVonFlUTrv0XOQpXuoxx1ZqF6Eylv/?=
 =?us-ascii?Q?DOh2eYxoqGN7K46xmo3FCnPs?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f87b4c9b-5c21-4811-9872-08d8d9126dbd
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2021 22:20:44.8637 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: quspnMVk0QK8ZG+UQu1MOew8b0iy+QWczt8i3qYUBiF0anS9RXnf2rR36+ZfVejM4GOIScEpn5Kn558DtE1eLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3807
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Philip Yang <Philip.Yang@amd.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Philip Yang <Philip.Yang@amd.com>

If xnack is on, VM retry fault interrupt send to IH ring1, and ring1
will be full quickly. IH cannot receive other interrupts, this causes
deadlock if migrating buffer using sdma and waiting for sdma done while
handling retry fault.

Remove VMC from IH storm client, enable ring1 write pointer overflow,
then IH will drop retry fault interrupts and be able to receive other
interrupts while driver is handling retry fault.

IH ring1 write pointer doesn't writeback to memory by IH, and ring1
write pointer recorded by self-irq is not updated, so always read
the latest ring1 write pointer from register.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vega10_ih.c | 32 +++++++++-----------------
 drivers/gpu/drm/amd/amdgpu/vega20_ih.c | 32 +++++++++-----------------
 2 files changed, 22 insertions(+), 42 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vega10_ih.c b/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
index 88626d83e07b..ca8efa5c6978 100644
--- a/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
@@ -220,10 +220,8 @@ static int vega10_ih_enable_ring(struct amdgpu_device *adev,
 	tmp = vega10_ih_rb_cntl(ih, tmp);
 	if (ih == &adev->irq.ih)
 		tmp = REG_SET_FIELD(tmp, IH_RB_CNTL, RPTR_REARM, !!adev->irq.msi_enabled);
-	if (ih == &adev->irq.ih1) {
-		tmp = REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_ENABLE, 0);
+	if (ih == &adev->irq.ih1)
 		tmp = REG_SET_FIELD(tmp, IH_RB_CNTL, RB_FULL_DRAIN_ENABLE, 1);
-	}
 	if (amdgpu_sriov_vf(adev)) {
 		if (psp_reg_program(&adev->psp, ih_regs->psp_reg_id, tmp)) {
 			dev_err(adev->dev, "PSP program IH_RB_CNTL failed!\n");
@@ -265,7 +263,6 @@ static int vega10_ih_irq_init(struct amdgpu_device *adev)
 	u32 ih_chicken;
 	int ret;
 	int i;
-	u32 tmp;
 
 	/* disable irqs */
 	ret = vega10_ih_toggle_interrupts(adev, false);
@@ -291,15 +288,6 @@ static int vega10_ih_irq_init(struct amdgpu_device *adev)
 		}
 	}
 
-	tmp = RREG32_SOC15(OSSSYS, 0, mmIH_STORM_CLIENT_LIST_CNTL);
-	tmp = REG_SET_FIELD(tmp, IH_STORM_CLIENT_LIST_CNTL,
-			    CLIENT18_IS_STORM_CLIENT, 1);
-	WREG32_SOC15(OSSSYS, 0, mmIH_STORM_CLIENT_LIST_CNTL, tmp);
-
-	tmp = RREG32_SOC15(OSSSYS, 0, mmIH_INT_FLOOD_CNTL);
-	tmp = REG_SET_FIELD(tmp, IH_INT_FLOOD_CNTL, FLOOD_CNTL_ENABLE, 1);
-	WREG32_SOC15(OSSSYS, 0, mmIH_INT_FLOOD_CNTL, tmp);
-
 	pci_set_master(adev->pdev);
 
 	/* enable interrupts */
@@ -345,11 +333,17 @@ static u32 vega10_ih_get_wptr(struct amdgpu_device *adev,
 	u32 wptr, tmp;
 	struct amdgpu_ih_regs *ih_regs;
 
-	wptr = le32_to_cpu(*ih->wptr_cpu);
-	ih_regs = &ih->ih_regs;
+	if (ih == &adev->irq.ih) {
+		/* Only ring0 supports writeback. On other rings fall back
+		 * to register-based code with overflow checking below.
+		 */
+		wptr = le32_to_cpu(*ih->wptr_cpu);
 
-	if (!REG_GET_FIELD(wptr, IH_RB_WPTR, RB_OVERFLOW))
-		goto out;
+		if (!REG_GET_FIELD(wptr, IH_RB_WPTR, RB_OVERFLOW))
+			goto out;
+	}
+
+	ih_regs = &ih->ih_regs;
 
 	/* Double check that the overflow wasn't already cleared. */
 	wptr = RREG32_NO_KIQ(ih_regs->ih_rb_wptr);
@@ -440,15 +434,11 @@ static int vega10_ih_self_irq(struct amdgpu_device *adev,
 			      struct amdgpu_irq_src *source,
 			      struct amdgpu_iv_entry *entry)
 {
-	uint32_t wptr = cpu_to_le32(entry->src_data[0]);
-
 	switch (entry->ring_id) {
 	case 1:
-		*adev->irq.ih1.wptr_cpu = wptr;
 		schedule_work(&adev->irq.ih1_work);
 		break;
 	case 2:
-		*adev->irq.ih2.wptr_cpu = wptr;
 		schedule_work(&adev->irq.ih2_work);
 		break;
 	default: break;
diff --git a/drivers/gpu/drm/amd/amdgpu/vega20_ih.c b/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
index 0049f048a305..101416c646c7 100644
--- a/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
@@ -223,10 +223,8 @@ static int vega20_ih_enable_ring(struct amdgpu_device *adev,
 	tmp = vega20_ih_rb_cntl(ih, tmp);
 	if (ih == &adev->irq.ih)
 		tmp = REG_SET_FIELD(tmp, IH_RB_CNTL, RPTR_REARM, !!adev->irq.msi_enabled);
-	if (ih == &adev->irq.ih1) {
-		tmp = REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_ENABLE, 0);
+	if (ih == &adev->irq.ih1)
 		tmp = REG_SET_FIELD(tmp, IH_RB_CNTL, RB_FULL_DRAIN_ENABLE, 1);
-	}
 	if (amdgpu_sriov_vf(adev)) {
 		if (psp_reg_program(&adev->psp, ih_regs->psp_reg_id, tmp)) {
 			dev_err(adev->dev, "PSP program IH_RB_CNTL failed!\n");
@@ -300,7 +298,6 @@ static int vega20_ih_irq_init(struct amdgpu_device *adev)
 	u32 ih_chicken;
 	int ret;
 	int i;
-	u32 tmp;
 
 	/* disable irqs */
 	ret = vega20_ih_toggle_interrupts(adev, false);
@@ -341,15 +338,6 @@ static int vega20_ih_irq_init(struct amdgpu_device *adev)
 		}
 	}
 
-	tmp = RREG32_SOC15(OSSSYS, 0, mmIH_STORM_CLIENT_LIST_CNTL);
-	tmp = REG_SET_FIELD(tmp, IH_STORM_CLIENT_LIST_CNTL,
-			    CLIENT18_IS_STORM_CLIENT, 1);
-	WREG32_SOC15(OSSSYS, 0, mmIH_STORM_CLIENT_LIST_CNTL, tmp);
-
-	tmp = RREG32_SOC15(OSSSYS, 0, mmIH_INT_FLOOD_CNTL);
-	tmp = REG_SET_FIELD(tmp, IH_INT_FLOOD_CNTL, FLOOD_CNTL_ENABLE, 1);
-	WREG32_SOC15(OSSSYS, 0, mmIH_INT_FLOOD_CNTL, tmp);
-
 	pci_set_master(adev->pdev);
 
 	/* enable interrupts */
@@ -395,11 +383,17 @@ static u32 vega20_ih_get_wptr(struct amdgpu_device *adev,
 	u32 wptr, tmp;
 	struct amdgpu_ih_regs *ih_regs;
 
-	wptr = le32_to_cpu(*ih->wptr_cpu);
-	ih_regs = &ih->ih_regs;
+	if (ih == &adev->irq.ih) {
+		/* Only ring0 supports writeback. On other rings fall back
+		 * to register-based code with overflow checking below.
+		 */
+		wptr = le32_to_cpu(*ih->wptr_cpu);
 
-	if (!REG_GET_FIELD(wptr, IH_RB_WPTR, RB_OVERFLOW))
-		goto out;
+		if (!REG_GET_FIELD(wptr, IH_RB_WPTR, RB_OVERFLOW))
+			goto out;
+	}
+
+	ih_regs = &ih->ih_regs;
 
 	/* Double check that the overflow wasn't already cleared. */
 	wptr = RREG32_NO_KIQ(ih_regs->ih_rb_wptr);
@@ -491,15 +485,11 @@ static int vega20_ih_self_irq(struct amdgpu_device *adev,
 			      struct amdgpu_irq_src *source,
 			      struct amdgpu_iv_entry *entry)
 {
-	uint32_t wptr = cpu_to_le32(entry->src_data[0]);
-
 	switch (entry->ring_id) {
 	case 1:
-		*adev->irq.ih1.wptr_cpu = wptr;
 		schedule_work(&adev->irq.ih1_work);
 		break;
 	case 2:
-		*adev->irq.ih2.wptr_cpu = wptr;
 		schedule_work(&adev->irq.ih2_work);
 		break;
 	default: break;
-- 
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
